

<#


C:\Users\administrator.CSD\OneDrive\download\PS1\SP04_FeatureSolution.ps1

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SP04_FeatureSolution.ps1

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

#   13  Install-SPFeature
#   41  SPFeature
#  142  Get-SPFeature -Limit ALL get 中文名稱
#   1329  Install-SPFeature



#-----------------------------------------------------------------------------------
#   13  Install-SPFeature
#-----------------------------------------------------------------------------------

The SharePoint Features files must already be put in the proper directory, either manually or by using a solution installer.

$featurefoler=“$env:ProgramFiles\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\”
ii $featurefoler  # count 409 


--------------EXAMPLE 1-----------------
Install-SPFeature -path "MyCustomFeature"
This example installs a new feature 
at $env:ProgramFiles\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\MyCustomFeature/feature.xml.

--------------EXAMPLE 2-----------------
Install-SPFeature -AllExistingFeatures -Whatif
This example shows the unregistered features that are available on the file system and that are installed if this command is run without the WhatIf parameter. 
This is commonly done after an upgrade process.

--------------EXAMPLE 3-----------------
Install-SPFeature -path "MyCustomFeature"  -CompatibilityLevel 14
This example installs a new feature at $env:ProgramFiles\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\MyCustomFeature\feature.xml.

--------------EXAMPLE 4-----------------
Install-SPFeature -path "MyCustomFeature"  -CompatibilityLevel 15
This example installs a new feature at $env:ProgramFiles\Common Files\Microsoft Shared\Web Server Extensions\15\TEMPLATE\FEATURES\MyCustomFeature\feature.xml.




#-----------------------------------------------------------------------------------
#  41  SPFeature
#-----------------------------------------------------------------------------------

PS SQLSERVER:\> Get-SPFeature | sort  displayname  

DisplayName                    Id                                       CompatibilityLevel   Scope                         
#-----------                    --                                       ------------------   -----                         
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





Name                        : FeatureDefinition/15/ff48f7e6-2fa1-428d-9a15-ab154762043
                              d
Id                          : ff48f7e6-2fa1-428d-9a15-ab154762043d
DisplayName                 : TemplateDiscovery
SolutionId                  : 00000000-0000-0000-0000-000000000000
CompatibilityLevel          : 15
ReceiverAssembly            : 
ReceiverClass               : 
UIVersion                   : 
UpgradeReceiverAssembly     : 
UpgradeReceiverClass        : 
Properties                  : {}
Version                     : 14.0.0.0
Scope                       : Farm
AutoActivateInCentralAdmin  : False
ActivateOnDefault           : True
RootDirectory               : C:\Program Files\Common Files\Microsoft Shared\Web Serve
                              r Extensions\15\Template\Features\TemplateDiscovery
Hidden                      : False
ActivationDependencies      : {}
AlwaysForceInstall          : False
RequireResources            : False
DefaultResourceFile         : dlccore
TypeName                    : Microsoft.SharePoint.Administration.SPFeatureDefinition
Status                      : Online
Parent                      : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
Farm                        : SPFarm Name=WIN-2S026UBRQFO_ConfigDB
UpgradedPersistedProperties : {}
#-----------------------------------------------------------------------------------
#  142  Get-SPFeature -Limit ALL get 中文名稱
#-----------------------------------------------------------------------------------

Get-SPFeature -Limit ALL | % { Get-SPFeature -Identity $_ | % { $_.DisplayName + $delimiter + $_.GetTitle($lcid) +$delimiter +$_.Scope + $delimiter + $_.Id + $delimiter + $_.GetDescription($lcid)} } >> c:\temp\feature.csv

$objects=Get-SPFeature |? CompatibilityLevel -EQ 15 |sort scope ,displayname;$objects.count  # 407
foreach ($object in $objects)
{
$object.DisplayName+"-"+$object.GetTitle($lcid)+"-"+$object.GetDescription($lcid)+"-"+$object.Scope #|select * 
  
  #Write-Host -NoNewline  $object.DisplayName +'--'+  $object.GetTitle($lcid)  `n
}



-scope :Farm: count 75


#-----------------------------------------------------------------------------------
#  http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site
#-----------------------------------------------------------------------------------


 
 
 網站設定 : 網站集合功能  http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site  標記為 S01
2網站設定 > 網站功能   http://localhost:2013/_layouts/15/ManageFeatures.aspx               標記為 W01


PS C:\Windows\system32> 
foreach ($object in $objects)
{
$object.DisplayName+"-"+$object.GetTitle($lcid)+"-"+$object.GetDescription($lcid)+"-"+$object.Scope #|select * 
  
  #Write-Host -NoNewline  $object.DisplayName +'--'+  $object.GetTitle($lcid)  `n
}

<#
網站設定 : 網站集合功能  http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site  標記為 S01
s01-PerformancePoint Services 網站集合功能;可啟用 PerformancePoint Services 的功能，包括此網站集合的內容類型和網站定義。 
s02-Search Server 網頁組件和範本;此功能可將 Search Server 網頁組件和顯示範本新增至您的網站。即使不啟動此功能，搜尋也可以在大多數網站上運作，但如果您在搜尋時收到遺失範本的訊息，那麼請啟動此功能。 
s03-SharePoint 2007 工作流程;SharePoint 2007 提供的現成工作流程功能彙總組合。 
s04-SharePoint Server 企業版網站集合功能;例如 InfoPath Forms Services、Visio Services, Access Services 及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。 
s05-SharePoint Server 發佈基礎結構;提供集中式程式庫、內容類型、主版頁面及版面配置，並讓網站集合可以使用頁面排程及其他發佈功能。 
s06-SharePoint Server 標準版網站集合功能;SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。 
s07-三態工作流程;使用此工作流程來追蹤清單中的項目。 
s08-工作流程;SharePoint 提供的現成工作流程功能彙總組合。 
s09-內容部署來源功能;內容部署來源功能可讓您在來源網站集合上執行內容部署的特定檢查，並可讓您設定從網站集合到目標網站集合的內容部署。  
s10-內容類型整合中樞;佈建網站以作為企業中繼資料中樞網站。 
s11-支援報告與資料搜尋;提供支援企業搜尋中心之報告與資料搜尋所需的內容類型、網站欄及文件庫範本。 
s12-文件庫和資料夾式保留;允許清單管理員覆寫內容類型保留排程，並在文件庫和資料夾上設定排程。 
s13-文件組;提供建立和使用文件組所需的內容類型。當您要將多份文件作為單一工作產品管理時，請建立文件組。 
s14-文件識別碼服務;為網站集合中的文件指派識別碼，這可以用來擷取與目前位置無關的項目。 
s15-自訂網站集合說明 ;建立可用於儲存此網站集合的自訂說明的說明庫。 
s16-限制存取使用者權限鎖定模式;啟用此功能後，將會減少 [限制存取] 權限等級中的使用者 (例如匿名使用者) 權限，以防止其存取應用程式頁面。 
s17-處理核准工作流程;由允許的參與者管理文件到期日與保留，並決定是否保留或刪除到期的文件。 
s18-報告;建立 Microsoft SharePoint Foundation 的資訊報告。 
s19-就地記錄管理;啟用可用記錄的定義和宣告。 
s20-發佈核准工作流程;安排頁面的核准流程。核准者可核准或拒絕頁面、重新指派核准工作，或是要求變更頁面。此工作流程可在 SharePoint Designer 中編輯。 
s21-視訊和多媒體 ;提供可用以儲存、管理與檢視圖像、音訊剪輯和視訊等多媒體資產的文件庫、內容類型和網頁組件。 
s22-搜尋引擎網站地圖; 此功能可以透過自動週期性產生包含 SharePoint 網站中所有有效 URL 的搜尋引擎網站地圖，改善網站的搜尋引擎最佳化。必須啟用匿名存取才能使用此功能。 
s23-跨伺服器陣列的網站權限;使用跨伺服器陣列的網站權限功能以允許內部 SharePoint 應用程式存取整個伺服器陣列中的網站。 
s24-跨網站集合發佈;啟用網站集合以將清單和文件庫指定為跨網站集合發佈的目錄來源。 
s25-預設以用戶端應用程式開啟文件;設定連至文件的連結，使文件依預設以用戶端應用程式開啟，而非 Web 應用程式。 
s26-網站原則   可讓網站集合管理員定義要套用至網站及其所有內容的保留排程。
#>



<#
W01-Access 應用程式  :Access Web App 
W02-BICenter 資料連線功能 ;BICenter 資料連線功能 
W03-PerformancePoint Services 網站功能:可啟用 PerformancePoint Services 清單和文件庫範本的功能。 
W04-SharePoint Server 企業版網站功能:例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。 
W05-SharePoint Server 發佈; 建立網頁庫及支援庫，以根據版面配置建立並發佈頁面。 
W06-SharePoint Server 標準版網站功能;SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。 
W07-Wiki 頁面首頁;此網站功能將會建立一個 Wiki 頁面，並將其設為您的網站首頁。 
W08-下列內容:讓使用者追蹤文件或網站。 
W09-小組共同作業清單;透過製作可使用的標準清單，如文件庫清單及議題清單，讓網站具有小組共同作業能力。 
W10-啟動  
W11-工作流程工作內容類型;將 SharePoint 2013 工作流程工作內容類型新增至網站中。 
W12-工作流程可以使用應用程式權限;允許工作流程從此網站的所有項目讀取，以及寫入此網站的所有項目。 
W13-中繼資料導覽和篩選;為網站中的每個清單提供一個設定頁面，設定讓該清單使用中繼資料樹狀檢視階層和篩選控制項，以改善瀏覽和篩選所含的項目。 
W14-內容組合管理;建立可將送出到此網站的內容移到正確文件庫或資料夾的中繼資料式規則。 
W15-內容管理互通性服務 (CMIS) 製作者;使用內容管理互通性服務 (CMIS) 標準，將此 SharePoint 網站中儲存的資料設為可用。  
W16-外部系統事件;這項功能可在外部清單和外部內容類型啟用提醒和事件接收器。 
W17-行動裝置瀏覽器檢視;使用 Smartphone 瀏覽器的行動裝置檢視，提供小組網站上的文件庫及其他清單。 
W18-快速入門;提供常用 SharePoint 網站動作的並排檢視使用體驗。 
W19-社群網站功能;此功能可新增討論區類別、內容與人員評價，以及成員清單等社群功能。另外也可佈建包含這些清單與功能的社群網站頁面。 
W20-保留;使用此功能以追蹤訴訟、調查或稽核等需要暫停文件處理的外部動作。 
W21-基本下載策略;在支援這項技術的網頁及網站範本，這項技術透過只下載並呈現網頁變更的部分，讓頁面導覽更加快速流暢。 
W22-專案功能;此功能會將專案管理功能新增至網站。這其中包括工作、行事曆及網站首頁的網頁組件。 
W23-搜尋設定清單執行個體功能;建立搜尋設定清單執行個體: 佈建一份清單，以啟用搜尋設定的匯入與匯出 
W24-搜尋設定資料的內容類型;安裝專門用於管理搜尋設定的內容類型。 
W25-搜尋設定資料網站欄;安裝專門用來管理搜尋設定相關資訊的欄。 
W26-搜尋設定範本功能;建立搜尋設定範本: 佈建一個範本，以供「搜尋設定清單」啟用搜尋設定的匯入與匯出 
W27-網站信箱;網站信箱應用程式能透過將您的網站連線到 Exchange 信箱，協助您將電子郵件和文件集中處理。如此一來，您就可以在 SharePoint 上檢視電子郵件，並在 Outlook 中檢視網站文件。 
W28-網站筆記本;在 [共用文件] 庫中建立 Microsoft OneNote 2010 筆記本，然後在 [快速啟動] 上新增其連結。此功能必須搭配妥善設定的 WOPI 應用程式伺服器，才能建立 OneNote 2010 筆記本。 
W29-網站摘要;啟用網站摘要使用。 
W30-課程 Web 類型;新增必要的內容類型至 SharePoint 課程 Web。 
W31-課程「我的網站主機」內容;新增課程與群組內容至 SharePoint「我的網站主機」網站集合。 
W32-離線同步處理外部清單;在外部清單和 Outlook 之間啟用離線同步處理。
#>

AccSrvApplication-Access Services 2010 伺服陣列功能-新增伺服陣列層級的 Access Services 2010 功能至 Microsoft SharePoint Foundation 架構-Farm
AccSrvSolutionGalleryStapler-Access Services 解決方案庫功能裝訂器-啟用已建立的每個網站集合的 Access Services 解決方案庫功能。-Farm
AccSvcAddAccessAppStapling-Access Service 新增 Access 應用程式功能裝訂器-啟用已建立之各網站的 Access Services 新增 Access 應用程式功能。-Farm
AccSvcApplication-Access Services 伺服器陣列功能-新增伺服器陣列層級的 Access Services 功能至 Microsoft SharePoint Foundation 架構-Farm
AdminReportCorePushdown-Administrative Reporting Core Pushdown Feature-This feature activates the Administrative Reporting Infrastructure feature in all site templates.-Farm
AutohostedAppLicensingStapling-自動裝載的應用程式授權功能裝訂-啟用應用程式目錄網站的自動裝載應用程式授權 UI。-Farm
BaseSiteStapling-Base Site Features Stapling-Staple Base features-Farm
BulkWorkflow-Bulk workflow process button-Adds the process all tasks button to complete workflows in bulk-Farm
CollaborationMailboxFarm-網站信箱-為此伺服器陣列上的網站啟用  Exchange 信箱佈建，並從網站將文件連接到 Outlook。-Farm
ContentFollowingStapling-內容追蹤裝訂-啟動所有網站集合上的內容追蹤功能。-Farm
ContentLightup-標準使用者介面項目-提供數個標準使用者介面元件與連結。-Farm
ContentTypeSettings-標準內容類型設定連結-提供「內容類型設定」頁面的標準連結。-Farm
DataConnectionLibraryStapling-資料連線庫-新增資料連線庫功能-Farm
DMContentTypeSettings-DM Content Type Setting Links-DLC Document Management content type setting links.-Farm
DownloadFromOfficeDotCom-從 SharePoint 的 Office.com 的進入點-此功能提供從 SharePoint 使用者介面的進入點，允許使用者從 Office.com 瀏覽 SharePoint 方案-Farm
EduFarmWebApplication-課程 Web 應用程式設定-在 SharePoint Web 應用程式中安裝課程與群組設定。-Farm
EnhancedHtmlEditing-增強型 HTML 編輯-內容編輯器網頁組件的增強型 HTML 編輯-Farm
ExcelServer-Excel Services 應用程式檢視伺服器陣列功能-新增伺服器陣列層級的 Excel Services 應用程式檢視功能至 Microsoft SharePoint Foundation 架構-Farm
ExcelServerWebPartStapler-Excel Services 應用程式網頁組件伺服器陣列功能-新增伺服器陣列層級的 Excel Services 應用程式網頁組件功能至 Microsoft SharePoint Foundation 架構-Farm
ExchangeSync-伺服器陣列層級 Exchange 任務同步處理-為 Work Management Service Application 啟用 Exchange 同步計時器工作。自訂 SharePoint Server 工作清單的功能區，讓使用者選擇是否要將 Work Management 與 Exchange Server 同步處理。-Farm
FeaturePushdown-Feature Pushdown Links-Link to display the feature pushdown page-Farm
GlobalWebParts-全域網頁組件-安裝與所有網站類型通用的其他網頁組件。-Farm
ipfsAdminLinks-InfoPath Forms Services 的管理連結。-InfoPath Forms Services 管理連結。-Farm
ListTargeting-選取目標清單內容-在「清單設定」頁面安裝一個按鈕，讓您可以使用對象來選取目標內容。-Farm
ManageUserProfileServiceApplication-Manage Profile Service Application-Manage Profile Service Application.-Farm
MasterSiteDirectoryControl-SharePoint Portal Server 主網站目錄擷取控制-SharePoint Portal Server 主網站目錄擷取控制。-Farm
MBrowserRedirectStapling-行動裝置瀏覽器檢視功能裝訂-啟用行動裝置瀏覽器檢視功能裝訂-Farm
MobileEwaFarm-Excel Services 應用程式 Mobile Excel Web Access 功能-新增伺服器陣列層級的 Excel Services 應用程式 Mobile Excel Web Access 功能至 Microsoft SharePoint Foundation 架構-Farm
MonitoredAppsUI-應用程式監視使用者介面-可讓承租人管理員和管理中心監視應用程式-Farm
MySite-我的網站-安裝與我的網站及使用者設定檔相關的功能。-Farm
MySiteCleanup-My Site Cleanup Feature-Installs and uninstalls Farm-level job for My Site Cleanup.-Farm
MyTasksDashboardCustomRedirect-我的任務儀表板自訂重新導向-這項功能可從連結的 SharePoint 任務重新導向回我的網站。-Farm
MyTasksDashboardStapling-我的任務儀表板裝訂-此功能會將 [我的工作儀表板] 功能裝釘 (連線) 至 [我的網站] 範本。-Farm
ObaProfilePagesTenantStapling-BDC 設定檔頁面承租人裝訂功能-將設定檔頁面功能裝訂至使用承租人管理範本的網站。-Farm
ObaStaple-離線同步處理外部清單-啟用外部清單與 Outlook 及 SharePoint Workspace 的離線同步處理。-Farm
OrganizationsClaimHierarchyProvider-組織宣告階層提供者-安裝以組織為基礎的宣告階層提供者。-Farm
OSearchCentralAdminLinks-搜尋管理中心連結-搜尋管理中心連結。-Farm
OSearchHealthReportsPushdown-Health Reports Pushdown Feature-This feature activates the Health ReportsLibrary.-Farm
OSearchPortalAdminLinks-搜尋管理入口網站連結及導覽列-預設搜尋入口網站管理連結。-Farm
PPSSiteStapling-PPS 網站裝訂-PPS 網站裝訂-Farm
PremiumSiteStapling-Premium Site Features Stapling-Staple Premium features-Farm
ProfileSynch-設定檔同步處理功能-安裝將使用者設定檔及成員資格與小組網站同步處理的工作。-Farm
PublishingStapling-Publishing Features Stapling-Staple Publishing features-Farm
RecordsManagement-記錄管理-新增記錄管理和資訊管理原則功能至 Microsoft SharePoint Foundation。-Farm
RecordsManagementTenantAdminStapling-記錄管理承租人管理裝訂-記錄管理承租人管理裝訂。-Farm
SearchConfigTenantStapler-$Resources:SearchConfigTenantStapler_Feature_Title;-Resources:SearchConfigTenantStapler_Feature_Description;-Farm
SearchWebPartsStapler-Search Server 網頁組件和支援檔案裝訂器-此功能可將 Search Server 網頁組件和支援檔案功能裝訂到所有範本。-Farm
SharedServices-Shared Services Infrastructure-Shared Services Infrastructure-Farm
ShareWithEveryoneStapling-「與所有人共用」功能裝訂-「與所有人共用」功能的功能裝訂-Farm
SiteFeedStapling-網站摘要功能裝訂-將網站摘要功能裝訂到所有新的「小組網站」網站集合。-Farm
SiteSettings-標準網站設定連結-提供網站標準網站設定的支援。-Farm
SiteStatusBar-Site status bar-在 [共用文件] 庫中建立 Microsoft OneNote 2010 筆記本，然後在 [快速啟動] 上新增其連結。此功能必須搭配妥善設定的 WOPI 應用程式伺服器，才能建立 OneNote 2010 筆記本。-Farm
SkuUpgradeLinks-Sku Upgrade Links-Link to display the portal to office server sku upgrade page-Farm
SlideLibraryActivation-Slide Library Activation--Farm
SocialRibbonControl-社交標記與記事區功能區控制項-新增社交標記的進入點，以及用於註解功能區使用者介面的記事區。-Farm
SPAppAnalyticsUploaderJob-上傳應用程式分析工作-將彙總應用程式使用狀況資料上傳到 Microsoft。Microsoft 會使用這項資料來改善服務商場的應用程式品質。如果您有多個內容伺服器陣列連接到同一個搜尋伺服器，只要在其中一個伺服器陣列上啟動這項功能即可。-Farm
SpellChecking-拼字檢查-在清單項目編輯表單中啟用拼字檢查。-Farm
SPSBlogStapling-$Resources:spscore,SPSBlogStaplingFeature_Title;-此功能會將部落格通知與喜歡功能裝訂至部落格網站範本-Farm
SPSDisco-入口網站 DiscoPage 功能-設定 spsdisco.aspx 之預設 Web 服務 DiscoPage 屬性的入口網站功能。-Farm
SRPProfileAdmin-使用者設定檔管理連結-安裝與管理 User Profile Service 相關的連結。-Farm
StapledWorkflows-Office Workflows-Workflows activated automatically upon site collection creation-Farm
TaxonomyFeatureStapler-Taxonomy feature stapler-Staples the Field Added feature to all sites created-Farm
TaxonomyTenantAdminStapler-Taxonomy Tenant Administration Stapler-Activates taxonomy related features in the tenant administration site.-Farm
TemplateDiscovery-[連線至 Office] 功能區控制項-如果使用者已安裝最新的 Office 版本，在功能區使用者介面新增進入點，以在使用者的 SharePoint 網站清單中建立文件庫捷徑。Office 會定期快取使用者本機電腦上文件庫中可用的範本。-Farm
TenantAdminBDCStapling-承租人 Business Data Connectivity 管理裝訂-將承租人 Business Data Connectivity 管理功能裝訂至承租人管理範本-Farm
TenantAdminSecureStoreStapling-Secure Store Service 裝訂功能-將 Secure Store Service 承租人管理裝訂至承租人管理範本。-Farm
TenantProfileAdminStapling-承租人使用者設定檔應用程式裝訂-將承租人使用者設定檔應用程式功能裝訂到 TenantAdmin 範本-Farm
TenantSearchAdminStapling-$Resources:TenantAdmin_SearchAdminFeatureStapling_Title;-$Resources:TenantAdmin_SearchAdminFeatureStapling_Description;-Farm
TransMgmtFunc-翻譯管理庫-新增用於管理文件翻譯程序的翻譯庫範本。-Farm
UPAClaimProvider-SharePoint Server 對伺服器的驗證-此功能提供伺服器對伺服器的驗證功能-Farm
UserMigrator-共用服務提供者使用者移轉程式-當使用者帳戶資訊變更時，安裝與移轉使用者資料相關的功能。-Farm
UserProfileUserSettingsProvider-使用者設定檔使用者設定提供者-這項功能可佈建使用者設定檔使用者設定提供者。-Farm
VisioProcessRepositoryFeatureStapling-Visio 程序存放庫-Visio 程序存放庫文件庫功能-Farm
VisioServer-Visio Web Access-在瀏覽器中檢視 Visio Web 繪圖-Farm
WorkflowServiceStapler-workflow service stapler-workflow service stapler-Farm
BaseWebApplication-SharePoint Server 標準版 Web 應用程式功能-SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。-WebApplication
BICenterFeatureStapler-BICenter 功能裝訂器功能-BICenter 功能裝訂器功能-WebApplication
BulkWorkflowTimerJob-Bulk Workflow Timer Job-The timer job that processes workflow tasks in bulk-WebApplication
ContentTypeSyndication-Content type syndication-Content type syndication.-WebApplication
CorporateCuratedGallerySettings-應用程式目錄設定-儲存應用程式目錄網站的設定-WebApplication
docmarketplacesafecontrols-學術文件庫網站安全控制項。-佈建用於學術文件庫網站中的安全控制項。-WebApplication
DocumentManagement-「文件組」中繼資料同步處理-提供為「文件組」同步處理中繼資料的基礎結構。-WebApplication
EduWebApplication-課程 Web 應用程式-在 SharePoint Web 應用程式上啟用課程與群組。-WebApplication
EmailTemplates-電子郵件範本功能-傳送一些 SharePoint 通知所用的電子郵件範本-WebApplication
IfeDependentApps-需要可存取之網際網路對應端點的應用程式-允許使用者從 SharePoint 市集取得需要網際網路對應端點的應用程式。-WebApplication
MySiteInstantiationQueues-我的網站具現化佇列計時器工作-在所有已建立的 Web Apps 上新增我的網站具現化佇列計時器工作-WebApplication
OSearchBasicFeature-SharePoint Server 網站搜尋-使用 Search Server 服務，以便對網站及清單範圍搜尋。-WebApplication
OSearchEnhancedFeature-SharePoint Server 企業版搜尋-使用 Search Server 服務，以便對廣大的企業內容搜尋。除了清單及網站範圍之外，還提供人員設定檔、商務資料、遠端及自訂內容來源的搜尋。搜尋中心會使用多個索引標籤來顯示結果。-WebApplication
PageConverters-文件轉頁面轉換程式-包含用來將文件轉換為發佈頁面的轉換程式。-WebApplication
PremiumWebApplication-SharePoint Server 企業版 Web 應用程式功能-例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。-WebApplication
PublishingTimerJobs-Publishing Timer Jobs-Create Publishing timer jobs in the web application to support scheduling and variations.-WebApplication
SearchAndProcess-搜尋與處理-提供搜尋與處理計時器工作。-WebApplication
SiteUpgrade-網站升級連結-提供網站的標準網站升級連結。-WebApplication
SPSearchFeature-Microsoft SharePoint Foundation 搜尋功能-Microsoft SharePoint Foundation 搜尋功能-WebApplication
TaxonomyTimerJobs-Create the taxonomy timer jobs-Creates the taxonomy timer jobs on all web apps being created-WebApplication
TranslationTimerJobs-Translation Timer Jobs-Creates timer jobs in the web application to support translation import and export.-WebApplication
AccSrvSolutionGallery-Access Services 解決方案庫-方便上傳 Access 範本檔案至解決方案庫。-Site
AdminReportCore-Administrative Reporting Infrastructure-Library for administrative reporting.-Site
AppRegistration-允許註冊 SharePoint 應用程式-$Resources:Core,AppRegistrationTitleFeatureDescription;-Site
AssetLibrary-Asset Library-Enable Asset Library Creation for site collection.-Site
AutohostedAppLicensing-自動裝載的應用程式授權功能-將自動裝載的應用程式授權 UI 元素新增至「內部應用程式目錄」。-Site
"S06"BaseSite-SharePoint Server 標準版網站集合功能-SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。-Site
BasicWebParts-基本網頁組件-網站集合網頁組件目錄中可以使用下列網頁組件: 網頁檢視器、內容編輯器、圖像、表單、XML 及網站使用者清單。-Site
BizAppsCTypes-SharePoint Portal Server Business Appications Content Type Definition-SharePoint Portal Server Business Appication content type definitions-Site
BizAppsFields-SPS Biz Apps Field Definition-OOB field definitions for Biz Apps-Site
BizAppsSiteTemplates-BizApps Site Templates-SharePoint Portal site templates and web parts-Site
CommunityPortal-社群入口網站功能-此功能加入了社區入口網站功能。它也會佈建社群入口網站頁面。-Site
ContentDeploymentSource-內容部署來源功能-內容部署來源功能可讓您在來源網站集合上執行內容部署的特定檢查，並可讓您設定從網站集合到目標網站集合的內容部署。 -Site
ContentFollowing-追蹤內容-可讓使用者追蹤文件或網站。-Site
ContentFollowingList-追蹤內容清單-此功能會封裝可讓使用者在 SharePoint 追蹤內容的清單。-Site
ContentTypeHub-內容類型整合中樞-佈建網站以作為企業中繼資料中樞網站。-Site
CrossFarmSitePermissions-跨伺服器陣列的網站權限-使用跨伺服器陣列的網站權限功能以允許內部 SharePoint 應用程式存取整個伺服器陣列中的網站。-Site
CrossSiteCollectionPublishing-跨網站集合發佈-啟用網站集合以將清單和文件庫指定為跨網站集合發佈的目錄來源。-Site
CTypes-標準內容類型定義-提供網站集合的標準內容類型定義。-Site
Developer-開發人員功能-協助開發人員建置、測試及發佈應用程式的功能-Site
DocId-文件識別碼服務-為網站集合中的文件指派識別碼，這可以用來擷取與目前位置無關的項目。-Site
DocumentRoutingResources-文件傳閱資源-在此網站集合內的網站中，佈建傳閱文件所需的資源。-Site
DocumentSet-文件組-提供建立和使用文件組所需的內容類型。當您要將多份文件作為單一工作產品管理時，請建立文件組。-Site
EawfSite-中文簽核流程-此網站集合功能提供中文簽核流程。您之後必須啟動「中文簽核流程」網站功能，才能使用此功能。-Site
EDiscoveryConsole-eDiscovery 入口網站-建立及管理 eDiscovery 案例。-Site
EduAdminPages-課程管理頁面-新增頁面至 SharePoint Online，以管理課程和機構資料。-Site
EduCommunityCustomSiteActions-課程社群網站動作-新增課程與群組網站動作至 SharePoint 社群網站集合。-Site
EduCommunitySite-社群清單-新增課程與群組清單至 SharePoint 社群網站集合。-Site
EduCourseCommunitySite-課程清單-新增必要清單至 SharePoint 課程網站集合。-Site
EduInstitutionAdmin-大量要求與回應清單-在管理網站上安裝大量要求與回應清單，以管理課程和使用者。-Site
EduSearchDisplayTemplates-課程搜尋顯示範本-安裝用來顯示搜尋結果的課程與群組顯示範本。-Site
EduShared-課程共用內容-新增 SharePoint 網站集合共用的課程與群組內容。-Site
EnableAppSideLoading-啟用 Office 及 SharePoint 相關應用程式側載-這項功能可讓開發人員將正在開發中的應用程式部署至網站。-Site
EnhancedTheming-Enhanced Theming-Enable enhanced .thmx theming.-Site
EnterpriseWikiLayouts-企業 Wiki 版面配置-建立包含類別和版面配置的大型 Wiki。-Site
ExcelServerEdit-已取代的 Office Web Apps-已取代的 Office Web Apps-Site
ExcelServerSite-Excel Services 應用程式檢視網站功能-新增網站層級的 Excel Services 應用程式檢視功能至 Microsoft SharePoint Foundation 架構-Site
ExcelServerWebPart-Excel Services 應用程式網頁組件網站功能-新增網站層級的 Excel Services 應用程式網頁組件功能至 Microsoft SharePoint Foundation 架構-Site
ExpirationWorkflow-處理核准工作流程-由允許的參與者管理文件到期日與保留，並決定是否保留或刪除到期的文件。-Site
FastCentralAdminHelpCollection-FAST Search 管理中心說明集合-啟用 FAST Search 管理中心說明集合-Site
FastEndUserHelpCollection-FAST Search 一般使用者說明集合-啟用 FAST Search 一般使用者說明集合-Site
Fields-標準欄定義-提供網站集合的標準欄定義。-Site
HelpLibrary-說明-建立可用於儲存產品說明的說明庫。-Site
HtmlDesign-Html Design-Enable Html Design.-Site
InPlaceRecords-就地記錄管理-啟用可用記錄的定義和宣告。-Site
IPFSSiteFeatures-InfoPath Forms Services 支援-讓伺服器端轉譯表單的 InfoPath Forms Services 清單及相關頁面。-Site
IssueTrackingWorkflow-三態工作流程-使用此工作流程來追蹤清單中的項目。-Site
ItemFormRecommendations-項目表單建議-新增建議的 CBS 控制項至所有項目顯示表單。-Site
'S03'LegacyWorkflows-SharePoint 2007 工作流程-SharePoint 2007 提供的現成工作流程功能彙總組合。-Site
LocalSiteDirectoryControl-SharePoint Portal Server Local Site Directory Capture Control-SharePoint Portal Server Local Site Directory Capture Control-Site
LocalSiteDirectorySettingsLink-Site Settings Link to Local Site Directory Settings page.-Site Settings Link to Local Site Directory Settings page.-Site
LocationBasedPolicy-文件庫和資料夾式保留-允許清單管理員覆寫內容類型保留排程，並在文件庫和資料夾上設定排程。-Site
MediaWebPart-Media Web Part-Enable MediaWebPart for site collection.-Site
MobileExcelWebAccess-Excel Services 應用程式 Mobile Excel Web Access 功能-新增網站層級的 Excel Services 應用程式 Mobile Excel Web Access 功能至 Microsoft SharePoint Foundation 架構-Site
MonitoredApps-應用程式監視-可讓承租人管理員和管理中心監視應用程式-Site
MossChart-圖表網頁組件-可協助您將 SharePoint 網站和入口網站上的資料視覺化。-Site

