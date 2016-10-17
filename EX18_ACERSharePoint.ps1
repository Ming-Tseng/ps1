<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX18_ACERSharePoint.ps1
EX18_ACERSharePoint-AP1


relation 
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SP07_SP13BackupRestore.ps1


#>

install source : 
EX18_ACERSharePoint


sql2014x  (AP1)   installor: csd\infrax  全新安裝  sp2013 (db1\MSQLSQLSERVER) 
sp2013wfe (AP2)    己安裝 昇級至SP1   sp2013 (db1\i2)



sql2014x  (AP1)   installor: csd\infrax  全新安裝  sp2013 (db1\MSQLSQLSERVER)  C:\Users\infrax\Documents\EX18_ACERSharePoint-AP1.ps1  
sp2013wfe (AP2)    己安裝 昇級至SP1   start-process  D:\software2015\officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe   
 sp2013 (db1\i2)




gsv *sql*
ping  172.16.220.193
ping  172.16.220.194

#--------------------------------------------------------
#   sql2014x (61)  using  infrax
#--------------------------------------------------------
installer user: csd\infrax
configure user: csd\infrax
whoami  whoami  #csd\infrax
add infra  remote login & localadministrator   lusrmgr.msc
$SharePoint2013Path ="H:\software2015\SP2103software"

using wizard install  or . H:\software2015\SP2103software\setup.exe

shutdown -r -f
#----  執行將 SHARTPOINT2013 上到SP1

start-process  h:\software2015\officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe 

#----  
Add-PSSnapin Microsoft.SharePoint.PowerShell  #  未有NewFarm 也是可以 ASNP
gsnp
'
PS C:\Windows\system32> GSNP


Name        : Microsoft.PowerShell.Core
PSVersion   : 4.0
Description : 

Name        : Microsoft.SharePoint.PowerShell
PSVersion   : 1.0
Description : Register all administration Cmdlets for Microsoft SharePoint Server'

#----設定
$AliasName = "SPFarmSQL"

Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

#----將安裝者加入資料庫SA

add  infrax to sql sa

#----設定 資料庫名稱,連接port
$AliasName = "SPFarmSQL"
$DatabaseServer = $AliasName  ; #SPecify the instance name if SQL is not installed on default instance$FarmName = Hostname#$FarmName = $ServerName ; #Hostname$ConfigDB = $FarmName+"_ConfigDB";  #SharePoint_Config61#$ConfigDB = $FarmName+"_ConfigDB";  SharePoint_Config61$AdminContentDB = $FarmName+"_CentralAdminContent";$Passphrase = convertto-securestring "p@ssw0rdx" -asplaintext -force;$Port = "2013";$Authentication = "NTLM";#$FarmAccount = "tempcsd\spFarm"
#--設定好密碼
$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "csd\infrax",$secpasswd
#---- 新增"設定資料庫"
New-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer `-FarmCredentials (Get-Credential $credential) -Passphrase $Passphrase `-AdministrationContentDatabaseName $AdminContentDB
#--- 檢查是否有成功

$farm = Get-SPFarm
if (!$farm -or $farm.Status -ne "Online") {
    Write-Output "Farm was not created or is not running"
    exit
}

#--- 設定 連接port
$Port = "2013";$Authentication = "NTLM";#--- 建立管理網站$t1=get-dateNew-SPCentralAdministration -Port $Port -WindowsAuthProvider 'NTLM'$t2=get-date; $t2-$t1 #2min,15 sec(tempcsd)  ,1 min 33 (PMP2016)

#---檢查管理網站 URL 及登入Get-SPWebApplication -IncludeCentralAdministration  #http://sql2012x:2013/inetmgr # can see  "SharePoint Central Administration v4"可以登入 http://localhost:2013/ (remember: infrax, p@ssw0rd 才是管理帳號)

#---其它的服務及功能的安裝


Install-SPHelpCollection -All
Initialize-SPResourceSecurity
Install-SPService
Install-SPFeature -AllExistingFeatures
Install-SPApplicationContent



