<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA01_General.ps1


about  syntax. package , dev tool 


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\AA01_General.ps1

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
#   66    command . shortcut #   74    宣告 / Type#   84    math
#   97    String
#   111   array 陣列
#   106   flow control  switch  break;  if  for
#   122   vibrator 震動  開放手機資源權限 permission   shen04.12  
#   113   getSystemService
#   137   顯示溫度符號  
#   156   自專案資源載入字串  getResources().getString(R.string.charC));  shen05
#   266  ArrayAdapter  shen6-3  {<#function trimspace ($ss){
#$ss='圖 檔 路 徑 Uri'
$i=$ss.Length
$s=''
for ($i = 0; $i -lt $ss.Length; $i++)
{ 
   
    if ($ss[$i] -ne ' ')
    {
        $s=$s+$ss[$i]

    }
}
 $s
}#>}#--------------------------------------------------------------------------------#   49  ebook index
#--------------------------------------------------------------------------------'D:\MyDataII'App200   Android超實用App輕鬆開發200例    楚無咎 胡嘉璽  上奇資訊  2015-02-01'
    第1章 Android簡介
        android的生--android的特點--android開發環境的架設--Android應用程式的偵錯--Android應用程式的專案結構--Android的系統架構

    第2章 Android簡單控制項的開發及應用
        按鈕的使用技巧--最常用的線性版面配置--相對性版面配置的方法,--頁框版面配置結構的學習.--結構緊湊的表格版面配置--用絕對座標版面配置
        --文字顯示的技巧…--文字色的設定…--使你的文字顯得更獨特…--簡單的本機驗證.--性別的選擇…--選擇喜歡的玩家.--確認傳送--個人愛好選擇
        --燈泡開關--最親和的提示--有背景圖片的按鈕--圖片按鈕的點擊轉換--音樂播放的進度提示--音量大小的調節.--為你喜歡的作品評分--自訂繪製畫布
        --自訂繪製字串.--自訂繪製幾何圖形--圖片繪製的控制技巧

    第3章 Android高級控制項的開發及應用
        --點擊檢視名人資訊--動態圖片排版.--選擇喜歡的體育運動--在選單中增加選項--點擊改變圖片透明度--動態改變片大小--旋轉圖片的技巧.
        --製作自己的相片集--重要訊息提醒--後台程式安装進度提示--單選按鈕實現選擇個入特長--用核取按鈕實現選擇歡的城市--點擊"確定"按鈕出現對話方塊
        --檢視時間日期的應用,--時鐘指針設計的應用.--動態清單設定選項--在安卓中瀏覽網頁--切換清單顯示

    第4章 手機使用者介面
        --取得手機螢幕的解析度--實現按鈕的介面回應--給控制項做背景實的技巧--定時改變提示訊息.--手機桌面心情.--應用選項選單的綜合技巧…
        --右鍵選單的應用--手機背景顏色的設定--字型色的轉換.--實現手機介面的置換.--活用Intent啟動新介面--介面間的資料送技巧--實現資料的傳回接收
        --設定自己的手機顯示模式--更改手螢幕顯示方向

    第5章 手機通信服務及手機控制
        --自動呼叫系統的撥號,上網和發送E-mail的功能.--電話撥號軟體.--自製電話撥號系統--手機發送簡訊.--簡易電子郵件--自製手機通訊錄搜索
        --一鍵查詢連絡人資料--有圖示的愛好選擇糸統--介面切換時的震動提醒--帶圖片的小提醒--音樂播放在狀態列上圖示提--自製開啟或關閉Wi-Fi.
        --還原手機桌面背景--設定手機桌面背景--輕鬆取得手桌面背景--輕鬆檢視手機的相關資訊.--檢視SIM卡的詳細資訊--按鍵移動圖片-方向鍵的應用
        --檢視正在執行的程式--手機螢幕更改時資訊的捕捉和提醒

    第6章 手機的自動服務功能
        --自動服務的主要功能.--系統服務的開姶與停止--提醒使用者收到簡訊.--檢視寺機電池剩餘電量.--接收到簡訊時介面切換顯示--簡訊訊息
        --透過後台定時發送提示--簡訊群發功能的實現--開機程式自啟動--手機狀態提醒.--有來電秲,發送簡訊回覆,--手機儲存卡容量的查詢
        --備忘錄的定時提醒--設定手機靜音和固定號瑪來電手機震動--根據手機姿態改變手機模式--定時更改手機模式,

    第7章 手機檔I/O與資料庫的應用
        --手機SD卡文字閱讀器--修改手機中的檔案--刪除手機中的檔案--存取APK套件中的檔案.--簡單的學生資訊管理--檢視手機裡面的相片
        --對資料康的簡單操作--記錄存取程式的時間

    第8章 手機網路應用
        --網路連接檢測軟體--製作簡單網頁覽器,--自訂網頁瀏覽器--網路圖片瀏覽軟體,--網路圖片相簿集.--手機檢視即衛星雲圖.
        --Google天氣用戶端--旅遊城巿的介紹.--網路音樂播放.--網路歌曲下載軟體.--下載網路歌曲製作手鈴聲--下載網路片製作手機背景.
        --製作RSS閱讀器,--遠端下載與安裝Android程式--手機下載3gp影片--常用網站登入介面製作

    第9章 手機的Google服務功能
        --手機用戶端Google帳號登入--使手機進行Google搜索--製作成績柱狀圖--霣現Google地圖.--Google地圖地點查詢功能.--隨身小詞典…


    第10章 手機多媒體服務功能
        --取得圖片的長寬,--繪製簡單圖形.--實現平面貼圖.--簡單淡淡出效果--虛擬鍵的設計與實現--取得手機內建媒體圖片--手機音量大小的調節
        --擷取咅訊資料.--擷取圖像資料.--取視訊資料…--視訊播放機…--自訂動畫效果--小球遊戲--音樂播放機

    第11章 Android手機的3D世界
        --三角形的繪製--立方體的繪製.--球體的繪製.--豐富多彩的光源世界--製作簡易小木箱--朦朧世界的霧景特效--透過玻璃風景.--3D相簿的製作,
       
    第12章 手機特效開發
        --虛線效的開發.--螢幕換頁勳畫特效.--控制項的抖動特效--多點觸控.--感測器探測者--小球遊戲動態壁紙--自動完成輸入框“--對你的圖片進行簡單編輯,
        --左右拖拉你的介面--靈活的面小工具--JDBC用戶端的開發--新浪微博用戶端的開發

    第13章 休閒遊戲——Q版瘋狂大炮
        --遊戲背景及功能介紹.--遊戲實際預覽效果--遊戲策劃及準備工作--遊戲的架構.--遊戲的主別程式框架--主類別中部分成員變數及方法的實現
        --按鍵回應執行緒類別的霣現--遊戲常數類別的設計與實現·--歡迎動畫介面的設計與實現--主選單介面的設計與實現.--積分榜介面的程式框架.
        --積分榜介面中部分方法的實現--遊戲介面示類別的程式框架--遊戲介面顯示類別中部分方法的實現--目標路徑類別的實現·--產生目標執行緒類別的實現
        --英雄大炮類別的程式框架--英雄大炮類別成員方法的實現--炮彈的實現…--目標的實現..--爆炸效果的實現“--飛行器及其子類別的實現.
        --飛行物的實現,--力道值的實現,--計時器的見--得分榜的實現.--捲頁背景的實現·--主選單按鈕的實現--取得系統日期的方法.--遊戲的最佳化與改進

    第14章 娛樂遊戲——3D迷宮        --遊戲背景及功能介紹--游戲實際預覽效果,--游戲策劃及準備工作,--遊戲的架構“--遊戲主類別的設計與實現·--遊戲常數類別的設計與實現
        --遊戲主選單類別的設計與實現--遊戲介面的設計與實現--遊戲介面中主要煬景的繪製--遊戲中的邏輯實現與執行緒操控--遊戲圖設計器的介面效果與使用方法
        --遊戲地圖設計器的開發實現--遊戲的最佳化與改進'QT    高手都用Qt進行Android專案  安曉輝  佳魁資訊'
    Chapter 01   Qt 概覽
1.1 什麼是Qt 
1.2 我們能用Qt 做什麼 
1.3 誰在使用Qt
1.4 什麼是Qt on Android 
1.5 Qt on Android 的前世今生

Chapter 02  Qt 開發環境快速上手
2.1 Qt Creator 簡介
2.2 Qt Creator 下載與安裝
2.2.1 下載 
2.2.2 安裝
2.3 建立第一個專案：Hello World
2.4 Qt Creator 整合式開發環境介紹 
2.4.1 歡迎介面
2.4.2 編輯介面
2.4.3 除錯介面
2.4.4 專案選項設定
2.4.5 選單簡介
2.4.6 Qt Creator 的選項設定
2.4.7 專案範本介紹
2.5 Qt 開發工具介紹 
2.5.1 Assistant
2.5.2 Designer
2.5.3 Linguist
2.5.4 命令列環境

