<#
ii C:\WorkLog\BOP\Proposal_Kickoff
ii c:\worklog\kmuh2022

ii c:\worklog\ibus2022


OS00_Index
filelocation : st
C:\Users\User\OneDrive\download\PS1\OS00_Index.ps1
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS00_Index.ps1
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS00_Index.ps1

Github  
     D:\ps1backup  
     https://github.com/Ming-Tseng/ps1.git
     
CreateDate:  APR.30.2014
LastDate :   AUG.11.2015
Author :Ming Tseng  ,a0921887912@gmail.com

ii  C:\Users\User\OneDrive\download\PS1

remark 

C:\WorkLog\UltraEdit_14\Uedit32.exe          #-----------------------------------------Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32

mstsc
ipconfig
ncpa.cp
ping 172.16.220.254
ping 172.16.220.49

ping 172.16.220.151
ping 172.16.220.154

trimspace  source code here 
{<#



function trimspace ($ss){
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
}


#>}

https://www.sqlshack.com/how-to-deploy-ssas-cubes/  #deploy SSAS cubes

start  http://www.aspphp.online/shujuku/sqlserversjk/gysqlserver/
start  https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/begin-transaction-transact-sql?view=sql-server-ver16  # Managing SQL Server Workloads with Resource Governor
start  https://www.sqlshack.com/sql-server-monitoring-tool-for-cpu-performance/ 
start  https://www.bleepingcomputer.com/tutorials/list-services-running-under-svchostexe-process/  #How to determine what services are running under a SVCHOST.EXE process
start  https://q.cnblogs.com/q/31681/   #sql压力巨大，CPU占用100%，求性能指教
https://stackoverflow.com/questions/36333505/is-there-a-way-to-clear-the-connection-pool-for-dbconnection     #Is there a way to clear the connection pool for DbConnection?
start http://www.aspphp.online/shujuku/sqlserversjk/gysqlserver/201701/71868.html    #SqlServer如何通過SQL語句獲取處理器(CPU)、內存（Memory）、磁盤（Disk）以及操作系統相關信息
start https://answers.microsoft.com/en-us/windows/forum/all/how-to-schedule-windows-update-downloads/41441941-046c-4f5b-afb5-2ccd6ca566e2  # How to schedule Windows Update Downloads
start https://answers.microsoft.com/en-us/windows/forum/all/abnormally-high-cpu-usage-from-svchostexe-solved/eb38d25d-6bb2-47cd-80f2-5389c62337be  #Abnormally high CPU usage from svchost.exe

start https://support.microsoft.com/en-us/topic/kb4338890-fix-non-yielding-scheduler-error-and-sql-server-appears-unresponsive-in-sql-server-2014-2016-and-2017-531a3518-df07-30a8-c789-c6b294c5f4f1 #KB4338890 - FIX: "Non-yielding Scheduler" error and SQL Server appears unresponsive in SQL Server 2014, 2016 and 2017
 #易宝典：SVCHOST.EXE进程的有关说明及占用资源高的解决方案(MVP 撰稿)
start https://support.microsoft.com/zh-cn/topic/%E6%98%93%E5%AE%9D%E5%85%B8-svchost-exe%E8%BF%9B%E7%A8%8B%E7%9A%84%E6%9C%89%E5%85%B3%E8%AF%B4%E6%98%8E%E5%8F%8A%E5%8D%A0%E7%94%A8%E8%B5%84%E6%BA%90%E9%AB%98%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88-mvp-%E6%92%B0%E7%A8%BF-518057b1-0f7a-f967-26ec-9777e46eb047  

#Powershell to find which service runs under which svchost process
start https://social.technet.microsoft.com/Forums/en-US/ee950af0-8708-4ad1-b1fc-83456d377c0a/powershell-to-find-which-service-runs-under-which-svchost-process?forum=win10itprohardware
start https://www.sqlshack.com/dont-fear-sql-server-performance-tuning/   #Don’t fear SQL Server performance tuning

 #Tuning ‘cost threshold for parallelism’ from the Plan Cache
start https://www.sqlskills.com/blogs/jonathan/tuning-cost-threshold-for-parallelism-from-the-plan-cache/
 
start https://docs.microsoft.com/zh-tw/sql/database-engine/configure-windows/configure-the-max-worker-threads-server-configuration-option?view=sql-server-ver16 #設定 max worker threads 伺服器組態選項

start https://stackoverflow.com/questions/670774/how-can-i-solve-a-connection-pool-problem-between-asp-net-and-sql-server  #How can I solve a connection pool problem between ASP.NET and SQL Server

start https://bobcares.com/blog/powershell-error-clear/  #PowerShell $Error clear – How to use it
start https://blog.poychang.net/using-exception-messages-with-try-catch-in-powershell/  # 在 PowerShell 中使用 Try/Catch 捕捉錯誤訊息
start https://jeffbrown.tech/using-exception-messages-with-try-catch-in-powershell/  #Mastering PowerShell Try Catch with Exception Messages
start https://jeffbrown.tech/using-exception-messages-with-try-catch-in-powershell/  #Understanding PowerShell Try Catch Syntax
 
start https://stackoverflow.com/questions/54899002/sql-queries-as-a-transaction-in-powershell  #SQL Queries as a Transaction in Powershell
start https://stackoverflow.com/questions/71655563/sqlclient-equivalent-of-begin-try-end-try  #SqlClient equivalent of "BEGIN TRY...END TRY"

https://docs.microsoft.com/zh-tw/dotnet/framework/data/adonet/sql-server-connection-pooling  #SQL Server 連接共用 (ADO.NET)
https://www.cnblogs.com/eaglet/archive/2011/10/31/2230197.html  
https://ithelp.ithome.com.tw/articles/10210068  #SQL 資料庫 Connection Pool 連線池觀念釐清

https://en.dirceuresende.com/blog/sql-server-how-to-identify-timeout-or-broken-connections-using-extended-events-xe-or-sql-profiler-trace/  #How to identify timeout or broken connections using Extended Events (XE) or SQL Profiler (Trace)
https://en.dirceuresende.com/blog/sql-server-how-to-identify-and-collect-time-consuming-query-information-using-extended-events-xe/         #SQL Server - How to identify and collect time consuming query information using Extended Events (XE)
https://docs.microsoft.com/zh-tw/troubleshoot/sql/performance/troubleshoot-query-timeouts#query-time-out-is-not-the-same-as-connection-time-out #針對查詢逾時錯誤進行疑難排解
https://forums.ni.com/t5/LabWindows-CVI/SQL-Toolkit-2-2-MS-SQL-Server-How-to-set-connection-timeout/td-p/4129342  #MS SQL Server - How to set connection timeout?

https://blog.darkthread.net/blog/sql-conn-pooling-experiment/  #SQL Connection Pooling 行為觀察
https://docs.microsoft.com/zh-tw/dotnet/framework/data/adonet/ole-db-odbc-and-oracle-connection-pooling   #OLE DB、ODBC 和 Oracle 連接共用
#輕量型共用伺服器組態選項
https://docs.microsoft.com/zh-tw/sql/database-engine/configure-windows/lightweight-pooling-server-configuration-option?view=sql-server-ver16


https://www.huanlintalk.com/2012/05/net-connection-pool.html  #.NET Connection Pool 與連線相關問題整理
https://dotblogs.com.tw/ricochen/2015/11/11/153886            #[SQL SERVER]找出SQL Server效能問題
   #Collecting .NET Data Provider for SqlServer performance counter data
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/1bf14a44-59a8-4e96-97fe-49a94912b8b3/collecting-net-data-provider-for-sqlserver-performance-counter-data?forum=ApplicationInsights

https://blog.darkthread.net/blog/view-sql-encrypt-certificate/  #SQL 連線加密觀察及加密憑證檢查

#sys.dm_os_waiting_tasks
https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-waiting-tasks-transact-sql?redirectedfrom=MSDN&view=sql-server-ver16
https://docs.microsoft.com/zh-tw/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine?WT.mc_id=DOP-MVP-37580&view=sql-server-ver16
https://www.mssqltips.com/sqlservertip/3408/how-to-troubleshoot-ssl-encryption-issues-in-sql-server/  # How to troubleshoot SSL encryption issues in SQL Server
https://www.mssqltips.com/sqlservertip/3299/how-to-configure-ssl-encryption-in-sql-server/


#How to: View the ASP.NET Performance Counters Available on Your Computer
https://docs.microsoft.com/en-us/previous-versions/xhcx5a20(v=vs.140)?redirectedfrom=MSDN
https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/performance-counters?redirectedfrom=MSDN


#Enable event tracing in SqlClient
https://docs.microsoft.com/en-us/sql/connect/ado-net/enable-eventsource-tracing?view=sql-server-ver16


#Does activating off-by-default performance counters in ADO.NET carry a performance hit #
https://stackoverflow.com/questions/26933071/does-activating-off-by-default-performance-counters-in-ado-net-carry-a-performan


#Performance counters in SqlClient
https://docs.microsoft.com/en-us/sql/connect/ado-net/performance-counters?view=sql-server-ver16
#Monitoring Database Connections using Performance Counters
https://www.c-sharpcorner.com/uploadfile/CMouli/monitoring-database-connections-using-performance-counters/



#PowerTip: Enable PerfMon counters for ODBC connection pooling with PowerShell
https://devblogs.microsoft.com/scripting/powertip-enable-perfmon-counters-for-odbc-connection-pooling-with-powershell/

https://www.sqlshack.com/sql-server-confidential-part-crypto-basics-sql-server-cryptographic-features/


# ----get_session.sql
select  GETDATE() 時, SUSER_NAME() 人,HOST_NAME()  地  , HOST_ID() 地識HOSTPID ,@@SERVERNAME 到  ,@@SPID  [到識]
select * from sys.dm_exec_connections  
select * from sys.dm_exec_sessions  where session_id >50 order by 2 

select c.session_id,client_net_address,encrypt_option,DB_NAME(database_id) dbn,client_tcp_port, local_net_address,local_tcp_port,net_transport,auth_scheme,s.host_name,s.host_process_id
,program_name,client_interface_name,login_name,nt_domain,nt_user_name,GETDATE() , @@SERVERNAME, SUSER_NAME()
--,,HOST_NAME(), HOST_ID(),@@SPID,,encrypt_op
from sys.dm_exec_connections   c
join sys.dm_exec_sessions  s  on c.session_id=s.session_id
order by 2,1







#local --6B-RDS-SRV2.6BRDS.COM.TW

https://6b-rds.6brds.com.tw/RDWeb/Pages/zh-TW/login.aspx?ReturnUrl=/RDWeb/Pages/zh-TW/Default.aspx
https://6b-rds.6brds.com.tw/RDWeb/Pages/zh-TW/Default.aspx

https://6b-rds-srv2.6brds.com.tw/RDWeb/Pages/zh-TW/login.aspx?ReturnUrl=/RDWeb/Pages/zh-TW/Default.aspx
https://6b-rds-srv2.6brds.com.tw/RDWeb/Pages/zh-TW/default.aspx
6brds\690303 -改密碼
1234qwerp@ssw0rds      (Jun.13.2019)
1234qwer1qaz@WSX       (Aug.14.2019)
p@ssw0rd1q2w3e4r5t     (Feb.11.2020)
1234qwerp@ssw0rd1q2w3e (Aug.12.2020)
1qaz@WSX3edc1234qwer    (Feb.09.2021)
1qaz@WSX3edc1234qwer

#--------------------------------------------------------------------------------------


function findext ($param1,$param2)
{
    $qdir=$param1+'\'
    $extn='.'+$param2
    $export =$param1+'\'+$param2+'_Alllist.txt' ;$export

cls
$t1=get-date
$dS=gci $qdir |? PSIsContainer -eq True |sort Name

foreach ($d in $dS)
{
    $dn = "$qdir"+$d.Name ;$dn
    #gci  $dn -Recurse |? Extension -eq $extn  |select Name,Extension,Directory, fullname |sort Name |ft -AutoSize  
    gci  $dn -Recurse  |? Extension -eq $extn  |select Name,fullname |sort Name | Out-File    $export  -Append  -Width  500
}
$t2=get-date ; $t2-$t1
ii $export
}


findext  c:\worklog pptx
findext  g:      dtsx  # 2m05sec 


#--------------------------------------------------------------------------------------
taskschd.msc
ipconfig
ncpa.cpl
C:\WorkLog\UltraEdit_14\Uedit32.exe  #   --   Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32Uedit32


mstsc
172.16.220.97  #isolation  ,BOP   ii C:\MyDataIII\Ming2020\dLock   corp\infra2 ,resmon
172.16.220.82  #SDC VS 
172.16.220.97  # infra2  SDC IIS  , isolation, logon Trigger ,permission  
172.16.220.94   #SDC nonAD Cluster  lcoal\administrator
172.16.220.110  #SDC nonAD Cluster

172.16.220.38  # BOP BIDS SQL2008
172.16.220.133 # BOP  vs2017
172.16.220.72  # BOP_Cluster node1
172.16.220.74  # BOP_Cluster node2

172.16.220.49       # infra1
192.168.12.69
172.16.210.64:3390  #SSRS   登入ID：TsengMing 密碼：Syscom@123

172.16.220.33 (Node4) + 62  Mirror  P     infra1
172.16.220.34  +45   Mirror  w
172.16.220.44   Mirror  B



#--------------------------------------------------------------------------------------
email backup

#$ps1fS=gi C:\Users\User\OneDrive\download\PS1\OS00_Index.ps1

Copy-Item  C:\Users\User\OneDrive\download\PS1\OS00_Index.ps1  C:\Users\User\OneDrive\download\PS1\OS00_Index.txt  -Force

$ps1fS=gi C:\Users\User\OneDrive\download\PS1\OS00_Index.txt


foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname         =$ps1fS.name
    $ps1fFullname     =$ps1fS.FullName 
    $ps1flastwritetime=$ps1fS.LastWriteTime
    $getdagte         = get-date -format yyyyMMdd
    $ps1length        =$ps1fS.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To "ming_tseng@syscom.com.tw" -from 'ming_tseng@syscom.com.tw' `
    -attachment $ps1fFullname  `
    -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length " `
    -Body "  ps1source from:me $ps1fname   " 
}

Remove-Item C:\Users\User\OneDrive\download\PS1\OS00_Index.txt

#--------------------------------------------------------------------------------------
基本知識
架構圖
基本語法
工具使用
SOP
環境準備




week backup 
mingbackup.ps1

$str=get-date -Format yyyyMMdd
$f33mydata='\\172.16.220.33\f$\mydataII\pS1_'+$str
start-sleep 5

Copy-Item -Path C:\onenote_20150528\ -Destination C:\Users\administrator.CSD\SkyDrive\ –Recurse -Force

Copy-Item -Path C:\onenote_20150528\ -Destination \\172.16.220.33\f$\mydataII –Recurse -Force

Copy-Item -Path C:\Users\administrator.CSD\SkyDrive\download\PS1 -Destination $f33mydata –Recurse -Force
 
edit at IBM t61  Aug.06.2015 
https://onedrive.live.com/edit.aspx/%E6%96%87%E4%BB%B6/Ming2017?cid=2135d796bd51c0fa&id=documents
https://onedrive.live.com/edit.aspx/文件/MingTseng?cid=2135d796bd51c0fa&id=docu
https://onedrive.live.com/edit.aspx/文件/MingTseng?cid=2135d796bd51c0fa&id=documents
https://onedrive.live.com/edit.aspx/文件/NewNote?cid=2135d796bd51c0fa&id=documents
https://onedrive.live.com/edit.aspx/文件/NewNote?cid=2135d796bd51c0fa&id=documents
https://onedrive.live.com/edit.aspx/文件/白灰?cid=2135d796bd51c0fa&id=documents
#>

________________________________________________________________________________________________________________________________________


