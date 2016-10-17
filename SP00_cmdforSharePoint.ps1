
<#  SP00_cmdforSharePoint  C:\Users\administrator.CSD\SkyDrive\download\PS1\SP01_installconfg.ps1 \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\SP01_installconfg.ps1 auther : ming_tseng    a0921887912@gmail.com createData : Mar.06.2014 history : Sep.04.2014  object :   $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SP01_installconfg.ps1

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

http://technet.microsoft.com/en-us/library/ee890108(v=office.15).aspx




--------------------- count:３６

01 Access Services cmdlets
02 App Management Service cmdlets
03 Backup and recovery cmdlets
04 Database cmdlets
05 Enterprise content management cmdlets
06 Excel Services cmdlets
07 Farm cmdlets
08 Features and solutions cmdlets   SP04_FeatureSolution.ps1
09 Health monitoring cmdlets
10 Import and export cmdlets
11 InfoPath Services cmdlets
12 Logging and events cmdlets
13 Managed metadata cmdlets
14 Office Web Apps cmdlets
15 PerformancePoint Services cmdlets
16 Secure Store Service cmdlets
17 Service application
18 Site collection cmdlets
19 State service and session state cmdlets
20 administer and configure search
21 administer security
22 administer SharePoint 2013
23 administer the Work Management Service
24 configure the User Profile service
25 manage Access Services
26 manage Business Connectivity Services
27 manage MachineTranslation Service applications
28 manage performance
29 manage sites
30 manage timer jobs
31 manage user licenses
32 manage workflow
33 upgrade to SharePoint 2013 and to migrate data
34 Visio Graphics Services cmdlets
35 Web application cmdlets
36 Word Services cmdlets

----------------------------------------------------------------------------------


Access Services cmdlets
App Management Service cmdlets
Backup and recovery cmdlets
Database cmdlets
Enterprise content management cmdlets
Excel Services cmdlets
Farm cmdlets
Features and solutions cmdlets
Health monitoring cmdlets
Import and export cmdlets
InfoPath Services cmdlets
Logging and events cmdlets
Managed metadata cmdlets
Office Web Apps cmdlets
PerformancePoint Services cmdlets
Secure Store Service cmdlets
Service application
Site collection cmdlets
State service and session state cmdlets
administer and configure search
administer security
administer SharePoint 2013
administer the Work Management Service
configure the User Profile service
manage Access Services
manage Business Connectivity Services
manage MachineTranslation Service applications
manage performance
manage sites
manage timer jobs
manage user licenses
manage workflow
upgrade to SharePoint 2013 and to migrate data
Visio Graphics Services cmdlets
Web application cmdlets
Word Services cmdlets



伺服器陣列中的伺服器    http://localhost:2013/_admin/FarmServers.aspx

設定服務帳戶 
     
管理 Web 應用程式     http://localhost:2013/_admin/WebApplicationList.aspx

內容資料庫            http://localhost:2013/_admin/CNTDBADM.aspx

網站設定 :網站集合管理: 網站集合功能  http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site

網站設定 :網站動作   :網站功能      http://localhost:2013/_layouts/15/ManageFeatures.aspx


應用程式管理           http://localhost:2013/applications.aspx

 管理服務應用程式 |   http://localhost:2013/_admin/ServiceApplications.aspx
 設定服務應用程式關聯  http://localhost:2013/_admin/ApplicationAssociations.aspx
 
 
 
 
 管理 Excel Services 應用程式  http://win-2s026ubrqfo:2013/_admin/ExcelServicesAdmin.aspx?Id=56d693a1e3994605810908730467ccc2
 
     整體設定        http://win-2s026ubrqfo:2013/_admin/ExcelServerSettings.aspx?Id=56d693a1e3994605810908730467ccc2
     定義負載平衡、記憶體以及節流閾值。設定自動服務帳戶和資料連線逾時。
 
     信任的檔案位置    http://win-2s026ubrqfo:2013/_admin/ExcelServerTrustedLocations.aspx?Id=56d693a1e3994605810908730467ccc2
 
     信任的資料提供者  http://win-2s026ubrqfo:2013/_admin/ExcelServerSafeDataProviders.aspx?Id=56d693a1e3994605810908730467ccc2
 
     信任的資料連線庫  http://win-2s026ubrqfo:2013/_admin/ExcelServerTrustedDcls.aspx?Id=56d693a1e3994605810908730467ccc2
 
     使用者定義的函數組件  http://win-2s026ubrqfo:2013/_admin/ExcelServerUserDefinedFunctions.aspx?Id=56d693a1e3994605810908730467ccc2
          登錄試算表可以使用的 Managed 程式碼組件。 

     資料模型設定     http://win-2s026ubrqfo:2013/_admin/ExcelServerBIServers.aspx?Id=56d693a1e3994605810908730467ccc2
        登錄    Excel Services 應用程式 可用來執行進階資料分析功能的 SQL Server Analysis Services 伺服器執行個體。 
 
 
 |se
          http://pmd2016:2013/_layouts/15/user.aspx
  http://win-2s026ubrqfo:2013/_layouts/15/user.aspx


 http://pp.tempcsd.syscom/PowerPivot%20圖庫/Forms/Gallery.aspx

檢視所有的網站集合
 Get-SPWebApplication  | Get-SPSite | Format-Table -Property URL,ContentDatabase
 
 $url='http://odsp.pmocsd.syscom.com/'
 $spwa=Get-SPWebApplication  $url ;$spwa |select *
 $spwa.Sites |select *


 商務網站集合的 OneDrive 的清單  (https://technet.microsoft.com/zh-tw/library/dn911464.aspx)
      $credentials = Get-Credential
      Connect-SPOService -Url https://<yourdomain>-admin.sharepoint.com -credential $credentials
      Get-SPOSite https://<yourdomain>.sharepoint.com




檢視儲存空間 :網站設定 : 儲存指標
https://syscomo365-my.sharepoint.com/personal/690303_syscom_com_tw/_layouts/storman.aspx
           http://odsp.pmocsd.syscom.com/personal/administrator/_layouts/15/storman.aspx