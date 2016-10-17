<#  SQLPS05_DMV
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_DMV.ps1
 C:\Users\administrator.CSD\SkyDrive\download\ps1\SQLPS05_DMV.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createDate : Jan.03.2014
 UpdateDate : Mar.21.2014
 history : 
 object : 
 relateion: 
 SQLPS0501_DMV_Transcation
 SQLPS0502_DMV_OSPerf

 $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SQLPS05_DMV.ps1

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
ssms
#1     Clearing all plans from the plan cache or  清空資料快取暫存區並重新查詢後，觀察暫存區的使用狀況
#2     Memory used per database
#3  90 The queries that use the most CPU
#4     Finding where a query is used
#5     A simple monitor for  go number
#6     statement concerning isolation  level.
#7     Get All  DMV  and DMF
#8     Identify the 20 slowest queries on your server
#9     找出   Find those missing indexes  sql_server_dmvs_in_active.pdf p.16
#10  316  找出什麼SQL   正在執行
#11    Who’s doing what and when?
#12    Find a cached plan
#13    Permissions to the DMVs/DMFs
#14    找出 a  Database 讀寫次數   DB_NAME(qt.dbid) = 'ParisDev' 
#15    最久10大 TSQL Top 10 longest-running queries on server
#16    Creating an empty temporary table structure
#17    Extracting the Individual Query from the Parent Query 
#18    Determine query effect via differential between snapshots
#19 517   找出連接伺服器的使用者，然後傳回每位使用者的工作階段數  session connection
#20      Finding everyone’s last-run query
#21 530   Amount of space (total, used, and free) in tempdb
#22 545   Total amount of space (data, log, and log used) by database 
#23       Estimating when a job will finish
#24 592   Determining the performance impact of a system upgrade 
#25 685   sys.dm_os_sys_info
#26 700   Finding where your query really spends its time 尋找查詢的真正花費的時間
#27 711   以sys.dm_exec_query_stats動態管理檢視查詢最耗損I/O資源的SQL語法
#28 735   監控是否有I/O延遲的狀況
#29 788   make lock  , deadlock 
#30 800   呈現鎖定與被鎖定間的鏈狀關係
#31 860   查詢某個資料庫內各物件使用記憶體暫存區資源的統計
#32 868   How to discover which locks are currently held
#33 900   How to identify contended resources
#34 934   How to identify contended resources, including SQL query details
#35 966   How to find an idle session with an open transaction
#36 988   What’s being blocked by idle sessions with open transactions
#37 1030  What has been blocked for more than 30 seconds
#38 1100   Listing / killing running/blocking processes using SMO  p128
#39 1111 statusOSPCRALL \ps1\0S02_sets_scenario004.ps1 
#40 1400 連續執行記錄執行時間總筆數
#   1596  儲存DMV 到 SQL_inventory  perfXXX sample
#   1677 big table sample data  lab



#98   SQL Server Performance     Data Collection
#99   SQL Server Host Performance Data Collection
ssms
milliseconds  10 -3 0.001
microseconds  10 -6 0.000001
#---------------------------------------------------------------
#1   Clearing all plans from the plan cache
#---------------------------------------------------------------
{#從計畫快取清除所有計畫

DBCC FREEPROCCACHE WITH NO_INFOMSGS

--1.1USE AdventureWorks2012;
GO
SELECT * FROM Person.Address;
GO
SELECT plan_handle, st.text
FROM sys.dm_exec_cached_plans CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS stWHERE text LIKE N'SELECT * FROM Person.Address%';GO
--1.2
-- Remove the specific plan from the cache.DBCC FREEPROCCACHE (0x060006001ECA270EC0215D05000000000000000000000000);GO

--cached plans for a specific database
DECLARE @DB_ID INTSET @DB_ID = DB_ID('NameOfDatabaseToClear') -- Change this to your DBDBCC FLUSHPROCINDB(@DB_ID)

--1.3

--清空記憶體快取區中既有的資料
DBCC DROPCLEANBUFFERS 
DBCC SQLPERF("sys.dm_os_wait_stats",CLEAR);
DBCC SQLPERF("sys.dm_os_latch_stats" , CLEAR)


--故意利用查詢記錄，將硬碟資料留在記憶體快取區中
select * from adventureWorks.Person.Contact
select * from adventureWorks.HumanResources.Employee

--利用先前探詢記憶體快取區的預存程序列出使用狀態
exec myScript.spBufferUsed 'AdventureWorks'
}
#---------------------------------------------------------------
#2   Memory used per database
#---------------------------------------------------------------
{SET TRAN ISOLATION LEVEL READ UNCOMMITTED
SELECT
ISNULL(DB_NAME(database_id), 'ResourceDb') AS DatabaseName, CAST(COUNT(row_count) * 8.0 / (1024.0) AS DECIMAL(28,2)) AS [Size (MB)]FROM sys.dm_os_buffer_descriptorsGROUP BY database_idORDER BY DatabaseName
}
#---------------------------------------------------------------
#3   The queries that use the most CPU
#---------------------------------------------------------------
{
--3.1
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST((qs.total_worker_time) / 1000000.0 AS DECIMAL(28,2)) AS [Total CPU time (s)]
, CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time AS DECIMAL(28,2)) AS [% CPU]
, CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 /qs.total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting]
, qs.execution_count
, CAST((qs.total_worker_time) / 1000000.0/ qs.execution_count AS DECIMAL(28, 2)) AS [CPU time average (s)]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1
,((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE qs.total_elapsed_time > 0
ORDER BY [Total CPU time (s)] DESC

--3.2

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
WHERE qs.total_elapsed_time > 0 and  DB_NAME(qt.dbid)= 'msdb'
ORDER BY [CPU 總時間(s)] DESC
--ORDER BY[ 平均CPU執行時間(微秒)] desc
--ORDER BY '上次開始執行計畫的時間' DESC


-- 3.3
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
  
}
#---------------------------------------------------------------
#4   Finding where a query is used
#---------------------------------------------------------------
{SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT 
SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,((CASE WHEN qs.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2ELSE qs.statement_end_offsetEND - qs.statement_start_offset)/2) + 1) AS [Individual Query], qt.text AS [Parent Query], DB_NAME(qt.dbid) AS DatabaseName, qp.query_planFROM sys.dm_exec_query_stats qsCROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qtCROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qpWHERE SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,((CASE WHEN qs.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2ELSE qs.statement_end_offsetEND - qs.statement_start_offset)/2) + 1)LIKE '%insert into dbo.deal%'
}
#---------------------------------------------------------------
#5   A simple monitor for  go number
#---------------------------------------------------------------
WAITFOR TIME '22:20:00'  --wait  until  22.PM
GO
PRINT GETDATE()
EXEC master.dbo.dba_BlockTracer
IF @@ROWCOUNT > 0    -- if blocking occuring
		BEGIN
		SELECT GETDATE() AS TIME     -- execute 
		EXEC master.dbo.dba_WhatSQLIsExecuting
END
WAITFOR DELAY '00:00:15'   -- wait 15 sec
GO 500       --repeat 500 times
#
Beginning execution loop
Mar  2 2014 10:29PM

(178 row(s) affected)
Mar  2 2014 10:29PM

(178 row(s) affected)
Batch execution completed 2 times.

#---------------------------------------------------------------
#6   statement concerning isolation  level.
#---------------------------------------------------------------
'This ensures you can read data without waiting for locks to be released or acquiring locks yourself, resulting in the query running   more quickly with minimal impact on other running SQL queries. 
The statement used is
'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

#---------------------------------------------------------------
#7   Get All  DMV  and DMF
#---------------------------------------------------------------
select * FROM [sys].[sysobjects]     -- 2015 rows
select * FROM [sys].system_objects   -- 2013 rows


SELECT name, type_desc FROM sys.system_objects  WHERE name LIKE 'dm_%' ORDER BY name

