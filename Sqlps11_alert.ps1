<#  Sqlps11_alert

C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps11_alert.ps1CreateDate: Jan.02.2013LastDate : APR.27.2014Author :Ming Tseng  ,a0921887912@gmail.comremark  history :  object :   事件會由 SQL Server 產生，並輸入 Microsoft Windows 應用程式記錄檔中。  SQL Server Agent 會讀取應用程式記錄檔，然後比較寫入其中的事件與您所定義的警示。  當 SQL Server Agent 找到相符項目時，即會發出警示，這是對事件的自動回應。   除了監視 SQL Server 事件以外， SQL Server Agent 還可以監視效能條件與 Windows Management Instrumentation (WMI) 事件。#># (1)  Get alert   --http://technet.microsoft.com/zh-tw/library/ms186933.aspx# (2)  Setting up Database Mail using SMO  P168# (3) 200 Adding / Running a SQL Server event alert  p187# (1)  Get alert # (2)  Setting up Database Mail using SMO  P168# (3) 200  Adding / Running a SQL Server event alert  p187#---------------------------------------------------------------# (1)  Get alert   --http://technet.microsoft.com/zh-tw/library/ms186933.aspx#---------------------------------------------------------------USE msdb  EXEC sp_help_alert @order_by=N'id'name:警示名稱 ,event_source事件的來源enabled 目前的狀態是啟用警示 (1) 或未啟用警示 (0)message_id  定義警示的訊息錯誤號碼。 (它通常對應於 sysmessages 資料表中的錯誤號碼)last_occurrence_date 警示上次發生的日期,last_occurrence_time警示上次發生的時間occurrence_count 警示的發生次數job_id ,job_name 當回應這個警示時，所執行的作業名稱has_notification 向一或多個操作員通知(1=有電子郵件通知,2=有呼叫器通知,4=有 net send 通知)#---------------------------------------------------------------# (2)  Setting up Database Mail using SMO  P168#---------------------------------------------------------------{<###parameterMail Server:mail.queryworks.localMail Server Port:25Email Address for Database Mail Profile:dbmail@queryworks.localSMTP Authentication :Basic authenticationCredentials for Email Address:Username: dbmail@queryworks.local  ,Password: <somepassword>##(1). Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
(2). Import the SQLPS module and create a new SMO Server object, as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName(3)enable DatabaseMail
#this is similar to an sp_configure TSQL command
$server.Configuration.DatabaseMailEnabled.ConfigValue = 1
$server.Configuration.Alter()
$server.Refresh()#set up account
$accountName = "DBMail"
$accountDescription = "QUERYWORKS Database Mail"
$displayName = "QUERYWORKS mail"
$emailAddress = "dbmail@queryworks.local"
$replyToAddress = "dbmail@queryworks.local"
$mailServerAddress = "mail.queryworks.local"
$account = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Mail.MailAccount -ArgumentList $server.Mail, $accountName,
$accountDescription, $displayName, $emailAddress
$account.ReplyToAddress = $replyToAddress
$account.Create()(4)Check the settings that have been changed from SQL Server Management Studio:
1. Open SQL Server Management Studio.
2. Expand the Management node.
3. Right-click on Database Mail and choose Configure Database Mail.4. In the Select Configuration Task window, select the Manage Database Mail accounts and profiles radio button.5. In the Manage Profiles and Accounts window, select the View, change, or delete an existing account option.6. Visually check the Manage Existing Account page. See what settings have been saved from executing your PowerShell script. Notice that in the SMTP authentication section, Anonymous Authentication has been selected by default.(5). Click on Cancel to exit the wizard and go back to PowerShell ISE.##(6)default mail server that was saved in the previous script
#was the server name, we need to change this to the
#appropriate mail server
$mailserver = $account.MailServers[$instanceName]
$mailserver.Rename($mailServerAddress)
$mailserver.Alter()
#default SMTP authentication is Anonymous Authentication
#set propert authentication
$mailserver.SetAccount("dbmail@queryworks.local", "some password")
$mailserver.Port = 25
$mailserver.Alter()(7) Check the Manage Existing Account window from Management Studio again.Check if these new settings have been saved.(8)Click on Cancel to exit the wizard and go back to PowerShell ISE.(9)Add the following script and run:
#create a profile
$profileName = "DB Mail Profile"
$profileDescription= "DB Mail Description"
if($mailProfile)
{
$mailProfile.Drop()
}$mailProfile = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Mail.MailProfile -ArgumentList $server.Mail,
$profileName, $profileDescription
$mailProfile.Create()
$mailProfile.Refresh()(10) Check the settings from SQL Server Management Studio1. Go back to the Manage Profiles and Accounts window, but this time select View, change, or delete an existing profile.
2. Visually check the Manage Existing Profile page. Notice that, apart from the name and description, the window is still fairly empty.(11) Click on Cancel to exit the wizard and go back to your PowerShell ISE.(12). Add the following script and run:
#add account to the profile
$mailProfile.AddAccount($accountName, 0)
$mailProfile.AddPrincipal('public', 1)
$mailProfile.Alter()(13). Check the settings from SQL Server Management Studio:
1. Go back to the Manage Profiles and Accounts window, but this time selectView, change, or delete an existing profile.
2. Visually check the Manage Profile Security page. Notice the default profile that has been saved.(14). Click on Cancel to exit the wizard and go back to your PowerShell ISE.
(15). Add the following script and run:
#link this mail profile to SQL Server Agent
$server.JobServer.AgentMailType = 'DatabaseMail'
$server.JobServer.DatabaseMailProfile = $profileName
$server.JobServer.Alter()
#restart SQL Server Agent
$managedComputer = New-Object 'Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer' $instanceName
$servicename = "SQLSERVERAGENT"
$service = $managedComputer.Services[$servicename]
$service.Stop()
$service.Start()
(16). Check settings from Management Studio:
1. Right-click on SQL Server Agent and go to Properties.
2. Click on Alert System from the left-hand pane.3. Check the settings. The Enable mail profile option should be checked(17). Manually test sending an e-mail. Right-click on Database Mail and choose Send
Test E-mail, as shown in the following screenshot:(18)Check your mail client to see if you have received the e-mail.#>}#---------------------------------------------------------------# (3) 200  Adding / Running a SQL Server event alert  p187#---------------------------------------------------------------{<#
##--adding
(1. Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.

(2. Import the SQLPS module and create a new SMO Server object, as follows: 
#import SQL Server module
Import-Module SQLPS -DisableNameChecking


#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3. Add the following script and run:
$jobserver = $server.JobServer

#for purposes of our exercise, we will drop this
#alert if it already exists
$alertname = "Test Alert"
$alert = $jobserver.Alerts[$alertname]if($alert)
{
$alert.Drop()
}
#accepts a JobServer and an alert name
$alert = New-Object Microsoft.SqlServer.Management.Smo.Agent.Alert $jobserver, "Test Alert"
$alert.Severity = 10#Raise Alert when Message contains
$alert.EventDescriptionKeyword = "failed"
#Set notification message
$alert.NotificationMessage = "This is a test alert, dont worry"
$alert.Create()##There's more...'SQL Server provides a mechanism to alert DBAs and other database staff of possible issues
or thresholds reached by the instances. 
If you navigate to SQL Server Agent and expand Alerts, you should see all the alerts set up in your instance' http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.agent.alert(v=sql.110).aspxThis table summarizes the types of alerts you can set up in SQL Server:Alert type                             DescriptionSQL Server event alert                 :Typically used for specific error numbers, severity, or keywords that exist in the error message.SQL Server performance condition alert :Typically set up if a performance threshold is reached. For example, if data file size exceeds 100 GB.WMI event alert                        :Used for WMI events that you want to flag within SQL Server. For example, if you want to monitor if a file gets created, or a deadlock is detected in one of the instances.##--Runing  p1903. Add the following script and run:
$jobserver = $server.JobServer
$jobname ="Test Job"
$job = $jobserver.Jobs[$jobname]
$job.Start()
#sleep to wait for job to finish
#check last run date
Start-Sleep-s1
$job.Refresh()
$job.LastRunDate#>}#---------------------------------------------------------------#   Temp#---------------------------------------------------------------#---------------------------------------------------------------#   Temp#---------------------------------------------------------------#---------------------------------------------------------------#   Temp#---------------------------------------------------------------#---------------------------------------------------------------#   Temp#---------------------------------------------------------------#---------------------------------------------------------------#   Temp#---------------------------------------------------------------http://technet.microsoft.com/zh-tw/library/ms180982.aspx您可以指定一個為回應特定效能條件而產生的警示。 此時您必須指定所要監視的效能計數器、警示的臨界值以及計數器在警示產生時必須顯示的行為。 若要設定效能條件，您必須在 SQL Server Agent 的 [一般] 頁面上定義 [新增警示] 或 [警示屬性] 對話方塊中的下列項目：
物件
此物件為要監視的效能區域。
計數器
計數器是要監視之區域的屬性。
執行個體
SQL Server 執行個體可為要監視的屬性定義特定的執行個體 (如果有的話)。
如果是計數器和值則發出警示
警示的臨界值和產生警示的行為。 臨界值是一個數值。 此行為是下列其中一項：低於、變成等於 或 高於在 [值] 中指定的數值。 [值] 是一個描述效能行況計數器的數值。 例如，若要設定警示在效能物件 SQLServer:Locks 的 Lock Wait Time 超過 30 分鐘時產生，您就必須選擇 [高於]，並指定 30 為[值]。
至於另一個範例，您可以指定效能物件 SQLServer:Transactions 在 tempdb 中的可用空間低於 1000 KB 時發出警示。 若要進行此設定，您必須選擇計數器 Free space in tempdb (KB)、低於，並在 [值] 中指定 1000。#---------------------------------------------------------------#   alert for replication default#---------------------------------------------------------------Warn if a subscription will expire within the threshold若訂閱將在臨界值內過期，就發出警告Warn if latency exceeds the threshold.若延遲超過臨界值，就發出警告alertReplication Warning: Long merge over dialup connection (Threshold: mergeslowrunduration)Replication Warning: Long merge over LAN connection (Threshold: mergefastrunduration)  14162#---------------------------------------------------------------#   Temp#---------------------------------------------------------------