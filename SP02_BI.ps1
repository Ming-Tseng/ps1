<#  SP02_BI  C:\Users\administrator.CSD\SkyDrive\download\PS1\SP02_BI.ps1 \\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\SP02_BI.ps1 \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_BI auther : ming_tseng    a0921887912@gmail.com createDate : Sep.04.2014  lastdate :Aug.29.2015 history :  object :   $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\SP02_BI.ps1

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
#>#  10   checklists#  15   create BI Group ,user, OU 
#  101  create BI Group for SQL #  138  SQL install feature list#  153  Configure the Windows Firewall to Allow SQL Server Access
#  340  Install and Download SharePoint 2013 prerequisites offline  Sp01_installconfg.ps1 Line:561#  465  Technical diagrams for SharePoint 2013   
#------------------------------------
#  10   checklists
#------------------------------------1 server list info2 BI Group3 BI OU4 BI user5 OU map to  User, Group map to User6 BI SQL feature lists :line ;1387 Firewall SQL connecting line:1538 SPS servcie / Features Lists (SP) <- powershell   line 4659 site URLlist #------------------------------------
#  15   create BI Group ,user, OU on OS
#------------------------------------$GroupS='BIInfraGroup','BIDesigner','BIPowerUserGroup','BIEndUserGroup','BILeaderGroup','BIAuditGroup'$OUS   ='Accounting','AP','CEO','DataAnalysis','DataModel','ETL','Report','IT','PM','Sales'$UserS ='acc2','ap1','ceo1','dm1','etl1','report1','infra1','pm1','pm2','sales2','sales1'#fully qualified domain name (FQDN) is named DEMO2013a.Contoso.com
# OUNEW-ADOrganizationalUnit “Accounting"
NEW-ADOrganizationalUnit “AP"
NEW-ADOrganizationalUnit “CEO"
NEW-ADOrganizationalUnit “DataAnalysis"
NEW-ADOrganizationalUnit “IT"
NEW-ADOrganizationalUnit “PM"
NEW-ADOrganizationalUnit “Sales"


NEW-ADOrganizationalUnit “ETL” –path “OU=DataAnalysis,DC=tempcsd,DC=syscom”
NEW-ADOrganizationalUnit “DataModel” –path “OU=DataAnalysis,DC=tempcsd,DC=syscom”
NEW-ADOrganizationalUnit “Report” –path “OU=DataAnalysis,DC=tempcsd,DC=syscom”# UsersNew-ADUser acc2 -SamAccountName "acc2"   -GivenName "acc2"  -Surname "Accounting"  -DisplayName "acc2"  -Path 'OU=Accounting,DC=tempcsd,DC=syscom'New-ADUser ap1 -SamAccountName "ap1"   -GivenName "ap1"  -Surname "AP"  -DisplayName "ap1"  -Path 'OU=AP,DC=tempcsd,DC=syscom'
New-ADUser ceo1 -SamAccountName "ceo1"  -GivenName "ceo1" -Surname "CEO" -DisplayName "ceo1" -Path 'OU=CEO,DC=tempcsd,DC=syscom'
New-ADUser dm1 -SamAccountName "dm1"  -GivenName "dm1" -Surname "DataModel" -DisplayName "dm1" -Path 'OU=DataModel,OU=DataAnalysis,DC=tempcsd,DC=syscom'
New-ADUser etl1 -SamAccountName "etl1"  -GivenName "etl1" -Surname "DataModel" -DisplayName "etl1" -Path 'OU=ETL,OU=DataAnalysis,DC=tempcsd,DC=syscom'
New-ADUser report1 -SamAccountName "report1"  -GivenName "report1" -Surname "Report" -DisplayName "report1" -Path 'OU=Report,OU=DataAnalysis,DC=tempcsd,DC=syscom'
New-ADUser infra1 -SamAccountName "infra1"  -GivenName "infra1" -Surname "IT" -DisplayName "infra1" -Path 'OU=IT,DC=tempcsd,DC=syscom'

# infraSSDE 為SQL Startup account have enterprise admin Role
New-ADUser infraSSDE -SamAccountName "infraSSDE"  -GivenName "infraSSDE" -Surname "IT" -DisplayName "infraSSDE" -Path 'OU=IT,DC=tempcsd,DC=syscom'
New-ADUser infraSSDW -SamAccountName "infraSSDW"  -GivenName "infraSSDW" -Surname "IT" -DisplayName "infraSSDW" -Path 'OU=IT,DC=tempcsd,DC=syscom'

# infraSSASMD ,infraSSASTR,infraSSRSNT ,infraSSRSSP為SQL Startup account have enterprise admin Role
New-ADUser infraSSASMD -SamAccountName "infraSSASMD"  -GivenName "infraSSASMD" -Surname "IT" -DisplayName "infraSSASMD" -Path 'OU=IT,DC=tempcsd,DC=syscom'
New-ADUser infraSSASTR -SamAccountName "infraSSASTR"  -GivenName "infraSSASTR" -Surname "IT" -DisplayName "infraSSASTR" -Path 'OU=IT,DC=tempcsd,DC=syscom'
New-ADUser infraSSRSNT -SamAccountName "infraSSRSNT"  -GivenName "infraSSRSNT" -Surname "IT" -DisplayName "infraSSRSNT" -Path 'OU=IT,DC=tempcsd,DC=syscom'
New-ADUser infraSSRSSP -SamAccountName "infraSSRSSP"  -GivenName "infraSSRSSP" -Surname "IT" -DisplayName "infraSSRSSP" -Path 'OU=IT,DC=tempcsd,DC=syscom'
New-ADUser infraSSASPT -SamAccountName "infraSSASPT"  -GivenName "infraSSASPT" -Surname "IT" -DisplayName "infraSSASPT" -Path 'OU=IT,DC=tempcsd,DC=syscom'

