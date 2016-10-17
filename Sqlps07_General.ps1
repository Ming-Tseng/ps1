<#Sqlps07_General

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps07_General.ps1
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps07_General.ps1
 C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps07_General.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.03.2014
 history : 
 object : tsql

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\Sqlps07_General.ps1

foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname         =$ps1fS.name
    $ps1fFullname     =$ps1fS.FullName 
    $ps1flastwritetime=$ps1fS.LastWriteTime
    $getdagte         = get-date -format yyyyMMdd
    $ps1length        =$ps1fS.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To "a0921887912@gmail.com","abcd12@gmail.com" -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  `
    -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length " `
    -Body "  ps1source from:me $ps1fname   " 
}
 

#>


#  1  system 變數  TSQL id ,hostname
#2    table => 變數 可執行  
#3   WHILE  loop 
#4   WAITFOR  
#5    RAND()   
#6    create table   
#7    INSERT data from Stored Procedure to Table 
#8    server_level objects 
#9    188 create   table
#10   insert 
#11   找出某Database 所有table            EXEC sp_MSforeachTable  
#12   找出某SQL 所有Database            Exec sp_MSforeachdb 
#13   Display Number of Rows in all Tables in a database
#14   Rebuild all indexes       Disable all Triggers      of all tables in a database
#15   like have '\'
#16   311 print echo
#17  343 查詢執行個體內SQL Server驗證的登入帳戶
#18  360  檢視「中央管理伺服器」存放在系統資料庫msdb內的資訊
#19  400  查詢 SQL Server 的產品版本、版本編號 edition
#20  420 step by step  create snapshot table
#21  450   Who   blocking  處理造成資料庫Blocking的情形 & sp_who
#22  474 set  single user
#23  477   Loop  example   & 大量產生資料  之變數
#24   table to table    +   計算時間 
#25  559 回傳 7 今天修改的
#26  580  Create   database
#27  600  WMI Server event alerts  using WMI  p.136
#27-2  700 explore the SQL Server WMI events is to use a tool similar  p140
#28  800  Attaching  / Detaching  /copy  a database using SMO  p143
#29  900 Executing a SQL query to multiple servers p152
#30  900 Running DBCC commands p167
#31  950  listing SQL Log error P215
#32  sp_addlinkedserver
#33  Show Size, Space Used, Unused Space, Type, and Name of all database files'
#    1099 34   get table info   ref:tsql004.ps1
#    1300 35  compare two tables  tablediff
#    1500 99  Built-in Functions TSQL
#    1500     Control-of-Flow Language TSQL
#    1801    Group having
#    1815  TSQL Trigger
#    1660  TQL Function#    1865   釋出所有快取  release cache on memory
#  1971   Automated Script generation   ScriptTransfer
#   1999   Getting database settings and object drops into a database-script


INSERT data from Stored Procedure to Table 
server_level objects 
#---------------------------------------------------------------
#  1  system 變數  TSQL id ,hostname
#---------------------------------------------------------------

select  @@spid
select  @@ServerName
select  ORIGINAL_LOGIN() ;select suser_sname() --CSD\Administrator
select APP_NAME()   --  Microsoft SQL Server Management Studio - Query
select SUSER_ID ('su2')   -- su2

select [Function] = 'user' ,Result = convert(sql_variant, user) union all
select [Function] = 'current_user' ,Result = convert(sql_variant, current_user) union all
select [Function] = 'sesion_user' ,Result = convert(sql_variant, session_user) union all
select [Function] = 'user_name()' ,Result = convert(sql_variant, user_name()) union all
select [Function] = 'user_id()' ,Result = convert(sql_variant, user_id()) union all 
select [Function] = 'user_sid()' ,Result = convert(sql_variant, user_sid()) union all 
select [Function] = 'system_user' ,Result = convert(sql_variant, system_user) union all 
select [Function] = 'suser_name()' ,Result = convert(sql_variant, suser_name()) union all 
select [Function] = 'suser_sname()' ,Result = convert(sql_variant, suser_sname()) union all 
select [Function] = 'suser_id()' ,Result = convert(sql_variant, suser_id()) union all 
select [Function] = 'suser_sid()' ,Result = convert(sql_variant, suser_sid()) union all 
select [Function] = 'original_login()' ,Result = convert(sql_variant, original_login()) union all
select [Function] = 'database_principal_id()', Result = convert(sql_variant, database_principal_id())

SELECT HOST_NAME(),suser_name(),
            SERVERPROPERTY('MachineName') AS [ServerName], 
			SERVERPROPERTY('ServerName') AS [ServerInstanceName], 
            SERVERPROPERTY('InstanceName') AS [Instance], 
            SERVERPROPERTY('Edition') AS [Edition],
            SERVERPROPERTY('ProductVersion') AS [ProductVersion], 
			Left(@@Version, Charindex('-', @@version) - 2) As VersionName


			SELECT HOST_NAME ()

#---------------------------------------------------------------
#2    table => 變數 可執行    DECLARE   SET
#---------------------------------------------------------------
DECLARE @SQL varchar(2000),@PathFileName varchar(100)
SET @PathFileName = 'TmpStList'
SET @SQL = ' Select * FROM  ' + @PathFileName  
EXEC (@SQL)

DECLARE @SQL varchar(2000),@PathFileName varchar(100), @dbname varchar(100)
SET @dbname ='WSS_Content_PMD'
SET @PathFileName = 'TmpStList'
SET @SQL = ' sp_helpdb ' + @dbname  
--SET @SQL = "BULK INSERT TmpStList FROM '"+@PathFileName+"' WITH (FIELDTERMINATOR = '"",""') " 
EXEC (@SQL)
##
declare @oid varchar(200)
select @oid=object_id from sys.tables where name='t2'
select * from sys.all_columns where object_id=@oid
#---------------------------------------------------------------
#3   WHILE  loop 
#---------------------------------------------------------------
DECLARE @counter smallint;
SET @counter = 1;
WHILE @counter < 5
   BEGIN
      SELECT RAND() as Random_Number
      SET @counter = @counter + 1
   END;
GO
#---------------------------------------------------------------
#4   WAITFOR  
#---------------------------------------------------------------
WAITFOR TIME '22:20:00'  --wait  until  22.PM

xxxx

WAITFOR DELAY '00:00:15'   -- wait 15 sec
GO 500       --repeat 500 times
#---------------------------------------------------------------
# 5  RAND()   
#---------------------------------------------------------------

      SELECT RAND() as Random_Number
      select newid() 
      SELECT cast((RAND()*1000) as int); --Geneter 1~1000 



#---------------------------------------------------------------
#6  create table   
#---------------------------------------------------------------
{<#
truncate table  [dbo].[T6]
DROP TABLE [dbo].[T6]
GO
CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [PRIMARY]
GO

DROP TABLE [dbo].[T5]
CREATE TABLE [dbo].[T5](
	[rid] [int] Not NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
    createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T5] PRIMARY KEY (rid)) ON [PRIMARY]
GO

#>}
#---------------------------------------------------------------
#7   INSERT data from Stored Procedure to Table  使用 TSQL002.ps1
#---------------------------------------------------------------

insert  into dgpap1.s1.dbo.t2 select * from t2

sp_configure 'Show Advanced Options', 1
GO
RECONFIGURE
GO
sp_configure 'Ad Hoc Distributed Queries', 1
GO
RECONFIGURE
GOSELECT * INTO #TestTableT FROM OPENROWSET('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;','EXEC  sp_who')
##----------------

use m1
CREATE TABLE dbo.Employee(ID INT IDENTITY(1,1),Name VARCHAR(50))INSERT INTO dbo.Employee(Name)VALUES('BASAVARAJ BIRADAR'),('SHREE BIRADAR')goselect * from dbo.EmployeeCREATE PROCEDURE dbo.GetEmployeesASBEGINSELECT * FROM dbo.Employee WITH(NOLOCK)ENDGO
EXEC dbo.GetEmployees
#---------------------------------------------------------------
#8   server_level objects 
#---------------------------------------------------------------
select * from sys.objects  where type='P'
select * from sys.tables

select * from sys.procedures order by name desc
AF = Aggregate function (CLR)C = CHECK constraintD = DEFAULT (constraint or stand-alone)F = FOREIGN KEY constraint
FN = SQL scalar functionFS = Assembly (CLR) scalar-functionFT = Assembly (CLR) table-valued functionIF = SQL inline table-valued functionIT = Internal tableP = SQL Stored ProcedurePC = Assembly (CLR) stored-procedurePG = Plan guidePK = PRIMARY KEY constraintR = Rule (old-style, stand-alone)RF = Replication-filter-procedureS = System base tableSN = SynonymSO = Sequence objectSQ = Service queueTA = Assembly (CLR) DML triggerTF = SQL table-valued-functionTR = SQL DML triggerTT = Table typeU = Table (user-defined)UQ = UNIQUE constraint
V = View
X = Extended stored procedure

#---------------------------------------------------------------
#9   create   TABLE
#---------------------------------------------------------------
DECLARE @blah TABLE
(
    ID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
)

INSERT INTO @blah (ID, Name)
    VALUES (123, 'Timmy')
    VALUES (124, 'Jonny')
    VALUES (125, 'Sally')

SELECT * FROM @blah


#---------------------------------------------------------------
#  10  insert 
#---------------------------------------------------------------

##
SELECT f.FactorId, f.FactorName, pf.PositionId
INTO #Temp01
FROM dbo.Factor f
WHERE 1 = 2
##
INSERT INTO #TempUsage
SELECT TOP 10  DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_seeks + s.user_scans + s.user_lookups) AS [Usage]
, s.user_updates
, i.fill_factor
FROM sys.dm_db_index_usage_stats s
    INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
    AND s.index_id = i.index_id
    INNER JOIN sys.objects o ON i.object_id = O.object_id
    WHERE s.database_id = DB_ID()

