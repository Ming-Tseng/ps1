<#

Subject :Tpex SQL alwayson for Moniter System 
CreateDate: Sep.16.2015
filepath :  \\172.18.65.184\c$\PS1\.ps1
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\ex06_TPEx.ps1
history : 
. initial  #01 ~ #21

#>



#01  69   General command 常用指令
#02  99   SQL check  SQL 服務檢查
#03  110  Get  IP Address  網路檢查
#04  137  get/ Install WindowsFeature  安裝windows功能
#05  176  install #NET Framework 3.5 安裝NET Framework 3.5  功能  
#06  183  check   Module  :  can see  FailoverClusters 開啟 powershell for FailoverClusters 功能  
#07  278  New  FailoverClusters command   佈建 容錯移轉叢集  服務 名稱
#08  254  ClusterNode   檢查節點
#09  394  ClusterOwnerNode   檢查擁有者節點
#10  429  Disk  檢查磁碟
#11  461  Get-ClusterNetwork  檢查叢集網路
#12  481  Get-ClusterLog   檢查叢集記錄
#13  573  安裝 Net 4.5
#14  520  enable firewall 檢查防火牆
#15  532  mkdir  & sharefolder  建立資料夾及分享資料夾
#16  550  建立 SQL 安裝  ConfigurationFile.ini
#17  585  啟動 alwayson 功能
#18  599  import-module sqlps   匯入  oowershell for SQL
#19  612  create database for sample  建立測試Database 及 備份
#20  640  設定 alwayson 服務
#21  929  建立 AG listener

#22   add 3rd quonan

