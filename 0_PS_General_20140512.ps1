<#
 Create data :APR.23.2014
 Filelocation :    \\10.0.21.113\c$\software\ps1\cluster\0_PS_General.ps1

 \\10.0.21.113\c$\software\ps1\cluster\01temp.ps1
  Author : Ming Tseng    syscom.com.tw
#>
ssms
#01  pre-installation
#02  Naming Rule  parameter
#03  get backup history
#04  create table Hosts
#05  update  table  hosts
#06  udpate table SQLServers  step1
#07  funtion  update SQL  cluster owner Nodes
#08   Table HostsDisks
#09    function updateHostDisks   need from  get-clusterdisk ,  may.07.2014
#10  TSQL
#11              udpateSQLdatabases   updatesql not finish
#12    600   GetSQLDBFileSize
#13    600   add  SQL_Inventory to ASSETAG
# 14   700    add  WinMasterVI  to ASSETAG
#15    750   failover to another 
#16    800  sys.availability
#17    850   function EstimateTime ( $SQLCluster)
#1414   part II
#  2592     SQL_E_2012_backup   1  -User Profile xxx
#  2630     SQL_E_2012backup  2    +User Profile xxx
#  2666  20140514   AG test
#  2777   cluster quorun
#  2822  20140514   AG   for    EIP   test
#   5000 TSQL









#42----------------------------------------------------------------------------------------------
# 1 pre-installation
#----------------------------------------------------------------------------------------------
Get-PSDrive
GET-WindowsFeature  RSAT-AD-PowerShell
Import-Module  "sqlps" -DisableNameChecking;Get-PSDrive
Set-ExecutionPolicy remotesigned
Add-WindowsFeature  RSAT-AD-PowerShell

$hostlist="00DPHCSSL01","00DPHCSSL02"`
,"00DPHCSSL03","00DPHCSSL04"`
,"00DPHCSSL05","00DPHCSSL06"`
,"00DPHCSSL07","00DPHCSSL08"`
,"01DPHCSSL01","01DPHCSSL02","01DPHCSSL03","01DPHCSSL04"

$hostlist[5]

icm -ComputerName 01DPHCSSL04 {hostname; get-date}

ping 01DPHCSSL01  10.1.21.113
ping 01DPHCSSL02  10.1.21.114
ping 01DPHCSSL03  10.1.21.103 
ping 01DPHCSSL04  10.1.21.104

gwmi  Win32_ComputerSystem -ComputerName $hostlist[10]
gwmi  Win32_ComputerSystem -ComputerName $hostlist[0]

icm  01DPHCSSL01 {get-date;hostname}

#----------------------------------------------------------------------------------------------
# 2 Naming Rule  parameter
#----------------------------------------------------------------------------------------------
$ivSQL= "SQL-B-2012"
$ivDatabase="SQL_inventory"
$AGName="ASSETAG"
$AGDatabase =""

$Node1="00DPHCSSL03"
$Node2=""

$SQLInstance1="DEFAULT"
$SQLInstance2="DEFAULT"

$SQLCluster1="SQL-B-2012"
$SQLCluster2

$SQLPathInstance1="SQLSERVER:\SQL\"+$SQLNetwork1+"\"+$SQLInstance1

$ObjectInstance1=
$SQLPathAG1="SQLSERVER:\SQL\"+$SQLNetwork1+"\"+$SQLInstance1+"\AvailabilityGroups\"+$AGName
$SQLPathAG2="SQLSERVER:\SQL\"+$SQLNetwork1+"\"+$SQLInstance1+"\AvailabilityGroups\"+$AGName

$SQLPathAGReplica1=$SQLPathAG1+"\AvailabilityReplicas"+$Node1 or 
$SQLPathAGReplica1

#SQLSERVER:\SQL\SQL-B-2012\DEFAULT\AvailabilityGroups\ASSETAG 
#SQLSERVER:\SQL\SQL-B-2012\DEFAULT\AvailabilityGroups\ASSETAG\AvailabilityReplicas\SQL-B-2012

#----------------------------------------------------------------------------------------------
# 3 get backup history
#----------------------------------------------------------------------------------------------
$SQLCluster1="SQL-B-2012"
$Server= New-Object -TypeName Microsoft.Sqlserver.management.Smo.server -ArgumentList  $SQLCluster1
$Server.Databases | select name,recoverymodel, lastbackupdate,lastdifferentialbackupdate, lastlogbackupdate |ft -AutoSize

$Server |select *

#----------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------
CREATE DATABASE [SQL_Inventory] ON(NAME = N'SQLInventory',FILENAME = N'Y:\SQLDB\SQL_Inventory.mdf',SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024MB )LOG ON(NAME = N'SQLInventory_log',FILENAME = N'Y:\SQLDB\SQL_Inventory_log.LDF',SIZE = 512MB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
#----------------------------------------------------------------------------------------------
#  4 create table Hosts
#----------------------------------------------------------------------------------------------
USE [SQL_Inventory]CREATE TABLE [dbo].[Hosts](
[MID] [varchar](128)  ,
[hostName] [varchar](128) ,
--[timeZone] [varchar](128) NULL,
--[enableDaylightSavingsTime] [bit] NULL,
[domain] [varchar](128) NULL,
[manufacturer] [varchar](128) NULL,
[model] [varchar](128) NULL,
--[systemType] [varchar](128) NULL,
--[systemStartupOptions] [varchar](128) NULL,
[numberOfProcessors] [tinyint] NULL,
[numberOfLogicalProcessors] [tinyint] NULL,
[totalPhysicalMemory] [int] NULL,
--[countryCode] [varchar](128) NULL,
[lastBootUpTime] [smalldatetime] NULL,
--[locale] [varchar](128) NULL,
[OS] [varchar](128) NULL,
[version] [varchar](128) NULL,
[servicePackMajorVersion] [varchar](10) NULL,
[servicePackMinorVersion] [varchar](10) NULL,
[buildNumber] [varchar](20) NULL,
[installDate] [datetime] NULL,
--[totalVisibleMemorySize] [bigint] NULL,
--[totalVirtualMemorySize] [bigint] NULL,
--[pagingFileSize] [bigint] NULL,
[IP1] [varchar](128) NULL,
[IP2] [varchar](128) NULL,
[IP3] [varchar](128) NULL,
[IP4] [varchar](128) NULL,
[IP5] [varchar](128) NULL,
[IP6] [varchar](128) NULL,
--[createDate] [smalldatetime]  NULL,
--[region] [char](2)  NULL,
--[location] [char](2)  NULL,
--[description] [varchar](500) NULL,
--[primaryBU] [varchar](128)  NULL,
[updateDate] [smalldatetime]  NULL)
 ON [PRIMARY]
GO






#----------------------------------------------------------------------------------------------
# 5  update  table  hosts
#----------------------------------------------------------------------------------------------
#truncate table Hosts
#select * from Hosts

$ivSQL= "SQL-B-2012"
$ivDatabase="SQL_inventory"
$hostlist="00DPHCSSL01","00DPHCSSL02"`
,"00DPHCSSL03","00DPHCSSL04"`
,"00DPHCSSL05","00DPHCSSL06"`
,"00DPHCSSL07","00DPHCSSL08"`
,"01DPHCSSL03","01DPHCSSL04"

$hostlist[5]

For ($i = 0; $i -lt $hostlist.Count; $i++)
{  #p141
 $Node=$hostlist[$i]  
    
 $sql_select ="select hostname  from hosts where hostname='" +$Node+"'"    #$sql_select ="select hostname  from hosts where hostname='01DPHCSSL03'"
 $select_result= Invoke-Sqlcmd -Query $sql_select -ServerInstance $ivSQL -Database $ivDatabase #-QueryTimeout
 if ($select_result -eq $Null)
 {  #p.24
     "Null  insert "
     $sql_insert = "INSERT INTO [Hosts] ([hostName],[updateDate]) VALUES  ( '$Node' ,getdate())";$sql_insert
     Invoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivDatabase #-QueryTimeout
 } #p.24
 else
 {  #p.24  "Get values  update"
     # $Node='00DPHCSSL01'
       $computerSystem = gwmi Win32_ComputerSystem -ComputerName $Node ; # $computerSystem |select *
            $manufacturer=$computerSystem.Manufacturer
            ;$Model=$computerSystem.Model
            ;$systemtype=$computerSystem.PCSystemType
            ;$LogicalProcessor=$computerSystem.NumberOfLogicalProcessors
            ;$PhyiscalProcessors=$computerSystem.NumberOfProcessors
            ;$domain=$computerSystem.Domain     

              $IPArr = gwmi Win32_NetworkAdapterconfiguration -ComputerName $Node | ? ipEnabled -Match 'True'; 
                $IP1=$IPArr.Ipaddress[0];$IP2=$IPArr.Ipaddress[1];$IP3=$IPArr.Ipaddress[2]
                $IP4=$IPArr.Ipaddress[3];$IP5=$IPArr.Ipaddress[4];$IP6=$IPArr.Ipaddress[5]

               $computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $Node  ;# $computerOS |select * 
                 $OS= $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion                 $OS = $OS.substring(25, $OS.length -25)                 $version=$computerOS.Version                 $servicePackMajorVersion=$computerOS.ServicePackMajorVersion                 $servicePackMinorVersion=$computerOS.servicePackMinorVersion                 $buildNumber=$computerOS.BuildNumber                 $InstallDate=$computerOS.ConvertToDateTime($computerOS.InstallDate)                 $TotalMemoryGigabytes=$computerSystem.TotalPhysicalMemory/1gb                 $TotalMemoryGigabytes = [math]::round($TotalMemoryGigabytes)                 $LastReboot= $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)

                   $sql_update= "update Hosts  set [manufacturer]='$manufacturer' ,[Model]='$Model' ,[numberOfProcessors]='$PhyiscalProcessors' 
                   ,[numberOfLogicalProcessors]='$LogicalProcessor' ,[totalPhysicalMemory]='$TotalMemoryGigabytes'  ,[lastBootUpTime]='$LastReboot' 
                   ,[OS]='$OS' ,[version]='$version'  ,[servicePackMajorVersion]='$servicePackMajorVersion' ,[buildNumber]='$buildNumber' ,[InstallDate]='$InstallDate' 
                     ,[IP1]='$IP1' ,[IP2]='$IP2'  ,[IP3]='$IP3' ,[IP4]='$IP4' ,[IP5]='$IP5'  ,[IP6]='$IP6' 
                   ,[domain]='$domain' 
                    , [updateDate]=getdate() where  hostName = '$Node'"
                    $sql_update               Invoke-Sqlcmd -Query $sql_update -ServerInstance $ivSQL -Database $ivDatabase #-QueryTimeout


 }  #p.24
 }# p141