#----新建 WebApplication 也一併建定applicationPool(用inetgmgr 才可以看到)
Get-SPWebApplication;'Null'

  get-SPServiceApplicationPool$env:USERDNSDOMAIN  #CSD.SYSCOM
#CreateWebApplication 'PowerPivot- 80' 'http://pp.tempcsd.syscom' 'BIApplicationPool' 'TEMPCSD\spService' $password 'SPFarmSQLAlias' 'PowerPivotWebApplicationDB'
$name      ='AP1-80'
$url       ='http://ap1.csd.syscom'
$appPool   ='sql2012xApplicationPool'
$appAccount='csd\infrax'
$appAccountPassword ='p@ssw0rd'
$dbServer  ='SPFarmSQL'
$dbName    ='WSS_Contentap1'

$appPoolManagedAccount = Get-SPManagedAccount $appAccount -ErrorAction:SilentlyContinue
#$appPoolManagedAccount = Get-SPManagedAccount 'csd\infrax' -ErrorAction:SilentlyContinue

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
AP1-80                         http://ap1.csd.syscom/                            
                       
'
iisreset
Get-SPWebApplication;
'
PS C:\Windows\system32>     Get-SPWebApplication;

DisplayName                    Url                                               
-----------                    ---                                               
AP1-80                         http://ap1.csd.syscom/'

#----找一個網路範本
   Get-SPWebTemplate 此例是找
   SPS#0                SharePoint Portal Server 網站              1028       14                   False 
   常用有
   STS#0                小組網站                                     1028       14                   False  
    
#----新建 SiteCollection 


