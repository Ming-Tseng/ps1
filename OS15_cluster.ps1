<#---------------------- -------------
#  

C:\Users\administrator.CSD\SkyDrive\download\ps1\OS15_cluster.ps1
\\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\OS15_cluster.ps1
from  OS Cluster  C01_cluster
CreateDate: Oct.16.2013
LastDate : May.24.2014

I. install
II. Configure
III.Log
: APR.30.2014Author :Ming Tseng  ,a0921887912@gmail.com
Ping SQL2012X ;telnet SQL2012X 5023

telnet SQL2012X 5022


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS00_Index.ps1

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

#01      General command 
#02      Network check 
#03      Get  IP Address
#04  100 get/ Install WindowsFeature  &
#05      install #NET Framework 3.5 功能  
#06      SQL Server 2008 R2 叢集問題驗證失敗 
#07      check   Module  :  can see  FailoverClusters
#08      check   FailoverClusters command
#09      ClusterNode
#10      ClusterOwnerNode  
#11  250 ClusterGroup		
#12  300 ClusterResource  
#13  400 Disk   
#14  400 Get-ClusterAvailableDisk 
#15      Get-ClusterResourceDependency
#16  450 Get-ClusterParameter
#17  500 Get-ClusterNetwork
#18      ClusterAccess
#19  550 SQL Server Agent
#20  600 Get-ClusterLog   Create a log file for all nodes (or a specific a node) in a failover cluster.
#21  600 Get-ClusterLog
#22  600   function Start  SQL2012X   ClusSvc 
#23 700  force a cluster to start without a quorum
#24 750  GET path of File Share Witness
#25 750  Cluster Quorum 








#-----------------------------------
#01  General command 
#-----------------------------------
Cluadmin
eventvwr
get-process | gm
Get-Service  | ?{$_.Name  -like '*SQL*'}
Ncpa.cpl
ssms
taskmgr.exe
Wf.msc
Whoami
Ipconfig
Cliconfg
Dcomcnfg
firewall.cpl

Whoami

SQLServerManager11.msc
$hostname=$env:computerName
ping spm
ping spm.csd.syscom
ping spm.csd.syscom
   
#-----------------------------------
#02  Network check 
#-----------------------------------

Get-Service  | ?{$_.Name  -like '*SQL*'}
net start MSSQLSERVER

netstat -aon |more
dir  $env
hostname
ping sqlassetDB
ping spm2

#-----------------------------------
#03   Get  IP Address
#-----------------------------------
Get-DnsClientServerAddress 
Set-DnsClientServerAddress -InterfaceAlias '乙太網路 2' -ServerAddresses "10.1.21.152","10.1.21.151","10.0.21.152","10.0.21.151"
Set-DnsClientServerAddress -InterfaceAlias '乙太網路 2' -ServerAddresses "10.1.24.183","10.1.24.182","10.0.24.183","10.0.24.182"

Set-DnsClientServerAddress -InterfaceAlias 'NIC Teaming' -ServerAddresses "10.0.24.183","10.0.24.182","10.1.24.182","10.1.24.182"

#-----------------------------------
#04   100 get/ Install WindowsFeature  &
#-----------------------------------
Get-WindowsFeature | ? {$_.name -like 'TE*'}


Get-WindowsFeature Failover*
<#
Display Name                                            Name                       Install State
------------                                            ----                       -------------
[X] 容錯移轉叢集                                              Failover-Clustering            Installed
#>

Install-WindowsFeature -Name Failover-Clustering –IncludeManagementTools
Install-WindowsFeature -Name Telnet-Client 
#  Install-WindowsFeature RSAT-Clustering  
Install-WindowsFeature -Name Failover-Clustering –IncludeManagementTools
Install-WindowsFeature -Name WAS-NET-Environment  
Install-WindowsFeature -Name NET-Framework-Features   #NET Framework 3.5 功能  

Import-Module FailoverClusters

#-----------------------------------
#05  install #NET Framework 3.5 功能  
#-----------------------------------
 get-WindowsFeature net-framework-core 
 Install-WindowsFeature net-framework-core -source c:\software\SXS
 Install-WindowsFeature -Name NET-Framework-Features 

#------------------------------------------------------------------
#06 #SQL Server 2008 R2 叢集問題驗證失敗 
#------------------------------------------------------------------
 get-WindowsFeature RSAT-clustering-Automationserver

 Add-WindowsFeature RSAT-clustering-Automationserver

#------------------------------------------------------------------
#07 check   Module  :  can see  FailoverClusters
#------------------------------------------------------------------
Get-Module -ListAvailable 
get-module

Import-Module FailoverClusters  #-- if no command , import 

Get-Command -Module FailoverClusters  
<#

Get-Command -Module FailoverClusters  

