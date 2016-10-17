<#  SP02_01PMDstepbystep  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1 from C:\Users\administrator.CSD\SkyDrive\download\PS1\SP02_BI.ps1 \\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\SP02_BI.ps1 \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1 auther : ming_tseng    a0921887912@gmail.com createDate : Sep.04.2014  lastdate :Aug.29.2015 history :  object :   $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1

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
#>#  08 檢查已安裝之軟件
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
"--------------551-----------17.0 Add-PSSnapin    -----------------------""--------------572-----------17.1 Found SharePoint Server 2013 Binaries. Will create Farm now------------------------""--------------589------------17.2  Installed Help Collection------------------------""--------------602-----------17.3  Initialized SP Resource Security------------------------""--------------607------------17.4 Created Central Administration Site   inetmgr------------------------""--------------717------------17.5 Instaled SPService  ------------------------""--------------827-------------17.6 Installed SP Feature------------------------""--------------847------------17.7 Installed Application Content. This was the last step."
# 863 step 18   restore database &  SSAS cube

# 888 step 19  excel service
"---------- 523 ---------------19.1  建立BI專屬 ApplicaionPool   BIApplicationPool -----------------------"
"-----------  561 -------------19.2  Start the Excel Calculation Services service (SI)  --------------------------------"
"------------- 567 ------------19.3  Create an Excel Services service application(SA)   --------------------------------"

# 1002  step 20  執行 PowerPivot for SharePoint 2013 安裝  ，安裝 SharePoint 模式的 Analysis Services 伺服器 (SSASPT)
"-------------- 640 -----------20.1  安裝 PowerPivot for SharePoint  --------------------------------"

# 1060  step 21  Install or Uninstall the PowerPivot for SharePoint Add-in (SharePoint 2013)
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
    #(11)  1116 部署 WA Solution  & Install-SPSolution to WA  DeployWebAppSolution
    #  1131 (12)建立網站集合 sitecollection &
    #  1164 (13) 啟用 sitecollection Enable feature
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

#   3317  設定 PowerPivot 無人看管的資料重新整理帳戶 (PowerPivot for SharePoint)