#----------------------------------------------------------------------------------------------
#    6  udpate table SQLServers  step1
#----------------------------------------------------------------------------------------------
$ivSQL= "SQL-B-2012"
$ivDatabase="SQL_inventory"

$hostlist = Invoke-Sqlcmd -Query "SELECT hostName FROM Hosts" -ServerInstance $ivSQL -Database $ivDatabase
#$hostlist = "00DPHCSSL03"

foreach ($item in $hostlist) { #86
   
 $hostName=$item.hostName;
#$hostName = "00DPHCSSL03"

 $GetSAlls=icm -ComputerName  $hostName    {  Get-ClusterGroup | ? name -like 'SQL Server (*' }

 foreach ($GSoneAll in $GetSAlls)
 {  #25
             $NetName =""
              $OSClusterName = ""
               $tInstanceName=""
               $tVersion=""
               $teditionName=""               $tCollation=""
               #$GSoneAll.OwnerNode=""
              # $GSoneAll.PSComputerName=""
    $SN=$GSoneAll.Name;# '#17-----'+$GSoneAll  
    $GetS=icm -ComputerName $hostName  { param($SN) Get-ClusterGroup  $SN  | Get-ClusterResource | ?  Name  -Like 'SQL Network Name (*' }  -ArgumentList $SN 
    if ($GetS -eq  $Null) {  continue }
    $t=($GetS.name).Substring(($GetS.name).IndexOf('(')+1,($GetS.name).Length- ($GetS.name).IndexOf('(')-1) 
    $SQLCluster1=$t.Substring(0,$t.Length-1) ;#'-----------'+$SQLCluster1

  $Server= New-Object -TypeName Microsoft.Sqlserver.management.Smo.server -ArgumentList  $SQLCluster1
#    $server |select *
# '++++++++++++++++++++++++++++++++++++++++++'
              $nodeownerHost=$GSoneAll.OwnerNode
              $NetName = $server.NetName
              $OSClusterName = $Server.ClusterName
               $tInstanceName=$Server.InstanceName
               $tVersion=$Server.version
               $teditionName=$Server.Edition               $tCollation=$Server.Collation               if ($tInstanceName.Length -eq  0 )
               {
                   $tInstanceName="MSSQLSERVER"
               }$sql_insert = @"INSERT INTO [SQLServers] ([instanceName],[Node1Host],[editionName],[Version],[Collation],[SQLClusterName],[OSClusterName],[nodeownerHost],[updateDate]) VALUES ('$tInstanceName', '$hostName','$teditionName','$tVersion','$tCollation','$NetName','$OSClusterName','$nodeownerHost',getdate())"@#$sql_insertInvoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivDatabase #-QueryTimeout
     } #25
     }#86

 # TSQL    
select [SQLClusterName] ,nodeownerHost, [instanceName],[Node1Host],[OSClusterName],[updateDate],[editionName],[Version]  from sqlservers
order by [SQLClusterName]


#----------------------------------------------------------------------------------------------
# 7  funtion  update SQL  cluster owner Nodes
#----------------------------------------------------------------------------------------------
Function UpdateSQLClusterOwnerNode ($ivSQL, $ivDatabase)
{#3
$ivSQL= "SQL-B-2012"
$ivDatabase="SQL_inventory"
$FENodeS = Invoke-Sqlcmd -Query "SELECT distinct node1host FROM sqlservers" -ServerInstance $ivSQL -Database $ivDatabase
Foreach ($FENode in $FENodeS)
{#4

 $FESQLServiceS=icm -ComputerName  $FENode.node1host  {  Get-ClusterGroup | ? name -like 'SQL Server (*' }
#                               icm -ComputerName  01DPHCSSL04   {  Get-ClusterGroup | ? name -like 'SQL Server (*' }
 
 Foreach ($FESQLService in $FESQLServiceS)
 {#5
  $GVSNN=icm -ComputerName $FENode.node1host  { param($FESQLService ) Get-ClusterGroup  $FESQLService   | Get-ClusterResource | ?  Name  -Like 'SQL Network Name (*' }  -ArgumentList $FESQLService.Name
  if ($GVSNN -eq  $Null) {  continue }
  $t=($GVSNN.name).Substring(($GVSNN.name).IndexOf('(')+1,($GVSNN.name).Length- ($GVSNN.name).IndexOf('(')-1) 
  $GVSQLCluster=$t.Substring(0,$t.Length-1) ;#'-----------'+$SQLCluster
#$FESQLService.name  +"     ownerNode is    "+$FESQLService.OwnerNode
#$SQL_update="update SQLServers Set  nodeownerHost='"+ $FESQLService.OwnerNode +"' , updatedate =  Getdate()  where   SQLClusterName= '" +$GVSQLCluster  +"' AND  nodeownerHost = ' "+ $FENode.node1host+"'"
 $SQL_update="update SQLServers Set  nodeownerHost='"+ $FESQLService.OwnerNode +"' , updatedate =  Getdate()  where   SQLClusterName= '" +$GVSQLCluster  +"'"
 Invoke-Sqlcmd -Query $SQL_update -ServerInstance $ivSQL -Database $ivDatabase #-QueryTimeout
}#5
}#4
}#3

UpdateSQLClusterOwnerNode  SQL-B-2012  SQL_inventory
## TSQL
select GETDATE()
SELECT distinct SQLClusterName,InstanceName,nodeownerHost,updatedate FROM sqlservers order by SQLClusterName




#----------------------------------------------------------------------------------------------
# 8   Table HostsDisks
#----------------------------------------------------------------------------------------------
DROP TABLE [dbo].[HostsDisks]
GO
CREATE TABLE [dbo].HostsDisks(
[MID] [varchar](128) ,
[instanceName] [varchar](128),
[hostName] [varchar](128) Null,
[drive] [char](2)  NULL,
[totalSizeG] [float],
[freeSpaceG] [float],
[total_datafile_sizeG] float,
[total_logfile_sizeG] float,
[total_filestream_sizeG] float,
[total_fulltext_sizeG] float,
[updateDate] [smalldatetime] NOT NULL default getDate()
)
GO

select * from HostsDisks





#----------------------------------------------------------------------------------------------
# 9 function updateHostDisks   need from  get-clusterdisk ,  may.07.2014
#----------------------------------------------------------------------------------------------

function updateHostDisks ($ivSQL, $ivDatabase) 
{ #5
#$ivSQL="SQL-B-2012"
#$ivdatabase='SQL_inventory'
$FENodeS=Invoke-Sqlcmd -Query "select distinct Node1Host from SQLServers" -ServerInstance $ivSQL -Database $ivdatabase
   #$Get1s
     foreach ($FENode in $FENodeS)
   {#245
     $hostname1=$FENode.Node1Host 
     #  '-----------'+$Get1.SQLClusterName  + ' --- '+ $Get1.Node1Host
     $FEdiskS=gwmi win32_logicaldisk -ComputerName $hostname1 -Filter "FileSystem='NTFS'" |select name,size,freespace
     if ($FEdiskS -eq $Null){ contiune }
     foreach($FEdisk in $FEdiskS)
     {#105
     $disklabel=$FEdisk.name
     $totalsize=[math]::round(($FEdisk.size)/1073741824, 0)
     $FreeSize =[math]::round(($FEdisk.freespace)/1073741824, 0)
     #$disklabel + ' -- ' +$totalsize +' -- '+ $FreeSize
     $sqlstring="select hostName from HostsDisks where  drive= '"+$disklabel +"' and totalSizeG = '"+ $totalsize + "' and hostName = '"+ $hostname1 + "' "  
     $Get2s=Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivdatabase
      if ($Get2s -ne $Null)
      {#90
          'Update'
          $SQL_update= "update HostsDisks set [freeSpaceG]='$FreeSize' , [updateDate]=getdate() where  hostname = '$hostname1' and  drive= '$disklabel'"
          Invoke-Sqlcmd -Query $SQL_update -ServerInstance $ivSQL -Database $ivdatabase #-QueryTimeout
      }#90
      else
      {#90
         $sql_insert = @"INSERT INTO [HostsDisks] ([hostname],[drive],[totalSizeG],[freeSpaceG],[updateDate]) VALUES ('$hostname1', '$disklabel','$totalsize' ,'$FreeSize',getdate())"@$sql_insertInvoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivdatabase #-QueryTimeout
      }#90
     }#105
   }#245
}#5

updateHostDisks  SQL-B-2012  SQL_inventory

##TSQL
use SQL_Inventory
select hostname,drive,totalsizeG,FreespaceG,totalsizeG-FreespaceG as[using] , round(FreespaceG/totalsizeG,2)*100 as [available %]
 From hostsdisks 
-- where 
 order by [available %]


#----------------------------------------------------------------------------------------------
# 10  TSQL
#----------------------------------------------------------------------------------------------
select * from hosts
select * from sqlservers
select * from sqldatabases
select * from hostsdisks

##
SELECT s.sqlclustername,d.hostname,nodeownerHost,drive,totalsizeG , FreespaceG 
, round(FreespaceG/totalsizeG,2)*100 as [available %] FROM sqlservers s
join  hostsdisks d on s.node1host=d.hostname
--where s.sqlclustername='SQL-A-2012'
order by sqlclustername,hostname, drive

##

SELECT distinct SQLClusterName,InstanceName,nodeownerHost,updatedate FROM sqlservers order by SQLClusterName

##  select  db file  , disk  space
select s.instanceName,s.databasename,s.database_id
, Datafilepath,DataFileSizeG, d.drive,round(FreespaceG/totalsizeG,2)*100 as [available %]
from sqldatabases s
join  hostsdisks d on substring(s.Datafilepath,0,3)=d.drive
where s.databasename  not in ('master','model','msdb','tempdb') and s.instancename=d.instancename
and s.instanceName='SQL-B-2012'
union 
select s.instanceName,s.databasename,s.database_id
,Logfilepath,LogfilesizeG, d.drive,round(FreespaceG/totalsizeG,2)*100 as [available %]
from sqldatabases s
join  hostsdisks d on substring(s.logfilepath,0,3)=d.drive
where s.databasename  not in ('master','model','msdb','tempdb') and s.instancename=d.instancename
and s.instanceName='SQL-B-2012'
order by  instancename,s.database_id ,databasename


## Get Database 
select instanceName,Datafilepath,DataFileSizeG, logfilepath ,LogfilesizeG
from  Sqldatabases where databasename='WinMasterVI'


