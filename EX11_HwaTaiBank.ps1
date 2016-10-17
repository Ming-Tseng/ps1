<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX11_HwaTaiBank.ps1
C:\Users\Chao_Ming\OneDrive\download\PS1\EX11_HwaTaiBank.ps1
C:\Users\administrator.CSD\OneDrive\download\PS1\EX11_HwaTaiBank.ps1
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX11_HwaTaiBank.ps1

CreateDate: AUG.19.2015LastDate : AUG.19.2015Author :Ming Tseng  ,a0921887912@gmail.com  ming_tseng@syscom.com.twremark 



$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1

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
#    385  Get basic info
#    637  Listing 1.5 Quickly find a cached plan  p.19
#    662  Extracting the Individual Query from the Parent Query
#    686  Determine query effect via differential between snapshots
#    741  Identifying indexes used by a given routine p.78
#    814  The queries spend the longest time being blocked p.104
#    850  SSIS package  dtexec.exe   Jan.29.2016
#    942   FEB.2016

#      make SQL_inventory  &  DMV_log Table Step
#        remote query timeout vs remote login timeout 
#    平行處理最大   CPU 
#    平行處理最大    remote login query timeout  & 並行連接最大數目

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
#   385 Get basic info
#---------------------------------------------------------------


$dbname    ='sql_inventory'


function dbmdfldfSize ($dbinstance,$dbname){
  $tsql_selectdbFileSize="
print 'Show Size, Space Used, Unused Space, Type, and Name of all database files'
select
	[FileSizeMB]	=
		convert(numeric(10,2),sum(round(a.size*0.008,2))),
        [UsedSpaceMB]	=
		convert(numeric(10,2),sum(round(fileproperty( a.name,'SpaceUsed')*0.008,2))) ,
        [UnusedSpaceMB]	=
		convert(numeric(10,2),sum(round((a.size-fileproperty( a.name,'SpaceUsed'))*0.008 ,2))) ,
	[Type] =
		case when a.groupid is null then '' when a.groupid = 0 then 'Log' else 'Data' end,
	[DBFileName]	= isnull(a.name,'+++ Total for all files ++')
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
Invoke-Sqlcmd -Query $tsql_selectdbFileSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rd  |ft -AutoSize  
}
dbmdfldfSize PMD2016 sql_inventory


$tsql_select53="select name, physical_name, size *0.000008 from sys.master_files"     

   Invoke-Sqlcmd -Query $tsql_select53 -ServerInstance  PMD2016  -user sa  -password p@ssw0rd  |ft -AutoSize


$tsql_GetTableRowSize=@"
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
"@
Invoke-Sqlcmd -Query $tsql_GetTableRowSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rd  |ft -AutoSize  

set statistics io on
set statistics time  on



#---------------------------------------------------------------
#   
#---------------------------------------------------------------

#----------------------------------------------------
#  637   Listing 1.5 Quickly find a cached plan  p.19
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
st.text AS [SQL]
, cp.cacheobjtype
, cp.objtype
, COALESCE(DB_NAME(st.dbid),
DB_NAME(CAST(pa.value AS INT))+'*',
'Resource') AS [DatabaseName]
, cp.usecounts AS [Plan usage]
, qp.query_plan
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
OUTER APPLY sys.dm_exec_plan_attributes(cp.plan_handle) pa
WHERE pa.attribute = 'dbid'
AND st.text LIKE '%CREATE PROCEDURE%'  --Text to search plan for


#>}