--10.2 迴圈新增大量資料
IF  EXISTS (SELECT * FROM sys.objects 
           WHERE object_id = OBJECT_ID(N'dbo.T') AND type in (N'U'))
DROP TABLE dbo.T
GO
CREATE TABLE dbo.t
   (
   c1 nchar(100) NULL DEFAULT 'hello'
   )  
GO

insert t default values

declare @i int
set @i=1
while @i<=30
begin
   insert t select * from t
   set @i=@i+1
end





#---------------------------------------------------------------
#11   找出  某Database 所有table            EXEC sp_MSforeachTable  
#---------------------------------------------------------------
EXEC sp_MSForEachTable 'PRINT ''?''; SELECT ''?'' as [TableName],
COUNT(*) AS [RowCount] FROM ?;'

##  TRUNCATE ALL TABLES
USE MyDatabase
EXEC sp_MSforeachtable 'TRUNCATE TABLE ?'

##  drop ALL TABLES
exec sp_msforeachtable 'drop table ?'

##
exec sp_msforeachtable 'delete from ?';
EXEC sp_MSforeachtable @command1 = "DELETE FROM ?"

use d1 ; select * from sys.tables where type='U' and is_ms_shipped ='0'

#---------------------------------------------------------------
#12   找出某SQL 所有Database            Exec sp_MSforeachdb 
#---------------------------------------------------------------
#   “Looping” through databases with sp_MSforeachdb and returning 1 data set
CREATE TABLE tempdb.dbo.Results (c1 VARCHAR(8000))

Declare @FullStatement varchar(MAX)

Set @FullStatement = 'SELECT ''use [?]''; SELECT  dp.state_desc + N'' '' + dp.permission_name + N'' TO '' + cast(QUOTENAME(dpl.name COLLATE DATABASE_DEFAULT) as nvarchar(500))  AS TSQLScript
FROM [?].sys.database_permissions AS dp
INNER JOIN [?].sys.database_principals AS dpl ON (dp.grantee_principal_id = dpl.principal_id)
WHERE dp.major_id = 0
and dpl.name not like ''##%'' -- excluds PBM accounts
and dpl.name not in (''dbo'', ''sa'', ''public'')
ORDER BY dp.permission_name ASC, dp.state_desc ASC'

INSERT INTO tempdb.dbo.Results Exec sp_MSforeachdb  @FullStatement

select * FROM tempdb.dbo.Results

##

EXEC sp_MSForEachDB 'USE [?];print DB_NAME(db_id()) '
EXEC sp_MSForEachDB 'USE [?];select name,* from sys.tables '


#---------------------------------------------------------------
#13   Display Number of Rows in all Tables in a database
#---------------------------------------------------------------

EXEC sp_MSforeachtable 'SELECT ''?'', Count(*) as NumberOfRows FROM ?'

EXEC sp_MSforeachtable @command1="EXEC sp_spaceused '?'"

#---------------------------------------------------------------
#14   Rebuild all indexes       Disable all Triggers      of all tables in a database
#---------------------------------------------------------------
USE YOURDBNAME
GO

EXEC sp_MSforeachtable @command1="print '?' DBCC DBREINDEX ('?', ' ', 80)"
GO
##Disable all Triggers of all tables in a database
EXEC sp_MSforeachtable 'ALTER TABLE ? DISABLE TRIGGER ALL'
##Update Statistics of all Tables in a database
USE YOURDBNAME
EXEC sp_MSforeachtable 'UPDATE statistics ? WITH ALL'


#---------------------------------------------------------------
#15   like have '\'
#---------------------------------------------------------------
For example, to find routines that contain the
text “dba_,” the LIKE statement would be
LIKE '%dba\_%' ESCAPE '\'

#---------------------------------------------------------------
#16   print echo
#---------------------------------------------------------------
RAISERROR( 'This message will show up right away...',0,1) WITH NOWAIT
Print ''

#---------------------------------------------------------------
#17  343 查詢執行個體內SQL Server驗證的登入帳戶
#---------------------------------------------------------------
USE master
GO
-- 查詢執行個體內SQL Server驗證的登入帳戶
SELECT name N'主體的名稱', principal_id N'主體的識別碼', sid N'主體的 SID (安全性識別碼)', type_desc N'主體類型的描述',
	is_disabled N'是否已被停用', create_date N'建立的日期時間', modify_date N'修改的日期時間'
FROM sys.server_principals
WHERE type='S'


#---------------------------------------------------------------
#18 360  檢視「中央管理伺服器」存放在系統資料庫msdb內的資訊
#---------------------------------------------------------------
USE msdb
GO
/*===========================================*/
--01 使用「檢視(View)」

--檢視各個「伺服器」的資料
SELECT * FROM msdb.dbo.sysmanagement_shared_registered_servers

--檢視「伺服器群組」的資料
SELECT * FROM msdb.dbo.sysmanagement_shared_server_groups

/*===========================================*/
--02 使用「資料表(Table)」

--檢視各個「伺服器」的資料
SELECT * FROM msdb.dbo.sysmanagement_shared_registered_servers_internal

--檢視「伺服器群組」的資料
SELECT * FROM msdb.dbo.sysmanagement_shared_server_groups_internal

#---------------------------------------------------------------
#   Temp
#---------------------------------------------------------------
select DB_NAME(database_id) as [DatabaseName],name as [internalDBName],physical_name,Size *0.008192 as 'filesize(M)' from  sys.master_files



#---------------------------------------------------------------
# 19 400 查詢 SQL Server 的產品版本、版本編號 
#---------------------------------------------------------------

http://sharedderrick.blogspot.com/2011/01/sql-server.html

SELECT RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'

 2014	
 12.0.2000.8	
 RTM	
 Enterprise Edition: Core-based Licensing (64-bit)	
 782	
 Microsoft SQL Server 2014 - 12.0.2000.8 (X64) Feb 20 2014 20:04:26 Copyright (c) Microsoft Corporation  Enterprise Edition: Core-based Licensing (64-bit) on Windows NT 6.3 <X64> (Build 9600: ) (Hypervisor)


 2014	
 12.0.4100.1	
 SP1	
 Enterprise Edition (64-bit)	
 782	
 Microsoft SQL Server 2014 - 12.0.4100.1 (X64) 	Apr 20 2015 17:29:27 Copyright (c) Microsoft Corporation Enterprise Edition (64-bit) on Windows NT 6.3 <X64> (Build 9600: ) (Hypervisor)


#---------------------------------------------------------------
#20 420 step by step  create snapshot table
#---------------------------------------------------------------
## 1

Use d1
SELECT * INTO os_wait_stats  FROM  sys.dm_os_wait_stats where 1=2
drop table os_wait_stats

## 2
CREATE TABLE [dbo].[os_wait_stats](
	[wait_type] [nvarchar](60) NOT NULL,
	[waiting_tasks_count] [bigint] NOT NULL,
	[wait_time_ms] [bigint] NOT NULL,
	[max_wait_time_ms] [bigint] NOT NULL,
	[signal_wait_time_ms] [bigint] NOT NULL,
	[gd] smalldatetime
) ON [PRIMARY]

GO
##

insert into os_wait_stats select *,GETDATE() from sys.dm_os_wait_stats

#---------------------------------------------------------------
#21  450   Who   blocking  處理造成資料庫Blocking的情形 & sp_who
#---------------------------------------------------------------
/*

*/
Sp_who
Sp_who2
Spid (系統進程ID)
status (進程狀態)
loginame (用戶登錄名)
hostname(用戶主機名稱)
blk (阻塞進程的SPID)
dbname (進程正在使用的資料庫名)
Cmd (當前正在執行的命令類型)
CPUTime (進程佔用的總CPU時間)
DiskIO (進程對磁片讀的總次數)
LastBatch (客戶最後一次調用存儲過程或者執行查詢的時間)
ProgramName (用來初始化連接的應用程式名稱，或者主機名稱)

回傳的SPID數值50以下的為系統進程，可以先忽略掉


KILL (SPID)
DBCC INPUTBUFFER (SPID)

#---------------------------------------------------------------
#22  474 set  single user
#---------------------------------------------------------------

Exec   sp_dboption 'dbname','single  user ','true'
Exec   sp_dboption 'dbname','single  user ','false'

EXEC sp_dboption 'pubs', 'read only', 'TRUE'

EXEC sp_dboption 'sales', 'offline', 'TRUE' 

Alter database XXX set Single_User  with No_wait
ALTER DATABASE AdventureWorks2012  SET SINGLE_USER   WITH ROLLBACK IMMEDIATE;



Alter database XXX set  Multi_User  with No_wait  -- must use 





#---------------------------------------------------------------
#  23 477   Loop  example   & 大量產生資料  之變數
#---------------------------------------------------------------

##
DECLARE  @dbname varchar(255)
DECLARE @dbid int

DECLARE  Pointcursor    SCROLL CURSOR FOR   --p.03
	SELECT dbid, name FROM sys.sysdatabases where dbid not in ('1','2','3','4')order by dbid

OPEN   Pointcursor    ;   --p.05
FETCH Next FROM   Pointcursor    into @dbid,@dbname ;
  
  WHILE @@FETCH_STATUS = 0   BEGIN    --P.12
           
		      print '['+ CONVERT(varchar(20), @dbid) + ']    '+ @dbname 
			 
              FETCH next FROM    Pointcursor      into    @dbid,@dbname 
  END--P.12

CLOSE    Pointcursor    ; --p.05
DEALLOCATE Pointcursor  ; --p.03

GO

##----------------------產生變數---------

