<#  SP02_01PMDstepbystep  C:\Users\administrator.CSD\SkyDrive\download\PS1\SP02_BI.ps1 \\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\SP02_BI.ps1 \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1 auther : ming_tseng    a0921887912@gmail.com createDate : Sep.04.2014  lastdate :Aug.29.2015 history :  object :   $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\SP02_BI.ps1

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
#>#    08 檢查已安裝之軟件
#  20  hostname
#  35  step01  prereqs
#  75  step02  Install-ADDSForest 
# 121  step03  create BI Group ,user, OU on OS
# 251  step04  enable firewall
# 323  step05  SQL SSDE 
# 349  step06  SQL tool
# 356  step07  SQL SSASTR
# 363  step08  SQL SSASMD
# 371  step09  SSDT
# 630  step10  office
# 378  step11  preinstall   Download-SP2013PreReqFiles.ps1
# 649  step12  Install-SP2013RolesFeatures.ps1  
# 420  step13  Install-SP2013PreReqFiles.ps1 
# 430  step14  install SP
# 483  step15  SQL  alias
# 522  step 16 setup  SQL  if need
# 532  step 17 configure SP
"----------------551---------17.0 Add-PSSnapin    -----------------------""--------------572-----------17.1 Found SharePoint Server 2013 Binaries. Will create Farm now------------------------""-------------589------------17.2  Installed Help Collection------------------------""--------------602-----------17.3  Initialized SP Resource Security------------------------""-------------607------------17.4 Created Central Administration Site   inetmgr------------------------""----------717---------------17.5 Instaled SPService  ------------------------""------------827-------------17.6 Installed SP Feature------------------------""------------847------------17.7 Installed Application Content. This was the last step."
# 863 step 18   restore database &  SSAS cube

# 888 step 19  excel service
"---------- 523 ---------------19.1 建立BI專屬 ApplicaionPool   BIApplicationPool -----------------------"
"-----------  561 -------------19.2  Start the Excel Calculation Services service (SI)  --------------------------------"
"------------- 567 ------------19.3  Create an Excel Services service application(SA)   --------------------------------"

#  1002  step 20  執行 PowerPivot for SharePoint 2013 安裝  ，安裝 SharePoint 模式的 Analysis Services 伺服器 (SSASPT)
"-------------- 640 -----------20.1  安裝 PowerPivot for SharePoint  --------------------------------"

#  1060   step 21  Install or Uninstall the PowerPivot for SharePoint Add-in (SharePoint 2013)
"------------- 716 ------------21.0 Add-PSSnapin    -----------------------""--------------726 -----------21.1 check    -----------------------"
"--------------- 838 ----------21.2   download   -----------------------"
"--------------- 850 ----------21.3   決定安裝伺服器環境   -----------------------"
"---------------- 862 ---------21.4   開始安裝  msi      -----------------------"
"---------------- 884 ---------21.5   設定 by UI      -----------------------"
"---------------- 888 ---------21.6   設定 by  PS1        -----------------------"
    #1268 (1) 加入Farm Solution
    #1285 (2) DeployFarmSolution $false
    #1304 (3)將 wsp 部置至管理中心
    #  957 (4)
    #  977 (5)管理中心功能
    #  990 (6)網站層級功能  InstallSiteCollectionFeatures
    #  998 (7) create  service Instance 
    #  1019 (8) 建立 PowerPivot SA
    #  1036 (9)   PowerPivot 系統服務物件的全域屬性。
    #(10)  1072 建立 WA
    #(11)  1116 部署 WA Solution
    #  1131 (12)建立網站集合 sitecollection
    #  1164 (13) 啟用 sitecollection  feature
    #  1197 (14) 啟用 windows Token 服務
    # 1241 (15)  啟動 Secure Store Service SI
    # 1291(16)  啟動 Secure Store Service SA
    # 1717  (17)  啟動 Secure Store Service SA Proxy
    # 1787(18) 更新　主要金鑰
    # 1819 (19)

# 1851  step 22  create WebApplication Sitecollection ,web
# 1906  step 23  PerformancePoint Services
# 1941  step 24  Reporting Services SharePoint 

#   step 25  visio
#   step 26  BCS


#------------------------------------
#    08 檢查已安裝之軟件
#------------------------------------
#
$prevSPSFile='C:\temp\prevSPSFile.txt'
gwmi  Win32_Product   |select name,Version |sort name  |out-file  $prevSPSFile -Force -append

ii $prevSPSFile

#
gsv -displayname  '*sql*'
ssms
#
Get-ADDomain  # PMOCSD
whoami   # pmocsd\infra1