Chapter 03  Qt on Android 快速上手
3.1 開發環境架設
3.1.1 JDK 安裝 
3.1.2 環境變數設定
3.1.3 Android SDK 安裝
3.1.4 Android NDK 安裝
3.1.5 Apache Ant 安裝
3.1.6 Qt Creator 的Android 環境設定
3.1.7 AVD 建立
3.1.8 連接你的手機
3.2 Hello Qt on Android
3.2.1 建立專案
3.2.2 專案選項
3.2.3 建立金鑰檔案和憑證
3.2.4 建立AndroidManifest.xml
3.2.5 增加程式
3.2.6 執行程式
3.3 Qt 函數庫的部署策略
3.3.1 Use Ministro service to install Qt
3.3.2 Bundle Qt libs in APK
3.3.3 Deploy local Qt libraries to temporary directory
3.4 記錄檔
3.4.1 為什麼要有記錄檔
3.4.2 在Qt 中如何使用記錄檔
3.4.3 如何把記錄檔輸出到Android 記錄檔系統中  

Chapter 04  Qt 專案檔案介紹
4.1 pro 檔案介紹
4.1.1 註釋 
4.1.2 元件選擇
4.1.3 目的檔案名稱
4.1.4 範本
4.1.5 指定原始檔案
4.1.6 指定標頭檔
4.1.7 設定標頭檔路徑
4.1.8 指定函數庫與函數庫檔案路徑
4.1.9 定義巨集
4.1.10 設定資訊
4.1.11 程式區塊與條件測試 
4.1.12 變數
4.2 pro.user 檔案
4.3 pri 檔案
4.4 Makefile 

Chapter 05  Qt 入門
5.1 Hello World 再分析
5.2 QuitApp：帶互動的小程式
5.3 初識訊號與槽
5.4 建置複雜介面
5.4.1 蓋洛普Q12 測評程式
5.4.2 建立自己的槽
5.4.3 版面配置管理員介紹
5.4.4 控制項回顧
5.5 追隨Qt 的程式風格

Chapter 06  元物件系統
6.1 牡丹花範例
6.2 再論編譯過程
6.3 Q_OBJECT 巨集
6.4 QMetaObject
6.5 關鍵字signals、slots、emit、SIGNALS、SLOTS 
6.5.1 signals
6.5.2 emit
6.5.3 slots
6.5.4 SIGNALS
6.5.5 SLOTS
6.6 moc 的魔法
6.6.1 moc_peony.cpp 的原始程式
6.6.2 moc 的工作清單
6.6.3 訊號的真容
6.6.4 訊號與槽 
6.7 深入了解訊號與槽
6.7.1 訊號與槽原理
6.7.2 如何使用訊號與槽
6.7.3 訊號與槽的連接類型
6.7.4 訊號與槽經驗談
6.7.5 跨執行緒使用訊號與槽
6.8 屬性系統
6.8.1 靜態屬性
6.8.2 動態（執行時期）屬性
6.9 事件和事件篩檢程式
6.9.1 重新定義event()
6.9.2 重新定義特定事件處理器 
6.9.3 事件篩檢程式
6.9.4 自訂事件
6.10 計時器事件
6.10.1 使用QTimer
6.10.2 使用QObject::startTimer
6.11 物件樹與生命週期
6.12 智慧指標
6.12.1 QPointer 
6.12.2 QSharedPointer
6.12.3 QWeakPointer
6.12.4 QScopedPointer
6.12.5 QObjectCleanupHandler
6.13 動態類型轉換
6.14 國際化
6.14.1 字串國際化方法
6.14.2 建立譯本
6.14.3 載入譯文檔案
6.14.4 執行時期改變語言

Chapter 07   Qt 範本函數庫介紹
7.1 使用QString
7.1.1 初始化一個字串
7.1.2 操作字串資料
7.1.3 字串查詢
7.1.4 編碼轉換 
7.1.5 格式化輸出
7.2 容器類別
7.2.1 QList 範例
7.2.2 QMap 範例

Chapter 08   Qt GUI 程式設計
8.1 智慧型手機GUI 特點
8.2 內建視窗控制項介紹
8.2.1 QRadioButton 
8.2.2 QCheckBox
8.2.3 QGroupBox
8.2.4 QLineEdit
8.2.5 QTextEdit
8.2.6 QTabWidget 
8.2.7 QListWidget
8.2.8 Qt 資源檔系統
8.2.9 QTableWidget9
8.3 自訂視窗套件
8.3.1 使用QPainter 繪圖
8.3.2 為Android 實現的ImageButton
8.3.3 文字漸層標籤

Chapter 09   多執行緒
9.1 上路，執行緒
9.2 執行緒自己的事件循環
9.3 執行緒間通訊
9.3.1 跨執行緒的訊號與槽
9.3.2 跨執行緒的事件
9.3.3 門鈴範例程式
9.4 執行緒同步
9.5 使用QThread 的注意事項
9.6 QThreadPool
9.7 高階多執行緒API：QtConcurrent

Chapter 10  網路程式設計
10.1 QNetworkAccessManager
10.1.1 http 程式設計 
10.1.2 ftp 程式設計
10.2 QTcpSocket/QTcpServer 
10.2.1 伺服器
10.2.2 用戶端
10.3 QUdpSocket 
10.3.1 伺服器
10.3.2 用戶端 

Chapter 11   檔案IO
11.1 QFile
11.2 QTextStream
11.3 QDataStream

Chapter 12   XML
12.1 XML 讀取與解析
12.1.1 DOM
12.1.2 SAX
12.1.3 StAX
12.2 XML 檔案產生與儲存
12.2.1 QXmlStreamWriter
12.2.2 QDomNode::save()
12.2.3 QTextStream 和QFile 的方式 

Chapter 13  Qt on Android 揭秘
13.1 APK 是怎樣煉成的 
13.1.1 當你「執行」時⋯⋯
13.1.2 Android 專案目錄結構
13.1.3 string.xml 介紹
13.1.4 AndroidManifest.xml 介紹
13.1.5 libs.xml 介紹
13.1.6 Androiddeployqt.exe 都做了什麼
13.2 Java 與Qt 的結合過程
13.2.1 應用入口
13.2.2 通訊代理
13.2.3 QPA 外掛程式
13.3 Qt 應用的狀態

Chapter14   Android 行動開發主題
14.1 按鍵處理
14.1.1 重新定義keyPressEvent/keyReleaseEvent
14.1.2 給子控制項安裝事件篩檢程式 
14.1.3 應用等級的事件篩檢程式
14.2 觸控與手勢 
14.2.1 觸控
14.2.2 手勢
14.3 感測器與手勢 
14.3.1 常見感測器介紹
14.3.2 Qt 感測器手勢類別庫介紹
14.3.3 搖動手勢
14.3.4 覆蓋手勢
14.3.5 自由落體
14.3.6 繞排手勢
14.3.7 翻轉手勢
14.3.8 扇動手勢
14.3.9 感測器手勢的使用
14.4 拍照
14.4.1 QCamera 和它的夥伴
14.4.2 QCameraViewFinder
14.4.3 QCameraImageCapture
14.4.4 使用相機拍照 
14.4.5 在QML 應用中使用相機
14.5 錄音與重播
14.5.1 錄音類別庫 
14.5.2 播放類別庫
14.5.3 錄音與重播小範例

Chapter15   使用JNI 擴充你的應用
15.1 使用JNI Environment 
15.2 呼叫Java 程式
15.2.1 Java 方法簽章
15.2.2 呼叫Java 方法
15.2.3 extendsQtWithJava 實例
15.2.4 QtAndroid 命名空間
15.2.5 使用手機外部儲存
15.3 Java 呼叫C++