MySiteBlog-My Site Blogs-Installs My Site Blog features.-Site
MySiteDocumentLibrary-我的網站文件庫功能-強化 [我的網站] 中現有的 SharePoint 文件庫。提供新檢視、輕量版本設定、增強式內容資訊，以及個別項目共用。-Site
MySiteHost-我的網站主機-安裝與架設我的網站相關的功能。-Site
MySiteLayouts-我的網站版面配置功能-「我的網站」的功能，可將所有版面配置上傳到主版頁面圖庫。-Site
MySiteMaster-我的網站主版功能-「我的網站」功能，可將主版頁面上傳到主版頁面圖庫。-Site
MySiteMicroBlogCtrl-MySite MicroBlogging-Enables MySite MicroBlogging services.-Site
MySitePersonalSite-「我的網站」個人網站設定-設定使用者的個人網站。-Site
MySiteSocialDeployment-MySite Social Deployment Scenario-Enables MySite social features.-Site
MySiteStorageDeployment-MySite Storage Deployment Scenario-Enables MySite storage features.-Site
MySiteUnifiedQuickLaunch-我的網站單一快速啟動功能-顯示主機與個人網站之相同快速啟動的「我的網站」功能。-Site


Navigation-Portal Navigation-Enable portal navigation bars.-Site
OfficeWebApps-已取代的 Office Web Apps-已取代的 Office Web Apps-Site
OffWFCommon-Microsoft Office Server workflows-This feature provides support for Microsoft Office Server workflows.-Site
OnenoteServerViewing-已取代的 Office Web Apps-已取代的 Office Web Apps-Site
OpenInClient-預設以用戶端應用程式開啟文件-設定連至文件的連結，使文件依預設以用戶端應用程式開啟，而非 Web 應用程式。-Site
OSSSearchEndUserHelpFeature-$Resources:SearchEndUserHelp_Feature_Title;-$Resources:SearchEndUserHelp_Feature_Description;-Site
OSSSearchSearchCenterUrlSiteFeature-Site collection level Search Center Url Feature-adds the url of search center in the property bag of root web.-Site
PortalLayouts-入口網站配置功能-將所有配置上傳到主版頁面圖庫的入口網站功能。-Site
PPSMonDatasourceCtype-PerformancePoint 資料來源內容類型定義-PerformancePoint 資料來源內容類型定義-Site
PPSRibbon-PerformancePoint 功能區--Site
"S01"PPSSiteCollectionMaster-PerformancePoint Services 網站集合功能-可啟用 PerformancePoint Services 的功能，包括此網站集合的內容類型和網站定義。-Site
PPSWebParts-PerformancePoint 監控-PerformancePoint 監控-Site
PPSWorkspaceCtype-PerformancePoint 內容類型定義-PerformancePoint 內容類型定義-Site
"S04"PremiumSite-SharePoint Server 企業版網站集合功能-例如 InfoPath Forms Services、Visio Services, Access Services 及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。-Site
Preservation-保留清單-用來建立保留清單的清單範本。-Site
ProductCatalogListTemplate-產品目錄清單範本-建立要用於產品目錄網站的清單範本-Site
ProductCatalogResources-產品目錄網站-佈建用於產品目錄網站的資源-Site
ProjectBasedPolicy-網站原則-可讓網站集合管理員定義要套用至網站及其所有內容的保留排程。-Site
PublishingLayouts-版面配置與主版頁面套件-發佈版面配置-Site
PublishingMobile-行動和替代裝置目標-可讓網站集合定義允許將網站上自訂最佳化頁面版本提供給行動與替代裝置的裝置通道。-Site
PublishingPrerequisites-Publishing Prerequisites-Enable Publishing prerequisites for site collection.-Site
PublishingResources -Publishing Resources-Enable Publishing for site collection.-Site
"S05"PublishingSite -SharePoint Server 發佈基礎結構-提供集中式程式庫、內容類型、主版頁面及版面配置，並讓網站集合可以使用頁面排程及其他發佈功能。-Site
QueryBasedPreservation-以查詢為基礎的就地保留-啟用以查詢為基礎的保留時，保留文件庫中儲存的內容若與此網站任何保留篩選不相符則會過期。此功能通常應用於有多個同時保留的封存網站。-Site
Ratings-評等-使用此功能讓使用者對內容進行評價。-Site
RecordResources-記錄資源-在此網站集合內的網站中，佈建建立記錄或保留所需的資源。-Site
Reporting-報告-建立 Microsoft SharePoint Foundation 的資訊報告。-Site
ReportsAndDataCTypes-SharePoint Portal Server Reports And Data Content Type Definition-SharePoint Portal Server Reports and Data content type definitions-Site
ReportsAndDataFields-SPS Reports and Data Field Definition-OOB field definitions for Reports and Data-Site
ReportsAndDataListTemplates-支援報告與資料搜尋-提供支援企業搜尋中心之報告與資料搜尋所需的內容類型、網站欄及文件庫範本。-Site
ReviewPublishingSPD-發佈核准工作流程-安排頁面的核准流程。核准者可核准或拒絕頁面、重新指派核准工作，或是要求變更頁面。此工作流程可在 SharePoint Designer 中編輯。-Site
ReviewPublishingSPD1028-Publishing Workflow - SharePoint 2013  (zh-tw)-This feature provides Publishing Approval workflow for a language (zh-tw)-Site
ReviewWorkflows-傳閱工作流程-傳送文件尋求意見反應或核准的工作流程。-Site
ReviewWorkflowsSPD-傳閱工作流程 - SharePoint 2010-傳送文件以尋求意見反應或核准的工作流程。在 SharePoint Designer 中可以編輯這些工作流程。-Site
ReviewWorkflowsSPD1028-Routing Workflows - SharePoint 2013  (zh-tw)-This feature provides Routing Workflows for a language (zh-tw)-Site
RollupPageLayouts-彙總版面配置-建立字詞導向彙總頁面和版面配置。-Site
SearchDrivenContent-搜尋導向內容-啟用搜尋導向內容網頁組件和其他相關功能。-Site
SearchEngineOptimization-搜尋引擎最佳化功能-搜尋引擎最佳化功能可啟用 SEO 特定 HTML 中繼元素、SEO 屬性特殊化編輯，以及其他項目。-Site
SearchExtensions-SearchExtensions-搜尋副檔名-Site
"S02"SearchMaster-Search Server 網頁組件和範本-此功能可將 Search Server 網頁組件和顯示範本新增至您的網站。即使不啟動此功能，搜尋也可以在大多數網站上運作，但如果您在搜尋時收到遺失範本的訊息，那麼請啟動此功能。-Site
SearchServerWizardFeature-$Resources:SearchServerWizard_Feature_Title;-$Resources:SearchServerWizard_Feature_Desc;-Site
SearchTaxonomyRefinementWebParts-Search Server 網頁組件和支援檔案-此功能可上傳分類精簡搜尋所需的所有網頁組件和支援檔案。-Site
SearchTaxonomyRefinementWebPartsHtml-Search Server 網頁組件和支援檔案-此功能可上傳分類精簡搜尋網頁組件所需的 HTML 檔案。-Site
SearchTemplatesandResources-搜尋和內容網頁組件的顯示範本-建立可供內容網頁組件使用的顯示範本。-Site
SearchWebParts-Search Server 網頁組件和支援檔案-此功能可上傳搜尋中心所需的所有網頁組件和支援檔案。-Site
ShareWithEveryone-與所有人共用-改善「與所有人共用」UI 所需的功能-Site
SignaturesWorkflow-收集簽章工作流程-收集完成 Microsoft Office 文件 所需的簽章。-Site
SignaturesWorkflowSPD-收集簽章工作流程 - SharePoint 2010-收集完成 Microsoft Office 文件所需的簽章。在 SharePoint Designer 中可以編輯此工作流程。-Site
SignaturesWorkflowSPD1028-Collect Signatures Workflow - SharePoint 2013  (zh-tw)-This feature provides Collect Signatures workflow for a language (zh-tw)-Site
SiteHelp-自訂網站集合說明-建立可用於儲存此網站集合的自訂說明的說明庫。-Site
SiteServicesAddins-Site Services Addins-Add and configure site services addins.-Site
SmallBusinessWebsite-Small Business Website-Create a Small Business Website.-Site
SocialDataStore-社交資料儲存區-提供社交功能的資料支援-Site
SocialSite-社群網站基礎結構-社群中討論區清單、評價、類別及成員資格的必要網站集合層級欄位、內容類型和網頁組件。-Site
TaxonomyFieldAdded-Register taxonomy site wide field added event receiver-Registers the field added event on all SPSites being created-Site
TopicPageLayouts-主題版面配置-建立字詞導向主題頁面與版面配置。-Site
Translation-Translation-Enables translation for Publishing Pages.-Site
TranslationWorkflow-翻譯管理工作流程-透過建立要翻譯文件的複本，並指派翻譯工作給譯者來管理文件翻譯工作。-Site
V2VPublishedLinks-V2V Published Links Upgrade-Add Published Links fields and content type-Site
V2VPublishingLayouts-V2V Publishing Layouts Upgrade-Add new masterpages and CSS styles-Site
VideoAndRichMedia-視訊和多媒體-提供可用以儲存、管理與檢視圖像、音訊剪輯和視訊等多媒體資產的文件庫、內容類型和網頁組件。-Site
ViewFormPagesLockDown-限制存取使用者權限鎖定模式-啟用此功能後，將會減少 [限制存取] 權限等級中的使用者 (例如匿名使用者) 權限，以防止其存取應用程式頁面。-Site
VisioWebAccess-Visio Web Access-在瀏覽器中檢視 Visio Web 繪圖-Site
WAWhatsPopularWebPart-Web Analytics 網頁組件-此功能是一個網頁組件，可顯示常用的內容、搜尋查詢及搜尋結果。-Site
WebPartAdderGroups-網頁組件新增項目預設群組-新增其他預設群組至網頁組件圖庫的 QuickAddGroups 欄-Site
WordServerViewing-已取代的 Office Web Apps-已取代的 Office Web Apps-Site
Workflows-工作流程-SharePoint 提供的現成工作流程功能彙總組合。-Site
XmlSitemap-搜尋引擎網站地圖-此功能可以透過自動週期性產生包含 SharePoint 網站中所有有效 URL 的搜尋引擎網站地圖，改善網站的搜尋引擎最佳化。必須啟用匿名存取才能使用此功能。-Site
AbuseReportsList-提報-此功能包含的清單結構描述與清單執行個體可用於管理社群網站內的攻擊性內容-Web
AccessRequests-存取要求清單-允許管理 Sharepoint 網站的存取要求-Web
AccSrvMSysAso-Access Services System Objects-Access Services System Objects-Web
AccSrvRestrictedList-Access Services Restricted List Definition-Access Services Restricted List Definition-Web
AccSrvShell-Access Services 命令介面-新增 Access Services 網站動作功能表項目。-Web
AccSrvUserTemplate-Access Services 使用者範本-方便從已上傳的 Access 範本檔案建立新網站。-Web
AccSrvUSysAppLog-Access Services User Application Log-Access Services User Application Log-Web
AccSvcAddAccessApp-Access 應用程式-Access Web App-Web
AccSvcShell-Access Services 命令介面-新增 Access Services 網站動作功能表項目。-Web
AddDashboard-Add Dashboard-Installs the "Add Dashboard" Link in Site Actions menu.-Web
AdminLinks-管理中心連結-管理中心中操作與應用程式管理頁面的連結。-Web
AnnouncementsList-宣告清單-提供網站宣告清單的支援。-Web
AppLockdown---Web
AppRequestsList-應用程式要求清單-佈建位置以儲存 SharePoint 應用程式要求。-Web
BaseWeb-SharePoint Server 標準版網站功能-SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。-Web
BcsEvents-外部系統事件啟動項-這項功能可藉由啟動相關功能，在「外部清單」和「外部內容類型」中啟用「提醒」和「事件接收器」。-Web
BDR-文件中心增強功能-提供瀏覽網站的樹狀檢視。-Web
BICenterDashboardsLib-儀表板庫-儀表板庫描述-Web
BICenterDataConnections-BICenter 資料連線功能-BICenter 資料連線功能-Web
BICenterDataconnectionsLib-PerformancePoint 資料連線庫-包含 ODC、UDC 和 PerformancePoint 資料連線。-Web
BICenterDataConnectionsListInstance-BICenter 資料連線清單執行個體功能-BICenter 資料連線清單執行個體功能-Web
BICenterPPSContentPages-BICenter PPS 內容頁面功能-BICenter PPS 內容頁面功能-Web
BICenterPPSNavigationLink-BICenter PPS 內容導覽列功能-BICenter PPS 內容導覽列功能-Web
BICenterPPSWorkspaceListInstance-BICenter PPS 工作區清單執行個體功能-BICenter PPS 工作區清單執行個體功能-Web
BICenterSampleData-商務智慧中心範例資料-商務智慧中心範例資料的功能，可將範例資料加入新建立的商務智慧中心網站。-Web
BizAppsListTemplates-SharePoint Portal Server Status Indicator List template-SharePoint Portal Server Status Indicator List template-Web
BlogContent-$Resources:core,blogContentFeatureTitle;-$Resources:core,blogContentFeatureDesc;-Web
BlogHomePage-Blog Home Page-Creates the default.aspx page for the a Blog site-Web
BlogSiteTemplate-部落格網站功能-$Resources:core,blogFeatureDesc;-Web
CallTrackList-Phone Call Memo List-此功能支援 [電話備忘錄] 清單類型。-Web
CategoriesList-類別清單功能-這項功能包含類別清單功能的範本-Web
CirculationList-Circulation List-此功能支援 [資訊流通] 清單類型。-Web
CmisProducer-內容管理互通性服務 (CMIS) 製作者-使用內容管理互通性服務 (CMIS) 標準，將此 SharePoint 網站中儲存的資料設為可用。  -Web
CollaborationMailbox-網站信箱-網站信箱應用程式能透過將您的網站連線到 Exchange 信箱，協助您將電子郵件和文件集中處理。如此一來，您就可以在 SharePoint 上檢視電子郵件，並在 Outlook 中檢視網站文件。-Web
CommunitySite-社群網站功能-此功能可新增討論區類別、內容與人員評價，以及成員清單等社群功能。另外也可佈建包含這些清單與功能的社群網站頁面。-Web
ContactsList-連絡人清單-提供網站連絡人清單的支援。-Web
ContentTypePublish-Content type publishing-Content type publishing.-Web
CorporateCatalog-應用程式目錄-佈建目錄以將應用程式散佈到您的組織-Web
CustomList-自訂清單-提供網站自訂清單的支援。-Web
DataConnectionLibrary-Data Connections Feature--Web
DataSourceLibrary-資料來源程式庫-提供網站資料來源程式庫的支援。-Web
DeploymentLinks-Content Deployment-OOB Content Deployment Feature.-Web
DiscussionsList-討論區清單-提供網站討論區的支援。-Web
docmarketplace-學術文件庫網站-學術文件庫網站。-Web
docmarketplacesampledata-學術文件庫網站範例資料-佈建學術文件庫網站的範例資料。-Web
DocumentLibrary-文件庫-提供網站文件庫的支援。-Web
DocumentRouting-內容組合管理-建立可將送出到此網站的內容移到正確文件庫或資料夾的中繼資料式規則。-Web
EawfWeb-中文簽核流程-此網站功能提供中文簽核流程。此功能只能從網站集合的根網站啟動。必須先啟動「中文簽核流程」網站集合功能。-Web
EDiscoveryCaseResources-eDiscovery 案例功能-佈建 eDiscovery 案例所需的資源。-Web
EduAdminLinks-課程管理中心連結-新增連結至 SharePoint 管理中心，以管理課程和機構資料。-Web
EduCommunity-課程社群 Web 類型-新增課程與群組內容類型至 SharePoint 社群 Web。-Web
EduCourseCommunity-課程 Web 類型-新增必要的內容類型至 SharePoint 課程 Web。-Web
EduDashboard-課程與「我的網站」內容-新增課程與群組內容至 SharePoint 課程與「我的網站」集合。-Web
EduInstitutionSiteCollection-課程管理清單-在 SharePoint 全域網站集合上安裝用於管理課程的清單和相關內容。-Web
EduMembershipUI-課程成員資格頁面-新增課程與群組成員資格頁面至 SharePoint 社群網站集合。-Web
EduMySiteCommunity-課程「我的網站」Web 類型-新增課程與群組內容類型至 SharePoint「我的網站」Web。-Web
EduMySiteHost-課程「我的網站主機」內容-新增課程與群組內容至 SharePoint「我的網站主機」網站集合。-Web
EduStudyGroupCommunity-學習群組 Web 內容-新增學習群組內容類型至 SharePoint 社群 Web。-Web
EduUserCache-課程使用者快取-快取 SharePoint 網站集合上的課程與群組使用者資料。-Web
EMailRouting-電子郵件與內容組合管理整合-這會讓網站的內容組合管理能夠接收和組織電子郵件訊息。此功能僅應在記錄中心等受高度管理的儲存區中使用。-Web
EnterpriseWiki-企業 Wiki-建立大型的 Wiki 網站。-Web
EventsList-事件清單-提供網站事件清單的支援。-Web
ExchangeSyncSiteSubscription-網站訂閱層級 Exchange 任務同步處理-可在指定的網站訂閱上啟用 Exchange 任務同步處理。-Web
ExternalList-外部清單-為網站提供外部清單支援。-Web
ExternalSubscription-外部系統事件-這項功能可在外部清單和外部內容類型啟用提醒和事件接收器。-Web
FacilityList-資源清單-此功能支援 [資源] 清單類型。-Web
FCGroupsList-Manage Resources-This feature provides support for Manage Resources list types.-Web
FollowingContent-下列內容-讓使用者追蹤文件或網站。-Web
GanttTasksList-甘特圖工作清單-提供網站甘特圖工作清單的支援。-Web
GBWProvision-群組工作佈建-此功能可佈建群組工作的網頁。-Web
GBWWebParts-GroupBoardWebParts--Web
GettingStarted-快速入門-提供常用 SharePoint 網站動作的並排檢視使用體驗。-Web
GettingStartedWithAppCatalogSite-開始使用您的應用程式目錄網站-在歡迎頁面上，佈建具有「應用程式目錄網站」網頁組件的「快速入門」。-Web
GridList-格線清單-提供在網站格線中編輯自訂清單的支援。-Web
GroupWork-群組工作清單-提供行事曆，內含新增的小組與資源排程功能。-Web
HierarchyTasksList-階層工作清單-支援網站的階層工作清單。-Web
Hold-保留-使用此功能以追蹤訴訟、調查或稽核等需要暫停文件處理的外部動作。-Web
HolidaysList-假日清單-此功能支援 [假日] 清單類型。-Web
IMEDicList-Microsoft IME 字典清單-若要將清單中的資料作為 Microsoft IME 字典使用，請建立 Microsoft IME 字典清單。您可以使用 Microsoft IME 將 [讀取] 欄位項目轉換成 [顯示]，然後在 [IME 備註] 視窗中，檢視 [註解] 中的內容。資料可連結至特定 URL。-Web
IPFSAdminWeb-InfoPath Forms Services 的管理連結。-InfoPath Forms Services 管理連結。-Web
IPFSTenantFormsConfig-InfoPath Forms Services 承租人管理-啟用 InfoPath Forms Services 承租人管理-Web
IPFSTenantWebProxyConfig-InfoPath Forms Services Web 服務 Proxy 管理-啟用 InfoPath Forms Services Web 服務 Proxy 設定的承租人管理-Web
IPFSWebFeatures-InfoPath Forms Services 支援-讓伺服器端轉譯表單的 InfoPath Forms Services 清單及相關頁面。-Web
IssuesList-議題清單-提供網站議題清單的支援。-Web
LegacyDocumentLibrary-文件庫-提供網站文件庫的支援。-Web
LinksList-連結清單-提供網站連結清單的支援。-Web
LocalSiteDirectoryMetaData-Local Site Directory MetaData Capture Feature-Feature that sets location to local site directory for site metadata capture-Web
MaintenanceLogs-維護記錄文件庫-提供網站集合升級與修復記錄的存取-Web
MBrowserRedirect-行動裝置瀏覽器檢視-使用 Smartphone 瀏覽器的行動裝置檢視，提供小組網站上的文件庫及其他清單。-Web
MDSFeature-基本下載策略-在支援這項技術的網頁及網站範本，這項技術透過只下載並呈現網頁變更的部分，讓頁面導覽更加快速流暢。-Web
MembershipList-網站成員資格-此功能包含的清單結構描述與清單執行個體可用於管理社群、專案、小組、教育等網站內的成員。-Web
MetaDataNav-中繼資料導覽和篩選-為網站中的每個清單提供一個設定頁面，設定讓該清單使用中繼資料樹狀檢視階層和篩選控制項，以改善瀏覽和篩選所含的項目。-Web
MobilityRedirect-行動捷徑 URL-提供清單中可存取之行動裝置版本的捷徑 URL (/m)。-Web
MpsWebParts-會議工作區網頁組件-擴充網頁組件新增項目，以顯示「會議工作區」清單範本。-Web
MruDocsWebPart-最近的文件-列出使用者最近存取過的文件。-Web
MySiteHostPictureLibrary-組織商標的共用圖片庫-使用此圖片庫儲存組織的商標。-Web
MySiteMicroBlog-MySite MicroBlogging List-Enables MySite MicroBlogging List.-Web
MySiteNavigation-我的網站導覽-為我的網站安裝導覽提供者。-Web
MySiteQuickLaunch-我的網站版面配置功能-「我的網站」的功能，可將所有版面配置上傳到主版頁面圖庫-Web
MySiteUnifiedNavigation-我的網站統一導覽功能-「我的網站」功能，可在主機網站與個人網站上顯示相同的導覽內容。-Web
MyTasksDashboard-我的任務儀表板-提供使用者體驗，讓使用者管理其任務、跨網站與系統彙總，並與這些動作互動。-Web
NavigationProperties-Portal Navigation Properties-Set per-site navigation properties.-Web
NoCodeWorkflowLibrary-無程式碼工作流程庫-提供網站無程式碼工作流程庫的支援。-Web
ObaProfilePages-BDC 設定檔頁面功能-啟用建立或升級 BDC 設定檔頁面的 UI。-Web
ObaSimpleSolution-離線同步處理外部清單-在外部清單和 Outlook 之間啟用離線同步處理。-Web
OfficeExtensionCatalog-Office 目錄的相關應用程式-佈建目錄以儲存 Office 相關應用程式-Web
OsrvLinks-Shared Services Administration Links-Links to the Shared Services administration pages-Web
OssNavigation-Shared Services Navigation-Shared Services Navigation-Web
OSSSearchSearchCenterUrlFeature-搜尋中心 URL-搜尋中心 URL 功能。-Web
PersonalizationSite-Personalization Site-Personalization Site Description-Web
PhonePNSubscriber-推播通知-這項功能會啟用平台功能，允許行動裝置訂閱此 SharePoint 網站上發生的事件通知。 -Web
PictureLibrary-圖片庫-提供網站圖片庫的支援。-Web
PPSDatasourceLib-PerformancePoint 資料來源庫範本-PerformancePoint 資料來源庫範本-Web
PPSSiteMaster-PerformancePoint Services 網站功能-可啟用 PerformancePoint Services 清單和文件庫範本的功能。-Web
PPSWorkspaceList-PerformancePoint 內容清單-PerformancePoint 內容清單-Web
PremiumSearchVerticals-SharePoint Server 企業版進階搜尋類別-進階搜尋類別使用的佈建檔案。-Web
PremiumWeb-SharePoint Server 企業版網站功能-例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。-Web
ProjectDiscovery-我的網站建議-自動建議文件和網站，以供使用者在其 SharePoint [我的網站] 上追蹤。-Web
ProjectFunctionality-專案功能-此功能會將專案管理功能新增至網站。這其中包括工作、行事曆及網站首頁的網頁組件。-Web
PromotedLinksList-升級的連結-這項功能可讓此網站使用「升級的連結」清單範本。-Web
Publishing-Publishing-Enable Publishing in a web.-Web
PublishingWeb-SharePoint Server 發佈-建立網頁庫及支援庫，以根據版面配置建立並發佈頁面。-Web
RecordsCenter-記錄中心設定-將網站設定為記錄中心。-Web
RecordsManagementTenantAdmin-記錄管理承租人管理-記錄管理承租人管理。-Web
RedirectPageContentTypeBinding-SharePoint Portal Server Redirect Page Content Type Binding Feature-SharePoint Portal Server Redirect Page Content Type Binding Feature-Web
RelatedLinksScopeSettingsLink-Related Links scope settings page-Related Links scope settings page-Web
ReportAndDataSearch-報告與資料搜尋-佈建報告與資料搜尋所用的檔案。-Web
ReportCenterSampleData-Report Center Sample Data-Creates a sample dashboard in the ReportsLibrary of the parent Report Center-Web
ReportListTemplate-SharePoint Portal Server Report Library-SharePoint Portal Server Report Library-Web
RollupPages-彙總頁面-建立字詞導向彙總頁面階層。-Web
ScheduleList-Schedule and Reservations List-This feature provides support for Schedule and Reservations list types.-Web
SearchAdminWebParts-Microsoft 搜尋管理網頁組件-此功能可上傳搜尋管理儀表板需要的所有網頁組件。-Web
SearchCenterFiles-Search Server Center 檔案-此功能可上傳 Search Server Center 檔案。-Web
SearchCenterLiteFiles-Search Server Center Lite 檔案-此功能可上傳 Search Server Center Lite 檔案。-Web
SearchCenterLiteUpgrade-Search Server Center 檔案-此功能可上傳 Search Server Center 檔案。-Web
SearchCenterUpgrade-Search Server Center 檔案-此功能可上傳 Search Server Center 檔案。-Web
SearchConfigContentType-搜尋設定資料的內容類型-安裝專門用於管理搜尋設定的內容類型。-Web
SearchConfigFields-搜尋設定資料網站欄-安裝專門用來管理搜尋設定相關資訊的欄。-Web
SearchConfigList-搜尋設定清單執行個體功能-建立搜尋設定清單執行個體: 佈建一份清單，以啟用搜尋設定的匯入與匯出-Web
SearchConfigListTemplate-搜尋設定範本功能-建立搜尋設定範本: 佈建一個範本，以供「搜尋設定清單」啟用搜尋設定的匯入與匯出-Web
SiteAssets-網站資產-在目前網站中建立 SiteAssets 文件庫。-Web
SiteFeed-網站摘要-啟用網站摘要使用。-Web
SiteFeedController-網站摘要功能控制器-控制網站摘要功能的啟動。-Web
SiteNotebook-網站筆記本-在 [共用文件] 庫中建立 Microsoft OneNote 2010 筆記本，然後在 [快速啟動] 上新增其連結。此功能必須搭配妥善設定的 WOPI 應用程式伺服器，才能建立 OneNote 2010 筆記本。-Web
SitesList-Sites List creation feature-Feature that creates sites list and registers event recievers-Web
SlideLibrary-投影片庫-當您想要共用 Microsoft PowerPoint 或相容應用程式的投影片時，請建立投影片庫。投影片庫也提供特殊功能，可以尋找、管理與重新使用投影片。-Web
SPSBlog-部落格通知功能-此功能會將通知新增至部落格-Web
SSSvcAdmin-Secure Store Service Admin-Secure Store Service Admin Ribbon-Web
SurveysList-問卷清單-提供網站問卷清單的支援。-Web
TaskListNewsFeed-TaskListNewsFeed-TaskListNewsFeed-Web
TasksList-工作清單-提供網站工作清單的支援。-Web
TaxonomyTenantAdmin-Taxonomy Tenant Administration-Enables taxonomy tenant administration.-Web
TeamCollab-小組共同作業清單-透過製作可使用的標準清單，如文件庫清單及議題清單，讓網站具有小組共同作業能力。-Web
TenantAdminBDC-承租人 Business Data Connectivity 管理-連至子頁面與 [承租人 Business Data Connectivity 管理] 功能區的連結-Web
TenantAdminDeploymentLinks-Tenant Administration Content Deployment Configuration-Allows Tenant Administrators to configure Content Deployment for their sites.-Web
TenantAdminLinks-承租人管理連結-連至 [承租人管理] 子頁面的連結，這些子頁面位於 [承租人管理] 主頁面上。-Web
TenantAdminSecureStore-$Resources:obacore,tenantadminbdcFeatureTitle;-$Resources:obacore,tenantadminbdcFeatureDesc;-Web
TenantProfileAdmin-承租人使用者設定檔應用程式-連結至承租人使用者設定檔應用程式管理的子頁面-Web
TenantSearchAdmin-承租人搜尋管理-連結至搜尋管理的子頁面-Web
TimeCardList-工時記錄卡清單-此功能支援 [工時記錄卡] 清單類型。-Web
TopicPages-主題頁面-建立字詞導向主題頁面。-Web
TransMgmtLib-翻譯管理庫-當您要以多種語言建立文件並管理翻譯工作時，請建立翻譯管理庫。翻譯管理庫包含管理翻譯程序的工作流程，並提供子資料夾、檔案版本處理及存回/取出等功能。-Web
UpgradeOnlyFile-$Resources:UpgradeOnlyFile_Feature_Title;-只上傳升級檔案的入口網站功能。-Web
VisioProcessRepository-Visio 程序存放庫-Visio 程序存放庫文件庫功能-Web
VisioProcessRepositoryContentTypes-Visio 程序存放庫 2013 內容類型-Visio 程序存放庫 2013 內容類型-Web
VisioProcessRepositoryContentTypesUs-Visio 程序存放庫 2013 內容類型-Visio 程序存放庫 2013 內容類型-Web
VisioProcessRepositoryUs-Visio 程序存放庫-Visio 程序存放庫文件庫功能-Web
WebPageLibrary-Wiki 頁面庫-一套可輕易編輯的互連式網頁，其中可包含文字、圖像，及網頁組件。-Web
WhatsNewList-What's New List-This feature provides support for What's New list types.-Web
WhereaboutsList-$Resources:core,GbwFeatureWhereaboutsTitle;-$Resources:core,GbwFeatureWhereaboutsDescription;-Web
WikiPageHomePage-Wiki 頁面首頁-此網站功能將會建立一個 Wiki 頁面，並將其設為您的網站首頁。-Web
WikiWelcome-WikiWelcome-這個功能可讓您將 Wiki 網站的首頁變成 Wiki 頁面。-Web
WorkflowAppOnlyPolicyManager-工作流程可以使用應用程式權限-允許工作流程從此網站的所有項目讀取，以及寫入此網站的所有項目。-Web
WorkflowHistoryList-工作流程歷程記錄清單-提供網站工作流程歷程記錄清單的支援。-Web
workflowProcessList-WorkflowProcessList Feature-This feature provides the ability to create a list to support running custom form actions.-Web
WorkflowServiceStore-workflow service store-workflow service store-Web
WorkflowTask-工作流程工作內容類型-將 SharePoint 2013 工作流程工作內容類型新增至網站中。-Web
XmlFormLibrary-XML 表單庫-提供網站 XML 表單庫的支援。-Web