#------------------------------------
#    08 檢查已安裝之軟件
#------------------------------------
#
md c:\temp
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
$t1=get-dateGet-Module –ListAvailableGEt-WindowsFeature  RSAT-AD-PowerShell
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
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools$t2=get-date;($t2-$t1)Restart-Computer#------------------------------------
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
New-ADUser infra2 -SamAccountName "infra2"  -GivenName "infra2" -Surname "IT" -DisplayName "infra2" -Path "OU=IT$oupath"
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
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Infra Group'}).DistinguishedName –Member (Get-ADUser -Filter * | ? samaccountname -eq 'infra2').DistinguishedName

Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Infra Group'}).DistinguishedName –Member (Get-ADUser -Filter * | ? samaccountname -eq 'SPAdmin').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Infra Group'}).DistinguishedName –Member (Get-ADUser -Filter * | ? samaccountname -eq 'SPService').DistinguishedName



Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI Leader Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*pm1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*pm2"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI PowerUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*sales1"').DistinguishedName
Add-ADGroupMember (Get-ADGroup -Filter {name -eq 'BI EndUser Group'}).DistinguishedName –Member (Get-ADUser -Filter 'SamAccountName -like "*sales2"').DistinguishedName##  手動設定 Group 是屬於那一個內建群組 ex: BI Infra Group = Enterpsire Administrator ##  ADUser 重設密碼Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)
Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infra2').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)
Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'SPAdmin').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'SPService').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)  Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSDE').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASTR').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASMD').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)  Set-ADAccountPassword (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASPT').DistinguishedName `
 -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)## enable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infra1').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infra2').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'SPAdmin').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'SPService').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSDE').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASTR').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASMD').DistinguishedNameenable-ADAccount (Get-ADUser -Filter * | ? samaccountname -eq 'infraSSASPT').DistinguishedName## Search-ADAccount -AccountDisabled | FT Name,ObjectClass -A##  手動設定 compmgmt.mscdsa.mscAdd  BI Infra Group  to localAdministrator#------------------------------------
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
#------------------------------------create snapshot   "ADReady"make infra1  to DomainAdmins  & local administratorschange user  infra1 login make sure  infra1   local administrators Group whoami  #pmocsd\infra1
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
#------------------------------------# 完整安裝   Microsoft SQL Server Data Tools - Business Intelligence for Visual Studio 2013  http://www.microsoft.com/en-US/download/details.aspx?id=42313  \\172.16.220.33\d$\software2015\SQL2014_ENT_TW_X64\Tools\SSDTBI_ENU  :1094M  unzip  \SSDTBI_x86_ENU# 這版本需要事先安裝Visual Studio   English (United States)	VS 2015 component update ISO - EN    https://msdn.microsoft.com/zh-tw/mt186501    \\192.168.112.144\D$\software2015\SSDT_14.0.50730.0_EN.iso  : 770M# 這版本需要線上安裝 SSDT for VisualStudio 2015   English (United States)	VS 2015 component update ISO - EN    https://msdn.microsoft.com/zh-tw/mt186501    \\192.168.112.144\D$\software2015\SSDTSetupforVS2015onlineInstall.exe  : 640Kshutdown  -r -f devenvssms#------------------------------------
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



  $t1=get-date 
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
        
  $t2=get-date ;($t2-$t1)
        #Oct.7.2015 done
#------------------------------------
# 430  step 14  install SP
#------------------------------------
whoami

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


update  SP1
. D:\software2015\officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe
'
name                                                                       Version                                                                   
----                                                                       -------                                                                   
Microsoft SharePoint Foundation 2013 1028 Lang Pack                        15.0.4571.1502                                                            
Microsoft SharePoint Foundation 2013 1028 SQL Express                      15.0.4571.1502                                                            
Microsoft SharePoint Foundation 2013 Core                                  15.0.4571.1502                                                            
Microsoft SharePoint Multilingual Solutions                                15.0.4571.1502                                                            
Microsoft SharePoint Multilingual Solutions Chinese (Traditional) Langu... 15.0.4571.1502                                                            
Microsoft SharePoint Portal                                                15.0.4571.1502                                                            
Microsoft SharePoint Portal Chinese (Traditional) Language Pack            15.0.4571.1502                                                            
Microsoft SharePoint Server 2013                                           15.0.4571.1502                                                            
PerformancePoint Services for SharePoint                                   15.0.4571.1502                                                            
PerformancePoint Services in SharePoint 1028 Language Pack                 15.0.4571.1502   


'

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
$FarmAccount = "csd\administrator"

$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "csd\infrax",$secpasswd
"--------------572-----------17.1 Found SharePoint Server 2013 Binaries. Will create Farm now------------------------"#rember : run powershell_ise as administratorNew-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer `-FarmCredentials (Get-Credential $farmAccount) -Passphrase $Passphrase `-AdministrationContentDatabaseName $AdminContentDB#Disconnect-SPConfigurationDatabase -Confirm:$false#get-help Disconnect-SPConfigurationDatabase -full#Remove-PSSnapin Microsoft.SharePoint.PowerShell#Add-PSSnapin Microsoft.SharePoint.PowerShell#check 7.1$farm = Get-SPFarm
if (!$farm -or $farm.Status -ne "Online") {
    Write-Output "Farm was not created or is not running"
    exit
}        #Oct.7.2015 done
"-------------589------------17.2  Installed Help Collection------------------------"$t1=get-dateInstall-SPHelpCollection -All$t2=get-date#Get-help Install-SPHelpCollection  -full# get-sphelpcollectionC:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\HCCab\1028\Install-SPHelpCollection Cmdlet 會在目前的伺服器陣列安裝 SharePoint 2010 產品的 Help 網站集合檔案。使用 LiteralPath 參數可安裝特定的自訂 Help 集合檔案。若未指定 LiteralPath 參數，即會安裝 Help 網站集合所有可用的 Help，並覆寫現有的 Help 集合檔案。        #Oct.7.2015 done
"--------------602-----------17.3  Initialized SP Resource Security------------------------"$t1=get-dateInitialize-SPResourceSecurity$t2=get-date ; $t2-$t1        #Oct.7.2015 done
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


#check(get-command *get-SP*).count ;# 190 (pmocsd)(get-command *new-sp*).count#Get-SPServiceApplicationPool<#Name                                     ProcessAccountName                                                                                                                 
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
Disabled 要求管理   (Request Management)                  41589d67-0b85-4882-9d33-f70000a96e42#>$t1=get-datewrite-host -f Yellow "Install-SPService   ... Loading now"Install-SPService$t2=get-date ;($t2-$t1)  #34sec(tempcsd) , 16sec (PMOCSD)write-host -f Green "Install-SPService is now loaded"# get SPServiceInstance 安裝後Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto(Get-SPServiceInstance -Server  $env:COMPUTERNAME ).count<#  count=30, 增加 23 個  使用UI設定.即是 30個PS C:\Windows\system32> Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto

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
Disabled 對 Windows Token 服務的宣告                     8efab8a2-b021-490d-90e0-41af65cecb28#>(gsv |ft -AutoSize).count  #186gsv | ? displayname -Like '*sharepoint*' |ft -AutoSize gsv |ft -AutoSize gsv |? displayname -eq '啟動器服務' |select *gsv |? name -eq 'spworkflowtimerv4' |select *Get-SPServiceInstance |select serviceGet-SPServiceInstance -Identity 51dc6952-dd56-4d3b-9fb5-eb84b34bc264 |select *Get-SPServiceInstance -Identity 664a26df-6f6c-4ae2-9c72-d0276737273a |gm# get SPServiceApplicationGet-SPServiceApplication | ft -AutoSize  # 使用UI 也是2個UI : Application Management > service applications > Manage services on server <#DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
<PMOCSD>
DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application dd30c213-b5ac-4eb1-ac2c-762102e7dccd
#>        #Oct.7.2015 done
"-------------------------------------------------------------------------""------------827-------------17.6 Installed SP Feature------------------------""-------------------------------------------------------------------------"prev-install : ref 528  SPFeature prev  get , install, enable , uninstallget-SPFeature | sort  DisplayName{<#PS C:\Windows\system32> get-SPFeature | sort  DisplayName

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
XmlFormLibrary                 00bfea71-1e1d-4562-b56a-f05371bb0115     15                   Web  #>}$t1=get-datewrite-host -f Yellow "Install-SPFeature   ... Loading now"Install-SPFeature -AllExistingFeatures$t2=get-date ;($t2-$t1)  #  1m 48 Sec(tempCSD)  1m02sec(PMOCSD)write-host -f Green "Install-SPFeature is now loaded"安裝完成之後。由原本　60 個增加為 657個{<#PS SQLSERVER:\> get-SPFeature | sort  DisplayName

DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
AbuseReportsList               c6a92dbf-6441-4b8b-882f-8d97cb12c83a     15                   Web                           
AccessRequests                 a0f12ee4-9b60-4ba4-81f6-75724f4ca973     15                   Web                           
AccSrvApplication              1cc4b32c-299b-41aa-9770-67715ea05f25     15                   Farm                          
AccSrvApplication              1cc4b32c-299b-41aa-9770-67715ea05f25     14                   Farm                          
AccSrvMSysAso                  29ea7495-fca1-4dc6-8ac1-500c247a036e     15                   Web                           
AccSrvMSysAso                  29ea7495-fca1-4dc6-8ac1-500c247a036e     14                   Web                           
AccSrvRestrictedList           a4d4ee2c-a6cb-4191-ab0a-21bb5bde92fb     15                   Web                           
AccSrvRestrictedList           a4d4ee2c-a6cb-4191-ab0a-21bb5bde92fb     14                   Web                           
AccSrvShell                    bcf89eb7-bca1-4468-bdb4-ca27f61a2292     15                   Web                           
AccSrvShell                    bcf89eb7-bca1-4468-bdb4-ca27f61a2292     14                   Web                           
AccSrvSolutionGallery          744b5fd3-3b09-4da6-9bd1-de18315b045d     14                   Site                          
AccSrvSolutionGallery          744b5fd3-3b09-4da6-9bd1-de18315b045d     15                   Site                          
AccSrvSolutionGalleryStapler   d5ff2d2c-8571-4c3c-87bc-779111979811     14                   Farm                          
AccSrvSolutionGalleryStapler   d5ff2d2c-8571-4c3c-87bc-779111979811     15                   Farm                          
AccSrvUserTemplate             1a8251a0-47ab-453d-95d4-07d7ca4f8166     14                   Web                           
AccSrvUserTemplate             1a8251a0-47ab-453d-95d4-07d7ca4f8166     15                   Web                           
AccSrvUSysAppLog               28101b19-b896-44f4-9264-db028f307a62     15                   Web                           
AccSrvUSysAppLog               28101b19-b896-44f4-9264-db028f307a62     14                   Web                           
AccSvcAddAccessApp             d2b9ec23-526b-42c5-87b6-852bd83e0364     15                   Web                           
AccSvcAddAccessAppStapling     3d7415e4-61ba-4669-8d78-213d374d9825     15                   Farm                          
AccSvcApplication              5094e988-524b-446c-b2f6-040b5be46297     15                   Farm                          
AccSvcShell                    7ffd6d57-4b10-4edb-ac26-c2cfbf8173ab     15                   Web                           
AddDashboard                   d250636f-0a26-4019-8425-a5232d592c09     15                   Web                           
AddDashboard                   d250636f-0a26-4019-8425-a5232d592c09     14                   Web                           
AdminLinks                     fead7313-ae6d-45dd-8260-13b563cb4c71     15                   Web                           
AdminLinks                     fead7313-ae6d-45dd-8260-13b563cb4c71     14                   Web                           
AdminReportCore                b8f36433-367d-49f3-ae11-f7d76b51d251     14                   Site                          
AdminReportCore                b8f36433-367d-49f3-ae11-f7d76b51d251     15                   Site                          
AdminReportCorePushdown        55312854-855b-4088-b09d-c5efe0fbf9d2     15                   Farm                          
AdminReportCorePushdown        55312854-855b-4088-b09d-c5efe0fbf9d2     14                   Farm                          
AnnouncementsList              00bfea71-d1ce-42de-9c63-a44004ce0104     15                   Web                           
AnnouncementsList              00bfea71-d1ce-42de-9c63-a44004ce0104     14                   Web                           
AppLockdown                    23330bdb-b83e-4e09-8770-8155aa5e87fd     15                   Web                           
AppRegistration                fdc6383e-3f1d-4599-8b7c-c515e99cbf18     15                   Site                          
AppRequestsList                334dfc83-8655-48a1-b79d-68b7f6c63222     15                   Web                           
AssetLibrary                   4bcccd62-dcaf-46dc-a7d4-e38277ef33f4     14                   Site                          
AssetLibrary                   4bcccd62-dcaf-46dc-a7d4-e38277ef33f4     15                   Site                          
AutohostedAppLicensing         fa7cefd8-5595-4d68-84fa-fe2d9e693de7     15                   Site                          
AutohostedAppLicensingStapling 013a0db9-1607-4c42-8f71-08d821d395c2     15                   Farm                          
BaseSite                       b21b090c-c796-4b0f-ac0f-7ef1659c20ae     14                   Site                          
BaseSite                       b21b090c-c796-4b0f-ac0f-7ef1659c20ae     15                   Site                          
BaseSiteStapling               97a2485f-ef4b-401f-9167-fa4fe177c6f6     14                   Farm                          
BaseSiteStapling               97a2485f-ef4b-401f-9167-fa4fe177c6f6     15                   Farm                          
BaseWeb                        99fe402e-89a0-45aa-9163-85342e865dc8     15                   Web                           
BaseWeb                        99fe402e-89a0-45aa-9163-85342e865dc8     14                   Web                           
BaseWebApplication             4f56f9fa-51a0-420c-b707-63ecbb494db1     15                   WebApplication                
BaseWebApplication             4f56f9fa-51a0-420c-b707-63ecbb494db1     14                   WebApplication                
BasicWebParts                  00bfea71-1c5e-4a24-b310-ba51c3eb7a57     14                   Site                          
BasicWebParts                  00bfea71-1c5e-4a24-b310-ba51c3eb7a57     15                   Site                          
BcsEvents                      60c8481d-4b54-4853-ab9f-ed7e1c21d7e4     15                   Web                           
BDR                            3f59333f-4ce1-406d-8a97-9ecb0ff0337f     15                   Web                           
BDR                            3f59333f-4ce1-406d-8a97-9ecb0ff0337f     14                   Web                           
BICenterDashboardsLib          f979e4dc-1852-4f26-ab92-d1b2a190afc9     15                   Web                           
BICenterDashboardsLib          f979e4dc-1852-4f26-ab92-d1b2a190afc9     14                   Web                           
BICenterDataConnections        3d8210e9-1e89-4f12-98ef-643995339ed4     15                   Web                           
BICenterDataconnectionsLib     26676156-91a0-49f7-87aa-37b1d5f0c4d0     15                   Web                           
BICenterDataconnectionsLib     26676156-91a0-49f7-87aa-37b1d5f0c4d0     14                   Web                           
BICenterDataConnectionsList... a64c4402-7037-4476-a290-84cfd56ca01d     15                   Web                           
BICenterFeatureStapler         3a027b18-36e4-4005-9473-dd73e6756a73     15                   WebApplication                
BICenterPPSContentPages        a354e6b3-6015-4744-bdc2-2fc1e4769e65     15                   Web                           
BICenterPPSNavigationLink      faf31b50-880a-4e4f-a21b-597f6b4d6478     15                   Web                           
BICenterPPSWorkspaceListIns... f9c216ad-35c7-4538-abb8-8ec631a5dff7     15                   Web                           
BICenterSampleData             3992d4ab-fa9e-4791-9158-5ee32178e88a     15                   Web                           
BICenterSampleData             3992d4ab-fa9e-4791-9158-5ee32178e88a     14                   Web                           
BizAppsCTypes                  43f41342-1a37-4372-8ca0-b44d881e4434     14                   Site                          
BizAppsCTypes                  43f41342-1a37-4372-8ca0-b44d881e4434     15                   Site                          
BizAppsFields                  5a979115-6b71-45a5-9881-cdc872051a69     15                   Site                          
BizAppsFields                  5a979115-6b71-45a5-9881-cdc872051a69     14                   Site                          
BizAppsListTemplates           065c78be-5231-477e-a972-14177cc5b3c7     15                   Web                           
BizAppsListTemplates           065c78be-5231-477e-a972-14177cc5b3c7     14                   Web                           
BizAppsSiteTemplates           4248e21f-a816-4c88-8cab-79d82201da7b     15                   Site                          
BizAppsSiteTemplates           4248e21f-a816-4c88-8cab-79d82201da7b     14                   Site                          
BlogContent                    0d1c50f7-0309-431c-adfb-b777d5473a65     15                   Web                           
BlogHomePage                   e4639bb7-6e95-4e2f-b562-03b832dd4793     15                   Web                           
BlogSiteTemplate               faf00902-6bab-4583-bd02-84db191801d8     15                   Web                           
BulkWorkflow                   aeef8777-70c0-429f-8a13-f12db47a6d47     15                   Farm                          
BulkWorkflow                   aeef8777-70c0-429f-8a13-f12db47a6d47     14                   Farm                          
BulkWorkflowTimerJob           d992aeca-3802-483a-ab40-6c9376300b61     15                   WebApplication                
BulkWorkflowTimerJob           d992aeca-3802-483a-ab40-6c9376300b61     14                   WebApplication                
CallTrackList                  239650e3-ee0b-44a0-a22a-48292402b8d8     14                   Web                           
CallTrackList                  239650e3-ee0b-44a0-a22a-48292402b8d8     15                   Web                           
CategoriesList                 d32700c7-9ec5-45e6-9c89-ea703efca1df     15                   Web                           
CirculationList                a568770a-50ba-4052-ab48-37d8029b3f47     15                   Web                           
CirculationList                a568770a-50ba-4052-ab48-37d8029b3f47     14                   Web                           
CmisProducer                   1fce0577-1f58-4fc2-a996-6c4bcf59eeed     15                   Web                           
CollaborationMailbox           502a2d54-6102-4757-aaa0-a90586106368     15                   Web                           
CollaborationMailboxFarm       3a11d8ef-641e-4c79-b4d9-be3b17f9607c     15                   Farm                          
CommunityPortal                2b03956c-9271-4d1c-868a-07df2971ed30     15                   Site                          
CommunitySite                  961d6a9c-4388-4cf2-9733-38ee8c89afd4     15                   Web                           
ContactsList                   00bfea71-7e6d-4186-9ba8-c047ac750105     14                   Web                           
ContactsList                   00bfea71-7e6d-4186-9ba8-c047ac750105     15                   Web                           
ContentDeploymentSource        cd1a49b0-c067-4fdd-adfe-69e6f5022c1a     15                   Site                          
ContentFollowing               7890e045-6c96-48d8-96e7-6a1d63737d71     15                   Site                          
ContentFollowingList           a34e5458-8d20-4c0d-b137-e1390f5824a1     15                   Site                          
ContentFollowingStapling       e1580c3c-c510-453b-be15-35feb0ddb1a5     15                   Farm                          
ContentLightup                 0f121a23-c6bc-400f-87e4-e6bbddf6916d     15                   Farm                          
ContentLightup                 0f121a23-c6bc-400f-87e4-e6bbddf6916d     14                   Farm                          
ContentTypeHub                 9a447926-5937-44cb-857a-d3829301c73b     14                   Site                          
ContentTypeHub                 9a447926-5937-44cb-857a-d3829301c73b     15                   Site                          
ContentTypePublish             dd903064-c9d8-4718-b4e7-8ab9bd039fff     15                   Web                           
ContentTypePublish             dd903064-c9d8-4718-b4e7-8ab9bd039fff     14                   Web                           
ContentTypeSettings            fead7313-4b9e-4632-80a2-ff00a2d83297     15                   Farm                          
ContentTypeSettings            fead7313-4b9e-4632-80a2-ff00a2d83297     14                   Farm                          
ContentTypeSyndication         34339dc9-dec4-4256-b44a-b30ff2991a64     15                   WebApplication                
ContentTypeSyndication         34339dc9-dec4-4256-b44a-b30ff2991a64     14                   WebApplication                
CorporateCatalog               0ac11793-9c2f-4cac-8f22-33f93fac18f2     15                   Web                           
CorporateCuratedGallerySett... f8bea737-255e-4758-ab82-e34bb46f5828     15                   WebApplication                
CrossFarmSitePermissions       a5aedf1a-12e5-46b4-8348-544386d5312d     15                   Site                          
CrossSiteCollectionPublishing  151d22d9-95a8-4904-a0a3-22e4db85d1e0     15                   Site                          
CTypes                         695b6570-a48b-4a8e-8ea5-26ea7fc1d162     15                   Site                          
ctypes                         695b6570-a48b-4a8e-8ea5-26ea7fc1d162     14                   Site                          
CustomList                     00bfea71-de22-43b2-a848-c05709900100     14                   Web                           
CustomList                     00bfea71-de22-43b2-a848-c05709900100     15                   Web                           
DataConnectionLibrary          00bfea71-dbd7-4f72-b8cb-da7ac0440130     14                   Web                           
DataConnectionLibrary          00bfea71-dbd7-4f72-b8cb-da7ac0440130     15                   Web                           
DataConnectionLibraryStapling  cdfa39c6-6413-4508-bccf-bf30368472b3     14                   Farm                          
DataConnectionLibraryStapling  cdfa39c6-6413-4508-bccf-bf30368472b3     15                   Farm                          
DataSourceLibrary              00bfea71-f381-423d-b9d1-da7a54c50110     14                   Web                           
DataSourceLibrary              00bfea71-f381-423d-b9d1-da7a54c50110     15                   Web                           
DeploymentLinks                ca2543e6-29a1-40c1-bba9-bd8510a4c17b     15                   Web                           
DeploymentLinks                ca2543e6-29a1-40c1-bba9-bd8510a4c17b     14                   Web                           
Developer                      e374875e-06b6-11e0-b0fa-57f5dfd72085     15                   Site                          
DiscussionsList                00bfea71-6a49-43fa-b535-d15c05500108     15                   Web                           
DiscussionsList                00bfea71-6a49-43fa-b535-d15c05500108     14                   Web                           
DMContentTypeSettings          1ec2c859-e9cb-4d79-9b2b-ea8df09ede22     15                   Farm                          
DMContentTypeSettings          1ec2c859-e9cb-4d79-9b2b-ea8df09ede22     14                   Farm                          
DocId                          b50e3104-6812-424f-a011-cc90e6327318     15                   Site                          
DocId                          b50e3104-6812-424f-a011-cc90e6327318     14                   Site                          
docmarketplace                 184c82e7-7eb1-4384-8e8c-62720ef397a0     15                   Web                           
docmarketplacesafecontrols     5690f1a0-22b6-4262-b1c2-74f505bc0670     15                   WebApplication                
docmarketplacesampledata       1dfd85c5-feff-489f-a71f-9322f8b13902     15                   Web                           
DocumentLibrary                00bfea71-e717-4e80-aa17-d0c71b360101     15                   Web                           
DocumentLibrary                00bfea71-e717-4e80-aa17-d0c71b360101     14                   Web                           
DocumentManagement             3a4ce811-6fe0-4e97-a6ae-675470282cf2     15                   WebApplication                
DocumentManagement             3a4ce811-6fe0-4e97-a6ae-675470282cf2     14                   WebApplication                
DocumentRouting                7ad5272a-2694-4349-953e-ea5ef290e97c     15                   Web                           
DocumentRouting                7ad5272a-2694-4349-953e-ea5ef290e97c     14                   Web                           
DocumentRoutingResources       0c8a9a47-22a9-4798-82f1-00e62a96006e     15                   Site                          
DocumentRoutingResources       0c8a9a47-22a9-4798-82f1-00e62a96006e     14                   Site                          
DocumentSet                    3bae86a2-776d-499d-9db8-fa4cdc7884f8     15                   Site                          
DocumentSet                    3bae86a2-776d-499d-9db8-fa4cdc7884f8     14                   Site                          
DownloadFromOfficeDotCom       a140a1ac-e757-465d-94d4-2ca25ab2c662     14                   Farm                          
DownloadFromOfficeDotCom       a140a1ac-e757-465d-94d4-2ca25ab2c662     15                   Farm                          
EawfSite                       142ae5f3-6796-45c5-b31d-2e62e8868b53     15                   Site                          
EawfSite                       142ae5f3-6796-45c5-b31d-2e62e8868b53     14                   Site                          
EawfWeb                        1ba1b299-716c-4ee1-9c23-e8bbab3c812a     15                   Web                           
EawfWeb                        1ba1b299-716c-4ee1-9c23-e8bbab3c812a     14                   Web                           
EDiscoveryCaseResources        e8c02a2a-9010-4f98-af88-6668d59f91a7     15                   Web                           
EDiscoveryConsole              250042b9-1aad-4b56-a8a6-69d9fe1c8c2c     15                   Site                          
EduAdminLinks                  03509cfb-8b2f-4f46-a4c9-8316d1e62a4b     15                   Web                           
EduAdminPages                  c1b78fe6-9110-42e8-87cb-5bd1c8ab278a     15                   Site                          
EduCommunity                   bf76fc2c-e6c9-11df-b52f-cb00e0d72085     15                   Web                           
EduCommunityCustomSiteActions  739ec067-2b57-463e-a986-354be77bb828     15                   Site                          
EduCommunitySite               2e030413-c4ff-41a4-8ee0-f6688950b34a     15                   Site                          
EduCourseCommunity             a16e895c-e61a-11df-8f6e-103edfd72085     15                   Web                           
EduCourseCommunitySite         824a259f-2cce-4006-96cd-20c806ee9cfd     15                   Site                          
EduDashboard                   5025492c-dae2-4c00-8f34-cd08f7c7c294     15                   Web                           
EduFarmWebApplication          cb869762-c694-439e-8d05-cf5ca066f271     15                   Farm                          
EduInstitutionAdmin            41bfb21c-0447-4c97-bc62-0b07bec262a1     15                   Site                          
EduInstitutionSiteCollection   978513c0-1e6c-4efb-b12e-7698963bfd05     15                   Web                           
EduMembershipUI                bd012a1f-c69b-4a13-b6a4-f8bc3e59760e     15                   Web                           
EduMySiteCommunity             abf1a85c-e91a-11df-bf2e-f7acdfd72085     15                   Web                           
EduMySiteHost                  932f5bb1-e815-4c14-8917-c2bae32f70fe     15                   Web                           
EduSearchDisplayTemplates      8d75610e-5ff9-4cd1-aefc-8b926f2af771     15                   Site                          
EduShared                      08585e12-4762-4cc9-842a-a8d7b074bdb7     15                   Site                          
EduStudyGroupCommunity         a46935c3-545f-4c15-a2fd-3a19b62d8a02     15                   Web                           
EduUserCache                   7f52c29e-736d-11e0-80b8-9edd4724019b     15                   Web                           
EduWebApplication              7de489aa-2e4a-46ff-88f0-d1b5a9d43709     15                   WebApplication                
EMailRouting                   d44a1358-e800-47e8-8180-adf2d0f77543     14                   Web                           
EMailRouting                   d44a1358-e800-47e8-8180-adf2d0f77543     15                   Web                           
EmailTemplates                 397942ec-14bf-490e-a983-95b87d0d29d1     15                   WebApplication                
EmailTemplates                 397942ec-14bf-490e-a983-95b87d0d29d1     14                   WebApplication                
EnableAppSideLoading           ae3a1339-61f5-4f8f-81a7-abd2da956a7d     15                   Site                          
EnhancedHtmlEditing            81ebc0d6-8fb2-4e3f-b2f8-062640037398     14                   Farm                          
EnhancedHtmlEditing            81ebc0d6-8fb2-4e3f-b2f8-062640037398     15                   Farm                          
EnhancedTheming                068bc832-4951-11dc-8314-0800200c9a66     14                   Site                          
EnhancedTheming                068bc832-4951-11dc-8314-0800200c9a66     15                   Site                          
EnterpriseWiki                 76d688ad-c16e-4cec-9b71-7b7f0d79b9cd     15                   Web                           
EnterpriseWiki                 76d688ad-c16e-4cec-9b71-7b7f0d79b9cd     14                   Web                           
EnterpriseWikiLayouts          a942a218-fa43-4d11-9d85-c01e3e3a37cb     15                   Site                          
EnterpriseWikiLayouts          a942a218-fa43-4d11-9d85-c01e3e3a37cb     14                   Site                          
EventsList                     00bfea71-ec85-4903-972d-ebe475780106     14                   Web                           
EventsList                     00bfea71-ec85-4903-972d-ebe475780106     15                   Web                           
ExcelServer                    e4e6a041-bc5b-45cb-beab-885a27079f74     14                   Farm                          
ExcelServer                    e4e6a041-bc5b-45cb-beab-885a27079f74     15                   Farm                          
ExcelServerEdit                b3da33d0-5e51-4694-99ce-705a3ac80dc5     14                   Site                          
ExcelServerEdit                b3da33d0-5e51-4694-99ce-705a3ac80dc5     15                   Site                          
ExcelServerSite                3cb475e7-4e87-45eb-a1f3-db96ad7cf313     15                   Site                          
ExcelServerSite                3cb475e7-4e87-45eb-a1f3-db96ad7cf313     14                   Site                          
ExcelServerWebPart             4c42ab64-55af-4c7c-986a-ac216a6e0c0e     15                   Site                          
ExcelServerWebPart             4c42ab64-55af-4c7c-986a-ac216a6e0c0e     14                   Site                          
ExcelServerWebPartStapler      c6ac73de-1936-47a4-bdff-19a6fc3ba490     14                   Farm                          
ExcelServerWebPartStapler      c6ac73de-1936-47a4-bdff-19a6fc3ba490     15                   Farm                          
ExchangeSync                   5f68444a-0131-4bb0-b013-454d925681a2     15                   Farm                          
ExchangeSyncSiteSubscription   7cd95467-1777-4b6b-903e-89e253edc1f7     15                   Web                           
ExpirationWorkflow             c85e5759-f323-4efb-b548-443d2216efb5     15                   Site                          
ExpirationWorkflow             c85e5759-f323-4efb-b548-443d2216efb5     14                   Site                          
ExternalList                   00bfea71-9549-43f8-b978-e47e54a10600     15                   Web                           
ExternalList                   00bfea71-9549-43f8-b978-e47e54a10600     14                   Web                           
ExternalSubscription           5b10d113-2d0d-43bd-a2fd-f8bc879f5abd     15                   Web                           
FacilityList                   58160a6b-4396-4d6e-867c-65381fb5fbc9     14                   Web                           
FacilityList                   58160a6b-4396-4d6e-867c-65381fb5fbc9     15                   Web                           
FastCentralAdminHelpCollection 38969baa-3590-4635-81a4-2049d982adfa     15                   Site                          
FastCentralAdminHelpCollection 38969baa-3590-4635-81a4-2049d982adfa     14                   Site                          
FastEndUserHelpCollection      6e8f2b8d-d765-4e69-84ea-5702574c11d6     15                   Site                          
FastEndUserHelpCollection      6e8f2b8d-d765-4e69-84ea-5702574c11d6     14                   Site                          
FastFarmFeatureActivation      d2d98dc8-c7e9-46ec-80a5-b38f039c16be     14                   Farm                          
FCGroupsList                   08386d3d-7cc0-486b-a730-3b4cfe1b5509     15                   Web                           
FCGroupsList                   08386d3d-7cc0-486b-a730-3b4cfe1b5509     14                   Web                           
FeaturePushdown                0125140f-7123-4657-b70a-db9aa1f209e5     15                   Farm                          
FeaturePushdown                0125140f-7123-4657-b70a-db9aa1f209e5     14                   Farm                          
Fields                         ca7bd552-10b1-4563-85b9-5ed1d39c962a     15                   Site                          
fields                         ca7bd552-10b1-4563-85b9-5ed1d39c962a     14                   Site                          
FollowingContent               a7a2793e-67cd-4dc1-9fd0-43f61581207a     15                   Web                           
GanttTasksList                 00bfea71-513d-4ca0-96c2-6a47775c0119     15                   Web                           
GanttTasksList                 00bfea71-513d-4ca0-96c2-6a47775c0119     14                   Web                           
GBWProvision                   6e8a2add-ed09-4592-978e-8fa71e6f117c     15                   Web                           
GBWProvision                   6e8a2add-ed09-4592-978e-8fa71e6f117c     14                   Web                           
GBWWebParts                    3d25bd73-7cd4-4425-b8fb-8899977f73de     14                   Web                           
GBWWebParts                    3d25bd73-7cd4-4425-b8fb-8899977f73de     15                   Web                           
GettingStarted                 4aec7207-0d02-4f4f-aa07-b370199cd0c7     15                   Web                           
GettingStartedWithAppCatalo... 4ddc5942-98b0-4d70-9f7f-17acfec010e5     15                   Web                           
GlobalWebParts                 319d8f70-eb3a-4b44-9c79-2087a87799d6     14                   Farm                          
GlobalWebParts                 319d8f70-eb3a-4b44-9c79-2087a87799d6     15                   Farm                          
GridList                       00bfea71-3a1d-41d3-a0ee-651d11570120     15                   Web                           
GridList                       00bfea71-3a1d-41d3-a0ee-651d11570120     14                   Web                           
GroupWork                      9c03e124-eef7-4dc6-b5eb-86ccd207cb87     15                   Web                           
GroupWork                      9c03e124-eef7-4dc6-b5eb-86ccd207cb87     14                   Web                           
HelpLibrary                    071de60d-4b02-4076-b001-b456e93146fe     15                   Site                          
HelpLibrary                    071de60d-4b02-4076-b001-b456e93146fe     14                   Site                          
HierarchyTasksList             f9ce21f8-f437-4f7e-8bc6-946378c850f0     15                   Web                           
Hold                           9e56487c-795a-4077-9425-54a1ecb84282     15                   Web                           
Hold                           9e56487c-795a-4077-9425-54a1ecb84282     14                   Web                           
HolidaysList                   9ad4c2d4-443b-4a94-8534-49a23f20ba3c     14                   Web                           
HolidaysList                   9ad4c2d4-443b-4a94-8534-49a23f20ba3c     15                   Web                           
HtmlDesign                     a4c654e4-a8da-4db3-897c-a386048f7157     15                   Site                          
IfeDependentApps               7877bbf6-30f5-4f58-99d9-a0cc787c1300     15                   WebApplication                
IMEDicList                     1c6a572c-1b58-49ab-b5db-75caf50692e6     15                   Web                           
IMEDicList                     1c6a572c-1b58-49ab-b5db-75caf50692e6     14                   Web                           
InPlaceRecords                 da2e115b-07e4-49d9-bb2c-35e93bb9fca9     14                   Site                          
InPlaceRecords                 da2e115b-07e4-49d9-bb2c-35e93bb9fca9     15                   Site                          
ipfsAdminLinks                 a10b6aa4-135d-4598-88d1-8d4ff5691d13     14                   Farm                          
ipfsAdminLinks                 a10b6aa4-135d-4598-88d1-8d4ff5691d13     15                   Farm                          
IPFSAdminWeb                   750b8e49-5213-4816-9fa2-082900c0201a     14                   Web                           
IPFSAdminWeb                   750b8e49-5213-4816-9fa2-082900c0201a     15                   Web                           
IPFSSiteFeatures               c88c4ff1-dbf5-4649-ad9f-c6c426ebcbf5     15                   Site                          
IPFSSiteFeatures               c88c4ff1-dbf5-4649-ad9f-c6c426ebcbf5     14                   Site                          
IPFSTenantFormsConfig          15845762-4ec4-4606-8993-1c0512a98680     15                   Web                           
IPFSTenantFormsConfig          15845762-4ec4-4606-8993-1c0512a98680     14                   Web                           
IPFSTenantWebProxyConfig       3c577815-7658-4d4f-a347-cfbb370700a7     14                   Web                           
IPFSTenantWebProxyConfig       3c577815-7658-4d4f-a347-cfbb370700a7     15                   Web                           
IPFSWebFeatures                a0e5a010-1329-49d4-9e09-f280cdbed37d     14                   Web                           
IPFSWebFeatures                a0e5a010-1329-49d4-9e09-f280cdbed37d     15                   Web                           
IssuesList                     00bfea71-5932-4f9c-ad71-1557e5751100     14                   Web                           
IssuesList                     00bfea71-5932-4f9c-ad71-1557e5751100     15                   Web                           
IssueTrackingWorkflow          fde5d850-671e-4143-950a-87b473922dc7     14                   Site                          
IssueTrackingWorkflow          fde5d850-671e-4143-950a-87b473922dc7     15                   Site                          
ItemFormRecommendations        39d18bbf-6e0f-4321-8f16-4e3b51212393     15                   Site                          
LegacyDocumentLibrary          6e53dd27-98f2-4ae5-85a0-e9a8ef4aa6df     15                   Web                           
LegacyDocumentLibrary          6e53dd27-98f2-4ae5-85a0-e9a8ef4aa6df     14                   Web                           
LegacyWorkflows                c845ed8d-9ce5-448c-bd3e-ea71350ce45b     15                   Site                          
LegacyWorkflows                c845ed8d-9ce5-448c-bd3e-ea71350ce45b     14                   Site                          
LinksList                      00bfea71-2062-426c-90bf-714c59600103     14                   Web                           
LinksList                      00bfea71-2062-426c-90bf-714c59600103     15                   Web                           
ListTargeting                  fc33ba3b-7919-4d7e-b791-c6aeccf8f851     15                   Farm                          
ListTargeting                  fc33ba3b-7919-4d7e-b791-c6aeccf8f851     14                   Farm                          
LocalSiteDirectoryControl      14aafd3a-fcb9-4bb7-9ad7-d8e36b663bbd     15                   Site                          
LocalSiteDirectoryControl      14aafd3a-fcb9-4bb7-9ad7-d8e36b663bbd     14                   Site                          
LocalSiteDirectoryMetaData     8f15b342-80b1-4508-8641-0751e2b55ca6     14                   Web                           
LocalSiteDirectoryMetaData     8f15b342-80b1-4508-8641-0751e2b55ca6     15                   Web                           
LocalSiteDirectorySettingsLink e978b1a6-8de7-49d0-8600-09a250354e14     15                   Site                          
LocalSiteDirectorySettingsLink e978b1a6-8de7-49d0-8600-09a250354e14     14                   Site                          
LocationBasedPolicy            063c26fa-3ccc-4180-8a84-b6f98e991df3     14                   Site                          
LocationBasedPolicy            063c26fa-3ccc-4180-8a84-b6f98e991df3     15                   Site                          
MaintenanceLogs                8c6f9096-388d-4eed-96ff-698b3ec46fc4     14                   Web                           
MaintenanceLogs                8c6f9096-388d-4eed-96ff-698b3ec46fc4     15                   Web                           
ManageUserProfileServiceApp... c59dbaa9-fa01-495d-aaa3-3c02cc2ee8ff     14                   Farm                          
ManageUserProfileServiceApp... c59dbaa9-fa01-495d-aaa3-3c02cc2ee8ff     15                   Farm                          
MasterSiteDirectoryControl     8a663fe0-9d9c-45c7-8297-66365ad50427     14                   Farm                          
MasterSiteDirectoryControl     8a663fe0-9d9c-45c7-8297-66365ad50427     15                   Farm                          
MBrowserRedirect               d95c97f3-e528-4da2-ae9f-32b3535fbb59     15                   Web                           
MBrowserRedirectStapling       2dd8788b-0e6b-4893-b4c0-73523ac261b1     15                   Farm                          
MDSFeature                     87294c72-f260-42f3-a41b-981a2ffce37a     15                   Web                           
MediaWebPart                   5b79b49a-2da6-4161-95bd-7375c1995ef9     15                   Site                          
MembershipList                 947afd14-0ea1-46c6-be97-dea1bf6f5bae     15                   Web                           
MetaDataNav                    7201d6a4-a5d3-49a1-8c19-19c4bac6e668     14                   Web                           
MetaDataNav                    7201d6a4-a5d3-49a1-8c19-19c4bac6e668     15                   Web                           
MobileEwaFarm                  5a020a4f-c449-4a65-b07d-f2cc2d8778dd     14                   Farm                          
MobileEwaFarm                  5a020a4f-c449-4a65-b07d-f2cc2d8778dd     15                   Farm                          
MobileExcelWebAccess           e995e28b-9ba8-4668-9933-cf5c146d7a9f     14                   Site                          
MobileExcelWebAccess           e995e28b-9ba8-4668-9933-cf5c146d7a9f     15                   Site                          
MobilityRedirect               f41cc668-37e5-4743-b4a8-74d1db3fd8a4     15                   Web                           
MobilityRedirect               f41cc668-37e5-4743-b4a8-74d1db3fd8a4     14                   Web                           
MonitoredApps                  345ff4f9-f706-41e1-92bc-3f0ec2d9f6ea     15                   Site                          
MonitoredAppsUI                1b811cfe-8c78-4982-aad7-e5c112e397d1     15                   Farm                          
MossChart                      875d1044-c0cf-4244-8865-d2a0039c2a49     14                   Site                          
MossChart                      875d1044-c0cf-4244-8865-d2a0039c2a49     15                   Site                          
MpsWebParts                    39dd29fb-b6f5-4697-b526-4d38de4893e5     14                   Web                           
MpsWebParts                    39dd29fb-b6f5-4697-b526-4d38de4893e5     15                   Web                           
MruDocsWebPart                 1eb6a0c1-5f08-4672-b96f-16845c2448c6     15                   Web                           
MySite                         69cc9662-d373-47fc-9449-f18d11ff732c     15                   Farm                          
MySite                         69cc9662-d373-47fc-9449-f18d11ff732c     14                   Farm                          
MySiteBlog                     863da2ac-3873-4930-8498-752886210911     14                   Site                          
MySiteBlog                     863da2ac-3873-4930-8498-752886210911     15                   Site                          
MySiteCleanup                  0faf7d1b-95b1-4053-b4e2-19fd5c9bbc88     15                   Farm                          
MySiteCleanup                  0faf7d1b-95b1-4053-b4e2-19fd5c9bbc88     14                   Farm                          
MySiteDocumentLibrary          e9c0ff81-d821-4771-8b4c-246aa7e5e9eb     15                   Site                          
MySiteHost                     49571cd1-b6a1-43a3-bf75-955acc79c8d8     14                   Site                          
MySiteHost                     49571cd1-b6a1-43a3-bf75-955acc79c8d8     15                   Site                          
MySiteHostPictureLibrary       5ede0a86-c772-4f1d-a120-72e734b3400c     14                   Web                           
MySiteHostPictureLibrary       5ede0a86-c772-4f1d-a120-72e734b3400c     15                   Web                           
MySiteInstantiationQueues      65b53aaf-4754-46d7-bb5b-7ed4cf5564e1     15                   WebApplication                
MySiteLayouts                  6928b0e5-5707-46a1-ae16-d6e52522d52b     15                   Site                          
MySiteLayouts                  6928b0e5-5707-46a1-ae16-d6e52522d52b     14                   Site                          
MySiteMaster                   fb01ca75-b306-4fc2-ab27-b4814bf823d1     15                   Site                          
MySiteMicroBlog                ea23650b-0340-4708-b465-441a41c37af7     15                   Web                           
MySiteMicroBlogCtrl            dfa42479-9531-4baf-8873-fc65b22c9bd4     15                   Site                          
MySiteNavigation               6adff05c-d581-4c05-a6b9-920f15ec6fd9     14                   Web                           
MySiteNavigation               6adff05c-d581-4c05-a6b9-920f15ec6fd9     15                   Web                           
MySitePersonalSite             f661430e-c155-438e-a7c6-c68648f1b119     15                   Site                          
MySitePersonalSite             f661430e-c155-438e-a7c6-c68648f1b119     14                   Site                          
MySiteQuickLaunch              034947cc-c424-47cd-a8d1-6014f0e36925     14                   Web                           
MySiteQuickLaunch              034947cc-c424-47cd-a8d1-6014f0e36925     15                   Web                           
MySiteSocialDeployment         b2741073-a92b-4836-b1d8-d5e9d73679bb     15                   Site                          
MySiteStorageDeployment        0ee1129f-a2f3-41a9-9e9c-c7ee619a8c33     15                   Site                          
MySiteUnifiedNavigation        41baa678-ad62-41ef-87e6-62c8917fc0ad     15                   Web                           
MySiteUnifiedQuickLaunch       eaa41f18-8e4a-4894-baee-60a87f026e42     15                   Site                          
MyTasksDashboard               89d1184c-8191-4303-a430-7a24291531c9     15                   Web                           
MyTasksDashboardCustomRedirect 04a98ac6-82d5-4e01-80ea-c0b7d9699d94     15                   Farm                          
MyTasksDashboardStapling       4cc8aab8-5af0-45d7-a170-169ea583866e     15                   Farm                          
Navigation                     89e0306d-453b-4ec5-8d68-42067cdbf98e     14                   Site                          
Navigation                     89e0306d-453b-4ec5-8d68-42067cdbf98e     15                   Site                          
NavigationProperties           541f5f57-c847-4e16-b59a-b31e90e6f9ea     14                   Web                           
NavigationProperties           541f5f57-c847-4e16-b59a-b31e90e6f9ea     15                   Web                           
NoCodeWorkflowLibrary          00bfea71-f600-43f6-a895-40c0de7b0117     14                   Web                           
NoCodeWorkflowLibrary          00bfea71-f600-43f6-a895-40c0de7b0117     15                   Web                           
ObaProfilePages                683df0c0-20b7-4852-87a3-378945158fab     14                   Web                           
ObaProfilePages                683df0c0-20b7-4852-87a3-378945158fab     15                   Web                           
ObaProfilePagesTenantStapling  90c6c1e5-3719-4c52-9f36-34a97df596f7     14                   Farm                          
ObaProfilePagesTenantStapling  90c6c1e5-3719-4c52-9f36-34a97df596f7     15                   Farm                          
ObaSimpleSolution              d250636f-0a26-4019-8425-a5232d592c01     15                   Web                           
ObaSimpleSolution              d250636f-0a26-4019-8425-a5232d592c01     14                   Web                           
ObaStaple                      f9cb1a2a-d285-465a-a160-7e3e95af1fdd     15                   Farm                          
ObaStaple                      f9cb1a2a-d285-465a-a160-7e3e95af1fdd     14                   Farm                          
OfficeExtensionCatalog         61e874cd-3ac3-4531-8628-28c3acb78279     15                   Web                           
OfficeWebApps                  0c504a5c-bcea-4376-b05e-cbca5ced7b4f     14                   Site                          
OfficeWebApps                  0c504a5c-bcea-4376-b05e-cbca5ced7b4f     15                   Site                          
OffWFCommon                    c9c9515d-e4e2-4001-9050-74f980f93160     14                   Site                          
OffWFCommon                    c9c9515d-e4e2-4001-9050-74f980f93160     15                   Site                          
OnenoteServerViewing           3d433d02-cf49-4975-81b4-aede31e16edf     14                   Site                          
OnenoteServerViewing           3d433d02-cf49-4975-81b4-aede31e16edf     15                   Site                          
OpenInClient                   8a4b8de2-6fd8-41e9-923c-c7c3c00f8295     14                   Site                          
OpenInClient                   8a4b8de2-6fd8-41e9-923c-c7c3c00f8295     15                   Site                          
OrganizationsClaimHierarchy... 9b0293a7-8942-46b0-8b78-49d29a9edd53     14                   Farm                          
OrganizationsClaimHierarchy... 9b0293a7-8942-46b0-8b78-49d29a9edd53     15                   Farm                          
OSearchBasicFeature            bc29e863-ae07-4674-bd83-2c6d0aa5623f     14                   WebApplication                
OSearchBasicFeature            bc29e863-ae07-4674-bd83-2c6d0aa5623f     15                   WebApplication                
OSearchCentralAdminLinks       c922c106-7d0a-4377-a668-7f13d52cb80f     14                   Farm                          
OSearchCentralAdminLinks       c922c106-7d0a-4377-a668-7f13d52cb80f     15                   Farm                          
OSearchEnhancedFeature         4750c984-7721-4feb-be61-c660c6190d43     15                   WebApplication                
OSearchEnhancedFeature         4750c984-7721-4feb-be61-c660c6190d43     14                   WebApplication                
OSearchHealthReports           e792e296-5d7f-47c7-9dfa-52eae2104c3b     14                   Site                          
OSearchHealthReportsPushdown   09fe98f3-3324-4747-97e5-916a28a0c6c0     14                   Farm                          
OSearchHealthReportsPushdown   09fe98f3-3324-4747-97e5-916a28a0c6c0     15                   Farm                          
OSearchPortalAdminLinks        edf48246-e4ee-4638-9eed-ef3d0aee7597     15                   Farm                          
OSearchPortalAdminLinks        edf48246-e4ee-4638-9eed-ef3d0aee7597     14                   Farm                          
OsrvLinks                      068f8656-bea6-4d60-a5fa-7f077f8f5c20     14                   Web                           
OsrvLinks                      068f8656-bea6-4d60-a5fa-7f077f8f5c20     15                   Web                           
OssNavigation                  10bdac29-a21a-47d9-9dff-90c7cae1301e     15                   Web                           
OssNavigation                  10bdac29-a21a-47d9-9dff-90c7cae1301e     14                   Web                           
OSSSearchEndUserHelpFeature    03b0a3dc-93dd-4c68-943e-7ec56e65ed4d     14                   Site                          
OSSSearchEndUserHelpFeature    03b0a3dc-93dd-4c68-943e-7ec56e65ed4d     15                   Site                          
OSSSearchSearchCenterUrlFea... 7acfcb9d-8e8f-4979-af7e-8aed7e95245e     14                   Web                           
OSSSearchSearchCenterUrlFea... 7acfcb9d-8e8f-4979-af7e-8aed7e95245e     15                   Web                           
OSSSearchSearchCenterUrlSit... 7ac8cc56-d28e-41f5-ad04-d95109eb987a     14                   Site                          
OSSSearchSearchCenterUrlSit... 7ac8cc56-d28e-41f5-ad04-d95109eb987a     15                   Site                          
PageConverters                 14173c38-5e2d-4887-8134-60f9df889bad     14                   WebApplication                
PageConverters                 14173c38-5e2d-4887-8134-60f9df889bad     15                   WebApplication                
PersonalizationSite            ed5e77f7-c7b1-4961-a659-0de93080fa36     14                   Web                           
PersonalizationSite            ed5e77f7-c7b1-4961-a659-0de93080fa36     15                   Web                           
PhonePNSubscriber              41e1d4bf-b1a2-47f7-ab80-d5d6cbba3092     15                   Web                           
PictureLibrary                 00bfea71-52d4-45b3-b544-b1c71b620109     14                   Web                           
PictureLibrary                 00bfea71-52d4-45b3-b544-b1c71b620109     15                   Web                           
PortalLayouts                  5f3b0127-2f1d-4cfd-8dd2-85ad1fb00bfc     14                   Site                          
PortalLayouts                  5f3b0127-2f1d-4cfd-8dd2-85ad1fb00bfc     15                   Site                          
PPSDatasourceLib               5d220570-df17-405e-b42d-994237d60ebf     14                   Web                           
PPSDatasourceLib               5d220570-df17-405e-b42d-994237d60ebf     15                   Web                           
PPSMonDatasourceCtype          05891451-f0c4-4d4e-81b1-0dabd840bad4     14                   Site                          
PPSMonDatasourceCtype          05891451-f0c4-4d4e-81b1-0dabd840bad4     15                   Site                          
PPSRibbon                      ae31cd14-a866-4834-891a-97c9d37662a2     15                   Site                          
PPSSiteCollectionMaster        a1cb5b7f-e5e9-421b-915f-bf519b0760ef     14                   Site                          
PPSSiteCollectionMaster        a1cb5b7f-e5e9-421b-915f-bf519b0760ef     15                   Site                          
PPSSiteMaster                  0b07a7f4-8bb8-4ec0-a31b-115732b9584d     14                   Web                           
PPSSiteMaster                  0b07a7f4-8bb8-4ec0-a31b-115732b9584d     15                   Web                           
PPSSiteStapling                8472208f-5a01-4683-8119-3cea50bea072     15                   Farm                          
PPSSiteStapling                8472208f-5a01-4683-8119-3cea50bea072     14                   Farm                          
PPSWebParts                    ee9dbf20-1758-401e-a169-7db0a6bbccb2     14                   Site                          
PPSWebParts                    ee9dbf20-1758-401e-a169-7db0a6bbccb2     15                   Site                          
PPSWorkspaceCtype              f45834c7-54f6-48db-b7e4-a35fa470fc9b     15                   Site                          
PPSWorkspaceCtype              f45834c7-54f6-48db-b7e4-a35fa470fc9b     14                   Site                          
PPSWorkspaceList               481333e1-a246-4d89-afab-d18c6fe344ce     14                   Web                           
PPSWorkspaceList               481333e1-a246-4d89-afab-d18c6fe344ce     15                   Web                           
PremiumSearchVerticals         9e99f7d7-08e9-455c-b3aa-fc71b9210027     15                   Web                           
PremiumSite                    8581a8a7-cf16-4770-ac54-260265ddb0b2     14                   Site                          
PremiumSite                    8581a8a7-cf16-4770-ac54-260265ddb0b2     15                   Site                          
PremiumSiteStapling            a573867a-37ca-49dc-86b0-7d033a7ed2c8     15                   Farm                          
PremiumSiteStapling            a573867a-37ca-49dc-86b0-7d033a7ed2c8     14                   Farm                          
PremiumWeb                     0806d127-06e6-447a-980e-2e90b03101b8     14                   Web                           
PremiumWeb                     0806d127-06e6-447a-980e-2e90b03101b8     15                   Web                           
PremiumWebApplication          0ea1c3b6-6ac0-44aa-9f3f-05e8dbe6d70b     15                   WebApplication                
PremiumWebApplication          0ea1c3b6-6ac0-44aa-9f3f-05e8dbe6d70b     14                   WebApplication                
Preservation                   bfc789aa-87ba-4d79-afc7-0c7e45dae01a     15                   Site                          
ProductCatalogListTemplate     dd926489-fc66-47a6-ba00-ce0e959c9b41     15                   Site                          
ProductCatalogResources        409d2feb-3afb-4642-9462-f7f426a0f3e9     15                   Site                          
ProfileSynch                   af847aa9-beb6-41d4-8306-78e41af9ce25     14                   Farm                          
ProfileSynch                   af847aa9-beb6-41d4-8306-78e41af9ce25     15                   Farm                          
ProjectBasedPolicy             2fcd5f8a-26b7-4a6a-9755-918566dba90a     15                   Site                          
ProjectDiscovery               4446ee9b-227c-4f1a-897d-d78ecdd6a824     15                   Web                           
ProjectFunctionality           e2f2bb18-891d-4812-97df-c265afdba297     15                   Web                           
PromotedLinksList              192efa95-e50c-475e-87ab-361cede5dd7f     15                   Web                           
Publishing                     22a9ef51-737b-4ff2-9346-694633fe4416     15                   Web                           
Publishing                     22a9ef51-737b-4ff2-9346-694633fe4416     14                   Web                           
PublishingLayouts              d3f51be2-38a8-4e44-ba84-940d35be1566     15                   Site                          
PublishingLayouts              d3f51be2-38a8-4e44-ba84-940d35be1566     14                   Site                          
PublishingMobile               57cc6207-aebf-426e-9ece-45946ea82e4a     15                   Site                          
PublishingPrerequisites        a392da98-270b-4e85-9769-04c0fde267aa     14                   Site                          
PublishingPrerequisites        a392da98-270b-4e85-9769-04c0fde267aa     15                   Site                          
PublishingResources            aebc918d-b20f-4a11-a1db-9ed84d79c87e     14                   Site                          
PublishingResources            aebc918d-b20f-4a11-a1db-9ed84d79c87e     15                   Site                          
PublishingSite                 f6924d36-2fa8-4f0b-b16d-06b7250180fa     14                   Site                          
PublishingSite                 f6924d36-2fa8-4f0b-b16d-06b7250180fa     15                   Site                          
PublishingStapling             001f4bd7-746d-403b-aa09-a6cc43de7942     14                   Farm                          
PublishingStapling             001f4bd7-746d-403b-aa09-a6cc43de7942     15                   Farm                          
PublishingTimerJobs            20477d83-8bdb-414e-964b-080637f7d99b     14                   WebApplication                
PublishingTimerJobs            20477d83-8bdb-414e-964b-080637f7d99b     15                   WebApplication                
PublishingWeb                  94c94ca6-b32f-4da9-a9e3-1f3d343d7ecb     15                   Web                           
PublishingWeb                  94c94ca6-b32f-4da9-a9e3-1f3d343d7ecb     14                   Web                           
QueryBasedPreservation         d9742165-b024-4713-8653-851573b9dfbd     15                   Site                          
Ratings                        915c240e-a6cc-49b8-8b2c-0bff8b553ed3     15                   Site                          
Ratings                        915c240e-a6cc-49b8-8b2c-0bff8b553ed3     14                   Site                          
RecordResources                5bccb9a4-b903-4fd1-8620-b795fa33c9ba     14                   Site                          
RecordResources                5bccb9a4-b903-4fd1-8620-b795fa33c9ba     15                   Site                          
RecordsCenter                  e0a45587-1069-46bd-bf05-8c8db8620b08     15                   Web                           
RecordsCenter                  e0a45587-1069-46bd-bf05-8c8db8620b08     14                   Web                           
RecordsManagement              6d127338-5e7d-4391-8f62-a11e43b1d404     14                   Farm                          
RecordsManagement              6d127338-5e7d-4391-8f62-a11e43b1d404     15                   Farm                          
RecordsManagementTenantAdmin   b5ef96cb-d714-41da-b66c-ce3517034c21     15                   Web                           
RecordsManagementTenantAdmi... 8c54e5d3-4635-4dff-a533-19fe999435dc     15                   Farm                          
RedirectPageContentTypeBinding 306936fd-9806-4478-80d1-7e397bfa6474     14                   Web                           
RedirectPageContentTypeBinding 306936fd-9806-4478-80d1-7e397bfa6474     15                   Web                           
RelatedLinksScopeSettingsLink  e8734bb6-be8e-48a1-b036-5a40ff0b8a81     15                   Web                           
RelatedLinksScopeSettingsLink  e8734bb6-be8e-48a1-b036-5a40ff0b8a81     14                   Web                           
ReportAndDataSearch            b9455243-e547-41f0-80c1-d5f6ce6a19e5     15                   Web                           
ReportCenterSampleData         c5d947d6-b0a2-4e07-9929-8e54f5a9fff9     14                   Web                           
ReportCenterSampleData         c5d947d6-b0a2-4e07-9929-8e54f5a9fff9     15                   Web                           
Reporting                      7094bd89-2cfe-490a-8c7e-fbace37b4a34     15                   Site                          
Reporting                      7094bd89-2cfe-490a-8c7e-fbace37b4a34     14                   Site                          
ReportListTemplate             2510d73f-7109-4ccc-8a1c-314894deeb3a     14                   Web                           
ReportListTemplate             2510d73f-7109-4ccc-8a1c-314894deeb3a     15                   Web                           
ReportsAndDataCTypes           e0a9f213-54f5-4a5a-81d5-f5f3dbe48977     15                   Site                          
ReportsAndDataFields           365356ee-6c88-4cf1-92b8-fa94a8b8c118     15                   Site                          
ReportsAndDataListTemplates    b435069a-e096-46e0-ae30-899daca4b304     15                   Site                          
ReviewPublishingSPD            a44d2aa3-affc-4d58-8db4-f4a3af053188     15                   Site                          
ReviewPublishingSPD            a44d2aa3-affc-4d58-8db4-f4a3af053188     14                   Site                          
ReviewPublishingSPD1028        19f5f68e-1b92-4a02-b04d-61810ead0404     15                   Site                          
ReviewPublishingSPD1028        19f5f68e-1b92-4a02-b04d-61810ead0404     14                   Site                          
ReviewWorkflows                02464c6a-9d07-4f30-ba04-e9035cf54392     14                   Site                          
ReviewWorkflows                02464c6a-9d07-4f30-ba04-e9035cf54392     15                   Site                          
ReviewWorkflowsSPD             b5934f65-a844-4e67-82e5-92f66aafe912     14                   Site                          
ReviewWorkflowsSPD             b5934f65-a844-4e67-82e5-92f66aafe912     15                   Site                          
ReviewWorkflowsSPD1028         3bc0c1e1-b7d5-4e82-afd7-9f7e59b60404     15                   Site                          
ReviewWorkflowsSPD1028         3bc0c1e1-b7d5-4e82-afd7-9f7e59b60404     14                   Site                          
RollupPageLayouts              588b23d5-8e23-4b1b-9fe3-2f2f62965f2d     15                   Site                          
RollupPages                    dffaae84-60ee-413a-9600-1cf431cf0560     15                   Web                           
ScheduleList                   636287a7-7f62-4a6e-9fcc-081f4672cbf8     15                   Web                           
ScheduleList                   636287a7-7f62-4a6e-9fcc-081f4672cbf8     14                   Web                           
SearchAdminWebParts            c65861fa-b025-4634-ab26-22a23e49808f     15                   Web                           
SearchAdminWebParts            c65861fa-b025-4634-ab26-22a23e49808f     14                   Web                           
SearchAndProcess               1dbf6063-d809-45ea-9203-d3ba4a64f86d     15                   WebApplication                
SearchAndProcess               1dbf6063-d809-45ea-9203-d3ba4a64f86d     14                   WebApplication                
SearchCenterFiles              6077b605-67b9-4937-aeb6-1d41e8f5af3b     15                   Web                           
SearchCenterLiteFiles          073232a0-1868-4323-a144-50de99c70efc     15                   Web                           
SearchCenterLiteUpgrade        fbbd1168-3b17-4f29-acb4-ef2d34c54cfb     15                   Web                           
SearchCenterUpgrade            372b999f-0807-4427-82dc-7756ae73cb74     15                   Web                           
SearchConfigContentType        48a243cb-7b16-4b5a-b1b5-07b809b43f47     15                   Web                           
SearchConfigFields             41dfb393-9eb6-4fe4-af77-28e4afce8cdc     15                   Web                           
SearchConfigList               acb15743-f07b-4c83-8af3-ffcfdf354965     15                   Web                           
SearchConfigListTemplate       e47705ec-268d-4c41-aa4e-0d8727985ebc     15                   Web                           
SearchConfigTenantStapler      9fb35ca8-824b-49e6-a6c5-cba4366444ab     15                   Farm                          
SearchDrivenContent            592ccb4a-9304-49ab-aab1-66638198bb58     15                   Site                          
SearchEngineOptimization       17415b1d-5339-42f9-a10b-3fef756b84d1     15                   Site                          
SearchExtensions               5eac763d-fbf5-4d6f-a76b-eded7dd7b0a5     15                   Site                          
SearchExtensions               5eac763d-fbf5-4d6f-a76b-eded7dd7b0a5     14                   Site                          
SearchMaster                   9c0834e1-ba47-4d49-812b-7d4fb6fea211     15                   Site                          
SearchServerWizardFeature      e09cefae-2ada-4a1d-aee6-8a8398215905     14                   Site                          
SearchServerWizardFeature      e09cefae-2ada-4a1d-aee6-8a8398215905     15                   Site                          
SearchTaxonomyRefinementWeb... 67ae7d04-6731-42dd-abe1-ba2a5eaa3b48     15                   Site                          
SearchTaxonomyRefinementWeb... 8c34f59f-8dfb-4a39-9a08-7497237e3dc4     15                   Site                          
SearchTemplatesandResources    8b2c6bcb-c47f-4f17-8127-f8eae47a44dd     15                   Site                          
SearchWebParts                 eaf6a128-0482-4f71-9a2f-b1c650680e77     14                   Site                          
SearchWebParts                 eaf6a128-0482-4f71-9a2f-b1c650680e77     15                   Site                          
SearchWebPartsStapler          922ed989-6eb4-4f5e-a32e-27f31f93abfa     15                   Farm                          
SharedServices                 f324259d-393d-4305-aa48-36e8d9a7a0d6     14                   Farm                          
SharedServices                 f324259d-393d-4305-aa48-36e8d9a7a0d6     15                   Farm                          
ShareWithEveryone              10f73b29-5779-46b3-85a8-4817a6e9a6c2     15                   Site                          
ShareWithEveryoneStapling      87866a72-efcf-4993-b5b0-769776b5283f     15                   Farm                          
SignaturesWorkflow             6c09612b-46af-4b2f-8dfc-59185c962a29     14                   Site                          
SignaturesWorkflow             6c09612b-46af-4b2f-8dfc-59185c962a29     15                   Site                          
SignaturesWorkflowSPD          c4773de6-ba70-4583-b751-2a7b1dc67e3a     14                   Site                          
SignaturesWorkflowSPD          c4773de6-ba70-4583-b751-2a7b1dc67e3a     15                   Site                          
SignaturesWorkflowSPD1028      a42f749f-8633-48b7-9b22-403b40190404     14                   Site                          
SignaturesWorkflowSPD1028      a42f749f-8633-48b7-9b22-403b40190404     15                   Site                          
SiteAssets                     98d11606-9a9b-4f44-b4c2-72d72f867da9     15                   Web                           
SiteFeed                       15a572c6-e545-4d32-897a-bab6f5846e18     15                   Web                           
SiteFeedController             5153156a-63af-4fac-b557-91bd8c315432     15                   Web                           
SiteFeedStapling               6301cbb8-9396-45d1-811a-757567d35e91     15                   Farm                          
SiteHelp                       57ff23fc-ec05-4dd8-b7ed-d93faa7c795d     14                   Site                          
SiteHelp                       57ff23fc-ec05-4dd8-b7ed-d93faa7c795d     15                   Site                          
SiteNotebook                   f151bb39-7c3b-414f-bb36-6bf18872052f     15                   Web                           
SiteServicesAddins             b21c5a20-095f-4de2-8935-5efde5110ab3     15                   Site                          
SiteSettings                   fead7313-4b9e-4632-80a2-98a2a2d83297     15                   Farm                          
SiteSettings                   fead7313-4b9e-4632-80a2-98a2a2d83297     14                   Farm                          
SitesList                      a311bf68-c990-4da3-89b3-88989a3d7721     15                   Web                           
SitesList                      a311bf68-c990-4da3-89b3-88989a3d7721     14                   Web                           
SiteStatusBar                  001f4bd7-746d-403b-aa09-a6cc43de7999     15                   Farm                          
SiteStatusBar                  001f4bd7-746d-403b-aa09-a6cc43de7999     14                   Farm                          
SiteUpgrade                    b63ef52c-1e99-455f-8511-6a706567740f     14                   WebApplication                
SiteUpgrade                    b63ef52c-1e99-455f-8511-6a706567740f     15                   WebApplication                
SkuUpgradeLinks                937f97e9-d7b4-473d-af17-b03951b2c66b     15                   Farm                          
SkuUpgradeLinks                937f97e9-d7b4-473d-af17-b03951b2c66b     14                   Farm                          
SlideLibrary                   0be49fe9-9bc9-409d-abf9-702753bd878d     14                   Web                           
SlideLibrary                   0be49fe9-9bc9-409d-abf9-702753bd878d     15                   Web                           
SlideLibraryActivation         65d96c6b-649a-4169-bf1d-b96505c60375     15                   Farm                          
SlideLibraryActivation         65d96c6b-649a-4169-bf1d-b96505c60375     14                   Farm                          
SmallBusinessWebsite           48c33d5d-acff-4400-a684-351c2beda865     15                   Site                          
SocialDataStore                fa8379c9-791a-4fb0-812e-d0cfcac809c8     15                   Site                          
SocialRibbonControl            756d8a58-4e24-4288-b981-65dc93f9c4e5     15                   Farm                          
SocialRibbonControl            756d8a58-4e24-4288-b981-65dc93f9c4e5     14                   Farm                          
SocialSite                     4326e7fc-f35a-4b0f-927c-36264b0a4cf0     15                   Site                          
SPAppAnalyticsUploaderJob      abf42bbb-cd9b-4313-803b-6f4a7bd4898f     15                   Farm                          
SpellChecking                  612d671e-f53d-4701-96da-c3a4ee00fdc5     15                   Farm                          
SpellChecking                  612d671e-f53d-4701-96da-c3a4ee00fdc5     14                   Farm                          
SPSBlog                        d97ded76-7647-4b1e-b868-2af51872e1b3     15                   Web                           
SPSBlogStapling                6d503bb6-027e-44ea-b54c-a53eac3dfed8     15                   Farm                          
SPSDisco                       713a65a1-2bc7-4e62-9446-1d0b56a8bf7f     14                   Farm                          
SPSDisco                       713a65a1-2bc7-4e62-9446-1d0b56a8bf7f     15                   Farm                          
SPSearchFeature                2ac1da39-c101-475c-8601-122bc36e3d67     15                   WebApplication                
SPSearchFeature                2ac1da39-c101-475c-8601-122bc36e3d67     14                   WebApplication                
SRPProfileAdmin                c43a587e-195b-4d29-aba8-ebb22b48eb1a     14                   Farm                          
SRPProfileAdmin                c43a587e-195b-4d29-aba8-ebb22b48eb1a     15                   Farm                          
SSSvcAdmin                     35f680d4-b0de-4818-8373-ee0fca092526     14                   Web                           
SSSvcAdmin                     35f680d4-b0de-4818-8373-ee0fca092526     15                   Web                           
StapledWorkflows               ee21b29b-b0d0-42c6-baff-c97fd91786e6     14                   Farm                          
StapledWorkflows               ee21b29b-b0d0-42c6-baff-c97fd91786e6     15                   Farm                          
SurveysList                    00bfea71-eb8a-40b1-80c7-506be7590102     15                   Web                           
SurveysList                    00bfea71-eb8a-40b1-80c7-506be7590102     14                   Web                           
TaskListNewsFeed               ff13819a-a9ac-46fb-8163-9d53357ef98d     15                   Web                           
TasksList                      00bfea71-a83e-497e-9ba0-7a5c597d0107     15                   Web                           
TasksList                      00bfea71-a83e-497e-9ba0-7a5c597d0107     14                   Web                           
TaxonomyFeatureStapler         415780bf-f710-4e2c-b7b0-b463c7992ef0     14                   Farm                          
TaxonomyFeatureStapler         415780bf-f710-4e2c-b7b0-b463c7992ef0     15                   Farm                          
TaxonomyFieldAdded             73ef14b1-13a9-416b-a9b5-ececa2b0604c     15                   Site                          
TaxonomyFieldAdded             73ef14b1-13a9-416b-a9b5-ececa2b0604c     14                   Site                          
TaxonomyTenantAdmin            7d12c4c3-2321-42e8-8fb6-5295a849ed08     15                   Web                           
TaxonomyTenantAdmin            7d12c4c3-2321-42e8-8fb6-5295a849ed08     14                   Web                           
TaxonomyTenantAdminStapler     8fb893d6-93ee-4763-a046-54f9e640368d     15                   Farm                          
TaxonomyTenantAdminStapler     8fb893d6-93ee-4763-a046-54f9e640368d     14                   Farm                          
TaxonomyTimerJobs              48ac883d-e32e-4fd6-8499-3408add91b53     15                   WebApplication                
TaxonomyTimerJobs              48ac883d-e32e-4fd6-8499-3408add91b53     14                   WebApplication                
TeamCollab                     00bfea71-4ea5-48d4-a4ad-7ea5c011abe5     14                   Web                           
TeamCollab                     00bfea71-4ea5-48d4-a4ad-7ea5c011abe5     15                   Web                           
TemplateDiscovery              ff48f7e6-2fa1-428d-9a15-ab154762043d     15                   Farm                          
TemplateDiscovery              ff48f7e6-2fa1-428d-9a15-ab154762043d     14                   Farm                          
TenantAdminBDC                 0a0b2e8f-e48e-4367-923b-33bb86c1b398     14                   Web                           
TenantAdminBDC                 0a0b2e8f-e48e-4367-923b-33bb86c1b398     15                   Web                           
TenantAdminBDCStapling         b5d169c9-12db-4084-b68d-eef9273bd898     14                   Farm                          
TenantAdminBDCStapling         b5d169c9-12db-4084-b68d-eef9273bd898     15                   Farm                          
TenantAdminDeploymentLinks     99f380b4-e1aa-4db0-92a4-32b15e35b317     14                   Web                           
TenantAdminDeploymentLinks     99f380b4-e1aa-4db0-92a4-32b15e35b317     15                   Web                           
TenantAdminLinks               98311581-29c5-40e8-9347-bd5732f0cb3e     14                   Web                           
TenantAdminLinks               98311581-29c5-40e8-9347-bd5732f0cb3e     15                   Web                           
TenantAdminSecureStore         b738400a-f08a-443d-96fa-a852d0356bba     15                   Web                           
TenantAdminSecureStore         b738400a-f08a-443d-96fa-a852d0356bba     14                   Web                           
TenantAdminSecureStoreStapling 6361e2a8-3bc4-4ca4-abbb-3dfbb727acd7     14                   Farm                          
TenantAdminSecureStoreStapling 6361e2a8-3bc4-4ca4-abbb-3dfbb727acd7     15                   Farm                          
TenantProfileAdmin             32ff5455-8967-469a-b486-f8eaf0d902f9     15                   Web                           
TenantProfileAdmin             32ff5455-8967-469a-b486-f8eaf0d902f9     14                   Web                           
TenantProfileAdminStapling     3d4ea296-0b35-4a08-b2bf-f0a8cabd1d7f     14                   Farm                          
TenantProfileAdminStapling     3d4ea296-0b35-4a08-b2bf-f0a8cabd1d7f     15                   Farm                          
TenantSearchAdmin              983521d7-9c04-4db0-abdc-f7078fc0b040     15                   Web                           
TenantSearchAdminStapling      08ee8de1-8135-4ef9-87cb-a4944f542ba3     15                   Farm                          
TimeCardList                   d5191a77-fa2d-4801-9baf-9f4205c9e9d2     15                   Web                           
TimecardList                   d5191a77-fa2d-4801-9baf-9f4205c9e9d2     14                   Web                           
TopicPageLayouts               742d4c0e-303b-41d7-8015-aad1dfd54cbd     15                   Site                          
TopicPages                     5ebe1445-5910-4c6e-ac27-da2e93b60f48     15                   Web                           
Translation                    4e7276bc-e7ab-4951-9c4b-a74d44205c32     15                   Site                          
TranslationTimerJobs           d085b8dc-9205-48a4-96ea-b40782abba02     15                   WebApplication                
TranslationWorkflow            c6561405-ea03-40a9-a57f-f25472942a22     15                   Site                          
TranslationWorkflow            c6561405-ea03-40a9-a57f-f25472942a22     14                   Site                          
TransMgmtFunc                  82e2ea42-39e2-4b27-8631-ed54c1cfc491     15                   Farm                          
TransMgmtFunc                  82e2ea42-39e2-4b27-8631-ed54c1cfc491     14                   Farm                          
TransMgmtLib                   29d85c25-170c-4df9-a641-12db0b9d4130     14                   Web                           
TransMgmtLib                   29d85c25-170c-4df9-a641-12db0b9d4130     15                   Web                           
UPAClaimProvider               5709886f-13cc-4ffc-bfdc-ec8ab7f77191     15                   Farm                          
UpgradeOnlyFile                2fa4db13-4109-4a1d-b47c-c7991d4cc934     15                   Web                           
UpgradeOnlyFile                2fa4db13-4109-4a1d-b47c-c7991d4cc934     14                   Web                           
UserMigrator                   f0deabbb-b0f6-46ba-8e16-ff3b44461aeb     14                   Farm                          
UserMigrator                   f0deabbb-b0f6-46ba-8e16-ff3b44461aeb     15                   Farm                          
UserProfileUserSettingsProv... 0867298a-70e0-425f-85df-7f8bd9e06f15     15                   Farm                          
V2VPublishedLinks              f63b7696-9afc-4e51-9dfd-3111015e9a60     14                   Site                          
V2VPublishedLinks              f63b7696-9afc-4e51-9dfd-3111015e9a60     15                   Site                          
V2VPublishingLayouts           2fbbe552-72ac-11dc-8314-0800200c9a66     14                   Site                          
V2VPublishingLayouts           2fbbe552-72ac-11dc-8314-0800200c9a66     15                   Site                          
VideoAndRichMedia              6e1e5426-2ebd-4871-8027-c5ca86371ead     15                   Site                          
ViewFormPagesLockDown          7c637b23-06c4-472d-9a9a-7c175762c5c4     14                   Site                          
ViewFormPagesLockDown          7c637b23-06c4-472d-9a9a-7c175762c5c4     15                   Site                          
VisioProcessRepository         7e0aabee-b92b-4368-8742-21ab16453d01     14                   Web                           
VisioProcessRepository         7e0aabee-b92b-4368-8742-21ab16453d01     15                   Web                           
VisioProcessRepositoryConte... 12e4f16b-8b04-42d2-90f2-aef1cc0b65d9     15                   Web                           
VisioProcessRepositoryConte... b1f70691-6170-4cae-bc2e-4f7011a74faa     15                   Web                           
VisioProcessRepositoryFeatu... 7e0aabee-b92b-4368-8742-21ab16453d00     14                   Farm                          
VisioProcessRepositoryFeatu... 7e0aabee-b92b-4368-8742-21ab16453d00     15                   Farm                          
VisioProcessRepositoryUs       7e0aabee-b92b-4368-8742-21ab16453d02     15                   Web                           
VisioProcessRepositoryUs       7e0aabee-b92b-4368-8742-21ab16453d02     14                   Web                           
VisioServer                    5fe8e789-d1b7-44b3-b634-419c531cfdca     15                   Farm                          
VisioServer                    5fe8e789-d1b7-44b3-b634-419c531cfdca     14                   Farm                          
VisioWebAccess                 9fec40ea-a949-407d-be09-6cba26470a0c     14                   Site                          
VisioWebAccess                 9fec40ea-a949-407d-be09-6cba26470a0c     15                   Site                          
WAWhatsPopularWebPart          8e947bf0-fe40-4dff-be3d-a8b88112ade6     14                   Site                          
WAWhatsPopularWebPart          8e947bf0-fe40-4dff-be3d-a8b88112ade6     15                   Site                          
WebPageLibrary                 00bfea71-c796-4402-9f2f-0eb9a6e71b18     14                   Web                           
WebPageLibrary                 00bfea71-c796-4402-9f2f-0eb9a6e71b18     15                   Web                           
WebPartAdderGroups             2ed1c45e-a73b-4779-ae81-1524e4de467a     15                   Site                          
WebPartAdderGroups             2ed1c45e-a73b-4779-ae81-1524e4de467a     14                   Site                          
WhatsNewList                   d7670c9c-1c29-4f44-8691-584001968a74     15                   Web                           
WhatsNewList                   d7670c9c-1c29-4f44-8691-584001968a74     14                   Web                           
WhereaboutsList                9c2ef9dc-f733-432e-be1c-2e79957ea27b     15                   Web                           
WhereaboutsList                9c2ef9dc-f733-432e-be1c-2e79957ea27b     14                   Web                           
WikiPageHomePage               00bfea71-d8fe-4fec-8dad-01c19a6e4053     15                   Web                           
WikiPageHomePage               00bfea71-d8fe-4fec-8dad-01c19a6e4053     14                   Web                           
WikiWelcome                    8c6a6980-c3d9-440e-944c-77f93bc65a7e     15                   Web                           
WikiWelcome                    8c6a6980-c3d9-440e-944c-77f93bc65a7e     14                   Web                           
WordServerViewing              1663ee19-e6ab-4d47-be1b-adeb27cfd9d2     14                   Site                          
WordServerViewing              1663ee19-e6ab-4d47-be1b-adeb27cfd9d2     15                   Site                          
WorkflowAppOnlyPolicyManager   ec918931-c874-4033-bd09-4f36b2e31fef     15                   Web                           
WorkflowHistoryList            00bfea71-4ea5-48d4-a4ad-305cf7030140     14                   Web                           
WorkflowHistoryList            00bfea71-4ea5-48d4-a4ad-305cf7030140     15                   Web                           
WorkflowProcessList            00bfea71-2d77-4a75-9fca-76516689e21a     14                   Web                           
workflowProcessList            00bfea71-2d77-4a75-9fca-76516689e21a     15                   Web                           
Workflows                      0af5989a-3aea-4519-8ab0-85d91abe39ff     14                   Site                          
Workflows                      0af5989a-3aea-4519-8ab0-85d91abe39ff     15                   Site                          
WorkflowServiceStapler         8b82e40f-2001-4f0e-9ce3-0b27d1866dff     15                   Farm                          
WorkflowServiceStore           2c63df2b-ceab-42c6-aeff-b3968162d4b1     15                   Web                           
WorkflowTask                   57311b7a-9afd-4ff0-866e-9393ad6647b1     15                   Web                           
XmlFormLibrary                 00bfea71-1e1d-4562-b56a-f05371bb0115     15                   Web                           
XmlFormLibrary                 00bfea71-1e1d-4562-b56a-f05371bb0115     14                   Web                           
XmlSitemap                     77fc9e13-e99a-4bd3-9438-a3f69670ed97     15                   Site                          



PS SQLSERVER:\> #>}#Uninstall-SPFeature -AllExistingFeatures#get-help Uninstall-SPFeature -full(Get-SPFeature).count  -> 662  + 5        #Oct.7.2015 done
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

$ServiceApplicationUser = "PMOCSD\SPService" 
$ServiceApplicationUserPassword = (ConvertTo-SecureString "pass@word1" -AsPlainText -force) 
$ServiceApplicationCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $ServiceApplicationUser, $ServiceApplicationUserPassword  
$ManagedAccount = New-SPManagedAccount -Credential $ServiceApplicationCredentials  


get-SPManagedAccount  #PMOCSD\infra1 only
'PS C:\Windows\system32> get-SPManagedAccount

UserName             PasswordExpiration    Automatic ChangeSchedule                
                                           Change                                  
--------             ------------------    --------- --------------                
PMOCSD\infra1        2015/10/21 下午 09:5... False                                   
'
$cred = Get-Credential PMOCSD\SPService
New-SPManagedAccount  -Credential $cred 
get-SPManagedAccount  #tempcsd\spfarm  +tempcsd\SPService
'PS C:\Windows\system32> get-SPManagedAccount

UserName             PasswordExpiration    Automatic ChangeSchedule                
                                           Change                                  
--------             ------------------    --------- --------------                
PMOCSD\infra1        2015/10/21 下午 09:5... False                                   
PMOCSD\SPService     2015/11/19 上午 09:4... False '

#9.1.2 
get-SPServiceApplicationPool
New-SPServiceApplicationPool -Name BIApplicationPool -Account PMOCSD\SPService
get-SPServiceApplicationPool  BIApplicationPool  |select *
'

PS C:\Windows\system32> get-SPServiceApplicationPool  BIApplicationPool  |select *
ProcessAccountName          : PMOCSD\SPService
Name                        : BIApplicationPool
ProcessAccount              : S-1-5-21-1411349735-3200970217-3053669373-1117
TypeName                    : Microsoft.SharePoint.Administration.SPIisWebServiceApplicationPool
DisplayName                 : BIApplicationPool
Id                          : a84acea1-6491-45aa-bf3b-e71062f69a6e
Status                      : Online
Parent                      : SPIisWebServiceSettings Name=SharePoint Web Services
Version                     : 9009
Properties                  : {}
Farm                        : SPFarm Name=_ConfigDB
UpgradedPersistedProperties : {}


(tempcsd)
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


get-SPServiceApplicationPool |select name, id , ProcessAccountName,displayname

'PS C:\Windows\system32> get-SPServiceApplicationPool |select name, id , ProcessAccountName

Name                                                     Id                                                       ProcessAccountName                                     
----                                                     --                                                       ------------------                                     
BIApplicationPool                                        a84acea1-6491-45aa-bf3b-e71062f69a6e                     PMOCSD\SPService                                       
SecurityTokenServiceApplicationPool                      511e789d-f948-4857-8fe8-cef7cb339397                     PMOCSD\infra1                                          
SharePoint Web Services System                           8db52d89-568c-4bb3-8f7e-7962b8463acd                     PMOCSD\infra1 '

由可確定  inetmgr.名稱 = SPServiceApplicationPool.Id,
此時 在 inetmgr 卻無看在 BIApplicationPool 出現   ref:line : 1490 & 1591

        #Oct.8.2015 done


:inetmgr
名稱:  11c52a3a13b34a4b982c31681c3860e0
實際路徑 : C:\Program Files\Microsoft Office Servers\15.0\WebServices\Shared\ExcelCalculationServer (待查..)


"-----------  561 -------------19.2  Start the Excel Calculation Services service (SI)  --------------------------------"
Get-SPServiceInstance | ?  TypeName -eq 'Excel Calculation Services'  # a504912b-2be2-4b22-87de-315ffe3e3955
Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' |Start-SPServiceInstance
Get-SPServiceInstance | ?  TypeName -eq 'Excel Calculation Services'   # status = provi to online
        #Oct.8.2015 done


"------------- 567 ------------19.3  Create an Excel Services service application(SA)   --------------------------------"

Get-SPServiceApplication |ft -AutoSize
Get-SPExcelServiceApplication 
'
PS C:\Windows\system32> Get-SPServiceApplication |ft -AutoSize

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application dd30c213-b5ac-4eb1-ac2c-762102e7dccd

(tempcsd)
PS C:\Windows\system32> Get-SPServiceApplication |ft -AutoSize

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359

'

$SPServiceApplicationPoolName='BIApplicationPool'
New-SPExcelServiceApplication -Name "ExcelServiceM" -ApplicationPool $SPServiceApplicationPoolName

Get-SPServiceApplication |ft -AutoSize
'Get-SPServiceApplication |ft -AutoSize

PS C:\Windows\system32> Get-SPServiceApplication |ft -AutoSize

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                       52109a27-ec54-4644-bd28-fc9caf960d4c
Security Token Service Application                          Security Token Service Application                          04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application dd30c213-b5ac-4eb1-ac2c-762102e7dccd





(tempcsd)
DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                       56d693a1-e399-4605-8109-08730467ccc2
Security Token Service Application                          Security Token Service Application                          1a88193f-2f77-48f7-a276-19a3c70baa16
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application 84044cab-bf1d-4c31-8897-35e99c777359
'

UI > Application Management   >  Manage service applications  http://localhost:2013/_admin/ServiceApplications.aspx
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

 #此時在 inetmgr上可以看   a84acea1649145aabf3be71062f69a6e applicationPool 出現. 對照 id = name  ref:line :  1490 & 1591

        #Oct.8.2015 done

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

gsv '*MSOLAP*'
'
Status   Name               DisplayName                           
------   ----               -----------                           
Running  MSOLAP$SSASMD      SQL Server Analysis Services (SSASMD) 
Running  MSOLAP$SSASTR      SQL Server Analysis Services (SSASTR) 
'

#10.1.1

D:\SQLASPT

SSASPT_PMOCSD_ConfigurationFile from  \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLINI\SQL2014

cmd /c ("D:\software2015\SQL2014_ENT_TW_X64\Setup.exe") '/ConfigurationFile=D:\SQLASPT\SSASPT_PMOCSD_ConfigurationFile.ini'
remember : services  account : pmocsd\infraSSASPT   p@ssw0trd
           admin acount :  PMOCSD\infra1 , pmocsd\PMOadmin , pmocsd\spservice

D:\SQLASPT\Data
D:\SQLASPT\Log
D:\SQLASPT\Temp
D:\SQLASPT\Backup

gsv -Name 'MSOLAP$SSASPT'
'Status   Name               DisplayName                           
------   ----               -----------                           
Running  MSOLAP$SSASPT      SQL Server Analysis Services (SSASPT)
 Oct.12.2015 '

#10.1.2 將 Analysis Services 的伺服器管理權限授與 Excel Services 
https://msdn.microsoft.com/en-us/library/jj219067.aspx#InstallSQL
    (1) connect to analysis services instance 
    (2) Right-click  Properties
    (3) click Security  (add  PMOCSD\infra1 , PMOCSD\SPAdmin , PMOCSD\SPService  )


#10.1.3
  環境有防火牆，請檢閱《SQL Server 線上叢書》主題＜設定 Windows 防火牆以允許 Analysis Services 存取＞。
  Configure the Windows Firewall to Allow Analysis Services Access
Use the information in the topic Configure the Windows Firewall to Allow Analysis Services Access to determine whether you need to unblock ports in a firewall to allow access to Analysis Services or Power Pivot for SharePoint. You can follow the steps provided in the topic to configure both port and firewall settings. In practice, you should perform these steps together to allow access to your Analysis Services server.


#10.1.4  configure Execl Servcies for analysis service integration (針對 Analysis Services 整合設定 Excel Services)
https://msdn.microsoft.com/en-us/library/jj219067.aspx#InstallSQL

In SharePoint Central Administration, in the Application Management group, click Manage Service Applications.
Click the name of your service application(管理 Excel Services 應用程式), the default is Excel Services Application.
                                        http://localhost:2013/_admin/ExcelServicesAdmin.aspx?Id=52109a27ec544644bd28fc9caf960d4c
On the Manage Excel Services Application page, click Data Model Settings.(資料模型設定)
   Excel Services 應用程式 資料模型設定   http://localhost:2013/_admin/ExcelServerBIServers.aspx?Id=56d693a1e3994605810908730467ccc2

Click Add Server. (新增 伺服器  http://localhost:2013/_admin/ExcelServerBIServer.aspx?Task=Add&Id=56d693a1e3994605810908730467ccc2 )
    assign :PMD2016\SSASPT

In Server Name, type the Analysis Services server name and the Power Pivot instance name. For example MyServer\POWERPIVOT. The Power Pivot instance name is required.
Type a description.
Click Ok.
The changes will take effect in a few minutes or you can Stop and Start the service Excel Calculation Services．
Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' |stop-SPServiceInstance -Confirm:$false
Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services'  # status :online -> Unprovisioning -> Provisioning  -> disabled
Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services' |start-SPServiceInstance 
(Get-SPServiceInstance  | ?  TypeName -eq 'Excel Calculation Services').status
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
I am whoami  : pmocsd\infra1

SpPowerPivot.msi 是SQLServer 提供(出品).QL Server 2014 PowerPivot for SharePoint 2013 在 SharePoint 2013 伺服器陣列中提供增強型 PowerPivot 功能和經驗。
這些功能包括使用活頁簿做為  資料來源、排程資料重新整理、 PowerPivot 圖庫  與 PowerPivot 管理儀表板

由於有SQL2012 & SQL2014 不同, 
SQL2014   spPowerPivot_SQL_2014.msi  存放在  \\192.168.112.129\h$\software2015\SQL_PowerPivot_msi 

"------------- 716 ------------21.0 Add-PSSnapin    -----------------------"
$snapin = (Get-PSSnapin -name Microsoft.SharePoint.PowerShell -EA SilentlyContinue)IF ($snapin -ne $null){write-host -f Green "SharePoint Snapin is loaded... No Action taken"}ELSE {write-host -f Yellow "SharePoint Snapin not found... Loading now"Add-PSSnapin Microsoft.SharePoint.PowerShellwrite-host -f Green "SharePoint Snapin is now loaded"}

"--------------726 -----------21.1 check    -----------------------"
Get-SPFarm
Get-SPFarmConfig |select *
'PS C:\Windows\system32> Get-SPFarmConfig |select *
WorkflowBatchSize                   : 100
WorkflowPostponeThreshold           : 15
WorkflowEventDeliveryTimeout        : 5
DataFormWebPartAutoRefreshEnabled   : True
ASPScriptOptimizationEnabled        : True
UserAccountDirectoryPathIsImmutable : False'
Get-SPProcessAccount |ft -AutoSize
'PS C:\Windows\system32> Get-SPProcessAccount |ft -AutoSize

SecurityIdentifier                             Name                        
------------------                             ----                        
S-1-5-20                                       NT AUTHORITY\NETWORK SERVICE
S-1-5-18                                       NT AUTHORITY\SYSTEM         
S-1-5-19                                       NT AUTHORITY\LOCAL SERVICE  
S-1-5-21-1411349735-3200970217-3053669373-1109 PMOCSD\infra1               
S-1-5-21-1411349735-3200970217-3053669373-1117 PMOCSD\SPService            
d'
Get-SPWebTemplate |sort name | ft -AutoSize 
'Get-SPWebTemplate |sort name | ft -AutoSize 

Name                     Title                                    LocaleId CompatibilityLevel Custom
----                     -----                                    -------- ------------------ ------
ACCSRV#0                 Access Services 網站                       1028     14                 False 
ACCSRV#0                 Access Services 網站                       1028     15                 False 
ACCSRV#1                 資產 Web 資料庫                               1028     14                 False 
ACCSRV#3                 慈善捐款 Web 資料庫                             1028     14                 False 
ACCSRV#4                 連絡人 Web 資料庫                              1028     14                 False 
ACCSRV#5                 專案 Web 資料庫                               1028     14                 False 
ACCSRV#6                 議題 Web 資料庫                               1028     14                 False 
ACCSVC#0                 Access Services 內部網站                     1028     15                 False 
ACCSVC#1                 Access Services 網站                       1028     15                 False 
APP#0                    應用程式範本                                   1028     15                 False 
APPCATALOG#0             應用程式目錄網站                                 1028     15                 False 
BDR#0                    文件中心                                     1028     14                 False 
BDR#0                    文件中心                                     1028     15                 False 
BICenterSite#0           商務智慧中心                                   1028     15                 False 
BICenterSite#0           商務智慧中心                                   1028     14                 False 
BLANKINTERNET#0          發佈網站                                     1028     14                 False 
BLANKINTERNET#0          發佈網站                                     1028     15                 False 
BLANKINTERNET#1          新聞稿網站                                    1028     14                 False 
BLANKINTERNET#1          新聞稿網站                                    1028     15                 False 
BLANKINTERNET#2          使用工作流程發佈網站                               1028     15                 False 
BLANKINTERNET#2          使用工作流程發佈網站                               1028     14                 False 
BLANKINTERNETCONTAINER#0 發佈入口網站                                   1028     14                 False 
BLANKINTERNETCONTAINER#0 發佈入口網站                                   1028     15                 False 
BLOG#0                   部落格                                      1028     15                 False 
BLOG#0                   部落格                                      1028     14                 False 
CENTRALADMIN#0           管理中心網站                                   1028     15                 False 
CENTRALADMIN#0           管理中心網站                                   1028     14                 False 
CMSPUBLISHING#0          發佈網站                                     1028     15                 False 
CMSPUBLISHING#0          發佈網站                                     1028     14                 False 
COMMUNITY#0              社群網站                                     1028     15                 False 
COMMUNITYPORTAL#0        社群入口網站                                   1028     15                 False 
DEV#0                    開發人員網站                                   1028     15                 False 
DOCMARKETPLACESITE#0     學術文件庫                                    1028     15                 False 
EDISC#0                  eDiscovery 中心                            1028     15                 False 
EDISC#1                  eDiscovery 案例                            1028     15                 False 
ENTERWIKI#0              企業 Wiki                                  1028     15                 False 
ENTERWIKI#0              企業 Wiki                                  1028     14                 False 
GLOBAL#0                 通用範本                                     1028     15                 False 
GLOBAL#0                 通用範本                                     1028     14                 False 
MPS#0                    基本會議工作區                                  1028     14                 False 
MPS#0                    基本會議工作區                                  1028     15                 False 
MPS#1                    空白會議工作區                                  1028     14                 False 
MPS#1                    空白會議工作區                                  1028     15                 False 
MPS#2                    決策會議工作區                                  1028     14                 False 
MPS#2                    決策會議工作區                                  1028     15                 False 
MPS#3                    社交會議工作區                                  1028     14                 False 
MPS#3                    社交會議工作區                                  1028     15                 False 
MPS#4                    多重頁面會議工作區                                1028     14                 False 
MPS#4                    多重頁面會議工作區                                1028     15                 False 
OFFILE#0                 (已過時) 記錄中心                               1028     15                 False 
OFFILE#0                 (已過時) 記錄中心                               1028     14                 False 
OFFILE#1                 記錄中心                                     1028     15                 False 
OFFILE#1                 記錄中心                                     1028     14                 False 
OSRV#0                   共用服務管理網站                                 1028     15                 False 
OSRV#0                   共用服務管理網站                                 1028     14                 False 
PPSMASite#0              PerformancePoint                         1028     15                 False 
PPSMASite#0              PerformancePoint                         1028     14                 False 
PRODUCTCATALOG#0         產品目錄                                     1028     15                 False 
PROFILES#0               設定檔                                      1028     14                 False 
PROFILES#0               設定檔                                      1028     15                 False 
PROJECTSITE#0            專案網站                                     1028     15                 False 
SGS#0                    群組工作站台                                   1028     15                 False 
SGS#0                    群組工作站台                                   1028     14                 False 
SPS#0                    SharePoint Portal Server 網站              1028     14                 False 
SPS#0                    SharePoint Portal Server 網站              1028     15                 False 
SPSCOMMU#0               社群區域範本                                   1028     14                 False 
SPSCOMMU#0               社群區域範本                                   1028     15                 False 
SPSMSITE#0               個人化網站                                    1028     14                 False 
SPSMSITE#0               個人化網站                                    1028     15                 False 
SPSMSITEHOST#0           我的網站主機                                   1028     14                 False 
SPSMSITEHOST#0           我的網站主機                                   1028     15                 False 
SPSNEWS#0                新聞網站                                     1028     15                 False 
SPSNEWS#0                新聞網站                                     1028     14                 False 
SPSNHOME#0               新聞網站                                     1028     15                 False 
SPSNHOME#0               新聞網站                                     1028     14                 False 
SPSPERS#0                SharePoint Portal Server 個人空間            1028     15                 False 
SPSPERS#0                SharePoint Portal Server 個人空間            1028     14                 False 
SPSPERS#2                具備儲存與社交功能的 SharePoint Portal Server 個人空間 1028     15                 False 
SPSPERS#3                僅具備儲存功能的 SharePoint Portal Server 個人空間   1028     15                 False 
SPSPERS#4                僅具備社交功能的 SharePoint Portal Server 個人空間   1028     15                 False 
SPSPERS#5                空的 SharePoint Portal Server 個人空間         1028     15                 False 
SPSPORTAL#0              共同作業入口網站                                 1028     15                 False 
SPSPORTAL#0              共同作業入口網站                                 1028     14                 False 
SPSREPORTCENTER#0        報告中心                                     1028     14                 False 
SPSREPORTCENTER#0        報告中心                                     1028     15                 False 
SPSSITES#0               網站目錄                                     1028     15                 False 
SPSSITES#0               網站目錄                                     1028     14                 False 
SPSTOC#0                 內容區域範本                                   1028     14                 False 
SPSTOC#0                 內容區域範本                                   1028     15                 False 
SPSTOPIC#0               主題區域範本                                   1028     14                 False 
SPSTOPIC#0               主題區域範本                                   1028     15                 False 
SRCHCEN#0                企業搜尋中心                                   1028     14                 False 
SRCHCEN#0                企業搜尋中心                                   1028     15                 False 
SRCHCENTERFAST#0         FAST Search 中心                           1028     14                 False 
SRCHCENTERLITE#0         基本搜尋中心                                   1028     14                 False 
SRCHCENTERLITE#0         基本搜尋中心                                   1028     15                 False 
SRCHCENTERLITE#1         基本搜尋中心                                   1028     14                 False 
SRCHCENTERLITE#1         基本搜尋中心                                   1028     15                 False 
STS#0                    小組網站                                     1028     15                 False 
STS#0                    小組網站                                     1028     14                 False 
STS#1                    空白網站                                     1028     15                 False 
STS#1                    空白網站                                     1028     14                 False 
STS#2                    文件工作區                                    1028     14                 False 
STS#2                    文件工作區                                    1028     15                 False 
TENANTADMIN#0            承租人管理網站                                  1028     15                 False 
TENANTADMIN#0            承租人管理網站                                  1028     14                 False 
vispr#0                  Visio 程序存放庫                              1028     15                 False 
vispr#0                  Visio 程序存放庫                              1028     14                 False 
WIKI#0                   Wiki 網站                                  1028     15                 False 
WIKI#0                   Wiki 網站                                  1028     14                 False 

 '

(Get-SPWebTemplate).count  #110  +111

Get-SPWebTemplate "STS*" # 6   -CompatibilityLevel 15

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
Get-SPServiceApplication | Select *
##  
Get-SPServiceApplication |select name, displayname,typename,id |ft -AutoSize ;
'
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
SQL Server management studio must off

下列檔案預設會安裝於本機電腦：

(1) 這包含適用於 SharePoint 2013 的 PowerPivot 方案檔  
    (伺服器陣列層級 :PowerPivotFarmSolution.WSP   :兩個檔案的範圍是網站集合層級 PowerPivotFarm14Solution.wsp & PowerPivotWebApplicationSolution.wsp)
    複製到下列資料夾：  C:\Program Files\Microsoft SQL Server\120\Tools\PowerPivotTools\SPAddinConfiguration\Resources
(2)PowerPivot for SharePoint 2013 組態工具以及用來在 SharePoint 中部署這些方案檔和設定 PowerPivot 的。
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
'
SolutionId 是相同地
 C:\Windows\system32> Get-SPSolution |ft -auto

Name                                 SolutionId                           Deployed
----                                 ----------                           --------
powerpivotfarm14solution.wsp         20556862-2287-4547-ae18-66e95a471271 False   
powerpivotfarmsolution.wsp           28201e83-6a35-4237-9ac0-4323f3d28497 False   
powerpivotwebapplicationsolution.wsp e51f7fb9-2272-4e77-a2af-7a070edd82b6 False



(tempcsd)
PS C:\Windows\system32> Get-SPSolution |ft -auto

Name                                 SolutionId                           Deployed
----                                 ----------                           --------
powerpivotfarm14solution.wsp         20556862-2287-4547-ae18-66e95a471271 False   
powerpivotfarmsolution.wsp           28201e83-6a35-4237-9ac0-4323f3d28497 False   
powerpivotwebapplicationsolution.wsp e51f7fb9-2272-4e77-a2af-7a070edd82b6 False 
'
Oct.16.2015 done
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
    

Oct.16.2015 done

#1304 (3)將 wsp 部置至管理中心
DeployWebAppSolutionToCentralAdmin $false
$solutionName='powerpivotwebapplicationsolution.wsp'
 $centralAdmin = $(Get-SPWebApplication -IncludeCentralAdministration | Where { $_.IsAdministrationWebApplication -eq $TRUE}) #|ft -AutoSize
'

DisplayName                          Url                         
-----------                          ---                         
SharePoint Central Administration v4 http://pmd2016:2013/

(tempcsd)

DisplayName                          Url                         
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
Install-SPFeature -path PowerPivotFarm -Force;
'DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PowerPivotFarm                 f8c51e81-0b46-4535-a3d5-244f63e1cab9     15                   Farm                          
'
(Get-SPFeature).count  #658

Install-SPFeature -path PowerPivotFarm -Force -CompatibilityLevel 14;
'PS C:\Windows\system32> Install-SPFeature -path PowerPivotFarm -Force -CompatibilityLevel 14


DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PowerPivotFarm                 f8c51e81-0b46-4535-a3d5-244f63e1cab9     14                   Farm                          
'
(Get-SPFeature).count  #659
Oct.16.2015 done

#  977 (5)管理中心功能

Install-SPFeature -path PowerPivotCA -Force;
'Install-SPFeature -path PowerPivotCA -Force

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


Oct.16.2015 done

#  998 (7) create  service Instance (SI)
#remember . reopen  powershell_ise  then Add-PSSnapin Microsoft.SharePoint.PowerShell again
(Get-SPServiceInstance).count  #30 + PowerPivot = 31
Get-SPServiceInstance |select Status,TypeName,DisplayName | sort TypeName #Description
Get-SPServiceInstance |select TypeName,DisplayName,status | sort TypeName  |ft -auto #Description

Get-Help '*powerpivot*' |select name , synopsis
'PS C:\Windows\system32> Get-Help *powerpivot* |select name , synopsis
Name                                                               Synopsis                                                          
----                                                               --------                                                          
Get-PowerPivotServiceApplication                                   Returns one or more PowerPivot service applications.              
Get-PowerPivotSystemService                                        Returns the global properties of the PowerPivot System Service ...
Get-PowerPivotSystemServiceInstance                                Returns one or more instances of PowerPivot System Service runn...
Set-PowerPivotServiceApplication                                   Sets the properties of a PowerPivot service application.          
Set-PowerPivotSystemService                                        Sets the global properties of the PowerPivotSystemService objec...
New-PowerPivotServiceApplication                                   Creates a new PowerPivot service application.                     
New-PowerPivotSystemServiceInstance                                Adds a new instance of PowerPivot System Service to an applicat...
Remove-PowerPivotServiceApplication                                Deletes a PowerPivot service application.                         
Remove-PowerPivotSystemServiceInstance                             Removes a PowerPivot System Service instance from the farm.       
Update-PowerPivotSystemService                                     Upgrades the parent object of the PowerPivot System Service in ...
'
Get-help new-powerpivotserviceapplication -full


Get-PowerPivotSystemServiceInstance ;'null'
(Get-spserviceinstance).count  #30
$t1=get-date
New-PowerPivotSystemServiceInstance -Provision:$true
$t2=get-date;($t2-$t1) # 2sec
(Get-spserviceinstance).count #31
Get-PowerPivotSystemServiceInstance ;
'
PS C:\Windows\system32> Get-PowerPivotSystemServiceInstance ;

TypeName                         Status   Id                                  
--------                         ------   --                                  
SQL Server PowerPivot 系統服務       Online   9a5eb723-532a-49e9-895c-bd84f36cbfbe
(tempcsd)
PS C:\Windows\system32> Get-PowerPivotSystemServiceInstance

TypeName                         Status   Id                                  
--------                         ------   --                                  
SQL Server PowerPivot 系統服務       Online   f824a789-f02b-4c88-aa22-b432812c3cdc'

Get-PowerPivotSystemServiceInstance |select *

Get-PowerPivotSystemService 
'PS C:\Windows\system32> Get-PowerPivotSystemService 


CurrentSolutionVersion         : 12.0.2468.0
DirectTCPConnections           : False
DiagnosticTraceLimit           : 20
DiagnosticTraceIntervalSeconds : 10
CanUpgrade                     : True
TypeName                       : SQL Server PowerPivot Service Application
Instances                      : {}
Applications                   : {}
Required                       : False
JobDefinitions                 : {PowerPivot Dashboard Processing Timer Job, PowerPivot Data Refresh Timer Job, PowerPivot Health Sta
                                 tistics Collector Timer Job, 每日-any-midtierservice-health-analysis-job...}
RunningJobs                    : {}
JobHistoryEntries              : {, , , ...}
IsBackwardsCompatible          : True
NeedsUpgradeIncludeChildren    : True
NeedsUpgrade                   : True
UpgradeContext                 : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                           : 
DisplayName                    : 
Id                             : d4ea83e0-a609-4e99-8794-2bafd967e129
Status                         : Online
Parent                         : SPFarm Name=_ConfigDB
Version                        : 12158
Properties                     : {}
Farm                           : SPFarm Name=_ConfigDB
UpgradedPersistedProperties    : {}
'

Get-PowerPivotServiceApplication
'Null'


#-Remove-PowerPivotSystemServiceInstance
Oct.16.2015 done

#  1019 (8) 建立 PowerPivot SA
get-spserviceapplication;
'DisplayName          TypeName             Id                                  
-----------          --------             --                                  
ExcelServiceM        Excel Services 應用... 56d693a1-e399-4605-8109-08730467ccc2
Security Token Se... Security Token Se... 1a88193f-2f77-48f7-a276-19a3c70baa16
Application Disco... Application Disco... 84044cab-bf1d-4c31-8897-35e99c777359
WSS_UsageApplication Usage and Health ... af8fc817-284b-4d6f-be82-d7d5a310bd97
'

New-PowerPivotServiceApplication -ServiceApplicationName 'PowerPivot Service ApplicationM' `
-DatabaseServerName 'SPFarmSQL' -DatabaseName 'PowerPivotServiceApplicationDB' -AddToDefaultProxyGroup:$true
'A PowerPivot service application was created successfully'
#New-PowerPivotServiceApplication -ServiceApplicationName "PowerPivot Service Application"
# -DatabaseServerName "AdvWorks-SRV01\PowerPivot" -DatabaseName "PowerPivotServiceApp1" -AddtoDefaultProxyGroup:$true