## query  all   by database
select s.instanceName,s.databasename,s.database_id
, Datafilepath,DataFileSizeG, d.drive,round(FreespaceG/totalsizeG,2)*100 as [available %]
from sqldatabases s
join  hostsdisks d on substring(s.Datafilepath,0,3)=d.drive
where s.databasename  not in ('master','model','msdb','tempdb') and s.instancename=d.instancename
and s.databasename='ObserveIT'
union 
select s.instanceName,s.databasename,s.database_id
,Logfilepath,LogfilesizeG, d.drive,round(FreespaceG/totalsizeG,2)*100 as [available %]
from sqldatabases s
join  hostsdisks d on substring(s.logfilepath,0,3)=d.drive
where s.databasename  not in ('master','model','msdb','tempdb') and s.instancename=d.instancename
and s.databasename='ObserveIT'
order by  instancename,s.database_id ,databasename


#----------------------------------------------------------------------------------------------
#11 udpateSQLdatabases   updatesql not finish
#----------------------------------------------------------------------------------------------
 Function udpateSQLdatabases ($ivSQL, $ivDatabase)
 {#2
#$ivSQL="SQL-B-2012"
#$ivdatabase='SQL_inventory'
$FEClusterS = Invoke-Sqlcmd -Query "SELECT distinct sqlclustername FROM SQLServers" -ServerInstance $ivSQL -Database $ivdatabase
foreach ($FECluster  in $FEClusterS )
{#5

  $in=$FECluster.sqlclustername
    #$pInstanceName='2013BI'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    $sqlstring="select name,database_id,compatibility_level,create_date,collation_name,recovery_model_desc,state_desc
,is_published,is_subscribed,is_distributor,user_access_desc from  master.sys.databases"
    
    $GetSQLdatabases= Invoke-Sqlcmd -Query $sqlstring -ServerInstance $in

    foreach ($GetSQLdatabase  in $GetSQLdatabases )
   { #1235

       $sql_select ="select * from SQLDatabases  where instancename='"+$in +"' and databasename= '"+$GetSQLdatabase.name+"'"

       $FEDatabase = Invoke-Sqlcmd -Query $sql_select -ServerInstance $ivSQL -Database $ivdatabase
       if ($FEDatabase.count -eq 1)
       { #6 update
            'update'
         # $SQL_update= "update SQLDatabases set [freeSpaceG]='$FreeSize' , [updateDate]=getdate() where  hostname = '$hostname1' and  drive= '$disklabel'"
         # Invoke-Sqlcmd -Query $SQL_update -ServerInstance $ivSQL -Database $ivdatabase #-QueryTimeout
       } #6
       else
       { #6 insert
  $databasename=$GetSQLdatabase.name
  $databaseid=$GetSQLdatabase.database_id
  $compatibilitylevel=$GetSQLdatabase.compatibility_level
       
  $createdate=$GetSQLdatabase.create_date
  $collationname=$GetSQLdatabase.collation_name
  $recovery_model_desc=$GetSQLdatabase.recovery_model_desc
  $statedesc=$GetSQLdatabase.state_desc
          
  $ispublished=$GetSQLdatabase.is_published
  $issubscribed=$GetSQLdatabase.is_subscribed
  $isdistributor=$GetSQLdatabase.is_distributor 
  $useraccessdesc=$GetSQLdatabase.user_access_desc
            $sql_insert = @"INSERT INTO [SQLDatabases] ([instanceName],[databasename],[database_id],[compatibility_level],[create_date],[collation_name],[recovery_model_desc],[state_desc],[is_published],[is_subscribed],[is_distributor],[user_access_desc],[updateDate]) VALUES ('$in', '$databasename','$databaseid','$compatibilitylevel' ,'$createdate','$collationname','$recovery_model_desc','$statedesc','$ispublished','$issubscribed','$isdistributor','$useraccessdesc',getdate())"@
# $sql_insert 
Invoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivdatabase #-QueryTimeout
       } #6
}#1235

}#5
}#2
# 
udpateSQLdatabases  SQL-B-2012  SQL_inventory
##TSQL
select instanceName,databasename,recovery_model_desc,compatibility_level,is_published
from sqldatabases 
where databasename not in ('master','model','msdb','tempdb')-- and instancename='SQL-D-2008R2' 
order by instancename,databasename


#----------------------------------------------------------------------------------------------
# 12   600  GetSQLDBFileSize
#----------------------------------------------------------------------------------------------
function GetSQLDBFileSize ($pInstanceName,[int] $databaseid)
{
    
    #$databaseid='5'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    #$pInstanceName='sp2013'
    $sqlstring1="select physical_name as [DataFilePath],Size *0.000008 as [DataFileSizeG]
    from msdb.sys.master_files where type=0   and FILE_ID=1 and database_id='$databaseid'"

    $GetSQLFile1=(Invoke-Sqlcmd -Query $sqlstring1 -ServerInstance $pInstanceName)
    $DataPath=$GetSQLFile1.DataFilePath
    $Datasize=$GetSQLFile1.DataFileSizeG

    $sqlstring2="select physical_name as [LogFilePath],Size *0.000008 as [LogFileSizeG]
    from msdb.sys.master_files where type=1   and FILE_ID=2 and database_id='$databaseid'"

    $GetSQLFile2=(Invoke-Sqlcmd -Query $sqlstring2 -ServerInstance $pInstanceName)
    $LogPath=$GetSQLFile2.LogFilePath
    $Logsize=$GetSQLFile2.LogFileSizeG
    $DataPath,$Datasize,$LogPath,$Logsize

}


$ivSQL="SQL-B-2012"
$ivdatabase='SQL_inventory'
$instanceNameS = Invoke-Sqlcmd -Query "SELECT instanceName,database_id FROM SQLDatabases" -ServerInstance $ivSQL -Database $ivdatabase
foreach ($instanceName  in $instanceNameS )
{
 
  $Fileset= GetSQLDBFileSize  ($instanceName.instanceName) ($instanceName.database_id) 
  $dl=$Fileset[0];$ds=$Fileset[1];$ll=$Fileset[2];$ls=$Fileset[3]
  $inx=$instanceName.instanceName
  $dix=$instanceName.database_id
  $sql_update= "update SQLDatabases set [DataFilePath]='$dl', [DataFileSizeG]='$ds' 
  , [LogFilePath]='$ll' , [LogFileSizeG]='$ls' , [updateDate]=getdate() where  instanceName = '$inx' and  database_id= '$dix'"
 #$sql_update
  Invoke-Sqlcmd -Query $sql_update -ServerInstance $ivSQL -Database $ivdatabase  #-QueryTimeout

}



#----------------------------------------------------------------------------------------------
# 13  600   add  SQL_Inventory to ASSETAG
#----------------------------------------------------------------------------------------------

$DatabaseBackupFile = "\\10.0.21.113\c$\software\SQL_Inventory20140507_12.bak"
$LogBackupFile            = "\\10.0.21.113\c$\software\SQL_Inventory20140507_12.trn"

$Node1Name="SQL-B-2012"
$Node2Name="SQL-Z1-2012"

$Instance1Name="default"
$Instance2Name="PRB"

$AGName="ASSETAG"
$AddAGDatabase="SQL_Inventory"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName

cd $MyAgPrimaryPath; $ObjectInstance=gi .




$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup

#Invoke-Sqlcmd {BACKUP DATABASE [SQL_Inventory] TO  DISK = N'\\SQL2012X\share\SQLInventory0506.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5 } -ServerInstance $Node1Name 
#Invoke-Sqlcmd {BACKUP DATABASE [SQL_Inventory] TO  DISK = N'\\SQL2012X\share\SQLInventory0506.trn' WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5} -ServerInstance $Node1Name 

#Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance $Node1Name
#Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance $Node1Name -BackupAction 'Log'

##--alter database sql_inventory set recovery full

Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance "$Node1Name\$Instance1Name"
Backup-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance "$Node1Name\$Instance1Name" -BackupAction 'Log'

#create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

Invoke-Sqlcmd {RESTORE DATABASE SQL_Inventory FROM  DISK = N'\\10.0.21.113\c$\software\SQL_Inventory20140507_13.bak' 
WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5,
  MOVE 'SQLInventory' TO N'X:\UserDB\SQL_Inventory.MDF', 
  MOVE 'SQLInventory_log'  TO N'X:\UserDB\SQL_Inventory_log.LDF'
} -ServerInstance $Node2Name 

Invoke-Sqlcmd {RESTORE LOG SQL_Inventory FROM  DISK = N'\\10.0.21.113\c$\software\SQL_Inventory20140507_13.trn' 
WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
} -ServerInstance $Node2Name 


#Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance $Node2Name -NoRecovery
#Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance $Node2Name -RestoreAction 'Log' -NoRecovery

#Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $DatabaseBackupFile -ServerInstance "SecondaryServer\InstanceName" -NoRecovery
#Restore-SqlDatabase -Database $AddAGDatabase -BackupFile $LogBackupFile -ServerInstance "SecondaryServer\InstanceName" -RestoreAction 'Log' -NoRecovery



Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

$rd=$MyAgPrimaryPath+"\AvailabilityDatabases\"+$AddAGDatabase
Remove-SqlAvailabilityDatabase -Path $rd 
                                     
Suspend-SqlAvailabilityDatabase -Path $rd 

Resume-SqlAvailabilityDatabase -Path $rd 

#----------------------------------------------------------------------------------------------
#  14   700    add  WinMasterVI  to ASSETAG
#----------------------------------------------------------------------------------------------


# 0 Set
$DatabaseBackupFile = "\\10.0.21.113\c$\software\WinMasterVI20140507_18.bak"
$LogBackupFile            = "\\10.0.21.113\c$\software\WinMasterVI20140507_18.trn"

$Node1Name="SQL-B-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-Z1-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="PRB"

$AGName="ASSETAG"
$AddAGDatabase="WinMasterVI"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup

$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; #BACKUP DATABASE WinMasterVI TO  DISK = N'\\10.0.21.113\c$\software\WinMasterVI20140507_14.bak'
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;#BACKUP Log  WinMasterVI  TO  DISK = N'\\10.0.21.113\c$\software\WinMasterVI20140507_14.trn' 
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 1200
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 1200
$t2=get-date
($t2-$t1).TotalSeconds


#create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name


$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
 
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5,
  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase


#----------------------------------------------------------------------------------------------
# 15   750   failover to another 
#----------------------------------------------------------------------------------------------

##-------------------------  Primary to DR
$witnessNode="00DPHCSSL01"
$SQLCluster ="SQL-Z1-2012"

$sql="select getdate() as [Now],lr.dns_name,ip_address,state_desc from sys.availability_group_listener_ip_addresses  ip join  sys.availability_group_listeners lr on lr.listener_id=ip.listener_id where state=1"
$t1state=Invoke-Sqlcmd $sql -ServerInstance $SQLCluster ; "    T1   "+ $t1state.ip_address
$t1=get-date
    Invoke-Sqlcmd "ALTER AVAILABILITY GROUP [ASSETAG] FAILOVER" -ServerInstance $SQLCluster  #-Database "Master"
