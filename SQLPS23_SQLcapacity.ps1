<#
C:\Users\administrator.CSD\OneDrive\download\PS1\SQLPS23_SQLcapacity.ps1
https://technet.microsoft.com/zh-tw/library/cc298801.aspx
https://technet.microsoft.com/en-us/library/cc298801.aspx
#>



規劃及設定儲存設備與 SQL Server 容量 (SharePoint Server 2013)
 
適用版本：SharePoint Server 2013
上次修改主題的時間：2015-03-09
摘要：了解如何在 SharePoint 2013 中規劃及設定 SQL Server 的儲存區與資料庫層。
我們提供的容量規劃資訊包含可協助您在 SharePoint Server 2013 環境中規劃及設定儲存區與 SQL Server 資料庫層的指導方針。這項資訊是以 Microsoft 內部實際機器上測試所得之結果。 但您的結果可能會因為所用設備及網站實作的功能而異。


由於 SharePoint Server 經常執行於由個別 SQL Server 資料庫管理員來管理資料庫的環境中，因此本文同時適用於 SharePoint Server 伺服器陣列實作人員與 SQL Server 資料庫管理員。本文假設使用者對 SharePoint Server 與 SQL Server 皆已有充分了解。
本文假設您熟知 SharePoint Server 2013 的容量管理及調整大小所介紹的概念。
SharePoint 2013 儲存區與資料庫層的設計與設定程序
建議您將儲存區與資料庫層設計程序分成下列步驟。以下各節將分別提供每個設計步驟的詳細資訊，包括儲存區需求與最佳作法：
1.	收集儲存區以及 SQL Server 空間和 I/O 的需求
2.	選擇 SQL Server 的版本與版次
3.	根據容量與 IO 需求設計儲存架構
4.	估計記憶體需求
5.	了解網路拓撲需求
6.	設定 SQL Server
7.	驗證儲存效能與可靠性
8.	SQL Server 2012 for SharePoint Server 2013
收集儲存區以及 SQL Server 空間和 I/O 的需求
有若干 SharePoint Server 2013 架構因素會對儲存設計產生影響。主要因素包括內容量、已啟用的功能、已部署的服務應用程式、伺服器陣列數目與可用性需求。
您必須先了解 SharePoint Server 2013 所能使用的資料庫，才能開始規劃儲存區。
本節內容：
•	SharePoint 2013 所使用的資料庫
•	了解 SQL Server 與 IOPS
•	估計核心儲存區與 IOPS 需求
•	確認服務應用程式儲存區與 IOPS 需求
•	確認可用性需求
SharePoint 2013 所使用的資料庫
隨 SharePoint 2013 安裝的資料庫，取決於環境中目前使用的功能。所有 SharePoint 2013 環境均須依賴 SQL Server 系統資料庫。本節將摘要說明隨 SharePoint 2013 安裝的資料庫。如需資料庫的詳細資訊，請參閱資料庫類型與描述 (SharePoint 2013)與支援 SharePoint 2013 的資料庫。
 附註：
有些 SharePoint 2013、SQL Server 資料庫引擎與 SQL Server Reporting Services (SSRS) 資料庫在位置方面會有特定的建議或需求。如需這些資料庫位置的相關資訊，請參閱資料庫類型與描述 (SharePoint 2013)。
 
產品版本與版次	資料庫
SharePoint Foundation 2013	設定
管理中心 內容
內容 (一或多個)
App Management Service
Business Data Connectivity
搜尋服務應用程式：
•	搜尋管理
•	Analytics 報告 (一或多個)
•	編目 (一或多個)
•	連結 (一或多個)
Secure Store Service
訂閱設定服務應用程式 (若已透過 Windows PowerShell 啟用)
Usage and Health Data Collection Service
Word Conversion Service
SharePoint Server 2013	機器翻譯服務
Managed Metadata Service
PerformancePoint Services
PowerPivot Service (Power Pivot for SharePoint 2013)
Project Server Service
狀態服務
User Profile Service 應用程式：
•	設定檔
•	同步處理
•	社交標記
Word Automation services
若您要進一步與 SQL Server 整合，您可以在環境中加入其他資料庫，如下列案例所示：
•	SQL Server 2012 Power Pivot for SharePoint 2013 可用於包含 SQL Server 2008 R2 Enterprise Edition 與 SQL ServerAnalysis Services 的 SharePoint Server 2013 環境中。若以此方式使用，您必須另行規劃以支援 Power Pivot 應用程式資料庫以及系統上的額外負載。如需詳細資訊，請參閱規劃 SharePoint 伺服陣列中的 PowerPivot 部署與 SQL Server PRO 文章了解 Microsoft Excel 2013 中的 PowerPivot 與 Power View。
•	SQL Server 2008 R2 Reporting Services (SSRS) 外掛程式可用於任何 SharePoint 2013 環境中。若您要使用此外掛程式，請進行規劃以支援兩個 SQL Server 2008 R2 Reporting Services 資料庫以及 SQL Server 2008 R2 Reporting Services 所需的額外負載。
了解 SQL Server 與 IOPS
在任何主控 SQL Server 執行個體的伺服器上，伺服器能否以最快的速度從 I/O 子系統進行回應，都是非常重要的議題。
磁碟或陣列愈多且愈快速，就愈能提供足夠的「每秒 I/O 作業數 (IOPS)」，同時讓所有磁碟維持低量的延遲與佇列作業。
您無法新增其他類型的資源 (例如 CPU 或記憶體) 來彌補 I/O 子系統緩慢的回應速度。但這可能會影響到整個伺服器陣列，並造成問題。在部署之前，請先妥善規劃以達到最低延遲，並監視您現有的系統。
在您部署新的伺服器陣列前，建議您使用 SQLIO 磁碟子系統基準工具測定 I/O 子系統的基準。請注意，這項工具適用於所有具有各種 SQL Server 版本的 Windows Server 版本。如需詳細資訊，請參閱 SQLIO 磁碟子系統基準工具。
壓力測試也可提供關於 SQL Server 的重要資訊。如需如何使用 SQLIOSim 公用程式與 SQLIO 進行壓力測試的相關資訊，請參閱 TechNet 視訊使用 SQLIOSIM 與 SQLIO 進行壓力測試 與如何使用 SQLIOSim 公用程式模擬磁碟子系統上的 SQL Server 活動。
如需有關於如何從 SQL Server 的觀點分析 IOPS 需求的詳細資訊，請參閱為 SQL Server 資料庫應用程式分析 I/O 特性及調整儲存系統大小。
估計核心儲存區與 IOPS 需求
設定與內容儲存區和 IOPS 是您在每個 SharePoint Server 2013 部署中都必須規劃的基準層。
設定儲存區與 IOPS
設定資料庫與 管理中心 內容資料庫的儲存區需求並不大。建議您為設定資料庫配置 2 GB，並且為 管理中心 內容資料庫配置 1 GB。經過一段時間後，設定資料庫可能會擴增到 1 GB 以上。它並不會快速擴增，而是以每 50,000 個網站集合約 40 MB 的速度擴增。
設定資料庫的交易記錄可能會很龐大。因此，建議您將資料庫的復原模式從完整變更為簡易。
 附註：