Chapter16   實作部分
16.1 筆記qnotepad
16.1.1 首頁設計與實現 
16.1.2 筆記物件
16.1.3 筆記瀏覽與編輯
16.2 圖片瀏覽器
16.2.1 檔案選擇控制項
16.2.2 圖片載入器
16.2.3 圖片顯示
16.3 IP 位址查詢 
16.3.1 Json 資料格式簡介
16.3.2 Qt 中的Json 類別庫 
16.3.3 程式詳解
16.4 音樂播放機
16.4.1 Qt 樣式表
16.4.2 多媒體類別庫介紹
16.4.3 音樂播放機詳解
16.5 天氣預報
16.5.1 GPS 定位
16.5.2 天氣查詢與顯示
16.6 拍照與後期處理
16.6.1 相機實作
16.6.2 影像處理演算法
16.6.3 圖片載入與顯示
16.6.4 組織 
Appendix A 常見問題'Tang  Android高效入門>>深度學習：使用Android Studio 2開發Android 6.0 APP    湯秉翰  2016-06-15  博碩 '
    Chapter 0　範例程式碼的使用
        0-1 Git版本控制系統
        0-2 GitHub網站
        0-3 GitHub範例專案
        0-4 書附範例專案
        0-5 協助與額外資訊

    Chapter 1　Android系統與應用程式介紹
        1-1 Android版本演進
        1-2 Android系統架構
        1-3 應用程式基礎
        1-4 應用程式元件
        1-5 應用程式宣告檔－AndroidManifest.xml
        1-6 Android Studio開發環境
        1-7 Java基礎知識

    Chapter 2　環境建置與第一個專案
        2-1 基礎環境－JDK與Android SDK
        2-2 整合開發工具－Android Studio
        2-3 無下載環境的快速安裝
        2-4 建立應用程式專案
        2-5 Android SDK工具與模擬器  sDK manager, AVD manager
        2-6 執行應用程式專案

    Chapter 3　Android專案架構與Activity
        3-1 AndroidManifest.xml載運清單  package屬性, application 屬性, activity 屬性
        3-2 畫面配置－Layout   XML 檔的原貌
        3-3 Java類別  Activiy 子類別  onCreate Method
        3-4 資源   R 類別 , layout, memu, values
        3-5 Android Support Library－支援函式庫  ,V4, v7 專案中導入函式庫

    Chapter 4　Activity設計
        4-1 版面配置Layout  RelativeLayout, LinearLayout, high ,width,, margin, align, weight
        4-2 Bmi專案功能設計  更換版面配置 . 新增元件
        4-3 在MainActivity中取得畫面元件  區域變數提昇為屬性  , 抽取程式碼成為方法
        4-4 按鈕的事件處理   onClick 
        4-5 使用浮動顯示－Toast類別
        4-6 使用對話框－AlertDialog類別   AlertDialog.Builder , 對話框按鈕
        4-7 多國語言     建立版面字串資源 , 建立語系資源檔正體中文, 設定模擬器 語系
        4-8 按鈕事件處理－匿名類別   取得按鈕事件  , 為按鈕事件註冊Listener , listener 實作程式碼

    Chapter 5　第二個Activity
        5-1 產生第二個Activity（方法、產生的檔案） 更換合適名稱, 一個Activity 的組成. 
        5-2 使用Intent轉換Activity
        5-3 使用Intent傳遞資料   簡單資料, 顥示,  Bundle 
        5-4 抽取字串成為資源     手動加入, 程式中使用字串資源, 使用A.S. 抽離字串資源
        5-5 Activity的生命週期  一般, 暫停, 切換  覆寄Callback ,  測試
        5-6 Atm專案之登入功能    MainActivity , LoginActivity, onClick , 登入判斷
        5-7 轉換Activity取得結果   定義功能常數, 呼叫 startActivityResult , 設定返回值, 

    Chapter 6　Material Design實感設計
        6-1 具浮動按鈕的Activity    產生Activity , Layout, 
        6-2 SnackBar提示訊息元件    設定Action 

    Chapter 7　存取設定資料
        7-1 偏好設定SharedPreferences   寫入, 讀取, 手機內部儈存方式. 
        7-2 使用ADB登入模擬器    ADB執行檔, 叔定系統變數, adb登入 模擬器
        7-3 實務練習－記住登入帳號   
        7-4 選單Menu  , 選單的事件處理

    Chapter 8　清單元件
        8-1   Adapter 
        8-2 清單－ListView
        8-3 下拉選單－Spinner  準備字串陣列, 加入, 使用 ArrayAdapter , 選擇項目事件處理, 取得選擇項目
        8-4 格狀清單－GridView
        8-5 客製化功能表－GridView  準備資料, BaseAdapter , IconAdapter  項目事件處理

    Chapter 9　SQLite資料庫
        9-1 準備活動     
        9-2 SQLiteOpenHelper類別   SQLiteDatabase, onCreate, onUpgrade
        9-3 新增資料   insert.nullColumnHack
        9-4 驗證與除錯
        9-5 查詢資料  Cursor , rawQuery , query 
        9-6 實務範例  SimpleCursorAdapter   , singletone

    Chapter 10　內容供應者與權限機制
        10-1 存取內容供應者   Contact class , ContentResolver, Content URI, 
        10-2 Permission權限  一般, 危險 執行中要求, 向使用者要求, 當使用者允許拒絕
        10-3 查詢聯絡人  Cursor  
        10-4 更新聯絡人

    Chapter 11　圖檔處理與手勢
        11-1 存取手機相片     
        11-2 以GridView展示縮圖
        11-3 點擊後顯示圖檔   DetialActivity
        11-4 手勢滑動更換圖檔  GestureDetector.onGestureListener   onTouchEvent method , onFling method 

    Chapter 12　Fragment
        12-1 Fragment的生命週期
        12-2 使用Fragment的Activity
        12-3 實作Fragment生命週期方法
        12-4 Fragment實作
        12-5 同一位置使用不同種類的Fragment   swapActivity 

    Chapter 13　網路程式與AsyncTask
        13-1 輸出入套件   byte to Char
        13-2 Java網路套件   Socket Class
        13-3 HTTP協定   URLConnection Class, GET, POST 
        13-4 UI執行緒與耗時工作
        13-5 耗時工作處理－AsyncTask類別   UI thread method
        13-6 Async練習專案     
        13-7 Atm專案登入範例  doInBackground  , login

    Chapter 14　解析JSON與使用第三方類別庫
        14-1 Gradle設定檔
        14-2 讀取JSON資料
        14-3 解析JSON陣列
        14-4 使用RecyclerView展示清單資料

    Chapter 15　Firebase註冊與驗證
        15-1 使用Firebase
        15-2 Android端設計
        15-3 啟動Email與密碼驗證
        15-4 Email註冊功能
        15-5 將資料儲存在Firebase上

    Chapter 16　Intent與Broadcast
        16-1 Intent意圖
        16-2 Intent的組成要件
        16-3 Broadcast廣播

    Chapter 17　通知Notification
        17-1 什麼是Notification
        17-2 附加動作在通知中

    Chapter 18　Service
        18-1 什麼是Service
        18-2 獨立運作Service
        18-3 IntentService
        18-4 綁定型Service

    Chapter 19　Google Maps地圖應用
        19-1 Google Maps應用的開發要件
        19-2 模擬器準備
        19-4 使用MyLocation功能
        19-5 標記－Marker

    Chapter 20　上架佈署應用程式
        20-1 應用程式的憑證
        20-2 Google Play上架流程
    'VBwithandroid'
    第1章 Android簡介
    第2章 Android簡單控制項的開發及應用
    第3章 Android高級控制項的開發及應用
    第4章 手機使用者介面
    第5章 手機通信服務及手機控制
    第6章 手機的自動服務功能
    第7章 手機檔I/O與資料庫的應用
    第8章 手機網路應用
    第9章 手機的Google服務功能
    第10章 手機多媒體服務功能
    第11章 Android手機的3D世界
    第12章 手機特效開發
    第13章 休閒遊戲——Q版瘋狂大炮
    第14章 娛樂遊戲——3D迷宮'施威銘   Android App 程式設計教本之無痛起步   2015/07/03  旗標 '    第1章使用AndroidStudio開發AndroidApp
        1-1 建立第一個AndroidApp專案,套件名稱的命名規,如何選擇MininumSDK.
        1-2 在電腦的模擬器上執行App;建立Android模擬器;認識的密度(Density).;在模擬器上執行AndroidApp;調整模擬器的語言時區、及移除app;在AndroidStudio中撿視模擬與App的執行狀況        1-3 AndroidStudio快速上手;認識AndroidStudio的操作環境;開啟最近使用的專案;專案搬移複製與刪除;開啟搬移複製後或『外來』的專案
        1-4 Android專案的構成;Android資源的『多版本』特色;在Project模式中檢視專案的實際儲存結構    第2章Android程式嗀計基礎講座
        2-1 AndroidApp的主角,Activity;Activity;實際的狀況是這樣·
        2-2 Android程式的設計流程  ; 視覺設計+程式邏輯;用圖形化介面來做視覺設計;用Java來寫程式邏輯;最後把視覺設計與程式碼組建(Build)起來
        2-3 認識Activity的基本程式邏輯;初MainActivity框架;oncreate():MainActiv1ty第一件要做的事;資源的ID
        2-4 元件的佈局與屬性設定;id屬性;findViewByld()方法;常見屬性類型
        2-5 開始動手寫程式;按一下按就放大顯示的文字;設定元件屬性的技巧;快速排除警告(或錯誤);快速選取現有的資源,或立即新增資源來使用  ;Android的尺寸單位;自動匯入程式中需要的套類別
        2-6 輸入欄位EditText元件;getText();取得使用者輪入的文字;setText():設定TextView示的文字;加人EditText元件
        2-7 使用USB線將程式部署到手機上執行;開啟手機偵錯功能;透過USB將AndroidApp傳送到手機安裝與執行;執行己安裝的程式·
        2-8 修改專案的套件名稱和應用程式    第3章AndroidApp介面設計
        3-1 View與ViewGroup(Layout):元件與佈局;View視覺元件;View元件屬性與設定;再談id屬性--Layout:畫面佈局
        3-2 使用LinearLayout建立畫面佈局--LinearLayout:依排列元件--在佈局中使用LinearLayout--使用LinearLayout(Horizontal)建立表單--imputType屬性;設定輸入欄位種類--加入人電話專用的EditText
        3-3 使用weight屬性控制元件的寬/髙--利用weight屬性對齊元件
        3-4 透過屬性美化外觀--元件的邊界:margins與paddings--設定邊界讓入表單版面寬鬆--顏色:RGB指定文字或背景顏色--設定文字及背景顏色
        3-5 以程式設定元件的外觀屬性--setTexTColor():改文字顏色--變色龍·以亂數設定色屬性
        3-6 使用Gmail將程式寄紿朋友測試--設定可以安裝GooglePlay商店下載的程式--將程式寄給朋友安裝    第4章與使用者互動-事件處理
        4-1 事件處理的機制--來源物件與監聽物件--Java的介面(interface)
        4-2 按一下事件的處理--每按一下按就讓計數器加1
        4-3 監聽長按事件--onLongClick():處理長按事件--長按按鈕數值歸零
        4-4 處理不同來源物件的相同事件--getld();判斷事件的來源物件--長按按鈕加2,長按計數值可歸零
        4-5 監聽控事件讓手機震動--onTouch();觸控事件的處理--如何讓手機震動--監聽TextView的觸控事件--在程式中登記震動的使用權限

    第5章使用者介面的基本元件
        5-1 多選一的單選鈕(RadioButton)--RadioButton與RadioGroup元件--getCheckedRadioButtonld():讀取單選鈕狀態--謮取RadioGroup的選取項目--onCheckedChanged():選項改事件--利用RadioButton選擇溫度轉換單位
        5-2 可複選的核取方塊(CheckBox)--isChecked():撿查昰否選取--以核取方塊建立點餐選單onCheckedChanged();選取~取消核取方塊的事件--利用選取事件即時修改訂單        5-3 顯示圖形的ImageView.--用Android系統內建的圖形資源--顯示系統內建圖形--使用非Android內(自行提供)的圖形資源--替選單加上圖片--圖形的放控制
    第6章進階UI元件:SpinnerListView
        6-1 Spinner選單元件--Spinner元伴的屬性設定.--getSelectedltemPosition()讀取Spinner元件的取項目--使用Spinner設計購票程式--onltemSelected():Spinner元件的選擇事件--運動能消耗計算機
        6-2 ListView清單方塊--onltemClick():ListView的按一下事件--用ListView建立選單
        6-3 在程式中變更spinner的顯示項目--ArrayAdapter:Spinner與資料橋樑--ArrayAdapter():建立ArrayAdapter物件--setDropDownViewResource():設定選項目的顯示樣式--setAdapter():將ArrayAdapter與Spinner綁在一起
    第7章即時訊息與交談窗
        7-1 使用Toast顯示即時訊息--Toast類別--腦筋急轉彎Toast顯示答案 --Toast訊息的取消顯示更新顯示--即跱顯示案的腦筋急彎
        7-2使用Alert交談窗--AlertDialog類別--AlertDialog.Builder:設定與建立Alert交談窗--setcancelable():設定可按返回關閉交談窗,--show():建立並顯示交談窗--建立Alert交談窗的簡潔寫法--顯示歡迎訊息的交談窗--在交談窗中加入按鈕--Android問卷調查
        7-3使用日期、時間交談窗DatePickerDialogTimePickerDialog類別--onDateSet()與onTimeSet():得選取的日期與時間--日期時間器選擇器
    第8章用Intent啟動程式中的其他Activity
        8-1在程式中新增Activity--在專案中新增Activity--
        8-2用Intent動程式中的Activity--startActivity():用明示Intent啟動Activity--finsh():結束-
        8-3在Intent中夾帶資料傳給新Activity--putExtra()附加資到Intent中--getlntent()與getXxxExtra()•從Intent中取出資料--在啟勳新Activity傳送資料
        8-4要求新Activity傳回資料--新Activity結束時將資料傳回.    第9章用Intent啟動手機內的各種程式
        9-1使用Intent啟動程式的方式--set,Action()及setData():加入動作資料到Intent中-Uri-intent的資料
        9-2使用Intent啟動電子郵件,簡訊、瀏覽器,地圖與Web搜尋-電子件地址-簡訊--網址--經緯度座標值--Web搜尋資料--從啟動程式傳回資料
    第10章拍照與顯示相片
        10-1 使用Intent啟動系統的相機程式--利用Bundle取出intent中附帶的Bitmap物件--利用系統相機程式來拍照
        10-2 要求相機程式存檔--準備代表圖檔路徑的Uri--用BitmapFactory類別讀取檔--要求相機程式存檔並在程式中顯示出來
        10-3 解決相片過大問題--用BitmapFactory.Options設定入檔的選項--依顯示尺寸來載入縮小的圖檔        10-4旋轉手機與旋轉相片--關閉自動旋轉功能並設定螢冪為直向顯示--用Matrix件來旋轉圖片--相片是直拍或橫拍而自動旋轉相片
        10-5使用Intent瀏覽並選取相片-將相片改為可供系統共用的檔案-利用Intent瀏覽並選取巳拍好的相片
    第11章播放音樂與影片
        11-1使用Intent來選音樂或影片--讀取預存在程式中的多媒體檔案--讓使用者挑選影音檔
        11-2用MediaPIayer播放音樂--MediaPlayer的咅樂播放流程--MediaPlayer可引發的3個重要事件--處理在放音樂時切換到其他程式的狀況--讓螢幕不進入休眠狀態--用MediaPlayer播放音樂
        11-3用VideoView播放影片--使用VideoView搭配Mediacontroller來播放影片--用程式控制VideoView的影片播放--設定全幕顯示--處理在播放影片切換到首其他程式的狀況--處理在播放時旋轉手機的狀況--晦開啟新的Activity來播放影片
    第12章用感測器製作水平儀與體感控制
        12-1讀取加速感測器的值 --認識加速感測器--取得系統的感測器物件--讀取感測器的值--顯示加速感測器的加速度值
        12-2利用xy軸的加速度值來製作水平儀--利用左邊界與上邊界來移動圖片--利用加速感測製作水平儀
        12-3利用加速感測器來做體感控制--偵測手機面朝下平放的狀態-偵測手機搖動--利用加速測器來控制音樂播放
    
    第13章WebView與SharedPreferences
        13-1使用WebView顯示網頁--顯示網站
        13-2改進WebView功能-用Websettings啟用網頁縮放及JavaScript--使用WebViewClient處理開放超連結動作--使用WebChromeClient建立網頁載入進度介面--使用ProgressBar顯示進度條--使用onBackPressed()實作回上一頁功能--改善WebView行為
        13-3 使用Preferences(偏好設定)記錄資訊--使用SharedPreferences物件儲存資料--讀取偏好設定資料--儲存/回存資料的機:onPause()/onResume()--flickr相片快搜
    第14章GPS定位、地圖、功能表
        14-1取得手機定位資料--LocationManager:系統的定位管理員--定位提供者--用getBestProvider()方法取得定位提供者名稱--用requestLocationUpdates()註冊位置更新事件的監聽器--實作LocationListener介面--用removeUpdate()方法取消註冊監聽器--取得所在位度經緯度
        14-2定位資訊與地址查詢--用Geocoder類別做地址查詢-Address地址物件--地址專家-用經緯度查詢地址
        14-3在程式中顯示GoogleMap--使用GoogleMap的前置準備--如何使用GoogleMap--在GoogleMap中示目前所在位置
        14-4幫Activity加上功能表--Activity預設的功能表--設定功能表的內容--撰寫功能表所需的2個方法--為程式加上功能
    第15章SQLite資料庫
        15-1認識SQLite資料--資料庫、資料表、資料欄位,--使用CREATETABLE述建立資料表--使用openOrCreateDatabase()建立資料庫--用execSQL()方法執行"CREATETABLE"述--用insert()方法及ContentValues件新增資料--建立資料庫及資料表
        15-2查詢資料及使用Cursor物件--使用SELECT物件進行資料查詾--使用Cursor物件取得查結果--使用Cursor物件的getXXX()方法讀取資料--使用cursor物件取查詾結果
        15-3熱線通訊家--使用SimpleCursorAdapter自訂ListView版面--資料表的_id欄位
    第16章Android互動設計一藍牙遙控自走車iTank
        16-1讓Android與外部的裝置互動--iTank智慧型移動平台基本簡介
        16-2點亮iTank控制板上的LED燈--點亮LED的指令--點亮LEDI
        16-3手機藍牙遙控iTank--FlagTank類別--手機藍牙遙控'張明星Wear   從穿戴裝置開始，第一次學Android開發就上手    張明星, 孫嬌  2015/03/23  佳魁資訊 '
   前言