New-SPSite -Url $url  -OwnerEmail 'infrax@csd.syscom' -OwnerAlias 'csd\infrax' `
-SecondaryOwnerAlias 'csd\infra1' -Template 'SPS#0' -Name  'JUL.06.2016 for acer  SP backupRestore Lab'


get-spwebapplication  |select name,id,status ,Farm,url

'Name   : AP1-80
Id     : 2791412b-eb99-4c30-ac75-9f867c964495
Status : Online
Farm   : SPFarm Name=SQL2012X_ConfigDB
Url    : http://ap1.csd.syscom/
'

#-- 接下來進行 演練

ping ap1.csd.syscom
ping ap2.csd.syscom
ping ap3.csd.syscom
#--------------------------------------------------------
#   193    check sharepoint product  using  infray
#--------------------------------------------------------
{<#
installer user: csd\administrator
configure user: csd\infray   ( at AD , enterprise admins )

ping sp2013wfe
sp2013wfe (AP2)     ---> sp2013 (db1\i2)   SP2013,1438
wf.msc  open 1438

gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
start-process  C:\software2015\officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe 
'PS C:\Windows\system32> gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name

name                                                                                 Version                                                                             
----                                                                                 -------                                                                             
Microsoft SharePoint Foundation 2013 1028 Lang Pack                                  15.0.4571.1502                                                                      
Microsoft SharePoint Foundation 2013 1028 SQL Express                                15.0.4571.1502                                                                      
Microsoft SharePoint Foundation 2013 Core                                            15.0.4571.1502                                                                      
Microsoft SharePoint Multilingual Solutions                                          15.0.4571.1502                                                                      
Microsoft SharePoint Multilingual Solutions Chinese (Traditional) Language Pack      15.0.4571.1502                                                                      
Microsoft SharePoint Portal                                                          15.0.4571.1502                                                                      
Microsoft SharePoint Portal Chinese (Traditional) Language Pack                      15.0.4571.1502                                                                      
Microsoft SharePoint Server 2013                                                     15.0.4571.1502                                                                      
PerformancePoint Services for SharePoint                                             15.0.4571.1502                                                                      
PerformancePoint Services in SharePoint 1028 Language Pack                           15.0.4571.1502    '

gsv| ?{$_.DisplayName -like '*SharePoint*'} |ft -AutoSize
{PS C:\Windows\system32> gsv| ?{$_.DisplayName -like '*SharePoint*'} |ft -AutoSize

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
}

Add-PSSnapin Microsoft.SharePoint.PowerShell
ASNP Microsoft.SharePoint.Powershell  #


use winzard      account   csd\infray db   SPFarmSQL   db    SharePoint_Config193  , password= p@ssw0rd  ,port 2013    step 10

dns 
#Ap1.csd.syscom    172.16.220.61
Ap2.csd.syscom    172.16.220.193  : team template , primary infray  secondary infra1


'
PS C:\Windows\system32> get-spserver 

Address             
-------             
SP2013WFE           
SPFarmSQL    
'
#>}



#----------------------------------------------------------------#  phase 0   first  before backup  farm configuration #----------------------------------------------------------------{<#

whoami # csd\infray
add-pssnapin WebAdministration
Add-PSSnapin Microsoft.SharePoint.PowerShell 

GSNP
'
PS C:\Windows\system32> GSNP

Name        : Microsoft.PowerShell.Core
PSVersion   : 4.0
Description : 

Name        : Microsoft.SharePoint.PowerShell
PSVersion   : 1.0
Description : Register all administration Cmdlets for Microsoft SharePoint Server

'

#--applicationpool
Get-SPServiceApplicationPool
'

61
PS C:\Windows\system32> Get-SPServiceApplicationPool

Name                                     ProcessAccountName                                                                                                              
----                                     ------------------                                                                                                              
SecurityTokenServiceApplicationPool      CSD\infrax                                                                                                                      
SharePoint Web Services System           CSD\infrax                                                                                                                      

193
PS C:\Windows\system32> Get-SPServiceApplicationPool

Name                                     ProcessAccountName                                                                                                              
----                                     ------------------                                                                                                              
SecurityTokenServiceApplicationPool      CSD\infrax                                                                                                                      
SharePoint Web Services System           CSD\infrax                                                                                                                      

'

#-- IIS inetmgr appliationPool
get-WmiObject -Namespace "root\WebAdministration" -Class Site -Authentication PacketPrivacy -ComputerName . 
get-WmiObject -Namespace "root\WebAdministration" -Class Site -Authentication PacketPrivacy -ComputerName .  |select name ,__path
'
61name                                                                                 __PATH                                                                              
----                                                                                 ------                                                                              
Default Web Site                                                                     \\SQL2012X\root\WebAdministration:Site.Name="Default Web Site"                      
SharePoint Web Services                                                              \\SQL2012X\root\WebAdministration:Site.Name="SharePoint Web Services"               
SharePoint Central Administration v4                                                 \\SQL2012X\root\WebAdministration:Site.Name="SharePoint Central Administration v4"  
AP1-80                                                                               \\SQL2012X\root\WebAdministration:Site.Name="AP1-80"   

^v^v

`193
PS C:\Windows\system32> get-WmiObject -Namespace "root\WebAdministration" -Class Site -Authentication PacketPrivacy -ComputerName .  |select name ,__path

name                                                                                 __PATH                                                                              
----                                                                                 ------                                                                              
Default Web Site                                                                     \\SP2013WFE\root\WebAdministration:Site.Name="Default Web Site"                     
SharePoint Web Services                                                              \\SP2013WFE\root\WebAdministration:Site.Name="SharePoint Web Services"              
SharePoint Central Administration v4                                                 \\SP2013WFE\root\WebAdministration:Site.Name="SharePoint Central Administration v4" 

                             
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
^v^v
193
PS C:\Windows\system32> get-website 

Name             ID   State      Physical Path                  Bindings                                                                                                 
----             --   -----      -------------                  --------                                                                                                 
Default Web Site 1    Started    %SystemDrive%\inetpub\wwwroot  http *:80:                                                                                               
                                                                net.tcp 808:*                                                                                            
                                                                net.pipe *                                                                                               
SharePoint Web S 2    Started    C:\Program Files\Common Files\ http *:32843:                                                                                            
ervices                          Microsoft Shared\Web Server Ex https *:32844: sslFlags=0                                                                                
                                 tensions\15\WebServices\Root   net.tcp 32845:*                                                                                          
                                                                net.pipe *                                                                                               
SharePoint Centr 7461 Started    C:\inetpub\wwwroot\wss\Virtual http :2013:                                                                                              
al Administratio 6964            Directories\45983                                                                                                                       
n v4             4      

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