若您要使用 SQL Server 資料庫鏡像提供設定資料庫的可用性，您必須使用完整復原模式。
設定資料庫與 管理中心 內容資料庫的 IOPS 需求都是最低需求。
內容儲存區與 IOPS
估計內容資料庫所需的儲存區與 IOPS，並無法得出精確的數據。我們期望能透過下列資訊的測試與解說協助您得出估計值，用以判斷部署的初始大小。但在您的環境執行時，我們希望您能夠根據實際環境中的資料重新檢視您的容量需求。
若想進一步了解我們的整體容量規劃方法，請參閱 SharePoint Server 2013 的容量管理及調整大小。
用以估計內容資料庫儲存區的公式
下列程序將說明如何估計內容資料庫所需的儲存區 (不考量記錄檔)：
1.	使用下列公式可估計內容資料庫的大小：
資料庫大小 = ((D × V) × S) + (10 KB × (L + (V × D)))
 附註：
在此公式中，10 KB 這個值是一個常數，用來估計 SharePoint Server 2013 所需的中繼資料量。若您的系統需要大量使用中繼資料，您可以增加此常數。
2.	計算預期的文件數目。此值為公式中的 D。
您對文件數目的計算方式，將取決於您所使用的功能。例如，對於 我的網站 或共同作業網站，建議您先計算每個使用者的預期文件數目，再將其乘上使用者人數。對於記錄管理或內容發佈網站，您可以計算一個程序所管理及產生的文件數目。
若您是從目前的系統移轉的，您目前的成長率與使用量可能會較容易推斷。若您建立新系統，請檢視您現有的檔案共用或其他存放庫，然後根據使用率進行估計。
3.	估計您所將儲存之文件的平均大小。此值為公式中的 S。為不同的網站類型或網站群組估計平均值，可能有其效益。我的網站、媒體存放庫與不同部門入口網站的平均檔案大小可能會有很大的差異。
4.	估計環境中的清單項目數。此值為公式中的 L。
與文件相比，清單項目較難估計。我們通常會以文件數目 (D) 的三倍作為估計值，但此值會隨著網站的預期使用方式而不同。
5.	判斷版本的概數。估計文件庫中的任何文件所將擁有的平均版本數目。此值通常會遠低於允許的版本數目上限。此值為公式中的 V。
V 值必須大於零。
舉例來說，我們使用此公式與下表中的特性，共同作業環境的內容資料庫估計其資料檔所需的儲存空間。結果是，您大約需要 105 GB。
 
