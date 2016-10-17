<#

Subject :Tpex SQL alwayson for Moniter System 
CreateDate: OCT.14.2015
filepath :             C:\Users\administrator.CSD\OneDrive\download\PS1\ex07_MOFA.ps1

     \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\ex07_MOFA.ps1
history : 
. initial  #01 ~ #21


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\ex07_MOFA.ps1

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


<#
Oct.

#>
syscom
P@ssw0rdP@ssw0rdf

sa
P@ssw0rdf

Network 
# 23  -----------------snyc OS Time
# 25  -----------------extranet  Network
# 45  -----------------intranet Network
# 115 -----------------Hostname
# 117 -----------------remote desktop
# 119 -----------------firewall
# 126 -----------------make folder for SQL
# 133 -----------------install SQL





# 23  -----------------snyc OS Time
sync time.nist.gov 

whoami  tsteform\administrator

# 25  -----------------extranet  Network
ipconfig 
 'Connection-specific DNS Suffix  . : 
   Link-local IPv6 Address . . . . . : fe80::61eb:4ff3:4189:5ca2%12
   IPv4 Address. . . . . . . . . . . : 210.69.210.155
   Subnet Mask . . . . . . . . . . . : 255.255.255.192
   Default Gateway . . . . . . . . . : 210.69.210.129
   '
   dns 210.69.210.24

   ping 210.69.210.155
   ping 210.69.210.129

   ping www.udn.com #

active windows

   cfdnkm68ymx78kcg87twdgk8w  # all pass


# 45 -----------------intranet Network

   73.2.137.31
   73.2.1.1
   255.0.0.0
   dns: 73.2.136.151   73.2.136.152

ipconfig /all
'PS C:\Users\Administrator> ipconfig /all

Windows IP 設定

   主機名稱 . . . . . . . . . . . . .: tsteform
   主要 DNS 尾碼  . . . . . . . . . .: 
   節點類型 . . . . . . . . . . . . .: 混合式
   IP 路由啟用 . . . . . . . . . . . : 否
   WINS Proxy 啟用 . . . . . . . . . : 否

乙太網路卡 乙太網路 2:

   媒體狀態 . . . . . . . . . . . . .: 媒體已中斷連線
   連線特定 DNS 尾碼 . . . . . . . . : 
   描述 . . . . . . . . . . . . . . .: HP Ethernet 1Gb 2-port 330i Adapter #2
   實體位址 . . . . . . . . . . . . .: 5C-B9-01-C4-54-69
   DHCP 已啟用 . . . . . . . . . . . : 是
   自動設定啟用 . . . . . . . . . . .: 是

乙太網路卡 乙太網路:

   連線特定 DNS 尾碼 . . . . . . . . : 
   描述 . . . . . . . . . . . . . . .: HP Ethernet 1Gb 2-port 330i Adapter
   實體位址 . . . . . . . . . . . . .: 5C-B9-01-C4-54-68
   DHCP 已啟用 . . . . . . . . . . . : 否
   自動設定啟用 . . . . . . . . . . .: 是
   連結-本機 IPv6 位址 . . . . . . . : fe80::9cc5:1de:2531:a56f%12(偏好選項) 
   IPv4 位址 . . . . . . . . . . . . : 73.2.137.31(偏好選項) 
   子網路遮罩 . . . . . . . . . . . .: 255.0.0.0
   預設閘道 . . . . . . . . . . . . .: 73.2.1.1
   DHCPv6 IAID . . . . . . . . . . . : 207403265
   DHCPv6 用戶端 DUID. . . . . . . . : 00-01-00-01-1A-1F-DB-FC-5C-B9-01-C4-54-68
   DNS 伺服器 . . . . . . . . . . . .: 73.2.136.151
                                       73.2.136.152
   NetBIOS over Tcpip . . . . . . . .: 啟用

