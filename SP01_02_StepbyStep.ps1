gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
C:\Content Packs\Packs\SharePoint Configuration Demo 15.2.6\AutoSetup\SP01_02_StepbyStep.ps1

<#








C:\Demos\216installSP.ps1
C:\Content Packs\Packs\SharePoint Configuration Demo 15.2.6\AutoSetup\SP01_02_StepbyStep.ps1
#>


#------------------------------------
#step 1  preinstall   Download-SP2013PreReqFiles.ps1
#------------------------------------
SP01_installconfg.ps1   561 Install and Download SharePoint 2013 prerequisites offline

$prevSPSFile='C:\Demos\prevSPSFile.txt'
gwmi  Win32_Product   |select name,Version |sort name  |out-file  $prevSPSFile -Force -append

ii $prevSPSFile

#------------------------------------
#step 2  Install-SP2013RolesFeatures.ps1
#------------------------------------
SP01_installconfg.ps1  719  Install-SP2013RolesFeatures.ps1

C:\Sharepoint2013preReqFiles
$prevWindowsFeature='C:\Demos\prevWindowsFeature.txt'


Get-WindowsFeature | ? Installed |out-file $prevWindowsFeature -append  ;ii $prevWindowsFeature

Add-WindowsFeature Net-Framework-Features,Web-Server,Web-WebServer,Web-Common-Http,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors `
,Web-App-Dev,Web-Asp-Net,Web-Net-Ext,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Health,Web-Http-Logging,Web-Log-Libraries,Web-Request-Monitor `
,Web-Http-Tracing,Web-Security,Web-Basic-Auth,Web-Windows-Auth,Web-Filtering,Web-Digest-Auth,Web-Performance,Web-Stat-Compression `
,Web-Dyn-Compression,Web-Mgmt-Tools,Web-Mgmt-Console,Web-Mgmt-Compat,Web-Metabase,Application-Server,AS-Web-Support,AS-TCP-Port-Sharing `
,AS-WAS-Support,AS-HTTP-Activation,AS-TCP-Activation,AS-Named-Pipes,AS-Net-Framework,WAS,WAS-Process-Model,WAS-NET-Environment `
,WAS-Config-APIs,Web-Lgcy-Scripting,Windows-Identity-Foundation,Server-Media-Foundation,Xps-Viewer -source C:\sxs

$postWindowsFeature='C:\Demos\postWindowsFeature.txt'


Get-WindowsFeature | ? Installed |out-file $postWindowsFeature -append  ;ii $postWindowsFeature



$prevgsv='C:\Demos\prevgsv.txt' ; ii $prevgsv



Restart-Computer

shutdown -r -f
#------------------------------------
# step 3  Install-SP2013PreReqFiles.ps1 
#------------------------------------
  SP01_installconfg.ps1  890  Install-SP2013PreReqFiles.ps1  
   先將iso unzip to Folder(like SP2013source) ,
 再將已Download DownLoadPreRequisites copy to \SP2013source\prerequisiteinstallerfiles\*.*
 設定 $SharePoint2013Path='C:\SP2013source'
 直接執行 InstallPreReqFiles .會出現安裝畫面, 會自動一直run 下去. 5 about mins 即會OK
 記得 安裝Software 不要用ISO模擬光碟機. 會出問題

#------------------------------------
#  step 4  install 
#------------------------------------

僅安裝(install)不進行設定(configuration).
. C:\SP2103software\setup.exe
 NQTMW-K63MQ-39G6H-B2CH9-FRDWJ (Trial)
  P4GN7-G2J3K-XPQYT-XG4J4-F6WFV (M3)
  & 'C:\Program Files\Microsoft Office Servers'

  Index file : C:\Program Files\Microsoft Office Servers\15.0\Data


## check 3.1  service on OS
gsv| ?{$_.DisplayName -like '*SharePoint*'} |ft -AutoSize

<#
Status  Name                   DisplayName                                
------  ----                   -----------                                
Stopped DCLauncher15           Microsoft SharePoint Server 2013 的文件轉換啟動器  
Stopped DCLoadBalancer15       Microsoft SharePoint Server 2013 的文件轉換負載平衡器
Stopped OSearch15              SharePoint Server Search 15                
Stopped SPAdminV4              SharePoint Administration                  
Stopped SPSearchHostController SharePoint Search Host Controller          
Stopped SPTimerV4              SharePoint Timer Service                   
Stopped SPTraceV4              SharePoint Tracing Service                 
Stopped SPUserCodeV4           SharePoint User Code Host                  
Stopped SPWriterV4             SharePoint VSS Writer                      
#>

# check 3.2  appwiz.cpl
gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
<# count=10
name                                                                             Version                                                                        
----                                                                             -------                                                                        
Microsoft SharePoint Foundation 2013 1028 Lang Pack                              15.0.4569.1506                                                                 
Microsoft SharePoint Foundation 2013 1028 SQL Express                            15.0.4569.1506                                                                 
Microsoft SharePoint Foundation 2013 Core                                        15.0.4569.1506                                                                 
Microsoft SharePoint Multilingual Solutions                                      15.0.4569.1506                                                                 
Microsoft SharePoint Multilingual Solutions Chinese (Traditional) Language Pack  15.0.4569.1506                                                                 
Microsoft SharePoint Portal                                                      15.0.4569.1506                                                                 
Microsoft SharePoint Portal Chinese (Traditional) Language Pack                  15.0.4569.1506                                                                 
Microsoft SharePoint Server 2013                                                 15.0.4569.1506                                                                 
PerformancePoint Services for SharePoint                                         15.0.4569.1506                                                                 
PerformancePoint Services in SharePoint 1028 Language Pack                       15.0.4569.1506                                                                 
#>

# check 3.3
#先等configuration完成之後
ASNP Microsoft.SharePoint.Powershell
(Get-SPFarm).Products


#------------------------------------
#  step 5  SQL  alias
#------------------------------------
# SQL Server client alias
$AliasName = "SPFarmSQLAlias"


#These are the two Registry locations for the SQL Alias locations
$x86 = "HKLM:\Software\Microsoft\MSSQLServer\Client\ConnectTo"
$x64 = "HKLM:\Software\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo"


#We're going to see if the ConnectTo key already exists, and create it if it doesn't.
if ((test-path -path $x86) -ne $True)
{
    write-host "$x86 doesn't exist"
    New-Item $x86
}
if ((test-path -path $x64) -ne $True)
{
    write-host "$x64 doesn't exist"
    New-Item $x64
}
  
$ServerName = $env:computername
#Adding the extra "fluff" to tell the machine what type of alias it is
$TCPAlias = ("DBMSSOCN," + $ServerName)
  
#Creating our TCP/IP Aliases
New-ItemProperty -Path $x86 -Name $AliasName -PropertyType String -Value $TCPAlias
New-ItemProperty -Path $x64 -Name $AliasName -PropertyType String -Value $TCPAlias
 
# Open cliconfig to verify the aliases
Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

#check 5.1
Invoke-Sqlcmd -Query "SELECT @@servername" -ServerInstance "$AliasName" #-Database $dbName
 
#------------------------------------
#  step 6  SQL 
#------------------------------------
setup SPFarm  to Tempcsd\BIinfraGroup

Tempcsd\BIinfraGroup  have dbcreate & securityadmin

 SQL Server 執行個體的「平行處理原則的最大程度」設定值，未依規定設為 1


#------------------------------------
#  step 7 
#------------------------------------
I amd whoami  tempcsd\infra1

# Service accounts
$DOMAIN = "tempCSD.SYSCOM"
$accounts = @{}
$accounts.Add("SPFarm", @{"username" = "SPFarm"; "password" = "pass@word1"})
$accounts.Add("SPWebApp", @{"username" = "SPWebApp"; "password" = "pass@word1"})
$accounts.Add("SPService", @{"username" = "SPService"; "password" = "pass@word1"})
 
 
Foreach ($account in $accounts.keys) {
    $accounts.$account.Add(`
    "credential", `
    (New-Object System.Management.Automation.PSCredential ($DOMAIN + "\" + $accounts.$account.username), `
    (ConvertTo-SecureString -String $accounts.$account.password -AsPlainText -Force)))
}
 
"-------------------------7.0 Add-PSSnapin    -----------------------"