$t2=get-date
    'Failover spend----- '+ ($t2-$t1).TotalSeconds
sleep 1
$t2state=Invoke-Sqlcmd $sql -ServerInstance $SQLCluster ;"   T2     "+$t2state.ip_address
Invoke-Sqlcmd "select primary_replica from sys.dm_hadr_availability_group_states" -ServerInstance $SQLCluster 
sleep 1
do
{ 
get-date
icm -ComputerName $witnessNode {ping sqlassetdb}  
#icm -ComputerName '00DPHCSSL01'  {ipconfig /flushdns;ping sqlassetdb}  
    sleep 3
}
until ($x -gt 0)


##---------------------------  Primary to PR
$witnessNode="00DPHCSSL01"
$SQLCluster ="SQL-B-2012"
$sql="select getdate() as [Now],lr.dns_name,ip_address,state_desc from sys.availability_group_listener_ip_addresses  ip join  sys.availability_group_listeners lr on lr.listener_id=ip.listener_id where state=1"
$t1state=Invoke-Sqlcmd $sql -ServerInstance $SQLCluster ; "    T1   "+ $t1state.ip_address

$t1=get-date
Invoke-Sqlcmd "ALTER AVAILABILITY GROUP [ASSETAG] FAILOVER" -ServerInstance $SQLCluster  #-Database "Master"
$t2=get-date
       'Failover spend----- '+  ($t2-$t1).TotalSeconds
sleep 1
$t2state=Invoke-Sqlcmd $sql -ServerInstance $SQLCluster ;"   T2     "+$t2state.ip_address
Invoke-Sqlcmd "select primary_replica from sys.dm_hadr_availability_group_states" -ServerInstance $SQLCluster 
sleep 1
do
{ 
get-date
icm -ComputerName $witnessNode  {ping sqlassetdb}  
#icm -ComputerName $witnessNode  {ipconfig /flushdns;ping sqlassetdb}     
    sleep 3
}
until ($x -gt 0)
##

icm -ComputerName '00DPHCSSL01'  {ipconfig /flushdns;ping sqlassetdb}  


icm -ComputerName '00DPHCSSL03'  {ping sqlassetdb}  # PR SQL-B-2012  (10.0.21.113) Node
icm -ComputerName '01DPHCSSL03'  {ping sqlassetdb}  # DR SQL-B-2012  (10.1.21.103)
icm -ComputerName '00DPHCSSL08'  {ping sqlassetdb} # ping 00DPHCSSL08  (10.0.21.134)
#----------------------------------------------------------------------------------------------
#   16   800  sys.availability
#----------------------------------------------------------------------------------------------

select * from sys.availability_databases_cluster
select ip_address,state_desc from sys.availability_group_listener_ip_addresses


select getdate() as [Now],lr.dns_name,ip_address,state_desc from sys.availability_group_listener_ip_addresses  ip
join  sys.availability_group_listeners lr on lr.listener_id=ip.listener_id where state=1

select * from sys.dm_hadr_availability_group_states st
select * from sys.availability_group_listener_ip_addresses 

select dns_name from sys.availability_group_listeners
select * from sys.availability_groups
select * from sys.availability_groups_cluster
select * from sys.availability_read_only_routing_lists
select * from sys.availability_replicas
select * from sys.dm_hadr_availability_group_states
select * from sys.dm_hadr_availability_replica_cluster_nodes
select * from sys.dm_hadr_availability_replica_cluster_states
select * from sys.dm_hadr_availability_replica_states

select name,* from sys.availability_groups

select ip_address,state_desc from sys.availability_group_listener_ip_addresses
select * from sys.availability_group_listeners

select * from sys.availability_groups --;select name,automated_backup_preference,automated_backup_preference_desc from sys.availability_groups 
select * from sys.availability_groups_cluster --;select name, from sys.availability_groups_cluster

select * from sys.availability_replicas



select * from sys.dm_hadr_availability_replica_cluster_nodes
select * from sys.dm_hadr_availability_replica_states

#----------------------------------------------------------------------------------------------
#   17  850   function EstimateTime ( $SQLCluster)
#----------------------------------------------------------------------------------------------

function EstimateTime ( $SQLCluster)
{
    
# $SQLCluster='sql-z1-2012'
$estimate="
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

$sql_sqlname=Invoke-Sqlcmd  $estimate  -ServerInstance $SQLCluster 
$sql_sqlname

}
EstimateTime sql-z1-2012

#----------------------------------------------------------------------------------------------
#  18
#----------------------------------------------------------------------------------------------





#----------------------------------------------------------------------------------------------
#  19
#----------------------------------------------------------------------------------------------



#----------------------------------------------------------------------------------------------
#  20
#----------------------------------------------------------------------------------------------



## ----------------------------------------------------
##  Get filegroups
USE [SQL_Inventory]
GO
select * from sys.filegroups

##   Add FileGroups

##  set  FileGroups

ALTER DATABASE [SQL_Inventory] MODIFY FILEGROUP [TestFG] DEFAULT
ALTER DATABASE [SQL_Inventory] MODIFY FILEGROUP [PRIMARY] DEFAULT

##  remove  FileGroups
ALTER DATABASE [SQL_Inventory]  REMOVE FILE [SQL_Inventory2_log]
GO
## ----------------------------------------------------
#
## ----------------------------------------------------

alter database SQL_Inventory set recovery simple

## ----------------------------------------------------
#FILE
## ----------------------------------------------------

## get 
select * from sys.master_files where database_id='8'

## add
USE [master]
GO
ALTER DATABASE SQL_Inventory ADD LOG FILE ( NAME = N'SQL_Inventory2_log', FILENAME = N'Y:\SQLDB\SQL_Inventory2_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO

## remove
USE [SQL_Inventory]
GO
ALTER DATABASE [SQL_Inventory]  REMOVE FILE [SQLInventory_log]
GO


































































#----------------------------------------------------------------------------------------------
# 21   EIP   pre-installation
#----------------------------------------------------------------------------------------------
\\10.0.21.113\c$\software\ps1\TSQL\0_TSql_General.sql
Get-PSDrive
GET-WindowsFeature  RSAT-AD-PowerShell
Import-Module  "sqlps" -DisableNameChecking
Set-ExecutionPolicy remotesigned
Add-WindowsFeature  RSAT-AD-PowerShell
Get-Cluster  #SQL_E_OS      
Get-ClusterNode

$env:COMPUTERNAME


$hostlist="00DPHCSSC01","00DPHCSSC02","01DPHCSSC01","01DPHCSSC02"

$hostlist[0]
$hostlist[1]
$hostlist[2]
$hostlist[3]

icm -ComputerName 01DPHCSSL04 {hostname; get-date}

ping 00DPHCSSC01  10.0.23.114
ping 00DPHCSSC02  10.0.23.113
ping 01DPHCSSC01  10.1.23.113
ping 01DPHCSSC02  10.1.23.114

gwmi  Win32_ComputerSystem -ComputerName $hostlist[10]
gwmi  Win32_ComputerSystem -ComputerName $hostlist[0]

icm  00DPHCSSC01  {get-date;hostname}
icm  01DPHCSSC01  {get-date;hostname}
icm  01DPHCSSC02  {get-date;hostname}



ping SQL-B-2012
ping 10.0.21.111  
C:\Windows\System32\Drivers\etc\hosts

10.0.23.114 	00DPHCSSC01 
10.0.23.113 	00DPHCSSC02  
10.1.23.113	01DPHCSSC01  
10.1.23.114	01DPHCSSC02  
10.0.21.111	SQLASSETDB
Invoke-Sqlcmd

 $select_result= Invoke-Sqlcmd  -Query   "select GETDATE(); select  @@SERVICENAME "    -ServerInstance $ivSQL  -Username 'sa'  -Password  'syscom#1'  
  Invoke-Sqlcmd   "select GETDATE()"  -ServerInstance "SQL-E-2012"
#----------------------------------------------------------------------------------------------
# 25  1100   update table hosts
#----------------------------------------------------------------------------------------------
$ivSQL= "SQLASSETDB"
$ivDatabase="SQL_inventory"
$hostlist="00DPHCSSC01","00DPHCSSC02","01DPHCSSC01","01DPHCSSC02"

For ($i = 0; $i -lt $hostlist.Count; $i++)
{  #p141
 $Node=$hostlist[$i]  
 #$Node=$hostlist[0]  
 
 $sql_select ="select hostname  from hosts where hostname='" +$Node+"'"    #$sql_select ="select hostname  from hosts where hostname='01DPHCSSL03'"
 $select_result= Invoke-Sqlcmd -Query $sql_select -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1'   #-QueryTimeout
 if ($select_result -eq $Null)
 {  #p.24
     "Null  insert "
     $sql_insert = "INSERT INTO [Hosts] ([hostName],[updateDate]) VALUES  ( '$Node' ,getdate())";$sql_insert
    Invoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
 } #p.24
 else
 {  #p.24

   "Get values  update"
     # $Node='00DPHCSSL01'
       $computerSystem = gwmi Win32_ComputerSystem -ComputerName $Node ; # $computerSystem |select *
            $manufacturer=$computerSystem.Manufacturer
            ;$Model=$computerSystem.Model
            ;$systemtype=$computerSystem.PCSystemType
            ;$LogicalProcessor=$computerSystem.NumberOfLogicalProcessors
            ;$PhyiscalProcessors=$computerSystem.NumberOfProcessors
            ;$domain=$computerSystem.Domain     

              $IPArr = gwmi Win32_NetworkAdapterconfiguration -ComputerName $Node | ? ipEnabled -Match 'True'; 
                $IP1=$IPArr.Ipaddress[0];$IP2=$IPArr.Ipaddress[1];$IP3=$IPArr.Ipaddress[2]
                $IP4=$IPArr.Ipaddress[3];$IP5=$IPArr.Ipaddress[4];$IP6=$IPArr.Ipaddress[5]

               $computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $Node  ;# $computerOS |select * 
                 $OS= $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion                 $OS = $OS.substring(25, $OS.length -25)                 $version=$computerOS.Version                 $servicePackMajorVersion=$computerOS.ServicePackMajorVersion                 $servicePackMinorVersion=$computerOS.servicePackMinorVersion                 $buildNumber=$computerOS.BuildNumber                 $InstallDate=$computerOS.ConvertToDateTime($computerOS.InstallDate)                 $TotalMemoryGigabytes=$computerSystem.TotalPhysicalMemory/1gb                 $TotalMemoryGigabytes = [math]::round($TotalMemoryGigabytes)                 $LastReboot= $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)

                   $sql_update= "update Hosts  set [manufacturer]='$manufacturer' ,[Model]='$Model' ,[numberOfProcessors]='$PhyiscalProcessors' 
                   ,[numberOfLogicalProcessors]='$LogicalProcessor' ,[totalPhysicalMemory]='$TotalMemoryGigabytes'  ,[lastBootUpTime]='$LastReboot' 
                   ,[OS]='$OS' ,[version]='$version'  ,[servicePackMajorVersion]='$servicePackMajorVersion' ,[buildNumber]='$buildNumber' ,[InstallDate]='$InstallDate' 
                     ,[IP1]='$IP1' ,[IP2]='$IP2'  ,[IP3]='$IP3' ,[IP4]='$IP4' ,[IP5]='$IP5'  ,[IP6]='$IP6' 
                   ,[domain]='$domain' 
                    , [updateDate]=getdate() where  hostName = '$Node'"
                    $sql_update               Invoke-Sqlcmd -Query $sql_update -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout

#>
 }  #p.24
 }# p141


 #----------------------------------------------------------------------------------------------
