<#

C:\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1

CreateDate: AUG.19.2015LastDate : AUG.19.2015Author :Ming Tseng  ,a0921887912@gmail.com  ming_tseng@syscom.com.twremark 



$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1
$ps1fS=gi C:\Users\Chao_Ming\OneDrive\download\PS1\OS00_Index.ps1  #s21
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
#08  230　 get SQL master_files
#09  246  get SQL version
#10  269  get SQL Job
#11  291 　get SQL databaseinfo
#12  312 　get SQL serverinfo
#13  333 　get SQL backup 
#     383    make SQL_inventory  &  DMV_log Table Step
#     476   remote query timeout vs remote login timeout 
# 493    平行處理最大   CPU 
# 499    平行處理最大    remote login query timeout  & 並行連接最大數目

#15  　    
#16  　    g




#-----------------------------------
#00  base info
#-----------------------------------
$infoPath ='H:\'
$env:COMPUTERNAME  SP2013
COM-DB-SQL1   10.150.100.1
COM-DB-SQL2   10.150.100.2
COM-DB-SQL3   10.150.100.3
COM-DB-SQL5   10.150.100.5
COM-DB-SQL6   10.150.100.6
COM-DB-SQL7   10.150.100.7

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
winrmgc # if need  run at COM-DB-SQLx
winrm e winrm/config/listener

winrm e winrm/config/listener
winrm set    winrm/config/client @{TrustedHosts="COM-DB-SQL1,COM-DB-SQL2,COM-DB-SQL3,COM-DB-SQL5,COM-DB-SQL6,COM-DB-SQL9,PMD"}  

winrm g winrm/config # get TrustedHosts

Test-WSMan -ComputerName PMD
<#
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 2.0
#>
gps -ComputerName pmd

gwmi Win32_Service  -ComputerName pmd |select name

ping PMD

icm -ComputerName sql2012x -ScriptBlock {systeminfo} |out-file 


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


#---------------------------------------------------------------
#   383    make SQL_inventory  &  DMV_log Table Step
#---------------------------------------------------------------


CREATE DATABASE [SQL_Inventory] ON(NAME = N'SQLInventory',FILENAME = N'H:\SQLDB\SQL_Inventory.mdf',SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024MB )LOG ON(NAME = N'SQLInventory_log',FILENAME = N'H:\SQLDB\SQL_Inventory_log.LDF',SIZE = 512MB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)




step 1 : select * into statusOSPCR FROM sys.dm_os_performance_counters 
step 2 : open table desgin on SSMS + [updateDate] [datetime] NULL  
       ALTER TABLE [dbo].[statusLogSize] ADD  CONSTRAINT [DF_statusLogSize_updateDate]  DEFAULT (getdate()) FOR [updateDate]
Step 3 : script table as  drop and create
step 4 : insert into 


'USE [SQL_inventory]
GO

DROP TABLE [dbo].[statusOSPCR]

/****** Object:  Table [dbo].[statusOSPCR]    Script Date: 11/11/2015 2:21:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[statusOSPCR](
	[object_name] [nchar](128) NOT NULL,
	[counter_name] [nchar](128) NOT NULL,
	[instance_name] [nchar](128) NULL,
	[cntr_value] [bigint] NOT NULL,
	[cntr_type] [int] NOT NULL,
    [updateDate] [datetime] NULL 
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[statusOSPCR] ADD  CONSTRAINT [DF_statusLogSize_updateDate]  DEFAULT (getdate()) FOR [updateDate]



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

' 



SELECT 
    c.name 'Column Name',
    t.Name 'Data type',
    c.max_length 'Max Length',
    c.precision ,
    c.scale ,
    c.is_nullable,
    ISNULL(i.is_primary_key, 0) 'Primary Key'
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE
    c.object_id = OBJECT_ID('[dm_hadr_database_replica_cluster_states]')

#-----------------------------------
# 476   remote query timeout 
#-----------------------------------

To configure the remote query timeout option
In Object Explorer, right-click a server and select Properties.
Click the Connections node.
Under Remote server connections, in the Remote query timeout box, type or select a value from 0 through 2,147,483,647 to set the maximum number seconds for SQL Server to wait before timing out.


EXEC sp_configure 'remote query timeout', 0 ;
GO
RECONFIGURE ;
GO


#-----------------------------------
# 493    平行處理最大   CPU 
#-----------------------------------
SQL SERVER 屬性 進階  平行處理原則  =0

#-----------------------------------
# 499    平行處理最大   remote login  & query timeout  & 
#-----------------------------------


## remote login timeout  default 10sec  (U: Advanced > Network >  Remote Login Timeout )
USE AdventureWorks2012 ;
GO
EXEC sp_configure 'remote login timeout', 35 ;
GO
RECONFIGURE ;
GO


#並行連接最大數目  SQL SERVER 屬性  > 連線 >  =0 無限



# remote query timeout  default 10sec SQL SERVER 屬性  > 連線 > remote query time ＞ =600  default 




#-----------------------------------
#14    DBCC to sql_inventory
#-----------------------------------
SELECT * FROM sys.dm_os_sys_info



#----------------------------------------------------
# 440  1667  Listing 6.4 What is blocked? p.159
#----------------------------------------------------
{<#
SELECT
Blocking.session_id as BlockingSessionId
, Sess.login_name AS BlockingUser
, BlockingSQL.text AS BlockingSQL
, Waits.wait_type WhyBlocked
, Blocked.session_id AS BlockedSessionId
, USER_NAME(Blocked.user_id) AS BlockedUser
, BlockedSQL.text AS BlockedSQL
, DB_NAME(Blocked.database_id) AS DatabaseName

FROM sys.dm_exec_connections AS Blocking
INNER JOIN sys.dm_exec_requests AS Blocked
ON Blocking.session_id = Blocked.blocking_session_id
INNER JOIN sys.dm_os_waiting_tasks AS Waits
ON Blocked.session_id = Waits.session_id
RIGHT OUTER JOIN sys.dm_exec_sessions Sess
ON Blocking.session_id = sess.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)
AS BlockingSQL
CROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQL
ORDER BY BlockingSessionId, BlockedSessionId

The script shows details of the query that is causing

#-----------------------------------
#15  　
#-----------------------------------




________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________