通道介面卡 isatap.{9957270D-05C6-4511-994A-94B9C04F5C52}:

   媒體狀態 . . . . . . . . . . . . .: 媒體已中斷連線
   連線特定 DNS 尾碼 . . . . . . . . : 
   描述 . . . . . . . . . . . . . . .: Microsoft ISATAP Adapter
   實體位址 . . . . . . . . . . . . .: 00-00-00-00-00-00-00-E0
   DHCP 已啟用 . . . . . . . . . . . : 否
   自動設定啟用 . . . . . . . . . . .: 是

通道介面卡 6TO4 Adapter:

   連線特定 DNS 尾碼 . . . . . . . . : 
   描述 . . . . . . . . . . . . . . .: Microsoft 6to4 Adapter
   實體位址 . . . . . . . . . . . . .: 00-00-00-00-00-00-00-E0
   DHCP 已啟用 . . . . . . . . . . . : 否
   自動設定啟用 . . . . . . . . . . .: 是
   IPv6 位址. . . . . . . . . . . . .: 2002:4902:891f::4902:891f(偏好選項) 
   預設閘道 . . . . . . . . . . . . .: 
   DHCPv6 IAID . . . . . . . . . . . : 452984832
   DHCPv6 用戶端 DUID. . . . . . . . : 00-01-00-01-1A-1F-DB-FC-5C-B9-01-C4-54-68
   DNS 伺服器 . . . . . . . . . . . .: 73.2.136.151
                                       73.2.136.152
   NetBIOS over Tcpip . . . . . . . .: 停用
'

Ping 73.2.1.1
# 115 -----------------Hostname
Hostname  #tsteform
# 117 ----------------- remote desktop
Enable remote desktop
# 119 ----------------- firewall

turn On firewall.cpl
wf.msc


create SQL  TCP 1433 , 
# 126 ----------------- make folder for SQL

MD d:\SQLDATA
MD d:\SQLLOG
MD d:\SQLtemp
MD d:\SQLDATA\BACKUP

# 133 ----------------- install SQL

   $SQLSource ='D:\software\SQL2014_STD_TW_X64'
   ii $SQLSource
   
 ii 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20151014_160345\ConfigurationFile.ini' cpi -Path 'C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\Log\20151014_160345\ConfigurationFile.ini' -Destination F:\MoFA_ConfigurationFile.ini -Force ii 'F:\MoFA_ConfigurationFile.ini'

cmd /c ("D:\software\SQL2014_ENT_TW_X64\Setup") '/ConfigurationFile=F:\MoFA_ConfigurationFile.ini' 

gsv -Name '*sql*'


# 147 -----------------WindowsFeature

      '
      PS C:\Users\Administrator>  Get-WindowsFeature 

Display Name                                            Name                       Install State
------------                                            ----                       -------------
[ ] Active Directory Federation Services                ADFS-Federation                Available
[ ] Active Directory Rights Management Services         ADRMS                          Available
    [ ] Active Directory Rights Management Server       ADRMS-Server                   Available
    [ ] 識別身分同盟支援                                        ADRMS-Identity                 Available
[ ] Active Directory 網域服務                               AD-Domain-Services             Available
[ ] Active Directory 輕量型目錄服務                            ADLDS                          Available
[ ] Active Directory 憑證服務                               AD-Certificate                 Available
    [ ] 憑證授權單位                                          ADCS-Cert-Authority            Available
    [ ] 網路裝置註冊服務                                        ADCS-Device-Enrollment         Available
    [ ] 線上回應                                            ADCS-Online-Cert               Available
    [ ] 憑證授權單位網頁註冊                                      ADCS-Web-Enrollment            Available
    [ ] 憑證註冊 Web 服務                                     ADCS-Enroll-Web-Svc            Available
    [ ] 憑證註冊原則 Web 服務                                   ADCS-Enroll-Web-Pol            Available
[ ] DHCP 伺服器                                            DHCP                           Available
[ ] DNS 伺服器                                             DNS                            Available
[ ] Hyper-V                                             Hyper-V                        Available
[ ] Windows Server Essentials 體驗                        ServerEssentialsRole           Available
[ ] Windows Server Update Services                      UpdateServices                 Available
    [ ] WID 資料庫                                         UpdateServices-WidDB           Available
    [ ] WSUS 服務                                         UpdateServices-Services        Available
    [ ] 資料庫                                             UpdateServices-DB              Available