^v^v
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


----------------------^v^v------------------

193

PS C:\Windows\system32> get-SPManagedAccount

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

----------------------^v^v------------------
193



PS C:\Windows\system32> get-spdatabase

Name                     Id                                   Type                
----                     --                                   ----                
SQL2012X_ConfigDB        6814fe44-fb5d-453f-bf95-5dfd294374e7 設定資料庫               
SQL2012X_CentralAdmin... 579b53fd-3803-4073-949b-8b8263a2e5a3 內容資料庫 

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

----------------------^v^v------------------
193  is NULL


'
#-- spserver
get-spserver
'
61 Address             
-------             
SPFarmSQL           
SQL2012X 
----------------------^v^v------------------
193
Address             
-------             
SP2013WFE           
SPFarmSQL
'

#-- spfarm
get-spfarm
'
61Name                                                    Status                   
----                                                    ------                   
SQL2012X_ConfigDB                                       Online  
----------------------^v^v------------------
193  
PS C:\Windows\system32> get-spfarm

Name                                                    Status                   
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

----------------------^v^v------------------
193  
DisplayName                    Url                                               
-----------                    ---                                               
SharePoint Central Administ... http://sp2013wfe:2013/ 
'


#--   SPFeature).count
(get-SPFeature).count

'
61 :657

193:60'

#--   SPWebApplication
Get-SPWebApplication
'
DisplayName                    Url                                               
-----------                    ---                                               
AP1-80                         http://ap1.csd.syscom/  

193:null
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

193:null

'
#>}

$AliasName = "SPFarmSQL" ;$DatabaseServer = $AliasName  ; #SPecify the instance name if SQL is not installed on default instance$ConfigDB  ='SQL2012X_ConfigDB' 
$backupSPConfigurationDatabase='H:\sharepointbackup\SPConfigurationDatabase'; 
$backupSPConfigurationDatabase='\\SQL2012X\SPConfigurationDatabase'
ii $backupSPConfigurationDatabase
if ( (test-path $backupSPConfigurationDatabase) -eq $false) { md  $backupSPConfigurationDatabase  }


#run at 61
Backup-SPConfigurationDatabase -Directory $backupSPConfigurationDatabase  -DatabaseServer $DatabaseServer `
-DatabaseName $ConfigDB  # -DatabaseCredentials <WindowsPowerShellCredentialObject> [-Verbose]
Get-SPBackupHistory  -Directory $backupSPConfigurationDatabase

#run at 193
Restore-SPFarm -Directory $backupSPConfigurationDatabase  -RestoreMethod Overwrite -ConfigurationOnly -Confirm:$false -Force






#--------------------------------------------------------
#   phase 1    backup Restore farm configurations  using SPConfigurationDatabase
#--------------------------------------------------------

http://sp2013wfe:2013/_layouts/15/people.aspx?MembershipGroupId=3  #  use have BUILTIN\Administrators ,infrax. infray 
http://sql2012x:2013/_layouts/15/people.aspx?MembershipGroupId=3   #  use have BUILTIN\Administrators ,infrax ,infra1

 



$AliasName = "SPFarmSQL" ;$DatabaseServer = $AliasName  ; #SPecify the instance name if SQL is not installed on default instance$ConfigDB  ='SQL2012X_ConfigDB' 
$backupSPConfigurationDatabase='H:\sharepointbackup\SPConfigurationDatabase'; 
$backupSPConfigurationDatabase='\\SQL2012X\SPConfigurationDatabase'
ii $backupSPConfigurationDatabase
if ( (test-path $backupSPConfigurationDatabase) -eq $false) { md  $backupSPConfigurationDatabase  }


#

$t1=get-date
Backup-SPConfigurationDatabase -Directory $backupSPConfigurationDatabase  -DatabaseServer $DatabaseServer `
-DatabaseName $ConfigDB  # -DatabaseCredentials <WindowsPowerShellCredentialObject> [-Verbose]
Get-SPBackupHistory  -Directory $backupSPConfigurationDatabase
$t2=get-date;$t2-$t1  #TotalMinutes      :   (sql2012x)