Chapter 01   Android 開發技術基礎
1.1 智慧型手機系統介紹
1.2 Android 的極大優勢
1.3 架設Android 應用程式開發環境
1.4 穿戴裝置的前世今生

Chapter 02  Android 技術核心框架分析
2.1 分析Android 的系統架構
2.2 簡述五大元件
2.3 處理程序和執行緒
2.4 分析Android 原始程式結構
2.5 Android 和Linux 的關係
2.6 第一段Android 程式

Chapter 03  HTTP 資料通訊    
3.1 HTTP 基礎
3.2 使用Apache 介面
3.3 使用標準的Java 介面
3.4 使用Android 網路介面
3.5 實戰演練

Chapter 04  使用Socket 實現資料通訊    
4.1 Socket 程式設計初步
4.2 TCP 程式設計詳解
4.3 UDP 程式設計
4.4 實戰演練 —— 在Android 中使用Socket 實現資料傳輸

Chapter 05  下載遠端資料                          
5.1 下載網路中的圖片資料
5.2 下載網路中的JSON 資料
5.3 下載某個網頁的原始程式
5.4 遠端取得多媒體檔案
5.5 多執行緒下載
5.6 遠端下載並安裝APK 檔案

Chapter 06  上傳資料    
6.1 Android 上傳資料技術
6.2 實戰演練 —— 上傳檔案到遠端伺服
6.3 使用GET 方式上傳資料
6.4 使用POST 方式上傳資料
6.5 使用HTTP 協定實現上傳

Chapter 07  感測器技術                          
7.1 Android 感測器系統概述  
7.2 使用SensorSimulator  
7.3 使用感測器

Chapter 08  人工智慧技術    
8.1 人工智慧基礎
8.2 圖搜索在人工智慧中的應用
8.3 實戰演練 —— 各種AI 圖搜索演算法在Android 遊戲中的用法

Chapter 09  語音辨識和手勢識別                          
9.1 語音辨識技術
9.2 手勢識別

Chapter 10  藍牙技術基礎    
10.1 藍牙概述
10.2 低耗電藍牙基礎
10.3 藍牙標準
10.4 低耗電藍牙協定堆疊詳解
10.5 TI 公司的低耗電藍牙