#------------------------------------
#    20  hostname
#------------------------------------$newname = "PMD2016" 
Rename-Computer -NewName $newname -force shutdown -r -fhostnamewf.mscfirewall.cpl #enable wf.msc all or sharing file and printer (SMB-In)  445remote desktop :port 3389ncpa.cplsysteminfo |out-file  c:\temp\systeminfo.txt -Force ; ii c:\temp\systeminfo.txt #------------------------------------
#    35  step 01 prereqs
#------------------------------------fully qualified domain name (FQDN) is named PMOCSD.syscom
Get-Module –ListAvailableGEt-WindowsFeature  RSAT-AD-PowerShell
Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools
Set-ExecutionPolicy remotesigned -forceAdd-WindowsFeature telnet-clientAdd-windowsfeature FileAndStorage-Services
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
Add-windowsfeature WoW64-SupportAdd-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementToolsRestart-Computer#------------------------------------
#   75 step 02 Install-ADDSForest 
#------------------------------------hostname : PMD2016whoami  pmd2016\administrator$domainname = "PMOCSD.SYSCOM.COM" 
$netbiosName = "PMOCSD" $pwd="p@ssw0rd1"     $t1=get-dateInstall-ADDSForest -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "Win2012R2" `
 -DomainName $domainname `
 -DomainNetbiosName $netbiosName `
 -ForestMode "Win2012R2" `
 -safemodeadministratorpassword (convertto-securestring "p@ssw0rd1" -asplaintext -force) `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true$t2=get-date  ;($t2-$t1)   Restart-Computer Get-ADDomain'PS C:\Users\Administrator>  Get-ADDomain


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=PMOCSD,DC=SYSCOM,DC=COM
DeletedObjectsContainer            : CN=Deleted Objects,DC=PMOCSD,DC=SYSCOM,DC=COM
DistinguishedName                  : DC=PMOCSD,DC=SYSCOM,DC=COM
DNSRoot                            : PMOCSD.SYSCOM.COM
DomainControllersContainer         : OU=Domain Controllers,DC=PMOCSD,DC=SYSCOM,DC=COM
DomainMode                         : Windows2012R2Domain
DomainSID                          : S-1-5-21-1411349735-3200970217-3053669373
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=PMOCSD,DC=SYSCOM,DC=COM
Forest                             : PMOCSD.SYSCOM.COM
InfrastructureMaster               : PMD2016.PMOCSD.SYSCOM.COM
LastLogonReplicationInterval       : 
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=PMOCSD,DC=SYSCOM,DC=COM}
LostAndFoundContainer              : CN=LostAndFound,DC=PMOCSD,DC=SYSCOM,DC=COM
ManagedBy                          : 
Name                               : PMOCSD
NetBIOSName                        : PMOCSD
ObjectClass                        : domainDNS
ObjectGUID                         : e08caf00-2bf8-4ebe-a716-849f583e1005
ParentDomain                       : 
PDCEmulator                        : PMD2016.PMOCSD.SYSCOM.COM
QuotasContainer                    : CN=NTDS Quotas,DC=PMOCSD,DC=SYSCOM,DC=COM
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {PMD2016.PMOCSD.SYSCOM.COM}
RIDMaster                          : PMD2016.PMOCSD.SYSCOM.COM
SubordinateReferences              : {DC=ForestDnsZones,DC=PMOCSD,DC=SYSCOM,DC=COM, DC=DomainDnsZones,DC=PMOCSD,DC=SYSCOM,DC=COM, CN=Configuration,DC=PMOCSD,DC=SYSCOM,DC=COM}
SystemsContainer                   : CN=System,DC=PMOCSD,DC=SYSCOM,DC=COM
UsersContainer                     : CN=Users,DC=PMOCSD,DC=SYSCOM,DC=COM'whoami  # pmocsd\administrator#------------------------------------
#  121 step03    create BI Group ,user, OU on OS
#------------------------------------$GroupS='BIInfraGroup','BIDesigner','BIPowerUserGroup','BIEndUserGroup','BILeaderGroup','BIAuditGroup'$OUS   ='Accounting','AP','CEO','DataAnalysis','DataModel','ETL','Report','IT','PM','Sales'$UserS ='acc2','ap1','ceo1','dm1','etl1','report1','infra1','pm1','pm2','sales2','sales1'#fully qualified domain name (FQDN) is named DEMO2013a.Contoso.com
# OUget-ADOrganizationalUnit -filter *'PS C:\Users\Administrator> get-ADOrganizationalUnit -filter *


City                     : 
Country                  : 
DistinguishedName        : OU=Domain Controllers,DC=PMOCSD,DC=SYSCOM,DC=COM
LinkedGroupPolicyObjects : {CN={6AC1786C-016F-11D2-945F-00C04fB984F9},CN=Policies,CN=System,DC=PMOCSD,DC=SYSCOM,DC=COM}
ManagedBy                : 
Name                     : Domain Controllers
ObjectClass              : organizationalUnit
ObjectGUID               : 0d855605-815b-4d2e-894e-b8bbaab853e9
PostalCode               : 
State                    : 
StreetAddress            : 'NEW-ADOrganizationalUnit “Accounting"
NEW-ADOrganizationalUnit “AP"
NEW-ADOrganizationalUnit “CEO"
NEW-ADOrganizationalUnit “DataAnalysis"
NEW-ADOrganizationalUnit “IT"
NEW-ADOrganizationalUnit “PM"
NEW-ADOrganizationalUnit “Sales"


NEW-ADOrganizationalUnit “ETL” –path “OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM”
NEW-ADOrganizationalUnit “DataModel” –path “OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM”
NEW-ADOrganizationalUnit “Report” –path “OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM”get-ADOrganizationalUnit -filter * |select DistinguishedName'PS C:\Users\Administrator> get-ADOrganizationalUnit -filter * |select DistinguishedName

DistinguishedName                                                                                                                                                                    
-----------------                                                                                                                                                                    
OU=Domain Controllers,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                     
OU=Accounting,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                             
OU=AP,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                                     
OU=CEO,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                                    
OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                           
OU=IT,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                                     
OU=PM,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                                     
OU=Sales,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                                  
OU=ETL,OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                    
OU=DataModel,OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                              
OU=Report,OU=DataAnalysis,DC=PMOCSD,DC=SYSCOM,DC=COM                                                                                                                                 
'dsa.mscdnsmgmt.msc# Users$oupath=',DC=PMOCSD,DC=SYSCOM,DC=COM'New-ADUser acc2 -SamAccountName "acc2"   -GivenName "acc2"  -Surname "Accounting"  -DisplayName "acc2"  -Path "OU=Accounting$oupath"New-ADUser ap1 -SamAccountName "ap1"   -GivenName "ap1"  -Surname "AP"  -DisplayName "ap1"  -Path "OU=AP$oupath"
New-ADUser ceo1 -SamAccountName "ceo1"  -GivenName "ceo1" -Surname "CEO" -DisplayName "ceo1" -Path "OU=CEO$oupath"
New-ADUser dm1 -SamAccountName "dm1"  -GivenName "dm1" -Surname "DataModel" -DisplayName "dm1" -Path "OU=DataModel,OU=DataAnalysis$oupath"
New-ADUser etl1 -SamAccountName "etl1"  -GivenName "etl1" -Surname "DataModel" -DisplayName "etl1" -Path "OU=ETL,OU=DataAnalysis$oupath"
New-ADUser report1 -SamAccountName "report1"  -GivenName "report1" -Surname "Report" -DisplayName "report1" -Path "OU=Report,OU=DataAnalysis$oupath"
New-ADUser infra1 -SamAccountName "infra1"  -GivenName "infra1" -Surname "IT" -DisplayName "infra1" -Path "OU=IT$oupath"

# infraSSDE 為SQL Startup account have enterprise admin Role
New-ADUser infraSSDE -SamAccountName "infraSSDE"  -GivenName "infraSSDE" -Surname "IT" -DisplayName "infraSSDE" -Path "OU=IT$oupath"
# infraSSASMD ,infraSSASTR,infraSSRSNT ,infraSSRSSP為SQL Startup account have enterprise admin Role
New-ADUser infraSSASMD -SamAccountName "infraSSASMD"  -GivenName "infraSSASMD" -Surname "IT" -DisplayName "infraSSASMD" -Path "OU=IT$oupath"
New-ADUser infraSSASTR -SamAccountName "infraSSASTR"  -GivenName "infraSSASTR" -Surname "IT" -DisplayName "infraSSASTR" -Path "OU=IT$oupath"
New-ADUser infraSSRSNT -SamAccountName "infraSSRSNT"  -GivenName "infraSSRSNT" -Surname "IT" -DisplayName "infraSSRSNT" -Path "OU=IT$oupath"
New-ADUser infraSSRSSP -SamAccountName "infraSSRSSP"  -GivenName "infraSSRSSP" -Surname "IT" -DisplayName "infraSSRSSP" -Path "OU=IT$oupath"
New-ADUser infraSSASPT -SamAccountName "infraSSASPT"  -GivenName "infraSSASPT" -Surname "IT" -DisplayName "infraSSASPT" -Path "OU=IT$oupath"

SPFarm=infra1
#New-ADUser SPFarm -SamAccountName "SPFarm"  -GivenName "SPFarm" -Surname "IT" -DisplayName "SPFarm" -Path "OU=IT$oupath"
New-ADUser SPService -SamAccountName "SPService"  -GivenName "SPService" -Surname "IT" -DisplayName "SPService" -Path "OU=IT$oupath"
New-ADUser SPAdmin   -SamAccountName "SPAdmin"    -GivenName "SPAdmin"   -Surname "IT" -DisplayName "SPAdmin"   -Path "OU=IT$oupath"

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
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Infra Group'}).DistinguishedName –Member (Get-ADUser -Filter * | ? samaccountname -eq 'SPAdmin').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Infra Group'}).DistinguishedName –Member (Get-ADUser -Filter * | ? samaccountname -eq 'SPService').DistinguishedName



Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Leader Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*pm1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*pm2"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*sales1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI EndUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*sales2"').DistinguishedName##  手動設定 Group 是屬於那一個內建群組 ex: BI Infra Group = Enterpsire Administrator ##  ADUser 重設密碼Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)
Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'SPAdmin').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'SPService').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)  Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSDE').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASTR').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASMD').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)  Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASPT').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)## enable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'SPAdmin').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'SPService').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSDE').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASTR').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASMD').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASPT').DistinguishedName## Search-ADAccount -AccountDisabled | FT Name,ObjectClass -A##  手動設定 compmgmt.mscdsa.mscAdd  BI Infra Group  to localAdministrator#------------------------------------
#   251  step04  enable firewall
#------------------------------------firewall.cplwf.msctelnet pmd2016 1433{<#https://msdn.microsoft.com/en-us/library/cc646023.aspx#BKMK_basicusing powershell_ise as administratorBasic Firewall Information
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
netsh advfirewall firewall add rule name = SQLPort1433 dir = in protocol = tcp action = allow localport = 1433 remoteip = localsubnet profile = DOMAIN#>}#------------------------------------
#  323 step05  SQL SSDE   & SSDW
#------------------------------------change user  infra1 login make sure  infra1   local administrators Group whoami  #pmocsd\infra1
##

MD D:\SQLData
MD C:\SQLLogMD C:\SQLTEMPDBMD D:\SQLASMD  ; MD :\SQLMD MD D:\SQLASTRMD D:\SQLASPTMD D:\SQLDATA\BackupMD D:\SQLDW執行個體根目錄     :C:\Program Files\Microsoft SQL Server\共用功能目錄       :C:\Program Files\Microsoft SQL Server\共用功能目錄(X86)  :C:\Program Files (x86)\Microsoft SQL Server\## check .net3.5Get-WindowsFeature  NET-Framework-Coreadd-WindowsFeature  NET-Framework-Core  -Source D:\software2015\Windows_SXS ii 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150910_093601' cpi -Path 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150910_093601\ConfigurationFile.ini' -Destination D:\temp\SSDE_ConfigurationFile.ini -Force ii 'D:\temp\SSDE_ConfigurationFile.ini' ## FEATURES=SQLENGINE,REPLICATION,SSMS,ADV_SSMS,SNAC_SDK Add  SQLSVCPASSWORD="p@ssw0rd" AGTSVCPASSWORD="p@ssw0rd" SAPWD="p@ssw0rd" modify  INSTANCENAME="MSSQLSERVER" to INSTANCENAME="SSDE"  shutdown -s -f  make VM snapshot ##  C:\Users\administrator.CSD\OneDrive\download\PS1\SQLINI\SQL2014SSDE      (Data Engine + Tool)    SSDE_ConfigurationFile.iniSSASTR    Tabular                 SSASTR_ConfigurationFileSSASMD    Multi-Dimension         SSASMD_ConfigurationFile.iniSSASPT    PowerPivot             SSASPT_ConfigurationFile.iniSSRSSP    RSIntegratedSharpoint  SSIS    cmd /c ("D:\software2015\SQL2014_ENT_TW_X64\Setup") '/ConfigurationFile=D:\temp\SSDE_ConfigurationFile.ini'ssmsgsv *sql*'PS C:\Windows\system32> gsv *sql*

Status   Name               DisplayName                           
------   ----               -----------                           
Running  MSSQL$SSDE         SQL Server (SSDE)                     
Running  SQLAgent$SSDE      SQL Server Agent (SSDE)               
Running  SQLBrowser         SQL Server Browser                    
Running  SQLWriter          SQL Server VSS Writer' $tsql_alterserverRole=@"ALTER SERVER ROLE [dbcreator] ADD MEMBER [TEMPCSD\BIinfraGroup]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [TEMPCSD\BIinfraGroup]
GO
ALTER SERVER ROLE [sysadmin] DROP MEMBER [TEMPCSD\BIinfraGroup]
GO
"@make one VM snapshot #------------------------------------
# 349 step06  SQL tool  import
#------------------------------------ 合併在 SSDE  Import-Module  'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\SQLPS' -DisableNameChecking get-Module 'PS SQLSERVER:\>  get-Module

ModuleType Version    Name                                ExportedCommands                                                           
---------- -------    ----                                ----------------                                                           
Script     1.0.0.0    ISE                                 {Get-IseSnippet, Import-IseSnippet, New-IseSnippet}                        
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Content...}         
Manifest   3.0.0.0    Microsoft.PowerShell.Security       {ConvertFrom-SecureString, ConvertTo-SecureString, Get-Acl, Get-Authenti...
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}                  
Manifest   3.0.0.0    Microsoft.WSMan.Management          {Connect-WSMan, Disable-WSManCredSSP, Disconnect-WSMan, Enable-WSManCred...
Script     0.0        Sqlps                                                                                                          
Manifest   1.0        SQLPS                               {Add-SqlAvailabilityDatabase, Add-SqlAvailabilityGroupListenerStaticIp, ...
' Import-module 'C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\sqlascmdlets' -DisableNameChecking 'PS SQLSERVER:\>  get-Module

ModuleType Version    Name                                ExportedCommands                                                           
---------- -------    ----                                ----------------                                                           
Script     1.0.0.0    ISE                                 {Get-IseSnippet, Import-IseSnippet, New-IseSnippet}                        
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Content...}         
Manifest   3.0.0.0    Microsoft.PowerShell.Security       {ConvertFrom-SecureString, ConvertTo-SecureString, Get-Acl, Get-Authenti...
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}                  
Manifest   3.0.0.0    Microsoft.WSMan.Management          {Connect-WSMan, Disable-WSManCredSSP, Disconnect-WSMan, Enable-WSManCred...
Manifest   1.0        sqlascmdlets                        {Add-RoleMember, Backup-ASDatabase, Invoke-ASCmd, Invoke-ProcessCube...}   
Script     0.0        Sqlps                                                                                                          
Manifest   1.0        SQLPS                               {Add-SqlAvailabilityDatabase, Add-SqlAvailabilityGroupListenerStaticIp, ...
'#------------------------------------
#  356 step07  SQL SSASTR
#------------------------------------ ii 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150911_121400\ConfigurationFile.ini' cpi -Path 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150911_121400\ConfigurationFile.ini' -Destination D:\temp\SSASTR_ConfigurationFile.ini -Force ii 'D:\temp\SSASTR_ConfigurationFile.ini' ADD  ASSVCPASSWORD="p@ssw0rd"cmd /c ("D:\software2015\SQL2014_ENT_TW_X64\Setup") '/ConfigurationFile=D:\temp\SSASTR_ConfigurationFile.ini'#------------------------------------
# 363  step8  SQL SSASMD
#------------------------------------$confini='C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20150911_233300\ConfigurationFile.ini' ii $confini cpi -Path $confini -Destination D:\temp\SSASMD_ConfigurationFile.ini -Force ii 'D:\temp\SSASMD_ConfigurationFile.ini' ADD  ASSVCPASSWORD="p@ssw0rd"cmd /c ("D:\software2015\SQL2014_ENT_TW_X64\Setup") '/ConfigurationFile=D:\temp\SSASMD_ConfigurationFile.ini'\SQLPS21_BI.ps1 #  27 Analysis Services PowerShell#------------------------------------
# 371  step9  SSDT
#------------------------------------# 完整安裝   Microsoft SQL Server Data Tools - Business Intelligence for Visual Studio 2013  http://www.microsoft.com/en-US/download/details.aspx?id=42313  \\172.16.220.33\d$\software2015\SQL2014_ENT_TW_X64\Tools\SSDTBI_ENU  :1094M  unzip  \SSDTBI_x86_ENU# 這版本需要事先安裝Visual Studio   English (United States)	VS 2015 component update ISO - EN    https://msdn.microsoft.com/zh-tw/mt186501    \\192.168.112.144\D$\software2015\SSDT_14.0.50730.0_EN.iso  : 770Mshutdown  -r -f devenvssms#------------------------------------
#  630 step 10  office
#------------------------------------

office professional plus_2013  2013 D:\software2015\en_office_professional_plus_2013_x64_dvd_1123674.iso

#------------------------------------
#  378 step 11 preinstall   Download-SP2013PreReqFiles.ps1
#------------------------------------
SP01_installconfg.ps1   561 Install and Download SharePoint 2013 prerequisites offline

$prevSPSFile='C:\temp\prevSPSFile.txt'
gwmi  Win32_Product   |select name,Version |sort name  |out-file  $prevSPSFile -Force -append

ii $prevSPSFile

\\192.168.112.144\D$\software2015\SP2103software # Sep.2015 ready include PreReqFiles

#------------------------------------
#  649   step 12  Install-SP2013RolesFeatures.ps1
#------------------------------------
SP01_installconfg.ps1  719  Install-SP2013RolesFeatures.ps1

C:\Sharepoint2013preReqFiles
$prevWindowsFeature='C:\temp\prevWindowsFeature.txt'


Get-WindowsFeature | ? Installed |out-file $prevWindowsFeature -append  ;ii $prevWindowsFeature

Add-WindowsFeature Net-Framework-Features,Web-Server,Web-WebServer,Web-Common-Http,Web-Static-Content,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors `
,Web-App-Dev,Web-Asp-Net,Web-Net-Ext,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Health,Web-Http-Logging,Web-Log-Libraries,Web-Request-Monitor `
,Web-Http-Tracing,Web-Security,Web-Basic-Auth,Web-Windows-Auth,Web-Filtering,Web-Digest-Auth,Web-Performance,Web-Stat-Compression `
,Web-Dyn-Compression,Web-Mgmt-Tools,Web-Mgmt-Console,Web-Mgmt-Compat,Web-Metabase,Application-Server,AS-Web-Support,AS-TCP-Port-Sharing `
,AS-WAS-Support,AS-HTTP-Activation,AS-TCP-Activation,AS-Named-Pipes,AS-Net-Framework,WAS,WAS-Process-Model,WAS-NET-Environment `
,WAS-Config-APIs,Web-Lgcy-Scripting,Windows-Identity-Foundation,Server-Media-Foundation,Xps-Viewer -source D:\software2015\Windows_SXS