$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}
# Values mentioned below needs to be edited
$DatabaseServer = $AliasName  ; #SPecify the instance name if SQL is not installed on default instance$FarmName = $ServerName ; #Hostname$ConfigDB = $FarmName+"_ConfigDB";$AdminContentDB = $FarmName+"_CentralAdminContent";$Passphrase = convertto-securestring "p@ssw0rdx" -asplaintext -force;$Port = "2013";$Authentication = "NTLM";#$FarmAccount = "tempcsd\spFarm"
$FarmAccount = $accounts.SPFarm.credential  #tempCSD.SYSCOM\SPFarm
"-------------------------7.1 Found SharePoint Server 2013 Binaries. Will create Farm now------------------------"New-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer `-FarmCredentials (Get-Credential $farmAccount) -Passphrase $Passphrase `-AdministrationContentDatabaseName $AdminContentDB#Disconnect-SPConfigurationDatabase -Confirm:$false#get-help Disconnect-SPConfigurationDatabase -full#Remove-PSSnapin Microsoft.SharePoint.PowerShell#Add-PSSnapin Microsoft.SharePoint.PowerShell#check 7.1$farm = Get-SPFarm
if (!$farm -or $farm.Status -ne "Online") {
    Write-Output "Farm was not created or is not running"
    exit
}"-------------------------7.2  Installed Help Collection------------------------"$t1=get-dateInstall-SPHelpCollection -All#Get-help Install-SPHelpCollection  -full# get-sphelpcollectionC:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\HCCab\1028\Install-SPHelpCollection Cmdlet 會在目前的伺服器陣列安裝 SharePoint 2010 產品的 Help 網站集合檔案。使用 LiteralPath 參數可安裝特定的自訂 Help 集合檔案。若未指定 LiteralPath 參數，即會安裝 Help 網站集合所有可用的 Help，並覆寫現有的 Help 集合檔案。$t2=get-date"-------------------------7.3  Initialized SP Resource Security------------------------"$t1=get-dateInitialize-SPResourceSecurity$t2=get-date"-------------------------7.4 Created Central Administration Site   inetmgr------------------------"$t1=get-dateNew-SPCentralAdministration -Port $Port -WindowsAuthProvider 'NTLM'$t2=get-date; $t2-$t1 #2min,15 sec#check 可以登入 http://localhost:2013/ (remember: spfarm , pass@word1 才是管理帳號)#check (Get-SPFarm).Products<#9ff54ebc-8c12-47d7-854f-3865d4be8118                                                                                                                                        
298a586a-e3c1-42f0-afe0-4bcfdc2e7cd0 #>#checkGo to Central Administration.Click on “Upgrade and Migration” on the Quick Links. Click on “Check Product and Patch Installation Status” #checkgsv | ? displayname -Like '*SharePoint*' |ft -AutoSize<#Status  Name                   DisplayName                                
------  ----                   -----------                                
  Stopped DCLauncher15           Microsoft SharePoint Server 2013 的文件轉換啟動器  
  Stopped DCLoadBalancer15       Microsoft SharePoint Server 2013 的文件轉換負載平衡器
  Stopped OSearch15              SharePoint Server Search 15                
Running SPAdminV4              SharePoint Administration                  
  Stopped SPSearchHostController SharePoint Search Host Controller          
Running SPTimerV4              SharePoint Timer Service                   
Running SPTraceV4              SharePoint Tracing Service                 
  Stopped SPUserCodeV4           SharePoint User Code Host                  
  Stopped SPWriterV4             SharePoint VSS Writer  Running W3SVC                    World Wide Web Publishing Service#>$postgsv='C:\Demos\postgsv.txt'
gsv |ft -auto |out-file $postgsv -force  -Width  160 ;ii $postgsv
#check$W3SVC=Get-Service | ?{$_.Name -eq 'W3SVC'} ; $W3SVC |select *
<#
Name                : W3SVC
RequiredServices    : {WAS, HTTP}
CanPauseAndContinue : False
CanShutdown         : True
CanStop             : True
DisplayName         : World Wide Web Publishing Service
DependentServices   : {w3logsvc}
MachineName         : .
ServiceName         : W3SVC
ServicesDependedOn  : {WAS, HTTP}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
Site                : 
Container           : 
#>


#check(get-command *get-SP*).count ;190#Get-SPServiceApplicationPool<#Name                                     ProcessAccountName                                                                                                                 
----                                     ------------------                                                                                                                 
SecurityTokenServiceApplicationPool      TEMPCSD\SPFarm                                                                                                                     
SharePoint Web Services System           TEMPCSD\SPFarm #>SPServiceApplicationProxyGroup  <#FriendlyName                     Proxies                                                               DefaultProxies                                                       
------------                     -------                                                               --------------                                                       
[default]                        {}                                                                    {}            #>#add-SPServiceApplicationProxyGroupMember  SPServiceApplicationProxy<# Null #>get-SPServiceHostConfig<#HttpPort                : 32843
HttpsPort               : 32844
NetTcpPort              : 32845
SslCertificateStoreName : SharePoint
SslCertificateFindType  : FindBySubjectDistinguishedName
SslCertificateFindValue : CN=SharePoint Services, OU=SharePoint, O=Microsoft, C=US#>Get-SPDatabase |ft -AutoSize<#Name                                Id                                   Type 
----                                --                                   ---- 
WIN-2S026UBRQFO_ConfigDB            23c7684b-3081-487e-92c9-909dbdc7857b 設定資料庫
WIN-2S026UBRQFO_CentralAdminContent 1877b232-1538-44ac-b215-7121f5c36ba6 內容資料庫#>"-------------------------------------------------------------------------""-------------------------7.5 Instaled SPService  ------------------------""-------------------------------------------------------------------------"在伺服器陣列上安裝及佈建  Servcie 服務 此 Cmdlet 會安裝本機伺服器電腦上的登錄中指定的所有服務、服務執行個體及服務 Proxy。在建立的指令碼中使用此 Cmdlet，可安裝及部署 SharePoint 伺服器陣列，或是安裝自訂開發的服務# get SPServiceInstance 安裝前sp01_installconfg 12  450  Manage services on server  for SharepointGet-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto
<# count 7 ,5 online, 2 disableStatus TypeName                                  Id                                  
  ------ --------                                  --                                  
  Online Microsoft SharePoint Foundation Web 應用程式   Microsoft SharePoint Foundation Web Application      8200bcb2-3997-4a29-8908-be9d3b788ea7
  Online Microsoft SharePoint Foundation 工作流程計時器服務  2c9ee7e1-589d-4148-be12-cd531c2d7efd
  Online Microsoft SharePoint Foundation 內送電子郵件       e6997d4e-ad9a-4fee-a360-e6751a57237a
  Online 分散式快取  (Distributed Cache)                    18ed1aa2-effc-4638-aaf7-7c3024f3dc27
  Online 管理中心   (Central Administration)               51dc6952-dd56-4d3b-9fb5-eb84b34bc264
Disabled Microsoft SharePoint Foundation 沙箱化程式碼服務   578e8222-a5ce-4ce3-aa25-e64660e221a4
Disabled 要求管理   (Request Management)                  41589d67-0b85-4882-9d33-f70000a96e42#>$t1=get-datewrite-host -f Yellow "Install-SPService   ... Loading now"Install-SPService$t2=get-date ;($t2-$t1)  #34secwrite-host -f Green "Install-SPService is now loaded"# get SPServiceInstance 安裝後Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto(Get-SPServiceInstance -Server  $env:COMPUTERNAME ).count<#  count=30, 增加 27個PS C:\Windows\system32> Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto

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
Disabled 對 Windows Token 服務的宣告                     8efab8a2-b021-490d-90e0-41af65cecb28#>(gsv |ft -AutoSize).count  #186gsv | ? displayname -Like '*sharepoint*' |ft -AutoSize gsv |ft -AutoSize gsv |? displayname -eq '啟動器服務' |select *gsv |? name -eq 'spworkflowtimerv4' |select *Get-SPServiceInstance |select servcieGet-SPServiceInstance -Identity 51dc6952-dd56-4d3b-9fb5-eb84b34bc264 |select *Get-SPServiceInstance |select typename,Service,Status |ft -AutoSizeGet-SPServiceInstance -Identity 664a26df-6f6c-4ae2-9c72-d0276737273a |gm# get SPServiceApplicationGet-SPServiceApplication | ft -AutoSizeUI : Application Management > service applications > Manage services on server <#DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
#>Get-SPServiceApplication | ft -AutoSize<#  得出來的值不變,代表僅是安isplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
#>"-------------------------------------------------------------------------""-------------------------7.6 Installed SP Feature------------------------""-------------------------------------------------------------------------"prev-install : ref 528  SPFeature prev  get , install, enable , uninstall$t1=get-datewrite-host -f Yellow "Install-SPFeature   ... Loading now"Install-SPFeature -AllExistingFeatures$t2=get-date ;($t2-$t1)  #  1m 48 Secwrite-host -f Green "Install-SPFeature is now loaded"安裝完成之後。由原本　60 個增加為 657個#Uninstall-SPFeature -AllExistingFeatures#get-help Uninstall-SPFeature -fullGet-SPFeature"-------------------------------------------------------------------------""-------------------------7.7 Installed Application Content. This was the last step.""-------------------------------------------------------------------------"Install-SPApplicationContent$featurefoler=“$env:ProgramFiles\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\”
ii $featurefoler  ; count=409