輸入	值
文件數目 (D)	200,000
以 10,000 個使用者乘以 20 份文件來計算
文件的平均大小 (S)	250 KB
清單項目 (L)	600,000
非現行版本數目 (V)	2
假設允許的版本數上限為 10
資料庫大小 = (((200,000 x 2)) × 250) + ((10 KB × (600,000 + (200,000 x 2))) = 110,000,000 KB 或 105 GB
 附註：
SharePoint Server 2013 中的高效率檔案 I/O，是一種會將檔案分割成片段而個別儲存及更新的儲存方法。當使用者要求檔案時，這些片段會一起串流傳送。如此可以提升 I/O 效能，且通常不會增加檔案大小。但小型檔案有可能會使所需的磁碟儲存區略為增加。
會對內容資料庫的大小產生影響的功能
下列 SharePoint Server 2013 功能可能會對內容資料庫的大小產生很大的影響：
•	資源回收桶   一份文件在從第一階段與第二階段的資源回收桶中刪除之前，會佔用內容資料庫中的空間。計算每個月刪除了多少文件，可推斷出資源回收桶對內容資料庫大小的影響。如需詳細資訊，請參閱Configure Recycle Bin settings in SharePoint Server 2013。
•	稽核   稽核資料可能會快速累加，並在內容資料庫中佔用大量的空間，尤其是在開啟檢視稽核功能時。建議您不應讓稽核資料無限制地增長，而應在必須符合法規需求或內部控制需求時，才啟用稽核功能。請使用下列指導方針，估計您必須為資料稽核工作保留多少空間：
o	估計一個網站有多少個新的稽核項目，然後將此數乘以 2 KB (項目通常限定在 4 KB 以內，平均大小約為 1 KB)。
o	根據您要配置的空間量，判斷您要讓稽核記錄保留多少天。
 附註：
Office Web Apps 與 SharePoint Server 2013 的搭配使用已不會對內容資料庫的大小產生影響。若您計劃在 SharePoint Server 2013 伺服器陣列中部署 Office Web Apps，您必須安裝 Office Web Apps Server。如需詳細資訊，請參閱搭配並用 Office Web Apps 與 SharePoint 2013
估計內容資料庫的 IOPS 需求
內容資料庫的 IOPS 需求會隨著環境的使用方式、可用的磁碟空間與您所擁有的伺服器目錄，而有很大的差異。一般而言，我們會建議您將環境中的預期工作量與我們已測試的其中一個解決方案相比較。如需詳細資訊，請參閱效能及容量測試結果與建議 (SharePoint Server 2013)。
在測試中，我們發現內容資料庫大多介於 0.05 IOPS/GB 到 0.2 IOPS/GB 左右。我們也發現，最佳作法是將上限提高為 0.5 IOPS/GB。此值高於必要值，並且可能遠高於您的環境所需的數量。請注意，若您使用鏡像，這可能會產生比原有的內容資料庫還多的 IO。請記住，鏡像的內容資料庫絕不會是輕量型。
估計服務應用程式儲存區需求與 IOPS
在估計內容儲存區與 IOPS 需求後，您必須判斷您的環境使用的服務應用程式所需的儲存區與 IOPS。
SharePoint Server 2013 服務應用程式儲存區與 IOPS 需求
要估計系統中的服務應用程式所需的儲存區，您必須先了解服務應用程式及其使用方式。下表列出可在 SharePoint Server 2013 中使用以及具有資料庫的服務應用程式。在 SharePoint Server 2013 中，除了搜尋服務應用程式與 User Profile Service 應用程式以外，所有服務應用程式的儲存區與 IOPs 資料皆仍與 SharePoint Server 2010 中的相同。
搜尋服務應用程式儲存區與 IOPS 需求
資料庫	調整大小	磁碟 IOPS	磁碟大小	10M 的項目	100M 的項目
編目	每 20M 的項目一個資料庫
SQL IOPS：10 (每 1 DPS)	中/高	中	15GB
2GB 的記錄	110GB
50GB 的記錄
連結	每 60M 的項目一個資料庫
SQL IOPS：10 (每 1M 的項目)	中	中	10GB
0.1GB 的記錄	80GB
5GB 的記錄
Analytics 報告	達到 100-300GB 時分割	中	中	使用相依性	使用相依性
搜尋管理	一個資料庫	低	低	0.4GB
1GB 的記錄	1GB 的資料
2GB 的記錄
服務應用程式儲存區需求與 IOPS 建議
服務應用程式	大小估計建議
User Profile	User Profile Service 應用程式與三個資料庫相關聯：設定檔、同步處理及社交標記。
 附註：
User Profile 資料庫儲存區需求與 IOPS 建議尚未完成測試。如需相關資訊，請查看前文。
如需 User Profile 資料庫的限制，請參閱資料庫類型與描述 (SharePoint 2013)。
Managed Metadata Service	Managed Metadata Service 應用程式具有一個資料庫。此資料庫的大小會受到系統中使用的內容類型數目與關鍵字數目的影響。許多環境都會有多個 Managed Metadata Service 應用程式執行個體。
Secure Store Service	Secure Store 服務應用程式資料庫的大小，取決於存放區中的認證數目與稽核表格中的項目數。對於此資料庫，建議您為每 1,000 個認證配置 5 MB。其 IOPS 是最小數目。
狀態服務	狀態服務應用程式具有一個資料庫。建議您為此資料庫配置 1 GB。其 IOPS 是最小數目。
Word Automation Services	Word Automation Service 應用程式具有一個資料庫。建議您為此資料庫配置 1 GB。其 IOPS 是最低的。
PerformancePoint Services	PerformancePoint Service 應用程式具有一個資料庫。建議您為此資料庫配置 1 GB。其 IOPS 是最小數目。
Business Data Connectivity Service	Business Data Connectivity Service 應用程式具有一個資料庫。此資料庫很小，且不太可能大幅增長。其 IOPS 是最小數目。
App Management	App Management Service 應用程式具有一個資料庫。此資料庫很小，且不太可能大幅增長。其 IOPS 是最小數目。
Word Automation Services	Word Automation Services 應用程式具有一個資料庫。此資料庫很小，且不太可能大幅增長。其 IOPS 是最小數目。
PerformancePoint Services	The PerformancePoint Services 具有一個資料庫。此資料庫很小，且不太可能大幅增長。其 IOPS 是最小數目。
Power Pivot	Power Pivot 服務應用程式具有一個資料庫。此資料庫很小，且對 I/O 沒有多大的影響。建議您使用與 SharePoint 內容資料庫相同的 IOPS。請注意，內容資料庫的 I/O 需求與比 Power Pivot 服務應用程式資料庫來得高。
確認可用性需求
可用性是指使用者對 SharePoint Server 2013 環境感受到的可用程度。可用系統是具有彈性的系統，也就是說，影響服務的事件並不常發生，即使發生，也會採取及時有效的動作加以解決。
可用性需求可能會大幅增加您的儲存需求。如需詳細資訊，請參閱為 SharePoint 2013 打造高可用性架構和策略。此外，也請參閱 SQL Server 2012 白皮書 AlwaysOn 架構指南：使用 AlwaysOn 可用性群組建置高可用性與災害復原解決方案
選擇 SQL Server 的版本與版次
建議您考慮在 SQL Server 2008 R2 Service Pack 1 (SP1)、SQL Server 2012 或 SQL Server 2014 的 Enterprise Edition 上執行您的環境，以充分運用這些版本特有的效能、可用性、安全性與管理功能。若想進一步了解 SQL Server 2008 R2 SP1、SQL Server 2012 和 SQL Server 2014 Enterprise Edition 有何優點，請參閱 SQL Server 2014 版本支援的功能、SQL Server 2012 版本支援的功能和 SQL Server 2008 R2 版本支援的功能。
特別是，您應考量您是否需要下列功能：
•	備份壓縮   備份壓縮可加快任何 SharePoint 備份的速度，並且適用於 SQL Server 2008 R2 Service Pack 1 (SP1) 或 SQL Server 2012 Enterprise Edition 或 Standard Edition。您只要在備份指令碼中設定壓縮選項，或是將執行 SQL Server 的伺服器預設成會執行壓縮，即可讓您的資料庫備份與傳送的記錄大幅縮減其大小。如需詳細資訊，請參閱備份壓縮 (SQL Server) (適用於 SQL Server 2008 R2 SP1)、備份壓縮 (SQL Server) (適用於 SQL Server 2012) 和備份壓縮 (SQL Server) (適用於 SQL Server 2014)。
 附註：
SQL Server 資料壓縮不適用於 SharePoint 2013 (搜尋服務應用程式資料庫除外)。
•	透明資料加密   若您的安全性需求中包括必須使用透明資料加密，您必須使用 SQL Server Enterprise Edition。
•	內容部署   若您要使用內容部署功能，請考慮使用 SQL Server Enterprise Edition，讓系統能夠充分運用資料庫快照的功能。
 附註：
若您使用的是不支援資料庫快照的遠端 BLOB 儲存區提供者，您就無法使用快照進行內容部署或備份。
•	遠端 BLOB 儲存區   若您要在與每個內容資料庫相關聯的檔案以外的資料庫或位置上使用遠端 BLOB 儲存區，您必須使用 SQL Server 2008 R2 SP1 或 SQL Server 2012 Enterprise Edition。
•	資源管理員   資源管理員是 SQL Server 2008 中導入的技術，可讓您對傳入要求所使用的資源量指定限制，以管理 SQL Server 工作量與資源。資源管理員可讓您根據自己指定的限制對工作量進行區別，以及在受到要求時配置 CPU 與記憶體。資源管理員僅適用於 SQL Server 2008 R2 SP1 Enterprise Edition。如需如何使用資源管理員的詳細資訊，請參閱使用資源管理員來管理 SQL Server 工作量 (適用於 SQL Server 2008 R2 SP1)、使用資源管理員來管理 SQL Server 工作量 (適用於 SQL Server 2012) 或資源管理員 (適用於 SQL Server 2014)。
建議您搭配使用資源管理員與 SharePoint Server 2013，以執行下列作業：
o	限制搜尋編目元件的目標 Web 伺服器所能使用的 SQL Server 資源量。根據最佳作法，建議您在系統負載偏低時將編目元件限定為 10% 的 CPU 使用量。
o	請監視系統中的每個資料庫所使用的資源量。例如，您可以利用資源管理員來判斷資料庫在執行 SQL Server 的電腦間最適當的配置方式。
•	Power Pivot for SharePoint 2013  可讓使用者在 Excel 與瀏覽器中對他們產生的資料模型與分析進行共用與共同作業，同時自動重新整理這些分析。這是 SQL Server 2008 R2 Analysis Services (SSAS) 資料中心與 Enterprise Edition、SQL Server 2012 SP1 Analysis Services (SSAS) Enterprise Edition 和 SQL Server 2014 Analysis Services (SSAS) Enterprise 和 Business Intelligence Edition 的一部分。
根據容量與 IO 需求設計儲存架構
您為環境選取的儲存架構與磁碟類型，可能會對系統效能產生影響。
本節內容：
•	選擇儲存架構
•	選擇磁碟類型
•	選擇 RAID 類型
選擇儲存架構
SharePoint Server 2013 支援直接連接儲存裝置 (DAS)、儲存區域網路 (SAN) 與網路連接儲存裝置 (NAS) 儲存架構，但 NAS 只能用於依設定會使用遠端 BLOB 儲存區的內容資料庫。您應根據您的商務解決方案與現有基礎結構內的因素，做出適當選擇。
任何儲存架構都必須支援您的可用性需求，並且能夠適當提供 IOPS 與延遲性。要受到支援，系統必須能穩定地在 20 毫秒 (ms) 內傳回資料的第一個位元組。
直接連接儲存裝置 (DAS)
DAS 是一種數位儲存系統，直接連接至伺服器或工作站，其間沒有儲存網路。DAS 實體磁碟類型包括序列連接 SCSI (SAS) 與序列連接 ATA (SATA)。
一般而言，若共用儲存平台不一定能達到 20 毫秒的回應時間，也不一定有足夠的容量可供平均與尖峰 IOPS 使用時，建議您選擇 DAS 架構。
儲存區域網路 (SAN)
SAN 是以特定方式將遠端電腦儲存裝置 (例如磁碟陣列與磁帶櫃) 連接至伺服器，使裝置如同在本機上連接至作業系統的架構 (例如區塊儲存區)。
一般而言，若共用儲存區對您的組織很有助益時，我們會建議您選擇 SAN。
共用儲存區的好處包括：
•	較容易在伺服器之間重新配置磁碟儲存區。
•	可為多部伺服器提供服務。
•	可存取的磁碟沒有數量上的限制。
網路連接儲存裝置 (NAS)
NAS 裝置是一種連接至網路的自助式電腦。它唯一的目的，就是將以檔案為基礎的資料儲存服務提供給網路上的其他裝置。NAS 裝置上的作業系統與其他軟體可提供資料儲存、檔案系統、存取檔案等功能，並且有能力管理這些功能 (例如檔案儲存)。
 附註：
NAS 只能用於依設定會使用遠端 BLOB 儲存區 (RBS) 的內容資料庫。任何網路儲存架構皆必須在 1 毫秒內回應 ping，並且在 20 毫秒內傳回資料的第一個位元組。此限制不適用於本機 SQL Server FILESTREAM 提供者，因為此提供者只會將資料儲存在相同伺服器上的本機位置。
當您使用Internet Small Computer System Interface (iSCSI)，並將其視為 NAS 通訊協定時，可能會產生某些混淆。若您透過 Common Internet File System (CFIS) 存取 iSCSI 儲存區，則會是 NAS 通訊協定。這表示，您無法將此儲存區用於未設定成使用 RBS 的內容資料庫。但若您透過本機連接的硬碟存取此 iSCSI 儲存區，此儲存區即會被視為 SAN 架構。這表示您可以將其用於 NAS。
選擇磁碟類型
您在系統中使用的磁碟類型可能會對可靠性與效能產生影響。在其他因素不變的情況下，磁碟機愈大，平均搜尋時間就愈長。SharePoint Server 2013 支援下列類型的磁碟機：
•	小型電腦系統介面 (SCSI)
•	序列進階技術連接 (SATA)
•	序列連接 SCSI (SAS)
•	光纖通道 (FC)
•	整合式電子裝置 (IDE)
•	固態硬碟 (SSD) 或快閃磁碟機
如需在 SQL Server 中使用固態硬碟作為儲存區的相關資訊，請參閱 SQL Server PRO 文章在 SQL Server 儲存解決方案中使用固態硬碟。
選擇 RAID 類型
RAID (獨立磁碟容錯陣列) 常用來改善個別磁碟的效能特性 (藉由去除數個磁碟間的資料) 以及防止個別磁碟發生故障。
所有 RAID 類型皆適用於 SharePoint Server 2013。但建議您使用 RAID 10 或供應商特有而具有同等效能的 RAID 解決方案。
在設定 RAID 陣列時，請確實根據供應商提供的偏移適當調校檔案系統。
如需為 SQL Server 2008 R2 SP1 及 SQL Server 2012 佈建 RAID 的詳細資訊，請參閱 RAID。
估計記憶體需求
SharePoint Server 2013 所需的記憶體，與您在執行 SQL Server 的伺服器上主控的內容資料庫大小有直接的關聯。
當您新增服務應用程式與功能時，需求很可能就會增加。下表提供我們建議您使用多少記憶體的準則。
 附註：
根據我們的定義，中小型部署是指 SharePoint Server 2013 的容量管理及調整大小概觀一文中的參考架構一節中所說明的部署。
 
內容資料庫的合併大小	針對執行 SQL Server 的電腦所建議的 RAM
小型生產部署的最低需求	8 GB
中型生產部署的最低需求	16 GB
2 TB 以內的建議	32 GB
2 TB 至 5 TB 的建議	64 GB
超過 5 TB 的建議	超過 64 GB 的額外 RAM 可改善 SQL Server 快取速度
 附註：
由於在 SharePoint Server 2013 環境中有配送資料的需求，因此這些值高於我們針對 SQL Server 而建議的最小值。如需 SQL Server 系統需求的詳細資訊，請參閱安裝 SQL Server 2012 的硬體與軟體需求。
如需 SQL Server 容量限制與規格的相關資訊，請參閱依 SQL Server 的版本計算容量限制和 SQL Server 的最高容量規格
其他可能影響到所需記憶體的因素包括：
•	是否使用 SQL Server 鏡像。
•	是否經常使用大於 15 MB 的檔案。
了解網路拓撲需求
請規劃伺服器陣列以內和之間的網路連線。建議您使用低延遲的網路。
下表提供若干最佳作法與建議：
•	伺服器陣列中的所有伺服器對於執行 SQL Server 的伺服器均應具有 LAN 頻寬與延遲。
•	建議您不要使用此類廣域網路 (WAN) 拓撲：從伺服器陣列的其他元件，透過延遲大於 1 毫秒的網路從遠端部署執行 SQL Server 的伺服器。因為此類拓撲尚未經過測試。
•	若您要使用 SQL Server AlwaysOn 實作套件、鏡像、記錄傳送或容錯移轉叢集以保有最新的遠端網站，請規劃適當的 WAN 網路。
•	我們建議，Web 伺服器與應用程式伺服器應具有兩張網路介面卡：一張網路介面卡用來處理使用者流量，另一張用來處理與執行 SQL Server 的伺服器之間的通訊。
 附註：
若您使用 iSCSI，請確定每張網路介面卡僅專用於網路通訊或 iSCI，而非同時用於兩者。
如需與建議的 SharePoint 2013 拓撲有關的資訊，請參閱下列技術圖表：
•	SharePoint 2013 的簡化拓撲
•	SharePoint 2013 的傳統拓撲
設定 SQL Server
以下幾節將說明如何妥善規劃以設定 SQL Server for SharePoint Server 2013。
本節內容：
•	確認所需的執行個體或伺服器數量
•	設定儲存區與記憶體
•	設定 SQL Server 選項
•	設定資料庫
估計所需的伺服器數量
一般而言，SharePoint Server 2013 會以充分運用 SQL Server 的擴充功能作為其設計方向。例如，相較於僅使用幾部大型伺服器，環境中若有許多執行 SQL Server 的中型伺服器，SharePoint Server 2013 會有較理想的執行效能。
SQL Server 應一律配置在專用伺服器上，且該伺服器並未執行任何其他伺服器陣列角色，或未主控任何其他應用程式的資料庫。此建議唯一的例外狀況，是您在開發環境或非效能導向的測試環境中，將系統部署於獨立伺服器時。
以下提供一般指引，說明何時應另行部署將會執行 SQL Server 執行個體的伺服器：
•	基於容量考量而執行四部以上的 Web 伺服器時，請另行新增資料庫伺服器。
•	當您目前的伺服器已達到 RAM、CPU、磁碟 IO 輸送量、磁碟容量或網路輸送量的有效資源上限時，請另行新增資料庫伺服器。
如需詳細資訊，請參閱依 SQL Server 的版本計算容量限制和 SQL Server 的最高容量規格。
若您在執行 Secure Store 服務應用程式時想要提升安全認證儲存區，建議您將 Secure Store 資料庫放置在僅限一個管理員可存取的個別資料庫執行個體上。
設定儲存區與記憶體
在執行 SQL Server 2008 R2 SP1 或 SQL Server 2012 的伺服器上，建議每個 CPU 的 L2 快取至少要有 2 MB，以提升記憶體效能。
遵循供應商的儲存設定建議
在設定實體儲存陣列時若要達到最佳效能，請遵循儲存供應商所提供的硬體設定建議，而不要使用作業系統的預設值。
若您沒有供應商所提供的指引，建議您使用 DiskPart.exe 磁碟設定公用程式來設定 SQL Server 2008 的儲存區。如需詳細資訊，請參閱預先部署 I/O 的最佳作法。
建議您使用可從 Windows Server 2012 使用的 Windows PowerShell 儲存 Cmdlet。如需詳細資訊，請參閱 Windows PowerShell 中的儲存 Cmdlet。
盡可能提供最多資源
確定對磁碟的 SQL Server I/O 通道並未讓其他應用程式共用，例如分頁檔與 Internet Information Services (IIS) 記錄。
盡可能提供較大的匯流排頻寬。匯流排頻寬愈大，可靠性與效能就愈高。請考量到磁碟並非匯流排頻寬的唯一使用者。例如，您也必須將網路存取納入考量。
設定 SQL Server 選項
下列 SQL Server 設定與選項應在您部署 SharePoint Server 之前設定。
•	在主控 SQL Server 及支援 SharePoint Server 的伺服器上，請不要啟用「自動建立統計資料」。SharePoint Server 會在佈建與升級期間設定必要的設定。「自動建立統計資料」可能會大幅變更從某個 SQL Server 執行個體對另一個 SQL Server 執行個體執行查詢的計劃。因此，為了讓所有客戶獲得一致的支援，SharePoint Server 會視需要提供查詢的編碼提示，以期在各種情況下都能達到最佳效能。
•	若確保最佳效能，強烈建議您將平行處理原則的最大程度 (MAXDOP)] 設為 1 (主控 SharePoint Server 2013 資料庫的 SQL Server 執行個體)。如需如何設定平行處理原則的最大程度的詳細資訊，請參閱平行處理原則的最大程度選項 (適用於 SQL Server 2008 R2 SP1)、設定平行處理原則的最大程度伺服器設定選項 (適用於 SQL Server 2012) 或 設定平行處理原則的最大程度伺服器設定選項 (適用於 SQL Server 2014)。
設定資料庫
下列指引說明您在環境中設定每個資料庫時所應採行的最佳規劃方式。
將您的資料分散到磁碟間並設定優先順序
理想狀況下，您應將 tempdb 資料庫、內容資料庫、使用狀況資料庫、搜尋資料庫與 SQL Server 2008 R2 SP1 及 SQL Server 2012 交易記錄放置在不同的實體硬碟上。
下表提供為資料設定優先順序時的若干最佳作法與建議：
•	在較快速的磁碟間設定資料的優先順序時，請使用下列排名：
1.	Tempdb 資料檔與交易記錄
2.	資料庫交易記錄檔
3.	搜尋管理資料庫以外的搜尋資料庫
4.	資料庫資料檔
在十分偏重於讀取性的入口網站中，資料的優先順序應高於記錄。
•	測試與客戶資料顯示，SharePoint Server 2013 伺服器陣列的效能可能因 tempdb 的磁碟 I/O 不足而嚴重下滑。若避免發生此問題，請為 tempdb 配置專用磁碟。若預期或已監控到高工作量 (亦即，平均讀取動作或平均寫入動作需要 20 毫秒以上才能完成)，您可能必須將檔案分散到各個磁碟間，或將更換為速度較快的磁碟，以緩解瓶頸。
•	為達到最佳效能，請將 tempdb 放置在 RAID 10 陣列上。tempdb 資料檔的數目應與核心 CPU 的數目相等，且各個 tempdb 資料檔應設為相同大小。此時請將雙核心處理器計為兩個 CPU。各個支援超執行緒的處理器應分別計為單一 CPU。如需詳細資訊，請參閱最佳化 tempdb 效能。
•	請將資料庫資料檔與交易記錄檔分散到不同的磁碟間。若因為檔案太小而無法給予完整磁碟或等量磁碟區，或是您的磁碟空間不足，而使檔案必須共用磁碟，請將使用模式不同的檔案放在相同磁碟上，以盡可能減少並行存取要求。
•	請洽詢您的儲存硬體供應商，了解如何設定所有的記錄與搜尋資料庫，讓您特定的儲存解決方案達到最佳寫入效能。
將多個資料檔用於內容資料庫
請遵循下列建議以達到最佳效能：
•	僅在資料庫的主要檔案群組中建立檔案。
•	將檔案分散到不同磁碟。
•	資料檔的數目應小於或等於核心 CPU 的數目。此時請將雙核心處理器計為兩個 CPU。各個支援超執行緒的處理器應分別計為單一 CPU。
•	建立大小相同的資料檔。
 重要事項：