New-ADUser for Sharepoint
<#
givenName	      sn	gname	        department	            uname	            ctPassword
-----------------------------------------------------------------------------------------------
<SPCacheSuperUser>		Service Account	Application Development	SPCacheSuperUser	pass@word1

<SPCacheUser>		        Service Account	Application Development	SPCacheUser	        pass@word1SS

<SPInst  = infra1 > (Member of the Administrators group on each server , SQL: dbcreate & securityadmin)
    --The Setup user account is used to run the 

*SPFarm		            Service Account	Application Development	SPFarm	            pass@word1 SQLadministrator
    --Configure and manage the server farm ,Act as the application pool identity for the SharePoint Central Administration Web site

*SPService		        Service Account	Application Development	SPService	        pass@word1 SQLadministrator
    --A generic services account for grouped Service Applications &　　applicationPool

<SPServicePool>
    --Application Pool Identity for SharePoint Web Services Default application
*SPAdmin		        Service Account	Application Development	SPAdmin	            pass@word1 SQLadministrator

SPSearch		        Service Account	Application Development	SPSearch	        pass@word1

SPSearchContent		    Service Account	Application Development	SPSearchContent	    pass@word1

SPWebApp
    --Application Pool Identity for the main web application

SPContent		        Service Account	Application Development	SPContent	        pass@word1


#>

p@ssw0rd
New-ADUser pm1 -SamAccountName "pm1"  -GivenName "pm1" -Surname "PM" -DisplayName "pm1" -Path 'OU=PM,DC=tempcsd,DC=syscom'
New-ADUser pm2 -SamAccountName "pm2"  -GivenName "pm2" -Surname "PM" -DisplayName "pm2" -Path 'OU=PM,DC=tempcsd,DC=syscom'
New-ADUser sales1 -SamAccountName "sales1"  -GivenName "sales1" -Surname "Sales" -DisplayName "sales1" -Path 'OU=Sales,DC=tempcsd,DC=syscom'
New-ADUser sales2 -SamAccountName "sales2"  -GivenName "sales2" -Surname "Sales" -DisplayName "sales2" -Path 'OU=Sales,DC=tempcsd,DC=syscom'
#GroupNew-ADGroup  -Name "BI Infra Group" -SamAccountName BIinfraGroup  -GroupCategory Security  -GroupScope Global `
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
-DisplayName "BI Aduit Group"   -Description "Aduit Group Description" # set User to GroupAdd-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI EndUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*acc2"').DistinguishedName

Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*ap1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Aduit Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*ceo1"').DistinguishedName

Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Designer Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*dm1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Designer Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*etl1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Designer Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*report1"').DistinguishedName

Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Infra Group'}).DistinguishedName –Member (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedName

Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Leader Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*pm1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*pm2"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*sales1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI EndUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*sales2"').DistinguishedName##  手動設定 Group 是屬於那一個內建群組 ex: BI Infra Group = Enterpsire Administrator ##  ADUser 重設密碼Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)
## enable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedName## 未Search-ADAccount -AccountDisabled | FT Name,ObjectClass -A#------------------------------------
#  101   create BI Group for SQL 
#------------------------------------1.SQL edition *32 *642.SQL source (ISO . DVD) :Path3.SQL Feature List : Database Engine Services; SQL Server Replication: Analaysis Servcies;                   ;Reporting Service(Native); Reporting servcies- Sharepoint : Reporint Service add-on for sharepoint                   ;Data Quality Client; Integration servies ; 4.執行個體根目錄:  'C:\Program Files\Microsoft SQL Server'  共用功能目錄,   共用功能目錄(X86), 5. 執行個體名稱: SQLSERVER   (SSDE)   SQL Server 目錄: C:\Program Files\Microsoft SQL Server\MSSQL12.   Analysis Services目錄: C:\Program Files\Microsoft SQL Server\MSAS12.   Reporting Services目錄:  C:\Program Files\Microsoft SQL Server\MSRS12.6.SQL Server Manager account (指定SQL SERVER 管理員帳號)   ex: infra1  & infraSQL7.定序COLLATION:  Chinese_Taiwan_STroke_CI_AS   or SQL_Latin1_General_CP1_CI_AS8.Max Authentication : sa password 9.資料根目錄:     系統資料庫目錄: C:\Program Files\Microsoft SQL Server\MSAS12.xxx\MSSQL\Data   使用者資料庫目錄   使用者資料庫記錄檔目錄   暫存資料庫目錄   暫存存資料庫記錄檔目錄   備份目錄10.Analysis Services : Multi-dimension (SSASMD) 資料目錄 , 記錄檔目錄 , 暫存目錄 , 備份目錄  C:\Program Files\Microsoft SQL Server\MSAS12.SQL2014ENT\OLAP\Data                     : Tabular (SSASTR) 資料目錄 , 記錄檔目錄 , 暫存目錄 , 備份目錄11.Analysis Services 管理員:12.Reporting Services : Native mode (SSRS =SSRSNT)                      : sharepoint services integration  (SSRSSP)13.組態檔路徑  14.SQL server powerpivot for Sharepoint (on SQL installation )           instance name(執行個體) :  SSASPT           執行個體根目錄  : C:\Program Files\Microsoft SQL Server\           資料目錄 , 記錄檔目錄 , 暫存目錄 , 備份目錄   To configure the farm, you must have a SQL Server login on the database server. The login must be assigned to the following roles: dbcreator, securityadmin and publi $tsql_alterserverRole=@"ALTER SERVER ROLE [dbcreator] ADD MEMBER [TEMPCSD\BIinfraGroup]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [TEMPCSD\BIinfraGroup]
GO
ALTER SERVER ROLE [sysadmin] DROP MEMBER [TEMPCSD\BIinfraGroup]
GO
"@## 6   C:\Users\administrator.CSD\OneDrive\download\PS1\SQLINI\SQL2014SSDE                               SSDE_ConfigurationFile.iniSSASTR    Tabular                SSASTR_ConfigurationFileSSASMD    Multi-Dimension        SSASMD_ConfigurationFile.iniSSASPT    PowerPivot             SSASPT_ConfigurationFile.iniSSRSSP    RSIntegratedSharpoint  SSIS    cmd /c ("e:\Setup") '/ConfigurationFile=C:\Demos\SQLServer2012\Scripts\SSASTR_ConfigurationFile.ini'#------------------------------------
#  138  SQL install feature list
#------------------------------------https://msdn.microsoft.com/en-us/library/ff487867.aspx1. MSSQL.ConfigurationFile - installs SQL Server Database Engine, SQL Server Agent
,  REPLICATION, SQL Server Full Text, Data Quality Server, 
, Analysis Services Tabular Mode, 
, Data Quality Client
, SQL Server Data Tools (SSDT)
, connectivity components, Integration Services
, backward compatibility components
, software development kit
, SQL Server Books Online
, SQL Server Management Tools Basic& Advanced
, SDK for Microsoft SQL Server Native Client
, and the Master Data Services
2. MultiDimensional.ConfigurationFile – installs SQL Server Database Engine, SQL Server Agent
,  REPLICATION, SQL Server Full Tex, Data Quality Server, Analysis Services Multidimensional mode
, and Native Reporting Services 