declare @cnt int
declare @selector int
declare @buffer varchar(500)
set @cnt = (select count(*) from #tableselection) ;Print @cnt 
set @selector = rand() * @cnt + 1 ;Print @selector 

set @buffer = 'truncate table ' + (select name from #tableselection where id = @selector);Print @buffer 


##
create table TestTB (
col1 int null,
col2 datetime null,
col3 int null,
col4 varchar(MAX)
)
go
declare @i as int
declare @max_i as int
declare @cnt as int
set @i = 0
set @max_i = 20000
while @i<@max_i
begin
   set @i = @i+1
   select @cnt=COUNT(*) from TestTB with (nolock)
   insert into TestTB values (@i  , GETDATE(), @cnt , REPLICATE ( cast ( @cnt as CHAR(8)), 100 )
   )
end
select COUNT(*), DATEDIFF(ms,min(col2),max(col2)) from TestTB with (nolock)
 
--drop table TestTB




#---------------------------------------------------------------
#  24 table to table    +   計算 
#---------------------------------------------------------------
SET STATISTICS TIME ON

set statistics io on
select * into TestTB3 from testtb
SET STATISTICS TIME OFF





#---------------------------------------------------------------
#25  559 回傳 7 今天修改的
#---------------------------------------------------------------


/* 回傳 7 今天修改的*/
use WebHr_Standard
select * from sys.objects 
where  modify_date > GETDATE() -7
order by  modify_date




#---------------------------------------------------------------
# 26  580  Create   database
#---------------------------------------------------------------
CREATE DATABASE [SQL_Inventory] ON(NAME = N'SQLInventory',FILENAME = N'H:\SQLDB\SQL_Inventory.mdf',SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024MB )LOG ON(NAME = N'SQLInventory_log',FILENAME = N'H:\SQLDB\SQL_Inventory_log.LDF',SIZE = 512MB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)



#---------------------------------------------------------------
# 27  600  WMI Server event alerts  using WMI  p.136
#---------------------------------------------------------------

##Getting ready
'
set up an alert that creates a timestamped text file every time there is a DDL
Login event (CREATE, ALTER, or DROP). We will utilize the WMI provider for server
events in this exercise.

Item :
Namespace (if using the default instance) : root\Microsoft\SqlServer\ServerEvents\MSSQLServer
Namespace (if using a named instance)     : root\Microsoft\SqlServer\ServerEvents\SQL01
WMI query    :SELECT * FROM DDL_LOGIN_EVENTS
DDL_LOGIN_EVENTS properties (partial list) : SQLInstance ,LoginName , PostTime , SPID ,ComputerName ,LoginType

'
'
For WMI events hitting SQL Server, you will also need to ensure that SQL Server Broker is running on your target database. 
In our case, we need to ensure that the Broker is running on the msdb database.
'
SELECT
is_broker_enabled, *
FROM
sys.databases
ORDER BY
name


#'Check the msdb database'
  is_broker_enabled field in the result.'
If service broker is not running on msdb, run the following T-SQL statement from SQL Server
Management Studio:
'

ALTER DATABASE msdb
SET ENABLE_BROKER

Alternatively, you can do this using PowerShell:
$database.BrokerEnabled = $true
$database.Alter()

##
$namespace = "root\Microsoft\SqlServer\ServerEvents\MSSQLSERVER"
#WQL for Login Events
#note we will capture CREATE, DROP, ALTER
#if you want to more specific, use these events
#DROP_LOGIN, CREATE_LOGIN, ALTER_LOGIN
$query = "SELECT * FROM DDL_LOGIN_EVENTS"
#register the event
#if the event is triggered, it will respond by
#creating a timestamped file containing event
#details

Register-WMIEvent `
-Namespace $namespace `
-Query $query -SourceIdentifier "SQLLoginEvent" `
-Action {
$date = Get-Date -Format "yyyy-MM-dd_hmmtt"
$filename = "C:\Temp\LoginEvent-$($date).txt"
New-Item –ItemType file $filename
$msg = @"
DDL Login Event Occurred`n
PostTime: $($event.SourceEventArgs.NewEvent.PostTime)
SQLInstance: $($event.SourceEventArgs.NewEvent.SQLInstance)
LoginType: $($event.SourceEventArgs.NewEvent.LoginType)
LoginName: $($event.SourceEventArgs.NewEvent.LoginName)
SID: $($event.SourceEventArgs.NewEvent.SID)
SPID: $($event.SourceEventArgs.NewEvent.SPID)
TSQLCommand: $($event.SourceEventArgs.NewEvent.TSQLCommand)
"@
$msg | Out-File -FilePath $filename -Append
}

## TEST
(1). Open SQL Server Management Studio.

(2). In a new query window, execute the following code. This will trigger the DDL Login WMI event:
USE [master]
GO
CREATE LOGIN [eric]
WITH PASSWORD=N'P@ssword',
DEFAULT_DATABASE=[master],
CHECK_EXPIRATION=OFF,
CHECK_POLICY=OFF
GO

(3). Go to your Temp folder and check if there is a file created for the LoginEvent:

(4).Open the LoginEvent file to see the entries. Note that the T-SQL statement
we used to create the new login has been captured in this file.

#---------------------------------------------------------------
# 27-2  700 explore the SQL Server WMI events is to use a tool similar  p140
#---------------------------------------------------------------
'Another way to explore the SQL Server WMI events is to use a tool similar to Marc van Orsouw's
(also known as The PowerShell Guy) PowerShell WMI Explorer (http://thepowershellguy.
com/blogs/posh/archive/2007/03/22/powershell-wmi-explorer-part-1.aspx):
'
'Marc has provided instructions on his blog on how to use this tool, which is pretty
straightforward. Once you navigate to the ROOT\Microsoft\SqlServer\ServerEvents\
MSSQLSERVER namespace and the DDL_LOGIN_EVENTS class, the supported properties
and methods will be displayed on the right-hand pane.
After you finalize the namespace and WQL query, you need to register this as a WMI event.
When registering this event, we will specify an action section to create a timestamped log file
each time the event is triggered. This log file will contain event properties such as PostTime,
LoginType, LoginName, SID, SPID, and the T-SQL command that caused the event trigger
to fire.

'Register-WMIEvent `
-Namespace $namespace `
-Query $query -SourceIdentifier "SQLLoginEvent" `
-Action {
$date = Get-Date -Format "yyyy-MM-dd_hmmtt"
$filename = "C:\Temp\LoginEvent-$($date).txt"
New-Item –ItemType file $filename
$msg = @"
DDL Login Event Occurred`n
PostTime: $($event.SourceEventArgs.NewEvent.PostTime)
SQLInstance: $($event.SourceEventArgs.NewEvent.SQLInstance)
LoginType: $($event.SourceEventArgs.NewEvent.LoginType)
LoginName: $($event.SourceEventArgs.NewEvent.LoginName)
SID: $($event.SourceEventArgs.NewEvent.SID)
SPID: $($event.SourceEventArgs.NewEvent.SPID)
TSQLCommand: $($event.SourceEventArgs.NewEvent.TSQLCommand)
"@
$msg | Out-File -FilePath $filename -Append
}


'The Register-WmiEvent cmdlet translates the query into SQL Server event notifications,
which are handled by the Service Broker.
To unregister the event, use the Unregister-Event cmdlet:
'
Unregister-Event "SQLLoginEvent"
'One caveat about the Register-WmiEvent cmdlet is that it's a temporarily registered event.
This means that it will go away if the program hosting it stops or the server gets restarted.
'

#WMI Provider for Server Events Classes and Properties article can be found here:
http://msdn.microsoft.com/en-us/library/ms186449(v=sql.110).aspx
#To learn more about DDL event groups, check out MSDN:
http://msdn.microsoft.com/en-us/library/bb510452(v=sql.110).aspx
#Also check out the MSDN article on Understanding the WMI Provider for Server Events:
http://msdn.microsoft.com/en-us/library/ms181893(v=sql.110).aspx
'WMI Query Language (WQL) will become more and more important as you work with more
WMI events. There is an excellent free e-book provided by one of the prominent bloggers in
the PowerShell community, Ravikanth Chaganti. You can download his WQL e-book from:
'
http://www.ravichaganti.com/blog/?p=1979
#One tool that can help you explore the WMI properties and events is Marc van Orsouw's PowerShell WMI Explorer:
http://thepowershellguy.com/blogs/posh/archive/2007/03/22/powershellwmi-explorer-part-1.aspx


#---------------------------------------------------------------
# 28 800  Attaching  / Detaching  /copy  a database using SMO  p143
#---------------------------------------------------------------
# $server.DetachDatabase($databasename, $false, $false)


CREATE DATABASE [TestDB]
CONTAINMENT = NONE
ON PRIMARY
( NAME = N'TestDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestDB.mdf' , SIZE = 4096KB , FILEGROWTH = 1024KB ),
FILEGROUP [FG1]
( NAME = N'data1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\data1.ndf' , SIZE = 4096KB , FILEGROWTH= 1024KB ),
FILEGROUP [FG2]
( NAME = N'data2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\data2.ndf' , SIZE = 4096KB , FILEGROWTH= 1024KB )
LOG ON
( NAME = N'TestDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestDB_log.ldf' , SIZE = 1024KB
, FILEGROWTH = 10%)
GO

##--  DetachDatabase
#replace this with your instance name
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$databasename = "TestDB"
#parameters accepted are databasename, boolean
#flag for updatestatistics, and boolean flag
#for removeFulltextIndexFile
$server.DetachDatabase($databasename, $false, $false)



'Capturing the mdf, ndf, and ldf information can be useful, especially if you plan to detach
the database and re-attach it right away to a different instance.
One way to get this information is by using the mdf file to extract all the other data and log
files that the detached database uses. You can supply the full mdf file path to two methods to
get all the information about the data and log files:
'
$server.EnumDetachedDatabaseFiles($mdfname)
$server.EnumDetachedLogFiles($mdfname)


##--  AttachDatabase
#replace this with your instance name
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$databasename = "TestDB"
#identify the primary data file
#this typically has the .mdf extension
$mdfname = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestDB.mdf"
#FYI only
#view detached database info
$server.DetachedDatabaseInfo($mdfname) | Format-Table

#attachdatabase accepts a StringCollection, so we need
#to add our files in this collection
$filecoll = New-Object System.Collections.Specialized.StringCollection

#add all data files
#this includes the primary data file
$server.EnumDetachedDatabaseFiles($mdfname) |
Foreach-Object {
$filecoll.Add($_)
}
#add all log files
$server.EnumDetachedLogFiles($mdfname) |
ForEach-Object {
$filecoll.Add($_)
}

$owner = "sp2012\administrator"
<#
http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.
management.smo.attachoptions.aspx
None There are no attach options. Value = 0.
EnableBroker Enables Service Broker . Value = 1.
NewBroker Creates a new Service Broker . Value = 2.
ErrorBrokerConversations Stops all current active Service Broker
conversations at the save point and issues
an error message. Value = 3.
RebuildLog Rebuilds the log. Value = 4.
#>
$server.AttachDatabase($databasename, $filecoll, $owner, [Microsoft.SqlServer.Management.Smo.AttachOptions]::None)

##--  Copying

$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$databasename = "TestDB"
$sourcedatabase = $server.Databases[$databasename]

#Create a database to hold the copy of your database
$dbnamecopy = "$($databasename)_copy"
$dbcopy = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Database -ArgumentList $server, $dbnamecopy
$dbcopy.Create()
#need to specify source database
#Use SMO Transfer Class
$transfer = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Transfer -ArgumentList $sourcedatabase
$transfer.CopyAllTables = $true
$transfer.Options.WithDependencies = $true
$transfer.Options.ContinueScriptingOnError = $true
$transfer.DestinationDatabase = $dbnamecopy
$transfer.DestinationServer = $server.Name
$transfer.DestinationLoginSecure = $true
$transfer.CopySchema = $true
#if you want to only produce a script that will
#“copy” your database, use the ScriptTransfer method
$transfer.ScriptTransfer()
#if you want to perform the actual transfer
#you should use the TransferData method
$transfer.TransferData()

#---------------------------------------------------------------
# 29  900 Executing a SQL query to multiple servers p152
#---------------------------------------------------------------

#getting ready

Identify the available instances for you to run your query on. Once you have identified all
the instances you want to execute the command to,
 create a text file in    and put each instance name line by line into that file. For example:
H:\Temp\sqlinstances.txt 
sp2013
sp2013\sqls2

$instances = Get-content "H:\Temp\sqlinstances.txt"
$query = "SELECT @@SERVERNAME 'SERVERNAME', @@VERSION 'VERSION'"
$databasename = "master"

$instances |
ForEach-Object {
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $_
Invoke-Sqlcmd -ServerInstance $_ -Database $databasename -Query
$query
}

#---------------------------------------------------------------
# 30  900 Running DBCC commands  CLEANTABLE DBreindex p167
#---------------------------------------------------------------
https://msdn.microsoft.com/en-us/library/ms188796.aspx
DBCC DBREINDEX  -- https://msdn.microsoft.com/en-us/library/ms181671.aspx

$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName

# Some DBCC commands are built into SMO, so you can just call the methods:
$databasename = "AdventureWorks2008R2"
$database = $server.Databases[$databasename]
#RepairType Values: AllowDataLost, Fast, None, Rebuild
$database.CheckTables([Microsoft.SqlServer.Management.Smo.RepairType]::None)

DBCC CLEANTABLE (AdventureWorks2012,'Production.Document', 0)  --從資料表或索引檢視中卸除的可變長度資料行回收空間。https://msdn.microsoft.com/zh-tw/zhtw/library/ms174418.aspx
WITH NO_INFOMSGS;  
GO



#---------------------------------------------------------------
# 31 900  listing SQL Log error P215
#---------------------------------------------------------------

2. Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

3. Add the following script and run:
#According to MSDN:
#ReadErrorLog: returns A StringCollection system object
#value that contains an enumerated list of errors from
#the SQL Server error log.
#Note we are using PowerShell V3 because of simplified
#Where-Object syntax
[datetime]$date = "2011-11-01"
$server.ReadErrorLog() | Where-Object Text -Like "*failed*" | Where-Object LogDate -ge $date |
Format-Table –AutoSize

## get generic errors from the Event log

#if you want to get all the generic errors from the Event Log
#you can use this
Get-EventLog Application -Source "MSSQLSERVER" -EntryType Error


#---------------------------------------------------------------
# 32  sp_addlinkedserver
#---------------------------------------------------------------

##  Get

exec sp_linkedservers

##

EXEC master.dbo.sp_addlinkedserver @server = N'DGPAP1', @srvproduct=N'SQL Server'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'DGPAP1',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='p@ssw0rd'





USE [master]
GO

/****** Object:  LinkedServer [2013BI]    Script Date: 2014/8/5 上午 10:25:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'2013BI', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'2013BI',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'2013BI', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

##  drop 

USE [master]
GO
/****** Object:  LinkedServer [DGPAP1]    Script Date: 2014/8/5 上午 10:28:04 ******/
EXEC master.dbo.sp_dropserver @server=N'DGPAP1', @droplogins='droplogins'
GO

#---------------------------------------------------------------
# 33  Show Size, Space Used, Unused Space, Type, and Name of all database files'
#---------------------------------------------------------------

$tsql_select="
print 'Show Size, Space Used, Unused Space, Type, and Name of all database files'
select
	[FileSizeMB]	=
		convert(numeric(10,2),sum(round(a.size/128.,2))),
        [UsedSpaceMB]	=
		convert(numeric(10,2),sum(round(fileproperty( a.name,'SpaceUsed')/128.,2))) ,
        [UnusedSpaceMB]	=
		convert(numeric(10,2),sum(round((a.size-fileproperty( a.name,'SpaceUsed'))/128.,2))) ,
	[Type] =
		case when a.groupid is null then '' when a.groupid = 0 then 'Log' else 'Data' end,
	[DBFileName]	= isnull(a.name,'*** Total for all files ***')
from
	sysfiles a
group by
	groupid,
	a.name
	with rollup
having
	a.groupid is null or
	a.name is not null
order by
	case when a.groupid is null then 99 when a.groupid = 0 then 0 else 1 end,
	a.groupid,
	case when a.name is null then 99 else 0 end,
	a.name
"

    Invoke-Sqlcmd -Query $tsql_select -ServerInstance  DGPAP2  -Database d1 |ft -AutoSize
    Invoke-Sqlcmd -Query $tsql_select -ServerInstance  PMD2016  -Database SQL_inventory  -user sa  -password p@ssw0rd  |ft -AutoSize

     

    sleep 3


#---------------------------------------------------------------
# 1099  34   get table info   ref:tsql004.ps1
#---------------------------------------------------------------
{<#
$tsql_select="
-- Script to analyze table space usage using the
-- output from the sp_spaceused stored procedure
-- Works with SQL 7.0, 2000, and 2005set nocount on


create table #TABLE_SPACE_WORK
(
	TABLE_NAME 	sysname		not null ,
	TABLE_ROWS 	numeric(18,0)	not null ,
	RESERVED 	varchar(50) 	not null ,
	DATA 		varchar(50) 	not null ,
	INDEX_SIZE 	varchar(50) 	not null ,
	UNUSED 		varchar(50) 	not null ,
)
create table #TABLE_SPACE_USED
(
	Seq		int		not null	
	identity(1,1)	primary key clustered,
	TABLE_NAME 	sysname		not null ,
	TABLE_ROWS 	numeric(18,0)	not null ,
	RESERVED 	varchar(50) 	not null ,
	DATA 		varchar(50) 	not null ,
	INDEX_SIZE 	varchar(50) 	not null ,
	UNUSED 		varchar(50) 	not null ,
)
create table #TABLE_SPACE
(
	Seq		int		not null
	identity(1,1)	primary key clustered,
	TABLE_NAME 	SYSNAME 	not null ,
	TABLE_ROWS 	int	 	not null ,
	RESERVED 	int	 	not null ,
	DATA 		int	 	not null ,
	INDEX_SIZE 	int	 	not null ,
	UNUSED 		int	 	not null ,
	USED_MB				numeric(18,4)	not null,
	USED_GB				numeric(18,4)	not null,
	AVERAGE_BYTES_PER_ROW		numeric(18,5)	null,
	AVERAGE_DATA_BYTES_PER_ROW	numeric(18,5)	null,
	AVERAGE_INDEX_BYTES_PER_ROW	numeric(18,5)	null,
	AVERAGE_UNUSED_BYTES_PER_ROW	numeric(18,5)	null,
)




declare @fetch_status int
declare @proc 	varchar(200)
select	@proc	= rtrim(db_name())+'.dbo.sp_spaceused'
declare Cur_Cursor cursor local
for
--select TABLE_NAME	= rtrim(TABLE_SCHEMA)+'.'+rtrim(TABLE_NAME)
--from INFORMATION_SCHEMA.TABLES 
--where  TABLE_TYPE	= 'BASE TABLE'
--order by	1

select TABLE_NAME =name  from  sys.tables  where is_ms_shipped ='0'

open Cur_Cursor
declare @TABLE_NAME 	varchar(200)
select @fetch_status = 0
while @fetch_status = 0
	begin
fetch next from Cur_Cursor
	into
		@TABLE_NAME
select @fetch_status = @@fetch_status
if @fetch_status <> 0
		begin
		continue
		end
truncate table #TABLE_SPACE_WORK
insert into #TABLE_SPACE_WORK
		(
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
		)
	exec @proc @objname =  @TABLE_NAME ,@updateusage = 'true'
-- Needed to work with SQL 7
	update #TABLE_SPACE_WORK
	set
		TABLE_NAME = @TABLE_NAME
insert into #TABLE_SPACE_USED
		(
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
		)
	select
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
	from
		#TABLE_SPACE_WORK
end 	--While end
close Cur_Cursor
deallocate Cur_Cursor
insert into #TABLE_SPACE
	(
	TABLE_NAME,
	TABLE_ROWS,
	RESERVED,
	DATA,
	INDEX_SIZE,
	UNUSED,
	USED_MB,
	USED_GB,
	AVERAGE_BYTES_PER_ROW,
	AVERAGE_DATA_BYTES_PER_ROW,
	AVERAGE_INDEX_BYTES_PER_ROW,
	AVERAGE_UNUSED_BYTES_PER_ROW
)
select
	TABLE_NAME,
	TABLE_ROWS,
	RESERVED,
	DATA,
	INDEX_SIZE,
	UNUSED,
	USED_MB			=
		round(convert(numeric(25,10),RESERVED)/
		convert(numeric(25,10),1024),4),
	USED_GB			=
		round(convert(numeric(25,10),RESERVED)/
		convert(numeric(25,10),1024*1024),4),
	AVERAGE_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),RESERVED))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_DATA_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),DATA))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_INDEX_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),INDEX_SIZE))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_UNUSED_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),UNUSED))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end
from
	(
	select
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED	= 
		convert(int,rtrim(replace(RESERVED,'KB',''))),
		DATA		= 
		convert(int,rtrim(replace(DATA,'KB',''))),
		INDEX_SIZE	= 
		convert(int,rtrim(replace(INDEX_SIZE,'KB',''))),
		UNUSED		= 
		convert(int,rtrim(replace(UNUSED,'KB','')))
	from
		#TABLE_SPACE_USED aa
	) a
order by
	TABLE_NAME

print 'Show results in descending order by size in MB'
select TABLE_NAME,TABLE_ROWS,USED_MB,AVERAGE_BYTES_PER_ROW,AVERAGE_DATA_BYTES_PER_ROW,AVERAGE_INDEX_BYTES_PER_ROW,AVERAGE_UNUSED_BYTES_PER_ROW

from #TABLE_SPACE order by USED_MB desc
go
drop table #TABLE_SPACE_WORK
drop table #TABLE_SPACE_USED 
drop table #TABLE_SPACE
"


    Invoke-Sqlcmd -Query $tsql_select -ServerInstance  DGPAP2  -Database d1 |ft -AutoSize
    
    Invoke-Sqlcmd -Query $tsql_select -ServerInstance  DGPAP1  -Database s1 |ft -AutoSize

#>}
#---------------------------------------------------------------
# 1300 35  compare two tables  tablediff
#---------------------------------------------------------------
{<#
在扮演複寫簽發者之 Microsoft SQL Server 執行個體的來源資料表，與扮演複製訂閱者的一或多個 SQL Server 執行個體的目的地資料表之間，每個資料列做比較。
執行快速比較，只比較資料列計數和結構描述。
進行資料行層級的比較。
產生 Transact-SQL 指令碼來修正目的地伺服器不一致的情形，以便聚合來源和目的地資料表。
將結果記錄在輸出檔中，或記錄在目的地資料庫的資料表中。

-sourceserver source_server_name[\instance_name] :這是來源伺服器的名稱。 為 SQL Server 的預設執行個體指定 source_server_name。 為 SQL Server 的具名執行個體指定 source_server_name\instance_name。
-sourcedatabase source_database   :這是來源資料庫的名稱。
-sourcetable source_table_name    :這是所檢查的來源資料表的名稱。
-sourceschema source_schema_name  :來源資料表的結構描述擁有者。 根據預設，資料表擁有者假設為 dbo。
-sourcepassword source_password   :這是用來連接使用 SQL Server 驗證之來源伺服器的登入密碼
-sourceuser source_login          :這是用來連接使用 SQL Server 驗證之來源伺服器的登入。 如果未提供 source_login，在連接到來源伺服器時，會使用 Windows 驗證。 盡可能使用 Windows 驗證。
-sourcelocked  :在比較期間，來源資料表以 TABLOCK 和 HOLDLOCK 資料表提示鎖定。
-destinationserver destination_server_name[\instance_name] :這是目的地伺服器的名稱。 為 SQL Server 的預設執行個體指定 destination_server_name。 為 SQL Server 的具名執行個體指定 destination_server_name\instance_name。
-destinationdatabase subscription_database:這是目的地資料庫的名稱。
-destinationtable destination_table :這是目的地資料表的名稱。
-destinationschema destination_schema_name :目的地資料表的結構描述擁有者。 根據預設，資料表擁有者假設為 dbo。
-destinationpassword destination_password  :這是用來連接使用 SQL Server 驗證之目的地伺服器的登入密碼。
-destinationuser destination_login         :這是用來連接使用 SQL Server 驗證之目的地伺服器的登入。 如果未提供 destination_login，在連接到伺服器時，會使用 Windows 驗證。 盡可能使用 Windows 驗證。
-destinationlocked                         :在比較期間，目的地資料表以 TABLOCK 和 HOLDLOCK 資料表提示鎖定。

-b large_object_bytes        :這是用來進行下列大型物件資料類型之資料行比較的位元組數目，其中包括：text、ntext、image、varchar(max)、nvarchar(max) 和 varbinary(max)。 large_object_bytes 預設為資料行的大小。 large_object_bytes 以上的任何資料將不會做比較。
-bf number_of_statements     :這是使用 -f 選項時要寫入現行 Transact-SQL 指令碼檔案中的 Transact-SQL 陳述式數目。 當 Transact-SQL 陳述式數目超出 number_of_statements 時，會建立新的 Transact-SQL 指令碼檔案。
-c                           :比較資料行層級的差異。
-dt                          :卸除 table_name 指定的結果資料表 (如果該資料表已存在的話)。
-et table_name               :指定要建立的結果資料表名稱。 如果這份資料表已經存在，就必須使用 -DT，否則作業會失敗。
-f [ file_name ]             :產生一份 Transact-SQL 指令碼來聚合目的地伺服器的資料表與來源伺服器的資料表。 您可以選擇性地為所產生的 Transact-SQL 指令碼檔案指定名稱和路徑。 如果未指定 file_name，Transact-SQL 指令碼檔案會產生在執行公用程式的目錄中。
-o output_file_name          :這是輸出檔的完整名稱和路徑。
-q                           :執行快速比較，只比較資料列計數和結構描述。
-rc number_of_retries        :公用程式重試失敗作業的次數。
-ri retry_interval           :兩次重試之間等待的間隔秒數。
-strict                      :嚴格比較來源和目的地結構描述。
-t connection_timeouts       :設定通往來源伺服器和目的地伺服器之連接的連接逾時期限 (以秒為單位)。


param( [string]$SourceServer = "SERVER\INSTANCE",
[string]$SourceDatabase = "SourceDB",
[string]$DestinationServer = "SERVER\INSTANCE",
[string]$DestinationDatabase = "DestinationDB",
[string]$OutputFolder = "H:\Z"
)


$SourceServer        = "dgpap1"
$SourceDatabase      = "S1"
$DestinationServer   = "dgpap2"
$DestinationDatabase = "D1"
$OutputFolder        = "H:\Z"
$tablediff = "C:\Program Files\Microsoft SQL Server\110\COM\tablediff.exe"
$Tables='CompareTable1','CompareTable'

 #create output folder if it does not exist
if ((Test-Path $OutputFolder) -eq $false)
{
md $OutputFolder
}
 
#Output file
$OutputFile = $OutputFolder+"\Output.txt"
 
#for each table
foreach($table in $Tables)
{ #p133
#create new file name for the Transact-SQL script file
$DiffScript = $OutputFolder+"\"+$table+".sql"

#If file exists throw the errror.
if ((Test-Path $DiffScript) -eq $true)
{
throw "The file " + $DiffScript + " already exists."
}
 
#execute tablediff
#& $tablediff -sourceserver $SourceServer -sourcedatabase $SourceDatabase -sourcetable $table.Name -destinationserver $DestinationServer -destinationdatabase $DestinationDatabase -destinationtable $table.Name -strict -c -o $OutputFile -f $DiffScript

& $tablediff -sourceserver $SourceServer -SourceDatabase $SourceDatabase -sourcetable $table `
 -destinationserver $DestinationServer -destinationdatabase $DestinationDatabase -destinationtable $table `
 -strict -c -o $OutputFile -f $DiffScript

# check the return value and throw an exception if needed
# tablediff return values: 0 - Success, 1 - Critical error, 2 - Table differences
if ($LastExitCode -eq 1)
{
throw "Error on table " + $table.Name + " with exit code $LastExitCode"
}

}  #p133


##
$x=& $tablediff -sourceserver $SourceServer -SourceDatabase $SourceDatabase -sourcetable $table -destinationserver $DestinationServer -destinationdatabase $DestinationDatabase -destinationtable $table  # -strict -c -o $OutputFile -f $DiffScript

##
& $tablediff -sourceserver $SourceServer -SourceDatabase $SourceDatabase -sourcetable $table `
 -destinationserver $DestinationServer -destinationdatabase $DestinationDatabase -destinationtable $table `
 -strict -c -dt  -et result  #指定要建立的結果資料表名稱 放在 destination Instance

  #>}

#---------------------------------------------------------------
# 1500 99  Built-in Functions TSQL
#---------------------------------------------------------------
#{<#  
 http://msdn.microsoft.com/en-us/library/ms174318.aspx

Types of Functions  (Rowset Functions,Aggregate Functions,Ranking Functions)
Scalar Functions   
    Configuration Functions

    Conversion Functions  http://msdn.microsoft.com/en-us/library/hh231076.aspx

    Cursor Functions

    Date and Time Data Types and Functions  :http://msdn.microsoft.com/en-us/library/ms186724.aspx

    Logical Functions

    Mathematical Functions

    Metadata Functions

    Security Functions

    String Functions

    System Functions

    System Statistical Functions

    Text and Image Functions
#-------------------------------------------------------------------------------------------------

#### <<<<<<<<<<<<<<<<<<<<<< Conversion Functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


## SQL 2012   TRY_CONVERT ( data_type [ ( length ) ], expression [, style ] )

select folderGroup, sum(TRY_CONVERT(float,foldersize)) from   [dbo].[FolderBackupLOG] 
group by folderGroup

SELECT 
    CASE WHEN TRY_CONVERT(float, 'test') IS NULL 
    THEN 'Cast failed'
    ELSE 'Cast succeeded'
END AS Result;
GO


SELECT DISTINCT p.Name  ,CAST(p.Name AS char(10)) AS [Name with Cast], s.UnitPrice
FROM Sales.SalesOrderDetail AS s 
JOIN Production.Product AS p  ON s.ProductID = p.ProductID
WHERE Name LIKE 'Long-Sleeve Logo Jersey, M';
GO
'
Name	                    Name with Cast	UnitPrice
Long-Sleeve Logo Jersey, M	Long-Sleev	    27.4945
'

select p.FirstName, p.LastName, s.SalesYTD,CAST(CAST(s.SalesYTD AS int) AS char(20)) as[int to Str]
FROM Person.Person AS p 
JOIN Sales.SalesPerson AS s 
    ON p.BusinessEntityID = s.BusinessEntityID 
	WHERE CAST(CAST(s.SalesYTD AS int) AS char(20)) LIKE '2%';
GO
'FirstName	LastName	SalesYTD	  int to Str
  Tsvi	    Reiter	    2315185.611  	2315186     '



SELECT CONVERT(char(8), 0x4E616D65, 0) AS [Style 0, binary to character]; --Name
SELECT CONVERT(char(8), 0x4E616D65, 1) AS [Style 1, binary to character]; --0x4E616D
SELECT CONVERT(binary(8), 'Name', 0)           AS [Style 0, character to binary]; --0x4E616D6500000000
SELECT CONVERT(binary(4), '0x4E616D65', 1)     AS [Style 1, character to binary]; --0x4E616D65






#### <<<<<<<<<<<<<<<<<<<<<< DATEDIFF,dateadd >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SELECT DATEDIFF(MINUTE,modtime,getdate()) ,modtime ,getdate() AS 'Duration'
FROM dgpap2.d1.dbo.p where b02idno='c';

declare @rm  datetime,@rm2  datetime  , @idno varchar(10)
select @rm=modtime ,@rm2=modtime FROM dgpap2.d1.dbo.p where b02idno='c'
select  dateadd(MINUTE,7,@rm),@rm2,@idno


declare @rm  datetime,@rm2  datetime ,@rm3  datetime   , @idno varchar(10)
select  @rm3=dateadd(MINUTE,7,modtime),@rm2=modtime  FROM dgpap2.d1.dbo.p where b02idno='c'
if   @rm3  < @rm2
begin
select  @rm3,@rm2,'yes'
end

####  <<<<<<<<<<<<<<<<<<<<<<  Date and Time Data Types and Functions  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    SELECT SYSDATETIME()
    ,SYSDATETIMEOFFSET()
    ,SYSUTCDATETIME()
    ,CURRENT_TIMESTAMP
    ,GETDATE()
    ,GETUTCDATE();
/* Returned:
SYSDATETIME()      2007-04-30 13:10:02.0474381
SYSDATETIMEOFFSET()2007-04-30 13:10:02.0474381 -07:00
SYSUTCDATETIME()   2007-04-30 20:10:02.0474381
CURRENT_TIMESTAMP  2007-04-30 13:10:02.047
GETDATE()          2007-04-30 13:10:02.047
GETUTCDATE()       2007-04-30 20:10:02.047
#
SELECT CONVERT (time, SYSDATETIME())
    ,CONVERT (time, SYSDATETIMEOFFSET())
    ,CONVERT (time, SYSUTCDATETIME())
    ,CONVERT (time, CURRENT_TIMESTAMP)
    ,CONVERT (time, GETDATE())
    ,CONVERT (time, GETUTCDATE());

/* Returned
SYSDATETIME()      13:18:45.3490361
SYSDATETIMEOFFSET()13:18:45.3490361
SYSUTCDATETIME()   20:18:45.3490361
CURRENT_TIMESTAMP  13:18:45.3470000
GETDATE()          13:18:45.3470000
GETUTCDATE()       20:18:45.3470000
*/

## Date , DateTime Time to string
select CONVERT(nvarchar(40), GETDATE(), 0)   --Aug 20 2014  3:54PM
select CONVERT(nvarchar(40), GETDATE(), 101) --08/20/2014
select CONVERT(nvarchar(40), GETDATE(), 102) --2014.08.20
select CONVERT(nvarchar(40), GETDATE(), 103) --20/08/2014
select CONVERT(nvarchar(40), GETDATE(), 104) --20.08.2014
select CONVERT(nvarchar(40), GETDATE(), 105) --20-08-2014
select CONVERT(nvarchar(40), GETDATE(), 106) --20 Aug 2014
select CONVERT(nvarchar(40), GETDATE(), 107) --Aug 20, 2014
select CONVERT(nvarchar(40), GETDATE(), 108) --15:56:08
select CONVERT(nvarchar(40), GETDATE(), 109) --Aug 20 2014  3:56:08:863PM
select CONVERT(nvarchar(40), GETDATE(), 110) --08-20-2014
select CONVERT(nvarchar(40), GETDATE(), 120) --2014-08-20 15:56:27
select CONVERT(nvarchar(40), GETDATE(), 121) --2014-08-20 15:56:27.133
select CONVERT(nvarchar(40), GETDATE(), 126) --2014-08-20T15:56:42.707
select CONVERT(nvarchar(40), GETDATE(), 127) --2014-08-20T15:56:42.707
select CONVERT(nvarchar(40), GETDATE(), 130) --24 شوال 1435  3:56:42:707PM
select CONVERT(nvarchar(40), GETDATE(), 131) --24/10/1435  3:56:42:707PM


## String to Date , DateTime Time
select Cast('2014-08-20 12:12:12.1234567' as datetime2)   --2014-08-20 12:12:12.1234567
select Cast('2014-08-20 12:12:12.1234567' as datetime2(1))--2014-08-20 12:12:12.1
select Cast('2014-08-20 12:12:12.1234567' as datetime2(2))--2014-08-20 12:12:12.12
select Cast('2014-08-20 12:12:12.1234567' as datetime2(3))--2014-08-20 12:12:12.123
select Cast('2014-08-20 12:12:12.1234567' as datetime2(4))--2014-08-20 12:12:12.1235
select Cast('2014-08-20 12:12:12.1234567' as date)        --2014-08-20
select Cast('2014-08-20 12:12:12.1234567' as datetime2)   --2014-08-20 12:12:12.1234567
select Cast('2014-08-20 12:12:12.1234567' as datetime2(1))--2014-08-20 12:12:12.1
select Cast('2014-08-20 12:12:12.1234567' as datetime2(2))--2014-08-20 12:12:12.12
select Cast('2014-08-20 12:12:12.1234567' as datetime2(3))--2014-08-20 12:12:12.123
select Cast('2014-08-20 12:12:12.1234567' as datetime2(4))--2014-08-20 12:12:12.1235

--設定時間與周數的變數

DECLARE @mdatetime nvarchar(19),@weektime nvarchar(2)

--取得yyyyMM的日期格式
select @mdatetime = substring(CONVERT(nvarchar,getdate(),112),1,10)

--取得目前是第幾周
--select @weektime = datepart(wk, getdate())





####  <<<<<<<<<<<<<<<<<<<<<< String >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##String gs  https://msdn.microsoft.com/zh-tw/library/ms181984.aspx?f=255&MSPPError=-2147217396
#---

#-ASCII  ASCII ( character_expression )  select ASCII ('v')
    {<
    SET TEXTSIZE 0;
SET NOCOUNT ON;
-- Create the variables for the current character string position 
-- and for the character string.
DECLARE @position int, @string char(15);
-- Initialize the variables.
SET @position = 1;
SET @string = 'Du monde entier';
WHILE @position <= DATALENGTH(@string)
   BEGIN
   SELECT ASCII(SUBSTRING(@string, @position, 1)),
      CHAR(ASCII(SUBSTRING(@string, @position, 1)))
    SET @position = @position + 1
   END;
SET NOCOUNT OFF;
GO
>}
#-CHAR  int ASCII 碼轉換成字元

#-CHARINDEX   CHARINDEX ( expressionToFind ,expressionToSearch [ , start_location ] ) 
{<
DECLARE @document varchar(64);
SELECT @document = '123456ming' +
                   'abcdefgvanessa';
SELECT CHARINDEX('ming', @document);      --7 
SELECT CHARINDEX('vanessa', @document);  --18
GO
>}


#-CONCAT 回串連兩個以上之字串值的結果字串。 CONCAT ( string_value1, string_value2 [, string_valueN ] )

#-DIFFERENCE   DIFFERENCE ( character_expression , character_expression )

#-FORMAT 
   針對不同文化特性格式化的簡單日期
   {<DECLARE @d DATETIME = '10/01/2011';
SELECT FORMAT ( @d, 'd', 'en-US' ) AS 'US English Result'
      ,FORMAT ( @d, 'd', 'en-gb' ) AS 'Great Britain English Result'
      ,FORMAT ( @d, 'd', 'de-de' ) AS 'German Result'
      ,FORMAT ( @d, 'd', 'zh-cn' ) AS 'Simplified Chinese (PRC) Result'; 
  
SELECT FORMAT ( @d, 'D', 'en-US' ) AS 'US English Result'
      ,FORMAT ( @d, 'D', 'en-gb' ) AS 'Great Britain English Result'
      ,FORMAT ( @d, 'D', 'de-de' ) AS 'German Result'
      ,FORMAT ( @d, 'D', 'zh-cn' ) AS 'Chinese (Simplified PRC) Result'; >}
      指定自訂格式顯示格式數值
      {<-- Current date is September 27 2012.
DECLARE @d DATETIME = GETDATE();
SELECT FORMAT( @d, 'dd/MM/yyyy', 'en-US' ) AS 'DateTime Result'
       ,FORMAT(123456789,'###-##-####') AS 'Custom Number Result';>}
#-LEFT  傳回字元字串含指定字元數的左側部分。 LEFT ( character_expression , integer_expression )

#-LEN  傳回指定字串運算式的字元數，但尾端空白不算。LEN ( string_expression )

#-LOWER

#-LTRIM  傳回移除開頭空白的字元運算式。 LTRIM ( character_expression )

#-NCHAR Unicode 標準所定義，傳回含指定之整數碼的 Unicode 字元  ;NCHAR ( integer_expression )

#-PATINDEX 傳回指定之運算式中的模式，在所有有效文字和字元資料類型中第一次出現的起始位置，如果找不到模式，便傳回零。 PATINDEX ( '%pattern%' , expression )
           使用變數，將值傳遞給 pattern 參數
           {<DECLARE @MyValue varchar(10) = 'safety'; 
SELECT PATINDEX('%' + @MyValue + '%', DocumentSummary) 
FROM Production.Document
WHERE DocumentNode = 0x7B40;
           >}
           指定的字串中 (索引從 1 開始)，使用 % 和 _ 萬用字元來尋找模式 'en' 後面接著任何一個字元和 'ure' 的開始位置：
           {<
           SELECT PATINDEX('%en_ure%', 'please ensure the door is locked');
           -----------
           8
           >}

#-QUOTENAME  傳回 Unicode 字串，且附加了分隔符號，以便使輸入字串成為有效的 SQL Server 分隔識別碼。 QUOTENAME ( 'character_string' [ , 'quote_character' ] ) 
      元字串 abc[]def，且利用 [ 和 ] 字元來建立有效的 SQL Server 分隔識別碼。
      {<
      SELECT QUOTENAME('abc[]def');
      >}
#-REPLACE REPLACE ( string_expression , string_pattern , string_replacement )

#-REPLICATE  將字串值重複指定的次數。 REPLICATE ( string_expression ,integer_expression ) 
   
   下列範例會在數值資料類型轉換成字元或 Unicode 時，填補到指定的長度。
   {<
   IF EXISTS(SELECT name FROM sys.tables
      WHERE name = 't1')
   DROP TABLE t1;
GO
CREATE TABLE t1 
(
 c1 varchar(3),
 c2 char(3)
);
GO
INSERT INTO t1 VALUES ('2', '2'), ('37', '37'),('597', '597');
GO
SELECT REPLICATE('0', 3 - DATALENGTH(c1)) + c1 AS 'Varchar Column',
       REPLICATE('0', 3 - DATALENGTH(c2)) + c2 AS 'Char Column'
FROM t1;
GO
>}

    下列範例會在 AdventureWorks2012 資料庫中的產品線代碼前面重複 0 字元四次。
   {<
   SELECT [Name]
, REPLICATE('0', 4) + [ProductLine] AS 'Line Code'
FROM [Production].[Product]
WHERE [ProductLine] = 'T'
ORDER BY [Name];
GO
   >}

#-REVERSE 傳回字串值的反轉順序。  REVERSE ( string_expression )
    SELECT FirstName, REVERSE(FirstName) AS Reverse
#-RIGHT  傳回指定字元數之字元字串的右側部分。 RIGHT ( character_expression , integer_expression )
     AdventureWorks2012 資料庫中每個人名字最右邊的五個字元
    {<SELECT RIGHT(FirstName, 5) AS 'First Name'
FROM Person.Person
WHERE BusinessEntityID < 5
ORDER BY FirstName;
GO
    >}
#-RTRIM  傳回截斷所有尾端空白的字元字串。


#-SOUNDEX  傳回四個字元的 (SOUNDEX) 代碼來評估兩個字串的相似度。
    修剪姓氏，並且將逗號、兩個空格以及 AdventureWorks2012 之 Person 資料表所列人員的名字串連起來
    {<
    USE AdventureWorks2012;
GO
SELECT RTRIM(LastName) + ',' + SPACE(2) +  LTRIM(FirstName)
FROM Person.Person
ORDER BY LastName, FirstName;
GO
    >}

#-SPACE   傳回重複空格的字串。  SPACE ( integer_expression )

#-STR  傳回從數值資料轉換而來的字元資料 Returns character data converted from numeric data.。  STR ( float_expression [ , length [ , decimal ] ] )
    將五個位數和小數點組成的運算式轉換成六個位數的字元字串。 數字的小數點後部份會捨入到一個小數位數
{<
SELECT STR(123.45, 6, 1);
GO
>}

#-STUFF STUFF 函數會將字串插入另一個字串。 它會在第一個字串的開始位置刪除指定長度的字元，然後將第二個字串插入第一個字串的開始位置
  STUFF ( character_expression , start , length , replaceWith_expression )
  會傳回從第一個字串 (abcdef) 中，從位置 2 (b) 開始，刪除三個字元所建立的字元字串，且會在刪除點插入第二個字串
  {<
  SELECT STUFF('abcdef', 2, 3, 'ijklmn');
  GO
  --------- 
  aijklmnef 
  >}


#-SUBSTRING    SUBSTRING ( expression ,start , length )   ex SUBSTRING(checkresult,0,120)
#-UNICODE  依照 Unicode 標準所定義，傳回輸入運算式第一個字元的整數值。 UNICODE ( 'ncharacter_expression' )
#-UPPER



#>}

#---------------------------------------------------------------
# 1500   Control-of-Flow Language TSQL
#---------------------------------------------------------------
{<#
BEGIN
     { 
    sql_statement | statement_block 
     } 
END

#---------------WAITFOR------------------------------
WAITFOR 
{
    DELAY 'time_to_pass' 
  | TIME 'time_to_execute' 
  | [ ( receive_statement ) | ( get_conversation_group_statement ) ] 
    [ , TIMEOUT timeout ]
}
#
EXECUTE sp_add_job @job_name = 'TestJob';
BEGIN
    WAITFOR TIME '22:20';
    EXECUTE sp_update_job @job_name = 'TestJob',@new_name = 'UpdatedJob';
END;
GO
#
BEGIN
    WAITFOR DELAY '02:00';
    EXECUTE sp_helpdb;
END;
GO
#
IF OBJECT_ID('dbo.TimeDelay_hh_mm_ss','P') IS NOT NULL
    DROP PROCEDURE dbo.TimeDelay_hh_mm_ss;
GO
CREATE PROCEDURE dbo.TimeDelay_hh_mm_ss 
    (
    @DelayLength char(8)= '00:00:00'
    )
AS
DECLARE @ReturnInfo varchar(255)
IF ISDATE('2000-01-01 ' + @DelayLength + '.000') = 0
    BEGIN
        SELECT @ReturnInfo = 'Invalid time ' + @DelayLength 
        + ',hh:mm:ss, submitted.';
        -- This PRINT statement is for testing, not use in production.
        PRINT @ReturnInfo 
        RETURN(1)
    END
BEGIN
    WAITFOR DELAY @DelayLength
    SELECT @ReturnInfo = 'A total time of ' + @DelayLength + ', hh:mm:ss, has elapsed! Your time is up.'
    -- This PRINT statement is for testing, not use in production.
    PRINT @ReturnInfo;
END;
GO
/* This statement executes the dbo.TimeDelay_hh_mm_ss procedure. */
EXEC TimeDelay_hh_mm_ss '00:00:10';
GO

#-------------WHILE----------------------------------
WHILE Boolean_expression 
     { sql_statement | statement_block | BREAK | CONTINUE } 
#
USE AdventureWorks2012;
GO
WHILE (SELECT AVG(ListPrice) FROM Production.Product) < $300
BEGIN
   UPDATE Production.Product
      SET ListPrice = ListPrice * 2
   SELECT MAX(ListPrice) FROM Production.Product
   IF (SELECT MAX(ListPrice) FROM Production.Product) > $500
      BREAK
   ELSE
      CONTINUE
END
PRINT 'Too much for the market to bear';
#
DECLARE Employee_Cursor CURSOR FOR
SELECT EmployeeID, Title 
FROM AdventureWorks2012.HumanResources.Employee
WHERE JobTitle = 'Marketing Specialist';
OPEN Employee_Cursor;
FETCH NEXT FROM Employee_Cursor;
WHILE @@FETCH_STATUS = 0
   BEGIN
      FETCH NEXT FROM Employee_Cursor;
   END;
CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;
GO
#

#>}

#---------------------------------------------------------------
#  1801    Group having
#---------------------------------------------------------------
{<#
SELECT DATEPART(yyyy,OrderDate) AS N'Year',SUM(TotalDue) AS N'Total Order Amount'
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(yyyy,OrderDate)
HAVING DATEPART(yyyy,OrderDate) >= N'2003'
ORDER BY DATEPART(yyyy,OrderDate);
#>}




#---------------------------------------------------------------
#   1815  TSQL Trigger DML
#---------------------------------------------------------------
{<#
if exists (select * from sys.objects name where name='B02insert_trigger' )
begin
 drop trigger B02insert_trigger
end
go

create trigger Employee_trigger
on Employees
after UPDATE, INSERT, DELETE
as
declare @EmpID int,@user varchar(20), @activity varchar(20);
if exists(SELECT * from inserted) and exists (SELECT * from deleted)
begin
    SET @activity = 'UPDATE';
    SET @user = SYSTEM_USER;
    SELECT @EmpID = EmployeeID from inserted i;
    INSERT into Emp_Audit(EmpID,Activity, DoneBy) values (@EmpID,@activity,@user);
endIf exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @activity = 'INSERT';
    SET @user = SYSTEM_USER;
    SELECT @EmpID = EmployeeID from inserted i;
    INSERT into Emp_Audit(EmpID,Activity, DoneBy) values(@EmpID,@activity,@user);
end
If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @activity = 'DELETE';
    SET @user = SYSTEM_USER;
    SELECT @EmpID = EmployeeID from deleted i;
    INSERT into Emp_Audit(EmpID,Activity, DoneBy) values(@EmpID,@activity,@user);
end

Pasted from <http://stackoverflow.com/questions/20205639/insert-delete-update-trigger-in-sql-server> 
#>}


#---------------------------------------------------------------
#  1865   釋出所有快取  release cache on memory
#---------------------------------------------------------------
#{<# 

https://msdn.microsoft.com/zh-tw/library/ms178529.aspx
#--釋出前
select physical_memory_in_use_kb,process_physical_memory_low,total_virtual_address_space_kb,process_virtual_memory_low,GETDATE() as getDate
--into perfprocessmemory
from sys.dm_os_process_memory

----DBCC FREESYSTEMCACHE
　　　DBCC FREESYSTEMCACHE ('ALL') WITH MARK_IN_USE_FOR_REMOVAL;
DBCC FREESYSTEMCACHE ('ALL');
--DBCC FREESESSIONCACHE
--DBCC FREEPROCCACHE

--DBCC DROPCLEANBUFFERS 
dbcc dropcleanbuffers
--DBCC FLUSHPROCINDB -- clears execution plans for that database
#--釋出後再觀察
select physical_memory_in_use_kb,process_physical_memory_low,total_virtual_address_space_kb,process_virtual_memory_low,GETDATE() as getDate
--into perfprocessmemory
from sys.dm_os_process_memory

# 但因SQL OS 沒有將memory 還給 Windows OS 最後執行

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'max server memory', 12000; -- 12G memory 
GO
RECONFIGURE;
GO


sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'max server memory', 2147483647; --設為無限
GO
RECONFIGURE;
GO


#>}

#---------------------------------------------------------------
#  1971   Automated Script generation   ScriptTransfer
#---------------------------------------------------------------
https://www.simple-talk.com/sql/database-administration/automated-script-generation-with-powershell-and-smo/

$Filepath='C:\Temp3' # local directory to save build-scripts to
$DataSource='sp2013' # server name and instance
$Database='AdventureWorks2014'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $true # this only goes to the file
$transfer.Options.ToFileOnly = $true # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database)_Build.sql"; 
$transfer.ScriptTransfer() 
"All done"


#
#   databasescriptWithOptions  以下會比較有用. 增加產生物件(Object)內其它的 Script
#

$Filepath='E:\MyScriptsDirectory' # local directory to save build-scripts to
$DataSource='MyServer' # server name and instance
$Database='MyDatabase'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$CreationScriptOptions = new-object ("$My.ScriptingOptions") 
$CreationScriptOptions.ExtendedProperties= $true # yes, we want these
$CreationScriptOptions.DRIAll= $true # and all the constraints 
$CreationScriptOptions.Indexes= $true # Yup, these would be nice
$CreationScriptOptions.Triggers= $true # This should be included when scripting a database
$CreationScriptOptions.ScriptBatchTerminator = $true # this only goes to the file
$CreationScriptOptions.IncludeHeaders = $true; # of course
$CreationScriptOptions.ToFileOnly = $true #no need of string output as well
$CreationScriptOptions.IncludeIfNotExists = $true # not necessary but it means the script can be more versatile
$CreationScriptOptions.Filename =  "$($FilePath)\$($Database)_Build.sql"; 
$transfer = new-object ("$My.Transfer") $s.Databases[$Database]

$transfer.options=$CreationScriptOptions # tell the transfer object of our preferences
$transfer.ScriptTransfer()
"All done"







#---------------------------------------------------------------
#   1999   Getting database settings and object drops into a database-script  part 1
#---------------------------------------------------------------
 # set "Option Explicit" to catch subtle errors 
set-psdebug -strict
$DirectoryToSaveTo='e:\MyScriptsDirectory\' # local directory to save build-scripts to
$servername='MyServer' # server name and instance
$Database='MyDatabase' # the database to copy from
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
 
Trap {
# Handle the error
$err = $_.Exception
write-host $err.Message
while( $err.InnerException ) {
   $err = $err.InnerException
   write-host $err.Message
   };
# End the script.
break
}
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$v = [System.Reflection.Assembly]::LoadWithPartialName( 'Microsoft.SqlServer.SMO')
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMOExtended') | out-null
   }
$My='Microsoft.SqlServer.Management.Smo'
$s = new-object ("$My.Server") $ServerName # get the server.
$Server=$s.netname -replace '[\\\/\:\.]',' ' # remove characters that can cause problems
$instance = $s.instanceName -replace '[\\\/\:\.]',' ' # ditto
$DatabaseName =$database -replace '[\\\/\:\.]',' ' # ditto
 
$DirectoryToSaveTo=$DirectoryToSaveTo+$Server+'\'+$Instance+'\' # database scripts are local on client
if (!( Test-Path -path "$DirectoryToSaveTo" )) # create it if not existing
       {$progress ="attempting to create directory $DirectoryToSaveTo"
              Try { New-Item "$DirectoryToSaveTo" -type directory | out-null } 
             Catch [system.exception]{
       Write-Error "error while $progress. $_"
                return
                } 
           }
<# now we will use the canteen system of SMO to specify what we want from the script. It is best to have a list of the defaults to hand and just override the defaults where necessary, but there is a chance that a later revision of SMO could change the defaults, so beware! #>
$CreationScriptOptions = new-object ("$My.ScriptingOptions") 
$CreationScriptOptions.ExtendedProperties= $true # yes, we want these
$CreationScriptOptions.DRIAll= $true # and all the constraints 
$CreationScriptOptions.Indexes= $true # Yup, these would be nice
$CreationScriptOptions.Triggers= $true # This should be included when scripting a database
$CreationScriptOptions.ScriptBatchTerminator = $true # this only goes to the file
$CreationScriptOptions.Filename = "$($DirectoryToSaveTo)$($DatabaseName)_Build.sql"; 
# we have to write to a file to get the GOs
$CreationScriptOptions.IncludeHeaders = $true; # of course
$CreationScriptOptions.ToFileOnly = $true # no need of string output as well
$CreationScriptOptions.IncludeIfNotExists = $true # not necessary but it means the script can be more versatile
$transfer = new-object ("$My.Transfer") $s.Databases[$Database]
$transfer.options=$CreationScriptOptions # tell the transfer object of our preferences
$scripter = new-object ("$My.Scripter") $s # script out the database creation
$scripter.options=$CreationScriptOptions # with the same options
$scripter.Script($s.Databases[$Database]) # do it
"USE $Database" | Out-File -Append -FilePath "$($DirectoryToSaveTo)$($DatabaseName)_Build.sql"
"GO" | Out-File -Append -FilePath "$($DirectoryToSaveTo)$($DatabaseName)_Build.sql"
# add the database object build script
$transfer.options.AppendToFile=$true
$transfer.options.ScriptDrops=$true
$transfer.EnumScriptTransfer()
$transfer.options.ScriptDrops=$false
$transfer.EnumScriptTransfer()
"All written to $($DirectoryToSaveTo)$($DatabaseName)_Build.sql"



##
#   databasescript.ps1
#
$Filepath='E:\MyScriptsDirectory' # local directory to save build-scripts to
$DataSource='MyServer' # server name and instance
$Database='MyDatabase'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $true # this only goes to the file
$transfer.Options.ToFileOnly = $true # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database)_Build.sql"; 
$transfer.ScriptTransfer() 
"All done"

#---------------------------------------------------------------
# part 2    Getting database settings and object drops into a database-script
#---------------------------------------------------------------


$ServerName='SP2013'# the server it is on
$Database='AdventureWorks2014' # the name of the database you want to script as objects
$DirectoryToSaveTo='C:\Temp3SP2013' # the directory where you want to store them
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries


$v = [System.Reflection.Assembly]::LoadWithPartialName( 'Microsoft.SqlServer.SMO')

if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
  [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMOExtended') | out-null
  }
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SmoEnum') | out-null
set-psdebug -strict # catch a few extra bugs
$ErrorActionPreference = "stop"
$My='Microsoft.SqlServer.Management.Smo'

#$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName   #這2行是相同
$srv    = new-object ("$My.Server") $ServerName #attach to the server

if ($srv.ServerType-eq $null) #if it managed to find a server
	{
  Write-Error "Sorry, but I couldn't find Server '$ServerName' "
  return
  }  
$scripter = new-object ("$My.Scripter") $srv #create the scripter
$scripter.Options.ToFileOnly = $true 
#we now get all the object types except extended stored procedures
# first we get the bitmap of all the object types we want 
$all =[long] [Microsoft.SqlServer.Management.Smo.DatabaseObjectTypes]::all `
    -bxor [Microsoft.SqlServer.Management.Smo.DatabaseObjectTypes]::ExtendedStoredProcedure
#and we store them in a datatable
$d = new-object System.Data.Datatable
#get everything except the servicebroker object, the information schema and system views
$d=$srv.databases[$Database].EnumObjects([long]0x1FFFFFFF -band $all) | `
    Where-Object {$_.Schema -ne 'sys'-and $_.Schema -ne "information_schema" -and $_.DatabaseObjectTypes -ne 'ServiceBroker'}
#and write out each scriptable object as a file in the directory you specify
$d| FOREACH-OBJECT { #for every object we have in the datatable.
	 $SavePath="$($DirectoryToSaveTo)\$($_.DatabaseObjectTypes)"
	# create the directory if necessary (SMO Doesn't).
	if (!( Test-Path -path $SavePath )) #create it if not existing
		{Try { New-Item $SavePath -type directory | out-null }  
	    Catch [system.exception]{
		      Write-Error "error while creating '$SavePath'  $_"
	         return
	          }  
	    }
	  #tell the scripter object where to write it
	 $scripter.Options.Filename = "$SavePath\$($_.name -replace  '[\\\/\:\.]','-').sql";
	 # Create a single element URN array
    $UrnCollection = new-object ('Microsoft.SqlServer.Management.Smo.urnCollection')
	 $URNCollection.add($_.urn)
	 #and write out the object to the specified file
    $scripter.script($URNCollection)
}
"Oh wide one, All is written out!"