[ ] Windows 部署服務                                        WDS                            Available
    [ ] 部署伺服器                                           WDS-Deployment                 Available
    [ ] 傳輸伺服器                                           WDS-Transport                  Available
[ ] 大量啟用服務                                              VolumeActivation               Available
[ ] 列印和文件服務                                             Print-Services                 Available
    [ ] 列印伺服器                                           Print-Server                   Available
    [ ] LPD 服務                                          Print-LPD-Service              Available
    [ ] 分散式掃描伺服器                                        Print-Scan-Server              Available
    [ ] 網際網路列印                                          Print-Internet                 Available
[ ] 傳真伺服器                                               Fax                            Available
[ ] 網頁伺服器 (IIS)                                         Web-Server                     Available
    [ ] 網頁伺服器                                           Web-WebServer                  Available
        [ ] 一般 HTTP 功能                                  Web-Common-Http                Available
            [ ] HTTP 錯誤                                 Web-Http-Errors                Available
            [ ] 預設文件                                    Web-Default-Doc                Available
            [ ] 靜態內容                                    Web-Static-Content             Available
            [ ] 瀏覽目錄                                    Web-Dir-Browsing               Available
            [ ] HTTP 重新導向                               Web-Http-Redirect              Available
            [ ] WebDAV 發行                               Web-DAV-Publishing             Available
        [ ] 安全性                                         Web-Security                   Available
            [ ] 要求篩選                                    Web-Filtering                  Available
            [ ] IIS 用戶端憑證對應驗證                           Web-Cert-Auth                  Available
            [ ] IP 及網域限制                                Web-IP-Security                Available
            [ ] URL 授權                                  Web-Url-Auth                   Available
            [ ] Windows 驗證                              Web-Windows-Auth               Available
            [ ] 用戶端憑證對應驗證                               Web-Client-Auth                Available
            [ ] 基本驗證                                    Web-Basic-Auth                 Available
            [ ] 集中式 SSL 憑證支援                            Web-CertProvider               Available
            [ ] 摘要式驗證                                   Web-Digest-Auth                Available
        [ ] 狀況及診斷                                       Web-Health                     Available
            [ ] HTTP 記錄                                 Web-Http-Logging               Available
            [ ] ODBC 記錄                                 Web-ODBC-Logging               Available
            [ ] 自訂記錄                                    Web-Custom-Logging             Available
            [ ] 要求監視器                                   Web-Request-Monitor            Available
            [ ] 記錄工具                                    Web-Log-Libraries              Available
            [ ] 追蹤                                      Web-Http-Tracing               Available
        [ ] 效能                                          Web-Performance                Available
            [ ] 靜態內容壓縮                                  Web-Stat-Compression           Available
            [ ] 動態內容壓縮                                  Web-Dyn-Compression            Available
        [ ] 應用程式開發                                      Web-App-Dev                    Available
            [ ] .NET 擴充性 3.5                            Web-Net-Ext                    Available
            [ ] .NET 擴充性 4.5                            Web-Net-Ext45                  Available
            [ ] ASP                                     Web-ASP                        Available
            [ ] ASP.NET 3.5                             Web-Asp-Net                    Available
            [ ] ASP.NET 4.5                             Web-Asp-Net45                  Available
            [ ] CGI                                     Web-CGI                        Available
            [ ] ISAPI 篩選器                               Web-ISAPI-Filter               Available
            [ ] ISAPI 擴充程式                              Web-ISAPI-Ext                  Available
            [ ] WebSocket 通訊協定                          Web-WebSockets                 Available
            [ ] 伺服器端包含                                  Web-Includes                   Available
            [ ] 應用程式初始化                                 Web-AppInit                    Available
    [ ] FTP 伺服器                                         Web-Ftp-Server                 Available
        [ ] FTP 服務                                      Web-Ftp-Service                Available
        [ ] FTP 擴充性                                     Web-Ftp-Ext                    Available
    [ ] 管理工具                                            Web-Mgmt-Tools                 Available
        [ ] IIS 管理主控台                                   Web-Mgmt-Console               Available
        [ ] IIS 6 管理相容性                                 Web-Mgmt-Compat                Available
            [ ] IIS 6 Metabase 相容性                      Web-Metabase                   Available
            [ ] IIS 6 WMI 相容性                           Web-WMI                        Available
            [ ] IIS 6 指令碼工具                             Web-Lgcy-Scripting             Available
            [ ] IIS 6 管理主控台                             Web-Lgcy-Mgmt-Console          Available
        [ ] IIS 管理指令碼及工具                                Web-Scripting-Tools            Available
        [ ] 管理服務                                        Web-Mgmt-Service               Available
