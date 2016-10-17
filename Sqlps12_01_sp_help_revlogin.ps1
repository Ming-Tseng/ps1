<#
C:\Users\administrator.CSD\SkyDrive\download\PS1\Sqlps12_01_sp_help_revlogin.ps1
C:\PerfLogs\Sqlps12_01_sp_help_revlogin.ps1

Date: Jul.21.2015
執行個體之間傳送登入和密碼 sp_help_revlogin
author : Ming_Tseng  a0921887912@gmail.com
sp_hexadecimal
sp_help_revlogin
use DDL Trigger
  
  other ref: 

$ps1fS=gi C:\Users\administrator.CSD\SkyDrive\download\PS1\Sqlps12_01_sp_help_revlogin.ps1
foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname=$ps1f.name
    $ps1fFullname=$ps1f.FullName 
    $ps1flastwritetime=$ps1f.LastWriteTime
    $getdagte= get-date -format yyyyMMdd
    $ps1length=$ps1f.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length "  -Body "  ps1source from:me $ps1fname   " 
}

refer:  Sqlps17_trigger  Line: #  300  RAISERROR 透過對 CREATE_TABLE 事件建立觸發程序，記錄建立者的帳號到 Windows Event Log
        Sqlps12_Security.ps1
        OS05_Job.ps1     Get-EventLog -LogName Application 
        OS01_General.ps1   
        https://gallery.technet.microsoft.com/scriptcenter/Fully-TransferMigrate-SQL-25a0cf05
#--
程式安裝順序
0. Node1為主要機, Node2為次要機
1. Node1 執行 $tsql_createSP  line :279
2. Node1 執行 CREATE TRIGGER LoginCreateTrigger ON ALL SERVER  line :296
3. Node1 執行 taskschd.msc (USE UI) 建立 event Trigger Name : LoginCreateTrigger , then  run  Sqlps12_01_sp_help_revlogin 

程式執行順序
0.  當SQL 執行 create login : 會啟動 Windows Event 啟動 Sqlps12_01_sp_help_revlogin.ps1
1.  檢查 最後一筆 SQL Server 事件 而且 EventID  是否為  17061 (大量批次處理.暫不考慮)
2.  由 找出被異動者名稱 $u
3.1  判斷 為 create 或是alter行為 
3.2 if Yes  執行產生SID 的 $revlogine,
3.3 找出 $revlogine 中  的帳號名稱  $loginName1
3.4 取出附有SID的TSQL指令
3.5 逐一檢查是否在Node2 是否有此 $u. 如有則Drop +Create, 
3.6 是否沒有此 $u. 如有則 Create only
4.判斷 為 drop 行為 則 直接在 Node2 上刪除
5.程式結束
#>

function checkprincipals ($Node2, $loginName){
    
$tsql_checkprincipals=@"
 --SELECT name from sys.server_principals where type='S' and name='$loginName'
 SELECT name from sys.server_principals where  name='$loginName'
"@
#$tsql_checkprincipals
Invoke-Sqlcmd -Query $tsql_checkprincipals -ServerInstance $Node2 
}
function checkallprincipals ($Node1){  
$tsql_checkallprincipals=@"
 -- 查詢執行個體內SQL Server驗證的登入帳戶
SELECT name N'主體的名稱'
--, principal_id N'主體的識別碼'
--, sid N'主體的 SID (安全性識別碼)'
--, type_desc N'主體類型的描述'
,is_disabled N'是否已被停用', create_date N'建立的日期時間'
	, modify_date N'修改的日期時間'
FROM sys.server_principals
--WHERE type='S'
 order by name
"@
Invoke-Sqlcmd -Query $tsql_checkallprincipals -ServerInstance $Node1 |ft -AutoSize
}
function listDBUser ($instanceName, $dbname){
if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    } 
#$instanceName = "sp2013"
  $server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
  $dbs=$server.Databases | ? name -EQ $dbname