$postWindowsFeature='C:\temp\postWindowsFeature.txt'


Get-WindowsFeature | ? Installed |out-file $postWindowsFeature -append  ;ii $postWindowsFeature



$prevgsv='C:\temp\prevgsv.txt' ; ii $prevgsv
gsv |out-file $prevgsv -force ; ii $prevgsv


Restart-Computer

shutdown -r -f
#------------------------------------
#  420 step 13  Install-SP2013PreReqFiles.ps1 
#------------------------------------
  SP01_installconfg.ps1  890  Install-SP2013PreReqFiles.ps1  
   先將iso unzip to Folder(like SP2013source) ,
 再將已Download DownLoadPreRequisites copy to \SP2013source\prerequisiteinstallerfiles\*.*
 設定 $SharePoint2013Path='C:\SP2013source'
 直接執行 InstallPreReqFiles .會出現安裝畫面,Next , Next  會自動一直run 下去. 5 about mins 即會OK
 會自動Reboot 再繼續 Next . 直到完成
 記得 安裝Software 不要用ISO模擬光碟機. 會出問題



 D:\

  $SharePoint2013Path ="D:\software2015\SP2103software"

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

        #Oct.7.2015 done
#------------------------------------
# 430  step 14  install SP
#------------------------------------

僅安裝(install)不進行設定(configuration).using UI