[ ] 網路原則與存取服務                                           NPAS                           Available
    [ ] 網路原則伺服器                                         NPAS-Policy-Server             Available
    [ ] 主機認證授權通訊協定                                      NPAS-Host-Cred                 Available
    [ ] 健康情況登錄授權單位                                      NPAS-Health                    Available
[ ] 遠端存取                                                RemoteAccess                   Available
    [ ] DirectAccess 與 VPN (RAS)                        DirectAccess-VPN               Available
    [ ] Web Application Proxy                           Web-Application-Proxy          Available
    [ ] 路由                                              Routing                        Available
[ ] 遠端桌面服務                                              Remote-Desktop-Services        Available
    [ ] 遠端桌面 Web 存取                                     RDS-Web-Access                 Available
    [ ] 遠端桌面工作階段主機                                      RDS-RD-Server                  Available
    [ ] 遠端桌面授權                                          RDS-Licensing                  Available
    [ ] 遠端桌面連線代理人                                       RDS-Connection-Broker          Available
    [ ] 遠端桌面虛擬主機                                        RDS-Virtualization             Available
    [ ] 遠端桌面閘道                                          RDS-Gateway                    Available
[ ] 應用程式伺服器                                             Application-Server             Available
    [ ] .NET Framework 4.5                              AS-NET-Framework               Available
    [ ] COM+ 網路存取                                       AS-Ent-Services                Available
    [ ] TCP 連接埠共用                                       AS-TCP-Port-Sharing            Available
    [ ] Windows 處理程序啟動服務支援                              AS-WAS-Support                 Available
        [ ] HTTP 啟動                                     AS-HTTP-Activation             Available
        [ ] TCP 啟動                                      AS-TCP-Activation              Available
        [ ] 具名管道啟動                                      AS-Named-Pipes                 Available
        [ ] 訊息佇列啟動                                      AS-MSMQ-Activation             Available
    [ ] 分散式交易                                           AS-Dist-Transaction            Available
        [ ] WS-Atomic 交易                                AS-WS-Atomic                   Available
        [ ] 外寄網路交易                                      AS-Outgoing-Trans              Available
        [ ] 連入網路交易                                      AS-Incoming-Trans              Available
    [ ] 網頁伺服器 (IIS) 支援                                  AS-Web-Support                 Available
[X] 檔案和存放服務                                             FileAndStorage-Services        Installed
    [X] 存放服務                                            Storage-Services               Installed
    [ ] 檔案和 iSCSI 服務                                    File-Services                  Available
        [ ] 檔案伺服器                                       FS-FileServer                  Available
        [ ] DFS 命名空間                                    FS-DFS-Namespace               Available
        [ ] DFS 複寫                                      FS-DFS-Replication             Available
        [ ] iSCSI 目標存放提供者 (VDS 和 VSS 硬體提供者)             iSCSITarget-VSS-VDS            Available
        [ ] iSCSI 目標伺服器                                 FS-iSCSITarget-Server          Available
        [ ] Server for NFS                              FS-NFS-Service                 Available
        [ ] 工作資料夾                                       FS-SyncShareService            Available
        [ ] 重複資料刪除                                      FS-Data-Deduplication          Available
        [ ] 網路檔案的 BranchCache                           FS-BranchCache                 Available
        [ ] 檔案伺服器 VSS 代理程式服務                            FS-VSS-Agent                   Available
        [ ] 檔案伺服器資源管理員                                  FS-Resource-Manager            Available
