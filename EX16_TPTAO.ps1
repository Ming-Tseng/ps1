<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX16_TPTAO.ps1
TCreateDate: MAR.17.2016LastDate  : MAR.19.2016Author :Ming Tseng  ,a0921887912@gmail.com  ming_tseng@syscom.com.twremark 

stakeholder: 
tao_james@mail.taipei.gov.tw
Carrie_Chuang@syscom.com.tw
tao_yun@mail.taipei.gov.tw


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\EX16_TPTAO.ps1

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

#>

________________________________________________________________________________________________________________________________________

#00  base info
#01  Add-WindowsFeature PowerShell-ISE
#02  74 enable winrm & configuation
#03  109  get systeminfo
#04  139  get Disk
#05  173  get install product
#06  185  get services 
#07  197  get firewall rule 
#08  230　get SQL master_files
#09  246  get SQL version
#10  269  get SQL Job
#11  291 　get SQL databaseinfo
#12  312 　get SQL serverinfo
#13  333 　get SQL backup 
#14  360  get SQL SSIS  packages 
#15  get  Host performance
#16  453 step1  General script  at  A  & B SQLServer 
#17  567 　稽核 Audit for  Server level
#18  680 　稽核 Audit for  Database level
#19  763 　稽核 Audit 分析


#-----------------------------------
#00  base info
#-----------------------------------
$infoPath ='H:\'
$env:COMPUTERNAME  
COM-DB-SQL1   10.150.100.1
COM-DB-SQL2   10.150.100.2
COM-DB-SQL3   10.150.100.3


$servers='COM-DB-SQL1','COM-DB-SQL2','COM-DB-SQL3','COM-DB-SQL5','COM-DB-SQL6','COM-DB-SQL7'
$servers='sp2013','PMD','sql2012x','2016BI'


$username = 'PMD\administrator'
$password = 'p@ssw0rd'


$PSVersionTable
<#
Name                           Value                                                      
----                           -----                                                      
CLRVersion                     2.0.50727.4927                                             
BuildVersion                   6.1.7600.16385                                             
PSVersion                      2.0                                                        
WSManStackVersion              2.0                                                        
PSCompatibleVersions           {1.0, 2.0}                                                 
SerializationVersion           1.1.0.1                                                    
PSRemotingProtocolVersion      2.1 

http://learn-powershell.net/2013/10/25/powershell-4-0-now-available-for-download/

Name                           Value                                                                                                                                     
----                           -----                                                                                                                                     
PSVersion                      4.0                                                                                                                                       
WSManStackVersion              3.0                                                                                                                                       
SerializationVersion           1.1.0.1                                                                                                                                   
CLRVersion                     4.0.30319.34014                                                                                                                           
BuildVersion                   6.3.9600.17400                                                                                                                            
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0}                                                                                                                      
PSRemotingProtocolVersion      2.2                                                                                                                                       
#>

#-----------------------------------
#01  Add-WindowsFeature PowerShell-ISE
#-----------------------------------
Import-Module ServerManager 
Add-WindowsFeature PowerShell-ISE

 Set-ExecutionPolicy RemoteSigned


#-----------------------------------
#02  74 enable winrm & configuation
#-----------------------------------
notepad  C:\Windows\System32\drivers\etc\hosts    add:  172.16.201.147          PMD

telnet  PMD  5985 # pass

Enable-PSRemoting   # Note: firewall port  5985 
Get-counter  use port
#Disable-PSRemoting


# if the remote computer is not in a trusted domain, 將  目標電腦(被控台(PMD))新增到 主控台(SP2013TrustedHosts 組態設定中
winrm qc # if need  run at COM-DB-SQLx
winrm e winrm/config/listener

winrm e winrm/config/listener
winrm set   winrm/config/client @{TrustedHosts="COM-DB-SQL1,COM-DB-SQL2,COM-DB-SQL3,COM-DB-SQL5,COM-DB-SQL6,COM-DB-SQL9,PMD"}  

#run sp2013
winrm set  winrm/config/client @{TrustedHosts="COM-DB-SQL1,COM-DB-SQL2,COM-DB-SQL3,COM-DB-SQL5,COM-DB-SQL6,COM-DB-SQL9,PMD2016"}  

winrm g winrm/config # get TrustedHosts

Test-WSMan -ComputerName PMD2016
Test-WSMan -ComputerName PMD

<#
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 2.0
#>
ping PMD2016  #  192.168.112.144
gps -ComputerName PMD2016
gps -ComputerName 192.168.112.144

icm -ComputerName PMD2016 -ScriptBlock {Stop-Process 12420}