"-------------------------------------------------------------------------""7.8 Farm Configuration Complete!""-------------------------------------------------------------------------"#Start Central Administration
Write-Output "Starting Central Administration"
& 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\BIN\psconfigui.exe' -cmd showcentraladmin


#------------------------------------
#  step 8   restore database &  SSAS cube
#------------------------------------
I am whoami  : tempcsd\infra1



#------------------------------------
#  step 9  excel service
#------------------------------------


"-------------------------9.0 Add-PSSnapin    -----------------------"$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}

"---------- 523 ---------------9.1 建立BI專屬 ApplicaionPool   BIApplicationPool -----------------------"
#9.1.1 註冊帳戶

$ServiceApplicationUser = "CSD\SPexcel" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "p@ssw0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword  
$ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials  


get-SPManagedAccount  #tempcsd\spfarm only
$cred = Get-Credential tempcsd\SPService
New-SPManagedAccount  -Credential $cred 
get-SPManagedAccount  #tempcsd\spfarm  +tempcsd\SPService


#9.1.2 
get-SPServiceApplicationPool
New-SPServiceApplicationPool -Name BIApplicationPool -Account tempcsd\SPService
get-SPServiceApplicationPool  BIApplicationPool  |select *
'
ProcessAccountName          : TEMPCSD\SPService
Name                        : BIApplicationPool
ProcessAccount              : S-1-5-21-2468440410-1141623422-109008057-1149
TypeName                    : Microsoft.SharePoint.Administration.SPIisWebServiceApplicationPool
DisplayName                 : BIApplicationPool
Id                          : 11c52a3a-13b3-4a4b-982c-31681c3860e0
Status                      : Online
Parent                      : SPIisWebServiceSettings Name=SharePoint Web Services
Version                     : 10375
Properties                  : {}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}'
:inetmgr
名稱:  11c52a3a13b34a4b982c31681c3860e0
實際路徑 :C:\Program Files\Microsoft Office Servers\15.0\WebServices\Shared\ExcelCalculationServer

由可確定  inetmgr.名稱 = SPServiceApplicationPool.Id

"-----------  561 -------------9.2  Start the Excel Calculation Services service (SI)  --------------------------------"
Get-SPServiceInstance | ?  TypeName -eq 'Excel Calculation Services'  # 8ee5a10b-7777-4754-b461-ce21d5cfd45e
Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' |Start-SPServiceInstance
Get-SPServiceInstance | ?  TypeName -eq 'Excel Calculation Services'   # status = online


"------------- 567 ------------9.3  Create an Excel Services service application(SA)   --------------------------------"

Get-SPServiceApplication |ft -AutoSize
'PS C:\Windows\system32> Get-SPServiceApplication |ft -AutoSize

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359

'

$SPServiceApplicationPoolName='BIApplicationPool'
New-SPExcelServiceApplication -Name "ExcelServiceM" -ApplicationPool $SPServiceApplicationPoolName

Get-SPServiceApplication |ft -AutoSize
'Get-SPServiceApplication |ft -AutoSize

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                              56d693a1-e399-4605-8109-08730467ccc2
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
'

UI > Application Management   >  Manage service applications 
'
$excelserviceDisplayname=Get-SPExcelServiceApplication |select DisplayName
$excelserviceDisplayname.DisplayName

Remove-SPServiceApplication(Get-SPExcelServiceApplication) -Confirm:$false

Remove-SPServiceApplicationProxy babab30e-8e3a-428b-8ff4-4d5c8f455e6d

Get-SPExcelBlockedFileType       Get  New  Remove
Get-SPExcelDataConnectionLibrary Get  New  Remove  set
Get-SPExcelDataProvider          Get  New  Remove  set
Get-SPExcelFileLocation          Get  New  Remove  set
Get-SPExcelServiceApplication    Get  New          set
Get-SPExcelUserDefinedFunction   Get  New  Remove  set
'


下列兩者是相同地
Get-SPExcelServiceApplication  |select *  #TypeName : Excel Services 應用程式 Web 服務應用程式
                                          #ServiceApplicationProxyGroup : SPServiceApplicationProxyGroup
Get-SPServiceApplication |? displayname -EQ  ExcelServiceM  |select *


Get-SPServiceApplicationProxy |select *  #TypeName :Excel Services 應用程式 Web 服務應用程式 Proxy

get-SPServiceApplicationProxyGroup
'PS C:\Windows\system32> get-SPServiceApplicationProxyGroup

FriendlyName                     Proxies                                                               DefaultProxies                                                       
------------                     -------                                                               --------------                                                       
[default]                        {}                                                                    {}                                                                   

'
 GET-SPServiceApplicationProxyGroupMember 

#------------------------------------
#  step 10  執行 PowerPivot for SharePoint 2013 安裝  ，安裝 SharePoint 模式的 Analysis Services 伺服器 (SSASPT)
#------------------------------------
whoami  #tempcsd\infra1


步驟 1：安裝 PowerPivot for SharePoint
步驟 2：設定基本 Analysis Services SharePoint 整合
步驟 3：確認整合
設定 Windows 防火牆以允許 Analysis Services 存取
升級活頁簿和排程的資料重新整理

"-------------- 640 -----------10.1  安裝 PowerPivot for SharePoint  --------------------------------"

#10.1.1
cmd /c ("e:\Setup") '/ConfigurationFile=C:\Demos\SQLServer2012\Scripts\SSASPT_ConfigurationFile.ini'
gsv -Name 'MSOLAP$SSASPT'

#10.1.2 將 Analysis Services 的伺服器管理權限授與 Excel Services 
https://msdn.microsoft.com/en-us/library/jj219067.aspx#InstallSQL
 

#10.1.3
  環境有防火牆，請檢閱《SQL Server 線上叢書》主題＜設定 Windows 防火牆以允許 Analysis Services 存取＞。
  Configure the Windows Firewall to Allow Analysis Services Access
Use the information in the topic Configure the Windows Firewall to Allow Analysis Services Access to determine whether you need to unblock ports in a firewall to allow access to Analysis Services or Power Pivot for SharePoint. You can follow the steps provided in the topic to configure both port and firewall settings. In practice, you should perform these steps together to allow access to your Analysis Services server.


#10.1.4  configure Execl Servcies for analysis service integratin
https://msdn.microsoft.com/en-us/library/jj219067.aspx#InstallSQL

In SharePoint Central Administration, in the Application Management group, click Manage Service Applications.
Click the name of your service application, the default is Excel Services Application.
On the Manage Excel Services Application page, click Data Model Settings.
   Excel Services 應用程式 資料模型設定   http://localhost:2013/_admin/ExcelServerBIServers.aspx?Id=56d693a1e3994605810908730467ccc2

Click Add Server. (新增 伺服器  http://localhost:2013/_admin/ExcelServerBIServer.aspx?Task=Add&Id=56d693a1e3994605810908730467ccc2 )


In Server Name, type the Analysis Services server name and the Power Pivot instance name. For example MyServer\POWERPIVOT. The Power Pivot instance name is required.
Type a description.
Click Ok.
The changes will take effect in a few minutes or you can Stop and Start the service Excel Calculation Services. To
Another option is to open a command prompt with administrative privileges, and type iisreset /noforce.


#10.1.5 verify the integration 

The following steps walk you through creating and uploading a new workbook to verify the Analysis Services integration. 
You will need a SQL Server database to complete the steps.

(1).If you already have an advanced workbook with slicers or filters, you can upload it to your SharePoint document library and verify you are able to interact with the slicers and filters from the document library view.
(2).Start a new workbook in Excel.
(3).On the Data tab, click From Other Sources on the ribbon in the Get External Data.
(4).Select From SQL Server.
(5).In the Data Connection Wizard, enter the name of the SQL Server instance that has the database you want to use.
(6).or Log on credentials, verify that Use Windows Authentication is selected, and then click Next.
(7).Select the database you want to use.
(8)Verify that the Connect to specific table checkbox is selected.
(9)Click the Enable selection of multiple tables and add tables to the Excel Data Model checkbox.
(10)Select the tables you want to import.
(11)Click the checkbox Import relationships between selected tables, and then click Next.
    Importing multiple tables from a relational database lets you work with tables that are already related. 
    You save steps because you donot have to build the relationships manually.
(12)In the Save Data Connection File and Finish page of the wizard, type a dame for your connection and click Finish.
(13)The Import Data dialog box will appear. Choose PivotTable Report, and then click Ok.
(14)A PivotTable Field List appears in the workbook. On the field list, click the All tab
(15)Add fields to the Row, Columns, and Value areas in the field list.
(16)Add a slicer or a filter to the PivotTable. Do not skip this step. A slicer or filter is the element that will help you verify your Analysis Services installation.
(17)Save the workbook to a document library on a SharePoint Server 2013 that has Excel Services configured. You can also save the workbook to a file share and then upload it to the SharePoint Server 2013 document library.
(18)Click the name of your workbook to view it in SharePoint and click the slicer or change the filter that you previously added. If a data update occurs, you know that Analysis Services is installed and available to Excel Services. If you open the workbook in Excel you will be using a cached copy and not using the Analysis Services server.






#------------------------------------
#  step 11  Install or Uninstall the PowerPivot for SharePoint Add-in (SharePoint 2013)
#------------------------------------
I am whoami  : tempcsd\infra1

SpPowerPivot.msi 是SQLServer 提供(出品).QL Server 2014 PowerPivot for SharePoint 2013 在 SharePoint 2013 伺服器陣列中提供增強型 PowerPivot 功能和經驗。
這些功能包括使用活頁簿做為  資料來源、排程資料重新整理、 PowerPivot 圖庫  與 PowerPivot 管理儀表板

由於有SQL2012 , 
SQL2014   spPowerPivot_SQL_2014.msi  存放在  \\192.168.112.129\h$\software2015\SQL_PowerPivot_msi 

"------------- 716 ------------11.0 Add-PSSnapin    -----------------------"

$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}