雖然您可以使用 SharePoint Server 2013 的內建備份與復原工具來備份及復原多個資料檔，但若您在相同位置上覆寫，則這些工具無法將多個資料檔還原到不同位置。因此，強烈建議您將多個資料檔用於內容資料庫時，應使用 SQL Server 備份與復原工具。如需如何備份及復原 SharePoint Server 2013 的詳細資訊，請參閱在 SharePoint 2013 中規劃備份及復原。
如需如何建立及管理檔案群組的詳細資訊，請參閱實體資料庫檔案與檔案群組。
限制內容資料庫大小以方便管理
規劃調整資料庫大小的作業，以提升環境的可管理性、效能與升級的簡易性。
為確保系統效能，建議您將內容資料庫的大小限定為 200 GB (當特定使用案例與情況支援較大的大小時除外)。如需內容資料庫大小限制的詳細資訊，請參閱 SharePoint 2013 的軟體界限及限制中的內容資料庫限制一節。
一般情況下，我們建議網站集合不應超過 100 GB，除非那是資料庫中唯一的網站集合，因此您可以在必要時使用 SharePoint Server 2013 的細微備份工具將網站集合移至其他資料庫。
主動管理資料檔與記錄檔的增長
建議您考量下列建議，以主動管理資料檔與記錄檔的增長：
•	盡可能將所有資料檔與記錄檔預先擴增至預期的最終大小。
•	建議您啟用以安全為考量的自動擴增功能。請不要使用預設的自動擴增設定。設定自動擴增功能時，請考量下列準則：
o	若您所規劃的內容資料庫超過建議的大小 (200 GB)，請將資料庫自動擴增值設為固定的 MB 數，而不要設為百分比。這將會降低 SQL Server 增加檔案大小的頻率。增加檔案大小是一種會以空白頁面填入新空間的阻礙性動作。
o	若預期內容資料庫的計算大小在明年內不會達到建議的大小上限 200 GB，請使用 ALTER DATABASE MAXSIZE 屬性，將大小上限設為該資料庫在一年內預期會達到的大小上限 (保留 20% 的誤差範圍) 。請定期檢視此設定，以確定該值仍適用 (以過去的成長率為準)。
•	在磁碟間保留至少 25% 的可用空間，供擴增與尖峰使用模式之用。若您藉由在 RAID 陣列中新增磁碟或配置更多儲存區來管理擴增，請密切監視磁碟大小以避免空間不足。
驗證及監視儲存區與 SQL Server 的效能
測試您的效能與備份解決方案在硬體上是否可讓您符合服務等級協定 (SLA)。特別是，請為執行 SQL Server 的電腦測試其 I/O 子系統，以確定效能良好。
測試您所使用的備份解決方案，以確定它可在可用的維護時程內完成系統備份。若備份解決方案無法符合您的企業所需的 SLA，請考慮使用累加備份解決方案，例如 System Center 2012 - Data Protection Manager (DPM) Service Pack 1 (SP1)。
請務必對執行 SQL Server 的伺服器追蹤下列資源元件：CPU、記憶體、快取/點擊比率與 I/O 子系統。若有一或多個元件疑似變慢或負載過重，請根據目前與預測的工作量分析適當的策略。如需詳細資訊，請參閱效能的監視與調整 (適用於 SQL Server 2008 R2 SP1) 與效能的監視與調整 (適用於 SQL Server 2012)。
以下幾節將列出我們建議您用來對執行於 SharePoint Server 2013 環境中的 SQL Server 資料庫監視效能的效能計數器。
如需如何監視效能及使用效能計數器的詳細資訊，請參閱 Windows 效能監視器與監視效能
要監視的 SQL Server 計數器
請監視下列 SQL Server 計數器，以確定伺服器的狀況：
•	一般統計資料   此物件會提供計數器，用以監視一般的全伺服器活動，例如目前連線數目，以及每秒從執行 SQL Server 執行個體的電腦上連線及中斷連線的使用者人數。請考慮監視下列計數器：
o	使用者連線   此計數器會顯示您執行 SQL Server 之電腦上的使用者連線數目。若您發現此數比起基準已增加了 500%，就可能出現效能下降的情況。
•	資料庫   此物件提供的計數器可監視大量複製作業、備份與還原輸送量以及交易記錄活動。監視交易與交易記錄，可判斷資料庫中發生了多少使用者活動，以及交易記錄的滿溢程度。使用者活動的數量可決定資料庫的效能，並且可能影響記錄大小、鎖定與複寫。監視低層級記錄活動以測量使用者活動與資源使用量，可協助您找出效能瓶頸。請考慮監視下列計數器：
o	交易/秒   此計數器會顯示指定資料庫或整部伺服器上每秒的交易數目。此數目可加入您的基準中，並可協助您進行問題的疑難排解。
•	鎖定   此物件可提供 SQL Server 對個別資源類型之鎖定的相關資訊。請考慮監視下列計數器：
o	平均等候時間 (毫秒)   此計數器會顯示每個導致等候狀況之鎖定要求的平均等候時間。
o	鎖定等候時間 (毫秒)   此計數器會顯示上一秒之鎖定的等候時間。
o	鎖定等候/秒   此計數器會顯示每秒內無法立即獲得應允而必須等候資源的鎖定數目。
o	死結數目/秒   此計數器會顯示執行 SQL Server 的電腦上每秒的死結數目。此數不應超過 0。
•	閂鎖   此物件所提供的計數器可監視名為閂鎖的內部 SQL Server 資源鎖定。監視閂鎖以判斷使用者活動與資源使用量，可協助您找出效能瓶頸。請考慮監視下列計數器：
o	平均閂鎖等候時間 (毫秒)   此計數器會顯示必須等候之閂鎖要求的平均閂鎖等候時間。
o	閂鎖等候/秒   此計數器會顯示無法立即獲得應允的閂鎖要求數目。
•	SQL 統計資料   此物件所提供的計數器可監視編譯以及傳送至 SQL Server 執行個體的要求類型。監視查詢的編譯與重新編譯數目以及 SQL Server 執行個體所接收的批次數目，可讓您了解 SQL Server 處理使用者查詢的速度以及查詢最佳化工具處理查詢的效率。請考慮監視下列計數器：
o	SQL 編譯/秒   此計數器會指出每秒輸入編譯代碼路徑的次數。
o	SQL 重新編譯/秒   此計數器會指出陳述式每秒重新編譯的次數。
•	緩衝區管理員   此物件所提供的計數器可監視 SQL Server 使用記憶體來儲存資料頁面、內部資料結構與程序快取的情形，另外也有計數器可監視 SQL Server 讀取及寫入資料庫頁面時的實體 I/O。請考慮監視下列計數器：
o	緩衝區快取點擊比率
o	此計數器會顯示直接從緩衝區快取中取得而無須從磁碟讀取的頁面百分比。此比率的計算方式，是將快取點擊的總數除以快取查閱的總數 (以過去數千個頁面存取作為樣本)。由於從快取讀取的成本遠低於從磁碟讀取，因此您會希望此比率是偏高的。一般而言，只要增加 SQL Server 的可用記憶體，即可提高緩衝區快取點擊比率。
•	規劃快取   此物件所提供的計數器可監視 SQL Server 使用記憶體來儲存各種物件的情形，例如預存程序、未備妥與已備妥的 Transact-SQL 陳述式與觸發程序等。請考慮監視下列計數器：
o	快取點擊比率
o	此計數器會指出計劃的快取點擊與查閱之間的比率。
要監視的實體伺服器計數器
請監視下列計數器，以確定您執行 SQL Server 的電腦處於何種狀況：
•	處理器：處理器時間百分比：總計   此計數器會顯示處理器在閒置時間外執行應用程式或作業系統程序的時間百分比。在執行 SQL Server 的電腦上，此計數器應維持在 50% 到 75% 之間。若出現持續超載的情況，請調查是否有異常的處理活動，或伺服器是否需要更多 CPU。
•	系統：處理器佇列長度   此計數器會顯示處理器佇列中的執行緒數目。請監視此計數器，確定其值仍在核心 CPU 數目的兩倍以下。
•	記憶體：可用的 Mbytes   此計數器會顯示電腦上執行的程序所能使用的實體記憶體 (以 MB 為單位)。請監視此計數器，以確定您至少保留了可用實體 RAM 總計的 20%。
•	記憶體：頁面/秒   此計數器會顯示在磁碟上讀取或寫入頁面的速率，以解決硬分頁錯誤。請監視此計數器，確定其值保持在 100 以下。
如需詳細資訊與記憶體疑難排解方法，請參閱監視記憶體使用量 (適用於 SQL Server 2008 R2 SP1)、監視記憶體使用量 (適用於 SQL Server 2012) 與監視記憶體使用量 (適用於 SQL Server 2014)。
要監視的磁碟計數器
監視下列計數器可確認磁碟的狀況。請注意，下列值是以一段時間作為計算基準，而不是突發性尖峰期間內的值，也不是以單一測量為準的值。
•	實體磁碟：磁碟時間百分比：資料磁碟機   此計數器會顯示選取的磁碟機忙於回應讀取或寫入要求的經過時間百分比；此為常見的磁碟忙碌程度指標。若實體磁碟：磁碟時間百分比計數器偏高 (超過 90%)，請檢查實體磁碟：目前磁碟佇列長度計數器，以確認有多少個系統要求正在等候磁碟存取。等候中的 I/O 要求數應維持在組成實體磁碟之主軸數的 1.5 到 2 倍以下。
•	邏輯磁碟：磁碟傳輸/秒   此計數器會顯示在磁碟上執行讀取與寫入作業的速率。使用此計數器可適當監視成長趨勢與預測。
•	邏輯磁碟：磁碟讀取位元組/秒與邏輯磁碟：磁碟寫入位元組/秒   這些計數器會顯示在讀取或寫入作業期間從磁碟傳輸位元組的速率。
•	邏輯磁碟：平均磁碟位元組/讀取   此計數器會顯示在讀取作業期間從磁碟傳輸的平均位元組數。此值可反映磁碟延遲 — 較大的讀取作業可能會導致延遲略為增加。
•	邏輯磁碟：平均磁碟位元組/寫入   此計數器會顯示在寫入作業期間傳輸至磁碟的平均位元組數。此值可反映磁碟延遲 — 較大的寫入作業可能會導致延遲略為增加。
•	邏輯磁碟：目前磁碟佇列長度   此計數器會顯示在收集效能資料時磁碟上仍待處理的要求數目。此計數器的值愈低愈好。若每個磁碟的值大於 2，表示可能有瓶頸存在，應加以調查。這表示以 4 個磁碟組成的邏輯單元 (LUN) 可接受的最大值為 8。瓶頸可能會產生可延伸至目前存取磁碟之伺服器以外的積存，而導致使用者陷入長時間的等候。瓶頸的可行解決方案包括為 RAID 陣列新增更多磁碟、將現有磁碟更換為較快速的磁碟，以及將部分資料移至其他磁碟。
•	邏輯磁碟：平均磁碟佇列長度   此計數器會顯示在取樣間隔期間為選取的磁碟排入佇列的讀取與寫入要求的平均數目。其規則是，每個主軸的待處理讀取與寫入要求數不應超過兩個。但由於儲存區虛擬化與不同設定之間的 RAID 層級有所差異，此值可能不易測量。您可以檢查是否有磁碟佇列長度與磁碟延遲都超出平均值的情況存在。若兩者都超出平均值，表示儲存陣列快取可能使用過度，或是與其他應用程式共用的主軸可能影響到效能。
•	邏輯磁碟：平均磁碟秒數/讀取與邏輯磁碟：平均磁碟秒數/寫入   這些計數器會顯示對磁碟進行讀取或寫入作業的平均秒數。請監視這些計數器，確定其值維持在磁碟容量的 85% 以下。若讀取或寫入作業超過磁碟容量的 85%，磁碟存取時間將會遽增。若要確認您的硬體所需的容量，請參閱供應商文件，或使用 SQLIO 磁碟子系統基準工具加以計算。如需詳細資訊，請參閱 SQLIO 磁碟子系統基準工具。
o	邏輯磁碟：平均磁碟秒數/讀取   此計數器會顯示從磁碟執行讀取作業的平均秒數。在調整得當的系統上，記錄的理想值會介於 1 到 5 毫秒之間 (快取陣列上的理想值為 1 毫秒)，資料的值則介於 4 到 20 毫秒之間 (最好小於 10 毫秒)。尖峰期間可能會出現偏高的遲延。但若有規律地出現偏高值，您即應調查原因。
o	邏輯磁碟：平均磁碟秒數/寫入   此計數器會顯示對磁碟執行寫入作業的平均秒數。在調整得當的系統上，記錄的理想值會介於 1 到 5 毫秒之間 (快取陣列上的理想值為 1 毫秒)，資料的值則介於 4 到 20 毫秒之間 (最好小於 10 毫秒)。尖峰期間可能會出現偏高的遲延。但若有規律地出現偏高值，您即應調查原因。
當您將 RAID 設定用於邏輯磁碟：平均磁碟位元組/讀取或邏輯磁碟：平均磁碟位元組/寫入計數器時，請使用下表所列的公式推算磁碟上的輸入與輸出速率。
 