. D:\software2015\SP2103software\setup.exe

 NQTMW-K63MQ-39G6H-B2CH9-FRDWJ (Trial)
 P4GN7-G2J3K-XPQYT-XG4J4-F6WFV (M3)
  
  & 'C:\Program Files\Microsoft Office Servers'
  
# If Search Server  please assign  index files
Index file : C:\Program Files\Microsoft Office Servers\15.0\Data


## check 14.1  service on OS
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

# check 14.2  appwiz.cpl
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

# check 14.3
#先等configuration完成之後
ASNP Microsoft.SharePoint.Powershell
(Get-SPFarm).Products

        #Oct.7.2015 done
#------------------------------------
#  483 step 15  SQL  alias
#------------------------------------
# SQL Server client alias
$AliasName = "SPFarmSQL"


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
  
$ServerName = $env:computername+'\SSDE'
#Adding the extra "fluff" to tell the machine what type of alias it is
$TCPAlias = ("DBMSSOCN," + $ServerName)
  
#Creating our TCP/IP Aliases
New-ItemProperty -Path $x86 -Name $AliasName -PropertyType String -Value $TCPAlias
New-ItemProperty -Path $x64 -Name $AliasName -PropertyType String -Value $TCPAlias
 
# Open cliconfig to verify the aliases
Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