pwd: p@ssw0rd  ; pass@word1 ; p@sswords    p@sswordv (116)
proxy.syscom.com.tw

https://partner.microsoft.com/zh-tw/

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\Desktop\readme.txt
powershell_ise 'C:\Users\User\OneDrive\download\PS1\temp2012.ps1'
powershell_ise C:\Users\User\OneDrive\download\AProd51\Aprod51_ming.ps1
start "chrome.exe" "https://docs.google.com/spreadsheets/d/1BuPSErVTuCcruCH2NrgU86a4mN0EzkMtfCuQMLf8s3Y/edit#gid=0"
SAPS  "chrome.exe" "https://docs.google.com/spreadsheets/d/1BuPSErVTuCcruCH2NrgU86a4mN0EzkMtfCuQMLf8s3Y/edit#gid=0"

Start-Process 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OneNote 2016'


ii C:\temp\mstsc  infra1  p@ssw0rd, p@ssw0rdq
corp\administrator   : p@ssw0rds


('SQLPS21_BI'                ,N'SSRS ,SSAS ,SSIS ',N'SSDT',N'devenv'_

ii \\172.16.220.226\CRMShare\





https://172.16.208.41/?timeout=false       manageiq690303 / syscom@123456  ,manageiq921304   syscom@123

csd\administrator  , p@ssw0rdv , p@ssw0rde  , p@ssw0rdj


Microsoft SQL Server Data Tools - Business Intelligence for Visual Studio 2013 


start-process 'c:\Windows\System32\cliconfg.exe'
start-process 'c:\Windows\SysWOW64\cliconfg.exe'

SQL hostname: PMD2017 (sql2016)
    APDB        172.16.208.119     etl    etlzpvuvu4wj/3
    BIDB        172.16.208.119     etl    etlzpvuvu4wj/3
in2k8SQL2k8-BI  	172.16.208.73	192.168.110.12    .\administrator   p@ssw0rd

Win2k8SQL2k8-MO     172.16.208.101  192.168.110.13    .\administrator   p@ssw0rd  C:\BIResource

#----CSD.SYSCOM     FC.CSD.SYSCOM          172.16.220.194 
(3)2013BI  2016BI	 34	   123   AD      member: SP2013,SQL2014X
(4)SP2013	         29	   124   SQL2014,Office2013plus,OneDrive, onenote, chrome,line, adobe,rar,ultraEdit
(5)SP2013WFE	           127            
(6.1)SQL2016     SQL2014X 61  129    SharePoint2013  ,SQL2016
(6.2)SQL2012X

(11)CHTCRM-MO  Win2k8SQL2k8-BI  	Windows 2008 SQL2008Enterprise	192.168.110.12  172.16.208.73     csd\infra1  
(12)CHTCRM-BI  Win2k8SQL2k8-MO  	Windows 2008 SQL2008Enterprise	192.168.110.12  172.16.208.101    csd\infra1 

#----PMOCSD.SYSCOM.COM
(10)New 專案管理系統 PMD2016  33  144  AD, sql2014ENT, Sharepoint2013 ,XMLNotepad.ultraEdit , PowerBIDesktop, p@ssw0rd for BI
                                            

________________________________________________________________________________________________________________________________________
('OS02A_performance'          ,N'效能 第一集中點' ,N'IOPS');  <--load test 

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS02A_performance.ps1
('AWS01_General'              ,N'AWS',N'ebook catalog List ','')
('AWS02_VPC    '              ,N'AWS',N'ebook catalog List ','')
('AWS03_Cloud9   '              ,N'AWS',N'ebook catalog List ','')
('AWS04_EC2    '              ,N'VPC',N'ebook catalog List ','')
('AWS05_IAM    '              ,N'AWS',N'ebook catalog List ','')
('AWS06_MSSQL    '              ,N'AWS',N'rds ','')
('AWS07_mysql    '              ,N'AWS',N'ebook catalog List ','')
('AWS08_Aurora_Global    '              ,N'Globaldtabase',N'ebook catalog List ','')
('AWS09_cloud9    '              ,N'NvM',N'node.js ','')
.ps1

('AA01_General'              ,N'Android',N'ebook catalog List ','')
('AA02_code'                 ,N'example',N'xml',N'an Syntax')
('AA03_anUse'                ,N'各式應用',N'class',N'imageView',N'checkbox',N'checkbox')
('AA04_anComponent'          ,N'RadioButton',N'object',N'',N'checkbox',N'checkbox')
('AA05_media'                ,N'movie',N'picture',N'mp3',N'DIRECTORY_MUSIC',N'ALARMS',N'DIRECTORY_MUSIC',N'NOTIFICATIONS')

('AA05_arSensorControl '     ,N'RadioButton',N'checkbox',N'imageView',N'checkbox',N'checkbox')
('AA06_arModule'             ,N'RadioButton',N'checkbox',N'imageView',N'checkbox',N'checkbox')
('AA07_arSyntax'             ,N'字串設定語法',N'checkbox',N'imageView',N'checkbox',N'checkbox')

('AA08_java'                 ,N'java4android',N'Youku',N'Syntax',N'DIRECTORY_MUSIC',N'ALARMS',N'DIRECTORY_MUSIC',N'NOTIFICATIONS') 
('AA09_ASPNET'               ,N'ASP',N'VB',N'ADO.Net')
#arModule

('EX01_CIB'                    ,N'CIB'       ,N'SSIS')
('EX02_M3'                     ,N'MVDIS'     ,N'Index',N'checkNodePort')
('EX03_DGPA'                   ,N'DGPA'      ,N'replication ','mirroring')
('EX04_KMUH'                   ,N'KUMU'      ,N'   ','sql profiler  ')
('EX05_SYSCOM'                 ,N'mingbackup',N'mingbackupfile ',mingbackupDB,'hyper V  226 labinfo')
('ex06_TPEx'                   ,N'cluadmin'  ,N'SQL2014 ', N'sp_spaceused'  ,'dm_db_log_space_usage' ,'sys.dm_server_services ')
('ex07_MOFA'                   ,N'cluadmin'  ,N'SQL2014 ', )
('ex08_TPEx_sharepoint2007'    ,N'cluadmin'  ,N'SQL2014 ', )
('ex08_01_TPEx_sharepoint2007' ,N'cluadmin'  ,N'SQL2014 ',   )
('ex08_02_TPEx_sharepoint2016' ,N'cluadmin'  ,N'SQL2014 ',   )
('ex09_CHTperformance'         ,N'CHT'       ,N'sQL2008 ',   )
('EX10_CHTD'                   ,N'CHT'       ,N'sQL2008 ',   )
('EX11_HwaTaiBank'             ,N'CHT'       ,N'sQL2008 ',   )
('EX12_TsengFamily'            ,N'FamilyPhoto',N'sQL2008 ',   )
('EX13_KMUHDR'                 ,N'CHT',N'sQL2008 ',   )
('EX14_TWSELOGPerf'            ,N'TWSE',N'sQL2008 ', '\WorkLog\TWSE-RecAP'  )
('EX15_TPDoITOneDrive'         ,N'TP',N' ', onedrive for business 'office 365 '  )
('EX16_TPTAO'                  ,N'臺北市交通事件裁決所',N' ', 'Taipei city Traffic Adjudication Office'  )
('EX17_TPTAO_everyQuarterly'   ,N'臺北市交通事件裁決所',N' '  )
('EX17_TPTAO_property_income'   ,N'臺北市交通事件裁決所',N' '  )
('EX18_ACERSharePoint'         ,N'SharePoint  ',N' ')
('EX19_CHTCRM        '         ,N'SharePoint  ',N' ')
('EX19_CHTCRM_DSIS_Daily_ETL'   ,N'SharePoint  ',N' ')
('EX20_T4'                     ,N'ticket machine  ',N' 自售機')
('EX21_MasterLink'             ,N'',N' ',   )
('EX22_huanansecu'             ,N'',N' ',   )
('EX23_TourBus'                ,N'tBus',N' ', 'iBUS'  )
('EX24_TWSEBIGSQL'             ,N'',N' ',   )
('EX25_NTPC_EDU'               ,N'',N' ',   )
('EX26_Sunnybank'              ,N' example from Microsoft',N' '   )
('EX27_iBusPlus_iBUS'          ,N' example from Microsoft',N' '   )
('EX28_troubleshooting'        ,N'SSPI context',N' Kerberos ',''   )
('EX29_ZXH'                    ,N'SSPI context', N'SPN ','中興醫院'   )
('EX30_MOI'                    ,N'SelfSignedCertificate', N'Cert','Encryption','內政雲'   )
('EX31_MING2020'               ,N'SelfSignedCertificate', N'Cert','Encrypton',''   )
('EX32_NTUH'                   ,N'Node049', N'Cert','Encryption','台大醫院'   )
('EX33_BOP'                    ,N'Node097', N'NLB','','csv to Table','xp_sendmail'   )
('EX34_CAMoF'                  ,N'Node049', N'NLB','','南資中心'   )
('EX35_T4_ATVM'                ,N'Node049', N'NLB','','南資中心'   )
('EX36_FACE'                   ,N'Node049', N'NLB','','南資中心'   )
('EX37_YTF'                    ,N'RunEV_0818', N'NLB','','南資中心'   )
('EX38_networkspeed'            ,N'test-networkspeed', N'X','','OO'   )



('Lx01_General '               ,N'SOP  PreSOP  from Microsoft',N'緊急 Help' ,N'WinPcap'  ) 
('Lx02_redhat '                ,N'SSH  PreSOP  from Microsoft',N'緊急 Help' ,N''  ) 





('M013'                        ,N'control ps1   SQL load ',N' 壓測' ,N'M008'  ) 
 

('OS00_Index'                ,N'Index',N'Index',Null)
('OS01_General'               N'pipeline,function,workflow, snap-in ,snapin ',N' ,math ,string ,Time ,random ,variable ,array,shortcut',PS2EXE)

('OS02_performance'          ,N'Powershell start',N'first', 'sq Monitoring Transaction Log Performance', ' listen port,'gps'');
('OS02A_performance'          ,N'效能 第一集中點');  <--load test 
('OS02_01_diskIO'            ,N'diskspd start',N'powershell',Null)
('OS02_03_Sharepoint_SQL'    ,N'counter list for SQL',N' performance example 範本',N'BaseLine Sample 樣板','集中點','')
('OS02_04_Alwayson'          ,N'  ',N'powershell','test data')
('OS02_04_SSAS'              ,N'  ',N'SSAS performance counter',Null)
('OS02_05_List'              ,N'  ',N'',)


('OS03_SendMail'             ,N'send Mail, monitor ,',N'powershell','GUI')
('OS04_firewall'             ,N'create firewall',N'powershell',Null)
('OS05_Job'                  ,N'job , schedule task',N'taskschd.msc' , N'scheduletask , win Event , ETW ',N'ScheduledTasks')
('OS06_remote'               ,N'enabling,disabling, session',N'NetFirewallRule',N'tracert'  , 'RDP'   ,'packet capture',' 限制存取IP  mstsc', 'WSMan')
('OS07_file'                 ,N'Powershell start',N'powershell','mingbackup','xpath')

('OS08_System'               ,N'IIS , Server manage, HyperV, Network,DNS',N'PyAutoGUI',,N'webSite',N'sysprep',N'己安裝軟件Software','gcim' ,'gwmi','NetAdapter')
('OS0801_WebRequest'         ,N'download html , math manage, , Network,DNS',N'WmiObject',enable powershell_ise,)

('OS09_modules'              ,N'type,import ,reload, write, check ',N'powershell',Null)
('OS10_AD'                   ,N'installation AD, Account ,Group policy ,Domain Controller ',N'AD ',Null)
('OS11_UC'                   ,N'Exchange ,Lync , Office365 ,sharepoint Online',N'exchagne,Lync ',Null)
('OS12_cloud'                ,N'Azure  firebase, connection, ',N'google cloud ','Line Notify')
('OS13_SC'                   ,N'SystemCenter ',N'cloud ',Null)
('OS14_Vendor'               ,N'VMWare ,Citrix ,Cisco ,Quest ',N'cloud ',Null)
('OS15_cluster'              ,N'cluster , ',N'sql Cluster ',Null)
('OS15_01_T4cluster'         ,N'cluster , ',N' ',Null)
('OS16_git'                  ,N'gitHub ,gitLab , , ,',N'', ,)
('OS17_APM'                  ,N'JMeter ,gitLab , , ,',N'', ,)


('Py01_General'               ,N'python ,gitLab , , ,',N'', ,)
('Py02_package'               ,N'File ,gitLab , , ,',N'', ,)
('Py03_'               ,N'python ,gitLab , , ,',N'', ,)


('SP00_cmdforSharePoint'     ,N'Powershell  for Sharepoint','powershell',NULL)
('SP01_installconfg'         ,N'SharePoint installation  configure','powershell',NULL)
('SP01_01_install'           ,N' service application ','powershell',)
('SP01_02_ProjectServer'      ,N' 2017 最新專案ProjectServer','',)


('SP02_BI'                   ,N'BI execl  performance  visio','powershell',NULL)
('SP02_01PMDstepbystep'      ,N'PMD2016','sharepoint2013','SOP')

('SP02_02check'              ,N'uninstall','sharepoint2016','SOP')

('SP03_Serviceapplication'   ,N' service application ','powershell',NULL)
('SP04_FeatureSolution'      ,N' Site Templates  ','powershell',NULL)
('SP05_OfficeWebApps'        ,N' excel client  ','VBA',Pivottable)
('SP06_WebApplication'       ,N' Site Templates  ','powershell',NULL)
('SP07_SP13BackupRestore'    ,N' Site Templates  ','powershell',NULL)

('SQLPS00_enable'            ,N'Basic Task'  , N'Install uninstall ',N'SqlServer PowerShell module  cliconfg',N'SMO',N'ConfigurationFile',N'sp_configure ')
('SQLPS01_alwayson'          ,N'Powershell start',N'powershell','nonAD alwayson  non-cluster alwayson ')
('SQLPS02_Sqlconfiguration'  ,N'filegroup ,sqlindex fragmentation ,sqljob' ,'operator','powershell','Partition','ChangePassword','Filestream' , 'FileTable' ,'linked server','sqlmail','PrimaryKey','CPU usage')
('SQLPS03_Invoke'            ,N'ODBC','powershell','dataProvider' ,'OLEDB','sp_executesql')
('SQLPS04_extendedevent'     ,N'Powershell start','powershell','deadlock')

('SQLPS05_DMV'               ,N'Powershell start','session',counter,'更新統計信息 Statistics' ,)
('SQLPS05_01_DMV_OSPerf'     ,N'Powershell start','powershell',N'')
('SQLPS0501_DMV_Transaction' ,N'Dirty Read ,, ISOLATION LEVEL','powershell',N'')   
('SQLPS05_03_LISTALL'        ,N'lock ,block, ','powershell',N'') 
('SQLPS05_04_LISTALL'        ,N' ,block, ','powershell',N'') 

('SQLPS06_BCP'               ,N'BCP','powershell',NULL)
('SQLPS07_General'           ,N'Statistics , event alert ,',N'EXEC (@SQL)','Control-of-Flow Language','foreign key','TSQL 內建函數 Bulti-in', sp_who to Table)
('SQLPS07_01_TSQL'           ,N'TSQL example,   ,',N'參考用TSQL','last_user_update',''INFORMATION_SCHEMA)

('SQLPS08_Inventory'         ,N'Inventory','powershell',NULL)
('SQLPS09_replication'       ,NULL,'powershell',NULL)
('Sqlps09_01_DGPA'           ,for DGPA Project,'powershell',NULL)
('SQLPS10_storedprocedure'   ,NULL,'powershell',NULL)
('SQLPS11_alert'             ,N'alert,database Mail,',N'DDL ',NULL)
('SQLPS12_security'           NULL,'security ,Audit','Encryption'  ,'isolation')
('Sqlps12_01_sp_help_revlogin'','NULL,'security ,',NULL)
('SQLPS13_TDE'               ,NULL,'powershell',NULL)
('SQLPS14_backupRestore'     ,N'fn_dblog',N'EXEC (@SQL)',NULL)
('SQLPS15_Mirroring'         ,N'Mirroring','powershell',NULL)
('SQLPS16_ResourceManager'   ,NULL,'powershell',NULL)
('SQLPS17_triggers'          ,'DML Trigger','powershell','sp_readerrorlog'  xp_readerrorlog  ,'DAC')
('SQLPS18_Profiler'          ,N'change tacking,trace,distribut Replay',N'change tacking,trace,',NULL)
('SQLPS19_Agent'             ,NULL,'powershell',NULL)
('SQLPS20_policy'            ,N'PBM','powershell',NULL)
('SQLPS21_BI'                ,N'SSRS ,SSAS ,SSIS ',N'SSDT',N'PowerBI'
('SQLPS22_DataCollection'    ,N'Management Data warehouse ,MDW',N'powershell',NULL)
('SQLPS23_SQLcapacity'       ,N'capacity planning and configuration  ,MDW',N'powershell',NULL)
('SQLPS24_inmemory'          ,N'in memory',N'powershell',NULL)
('SQLPS25_FullText'          ,N'Search',N'FileTable',NULL)
('SQLPS26_SQLTuning'          ,N'SQL優化',N'FileTable','Querystore')
('SQLPS27_GCB'               ,N'帳戶管理',N'強制執行密碼原則,密碼原則,存取授權',NULL)


('VB01_General'               NULL,N'MSDTC' ,'devenv', N'visual studo', 'VS2017')
('VB02_code'                 ,N'example',N'xml',Null)
('VB03_Use'                  ,N'各式應用',N'ebook chapter',N'imageView',N'checkbox',N'checkbox')
('VB04_Component'            ,N'RadioButton',N'object',N'class',N'checkbox',N'checkbox')
(''                          ,N'movie',N'picture',N'mp3',N'DIRECTORY_MUSIC',N'ALARMS',N'DIRECTORY_MUSIC',N'NOTIFICATIONS')


$-----------------AWS01_General.ps1

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS01_General.ps1


$-----------------AWS02_IAM.ps1

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS02_IAM.ps1

$-----------------AWS03_Cloud9.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS03_Cloud9.ps1

$-----------------AWS04_EC2.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS04_EC2.ps1


$-----------------AWS06_MSSQL.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS06_MSSQL.ps1


$-----------------AWS07_mysql.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS07_mysql.ps1

$-----------------AWS08_Aurora_Global.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS08_Aurora_Global.ps1


$-----------------AWS09_cloud9.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AWS09_cloud9.ps1

$-----------------AA01_General.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA01_General.ps1
powershell_ise C:\Users\User\OneDrive\download\PS1\AA01_General.ps1

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AA01_General.ps1

#   66    command . shortcut 
#   069   Android Device monitor    DDMS
#   74    宣告 / Type
#   84    math
#   97    String
#   111   array 陣列
#  106    flow control  switch  break;  if  for
#   122   vibrator 震動     shen04.12  
#   113   getSystemService
#   137   顯示溫度符號  
#   156   自專案資源載入字串  getResources().getString(R.string.charC));  shen05

$-----------------AA02_code.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA02_code.ps1
powershell_ise C:\Users\User\OneDrive\download\PS1\AA02_code.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AA02_code.ps1

$-----------------AA03_anUse.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA03_anUse.ps1
powershell_ise C:\Users\User\OneDrive\download\PS1\AA03_anUse.ps1

#   028    java class  dictionary 


$-----------------AA04_anComponent.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA04_anComponent.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AA04_anComponent.ps1



$-----------------AA05_arSensorControl.ps1
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA05_arSensorControl.ps1

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AA05_arSensorControl.ps1


$-----------------AA06_arModule.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA06_arModule.ps1

powershell_ise C:\Users\User\OneDrive\download\PS1\AA06_arModule.ps1

$-----------------AA08_java.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA08_java.ps1


$-----------------AA09_ASPNET.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\AA09_ASPNET.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AA09_ASPNET.ps1



    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\AA08_java.ps1


$-----------------EX01_CIB.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX01_CIB.ps1
{<#
#00  base info
#01  Add-WindowsFeature PowerShell-ISE
#02  74 enable winrm & configuation
#03  109  get systeminfo
#04  139  get Disk
#05  173  get install product
#06  185  get services 
#07 197   get firewall rule 
#08 230　 get SQL master_files
#09 246   get SQL version
#10 269   get SQL Job
#11  291  get SQL databaseinfo
#12 312 　get SQL  serverinfo
#13 333 　get SQL backup 
#14 360  　get SQL SSIS  packages 
#15  　   get Host performance
#16  　   get SQL create script
#>}


$-----------------EX02_M3.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX02_M3.ps1
powershell_ise C:\Users\User\OneDrive\download\PS1\EX02_M3.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX02_M3.ps1

{<#

#>}


$-----------------EX04_KMUH.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX04_KMUH.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX04_KMUH.ps1
{<#

#>}

$-----------------EX05_SYSCOM.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX05_SYSCOM.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX05_SYSCOM.ps1



{<#
# 31    mingbackup 
# 171   mingbackupfile
# 337   mingbackuDB 
# 434   mingbackupfile  F2 to F3  
# 461   Syscom lab   226  with hyperV  
#>}
$-----------------ex06_TPEx.ps1
powershell_ise C:\Users\User\OneDrive\download\PS1\ex06_TPEx.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\ex06_TPEx.ps1
#01  69   General command 常用指令
#02  99   SQL check  SQL  服務檢查
#03  110  Get Set  IP Address  網路檢查   NetIPAddress
#04  137  get/ Install WindowsFeature  安裝windows功能
#05  176  install #NET Framework 3.5 安裝NET Framework 3.5  功能  
#06  183  check   Module  :  can see  FailoverClusters 開啟 powershell for FailoverClusters 功能  
#07  278  New  FailoverClusters command   佈建 容錯移轉叢集  服務 名稱
#08  254  ClusterNode   檢查節點
#09  394  ClusterOwnerNode   檢查擁有者節點
#10  429  Disk  檢查磁碟
#11  461  Get-ClusterNetwork  檢查叢集網路
#12  481  Get-ClusterLog   檢查叢集記錄
#13  573  安裝 Net 4.5
#14  520  enable firewall 檢查防火牆
#15  532  mkdir  & sharefolder  建立資料夾及分享資料夾
#16  550  建立 SQL 安裝  ConfigurationFile.ini
#17  585  啟動 alwayson 功能
#18  599  import-module sqlps   匯入  Powershell for SQL
#19  612  create database for sample  建立測試Database 及 備份
#20  640  設定 alwayson 服務
#21  929  建立 AG listener

#22   add 3rd quorum
#23  963    DBinfo ,diskInfo  , fileInfo, fragInfo, indexInfo ,LogspaceInfo, statInfo , tableInfo (sp_msforeachtable) ,sp_spaceused  spaceused,dbsizeinfo
#24  1754  找出資料庫中 所有 索引 的詳細資訊    allindex
#25  1805   查詢  執行平均時間排名   執行計畫建立時間
#  1841    被封鎖的session資訊(  locked session information  )
#  1869    被封鎖封鎖 別 人的session資訊(  blocking session information  )
#  1891    找出已開啟且閒置的交易(Finding idle sessions that have open transactions )  
#  2095    Partition lab 01 for TPEX   維持6個月的Partition
#  2507    Drop Partition File  

$-----------------ex07_MOFA.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\ex07_MOFA.ps1

$-----------------ex08_TPEx_sharepoint2007.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\ex08_TPEx_sharepoint2007.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\ex08_TPEx_sharepoint2007.ps1

# 31    mingbackup 
# 171   mingbackupfile
# 337   mingbackuDB 
$-----------------ex08_02_TPEx_sharepoint2016.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\ex08_02_TPEx_sharepoint2016.ps1

$-----------------ex09_CHTperformance.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\ex09_CHTperformance.ps1




$-----------------EX11_HwaTaiBank.ps1
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX11_HwaTaiBank.ps1

$-----------------EX12_TsengFamily.ps1 
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\EX12_TsengFamily.ps1
powershell_ise C:\Users\User\OneDrive\download\PS1\EX12_TsengFamily.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX12_TsengFamily.ps1


{<#
# 11      tsql  Nov.30.3015
# 20  74  check import File (ex:Family2010821X)  所有檔案是否已存放在 FamilyPhoto  之中了
# 241     check 由 Table（FilePhotoListS  Familyphoto 是否可以讀取  file properties
# 255     clear empty folder
# 284     delelte  Hidden   Thumbs.db
# 296     ONOFF=2 之處理
# 408    update ONOFF = 5 手動, filelength=0  ,then delete physical file
# 572     rename  0 + FileName 
# 587     人工排除 重覆 
# 740     folder 內檔案數,大小  [FolderPhotoListS]
# 825     compare two folder  &　F1 copy to F2
# 945     New file import
#  1805  最終版  20180513
#  2118  MyDataII 備份SOP
#  2213  Software2018 備份SOP
#  2357  List all worklog fullpath , name to CSV  to Keep
#>}

$-----------------EX13_KMUHDR.ps1
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\EX13_KMUHDR.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\EX13_KMUHDR.ps1

#   15    basic parameter
#   38    get basic perf
#   382        災害復原之標準作業程序  當 Storage 1 不能使用時,  HISDB2, Storage 2 仍可使用時 緊急使用    2016
#   388        災害復原之標準作業程序  只有 HISDB2 仍可使用時 緊急使用    2016    
#   552   sessioninfo  檢查當下的連線資訊以及強制刪除 SPID
#   778    whoRun  To   zWhatsGoingOnHistory 側錄當下所執行之TSQL  及找出之後  最常及最久  TSQL
#   842   災害復原之標準作業程序   scenario 2  add replica   HISDBCLS1 into AG
#   917   HISDB  災害復原之標準作業程序   scenario 3     HISDB to $node1
#   1054  HIS_BKDB  災害復原之標準作業程序   scenario 4  HIS_BKDB to $node1
#   1129  HISDB  災害復原之標準作業程序   scenario 5  HISDB  Node1 to Node2
#   1230  HIS_BKDB  災害復原之標準作業程序   scenario 6  HIS_BKDB to node2
#   1303  create AG 
#   1422  who is primary
#   1434  failover to another
#   1458  REMOVE DATABASE
#   1471  REMOVE REPLICA 
#   1495  災害復原之標準作業程序   scenario 7  add replica   HISDBCLS2,1436  into AG
#   1573  資料庫備份進度檢查 EstimatedEndTime



$-----------------EX14_TWSELOGPerf.ps1
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\EX14_TWSELOGPerf.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX14_TWSELOGPerf.ps1


$-----------------EX15_TPDoITOneDrive.ps1
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX15_TPDoITOneDrive.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX15_TPDoITOneDrive.ps1

{<#
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
# 831 office 365 online management shell 
#>}
$-----------------EX16_TPTAO.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe   C:\Users\User\OneDrive\download\PS1\EX16_TPTAO.ps1



$-----------------EX17_TPTAO_everyQuarterly.ps1
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX17_TPTAO_everyQuarterly.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX17_TPTAO_everyQuarterly.ps1


$-----------------EX17_TPTAO_property_income.ps1
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX17_TPTAO_everyQuarterly.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX17_TPTAO_property_income.ps1



$-----------------EX18_ACERSharePoint.ps1
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX18_ACERSharePoint.ps1


$-----------------EX19_CHTCRM    EX19_CHTCRM_DSIS_Daily_ETL   
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX19_CHTCRM.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX19_CHTCRM.ps1


#     3490  DB maintain  backup  
#   274   sysjobs
#   287   import SQLJOB    sysjobsteps    dtsxlist
#  2347  ATest51 reonline  測試區SharePoint 重建
#   663 SSRSList
#   799  ColumnList
#   851     DBinfo ,diskInfo  , fileInfo, fragInfo, indexInfo ,LogspaceInfo, statInfo , tableInfo  APR.13.2017   
#  1984  Sharepoint 2007  create new all    Jul.03.2017
    # 1984_11  enable function 
    # 1984_013
    # 1984_015
    # 1984_017
    # 1984_031  alias 192.168.217.101  MOSSDB
    # 1984_036  create new farm use UI
    # 1984_053  restore DB
    # 1984_072  hosts
    # 1984_085  update wss sp3 & sharepoint sp3
    # 1984_089  install /uninstall  rs
    # 1984_097  restore IIS
    # 1984_098  drop 
    # 1984_113  URL test 
    # 1984_116
    # 1984_131  configure rs
    # 1984_137  getregedit
#  2347  ATest51 reonline  測試區SharePoint 重建步驟
#  2626 web.config 
#     2708  DB maintain  db general script
#     2171  DB maintain  import  


$-----------------EX20_T4     
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX20_T4.ps1



$-----------------EX21_MasterLink    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX21_MasterLink.ps1

$-----------------EX22_huanansecu    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX22_huanansecu.ps1

$-----------------EX23_TourBus    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX23_TourBus.ps1
常用 Event ID
Event ID: 17110  SQL 登錄啟動參數 
Event ID: 18210 備份 磁碟的空間不足
Event ID: 3041 BACKUP 無法完成命令 
Event ID: 35206 alwayson 發生連接逾時 
schedulebase: each 15min  通知:   磁碟 $didr 空間已低 $DiskCapacity %


#   73 Disk Size Check 
#   196  tls 1.2 windows hotfixupgrade
#   438    ibus 75_perfSQL01
#   1151   分析  BLG


$-----------------EX24_TWSEBIGSQL    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX24_TWSEBIGSQL.ps1
#   lab2  
#   lab04 139   Partition  FileGroup  Backup ＆　Restore  one  
#   lab06 145   Partition  FileGroup  Backup ＆　Restore  one  
#   lab07 850   Move Partition  FileGroup  to another path  
#   lab08 947   回復單一FileGroup(分自我DBSUV_D  
#   lab06 1183  Partition  FileGroup  Backup ＆　Restore  one

$-----------------EX25_NTPC_EDU    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX25_NTPC_EDU.ps1

$-----------------EX26_Sunnybank    
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX26_Sunnybank.ps1
#   471     enable  ReportingServicesTools
#   584     upload   
#   2417    定序的相依性

#   786   D:\exportRDL\exportRDL.ps1  20190411 版
#   1043  sQL Baseline FromMicrosoft 
#   1072  sQL  SSRS  Baseline FromMicrosoft 

$-----------------EX27_iBusPlus 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX27_iBusPlus_iBUS.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX27_iBusPlus_PreSOP.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX27_iBusPlus_SOP.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX27_iBusPlus_tBUS.ps1 


EX27_iBusPlus_iBUS
#    278 PR Site Fail 緊急 當主要點暴力中斷
#    304 全台大停電, 台北先復電. 但 DR ChaiYi 未上線  強制仲裁模式啟動  強制手動容錯移轉
#    056  backup & restore
#    075  (01) iBus Failover to DR   01_iBus_Failover_To_DR
#         (02) tBus Failover to DR       02_tBus_Failover_To_DR
#         (03) dCar Failover to DR
#         (04) iBus Failover to PR
#         (05) tBus Failover to PR
#         (06) dCar Failover to PR
#         (07) iBus  + iBus Failover to DR
#         (08) iBus  + iBus Failover to PR
#         (09) iBus  + iBus + dCar  Failover to DR
#         (10) iBus  + iBus + dCar  Failover to DR
#    278  (11)緊急  iBus  PR Site Fail 當主要點暴力中斷 緊急在DR強制上線   DR UP 
#    304  (12)緊急  iBus  台北先復電. 但 DR ChaiYi 未上線 if 全台大停電
#         (13) 15th create Next month  database
#   749   (14) make  availability group for next month
#    777  (15)   synchronization_state check 每日檢查報告 Sendmail 
#    818  MirrorStauts 
#    1093    backup  rule  bak dif trn
#  1227   16_iBus_Drop3monthagoBAG
#  1342   ibus backup log table

$-----------------EX28_troubleshooting 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX28_troubleshooting.ps1 
#   51  Cannot generate SSPI context" error message  Kerberos
#   284  SQL  PID  listen PORT  SQL目前正在運行ProcessID 以及監聽的TCP  Port
#  348   目前SQL登入來源主機, 帳號, Authentication schema, TCP
#  380     sa  連密碼都忘記
#  450     SQL Agent 起不來 in SQLcluster　　＋　multi-instance 
#  485     收集一般資訊  Nov.02.2021
#--     480  重建系統資料庫   REBUILDDATABASE
#--  525 移動系統資料庫  (master)
#-- 581  移動系統資料庫  (msdb,  model  , tempdb)


$-----------------EX29_ZXH 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX29_ZXH.ps1 
#   16  常用指令
#   57 找出那一支程式正在listen 那一個  PORT
#    78  找出 正在運行SQL 的  ProcessId StartName   
#  102 連接字串 6 Type
#  130  網卡名稱  MACAddress Link SPeed 連線速度  以及目前IP 
#  182   Display filter 過濾指令
#  204   setspn  SPN
#   16  常用指令
#   57  找出那一支程式正在listen 那一個  PORT
#   78  找出 正在運行SQL 的  ProcessId StartName   
#  102  連接字串 6 Type
#  130  網卡名稱  MACAddress Link SPeed 連線速度  以及目前IP 
#  182  wireshark Display filter 過濾指令
#  204  setspn  SPN
#  279   查詢  SQL 登入 來自IP, 帳號  authentication . port 
#  296  Cluster Command
#  480  cluster Node Failover 
#  495  Set  ClusterGroup   rename
#  506   make resoruce offline  & online
#  378 mirroring work  常用指令
#  backup Time
#   1151   分析BLG



$-----------------EX30_MOI 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX30_MOI.ps1 

#  0 ~  6 create/configure encyption for  SQL   SelfSignedCertificate Lab: Node141 C:\PerfLogs\SQLConnectEncrypt.ps1
#  96    Wireshark 自動擷取  
#   180  Microsoft SQL Serverv &  SQL Native Client   的 TLS 1.2 支援
#   196    如何判斷    安裝的 作業系統	.NET Framework 版本	TLS 1.2 支援的更新  How to use PowerShell to determine the version and service pack level of a .NET  regedit 
#   237    找出安裝在電腦上的 .NET Framework 安全性更新  與 Hotfix
#   290    .NET Framework 版本和 CLR 版本之間 差異
#   388    Informix to SQL Server Migration

 
 $-----------------EX31_MING2020 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX31_MING2020.ps1 
#C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\WorkLog\iBus\EX31_MING2020.ps1

copy   C:\WorkLog\iBus\EX31_MING2020.ps1  C:\Users\User\OneDrive\download\PS1\EX31_MING2020.ps1
 $-----------------EX32_NTUH 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX32_NTUH.ps1 

Lab_removeFilgroup


 $-----------------EX33_BOP
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX33_BOP.ps1 
#   32   HostList
#   62   dblistbyName 
#  114   dblistbyName 
#  173   permissionbyDB
#  256   permissionbyLogin
#  358   SQLJobList
#  468   aplist 
#  534   aplistbyDB
#  647   DTS
#   971  SQL Cluster   access  1 name  mulit IP 
 #   987  how-to-use-database-mail-feature-in-sql-server-2000   xp_sendmail
 #  1160  SSIS XMLparse xpath
 #  1306   get  Excel  by  Microsoft.ACE.OLEDB.12.0

 $-----------------EX35_T4_ATVM
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX35_T4_ATVM.ps1 
#  105  scenario  I
#  236  scenario  II 
#  426  scenario  II 
#--  638  -Sending query results e-mail message   


 $-----------------EX36_FACE
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX36_FACE.ps1 


 $-----------------EX37_YTF
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\EX37_YTF.ps1 


$-----------------Lx01_General
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\Lx01_General.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Lx01_General.ps1

#   49  ebook index
#   92  find  grep   搜尋文件內的文字  尋找檔案
#     247 wiresharek command Line
#   113   wireshark
#   185   wireshark command  event 1135  trigger capture
#   282 Network ref
#   379  TCP 壅塞控制 (Congestion Control)  
#   395  WinPcap
#   468   HTTP protocol
#   505  tshark  #   588  tshark analysis
#   588  tshark analysis

#   678    statistics
#   753   tshark  analysed statistics like wireshark at commandline 


$-----------------Lx02_redhat
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\Lx01_General.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Lx02_redhat.ps1



$-----------------M013
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe   C:\Users\User\OneDrive\download\PS1\M013.ps1

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe 'C:\Users\User\OneDrive\download\PS1\M008_Control.ps1'
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe 'C:\Users\User\OneDrive\download\PS1\M008.ps1'




$-----------------OS01_General
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\oneDrive\download\ps1\OS01_General.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe   C:\Users\User\OneDrive\download\PS1\OS01_General.ps1

{ 
# 1   88  Enable Powershell ISE  & telnet
# 2   150  math
# 3   300  String  replace  substring
#  350 char   unicode ascii utf-8
# 4   400  time
# 5   500  File
# 6   550  executionPolicy syntax V3    ?  where
# 7   600  Flow control
# 8   700 variable & object  Hashtable
# 9   750 Get-PSDrive
#10   800 Install PowerShell V3 V4
#11   750 PSSnapin  vs modules
#12   800 mixed assembly error
#13  850 Get-Command  filter Service2
#14  900  Function 
#15  900  Out-GridView  Out-null 
#16  900  Measure-Command  Measure-Object
#17  900  Group item find out count*
#18  950  select -object ExpandProperty
#(19)  950  system  variables  env:   PSVersionTable Automatic Variables
#20  pass  parameter to ps1 file 
#21  Operators  運算子
#(22) 1600   $env  set $env:path add Path 
#(1777) NoNewline or next line ,same line
#  1777 gci expression  @{Name="Kbytes";Expression={$_.Length / 1Kb}}  在多個資料夾內搜尋
#  1916 Run a Dos command in Powershell  Aug.26.2015
#  1966 try catch  Aug.30.2015
#  2150 runas  administrator start-process execute program  & url IE  chrome
#  2184 command . shortcut 
#  2468  Special Characters  `r `n `t  \n  \r  \t  escape
#  2697  Remove a File Share  Get-SmbShare
#  2746   pass an argument to Ps1
#  2746   GET  Self Powershell process Pid   SilentlyContinue
#  2807   Get Process Name and Owner User Name
#  2826    New-Object PSObject  暫存用powershell Table
#  2925      Convert Powershell to Exe  ps2exe
#  3010    Compress-Archive   Expand-Archive  zip unzip  
#  3052     access network folder  uncpath  
#  3085     powershell  $error 
}



$-----------------OS02_performance  
{<#
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS02_performance.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS02_performance.ps1


\0S02_sets

# 1  58       校時 Sync Host Time
# 1  76       Enumerating the counter groups
# 2  110       find right counter
# 3         accessing the counter' data
# 4   remote icm +  scriptblok + pararmeter  PowerShell DEEP DIVES ,port 445  p39
# 5    200  Using jobs for long-running tasks  icm -Asjob
# 6    249  Collecting and saving remote performance data to disk in a BLG file  PowerShell DEEP DIVES p41  ;Export-Counter
# 7    250  Import-Counter   Manipulating stored performance data from a file
# 8    300  real  Average
# 9    350  Get-AvGCPULoad.ps1      PowerShell DEEP DIVES P48
# 9-2  350  Get-AvgGlobalLoad.ps1   PowerShell DEEP DIVES P48
# 10        Find 常用效能計算器 
# 11        performance  Get-Counter  perfmon.exe
# 12   694      re-log existing data  http://technet.microsoft.com/en-us/library/hh849683.aspx
# 13        PerformanceCounterSampleSet
# 14  550  disk I/0  sample
# 15  600  disk I/0  sample
# 16  700  performance set list
# 17  750  $using parameter pass to remote  -AsJob 
# 18  878  relog  blg + blg  logman
# 19  800  Data Collector Sets   
# 20  Using Format Commands to Change Output View 
# 21  1045  Import-Counter
#     1072  Missing SQL Server Performance Counters
#     1167  casestudy   Diagnosing Transaction Log Performance Issues and Limits of the Log Manager
#   1597  RTO  RPO  Recovery Time Objective   Recovery Point Objective
# 1647  SQL eventvwr  eventID  monitor  SQL出現事件ID
#    1671  listen port How can you find out which process is listening on a port on Windows?
# 99  1725   Task Manager   gps vs get-counter , Processid  20220503
#    1759  AG performace DMV
#   1795   Process  counter  found  PID   \Process(*)\ID Process   20220503
# 1987    Get-AvgCPULoad   Get-AvgGlobalLoad.ps1    20220424
# # 2061    75_perfSQL01    20220424
#  2336   counter   Build an HTML page  20220515
#>}



$-----------------OS02A_performance    #  20190515 load Test
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS02_performance.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS02A_performance.ps1
#  172  tasklist   ResMon


$-----------------OS02_01_diskIO  
powershell_ise C:\Users\User\OneDrive\download\PS1\OS02_01_diskIO.ps1


$-----------------OS02_03_Sharepoint_SQL
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS02_03_Sharepoint_SQL.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS02_03_Sharepoint_SQL.ps1
#  24   Get basic info
#  268  remote job counter
#  351  os Memory  PCR
#  435  SQL　　 PCR
#  457  disk　　PCR
#  584  performance Counter  ref  指標器 參考值

#  1224  pagefile 分頁檔
#  1320  正確解讀記憶體佔用率
#  1503  KMUH BaseLine  example
#  1622  TPex BaseLine  example
#  1750  SQL Server 儲存設備 (Storage) 最佳調整作業  Sep.09.2017
#  1864  SQLIO Disk Subsystem Benchmark Tool. Sep.18.2017
#  1890 thread Task  dm_os_schedulers 
#  1891 存儲過程運行良好，但是有時非常差  重用一個緩存的執行計劃  storedProcedure

$-----------------OS02_04_Alwayson
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS02_04_Alwayson.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS02_04_Alwayson.ps1
{<#
#  0 120  test data
#  1 150  SQLServer:Availability Replica  PCR
#  2 200  SQLServer:Database Replica      PCR
#  3 200  SQLServer:Database              PCR
#  function  
#  function PCRTwoNode 

#>}
$-----------------OS03_SendMail
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS03_SendMail.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS03_SendMail.ps1
 
 
 # 1  Send-MailMessage
 # 2   150  syscom SMTP info  -smtpserver '172.16.200.27'  + taskschd
 # 3  powershell run  ps1 file 
 # 4  200 Function SendMail 
 # 5  218 Add a PowerShell GUI Event Handler
 #  5050  send  e-mail from a trigger  database mail (sp_send_dbmail)
#  539   pop-up message


$-----------------OS05_Job

powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS05_Job.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS05_Job.ps1

{<#
# 01       background
# 02  120  Scheduled Tasks  
# 03  250  New-ScheduledTaskAction
# 04  300  ScheduledTaskTrigger 
# 05  300  Register-ScheduledTask
# 06  400  schtasks.exe create  ScheduledTask 
#    x     time-based trigger vs Event-based triggers
# 07  500  Managing failover clusters with scheduled tasks
# 08  500  example   scheTest.ps1  
# 09  566  JOB CMDLET  
# 10  630  Get-eventlogs   WinEvent
# 11  700  new  & clear & remove  & write-log
# 12  760  Get-WinEvent
# 13  800  wevtutil 
#>}
$-----------------OS06_remote
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS06_remote.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS06_remote.ps1


{<#
# 1  firewall   netsh advfirewall firewall
# 2 Enable-PSRemoting  Port 445, 5985
# 3   115   Creating a remote Windows PowerShell session  pssession
# 4  captures output from the remote Windows PowerShell session, as well as outputfrom the local session
# 261 Test-Port
# 5  Running a single Windows PowerShell command
# 6  驗證配置與 Kerberos 不同，或是用戶端電腦沒有加入網域， 到 TrustedHosts 組態設定中。
# 7  get all member machine info
# 8  Test-Connection
# 9  250   Get all computername pararmeter 
# 10 250  remote create scheuletasks 
# 310   turn on Winrm using AD Group Policy Editor
# 460  gwmi firewall port
# 684  Tracert   Test-NetConnection   and  System.Net.Sockets.TcpClient
# 1002  RDP  change  3389 to other port
# 1011    Packet   Capture
# 1474   get-counter  remote     nov.09.2015
# 1286   Block IP to SQL  Mar.11.2020
#  1656   WSMan
#    1714  Get-NetTCPConnection
#    1731  Powershell Execute remote exe with command line arguments on remote computer   ArgumentList
#  2017   Get-NetRoute   Route table
#>}

$-----------------OS07_file
powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS07_file.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS07_file.ps1

{<#
#  50 out-file
#  66 Using Format Commands to Change Output View
#  90    PowerShell Script to save System, Application, Security event viewer logs from various servers into a CSV file
#  200   mail all ps1 source to my Gmail 
#  200   Get disk FreeSpace & Size
#  212   compare two folder then copy difference
#  255   copy jpg * to folder by yyyyMMdd
#  300   merge two folder then copy difference by LastWriteTime
#  338   C:\PerfLogs\mingbackup.ps1
#  557   Backup Ming data to LOG @database
#  599   edit save  to file
#  613   remove folder if no any file
#  752   compare 2 Folder result to file
#  1006  sqltable  save to excel xls xlsx csv export-csv  multi multiline to one line
# 1007  excel  xls xlsx  to sqltable   Mar.19.2018
#  1077  ConvertTo-Csv   ConvertFrom-Csv
#  1106  Import-Csv  ipcsv
#  1129  foreach string  to CSV 
#  1175  save folder data to csv (inclue directory and file )
#  1292  CSV to excel  xls  xlsx
#  1309  CSV to sql table 
#  1397  photo  CSV to sql table   + folderlocation
#  1535  Get filePhotoLists  copy jpg to filephotopath ( familyPhoto) for SQL
#  1851  Familyphoto all folder properties to DB  FolderPhotoGroupS Table   
#  1873  Explore Structure of an XML Document
#  2104  excel xlsx  xls    to CSV
#  2153  Get File to Table
#  2475  make mp3 filename
#   2539  get file path & file name
#   2551  edit MP3 tags
#  2674  Trustedinstaller   get-acl    20171208
#  2799  robocopy
#  2938  Get Text File Encoding   Nov.12.2020
#>}


$-----------------OS08_System
 powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS08_System.ps1

  C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS08_System.ps1   #>-------
 C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS08_System_clickOMFlow.ps1         
 C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS08_System_sendkey1.ps1   
 
{<#
# 01        Get-WmiObject  Gwmi
# 01     109 Get-CimInstance  gcim
#   128   搜尋工作管理員特定  services 的  svchost 的 PID  然後  刪除   services PID
# 02    222    credential (Non-AD)  pass password
# 03   60   Disk using gwmi
# 03-1 150  10500 Checking disk space usage using gwmi  p133
# 04   200  Stop service with Gwmi & gsv
# 05   200  get BIOS
# 06        Get curent logonserver
# 07        IIS  w3wp
# 08  277      Net.WebRequest     ping sp.csd.syscom
# 09  300   Net.Webclient
# 10  350   attempt a connection until it is able to do so
# 11        shows how many bytes a the webpage that you are downloading is
# 12        Gets content from a web page on the Internet
# 13  400   repeart
# 14        get-wmiobject 
# 15        Get computer system and hardware information  O.S.
# 16  450   Get-ItemProperty   GET regedit value  Use PowerShell to Easily Create New Registry Keys
# 17 450    check node Port  open close
# 18 501  Network  , adapter  NetIPConfiguration    Test-NetConnection   
# 505   windows  operatingsystem    edition  systeminfo   作業系統 OS 資訊
# 510   Enable Powershell ISE from Windows Server 2008 R2 + 2003 R2
#  550  Change file extension associations
#  596  Computer Startup shutdown , logon , logoff Scripts
#  620  Execute Powershell and Prompt User to choice 
#  650  Get  Share folder  Path of computer
#  679    language  input  惱人的輸入法問題  & 候選字
#  845  Win32_Product   add and remove program    appwiz.cpl 
#  863  hyperV  install  sysprep
#  877  NTP w32tm
#  989  ultraedit install 
#  1149  gwmi  win32_processor
#  1167  Uninstall Trend Micro OfficeScan without the password. officescan
#  1364  sendkey  keyword send  Send click 
#  1506  enable active windows serial 
#  1555  FQDN
#  1884  list Established   process name pid  use local  port remote ip port  列出已建連線程式名稱以及PID
#  1999   appwiz.cpl  install list
#  1951  PyAutoGUI  自動控制滑鼠跟鍵盤
#  2090   logoff remote user     qwinsta    Invoke-RDUserLogoff   .Jul12.2022
#  2191    Wsappx 在 Windows 11/10 上佔用高磁碟和 CPU 使用率的解決方案   Jan10.2023

$-----------------OS0801_WebRequest download html

#>}
$-----------------OS09_modules
{<#

powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS09_modules.ps1
powershell_ise 
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS09_modules.ps1

# 01 50  $env:PSModulePath  :查詢預設模組位置
# 02 55 Get-module -listAvailable  查詢出來可用地 
# 03 80  Get-module -查詢已匯入的模組  以及模組內的指令
# 04 80 import-module-匯入的模組  &移除模組時
# 05 100    尋找模組中的命令  
# 06 110     Get  remove -psdrive   gh get-psdrive -full  Net use * /delete /y
# 07 120     new -psdrive
# 08  166     sqlpsx
# 09   275  Remote Active Directory Administration  AD module RSAT-AD-PowerShell  RSAT-AD-AdminCenter

#>}

$-----------------OS10_AD
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS10_AD.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\OS10_AD.ps1
ise  C:\Users\User\OneDrive\download\PS1\OS10_AD.ps1

#  12  Install  RSAT-AD-PowerShell  Installing the Active Directory Module for PowerShell
#  108  Use PowerShell to Deploy a New Active Directory Forest 
#  290  Get-ADDomain
#  310  Get-ADComputer
#  344  Get-ADGroup
#  428  NEW-ADOrganizationalUnit
#  523  ADUser 
#  669  Move-ADObject user to OU
#  699  ADGroupMember
#  734  ADAccountPassword
#  747  ADAccount  
#  781  How to configure a firewall for domains and trusts.
#  959  gpupdate -force  Dec.28.2016

OS12_cloud
$-----------------OS12_cloud
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS12_cloud.ps1

#    227  Line  Notify using Powershell


$-----------------OS15_cluster
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS15_cluster.ps1


{<#
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS15_cluster.ps1

#    69  Get Cluster info
#01      General command 
#02      Network check 
#03      Get  IP Address
#04  100 get/ Install WindowsFeature  &
#05      install #NET Framework 3.5 功能  
#06      SQL Server 2008 R2 叢集問題驗證失敗 
#07      check   Module  :  can see  FailoverClusters
#08      check   FailoverClusters command
#09      ClusterNode
#10      ClusterOwnerNode  
#11  250 ClusterGroup		
#12  300 ClusterResource  
#13  400 Disk   
#14  400 Get-ClusterAvailableDisk 
#15      Get-ClusterResourceDependency
#16  450 Get-ClusterParameter
#17  500 Get-ClusterNetwork
#18      ClusterAccess
#19  550 SQL Server Agent
#20  600 Get-ClusterLog   Create a log file for all nodes (or a specific a node) in a failover cluster.
#21  600 Get-ClusterLog
#22  600 function Start  SQL2012X   ClusSvc 
#23  700 force a cluster to start without a quorum
#24  750 GET path of File Share Witness
#25  750 Cluster Quorum 
# 26 945 Manually add the SQL Server Agent resource type to the SQL Server cluster resource group      20170810 
# 27 1018   VM SQL Cluster  iSCSI     20180227
# 28 1106   SQL Cluster name rename
# 29 1157   manual  add sql agent to  sQL Cluster  
#  1420   Workgroup and Multi-domain clusters 
#  1478   Microsoft Windows Multi-Site Failover Cluster Best Practices
# 1498   了解叢集和集區仲裁 
#>}

$-----------------OS15_01_T4cluster
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS15_01_T4cluster.ps1



$-----------------OS16_git
{<#
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS16_git.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS16_git.ps1

#01       

#>}


$-----------------OS17_APM

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\OS17_APM.ps1


$-----------------Py01_General

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Py01_General.ps1
Py01_General

$-----------------Py02_package

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Py02_package.ps1
#   38   pip


$-----------------SP00_cmdforSharePoint
 powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP00_cmdforSharePoint.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\SP00_cmdforSharePoint.ps1


$-----------------SP01_installconfg

powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP01_installconfg.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SP01_installconfg.ps1
# 01   50  Check Sharepoint software appwiz.cpl
# 02  150  Find Your SharePoint Version
# 03  184  get-PsSnapIn 
# 04  204  $profile
#  05       install  using Powershell  ASNP Microsoft.SharePoint.Powershell 
#  06 250 configuration using Powershell   SPShellAdmin  無法存取本機伺服陣列。未登錄具有 FeatureDependencyId 的 Cmdlet
# 07  330  SharePoint Services for OS
# 08  400  IIS Servcies
# 09  440  get-command *get-SP*
# 10  440  伺服器陣列的所有伺服器   status   gh Get-SPServer  -full
# 11  440  get-SPDatabase
# 12  450  Manage services on server  for Sharepoint  SPServiceInstance
# 13  500  服務應用程式集區  Service Application Pool
# 14  547  SP  Service   Application  Get-SPServiceApplication   Proxy
# 15  561  Install and Download SharePoint 2013 prerequisites offline
#     719  Install-SP2013RolesFeatures.ps1
#    1025  install sharepoint at WFE
#    1039  SPWebTemplate
#    1206  Add or remove blocked file types
#    1409   SPManagedAccount
#    1413   SPServiceApplicationPool
#  1471   IncludeCentralAdministration
#  1478    update to  Sharepoint sp1
#  1489   regedit  spfarm  login 
#  1650   after configuration Wizard  don't  run wizard now
##  1671  SP Check List all
##  2003  stsadm   
##  2011  INSTALL AND CONFIGURE PROJECT SERVER 2016
##  2193  PowerShell Script to Configure Project Server 2016   
##  2305  PowerShell Script to Configure  Reporting Servcies  SSRS 
##  2383  SharePoint 2016: How To Configure Search Service Application Using PowerShell
##  2570  Backup and Restore a Site Collection using PowerShell   Jun.11.2019

$-----------------SP01_01_install
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\SP01_01_install.ps1
{<#
AutoSPInstaller

#>}
$-----------------SP01_02_ProjectServer
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\SP01_02_ProjectServer.ps1
{<#
AutoSPInstaller
C:\Users\User\OneDrive\download\PS1\SP01_02_ProjectServer.ps1
#1 - Register Managed Accounts.
#2 - Enable Project Server 2016 License.
#3 - Create Project Server Application Service Application Pool.
#4 - Create a Project Server 2016 service application.
#5 - Create a web Application.
#6 - Create Top Level site Collection.
#7 - Lock Down web application Content Database.
#8 - Create a PWA Content Database.
#9 - Lock Down PWA Content Database.
#10 - Provision the PWA Site Collection.
#11 - Enable PWA FeatureStart PWA Instance.
#12 - Start PWA Instance.
#>}
$-----------------SP02_BI
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_BI.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe C:\Users\User\OneDrive\download\PS1\SP02_BI.ps1


{<#
#  10    checklists
#  15    create BI Group ,user, OU 
#  101   create BI Group for SQL 
#  138   SQL install feature list
#  153   Configure the Windows Firewall to Allow SQL Server Access
#  340   Install and Download SharePoint 2013 prerequisites offline  Sp01_installconfg.ps1 Line:561
#  465   Technical diagrams for SharePoint 2013   



#>}
$-----------------SP02_01PMDstepbystep

Powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1
Powershell_ise  \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SP02_01PMDstepbystep.ps1
# 008 檢查已安裝之軟件
# 020  hostname
# 035  step01  prereqs
# 075  step02  Install-ADDSForest 
# 121  step03  create BI Group ,user, OU on OS
# 251  step04  enable firewall#1     List  ---  
# 323  step05  SQL SSDE 
# 349  step06  SQL tool
# 356  step07  SQL SSASTR
# 363  step08  SQL SSASMD
# 371  step09  SSDT
# 630  step10  office
# 378  step11  preinstall   Download-SP2013PreReqFiles.ps1
#  378_2   sharepint 2016 preinstallatin 
# 649  step12  Install-SP2013RolesFeatures.ps1  
# 420  step13  Install-m.ps1 
# 430  step14  install SP
# 483  step15  SQL  alias
# 522  step 16 setup  SQL  if need
# 532  step 17 configure SP
"--------------551-----------17.0 Add-PSSnapin    -----------------------"
"--------------572-----------17.1 Found SharePoint Server 2013 Binaries. Will create Farm now------------------------"
"--------------589-----------17.2  Installed Help Collection------------------------"
"--------------602-----------17.3  Initialized SP Resource Security------------------------"
"--------------607-----------17.4 Created Central Administration Site   inetmgr------------------------"
"--------------717-----------17.5 Instaled SPService  ------------------------"
"--------------827-----------17.6 Installed SP Feature------------------------"
"--------------847-----------17.7 Installed Application Content. This was the last step."

# 863 step 18   restore database &  SSAS cube

# 888 step 19  excel service
"------------ 523 -------------19.1  建立BI專屬 ApplicaionPool   BIApplicationPool -----------------------"
"------------ 561 -----------19.2  Start the Excel Calculation Services service (SI)  --------------------------------"
"------------ 567 ----------19.3  Create an Excel Services service application(SA)   --------------------------------"

# 1002  step 20  執行 PowerPivot for SharePoint 2013 安裝  ，安裝 SharePoint 模式的 Analysis Services 伺服器 (SSASPT)
"-------------- 640 ---------20.1  安裝 PowerPivot for SharePoint  --------------------------------"

# 1060  step 21  Install or Uninstall the PowerPivot for SharePoint Add-in (SharePoint 2013)
"------------- 716 ------------21.0   Add-PSSnapin       -----------------------"
"--------------726 ------------21.1   check              -----------------------"
"--------------838 ------------21.2   download         -----------------------"
"--------------850 ------------21.3   決定安裝伺服器環境  -----------------------"
"--------------862 ------------21.4   開始安裝  msi     -----------------------"
"--------------884 ------------21.5   設定 by UI       -----------------------"
"--------------888 ------------21.6   設定 by  PS1     -----------------------"
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
    #(11)  1116 部署 WA Solution  & Install-SPSolution to WA  DeployWebAppSolution
    #  1131 (12)建立網站集合 sitecollection &
    #  1164 (13) 啟用 sitecollection Enable feature
    #  1197 (14) 啟用 windows Token 服務
    # 1241  (15)  啟動 Secure Store Service SI
    # 1291  (16)  啟動 Secure Store Service SA
    # 1717  (17)  啟動 Secure Store Service SA Proxy
    # 1787(18) 更新　主要金鑰
    # 1819 (19)

# 1851  step 22  create WebApplication Sitecollection ,web
# 1906  step 23  PerformancePoint Services
# 1941  step 24  Reporting Services SharePoint 

#   step 25  visio
#   step 26  BCS

#   3317  設定 PowerPivot 無人看管的資料重新整理帳戶 (PowerPivot for SharePoint)


$-----------------SP03_Serviceapplication
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP03_Serviceapplication.ps1

{<#
#  17  Excel Services cmdlets
# 100    service application  cmdlets
# 128   Business Data Catalog Service Application 
# 188  PerformancePoint Service Application
# 244   Secure Store Service Application
# 324   Visio Graphics Service Application
#>}

$-----------------SP04_FeatureSolution
Powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP04_FeatureSolution.ps1

{<#
#   13   Install-SPFeature
#   41   SPFeature
#  142   Get-SPFeature -Limit ALL get 中文名稱
#  1329  Enable-SPFeature
#>}

$-----------------SP06_WebApplication
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP06_WebApplication.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SP06_WebApplication.ps1
    
##   51  伺服器陣列中所有的服務應用程式集區
##   64  Get-SPWebTemplate
##  188  SPWebApplication 
##  526  upload  +  download + delete  file to sharepoint 
#   647   Site Collection  spsite

$-----------------SP07_BackupRestore
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP07_BackupRestore.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SP07_BackupRestore.ps1

    
##   51 伺服器陣列中所有的服務應用程式集區
##   64  Get-SPWebTemplate
##  188  SPWebApplication 
##  526 upload  +  download + delete  file to sharepoint 

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SP07_SP13BackupRestore.ps1


$-----------------sqlps00_enable
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\sqlps00_enable.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\sqlps00_enable.ps1



{<#
# (1) 35 before start : check SQLPS  SqlServer PowerShell module   nupkg
#   (1) 56   Get-packageprovider   Get-packagesource
#   (1) 77 Nuget    nuget.org
##  92 sqlserver module    <- 新版sqlps   get-sqldatabase
# (2) 100  sQL Modules and snap-ins:
# (3) 150  Import-Module “sqlps” -DisableNameChecking
# (4) 150  naming parament rules  Development environment
# (5) 200  SQL Server Management Objects (SMO)  p20
# (6) 270  discover SQL-related cmdlets  p22
# (7)      service cmdlet
# (8) 300 SQL server configuration settings         with SQLPath
# (9) 350  Get / Set  configuration settings        with smo
# (10) 400 remote query timeout (s)
# (11) Searching for all database objects save to file  p60
# (12)  500  Creating /Drop /Set a database         with SMO  p67
# (13)  550  Creating /Drop /Set a table            with SMO  p75
# (14)  600  Creating /Drop /Set a VIEW             with SMO  p81
# (15)  650  Creating /Drop /Set a stored procedure with SMO  p85
# (16)  700  Creating /Drop /Set a Trigger          with SMO  p90
# (17)  750  Creating /Drop /Set INDEX              with SMO  p95
# (18)  850  Executing a query / SQL script with SMO  p99
# (19)  900 uninstall SQL feature SSRS
#  889  cliconfg  alias
#  896  Install SQL Server PowerShell Module (SQLPS)
#  912  using ConfigurationFile install SQL 
#  986   catch error invoke-sqlcmd 
#  1048   設定 remote access 選項  專用管理員連接 (DAC)。
#  1069    當系統管理員遭到鎖定時連接到 SQL Server
#  1321     backslash  UDP 1434
#  1380   sp_configure 來啟用 'xp_cmdshell' 
#>}

$-----------------sqlps01_alwayson
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\sqlps01_alwayson.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\sqlps01_alwayson.ps1
{<#
#  (01) 101  Get Alwayson  availability Groups is enables
#  (02) 117  Get instance information  using SQLPath
#  (03) 255  Get AvailabilityGroups information
#  (04) 300  configuration AlwaysOn with TSQL
#  (05) 601  adding and Managing an Availability Databases  手動加入指定複本機位於不同磁碟位置
#  5.1  735  adding and Managing an Availability Databases sp2013 and sql2012x : workable
#  5.2  800  adding and Managing an Availability Databases  sp2013wfe DataFile other load  workable
#  (06) 888  remove   add  a secondary replica
#  (07)      Availability Group with powershell   ref 4-(8)
#  8         Join-SqlAvailabilityGroup
#  9         enable AlwaysOn Availability Groups
#  10        Get who is Primary   Switch  SqlAvailabilityGroup
#  11    1100  Test-SqlAvailabilityGroup  with SQLPath
#  11.1  1200 Including User Policies   Test-SqlAvailabilityGroup
#  11.2  # 11.2   alwayson   with SMO 
#  12    1300     1   RegisterAllProvidersIP
#  13  
#  14   To configure an existing availability group
#  14.1• Add a Secondary Replica to an Availability Group (SQL Server)
	• Remove a Secondary Replica from an Availability Group (SQL Server)
	• Add a Database to an Availability Group (SQL Server)
	• Remove a Secondary Database from an Availability Group (SQL Server)
	• Remove a Primary Database from an Availability Group (SQL Server)
	• Configure the Flexible Failover Policy to Control Conditions for Automatic Failover (AlwaysOn Availability Groups)
#  15 To manage an availability group
	• Configure Backup on Availability Replicas (SQL Server)
#15.2• Perform a Planned Manual Failover of an Availability Group (SQL Server)
#15.3• Perform a Forced Manual Failover of an Availability Group (SQL Server)
	• Remove an Availability Group (SQL Server)
#  16   To manage an availability replica
#16.1• Add a Secondary Replica to an Availability Group (SQL Server)
#16.2	• Join a Secondary Replica to an Availability Group (SQL Server)
#16.3	• Remove a Secondary Replica from an Availability Group (SQL Server)
#16.4	• Change the Availability Mode of an Availability Replica (SQL Server)
#16.5	• Change the Failover Mode of an Availability Replica (SQL Server)
#16.6	• Configure Backup on Availability Replicas (SQL Server)
#16.7	• Configure Read-Only Access on an Availability Replica (SQL Server)
#16.8	• Configure Read-Only Routing for an Availability Group (SQL Server)
#16.9	• Change the Session-Timeout Period for an Availability Replica (SQL Server)
#17  To manage an availability database
#18  To monitor an availability group
#19  To support migrating availability groups to a new WSFC cluster (cross-cluster migration)
# (20) 1500  how to get  log_send_queue
# (21) 1500 21  what latency got introduced with choosing synchronous availability mode
#  22   1600  alwayson  DMV 
#  23  1650  dmv about alwayson  監視 WSFC 叢集中的可用性群組  Monitoring Availability Groups on the WSFC Cluster
#  24  1650    dmv  監視可用性群組 Groups  :Monitoring Availability Groups
#  25  1710  dmv  監視可用性複本 replicas  Monitoring Availability Replicas
#  26  2010  dmv  監視可用性資料庫  replicas  Monitoring Availability Databases
#  27  2400  dmv  監視可用性群組接聽程式  Monitoring Availability Group Listeners  
#  28 2500  monitor AG wiht SMO
# 29  2555   Monitor availability groups and availability replicas status information using T-SQL  常用指令  目前的同步狀態  強制暫停  強制轉移  一般轉移
# 30  2666  BAG basic Availability Group    Jul.22.2019
# 2844   Availability Group   -performance  LastCommitTime
#    2903     non-AD  Cluster Group  workGroup 
#    2927     BACKUP   LOG  on AG
#>}

$-----------------sqlps02_Sqlconfiguration
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\sqlps02_Sqlconfiguration.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe   C:\Users\User\OneDrive\download\PS1\sqlps02_Sqlconfiguration.ps1
{<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\sqlps02_Sqlconfiguration.ps1
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\sqlps02_Sqlconfiguration.ps1
# 01      Listing installed hotfixes and service packs using SMO
# 02   116  table and  filegroup  p.153
#  (3) 130  Adding secondary data files to a filegroup  table to filegroup   p.l156 
#  (4) 200  Moving an index to a different filegroup  if OBJECT_ID
# 05 301  Checking /Reorganizing/rebuilding  index fragmentation 重新組織與重建索引  p162
# 22   1465   SQL Job view ,clear , start , stop  disable or enable JOB  by TSQL
  (6) 355  Listing /Creating/scheduling SQL Server jobs / list only the failed jobs   sqljob p.178
#   366   Using the new SQLServer Powershell module to get SQL Agent Job Information   Mar.06.2018
# 07      Adding a SQL Server operator  p.181
# 08
# 09
# 10
# 11  查詢 SQL Server 的產品版本  version
# 12  修改SQL伺服器名稱2
# 13  Adding a file to a database
# 14  Adding a filegroup with two files to a database
# 15  Adding two log files to a database
# 16  Removing a file from a database
# 17   1499  Moving tempdb  master msdb systemdatabase 移到新位置  to a new location
# 18  Making a filegroup the default
# 19  Adding a Filegroup Using ALTER DATABASE
# 20  回傳 7 今天修改的
# 21  Creating a SQL Server instance object  p29

# 23  modify a job
# 24  1015   List All Objects Created on All Filegroups in Databas
# 25   1110  建立分割區資料表及索引  Partitioned Tables and Indexes
# 25   1180  自動建立分割區資料表及索引  Partitioned Tables and Indexes
# 25   1188   Create new yearly partition table  產生新年度partition table 
# 1215 Get Database Table column Data Type  
#  1353    max degree of parallelism  MAXDOP
#  1447    in-memory 
#  1466    Set or Change the Database Collation  
#  2417    定序的相依性
#   1499  tempdb 移到新位置
# 1309  CSV to sql table (lost)
#  1397  photo  CSV to sql table   + folderlocation (lost)
#  1754  找出資料庫中 所有 索引 的詳細資訊    allindex   goto ex06_TPEx Line:1754
#  1705   索引搜尋查閱次數 ,資料列筆數 ,使用大小 
#  1734   遺漏索引  dm_db_missing_index_details
#   1758   遺漏索引  評估使用者  使用查詢的頻率
#  1846  ChangePassword  SQL Services
#  2640  專用管理員連接 ( DAC )
#  2728  Filestream 及 FileTable 
#   2752  連結的伺服器 Linked Server
#     3015  Check Available CPU s with a SQL Server Query  CPU usage
#   3066 sqlmail
#   3696   LOGINPROPERTY   MS SQL 登入者最後 修改密碼 的時間
#   3755   Find tables without primarykeys (PKs) in SQL Server database
#   4124   Rename SQL Server Name
#   4231   show advanced options
#>}
$----------------- SQLPS03_Invoke
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS03_Invoke.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS03_Invoke.ps1
#    24 get-pssnapin -Registered
#   45  execute a simple query,
#   58  multiple sqlcmd scripting variables to Invoke-Sqlcmd
#   70  execute a  query sql  output to a file
#   81  SQL Server provider for Windows PowerShell to navigate to an instance of the Database Engine
#   91  insert  
# 104 create tabel  multi the SQLinstances
#   130  example : Get table variable to all value insert into sql table 
#   192   ODBC 
#   267    Microsoft SQL Server 的驅動程式歷程記錄   Driver history for Microsoft SQL Server
#   313  connectionstring   string    
#     446   Excel connection strings
#     547   02  SQL Server Native Client  (SNAC) 
#     588   Microsoft ODBC Driver 17 for SQL Server  
#     650   OLE  
#     781        How to use PowerShell to determine the version and service pack level of a .NET 
#     811     MSOLEDBSQL   Microsoft OLE DB Driver for SQL Server 
#     953     System.Data.SqlClient
#     1116     Microsoft.Data.SqlClient
#     1365     sp_executesql

 
$----------------- SQLPS04_extendedevent
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS04_extendedevent.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS04_extendedevent.ps1

#    19     Audit   extended event
#    85     lock  extended event
#    136    找出封鎖的處理序
#    163    匯出指令碼追蹤定義
#    196    如何把追蹤檔(trc)匯入資料表  fn_trace_gettable
#    282    使用擴充事件監視系統活動 
#    309    使用擴充事件   監視  系統活動 
#    471    使用擴充事件   監視   系統活動  
#    546   擴充的事件   目錄檢視 (Transact-SQL)
#    559   判斷哪些查詢持有鎖定  use  extended event
#    919   TransactionBlock      Aug.24.2021





$----------------- SQLPS05_DMV
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_DMV.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS05_DMV.ps1

{<#
#1  83   Clearing all plans from the plan cache or   Find a cached plan  執行計畫  cacheplan  sys.dm_exec_cached_plans 清空資料快取暫存區並重新查詢後，觀察暫存區的使用狀況
#2   315  Memory used per database
#3   361  Measure CPU Usage Per Database
#03  90 The queries that use the most CPU  (+high ) + 檢查CPU 可用數 on VM
#04     Finding where a query is used
#05     A simple monitor for  go number
#
#07     Get All  DMV  and DMF
#08     Identify the 20 slowest queries on your server
#09     找出   Find those missing indexes  sql_server_dmvs_in_active.pdf p.16
#10     找出什麼SQL   正在執行
#11     Who’s doing what and when?
#12  402   
#13     Permissions to the DMVs/DMFs
#14     找出 a  Database 讀寫次數   DB_NAME(qt.dbid) = 'ParisDev' 
#15     最久10大 TSQL Top 10 longest-running queries on server
#16     Creating an empty temporary table structure
#17     Extracting the Individual Query from the Parent Query 
#18     Determine query effect via differential between snapshots
#19     找出連接伺服器的使用者，然後傳回每位使用者的工作階段數  session  Max number of concurrent connections   
#20     Finding everyone’s last-run query
#21 530 Amount of space (total, used, and free) in tempdb
#22 545 Total amount of space (data, log, and log used) by database 
#23     Estimating estimate when a job will finish  -5
#24 592 Determining the performance impact of a system upgrade 
#25 685 sys.dm_os_sys_info
#26 700 Finding where your query really spends its time 尋找查詢的真正花費的時間
#27 711    以sys.dm_exec_query_stats動態管理檢視查詢最耗損I/O資源的SQL語法
#28 735  監控是否有I/O延遲的狀況
#29 788   make lock  , deadlock 
#30 800     呈現鎖定與被鎖定間的鏈狀關係
#31 860     查詢某個資料庫內各物件使用記憶體暫存區資源的統計
#32 868  How to discover which locks are currently held
#33 900  How to identify contended resources
#34 934  How to identify contended resources, including SQL query details
#35 966  How to find an idle session with an open transaction
#36 988  What’s being blocked by idle sessions with open transactions
#37 1030 What has been blocked for more than 30 seconds
#38 1100 Listing / killing running/blocking processes using SMO  p128
#39 1111 statusOSPCRALL \ps1\0S02_sets_scenario004.ps1 
#40 1400 連續執行記錄   執行時間總筆數
#   1596  儲存DMV 到 SQL_inventory  perfXXX sample
#   1677 big table sample data  lab
#  3579    更新統計信息  UPDATE STATISTICS



#98   SQL Server Performance      Data Collection
#99   SQL Server Host Performance Data Collection


#>}

$----------------- SQLPS0501_DMV_Transaction

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS0501_DMV_Transaction.ps1





$----------------- SQLPS05_03_listall
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_03_listall.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS05_03_listall.ps1

{<#
# 15   Listing 1.1 A simple monitor
# 32   Listing 1.2 Find your slowest queries
# 55   Listing 1.3 Find those missing indexes  p.16
# 76   Listing 1.4 Identify what SQL is running now p.17
# 113  Listing 1.5 Quickly find a cached plan  p.19
# 137  Listing 1.6 Missing index details
# 149  Listing 2.1 Restricting output to a given database  p.33
# 164  Listing 2.2 Top 10 longest-running queries on server p.33
# 199  Listing 2.3 Creating a temporary table WHERE 1 = 2
# 210  Listing 2.4 Looping over all databases on a server pattern
# 253  Listing 2.5 Quickly find the most-used cached plans—simple version  p.37
# 273  Listing 2.6 Extracting the Individual Query from the Parent Query
# 296  Listing 2.7 Identify the database of ad hoc queries and stored procedures p.40
# 321  Listing 2.8 Determine query effect via differential between snapshots
# 373  Listing 2.9 Example of building dynamic SQL  p.47
# 398  Listing 2.10 Example of printing the content of large variables p.48
# 437  Listing 3.1 Identifying the most important missing indexes p.62
# 463  Listing 3.2 The most-costly unused indexes p.66
# 518  Listing 3.3 The top high-maintenance indexes  p.70
# 575  Listing 3.4 The most-used indexes  p.73
# 619  Listing 3.5 The most-fragmented indexes p.75
# 659  Listing 3.6 Identifying indexes used by a given routine p.78
# 730  Listing 3.7 The databases with the most missing indexes p.84
# 746  Listing 3.8 Indexes that aren’t used at all p.85
# 781 Listing 3.9 What is the state of your statistics?  statinfo  p.88  更新統計
# 807  Listing 4.1 How to find a cached plan p.95
# 831  Listing 4.2 Finding where a query is used  p.97
# 858  Listing 4.3 The queries that take the longest time to run p.99
# 890  Listing 4.4 The queries spend the longest time being blocked p.104
# 922  Listing 4.5 The queries that use the most CPU p.106
# 953  Listing 4.6 The queries that use the most I/O p.109
# 979  Listing 4.7 The queries that have been executed the most often p.112
# 1001 Listing 4.8 Finding when a query was last run p.114
# 1017 Listing 4.9 Finding when a table was last inserted p.116
# 1094 Listing 5.1 Finding queries with missing statistics p.120
# 1113 Listing 5.2 Finding your default statistics options  p.123
# 1128 Listing 5.3 Finding disparate columns with different data types p.125
# 1162 Listing 5.4 Finding queries that are running slower than normal p.128
# 1241 Listing 5.5 Finding unused stored procedures   p.133
# 1255 Listing 5.6 Which queries run over a given time period p.134
# 1316 Listing 5.7 Amalgamated DMV snapshots  p.137
# 1470 Listing 5.8 What queries are running now  p.142
# 1498 Listing 5.9 Determining your most-recompiled queries p.144
# 1522 Listing 6.1 Why are you waiting? p.149
# 1544 Listing 6.2 Why are you waiting? (snapshot version) p.153
# 1581 Listing 6.3 Why your queries are waiting  p.155
# 1667 Listing 6.4 What is blocked? p.159
# 1696 Listing 6.5 Effect of queries on performance counters p.164
# 1736 Listing 6.6 Changes in performance counters and wait states p.166
# 1801 Listing 6.7 Queries that change performance counters and wait states p.169
# 1913 Listing 6.8 Recording DMV snapshots periodically p.173
# 1944 Listing 7.1 C# code to create regular expression functionality for use within SQL Server p.178
# 1957 Listing 7.2 Enabling CLR integration within SQL Server p.182
# 1976 Listing 7.3 Using the CLR regular expression functionality
# 1985 Listing 7.4 The queries that spend the most time in the CLR p.185
# 2034 Listing 7.5 The queries that spend the most time in the CLR (snapshot version) p.188
# 2090 Listing 7.6 Relationships between DMVs and CLR queries p190
# 2237 Listing 7.7 Obtaining information about SQL CLR assemblies p.194
# 2267 Listing 8.1 Transaction processing pattern p.198
# 2282 Listing 8.2 Creating the sample database and table p.199
# 2295 Listing 8.3 Starting an open transaction  p.200
# 2304 Listing 8.4  a table that has an open transaction against it p.200
# 2314 Listing 8.5  Observing the current locks  p.200
# 2327 Listing 8.6  Template for handling deadlock retries p.204
# 2372 Listing 8.7  Information contained in sessions, connections, and requests p.208
# 2389 Listing 8.8  How to discover which locks are currently held p.209
# 2415 Listing 8.9  How to identify contended resources p.211
# 2447 Listing 8.10 How to identify contended resources, including SQL query details p.211
# 2490 Listing 8.11 How to find an idle session with an open transaction p.214
# 2511 Listing 8.12 What’s being blocked by idle sessions with open transactions p.215
# 2556 Listing 8.13 What’s blocked by active sessions with open transactionsp.218
# 2602 Listing 8.14 What’s blocked—active and idle sessions with open transactions p.219
# 2648 Listing 8.15 What has been blocked for more than 30 seconds p.220
# 2695 Listing 9.1 Amount of space (total, used, and free) in tempdb  p.229
# 2719 Listing 9.2 Total amount of space (data, log, and log used) by database p.230
# 2740 Listing 9.3 Tempdb total space usage by object type p.231 
# 2760 Listing 9.4 Space usage by session
# 2789 Listing 9.5 Space used and reclaimed in tempdb for completed batches p.234
# 2822 Listing 9.6 Space usage by task
# 2849 Listing 9.7 Space used and not reclaimed in tempdb for active batches
# 2893  9.4  Tempdb recommendations  p.240 
# 2902  9.5 Index contention
# 2910 Listing 9.8 Indexes under the most row-locking pressure p.242 
# 2938 Listing 9.9 Indexes with the most lock escalations  p.244
# 2966 Listing 9.10 Indexes with the most unsuccessful lock escalations p.245
# 2990 Listing 9.11 Indexes with the most page splits  p.247 
# 3015 Listing 9.12 Indexes with the most latch contention p.248 
# 3040 Listing 9.13 Indexes with the most page I/O-latch contention p.250 
# 3066 Listing 9.14 Indexes under the most row-locking pressure—snapshot version p.251
# 3161 Listing 9.15 Determining how many rows are inserted/deleted/updated/  p.254
# 3278 Listing 10.1 CLR function to extract the routine name p.160
# 3330 Listing 10.2 Recompile routines that are running slower than normal p.262 
# 3435 Listing 10.3   Rebuilding and reorganizing fragmented indexes
# 3494 Listing 10.4 Rebuild/reorganize for all databases on a given server  p.268 
# 3556 Listing 10.5 Intelligently update statistics—simple version p.270 
# 3615 Listing 10.6 Intelligently update statistics—time-based version p.273
# 3770 Listing 10.7 Update statistics used by a SQL routine or a time interval p.277
# 3877 Listing 10.8 Automatically create any missing indexes
# 3936 Listing 10.9 Automatically disable or drop unused indexesp.283 
# 4009 Listing 11.1 Finding everyone’s last-run query p.287 
# 4027 Listing 11.2 Generic performance test harness p.289 
# 4082 Listing 11.3 Determining the performance impact of a system upgrade p.291
# 4236 Estimating the finishing time of system jobs
# 4219 Listing 11.4 Estimating when a job will finish p.295
# 4247 11.5 Get system information from within SQL Server p.297 
# 4265 11.6 Viewing enabled Enterprise features (2008 only) p.298
# 4315 Listing 11.5 Who’s doing what and when?  p.299
# 4373 1.8.1 Locating where your queries are spending their time  p.301
# 4435 Listing 11.7 Memory used per database  p.304
# 4455 11.10.1 Determining the memory used by tables and indexes p.305
# 4482 Listing 11.9 I/O stalls at the database level p.308 
# 4504 Listing 11.10 I/O stalls at the file level p.309
# 4526 Listing 11.11 Average read/write times per file, per database p.311 
# 4545 Listing 11.12 Simple trace utility  p.312
# 4603 11.13 Some best practices p.314


#>}

$----------------- SQLPS05_04_listall
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_04_listall.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS05_04_listall.ps1



$-----------------SQLPS06_BCP
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS06_BCP.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS06_BCP.ps1

{<#
#  (1)  50  bulk export using invoke-sqlcmd to CSV file
#  (2)  100 bulk export using BCP  P102
#  (3) 150  bulk import using BULK INSERT from CSV p.105

#(99)my test Person.persony 
#>}

$-----------------Sqlps07_General
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps07_General.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps07_General.ps1


{<#



#  1  system 變數  TSQL id ,hostname
#2         table => 變數 可執行  
#3         WHILE  loop 
#4         WAITFOR   delay
#5         RAND()   
#6         create table   
#7         INSERT data from Stored Procedure to Table 
#8         server_level objects 
#9     188 create   table
#10        insert 
#11        找出某Database 所有table   EXEC sp_MSforeachTable  
#12        找出某SQL 所有Database            Exec sp_MSforeachdb 
#13        Display Number of Rows in all Tables in a database
#14        Rebuild all indexes       Disable all Triggers      of all tables in a database
#15        like have '\'
#16    311 print echo
#17    343 查詢執行個體內SQL Server驗證的登入帳戶
#18    360 檢視「中央管理伺服器」存放在系統資料庫msdb內的資訊
#19    400 查詢 SQL Server 的產品版本、版本編號  edition
#20    420 step by step  create snapshot table
#21    450 Who   blocking  處理造成資料庫Blocking的情形 & sp_who
#22    474 set  single user
#23    477 Loop  Example   & 大量產生資料  之變數
#24    63024    Table to table    +   計算時間 SET STATISTICS TIME
#25    559 回傳 7 今天修改的
#26    580 Create   database
#27    600 WMI Server event alerts  using WMI  p.136
#27-2  700 explore the SQL Server WMI events is to use a tool similar  p140
#28    800 Attaching  / Detaching  /copy  a database using SMO  p143
#29    900 Executing a SQL query to multiple servers p152
#30    900 Running DBCC commands CLEANTABLE DBreindex   p167
#31    950 listing SQL Log error P215
#32    delete SSMS Studio Tool 登入記錄 > 連接到 > 在伺服器名稱 > 點選> 直接 <DEL> 接鍵
# 33     Show Size, Space Used, Unused Space, Type, and Name of all database files'  sp_spaceused
# 1099 34   get table info  tableinfo   ref:tsql004.ps1  a  DB 上各Table ,Row  大小
# 1300 35  compare two tables  tablediff
# 1501 99  Built-in Functions TSQL 內建函數 Bulti-in
# 1500     Control-of-Flow Language TSQL 
#1801    Group having
#1815  TSQL Trigger
#1660  TQL Function
#  1865   釋出所有快取  release cache on memory
#  1971   Automated Script generation   ScriptTransfer
#  1999   Getting database settings and object drops into a database-script part1 and part 2
#   2144   SSMS 將查詢結果 存成CSV
#  2295 查詢有關的  條件約束。
#   2268   force drop database
#  3362   sp_who, dbcc perf(logspace) to table
#  3410   透過 DBCC SHRINKFILE([要清空的File], EMPTYFILE) 來將資料移到另一個資料檔之中  ,SHOWFILESTATS   SEP.23.2020
#  3642   ssms shortcut   Oct.12.2020
#>}

$-----------------SQLPS07_01_TSQL
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS07_01_TSQL.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS07_01_TSQL.ps1


#    039    dm_db_index_usage_stats
#     061  INFORMATION_SCHEMA    查詢欄位定序 COLLATION
#   2329 8-16. Merging Data (Inserting, Updating, or Deleting Values)



     #  7318   /* 23-1. Displaying Index Fragmentation */
     #  7343   /* 23-2. Rebuilding Indexes */
     
     #  7412   /* 23-5. Displaying Index Usage */
     #  7444   /* 23-6. Manually Creating Statistics */
     #  7451   /* 23-7. Creating Statistics on a Subset of Rows */
     #  7459   /* 23-8. Updating Statistics */
     #  7466   /* 23-9. Generating Statistics Across All Tables */









$-----------------Sqlps08_Inventory
powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps08_Inventory.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps08_Inventory.ps1

{<#
# 01      Create  SQLInventory database
# 02 100  <Hosts>
# 03 150  insert/update Hosts
# 04 200  SQLServers information  with sQLPath
# 05 350  <SQLServers> with SERVERPROPERTY
# 05-1 1350 Function updateSQLServer with smo
# 05 450  function GetTCPPort
# 06 500  function GetSQLServiceStatus
# 07 550  function GetSQLstarttime
# 08 600  function GetSQLsystemDbDevice
# 09 650  <SQLDatabases>
# 10 650  Function GetSQLdatabases
# 11 750  Function GetSQLDBFileSize
# 12 800  GetDBfileNum
# 13 800  function updateMID
# 14 850  <HostsDisks>
# 15 900  Get  instance inventory  to CSV  p116
# 16 950  Get  Database information inventory  to CSV  p116
# 17 1000 Get  database using SMO
# 18 1200 GetHostDisks
# 19 1200  <SQLDisk>  + Function updateSQLDisks
# 20 1400  step by step DMV to SQL_inventory
# 21  1400  DBCC to SQL_inventory  table 
# 22  get  Table index  filegroup 
#    1612   SQLEventLog
#+ SQLMonitor (alert, schedule, 
#+ PerfDisk
#+ perfCPU
#+ perfMemory
#+ perfNetwork
#+ perfalwayson
#+ perfreplication
#+ perfmirror
#+ DMVBlock
#+ SQLstatus (view)
#+ historySQLDisks
#+ historyHostsDisk

# 99  ps1
#>}

$-----------------Sqlps09_replication
Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\Sqlps09_replication.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps09_replication.ps1

{<#
#         01 Test data  T6 ,T8 ,T9,t9nt , Hosts
# 02 224  Get Publisher  
# 03 354  Get drop  散發者設定  distribution
# 04 379  Get Subscriber 
# 05 401  create publication  
# 06 485  create  publication    merge 
# 07 525  drop publication  
# 08 541  Remove replication objects from the database. 
# 09 551  create subscription     
# 10 597  drop subscription     
# 11 618  將交易式提取Pull或匿名訂閱標示為在下次執行散發代理程式時重新初始化。 這個預存程序執行於提取訂閱資料庫的訂閱者端
# 12 681  article
# 13  監視複寫  http://technet.microsoft.com/zh-tw/library/ms152751.aspx
# 14  5) Monitoring Replication with System Monitor http://technet.microsoft.com/en-us/library/ms151754.aspx
# 15     agent job and MSreplication_monitordata
# 16  MSdistribution_status
# 17  http://basitaalishan.com/2012/07/25/transact-sql-script-to-monitor-replication-status/
# 18  un- distribute command
# 19  stop /start  distribution_agent
# 20  stop / start  replicatoin Jobs 
#    1300  View and Modify Replication Security Settings
#>}

$-----------------SQLPS10_storedprocedure
Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\Sqlps09_replication.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS10_storedprocedure.ps1



$-----------------Sqlps11_alert
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps11_alert.ps1
{<#
# (1)  Get alert   --http://technet.microsoft.com/zh-tw/library/ms186933.aspx
# (2)   Setting up Database Mail using SMO  P168
# (3)  200 Adding / Running a SQL Server event alert  p187

#>}

$-----------------Sqlps12_Security
Powershell_ise  \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\Sqlps12_Security.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps12_Security.ps1


{<#
#01  Listing /set SQL Server service accounts p204
#02  Listing/ Set Authentication Modes p210
#03  950 Listing failed login attempts             p220
#04  Listing logins, users, and database mappings  p222
# 05  457   Listing login/user  DB  roles and permissions p225  
#06 300 Creating / set Permission a login using SMO p227
#07 350  creating /assigning permission  a database user p.232
#08 createing a database Role p.237
#09   Fixing orphaned users p241
#10 Creating a credential  p.244
#11 600 Creating a proxy  p246
#12 Creating a database master key p.289
#13  700 Creating a certificate  p.291
#14  750  Creating symmetric and asymmetric keys P293   對稱式金鑰  
#14 1438  Creating 非對稱式金鑰   asymmetric keys P293   非對稱式金鑰
#15 800  How to link users and logins in an Availability Group  orphaned
#16  866  稽核 audit overview 
#17  866  範例程式碼15-2：在資料庫Northwind_Audit內，建立、修改與刪除資料庫物件
#  18  933  建立登入帳戶 ，GRANT  Deny revoke 物件的權限  Sep.22.2017
#19  960  範例程式碼15-4：利用登入帳戶wii，對資料表Custoemrs執行查詢與更新等作業
#20  977  範例程式碼15-5：使用sys.dm_server_audit_status動態管理檢視來查看各個「稽核」物件的目前狀態
#21  999  範例程式碼15-6：使用函數fn_get_audit_file分析「稽核」檔案.sql
#22  1060 範例程式碼15-7：建立、啟用與檢視「稽核」物件
#23  1077 範例程式碼15-8：建立與啟用「伺服器稽核規格」物件
#24  1099 範例程式碼15-9：檢視「伺服器稽核規格」物件的相關資料
#25  1111 範例程式碼15-10：檢視可用於設定的稽核動作、稽核動作群組與稽核類型的項目
#26  1150 範例程式碼15-11：建立與啟用「資料庫稽核規格」
#27  1168 範例程式碼15-12：檢視「資料庫稽核規格」物件的目前狀態
#28  1180 範例程式碼15-13：建立登入帳戶ps3，可以連線資料庫Northwind_Audit，並賦予適當的權限
#29  1208 範例程式碼15-14：查詢資料庫Northwind_Audit內的資料表
#30  1233 範例程式碼15-15：建立函數，篩選與分析所需的稽核資料
#31  1333  Testing  server Audit Specification
#32  1400  Testing  Database Audit Specification
#33  1470  檢視/create/drop   Audit   20150610
#34  1500  Get audit actions   20150610
#35  1800  sp_change_users_login  現有的資料庫使用者對應至 SQL Server 登入  20150720
#36  1800  執行個體之間傳送登入和密碼 sp_help_revlogin   sp_hexadecimal  20150721
#37  2001     稽核SQL Server Audit新增強的功能(1) 
#38  2066     實作練習一
#39  2575     實作練習二：認識對稽核記錄檔案的篩選
#40  2778     實作練習三：認識使用者定義稽核群組
#  41   3144     authorization  Principal
#  42   3185     sp_srvrolepermission
#  43   3312     SQL serverRole  Fixed + userDefineServerRole   
#  44   3415    Database Role 資料庫角色
#  45   3504    RLS Row Level Security  Row-Level
#  46   3622   ApplicationRole  應用程式角色
#  47   3665    Execute As模擬其它使用者身份
#  4417  4450  TLS 1.2  Transport Layer Security  disable 
#  4450   TLS/SSL Tools
#  4924   Enable SSL Encryption for an MSSQL Network Transport Layer
#  Msg 15466  An error occurred during decryption.
#    4880  Always Encrypted
#    5285  Connecting PowerShell to SQL Server – Using a Different Account
#  2214   sQL 2000 object permission     AUG.2020
#  5478   isolation lab                  AUG.31.2020
#   5999   readonly  +  See  one database  
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps12_Security.ps1


#>}

$-----------------Sqlps12_01_sp_help_revlogin
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps12_01_sp_help_revlogin.ps1



$-----------------SQLPS13_TDE

Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SQLPS13_TDE.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe   C:\Users\User\OneDrive\download\PS1\SQLPS13_TDE.ps1

# 01 Setting up Transparent Data Encryption(TDE)  p.299

#    733  Lab  https://www.itread01.com/p/1214487.html  Dec.27.2019




$-----------------Sqlps14_backupRestore

Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\Sqlps14_backupRestore.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe   C:\Users\User\OneDrive\download\PS1\Sqlps14_backupRestore.ps1


{<#
# 1  交易記錄檔的使用狀況
# 2  截斷交易記錄 &  簡單完整模式
# 3  移動資料或記錄檔
# 123  壓縮記錄檔  SHRINK   FILE
# 136  FreeSpaceMB  datafile available  logfile  可使用百分比
# 5  結尾記錄備份 
# 6 127   備份  mediapassword
# 7  還原資料庫 + 移動檔案  
# 8  交易記錄還原到標記
# 9  清除檔案 
# 10 200 Changing database recovery model  using SMO p.30
# 11  300  Listing backup history  P309
# 12 300  Creating a backup device  p.310 
# 13 Listing backup header and file listinformation  p312
# 14  400  Creating a full backup  p316
# 15  500  Creating a backup on mirrored media sets  p321
# 16 550  Creating a differential backup   p324
# 17 600  Creating a transcation log  backup   p327
# 18 600  Creating a filegroup backup   p329
# 19    Restoring a database to a point in time   p332
# 20 800 Performing an online piecemeal restore p.34
# 21  800 Recovery-Only Database Restore  在不還原資料的情況下復原資料庫
# 22 How to read the SQL Server Database Transaction Log   sys.fn_dblog(NULL,NULL)
# 23  929  LSN 
# 24 2166   Recovery Paths 復原路徑
# 25 2200  Piecemeal Restore of Databases  分次還原
# 26 2353    Logspace  DBSizeInfo
#   2624    超大数据库的备份和恢复问题：分区表、文件组备份、部分还原  partial backup
#   2689  --# lab06   Partition  FileGroup  Backup ＆　Restore 
#    2678    lab for backup & restore     
#>}

$-----------------SQLPS15_Mirroring

Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SQLPS15_Mirroring.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS15_Mirroring.ps1


#  48  將用戶端連接至資料庫鏡像工作階段 (SQL Server
#  69  often maintain TSQL  卡在“恢復”狀態
# 111  view & check 
# 138  setp 1  @PrincipalHost
# 173  step 2  Endpoints  @ MirroringHost
# 202  step 3  backup   mingDB       @ PrincipalHost
# 223  step 4  backup   mingDB       @ MirroringHost
# 250  step 5  backup   mingDB       @ PrincipalHost
# 263  step 6  @ MirroringHost
# 288  step 7   @ MirroringHost
# 316  step 8   @ MirroringHost
# 378  mirroring work  tsql  常用指令
# 388  mirroring  實測步驟
# 400  Estimate the Interruption of Service During Role Switching 
# 439  mirroring system View
# 469  Use Warning Thresholds and Alerts on Mirroring Performance Metrics
#      620  資料庫鏡像作業模式 (文件用)
#   713   sp_dbmmonitorresults
#  743 SQLServer:Database Mirroring  PCR


$-----------------SQLPS16_ResourceManager

C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS16_ResourceManager.ps1





$-----------------Sqlps17_Triggers
{<#
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps17_triggers.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps17_Triggers.ps1

#  50  DML trigger  新增更改刪除 another Table
#  200 DDL trigger   
#  300  RAISERROR 透過對 CREATE_TABLE 事件建立觸發程序，記錄建立者的帳號到 Windows Event Log
#  350  DDL 觸發程序搭配資料表記錄使用者對資料庫的變更動作
#  400   sys.messages 目錄檢檢視
#  485   登入觸發程序  Logon Triggers
#  513   creating a DDL trigger for the CREATE LOGIN facet which sends an email via sp_send_dbmail
#  535  使用 EVENTDATA 函數
#  607 DML  trigger  for DGPA 
#  1011  DAC
#>}

$-----------------SQLPS18_Profiler
{<#
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS18_Profiler.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS18_Profiler.ps1



#1  Enabling/disabling change tracking            p.275
#2  Running and saving a profiler trace event     p.276
#3  200  Extracting the contents of a trace file  p.284
#   446  trc to sql_table   以T-SQL分析存放在資料表內錄製的結果
#   491 get-sqlprofiler
#  506     分析  trc


#>}

$-----------------Sqlps19_Agent
{<#
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps19_Agent.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\Sqlps19_Agent.ps1




#>}

$-----------------Sqlps20_policy
{<#
# 1：建立目標資料庫Northwind_PBM與使用者預存程序：dbo.sp_haha01
# 2：建立不符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為sp_
# 3：建立符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為np_
# 4：測試「原則」：預存程序的物件名稱之前置詞不得為sp_
# 5：建立違反原則的使用者自定預存程序，並檢視其錯誤訊息
# 6：利用xp_cmdshell擴充預存程序，執行顯示目錄命令
# 7：以原則為基礎的管理與系統檢視
# 8：刪除「以原則為基礎的管理」的歷史紀錄
# 9       Listing facets and facet properties  p252
# 10      Listing / Exporting  policies  p.254
# 11      Creating a condition  p.264
# 12  700  Creating  /Evaluating  a policy P.268
#  13   800 PBM default for alwayson
#  14   900 msdb.dbo.syspolicy_policies  for alwayson
#  15  900  msdb.dbo.syspolicy_conditions   msdb.dbo.syspolicy_conditions_internal    for alwayson
#  16  950  look for all  properties facts      Microsoft.SqlServer.Management.Smo Namespace
#>}
$-----------------SQLPS21_BI

powershell_ise \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS21_BI.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe  C:\Users\User\OneDrive\download\PS1\SQLPS21_BI.ps1
{<#
#  27   Analysis Services PowerShell
#  187  invoke-ascmd
#  204  Backup  & restore ASDatabase
#  211  deploy   manage & security  SSAS
#  230  SQL Server Analysis Services 教學課程
#  309  Using powerPivot  in excel 2013
#  333  Using power view
#  385   Troubleshooting    SSAS startup failure
#  396    SSISDB 目錄  catalog
#  407    SSIS configuration  deploy package   Dtutil 
#  474    SSIS run  package   Dtexec  log
#  575    SSDT for VS2013  VS2015  VS2017   575   devenv  VS
#  674    SSDT for  VS2017   20170715   20190123
#  612  ebook  index   
#    1   795  Listing items in your SSRS Report Server  p386
#    2   816  Listing SSRS report properties   p388
#    3   832  Using ReportViewer to view your SSRS report   391
#    4   889  Downloading an SSRS report in Excel and PDF  p396
#    5   942  Creating an SSRS folder  p400
#    6   982  Creating an SSRS data source  p404
#  1036  Install-Module -Name ReportingServicesTools  SSRS
#  1144  deploy RDL to server     SSRS
#  1028  Test     SSRS
#  1241    Monitoring Report Server Performance
#  1301    Performance Counters - ReportServer Service, Performance Objects
#  1339    DAX
#  1416    SSRS 2019   匿名登入的設定步驟 ( Anonymous Access )
#>}




$-----------------SQLPS25_FullText
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe    C:\Users\User\OneDrive\download\PS1\SQLPS25_FullText.ps1


$-----------------SQLPS24_inmemory
Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SQLPS24_inmemory.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe    C:\Users\User\OneDrive\download\PS1\SQLPS24_inmemory.ps1
#    2138   inmemory  table sample  how to know  is_memory_optimized



$-----------------SQLPS26_SQLTuning
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe    C:\Users\User\OneDrive\download\PS1\SQLPS26_SQLTuning.ps1

#   13    pptfilelist

#   165     SQL memeory      足夠不夠用
#   496     database page    DBCC IND >  sys.dm_db_database_page_allocations.  >    sys.dm_db_page_info
#   641     DBCC PAGE        GAM和   SGAM    PFS

ii C:\WorkLog\BOP\Proposal_Kickoff
ii  C:\MyDataIII\Ming2020

gci C:\WorkLog\BOP\Proposal_Kickoff |select Name

Name                                                       
----                                                       
01_Kickoff_20200622V1.pptx                                 
02_SQL Server SSIS介紹.pptx                                  
03_SSIS_parameter.pptx                                     
04_Cluster_addResource.pptx                                
05_Aplist.pptx                                             
06_ActiveX.pptx                                            
07_Aplist_1012.pptx                                        
08_NT33_LIST_20201105.pptx                                 
09_SSIS_Environment_Variable.pptx                          
10_SSIS_Catalog.pptx                                       
11_PackageDesign_0109.pptx                                 
12_SampleDtsx_0005.pptx                                    
13_Cluster_addResource.pptx                                
14_SendMail.pptx                                           
15_SampleDtsx_Loop1.pptx                                   
16_ForLoopContainer.zip                                    
16_SampleDtsx_Loop2.pptx                                   
17_SampleDtsx_0126.pptx                                    
18X_PackageDeploy.pptx                                     
19_SampleDtsx_0174.pptx                                    
20_SampleDtsx_0209.pptx                                    
21_NT33_20210112.pptx                                      
22_FEP_20210205.pptx                                       
23_Table_PK_Heap.pptx                                      
24_Excel_255.pptx                                          
'25_BOP Cohesity Test with MSSQL.docx'                       
'25_BOP Cohesity Test with MSSQL.pptx'                       
26_Executing SSIS Package with SQL Authentication - 複製.pptx
27_Encoding.pptx      # 27_Encoding.zip                                            
28_architecture.pdf   # 28_unattach.zip                                            
28_unattachAttachBackupRestore.pptx                        
29_LinkedServer.pptx  # 29_LinkedServer.txt                                        
29_linkedServer.zip                                        
30_TLS1.2.pptx        #30_TLS1.2.txt                                              
31_DataProvider.pptx  #31_DataProvider.zip   ; 31_LinkedServer.txt  ; 31_netFramework.txt  ;31_ODBC.txt  ;31_OLEDB.txt                                               
32_Database_Page.pptx                                      
33_Execution_Plan.pptx   #   ii  C:\WorkLog\BOP\Proposal_Kickoff\33_Execution_Plan.pptx                                    
34_Recompilations.pptx   #   ii  C:\WorkLog\BOP\Proposal_Kickoff\34_Recompilations.pptx                             
35_Parellel.pptx                                           
36_StatisticsInfo.pptx    #   ii  C:\WorkLog\BOP\Proposal_Kickoff\36_StatisticsInfo.pptx                                    

38_SSIS_Installation.pptx                                  
39_Lock.pptx                                               
40_PerformanceAnalysisofLogs)PAL.pptx                      
41_WaitStatistics.pptx              #        ii C:\WorkLog\BOP\Proposal_Kickoff\41_WaitStatistics.pptx         wait                        
42_TempDB.pptx                                             
43_Index_Rebuild_Reorganize.pptx                           
44_BlockedProcess.pptx                #                                  
45_caseStudy效能測試.pptx                                      
46_Performance_overview.pptx          # ii C:\WorkLog\BOP\Proposal_Kickoff\46_Performance_overview.pptx                       
47_Performance_APM.pptx                                    
48_caseStudy_SQL2019 健檢.pptx                               
49_TraceFlag.pptx                     #  datafile logfile auto grow    ii  C:\WorkLog\BOP\Proposal_Kickoff\49_TraceFlag.pptx                                    
50_Replication.pptx                                        
51_caseStudy_SQLhappen.pptx  
52_Sizing.pptx                 # ii  C:\WorkLog\BOP\Proposal_Kickoff\52_Sizing.pptx  

53_ParameterSniffing.pptx      # ii  C:\WorkLog\BOP\Proposal_Kickoff\53_ParameterSniffing.pptx  

54_QueryStore.pptx         #  ii  C:\WorkLog\BOP\Proposal_Kickoff\54_QueryStore.pptx  ;  ii C:\MyDataIII\Ming2020\querystore

55_PlanCache.sql           #  ii  C:\WorkLog\BOP\Proposal_Kickoff\55_PlanCache.pptx     ii  C:\WorkLog\BOP\Proposal_Kickoff\55_PlanCache.sql 

56_SQL_BufferCache.pptx    #  ii  C:\WorkLog\BOP\Proposal_Kickoff\56_SQL_BufferCache.pptx    , ii  C:\WorkLog\BOP\Proposal_Kickoff\56_SQL_BufferCache.sql  

57_Performance_processor.pptx    
58_Performance_memory.pptx   
59_Performance_disk.pptx            #  ii  C:\WorkLog\BOP\Proposal_Kickoff\59_Performance_disk.pptx  
60_Performance_Network.pptx         #  ii  C:\WorkLog\BOP\Proposal_Kickoff\60_Performance_Network.pptx  
61_Performance_SQL+counter.pptx     #  ii  C:\WorkLog\BOP\Proposal_Kickoff\61_Performance_SQL+counter.pptx  
62_擴充事件ExtendedEvents.pptx        #  ii  C:\WorkLog\BOP\Proposal_Kickoff\62_擴充事件ExtendedEvents.pptx  
63_PLA                              # ii  C:\WorkLog\BOP\Proposal_Kickoff\63_PLA.pptx 
64_monitor_alwayson.pptx   
65_Performance_SOP.pptx           # ii  C:\WorkLog\BOP\Proposal_Kickoff\65_Performance_SOP.pptx 
66_Stress.pptx                    # ii  C:\WorkLog\BOP\Proposal_Kickoff\66_Stress.pptx 
67_Audit.pptx                     # ii  C:\WorkLog\BOP\Proposal_Kickoff\67_Audit.pptx 
                       
BOP_建議書_20200520v1.docx                                    
ErrorHandling.dtsx                                         
How to configure a Linked Server using the ODBC driver.pdf 
SQLNCLI10 _ SQL with Manoj.pdf                             
SSIS教育訓練課程課後問答實作.docx                                      
TLS1.2.pptx                                                


ii  'C:\MyDataIII\Ming2020\executePlan\Searching the SQL Server query plan cache.pdf'
ii  'C:\MyDataIII\Ming2020\querystore\SQL Compilations_sec is not what you think it is - Simple Talk.pdf'



$-----------------
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe    C:\Users\User\OneDrive\download\PS1\SQLPS27_GCB.ps1

# 019    密碼原則	系統管理者帳戶強制執行密碼逾期
#   056  強制執行密碼原則	強制執行密碼原則	
#   081  帳戶管理	 停用 sa帳戶
#   105  重新命名sa帳戶名稱
#   124  帳戶管理	MSSQL Server服務帳戶所屬群組
#   143  全文檢索服務帳戶所屬群組	
#   163  Guest帳戶之連線權限	
#   179  孤兒帳戶Orphaned
#   205  使用者身分驗證模式
#   233  自主資料庫使用者類型
#   266  預設服務埠	
#   281  msdb資料庫共用角色之SQL Server Agent Proxy存取權限
#   314  特定分散式查詢方式
#   341  跨資料庫擁有權鏈結
#   358  Database mail XPs
#   370  專用管理者連線	
#   392  隱藏執行個體	
#   416  自主資料庫自動關閉	
#   435  共通語言執行環境
#   461  Ole自動化程序	
#   386  遠端存取
#   508  掃描啟動程序	
#   527  Trustworthy	
#   542  xp_cmdshell	
#   569  範例資料庫	
#   591  錯誤記錄檔的最大數目	
#   605  預設追蹤	
#   629  登入稽核紀錄	
#   646  備份服務主金鑰	"
#   661  備份資料庫主金鑰
#   677  存取授權	TLS加密協定



$-----------------VB01_General
Powershell_ise   \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\VB01_General.ps1
C:\Users\User\Documents\WindowsPowerShell\Modules\PowerShellISE-preview\5.1.1\powershell_ise.exe    C:\Users\User\OneDrive\download\PS1\VB01_General.ps1

#  18  what is MSDTC        
#  52  官方文件   如何疑難排解 MS DTC 防火牆問題
#  22  syscom 33  devenv 
#   41  MSDTC   ref list
#   73  MSDTC   config
# 115 MSDTC   問題疑難排解
# TransactionScope  with  VB C#
#  278   立 Visual Studio 2017 的離線安裝