[X] .NET Framework 3.5 功能                               NET-Framework-Features         Installed
    [X] .NET Framework 3.5 (包括 .NET 2.0 和 3.0)          NET-Framework-Core             Installed
    [ ] HTTP 啟用                                         NET-HTTP-Activation            Available
    [ ] 非 HTTP 啟用                                       NET-Non-HTTP-Activ             Available
[X] .NET Framework 4.5 功能                               NET-Framework-45-Fea...        Installed
    [X] .NET Framework 4.5                              NET-Framework-45-Core          Installed
    [ ] ASP.NET 4.5                                     NET-Framework-45-ASPNET        Available
    [X] WCF 服務                                          NET-WCF-Services45             Installed
        [ ] HTTP 啟用                                     NET-WCF-HTTP-Activat...        Available
        [ ] TCP 啟用                                      NET-WCF-TCP-Activati...        Available
        [X] TCP 連接埠共用                                   NET-WCF-TCP-PortShar...        Installed
        [ ] 具名管道啟用                                      NET-WCF-Pipe-Activat...        Available
        [ ] 訊息佇列 (MSMQ) 啟用                              NET-WCF-MSMQ-Activat...        Available
[ ] BitLocker 磁碟機加密                                     BitLocker                      Available
[ ] BitLocker 網路解除鎖定                                    BitLocker-NetworkUnlock        Available
[ ] BranchCache                                         BranchCache                    Available
[ ] Client for NFS                                      NFS-Client                     Available
[ ] Direct Play                                         Direct-Play                    Available
[ ] IP 位址管理 (IPAM) 伺服器                                  IPAM                           Available
[ ] iSNS Server 服務                                      ISNS                           Available
[ ] LPR 連接埠監視器                                          LPR-Port-Monitor               Available
[ ] RAS 連線管理員系統管理組件 (CMAK)                              CMAK                           Available
[ ] RPC over HTTP Proxy                                 RPC-over-HTTP-Proxy            Available
[X] SMB 1.0/CIFS 檔案共用支援                                 FS-SMB1                        Installed
[ ] SMB Bandwidth Limit                                 FS-SMBBW                       Available
[ ] SMTP  伺服器                                           SMTP-Server                    Available
[ ] SNMP Service                                        SNMP-Service                   Available
    [ ] SNMP WMI Provider                               SNMP-WMI-Provider              Available
[ ] Telnet 用戶端                                          Telnet-Client                  Available
[ ] Telnet 伺服器                                          Telnet-Server                  Available
[ ] TFTP 用戶端                                            TFTP-Client                    Available
[ ] Windows Feedback Forwarder                          WFF                            Available
[ ] Windows Identity Foundation 3.5                     Windows-Identity-Fou...        Available
[X] Windows PowerShell                                  PowerShellRoot                 Installed
    [X] Windows PowerShell 4.0                          PowerShell                     Installed
    [X] Windows PowerShell 2.0 引擎                       PowerShell-V2                  Installed
    [X] Windows PowerShell ISE                          PowerShell-ISE                 Installed
    [ ] Windows PowerShell Web 存取                       WindowsPowerShellWeb...        Available
    [ ] Windows PowerShell 預期設定狀態服務                     DSC-Service                    Available
[ ] Windows Search 服務                                   Search-Service                 Available
[ ] Windows Server Backup                               Windows-Server-Backup          Available
[ ] Windows Server 移轉工具                                 Migration                      Available
[ ] Windows TIFF IFilter                                Windows-TIFF-IFilter           Available
[ ] Windows 內部資料庫                                       Windows-Internal-Dat...        Available
[ ] Windows 生物特徵辨識架構                                    Biometric-Framework            Available
[ ] Windows 處理序啟用服務                                     WAS                            Available
    [ ] 處理序模型                                           WAS-Process-Model              Available
    [ ] .NET 環境 3.5                                     WAS-NET-Environment            Available
    [ ] 設定 API                                          WAS-Config-APIs                Available