RAID 層級	公式
RAID 0	每一磁碟的 I/O = (讀取數 + 寫入數) / 磁碟數目
RAID 1	每一磁碟的 I/O = [讀取數 + (2 × 寫入數)] / 2
RAID 5	每一磁碟的 I/O = [讀取數 + (4 × 寫入數)] / 磁碟數目
RAID 10	每一磁碟的 I/O = [讀取數 + (2 × 寫入數)] / 磁碟數目
舉例來說，若您的 RAID 1 系統具有兩個實體磁碟，而您計數器的值如下表中所示。
 
計數器	值
平均磁碟秒數/讀取	80
邏輯磁碟：平均磁碟秒數/寫入	70
平均磁碟佇列長度	5
每一磁碟的 I/O 值可計算如下：(80 + (2 × 70))/2 = 110
磁碟佇列長度可計算如下：5/2 = 2.5
在此情況下，您的 Borderline I/O 發生瓶頸。
其他監視工具
您也可以使用 SQL Server 2008 中的 sys.dm_io_virtual_file_stats 動態管理檢視，來監視磁碟延遲及分析趨勢。如需詳細資訊，請參閱 sys.dm_io_virtual_file_stats (Transact-SQL) (適用於 SQL Server 2008 R2 SP1) 或 sys.dm_io_virtual_file_stats (Transact-SQL) (適用於 SQL Server 2012)。
SQL Server 2012 for SharePoint Server 2013
感謝 Microsoft 資深產品行銷經理 Bill Baer 與 MicroTechPoint 的 CEO 兼創辦人 Brian Alderman 提供一系列的線上 SQL Server 2012 訓練單元。同時要特別感謝 Channel 9 Microsoft 收錄了這些線上訓練單元。下列訓練單元將提供關於 SQL Server 2012 資料庫設定的詳細資料，以協助您了解如何改善 SharePoint Server 2013 效能、可用性與安全性。
•	調整 SQL Server 2012 for SharePoint 2013：(01) SQL Server 與 SharePoint Server 的重要整合
•	調整 SQL Server 2012 for SharePoint 2013：(02) SQL Server 資料庫設定的最佳作法
•	調整 SQL Server 2012 for SharePoint 2013: (03) SQL Server 的伺服器設定
•	調整 SQL Server 2012 for SharePoint 2013：(04) SQL Server 與 SharePoint 可用性
另請參閱
 
