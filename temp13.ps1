

#  35  step01  prereqs
#   75 step02  Install-ADDSForest 
# 121  step03  create BI Group ,user, OU on OS
# 251  step04  enable firewall
#  323 step05  SQL SSDE 
# 349  step06  SQL tool
#  356 step07  SQL SSASTR
# 363  step8   SQL SSASMD
# 371  step9  
#  378 step10  preinstall   Download-SP2013PreReqFiles.ps1
#  420 step13  Install-SP2013PreReqFiles.ps1 
# 430  step14  install SP
#  483 step15  SQL  alias
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