++++++++++++++++++++++++++OCT.16.2015 +++++++++++++++++++++++++++++++++

AbuseReportsList*提報*Web*c6a92dbf-6441-4b8b-882f-8d97cb12c83a*此功能包含的清單結構描述與清單執行個體可用於管理社群網站內的攻擊性內容
AccessRequests*存取要求清單*Web*a0f12ee4-9b60-4ba4-81f6-75724f4ca973*允許管理 Sharepoint 網站的存取要求
AccSrvApplication*Access Services 2010 伺服陣列功能*Farm*1cc4b32c-299b-41aa-9770-67715ea05f25*新增伺服陣列層級的 Access Services 2010 功能至 Microsoft SharePoint Foundation 架構
AccSrvApplication*Access Services 2010 伺服陣列功能*Farm*1cc4b32c-299b-41aa-9770-67715ea05f25*新增伺服陣列層級的 Access Services 2010 功能至 Microsoft SharePoint Foundation 架構
AccSrvMSysAso*Access Services System Objects*Web*29ea7495-fca1-4dc6-8ac1-500c247a036e*Access Services System Objects
AccSrvMSysAso*Access Services System Objects*Web*29ea7495-fca1-4dc6-8ac1-500c247a036e*Access Services System Objects
AccSrvRestrictedList*Access Services Restricted List Definition*Web*a4d4ee2c-a6cb-4191-ab0a-21bb5bde92fb*Access Services Restricted List Definition
AccSrvRestrictedList*Access Services Restricted List Definition*Web*a4d4ee2c-a6cb-4191-ab0a-21bb5bde92fb*Access Services Restricted List Definition
AccSrvShell*Access Services 命令介面*Web*bcf89eb7-bca1-4468-bdb4-ca27f61a2292*新增 Access Services 網站動作功能表項目。
AccSrvShell*Access Services 命令介面*Web*bcf89eb7-bca1-4468-bdb4-ca27f61a2292*新增 Access Services 網站動作功能表項目。
AccSrvSolutionGallery*Access Services 解決方案庫*Site*744b5fd3-3b09-4da6-9bd1-de18315b045d*方便上傳 Access 範本檔案至解決方案庫。
AccSrvSolutionGallery*Access Services 解決方案庫*Site*744b5fd3-3b09-4da6-9bd1-de18315b045d*方便上傳 Access 範本檔案至解決方案庫。
AccSrvSolutionGalleryStapler*Access Services 解決方案庫功能裝訂器*Farm*d5ff2d2c-8571-4c3c-87bc-779111979811*啟用已建立的每個網站集合的 Access Services 解決方案庫功能。
AccSrvSolutionGalleryStapler*Access Services 解決方案庫功能裝訂器*Farm*d5ff2d2c-8571-4c3c-87bc-779111979811*啟用已建立的每個網站集合的 Access Services 解決方案庫功能。
AccSrvUserTemplate*Access Services 使用者範本*Web*1a8251a0-47ab-453d-95d4-07d7ca4f8166*方便從已上傳的 Access 範本檔案建立新網站。
AccSrvUserTemplate*Access Services 使用者範本*Web*1a8251a0-47ab-453d-95d4-07d7ca4f8166*方便從已上傳的 Access 範本檔案建立新網站。
AccSrvUSysAppLog*Access Services User Application Log*Web*28101b19-b896-44f4-9264-db028f307a62*Access Services User Application Log
AccSrvUSysAppLog*Access Services User Application Log*Web*28101b19-b896-44f4-9264-db028f307a62*Access Services User Application Log
AccSvcAddAccessApp*Access 應用程式*Web*d2b9ec23-526b-42c5-87b6-852bd83e0364*Access Web App
AccSvcAddAccessAppStapling*Access Service 新增 Access 應用程式功能裝訂器*Farm*3d7415e4-61ba-4669-8d78-213d374d9825*啟用已建立之各網站的 Access Services 新增 Access 應用程式功能。
AccSvcApplication*Access Services 伺服器陣列功能*Farm*5094e988-524b-446c-b2f6-040b5be46297*新增伺服器陣列層級的 Access Services 功能至 Microsoft SharePoint Foundation 架構
AccSvcShell*Access Services 命令介面*Web*7ffd6d57-4b10-4edb-ac26-c2cfbf8173ab*新增 Access Services 網站動作功能表項目。
AddDashboard*Add Dashboard*Web*d250636f-0a26-4019-8425-a5232d592c09*Installs the "Add Dashboard" Link in Site Actions menu.
AddDashboard*Add Dashboard*Web*d250636f-0a26-4019-8425-a5232d592c09*Installs the "Add Dashboard" Link in Site Actions menu.
AdminLinks*管理中心連結*Web*fead7313-ae6d-45dd-8260-13b563cb4c71*管理中心中操作與應用程式管理頁面的連結。
AdminLinks*管理中心連結*Web*fead7313-ae6d-45dd-8260-13b563cb4c71*管理中心中操作與應用程式管理頁面的連結。
AdminReportCore*Administrative Reporting Infrastructure*Site*b8f36433-367d-49f3-ae11-f7d76b51d251*Library for administrative reporting.
AdminReportCore*Administrative Reporting Infrastructure*Site*b8f36433-367d-49f3-ae11-f7d76b51d251*Library for administrative reporting.
AdminReportCorePushdown*Administrative Reporting Core Pushdown Feature*Farm*55312854-855b-4088-b09d-c5efe0fbf9d2*This feature activates the Administrative Reporting Infrastructure feature in all site templates.
AdminReportCorePushdown*Administrative Reporting Core Pushdown Feature*Farm*55312854-855b-4088-b09d-c5efe0fbf9d2*This feature activates the Administrative Reporting Infrastructure feature in all site templates.
AnnouncementsList*宣告清單*Web*00bfea71-d1ce-42de-9c63-a44004ce0104*提供網站宣告清單的支援。
AnnouncementsList*宣告清單*Web*00bfea71-d1ce-42de-9c63-a44004ce0104*提供網站宣告清單的支援。
AppLockdown**Web*23330bdb-b83e-4e09-8770-8155aa5e87fd*
AppRegistration*允許註冊 SharePoint 應用程式*Site*fdc6383e-3f1d-4599-8b7c-c515e99cbf18*$Resources:Core,AppRegistrationTitleFeatureDescription;
AppRequestsList*應用程式要求清單*Web*334dfc83-8655-48a1-b79d-68b7f6c63222*佈建位置以儲存 SharePoint 應用程式要求。
AssetLibrary*Asset Library*Site*4bcccd62-dcaf-46dc-a7d4-e38277ef33f4*Enable Asset Library Creation for site collection.
AssetLibrary*Asset Library*Site*4bcccd62-dcaf-46dc-a7d4-e38277ef33f4*Enable Asset Library Creation for site collection.
AutohostedAppLicensing*自動裝載的應用程式授權功能*Site*fa7cefd8-5595-4d68-84fa-fe2d9e693de7*將自動裝載的應用程式授權 UI 元素新增至「內部應用程式目錄」。
AutohostedAppLicensingStapling*自動裝載的應用程式授權功能裝訂*Farm*013a0db9-1607-4c42-8f71-08d821d395c2*啟用應用程式目錄網站的自動裝載應用程式授權 UI。
BaseSite*SharePoint Server 標準版網站集合功能*Site*b21b090c-c796-4b0f-ac0f-7ef1659c20ae*SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。
BaseSite*SharePoint Server 標準版網站集合功能*Site*b21b090c-c796-4b0f-ac0f-7ef1659c20ae*SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。
BaseSiteStapling*Base Site Features Stapling*Farm*97a2485f-ef4b-401f-9167-fa4fe177c6f6*Staple Base features
BaseSiteStapling*Base Site Features Stapling*Farm*97a2485f-ef4b-401f-9167-fa4fe177c6f6*Staple Base features
BaseWeb*SharePoint Server 標準版網站功能*Web*99fe402e-89a0-45aa-9163-85342e865dc8*SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。
BaseWeb*SharePoint Server 標準版網站功能*Web*99fe402e-89a0-45aa-9163-85342e865dc8*SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。
BaseWebApplication*SharePoint Server 標準版 Web 應用程式功能*WebApplication*4f56f9fa-51a0-420c-b707-63ecbb494db1*SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。
BaseWebApplication*SharePoint Server 標準版 Web 應用程式功能*WebApplication*4f56f9fa-51a0-420c-b707-63ecbb494db1*SharePoint Server 標準版授權所包含的功能，例如使用者設定檔及搜尋。
BasicWebParts*基本網頁組件*Site*00bfea71-1c5e-4a24-b310-ba51c3eb7a57*網站集合網頁組件目錄中可以使用下列網頁組件: 網頁檢視器、內容編輯器、圖像、表單、XML 及網站使用者清單。
BasicWebParts*基本網頁組件*Site*00bfea71-1c5e-4a24-b310-ba51c3eb7a57*網站集合網頁組件目錄中可以使用下列網頁組件: 網頁檢視器、內容編輯器、圖像、表單、XML 及網站使用者清單。
BcsEvents*外部系統事件啟動項*Web*60c8481d-4b54-4853-ab9f-ed7e1c21d7e4*這項功能可藉由啟動相關功能，在「外部清單」和「外部內容類型」中啟用「提醒」和「事件接收器」。
BDR*文件中心增強功能*Web*3f59333f-4ce1-406d-8a97-9ecb0ff0337f*提供瀏覽網站的樹狀檢視。
BDR*文件中心增強功能*Web*3f59333f-4ce1-406d-8a97-9ecb0ff0337f*提供瀏覽網站的樹狀檢視。
BICenterDashboardsLib*儀表板庫*Web*f979e4dc-1852-4f26-ab92-d1b2a190afc9*儀表板庫描述
BICenterDashboardsLib*儀表板庫*Web*f979e4dc-1852-4f26-ab92-d1b2a190afc9*儀表板庫描述
BICenterDataConnections*BICenter 資料連線功能*Web*3d8210e9-1e89-4f12-98ef-643995339ed4*BICenter 資料連線功能
BICenterDataconnectionsLib*PerformancePoint 資料連線庫*Web*26676156-91a0-49f7-87aa-37b1d5f0c4d0*包含 ODC、UDC 和 PerformancePoint 資料連線。
BICenterDataconnectionsLib*PerformancePoint 資料連線庫*Web*26676156-91a0-49f7-87aa-37b1d5f0c4d0*包含 ODC、UDC 和 PerformancePoint 資料連線。
BICenterDataConnectionsListInstance*BICenter 資料連線清單執行個體功能*Web*a64c4402-7037-4476-a290-84cfd56ca01d*BICenter 資料連線清單執行個體功能
BICenterFeatureStapler*BICenter 功能裝訂器功能*WebApplication*3a027b18-36e4-4005-9473-dd73e6756a73*BICenter 功能裝訂器功能
BICenterPPSContentPages*BICenter PPS 內容頁面功能*Web*a354e6b3-6015-4744-bdc2-2fc1e4769e65*BICenter PPS 內容頁面功能
BICenterPPSNavigationLink*BICenter PPS 內容導覽列功能*Web*faf31b50-880a-4e4f-a21b-597f6b4d6478*BICenter PPS 內容導覽列功能
BICenterPPSWorkspaceListInstance*BICenter PPS 工作區清單執行個體功能*Web*f9c216ad-35c7-4538-abb8-8ec631a5dff7*BICenter PPS 工作區清單執行個體功能
BICenterSampleData*商務智慧中心範例資料*Web*3992d4ab-fa9e-4791-9158-5ee32178e88a*商務智慧中心範例資料的功能，可將範例資料加入新建立的商務智慧中心網站。
BICenterSampleData*商務智慧中心範例資料*Web*3992d4ab-fa9e-4791-9158-5ee32178e88a*商務智慧中心範例資料的功能，可將範例資料加入新建立的商務智慧中心網站。
BizAppsCTypes*SharePoint Portal Server Business Appications Content Type Definition*Site*43f41342-1a37-4372-8ca0-b44d881e4434*SharePoint Portal Server Business Appication content type definitions
BizAppsCTypes*SharePoint Portal Server Business Appications Content Type Definition*Site*43f41342-1a37-4372-8ca0-b44d881e4434*SharePoint Portal Server Business Appication content type definitions
BizAppsFields*SPS Biz Apps Field Definition*Site*5a979115-6b71-45a5-9881-cdc872051a69*OOB field definitions for Biz Apps
BizAppsFields*SPS Biz Apps Field Definition*Site*5a979115-6b71-45a5-9881-cdc872051a69*OOB field definitions for Biz Apps
BizAppsListTemplates*SharePoint Portal Server Status Indicator List template*Web*065c78be-5231-477e-a972-14177cc5b3c7*SharePoint Portal Server Status Indicator List template
BizAppsListTemplates*SharePoint Portal Server Status Indicator List template*Web*065c78be-5231-477e-a972-14177cc5b3c7*SharePoint Portal Server Status Indicator List template
BizAppsSiteTemplates*BizApps Site Templates*Site*4248e21f-a816-4c88-8cab-79d82201da7b*SharePoint Portal site templates and web parts
BizAppsSiteTemplates*BizApps Site Templates*Site*4248e21f-a816-4c88-8cab-79d82201da7b*SharePoint Portal site templates and web parts
BlogContent*$Resources:core,blogContentFeatureTitle;*Web*0d1c50f7-0309-431c-adfb-b777d5473a65*$Resources:core,blogContentFeatureDesc;
BlogHomePage*Blog Home Page*Web*e4639bb7-6e95-4e2f-b562-03b832dd4793*Creates the default.aspx page for the a Blog site
BlogSiteTemplate*部落格網站功能*Web*faf00902-6bab-4583-bd02-84db191801d8*$Resources:core,blogFeatureDesc;
BulkWorkflow*Bulk workflow process button*Farm*aeef8777-70c0-429f-8a13-f12db47a6d47*Adds the process all tasks button to complete workflows in bulk
BulkWorkflow*Bulk workflow process button*Farm*aeef8777-70c0-429f-8a13-f12db47a6d47*Adds the process all tasks button to complete workflows in bulk
BulkWorkflowTimerJob*Bulk Workflow Timer Job*WebApplication*d992aeca-3802-483a-ab40-6c9376300b61*The timer job that processes workflow tasks in bulk
BulkWorkflowTimerJob*Bulk Workflow Timer Job*WebApplication*d992aeca-3802-483a-ab40-6c9376300b61*The timer job that processes workflow tasks in bulk
CallTrackList*Phone Call Memo List*Web*239650e3-ee0b-44a0-a22a-48292402b8d8*此功能支援 [電話備忘錄] 清單類型。
CallTrackList*Phone Call Memo List*Web*239650e3-ee0b-44a0-a22a-48292402b8d8*此功能支援 [電話備忘錄] 清單類型。
CategoriesList*類別清單功能*Web*d32700c7-9ec5-45e6-9c89-ea703efca1df*這項功能包含類別清單功能的範本
CirculationList*Circulation List*Web*a568770a-50ba-4052-ab48-37d8029b3f47*此功能支援 [資訊流通] 清單類型。
CirculationList*Circulation List*Web*a568770a-50ba-4052-ab48-37d8029b3f47*此功能支援 [資訊流通] 清單類型。
CmisProducer*內容管理互通性服務 (CMIS) 製作者*Web*1fce0577-1f58-4fc2-a996-6c4bcf59eeed*使用內容管理互通性服務 (CMIS) 標準，將此 SharePoint 網站中儲存的資料設為可用。  
CollaborationMailbox*網站信箱*Web*502a2d54-6102-4757-aaa0-a90586106368*網站信箱應用程式能透過將您的網站連線到 Exchange 信箱，協助您將電子郵件和文件集中處理。如此一來，您就可以在 SharePoint 上檢視電子郵件，並在 Outlook 中檢視網站文件。
CollaborationMailboxFarm*網站信箱*Farm*3a11d8ef-641e-4c79-b4d9-be3b17f9607c*為此伺服器陣列上的網站啟用  Exchange 信箱佈建，並從網站將文件連接到 Outlook。
CommunityPortal*社群入口網站功能*Site*2b03956c-9271-4d1c-868a-07df2971ed30*此功能加入了社區入口網站功能。它也會佈建社群入口網站頁面。
CommunitySite*社群網站功能*Web*961d6a9c-4388-4cf2-9733-38ee8c89afd4*此功能可新增討論區類別、內容與人員評價，以及成員清單等社群功能。另外也可佈建包含這些清單與功能的社群網站頁面。
ContactsList*連絡人清單*Web*00bfea71-7e6d-4186-9ba8-c047ac750105*提供網站連絡人清單的支援。
ContactsList*連絡人清單*Web*00bfea71-7e6d-4186-9ba8-c047ac750105*提供網站連絡人清單的支援。
ContentDeploymentSource*內容部署來源功能*Site*cd1a49b0-c067-4fdd-adfe-69e6f5022c1a*內容部署來源功能可讓您在來源網站集合上執行內容部署的特定檢查，並可讓您設定從網站集合到目標網站集合的內容部署。 
ContentFollowing*追蹤內容*Site*7890e045-6c96-48d8-96e7-6a1d63737d71*可讓使用者追蹤文件或網站。
ContentFollowingList*追蹤內容清單*Site*a34e5458-8d20-4c0d-b137-e1390f5824a1*此功能會封裝可讓使用者在 SharePoint 追蹤內容的清單。
ContentFollowingStapling*內容追蹤裝訂*Farm*e1580c3c-c510-453b-be15-35feb0ddb1a5*啟動所有網站集合上的內容追蹤功能。
ContentLightup*標準使用者介面項目*Farm*0f121a23-c6bc-400f-87e4-e6bbddf6916d*提供數個標準使用者介面元件與連結。
ContentLightup*標準使用者介面項目*Farm*0f121a23-c6bc-400f-87e4-e6bbddf6916d*提供數個標準使用者介面元件與連結。
ContentTypeHub*內容類型整合中樞*Site*9a447926-5937-44cb-857a-d3829301c73b*佈建網站以作為企業中繼資料中樞網站。
ContentTypeHub*內容類型整合中樞*Site*9a447926-5937-44cb-857a-d3829301c73b*佈建網站以作為企業中繼資料中樞網站。
ContentTypePublish*Content type publishing*Web*dd903064-c9d8-4718-b4e7-8ab9bd039fff*Content type publishing.
ContentTypePublish*Content type publishing*Web*dd903064-c9d8-4718-b4e7-8ab9bd039fff*Content type publishing.
ContentTypeSettings*標準內容類型設定連結*Farm*fead7313-4b9e-4632-80a2-ff00a2d83297*提供「內容類型設定」頁面的標準連結。
ContentTypeSettings*標準內容類型設定連結*Farm*fead7313-4b9e-4632-80a2-ff00a2d83297*提供「內容類型設定」頁面的標準連結。
ContentTypeSyndication*Content type syndication*WebApplication*34339dc9-dec4-4256-b44a-b30ff2991a64*Content type syndication.
ContentTypeSyndication*Content type syndication*WebApplication*34339dc9-dec4-4256-b44a-b30ff2991a64*Content type syndication.
CorporateCatalog*應用程式目錄*Web*0ac11793-9c2f-4cac-8f22-33f93fac18f2*佈建目錄以將應用程式散佈到您的組織
CorporateCuratedGallerySettings*應用程式目錄設定*WebApplication*f8bea737-255e-4758-ab82-e34bb46f5828*儲存應用程式目錄網站的設定
CrossFarmSitePermissions*跨伺服器陣列的網站權限*Site*a5aedf1a-12e5-46b4-8348-544386d5312d*使用跨伺服器陣列的網站權限功能以允許內部 SharePoint 應用程式存取整個伺服器陣列中的網站。
CrossSiteCollectionPublishing*跨網站集合發佈*Site*151d22d9-95a8-4904-a0a3-22e4db85d1e0*啟用網站集合以將清單和文件庫指定為跨網站集合發佈的目錄來源。
CTypes*標準內容類型定義*Site*695b6570-a48b-4a8e-8ea5-26ea7fc1d162*提供網站集合的標準內容類型定義。
CTypes*標準內容類型定義*Site*695b6570-a48b-4a8e-8ea5-26ea7fc1d162*提供網站集合的標準內容類型定義。
CustomList*自訂清單*Web*00bfea71-de22-43b2-a848-c05709900100*提供網站自訂清單的支援。
CustomList*自訂清單*Web*00bfea71-de22-43b2-a848-c05709900100*提供網站自訂清單的支援。
DataConnectionLibrary*Data Connections Feature*Web*00bfea71-dbd7-4f72-b8cb-da7ac0440130*
DataConnectionLibrary*Data Connections Feature*Web*00bfea71-dbd7-4f72-b8cb-da7ac0440130*
DataConnectionLibraryStapling*資料連線庫*Farm*cdfa39c6-6413-4508-bccf-bf30368472b3*新增資料連線庫功能
DataConnectionLibraryStapling*資料連線庫*Farm*cdfa39c6-6413-4508-bccf-bf30368472b3*新增資料連線庫功能
DataSourceLibrary*資料來源程式庫*Web*00bfea71-f381-423d-b9d1-da7a54c50110*提供網站資料來源程式庫的支援。
DataSourceLibrary*資料來源程式庫*Web*00bfea71-f381-423d-b9d1-da7a54c50110*提供網站資料來源程式庫的支援。
DeploymentLinks*Content Deployment*Web*ca2543e6-29a1-40c1-bba9-bd8510a4c17b*OOB Content Deployment Feature.
DeploymentLinks*Content Deployment*Web*ca2543e6-29a1-40c1-bba9-bd8510a4c17b*OOB Content Deployment Feature.
Developer*開發人員功能*Site*e374875e-06b6-11e0-b0fa-57f5dfd72085*協助開發人員建置、測試及發佈應用程式的功能
DiscussionsList*討論區清單*Web*00bfea71-6a49-43fa-b535-d15c05500108*提供網站討論區的支援。
DiscussionsList*討論區清單*Web*00bfea71-6a49-43fa-b535-d15c05500108*提供網站討論區的支援。
DMContentTypeSettings*DM Content Type Setting Links*Farm*1ec2c859-e9cb-4d79-9b2b-ea8df09ede22*DLC Document Management content type setting links.
DMContentTypeSettings*DM Content Type Setting Links*Farm*1ec2c859-e9cb-4d79-9b2b-ea8df09ede22*DLC Document Management content type setting links.
DocId*文件識別碼服務*Site*b50e3104-6812-424f-a011-cc90e6327318*為網站集合中的文件指派識別碼，這可以用來擷取與目前位置無關的項目。
DocId*文件識別碼服務*Site*b50e3104-6812-424f-a011-cc90e6327318*為網站集合中的文件指派識別碼，這可以用來擷取與目前位置無關的項目。
docmarketplace*學術文件庫網站*Web*184c82e7-7eb1-4384-8e8c-62720ef397a0*學術文件庫網站。
docmarketplacesafecontrols*學術文件庫網站安全控制項。*WebApplication*5690f1a0-22b6-4262-b1c2-74f505bc0670*佈建用於學術文件庫網站中的安全控制項。
docmarketplacesampledata*學術文件庫網站範例資料*Web*1dfd85c5-feff-489f-a71f-9322f8b13902*佈建學術文件庫網站的範例資料。
DocumentLibrary*文件庫*Web*00bfea71-e717-4e80-aa17-d0c71b360101*提供網站文件庫的支援。
DocumentLibrary*文件庫*Web*00bfea71-e717-4e80-aa17-d0c71b360101*提供網站文件庫的支援。
DocumentManagement*「文件組」中繼資料同步處理*WebApplication*3a4ce811-6fe0-4e97-a6ae-675470282cf2*提供為「文件組」同步處理中繼資料的基礎結構。
DocumentManagement*「文件組」中繼資料同步處理*WebApplication*3a4ce811-6fe0-4e97-a6ae-675470282cf2*提供為「文件組」同步處理中繼資料的基礎結構。
DocumentRouting*內容組合管理*Web*7ad5272a-2694-4349-953e-ea5ef290e97c*建立可將送出到此網站的內容移到正確文件庫或資料夾的中繼資料式規則。
DocumentRouting*內容組合管理*Web*7ad5272a-2694-4349-953e-ea5ef290e97c*建立可將送出到此網站的內容移到正確文件庫或資料夾的中繼資料式規則。
DocumentRoutingResources*文件傳閱資源*Site*0c8a9a47-22a9-4798-82f1-00e62a96006e*在此網站集合內的網站中，佈建傳閱文件所需的資源。
DocumentRoutingResources*文件傳閱資源*Site*0c8a9a47-22a9-4798-82f1-00e62a96006e*在此網站集合內的網站中，佈建傳閱文件所需的資源。
DocumentSet*文件組*Site*3bae86a2-776d-499d-9db8-fa4cdc7884f8*提供建立和使用文件組所需的內容類型。當您要將多份文件作為單一工作產品管理時，請建立文件組。
DocumentSet*文件組*Site*3bae86a2-776d-499d-9db8-fa4cdc7884f8*提供建立和使用文件組所需的內容類型。當您要將多份文件作為單一工作產品管理時，請建立文件組。
DownloadFromOfficeDotCom*從 SharePoint 的 Office.com 的進入點*Farm*a140a1ac-e757-465d-94d4-2ca25ab2c662*此功能提供從 SharePoint 使用者介面的進入點，允許使用者從 Office.com 瀏覽 SharePoint 方案
DownloadFromOfficeDotCom*從 SharePoint 的 Office.com 的進入點*Farm*a140a1ac-e757-465d-94d4-2ca25ab2c662*此功能提供從 SharePoint 使用者介面的進入點，允許使用者從 Office.com 瀏覽 SharePoint 方案
EawfSite*中文簽核流程*Site*142ae5f3-6796-45c5-b31d-2e62e8868b53*此網站集合功能提供中文簽核流程。您之後必須啟動「中文簽核流程」網站功能，才能使用此功能。
EawfSite*中文簽核流程*Site*142ae5f3-6796-45c5-b31d-2e62e8868b53*此網站集合功能提供中文簽核流程。您之後必須啟動「中文簽核流程」網站功能，才能使用此功能。
EawfWeb*中文簽核流程*Web*1ba1b299-716c-4ee1-9c23-e8bbab3c812a*此網站功能提供中文簽核流程。此功能只能從網站集合的根網站啟動。必須先啟動「中文簽核流程」網站集合功能。
EawfWeb*中文簽核流程*Web*1ba1b299-716c-4ee1-9c23-e8bbab3c812a*此網站功能提供中文簽核流程。此功能只能從網站集合的根網站啟動。必須先啟動「中文簽核流程」網站集合功能。
EDiscoveryCaseResources*eDiscovery 案例功能*Web*e8c02a2a-9010-4f98-af88-6668d59f91a7*佈建 eDiscovery 案例所需的資源。
EDiscoveryConsole*eDiscovery 入口網站*Site*250042b9-1aad-4b56-a8a6-69d9fe1c8c2c*建立及管理 eDiscovery 案例。
EduAdminLinks*課程管理中心連結*Web*03509cfb-8b2f-4f46-a4c9-8316d1e62a4b*新增連結至 SharePoint 管理中心，以管理課程和機構資料。
EduAdminPages*課程管理頁面*Site*c1b78fe6-9110-42e8-87cb-5bd1c8ab278a*新增頁面至 SharePoint Online，以管理課程和機構資料。
EduCommunity*課程社群 Web 類型*Web*bf76fc2c-e6c9-11df-b52f-cb00e0d72085*新增課程與群組內容類型至 SharePoint 社群 Web。
EduCommunityCustomSiteActions*課程社群網站動作*Site*739ec067-2b57-463e-a986-354be77bb828*新增課程與群組網站動作至 SharePoint 社群網站集合。
EduCommunitySite*社群清單*Site*2e030413-c4ff-41a4-8ee0-f6688950b34a*新增課程與群組清單至 SharePoint 社群網站集合。
EduCourseCommunity*課程 Web 類型*Web*a16e895c-e61a-11df-8f6e-103edfd72085*新增必要的內容類型至 SharePoint 課程 Web。
EduCourseCommunitySite*課程清單*Site*824a259f-2cce-4006-96cd-20c806ee9cfd*新增必要清單至 SharePoint 課程網站集合。
EduDashboard*課程與「我的網站」內容*Web*5025492c-dae2-4c00-8f34-cd08f7c7c294*新增課程與群組內容至 SharePoint 課程與「我的網站」集合。
EduFarmWebApplication*課程 Web 應用程式設定*Farm*cb869762-c694-439e-8d05-cf5ca066f271*在 SharePoint Web 應用程式中安裝課程與群組設定。
EduInstitutionAdmin*大量要求與回應清單*Site*41bfb21c-0447-4c97-bc62-0b07bec262a1*在管理網站上安裝大量要求與回應清單，以管理課程和使用者。
EduInstitutionSiteCollection*課程管理清單*Web*978513c0-1e6c-4efb-b12e-7698963bfd05*在 SharePoint 全域網站集合上安裝用於管理課程的清單和相關內容。
EduMembershipUI*課程成員資格頁面*Web*bd012a1f-c69b-4a13-b6a4-f8bc3e59760e*新增課程與群組成員資格頁面至 SharePoint 社群網站集合。
EduMySiteCommunity*課程「我的網站」Web 類型*Web*abf1a85c-e91a-11df-bf2e-f7acdfd72085*新增課程與群組內容類型至 SharePoint「我的網站」Web。
EduMySiteHost*課程「我的網站主機」內容*Web*932f5bb1-e815-4c14-8917-c2bae32f70fe*新增課程與群組內容至 SharePoint「我的網站主機」網站集合。
EduSearchDisplayTemplates*課程搜尋顯示範本*Site*8d75610e-5ff9-4cd1-aefc-8b926f2af771*安裝用來顯示搜尋結果的課程與群組顯示範本。
EduShared*課程共用內容*Site*08585e12-4762-4cc9-842a-a8d7b074bdb7*新增 SharePoint 網站集合共用的課程與群組內容。
EduStudyGroupCommunity*學習群組 Web 內容*Web*a46935c3-545f-4c15-a2fd-3a19b62d8a02*新增學習群組內容類型至 SharePoint 社群 Web。
EduUserCache*課程使用者快取*Web*7f52c29e-736d-11e0-80b8-9edd4724019b*快取 SharePoint 網站集合上的課程與群組使用者資料。
EduWebApplication*課程 Web 應用程式*WebApplication*7de489aa-2e4a-46ff-88f0-d1b5a9d43709*在 SharePoint Web 應用程式上啟用課程與群組。
EMailRouting*電子郵件與內容組合管理整合*Web*d44a1358-e800-47e8-8180-adf2d0f77543*這會讓網站的內容組合管理能夠接收和組織電子郵件訊息。此功能僅應在記錄中心等受高度管理的儲存區中使用。
EMailRouting*電子郵件與內容組合管理整合*Web*d44a1358-e800-47e8-8180-adf2d0f77543*這會讓網站的內容組合管理能夠接收和組織電子郵件訊息。此功能僅應在記錄中心等受高度管理的儲存區中使用。
EmailTemplates*電子郵件範本功能*WebApplication*397942ec-14bf-490e-a983-95b87d0d29d1*傳送一些 SharePoint 通知所用的電子郵件範本
EmailTemplates*電子郵件範本功能*WebApplication*397942ec-14bf-490e-a983-95b87d0d29d1*傳送一些 SharePoint 通知所用的電子郵件範本
EnableAppSideLoading*啟用 Office 及 SharePoint 相關應用程式側載*Site*ae3a1339-61f5-4f8f-81a7-abd2da956a7d*這項功能可讓開發人員將正在開發中的應用程式部署至網站。
EnhancedHtmlEditing*增強型 HTML 編輯*Farm*81ebc0d6-8fb2-4e3f-b2f8-062640037398*內容編輯器網頁組件的增強型 HTML 編輯
EnhancedHtmlEditing*增強型 HTML 編輯*Farm*81ebc0d6-8fb2-4e3f-b2f8-062640037398*內容編輯器網頁組件的增強型 HTML 編輯
EnhancedTheming*Enhanced Theming*Site*068bc832-4951-11dc-8314-0800200c9a66*Enable enhanced .thmx theming.
EnhancedTheming*Enhanced Theming*Site*068bc832-4951-11dc-8314-0800200c9a66*Enable enhanced .thmx theming.
EnterpriseWiki*企業 Wiki*Web*76d688ad-c16e-4cec-9b71-7b7f0d79b9cd*建立大型的 Wiki 網站。
EnterpriseWiki*企業 Wiki*Web*76d688ad-c16e-4cec-9b71-7b7f0d79b9cd*建立大型的 Wiki 網站。
EnterpriseWikiLayouts*企業 Wiki 版面配置*Site*a942a218-fa43-4d11-9d85-c01e3e3a37cb*建立包含類別和版面配置的大型 Wiki。
EnterpriseWikiLayouts*企業 Wiki 版面配置*Site*a942a218-fa43-4d11-9d85-c01e3e3a37cb*建立包含類別和版面配置的大型 Wiki。
EventsList*事件清單*Web*00bfea71-ec85-4903-972d-ebe475780106*提供網站事件清單的支援。
EventsList*事件清單*Web*00bfea71-ec85-4903-972d-ebe475780106*提供網站事件清單的支援。
ExcelServer*Excel Services 應用程式檢視伺服器陣列功能*Farm*e4e6a041-bc5b-45cb-beab-885a27079f74*新增伺服器陣列層級的 Excel Services 應用程式檢視功能至 Microsoft SharePoint Foundation 架構
ExcelServer*Excel Services 應用程式檢視伺服器陣列功能*Farm*e4e6a041-bc5b-45cb-beab-885a27079f74*新增伺服器陣列層級的 Excel Services 應用程式檢視功能至 Microsoft SharePoint Foundation 架構
ExcelServerEdit*已取代的 Office Web Apps*Site*b3da33d0-5e51-4694-99ce-705a3ac80dc5*已取代的 Office Web Apps
ExcelServerEdit*已取代的 Office Web Apps*Site*b3da33d0-5e51-4694-99ce-705a3ac80dc5*已取代的 Office Web Apps
ExcelServerSite*Excel Services 應用程式檢視網站功能*Site*3cb475e7-4e87-45eb-a1f3-db96ad7cf313*新增網站層級的 Excel Services 應用程式檢視功能至 Microsoft SharePoint Foundation 架構
ExcelServerSite*Excel Services 應用程式檢視網站功能*Site*3cb475e7-4e87-45eb-a1f3-db96ad7cf313*新增網站層級的 Excel Services 應用程式檢視功能至 Microsoft SharePoint Foundation 架構
ExcelServerWebPart*Excel Services 應用程式網頁組件網站功能*Site*4c42ab64-55af-4c7c-986a-ac216a6e0c0e*新增網站層級的 Excel Services 應用程式網頁組件功能至 Microsoft SharePoint Foundation 架構
ExcelServerWebPart*Excel Services 應用程式網頁組件網站功能*Site*4c42ab64-55af-4c7c-986a-ac216a6e0c0e*新增網站層級的 Excel Services 應用程式網頁組件功能至 Microsoft SharePoint Foundation 架構
ExcelServerWebPartStapler*Excel Services 應用程式網頁組件伺服器陣列功能*Farm*c6ac73de-1936-47a4-bdff-19a6fc3ba490*新增伺服器陣列層級的 Excel Services 應用程式網頁組件功能至 Microsoft SharePoint Foundation 架構
ExcelServerWebPartStapler*Excel Services 應用程式網頁組件伺服器陣列功能*Farm*c6ac73de-1936-47a4-bdff-19a6fc3ba490*新增伺服器陣列層級的 Excel Services 應用程式網頁組件功能至 Microsoft SharePoint Foundation 架構
ExchangeSync*伺服器陣列層級 Exchange 任務同步處理*Farm*5f68444a-0131-4bb0-b013-454d925681a2*為 Work Management Service Application 啟用 Exchange 同步計時器工作。自訂 SharePoint Server 工作清單的功能區，讓使用者選擇是否要將 Work Management 與 Exchange Server 同步處理。
ExchangeSyncSiteSubscription*網站訂閱層級 Exchange 任務同步處理*Web*7cd95467-1777-4b6b-903e-89e253edc1f7*可在指定的網站訂閱上啟用 Exchange 任務同步處理。
ExpirationWorkflow*處理核准工作流程*Site*c85e5759-f323-4efb-b548-443d2216efb5*由允許的參與者管理文件到期日與保留，並決定是否保留或刪除到期的文件。
ExpirationWorkflow*處理核准工作流程*Site*c85e5759-f323-4efb-b548-443d2216efb5*由允許的參與者管理文件到期日與保留，並決定是否保留或刪除到期的文件。
ExternalList*外部清單*Web*00bfea71-9549-43f8-b978-e47e54a10600*為網站提供外部清單支援。
ExternalList*外部清單*Web*00bfea71-9549-43f8-b978-e47e54a10600*為網站提供外部清單支援。
ExternalSubscription*外部系統事件*Web*5b10d113-2d0d-43bd-a2fd-f8bc879f5abd*這項功能可在外部清單和外部內容類型啟用提醒和事件接收器。
FacilityList*資源清單*Web*58160a6b-4396-4d6e-867c-65381fb5fbc9*此功能支援 [資源] 清單類型。
FacilityList*資源清單*Web*58160a6b-4396-4d6e-867c-65381fb5fbc9*此功能支援 [資源] 清單類型。
FastCentralAdminHelpCollection*FAST Search 管理中心說明集合*Site*38969baa-3590-4635-81a4-2049d982adfa*啟用 FAST Search 管理中心說明集合
FastCentralAdminHelpCollection*FAST Search 管理中心說明集合*Site*38969baa-3590-4635-81a4-2049d982adfa*啟用 FAST Search 管理中心說明集合
FastEndUserHelpCollection*FAST Search 一般使用者說明集合*Site*6e8f2b8d-d765-4e69-84ea-5702574c11d6*啟用 FAST Search 一般使用者說明集合
FastEndUserHelpCollection*FAST Search 一般使用者說明集合*Site*6e8f2b8d-d765-4e69-84ea-5702574c11d6*啟用 FAST Search 一般使用者說明集合
FastFarmFeatureActivation*ESS_SHORT_NAME_RTM 主工作佈建*Farm*d2d98dc8-c7e9-46ec-80a5-b38f039c16be*佈建 ESS_SHORT_NAME_RTM 主工作。
FCGroupsList*Manage Resources*Web*08386d3d-7cc0-486b-a730-3b4cfe1b5509*This feature provides support for Manage Resources list types.
FCGroupsList*Manage Resources*Web*08386d3d-7cc0-486b-a730-3b4cfe1b5509*This feature provides support for Manage Resources list types.
FeaturePushdown*Feature Pushdown Links*Farm*0125140f-7123-4657-b70a-db9aa1f209e5*Link to display the feature pushdown page
FeaturePushdown*Feature Pushdown Links*Farm*0125140f-7123-4657-b70a-db9aa1f209e5*Link to display the feature pushdown page
Fields*標準欄定義*Site*ca7bd552-10b1-4563-85b9-5ed1d39c962a*提供網站集合的標準欄定義。
Fields*標準欄定義*Site*ca7bd552-10b1-4563-85b9-5ed1d39c962a*提供網站集合的標準欄定義。
FollowingContent*下列內容*Web*a7a2793e-67cd-4dc1-9fd0-43f61581207a*讓使用者追蹤文件或網站。
GanttTasksList*甘特圖工作清單*Web*00bfea71-513d-4ca0-96c2-6a47775c0119*提供網站甘特圖工作清單的支援。
GanttTasksList*甘特圖工作清單*Web*00bfea71-513d-4ca0-96c2-6a47775c0119*提供網站甘特圖工作清單的支援。
GBWProvision*群組工作佈建*Web*6e8a2add-ed09-4592-978e-8fa71e6f117c*此功能可佈建群組工作的網頁。
GBWProvision*群組工作佈建*Web*6e8a2add-ed09-4592-978e-8fa71e6f117c*此功能可佈建群組工作的網頁。
GBWWebParts*GroupBoardWebParts*Web*3d25bd73-7cd4-4425-b8fb-8899977f73de*
GBWWebParts*GroupBoardWebParts*Web*3d25bd73-7cd4-4425-b8fb-8899977f73de*
GettingStarted*快速入門*Web*4aec7207-0d02-4f4f-aa07-b370199cd0c7*提供常用 SharePoint 網站動作的並排檢視使用體驗。
GettingStartedWithAppCatalogSite*開始使用您的應用程式目錄網站*Web*4ddc5942-98b0-4d70-9f7f-17acfec010e5*在歡迎頁面上，佈建具有「應用程式目錄網站」網頁組件的「快速入門」。
GlobalWebParts*全域網頁組件*Farm*319d8f70-eb3a-4b44-9c79-2087a87799d6*安裝與所有網站類型通用的其他網頁組件。
GlobalWebParts*全域網頁組件*Farm*319d8f70-eb3a-4b44-9c79-2087a87799d6*安裝與所有網站類型通用的其他網頁組件。
GridList*格線清單*Web*00bfea71-3a1d-41d3-a0ee-651d11570120*提供在網站格線中編輯自訂清單的支援。
GridList*格線清單*Web*00bfea71-3a1d-41d3-a0ee-651d11570120*提供在網站格線中編輯自訂清單的支援。
GroupWork*群組工作清單*Web*9c03e124-eef7-4dc6-b5eb-86ccd207cb87*提供行事曆，內含新增的小組與資源排程功能。
GroupWork*群組工作清單*Web*9c03e124-eef7-4dc6-b5eb-86ccd207cb87*提供行事曆，內含新增的小組與資源排程功能。
HelpLibrary*說明*Site*071de60d-4b02-4076-b001-b456e93146fe*建立可用於儲存產品說明的說明庫。
HelpLibrary*說明*Site*071de60d-4b02-4076-b001-b456e93146fe*建立可用於儲存產品說明的說明庫。
HierarchyTasksList*階層工作清單*Web*f9ce21f8-f437-4f7e-8bc6-946378c850f0*支援網站的階層工作清單。
Hold*保留*Web*9e56487c-795a-4077-9425-54a1ecb84282*使用此功能以追蹤訴訟、調查或稽核等需要暫停文件處理的外部動作。
Hold*保留*Web*9e56487c-795a-4077-9425-54a1ecb84282*使用此功能以追蹤訴訟、調查或稽核等需要暫停文件處理的外部動作。
HolidaysList*假日清單*Web*9ad4c2d4-443b-4a94-8534-49a23f20ba3c*此功能支援 [假日] 清單類型。
HolidaysList*假日清單*Web*9ad4c2d4-443b-4a94-8534-49a23f20ba3c*此功能支援 [假日] 清單類型。
HtmlDesign*Html Design*Site*a4c654e4-a8da-4db3-897c-a386048f7157*Enable Html Design.
IfeDependentApps*需要可存取之網際網路對應端點的應用程式*WebApplication*7877bbf6-30f5-4f58-99d9-a0cc787c1300*允許使用者從 SharePoint 市集取得需要網際網路對應端點的應用程式。
IMEDicList*Microsoft IME 字典清單*Web*1c6a572c-1b58-49ab-b5db-75caf50692e6*若要將清單中的資料作為 Microsoft IME 字典使用，請建立 Microsoft IME 字典清單。您可以使用 Microsoft IME 將 [讀取] 欄位項目轉換成 [顯示]，然後在 [IME 備註] 視窗中，檢視 [註解] 中的內容。資料可連結至特定 URL。
IMEDicList*Microsoft IME 字典清單*Web*1c6a572c-1b58-49ab-b5db-75caf50692e6*若要將清單中的資料作為 Microsoft IME 字典使用，請建立 Microsoft IME 字典清單。您可以使用 Microsoft IME 將 [讀取] 欄位項目轉換成 [顯示]，然後在 [IME 備註] 視窗中，檢視 [註解] 中的內容。資料可連結至特定 URL。
InPlaceRecords*就地記錄管理*Site*da2e115b-07e4-49d9-bb2c-35e93bb9fca9*啟用可用記錄的定義和宣告。
InPlaceRecords*就地記錄管理*Site*da2e115b-07e4-49d9-bb2c-35e93bb9fca9*啟用可用記錄的定義和宣告。
ipfsAdminLinks*InfoPath Forms Services 的管理連結。*Farm*a10b6aa4-135d-4598-88d1-8d4ff5691d13*InfoPath Forms Services 管理連結。
ipfsAdminLinks*InfoPath Forms Services 的管理連結。*Farm*a10b6aa4-135d-4598-88d1-8d4ff5691d13*InfoPath Forms Services 管理連結。
IPFSAdminWeb*InfoPath Forms Services 的管理連結。*Web*750b8e49-5213-4816-9fa2-082900c0201a*InfoPath Forms Services 管理連結。
IPFSAdminWeb*InfoPath Forms Services 的管理連結。*Web*750b8e49-5213-4816-9fa2-082900c0201a*InfoPath Forms Services 管理連結。
IPFSSiteFeatures*InfoPath Forms Services 支援*Site*c88c4ff1-dbf5-4649-ad9f-c6c426ebcbf5*讓伺服器端轉譯表單的 InfoPath Forms Services 清單及相關頁面。
IPFSSiteFeatures*InfoPath Forms Services 支援*Site*c88c4ff1-dbf5-4649-ad9f-c6c426ebcbf5*讓伺服器端轉譯表單的 InfoPath Forms Services 清單及相關頁面。
IPFSTenantFormsConfig*InfoPath Forms Services 承租人管理*Web*15845762-4ec4-4606-8993-1c0512a98680*啟用 InfoPath Forms Services 承租人管理
IPFSTenantFormsConfig*InfoPath Forms Services 承租人管理*Web*15845762-4ec4-4606-8993-1c0512a98680*啟用 InfoPath Forms Services 承租人管理
IPFSTenantWebProxyConfig*InfoPath Forms Services Web 服務 Proxy 管理*Web*3c577815-7658-4d4f-a347-cfbb370700a7*啟用 InfoPath Forms Services Web 服務 Proxy 設定的承租人管理
IPFSTenantWebProxyConfig*InfoPath Forms Services Web 服務 Proxy 管理*Web*3c577815-7658-4d4f-a347-cfbb370700a7*啟用 InfoPath Forms Services Web 服務 Proxy 設定的承租人管理
IPFSWebFeatures*InfoPath Forms Services 支援*Web*a0e5a010-1329-49d4-9e09-f280cdbed37d*讓伺服器端轉譯表單的 InfoPath Forms Services 清單及相關頁面。
IPFSWebFeatures*InfoPath Forms Services 支援*Web*a0e5a010-1329-49d4-9e09-f280cdbed37d*讓伺服器端轉譯表單的 InfoPath Forms Services 清單及相關頁面。
IssuesList*議題清單*Web*00bfea71-5932-4f9c-ad71-1557e5751100*提供網站議題清單的支援。
IssuesList*議題清單*Web*00bfea71-5932-4f9c-ad71-1557e5751100*提供網站議題清單的支援。
IssueTrackingWorkflow*三態工作流程*Site*fde5d850-671e-4143-950a-87b473922dc7*使用此工作流程來追蹤清單中的項目。
IssueTrackingWorkflow*三態工作流程*Site*fde5d850-671e-4143-950a-87b473922dc7*使用此工作流程來追蹤清單中的項目。
ItemFormRecommendations*項目表單建議*Site*39d18bbf-6e0f-4321-8f16-4e3b51212393*新增建議的 CBS 控制項至所有項目顯示表單。
LegacyDocumentLibrary*文件庫*Web*6e53dd27-98f2-4ae5-85a0-e9a8ef4aa6df*提供網站文件庫的支援。
LegacyDocumentLibrary*文件庫*Web*6e53dd27-98f2-4ae5-85a0-e9a8ef4aa6df*提供網站文件庫的支援。
LegacyWorkflows*SharePoint 2007 工作流程*Site*c845ed8d-9ce5-448c-bd3e-ea71350ce45b*SharePoint 2007 提供的現成工作流程功能彙總組合。
LegacyWorkflows*SharePoint 2007 工作流程*Site*c845ed8d-9ce5-448c-bd3e-ea71350ce45b*SharePoint 2007 提供的現成工作流程功能彙總組合。
LinksList*連結清單*Web*00bfea71-2062-426c-90bf-714c59600103*提供網站連結清單的支援。
LinksList*連結清單*Web*00bfea71-2062-426c-90bf-714c59600103*提供網站連結清單的支援。
ListTargeting*選取目標清單內容*Farm*fc33ba3b-7919-4d7e-b791-c6aeccf8f851*在「清單設定」頁面安裝一個按鈕，讓您可以使用對象來選取目標內容。
ListTargeting*選取目標清單內容*Farm*fc33ba3b-7919-4d7e-b791-c6aeccf8f851*在「清單設定」頁面安裝一個按鈕，讓您可以使用對象來選取目標內容。
LocalSiteDirectoryControl*SharePoint Portal Server Local Site Directory Capture Control*Site*14aafd3a-fcb9-4bb7-9ad7-d8e36b663bbd*SharePoint Portal Server Local Site Directory Capture Control
LocalSiteDirectoryControl*SharePoint Portal Server Local Site Directory Capture Control*Site*14aafd3a-fcb9-4bb7-9ad7-d8e36b663bbd*SharePoint Portal Server Local Site Directory Capture Control
LocalSiteDirectoryMetaData*Local Site Directory MetaData Capture Feature*Web*8f15b342-80b1-4508-8641-0751e2b55ca6*Feature that sets location to local site directory for site metadata capture
LocalSiteDirectoryMetaData*Local Site Directory MetaData Capture Feature*Web*8f15b342-80b1-4508-8641-0751e2b55ca6*Feature that sets location to local site directory for site metadata capture
LocalSiteDirectorySettingsLink*Site Settings Link to Local Site Directory Settings page.*Site*e978b1a6-8de7-49d0-8600-09a250354e14*Site Settings Link to Local Site Directory Settings page.
LocalSiteDirectorySettingsLink*Site Settings Link to Local Site Directory Settings page.*Site*e978b1a6-8de7-49d0-8600-09a250354e14*Site Settings Link to Local Site Directory Settings page.
LocationBasedPolicy*文件庫和資料夾式保留*Site*063c26fa-3ccc-4180-8a84-b6f98e991df3*允許清單管理員覆寫內容類型保留排程，並在文件庫和資料夾上設定排程。
LocationBasedPolicy*文件庫和資料夾式保留*Site*063c26fa-3ccc-4180-8a84-b6f98e991df3*允許清單管理員覆寫內容類型保留排程，並在文件庫和資料夾上設定排程。
MaintenanceLogs*維護記錄文件庫*Web*8c6f9096-388d-4eed-96ff-698b3ec46fc4*提供網站集合升級與修復記錄的存取
MaintenanceLogs*維護記錄文件庫*Web*8c6f9096-388d-4eed-96ff-698b3ec46fc4*提供網站集合升級與修復記錄的存取
ManageUserProfileServiceApplication*Manage Profile Service Application*Farm*c59dbaa9-fa01-495d-aaa3-3c02cc2ee8ff*Manage Profile Service Application.
ManageUserProfileServiceApplication*Manage Profile Service Application*Farm*c59dbaa9-fa01-495d-aaa3-3c02cc2ee8ff*Manage Profile Service Application.
MasterSiteDirectoryControl*SharePoint Portal Server 主網站目錄擷取控制*Farm*8a663fe0-9d9c-45c7-8297-66365ad50427*SharePoint Portal Server 主網站目錄擷取控制。
MasterSiteDirectoryControl*SharePoint Portal Server 主網站目錄擷取控制*Farm*8a663fe0-9d9c-45c7-8297-66365ad50427*SharePoint Portal Server 主網站目錄擷取控制。
MBrowserRedirect*行動裝置瀏覽器檢視*Web*d95c97f3-e528-4da2-ae9f-32b3535fbb59*使用 Smartphone 瀏覽器的行動裝置檢視，提供小組網站上的文件庫及其他清單。
MBrowserRedirectStapling*行動裝置瀏覽器檢視功能裝訂*Farm*2dd8788b-0e6b-4893-b4c0-73523ac261b1*啟用行動裝置瀏覽器檢視功能裝訂
MDSFeature*基本下載策略*Web*87294c72-f260-42f3-a41b-981a2ffce37a*在支援這項技術的網頁及網站範本，這項技術透過只下載並呈現網頁變更的部分，讓頁面導覽更加快速流暢。
MediaWebPart*Media Web Part*Site*5b79b49a-2da6-4161-95bd-7375c1995ef9*Enable MediaWebPart for site collection.
MembershipList*網站成員資格*Web*947afd14-0ea1-46c6-be97-dea1bf6f5bae*此功能包含的清單結構描述與清單執行個體可用於管理社群、專案、小組、教育等網站內的成員。
MetaDataNav*中繼資料導覽和篩選*Web*7201d6a4-a5d3-49a1-8c19-19c4bac6e668*為網站中的每個清單提供一個設定頁面，設定讓該清單使用中繼資料樹狀檢視階層和篩選控制項，以改善瀏覽和篩選所含的項目。
MetaDataNav*中繼資料導覽和篩選*Web*7201d6a4-a5d3-49a1-8c19-19c4bac6e668*為網站中的每個清單提供一個設定頁面，設定讓該清單使用中繼資料樹狀檢視階層和篩選控制項，以改善瀏覽和篩選所含的項目。
MobileEwaFarm*Excel Services 應用程式 Mobile Excel Web Access 功能*Farm*5a020a4f-c449-4a65-b07d-f2cc2d8778dd*新增伺服器陣列層級的 Excel Services 應用程式 Mobile Excel Web Access 功能至 Microsoft SharePoint Foundation 架構
MobileEwaFarm*Excel Services 應用程式 Mobile Excel Web Access 功能*Farm*5a020a4f-c449-4a65-b07d-f2cc2d8778dd*新增伺服器陣列層級的 Excel Services 應用程式 Mobile Excel Web Access 功能至 Microsoft SharePoint Foundation 架構
MobileExcelWebAccess*Excel Services 應用程式 Mobile Excel Web Access 功能*Site*e995e28b-9ba8-4668-9933-cf5c146d7a9f*新增網站層級的 Excel Services 應用程式 Mobile Excel Web Access 功能至 Microsoft SharePoint Foundation 架構
MobileExcelWebAccess*Excel Services 應用程式 Mobile Excel Web Access 功能*Site*e995e28b-9ba8-4668-9933-cf5c146d7a9f*新增網站層級的 Excel Services 應用程式 Mobile Excel Web Access 功能至 Microsoft SharePoint Foundation 架構
MobilityRedirect*行動捷徑 URL*Web*f41cc668-37e5-4743-b4a8-74d1db3fd8a4*提供清單中可存取之行動裝置版本的捷徑 URL (/m)。
MobilityRedirect*行動捷徑 URL*Web*f41cc668-37e5-4743-b4a8-74d1db3fd8a4*提供清單中可存取之行動裝置版本的捷徑 URL (/m)。
MonitoredApps*應用程式監視*Site*345ff4f9-f706-41e1-92bc-3f0ec2d9f6ea*可讓承租人管理員和管理中心監視應用程式
MonitoredAppsUI*應用程式監視使用者介面*Farm*1b811cfe-8c78-4982-aad7-e5c112e397d1*可讓承租人管理員和管理中心監視應用程式
MossChart*圖表網頁組件*Site*875d1044-c0cf-4244-8865-d2a0039c2a49*可協助您將 SharePoint 網站和入口網站上的資料視覺化。
MossChart*圖表網頁組件*Site*875d1044-c0cf-4244-8865-d2a0039c2a49*可協助您將 SharePoint 網站和入口網站上的資料視覺化。
MpsWebParts*會議工作區網頁組件*Web*39dd29fb-b6f5-4697-b526-4d38de4893e5*擴充網頁組件新增項目，以顯示「會議工作區」清單範本。
MpsWebParts*會議工作區網頁組件*Web*39dd29fb-b6f5-4697-b526-4d38de4893e5*擴充網頁組件新增項目，以顯示「會議工作區」清單範本。
MruDocsWebPart*最近的文件*Web*1eb6a0c1-5f08-4672-b96f-16845c2448c6*列出使用者最近存取過的文件。
MySite*我的網站*Farm*69cc9662-d373-47fc-9449-f18d11ff732c*安裝與我的網站及使用者設定檔相關的功能。
MySite*我的網站*Farm*69cc9662-d373-47fc-9449-f18d11ff732c*安裝與我的網站及使用者設定檔相關的功能。
MySiteBlog*My Site Blogs*Site*863da2ac-3873-4930-8498-752886210911*Installs My Site Blog features.
MySiteBlog*My Site Blogs*Site*863da2ac-3873-4930-8498-752886210911*Installs My Site Blog features.
MySiteCleanup*My Site Cleanup Feature*Farm*0faf7d1b-95b1-4053-b4e2-19fd5c9bbc88*Installs and uninstalls Farm-level job for My Site Cleanup.
MySiteCleanup*My Site Cleanup Feature*Farm*0faf7d1b-95b1-4053-b4e2-19fd5c9bbc88*Installs and uninstalls Farm-level job for My Site Cleanup.
MySiteDocumentLibrary*我的網站文件庫功能*Site*e9c0ff81-d821-4771-8b4c-246aa7e5e9eb*強化 [我的網站] 中現有的 SharePoint 文件庫。提供新檢視、輕量版本設定、增強式內容資訊，以及個別項目共用。
MySiteHost*我的網站主機*Site*49571cd1-b6a1-43a3-bf75-955acc79c8d8*安裝與架設我的網站相關的功能。
MySiteHost*我的網站主機*Site*49571cd1-b6a1-43a3-bf75-955acc79c8d8*安裝與架設我的網站相關的功能。
MySiteHostPictureLibrary*組織商標的共用圖片庫*Web*5ede0a86-c772-4f1d-a120-72e734b3400c*使用此圖片庫儲存組織的商標。
MySiteHostPictureLibrary*組織商標的共用圖片庫*Web*5ede0a86-c772-4f1d-a120-72e734b3400c*使用此圖片庫儲存組織的商標。
MySiteInstantiationQueues*我的網站具現化佇列計時器工作*WebApplication*65b53aaf-4754-46d7-bb5b-7ed4cf5564e1*在所有已建立的 Web Apps 上新增我的網站具現化佇列計時器工作
MySiteLayouts*我的網站版面配置功能*Site*6928b0e5-5707-46a1-ae16-d6e52522d52b*「我的網站」的功能，可將所有版面配置上傳到主版頁面圖庫。
MySiteLayouts*我的網站版面配置功能*Site*6928b0e5-5707-46a1-ae16-d6e52522d52b*「我的網站」的功能，可將所有版面配置上傳到主版頁面圖庫。
MySiteMaster*我的網站主版功能*Site*fb01ca75-b306-4fc2-ab27-b4814bf823d1*「我的網站」功能，可將主版頁面上傳到主版頁面圖庫。
MySiteMicroBlog*MySite MicroBlogging List*Web*ea23650b-0340-4708-b465-441a41c37af7*Enables MySite MicroBlogging List.
MySiteMicroBlogCtrl*MySite MicroBlogging*Site*dfa42479-9531-4baf-8873-fc65b22c9bd4*Enables MySite MicroBlogging services.
MySiteNavigation*我的網站導覽*Web*6adff05c-d581-4c05-a6b9-920f15ec6fd9*為我的網站安裝導覽提供者。
MySiteNavigation*我的網站導覽*Web*6adff05c-d581-4c05-a6b9-920f15ec6fd9*為我的網站安裝導覽提供者。
MySitePersonalSite*「我的網站」個人網站設定*Site*f661430e-c155-438e-a7c6-c68648f1b119*設定使用者的個人網站。
MySitePersonalSite*「我的網站」個人網站設定*Site*f661430e-c155-438e-a7c6-c68648f1b119*設定使用者的個人網站。
MySiteQuickLaunch*我的網站版面配置功能*Web*034947cc-c424-47cd-a8d1-6014f0e36925*「我的網站」的功能，可將所有版面配置上傳到主版頁面圖庫
MySiteQuickLaunch*我的網站版面配置功能*Web*034947cc-c424-47cd-a8d1-6014f0e36925*「我的網站」的功能，可將所有版面配置上傳到主版頁面圖庫
MySiteSocialDeployment*MySite Social Deployment Scenario*Site*b2741073-a92b-4836-b1d8-d5e9d73679bb*Enables MySite social features.
MySiteStorageDeployment*MySite Storage Deployment Scenario*Site*0ee1129f-a2f3-41a9-9e9c-c7ee619a8c33*Enables MySite storage features.
MySiteUnifiedNavigation*我的網站統一導覽功能*Web*41baa678-ad62-41ef-87e6-62c8917fc0ad*「我的網站」功能，可在主機網站與個人網站上顯示相同的導覽內容。
MySiteUnifiedQuickLaunch*我的網站單一快速啟動功能*Site*eaa41f18-8e4a-4894-baee-60a87f026e42*顯示主機與個人網站之相同快速啟動的「我的網站」功能。
MyTasksDashboard*我的任務儀表板*Web*89d1184c-8191-4303-a430-7a24291531c9*提供使用者體驗，讓使用者管理其任務、跨網站與系統彙總，並與這些動作互動。
MyTasksDashboardCustomRedirect*我的任務儀表板自訂重新導向*Farm*04a98ac6-82d5-4e01-80ea-c0b7d9699d94*這項功能可從連結的 SharePoint 任務重新導向回我的網站。
MyTasksDashboardStapling*我的任務儀表板裝訂*Farm*4cc8aab8-5af0-45d7-a170-169ea583866e*此功能會將 [我的工作儀表板] 功能裝釘 (連線) 至 [我的網站] 範本。
Navigation*Portal Navigation*Site*89e0306d-453b-4ec5-8d68-42067cdbf98e*Enable portal navigation bars.
Navigation*Portal Navigation*Site*89e0306d-453b-4ec5-8d68-42067cdbf98e*Enable portal navigation bars.
NavigationProperties*Portal Navigation Properties*Web*541f5f57-c847-4e16-b59a-b31e90e6f9ea*Set per-site navigation properties.
NavigationProperties*Portal Navigation Properties*Web*541f5f57-c847-4e16-b59a-b31e90e6f9ea*Set per-site navigation properties.
NoCodeWorkflowLibrary*無程式碼工作流程庫*Web*00bfea71-f600-43f6-a895-40c0de7b0117*提供網站無程式碼工作流程庫的支援。
NoCodeWorkflowLibrary*無程式碼工作流程庫*Web*00bfea71-f600-43f6-a895-40c0de7b0117*提供網站無程式碼工作流程庫的支援。
ObaProfilePages*BDC 設定檔頁面功能*Web*683df0c0-20b7-4852-87a3-378945158fab*啟用建立或升級 BDC 設定檔頁面的 UI。
ObaProfilePages*BDC 設定檔頁面功能*Web*683df0c0-20b7-4852-87a3-378945158fab*啟用建立或升級 BDC 設定檔頁面的 UI。
ObaProfilePagesTenantStapling*BDC 設定檔頁面承租人裝訂功能*Farm*90c6c1e5-3719-4c52-9f36-34a97df596f7*將設定檔頁面功能裝訂至使用承租人管理範本的網站。
ObaProfilePagesTenantStapling*BDC 設定檔頁面承租人裝訂功能*Farm*90c6c1e5-3719-4c52-9f36-34a97df596f7*將設定檔頁面功能裝訂至使用承租人管理範本的網站。
ObaSimpleSolution*離線同步處理外部清單*Web*d250636f-0a26-4019-8425-a5232d592c01*在外部清單和 Outlook 之間啟用離線同步處理。
ObaSimpleSolution*離線同步處理外部清單*Web*d250636f-0a26-4019-8425-a5232d592c01*在外部清單和 Outlook 之間啟用離線同步處理。
ObaStaple*離線同步處理外部清單*Farm*f9cb1a2a-d285-465a-a160-7e3e95af1fdd*啟用外部清單與 Outlook 及 SharePoint Workspace 的離線同步處理。
ObaStaple*離線同步處理外部清單*Farm*f9cb1a2a-d285-465a-a160-7e3e95af1fdd*啟用外部清單與 Outlook 及 SharePoint Workspace 的離線同步處理。
OfficeExtensionCatalog*Office 目錄的相關應用程式*Web*61e874cd-3ac3-4531-8628-28c3acb78279*佈建目錄以儲存 Office 相關應用程式
OfficeWebApps*已取代的 Office Web Apps*Site*0c504a5c-bcea-4376-b05e-cbca5ced7b4f*已取代的 Office Web Apps
OfficeWebApps*已取代的 Office Web Apps*Site*0c504a5c-bcea-4376-b05e-cbca5ced7b4f*已取代的 Office Web Apps
OffWFCommon*Microsoft Office Server workflows*Site*c9c9515d-e4e2-4001-9050-74f980f93160*This feature provides support for Microsoft Office Server workflows.
OffWFCommon*Microsoft Office Server workflows*Site*c9c9515d-e4e2-4001-9050-74f980f93160*This feature provides support for Microsoft Office Server workflows.
OnenoteServerViewing*已取代的 Office Web Apps*Site*3d433d02-cf49-4975-81b4-aede31e16edf*已取代的 Office Web Apps
OnenoteServerViewing*已取代的 Office Web Apps*Site*3d433d02-cf49-4975-81b4-aede31e16edf*已取代的 Office Web Apps
OpenInClient*預設以用戶端應用程式開啟文件*Site*8a4b8de2-6fd8-41e9-923c-c7c3c00f8295*設定連至文件的連結，使文件依預設以用戶端應用程式開啟，而非 Web 應用程式。
OpenInClient*預設以用戶端應用程式開啟文件*Site*8a4b8de2-6fd8-41e9-923c-c7c3c00f8295*設定連至文件的連結，使文件依預設以用戶端應用程式開啟，而非 Web 應用程式。
OrganizationsClaimHierarchyProvider*組織宣告階層提供者*Farm*9b0293a7-8942-46b0-8b78-49d29a9edd53*安裝以組織為基礎的宣告階層提供者。
OrganizationsClaimHierarchyProvider*組織宣告階層提供者*Farm*9b0293a7-8942-46b0-8b78-49d29a9edd53*安裝以組織為基礎的宣告階層提供者。
OSearchBasicFeature*SharePoint Server 網站搜尋*WebApplication*bc29e863-ae07-4674-bd83-2c6d0aa5623f*使用 Search Server 服務，以便對網站及清單範圍搜尋。
OSearchBasicFeature*SharePoint Server 網站搜尋*WebApplication*bc29e863-ae07-4674-bd83-2c6d0aa5623f*使用 Search Server 服務，以便對網站及清單範圍搜尋。
OSearchCentralAdminLinks*搜尋管理中心連結*Farm*c922c106-7d0a-4377-a668-7f13d52cb80f*搜尋管理中心連結。
OSearchCentralAdminLinks*搜尋管理中心連結*Farm*c922c106-7d0a-4377-a668-7f13d52cb80f*搜尋管理中心連結。
OSearchEnhancedFeature*SharePoint Server 企業版搜尋*WebApplication*4750c984-7721-4feb-be61-c660c6190d43*使用 Search Server 服務，以便對廣大的企業內容搜尋。除了清單及網站範圍之外，還提供人員設定檔、商務資料、遠端及自訂內容來源的搜尋。搜尋中心會使用多個索引標籤來顯示結果。
OSearchEnhancedFeature*SharePoint Server 企業版搜尋*WebApplication*4750c984-7721-4feb-be61-c660c6190d43*使用 Search Server 服務，以便對廣大的企業內容搜尋。除了清單及網站範圍之外，還提供人員設定檔、商務資料、遠端及自訂內容來源的搜尋。搜尋中心會使用多個索引標籤來顯示結果。
OSearchHealthReports*$Resources:HealthReportsFeatureTitle;*Site*e792e296-5d7f-47c7-9dfa-52eae2104c3b*$Resources:HealthReportsFeatureDesc;
OSearchHealthReportsPushdown*Health Reports Pushdown Feature*Farm*09fe98f3-3324-4747-97e5-916a28a0c6c0*This feature activates the Health ReportsLibrary.
OSearchHealthReportsPushdown*Health Reports Pushdown Feature*Farm*09fe98f3-3324-4747-97e5-916a28a0c6c0*This feature activates the Health ReportsLibrary.
OSearchPortalAdminLinks*搜尋管理入口網站連結及導覽列*Farm*edf48246-e4ee-4638-9eed-ef3d0aee7597*預設搜尋入口網站管理連結。
OSearchPortalAdminLinks*搜尋管理入口網站連結及導覽列*Farm*edf48246-e4ee-4638-9eed-ef3d0aee7597*預設搜尋入口網站管理連結。
OsrvLinks*Shared Services Administration Links*Web*068f8656-bea6-4d60-a5fa-7f077f8f5c20*Links to the Shared Services administration pages
OsrvLinks*Shared Services Administration Links*Web*068f8656-bea6-4d60-a5fa-7f077f8f5c20*Links to the Shared Services administration pages
OssNavigation*Shared Services Navigation*Web*10bdac29-a21a-47d9-9dff-90c7cae1301e*Shared Services Navigation
OssNavigation*Shared Services Navigation*Web*10bdac29-a21a-47d9-9dff-90c7cae1301e*Shared Services Navigation
OSSSearchEndUserHelpFeature*$Resources:SearchEndUserHelp_Feature_Title;*Site*03b0a3dc-93dd-4c68-943e-7ec56e65ed4d*$Resources:SearchEndUserHelp_Feature_Description;
OSSSearchEndUserHelpFeature*$Resources:SearchEndUserHelp_Feature_Title;*Site*03b0a3dc-93dd-4c68-943e-7ec56e65ed4d*$Resources:SearchEndUserHelp_Feature_Description;
OSSSearchSearchCenterUrlFeature*搜尋中心 URL*Web*7acfcb9d-8e8f-4979-af7e-8aed7e95245e*搜尋中心 URL 功能。
OSSSearchSearchCenterUrlFeature*搜尋中心 URL*Web*7acfcb9d-8e8f-4979-af7e-8aed7e95245e*搜尋中心 URL 功能。
OSSSearchSearchCenterUrlSiteFeature*Site collection level Search Center Url Feature*Site*7ac8cc56-d28e-41f5-ad04-d95109eb987a*adds the url of search center in the property bag of root web.
OSSSearchSearchCenterUrlSiteFeature*Site collection level Search Center Url Feature*Site*7ac8cc56-d28e-41f5-ad04-d95109eb987a*adds the url of search center in the property bag of root web.
PageConverters*文件轉頁面轉換程式*WebApplication*14173c38-5e2d-4887-8134-60f9df889bad*包含用來將文件轉換為發佈頁面的轉換程式。
PageConverters*文件轉頁面轉換程式*WebApplication*14173c38-5e2d-4887-8134-60f9df889bad*包含用來將文件轉換為發佈頁面的轉換程式。
PersonalizationSite*Personalization Site*Web*ed5e77f7-c7b1-4961-a659-0de93080fa36*Personalization Site Description
PersonalizationSite*Personalization Site*Web*ed5e77f7-c7b1-4961-a659-0de93080fa36*Personalization Site Description
PhonePNSubscriber*推播通知*Web*41e1d4bf-b1a2-47f7-ab80-d5d6cbba3092*這項功能會啟用平台功能，允許行動裝置訂閱此 SharePoint 網站上發生的事件通知。 
PictureLibrary*圖片庫*Web*00bfea71-52d4-45b3-b544-b1c71b620109*提供網站圖片庫的支援。
PictureLibrary*圖片庫*Web*00bfea71-52d4-45b3-b544-b1c71b620109*提供網站圖片庫的支援。
PortalLayouts*入口網站配置功能*Site*5f3b0127-2f1d-4cfd-8dd2-85ad1fb00bfc*將所有配置上傳到主版頁面圖庫的入口網站功能。
PortalLayouts*入口網站配置功能*Site*5f3b0127-2f1d-4cfd-8dd2-85ad1fb00bfc*將所有配置上傳到主版頁面圖庫的入口網站功能。
PowerPivotCA*PowerPivot 管理功能*Web*4f31948e-8dc7-4e67-a4b7-070941848658*PowerPivot 與管理中心整合
PowerPivotFarm*PowerPivot 整合功能*Farm*f8c51e81-0b46-4535-a3d5-244f63e1cab9*啟用 SharePoint 伺服器陣列中的 PowerPivot 查詢處理
PowerPivotFarm*PowerPivot 整合功能*Farm*f8c51e81-0b46-4535-a3d5-244f63e1cab9*啟用 SharePoint 伺服器陣列中的 PowerPivot 查詢處理
PowerPivotSite*網站集合的 PowerPivot 功能整合*Site*1a33a234-b4a4-4fc6-96c2-8bdb56388bd5*使用 PowerPivot for SharePoint 擴充網站集合的功能
PowerPivotSite*網站集合的 PowerPivot 功能整合*Site*1a33a234-b4a4-4fc6-96c2-8bdb56388bd5*使用 PowerPivot for SharePoint 擴充網站集合的功能
PPSDatasourceLib*PerformancePoint 資料來源庫範本*Web*5d220570-df17-405e-b42d-994237d60ebf*PerformancePoint 資料來源庫範本
PPSDatasourceLib*PerformancePoint 資料來源庫範本*Web*5d220570-df17-405e-b42d-994237d60ebf*PerformancePoint 資料來源庫範本
PPSMonDatasourceCtype*PerformancePoint 資料來源內容類型定義*Site*05891451-f0c4-4d4e-81b1-0dabd840bad4*PerformancePoint 資料來源內容類型定義
PPSMonDatasourceCtype*PerformancePoint 資料來源內容類型定義*Site*05891451-f0c4-4d4e-81b1-0dabd840bad4*PerformancePoint 資料來源內容類型定義
PPSRibbon*PerformancePoint 功能區*Site*ae31cd14-a866-4834-891a-97c9d37662a2*
PPSSiteCollectionMaster*PerformancePoint Services 網站集合功能*Site*a1cb5b7f-e5e9-421b-915f-bf519b0760ef*可啟用 PerformancePoint Services 的功能，包括此網站集合的內容類型和網站定義。
PPSSiteCollectionMaster*PerformancePoint Services 網站集合功能*Site*a1cb5b7f-e5e9-421b-915f-bf519b0760ef*可啟用 PerformancePoint Services 的功能，包括此網站集合的內容類型和網站定義。
PPSSiteMaster*PerformancePoint Services 網站功能*Web*0b07a7f4-8bb8-4ec0-a31b-115732b9584d*可啟用 PerformancePoint Services 清單和文件庫範本的功能。
PPSSiteMaster*PerformancePoint Services 網站功能*Web*0b07a7f4-8bb8-4ec0-a31b-115732b9584d*可啟用 PerformancePoint Services 清單和文件庫範本的功能。
PPSSiteStapling*PPS 網站裝訂*Farm*8472208f-5a01-4683-8119-3cea50bea072*PPS 網站裝訂
PPSSiteStapling*PPS 網站裝訂*Farm*8472208f-5a01-4683-8119-3cea50bea072*PPS 網站裝訂
PPSWebParts*PerformancePoint 監控*Site*ee9dbf20-1758-401e-a169-7db0a6bbccb2*PerformancePoint 監控
PPSWebParts*PerformancePoint 監控*Site*ee9dbf20-1758-401e-a169-7db0a6bbccb2*PerformancePoint 監控
PPSWorkspaceCtype*PerformancePoint 內容類型定義*Site*f45834c7-54f6-48db-b7e4-a35fa470fc9b*PerformancePoint 內容類型定義
PPSWorkspaceCtype*PerformancePoint 內容類型定義*Site*f45834c7-54f6-48db-b7e4-a35fa470fc9b*PerformancePoint 內容類型定義
PPSWorkspaceList*PerformancePoint 內容清單*Web*481333e1-a246-4d89-afab-d18c6fe344ce*PerformancePoint 內容清單
PPSWorkspaceList*PerformancePoint 內容清單*Web*481333e1-a246-4d89-afab-d18c6fe344ce*PerformancePoint 內容清單
PremiumSearchVerticals*SharePoint Server 企業版進階搜尋類別*Web*9e99f7d7-08e9-455c-b3aa-fc71b9210027*進階搜尋類別使用的佈建檔案。
PremiumSite*SharePoint Server 企業版網站集合功能*Site*8581a8a7-cf16-4770-ac54-260265ddb0b2*例如 InfoPath Forms Services、Visio Services, Access Services 及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。
PremiumSite*SharePoint Server 企業版網站集合功能*Site*8581a8a7-cf16-4770-ac54-260265ddb0b2*例如 InfoPath Forms Services、Visio Services, Access Services 及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。
PremiumSiteStapling*Premium Site Features Stapling*Farm*a573867a-37ca-49dc-86b0-7d033a7ed2c8*Staple Premium features
PremiumSiteStapling*Premium Site Features Stapling*Farm*a573867a-37ca-49dc-86b0-7d033a7ed2c8*Staple Premium features
PremiumWeb*SharePoint Server 企業版網站功能*Web*0806d127-06e6-447a-980e-2e90b03101b8*例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。
PremiumWeb*SharePoint Server 企業版網站功能*Web*0806d127-06e6-447a-980e-2e90b03101b8*例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。
PremiumWebApplication*SharePoint Server 企業版 Web 應用程式功能*WebApplication*0ea1c3b6-6ac0-44aa-9f3f-05e8dbe6d70b*例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。
PremiumWebApplication*SharePoint Server 企業版 Web 應用程式功能*WebApplication*0ea1c3b6-6ac0-44aa-9f3f-05e8dbe6d70b*例如 Visio Services、Access Services 以及 Excel Services 應用程式等功能 (隨附於 SharePoint Server 企業版授權)。
Preservation*保留清單*Site*bfc789aa-87ba-4d79-afc7-0c7e45dae01a*用來建立保留清單的清單範本。
ProductCatalogListTemplate*產品目錄清單範本*Site*dd926489-fc66-47a6-ba00-ce0e959c9b41*建立要用於產品目錄網站的清單範本
ProductCatalogResources*產品目錄網站*Site*409d2feb-3afb-4642-9462-f7f426a0f3e9*佈建用於產品目錄網站的資源
ProfileSynch*設定檔同步處理功能*Farm*af847aa9-beb6-41d4-8306-78e41af9ce25*安裝將使用者設定檔及成員資格與小組網站同步處理的工作。
ProfileSynch*設定檔同步處理功能*Farm*af847aa9-beb6-41d4-8306-78e41af9ce25*安裝將使用者設定檔及成員資格與小組網站同步處理的工作。
ProjectBasedPolicy*網站原則*Site*2fcd5f8a-26b7-4a6a-9755-918566dba90a*可讓網站集合管理員定義要套用至網站及其所有內容的保留排程。
ProjectDiscovery*我的網站建議*Web*4446ee9b-227c-4f1a-897d-d78ecdd6a824*自動建議文件和網站，以供使用者在其 SharePoint [我的網站] 上追蹤。
ProjectFunctionality*專案功能*Web*e2f2bb18-891d-4812-97df-c265afdba297*此功能會將專案管理功能新增至網站。這其中包括工作、行事曆及網站首頁的網頁組件。
PromotedLinksList*升級的連結*Web*192efa95-e50c-475e-87ab-361cede5dd7f*這項功能可讓此網站使用「升級的連結」清單範本。
Publishing*Publishing*Web*22a9ef51-737b-4ff2-9346-694633fe4416*Enable Publishing in a web.
Publishing*Publishing*Web*22a9ef51-737b-4ff2-9346-694633fe4416*Enable Publishing in a web.
PublishingLayouts*版面配置與主版頁面套件*Site*d3f51be2-38a8-4e44-ba84-940d35be1566*發佈版面配置
PublishingLayouts*版面配置與主版頁面套件*Site*d3f51be2-38a8-4e44-ba84-940d35be1566*發佈版面配置
PublishingMobile*行動和替代裝置目標*Site*57cc6207-aebf-426e-9ece-45946ea82e4a*可讓網站集合定義允許將網站上自訂最佳化頁面版本提供給行動與替代裝置的裝置通道。
PublishingPrerequisites*Publishing Prerequisites*Site*a392da98-270b-4e85-9769-04c0fde267aa*Enable Publishing prerequisites for site collection.
PublishingPrerequisites*Publishing Prerequisites*Site*a392da98-270b-4e85-9769-04c0fde267aa*Enable Publishing prerequisites for site collection.
PublishingResources*Publishing Resources*Site*aebc918d-b20f-4a11-a1db-9ed84d79c87e*Enable Publishing for site collection.
PublishingResources*Publishing Resources*Site*aebc918d-b20f-4a11-a1db-9ed84d79c87e*Enable Publishing for site collection.
PublishingSite*SharePoint Server 發佈基礎結構*Site*f6924d36-2fa8-4f0b-b16d-06b7250180fa*提供集中式程式庫、內容類型、主版頁面及版面配置，並讓網站集合可以使用頁面排程及其他發佈功能。
PublishingSite*SharePoint Server 發佈基礎結構*Site*f6924d36-2fa8-4f0b-b16d-06b7250180fa*提供集中式程式庫、內容類型、主版頁面及版面配置，並讓網站集合可以使用頁面排程及其他發佈功能。
PublishingStapling*Publishing Features Stapling*Farm*001f4bd7-746d-403b-aa09-a6cc43de7942*Staple Publishing features
PublishingStapling*Publishing Features Stapling*Farm*001f4bd7-746d-403b-aa09-a6cc43de7942*Staple Publishing features
PublishingTimerJobs*Publishing Timer Jobs*WebApplication*20477d83-8bdb-414e-964b-080637f7d99b*Create Publishing timer jobs in the web application to support scheduling and variations.
PublishingTimerJobs*Publishing Timer Jobs*WebApplication*20477d83-8bdb-414e-964b-080637f7d99b*Create Publishing timer jobs in the web application to support scheduling and variations.
PublishingWeb*SharePoint Server 發佈*Web*94c94ca6-b32f-4da9-a9e3-1f3d343d7ecb*建立網頁庫及支援庫，以根據版面配置建立並發佈頁面。
PublishingWeb*SharePoint Server 發佈*Web*94c94ca6-b32f-4da9-a9e3-1f3d343d7ecb*建立網頁庫及支援庫，以根據版面配置建立並發佈頁面。
QueryBasedPreservation*以查詢為基礎的就地保留*Site*d9742165-b024-4713-8653-851573b9dfbd*啟用以查詢為基礎的保留時，保留文件庫中儲存的內容若與此網站任何保留篩選不相符則會過期。此功能通常應用於有多個同時保留的封存網站。
Ratings*評等*Site*915c240e-a6cc-49b8-8b2c-0bff8b553ed3*使用此功能讓使用者對內容進行評價。
Ratings*評等*Site*915c240e-a6cc-49b8-8b2c-0bff8b553ed3*使用此功能讓使用者對內容進行評價。
RecordResources*記錄資源*Site*5bccb9a4-b903-4fd1-8620-b795fa33c9ba*在此網站集合內的網站中，佈建建立記錄或保留所需的資源。
RecordResources*記錄資源*Site*5bccb9a4-b903-4fd1-8620-b795fa33c9ba*在此網站集合內的網站中，佈建建立記錄或保留所需的資源。
RecordsCenter*記錄中心設定*Web*e0a45587-1069-46bd-bf05-8c8db8620b08*將網站設定為記錄中心。
RecordsCenter*記錄中心設定*Web*e0a45587-1069-46bd-bf05-8c8db8620b08*將網站設定為記錄中心。
RecordsManagement*記錄管理*Farm*6d127338-5e7d-4391-8f62-a11e43b1d404*新增記錄管理和資訊管理原則功能至 Microsoft SharePoint Foundation。
RecordsManagement*記錄管理*Farm*6d127338-5e7d-4391-8f62-a11e43b1d404*新增記錄管理和資訊管理原則功能至 Microsoft SharePoint Foundation。
RecordsManagementTenantAdmin*記錄管理承租人管理*Web*b5ef96cb-d714-41da-b66c-ce3517034c21*記錄管理承租人管理。
RecordsManagementTenantAdminStapling*記錄管理承租人管理裝訂*Farm*8c54e5d3-4635-4dff-a533-19fe999435dc*記錄管理承租人管理裝訂。
RedirectPageContentTypeBinding*SharePoint Portal Server Redirect Page Content Type Binding Feature*Web*306936fd-9806-4478-80d1-7e397bfa6474*SharePoint Portal Server Redirect Page Content Type Binding Feature
RedirectPageContentTypeBinding*SharePoint Portal Server Redirect Page Content Type Binding Feature*Web*306936fd-9806-4478-80d1-7e397bfa6474*SharePoint Portal Server Redirect Page Content Type Binding Feature
RelatedLinksScopeSettingsLink*Related Links scope settings page*Web*e8734bb6-be8e-48a1-b036-5a40ff0b8a81*Related Links scope settings page
RelatedLinksScopeSettingsLink*Related Links scope settings page*Web*e8734bb6-be8e-48a1-b036-5a40ff0b8a81*Related Links scope settings page
ReportAndDataSearch*報告與資料搜尋*Web*b9455243-e547-41f0-80c1-d5f6ce6a19e5*佈建報告與資料搜尋所用的檔案。
ReportCenterSampleData*Report Center Sample Data*Web*c5d947d6-b0a2-4e07-9929-8e54f5a9fff9*Creates a sample dashboard in the ReportsLibrary of the parent Report Center
ReportCenterSampleData*Report Center Sample Data*Web*c5d947d6-b0a2-4e07-9929-8e54f5a9fff9*Creates a sample dashboard in the ReportsLibrary of the parent Report Center
Reporting*報告*Site*7094bd89-2cfe-490a-8c7e-fbace37b4a34*建立 Microsoft SharePoint Foundation 的資訊報告。
Reporting*報告*Site*7094bd89-2cfe-490a-8c7e-fbace37b4a34*建立 Microsoft SharePoint Foundation 的資訊報告。
ReportListTemplate*SharePoint Portal Server Report Library*Web*2510d73f-7109-4ccc-8a1c-314894deeb3a*SharePoint Portal Server Report Library
ReportListTemplate*SharePoint Portal Server Report Library*Web*2510d73f-7109-4ccc-8a1c-314894deeb3a*SharePoint Portal Server Report Library
ReportsAndDataCTypes*SharePoint Portal Server Reports And Data Content Type Definition*Site*e0a9f213-54f5-4a5a-81d5-f5f3dbe48977*SharePoint Portal Server Reports and Data content type definitions
ReportsAndDataFields*SPS Reports and Data Field Definition*Site*365356ee-6c88-4cf1-92b8-fa94a8b8c118*OOB field definitions for Reports and Data
ReportsAndDataListTemplates*支援報告與資料搜尋*Site*b435069a-e096-46e0-ae30-899daca4b304*提供支援企業搜尋中心之報告與資料搜尋所需的內容類型、網站欄及文件庫範本。
ReviewPublishingSPD*發佈核准工作流程*Site*a44d2aa3-affc-4d58-8db4-f4a3af053188*安排頁面的核准流程。核准者可核准或拒絕頁面、重新指派核准工作，或是要求變更頁面。此工作流程可在 SharePoint Designer 中編輯。
ReviewPublishingSPD*發佈核准工作流程*Site*a44d2aa3-affc-4d58-8db4-f4a3af053188*安排頁面的核准流程。核准者可核准或拒絕頁面、重新指派核准工作，或是要求變更頁面。此工作流程可在 SharePoint Designer 中編輯。
ReviewPublishingSPD1028*Publishing Workflow - SharePoint 2013  (zh-tw)*Site*19f5f68e-1b92-4a02-b04d-61810ead0404*This feature provides Publishing Approval workflow for a language (zh-tw)
ReviewPublishingSPD1028*Publishing Workflow - SharePoint 2013  (zh-tw)*Site*19f5f68e-1b92-4a02-b04d-61810ead0404*This feature provides Publishing Approval workflow for a language (zh-tw)
ReviewWorkflows*傳閱工作流程*Site*02464c6a-9d07-4f30-ba04-e9035cf54392*傳送文件尋求意見反應或核准的工作流程。
ReviewWorkflows*傳閱工作流程*Site*02464c6a-9d07-4f30-ba04-e9035cf54392*傳送文件尋求意見反應或核准的工作流程。
ReviewWorkflowsSPD*傳閱工作流程 - SharePoint 2010*Site*b5934f65-a844-4e67-82e5-92f66aafe912*傳送文件以尋求意見反應或核准的工作流程。在 SharePoint Designer 中可以編輯這些工作流程。
ReviewWorkflowsSPD*傳閱工作流程 - SharePoint 2010*Site*b5934f65-a844-4e67-82e5-92f66aafe912*傳送文件以尋求意見反應或核准的工作流程。在 SharePoint Designer 中可以編輯這些工作流程。
ReviewWorkflowsSPD1028*Routing Workflows - SharePoint 2013  (zh-tw)*Site*3bc0c1e1-b7d5-4e82-afd7-9f7e59b60404*This feature provides Routing Workflows for a language (zh-tw)
ReviewWorkflowsSPD1028*Routing Workflows - SharePoint 2013  (zh-tw)*Site*3bc0c1e1-b7d5-4e82-afd7-9f7e59b60404*This feature provides Routing Workflows for a language (zh-tw)
RollupPageLayouts*彙總版面配置*Site*588b23d5-8e23-4b1b-9fe3-2f2f62965f2d*建立字詞導向彙總頁面和版面配置。
RollupPages*彙總頁面*Web*dffaae84-60ee-413a-9600-1cf431cf0560*建立字詞導向彙總頁面階層。
ScheduleList*Schedule and Reservations List*Web*636287a7-7f62-4a6e-9fcc-081f4672cbf8*This feature provides support for Schedule and Reservations list types.
ScheduleList*Schedule and Reservations List*Web*636287a7-7f62-4a6e-9fcc-081f4672cbf8*This feature provides support for Schedule and Reservations list types.
SearchAdminWebParts*Microsoft 搜尋管理網頁組件*Web*c65861fa-b025-4634-ab26-22a23e49808f*此功能可上傳搜尋管理儀表板需要的所有網頁組件。
SearchAdminWebParts*Microsoft 搜尋管理網頁組件*Web*c65861fa-b025-4634-ab26-22a23e49808f*此功能可上傳搜尋管理儀表板需要的所有網頁組件。
SearchAndProcess*搜尋與處理*WebApplication*1dbf6063-d809-45ea-9203-d3ba4a64f86d*提供搜尋與處理計時器工作。
SearchAndProcess*搜尋與處理*WebApplication*1dbf6063-d809-45ea-9203-d3ba4a64f86d*提供搜尋與處理計時器工作。
SearchCenterFiles*Search Server Center 檔案*Web*6077b605-67b9-4937-aeb6-1d41e8f5af3b*此功能可上傳 Search Server Center 檔案。
SearchCenterLiteFiles*Search Server Center Lite 檔案*Web*073232a0-1868-4323-a144-50de99c70efc*此功能可上傳 Search Server Center Lite 檔案。
SearchCenterLiteUpgrade*Search Server Center 檔案*Web*fbbd1168-3b17-4f29-acb4-ef2d34c54cfb*此功能可上傳 Search Server Center 檔案。
SearchCenterUpgrade*Search Server Center 檔案*Web*372b999f-0807-4427-82dc-7756ae73cb74*此功能可上傳 Search Server Center 檔案。
SearchConfigContentType*搜尋設定資料的內容類型*Web*48a243cb-7b16-4b5a-b1b5-07b809b43f47*安裝專門用於管理搜尋設定的內容類型。
SearchConfigFields*搜尋設定資料網站欄*Web*41dfb393-9eb6-4fe4-af77-28e4afce8cdc*安裝專門用來管理搜尋設定相關資訊的欄。
SearchConfigList*搜尋設定清單執行個體功能*Web*acb15743-f07b-4c83-8af3-ffcfdf354965*建立搜尋設定清單執行個體: 佈建一份清單，以啟用搜尋設定的匯入與匯出
SearchConfigListTemplate*搜尋設定範本功能*Web*e47705ec-268d-4c41-aa4e-0d8727985ebc*建立搜尋設定範本: 佈建一個範本，以供「搜尋設定清單」啟用搜尋設定的匯入與匯出
SearchConfigTenantStapler*$Resources:SearchConfigTenantStapler_Feature_Title;*Farm*9fb35ca8-824b-49e6-a6c5-cba4366444ab*Resources:SearchConfigTenantStapler_Feature_Description;
SearchDrivenContent*搜尋導向內容*Site*592ccb4a-9304-49ab-aab1-66638198bb58*啟用搜尋導向內容網頁組件和其他相關功能。
SearchEngineOptimization*搜尋引擎最佳化功能*Site*17415b1d-5339-42f9-a10b-3fef756b84d1*搜尋引擎最佳化功能可啟用 SEO 特定 HTML 中繼元素、SEO 屬性特殊化編輯，以及其他項目。
SearchExtensions*SearchExtensions*Site*5eac763d-fbf5-4d6f-a76b-eded7dd7b0a5*搜尋副檔名
SearchExtensions*SearchExtensions*Site*5eac763d-fbf5-4d6f-a76b-eded7dd7b0a5*搜尋副檔名
SearchMaster*Search Server 網頁組件和範本*Site*9c0834e1-ba47-4d49-812b-7d4fb6fea211*此功能可將 Search Server 網頁組件和顯示範本新增至您的網站。即使不啟動此功能，搜尋也可以在大多數網站上運作，但如果您在搜尋時收到遺失範本的訊息，那麼請啟動此功能。
SearchServerWizardFeature*$Resources:SearchServerWizard_Feature_Title;*Site*e09cefae-2ada-4a1d-aee6-8a8398215905*$Resources:SearchServerWizard_Feature_Desc;
SearchServerWizardFeature*$Resources:SearchServerWizard_Feature_Title;*Site*e09cefae-2ada-4a1d-aee6-8a8398215905*$Resources:SearchServerWizard_Feature_Desc;
SearchTaxonomyRefinementWebParts*Search Server 網頁組件和支援檔案*Site*67ae7d04-6731-42dd-abe1-ba2a5eaa3b48*此功能可上傳分類精簡搜尋所需的所有網頁組件和支援檔案。
SearchTaxonomyRefinementWebPartsHtml*Search Server 網頁組件和支援檔案*Site*8c34f59f-8dfb-4a39-9a08-7497237e3dc4*此功能可上傳分類精簡搜尋網頁組件所需的 HTML 檔案。
SearchTemplatesandResources*搜尋和內容網頁組件的顯示範本*Site*8b2c6bcb-c47f-4f17-8127-f8eae47a44dd*建立可供內容網頁組件使用的顯示範本。
SearchWebParts*Search Server 網頁組件和支援檔案*Site*eaf6a128-0482-4f71-9a2f-b1c650680e77*此功能可上傳搜尋中心所需的所有網頁組件和支援檔案。
SearchWebParts*Search Server 網頁組件和支援檔案*Site*eaf6a128-0482-4f71-9a2f-b1c650680e77*此功能可上傳搜尋中心所需的所有網頁組件和支援檔案。
SearchWebPartsStapler*Search Server 網頁組件和支援檔案裝訂器*Farm*922ed989-6eb4-4f5e-a32e-27f31f93abfa*此功能可將 Search Server 網頁組件和支援檔案功能裝訂到所有範本。
SharedServices*Shared Services Infrastructure*Farm*f324259d-393d-4305-aa48-36e8d9a7a0d6*Shared Services Infrastructure
SharedServices*Shared Services Infrastructure*Farm*f324259d-393d-4305-aa48-36e8d9a7a0d6*Shared Services Infrastructure
ShareWithEveryone*與所有人共用*Site*10f73b29-5779-46b3-85a8-4817a6e9a6c2*改善「與所有人共用」UI 所需的功能
ShareWithEveryoneStapling*「與所有人共用」功能裝訂*Farm*87866a72-efcf-4993-b5b0-769776b5283f*「與所有人共用」功能的功能裝訂
SignaturesWorkflow*收集簽章工作流程*Site*6c09612b-46af-4b2f-8dfc-59185c962a29*收集完成 Microsoft Office 文件 所需的簽章。
SignaturesWorkflow*收集簽章工作流程*Site*6c09612b-46af-4b2f-8dfc-59185c962a29*收集完成 Microsoft Office 文件 所需的簽章。
SignaturesWorkflowSPD*收集簽章工作流程 - SharePoint 2010*Site*c4773de6-ba70-4583-b751-2a7b1dc67e3a*收集完成 Microsoft Office 文件所需的簽章。在 SharePoint Designer 中可以編輯此工作流程。
SignaturesWorkflowSPD*收集簽章工作流程 - SharePoint 2010*Site*c4773de6-ba70-4583-b751-2a7b1dc67e3a*收集完成 Microsoft Office 文件所需的簽章。在 SharePoint Designer 中可以編輯此工作流程。
SignaturesWorkflowSPD1028*Collect Signatures Workflow - SharePoint 2013  (zh-tw)*Site*a42f749f-8633-48b7-9b22-403b40190404*This feature provides Collect Signatures workflow for a language (zh-tw)
SignaturesWorkflowSPD1028*Collect Signatures Workflow - SharePoint 2013  (zh-tw)*Site*a42f749f-8633-48b7-9b22-403b40190404*This feature provides Collect Signatures workflow for a language (zh-tw)
SiteAssets*網站資產*Web*98d11606-9a9b-4f44-b4c2-72d72f867da9*在目前網站中建立 SiteAssets 文件庫。
SiteFeed*網站摘要*Web*15a572c6-e545-4d32-897a-bab6f5846e18*啟用網站摘要使用。
SiteFeedController*網站摘要功能控制器*Web*5153156a-63af-4fac-b557-91bd8c315432*控制網站摘要功能的啟動。
SiteFeedStapling*網站摘要功能裝訂*Farm*6301cbb8-9396-45d1-811a-757567d35e91*將網站摘要功能裝訂到所有新的「小組網站」網站集合。
SiteHelp*自訂網站集合說明*Site*57ff23fc-ec05-4dd8-b7ed-d93faa7c795d*建立可用於儲存此網站集合的自訂說明的說明庫。
SiteHelp*自訂網站集合說明*Site*57ff23fc-ec05-4dd8-b7ed-d93faa7c795d*建立可用於儲存此網站集合的自訂說明的說明庫。
SiteNotebook*網站筆記本*Web*f151bb39-7c3b-414f-bb36-6bf18872052f*在 [共用文件] 庫中建立 Microsoft OneNote 2010 筆記本，然後在 [快速啟動] 上新增其連結。此功能必須搭配妥善設定的 WOPI 應用程式伺服器，才能建立 OneNote 2010 筆記本。
SiteServicesAddins*Site Services Addins*Site*b21c5a20-095f-4de2-8935-5efde5110ab3*Add and configure site services addins.
SiteSettings*標準網站設定連結*Farm*fead7313-4b9e-4632-80a2-98a2a2d83297*提供網站標準網站設定的支援。
SiteSettings*標準網站設定連結*Farm*fead7313-4b9e-4632-80a2-98a2a2d83297*提供網站標準網站設定的支援。
SitesList*Sites List creation feature*Web*a311bf68-c990-4da3-89b3-88989a3d7721*Feature that creates sites list and registers event recievers
SitesList*Sites List creation feature*Web*a311bf68-c990-4da3-89b3-88989a3d7721*Feature that creates sites list and registers event recievers
SiteStatusBar*Site status bar*Farm*001f4bd7-746d-403b-aa09-a6cc43de7999*在 [共用文件] 庫中建立 Microsoft OneNote 2010 筆記本，然後在 [快速啟動] 上新增其連結。此功能必須搭配妥善設定的 WOPI 應用程式伺服器，才能建立 OneNote 2010 筆記本。
SiteStatusBar*Site status bar*Farm*001f4bd7-746d-403b-aa09-a6cc43de7999*在 [共用文件] 庫中建立 Microsoft OneNote 2010 筆記本，然後在 [快速啟動] 上新增其連結。此功能必須搭配妥善設定的 WOPI 應用程式伺服器，才能建立 OneNote 2010 筆記本。
SiteUpgrade*網站升級連結*WebApplication*b63ef52c-1e99-455f-8511-6a706567740f*提供網站的標準網站升級連結。
SiteUpgrade*網站升級連結*WebApplication*b63ef52c-1e99-455f-8511-6a706567740f*提供網站的標準網站升級連結。
SkuUpgradeLinks*Sku Upgrade Links*Farm*937f97e9-d7b4-473d-af17-b03951b2c66b*Link to display the portal to office server sku upgrade page
SkuUpgradeLinks*Sku Upgrade Links*Farm*937f97e9-d7b4-473d-af17-b03951b2c66b*Link to display the portal to office server sku upgrade page
SlideLibrary*投影片庫*Web*0be49fe9-9bc9-409d-abf9-702753bd878d*當您想要共用 Microsoft PowerPoint 或相容應用程式的投影片時，請建立投影片庫。投影片庫也提供特殊功能，可以尋找、管理與重新使用投影片。
SlideLibrary*投影片庫*Web*0be49fe9-9bc9-409d-abf9-702753bd878d*當您想要共用 Microsoft PowerPoint 或相容應用程式的投影片時，請建立投影片庫。投影片庫也提供特殊功能，可以尋找、管理與重新使用投影片。
SlideLibraryActivation*Slide Library Activation*Farm*65d96c6b-649a-4169-bf1d-b96505c60375*
SlideLibraryActivation*Slide Library Activation*Farm*65d96c6b-649a-4169-bf1d-b96505c60375*
SmallBusinessWebsite*Small Business Website*Site*48c33d5d-acff-4400-a684-351c2beda865*Create a Small Business Website.
SocialDataStore*社交資料儲存區*Site*fa8379c9-791a-4fb0-812e-d0cfcac809c8*提供社交功能的資料支援
SocialRibbonControl*社交標記與記事區功能區控制項*Farm*756d8a58-4e24-4288-b981-65dc93f9c4e5*新增社交標記的進入點，以及用於註解功能區使用者介面的記事區。
SocialRibbonControl*社交標記與記事區功能區控制項*Farm*756d8a58-4e24-4288-b981-65dc93f9c4e5*新增社交標記的進入點，以及用於註解功能區使用者介面的記事區。
SocialSite*社群網站基礎結構*Site*4326e7fc-f35a-4b0f-927c-36264b0a4cf0*社群中討論區清單、評價、類別及成員資格的必要網站集合層級欄位、內容類型和網頁組件。
SPAppAnalyticsUploaderJob*上傳應用程式分析工作*Farm*abf42bbb-cd9b-4313-803b-6f4a7bd4898f*將彙總應用程式使用狀況資料上傳到 Microsoft。Microsoft 會使用這項資料來改善服務商場的應用程式品質。如果您有多個內容伺服器陣列連接到同一個搜尋伺服器，只要在其中一個伺服器陣列上啟動這項功能即可。
SpellChecking*拼字檢查*Farm*612d671e-f53d-4701-96da-c3a4ee00fdc5*在清單項目編輯表單中啟用拼字檢查。
SpellChecking*拼字檢查*Farm*612d671e-f53d-4701-96da-c3a4ee00fdc5*在清單項目編輯表單中啟用拼字檢查。
SPSBlog*部落格通知功能*Web*d97ded76-7647-4b1e-b868-2af51872e1b3*此功能會將通知新增至部落格
SPSBlogStapling*$Resources:spscore,SPSBlogStaplingFeature_Title;*Farm*6d503bb6-027e-44ea-b54c-a53eac3dfed8*此功能會將部落格通知與喜歡功能裝訂至部落格網站範本
SPSDisco*入口網站 DiscoPage 功能*Farm*713a65a1-2bc7-4e62-9446-1d0b56a8bf7f*設定 spsdisco.aspx 之預設 Web 服務 DiscoPage 屬性的入口網站功能。
SPSDisco*入口網站 DiscoPage 功能*Farm*713a65a1-2bc7-4e62-9446-1d0b56a8bf7f*設定 spsdisco.aspx 之預設 Web 服務 DiscoPage 屬性的入口網站功能。
SPSearchFeature*Microsoft SharePoint Foundation 搜尋功能*WebApplication*2ac1da39-c101-475c-8601-122bc36e3d67*Microsoft SharePoint Foundation 搜尋功能
SPSearchFeature*Microsoft SharePoint Foundation 搜尋功能*WebApplication*2ac1da39-c101-475c-8601-122bc36e3d67*Microsoft SharePoint Foundation 搜尋功能
SRPProfileAdmin*使用者設定檔管理連結*Farm*c43a587e-195b-4d29-aba8-ebb22b48eb1a*安裝與管理 User Profile Service 相關的連結。
SRPProfileAdmin*使用者設定檔管理連結*Farm*c43a587e-195b-4d29-aba8-ebb22b48eb1a*安裝與管理 User Profile Service 相關的連結。
SSSvcAdmin*Secure Store Service Admin*Web*35f680d4-b0de-4818-8373-ee0fca092526*Secure Store Service Admin Ribbon
SSSvcAdmin*Secure Store Service Admin*Web*35f680d4-b0de-4818-8373-ee0fca092526*Secure Store Service Admin Ribbon
StapledWorkflows*Office Workflows*Farm*ee21b29b-b0d0-42c6-baff-c97fd91786e6*Workflows activated automatically upon site collection creation
StapledWorkflows*Office Workflows*Farm*ee21b29b-b0d0-42c6-baff-c97fd91786e6*Workflows activated automatically upon site collection creation
SurveysList*問卷清單*Web*00bfea71-eb8a-40b1-80c7-506be7590102*提供網站問卷清單的支援。
SurveysList*問卷清單*Web*00bfea71-eb8a-40b1-80c7-506be7590102*提供網站問卷清單的支援。
TaskListNewsFeed*TaskListNewsFeed*Web*ff13819a-a9ac-46fb-8163-9d53357ef98d*TaskListNewsFeed
TasksList*工作清單*Web*00bfea71-a83e-497e-9ba0-7a5c597d0107*提供網站工作清單的支援。
TasksList*工作清單*Web*00bfea71-a83e-497e-9ba0-7a5c597d0107*提供網站工作清單的支援。
TaxonomyFeatureStapler*Taxonomy feature stapler*Farm*415780bf-f710-4e2c-b7b0-b463c7992ef0*Staples the Field Added feature to all sites created
TaxonomyFeatureStapler*Taxonomy feature stapler*Farm*415780bf-f710-4e2c-b7b0-b463c7992ef0*Staples the Field Added feature to all sites created
TaxonomyFieldAdded*Register taxonomy site wide field added event receiver*Site*73ef14b1-13a9-416b-a9b5-ececa2b0604c*Registers the field added event on all SPSites being created
TaxonomyFieldAdded*Register taxonomy site wide field added event receiver*Site*73ef14b1-13a9-416b-a9b5-ececa2b0604c*Registers the field added event on all SPSites being created
TaxonomyTenantAdmin*Taxonomy Tenant Administration*Web*7d12c4c3-2321-42e8-8fb6-5295a849ed08*Enables taxonomy tenant administration.
TaxonomyTenantAdmin*Taxonomy Tenant Administration*Web*7d12c4c3-2321-42e8-8fb6-5295a849ed08*Enables taxonomy tenant administration.
TaxonomyTenantAdminStapler*Taxonomy Tenant Administration Stapler*Farm*8fb893d6-93ee-4763-a046-54f9e640368d*Activates taxonomy related features in the tenant administration site.
TaxonomyTenantAdminStapler*Taxonomy Tenant Administration Stapler*Farm*8fb893d6-93ee-4763-a046-54f9e640368d*Activates taxonomy related features in the tenant administration site.
TaxonomyTimerJobs*Create the taxonomy timer jobs*WebApplication*48ac883d-e32e-4fd6-8499-3408add91b53*Creates the taxonomy timer jobs on all web apps being created
TaxonomyTimerJobs*Create the taxonomy timer jobs*WebApplication*48ac883d-e32e-4fd6-8499-3408add91b53*Creates the taxonomy timer jobs on all web apps being created
TeamCollab*小組共同作業清單*Web*00bfea71-4ea5-48d4-a4ad-7ea5c011abe5*透過製作可使用的標準清單，如文件庫清單及議題清單，讓網站具有小組共同作業能力。
TeamCollab*小組共同作業清單*Web*00bfea71-4ea5-48d4-a4ad-7ea5c011abe5*透過製作可使用的標準清單，如文件庫清單及議題清單，讓網站具有小組共同作業能力。
TemplateDiscovery*[連線至 Office] 功能區控制項*Farm*ff48f7e6-2fa1-428d-9a15-ab154762043d*如果使用者已安裝最新的 Office 版本，在功能區使用者介面新增進入點，以在使用者的 SharePoint 網站清單中建立文件庫捷徑。Office 會定期快取使用者本機電腦上文件庫中可用的範本。
TemplateDiscovery*[連線至 Office] 功能區控制項*Farm*ff48f7e6-2fa1-428d-9a15-ab154762043d*如果使用者已安裝最新的 Office 版本，在功能區使用者介面新增進入點，以在使用者的 SharePoint 網站清單中建立文件庫捷徑。Office 會定期快取使用者本機電腦上文件庫中可用的範本。
TenantAdminBDC*承租人 Business Data Connectivity 管理*Web*0a0b2e8f-e48e-4367-923b-33bb86c1b398*連至子頁面與 [承租人 Business Data Connectivity 管理] 功能區的連結
TenantAdminBDC*承租人 Business Data Connectivity 管理*Web*0a0b2e8f-e48e-4367-923b-33bb86c1b398*連至子頁面與 [承租人 Business Data Connectivity 管理] 功能區的連結
TenantAdminBDCStapling*承租人 Business Data Connectivity 管理裝訂*Farm*b5d169c9-12db-4084-b68d-eef9273bd898*將承租人 Business Data Connectivity 管理功能裝訂至承租人管理範本
TenantAdminBDCStapling*承租人 Business Data Connectivity 管理裝訂*Farm*b5d169c9-12db-4084-b68d-eef9273bd898*將承租人 Business Data Connectivity 管理功能裝訂至承租人管理範本
TenantAdminDeploymentLinks*Tenant Administration Content Deployment Configuration*Web*99f380b4-e1aa-4db0-92a4-32b15e35b317*Allows Tenant Administrators to configure Content Deployment for their sites.
TenantAdminDeploymentLinks*Tenant Administration Content Deployment Configuration*Web*99f380b4-e1aa-4db0-92a4-32b15e35b317*Allows Tenant Administrators to configure Content Deployment for their sites.
TenantAdminLinks*承租人管理連結*Web*98311581-29c5-40e8-9347-bd5732f0cb3e*連至 [承租人管理] 子頁面的連結，這些子頁面位於 [承租人管理] 主頁面上。
TenantAdminLinks*承租人管理連結*Web*98311581-29c5-40e8-9347-bd5732f0cb3e*連至 [承租人管理] 子頁面的連結，這些子頁面位於 [承租人管理] 主頁面上。
TenantAdminSecureStore*$Resources:obacore,tenantadminbdcFeatureTitle;*Web*b738400a-f08a-443d-96fa-a852d0356bba*$Resources:obacore,tenantadminbdcFeatureDesc;
TenantAdminSecureStore*$Resources:obacore,tenantadminbdcFeatureTitle;*Web*b738400a-f08a-443d-96fa-a852d0356bba*$Resources:obacore,tenantadminbdcFeatureDesc;
TenantAdminSecureStoreStapling*Secure Store Service 裝訂功能*Farm*6361e2a8-3bc4-4ca4-abbb-3dfbb727acd7*將 Secure Store Service 承租人管理裝訂至承租人管理範本。
TenantAdminSecureStoreStapling*Secure Store Service 裝訂功能*Farm*6361e2a8-3bc4-4ca4-abbb-3dfbb727acd7*將 Secure Store Service 承租人管理裝訂至承租人管理範本。
TenantProfileAdmin*承租人使用者設定檔應用程式*Web*32ff5455-8967-469a-b486-f8eaf0d902f9*連結至承租人使用者設定檔應用程式管理的子頁面
TenantProfileAdmin*承租人使用者設定檔應用程式*Web*32ff5455-8967-469a-b486-f8eaf0d902f9*連結至承租人使用者設定檔應用程式管理的子頁面
TenantProfileAdminStapling*承租人使用者設定檔應用程式裝訂*Farm*3d4ea296-0b35-4a08-b2bf-f0a8cabd1d7f*將承租人使用者設定檔應用程式功能裝訂到 TenantAdmin 範本
TenantProfileAdminStapling*承租人使用者設定檔應用程式裝訂*Farm*3d4ea296-0b35-4a08-b2bf-f0a8cabd1d7f*將承租人使用者設定檔應用程式功能裝訂到 TenantAdmin 範本
TenantSearchAdmin*承租人搜尋管理*Web*983521d7-9c04-4db0-abdc-f7078fc0b040*連結至搜尋管理的子頁面
TenantSearchAdminStapling*$Resources:TenantAdmin_SearchAdminFeatureStapling_Title;*Farm*08ee8de1-8135-4ef9-87cb-a4944f542ba3*$Resources:TenantAdmin_SearchAdminFeatureStapling_Description;
TimeCardList*工時記錄卡清單*Web*d5191a77-fa2d-4801-9baf-9f4205c9e9d2*此功能支援 [工時記錄卡] 清單類型。
TimeCardList*工時記錄卡清單*Web*d5191a77-fa2d-4801-9baf-9f4205c9e9d2*此功能支援 [工時記錄卡] 清單類型。
TopicPageLayouts*主題版面配置*Site*742d4c0e-303b-41d7-8015-aad1dfd54cbd*建立字詞導向主題頁面與版面配置。
TopicPages*主題頁面*Web*5ebe1445-5910-4c6e-ac27-da2e93b60f48*建立字詞導向主題頁面。
Translation*Translation*Site*4e7276bc-e7ab-4951-9c4b-a74d44205c32*Enables translation for Publishing Pages.
TranslationTimerJobs*Translation Timer Jobs*WebApplication*d085b8dc-9205-48a4-96ea-b40782abba02*Creates timer jobs in the web application to support translation import and export.
TranslationWorkflow*翻譯管理工作流程*Site*c6561405-ea03-40a9-a57f-f25472942a22*透過建立要翻譯文件的複本，並指派翻譯工作給譯者來管理文件翻譯工作。
TranslationWorkflow*翻譯管理工作流程*Site*c6561405-ea03-40a9-a57f-f25472942a22*透過建立要翻譯文件的複本，並指派翻譯工作給譯者來管理文件翻譯工作。
TransMgmtFunc*翻譯管理庫*Farm*82e2ea42-39e2-4b27-8631-ed54c1cfc491*新增用於管理文件翻譯程序的翻譯庫範本。
TransMgmtFunc*翻譯管理庫*Farm*82e2ea42-39e2-4b27-8631-ed54c1cfc491*新增用於管理文件翻譯程序的翻譯庫範本。
TransMgmtLib*翻譯管理庫*Web*29d85c25-170c-4df9-a641-12db0b9d4130*當您要以多種語言建立文件並管理翻譯工作時，請建立翻譯管理庫。翻譯管理庫包含管理翻譯程序的工作流程，並提供子資料夾、檔案版本處理及存回/取出等功能。
TransMgmtLib*翻譯管理庫*Web*29d85c25-170c-4df9-a641-12db0b9d4130*當您要以多種語言建立文件並管理翻譯工作時，請建立翻譯管理庫。翻譯管理庫包含管理翻譯程序的工作流程，並提供子資料夾、檔案版本處理及存回/取出等功能。
UPAClaimProvider*SharePoint Server 對伺服器的驗證*Farm*5709886f-13cc-4ffc-bfdc-ec8ab7f77191*此功能提供伺服器對伺服器的驗證功能
UpgradeOnlyFile*$Resources:UpgradeOnlyFile_Feature_Title;*Web*2fa4db13-4109-4a1d-b47c-c7991d4cc934*只上傳升級檔案的入口網站功能。
UpgradeOnlyFile*$Resources:UpgradeOnlyFile_Feature_Title;*Web*2fa4db13-4109-4a1d-b47c-c7991d4cc934*只上傳升級檔案的入口網站功能。
UserMigrator*共用服務提供者使用者移轉程式*Farm*f0deabbb-b0f6-46ba-8e16-ff3b44461aeb*當使用者帳戶資訊變更時，安裝與移轉使用者資料相關的功能。
UserMigrator*共用服務提供者使用者移轉程式*Farm*f0deabbb-b0f6-46ba-8e16-ff3b44461aeb*當使用者帳戶資訊變更時，安裝與移轉使用者資料相關的功能。
UserProfileUserSettingsProvider*使用者設定檔使用者設定提供者*Farm*0867298a-70e0-425f-85df-7f8bd9e06f15*這項功能可佈建使用者設定檔使用者設定提供者。
V2VPublishedLinks*V2V Published Links Upgrade*Site*f63b7696-9afc-4e51-9dfd-3111015e9a60*Add Published Links fields and content type
V2VPublishedLinks*V2V Published Links Upgrade*Site*f63b7696-9afc-4e51-9dfd-3111015e9a60*Add Published Links fields and content type
V2VPublishingLayouts*V2V Publishing Layouts Upgrade*Site*2fbbe552-72ac-11dc-8314-0800200c9a66*Add new masterpages and CSS styles
V2VPublishingLayouts*V2V Publishing Layouts Upgrade*Site*2fbbe552-72ac-11dc-8314-0800200c9a66*Add new masterpages and CSS styles
VideoAndRichMedia*視訊和多媒體*Site*6e1e5426-2ebd-4871-8027-c5ca86371ead*提供可用以儲存、管理與檢視圖像、音訊剪輯和視訊等多媒體資產的文件庫、內容類型和網頁組件。
ViewFormPagesLockDown*限制存取使用者權限鎖定模式*Site*7c637b23-06c4-472d-9a9a-7c175762c5c4*啟用此功能後，將會減少 [限制存取] 權限等級中的使用者 (例如匿名使用者) 權限，以防止其存取應用程式頁面。
ViewFormPagesLockDown*限制存取使用者權限鎖定模式*Site*7c637b23-06c4-472d-9a9a-7c175762c5c4*啟用此功能後，將會減少 [限制存取] 權限等級中的使用者 (例如匿名使用者) 權限，以防止其存取應用程式頁面。
VisioProcessRepository*Visio 程序存放庫*Web*7e0aabee-b92b-4368-8742-21ab16453d01*Visio 程序存放庫文件庫功能
VisioProcessRepository*Visio 程序存放庫*Web*7e0aabee-b92b-4368-8742-21ab16453d01*Visio 程序存放庫文件庫功能
VisioProcessRepositoryContentTypes*Visio 程序存放庫 2013 內容類型*Web*12e4f16b-8b04-42d2-90f2-aef1cc0b65d9*Visio 程序存放庫 2013 內容類型
VisioProcessRepositoryContentTypesUs*Visio 程序存放庫 2013 內容類型*Web*b1f70691-6170-4cae-bc2e-4f7011a74faa*Visio 程序存放庫 2013 內容類型
VisioProcessRepositoryFeatureStapling*Visio 程序存放庫*Farm*7e0aabee-b92b-4368-8742-21ab16453d00*Visio 程序存放庫文件庫功能
VisioProcessRepositoryFeatureStapling*Visio 程序存放庫*Farm*7e0aabee-b92b-4368-8742-21ab16453d00*Visio 程序存放庫文件庫功能
VisioProcessRepositoryUs*Visio 程序存放庫*Web*7e0aabee-b92b-4368-8742-21ab16453d02*Visio 程序存放庫文件庫功能
VisioProcessRepositoryUs*Visio 程序存放庫*Web*7e0aabee-b92b-4368-8742-21ab16453d02*Visio 程序存放庫文件庫功能
VisioServer*Visio Web Access*Farm*5fe8e789-d1b7-44b3-b634-419c531cfdca*在瀏覽器中檢視 Visio Web 繪圖
VisioServer*Visio Web Access*Farm*5fe8e789-d1b7-44b3-b634-419c531cfdca*在瀏覽器中檢視 Visio Web 繪圖
VisioWebAccess*Visio Web Access*Site*9fec40ea-a949-407d-be09-6cba26470a0c*在瀏覽器中檢視 Visio Web 繪圖
VisioWebAccess*Visio Web Access*Site*9fec40ea-a949-407d-be09-6cba26470a0c*在瀏覽器中檢視 Visio Web 繪圖
WAWhatsPopularWebPart*Web Analytics 網頁組件*Site*8e947bf0-fe40-4dff-be3d-a8b88112ade6*此功能是一個網頁組件，可顯示常用的內容、搜尋查詢及搜尋結果。
WAWhatsPopularWebPart*Web Analytics 網頁組件*Site*8e947bf0-fe40-4dff-be3d-a8b88112ade6*此功能是一個網頁組件，可顯示常用的內容、搜尋查詢及搜尋結果。
WebPageLibrary*Wiki 頁面庫*Web*00bfea71-c796-4402-9f2f-0eb9a6e71b18*一套可輕易編輯的互連式網頁，其中可包含文字、圖像，及網頁組件。
WebPageLibrary*Wiki 頁面庫*Web*00bfea71-c796-4402-9f2f-0eb9a6e71b18*一套可輕易編輯的互連式網頁，其中可包含文字、圖像，及網頁組件。
WebPartAdderGroups*網頁組件新增項目預設群組*Site*2ed1c45e-a73b-4779-ae81-1524e4de467a*新增其他預設群組至網頁組件圖庫的 QuickAddGroups 欄
WebPartAdderGroups*網頁組件新增項目預設群組*Site*2ed1c45e-a73b-4779-ae81-1524e4de467a*新增其他預設群組至網頁組件圖庫的 QuickAddGroups 欄
WhatsNewList*What's New List*Web*d7670c9c-1c29-4f44-8691-584001968a74*This feature provides support for What's New list types.
WhatsNewList*What's New List*Web*d7670c9c-1c29-4f44-8691-584001968a74*This feature provides support for What's New list types.
WhereaboutsList*$Resources:core,GbwFeatureWhereaboutsTitle;*Web*9c2ef9dc-f733-432e-be1c-2e79957ea27b*$Resources:core,GbwFeatureWhereaboutsDescription;
WhereaboutsList*$Resources:core,GbwFeatureWhereaboutsTitle;*Web*9c2ef9dc-f733-432e-be1c-2e79957ea27b*$Resources:core,GbwFeatureWhereaboutsDescription;
WikiPageHomePage*Wiki 頁面首頁*Web*00bfea71-d8fe-4fec-8dad-01c19a6e4053*此網站功能將會建立一個 Wiki 頁面，並將其設為您的網站首頁。
WikiPageHomePage*Wiki 頁面首頁*Web*00bfea71-d8fe-4fec-8dad-01c19a6e4053*此網站功能將會建立一個 Wiki 頁面，並將其設為您的網站首頁。
WikiWelcome*WikiWelcome*Web*8c6a6980-c3d9-440e-944c-77f93bc65a7e*這個功能可讓您將 Wiki 網站的首頁變成 Wiki 頁面。
WikiWelcome*WikiWelcome*Web*8c6a6980-c3d9-440e-944c-77f93bc65a7e*這個功能可讓您將 Wiki 網站的首頁變成 Wiki 頁面。
WordServerViewing*已取代的 Office Web Apps*Site*1663ee19-e6ab-4d47-be1b-adeb27cfd9d2*已取代的 Office Web Apps
WordServerViewing*已取代的 Office Web Apps*Site*1663ee19-e6ab-4d47-be1b-adeb27cfd9d2*已取代的 Office Web Apps
WorkflowAppOnlyPolicyManager*工作流程可以使用應用程式權限*Web*ec918931-c874-4033-bd09-4f36b2e31fef*允許工作流程從此網站的所有項目讀取，以及寫入此網站的所有項目。
WorkflowHistoryList*工作流程歷程記錄清單*Web*00bfea71-4ea5-48d4-a4ad-305cf7030140*提供網站工作流程歷程記錄清單的支援。
WorkflowHistoryList*工作流程歷程記錄清單*Web*00bfea71-4ea5-48d4-a4ad-305cf7030140*提供網站工作流程歷程記錄清單的支援。
workflowProcessList*WorkflowProcessList Feature*Web*00bfea71-2d77-4a75-9fca-76516689e21a*This feature provides the ability to create a list to support running custom form actions.
workflowProcessList*WorkflowProcessList Feature*Web*00bfea71-2d77-4a75-9fca-76516689e21a*This feature provides the ability to create a list to support running custom form actions.
Workflows*工作流程*Site*0af5989a-3aea-4519-8ab0-85d91abe39ff*SharePoint 提供的現成工作流程功能彙總組合。
Workflows*工作流程*Site*0af5989a-3aea-4519-8ab0-85d91abe39ff*SharePoint 提供的現成工作流程功能彙總組合。
WorkflowServiceStapler*workflow service stapler*Farm*8b82e40f-2001-4f0e-9ce3-0b27d1866dff*workflow service stapler
WorkflowServiceStore*workflow service store*Web*2c63df2b-ceab-42c6-aeff-b3968162d4b1*workflow service store
WorkflowTask*工作流程工作內容類型*Web*57311b7a-9afd-4ff0-866e-9393ad6647b1*將 SharePoint 2013 工作流程工作內容類型新增至網站中。
XmlFormLibrary*XML 表單庫*Web*00bfea71-1e1d-4562-b56a-f05371bb0115*提供網站 XML 表單庫的支援。
XmlFormLibrary*XML 表單庫*Web*00bfea71-1e1d-4562-b56a-f05371bb0115*提供網站 XML 表單庫的支援。
XmlSitemap*搜尋引擎網站地圖*Site*77fc9e13-e99a-4bd3-9438-a3f69670ed97*此功能可以透過自動週期性產生包含 SharePoint 網站中所有有效 URL 的搜尋引擎網站地圖，改善網站的搜尋引擎最佳化。必須啟用匿名存取才能使用此功能。