SharePoint 環境中的 SQL Server 概觀 (SharePoint 2013)
最佳化 SharePoint Server 2013 的效能
針對 SharePoint 伺服器陣列 SQL Server 的最佳作法
規劃 SharePoint 2013 的效能與容量管理
SharePoint Server 2013 的容量管理及調整大小
SharePoint Server 2013 的容量規劃
 
適用於 IT 專業人員的 SharePoint


TechNetProductsIT ResourcesDownloadsTrainingSupport
SharepointUnited States (English)  Sign in
 
Home 2013 2010 Other Versions Library Forums Gallery
Was this page helpful? Your feedback about this content is important. Let us know what you think.  Yes No
Export (0) Print Collapse All
 Expand
Storage and SQL Server capacity planning and configuration (SharePoint Server 2013)


 
Applies to: SharePoint Server 2013
Topic Last Modified: 2015-01-28
Summary: Learn how to plan and configure the storage and database tier for SQL Server in SharePoint 2013.
The capacity planning information that we provide contains guidelines to help you plan and configure the storage and SQL Server database tier in a SharePoint Server 2013 environment. This information is based on testing performed at Microsoft on live properties. However, your results may vary based on the equipment you use and the features and functionality that you implement for your sites.
    NoteNote:
Performance and capacity tests in this article use SQL Server 2008 R2 with Service Pack 1 (SP1) and SharePoint Server 2013. The test results are the same as in SharePoint Server 2010, except for the Search service test data. The test data for the Search service in SharePoint Server 2013 has changed and is shown in the appropriate sections in this article.
Although tests were not run on SQL Server 2012, you can use these test results as a guide to help you plan for and configure the storage and SQL Server database tier in a SharePoint Server 2013 environment. For training about how to configure and tune SQL Server 2012, see SQL Server 2012 and SharePoint Server 2013.
Because SharePoint Server often runs in environments in which databases are managed by separate SQL Server database administrators, this document is intended for joint use by SharePoint Server farm implementers and SQL Server database administrators. It assumes significant understanding of both SharePoint Server and SQL Server.
This article assumes that you are familiar with the concepts that are presented in Capacity management and sizing for SharePoint Server 2013.