get-spserviceapplication |ft -AutoSize
'PS C:\Windows\system32> get-spserviceapplication

DisplayName          TypeName             Id                                  
-----------          --------             --                                  
ExcelServiceM                          Excel Services 應用...   52109a27-ec54-4644-bd28-fc9caf960d4c
PowerPivot Service ApplicationM        PowerPivot 服務應用程式   586e8621-1352-4b43-b6cd-cc987980a660
Security Token Service Application     Security Token Se...    04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application    dd30c213-b5ac-4eb1-ac2c-762102e7dccd
WSS_UsageApplication                   Usage and Health ...    7288de1d-531d-4025-9e41-43dd357a03d6
'

Get-spserviceapplication -Identity 586e8621-1352-4b43-b6cd-cc987980a660 |select *
Oct.16.2015 done


#  1036 (9)   PowerPivot 系統服務物件的全域屬性。
Get-PowerPivotSystemService |select * ;
'PS C:\Windows\system32> Get-PowerPivotSystemService
CurrentSolutionVersion         : 12.0.2468.0
DirectTCPConnections           : False
DiagnosticTraceLimit           : 20
DiagnosticTraceIntervalSeconds : 10
CanUpgrade                     : True
TypeName                       : SQL Server PowerPivot Service Application
Instances                      : {}
Applications                   : {PowerPivot Service ApplicationM}
Required                       : False
JobDefinitions                 : {PowerPivot Dashboard Processing Timer Job
                                 , PowerPivot Data Refresh Timer Job
                                 , PowerPivot Health Statistics Collector Timer Job
                                 , 每日-any-midtierservice-health-analysis-job...}
