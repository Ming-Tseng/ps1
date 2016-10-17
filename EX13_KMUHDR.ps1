<#
#  
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX13_KMUHDR.ps1
\\HISDB1\ps1\alwayson.ps1


from  OS Cluster  C01_cluster
CreateDate: Oct.16.2013
LastDate : May.24.2014

I. install
II. Configure
III.Log
: APR.30.2014

Author :Ming Tseng  ,a0921887912@gmail.com
Ping SQL2012X ;telnet SQL2012X 5023

telnet SQL2012X 5022


http://support.microsoft.com/kb/2857849
restore database HISDB with recovery
#>

eventvwr
sqlservermanager12.msc
#-----------------------------------------------------------
#     enable   Invoke-Sqlcmd
#-----------------------------------------------------------
{<#
remember run as adminitstrator

if ((Get-Module -Name sqlps) -eq $null) {Import-Module “sqlps” -DisableNameChecking}
gsv -displayname  '*sql*'

$svrinstance=$env:COMPUTERNAME  #  HISDB2

#1   50  AVAILABILITY  failover 

Invoke-Sqlcmd -query "select getdate(); select  @@servername" -ServerInstance  $sqlcluster1
Invoke-Sqlcmd -query "select getdate(); select  @@servername" -ServerInstance  $sqlcluster2
#>}
#-----------------------------------------------------------
#     parameter 
#-----------------------------------------------------------
$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDBCLS2,1436'



#-----------------------------------------------------------
#     Get  AGname, NodeName, InstanceName
#-----------------------------------------------------------
{<#
select ag_name,node_name,instance_name from sys.dm_hadr_instance_node_map  inm
join  sys.dm_hadr_name_id_map  nip on inm.ag_resource_id=nip.ag_resource_id


select * from sys.dm_hadr_cluster 
select * from sys.dm_hadr_cluster_members 
select * from sys.dm_hadr_cluster_networks 
select * from sys.dm_hadr_instance_node_map 
select * from sys.dm_hadr_name_id_map 
#>}



#-----------------------------------------------------------
#      ar  cr  dr  
#----------------------------------------------------------- 
{<#
$tsql_ar=@"
select ar.replica_server_name,ars.role_desc,ars.connected_state_desc,ars.last_connect_error_description,ars.last_connect_error_timestamp
from sys.availability_replicas  ar
join  sys.dm_hadr_availability_replica_states  ars on ar.replica_id=ars.replica_id
"@

Get-Date;Invoke-Sqlcmd -query $tsql_ar -ServerInstance HISAG |ft -AutoSize




$tsql_dr=@"
select  cr.replica_server_name,DB_Name(dr.database_id),synchronization_state_desc,last_commit_time 
from sys.dm_hadr_availability_replica_cluster_states cr
join sys.dm_hadr_database_replica_states dr on cr.replica_id=dr.replica_id
"@
Get-Date;Invoke-Sqlcmd -query $tsql_dr -ServerInstance HISAG |ft -AutoSize


#Get-Date;Move-ClusterGroup –Name $SQLCLS1 -Node HISDB1 

#>}

#-----------------------------------------------------------
#        HISDB資料庫備份
#-----------------------------------------------------------
#{<#

$node2backupbak='\\Hisdbcls1\sqlsync\HISDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HISDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HISDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HISDB_node1.trn'
 
$sqlcluster1='HISDBCLS1'
#$sqlcluster2='HISDBCLS2,1436'
 $sqlcluster2='HISDB2\KMUHDB2,1436'

$sqlclusterfrom  =$sqlcluster2
$sqlclusterto   =$sqlcluster1
$sqlclusterPrimary=$sqlcluster1
$sqlclustersecondary=$sqlcluster2

$sql_bkNode1=@"
BACKUP DATABASE [HISDB] TO  DISK = N'$node1backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
BACKUP LOG [HISDB] TO  DISK = N'$node1backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node1backupbak) { Remove-Item  $node1backupbak}
if (Test-Path $node1backuptrn) { Remove-Item  $node1backuptrn}
Invoke-Sqlcmd -query $sql_bkNode1 -ServerInstance  $sqlcluster1

$sql_bkNode2=@"
BACKUP DATABASE [HISDB] TO  DISK = N'$node2backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
BACKUP LOG [HISDB] TO  DISK = N'$node2backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node2backupbak) { Remove-Item  $node2backupbak}
if (Test-Path $node2backupbak) { Remove-Item  $node2backupbak}
Invoke-Sqlcmd -query $sql_bkNode2 -ServerInstance  $sqlcluster1

#>}

#-----------------------------------------------------------
#        HISDB 資料庫備份檔檢查
#-----------------------------------------------------------
$node1backupbak='\\Hisdbcls1\sqlsync\HISDB_node1.bak'
$node2backupbak='\\Hisdbcls1\sqlsync\HISDB_node2.bak'

 
$sqlcluster1='HISDBCLS1'
#$sqlcluster2='HISDBCLS2,1436'
 $sqlcluster2='HISDB2\KMUHDB2,1436'

$sqlclusterfrom  =$sqlcluster2
$sqlclusterto   =$sqlcluster1
$sqlclusterPrimary=$sqlcluster1
$sqlclustersecondary=$sqlcluster2

$sql_Node1bkcheck=@"
RESTORE filelistonly  FROM  DISK = N'$node1backupbak' 
GO
"@
Invoke-Sqlcmd -query $sql_Node1bkcheck -ServerInstance  $sqlcluster1


$sql_Node2bkcheck=@"
RESTORE filelistonly  FROM  DISK = N'$node2backupbak' 
GO
"@
Invoke-Sqlcmd -query $sql_Node2bkcheck -ServerInstance  $sqlcluster2


#-----------------------------------------------------------
#      HISDB  災害復原之標準作業程序  scenario 1
#----------------------------------------------------------- 
#{<#
#sqlcluster1.HISDB restoring , 
#sqlcluster2.HISDB workable

###-------------step01: backup  sqlcluster2.HISDB 
{
$node2backupbak='\\Hisdbcls1\sqlsync\HISDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HISDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HISDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HISDB_node1.trn'

$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDBCLS2,1436'

$sqlclusterfrom  =$sqlcluster2
$sqlclusterto   =$sqlcluster1
$sqlclusterPrimary=$sqlcluster1
$sqlclustersecondary=$sqlcluster2

$sql_102=@"
BACKUP DATABASE [HISDB] TO  DISK = N'$node2backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node2backupbak) { Remove-Item  $node2backupbak}
Invoke-Sqlcmd -query $sql_102 -ServerInstance  $sqlclusterfrom
$sql_103=@"
RESTORE filelistonly  FROM  DISK = N'$node2backupbak' 
"@
Invoke-Sqlcmd -query $sql_103 -ServerInstance  $sqlclusterto
}
###-------------step02:  
{
$sql_121_toS1=@"
RESTORE DATABASE HISDB  FROM  DISK = N'$node2backupbak'  
WITH replace , NOUNLOAD,  STATS = 5
,Move  'HISDB'        To  N'E:\SQLDATA\HISDB.mdf' 
,move  'Common_FG_01' to  N'M:\SQLDATA\Common_FG_01.ndf'
,move  'CommonDB'     to  N'M:\SQLDATA\CommonDB.ndf' 
,move 'EISCODE_FG_01' to  N'E:\SQLDATA\EISCODE_FG_01.ndf' 
,move 'EIS_FG_01'     To  N'E:\SQLDATA\EIS_FG_01.ndf' 
,move 'EIS_FG_02'     To  N'E:\SQLDATA\EIS_FG_02.ndf'  
,move 'EISIDX_FG_01'  To  N'E:\SQLDATA\EISIDX_FG_01.ndf' 
,move 'EISIDX_FG_02'  To  N'E:\SQLDATA\EISIDX_FG_02.ndf'  
,move 'EISDB'         To  N'E:\SQLDATA\EISDB.ndf' 
,move 'EMR_FG_01'     To  N'L:\SQLDATA\EMR_FG_01.ndf' 
,move 'EMR_FG_02'     To  N'L:\SQLDATA\EMR_FG_02.ndf'  
,move 'EMRDB'         To  N'L:\SQLDATA\EMRDB.ndf' 
,move 'LIS_FG_01'     To  N'L:\SQLDATA\LIS_FG_01.ndf'  
,move 'LISDB'         To  N'L:\SQLDATA\LISDB.ndf' 
,move 'MIS_FG_01'     To  N'M:\SQLDATA\MIS_FG_01.ndf'  
,move 'MISDB'         To  N'M:\SQLDATA\MISDB.ndf' 
,move 'OPDCODE_FG_01' To  N'O:\SQLDATA\OPDCODE_FG_01.ndf'  
,move 'OPDIDX_FG_01'  To  N'O:\SQLDATA\OPDIDX_FG_01.ndf' 
,move 'OPDIDX_FG_02'  To  N'O:\SQLDATA\OPDIDX_FG_02.ndf'  
,move 'OPD_FG_01'     To  N'O:\SQLDATA\OPD_FG_01.ndf' 
,move 'OPD_FG_02'     To  N'O:\SQLDATA\OPD_FG_02.ndf'  
,move 'OPDDB'         To  N'O:\SQLDATA\OPDDB.ndf' 
,move 'PCSDB_CODE_FG' To  N'N:\SQLDATA\PCSDB_CODE_FG_01.ndf'  
,move 'PCSCODE_FG_01' To  N'N:\SQLDATA\PCSCODE_FG_01.ndf' 
,move 'PCSCODE_FG_02' To  N'N:\SQLDATA\PCSCODE_FG_02.ndf'  
,move 'PCS_FG_01'     To  N'N:\SQLDATA\PCS_FG_01.ndf' 
,move 'PCS_FG_02'     To  N'N:\SQLDATA\PCS_FG_02.ndf'  
,move 'PCSDB'         To  N'N:\SQLDATA\PCSDB.ndf' 
,move 'HISDB_log'     To  N'I:\SQLLOG\HISDB__log.ldf' 
,move 'HISDB_log2'    To  N'J:\SQLLOG\HISDB__log2.ldf' 
,move 'HISDB_log3'    To  N'K:\SQLLOG\HISDB__log3.ldf' 
GO
"@
$sql_121_toS1
Invoke-Sqlcmd -query $sql_121_toS1 -ServerInstance  $sqlclusterto -QueryTimeout 3600
#make sure sqlcluster1.HISDB  workable
}

###-------------step03:  
{
$sql_131=@"
USE [master]

GO

/****** Object:  AvailabilityReplica [HISDBCLS1]    Script Date: 2014/11/22 下午 05:31:23 ******/
ALTER AVAILABILITY GROUP [HISAG2]
REMOVE REPLICA ON N'HISDBCLS1';

GO
"@
Invoke-Sqlcmd -query $sql_131 -ServerInstance  HISAG -QueryTimeout 3600

$sql_132=@"
USE [master]

GO

ALTER AVAILABILITY GROUP [HISAG2]
REMOVE DATABASE [HISDB];

GO

"@
Invoke-Sqlcmd -query $sql_132 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600


$sql_133=@"
USE [master]
GO
ALTER AVAILABILITY GROUP [HISAG2]
ADD DATABASE [HISDB];
GO
"@
Invoke-Sqlcmd -query $sql_133 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600
#此時主要點HISDB  已上線,次要點未同步

}

###-------------step04
{
$sql_141=@"
BACKUP DATABASE [HISDB] TO  DISK = N'$node1backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node1backupbak ) { Remove-Item  $node1backupbak}
Invoke-Sqlcmd -query $sql_141 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

}
###-------------step05
{
$sql_151=@"
RESTORE DATABASE HISDB  FROM  DISK = N'$node1backupbak'  
WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,Move  'HISDB'        To  N'P:\SQLDATA\HISDB.mdf' 
,move  'Common_FG_01' to  N'x:\SQLDATA\Common_FG_01.ndf'
,move  'CommonDB'     to  N'x:\SQLDATA\CommonDB.ndf' 
,move 'EISCODE_FG_01' to  N'p:\SQLDATA\EISCODE_FG_01.ndf' 
,move 'EIS_FG_01'     To  N'p:\SQLDATA\EIS_FG_01.ndf' 
,move 'EIS_FG_02'     To  N'p:\SQLDATA\EIS_FG_02.ndf'  
,move 'EISIDX_FG_01'  To  N'p:\SQLDATA\EISIDX_FG_01.ndf' 
,move 'EISIDX_FG_02'  To  N'p:\SQLDATA\EISIDX_FG_02.ndf'  
,move 'EISDB'         To  N'p:\SQLDATA\EISDB.ndf' 
,move 'EMR_FG_01'     To  N'w:\SQLDATA\EMR_FG_01.ndf' 
,move 'EMR_FG_02'     To  N'w:\SQLDATA\EMR_FG_02.ndf'  
,move 'EMRDB'         To  N'w:\SQLDATA\EMRDB.ndf' 
,move 'LIS_FG_01'     To  N'w:\SQLDATA\LIS_FG_01.ndf'  
,move 'LISDB'         To  N'w:\SQLDATA\LISDB.ndf' 
,move 'MIS_FG_01'     To  N'x:\SQLDATA\MIS_FG_01.ndf'  
,move 'MISDB'         To  N'x:\SQLDATA\MISDB.ndf' 
,move 'OPDCODE_FG_01' To  N'z:\SQLDATA\OPDCODE_FG_01.ndf'  
,move 'OPDIDX_FG_01'  To  N'z:\SQLDATA\OPDIDX_FG_01.ndf' 
,move 'OPDIDX_FG_02'  To  N'z:\SQLDATA\OPDIDX_FG_02.ndf'  
,move 'OPD_FG_01'     To  N'z:\SQLDATA\OPD_FG_01.ndf' 
,move 'OPD_FG_02'     To  N'z:\SQLDATA\OPD_FG_02.ndf'  
,move 'OPDDB'         To  N'z:\SQLDATA\OPDDB.ndf' 
,move 'PCSDB_CODE_FG' To  N'Y:\SQLDATA\PCSDB_CODE_FG_01.ndf'  
,move 'PCSCODE_FG_01' To  N'Y:\SQLDATA\PCSCODE_FG_01.ndf' 
,move 'PCSCODE_FG_02' To  N'Y:\SQLDATA\PCSCODE_FG_02.ndf'  
,move 'PCS_FG_01'     To  N'Y:\SQLDATA\PCS_FG_01.ndf' 
,move 'PCS_FG_02'     To  N'Y:\SQLDATA\PCS_FG_02.ndf'  
,move 'PCSDB'         To  N'Y:\SQLDATA\PCSDB.ndf' 
,move 'HISDB_log'     To  N't:\SQLLOG\HISDB__log.ldf' 
,move 'HISDB_log2'    To  N'u:\SQLLOG\HISDB__log2.ldf' 
,move 'HISDB_log3'    To  N'v:\SQLLOG\HISDB__log3.ldf' 
GO
"@
Invoke-Sqlcmd -query $sql_151 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600
#此時主要點HISDB  已上線,次要點狀態為正在還原
}
###-------------step06
{
$sql_161=@"
BACKUP LOG [HISDB] TO  DISK = N'$node1backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
"@
if (Test-Path $node1backuptrn ) { Remove-Item  $node1backuptrn}
Invoke-Sqlcmd -query $sql_161 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

#檢視 \\Hisdbcls1\sqlsync  檔案及產生日期

}
###-------------step07
{
$sql_171=@"
RESTORE LOG [HISDB] FROM  DISK = N'$node1backuptrn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO
"@
Invoke-Sqlcmd -query $sql_171 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600
}
###-------------step08
{
$sql_181=@"
ALTER DATABASE HISDB SET HADR AVAILABILITY GROUP = [HISAG2];
"@
Invoke-Sqlcmd -query $sql_181 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

## 此時數位儀表板可得全為GREEN
}

#>}



#-----------------------------------------------------------
#        災害復原之標準作業程序   scenario 2  add replica   HISDBCLS1 into AG
#-----------------------------------------------------------
{<#
only $sqlcluster2='HISDBCLS2,1436'  exist 
無法建立、聯結或加入複本至可用性群組 'HISAG2'，因為節點 'HISDB1' 是複本 'HISDBCLS2\KMUHDBI2' 和 'HISDBCLS1' 的可能擁有者。


$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'


###-------------step21
$sql_211=@"
--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
--Connect HISAG
use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [KMUH\sqladm]
GO
"@
Invoke-Sqlcmd -query $sql_211 -ServerInstance  HISAG -QueryTimeout 3600

###-------------step22
$tsql_212=@"
--:Connect HISDBCLS1

IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO
use [master]

GO

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [KMUH\sqladm]

GO

--:Connect HISDBCLS1

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO
"@
Invoke-Sqlcmd -query $tsql_212 -ServerInstance  $sqlcluster1 -QueryTimeout 3600

###-------------step2-3
$tsql_213=@"
--:Connect HISAG
USE [master]
GO

ALTER AVAILABILITY GROUP [HISAG2]
ADD REPLICA ON N'HISDBCLS1' WITH (ENDPOINT_URL = N'TCP://HISDBCLS1.KMUH.GOV.TW:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));
GO
"@
Invoke-Sqlcmd -query $tsql_213 -ServerInstance  HISAG -QueryTimeout 3600
$tsql_214=@"
--Connect HISDBCLS1
ALTER AVAILABILITY GROUP [HISAG2] JOIN;
GO
"@
Invoke-Sqlcmd -query $tsql_214 -ServerInstance  $sqlcluster1 -QueryTimeout 3600
#>}

#-----------------------------------------------------------
#      HISDB  災害復原之標準作業程序   scenario 3     HISDB to $node1
#-----------------------------------------------------------
{<#
 #$sqlcluster2='HISDBCLS2,1436'  Primay  
 #$sqlcluster1='HISDBCLS1'.HISDB Restoring
 # HISDBCLS2,1436 copy to  HISDBCLS1

$node2backupbak='\\Hisdbcls1\sqlsync\HISDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HISDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HISDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HISDB_node1.trn'

$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'

$sqlclusterfrom     =$sqlcluster2
$sqlclusterto       =$sqlcluster1
$sqlclusterPrimary  =$sqlcluster2
$sqlclustersecondary=$sqlcluster1

###-------------step3-1
$sql_311=@"
BACKUP DATABASE [HISDB] TO  DISK = N'$node2backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node2backupbak ) { Remove-Item  $node2backupbak}
Invoke-Sqlcmd -query $sql_311 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600


###-------------step3-2
$tsql_321=@"
RESTORE DATABASE HISDB  FROM  DISK = N'$node2backupbak'  
WITH replace ,  NOUNLOAD,  STATS = 5
,Move  'HISDB'        To  N'E:\SQLDATA\HISDB.mdf' 
,move  'Common_FG_01' to  N'M:\SQLDATA\Common_FG_01.ndf'
,move  'CommonDB'     to  N'M:\SQLDATA\CommonDB.ndf' 
,move 'EISCODE_FG_01' to  N'E:\SQLDATA\EISCODE_FG_01.ndf' 
,move 'EIS_FG_01'     To  N'E:\SQLDATA\EIS_FG_01.ndf' 
,move 'EIS_FG_02'     To  N'E:\SQLDATA\EIS_FG_02.ndf'  
,move 'EISIDX_FG_01'  To  N'E:\SQLDATA\EISIDX_FG_01.ndf' 
,move 'EISIDX_FG_02'  To  N'E:\SQLDATA\EISIDX_FG_02.ndf'  
,move 'EISDB'         To  N'E:\SQLDATA\EISDB.ndf' 
,move 'EMR_FG_01'     To  N'L:\SQLDATA\EMR_FG_01.ndf' 
,move 'EMR_FG_02'     To  N'L:\SQLDATA\EMR_FG_02.ndf'  
,move 'EMRDB'         To  N'L:\SQLDATA\EMRDB.ndf' 
,move 'LIS_FG_01'     To  N'L:\SQLDATA\LIS_FG_01.ndf'  
,move 'LISDB'         To  N'L:\SQLDATA\LISDB.ndf' 
,move 'MIS_FG_01'     To  N'M:\SQLDATA\MIS_FG_01.ndf'  
,move 'MISDB'         To  N'M:\SQLDATA\MISDB.ndf' 
,move 'OPDCODE_FG_01' To  N'O:\SQLDATA\OPDCODE_FG_01.ndf'  
,move 'OPDIDX_FG_01'  To  N'O:\SQLDATA\OPDIDX_FG_01.ndf' 
,move 'OPDIDX_FG_02'  To  N'O:\SQLDATA\OPDIDX_FG_02.ndf'  
,move 'OPD_FG_01'     To  N'O:\SQLDATA\OPD_FG_01.ndf' 
,move 'OPD_FG_02'     To  N'O:\SQLDATA\OPD_FG_02.ndf'  
,move 'OPDDB'         To  N'O:\SQLDATA\OPDDB.ndf' 
,move 'PCSDB_CODE_FG' To  N'N:\SQLDATA\PCSDB_CODE_FG_01.ndf'  
,move 'PCSCODE_FG_01' To  N'N:\SQLDATA\PCSCODE_FG_01.ndf' 
,move 'PCSCODE_FG_02' To  N'N:\SQLDATA\PCSCODE_FG_02.ndf'  
,move 'PCS_FG_01'     To  N'N:\SQLDATA\PCS_FG_01.ndf' 
,move 'PCS_FG_02'     To  N'N:\SQLDATA\PCS_FG_02.ndf'  
,move 'PCSDB'         To  N'N:\SQLDATA\PCSDB.ndf' 
,move 'HISDB_log'     To  N'I:\SQLLOG\HISDB__log.ldf' 
,move 'HISDB_log2'    To  N'J:\SQLLOG\HISDB__log2.ldf' 
,move 'HISDB_log3'    To  N'K:\SQLLOG\HISDB__log3.ldf' 
GO
"@
Invoke-Sqlcmd -query $tsql_321 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

$tsql_322=@"
RESTORE DATABASE HISDB  FROM  DISK = N'$node2backupbak'  
WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,Move  'HISDB'        To  N'E:\SQLDATA\HISDB.mdf' 
,move  'Common_FG_01' to  N'M:\SQLDATA\Common_FG_01.ndf'
,move  'CommonDB'     to  N'M:\SQLDATA\CommonDB.ndf' 
,move 'EISCODE_FG_01' to  N'E:\SQLDATA\EISCODE_FG_01.ndf' 
,move 'EIS_FG_01'     To  N'E:\SQLDATA\EIS_FG_01.ndf' 
,move 'EIS_FG_02'     To  N'E:\SQLDATA\EIS_FG_02.ndf'  
,move 'EISIDX_FG_01'  To  N'E:\SQLDATA\EISIDX_FG_01.ndf' 
,move 'EISIDX_FG_02'  To  N'E:\SQLDATA\EISIDX_FG_02.ndf'  
,move 'EISDB'         To  N'E:\SQLDATA\EISDB.ndf' 
,move 'EMR_FG_01'     To  N'L:\SQLDATA\EMR_FG_01.ndf' 
,move 'EMR_FG_02'     To  N'L:\SQLDATA\EMR_FG_02.ndf'  
,move 'EMRDB'         To  N'L:\SQLDATA\EMRDB.ndf' 
,move 'LIS_FG_01'     To  N'L:\SQLDATA\LIS_FG_01.ndf'  
,move 'LISDB'         To  N'L:\SQLDATA\LISDB.ndf' 
,move 'MIS_FG_01'     To  N'M:\SQLDATA\MIS_FG_01.ndf'  
,move 'MISDB'         To  N'M:\SQLDATA\MISDB.ndf' 
,move 'OPDCODE_FG_01' To  N'O:\SQLDATA\OPDCODE_FG_01.ndf'  
,move 'OPDIDX_FG_01'  To  N'O:\SQLDATA\OPDIDX_FG_01.ndf' 
,move 'OPDIDX_FG_02'  To  N'O:\SQLDATA\OPDIDX_FG_02.ndf'  
,move 'OPD_FG_01'     To  N'O:\SQLDATA\OPD_FG_01.ndf' 
,move 'OPD_FG_02'     To  N'O:\SQLDATA\OPD_FG_02.ndf'  
,move 'OPDDB'         To  N'O:\SQLDATA\OPDDB.ndf' 
,move 'PCSDB_CODE_FG' To  N'N:\SQLDATA\PCSDB_CODE_FG_01.ndf'  
,move 'PCSCODE_FG_01' To  N'N:\SQLDATA\PCSCODE_FG_01.ndf' 
,move 'PCSCODE_FG_02' To  N'N:\SQLDATA\PCSCODE_FG_02.ndf'  
,move 'PCS_FG_01'     To  N'N:\SQLDATA\PCS_FG_01.ndf' 
,move 'PCS_FG_02'     To  N'N:\SQLDATA\PCS_FG_02.ndf'  
,move 'PCSDB'         To  N'N:\SQLDATA\PCSDB.ndf' 
,move 'HISDB_log'     To  N'I:\SQLLOG\HISDB__log.ldf' 
,move 'HISDB_log2'    To  N'J:\SQLLOG\HISDB__log2.ldf' 
,move 'HISDB_log3'    To  N'K:\SQLLOG\HISDB__log3.ldf' 
GO
"@
Invoke-Sqlcmd -query $tsql_322 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

###-------------step3-3
$tsql_331=@"
BACKUP LOG [HISDB] TO  DISK = N'$node2backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
"@
if (Test-Path $node2backuptrn ) { Remove-Item  $node2backuptrn}
Invoke-Sqlcmd -query $tsql_331 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600


###-------------step3-4


$tsql_341=@"
RESTORE LOG [HISDB] FROM  DISK = N'$node2backuptrn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO
"@

Invoke-Sqlcmd -query $tsql_341 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600


###-------------step3-5
$tsql_351=@"
ALTER DATABASE HISDB SET HADR AVAILABILITY GROUP = [HISAG2];
"@
Invoke-Sqlcmd -query $tsql_351 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

#>}
#-----------------------------------------------------------
#      HIS_BKDB  災害復原之標準作業程序   scenario 4  HIS_BKDB to $node1
#-----------------------------------------------------------
{<#
 #$sqlcluster2='HISDBCLS2,1436'  Primay  
 #$sqlcluster1='HISDBCLS1'.HIS_BKDB  restoring 
 # HISDBCLS2,1436.HIS_BKDB  copy to  HISDBCLS1

$node2backupbak='\\Hisdbcls1\sqlsync\HIS_BKDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HIS_BKDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HIS_BKDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HIS_BKDB_node1.trn'

$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'

$sqlclusterfrom     =$sqlcluster2
$sqlclusterto       =$sqlcluster1
$sqlclusterPrimary  =$sqlcluster2
$sqlclustersecondary=$sqlcluster1

###-------------step4-1
$sql_411=@"
BACKUP DATABASE [HIS_BKDB] TO  DISK = N'$node2backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node2backupbak ) { Remove-Item  $node2backupbak}
Invoke-Sqlcmd -query $sql_411 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

###-------------step4-2
$tsql_421=@"
RESTORE DATABASE HIS_BKDB  FROM  DISK = N'$node2backupbak'  
WITH replace ,   NOUNLOAD,  STATS = 5
, MOVE 'HIS_BKDB'  TO N'L:\SQLDATA\HIS_BKDB.mdf'
, MOVE 'HIS_BKDB_log' TO N'L:\SQLLOG\HIS_BKDB_log.ldf'

"@
Invoke-Sqlcmd -query $tsql_421 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600


###-------------step4-3
$tsql_431=@"
RESTORE DATABASE HIS_BKDB  FROM  DISK = N'$node2backupbak'  
WITH replace , NORECOVERY ,   NOUNLOAD,  STATS = 5
, MOVE 'HIS_BKDB'  TO N'L:\SQLDATA\HIS_BKDB.mdf'
, MOVE 'HIS_BKDB_log' TO N'L:\SQLLOG\HIS_BKDB_log.ldf'

"@
Invoke-Sqlcmd -query $tsql_431 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

###-------------step 4-4
$tsql_441=@"
BACKUP LOG [HIS_BKDB] TO  DISK = N'$node2backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
"@
if (Test-Path $node2backuptrn ) { Remove-Item  $node2backuptrn}
Invoke-Sqlcmd -query $tsql_441 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

###-------------step 4-5
$tsql_451=@"
RESTORE LOG [HIS_BKDB] FROM  DISK = N'$node2backuptrn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO
"@
Invoke-Sqlcmd -query $tsql_451 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600
###-------------step 4-6
$tsql_461=@"
ALTER DATABASE HIS_BKDB SET HADR AVAILABILITY GROUP = [HISAG2];
"@
Invoke-Sqlcmd -query $tsql_461 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

#>}

#-----------------------------------------------------------
#      HISDB  災害復原之標準作業程序   scenario 5  HISDB  Node1 to Node2
#-----------------------------------------------------------
#{<#
 #$sqlcluster1='HISDBCLS1H'  Primay  
 #$Node2='ISDBCLS2,1436'.HISDB workable
 # HISDBCLS1 copy to  HISDB2\KMUHDB2,1436

$node2backupbak='\\Hisdbcls1\sqlsync\HISDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HISDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HISDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HISDB_node1.trn'

$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'

$sqlclusterfrom     =$sqlcluster1
$sqlclusterto       =$sqlcluster2
$sqlclusterPrimary  =$sqlcluster1
$sqlclustersecondary=$sqlcluster2

###-------------step5-1
$sql_511=@"
BACKUP DATABASE [HISDB] TO  DISK = N'$node1backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node1backupbak ) { Remove-Item  $node1backupbak}
Invoke-Sqlcmd -query $sql_511 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600


###-------------step5-2
$tsql_521=@"
RESTORE DATABASE HISDB  FROM  DISK = N'$node1backupbak'  
WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,Move  'HISDB'        To  N'P:\SQLDATA\HISDB.mdf' 
,move  'Common_FG_01' to  N'x:\SQLDATA\Common_FG_01.ndf'
,move  'CommonDB'     to  N'x:\SQLDATA\CommonDB.ndf' 
,move 'EISCODE_FG_01' to  N'p:\SQLDATA\EISCODE_FG_01.ndf' 
,move 'EIS_FG_01'     To  N'p:\SQLDATA\EIS_FG_01.ndf' 
,move 'EIS_FG_02'     To  N'p:\SQLDATA\EIS_FG_02.ndf'  
,move 'EISIDX_FG_01'  To  N'p:\SQLDATA\EISIDX_FG_01.ndf' 
,move 'EISIDX_FG_02'  To  N'p:\SQLDATA\EISIDX_FG_02.ndf'  
,move 'EISDB'         To  N'p:\SQLDATA\EISDB.ndf' 
,move 'EMR_FG_01'     To  N'w:\SQLDATA\EMR_FG_01.ndf' 
,move 'EMR_FG_02'     To  N'w:\SQLDATA\EMR_FG_02.ndf'  
,move 'EMRDB'         To  N'w:\SQLDATA\EMRDB.ndf' 
,move 'LIS_FG_01'     To  N'w:\SQLDATA\LIS_FG_01.ndf'  
,move 'LISDB'         To  N'w:\SQLDATA\LISDB.ndf' 
,move 'MIS_FG_01'     To  N'x:\SQLDATA\MIS_FG_01.ndf'  
,move 'MISDB'         To  N'x:\SQLDATA\MISDB.ndf' 
,move 'OPDCODE_FG_01' To  N'z:\SQLDATA\OPDCODE_FG_01.ndf'  
,move 'OPDIDX_FG_01'  To  N'z:\SQLDATA\OPDIDX_FG_01.ndf' 
,move 'OPDIDX_FG_02'  To  N'z:\SQLDATA\OPDIDX_FG_02.ndf'  
,move 'OPD_FG_01'     To  N'z:\SQLDATA\OPD_FG_01.ndf' 
,move 'OPD_FG_02'     To  N'z:\SQLDATA\OPD_FG_02.ndf'  
,move 'OPDDB'         To  N'z:\SQLDATA\OPDDB.ndf' 
,move 'PCSDB_CODE_FG' To  N'Y:\SQLDATA\PCSDB_CODE_FG_01.ndf'  
,move 'PCSCODE_FG_01' To  N'Y:\SQLDATA\PCSCODE_FG_01.ndf' 
,move 'PCSCODE_FG_02' To  N'Y:\SQLDATA\PCSCODE_FG_02.ndf'  
,move 'PCS_FG_01'     To  N'Y:\SQLDATA\PCS_FG_01.ndf' 
,move 'PCS_FG_02'     To  N'Y:\SQLDATA\PCS_FG_02.ndf'  
,move 'PCSDB'         To  N'Y:\SQLDATA\PCSDB.ndf' 
,move 'HISDB_log'     To  N't:\SQLLOG\HISDB__log.ldf' 
,move 'HISDB_log2'    To  N'u:\SQLLOG\HISDB__log2.ldf' 
,move 'HISDB_log3'    To  N'v:\SQLLOG\HISDB__log3.ldf' 
GO
"@
Invoke-Sqlcmd -query $tsql_521 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

###-------------step5-3
$tsql_531=@"
BACKUP LOG [HISDB] TO  DISK = N'$node1backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
"@
if (Test-Path $node1backuptrn ) { Remove-Item  $node1backuptrn}
Invoke-Sqlcmd -query $tsql_531 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600


###-------------step5-4


$tsql_541=@"
RESTORE LOG [HISDB] FROM  DISK = N'$node1backuptrn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO
"@

Invoke-Sqlcmd -query $tsql_541 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600


###-------------step5-5
$tsql_551=@"
ALTER DATABASE HISDB SET HADR AVAILABILITY GROUP = [HISAG2];
"@
Invoke-Sqlcmd -query $tsql_351 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

#>}


#-----------------------------------------------------------
#      HIS_BKDB  災害復原之標準作業程序   scenario 6  HIS_BKDB to node2
#-----------------------------------------------------------
#{<#
 #$sqlcluster2='HISDBCLS2,1436'  Primay  
 #$sqlcluster1='HISDBCLS1'.HIS_BKDB  restoring 
 # HISDBCLS2,1436.HIS_BKDB  copy to  HISDBCLS1

$node2backupbak='\\Hisdbcls1\sqlsync\HIS_BKDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HIS_BKDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HIS_BKDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HIS_BKDB_node1.trn'

$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'

$sqlclusterfrom     =$sqlcluster1
$sqlclusterto       =$sqlcluster2
$sqlclusterPrimary  =$sqlcluster1
$sqlclustersecondary=$sqlcluster2

###-------------step6-1
$sql_611=@"
BACKUP DATABASE [HIS_BKDB] TO  DISK = N'$node1backupbak' 
WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO
"@
if (Test-Path $node1backupbak ) { Remove-Item  $node1backupbak}
Invoke-Sqlcmd -query $sql_611 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

###-------------step6-2
$tsql_621=@"
RESTORE DATABASE HIS_BKDB  FROM  DISK = N'$node1backupbak'  
WITH replace ,   NOUNLOAD,  STATS = 5
, MOVE 'HIS_BKDB'  TO N'W:\SQLDATA\HIS_BKDB.mdf'
, MOVE 'HIS_BKDB_log' TO N'W:\SQLLOG\HIS_BKDB_log.ldf'
"@
Invoke-Sqlcmd -query $tsql_621 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600


###-------------step6-3
$tsql_631=@"
RESTORE DATABASE HIS_BKDB  FROM  DISK = N'$node1backupbak'  
WITH replace , NORECOVERY ,   NOUNLOAD,  STATS = 5
, MOVE 'HIS_BKDB'  TO N'W:\SQLDATA\HIS_BKDB.mdf'
, MOVE 'HIS_BKDB_log' TO N'W:\SQLLOG\HIS_BKDB_log.ldf'

"@
Invoke-Sqlcmd -query $tsql_631 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

###-------------step 6-4
$tsql_641=@"
BACKUP LOG [HIS_BKDB] TO  DISK = N'$node1backuptrn' 
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
"@
if (Test-Path $node1backuptrn ) { Remove-Item  $node1backuptrn}
Invoke-Sqlcmd -query $tsql_641 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

###-------------step 6-5
$tsql_651=@"
RESTORE LOG [HIS_BKDB] FROM  DISK = N'$node1backuptrn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO
"@
Invoke-Sqlcmd -query $tsql_651 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600
###-------------step 6-6
$tsql_661=@"
ALTER DATABASE HIS_BKDB SET HADR AVAILABILITY GROUP = [HISAG2];
"@
Invoke-Sqlcmd -query $tsql_661 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

#>}
#-----------------------------------------------------------
#      create AG 
#-----------------------------------------------------------
{<#
$node2backupbak='\\Hisdbcls1\sqlsync\HISDB_node2.bak'
$node2backuptrn='\\Hisdbcls1\sqlsync\HISDB_node2.trn'
$node1backupbak='\\Hisdbcls1\sqlsync\HISDB_node1.bak'
$node1backuptrn='\\Hisdbcls1\sqlsync\HISDB_node1.trn'

$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'

$sqlclusterfrom     =$sqlcluster1
$sqlclusterto       =$sqlcluster2
$sqlclusterPrimary  =$sqlcluster1
$sqlclustersecondary=$sqlcluster2

$tsql_n01=@"
IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO
use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [KMUH\sqladm]
GO
"@

Invoke-Sqlcmd -query $tsql_n01 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

$tsql_n02=@"
--:Connect HISDB2\HISDB2,1436
IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO
use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [KMUH\sqladm]
GO
"@
Invoke-Sqlcmd -query $tsql_n02 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

$tsql_n03=@"
--Connect HISDBCLS1
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO
"@
Invoke-Sqlcmd -query $tsql_n03 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

$tsql_n04=@"
--Connect HISDB2\HISDB2,1436
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO
"@
Invoke-Sqlcmd -query $tsql_n04 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

#remember remove possible owner on SQLServer 
$tsql_n05=@"
--Connect HISDBCLS1
USE [master]
GO
CREATE AVAILABILITY GROUP [HISAG2]
WITH (AUTOMATED_BACKUP_PREFERENCE = SECONDARY)
FOR DATABASE [HIS_BKDB], [HISDB]
REPLICA ON N'HISDB2\KMUHDB2' WITH (ENDPOINT_URL = N'TCP://HISDB2.KMUH.GOV.TW:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
	N'HISDBCLS1' WITH (ENDPOINT_URL = N'TCP://HISDBCLS1.KMUH.GOV.TW:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));

GO
"@
Invoke-Sqlcmd -query $tsql_n05 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600

$tsql_n06=@"
--Connect HISDB2\HISDB2,1436
ALTER AVAILABILITY GROUP [HISAG2] JOIN;
GO
"@
Invoke-Sqlcmd -query $tsql_n06 -ServerInstance  $sqlclustersecondary -QueryTimeout 3600

$tsql_n07=@"
USE [master]
GO
ALTER AVAILABILITY GROUP [HISAG2]
ADD LISTENER N'HISAG' (
WITH IP
((N'192.168.20.18', N'255.255.255.0')
)
, PORT=1433);
GO
"@
Invoke-Sqlcmd -query $tsql_n07 -ServerInstance  $sqlclusterPrimary -QueryTimeout 3600



#>}






#-----------------------------------------------------------
#    who is primary
#-----------------------------------------------------------


function whoisPrimary ()
{
    $tsql_whoisPrimary="select primary_replica from sys.dm_hadr_availability_group_states" 
Invoke-Sqlcmd $tsql_whoisPrimary  -ServerInstance HISAG
}


#-----------------------------------------------------------
#    failover to another
#-----------------------------------------------------------
{<#
get-date;whoisprimary
$tsql_whoisPrimary="select primary_replica from sys.dm_hadr_availability_group_states" 
$iamprimary=Invoke-Sqlcmd $tsql_whoisPrimary  -ServerInstance HISAG

$failovercommand='ALTER AVAILABILITY GROUP [HISAG2] FAILOVER'
switch ($iamprimary.primary_replica)
{
    'HISDBCLS1' {
    Invoke-Sqlcmd -query  $failovercommand -ServerInstance  'HISDBCLS2,1436'
    }
    'HISDB2\KMUHDB2' {
    Invoke-Sqlcmd -query  $failovercommand -ServerInstance  'HISDBCLS1'
    }
    'HISDBCLS2\KMUHDBI2' {
    Invoke-Sqlcmd -query  $failovercommand -ServerInstance  'HISDBCLS1'
    }
    Default {}
}
get-date;whoisprimary
#>}
#-----------------------------------------------------------
#   REMOVE DATABASE
#-----------------------------------------------------------
{<#
USE [master]
GO

ALTER AVAILABILITY GROUP [HISAG2]  REMOVE DATABASE [HIS_BKDB];
GO

ALTER AVAILABILITY GROUP [HISAG2]  REMOVE DATABASE [HISDB];
GO
#>}
#-----------------------------------------------------------
#  REMOVE REPLICA 
#-----------------------------------------------------------
{<#

$tsql_remove_Replica=@"
USE [master]
GO
--ALTER AVAILABILITY GROUP [HISAG2] REMOVE REPLICA ON N'HISDBCLS2\KMUHDBI2';
ALTER AVAILABILITY GROUP [HISAG2] REMOVE REPLICA ON N'HISDB2\KMUHDB2';
GO
"@
Invoke-Sqlcmd -query $tsql_remove_Replica -ServerInstance  HISAG -QueryTimeout 3600

$tsql_remove_Replica=@"
USE [master]
GO
ALTER AVAILABILITY GROUP [HISAG2] REMOVE REPLICA ON N'HISDBCLS1';
GO
"@

Invoke-Sqlcmd -query $tsql_remove_Replica -ServerInstance  HISAG -QueryTimeout 3600

#>}
#-----------------------------------------------------------
#  災害復原之標準作業程序   scenario 7  add replica   HISDBCLS2,1436  into AG
#-----------------------------------------------------------
#{<#

only $sqlcluster2='HISDBCLS2,1436'  exist 
無法建立、聯結或加入複本至可用性群組 'HISAG2'，因為節點 'HISDB1' 是複本 'HISDBCLS2\KMUHDBI2' 和 'HISDBCLS1' 的可能擁有者。


$sqlcluster1='HISDBCLS1'
$sqlcluster2='HISDB2\KMUHDB2,1436'
#$sqlcluster2='HISDBCLS2,1436'


###-------------step71
$sql_711=@"
--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
--Connect HISAG
use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [KMUH\sqladm]
GO
"@
Invoke-Sqlcmd -query $sql_711 -ServerInstance  HISAG -QueryTimeout 3600

###-------------step72
$tsql_712=@"
--:Connect HISDB2\KMUHDB2

IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO
use [master]

GO

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [KMUH\sqladm]

GO


IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO
"@
Invoke-Sqlcmd -query $tsql_712 -ServerInstance  $sqlcluster2 -QueryTimeout 3600

###-------------step7-3
$tsql_713=@"
--:Connect HISAG
USE [master]
GO

ALTER AVAILABILITY GROUP [HISAG2]
ADD REPLICA ON N'HISDB2\KMUHDB2' WITH (ENDPOINT_URL = N'TCP://HISDB2.KMUH.GOV.TW:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));
GO
"@
Invoke-Sqlcmd -query $tsql_713 -ServerInstance  HISAG -QueryTimeout 3600
###-------------step7-4
$tsql_714=@"
--Connect HISDB2\KMUHDB2
ALTER AVAILABILITY GROUP [HISAG2] JOIN;
GO
"@
Invoke-Sqlcmd -query $tsql_714 -ServerInstance  $sqlcluster2 -QueryTimeout 3600

#>}

#>}
#-----------------------------------------
#    資料庫備份進度檢查 EstimatedEndTime
#-----------------------------------------

$sql_mdfrestore="
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT r.percent_complete
, DATEDIFF(MINUTE, start_time, GETDATE()) AS Age
, DATEADD(MINUTE, DATEDIFF(MINUTE, start_time, GETDATE()) /
percent_complete * 100, start_time) AS EstimatedEndTime
, t.Text AS ParentQuery
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS IndividualQuery
, start_time
, DB_NAME(Database_Id) AS DatabaseName
, Status
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
WHERE session_id > 50
AND percent_complete > 0
ORDER BY percent_complete DESC
"

$sqlcluster1='HISDBCLS1'
#$sqlcluster2='HISDBCLS2,1436'
$sqlcluster2='HISDB2\KMUHDB2,1436'
do
{ 
  clear-host
    Sleep 1
    Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $ sqlcluster1 -QueryTimeout 14400
    Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $ sqlcluster2 -QueryTimeout 14400
    Sleep 10
}
until ($x -gt 0)