$t1=get-date
Restore-SPFarm -Directory $backupSPConfigurationDatabase  -RestoreMethod Overwrite -ConfigurationOnly -Confirm:$false -Force
$t2=get-date;$t2-$t1  #TotalMinutes      : 1.52160397333333 (sp2013wfe)

# 目前無法證明實際成功. 只能知道沒有任何錯誤

#--------------------------------------------------------
#   phase 2    backup Restore farm configurations   using Backup-SPFarm 
#--------------------------------------------------------

$t1=get-date
Backup-SPFarm -Directory $backupSPConfigurationDatabase  -BackupMethod full -ConfigurationOnly
$t2=get-date;$t2-$t1 #Seconds : 16  (sql2012x)

Get-SPBackupHistory  -Directory $backupSPConfigurationDatabase
get 

$t1=get-date
Restore-SPFarm -Directory $backupSPConfigurationDatabase -BackupId f5a3dc16-decc-451d-b7a8-0e42fbd64e78 -RestoreMethod new -ConfigurationOnly -Confirm:$false -Force
$t2=get-date;$t2-$t1 # 1m11sec  (sp2013wfe)

# 目前無法證明實際成功. 只能知道沒有任何錯誤



ping ap1.csd.syscom


#--------------------------------------------------------
#   phase 3   backup Restore SharePoint 2013 中備份 WebApplication
#--------------------------------------------------------
$AliasName = "SPFarmSQL" ;$DatabaseServer = $AliasName  ; #SPecify the instance name if SQL is not installed on default instance$ConfigDB  ='SQL2012X_ConfigDB' 
$backupSPWebApplication='H:\sharepointbackup\SPWebApplication'; 
$backupSPWebApplication='\\SQL2012X\SPWebApplication'
ii $backupSPWebApplication
if ( (test-path $backupSPWebApplication) -eq $false) { md  $backupSPWebApplication  }


Get-SPWebApplication
Backup-SPFarm -ShowTree  #get 顯示服務應用程式的名稱 Now is AP1-80

$t1=get-date
Backup-SPFarm -Directory $backupSPWebApplication  -BackupMethod Full  -Item AP1-80
$t2=get-date;$t2-$t1 #Seconds : 25 (sql2012x)

Get-SPBackupHistory  -Directory $backupSPWebApplication
Get-SPBackupHistory -Directory $backupSPWebApplication -ShowBackup

gsv -displayname  *sharepoint*
net start sptimerv4
 計時器服務正在執行。 
 管理服務正在執行。 


$t1=get-date
Restore-SPFarm -Directory $backupSPWebApplication  -RestoreMethod new -Item  AP1-80 -Confirm:$false -Force
$t2=get-date;$t2-$t1 #Seconds : 16  (sp2013wfe)

gsv | ? displayname -Like '*sharepoint*' |ft -AutoSize 

ping ap1.csd.syscom
ping ap2.csd.syscom
ping ap3.csd.syscom

#  刪除193上原有WEBAPPLICATION.清空
$t1=get-date
get-spwebapplication |Remove-SPWebApplication -RemoveContentDatabases -DeleteIISSite -Confirm:$false
$t1=get-date $t2-$t1 #Seconds : 16  (sp2013wfe)
# 再刪除 SQL上的DB

#--------------------------------------------------------
#   backup restore  a web application 
#--------------------------------------------------------

get-spwebapplication  |select name,id,status ,Farm,url



Backup-SPFarm -Directory <BackupFolder> -BackupMethod {Full | Differential} -Item <WebApplicationName> [-Verbose]

Restore-SPFarm -Directory <BackupFolderName> -RestoreMethod Overwrite -Item  <WebApplicationName> [-BackupId <GUID>] [-Verbose]

#--------------------------------------------------------
#   backup restore  service applications
#--------------------------------------------------------
Back up service applications

#--------------------------------------------------------
#   backup restore a site collections
#--------------------------------------------------------

ackup-SPSite -Identity <SiteCollectionGUIDorURL> -Path <BackupFile> [-Force] [-NoSiteLock] [-UseSqlSnapshot] [-Verbose]