foreach ($db in $dbs)
{
'      '
'---------'+$db.name
    $users=$db.users
    foreach ($user in $users)
    {
       $user.Name +"       " + $user.Login + "        "+$user.EnumRoles() 
    }

}  
}
function LoginCreateTrigger ($Node1){
$tsql_LoginCreateTrigger=@"
use Master
GO

CREATE TRIGGER LoginCreateTrigger ON ALL SERVER
FOR CREATE_LOGIN,alter_login,drop_login
AS
BEGIN
	DECLARE @createloginName nvarchar(max);
	DECLARE @TSQL nvarchar(max);
    DECLARE  @EventType nvarchar(max);
    DECLARE  @return nvarchar(max);
	--DECLARE @data xml;
	--SET @cloginName = EVENTDATA();
	--select @data
	Set @TSQL= EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
    Set @EventType=EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(max)')
    Set @createloginName=EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)')
    --Print @whologinName +'create '+@createloginName 
	--ROLLBACK
    Set @return=@EventType +'=TYPE'+ @createloginName +'=Name'
    RAISERROR(@return,10,10) WITH LOG
END

"@
Invoke-Sqlcmd -Query $tsql_LoginCreateTrigger -ServerInstance $Node1 
}

##
#------------------------
#  (configuraton) # only one 
#------------------------
#$Node1='SP2013'
#$Node2="sql2012x"

$tsql_createSP=@"
USE master
GO
IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
DROP PROCEDURE sp_hexadecimal
GO
CREATE PROCEDURE sp_hexadecimal
@binvalue varbinary(256),
@hexvalue varchar (514) OUTPUT
AS
DECLARE @charvalue varchar (514)
DECLARE @i int
DECLARE @length int
DECLARE @hexstring char(16)
SELECT @charvalue = '0x'
SELECT @i = 1
SELECT @length = DATALENGTH (@binvalue)
SELECT @hexstring = '0123456789ABCDEF'
WHILE (@i <= @length)
BEGIN
DECLARE @tempint int
DECLARE @firstint int
DECLARE @secondint int
SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
SELECT @firstint = FLOOR(@tempint/16)
SELECT @secondint = @tempint - (@firstint*16)
SELECT @charvalue = @charvalue +
SUBSTRING(@hexstring, @firstint+1, 1) +
SUBSTRING(@hexstring, @secondint+1, 1)
SELECT @i = @i + 1
END

SELECT @hexvalue = @charvalue
GO
 
IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL
DROP PROCEDURE sp_help_revlogin
GO
CREATE PROCEDURE sp_help_revlogin @login_name sysname = NULL AS
DECLARE @name sysname
DECLARE @type varchar (1)
DECLARE @hasaccess int
DECLARE @denylogin int
DECLARE @is_disabled int
DECLARE @PWD_varbinary  varbinary (256)
DECLARE @PWD_string  varchar (514)
DECLARE @SID_varbinary varbinary (85)
DECLARE @SID_string varchar (514)
DECLARE @tmpstr  varchar (1024)
DECLARE @is_policy_checked varchar (3)
DECLARE @is_expiration_checked varchar (3)

DECLARE @defaultdb sysname
 
IF (@login_name IS NULL)
DECLARE login_curs CURSOR FOR

SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
sys.server_principals p LEFT JOIN sys.syslogins l
ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name <> 'sa'
ELSE
DECLARE login_curs CURSOR FOR


SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
sys.server_principals p LEFT JOIN sys.syslogins l
ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name = @login_name
OPEN login_curs

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
IF (@@fetch_status = -1)
BEGIN
PRINT 'No login(s) found.'
CLOSE login_curs
DEALLOCATE login_curs
RETURN -1
END
SET @tmpstr = '/* sp_help_revlogin script '
PRINT @tmpstr
SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
PRINT @tmpstr
PRINT ''
WHILE (@@fetch_status <> -1)
BEGIN
IF (@@fetch_status <> -2)
BEGIN
PRINT ''
SET @tmpstr = '-- Login:' + @name
PRINT @tmpstr
IF (@type IN ( 'G', 'U'))
BEGIN -- NT authenticated account/group

SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'
END
ELSE BEGIN -- SQL Server authentication
-- obtain password and sid
SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )
EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT
EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT
 