(1)Design and configuration process for SharePoint 2013 storage and database tier

We recommend that you break the storage and database tier design process into the following steps. Each section provides detailed information about each design step, including storage requirements and best practices:
Gather storage and SQL Server space and I/O requirements
(3)Choose SQL Server version and edition
(4)Design storage architecture based on capacity and IO requirements
(5)Estimate memory requirements
(6)Understand network topology requirements
(7)Configure SQL Server
(8)Validate storage performance and reliability
(9)SQL Server 2012 for SharePoint Server 2013
(2)Gather storage and SQL Server space and I/O requirements

Several SharePoint Server 2013 architectural factors influence storage design. The key factors are: the amount of content, enabled features, deployed service applications, number of farms, and availability requirements.
Before you start to plan storage, you should understand the databases that SharePoint Server 2013 can use.
In this section:
Databases used by SharePoint 2013
Understand SQL Server and IOPS
Estimate core storage and IOPS needs
Determine service application storage and IOPS needs
Determine availability needs
Databases used by SharePoint 2013

The databases that are installed with SharePoint 2013 depend on the features that are being used in the environment. All SharePoint 2013 environments rely on the SQL Server system databases. This section provides a summary of the databases installed with SharePoint 2013. For detailed database information, see Database types and descriptions (SharePoint 2013) and Databases that support SharePoint 2013.
NoteNote:
Some SharePoint 2013, SQL Server Database Engine, and SQL Server Reporting Services (SSRS) databases have specific location recommendations or requirements. For information about these database locations, see Database types and descriptions (SharePoint 2013).
 