[ ] Windows 標準式存放裝置管理                                   WindowsStorageManage...        Available
[ ] WinRM IIS 擴充功能                                      WinRM-IIS-Ext                  Available
[ ] WINS 伺服器                                            WINS                           Available
[X] WoW64 支援                                            WoW64-Support                  Installed
[ ] XPS 檢視器                                             XPS-Viewer                     Available
[ ] 可裝載 IIS 的網頁核心                                       Web-WHC                        Available
[ ] 多重路徑 I/O                                            Multipath-IO                   Available
[X] 使用者介面與基礎結構                                          User-Interfaces-Infra          Installed
    [X] 圖形化管理工具與基礎結構                                    Server-Gui-Mgmt-Infra          Installed
    [X] 伺服器圖形化殼層                                        Server-Gui-Shell               Installed
    [ ] 桌面體驗                                            Desktop-Experience             Available
[ ] 背景智慧型傳送服務 (BITS)                                    BITS                           Available
    [ ] IIS 伺服器擴充功能                                     BITS-IIS-Ext                   Available
    [ ] Compact Server                                  BITS-Compact-Server            Available
[ ] 容錯移轉叢集                                              Failover-Clustering            Available
[ ] 訊息佇列                                                MSMQ                           Available
    [ ] 訊息佇列服務                                          MSMQ-Services                  Available
        [ ] 訊息佇列伺服器                                     MSMQ-Server                    Available
        [ ] HTTP 支援                                     MSMQ-HTTP-Support              Available
        [ ] 目錄服務整合                                      MSMQ-Directory                 Available
        [ ] 多點傳送支援                                      MSMQ-Multicasting              Available
        [ ] 訊息佇列觸發程序                                    MSMQ-Triggers                  Available
        [ ] 路由服務                                        MSMQ-Routing                   Available
    [ ] 訊息佇列 DCOM Proxy                                 MSMQ-DCOM                      Available
