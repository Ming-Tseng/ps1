<#  SQLPS05_DMV
 C:\Users\administrator.CSD\SkyDrive\download\ps1\ex09_CHTperformance.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createDate : Nov.3.2015
 UpdateDate : 
 history : 
 object : 
 relateion: 
 SQLPS0501_DMV_Transcation
 SQLPS0502_DMV_OSPerf

#>

#   00  base info
#   10  各資料庫使用記憶體情況
#   23  找出 總耗CPU 時間/執行次數  
#   41  找出某資料庫執 行的次數  CPU 總時間   請修改下列資料庫_ConfigDB
#   76  由特定 TSQL 查詢在什麼地方使用       請修改下列TSQL :insert into dbo.deal
#  100  明細建議索引  Find those missing indexes  
#  122  找出  目前正在執行 什麼SQL
#  151  動態管理檢視查詢最耗損I/O資源的SQL語法
#  204  Observing the current locks

#-----------------------------------
#    00  base info
#-----------------------------------

SELECT 
  @@servername N'SQLServerName',
 RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'


select name,physical_name,size *0.000008 from sys.master_files

#---------------------------------------------------------------
#  10    各資料庫使用記憶體情況
#---------------------------------------------------------------
SET TRAN ISOLATION LEVEL READ UNCOMMITTED
SELECT
ISNULL(DB_NAME(database_id), 'ResourceDb') AS DatabaseName, CAST(COUNT(row_count) * 8.0 / (1024.0) AS DECIMAL(28,2)) AS [Size (MB)]FROM sys.dm_os_buffer_descriptorsGROUP BY database_idORDER BY DatabaseName




#---------------------------------------------------------------
#   23  找出 總耗CPU 時間/執行次數  
#---------------------------------------------------------------
SELECT TOP 20
   total_worker_time/1000 AS [總耗CPU 時間(ms)],execution_count [執行次數],
   qs.total_worker_time/qs.execution_count/1000. as [平均耗CPU 時間(ms)],
   SUBSTRING(qt.text,qs.statement_start_offset/2+1, 
      (case when qs.statement_end_offset = -1 
      then DATALENGTH(qt.text) 
      else qs.statement_end_offset end -qs.statement_start_offset)/2 + 1) 
   as [使用CPU的語法], qt.text [完整語法],
   qt.dbid, dbname=db_name(qt.dbid),
   qt.objectid,object_name(qt.objectid,qt.dbid) ObjectName
 
FROM sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(qs.sql_handle) as qt
ORDER BY 
        total_worker_time DESC
#---------------------------------------------------------------
#   41  找出某資料庫執 行的次數  CPU 總時間   請修改下列資料庫_ConfigDB
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 SELECT TOP 20
--sql_handle
--,plan_handle
CAST((qs.total_worker_time) / 1000000.0 AS DECIMAL(28,2)) AS [CPU 總時間(s)]
,qs.total_worker_time  as '耗用的 CPU 總時間量microSEC'
, CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time AS DECIMAL(28,2)) AS [% CPU]
--,creation_time  as '編譯時間'
--,total_elapsed_time as '完成執行經歷的總時間microSEC'
,last_execution_time as '上次開始執行計畫的時間'
, CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 /qs.total_elapsed_time AS DECIMAL(28, 2)) AS [% CPU Waiting]
, qs.execution_count as '被執行的次數'
,(qs.total_worker_time / 1000000.0/ qs.execution_count ) AS [ 平均CPU執行時間(微秒)]
, CAST((qs.total_worker_time) / 1000000.0/ qs.execution_count AS DECIMAL(28, 2)) AS [ 平均CPU執行時間(秒)]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1
,((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS '資料庫名稱'
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE qs.total_elapsed_time > 0 and  DB_NAME(qt.dbid) = '_ConfigDB'
ORDER BY [CPU 總時間(s)] DESC
--ORDER BY[ 平均CPU執行時間(微秒)] desc
--ORDER BY '上次開始執行計畫的時間' DESC



#---------------------------------------------------------------
#    76   由特定 TSQL 查詢在什麼地方使用       請修改下列TSQL :insert into dbo.deal
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT 
SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,((CASE WHEN qs.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2ELSE qs.statement_end_offsetEND - qs.statement_start_offset)/2) + 1) AS [Individual Query], qt.text AS [Parent Query], DB_NAME(qt.dbid) AS DatabaseName, qp.query_planFROM sys.dm_exec_query_stats qsCROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qtCROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qpWHERE SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,((CASE WHEN qs.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2ELSE qs.statement_end_offsetEND - qs.statement_start_offset)/2) + 1)LIKE '%insert into dbo.deal%'