#    26   1150   udpate table SQLServers  step1
#----------------------------------------------------------------------------------------------
$ivSQL= "SQLASSETDB"
$ivDatabase="SQL_inventory"

$hostlist = Invoke-Sqlcmd -Query "select * from Hosts where hostname in ('00DPHCSSC01','00DPHCSSC02','01DPHCSSC01','01DPHCSSC02') " `
-ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
#$hostlist = "00DPHCSSL03"

foreach ($item in $hostlist) { #86
   
 $hostName=$item.hostName;
#$hostName = "00DPHCSSL03"

 $GetSAlls=icm -ComputerName  $hostName    {  Get-ClusterGroup | ? name -like 'SQL Server (*' }

 foreach ($GSoneAll in $GetSAlls)
 {  #25
             $NetName =""
              $OSClusterName = ""
               $tInstanceName=""
               $tVersion=""
               $teditionName=""               $tCollation=""
               #$GSoneAll.OwnerNode=""
              # $GSoneAll.PSComputerName=""
    $SN=$GSoneAll.Name;# '#17-----'+$GSoneAll  
    $GetS=icm -ComputerName $hostName  { param($SN) Get-ClusterGroup  $SN  | Get-ClusterResource | ?  Name  -Like 'SQL Network Name (*' }  -ArgumentList $SN 
    if ($GetS -eq  $Null) {  continue }
    $t=($GetS.name).Substring(($GetS.name).IndexOf('(')+1,($GetS.name).Length- ($GetS.name).IndexOf('(')-1) 
    $SQLCluster1=$t.Substring(0,$t.Length-1) ;#'-----------'+$SQLCluster1

  $Server= New-Object -TypeName Microsoft.Sqlserver.management.Smo.server -ArgumentList  $SQLCluster1
#    $server |select *
# '++++++++++++++++++++++++++++++++++++++++++'
              $nodeownerHost=$GSoneAll.OwnerNode
              $NetName = $server.NetName
              $OSClusterName = $Server.ClusterName
               $tInstanceName=$Server.InstanceName
               $tVersion=$Server.version
               $teditionName=$Server.Edition               $tCollation=$Server.Collation               if ($tInstanceName.Length -eq  0 )
               {
                   $tInstanceName="MSSQLSERVER"
               }$sql_insert = @"INSERT INTO [SQLServers] ([instanceName],[Node1Host],[editionName],[Version],[Collation],[SQLClusterName],[OSClusterName],[nodeownerHost],[updateDate]) VALUES ('$tInstanceName', '$hostName','$teditionName','$tVersion','$tCollation','$NetName','$OSClusterName','$nodeownerHost',getdate())"@#$sql_insertInvoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
     } #25
     }#86

 # TSQL    
select [SQLClusterName] ,nodeownerHost, [instanceName],[Node1Host],[OSClusterName],[updateDate],[editionName],[Version]  from sqlservers
order by [SQLClusterName]

#----------------------------------------------------------------------------------------------
#27  1200  funtion  update SQL  cluster owner Nodes  
#----------------------------------------------------------------------------------------------
Function UpdateSQLClusterOwnerNode ($ivSQL, $ivDatabase)
{#3
$ivSQL= "SQLASSETDB"
$ivDatabase="SQL_inventory"
$FENodeS = Invoke-Sqlcmd -Query "SELECT distinct node1host FROM sqlservers where hostname in ('00DPHCSSC01','00DPHCSSC02','01DPHCSSC01','01DPHCSSC02') " -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
Foreach ($FENode in $FENodeS)
{#4

 $FESQLServiceS=icm -ComputerName  $FENode.node1host  {  Get-ClusterGroup | ? name -like 'SQL Server (*' }
#                               icm -ComputerName  01DPHCSSL04   {  Get-ClusterGroup | ? name -like 'SQL Server (*' }
 
 Foreach ($FESQLService in $FESQLServiceS)
 {#5
  $GVSNN=icm -ComputerName $FENode.node1host  { param($FESQLService ) Get-ClusterGroup  $FESQLService   | Get-ClusterResource | ?  Name  -Like 'SQL Network Name (*' }  -ArgumentList $FESQLService.Name
  if ($GVSNN -eq  $Null) {  continue }
  $t=($GVSNN.name).Substring(($GVSNN.name).IndexOf('(')+1,($GVSNN.name).Length- ($GVSNN.name).IndexOf('(')-1) 
  $GVSQLCluster=$t.Substring(0,$t.Length-1) ;#'-----------'+$SQLCluster
#$FESQLService.name  +"     ownerNode is    "+$FESQLService.OwnerNode
#$SQL_update="update SQLServers Set  nodeownerHost='"+ $FESQLService.OwnerNode +"' , updatedate =  Getdate()  where   SQLClusterName= '" +$GVSQLCluster  +"' AND  nodeownerHost = ' "+ $FENode.node1host+"'"
 $SQL_update="update SQLServers Set  nodeownerHost='"+ $FESQLService.OwnerNode +"' , updatedate =  Getdate()  where   SQLClusterName= '" +$GVSQLCluster  +"'"
 Invoke-Sqlcmd -Query $SQL_update -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
}#5
}#4
}#3

UpdateSQLClusterOwnerNode  SQL-B-2012  SQL_inventory
## TSQL
select GETDATE()
SELECT distinct SQLClusterName,InstanceName,nodeownerHost,updatedate FROM sqlservers order by SQLClusterName

#----------------------------------------------------------------------------------------------
# 29 function updateHostDisks   need from  get-clusterdisk ,  may.07.2014
#----------------------------------------------------------------------------------------------

function updateHostDisks ($ivSQL, $ivDatabase) 
{ #5
$FENodeS=Invoke-Sqlcmd -Query "select distinct Node1Host from SQLServers where Node1Host in ('00DPHCSSC01','00DPHCSSC02','01DPHCSSC01','01DPHCSSC02') " -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
   #$Get1s
     foreach ($FENode in $FENodeS)
   {#245
     $hostname1=$FENode.Node1Host 
     #  '-----------'+$Get1.SQLClusterName  + ' --- '+ $Get1.Node1Host
     $FEdiskS=gwmi win32_logicaldisk -ComputerName $hostname1 -Filter "FileSystem='NTFS'" |select name,size,freespace
     if ($FEdiskS -eq $Null){ contiune }
     foreach($FEdisk in $FEdiskS)
     {#105
     $disklabel=$FEdisk.name
     $totalsize=[math]::round(($FEdisk.size)/1073741824, 0)
     $FreeSize =[math]::round(($FEdisk.freespace)/1073741824, 0)
     #$disklabel + ' -- ' +$totalsize +' -- '+ $FreeSize
     $sqlstring="select hostName from HostsDisks where  drive= '"+$disklabel +"' and totalSizeG = '"+ $totalsize + "' and hostName = '"+ $hostname1 + "' "  
     $Get2s=Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
      if ($Get2s -ne $Null)
      {#90
          'Update'
          $SQL_update= "update HostsDisks set [freeSpaceG]='$FreeSize' , [updateDate]=getdate() where  hostname = '$hostname1' and  drive= '$disklabel'"
          Invoke-Sqlcmd -Query $SQL_update -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
      }#90
      else
      {#90
         $sql_insert = @"INSERT INTO [HostsDisks] ([hostname],[drive],[totalSizeG],[freeSpaceG],[updateDate]) VALUES ('$hostname1', '$disklabel','$totalsize' ,'$FreeSize',getdate())"@#$sql_insertInvoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
      }#90
     }#105
   }#245
}#5

updateHostDisks  SQLASSETDB  SQL_inventory

##TSQL
use SQL_Inventory
select hostname,drive,totalsizeG,FreespaceG,totalsizeG-FreespaceG as[using] , round(FreespaceG/totalsizeG,2)*100 as [available %]
 From hostsdisks 
-- where 
 order by [available %]


 #----------------------------------------------------------------------------------------------
#11 udpateSQLdatabases   updatesql not finish
#----------------------------------------------------------------------------------------------
 Function udpateSQLdatabases ($ivSQL, $ivDatabase)
 {#2

$FEClusterS = Invoke-Sqlcmd -Query "SELECT distinct sqlclustername FROM SQLServers where Node1Host in ('00DPHCSSC01','00DPHCSSC02','01DPHCSSC01','01DPHCSSC02')" `
-ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
foreach ($FECluster  in $FEClusterS )
{#5

  $in=$FECluster.sqlclustername
    #$pInstanceName='2013BI'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    $sqlstring="select name,database_id,compatibility_level,create_date,collation_name,recovery_model_desc,state_desc
,is_published,is_subscribed,is_distributor,user_access_desc from  master.sys.databases"
    
    $GetSQLdatabases= Invoke-Sqlcmd -Query $sqlstring -ServerInstance $in

    foreach ($GetSQLdatabase  in $GetSQLdatabases )
   { #1235
       $sql_select ="select * from SQLDatabases  where instancename='"+$in +"' and databasename= '"+$GetSQLdatabase.name+"'"
       $FEDatabase = Invoke-Sqlcmd -Query $sql_select -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1'
       if ($FEDatabase.count -eq 1)
       { #6 update
            'update'
         # $SQL_update= "update SQLDatabases set [freeSpaceG]='$FreeSize' , [updateDate]=getdate() where  hostname = '$hostname1' and  drive= '$disklabel'"
         # Invoke-Sqlcmd -Query $SQL_update -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
       } #6
       else
       { #6 insert
  $databasename=$GetSQLdatabase.name
  $databaseid=$GetSQLdatabase.database_id
  $compatibilitylevel=$GetSQLdatabase.compatibility_level
       
  $createdate=$GetSQLdatabase.create_date
  $collationname=$GetSQLdatabase.collation_name
  $recovery_model_desc=$GetSQLdatabase.recovery_model_desc
  $statedesc=$GetSQLdatabase.state_desc
          
  $ispublished=$GetSQLdatabase.is_published
  $issubscribed=$GetSQLdatabase.is_subscribed
  $isdistributor=$GetSQLdatabase.is_distributor 
  $useraccessdesc=$GetSQLdatabase.user_access_desc
            $sql_insert = @"INSERT INTO [SQLDatabases] ([instanceName],[databasename],[database_id],[compatibility_level],[create_date],[collation_name],[recovery_model_desc],[state_desc],[is_published],[is_subscribed],[is_distributor],[user_access_desc],[updateDate]) VALUES ('$in', '$databasename','$databaseid','$compatibilitylevel' ,'$createdate','$collationname','$recovery_model_desc','$statedesc','$ispublished','$issubscribed','$isdistributor','$useraccessdesc',getdate())"@
# $sql_insert 
Invoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
       } #6
}#1235

}#5
}#2
# 
udpateSQLdatabases  SQLASSETDB  SQL_inventory
##TSQL
select instanceName,databasename,recovery_model_desc,compatibility_level,is_published
from sqldatabases 
where databasename not in ('master','model','msdb','tempdb')-- and instancename='SQL-D-2008R2' 
order by instancename,databasename