#check 5.1
Invoke-Sqlcmd -Query "SELECT @@servername as hostname "  -ServerInstance "$AliasName" #-Database $dbName
 
        #Oct.7.2015 done
#------------------------------------
# 522  step 16 setup  SQL  if need
#------------------------------------
setup SPFarm  to Tempcsd\BIinfraGroup

pmocsd\BIinfraGroup  have dbcreate & securityadmin

 SQL Server 執行個體的「平行處理原則的最大程度」設定值，未依規定設為 1


#------------------------------------
# 532  step 17  configure SP 
#------------------------------------
I amd whoami  pmocsd\infra1 (infra1 = SPFarm )

# Service accounts
$DOMAIN = "PMOCSD.SYSCOM"
$DOMAIN = "PMOCSD"

$accounts = @{}
$accounts.Add("infra1", @{"username" = "infra1"; "password" = "p@ssw0rd"})
$accounts.Add("SPAdmin", @{"username" = "SPAdmin"; "password" = "pass@word1"})
$accounts.Add("SPWebApp", @{"username" = "SPWebApp"; "password" = "pass@word1"})
$accounts.Add("SPService", @{"username" = "SPService"; "password" = "pass@word1"})
 
 
Foreach ($account in $accounts.keys) {
    $accounts.$account.Add(`
    "credential", `
    (New-Object System.Management.Automation.PSCredential ($DOMAIN + "\" + $accounts.$account.username), `
    (ConvertTo-SecureString -String $accounts.$account.password -AsPlainText -Force)))
}
 
"----------------551---------17.0 Add-PSSnapin    -----------------------"

$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}
# Values mentioned below needs to be edited
$AliasName = "SPFarmSQL"
$DatabaseServer = $AliasName  ; #SPecify the instance name if SQL is not installed on default instance#$FarmName = Hostname#$FarmName = $ServerName ; #Hostname$ConfigDB = $FarmName+"_ConfigDB";$AdminContentDB = $FarmName+"_CentralAdminContent";$Passphrase = convertto-securestring "p@ssw0rdx" -asplaintext -force;$Port = "2013";$Authentication = "NTLM";#$FarmAccount = "tempcsd\spFarm"
$FarmAccount = $accounts.infra1.credential  #PMOCSD.SYSCOM\infra1
"--------------572-----------17.1 Found SharePoint Server 2013 Binaries. Will create Farm now------------------------"#rember : run powershell_ise as administratorNew-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer `-FarmCredentials (Get-Credential $farmAccount) -Passphrase $Passphrase `-AdministrationContentDatabaseName $AdminContentDB#Disconnect-SPConfigurationDatabase -Confirm:$false#get-help Disconnect-SPConfigurationDatabase -full#Remove-PSSnapin Microsoft.SharePoint.PowerShell#Add-PSSnapin Microsoft.SharePoint.PowerShell#check 7.1$farm = Get-SPFarm
if (!$farm -or $farm.Status -ne "Online") {
    Write-Output "Farm was not created or is not running"
    exit
}        #Oct.7.2015 done
"-------------589------------17.2  Installed Help Collection------------------------"$t1=get-dateInstall-SPHelpCollection -All$t2=get-date#Get-help Install-SPHelpCollection  -full# get-sphelpcollectionC:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\HCCab\1028\Install-SPHelpCollection Cmdlet 會在目前的伺服器陣列安裝 SharePoint 2010 產品的 Help 網站集合檔案。使用 LiteralPath 參數可安裝特定的自訂 Help 集合檔案。若未指定 LiteralPath 參數，即會安裝 Help 網站集合所有可用的 Help，並覆寫現有的 Help 集合檔案。        #Oct.7.2015 done
"--------------602-----------17.3  Initialized SP Resource Security------------------------"$t1=get-dateInitialize-SPResourceSecurity$t2=get-date        #Oct.7.2015 done
"-------------607------------17.4 Created Central Administration Site   inetmgr------------------------"$t1=get-dateNew-SPCentralAdministration -Port $Port -WindowsAuthProvider 'NTLM'$t2=get-date; $t2-$t1 #2min,15 sec(tempcsd)  ,1 min 33 (PMP2016)#check inetmgr # can see  "SharePoint Central Administration v4"可以登入 http://localhost:2013/ (remember: infra1 , p@ssw0rd 才是管理帳號)#check (Get-SPFarm).Products<#9ff54ebc-8c12-47d7-854f-3865d4be8118                                                                                                                                        
b7d84c2b-0754-49e4-b7be-7ee321dce0a9 #>#checkGo to Central Administration.Click on “Upgrade and Migration” on the Quick Links. Click on “Check Product and Patch Installation Status” 'PMD2016 Microsoft SharePoint Server 2013   已安裝 
 PMD2016 
 Microsoft Access Services Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Access Services Server 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Document Lifecycle Components 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Document Lifecycle Components Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Education 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Education Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Excel Mobile Viewer Components 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Excel Services Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Excel Services Components 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft InfoPath Form Services Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft InfoPath Forms Services 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Office PowerPoint Services 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Office PowerPoint Services Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Search Server 2013 Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Search Server 2013 Core 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Server Proof (Arabic) 2013 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Server Proof (English) 2013 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Server Proof (French) 2013 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Server Proof (German) 2013 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Server Proof (Russian) 2013 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Server Proof (Spanish) 2013 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Shared Components 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Shared Coms Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Foundation 2013 1028 Lang Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Foundation 2013 1028 SQL Express 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Foundation 2013 Core 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Multilingual Solutions 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Multilingual Solutions Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Portal 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Portal Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft SharePoint Server 2013  
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Slide Library 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Slide Library Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft User Profiles 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Visio Services Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Visio Services Web Front End Components 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Web Analytics Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Web Analytics Web Front End Components 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Word Server 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Word Server Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Workflow Solutions Framework 
 15.0.4569.1506 已安裝 
 PMD2016 
 Microsoft Workflow Solutions Framework Chinese (Traditional) Language Pack 
 15.0.4569.1506 已安裝 
 PMD2016 
 PerformancePoint Services for SharePoint 
 15.0.4569.1506 已安裝 
 PMD2016 
 PerformancePoint Services in SharePoint 1028 Language Pack 
 15.0.4569.1506 已安裝 