[ ] 高品質 Windows 音訊/視訊體驗                                 qWave                          Available
[ ] 媒體基礎                                                Server-Media-Foundation        Available
[ ] 無線區域網路服務                                            Wireless-Networking            Available
[ ] 筆跡和手寫服務                                             InkAndHandwritingSer...        Available
[ ] 群組原則管理                                              GPMC                           Available
[ ] 資料中心橋接                                              Data-Center-Bridging           Available
[ ] 對等名稱解析通訊協定                                          PNRP                           Available
[ ] 管理 OData IIS 擴充功能                                   ManagementOdata                Available
[ ] 網路負載平衡                                              NLB                            Available
[ ] 網際網路列印用戶端                                           Internet-Print-Client          Available
[ ] 遠端伺服器管理工具                                           RSAT                           Available
    [ ] 功能管理工具                                          RSAT-Feature-Tools             Available
        [ ] SMTP 伺服器工具                                  RSAT-SMTP                      Available
        [ ] BitLocker 磁碟機加密管理公用程式                       RSAT-Feature-Tools-B...        Available
            [ ] BitLocker 修復密碼檢視器                       RSAT-Feature-Tools-B...        Available
            [ ] BitLocker 磁碟機加密工具                       RSAT-Feature-Tools-B...        Available
        [ ] BITS 伺服器擴充功能工具                              RSAT-Bits-Server               Available
        [ ] IP 位址管理 (IPAM) 用戶端                          IPAM-Client-Feature            Available
        [ ] SNMP 工具                                     RSAT-SNMP                      Available
        [ ] WINS 伺服器工具                                  RSAT-WINS                      Available
        [ ] 容錯移轉叢集工具                                    RSAT-Clustering                Available
            [ ] Windows PowerShell 的容錯移轉叢集模組            RSAT-Clustering-Powe...        Available
            [ ] 容錯移轉叢集管理工具                              RSAT-Clustering-Mgmt           Available
            [ ] 容錯移轉叢集自動化伺服器                            RSAT-Clustering-Auto...        Available
            [ ] 容錯移轉叢集命令介面                              RSAT-Clustering-CmdI...        Available
        [ ] 網路負載平衡工具                                    RSAT-NLB                       Available
    [ ] 角色管理工具                                          RSAT-Role-Tools                Available
        [ ] AD DS 及 AD LDS 工具                           RSAT-AD-Tools                  Available
            [ ] AD DS 工具                                RSAT-ADDS                      Available
                [ ] Active Directory 管理中心               RSAT-AD-AdminCenter            Available
                [ ] AD DS 嵌入式管理單元及命令列工具                 RSAT-ADDS-Tools                Available
                [ ] NIS 工具的伺服器 [已過時]                    RSAT-NIS                       Available
            [ ] AD LDS 嵌入式管理單元及命令列工具                    RSAT-ADLDS                     Available
            [ ] Windows PowerShell 的 Active Director... RSAT-AD-PowerShell             Available
        [ ] Hyper-V 管理工具                                RSAT-Hyper-V-Tools             Available
            [ ] Hyper-V GUI 管理工具                        Hyper-V-Tools                  Available
            [ ] 適用於 Windows PowerShell 的 Hyper-V 模組     Hyper-V-PowerShell             Available
        [ ] Windows Server Update Services 工具           UpdateServices-RSAT            Available
            [ ] API 和 PowerShell Cmdlet                 UpdateServices-API             Available
            [ ] 使用者介面管理主控台                              UpdateServices-UI              Available
        [ ] 遠端桌面服務工具                                    RSAT-RDS-Tools                 Available
            [ ] 遠端桌面授權工具                                RDS-Licensing-UI               Available
            [ ] 遠端桌面授權診斷程式工具                            RSAT-RDS-Licensing-D...        Available
            [ ] 遠端桌面閘道工具                                RSAT-RDS-Gateway               Available
        [ ] Active Directory Rights Management Servi... RSAT-ADRMS                     Available
        [ ] Active Directory 憑證服務工具                     RSAT-ADCS                      Available
            [ ] 線上回應工具                                  RSAT-Online-Responder          Available
            [ ] 憑證授權單位管理工具                              RSAT-ADCS-Mgmt                 Available
        [ ] DHCP 伺服器工具                                  RSAT-DHCP                      Available
        [ ] DNS 伺服器工具                                   RSAT-DNS-Server                Available
        [ ] Windows 部署服務工具                              WDS-AdminPack                  Available
        [ ] 大量啟用工具                                      RSAT-VA-Tools                  Available
        [ ] 列印和文件服務工具                                   RSAT-Print-Services            Available
        [ ] 傳真伺服器工具                                     RSAT-Fax                       Available
        [ ] 網路原則與存取服務工具                                 RSAT-NPAS                      Available
        [ ] 遠端存取管理工具                                    RSAT-RemoteAccess              Available
            [ ] Windows PowerShell 的遠端存取模組              RSAT-RemoteAccess-Po...        Available
            [ ] 遠端存取 GUI 和命令列工具                         RSAT-RemoteAccess-Mgmt         Available
        [ ] 檔案服務工具                                      RSAT-File-Services             Available
            [ ] DFS 管理工具                                RSAT-DFS-Mgmt-Con              Available
            [ ] 共用與存放管理工具                               RSAT-CoreFile-Mgmt             Available
            [ ] 網路檔案系統管理工具的服務                           RSAT-NFS-Admin                 Available
            [ ] 檔案伺服器資源管理員工具                            RSAT-FSRM-Mgmt                 Available
[ ] 遠端協助                                                Remote-Assistance              Available
[ ] 遠端差異壓縮                                              RDC                            Available
[ ] 增強的存放區                                              EnhancedStorage                Available
[ ] 簡單 TCP/IP 服務                                        Simple-TCPIP                   Available



PS C:\Users\Administrator> 
      '