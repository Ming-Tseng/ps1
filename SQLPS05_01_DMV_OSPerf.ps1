<#  SQLPS0502_DMV_OSPerf
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.21.2014
 history : 
 object : tsql 
 Parent SQLPS05_DMV

#>SQLPS0501_DMV
## CPU
## memory
## Disk
## Network

#---------------------------------------------------------------
#  About CPU DMV
#---------------------------------------------------------------
sys.dm_os_memory_clerks — Memory clerks are used by SQL Server to allocate memory. Significant components within SQL Server have their own memory clerk. This DMV shows all the memory clerks and how much memory each one is using. 
sys.dm_os_performance_counters
sys.dm_os_schedulers — Returns one row per scheduler (remember, there is one user scheduler per logical processor) and displays information about scheduler load and health. 
sys.dm_os_sys_info
sys.dm_os_wait_stats
sys.dm_os_waiting_tasks — Returns one row for every executing task that is currently waiting for a resource, as well as the wait type

sys.dm_os_workers 


## sys.dm_os_schedulers
 SQL Server 中的每個排程器，各傳回一個資料列，其中每個排程器都會對應至個別的處理器。 請利用這份檢視來監視排程器的狀況或識別失控的工作

 SELECT
    scheduler_id  as [排程器的識別碼], --識別碼大於或等於 1048576 的排程器是 SQL Server 內部使用的排程器,  
    cpu_id  as [派給排程器的 CPU 識別碼],
    parent_node_id as [排程器所屬節點],
    current_tasks_count  as [目前工作數目],
    runnable_tasks_count as  [等候排程到可執行佇列上的工作者數目],
    current_workers_count  ,
    active_workers_count,
    work_queue_count as [暫止佇列中的工作數目]
  FROM sys.dm_os_schedulers
  where scheduler_id < 1048576 ;

## sys.dm_os_waiting_tasks



#---------------------------------------------------------------
#  Get   max  worker threads 
#---------------------------------------------------------------
session make 
request divides into 'worker thread'
thread  run  one scheduler  (running , suspended , runnable )
   	• Total available logical CPUs <= 4
        ○ Max Worker Threads = 512
	• Total available logical CPUs > 4
		○ Max Worker Threads = 512 + ((logical CPUs - 4)*16)
ex : 16 logical CPUs = 512 + ((16–4)*16) = 704

SELECT max_workers_count
FROM sys.dm_os_sys_info
#---------------------------------------------------------------
# sys.dm_os_workers
#---------------------------------------------------------------
Each worker thread requires 2MB of RAM on a 64-bit server and 0.5MB on a 32-bit server,
 so SQL Server creates threads only as it needs them, rather than all at once.

The sys.dm_os_workers DMV contains one row for every worker thread, so you can see how many threads SQL Server currently has by executing the following:

SELECT count(*) FROM sys.dm_os_workers --Get  worker thread

##


#---------------------------------------------------------------
#  Find out how long a worker has been running in a SUSPENDED or RUNNABLE state.
#---------------------------------------------------------------

SELECT 
    t1.session_id as [工作階段識別碼],
    CONVERT(varchar(10), t1.status) AS status, --[背景,執行中,可執行的runnable,休眠中,已暫停]
    CONVERT(varchar(15), t1.command) AS [目前所處理命令的類型],
    CONVERT(varchar(10), t2.state) AS [工作者狀態], --工作者狀態。 可以是下列其中一個值：
--INIT = 目前正在初始化的工作者。
--RUNNING = 工作者目前以非先佔式或先佔式執行。
--RUNNABLE = 工作者準備在排程器執行 CPU interanl wait。
--SUSPENDED = 工作者目前暫停，等待事件傳送信號給它 other Resource Wait。
    --w_suspended = 
      CASE t2.wait_started_ms_ticks
        WHEN 0 THEN 0
        ELSE 
          t3.ms_ticks - t2.wait_started_ms_ticks
      END as  [進入 SUSPENDED 狀態時，毫秒數 ] ,
    --w_runnable = 
      CASE t2.wait_resumed_ms_ticks
        WHEN 0 THEN 0
        ELSE 
          t3.ms_ticks - t2.wait_resumed_ms_ticks
      END as [進入 RUNNABLE 狀態 毫秒數 ]
  FROM sys.dm_exec_requests AS t1
  INNER JOIN sys.dm_os_workers AS t2 ON t2.task_address = t1.task_address
  CROSS JOIN sys.dm_os_sys_info AS t3
  WHERE t1.scheduler_id IS NOT NULL and t1.session_id >50 ;


  --select wait_started_ms_ticks,wait_resumed_ms_ticks  from  sys.dm_os_workers