gps -ComputerName PMD
get-counter -ComputerName 192.168.112.144
get-counter -ComputerName PMD2016
get-counter '\\192.168.112.144\\physicaldisk(_total)\% disk time'



gwmi Win32_Service  -ComputerName PMD2016 |select name 
gwmi Win32_Service  -ComputerName 192.168.112.144 |select name 


ping PMD

icm -ComputerName PMD2016 -ScriptBlock {hostname} #|out-file 


#-----------------------------------
#03  109  get systeminfo
#-----------------------------------
$infoPath ='H:\'
$reportfile=$infoPath+'CIB_SYSTEMINFO.txt'
$username = 'PMD\administrator'
$password = 'p@ssw0rd'

$servers='sp2013','PMD','sql2012x','2016BI'
$servers='sp2013','sql2012x','2016BI'
ri $reportfile
# case 1

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList @($username,(ConvertTo-SecureString -String $password -AsPlainText -Force))

Invoke-Command -ComputerName $servers -Credential $cred -ScriptBlock  {systeminfo}  | Out-File $reportfile -Append
Invoke-Command -ComputerName $servers  -ScriptBlock  {systeminfo} | Out-File $reportfile -Append ;ii $reportfile

# case 2
$infoPath ='H:\'
$reportfile=$infoPath+'CIB_Win32_OperatingSystem.txt'
$username = 'PMD\administrator'
$password = 'p@ssw0rd'
ri $reportfile
gwmi   Win32_OperatingSystem  -comp $servers |select * | Out-File $reportfile -Append  ;ii 

get-wmiobject Win32_OperatingSystem  ; $computerOS |select * 

#-----------------------------------
#04  139  get Disk
#-----------------------------------


$reportfile=$infoPath+'CIB_DISK.txt'
ri $reportfile
gwmi -ComputerName $servers -Class Win32_Volume | sort systemname,DriveLetter |`
select @{N="systemName";E={$_.systemname}} `
,@{N="Name";E={$_.Name}} `
,@{N="DriveLetter";E={$_.DriveLetter}} `
,@{N="DeviceType";E={switch ($_.DriveType){0 {"Unknown"}
1 {"No Root Directory"}
2 {"Removable Disk"}
3 {"Local Disk"}
4 {"Network Drive"}
5 {"Compact Disk"}
6 {"RAM"}
}};} `
,@{N="Size(GB)";E={"{0:N1}" -f($_.Capacity/1GB)}}`
,@{N="FreeSpace(GB)";E={"{0:N1}" -f($_.FreeSpace/1GB)}} `
,@{N="FreeSpacePercent";E={if ($_.Capacity -gt 0){"{0:P0}" -f($_.FreeSpace/$_.Capacity)}else{0}}} `
 |Format-Table -AutoSize |Out-File  $reportfile
 ii $reportfile






#-----------------------------------
#05  173  get install product
#-----------------------------------

