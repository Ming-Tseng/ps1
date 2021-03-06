
<#  SP01_installconfg  C:\Users\administrator.CSD\SkyDrive\download\PS1\SP01_installconfg.ps1 \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\SP01_installconfg.ps1 auther : ming_tseng    a0921887912@gmail.com createData : Mar.06.2014 history : Sep.04.2014  object :   $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SP01_installconfg.ps1

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
}#>

ASNP Microsoft.SharePoint.Powershell  

iisreset /start

$env:computername
$env:APPDATA    #C:\Users\administrator.CSD\AppData\Roaming
$env:USERDNSDOMAIN  #CSD.SYSCOM
$env:USERDOMAIN_ROAMINGPROFILE   #CSD
$env:USERNAME     #Administrator
$env:CLIENTNAME    #my remote name  ex : W2K8R2-2013
$env:PUBLIC      #C:\Users\Public
$env:ComSpec     #C:\Windows\system32\cmd.exe
$env:HOMEDRIVE   #c
$env:USERPROFILE    #C:\Users\administrator.CSD
$env:Path






# 01   50  Check Sharepoint software appwiz.cpl
# 02  150  Find Your SharePoint Version
# 03  184  get-PsSnapIn 
# 04  204  $profile
#  05       install  using Powershell  ASNP Microsoft.SharePoint.Powershell 
#  06 250 configuration using Powershell   SPShellAdmin  無法存取本機伺服陣列。未登錄具有 FeatureDependencyId 的 Cmdlet
# 07  330  SharePoint Services for OS
# 08  400  IIS Servcies
# 09  440  get-command *get-SP*
# 10  440  伺服器陣列的所有伺服器   status   gh Get-SPServer  -full
# 11  440  get-SPDatabase
# 12  450  Manage services on server  for Sharepoint  SPServiceInstance
# 13  500  服務應用程式集區  Service Application Pool
# 14  547  SP  Service   Application  Get-SPServiceApplication   Proxy
# 15  561  Install and Download SharePoint 2013 prerequisites offline
#     719  Install-SP2013RolesFeatures.ps1
#    1025  install sharepoint at WFE
#    1039  SPWebTemplate
#    1206  Add or remove blocked file types
#    1409   SPManagedAccount
#    1413   SPServiceApplicationPool
#  1471   IncludeCentralAdministration 
#  1478    update to  Sharepoint sp1
#  1489   regedit  spfarm  login 
##  1650  after configuration Wizard  don't  run wizard now
##  1671  SP Check List all




Get-WindowsFeature



#----------------------------
# 01   50  Check Sharepoint software appwiz.cpl
#----------------------------
{<#$PSVersionTable
'Name                           Value                                                                                                                            
----                           -----                                                                                                                            
PSVersion                      3.0                                                                                                                              
WSManStackVersion              3.0                                                                                                                              
SerializationVersion           1.1.0.1                                                                                                                          
CLRVersion                     4.0.30319.17929                                                                                                                  
BuildVersion                   6.2.9200.16384                                                                                                                   
PSCompatibleVersions           {1.0, 2.0, 3.0}                                                                                                                  
PSRemotingProtocolVersion      2.2   '
gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
gwmi  Win32_Product | ? name -Like '*SQL Server*' |select name,Version |sort name

gwmi -Class Win32_Product | ?  {$_.Name -like  "*SharePoint*"}  |select name,Version |sort name
gwmi -Class Win32_Product | ?  {$_.Name -like  "*SQL*"} |select name,Version |sort name
gsv -displayname '*sql*' |select DisplayName
'
#29
name                                                                  Version                                                              
----                                                                  -------                                                              
Microsoft SharePoint 2010 Administration Toolkit                      14.0.5139.5001                                                       
Microsoft SharePoint Foundation 2013 1033 Lang Pack                   15.0.4420.1017                                                       
Microsoft SharePoint Foundation 2013 1033 SQL Express                 15.0.4420.1017                                                       
Microsoft SharePoint Foundation 2013 Core                             15.0.4420.1017                                                       
Microsoft SharePoint Multilingual Solutions                           15.0.4420.1017                                                       
Microsoft SharePoint Multilingual Solutions English Language Pack     15.0.4420.1017                                                       
Microsoft SharePoint Portal                                           15.0.4420.1017                                                       
Microsoft SharePoint Portal English Language Pack                     15.0.4420.1017                                                       
Microsoft SharePoint Server 2013                                      15.0.4420.1017                                                       
PerformancePoint Services for SharePoint                              15.0.4420.1017                                                       
PerformancePoint Services in SharePoint 1033 Language Pack            15.0.4420.1017                                                       

#61
gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name


name                                                                             Version                                                                        
----                                                                             -------                                                                        
1 Microsoft SharePoint Foundation 2013 1033 Lang Pack                              15.0.4420.1017                                                                 
2 Microsoft SharePoint Foundation 2013 1033 SQL Express                            15.0.4420.1017                                                                 
3 Microsoft SharePoint Foundation 2013 Core                                        15.0.4420.1017                                                                 
4 Microsoft SharePoint Multilingual Solutions                                      15.0.4420.1017                                                                 
5 Microsoft SharePoint Multilingual Solutions English Language Pack                15.0.4420.1017                                                                 
6 Microsoft SharePoint Portal                                                      15.0.4420.1017                                                                 
7 Microsoft SharePoint Portal English Language Pack                                15.0.4420.1017                                                                 
8 Microsoft SharePoint Server 2013                                                 15.0.4420.1017                                                                 
9 PerformancePoint Services for SharePoint                                         15.0.4420.1017                                                                 
10PerformancePoint Services in SharePoint 1033 Language Pack                       15.0.4420.1017                                                                 

11SQL Server 2014 RS_SharePoint_SharedService                                      12.0.2000.8                                                                    
12適用於 SharePoint 的 Microsoft SQL Server 2014 RS 增益集                                12.0.2000.8                                                                    


#& uninstallation from  appwiz.cpl
gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name

PS C:\Users\administrator.CSD> gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name

name                                                                             Version                                                                        
----                                                                             -------                                                                        
SQL Server 2014 RS_SharePoint_SharedService                                       12.0.2000.8                                                                    
適用於 SharePoint 的 Microsoft SQL Server 2014 RS 增益集                            12.0.2000.8                                                                    


##194
name                                                                             Version                                                                        
----                                                                             -------                                                                        
Microsoft SharePoint Designer 2013                                               15.0.4420.1017                                                                 
Microsoft SharePoint Designer MUI (English) 2013                                 15.0.4420.1017 
                                                                
Microsoft SharePoint Foundation 2013 1033 Lang Pack                              15.0.4420.1017                                                                 
Microsoft SharePoint Foundation 2013 1033 SQL Express                            15.0.4420.1017                                                                 
Microsoft SharePoint Foundation 2013 Core                                        15.0.4420.1017                                                                 
Microsoft SharePoint Multilingual Solutions                                      15.0.4420.1017                                                                 
Microsoft SharePoint Multilingual Solutions English Language Pack                15.0.4420.1017                                                                 
Microsoft SharePoint Portal                                                      15.0.4420.1017                                                                 
Microsoft SharePoint Portal English Language Pack                                15.0.4420.1017                                                                 
Microsoft SharePoint Server 2013                                                 15.0.4420.1017                                                                 
PerformancePoint Services for SharePoint                                         15.0.4420.1017                                                                 
PerformancePoint Services in SharePoint 1033 Language Pack                       15.0.4420.1017 

'

#>}

#----------------------------
# 02  150  Find Your SharePoint Version
#----------------------------

{
ASNP Microsoft.SharePoint.Powershell
(Get-SPFarm).Products
'

08460AA2-A176-442C-BDCA-26928704D80B  Search Server 2010
1328E89E-7EC8-4F7E-809E-7E945796E511  Search Server Express 2010
35466B1A-B17B-4DFB-A703-F74E2A1F5F5E  Project Server 2013
3FDFBCC8-B3E4-4482-91FA-122C6432805C  SharePoint Server 2010 Standard
84902853-59F6-4B20-BC7C-DE4F419FEFAD  Project Server 2010 Trial
88BED06D-8C6B-4E62-AB01-546D6005FE97  SharePoint Server 2010 Enterprise Trial
926E4E17-087B-47D1-8BD7-91A394BC6196  Office Web Applications 2010
>9FF54EBC-8C12-47D7-854F-3865D4BE8118  SharePoint Foundation 2013
B2C0B444-3914-4ACB-A0B8-7CF50A8F7AA0  SharePoint Server 2010 Standard Trial
>B7D84C2B-0754-49E4-B7BE-7EE321DCE0A9  SharePoint Server 2013 Enterprise
BC4C1C97-9013-4033-A0DD-9DC9E6D6C887  Search Server 2010 Trial
BC7BAF08-4D97-462C-8411-341052402E71  Project Server 2013 Preview
BEED1F75-C398-4447-AEF1-E66E1F0DF91E  SharePoint Foundation 2010
C5D855EE-F32B-4A1C-97A8-F0A28CE02F9C  SharePoint Server 2013 Standard
D5595F62-449B-4061-B0B2-0CBAD410BB51  SharePoint Server 2010 Enterprise
D6B57A0D-AE69-4A3E-B031-1F993EE52EDC  Microsoft Office Web Apps Server 2013
ED21638F-97FF-4A65-AD9B-6889B93065E2  Project Server 2010

298a586a-e3c1-42f0-afe0-4bcfdc2e7cd0 SharePoint Server 2013 Enterprise Preview
'
}

#----------------------------
# 03 184 get-PsSnapIn 
#----------------------------
{
get-PsSnapIn
Get-Module
'
Name        : Microsoft.PowerShell.Core
PSVersion   : 3.0
Description : This Windows PowerShell snap-in contains cmdlets used to manage components of Windows PowerShell.

Name        : Microsoft.SharePoint.PowerShell
PSVersion   : 1.0
Description : Register all administration Cmdlets for Microsoft SharePoint Server
'

Add-PsSnapIn Microsoft.SharePoint.PowerShell

#migration to spGet-SPServiceInstance.ps1
}
#----------------------------
#  04 204  $profile
#----------------------------
{Test-Path $profile

New-Item -path $profile -type file -force
notepad $profile
##Reload-Profile 
. $profile
<# ####################################################  
#dir env:\
#$env:COMPUTERNAME
#. $profile
Set-Alias gh  Get-Help

function stf {"StartTime  " + (get-date)};Set-Alias st stf
function ttf {"Stop Time  " + (get-date)};Set-Alias tt ttf 
function tt1 {"Stop Time  " + (get-date)};Set-Alias t1 tt1 

#function FindDefaultPrinter
#{
#   Get-WMIObject -query "Select * From Win32_Printer Where Default = TRUE"
#}


Set-Alias excel "C:\Program Files\Microsoft Office\Office12\Excel.exe"

#$NIC=Get-WmiObject Win32_NetworkAdapterConfiguration


if ( get-PsSnapIn | ? { $_.name  -eq  "Microsoft.sharepoint.PowerShell"} )
{write 'SharePoint.PowerShell loaded' } 
    else
{Add-PsSnapIn Microsoft.SharePoint.PowerShell } 


write "Reload Profile Finish "
#########################################>

}

#-----------------------------------------------
#  05  install  using Powershell  ASNP Microsoft.SharePoint.Powershell 
#-----------------------------------------------
  pre-install
  NQTMW-K63MQ-39G6H-B2CH9-FRDWJ (Trial)
  P4GN7-G2J3K-XPQYT-XG4J4-F6WFV (M3)

#-----------------------------------------------
#  06 250 configuration using Powershell   SPShellAdmin  無法存取本機伺服陣列。未登錄具有 FeatureDependencyId 的 Cmdlet
#-----------------------------------------------
{

ASNP Microsoft.SharePoint.Powershell  

'無法存取本機伺服陣列。未登錄具有 FeatureDependencyId 的 Cmdlet'

https://technet.microsoft.com/zh-tw/library/ff607596(v=office.14).aspx
Get-SPShellAdmin
Add-SPShellAdmin -UserName pmocsd\administrator
Remove-SPShellAdmin

Clear-Host

ping SPM
ping SPDB
telnet SPDB 1433
telnet SPM 1433
cmd

# Values mentioned below needs to be edited
$DatabaseServer = "SPDB"; #SPecify the instance name if SQL is not installed on default instance$FarmName = "194SP"; #IP+SP$ConfigDB = $FarmName+"_ConfigDB";$AdminContentDB = $FarmName+"_CentralAdminContent";$Passphrase = convertto-securestring "p@ssw0rdx" -asplaintext -force;$Port = "2013";$Authentication = "NTLM";$FarmAccount = "csd\administrator"
############################################################################ DO NOT EDIT ANYTHING BELOW THIS LINE ###############################################################################
#Start Loading SharePoint Snap-in
$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}

# END Loading SharePoint Snapin# checking to see if SharePoint Binaries are installed

IF((Get-WmiObject -Class Win32_Product | Where {$_.Name -eq "Microsoft SharePoint Server 2013 "}) -ne $null){"Found SharePoint Server 2013 Binaries. Will create Farm now"New-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer `-FarmCredentials (Get-Credential $farmAccount) -Passphrase $Passphrase `-AdministrationContentDatabaseName $AdminContentDB#Disconnect-SPConfigurationDatabase -Confirm:$falseget-help Disconnect-SPConfigurationDatabase -fullRemove-PSSnapin Microsoft.SharePoint.PowerShellAdd-PSSnapin Microsoft.SharePoint.PowerShellInstall-SPHelpCollection -All"Installed Help Collection"Get-help Install-SPHelpCollection  -fullInitialize-SPResourceSecurity"Initialized SP Resource Security"Install-SPService"Instaled Ssp service"Install-SPFeature -AllExistingFeatures"Installed SP Feature"#Uninstall-SPFeature -AllExistingFeatures#get-help Uninstall-SPFeature -fullGet-SPFeatureNew-SPCentralAdministration -Port $Port"Created Central Administration Site"Install-SPApplicationContent"Installed Application Content. This was the last step.Farm Configuration Complete!"
}
ELSE {"SP Binaries not found"}

#Start Central Administration
Write-Output "Starting Central Administration"& 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\BIN\psconfigui.exe' -cmd showcentraladmin

}