"--------------726 -----------11.1 check    -----------------------"
Get-SPFarm
Get-SPFarmConfig |select *

Get-SPProcessAccount

Get-SPWebTemplate |sort name
Get-SPWebTemplate "STS*" -CompatibilityLevel 

##
Get-SPServiceApplicationPool |select *
<#
Name                                     ProcessAccountName                                                                                                                 
----                                     ------------------                                                                                                                 
SecurityTokenServiceApplicationPool      TEMPCSD\SPFarm                                                                                                                     
SharePoint Web Services System           TEMPCSD\SPFarm 


PS SQLSERVER:\> Get-SPServiceApplicationPool |select *


ProcessAccountName          : TEMPCSD\SPFarm
Name                        : SecurityTokenServiceApplicationPool
ProcessAccount              : S-1-5-21-2468440410-1141623422-109008057-1148
TypeName                    : Microsoft.SharePoint.Administration.SPIisWebServiceApplicationPool
DisplayName                 : SecurityTokenServiceApplicationPool
Id                          : 42480c58-6c86-4d45-881e-665b35d5c8d7
Status                      : Online
Parent                      : SPIisWebServiceSettings Name=SharePoint Web Services
Version                     : 2852
Properties                  : {}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}

ProcessAccountName          : TEMPCSD\SPFarm
Name                        : SharePoint Web Services System
ProcessAccount              : S-1-5-21-2468440410-1141623422-109008057-1148
TypeName                    : Microsoft.SharePoint.Administration.SPIisWebServiceApplicationPool
DisplayName                 : SharePoint Web Services System
Id                          : 7d67882a-542c-48a4-8b16-99d553ed198f
Status                      : Online
Parent                      : SPIisWebServiceSettings Name=SharePoint Web Services
Version                     : 2883
Properties                  : {}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}

在 inetmgr中的的應用程式集區可以看到 ３個新增的　ａｐｐｌｉｃａｔｉｏｎ　Ｐｏｏｌ
    SecurityTokenServiceApplicationPool   ()
      

    7d67882a-542c-48a4-8b16-99d553ed198f  ( SharePoint Web Services System  )
      實體路徑: C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\WebServices\Topology
    ii C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\WebServices\Topology
#>

##  
Get-SPServiceApplication |select name, displayname,typename,id |ft -AutoSize ;'
Name                            DisplayName                                                 TypeName                                                    Id                  
----                            -----------                                                 --------                                                    --                  
SecurityTokenServiceApplication Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f...
Topology                        Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c3...
'

#>
Get-SPServiceApplication -Name SecurityTokenServiceApplication |select *
Get-SPServiceApplication -Name Topology |select *

## ref C:\Users\administrator.CSD\OneDrive\download\PS1\SP04_FeatureSolution.ps1
(Get-SPFeature).count  #657
(Get-SPFeature -Farm).count  #72
Get-SPFeature |select * 
Get-SPFeature -WebApplication

Get-SPFeature | select Name,title,scope,ID,description

$lcid=1028

$delimiter = "*"
Get-SPFeature -Limit ALL | % { Get-SPFeature -Identity $_ | % { $_.DisplayName + $delimiter + $_.GetTitle($lcid) +$delimiter +$_.Scope + $delimiter + $_.Id + $delimiter + $_.GetDescription($lcid)} } >> c:\temp\feature.csv

Get-SPFeature -Limit ALL | % { Get-SPFeature -Identity $_ | % { $_.DisplayName , $_.GetTitle($lcid),$_.Scope , $_.Id , $_.GetDescription($lcid)} } |ft -AutoSize

Get-SPFeature |select name,displayname
$objects=Get-SPFeature |? CompatibilityLevel -EQ 15 |sort scope ,displayname;$objects.count

select name,displayname

$objects=Get-SPFeature |select name,displayname
$objects |gm

foreach ($object in $objects)
{
$object.DisplayName+"-"+$object.GetTitle($lcid)+"-"+$object.GetDescription($lcid)+"-"+$object.Scope #|select * 
  
  #Write-Host -NoNewline  $object.DisplayName +'--'+  $object.GetTitle($lcid)  `n
}


ii C:\temp\feature.csv

#  Get-SPSolution
<#Null#>
Get-SPServiceApplication |ft -AutoSize ;'DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                              56d693a1-e399-4605-8109-08730467ccc2
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
'



"--------------- 838 ----------11.2   download   -----------------------"
Microsoft® SQL Server® 2012 SP1 PowerPivot® for Microsoft SharePoint®
https://www.microsoft.com/en-us/download/details.aspx?id=35577

Microsoft® SQL Server® 2014 PowerPivot for Microsoft SharePoint®
http://www.microsoft.com/en-us/download/details.aspx?id=42300
http://www.microsoft.com/zh-TW/download/details.aspx?id=42300


also copy from \\192.168.112.129\h$\software2015\SQL_PowerPivot_msi  (Sep.7.2015)


"--------------- 850 ----------11.3   決定安裝伺服器環境   -----------------------"

https://msdn.microsoft.com/en-us/library/hh231674.aspx

PowerPivot for sharepoint 2013 and Reporting service: single server (excel SA + Powerpivot SA, Reporting Service + reporint SA + reporting Service Add-in)
PowerPivot for sharepoint 2013 and Reporting service : two server 
PowerPivot for sharepoint 2013 and Reporting service : three server