-- obtain password policy state
SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
 
SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'

IF ( @is_policy_checked IS NOT NULL )
BEGIN
SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked
END
IF ( @is_expiration_checked IS NOT NULL )
BEGIN
SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked
END
END
IF (@denylogin = 1)
BEGIN -- login is denied access
SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )
END
ELSE IF (@hasaccess = 0)
BEGIN -- login exists but does not have access
SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )
END
IF (@is_disabled = 1)
BEGIN -- login is disabled
SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'
END
PRINT @tmpstr
END

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
END
CLOSE login_curs
DEALLOCATE login_curs
RETURN 0
GO


"@
#Invoke-Sqlcmd -Query $tsql_createSP -ServerInstance $Node1 # only one 

$tsql_DropSP=@"
USE master
GO
IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
DROP PROCEDURE sp_hexadecimal
GO

 
IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL
DROP PROCEDURE sp_help_revlogin
GO
"@
#Invoke-Sqlcmd -Query $tsql_DropSP -ServerInstance $Node1 
## Get

# LoginCreateTrigger $Node1



#------------------------
#  (main)主程式
#------------------------
#0  當SQL 執行 create login : 會啟動 Windows Event 啟動 Sqlps12_01_sp_help_revlogin.ps1
$Node1='SP2013'
$Node2="sql2012x"

if ((get-module 'sqlps') -gt $null)
{
    Import-Module 'sqlps' -DisableNameChecking
}

#1 檢查 最後一筆 SQL Server 事件 而且 EventID  是否為  17061 (大量批次處理.暫不考慮)
$e=Get-EventLog -LogName Application -Newest 1 -Source MSSQLSERVER -ComputerName $Node1

if ($e.EventID -eq '17061' ){
#2 找出被異動者名稱 $u
$a=($e.Message).IndexOf('=TYPE')+5
$b=($e.Message).IndexOf('=Name')
$u=($e.Message).Substring($a,$b-$a);#$u
#3.1 判斷 為 create 或是alter 行為
  if ( ($e.Message.IndexOf('CREATE_LOGIN') -ne -1 )   -or  ($e.Message.IndexOf('ALTER_LOGIN') -ne -1 )  ){
    
#3.2 if Yes  執行產生SID 的 $revlogine,
      $revlogine= sqlcmd -S $Node1 -Q "EXEC  sp_help_revlogin" 
#3.3 找出 $revlogine 中  的帳號名稱  $loginName1
      $i=0
        for ($n =0; $i -lt ($revlogine.count-2); $n++){ 
            $i=7+3*$n
            #$revlogine[$i];#$revlogine[$i].Length
            $loginName1=$revlogine[$i].Substring(9,($revlogine[$i].Length)-9);
            #Check Node2 loginName1 if
#3.4 取出附有SID的TSQL指令
            $revloginC=$revlogine[$i+1] | Out-String
#3.5 逐一檢查是否在Node2 是否有此 $u. 如有則Drop +Create,            
            if ((  (checkprincipals $Node2 $loginName1).name -ne $Null ) -and ($loginName1 -eq $u )){
            #if yes drop creat
$tsql_dorpCreateLogin=@"
                USE [master]
                GO
                DROP LOGIN [$loginName1]
                GO
                $revloginC
"@
#$tsql_dorpCreateLogin
                Invoke-Sqlcmd -Query $tsql_dorpCreateLogin -ServerInstance $Node2
             }
#3.6 是否沒有在Node2 此 $u. 如有則 Create only
            if ((  (checkprincipals $Node2 $loginName1).name -eq $Null ) -and ($loginName1 -eq $u )){

$tsql_CreateLogin=@"
$revloginC
GO
"@
#$tsql_CreateLogin
                Invoke-Sqlcmd -Query $tsql_CreateLogin -ServerInstance $Node2
}        

         }#for ($n =0; $i -lt ($revlogine.count-2); $n++)
  }# CREATE_LOGIN & ALTER_LOGIN
#4  判斷 為 drop 行為 則 直接在 Node2 上刪除
  if ($e.Message.IndexOf('DROP_LOGIN') -ne -1 ){
      '$u DROP_LOGIN'

$tsql_dorpLogin=@"
USE [master]
GO
DROP LOGIN [$loginName1]
GO
"@
#$tsql_dorpLogin
                Invoke-Sqlcmd -Query $tsql_dorpLogin -ServerInstance $Node2
  } # DROP_LOGIN

}  #$e.EventID -eq '17061' 
#5.程式結束