#-----------------------------------------------------------------------------------
#   1329  Enable-SPFeature
#-----------------------------------------------------------------------------------
$url='http://pp.pmocsd.syscom.com'
$urladm='http://localhost:2013'
Enable-SPFeature

Get-SPFeature -site   $url |sort displayname

Get-SPFeature -farm  |sort displayname   #73
Get-SPFeature -site   $url |sort displayname  #6
(Get-SPFeature -site   $url).count |sort displayname

Get-SPFeature -farm  |sort displayname   #73
Get-SPFeature -site   $urladm |sort displayname  #6
(Get-SPFeature -web   $urladm).count |sort displayname

Get-SPSite $url   | Get-SPWeb -Limit ALL | Where-Object { Get-SPFeature -Web $_ } | Select DisplayName,ID -Unique
(Get-SPFeature -Limit ALL | Where-Object {$_.Scope -eq "SITE"}).count  #215
Get-SPWeb  $url

#-http://pp.pmocsd.syscom.com/_layouts/15/ManageFeatures.aspx?Scope=Site
Disable-SPFeature

#快速入門  web
Disable-SPFeature -identity "GettingStarted" -URL $url -Confirm:$false
Enable-SPFeature  -identity "GettingStarted" -URL $url

#網站原則
Enable-SPFeature  -identity "projectbasedPolicy" -URL $url
Disable-SPFeature -identity "projectbasedPolicy" -URL $url -Confirm:$false