#---------------------------------------------------------------
#8   Identify the 20 slowest queries on your server
#---------------------------------------------------------------
{SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST(qs.total_elapsed_time / 1000000.0 AS DECIMAL(28, 2)) AS [Total Elapsed Duration (s)]
, qs.execution_count
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1
, ((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
    ELSE
qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]

, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan

FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_elapsed_time DESC
''
##  TOP 5   Avg CPU Time
SELECT TOP 5 total_worker_time/execution_count AS [Avg CPU Time],
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
        ((CASE qs.statement_end_offset
          WHEN -1 THEN DATALENGTH(st.text)
         ELSE qs.statement_end_offset
         END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY total_worker_time/execution_count DESC;
}


#---------------------------------------------------------------
#9   找出   Find those missing indexes  sql_server_dmvs_in_active.pdf p.16
#---------------------------------------------------------------
{

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
}
#---------------------------------------------------------------
#10  316   找出什麼SQL   正在執行
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
#11   Who’s doing what and when?  ref sql08_inventory.ps1
#---------------------------------------------------------------
USE [SQL_Inventory]
CREATE TABLE [dbo].[WhatsGoingOnHistory](
	[Runtime] [datetime] NULL,[session_id] [smallint] NOT NULL,[login_name] [varchar](128) NOT NULL,[host_name] [varchar](128) NULL,[DBName] [varchar](128) NULL,
	[Individual Query] [varchar](max) NULL,[Parent Query] [varchar](200) NULL,[status] [varchar](30) NULL,[start_time] [datetime] NULL,[wait_type] [varchar](60) NULL,
	[program_name] [varchar](128) NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


INSERT INTO dbo.WhatsGoingOnHistory
SELECT
GETDATE() as[runTime] 
, s.session_id
, s.login_name
, s.host_name
, DB_NAME(r.database_id) AS DBName
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1
,((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS [Individual Query]
, SUBSTRING(text, 1, 200) AS [Parent Query]
, r.status
, r.start_time
, r.wait_type
, s.program_name 
FROM sys.dm_exec_sessions s
INNER JOIN sys.dm_exec_connections c ON s.session_id = c.session_id
INNER JOIN sys.dm_exec_requests r ON c.connection_id = r.connection_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
--WHERE s.session_id > 50  AND r.session_id != @@spid

WAITFOR DELAY '00:01:00'
GO 1440 -- 60 * 24 (one day)

#---------------------------------------------------------------
#12   Find a cached plan
#---------------------------------------------------------------
Cached plan(executed plan)通常目的   reuse this plan, saving time.

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
st.text AS [SQL]
, cp.cacheobjtype
, cp.objtype
, COALESCE(DB_NAME(st.dbid),
DB_NAME(CAST(pa.value AS INT))+'*',
'Resource') AS [DatabaseName]
, cp.usecounts AS [Plan usage]
, qp.query_plan
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
OUTER APPLY sys.dm_exec_plan_attributes(cp.plan_handle) pa
WHERE pa.attribute = 'dbid'
AND st.text LIKE '%CREATE PROCEDURE%'
--AND st.text LIKE '%PartyType%'
#---------------------------------------------------------------
#13   permissions to the DMVs/DMFs
#---------------------------------------------------------------
VIEW SERVER STATE
VIEW DATABASE STATE 
ALTER SERVER STATE
#---------------------------------------------------------------
#14   找出 a  Database 讀寫次數   DB_NAME(qt.dbid) = 'ParisDev' 
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT SUM(qs.total_logical_reads) AS [Total Reads]
,SUM(qs.total_logical_writes) AS [Total Writes]
,DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
WHERE DB_NAME(qt.dbid) = 'ParisDev'  --
GROUP BY DB_NAME(qt.dbid)

#---------------------------------------------------------------
#15   最久10大 TSQL Top 10 longest-running queries on server
#---------------------------------------------------------------
{
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 10
qs.total_elapsed_time AS [Total Time]
, qs.execution_count AS [Execution count]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE
qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY [Total Time] DESC;
}
#---------------------------------------------------------------
#16   Creating an empty temporary table structure
#---------------------------------------------------------------
利用此方法奪出DMV Column Data type , 再利用自動產生 script  tableas
#Often you want to create a temporary table to hold the results of any transient data,

SELECT * 
INTO #Temp01
FROM sys.tables f
WHERE 1 = 2   --creates empty table

SELECT f.FactorId, f.FactorName, pf.PositionId
INTO #Temp01
FROM dbo.Factor f
INNER JOIN dbo.PositionFactor pf ON pf.FactorId = f.FactorId
WHERE 1 = 2
#---------------------------------------------------------------
#17  Extracting the Individual Query from the Parent Query 
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
qs.execution_count
, SUBSTRING (qt.text, (qs.statement_start_offset/2) + 1
, ((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
ORDER BY execution_count DESC;
#---------------------------------------------------------------
#18  Determine query effect via differential between snapshots
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED--Get pre-work
snapshot
SELECT sql_handle, plan_handle, total_elapsed_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkSnapShot
FROM sys.dm_exec_query_stats--Run queries
EXEC dbo.IWSR
SELECT * FROM dbo.appdate--Get post-work  snapshot
SELECT sql_handle, plan_handle, total_elapsed_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkSnapShot
FROM sys.dm_exec_query_stats

--compare  Two Snapshot  Extract
delta
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkSnapShot p1
RIGHT OUTER JOIN
#PostWorkSnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qtWHERE p2.execution_count != ISNULL(p1.execution_count, 0)ORDER BY [Duration] DESC
#---------------------------------------------------------------
#19   517  找出連接伺服器的使用者，然後傳回每位使用者的工作階段數  session connection
#---------------------------------------------------------------


A connection represents the external connection to the server (over a network or locally through shared memory for example).
A session represents a user process within SQL Server.

A connection may be associated with zero, one, or many sessions.
# 
<Max number of concurrent connections> 
To configure the user connections option
In Object Explorer, right-click a server and click Properties.
Click the Connections node.
Under Connections, in the Max number of concurrent connections box, type or select a value from 0 through 32767 to set the maximum number of users that are allowed to connect simultaneously to the instance of SQL Server.

select @@MAX_CONNECTIONS  

$tsql="SELECT login_name ,COUNT(session_id) AS session_count `
FROM sys.dm_exec_sessions `
GROUP BY login_name; "

Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto




<#

function mysid (){
    Invoke-Sqlcmd -ServerInstance pmd2016 -Username usql2014x -Password p@ssw0rds -Query 'select @@spid as sid '|ft -auto
}


USE [master]
GO
DENY CONNECT SQL TO [PMOCSD\infra1]
GO
ALTER LOGIN [PMOCSD\infra1] DISABLE
GO
USE [master]
GO
DENY CONNECT SQL TO [PMOCSD\SPService]
GO
ALTER LOGIN [PMOCSD\SPService] DISABLE
GO
USE [master]
GO
DENY CONNECT SQL TO [sa]
GO
ALTER LOGIN [sa] DISABLE
GO



gh=hostname
$Getk2=@"
select @@servername
"@
$Getk2=@"
select @@spid
"@

icm -ComputerName sql2014x `
-ScriptBlock {Invoke-Sqlcmd -ServerInstance PMD2016 -Username sa -Password p@ssw0rds -Query $using:Getk2 }

icm -ComputerName sql2014x -ScriptBlock {hostname}

KillSessionByHostname PMD2016 PMD2016

getallSid $ServerInstance all;mysid
KillSessionByHostname PMD2016 sql2014x
getallSid $ServerInstance all


Invoke-Command -ScriptBlock { Get-Counter -Counter $using:Getk2 -MaxSamples 120 -SampleInterval 1 |
Export-Counter -Path C:\PerfLogs\capture2.blg -FileFormat blg } `
-AsJob -ComputerName DGPAP1, DGPAP1

ping sql2014x
whoami
icm -ComputerName sql2014x -ScriptBlock {'select @@servername'}
icm -ComputerName sql2014x  {gps}
icm -ComputerName sql2014x  {calc}
icm -ComputerName sql2014x -ScriptBlock {notepad}
icm -ComputerName sql2014x -ScriptBlock {Stop-Process -name calc  -Force -Confirm:$false}
icm -ComputerName sql2014x -ScriptBlock {new-Process calc }

Start-Process invoke-
Invoke-Command


$commands = {
  Start-Process notepad.exe
  Start-Sleep 2
  Get-Process -Name notepad
  Start-Sleep 200
}
Invoke-Command -ScriptBlock $commands -ComputerName sql2014x
Invoke-Command -ScriptBlock  {Get-Process -Name notepad} -ComputerName sql2014x



Icm  {. h:\ps1\t.ps1;start-sleep 60 } -ComputerName sql2014x


Icm  {get-date |out-file h:\ps1\t.txt -Append} -ComputerName sql2014x

Icm  {ri h:\ps1\t.txt -Force -Confirm:$false} -ComputerName sql2014x

Get-Process -name notepad
Start-Sleep 2
Get-Process -Name notepad

Stop-Process -Id

Import-Module sqlps -DisableNameChecking




ssms

icm -ComputerName sql2014x -ScriptBlock {}

$tsql_killsessionbyHostname

$ServerInstance='pmd2016'
$hostaname='SQL2014X'
$hostaname='PMD2016'

function  KillSessionByHostname ($ServerInstance, $hostaname){
    

#Invoke-Sqlcmd -ServerInstance pmd2016 -Username usql2014x -Password p@ssw0rds -Query 'select @@spid'  

$tsql_getsessionidbyHostname=@"
select session_id FROM sys.dm_exec_sessions  where  session_id > 50 and session_id <> @@spid and host_name='$hostaname'
"@

$SIDs=Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sa -Password p@ssw0rds -Query $tsql_getsessionidbyHostname

foreach ($SID in $SIDs)
{
     $spid =$SID.session_id
     $tsql_killSID="kill $spid  "; $tsql_killSID
}
Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sa -Password p@ssw0rds -Query $tsql_killSID
}
#---
getallSid $ServerInstance sp2013;mysid
KillSessionByHostname PMD2016 sp2013


function GetallSID ($ServerInstance, $hostaname){

if ($hostaname -eq 'all')
{
    $tsql_GetallSession=@" 
select session_id,login_time,host_name,login_name,status,last_request_start_time,last_request_end_time 
     FROM sys.dm_exec_sessions  where  session_id > 50 order by last_request_start_time desc
"@
}
else
{
    $tsql_GetallSession=@" 
select session_id,login_time,host_name,login_name,status,last_request_start_time,last_request_end_time 
     FROM sys.dm_exec_sessions  where  session_id > 50 and host_name='$hostaname' order by last_request_start_time desc
"@
}


$r=Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_GetallSession 
$r |ft -AutoSize
$r.count
}

KillSessionByHostname PMD2016 sp2013
KillSessionByHostname PMD2016 PMD2016

getallSid $ServerInstance all
getallSid $ServerInstance sp2013
getallSid $ServerInstance pmd2016
getallSid $ServerInstance sql2014x
mysid


#>








#---------------------------------------------------------------
#20   Finding everyone’s last-run query
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT c.session_id, s.host_name, s.login_name  as[工作階段的登入名稱], s.status, st.text, s.login_time  as[建立工作階段的時間],c.connect_time as[連接的時間戳記], s.program_name as [用戶端程式名稱], *FROM sys.dm_exec_connections cINNER JOIN sys.dm_exec_sessions s ON c.session_id = s.session_idCROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS stORDER BY c.session_id
##

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select connect_time as[連接的時間戳記],client_net_address as[用戶端的主機位址],client_tcp_port as [用戶端電腦上的通訊埠編號],local_net_address as [目標伺服器的 IP 位址],local_tcp_port as [連接的目標伺服器 TCP 埠],connection_id as[識別連接。],num_reads as[連接期間所進行的封包讀取數],num_writes  as [連接期間所進行的資料封包寫入數],last_read as [最後一次讀取的時間戳記],last_write as  [最後一次寫入的時間戳記],net_packet_size as [傳送資訊和資料的網路封包大小],* FROM sys.dm_exec_connections c
##
select login_time as[工作階段的時間],host_name as[特定用戶端工作站名稱] --內部工作階段的值為 NULL。,program_name as [用戶端程式名稱],host_process_id as [用戶端程式的處理序識別碼],login_name as [ SQL Server 登入名稱],nt_domain as[用戶端的 Windows 網域],nt_user_name as[Windows 使用者名稱],status  as [工作階段的狀態] --running 目前執行一或多項要求, Sleeping 目前不執行任何要求, Dormant 工作階段因連接共用而重設，目前處於登入前狀態 ,Preconnect工作階段在資源管理員類別器中,cpu_time as [所使用的 CPU 時間 毫秒],memory_usage as  [所用記憶體的 8 KB 頁數],total_elapsed_time as [自工作階段建立以來的時間 毫秒],last_request_start_time as [最後一項要求的開始時間],last_request_end_time as [最後完成的時間],reads as [讀取次數],writes as [寫入次數],database_id as [資料庫的識別碼],* FROM sys.dm_exec_sessions s where session_id > 50 

#---------------------------------------------------------------
# 21  530  Amount of space (total, used, and free) in tempdb
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT SUM(user_object_reserved_page_count
+ internal_object_reserved_page_count
+ version_store_reserved_page_count
+ mixed_extent_page_count
+ unallocated_extent_page_count) * (8.0/1024.0) AS [TotalSizeOfTempDB(MB)]
, SUM(user_object_reserved_page_count
+ internal_object_reserved_page_count
+ version_store_reserved_page_count
+ mixed_extent_page_count) * (8.0/1024.0) AS [UsedSpace (MB)]
, SUM(unallocated_extent_page_count * (8.0/1024.0)) AS [FreeSpace (MB)]
FROM sys.dm_db_file_space_usage

#---------------------------------------------------------------
# 22  545 Total amount of space (data, log, and log used) by database 
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT instance_name, counter_name, cntr_value / 1024.0 AS [Size(MB)]FROM sys.dm_os_performance_countersWHERE object_name = 'SQLServer:Databases'AND counter_name IN ('Data File(s) Size (KB)', 'Log File(s) Size (KB)', 'Log File(s) Used Size (KB)')
ORDER BY instance_name, counter_name

#---------------------------------------------------------------
# 23  Estimating when a job will finish
#---------------------------------------------------------------
backup log [194_SP_CentralAdminContent]  to disk='h:\temp\xx.trn'   
                                                                                                  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT r.percent_complete
, DATEDIFF(MINUTE, start_time, GETDATE()) AS Age
, DATEADD(MINUTE, DATEDIFF(MINUTE, start_time, GETDATE()) /
percent_complete * 100, start_time) AS EstimatedEndTime
, t.Text AS ParentQuery
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS IndividualQuery
, start_time
, DB_NAME(Database_Id) AS DatabaseName
, Status
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
WHERE session_id > 50
AND percent_complete > 0
ORDER BY percent_complete DESC

#---------------------------------------------------------------
# 24 Determining the performance impact of a system upgrade  
#---------------------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED##(1)Get pre-work
counters
SELECT
total_elapsed_time, total_worker_time, total_logical_reads
, total_logical_writes, total_clr_time, execution_count
, statement_start_offset, statement_end_offset, sql_handle, plan_handle
INTO #prework
FROM sys.dm_exec_query_stats


##(2)Do something here (query/time interval)

EXEC PutYourWorkloadHere

##SELECTtotal_elapsed_time, total_worker_time, total_logical_reads, total_logical_writes, total_clr_time, execution_count, statement_start_offset, statement_end_offset, sql_handle, plan_handleINTO #postwork
FROM sys.dm_exec_query_stats

## (4)Get totals by database
SELECT SUM(p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) AS [TotalDuration]
, SUM(p2.total_worker_time - ISNULL(p1.total_worker_time, 0)) AS [Total Time on CPU]
, SUM((p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))) AS [Total Time Waiting], SUM(p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0)) AS [TotalReads], SUM(p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)) AS [TotalWrites], SUM(p2.total_clr_time - ISNULL(p1.total_clr_time, 0)) AS [Total CLR time], SUM(p2.execution_count - ISNULL(p1.execution_count, 0)) AS [Total Executions], DB_NAME(qt.dbid) AS DatabaseNameFROM #prework p1RIGHT OUTER JOIN #postwork p2 ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)AND p2.statement_start_offset = ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset = ISNULL(p1.statement_end_offset, p2.statement_end_offset)CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qtWHERE p2.execution_count != ISNULL(p1.execution_count, 0)GROUP BY DB_NAME(qt.dbid)

##(5)Get totals by Parent Query
SELECTSUM(p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) AS [TotalDuration], SUM(p2.total_worker_time - ISNULL(p1.total_worker_time, 0)) AS [Total Time on CPU], SUM((p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0))- (p2.total_worker_time - ISNULL(p1.total_worker_time, 0))) AS [Total Time Waiting], SUM(p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0)) AS [TotalReads], SUM(p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)) AS [TotalWrites], SUM(p2.total_clr_time - ISNULL(p1.total_clr_time, 0)) AS [Total CLR time], SUM(p2.execution_count - ISNULL(p1.execution_count, 0)) AS [Total Executions], DB_NAME(qt.dbid) AS DatabaseName, qt.text AS [Parent Query]
FROM #prework p1RIGHT OUTER JOIN #postwork p2 ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)AND p2.statement_start_offset = ISNULL(p1.statement_start_offset, p2.statement_start_offset)AND p2.statement_end_offset =ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qtWHERE p2.execution_count != ISNULL(p1.execution_count, 0)GROUP BY DB_NAME(qt.dbid), qt.textORDER BY [TotalDuration] DESC

## (6) Get totals by Individual Query
SELECTp2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [TotalDuration], p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Total Time on CPU], (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) - (p2.total_worker_time - ISNULL(p1.total_worker_time, 0)) AS [Total Time Waiting]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [TotalReads], p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0) AS [TotalWrites], p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [Total CLR time], p2.execution_count - ISNULL(p1.execution_count, 0) AS [Total Executions], SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,((CASE WHEN p2.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2ELSE p2.statement_end_offsetEND - p2.statement_start_offset)/2) + 1) AS [Individual Query], qt.text AS [Parent Query], DB_NAME(qt.dbid) AS DatabaseNameFROM #prework p1RIGHT OUTER JOIN #postwork p2 ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)AND p2.statement_start_offset = ISNULL(p1.statement_start_offset, p2.statement_start_offset)AND p2.statement_end_offset = ISNULL(p1.statement_end_offset, p2.statement_end_offset)CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qtWHERE p2.execution_count != ISNULL(p1.execution_count, 0)ORDER BY [TotalDuration] DESC
DROP TABLE #preworkDROP TABLE #postwork
#>}
#---------------------------------------------------------------
#   25 sys.dm_os_sys_info
#---------------------------------------------------------------
{<#
SELECT cpu_count AS [Logical CPUs],cpu_count / hyperthread_ratio AS [Physical CPUs]FROM sys.dm_os_sys_info

SELECT DATEADD(ss, -(ms_ticks / 1000), GetDate()) AS [Start dateTime]
FROM sys.dm_os_sys_info

select * FROM sys.dm_os_sys_info
#>}
#---------------------------------------------------------------
#26  Finding where your query really spends its time 尋找查詢的真正花費的時間
#---------------------------------------------------------------





#---------------------------------------------------------------
#27  以sys.dm_exec_query_stats動態管理檢視查詢最耗損I/O資源的SQL語法
#---------------------------------------------------------------
{<#
select --top 5 
(total_logical_reads/execution_count) as [平均邏輯讀取次數],
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
 #>}


#---------------------------------------------------------------
# 28   監控是否有I/O延遲的狀況
#---------------------------------------------------------------
{<#

透過sys.dm_io_pending_io_requests系統檢視和sys.dm_io_virtual_file_stats


select 
    db_name(i.database_id) db, 
    name,
	physical_name, 
    io_stall [使用者等候檔案完成I/O 的總時間(以毫秒為單位)] ,
	io_type [I/O 要求的類型],
    io_pending_ms_ticks [個別IO 在佇列(Pending queue)等待的總時間]
from sys.dm_io_virtual_file_stats(NULL, NULL) i
join sys.dm_io_pending_io_requests as p
on i.file_handle = p.io_handle
join sys.master_files m
On m.database_id=i.database_id and m.file_id=i.file_id

#>}
#---------------------------------------------------------------
#29 make lock  , deadlock 
#---------------------------------------------------------------
{<#
##  example1  故意大量新增記錄，讓兩條連接彼此搶奪硬碟I/O資源
use SQL_inventory
GO
CREATE TABLE tbl(c1 int,c2 nvarchar(100))
go
INSERT tbl VALUES(1,'Hello')
go

DECLARE @i int=1
WHILE @i<21
BEGIN
	INSERT tbl SELECT * FROM tbl
	SET @i+=1
END
go
DROP TABLE tbl


##  example2 故意透過交易以延長鎖定時間，讓其他存取相同資源的連接被鎖住

--透過sqlcmd 傳入執行的順序，以及要等待的秒數
!!@@ECHO $(No)
PRINT @@spid;
GO  --要分批次，才會照想要的順序執行
SELECT * FROM Northwind.dbo.Customers WHERE CustomerID='alfki'
GO
BEGIN TRAN
   UPDATE Northwind.dbo.Customers SET CompanyName='aaabbb' WHERE CustomerID='alfki'
   WAITFOR DELAY '00:00:$(Sec)'
ROLLBACK TRAN
GO
--讓命令列執行環境等待一個鍵再結束
!!PAUSE
- sqlcmd -i c:\ming\block.sql -vNo=1 -vSec=30

##  example3

#>}

#---------------------------------------------------------------
#30   800   呈現鎖定與被鎖定間的鏈狀關係
#---------------------------------------------------------------

{<#
select t1.resource_type as [資源鎖定型態]
   ,db_name(resource_database_id) as [資料庫名]
   ,t1.resource_associated_entity_id as [鎖定的物件]
   ,t1.request_mode as [等待者需求的鎖定型態]
   ,t1.request_session_id as [等待者sid]  
   ,t2.wait_duration_ms as [等待時間]	
   ,(select text from sys.dm_exec_requests as r  
      cross apply sys.dm_exec_sql_text(r.sql_handle) 
      where r.session_id = t1.request_session_id) as [等待者要執行的批次]
   ,(select substring(qt.text,r.statement_start_offset/2+1, 
             (case when r.statement_end_offset = -1 
             then datalength(qt.text) 
             else r.statement_end_offset end - r.statement_start_offset)/2+1) 
       from sys.dm_exec_requests as r
       cross apply sys.dm_exec_sql_text(r.sql_handle) as qt
       where r.session_id = t1.request_session_id) as [等待者正要執行的語法]
   ,t2.blocking_session_id as [鎖定者sid] 
     ,(select text from sys.sysprocesses as p		
       cross apply sys.dm_exec_sql_text(p.sql_handle) 
       where p.spid = t2.blocking_session_id) as [鎖定者的語法]
   from 
   sys.dm_tran_locks as t1, 
   sys.dm_os_waiting_tasks as t2
where 
   t1.lock_owner_address = t2.resource_address
#>}
#---------------------------------------------------------------
#31  860    查詢某個資料庫內各物件使用記憶體暫存區資源的統計
#---------------------------------------------------------------
{<#
   # 待驗證
DECLARE @sql varchar(8000)
SET @sql='
select 	p.object_id
        ,OBJECT_SCHEMA_NAME(object_id, database_id) as SchemaName
        ,object_name(p.object_id,b.database_id) as objname
        ,p.index_id
        ,buffer_count=count(*)
from ' + @db + '.sys.allocation_units a,
    ' + @db + '.sys.dm_os_buffer_descriptors b,
    ' + @db + '.sys.partitions p
where a.allocation_unit_id = b.allocation_unit_id
and a.container_id = p.hobt_id
and b.database_id = db_id('''+@db +''')
group by b.database_id,p.object_id, p.index_id
order by buffer_count desc'
exec(@sql)
#>}
#---------------------------------------------------------------
#32  868 How to discover which locks are currently held
#---------------------------------------------------------------
{<#SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT DB_NAME(resource_database_id) AS DatabaseName, request_session_id, resource_type, CASEWHEN resource_type = 'OBJECT'THEN OBJECT_NAME(resource_associated_entity_id)WHEN resource_type IN ('KEY', 'PAGE', 'RID')THEN (SELECT OBJECT_NAME(OBJECT_ID)FROM sys.partitions pWHERE p.hobt_id = l.resource_associated_entity_id)END AS resource_type_name, request_status, request_modeFROM sys.dm_tran_locks lWHERE request_session_id !=@@spidORDER BY request_session_id
#>}

#---------------------------------------------------------------
#33  900  How to identify contended resources
#---------------------------------------------------------------
{<#SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECTtl1.resource_type,DB_NAME(tl1.resource_database_id) AS DatabaseName,tl1.resource_associated_entity_id,tl1.request_session_id,tl1.request_mode,tl1.request_status, CASEWHEN tl1.resource_type = 'OBJECT'
THEN OBJECT_NAME(tl1.resource_associated_entity_id)WHEN tl1.resource_type IN ('KEY', 'PAGE', 'RID')THEN (SELECT OBJECT_NAME(OBJECT_ID)FROM sys.partitions sWHERE s.hobt_id = tl1.resource_associated_entity_id)END AS resource_type_nameFROM sys.dm_tran_locks as tl1INNER JOIN sys.dm_tran_locks as tl2ON tl1.resource_associated_entity_id = tl2.resource_associated_entity_idAND tl1.request_status <> tl2.request_statusAND (tl1.resource_description = tl2.resource_descriptionOR (tl1.resource_description IS NULLAND tl2.resource_description IS NULL))ORDER BY tl1.resource_associated_entity_id, tl1.request_status
#>}

#---------------------------------------------------------------
#34   934 How to identify contended resources, including SQL query details
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECTtl1.resource_type, DB_NAME(tl1.resource_database_id) AS DatabaseName, tl1.resource_associated_entity_id, tl1.request_session_id, tl1.request_mode, tl1.request_status, CASEWHEN tl1.resource_type = 'OBJECT'THEN OBJECT_NAME(tl1.resource_associated_entity_id)WHEN tl1.resource_type IN ('KEY', 'PAGE', 'RID')THEN (SELECT OBJECT_NAME(OBJECT_ID)FROM sys.partitions sWHERE s.hobt_id = tl1.resource_associated_entity_id)END AS resource_type_name, t.text AS [Parent Query], SUBSTRING (t.text,(r.statement_start_offset/2) + 1,((CASE WHEN r.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2ELSE r.statement_end_offsetEND - r.statement_start_offset)/2) + 1) AS [Individual Query]FROM sys.dm_tran_locks as tl1INNER JOIN sys.dm_tran_locks as tl2ON tl1.resource_associated_entity_id = tl2.resource_associated_entity_idAND tl1.request_status <> tl2.request_statusAND (tl1.resource_description = tl2.resource_descriptionOR (tl1.resource_description IS NULLAND tl2.resource_description IS NULL))INNER JOIN sys.dm_exec_connections cON tl1.request_session_id = c.most_recent_session_idCROSS APPLY sys.dm_exec_sql_text(c.most_recent_sql_handle) tLEFT OUTER JOIN sys.dm_exec_requests r ON c.connection_id = r.connection_idORDER BY tl1.resource_associated_entity_id, tl1.request_status
#---------------------------------------------------------------
#35 966 How to find an idle session with an open transaction
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT es.session_id, es.login_name, es.host_name, est.text, cn.last_read, cn.last_write, es.program_nameFROM sys.dm_exec_sessions esINNER JOIN sys.dm_tran_session_transactions stON es.session_id = st.session_idINNER JOIN sys.dm_exec_connections cnON es.session_id = cn.session_idCROSS APPLY sys.dm_exec_sql_text(cn.most_recent_sql_handle) estLEFT OUTER JOIN sys.dm_exec_requests erON st.session_id = er.session_idAND er.session_id IS NULL

#---------------------------------------------------------------
#36 988 What’s being blocked by idle sessions with open transactions
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECTWaits.wait_duration_ms / 1000 AS WaitInSeconds, Blocking.session_id as BlockingSessionId, DB_NAME(Blocked.database_id) AS DatabaseName, Sess.login_name AS BlockingUser, Sess.host_name AS BlockingLocation, BlockingSQL.text AS BlockingSQL, Blocked.session_id AS BlockedSessionId, BlockedSess.login_name AS BlockedUser, BlockedSess.host_name AS BlockedLocation, BlockedSQL.text AS BlockedSQL, SUBSTRING (BlockedSQL.text, (BlockedReq.statement_start_offset/2) + 1,((CASE WHEN BlockedReq.statement_end_offset = -1THEN LEN(CONVERT(NVARCHAR(MAX), BlockedSQL.text)) * 2ELSE BlockedReq.statement_end_offsetEND - BlockedReq.statement_start_offset)/2) + 1)AS [Blocked Individual Query], Waits.wait_typeFROM sys.dm_exec_connections AS BlockingINNER JOIN sys.dm_exec_requests AS BlockedON Blocking.session_id = Blocked.blocking_session_idINNER JOIN sys.dm_exec_sessions SessON Blocking.session_id = sess.session_idINNER JOIN sys.dm_tran_session_transactions stON Blocking.session_id = st.session_idLEFT OUTER JOIN sys.dm_exec_requests erON st.session_id = er.session_idAND er.session_id IS NULLINNER JOIN sys.dm_os_waiting_tasks AS WaitsON Blocked.session_id = Waits.session_idCROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)AS BlockingSQLINNER JOIN sys.dm_exec_requests AS BlockedReqON Waits.session_id = BlockedReq.session_idINNER JOIN sys.dm_exec_sessions AS BlockedSessON Waits.session_id = BlockedSess.session_idCROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQLORDER BY WaitInSeconds


#---------------------------------------------------------------
#37 1030 What has been blocked for more than 30 seconds
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECTWaits.wait_duration_ms / 1000 AS WaitInSeconds, Blocking.session_id as BlockingSessionId, Sess.login_name AS BlockingUser, Sess.host_name AS BlockingLocation, BlockingSQL.text AS BlockingSQL, Blocked.session_id AS BlockedSessionId, BlockedSess.login_name AS BlockedUser, BlockedSess.host_name AS BlockedLocation, BlockedSQL.text AS BlockedSQL, DB_NAME(Blocked.database_id) AS DatabaseNameFROM sys.dm_exec_connections AS BlockingINNER JOIN sys.dm_exec_requests AS BlockedON Blocking.session_id = Blocked.blocking_session_idINNER JOIN sys.dm_exec_sessions Sess ON Blocking.session_id = sess.session_idINNER JOIN sys.dm_tran_session_transactions st ON Blocking.session_id = st.session_idLEFT OUTER JOIN sys.dm_exec_requests er ON st.session_id = er.session_idAND er.session_id IS NULLINNER JOIN sys.dm_os_waiting_tasks AS Waits ON Blocked.session_id = Waits.session_idCROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle) AS BlockingSQL INNER JOIN sys.dm_exec_requests AS BlockedReq ON Waits.session_id = BlockedReq.session_idINNER JOIN sys.dm_exec_sessions AS BlockedSess ON Waits.session_id = BlockedSess.session_idCROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQLWHERE Waits.wait_duration_ms > 30000ORDER BY WaitInSeconds

#---------------------------------------------------------------
#38 1100 Listing running/blocking processes using SMO  p128
#---------------------------------------------------------------
#Getting force some blocking queries
'Open two new query windows for that connection. Type and run the following in the two query windows'

USE AdventureWorks2008R2
GO
BEGIN TRAN
SELECT *
FROM dbo.ErrorLog
WITH (TABLOCKX)

##  Get
#replace this with your instance name
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#List all processes
$server.EnumProcesses() | Select Name, Spid, Command, Status, Login, Database, BlockingSpid |ft -AutoSize

##Kill
#replace this with your instance name
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$VerbosePreference = "Continue"
#This assumes you already ran the SQL Script in the
#prep section to create the blocking processes

#Otherwise you may not see any results
$server.EnumProcesses() |
Where-Object BlockingSpid -ne 0 | % {
Write-Verbose "Killing SPID $($_.BlockingSpid)"
$server.KillProcess($_.BlockingSpid)
}
$VerbosePreference = "SilentlyContinue"


#---------------------------------------------------------------
#   39 1111 statusOSPCRALL \ps1\0S02_sets_scenario004.ps1 
#---------------------------------------------------------------

step 1 : select * into statusOSPCR FROM sys.dm_os_performance_counters 
step 2 : open table desgin on SSMS + [updateDate] [datetime] NULL  
       ALTER TABLE [dbo].[statusLogSize] ADD  CONSTRAINT [DF_statusLogSize_updateDate]  DEFAULT (getdate()) FOR [updateDate]
Step 3 : script table as  drop and create
step 4 : 

<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\scenario004.ps1

C:\PerfLogs\scenario004.ps1

 createData : Jul.19.2014
 history : 使用內建語法. Insert into * 僅  1777 筆 僅  0.063 Sec ,
 但是使用  foreach  1777 筆 需   11  Sec   差很多
 
 author:Ming Tseng a0921887912@gmail.com

 週期排程收集  DMV sys.dm_os_performance_counters  to  Sql_inventory.statusOSPCRALL
 動態產生  out-file  C:\PerfLogs\Tsql04.ps1
 以及建立在 遠端  schetask

 [string]  $runschdNode,  執行schetask的主機
  [string] $TaskRunTime  ,開始執行時間
  [string] $timespanlenMin  ,執行多久 (分)
  [string] $SampleIntervalSec ,取樣秒數
  [string] $CollectIns  收集的SQL Instance
  [string] $inventoryIns,  儲存的 SQL instance
  [string] $inventorydb   :儲存的 SQL DB 
  .\scenario004 sp2013 1 "18:00:11" spm SQL_Inventory

#>

#---------------------------------------------------------------
#    < A >  CREATE TABLE
#---------------------------------------------------------------
<#table

USE [SQL_Inventory]
GO

ALTER TABLE [dbo].[statusOSPCRALL] DROP CONSTRAINT [DF_statusOSPCRALL_updateDate]
GO

/****** Object:  Table [dbo].[statusOSPCRALL]    Script Date: 7/19/2014 5:59:02 PM ******/
DROP TABLE [dbo].[statusOSPCRALL]
GO


/****** Object:  Table [dbo].[[statusOSPCRALL]]    Script Date: 7/19/2014 5:59:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[statusOSPCRALL](
	[instance_name] [nchar](128) NULL,
	[counter_name] [nchar](128) NULL,
	[cntr_value] [bigint] NULL,
	[object_name] [nchar](128) NULL,
	[updateDate] [datetime] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[statusOSPCRALL] ADD  CONSTRAINT [DF_statusOSPCRALL_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO














#>
#---------------------------------------------------------------
#    < B >  use foreach  保留 不使用
#---------------------------------------------------------------
{<#

Param(
  [string] $runSchdNode,
  [string] $TaskRunTime,
  [string] $SecsInterval,
  [string] $CollectIns,
  [string] $inventoryIns,
  [string] $inventorydb 
)

$runSchdNode ="sp2013"
$TaskRunTime ="17:12:00"
$SampleIntervalSec="5"
$CollectIns  ="spm"
$inventoryIns="spm"
$inventorydb ="SQL_Inventory"

#$filedest='\\sql2012x\C$\PerfLogs\1.ps1'
#---------------------------------------------------------------
#   out-file 
#---------------------------------------------------------------

$filedest ="\\"+$runSchdNode+'\C$\PerfLogs\Tsql004.ps1'
## file column don't over 80 -Width 160
$Filecontent={
Param(
  [string] $inventoryIns,
  [string] $inventorydb
)
#$inventoryIns="spm"
#$inventorydb   ="SQL_Inventory"

if ((Get-Module -Name sqlps) -eq $null) {Import-Module “sqlps” -DisableNameChecking}
$t1=get-date;$t1
#$tquery="select * FROM sys.dm_os_performance_counters where counter_name='Transactions/sec'"
$tquery="select  *  FROM sys.dm_os_performance_counters"
$DMVOSPCRS = Invoke-Sqlcmd  -ServerInstance $CollectIns -Query $tquery

$t2=get-date;$t2
$DMVOSPCRS.Count
foreach ($DMVOSPCR in $DMVOSPCRS)
{ #p90
 
       $vinstance_name=($DMVOSPCR[2]).Trim()
       $vcounter_name =($DMVOSPCR[1]).Trim()
       $vcntr_value   =$DMVOSPCR[3]
       $vobject_name  =($DMVOSPCR[0]).Trim()
     if (($vinstance_name).Contains("'") -eq $True)
     { $vinstance_name=$vinstance_name -replace("'"," ")}
       
$sql_insert =@" 
INSERT INTO [dbo].[statusOSPCRALL]
           ([instance_name]
           ,[counter_name]
           ,[cntr_value]
           ,[object_name]
           )
     VALUES
           ('$vinstance_name'
           ,'$vcounter_name'  
           ,'$vcntr_value'
           ,'$vobject_name'
           )
"@
    #$sql_insert 
    Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb
}#p90
$t3=get-date;$t3

($t2-$t1).TotalSeconds
($t3-$t2).TotalSeconds

}

cd c:\
$Filecontent |  Out-File  $filedest -Width 160 -force
insert into statusOSPCRALL (instance_name,counter_name,cntr_value,object_name) select instance_name,counter_name,cntr_value,object_name   FROM sys.dm_os_performance_counters  
#>}
#---------------------------------------------------------------
#    < C >   內建語法. Insert into * 
#---------------------------------------------------------------
<#
Param(
  [string] $runSchdNode,
  [string] $TaskRunTime,
  [string] $SecsInterval,
  [string] $CollectIns,
  [string] $inventoryIns,
  [string] $inventorydb 
)
#>
$runSchdNode ="sp2013"
$TaskRunTime ="17:12:00"
$timespanlenMin=1
$SampleIntervalSec="5"
$CollectIns  ="spm"
$inventoryIns="spm"
$inventorydb ="SQL_Inventory"

#$filedest='\\sql2012x\C$\PerfLogs\1.ps1'
#---------------------------------------------------------------
#   < C1 >  out-file 
#---------------------------------------------------------------

$filedest ="\\"+$runSchdNode+'\C$\PerfLogs\Tsql004.ps1'
## file column don't over 80 -Width 160
$Filecontent={  #p.188
Param(
  [string] $inventoryIns,
  [string] $inventorydb
)
#$inventoryIns="spm"
#$inventorydb   ="SQL_Inventory"
if ((Get-Module -Name sqlps) -eq $null) {Import-Module “sqlps” -DisableNameChecking}
$sql_insert=@"
insert into statusOSPCRALL (instance_name,counter_name,cntr_value,object_name) 
select instance_name,counter_name,cntr_value,object_name   FROM sys.dm_os_performance_counters  
"@
 Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb
} #p.188

cd c:\
$Filecontent |  Out-File  $filedest -Width 160 -force
#---------------------------------------------------------------
#   < C2 > schetask.msc
#---------------------------------------------------------------

icm -ComputerName $destNode -ScriptBlock {

$TaskName       = "Tsql004"

$TaskDescr =  $TaskName +"  check logSpaceUsed % :  DaysInterval each "+$using:DaysInterval +" Day  ,TaskRunTime:" + $using:TaskRunTime 
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $using:para_svrinstance +" "+ $using:para_database
$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval $using:DaysInterval -At $using:TaskRunTime 
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "$env:USERDOMAIN\$env:USERNAME" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
}
#icm -ComputerName $destNode  -ScriptBlock {Unregister-ScheduledTask –TaskName $using:TaskName  -Confirm:$false}

{<#
#---------------------------------------------------------------
#  schetask.msc
#---------------------------------------------------------------
$script={
#$TaskRunTime    = "14:30:00" 
$TaskName       = "Tsql003"

$para_timespanlen='10'
$para_SampleInterval=5

$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +"   ,SampleInterval:" + $para_SampleInterval+"sec"
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_svrinstance +" "+ $para_database
$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" #$TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once
$TaskTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval 2 -At "01:01:01" 
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "$env:USERDOMAIN\$env:USERNAME" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
##Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false 
}

icm -ComputerName $destNode -ScriptBlock $script
#icm -ComputerName sp2013 -ScriptBlock {Unregister-ScheduledTask –TaskName $using:TaskName  -Confirm:$false}
#>}

##
#---------------------------------------------------------------
#   40  1400 連續執行記錄執行時間總筆數
#---------------------------------------------------------------
$x=1
do
{
    

$t1=get-date;$t1
$sql_insert=@"
insert into statusOSPCRALL (instance_name,counter_name,cntr_value,object_name) select instance_name,counter_name,cntr_value,object_name   FROM sys.dm_os_performance_counters  
"@

 t2=get-date;$t2
 Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb
 $t3=get-date;$t3

$x.tostring() +' p1 = '+ ($t2-$t1).TotalSeconds
$x.tostring() +' p2 = '+ ($t3-$t2).TotalSeconds

   sleep 2
    $x +=1
}
until ($x -gt 5)  

#---------------------------------------------------------------
#   1596  儲存 DMV 到 SQL_inventory  perfXXX sample
#---------------------------------------------------------------

#---------------------step 1/5 : TSQl  + into perfXXX

'use SQL_inventory

select session_id,login_time,host_name,login_name,status,last_request_start_time,last_request_end_time 
,GETDATE() as updateDT

into perfsession
     FROM sys.dm_exec_sessions  where  session_id > 50 '



#---------------------step 2/5 : script by SSMs
'USE [SQL_inventory]
GO

/****** Object:  Table [dbo].[perfsession]    Script Date: 2015/11/13 下午 01:38:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[perfsession](
	[session_id] [smallint] NOT NULL,
	[login_time] [datetime] NOT NULL,
	[host_name] [nvarchar](128) NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[status] [nvarchar](30) NOT NULL,
	[last_request_start_time] [datetime] NOT NULL,
	[last_request_end_time] [datetime] NULL,
	[updateDT] [datetime] NOT NULL
) ON [PRIMARY]

GO


 '


#---------------------step 3/5 : 

select   * from perfsession
select   * from perfsession where session_id='56'
    
    function viewperfsession ($param1, $param2) {
 $d=Invoke-Sqlcmd -ServerInstance PMD2016 -database sql_inventory -Username sa -Password p@ssw0rds -Query 'select   * from perfsession' 
 $d |ft -AutoSize       
    }

    
--drop tale SQL_inventory.dbo.perfsession
#truncate table perfsession
Invoke-Sqlcmd -ServerInstance PMD2016 -database sql_inventory -Username sa -Password p@ssw0rds -Query 'truncate table perfsession' 

#---------------------step 4/5 :   insert 
$tsql_insertperfsession=@"
insert   perfsession
select session_id,login_time,host_name,login_name,status,last_request_start_time,last_request_end_time 
,GETDATE() as updateDT
 FROM sys.dm_exec_sessions  where  session_id > 50
"@

for ($i = 1; $i -eq 300; $i++)  
{ #
    Invoke-Sqlcmd -ServerInstance PMD2016 -Username sa -database sql_inventory -Password p@ssw0rds -Query $tsql_insertperfsession 
    start-sleep 2
}

viewperfsession
#---------------------step 5/5 : 
 truncate table perfsession


#---------------------------------------------------------------
#   1677 big table sample data  lab
#---------------------------------------------------------------
ref: \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps09_replication.ps1  line  1 Test data  

     \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS02_03_Sharepoint_SQL.ps1  line   24   Get basic info

     \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql005.ps1






#--------------------------------------------------
#  1677_1699  funciton 
#--------------------------------------------------
function dbmdfldfSize ($dbinstance,$dbname){
  $tsql_selectdbFileSize="
print 'Show Size, Space Used, Unused Space, Type, and Name of all database files'
select
	[FileSizeMB]	=
		convert(numeric(10,2),sum(round(a.size*0.008,2))),
        [UsedSpaceMB]	=
		convert(numeric(10,2),sum(round(fileproperty( a.name,'SpaceUsed')*0.008,2))) ,
        [UnusedSpaceMB]	=
		convert(numeric(10,2),sum(round((a.size-fileproperty( a.name,'SpaceUsed'))*0.008 ,2))) ,
	[Type] =
		case when a.groupid is null then '' when a.groupid = 0 then 'Log' else 'Data' end,
	[DBFileName]	= isnull(a.name,'+++ Total for all files ++')
from
	sysfiles a
group by
	groupid,
	a.name
	with rollup
having
	a.groupid is null or
	a.name is not null
order by
	case when a.groupid is null then 99 when a.groupid = 0 then 0 else 1 end,
	a.groupid,
	case when a.name is null then 99 else 0 end,
	a.name
"
Invoke-Sqlcmd -Query $tsql_selectdbFileSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rds  |ft -AutoSize  
}
dbmdfldfSize PMD2016 sql_inventory
function  KillSID ($SID){
$tsql_KillSID=@"
kill $SID
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_KillSID
"Kill $SID sucess"
}
function  KillSessionByHostname ($ServerInstance, $hostaname){
    

#Invoke-Sqlcmd -ServerInstance pmd2016 -Username usql2014x -Password p@ssw0rds -Query 'select @@spid'  

$tsql_getsessionidbyHostname=@"
select session_id FROM sys.dm_exec_sessions  where  session_id > 50 and session_id <> @@spid and host_name='$hostaname'
"@

$SIDs=Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_getsessionidbyHostname

foreach ($SID in $SIDs)
{
     $spid =$SID.session_id
     $tsql_killSID="kill $spid  "; $tsql_killSID
}
Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_killSID
}
function  KillSessionByLoginname ($ServerInstance, $Loginname){

$tsql_getsessionidbyHostname=@"
select session_id FROM sys.dm_exec_sessions  where  session_id > 50  and login_name='$Loginname'
"@

$SIDs=Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_getsessionidbyHostname

foreach ($SID in $SIDs)
{
     $spid =$SID.session_id
     $tsql_killSID="kill $spid  "; $tsql_killSID +' success '
}
Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_killSID
}
function  GetallSID ($ServerInstance, $hostaname){

if ($hostaname -eq 'all')
{
    $tsql_GetallSession=@" 
select session_id,login_time,host_name,login_name,status,last_request_start_time,last_request_end_time 
     FROM sys.dm_exec_sessions  where  session_id > 50 order by last_request_start_time desc
"@
}
else
{
    $tsql_GetallSession=@" 
select session_id,login_time,host_name,login_name,status,last_request_start_time,last_request_end_time 
     FROM sys.dm_exec_sessions  where  session_id > 50 and host_name='$hostaname' order by last_request_start_time desc
"@
}


$r=Invoke-Sqlcmd -ServerInstance $ServerInstance -Username sqlsa -Password p@ssw0rds -Query $tsql_GetallSession 
$r |ft -AutoSize
' SId total  : '   + $r.count
}
function GetTableRowSize ($dbinstance, $dbname){
  $tsql_GetTableRowSize=@"
create table #TABLE_SPACE_WORK
(
	TABLE_NAME 	sysname		not null ,
	TABLE_ROWS 	numeric(18,0)	not null ,
	RESERVED 	varchar(50) 	not null ,
	DATA 		varchar(50) 	not null ,
	INDEX_SIZE 	varchar(50) 	not null ,
	UNUSED 		varchar(50) 	not null ,
)

create table #TABLE_SPACE_USED
(
	Seq		int		not null	
	identity(1,1)	primary key clustered,
	TABLE_NAME 	sysname		not null ,
	TABLE_ROWS 	numeric(18,0)	not null ,
	RESERVED 	varchar(50) 	not null ,
	DATA 		varchar(50) 	not null ,
	INDEX_SIZE 	varchar(50) 	not null ,
	UNUSED 		varchar(50) 	not null ,
)
create table #TABLE_SPACE
(
	Seq		int		not null
	identity(1,1)	primary key clustered,
	TABLE_NAME 	SYSNAME 	not null ,
	TABLE_ROWS 	int	 	not null ,
	RESERVED 	int	 	not null ,
	DATA 		int	 	not null ,
	INDEX_SIZE 	int	 	not null ,
	UNUSED 		int	 	not null ,
	USED_MB				numeric(18,4)	not null,
	USED_GB				numeric(18,4)	not null,
	AVERAGE_BYTES_PER_ROW		numeric(18,5)	null,
	AVERAGE_DATA_BYTES_PER_ROW	numeric(18,5)	null,
	AVERAGE_INDEX_BYTES_PER_ROW	numeric(18,5)	null,
	AVERAGE_UNUSED_BYTES_PER_ROW	numeric(18,5)	null,
)




declare @fetch_status int
declare @proc 	varchar(200)
select	@proc	= rtrim(db_name())+'.dbo.sp_spaceused'
declare Cur_Cursor cursor local
for
--select TABLE_NAME	= rtrim(TABLE_SCHEMA)+'.'+rtrim(TABLE_NAME)
--from INFORMATION_SCHEMA.TABLES 
--where  TABLE_TYPE	= 'BASE TABLE'
--order by	1

select TABLE_NAME =name  from  sys.tables  where is_ms_shipped ='0'

open Cur_Cursor
declare @TABLE_NAME 	varchar(200)
select @fetch_status = 0
while @fetch_status = 0
	begin
fetch next from Cur_Cursor
	into
		@TABLE_NAME
select @fetch_status = @@fetch_status
if @fetch_status <> 0
		begin
		continue
		end
truncate table #TABLE_SPACE_WORK
insert into #TABLE_SPACE_WORK
		(
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
		)
	exec @proc @objname =  @TABLE_NAME ,@updateusage = 'true'
-- Needed to work with SQL 7
	update #TABLE_SPACE_WORK
	set
		TABLE_NAME = @TABLE_NAME
insert into #TABLE_SPACE_USED
		(
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
		)
	select
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
	from
		#TABLE_SPACE_WORK
end 	--While end
close Cur_Cursor
deallocate Cur_Cursor
insert into #TABLE_SPACE
	(
	TABLE_NAME,
	TABLE_ROWS,
	RESERVED,
	DATA,
	INDEX_SIZE,
	UNUSED,
	USED_MB,
	USED_GB,
	AVERAGE_BYTES_PER_ROW,
	AVERAGE_DATA_BYTES_PER_ROW,
	AVERAGE_INDEX_BYTES_PER_ROW,
	AVERAGE_UNUSED_BYTES_PER_ROW
)
select
	TABLE_NAME,
	TABLE_ROWS,
	RESERVED,
	DATA,
	INDEX_SIZE,
	UNUSED,
	USED_MB			=
		round(convert(numeric(25,10),RESERVED)/
		convert(numeric(25,10),1024),4),
	USED_GB			=
		round(convert(numeric(25,10),RESERVED)/
		convert(numeric(25,10),1024*1024),4),
	AVERAGE_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),RESERVED))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_DATA_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),DATA))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_INDEX_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),INDEX_SIZE))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_UNUSED_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),UNUSED))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end
from
	(
	select
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED	= 
		convert(int,rtrim(replace(RESERVED,'KB',''))),
		DATA		= 
		convert(int,rtrim(replace(DATA,'KB',''))),
		INDEX_SIZE	= 
		convert(int,rtrim(replace(INDEX_SIZE,'KB',''))),
		UNUSED		= 
		convert(int,rtrim(replace(UNUSED,'KB','')))
	from
		#TABLE_SPACE_USED aa
	) a
order by
	TABLE_NAME

print 'Show results in descending order by size in MB'
select TABLE_NAME,TABLE_ROWS,USED_MB,AVERAGE_BYTES_PER_ROW,AVERAGE_DATA_BYTES_PER_ROW,AVERAGE_INDEX_BYTES_PER_ROW,AVERAGE_UNUSED_BYTES_PER_ROW

from #TABLE_SPACE order by USED_MB desc
go
drop table #TABLE_SPACE_WORK
drop table #TABLE_SPACE_USED 
drop table #TABLE_SPACE
"@
Invoke-Sqlcmd -Query $tsql_GetTableRowSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rds  |ft -AutoSize    
}
function GetSQLallSID (){
   do
{
    Get-Date
    $y=getallSid $ServerInstance all; $y
    start-sleep  2
    #viewperfsession
}
until ($j -gt 0)
 
}
function  mysid (){
    Invoke-Sqlcmd -ServerInstance pmd2016 -Username sqlsa -Password p@ssw0rds -Query 'select @@spid as Mysid '|ft -auto
}
function  sqlview (){
  $tsql2213=@"
--truncate table T61
select top 20 *,totalcount/testsec  as averageSec  from BLTSQL005 order by insertdt desc
--select top 10 * from T61 order by  createdate desc
"@
invoke-sqlcmd -ServerInstance  PMD2016 -database sql_inventory -query $tsql2213 -user sqlsa  -password p@ssw0rds  |Out-GridView

$tsql2220=@"
--truncate table T61
--select top 77 *,totalcount/testsec  as averageSec  from BLTSQL005 order by insertdt desc
select top 77 iid,rid,createDate,inserthost,spid,ppid,systemuser from T61 order by  createdate desc
"@
invoke-sqlcmd -ServerInstance  PMD2016 -database sql_inventory -query $tsql2220 -user sqlsa  -password p@ssw0rds  |Out-GridView  
}
function  sqlviewbyTime ($hms,$dt){
#  sqlviewbyTime 16:30:00
#  $hms='09:08:00' ;$dt='2015-12-15'
$tsql2019=@"
select  SYSTEMUSER,ppid,SPID,max(createDate) as maxr ,min(createDate) as minr,count(iid) as rows 
,DATEPART(SECOND, max(createDate) - min(createDate) )  as diff
from  t61  where createDate  > Cast('$dt $hms' as datetime2(1))
group by SYSTEMUSER,ppid,SPID
order by minr,SYSTEMUSER
"@
#$tsql2019
invoke-sqlcmd -ServerInstance  PMD2016 -database sql_inventory -query $tsql2019 -user sqlsa  -password p@ssw0rds  |Out-GridView
}
sqlviewbyTime 09:08:00 2015-12-15
function waitrun ([string]$th,[string] $tm){
 #$th='14' ;$tm='10'[datetime]$b1 =  $th+':'+$tm+':00'do{   $d=get-date ;   } until ($d -gt $b1);  get-date 
} # waitrun 08 56

$tsql_select53="select name, physical_name, size *0.000008 from sys.master_files"     

Invoke-Sqlcmd -Query $tsql_select53 -ServerInstance  PMD2016  -user sa  -password p@ssw0rd  |ft -AutoSize


$tsql_GetTableRowSize=@"
create table #TABLE_SPACE_WORK
(
	TABLE_NAME 	sysname		not null ,
	TABLE_ROWS 	numeric(18,0)	not null ,
	RESERVED 	varchar(50) 	not null ,
	DATA 		varchar(50) 	not null ,
	INDEX_SIZE 	varchar(50) 	not null ,
	UNUSED 		varchar(50) 	not null ,
)

create table #TABLE_SPACE_USED
(
	Seq		int		not null	
	identity(1,1)	primary key clustered,
	TABLE_NAME 	sysname		not null ,
	TABLE_ROWS 	numeric(18,0)	not null ,
	RESERVED 	varchar(50) 	not null ,
	DATA 		varchar(50) 	not null ,
	INDEX_SIZE 	varchar(50) 	not null ,
	UNUSED 		varchar(50) 	not null ,
)
create table #TABLE_SPACE
(
	Seq		int		not null
	identity(1,1)	primary key clustered,
	TABLE_NAME 	SYSNAME 	not null ,
	TABLE_ROWS 	int	 	not null ,
	RESERVED 	int	 	not null ,
	DATA 		int	 	not null ,
	INDEX_SIZE 	int	 	not null ,
	UNUSED 		int	 	not null ,
	USED_MB				numeric(18,4)	not null,
	USED_GB				numeric(18,4)	not null,
	AVERAGE_BYTES_PER_ROW		numeric(18,5)	null,
	AVERAGE_DATA_BYTES_PER_ROW	numeric(18,5)	null,
	AVERAGE_INDEX_BYTES_PER_ROW	numeric(18,5)	null,
	AVERAGE_UNUSED_BYTES_PER_ROW	numeric(18,5)	null,
)




declare @fetch_status int
declare @proc 	varchar(200)
select	@proc	= rtrim(db_name())+'.dbo.sp_spaceused'
declare Cur_Cursor cursor local
for
--select TABLE_NAME	= rtrim(TABLE_SCHEMA)+'.'+rtrim(TABLE_NAME)
--from INFORMATION_SCHEMA.TABLES 
--where  TABLE_TYPE	= 'BASE TABLE'
--order by	1

select TABLE_NAME =name  from  sys.tables  where is_ms_shipped ='0'

open Cur_Cursor
declare @TABLE_NAME 	varchar(200)
select @fetch_status = 0
while @fetch_status = 0
	begin
fetch next from Cur_Cursor
	into
		@TABLE_NAME
select @fetch_status = @@fetch_status
if @fetch_status <> 0
		begin
		continue
		end
truncate table #TABLE_SPACE_WORK
insert into #TABLE_SPACE_WORK
		(
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
		)
	exec @proc @objname =  @TABLE_NAME ,@updateusage = 'true'
-- Needed to work with SQL 7
	update #TABLE_SPACE_WORK
	set
		TABLE_NAME = @TABLE_NAME
insert into #TABLE_SPACE_USED
		(
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
		)
	select
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED,
		DATA,
		INDEX_SIZE,
		UNUSED
	from
		#TABLE_SPACE_WORK
end 	--While end
close Cur_Cursor
deallocate Cur_Cursor
insert into #TABLE_SPACE
	(
	TABLE_NAME,
	TABLE_ROWS,
	RESERVED,
	DATA,
	INDEX_SIZE,
	UNUSED,
	USED_MB,
	USED_GB,
	AVERAGE_BYTES_PER_ROW,
	AVERAGE_DATA_BYTES_PER_ROW,
	AVERAGE_INDEX_BYTES_PER_ROW,
	AVERAGE_UNUSED_BYTES_PER_ROW
)
select
	TABLE_NAME,
	TABLE_ROWS,
	RESERVED,
	DATA,
	INDEX_SIZE,
	UNUSED,
	USED_MB			=
		round(convert(numeric(25,10),RESERVED)/
		convert(numeric(25,10),1024),4),
	USED_GB			=
		round(convert(numeric(25,10),RESERVED)/
		convert(numeric(25,10),1024*1024),4),
	AVERAGE_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),RESERVED))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_DATA_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),DATA))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_INDEX_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),INDEX_SIZE))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end,
	AVERAGE_UNUSED_BYTES_PER_ROW	=
		case
		when TABLE_ROWS <> 0
		then round(
		(1024.000000*convert(numeric(25,10),UNUSED))/
		convert(numeric(25,10),TABLE_ROWS),5)
		else null
		end
from
	(
	select
		TABLE_NAME,
		TABLE_ROWS,
		RESERVED	= 
		convert(int,rtrim(replace(RESERVED,'KB',''))),
		DATA		= 
		convert(int,rtrim(replace(DATA,'KB',''))),
		INDEX_SIZE	= 
		convert(int,rtrim(replace(INDEX_SIZE,'KB',''))),
		UNUSED		= 
		convert(int,rtrim(replace(UNUSED,'KB','')))
	from
		#TABLE_SPACE_USED aa
	) a
order by
	TABLE_NAME

print 'Show results in descending order by size in MB'
select TABLE_NAME,TABLE_ROWS,USED_MB,AVERAGE_BYTES_PER_ROW,AVERAGE_DATA_BYTES_PER_ROW,AVERAGE_INDEX_BYTES_PER_ROW,AVERAGE_UNUSED_BYTES_PER_ROW

from #TABLE_SPACE order by USED_MB desc
go
drop table #TABLE_SPACE_WORK
drop table #TABLE_SPACE_USED 
drop table #TABLE_SPACE
"@
Invoke-Sqlcmd -Query $tsql_GetTableRowSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rds  |ft -AutoSize  

GetSQLallSID  #每2Sec 檢查現有連線資訊
ssms

GetTableRowSize $ServerInstance SQL_inventory

killSID 53
KillSessionByLoginname  $ServerInstance sa
KillSessionByHostname  $ServerInstance sql2014x




#--------------------------------------------------
#  1677_2219   Test Nodes & account
#--------------------------------------------------

$ServerInstance='pmd2016'

$hostaname='PMD2016'
$h1='2016BI' 
$h2='PMD'
$h3='sp2013'
$h4='SQL2014X'

$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$h2credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd


$pTServerInstance='PMD2016' $pGServerInstance='PMD2016'  $pTdatabase      ='SQL_inventory'$pGdatabase      ='SQL_inventory'$ptsec           ='10'



#---------------------------------------------------------------
#   1677_2225    scenario I   第一次執行時.是否需要建立連線時間　　$h1='2016BI' 
#---------------------------------------------------------------


# $h1='2016BI'  本機DB
#  Run at Powersehll_ise
# 1.1.0 copy  C:\PerfLogs\TSQL005.ps1  to each Node
# 1.1.1 . C:\PerfLogs\TSQL005.ps1  $pTServerInstance $pGServerInstance $pTdatabase $pGdatabase $ptsec @ run at TsqlTrigger.ps1

GetSQLallSID ; 
KillSID 54 ;GetSQLallSID

gps -Name powershell_ise |stop-process -force ;  #將 Powershell_ise trun off 
Start-Process powershell_ise  -Verb runas -ArgumentList { "C:\PerfLogs\TSQL005.ps1 , C:\PerfLogs\TSQL005Trigger.ps1"  }  #  @run powershell 

result :  First time : 10sec ,insert 17 Rows,  average  1Row/Sec
          但是  SSID, PSID Keep （意指powershell_ise No Close ）, Next :  10Sec insert 58 Rows,  average: 5Row/Sec 
          只要  powershell_ise 不關閉, 即是  KillSID 54 ,也是 可以 5 Row / sec
'
10	57	4	PMD2016	12/14/2015 2:47:25 PM	51	13172	upmd2016	5	<-- killSID ,run again,可見依可GET 原來的SID
10	48	4	PMD2016	12/14/2015 2:46:09 PM	51	13172	upmd2016	4	<--second  SSID,PPID keep 
10	18	3	PMD2016	12/14/2015 2:43:25 PM	51	13172	upmd2016	1	 <--first

'
GetSQLallSID ; 
KillSID 53 ;GetSQLallSID
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell_ise |stop-process -force ; }
sqlview

# 1.2.1  $h4='SQL2014X'  remote DB

GetSQLallSID ; 
KillSID 51;KillSID 53 ;GetSQLallSID 
sqlview 

result :  First time : 10sec ,insert 1 Rows,  average  0 Row/Sec
          但是  SSID, PSID Keep it（意指powershell_ise No Close ）, Next :  10Sec insert 42 Rows,  average: 4Row/Sec 
          只要  powershell_ise 不關閉, 即是  KillSID xx ,也是 可以 4 Row / sec
'
10	44	4	SQL2014X	12/14/2015 2:38:06 PM	51	3620	usql2014x	4	<-- killSID ,run again,可見依可GET 原來的SID
10	48	4	SQL2014X	12/14/2015 2:36:35 PM	51	3620	usql2014x	4	<--second  SSID,PPID keep 
10	15	4	SQL2014X	12/14/2015 2:35:47 PM	51	3620	usql2014x	1	<--first
10	24	4	SQL2014X	12/14/2015 2:33:00 PM	51	3044	usql2014x	2	

'
icm -ComputerName sql2014x -ScriptBlock  {gps -Name powershell_ise |stop-process -force ; }


#---------------------------------------------------------------
#   1677_2244    scenario II    function call ,  ps1 call 在 Powershell_ise 是不是同一個 PPID
#---------------------------------------------------------------
# $h1='2016BI'  本機DB
#  Run at Powersehll_ise
# 2.1.0 copy  C:\PerfLogs\TSQL005.ps1  to each Node
# 2.1.1 TSQL005  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 @powersehll_ise using function
GetSQLallSID ; 
'
Monday, December 14, 2015 2:55:02 PM
session_id login_time            host_name login_name status  last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------  ----------------------- ---------------------
        51 12/14/2015 2:55:04 PM SP2013    sqlsa      running 12/14/2015 2:55:04 PM   12/14/2015 2:55:04 PM
'
KillSID 54 ;GetSQLallSID
Start-Process powershell_ise  -Verb runas -ArgumentList { "C:\PerfLogs\TSQL005.ps1 , C:\PerfLogs\TSQL005Trigger.ps1"  }  #  @run powershell 

'
10	56	4	PMD2016	12/14/2015 2:58:58 PM	52	16268	upmd2016	5	<- TSQL005Trigger  call tsql005.ps1 . C:\PerfLogs\TSQL005.ps1  $pTServerInstance $pGServerInstance $pTdatabase $pGdatabase $ptsec
10	53	4	PMD2016	12/14/2015 2:57:57 PM	52	16268	upmd2016	5	<- second tsql005.ps1 function call
10	16	3	PMD2016	12/14/2015 2:56:26 PM	52	16268	upmd2016	1	<- First using tsql005.ps1 function call
'
result :　同一PPID  在Powershell 內 是相同地.

GetSQLallSID ; 
KillSID 53 ;GetSQLallSID
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell_ise |stop-process -force ; }
'
session_id login_time            host_name login_name status   last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------   ----------------------- ---------------------
        51 12/14/2015 3:03:30 PM SP2013    sqlsa      running  12/14/2015 3:03:30 PM   12/14/2015 3:03:30 PM
        54 12/14/2015 3:03:01 PM SP2013    sqlsa      sleeping 12/14/2015 3:03:01 PM   12/14/2015 3:03:01 PM


'

#---------------------------------------------------------------
#     1677_2343      scenario III   Powershell call ps1
#---------------------------------------------------------------
# runNode = call call  local,  $ptsec ='10'
# 3.1.0 copy  C:\PerfLogs\TSQL005.ps1  to each Node
# 3.1.1 run powershell

GetSQLallSID 
'
session_id login_time            host_name login_name status  last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------  ----------------------- ---------------------
        51 12/14/2015 3:08:16 PM SP2013    sqlsa      running 12/14/2015 3:08:16 PM   12/14/2015 3:08:16 PM
'
. C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10
sqlview
'
10	63	3	PMD2016	12/14/2015 3:16:08 PM	51	12100	upmd2016	6	<--
10	17	3	PMD2016	12/14/2015 3:14:13 PM	51	12100	upmd2016	1	<-- close powershell ,execute . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 

10	53	4	PMD2016	12/14/2015 3:10:08 PM	52	10728	upmd2016	5	<-- powershell not close(keep) ,run again
10	18	3	PMD2016	12/14/2015 3:09:03 PM	52	10728	upmd2016	1	<-- at powershell first call

'
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell |stop-process -force ; }

result : 只要是PPID  ,Ssession 沒有關閉. 第2次會比較順.

# runNode = remote  call  local,  $ptsec ='10'
# 3.2.0 copy  C:\PerfLogs\TSQL005.ps1  to each Node
# 3.2.1 run powershell

GetSQLallSID 
'
session_id login_time            host_name login_name status  last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------  ----------------------- ---------------------
        51 12/14/2015 3:20:54 PM SP2013    sqlsa      running 12/14/2015 3:20:54 PM   12/14/2015 3:20:54 PM
'

icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 }
'
10	16	4	PMD2016	12/14/2015 3:22:41 PM	53	7148	upmd2016	1	<--

10	16	3	PMD2016	12/14/2015 3:21:36 PM	52	6208	upmd2016	1	<--

'
resutl : 
GetSQLallSID 
'
session_id login_time            host_name login_name status   last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------   ----------------------- ---------------------
        52 12/14/2015 3:41:06 PM SP2013    sqlsa      running  12/14/2015 3:41:06 PM   12/14/2015 3:41:06 PM
        51 12/14/2015 3:38:26 PM SP2013    sqlsa      sleeping 12/14/2015 3:38:26 PM   12/14/2015 3:38:26 PM
'


# runNode = remote  call  local,  $ptsec ='10'

# 3.3.1 run powershell using -asjob
get-job | remove-job ; get-job

icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob

'
10	14	4	PMD2016	12/14/2015 3:34:13 PM	52	5496	upmd2016	1	 <-- sametime two PPID
10	17	3	PMD2016	12/14/2015 3:34:13 PM	51	10956	upmd2016	1	 <-- 同時 2 PPID  =31rows
'

icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
'
10	18	6	PMD2016	12/14/2015 3:37:46 PM	52	4672	upmd2016	1	<-  3 PPID
10	19	6	PMD2016	12/14/2015 3:37:46 PM	54	14752	upmd2016	1	<-  3 PPID
10	14	5	PMD2016	12/14/2015 3:37:46 PM	53	4468	upmd2016	1	<-  3 PPID  =51 rows
'


'session_id login_time            host_name login_name status   last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------   ----------------------- ---------------------
        52 12/14/2015 3:41:06 PM SP2013    sqlsa      running  12/14/2015 3:41:06 PM   12/14/2015 3:41:06 PM
        51 12/14/2015 3:38:26 PM SP2013    sqlsa      sleeping 12/14/2015 3:38:26 PM   12/14/2015 3:38:26 PM'
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
'
10	13	8	PMD2016	12/14/2015 3:43:01 PM	54	6276	upmd2016	1	<- 4PPID
10	12	7	PMD2016	12/14/2015 3:43:01 PM	55	4224	upmd2016	1	<- 4PPID
10	15	8	PMD2016	12/14/2015 3:43:01 PM	53	1248	upmd2016	1	<- 4PPID
10	7	7	PMD2016	12/14/2015 3:43:01 PM	56	9204	upmd2016	0	<- 4PPID  = 47 rows

'
get-job | remove-job ; get-job ; GetSQLallSID

for ($i = 0; $i -lt 5; $i++){ icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob}
'
10	3	7	PMD2016	12/14/2015 3:48:13 PM	56	7664	upmd2016	0	<- 5PPID
10	3	10	PMD2016	12/14/2015 3:48:13 PM	55	7476	upmd2016	0	<- 5PPID
10	4	9	PMD2016	12/14/2015 3:48:13 PM	54	3636	upmd2016	0	<- 5PPID
10	7	8	PMD2016	12/14/2015 3:48:13 PM	53	320  	upmd2016	0	<- 5PPID
10	8	7	PMD2016	12/14/2015 3:48:13 PM	51	15576	upmd2016	0   <- 5PPID  = 25 rows


10	7	8	PMD2016	12/14/2015 3:51:50 PM	55	15264	upmd2016	0	- 5PPID
10	11	7	PMD2016	12/14/2015 3:51:50 PM	53	7448	upmd2016	1	- 5PPID
10	3	10	PMD2016	12/14/2015 3:51:50 PM	57	14972	upmd2016	0	- 5PPID
10	8	9	PMD2016	12/14/2015 3:51:50 PM	54	5888	upmd2016	0	- 5PPID
10	3	8	PMD2016	12/14/2015 3:51:50 PM	56	11332	upmd2016	0	- 5PPID  = 32 rows

'

for ($i = 0; $i -lt 2; $i++){ icm -ComputerName sql2014x -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob}
sqlview
'
10	20	5	SQL2014X	12/14/2015 3:55:43 PM	54	2992	usql2014x	2	<- 2PPID 
10	22	4	SQL2014X	12/14/2015 3:55:43 PM	53	3984	usql2014x	2	<- 2PPID  =40 rows

10	17	5	SQL2014X	12/14/2015 3:57:42 PM	53	3632	usql2014x	1	
10	19	4	SQL2014X	12/14/2015 3:57:42 PM	52	2036	usql2014x	1	

'
# 同時 PMD2016, sql2014x , 3PPID 
get-job | remove-job ; get-job ; GetSQLallSID
'session_id login_time            host_name login_name status  last_request_start_time last_request_end_time
---------- ----------            --------- ---------- ------  ----------------------- ---------------------
        52 12/14/2015 4:02:56 PM SP2013    sqlsa      running 12/14/2015 4:02:56 PM   12/14/2015 4:02:56 PM'
for ($i = 0; $i -lt 3; $i++){
  icm -ComputerName sql2014x               -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
  icm -ComputerName pmd2016  -Credential $h2credential  { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
}
'
'

'
10	17	7	SQL2014X	12/14/2015 4:05:04 PM	51	140	    usql2014x	1	<- 　2Nodes6PPID
10	12	9	SQL2014X	12/14/2015 4:05:03 PM	56	2908	usql2014x	1	<- 　2Nodes6PPID
10	12	8	SQL2014X	12/14/2015 4:05:03 PM	53	2564	usql2014x	1	<- 　2Nodes6PPID
10	15	10	PMD2016	    12/14/2015 4:05:03 PM	54	4324	upmd2016	1	<- 　2Nodes6PPID
10	15	9	PMD2016	    12/14/2015 4:05:03 PM	57	11960	upmd2016	1	<- 　2Nodes6PPID
10	16	8	PMD2016	    12/14/2015 4:05:03 PM	55	12236	upmd2016	1	<- 　2Nodes6PPID  = 76 rows
'

$hhs='15' ;$hhm='09';$opt=$hhs+':'+$hhm+':00' ;sqlviewbyTime $opt
waitrun $hhs $hhm
for ($i = 0; $i -lt 3; $i++){ 
 icm -ComputerName sql2014x              -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
 icm -ComputerName pmd2016  -Credential $h2credential { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
 #start-process powershell  -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }
 Start-Job -ScriptBlock { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }
}
sqlviewbyTime $opt




10	27	6	SQL2014X	12/14/2015 4:33:32 PM	53	3292	usql2014x	2	
10	17	5	PMD2016	    12/14/2015 4:33:32 PM	55	12212	upmd2016	1	
10	20	6	SP2013	    12/14/2015 4:33:32 PM	54	6088	usp2013	    2	
10	16	6	SP2013	    12/14/2015 4:33:24 PM	57	6552	usp2013	    1	
10	18	11	PMD2016	    12/14/2015 4:33:24 PM	59	3696	upmd2016	1	
10	15	10	PMD2016	    12/14/2015 4:33:24 PM	58	7796	upmd2016	1	
10	16	9	SP2013	    12/14/2015 4:33:24 PM	56	8924	usp2013	    1	
10	24	8	SQL2014X	12/14/2015 4:33:24 PM	55	2616	usql2014x	2	
10	22	4	SQL2014X	12/14/2015 4:33:14 PM	53	3204	usql2014x	2	 = 183 Row / 20



get-job | remove-job ; get-job ; GetSQLallSID

sqlview
GetSQLallSID
#---------------------------------------------------------------
#     1677_2396      scenario 4   
#---------------------------------------------------------------

sqlview

KillSID 54 ;GetSQLallSID  



# 1 Powersehll_ise :@TSQL005Trigger execute 
    . C:\PerfLogs\TSQL005.ps1  $pTServerInstance $pGServerInstance $pTdatabase $pGdatabase $ptsec
# 2 Powersehll_ise :@TSQL005 execute 
      TSQL005  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 
# 3 powersehll  execute   . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 30








#---------------------------------------------------------------
#     1677_2551     scenario 5   實際開始寫入時間
#---------------------------------------------------------------
  
# 單一 pmd2016  : local call function  (in powershell_ise)

#5.1.1 
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell_ise |stop-process -force ; }
#5.1.2 @run powershell 
Start-Process powershell_ise  -Verb runas -ArgumentList { "C:\PerfLogs\TSQL005.ps1 , C:\PerfLogs\TSQL005Trigger.ps1"  }  #  @run powershell 
#5.1.3
$hhs='09' ;$hhm='20';$opt=$hhs+':'+$hhm+':00' ;sqlviewbyTime $opt 2015-12-15
waitrun $hhs $hhm
waitrun $hhs $hhm ;. C:\PerfLogs\TSQL005.ps1  $pTServerInstance $pGServerInstance $pTdatabase $pGdatabase $ptsec
 icm -ComputerName sql2014x              -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
 #icm -ComputerName pmd2016  -Credential $h2credential { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
 #start-process powershell  -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }
 #Start-Job -ScriptBlock { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }
sqlviewbyTime $opt 2015-12-15
$hhs='09' ;$hhm='28';$opt=$hhs+':'+$hhm+':00' ; sqlviewbyTime $opt 2015-12-15

'run one
upmd2016	4620	53	12/15/2015 9:28:10 AM	12/15/2015 9:28:00 AM	53	9	<-- third   09:28:00
upmd2016	4620	53	12/15/2015 9:25:10 AM	12/15/2015 9:20:07 AM	71	3	<-- second  09:25:00
upmd2016	4620	53	12/15/2015 9:20:10 AM	12/15/2015 9:20:07 AM	18	3	<-- first   09:20:00
'

GetSQLallSID   (此為同一執行緒 PPID: 13032 , SSID:51)
$hhs='09' ;$hhm='40';$opt=$hhs+':'+$hhm+':00' ; sqlviewbyTime $opt 2015-12-15
$hhs='09' ;$hhm='43';$opt=$hhs+':'+$hhm+':00' ; sqlviewbyTime $opt 2015-12-15
$hhs='09' ;$hhm='46';$opt=$hhs+':'+$hhm+':00' ; sqlviewbyTime $opt 2015-12-15
'run  Two 
upmd2016	13032	51	12/15/2015 9:50:10 AM	12/15/2015 9:50:00 AM	57	9	<-- 4rd     
upmd2016	13032	51	12/15/2015 9:46:10 AM	12/15/2015 9:46:00 AM	58	9	<-- third   09:46:00　看起來是　都吃飽　10sec
upmd2016	13032	51	12/15/2015 9:43:10 AM	12/15/2015 9:43:00 AM	54	10	<-- second  09:43:00 
upmd2016	13032	51	12/15/2015 9:40:10 AM	12/15/2015 9:40:07 AM	20	3	<-- first   09:40:00 只有3sec 在執行.其餘是Powershell 執行時間

'
$hhs='09' ;$hhm='50';$opt=$hhs+':'+$hhm+':00' ; sqlviewbyTime $opt 2015-12-15
KillSID 54 ;GetSQLallSID  


# 單一 pmd2016  : local   call ps1  (run  powershell)
#5.2.1 
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell_ise |stop-process -force ; }
#5.2.2  如何讓Local定時自發執行不同PPID . (1) sp2013 remote call :不符此目的
                                      (2) taskschd 比較可行. 可以也需考量 taskschd.msc 執行上手時間
 

              ## 轉至   
              \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_04_Lab.ps1


 . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10

#5.2.3
GetSQLallSID  




# 單一 pmd2016  : remote   call ps1  (run  powershell)
#5.3.1 icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell_ise |stop-process -force ; }
#5.3.2 Start-Process powershell_ise  -Verb runas -ArgumentList { "C:\PerfLogs\TSQL005.ps1 , C:\PerfLogs\TSQL005Trigger.ps1"  }  #  @run powershell 
#5.3.3

icm -ComputerName sql2014x              -ScriptBlock { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
 #icm -ComputerName pmd2016  -Credential $h2credential { . C:\PerfLogs\TSQL005.ps1  PMD2016 PMD2016 SQL_inventory SQL_inventory 10 } -AsJob
 #start-process powershell  -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }
 #Start-Job -ScriptBlock { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }
sqlviewbyTime $opt 2015-12-15

#---------------------------------------------------------------
#     1677_xxx      scenario 6   
#---------------------------------------------------------------

\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_04_Lab.ps1



#-----------------------------------------
create database admin
go
use admin
go
#-----------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
USE [admin]
GO
/****** Object: Table [dbo].[AWEAllocated] Script Date: 08/21/2008 11:47:19 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[AWEAllocated]’) AND type in (N’U’))
DROP TABLE [dbo].[AWEAllocated]
GO
CREATE TABLE [dbo].[AWEAllocated](
[AWE allocated, Mb] [bigint] NULL,
[servername] [sysname] NULL,
[datestamp] [datetime] NULL
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[LogFileUsage] Script Date: 08/21/2008 11:47:49 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[LogFileUsage]’) AND type in (N’U’))
DROP TABLE [dbo].[LogFileUsage]
GO
CREATE TABLE [dbo].[LogFileUsage](
[servername] [nvarchar](128) NULL,
[instance_name] [nchar](128) NULL,
[Log File(s) Used Size (KB)] [bigint] NOT NULL,
[datestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[TopQueries] Script Date: 08/21/2008 12:24:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[TopQueries]’) AND type in (N’U’))
DROP TABLE [dbo].[TopQueries]
GO
CREATE TABLE [dbo].[TopQueries](
[Servername] [nvarchar](128) NULL,
[creation_time] [datetime] NOT NULL,
[last_execution_time] [datetime] NOT NULL,
[row_no] [bigint] NULL,
[l1] [bigint] NULL,
[total_worker_time] [numeric](26, 6) NULL,
[AvgCPUTime] [numeric](38, 18) NULL,
[LogicalReads] [bigint] NOT NULL,
[LogicalWrites] [bigint] NOT NULL,
[execution_count] [bigint] NOT NULL,
[AggIO] [bigint] NULL,
[AvgIO] [numeric](38, 18) NULL,
[query_text] [nvarchar](max) NULL,
[db_name] [nvarchar](128) NULL,
[object_id] [int] NULL,
[datestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[TaskCount] Script Date: 08/21/2008 11:48:02 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[TaskCount]’) AND type in (N’U’))
DROP TABLE [dbo].[TaskCount]
GO
CREATE TABLE [dbo].[TaskCount](
[scheduler_id] [int] NOT NULL,
[current_tasks_count] [int] NOT NULL,
[runnable_tasks_count] [int] NOT NULL,
[servername] [sysname] NULL,
[datestamp] [datetime] NULL
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[TopMemConsumption] Script Date: 08/21/2008
11:48:15 ******/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[TopMemConsumption]’) AND type in (N’U’))
DROP TABLE [dbo].[TopMemConsumption]
GO
CREATE TABLE [dbo].[TopMemConsumption](
[servername] [nvarchar](128) NULL,
[type] [nvarchar](60) NOT NULL,
[SPA Mem, Kb] [bigint] NULL,
[datestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO

#-----------------------------------------
USE [admin]
GO
/****** Object: StoredProcedure [dbo].[uspCollectPerfData] Script Date: 08/21/2008
11:53:23 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[uspCollectPerfData]’) AND type in (N’P’, N’PC’))
DROP PROCEDURE [dbo].[uspCollectPerfData]
GO

CREATE PROCEDURE uspCollectPerfData as
set nocount on
INSERT INTO TaskCount (servername,scheduler_id,current_tasks_count,runnable_tasks_count,datestamp )
SELECT @@SERVERNAME, scheduler_id,current_tasks_count,runnable_tasks_count, GETDATE()
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255


INSERT INTO AWEAllocated (servername, [AWE allocated, Mb],datestamp )
SELECT @@SERVERNAME, SUM(awe_allocated_kb) / 1024 as [AWE allocated, Mb], GETDATE()
FROM sys.dm_os_memory_clerks

INSERT INTO LogFileUsage (servername,instance_name,[Log File(s) Used Size (KB)],datestamp)
SELECT @@SERVERNAME,instance_name,cntr_value ‘Log File(s) Used Size (KB)’, GETDATE()
FROM sys.dm_os_performance_counters
WHERE counter_name = ‘Log File(s) Used Size (KB)’
order by instance_name desc

INSERT INTO TopMemConsumption (servername, type,[SPA Mem, Kb] ,datestamp)
SELECT TOP 10 @@SERVERNAME,
type, SUM(single_pages_kb) as [SPA Mem, Kb], GETDATE()
FROM sys.dm_os_memory_clerks
GROUP BY type
ORDER BY SUM(single_pages_kb) DESC

INSERT INTO TopQueries (
Servername,creation_time,
last_execution_time,
row_no,
l1,
total_worker_time,
AvgCPUTime,
LogicalReads,
LogicalWrites,
execution_count,
AggIO,
AvgIO,
query_text,
db_name ,
object_id ,
datestamp)

select Top 10 @@SERVERNAME,
creation_time, last_execution_time
,rank() over(order by (total_worker_time+0.0)/execution_count desc
,sql_handle,statement_start_offset ) as row_no
,(rank() over(order by (total_worker_time+0.0)/execution_count desc
,sql_handle,statement_start_offset ))%2 as l1
, (total_worker_time+0.0)/1000 as total_worker_time
, (total_worker_time+0.0)/(execution_count*1000) as [AvgCPUTime]
, total_logical_reads as [LogicalReads]
, total_logical_writes as [LogicalWrites]
, execution_count
, total_logical_reads+total_logical_writes as [AggIO]
, (total_logical_reads+total_logical_writes)/ (execution_count+0.0) as [AvgIO]
, case when sql_handle IS NULL
then ‘ ‘
else ( substring(st.text,(qs.statement_start_offset+2)/2,
(case when qs.statement_end_offset = -1
then len(convert(nvarchar(MAX),st.text))*2
else qs.statement_end_offset
end - qs.statement_start_offset) /2 ) )
end as query_text
, db_name(st.dbid) as db_name
, st.objectid as object_id,
GETDATE()
from sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(sql_handle) st
where total_worker_time > 0
order by (total_worker_time+0.0)/(execution_count*1000)
GO

#-----------------------------------------
param (
[string] $serverName
)
. C:\DBAScripts\dbaLib.ps1
if ( $serverName.Length -eq 0 ) {
"Please enter a server name."
exit 1
}
Invoke-Sqlcmd -Query "exec dbo.[uspCollectPerfData]" -ServerInstance $serverName
-Database "admin"

C:\DBAScripts\Collect-SQLPerfmonData.ps1 "PowerServer3"
#-----------------------------------------


Use admin
go
select * from dbo.AWEAllocated
select * from dbo.LogFileUsage
select * from dbo.TaskCount
select * from dbo.TopMemConsumption
select ServerName, Query_text, * from dbo.TopQueries
#---------------------------------------------------------------
# 99  SQL Server Host Performance Data Collection
#---------------------------------------------------------------
❑ PerfDisk_PhysicalDisk: Stores data related to physical disk information
❑ PerfRawData_PerfOS_Memory: Stores information related to memory usage
❑ PerfRawData_PerfOS_Processor: Stores information about the processor
❑ PerfRawData_PerfProc_Process: Stores information about processes
❑ PerfRawData_Tcpip_NetworkInterface: Stores information about the network

#---------------------------------------------------------------

USE [master]
GO
/****** Object: Database [PerfMon_DB] Script Date: 08/23/2008 03:09:13 ******/
IF EXISTS (SELECT name FROM sys.databases WHERE name = N’PerfMon_DB’)
DROP DATABASE [PerfMon_DB]
GO
CREATE DATABASE PerfMon_DB
Go
#---------------------------------------------------------------

USE [PerfMon_DB]
GO
/****** Object: Table [dbo].[PerfDisk_PhysicalDisk] Script Date: 08/23/2008
03:29:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[PerfDisk_PhysicalDisk]’) AND type in (N’U’))
DROP TABLE [dbo].[PerfDisk_PhysicalDisk]
GO
CREATE TABLE PerfDisk_PhysicalDisk(
Hostname varchar(100) NULL ,
___GENUS int NULL ,
___CLASS varchar(100) NULL ,
___SUPERCLASS varchar(100) NULL ,
___DYNASTY varchar(100) NULL ,
___RELPATH varchar(100) NULL ,
___PROPERTY_COUNT int NULL ,
___DERIVATION varchar(100) NULL ,
___SERVER varchar(100) NULL ,
___NAMESPACE varchar(100) NULL ,
___PATH varchar(100) NULL ,
AvgDiskBytesPerRead bigint NULL ,
AvgDiskBytesPerRead_Base bigint NULL ,
AvgDiskBytesPerTransfer bigint NULL ,
AvgDiskBytesPerTransfer_Base bigint NULL ,
AvgDiskBytesPerWrite bigint NULL ,
AvgDiskBytesPerWrite_Base bigint NULL ,
AvgDiskQueueLength bigint NULL ,
AvgDiskReadQueueLength bigint NULL ,
AvgDisksecPerRead bigint NULL ,
AvgDisksecPerRead_Base bigint NULL ,
AvgDisksecPerTransfer bigint NULL ,
AvgDisksecPerTransfer_Base bigint NULL ,
AvgDisksecPerWrite bigint NULL ,
AvgDisksecPerWrite_Base bigint NULL ,
AvgDiskWriteQueueLength bigint NULL ,
Caption varchar(100) NULL ,
CurrentDiskQueueLength bigint NULL ,
Description varchar(100) NULL ,
DiskBytesPersec bigint NULL ,
DiskReadBytesPersec bigint NULL ,
DiskReadsPersec bigint NULL ,
DiskTransfersPersec bigint NULL ,
DiskWriteBytesPersec bigint NULL ,
DiskWritesPersec bigint NULL ,
Frequency_Object bigint NULL ,
Frequency_PerfTime bigint NULL ,
Frequency_Sys100NS bigint NULL ,
Name varchar(100) NULL ,
PercentDiskReadTime bigint NULL ,
PercentDiskTime bigint NULL ,
PercentDiskWriteTime bigint NULL ,
PercentIdleTime bigint NULL ,
SplitIOPerSec bigint NULL ,
Timestamp_Object bigint NULL ,
Timestamp_PerfTime bigint NULL ,
Timestamp_Sys100NS bigint NULL ,
datestamp datetime default getdate())

/****** Object: Table [dbo].[PerfRawData_PerfOS_Memory] Script Date: 08/23/2008
03:29:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[PerfRawData_PerfOS_Memory]’) AND type in (N’U’))
DROP TABLE [dbo].PerfRawData_PerfOS_Memory
GO

CREATE TABLE PerfRawData_PerfOS_Memory(
Hostname varchar(100) NULL ,
___GENUS bigint NULL ,
___CLASS varchar(100) NULL ,
___SUPERCLASS varchar(100) NULL ,
___DYNASTY varchar(100) NULL ,
___RELPATH varchar(100) NULL ,
___PROPERTY_COUNT bigint NULL ,
___DERIVATION varchar(100) NULL ,
___SERVER varchar(100) NULL ,
___NAMESPACE varchar(100) NULL ,
___PATH varchar(100) NULL ,
AvailableBytes bigint NULL ,
AvailableKBytes bigint NULL ,
AvailableMBytes bigint NULL ,
CacheBytes bigint NULL ,
CacheBytesPeak bigint NULL ,
CacheFaultsPersec bigint NULL ,
Caption varchar(100) NULL ,
CommitLimit bigint NULL ,
CommittedBytes bigint NULL ,
DemandZeroFaultsPersec bigint NULL ,
Description varchar(100) NULL ,
FreeAndZeroPageListBytes bigint NULL ,
FreeSystemPageTableEntries bigint NULL ,
Frequency_Object bigint NULL ,
Frequency_PerfTime bigint NULL ,
Frequency_Sys100NS bigint NULL ,
ModifiedPageListBytes bigint NULL ,
Name varchar(100) NULL ,
PageFaultsPersec bigint NULL ,
PageReadsPersec bigint NULL ,
PagesInputPersec bigint NULL ,
PagesOutputPersec bigint NULL ,
PagesPersec bigint NULL ,
PageWritesPersec bigint NULL ,
PercentCommittedBytesInUse bigint NULL ,
PercentCommittedBytesInUse_Base bigint NULL ,
PoolNonpagedAllocs bigint NULL ,
PoolNonpagedBytes bigint NULL ,
PoolPagedAllocs bigint NULL ,
PoolPagedBytes bigint NULL ,
PoolPagedResidentBytes bigint NULL ,
StandbyCacheCoreBytes bigint NULL ,
StandbyCacheNormalPriorityBytes bigint NULL ,
StandbyCacheReserveBytes bigint NULL ,
SystemCacheResidentBytes bigint NULL ,
SystemCodeResidentBytes bigint NULL ,
SystemCodeTotalBytes bigint NULL ,
SystemDriverResidentBytes bigint NULL ,
SystemDriverTotalBytes bigint NULL ,
Timestamp_Object bigint NULL ,
Timestamp_PerfTime bigint NULL ,
Timestamp_Sys100NS bigint NULL ,
TransitionFaultsPersec bigint NULL ,
TransitionPagesRePurposedPersec bigint NULL ,
WriteCopiesPersec bigint NULL ,
datestamp datetime default getdate())

/****** Object: Table [dbo].[PerfRawData_PerfOS_Processor] Script Date: 08/23/2008
03:29:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[PerfRawData_PerfOS_Processor]’) AND type in (N’U’))
DROP TABLE [dbo].PerfRawData_PerfOS_Processor
GO
CREATE TABLE PerfRawData_PerfOS_Processor(
Hostname varchar(100) NULL ,
___GENUS bigint NULL ,
___CLASS varchar(100) NULL ,
___SUPERCLASS varchar(100) NULL ,
___DYNASTY varchar(100) NULL ,
___RELPATH varchar(100) NULL ,
___PROPERTY_COUNT bigint NULL ,
___DERIVATION varchar(100) NULL ,
___SERVER varchar(100) NULL ,
___NAMESPACE varchar(100) NULL ,
___PATH varchar(100) NULL ,
C1TransitionsPersec bigint NULL ,
C2TransitionsPersec bigint NULL ,
C3TransitionsPersec bigint NULL ,
Caption varchar(100) NULL ,
Description varchar(100) NULL ,
DPCRate bigint NULL ,
DPCsQueuedPersec bigint NULL ,
Frequency_Object bigint NULL ,
Frequency_PerfTime bigint NULL ,
Frequency_Sys100NS bigint NULL ,
InterruptsPersec bigint NULL ,
Name varchar(100) NULL ,
PercentC1Time bigint NULL ,
PercentC2Time bigint NULL ,
PercentC3Time bigint NULL ,
PercentDPCTime bigint NULL ,
PercentIdleTime bigint NULL ,
PercentInterruptTime bigint NULL ,
PercentPrivilegedTime bigint NULL ,
PercentProcessorTime bigint NULL ,
PercentUserTime bigint NULL ,
Timestamp_Object bigint NULL ,
Timestamp_PerfTime bigint NULL ,
Timestamp_Sys100NS bigint NULL ,
datestamp datetime default getdate())

/****** Object: Table [dbo].[PerfRawData_PerfProc_Process] Script Date: 08/23/2008
03:29:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[PerfRawData_PerfProc_Process]’) AND type in (N’U’))
DROP TABLE [dbo].PerfRawData_PerfProc_Process
GO
CREATE TABLE PerfRawData_PerfProc_Process(
Hostname varchar(100) NULL ,
___GENUS bigint NULL ,
___CLASS varchar(100) NULL ,
___SUPERCLASS varchar(100) NULL ,
___DYNASTY varchar(100) NULL ,
___RELPATH varchar(100) NULL ,
___PROPERTY_COUNT bigint NULL ,
___DERIVATION varchar(100) NULL ,
___SERVER varchar(100) NULL ,
___NAMESPACE varchar(100) NULL ,
___PATH varchar(100) NULL ,
Caption varchar(100) NULL ,
CreatingProcessID bigint NULL ,
Description varchar(100) NULL ,
ElapsedTime bigint NULL ,
Frequency_Object bigint NULL ,
Frequency_PerfTime bigint NULL ,
Frequency_Sys100NS bigint NULL ,
HandleCount bigint NULL ,
IDProcess bigint NULL ,
IODataBytesPersec bigint NULL ,
IODataOperationsPersec bigint NULL ,
IOOtherBytesPersec bigint NULL ,
IOOtherOperationsPersec bigint NULL ,
IOReadBytesPersec bigint NULL ,
IOReadOperationsPersec bigint NULL ,
IOWriteBytesPersec bigint NULL ,
IOWriteOperationsPersec bigint NULL ,
Name varchar(100) NULL ,
PageFaultsPersec bigint NULL ,
PageFileBytes bigint NULL ,
PageFileBytesPeak bigint NULL ,
PercentPrivilegedTime bigint NULL ,
PercentProcessorTime bigint NULL ,
PercentUserTime bigint NULL ,
PoolNonpagedBytes bigint NULL ,
PoolPagedBytes bigint NULL ,
PriorityBase bigint NULL ,
PrivateBytes bigint NULL ,
ThreadCount bigint NULL ,
Timestamp_Object bigint NULL ,
Timestamp_PerfTime bigint NULL ,
Timestamp_Sys100NS bigint NULL ,
VirtualBytes bigint NULL ,
VirtualBytesPeak bigint NULL ,
WorkingSet bigint NULL ,
WorkingSetPeak bigint NULL ,
WorkingSetPrivate bigint NULL ,
datestamp datetime default getdate())


/****** Object: Table [dbo].[PerfRawData_Tcpip_NetworkInterface]
Script Date: 08/23/2008 03:29:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].
[PerfRawData_Tcpip_NetworkInterface]’) AND type in (N’U’))
DROP TABLE [dbo].PerfRawData_Tcpip_NetworkInterface
GO
CREATE TABLE PerfRawData_Tcpip_NetworkInterface(
Hostname varchar(100) NULL ,
___GENUS bigint NULL ,
___CLASS varchar(100) NULL ,
___SUPERCLASS varchar(100) NULL ,
___DYNASTY varchar(100) NULL ,
___RELPATH varchar(300) NULL ,
___PROPERTY_COUNT bigint NULL ,
___DERIVATION varchar(100) NULL ,
___SERVER varchar(100) NULL ,
___NAMESPACE varchar(100) NULL ,
___PATH varchar(300) NULL ,
BytesReceivedPersec bigint NULL ,
BytesSentPersec bigint NULL ,
BytesTotalPersec bigint NULL ,
Caption varchar(100) NULL ,
CurrentBandwidth bigint NULL ,
Description varchar(100) NULL ,
Frequency_Object bigint NULL ,
Frequency_PerfTime bigint NULL ,
Frequency_Sys100NS bigint NULL ,
Name varchar(100) NULL ,
OutputQueueLength bigint NULL ,
PacketsOutboundDiscarded bigint NULL ,
PacketsOutboundErrors bigint NULL ,
PacketsPersec bigint NULL ,
PacketsReceivedDiscarded bigint NULL ,
PacketsReceivedErrors bigint NULL ,
PacketsReceivedNonUnicastPersec bigint NULL ,
PacketsReceivedPersec bigint NULL ,
PacketsReceivedUnicastPersec bigint NULL ,
PacketsReceivedUnknown bigint NULL ,
PacketsSentNonUnicastPersec bigint NULL ,
PacketsSentPersec bigint NULL ,
PacketsSentUnicastPersec bigint NULL ,
Timestamp_Object bigint NULL ,
Timestamp_PerfTime bigint NULL ,
Timestamp_Sys100NS bigint NULL ,
datestamp datetime default getdate())







#---------------------------------------------------------------






#---------------------------------------------------------------





#---------------------------------------------------------------
#   Temp
#---------------------------------------------------------------




#---------------------------------------------------------------
#   sys.dm_exec_query_stats
#---------------------------------------------------------------