#----------------------------------------------------------------------------------------------
# 32   1350  GetSQLDBFileSize
#----------------------------------------------------------------------------------------------
function GetSQLDBFileSize ($pInstanceName,[int] $databaseid)
{
    
    #$databaseid='5'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    #$pInstanceName='sp2013'
    $sqlstring1="select physical_name as [DataFilePath],Size *0.000008 as [DataFileSizeG]
    from msdb.sys.master_files where type=0   and FILE_ID=1 and database_id='$databaseid'"

    $GetSQLFile1=(Invoke-Sqlcmd -Query $sqlstring1 -ServerInstance $pInstanceName)
    $DataPath=$GetSQLFile1.DataFilePath
    $Datasize=$GetSQLFile1.DataFileSizeG

    $sqlstring2="select physical_name as [LogFilePath],Size *0.000008 as [LogFileSizeG]
    from msdb.sys.master_files where type=1   and FILE_ID=2 and database_id='$databaseid'"

    $GetSQLFile2=(Invoke-Sqlcmd -Query $sqlstring2 -ServerInstance $pInstanceName)
    $LogPath=$GetSQLFile2.LogFilePath
    $Logsize=$GetSQLFile2.LogFileSizeG
    $DataPath,$Datasize,$LogPath,$Logsize

}


$ivSQL="SQLASSETDB"
$ivdatabase='SQL_inventory'
$instanceNameS = Invoke-Sqlcmd -Query "SELECT instanceName,database_id FROM SQLDatabases where  instancename in ('SQL-E1-2012','SQL-E-2012','SQL-M-2012','SQL-X1-2012','SQL-X-2012')" `
-ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout
foreach ($instanceName  in $instanceNameS )
{
 
  $Fileset= GetSQLDBFileSize  ($instanceName.instanceName) ($instanceName.database_id) 
  $dl=$Fileset[0];$ds=$Fileset[1];$ll=$Fileset[2];$ls=$Fileset[3]
  $inx=$instanceName.instanceName
  $dix=$instanceName.database_id
  $sql_update= "update SQLDatabases set [DataFilePath]='$dl', [DataFileSizeG]='$ds' 
  , [LogFilePath]='$ll' , [LogFileSizeG]='$ls' , [updateDate]=getdate() where  instanceName = '$inx' and  database_id= '$dix'"
#$sql_update
 Invoke-Sqlcmd -Query $sql_update -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' #-QueryTimeout

}
#----------------------------------------------------------------------------------------------
# 
#----------------------------------------------------------------------------------------------
1  1414
Search_Service_Application_AnalyticsReportingStoreDB_a564958d09d54b0881c5aa5b019f71cb
2  1489
Search_Service_Application_CrawlStoreDB_b12a4a3bf14c4d13b44050d5f4826aa2
3  1556
Search_Service_Application_DB_8e4ca4c4e02141f0b1bc5b5dcdad2a93
4   1619
Search_Service_Application_LinksStoreDB_7dbfef0f3fc04328bae0d5df61e6e8dc
5  1684
SearchServiceApplication_Admindb
6  1749
SharePoint_Config
7   1815
WSS_Content_ECM
8  1881
WSS_Content_EIP
9  1945
WSS_Content_KMS
10  2011
WSS_Content_MySite
11  2074 
WSS_Content_Rex
12  2136
WSS_Logging

#1413----------------------------------------------------------------------------------------------
# 1  1414  Search_Service_Application_AnalyticsReportingStoreDB_a564958d09d54b0881c5aa5b019f71cb
#----------------------------------------------------------------------------------------------
{
# 0 Set
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\Search_Service_Application_AnalyticsReportingStoreDB_a564958d09d54b0881c5aa5b019f71cb_050721.bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\Search_Service_Application_AnalyticsReportingStoreDB_a564958d09d54b0881c5aa5b019f71cb_050721.trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"
$AddAGDatabase="Search_Service_Application_AnalyticsReportingStoreDB_a564958d09d54b0881c5aa5b019f71cb"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
 
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
#,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

}









#----------------------------------------------------------------------------------------------
# 2  1489   Search_Service_Application_CrawlStoreDB_b12a4a3bf14c4d13b44050d5f4826aa2
#----------------------------------------------------------------------------------------------
{
# 0 Set
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\Search_Service_Application_CrawlStoreDB_b12a4a3bf14c4d13b44050d5f4826aa2_050721.bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\Search_Service_Application_CrawlStoreDB_b12a4a3bf14c4d13b44050d5f4826aa2_050721.trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"
$AddAGDatabase="Search_Service_Application_CrawlStoreDB_b12a4a3bf14c4d13b44050d5f4826aa2"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
 
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
"

Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}


#----------------------------------------------------------------------------------------------
#     3   1556    Search_Service_Application_DB_8e4ca4c4e02141f0b1bc5b5dcdad2a93
#----------------------------------------------------------------------------------------------
{# 0 Set
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\Search_Service_Application_DB_8e4ca4c4e02141f0b1bc5b5dcdad2a93_050721.bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\Search_Service_Application_DB_8e4ca4c4e02141f0b1bc5b5dcdad2a93_050721.trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"
$AddAGDatabase="Search_Service_Application_DB_8e4ca4c4e02141f0b1bc5b5dcdad2a93"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore

$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
 
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#    4 1619  Search_Service_Application_LinksStoreDB_7dbfef0f3fc04328bae0d5df61e6e8dc
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="Search_Service_Application_LinksStoreDB_7dbfef0f3fc04328bae0d5df61e6e8dc"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"


$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
#2b   44.161502
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes  # 0.116638858333333

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#     5    1684  SearchServiceApplication_Admindb
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="SearchServiceApplication_Admindb"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds  #0.9257282


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
##2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
 ##2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
--,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#     (6) 1749   SharePoint_Config
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014051209"
$AddAGDatabase="SharePoint_Config"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds  #,125.1091321


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name
$DR_ldf_physical   =$sql_filepath[1].physical_name

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName
$PR_ldf_name=$sql_sqlname[1].LogicalName
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds  #189.8750002
($t4-$t3).TotalMinutes  #3.16458333666667


$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes  #0.0392177366666667

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#     (7)  1815   WSS_Content_ECM
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="WSS_Content_ECM"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds  #1.5193747


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
, MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds  #23.210075
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes  #0275927683333333

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}

#----------------------------------------------------------------------------------------------
#     (8)  1881   WSS_Content_EIP
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050811"
$AddAGDatabase="WSS_Content_EIP"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"    ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds  #69.505865

#1. create database
## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical

$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 

$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes  #31.1773410733333  ;   6.651904G

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t6=get-date
($t6-$t5).TotalMinutes  #  48.68113856    size:20.971520G

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase


}
#----------------------------------------------------------------------------------------------
#     (9)  1945  WSS_Content_KMS
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050811"
$AddAGDatabase="WSS_Content_KMS"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400
$t2=get-date
($t2-$t1).TotalSeconds  #   30.1082644 sec data20.971520G .Log27.267776G
#1. create database
<Sqlps07_General  #26  580  Create   database>
## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes  #17.2016366883333

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t6=get-date
($t6-$t5).TotalMinutes # 0.697650883333333

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}






#----------------------------------------------------------------------------------------------
#     10  2011  WSS_Content_MySite
#----------------------------------------------------------------------------------------------
{
# 0 Set
$bdate="_2014050721"
$AddAGDatabase="WSS_Content_MySite"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 7200
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 7200
$t2=get-date
($t2-$t1).TotalSeconds  #  18.9508424  sec;data3.844096   ,log10.485760

#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 7200
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 7200
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#     11  2074    WSS_Content_Rex
#----------------------------------------------------------------------------------------------
{
# 0 Set
$bdate="_2014051021"
$AddAGDatabase="WSS_Content_Rex"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14000
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14000
$t2=get-date
($t2-$t1).TotalSeconds  #

#1. create database
#<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#     (12)  2136  WSS_Logging
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014051021"
$AddAGDatabase="WSS_Logging"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400
$t2=get-date
($t2-$t1).TotalSeconds  #156.3578829sec #192.1767159     data 51.200000G


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
--,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t6=get-date
($t6-$t5).TotalMinutes

sleep 10
## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

}
#----------------------------------------------------------------------------------------------
#     extended
#----------------------------------------------------------------------------------------------
(1)  2209  Managed Metadata Service_0c295f4b68ae4122bf072c3dae5ee923
(2)   2272  SharePoint_AdminContent_b4855f69-235b-4f74-a875-9aed893f1729
(3)    2335    User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05
(4)   2399    User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450
(5)   2463   WSS_Content_SEARCH
#----------------------------------------------------------------------------------------------
#   (1)  2209 Managed Metadata Service_0c295f4b68ae4122bf072c3dae5ee923
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="Managed Metadata Service_0c295f4b68ae4122bf072c3dae5ee923"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#    (2)   2272 SharePoint_AdminContent_b4855f69-235b-4f74-a875-9aed893f1729
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="SharePoint_AdminContent_b4855f69-235b-4f74-a875-9aed893f1729"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}
#----------------------------------------------------------------------------------------------
#    ( 3)  2335   User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050816"
$AddAGDatabase="[User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05]"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400
$t2=get-date
($t2-$t1).TotalSeconds  #2.108755sec


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$AddAGDatabase1="User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05"
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase1')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
--,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes  #  1.4954614 M ,  1.38736472833333

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t6=get-date
($t6-$t5).TotalMinutes  # 0.249393403333333

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database 'User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05'
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database 'User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05'
}
#----------------------------------------------------------------------------------------------
#     (4) 2399   User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450
#----------------------------------------------------------------------------------------------
# 0 Set
$bdate="_2014050816"
$AddAGDatabase="[User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450]"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400
$t2=get-date
($t2-$t1).TotalSeconds #13.418705sec


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$AddAGDatabase1="User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450"
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase1')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes   #5.66434536833333M

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400
$t6=get-date
($t6-$t5).TotalMinutes  #  0.304294225

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database 'User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450'
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database 'User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450'

#----------------------------------------------------------------------------------------------
#     (5)  2463 WSS_Content_SEARCH
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="WSS_Content_SEARCH"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase

}
#----------------------------------------------------------------------------------------------
#     template
#----------------------------------------------------------------------------------------------
{# 0 Set
$bdate="_2014050721"
$AddAGDatabase="Search_Service_Application_LinksStoreDB_7dbfef0f3fc04328bae0d5df61e6e8dc"
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"

$Node1Name="SQL-E-2012"    ;$SQLCluster1=$Node1Name
$Node2Name="SQL-X-2012"  ;$SQLCluster2=$Node2Name

$Instance1Name="Default"
$Instance2Name="Default"

$AGName="SP2013_SQLE_AG"

$MyAgPrimaryPath = "SQLSERVER:\SQL\"+$Node1Name+"\"+$Instance1Name+"\AvailabilityGroups\"+$AGName
#cd $MyAgPrimaryPath; $ObjectInstance=gi .
$MyAgSecondaryPath = "SQLSERVER:\SQL\"+$Node2Name+"\"+$Instance2Name+"\AvailabilityGroups\"+$AGName
#cd  $MyAgSecondaryPath  ;$ObjectInstance2=gi .

## 1 Backup  cd c:\
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" ; 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  ;
$t1=get-date
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 2400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 2400
$t2=get-date
($t2-$t1).TotalSeconds


#1. create database
<Sqlps07_General  #26  580  Create   database>

## 2 Restore
#2a
$sql_filepath=Invoke-Sqlcmd "select physical_name  from sys.master_files where  database_id=DB_ID('$AddAGDatabase')"  -ServerInstance $Node2Name 
$DR_mdf_physical=$sql_filepath[0].physical_name;$DR_mdf_physical
$DR_ldf_physical   =$sql_filepath[1].physical_name;$DR_ldf_physical
$sql_sqlname=Invoke-Sqlcmd "restore filelistonly from  disk = '$DatabaseBackupFile'"  -ServerInstance $Node2Name 
$PR_mdf_name=$sql_sqlname[0].LogicalName;$PR_mdf_name
$PR_ldf_name=$sql_sqlname[1].LogicalName;$PR_ldf_name
 #2b
 $t3=get-date
$sql_mdfrestore="RESTORE DATABASE $AddAGDatabase  FROM  DISK = N'$DatabaseBackupFile'  WITH replace , NORECOVERY,  NOUNLOAD,  STATS = 5
,  MOVE '$PR_mdf_name'  TO N'$DR_mdf_physical', MOVE '$PR_ldf_name' TO N'$DR_ldf_physical'
"
Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 3000
$t4=get-date
($t4-$t3).TotalSeconds
($t4-$t3).TotalMinutes

$t5=get-date
$sql_ldfrestore="RESTORE LOG  $AddAGDatabase  FROM  DISK = N'$LogBackupFile'  WITH  NORECOVERY,  NOUNLOAD,  STATS = 5"
Invoke-Sqlcmd $sql_ldfrestore  -ServerInstance $Node2Name  -QueryTimeout 2400
$t6=get-date
($t6-$t5).TotalMinutes

## 3 Enable
Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase 
Add-SqlAvailabilityDatabase -Path $MyAgSecondaryPath -Database $AddAGDatabase
}


#----------------------------------------------------------------------------------------------
#  2592     SQL_E_2012_backup   1  -User Profile xxx
#----------------------------------------------------------------------------------------------
{
function SQL_E_2012backup  ($ivSQL , $ivDatabase ,$bdate)
{#3
$t1=get-date
$bdate="_2014050817"
$ivSQL= "SQLASSETDB"
$ivDatabase="SQL_inventory"

 $FENodeS=Invoke-Sqlcmd -Query "select distinct databasename from sqldatabases where instancename in ('SQL-E-2012')  and  databasename not in ('master','model','msdb','tempdb')" `
  -ServerInstance $ivSQL -Database $ivDatabase  -Username  sa  -Password  'syscom#1' 
  
  $t1=get-date
  foreach ($FENode in $FENodeS)
{ #8
$t2=get-date
$AddAGDatabase=$FENode.databasename
$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\"+$AddAGDatabase+$bdate+".trn"


$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  


Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400
$t3=get-date
'$AddAGDatabase' +' backup sub:   '+($t3-$t2).TotalSeconds

}#8
$t4=get-date
'total  backup:     ' +($t4-$t3).TotalMinutes
} #3


