<#-----------------------------------
#  remote   SP07_SP13BackupRestore

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SP07_BackupRestore.ps1.ps1
C:\Users\administrator.CSD\OneDrive\download\PS1\SP07_SP13BackupRestore.ps1
#Date:  release
#last update :  


powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX18_ACERSharePoint.ps1

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SP07_BackupRestore.ps1

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

cluadmin.msc


ping sql2014x  -t
ping sp2013


icm -ComputerName  sp2013  -ScriptBlock  whoami

https://technet.microsoft.com/zh-tw/library/ee428316.aspx   在 SharePoint 2013 中備份伺服器陣列

#--------------------------------------------
#   SPConfigurationDatabase
#--------------------------------------------


New-SPConfigurationDatabase

Connect-SPConfigurationDatabase

Remove-SPConfigurationDatabase

Disconnect-SPConfigurationDatabase 

#Backup-SPConfigurationDatabase
    Backup-SPConfigurationDatabase -ShowTree

    $backupSPFarm='H:\sharepointbackup\bkSPFarm_61'
    md $backupSPConfDB ;ii $backupSPConfDB
    $backupSPConfDB='H:\sharepointbackup\bkSPconfDB_61'
    Backup-SPConfigurationDatabase -DatabaseName 'SQL2012X_ConfigDB' -DatabaseServer 'SPFarmSQL' -Directory $backupSPConfDB 
# Get-SPBackupHistory  -Directory $backupSPConfDB  先找出要還原ID , 可以從備份目錄中地 spbrtoc.xml 找出備份時間

Restore-SPFarm -Directory $backupSPConfDB -BackupId 776f6ef3-bc16-423d-be2f-022ed6f71f56 -RestoreMethod new -ConfigurationOnly  -confirm:$false

#--------------------------------------------
#   Backup-SPFarm 
#--------------------------------------------
$backupSPFarm='H:\sharepointbackup\bkSPFarm_61'
Get-SPBackupHistory  -Directory $backupSPFarm

Backup-SPFarm -ShowTree
伺服器陣列\
        [SQL2012X_ConfigDB]\
        InfoPath Forms Services\
            設定\
            資料連線\
            表單範本\
            免除使用者代理程式\
                [crawler]\
                [googlebot]\
                [ms search]\
                [msnbot]\
                [msoffice]\
                [slurp]\
        功能對應的授權\
        SharePoint Server State Service\
        Microsoft SharePoint Foundation Web 應用程式\
            SharePoint - ap1.csd.syscom80\
                WSS_Content_AP1\
                [計時器工作群組]\
        [WSS_Administration]\
            [SharePoint Central Administration v4]\
                SharePoint_AdminContent_6b845c0d-071a-4217-8b3f-ea5d3cf8218e\
        SharePoint Server State Service Proxy\
        SPUserCodeV4\
            [使用常用的沙箱化程式碼負載平衡器提供者]\
            [「資源度量」群組。]\
            [「執行層」群組。]\
        [Microsoft SharePoint Server 診斷服務]\
        全域搜尋設定\
        [工作流程服務 Proxy]\
        [Microsoft.Ceres.Diagnostics.Administration.DiagnosticsService]\
        [Microsoft SharePoint Foundation 診斷服務]\
        共用服務\
            共用服務應用程式\
                SecurityTokenServiceApplication\
                    ClaimEncodingManager\
                    SecurityTokenServiceManager\
                    ClaimProviderManager\

	[ ] - item cannot be selected.
	 *   - not selected to be backed up.

#--------------------------------------------
#   在 SharePoint 2013 中備份伺服器陣列  使用 Windows PowerShell
#--------------------------------------------



#--------------------------------------------
#   在 SharePoint 2013 中備份伺服器陣列  使用管理中心備份
#--------------------------------------------



#--------------------------------------------
#   在 SharePoint 2013 中備份伺服器陣列  使用 SQL Server 工具
#--------------------------------------------




#--------------------------------------------
#   (0) 備份及還原  https://technet.microsoft.com/zh-tw/library/ee662536.aspx
#--------------------------------------------
設定備份及還原權限  

備份

還原

#--------------------------------------------
#  (1)權限  https://technet.microsoft.com/zh-tw/library/ee662536.aspx
#--------------------------------------------
設定備份及還原權限   #https://technet.microsoft.com/zh-tw/library/ee748614.aspx
    管理員可以使用 Add-SPShellAdmin Cmdlet 授與使用 SharePoint 2013 產品 Cmdlet 的權限
    Add-SPShellAdmin -Username <User account> -Database <Database ID>

檢視使用者帳戶
     ForEach ($db in Get-SPDatabase) {Get-SPShellAdmin -Database $db}

新增使用者帳戶

    Get-SPDatabase

    Add-SPShellAdmin -Username <User account> -Database <Database ID>
    
    ForEach ($db in Get-SPDatabase) {Add-SPShellAdmin -Username csd\infrax -Database $db}