#-----------------------------------
#01  69  General command 常用指令
#-----------------------------------
{<#
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
services.msc

$newname = "PMD2016" 
Rename-Computer -NewName $newname -force shutdown -r -fhostnamewf.mscfirewall.cpl #enable wf.msc all or sharing file and printer (SMB-In)  445remote desktop :port 3389ncpa.cplsysteminfo |out-file  c:\temp\systeminfo.txt -Force ; ii c:\temp\systeminfo.txt

Whoami

SQLServerManager12.msc
$hostname=$env:computerName

ping bq-mondb01
ping bq-mondb02

ping bq-monap01
ping bq-monap02

ping 172.18.65.181
ping 172.18.65.182


ping tc-mondb01

ping bq-mondb01.ad.gretai.gov.tw
   
  install :  ad\infoadmin
  sql service :  MonSql

  No Item Hostname Public IP Heartbeat IP
1 Banqia AP主機01(VM) BQ-MonAP01 172.18.65.181 
2 Banqia AP主機02(VM) BQ-MonAP02 172.18.65.182 
3 *DBListener 
4 Banqia DB
5 Banqia DB
6 *Cluster  7 Taichung AP主機01(VM) 
TC-MonAP01 172.19.65.181 8 
Taichung DB主機01(VM) TC-MonDB01 172.19.65.184 192.168.65.186

172.19.65.183

主機01 BQ-MonDB01 172.18.65.184 192.168.65.184
主機02 BQ-MonDB02 172.18.65.185 192.168.65.185





whoami    #ad\infoadm
hostname  BQ-MONDB01

Rename-Computer -ComputerName BQ-MON-DB01 -NewName  BQ-MONDB01


shutdown -r -f
ipconfig  192.168.65.184

$env:USERDNSDOMAIN  #AD.GRETAI.ORG.TW

$SQLSource ='C:\software\SQL2014_ENT_TW_X64'

#>}
#-----------------------------------
#02  99  SQL check  SQL 服務檢查
#-----------------------------------

Get-Service  | ?{$_.Name  -like '*SQL*'} #'null'

net start MSSQLSERVER

netstat -aon |more
dir  $env

#-----------------------------------
#03  110  Get  IP Address  網路檢查
#-----------------------------------
Get-DnsClientServerAddress  |ft -AutoSize
'
PS C:\Windows\system32> Get-DnsClientServerAddress  |ft -AutoSize

InterfaceAlias                                InterfaceIndex AddressFamily ServerAddresses                                       
--------------                                -------------- ------------- ---------------                                       
LAN2 _Heartbeat                                           14 IPv4          {}                                                    
LAN2 _Heartbeat                                           14 IPv6          {}                                                    
isatap.{39DA359A-0B74-4FAA-840B-91630D55F7FE}             16 IPv4          {}                                                    
isatap.{39DA359A-0B74-4FAA-840B-91630D55F7FE}             16 IPv6          {}                                                    
LAN1_Public                                               12 IPv4          {172.18.8.1, 172.18.8.2}                              
LAN1_Public                                               12 IPv6          {}                                                    
isatap.{CC3C4B75-C411-4BE0-9667-BD0D96B0E6B2}             17 IPv4          {172.18.8.1, 172.18.8.2}                              
isatap.{CC3C4B75-C411-4BE0-9667-BD0D96B0E6B2}             17 IPv6          {}                                                    
Loopback Pseudo-Interface 1                                1 IPv4          {}                                                    
Loopback Pseudo-Interface 1                                1 IPv6          {fec0:0:0:ffff::1, fec0:0:0:ffff::2, fec0:0:0:ffff::3}
'


#Set-DnsClientServerAddress -InterfaceAlias '乙太網路 2' -ServerAddresses "10.1.21.152","10.1.21.151","10.0.21.152","10.0.21.151"
#Set-DnsClientServerAddress -InterfaceAlias '乙太網路 2' -ServerAddresses "10.1.24.183","10.1.24.182","10.0.24.183","10.0.24.182"

#Set-DnsClientServerAddress -InterfaceAlias 'NIC Teaming' -ServerAddresses "10.0.24.183","10.0.24.182","10.1.24.182","10.1.24.182"

#-----------------------------------
#04   137  get/ Install WindowsFeature  安裝windows功能
#-----------------------------------
Get-WindowsFeature | ? {$_.name -like 'TE*'}


Get-WindowsFeature Failover*
<#
PS C:\Windows\system32> Get-WindowsFeature Failover*

Display Name                                            Name                       Install State
------------                                            ----                       -------------
[ ] 容錯移轉叢集                                              Failover-Clustering            Available

#>

Install-WindowsFeature -Name Failover-Clustering –IncludeManagementTools



Install-WindowsFeature -Name Telnet-Client 

#  Install-WindowsFeature RSAT-Clustering  

Get-WindowsFeature Failover*
'PS C:\Windows\system32> Get-WindowsFeature Failover*

Display Name                                            Name                       Install State
------------                                            ----                       -------------
[X] 容錯移轉叢集                                              Failover-Clustering            Installed
'


Install-WindowsFeature -Name Failover-Clustering –IncludeManagementTools

Install-WindowsFeature -Name WAS-NET-Environment  

Import-Module FailoverClusters

#-----------------------------------
#05  176  install #NET Framework 3.5 安裝NET Framework 3.5  功能  
#-----------------------------------
 Get-WindowsFeature net-framework-core 
 Install-WindowsFeature net-framework-core -source c:\software\SXS  
 Install-WindowsFeature -Name NET-Framework-Features 

#------------------------------------------------------------------
#06  183  check   Module  :  can see  FailoverClusters 開啟 powershell for FailoverClusters 功能  
#------------------------------------------------------------------
Get-Module -ListAvailable 

get-module
'PS C:\Windows\system32>  Get-Module -ListAvailable 


    目錄: C:\Windows\system32\WindowsPowerShell\v1.0\Modules


ModuleType Version    Name                                ExportedCommands                                                                           
---------- -------    ----                                ----------------                                                                           
Manifest   2.0.0.0    AppLocker                           {Get-AppLockerFileInformation, Get-AppLockerPolicy, New-AppLockerPolicy, Set-AppLockerPo...
Manifest   2.0.0.0    Appx                                {Add-AppxPackage, Get-AppxPackage, Get-AppxPackageManifest, Remove-AppxPackage...}         
Manifest   1.0        BestPractices                       {Get-BpaModel, Get-BpaResult, Invoke-BpaModel, Set-BpaResult}                              
Manifest   1.0.0.0    BitsTransfer                        {Add-BitsFile, Complete-BitsTransfer, Get-BitsTransfer, Remove-BitsTransfer...}            
Manifest   1.0.0.0    BranchCache                         {Add-BCDataCacheExtension, Clear-BCCache, Disable-BC, Disable-BCDowngrading...}            
Manifest   1.0.0.0    CimCmdlets                          {Get-CimAssociatedInstance, Get-CimClass, Get-CimInstance, Get-CimSession...}              
Binary     2.0.0.0    ClusterAwareUpdating                {Get-CauPlugin, Register-CauPlugin, Unregister-CauPlugin, Invoke-CauScan...}               
Manifest   1.0.0.0    DirectAccessClientComponents        {Disable-DAManualEntryPointSelection, Enable-DAManualEntryPointSelection, Get-DAClientEx...
Script     2.0        Dism                                {Add-AppxProvisionedPackage, Add-WindowsDriver, Add-WindowsImage, Add-WindowsPackage...}   
Manifest   1.0.0.0    DnsClient                           {Resolve-DnsName, Clear-DnsClientCache, Get-DnsClient, Get-DnsClientCache...}              
Manifest   2.0.0.0    FailoverClusters                    {Add-ClusterCheckpoint, Add-ClusterDisk, Add-ClusterFileServerRole, Add-ClusterGenericAp...
Manifest   2.0.0.0    International                       {Get-WinDefaultInputMethodOverride, Set-WinDefaultInputMethodOverride, Get-WinHomeLocati...
Manifest   1.0.0.0    iSCSI                               {Get-IscsiTargetPortal, New-IscsiTargetPortal, Remove-IscsiTargetPortal, Update-IscsiTar...
Manifest   2.0.0.0    IscsiTarget                         {Add-ClusteriSCSITargetServerRole, Add-IscsiVirtualDiskTargetMapping, Checkpoint-IscsiVi...
Script     1.0.0.0    ISE                                 {New-IseSnippet, Import-IseSnippet, Get-IseSnippet}                                        
Manifest   1.0.0.0    Kds                                 {Add-KdsRootKey, Get-KdsRootKey, Test-KdsRootKey, Set-KdsConfiguration...}                 
Manifest   3.0.0.0    Microsoft.PowerShell.Diagnostics    {Get-WinEvent, Get-Counter, Import-Counter, Export-Counter...}                             
Manifest   3.0.0.0    Microsoft.PowerShell.Host           {Start-Transcript, Stop-Transcript}                                                        
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Content, Clear-Content, Clear-ItemProperty, Join-Path...}                             
Manifest   3.0.0.0    Microsoft.PowerShell.Security       {Get-Acl, Set-Acl, Get-PfxCertificate, Get-Credential...}                                  
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Format-List, Format-Custom, Format-Table, Format-Wide...}                                 
Manifest   3.0.0.0    Microsoft.WSMan.Management          {Disable-WSManCredSSP, Enable-WSManCredSSP, Get-WSManCredSSP, Set-WSManQuickConfig...}     
Manifest   1.0        MMAgent                             {Disable-MMAgent, Enable-MMAgent, Set-MMAgent, Get-MMAgent...}                             
Manifest   1.0.0.0    MPIO                                {Get-MPIOAvailableHW, New-MSDSMSupportedHW, Clear-MSDSMSupportedHW, Get-MSDSMSupportedHW...
Manifest   1.0.0.0    MsDtc                               {New-DtcDiagnosticTransaction, Complete-DtcDiagnosticTransaction, Join-DtcDiagnosticReso...
Manifest   2.0.0.0    NetAdapter                          {Disable-NetAdapter, Disable-NetAdapterBinding, Disable-NetAdapterChecksumOffload, Disab...
Manifest   1.0.0.0    NetConnection                       {Get-NetConnectionProfile, Set-NetConnectionProfile}                                       
Manifest   1.0.0.0    NetEventPacketCapture               {New-NetEventSession, Remove-NetEventSession, Get-NetEventSession, Set-NetEventSession...} 
Manifest   2.0.0.0    NetLbfo                             {Add-NetLbfoTeamMember, Add-NetLbfoTeamNic, Get-NetLbfoTeam, Get-NetLbfoTeamMember...}     
Manifest   1.0.0.0    NetNat                              {Get-NetNat, Get-NetNatExternalAddress, Get-NetNatStaticMapping, Get-NetNatSession...}     
Manifest   2.0.0.0    NetQos                              {Get-NetQosPolicy, Set-NetQosPolicy, Remove-NetQosPolicy, New-NetQosPolicy}                
Manifest   2.0.0.0    NetSecurity                         {Get-DAPolicyChange, New-NetIPsecAuthProposal, New-NetIPsecMainModeCryptoProposal, New-N...
Manifest   1.0.0.0    NetSwitchTeam                       {New-NetSwitchTeam, Remove-NetSwitchTeam, Get-NetSwitchTeam, Rename-NetSwitchTeam...}      
Manifest   1.0.0.0    NetTCPIP                            {Get-NetIPAddress, Get-NetIPInterface, Get-NetIPv4Protocol, Get-NetIPv6Protocol...}        
Manifest   1.0.0.0    NetworkConnectivityStatus           {Get-DAConnectionStatus, Get-NCSIPolicyConfiguration, Reset-NCSIPolicyConfiguration, Set...
Manifest   1.0.0.0    NetworkTransition                   {Add-NetIPHttpsCertBinding, Disable-NetDnsTransitionConfiguration, Disable-NetIPHttpsPro...
Manifest   1.0        NFS                                 {Get-NfsMappedIdentity, Get-NfsNetgroup, Install-NfsMappingStore, New-NfsMappedIdentity...}
Manifest   1.0.0.0    PcsvDevice                          {Get-PcsvDevice, Start-PcsvDevice, Stop-PcsvDevice, Restart-PcsvDevice...}                 
Manifest   1.0.0.0    PKI                                 {Add-CertificateEnrollmentPolicyServer, Export-Certificate, Export-PfxCertificate, Get-C...
Manifest   1.1        PrintManagement                     {Add-Printer, Add-PrinterDriver, Add-PrinterPort, Get-PrintConfiguration...}               
Binary     1.0        PSDesiredStateConfiguration         {Set-DscLocalConfigurationManager, Start-DscConfiguration, Configuration, Get-DscConfigu...
Script     1.0.0.0    PSDiagnostics                       {Disable-PSTrace, Disable-PSWSManCombinedTrace, Disable-WSManTrace, Enable-PSTrace...}     
Binary     1.1.0.0    PSScheduledJob                      {New-JobTrigger, Add-JobTrigger, Remove-JobTrigger, Get-JobTrigger...}                     
Manifest   2.0.0.0    PSWorkflow                          {New-PSWorkflowExecutionOption, New-PSWorkflowSession, nwsn}                               
Manifest   1.0.0.0    PSWorkflowUtility                   Invoke-AsWorkflow                                                                          
Manifest   2.0.0.0    RemoteDesktop                       {Get-RDCertificate, Set-RDCertificate, New-RDCertificate, New-RDVirtualDesktopDeployment...
Manifest   1.0.0.0    ScheduledTasks                      {Get-ScheduledTask, Set-ScheduledTask, Register-ScheduledTask, Unregister-ScheduledTask...}
Manifest   2.0.0.0    SecureBoot                          {Confirm-SecureBootUEFI, Set-SecureBootUEFI, Get-SecureBootUEFI, Format-SecureBootUEFI...} 
Script     1.0.0.0    ServerCore                          {Get-DisplayResolution, Set-DisplayResolution}                                             
Script     2.0.0.0    ServerManager                       {Get-WindowsFeature, Install-WindowsFeature, Uninstall-WindowsFeature, Enable-ServerMana...
Cim        1.0.0.0    ServerManagerTasks                  {Get-SMCounterSample, Get-SMPerformanceCollector, Start-SMPerformanceCollector, Stop-SMP...
Manifest   2.0.0.0    SmbShare                            {Get-SmbShare, Remove-SmbShare, Set-SmbShare, Block-SmbShareAccess...}                     
Manifest   2.0.0.0    SmbWitness                          {Get-SmbWitnessClient, Move-SmbWitnessClient, gsmbw, msmbw...}                             
Manifest   1.0.0.0    SoftwareInventoryLogging            {Get-SilComputer, Get-SilSoftware, Get-SilWindowsUpdate, Get-SilUalAccess...}              
Manifest   1.0.0.0    StartScreen                         {Export-StartLayout, Import-StartLayout, Get-StartApps}                                    
Manifest   2.0.0.0    Storage                             {Add-InitiatorIdToMaskingSet, Add-PartitionAccessPath, Add-PhysicalDisk, Add-TargetPortT...
Manifest   2.0.0.0    TLS                                 {New-TlsSessionTicketKey, Enable-TlsSessionTicketKey, Disable-TlsSessionTicketKey, Expor...
Manifest   1.0.0.0    TroubleshootingPack                 {Get-TroubleshootingPack, Invoke-TroubleshootingPack}                                      
Manifest   2.0.0.0    TrustedPlatformModule               {Get-Tpm, Initialize-Tpm, Clear-Tpm, Unblock-Tpm...}                                       
Manifest   1.0.0.0    UserAccessLogging                   {Enable-Ual, Disable-Ual, Get-Ual, Get-UalDns...}                                          
Manifest   2.0.0.0    VpnClient                           {Add-VpnConnection, Set-VpnConnection, Remove-VpnConnection, Get-VpnConnection...}         
Manifest   1.0.0.0    Wdac                                {Get-OdbcDriver, Set-OdbcDriver, Get-OdbcDsn, Add-OdbcDsn...}                              
Manifest   2.0.0.0    Whea                                {Get-WheaMemoryPolicy, Set-WheaMemoryPolicy}                                               
Manifest   1.0.0.0    WindowsDeveloperLicense             {Get-WindowsDeveloperLicense, Show-WindowsDeveloperLicenseRegistration, Unregister-Windo...
Script     1.0        WindowsErrorReporting               {Enable-WindowsErrorReporting, Disable-WindowsErrorReporting, Get-WindowsErrorReporting}   
Manifest   1.0.0.0    WindowsSearch                       {Get-WindowsSearchSetting, Set-WindowsSearchSetting}                                       


'
Import-Module FailoverClusters  #-- if no command , import 

Get-Command -Module FailoverClusters  

$env:USERDNSDOMAIN

$env:USERDOMAIN


$env:USERPROFILE


#------------------------------------------------------------------
#07  278   New  FailoverClusters command   佈建 容錯移轉叢集  服務 名稱
#------------------------------------------------------------------
$dn='AD.GRETAI.ORG.TW'

gsv -Name '*ClusSvc*'
'gsv -Name *ClusSvc*

Status   Name               DisplayName                           
------   ----               -----------                           
Stopped  ClusSvc            Cluster Service     '
##Get

Get-cluster |FL -Property *

Get-cluster | select  Domain,name 

#  All  cluster on AD
#Get-cluster -Domain  system-ad.mvdis.gov.tw  

Get-cluster -Domain  $dn
'PS C:\Windows\system32> Get-cluster -Domain  $dn

Name                                                                                                                                                 
----                                                                                                                                                 
MIS_DB_CS'


##New

$env:computerName    #BQ-MONDB01
$env:USERDNSDOMAIN   #AD.GRETAI.ORG.TW

MonDBAGL 172.18.65.183

MonDBCluster 172.18.65.186

$t1=get-date
New-Cluster -Name MonDBCluster -Node BQ-MonDB01.AD.GRETAI.ORG.TW  -StaticAddress 172.18.65.186 -NoStorage 
$t2=get-date ; ($t2-$t1) 

Get-cluster  ;ping  MonDBCluster
'Name                                                                                                                                                 
----                                                                                                                                                 
MonDBCluster'

#step:01  ping  FC workable

Get-Cluster -Name MonDBCluster

#



Get-Cluster –Name MonDBCluster | Add-ClusterNode –Name BQ-MonDB02.AD.GRETAI.ORG.TW  #step:02


gsv -ComputerName BQ-MonDB01  ClusSvc     #step:03
gsv -ComputerName BQ-MonDB02   ClusSvc    #step:03


 2016BI:>Active Directory user and computer> csd.syscom > computers  > you can see  MonDBCluster  

## set
##


##start
#Start-Cluster –Name node2

##Remove

#Get-Cluster FC2 | Remove-Cluster -Force -CleanupAD
#ping FC2.csd.syscom


#----------------------------------------------------------------------------------------------------------------------------------------------
#08   254 ClusterNode   檢查節點
#----------------------------------------------------------------------------------------------------------------------------------------------

##Get
Get-ClusterNode
'
PS C:\Windows\system32> Get-ClusterNode

Name                 ID    State                                                                                                                     
----                 --    -----                                                                                                                     
BQ-MONDB01           1     Up                                                                                                                        
BQ-MONDB02           2     Up '


##New
#add-clusterNode -Name  00DPHCSSL01.mvdis.gov.tw 
#add-clusterNode -Name  00DPHCSSL01.mvdis.gov.tw  
#add-clusterNode -Name  00DPHCSSL02mvdis.gov.tw  
#add-clusterNode  SQL2014X.csd.syscom 
## set

##Remove
#remove-clusterNode -Name  01DPHCSSL04.system-ad.mvdis.gov.tw -Force


#Get-clusterNode -name 00DPHCSSL03 | Remove-ClusterNode -force

Clear-ClusterNode 01DPHCSSL03.system-ad.mvdis.gov.tw    -Force  # run @  01DPHCSSL03
Clear-ClusterNode 01DPHCSSL04.system-ad.mvdis.gov.tw    -Force

Clear-ClusterNode SP2013.csd.syscom   -Force  # run @  01DPHCSSL03
Clear-ClusterNode SP2013WFE.csd.syscom  -Force 
Clear-ClusterNode SQL2012X.csd.syscom  -Force 

remove-clusterNode -Name  SP2013.csd.syscom -Force
remove-clusterNode -Name  SP2013WFE.csd.syscom -Force
remove-clusterNode -Name  SQL2012X.csd.syscom -Force


#--------------------------------------------
#09   394   ClusterOwnerNode   檢查擁有者節點
#--------------------------------------------
##Get

Get-ClusterGroup   
'
PS C:\Windows\system32> Get-ClusterGroup

Name                                              OwnerNode                                         State                                            
----                                              ---------                                         -----                                            
可用存放裝置                                            BQ-MONDB01                                        PartialOnline                                    
叢集群組                                              BQ-MONDB01                                        Online                                           

'
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
#10   429  Disk  檢查磁碟
#--------------------------------------------
 
注意  磁碟 不可為 共同磁碟, 如有進入 compmgmt.msc  ,將之移除 !!

##Get

Get-Disk 
'
PS C:\Windows\system32> Get-Disk

Number Friendly Name                            OperationalStatus                                        Total Size Partition Style                  
------ -------------                            -----------------                                        ---------- ---------------                  
0      LSI UCSB-MRAID12G SCSI Disk Device       Online                                                    278.46 GB MBR                              
2      IBM 2145  Multi-Path Disk Device         Online                                                       500 GB MBR                              
1      IBM 2145  Multi-Path Disk Device         Online                                                         1 TB MBR                              
3      IBM 2145  Multi-Path Disk Device         Online                                                       500 GB MBR                              


'



##New
#Get-ClusterAvailableDisk | Add-ClusterDisk  #adds all disks that are ready to be added to the local cluster


## set
#Import-Module?FailoverClusters?
##Remove

#--------------------------------------------
#11 	461  Get-ClusterNetwork  檢查叢集網路
#--------------------------------------------
##Get
get-ClusterNetwork |select name,Address,state
'
PS C:\Windows\system32> get-ClusterNetwork |select name,Address,state

Name                                              Address                                                                                       State
----                                              -------                                                                                       -----
叢集網路 1                                            192.168.65.0                                                                                     Up
叢集網路 2                                            172.18.65.0                                                                                      Up



## set  rename
Get-ClusterNetwork |select name,Address,state
(Get-ClusterNetwork | ? {$_.Address -eq "172.16.220.0"}).Name = "ClusterNetworkNewName"
'

#--------------------------------------------
#12  481 Get-ClusterLog   檢查叢集記錄
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
#13  573  安裝 Net 4.5
#-------------------------------------------- 
#sourcepath=''

Install-WindowsFeature net-framework-core -source c:\software\SXS
 
Add-windowsfeature NET-Framework-45-Features
Add-windowsfeature NET-Framework-45-Core

#--------------------------------------------
#14  520   enable firewall 檢查防火牆
#-------------------------------------------- 
firewall.cplwf.msctelnet bq-mondb01 1433
telnet bq-mondb02 1433




#--------------------------------------------
#15 532  mkdir  & sharefolder  建立資料夾及分享資料夾
#-------------------------------------------- 

$SQLSource ='C:\software\SQL2014_ENT_TW_X64'
whoami  #ad\infoadm
services.msc
cluadmin.msc

MD c:\temp  (sharefolder )  \\BQ-MONDB01\temp
MD X:\SQLData
MD Y:\SQLLogMD Z:\SQLTEMPDBMD X:\SQLData\Backup#--------------------------------------------
#16  550  建立 SQL 安裝  ConfigurationFile.ini
#-------------------------------------------- NT Service\SQLSERVERAGENTNT Service\MSSQLSERVER

執行個體根目錄     :C:\Program Files\Microsoft SQL Server\共用功能目錄       :C:\Program Files\Microsoft SQL Server\共用功能目錄(X86)  :C:\Program Files (x86)\Microsoft SQL Server\

'記得 要  區分大小寫'   Chinese_Taiwan_Stroke_CS_AS

 ii 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150916_101329\ConfigurationFile.ini' cpi -Path 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150916_101329\ConfigurationFile.ini' -Destination C:\ps1\SSDE_ConfigurationFile.ini -Force ii 'C:\PS1\SSDE_ConfigurationFile.ini'
 cpi -Path 'C:\PS1\SSDE_ConfigurationFile.ini' -Destination \\dq-mondb02\C$\PS1\SSDE_ConfigurationFile.ini

  FEATURES=SQLENGINE,REPLICATION,SSMS,ADV_SSMS,SNAC_SDK


#在 dq-mondb01 & dq-mondb02 同步執行
cmd /c ("C:\software\SQL2014_ENT_TW_X64\Setup") '/ConfigurationFile=C:\PS1\SSDE_ConfigurationFile.ini'


  gsv *sql*
  'PS C:\Windows\system32>   gsv *sql*

Status   Name               DisplayName                           
------   ----               -----------                           
Running  MSSQLSERVER        SQL Server (MSSQLSERVER)              
Stopped  SQLBrowser         SQL Server Browser                    
Stopped  SQLSERVERAGENT     SQL Server Agent (MSSQLSERVER)        
Running  SQLWriter          SQL Server VSS Writer '




#--------------------------------------------
#17 585 啟動 alwayson 功能
#--------------------------------------------

use UI

sqlservermanager12.msc

(gsv -Name MSSQLSERVER).stop()
(gsv -Name MSSQLSERVER).Start()


#--------------------------------------------
#18  599  import-module sqlps   匯入  oowershell for SQL
#--------------------------------------------

ii 'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\'

Import-Module  'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\SQLPS' -DisableNameChecking

Import-Module  'SQLPS' -DisableNameChecking


get-module

#--------------------------------------------
#19   612  create database for sample  建立測試Database 及 備份
#--------------------------------------------


CREATE DATABASE [TEST]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TEST', FILENAME = N'X:\SQLData\TEST.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TEST_log', FILENAME = N'Y:\SQLLog\TEST_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO



BACKUP DATABASE [TEST] TO  DISK = N'\\BQ-MONDB01\temp\test.bak' 

WITH NOFORMAT, NOINIT,  NAME = N'ssmatesterdb-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10



alwayson group =  MonG1





#--------------------------------------------
#20  640  設定 alwayson 服務
#--------------------------------------------
{<#


--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect BQ-MONDB01

USE [master]

GO

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

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [NT Service\MSSQLSERVER]

GO

:Connect BQ-MONDB02

USE [master]

GO

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

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [NT Service\MSSQLSERVER]

GO

:Connect BQ-MONDB01

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO

:Connect BQ-MONDB02

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END

GO

:Connect BQ-MONDB01

USE [master]

GO

CREATE AVAILABILITY GROUP [MonG1]
WITH (AUTOMATED_BACKUP_PREFERENCE = SECONDARY)
FOR DATABASE [TEST]
REPLICA ON N'BQ-MONDB01' WITH (ENDPOINT_URL = N'TCP://BQ-MONDB01.ad.gretai.org.tw:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
	N'BQ-MONDB02' WITH (ENDPOINT_URL = N'TCP://BQ-MONDB02.ad.gretai.org.tw:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));

GO

:Connect BQ-MONDB02

ALTER AVAILABILITY GROUP [MonG1] JOIN;

GO

:Connect BQ-MONDB01

BACKUP DATABASE [TEST] TO  DISK = N'\\BQ-MONDB01\temp\TEST.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect BQ-MONDB02

RESTORE DATABASE [TEST] FROM  DISK = N'\\BQ-MONDB01\temp\TEST.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect BQ-MONDB01

BACKUP LOG [TEST] TO  DISK = N'\\BQ-MONDB01\temp\TEST_20150916032515.trn' WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect BQ-MONDB02

RESTORE LOG [TEST] FROM  DISK = N'\\BQ-MONDB01\temp\TEST_20150916032515.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect BQ-MONDB02


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'MonG1'
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
ALTER DATABASE [TEST] SET HADR AVAILABILITY GROUP = [MonG1];

GO


GO






ping 172.18.65.183
ping monDBagl


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
#>}
#--------------------------------------------
#21  929    建立 AG listener
#--------------------------------------------
use UI

ssms 