PowerPivot for sharepoint 2013  : single server (excel , default power pivot server application , dbs , SSASPT) 
PowerPivot for sharepoint 2013  : two server (server1: SSASPT, DBs . server 2 :  execl + PowerPivot SA, sppowerpivot.msi
PowerPivot for sharepoint 2013  three server

"---------------- 862 ---------11.4   開始安裝  msi      -----------------------"
用來部署 Analysis Services 用戶端程式庫和複製 PowerPivot for SharePoint 2013 安裝檔案到本機電腦。
此安裝程式不會在 SharePoint 中部署或設定任何功能。(所以要自已設定)
下列檔案預設會安裝於本機電腦：

(1) 這包含適用於 SharePoint 2013 的 PowerPivot 方案檔  
    (伺服器陣列層級 :PowerPivotFarmSolution.WSP   :兩個檔案的範圍是網站集合層級 PowerPivotFarm14Solution.wsp & PowerPivotWebApplicationSolution.wsp)
    複製到下列資料夾：  C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources
(2)    PowerPivot for SharePoint 2013 組態工具以及用來在 SharePoint 中部署這些方案檔和設定 PowerPivot 的。
(3)Microsoft OLE DB Provider for Analysis Services (MSOLAP)。
(4)ADOMD.NET 資料提供者。
(5)SQL Server 2014 Analysis Management Objects。
Msiexec.exe /i SpPowerPivot.msi。

安裝完成後 有三個ps1 
C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources
ConfigurePowerPivot.ps1
UnconfigurePowerPivot.ps1
UpgradePowerPivot.ps1



"---------------- 884 ---------11.5   設定 by UI      -----------------------"
 
 會在 Microsoft SQL server 2014 中新增   PowerPivot for Sharepoint 

"---------------- 888 ---------11.6   設定 by  PS1        -----------------------"
C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources



# 開啟 PowerShell 程式庫來源: C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources\ConfigurePowerPivot.ps1

#(1) 加入Farm Solution
Get-SPSolution
Add-SPSolution -LiteralPath 'C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources\powerpivotfarmsolution.wsp'

#Add-SPSolution –LiteralPath “C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\ConfigurationTool\Resources\PowerPivotFarm.wsp”

Add-SPSolution -LiteralPath 'C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources\PowerPivotFarm14Solution.wsp'
Add-SPSolution -LiteralPath 'C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources\powerpivotwebapplicationsolution.wsp'
Get-SPSolution |ft -auto
'PS C:\Windows\system32> Get-SPSolution |ft -auto

Name                                 SolutionId                           Deployed
----                                 ----------                           --------
powerpivotfarm14solution.wsp         20556862-2287-4547-ae18-66e95a471271 False   
powerpivotfarmsolution.wsp           28201e83-6a35-4237-9ac0-4323f3d28497 False   
powerpivotwebapplicationsolution.wsp e51f7fb9-2272-4e77-a2af-7a070edd82b6 False '

#(2) DeployFarmSolution $false

Install-SPSolution -Identity powerpivotfarmsolution.wsp –CompatibilityLevel NewVersion -GACDeployment -Force

Start-Sleep -s 20
$solution='PowerPivotFarm14Solution.wsp'
Install-SPSolution -Identity $solution -GACDeployment -Force
$count = 0
    while(!$solution -and $count -lt 10)
    {
        "PowerPivot Solution is not added to farm yet. Wait 3 seconds and check again."
        Start-Sleep -s 3
        ($count)++
        $solution = Get-SPSolution $solutionName -ErrorAction:SilentlyContinue
    }
Get-SPSolution |ft -auto
    


#(3)將 wsp 部置至管理中心
DeployWebAppSolutionToCentralAdmin $false
$solutionName='powerpivotwebapplicationsolution.wsp'
 $centralAdmin = $(Get-SPWebApplication -IncludeCentralAdministration | Where { $_.IsAdministrationWebApplication -eq $TRUE}) #|ft -AutoSize
'DisplayName                          Url                         
-----------                          ---                         
SharePoint Central Administration v4 http://win-2s026ubrqfo:2013/'

$solution=Install-SPSolution -Identity $solutionName –CompatibilityLevel NewVersion -GACDeployment -Force -WebApplication $centralAdmin -FullTrustBinDeployment
$count = 0
    while(!$solution -and $count -lt 10)
    {
        "PowerPivot Solution is not added to farm yet. Wait 3 seconds and check again."
        Start-Sleep -s 3
        ($count)++
        $solution = Get-SPSolution $solutionName -ErrorAction:SilentlyContinue
    }

    Get-SPSolution
'Name                           SolutionId                           Deployed              
----                           ----------                           --------              
powerpivotfarm14solution.wsp   20556862-2287-4547-ae18-66e95a471271 True                  
powerpivotfarmsolution.wsp     28201e83-6a35-4237-9ac0-4323f3d28497 True                  
powerpivotwebapplicationsol... e51f7fb9-2272-4e77-a2af-7a070edd82b6 True                  
'

#  957 (4)
會在找到  PowerPivotFarm ,PowerPivotCA ,PowerPivotSite 三個folder 在(4),(5),(6)中分別執行 ,
ii "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\”

(Get-SPFeature).count #657
Install-SPFeature -path PowerPivotFarm -Force;'DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PowerPivotFarm                 f8c51e81-0b46-4535-a3d5-244f63e1cab9     15                   Farm                          
'
(Get-SPFeature).count  #658

Install-SPFeature -path PowerPivotFarm -Force -CompatibilityLevel 14;'PS C:\Windows\system32> Install-SPFeature -path PowerPivotFarm -Force -CompatibilityLevel 14


DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PowerPivotFarm                 f8c51e81-0b46-4535-a3d5-244f63e1cab9     14                   Farm                          
'
(Get-SPFeature).count  #659

#  977 (5)管理中心功能

Install-SPFeature -path PowerPivotCA -Force;'Install-SPFeature -path PowerPivotCA -Force

DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PowerPivotCA                   4f31948e-8dc7-4e67-a4b7-070941848658     15                   Web                           

PS C:\Windows\system32> (Get-SPFeature).count  #659
660
'
(Get-SPFeature).count  #660

#  990 (6)網站層級功能  InstallSiteCollectionFeatures
(Get-SPFeature).count  #660
Install-SPFeature -path PowerPivotSite -Force
(Get-SPFeature).count  #661
Install-SPFeature -path PowerPivotSite -CompatibilityLevel 14 -Force
(Get-SPFeature).count  #662


#  998 (7) create  service Instance 
#remember . reopen  powershell_ise  then Add-PSSnapin Microsoft.SharePoint.PowerShell again

Get-Help '*powerpivot*'
Get-help new-powerpivotserviceapplication -full


Get-PowerPivotSystemServiceInstance ;'null'
(Get-spserviceinstance).count  #30
$t1=get-date
New-PowerPivotSystemServiceInstance -Provision:$true
$t2=get-date;($t2-$t1) #
(Get-spserviceinstance).count #31
Get-PowerPivotSystemServiceInstance ;'PS C:\Windows\system32> Get-PowerPivotSystemServiceInstance

TypeName                         Status   Id                                  
--------                         ------   --                                  
SQL Server PowerPivot 系統服務       Online   f824a789-f02b-4c88-aa22-b432812c3cdc'

#-Remove-PowerPivotSystemServiceInstance

#  1019 (8) 建立 PowerPivot SA
get-spserviceapplication;'DisplayName          TypeName             Id                                  
-----------          --------             --                                  
ExcelServiceM        Excel Services 應用... 56d693a1-e399-4605-8109-08730467ccc2
Security Token Se... Security Token Se... 1a88193f-2f77-48f7-a276-19a3c70baa16
Application Disco... Application Disco... 84044cab-bf1d-4c31-8897-35e99c777359
WSS_UsageApplication Usage and Health ... af8fc817-284b-4d6f-be82-d7d5a310bd97
'

New-PowerPivotServiceApplication -ServiceApplicationName 'PowerPivot Service ApplicationM' `
-DatabaseServerName 'SPFarmSQLAlias' -DatabaseName 'PowerPivotServiceApplicationDB' -AddToDefaultProxyGroup:$true

#New-PowerPivotServiceApplication -ServiceApplicationName "PowerPivot Service Application"
# -DatabaseServerName "AdvWorks-SRV01\PowerPivot" -DatabaseName "PowerPivotServiceApp1" -AddtoDefaultProxyGroup:$true

get-spserviceapplication

#  1036 (9)   PowerPivot 系統服務物件的全域屬性。
Get-PowerPivotSystemService;'PS C:\Windows\system32> Get-PowerPivotSystemService


CurrentSolutionVersion         : 12.0.2468.0
DirectTCPConnections           : False
DiagnosticTraceLimit           : 20
DiagnosticTraceIntervalSeconds : 10
CanUpgrade                     : True
TypeName                       : SQL Server PowerPivot Service Application
Instances                      : {}
Applications                   : {}
Required                       : False
JobDefinitions                 : {PowerPivot Dashboard Processing Timer Job, PowerPivot Data Refresh Timer Job, PowerPivot Health Statisti
                                 cs Collector Timer Job, 每日-any-midtierservice-health-analysis-job...}
RunningJobs                    : {}
JobHistoryEntries              : {, , , ...}
IsBackwardsCompatible          : True
NeedsUpgradeIncludeChildren    : True
NeedsUpgrade                   : True
UpgradeContext                 : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                           : 
DisplayName                    : 
Id                             : f0e4ef51-e90e-4b13-ae8c-d91036c5f6b1
Status                         : Online
Parent                         : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
Version                        : 11037
Properties                     : {}
Farm                           : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties    : {}'
Set-PowerPivotSystemService -Confirm:$false;'PS C:\Windows\system32>Set-PowerPivotSystemService -Confirm:$false
PowerPivot system service instance was successfully updated'




#(10)  1072 建立 WA

#CreateWebApplication 'PowerPivot- 80' 'http://pp.tempcsd.syscom' 'BIApplicationPool' 'TEMPCSD\spService' $password 'SPFarmSQLAlias' 'PowerPivotWebApplicationDB'
$name      ='PowerPivot- 80'
$url       ='http://pp.tempcsd.syscom'
$appPool   ='BIApplicationPool'
$appAccount='TEMPCSD\spService'
$appAccountPassword ='pass@word1'
$dbServer  ='SPFarmSQLAlias'
$dbName    ='PowerPivotWebApplicationDB'

$appPoolManagedAccount = Get-SPManagedAccount $appAccount -ErrorAction:SilentlyContinue
#$appPoolManagedAccount = Get-SPManagedAccount 'ttttee' -ErrorAction:SilentlyContinue

    if($appPoolManagedAccount -eq $null)
    {
        $appPoolAccount = New-Object System.Management.Automation.PSCredential ($appAccount, $appAccountPassword)
        $appPoolManagedAccount = New-SPManagedAccount $appPoolAccount
    }

Get-SPWebApplication;'Null'

$ap = New-SPAuthenticationProvider
New-SPWebApplication -Name $name -ApplicationPool $appPool -ApplicationPoolAccount $appPoolManagedAccount `
-URL $url -DatabaseServer $dbServer -DatabaseName $dbName -AuthenticationProvider $ap
'DisplayName                    Url                                               
-----------                    ---                                               
PowerPivot- 80                 http://pp.tempcsd.syscom/                         
'
    iisreset

Get-SPWebApplication;'PS C:\Windows\system32> Get-SPWebApplication

DisplayName                    Url                                               
-----------                    ---                                               
PowerPivot- 80                 http://pp.tempcsd.syscom/ '


Get-SPWebApplication -Identity 'PowerPivot- 80' |select *
#New-SPWebApplication -Name $WebAppName -Port $WebAppPort  -URL $Url -HostHeader  $WebAppHostHeader `
#-ApplicationPool $WebAppAppPool -ApplicationPoolAccount (Get-SPManagedAccount $WebAppAppPoolAccount) `
#-DatabaseName $WebAppDatabaseName -DatabaseServer $WebAppDatabaseServer


#(11)  1116 部署 WA Solution
DeployWebAppSolution 'http://pp.tempcsd.syscom' 2047 $false
   
   DNS :create pp.tempcsd.syscom  to IP

   $url='http://pp.tempcsd.syscom' 
   $targetWebApp = Get-SPWebApplication  $url -ErrorAction:SilentlyContinue
   $targetWebApp.MaximumFileSize  # 250
   $targetWebApp.MaximumFileSize = 2047 # 將250M 改成 2G Size
   $targetWebApp.Update()
   $targetWebApp.MaximumFileSize  # 2047

   Install-SPSolution -Identity powerpivotwebapplicationsolution.wsp –CompatibilityLevel NewVersion -GACDeployment -Force `
   -WebApplication $targetWebApp -FullTrustBinDeployment

   UI:用程式管理 > 管理 Web 應用程式  http://localhost:2013/_admin/WebApplicationList.aspx


#  1131 (12)建立網站集合 sitecollection

Get-SPSite;'Null'


$w = Get-SPWebApplication $url

New-SPSite -Url 'http://pp.tempcsd.syscom' -OwnerEmail 'spfarm@tempcsd.syscom.com' -OwnerAlias 'TEMPCSD\spfarm' `
-SecondaryOwnerAlias 'TEMPCSD\infra1' -Template 'PowerPivot#0' -Name  'PowerPivot Site 1140'

#OwnerEmail 驗證必須是 .com
#-HostHeaderWebApplication $w  原沒有,後行自已增加之

UI:  網站集合清單   http://localhost:2013/_admin/SiteCollections.aspx?ReturnSelectionPage=/applications.aspx
IE:  此時仍不行連入

# use cmd - regedit  if spfarm , infra  can not into http://pp.tempcsd.syscom
解決方法
1. Click Start, click Run, type regedit, and then click OK.
2. In Registry Editor, locate and then click the following registry key:    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa
3. Right-click Lsa, point to New, and then click DWORD Value.
4. Type DisableLoopbackCheck, and then press ENTER.
5. Right-click DisableLoopbackCheck, and then click Modify.
6. In the Value data box, type 1, and then click OK.
7. Quit Registry Editor, and then restart your computer.


get-spsite $url |select *

#  1164 (13) 啟用 sitecollection  feature
EnableSiteFeatures 'http://pp.tempcsd.syscom' $true

$url='http://pp.tempcsd.syscom'
    param($url, $enablePremiumFeature)

    get-spfeature -Identity "8581A8A7-CF16-4770-AC54-260265DDB0B2" ;'DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PremiumSite                    8581a8a7-cf16-4770-ac54-260265ddb0b2     15                   Site                          
SharePoint Server 企業版網站集合功能  id 好像是固定的...

'

    $premiumFeature = "8581A8A7-CF16-4770-AC54-260265DDB0B2"

    get-spfeature -Identity "PowerPivotSite"    |select *

    # Enable-SPFeature -Identity "PowerPivotSiteCollection" -URL $url -Force

	Enable-SPFeature -Identity "PowerPivotSite" -URL $url -Force #開啟此網站之下 網站集合的 PowerPivot 功能整合

    if($enablePremiumFeature)
    {
        $site = Get-SPSite $url
        if($site.Features[$premiumFeature] -eq $null)
        {
            Enable-SPFeature -Identity $premiumFeature -URL $url -Force #也開啟此網站之下 SharePoint Server 企業版網站集合功能
        }

        $site.Dispose()
    }


#  1197 (14) 啟用 windows Token 服務
 StartService ="Microsoft.SharePoint.Administration.Claims.SPWindowsTokenServiceInstance"

$serviceType="Microsoft.SharePoint.Administration.Claims.SPWindowsTokenServiceInstance"

Get-SPServiceInstance | ? typename -eq '對 Windows Token 服務的宣告'|select * ;'PS C:\Windows\system32> Get-SPServiceInstance | ? typename -eq '對 Windows Token 服務的宣告'|select * 

Description                 : 允許 Windows 使用者透過宣告驗證登入，從宣告身分識別轉換回原始的 Windows 身分識別。
TypeName                    : 對 Windows Token 服務的宣告
DisplayName                 : 對 Windows Token 服務的宣告
Server                      : SPServer Name=WIN-2S026UBRQFO
Service                     : SPWindowsTokenService Name=c2wts
Instance                    : 
Roles                       : 
Hidden                      : False
SystemService               : False
ManageLink                  : Microsoft.SharePoint.Administration.SPActionLink
ProvisionLink               : Microsoft.SharePoint.Administration.SPActionLink
UnprovisionLink             : Microsoft.SharePoint.Administration.SPActionLink
CanUpgrade                  : True
IsBackwardsCompatible       : True
NeedsUpgradeIncludeChildren : False
NeedsUpgrade                : False
UpgradeContext              : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                        : 
Id                          : 8efab8a2-b021-490d-90e0-41af65cecb28
Status                      : Disabled
Parent                      : SPServer Name=WIN-2S026UBRQFO
Version                     : 7046
Properties                  : {}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}