CommandType     Name                                               ModuleName  
-----------     ----                                               ----------  
Alias           Add-VMToCluster                                    FailoverC...
Alias           Remove-VMFromCluster                               FailoverC...
Cmdlet          Add-ClusterCheckpoint                              FailoverC...
Cmdlet          Add-ClusterDisk                                    FailoverC...
Cmdlet          Add-ClusterFileServerRole                          FailoverC...
Cmdlet          Add-ClusterGenericApplicationRole                  FailoverC...
Cmdlet          Add-ClusterGenericScriptRole                       FailoverC...
Cmdlet          Add-ClusterGenericServiceRole                      FailoverC...
Cmdlet          Add-ClusterGroup                                   FailoverC...
Cmdlet          Add-ClusteriSCSITargetServerRole                   FailoverC...
Cmdlet          Add-ClusterNode                                    FailoverC...
Cmdlet          Add-ClusterPrintServerRole                         FailoverC...
Cmdlet          Add-ClusterResource                                FailoverC...
Cmdlet          Add-ClusterResourceDependency                      FailoverC...
Cmdlet          Add-ClusterResourceType                            FailoverC...
Cmdlet          Add-ClusterScaleOutFileServerRole                  FailoverC...
Cmdlet          Add-ClusterServerRole                              FailoverC...
Cmdlet          Add-ClusterSharedVolume                            FailoverC...
Cmdlet          Add-ClusterVirtualMachineRole                      FailoverC...
Cmdlet          Add-ClusterVMMonitoredItem                         FailoverC...
Cmdlet          Block-ClusterAccess                                FailoverC...
Cmdlet          Clear-ClusterDiskReservation                       FailoverC...
Cmdlet          Clear-ClusterNode                                  FailoverC...
Cmdlet          Get-Cluster                                        FailoverC...
Cmdlet          Get-ClusterAccess                                  FailoverC...
Cmdlet          Get-ClusterAvailableDisk                           FailoverC...
Cmdlet          Get-ClusterCheckpoint                              FailoverC...
Cmdlet          Get-ClusterGroup                                   FailoverC...
Cmdlet          Get-ClusterLog                                     FailoverC...
Cmdlet          Get-ClusterNetwork                                 FailoverC...
Cmdlet          Get-ClusterNetworkInterface                        FailoverC...
Cmdlet          Get-ClusterNode                                    FailoverC...
Cmdlet          Get-ClusterOwnerNode                               FailoverC...
Cmdlet          Get-ClusterParameter                               FailoverC...
Cmdlet          Get-ClusterQuorum                                  FailoverC...
Cmdlet          Get-ClusterResource                                FailoverC...
Cmdlet          Get-ClusterResourceDependency                      FailoverC...
Cmdlet          Get-ClusterResourceDependencyReport                FailoverC...
Cmdlet          Get-ClusterResourceType                            FailoverC...
Cmdlet          Get-ClusterSharedVolume                            FailoverC...
Cmdlet          Get-ClusterSharedVolumeState                       FailoverC...
Cmdlet          Get-ClusterVMMonitoredItem                         FailoverC...
Cmdlet          Grant-ClusterAccess                                FailoverC...
Cmdlet          Move-ClusterGroup                                  FailoverC...
Cmdlet          Move-ClusterResource                               FailoverC...
Cmdlet          Move-ClusterSharedVolume                           FailoverC...
Cmdlet          Move-ClusterVirtualMachineRole                     FailoverC...
Cmdlet          New-Cluster                                        FailoverC...
Cmdlet          Remove-Cluster                                     FailoverC...
Cmdlet          Remove-ClusterAccess                               FailoverC...
Cmdlet          Remove-ClusterCheckpoint                           FailoverC...
Cmdlet          Remove-ClusterGroup                                FailoverC...
Cmdlet          Remove-ClusterNode                                 FailoverC...
Cmdlet          Remove-ClusterResource                             FailoverC...
Cmdlet          Remove-ClusterResourceDependency                   FailoverC...
Cmdlet          Remove-ClusterResourceType                         FailoverC...
Cmdlet          Remove-ClusterSharedVolume                         FailoverC...
Cmdlet          Remove-ClusterVMMonitoredItem                      FailoverC...
Cmdlet          Repair-ClusterSharedVolume                         FailoverC...
Cmdlet          Reset-ClusterVMMonitoredState                      FailoverC...
Cmdlet          Resume-ClusterNode                                 FailoverC...
Cmdlet          Resume-ClusterResource                             FailoverC...
Cmdlet          Set-ClusterLog                                     FailoverC...
Cmdlet          Set-ClusterOwnerNode                               FailoverC...
Cmdlet          Set-ClusterParameter                               FailoverC...
Cmdlet          Set-ClusterQuorum                                  FailoverC...
Cmdlet          Set-ClusterResourceDependency                      FailoverC...
Cmdlet          Start-Cluster                                      FailoverC...
Cmdlet          Start-ClusterGroup                                 FailoverC...
Cmdlet          Start-ClusterNode                                  FailoverC...
Cmdlet          Start-ClusterResource                              FailoverC...
Cmdlet          Stop-Cluster                                       FailoverC...
Cmdlet          Stop-ClusterGroup                                  FailoverC...
Cmdlet          Stop-ClusterNode                                   FailoverC...
Cmdlet          Stop-ClusterResource                               FailoverC...
Cmdlet          Suspend-ClusterNode                                FailoverC...
Cmdlet          Suspend-ClusterResource                            FailoverC...
Cmdlet          Test-Cluster                                       FailoverC...
Cmdlet          Test-ClusterResourceFailure                        FailoverC...
Cmdlet          Update-ClusterIPResource                           FailoverC...
Cmdlet          Update-ClusterNetworkNameResource                  FailoverC...
Cmdlet          Update-ClusterVirtualMachineConfiguration          FailoverC...