'#checkgsv | ? displayname -Like '*SharePoint*' |ft -AutoSize<#Status  Name                   DisplayName                                
------  ----                   -----------                                
  Stopped DCLauncher15           Microsoft SharePoint Server 2013 的文件轉換啟動器  
  Stopped DCLoadBalancer15       Microsoft SharePoint Server 2013 的文件轉換負載平衡器
  Stopped OSearch15              SharePoint Server Search 15                
Running SPAdminV4              SharePoint Administration                  
  Stopped SPSearchHostController SharePoint Search Host Controller          
Running SPTimerV4              SharePoint Timer Service                   
Running SPTraceV4              SharePoint Tracing Service                 
  Stopped SPUserCodeV4           SharePoint User Code Host                  
  Stopped SPWriterV4             SharePoint VSS Writer  Running W3SVC                    World Wide Web Publishing Service#>$postgsv='C:\temp\postgsv.txt'
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


#check(get-command *get-SP*).count ;# 190 (pmocsd)#Get-SPServiceApplicationPool<#Name                                     ProcessAccountName                                                                                                                 
----                                     ------------------                                                                                                                 
SecurityTokenServiceApplicationPool      TEMPCSD\SPFarm                                                                                                                     
SharePoint Web Services System           TEMPCSD\SPFarm 
Name                                     ProcessAccountName                                                                                                              
----                                     ------------------                                                                                                              
SecurityTokenServiceApplicationPool      PMOCSD\infra1                                                                                                                   
SharePoint Web Services System           PMOCSD\infra1 #>SPServiceApplicationProxyGroup  <#FriendlyName                     Proxies                                                               DefaultProxies                                                       
------------                     -------                                                               --------------                                                       
[default]                        {}                                                                    {}            #>#add-SPServiceApplicationProxyGroupMember  SPServiceApplicationProxy<# Null #>get-SPServiceHostConfig<#HttpPort                : 32843
HttpsPort               : 32844
NetTcpPort              : 32845
SslCertificateStoreName : SharePoint
SslCertificateFindType  : FindBySubjectDistinguishedName
SslCertificateFindValue : CN=SharePoint Services, OU=SharePoint, O=Microsoft, C=US#>Get-SPDatabase |ft -AutoSize<#Name                                Id                                   Type 
----                                --                                   ---- 
WIN-2S026UBRQFO_ConfigDB            23c7684b-3081-487e-92c9-909dbdc7857b 設定資料庫
WIN-2S026UBRQFO_CentralAdminContent 1877b232-1538-44ac-b215-7121f5c36ba6 內容資料庫PMOCSD > Get-SPDatabase |ft -AutoSize