#-----------------------------------------------
#  07  330  SharePoint Services for OS
#-----------------------------------------------
{
########  Get 
gsv| ?{$_.DisplayName -like '*SharePoint*'}|select Name |sort name
gsv SP*

'Status   Name               DisplayName                           
------   ----               -----------                           
Stopped  DCLauncher15       Document Conversions Launcher for M...
Stopped  DCLoadBalancer15   Document Conversions Load Balancer ...
Stopped  OSearch15          SharePoint Server Search 15           
Running  SPAdminV4          SharePoint Administration             
Stopped  SPSearchHostCon... SharePoint Search Host Controller     
Running  SPTimerV4          SharePoint Timer Service              
Running  SPTraceV4          SharePoint Tracing Service            
Stopped  SPUserCodeV4       SharePoint User Code Host             
Stopped  SPWriterV4         SharePoint VSS Writer 
'
#Name of server where you are running the script
$Services = "OSearch15", "SPAdminV4","SPSearchHostController", "SPTimerV4", "SPTraceV4", "SPUserCodeV4", "SPWriterV4"
#$server = "shop-01-FE"

######## Stop all 
foreach ($ServiceName in $Services){#p.20

if ($ServiceName.Status -eq 'Running')
{ $ServiceName.stop()
}

}#p.20


######## Start all 
foreach ($ServiceName in $Services){#p.29
if ($ServiceName.Status -eq 'Stopped')
{ $ServiceName.Start()
}
}#p.29


cliconfg

$server =$env:COMPUTERNAME

$SPSearchHostController=Get-Service | ?{$_.Name -like 'SPSearchHostController'}
$SPSearchHostController.Start();$SPSearchHostController.Refresh();$SPSearchHostController.Status
if ($SPSearchHostController.Status -eq 'Running')
{ $SPSearchHostController.stop()
echo  $SPSearchHostController.Name  'is Stop Now'
}

SPSearchHostController

$SPTraceV4=Get-Service | ?{$_.Name -like 'SPTraceV4'}
$SPTraceV4.Start();$SPTraceV4
if ($SPTraceV4.Status -eq 'Running')
{ $SPTraceV4.stop()
echo  $SPTraceV4.Name  'is Stop Now'
}

$SPTimerV4=Get-Service | ?{$_.Name -like 'SPTimerV4'};$SPTimerV4.Start()
if ($SPTimerV4.Status -eq 'Running')
{ $SPTimerV4.stop()
echo  $SPTimerV4.Name  'is Stop Now'
$SPTimerV4.Status
}

$SPAdminV4=Get-Service | ?{$_.Name -like 'SPAdminV4'}
$SPAdminV4.Start();$SPAdminV4

if ($SPAdminV4.Status -eq 'Running')
{ $SPAdminV4.stop()
echo  $SPAdminV4.Name  'is Stop Now'
$SPAdminV4.Refresh()
$SPAdminV4.Status
}

}


#-----------------------------------------------
# 08  400 IIS Servcies
#-----------------------------------------------
{
$W3SVC=Get-Service | ?{$_.Name -eq 'W3SVC'}

##Stop
if($W3SVC.status -eq 'Running' ){$W3SVC.stop();$W3SVC.Refresh();$W3SVC.status} ;$W3SVC.Refresh();$W3SVC.status

##start
if($W3SVC.status -eq 'Stopped' ){$W3SVC.start();$W3SVC.Refresh();$W3SVC.status} ;$W3SVC.Refresh();$W3SVC.status



$IISADMIN=Get-Service | ?{$_.Name -like 'IISADMIN*'}
$IISADMIN.stop()
$IISADMIN.start()
}
#----------------------------
## 09   440 get-command *get-SP*
#----------------------------
(get-command *get-SP*).count    ; 188  ,198 , 206

#----------------------------
##  10  440 伺服器陣列的所有伺服器   status   gh Get-SPServer  -full
#----------------------------
Get-SPServer | select Name ,role,status      | ft -auto    
Get-SPServer |gm ; Get-SPServer | Where{ $_.NeedsUpgrade -eq $TRUE}


#------------------------------------------- 
# 11 440  get-SPDatabase
#-------------------------------------------

{
Get-SPDatabase |select name,type

Get-SPContentDatabase  –WebApplication "SP"
Mount-SPContentDatabase –Name "NewContentDB" –WebApplication "PSWebApp"
}

#-------------------------------------------
# 12  450  Manage services on server  for Sharepoint  SPServiceInstance
#-------------------------------------------