Chapter 11  Android 藍牙模組詳解    
11.1 Android 系統中的藍牙模組
11.2 分析藍牙模組的原始程式
11.3 和藍牙相關的類別
11.4 在Android 平台開發藍牙應用程式
11.5 在穿戴裝置中開發一個藍牙控制器

Chapter 12  藍牙4.0 BLE 詳解                          
12.1 短距離無線通訊技術概覽
12.2 藍牙4.0 BLE 基礎
12.3 低耗電藍牙協定堆疊詳解

Chapter 13  專案實戰 —— 開發智慧心跳計                          
13.1 什麼是心跳  
13.2 什麼是心跳手錶  
13.3 開發一個Android 版測試心跳系統

Chapter 14  專案實戰 —— 開發計步器    
14.1 系統功能模組介紹
14.2 系統主介面  
14.3 系統設定模組'柯博文    Android 6變形金剛：最佳化案例開發實戰  博碩   2015/11/30   github.com/powenko/Android6CookbookPowenko'   www.drmaster.com.tw/Bookinfo.asp?BookID=MP21522
    CHAPTER 01　Android簡介
    CHAPTER 02　開發環境設定
    CHAPTER 03　開發環境介紹
    CHAPTER 04　Android常用的元件  TextView  EditText  Button  ImageView  ImageButton checkbox RadioGroup RadioButton Spinner NumberPicker 解決軟鐽盤擋住
    CHAPTER 05　切換畫面    startActivity Bundle startActivityForResult 
    CHAPTER 06　畫面設計    RelativeLayout LinearLayout  AbsoluteLayout  FrameLayout TableLayout GridLayout InsertLayout 動態加入其它的Layout
    CHAPTER 07　元件觸發事件處理   透過 class, 透過implement , setOnTouchListener , 使用觸發變數 
    CHAPTER 08　視窗  Log函數, Toast函數 , AlertDialog , PopupWindow, ListPopupWindow --  NoticationManager Menu  PopupMenu - 
                     --Status bar Notification 狀態欄提示 --顯示訊息到 lock screen  --ProgressDialog 處理進度視窗 -- 
    CHAPTER 09　列表顯示 UI  -- ListActivity -- ScrollView 畫面上下捲動 -- HorizontalScrollView 左右畫面捲動-- 列表選取ToggleButton -- 展開列表 ExpandableListView
    CHAPTER 10　動畫效果     -- Tween Animation UI元件 -- Frame Animation UI 元件 -- 換頁動畫  --SDK20的新動畫功能
    
    CHAPTER 11　進階UI元件   -- Tab -- ActionBarTab -- SlidingDrawer -- style換膚功能 --Fragment 畫面切割-- Action Bar 標籤頁
                            -- Search View 搜尋 -- Action Bar 回上一頁 -- StackView -- ExpandableListView 展開列表 
                            --Content loader  -- TimePicker TimePickerDialog --DatePickerDialog -- Fragment 動態切割
    CHAPTER 12　網路功能     --WebKit 顯示網頁 -- HTTPGet 範例程式  -- HTTPPost  -- HTTP Download Image  --設定網路下載的時間
                            --下載並顯示進度  --Hybrid 網頁型 App --Facebook 4  登入
    
    CHAPTER 13　檔案處理    -- preferences  -- File -- SQLite -- XML -- JSON -- SD  --下載並顯示進度
    CHAPTER 14　控制硬體    -- 撥打電話 -- 發簡訊 -- 位置服務 GPS  --轉換成地址一GPS獲取經緯度元件 --Bluetooth  API -- 藍牙聊天室 BluetoothChat
                            -- WiFi Direct -- NFC -- 電話聯絡人的名單
    CHAPTER 15　多媒體音樂影片播放程式 -- 音樂放在程式中 --音樂放在SD卡 -- VideoView 播放影片  --錄音
    CHAPTER 16　系統功能應用程式   --ScreenOrientation-畫面翻轉“  --screenOrientation橫直畫面的處理  --System clipboard的剪貼簿.  --Widget桌面應用程式
    CHAPTER 17　多執行緒          --Timer  -- Thread -- ANR 錯誤 -- 建立自己的implement 觸發事件  -- Service 常駐程式  進階
    CHAPTER 18　Android開發相關技巧 --簽署和販賣應用程式, --認證檔案keystore--到GooglePlay賣軟體--取得機器或模擬器的截圖--Android使用第三方jar包的方法--設計lib和使用lib--如何建立一個lib--如何使用Lib.
    CHAPTER 19　廣告   --Google Admob 設定 -- 廣告   --Google Admob    APPendix A 2D 圖形影像處理    APPendix B 3D OpenGLES'王安邦   Android 6.X App開發之鑰：使用Java及Android Studio(附光碟)  2015/11/27  上奇資訊  9折612元'
    Chapter 01　Android 簡介
    Chapter 02　準備Android 開發環境  -- 工具列 -- Project 專案瀏覽視窗  --
    Chapter 03　準備Android 開發環境   
                --建立一個AndroidAPP--整合式開發環境Andriodstudio的簡介--建立及啟動虛擬機器AVD--編譯、簽署、及執行一個AndroidAPP--刪除-個AndroidApp
                --滙一個AndroidApp--以指定的組態執行一個AndroidApp--在霣體手機上執行一個AndroidAPP--發行您開發的AndroidAPP
                --除錯視窗組的操作-DDMS視窗的操作

    Chapter 04　深入解析Android App 專案   -Android App 基礎 -- eclipse ADT 與 Android Studio 的差異 -- Android App 專案的解析 
    Chapter 05　自己撰寫Android App  
                --自己撰寫AndroidApp專案--撰寫MVC式的AndroidApp專案--介紹Button物件及toast類別--存取Resources
                --ImageButton(影像按鈕)物件--DynamicButton(動態按鈕)--文字欄位的監控---ToggleButton(切換按鈕)物件--開發多語言的App專案
    Chapter 06　活動（Activity）及意圖（Intent）
                --活動--啟動另-活動未夾帶資料--啟動另-活動且夾帶買料--啟動另一活動並由該活動傳回資料--執行特定工作的活動--意圖篩選器(IntentFilter)
                --管理活動的生命週期(Managingthe ActivityLifecycle )  callbacks  -- saving activity state -- Handling configuration changes -- coordinating activities  
    Chapter 07　使用者介面（UI）物件的應用
                --View ViewGroup -- Layout -- Radio Button -- Radio Group --List -- Adapter -- Adapter View --Spinner --CheckBox --ScrollView
                --ImageView -- SeekBar -- RatingBar --GridView --Gallery -- ImageSwithcher object  --ListView -- ExpandableListView object 
    Chapter 08　存取資料      -- 存取 Assets --存取 shared preferences -- 存取 Internal Stroage -- 存取 External Storage
    Chapter 09　對話方塊（Dialog）及通知（Notification）--
                    --Toast--Notification類別--預設的通知方式--自訂通知,--Thread(執行緒)及Handler(處理桯序)類別--對話方塊的應用--建立AlertDlalog方法一
                    --建立AlertDialog方法二--對話方塊含選項清單、選項鈕群組、核取方塊--進度對話方塊--自訂話方塊--Datepicker物件及TimePicker物件
                    ---DatePicker物件 ---Timepicker物件  -- DatePickerDialog -- TimePickerDialog

    Chapter 10　BroadCast Receiver 及Service 元件
                    --系統廣播--使用自訂廣播--service元件.--在清單中宣吿服務,--操作被啟動的服務--操作被綁定的服務、--服務的生命週期
                    --被動的服務--被綁定服務
    Chapter 11　其他使用者介面（UI）物件的應用
                    --OptionsMenu及Submenu物件(建立功能表)--ContextMenu物件(建立快顯功能表)--Action Bar物件(動作列)
                    --Menu Action Bar(功能表動作列) --Customer Menu Action Bar (自訂功能表動作列) --ActionView (動作列視窗)
                    --Fragment物件(視窗區塊) --ListFragment (清單視窗區塊) -- Alert Dialog Fragment (對話方塊視窗區塊)
                    --Options Menu Fragment(功能表視窗區塊) -- ContextMenu Fragment (快顯功能表視窗區塊)
                    --ShoworHideFragment(切換顯示或藏視窗區塊)--ActionBarTab(動作列標籤頁-視窗區塊)--ViewPager的應用
                    --ListFragment的應用1--ListFragment的應用2--以DrawerLayoute建立抽屜瀏覽,
    Chapter 12　SQLite 行動資料庫應用
    Chapter 13　內容提供者（Content Provider）元件 --應用  ----讀取手機設備中的連絡人·--讀取手機設備中的簡訊--讀手機設中的媒體
    Chapter 14　多媒體與相機
    Chapter 15　繪圖及動畫（收錄於光碟中）'陳德春   讓你的Android程式碼10倍速，不出錯：使用最佳化技術    2016/01/29  468元'		Chapter01 Android 系統閃亮登場
			1.1 一款全新的智慧型手機平台——Android  
			1.1.1 何謂智慧型手機
			1.1.2 看目前主流的智慧型手機系統  
			1.2 分析Android 的優勢  
			1.2.1 第一個優勢—— 系出名門  
			1.2.2 第二個優勢—— 強大的開發團隊  
			1.2.3 第三個優勢—— 獎金豐厚
			1.2.4 第四個優勢——程式開放原始碼  
			1.3 架設開發環境  
			1.3.1 安裝Android SDK 的系統要求
			1.3.2 安裝JDK、Eclipse、Android SDK
			1.3.3 設定Android SDK Home
			1.4 建立Android 虛擬裝置(AVD)  
			1.4.1 Android 模擬器簡介
			1.4.2 模擬器和實機的區別
			1.4.3 建立Android 虛擬裝置  
			1.4.4 啟動模擬器  
			1.4.5 快速安裝SDK
			1.5 解決架設環境過程中的三個問題  
			1.5.1 不能線上更新  
			1.5.2 一直顯示Project name must be specified 提示
			1.5.3 Target 清單中沒有Target 選項  
		
		Chapter02 分析Android 核心框架
			2.1 簡析Android 安裝檔案
			2.1.1 Android SDK 目錄結構  
			2.1.2 android.jar 及其內部結構  
			2.1.3 SDK 說明文件
			2.1.4 Android SDK 實例簡介  
			2.2 Android 的系統架構詳解  
			2.2.1 Android 系統結構介紹
			2.2.2 Android 專案檔案結構
			2.2.3 應用程式的生命週期  
			2.3 簡析Android 核心  
			2.3.1 Android 繼承於Linux  
			2.3.2 Android 核心和Linux 核心的區別  
			2.4 簡析Android 原始程式  
			2.4.1 取得並編譯Android 原始程式
			2.4.2 Android 對Linux 的改造
			2.4.3 為Android 建構Linux 的作業系統  
		
		Chapter03 為什麼需要最佳化
			3.1 使用者體驗是產品成功的關鍵  
			3.1.1 什麼是使用者體驗  
			3.1.2 影響使用者體驗的因素  
			3.1.3 使用者體驗設計目標
			3.2 Android 的使用者體驗  
			3.3 不同的廠商，不同的硬體
			3.4 Android 最佳化概述
		
		Chapter04 UI 版面配置最佳化
			4.1 和版面配置相關的元件
			4.1.1 View 視畫素件
			4.1.2 Viewgroup 容器
			4.2 Android 中的5 種版面配置方式  
			4.2.1 線性版面配置LinearLayout  
			4.2.2 框架版面配置FrameLayout
			4.2.3 絕對版面配置AbsoluteLayout
			4.2.4 相對版面配置RelativeLayout
			4.2.5 表格版面配置TableLayout  
			4.3 標籤在UI 介面中的最佳化作用  
			4.4 遵循Android Layout 最佳化的兩段通用程式  
			4.5 最佳化Bitmap 圖片  
			4.5.1 實例說明  
			4.5.2 實作方式
			4.6 FrameLayout 版面配置最佳化  
			4.6.1 使用減少視圖層級結構  
			4.6.2 使用重用Layout 程式  
			4.6.3 延遲載入
			4.7 使用Android 為我們提供的最佳化工具
			4.7.1 Layout Optimization 工具
			4.7.2 Hierarchy Viewer 工具
			4.7.3 聯合使用和標籤實現互補
			4.8 歸納Android UI 版面配置最佳化的原則和方法
		
		Chapter05 Android 的記憶體系統
			5.1 記憶體和處理程序的關係
			5.1.1 處理程序管理工具的紛爭  
			5.1.2 程式設計師的工作  
			5.1.3 Android 系統記憶體設計
			5.2 分析Android 的處理程序通訊機制
			5.2.1 Android 的處理程序間通訊(IPC) 機制Binder
			5.2.2 Service Manager 是Binder 機制的上下文管理者  
			5.2.3 分析Server 和Client 獲得Service Manager 的過程
			5.3 分析Android 系統匿名共用記憶體C++呼叫介面
			5.3.1 Java 程式  
			5.3.2 相關程式
			5.4 Android 中的垃圾回收
			5.4.1 sp 和wp 簡析
			5.4.2 詳解智慧指標(android refbase 類別(sp 和wp))  
		
		Chapter06 Android 記憶體最佳化
			6.1 Android 記憶體最佳化的作用
			6.2 檢視Android 記憶體和CPU 使用情況
			6.2.1 利用Android API 函數檢視  
			6.2.2 直接對Android 檔案進行解析查詢  
			6.2.3 透過Runtime 類別實現  
			6.2.4 使用DDMS 工具取得  
			6.2.5 其他方法  
			6.3 Android 的記憶體洩漏  
			6.3.1 什麼是記憶體洩漏  
			6.3.2 為什麼會發生記憶體洩漏  
			6.3.3 shallow size、retained size  
			6.3.4 檢視Android 記憶體洩漏的工具  
			6.3.5 檢視Android 記憶體洩漏的方法  
			6.3.6 Android(Java) 中常見的容易引起記憶體洩漏的不良程式  
			6.4 常見的引起記憶體洩漏的壞毛病  
			6.4.1 查詢資料庫時忘記關閉游標
			6.4.2 建構Adapter 時不習慣使用快取的convertView  
			6.4.3 沒有及時釋放物件的參考  
			6.4.4 不在使用Bitmap 物件時呼叫recycle() 釋放記憶體
			6.5 演練解決記憶體洩漏  
			6.5.1 使用MAT 根據heap dump 分析Java 程式記憶體洩漏的根源
			6.5.2 演練Android 中記憶體洩漏程式最佳化及檢測  
			6.6 Android 圖片的記憶體最佳化  
		
		Chapter07 程式碼最佳化
			7.1 Android 程式最佳化的基本原則  
			7.2 最佳化Java 程式  
			7.2.1 GC 物件最佳化
			7.2.2 儘量使用StringBuilder 和StringBuffer 進行字串連接
			7.2.3 及時釋放不用的物件
			7.3 撰寫更高效的Android 程式  
			7.3.1 避免建立物件
			7.3.2 最佳化方法呼叫程式  
			7.3.3 最佳化程式變數  
			7.3.4 最佳化程式過程
			7.3.5 加強Cursor 查詢資料的效能  
			7.3.6 編碼中儘量使用ContentProvider 共用資料
			7.4 Android 控制項的效能最佳化  
			7.4.1 ListView 控制項的程式最佳化
			7.4.2 Adapter( 介面卡) 最佳化
			7.4.3 ListView 非同步載入圖片最佳化
			7.5 最佳化Android 圖形  
			7.5.1 2D 繪圖的基本最佳化  
			7.5.2 觸發螢幕圖形觸控器的最佳化  
			7.5.3 SurfaceView 繪圖覆蓋更新及重繪矩形更新方法
		
		Chapter08 性能優化
			8.1 資源儲存最佳化
			8.1.1 Android 檔案儲存
			8.1.2 Android 中的資源儲存
			8.1.3 Android 資源的類型和命名  
			8.1.4 Android 檔案資源(raw/data/asset) 的存取  
			8.1.5 Android 對Drawable 物件的最佳化  
			8.1.6 建議使用Drawable，而非Bitmap
			8.2 載入APK 檔案和DEX 檔案
			8.2.1 APK 檔案介紹
			8.2.2 DEX 檔案介紹和最佳化
			8.2.3 Android 類別動態載入技術實現加密最佳化
			8.3 SD 卡最佳化
			8.4 Android 的虛擬機器最佳化
			8.4.1 Android 虛擬機器概述
			8.4.2 平台最佳化——ARM 的管線技術
			8.4.3 Android 對C 函數庫最佳化
			8.4.4 建立處理程序的最佳化
			8.4.5 繪製最佳化  
			8.5 SQLite 最佳化
			8.5.1 Android SQLite 的查詢最佳化
			8.5.2 SQLite 效能最佳化技巧
			8.6 Android 的圖片快取處理和效能最佳化  
			
		Chapter09 系統最佳化
			9.1 基本系統最佳化
			9.1.1 更新軔體重新啟動  
			9.1.2 刷核心  
			9.1.3 精簡內建應用  
			9.1.4 基本系統最佳化歸納  
			9.2 處理程序管理
			9.2.1 Android 處理程序跟Windows 處理程序是兩回事
			9.2.2 檢視目前系統中正在執行的程式
			9.2.3 列舉Android 系統的處理程序、工作和服務的資訊
			9.2.4 研究Android 處理程序管理員的實現
			9.3 將Android 軟體從手機記憶體傳輸到儲存卡  
			9.3.1 第一步：準備工作
			9.3.2 第二步：儲存卡分區
			9.3.3 第三步：將軟體移動到SD 卡  
			9.4 常用的系統最佳化工具  
			9.4.1 優化大師  
		    9.4.2 360 手機衛士  
		
		Chapter10 開發一個Android 最佳化系統
			10.1 優化大師介紹  
			10.1.1 手機優化大師用戶端
			10.1.2 手機優化大師PC 端  
			10.2 專案介紹  
			10.2.1 規劃UI 介面
			10.2.2 預期效果
			10.3 準備工作
			10.3.1 新增專案
			10.3.2 主介面  
			10.4 撰寫主介面程式
			10.5 處理程序管理模式模組  
			10.5.1 基礎狀態檔案  
			10.5.2 CPU 和記憶體使用資訊  
			10.5.3 處理程序詳情  
			10.6 處理程序視圖模組
			10.6.1 處理程序主視圖
			10.6.2 處理程序視圖  
			10.6.3 取得處理程序資訊
			10.7 處理程序類別模組  
			10.7.1 載入處理程序  
			10.7.2 後台載入設定
			10.7.3 載入顯示  
			10.8 檔案管理模式模組
			10.8.1 檔案分類
			10.8.2 載入處理程序
			10.8.3 檔案視圖處理  
			10.9 檔案管理模組  
			10.9.1 資料夾
			10.9.2 顯示檔案資訊
			10.9.3 操作檔案  
			10.9.4 取得處理程序的CPU 和記憶體資訊
			10.10 系統測試  
		
		Chapter11 綜合實例—— 手機地圖系統
			11.1 專案分析  
			11.1.1 規劃UI 介面
			11.1.2 資料儲存設計和最佳化  
			11.2 具體實現
			11.2.1 新增專案
			11.2.2 主介面
			11.2.3 新增介面
			11.2.4 設定介面  
			11.2.5 說明介面
			11.2.6 地圖介面
			11.2.7 資料存取  
			11.2.8 實現Service 服務
			11.3 發佈自己的作品來盈利  
			11.3.1 申請會員  
			11.3.2 產生簽名檔
			11.3.3 使用簽名檔  
			11.3.4 發佈
		
		Chapter12 綜合實例——Android 足球遊戲
			12.1 手機遊戲產業的發展
			12.1.1 1.2 億手機遊戲使用者
			12.1.2 淘金的時代
			12.1.3 手機遊戲的未來發展  
			12.2 Java 遊戲開發基礎
			12.3 足球遊戲介紹  
			12.3.1 手機足球遊戲  
			12.3.2 策劃遊戲
			12.3.3 準備工作  
			12.4 專案架構
			12.4.1 整體架構  
			12.4.2 規劃類別  
			12.5 Android 手機遊戲的最佳化策略
			12.6 具體程式開發
			12.6.1 Activity 類別開發  
			12.6.2 歡迎介面  
			12.6.3 載入節目  
			12.6.4 運動控制
			12.6.5 獎品模組'陳會安   新觀念 Android 程式設計範例教本：使用 Android Studio  2015/03/24   589元'		Part01 Java 與 Android 的基礎
			第1章 Android 基礎與開發環境的建立
			第2章	建立 Android 應用程式
			第3章	Android 模擬器與實機的使用
			第4章	XML 與 Java 物件導向程式設計
		
		Part02	Android 程式設計–單一活動與片段篇
			第5章	活動與版面配置 - TextView 和 Button 為例說明版面配置
			第6章	建立 Android 使用介面 – View、與事件處理 (範例:BMI 計算機) 
			第7章	Fragment 片段與動作列選單 – 更多的事件處理
			第8章	對話方塊與資源管理 - 介面元件動畫，對話方塊
		
		Part03	Android 程式設計–組成元件與多活動篇
			第9章	使用意圖啟動活動與內建應用程式– 多國語系
			第10章 儲存偏好設定、檔案與資料庫 – 儲存偏好設定頁面和表單輸入資料
			第11章 內容提供者、清單元件與動作列巡覽– Spinner、ListView 與側邊選單
			第12章 廣播接收器、服務與訊息提醒
		
		Part04	Android 程式設計–實務篇
			第13章	繪圖與多媒體
						-[行動圖庫][音樂播放器][視訊播放器][錄音程式][井字遊戲]
			第14章	Google 地圖與定位服務
						-[我在哪裡][找出景點座標][GPS 景點防撞雷達][My 地圖][追蹤個人行蹤]
			第15章 網路與通訊
						-[行動瀏覽器][我的簡訊][郵件寄送工具][大型檔案下載][GPS 間諜簡訊]
			第16章 首頁畫面小工具與硬體介面
						-[手機靜音切換][重力球遊戲][行車記錄器][聰明相機][掃描藍芽裝置]
		
		附錄 A：Java 語言的基本語法 (PDF 電子書)
		附錄 B：使用者偏好設定頁面和自行建立內容提供者 (PDF 電子書) 