#---------------------------------------------------------------
#   Clearing sys.dm_os_wait_stat  Per
#---------------------------------------------------------------
DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR);

#---------------------------------------------------------------
#   sys.dm_os_wait_stats  P.267
#---------------------------------------------------------------
##
http://msdn.microsoft.com/zh-tw/library/ms179984.aspx

這些統計資料在 SQL Server 重新啟動之後都不會保存下來，而且所有的資料都是從上次統計資料重設或伺服器啟動之後開始累加計算
select 
wait_type as [此類型的名稱]
,waiting_tasks_count as [此類型等候次數,從每次開始等候時逐量遞增計算]
,wait_time_ms as [此等候類型總等候時間]
,max_wait_time_ms AS [最大總等候時間]
,signal_wait_time_ms as [此類型累積CPU internal wait]
 from sys.dm_os_wait_stats
 order by wait_time_ms desc
##

DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR);
 
 waitfor delay '00:00:10'

 SELECT TOP 10
wait_type as [此類型的名稱] 
,waiting_tasks_count as [此類型累積總次數]
,wait_time_ms / 1000.0 AS  [此等候類型總等候時間單位秒] 
,CASE WHEN waiting_tasks_count = 0 THEN NULL
ELSE wait_time_ms / 1000.0 / waiting_tasks_count
END AS [平均每次等多少秒] 
,
max_wait_time_ms / 1000.0 AS [最大曾經總等候時間]
,( wait_time_ms - signal_wait_time_ms ) / 1000.0 AS [等候CPU外的資源單位秒]
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN --tasks that are actually good or expected
--to be waited on
( 'CLR_SEMAPHORE', 'LAZYWRITER_SLEEP', 'RESOURCE_QUEUE', 'SLEEP_TASK',
'SLEEP_SYSTEMTASK', 'WAITFOR' )
ORDER BY waiting_tasks_count DESC

#---------------------------------------------------------------
#   Report on top resource waits. 此資源等待百分比wait_time_percentage  P.270
#---------------------------------------------------------------
-- Isolate top waits for server instance since last restart
-- or statistics clear
WITH Waits
AS ( SELECT wait_type ,
wait_time_ms / 1000. AS wait_time_sec 
,100. * wait_time_ms / SUM(wait_time_ms) OVER ( ) AS pct 
--,ROW_NUMBER() OVER ( ORDER BY wait_time_ms DESC ) AS rn
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ( 'CLR_SEMAPHORE', 'LAZYWRITER_SLEEP',
'RESOURCE_QUEUE', 'SLEEP_TASK',
'SLEEP_SYSTEMTASK',
'SQLTRACE_BUFFER_FLUSH', 'WAITFOR',
'LOGMGR_QUEUE', 'CHECKPOINT_QUEUE' )
)
SELECT wait_type ,
CAST(wait_time_sec AS DECIMAL(12, 2)) AS [wait_time_sec] ,
CAST(pct AS DECIMAL(12, 2)) AS [此資源等待百分比wait_time_percentage]
FROM Waits
WHERE pct > 1
ORDER BY wait_time_sec DESC

#---------------------------------------------------------------
#   Investigating locking waits  P.272
#---------------------------------------------------------------

SELECT wait_type ,
waiting_tasks_count ,
wait_time_ms ,
max_wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type LIKE 'LCK%' AND Waiting_tasks_count > 0
ORDER BY waiting_tasks_count DESC




#---------------------------------------------------------------
#  Investigating CPU pressure    P.273
#---------------------------------------------------------------
-- Total waits are wait_time_ms (high signal waits indicates CPU pressure)
SELECT 
 CAST(100.0 * SUM(signal_wait_time_ms) / SUM(wait_time_ms) AS NUMERIC(20,2))                 AS [%signal (cpu) waits] 