RunningJobs                    : {}
JobHistoryEntries              : {, , , ...}
IsBackwardsCompatible          : True
NeedsUpgradeIncludeChildren    : True
NeedsUpgrade                   : True
UpgradeContext                 : Microsoft.SharePoint.Upgrade.SPUpgradeContext
Name                           : 
DisplayName                    : 
Id                             : d4ea83e0-a609-4e99-8794-2bafd967e129
Status                         : Online
Parent                         : SPFarm Name=_ConfigDB
Version                        : 12158
Properties                     : {}
Farm                           : SPFarm Name=_ConfigDB
UpgradedPersistedProperties    : {}
'
Set-PowerPivotSystemService -Confirm:$false;
'PS C:\Windows\system32>Set-PowerPivotSystemService -Confirm:$false
PowerPivot system service instance was successfully updated'圾

ssms
Oct.16.2015 done


#(10)  1072 建立 WA
$env:USERDNSDOMAIN  #PMOCSD.SYSCOM.COM
#CreateWebApplication 'PowerPivot- 80' 'http://pp.tempcsd.syscom' 'BIApplicationPool' 'TEMPCSD\spService' $password 'SPFarmSQLAlias' 'PowerPivotWebApplicationDB'
$name      ='PowerPivot- 80'
$url       ='http://pp.pmocsd.syscom.com'
$appPool   ='BIApplicationPool'
$appAccount='PMOCSD\spService'
$appAccountPassword ='p@ssw0rd'
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
'
DisplayName                    Url                                               
-----------                    ---                                               
PowerPivot- 80                 http://pp.pmocsd.syscom.com/                      