'黃彬華   Android 6~5.x App開發教戰手冊-使用Android Studio(附教學影片、範例檔)  碁峰   2015/10/21  411元'
    	chapter 1　Android導論
		chapter 2　開發工具下載與安裝
		chapter 3　Android專案與系統架構  --DDMS  --多國語言
		chapter 4　UI設計基本概念  --Layout Editor -- 非程式資源  --AndroidUI設計基本觀念--AndroidLayoutEditor--非程式資源
                                --UI事件處理 --按鈕點擊件處理-java統型--按鈕點事件處理-Android簡易型--layout元件介紹--常用layout說明
                                --ScrollView與HorizontalScrollView  --style與theme--定義style --繼承style --套用theme --繼承theme
                                --觸控與手勢--觸擊事件處理--手勢--WebView--RatingBar--SeekBar--CompoundButton--Menus
		chapter 5　UI進階設計     --Spinner --AutoCompleteTextView --ListView--GridVlew --CardViewEh.d RecyclerView 
                                --自訂View 元件與 2D 繪圖 --Frame Animation --Tween Animation 

		chapter 6　Activity與Fragment --Activity生命週期  --Activity之間資料傳遞  --傳遞基本資料類型  --傳遞物件類型 --FragmentUI設計概念
                                     --Fragment生命週期 --頁面切割 --DialogFragment  --AlertDialog  --DatePickerDialog  -- TimePickerDialog

		chapter 7　Notification, Broadcast, Service  --Notification(通知訊息)  --Broadcast(廣播)  --攔截Broadcast
                                                     --自行發送與攔截Broadcast--Service生命週期--呼叫Service開啟Service--呼叫bindService()連結Service
                                                       --IntentService
		chapter 8　資料存取  --Android 資料存取概論 --Assets --Shared Preferences --Internal Storage --External Storage 

		chapter 9　行動資料庫SQLite  --SQLite資料庫概論與資料類型  -SQLite資料厙概論  -SQLite資料類型  --使用命令列建立資料庫.
                                    --SQL語法  -建立資料表  -DML語法  --應用程式存取SQLite資料庫  --新增功能--修改功能·--刪除功能--查詢功能
                                    --查詢聯絡人資料
		chapter 10　Google地圖  --Google地圖功能介紹.--產生數位憑證指紋 --申請API金鑰  --GooglePlayServices安裝與匯入 --建立基本Google地圖.
                                --地圖種類與UI設定-地圖種類設定-地圖UI設定  --使用標記與設定鏡頭焦點-使用標記-訊息視窗-標記事件處理-鏡頭設定
                                --繪製連續線丶多邊形與圓形-連續線(Polyline)-多邊形(Polygon)-圓形(Circle)
                                --地名或地址轉成位置--位置資訊的應用-定位(Fix)-更新位置-計算2點間距離-導航功能


		chapter 11　感應器應用   -感應器介紹--加速度感應器--陀螺儀感應器--方位感應器.--呼叫getOrientation()取得方位資訊--接近感應器.--光度感應器

		chapter 12　多媒體與相機功能 -Android多媒體功能介紹--播放Audio檔案-播放資源檔案-播放外部檔案--Video播放器.
                                    --錄製Audio檔案--拍照與選取照片-拍照-選取照片 --錄製Video檔案
		chapter 13　AdMob廣告看板製作   --AdMob簡介--註冊AdMob帳戶--建立廣吿單元並取得編號--將行動廣吿整合至應用程式.-GooglePlayServices安裝與匯入.
                                        -設定Android專案的manifest檔案 -使用AdⅥew加橫幅告


		chapter 14　發佈應用程式至Play商店 --將應用程式發佈至Play商店.--產生並簽署應用程式-發佈應用程式前應注意事項--申請Android開發者帳號
                                        --使用開發者管理介面發佈應用程式-應用程式首次發佈-應用程式改版'trimspace '
