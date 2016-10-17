<#

SQLPS01_Alwayson
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\sqlps01_alwayson.ps1
CreateDate:APR.21.2014LastDate : APR.30.2014Author :Ming Tseng  ,a0921887912@gmail.comremark 


#>

#  (01) 101  Get Alwayson  availability Groups is enables
#  (02) 117  Get instance information  using SQLPath
#  (03) 255  Get AvailabilityGroups information
#  (04) 300  configuration AlwaysOn with TSQL
#  (05) 600  adding and Managing an Availability Databases
#  5.1  735  adding and Managing an Availability Databases sp2013 and sql2012x : workable
#  5.2  800  adding and Managing an Availability Databases  sp2013wfe DataFile other load  workable
#  (06) 888  remove   add  a secondary replica
#  (07)      Availability Group with powershell   ref 4-(8)
#  8         Join-SqlAvailabilityGroup
#  9         enable AlwaysOn Availability Groups
#  10        Get who is Primary   Switch  SqlAvailabilityGroup
#  11    1100  Test-SqlAvailabilityGroup  with SQLPath
#  11.1  1200 Including User Policies   Test-SqlAvailabilityGroup
#  11.2  # 11.2   alwayson   with SMO 
#  12    1300     1   RegisterAllProvidersIP
#  13  

    http://msdn.microsoft.com/zh-tw/library/hh403386.aspx

#  14   To configure an existing availability group
#  14.1• Add a Secondary Replica to an Availability Group (SQL Server)
	• Remove a Secondary Replica from an Availability Group (SQL Server)
	• Add a Database to an Availability Group (SQL Server)
	• Remove a Secondary Database from an Availability Group (SQL Server)
	• Remove a Primary Database from an Availability Group (SQL Server)
	• Configure the Flexible Failover Policy to Control Conditions for Automatic Failover (AlwaysOn Availability Groups)
#  15 To manage an availability group
	• Configure Backup on Availability Replicas (SQL Server)
#15.2• Perform a Planned Manual Failover of an Availability Group (SQL Server)
#15.3• Perform a Forced Manual Failover of an Availability Group (SQL Server)
	• Remove an Availability Group (SQL Server)
#  16   To manage an availability replica
#16.1• Add a Secondary Replica to an Availability Group (SQL Server)
#16.2	• Join a Secondary Replica to an Availability Group (SQL Server)
#16.3	• Remove a Secondary Replica from an Availability Group (SQL Server)
#16.4	• Change the Availability Mode of an Availability Replica (SQL Server)
#16.5	• Change the Failover Mode of an Availability Replica (SQL Server)
#16.6	• Configure Backup on Availability Replicas (SQL Server)
#16.7	• Configure Read-Only Access on an Availability Replica (SQL Server)
#16.8	• Configure Read-Only Routing for an Availability Group (SQL Server)
#16.9	• Change the Session-Timeout Period for an Availability Replica (SQL Server)
#17  To manage an availability database
	• Add a Database to an Availability Group (SQL Server)
	• Join a Secondary Database to an Availability Group (SQL Server)
	• Remove a Primary Database from an Availability Group (SQL Server)
	• Remove a Secondary Database from an Availability Group (SQL Server)
	• Suspend an Availability Database (SQL Server)
	• Resume an Availability Database (SQL Server)
#18  To monitor an availability group
	• Monitoring of Availability Groups (SQL Server)

#19  To support migrating availability groups to a new WSFC cluster (cross-cluster migration)


	• Change the HADR Cluster Context of Server Instance (SQL Server)
	• Take an Availability Group Offline (SQL Server)

# (20) 1500  how to get  log_send_queue
# (21) 1500 21  what latency got introduced with choosing synchronous availability mode
#  22   1600  alwayson  DMV 
#  23  1650  dmv about alwayson  監視 WSFC 叢集中的可用性群組  Monitoring Availability Groups on the WSFC Cluster
#  24  1650    dmv  監視可用性群組 Groups  :Monitoring Availability Groups
#  25  1710  dmv  監視可用性複本 replicas  Monitoring Availability Replicas
#  26  2010  dmv  監視可用性資料庫  replicas  Monitoring Availability Databases
#  27  2400  dmv  監視可用性群組接聽程式  Monitoring Availability Group Listeners  
#  28 2500  monitor AG wiht SMO
#  29  2555   Monitor availability groups and availability replicas status information using T-SQL



















#-100---------------------------------------------------------------
#  1   Get Alwayson  availability Groups is enables
#----------------------------------------------------------------

##
SELECT SERVERPROPERTY ('IsHadrEnabled');  

##cd
Set default (cd) to the server instance 
PS SQLSERVER:\SQL\NODE1\DEFAULT> get-item . | select IsHadrEnabled
cd c:\; cd SQLSERVER:\SQL\sp2013\DEFAULT
PS SQLSERVER:\SQL\sp2013\DEFAULT> gi . | select IsHadrEnabled
gi . |select * 

Test-SqlAvailabilityGroup *

#----------------------------------------------------------------
#  117   Get instance information using SQLPath
#----------------------------------------------------------------
Set default (cd) to the server instance 
PS SQLSERVER:\SQL\NODE1\DEFAULT> gi . | select *
$idefualt=gi . ;$idefualt |select *
$t=$idefualt.AvailabilityGroups; $t |select *
{

----
DisplayName                 : DEFAULT
PSPath                      : Microsoft.SqlServer.Management.PSProvider\SqlServer::SQLSERVER:\SQL\sp2013\DEFAULT
PSParentPath                : Microsoft.SqlServer.Management.PSProvider\SqlServer::SQLSERVER:\SQL\sp2013
PSChildName                 : DEFAULT
PSDrive                     : SQLSERVER
PSProvider                  : Microsoft.SqlServer.Management.PSProvider\SqlServer
PSIsContainer               : False
AuditLevel                  : Failure
BackupDirectory             : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup
BrowserServiceAccount       : NT AUTHORITY\LOCALSERVICE
BrowserStartMode            : Auto
BuildClrVersionString       : v4.0.30319
BuildNumber                 : 3128
ClusterName                 : FC2
ClusterQuorumState          : NormalQuorum
ClusterQuorumType           : NodeAndFileshareMajority
Collation                   : Chinese_Taiwan_Stroke_CI_AS
CollationID                 : 53251
ComparisonStyle             : 196609
ComputerNamePhysicalNetBIOS : SP2013
DefaultFile                 : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\
DefaultLog                  : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\
Edition                     : Enterprise Edition (64-bit)
ErrorLogPath                : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Log
FilestreamLevel             : TSqlFullFileSystemAccess
FilestreamShareName         : MSSQLSERVER
HadrManagerStatus           : Running
InstallDataDirectory        : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL
InstallSharedDirectory      : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL
InstanceName                : 
IsCaseSensitive             : False
IsClustered                 : False
IsFullTextInstalled         : False
IsHadrEnabled               : True
IsSingleUser                : False
Language                    : English (United States)
LoginMode                   : Mixed
MailProfile                 : 
MasterDBLogPath             : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
MasterDBPath                : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
MaxPrecision                : 38
NamedPipesEnabled           : True
NetName                     : SP2013
NumberOfLogFiles            : -1
OSVersion                   : 6.2 (9200)
PerfMonMode                 : None
PhysicalMemory              : 8192
PhysicalMemoryUsageInKB     : 739380
Platform                    : NT x64
Processors                  : 2
ProcessorUsage              : 0
Product                     : Microsoft SQL Server
ProductLevel                : SP1
ResourceLastUpdateDateTime  : 10/19/2012 3:30:00 PM
ResourceVersionString       : 11.00.3000
RootDirectory               : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL
ServerType                  : Standalone
ServiceAccount              : csd\administrator
ServiceInstanceId           : MSSQL11.MSSQLSERVER
ServiceName                 : MSSQLSERVER
ServiceStartMode            : Auto
SqlCharSet                  : 13
SqlCharSetName              : cp950
SqlDomainGroup              : NT SERVICE\MSSQLSERVER
SqlSortOrder                : 0
SqlSortOrderName            : bin_ascii_8
Status                      : Online
TapeLoadWaitTime            : -1
TcpEnabled                  : True
VersionMajor                : 11
VersionMinor                : 0
VersionString               : 11.0.3128.0
Name                        : SP2013
Version                     : 11.0.3128
EngineEdition               : EnterpriseOrDeveloper
ResourceVersion             : 11.0.3000
BuildClrVersion             : 4.0.30319
DefaultTextMode             : True
Configuration               : Microsoft.SqlServer.Management.Smo.Configuration
AffinityInfo                : Microsoft.SqlServer.Management.Smo.AffinityInfo
ProxyAccount                : [SP2013]
Mail                        : [SP2013]
Databases                   : {194_SP_CentralAdminContent, 194_SP_ConfigDB, AdventureWorks2008, 
                              AdventureWorks2008R2...}
Endpoints                   : {Dedicated Admin Connection, Hadr_endpoint, TSQL Default TCP, TSQL Default VIA...}
Languages                   : {Arabic, British, čeština, Dansk...}
SystemMessages              : {21, 21, 21, 21...}
UserDefinedMessages         : {59998, 59999}
Credentials                 : {}
CryptographicProviders      : {}
Logins                      : {##MS_PolicyEventProcessingLogin##, ##MS_PolicyTsqlExecutionLogin##, 
                              CSD\administrator, CSD\Eadmin...}
Roles                       : {bulkadmin, dbcreator, diskadmin, LimitedDBA...}
LinkedServers               : {2013BI, repl_distributor, SQL2012X}
SystemDataTypes             : {bigint, binary, bit, char...}
JobServer                   : [SP2013]
ResourceGovernor            : Microsoft.SqlServer.Management.Smo.ResourceGovernor
ServiceMasterKey            : Microsoft.SqlServer.Management.Smo.ServiceMasterKey
Settings                    : Microsoft.SqlServer.Management.Smo.Settings
Information                 : Microsoft.SqlServer.Management.Smo.Information
UserOptions                 : Microsoft.SqlServer.Management.Smo.UserOptions
BackupDevices               : {}
FullTextService             : [SP2013]
ActiveDirectory             : 
Triggers                    : {}
Audits                      : {}
ServerAuditSpecifications   : {}
AvailabilityGroups          : {SPMAG}
ConnectionContext           : Data Source=SP2013;Integrated Security=True;MultipleActiveResultSets=False;Connect 
                              Timeout=30;Application Name="SQLPS (administrator@SP2013)"
Events                      : Microsoft.SqlServer.Management.Smo.ServerEvents
OleDbProviderSettings       : 
Urn                         : Server[@Name='SP2013']
Properties                  : {Name=AuditLevel/Type=Microsoft.SqlServer.Management.Smo.AuditLevel/Writable=True/Value
                              =Failure, Name=BackupDirectory/Type=System.String/Writable=True/Value=C:\Program 
                              Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup, 
                              Name=BuildNumber/Type=System.Int32/Writable=False/Value=3128, 
                              Name=DefaultFile/Type=System.String/Writable=True/Value=C:\Program Files\Microsoft SQL 
                              Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\...}
UserData                    : 
State                       : Existing
IsDesignMode                : False
DomainName                  : SMO
DomainInstanceName          : SP2013
}



#----------------------------------------------------------------
#  255 Get AvailabilityGroups information
#----------------------------------------------------------------
cd c:\;cd SQLSERVER:\sql\sp2013\sqls2
$isp2013sqls2=gi .

$isp2013sqls2 |select *

$t=$isp2013sqls2.AvailabilityGroups;$t |select *

$t |select name, AvailabilityReplicas, AvailabilityDatabases,PrimaryReplicaServerName,FailureConditionLevel,AvailabilityGroupListeners



cd c:\;cd SQLSERVER:\sql\sp2013\default
$isp2013default=gi .

$isp2013default |select *

$u=$isp2013default.AvailabilityGroups;$u |select *

$u |select name, AvailabilityReplicas, AvailabilityDatabases,PrimaryReplicaServerName,FailureConditionLevel,AvailabilityGroupListeners

cd c:\;cd SQLSERVER:\sql\sp2013wfe\default
ls; cd AvailabilityGroups ;ls
cd spmag;ls
cd AvailabilityReplicas;ls


