,CAST(100.0 * SUM(wait_time_ms - signal_wait_time_ms) / SUM(wait_time_ms) AS NUMERIC(20, 2)) AS [%resource waits]
FROM sys.dm_os_wait_stats ;

16.27	83.73



#---------------------------------------------------------------
#  dm_os_performance_counters
#---------------------------------------------------------------

SELECT DISTINCT
cntr_type
FROM sys.dm_os_performance_counters
ORDER BY cntr_type

•65792 = PERF_COUNTER_LARGE_RAWCOUNT – p directly,
• 272696576 = PERF_COUNTER_BULK_COUNT – provides the average number of operations per second. 
• 537003264 = PERF_LARGE_RAW_FRACTION –  ratio.
• 1073874176 = PERF_AVERAGE_BULK – average number ofoperations completed during a time interval
• 1073939712 = PERF_LARGE_RAW_BASE, translation


• directly usable values (PERF_COUNTER_LARGE_RAWCOUNT)
• ratios (PERF_LARGE_RAW_FRACTION)
• average number of operations per second (PERF_COUNTER_BULK_COUNT)
• average number of operations (PERF_AVERAGE_BULK).
#---------------------------------------------------------------
#  Returning the values of directly usable PerfMon counters
#---------------------------------------------------------------
DECLARE @PERF_COUNTER_LARGE_RAWCOUNT INT
SELECT @PERF_COUNTER_LARGE_RAWCOUNT = 65792
SELECT object_name ,
counter_name ,
instance_name ,
cntr_value
FROM sys.dm_os_performance_counters
WHERE cntr_type = @PERF_COUNTER_LARGE_RAWCOUNT
ORDER BY object_name ,
counter_name ,
instance_name



#---------------------------------------------------------------
#  transaction log 擴大總次數 &縮小的總次數
#---------------------------------------------------------------
DECLARE @object_name SYSNAME
SET @object_name = 
CASE 
WHEN @@servicename = 'MSSQLSERVER' THEN 'SQLServer'
ELSE 'MSSQL$' + @@serviceName
END + ':Databases'

Print @object_name 
DECLARE @PERF_COUNTER_LARGE_RAWCOUNT INT
SELECT @PERF_COUNTER_LARGE_RAWCOUNT = 65792

SELECT object_name ,
counter_name ,
instance_name ,
cntr_value
FROM sys.dm_os_performance_counters
WHERE cntr_type = @PERF_COUNTER_LARGE_RAWCOUNT
AND object_name = @object_name
AND counter_name IN ( 'Log Growths', 'Log Shrinks' )
AND cntr_value > 0
ORDER BY object_name ,
counter_name ,
instance_name


#---------------------------------------------------------------
#  監視指定為已被取代的功能   p279
#---------------------------------------------------------------
http://technet.microsoft.com/zh-tw/library/bb510662.aspx
DECLARE @object_name SYSNAME
SET @object_name = CASE WHEN @@servicename = 'MSSQLSERVER' THEN 'SQLServer'
ELSE 'MSSQL$' + @@serviceName
END + ':Deprecated Features'
DECLARE @PERF_COUNTER_LARGE_RAWCOUNT INT
SELECT @PERF_COUNTER_LARGE_RAWCOUNT = 65792

SELECT object_name ,
counter_name ,
instance_name ,
cntr_value
FROM sys.dm_os_performance_counters
WHERE cntr_type = @PERF_COUNTER_LARGE_RAWCOUNT
AND object_name = @object_name
AND cntr_value > 0


#---------------------------------------------------------------
#  Returning the current value for the buffer cache hit ratio.   p282
#---------------------------------------------------------------
Returning the current value for the buffer cache hit ratio.