#網站集合的 PowerPivot 功能整合
Disable-SPFeature -identity "powerpivotsite" -URL $url -Confirm:$false
Enable-SPFeature  -identity "powerpivotsite" -URL $url

#網站設定 : 網站集合功能) SharePoint Server 企業版網站集合功能  http://localhost:2013/_layouts/15/ManageFeatures.aspx?Scope=Site
Enable-SPFeature  -identity "PremiumSite" -URL $urladm
Disable-SPFeature -identity "PremiumSite" -URL $urladm -Confirm:$false

#網站設定 : 網站功能)   http://localhost:2013/_layouts/15/ManageFeatures.aspx

Disable-SPFeature -identity "PowerPivotCA" -URL $urladm -Confirm:$false
Enable-SPFeature  -identity "PowerPivotCA" -URL $urladm
(Get-SPFeature -site $url).count # 32
(Get-SPFeature -site $urladm).count # 9    ; (Get-SPFeature -site $url).count

Get-SPFeature -web $urladm | sort  DisplayName
Get-SPFeature -web $url    | sort  DisplayName

Get-SPFeature -site $urladm | sort  DisplayName
Get-SPFeature -web $url    | sort  DisplayName  ; # (Get-SPFeature -web $url ).count  #37 32

Get-SPFeature -site $urladm    | sort  DisplayName  ; # (Get-SPFeature -site $urladm ).count  # 9
Get-SPFeature -site $url    | sort  DisplayName  ; # (Get-SPFeature -site $url ).count  # 30
#-----------------------------------------------------------------------------------
#  
#-----------------------------------------------------------------------------------