ping pp.pmocsd.syscom.com

DisplayName                    Url                                               
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

(get-spfeature).count  #662
(get-spfeature  -farm).count  #73
(get-spfeature  | ? scope -EQ Site ).count  #215
(get-spfeature  | ? scope -EQ Site ).count  #215
(get-spfeature  | ? scope -EQ web ).count  #281
(get-spfeature  | ? scope -EQ webapplication ).count  #35


get-spfeature  | ? scope -EQ web | sort displayname 
get-spfeature  | ? scope -EQ Site | sort displayname 


get-spfeature  |  sort displayname 
Oct.16.2015 done

#(11)  1116 部署 WA Solution  & Install-SPSolution to  DeployWebAppSolution
DeployWebAppSolution 'http://pp.tempcsd.syscom' 2047 $false
   
   DNS :create pp.pmocsd.syscom.com to IP

   $url='http://pp.pmocsd.syscom.com' 
   $targetWebApp = Get-SPWebApplication  $url -ErrorAction:SilentlyContinue
   $targetWebApp.MaximumFileSize  # 250
   $targetWebApp.MaximumFileSize = 2047 # 將250M 改成 2G Size
   $targetWebApp.Update()
   $targetWebApp.MaximumFileSize  # 2047

   $targetWebApp |select * 

   Install-SPSolution -Identity powerpivotwebapplicationsolution.wsp –CompatibilityLevel NewVersion -GACDeployment -Force `
   -WebApplication $targetWebApp -FullTrustBinDeployment

   UI:用程式管理 > 管理 Web 應用程式  http://localhost:2013/_admin/WebApplicationList.aspx


     網站設定 : 網站集合功能          http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site
                                   
                            http://pp.pmocsd.syscom.com/_layouts/15/ManageFeatures.aspx?Scope=Site(網站集合功能)
                            http://pp.pmocsd.syscom.com/_layouts/15/ManageFeatures.aspx  (網站功能)
                            

get-spfeature -Site $url #-  (get-spfeature -Site $url).count  30
get-spfeature -web $url
get-spfeature -Site http://localhost:2013

Oct.16.2015 done

#  1131 (12)建立網站集合 SiteCollection

Get-SPSite;'Null'

$w = Get-SPWebApplication $url

New-SPSite -Url 'http://pp.pmocsd.syscom.com' -OwnerEmail 'infra1@pmocsd.syscom.com' -OwnerAlias 'pmoCSD\spadmin' `
-SecondaryOwnerAlias 'pmoCSD\infra1' -Template 'PowerPivot#0' -Name  'PowerPivot Site create by Oct.13.2015'