#(checkallprincipals  sp2013   ).count --38
#(checkallprincipals  sql2012x).count --35


#-----------------------------------

#$e |select  eventid

#$e.Message.IndexOf('DROP_LOGIN')
#$e.Message.IndexOf('CREATE_LOGIN')
#$e.Message.IndexOf('ALTER_LOGIN')

#listDBUser sp2013 backrest2
#listDBUser sp2013 backrest3
#listDBUser sp2013 backrest4

#listDBUser sql2012x backrest2
#listDBUser sql2012x backrest3
#listDBUser sql2012x backrest4

## assign Node 


#$revlogine.count-1
#$loginName='su1'

#checkprincipals $Node1 $loginName
#if ((checkprincipals $Node1 $loginName) -eq $Null){'Null'}
{<#
$i=0
for ($n =0; $i -lt ($revlogine.count-2); $n++)
{ 
    $i=7+3*$n
    #$revlogine[$i];$revlogine[$i].Length
    $loginName1=$revlogine[$i].Substring(9,($revlogine[$i].Length)-9);
    #Check Node2 loginName1 if
    $revloginC=$revlogine[$i+1] |Out-String
    if (((checkprincipals $Node2 $loginName1) -ne $Null) -and ($loginName1.Substring(0,2) -ne "##" )){
    #if yes drop creat
$tsql_dorpCreateLogin=@"
USE [master]
GO
DROP LOGIN [$loginName1]
GO
$revloginC
"@

#$tsql_dorpCreateLogin
Invoke-Sqlcmd -Query $tsql_dorpCreateLogin -ServerInstance $Node2
    }
    else{
  $tsql_CreateLogin=@"
  $revloginC
  GO
"@
#$tsql_CreateLogin
Invoke-Sqlcmd -Query $tsql_CreateLogin -ServerInstance $Node2
        
    }
    #$loginName1=$revlogine[$i].indexof("Login:")
    #$revlogine[$i+1]
}
#>}
<#
event ID: 17061
message :Error: 50000 Severity: 10 State: 10 CREATE LOGIN [su5] WITH PASSWORD=N'******', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
         Error: 50000 Severity: 10 State: 10 drop login su5 
         Error: 50000 Severity: 10 State: 10 ALTER LOGIN su5 WITH PASSWORD=N'******'

CREATE TRIGGER LoginCreateTrigger ON ALL SERVER
FOR CREATE_LOGIN,alter_login,drop_login
AS
BEGIN
	DECLARE @createloginName nvarchar(max);
	DECLARE @TSQL nvarchar(max);
    DECLARE  @EventType nvarchar(max);
    DECLARE  @return nvarchar(max);
	--DECLARE @data xml;
	--SET @cloginName = EVENTDATA();
	--select @data
	Set @TSQL= EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
    Set @EventType=EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(max)')
    Set @createloginName=EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)')
    --Print @whologinName +'create '+@createloginName 
	--ROLLBACK
    Set @return=@EventType +'=TYPE'+ @createloginName +'=Name'
    RAISERROR(@return,10,10) WITH LOG
END

drop TRIGGER LoginCreateTrigger  ON ALL SERVER

select * from sys.server_triggers#>

<#

# scenario 0 
--sp2013
sa
##MS_PolicyTsqlExecutionLogin##
##MS_PolicyEventProcessingLogin##
mingX
sasa
sql2012x
sp2013wfe
su1
su2
su4


--sql2012x
sa
##MS_PolicyTsqlExecutionLogin##
##MS_PolicyEventProcessingLogin##
su1
su2
mingX
sasa
sql2012x
sp2013wfe
su4