#----------------------------------------------------------------------------------------------
# 2630     SQL_E_2012backup  2    +User Profile xxx
#----------------------------------------------------------------------------------------------
User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05    
User Profile Service Application_SocialDB_023d3567f61c43acbe8b4a5a025230bd     
User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450  

$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05_2014050817.bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05_2014050817.trn"
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400

$DatabaseBackupFile = "\\10.0.23.113\r$\backupNBU\User Profile Service Application_SocialDB_023d3567f61c43acbe8b4a5a025230bd_2014050817.bak"
$LogBackupFile            = "\\10.0.23.113\r$\backupNBU\User Profile Service Application_SocialDB_023d3567f61c43acbe8b4a5a025230bd_2014050817.trn"
$sql_mdfbackup="BACKUP DATABASE $AddAGDatabase TO  DISK = N'$DatabaseBackupFile'" 
$sql_ldfbackup  = "BACKUP Log  $AddAGDatabase  TO  DISK = N'$LogBackupFile' "  
Invoke-Sqlcmd $sql_mdfbackup  -ServerInstance $Node1Name  -QueryTimeout 14400
Invoke-Sqlcmd $sql_ldfbackup     -ServerInstance $Node1Name  -QueryTimeout 14400

}


'
Add-SqlAvailabilityDatabase : 資料庫 "WSS_Logging" 的遠端副本的復原程度不足以啟用資料庫鏡像或將它聯結至可用性群組
。您必須從主體/主要資料庫還原目前的記錄備份，藉以將遺漏的記錄檔記錄套用至遠端資料庫。 
位於 線路:1 字元:1
+ Add-SqlAvailabilityDatabase -Path $MyAgPrimaryPath -Database $AddAGDatabase
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Add-SqlAvailabilityDataba 
   se]，SqlException
    + FullyQualifiedErrorId : ExecutionFailed,Microsoft.SqlServer.Management.P 
   owerShell.Hadr.AddSqlAvailabilityGroupDatabaseCommand
   '

#----------------------------------------------------------------------------------------------
#    2666  20140514   AG   for    asset   test
#----------------------------------------------------------------------------------------------
{


function GetAssetCluSrv
{
  $nodeS="00DPHCSSL03","00DPHCSSL04","01DPHCSSL03","01DPHCSSL04"
    foreach ($node in $nodeS)
    {
    $return=icm -ComputerName  $node  {(gsv "clusSvc").status}
    $return.PSComputerName+"-----clusvr---"+$return.Value
    }
}

Function AssetAGOwneIP 
{
$t1=get-date
$sqlonline="select dns_name,ip_address,state_desc from sys.availability_group_listeners  agl
join sys.availability_group_listener_ip_addresses agipa on agl.listener_id=agipa.listener_id
where agipa.state=1"
   $SPE=Invoke-Sqlcmd -ServerInstance "SQL-B-2012"  -Query $sqlonline
$SPE1=Invoke-Sqlcmd -ServerInstance "SQL-Z1-2012"  -Query $sqlonline 
$SPE;$SPE1 
$t2=get-date
"total Seconds = "+  ($t2-$t1).TotalSeconds
}

AssetAGOwneIP

function GetAGState ($ServerInstance)
{
    $sql ="select lr.dns_name  as [AG Listener],ac.name  as [AG Name],aip.ip_address,aip.state_desc
from  sys.availability_group_listeners lr
join  sys.availability_groups_cluster ac  on lr.group_id=ac.group_id
join  sys.availability_group_listener_ip_addresses aip on aip.listener_id=lr.listener_id"

Invoke-Sqlcmd  -ServerInstance   $ServerInstance  -Query  $sql 
}

 function ASSETAGPRtoDR ($param1, $param2)
 {
      $t1=get-date
 $SQLCluster2="SQL-Z1-2012" 
 $AGFailover="Alter Availability Group  ASSETAG  FAILOVER"
  Invoke-Sqlcmd  -ServerInstance   $SQLCluster2  -Query  $AGFailover
  $t2=get-date
  ($t2-$t1).TotalSeconds
 }

  function ASSETAGDRtoPR ($param1, $param2)
 {
      $t1=get-date
 $SQLCluster2="SQL-B-2012" 
 $AGFailover="Alter Availability Group  ASSETAG  FAILOVER"
  Invoke-Sqlcmd  -ServerInstance   $SQLCluster2  -Query  $AGFailover
  $t2=get-date
  ($t2-$t1).TotalSeconds
 }

 ASSETAGPRtoDR
 ASSETAGDRtoPR
ping SQLASSETDB
Ipconfig /flushdns
checkEIPDB
AssetAGOwneIP
GetAGState  SQLASSETDB
GetAGState  sql-b-2012
GetAGState  sql-z1-2012

Get-ClusterQuorum |select *


## ------------Get
$nodeS="00DPHCSSL03","00DPHCSSL04","01DPHCSSL03","01DPHCSSL04"

$n1=Get-Clusternode $nodeS[0]
$n2=Get-Clusternode $nodeS[1]
$n3=Get-Clusternode $nodeS[2]
$n4=Get-Clusternode $nodeS[3]

for ($i = 0; $i -lt 4; $i++)
{ 
    Get-Clusternode $nodeS[$i ]  |select NodeName, NodeWeight
}

##------------ Set  NodeWeight
$n3=Get-Clusternode $nodeS[2]
$n3.NodeWeight=0
$n3 |select NodeName, NodeWeight

##------------ Switch-SqlAvailabilityGroup
{  #  don't use
$bdate="_2014051021"
$AGDatabase="WSS_Logging"
$SQLCluster1="SQL-B-2012"  
$SQLCluster2="SQL-Z1-2012" 
$SQLInstance1="Default"
$SQLInstance2="Default"

$AGName="ASSETAG"

$SQLPathAG1 ="SQLSERVER:\SQL\"+$SQLCluster1+"\"+$SQLInstance1+"\AvailabilityGroups\"+$AGName
$SQLPathAG2= "SQLSERVER:\SQL\"+$SQLCluster2+"\"+$SQLInstance2+"\AvailabilityGroups\"+$AGName

cd  $SQLPathAG1
$objectAG1=gi .
$objectAG1 |select *


Switch-SqlAvailabilityGroup  -path  $SQLPathAG1 -AllowDataLoss -Force

Switch-SqlAvailabilityGroup  -path  $SQLPathAG2  # -AllowDataLoss -Force
}
}