#OwnerEmail 驗證必須是 .com
#-HostHeaderWebApplication $w  原沒有,後行自已增加之

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


get-spsite $url |select *
((get-spsite $url).Features).count
((get-spsite $urladm).Features).count

get-spsite $url |select *


Oct.16.2015 done

#  1164 (13) 啟用 sitecollection  feature
EnableSiteFeatures 'http://pp.pmocsd.syscom.com' $true

$url='http://pp.pmocsd.syscom.com'
    param($url, $enablePremiumFeature)

    get-spfeature -Identity "8581A8A7-CF16-4770-AC54-260265DDB0B2" 
    get-spfeature -Identity PremiumSite
    ;
'
DisplayName                    Id                                       CompatibilityLevel   Scope                         
-----------                    --                                       ------------------   -----                         
PremiumSite                    8581a8a7-cf16-4770-ac54-260265ddb0b2     15                   Site                          
SharePoint Server 企業版網站集合功能  id 好像是固定的...

'

    $premiumFeature = "8581A8A7-CF16-4770-AC54-260265DDB0B2"

    get-spfeature -Identity "PowerPivotSite"    |select *
    Enable-SPFeature  -identity "powerpivotsite" -URL $url

    # Enable-SPFeature -Identity "PowerPivotSiteCollection" -URL $url -Force

	Enable-SPFeature  -Identity "PremiumWeb" -URL $url -Force #開啟此網站 PowerPivot 功能整合
    disable-SPFeature -Identity "PremiumWeb" -URL $url -Force  -Confirm:$false #開啟此網站之下 網站集合的 PowerPivot 功能整合
	
    Enable-SPFeature -Identity "PowerPivotSite" -URL $url -Force #開啟此網站之下 網站集合的 PowerPivot 功能整合

    if($enablePremiumFeature)
    {
        $site = Get-SPSite $url
        if($site.Features[$premiumFeature] -eq $null)
        {
            Enable-SPFeature -Identity PremiumSite -URL $url -Force #也開啟此網站之下 SharePoint Server 企業版網站集合功能
        }

        $site.Dispose()
    }