Name                 Id                                   Type 
----                 --                                   ---- 
_ConfigDB            e731c0b3-2cd3-46b8-a7f2-be3ed61dc061 設定資料庫
_CentralAdminContent 16287a44-69fa-4f62-83d0-31c0278ac895 內容資料庫
#>        #Oct.7.2015 done
"-------------------------------------------------------------------------""----------717---------------17.5 Instaled SPService  ------------------------""-------------------------------------------------------------------------"在伺服器陣列上安裝及佈建  Servcie 服務 此 Cmdlet 會安裝本機伺服器電腦上的登錄中指定的所有服務、服務執行個體及服務 Proxy。在建立的指令碼中使用此 Cmdlet，可安裝及部署 SharePoint 伺服器陣列，或是安裝自訂開發的服務# get SPServiceInstance 安裝前sp01_installconfg 12  450  Manage services on server  for SharepointGet-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto
<# count 7 ,5 online, 2 disableStatus TypeName                                  Id                                  
  ------ --------                                  --                                  
  Online Microsoft SharePoint Foundation Web 應用程式   Microsoft SharePoint Foundation Web Application      8200bcb2-3997-4a29-8908-be9d3b788ea7
  Online Microsoft SharePoint Foundation 工作流程計時器服務  2c9ee7e1-589d-4148-be12-cd531c2d7efd
  Online Microsoft SharePoint Foundation 內送電子郵件       e6997d4e-ad9a-4fee-a360-e6751a57237a
  Online 分散式快取  (Distributed Cache)                    18ed1aa2-effc-4638-aaf7-7c3024f3dc27
  Online 管理中心   (Central Administration)               51dc6952-dd56-4d3b-9fb5-eb84b34bc264
Disabled Microsoft SharePoint Foundation 沙箱化程式碼服務   578e8222-a5ce-4ce3-aa25-e64660e221a4
Disabled 要求管理   (Request Management)                  41589d67-0b85-4882-9d33-f70000a96e42#>$t1=get-datewrite-host -f Yellow "Install-SPService   ... Loading now"Install-SPService$t2=get-date ;($t2-$t1)  #34sec(tempcsd) , 16sec (PMOCSD)write-host -f Green "Install-SPService is now loaded"# get SPServiceInstance 安裝後Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto(Get-SPServiceInstance -Server  $env:COMPUTERNAME ).count<#  count=30, 增加 23 個PS C:\Windows\system32> Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto

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
Disabled 對 Windows Token 服務的宣告                     8efab8a2-b021-490d-90e0-41af65cecb28#>(gsv |ft -AutoSize).count  #186gsv | ? displayname -Like '*sharepoint*' |ft -AutoSize gsv |ft -AutoSize gsv |? displayname -eq '啟動器服務' |select *gsv |? name -eq 'spworkflowtimerv4' |select *Get-SPServiceInstance |select servcieGet-SPServiceInstance -Identity 51dc6952-dd56-4d3b-9fb5-eb84b34bc264 |select *Get-SPServiceInstance -Identity 664a26df-6f6c-4ae2-9c72-d0276737273a |gm# get SPServiceApplicationGet-SPServiceApplication | ft -AutoSizeUI : Application Management > service applications > Manage services on server <#DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
<PMOCSD>
DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application dd30c213-b5ac-4eb1-ac2c-762102e7dccd
#>        #Oct.7.2015 done
"-------------------------------------------------------------------------""------------827-------------17.6 Installed SP Feature------------------------""-------------------------------------------------------------------------"prev-install : ref 528  SPFeature prev  get , install, enable , uninstall$t1=get-datewrite-host -f Yellow "Install-SPFeature   ... Loading now"Install-SPFeature -AllExistingFeatures$t2=get-date ;($t2-$t1)  #  1m 48 Sec(tempCSD)  1m02sec(PMOCSD)write-host -f Green "Install-SPFeature is now loaded"安裝完成之後。由原本　60 個增加為 657個#Uninstall-SPFeature -AllExistingFeatures#get-help Uninstall-SPFeature -full(Get-SPFeature).count        #Oct.7.2015 done
"-------------------------------------------------------------------------""------------847------------17.7 Installed Application Content. This was the last step.""-------------------------------------------------------------------------"Install-SPApplicationContent$featurefoler=“$env:ProgramFiles\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\”
ii $featurefoler  ; count=409

        #Oct.7.2015 done
"-------------------------------------------------------------------------""17.8 Farm Configuration Complete!""-------------------------------------------------------------------------"#Start Central Administration
Write-Output "Starting Central Administration"
& 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\BIN\psconfigui.exe' -cmd showcentraladmin


 管理服務應用程式 |   http://localhost:2013/_admin/ServiceApplications.aspx


#------------------------------------
# 863 step 18   restore database &  SSAS cube
#------------------------------------
I am whoami  : tempcsd\infra1

# database SSDE
& '\\192.168.112.129\h$\mydataII\booksExample\excelDataPivotTable\第三章範例檔\AdventureWorks_Data.mdf'
& '\\192.168.112.129\h$\mydataII\booksExample\excelDataPivotTable\第三章範例檔\AdventureWorksDW_Data.mdf'



# SSAS cube






#------------------------------------
# 888 step 19  excel service
#------------------------------------


"-------------------------19.0 Add-PSSnapin    -----------------------"$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}

"---------- 523 ---------------19.1 建立BI專屬 ApplicaionPool   BIApplicationPool -----------------------"
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

"-----------  561 -------------19.2  Start the Excel Calculation Services service (SI)  --------------------------------"
Get-SPServiceInstance | ?  TypeName -eq 'Excel Calculation Services'  # 8ee5a10b-7777-4754-b461-ce21d5cfd45e
Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' |Start-SPServiceInstance
Get-SPServiceInstance | ?  TypeName -eq 'Excel Calculation Services'   # status = online