#>
#----------------------------------------------------------------------------------------------------------------------------------------------
#08 check   FailoverClusters command
#----------------------------------------------------------------------------------------------------------------------------------------------

gsv -Name '*ClusSvc*'

##Get

Get-cluster |FL -Property *
<#
PS SQLSERVER:\> Get-cluster |FL -Property *


Domain                                  : csd.syscom
Name                                    : FC
AddEvictDelay                           : 60
AdministrativeAccessPoint               : ActiveDirectoryAndDns
BackupInProgress                        : 0
ClusSvcHangTimeout                      : 60
ClusSvcRegroupOpeningTimeout            : 5
ClusSvcRegroupPruningTimeout            : 5
ClusSvcRegroupStageTimeout              : 5
ClusSvcRegroupTickInMilliseconds        : 300
ClusterGroupWaitDelay                   : 120
MinimumNeverPreemptPriority             : 3000
MinimumPreemptorPriority                : 1
ClusterEnforcedAntiAffinity             : 0
ClusterLogLevel                         : 3
ClusterLogSize                          : 300
CrossSubnetDelay                        : 1000
CrossSubnetThreshold                    : 5
DefaultNetworkRole                      : 2
Description                             : 
FixQuorum                               : 0
WitnessDynamicWeight                    : 0
HangRecoveryAction                      : 3
IgnorePersistentStateOnStartup          : 0
LogResourceControls                     : 0
PlumbAllCrossSubnetRoutes               : 0
PreventQuorum                           : 0
QuorumArbitrationTimeMax                : 20
RequestReplyTimeout                     : 60
RootMemoryReserved                      : 4294967295
RouteHistoryLength                      : 10
SameSubnetDelay                         : 1000
SameSubnetThreshold                     : 5
SecurityLevel                           : 1
SharedVolumeCompatibleFilters           : {}
SharedVolumeIncompatibleFilters         : {}
SharedVolumesRoot                       : C:\ClusterStorage
SharedVolumeSecurityDescriptor          : {1, 0, 4, 128...}
ShutdownTimeoutInMinutes                : 20
DrainOnShutdown                         : 1
SharedVolumeVssWriterOperationTimeout   : 1800
NetftIPSecEnabled                       : 1
LowerQuorumPriorityNodeId               : 0
UseClientAccessNetworksForSharedVolumes : 0
BlockCacheSize                          : 0
WitnessDatabaseWriteTimeout             : 300
WitnessRestartInterval                  : 15
RecentEventsResetTime                   : 2015/8/21 上午 02:05:58
EnableSharedVolumes                     : 已啟用
DynamicQuorum                           : 1
CsvBalancer                             : 1
DatabaseReadWriteMode                   : 0
MessageBufferLength                     : 50
Id                                      : 4aa97485-0ce3-4d32-a23c-78ab7fb56889
PS SQLSERVER:\> 
#>
Get-cluster | select  Domain,name 

#  All  cluster on AD
#Get-cluster -Domain  system-ad.mvdis.gov.tw  
Get-cluster -Domain  mvdis.gov.tw  
Get-cluster -Domain  csd.syscom

##New

New-Cluster 
New-Cluster -Name FC -Node sql2012x.csd.syscom -StaticAddress 172.16.220.194 -NoStorage #step:01  ping  FC workable
<#
PS SQLSERVER:\> New-Cluster -Name FC -Node sql2012x.csd.syscom -StaticAddress 172.16.220.194 -NoStorage
報告檔案位置: C:\Windows\cluster\Reports\建立叢集精靈 FC on 2015.08.21 At 10.05.26.mht

Name                                                                                                                                                                     
----                                                                                                                                                                     
FC  
#>

Get-Cluster -Name FC2
Get-Cluster –Name FC | Add-ClusterNode –Name sp2013.csd.syscom #step:02
<#
報告檔案位置: C:\Windows\cluster\Reports\新增節點精靈 396ab93e-ac5d-4eb5-8653-eac2e5fac38a on 2015.08.21 At 10.13.09.mht
#>

gsv -ComputerName sql2012x  ClusSvc  #step:03
gsv -ComputerName sp2013    ClusSvc    #step:03
 2016BI:>Active Directory user and computer> csd.syscom > computers  > you can see  FC  

## set
##


##start
 Start-Cluster –Name node2

##Remove