Oct.16.2015 done


#  1197 (14) 啟用 windows Token 服務
 StartService ="Microsoft.SharePoint.Administration.Claims.SPWindowsTokenServiceInstance"

$serviceType="Microsoft.SharePoint.Administration.Claims.SPWindowsTokenServiceInstance"
Get-SPServiceInstance |select typename,id,status |sort typename
Get-SPServiceInstance | ? typename -eq '對 Windows Token 服務的宣告'  |select * ;

'

PS C:\Windows\system32> Get-SPServiceInstance | ? typename -eq 對 Windows Token 服務的宣告 |select * ;


Description                 : 允許 Windows 使用者透過宣告驗證登入，從宣告身分識別轉換回原始的 Windows 身分識別。
TypeName                    : 對 Windows Token 服務的宣告
DisplayName                 : 對 Windows Token 服務的宣告
Server                      : SPServer Name=PMD2016
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
Id                          : d536526e-968c-48b9-aebe-725be09b9672
Status                      : Disabled
Parent                      : SPServer Name=PMD2016
Version                     : 6094
Properties                  : {}
Farm                        : SPFarm Name=_ConfigDB
UpgradedPersistedProperties : {}



(tempcsd)
PS C:\Windows\system32> Get-SPServiceInstance | ? typename -eq 對 Windows Token 服務的宣告 |select * 

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