#----------------------------------------------------------------
#  (4)  300 configuration AlwaysOn use TSQL
#----------------------------------------------------------------
onenote:///C:\Users\Administrator\SkyDrive\onMicrosoft\SQL\Database%20Administration\HA-DR.one#*25Script&section-id={C3783363-7D6D-451E-A38D-359512D15FBF}&page-id={A3D28ABF-87D5-4C7B-81CE-9DD9AE857BEF}&end
{
(1) make sh shared folder  @primary
(2) Full backup is required  @primary
(3) drop  availability Group   [AGName]


(4) create  endpoint   @primary
(5) create  endpoint  @secondary

(6) alter event session  @primary
(7) Alter event session  @secondary

(8) Create  availability  @ primary

(9) Add listener  @primary
(10)Alter event session  @ primary

(11) backup   database  /Log     @ primary 
(12) restore database  @ secondary
(13) ALTER DATABASE   @ secondary 

(14)  Restart  :@ secondary 





---------------------------------------------------
-- (1 ) shared Folder   @ Primary
---------------------------------------------------
 \\sql-b02012\ReplData


----------------------
--(2)  : full backup is required
----------------------


BACKUP DATABASE [ssmatesterdb] TO  DISK = N'\\SP2013\repldata\Ssmatesterdb.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'ssmatesterdb-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10

GO

[SharePoint_Config] 
U:\UserDBData\SharePoint_Config.mdf
U:\UserDBLog\SharePoint_Config_log.ldf

[SharePoint_AdminContent_98922288-1f3a-438d-8647-479c11fd7b0b]  
U:\UserDBData\SharePoint_AdminContent_98922288-1f3a-438d-8647-479c11fd7b0b.mdf
U:\UserDBLog\SharePoint_AdminContent_98922288-1f3a-438d-8647-479c11fd7b0b_log.ldf

BACKUP DATABASE [SharePoint_Config] TO  DISK = N'\\SQL-M-2012\AGSync\SharePoint_Config.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'SharePoint_Config-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10

GO

BACKUP DATABASE [SharePoint_AdminContent_98922288-1f3a-438d-8647-479c11fd7b0b]
 TO  DISK = N'\\SQL-M-2012\AGSync\SharePoint_AdminContent_98922288-1f3a-438d-8647-479c11fd7b0b.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'SharePoint_AdminContent-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10

GO

BACKUP DATABASE [WSS_Content_EIPM] TO  DISK = N'\\SQL-M-2012\AGSync\WSS_Content_EIPM.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'WSS_Content_EIPM-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10

GO






------------------------------------------
--- (3)DROP AVAILABILITY GROUP [ $AGName]
------------------------------------------
USE [master]
GO
DROP AVAILABILITY GROUP [T6];
GO
--DROP ENDPOINT [Hadr_endpoint]
--GO



-----------------------------
--(4)create  ENDPOINT    @primary 
-----------------------------

CREATE ENDPOINT [Hadr_endpoint] 
	AS TCP (LISTENER_PORT = 5022)
	FOR DATA_MIRRORING (ROLE = ALL, ENCRYPTION = REQUIRED ALGORITHM AES)
GO


IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO

use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [MVDIS\spfarmadmin]
GO

--*************************************
--(5)create  ENDPOINT  :@secondary
--*************************************

IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO

use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [MVDIS\spfarmadmin]
GO
-----------------------------
--(6)ALTER EVENT SESSION   @primary
-----------------------------

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO

--*************************************
--(7)ALTER EVENT SESSION   @secondary
--*************************************
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO
-----------------------------
--(8)CREATE AVAILABILITY    @primary
-----------------------------
USE [master]
GO

CREATE AVAILABILITY GROUP [T7]
WITH (AUTOMATED_BACKUP_PREFERENCE = SECONDARY)
FOR DATABASE [WSS_Content_Rex]
REPLICA ON N'SQL-M-2012\M' WITH (ENDPOINT_URL = N'TCP://SQL-M-2012.mvdis.gov.tw:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO)),
	N'SQL-X-2012\SQLX' WITH (ENDPOINT_URL = N'TCP://SQL-X-2012.mvdis.gov.tw:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO));
GO

-----------------------------
--(9)ADD LISTENER   :@primary
-----------------------------


USE [master]
GO
ALTER AVAILABILITY GROUP [T7]
ADD LISTENER N'SPM' (
WITH IP
((N'10.0.23.117', N'255.255.255.0'),
(N'10.1.23.117', N'255.255.255.0')
)
, PORT=1433);

--USE [master]
--GO
--ALTER AVAILABILITY GROUP [T7]
--REMOVE LISTENER N'T7Lr';
--GO


GO
--*************************************
--(10)ALTER EVENT SESSION  :@primary
--*************************************

ALTER AVAILABILITY GROUP [T7] JOIN;
GO

------------------------------------------
--- (11) backup   database  /Log     @ primary 
------------------------------------------


--BACKUP DATABASE WSS_Content_Rex TO  DISK = N'\\SQL-M-2012\AGSync\WSS_Content_Rex.bak' 
--WITH  NOFORMAT, NOINIT, SKIP, NOUNLOAD, NOREWIND,  STATS = 10

--GO

BACKUP DATABASE WSS_Content_Rex TO  DISK = N'\\SQL-M-2012\AGSync\WSS_Content_Rex.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'WSS_Content_Rex-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10


BACKUP LOG WSS_Content_Rex 
TO  DISK = N'\\SQL-M-2012\AGSync\WSS_Content_Rex.trn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO


GO

--****************************************
--- (12)  restore database  @ secondary
--****************************************
Restore filelistonly from disk='\\SQL-M-2012\AGSync\WSS_Content_Rex.bak'

--drop database WSS_Content_Rex


Restore database WSS_Content_Rex
From disk ='\\SQL-M-2012\AGSync\WSS_Content_Rex.bak'
with replace, NORECOVERY,
Move 'WSS_Content_Rex' to  'U:\UserDBData\WSS_Content_Rex.mdf',
move 'WSS_Content_Rex_log' to 'U:\UserDBData\WSS_Content_Rex_log.ldf'
go

GO

RESTORE LOG WSS_Content_Rex FROM  DISK = N'\\SQL-M-2012\AGSync\WSS_Content_Rex.trn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5


--****************************************
--- (13)    ALTER DATABASE   @ secondary 
--****************************************




-- Wait for the replica to start communicating
begin try
declare @conn bit
declare @count int
declare @replica_id uniqueidentifier 
declare @group_id uniqueidentifier
set @conn = 0
set @count = 30 -- wait for 5 minutes 

if (serverproperty('IsHadrEnabled') = 1)
	and (isnull((select member_state from master.sys.dm_hadr_cluster_members where upper(member_name COLLATE Latin1_General_CI_AS) = upper(cast(serverproperty('ComputerNamePhysicalNetBIOS') as nvarchar(256)) COLLATE Latin1_General_CI_AS)), 0) <> 0)
	and (isnull((select state from master.sys.database_mirroring_endpoints), 1) = 0)
begin
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'AGTEST'
	select @replica_id = replicas.replica_id from master.sys.availability_replicas as replicas where upper(replicas.replica_server_name COLLATE Latin1_General_CI_AS) = upper(@@SERVERNAME COLLATE Latin1_General_CI_AS) and group_id = @group_id
	while @conn <> 1 and @count > 0
	begin
		set @conn = isnull((select connected_state from master.sys.dm_hadr_availability_replica_states as states where states.replica_id = @replica_id), 1)
		if @conn = 1
		begin
			-- exit loop when the replica is connected, or if the query cannot find the replica status
			break
		end
		waitfor delay '00:00:10'
		set @count = @count - 1
	end
end
end try
begin catch
	-- If the wait loop fails, do not stop execution of the alter database statement
end catch


--ALTER DATABASE [$DBName] SET HADR AVAILABILITY GROUP = [$AGName];

ALTER DATABASE SharePoint_Config  SET HADR AVAILABILITY GROUP = [T7];
ALTER DATABASE [SharePoint_AdminContent_98922288-1f3a-438d-8647-479c11fd7b0b] SET HADR AVAILABILITY GROUP = [T7];
ALTER DATABASE WSS_Content_EIPM SET HADR AVAILABILITY GROUP = [T7];
GO


GO


--****************************************
--- (14)  Restart  @ secondary 
--****************************************

}


#----------------------------------------------------------------
#  05 600  adding and Managing an Availability Databases
#----------------------------------------------------------------
{
SqlAvailabilityDatabase(Add, remove, suspend, resume)
## TSQL
:Connect SP2013

USE [master]
GO
ALTER AVAILABILITY GROUP [AGTEST]  ADD DATABASE [ssmatesterdb];
GO

:Connect SP2013
BACKUP DATABASE [ssmatesterdb] TO  DISK = N'\\SP2013\repldata\ssmatesterdb.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO

:Connect sql2012X
RESTORE DATABASE [ssmatesterdb] FROM  DISK = N'\\SP2013\repldata\ssmatesterdb.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO

:Connect SP2013
BACKUP LOG [ssmatesterdb] TO  DISK = N'\\SP2013\repldata\ssmatesterdb_20131023023748.trn' WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO

:Connect sql2012X
RESTORE LOG [ssmatesterdb] FROM  DISK = N'\\SP2013\repldata\ssmatesterdb_20131023023748.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO

:Connect sql2012X
-- Wait for the replica to start communicating
begin try
declare @conn bit
declare @count int
declare @replica_id uniqueidentifier 
declare @group_id uniqueidentifier
set @conn = 0
set @count = 30 -- wait for 5 minutes 

if (serverproperty('IsHadrEnabled') = 1)
	and (isnull((select member_state from master.sys.dm_hadr_cluster_members where upper(member_name COLLATE Latin1_General_CI_AS) = upper(cast(serverproperty('ComputerNamePhysicalNetBIOS') as nvarchar(256)) COLLATE Latin1_General_CI_AS)), 0) <> 0)
	and (isnull((select state from master.sys.database_mirroring_endpoints), 1) = 0)
begin
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'AGTEST'
	select @replica_id = replicas.replica_id from master.sys.availability_replicas as replicas where upper(replicas.replica_server_name COLLATE Latin1_General_CI_AS) = upper(@@SERVERNAME COLLATE Latin1_General_CI_AS) and group_id = @group_id
	while @conn <> 1 and @count > 0
	begin
		set @conn = isnull((select connected_state from master.sys.dm_hadr_availability_replica_states as states where states.replica_id = @replica_id), 1)
		if @conn = 1
		begin
			-- exit loop when the replica is connected, or if the query cannot find the replica status
			break
		end
		waitfor delay '00:00:10'
		set @count = @count - 1
	end
end
end try
begin catch
	-- If the wait loop fails, do not stop execution of the alter database statement
end catch




ALTER DATABASE [ssmatesterdb] SET HADR AVAILABILITY GROUP = [AGTEST];

GO

###  powershell

## 0 parameter
gwmi -Class Win32_Share

$DatabaseBackupFile = "\\SQL2012X\share\SQLInventory.bak"
$LogBackupFile = "\\SQL2012X\share\SQLInventory.trn"

$Node1Name="SP2013"
$Node2Name="SQL2012X"
$Instance1Name="default"
$Instance2Name="default"

$AGName="SPMAG"
$AddAGDatabase="SQL_Inventory"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
## 1 Backup

Invoke-Sqlcmd {BACKUP DATABASE [SQL_Inventory] TO  DISK = N'\\SQL2012X\share\SQLInventory0506.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5 } -ServerInstance $Node1Name 
Invoke-Sqlcmd {BACKUP DATABASE [SQL_Inventory] TO  DISK = N'\\SQL2012X\share\SQLInventory0506.trn' WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5} -ServerInstance $Node1Name 

Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance $Node1Name
Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance $Node1Name -BackupAction 'Log'

##--alter database sql_inventory set recovery full

Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance "$Node1Name\$Instance1Name"
Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance "$Node1Name\$Instance1Name" -BackupAction 'Log'

#create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

Invoke-Sqlcmd {RESTORE DATABASE [SQL_Inventory]  FROM Disk ='\\SQL2012X\share\SQLInventory0457.bak'  WITH Replace,RECOVERY
} -ServerInstance $Node2Name 
Invoke-Sqlcmd {RESTORE LOG [SQL_Inventory]  FROM Disk ='\\SQL2012X\share\SQLInventory0457.trn' WITH  NORECOVERY
} -ServerInstance $Node2Name 

Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance $Node2Name -NoRecovery
Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance $Node2Name -RestoreAction 'Log' -NoRecovery

Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance "SecondaryServer\InstanceName" -NoRecovery
Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance "SecondaryServer\InstanceName" -RestoreAction 'Log' -NoRecovery



Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

$rd=$MyAgPrimaryPath+"\AvailabilityDatabases\"+$AddAGDatabase
Remove-SqlAvailabilityDatabase -Path $rd 
                                     
Suspend-SqlAvailabilityDatabase -Path $rd 

Resume-SqlAvailabilityDatabase -Path $rd 

}






#----------------------------------------------------------------
#  5.1  735 adding and Managing an Availability Databases sp2013 and sql2012x : workable
#----------------------------------------------------------------

###  powershell

## 0 parameter
gwmi -Class Win32_Share

$DatabaseBackupFile = "\\SQL2012X\share\SQLInventory.bak"
$LogBackupFile = "\\SQL2012X\share\SQLInventory.trn"

$Node1Name="SP2013"
$Node2Name="SQL2012X"
$Instance1Name="default"
$Instance2Name="default"

$AGName="SPMAG"
$AddAGDatabase="SQL_Inventory"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
## 1 Backup

Invoke-Sqlcmd { BACKUP DATABASE SQL_Inventory TO  DISK = N'\\SQL2012X\share\SQLInventory.bak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
} -ServerInstance $Node1Name 

Invoke-Sqlcmd {BACKUP LOG SQL_Inventory TO  DISK = N'\\SQL2012X\share\SQLInventory.trn'
 WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
 } -ServerInstance $Node1Name 


#create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

Invoke-Sqlcmd {RESTORE DATABASE SQL_Inventory FROM  DISK = N'\\SQL2012X\share\SQLInventory.bak' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
} -ServerInstance $Node2Name 
Invoke-Sqlcmd {RESTORE LOG SQL_Inventory FROM  DISK = N'\\SQL2012X\share\SQLInventory.trn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
} -ServerInstance $Node2Name 


Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

$rd=$MyAgPrimaryPath+"\AvailabilityDatabases\"+$AddAGDatabase
Remove-SqlAvailabilityDatabase -Path $rd 
                                     
Suspend-SqlAvailabilityDatabase -Path $rd 

Resume-SqlAvailabilityDatabase -Path $rd 










#----------------------------------------------------------------
#  5.2  800 adding and Managing an Availability Databases  sp2013wfe DataFile other load  workable
#----------------------------------------------------------------


#create database
<Sqlps07_General  #26  580  Create   database>
CREATE DATABASE [SQL_Inventory] ON(NAME = N'SQLInventory',FILENAME = N'E:\SQLDB\SQL_Inventory.mdf',SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024MB )LOG ON(NAME = N'SQLInventory_log',FILENAME = N'E:\SQLDB\SQL_Inventory_log.LDF',SIZE = 512MB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)


## 0 parameter
gwmi -Class Win32_Share

$DatabaseBackupFile = "\\SQL2012X\share\SQLInventory.bak"
$LogBackupFile = "\\SQL2012X\share\SQLInventory.trn"

$Node1Name="SP2013"
$Node2Name="SP2013wfe"
$Instance1Name="default"
$Instance2Name="default"

$AGName="SPMAG"
$AddAGDatabase="SQL_Inventory"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
## 1 Backup

Invoke-Sqlcmd { BACKUP DATABASE SQL_Inventory TO  DISK = N'\\SQL2012X\share\SQLInventory.bak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
} -ServerInstance $Node1Name 

Invoke-Sqlcmd {BACKUP LOG SQL_Inventory TO  DISK = N'\\SQL2012X\share\SQLInventory.trn'
 WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
 } -ServerInstance $Node1Name 




## 2 Restore

Invoke-Sqlcmd {RESTORE DATABASE SQL_Inventory FROM  DISK = N'\\SQL2012X\share\SQLInventory.bak' 
WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5,
  MOVE 'SQL_Inventory' TO N'E:\SQLDB\SQL_Inventory.mdf', 
  MOVE 'SQL_Inventory_log'  TO N'E:\SQLDB\SQL_Inventory.ldf';

} -ServerInstance $Node2Name 
Invoke-Sqlcmd {RESTORE LOG SQL_Inventory FROM  DISK = N'\\SQL2012X\share\SQLInventory.trn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
} -ServerInstance $Node2Name 


#Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

$rd=$MyAgPrimaryPath+"\AvailabilityDatabases\"+$AddAGDatabase
Remove-SqlAvailabilityDatabase -Path $rd 
                                     
Suspend-SqlAvailabilityDatabase -Path $rd 

Resume-SqlAvailabilityDatabase -Path $rd 


#
$DelAGDatabase="WSS_Content_spload"
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#SQLSERVER:\SQL\SP2013wfe\default\AvailabilityGroups\SPMAG
$dd=$MyAgPrimaryPath+"\AvailabilityDatabases\"+$DelAGDatabase
Remove-SqlAvailabilityDatabase -Path $dd 












#----------------------------------------------------------------
#  6  888  remove   add  a secondary replica
#---------------------------------------------------------------
SqlAvailabilityReplica ( add ,remove set )

##---- Get
$PrimaryPath="SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName+"\AvailabilityReplicas\"

cd c:\;cd SQLSERVER:\sql\sp2013\default
$isp2013default=gi .  ;$isp2013default |select *
$u=$isp2013default.AvailabilityGroups ;$u |select *

#$u |select name, AvailabilityReplicas,EndpointUrl

foreach ($item in $u )
{
    $item.AvailabilityReplicas |select name, EndpointUrl,FailoverMode,AvailabilityMode
    #$item.AvailabilityReplicas |select *
}



##---- ADD
#tsql
ALTER AVAILABILITY GROUP MyAG ADD REPLICA ON 'COMPUTER04' 
   WITH (
         ENDPOINT_URL = 'TCP://COMPUTER04.Adventure-Works.com:5022',
         AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT,
         FAILOVER_MODE = MANUAL
         );

#powershell  (Apr.21.2014 Not work !)
  $AGName="SPMAG"
  $Node1Name="SP2013"
  $Instance1Name="Default"
  $Replica="SP2013WFE"
  #$agPath = "SQLSERVER:\Sql\PrimaryServer\InstanceName\AvailabilityGroups\MyAg"
  $PrimaryPath="SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName

  $endpointURL = "TCP://SP2013.CSD.syscom:5022"
  $failoverMode = "Manual"
  $availabilityMode = "AsynchronousCommit"
  $secondaryReadMode = "AllowAllConnections"

 New-SqlAvailabilityReplica -Name $Replica -EndpointUrl $endpointURL ` 
  -FailoverMode $failoverMode ` 
  -AvailabilityMode $availabilityMode ` 
  -ConnectionModeInSecondaryRole $secondaryReadMode ` 
  -Path $PrimaryPath


  
 New-SqlAvailabilityReplica -Name "SP2013WFE" -EndpointUrl "TCP://SP2013.CSD.syscom:5022" ` 
  -FailoverMode "Manual" -AvailabilityMode "AsynchronousCommit" -ConnectionModeInSecondaryRole "AllowAllConnections"` 
  -Path "SQLSERVER:\SQL\SP2013\Default\AvailabilityGroups\SPMAG"

  >$agPath = "SQLSERVER:\Sql\PrimaryServer\InstanceName\AvailabilityGroups\MyAg"
    $endpointURL = "TCP://PrimaryServerName.domain.com:5022"
    $failoverMode = "Manual"
    $availabilityMode = "AsynchronousCommit"
    $secondaryReadMode = "AllowAllConnections"
    New-SqlAvailabilityReplica -Name SecondaryServer\Instance -EndpointUrl $endpointURL 
    -FailoverMode $failoverMode -AvailabilityMode $availabilityMode 
    -ConnectionModeInSecondaryRole $secondaryReadMode -Path $agPath


##---- REMOVE  
    #tsql
    ALTER AVAILABILITY GROUP SPMAG REMOVE REPLICA ON 'COMPUTER02\HADR_INSTANCE';


    ##powershell

$AGName="SPMAG"
$Node1Name="SP2013"
$Instance1Name="Default"
$Replica="SP2013WFE"
$PrimaryPath="SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName+"\AvailabilityReplicas\"+$Replica

Remove-SqlAvailabilityReplica ` 
-Path SQLSERVER:\SQL\PrimaryServer\InstanceName\AvailabilityGroups\MyAg\AvailabilityReplicas\MyReplica

Remove-SqlAvailabilityReplica -Path $PrimaryPath
#----------------------------------------------------------------
#  7    Availability Group with powershell   ref 4-(8)
#---------------------------------------------------------------



#----------------------------------------------------------------
#  8    Join-SqlAvailabilityGroup
#---------------------------------------------------------------

## Tsql
  ALTER AVAILABILITY GROUP MyAG JOIN;

## Poweshell
$Node2Name="SP2013"
$Instance2Name="default"
$AGSecondaryPathInstance = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name
$AGName="SPMAG"

Join-SqlAvailabilityGroup -Path SQLSERVER:\SQL\SecondaryServer\InstanceName -Name 'MyAg'
Join-SqlAvailabilityGroup -Path $AGSecondaryPathInstance -Name $AGName


#----------------------------------------------------------------
#   9   enable AlwaysOn Availability Groups
#---------------------------------------------------------------

$Node1Name="SP2013"
$Node2Name="SP2013wfe"
$Instance1Name="default"
$Instance2Name="default"

$AGName="SPMAG"
$AddAGDatabase="SQL_Inventory"

$AGPrimaryPathInstance = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name


Enable-SqlAlwaysOn -Path $AGPrimaryPathInstance  #restart SQL services 
Disable-SqlAlwaysOn -Path $AGPrimaryPathInstance -Confirm:$False  -NoServiceRestart -Force

#----------------------------------------------------------------
#   10  900  Get who is Primary   Switch  SqlAvailabilityGroup
#---------------------------------------------------------------

##
cd c:\;cd SQLSERVER:\sql\sp2013\default
$sqlpathinstance=gi .  ;$sqlpathinstance |select *
$sqlpathAG=$sqlpathinstance.AvailabilityGroups ;$sqlpathAG |select PrimaryReplicaServerName
$sqlpathReplicas =$sqlpathAG.AvailabilityReplicas; $sqlpathReplicas | select *

$sqlpathReplicas |select  name,FailoverMode,role

## 

@Connect SQL2012X (primary to SQL2012X)
ALTER AVAILABILITY GROUP [SPMAG] FAILOVER;



##

$Node1Name="SP2013"
$Node2Name="SP2013wfe"
$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SPMAG"
$AddAGDatabase="SQL_Inventory"

$AGPrimaryPathInstance = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name

# primary (sp2013) to (SQL2012X)
Switch-SqlAvailabilityGroup -Path SQLSERVER:\Sql\sql2012x\Default\AvailabilityGroups\SPMAG #workable run@sp2013

# primary (SQL2012X) to (sp2013)
Switch-SqlAvailabilityGroup -Path SQLSERVER:\Sql\sp2013\Default\AvailabilityGroups\SPMAG #workable run@sp2013


    
#----------------------------------------------------------------
#  11  1100  Test-SqlAvailabilityGroup  with SQLPath
#---------------------------------------------------------------- sqlpsgh Test-SqlAvailabilityGroup -full$env:userdomain\$env:USERNAME
dir $env:computerName
cd SQLSERVER:\SQL\$env:computerName\DEFAULT\AvailabilityGroups
ls
{<#'PS SQLSERVER:\SQL>
                  (1) MachineName  : sp2013
(2)Instance Name    DEFAULT /SQLS2
                  Audits                                                                           
                (3)AvailabilityGroups  ---------------->  Name                     PrimaryReplicaServerName    
                  BackupDevices                          (4) SPMAG
                  Credentials                              (5) \AvailabilityDatabases                                                                        
                  CryptographicProviders                                  Name                 SynchronizationState IsSuspended IsJoined                  
                  Databases                                               ----                 -------------------- ----------- --------    
                  Endpoints                                               194_SP_CentralAdm... Synchronized         False       True                     
                  JobServer                                               194_SP_ConfigDB      Synchronized         False       True             
                  Languages                                               SQL_Inventory        Synchronized         False       True            
                  LinkedServers                                                                                                             
                  Logins                                   (5) \AvailabilityGroupListeners     
                  Mail                                                   Name                 PortNumber      ClusterIPConfiguration                                                                                      
                  ResourceGovernor                                       ----                 ----------      ----------------------                                                                                      
                  Roles                                                  SPM                  1433            ('IP Address: 172.16.220.161')                                                                              
                  ServerAuditSpecifications                (5) \AvailabilityReplicas     
                  SystemDataTypes                                        Name                 Role      ConnectionState RollupSynchronizationState
                  SystemMessages                                         ----                 ----      --------------- --------------------------
                  Triggers                                               SP2013               Primary   Connected       Synchronized              
                  UserDefinedMessages'                                   SP2013WFE            Secondary Connected       Synchronized              
                                                                         SQL2012X             Secondary Connected       Synchronized              
                                                           (5) \DatabaseReplicaStates                                                                                                                                                                                                                         
                                                                        AvailabilityReplicaServerName AvailabilityDatabaseName SynchronizationState  EstimatedRecoveryTime    SynchronizationPerformance LogSendQueueSize
                                                                        ----------------------------- ------------------------ --------------------  ---------------------    -------------------------- ----------------
                                                                        SP2013                        194_SP_CentralAdminCo... Synchronized          -1                       -1                         -1              
                                                                        SP2013                        194_SP_ConfigDB          Synchronized          -1                       -1                         -1              
                                                                        SP2013                        SQL_Inventory            Synchronized          -1                       -1                         -1              
                                                                        SP2013WFE                     194_SP_CentralAdminCo... Synchronized          0                        0                          0               
                                                                        SP2013WFE                     194_SP_ConfigDB          Synchronized          0                        0                          0               
                                                                        SP2013WFE                     SQL_Inventory            Synchronized          0                        0                          0               
                                                                        SQL2012X                      194_SP_CentralAdminCo... Synchronized          0                        0                          0               
                                                                        SQL2012X                      194_SP_ConfigDB          Synchronized          0                        0                          0               
                                                                        SQL2012X                      SQL_Inventory            Synchronized          0                        0                          0               
#> }                                                                       

cd SQLSERVER:\SQL\ (1)  \  (2)  \        (3)      \  (4) \     (5)
cd SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityDatabases     ;ls
cd SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityGroupListeners;ls
cd SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas      ;ls
cd SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag\DatabaseReplicaStates     ;ls
cd SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag
cd SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups     #(3)
cd SQLSERVER:\SQL\SP2013\DEFAULT               #(2)
cd SQLSERVER:\SQL\SP2013   #(1)
cd SQLSERVER:\SQL


Test-SqlAvailabilityGroup spmag    # (3)


$result=Test-SqlAvailabilityGroup .\spmag          # (3)
$result | select * 
 
$result.PolicyEvaluationDetails | ft Result,Name -AutoSize
$result.PolicyEvaluationDetails |sort name | Out-GridView 
'
PS SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups> $result.PolicyEvaluationDetails |sort name 

Result TargetObject         Category                            Name                                                                             
------ ------------         --------                            ----                                                                             
True   [SPMAG]              Availability group errors (prima... AlwaysOnAgAutomaticFailoverHealthPolicy                                          
True   [SPMAG]              Availability group errors (any r... AlwaysOnAgOnlineStateHealthPolicy                                                
True   [SPMAG]              Availability group warnings (pri... AlwaysOnAgReplicasConnectionHealthPolicy                                         
True   [SPMAG]              Availability group warnings (pri... AlwaysOnAgReplicasDataSynchronizationHealthPolicy                                
True   [SPMAG]              Availability group warnings (pri... AlwaysOnAgReplicasRoleHealthPolicy                                               
True   [SPMAG]              Availability group warnings (pri... AlwaysOnAgSynchronousReplicasDataSynchronizationHealthPolicy                     
True   [SP2013]             Availability group errors (any r... AlwaysOnAgWSFClusterHealthPolicy 
'
$result.HealthState  # Unknown 代表可能不是是Primary .Healthy : 再加上 $sqlpathAG |select PrimaryReplicaServerName

cd SQLSERVER:\SQL\$env:computerName\DEFAULT\
$sqlpathinstance=gi .  ;$sqlpathinstance |select *
$sqlpathAG=$sqlpathinstance.AvailabilityGroups ;$sqlpathAG |select PrimaryReplicaServerName
$sqlpathReplicas =$sqlpathAG.AvailabilityReplicas; $sqlpathReplicas | select *



##
pwd
{dir;cd .\AvailabilityReplicas

--PS SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\sp2013\AvailabilityReplicas> dir

Name                 Role      ConnectionState RollupSynchronizationState
----                 ----      --------------- --------------------------
SP2013               Primary   Connected       Synchronized              
SQL2012X             Secondary Connected       Synchronized
}
##
cd SQLSERVER:\SQL
Test-SqlAvailabilityGroup    SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups
Test-SqlAvailabilityReplica  SQLSERVER:\SQL\sp2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas\sp2013  -NoRefresh
Test-SqlAvailabilityReplica  SQLSERVER:\SQL\sp2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas\sql2012x
Test-SqlDatabaseReplicaState

#----------------------------------------------------------------
# 11.1   1200 Including User Policies
#---------------------------------------------------------------
{<#
'You are able to extend the default AlwaysOn health model with your own policies.  I won’t go into details here about how to create these custom policies, but please refer to this post for more information.  

By default, the AlwaysOn health cmdlets won’t evaluate user policies; however you can force them to do so by specifying the AllowUserPolicies parameter, supported by all three cmdlets.  This is a simple switch parameter:
#>}
Test-SqlAvailabilityGroup .\spmag -ShowPolicyDetails -AllowUserPolicies


Test-SqlAvailabilityReplica 
Test-SqlAvailabilityReplica  SQLSERVER:\SQL\sql2012x\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas
#----------------------------------------------------------------
# 11.2   alwayson with SMO
#---------------------------------------------------------------
##naïve approach
$serverObj = New-Object Microsoft.SqlServer.Management.Smo.Server("sp2013")
$ag = $serverObj.AvailabilityGroups["spmag"]

$ag |select *
 $ag.DatabaseReplicaStates
Measure-Command { $ag.DatabaseReplicaStates | Test-SqlDatabaseReplicaState }

##optimized approach
• http://blogs.msdn.com/b/mwories/archive/2005/04/22/smoperf1.aspx
• http://blogs.msdn.com/b/mwories/archive/2005/04/22/smoperf2.aspx


$ServerObj = New-Object Microsoft.SqlServer.Management.Smo.Server("sp2013")
$ServerObj.SetDefaultInitFields([Microsoft.SqlServer.Management.Smo.AvailabilityGroup], $true)
$ServerObj.SetDefaultInitFields([Microsoft.SqlServer.Management.Smo.AvailabilityReplica], $true)
$ServerObj.SetDefaultInitFields([Microsoft.SqlServer.Management.Smo.DatabaseReplicaState], $true)
Measure-Command { $ag.DatabaseReplicaStates | Test-SqlDatabaseReplicaState -NoRefresh }






#----------------------------------------------------------------
# 12 1200  1   RegisterAllProvidersIP
#---------------------------------------------------------------
cluadmin

Import-Module FailoverClusters
Get-ClusterResource
Get-ClusterResource SPMAG_SPM |Get-ClusterParameter RegisterAllProvidersIP
Get-ClusterResource  | Set-ClusterParameter RegisterAllProvidersIP 0 
Get-ClusterResource yourListenerName|Set-ClusterParameter HostRecordTTL 300
Stop-ClusterResource yourListenerName
Start-ClusterResource yourListenerName
cluadmin




#----------------------------------------------------------------
# 13 1115  1   RegisterAllProvidersIP
#---------------------------------------------------------------
ssms

gsv '*sql*'

(gsv -Name MSSQLSERVER).Stop();sleep 5 ;(gsv -Name MSSQLSERVER).Status
(gsv -Name MSSQLSERVER).start();
(gsv -Name MSSQLSERVER).Status

icm -ComputerName sql2012x {$env:computername}
icm  sql2012x {(gsv -Name MSSQLSERVER).Stop()}
icm  sql2012x {(gsv -Name MSSQLSERVER).start()}

icm -ComputerName sql2012x {(gsv -Name MSSQLSERVER).Stop()}
icm  sql2012x {(gsv -Name MSSQLSERVER).Status} |select PSComputerName,value
invoke-sqlcmd -ServerInstance sql2012x -Query "select @@SERVERNAME"

invoke-sqlcmd -ServerInstance sp2013 -Query "select @@SERVERNAME"
do
{
   invoke-sqlcmd -ServerInstance spm -Query "select @@SERVERNAME"
   sleep 1 
}
until ($x -gt 0)



Forcing failover of an availability group

ALTER AVAILABILITY GROUP AccountsAG FORCE_FAILOVER_ALLOW_DATA_LOSS;
GO

#---------------------------------------------------------------
#15.2• Perform a Planned Manual Failover of an Availability Group (SQL Server)
#---------------------------------------------------------------
##TSQL
ALTER AVAILABILITY GROUP MyAg FAILOVER;

##PS

Switch-SqlAvailabilityGroup -Path SQLSERVER:\Sql\SecondaryServer\InstanceName\AvailabilityGroups\MyAg

#---------------------------------------------------------------
#15.3• Perform a Forced Manual Failover of an Availability Group
#---------------------------------------------------------------
##TsQL
連接到裝載需要容錯移轉之可用性群組中，其角色為 SECONDARY 或 RESOLVING 狀態之複本的伺服器執行個體。
ALTER AVAILABILITY GROUP AccountsAG FORCE_FAILOVER_ALLOW_DATA_LOSS;

##PS
Switch-SqlAvailabilityGroup `
   -Path SQLSERVER:\Sql\SecondaryServer\InstanceName\AvailabilityGroups\MyAg `
   -AllowDataLoss


#---------------------------------------------------------------
#16.7	• Configure Read-Only Access on an Availability Replica
#---------------------------------------------------------------

http://msdn.microsoft.com/zh-tw/library/hh403386.aspx

'將可用性複本加入至可用性群組時，請使用 New-SqlAvailabilityReplica 指令程式。 
修改現有的可用性複本時，請使用 Set-SqlAvailabilityReplica 指令程式。 
相關參數如下所示：
'
設定次要角色的連接存取，請指定 ConnectionModeInSecondaryRolesecondary_role_keyword 參數
 
secondary_role_keyword 等於下列其中一個值
AllowNoConnections: 不允許直接連接次要複本的資料庫，這些資料庫也不可用於讀取存取。 這是預設設定。
AllowReadIntentConnectionsOnly 次要複本的資料庫只允許 Application Intent 屬性設為 ReadOnly 的連接
AllowAllConnections  次要複本的資料庫允許所有連接進行唯讀存取

'
若要設定主要角色的連接存取，
請指定 ConnectionModeInPrimaryRoleprimary_role_keyword，其中 

primary_role_keyword 等於下列其中一個值：

AllowReadWriteConnections :不允許 Application Intent 連接屬性設為 ReadOnly 的連接。 當 Application Intent 屬性設為 ReadWrite 或是未設定 Application Intent 連接屬性時，便會允許連接。 如需有關 Application Intent 連接屬性的詳細資訊，請參閱＜搭配 SQL Server Native Client 使用連接字串關鍵字＞。
AllowAllConnections :主要複本的資料庫允許所有連接。 這是預設設定。


'


Set-Location SQLSERVER:\SQL\PrimaryServer\default\AvailabilityGroups\MyAg
$primaryReplica = Get-Item "AvailabilityReplicas\PrimaryServer"

Set-SqlAvailabilityReplica -ConnectionModeInSecondaryRole "AllowAllConnections" ` 
-InputObject $primaryReplica

Set-SqlAvailabilityReplica -ConnectionModeInPrimaryRole "AllowAllConnections" ` 
-InputObject $primaryReplica

















#----------------------------------------------------------------
#     PowerShell Cmdlets for AlwaysOn Availability Groups (SQL Server)
#---------------------------------------------------------------
http://technet.microsoft.com/en-us/library/ff878391.aspx

Configuring a server instance for AlwaysOn Availability Groups (SqlAlwaysOn :Enable/Disable,SqlHadrEndPoint Get , New)

Backing up and restoring databases and transaction logs (Backup-SqlDatabase, Restore-SqlDatabase )
Creating and managing an availability group (SqlAvailabilityGroup : New, Set, Remove, Switch)
Creating and managing an availability group listener (SqlAvailabilityGroupListener : New,Set, Join, Remvoe)
Creating and managing an availability replica (SqlAvailabilityReplica (New , Join ,set, Remove)
Adding and managing an availability database (Add-SqlAvailabilityDatabase : Add, remove , resume, suspend)
Monitoring availability group health  (Test-)

http://technet.microsoft.com/en-us/library/ff878259.aspx

#----------------------------------------------------------------
#     Import-Module “sqlps” -DisableNameChecking
#---------------------------------------------------------------

Import-Module “sqlps” -DisableNameChecking 
sqlps

#---------------------Level 1 Get-PSDrive |select name,root

#---------------------Level 2  cd sqlserver:\

PS SQLSERVER:\>   ''
dir
<#
Name            Root                           Description                             
----            ----                           -----------                             
SQL             SQLSERVER:\SQL                 SQL Server Database Engine              
SQLPolicy       SQLSERVER:\SQLPolicy           SQL Server Policy Management            
SQLRegistration SQLSERVER:\SQLRegistration     SQL Server Registrations                
DataCollection  SQLSERVER:\DataCollection      SQL Server Data Collection              
XEvent          SQLSERVER:\XEvent              SQL Server Extended Events              
Utility         SQLSERVER:\Utility             SQL Server Utility                      
DAC             SQLSERVER:\DAC                 SQL Server Data-Tier Application Component                               
SSIS            SQLSERVER:\SSIS                SQL Server Integration Services         
SQLAS           SQLSERVER:\SQLAS               SQL Server Analysis Services            

#>
#---------------------Level 3   PS SQLSERVER:\sql> 
cd sql ;dir ; pwd  
<#PS SQLSERVER:\sql> dir

MachineName                     
-----------                     
SP2013                          
#>



#---------------------Level 4  PS SQLSERVER:\sql\sp2013
cd sp2013 ;pwd ; 'PS SQLSERVER:\sql\sp2013> '
ls 
<#PS SQLSERVER:\sql\sp2013> dir

Instance Name                                                                   
-------------                                                                   
DEFAULT                                                                         
SQLS2                                                                           
#>

$l4=ls;pwd
$l4.count
$i=0
foreach ($item in $l4)
{
    $i=$i+1 ; $i;$item.Name
}

#---------------------Level 5 
cd default 'PS SQLSERVER:\sql\sp2013\default> '
$l5=ls
<#
PS SQLSERVER:\sql\sp2013\default> dir
Audits
AvailabilityGroups  <------
BackupDevices
Credentials
CryptographicProviders
Databases
Endpoints
JobServer
Languages
LinkedServers
Logins
Mail
ResourceGovernor
Roles
ServerAuditSpecifications
SystemDataTypes
SystemMessages
Triggers
UserDefinedMessages
#>


cd ..;
cd Databases
$l6db=ls

$l6db |? name -eq WSS_Content_spload  |select *
#---------------------Level 6 ag
cd AvailabilityGroups
$l6ag=ls;$l6ag
<#PS SQLSERVER:\sql\sp2013\default\AvailabilityGroups> ls

Name                 PrimaryReplicaServerName        
----                 ------------------------        
SPMAG                SQL2012X  #>

#---------------------Level 7 PS SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag
cd spmag;ls

PS SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag
<#
> ls
AvailabilityDatabases
AvailabilityGroupListeners
AvailabilityReplicas
DatabaseReplicaStates#>

ls | Test-SqlAvailabilityReplica

Test-SqlAvailabilityGroup -Path SQLSERVER:\Sql\Computer\Instance\AvailabilityGroups\MyAg
Test-SqlAvailabilityGroup -Path SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag

cd  AvailabilityReplicas ; ls
Test-SqlAvailabilityReplica

Test-SqlAvailabilityReplica SQLSERVER:\sql\sp2013\default\AvailabilityGroups\spmag\AvailabilityReplicas\sp2013

Test-SqlAvailabilityReplica SQLSERVER:\sql\sp2013\default\AvailabilityGroups\spmag\AvailabilityReplicas\sql2012x
Test-SqlAvailabilityReplica SQLSERVER:\sql\sp2013\default\AvailabilityGroups\spmag\AvailabilityReplicas\sp2013wfe


ls


#----------------------------------------------------------------
#     SQLSERVER:\SQL
#---------------------------------------------------------------- 
##
dir | Test-SqlAvailabilityReplicacd spmag--PS SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas> 
cd AvailabilityReplicas
dir |Test-SqlAvailabilityReplica
lityReplica

HealthState            AvailabilityGroup    Name                                                                          
-----------            -----------------    ----                                                                          
Healthy                SP2013               SP2013                                                                        
Healthy                SP2013               SQL2012X  cd..;cd .\DatabaseReplicaStates;dir-- AvailabilityReplicaServerName AvailabilityDatabaseName SynchronizationState  EstimatedRecoveryTime    SynchronizationPerfo
                                                                                                      rmance              
----------------------------- ------------------------ --------------------  ---------------------    --------------------
SP2013                        194_SP_CentralAdminCo... Synchronized          -1                       -1                  
SP2013                        194_SP_ConfigDB          Synchronized          -1                       -1                  
SP2013                        T1                       Synchronized          -1                       -1                  
SQL2012X                      194_SP_CentralAdminCo... Synchronized          0                        0                   
SQL2012X                      194_SP_ConfigDB          Synchronized          0                        0                   
SQL2012X                      T1                       Synchronized          -1                       -1                  
#----------------------------------------------------------------
#     SQLSERVER:\SQL
#---------------------------------------------------------------- 
{dir |Test-SqlDatabaseReplicaState

PS SQLSERVER:\SQL\SP2013\DEFAULT\AvailabilityGroups\sp2013\DatabaseReplicaStates> dir |Test-SqlDatabaseReplicaState

HealthState            AvailabilityGroup    AvailabilityReplica  Name                                                     
-----------            -----------------    -------------------  ----                                                     
Healthy                SP2013               SP2013               194_SP_CentralAdminContent                               
Healthy                SP2013               SP2013               194_SP_ConfigDB                                          
Healthy                SP2013               SP2013               T1                                                       
Healthy                SP2013               SQL2012X             194_SP_CentralAdminContent                               
Healthy                SP2013               SQL2012X             194_SP_ConfigDB                                          
Healthy                SP2013               SQL2012X             T1 
}

#----------------------------------------------------------------
# (20) 1500  how to get  log_send_queue
#----------------------------------------------------------------
$SQL_select="SELECT ag.name AS ag_name
, ar.replica_server_name AS ag_replica_server
, dr_state.database_id as database_id
,DB_NAME(dr_state.database_id) as database_Name
,dr_state.log_send_queue_size
, is_ag_replica_local = CASE 
	WHEN ar_state.is_local = 1 THEN N'LOCAL' 
	ELSE 'REMOTE' 
	END 
, ag_replica_role = CASE 
	WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED' 
	ELSE ar_state.role_desc  
	END 
FROM (( sys.availability_groups AS ag JOIN sys.availability_replicas AS ar ON ag.group_id = ar.group_id ) 
JOIN sys.dm_hadr_availability_replica_states AS ar_state  ON ar.replica_id = ar_state.replica_id) 
JOIN sys.dm_hadr_database_replica_states dr_state on ag.group_id = dr_state.group_id and dr_state.replica_id = ar_state.replica_id
where   dr_state.database_id = DB_ID('SQL_Inventory')
"

do
{
    Invoke-Sqlcmd 
}
until ($x -gt 0)

(gsv -Name '*MSSQLSERVER*').stop


icm -ComputerName sql2012x {$env:computername}
icm  sp2013wfe {(gsv -Name MSSQLSERVER).status}
icm  sp2013wfe {(gsv -Name MSSQLSERVER).Stop()}
icm  sp2013wfe {(gsv -Name MSSQLSERVER).start()}

icm  sql2012x {(gsv -Name MSSQLSERVER).status}
icm  sql2012x {(gsv -Name MSSQLSERVER).Stop()}
icm  sql2012x {(gsv -Name MSSQLSERVER).start()}

#----------------------------------------------------------------
#   21  what latency got introduced with choosing synchronous availability mode
#----------------------------------------------------------------
所有的計數器重設為
DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR);
GO


select 
wait_type
, waiting_tasks_count  --這個等候類型的等候次數。 這個計數器是從每次開始等候時逐量遞增計算
, wait_time_ms  --這個等候類型的總等候時間 (以毫秒為單位)
, wait_time_ms/waiting_tasks_count as'time_per_wait'  --
from sys.dm_os_wait_stats where waiting_tasks_count >0 
and wait_type = 'HADR_SYNC_COMMIT'
#----------------------------------------------------------------
# 22 alwayson  DMV 
#----------------------------------------------------------------

select * from sys.availability_databases_cluster             --database
select * from sys.availability_group_listener_ip_addresses   --listeners
select * from sys.availability_group_listeners               --listeners
select * from sys.availability_groups                        --groups
select * from sys.availability_read_only_routing_lists  
select * from sys.availability_replicas                      --rplicas

select * from sys.database_mirroring_endpoints               --configure

select * from sys.dm_hadr_auto_page_repair                         

select * from sys.dm_hadr_availability_group_states            --groups  
select * from sys.dm_hadr_availability_replica_cluster_nodes   --replicas 
select * from sys.dm_hadr_availability_replica_cluster_states  --replicas
select * from sys.dm_hadr_availability_replica_states          --replicas
select * from sys.dm_hadr_cluster                              --WSFC
select * from sys.dm_hadr_cluster_members                      --WSFC
select * from sys.dm_hadr_cluster_networks                     --listeners

select * from sys.dm_hadr_database_replica_cluster_states      --replica

select * from sys.dm_hadr_database_replica_states  --replica

select * from sys.dm_hadr_instance_node_map     --WSFC
select * from sys.dm_hadr_name_id_map            --WSFC
 
select * from sys.dm_os_performance_counters
select * from sys.dm_tcp_listener_states 
--select * from sys.fn_hadr_backup_is_preferred_replica




#----------------------------------------------------------------
#  23  dmv about alwayson  監視 WSFC 叢集中的可用性群組  Monitoring Availability Groups on the WSFC Cluster
#----------------------------------------------------------------
##

select * from sys.dm_hadr_cluster 
select * from sys.dm_hadr_cluster_members 
select * from sys.dm_hadr_cluster_networks 
select * from sys.dm_hadr_instance_node_map 
select * from sys.dm_hadr_name_id_map 
{
select ag_name,node_name,instance_name from sys.dm_hadr_instance_node_map  inm
join  sys.dm_hadr_name_id_map  nip on inm.ag_resource_id=nip.ag_resource_id

}

#----------------------------------------------------------------
#  24  1650    dmv  監視可用性群組 Groups  :Monitoring Availability Groups
#----------------------------------------------------------------
select * from sys.availability_groups 
select * from sys.availability_groups_cluster
select * from sys.dm_hadr_availability_group_states  

##
PS SQLSERVER:\> $sql="select * from sys.availability_groups" 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{
group_id                         : 16950bd6-e98a-4254-affc-d37e205e0fbc
name                             : TradeDBAG
resource_id                      : 4b395736-2086-4f7d-ae03-eb190e4a6d15
resource_group_id                : 2f5a40ef-9590-4fe3-ab52-293b88c786b1
failure_condition_level          : 3
health_check_timeout             : 30000
automated_backup_preference      : 2
automated_backup_preference_desc : secondary

group_id                         : 822b1114-a943-481d-a7a1-7768f5213c83
name                             : heartbeatAG
resource_id                      : acfa70f5-c347-4e6f-99c7-b01655ba5ecb
resource_group_id                : 38f4ab46-4563-404c-9900-daef7f4e94ad
failure_condition_level          : 3
health_check_timeout             : 30000
automated_backup_preference      : 2
automated_backup_preference_desc : secondary

}
##
$sql="select * from sys.availability_groups_cluster" 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{

group_id                         : 16950bd6-e98a-4254-affc-d37e205e0fbc
name                             : TradeDBAG
resource_id                      : 4b395736-2086-4f7d-ae03-eb190e4a6d15
resource_group_id                : 2f5a40ef-9590-4fe3-ab52-293b88c786b1
failure_condition_level          : 3
health_check_timeout             : 30000
automated_backup_preference      : 2
automated_backup_preference_desc : secondary

group_id                         : 822b1114-a943-481d-a7a1-7768f5213c83
name                             : heartbeatAG
resource_id                      : acfa70f5-c347-4e6f-99c7-b01655ba5ecb
resource_group_id                : 38f4ab46-4563-404c-9900-daef7f4e94ad
failure_condition_level          : 3
health_check_timeout             : 30000
automated_backup_preference      : 2
automated_backup_preference_desc : secondary
}
##
$sql="select * from sys.dm_hadr_availability_group_states" 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{

group_id                       : 16950bd6-e98a-4254-affc-d37e205e0fbc
primary_replica                : TRADESQLCLUSTER
primary_recovery_health        : 1
primary_recovery_health_desc   : ONLINE
secondary_recovery_health      : 
secondary_recovery_health_desc : 
synchronization_health         : 2
synchronization_health_desc    : HEALTHY

group_id                       : 822b1114-a943-481d-a7a1-7768f5213c83
primary_replica                : TRADEDB114
primary_recovery_health        : 
primary_recovery_health_desc   : 
secondary_recovery_health      : 
secondary_recovery_health_desc : 
synchronization_health         : 0
synchronization_health_desc    : NOT_HEALTHY




PS SQLSERVER:\> }



#----------------------------------------------------------------
#  25  1710  dmv  監視可用性複本 replicas  Monitoring Availability Replicas
#----------------------------------------------------------------
select * from sys.availability_replicas 
--select * from sys.availability_read_only_routing_lists 
select * from sys.dm_hadr_availability_replica_cluster_nodes 
select * from sys.dm_hadr_availability_replica_cluster_states 
select * from sys.dm_hadr_availability_replica_states 
--select * from sys.fn_hadr_backup_is_preferred_replica 
##
$sql="select * from sys.availability_replicas"
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{<#
PS SQLSERVER:\> 
$sql="select * from sys.availability_replicas"
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB


replica_id                            : ed524c13-5abd-447d-bf73-8c47ccdfc637
group_id                              : 822b1114-a943-481d-a7a1-7768f5213c83
replica_metadata_id                   : 
replica_server_name                   : TRADEDB113
owner_sid                             : 
endpoint_url                          : TCP://192.168.168.113:5022
availability_mode                     : 1
availability_mode_desc                : SYNCHRONOUS_COMMIT
failover_mode                         : 0
failover_mode_desc                    : AUTOMATIC
session_timeout                       : 10
primary_role_allow_connections        : 2
primary_role_allow_connections_desc   : ALL
secondary_role_allow_connections      : 2
secondary_role_allow_connections_desc : ALL
create_date                           : 
modify_date                           : 
backup_priority                       : 50
read_only_routing_url                 : 

replica_id                            : db2b43cb-aa7c-41b9-bede-ecbe345dff36
group_id                              : 822b1114-a943-481d-a7a1-7768f5213c83
replica_metadata_id                   : 
replica_server_name                   : TRADEDB114
owner_sid                             : 
endpoint_url                          : TCP://192.168.168.114:5022
availability_mode                     : 1
availability_mode_desc                : SYNCHRONOUS_COMMIT
failover_mode                         : 0
failover_mode_desc                    : AUTOMATIC
session_timeout                       : 10
primary_role_allow_connections        : 2
primary_role_allow_connections_desc   : ALL
secondary_role_allow_connections      : 2
secondary_role_allow_connections_desc : ALL
create_date                           : 
modify_date                           : 
backup_priority                       : 50
read_only_routing_url                 : 

replica_id                            : 5aa33a3a-4c57-4fe7-8359-eae9dd4cabca
group_id                              : 822b1114-a943-481d-a7a1-7768f5213c83
replica_metadata_id                   : 65537
replica_server_name                   : TRADESQLCLUSTER
owner_sid                             : {1, 5, 0, 0...}
endpoint_url                          : TCP://192.168.168.111:5022
availability_mode                     : 1
availability_mode_desc                : SYNCHRONOUS_COMMIT
failover_mode                         : 1
failover_mode_desc                    : MANUAL
session_timeout                       : 10
primary_role_allow_connections        : 2
primary_role_allow_connections_desc   : ALL
secondary_role_allow_connections      : 2
secondary_role_allow_connections_desc : ALL
create_date                           : 2014/6/27 下午 04:23:24
modify_date                           : 2014/6/27 下午 04:23:24
backup_priority                       : 50
read_only_routing_url                 : 

replica_id                            : 286f6f7f-ba67-44b5-b7d9-ad12b4229b76
group_id                              : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_metadata_id                   : 65536
replica_server_name                   : TRADESQLCLUSTER
owner_sid                             : {1, 5, 0, 0...}
endpoint_url                          : TCP://TRADESQLCLUSTER.eaidbdm.entrust.c
                                        om.tw:5022
availability_mode                     : 1
availability_mode_desc                : SYNCHRONOUS_COMMIT
failover_mode                         : 1
failover_mode_desc                    : MANUAL
session_timeout                       : 10
primary_role_allow_connections        : 2
primary_role_allow_connections_desc   : ALL
secondary_role_allow_connections      : 2
secondary_role_allow_connections_desc : ALL
create_date                           : 2014/6/16 下午 04:24:51
modify_date                           : 2014/6/16 下午 04:24:51
backup_priority                       : 50
read_only_routing_url                 : 

replica_id                            : 3844f779-c844-4203-9e93-e7a00cec37c0
group_id                              : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_metadata_id                   : 
replica_server_name                   : TRADEDB114
owner_sid                             : 
endpoint_url                          : TCP://TradeDB114.eaidbdm.entrust.com.tw
                                        :5022
availability_mode                     : 1
availability_mode_desc                : SYNCHRONOUS_COMMIT
failover_mode                         : 0
failover_mode_desc                    : AUTOMATIC
session_timeout                       : 10
primary_role_allow_connections        : 2
primary_role_allow_connections_desc   : ALL
secondary_role_allow_connections      : 2
secondary_role_allow_connections_desc : ALL
create_date                           : 
modify_date                           : 
backup_priority                       : 50
read_only_routing_url                 : 

replica_id                            : 2c400a93-6d95-4861-8120-42061ad68672
group_id                              : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_metadata_id                   : 
replica_server_name                   : TRADEDB113
owner_sid                             : 
endpoint_url                          : TCP://TradeDB113.eaidbdm.entrust.com.tw
                                        :5022
availability_mode                     : 1
availability_mode_desc                : SYNCHRONOUS_COMMIT
failover_mode                         : 0
failover_mode_desc                    : AUTOMATIC
session_timeout                       : 10
primary_role_allow_connections        : 2
primary_role_allow_connections_desc   : ALL
secondary_role_allow_connections      : 2
secondary_role_allow_connections_desc : ALL
create_date                           : 
modify_date                           : 
backup_priority                       : 50
read_only_routing_url                 : 


#>}


##
 $sql="select * from  sys.dm_hadr_availability_replica_cluster_nodes "
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{<#
group_name                 replica_server_name        node_name                
----------                 -------------------        ---------                
TradeDBAG                  TRADESQLCLUSTER            TRADEDB111               
TradeDBAG                  TRADESQLCLUSTER            TRADEDB112               
TradeDBAG                  TRADEDB114                 TRADEDB114               
TradeDBAG                  TRADEDB113                 TRADEDB113               
heartbeatAG                TRADEDB113                 TRADEDB113               
heartbeatAG                TRADEDB114                 TRADEDB114               
heartbeatAG                TRADESQLCLUSTER            TRADEDB111               
heartbeatAG                TRADESQLCLUSTER            TRADEDB112               
#>}

##
$sql="select * from  sys.dm_hadr_availability_replica_cluster_states  "
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB

{<#
replica_id          : 286f6f7f-ba67-44b5-b7d9-ad12b4229b76
replica_server_name : TRADESQLCLUSTER
group_id            : 16950bd6-e98a-4254-affc-d37e205e0fbc
join_state          : 2
join_state_desc     : JOINED_FCI

replica_id          : 3844f779-c844-4203-9e93-e7a00cec37c0
replica_server_name : TRADEDB114
group_id            : 16950bd6-e98a-4254-affc-d37e205e0fbc
join_state          : 1
join_state_desc     : JOINED_STANDALONE

replica_id          : 2c400a93-6d95-4861-8120-42061ad68672
replica_server_name : TRADEDB113
group_id            : 16950bd6-e98a-4254-affc-d37e205e0fbc
join_state          : 1
join_state_desc     : JOINED_STANDALONE

replica_id          : ed524c13-5abd-447d-bf73-8c47ccdfc637
replica_server_name : TRADEDB113
group_id            : 822b1114-a943-481d-a7a1-7768f5213c83
join_state          : 1
join_state_desc     : JOINED_STANDALONE

replica_id          : db2b43cb-aa7c-41b9-bede-ecbe345dff36
replica_server_name : TRADEDB114
group_id            : 822b1114-a943-481d-a7a1-7768f5213c83
join_state          : 1
join_state_desc     : JOINED_STANDALONE

replica_id          : 5aa33a3a-4c57-4fe7-8359-eae9dd4cabca
replica_server_name : TRADESQLCLUSTER
group_id            : 822b1114-a943-481d-a7a1-7768f5213c83
join_state          : 2
join_state_desc     : JOINED_FCI
#>}

##
$sql="select * from  sys.dm_hadr_availability_replica_states"
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{<#
replica_id                     : 286f6f7f-ba67-44b5-b7d9-ad12b4229b76
group_id                       : 16950bd6-e98a-4254-affc-d37e205e0fbc
is_local                       : True
role                           : 1
role_desc                      : PRIMARY
operational_state              : 2
operational_state_desc         : ONLINE
connected_state                : 1
connected_state_desc           : CONNECTED
recovery_health                : 1
recovery_health_desc           : ONLINE
synchronization_health         : 2
synchronization_health_desc    : HEALTHY
last_connect_error_number      : 
last_connect_error_description : 
last_connect_error_timestamp   : 

replica_id                     : 3844f779-c844-4203-9e93-e7a00cec37c0
group_id                       : 16950bd6-e98a-4254-affc-d37e205e0fbc
is_local                       : False
role                           : 2
role_desc                      : SECONDARY
operational_state              : 
operational_state_desc         : 
connected_state                : 1
connected_state_desc           : CONNECTED
recovery_health                : 
recovery_health_desc           : 
synchronization_health         : 2
synchronization_health_desc    : HEALTHY
last_connect_error_number      : 
last_connect_error_description : 
last_connect_error_timestamp   : 

replica_id                     : 2c400a93-6d95-4861-8120-42061ad68672
group_id                       : 16950bd6-e98a-4254-affc-d37e205e0fbc
is_local                       : False
role                           : 2
role_desc                      : SECONDARY
operational_state              : 
operational_state_desc         : 
connected_state                : 1
connected_state_desc           : CONNECTED
recovery_health                : 
recovery_health_desc           : 
synchronization_health         : 2
synchronization_health_desc    : HEALTHY
last_connect_error_number      : 
last_connect_error_description : 
last_connect_error_timestamp   : 

replica_id                     : 5aa33a3a-4c57-4fe7-8359-eae9dd4cabca
group_id                       : 822b1114-a943-481d-a7a1-7768f5213c83
is_local                       : True
role                           : 2
role_desc                      : SECONDARY
operational_state              : 2
operational_state_desc         : ONLINE
connected_state                : 0
connected_state_desc           : DISCONNECTED
recovery_health                : 
recovery_health_desc           : 
synchronization_health         : 0
synchronization_health_desc    : NOT_HEALTHY
last_connect_error_number      : 64
last_connect_error_description : The connection was closed by the remote end, o
                                 r an error occurred while receiving data: '64(
                                 指定的網路名稱無法使用。)'
last_connect_error_timestamp   : 2014/7/14 上午 06:28:08

#>}

## get group_name ,replica_server_name
$sql="select distinct group_name,arcs.replica_server_name,node_name  from sys.dm_hadr_availability_replica_cluster_states arcs
join sys.dm_hadr_availability_replica_cluster_nodes arcn  on arcs.replica_server_name=arcn.replica_server_name"
{<#
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB

group_name                 replica_server_name        node_name                
----------                 -------------------        ---------                
heartbeatAG                TRADEDB113                 TRADEDB113               
heartbeatAG                TRADEDB114                 TRADEDB114               
heartbeatAG                TRADESQLCLUSTER            TRADEDB111               
heartbeatAG                TRADESQLCLUSTER            TRADEDB112               
TradeDBAG                  TRADEDB113                 TRADEDB113               
TradeDBAG                  TRADEDB114                 TRADEDB114               
TradeDBAG                  TRADESQLCLUSTER            TRADEDB111               
TradeDBAG                  TRADESQLCLUSTER            TRADEDB112               
#>}



#----------------------------------------------------------------
#  26  2010  dmv  監視可用性資料庫  replicas  Monitoring Availability Databases
#----------------------------------------------------------------
select * from sys.availability_databases_cluster  
select name,replica_id,group_database_id  from sys.databases   where replica_id is not null                      
select * from sys.dm_hadr_auto_page_repair        
select * from sys.dm_hadr_database_replica_states 
select * from sys.dm_hadr_database_replica_cluster_states 

##
$sql="select * from  sys.availability_databases_cluster" 
 Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB |fl
{<#

group_id          : 16950bd6-e98a-4254-affc-d37e205e0fbc
group_database_id : acdb1cbf-5801-414f-a075-bbe140fb36a3
database_name     : trade

group_id          : 822b1114-a943-481d-a7a1-7768f5213c83
group_database_id : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
database_name     : heartbeatDB
#>}


##
 $sql="select name,replica_id,group_database_id  from sys.databases,database_id    where replica_id is not null " 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB |fl
Invoke-Sqlcmd  -Query $sql  -ServerInstance heartbeatDB |fl 
 
{<#
                    @ TradeDB

name              : trade
replica_id        : 286f6f7f-ba67-44b5-b7d9-ad12b4229b76
group_database_id : acdb1cbf-5801-414f-a075-bbe140fb36a3
database_id       : 6


                     @ heartbeatDB
name              : trade
replica_id        : 3844f779-c844-4203-9e93-e7a00cec37c0
group_database_id : acdb1cbf-5801-414f-a075-bbe140fb36a3
database_id       : 7

name              : heartbeatDB
replica_id        : db2b43cb-aa7c-41b9-bede-ecbe345dff36
group_database_id : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
database_id       : 8


#>}

##
PS SQLSERVER:\>  
$sql=" select * from sys.dm_hadr_database_replica_states "
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB |fl
Invoke-Sqlcmd  -Query $sql  -ServerInstance heartbeatDB |fl 
{<#

database_id                 : 6
group_id                    : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_id                  : 2c400a93-6d95-4861-8120-42061ad68672
group_database_id           : acdb1cbf-5801-414f-a075-bbe140fb36a3
is_local                    : False
synchronization_state       : 2
synchronization_state_desc  : SYNCHRONIZED
is_commit_participant       : True
synchronization_health      : 2
synchronization_health_desc : HEALTHY
database_state              : 
database_state_desc         : 
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 4294967295429496729500001
truncation_lsn              : 10175000021686900001
last_sent_lsn               : 1
last_sent_time              : 2014/7/14 上午 11:33:57
last_received_lsn           : 10227000241966000001
last_received_time          : 2014/7/14 上午 11:33:57
last_hardened_lsn           : 10227000241966100001
last_hardened_time          : 2014/7/14 上午 11:33:57
last_redone_lsn             : 10227000241966000001
last_redone_time            : 2014/7/14 上午 11:33:28
log_send_queue_size         : 0
log_send_rate               : 2000
redo_queue_size             : 0
redo_rate                   : 1166
filestream_send_rate        : 0
end_of_log_lsn              : 10227000241966000001
last_commit_lsn             : 0
last_commit_time            : 
low_water_mark_for_ghosts   : 2044114396

database_id                 : 6
group_id                    : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_id                  : 3844f779-c844-4203-9e93-e7a00cec37c0
group_database_id           : acdb1cbf-5801-414f-a075-bbe140fb36a3
is_local                    : False
synchronization_state       : 2
synchronization_state_desc  : SYNCHRONIZED
is_commit_participant       : True
synchronization_health      : 2
synchronization_health_desc : HEALTHY
database_state              : 
database_state_desc         : 
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 4294967295429496729500001
truncation_lsn              : 10175000021686900001
last_sent_lsn               : 1
last_sent_time              : 2014/7/14 上午 11:33:31
last_received_lsn           : 10227000241966000001
last_received_time          : 2014/7/14 上午 11:33:31
last_hardened_lsn           : 10227000241966100001
last_hardened_time          : 2014/7/14 上午 11:33:31
last_redone_lsn             : 10227000241966000001
last_redone_time            : 2014/7/14 上午 11:33:28
log_send_queue_size         : 0
log_send_rate               : 0
redo_queue_size             : 0
redo_rate                   : 140
filestream_send_rate        : 0
end_of_log_lsn              : 10227000241966000001
last_commit_lsn             : 0
last_commit_time            : 
low_water_mark_for_ghosts   : 2044114396

database_id                 : 6
group_id                    : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_id                  : 286f6f7f-ba67-44b5-b7d9-ad12b4229b76
group_database_id           : acdb1cbf-5801-414f-a075-bbe140fb36a3
is_local                    : True
synchronization_state       : 2
synchronization_state_desc  : SYNCHRONIZED
is_commit_participant       : True
synchronization_health      : 2
synchronization_health_desc : HEALTHY
database_state              : 0
database_state_desc         : ONLINE
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 4294967295429496729500001
truncation_lsn              : 10175000021686900001
last_sent_lsn               : 
last_sent_time              : 
last_received_lsn           : 
last_received_time          : 
last_hardened_lsn           : 10227000241966100001
last_hardened_time          : 
last_redone_lsn             : 
last_redone_time            : 
log_send_queue_size         : 
log_send_rate               : 
redo_queue_size             : 
redo_rate                   : 
filestream_send_rate        : 
end_of_log_lsn              : 10227000241966000001
last_commit_lsn             : 0
last_commit_time            : 
low_water_mark_for_ghosts   : 2044114396


                       @ heartbeatDB


database_id                 : 7
group_id                    : 16950bd6-e98a-4254-affc-d37e205e0fbc
replica_id                  : 3844f779-c844-4203-9e93-e7a00cec37c0
group_database_id           : acdb1cbf-5801-414f-a075-bbe140fb36a3
is_local                    : True
synchronization_state       : 2
synchronization_state_desc  : SYNCHRONIZED
is_commit_participant       : False
synchronization_health      : 2
synchronization_health_desc : HEALTHY
database_state              : 0
database_state_desc         : ONLINE
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 10227000241965700001
truncation_lsn              : 10175000021686900001
last_sent_lsn               : 1
last_sent_time              : 2014/7/14 下午 03:01:51
last_received_lsn           : 10227000241966000001
last_received_time          : 2014/7/14 下午 03:01:51
last_hardened_lsn           : 10227000241966100001
last_hardened_time          : 2014/7/14 上午 11:33:27
last_redone_lsn             : 10227000241966000001
last_redone_time            : 2014/7/14 上午 11:33:28
log_send_queue_size         : 0
log_send_rate               : 0
redo_queue_size             : 0
redo_rate                   : 140
filestream_send_rate        : 0
end_of_log_lsn              : 10227000241966000001
last_commit_lsn             : 0
last_commit_time            : 
low_water_mark_for_ghosts   : 

database_id                 : 8
group_id                    : 822b1114-a943-481d-a7a1-7768f5213c83
replica_id                  : 5aa33a3a-4c57-4fe7-8359-eae9dd4cabca
group_database_id           : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
is_local                    : False
synchronization_state       : 0
synchronization_state_desc  : NOT SYNCHRONIZING
is_commit_participant       : False
synchronization_health      : 0
synchronization_health_desc : NOT_HEALTHY
database_state              : 
database_state_desc         : 
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 1
truncation_lsn              : 450000000634100001
last_sent_lsn               : 1
last_sent_time              : 2014/7/10 下午 05:30:10
last_received_lsn           : 1
last_received_time          : 2014/7/10 下午 05:30:10
last_hardened_lsn           : 0
last_hardened_time          : 2014/7/10 下午 05:30:10
last_redone_lsn             : 0
last_redone_time            : 2014/7/10 下午 05:30:10
log_send_queue_size         : 0
log_send_rate               : 0
redo_queue_size             : 0
redo_rate                   : 0
filestream_send_rate        : 0
end_of_log_lsn              : 0
last_commit_lsn             : 0
last_commit_time            : 
low_water_mark_for_ghosts   : 

database_id                 : 8
group_id                    : 822b1114-a943-481d-a7a1-7768f5213c83
replica_id                  : ed524c13-5abd-447d-bf73-8c47ccdfc637
group_database_id           : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
is_local                    : False
synchronization_state       : 2
synchronization_state_desc  : SYNCHRONIZED
is_commit_participant       : True
synchronization_health      : 2
synchronization_health_desc : HEALTHY
database_state              : 
database_state_desc         : 
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 4294967295429496729500001
truncation_lsn              : 450000000634400001
last_sent_lsn               : 1
last_sent_time              : 2014/7/10 下午 05:30:22
last_received_lsn           : 450000000638000001
last_received_time          : 2014/7/10 下午 05:30:22
last_hardened_lsn           : 450000000638100001
last_hardened_time          : 2014/7/10 下午 05:30:22
last_redone_lsn             : 450000000638000001
last_redone_time            : 2014/7/10 下午 05:29:47
log_send_queue_size         : 0
log_send_rate               : 9500
redo_queue_size             : 0
redo_rate                   : 5000
filestream_send_rate        : 0
end_of_log_lsn              : 450000000638000001
last_commit_lsn             : 450000000635700012
last_commit_time            : 2014/7/10 下午 04:02:37
low_water_mark_for_ghosts   : 1433

database_id                 : 8
group_id                    : 822b1114-a943-481d-a7a1-7768f5213c83
replica_id                  : db2b43cb-aa7c-41b9-bede-ecbe345dff36
group_database_id           : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
is_local                    : True
synchronization_state       : 2
synchronization_state_desc  : SYNCHRONIZED
is_commit_participant       : True
synchronization_health      : 2
synchronization_health_desc : HEALTHY
database_state              : 0
database_state_desc         : ONLINE
is_suspended                : False
suspend_reason              : 
suspend_reason_desc         : 
recovery_lsn                : 4294967295429496729500001
truncation_lsn              : 450000000634400001
last_sent_lsn               : 
last_sent_time              : 
last_received_lsn           : 
last_received_time          : 
last_hardened_lsn           : 450000000638100001
last_hardened_time          : 
last_redone_lsn             : 
last_redone_time            : 
log_send_queue_size         : 
log_send_rate               : 
redo_queue_size             : 
redo_rate                   : 
filestream_send_rate        : 
end_of_log_lsn              : 450000000638000001
last_commit_lsn             : 450000000635700012
last_commit_time            : 2014/7/10 下午 04:02:37
low_water_mark_for_ghosts   : 1433

#>}
##
PS SQLSERVER:\> $sql=" select * from sys.dm_hadr_database_replica_cluster_states  "
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB |fl
{<#
replica_id                   : 286f6f7f-ba67-44b5-b7d9-ad12b4229b76
group_database_id            : acdb1cbf-5801-414f-a075-bbe140fb36a3
database_name                : trade
is_failover_ready            : True
is_pending_secondary_suspend : False
is_database_joined           : True
recovery_lsn                 : 4294967295429496729500001
truncation_lsn               : 10175000021686900001

replica_id                   : 3844f779-c844-4203-9e93-e7a00cec37c0
group_database_id            : acdb1cbf-5801-414f-a075-bbe140fb36a3
database_name                : trade
is_failover_ready            : True
is_pending_secondary_suspend : False
is_database_joined           : True
recovery_lsn                 : 4294967295429496729500001
truncation_lsn               : 10175000021686900001

replica_id                   : 2c400a93-6d95-4861-8120-42061ad68672
group_database_id            : acdb1cbf-5801-414f-a075-bbe140fb36a3
database_name                : trade
is_failover_ready            : True
is_pending_secondary_suspend : False
is_database_joined           : True
recovery_lsn                 : 4294967295429496729500001
truncation_lsn               : 10175000021686900001

replica_id                   : ed524c13-5abd-447d-bf73-8c47ccdfc637
group_database_id            : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
database_name                : heartbeatDB
is_failover_ready            : True
is_pending_secondary_suspend : False
is_database_joined           : True
recovery_lsn                 : 4294967295429496729500001
truncation_lsn               : 450000000634100001

replica_id                   : db2b43cb-aa7c-41b9-bede-ecbe345dff36
group_database_id            : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
database_name                : heartbeatDB
is_failover_ready            : True
is_pending_secondary_suspend : False
is_database_joined           : True
recovery_lsn                 : 4294967295429496729500001
truncation_lsn               : 450000000634100001

replica_id                   : 5aa33a3a-4c57-4fe7-8359-eae9dd4cabca
group_database_id            : 8c4fbec2-83a7-4dad-9b22-fb3c431092af
database_name                : heartbeatDB
is_failover_ready            : False
is_pending_secondary_suspend : False
is_database_joined           : False
recovery_lsn                 : 1
truncation_lsn               : 450000000634100001

#>}

#----------------------------------------------------------------
#  27 2400  dmv  監視可用性群組接聽程式  Monitoring Availability Group Listeners  
#----------------------------------------------------------------
##  傳回虛擬 IP 位址
$sql="select * from  sys.availability_group_listener_ip_addresses" 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{
listener_id                  : 5268c6f6-acf7-4a71-905c-111796f9dd56
ip_address                   : 172.22.168.119
ip_subnet_mask               : 255.255.255.0
is_dhcp                      : False
network_subnet_ip            : 172.22.168.0
network_subnet_prefix_length : 24
network_subnet_ipv4_mask     : 255.255.255.0
state                        : 1
state_desc                   : ONLINE

listener_id                  : e836ac38-f982-493b-b13b-e716653a3336
ip_address                   : 172.22.168.118
ip_subnet_mask               : 255.255.255.0
is_dhcp                      : False
network_subnet_ip            : 172.22.168.0
network_subnet_prefix_length : 24
network_subnet_ipv4_mask     : 255.255.255.0
state                        : 1
state_desc                   : ONLINE


}
##  傳回 dns_name, port 
$sql="select * from sys.availability_group_listeners " 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB


{

group_id                             : 822b1114-a943-481d-a7a1-7768f5213c83
listener_id                          : 5268c6f6-acf7-4a71-905c-111796f9dd56
dns_name                             : heartbeatDB
port                                 : 1433
is_conformant                        : True
ip_configuration_string_from_cluster : ('IP Address: 172.22.168.119')

group_id                             : 16950bd6-e98a-4254-affc-d37e205e0fbc
listener_id                          : e836ac38-f982-493b-b13b-e716653a3336
dns_name                             : TradeDB
port                                 : 1433
is_conformant                        : True
ip_configuration_string_from_cluster : ('IP Address: 172.22.168.118')
}

## 針對每個 TCP 接聽程式傳回一個包含動態狀態資訊的資料列
$sql="select * from sys.dm_tcp_listener_states " 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB

{PS SQLSERVER:\> $sql="select * from sys.dm_tcp_listener_states " 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB


listener_id : 17
ip_address  : 172.22.168.118
is_ipv4     : True
port        : 1433
type        : 0
type_desc   : TSQL
state       : 0
state_desc  : ONLINE
start_time  : 2014/7/14 上午 03:33:27

listener_id : 2
ip_address  : 172.22.168.117
is_ipv4     : True
port        : 5022
type        : 2
type_desc   : DATABASE_MIRRORING
state       : 0
state_desc  : ONLINE
start_time  : 2014/6/18 上午 09:10:37

listener_id : 1
ip_address  : 172.22.168.117
is_ipv4     : True
port        : 1433
type        : 0
type_desc   : TSQL
state       : 0
state_desc  : ONLINE
start_time  : 2014/6/18 上午 09:10:37}


##   get listener'  dns_name,ip_address ,port,state_desc


$sql="select dns_name,ip_address ,port,state_desc  from sys.availability_group_listeners agl
join  sys.availability_group_listener_ip_addresses aglipa on agl.listener_id=aglipa.listener_id
 " 
Invoke-Sqlcmd  -Query $sql  -ServerInstance TradeDB
{<#
dns_name            ip_address                         port state_desc         
--------            ----------                         ---- ----------         
heartbeatDB         172.22.168.119                     1433 ONLINE             
TradeDB             172.22.168.118                     1433 ONLINE             
#>
}



#----------------------------------------------------------------
#   28 2500  monitor AG wiht SMO
#---------------------------------------------------------------- 
.\monitorag.ps1 -ServerName "myserver\myinstance" -GroupName "MyAvailabilityGroup"
###########################################################
# Script Parameters
###########################################################

Param
(
    # The name of the server instance that hosts the availability group
    [Parameter(Mandatory=$true)]
    [string] $ServerName,

    # Name of the availability group to monitor
    [Parameter(Mandatory=$true)]
    [string] $GroupName
)

###########################################################
# Script Body 
###########################################################

# Connect to the server instance and set default init fields for 
# efficient loading of collections. We use windows authentication here,
# but this can be changed to use SQL Authentication if required.
$serverObject = New-Object Microsoft.SqlServer.Management.SMO.Server($ServerName)
$serverObject.SetDefaultInitFields([Microsoft.SqlServer.Management.Smo.AvailabilityGroup], $true)
$serverObject.SetDefaultInitFields([Microsoft.SqlServer.Management.Smo.AvailabilityReplica], $true)
$serverObject.SetDefaultInitFields([Microsoft.SqlServer.Management.Smo.DatabaseReplicaState], $true)

# Attempt to access the availability group object on the server
$groupObject = $serverObject.AvailabilityGroups[$GroupName]

if($groupObject -eq $null)
{
    # Can't find the availability group on the server.
    throw "The availability group '$GroupName' does not exist on server '$ServerName'."
}
elseif($groupObject.PrimaryReplicaServerName -eq $null)
{
    # Can't determine the primary server instance. This can be serious (may mean the AG is offline), so throw an error.
    throw "Cannot determine the primary replica of availability group '$GroupName' from server instance '$ServerName'. Please investigate!" 
}
elseif($groupObject.PrimaryReplicaServerName -ne $ServerName)
{
    # We're trying to run the script on a secondary replica, which we shouldn't do.
    # We'll just throw a warning in this case, however, and skip health evaluation.
    Write-Warning "The server instance '$ServerName' is not the primary replica for the availability group '$GroupName'. Skipping evaluation."
}
else 
{
    # Run the health cmdlets
    $groupResult = Test-SqlAvailabilityGroup $groupObject -NoRefresh
    $replicaResults = @($groupObject.AvailabilityReplicas | Test-SqlAvailabilityReplica -NoRefresh)
    $databaseResults = @($groupObject.DatabaseReplicaStates | Test-SqlDatabaseReplicaState -NoRefresh)
    
    # Determine if any objects are in the critical state
    $groupIsCritical = $groupResult.HealthState -eq "Error"
    $criticalReplicas = @($replicaResults | Where-Object { $_.HealthState -eq "Error" })
    $criticalDatabases = @($databaseResults | Where-Object { $_.HealthState -eq "Error" })

    # If any objects are critical throw an error
    if($groupIsCritical -or $criticalReplicas.Count -gt 0 -or $criticalDatabases.Count -gt 0)
    {
        throw "The availability group '$GroupName' has objects in the critical state! Please investigate."
    }
}




#----------------------------------------------------------------
# 29  2555   Monitor availability groups and availability replicas status information using T-SQL
#---------------------------------------------------------------- 


WITH [AvailabilityGroupReplicaCTE]
AS (
    SELECT dc.[database_name]
        ,dr.[synchronization_state_desc]
        ,dr.[suspend_reason_desc]
        ,dr.[synchronization_health_desc]
        ,dr.[replica_id]
        ,ar.[availability_mode_desc]
        ,ar.[primary_role_allow_connections_desc]
        ,ar.[secondary_role_allow_connections_desc]
        ,ar.[failover_mode_desc]
        ,ar.[endpoint_url]
        ,ar.[owner_sid]
        ,ar.[create_date]
        ,ar.[modify_date]
        ,dr.[recovery_lsn]
        ,dr.[truncation_lsn]
        ,dr.[last_sent_lsn]
        ,dr.[last_sent_time]
        ,dr.[last_received_lsn]
        ,dr.[last_received_time]
        ,dr.[last_hardened_lsn]
        ,dr.[last_hardened_time]
        ,dr.[last_redone_lsn]
        ,dr.[last_redone_time]
        ,dr.[redo_queue_size]
        ,dr.[log_send_queue_size]
    FROM [sys].[dm_hadr_database_replica_states] dr
    INNER JOIN [sys].[availability_databases_cluster] dc
        ON dr.[group_database_id] = dc.[group_database_id]
    INNER JOIN [sys].[availability_replicas] ar
        ON ar.[replica_id] = dr.[replica_id]
    WHERE dr.[is_local] = 1
    )
    ,[AvailabilityGroupReplicaDatabaseState] (
    [ReplicaID]
    ,[ReplicaDBName]
    ,[ReplicaServerName]
    ,[JoinState]
    ,[Role]
    ,[AvailabilityMode]
    ,[SynchronizationState]
    ,[SynchronizationHealth]
    ,[OperationalState]
    ,[ConnectedState]
    ,[SuspendReason]
    ,[RecoveryHealth]
    ,[RecoveryLSN]
    ,[TruncationLSN]
    ,[LastSentLSN]
    ,[LastSentTime]
    ,[LastReceivedLSN]
    ,[LastReceivedTime]
    ,[LastHardenedLSN]
    ,[LastHardenedTime]
    ,[LastRedoneLSN]
    ,[LastRedoneTime]
    ,[RedoQueueSize]
    ,[LogSendQueueSize]
    ,[PrimaryRoleAllowConnections]
    ,[SecondaryRoleAllowConnections]
    ,[FailoverMode]
    ,[EndPointURL]
    ,[Owner]
    ,[CreateDate]
    ,[ModifyDate]
    )
AS (
    SELECT c.[replica_id]
        ,c.[database_name]
        ,cs.[replica_server_name]
        ,cs.[join_state_desc]
        ,rs.[role_desc]
        ,c.[availability_mode_desc]
        ,c.[synchronization_state_desc]
        ,c.[synchronization_health_desc]
        ,rs.[operational_state_desc]
        ,rs.[connected_state_desc]
        ,c.[suspend_reason_desc]
        ,rs.[recovery_health_desc]
        ,c.[recovery_lsn]
        ,c.[truncation_lsn]
        ,c.[last_sent_lsn]
        ,c.[last_sent_time]
        ,c.[last_received_lsn]
        ,c.[last_received_time]
        ,c.[last_hardened_lsn]
        ,c.[last_hardened_time]
        ,c.[last_redone_lsn]
        ,c.[last_redone_time]
        ,c.[redo_queue_size]
        ,c.[log_send_queue_size]
        ,c.[primary_role_allow_connections_desc]
        ,c.[secondary_role_allow_connections_desc]
        ,c.[failover_mode_desc]
        ,c.[endpoint_url]
        ,sl.[name]
        ,c.[create_date]
        ,c.[modify_date]
    FROM [AvailabilityGroupReplicaCTE] c
    INNER JOIN [sys].[dm_hadr_availability_replica_states] rs
        ON rs.[replica_id] = c.[replica_id]
    INNER JOIN [sys].[dm_hadr_availability_replica_cluster_states] cs
        ON cs.[replica_id] = c.[replica_id]
    INNER JOIN [sys].[syslogins] sl
        ON c.[owner_sid] = sl.[sid]
    )
SELECT *
FROM [AvailabilityGroupReplicaDatabaseState];





