
<#Sqlps18_Profiler
 C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps18_Profiler.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 LastDate : APR.27.2014
 object : tsql

 CH07_效能監視器、活動監視器與SQL Profiler.sql

#>


#1 Enabling/disabling change tracking  p.275
#2 Running and saving a profiler trace event p.276
#3  200  Extracting the contents of a trace file  p.284



































#-------------------------------------------------------------------
#1 Enabling/disabling change tracking  p.275
#-------------------------------------------------------------------


## Check which of your databases have change tracking enabled
SELECT
DB_NAME(database_id) AS 'DB',
*
FROM
sys.change_tracking_databases


##
(2). Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
(3). Add the following script and run:
$databasename = "TestDB"
$database = $server.Databases[$databasename]
$database.ChangeTrackingEnabled
$database.ChangeTrackingEnabled = $true
$database.Alter()
$database.Refresh()
$database.ChangeTrackingEnabled
To disable change tracking, you just need to set the database property
ChangeTrackingEnabled to false, and invoke the Alter method again.
$database.ChangeTrackingEnabled = $false
$database.Alter()

#-------------------------------------------------------------------
#2 Running and saving a profiler trace event p.276
#-------------------------------------------------------------------

##Getting ready
'To run and save a profiler trace event, we will need to use the x86 version of PowerShell and/or
PowerShell ISE. This is unfortunate, but some of the classes we need to use are only supported
in 32-bit mode

In this recipe, we will need to use the standard trace Template Definition File (TDF) as our
starting template for the trace we are going to run. 
This can be found in C:\Program Files(x86)\Microsoft SQL Server\110\Tools\Profiler\Templates\Microsoft SQL Server\110\Standard.tdf

For our purposes, we are also going to limit the number of events to 50.
'
(1). Open the PowerShell console by going to Start | Accessories | Windows PowerShell | Windows PowerShell ISE (x86).