Get-Cluster FC2 | Remove-Cluster -Force -CleanupAD
ping FC2.csd.syscom

#--------------------------------------------
#09     ClusterNode
#--------------------------------------------

##Get
Get-ClusterNode

##New
add-clusterNode -Name  00DPHCSSL01.mvdis.gov.tw 
#add-clusterNode -Name  00DPHCSSL01.mvdis.gov.tw  
#add-clusterNode -Name  00DPHCSSL02mvdis.gov.tw  

## set

ping 172.16.220.161

##Remove
#remove-clusterNode -Name  01DPHCSSL04.system-ad.mvdis.gov.tw -Force


#Get-clusterNode -name 00DPHCSSL03 | Remove-ClusterNode -force

Clear-ClusterNode 01DPHCSSL03.system-ad.mvdis.gov.tw    -Force  # run @  01DPHCSSL03
Clear-ClusterNode 01DPHCSSL04.system-ad.mvdis.gov.tw    -Force

Clear-ClusterNode SP2013.csd.syscom     -Force  # run @  01DPHCSSL03
Clear-ClusterNode SP2013WFE.csd.syscom  -Force 
Clear-ClusterNode SQL2012X.csd.syscom   -Force 

remove-clusterNode -Name  SP2013.csd.syscom -Force
remove-clusterNode -Name  SP2013WFE.csd.syscom -Force
remove-clusterNode -Name  SQL2012X.csd.syscom -Force


#--------------------------------------------
#10   ClusterOwnerNode  
#--------------------------------------------
##Get

Get-ClusterGroup    –Group cluster1FS12  | Get-ClusterOwnerNode  # lists the preferred owners for the clustered file server, or resource group, called cluster1FS12 on the local cluster

Get-ClusterResource  |  Get-ClusterOwnerNode 

Get-ClusterResource  -Name 'DR M 10' | Get-ClusterOwnerNode  # lists the possible owners for the cluster named

##New



## set

##sets the possible owner   # 00DPHCSSC01    ,00DPHCSSC02    ,     01DPHCSSC01      ,01DPHCSSC02
Get-ClusterResource  -Name 'DR-M-10G'  |  Set-ClusterOwnerNode  -Owner  01DPHCSSC01,01DPHCSSC02
Get-ClusterResource  -Name 'PR-Q-10'

##Set   Preferred owners
Set-ClusterOwnerNode -Group  xxxx    -Owners  Node3,Node2

##Remove
Get-ClusterResource  -Name ' Name'
Remove-ClusterResource "Cluster Name" -force

#--------------------------------------------
#11  250   ClusterGroup		
#--------------------------------------------

##Get
Get-Clustergroup   |  FL 
<#
Name      : 可用存放裝置
OwnerNode : SQL2012X
State     : Offline

Name      : 叢集群組
OwnerNode : SQL2012X
State     : Online
#>
Get-Clustergroup   |  select *
$SQLSrv=Get-clustergroup -Name  'SQL Server (MSSQLSERVER)'
$SQLSrv.Cluster
$SQLSrv.OwnerNode

Get-ClusterGroup -Name 'SQL Server (M)'  |Get-clusterResource

'
SQL Server (M)                            00DPHCSSC01                Online                   
SQL Server (MSSQLSERVER)   00DPHCSSC01                Online                   
SQL Server (SPC)                        00DPHCSSC02                Online                   
SQL Server (SQLX)                     00DPHCSSC01                Offline                  
SQL_E_MSDTC                            00DPHCSSC01                Online                   
SQL_X_MSDTC                00DPHCSSC01                Offline                  
T7                         00DPHCSSC01                Online                   
可用存放裝置                     00DPHCSSC02                PartialOnline            
叢集群組                       00DPHCSSC01                Online    
'
Get-ClusterGroup  -Name 'SQL Server (MSSQLSERVER)'
Get-ClusterGroup  -Name 'SQL Server (SQLX)'
Get-ClusterGroup  -Name 'SQL_X_MSDTC'
##New

## set

Moves a clustered role (a resource group) from one node to another in a failover cluster.
Get-ClusterNode
Move-ClusterGroup –Name SPMAG -Node SQL2012X  #moves the resource group called MyFileServer from the current owner node to the node named node2.

Get-ClusterNode node3 | Get-ClusterGroup | Move-ClusterGroup  #moves all resource groups that are currently owned by the node named node3 to other nodes.
Move-clusterGroup  -name  'SQL_B_MSDTC' -node '01DPHCSSL03' 
Move-ClusterGroup –Name MyFileServer -Node node2 -Wait 0   #immediately

#Set  ClusterGroup   rename
Get-ClusterGroup temp1 | fl Name,Id
( Get-ClusterGroup -name xxxx).Name = "temp2"
$group = Get-ClusterGroup  xxxx
$group.Name = "temp2"
 


##Remove