#----------------------------------------------------------------------------------------------
#    2822  20140514   AG   for    EIP   test
#----------------------------------------------------------------------------------------------
{

#Import-Module  FailoverClusters

function GetEIPCluSrv
{
 $nodeS="00DPHCSSC01","00DPHCSSC02","01DPHCSSC01","01DPHCSSC02"
    foreach ($node in $nodeS)
    {
    $return=icm -ComputerName  $node  {(gsv "clusSvc").status}
    $return.PSComputerName+"-----clusvr---"+$return.Value
    }
}

GetEIPCluSrv

Function CheckEIPDB 
{ 
Clear-Host
    $sqlonline="select  getdate() as D ;  select @@Servername as N"
    $SPE=Invoke-Sqlcmd -ServerInstance SPE -Query $sqlonline
    $SPE1=Invoke-Sqlcmd -ServerInstance SPE1 -Query $sqlonline
    '-----------------'
    " SPE   running    @   " +  $SPE.N  +'    now is '+  ($SPE.D)
    '-----------------'
    " SPE1   running    @    " +  $SPE1.N  +  '   now is '+  ($SPE1.D)

}

Function EIPAGOwneIP 
{
$t1=get-date
$sqlonline="select dns_name,ip_address,state_desc from sys.availability_group_listeners  agl
join sys.availability_group_listener_ip_addresses agipa on agl.listener_id=agipa.listener_id
where agipa.state=1"
   $SPE=Invoke-Sqlcmd -ServerInstance "SQL-E-2012"  -Query $sqlonline
$SPE1=Invoke-Sqlcmd -ServerInstance "SQL-E1-2012"  -Query $sqlonline 
$SPE;$SPE1 
$t2=get-date
"total Seconds = "+  ($t2-$t1).TotalSeconds
}

EIPAGOwneIP

Function EIPAGFailover ($param1)
{#2
$t1=get-date
$SPE_Failover  ="ALTER AVAILABILITY GROUP  [SP2013_SQLE_AG]  FAILOVER"
$SPE1_Failover="ALTER AVAILABILITY GROUP  [SP2013_SQLE1_AG]  FAILOVER"
   if ($param1.length  -eq 6 )   {#3
    if ($param1 -eq "DRtoPR")
    {#5
        'now is DRtoPR'
        #$SPE_SQLCluster="SQL-E-2012" 
        #$SPE1_SQLCluster="SQL-E1-2012" 
        Invoke-Sqlcmd -ServerInstance "SQL-E-2012"  -Query $SPE_Failover
        sleep 5
        Invoke-Sqlcmd -ServerInstance "SQL-E1-2012"  -Query $SPE1_Failover
    }#5
    else
    {#5
        'now is PRtoDR'
         #$SPE_SQLCluster="SQL-X-2012" 
         #$SPE1_SQLCluster="SQL-X1-2012" 
          Invoke-Sqlcmd -ServerInstance "SQL-X-2012"  -Query $SPE_Failover
               sleep 5
          Invoke-Sqlcmd -ServerInstance "SQL-X1-2012"  -Query $SPE1_Failover
    }#5
     }#3
   else
   {#3     
    'plesae  enter again'  
   }#3
   $t2=get-date
"total Seconds = "+  ($t2-$t1).TotalSeconds
}#2
#EIPAGFailover  PRtoDR
#EIPAGFailover  DRtoPR

function GetAGState ($ServerInstance)
{
    $sql ="select lr.dns_name  as [AG Listener],ac.name  as [AG Name],aip.ip_address,aip.state_desc
from  sys.availability_group_listeners lr
join  sys.availability_groups_cluster ac  on lr.group_id=ac.group_id
join  sys.availability_group_listener_ip_addresses aip on aip.listener_id=lr.listener_id"

Invoke-Sqlcmd  -ServerInstance   $ServerInstance  -Query  $sql 
}


GetEIPCluSrv
CheckEIPDB
ping SPE
Ipconfig /flushdns

EIPAGOwneIP

GetAGState  spe ; GetAGState spe1

GetAGState  sql-e-2012
GetAGState  sql-x1-2012

Get-ClusterQuorum |select *


## ------------Get-cluster
Get-Clusternode
$nodeS="00DPHCSSC01","00DPHCSSC02","01DPHCSSC01","01DPHCSSC02"

$n1=Get-Clusternode $nodeS[0]
$n2=Get-Clusternode $nodeS[1]
$n3=Get-Clusternode $nodeS[2]
$n4=Get-Clusternode $nodeS[3]

for ($i = 0; $i -lt 4; $i++)
{ 
    Get-Clusternode $nodeS[$i ]  |select NodeName, NodeWeight
}

##------------ Set  NodeWeight
$n3=Get-Clusternode $nodeS[2]
$n3.NodeWeight=0
$n3 |select NodeName, NodeWeight

##------------ Switch-SqlAvailabilityGroup
$bdate="_2014051021"
$AGDatabase="WSS_Logging"
$SQLCluster1="SQLE-2012"  
$SQLCluster2="SQL-X-2012" 
$SQLInstance1="Default"
$SQLInstance2="Default"

$AGName="SP2013_SQLE_AG"

$SQLPathAG1 ="SQLSERVER:\SQL\"+$SQLCluster1+"\"+$SQLInstance1+"\AvailabilityGroups\"+$AGName
$SQLPathAG2= "SQLSERVER:\SQL\"+$SQLCluster2+"\"+$SQLInstance2+"\AvailabilityGroups\"+$AGName

cd  $SQLPathAG1
$objectAG1=gi .
$objectAG1 |select *


#Switch-SqlAvailabilityGroup  -path  $SQLPathAG1 -AllowDataLoss -Force

Switch-SqlAvailabilityGroup  -path  $SQLPathAG2  # -AllowDataLoss -Force

}


#----------------------------------------------------------------------------------------------
#troubshooting   database suspect 
#----------------------------------------------------------------------------------------------
{

-- 1
 select name,state_desc  from sys.databases
----3--
----alter database WSS_Logging set emergency

------4 
----dbcc checkdb(WSS_Logging);


------5
----alter database WSS_Logging set single_user with rollback immediate
--sp_who2 WSS_Logging

----sp_who
----kill 73

------ 6
---use WSS_Logging
----go
----dbcc checkdb (WSS_Logging ,repair_rebuild)
----go
----dbcc checkdb(WSS_Logging,Repair_allow_data_loss);

------ 7
alter database WSS_Logging  set multi_user

}

#----------------------------------------------------------------------------------------------
#  2777   cluster quorun
#----------------------------------------------------------------------------------------------
Get-Cluster
'SQL_E_OS'

Get-Clusternode
'Name                 ID    State                                               
----    E             --    -----                                               
00DPHCSSC01          2     Up                                                  
00DPHCSSC02          1     Up                                                  
01DPHCSSC01          4     Up                                                  
01DPHCSSC02          3     Up 


Get-ClusterQuorum
'SQL_E_OS                   PR-E-Q-10G(1)                    NodeAndDiskMajority'


----     B            --    -----                                               
00DPHCSSL03          2     Up                                                  
00DPHCSSL04          1     Up                                                  
01DPHCSSL03          3     Up                                                  
01DPHCSSL04          4     Up  

'

'SQL_B_OS                   PR  Q                                     NodeAndDiskMajority'

$n2=Get-Clusternode '00DPHCSSC01'

$n2 |select  NodeName, NodeWeight


#----------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------





#-----------------------------------------
#    EstimatedEndTime
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

$Node2Name="SQL-X-2012"  
do
{ 
  clear-host
    Sleep 1
    Invoke-Sqlcmd $sql_mdfrestore  -ServerInstance $Node2Name  -QueryTimeout 14400

    Sleep 10
}
until ($x -gt 0)

#----------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------
dbcc sqlperf('logspace')
select name,physical_name,size * 0.000008 from sys.master_files
order by size desc
'  top 15
WSS_Logging 
User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05_log
WSS_Content_KMS
User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450_log
SharePoint_AdminContent_b4855f69-235b-4f74-a875-9aed893f1729_log
WSS_Content_MySite_log
SharePoint_Config_log
WSS_Content_EIP
User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450
WSS_Content_MySite
WSS_Content_SEARCH_log
Search_Service_Application_CrawlStoreDB_b12a4a3bf14c4d13b44050d5f4826aa2_log
SharePoint_Config
'

select name,physical_name,size * 0.000008 from sys.master_files
order by substring(physical_name,0,2) ,size desc 
' top 5
User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05_log	T:\UserDBLog\User Profile Service Application_ProfileDB_9e200ef6dc17436a8c579444f3b50f05_log.ldf	  40.572864
User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450_log	T:\UserDBLog\User Profile Service Application_SyncDB_a44ec3581a7541348412922d8d337450_log.ldf	20.971520
SharePoint_AdminContent_b4855f69-235b-4f74-a875-9aed893f1729_log	                    T:\UserDBLog\SharePoint_AdminContent_b4855f69-235b-4f74-a875-9aed893f1729_log.ldf	11.534336
WSS_Content_MySite_log	                                                                                                            T:\UserDBLog\WSS_Content_MySite_log.ldf	10.485760
SharePoint_Config_log                                                                                                                  	T:\UserDBLog\SharePoint_Config_log.ldf	8.499200    99.86238


#---------------------------------------------
#  5000  TSQL 
#---------------------------------------------

ping sqlassetdb   ;ipconfig /flushdns
cd c:\
eventvwr
ping spe1

dbcc sqlperf('logspace')
select name,physical_name,size * 0.000008 from sys.master_files   order by size desc
select name,physical_name,size * 0.000008 from sys.master_files   order by substring(physical_name,0,2) ,size desc 

ping eip.mvdis.gov.tw    ;ping  10.0.1.56




use DBName

alter database WinMasterVI  set recovery simple

DBCC SHRinkFile (WinMasterVI_log, 100000) --10G

alter database WinMasterVI  set recovery full
alter database SQL_Inventory  set recovery full



--use WinMasterVI
--exec sp_droppublication @publication=N'WinMasterVI'

--use WinMasterVI
--exec sp_removedbreplication'