3. PowerPivot.ConfigurationFile – installs Analysis Services PowerPivot Mode calculation engine
, preconfigured for in-memory data storage and processing.
 PowerPivot solution packages, SQL Server Books Online, Database Engine, Configuration Tools, SQL Server Management Studio, 
4. RSIntegrated.ConfigurationFile – installs Reporting Services for  SharePoint Mode and the Reporting Services add-in for SharePoint Products
#------------------------------------
#  153   Configure the Windows Firewall to Allow SQL Server Access
#------------------------------------https://msdn.microsoft.com/en-us/library/cc646023.aspx#BKMK_basicusing powershell_ise as administratorBasic Firewall Information
Default Firewall Settings
Programs to Configure the Firewall
Ports Used by the Database Engine
Ports Used By Analysis Services
Ports Used By Reporting Services
Ports Used By Integration Services
Additional Ports and Services
Interaction with Other Firewall Rules
Overview of Firewall Profiles
Additional Firewall Settings Using the Windows Firewall Item in Control Panel
Using the Windows Firewall with Advanced Security Snap-in
Troubleshooting Firewall SettingsTCP port 1433 SQL Server default instance running over TCPUDP port 1434 SQL Server named instances in the default configuration  UDP port 1434 SQL Server Browser serviceTCP port 1434 Dedicated Admin ConnectionTCP port 80   SQL Server instance running over an HTTP endpointTCP port 443  SQL Server instance runningover an HTTP endpoint SSL_PORT traffic.TCP port 4022 Service Broker  (SELECT name, protocol_desc, port, state_desc FROM sys.tcp_endpoints WHERE type_desc = 'SERVICE_BROKER')TCP port 7022 Database Mirroring (SELECT name, protocol_desc, port, state_desc FROM sys.tcp_endpoints WHERE type_desc = 'DATABASE_MIRRORING')TCP port 135  Transact-SQL debuggerReplication   TCP port 1433 Database Engine ports Replication   FTP (TCP port 21)Replication   HTTP (TCP port 80) Replication   File Sharing (UDP port 137 and 138, and TCP port 139)Replication   File Sharing using NetBIOS  (TCP port 445)TCP port 2383 Analysis ServicesTCP port 2382 SQL Server Browser serviceTCP port 80   Analysis Services configured for use through IIS/HTTP +The PivotTable® ServiceTCP port 443  Analysis Services configured for use through IIS/HTTPS The PivotTable® ServiceTCP port 80  Reporting Services Web ServicesTCP port 80  Reporting Services configured for use through HTTPSTCP port 135  SSIS Microsoft remote procedure calls (MS RPC)  Used by the Integration Services runtime.TCP port 135  Windows Management InstrumentationTCP port 135  Microsoft Distributed Transaction Coordinator (MS DTC)UDP port 1434 The browse button in Management Studio uses UDP to connect to the SQL Server Browser Service.   UDP port 500 and UDP port 4500  IPsec trafficSQL Cluster             Windows 防火牆以外的防火牆來保護您的網路，請注意下列伺服器叢集所需連接埠的清單：
135 (RPC 端點對應程式/DCOM)。
135 (透過 UDP 的 RPC 端點對應程式)。
3343 (由叢集網路驅動程式使用)。
445 (SMB)。
139 (NetBIOS 工作階段服務)。
如果是執行許多服務的叢集節點，則可能需要開啟連接埠 5000-5099 (或更多) 以供遠端 RPC 連線至「叢集系統管理員」。當您關閉這些連接埠時，如果透過「叢集系統管理員」連線至叢集，可能會發生事件日誌錯誤 1721 (除非您只是在「叢集系統管理員」中鍵入句點)。
叢集服務至少需要 100 個連接埠才能透過 Remote Procedure Call (RPC) 進行通訊，因此可能會發生這個問題。當其他服務正在使用部分必要的連接埠時，叢集服務可用的連接埠數量可能會變得太少。這類服務包括 Windows DNS 服務、Windows 網際網路名稱服務 (WINS)、Microsoft SQL Server 服務及其他服務。
如果防火牆分隔節點，則必須針對節點間的 RPC 連線開啟連接埠 8011-8031。否則，叢集記錄中的錯誤將會表示無法使用「贊助節點」。沒有足夠的連接埠，供嘗試加入叢集的節點與可「贊助」該節點的節點之間進行 RPC 通訊，因此會發生這些錯誤。
netsh advfirewall firewall add rule name = SQLPort1433 dir = in protocol = tcp action = allow localport = 1433 remoteip = localsubnet profile = DOMAIN#------------------------------------
#  340   Download and Install Prerequisites on Windows Server 2012 with PowerShell
#------------------------------------Step 1: Install-SP2013RolesFeatures.ps1Step 2: Download-SP2013PreReqFiles.ps1Step 3: Install-SP2013PreReqFiles.ps1There are two different scenarios for how you can use this script