'
Get-SPServiceInstance | ? {$_.GetType().FullName -eq $serviceType}

$serviceInstances = Get-SPServiceInstance | ? {$_.GetType().FullName -eq $serviceType}
$serviceInstances.Status # disabled
$serviceInstances | start-spserviceinstance
$serviceInstances.Status # Provisiong
$serviceInstances.Status # online



# 1241 (15)  啟動 Secure Store Service SI
StartSecureStoreService

### Constants
	$serviceName = "SecureStoreService"
	
	### make sure secure store service is started
	$serviceInstances = Get-spserviceinstance | ? {$_.Service -match $serviceName} ;'PS C:\Windows\system32> get-spserviceinstance | ? {$_.Service -match $serviceName} |select  * 
TypeName                    : Secure Store Service
Server                      : SPServer Name=WIN-2S026UBRQFO
Service                     : SecureStoreService
Instance                    : 
Roles                       : 
Hidden                      : False
SystemService               : False
Description                 : 
ManageLink                  : Microsoft.SharePoint.Administration.SPActionLink
ProvisionLink               : Microsoft.SharePoint.Administration.SPActionLink
UnprovisionLink             : Microsoft.SharePoint.Administration.SPActionLink
CanUpgrade                  : True
IsBackwardsCompatible       : True
NeedsUpgradeIncludeChildren : False
NeedsUpgrade                : False
UpgradeContext              : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                        : 
DisplayName                 : 
Id                          : d8e55afd-90db-476e-858b-f931cf79ecb3
Status                      : Disabled
Parent                      : SPServer Name=WIN-2S026UBRQFO
Version                     : 6888
Properties                  : {}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}'
	
foreach ( $serviceInstance in $serviceInstances)
	{
		if( $serviceInstance.Status -ne "Online") 
		{
			$serviceInstance | start-spserviceinstance
			"Started service"
		}
		else {"Service Instance is online"}
	} 

   $serviceInstance.Status