{
whoami

Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto
Get-SPServiceInstance -Server  $env:COMPUTERNAME   | ? typename -like "*secure*"
Get-SPServiceInstance |select typename,Status |sort TypeName
'count=30
01 Access Database Service 2010                                   Disabled
02 Access Services                                                Disabled   newServiceApplication
03 App Management Service                                         Disabled   newServiceApplication
04 Business Data Connectivity Service                             Disabled   newServiceApplication
05 Central Administration                                           Online   29,194
06 Claims to Windows Token Service                                Disabled
07 Distributed Cache                                              Disabled    194
08 Document Conversions Launcher Service                          Disabled
09 Document Conversions Load Balancer Service                     Disabled
10 Excel Calculation Services                                     Disabled    newServiceApplication
11 Lotus Notes Connector                                          Disabled
12 Machine Translation Service                                    Disabled    newServiceApplication
13 Managed Metadata Web Service                                   Disabled    newServiceApplication
14 Microsoft SharePoint Foundation Incoming E-Mail                Disabled  194
15 Microsoft SharePoint Foundation Sandboxed Code Service         Disabled
16 Microsoft SharePoint Foundation Subscription Settings Service  Disabled
17 Microsoft SharePoint Foundation Web Application                  Online  29,194
18 Microsoft SharePoint Foundation Workflow Timer Service         Disabled  194
19 PerformancePoint Service                                       Disabled    newServiceApplication
20 PowerPoint Conversion Service                                  Disabled
21 Request Management                                             Disabled
22 Search Host Controller Service                                 Disabled
23 Search Query and Site Settings Service                         Disabled
24 Secure Store Service                                           Disabled    newServiceApplication     v
25 SharePoint Server Search                                       Disabled
26 User Profile Service                                           Disabled    newServiceApplication
27 User Profile Synchronization Service                           Disabled
28 Visio Graphics Service                                         Disabled    newServiceApplication
29 Word Automation Services                                       Disabled    newServiceApplication
30 Work Management Service                                        Disabled    
'
'
PS C:\Windows\system32> Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto

  Status TypeName                                  Id                                  
  ------ --------                                  --                                  
  (*) Online Microsoft SharePoint Foundation Web 應用程式      8200bcb2-3997-4a29-8908-be9d3b788ea7
  (*) Online Microsoft SharePoint Foundation 工作流程計時器服務  2c9ee7e1-589d-4148-be12-cd531c2d7efd
  (*) Online Microsoft SharePoint Foundation 內送電子郵件       e6997d4e-ad9a-4fee-a360-e6751a57237a
  (*)Online 分散式快取                                     18ed1aa2-effc-4638-aaf7-7c3024f3dc27
  (*)Online 管理中心                                      51dc6952-dd56-4d3b-9fb5-eb84b34bc264
Disabled Access Services                           8b407a9b-c1e6-4ce8-acde-32c0ca0e7990
Disabled Access 資料庫服務 2010                         fe291e74-858a-4a2d-a5d7-0c4ae76c009b
Disabled App Management Service                    c9b510ab-6204-4839-983a-b11db6244dd7
Disabled Business Data Connectivity Service        cce6e70e-5fae-4de4-9383-508ebed78630
Disabled Excel Calculation Services                8ee5a10b-7777-4754-b461-ce21d5cfd45e
Disabled Lotus Notes 連接器                           13cc6351-e686-45a9-80b2-c97ba8a29b15
Disabled Machine Translation Service               634ec99a-e032-4aa0-b8cc-dba13f6715ee
Disabled Managed Metadata Web Service              0f35b663-29d1-44c3-b236-16e66e9d4f14
(*)Disabled Microsoft SharePoint Foundation 沙箱化程式碼服務  578e8222-a5ce-4ce3-aa25-e64660e221a4
Disabled Microsoft SharePoint Foundation 訂閱設定服務    2cf57c1d-545d-4ba6-a4bd-9ba4bff91f72
Disabled PerformancePoint Service                  6476146b-0717-4157-b03a-d0efd04d2544
Disabled PowerPoint Conversion Service             da253d8d-3a3d-4741-a3e7-23bed68281df
Disabled Secure Store Service                      d8e55afd-90db-476e-858b-f931cf79ecb3
Disabled SharePoint Server 搜尋                      bc8f4208-0be1-4b25-adcb-72e69293dd92
Disabled User Profile Service                      f0260529-8c47-448d-9b6b-12b306b7b052
Disabled User Profile Synchronization Service      9e9beccd-89c2-4c87-b412-5438438c0d6d
Disabled Visio Graphics Service                    3f9379f0-b5f3-4128-9596-86c191c07a96
Disabled Word Automation Services                  74ddd564-95e4-4949-92ff-88b499853a5d
Disabled Work Management Service                   48c38f6e-0a0f-425f-8d75-bca23b4b783b
Disabled 文件轉換負載平衡器服務                               c1b0994d-79e8-4999-96cc-b58c22234415
Disabled 文件轉換啟動器服務                                 664a26df-6f6c-4ae2-9c72-d0276737273a
(*)Disabled 要求管理                                      41589d67-0b85-4882-9d33-f70000a96e42
Disabled 搜尋主機控制器服務                                 d991e371-c8cb-4ed3-b5f4-e6060bdd1303
Disabled 搜尋查詢和網站設定服務                               319def38-7bc3-441c-a98d-058831bf0093
Disabled 對 Windows Token 服務的宣告                     8efab8a2-b021-490d-90e0-41af65cecb28
'
'
PS C:\Windows\system32> Get-SPServiceInstance -Identity 664a26df-6f6c-4ae2-9c72-d0276737273a |gm


   TypeName: Microsoft.Office.Server.Conversions.LauncherServiceInstance

Name                           MemberType Definition                           
----                           ---------- ----------                           
Clone                          Method     System.Object Clone(), System.Obje...
Delete                         Method     void Delete()                        
EnableService                  Method     void EnableService()                 
Equals                         Method     bool Equals(System.Object obj)       
GetChild                       Method     T GetChild[T](string name), T GetC...
GetHashCode                    Method     int GetHashCode()                    
GetObjectData                  Method     void GetObjectData(System.Runtime....
GetType                        Method     type GetType()                       
Invalidate                     Method     void Invalidate(), void IUpgradabl...
Provision                      Method     void Provision(), void Provision(b...
Start                          Method     void Start()                         
Stop                           Method     void Stop()                          
ToString                       Method     string ToString()                    
Uncache                        Method     void Uncache()                       
Unprovision                    Method     void Unprovision()                   
Update                         Method     void Update(), void Update(bool en...
Upgrade                        Method     void Upgrade(), void Upgrade(bool ...
ValidateBackwardsCompatibility Method     void ValidateBackwardsCompatibility()
CanUpgrade                     Property   bool CanUpgrade {get;}               
Description                    Property   string Description {get;}            
DisplayName                    Property   string DisplayName {get;}            
Farm                           Property   Microsoft.SharePoint.Administratio...
Hidden                         Property   bool Hidden {get;}                   
Id                             Property   guid Id {get;set;}                   
Instance                       Property   string Instance {get;set;}           
IsBackwardsCompatible          Property   Microsoft.SharePoint.TriState IsBa...
LoadBalancerServerId           Property   guid LoadBalancerServerId {get;set;} 
ManageLink                     Property   Microsoft.SharePoint.Administratio...
Name                           Property   string Name {get;set;}               
NeedsUpgrade                   Property   bool NeedsUpgrade {get;set;}         
NeedsUpgradeIncludeChildren    Property   bool NeedsUpgradeIncludeChildren {...
Parent                         Property   Microsoft.SharePoint.Administratio...
Port                           Property   int Port {get;set;}                  
Properties                     Property   hashtable Properties {get;}          
ProvisionLink                  Property   Microsoft.SharePoint.Administratio...
Roles                          Property   System.Collections.Generic.ICollec...
Server                         Property   Microsoft.SharePoint.Administratio...
Service                        Property   Microsoft.SharePoint.Administratio...
SingleServer                   Property   bool SingleServer {get;set;}         
Status                         Property   Microsoft.SharePoint.Administratio...
SystemService                  Property   bool SystemService {get;}            
TypeName                       Property   string TypeName {get;}               
UnprovisionLink                Property   Microsoft.SharePoint.Administratio...
UpgradeContext                 Property   Microsoft.SharePoint.Upgrade.SPUpg...
UpgradedPersistedProperties    Property   hashtable UpgradedPersistedPropert...
Version                        Property   long Version {get;} 
' #gm
'
Get-SPServiceInstance -Identity 664a26df-6f6c-4ae2-9c72-d0276737273a |select *
Port                        : 8082
LoadBalancerServerId        : 00000000-0000-0000-0000-000000000000
SingleServer                : False
TypeName                    : 文件轉換啟動器服務
DisplayName                 : 啟動器服務
ManageLink                  : Microsoft.SharePoint.Administration.SPActionLink
ProvisionLink               : Microsoft.SharePoint.Administration.SPActionLink
Server                      : SPServer Name=WIN-2S026UBRQFO
Service                     : LauncherService Name=DCLauncher15
Instance                    : 
Roles                       : 
Hidden                      : False
SystemService               : False
Description                 : 
UnprovisionLink             : Microsoft.SharePoint.Administration.SPActionLink
CanUpgrade                  : True
IsBackwardsCompatible       : True
NeedsUpgradeIncludeChildren : False
NeedsUpgrade                : False
UpgradeContext              : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                        : 
Id                          : 664a26df-6f6c-4ae2-9c72-d0276737273a
Status                      : Disabled
Parent                      : SPServer Name=WIN-2S026UBRQFO
Version                     : 6945
Properties                  : {}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}
' #select *

'
S C:\Windows\system32> Get-SPServiceInstance |select typename,Service,Status |ft -AutoSize

TypeName                                  Service                                                        Status
--------                                  -------                                                        ------
(V)搜尋主機控制器服務                           SearchRuntimeService Name=SPSearchHostController             Disabled
   App Management Service                    AppManagementService                                         Disabled
   Managed Metadata Web Service              MetadataWebService                                           Disabled
   Access Services                           AccessServicesWebService                                     Disabled
(?)User Profile Synchronization Service      ProfileSynchronizationService Name=FIMSynchronizationService Disabled
   Business Data Connectivity Service        BdcService                                                   Disabled
   要求管理                                   SPRequestManagementService                                   Disabled
   Secure Store Service                      SecureStoreService                                           Disabled
(V)對 Windows Token 服務的宣告                     SPWindowsTokenService Name=c2wts                         Disabled
   (X)Microsoft SharePoint Foundation 工作流程計時器服務 SPWorkflowTimerService Name=spworkflowtimerv4         Online
   PerformancePoint Service                  BIMonitoringService                                          Disabled
(V)Microsoft SharePoint Foundation 沙箱化程式碼服務  SPUserCodeService Name=SPUserCodeV4                     Disabled
   Visio Graphics Service                    VisioGraphicsService                                         Disabled
(v)SharePoint Server 搜尋                      SearchService Name=OSearch15                                 Disabled
(V)文件轉換啟動器服務                                 LauncherService Name=DCLauncher15                            Disabled
(V)文件轉換負載平衡器服務                               LoadBalancerService Name=DCLoadBalancer15                    Disabled
   搜尋查詢和網站設定服務                               SearchQueryAndSiteSettingsService                            Disabled
   Work Management Service                   WorkManagementService                                        Disabled
   (X)Microsoft SharePoint Foundation Web 應用程式  SPWebService                                                   Online
   (X)管理中心                                      SPWebService Name=WSS_Administration                           Online
   Excel Calculation Services                ExcelServerWebService                                        Disabled
   Microsoft SharePoint Foundation 內送電子郵件    SPIncomingEmailService                                         Online
  User Profile Service                      UserProfileService                                           Disabled
  Access 資料庫服務 2010                         AccessServerWebService                                       Disabled
  Microsoft SharePoint Foundation 訂閱設定服務    SPSubscriptionSettingsService                                Disabled
  Lotus Notes 連接器                           NotesWebService                                              Disabled
  Word Automation Services                  WordService                                                  Disabled
  PowerPoint Conversion Service             PowerPointConversionService                                  Disabled
  Machine Translation Service               TranslationService                                           Disabled
(V)分散式快取                                     SPDistributedCacheService Name=AppFabricCachingService         Online
'






Get-SPServiceInstance |select  Status , typename ,id |sort TypeName
Get-SPServiceInstance |? {$_.Status -eq 'online' } |select id,typename,Status


Start-SPServiceInstance  -Identity d1a6d504-418d-4833-b67d-3dfd3045665d  #Central Administration
Start-SPServiceInstance  -Identity e9e83095-2af0-4ad8-8874-433d147cad32  #Microsoft SharePoint Foundation Web Application

Stop-SPServiceInstance -Identity e9e83095-2af0-4ad8-8874-433d147cad32  -Confirm:$false      #Microsoft SharePoint Foundation Web Application
Stop-SPServiceInstance -Identity d1a6d504-418d-4833-b67d-3dfd3045665d  -Confirm:$false      #Central Administration
Stop-SPServiceInstance -Identity e058340e-d7a8-42d4-9501-2c236824085b  -Confirm:$false      #Microsoft SharePoint Foundation Incoming E-Mail
Stop-SPServiceInstance -Identity 03002d00-f6d0-4f80-9a19-4c073666e3a6  -Confirm:$false      #Distributed Cache
Stop-SPServiceInstance -Identity  67920e93-c8d9-48ec-809f-41560c9d042f -Confirm:$false      #Microsoft SharePoint Foundation Workflow Timer Service
}
#-------------------------------------------
# 13   500  服務應用程式集區  Service Application Pool
#-------------------------------------------
Get-SPFarm |select *   #  get configuration DB

##
 Get-SPServiceApplicationPool |select *
Get-SPServiceApplicationPool
'
Name                                     ProcessAccountName                                                                                
----                                     ------------------                                                                                
SecurityTokenServiceApplicationPool      CSD\Administrator                                                                                 
SharePoint Web Services System           CSD\Administrator 

'
## New
$SPServiceApplicationPoolName='ExcelWebApplicationPool'
New-SPServiceApplicationPool -Name ExcelWebApplicationPool -Account csd\spExcel

## set

Set-SPServiceApplicationPool  TestServiceWebApplicationPool -Account testdomain\testuser1

## remove
Remove-SPServiceApplicationPool TestServiceWebApplicationPool

#------------------------------------------- 
# 14  547  SP  Service   Application  Get-SPServiceApplication   Proxy
#-------------------------------------------


Get-SPServiceApplicationProxy -id 5e612959-5119-4284-8e1a-025dca8fb1f2 |fL
Remove-SPServiceApplicationProxy babab30e-8e3a-428b-8ff4-4d5c8f455e6d

Get-SPServiceApplication  |select name,typename |fl
Get-SPServiceApplication -Name SvcApp_SPSecureStoreServiceApplication_01


Remove-SPServiceApplication 053c34be-d251-488c-8e94-644eae94da26 -RemoveData

Get-SPServiceApplication |select name, displayname,typename,id |ft -AutoSize
<#
Name                            DisplayName                                                 TypeName                                                    Id                  
----                            -----------                                                 --------                                                    --                  
SecurityTokenServiceApplication Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f...
Topology                        Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c3...
#>

 Get-SPServiceApplication -Name Topology |select *

<#
LoadBalancerUrl              : https://win-2s026ubrqfo:32844/Topology/topology.svc
DisplayName                  : Application Discovery and Load Balancer Service Application
TypeName                     : Application Discovery and Load Balancer Service Application
ApplicationClassId           : ece729db-e3d3-4e91-b225-e27b050bf5ed
ApplicationVersion           : 1.0.0.0
Uri                          : https://win-2s026ubrqfo:32844/Topology/topology.svc
IisVirtualDirectoryPath      : SharePoint Web Services\Topology
ApplicationPool              : SPIisWebServiceApplicationPool Name=SharePoint Web Services System
PermissionsLink              : Microsoft.SharePoint.Administration.SPAdministrationLink
Endpoints                    : {}
DefaultEndpoint              : SPIisWebServiceEndpoint
Shared                       : False
Comments                     : 
TermsOfServiceUri            : 
Service                      : SPTopologyWebService
ServiceInstances             : {}
ServiceApplicationProxyGroup : SPServiceApplicationProxyGroup
ManageLink                   : 
PropertiesLink               : 
CanUpgrade                   : True
IsBackwardsCompatible        : True
NeedsUpgradeIncludeChildren  : False
NeedsUpgrade                 : False
UpgradeContext               : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                         : Topology
Id                           : 84044cab-bf1d-4c31-8897-35e99c777359
Status                       : Online
Parent                       : SPTopologyWebService
Version                      : 2892
Properties                   : {}
Farm                         : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties  : {}
CanSelectForBackup           : True
DiskSizeRequired             : 0
CanSelectForRestore          : True
CanRenameOnRestore           : True
#>


#-------------------------------------------
#15    561 Install and Download SharePoint 2013 prerequisites offline
#-------------------------------------------
{<#
https://gallery.technet.microsoft.com/DownloadInstall-SharePoint-e6df9eb8


________________________________________________________________________________________________________________________________________

###  Download-SP2013PreReqFiles.ps1
#***************************************************************************************
# Written by Craig Lussier - http://craiglussier.com
#
# This script downloads SharePoint 2013 Prerequisites
#   
# -Only run this script on Windows Server 2012 (RTM, either Standard or Datacenter)
# -Do not run this script on a Windows Server 2008 R2 SP1 Server!
# ---These are the Prerequisites for Windows Server 2012
# -Run this script as a local server Administrator
# -Run PowerShell as Administrator
#
# Don't forget to: Set-ExecutionPolicy RemoteSigned
# If you have not done so already within you Windows Server 2012 server
#****************************************************************************************
#param([string] $SharePoint2013Path = $(Read-Host -Prompt "Please enter the directory path to where you wish to save the SharePoint 2013 Prerequisite files.")) 
 
 $SharePoint2013Path ="c:\temp\Sharepoint2013preReqFiles"

# Import Required Modules
#Get-Module
Import-Module BitsTransfer 
#Get-Module


# Specify download url's for SharePoint 2013 prerequisites
$DownloadUrls = (
		    "http://download.microsoft.com/download/9/1/3/9138773A-505D-43E2-AC08-9A77E1E0490B/1033/x64/sqlncli.msi", # Microsoft SQL Server 2008 R2 SP1 Native Client
		    "http://download.microsoft.com/download/E/0/0/E0060D8F-2354-4871-9596-DC78538799CC/Synchronization.msi", # Microsoft Sync Framework Runtime v1.0 SP1 (x64)
		    "http://download.microsoft.com/download/A/6/7/A678AB47-496B-4907-B3D4-0A2D280A13C0/WindowsServerAppFabricSetup_x64.exe", # Windows Server App Fabric
            "http://download.microsoft.com/download/7/B/5/7B51D8D1-20FD-4BF0-87C7-4714F5A1C313/AppFabric1.1-RTM-KB2671763-x64-ENU.exe", # Cumulative Update Package 1 for Microsoft AppFabric 1.1 for Windows Server (KB2671763)
            "http://download.microsoft.com/download/D/7/2/D72FD747-69B6-40B7-875B-C2B40A6B2BDD/Windows6.1-KB974405-x64.msu", #Windows Identity Foundation (KB974405)
		    "http://download.microsoft.com/download/0/1/D/01D06854-CA0C-46F1-ADBA-EBF86010DCC6/rtm/MicrosoftIdentityExtensions-64.msi", # Microsoft Identity Extensions
		    "http://download.microsoft.com/download/9/1/D/91DA8796-BE1D-46AF-8489-663AB7811517/setup_msipc_x64.msi", # Microsoft Information Protection and Control Client
		    "http://download.microsoft.com/download/8/F/9/8F93DBBD-896B-4760-AC81-646F61363A6D/WcfDataServices.exe" # Microsoft WCF Data Services 5.0
                ) 


function DownLoadPreRequisites() 
{ 

    Write-Host ""
    Write-Host "====================================================================="
    Write-Host "      Downloading SharePoint 2013 Prerequisites Please wait..." 
    Write-Host "====================================================================="
     
    $ReturnCode = 0 
 
    foreach ($DownLoadUrl in $DownloadUrls) 
    { 
        ## Get the file name based on the portion of the URL after the last slash 
        $FileName = $DownLoadUrl.Split('/')[-1] 
        Try 
        { 
            ## Check if destination file already exists 
            If (!(Test-Path "$SharePoint2013Path\$FileName")) 
            { 
                ## Begin download 
                Start-BitsTransfer -Source $DownLoadUrl -Destination $SharePoint2013Path\$fileName -DisplayName "Downloading `'$FileName`' to $SharePoint2013Path" -Priority High -Description "From $DownLoadUrl..." -ErrorVariable err 
                If ($err) {Throw ""} 
            } 
            Else 
            { 
                Write-Host " - File $FileName already exists, skipping..." 
            } 
        } 
        Catch 
        { 
            $ReturnCode = -1 
            Write-Warning " - An error occurred downloading `'$FileName`'" 
            Write-Error $_ 
            break 
        } 
    } 
    Write-Host " - Done downloading Prerequisites required for SharePoint 2013" 
     
    return $ReturnCode 
} 


 

function CheckProvidedDownloadPath()
{


    $ReturnCode = 0

    Try 
    { 
        # Check if destination path exists 
        If (Test-Path $SharePoint2013Path) 
        { 
           # Remove trailing slash if it is present
           $script:SharePoint2013Path = $SharePoint2013Path.TrimEnd('\')
	   $ReturnCode = 0
        }
        Else {

	   $ReturnCode = -1
           Write-Host ""
	   Write-Warning "Your specified download path does not exist. Please verify your download path then run this script again."
           Write-Host ""
        } 


    } 
    Catch 
    { 
         $ReturnCode = -1 
         Write-Warning "An error has occurred when checking your specified download path" 
         Write-Error $_ 
         break 
    }     
    
    return $ReturnCode 

}


 
function DownloadPreReqs() 
{ 

    $rc = 0 
    
    $rc = CheckProvidedDownloadPath  

    # Download Pre-Reqs  
    if($rc -ne -1) 
    { 
        $rc = DownLoadPreRequisites 
    } 
     

    if($rc -ne -1)
    {

        Write-Host ""
        Write-Host "Script execution is now complete!"
        Write-Host ""
    }


} 

DownloadPreReqs
________________________________________________________________________________________________________________________________________


## 719  Install-SP2013RolesFeatures.ps1
#***************************************************************************************
# Written by Craig Lussier - http://craiglussier.com
#
# This script installs SharePoint 2013 Roles/Features for Windows Server 2012
#  
# -Only run this script on Windows Server 2012 (RTM, either Standard or Datacenter)
# -If you are running this script 'offline' have your Windows Server 2012 installation
#  Media mounted/copied to this machine. You can also use a network UNC path.
# -Do not run this script on a Windows Server 2008 R2 SP1 Server!
# ---These are the Prerequisites for Windows Server 2012
# -Run this script as a local server Administrator
# -Run PowerShell as Administrator
#
# Don't forget to: Set-ExecutionPolicy RemoteSigned
# If you have not done so already within you Windows Server 2012 server 
#****************************************************************************************
# Import Required Module
Import-Module ServerManager

function AddWindowsFeatures() 
{ 
    Write-Host "==================================================================================="
    Write-Host "Install required Windows Roles/Features for SharePoint 2013 on Windows Server 2012"
    Write-Host ""
    Write-Host "Note: You'll receive prompt to restart your server when the"
    Write-Host "      Windows Server 2012 Role/Feature installation is complete."
    Write-Host "==================================================================================="        
     
      
    # Note: You can use the Get-WindowsFeature cmdlet (its in the ServerManager module) 
    #       to get a listing of all features and roles.
    $WindowsFeatures = @(
			"Net-Framework-Features",
			"Web-Server",
			"Web-WebServer",
			"Web-Common-Http",
			"Web-Static-Content",
			"Web-Default-Doc",
			"Web-Dir-Browsing",
			"Web-Http-Errors",
			"Web-App-Dev",
			"Web-Asp-Net",
			"Web-Net-Ext",
			"Web-ISAPI-Ext",
			"Web-ISAPI-Filter",
			"Web-Health",
			"Web-Http-Logging",
			"Web-Log-Libraries",
			"Web-Request-Monitor",
			"Web-Http-Tracing",
			"Web-Security",
			"Web-Basic-Auth",
			"Web-Windows-Auth",
			"Web-Filtering",
			"Web-Digest-Auth",
			"Web-Performance",
			"Web-Stat-Compression",
			"Web-Dyn-Compression",
			"Web-Mgmt-Tools",
			"Web-Mgmt-Console",
			"Web-Mgmt-Compat",
			"Web-Metabase",
			"Application-Server",
			"AS-Web-Support",
			"AS-TCP-Port-Sharing",
			"AS-WAS-Support",
			"AS-HTTP-Activation",
			"AS-TCP-Activation",
			"AS-Named-Pipes",
			"AS-Net-Framework",
			"WAS",
			"WAS-Process-Model",
			"WAS-NET-Environment",
			"WAS-Config-APIs",
			"Web-Lgcy-Scripting",
			"Windows-Identity-Foundation",
			"Server-Media-Foundation",
			"Xps-Viewer"
    )


    #Prompt To Start Role/Feature Installation
    $title = "Do you wish to perform an online or offline installation?"
    $message = "Please ensure that you have read and understand the instructions located at http://gallery.technet.microsoft.com/DownloadInstall-SharePoint-e6df9eb8. 'Online' means Windows Server 2012 is connected to the Internet and Windows Update is used to download supporting files, Offline means Windows Server 2012 is not connected to the Internet and you have your Windows Server 2012 installation media mounted/copied to this server to install supporting files."

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Online", `
	   "Uses Windows Update to download and install necessary components related to .NET 3.5 feature (NET-Framework-Core)"

    $no = New-Object System.Management.Automation.Host.ChoiceDescription "O&ffline", `
           "Uses Windows Server 2012 media to install necessary components related to .NET 3.5 feature (NET-Framework-Core)"

    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

    $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

    $windowsServer2012MediaPath = ""
    Write-Host ""

    switch ($result)
	{
        
        0 {"You will be using Windows Update to download the necessary components to install features related to .NET 3.5. This will extend the duration of your Role/Feature installation."}
        1 {$windowsServer2012MediaPath = $(Read-Host -Prompt "Please enter the directory pointing to the directory of your Windows Server 2012 installation media. Fore example, D:\sources\sxs")}
    }
    Write-Host ""


    Try 
    { 
	# Create PowerShell to execute 

        $source = "" 

        if($windowsServer2012MediaPath -ne "") {
           $source = ' -source ' + $windowsServer2012MediaPath
        }
        

        $myCommand = 'Add-WindowsFeature ' + [string]::join(",",$WindowsFeatures) + $source

	    # Execute $myCommand
        $operation = Invoke-Expression $myCommand    

        if ($operation.RestartNeeded -eq "Yes") { 
        
      	   #Prompt User for Restart
	   $title = "Restart your server now?"
	   $message = "Would you like to restart your server now? It is required to complete the Windows Role/Feature Installation."

	   $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
	         "Restarts your Windows Server 2012 server now to complete the Role/Feature installation."

	   $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
	    "Does not restart your server now... But you should..."

	   $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

	   $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

	   switch ($result)
	   {
	        0 {Restart-Computer;}
	        1 {"Your server will not restart at this time. Before installing the Pre-requisite files, restart your computer."}
	   }


        }

    } 
    Catch 
    { 
        Write-Warning "Error when Adding Windows Features. Error details are below:" 
        Write-Error $_ 
        break 
    } 
      
} 

AddWindowsFeatures
 



________________________________________________________________________________________________________________________________________

## 890  Install-SP2013PreReqFiles.ps1  
 先將iso unzip to Folder(like SP2013source) ,
 再將已Download DownLoadPreRequisites copy to \SP2013source\prerequisiteinstallerfiles\*.*
 設定 $SharePoint2013Path='C:\SP2013source'
 直接執行 InstallPreReqFiles .會出現安裝畫面, 會自動一直run 下去. 5 mins 即會OK
 記得 安裝Software 不要用ISO模擬光碟機. 會出問題

#***************************************************************************************
# Written by Craig Lussier - http://craiglussier.com
#
# This script downloads and instals SharePoint 2013 Prerequisites
#  
# -Only run this script on Windows Server 2012 (RTM, either Standard or Datacenter)
# -Do not run this script on a Windows Server 2008 R2 SP1 Server!
# ---These are the Prerequisites for Windows Server 2012
# -Run this script as a local server Administrator
# -Run PowerShell as Administrator
# 
# IMPORTANT NOTES:
# -The $SharePoint2013Path is the path to your SharePoint 2013 installation media
# -This script utilizes the PrerequisiteInstaller.exe in your SharePoint 2013 media
# -The script points to your $SharePoint2013Path\PrerequisiteInstallerFiles directory.
# ---BE SURE TO COPY THE PREREQ FILES INTO THIS DIRECTORY IF THEY ARE NOT ALREADY THERE FROM THE Download-SP2013PreReqFiles.ps1 script
#
# Don't forget to: Set-ExecutionPolicy RemoteSigned
# If you have not done so already within you Windows Server 2012 server
#****************************************************************************************
param([string] $SharePoint2013Path = $(Read-Host -Prompt "Please enter the directory path to where your SharePoint 2013 installation files exist.")) 
 
 $SharePoint2013Path ="c:\temp\Sharepoint2013preReqFiles"
 
function InstallPreReqFiles() 
{ 

    $ReturnCode = 0

    Write-Host ""
    Write-Host "====================================================================="
    Write-Host "Installing Prerequisites required for SharePoint 2013" 
    Write-Host ""
    Write-Host "This uses the supported installing offline method"
    Write-Host ""
    Write-Host "If you have not installed the necessary Roles/Features"
    Write-Host "this will occur at this time."
    Write-Host "=====================================================================" 
     
     
        Try 
        { 
        

             Start-Process "$SharePoint2013Path\PrerequisiteInstaller.exe" -ArgumentList "`
                                                                                             /SQLNCli:`"$SharePoint2013Path\PrerequisiteInstallerFiles\sqlncli.msi`" `
                                                                                             /IDFX:`"$SharePoint2013Path\PrerequisiteInstallerFiles\Windows6.1-KB974405-x64.msu`" `
                                                                                             /IDFX11:`"$SharePoint2013Path\PrerequisiteInstallerFiles\MicrosoftIdentityExtensions-64.msi`" `
                                                                                             /Sync:`"$SharePoint2013Path\PrerequisiteInstallerFiles\Synchronization.msi`" `
                                                                                             /AppFabric:`"$SharePoint2013Path\PrerequisiteInstallerFiles\WindowsServerAppFabricSetup_x64.exe`" `
                                                                                             /KB2671763:`"$SharePoint2013Path\PrerequisiteInstallerFiles\AppFabric1.1-RTM-KB2671763-x64-ENU.exe`" `                                                                                             
                                                                                             /MSIPCClient:`"$SharePoint2013Path\PrerequisiteInstallerFiles\setup_msipc_x64.msi`" `
                                                                                             /WCFDataServices:`"$SharePoint2013Path\PrerequisiteInstallerFiles\WcfDataServices.exe`""
        } 
        Catch 
        { 
            $ReturnCode = -1 
            Write-Error $_ 
            break 
        }     
 
    return $ReturnCode 
} 
 
function CheckProvidedSharePoint2013Path()
{


    $ReturnCode = 0

    Try 
    { 
        # Check if destination path exists 
        If (Test-Path $SharePoint2013Path) 
        { 
           # Remove trailing slash if it is present
           $script:SharePoint2013Path = $SharePoint2013Path.TrimEnd('\')
	   $ReturnCode = 0
        }
        Else {

	   $ReturnCode = -1
           Write-Host ""
	   Write-Warning "Your specified download path does not exist. Please verify your download path then run this script again."
           Write-Host ""
        } 


    } 
    Catch 
    { 
         $ReturnCode = -1 
         Write-Warning "An error has occurred when checking your specified download path" 
         Write-Error $_ 
         break 
    }     
    
    return $ReturnCode 

}


 
function InstallPreReqs() 
{ 

    $rc = 0 
    
    $rc = CheckProvidedSharePoint2013Path  

     
    # Install the Pre-Reqs 
    if($rc -ne -1) 
    { 
       $rc = InstallPreReqFiles 
    } 

    if($rc -ne -1)
    {

        Write-Host ""
        Write-Host "Script execution is now complete!"
        Write-Host ""
    }


} 

InstallPreReqs


________________________________________________________________________________________________________________________________________


 #>}



#-------------------------------------------
#  1025  install sharepoint at WFE  SEP.03.2015
#-------------------------------------------
I Miss MaMa











#-------------------------------------------
#   1206  Add or remove blocked file types 
#-------------------------------------------
https://technet.microsoft.com/en-us/library/cc262496.aspx


In Central Administration, > Security.
On the Security page, in the General Security section, click Define blocked file types.
On the Blocked File Types page, if you want to change the selected web application, on the Web Application menu, click Change Web Application. Use the Select Web Application page to select a web application.
Do one of the following:
To block an additional file type, scroll to the bottom of the Type each file name extension on a separate line text box, type the file name extension that you want to block, and then click OK.
NoteNote:
You do not have to type a file name extension in the list in alphabetical order. The next time that you open the list, the file name extension you added will be correctly sorted in alphabetical order.
To stop blocking a file type, select a file type from the list, press the Delete key, and then click OK.


<#
PS SQLSERVER:\> Get-SPWebTemplate |sort name

Name                 Title                                    LocaleId   Compatibi
                                                                         lityLevel
----                 -----                                    --------   ---------
ACCSRV#0             Access Services 網站                       1028       14       
ACCSRV#0             Access Services 網站                       1028       15       
ACCSRV#1             資產 Web 資料庫                               1028       14       
ACCSRV#3             慈善捐款 Web 資料庫                             1028       14       
ACCSRV#4             連絡人 Web 資料庫                              1028       14       
ACCSRV#5             專案 Web 資料庫                               1028       14       
ACCSRV#6             議題 Web 資料庫                               1028       14       
ACCSVC#0             Access Services 內部網站                     1028       15       
ACCSVC#1             Access Services 網站                       1028       15       
APP#0                應用程式範本                                   1028       15       
APPCATALOG#0         應用程式目錄網站                                 1028       15       
BDR#0                文件中心                                     1028       14       
BDR#0                文件中心                                     1028       15       
BICenterSite#0       商務智慧中心                                   1028       15       
BICenterSite#0       商務智慧中心                                   1028       14       
BLANKINTERNET#0      發佈網站                                     1028       14       
BLANKINTERNET#0      發佈網站                                     1028       15       
BLANKINTERNET#1      新聞稿網站                                    1028       14       
BLANKINTERNET#1      新聞稿網站                                    1028       15       
BLANKINTERNET#2      使用工作流程發佈網站                               1028       15       
BLANKINTERNET#2      使用工作流程發佈網站                               1028       14       
BLANKINTERNETCONT... 發佈入口網站                                   1028       14       
BLANKINTERNETCONT... 發佈入口網站                                   1028       15       
BLOG#0               部落格                                      1028       15       
BLOG#0               部落格                                      1028       14       
CENTRALADMIN#0       管理中心網站                                   1028       15       
CENTRALADMIN#0       管理中心網站                                   1028       14       
CMSPUBLISHING#0      發佈網站                                     1028       15       
CMSPUBLISHING#0      發佈網站                                     1028       14       
COMMUNITY#0          社群網站                                     1028       15       
COMMUNITYPORTAL#0    社群入口網站                                   1028       15       
DEV#0                開發人員網站                                   1028       15       
DOCMARKETPLACESITE#0 學術文件庫                                    1028       15       
EDISC#0              eDiscovery 中心                            1028       15       
EDISC#1              eDiscovery 案例                            1028       15       
ENTERWIKI#0          企業 Wiki                                  1028       15       
ENTERWIKI#0          企業 Wiki                                  1028       14       
GLOBAL#0             通用範本                                     1028       15       
GLOBAL#0             通用範本                                     1028       14       
MPS#0                基本會議工作區                                  1028       14       
MPS#0                基本會議工作區                                  1028       15       
MPS#1                空白會議工作區                                  1028       14       
MPS#1                空白會議工作區                                  1028       15       
MPS#2                決策會議工作區                                  1028       14       
MPS#2                決策會議工作區                                  1028       15       
MPS#3                社交會議工作區                                  1028       14       
MPS#3                社交會議工作區                                  1028       15       
MPS#4                多重頁面會議工作區                                1028       14       
MPS#4                多重頁面會議工作區                                1028       15       
OFFILE#0             (已過時) 記錄中心                               1028       15       
OFFILE#0             (已過時) 記錄中心                               1028       14       
OFFILE#1             記錄中心                                     1028       15       
OFFILE#1             記錄中心                                     1028       14       
OSRV#0               共用服務管理網站                                 1028       15       
OSRV#0               共用服務管理網站                                 1028       14       
PPSMASite#0          PerformancePoint                         1028       15       
PPSMASite#0          PerformancePoint                         1028       14       
PRODUCTCATALOG#0     產品目錄                                     1028       15       
PROFILES#0           設定檔                                      1028       14       
PROFILES#0           設定檔                                      1028       15       
PROJECTSITE#0        專案網站                                     1028       15       
SGS#0                群組工作站台                                   1028       15       
SGS#0                群組工作站台                                   1028       14       
SPS#0                SharePoint Portal Server 網站              1028       14       
SPS#0                SharePoint Portal Server 網站              1028       15       
SPSCOMMU#0           社群區域範本                                   1028       14       
SPSCOMMU#0           社群區域範本                                   1028       15       
SPSMSITE#0           個人化網站                                    1028       14       
SPSMSITE#0           個人化網站                                    1028       15       
SPSMSITEHOST#0       我的網站主機                                   1028       14       
SPSMSITEHOST#0       我的網站主機                                   1028       15       
SPSNEWS#0            新聞網站                                     1028       15       
SPSNEWS#0            新聞網站                                     1028       14       
SPSNHOME#0           新聞網站                                     1028       15       
SPSNHOME#0           新聞網站                                     1028       14       
SPSPERS#0            SharePoint Portal Server 個人空間            1028       15       
SPSPERS#0            SharePoint Portal Server 個人空間            1028       14       
SPSPERS#2            具備儲存與社交功能的 SharePoint Portal Server 個人空間 1028       15       
SPSPERS#3            僅具備儲存功能的 SharePoint Portal Server 個人空間   1028       15       
SPSPERS#4            僅具備社交功能的 SharePoint Portal Server 個人空間   1028       15       
SPSPERS#5            空的 SharePoint Portal Server 個人空間         1028       15       
SPSPORTAL#0          共同作業入口網站                                 1028       15       
SPSPORTAL#0          共同作業入口網站                                 1028       14       
SPSREPORTCENTER#0    報告中心                                     1028       14       
SPSREPORTCENTER#0    報告中心                                     1028       15       
SPSSITES#0           網站目錄                                     1028       15       
SPSSITES#0           網站目錄                                     1028       14       
SPSTOC#0             內容區域範本                                   1028       14       
SPSTOC#0             內容區域範本                                   1028       15       
SPSTOPIC#0           主題區域範本                                   1028       14       
SPSTOPIC#0           主題區域範本                                   1028       15       
SRCHCEN#0            企業搜尋中心                                   1028       14       
SRCHCEN#0            企業搜尋中心                                   1028       15       
SRCHCENTERFAST#0     FAST Search 中心                           1028       14       
SRCHCENTERLITE#0     基本搜尋中心                                   1028       14       
SRCHCENTERLITE#0     基本搜尋中心                                   1028       15       
SRCHCENTERLITE#1     基本搜尋中心                                   1028       14       
SRCHCENTERLITE#1     基本搜尋中心                                   1028       15       
STS#0                小組網站                                     1028       15       
STS#0                小組網站                                     1028       14       
STS#1                空白網站                                     1028       15       
STS#1                空白網站                                     1028       14       
STS#2                文件工作區                                    1028       14       
STS#2                文件工作區                                    1028       15       
TENANTADMIN#0        承租人管理網站                                  1028       15       
TENANTADMIN#0        承租人管理網站                                  1028       14       
vispr#0              Visio 程序存放庫                              1028       15       
vispr#0              Visio 程序存放庫                              1028       14       
WIKI#0               Wiki 網站                                  1028       15       
WIKI#0               Wiki 網站                                  1028       14  

#>

#-------------------------------------------
#  1409   SPManagedAccount
#-------------------------------------------
https://technet.microsoft.com/en-us/library/ff607835.aspx
 Get-SPManagedAccount

  ##  get  Get-SPManagedAccount##  newUser name: domain\accountname csd\spExcel pwd: p@ssw0rd$ServiceApplicationUser = "PMOCSD\infra1" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "p@ssw0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword  
 
 #Managed Account 
      write-host -ForegroundColor Green "Managed account..."; 
      $ManagedAccount = Get-SPManagedAccount $ServiceApplicationUser 

      if ($ManagedAccount -eq $NULL)  
      {  
           write-host  -ForegroundColor Green "Create new managed account" 
           $ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials 
      } 
      

  Get-SPManagedAccount  ## set

#-------------------------------------------
#  1413   SPServiceApplicationPool
#-------------------------------------------

#get
get-SPServiceApplicationPool

get-SPServiceApplicationPool  BIApplicationPool  |select *

get-SPServiceApplicationPool  'SharePoint Web Services System'  |select *
##  Id =  inetmgr name 


#new




#remove
 
Remove-SPServiceApplicationPool   BIApplicationPool -Confirm:$false
#-------------------------------------------
#  1471   IncludeCentralAdministration 
#-------------------------------------------

Get-SPWebApplication -IncludeCentralAdministration | Where { $_.DefaultServerComment -eq "SharePoint Central Administration v4"} | Format-List *


#-------------------------------------------
#  1478    update to  Sharepoint sp1
#-------------------------------------------


gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
'Microsoft SharePoint Portal       15.0.4569.1506 '
start-process  D:\software2015\officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe 
remember  must reboot 
'Microsoft SharePoint Server 2013  15.0.4571.1502 '

#-------------------------------------------
#  1489   regedit  spfarm  login 
#-------------------------------------------

UI:  網站集合清單   http://localhost:2013/_admin/SiteCollections.aspx?ReturnSelectionPage=/applications.aspx
IE:  此時本機仍不行連入

# use cmd - regedit  if spfarm , infra  can not into http://pp.tempcsd.syscom
解決方法
1. Click Start, click Run, type regedit, and then click OK.
2. In Registry Editor, locate and then click the following registry key:    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa
3. Right-click Lsa, point to New, and then click DWORD Value.
4. Type DisableLoopbackCheck, and then press ENTER.
5. Right-click DisableLoopbackCheck, and then click Modify.
6. In the Value data box, type 1, and then click OK.
7. Quit Registry Editor, and then restart your computer.


#-------------------------------------------
#  檢查是否Sharepoint 需要 upgrade
#-------------------------------------------
(get-spserver $env:computername).NeedsUpgrade


#-------------------------------------------
#具有 SharePoint_Shell_Access 角色之所有使用者的名稱
#-------------------------------------------
  gh Get-SPShellAdmin  -full

#http://technet.microsoft.com/en-us/library/ff793362.aspx

## import-module ADRMS, AppLocker, BestPractices, BitsTransfer,PSDiagnostices,Servermanager,TroubleshootingPack,WebAdministration
##  Import-Module “sqlps” -DisableNameChecking





#----------------------------
#  Get-Module
#----------------------------
Get-Module

import-module webadministration
Import-Module ServerManager

write-host "Snap-In $SnapInName already loaded"
Get-pssnapin |select name
Get-webbinding |  select item,bindingInformation   cmdlet
Get-Website |select Name ,"PhysicalPath" ,Bindings   |fl 


#----------------------------
## Get-SPFarmConfig
#----------------------------
Get-SPFarmConfig


#------------------------------------------
#Retrieve the System Accounts
#------------------------------------------
Get-SPProcessAccount


# Get-Help
get-help Set-SPPassPhrase -full

Set-SPFarmConfig -InstalledProductsRefresh

#------------------------------------------
#Change the Port of Central Admin
#------------------------------------------
set-SPCentralAdministration –Port 20222
Import all modules


#------------------------------------------
#Change the Port of Central Admin
#------------------------------------------

add-pssnapin WebAdministration
Get-Website

#------------------------------------------
#   Get-SPManagedPath 
#------------------------------------------
Get-SPManagedPath   -WebApplication  "SP"
New-SPManagedPath "Teams" -WebApplication "http://somesite"

#-----------------------------------
##    新增受管理帳戶至伺服器陣列
#-----------------------------------
SPBI
SPExcel
SPFarmadmin        (also Run as SQL database, local administrator , role dbcreate ,securityadmin , public )
SPSerach
SPU1
SPU2
SPUnattended






# Service accounts
$DOMAIN = "CSD.SYSCOM"$accounts = @{}$accounts.Add("SPFarm",   @{"username" = "sp2013-farm"; "password" = "Password123"})$accounts.Add("SPWebApp", @{"username" = "sp2013-ap-webapp"; "password" = "Password123"})$accounts.Add("SPSvcApp", @{"username" = "sp2013-ap-service"; "password" = "Password123"})
# Add managed accounts
Write-Output "Creating managed accounts ..."
New-SPManagedAccount -credential $accounts.SPWebApp.credential
New-SPManagedAccount -credential $accounts.SPSvcApp.credential
New-SPManagedAccount -credential $accounts.SPCrawl.credential


$ServiceApplicationUser = "CSD\spfarmadmin" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "p@ssw0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword  
 
 
 #Managed Account 
      write-host -ForegroundColor Green "Managed account..."; 
      $ManagedAccount = Get-SPManagedAccount $ServiceApplicationUser 

      if ($ManagedAccount -eq $NULL)  
      {  
           write-host  -ForegroundColor Green "Create new managed account" 
           $ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials 
      } 
      




$ServiceApplicationUser = "CSD\excel"  #
$ServiceApplicationUserPassword = (ConvertTo-SecureString "p@ssw0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword  
 
 #Managed Account 
      write-host -ForegroundColor Green "Managed account..."; 
      $ManagedAccount = Get-SPManagedAccount $ServiceApplicationUser 

      if ($ManagedAccount -eq $NULL)  
      {  
           write-host  -ForegroundColor Green "Create new managed account" 
           $ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials 
      } 
      

      Get-SPManagedAccount


#-----------------------------------
##  1650  after configuration Wizard  don't  run wizard now
#-----------------------------------
#http://mikefrobbins.com/2013/02/14/install-sharepoint-2013-with-powershell-to-prevent-the-dreaded-database-names-with-guids/> 
# Not launch yet

Add-PSSnapin Microsoft.SharePoint.PowerShell
$FarmCredential = Get-Credential -credential csd\spBI
$Passphrase = Read-Host -assecurestring "SP PassPhrase"
$DbName = "SP_Extranet_Config"
$DbServer = "2013BI"
$AdminContentDb = "SP_Extranet_AdminContent"
New-SPConfigurationDatabase -DatabaseName $DbName -DatabaseServer $DbServer -AdministrationContentDatabaseName $AdminContentDb -FarmCredentials $FarmCredential -Passphrase $Passphrase
Install-SPHelpCollection -All
Initialize-SPResourceSecurity
Install-SPService
Install-SPFeature -AllExistingFeatures
New-SPCentralAdministration -Port 55000 -WindowsAuthProvider "NTLM"
Install-SPApplicationContent


#-----------------------------------
##  1671  SP Check List all
#-----------------------------------

add-pssnapin WebAdministration
Add-PSSnapin Microsoft.SharePoint.PowerShell 

GSNP


#--applicationpool
Get-SPServiceApplicationPool
'PS C:\Windows\system32> Get-SPServiceApplicationPool

Name                                     ProcessAccountName                                                                                                              
----                                     ------------------                                                                                                              
SecurityTokenServiceApplicationPool      CSD\infrax                                                                                                                      
SharePoint Web Services System           CSD\infrax                                                                                                                      

'

#-- IIS inetmgr appliationPool
get-WmiObject -Namespace "root\WebAdministration" -Class Site -Authentication PacketPrivacy -ComputerName sql2012x 
get-WmiObject -Namespace "root\WebAdministration" -Class Site -Authentication PacketPrivacy -ComputerName sql2012x  |select name ,__path
'name                                                                                 __PATH                                                                              
----                                                                                 ------                                                                              
Default Web Site                                                                     \\SQL2012X\root\WebAdministration:Site.Name="Default Web Site"                      
SharePoint Web Services                                                              \\SQL2012X\root\WebAdministration:Site.Name="SharePoint Web Services"               
SharePoint Central Administration v4                                                 \\SQL2012X\root\WebAdministration:Site.Name="SharePoint Central Administration v4"  
AP1-80                                                                               \\SQL2012X\root\WebAdministration:Site.Name="AP1-80"                                
'

#-- IIS inetmgr website
get-website 
get-website |fl
get-website |select name , physicalpath,bindings
'
PS C:\Windows\system32> get-website 

Name             ID   State      Physical Path                  Bindings                                                                                                 
----             --   -----      -------------                  --------                                                                                                 
Default Web Site 1    Stopped    %SystemDrive%\inetpub\wwwroot  http *:80:                                                                                               
                                                                net.tcp 808:*                                                                                            
                                                                net.pipe *                                                                                               
SharePoint Web S 2    Started    C:\Program Files\Common Files\ http *:32843:                                                                                            
ervices                          Microsoft Shared\Web Server Ex https *:32844: sslFlags=0                                                                                
                                 tensions\15\WebServices\Root   net.tcp 32845:*                                                                                          
                                                                net.pipe *                                                                                               
SharePoint Centr 7461 Started    C:\inetpub\wwwroot\wss\Virtual http :2013:                                                                                              
al Administratio 6964            Directories\45983                                                                                                                       
n v4             4                                                                                                                                                       
AP1-80           1900 Started    C:\inetpub\wwwroot\wss\Virtual http :80:                                                                                                
                 0059            Directories\80                                                                                                                          
                 07    
'
#-- SPFarmConfig
Get-SPFarmConfig


#-- SPProcessAccount
Get-SPProcessAccount
'
PS C:\Windows\system32> Get-SPProcessAccount

SecurityIdentifier             Name                          
------------------             ----                          
S-1-5-20                       NT AUTHORITY\NETWORK SERVICE  
S-1-5-18                       NT AUTHORITY\SYSTEM           
S-1-5-19                       NT AUTHORITY\LOCAL SERVICE    
S-1-5-21-4256488325-3202881... CSD\infrax   
'

#-- SPManagedAccount

get-SPManagedAccount
'PS C:\Windows\system32> get-SPManagedAccount

UserName             PasswordExpiration    Automatic ChangeSchedule                
                                           Change                                  
--------             ------------------    --------- --------------                
CSD\infrax           2016/8/10 下午 04:51:52 False  
'

#-- spdatabase

get-spdatabase
'PS C:\Windows\system32> get-spdatabase

Name                     Id                                   Type                
----                     --                                   ----                
SQL2012X_ConfigDB        6814fe44-fb5d-453f-bf95-5dfd294374e7 設定資料庫               
SQL2012X_CentralAdmin... 579b53fd-3803-4073-949b-8b8263a2e5a3 內容資料庫               
WSS_Contentap1           5c69571f-54af-4051-bba5-90c447f55b3d 內容資料庫
'

#-- SPShellAdmin

Get-SPShellAdmin


#-- SPwebapplication

get-spwebapplication  |select name,id,status ,Farm,url
'Name   : AP1-80
Id     : 2791412b-eb99-4c30-ac75-9f867c964495
Status : Online
Farm   : SPFarm Name=SQL2012X_ConfigDB
Url    : http://ap1.csd.syscom/
'

#-- spserver
get-spserver
'
61 Address             
-------             
SPFarmSQL           
SQL2012X 
'

#-- spfarm
get-spfarm
'
61Name                                                    Status                   
----                                                    ------                   
SQL2012X_ConfigDB                                       Online                   
'


#--   CentralAdministration
Get-SPWebApplication -IncludeCentralAdministration
'
61DisplayName                    Url                                               
-----------                    ---                                               
AP1-80                         http://ap1.csd.syscom/                            
SharePoint Central Administ... http://sql2012x:2013/ 
'


#--   SPFeature).count
(get-SPFeature).count

'657'

#--   SPWebApplication
Get-SPWebApplication
'
DisplayName                    Url                                               
-----------                    ---                                               
AP1-80                         http://ap1.csd.syscom/  
'


#--   SPManagedPath
Get-SPManagedPath   -WebApplication  "AP1-80"


#--   SPSite
get-SPSite 
'
PS C:\Windows\system32> get-SPSite 

Url                                                     CompatibilityLevel  
---                                                     ------------------  
http://ap1.csd.syscom                                   15                  

'


++++++++++++++++++++++++++++++++++++++++++++++

#
Get-Credential -credential csd\spBI | New-SPManagedAccount

#  create web application  # ref: \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\SP04_WebApplication.ps1
'$WebAppPool = "SP - Extranet"
$WebAppName = "SP - Extranet"
$WebAppPoolAcct = "mikefrobbins\spExtranetPool"
$WebAppDbName = "SP_Extranet_Content"
$WebAppDbServer = "sql01.mikefrobbins.com"
$WebAppPath = "D:\inetpub\wwwroot\wss\VirtualDirectories\Extranet"
$WebAppPort = "80"
'
$t1=get-date
$WebAppPool     = "biAppPool"
$WebAppName     = "SPbi29"
$WebAppPoolAcct = "CSD\spfarmadmin"
$WebAppDbName   = "SPcontent_bi29"
$WebAppDbServer = "2013Bi"
#$WebAppPath    = "D:\inetpub\wwwroot\wss\VirtualDirectories\Extranet"
$WebAppPort     = "80"
New-SPWebApplication -ApplicationPool $WebAppPool -Name $WebAppName -ApplicationPoolAccount (Get-SPManagedAccount $WebAppPoolAcct) `
-DatabaseName $WebAppDbName -DatabaseServer $WebAppDbServer -Port $WebAppPort -Url $SiteColUrl 


$t2=get-date
($t2-$t1).TotalMinutes   #1.581352225

$SiteColUrl         = ("http://bi29.csd.syscom")
$SiteColOwner       = "CSD\spfarmadmin"
$SecondaryOwnerAlias= "CSD\administrator"
$SiteColDescription = "Ming Tseng - create SP Using Powershell"
$SiteColName        = "BICenter"
$SiteColTemplate    = "BICenterSite#0"
New-SPSite -Url $SiteColUrl -OwnerAlias $SiteColOwner -SecondaryOwnerAlias $SecondaryOwnerAlias `
-Description $SiteColDescription -Name $SiteColName -Template $SiteColTemplate
$t3=get-date
($t3-$t2).TotalMinutes   #1.991056165



'
New-SPWebApplication -ApplicationPool $WebAppPool -Name $WebAppName -ApplicationPoolAccount (Get-SPManagedAccount $WebAppPoolAcct) `
-DatabaseName $WebAppDbName -DatabaseServer $WebAppDbServer -Path $WebAppPath -Port $WebAppPort -Url $SiteColUrl `
-SecondaryOwnerAlias $SecondaryOwnerAlias -AuthenticationProvider (New-SPAuthenticationProvider)
'


New-SPWebApplication -ApplicationPool $WebAppAppPool -Name $WebAppName -ApplicationPoolAccount (Get-SPManagedAccount $WebAppAppPoolAccount)
-DatabaseName $WebAppDatabaseName -DatabaseServer $WebAppDatabaseServer -Port $WebAppPort  



 `

-DatabaseServer $WebAppDatabaseServer



"C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Bin\PowerPivotSPAddinConfiguration.exe"


"C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Bin\PowerPivotSPAddinConfiguration.exe"





#01##12#############################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2008 enterprise tw, sql 2k5 std , moss 2k8 enterprise
#History    :
#object : Gretai security
#
# cd env:Path 
#
# debug:12

 

write-host "--01-variable-" 
# import-csv
#[Environment]::SetEnvironmentVariable("Path", "$env:path;$env:commonprogramfiles\microsoft shared\web server extensions\12\bin\", "machine")
#[environment]::GetEnvironmentVariable("Path","machine") #get
#[Environment]::SetEnvironmentVariable("Path",$null,"machine") #delete 
# $env:path
$servername=$env:COMPUTERNAME 
$Farm_ConfigurationDatabase="Farm_config"
$dbuser="sa"
$dbpwd="p@ssw0rd"

$installuser         ="$env:userdomain\$env:USERNAME"
$installuserpwd      ="p@ssw0rd"
$webapplicatiosadmin ="WebappS_admin"
$farmcontactemail    ="spfarmadmin@csd.syscom"
$centralport         ="2688"
cd "$env:commonprogramfiles\microsoft shared\web server extensions\15\bin\"


write-host "--02-create db using-"

#$teststring ="psconfig -cmd configdb -create -server $servername -database $Farm_ConfigurationDatabase -dbuser $dbuser -dbpassword $dbpwd -user $installuser -password $installuserpwd -admincontentdatabase $webapplicatiosadmin"
#$teststring
#.\psconfig -help configdb
#.\psconfig  -cmd configdb -disconnect  
#  .\psconfig  -cmd configdb -connect -server $servername -database $Farm_ConfigurationDatabase -dbuser $dbuser -dbpassword $dbpwd -user $installuser -password $installuserpwd

.\psconfig -cmd configdb -create -server $servername -database $Farm_ConfigurationDatabase -dbuser $dbuser -dbpassword $dbpwd -user $installuser -password $installuserpwd -admincontentdatabase $webapplicatiosadmin

 
write-host "--03-config using psconfig-" 
.\PSConfig -cmd helpcollections installall


write-host "--04-config services  using psconfig -"
.\PSConfig -cmd services -install
#stsadm -o spsearch -action start -farmserviceaccount domain\user -farmservicepassword MyPassword
.\stsadm -o spsearch -action start -farmserviceaccount $installuser -farmservicepassword $installuserpwd
#stsadm -o osearch -action start -role IndexQuery -farmserviceaccount domain\user -farmservicepassword MyPassword -farmcontactemail user@domain.com
.\stsadm -o osearch -action start -role IndexQuery -farmserviceaccount $installuser  -farmservicepassword $installuserpwd -farmcontactemail $farmcontactemail
.\psconfig -cmd services -provision

write-host "--05-installfeatures  using psconfig -"
.\PSConfig -cmd installfeatures
.\PSConfig -cmd adminvs -provision -port $centralport -windowsauthprovider onlyusentlm
.\PSConfig -cmd applicationcontent -install

write-host "--center admin finish -----"