#--------------------------------------------
#12  300  ClusterResource  
#--------------------------------------------
##Get
Get-ClusterResource |select *
Get-ClusterResource -name 叢集名稱  | select *
Get-ClusterResource   |select ownergroup  |FL
Get-ClusterResource -name "DR Y 100"       | select *
Get-ClusterResource | ? {$_.name -like  'file*'}  |fl

Get-ClusterResource -name 'File Server (\\SQL-B-2012)'  | select *
 Get-ClusterResource -name "DR Y 100"       | select *
#Tip  re-install SQL Cluster failure
Get-ClusterResource 
Get-ClusterResource  -Name 'SQL Network Name (SQL-B-2012)'  |fl

Get-ClusterResource  |  Get-ClusterOwnerNode 
Get-ClusterResource  |  Get-ClusterOwnerNode -Group 'SQL Server (PRB)'
Get-ClusterResource | ? {$_.name -like  'file*'}  | fl
Get-ClusterResource    | select   name,OwnerNode,OwnerGroup  |fT -AutoSize
  Get-ClusterResource  -Name 'DR M 10'   | select   name,OwnerNode,OwnerGroup
Get-ClusterGroup -Name  'SQL Server (PRB)'  | Get-ClusterResourc

get-clusterGroup -name  'SPMAG' | Get-ClusterResource  
'
PS C:\Users\administrator.CSD> get-clusterGroup -name  'SPMAG' | Get-ClusterResource

Name                              State                             OwnerGroup                       ResourceType                    
----                              -----                             ----------                       ------------                    
SPMAG                             Online                            SPMAG                            SQL Server Availability Group   
SPMAG_172.16.220.161              Online                            SPMAG                            IP Address                      
SPMAG_FSShare                     Online                            SPMAG                            SQL Server FILESTREAM Share     
SPMAG_SPM                         Online                            SPMAG                            Network Name  
'

Get-ClusterResource |select Name,resourcetype  # ResourceType=Network Name
Get-ClusterResource "SPMAG_SPM" | Get-ClusterParameter
Get-ClusterResource "SPMAG_SPM" |set-ClusterParameter RegisterAllProvidersIP  0
Get-ClusterResource "SPMAG_SPM" |Set-ClusterParameter HostRecordTTL 300
Stop-ClusterResource "SPMAG_SPM
"Start-ClusterResource yourListenerName

' Get-ClusterResource "SPMAG_SPM" | Get-ClusterParameter

Object                          Name                            Value                          Type                          
------                          ----                            -----                          ----                          
SPMAG_SPM                       Name                            SPM                            String                        
SPMAG_SPM                       DnsName                         SPM                            String                        
SPMAG_SPM                       Aliases                                                        String                        
SPMAG_SPM                       RemapPipeNames                  1                              UInt32                        
SPMAG_SPM                       HostRecordTTL                   1200                           UInt32                        
SPMAG_SPM                       RegisterAllProvidersIP          1                              UInt32                        
SPMAG_SPM                       PublishPTRRecords               0                              UInt32                        
SPMAG_SPM                       ResourceData                    {1, 0, 0, 0...}                ByteArray                     
SPMAG_SPM                       StatusNetBIOS                   0                              UInt32                        
SPMAG_SPM                       StatusDNS                       9002                           UInt32                        
SPMAG_SPM                       StatusKerberos                  0                              UInt32                        
SPMAG_SPM                       CreatingDC                      \\2013BI.CSD.syscom            String                        
SPMAG_SPM                       LastDNSUpdateTime               12/29/2013 9:11:38 AM          DateTime                      
SPMAG_SPM                       ObjectGUID                      56f49f1d808aae4bbd896952c2f... String                        
SPMAG_SPM                       DnsSuffix                       CSD.syscom    
'
http://technet.microsoft.com/zh-tw/library/cc280386.aspx

##New

## set    

#Set  ClusterResource  rename
Get-ClusterGroup    xxxx   | Get-ClusterResource
Get-ClusterResource   oldname  |  %  { $_.Name = "newname" }  # rename
Get-ClusterGroup    xxxx   | Get-ClusterResource

 
##Remove
#Get-ClusterResource  -Name 'File Server (\\SQL-B-2012)' | Remove-ClusterResource -Force
#Get-ClusterResource  -Name 'SQL Network Name (SQL-B-2012)'   | Remove-ClusterResource -Force
#Get-ClusterResource  -Name 'SQL Network Name (SQL-B-2012)'   | Remove-ClusterResource -Force 

#--------------------------------------------
#13  400 Disk   
#-------------------------------------------- 
##Get

Get-Disk –Number 11 | Add-Clusterdisk  #adds a physical disk to the Available Storage for the cluster

##New
Get-ClusterAvailableDisk | Add-ClusterDisk  #adds all disks that are ready to be added to the local cluster


## set
Import-Module FailoverClusters 
 
foreach ($diskrsrc in Get-ClusterResource | where-object {$_.ResourceType -ilike "Physical Disk"}) { 
    get-clusterresource $diskrsrc.Name | get-clusterparameter | ?{$_.Name -eq "DiskSignature"} | %{$diski += @{[Convert]::ToUInt32($_.Value, 16) = $diskrsrc.Name}} 
} 
 
