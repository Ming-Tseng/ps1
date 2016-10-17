<#
OS10_AD

\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS10_AD.ps1

Date: MAR.29.2014
LastDate: Aug.26.2015

OS09_modules.ps1  line:  09   275  Remote Active Directory Administration  AD module RSAT-AD-PowerShell  RSAT-AD-AdminCenter

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS10_AD.ps1

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


#  12  Install  RSAT-AD-PowerShell  Installing the Active Directory Module for PowerShell
#  108  Use PowerShell to Deploy a New Active Directory Forest 
#  290  Get-ADDomain
#  310  Get-ADComputer
#  344 Get-ADGroup
#  428  NEW-ADOrganizationalUnit
#  523   ADUser 
#   669  Move-ADObject user to OU
#  699  ADGroupMember
#  734 ADAccountPassword 
#  747 ADAccount  
#  781  How to configure a firewall for domains and trusts.  Aug.29.2015





#-------------------------
#  12  Install  RSAT-AD-PowerShell  Installing the Active Directory Module for PowerShell
#-------------------------

fully qualified domain name (FQDN) is named csd.syscom


Get-Module –ListAvailable
<#  PMD2016

ModuleType Version    Name                                ExportedCommands                                                                                               
---------- -------    ----                                ----------------                                                                                               
Manifest   1.0.0.0    ActiveDirectory                     {Add-ADCentralAccessPolicyMember, Add-ADComputerServiceAccount, Add-ADDomainControllerPasswordReplicationPol...
Manifest   2.0.0.0    AppLocker                           {Get-AppLockerFileInformation, Get-AppLockerPolicy, New-AppLockerPolicy, Set-AppLockerPolicy...}               
Manifest   2.0.0.0    Appx                                {Add-AppxPackage, Get-AppxPackage, Get-AppxPackageManifest, Remove-AppxPackage...}                             
Manifest   1.0        BestPractices                       {Get-BpaModel, Get-BpaResult, Invoke-BpaModel, Set-BpaResult}                                                  
Manifest   1.0.0.0    BitsTransfer                        {Add-BitsFile, Complete-BitsTransfer, Get-BitsTransfer, Remove-BitsTransfer...}                                
Manifest   1.0.0.0    BranchCache                         {Add-BCDataCacheExtension, Clear-BCCache, Disable-BC, Disable-BCDowngrading...}                                
Manifest   1.0.0.0    CimCmdlets                          {Get-CimAssociatedInstance, Get-CimClass, Get-CimInstance, Get-CimSession...}                                  
Manifest   1.0.0.0    DirectAccessClientComponents        {Disable-DAManualEntryPointSelection, Enable-DAManualEntryPointSelection, Get-DAClientExperienceConfiguratio...
Script     3.0        Dism                                {Add-AppxProvisionedPackage, Add-WindowsDriver, Add-WindowsImage, Add-WindowsPackage...}                       
Manifest   1.0.0.0    DnsClient                           {Resolve-DnsName, Clear-DnsClientCache, Get-DnsClient, Get-DnsClientCache...}                                  
Manifest   2.0.0.0    International                       {Get-WinDefaultInputMethodOverride, Set-WinDefaultInputMethodOverride, Get-WinHomeLocation, Set-WinHomeLocat...
Manifest   1.0.0.0    iSCSI                               {Get-IscsiTargetPortal, New-IscsiTargetPortal, Remove-IscsiTargetPortal, Update-IscsiTargetPortal...}          
Manifest   2.0.0.0    IscsiTarget                         {Add-ClusteriSCSITargetServerRole, Add-IscsiVirtualDiskTargetMapping, Checkpoint-IscsiVirtualDisk, Convert-I...
Script     1.0.0.0    ISE                                 {New-IseSnippet, Import-IseSnippet, Get-IseSnippet}                                                            
Manifest   1.0.0.0    Kds                                 {Add-KdsRootKey, Get-KdsRootKey, Test-KdsRootKey, Set-KdsConfiguration...}                                     
Manifest   3.0.0.0    Microsoft.PowerShell.Diagnostics    {Get-WinEvent, Get-Counter, Import-Counter, Export-Counter...}                                                 
Manifest   3.0.0.0    Microsoft.PowerShell.Host           {Start-Transcript, Stop-Transcript}                                                                            
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Content, Clear-Content, Clear-ItemProperty, Join-Path...}                                                 
Manifest   3.0.0.0    Microsoft.PowerShell.Security       {Get-Acl, Set-Acl, Get-PfxCertificate, Get-Credential...}                                                      
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Format-List, Format-Custom, Format-Table, Format-Wide...}                                                     
Manifest   3.0.0.0    Microsoft.WSMan.Management          {Disable-WSManCredSSP, Enable-WSManCredSSP, Get-WSManCredSSP, Set-WSManQuickConfig...}                         
Manifest   1.0        MMAgent                             {Disable-MMAgent, Enable-MMAgent, Set-MMAgent, Get-MMAgent...}                                                 
Manifest   1.0.0.0    MsDtc                               {New-DtcDiagnosticTransaction, Complete-DtcDiagnosticTransaction, Join-DtcDiagnosticResourceManager, Receive...
Manifest   2.0.0.0    NetAdapter                          {Disable-NetAdapter, Disable-NetAdapterBinding, Disable-NetAdapterChecksumOffload, Disable-NetAdapterEncapsu...
Manifest   1.0.0.0    NetConnection                       {Get-NetConnectionProfile, Set-NetConnectionProfile}                                                           
Manifest   1.0.0.0    NetEventPacketCapture               {New-NetEventSession, Remove-NetEventSession, Get-NetEventSession, Set-NetEventSession...}                     
Manifest   2.0.0.0    NetLbfo                             {Add-NetLbfoTeamMember, Add-NetLbfoTeamNic, Get-NetLbfoTeam, Get-NetLbfoTeamMember...}                         
Manifest   1.0.0.0    NetNat                              {Get-NetNat, Get-NetNatExternalAddress, Get-NetNatStaticMapping, Get-NetNatSession...}                         
Manifest   2.0.0.0    NetQos                              {Get-NetQosPolicy, Set-NetQosPolicy, Remove-NetQosPolicy, New-NetQosPolicy}                                    
Manifest   2.0.0.0    NetSecurity                         {Get-DAPolicyChange, New-NetIPsecAuthProposal, New-NetIPsecMainModeCryptoProposal, New-NetIPsecQuickModeCryp...
Manifest   1.0.0.0    NetSwitchTeam                       {New-NetSwitchTeam, Remove-NetSwitchTeam, Get-NetSwitchTeam, Rename-NetSwitchTeam...}                          
Manifest   1.0.0.0    NetTCPIP                            {Get-NetIPAddress, Get-NetIPInterface, Get-NetIPv4Protocol, Get-NetIPv6Protocol...}                            
Manifest   1.0.0.0    NetworkConnectivityStatus           {Get-DAConnectionStatus, Get-NCSIPolicyConfiguration, Reset-NCSIPolicyConfiguration, Set-NCSIPolicyConfigura...
Manifest   1.0.0.0    NetworkTransition                   {Add-NetIPHttpsCertBinding, Disable-NetDnsTransitionConfiguration, Disable-NetIPHttpsProfile, Disable-NetNat...
Manifest   1.0        NFS                                 {Get-NfsMappedIdentity, Get-NfsNetgroup, Install-NfsMappingStore, New-NfsMappedIdentity...}                    
Manifest   1.0.0.0    PcsvDevice                          {Get-PcsvDevice, Start-PcsvDevice, Stop-PcsvDevice, Restart-PcsvDevice...}                                     
Manifest   1.0.0.0    PKI                                 {Add-CertificateEnrollmentPolicyServer, Export-Certificate, Export-PfxCertificate, Get-CertificateAutoEnroll...
Manifest   1.1        PrintManagement                     {Add-Printer, Add-PrinterDriver, Add-PrinterPort, Get-PrintConfiguration...}                                   
Manifest   1.0        PSDesiredStateConfiguration         {Set-DscLocalConfigurationManager, Start-DscConfiguration, Update-DscConfiguration, Configuration...}          
Script     1.0.0.0    PSDiagnostics                       {Disable-PSTrace, Disable-PSWSManCombinedTrace, Disable-WSManTrace, Enable-PSTrace...}                         
Binary     1.1.0.0    PSScheduledJob                      {New-JobTrigger, Add-JobTrigger, Remove-JobTrigger, Get-JobTrigger...}                                         
Manifest   2.0.0.0    PSWorkflow                          {New-PSWorkflowExecutionOption, New-PSWorkflowSession, nwsn}                                                   
Manifest   1.0.0.0    PSWorkflowUtility                   Invoke-AsWorkflow                                                                                              
Manifest   2.0.0.0    RemoteDesktop                       {Get-RDCertificate, Set-RDCertificate, New-RDCertificate, New-RDVirtualDesktopDeployment...}                   
Manifest   1.0.0.0    ScheduledTasks                      {Get-ScheduledTask, Set-ScheduledTask, Register-ScheduledTask, Unregister-ScheduledTask...}                    
Manifest   2.0.0.0    SecureBoot                          {Confirm-SecureBootUEFI, Set-SecureBootUEFI, Get-SecureBootUEFI, Format-SecureBootUEFI...}                     
Script     1.0.0.0    ServerCore                          {Get-DisplayResolution, Set-DisplayResolution}                                                                 
Script     2.0.0.0    ServerManager                       {Get-WindowsFeature, Install-WindowsFeature, Uninstall-WindowsFeature, Enable-ServerManagerStandardUserRemot...
Cim        1.0.0.0    ServerManagerTasks                  {Get-SMCounterSample, Get-SMPerformanceCollector, Start-SMPerformanceCollector, Stop-SMPerformanceCollector...}
Manifest   2.0.0.0    SmbShare                            {Get-SmbShare, Remove-SmbShare, Set-SmbShare, Block-SmbShareAccess...}                                         
Manifest   2.0.0.0    SmbWitness                          {Get-SmbWitnessClient, Move-SmbWitnessClient, gsmbw, msmbw...}                                                 
Manifest   2.0.0.0    SoftwareInventoryLogging            {Get-SilComputer, Get-SilComputerIdentity, Get-SilSoftware, Get-SilWindowsUpdate...}                           
Manifest   1.0.0.0    StartScreen                         {Export-StartLayout, Import-StartLayout, Get-StartApps}                                                        
Manifest   2.0.0.0    Storage                             {Add-InitiatorIdToMaskingSet, Add-PartitionAccessPath, Add-PhysicalDisk, Add-TargetPortToMaskingSet...}        
Manifest   2.0.0.0    TLS                                 {New-TlsSessionTicketKey, Enable-TlsSessionTicketKey, Disable-TlsSessionTicketKey, Export-TlsSessionTicketKey} 
Manifest   1.0.0.0    TroubleshootingPack                 {Get-TroubleshootingPack, Invoke-TroubleshootingPack}                                                          
Manifest   2.0.0.0    TrustedPlatformModule               {Get-Tpm, Initialize-Tpm, Clear-Tpm, Unblock-Tpm...}                                                           
Manifest   1.0.0.0    UserAccessLogging                   {Enable-Ual, Disable-Ual, Get-Ual, Get-UalDns...}                                                              
Manifest   2.0.0.0    VpnClient                           {Add-VpnConnection, Set-VpnConnection, Remove-VpnConnection, Get-VpnConnection...}                             
Manifest   1.0.0.0    Wdac                                {Get-OdbcDriver, Set-OdbcDriver, Get-OdbcDsn, Add-OdbcDsn...}                                                  
Manifest   2.0.0.0    Whea                                {Get-WheaMemoryPolicy, Set-WheaMemoryPolicy}                                                                   
Manifest   1.0.0.0    WindowsDeveloperLicense             {Get-WindowsDeveloperLicense, Show-WindowsDeveloperLicenseRegistration, Unregister-WindowsDeveloperLicense}    
Script     1.0        WindowsErrorReporting               {Enable-WindowsErrorReporting, Disable-WindowsErrorReporting, Get-WindowsErrorReporting}                       
Manifest   1.0.0.0    WindowsSearch                       {Get-WindowsSearchSetting, Set-WindowsSearchSetting}                                                           


#>



GEt-WindowsFeature  RSAT-AD-PowerShell

Add-WindowsFeature  RSAT-AD-PowerShell # Install State (Available) to  (Installed)

Import-Module servermanager
Add-WindowsFeature telnet-client
Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools

##
use UI
  >add feature > remote server management tools> role management Tool >

##
import-module activedirectory

##unInstall

#-------------------------
#  108  Use PowerShell to Deploy a New Active Directory Forest 
#-------------------------
http://blogs.technet.com/b/heyscriptingguy/archive/2013/01/03/use-powershell-to-deploy-a-new-active-directory-forest.aspx

<0.>
Set-ExecutionPolicy remotesigned -force

# 2  Some of the infrastructure prerequisites are listed here.
<1.> Ensure the server has the correct name.
<#
#rename the computer 
$newname = "dc8508" 
Rename-Computer -NewName $newname –force
#>


<2.> Set a static IP address configuration.
<#
#set static IP address 
$ipaddress = "192.168.0.225" 
$ipprefix = "24" 
$ipgw = "192.168.0.1" 
$ipdns = "192.168.0.225" 
$ipif = (Get-NetAdapter).ifIndex 
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix ` 
-InterfaceIndex $ipif -DefaultGateway $ipgw
#>


<3.> Ensure DNS is deployed and configured.




# 3 These role-based prerequisites are shown here.
<4.> Active Directory module for Windows PowerShell &  Active Directory Administrative Center tools

<#
#install features 

Add-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter,RSAT-AD-Tools

$featureLogPath = "c:\poshlog\featurelog.txt" 
New-Item $featureLogPath -ItemType file -Force 

$addsTools = "RSAT-AD-Tools" 
Add-WindowsFeature $addsTools 


Get-WindowsFeature | Where installed >>$featureLogPa



#>

Get-WindowsFeature | ? name -like '*DNs*' |Out-GridView

Add-WindowsFeature  FileAndStorage-Services
Add-WindowsFeature 	NET-Framework-45-Features	Installed	

[ ] Active Directory 網域服務	AD-Domain-Services	Available	
[ ] DNS 伺服器	DNS	Available	
[ ] 群組原則管理	GPMC	Available	
[ ] DNS 伺服器工具	RSAT-DNS-Server	Available	


[X] 檔案和存放服務	FileAndStorage-Services	Installed	
[X] 存放服務	Storage-Services	Installed	
[X] .NET Framework 4.5 功能	NET-Framework-45-Features	Installed	
[X] .NET Framework 4.5	NET-Framework-45-Core	Installed	
[X] WCF 服務	NET-WCF-Services45	Installed	
[X] TCP 連接埠共用	NET-WCF-TCP-PortSharing45	Installed	
[X] 遠端伺服器管理工具	RSAT	Installed	
[X] 角色管理工具	RSAT-Role-Tools	Installed	
[X] AD DS 及 AD LDS 工具	RSAT-AD-Tools	Installed	
[X] Windows PowerShell 的 Active Directory 模組	RSAT-AD-PowerShell	Installed	
[ ] AD DS 工具	RSAT-ADDS	Available	
[ ] Active Directory 管理中心	RSAT-AD-AdminCenter	Available	
[ ] AD DS 嵌入式管理單元及命令列工具	RSAT-ADDS-Tools	Available	
[ ] AD LDS 嵌入式管理單元及命令列工具	RSAT-ADLDS	Available	
[X] 使用者介面與基礎結構	User-Interfaces-Infra	Installed	
[X] 圖形化管理工具與基礎結構	Server-Gui-Mgmt-Infra	Installed	
[X] 伺服器圖形化殼層	Server-Gui-Shell	Installed	
[X] Windows PowerShell	PowerShellRoot	Installed	
[X] Windows PowerShell 4.0	PowerShell	Installed	
[X] Windows PowerShell ISE	PowerShell-ISE	Installed	
[X] WoW64 支援	WoW64-Support	Installed	



	
Add-windowsfeature FileAndStorage-Services
Add-windowsfeature Storage-Services
Add-windowsfeature NET-Framework-45-Features
Add-windowsfeature NET-Framework-45-Core
Add-windowsfeature NET-WCF-Services45
Add-windowsfeature NET-WCF-TCP-PortSharing45
Add-windowsfeature RSAT
Add-windowsfeature RSAT-Role-Tools
Add-windowsfeature RSAT-AD-Tools
Add-windowsfeature RSAT-AD-PowerShell
Add-windowsfeature RSAT-ADDS
Add-windowsfeature RSAT-AD-AdminCenter
Add-windowsfeature RSAT-ADDS-Tools
Add-windowsfeature RSAT-ADLDS
Add-windowsfeature User-Interfaces-Infra
Add-windowsfeature Server-Gui-Mgmt-Infra
Add-windowsfeature Server-Gui-Shell
Add-windowsfeature PowerShellRoot
Add-windowsfeature PowerShell
Add-windowsfeature PowerShell-ISE
Add-windowsfeature WoW64-Support
	
Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools

Wait-Job -Name addFeature 
Get-WindowsFeature | Where installed 



<5.> restart the computer 
Restart-Computer





<6.> verify that the roles and features were added properly
Get-WindowsFeature | Where installed >>$featureLogPath

Get-WindowsFeature | ? installed

<7.> InstallNewForest.ps1

# Create New Forest, add Domain Controller 
$domainname = "Tempcsd.syscom" 
$netbiosName = "tempcsd" 

Import-Module ADDSDeployment 

Install-ADDSForest -CreateDnsDelegation:$false ` 
-DatabasePath "C:\Windows\NTDS" ` 
-DomainMode "Win2012" ` 
-DomainName $domainname ` 
-DomainNetbiosName $netbiosName ` 
-ForestMode "Win2012" ` 
-InstallDns:$true ` 
-LogPath "C:\Windows\NTDS" ` 
-NoRebootOnCompletion:$false ` 
-SysvolPath "C:\Windows\SYSVOL" ` 
-Force:$true


C:\> Install-ADDSForest           #<-- Workable 
 -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "Win2012R2" `
 -DomainName "PMD.CSD.SYSCOM" `
 -DomainNetbiosName "PMD" `
 -ForestMode "Win2012R2" `
 -safemodeadministratorpassword (convertto-securestring "pass@word" -asplaintext -force) `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true
#

#-------------------------
#   287   AddAdPrereqs.ps1 example
#-------------------------
#set static IP address 
$ipaddress = "192.168.0.225" 
$ipprefix = "24" 
$ipgw = "192.168.0.1" 
$ipdns = "192.168.0.225" 
$ipif = (Get-NetAdapter).ifIndex 
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix ` 
-InterfaceIndex $ipif -DefaultGateway $ipgw 
#rename the computer 
$newname = "dc8508" 
Rename-Computer -NewName $newname -force 
#install features 
$featureLogPath = "c:\poshlog\featurelog.txt" 
New-Item $featureLogPath -ItemType file -Force 
$addsTools = "RSAT-AD-Tools" 
Add-WindowsFeature $addsTools 
Get-WindowsFeature | Where installed >>$featureLogPath 
#restart the computer 
Restart-Computer
#-------------------------
#  290  Get-ADDomain
#-------------------------

<#
Get-ADDomain


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=tempcsd,DC=syscom
DeletedObjectsContainer            : CN=Deleted Objects,DC=tempcsd,DC=syscom
DistinguishedName                  : DC=tempcsd,DC=syscom
DNSRoot                            : tempcsd.syscom
DomainControllersContainer         : OU=Domain Controllers,DC=tempcsd,DC=syscom
DomainMode                         : Windows2012R2Domain
DomainSID                          : S-1-5-21-2468440410-1141623422-109008057
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=tempcsd,DC=syscom
Forest                             : tempcsd.syscom
InfrastructureMaster               : WIN-2S026UBRQFO.tempcsd.syscom
LastLogonReplicationInterval       : 
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=tempcsd,DC=syscom}
LostAndFoundContainer              : CN=LostAndFound,DC=tempcsd,DC=syscom
ManagedBy                          : 
Name                               : tempcsd
NetBIOSName                        : TEMPCSD
ObjectClass                        : domainDNS
ObjectGUID                         : 3222220a-191a-4836-bf35-fb232e6ee705
ParentDomain                       : 
PDCEmulator                        : WIN-2S026UBRQFO.tempcsd.syscom
QuotasContainer                    : CN=NTDS Quotas,DC=tempcsd,DC=syscom
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {WIN-2S026UBRQFO.tempcsd.syscom}
RIDMaster                          : WIN-2S026UBRQFO.tempcsd.syscom
SubordinateReferences              : {DC=ForestDnsZones,DC=tempcsd,DC=syscom, DC=DomainDnsZones,DC=tempcsd,DC=syscom, 
                                     CN=Configuration,DC=tempcsd,DC=syscom}
SystemsContainer                   : CN=System,DC=tempcsd,DC=syscom
UsersContainer                     : CN=Users,DC=tempcsd,DC=syscom
#>

http://www.tomsitpro.com/articles/powershell-active-directory-cmdlets,2-801.html

Get-ADUser

Remove-ADGroupMember –Identity “Domain Admins” –Member  “khess”


#-------------------------
#   310  Get-ADComputer
#-------------------------
##Get
Get-ADComputer -Filter * |select name

$t=Get-ADComputer  -Filter {name -eq 'sp2013'} -Properties *
$t.OperatingSystem

Get-ADComputer  -Filter {Name -eq 'sp2013'} -Properties Name,OperatingSystem,OperatingSystemServicePack


Get-ADComputer  -Filter * -Property Name,OperatingSystem,OperatingSystemServicePack,logonCount






## New

## delete

#-------------------------
#    344 Get-ADGroup
#-------------------------
## Get
Get-ADGroup -Filter * | select name,SamAccountName
<#
PS C:\Users\Administrator> Get-ADGroup -Filter * | select name,SamAccountName|Sort-Object name

name                                                                        SamAccountName                                                            
----                                                                        --------------                                                            
Access Control Assistance Operators                                         Access Control Assistance Operators                                       
Account Operators                                                           Account Operators                                                         
Administrators                                                              Administrators                                                            
Allowed RODC Password Replication Group                                     Allowed RODC Password Replication Group                                   
Backup Operators                                                            Backup Operators                                                          
Cert Publishers 已允許這個群組的成員將憑證發行到目錄        DomainLocal                                         Cert Publishers                                                           
Certificate Service DCOM Access                                             Certificate Service DCOM Access                                           
Cloneable Domain Controllers   可以複製屬於此群組的網域控制站。    Global                                          Cloneable Domain Controllers                                              
Cryptographic Operators                                                     Cryptographic Operators                                                   
Denied RODC Password Replication Group 個群組的成員，不可將其密碼複寫至網域中任何唯讀網域控制站       DomainLocal                              Denied RODC Password Replication Group                                    
Distributed COM Users                                                       Distributed COM Users                                                     
DnsAdmins    DNS 系統管理員群組   DomainLocal                                 DnsAdmins                                                                 
DnsUpdateProxy    可以替其他用戶端 (例如 DHCP 伺服器) 執行動態更新的 DNS 用戶端。    Global    DnsUpdateProxy                                                            
Domain Admins    指定的網域系統管理員      Global             Domain Admins                                                             
Domain Computers 所有已加入網域的工作站及伺服器    Global                                     Domain Computers                                                          
Domain Controllers   在網域所有的網域控制站    Global                                                      Domain Controllers                                                        
Domain Guests    所有網域來賓  Global                                                         Domain Guests                                                             
Domain Users     所有網域使用者  Global                                                         Domain Users                                                              
Enterprise Admins   指定的公司系統管理員   Universal                            Enterprise Admins                                                         
Enterprise Read-only Domain Controllers   此群組成員在企業中是唯讀的網域控制站   Universal                               Enterprise Read-only Domain Controllers                                   
Event Log Readers                                                           Event Log Readers                                                         
Group Policy Creator Owners  這個群組的成員可以修改網域的群組原則       Global                                        Group Policy Creator Owners                                               
Guests                                                                      Guests                                                                    
HelpLibraryUpdaters                                                         HelpLibraryUpdaters                                                       
Hyper-V Administrators                                                      Hyper-V Administrators                                                    
IIS_IUSRS                                                                   IIS_IUSRS                                                                 
Incoming Forest Trust Builders                                              Incoming Forest Trust Builders                                            
Network Configuration Operators                                             Network Configuration Operators                                           
Performance Log Users                                                       Performance Log Users                                                     
Performance Monitor Users                                                   Performance Monitor Users                                                 
Pre-Windows 2000 Compatible Access                                          Pre-Windows 2000 Compatible Access                                        
Print Operators                                                             Print Operators                                                           
Protected Users      系統會為此群組的成員提供額外的保護，讓其免於驗證安全性威脅。如需詳細資訊，請參閱 http://go.microsoft.com/fwlink/?LinkId=298939。              Protected Users                                                           
RAS and IAS Servers  這個群組的伺服器可以存取遠端存取的使用者內容                RAS and IAS Servers                                                       
RDS Endpoint Servers                                                        RDS Endpoint Servers                                                      
RDS Management Servers                                                      RDS Management Servers                                                    
RDS Remote Access Servers                                                   RDS Remote Access Servers                                                 
Read-only Domain Controllers  這個群組的成員是網域的唯讀網域控制站      Read-only Domain Controllers                                              
Remote Desktop Users                                                        Remote Desktop Users                                                      
Remote Management Users                                                     Remote Management Users                                                   
Replicator                                                                  Replicator                                                                
Schema Admins   指定的系統管理員架構                                           Schema Admins                                                             
Server Operators                                                            Server Operators                                                          
SQLServer2005SQLBrowserUser$WIN-2S026UBRQFO                                 SQLServer2005SQLBrowserUser$WIN-2S026UBRQFO                               
Terminal Server License Servers                                             Terminal Server License Servers                                           
Users                                                                       Users                                                                     
Windows Authorization Access Group                                           Windows Authorization Access Group                                        
WinRMRemoteWMIUsers__   Members of this group can access WMI resources over  WinRMRemoteWMIUsers__                                                     


#>

get-adgroup -Filter 'GroupCategory -eq "Security" -and GroupScope -ne "DomainLocal"'
get-adgroup -server localhost:60000 -filter {GroupScope -eq "DomainLocal"} -SearchBase "DC=AppNC" 

$SearchBase=(Get-ADDomain |select DistinguishedName).DistinguishedName
Get-ADGroup -Filter {name -like 'BI*'} -SearchBase  $SearchBase | select name,SamAccountName

get-adgroup  -filter {GroupScope -eq "DomainLocal"} -SearchBase "DC=tempcsd,dc=syscom"  #DomainLocal, global , universal

## New
 
New-ADGroup  -Name "BI Infra Group" -SamAccountName BIinfraGroup  -GroupCategory Security  -GroupScope Global `
-DisplayName "BI Infra Group"   -Description "Infra Group Description" 
New-ADGroup  -Name "BI Designer Group" -SamAccountName BIDesignerGroup  -GroupCategory Security  -GroupScope Global `
-DisplayName "BI Designer Group"   -Description "BI Designer Group Description" 
New-ADGroup  -Name "BI Leader Group" -SamAccountName BILeaderGroup  -GroupCategory Security  -GroupScope Global `
-DisplayName "BI Leader Group"   -Description "Leader Group Description" 
New-ADGroup  -Name "BI PowerUser Group" -SamAccountName BIPowerUserGroup  -GroupCategory Security  -GroupScope Global `
-DisplayName "BI PowerUser Group"   -Description "PowerUser Group Description" 
New-ADGroup  -Name "BI EndUser Group" -SamAccountName BIEndUserGroup  -GroupCategory Security  -GroupScope Global `
-DisplayName "BI EndUser Group"   -Description "EndUser Group Description" 
New-ADGroup  -Name "BI Aduit Group" -SamAccountName BIAduitGroup  -GroupCategory Security  -GroupScope Global `
-DisplayName "BI Aduit Group"   -Description "Aduit Group Description" 

## Update


##Drop


#-------------------------
#    428  ADOrganizationalUnit
#-------------------------

Get-ADOrganizationalUnit -Filter *
Get-ADOrganizationalUnit -Filter  {name  -like 'ac*'} |select *
Get-ADOrganizationalUnit -Filter  {name  -like 'ac*'} |select name , distinguishedname

<#
City                     : 
Country                  : 
DistinguishedName        : OU=DataAnalysis,DC=tempcsd,DC=syscom
LinkedGroupPolicyObjects : {}
ManagedBy                : CN=Administrator,CN=Users,DC=tempcsd,DC=syscom
Name                     : DataAnalysis
ObjectClass              : organizationalUnit
ObjectGUID               : 277f062c-c18d-46d6-9bc4-e42b17792bbe
PostalCode               : 
State                    : 
StreetAddress            : 
PropertyNames            : {City, Country, DistinguishedName, LinkedGroupPolicyObjects...}
AddedProperties          : {}
RemovedProperties        : {}
ModifiedProperties       : {}
PropertyCount            : 11
#>


## New 
$path=",DC=tempcsd,DC=syscom"


NEW-ADOrganizationalUnit “Accounting"
NEW-ADOrganizationalUnit “AP"
NEW-ADOrganizationalUnit “CEO"
NEW-ADOrganizationalUnit “DataAnalysis"
NEW-ADOrganizationalUnit “IT"
NEW-ADOrganizationalUnit “PM"
NEW-ADOrganizationalUnit “Sales"


NEW-ADOrganizationalUnit “ETL” –path “OU=DataAnalysis,DC=tempcsd,DC=syscom”
NEW-ADOrganizationalUnit “DataModel” –path “OU=DataAnalysis,DC=tempcsd,DC=syscom”
NEW-ADOrganizationalUnit “Report” –path “OU=DataAnalysis,DC=tempcsd,DC=syscom”

##
$Identity="OU=Report,OU=DataAnalysis,DC=tempcsd,DC=syscom"

Set-ADOrganizationalUnit -Identity $Identity -Description "This Organizational Unit holds all of the users accounts of tempcsd.syscom"

Set-ADOrganizationalUnit -Identity  $Identity  -Country "TW" -StreetAddress "45 Martens Place" -City Taipei -State TW -PostalCode 4171 -Replace @{co="Australia"}


Set-ADOrganizationalUnit -Identity "OU=UserAccounts,OU=DataAnalysis,DC=tempcsd,DC=syscom" -ProtectedFromAccidentalDeletion $false


## remove
Set-ADOrganizationalUnit -Identity "OU=UserAccounts,OU=DataAnalysis,DC=tempcsd,DC=syscom" -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU=Reporet,OU=DataAnalysis,DC=tempcsd,DC=syscom" -Confirm:$false # must off Protected

#-------------------------
#    523   ADUser 
#-------------------------
## Get
Get-ADUser -Filter * |select *
Get-ADUser -Filter * |select name,samaccountname,distinguishedname
Get-ADUser ming01 -Properties *  #Login = SamAccountName
<#
PS C:\Users\Administrator> Get-ADUser ming01  -Properties * 
AccountExpirationDate                : 
accountExpires                       : 9223372036854775807
AccountLockoutTime                   : 
AccountNotDelegated                  : False
AllowReversiblePasswordEncryption    : False
AuthenticationPolicy                 : {}
AuthenticationPolicySilo             : {}
BadLogonCount                        : 0
badPasswordTime                      : 0
badPwdCount                          : 0
CannotChangePassword                 : True
CanonicalName                        : tempcsd.syscom/Users/Tseng ming
Certificates                         : {}
City                                 : 
CN                                   : Tseng ming
codePage                             : 0
Company                              : 
CompoundIdentitySupported            : {}
Country                              : 
countryCode                          : 0
Created                              : 8/26/2015 11:11:55 PM
createTimeStamp                      : 8/26/2015 11:11:55 PM
Deleted                              : 
Department                           : 
Description                          : 
DisplayName                          : Tseng ming
DistinguishedName                    : CN=Tseng ming,CN=Users,DC=tempcsd,DC=syscom
Division                             : 
DoesNotRequirePreAuth                : False
dSCorePropagationData                : {8/27/2015 1:31:46 PM, 8/26/2015 11:11:55 PM, 1/1/1601 8:00:01 AM}
EmailAddress                         : 
EmployeeID                           : 
EmployeeNumber                       : 
Enabled                              : True
Fax                                  : 
GivenName                            : ming
HomeDirectory                        : 
HomedirRequired                      : False
HomeDrive                            : 
HomePage                             : 
HomePhone                            : 
Initials                             : 
instanceType                         : 4
isDeleted                            : 
KerberosEncryptionType               : {}
LastBadPasswordAttempt               : 
LastKnownParent                      : 
lastLogoff                           : 0
lastLogon                            : 0
LastLogonDate                        : 
LockedOut                            : False
logonCount                           : 0
LogonWorkstations                    : 
Manager                              : 
MemberOf                             : {}
MNSLogonAccount                      : False
MobilePhone                          : 
Modified                             : 8/26/2015 11:11:55 PM
modifyTimeStamp                      : 8/26/2015 11:11:55 PM
msDS-User-Account-Control-Computed   : 0
Name                                 : Tseng ming
nTSecurityDescriptor                 : System.DirectoryServices.ActiveDirectorySecurity
ObjectCategory                       : CN=Person,CN=Schema,CN=Configuration,DC=tempcsd,DC=syscom
ObjectClass                          : user
ObjectGUID                           : d365497a-cc36-43e1-bcf2-49303f0d3bee
objectSid                            : S-1-5-21-2468440410-1141623422-109008057-1114
Office                               : 
OfficePhone                          : 
Organization                         : 
OtherName                            : 
PasswordExpired                      : False
PasswordLastSet                      : 8/26/2015 11:11:55 PM
PasswordNeverExpires                 : True
PasswordNotRequired                  : False
POBox                                : 
PostalCode                           : 
PrimaryGroup                         : CN=Domain Users,CN=Users,DC=tempcsd,DC=syscom
primaryGroupID                       : 513
PrincipalsAllowedToDelegateToAccount : {}
ProfilePath                          : 
ProtectedFromAccidentalDeletion      : False
pwdLastSet                           : 130850755157272502
SamAccountName                       : ming01
sAMAccountType                       : 805306368
ScriptPath                           : 
sDRightsEffective                    : 15
ServicePrincipalNames                : {}
SID                                  : S-1-5-21-2468440410-1141623422-109008057-1114
SIDHistory                           : {}
SmartcardLogonRequired               : False
sn                                   : Tseng
State                                : 
StreetAddress                        : 
Surname                              : Tseng
Title                                : 
TrustedForDelegation                 : False
TrustedToAuthForDelegation           : False
UseDESKeyOnly                        : False
userAccountControl                   : 66048
userCertificate                      : {}
UserPrincipalName                    : ming01@tempcsd.syscom
uSNChanged                           : 12830
uSNCreated                           : 12824
whenChanged                          : 8/26/2015 11:11:55 PM
whenCreated                          : 8/26/2015 11:11:55 PM
#>


$SearchBase=(Get-ADDomain |select UsersContainer).UsersContainer
Get-ADUser -Filter * -SearchBase $SearchBase

#
Get-ADUser -Filter {name -like "sql*"} | select name,surname,DistinguishedName
Get-ADUser -Filter {EmailAddress -like "*"}
Get-ADUser -Filter {mail -like "*"}
-or-
Get-ADObject -Filter {(mail -like "*") -and (ObjectClass -eq "user")}

$SearchBase ="OU=Report,OU=DataAnalysis,DC=tempcsd,DC=syscom"
$SearchBase ="CN=users,DC=tempcsd,DC=syscom"
Get-ADUser -Filter * -SearchBase $SearchBase

Get-ADUser -Filter 'Name -like "*ming"' | FT Name,SamAccountName -A


## New
New-ADUser ericTasi -SamAccountName "acc1" -GivenName "蔡" -Surname "運生" -DisplayName "蔡運生" -Path 'OU=Accounting,DC=tempcsd,DC=syscom' `
-PasswordNeverExpires $false  -OtherAttributes @{'msDS-PhoneticDisplayName'="Eric"}

New-ADUser 翁家宏 -SamAccountName "acc2" -GivenName "翁" -Surname "家宏" `-DisplayName "翁家宏" -Path 'CN=Users,DC=tempcsd,DC=syscom' `
-OtherAttributes @{'msDS-PhoneticDisplayName'="Eric"}

## SET


## Delete
Remove-ADUser -Identity acc1  -Confirm:$false


##  Add users  using CSV
#   using Quest activeRoles  Management Shell for Active Directory

$MSIFilePath='C:\Demo\ActiveDirectory\PowerShell\'
#$MSIFilePath="C:\Content Packs\Packs\Active Directory Demo 15.2.3\Demo\PowerShell\"
cmd /c $MSIFilePath"ActiveRolesManagmentShell_x64.msi /quiet"

Add-PSSnapin Quest.ActiveRoles.ADManagement


csv example :　H:\Microsoft\BI2015_ContentPackDemo\Active Directory Demo 15.2.3\Demo\Scripts
# Connect to AD, Create OU and Save
$ErrorActionPreference = "continue"
try
{
	$domainObj = [ADSI] "LDAP://localhost:389/ DC=tempcsd, DC=syscom" 
	$domainGroup = $domainObj.Create("organizationalUnit", "ou=Employees")
	$domainGroup.SetInfo()
}	
catch
{
    Write-Host "*** Exception ***"
	Write-Host "OU Already Exists: " $domainGroup
}

# set a temporary password, Accounts will be created but they will be "Disabled" accounts. 
$Password='pass@word1'

# Loop through EACH item in the list (Header row is treated as variable names by default)
$(Get-Date -format "dd/MM/yy HH:mm:ss") + ': Adding Users.' | Out-File $LOGFilePath -append

FOREACH ($USER in (IMPORT-CSV $CSVFilePath))
{
	try
	{
		# CSV Column Headers of Employees.csv A standard csv from county will be given with 6 Headers
		$FirstName=$USER.givenName
		$LastName=$USER.sn
		$JobTitle=$USER.gname
		$Department=$USER.department
		$Username=$USER.uname
		$Password=$USER.ctPassword
		$Title=$JobTitle
		$Office=''
		$Email=$Username+'@tempcsd.syscom'
		$Extension=''
		$Mobile=''
		$Address=''
		$City=''
		$StateProv=''
		$PostalZip=''
		$Country=''
		$ImmediateSupervisor=''
		# Example: $HomeDirectory='\\DEMO2013a\Homes$\'+$Username
		$HomeDirectory=''
		$HomeDrive=''
		# Example: $ProfilePath=''+$Username
		$ProfilePath=''
		$LogonScript=''
		$Domain='tempcsd.syscom'
		$UPN=$Username+'@'+$Domain
		$DisplayName=$FirstName+''+' '+$LastName
		$Company='Syscom'
		$PhoneNumber='555-1212 831 885 + '+$Extension
		$Web='http://tempcsd.syscom'
		$Description=$FirstName+' '+$LastName+' belongs to the '+$JobTitle+' group and joined the school in '+$Department+'.'
		$Fax=''

		# SAM USERID cannot be greater than 20 characters so trim away - LEGACY!
		$SAM=(($Username+'                    ').Substring(0,20)).Trimend()

		# Check to see if the user already exists. If it does add it to an error log and then continue with the next user.If it doesn't then add the user and loop.
		$count = Get-QADUser -SamAccountName $SAM | Measure-Object
		if ($count.count -ne 0) 
		{
			Write-Host 'The user'$SAM' failed. The user already exists!'
			$(Get-Date -format "dd/MM/yy HH:mm:ss") + ': The user ' + $SAM + ' failed. The user already exists!' | Out-File $LOGFilePath -append
		}
		else 
		{
			# Create user.
			NEW-QADUSER -ParentContainer 'OU=Employees,DC=tempcsd,DC=syscom' -Name $DisplayName -UserPassword $Password -City $City -Company $Company -Department $Department -email $Email -FAX $Fax -Firstname $FirstName -Lastname $LastName -Mobilephone $MobilePhone -Office $Office -Phonenumber $PhoneNumber -Postalcode $PostalZip -samaccountname $SAM -StateorProvince $StateProv -StreetAddress $Address -Title $JobTitle -UserPrincipalName $UPN -webpage $Web -Description $Description -displayname $DisplayName -HomeDirectory $HomeDirectory -HomeDrive $HomeDrive -ProfilePath $ProfilePath -LogonScript $LogonScript
			$(Get-Date -format "dd/MM/yy HH:mm:ss") + ': The user ' + $SAM + ' succeeded.' | Out-File $LOGFilePath -append
		}
	}
	catch
	{
		Write-Host "*** Exception Handler ***"
		Write-Host "Problem username: " $USER.uname
	}
}


#-------------------------
#   669  Move-ADObject user to OU
#-------------------------

#
Move-ADObject -Identity "OU=ManagedGroups,DC=Fabrikam,DC=Com" -TargetPath "OU=Managed,DC=Fabrikam,DC=Com"
Move-ADObject "8d0bcc44-c826-4dd8-af5c-2c69dd960fbd47" -TargetPath "OU=Managed,DC=Fabrikam,DC=Com"
Move-ADObject "8d0bcc44-c826-4dd8-af5c-dd" -TargetPath "1c2ea8a8-c2b7-4a87-8190-0e8a166aee16"
Move-ADObject -Identity "CN=Peter Bankov,OU=Accounting,DC=Fabrikam,DC=com" -TargetPath "OU=Accounting,DC=Europe,DC=Fabrikam,DC=com" -TargetServer "server01.europe.fabrikam.com"
Move-ADObject -Identity "CN=AccountLeads,DC=AppNC" -TargetPath "OU=AccountDeptOU,DC=AppNC" -server "FABRIKAM-SRV1:60000"

$usern=(Get-ADUser acc2).DistinguishedName
$OUn=(Get-ADOrganizationalUnit -Filter  {name  -eq 'Accounting'}).distinguishedname
Move-ADObject -Identity $usern -TargetPath $OUn

#-------------------------
#  699  ADGroupMember
#-------------------------

#set
get-adgroup  -filter {GroupScope -eq "DomainLocal"} -SearchBase "DC=AppNC" | get-adgroupmember -partition "DC=AppNC"


get-adgroupmember -Identity administrators 


(Get-ADGroup -Filter {name -like  'BI*'}) |select  DistinguishedName, Name 
$groupn=(Get-ADGroup -Filter {name -eq 'BI EndUser Group'}).DistinguishedName
get-adgroupmember -Identity $groupn

# New 
Add-ADGroupMember
    #Adds the user "CN=Glen John,OU=UserAccounts" from the North America domain to the group "CN=AccountLeads,OU=UserAccounts" in the Europe domain.
    $user = Get-ADUser "CN=Glen John,OU=UserAccounts,DC=NORTHAMERICA,DC=FABRIKAM,DC=COM" –Server "northamerica.fabrikam.com";
    $group = Get-ADGroup "CN=AccountLeads,OU=UserAccounts,DC=EUROPE,DC=FABRIKAM,DC=COM" –Server "europe.fabrikam.com";
    Add-ADGroupMember $group –Member $user –Server "europe.fabrikam.com"

#example  : make acc2 to  accounting group 
Get-ADUser -Filter * |select name ,SamAccountName
$usern =Get-ADUser -Filter 'SamAccountName -like "*acc2"' | FT Name,SamAccountName -A
$usern =(Get-ADUser -Filter 'SamAccountName -like "*acc2"').DistinguishedName
$groupn=(Get-ADGroup -Filter {name -eq 'BI EndUser Group'}).DistinguishedName
Add-ADGroupMember $groupn –Member $usern 
get-ADGroupMember accounting 

get-adgroupmember -Identity $groupn



#-------------------------
#  734 ADAccountPassword  password Aug.29.2015
#-------------------------
Set-ADAccountPassword 'CN=Jeremy Los,OU=Accounts,DC=Fabrikam,DC=com' -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)
Set-ADAccountPassword -Identity tmakovec -OldPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) -NewPassword (ConvertTo-SecureString -AsPlainText "qwert@12345" -Force)
Set-ADAccountPassword -Identity saradavi
$newPassword = (Read-Host -Prompt "Provide New Password" -AsSecureString); Set-ADAccountPassword -Identity mollyd -NewPassword $newPassword -Reset
set-adaccountpassword "CN=Molly Dempsey,OU=AccountDeptOU,DC=AppNC" -server "dsp13a24:60000"

#-------------------------
#  747 ADAccount   Aug.29.2015
#-------------------------

## Disable-ADAccount

Disable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedName
Disable-ADAccount -Identity "CN=Kim Abercrombie,OU=Finance,OU=UserAccounts,DC=FABRIKAM,DC=COM"

## 
enable-ADAccount


Enable-ADAccount 
##Search-ADAccount 
Search-ADAccount -AccountDisabled | FT Name,ObjectClass -A


Search-ADAccount -AccountDisabled -UsersOnly | FT Name,ObjectClass -A
Search-ADAccount -AccountExpired | FT Name,ObjectClass -A
Search-ADAccount -AccountExpiring -TimeSpan 6.00:00:00 | FT Name,ObjectClass -A
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 | FT Name,ObjectClass -A
Search-ADAccount -PasswordExpired | FT Name,ObjectClass -A

##Unlock-ADAccount 







#-------------------------
#  781  How to configure a firewall for domains and trusts.  Aug.29.2015
#-------------------------
https://support.microsoft.com/zh-tw/kb/179442


<NT>
Windows NT

在此環境中，一方的信任是 Windows NT 4.0 信任，或信任已經建立使用 NetBIOS 名稱。
用戶端連接埠	伺服器連接埠	服務
137/UDP	137/UDP	NetBIOS 名稱
138/UDP	138/UDP	NetBIOS Netlogon 及瀏覽
1024-65535/TCP	139/TCP	NetBIOS 的工作階段
1024-65535/TCP	42/TCP	WINS 複寫


<Windows Server 2003 和 Windows 2000 Server>
用戶端連接埠	伺服器連接埠	服務
1024-65535/TCP	135/TCP	RPC 端點對應程式
1024-65535/TCP	1024-65535/TCP	LSA，SAM，Netlogon (*) 的 RPC
1024-65535/TCP/UDP	389/TCP/UDP	LDAP
1024-65535/TCP	636/TCP	LDAP SSL
1024-65535/TCP	3268/TCP	LDAP GC
1024-65535/TCP	3269/TCP	LDAP GC SSL
53,1024-65535/TCP/UDP	53/TCP/UDP	DNS
1024-65535/TCP/UDP	88/TCP/UDP	Kerberos
1024-65535/TCP	445/TCP	SMB
1024-65535/TCP	1024-65535/TCP	FRS RPC (*)

<Windows Server 2008 和 Windows Server 2008 R2>
用戶端連接埠	伺服器連接埠	服務
49152-65535/UDP	        123/UDP	W32Time
49152-65535/TCP	        135/TCP	RPC 端點對應程式
49152-65535/TCP	        464/TCP/UDP	Kerberos 密碼變更
49152-65535/TCP	        49152-65535/TCP	LSA，SAM，Netlogon (*) 的 RPC
49152-65535/TCP/UDP 	389/TCP/UDP	LDAP
49152-65535/TCP	        636/TCP	LDAP SSL
49152-65535/TCP	        3268/TCP	LDAP GC
49152-65535/TCP	        3269/TCP	LDAP GC SSL
53、 49152-65535/TCP/UDP	53/TCP/UDP	DNS
49152-65535/TCP	        49152-65535/TCP	FRS RPC (*)
49152-65535/TCP/UDP	    88/TCP/UDP	Kerberos
49152-65535/TCP/UDP	    445/TCP	SMB
49152-65535/TCP	        49152-65535/TCP	DFSR RPC (*)

<Active Directory>
在 Windows 2000 和 Windows XP 中，網際網路控制訊息通訊協定 (ICMP) 必須允許透過防火牆從用戶端的網域控制站，以便穿越防火牆 Active Directory 群組原則用戶端可以正確運作。

在 Windows Server 2008 和更新版本中，網路位置感知服務會提供與網路上的其他工作站根據流量的頻寬估計。

Windows 重新導向器也會使用 ICMP 來確認伺服器的 IP 解決 DNS 服務，並在進行連線之前，當伺服器位於使用 DFS。

如果您想要降低 ICMP 流量，您可以使用下列的範例防火牆規則:
<any> ICMP -> DC IP addr = allow

不像 TCP 通訊協定層級和 UDP 通訊協定層級，ICMP 並沒有連接埠號碼。

預設情況下，Windows Server 2003 和 Windows 2000 伺服器的 DNS 伺服器會使用暫時的用戶端連接埠，當他們所查詢其他 DNS 伺服器。不過，這種行為可能會變更的特定登錄設定。如需詳細資訊，請參閱 Microsoft 知識庫文件 260186: 傳送埠的 DNS 登錄機碼未如預期般運作

如需有關 Active Directory 及防火牆設定的詳細資訊，請參閱防火牆分段網路中的 Active Directory Microsoft 的白皮書。
用戶端連接埠	伺服器連接埠	通訊協定
1024-65535/TCP	1723/TCP	PPTP
此外，您必須啟用 IP 通訊協定 47 (GRE)。