#----------- scenario 1   sp2013.backrest2  retore to sql2012x.backrest2
 #su2 己在 SP2013 & SQL2012X 都 已有帳號
 backrest2 su2 可以進入, 但是無法登入sql2012x. 執行同步$revlogin ,因為 su2 已在 sql2012x  already exists ,造成無法更新及登入
 手動刪除 sql2012x 上的 su2 (sp2013.backrest2上的su2仍保存在),再次執行 $revlogin , 後即可登入sql2012x.backrest2

USE [master]
DROP LOGIN [su2]
GO


$tsql_backrest2="select top  10 *  FROM [BackRest2].[dbo].[T1]"

invoke-sqlcmd -ServerInstance sp2013 -Database BackRest2 -Username su2 -Password '1234asdf' -Query $tsql_backrest2
invoke-sqlcmd -ServerInstance sql2012x -Database BackRest2 -Username su2 -Password '1234asdf' -Query $tsql_backrest2
#-----------
#----------- scenario 2   sp2013.backrest2  retore to sql2012x.backrest2
 #su2 己在 SP2013 & SQL2012X 都 已有帳號  , SP2013.su2 更改密碼. 此時 各用不同的密碼可登入.
(2.1).SP2013.su2 更改密碼
 USE [master]
GO
ALTER LOGIN [su2] WITH PASSWORD=N'1234asdf'
GO
 
  backup+restore backrest2  sql2012x 仍可以照登入,不用執行同步$revlogin

(2.2)各用不同的密碼可登入
  invoke-sqlcmd -ServerInstance sp2013 -Database BackRest2 -Username su2 -Password '1234fdsa' -Query $tsql_backrest2
invoke-sqlcmd -ServerInstance sql2012x -Database BackRest2 -Username su2 -Password '1234asdf' -Query $tsql_backrest2

(2.3)  backup+restore backrest2  

restore database backrest2 from disk='\\SP2013\temp\backrest2.bak' with replace
(2.4)sql2012x 仍可以照登入,不用執行同步$revlogin
#-----------

$s1 = $revlogine[2].indexof("LOGIN [") +7      ;$s1

$s2 = $revlogine[2].indexof("] WITH PASSWORD") ;$s2
$s2 = $revlogine[2].indexof("] FROM WINDOWS")  ;$s2
  
$c-$b
$loginName=$revlogine[2].Substring($b ,$c-$b)

$loginName=$revlogine[2].Substring($revlogine[2].indexof("LOGIN [") ,($revlogine[2].indexof("] FROM WINDOWS")-$revlogine[2].Substring($revlogine[2].indexof("LOGIN ["))) )

USE [master]
GO
CREATE LOGIN [su5] WITH PASSWORD=N'1234asdf', DEFAULT_DATABASE=[backrest4], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [su5]
GO



 TSQL
USE [master]
GO
ALTER LOGIN [su2] WITH PASSWORD=N'1234asdf'
GO

USE [master]
GO
ALTER LOGIN [su3] WITH PASSWORD=N'1234zxcv'
GO
USE [master]
GO
ALTER LOGIN [su4] WITH PASSWORD=N'1234qwer'
GO


USE [BackRest2]
GO
ALTER ROLE [db_datareader] ADD MEMBER [su2]
ALTER ROLE [db_datawriter] ADD MEMBER [su2]
GO


USE [BackRest2]
GO
ALTER ROLE [db_datareader] DROP MEMBER [su2]
GO
USE [BackRest2]
GO
ALTER ROLE [db_datawriter] DROP MEMBER [su2]
GO


backup database backrest2 to disk='\\SP2013\temp\backrest2.bak'
backup database backrest3 to disk='\\SP2013\temp\backrest3.bak'
backup database backrest4 to disk='\\SP2013\temp\backrest4.bak'

restore database backrest2 from disk='\\SP2013\temp\backrest2.bak' with replace
restore database backrest3 from disk='\\SP2013\temp\backrest3.bak' with replace
restore database backrest4 from disk='\\SP2013\temp\backrest4.bak' with replace






#>