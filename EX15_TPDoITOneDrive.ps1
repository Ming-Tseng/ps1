<#
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX15_TPDoITOneDrive.ps1
C:\Users\Administrator\OneDrive\download\PS1\EX15_TPDoITOneDrive.ps1

createdate:Mar.02.2016
stakeholder
臺北市政府
資訊局      系統發展組
高級分析師  史凱文
電話        (02)27208889#8556
ic_nivek@mail.taipei.gov.tw]

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\EX15_TPDoITOneDrive.ps1

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

#  50 gmail  get office365
#  67  office365 
# 112  office365  onedrive  agent path
# 162  office365  onenote
# 175  office365  Sites
# 227  after  install SP2013 
# 233  Sharepoint on-premises SP1 & 
# 233.1   Metadata 
# 233.2   Profile 
# 233.3   mysite 
# 442   Using Powershell to open internet explorer and login into sharepoint
# 485   APR.06.2016
#       Install and configure OneDrive for Business
# 510   bandwidth performace
# 706   make test file
#  832  upload multifiel to  onedrive

#    office 365 online management shell 




ASNP Microsoft.SharePoint.Powershell  

























#-----------------------------------
# 50 gmail  get office365
#-----------------------------------
{<#

Emailname:   690303@syscom.com.tw
password:    690303
POP  outlook.office365.com	995
checked  Always use a secure connection (SSL) when retrieving mail ; label incoming messages :  


POP3	outlook.office365.com	995 implicit	TLS* v1-1.2
IMAP4	outlook.office365.com	993 implicit	TLS* v1-1.2
SMTP	smtp.office365.com	587 explicit	TLS v1-1.2
#>}



#-----------------------------------
#  67  office365 
#-----------------------------------
{<#
login 

https://login.microsoftonline.com

https://portal.office.com

mail      https://outlook.office.com/owa/?realm=syscom.com.tw#path=/mail
calendar    https://outlook.office.com/owa/#path=/calendar
People
Yammer
onedrive https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/onedrive.aspx
Sites    https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/Social/Sites.aspx
Tasks    https://outlook.office.com/owa/?realm=syscom.com.tw#path=/tasks
Delve    https://syscomo365-my.sharepoint.com/_layouts/15/me.aspx
video    https://syscomo365.sharepoint.com/portals/hub/_layouts/15/PointPublishing.aspx?app=video&p=h
wordonline
excelonline
PowerPointOnline
OnenoteOnline    https://www.onenote.com/notebooks?session=&auth=2
(14)Sway

blog         https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/Blog/default.aspx
public site  https://syscomo365-public.sharepoint.com/


https://portal.office.com/account/#personalinfo
https://portal.office.com/account/#subscriptions
https://portal.office.com/account/#apps   https://portal.office.com/myapps#  
https://portal.office.com/account/#settings

https://outlook.office.com/owa/?realm=syscom.com.tw#exsvurl=1&ll-cc=1033&modurl=0&wa=wsignin1.0
https://outlook.office.com/owa/?realm=syscom.com.tw#path=/mail



ming@syscom365.com




#>}


#-----------------------------------
#  112  office365  onedrive  agent path
#-----------------------------------
#{<#
(33  user : pmocsd\adminsitrator)
onedrive  version   2015  17.3.6381.0405
 
                  '---agent sync 1'  
 install version: 17.3.6381.0405(appwiz.cpl) from online download
 此版本有個<設定>功能.可以選 Folder 
690303@syscom.com.tw  

D:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO
. 'C:\Users\Administrator\AppData\Local\Microsoft\OneDrive\OneDrive.exe'
gps -Name OneDrive |Stop-Process -Force
'
Handles                    : 630
VM                         : 235155456
WS                         : 84475904
PM                         : 68898816
NPM                        : 40208

FileVersion                : 17.3.6381.0405
ProductVersion             : 17.3.6381.0405
'


                  '---agent sync  2' 
http://odsp.pmocsd.syscom.com/personal/administrator
D:\OneDrive_ODSP_33\商務用 OneDrive
.  C:\Program Files (x86)\Microsoft Office\root\Office16\GROOVE.EXE
gps  -Name GROOVE  |select *
'
FileVersion                : 16.0.6741.2026
ProductVersion             : 16.0.6741.2026
'




(33  user : pmocsd\infra1)  

http://odsp.pmocsd.syscom.com/personal/infra1
D:\OneDrive_ODSP_33\SharePoint\infra1

(33  user : pmocsd\infra2)
http://odsp.pmocsd.syscom.com/personal/infra2
D:\OneDrive_ODSP_33\商務用 OneDrive 1


(61  user : pmocsd\infra2)

agent sync 1
http://odsp.pmocsd.syscom.com/personal/infra2
C:\Users\infra2\商務用 OneDrive

agent sync 2
http://pp.tempcsd.syscom/personal/infra2
C:\Users\infra2\商務用 OneDrive 1


(193  sp2013wfe  user : sp2103wfe\infra1)
agent  from C:\temp\oneDriveStandalone\OneDrive_forBusiness_offline.zip
C:\Users\infra1\SharePoint\infra1  (PMOCSD\infra1)

appwiz.cpl  15.0.4701.1002
Open your OneDrive for Business
sync a new library



https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/onedrive.aspx

檢視儲存空間 :網站設定 : 儲存指標
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/storman.aspx
           http://odsp.pmocsd.syscom.com/personal/administrator/_layouts/15/storman.aspx
#網站設定 : 儲存指標 查詢空間  1022.74 GB 可用，共 1024.00 GB  #apr.12.2016
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/storman.aspx

資源回收筒
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/AdminRecycleBin.aspx


https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/viewlsts.aspx

#>}

#-----------------------------------
# 162 office365  onenote
#-----------------------------------
{<#
http://www.onenote.com/#
https://www.onenote.com/notebooks?auth=2&nf=1
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/WopiFrame.aspx?sourcedoc={C8B9677C-8A0E-4807-AA12-B58878498649}&file=Ming%20@%20%E5%85%AC%E5%8F%B8&action=default&wdo=6&wdfre=0&RootFolder=%2fpersonal%2f690303%5fsyscom%5fcom%5ftw%2fDocuments%2f%e7%ad%86%e8%a8%98%e6%9c%ac%2fMing%20%40%20%e5%85%ac%e5%8f%b8


共用
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/guestaccess.aspx?guestaccesstoken=izKVD1NQM9EvYaClbtitR%2fKE4an4ICLNlLWV%2bhL4UTk%3d&folderid=2_1c8b9677c8a0e4807aa12b58878498649
#>}

#-----------------------------------
# 175  office365  Sites
#-----------------------------------
{<#
Sites    https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/Social/Sites.aspx

網站內容
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/start.aspx#/_layouts/15/viewlsts.aspx



網站設定  
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/15/start.aspx#/_layouts/15/settings.aspx
?Source=https%3A%2F%2Fsyscomo365%2Dmy%2Esharepoint%2Ecom%2Fpersonal%2F690303%5Fsyscom%5Fcom%5Ftw%2F%5Flayouts%2F15%2Fviewlsts%2Easpx
 

 
使用者與權限 
人員與群組 
網站權限 
存取要求與邀請 
網站集合管理員 
網站應用程式權限 
 
 
網站設計工具庫 
網站欄 
網站內容類型 
網頁組件 
清單範本 
主版頁面 
方案 
組成外觀 
 
 
網站管理 
地區設定 
語言設定 
網站程式庫與清單 
使用者提醒 
RSS 
網站與工作區 
工作流程設定 
字詞庫管理 
 
 
搜尋 
結果來源 
結果類型 
查詢規則 
結構描述 
搜尋設定 
搜尋與離線可用性 
設定匯入 
設定匯出 
 

外觀與風格 
標題、描述及標誌 
快速啟動 
上方連結列 
瀏覽項目 
 
 
網站動作 
管理網站功能 
重設為網站定義 
 
 
    網站集合管理 
資源回收筒 
搜尋結果來源 
搜尋結果類型 
搜尋查詢規則 
搜尋結構描述 
搜尋設定 
搜尋設定匯入 
搜尋設定匯出 
網站集合功能 
網站階層 
網站集合稽核設定 
入口網站連線 
儲存指標 
網站集合應用程式權限 
內容類型發佈 
HTML 欄位安全性 
SharePoint Designer 設定 
網站集合狀況檢查 
網站集合升級 
#>} 

#-----------------------------------
# 227  after  install SP2013 
#-----------------------------------

Get-ADDomain
Restart-Computer

shutdown -r -f

Powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1

 NQTMW-K63MQ-39G6H-B2CH9-FRDWJ (Trial)
 P4GN7-G2J3K-XPQYT-XG4J4-F6WFV (M3)

#-----------------------------------
# 233  Sharepoint on-premises SP1 & 
#-----------------------------------

gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
'Microsoft SharePoint Portal       15.0.4569.1506 '
start-process  D:\software2015\officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe 
remember  must reboot 
'Microsoft SharePoint Server 2013  15.0.4571.1502 '

ref :SP02_01PMDstepbystep.ps1

powershell_ise  \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1

gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name  #15.0.4569.1506 -> 15.0.4571.1502
ASNP Microsoft.SharePoint.Powershell  # Get-PsSnapIn  GSNP
(Get-SPFarm).Products
'
9ff54ebc-8c12-47d7-854f-3865d4be8118                                                                                                        
b7d84c2b-0754-49e4-b7be-7ee321dce0a9  SharePoint Server 2013 Enterprise
'
get-spserver #$env:computername
'
PMD2016             
SPFarmSQL

'

$url = "http://www.udn.com/" 
$URLadmin=(Get-SPWebApplication -includecentraladministration | where {$_.DisplayName -eq "SharePoint Central Administration v4"}).url
$URLadmin='http://pmd2016:2013/'
# Get-SPFarm 


#
Get-SPManagedAccount # whoami   pmocsd\infra1


#
get-SPServiceApplicationPool #BIApplicationPool
'Name                                     ProcessAccountName                                                                                 
----                                     ------------------                                                                                 
BIApplicationPool                        PMOCSD\SPService                                                                                   
SecurityTokenServiceApplicationPool      PMOCSD\infra1                                                                                      
SharePoint Web Services System           PMOCSD\infra1
'
#
Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto
#-----------------------------------
# 233.1   Metadata 
#-----------------------------------

http://win-2s026ubrqfo:2016/_admin/ServiceApplications.aspx
http://pmd2016:2013/_admin/ServiceApplications.aspx

Get-SPServiceInstance | ?  TypeName -eq 'Managed Metadata Web Service' |Start-SPServiceInstance
Get-SPServiceInstance | ?  TypeName -eq 'Managed Metadata Web Service'  # status : online

$t1=get-date;
New-SPMetadataServiceApplication -Name "MetadataServiceApp" -ApplicationPool 'MySitePool' -DatabaseName "MetadataDB"
New-SPMetadataServiceApplicationProxy -Name "MetadataServiceProxy" -ServiceApplication "MetadataServiceApp"
$t2=get-date; ($t2-$t1)
http://localhost:2013/_admin/ServiceApplications.aspx

$MetadaSrvAppProxy=Get-SPServiceApplicationProxy  | ? TypeName -eq 'Managed Metadata Service 連線'
Remove-SPServiceApplicationProxy $MetadaSrvAppProxy -Confirm:$false 

$MetadaSrvApp=Get-SPServiceApplication | ? TypeName -eq 'Managed Metadata Service'
Remove-SPServiceApplication $MetadaSrvApp -RemoveData -Confirm:$false 


#-----------------------------------
# 233.2   Profile 
#-----------------------------------
Get-SPServiceInstance | ? {$_.TypeName -eq "User Profile Service"} | Start-SPServiceInstance 
Get-SPServiceInstance | ? {$_.TypeName -eq "User Profile Service"} #online

$userProfileSAName ='UPA'
$saAppPoolName='BIApplicationPool'
$databaseServerName='SPFarmSQL'

$userProfileService = New-SPProfileServiceApplication -Name $userProfileSAName `
-ApplicationPool $saAppPoolName `
-ProfileDBServer $databaseServerName     -ProfileDBName "ProfileDB" `
-SocialDBServer  $databaseServerName     -SocialDBName  "SocialDB" `
-ProfileSyncDBServer $databaseServerName -ProfileSyncDBName "SyncDB"

New-SPProfileServiceApplicationProxy -Name "$userProfileSAName Proxy" `
-ServiceApplication $userProfileService -DefaultProxyGroup

 http://localhost:2013/_admin/ServiceApplications.aspx

#
Get-SPServiceApplication | ft -AutoSize
#-----------------------------------
# 233.3   mysite 
#-----------------------------------
get-WebApplication
Get-SPWebApplication
Get-SPWebTemplate


#(1/8)   建立「我的網站」WebApplication

$env:USERDNSDOMAIN  #PMOCSD.SYSCOM.COM
#CreateWebApplication 'PowerPivot- 80' 'http://pp.tempcsd.syscom' 'BIApplicationPool' 'TEMPCSD\spService' $password 'SPFarmSQLAlias' 'PowerPivotWebApplicationDB'
$name      ='aa_mysite'
$url       ='http://aa.pmocsd.syscom.com'
$appPool   ='MySitePool'
$appAccount='PMOCSD\infra1'
$appAccountPassword ='p@ssw0rd'
$dbServer  ='SPFarmSQL'
$dbName    ='aaWADB'

$appPoolManagedAccount = Get-SPManagedAccount $appAccount -ErrorAction:SilentlyContinue
#$appPoolManagedAccount = Get-SPManagedAccount 'ttttee' -ErrorAction:SilentlyContinue

    if($appPoolManagedAccount -eq $null)
    {
        $appPoolAccount = New-Object System.Management.Automation.PSCredential ($appAccount, $appAccountPassword)
        $appPoolManagedAccount = New-SPManagedAccount $appPoolAccount
    }

Get-SPWebApplication;'Null'

$ap = New-SPAuthenticationProvider
$t1=get-date
New-SPWebApplication -Name $name -ApplicationPool $appPool -ApplicationPoolAccount $appPoolManagedAccount `
-URL $url -DatabaseServer $dbServer -DatabaseName $dbName -AuthenticationProvider $ap
$t2=get-date; ($t2-$t1)  #  3Min 16Sec 



GET-SPFeature -Identity PublishingSite

Enable-SPFeature -Identity PremiumSite -URL $URLadmin -Force #也開啟此網站之下 SharePoint Server 企業版網站集合功能
#http://pmd2016:2013/_layouts/15/ManageFeatures.aspx?Scope=Site
# your can see SharePoint Server 企業版網站集合功能  <啟動>  

Enable-SPFeature -Identity PublishingSite -URL $URLadmin -Force  # 啟動  SharePoint Server 發佈基礎結構 功能


$urlaa='http://aa.pmocsd.syscom.com/'
$urlpp='http://pp.pmocsd.syscom.com/'

$t1=get-date
Remove-SPWebApplication $urlaa -Confirm:$false -DeleteIISSite -RemoveContentDatabases
$t2=get-date
($t2-$t1).TotalMinutes  #3mins


#(2/8)  建立「我的網站」主機網站集合
$t1=get-date; 
New-SPSite -Url $url -OwnerEmail 'infra1@pmocsd.syscom.com' -OwnerAlias 'PMOCSD\infra1' `
-SecondaryOwnerAlias 'PMOCSD\infra2' -Template 'SPS#0' -Name  ' SPS#0 create by Mar.14.2018'
$t2=get-date; ($t2-$t1) 

$t1=get-date;  
New-SPSite -Url $url  -OwnerEmail 'infra1@pmocsd.syscom.com' -OwnerAlias 'pmoCSD\infra1' `
-SecondaryOwnerAlias 'pmoCSD\infra2' -Template 'SPSMSITEHOST#0' -Name  'MySite'
$t2=get-date; ($t2-$t1) 


## remove
$t1=get-date;
Remove-SPSite -Identity $url -GradualDelete -Confirm:$False
$t2=get-date; ($t2-$t1) # 3M 42S



  you can  see http://aa.pmocsd.syscom.com    using infra1 or infra2

#(3/8)   將包含相對路徑的管理路徑加入 Web 應用程式
#  http://pmd2016:2013/_admin/WebApplicationList.aspx   -> 定義管理的路徑
$WAurl='http://aa.pmocsd.syscom.com'
Get-SPManagedPath   -WebApplication  $WAurl
'
S C:\Windows\system32> Get-SPManagedPath   -WebApplication  $WAurl

Name                           Type                          
----                           ----                          
                               ExplicitInclusion             
personal                       WildcardInclusion   

PS C:\Windows\system32> Get-SPManagedPath   -WebApplication  ''http://pp.tempcsd.syscom''

Name                           Type                          
----                           ----                          
                               ExplicitInclusion             
sites                          WildcardInclusion             
personal                       WildcardInclusion

'


New-SPManagedPath "personal" -WebApplication $WAurl


#(4/8) 將 Web 應用程式連接到服務應用程式

http://pmd2016:2013/_admin/WebApplicationList.aspx
    在 [Web 應用程式] 索引標籤的 [管理] 群組中，按一下 [服務連線]。

    MetadataServiceProxy   must checked
    UPA Proxy 

#(5/8) 啟用 Web 應用程式的自助網站架設。
http://pmd2016:2013/_admin/WebApplicationList.aspx

8.5.1
在 [Web 應用程式] 索引標籤的 [安全性] 群組中，按一下 [自助網站架設]。
在[自助網站架設管理] 對話方塊的 [網站集合] 中，選取 [開啟]。選擇性地在 [要套用的配額範本]，選取配額範本。

8.5.2
在 [原則] 群組中按一下 [權限原則]。
在 [管理權限原則等級] 對話方塊中，按一下 [新增權限原則等級]。
請輸入權限原則的名稱。
在 [權限] 下的 [網站權限] 中，選擇 [建立子網站：建立子網站，例如小組網站、會議工作區網站以及文件工作區網站] 的 [授與] 選項。
按一下 [儲存]。
在 [原則] 群組中按一下 [使用者原則]。
在 [Web 應用程式原則] 對話方塊中按一下 [加入使用者]。
在 [加入使用者] 的 [區域] 中選取 [(所有區域)]，然後按 [下一步]。
在 [選擇使用者] 中輸入您要從「我的網站」建立小組網站的使用者名稱，以便使用網站摘要。如果所有使用者可從「我的網站」建立小組網站來使用網站摘要，請按一下 [瀏覽] 圖示。在 [選取人員和群組] 中，依序按一下 [所有使用者]、[所有人]、[新增]、[確定]。
在 [選擇權限] 區段中選擇先前建立的 [權限原則] 名稱。
按一下 [完成]，然後按一下 [確定]。

#(6/8) 設定 User Profile Service 應用程式的「我的網站」設定

http://pmd2016:2013/_admin/ServiceApplications.aspx  #管理服務應用程式

按一下在此工作初期連接到 Web 應用程式主控「我的網站」的 User Profile Service 應用程式。
http://pmd2016:2013/_layouts/15/ManageUserProfileServiceApplication.aspx?ApplicationID=487fc1c3%2D898b%2D4375%2Dbbe0%2Da95de807ecb8
http://win-2s026ubrqfo:2016/_layouts/15/ManageUserProfileServiceApplication.aspx?ApplicationID=a6967447%2Da66d%2D4338%2Da7c5%2Dedcaed4d82b3

在「管理設定檔服務」頁面的 [我的網站設定] 區段中，按一下 [設定我的網站]。


#(7/8) 啟用 User Profile Service 應用程式 - 活動摘要工作

#(8/8) 後續步驟








$url=$url+'/sites/'





New-SPSite : 所提供的受管理路徑不存在，因此無法建立網站集合。請變更 URL 以使用現有受管理路徑，或建立遺失的受管理路徑，然後再呼叫此命令。

http://localhost:2013/_admin/scprefix.aspx?WebApplicationId=5e313bc5%2Dbe99%2D4f11%2D872f%2D2e763dfc086f&Source=http%3A%2F%2Flocalhost%3A2013%2F%5Fadmin%2Fcreatesite%2Easpx



Remove-SPSite -Identity $url -GradualDelete -Confirm:$False
Get-SPSite 'http://www.contoso.com'


#-----------------------------------
# 442  Using Powershell to open internet explorer and login into sharepoint
#-----------------------------------
$url = "http://PMD2016:2013/" 
$username="administrator@tempcsd.syscom.com" 
$password="p@ssw0rd" 
$ie = New-Object -com internetexplorer.application; 
$ie.visible = $true; 
$ie.navigate('http://PMD2016:2013/');

#$IE.Quit()

$ie.navigate();

while ($ie.Busy -eq $true) 
{ 
    Start-Sleep -Milliseconds 1000; 
} 
$ie.Document.getElementById("login").value = $username 
$ie.Document.getElementByID("Passwd").value=$password 
$ie.Document.getElementById("cred_sign_in_button").Click();


Start-Process 'http://www.microsoft.com' 
$ie.navigate('http://portal.office.com');
$ie.navigate('http://www.google.com');
$ie.navigate('http://www.udn.com',2048);

$ie.Navigate2("http://www.google.com/", 2048) # New Tab

$ie.Navigate2("http://www.chinatimes.com/",2048)
$ie.Navigate2("http://www.udn.com/",2048)

gps -Name iexplore
gps -Name iexplore |Stop-Process


$iethreads = get-process iexplore |?{!$_.MainWindowTitle} |%{$_.ID}


#-----------------------------------
#  485   APR.06.2016
#-----------------------------------
網站設定 : 網站集合功能  
http://pmd2016:2013/_layouts/15/ManageFeatures.aspx?Scope=Site
http://win-2s026ubrqfo:2016/_layouts/15/ManageFeatures.aspx?Scope=Site

管理網站功能 
http://pmd2016:2013/_layouts/15/ManageFeatures.aspx
http://win-2s026ubrqfo:2016/_layouts/15/ManageFeatures.aspx


#-----------------------------------
#    Install and configure OneDrive for Business
#-----------------------------------

https://technet.microsoft.com/en-us/library/mt147421.aspx


Microsoft SharePoint Server 2013 (KB2880552) Service Pack 1
officeserversp2013-kb2880552-fullfile-x64-zh-tw.exe   1.3G


(1)Set up OneDrive for Business in SharePoint 2013
  (1.1) Managed Metadata service
    
(2)Set up hybrid OneDrive for Business
(3)Create an audience for SharePoint 2013
(4)Set up search for hybrid OneDrive for Business
(5)Pre-provision user sites in OneDrive for Business

#-----------------------------------
#  510  bandwidth performace
#-----------------------------------
Get-counter -ListSet  *network* | Select-Object -ExpandProperty Paths 

get-counter
Get-Counter -ListSet  "Network Interface" |Select-Object -ExpandProperty Paths
\Network Interface(*)\Bytes Total/sec

'network interface(red hat virtio ethernet adapter)\bytes total/sec'
processor(_total)\% processor time 


#-----------
$blgFile='c:\PerfLogs\SCE_'+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.blg';$blgFile


Saving the data to a binary file (BLG)
$counters = '\Processor(*)\% Processor Time',
'\Memory\Committed Bytes',
'\Memory\Available Bytes', '\Memory\Pages/sec',
'\Process(*)\Working Set - Private',
'\PhysicalDisk(_Total)\Disk Reads/sec',
'\PhysicalDisk(_Total)\Disk Writes/sec'

Get-Counter -Counter $counters -MaxSamples 120 -SampleInterval 1 | Export-Counter -Path $blgFile -FileFormat blg

ii $blgFile


get-job 
Remove-Job * 
$t1=get-date
Start-Job  -scriptblock {Get-Counter  -MaxSamples 120 -SampleInterval 1 | Export-Counter -Path $blgFile -FileFormat blg} #/cons

$t2=get-date; ($t2-$t1)


'
\Network Interface(*)\Bytes Total/sec
\Network Interface(*)\Packets/sec
\Network Interface(*)\Packets Received/sec
\Network Interface(*)\Packets Sent/sec
\Network Interface(*)\Current Bandwidth
\Network Interface(*)\Bytes Received/sec
\Network Interface(*)\Packets Received Unicast/sec
\Network Interface(*)\Packets Received Non-Unicast/sec
\Network Interface(*)\Packets Received Discarded
\Network Interface(*)\Packets Received Errors
\Network Interface(*)\Packets Received Unknown
\Network Interface(*)\Bytes Sent/sec
\Network Interface(*)\Packets Sent Unicast/sec
\Network Interface(*)\Packets Sent Non-Unicast/sec
\Network Interface(*)\Packets Outbound Discarded
\Network Interface(*)\Packets Outbound Errors
\Network Interface(*)\Output Queue Length
\Network Interface(*)\Offloaded Connections
\Network Interface(*)\TCP Active RSC Connections
\Network Interface(*)\TCP RSC Coalesced Packets/sec
\Network Interface(*)\TCP RSC Exceptions/sec
\Network Interface(*)\TCP RSC Average Packet Size'




# use cmd - regedit  if spfarm , infra  can not into http://pp.tempcsd.syscom
解決方法
1. Click Start, click Run, type regedit, and then click OK.
2. In Registry Editor, locate and then click the following registry key:    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa
3. Right-click Lsa, point to New, and then click DWORD Value.
4. Type DisableLoopbackCheck, and then press ENTER.
5. Right-click DisableLoopbackCheck, and then click Modify.
6. In the Value data box, type 1, and then click OK.
7. Quit Registry Editor, and then restart your computer.





#-----------------------------------
#  706 make test file
#-----------------------------------




ii  C:\users\infra2


$ODSP='C:\Users\infra2\商務用 OneDrive'
$PP='C:\Users\infra2\商務用 OneDrive 1'

$ODSPshare='C:\Users\infra2\商務用 OneDrive\與所有人共用'
ii $ODSP 

;ii $PP

$whoami=$env:USERDNSDOMAIN+'_'+$env:USERNAME

$FN=get-date -format yyy_MM_dd_HH_mm

$ODSPF     =$ODSP+'\'+$whoami+'_ODSP_'+ $FN +'.txt' ; $ODSPF 

$PPF       =$PP+'\'+$whoami+'_'+$PP_infra2_+ $FN +'.txt' ;$PPF 

$ODSPshareF=$ODSPshare+'\'+$whoami+'_'+$FN+'.txt';$ODSPshareF
systeminfo | out-file   $ODSPshareF  -Append



systeminfo | out-file   $ODSPF  -Append
systeminfo | out-file   $PPF  -Append
;



$ODSP='C:\Users\infra2\商務用 OneDrive'; $x=0;
do
{
$FN=get-date -format yyy_MM_dd_HH_mm_ss
$ODSPF     =$ODSP+'\'+$whoami+'_ODSP_'+ $FN +'.txt' ;# $ODSPF 
systeminfo | out-file   $ODSPF  -Append
start-sleep 5
$x=$x+1;#$x
}
until ($x -eq 5)

$FS=gci $ODSP -Recurse
foreach ($F in $FS)
{
    #$F.name +' --'+$F.LastWriteTime  +'  ---'+$F.FullName
    if ($F.PSIsContainer -ne $true)
    {
         $F.name +' --'+$F.LastWriteTime  +'  ---'+$F.FullName
         rm $F.FullName -Force -confirm:$false
    }

}


ii $ODSP 

#-----------------------------------
#   832  upload multifiel to  
#-----------------------------------
ref ## 526 upload  +  download + delete  file to sharepoint 

Scenario 1: Uploading Files to SharePoint on the SharePoint Server

Here’s a quick example of how to upload a document on a SharePoint server using the SharePoint PowerShell module which uses the SharePoint Object Model.

# Set the variables 
$WebURL = “http://portal.contoso.com/sites/stuff” 
$DocLibName = “Docs” 
$FilePath = “C:\Docs\stuff\Secret Sauce.docx” 

# Get a variable that points to the folder 
$Web = Get-SPWeb $WebURL 
$List = $Web.GetFolder($DocLibName) 
$Files = $List.Files

# Get just the name of the file from the whole path 
$FileName = $FilePath.Substring($FilePath.LastIndexOf("\")+1)

# Load the file into a variable 
$File= Get-ChildItem $FilePath

# Upload it to SharePoint 
$Files.Add($DocLibName +"/" + $FileName,$File.OpenRead(),$false) 
$web.Dispose()

In the case we use the Add member of the SPFileCollection class. It has a few overloads, so check them out, there might be one that better fits what you’re trying to do. 

Scenario 2: Uploading Files to SharePoint from a Remote Machine

Since we can’t use the object model to upload files remotely we have to go about it a different way. I use the WebClient object, though there might be other ways. Here’s an example:

$destination = "http://odsp.pmocsd.syscom.com/personal/infra2” 
$securePasssword = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force 
$credentials = New-Object System.Management.Automation.PSCredential ("PMOCSD\infra2", $securePasssword)


$webclient = New-Object System.Net.WebClient 
$webclient.Credentials = $credentials 
$webclient.UploadFile($destination + "/" + $fileN.Name, "PUT", $fileN.FullName)

ssms
$webclient |gm 
$webclient.UploadFile('http://odsp.pmocsd.syscom.com/personal/infra2/Documents/1M.txt', "PUT", 'H:\temp\1M.txt')
$webclient.UploadFile('http://odsp.pmocsd.syscom.com/personal/infra2/Documents/4k.txt', "PUT", 'H:\temp\4k.txt')



$WebClient.DownloadFile( 'http://odsp.pmocsd.syscom.com/personal/infra2/Documents/4k.txt', 'c:\temp\K4T.txt' )



#  Delete sharepoint file 


 $url='http://odsp.pmocsd.syscom.com/personal/administrator'
 $url='http://odsp.pmocsd.syscom.com/personal/infra2'

  $sweb=get-spweb $url
  #$sweb.Lists |select title
  $slists = $sweb.Lists["文件"]; #$slists
  $sf= $slists.Items | ? name  -like '4*.txt'  # $slists.Items |select name  
  #$sf |select name
  $sf.Delete()



# Set the variables 
$destination = "http://portal.contoso.com/sites/stuff/Docs” 
$File = get-childitem “C:\Docs\stuff\Secret Sauce.docx”

# Since we’re doing this remotely, we need to authenticate 
$securePasssword = ConvertTo-SecureString "pass@word1" -AsPlainText -Force 
$credentials = New-Object System.Management.Automation.PSCredential ("contoso\johnsmith", $securePasssword)

# Upload the file 
$webclient = New-Object System.Net.WebClient 
$webclient.Credentials = $credentials 
$webclient.UploadFile($destination + "/" + $File.Name, "PUT", $File.FullName)






#-----------------------------------
#   office 365 online management shell 
#-----------------------------------
https://technet.microsoft.com/en-us/library/fp161362(v=office.15).aspx


https://www.microsoft.com/en-us/download/details.aspx?id=35588
ii 'C:\Program Files\SharePoint Online Management Shell\'

$env:PSModulePath 
C:\Users\Administrator\Documents\WindowsPowerShell\Modules
;C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules\
;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\
;C:\Program Files\適用於 Windows Server 的AppFabric 1.1\PowershellModules
; ii 'C:\Program Files\SharePoint Online Management Shell\'


Connect-SPOService -Url  https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw -credential 690303@syscom.com.tw
Connect-SPOService -Url  https://syscomo365-my.sharepoint.com -credential 690303@syscom.com.tw