DECLARE @object_name SYSNAME
SET @object_name = CASE WHEN @@servicename = 'MSSQLSERVER' THEN 'SQLServer'
ELSE 'MSSQL$' + @@serviceName
END + ':Buffer Manager'
DECLARE
@PERF_LARGE_RAW_FRACTION INT ,
@PERF_LARGE_RAW_BASE INT
SELECT @PERF_LARGE_RAW_FRACTION = 537003264 ,
@PERF_LARGE_RAW_BASE = 1073939712
SELECT dopc_fraction.object_name ,
dopc_fraction.instance_name ,
dopc_fraction.counter_name ,
--when divisor is 0, return I return NULL to indicate
--divide by 0/no values captured
CAST(dopc_fraction.cntr_value AS FLOAT)
/ CAST(CASE dopc_base.cntr_value
WHEN 0 THEN NULL
ELSE dopc_base.cntr_value
END AS FLOAT) AS cntr_value
FROM sys.dm_os_performance_counters AS dopc_base
JOIN sys.dm_os_performance_counters AS dopc_fraction
ON dopc_base.cntr_type = @PERF_LARGE_RAW_BASE
AND dopc_fraction.cntr_type = @PERF_LARGE_RAW_FRACTION
AND dopc_base.object_name = dopc_fraction.object_name
AND dopc_base.instance_name = dopc_fraction.instance_name
AND ( REPLACE(dopc_base.counter_name,
'base', '') = dopc_fraction.counter_name
--Worktables From Cache has "odd" name where
--Ratio was left off
OR REPLACE(dopc_base.counter_name,
'base', '') = ( REPLACE(dopc_fraction.counter_name,
'ratio', '') )
)
WHERE dopc_fraction.object_name = @object_name
AND dopc_fraction.instance_name = ''
AND dopc_fraction.counter_name = 'Buffer cache hit ratio'
ORDER BY dopc_fraction.object_name ,
dopc_fraction.instance_name ,
dopc_fraction.counter_name







#---------------------------------------------------------------
#  CPU configuration details.
#---------------------------------------------------------------


SELECT cpu_count AS [Logical CPU Count] ,
hyperthread_ratio AS [Hyperthread Ratio] ,
cpu_count / hyperthread_ratio AS [Physical CPU Count] ,
physical_memory_in_bytes / 1048576 AS [Physical Memory (MB)] ,
sqlserver_start_time
FROM sys.dm_os_sys_info ;

SELECT cpu_count AS [Logical CPU Count] ,
hyperthread_ratio AS [Hyperthread Ratio] ,
cpu_count / hyperthread_ratio AS [Physical CPU Count] ,
physical_memory_kb / 1048576 AS [Physical Memory (GB)] ,
sqlserver_start_time
FROM sys.dm_os_sys_info ;




#---------------------------------------------------------------
#  Interrogating memory configuration. p.291
#---------------------------------------------------------------

DECLARE @ServerAddressing AS TINYINT
SELECT @serverAddressing = CASE WHEN CHARINDEX('64',
CAST(SERVERPROPERTY('Edition')
AS VARCHAR(100))) > 0
THEN 64
ELSE 32
END ;

SELECT cpu_count / hyperthread_ratio AS SocketCount ,
physical_memory_in_bytes / 1024 / 1024 AS physical_memory_mb ,
virtual_memory_in_bytes / 1024 / 1024 AS sql_max_virtual_memory_mb ,
-- same with other bpool columns as they are page oriented.
-- Multiplying by 8 takes it to 8K, then / 1024 to convert to mb
bpool_committed * 8 / 1024 AS buffer_pool_committed_mb ,
--64 bit OS does not have limitations with addressing as 32 did
CASE WHEN @serverAddressing = 32
THEN CASE WHEN virtual_memory_in_bytes / 1024 /
( 2048 * 1024 ) < 1
THEN 'off'
ELSE 'on'
END
ELSE 'N/A on 64 bit'
END AS [/3GB switch]
FROM sys.dm_os_sys_info



#---------------------------------------------------------------
#  Temp
#---------------------------------------------------------------




#---------------------------------------------------------------
#  Temp
#---------------------------------------------------------------





#---------------------------------------------------------------
#  Temp
#---------------------------------------------------------------




#---------------------------------------------------------------
#  Temp
#---------------------------------------------------------------






#---------------------------------------------------------------
#  SQL Server 中的 SQLServer:Databases 物件提供計數器，
#可用來監視大量複製作業、備份和還原輸送量以及交易記錄活動。 監視交易和交易記錄檔，可以判斷資料庫中有多少使用者活動，以及交易記錄檔有多滿。 使用者活動量可用來判斷資料庫的效能，並且會影響記錄檔大小、鎖定和複寫。 監視低階記錄檔活動，則可量測使用者活動和資源使用量，以協助您找出效能瓶頸
#---------------------------------------------------------------