(2). Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3). Import additional libraries. These are needed to use our TraceFile and
TraceServer classes. We do this as follows:
#load ConnectionInfoExtended, this contains TraceFile class
[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfoExtended") | Out-Null
#load ConnectionInfo, contains SqlConnectionInfo class
[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null

(4)Add the following script and run:
#create SqlConnectionInfo object,
#specifically required to run the traces
#need to specifically use the ConnectionInfoBase type
[Microsoft.SqlServer.Management.Common.ConnectionInfoBase]$conn =
New-Object Microsoft.SqlServer.Management.Common.SqlConnectionInfo
-ArgumentList "KERRIGAN"
$conn.UseIntegratedSecurity = $true
#create new TraceServer object
#The TraceServer class can start and read traces
$trcserver = New-Object -TypeName Microsoft.SqlServer.Management.
Trace.TraceServer
#need to get a handle to a Trace Template
#in this case we are using the Standard template
#that comes with Microsoft
$standardTemplate = "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Profiler\Templates\Microsoft SQL Server\110\Standard.tdf"
$trcserver.InitializeAsReader($conn,$standardTemplate) | Out-Null
$received = 0
#where do you want to write the trace?
#here we compose a timestamped file
$folder = "H:\Temp\"
$currdate = Get-Date -Format "yyyy-MM-dd_hmmtt"
$filename = "$($instanceName)_trace_$($currdate).trc"
$outputtrace = Join-Path $folder $filename
#number of events to capture
$numevents = 10
#create new TraceFile object
#and initialize as writer
#The TraceFile class can read and write a Trace File
$trcwriter = New-Object Microsoft.SqlServer.Management.Trace.TraceFile
$trcwriter.InitializeAsWriter($trcserver,$outputtrace) | Out-Null
while ($trcserver.Read())
{
#write incoming trace to file
$trcwriter.Write() | Out-Null
$received++
#we dont know how many columns are included
#in the template so we will have to loop if we
#want to capture and display all of them
#get number of columns
#we need to subtract 1 because column array
#is zero-based, ie index starts at 0
$cols = ($trcserver.FieldCount) -1
#we'll need to dynamically create a hash to
#contain the trace events
#because we need to dynamically build this hash
#based on number of columns included in a template,
#we'll have to store the code to build the hash
#as string first and then invoke expression
#to actually build the hash in PowerShell
$hashstr = "`$hash = `$null; `n `$hash = @{ `n"
for($i = 0;$i -le $cols; $i++)
{
$colname = $trcserver.GetName($i)
#add each column to our hash
#we will not capture the binary data
if($colname -ne "BinaryData")
{
$colvalue = $trcserver.GetValue($trcserver.
GetOrdinal($colname))
$hashstr += "`"$($colname)`"=`"$($colvalue)`" `n"
}
}
$hashstr += "}"
#create the real hash
Invoke-Expression $hashstr
#display
$item = New-Object PSObject -Property $hash
$item | Format-List
if($received -ge $numevents)
{
break
}
}
$trcwriter.Close()
$trcserver.Close()

#-------------------------------------------------------------------
#3  200  Extracting the contents of a trace file  p.284
#-------------------------------------------------------------------

'
We will need to use the x86 version of PowerShell and/or PowerShell ISE for this recipe. This
is unfortunate, but some of the classes we need to use are only supported in 32-bit mode.
In this recipe, we will use a previously saved trace (.trc) file. Feel free to substitute this with
a trace file that you have available
'
(3)3. Import additional libraries. These are needed to use our TraceFile and
TraceServer classes. We do this as follows:
#load ConnectionInfoExtended, this contains TraceFile class
[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.
ConnectionInfoExtended") |
Out-Null
#load ConnectionInfo, contains SqlConnectionInfo class
[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.
ConnectionInfo") |
Out-Null

(4)Add the following script and run:
#replace this with your own filename
$path = "C:\Temp\KERRIGAN_trace_2012-02-11_206PM.trc"
$trcreader = New-Object Microsoft.SqlServer.Management.Trace.TraceFile
$trcreader.InitializeAsReader($path)
#extract all
$result = @()
if($trcreader.Read())
{
while($trcreader.Read())
{
#let's extract only the ones that
#took more than 1000ms
$duration = $trcreader.GetValue($trcreader.GetOrdinal("Duration"))
if($duration -ge 1000)
{
$cols = ($trcreader.FieldCount) -1
#we need to dynamically build the hash string
#because we don't know how many columns
#are in the incoming trace file
$hashstr = "`$hash = @{ `n"
for($i = 0;$i -le $cols; $i++)
{
$colname = $trcreader.GetName($i)
#don't include binary data
if($colName -ne "BinaryData")
{
$colvalue = $trcreader.GetValue($trcreader.GetOrdinal($colname))
$hashstr += "`"$($colname)`"=`"$($colvalue)`" `n"
}
}
$hashstr += "}"
#create the real hash
Invoke-Expression $hashstr
$item = New-Object PSObject -Property $hash
$result += $item
}
}
}
#display
$result | Format-List





-------------------------------------------------------------------
--範例程式碼7-1：「處理序」區段所使用的系統預存程序
-------------------------------------------------------------------
SELECT
[工作階段識別碼] = s.session_id,
[使用者處理序] = CONVERT(CHAR(1), s.is_user_process),
[登入者] = s.login_name,
[資料庫] = ISNULL(db_name(r.database_id), N''),
[工作狀態] = ISNULL(t.task_state, N''),
[命令] = ISNULL(r.command, N''),
[應用程式] = ISNULL(s.program_name, N''),
[等候時間(毫秒)] = ISNULL(w.wait_duration_ms, 0),
[等候類型] = ISNULL(w.wait_type, N''),
[等候資源] = ISNULL(w.resource_description, N''),
[封鎖者] = ISNULL(CONVERT (varchar, w.blocking_session_id), ''),
[源頭封鎖者] =
CASE
-- session has an active request, is blocked, but is blocking others
SELECT 
   [工作階段識別碼]    = s.session_id, 
   [使用者處理序]  = CONVERT(CHAR(1), s.is_user_process),
   [登入者]         = s.login_name,   
   [資料庫]      = ISNULL(db_name(r.database_id), N''), 
   [工作狀態]    = ISNULL(t.task_state, N''), 
   [命令]       = ISNULL(r.command, N''), 
   [應用程式]   = ISNULL(s.program_name, N''), 
   [等候時間(毫秒)]     = ISNULL(w.wait_duration_ms, 0),
   [等候類型]     = ISNULL(w.wait_type, N''),
   [等候資源] = ISNULL(w.resource_description, N''), 
   [封鎖者]    = ISNULL(CONVERT (varchar, w.blocking_session_id), ''),
   [源頭封鎖者]  = 
    CASE 
     -- session has an active request, is blocked, but is blocking others
    WHEN r2.session_id IS NOT NULL AND r.blocking_session_id = 0 THEN '1' 
     -- session is idle but has an open tran and is blocking others
    WHEN r.session_id IS NULL THEN '1' 
     ELSE ''
     END, 
   [CPU (ms)] = s.cpu_time, 
   [實體I/O (MB)]   = (s.reads + s.writes) * 8 / 1024, 
   [記憶體使用量(KB)]  = s.memory_usage * 8192 / 1024, 
   [開起交易] = ISNULL(r.open_transaction_count,0), 
   [登入時間]    = s.login_time, 
   [工作階段最後一項要求的開始時間] = s.last_request_start_time,
   [主機]     = ISNULL(s.host_name, N''),
   [網路位置]   = ISNULL(c.client_net_address, N''), 
   [執行內容識別碼] = ISNULL(t.exec_context_id, 0),
   [要求的識別碼] = ISNULL(r.request_id, 0),
   [Workload Group] = ISNULL(g.name, N'')
INTO #snapshot_processinfo
FROM sys.dm_exec_sessions s 
LEFT OUTER JOIN sys.dm_exec_connections c ON (s.session_id = c.session_id)
LEFT OUTER JOIN sys.dm_exec_requests r ON (s.session_id = r.session_id)
LEFT OUTER JOIN sys.dm_os_tasks t 
ON (r.session_id = t.session_id AND r.request_id = t.request_id)
LEFT OUTER JOIN 
(
    SELECT *, ROW_NUMBER() OVER (PARTITION BY waiting_task_address
    ORDER BY wait_duration_ms DESC) AS row_num
    FROM sys.dm_os_waiting_tasks 
) w ON (t.task_address = w.waiting_task_address) AND w.row_num = 1
LEFT OUTER JOIN sys.dm_exec_requests r2 
ON (r.session_id = r2.blocking_session_id)
LEFT OUTER JOIN sys.dm_resource_governor_workload_groups g 
ON (g.group_id = s.group_id)
ORDER BY s.session_id;


-------------------------------------------------------------------
--範例程式碼7-2：呈現有可疑交易狀態的程序資料
-------------------------------------------------------------------
--透過  [處理序識別碼]>=52 列出使用者的查詢語法
select * from #snapshot_processinfo where [工作階段識別碼]>=52

--交易狀況有問題
select * from #snapshot_processinfo where [開起交易]> 0 AND RTRIM(工作狀態) = 'sleeping'
--等待時間過長
SELECT * FROM #snapshot_processinfo WHERE [等候時間(毫秒)]> 1000
--CPU 使用量過大
SELECT * FROM #snapshot_processinfo WHERE [CPU (ms)] > 1000


-------------------------------------------------------------------
--範例程式碼7-3：透過迴圈新增大量資料
-------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects 
           WHERE object_id = OBJECT_ID(N'dbo.T') AND type in (N'U'))