#----------------------------------------------------
#  100  明細建議索引  Find those missing indexes  
#----------------------------------------------------

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
ROUND(s.avg_total_user_cost * s.avg_user_impact *
(s.user_seeks + s.user_scans),0) AS [Total Cost]
, s.avg_user_impact
, d.statement AS TableName
, d.equality_columns
, d.inequality_columns
, d.included_columns
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle
INNER JOIN sys.dm_db_missing_index_details d
ON d.index_handle = g.index_handle
ORDER BY [Total Cost] DESC



#---------------------------------------------------------------
#  122   找出  目前正在執行 什麼SQL
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
er.session_Id AS [Spid]   --process identifier),
, sp.ecid
, DB_NAME(sp.dbid) AS [Database]
, sp.nt_username
, er.status
, er.wait_type
, SUBSTRING (qt.text, (er.statement_start_offset/2) + 1,
((CASE WHEN er.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE er.statement_end_offset
END - er.statement_start_offset)/2) + 1) AS [Individual Query]  
, qt.text AS [Parent Query]
, sp.program_name
, sp.Hostname
, sp.nt_domain
, er.start_time
FROM sys.dm_exec_requests er
INNER JOIN sys.sysprocesses sp ON er.session_id = sp.spid
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle)as qt
WHERE session_Id > 50
AND session_Id NOT IN (@@SPID)
ORDER BY session_Id, ecid


#---------------------------------------------------------------
#   151   動態管理檢視查詢最耗損I/O資源的SQL語法
#---------------------------------------------------------------
select --top 5 
(total_logical_reads/execution_count) as  [平均邏輯讀取次數],
(total_logical_writes/execution_count) as [平均邏輯寫入次數],
(total_physical_reads/execution_count) as [平均實體讀取次數],
 Execution_count 執行次數, 
substring(qt.text,r.statement_start_offset/2+1, 
(case when r.statement_end_offset = -1 
then datalength(qt.text) 
else r.statement_end_offset end - r.statement_start_offset)/2+1) [執行語法]
from sys.dm_exec_query_stats  as r
   cross apply sys.dm_exec_sql_text(r.sql_handle) as qt 
order by 
 (total_logical_reads + total_logical_writes) Desc

#-------------------------
#  204  Observing the current locks
#-------------------------
SELECT DB_NAME(resource_database_id) AS DatabaseName, request_session_id
, resource_type, request_status, request_mode
FROM sys.dm_tran_locks
WHERE request_session_id !=@@spid
ORDER BY request_session_id



SELECT
Blocking.session_id as BlockingSessionId
, Sess.login_name AS BlockingUser
, BlockingSQL.text AS BlockingSQL
, Waits.wait_type WhyBlocked
, Blocked.session_id AS BlockedSessionId
, USER_NAME(Blocked.user_id) AS BlockedUser
, BlockedSQL.text AS BlockedSQL
, DB_NAME(Blocked.database_id) AS DatabaseName
FROM sys.dm_exec_connections AS Blocking
INNER JOIN sys.dm_exec_requests AS Blocked
ON Blocking.session_id = Blocked.blocking_session_id
INNER JOIN sys.dm_os_waiting_tasks AS Waits
ON Blocked.session_id = Waits.session_id
RIGHT OUTER JOIN sys.dm_exec_sessions Sess
ON Blocking.session_id = sess.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)
AS BlockingSQL
CROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQL
ORDER BY BlockingSessionId, BlockedSessionId