移除使用者帳戶

ForEach ($db in Get-SPDatabase) {Remove-SPShellAdmin -Username csd\infra1  -Database $db  -Confirm:$false }



其他必要的權限

伺服器陣列元件
伺服器陣列
服務應用程式
內容資料庫
網站集合
網站、清單、文件庫

#--------------------------------------------
#  (2)備份  https://technet.microsoft.com/zh-tw/library/ee428315.aspx
#--------------------------------------------

#2.1 備份伺服器陣列
$backupSPFarm='H:\sharepointbackup\bkSPFarm_61'
md  $backupSPFarm
$t1=get=date
Backup-SPFarm -Directory $backupSPFarm  -BackupMethod Full
$t2=get=date;($t2-$t1)


#2.2 Back up a farm configuration

Backup-SPConfigurationDatabase -Directory <BackupFolder> -DatabaseServer <DatabaseServerName> 
-DatabaseName <DatabaseName> 
-DatabaseCredentials <WindowsPowerShellCredentialObject> [-Verbose]


#--------------------------------------------
#     備份 及 還原   SharePoint伺服器陣列  作法   
#--------------------------------------------
{<#
AP1  DB1

AP2  DB2 :

將AP1/DB1 設定資料庫還原在 AP2/DB2


#(1)先建立AP1 configureDB 設定資料庫名稱是 SQL2012X_ConfigDB

$AliasName = "SPFarmSQL"
Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

$DatabaseServer = “SPFarmSQL” ;
$ConfigDB = "SQL2012X_ConfigDB";
$AdminContentDB = "SQL2012X_CentralAdminContent";
$Passphrase = convertto-securestring "p@ssw0rdx" -asplaintext -force;
$Port = "2013";
$Authentication = "NTLM";
$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "csd\infrax",$secpasswd

New-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer `
-FarmCredentials (Get-Credential $credential) -Passphrase $Passphrase `
-AdministrationContentDatabaseName $AdminContentDB

Get-SPFarm #檢視是否有連接 SQL2012X_ConfigDB
(2)建立 CentralAdmin web site (管理網站).port:2013

$t1=get-date
New-SPCentralAdministration -Port $Port -WindowsAuthProvider 'NTLM'
$t2=get-date; $t2-$t1
Get-SPWebApplication -IncludeCentralAdministration

(3)檢視是可登入管理網站

(4)備份資料庫 在DB1 SQL2012X_ConfigDB &amp; SQL2012X_CentralAdminContent

Backup DB

backup database SQL2012X_ConfigDB to disk='\\SP2013\sharepointDBbackup\SQL2012X_ConfigDB.bak';
backup database SQL2012X_CentralAdminContent to disk='\\SP2013\sharepointDBbackup\SQL2012X_CentralAdminContent.bak';

(5)還原資料庫在DB2 注意還原路徑

restore database SQL2012X_ConfigDB from disk='\\SP2013\sharepointDBbackup\SQL2012X_ConfigDB.bak';
with replace,recovery,
move ';SQL2012X_ConfigDB' to 'H:\SQLDATA_I2\SQL2012X_ConfigDB.mdf';,
move ';SQL2012X_ConfigDB_log' to 'H:\SQLDATA_I2\SQL2012X_ConfigDB_log.ldf';

restore database SQL2012X_CentralAdminContent from
disk='\\SP2013\sharepointDBbackup\SQL2012X_CentralAdminContent.bak'
with replace,recovery,
move 'SQL2012X_CentralAdminContent' to 'H:\SQLDATA_I2\SQL2012X_CentralAdminContent.mdf',
move 'SQL2012X_CentralAdminContent_log' to 'H:\SQLDATA_I2\SQL2012X_CentralAdminContent_log.ldf'


(6) AP2 連接設定資料庫 (為SQL2012X_ConfigDB)

$AliasName = "SPFarmSQL"
Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

$DatabaseServer = “SPFarmSQL” ;
$ConfigDB = "SQL2012X_ConfigDB";
$AdminContentDB = "SQL2012X_CentralAdminContent";
$Passphrase = convertto-securestring "p@ssw0rdx" -asplaintext -force;

$Port = "2013";
$Authentication = "NTLM";

Connect-SPConfigurationDatabase -DatabaseName $ConfigDB -DatabaseServer $DatabaseServer -Passphrase  $Passphrase
get-spfarm


Remove-SPCentralAdministration

(7)建立 CentralAdmin web site (管理網站).port:2013

Remove-SPCentralAdministration  #先刪除原有

$t1=get-date
New-SPCentralAdministration -Port $Port -WindowsAuthProvider 'NTLM'
$t2=get-date; $t2-$t1 #

#>}




#--------------------------------------------
#  
#--------------------------------------------
還原