foreach ($rec in $diski.GetEnumerator()) { 
    $WMIdisk = gwmi -Namespace root/MSCluster -Query "Select * From MSCluster_Disk Where ID=$($rec.Name)" 
    gwmi -Namespace root/MSCluster -Query "ASSOCIATORS OF {$WMIdisk} Where ResultClass=MSCluster_DiskPartition" | %{$Label = $_.VolumeLabel; Get-ClusterResource $($rec.Value) | %{$_.Name = $Label}} 
}

Pasted from <http://gallery.technet.microsoft.com/scriptcenter/Rename-Cluster-Disk-8021c99e/description> 



##Remove

#--------------------------------------------
#14  400 Get-ClusterAvailableDisk 
#-------------------------------------------- 

##當DR Disk 加入Cluster 會因為 Available Storage(可用存放裝置) Owner 分卻在 PR site某個node  ,因此會造成 DR Disk無法上線.

Get-clusterGroup  -Name '可用存放裝置'  # first view
Move-clusterGroup -name '可用存放裝置'   -node  'N4Hostname'
Get-clusterGroup  -Name '可用存放裝置'  # confirm 可用存放裝置 是否已在DR ' Hostname
Get-Disk #  Get  Disk on this machine
Get-Disk -number  XX  | add-clusterDisk  # 將OS' Disk 加入 Cluster'Disk
#Rename Cluster'Disk (ex DRM10G)
Get-ClusterResource  -Name '' | setClusterOwnerNode - Owner  N3, N4


#--------------------------------------------
#15  Get-ClusterResourceDependency
#-------------------------------------------- 
##Get
Get-ClusterResource 
Get-ClusterResourceDependency -Resource  'SQL Network Name (SQL-B-2012)'  #isplays the dependencies for the resource
Get-ClusterResourceDependency -Resource  'MSDTC-SQL_B_MSDTC'
Get-ClusterResourceDependency -Resource 'SQL_B_MSDTC'
Get-ClusterResourceDependency -Resource  'Cluster Disk 3'   
Get-ClusterResourceDependency -Resource  '叢集 IP 位址'
Get-ClusterResourceDependency -Resource  'SQL Server' |fl


Get-ClusterGroup –Name cluster1FS12 | Get-ClusterResource | Get-ClusterResourceDependency

##New
## set
 Set-ClusterResourceDependency –Resource cluster1FS12 -Dependency "[IP Address 151.56.48.0]"
Set-ClusterResourceDependency –Resource cluster1FS12 –Dependency "[IP Address 151.56.48.0] or [New IP Address]"
Set-ClusterResourceDependency –Resource cluster1FS12 –Dependency "" #clears the dependency list for the resource named cluster1FS12
##Remove


#--------------------------------------------
#16  450  Get-ClusterParameter
#--------------------------------------------
##Get

Get-ClusterResource "Cluster Name" | Get-ClusterParameter

Pasted from <http://blogs.msdn.com/b/clustering/archive/2009/09/23/9898289.aspx> 
'
PS C:\Users\administrator.CSD> Get-clusterGroup -Name 'Cluster Group'  |Get-ClusterResource

Name                              State                             OwnerGroup                       ResourceType                    
----                              -----                             ----------                       ------------                    
Cluster IP Address                Online                            Cluster Group                    IP Address                      
Cluster Name                      Online                            Cluster Group                    Network Name                    
'


PS C:\Users\administrator.CSD> Get-ClusterResource -Name 'Cluster Name'  | Get-ClusterParameter
'
Object                                 Name                              Value                            Type                            
------                                     ----                              -----                            ----                            
Cluster Name                      Name                              FC2                              String                          
Cluster Name                      DnsName                           FC2                              String                          
Cluster Name                      Aliases                                                            String                          
Cluster Name                      RemapPipeNames                    0                                UInt32                          
Cluster Name                      HostRecordTTL                     1200                             UInt32                          
Cluster Name                      RegisterAllProvidersIP            0                                UInt32                          
Cluster Name                      PublishPTRRecords                 0                                UInt32                          
Cluster Name                      ResourceData                      {1, 0, 0, 0...}                  ByteArray                       
Cluster Name                      StatusNetBIOS                     0                                UInt32                          
Cluster Name                      StatusDNS                         0                                UInt32                          
Cluster Name                      StatusKerberos                    0                                UInt32                          
Cluster Name                      CreatingDC                        \\2013BI.CSD.syscom              String                          
Cluster Name                      LastDNSUpdateTime                 11/26/2013 11:43:14 AM           DateTime                        
Cluster Name                      ObjectGUID                        b194d1ad56107d409ae2f8a93a5895e0 String                          
Cluster Name                      DnsSuffix                         CSD.syscom                       String                          
'


((Get-ClusterResource -Name 'Cluster IP Address'  | Get-ClusterParameter) | ? {$_.name -eq 'address'}).value