Procedure - Scenario 1:

You have already executed Install-SP2013RolesFeatures.ps1 and rebooted your server
You have already executed Download-SP2013PreReqFiles.ps1
Copy the SharePoint 2013 installation media files into a local directory on you Windows Server 2012 server. For example, c:\sp2013.
Copy the Prerequisite files into the c:\sp2013\prerequisiteinstallerfiles directory.
Run PowerShell as Administrator (you can do this from the Start Screen - right click PowerShell and select Run as Administrator
Run this script: c:\powershellscripts\Install-SP2013PreReqFiles.ps1. You will be required to define a path where to your SharePoint 2013 installation media. (e.g. c:\sp2013). Watch the Prerequisite installer tool install all of the prerequisites.
When the installer is complete, reboot your server prior to installing SharePoint 2013. You should now be able to run the SharePoint 2013 installer, bypassing the Pre-requisite step.

Procedure - Scenario 2:
You have NOT executed Install-SP2013RolesFeatures.ps1 and rebooted your server
You have already executed Download-SP2013PreReqFiles.ps1
Copy the SharePoint 2013 installation media files into a local directory on you Windows Server 2012 server. For example, c:\sp2013.
Copy the Prerequisite files into the c:\sp2013\prerequisiteinstallerfiles directory.
Run PowerShell as Administrator (you can do this from the Start Screen - right click PowerShell and select Run as Administrator"
Run this script: c:\powershellscripts\Install-SP2013PreReqFiles.ps1. You will be required to define a path where to your SharePoint 2013 installation media. (e.g. c:\sp2013). On this run, defining the path isnot technically required as it will add the Windows Server 2012 Roles/Features for SharePoint 2013. When the Roles/Features are installed, click Finish and your server will reboot.
After the reboot, when you login, if the PrerequisiteInstaller launches, close the installer.Prerequisite installer tool install all of the prerequisites.
Run this script: c:\powershellscripts\Install-SP2013PreReqFiles.ps1. You will be required to define a path where to your SharePoint 2013 installation media. (e.g. c:\sp2013). Watch the Prerequisite installer tool install all of the prerequisites.
When the installer is complete, reboot your server prior to installing SharePoint 2013. You should now be able to run the SharePoint 2013 installer, bypassing the Pre-requisite step."#------------------------------------
#    
#------------------------------------TABLE A-1 A comparison of hardware needs for Tabular and Multidimensional Analysis Services instances
Feature Tabular Multidimensional RAM Some (16/32 GB) A lot (64/128 GB) RAM Speed Important Crucial Number of cores 4/8/16 4/8/16 Core speed Less important Crucial
Disk speed Less important NA
SSD disk usage Recommended NA
Network speed Important Important
The following instruction for determining memory is excerpted from the book Microsoft SQL Server 2012 Analysis Services: The BISM Tabular Model (Microsoft Press, 2012).
#------------------------------------
#   
#------------------------------------http://sharepointdemobuilds.codeplex.com/Active Directory Content Pack Demo 2.0
SQL 2012 SP1 Content Pack Demo 2.0
SharePoint 2013 Configuration Demo 2.0
PeoplePack - UserProfile Provisioning Demo 2.0
Self-Service BI Demo 2.0 Content Pack
Visio Services Demo 2.0 Content Pack#------------------------------------
#    370  SPserver  FarmServers list
#------------------------------------#--------------------------------------------------------------------------
$inputFile="H:\Microsoft\BI2015_ContentPackDemo\SharePoint Configuration Demo 15.2.6\Demo\SP\AutoSPInstaller\AutoSPInstallerInput.xml"
[xml]$xmlinput = (Get-Content $inputFile)  $xmlinput.SelectNodes("//*[@Provision]
 |//*[@Install]
 |//*[CrawlComponent]
 |//*[QueryComponent]
 |//*[SearchQueryAndSiteSettingsServers]
 |//*[AdminComponent]
 |//*[IndexComponent]
 |//*[ContentProcessingComponent]
 |//*[AnalyticsProcessingComponent]
 |//*[@Start]")

 <#
Access 2010 Service                                                      AccessService                                                           
Access Services                                                          AccessServices                                                          
App Management Service                                                   AppManagementService                                                    
Business Data Connectivity Service                                       BusinessDataConnectivity                                                
CentralAdmin                                                             CentralAdmin                                                            
ClaimsToWindowsTokenService                                              ClaimsToWindowsTokenService                                             
EnterpriseSearchService                                                  EnterpriseSearchService                                                 
Excel Services Application                                               ExcelServices                                                           
Excel Web App                                                            ExcelService                                                            
ForeFront                                                                ForeFront                                                               
iFilter                                                                  iFilter                                                                 
Machine Translation Service                                              MachineTranslationService                                               
Managed Metadata Service                                                 ManagedMetadataServiceApp                                               
OfficeWebApps                                                            OfficeWebApps                                                           
PerformancePoint Service                                                 PerformancePointService                                                 
PowerPoint Conversion Service Application                                PowerPointConversionService                                             
PowerPoint Service Application                                           PowerPointService                                                       
SandboxedCodeService                                                     SandboxedCodeService                                                    
Search Service Application                                               EnterpriseSearchServiceApplication                                      
Secure Store Service                                                     SecureStoreService                                                      
SMTP                                                                     SMTP                                                                    
State Service                                                            StateService                                                            
Subscription Settings Service                                            SubscriptionSettingsService                                             
Usage and Health Data Collection                                         SPUsageService                                                          
User Profile Service Application                                         UserProfileServiceApp                                                   
Visio Graphics Service                                                   VisioService                                                            
Web Analytics Service Application                                        WebAnalyticsService                                                     
Word Automation Services                                                 WordAutomationService                                                   
Word Viewing Service                                                     WordViewingService                                                      
Work Management Service Application                                      WorkManagementService                                                   
#>
  $xmlinput.SelectNodes("//*[@Provision]") |select Name,localname|sort name 
  $xmlinput.SelectNodes("//Name") |select Name,Provision ,database|sort name 

  $xmlinput.SelectNodes("//*[Name = 'Search Service Application' ]")# |select Name,Provision ,database|sort name 
  $xmlinput.SelectNodes("//*[AdminComponent = 'AdminComponent' ]")# |select Name,Provision ,database|sort name 

  
  $xmlinput.SelectNodes("//*[CrawlComponent]")# |select Name,Provision ,database|sort name 

  $xmlinput.SelectNodes("//*['Access 2010 Service']") |select parentnode,localname,Name|sort name 
 #------------------------------------
#   465  Technical diagrams for SharePoint 2013   Sep.03.2015
#------------------------------------https://technet.microsoft.com/en-us/library/bcbae7bd-656b-4003-969c-8411b81fcd77#architectureref  H:\Microsoft\BI2016Apps  (App Overview for IT Pro)Architecture (Microsoft Sharepoint 2013 Platform Options;SharePoint 2013 Internet-facing sites in Azure )AuthenticationBackup and recoveryDatabasesDesign a Sharepoint SiteDesign SamplessearchUpgrade#------------------------------------
#    
#------------------------------------#------------------------------------
#    
#------------------------------------#------------------------------------
#    Managed Accounts
#------------------------------------{ ##  get  Get-SPManagedAccount##  newUser name: domain\accountname csd\spExcel pwd: p@ssw0rd$ServiceApplicationUser = "CSD\SPexcel" 
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
      

  Get-SPManagedAccount  ## set}#------------------------------------
#   Excel Services cmdlets
#------------------------------------
{
#### 1   Configure the application pool account

Get-SPServiceApplicationPool

$ServiceApplicationUser = "CSD\SPexcel" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "p@ssw0rd" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword  
$ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials  

## 2 將內容資料庫存取授與受管理帳戶

'新增其他的內容資料庫，就必須重新執行這些 Cmdlet 以確保 Excel Services 可存取新的資料庫'
$w = Get-SPWebApplication -identity http://<WebApplication>
$w.GrantAccessToProcessIdentity("CSD\SPexcel")

####  3 Start the Excel Calculation Services service

 Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' |Start-SPServiceInstance
 Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' 
 
 Stop-SPServiceInstance 


#### 4  Create an Excel Services service application

#### 4.1 Service Application Pool



$SPServiceApplicationPoolName='ExcelWebApplicationPool' 
New-SPServiceApplicationPool -Name $SPServiceApplicationPoolName -Account $ServiceApplicationUser 

Get-SPServiceApplicationPool  $SPServiceApplicationPoolName |select *



#### 4.2 Service Application 

Get-SPServiceApplication |ft -AutoSize
'

DisplayName                                                 TypeName                                                    Id                 
-----------                                                 --------                                                    --                 
Security Token Service Application                          Security Token Service Application                          612fcc0b-7090-4d...
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application d87e019e-33ef-4f...
'
New-SPExcelServiceApplication -Name "ExcelServiceM" -ApplicationPool $SPServiceApplicationPoolName

Get-SPServiceApplication |ft -AutoSize
Get-SPExcelServiceApplication  

'
Get-SPServiceApplication |ft -AutoSize

DisplayName                                                 TypeName                                                    Id                       
-----------                                                 --------                                                    --                       
ExcelService                                                Excel Services Application Web Service Application          c2bc17b7-c416-4364-865...
Security Token Service Application                          Security Token Service Application                          612fcc0b-7090-4de8-bfc...
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application d87e019e-33ef-4f83-8eb...

UI > Application Management   >  Manage service applications 
'
$excelserviceDisplayname=Get-SPExcelServiceApplication |select DisplayName
$excelserviceDisplayname.DisplayName

Remove-SPServiceApplication(Get-SPExcelServiceApplication) -Confirm:$false

Remove-SPServiceApplicationProxy babab30e-8e3a-428b-8ff4-4d5c8f455e6d



####  5

Global setting
Trusted file locations
Trusted data Providers
Trusted Data connection libraries
User Defined function assemblies
Data Model settings

####  

Get-SPExcelBlockedFileType       Get  New  Remove
Get-SPExcelDataConnectionLibrary Get  New  Remove  set
Get-SPExcelDataProvider          Get  New  Remove  set
Get-SPExcelFileLocation          Get  New  Remove  set
Get-SPExcelServiceApplication    Get  New          set
Get-SPExcelUserDefinedFunction   Get  New  Remove  set

}
#------------------------------------
#   Secure Store Service
#------------------------------------
{# 0 Naming
#-Application Pool Service Account:  Domain\SvcAccount (this should already be created) 
$ServiceApplicationUser = "CSD\SPexcel"  #ref csd\spexecl must in  Managed Accounts
#-Application Pool   : SvcApp_SPServiceApplicationPool_02 (this should already be created)
$SPServiceApplicationPoolName='SSSApplicationPool' 
Service Application: SvcApp_SPSecureStoreServiceApplication_01
Database           : SvcApp_SPSecureStoreServiceApplication_01_DB_01

##1 Create Application Pool  


$SPServiceApplicationPoolName='SSSApplicationPool' 
New-SPServiceApplicationPool -Name $SPServiceApplicationPoolName -Account $ServiceApplicationUser 
Get-SPServiceApplicationPool | Select Name


##2.start Secure Store Service
Get-SPServiceInstance -Server  $env:COMPUTERNAME   | ? typename -like "*secure*"
'
TypeName                         Status   Id                                  
--------                         ------   --                                  
Secure Store Service             Disabled 7b6015d0-5b99-4093-a059-54ffc93f6ed0
'
Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto


start-SPServiceInstance  7b6015d0-5b99-4093-a059-54ffc93f6ed0

Stop-SPServiceInstance -Identity 7b6015d0-5b99-4093-a059-54ffc93f6ed0  -Confirm:$false 
## 3  Set the Service Application Pool in a variable.

 Get-SPServiceApplicationPool |select name,ID,TypeName,Status
$SvcAppPool = Get-SPServiceApplicationPool $SPServiceApplicationPoolName

#-Create the Secure Store Service Application.  Specify the Application Pool, the AuditingEnabled setting, the Service Application Name, the Database Name, and the Database Server Name.
$SvcApp = New-SPSecureStoreServiceApplication `
-ApplicationPool $SvcAppPool `
–AuditingEnabled:$false `
-Name "SvcApp_SPSecureStoreServiceApplication_01" `
-DatabaseName "SvcApp_SPSecureStoreServiceApplication_01_DB_01" `
-DatabaseServer "2013BI"

#-6)  Verify the Service Application.
Get-SPServiceApplication | Select Name |fl

$SSSSPA=Get-SPServiceApplication -Name SvcApp_SPSecureStoreServiceApplication_01
Remove-SPServiceApplication $SSSSPA -RemoveData -Confirm:$false 


#-7)  Create the Service Application Proxy and assign it to the Service Application.
$SvcAppProxy = New-SPSecureStoreServiceApplicationProxy `
-Name "SvcApp_SPSecureStoreServiceApplication_01_Proxy_01" `
-ServiceApplication $SvcApp

#-8)  Verify Service Application Proxy.
Get-SPServiceApplicationProxy | Select Name
'
SvcApp_SPSecureStoreServiceApplication_01_Proxy_01                                                                                               
d87e019e-33ef-4f83-8eb1-307c6ea558be                                                                                                             
ExcelServiceM
'
Get-SPServiceApplicationProxy -Identity 5e612959-5119-4284-8e1a-025dca8fb1f2
$SSSSPPy=Get-SPServiceApplicationProxy -Identity 5e612959-5119-4284-8e1a-025dca8fb1f2 |fl
remove-SPServiceApplicationProxy  $SSSSPPy -Confirm:$false


###
   Get-SPServiceApplicationProxy -DisplayName 'SvcApp_SPSecureStoreServiceApplication_01_Proxy_01'
remove- 

####4

Secure Store Service 是包含安全資料庫的宣告感知驗證服務，可儲存與應用程式識別碼相關的認證。

這些應用程式識別碼可用以授權存取外部資料來源。

Secure Store Service 提供安全儲存認證的功能，以及將認證與特定身分識別或一組身分識別建立關聯的功能。

常見的 Secure Store Servcie 案例，是應用程式嘗試驗證某個系統，而現行使用者在此系統中使用不同的名稱，或以不同的帳戶進行驗證。

搭配 Microsoft Business Connectivity Services (BCS) 一起使用時，Secure Store Service 會提供驗證外部資料來源的方法

SPSecureStoreApplication	get   new  set remove
SPSecureStoreApplicationField   new
SPSecureStoreApplicationServerKey   update
SPSecureStoreCredentialMapping   clear  update
SPSecureStoreDefaultProvider		clear    set
SPSecureStoreDefaultProvider   set
SPSecureStoreGroupCredentialMapping   update
SPSecureStoreMasterKey   update
SPSecureStoreServiceApplication  new  set
SPSecureStoreServiceApplicationProxy  new   
SPSecureStoreTargetApplication  new
SPSingleSignOn		disable
SPSingleSignOnDatabase  Upgrade
$ssApp = Get-SPSecureStoreApplication -ServiceContext http://contoso -Name "ContosoTargetApplication"Get-SPSecureStoreApplication -name SvcApp_SPSecureStoreServiceApplication_01}#------------------------------------
#   PerformancePoint Services
#------------------------------------
{Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -autoGet-SPServiceInstance  | ?  TypeName -eq 'PerformancePoint Service' |Start-SPServiceInstanceGet-SPServiceInstance  | ?  TypeName -eq 'PerformancePoint Service'$ServiceApplicationUser='CSD\administrator'$SPServiceApplicationPoolName='biWebApplicationPool' 
New-SPServiceApplicationPool -Name $SPServiceApplicationPoolName -Account $ServiceApplicationUser 

Get-SPServiceApplicationPool  $SPServiceApplicationPoolName |select *Get-SPPerformancePointServiceApplication "PPSApp_01"New-SPPerformancePointServiceApplication -Name PPS_Application_01 -ApplicationPool $SPServiceApplicationPoolNameGet-SPPerformancePointServiceApplication New-SPPerformancePointServiceApplicationProxy -Name PPS_Application_Proxy_01 -ServiceApplication PPS_Application_01 -Default'Remove-SPPerformancePointServiceApplicationProxy -Identity  PPS_Application_Proxy_01Remove-SPPerformancePointServiceApplication   -Identity PPS_Application_01'database  manual delete : PPS_Application_01_7889d5ccee414acaa2a432703e7d7b3a}#------------------------------------
#   
#------------------------------------

Get-help *powerpivot*



#------------------------------------
#   Reporting Services SharePoint 
#------------------------------------

步驟 1 (電腦 61)：在 SharePoint 模式下安裝 Reporting Services 報表伺服器 
      -在 [Reporting Services 組態] 頁面上，應該會看到已選取 [只安裝] 選項


{<#
步驟 2：安裝或解除安裝 SharePoint 的 Reporting Services 增益集   http://msdn.microsoft.com/zh-tw/library/aa905871.aspx
       (電腦 194)   下載 Reporting Services 增益集的安裝程式 (rsSharepoint.msi)  http://msdn.microsoft.com/zh-tw/library/gg426282.aspx
                   安裝程式會在下列路徑下建立資料夾，並將檔案複製到資料夾  
                   C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\
                   Rssharepoint.msi /?
                   #移除 Reporting Services 物件和功能
                    以系統管理員權限開啟命令提示字元  msiexec.exe /uninstall rsSharePoint.msi
#>}

步驟 2：安裝或解除安裝  using SQL 安裝 reporting services for sharepoint ((電腦 194)
      onenote:///C:\Users\Administrator\SkyDrive\onOnenote\0910.one#2Sql Reporting server for sharepoint&section-id={70C9D703-5271-4E87-84EC-EFAE1C8404F7}&page-id={66EF71D4-3C81-4CC3-B9F0-C252223AD821}&end

步驟 3：註冊並啟動 Reporting Services SharePoint 服務   Reporting Services 報表伺服器 (SharePoint 模式)
       (電腦 194)   按一下 [SharePoint 2013 管理命令介面]     
       Install-SPRSService

       Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto

       Get-SPServiceInstance  | ?  TypeName -eq 'SQL Server Reporting Services 服務' | Start-SPServiceInstance

       Get-SPServiceInstance  | ?  TypeName -eq 'SQL Server Reporting Services 服務' | Stop-SPServiceInstance -confirm:$false
       $RS = Get-SPServiceInstance | Where {$_.TypeName -eq "SQL Server Reporting Services Service"}
       $RS = Get-SPServiceInstance | Where {$_.TypeName -eq "SQL Server Reporting Services 服務"}
         $Status = Get-SPServiceInstance $RS.Id.ToString()

   While ($Status.Status -ne "Online")
    {
        Write-Host -ForegroundColor Green "SSRS Service Not Online...Current Status = " $Status.Status
        Start-Sleep -Seconds 2
        $Status = Get-SPServiceInstance $RS.Id.ToString()
    }

步驟 3：建立 Reporting Services 服務應用程式
       http://msdn.microsoft.com/en-us/library/jj219068.aspx
       $time=Get-Date
        write-host -foregroundcolor DarkGray StartTime>> $starttime 
        write-host -foregroundcolor DarkGray $time

        Write-Host -ForegroundColor Green "Create a new application pool and Reporting Services service application"
        Write-Host -ForegroundColor Green ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        Write-Host -ForegroundColor Green "Create a new application pool"

        Get-SPServiceApplicationPool
        $appPool= Get-SPServiceApplicationPool  biWebApplicationPool
        $rsService= New-SPRSServiceApplication -Name RSApplication -ApplicationPool $appPool -DatabaseName spRSDB -DatabaseServer "sql2012x\sql2014ent"

        $rsServiceProxy = New-SPRSServiceApplicationProxy -Name "RSApplicationProxy" -ServiceApplication $rsService

        Get-SPServiceApplicationProxyGroup -default | Add-SPServiceApplicationProxyGroupMember -Member $rsServiceProxy

         Get-SPRSDatabase
         '
         Name                     Id                                   Type                
         ----                     --                                   ----                
         ReportingDB              6526e503-1b7c-4d16-8303-b385d88bc4d8 Microsoft.Repo
'

         get-SPRSServiceApplication -Identity 61d546db-4ccd-4a27-ab7d-64c0fb1488a7
         Remove-SPServiceApplication 61d546db-4ccd-4a27-ab7d-64c0fb1488a7 -RemoveData  -confirm:$false

         Get-SPServiceApplicationProxy #Get id like  092c4d78-9db5-43ee-9180-1806f1a6eda1
         Get-SPServiceApplicationProxy -Identity 092c4d78-9db5-43ee-9180-1806f1a6eda1 | Remove-SPServiceApplicationProxy  -confirm:$false

#!!!! update "-Account" with an existing Managed Service Account

步驟 4：啟動 Power View 網站集合功能。

Enable-SPfeature -identity "powerview" -Url http://spload.csd.syscom/sites/BICenter
Enable-SPfeature -identity "reportserver" -Url http://spload.csd.syscom/sites/BICenter



步驟 1 到 4 的 Windows PowerShell 指令碼

安裝順序
以下是建議的安裝和設定順序：
#(1)電腦 61：安裝 SQL Server Reporting Services 和 SQL Server Database Engine。
#(2)電腦 61：安裝 SharePoint 2010 產品的最小安裝，讓 SharePoint 物件模型位於電腦上，而且可供報表伺服器使用。
#(3)電腦 194：執行 SharePoint 2010 產品準備工具。準備工具將會安裝適用於 SharePoint 2010 產品的 Reporting Services 增益集。
#(4)電腦 194：安裝 SharePoint Server 2010 或 SharePoint Foundation 2010。
#(5)電腦 194：執行 [SharePoint 產品及技術設定精靈]，並且選取資料庫伺服器。
#(6)電腦 194：在管理中心內設定網站集合功能，然後開啟 SharePoint 網站，確認您的安裝有效。
#(7)電腦 194:在管理中心內設定報表伺服器整合功能。



#(1) 61 chech gsv

gsv -DisplayName '*SQL Server Reporting Services*'  |ft -AutoSize

#configuration 
Get-SPServiceInstance  | ?  DisplayName -like '*Reporting Services*' 


####Shared Service and Proxy Cmdlets  http://msdn.microsoft.com/en-us/library/gg492249.aspx
#Shared Service and Proxy Cmdlets   
   Install-SPRSService
   Install-SPRSServiceProxy
   Get-SPRSProxyUrl
   Get-SPRSServiceApplicationServers
#####Service Application and Proxy Cmdlets
   Get-SPRSServiceApplication
   New-SPRSServiceApplication
   Remove-SPRSServiceApplication
   Set-SPRSServiceApplication
   New-SPRSServiceApplicationProxy
   Get-SPRSServiceApplicationProxy
   Dismount-SPRSDatabase
   Remove-SPRSDatabase
   Set-SPRSDatabase
   Mount-SPRSDatabase
   New-SPRSDatabase
   Get-SPRSDatabaseCreationScript
   Get-SPRSDatabase
   Get-SPRSDatabaseRightsScript
   Get-SPRSDatabaseUpgradeScript
#####Reporting Services Custom Functionality Cmdlets
   Update-SPRSEncryptionKey
   Restore-SPRSEncryptionKey
   Remove-SPRSEncryptedData
   Backup-SPRSEncryptionKey
   New-SPRSExtension
   Set-SPRSExtension
   Remove-SPRSExtension
   Get-SPRSExtension