$reportfile=$infoPath+'CIB_Win32_Product.txt'
ri $reportfile
gwmi -Class Win32_Product -ComputerName  $servers   |select PSComputerName,Name,version,InstallLocation,Caption,Description,InstallDate,packageName `
|Format-Table -AutoSize |Out-File  $reportfile -Width  1024

ii $reportfile


#-----------------------------------
#06  185  get services 
#-----------------------------------
$reportfile=$infoPath+'CIB_Services.txt'
#ri $reportfile
foreach ($server in $servers)
{
    $server |Out-File  $reportfile  -Append 
    gsv -ComputerName $server |Out-File  $reportfile  -Append
}
ii $reportfile

#-----------------------------------
#07 197   get firewall rule 
#-----------------------------------
Get-NetFirewallProfile  -name   Private ,Public,Domain
$reportfile=$infoPath+'CIB_FirewallRule.txt'

$ScriptBlock={Get-NetFirewallProfile -Name Public | Get-NetFirewallRule | select name,DisplayGroup, displayname, enabled}



$cred = New-Object System.Management.Automation.PSCredential -ArgumentList @($username,(ConvertTo-SecureString -String $password -AsPlainText -Force))

foreach ($server in $servers)
{
 $server |Out-File  $reportfile  -Append 
#icm -ComputerName PMD     -ScriptBlock $ScriptBlock -Credential $cred  | Out-File $reportfile -Append
icm -ComputerName $server  -ScriptBlock $ScriptBlock     |ft -AutoSize  | Out-File $reportfile -Append
}

ii $reportfile

#-----------------------------------
#08 230　get SQL master_files
#-----------------------------------
 Add-PSSnapin SqlServerCmdletSnapin100


Import-Module sqlps -DisableNameChecking
Import-Module  'C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS' -DisableNameChecking
$ivsql="sp2013"


$reportfile=$infoPath+'CIB_master_files.txt'
$tsql_masterfile="select name,physical_name,size *0.000008 from sys.master_files"

 Invoke-Sqlcmd -Query $tsql_masterfile -ServerInstance $ivsql |Out-File  $reportfile  -Append

#-----------------------------------
#09 246  　get SQL version
#-----------------------------------
$reportfile=$infoPath+'CIB_SQLEdition.txt'


$tsql_SQLedition=@"
SELECT 
  @@servername N'SQLServerName',
 RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'
"@

foreach ($server in $servers)
{
    Invoke-Sqlcmd -Query $tsql_SQLedition -ServerInstance $server |Out-File  $reportfile  -Append
}


#-----------------------------------
#10 269  　get SQL Job
#-----------------------------------
$reportfile=$infoPath+'CIB_SQLJob.txt'



foreach ($server in $servers)
{
$server |Out-File  $reportfile  -Append 
#$server = "WIN-2S026UBRQFO"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $server

$jobs=$server.JobServer.Jobs
$jobs |
Select Name, OwnerLoginName, LastRunDate, LastRunOutcome |
Sort -Property Name |
Format-Table -AutoSize  |Out-File  $reportfile  -Append

}


#-----------------------------------
#11  291 　get SQL databaseinfo
#-----------------------------------
$reportfile=$infoPath+'CIB_DatabaseInfo.txt'
foreach ($server in $servers)
{
$server |Out-File  $reportfile  -Append 
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $server
$dbS=$server.Databases 

$i=$dbS.Count
foreach ($db in $dbS)
{
    "------$i--------------------$db.name-------------------------" | out-file c:\temp\master.txt -Append 
    $db |select * | out-file c:\temp\master.txt -Append -force
    ;$i=$i-1
}

}
ri $reportfile
ii $reportfile
#-----------------------------------
#12 312 　get SQL  serverinfo
#-----------------------------------

$reportfile=$infoPath+'CIB_SQLInfo.txt'
foreach ($server in $servers)
{
$server |Out-File  $reportfile  -Append 
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $server
$server |select * |out-file |Out-File  $reportfile  -Append
$server.Information|Out-File  $reportfile  -Append

"------------------------------------------------------------"|Out-File  $reportfile  -Append 

}
ri $reportfile
ii $reportfile




#-----------------------------------
#13 333 　get SQL backup 
#-----------------------------------

SELECT
DATABASE_NAME as '資料庫名稱',
CASE [type]   
WHEN 'D' THEN N'資料庫' 
WHEN 'I' THEN N'差異資料庫' 
WHEN 'L' THEN N'紀錄' 
WHEN 'F' THEN N'檔案或檔案群組' 
WHEN 'G' THEN N'差異檔案' 
WHEN 'P' THEN N'部分' 
WHEN 'Q' THEN N'差異部分' 
ELSE N'NULL' 
END as '備份類型', 
--RECOVERY_MODEL as '還原模式',
DATABASE_BACKUP_LSN as '完整資料庫備份之LSN',
FIRST_LSN as '第一個LSN',
LAST_LSN as '下一個LSN',
DIFFERENTIAL_BASE_LSN as '差異備份的基底LSN',
backup_start_date as '備份開始時間', 
backup_finish_date as '備份完成時間',
backup_size *0.000000001
FROM msdb.dbo.backupset 
WHERE DATABASE_NAME='ssmatesterdb'
order by backup_finish_date desc
#-----------------------------------
#14 360  　get SQL SSIS  packages 
#-----------------------------------
-- List all SSIS packages stored in msdb database. 
SELECT PCK.name AS PackageName 
      ,PCK.[description] AS [Description] 
      ,FLD.foldername AS FolderName 
      ,CASE PCK.packagetype 
            WHEN 0 THEN 'Default client' 
            WHEN 1 THEN 'I/O Wizard' 
            WHEN 2 THEN 'DTS Designer' 
            WHEN 3 THEN 'Replication' 
            WHEN 5 THEN 'SSIS Designer' 
            WHEN 6 THEN 'Maintenance Plan' 
            ELSE 'Unknown' END AS PackageTye 
      ,LG.name AS OwnerName 
      ,PCK.isencrypted AS IsEncrypted 
      ,PCK.createdate AS CreateDate 
      ,CONVERT(varchar(10), vermajor) 
       + '.' + CONVERT(varchar(10), verminor) 
       + '.' + CONVERT(varchar(10), verbuild) AS Version 
      ,PCK.vercomments AS VersionComment 
      ,DATALENGTH(PCK.packagedata) AS PackageSize 
FROM msdb.dbo.sysdtspackages90 AS PCK 
     INNER JOIN msdb.dbo.sysdtspackagefolders90 AS FLD 
         ON PCK.folderid = FLD.folderid 
     INNER JOIN sys.syslogins AS LG 
         ON PCK.ownersid = LG.sid 
ORDER BY PCK.name;




#-----------------------------------
#16 411 　get SQL create script
#-----------------------------------
Generate a Script 


In Object Explorer, expand Databases, right-click a "database", point to "Tasks", and then click Generate Scripts. 
Follow the steps in the wizard to script the database objects.
On the Choose Objects page, select the objects to be included in the script. For more information, see Generate and Publish Scripts Wizard (Choose Objects Page).
On the Set Scripting Options page, select Save scripts to a specific location.
To specify advanced scripting options, select the Advanced button in the Save scripts to a specific location section.
Select the location for the generated script: to a file, a Database Engine Query Editor window, or the Clipboard.
For more information, see Generate and Publish Scripts Wizard (Set Scripting Options Page).
On the Summary page, review your selections. Click Previous to change your selections. Click Next to generate a script of the objects you selected. For more information, see Generate and Publish Scripts Wizard (Summary Page).
On the Save or Publish Scripts page, monitor the progress of the script generation. For more information, see Generate and Publish Scripts Wizard (Save or Publish Scripts Page)
Object Explorer Script as Menu

You can use the Object Explorer Script as menu to script a single object, script multiple objects, or script multiple statement


#-----------------------------------
#15  　get Host performance
#-----------------------------------


#-----------------------------------
# 16  453 step1  General script  at  A  & B SQLServer 
#-----------------------------------
$Filepath='D:\MyScriptsDirectory' # local directory to save build-scripts to
$DataSource='PMD2016'             # server name and instance
$Database='SQL_inventory'         # the database to copy from
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
$CreationScriptOptions.DRIAll  = $true # and all the constraints 
$CreationScriptOptions.Indexes = $true # Yup, these would be nice
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

#-----------------------------------
# step2  compare-two file 
#-----------------------------------
$A='D:\MyScriptsDirectory\SQL_inventory_Build_A.sql'
$B='D:\MyScriptsDirectory\SQL_inventory_Build_B.sql'



function Compare-Files{
param(
$file1,
$file2,
[switch]$IncludeEqual
)
$content1 = Get-Content $file1
$content2 = Get-Content $file2


#$comparedLines = Compare-Object $content1 $content2 -IncludeEqual:$IncludeEqual | group { $_.InputObject.ReadCount } | sort Name
$comparedLines = Compare-Object $content1 $content2 | group { $_.InputObject.ReadCount } | sort Name


$comparedLines | foreach {
$curr=$_
switch ($_.Group[0].SideIndicator){
“==” { $right=$left = $curr.Group[0].InputObject;break}
“=>” { $right,$left = $curr.Group[0].InputObject,$curr.Group[1].InputObject;break }
“<=" { $right,$left = $curr.Group[1].InputObject,$curr.Group[0].InputObject;break }
}
[PSCustomObject] @{
Line = $_.Name
Left = $left
Right = $right
}
}
}



Compare-Files $A $B
[switch]$IncludeEqual
)
$content1 = Get-Content $file1
$content2 = Get-Content $file2


#$comparedLines = Compare-Object $content1 $content2 -IncludeEqual:$IncludeEqual | group { $_.InputObject.ReadCount } | sort Name
$comparedLines = Compare-Object $content1 $content2 | group { $_.InputObject.ReadCount } | sort Name


$comparedLines | foreach {
$curr=$_
switch ($_.Group[0].SideIndicator){
“==” { $right=$left = $curr.Group[0].InputObject;break}
“=>” { $right,$left = $curr.Group[0].InputObject,$curr.Group[1].InputObject;break }
“<=" { $right,$left = $curr.Group[1].InputObject,$curr.Group[0].InputObject;break }
}
[PSCustomObject] @{
Line = $_.Name
Left = $left
Right = $right
}
}
}



Compare-Files $A $B


#-----------------------------------
#17  567 　稽核 Audit for  Server level
#-----------------------------------


#----Get

SELECT name N'稽核', is_state_enabled N'啟用',type_desc N'稽核類型',  queue_delay N'寫入磁碟前等候時間(毫秒)',
	create_date N'建立日期時間', modify_date '修改日期時間'
FROM sys.server_audits

SELECT audit_action_id N'稽核動作的識別碼', audit_action_name N'稽核動作或稽核動作群組的名稱', 
	class_desc N'稽核動作套用的物件之類別名稱', is_group N'是否為動作群組'
FROM sys.server_audit_specification_details


#----New



# 1 稽核命名原則
1.	稽核名稱: SrvAudit-年月日-流水號

SrvAudit-年月日-流水號-spec
dbAudit-年月日-流水號-spec


# 2  稽核檔案所在路徑及備份路徑
$AuditPath='H:\SQLAudit'
$AuditBakPath=''

# 3  建立稽核


USE [master]

GO

CREATE SERVER AUDIT [MonitorLogin]  #Audit-20160317-00000 最好是 稽核資料庫的查詢]
TO FILE 
(	FILEPATH = N'H:\SQLAudit'
	,MAXSIZE = 100 MB
	,MAX_FILES = 100
	,RESERVE_DISK_SPACE = OFF
)WITH(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE)

ALTER SERVER AUDIT [UserAction]
TO FILE 
(		MAX_ROLLOVER_FILES = 100
)

GO


# 4  建立 [稽核規格]  並套入  所屬 [稽核]

USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [MonitorLogin_SUCCESSFULANDFAILED]  # 監控帳戶登入事件
FOR SERVER AUDIT [MonitorLogin]
ADD (FAILED_LOGIN_GROUP),
ADD (SUCCESSFUL_LOGIN_GROUP)
GO

# 5  Turn the audit and server audit specification


ALTER SERVER AUDIT [MonitorLogin] WITH(STATE = ON)
ALTER SERVER AUDIT SPECIFICATION [MonitorLogin_SUCCESSFULANDFAILED]WITH (STATE = ON)GO

# 6  GET info

USE master;SELECT event_time,server_principal_name, object_name, statement,* FROM fn_get_audit_file('H:\SQLAudit\Audit*',NULL, NULL)



ALTER SERVER AUDIT [MonitorLogin] WITH(STATE = OFF)
ALTER SERVER AUDIT SPECIFICATION [MonitorLogin_SUCCESSFULANDFAILED]WITH (STATE = OFF)




#----Drop


USE [master]
GO

DROP SERVER AUDIT SPECIFICATION [MonitorLogin_SUCCESSFULANDFAILED]
GO


DROP SERVER AUDIT [MonitorLogin]
GO


#-----------------------------------
#18   680 　稽核 Audit for  Database level
#-----------------------------------

# Get


--01 檢視「資料庫稽核規格」的資料
SELECT name N'資料庫稽核規格', is_state_enabled N'是否已啟用', 
	create_date N'建立日期時間', modify_date N'修改日期時間'
FROM sys.database_audit_specifications 

--02 檢視「資料庫稽核規格」的詳細資料(動作)
SELECT audit_action_id N'稽核動作的識別碼', audit_action_name N'稽核動作或稽核動作群組的名稱', 
	class_desc N'稽核的物件類別之描述', is_group N'是否為動作群組'
FROM sys.database_audit_specification_details




# Create

CREATE SERVER AUDIT [UserAction]  #Audit-20160317-00000 最好是 稽核資料庫的查詢]
TO FILE 
(	FILEPATH = N'H:\SQLAudit'
	,MAXSIZE = 100 MB
	,MAX_FILES = 100
	,RESERVE_DISK_SPACE = OFF
)
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
)


use AdventureWorks2014
CREATE DATABASE AUDIT SPECIFICATION [userSelect]
FOR SERVER AUDIT [UserAction]
	ADD (SELECT,insert,update,delete  ON SCHEMA::[dbo] BY [public])
GO

#  enable
use master 
ALTER SERVER AUDIT [UserAction] WITH(STATE = ON)use AdventureWorks2014
ALTER DATABASE AUDIT SPECIFICATION [userSelect]WITH (STATE = ON)

# diable
use master 
ALTER SERVER AUDIT [UserAction] WITH(STATE = OFF)use AdventureWorks2014
ALTER DATABASE AUDIT SPECIFICATION [userSelect]WITH (STATE = OFF)

# get info

SELECT SWITCHOFFSET(CAST(event_time AS datetimeoffset ),'+08:00') N'稽核動作引發時的日期時間(台北時區GMT+08:00)', 
	server_principal_name N'登入帳戶', database_principal_name N'資料庫使用者',
	database_name N'資料庫', object_name N'物件名稱', statement N'TSQL 陳述式'
FROM sys.fn_get_audit_file (N'H:\SQLAudit\UserAction*.*',default,default);



SELECT event_time,server_principal_name, object_name, statement,* FROM fn_get_audit_file('H:\SQLAudit\userAction*',NULL, NULL)where server_principal_name='sqlsa'

# drop 

DROP SERVER AUDIT [UserAction]
GO


USE [AdventureWorks2014]
DROP DATABASE AUDIT SPECIFICATION [userSelect]
GO


#-----------------------------------
#19    763 　稽核 Audit 分析
#-----------------------------------
ii 'D:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\worklog\TPTAO\'

D:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\worklog\TPTAO\Audit_Log\DB_Audit2016Q2.zip

Work at   
ii  'C:\temp\DB_Audit'


$workpath='C:\temp\DB_Audit'
$auditPath=$workpath+$dc

$dc='Audit-DATABASE_CHANGE_GROUP_'
$doc='Audit-DATABASE_OBJECT_CHANGE_GROUP_'
$soc='Audit-SERVER_OBJECT_CHANGE_GROUP_'
$mlo='MonitorLogin_'

--------------------------------------------


$repfiletxt='C:\temp\DB_Audit\auditlog.txt'
$repfilecsv='C:\temp\DB_Audit\auditlog.csv'
ri $repfiletxt; ri $repfilecsv
$gs=gci $workpath  -Filter MonitorLogin_*.sqlaudit     # 
$i=$gs.count

foreach ($g in $gs)
{  #786
   $i
    $gf=$g.FullName

    $tsql_audit=@"
     SELECT SWITCHOFFSET(CAST(event_time AS datetimeoffset ),'+08:00') N'稽核動作引發時的日期時間(台北時區GMT+08:00)'
	,action_id
	,session_server_principal_name AS UserName
	,server_instance_name
	,database_name
	,schema_name
	,object_name
	,statement
FROM sys.fn_get_audit_file('$gf', DEFAULT, DEFAULT)
WHERE action_id IN ( 'SL', 'IN', 'DR', 'LGIF' , '%AU%','LGIS' )
"@

$rs=Invoke-Sqlcmd -ServerInstance   SPFarmsQL -query  $tsql_audit 

foreach ($r in $rs)
{  #807 2
    
    if ( ($r.action_id)  -ne 'LGIS')
{
   $r  | out-file $repfiletxt -Append
   $r  | Export-Csv -Path $repfilecsv  -Append  -NoTypeInformation -Encoding UTF8
}



}  #807 2



$i--


} #786

---------------------------------------------------


WHERE action_id IN ( 'SL', 'IN', 'DR', 'LGIF' , '%AU%','LGIS' )
The action_id = 
‘SL’ shows SELECT statements executed, 
‘IN’ – inserts, 
‘DR’ – dropped objects, 
‘LGIF’ – failed logins, 
‘%AU%’ – events related to the audit feature, and 
‘UP’ – updates

________________________________________________________________________________________________________________________________________

#-----------------------------------
#20   　稽核 Audit 備份
#-----------------------------------
#-------------3  copy to \\HISBACKUP\SQLBultiInBackup

$PathauditlogFile_local  ='\\Hisdb2\A$\SQLLOG'
$PathHisbakup15          ='\\HISBACKUP\SQLBultiInBackup'

$auditlogFile_local      =$PathauditlogFile_local+'\*adt*.sqlaudit'
$Hisbakup15path          =$PathHisbakup15 +'\*adt*.sqlaudit'

cd  a:\

$lf=gi $auditlogFile_local ;$lf


$rf=gi $Hisbakup15path ;$rf

dir 

cp  $auditlogFile_local $PathHisbakup15   -Force

#--------------4 remove - 7 day 
$beforeday = (get-date).AddDays(-7); #$beforeday
#$fileS = get-item \\Hisdb2\sqlbackup\*.* ; $files; $files.count
$fileS = get-item A:\SQLBACKUP\*.* ;# $files; $files.count

foreach ($file in $fileS)
{
  if ($beforeday  -gt $file.CreationTime  ) # find  -x day 
{
   #$file.CreationTime
   #Remove-Item $file
   #(get-date).ToString() +"   delete $file  file finish"|out-file A:\SQLLOG\backuplog.txt -Append
}  
}
________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________

二、 前置作業區 

本區域是透過第三代公路監理系統提供原始資料(格式UTF-8)，包含代碼檔、違規主檔、申訴檔、一次裁決檔及分期檔等新建三代主檔以及每日差異檔匯入SQL 2012伺服器，並用SSIS 設計資料處理流程，並針對交通違規主檔的日期有西元年格式轉換民國年格式，另外每月以文字檔方式匯出主檔。 



貳、 轉檔程序說明 

此部分針對接收第三代公路監理系統提供原始資料做資料整理，包含代碼檔每日匯入、主檔首次匯入及每日差異匯入。以下將三部分介紹: 一、文字檔路徑規劃；二、SSIS程序說明。 


一、 文字檔路徑規劃 

文字檔一律存放在主機IP 為10.12.2.14  

序號 檔名 原始資料區路徑 匯入存放區 匯出存放區 備份區 

1 vil_rcv_state_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

2 vil_vehicle_kind_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

3 vil_pay_way_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

4 vil_lic_type.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

5 vil_hold_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

6 vil_car_susp_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

7 vil_drv_susp_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

8 vil_dmv_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

9 vil_close_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

10 vil_clause_rule.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

11 vil_car_kind_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

12 vil_adm_state_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

13 vil_adm_handle_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

14 vil_addr_no_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

15 vil_accuse_type_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

16 vil_accuse_state_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

17 vil_accuse_no_code.D D:\olapdb\ D:\M3_data\DIM D:\M3_Backup 

18 vil_adm_remedy_log.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

19 vil_car_susp_his.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

20 vil_motor_susp_his.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

21 vil_migrate.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

22 vil_div.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

23 vil_div_his.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

24 vil_pay_month.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

25 vil_pay_month_detail.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

26 vil_phone_xact.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

27 vil_receipt_payment.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

28 vil_plate_susp_his.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

29 vil_adj_traffic D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 

30 vil_traffic_rule.D D:\olapdb\ D:\M3_data\FACT D:\M3_Export D:\M3_Backup 


二、 SSIS程序說明 

1. SSIS 轉檔流程圖 



2. 封裝作業說明與轉檔頻率 

(1) Import Fact Table.dtsx 

封裝名稱 作業內容 轉檔頻率 

Import Fact Table.dtsx 1. 檢查文字檔是否已在匯入存放區 2. 清空資料庫主檔資料表 3. 匯入文字檔至資料庫主檔 Vil_pay_month , vil_traffic_rule, m3_vil_div, vil_pay_month_detail, vil_adm_remedy_log, vil_car_susp_his, vil_motor_susp_his, m3_vil_div_his, vil_adj_traffic, vil_plate_susp_his, vil_receipt_payment, vil_migrate 4. 備份文字檔 首次或提供當月全檔 

流程圖 


(2) Import Append.dtsx 

封裝名稱 作業內容 轉檔頻率 

Import Append.dtsx 1. 檢查文字檔是否已在匯入存放區 2. 匯入文字檔至資料庫主檔 Vil_pay_month , vil_traffic_rule, m3_vil_div, vil_pay_month_detail, vil_adm_remedy_log, vil_car_susp_his, vil_motor_susp_his, m3_vil_div_his, vil_adj_traffic, vil_plate_susp_his, vil_receipt_payment, vil_migrate 2-1檢查是否資料已存在，若已存在則更新該筆。更新程式參考[三、轉檔預存程序(SP)] 3. 備份文字檔 每日上午04:00 

流程圖 
(3) Import Dim Table.dtsx 

封裝名稱 作業內容 轉檔頻率 

Import Dim Table.dtsx 1. 檢查文字檔是否已在匯入存放區 2. 清空資料庫代碼檔資料表 3. 匯入文字檔至資料庫代碼檔 vil_accuse_no_code, vil_accuse_state_code, vil_accuse_type_code, vil_addr_no_code, vil_adm_handle_code, vil_adm_state_code, vil_car_kind_code, vil_clause_rule, vil_close_code, vil_dmv_code, vil_car_susp_code, vil_drv_susp_code vil_hold_code, vil_lic_type, vil_pay_way_code vil_rcv_state_code, vil_vehicle_kind_code 4. 備份文字檔 
(4) Export.dtsx 

封裝名稱 作業內容 轉檔頻率 

Export.dtsx 1.  以文字檔方式匯出資料庫主檔，提供Sybase IQ 使用。匯出的主檔有Vil_pay_month , vil_traffic_rule, m3_vil_div, vil_pay_month_detail, vil_adm_remedy_log, vil_car_susp_his, vil_motor_susp_his, m3_vil_div_his, vil_adj_traffic, vil_plate_susp_his, vil_receipt_payment, vil_migrate,vil_phone_xact 共13個文字檔 2. 針對vil_traffic_rule特別處理日期格式且只選擇Sybase ETL所需要的欄位，並以文字檔(vil_traffic_rule_view) 匯出。日期處理格式參考[三、轉檔預存程序(SP)] 每月月初 


________________________________________________________________________________________________________________________________________
三、 SQL Server Agent 排程 

項次 排程時間 SQL Server Agent  作業名稱 SSIS 封裝存放區 執行時間(約) 

1 每日上午3:30 Import Dim tables(Daily) \MSDB\tao_ssis\import Dim tables 5 秒 

2 每日上午4:00 Append Fact tables (Dai-ly) \MSDB\tao_ssis\import ap-pend 26秒 

3 每月1日 上午04:30 Export Tables \MSDB\tao_ssis\export table 1小時 


作業名稱內容說明 

1. Import Dim tables(Daily) : 將文字檔由D:\M3_data\DIM中搬移SQL， 並複製一份至D:\M3_Backup資料夾。 

項次 資料表名稱 SQL table name 

1 違規舉發單位代碼表 vil_accuse_no_code 

2 舉發狀態代碼表 vil_accuse_state_code 

3 舉發類別代碼表 vil_accuse_type_code 

4 違規地點代碼表 vil_addr_no_code 

5 申訴處理情形代碼表 vil_adm_handle_code 

6 申訴行政救濟代碼表 vil_adm_state_code 

7 車籍車種 vil_car_kind_code 

8 條款代碼 vil_clause_rule 

9 案件異動別代碼表 vil_close_code 

10 所站代碼表 vil_dmv_code 

11 牌照吊扣銷 vil_car_susp_code 

12 駕照吊扣銷 vil_drv_susp_code 

13 扣件代碼表 vil_hold_code 

14 駕照類別 vil_lic_type 

15 繳式代碼 vil_pay_way_code 

16 送達狀態代碼表 vil_rcv_state_code 

17 車籍簡式車種 vil_vehicle_kind_code 



2. Append Fact tables (Daily) : 將在D:\M3_data\FACT 底下13個主檔匯入SQL 並每日異動資料更新，以key檢查，若是資料表中已有的則更新，沒有的資料新增 


3. Export Tables : 每月一日匯出主檔至D:\M3_Export。 



項次 資料表名稱 SQL table name key 

1 一般違規主資料 vil_traffic_rule vil_ticket+plate_no 

2 一次裁罰申訴/異議 vil_adm_remedy_log remedy_id 

3 汽車駕照吊扣註銷歷史檔 vil_car_susp_his car_susp_seq 

4 機車駕照吊註銷歷史檔 vil_motor_susp_his motor_susp_seq 

5 移轉管轄歷史 vil_migrate vil_ticket 

6 一般違規單筆分期付款 m3_vil_div vil_ticket 

7 一般違規單筆分期付款歷史紀錄 m3_vil_div_his vil_ticket 

8 一般違規多筆分期主資料 vil_pay_month pay_month_seq 

9 一般違規多筆分期明細資料 vil_pay_month_detail month_detail_seq 

10 語音轉帳 vil_phone_xact trans_dt+vil_ticket 

11 違規收據 vil_receipt_payment receipt_seq 

12 一次裁決 vil_adj_traffic vil_ticket+plate_no 

13 行牌照吊扣註銷歷史檔 vil_plate_susp_his plate_susp_seq 

項次 資料表名稱 SQL table name 

1 一般違規主資料 vil_traffic_rule 

2 一次裁罰申訴/異議 vil_adm_remedy_log 

3 汽車駕照吊扣註銷歷史檔 vil_car_susp_his 

4 機車駕照吊註銷歷史檔 vil_motor_susp_his 

5 移轉管轄歷史 vil_migrate 

6 一般違規單筆分期付款 m3_vil_div 

7 一般違規單筆分期付款歷史紀錄 m3_vil_div_his 

8 一般違規多筆分期主資料 vil_pay_month 

9 一般違規多筆分期明細資料 vil_pay_month_detail 

10 語音轉帳 vil_phone_xact 

11 違規收據 vil_receipt_payment 

12 一次裁決 vil_adj_traffic 

13   行牌照吊扣註銷歷史檔 vil_plate_susp_his 

14 每月違規主檔(日期民國年) vil_traffic_rule_view 

肆、 ETL排程 

項次 排程時間 Windows排程名稱 批次檔路徑 執行時間(約) 

1 每天上午05:20 move_today_data D:\M3_load_data\script\move_today_data.bat 1分鐘 

2 每月1日 上午05:30 auto_M3_codeload D:\M3_Run\script\auto_m3_codeload.bat 20分鐘 


作業名稱內容說明 

1. move_today_data 

備份D:/ M3_load_data 底下的主檔跟代碼檔 至D:/ M3_load_data/年月日子目錄與D:/ M3_load_data/code/年月日子目錄，同時將代碼檔複製到D:/M3_data/code下 

2. auto_M3_codeload 

(1) 檢查 D:/M3_Data/code下的文字檔是否存在 

(2) 將文字檔的語系從UTF8轉為BIG5 

(3) 執行run_m3_codeload.bat，將代碼檔匯入資料表 

(4) 備份17個代碼檔至D:\M3_backup\年月子目錄\code下 

(5) Log檔存放D:\M3_Run\script\M3CODE_Load_M月.txt下 