(Get-ClusterResource -Name 'Cluster IP Address'  | Get-ClusterParameter) 
'
Object                            Name                              Value                            Type                            
------                            ----                              -----                            ----                            
Cluster IP Address                Network                           叢集網路 2                           String                          
Cluster IP Address                Address                           172.16.220.216                   String                          
Cluster IP Address                SubnetMask                        255.255.255.0                    String                          
Cluster IP Address                EnableNetBIOS                     2                                UInt32                          
Cluster IP Address                OverrideAddressMatch              0                                UInt32                          
Cluster IP Address                EnableDhcp                        0                                UInt32                          
Cluster IP Address                ProbePort                         0                                UInt32                          
Cluster IP Address                ProbeFailureThreshold             0                                UInt32                          
Cluster IP Address                LeaseObtainedTime                 1/1/0001 12:00:00 AM             DateTime                        
Cluster IP Address                LeaseExpiresTime                  1/1/0001 12:00:00 AM             DateTime                        
Cluster IP Address                DhcpServer                        255.255.255.255                  String                          
Cluster IP Address                DhcpAddress                       0.0.0.0                          String                          
Cluster IP Address                DhcpSubnetMask                    255.0.0.0                        String  
'
##New
## set
##Remove

Get-ClusterResource -name 'MSDTC-SQL_B_MSDTC' |Get-ClusterParameter
Get-ClusterResource -name 'SQL_B_MSDTC' |Get-ClusterParameter
Get-ClusterResource -name '叢集 IP 位址' |Get-ClusterParameter
Get-ClusterResource -name 'SQL Server' |Get-ClusterParameter



#--------------------------------------------
#17  500 Get-ClusterNetwork
#--------------------------------------------

##Get
get-ClusterNetwork |select name,Address,state
'
Name                                         Address                                                                            State
----                                         -------                                                                            -----
叢集網路 1                                       192.168.111.0                                                                         Up
叢集網路 2                                       172.16.220.0                                                                          Up
## set  rename
Get-ClusterNetwork |select name,Address,state
(Get-ClusterNetwork | ? {$_.Address -eq "172.16.220.0"}).Name = "ClusterNetworkNewName"
'



#--------------------------------------------
#18   ClusterAccess
#--------------------------------------------

PS C:\Users\administrator.CSD> Get-ClusterAccess
'
IdentityReference                                                       AccessControlType                               ClusterRights
-----------------                                                       -----------------                               -------------
NT AUTHORITY\SYSTEM                                                                 Allow                                        Full
NT AUTHORITY\NETWORK SERVICE                                                        Allow                                        Full
BUILTIN\Administrators                                                              Allow                                        Full
S-1-5-21-3682455631-3363767133-2726721345...                                        Allow                                        Full
SP2013\SQLServerHADRUser$MSSQLSERVER                                                Allow                                        Full
NT SERVICE\MSDTC 
'

#--------------------------------------------
#19 550 SQL Server Agent
#--------------------------------------------
1 - Add the SQL agent 'resource type'.
cluster restype "SQL Server Agent" /create /DLL:sqagtres.dll
Pasted from <http://social.msdn.microsoft.com/Forums/sqlserver/en-US/85aef7a9-4c54-4ae6-b855-ff9eebb1ff23/cluster-adding-node-with-service-accounts-name-empty?forum=sqlsetupandupgrade> 

2Add the SQL agent resource ..
.       In the Failover Cluster Management use Add Resource to add the SQL Server Agent resource.
Name the resource as “SQL Server Agent”, as this is case sensitive unless you are on CU3 or above for SQL Server 2008 RTM.

a.       Right-click on the SQL Agent resource and go to Properties and fill in values for the two parameters.
b.      Specify the Virtual Server name of the SQL instance. 
c.       Specify the Instance name.
d.      Add the SQL Server Resource as a dependency for the newly created SQL Server Agent resource
3.       Open Registry Editor and browse to the following location.

Pasted from <http://social.msdn.microsoft.com/Forums/sqlserver/en-US/85aef7a9-4c54-4ae6-b855-ff9eebb1ff23/cluster-adding-node-with-service-accounts-name-empty?forum=sqlsetupandupgrade> 


#--------------------------------------------
#20  600 Get-ClusterLog   Create a log file for all nodes (or a specific a node) in a failover cluster.
#--------------------------------------------
<#
  delete C:\Windows\Cluster\Reports
Get-ClusterLog [  Creates a log file for all nodes, or a specific a node, in a failover cluster
[-Node] <StringCollection> ] Specifies the name of the cluster node for which to generate the cluster log
[-Cluster <String> ] 
[-Destination <String> ]   Specifies the location to which to copy one or more cluster logs. To copy to the current folder, use . for this parameter input.
[-InputObject <PSObject> ] Specifies the cluster from which to generate cluster logs.
[-TimeSpan <UInt32> ]  Specifies the time span for which to generate the cluster log.
[-UseLocalTime] [ <CommonParameters>]  Specifies that the time stamp for each cluster log entry uses local time. By default, the timestamp uses Greenwich Mean Time (GMT).
#>
get-date
Get-ClusterLog -TimeSpan 5 -UseLocalTime -Destination d:\temp\  #creates a log file for the local cluster in the cluster reports folder on each node of the cluster. The log covers the last 3 minutes
get-date