(Get-SPServiceInstance | ? typename -eq '對 Windows Token 服務的宣告').status  #online
(Get-SPServiceInstance | ? TypeName -eq "Secure Store Service" ).status      #online
  

#  1291(16)  啟動 Secure Store Service SA
CreateSecureStoreApplicationService 'SPFarmSQLAlias' 'Secure Store Service'

	$DbServerAddress="SPFarmSQLAlias"
　　 $ServiceApplicationName="Secure Store Service" 
	
### Constants
	$serviceName = "SecureStoreService"
	#$dbName = $serviceName + "_" + [System.Guid]::NewGuid().ToString("N") 
	$dbName = $serviceName + "ServiceApplicationDB" 

	### Retrieve secure store service application
	$serviceapp = Get-SPServiceApplication | where {$_.DisplayName -eq $ServiceApplicationName}
	
	$pool = Get-SPServiceApplicationPool | where {$_ -match "BIapplicationPool"}
	
	### Only create service application if it doesn't exist already
	get-SpServiceApplication;'PS C:\Windows\system32> 	get-SpServiceApplication|ft -a;

DisplayName                                                 TypeName                                                    Id                 
-----------                                                 --------                                                    --                 
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                       56d693a1-e399-46...
PowerPivot Service ApplicationM                             PowerPivot 服務應用程式                                       0a666c77-bd1f-4d...
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48...
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c...
WSS_UsageApplication                                        Usage and Health Data Collection Service 應用程式             af8fc817-284b-4d...
'

    if(!$serviceapp)
	{
		### Add Secure Store Service Aplication
		New-SPSecureStoreServiceApplication -Name $ServiceApplicationName -partitionmode:$false -sharing:$false `
        -databaseserver $DbServerAddress -databasename $dbName -applicationpool $pool -auditingEnabled:$true -auditlogmaxsize 30
	}
	else { throw "The secure store service application already exists"}

	get-SpServiceApplication |ft -a ;'PS C:\Windows\system32> get-SpServiceApplication |ft -a

DisplayName                                                 TypeName                                                    Id                 
-----------                                                 --------                                                    --                 
Secure Store Service                                        Secure Store Service Application                            a48ae093-8e07-46...
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                              56d693a1-e399-46...
PowerPivot Service ApplicationM                             PowerPivot 服務應用程式                                           0a666c77-bd1f-4d...
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48...
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c...
WSS_UsageApplication                                        Usage and Health Data Collection Service 應用程式               af8fc817-284b-4d...
'

IE:  此時已可以連入 http://pp.tempcsd.syscom/SitePages/%E9%A6%96%E9%A0%81.aspx
http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site     #此為 centraladmin  網站設定 : 網站集合功能
http://pp.tempcsd.syscom/_layouts/15/ManageFeatures.aspx?Scope=Site  #此為 pp.tempcsd.syscom  網站設定 : 網站集合功能

     
#(17)  啟動 Secure Store Service SA Proxy
CreateSecureStoreApplicationServiceProxy 'Secure Store Service' 'Secure Store Proxy'

$serviceApplicationName='Secure Store Service'
$proxyName='Secure Store ProxyM'
	
Get-SPServiceApplicationProxy |ft -a ;'S C:\Windows\system32> Get-SPServiceApplicationProxy |ft -a 

DisplayName                     TypeName                               Id                                  
-----------                     --------                               --                                  
PowerPivot Service ApplicationM PowerPivot 服務應用程式 Proxy                4e5f27c1-ca01-4660-9371-636ef6455b4b
ExcelServiceM                   Excel Services 應用程式 Web 服務應用程式 Proxy   894aba2a-005d-403c-96d6-f338017cbaa7
WSS_UsageApplication            Usage and Health Data Collection Proxy fac04375-8ca2-44d8-888b-746bc012fe3d
'

	### Retrieve secure store service application proxy
	$proxy = Get-SPServiceApplicationProxy | where {$_.DisplayName -eq $proxyName}
	
	### Only create application proxy if it doesn't exist already
	if(!$proxy)
	{
		### Retrieve secure store service application
		$serviceapp = Get-SPServiceApplication | where {$_.DisplayName -eq $serviceApplicationName}
	
		### Add Secure Store Service Proxy
		$serviceapp | New-SPSecureStoreServiceApplicationProxy -defaultproxygroup:$true -name $proxyName 
	}
	else { throw "The secure store service application proxy already exists"}
Get-SPServiceApplicationProxy |ft -a
'PS C:\Windows\system32> Get-SPServiceApplicationProxy |ft -a

DisplayName                                                                                            TypeName                                      
-----------                                                                                            --------                                      
PowerPivot Service ApplicationM                                                                        PowerPivot 服務應用程式 Proxy                       
SecureStoreServiceApplicationProxy_2d9b4480-8b0a-4f0f-a1f7-319058e6f665                                Secure Store Service Application Proxy        
Application Discovery and Load Balancer Service Application Proxy_84044cab-bf1d-4c31-8897-35e99c777359 Application Discovery and Load Balancer Ser...
ExcelServiceM                                                                                          Excel Services 應用程式 Web 服務應用程式 Proxy          
WSS_UsageApplication                                                                                   Usage and Health Data Collection Proxy        
'
UI 管理服務應用程式  >   http://localhost:2013/_admin/ServiceApplications.aspx

Get-SPServiceApplicationProxy |? typename -eq 'Secure Store Service Application Proxy' |select *
'PS C:\Windows\system32> Get-SPServiceApplicationProxy |? typename -eq Secure Store Service Application Proxy |select *


TypeName                    : Secure Store Service Application Proxy
ManageLink                  : Microsoft.SharePoint.Administration.SPAdministrationLink
ServiceEndpointUri          : urn:schemas-microsoft-com:sharepoint:service:a48ae0938e07467bace156a8dc64a68b#authority=urn:uuid:84044cabbf1d4c31889735
                              e99c777359&authority=https:%2F%2Fwin-2s026ubrqfo:32844%2FTopology%2Ftopology.svc
PropertiesLink              : 
CanUpgrade                  : True
IsBackwardsCompatible       : True
NeedsUpgradeIncludeChildren : False
NeedsUpgrade                : False
UpgradeContext              : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                        : SecureStoreServiceApplicationProxy_2d9b4480-8b0a-4f0f-a1f7-319058e6f665
DisplayName                 : SecureStoreServiceApplicationProxy_2d9b4480-8b0a-4f0f-a1f7-319058e6f665
Id                          : 51bd3541-a9b7-441e-ad77-ffb56131d468
Status                      : Online
Parent                      : SecureStoreServiceProxy
Version                     : 12350
Properties                  : {Microsoft.Office.Server.Utilities.SPPartitionOptions}
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}
CanSelectForBackup          : True
DiskSizeRequired            : 0
CanSelectForRestore         : True
CanRenameOnRestore          : True'


#(18) 更新　主要金鑰
?? have program :'Update-SPSecureStoreMasterKey : Secure Store Service 無法執行此作業。
位於 線路:1 字元:3
+         Update-SPSecureStoreMasterKey -ServiceApplicationProxy $proxy -Passphrase $far ...
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidData: (Microsoft.Offic...eStoreMasterKey:SPUpdateSPSecureStoreMasterKey) [Update-SPSecureStoreMasterKey]，Addres 
   sAccessDeniedException
    + FullyQualifiedErrorId : Microsoft.Office.SecureStoreService.PowerShellCmdlet.SPUpdateSPSecureStoreMasterKey
'
UpdateSecureStoreMasterKey 'Secure Store Proxy' '********' 


$proxyName ='SecureStoreServiceApplicationProxy_2d9b4480-8b0a-4f0f-a1f7-319058e6f665'
$farmPassPhrase='pass@word1'
$farmPassPhrase='p@ssw0rdx'


		
	### Retrieve secure store service application proxy
	$proxy = Get-SPServiceApplicationProxy | where {$_.DisplayName -eq $proxyName}
$proxy |ft -a

	
		Update-SPSecureStoreMasterKey -ServiceApplicationProxy $proxy -Passphrase $farmPassPhrase
		start-sleep -s 60
		
		Update-SPSecureStoreApplicationServerKey -ServiceApplicationProxy $proxy -Passphrase $farmPassPhrase
		start-sleep -s 60

        WaitForMasterKeyPropagation


#(19)
CreateUnattendedAccountForDataRefresh 'http://pp.tempcsd.syscom' 'PowerPivotUnattendedAccount' 'PowerPivot Unattended Account for Data Refresh' 'TEMPCSD\infra1' $password 

	param($siteUrl, $individualAppID, $individualFriendlyName, $unattendedAccountUser,$unattendedAccountPwdSecureString)
		
	### Setup Individual ID
	### get context
	"Obtaining service context for Url: ($siteUrl)"
	$context = Get-SPSite -Identity $siteUrl | Get-SPServiceContext
	if($context)
	{
		"Obtaining PowerPivotServiceApplication associated with current context"
		$pp = get-powerpivotserviceapplication -ServiceContext $context
	}

	if($pp)
	{
		$targetApplicationAdministrator = $pp.ApplicationPool.ProcessAccountName
		"Retrieving PowerPivotServiceApplication application pool process account: ($targetApplicationAdministrator)"
		$targetApplicationAdministratorClaims = New-SPClaimsPrincipal -Identity $targetApplicationAdministrator -IdentityType WindowsSamAccountName
	}
	
	$unattendedAccountUserSecureString = ConvertTo-SecureString $unattendedAccountUser -AsPlainText -Force
	
	if($context -and $targetApplicationAdministratorClaims)
	{
		"Create secure store application"
		WaitForMasterKeyPropagation
		CreateSecureStoreApplication $individualAppID $individualFriendlyName $context
	
		### Get secure store application
		$sssapp = Get-SPSecureStoreApplication -All -ServiceContext $context | where {$_.TargetApplication.ApplicationId -eq $individualAppID}
		
		### Update credentials
		"Update secure store credential mapping"
		WaitForMasterKeyPropagation
		Update-SPSecureStoreCredentialMapping -Principal $targetApplicationAdministratorClaims -identity $sssapp -Values $unattendedAccountUserSecureString,$unattendedAccountPwdSecureString
	}
	else
	{
		throw "Cannot create unattended account for data refresh because there is no enough information to locate current proxy group."
	}


#(20)
SetECSUsageTracker 'ExcelServiceM'




"-------------------------      -----------------------"


#------------------------------------
#  step 10
#------------------------------------


I am  Whoami  :tempcsd\spfarm  
接下來由  spfarm 接手 


#------------------------------------
#  step 10
#------------------------------------


#------------------------------------
#  SPSolution  Prev  
#------------------------------------

Get-SPSolution
<#Null#>
#------------------------------------
#   528  SPFeature prev  get , install, enable , uninstall
#------------------------------------
(Get-SPFeature).count  #60  -> 657
PS SQLSERVER:\> Get-SPFeature | sort  displayname  

DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
AccessRequests                 a0f12ee4-9b60-4ba4-81f6-75724f4ca973     15                   Web                           
AdminLinks                     fead7313-ae6d-45dd-8260-13b563cb4c71     15                   Web                           
AnnouncementsList              00bfea71-d1ce-42de-9c63-a44004ce0104     15                   Web                           
AppLockdown                    23330bdb-b83e-4e09-8770-8155aa5e87fd     15                   Web                           
AppRegistration                fdc6383e-3f1d-4599-8b7c-c515e99cbf18     15                   Site                          
BasicWebParts                  00bfea71-1c5e-4a24-b310-ba51c3eb7a57     15                   Site                          
CallTrackList                  239650e3-ee0b-44a0-a22a-48292402b8d8     15                   Web                           
CirculationList                a568770a-50ba-4052-ab48-37d8029b3f47     15                   Web                           
ContactsList                   00bfea71-7e6d-4186-9ba8-c047ac750105     15                   Web                           
ContentLightup                 0f121a23-c6bc-400f-87e4-e6bbddf6916d     15                   Farm                          
ContentTypeSettings            fead7313-4b9e-4632-80a2-ff00a2d83297     15                   Farm                          
CTypes                         695b6570-a48b-4a8e-8ea5-26ea7fc1d162     15                   Site                          
CustomList                     00bfea71-de22-43b2-a848-c05709900100     15                   Web                           
DataSourceLibrary              00bfea71-f381-423d-b9d1-da7a54c50110     15                   Web                           
DiscussionsList                00bfea71-6a49-43fa-b535-d15c05500108     15                   Web                           
DocumentLibrary                00bfea71-e717-4e80-aa17-d0c71b360101     15                   Web                           
DownloadFromOfficeDotCom       a140a1ac-e757-465d-94d4-2ca25ab2c662     15                   Farm                          
EmailTemplates                 397942ec-14bf-490e-a983-95b87d0d29d1     15                   WebApplication                
EventsList                     00bfea71-ec85-4903-972d-ebe475780106     15                   Web                           
ExternalList                   00bfea71-9549-43f8-b978-e47e54a10600     15                   Web                           
FacilityList                   58160a6b-4396-4d6e-867c-65381fb5fbc9     15                   Web                           
FCGroupsList                   08386d3d-7cc0-486b-a730-3b4cfe1b5509     15                   Web                           
Fields                         ca7bd552-10b1-4563-85b9-5ed1d39c962a     15                   Site                          
GanttTasksList                 00bfea71-513d-4ca0-96c2-6a47775c0119     15                   Web                           
GBWProvision                   6e8a2add-ed09-4592-978e-8fa71e6f117c     15                   Web                           
GBWWebParts                    3d25bd73-7cd4-4425-b8fb-8899977f73de     15                   Web                           
GettingStarted                 4aec7207-0d02-4f4f-aa07-b370199cd0c7     15                   Web                           
GridList                       00bfea71-3a1d-41d3-a0ee-651d11570120     15                   Web                           
GroupWork                      9c03e124-eef7-4dc6-b5eb-86ccd207cb87     15                   Web                           
HelpLibrary                    071de60d-4b02-4076-b001-b456e93146fe     15                   Site                          
HierarchyTasksList             f9ce21f8-f437-4f7e-8bc6-946378c850f0     15                   Web                           
HolidaysList                   9ad4c2d4-443b-4a94-8534-49a23f20ba3c     15                   Web                           
IMEDicList                     1c6a572c-1b58-49ab-b5db-75caf50692e6     15                   Web                           
IssuesList                     00bfea71-5932-4f9c-ad71-1557e5751100     15                   Web                           
IssueTrackingWorkflow          fde5d850-671e-4143-950a-87b473922dc7     15                   Site                          
LinksList                      00bfea71-2062-426c-90bf-714c59600103     15                   Web                           
MBrowserRedirect               d95c97f3-e528-4da2-ae9f-32b3535fbb59     15                   Web                           
MBrowserRedirectStapling       2dd8788b-0e6b-4893-b4c0-73523ac261b1     15                   Farm                          
MobilityRedirect               f41cc668-37e5-4743-b4a8-74d1db3fd8a4     15                   Web                           
MpsWebParts                    39dd29fb-b6f5-4697-b526-4d38de4893e5     15                   Web                           
NoCodeWorkflowLibrary          00bfea71-f600-43f6-a895-40c0de7b0117     15                   Web                           
OpenInClient                   8a4b8de2-6fd8-41e9-923c-c7c3c00f8295     15                   Site                          
PictureLibrary                 00bfea71-52d4-45b3-b544-b1c71b620109     15                   Web                           
PromotedLinksList              192efa95-e50c-475e-87ab-361cede5dd7f     15                   Web                           
ScheduleList                   636287a7-7f62-4a6e-9fcc-081f4672cbf8     15                   Web                           
SiteHelp                       57ff23fc-ec05-4dd8-b7ed-d93faa7c795d     15                   Site                          
SiteNotebook                   f151bb39-7c3b-414f-bb36-6bf18872052f     15                   Web                           
SiteSettings                   fead7313-4b9e-4632-80a2-98a2a2d83297     15                   Farm                          
SurveysList                    00bfea71-eb8a-40b1-80c7-506be7590102     15                   Web                           
TasksList                      00bfea71-a83e-497e-9ba0-7a5c597d0107     15                   Web                           
TeamCollab                     00bfea71-4ea5-48d4-a4ad-7ea5c011abe5     15                   Web                           
TimeCardList                   d5191a77-fa2d-4801-9baf-9f4205c9e9d2     15                   Web                           
WebPageLibrary                 00bfea71-c796-4402-9f2f-0eb9a6e71b18     15                   Web                           
WhatsNewList                   d7670c9c-1c29-4f44-8691-584001968a74     15                   Web                           
WhereaboutsList                9c2ef9dc-f733-432e-be1c-2e79957ea27b     15                   Web                           
WikiPageHomePage               00bfea71-d8fe-4fec-8dad-01c19a6e4053     15                   Web                           
WikiWelcome                    8c6a6980-c3d9-440e-944c-77f93bc65a7e     15                   Web                           
WorkflowHistoryList            00bfea71-4ea5-48d4-a4ad-305cf7030140     15                   Web                           
workflowProcessList            00bfea71-2d77-4a75-9fca-76516689e21a     15                   Web                           
XmlFormLibrary                 00bfea71-1e1d-4562-b56a-f05371bb0115     15                   Web                           