Oct.19.2015 done

# 1241 (15)  啟動 Secure Store Service SI
StartSecureStoreService

### Constants
	$serviceName = "SecureStoreService"
	
	### make sure secure store service is started
	$serviceInstances = Get-spserviceinstance | ? {$_.Service -match $serviceName} ;


'PS C:\Windows\system32> get-spserviceinstance | ? {$_.Service -match $serviceName} |select  * 
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
			"Started service......"
		}
		else {"Service Instance is online"}
	} 

   $serviceInstances.Status

(Get-SPServiceInstance | ? typename -eq '對 Windows Token 服務的宣告').status  #online
(Get-SPServiceInstance | ? TypeName -eq "Secure Store Service" ).status      #online
  
Oct.19.2015 done


#  1291(16)  啟動 Secure Store Service SA
CreateSecureStoreApplicationService 'SPFarmSQL' 'Secure Store Service'

	$DbServerAddress="SPFarmSQL"
　　 $ServiceApplicationName="Secure Store ServiceM" 
	
### Constants
	$serviceName = "SecureStoreService"
	#$dbName = $serviceName + "_" + [System.Guid]::NewGuid().ToString("N") 
	$dbName = "SecureStoreSADB" 

	### Retrieve secure store service application
	$serviceapp = Get-SPServiceApplication | where {$_.DisplayName -eq $ServiceApplicationName}
	#$serviceapp | remove-SPServiceApplication
    
    $serviceappProxy = Get-SPServiceApplicationproxy | where {$_.DisplayName -eq $proxyName}
    #$serviceappProxy | remove-spserviceapplicationproxy -Confirm:$false

	$pool = Get-SPServiceApplicationPool | where {$_ -match "BIapplicationPool"}
	
	### Only create service application if it doesn't exist already
	get-SpServiceApplication |ft -AutoSize;
'
=http://localhost:2013/_admin/ServiceApplications.aspx

PS C:\Windows\system32> 	get-SpServiceApplication |ft -AutoSize;

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                       52109a27-ec54-4644-bd28-fc9caf960d4c
PowerPivot Service ApplicationM                             PowerPivot 服務應用程式                                       586e8621-1352-4b43-b6cd-cc987980a660
Security Token Service Application                          Security Token Service Application                          04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application dd30c213-b5ac-4eb1-ac2c-762102e7dccd
WSS_UsageApplication                                        Usage and Health Data Collection Service 應用程式            7288de1d-531d-4025-9e41-43dd357a03d6

(tempcsd)
PS C:\Windows\system32> 	get-SpServiceApplication|ft -a;

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

'
New-SPSecureStoreServiceApplication : 計時器工作已完成，但在伺服器陣列中的一或多個機器上失敗。 (((最後是刪除後再重建即可)))
                                      The time job created.  But failed to start in one or more servers in the farm
位於 線路:4 字元:3
+         New-SPSecureStoreServiceApplication -Name $ServiceApplicationName -partitionmo ...
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidData: (Microsoft.Offic...viceApplication:SPNewSecureStoreServiceApplication) [New-SPSecureStoreServiceApplication]，SPException
    + FullyQualifiedErrorId : Microsoft.Office.SecureStoreService.PowerShellCmdlet.SPNewSecureStoreServiceApplication

https://technet.microsoft.com/zh-tw/library/ee906549.aspx    

#http://sharepointsol.blogspot.tw/2014/11/creation-of-secure-store-service.html
Delete the Secure Store Service Application.

$proxy = Get-SPServiceApplicationProxy | where {$_.TypeName -eq "Secure Store Service Application Proxy"}
$proxy.Status = "Online"
$proxy.Update()

    
'

Get-SPServiceApplication | where {$_.DisplayName -eq $ServiceApplicationName} |select *

Get-SpServiceApplication |ft -a ;

'http://localhost:2013/_admin/ServiceApplications.aspx

PS C:\Windows\system32> get-SpServiceApplication |ft -a

DisplayName                                                 TypeName                                                    Id                                  
-----------                                                 --------                                                    --                                  
Secure Store ServiceM                                       Secure Store Service Application                            26bd7cd8-d686-4bff-ae9b-6ed2c5042ed1
ExcelServiceM                                               Excel Services 應用程式 Web 服務應用程式                              52109a27-ec54-4644-bd28-fc9caf960d4c
PowerPivot Service ApplicationM                             PowerPivot 服務應用程式                                           586e8621-1352-4b43-b6cd-cc987980a660
Security Token Service Application                          Security Token Service Application                          04db5fdc-25e5-4d7d-b475-920fd5e00efa
Application Discovery and Load Balancer Service Application Application Discovery and Load Balancer Service Application dd30c213-b5ac-4eb1-ac2c-762102e7dccd
WSS_UsageApplication                                        Usage and Health Data Collection Service 應用程式               7288de1d-531d-4025-9e41-43dd357a03d6
'

IE:  此時已可以連入 http://pp.tempcsd.syscom/SitePages/%E9%A6%96%E9%A0%81.aspx
http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site     #此為 centraladmin  網站設定 : 網站集合功能
http://pp.tempcsd.syscom/_layouts/15/ManageFeatures.aspx?Scope=Site  #此為 pp.tempcsd.syscom  網站設定 : 網站集合功能

Oct.19.2015 done

     
#1717 (17)  啟動 Secure Store Service SA Proxy
CreateSecureStoreApplicationServiceProxy 'Secure Store Service' 'Secure Store Proxy'

$serviceApplicationName='Secure Store ServiceM'
$proxyName='Secure Store ProxyM'
	
Get-SPServiceApplicationProxy |ft -a ;
' Get-SPServiceApplicationProxy |ft -a 
DisplayName                                                                                            TypeName                                                    Id    
-----------                                                                                            --------                                                    --    
PowerPivot Service ApplicationM                                                                        PowerPivot 服務應用程式 Proxy                                     f04...
Application Discovery and Load Balancer Service Application Proxy_dd30c213-b5ac-4eb1-ac2c-762102e7dccd Application Discovery and Load Balancer Service 應用程式  Proxy bfd...
ExcelServiceM                                                                                          Excel Services 應用程式 Web 服務應用程式 Proxy                        e91...
WSS_UsageApplication                                                                                   Usage and Health Data Collection Proxy                      1b6...

'

	### Retrieve secure store service application proxy
	$proxy = Get-SPServiceApplicationProxy | where {$_.DisplayName -eq $proxyName};'null'

	### Only create application proxy if it doesn't exist already
	if(!$proxy)
	{
		### Retrieve secure store service application
		$serviceapp = Get-SPServiceApplication | where {$_.DisplayName -eq $serviceApplicationName} #|ft -AutoSize
	'
$serviceapp

DisplayName           TypeName                         Id                                  
-----------           --------                         --                                  
Secure Store ServiceM Secure Store Service Application 26bd7cd8-d686-4bff-ae9b-6ed2c5042ed1'
		### Add Secure Store Service Proxy
		$serviceapp | New-SPSecureStoreServiceApplicationProxy -defaultproxygroup:$true -name $proxyName 
	}
	else { throw "The secure store service application proxy already exists"}
Get-SPServiceApplicationProxy |select  displayname,id |ft -a

Get-SPServiceApplicationProxy   f586d0f3-0946-459a-99f1-b6e839befbe6  |select *
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

Oct.19.2015 done


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

$proxyName='Secure Store ProxyM'
#$proxyName ='SecureStoreServiceApplicationProxy_2d9b4480-8b0a-4f0f-a1f7-319058e6f665'
$farmPassPhrase='pass@word1'
$farmPassPhrase='p@ssw0rdx'


		
	### Retrieve secure store service application proxy
	$proxy = Get-SPServiceApplicationProxy | ? {$_.DisplayName -eq $proxyName}
$proxy |select *
# http://localhost:2013/_admin/sssvc/ManageSSSvcApplication.aspx?AppId=f586d0f3-0946-459a-99f1-b6e839befbe6
	
		Update-SPSecureStoreMasterKey -ServiceApplicationProxy $proxy -Passphrase $farmPassPhrase
		start-sleep -s 60
		
		Update-SPSecureStoreApplicationServerKey -ServiceApplicationProxy $proxy -Passphrase $farmPassPhrase
		start-sleep -s 60

        WaitForMasterKeyPropagation

  Oct.20.2015 done

#1819 (19)  
CreateUnattendedAccountForDataRefresh 
$siteUrl='http://pp.pmocsd.syscom.com' 
$individualAppID='PowerPivotUnattendedAccount' 
'PowerPivot Unattended Account for Data Refresh' 
'TEMPCSD\infra1' 
$password 

	param($siteUrl, $individualAppID, $individualFriendlyName, $unattendedAccountUser,$unattendedAccountPwdSecureString)
		
	### Setup Individual ID
	### get context
	"Obtaining service context for Url: ($siteUrl)"
    $siteUrl="http://pp.pmocsd.syscom.com"
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
#    排程資料重新整理 (PowerPivot for SharePoint)
#------------------------------------https://msdn.microsoft.com/zh-tw/library/ee210651(v=sql.120).aspx#------------------------------------
#   3317  設定 PowerPivot 無人看管的資料重新整理帳戶 (PowerPivot for SharePoint)
#------------------------------------https://msdn.microsoft.com/en-us/library/ff773327(v=sql.120).aspxConfigure the PowerPivot Unattended Data Refresh Account (PowerPivot for SharePoint)Step 1: Create a target application and set the credentials  建立目標應用程式並設定認證
Step 2: Specify the unattended account in PowerPivot server configuration pages  在 PowerPivot 伺服器組態頁面中，指定無人看管的帳戶
Step 3: Grant contribute permissions to the account  授與參與權限給帳戶
Step 4: Grant read permissions to access external data sources used in data refresh 授與資料重新整理期間存取外部資料來源時所需的讀取權限
Step 5: Verify account availability in data refresh configuration pages  在資料重新整理組態頁面中，確認帳戶可用性
Using the PowerPivot Unattended Data Refresh Account  使用 PowerPivot 無人看管的資料重新整理帳戶
Update the credentials used by an existing PowerPivot unattended data refresh account  更新現有 PowerPivot 無人看管的資料重新整理帳戶所使用的認證http://localhost:2013/_admin/ServiceApplications.aspxhttp://localhost:2013/_admin/sssvc/ManageSSSvcApplication.aspx?AppId=f586d0f3-0946-459a-99f1-b6e839befbe6Step 1: Create a target application and set the credentials  建立目標應用程式並設定認證
Step 2: Specify the unattended account in PowerPivot server configuration pages  在 PowerPivot 伺服器組態頁面中，指定無人看管的帳戶
Step 3: Grant contribute permissions to the account  授與參與權限給帳戶
Step 4: Grant read permissions to access external data sources used in data refresh 授與資料重新整理期間存取外部資料來源時所需的讀取權限
Step 5: Verify account availability in data refresh configuration pages  在資料重新整理組態頁面中，確認帳戶可用性
Using the PowerPivot Unattended Data Refresh Account  使用 PowerPivot 無人看管的資料重新整理帳戶
Update the credentials used by an existing PowerPivot unattended data refresh account  更新現有 PowerPivot 無人看管的資料重新整理帳戶所使用的認證Get-ModuleCreateUnattendedAccountForDataRefresh 
$siteUrl='http://pp.pmocsd.syscom.com' 
'PowerPivotUnattendedAccount' 
'PowerPivot Unattended Account for Data Refresh' 
'PMOCSD\infra1' 
$password 


Function CreateUnattendedAccountForDataRefresh
{
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
}