http://technet.microsoft.com/zh-tw/library/ms190382.aspx


#---------------------------------------------------------------
#  SQL Server 所提供的物件與計數器，可供「系統監視器」用來對執行 SQL Server 執行個體的電腦監視其中的活動
#---------------------------------------------------------------
http://technet.microsoft.com/zh-tw/library/ms190382.aspx

(1)SQL Server Agent 效能物件

(2)Service Broker 效能物件

(3)SQL Server 效能物件 
  
SQLServer:Access Methods    搜尋並測量 SQL Server 資料庫物件的配置 (例如索引搜尋數或配置給索引和資料的頁數)。
SQLServer:Backup Device     提供備份和還原作業所使用的備份裝置相關資訊，例如備份裝置的輸送量。
SQLServer:Buffer Manager    提供 SQL Server 所使用之記憶體緩衝區的相關資訊，例如 freememory 與 buffer cache hit ratio。
SQLServer:Buffer Node      提供 SQL Server 要求及存取可用頁面的頻率相關資訊。
SQLServer:CLR  提供有關 Common Language Runtime (CLR) 的資訊。
SQLServer:Cursor Manager by Type   提供關於資料指標的資訊。
SQLServer:Cursor Manager Total     提供關於資料指標的資訊。
SQLServer:Database Mirroring    提供資料庫鏡像的相關資訊。
SQLServer:Databases    提供 SQL Server 資料庫的相關資訊，例如可用的記錄空間量，或資料庫中的使用中交易數目。 本物件中含有多項執行個體。
SQLServer:Deprecated Features   此值會計算使用之已被取代功能的次數。
SQLServer:Exec Statistics  提供執行統計資料的相關資訊。
SQLServer:General Statistics  提供一般伺服器範圍活動的相關資訊，例如目前連接到 SQL Server 執行個體的使用者數目。
SQLServer:HADR            可用性複本  提供 SQL Server AlwaysOn 可用性群組 可用性複本的相關資訊。
SQLServer:HADR            資料庫複本  提供 SQL ServerAlwaysOn 可用性群組 資料庫複本的相關資訊。
SQLServer:Latches          針對 SQL Server 所使用之內部資源 (例如資料庫頁面) 的閂鎖，提供相關資訊。
SQLServer:Locks            提供 SQL Server 所提出之個別鎖定要求的相關資訊，例如鎖定逾時和死結。 本物件中含有多項執行個體。
SQLServer:Memory Manager   提供 SQL Server 記憶體使用狀況的相關資訊，例如目前配置的鎖定結構總數。
SQLServer:Plan Cache       提供用來儲存物件 (例如預存程序、觸發程序和查詢計畫) 之 SQL Server 快取的相關資訊。
SQLServer:Resource Pool Stats  提供有關資源管理員資源集區統計資料的資訊。
SQLServer:SQL Errors   提供 SQL Server 錯誤的相關資訊。
SQLServer:SQL Statistics   提供 Transact-SQL 查詢方面的相關資訊，例如 SQL Server 所接收之 Transact-SQL 陳述式的批次數。
SQLServer:Transactions      提供 SQL Server 的使用中交易相關資訊，例如交易總數與快照集交易的數量。
SQLServer:User Settable    執行自訂監視。 每個計數器皆可為自訂的預存程序，或任何可傳回監視數值的 Transact-SQL 陳述式。
SQLServer:Wait Statistics   提供等候的相關資訊。
SQLServer:Workload Group Stats  提供有關資源管理員工作負載群組統計資料的資訊。


(4)SQL Server 複寫效能物件


(5)SSIS 管線計數器


#---------------------------------------------------------------
#  建立 SQL Server 資料庫警示
#---------------------------------------------------------------
http://technet.microsoft.com/zh-tw/library/ms175166.aspx



#---------------------------------------------------------------
#  http://technet.microsoft.com/zh-tw/library/ms190382.aspx
#---------------------------------------------------------------