DROP TABLE dbo.T
GO
CREATE TABLE dbo.t
   (
   c1 nchar(100) NULL DEFAULT 'hello'
   )  
GO

insert t default values

declare @i int
set @i=1
while @i<=30
begin
   insert t select * from t
   set @i=@i+1
end


-------------------------------------------------------------------
--範例程式碼7-4：透過SQL Profiler建立執行在伺服器端的追蹤
-------------------------------------------------------------------
/****************************************************/
/* Created by: SQL Server 2008 Profiler             */
/* Date: 2009/04/09  10:09:13 PM         */
/****************************************************/


-- Create a Queue
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
set @maxfilesize = 5 

-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

exec @rc = sp_trace_create @TraceID output, 0, N'InsertFileNameHere', @maxfilesize, NULL 
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 14, 1, @on
exec sp_trace_setevent @TraceID, 14, 9, @on
exec sp_trace_setevent @TraceID, 14, 6, @on
exec sp_trace_setevent @TraceID, 14, 10, @on
exec sp_trace_setevent @TraceID, 14, 14, @on
…


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - 1086ed94-5208-4488-9611-5f4c363c9948'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
/*
--若要傳回所有追蹤的相關資訊，
--請指定此參數的預設值：關鍵字 'default'
SELECT * FROM fn_trace_getinfo(default)

--停掉追蹤，並移除定義，sp_trace_setstatus 執行兩次
--第一次設定 0，停止追蹤。第二次設定 2 刪除追蹤。
sp_trace_setstatus 1,0
sp_trace_setstatus 1,2

sp_configurate 
*/



-------------------------------------------------------------------
--範例程式碼7-5：以T-SQL分析存放在資料表內錄製的結果
-------------------------------------------------------------------
/*分析 Trace 所得的資料*/
-- 原始資料在「工作負載檔案」，透過暫時資料表
-- 來分析
SELECT  *
INTO #Temp 
FROM  fn_trace_gettable('c:\myTrace.trc', default)

--對 Recompile 的現象做分析
SELECT   EventClass, TextData, SPID, Duration, CPU, Reads, Writes 
FROM      #Temp 
WHERE   Duration > 10  
OR TextData LIKE '%Text%' 
OR EventClass = 37  -- sp:Recompile 事件 
OR StartTime BETWEEN '20090410' 
AND '20090412 15:00'
ORDER BY Duration DESC

-- 追蹤所得的資料本來就在資料表內，直接透過 T-SQL 分析
SELECT SUBSTRING(TextData, 1,30) AS '名稱',
COUNT(*) '數量',
AVG(duration) AS '平均執行時間(ms)',
AVG(cpu) AS '平均 CPU 時間(ms)',
AVG(reads) AS '平均閱讀次數',
AVG(writes) AS '平均寫入次數'
FROM #Temp
WHERE EventClass=12    -- 12 代表 SQL:BatchCompleted 事件
GROUP BY SUBSTRING(TextData, 1,30)

--找出一段時間內，最耗時的 SQL 語法
SELECT SUBSTRING(TextData, 1,150) AS '名稱',
COUNT(*) '數量',
SUM(duration) AS '總執行時間(ms)',
AVG(duration) AS '平均執行時間(ms)',
AVG(cpu) AS '平均 CPU 時間(ms)',
AVG(reads) AS '平均閱讀次數',
AVG(writes) AS '平均寫入次數'
FROM #Temp
GROUP BY SUBSTRING(TextData, 1,150)
ORDER BY SUM(duration) DESC