"------------- 567 ------------19.3  Create an Excel Services service application(SA)   --------------------------------"

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
#  1002  step 20  執行 PowerPivot for SharePoint 2013 安裝  ，安裝 SharePoint 模式的 Analysis Services 伺服器 (SSASPT)
#------------------------------------
whoami  #tempcsd\infra1


步驟 1：安裝 PowerPivot for SharePoint
步驟 2：設定基本 Analysis Services SharePoint 整合
步驟 3：確認整合
設定 Windows 防火牆以允許 Analysis Services 存取
升級活頁簿和排程的資料重新整理

"-------------- 640 -----------20.1  安裝 PowerPivot for SharePoint  --------------------------------"

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
#  1060   step 21  Install or Uninstall the PowerPivot for SharePoint Add-in (SharePoint 2013)
#------------------------------------
I am whoami  : tempcsd\infra1

SpPowerPivot.msi 是SQLServer 提供(出品).QL Server 2014 PowerPivot for SharePoint 2013 在 SharePoint 2013 伺服器陣列中提供增強型 PowerPivot 功能和經驗。
這些功能包括使用活頁簿做為  資料來源、排程資料重新整理、 PowerPivot 圖庫  與 PowerPivot 管理儀表板

由於有SQL2012 , 
SQL2014   spPowerPivot_SQL_2014.msi  存放在  \\192.168.112.129\h$\software2015\SQL_PowerPivot_msi 

"------------- 716 ------------21.0 Add-PSSnapin    -----------------------"

$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}

"--------------726 -----------21.1 check    -----------------------"
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



"--------------- 838 ----------21.2   download   -----------------------"
Microsoft® SQL Server® 2012 SP1 PowerPivot® for Microsoft SharePoint®
https://www.microsoft.com/en-us/download/details.aspx?id=35577

Microsoft® SQL Server® 2014 PowerPivot for Microsoft SharePoint®
http://www.microsoft.com/en-us/download/details.aspx?id=42300
http://www.microsoft.com/zh-TW/download/details.aspx?id=42300


also copy from \\192.168.112.129\h$\software2015\SQL_PowerPivot_msi  (Sep.7.2015)


"--------------- 850 ----------21.3   決定安裝伺服器環境   -----------------------"

https://msdn.microsoft.com/en-us/library/hh231674.aspx

PowerPivot for sharepoint 2013 and Reporting service: single server (excel SA + Powerpivot SA, Reporting Service + reporint SA + reporting Service Add-in)
PowerPivot for sharepoint 2013 and Reporting service : two server 
PowerPivot for sharepoint 2013 and Reporting service : three server

PowerPivot for sharepoint 2013  : single server (excel , default power pivot server application , dbs , SSASPT) 
PowerPivot for sharepoint 2013  : two server (server1: SSASPT, DBs . server 2 :  execl + PowerPivot SA, sppowerpivot.msi
PowerPivot for sharepoint 2013  three server

"---------------- 862 ---------21.4   開始安裝  msi      -----------------------"
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



"---------------- 884 ---------21.5   設定 by UI      -----------------------"
 
 會在 Microsoft SQL server 2014 中新增   PowerPivot for Sharepoint 

"---------------- 888 ---------21.6   設定 by  PS1        -----------------------"
C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources



# 開啟 PowerShell 程式庫來源: C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources\ConfigurePowerPivot.ps1

#1268 (1) 加入Farm Solution
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

#1285 (2) DeployFarmSolution $false

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
    


#1304 (3)將 wsp 部置至管理中心
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
-DatabaseServerName 'SPFarmSQL' -DatabaseName 'PowerPivotServiceApplicationDB' -AddToDefaultProxyGroup:$true

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
$dbServer  ='SPFarmSQL'
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
CreateSecureStoreApplicationService 'SPFarmSQL' 'Secure Store Service'

	$DbServerAddress="SPFarmSQL"
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

     
#1717 (17)  啟動 Secure Store Service SA Proxy
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


#1787 (18) 更新　主要金鑰
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


#1819 (19)
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




#------------------------------------
# 1851  step 22  create WebApplication Sitecollection ,web
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
      

  Get-SPManagedAccount  ## set}#------------------------------------
# 1906  step 23  PerformancePoint Services
#------------------------------------
{Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -autoGet-SPServiceInstance  | ?  TypeName -eq 'PerformancePoint Service' |Start-SPServiceInstanceGet-SPServiceInstance  | ?  TypeName -eq 'PerformancePoint Service'$ServiceApplicationUser='CSD\administrator'$SPServiceApplicationPoolName='biWebApplicationPool' 
New-SPServiceApplicationPool -Name $SPServiceApplicationPoolName -Account $ServiceApplicationUser 

Get-SPServiceApplicationPool  $SPServiceApplicationPoolName |select *Get-SPPerformancePointServiceApplication "PPSApp_01"New-SPPerformancePointServiceApplication -Name PPS_Application_01 -ApplicationPool $SPServiceApplicationPoolNameGet-SPPerformancePointServiceApplication New-SPPerformancePointServiceApplicationProxy -Name PPS_Application_Proxy_01 -ServiceApplication PPS_Application_01 -Default'Remove-SPPerformancePointServiceApplicationProxy -Identity  PPS_Application_Proxy_01Remove-SPPerformancePointServiceApplication   -Identity PPS_Application_01'database  manual delete : PPS_Application_01_7889d5ccee414acaa2a432703e7d7b3a}
#------------------------------------
# 1941 step 24  Reporting Services SharePoint 
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


 #------------------------------------
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
#  Secure Store Service
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
$ssApp = Get-SPSecureStoreApplication -ServiceContext http://contoso -Name "ContosoTargetApplication"Get-SPSecureStoreApplication -name SvcApp_SPSecureStoreServiceApplication_01}  #------------------------------------
#    
#------------------------------------#------------------------------------
#    
#------------------------------------