Get-ClusterLog -Destination . -Node sp2013


## set-clusterlog
Set-ClusterLog 
[-Cluster <String> ] #Specifies the name of the cluster on which to run this cmdlet. If the input for this parameter is . or it is omitted, then the cmdlet runs on the local cluste
[-InputObject <PSObject> ] #Specifies the cluster from which to generate cluster logs
[-Level <Int32> ] #Specifies the log level to set for the cluster. The acceptable values for this parameter are: 0 to 5.
[-Size <Int32> ] #Specifies the log size to set for the cluster. The acceptable values for this parameter are: 8 MB to 1024 MB.
[ <CommonParameters>]


#--------------------------------------------
#21 600 Get-ClusterLog
#--------------------------------------------
Get-ClusterQuorum


#--------------------------------------------
#22 600   function Start  SQL2012X   ClusSvc 
#--------------------------------------------
ALTER AVAILABILITY GROUP [SPMAG] FAILOVER;


$sql="select Primary_replica,primary_recovery_health_desc,synchronization_health_desc 
from sys.dm_hadr_availability_group_states
"




function alterAGto ($param1)
{
$t1=get-date
Invoke-Sqlcmd  -ServerInstance $param1  -Query "ALTER AVAILABILITY GROUP [SPMAG] FAILOVER;"  
$t2=get-date
  ($t2-$t1).TotalSeconds
}


alterAGto  sp2013wfe


do
{
    get-date
    Invoke-Sqlcmd  -ServerInstance spm  -Query $sql
    sleep 3
}
until ($x -gt 0)

gsv "
"
Get-Clusternode

#---------------------
function StartSQL2012XClusSvc 
{
  icm -ComputerName  SQL2012X {(gsv "ClusSvc").Start()}  
}

function StartSP2013ClusSvc 
{
  icm   SP2013 {(gsv "ClusSvc").Start()}  
}

function StartSP2013wfeClusSvc 
{
  icm   SP2013wfe {(gsv "ClusSvc").Start()}  
}
#---------------------

function StopSQL2012XClusSvc 
{
  icm -ComputerName  SQL2012X {(gsv "ClusSvc").stop()}  
}

function StopSP2013ClusSvc 
{
  icm -ComputerName  SP2013 {(gsv "ClusSvc").stop()}  
}

function StopSP2013wfeClusSvc 
{
  icm -ComputerName  SP2013wfe {(gsv "ClusSvc").stop()}  
}

#---------------------
function GetSP2013wfeClusSvc 
{
  $return=icm -ComputerName  SP2013wfe {(gsv "ClusSvc").Status}  
  $return.PSComputerName +"--ClusSvc--"+$return.value
}

function GetSP2013ClusSvc 
{
  $return=icm -ComputerName  SP2013 {(gsv "ClusSvc").Status}  
  $return.PSComputerName +"  --ClusSvc--"+$return.value
}

function GetSQL2012XClusSvc 
{
  $return=icm -ComputerName  SQL2012X {(gsv "ClusSvc").Status}  
  $return.PSComputerName +"--ClusSvc--"+$return.value
}




StartSQL2012XClusSvc

StopSQL2012XClusSvc

GetSQL2012XClusSvc;GetSP2013ClusSvc;GetSP2013wfeClusSvc


StartSP2013ClusSvc
StopSP2013ClusSvc



StopSP2013wfeClusSvc
StartSP2013wfeClusSvc

#--------------------------------------------
#23 700  force a cluster to start without a quorum
#--------------------------------------------
Import-Module FailoverClusters
$node = "AlwaysOnSrv02"
Stop-ClusterNode –Name $node
Start-ClusterNode –Name $node -FixQuorum
(Get-ClusterNode $node).NodeWeight = 1
$nodes = Get-ClusterNode -Cluster $node
$nodes | Format-Table -property NodeName, State, NodeWeight



#--------------------------------------------
# 24 750 GET path of File Share Witness
#--------------------------------------------
 Get-ClusterResource "File Share Witness" -Cluster FC2   |   Get-ClusterParameter |select *
 '
 ClusterObject : File Share Witness
Name          : SharePath
IsReadOnly    : False
ParameterType : String
Value         : \\SP2013WFE\quorum

 '



#--------------------------------------------
# 25 750 Cluster Quorum 
#--------------------------------------------

Set-ClusterQuorum 
[-InputObject <psobject>] 
[-Cluster <string>] 
[-DiskOnly <string>] 
[-NodeAndDiskMajority <string>] 
[-NodeAndFileShareMajority <string>] 
[-NodeMajority] [<CommonParameters>]