--將 應 用 程 式 發 佈 至 Play 商 店 . 
--產 生 並 簽 署 應 用 程 式 
-發 佈 應 用 程 式 前 應 注 意 事 項 
--申 請 Android 開 發 者 帳 號 
--使 用 開 發 者 管 理 介 面 發 佈 應 用 程 式 
- 應 用 程 式 首 次 發 佈 
- 應 用 程 式 改 版 '#--------------------------------------------------------------------------------
#   1   66   command . shortcut 
#--------------------------------------------------------------------------------

CTRL-SHIFT-ENTER       Auto add Code 自動結尾;  
ALT-ENTER              Auto import 修改錯誤         
Run                    SHIFT-F10
code Completion          CTRL-SPACE 
 
smartType Completion    CTRL-SHIFT-SPACE   (exe : Srting S=(<caret is here>

Find Error (red light  紅色燈泡)         ALT-ENTER

open variable file      CTRL-ALT+ click *2 
CTRL-E  open recenlty file
cTRL-Z  CTRL-Y

Layout > XML > 直接在 element 中修改 ext LinerLayout to RelativeLayout
Layout > XML > 直接在 element 輸入 '<' 會出現可以待選, 最後再加上 '>' ,會自動出現

程式畫面放大  <左下角>
<tab>key : live Templates  , File > Settings > Live Templates 
ctrl+ SPACE  codeCompletion  File > seetings > Code style
ctrl+ P  list of valid parameter
ctrl+ shift +F7  edit /find/highlight usages in File ) F3. Shift_F3 navigate .escape remove highlight
Ctrl+ Shift+J shortcut joins two lines into one and removes unnecessary space to match your code style.
Ctrl+j(ctrlj)  valid live Template abbreviation
Ctrl+Shift+V shortcut to choose and insert recent clipboard contents into the text.

implement interface  -> using 燈泡  .會自動產生 method

Alt+1  (alt1) :Project View 
Alt+9 : (alt9): Version view 
Alt+Q  view| context info : to see the declaration of the current method 找出宜告物件()在程式中何處出現
Alt+UP   Alt+Down  Quickly move between methods in the editor

File > settings 
appearance  and behavior > UI Options  >  Theme : Intellij  Size: 30 and  14<- UI Font


Editor > Colors & Fonts > Font > Size : 30  <-  13

F2 / shift F2   jump between highlighted syntax error;
Ctrl+Alt+UP / Ctrl+Alt Down  between  compiler error messages or search operation results

Ctrl+W 
To easily evaluate the value of any expression while debugging the program, select its text in the editor 
(you may press a Ctrl+W a few times to efficiently perform this operation) and press Alt+F8.

#--------------------------------------------------------------------------------
#   74   宣告 / Type
#--------------------------------------------------------------------------------
String msg="";
RadioGroup unit;
EditText value;
CheckBox  Chkj;
double f, c;  // 儲存溫度值換算結果

#--------------------------------------------------------------------------------
#   84   math  round
#--------------------------------------------------------------------------------
int counter = 0;	// 用來儲存計數的值, 初值為 0
counter+=2  ;  ++counter 


:math to string 
String.valueOf(++counter)
txvRate.setText(String.valueOf(energyRate[position]));    


 long consumedEnergy=Math.round(energyRate[selected]*w*t);



#--------------------------------------------------------------------------------
#   97   String
#--------------------------------------------------------------------------------

string to Math
#格式化輸出 ref shen05.p9
String.format("%.1f",c)

#string to Double  ref shen05.p9
double f, c; 
f = Double.parseDouble(value.getText().toString());

# 字串長度
String msg="";
msg.length()>0

#將換行字元
msg+="\n"+chk.getText();   // 將換行字元及字串相加

 #字串相加
 msg+=" "+str;   
 #是否有已字串
 selected.contains(item)

 substring() 
 substring(int start) : 截取由 tart 位 置 ( 由 0算起 ) 開到字串結束的所有字元 # "abcde".substring(1) 的結果為 'bcde'
 substring(int start, int end): 截取由 start 到 (end-1) 之間的字元


#--------------------------------------------------------------------------------
#   111   array 陣列  ArrayList
#--------------------------------------------------------------------------------
// 固定陣列 
int[5] intArr
   String[] aMemo = {
            "1. 按一下可以編輯備忘\"",
            "2. 長按可以清除備忘\" ," 
            "3.",
            "4.",
            "5.",
            "6."
    };

// 用陣列存放所有 CheckBox 元件的 ID
int[] id={R.id.chk1, R.id.chk2, R.id.chk3, R.id.chk4};
int[] chk_id={R.id.chk1,R.id.chk2,R.id.chk3,R.id.chk4};
double[] energyRate={3.1, 4.4, 13.2, 9.7, 5.1, 3.7};


// 用來儲存已選取項目的 ID 集合物件  shen05
import java.util.ArrayList;
ArrayList<int>    //存放int 
ArrayList<String> //String 陣列 可以任意新增刪除集合元素
ArrayList<int>  intList = New Array<>();  //declare
initList.add(10);     //加入 整數10
initList.remove(10);  //刪除 整數10

ArrayList<CompoundButton> selected=new ArrayList<>();


 ArrayList<String> selected = new ArrayList<>();
 String item = txv.getText().toString();
        if(selected.contains(item)) // 若 ArrayList 已有同名項目
            selected.remove(item);  // 就將它移除
        else                        // 若 ArrayList 沒有同名項目
            selected.add(item);     // 就將它加到 ArrayList (當成選取的項目)
        String msg;

        if(selected.size()>0){   // 若 ArrayList 中的項目數大於 0
            msg="你點了:";
            for(String str:selected)
                msg+=" "+str;    // 每個項目 (餐點) 名稱前空一格
        }                        // 並附加到訊息字串後面
        else                     // 若 ArrayList 中的項目數等於 0
            msg="請點餐!";

#--------------------------------------------------------------------------------
#  106    flow control  switch  break;  if  for
#--------------------------------------------------------------------------------
{<# 
switch
switch (ticketType.getCheckedRadioButtonId()) {
            case R.id.adult:
                txv.setText("Adult");
                break;
            case R.id.child:
                txv.setText("child");
                break;
            case R.id.senior:
                txv.setText("senior");
                break;
        }


for(int i:id){    // 以迴圈逐一檢視各 CheckBox 是否被選取
            chk = (CheckBox) findViewById(i);
            if(chk.isChecked())            // 若有被選取
                msg+="\n"+chk.getText();   // 將換行字元及選項文字
        }                                  // 附加到 msg 字串後面


if(isChecked){  // 被選取時
            items++;    // 數量加 1
            visible=View.VISIBLE; // 將圖片設為可見
        }
        else{                     // 被取消時
            items--;              // 數量減 1
            visible=View.GONE;    // 將圖片設為不可見
        }
//檢查是否為空字串.即返回不執行
 if (weight.getText().length() == 0 || time.getText().length() == 0 ) {
            return;
        }

#>}


#--------------------------------------------------------------------------------
#   122  vibrator 震動  開放手機資源權限 permission   shen04.12  
#--------------------------------------------------------------------------------
{<# 
AndroidManifest.xml 加上
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
 在 <application/> 之外

 Vibrator vb = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);

vb.vibrate(5000); // 震動 5 秒
vb.cancel(); // 停止震動

long[] pattern =(0,100,2000,300);
vb.vibrate(pattern  ,2 )
#>}

#--------------------------------------------------------------------------------
#   113   getSystemService
#--------------------------------------------------------------------------------

{<#  


#>}


#--------------------------------------------------------------------------------
#   137  顯示溫度符號  
#--------------------------------------------------------------------------------
{<#  
1 是使用Unicode
  \uXXX  , \u2109  , \u2103

1 是使用圖案
#>}

#--------------------------------------------------------------------------------
#     156 自專案資源載入字串  getResources().getString(R.string.charC));  shen05 shen 6
#--------------------------------------------------------------------------------
{<#  
in class   getResources()

degC.setText(String.format("%.1f",c)+  getResources().getString(R.string.charC));  //#本例為呼叫在 String.xml 中的字串


進行呼叫手機資源 進行
String[] cinemas = getResources().getStringArray(R.array.cinemas);#本例為呼叫在 String.xml 中的字串陣列 


getResources().getDrawable() //可取得在drawable-XXX  下的圖形資源

#>}


#--------------------------------------------------------------------------------
#     266  ArrayAdapter  shen6-3  
#--------------------------------------------------------------------------------
{<#  
可配合 spinner .ListView 進行動態字串顯示..

ArrayAdapter<string> tempad = new ArrayAdapter<string>(this, android.R.layout.simple_spinner_item, tempSet);

ArrayAdapter<string> //表示為字串
tempad = new ArrayAdapter<string>(
this  //第一個參數傳入
, android.R.layout.simple_spinner_item
, tempSet//來源資料的字串陣列
);

保留有需要再讀
#>}

#--------------------------------------------------------------------------------
#   315   使用地圖功則在 模擬 器 的 Target 設定 中 必 須選用 Google API   shen09 p.7
#--------------------------------------------------------------------------------
{<#  

對於已建立的模擬器,可執行Tools/Android/SDKManager」命令(或按工具列
的@鈕)開啟AVDManager「,然後按模擬器右側的鈕來修改設定”


trimspace  '
對 於 已 建 立 的 模 擬 器 , 可 執 行 Tools/Android/SDK Manager 」 命 令 ( 或 按 工 具 列 
的@ 鈕 ) 開 啟 AVD Manager  「 , 然 後 按 模 擬 器 右 側 的 鈕 來 修 改 設 定 ” 
'

#>}

#--------------------------------------------------------------------------------
#  1461  adb   android debug Bridge 所在    Tang07
#--------------------------------------------------------------------------------
{<#  
DB執行檔放置於AndroidSDK所安裝目錄下的「platform-tools」子目錄下,SDK安裝所在目錄可打開專案架構設定得知,請在功能表中選擇rFile/projectStructure」
 cd C:\Users\User\AppData\Local\Android\sdk\platform-tools\

run DOS Module 
adb devices  列出已連線設備 
.\adb.exe devices
'
List of devices attached
emulator-5554           device
Medfield42C63D52        device
'
adb shell    如果目前ADB只連接到一個設備,直接使用radbshell」指令即可遠端連線至該設備,連線成功後會進入Android系統,並取得命令提示(prompt)
.\adb -s  Medfield42C63D52 shell   #

連接後最後的「#」號,代表目前登入為系統超級使用者root,可以自由複製、刪除、管理Android內的檔案與目錄,模擬器大都能取得ro權限”若為連
連接後的提示字元最後為「$」號,代表操作的權限是受到限制的,無法提供管理層面的指令 

「exit」指令,即可離開遠端連接的設備
cd  
ls   :
cat  :  cat atm.xml




#>}

trimspace '
結 實 體 手 機 時 , 連 接 後 的 提 示 字 元 最 後 為 「$ 」 號 , 代 表 操 作 的 權 限 是 受 到 限 制 的 , 無 法 提 供 管 理 層 面 的 指 令 
最 後 , 使 用 「 exit」指 令 , 即 可 離 開 遠 端 連 接 的 設 備 , 如 下 圖 : 
'

#--------------------------------------------------------------------------------
#     
#--------------------------------------------------------------------------------
{<#  


#>}

#--------------------------------------------------------------------------------
#     
#--------------------------------------------------------------------------------
{<#  


#>}


#--------------------------------------------------------------------------------
#     
#--------------------------------------------------------------------------------
{<#  


#>}