#----------------------------------------------------
#   662  Extracting the Individual Query from the Parent Query
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
qs.execution_count
, SUBSTRING (qt.text, (qs.statement_start_offset/2) + 1
, ((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
ORDER BY execution_count DESC;

#>}
#---------------------------------------------------------------
#   
#---------------------------------------------------------------
#----------------------------------------------------
#  686  Determine query effect via differential between snapshots
#----------------------------------------------------
{<#

--Get pre-work snapshot
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT sql_handle, plan_handle, total_elapsed_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkSnapShot
FROM sys.dm_exec_query_stats

--Run queries
EXEC dbo.IWSR
SELECT * FROM dbo.appdate


--Get post-work snapshot
SELECT sql_handle, plan_handle, total_elapsed_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkSnapShot
FROM sys.dm_exec_query_stats

--Extract delta

SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkSnapShot p1
RIGHT OUTER JOIN
#PostWorkSnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
ORDER BY [Duration] DESC
DROP TABLE #PreWorkSnapShot
DROP TABLE #PostWorkSnapShot



#>}


#----------------------------------------------------
#   741   Identifying indexes used by a given routine p.78
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
SchemaName = ss.name
, TableName = st.name
, IndexName = ISNULL(si.name, '')
, IndexType = si.type_desc
, user_updates = ISNULL(ius.user_updates, 0)
, user_seeks = ISNULL(ius.user_seeks, 0)
, user_scans = ISNULL(ius.user_scans, 0)
, user_lookups = ISNULL(ius.user_lookups, 0)
, ssi.rowcnt
, ssi.rowmodctr
, si.fill_factor
INTO #IndexStatsPre
FROM sys.dm_db_index_usage_stats ius
SELECT
SchemaName = ss.name
, TableName = st.name
, IndexName = ISNULL(si.name, '')
, IndexType = si.type_desc
, user_updates = ISNULL(ius.user_updates, 0)
, user_seeks = ISNULL(ius.user_seeks, 0)
, user_scans = ISNULL(ius.user_scans, 0)
, user_lookups = ISNULL(ius.user_lookups, 0)
, ssi.rowcnt
, ssi.rowmodctr
, si.fill_factor
INTO #IndexStatsPost
FROM sys.dm_db_index_usage_stats ius
RIGHT OUTER JOIN sys.indexes si ON ius.[object_id] = si.[object_id]
AND ius.index_id = si.index_id
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE ius.database_id = DB_ID()
AND OBJECTPROPERTY(ius.[object_id], 'IsMsShipped') = 0
SELECT
DB_NAME() AS DatabaseName
, po.[SchemaName]
, po.[TableName]
, po.[IndexName]
, po.[IndexType]
, po.user_updates - ISNULL(pr.user_updates, 0) AS [User Updates]
, po.user_seeks - ISNULL(pr.user_seeks, 0) AS [User Seeks]
, po.user_scans - ISNULL(pr.user_scans, 0) AS [User Scans]
, po.user_lookups - ISNULL(pr.user_lookups , 0) AS [User Lookups]
, po.rowcnt - pr.rowcnt AS [Rows Inserted]
, po.rowmodctr - pr.rowmodctr AS [Updates I/U/D]
, po.fill_factor
FROM #IndexStatsPost po LEFT OUTER JOIN #IndexStatsPre pr
ON pr.SchemaName = po.SchemaName
AND pr.TableName = po.TableName
AND pr.IndexName = po.IndexName
AND pr.IndexType = po.IndexType
WHERE ISNULL(pr.user_updates, 0) != po.user_updates
OR ISNULL(pr.user_seeks, 0) != po.user_seeks
OR ISNULL(pr.user_scans, 0) != po.user_scans
OR ISNULL(pr.user_lookups, 0) != po.user_lookups
ORDER BY po.[SchemaName], po.[TableName], po.[IndexName];
DROP TABLE #IndexStatsPre
DROP TABLE #IndexStatsPost




#>}
#
#----------------------------------------------------
#  814  The queries spend the longest time being blocked p.104
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST((qs.total_elapsed_time - qs.total_worker_time) /
1000000.0 AS DECIMAL(28,2)) AS [Total time blocked (s)]
, CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time
AS DECIMAL(28,2)) AS [% CPU]
, CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 /
qs.total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting]
, qs.execution_count
, CAST((qs.total_elapsed_time - qs.total_worker_time) / 1000000.0
/ qs.execution_count AS DECIMAL(28, 2)) AS [Blocking average (s)]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE qs.total_elapsed_time > 0
ORDER BY [Total time blocked (s)] DESC



#>}


#----------------------------------------------------
#  850   SSIS package  dtexec.exe   Jan.29.2016
#----------------------------------------------------
##
$SSISServerInstance='PMD2016\SSDE'
$SSISdatabase='AdventureWorks'
$tsql_truncateSSIS=@"
truncate table  dbo.sysssislog
"@

$tsql_selectSSIS=@"
select *  from  dbo.sysssislog
"@

function prepareSSISLOG (){
 ri  c:\ssis\logcsv.csv
Invoke-Sqlcmd -ServerInstance $SSISServerInstance -Database $SSISdatabase -Query $tsql_truncateSSIS
$x=Invoke-Sqlcmd -ServerInstance $SSISServerInstance -Database $SSISdatabase -Query $tsql_selectSSIS    
$x;$x.count

}

function prepare (){
Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase -Query $tsql_truncateSSISLog
Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase -Query $tsql_select    
}


function SSISlogselect (){
$x=Invoke-Sqlcmd -ServerInstance $SSISServerInstance -Database $SSISdatabase -Query $tsql_selectSSIS    
$x;$x.count 
}


function tempselect (){
Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase -Query $tsql_select    
}
#*********************************************
prepareSSISLOG
SSISlogselect #417
 ii  c:\ssis\logcsv.csv

prepare 
tempselect


#*********************************************

$workFolder='C:\SSIS'


cp 'C:\Users\infra1\Documents\Visual Studio 2013\projects\HTB\HTB\p4.dtsx' "C:\SSIS\P4.dtsx" -Force

cp  C:\SSISLab\Ch03_StoreAndExecute\testDTExec\myLog.dtsx "C:\SSIS\myLog.dtsx" -Force
get-job \
Remove-Job * 
$t1=get-date
Start-Job  -scriptblock {dtexec.exe /f  C:\SSIS\P4.dtsx} #/cons
$t2=get-date; ($t2-$t1)

dtexec.exe /f C:\SSIS\myLog.dtsx /consolelog
notepad  C:\SSISLab\Ch03_StoreAndExecute\testDTExec\Log\LogPackage.log



'Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 14
Milliseconds      : 40
Ticks             : 140409131
TotalDays         : 0.000162510568287037
TotalHours        : 0.00390025363888889
TotalMinutes      : 0.234015218333333
TotalSeconds      : 14.0409131
TotalMilliseconds : 14040.9131'



    select *  from  [AdventureWorks].dbo.sysssislog

--truncate table  [AdventureWorks].dbo.sysssislog

 
 prepareSSISLOG
SSISlogselect #417
 ii  c:\ssis\logcsv.csv

 cd 'C:\Program Files\Microsoft SQL Server\120\DTS\Binn\'
 unlodctr dtspipeline
 lodctr  "C:\Program Files\Microsoft SQL Server\120\DTS\Binn\perf-DTSPipeline120DTSPERF.INI"  /R
  lodctr  "C:\Program Files\Microsoft SQL Server\120\DTS\Binn\perf-MsDtsServer120DTSSVCPERF.INI" /R
#---------------------------------------------------------------
#    942   FEB.2016
#---------------------------------------------------------------
cd 'C:\Program Files\Microsoft SQL Server\MSSQL12.SSDE\MSSQL\Binn'
unlodctr MSSQL$SSDE
lodctr 'perf-MSSQL$SSDEsqlctr.ini'

net stop "Remote Registry"
net stop "Performance Logs & Alerts" 
net start "Remote Registry"
net start "Performance Logs & Alerts"


get-Counter '\\sp2013\memory\% committed bytes in use' -MaxSamples 10 -SampleInterval 2  |  Export-Counter -Path h:\Temp\temp.csv -FileFormat csv  -Force ;ii  h:\Temp\temp.csv 
Import-Counter -Path h:\Temp\temp.csv  -ListSet *  ;ri $Buffercachehitratio

$SSISCounter=Get-counter -ListSet  '*SSIS Pipeline*' | Select-Object -ExpandProperty Paths 
Get-counter -ListSet  *SQLServer* | Select-Object -ExpandProperty Paths 
#counterSetname
Get-Counter -ListSet *MSSQL* | Select-Object -ExpandProperty Paths
Get-counter -ListSet  '*SSIS Pipeline*' | Select-Object -ExpandProperty Paths 

perfmon
get-counter $SSISCounter

$blgfile=C:\PerfLogs\SSIS.blg

start-job  {Get-Counter $using:SSISCounter -MaxSamples 21 -SampleInterval 1 |Export-Counter -Path C:\PerfLogs\SSIS.blg -FileFormat blg -force}

$Data = 

Import-Counter -Path 'H:\Temp\NETL_SSIS Performance Counter_Buffer cache hit ratio.csv'
Import-Counter -Path h:\Temp\temp.csv  -ListSet * 
\\NETL\SQLServer:Buffer Manager\Buffer cache hit ratio


$Buffercachehitratio='H:\Temp\NETL_SSIS Performance Counter_Buffer cache hit ratio.csv'
$Buffercachehitratio='h:\Temp\temp.csv'
$Buffercachehitratio='h:\Temp\t1.csv' 

Import-Counter -Path $Buffercachehitratio -ListSet * ;

gps -Name EXCEL
Stop-Process -id (gps -Name EXCEL).id 

Import-Csv 'h:\Temp\t2.csv' 
$g =Import-Counter 'h:\Temp\t1.csv' 
$g.Count
$g | Export-Counter -Path h:\Temp\ProcessorTime.blg -FileFormat blg  -Force

$g[2060]

Import-Counter H:\Temp\merge.blg
$Data= Import-Counter  H:\Temp\Buffercachehitratio.blg , H:\Temp\AvgDiskQueueLength_D.blg
$Data= Import-Counter  H:\Temp\CurrentDiskQueueLength_D.blg , H:\Temp\AvailableMBytes.blg
, H:\Temp\AvailableMBytes.blg 
$Data | Export-Counter H:\Temp\merge2.blg -FileFormat blg -Force




 Import-Counter  H:\Temp\merge.blg , H:\Temp\merge2.blg | Export-Counter H:\Temp\merge2.blg -FileFormat blg -Force


 Import-Counter  "H:\Temp\Buffercachehitratio.blg" , "H:\Temp\AvgDiskQueueLength_D.blg"`
 , "H:\Temp\CurrentDiskQueueLength_D.blg" ,  H:\Temp\AvailableMBytes.blg ,  H:\Temp\ProcessorTime.blg `
  | Export-Counter H:\Temp\merge.blg -FileFormat blg -Force

  Import-Counter h:\Temp\ProcessorTime.blg, H:\Temp\merge3.blg| Export-Counter H:\Temp\merge3.blg -FileFormat blg -Force


'
12/01/2015 11:27:21.696  

12/01/2015 11:26:49.695

12/01/2015 12:01:27.740


(PDH-CSV 4.0) (	

\\NETL\SQLServer:Buffer Manager\Buffer cache hit ratio	
\\NETL\Memory\Available MBytes	
\\NETL\Memory\Committed Bytes	
\\NETL\Memory\Pages/sec	

\\NETL\PhysicalDisk(0)\Current Disk Queue Length	
\\NETL\PhysicalDisk(1)\Current Disk Queue Length	
\\NETL\PhysicalDisk(2 C:)\Current Disk Queue Length	
\\NETL\PhysicalDisk(3 D:)\Current Disk Queue Length	   \\NETL\PhysicalDisk(3 D:)\Current Disk Queue Length
\\NETL\PhysicalDisk(_Total)\Current Disk Queue Length	
\\NETL\PhysicalDisk(0)\Avg. Disk Queue Length	
\\NETL\PhysicalDisk(1)\Avg. Disk Queue Length	
\\NETL\PhysicalDisk(2 C:)\Avg. Disk Queue Length	

\\NETL\PhysicalDisk(3 D:)\Avg. Disk Queue Length	

\\NETL\PhysicalDisk(_Total)\Avg. Disk Queue Length	
\\NETL\PhysicalDisk(_Total)\% Disk Time	

\\NETL\Processor(_Total)\% Processor Time
	
\\NETL\SQLServer:Access Methods\Full Scans/sec	

\\NETL\SQLServer:Databases(tempdb)\Transactions/sec	
\\NETL\SQLServer:Databases(model)\Transactions/sec	
\\NETL\SQLServer:Databases(HTACT)\Transactions/sec	
\\NETL\SQLServer:Databases(HTBDW)\Transactions/sec	
\\NETL\SQLServer:Databases(ReportServer)\Transactions/sec	
\\NETL\SQLServer:Databases(HTDB)\Transactions/sec	
\\NETL\SQLServer:Databases(BudgetManage)\Transactions/sec	
\\NETL\SQLServer:Databases(HTDB2)\Transactions/sec	
\\NETL\SQLServer:Databases(HTBIS)\Transactions/sec	
\\NETL\SQLServer:Databases(HTCBS)\Transactions/sec	
\\NETL\SQLServer:Databases(HTPER)\Transactions/sec	
\\NETL\SQLServer:Databases(HTSIN)\Transactions/sec	
\\NETL\SQLServer:Databases(HTODSB)\Transactions/sec	
\\NETL\SQLServer:Databases(HTPUB)\Transactions/sec	
\\NETL\SQLServer:Databases(BOStore2)\Transactions/sec	
\\NETL\SQLServer:Databases(HTODS)\Transactions/sec	
\\NETL\SQLServer:Databases(HTACC)\Transactions/sec	
\\NETL\SQLServer:Databases(HTODSC)\Transactions/sec	
\\NETL\SQLServer:Databases(DW)\Transactions/sec	
\\NETL\SQLServer:Databases(HTOLAP)\Transactions/sec	
\\NETL\SQLServer:Databases(ReportServerTempDB)\Transactions/sec	
\\NETL\SQLServer:Databases(VIEW_DATA)\Transactions/sec	
\\NETL\SQLServer:Databases(HTCOM)\Transactions/sec	
\\NETL\SQLServer:Databases(HTRND)\Transactions/sec	
\\NETL\SQLServer:Databases(mssqlsystemresource)\Transactions/sec	
\\NETL\SQLServer:Databases(HTEDW)\Transactions/sec	
\\NETL\SQLServer:Databases(msdb)\Transactions/sec	
\\NETL\SQLServer:Databases(_Total)\Transactions/sec	
\\NETL\SQLServer:Databases(master)\Transactions/sec	


\\NETL\SQLServer:Databases(tempdb)\Log Growths	
\\NETL\SQLServer:Databases(model)\Log Growths	
\\NETL\SQLServer:Databases(HTACT)\Log Growths	
\\NETL\SQLServer:Databases(HTBDW)\Log Growths	
\\NETL\SQLServer:Databases(ReportServer)\Log Growths	
\\NETL\SQLServer:Databases(HTDB)\Log Growths	
\\NETL\SQLServer:Databases(BudgetManage)\Log Growths	
\\NETL\SQLServer:Databases(HTDB2)\Log Growths	
\\NETL\SQLServer:Databases(HTBIS)\Log Growths	
\\NETL\SQLServer:Databases(HTCBS)\Log Growths	
\\NETL\SQLServer:Databases(HTPER)\Log Growths	
\\NETL\SQLServer:Databases(HTSIN)\Log Growths	
\\NETL\SQLServer:Databases(HTODSB)\Log Growths	
\\NETL\SQLServer:Databases(HTPUB)\Log Growths	
\\NETL\SQLServer:Databases(BOStore2)\Log Growths	
\\NETL\SQLServer:Databases(HTODS)\Log Growths	
\\NETL\SQLServer:Databases(HTACC)\Log Growths	
\\NETL\SQLServer:Databases(HTODSC)\Log Growths	
\\NETL\SQLServer:Databases(DW)\Log Growths	
\\NETL\SQLServer:Databases(HTOLAP)\Log Growths	
\\NETL\SQLServer:Databases(ReportServerTempDB)\Log Growths	
\\NETL\SQLServer:Databases(VIEW_DATA)\Log Growths	
\\NETL\SQLServer:Databases(HTCOM)\Log Growths	
\\NETL\SQLServer:Databases(HTRND)\Log Growths	
\\NETL\SQLServer:Databases(mssqlsystemresource)\Log Growths	
\\NETL\SQLServer:Databases(HTEDW)\Log Growths	
\\NETL\SQLServer:Databases(msdb)\Log Growths	
\\NETL\SQLServer:Databases(_Total)\Log Growths	
\\NETL\SQLServer:Databases(master)\Log Growths
	
\\NETL\SQLServer:Databases(_Total)\Percent Log Used	
\\NETL\SQLServer:Databases(_Total)\Data File(s) Size (KB)	
\\NETL\SQLServer:General Statistics\User Connections	

\\NETL\SQLServer:Locks(_Total)\Lock Waits/sec	

\\NETL\SQLServer:Locks(_Total)\Number of Deadlocks/sec	
\\NETL\SQLServer:Memory Manager\Total Server Memory (KB)	
\\NETL\SQLServer:SQL Errors(DB Offline Errors)\Errors/sec	
\\NETL\SQLServer:SQL Errors(Kill Connection Errors)\Errors/sec	
\\NETL\SQLServer:SQL Errors(User Errors)\Errors/sec	
\\NETL\SQLServer:SQL Errors(Info Errors)\Errors/sec	
\\NETL\SQLServer:SQL Errors(_Total)\Errors/sec	
\\NETL\SQLServer:SQL Statistics\SQL Re-Compilations/sec	

\\NETL\SQLServer:SSIS Pipeline 12.0\Rows read	
\\NETL\SQLServer:SSIS Pipeline 12.0\Rows written	
\\NETL\SQLServer:SSIS Pipeline 12.0\Buffers in use	
\\NETL\SQLServer:SSIS Pipeline 12.0\Buffer memory	
\\NETL\SQLServer:SSIS Pipeline 12.0\Private buffers in use	
\\NETL\SQLServer:SSIS Pipeline 12.0\Private buffer memory	
\\NETL\SQLServer:SSIS Pipeline 12.0\Flat buffers in use	
\\NETL\SQLServer:SSIS Pipeline 12.0\Flat buffer memory	
\\NETL\SQLServer:SSIS Pipeline 12.0\Buffers spooled	
\\NETL\SQLServer:SSIS Pipeline 12.0\BLOB bytes read	
\\NETL\SQLServer:SSIS Pipeline 12.0\BLOB bytes written	
\\NETL\SQLServer:SSIS Pipeline 12.0\BLOB files in use	


建立包含本機電腦之硬體資源、系統回應時間以及處理程序詳細資訊的報告。您可以使用使此資訊來識別效能問題的可能原因。若要執行此資料收集器集合工具，您必須是本機 Administrators 群組的成員，或具有相同權限的群組成員。

'




#---------------------------------------------------------------
#       make SQL_inventory  &  DMV_log Table Step
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