Product version and edition	Databases
SharePoint Foundation 2013
Configuration
Central Administration content
Content (one or more)
App Management Service
Business Data Connectivity
Search service application:
Search administration
Analytics Reporting (one or more)
Crawl (one or more)
Link (one or more)
Secure Store Service
Subscription Settings Service Application (if it is enabled through Windows PowerShell)
Usage and Health Data Collection Service
Word Conversion Service
SharePoint Server 2013
Machine Translation Services
Managed Metadata Service
PerformancePoint Services
PowerPivot Service (Power Pivot for SharePoint 2013)
Project Server Service
State Service
User Profile Service application:
Profile
Synchronization
Social tagging
Word Automation services
If you are integrating further with SQL Server, your environment may also include additional databases, as in the following scenarios:
SQL Server 2012 Power Pivot for SharePoint 2013 can be used in a SharePoint Server 2013 environment that includes SQL Server 2008 R2 Enterprise Edition and SQL Server Analysis Services. If in use, you must also plan to support the Power Pivot application database, and the additional load on the system. For more information, see Plan a PowerPivot deployment in a SharePoint farm and the SQL Server PRO article Understanding PowerPivot and Power View in Microsoft Excel 2013.
The SQL Server 2008 R2 Reporting Services (SSRS) plug-in can be used with any SharePoint 2013 environment. If you are using the plug-in, plan to support the two SQL Server 2008 R2 Reporting Services databases and the additional load that is required for SQL Server 2008 R2 Reporting Services.
Understand SQL Server and IOPS

Estimate core storage and IOPS needs

Estimate service application storage needs and IOPS

Determine availability needs

Choose SQL Server version and edition

Design storage architecture based on capacity and I/O requirements

Estimate memory requirements

Understand network topology requirements

Configure SQL Server

Validate and monitor storage and SQL Server performance

SQL Server 2012 for SharePoint Server 2013

See also

 
Overview of SQL Server in a SharePoint environment (SharePoint 2013)
Optimize performance for SharePoint Server 2013
Best practices for SQL Server in a SharePoint Server farm
Plan for performance and capacity management in SharePoint Server 2013
Capacity management and sizing for SharePoint Server 2013
Capacity planning for SharePoint Server 2013
 
SharePoint for IT pros

