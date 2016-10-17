<#

\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_03_listall.ps1
C:\Users\administrator.CSD\OneDrive\download\PS1
ebook: 
\\172.16.220.33\d$\mydata\ebook\SQL2012\sql_server_dmvs_in_action.pdf
C:\Users\administrator.CSD\OneDrive\公用Public\SQL\03.sql_server_dmvs_in_action.pdf

                                                   07.eBook_Performance_Tuning_Davidson_Ford.pdf        

set statistics time off


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_03_listall.ps1

foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname=$ps1f.name
    $ps1fFullname=$ps1f.FullName 
    $ps1flastwritetime=$ps1f.LastWriteTime
    $getdagte= get-date -format yyyyMMdd
    $ps1length=$ps1f.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length "  -Body "  ps1source from:me $ps1fname   " 
}

set statistics time off
WAITFOR DELAY '00:00:$(Sec)'
#>

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
# 781  Listing 3.9 What is the state of your statistics? p.88
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
# 2304 Listing 8.4 Selecting data from a table that has an open transaction against it p.200
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
# 3040  Listing 9.13 Indexes with the most page I/O-latch contention p.250 
# 3066  Listing 9.14 Indexes under the most row-locking pressure—snapshot version p.251
# 3161 Listing 9.15 Determining how many rows are inserted/deleted/updated/selected  p.254
# 3278  Listing 10.1 CLR function to extract the routine name p.160
# 3330 Listing 10.2 Recompile routines that are running slower than normal p.262 
# 3435  Listing 10.3   Rebuilding and reorganizing fragmented indexes
# 3494 Listing 10.4 Rebuild/reorganize for all databases on a given server  p.268 
# 3556 Listing 10.5 Intelligently update statistics—simple version p.270 
# 3615 Listing 10.6 Intelligently update statistics—time-based version p.273
# 3770 Listing 10.7 Update statistics used by a SQL routine or a time interval p.277
# 3877 Listing 10.8 Automatically create any missing indexes
# 3936 Listing 10.9 Automatically disable or drop unused indexesp.283 
# 4009  Listing 11.1 Finding everyone’s last-run query p.287 
# 4027 Listing 11.2 Generic performance test harness p.289 
# 4082 Listing 11.3 Determining the performance impact of a system upgrade p.291
# 4236 Estimating the finishing time of system jobs
# 4219 Listing 11.4 Estimating when a job will finish p.295
# 4247 11.5 Get system information from within SQL Server p.297 
# 4265 11.6 Viewing enabled Enterprise features (2008 only) p.298
# 4315  Listing 11.5 Who’s doing what and when?  p.299
# 4373  11.8.1 Locating where your queries are spending their time  p.301
# 4435  Listing 11.7 Memory used per database  p.304
# 4455 11.10.1 Determining the memory used by tables and indexes p.305
# 4482  Listing 11.9 I/O stalls at the database level p.308 
# 4504  Listing 11.10 I/O stalls at the file level p.309
# 4526  Listing 11.11 Average read/write times per file, per database p.311 
# 4545 Listing 11.12 Simple trace utility  p.312
# 4603 11.13 Some best practices p.314




















#----------------------------------------------------
# 15  Listing 1.1 A simple monitor
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
WAITFOR TIME '19:00:00'
GO
PRINT GETDATE()
EXEC master.dbo.dba_BlockTracer
IF @@ROWCOUNT > 0
BEGIN
SELECT GETDATE() AS TIME
EXEC master.dbo.dba_WhatSQLIsExecuting
END
WAITFOR DELAY '00:00:15'
GO 500
#>}
#----------------------------------------------------
# 32  Listing 1.2 Find your slowest queries
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST(qs.total_elapsed_time / 1000000.0 AS DECIMAL(28, 2))
AS [Total Elapsed Duration (s)]
, qs.execution_count
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
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_elapsed_time DESC
#>}
#----------------------------------------------------
#   55  Listing 1.3 Find those missing indexes  p.16
#----------------------------------------------------
{<#
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
The DMV sys.dm_db_missing_
#>}
#----------------------------------------------------
# 76  Listing 1.4 Identify what SQL is running now p.17
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
er.session_Id AS [Spid]
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
Listing 1.4 Identify what SQL is running now
Extract SQL
statement
B
www.it-ebooks.info
18 CHAPTER 1 The Dynamic Management Views gold mine
FROM sys.dm_exec_requests er
INNER JOIN sys.sysprocesses sp ON er.session_id = sp.spid
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle)as qt
WHERE session_Id > 50
AND session_Id NOT IN (@@SPID)
ORDER BY session_Id, ecid


#>}
#----------------------------------------------------
#  113   Listing 1.5 Quickly find a cached plan  p.19
#----------------------------------------------------
{<#
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
AND st.text LIKE '%CREATE PROCEDURE%'  --Text to search plan for


#>}

#----------------------------------------------------
# 137  Listing 1.6 Missing index details
#----------------------------------------------------









#----------------------------------------------------
#  149  Listing 2.1 Restricting output to a given database  p.33
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT SUM(qs.total_logical_reads) AS [Total Reads]
, SUM(qs.total_logical_writes) AS [Total Writes]
, DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
WHERE DB_NAME(qt.dbid) = 'ParisDev'  --Specify database here
GROUP BY DB_NAME(qt.dbid)

#>}
#----------------------------------------------------
#  164  Listing 2.2 Top 10 longest-running queries on server p.33
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 10
qs.total_elapsed_time AS [Total Time]
, qs.execution_count AS [Execution count]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE
Listing 2.1 Restricting output to a given database
Listing 2.2 Top 10 longest-running queries on server
Specify
database here
Number of rows
B to report on
qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY [Total Time] DESC;
You can hardcode the number of





#>}
#----------------------------------------------------
# 199  Listing 2.3 Creating a temporary table WHERE 1 = 2
#----------------------------------------------------
{<#
SELECT f.FactorId, f.FactorName, pf.PositionId
INTO #Temp01
FROM dbo.Factor f
INNER JOIN dbo.PositionFactor pf ON pf.FactorId = f.FactorId
WHERE 1 = 2

#>}
#----------------------------------------------------
#  210  Listing 2.4 Looping over all databases on a server pattern
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_seeks + s.user_scans + s.user_lookups) AS [Usage]
, s.user_updates
, i.fill_factor
INTO #TempUsage
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE 1=2
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempUsage
SELECT TOP 10
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_seeks + s.user_scans + s.user_lookups) AS [Usage]
, s.user_updates
, i.fill_factor
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE s.database_id = DB_ID()
AND i.name IS NOT NULL
AND OBJECTPROPERTY(s.[object_id], ''IsMsShipped'') = 0
ORDER BY [Usage] DESC'  --Identify most-used indexes
SELECT TOP 10 * FROM #TempUsage ORDER BY [Usage] DESC
DROP TABLE #TempUsage



#>}
#----------------------------------------------------
#  253  Listing 2.5 Quickly find the most-used cached plans—simple version  p.37
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 10
st.text AS [SQL]
, DB_NAME(st.dbid) AS DatabaseName
, cp.usecounts AS [Plan usage]
, qp.query_plan
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st

CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
WHERE st.text LIKE '%CREATE PROCEDURE%'
ORDER BY cp.usecounts DESC


#>}
#----------------------------------------------------
#   273  Listing 2.6 Extracting the Individual Query from the Parent Query
#----------------------------------------------------
{<#

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




#>}
#----------------------------------------------------
#   296  Listing 2.7 Identify the database of ad hoc queries and stored procedures p.40
#----------------------------------------------------
{<#
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
ORDER BY cp.usecounts DESC;




#>}
#----------------------------------------------------
#  321  Listing 2.8 Determine query effect via differential between snapshots
#----------------------------------------------------
{<#

--Get pre-work snapshot
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT sql_handle, plan_handle, total_elapsed_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkSnapShot
FROM sys.dm_exec_query_stats

--Run queries
EXEC dbo.IWSR
SELECT * FROM dbo.appdate


--Get post-work snapshot
SELECT sql_handle, plan_handle, total_elapsed_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkSnapShot
FROM sys.dm_exec_query_stats

--Extract delta

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
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
ORDER BY [Duration] DESC
DROP TABLE #PreWorkSnapShot
DROP TABLE #PostWorkSnapShot



#>}
#----------------------------------------------------
#  373  Listing 2.9 Example of building dynamic SQL  p.47
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME
INTO #TableDetails
FROM INFORMATION_SCHEMA.tables
WHERE TABLE_TYPE = 'BASE TABLE'
DECLARE @DynamicSQL NVARCHAR(MAX)
SET @DynamicSQL = ''
SELECT
@DynamicSQL = @DynamicSQL + CHAR(10)
+ ' SELECT COUNT_BIG(*) as [TableName: '
+ TABLE_CATALOG + '.' + TABLE_SCHEMA + '. ' + TABLE_NAME
+ + '] FROM ' + QUOTENAME(TABLE_CATALOG) + '.'
+ QUOTENAME(TABLE_SCHEMA) + '. ' + QUOTENAME(TABLE_NAME)
FROM #TableDetails
EXECUTE sp_executesql @DynamicSQL
DROP TABLE #TableDetails



#>}
#----------------------------------------------------
#  398  Listing 2.10 Example of printing the content of large variables p.48
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME
INTO #TableDetails
FROM INFORMATION_SCHEMA.tables
WHERE TABLE_TYPE = 'BASE TABLE'


DECLARE @DynamicSQL NVARCHAR(MAX)
SET @DynamicSQL = ''
SELECT
@DynamicSQL = @DynamicSQL + CHAR(10)
+ ' SELECT COUNT_BIG(*) as [TableName: '
+ TABLE_CATALOG + '.' + TABLE_SCHEMA + '. ' + TABLE_NAME
+ + '] FROM ' + QUOTENAME(TABLE_CATALOG) + '.'
+ QUOTENAME(TABLE_SCHEMA) + '. ' + QUOTENAME(TABLE_NAME)
FROM #TableDetails
--EXECUTE sp_executesql @DynamicSQL

DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@DynamicSQL))
BEGIN
PRINT SUBSTRING(@DynamicSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@DynamicSQL, @StartOffset, @Length)
DROP TABLE #TableDetails



#>}
#----------------------------------------------------
#  437  Listing 3.1 Identifying the most important missing indexes p.62
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
ROUND(s.avg_total_user_cost *
s.avg_user_impact
* (s.user_seeks + s.user_scans),0)
AS [Total Cost]
, d.[statement] AS [Table Name]
, equality_columns
, inequality_columns
, included_columns
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle
INNER JOIN sys.dm_db_missing_index_details d
ON d.index_handle = g.index_handle
ORDER BY [Total Cost] DESC




#>}
#----------------------------------------------------
#  463  Listing 3.2 The most-costly unused indexes p.66
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, s.user_updates
, s.system_seeks + s.system_scans + s.system_lookups
AS [System usage]
INTO #TempUnusedIndexes
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE 1=2
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempUnusedIndexes
SELECT TOP 20
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, s.user_updates
, s.system_seeks + s.system_scans + s.system_lookups
AS [System usage]
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE s.database_id = DB_ID()
AND OBJECTPROPERTY(s.[object_id], ''IsMsShipped'') = 0
AND s.user_seeks = 0
AND s.user_scans = 0
AND s.user_lookups = 0
AND i.name IS NOT NULL
ORDER BY s.user_updates DESC'
SELECT TOP 20 * FROM #TempUnusedIndexes ORDER BY [user_updates] DESC
DROP TABLE #TempUnusedIndexes
Listing 3.2 The most-costly unused indexes
Temp table to
B hold results
Loop around
C all databases
Identify most-costly
unused indexes
D
www.


#>}
#----------------------------------------------------
#   518  Listing 3.3 The top high-maintenance indexes  p.70
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_updates ) AS [update usage]
, (s.user_seeks + s.user_scans + s.user_lookups)
AS [Retrieval usage]
, (s.user_updates) -
(s.user_seeks + s.user_scans + s.user_lookups) AS [Maintenance cost]
, s.system_seeks + s.system_scans + s.system_lookups AS [System usage]
, s.last_user_seek
, s.last_user_scan
, s.last_user_lookup
INTO #TempMaintenanceCost
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE 1=2
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempMaintenanceCost
SELECT TOP 20
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_updates ) AS [update usage]
, (s.user_seeks + s.user_scans + s.user_lookups)
AS [Retrieval usage]
, (s.user_updates) -
(s.user_seeks + user_scans +
s.user_lookups) AS [Maintenance cost]
, s.system_seeks + s.system_scans + s.system_lookups AS [System usage]
, s.last_user_seek
, s.last_user_scan
, s.last_user_lookup
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE s.database_id = DB_ID()
AND i.name IS NOT NULL
AND OBJECTPROPERTY(s.[object_id], ''IsMsShipped'') = 0
AND (s.user_seeks + s.user_scans + s.user_lookups) > 0
ORDER BY [Maintenance cost] DESC'
SELECT top 20 * FROM #TempMaintenanceCost ORDER BY [Maintenance cost] DESC
DROP TABLE #TempMaintenanceCost



#>}
#----------------------------------------------------
#   575  Listing 3.4 The most-used indexes  p.73
#----------------------------------------------------
{<#
SELECT
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_seeks + s.user_scans + s.user_lookups) AS [Usage]
, s.user_updates
, i.fill_factor
INTO #TempUsage
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE 1=2

EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempUsage
SELECT TOP 20
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, (s.user_seeks + s.user_scans + s.user_lookups) AS [Usage]
, s.user_updates
, i.fill_factor
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE s.database_id = DB_ID()
AND i.name IS NOT NULL
AND OBJECTPROPERTY(s.[object_id], ''IsMsShipped'') = 0
ORDER BY [Usage] DESC '


SELECT TOP 20 * FROM #TempUsage ORDER BY [Usage] DESC
DROP TABLE #TempUsage


#>}
#----------------------------------------------------
# 619  Listing 3.5 The most-fragmented indexes p.75
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME() AS DatbaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, ROUND(s.avg_fragmentation_in_percent,2) AS [Fragmentation %]
INTO #TempFragmentation
FROM sys.dm_db_index_physical_stats(db_id(),null, null, null, null) s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE 1=2
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempFragmentation
SELECT TOP 20
DB_NAME() AS DatbaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, ROUND(s.avg_fragmentation_in_percent,2) AS [Fragmentation %]
FROM sys.dm_db_index_physical_stats(db_id(),null, null, null, null) s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE s.database_id = DB_ID()
AND i.name IS NOT NULL
AND OBJECTPROPERTY(s.[object_id], ''IsMsShipped'') = 0
ORDER BY [Fragmentation %] DESC'
SELECT top 20 * FROM #TempFragmentation ORDER BY [Fragmentation %] DESC
DROP TABLE #TempFragmentation




#>}
#----------------------------------------------------
#  659  Listing 3.6 Identifying indexes used by a given routine p.78
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
SchemaName = ss.name
, TableName = st.name
, IndexName = ISNULL(si.name, '')
, IndexType = si.type_desc
, user_updates = ISNULL(ius.user_updates, 0)
, user_seeks = ISNULL(ius.user_seeks, 0)
, user_scans = ISNULL(ius.user_scans, 0)
, user_lookups = ISNULL(ius.user_lookups, 0)
, ssi.rowcnt
, ssi.rowmodctr
, si.fill_factor
INTO #IndexStatsPre
FROM sys.dm_db_index_usage_stats ius
SELECT
SchemaName = ss.name
, TableName = st.name
, IndexName = ISNULL(si.name, '')
, IndexType = si.type_desc
, user_updates = ISNULL(ius.user_updates, 0)
, user_seeks = ISNULL(ius.user_seeks, 0)
, user_scans = ISNULL(ius.user_scans, 0)
, user_lookups = ISNULL(ius.user_lookups, 0)
, ssi.rowcnt
, ssi.rowmodctr
, si.fill_factor
INTO #IndexStatsPost
FROM sys.dm_db_index_usage_stats ius
RIGHT OUTER JOIN sys.indexes si ON ius.[object_id] = si.[object_id]
AND ius.index_id = si.index_id
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE ius.database_id = DB_ID()
AND OBJECTPROPERTY(ius.[object_id], 'IsMsShipped') = 0
SELECT
DB_NAME() AS DatabaseName
, po.[SchemaName]
, po.[TableName]
, po.[IndexName]
, po.[IndexType]
, po.user_updates - ISNULL(pr.user_updates, 0) AS [User Updates]
, po.user_seeks - ISNULL(pr.user_seeks, 0) AS [User Seeks]
, po.user_scans - ISNULL(pr.user_scans, 0) AS [User Scans]
, po.user_lookups - ISNULL(pr.user_lookups , 0) AS [User Lookups]
, po.rowcnt - pr.rowcnt AS [Rows Inserted]
, po.rowmodctr - pr.rowmodctr AS [Updates I/U/D]
, po.fill_factor
FROM #IndexStatsPost po LEFT OUTER JOIN #IndexStatsPre pr
ON pr.SchemaName = po.SchemaName
AND pr.TableName = po.TableName
AND pr.IndexName = po.IndexName
AND pr.IndexType = po.IndexType
WHERE ISNULL(pr.user_updates, 0) != po.user_updates
OR ISNULL(pr.user_seeks, 0) != po.user_seeks
OR ISNULL(pr.user_scans, 0) != po.user_scans
OR ISNULL(pr.user_lookups, 0) != po.user_lookups
ORDER BY po.[SchemaName], po.[TableName], po.[IndexName];
DROP TABLE #IndexStatsPre
DROP TABLE #IndexStatsPost




#>}
#----------------------------------------------------
#   730  Listing 3.7 The databases with the most missing indexes p.84
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME(database_id) AS DatabaseName
, COUNT(*) AS [Missing Index Count]
FROM sys.dm_db_missing_index_details
GROUP BY DB_NAME(database_id)
ORDER BY [Missing Index Count] DESC



#>}
#----------------------------------------------------
#  746  Listing 3.8 Indexes that aren’t used at all p.85
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME() AS DatbaseName
, SCHEMA_NAME(O.Schema_ID) AS SchemaName
, OBJECT_NAME(I.object_id) AS TableName
, I.name AS IndexName
INTO #TempNeverUsedIndexes
FROM sys.indexes I INNER JOIN sys.objects O ON I.object_id = O.object_id
WHERE 1=2
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempNeverUsedIndexes
SELECT
DB_NAME() AS DatbaseName
, SCHEMA_NAME(O.Schema_ID) AS SchemaName
, OBJECT_NAME(I.object_id) AS TableName
, I.NAME AS IndexName
FROM sys.indexes I INNER JOIN sys.objects O ON I.object_id = O.object_id
LEFT OUTER JOIN sys.dm_db_index_usage_stats S ON S.object_id = I.object_id
AND I.index_id = S.index_id
AND DATABASE_ID = DB_ID()
WHERE OBJECTPROPERTY(O.object_id,''IsMsShipped'') = 0
AND I.name IS NOT NULL
AND S.object_id IS NULL'
SELECT * FROM #TempNeverUsedIndexes
ORDER BY DatbaseName, SchemaName, TableName, IndexName
DROP TABLE #TempNeverUsedIndexes




#>}
#----------------------------------------------------
#  781 Listing 3.9 What is the state of your statistics? p.88
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
ss.name AS SchemaName
, st.name AS TableName
, s.name AS IndexName
, STATS_DATE(s.id,s.indid) AS 'Statistics Last Updated'
, s.rowcnt AS 'Row Count'
, s.rowmodctr AS 'Number Of Changes'
, CAST((CAST(s.rowmodctr AS DECIMAL(28,8))/CAST(s.rowcnt AS
DECIMAL(28,2)) * 100.0)
AS DECIMAL(28,2)) AS '% Rows Changed'
FROM sys.sysindexes s
INNER JOIN sys.tables st ON st.[object_id] = s.[id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE s.id > 100
AND s.indid > 0
AND s.rowcnt >= 500
ORDER BY SchemaName, TableName, IndexName



#>}
#----------------------------------------------------
#  807 Listing 4.1 How to find a cached plan p.95
#----------------------------------------------------
{<#

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
AND st.text LIKE '%PartyType%'  -Text to search plan for


#>}
#----------------------------------------------------
#  831  Listing 4.2 Finding where a query is used  p.97
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1)
LIKE '%insert into dbo.deal%'  --Text to search plan for



#>}
#----------------------------------------------------
#  858  Listing 4.3 The queries that take the longest time to run p.99
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST(qs.total_elapsed_time / 1000000.0 AS DECIMAL(28, 2))
AS [Total Duration (s)]
, CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time
AS DECIMAL(28, 2)) AS [% CPU]
, CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 /
qs.total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting]
, qs.execution_count
, CAST(qs.total_elapsed_time / 1000000.0 / qs.execution_count
AS DECIMAL(28, 2)) AS [Average Duration (s)]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
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
ORDER BY qs.total_elapsed_time DESC



#>}
#----------------------------------------------------
#  890  Listing 4.4 The queries spend the longest time being blocked p.104
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST((qs.total_elapsed_time - qs.total_worker_time) /
1000000.0 AS DECIMAL(28,2)) AS [Total time blocked (s)]
, CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time
AS DECIMAL(28,2)) AS [% CPU]
, CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 /
qs.total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting]
, qs.execution_count
, CAST((qs.total_elapsed_time - qs.total_worker_time) / 1000000.0
/ qs.execution_count AS DECIMAL(28, 2)) AS [Blocking average (s)]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
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
ORDER BY [Total time blocked (s)] DESC



#>}
#----------------------------------------------------
# 922  Listing 4.5 The queries that use the most CPU p.106
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
CAST((qs.total_worker_time) / 1000000.0 AS DECIMAL(28,2))
AS [Total CPU time (s)]
, CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time
AS DECIMAL(28,2)) AS [% CPU]
, CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 /
qs.total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting]
, qs.execution_count
, CAST((qs.total_worker_time) / 1000000.0
/ qs.execution_count AS DECIMAL(28, 2)) AS [CPU time average (s)]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
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


#>}
#----------------------------------------------------
#   953  Listing 4.6 The queries that use the most I/O p.109
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
[Total IO] = (qs.total_logical_reads + qs.total_logical_writes)
, [Average IO] = (qs.total_logical_reads + qs.total_logical_writes) /
qs.execution_count
, qs.execution_count
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY [Total IO] DESC


#>}
#----------------------------------------------------
#  979 Listing 4.7 The queries that have been executed the most often p.112
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
qs.execution_count
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY qs.execution_count DESC;


#>}
#----------------------------------------------------
#  1001 Listing 4.8 Finding when a query was last run p.114
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT DISTINCT TOP 20
qs.last_execution_time
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
WHERE qt.text LIKE '%CREATE PROCEDURE%List%PickList%'
ORDER BY qs.last_execution_time DESC

#>}
#----------------------------------------------------
#  1017 Listing 4.9 Finding when a table was last inserted p.116
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
qs.last_execution_time
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
WHERE SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1)
LIKE '%INSERT INTO dbo.Underlying%'
ORDER BY qs.last_execution_time DESC

#>}
#----------------------------------------------------
#   1094 Listing 5.1 Finding queries with missing statistics p.120
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
st.text AS [Parent Query]
, DB_NAME(st.dbid)AS [DatabaseName]
, cp.usecounts AS [Usage Count]
, qp.query_plan
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
WHERE CAST(qp.query_plan AS NVARCHAR(MAX))
LIKE '%<ColumnsWithNoStatistics>%'
ORDER BY cp.usecounts DESC


#>}
#----------------------------------------------------
#  1113 Listing 5.2 Finding your default statistics options  p.123
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT name AS DatabaseName
, is_auto_create_stats_on AS AutoCreateStatistics
, is_auto_update_stats_on AS AutoUpdateStatistics
, is_auto_update_stats_async_on
AS AutoUpdateStatisticsAsync
FROM sys.databases
ORDER BY DatabaseName


#>}
#----------------------------------------------------
#  1128  Listing 5.3 Finding disparate columns with different data types p.125
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
COLUMN_NAME
,[%] = CONVERT(DECIMAL(12,2),COUNT(COLUMN_NAME)*
100.0 / COUNT(*)OVER())
INTO #Prevalence
FROM INFORMATION_SCHEMA.COLUMNS
GROUP BY COLUMN_NAME
SELECT DISTINCT
C1.COLUMN_NAME
, C1.TABLE_SCHEMA
, C1.TABLE_NAME
, C1.DATA_TYPE
, C1.CHARACTER_MAXIMUM_LENGTH
, C1.NUMERIC_PRECISION
, C1.NUMERIC_SCALE
, [%]
FROM INFORMATION_SCHEMA.COLUMNS C1
INNER JOIN INFORMATION_SCHEMA.COLUMNS C2 ON C1.COLUMN_NAME =
C2.COLUMN_NAME
INNER JOIN #Prevalence p ON p.COLUMN_NAME = C1.COLUMN_NAME
WHERE ((C1.DATA_TYPE != C2.DATA_TYPE)
OR (C1.CHARACTER_MAXIMUM_LENGTH != C2.CHARACTER_MAXIMUM_LENGTH)
OR (C1.NUMERIC_PRECISION != C2.NUMERIC_PRECISION)
OR (C1.NUMERIC_SCALE != C2.NUMERIC_SCALE))
ORDER BY [%] DESC, C1.COLUMN_NAME, C1.TABLE_SCHEMA, C1.TABLE_NAME
DROP TABLE #Prevalence


#>}
#----------------------------------------------------
#  1162 Listing 5.4 Finding queries that are running slower than normal p.128
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 100
qs.execution_count AS [Runs]
, (qs.total_worker_time - qs.last_worker_time) / (qs.execution_count - 1)
AS [Avg time]
, qs.last_worker_time AS [Last time]
, (qs.last_worker_time - ((qs.total_worker_time - qs.last_worker_time) /
(qs.execution_count - 1))) AS [Time Deviation]
, CASE WHEN qs.last_worker_time = 0
THEN 100
ELSE (qs.last_worker_time - ((qs.total_worker_time -
qs.last_worker_time) / (qs.execution_count - 1))) * 100
END
/ (((qs.total_worker_time - qs.last_worker_time) /
(qs.execution_count - 1.0))) AS [% Time Deviation]
,qs.last_logical_reads + qs.last_logical_writes + qs.last_physical_reads
AS [Last IO]
, ((qs.total_logical_reads + qs.total_logical_writes +
qs.total_physical_reads) -
(qs.last_logical_reads + last_logical_writes
+ qs.last_physical_reads))
/ (qs.execution_count - 1) AS [Avg IO]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS [DatabaseName]
INTO #SlowQueries
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) qt
WHERE qs.execution_count > 1
AND qs.total_worker_time != qs.last_worker_time
ORDER BY [% Time Deviation] DESC
SELECT TOP 100 [Runs]
, [Avg time]
, [Last time]
, [Time Deviation]
, [% Time Deviation]
, [Last IO]
, [Avg IO]
, [Last IO] - [Avg IO] AS [IO Deviation]
, CASE WHEN [Avg IO] = 0
THEN 0
ELSE ([Last IO]- [Avg IO]) * 100 / [Avg IO]
END AS [% IO Deviation]
, [Individual Query]
, [Parent Query]
, [DatabaseName]
INTO #SlowQueriesByIO
FROM #SlowQueries
ORDER BY [% Time Deviation] DESC
SELECT TOP 100
[Runs]
, [Avg time]
, [Last time]
, [Time Deviation]
, [% Time Deviation]
, [Last IO]
, [Avg IO]
, [IO Deviation]
, [% IO Deviation]
, [Impedance] = [% Time Deviation] - [% IO Deviation]
, [Individual Query]
, [Parent Query]
, [DatabaseName]
FROM #SlowQueriesByIO
WHERE [% Time Deviation] - [% IO Deviation] > 20
ORDER BY [Impedance] DESC
DROP TABLE #SlowQueries
DROP TABLE #SlowQueriesByIO

#>}
#----------------------------------------------------
#   1241  Listing 5.5 Finding unused stored procedures   p.133
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT s.name, s.type_desc
FROM sys.procedures s
LEFT OUTER JOIN sys.dm_exec_procedure_stats d
ON s.object_id = d.object_id
WHERE d.object_id IS NULL
ORDER BY s.name

#>}
#----------------------------------------------------
# 1255  Listing 5.6 Which queries run over a given time period p.134
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT sql_handle, plan_handle, total_elapsed_time
, total_worker_time, total_logical_reads, total_logical_writes
, total_clr_time, execution_count, statement_start_offset
, statement_end_offset
INTO #PreWorkSnapShot
FROM sys.dm_exec_query_stats

--Time delay period
WAITFOR DELAY '00:05:00'

SELECT sql_handle, plan_handle, total_elapsed_time
, total_worker_time, total_logical_reads, total_logical_writes
, total_clr_time, execution_count, statement_start_offset
, statement_end_offset

INTO #PostWorkSnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
, qp.query_plan
FROM #PreWorkSnapShot p1
RIGHT OUTER JOIN
#PostWorkSnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(p2.plan_handle) qp
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND qt.text NOT LIKE '--ThisRoutineIdentifier99%'
ORDER BY [Duration] DESC
DROP TABLE #PreWorkSnapShot
DROP TABLE #PostWorkSnapShot


#>}
#----------------------------------------------------
#  1316  Listing 5.7 Amalgamated DMV snapshots  p.137
#----------------------------------------------------
{<#

--ThisRoutineIdentifier
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
index_group_handle, index_handle
, avg_total_user_cost, avg_user_impact, user_seeks, user_scans
INTO #PreWorkMissingIndexes
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle

SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PreWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PreWorkWaitStats
FROM sys.dm_os_wait_stats
WAITFOR DELAY '00:05:00'
SELECT wait_type, waiting_tasks_count, wait_time_ms
, max_wait_time_ms, signal_wait_time_ms
INTO #PostWorkWaitStats
FROM sys.dm_os_wait_stats
SELECT [object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PostWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats

SELECT index_group_handle, index_handle
, avg_total_user_cost, avg_user_impact, user_seeks, user_scans
INTO #PostWorkMissingIndexes
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2

ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND qt.text NOT LIKE '--ThisRoutineIdentifier%'
SELECT
p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) AS wait_time_ms
, p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)
AS signal_wait_time_ms
, ((p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0))
- (p2.signal_wait_time_ms
- ISNULL(p1.signal_wait_time_ms, 0))) AS RealWait
, p2.wait_type
FROM #PreWorkWaitStats p1
RIGHT OUTER JOIN
#PostWorkWaitStats p2 ON p2.wait_type = ISNULL(p1.wait_type, p2.wait_type)
WHERE p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) > 0
AND p2.wait_type NOT LIKE '%SLEEP%'
AND p2.wait_type != 'WAITFOR'
ORDER BY RealWait DESC

SELECT
ROUND((p2.avg_total_user_cost - ISNULL(p1.avg_total_user_cost, 0))
* (p2.avg_user_impact - ISNULL(p1.avg_user_impact, 0)) *
((p2.user_seeks - ISNULL(p1.user_seeks, 0))
+ (p2.user_scans - ISNULL(p1.user_scans, 0))),0)
AS [Total Cost]
, p2.avg_total_user_cost - ISNULL(p1.avg_total_user_cost, 0)
AS avg_total_user_cost
, p2.avg_user_impact - ISNULL(p1.avg_user_impact, 0) AS avg_user_impact
, p2.user_seeks - ISNULL(p1.user_seeks, 0) AS user_seeks
, p2.user_scans - ISNULL(p1.user_scans, 0) AS user_scans
, d.statement AS TableName
, d.equality_columns
, d.inequality_columns
, d.included_columns
FROM #PreWorkMissingIndexes p1
RIGHT OUTER JOIN
#PostWorkMissingIndexes p2 ON p2.index_group_handle =
ISNULL(p1.index_group_handle, p2.index_group_handle)
AND p2.index_handle =
ISNULL(p1.index_handle, p2.index_handle)
INNER JOIN sys.dm_db_missing_index_details d
ON p2.index_handle = d.index_handle

WHERE p2.avg_total_user_cost - ISNULL(p1.avg_total_user_cost, 0) > 0
OR p2.avg_user_impact - ISNULL(p1.avg_user_impact, 0) > 0
OR p2.user_seeks - ISNULL(p1.user_seeks, 0) > 0
OR p2.user_scans - ISNULL(p1.user_scans, 0) > 0
ORDER BY [Total Cost] DESC
SELECT
p2.object_name, p2.counter_name, p2.instance_name
, ISNULL(p1.cntr_value, 0) AS InitialValue
, p2.cntr_value AS FinalValue
, p2.cntr_value - ISNULL(p1.cntr_value, 0) AS Change
, (p2.cntr_value - ISNULL(p1.cntr_value, 0)) * 100 / p1.cntr_value
AS [% Change]
FROM #PreWorkOSSnapShot p1
RIGHT OUTER JOIN
#PostWorkOSSnapShot p2 ON p2.object_name =
ISNULL(p1.object_name, p2.object_name)
AND p2.counter_name = ISNULL(p1.counter_name, p2.counter_name)
AND p2.instance_name = ISNULL(p1.instance_name, p2.instance_name)
WHERE p2.cntr_value - ISNULL(p1.cntr_value, 0) > 0
AND ISNULL(p1.cntr_value, 0) != 0
ORDER BY [% Change] DESC, Change DESC
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
DROP TABLE #PostWorkWaitStats
DROP TABLE #PreWorkWaitStats
DROP TABLE #PreWorkOSSnapShot
DROP TABLE #PostWorkOSSnapShot
DROP TABLE #PreWorkMissingIndexes
DROP TABLE #PostWorkMissingIndexes

#>}
#----------------------------------------------------
#  1470  Listing 5.8 What queries are running now  p.142
#----------------------------------------------------
{<#

SELECT
es.session_id, es.host_name, es.login_name
, er.status, DB_NAME(database_id) AS DatabaseName
, SUBSTRING (qt.text,(er.statement_start_offset/2) + 1,
((CASE WHEN er.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE er.statement_end_offset
END - er.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, es.program_name, er.start_time, qp.query_plan
, er.wait_type, er.total_elapsed_time, er.cpu_time, er.logical_reads
, er.blocking_session_id, er.open_transaction_count, er.last_wait_type
, er.percent_complete
FROM sys.dm_exec_requests AS er
INNER JOIN sys.dm_exec_sessions AS es ON es.session_id = er.session_id
CROSS APPLY sys.dm_exec_sql_text( er.sql_handle) AS qt
CROSS APPLY sys.dm_exec_query_plan(er.plan_handle) qp
WHERE es.is_user_process=1
AND es.session_Id NOT IN (@@SPID)
ORDER BY es.session_id


#>}
#----------------------------------------------------
#   1498 Listing 5.9 Determining your most-recompiled queries p.144
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
qs.plan_generation_num
, qs.total_elapsed_time
, qs.execution_count
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]

, DB_NAME(qt.dbid) AS DatabaseName
, qs.creation_time
, qs.last_execution_time
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
ORDER BY plan_generation_num DESC

#>}
#----------------------------------------------------
#  1522 Listing 6.1 Why are you waiting? p.149
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
wait_type, wait_time_ms, signal_wait_time_ms
, wait_time_ms - signal_wait_time_ms AS RealWait
, CONVERT(DECIMAL(12,2), wait_time_ms * 100.0 / SUM(wait_time_ms) OVER())
AS [% Waiting]
, CONVERT(DECIMAL(12,2), (wait_time_ms - signal_wait_time_ms) * 100.0
/ SUM(wait_time_ms) OVER()) AS [% RealWait]
FROM sys.dm_os_wait_stats
WHERE wait_type NOT LIKE '%SLEEP%'
AND wait_type != 'WAITFOR'
ORDER BY wait_time_ms DESC





#>}
#----------------------------------------------------
#  1544  Listing 6.2 Why are you waiting? (snapshot version) p.153
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PreWorkWaitStats
FROM sys.dm_os_wait_stats
WAITFOR DELAY '00:10:00'
SELECT wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PostWorkWaitStats
FROM sys.dm_os_wait_stats
SELECT
p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) AS wait_time_ms
, p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)
AS signal_wait_time_ms
, ((p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0))
- (p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)))
AS RealWait
, p2.wait_type
FROM #PreWorkWaitStats p1
RIGHT OUTER JOIN
#PostWorkWaitStats p2 ON p2.wait_type = ISNULL(p1.wait_type, p2.wait_type)
WHERE p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) > 0
AND p2.wait_type NOT LIKE '%SLEEP%'
AND p2.wait_type != 'WAITFOR'
ORDER BY RealWait DESC
DROP TABLE #PostWorkWaitStats
DROP TABLE #PreWorkWaitStats





#>}
#----------------------------------------------------
#  1581  Listing 6.3 Why your queries are waiting  p.155
#----------------------------------------------------
{<#

--ThisRoutineIdentifier
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PreWorkWaitStats
FROM sys.dm_os_wait_stats
WAITFOR DELAY '00:05:00'
SELECT
wait_type, waiting_tasks_count, wait_time_ms
, max_wait_time_ms, signal_wait_time_ms
INTO #PostWorkWaitStats
FROM sys.dm_os_wait_stats
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) AS wait_time_ms
, p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)
AS signal_wait_time_ms
, ((p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0))
– (p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)))
AS RealWait
, p2.wait_type
FROM #PreWorkWaitStats p1
RIGHT OUTER JOIN
#PostWorkWaitStats p2 ON p2.wait_type = ISNULL(p1.wait_type, p2.wait_type)
WHERE p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) > 0
AND p2.wait_type NOT LIKE '%SLEEP%'
AND p2.wait_type != 'WAITFOR'
ORDER BY RealWait DESC

SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND qt.text NOT LIKE '--ThisRoutineIdentifier%'
ORDER BY [Time blocked] DESC
DROP TABLE #PostWorkWaitStats
DROP TABLE #PreWorkWaitStats
DROP TABLE #PostWorkQuerySnapShot
DROP TABLE #PreWorkQuerySnapShot




#>}
#----------------------------------------------------
#  1667  Listing 6.4 What is blocked? p.159
#----------------------------------------------------
{<#
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
The script shows details of the query that is causing



#>}
#----------------------------------------------------
#  1696 Listing 6.5 Effect of queries on performance counters p.164
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PreWorkOSSnapShot
FROM sys.dm_os_performance_counters
WAITFOR DELAY '00:05:00'
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PostWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
p2.object_name, p2.counter_name, p2.instance_name
, ISNULL(p1.cntr_value, 0) AS InitialValue
, p2.cntr_value AS FinalValue
, p2.cntr_value - ISNULL(p1.cntr_value, 0) AS Change
, (p2.cntr_value - ISNULL(p1.cntr_value, 0)) * 100 / p1.cntr_value
AS [% Change]
FROM #PreWorkOSSnapShot p1
RIGHT OUTER JOIN
#PostWorkOSSnapShot p2 ON p2.object_name =
ISNULL(p1.object_name, p2.object_name)
AND p2.counter_name = ISNULL(p1.counter_name, p2.counter_name)
AND p2.instance_name = ISNULL(p1.instance_name, p2.instance_name)
WHERE p2.cntr_value - ISNULL(p1.cntr_value, 0) > 0
AND ISNULL(p1.cntr_value, 0) != 0
ORDER BY [% Change] DESC, Change DESC
DROP TABLE #PreWorkOSSnapShot
DROP TABLE #PostWorkOSSnapShot




#>}
#----------------------------------------------------
#  1736  Listing 6.6 Changes in performance counters and wait states p.166
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PreWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PreWorkWaitStats
FROM sys.dm_os_wait_stats
WAITFOR DELAY '00:05:00'
SELECT
wait_type, waiting_tasks_count, wait_time_ms
, max_wait_time_ms, signal_wait_time_ms
INTO #PostWorkWaitStats
FROM sys.dm_os_wait_stats
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PostWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) AS wait_time_ms
, p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)
AS signal_wait_time_ms
, ((p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0)) –
(p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)))
AS RealWait
, p2.wait_type
FROM #PreWorkWaitStats p1
RIGHT OUTER JOIN
#PostWorkWaitStats p2 ON p2.wait_type = ISNULL(p1.wait_type, p2.wait_type)
WHERE p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) > 0
AND p2.wait_type NOT LIKE '%SLEEP%'
AND p2.wait_type != 'WAITFOR'
ORDER BY RealWait DESC
SELECT
p2.object_name, p2.counter_name, p2.instance_name
, ISNULL(p1.cntr_value, 0) AS InitialValue
, p2.cntr_value AS FinalValue
, p2.cntr_value - ISNULL(p1.cntr_value, 0) AS Change
, (p2.cntr_value - ISNULL(p1.cntr_value, 0)) * 100 / p1.cntr_value
AS [% Change]
FROM #PreWorkOSSnapShot p1
RIGHT OUTER JOIN
#PostWorkOSSnapShot p2 ON p2.object_name =
ISNULL(p1.object_name, p2.object_name)
AND p2.counter_name = ISNULL(p1.counter_name, p2.counter_name)
AND p2.instance_name = ISNULL(p1.instance_name, p2.instance_name)
WHERE p2.cntr_value - ISNULL(p1.cntr_value, 0) > 0
AND ISNULL(p1.cntr_value, 0) != 0
ORDER BY [% Change] DESC, Change DESC
DROP TABLE #PostWorkWaitStats
DROP TABLE #PreWorkWaitStats
DROP TABLE #PreWorkOSSnapShot
DROP TABLE #PostWorkOSSnapShot



#>}
#----------------------------------------------------
#  1801 Listing 6.7 Queries that change performance counters and wait states p.169
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PreWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PreWorkWaitStats
FROM sys.dm_os_wait_stats
WAITFOR DELAY '00:05:00'
SELECT
wait_type, waiting_tasks_count, wait_time_ms
, max_wait_time_ms, signal_wait_time_ms
INTO #PostWorkWaitStats
FROM sys.dm_os_wait_stats
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PostWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND qt.text NOT LIKE '--ThisRoutineIdentifier%'
ORDER BY [Duration] DESC

SELECT
p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) AS wait_time_ms
, p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)
AS signal_wait_time_ms
, ((p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0)) –
(p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)))
AS RealWait
, p2.wait_type
FROM #PreWorkWaitStats p1
RIGHT OUTER JOIN
#PostWorkWaitStats p2 ON p2.wait_type = ISNULL(p1.wait_type, p2.wait_type)
WHERE p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) > 0
AND p2.wait_type NOT LIKE '%SLEEP%'
AND p2.wait_type != 'WAITFOR'
ORDER BY RealWait DESC
SELECT
p2.object_name, p2.counter_name, p2.instance_name
, ISNULL(p1.cntr_value, 0) AS InitialValue
, p2.cntr_value AS FinalValue
, p2.cntr_value - ISNULL(p1.cntr_value, 0) AS Change
, (p2.cntr_value - ISNULL(p1.cntr_value, 0)) * 100 / p1.cntr_value
AS [% Change]
FROM #PreWorkOSSnapShot p1
RIGHT OUTER JOIN
#PostWorkOSSnapShot p2 ON p2.object_name =
ISNULL(p1.object_name, p2.object_name)
AND p2.counter_name = ISNULL(p1.counter_name, p2.counter_name)
AND p2.instance_name = ISNULL(p1.instance_name, p2.instance_name)
WHERE p2.cntr_value - ISNULL(p1.cntr_value, 0) > 0
AND ISNULL(p1.cntr_value, 0) != 0
ORDER BY [% Change] DESC, Change DESC
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
DROP TABLE #PostWorkWaitStats
DROP TABLE #PreWorkWaitStats
DROP TABLE #PreWorkOSSnapShot
DROP TABLE #PostWorkOSSnapShot




#>}
#----------------------------------------------------
#  1913 Listing 6.8 Recording DMV snapshots periodically p.173
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
CREATE TABLE #PerfCounters
( RunDateTime datetime NOT NULL,
object_name nchar(128) NOT NULL,
counter_name nchar(128) NOT NULL,
instance_name nchar(128) NULL,
cntr_value bigint NOT NULL,
cntr_type int NOT NULL
)
ALTER TABLE #PerfCounters
ADD CONSTRAINT DF_PerFCounters_RunDateTime
DEFAULT (getdate()) FOR RunDateTime
GO
INSERT INTO #PerfCounters
(object_name,counter_name,instance_name,cntr_value,cntr_type)
(SELECT object_name,counter_name,instance_name,cntr_value,cntr_type
FROM sys.dm_os_performance_counters)
WAITFOR DELAY '00:00:01'
GO 20
SELECT * FROM #PerfCounters
ORDER BY RunDateTime, object_name,counter_name,instance_name
DROP TABLE #PerfCounters



#>}
#----------------------------------------------------
# 1944  Listing 7.1 C# code to create regular expression functionality for use within SQL Server p.178
#----------------------------------------------------
{<#

EXEC sp_configure 'show advanced options', 1
RECONFIGURE
EXEC sp_configure 'clr_enabled', 1
RECONFIGURE



#>}
#----------------------------------------------------
# 1957  Listing 7.2 Enabling CLR integration within SQL Server p.182
#----------------------------------------------------
{<#
SELECT dbo.RegExDigitsOnly('123456');
SELECT dbo.RegExDigitsOnly('123456789abc');
SELECT dbo.RegExEmailIsValid('ian_stirk@yahoo.com');
SELECT dbo.RegExEmailIsValid('ian_stirk@yahoo');
SELECT dbo.WebAddressIsValid
➥('http://www.manning.com/stirk');
SELECT dbo.WebAddressIsValid
➥('http://wwwmanningcom');
SELECT dbo.RegExReplace('Q123AS456WE789', '[^0-9]', 'a');
SELECT dbo.RegExMatch('123456789', '^[0-9]+$');
SELECT dbo.RegExMatch('12345678abc9', '^[0-9]+$');



#>}
#----------------------------------------------------
#   1976  Listing 7.3 Using the CLR regular expression functionality
#----------------------------------------------------
{<#




#>}
#----------------------------------------------------
#   1985 Listing 7.4 The queries that spend the most time in the CLR p.185
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
qs.total_clr_time
, qs.total_elapsed_time AS [Duration]
, qs.total_worker_time AS [Time on CPU]
, qs.total_elapsed_time – qs.total_worker_time AS [Time waiting]
, qs.total_logical_reads
, qs.total_logical_writes
, qs.execution_count
, SUBSTRING (qt.text,qs.statement_start_offset/2 + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END – qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(sql_handle) as qt
WHERE qs.total_clr_time > 0
ORDER BY qs.total_clr_time DESC




#>}
#----------------------------------------------------
#   2034  Listing 7.5 The queries that spend the most time in the CLR (snapshot version) p.188
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
WAITFOR DELAY '00:10:00'
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND p2.total_clr_time - ISNULL(p1.total_clr_time, 0) <>0
ORDER BY [CLR time] DESC
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot



#>}
#----------------------------------------------------
#   2090  Listing 7.6 Relationships between DMVs and CLR queries p190
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
g.index_group_handle, g.index_handle
, s.avg_total_user_cost
, s.avg_user_impact, s.user_seeks, s.user_scans
INTO #PreWorkMissingIndexes
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
[object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PreWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT
wait_type, waiting_tasks_count
, wait_time_ms, max_wait_time_ms, signal_wait_time_ms
INTO #PreWorkWaitStats
FROM sys.dm_os_wait_stats
WAITFOR DELAY '00:10:00'
SELECT wait_type, waiting_tasks_count, wait_time_ms
, max_wait_time_ms, signal_wait_time_ms
INTO #PostWorkWaitStats
FROM sys.dm_os_wait_stats
SELECT [object_name], [counter_name], [instance_name]
, [cntr_value], [cntr_type]
INTO #PostWorkOSSnapShot
FROM sys.dm_os_performance_counters
SELECT sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT g.index_group_handle, g.index_handle, s.avg_total_user_cost
, s.avg_user_impact, s.user_seeks, s.user_scans
INTO #PostWorkMissingIndexes
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND p2.total_clr_time - ISNULL(p1.total_clr_time, 0) <>0
ORDER BY [CLR time] DESC
SELECT
p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) AS wait_time_ms
, p2.signal_wait_time_ms - ISNULL(p1.signal_wait_time_ms, 0)
AS signal_wait_time_ms
, ((p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0)) –
(p2.signal_wait_time_ms
- ISNULL(p1.signal_wait_time_ms, 0))) AS RealWait
, p2.wait_type
FROM #PreWorkWaitStats p1
RIGHT OUTER JOIN
#PostWorkWaitStats p2 ON p2.wait_type = ISNULL(p1.wait_type, p2.wait_type)
WHERE p2.wait_time_ms - ISNULL(p1.wait_time_ms, 0) > 0
AND p2.wait_type NOT LIKE '%SLEEP%'
AND p2.wait_type != 'WAITFOR'
ORDER BY RealWait DESC
SELECT
ROUND((p2.avg_total_user_cost - ISNULL(p1.avg_total_user_cost, 0))
* (p2.avg_user_impact - ISNULL(p1.avg_user_impact, 0)) *
((p2.user_seeks - ISNULL(p1.user_seeks, 0)) + (p2.user_scans –
ISNULL(p1.user_scans, 0))),0) AS [Total Cost]
, p2.avg_total_user_cost - ISNULL(p1.avg_total_user_cost, 0)
AS avg_total_user_cost
, p2.avg_user_impact - ISNULL(p1.avg_user_impact, 0) AS avg_user_impact
, p2.user_seeks - ISNULL(p1.user_seeks, 0) AS user_seeks
, p2.user_scans - ISNULL(p1.user_scans, 0) AS user_scans
, d.statement AS TableName
, d.equality_columns
, d.inequality_columns
, d.included_columns
FROM #PreWorkMissingIndexes p1
RIGHT OUTER JOIN
#PostWorkMissingIndexes p2 ON p2.index_group_handle =
ISNULL(p1.index_group_handle, p2.index_group_handle)
AND p2.index_handle = ISNULL(p1.index_handle, p2.index_handle)
INNER JOIN sys.dm_db_missing_index_details d
ON p2.index_handle = d.index_handle
WHERE p2.avg_total_user_cost - ISNULL(p1.avg_total_user_cost, 0) > 0
OR p2.avg_user_impact - ISNULL(p1.avg_user_impact, 0) > 0
OR p2.user_seeks - ISNULL(p1.user_seeks, 0) > 0
OR p2.user_scans - ISNULL(p1.user_scans, 0) > 0
ORDER BY [Total Cost] DESC
SELECT
p2.object_name, p2.counter_name, p2.instance_name
, ISNULL(p1.cntr_value, 0) AS InitialValue
, p2.cntr_value AS FinalValue
, p2.cntr_value - ISNULL(p1.cntr_value, 0) AS Change
, (p2.cntr_value - ISNULL(p1.cntr_value, 0)) * 100 / p1.cntr_value
AS [% Change]
FROM #PreWorkOSSnapShot p1
RIGHT OUTER JOIN
#PostWorkOSSnapShot p2 ON p2.object_name =
ISNULL(p1.object_name, p2.object_name)
AND p2.counter_name = ISNULL(p1.counter_name, p2.counter_name)
AND p2.instance_name = ISNULL(p1.instance_name, p2.instance_name)
WHERE p2.cntr_value - ISNULL(p1.cntr_value, 0) > 0
AND ISNULL(p1.cntr_value, 0) != 0
ORDER BY [% Change] DESC, Change DESC
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
DROP TABLE #PostWorkWaitStats
DROP TABLE #PreWorkWaitStats
DROP TABLE #PreWorkOSSnapShot
DROP TABLE #PostWorkOSSnapShot
DROP TABLE #PreWorkMissingIndexes
DROP TABLE #PostWorkMissingIndexes
#>}
#----------------------------------------------------
#  2237 Listing 7.7 Obtaining information about SQL CLR assemblies p.194
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME(d.db_id) AS DatabaseName
, USER_NAME(d.user_id) UserName
, a.name AS AssemblyName
, f.name AS AssemblyFileName
, a.create_date AS AssemblyCreateDate
, l.load_time AS AssemblyLoadDate
, d.appdomain_name
, d.creation_time AS AppDomainCreateTime
, a.permission_set_desc
, d.state
, a.clr_name
, a.is_visible
FROM sys.dm_clr_loaded_assemblies AS l
INNER JOIN sys.dm_clr_appdomains d
ON l.appdomain_address = d.appdomain_address
INNER JOIN sys.assemblies AS a
ON l.assembly_id = a.assembly_id
INNER JOIN sys.assembly_files AS f
ON a.assembly_id = f.assembly_id
ORDER BY DatabaseName, UserName, AssemblyName



#>}
#----------------------------------------------------
#  2267 Listing 8.1 Transaction processing pattern p.198
#----------------------------------------------------
{<#
BEGIN TRY
	BEGIN TRAN
	SELECT 1/0
	PRINT 'Success'
	COMMIT
END TRY
	BEGIN CATCH
	ROLLBACK
	PRINT 'An error has occurred'
END CATCH
#>}
#----------------------------------------------------
#  2282 Listing 8.2 Creating the sample database and table p.199
#----------------------------------------------------
{<#

CREATE DATABASE IWS_Temp
GO
USE IWS_Temp
CREATE TABLE [dbo].[tblCountry](
[CountryId] [int] IDENTITY(1,1) NOT NULL,
[Code] [char](3) NOT NULL,
[Description] [varchar](50) NOT NULL)
#>}
#----------------------------------------------------
#  2295 Listing 8.3 Starting an open transaction  p.200
#----------------------------------------------------
{<#
USE IWS_TEMP
BEGIN TRANSACTION
INSERT INTO [dbo].[tblCountry] ([Code], [Description]) VALUES('ENG', 'ENGLAND')

#>}
#----------------------------------------------------
#  2304 Listing 8.4 Selecting data from a table that has an open transaction against it p.200
#----------------------------------------------------
{<#
USE IWS_TEMP
SELECT * FROM [dbo].[tblCountry]



#>}
#----------------------------------------------------
#  2314 Listing 8.5 Observing the current locks  p.200
#----------------------------------------------------
{<#

SELECT DB_NAME(resource_database_id) AS DatabaseName, request_session_id
, resource_type, request_status, request_mode
FROM sys.dm_tran_locks
WHERE request_session_id !=@@spid
ORDER BY request_session_id


#>}
#----------------------------------------------------
#  2327 Listing 8.6 Template for handling deadlock retries p.204
#----------------------------------------------------
{<#

DECLARE @CurrentTry INT = 1
DECLARE @MaxRetries INT = 3
DECLARE @Complete BIT = 0
WHILE (@Complete = 0)
BEGIN
BEGIN TRY
EXEC dbo.SomeRoutine
SET @Complete = 1
END TRY
BEGIN CATCH
DECLARE @ErrorNum INT
DECLARE @ErrorMessage NVARCHAR(4000)
DECLARE @ErrorState INT
DECLARE @ErrorSeverity INT
SET @ErrorNum = ERROR_NUMBER()
SET @ErrorMessage = ERROR_MESSAGE()
SET @ErrorState = ERROR_STATE()
SET @ErrorSeverity = ERROR_SEVERITY()
IF (@ErrorNum = 1205) AND (@CurrentTry < @MaxRetries)
BEGIN
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION
SET @CurrentTry = @CurrentTry + 1
WAITFOR DELAY '00:00:10'
END
ELSE
BEGIN
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION
SET @Complete = 1
RAISERROR ('An error has occurred'
, @ErrorSeverity
, @ErrorState)
END
END CATCH
END



#>}
#----------------------------------------------------
#  2372 Listing 8.7 Information contained in sessions, connections, and requests p.208
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT *
FROM sys.dm_exec_sessions s
LEFT OUTER JOIN sys.dm_exec_connections c
ON s.session_id = c.session_id
LEFT OUTER JOIN sys.dm_exec_requests r
ON c.connection_id = r.connection_id
WHERE s.session_id > 50




#>}
#----------------------------------------------------
#  2389 Listing 8.8 How to discover which locks are currently held p.209
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT DB_NAME(resource_database_id) AS DatabaseName
, request_session_id
, resource_type
, CASE
WHEN resource_type = 'OBJECT'
THEN OBJECT_NAME(resource_associated_entity_id)
WHEN resource_type IN ('KEY', 'PAGE', 'RID')
THEN (SELECT OBJECT_NAME(OBJECT_ID)
FROM sys.partitions p
WHERE p.hobt_id = l.resource_associated_entity_id)
END AS resource_type_name
, request_status
, request_mode
FROM sys.dm_tran_locks l
WHERE request_session_id !=@@spid
ORDER BY request_session_id



#>}
#----------------------------------------------------
#  2415 Listing 8.9 How to identify contended resources p.211
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
tl1.resource_type,
DB_NAME(tl1.resource_database_id) AS DatabaseName,
tl1.resource_associated_entity_id,
tl1.request_session_id,
tl1.request_mode,
tl1.request_status
, CASE
WHEN tl1.resource_type = 'OBJECT'
THEN OBJECT_NAME(tl1.resource_associated_entity_id)
WHEN tl1.resource_type IN ('KEY', 'PAGE', 'RID')
THEN (SELECT OBJECT_NAME(OBJECT_ID)
FROM sys.partitions s
WHERE s.hobt_id = tl1.resource_associated_entity_id)
END AS resource_type_name
FROM sys.dm_tran_locks as tl1
INNER JOIN sys.dm_tran_locks as tl2
ON tl1.resource_associated_entity_id = tl2.resource_associated_entity_id
AND tl1.request_status <> tl2.request_status
AND (tl1.resource_description = tl2.resource_description
OR (tl1.resource_description IS NULL
AND tl2.resource_description IS NULL))
ORDER BY tl1.resource_associated_entity_id, tl1.request_status


#>}
#----------------------------------------------------
#  2447 Listing 8.10 How to identify contended resources, including SQL query details p.211
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
tl1.resource_type
, DB_NAME(tl1.resource_database_id) AS DatabaseName
, tl1.resource_associated_entity_id
, tl1.request_session_id
, tl1.request_mode
, tl1.request_status
, CASE
WHEN tl1.resource_type = 'OBJECT'
THEN OBJECT_NAME(tl1.resource_associated_entity_id)
WHEN tl1.resource_type IN ('KEY', 'PAGE', 'RID')
THEN (SELECT OBJECT_NAME(OBJECT_ID)
FROM sys.partitions s
WHERE s.hobt_id = tl1.resource_associated_entity_id)
END AS resource_type_name
, t.text AS [Parent Query]
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS [Individual Query]
FROM sys.dm_tran_locks as tl1
INNER JOIN sys.dm_tran_locks as tl2
ON tl1.resource_associated_entity_id = tl2.resource_associated_entity_id
AND tl1.request_status <> tl2.request_status
AND (tl1.resource_description = tl2.resource_description
OR (tl1.resource_description IS NULL
AND tl2.resource_description IS NULL))
INNER JOIN sys.dm_exec_connections c
ON tl1.request_session_id = c.most_recent_session_id
CROSS APPLY sys.dm_exec_sql_text(c.most_recent_sql_handle) t
LEFT OUTER JOIN sys.dm_exec_requests r ON c.connection_id = r.connection_id
ORDER BY tl1.resource_associated_entity_id, tl1.request_status



#>}
#----------------------------------------------------
#  2490 Listing 8.11 How to find an idle session with an open transaction p.214
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT es.session_id, es.login_name, es.host_name, est.text
, cn.last_read, cn.last_write, es.program_name
FROM sys.dm_exec_sessions es
INNER JOIN sys.dm_tran_session_transactions st
ON es.session_id = st.session_id
INNER JOIN sys.dm_exec_connections cn
ON es.session_id = cn.session_id
CROSS APPLY sys.dm_exec_sql_text(cn.most_recent_sql_handle) est
LEFT OUTER JOIN sys.dm_exec_requests er
ON st.session_id = er.session_id
AND er.session_id IS NULL



#>}
#----------------------------------------------------
#  2511 Listing 8.12 What’s being blocked by idle sessions with open transactions p.215
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
Waits.wait_duration_ms / 1000 AS WaitInSeconds
, Blocking.session_id as BlockingSessionId
, DB_NAME(Blocked.database_id) AS DatabaseName
, Sess.login_name AS BlockingUser
, Sess.host_name AS BlockingLocation
, BlockingSQL.text AS BlockingSQL
, Blocked.session_id AS BlockedSessionId
, BlockedSess.login_name AS BlockedUser
, BlockedSess.host_name AS BlockedLocation
, BlockedSQL.text AS BlockedSQL
, SUBSTRING (BlockedSQL.text, (BlockedReq.statement_start_offset/2) + 1,
((CASE WHEN BlockedReq.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), BlockedSQL.text)) * 2
ELSE BlockedReq.statement_end_offset
END - BlockedReq.statement_start_offset)/2) + 1)
AS [Blocked Individual Query]
, Waits.wait_type
FROM sys.dm_exec_connections AS Blocking
INNER JOIN sys.dm_exec_requests AS Blocked
ON Blocking.session_id = Blocked.blocking_session_id
INNER JOIN sys.dm_exec_sessions Sess
ON Blocking.session_id = sess.session_id
INNER JOIN sys.dm_tran_session_transactions st
ON Blocking.session_id = st.session_id
LEFT OUTER JOIN sys.dm_exec_requests er
ON st.session_id = er.session_id
AND er.session_id IS NULL
INNER JOIN sys.dm_os_waiting_tasks AS Waits
ON Blocked.session_id = Waits.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)
AS BlockingSQL
INNER JOIN sys.dm_exec_requests AS BlockedReq
ON Waits.session_id = BlockedReq.session_id
INNER JOIN sys.dm_exec_sessions AS BlockedSess
ON Waits.session_id = BlockedSess.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQL
ORDER BY WaitInSeconds

#>}
#----------------------------------------------------
#  2556 Listing 8.13 What’s blocked by active sessions with open transactionsp.218
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
Waits.wait_duration_ms / 1000 AS WaitInSeconds
, Blocking.session_id as BlockingSessionId
, DB_NAME(Blocked.database_id) AS DatabaseName
, Sess.login_name AS BlockingUser
, Sess.host_name AS BlockingLocation
, BlockingSQL.text AS BlockingSQL
, Blocked.session_id AS BlockedSessionId
, BlockedSess.login_name AS BlockedUser
, BlockedSess.host_name AS BlockedLocation
, BlockedSQL.text AS BlockedSQL
, SUBSTRING (BlockedSQL.text, (BlockedReq.statement_start_offset/2) + 1,
((CASE WHEN BlockedReq.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), BlockedSQL.text)) * 2
ELSE BlockedReq.statement_end_offset
END - BlockedReq.statement_start_offset)/2) + 1)
AS [Blocked Individual Query]
, Waits.wait_type
FROM sys.dm_exec_connections AS Blocking
INNER JOIN sys.dm_exec_requests AS Blocked
ON Blocking.session_id = Blocked.blocking_session_id
INNER JOIN sys.dm_exec_sessions Sess
ON Blocking.session_id = sess.session_id
INNER JOIN sys.dm_tran_session_transactions st
ON Blocking.session_id = st.session_id
INNER JOIN sys.dm_exec_requests er
ON st.session_id = er.session_id
INNER JOIN sys.dm_os_waiting_tasks AS Waits
ON Blocked.session_id = Waits.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)
AS BlockingSQL
INNER JOIN sys.dm_exec_requests AS BlockedReq
ON Waits.session_id = BlockedReq.session_id
INNER JOIN sys.dm_exec_sessions AS BlockedSess
ON Waits.session_id = BlockedSess.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQL
ORDER BY WaitInSeconds



#>}
#----------------------------------------------------
#  2602 Listing 8.14 What’s blocked—active and idle sessions with open transactions p.219
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
Waits.wait_duration_ms / 1000 AS WaitInSeconds
, Blocking.session_id as BlockingSessionId
, DB_NAME(Blocked.database_id) AS DatabaseName
, Sess.login_name AS BlockingUser
, Sess.host_name AS BlockingLocation
, BlockingSQL.text AS BlockingSQL
, Blocked.session_id AS BlockedSessionId
, BlockedSess.login_name AS BlockedUser
, BlockedSess.host_name AS BlockedLocation
, BlockedSQL.text AS BlockedSQL
, SUBSTRING (BlockedSQL.text, (BlockedReq.statement_start_offset/2) + 1,
((CASE WHEN BlockedReq.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), BlockedSQL.text)) * 2
ELSE BlockedReq.statement_end_offset
END - BlockedReq.statement_start_offset)/2) + 1)
AS [Blocked Individual Query]
, Waits.wait_type
FROM sys.dm_exec_connections AS Blocking
INNER JOIN sys.dm_exec_requests AS Blocked
ON Blocking.session_id = Blocked.blocking_session_id
INNER JOIN sys.dm_exec_sessions Sess
ON Blocking.session_id = sess.session_id
INNER JOIN sys.dm_tran_session_transactions st
ON Blocking.session_id = st.session_id
LEFT OUTER JOIN sys.dm_exec_requests er
ON st.session_id = er.session_id
INNER JOIN sys.dm_os_waiting_tasks AS Waits
ON Blocked.session_id = Waits.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)
AS BlockingSQL
INNER JOIN sys.dm_exec_requests AS BlockedReq
ON Waits.session_id = BlockedReq.session_id
INNER JOIN sys.dm_exec_sessions AS BlockedSess
ON Waits.session_id = BlockedSess.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQL
ORDER BY WaitInSeconds



#>}
#----------------------------------------------------
#  2648 Listing 8.15 What has been blocked for more than 30 seconds p.220
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
Waits.wait_duration_ms / 1000 AS WaitInSeconds
, Blocking.session_id as BlockingSessionId
, Sess.login_name AS BlockingUser
, Sess.host_name AS BlockingLocation
, BlockingSQL.text AS BlockingSQL
, Blocked.session_id AS BlockedSessionId
, BlockedSess.login_name AS BlockedUser
, BlockedSess.host_name AS BlockedLocation
, BlockedSQL.text AS BlockedSQL
, DB_NAME(Blocked.database_id) AS DatabaseName
FROM sys.dm_exec_connections AS Blocking
INNER JOIN sys.dm_exec_requests AS Blocked
ON Blocking.session_id = Blocked.blocking_session_id
INNER JOIN sys.dm_exec_sessions Sess
ON Blocking.session_id = sess.session_id
INNER JOIN sys.dm_tran_session_transactions st
ON Blocking.session_id = st.session_id
LEFT OUTER JOIN sys.dm_exec_requests er
ON st.session_id = er.session_id
AND er.session_id IS NULL
INNER JOIN sys.dm_os_waiting_tasks AS Waits
ON Blocked.session_id = Waits.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocking.most_recent_sql_handle)
AS BlockingSQL
INNER JOIN sys.dm_exec_requests AS BlockedReq
ON Waits.session_id = BlockedReq.session_id
INNER JOIN sys.dm_exec_sessions AS BlockedSess
ON Waits.session_id = BlockedSess.session_id
CROSS APPLY sys.dm_exec_sql_text(Blocked.sql_handle) AS BlockedSQL
WHERE Waits.wait_duration_ms > 30000
ORDER BY WaitInSeconds



#>}

8.12 Lock escalation  p.222
8.13 How to reduce blocking  p.222
8.14 How to reduce deadlocks
8.15 Summary p.226

#----------------------------------------------------
#  2695 Listing 9.1 Amount of space (total, used, and free) in tempdb  p.229
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT SUM(user_object_reserved_page_count
+ internal_object_reserved_page_count
+ version_store_reserved_page_count
+ mixed_extent_page_count
+ unallocated_extent_page_count) * (8.0/1024.0)
AS [TotalSizeOfTempDB(MB)]
, SUM(user_object_reserved_page_count
+ internal_object_reserved_page_count
+ version_store_reserved_page_count
+ mixed_extent_page_count) * (8.0/1024.0)
AS [UsedSpace (MB)]
, SUM(unallocated_extent_page_count * (8.0/1024.0))
AS [FreeSpace (MB)]
FROM sys.dm_db_file_space_usage



#>}
#----------------------------------------------------
#  2719 Listing 9.2 Total amount of space (data, log, and log used) by database p.230
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT instance_name
, counter_name
, cntr_value / 1024.0 AS [Size(MB)]
FROM sys.dm_os_performance_counters
WHERE object_name = 'SQLServer:Databases'
AND counter_name IN (
'Data File(s) Size (KB)'
, 'Log File(s) Size (KB)'
, 'Log File(s) Used Size (KB)')
ORDER BY instance_name, counter_name




#>}
#----------------------------------------------------
#  2740 Listing 9.3 Tempdb total space usage by object type p.231 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
SUM (user_object_reserved_page_count) * (8.0/1024.0)
AS [User Objects (MB)],
SUM (internal_object_reserved_page_count) * (8.0/1024.0)
AS [Internal Objects (MB)],
SUM (version_store_reserved_page_count) * (8.0/1024.0)
AS [Version Store (MB)],
SUM (mixed_extent_page_count)* (8.0/1024.0)
AS [Mixed Extent (MB)],
SUM (unallocated_extent_page_count)* (8.0/1024.0)
AS [Unallocated (MB)]
FROM sys.dm_db_file_space_usage

#>}
#----------------------------------------------------
#  2760 Listing 9.4 Space usage by session
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT es.session_id
, ec.connection_id
, es.login_name
, es.host_name
, st.text
, su.user_objects_alloc_page_count
, su.user_objects_dealloc_page_count
, su.internal_objects_alloc_page_count
, su.internal_objects_dealloc_page_count
, ec.last_read
, ec.last_write
, es.program_name
FROM sys.dm_db_session_space_usage su
INNER JOIN sys.dm_exec_sessions es
ON su.session_id = es.session_id
LEFT OUTER JOIN sys.dm_exec_connections ec
ON su.session_id = ec.most_recent_session_id
OUTER APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) st
WHERE su.session_id > 50



#>}
#----------------------------------------------------
#  2789 Listing 9.5 Space used and reclaimed in tempdb for completed batches p.234
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT CAST(SUM(su.user_objects_alloc_page_count
+ su.internal_objects_alloc_page_count) * (8.0/1024.0)
AS DECIMAL(20,3)) AS [SpaceUsed(MB)]
, CAST(SUM(su.user_objects_alloc_page_count
– su.user_objects_dealloc_page_count
+ su.internal_objects_alloc_page_count
– su.internal_objects_dealloc_page_count)
* (8.0/1024.0) AS DECIMAL(20,3)) AS [SpaceStillUsed(MB)]
, su.session_id
, ec.connection_id
, es.login_name
, es.host_name
, st.text AS [LastQuery]
, ec.last_read
, ec.last_write
, es.program_name
FROM sys.dm_db_session_space_usage su
INNER JOIN sys.dm_exec_sessions es ON su.session_id = es.session_id
LEFT OUTER JOIN sys.dm_exec_connections ec
ON su.session_id = ec.most_recent_session_id
OUTER APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) st
WHERE su.session_id > 50
GROUP BY su.session_id, ec.connection_id, es.login_name, es.host_name
, st.text, ec.last_read, ec.last_write, es.program_name
ORDER BY [SpaceStillUsed(MB)] DESC

#>}
#----------------------------------------------------
#  2822 Listing 9.6 Space usage by task
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT es.session_id
, ec.connection_id
, es.login_name
, es.host_name
, st.text
, tu.user_objects_alloc_page_count
, tu.user_objects_dealloc_page_count
, tu.internal_objects_alloc_page_count
, tu.internal_objects_dealloc_page_count
, ec.last_read
, ec.last_write
, es.program_name
FROM sys.dm_db_task_space_usage tu
INNER JOIN sys.dm_exec_sessions es ON tu.session_id = es.session_id
LEFT OUTER JOIN sys.dm_exec_connections ec
ON tu.session_id = ec.most_recent_session_id
OUTER APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) st
WHERE tu.session_id > 50


#>}
#----------------------------------------------------
#  2849 Listing 9.7 Space used and not reclaimed in tempdb for active batches
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT SUM(ts.user_objects_alloc_page_count
+ ts.internal_objects_alloc_page_count)
* (8.0/1024.0) AS [SpaceUsed(MB)]
, SUM(ts.user_objects_alloc_page_count
– ts.user_objects_dealloc_page_count
+ ts.internal_objects_alloc_page_count
– ts.internal_objects_dealloc_page_count)
* (8.0/1024.0) AS [SpaceStillUsed(MB)]
, ts.session_id
, ec.connection_id
, es.login_name
, es.host_name
, st.text AS [Parent Query]
, SUBSTRING (st.text,(er.statement_start_offset/2) + 1,
((CASE WHEN er.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), st.text)) * 2
ELSE er.statement_end_offset
END - er.statement_start_offset)/2) + 1) AS [Current Query]
, ec.last_read
, ec.last_write
, es.program_name
FROM sys.dm_db_task_space_usage ts
INNER JOIN sys.dm_exec_sessions es ON ts.session_id = es.session_id
LEFT OUTER JOIN sys.dm_exec_connections ec
ON ts.session_id = ec.most_recent_session_id
OUTER APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) st
LEFT OUTER JOIN sys.dm_exec_requests er ON ts.session_id = er.session_id
WHERE ts.session_id > 50
GROUP BY ts.session_id, ec.connection_id, es.login_name, es.host_name
, st.text, ec.last_read, ec.last_write, es.program_name
, SUBSTRING (st.text,(er.statement_start_offset/2) + 1,
((CASE WHEN er.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), st.text)) * 2
ELSE er.statement_end_offset
END - er.statement_start_offset)/2) + 1)
ORDER BY [SpaceStillUsed(MB)] DESC

#>}
#----------------------------------------------------
#  2893  9.4  Tempdb recommendations  p.240 
#----------------------------------------------------
{<#




#>}
#----------------------------------------------------
#   2902  9.5 Index contention
#----------------------------------------------------
{<#



#>}
#----------------------------------------------------
#  2910 Listing 9.8 Indexes under the most row-locking pressure p.242 
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
x.name AS SchemaName
, OBJECT_NAME(s.object_id) AS TableName
, i.name AS IndexName
, s.row_lock_wait_in_ms
, s.row_lock_wait_count
FROM sys.dm_db_index_operational_stats(db_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.row_lock_wait_in_ms > 0
AND o.is_ms_shipped = 0
ORDER BY s.row_lock_wait_in_ms DESC
#>}


#----------------------------------------------------
#  2938 Listing 9.9 Indexes with the most lock escalations  p.244
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


SELECT TOP 20
x.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.index_lock_promotion_count
FROM sys.dm_db_index_operational_stats(db_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.index_lock_promotion_count > 0
AND o.is_ms_shipped = 0
ORDER BY s.index_lock_promotion_count DESC


#>}

#----------------------------------------------------
#  2966 Listing 9.10 Indexes with the most unsuccessful lock escalations p.245
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
x.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.index_lock_promotion_attempt_count – s.index_lock_promotion_count
AS UnsuccessfulIndexLockPromotions
FROM sys.dm_db_index_operational_stats(db_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE (s.index_lock_promotion_attempt_count - index_lock_promotion_count)>0
AND o.is_ms_shipped = 0
ORDER BY UnsuccessfulIndexLockPromotions DESC

#>}



#----------------------------------------------------
#   2990 Listing 9.11 Indexes with the most page splits  p.247 
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
x.name AS SchemaName
, object_name(s.object_id) AS TableName
, i.name AS IndexName
, s.leaf_allocation_count
, s.nonleaf_allocation_count
FROM sys.dm_db_index_operational_stats(DB_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.leaf_allocation_count > 0
AND o.is_ms_shipped = 0
ORDER BY s.leaf_allocation_count DESC


#>}



#----------------------------------------------------
#  3015 Listing 9.12 Indexes with the most latch contention p.248 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
x.name AS SchemaName
, OBJECT_NAME(s.object_id) AS TableName
, i.name AS IndexName
, s.page_latch_wait_in_ms
, s.page_latch_wait_count
FROM sys.dm_db_index_operational_stats(db_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.page_latch_wait_in_ms > 0
AND o.is_ms_shipped = 0
ORDER BY s.page_latch_wait_in_ms DESC

#>}



#----------------------------------------------------
#  3040  Listing 9.13 Indexes with the most page I/O-latch contention p.250 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
x.name AS SchemaName
, OBJECT_NAME(s.object_id) AS TableName
, i.name AS IndexName
, s.page_io_latch_wait_count
, s.page_io_latch_wait_in_ms
FROM sys.dm_db_index_operational_stats(db_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.page_io_latch_wait_in_ms > 0
AND o.is_ms_shipped = 0
ORDER BY s.page_io_latch_wait_in_ms DESC


#>}



#----------------------------------------------------
#   3066  Listing 9.14 Indexes under the most row-locking pressure—snapshot version p.251
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT x.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.row_lock_wait_in_ms
INTO #PreWorkIndexCount
FROM sys.dm_db_index_operational_stats(DB_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.row_lock_wait_in_ms > 0
AND o.is_ms_shipped = 0
SELECT sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
WAITFOR DELAY '01:00:00'
SELECT x.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.row_lock_wait_in_ms
INTO #PostWorkIndexCount
FROM sys.dm_db_index_operational_stats(DB_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE s.row_lock_wait_in_ms > 0
AND o.is_ms_shipped = 0
SELECT sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.SchemaName
, p2.TableName
, p2.IndexName
, p2.row_lock_wait_in_ms - ISNULL(p1.row_lock_wait_in_ms, 0)
AS RowLockWaitTimeDelta_ms
FROM #PreWorkIndexCount p1
RIGHT OUTER JOIN
#PostWorkIndexCount p2 ON p2.SchemaName =
ISNULL(p1.SchemaName, p2.SchemaName)
AND p2.TableName = ISNULL(p1.TableName, p2.TableName)
AND p2.IndexName = ISNULL(p1.IndexName, p2.IndexName)
WHERE p2.row_lock_wait_in_ms - ISNULL(p1.row_lock_wait_in_ms, 0) > 0
ORDER BY RowLockWaitTimeDelta_ms DESC
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) –
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND qt.text NOT LIKE '--ThisRoutineIdentifier%'
ORDER BY [Duration] DESC
DROP TABLE #PreWorkIndexCount
DROP TABLE #PostWorkIndexCount
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot

#>}



#----------------------------------------------------
#  3161 Listing 9.15 Determining how many rows are inserted/deleted/updated/selected  p.254
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT x.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.leaf_delete_count
, s.leaf_ghost_count
, s.leaf_insert_count
, s.leaf_update_count
, s.range_scan_count
, s.singleton_lookup_count
INTO #PreWorkIndexCount
FROM sys.dm_db_index_operational_stats(DB_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE o.is_ms_shipped = 0
WAITFOR DELAY '01:00:00'
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT x.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.leaf_delete_count
, s.leaf_ghost_count
, s.leaf_insert_count
, s.leaf_update_count
, s.range_scan_count
, s.singleton_lookup_count
INTO #PostWorkIndexCount
FROM sys.dm_db_index_operational_stats(DB_ID(), NULL, NULL, NULL) s
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.indexes i ON s.index_id = i.index_id
AND i.object_id = o.object_id
INNER JOIN sys.schemas x ON x.schema_id = o.schema_id
WHERE o.is_ms_shipped = 0
SELECT
p2.SchemaName
, p2.TableName
, p2.IndexName
, p2.leaf_delete_count - ISNULL(p1.leaf_delete_count, 0)
AS leaf_delete_countDelta
, p2.leaf_ghost_count - ISNULL(p1.leaf_ghost_count, 0)
AS leaf_ghost_countDelta
, p2.leaf_insert_count - ISNULL(p1.leaf_insert_count, 0)
AS leaf_insert_countDelta
, p2.leaf_update_count - ISNULL(p1.leaf_update_count, 0)
AS leaf_update_countDelta
, p2.range_scan_count - ISNULL(p1.range_scan_count, 0)
AS range_scan_countDelta
, p2.singleton_lookup_count - ISNULL(p1.singleton_lookup_count, 0)
AS singleton_lookup_countDelta
FROM #PreWorkIndexCount p1
RIGHT OUTER JOIN
#PostWorkIndexCount p2 ON p2.SchemaName =
ISNULL(p1.SchemaName, p2.SchemaName)
AND p2.TableName = ISNULL(p1.TableName, p2.TableName)
AND p2.IndexName = ISNULL(p1.IndexName, p2.IndexName)
WHERE p2.leaf_delete_count - ISNULL(p1.leaf_delete_count, 0) > 0
OR p2.leaf_ghost_count - ISNULL(p1.leaf_ghost_count, 0) > 0
OR p2.leaf_insert_count - ISNULL(p1.leaf_insert_count, 0) > 0
OR p2.leaf_update_count - ISNULL(p1.leaf_update_count, 0) > 0
OR p2.range_scan_count - ISNULL(p1.range_scan_count, 0) > 0
OR p2.singleton_lookup_count - ISNULL(p1.singleton_lookup_count, 0) > 0
ORDER BY leaf_delete_countDelta DESC
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) –
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
ORDER BY [Duration] DESC
DROP TABLE #PreWorkIndexCount
DROP TABLE #PostWorkIndexCount
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
#>}



#----------------------------------------------------
#  3278  Listing 10.1 CLR function to extract the routine name p.160
#----------------------------------------------------
{<#

using System;
using Microsoft.SqlServer.Server;
public partial class UserDefinedFunctions
{
[SqlFunction(IsDeterministic = true, DataAccess = DataAccessKind.None)]
public static String ExtractSQLRoutineName(String sSource)
{
int _routineStartOffset;
int _firstSpaceOffset;
int _endOfRoutineNameOffset;
if (String.IsNullOrEmpty(sSource) == true)
return null;
}
_routineStartOffset = sSource.IndexOf("CREATE PROC",
StringComparison.CurrentCultureIgnoreCase);
if (_routineStartOffset == -1)
{
_routineStartOffset = sSource.IndexOf("CREATE FUNC",
StringComparison.CurrentCultureIgnoreCase);
}
if (_routineStartOffset == -1)
{
return null;
}
_routineStartOffset = _routineStartOffset + "CREATE FUNC".Length;
_firstSpaceOffset = sSource.IndexOf(" ", _routineStartOffset);
for (int i = _firstSpaceOffset; i < (sSource.Length - 1); i++)
{
if (sSource.Substring(i, 1) != " ")
{
_firstSpaceOffset = i;
break;
}
}
_endOfRoutineNameOffset = sSource.IndexOfAny(new char[] { ' ',
'(', '\t', '\r', '\n' }, _firstSpaceOffset + 1);
if (_endOfRoutineNameOffset > _routineStartOffset)
{
return sSource.Substring(_firstSpaceOffset,
(_endOfRoutineNameOffset - _firstSpaceOffset));
}
else
return null;
}
};
#>}

#----------------------------------------------------
#  3330 Listing 10.2 Recompile routines that are running slower than normal p.262 
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 100
qs.execution_count AS [Runs]
, (qs.total_worker_time - qs.last_worker_time) /
(qs.execution_count - 1) AS [Avg time]
, qs.last_worker_time AS [Last time]
, (qs.last_worker_time - ((qs.total_worker_time - qs.last_worker_time)
/ (qs.execution_count - 1))) AS [Time Deviation]
, CASE WHEN qs.last_worker_time = 0
THEN 100
ELSE (qs.last_worker_time - ((qs.total_worker_time –
qs.last_worker_time) / (qs.execution_count - 1))) * 100
END
/ (((qs.total_worker_time - qs.last_worker_time)
/ (qs.execution_count - 1))) AS [% Time Deviation]
, qs.last_logical_reads + qs.last_logical_writes
+ qs.last_physical_reads AS [Last IO]
, ((qs.total_logical_reads + qs.total_logical_writes +
qs.total_physical_reads) - (qs.last_logical_reads +
qs.last_logical_writes + qs.last_physical_reads))
/ (qs.execution_count - 1) AS [Avg IO]
, SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS [DatabaseName]
INTO #SlowQueries
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) qt
WHERE qs.execution_count > 1
AND qs.total_worker_time != qs.last_worker_time
ORDER BY [% Time Deviation] DESC
SELECT TOP 100 [Runs]
, [Avg time]
, [Last time]
, [Time Deviation]
, [% Time Deviation]
, [Last IO]
, [Avg IO]
, [Last IO] - [Avg IO] AS [IO Deviation]
, CASE WHEN [Avg IO] = 0
THEN 0
ELSE ([Last IO]- [Avg IO]) * 100 / [Avg IO]
END AS [% IO Deviation]
, [Individual Query]
, [Parent Query]
, [DatabaseName]
INTO #SlowQueriesByIO
FROM #SlowQueries
ORDER BY [% Time Deviation] DESC
SELECT TOP 100
[Runs]
, [Avg time]
, [Last time]
, [Time Deviation]
, [% Time Deviation]
, [Last IO]
, [Avg IO]
, [IO Deviation]
, [% IO Deviation]
, [Impedance] = [% Time Deviation] - [% IO Deviation]
, [Individual Query]
, [Parent Query]
, [DatabaseName]
INTO #QueriesRunningSlowerThanNormal
FROM #SlowQueriesByIO
WHERE [% Time Deviation] - [% IO Deviation] > 20
ORDER BY [Impedance] DESC
SELECT DISTINCT
' EXEC sp_recompile ' + '''' + '[' + [DatabaseName] + '].'
+ dbo.ExtractSQLRoutineName([Parent Query]) + ''''
AS recompileRoutineSQL
INTO #RecompileQuery
FROM #QueriesRunningSlowerThanNormal
WHERE [DatabaseName] NOT IN ('master', 'msdb', '')
DECLARE @RecompilationSQL NVARCHAR(MAX)
SET @RecompilationSQL = ''
SELECT @RecompilationSQL = @RecompilationSQL
+ recompileRoutineSQL + CHAR(10)
FROM #RecompileQuery
WHERE recompileRoutineSQL IS NOT NULL
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@RecompilationSQL))
BEGIN
PRINT SUBSTRING(@RecompilationSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@RecompilationSQL, @StartOffset, @Length)
EXECUTE sp_executesql @RecompilationSQL
DROP TABLE #SlowQueries
DROP TABLE #SlowQueriesByIO
DROP TABLE #QueriesRunningSlowerThanNormal
DROP TABLE #RecompileQuery
#>}


#----------------------------------------------------
#  3435  Listing 10.3   Rebuilding and reorganizing fragmented indexes
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
CREATE TABLE #FragmentedIndexes(
DatabaseName SYSNAME
, SchemaName SYSNAME
, TableName SYSNAME
, IndexName SYSNAME
, [Fragmentation%] FLOAT)
INSERT INTO #FragmentedIndexes
SELECT
DB_NAME(DB_ID()) AS DatabaseName
, ss.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.avg_fragmentation_in_percent AS [Fragmentation%]
FROM sys.dm_db_index_physical_stats(db_id(),NULL, NULL, NULL, 'SAMPLED') s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.schemas ss ON ss.[schema_id] = o.[schema_id]
WHERE s.database_id = DB_ID()
AND i.index_id != 0
AND s.record_count > 0
AND o.is_ms_shipped = 0
DECLARE @RebuildIndexesSQL NVARCHAR(MAX)
SET @RebuildIndexesSQL = ''
SELECT
@RebuildIndexesSQL = @RebuildIndexesSQL +
CASE
WHEN [Fragmentation%] > 30
THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
+ QUOTENAME(SchemaName) + '.'
+ QUOTENAME(TableName) + ' REBUILD;'
WHEN [Fragmentation%] > 10
THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
+ QUOTENAME(SchemaName) + '.'
+ QUOTENAME(TableName) + ' REORGANIZE;'
END
FROM #FragmentedIndexes
WHERE [Fragmentation%] > 10
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@RebuildIndexesSQL))
BEGIN
PRINT SUBSTRING(@RebuildIndexesSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@RebuildIndexesSQL, @StartOffset, @Length)
EXECUTE sp_executesql @RebuildIndexesSQL
DROP TABLE #FragmentedIndexes

#>}


#----------------------------------------------------
#  3494 Listing 10.4 Rebuild/reorganize for all databases on a given server  p.268 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
CREATE TABLE #FragmentedIndexes(
DatabaseName SYSNAME
, SchemaName SYSNAME
, TableName SYSNAME
, IndexName SYSNAME
, [Fragmentation%] FLOAT)
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #FragmentedIndexes
SELECT
DB_NAME(DB_ID()) AS DatabaseName
, ss.name AS SchemaName
, OBJECT_NAME (s.object_id) AS TableName
, i.name AS IndexName
, s.avg_fragmentation_in_percent AS [Fragmentation%]
FROM sys.dm_db_index_physical_stats(db_id(),NULL, NULL, NULL,
''SAMPLED'') s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.schemas ss ON ss.[schema_id] = o.[schema_id]
WHERE s.database_id = DB_ID()
AND i.index_id != 0
AND s.record_count > 0
AND o.is_ms_shipped = 0
;'
DECLARE @RebuildIndexesSQL NVARCHAR(MAX)
SET @RebuildIndexesSQL = ''
SELECT
@RebuildIndexesSQL = @RebuildIndexesSQL +
CASE
WHEN [Fragmentation%] > 30
THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
+ QUOTENAME(DatabaseName) + '.'+ QUOTENAME(SchemaName) + '.'
+ QUOTENAME(TableName) + ' REBUILD;'
WHEN [Fragmentation%] > 10
THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
+ QUOTENAME(DatabaseName) + '.'+ QUOTENAME(SchemaName) + '.'
+ QUOTENAME(TableName) + ' REORGANIZE;'
END
FROM #FragmentedIndexes
WHERE [Fragmentation%] > 10
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@RebuildIndexesSQL))
BEGIN
PRINT SUBSTRING(@RebuildIndexesSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@RebuildIndexesSQL, @StartOffset, @Length)
EXECUTE sp_executesql @RebuildIndexesSQL
DROP TABLE #FragmentedIndexes
#>}


#----------------------------------------------------
#  3556 Listing 10.5 Intelligently update statistics—simple version p.270 
#----------------------------------------------------
{<#
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
ss.name AS SchemaName
, st.name AS TableName
, si.name AS IndexName
, si.type_desc AS IndexType
, STATS_DATE(si.object_id,si.index_id) AS StatsLastTaken
, ssi.rowcnt
, ssi.rowmodctr
INTO #IndexUsage
FROM sys.indexes si
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE st.is_ms_shipped = 0
AND si.index_id != 0
AND ssi.rowcnt > 100
AND ssi.rowmodctr > 0
DECLARE @UpdateStatisticsSQL NVARCHAR(MAX)
SET @UpdateStatisticsSQL = ''
SELECT
@UpdateStatisticsSQL = @UpdateStatisticsSQL
+ CHAR(10) + 'UPDATE STATISTICS '
+ QUOTENAME(SchemaName) + '.' + QUOTENAME(TableName)
+ ' ' + QUOTENAME(IndexName) + ' WITH SAMPLE '
+ CASE
WHEN rowcnt < 500000 THEN '100 PERCENT'
WHEN rowcnt < 1000000 THEN '50 PERCENT'
WHEN rowcnt < 5000000 THEN '25 PERCENT'
WHEN rowcnt < 10000000 THEN '10 PERCENT'
WHEN rowcnt < 50000000 THEN '2 PERCENT'
WHEN rowcnt < 100000000 THEN '1 PERCENT'
ELSE '3000000 ROWS '
END
+ '-- ' + CAST(rowcnt AS VARCHAR(22)) + ' rows'
FROM #IndexUsage
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@UpdateStatisticsSQL))
BEGIN
PRINT SUBSTRING(@UpdateStatisticsSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@UpdateStatisticsSQL, @StartOffset, @Length)
EXECUTE sp_executesql @UpdateStatisticsSQL
DROP TABLE #IndexUsage

#>}




#----------------------------------------------------
#  3615 Listing 10.6 Intelligently update statistics—time-based version p.273
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
IF EXISTS
(SELECT 1
FROM sys.indexes si
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE st.is_ms_shipped = 0
AND si.index_id != 0
AND ssi.rowcnt > 100
AND ssi.rowmodctr > 0)
BEGIN
DECLARE @StatsMarker NVARCHAR(2000)
DECLARE @SamplingComplete BIT
DECLARE @RowsToBenchMark BIGINT
SET @RowsToBenchMark = 500
SET @SamplingComplete = 0
DECLARE @TotalStatsTime BIGINT
DECLARE @StartTime DATETIME
DECLARE @TimePerRow FLOAT
WHILE (@SamplingComplete = 0)
BEGIN
SELECT TOP 1 @StatsMarker = 'UPDATE STATISTICS '
+ QUOTENAME(ss.name) + '.' + QUOTENAME(st.name)
+ ' ' + QUOTENAME(si.name) + ' WITH SAMPLE '
+ CAST(@RowsToBenchMark AS VARCHAR(22)) + ' ROWS'
FROM sys.indexes si
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE st.is_ms_shipped = 0 -- User tables only
AND si.index_id != 0 -- ignore heaps
AND ssi.rowcnt > @RowsToBenchMark
ORDER BY ssi.rowcnt
IF @@ROWCOUNT > 0
BEGIN
PRINT 'Testing sampling time with: ' + @StatsMarker
SET @StartTime = GETDATE()
EXECUTE sp_executesql @StatsMarker
SET @TotalStatsTime = DATEDIFF(SECOND, @StartTime, GETDATE())
PRINT '@TotalStatsTime: ' + CAST(@TotalStatsTime AS VARCHAR(22))
IF (@TotalStatsTime > 5)
BEGIN
SET @TimePerRow = @TotalStatsTime /
(@RowsToBenchMark * 1.0)
PRINT @TimePerRow
SET @SamplingComplete = 1
END
ELSE
SET @RowsToBenchMark = @RowsToBenchMark * 10
END
ELSE
BEGIN
DECLARE @ErrorMsg VARCHAR(200)
SET @ErrorMsg = 'No indexes found with @RowsToBenchMark > '
+ CAST(@RowsToBenchMark AS VARCHAR(22))
RAISERROR(@ErrorMsg, 16, 1)
RETURN
END
END
DECLARE @RowsToSample BIGINT
SET @RowsToSample = 0
SELECT
ss.name AS SchemaName
, st.name AS TableName
, si.name AS IndexName
, si.type_desc AS IndexType
, STATS_DATE(si.object_id,si.index_id) AS StatsLastTaken
, ssi.rowcnt
, ssi.rowmodctr
, @RowsToSample AS RowsToSample
INTO #IndexUsage
FROM sys.indexes si
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE st.is_ms_shipped = 0
AND si.index_id != 0
AND ssi.rowcnt > 100
AND ssi.rowmodctr > 0
DECLARE @MaxSamplingTimeInSeconds INT
SET @MaxSamplingTimeInSeconds = 600 -- 10 mins
DECLARE @WorkIsWithinTimeLimit BIT
SET @WorkIsWithinTimeLimit = 0
DECLARE @TotalTimeForAllStats INT
DECLARE @ReduceFraction FLOAT
SET @ReduceFraction = 1.0
DECLARE @ReduceFractionSmall FLOAT
SET @ReduceFractionSmall = 1.0
UPDATE #IndexUsage
SET RowsToSample =
CASE
WHEN rowcnt < 100000000 THEN rowcnt
ELSE 3000000
END
WHILE (@WorkIsWithinTimeLimit = 0)
BEGIN
UPDATE #IndexUsage
SET RowsToSample =
CASE
WHEN rowcnt < 500000 THEN rowcnt * @ReduceFractionSmall
WHEN rowcnt < 1000000 THEN rowcnt / 2 * @ReduceFractionSmall
WHEN rowcnt < 5000000 THEN rowcnt / 4 * @ReduceFractionSmall
WHEN rowcnt < 10000000 THEN rowcnt / 10 * @ReduceFraction
WHEN rowcnt < 50000000 THEN rowcnt / 50 * @ReduceFraction
WHEN rowcnt < 100000000 THEN rowcnt / 100 * @ReduceFraction
ELSE 3000000 * @ReduceFraction
END
SELECT @TotalTimeForAllStats = SUM(RowsToSample) * @TimePerRow
FROM #IndexUsage
PRINT '@TotalTimeForAllStats: '
+ CAST(@TotalTimeForAllStats AS VARCHAR(22))
IF (@TotalTimeForAllStats < @MaxSamplingTimeInSeconds)
SET @WorkIsWithinTimeLimit = 1
ELSE
BEGIN
SET @ReduceFraction = @ReduceFraction - 0.01
SET @ReduceFractionSmall = @ReduceFractionSmall - 0.001
END
END
DECLARE @UpdateStatisticsSQL NVARCHAR(MAX)
SET @UpdateStatisticsSQL = ''
SELECT
@UpdateStatisticsSQL = @UpdateStatisticsSQL
+ CHAR(10) + 'UPDATE STATISTICS ' + QUOTENAME(SchemaName)
+ '.' + QUOTENAME(TableName)
+ ' ' + QUOTENAME(IndexName) + ' WITH SAMPLE '
+ CAST(RowsToSample AS VARCHAR(22)) + ' ROWS '
FROM #IndexUsage
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@UpdateStatisticsSQL))
BEGIN
PRINT SUBSTRING(@UpdateStatisticsSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@UpdateStatisticsSQL, @StartOffset, @Length)
EXECUTE sp_executesql @UpdateStatisticsSQL
DROP TABLE #IndexUsage
END
#>}




#----------------------------------------------------
#   3770 Listing 10.7 Update statistics used by a SQL routine or a time interval p.277
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
SchemaName = ss.name
, TableName = st.name
, IndexName = si.name
, si.type_desc AS IndexType
, user_updates = ISNULL(ius.user_updates, 0)
, user_seeks = ISNULL(ius.user_seeks, 0)
, user_scans = ISNULL(ius.user_scans, 0)
, user_lookups = ISNULL(ius.user_lookups, 0)
, ssi.rowcnt
, ssi.rowmodctr
INTO #IndexStatsPre
FROM sys.dm_db_index_usage_stats ius
RIGHT OUTER JOIN sys.indexes si ON ius.[object_id] = si.[object_id]
AND ius.index_id = si.index_id
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE ius.database_id = DB_ID()
AND st.is_ms_shipped = 0
WAITFOR DELAY '00:10:00'
SELECT
SchemaName = ss.name
, TableName = st.name
, IndexName = si.name
, si.type_desc AS IndexType
, user_updates = ISNULL(ius.user_updates, 0)
, user_seeks = ISNULL(ius.user_seeks, 0)
, user_scans = ISNULL(ius.user_scans, 0)
, user_lookups = ISNULL(ius.user_lookups, 0)
, ssi.rowcnt
, ssi.rowmodctr
INTO #IndexStatsPost
FROM sys.dm_db_index_usage_stats ius
RIGHT OUTER JOIN sys.indexes si ON ius.[object_id] = si.[object_id]
AND ius.index_id = si.index_id
INNER JOIN sys.sysindexes ssi ON si.object_id = ssi.id
AND si.name = ssi.name
INNER JOIN sys.tables st ON st.[object_id] = si.[object_id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
WHERE ius.database_id = DB_ID()
AND st.is_ms_shipped = 0
SELECT
po.[SchemaName]
, po.[TableName]
, po.[IndexName]
, po.rowcnt
, po.[IndexType]
, [User Updates] = po.user_updates - ISNULL(pr.user_updates, 0)
, [User Seeks] = po.user_seeks - ISNULL(pr.user_seeks, 0)
, [User Scans] = po.user_scans - ISNULL(pr.user_scans, 0)
, [User Lookups] = po.user_lookups - ISNULL(pr.user_lookups, 0)
, [Rows Inserted] = po.rowcnt - ISNULL(pr.rowcnt, 0)
, [Updates I/U/D] = po.rowmodctr - ISNULL(pr.rowmodctr, 0)
INTO #IndexUsage
FROM #IndexStatsPost po
LEFT OUTER JOIN #IndexStatsPre pr ON pr.SchemaName = po.SchemaName
AND pr.TableName = po.TableName
AND pr.IndexName = po.IndexName
AND pr.IndexType = po.IndexType
WHERE ISNULL(pr.user_updates, 0) != po.user_updates
OR ISNULL(pr.user_seeks, 0) != po.user_seeks
OR ISNULL(pr.user_scans, 0) != po.user_scans
OR ISNULL(pr.user_lookups, 0) != po.user_lookups
DECLARE @UpdateStatisticsSQL NVARCHAR(MAX)
SET @UpdateStatisticsSQL = ''
SELECT
@UpdateStatisticsSQL = @UpdateStatisticsSQL
+ CHAR(10) + 'UPDATE STATISTICS ' + QUOTENAME(SchemaName)
+ '.' + QUOTENAME(TableName)
+ ' ' + QUOTENAME(IndexName) + ' WITH SAMPLE '
+ CASE
WHEN rowcnt < 500000 THEN '100 PERCENT'
WHEN rowcnt < 1000000 THEN '50 PERCENT'
WHEN rowcnt < 5000000 THEN '25 PERCENT'
WHEN rowcnt < 10000000 THEN '10 PERCENT'
WHEN rowcnt < 50000000 THEN '2 PERCENT'
WHEN rowcnt < 100000000 THEN '1 PERCENT'
ELSE '3000000 ROWS '
END
FROM #IndexUsage
WHERE [User Seeks] != 0 OR [User Scans] != 0 OR [User Lookups] != 0
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@UpdateStatisticsSQL))
BEGIN
PRINT SUBSTRING(@UpdateStatisticsSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@UpdateStatisticsSQL, @StartOffset, @Length)
EXECUTE sp_executesql @UpdateStatisticsSQL
DROP TABLE #IndexStatsPre
DROP TABLE #IndexStatsPost
DROP TABLE #IndexUsage
#>}



#----------------------------------------------------
#   3877 Listing 10.8 Automatically create any missing indexes
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT TOP 20
'CREATE NONCLUSTERED INDEX '
+ QUOTENAME('IX_AutoGenerated_'
+ REPLACE(REPLACE(CONVERT(VARCHAR(25), GETDATE(), 113)
, ' ', '_'), ':', '_')
+ '_' + CAST(d.index_handle AS VARCHAR(22))
)
+ ' ON ' + d.[statement] + '('
+ CASE
WHEN d.equality_columns IS NULL THEN d.inequality_columns
WHEN d.inequality_columns IS NULL THEN d.equality_columns
ELSE d.equality_columns + ',' + d.inequality_columns
END
+ ')'
+ CASE
WHEN d.included_columns IS NOT NULL THEN
' INCLUDE ( ' + d.included_columns + ')'
ELSE ''
END AS MissingIndexSQL
, ROUND(s.avg_total_user_cost * s.avg_user_impact
* (s.user_seeks + s.user_scans),0) AS [Total Cost]
, d.[statement] AS [Table Name]
, d.equality_columns
, d.inequality_columns
, d.included_columns
INTO #MissingIndexes
FROM sys.dm_db_missing_index_groups g
INNER JOIN sys.dm_db_missing_index_group_stats s
ON s.group_handle = g.index_group_handle
INNER JOIN sys.dm_db_missing_index_details d
ON d.index_handle = g.index_handle
ORDER BY [Total Cost] DESC
DECLARE @MissingIndexesSQL NVARCHAR(MAX)
SET @MissingIndexesSQL = ''
SELECT
@MissingIndexesSQL = @MissingIndexesSQL + MissingIndexSQL + CHAR(10)
FROM #MissingIndexes
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@MissingIndexesSQL))
BEGIN
PRINT SUBSTRING(@MissingIndexesSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@MissingIndexesSQL, @StartOffset, @Length)
EXECUTE sp_executesql @MissingIndexesSQL
DROP TABLE #MissingIndexes
#>}



#----------------------------------------------------
#  3936 Listing 10.9 Automatically disable or drop unused indexesp.283 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, s.user_updates
, s.system_seeks + s.system_scans + s.system_lookups
AS [System usage]
INTO #TempUnusedIndexes
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE 1=2
EXEC sp_MSForEachDB 'USE [?];
INSERT INTO #TempUnusedIndexes
SELECT TOP 20
DB_NAME() AS DatabaseName
, SCHEMA_NAME(o.Schema_ID) AS SchemaName
, OBJECT_NAME(s.[object_id]) AS TableName
, i.name AS IndexName
, s.user_updates
, s.system_seeks + s.system_scans + s.system_lookups
AS [System usage]
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON i.object_id = O.object_id
WHERE s.database_id = DB_ID()
AND OBJECTPROPERTY(s.[object_id], ''IsMsShipped'') = 0
AND user_seeks = 0
AND user_scans = 0
AND user_lookups = 0
AND i.name IS NOT NULL
ORDER BY user_updates DESC'
DECLARE @DisableOrDrop INT
SET @DisableOrDrop = 1
DECLARE @DisableIndexesSQL NVARCHAR(MAX)
SET @DisableIndexesSQL = ''
SELECT
@DisableIndexesSQL = @DisableIndexesSQL +
CASE
WHEN @DisableOrDrop = 1
THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
+ QUOTENAME(DatabaseName) + '.'+ QUOTENAME(SchemaName) + '.'
+ QUOTENAME(TableName) + ' DISABLE;'
ELSE CHAR(10) + 'DROP INDEX ' + QUOTENAME(IndexName) + ' ON '
+ QUOTENAME(DatabaseName) + '.'+ QUOTENAME(SchemaName) + '.'
+ QUOTENAME(TableName)
END
FROM #TempUnusedIndexes
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@DisableIndexesSQL))
BEGIN
PRINT SUBSTRING(@DisableIndexesSQL, @StartOffset, @Length)
SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@DisableIndexesSQL, @StartOffset, @Length)
EXECUTE sp_executesql @DisableIndexesSQL
DROP TABLE #TempUnusedIndexes
#>}



#----------------------------------------------------
#  4009  Listing 11.1 Finding everyone’s last-run query p.287 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT c.session_id, s.host_name, s.login_name, s.status
, st.text, s.login_time, s.program_name, *
FROM sys.dm_exec_connections c
INNER JOIN sys.dm_exec_sessions s ON c.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS st
ORDER BY c.session_id


#>}



#----------------------------------------------------
#   4027 Listing 11.2 Generic performance test harness p.289 
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
EXEC PutYourQueryHere
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) –
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time blocked]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2 ON p2.sql_handle =
ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
ORDER BY qt.text, p2.statement_start_offset
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
#>}



#----------------------------------------------------
#   4082 Listing 11.3 Determining the performance impact of a system upgrade p.291
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
total_elapsed_time, total_worker_time, total_logical_reads
, total_logical_writes, total_clr_time, execution_count
, statement_start_offset, statement_end_offset, sql_handle, plan_handle
INTO #prework
FROM sys.dm_exec_query_stats
EXEC PutYourWorkloadHere
SELECT
total_elapsed_time, total_worker_time, total_logical_reads
, total_logical_writes, total_clr_time, execution_count
, statement_start_offset, statement_end_offset, sql_handle, plan_handle
INTO #postwork
FROM sys.dm_exec_query_stats
SELECT
SUM(p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0))
AS [TotalDuration]
, SUM(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Total Time on CPU]
, SUM((p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) –
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0)))
AS [Total Time Waiting]
, SUM(p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0))
AS [TotalReads]
, SUM(p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0))
AS [TotalWrites]
, SUM(p2.total_clr_time - ISNULL(p1.total_clr_time, 0))
AS [Total CLR time]
, SUM(p2.execution_count - ISNULL(p1.execution_count, 0))
AS [Total Executions]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #prework p1
RIGHT OUTER JOIN
#postwork p2 ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
GROUP BY DB_NAME(qt.dbid)
SELECT
SUM(p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0))
AS [TotalDuration]
, SUM(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Total Time on CPU]
, SUM((p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0))
- (p2.total_worker_time - ISNULL(p1.total_worker_time, 0)))
AS [Total Time Waiting]
, SUM(p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0))
AS [TotalReads]
, SUM(p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0))
AS [TotalWrites]
, SUM(p2.total_clr_time - ISNULL(p1.total_clr_time, 0))
AS [Total CLR time]
, SUM(p2.execution_count - ISNULL(p1.execution_count, 0))
AS [Total Executions]
, DB_NAME(qt.dbid) AS DatabaseName
, qt.text AS [Parent Query]
FROM #prework p1
RIGHT OUTER JOIN
#postwork p2 ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
GROUP BY DB_NAME(qt.dbid), qt.text
ORDER BY [TotalDuration] DESC

SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)
AS [TotalDuration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0)
AS [Total Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0))
- (p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Total Time Waiting]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0)
AS [TotalReads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [TotalWrites]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [Total CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0)
AS [Total Executions]
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #prework p1
RIGHT OUTER JOIN
#postwork p2 ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
ORDER BY [TotalDuration] DESC
DROP TABLE #prework
DROP TABLE #postwork
#>}



#----------------------------------------------------
#  4236 Estimating the finishing time of system jobs
#----------------------------------------------------
{<#
■ALTER INDEX REORGANIZE
■ AUTO_SHRINK option with ALTER DATABASE
■ BACKUP DATABASE
■CREATE INDEX
■ DBCC CHECKDB
■ DBCC CHECKFILEGROUP
■ DBCC CHECKTABLE
■ DBCC INDEXDEFRAG
■ DBCC SHRINKDATABASE
■ DBCC SHRINKFILE
■ KILL (Transact-SQL)
■ RESTORE DATABASE
■ UPDATE STATISTICS

#>}

#----------------------------------------------------
#   4219 Listing 11.4 Estimating when a job will finish p.295
#----------------------------------------------------
{<#

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

#>}


#----------------------------------------------------
#   4247 11.5 Get system information from within SQL Server p.297 
#----------------------------------------------------
{<#


SELECT * FROM sys.dm_os_sys_info

SELECT cpu_count AS [Logical CPUs]
,cpu_count / hyperthread_ratio AS [Physical CPUs]
FROM sys.dm_os_sys_info

SELECT DATEADD(ss, -(ms_ticks / 1000), GetDate()) AS [Start dateTime]
FROM sys.dm_os_sys_info

#>}


#----------------------------------------------------
#  4265 11.6 Viewing enabled Enterprise features (2008 only) p.298
#----------------------------------------------------
{<#

SELECT * FROM sys.dm_db_persisted_sku_features

#>}





#----------------------------------------------------
# 4315  Listing 11.5 Who’s doing what and when?  p.299
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
CREATE TABLE dbo.WhatsGoingOnHistory(
[Runtime] [DateTime],
[session_id] [smallint] NOT NULL,
[login_name] [varchar](128) NOT NULL,
[host_name] [varchar](128) NULL,
[DBName] [varchar](128) NULL,
[Individual Query] [varchar](max) NULL,
[Parent Query] [varchar](200) NULL,
[status] [varchar](30) NULL,
[start_time] [datetime] NULL,
[wait_type] [varchar](60) NULL,
[program_name] [varchar](128) NULL
)
GO
CREATE UNIQUE NONCLUSTERED INDEX
[NONCLST_WhatsGoingOnHistory] ON [dbo].[WhatsGoingOnHistory]
([Runtime] ASC, [session_id] ASC)
GO



INSERT INTO dbo.WhatsGoingOnHistory
SELECT
GETDATE()
, s.session_id
, s.login_name
, s.host_name
, DB_NAME(r.database_id) AS DBName
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
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
WHERE s.session_id > 50
AND r.session_id != @@spid
WAITFOR DELAY '00:01:00'
GO 1440 -- 60 * 24 (one day)


#>}



#----------------------------------------------------
#  4373  11.8.1 Locating where your queries are spending their time  p.301
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
EXEC MO.PNLYearToDate_v01iws
@pControlOrgIds = '537'
, @pCOBStart = '27 may 2009'
, @pCOBEnd = '27 may 2009'
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset,
last_execution_time
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0)) -
(p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time waiting]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, p2.last_execution_time
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2
ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
AND qt.text LIKE '%PNLYearToDate_v01iws %'
ORDER BY [Parent Query], p2.statement_start_offset
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
#>}




#----------------------------------------------------
#  4435  Listing 11.7 Memory used per database  p.304
#----------------------------------------------------
{<#

SET TRAN ISOLATION LEVEL READ UNCOMMITTED
SELECT
ISNULL(DB_NAME(database_id), 'ResourceDb') AS DatabaseName
, CAST(COUNT(row_count) * 8.0 / (1024.0) AS DECIMAL(28,2))
AS [Size (MB)]
FROM sys.dm_os_buffer_descriptors
GROUP BY database_id
ORDER BY DatabaseName

#>}



#----------------------------------------------------
#  4455 11.10.1 Determining the memory used by tables and indexes p.305
#----------------------------------------------------
{<#
Listing 11.8 Memory used by objects in the current database
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
OBJECT_NAME(p.[object_id]) AS [TableName]
, (COUNT(*) * 8) / 1024 AS [Buffer size(MB)]
, ISNULL(i.name, '-- HEAP --') AS ObjectName
, COUNT(*) AS NumberOf8KPages
FROM sys.allocation_units AS a
INNER JOIN sys.dm_os_buffer_descriptors AS b
ON a.allocation_unit_id = b.allocation_unit_id
INNER JOIN sys.partitions AS p
INNER JOIN sys.indexes i ON p.index_id = i.index_id
AND p.[object_id] = i.[object_id]
ON a.container_id = p.hobt_id
WHERE b.database_id = DB_ID()
AND p.[object_id] > 100
GROUP BY p.[object_id], i.name
ORDER BY NumberOf8KPages DESC



#>}



#----------------------------------------------------
#   4482  Listing 11.9 I/O stalls at the database level p.308 
#----------------------------------------------------
{<#

SET TRAN ISOLATION LEVEL READ UNCOMMITTED
SELECT DB_NAME(database_id) AS [DatabaseName]
, SUM(CAST(io_stall / 1000.0 AS DECIMAL(20,2))) AS [IO stall (secs)]
, SUM(CAST(num_of_bytes_read / 1024.0 / 1024.0 AS DECIMAL(20,2)))
AS [IO read (MB)]
, SUM(CAST(num_of_bytes_written / 1024.0 / 1024.0 AS DECIMAL(20,2)))
AS [IO written (MB)]
, SUM(CAST((num_of_bytes_read + num_of_bytes_written)
/ 1024.0 / 1024.0 AS DECIMAL(20,2))) AS [TotalIO (MB)]
FROM sys.dm_io_virtual_file_stats(NULL, NULL)
GROUP BY database_id
ORDER BY [IO stall (secs)] DESC

#>}



#----------------------------------------------------
#   4504  Listing 11.10 I/O stalls at the file level p.309
#----------------------------------------------------
{<#

SET TRAN ISOLATION LEVEL READ UNCOMMITTED
SELECT DB_NAME(database_id) AS [DatabaseName]
, file_id
, SUM(CAST(io_stall / 1000.0 AS DECIMAL(20,2))) AS [IO stall (secs)]
, SUM(CAST(num_of_bytes_read / 1024.0 / 1024.0 AS DECIMAL(20,2)))
AS [IO read (MB)]
, SUM(CAST(num_of_bytes_written / 1024.0 / 1024.0 AS DECIMAL(20,2)))
AS [IO written (MB)]
, SUM(CAST((num_of_bytes_read + num_of_bytes_written)
/ 1024.0 / 1024.0 AS DECIMAL(20,2))) AS [TotalIO (MB)]
FROM sys.dm_io_virtual_file_stats(NULL, NULL)
GROUP BY database_id, file_id
ORDER BY [IO stall (secs)] DESC
#>}



#----------------------------------------------------
#  4526  Listing 11.11 Average read/write times per file, per database p.311 
#----------------------------------------------------
{<#

SET TRAN ISOLATION LEVEL READ UNCOMMITTED
SELECT DB_NAME(database_id) AS DatabaseName
, file_id
, io_stall_read_ms / num_of_reads AS 'Average read time'
, io_stall_write_ms / num_of_writes AS 'Average write time'
FROM sys.dm_io_virtual_file_stats(NULL, NULL)
WHERE num_of_reads > 0 and num_of_writes > 0
ORDER BY DatabaseName


#>}



#----------------------------------------------------
#  4545 Listing 11.12 Simple trace utility  p.312
#----------------------------------------------------
{<#

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset, statement_end_offset
INTO #PreWorkQuerySnapShot
FROM sys.dm_exec_query_stats
WAITFOR DELAY ‘00:01:00’
SELECT
sql_handle, plan_handle, total_elapsed_time, total_worker_time
, total_logical_reads, total_logical_writes, total_clr_time
, execution_count, statement_start_offset
, statement_end_offset, last_execution_time
INTO #PostWorkQuerySnapShot
FROM sys.dm_exec_query_stats
SELECT
p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0) AS [Duration]
, p2.total_worker_time - ISNULL(p1.total_worker_time, 0) AS [Time on CPU]
, (p2.total_elapsed_time - ISNULL(p1.total_elapsed_time, 0))
- (p2.total_worker_time - ISNULL(p1.total_worker_time, 0))
AS [Time waiting]
, p2.total_logical_reads - ISNULL(p1.total_logical_reads, 0) AS [Reads]
, p2.total_logical_writes - ISNULL(p1.total_logical_writes, 0)
AS [Writes]
, p2.total_clr_time - ISNULL(p1.total_clr_time, 0) AS [CLR time]
, p2.execution_count - ISNULL(p1.execution_count, 0) AS [Executions]
, p2.last_execution_time
, SUBSTRING (qt.text,p2.statement_start_offset/2 + 1,
((CASE WHEN p2.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE p2.statement_end_offset
END - p2.statement_start_offset)/2) + 1) AS [Individual Query]
, qt.text AS [Parent Query]
, DB_NAME(qt.dbid) AS DatabaseName
FROM #PreWorkQuerySnapShot p1
RIGHT OUTER JOIN
#PostWorkQuerySnapShot p2
ON p2.sql_handle = ISNULL(p1.sql_handle, p2.sql_handle)
AND p2.plan_handle = ISNULL(p1.plan_handle, p2.plan_handle)
AND p2.statement_start_offset =
ISNULL(p1.statement_start_offset, p2.statement_start_offset)
AND p2.statement_end_offset =
ISNULL(p1.statement_end_offset, p2.statement_end_offset)
CROSS APPLY sys.dm_exec_sql_text(p2.sql_handle) as qt
WHERE p2.execution_count != ISNULL(p1.execution_count, 0)
ORDER BY DatabaseName, [Parent Query]
, p2.statement_start_offset
DROP TABLE #PreWorkQuerySnapShot
DROP TABLE #PostWorkQuerySnapShot
#>}



#----------------------------------------------------
#   4603 11.13 Some best practices p.314
#----------------------------------------------------
{<#

How to Use This Checklist
This checklist is a companion to Chapter 14, "Improving SQL Server Performance"

SQL: Scale Up vs. Scale Out

■	Optimize the application before scaling up or scaling out.
■	Address historical and reporting data.
■	Scale up for most applications.
■	Scale out when scaling up does not suffice or is cost-prohibitive.

Schema

■	Devote the appropriate resources to schema design.
■	Separate online analytical processing (OLAP) and online transaction processing (OLTP) workloads.
■	Normalize first, denormalize later for performance.
■	Define all primary keys and foreign key relationships.
■	Define all unique constraints and check constraints.
■	Choose the most appropriate data type.
■	Use indexed views for denormalization.
■	Partition tables vertically and horizontally.

Queries

■	Know the performance and scalability characteristics of queries.
■	Write correctly formed queries.
■	Return only the rows and columns needed.
■	Avoid expensive operators such as NOT LIKE.
■	Avoid explicit or implicit functions in WHERE clauses.
■	Use locking and isolation level hints to minimize locking.
■	Use stored procedures or parameterized queries.
■	Minimize cursor use.
■	Avoid long actions in triggers.
■	Use temporary tables and table variables appropriately.
■	Limit query and index hint use.
■	Fully qualify database objects.

Indexes

■	Create indexes based on use.
■	Keep clustered index keys as small as possible.
■	Consider range data for clustered indexes.
■	Create an index on all foreign keys.
■	Create highly selective indexes.
■	Create a covering index for often-used, high-impact queries.
■	Use multiple narrow indexes rather than a few wide indexes.
■	Create composite indexes with the most restrictive column first.
■	Consider indexes on columns used in WHERE, ORDER BY, GROUP BY, and DISTINCT clauses.
■	Remove unused indexes.
■	Use the Index Tuning Wizard.

Transactions

■	Avoid long-running transactions.
■	Avoid transactions that require user input to commit.
■	Access heavily used data at the end of the transaction.
■	Try to access resources in the same order.
■	Use isolation level hints to minimize locking.
■	Ensure that explicit transactions commit or roll back.

Stored Procedures
■	Use Set NOCOUNT ON in stored procedures.
■	Do not use the sp_prefix for custom stored procedures.


Execution Plans
■	Evaluate the query execution plan.
■	Avoid table and index scans.
■	Evaluate hash joins.
■	Evaluate bookmarks.
■	Evaluate sorts and filters.
■	Compare actual versus estimated rows and executions.


Execution Plan Recompiles
■	Use stored procedures or parameterized queries.
■	Use sp_executesql for dynamic code.
■	Avoid interleaving data definition language (DDL) and data manipulation language (DML) in stored procedures, including the tempdb database DDL.
■	Avoid cursors over temporary tables.

SQL XML
■	Avoid OPENXML over large XML documents.
■	Avoid large numbers of concurrent OPENXML statements over XML documents.


Tuning
■	Use SQL Profiler to identify long-running queries.
■	Take note of small queries called often.
■	Use sp_lock and sp_who2 to evaluate locking and blocking.
■	Evaluate waittype and waittime in master..sysprocesses.
■	Use DBCC OPENTRAN to locate long-running transactions.


Testing
■	Ensure that your transactions logs do not fill up.
■	Budget your database growth.
■	Use tools to populate data.
■	Use existing production data.
■	Use common user scenarios, with appropriate balances between reads and writes.
■	Use testing tools to perform stress and load tests on the system.

Monitoring
■	Keep statistics up to date.
■	Use SQL Profiler to tune long-running queries.
■	Use SQL Profiler to monitor table and index scans.
■	Use Performance Monitor to monitor high resource usage.
■	Set up an operations and development feedback loop.


Deployment Considerations
■	Use default server configuration settings for most applications.
■	Locate logs and the tempdb database on separate devices from the data.
■	Provide separate devices for heavily accessed tables and indexes.
■	Use the correct RAID configuration.
■	Use multiple disk controllers.
■	Pre-grow databases and logs to avoid automatic growth and fragmentation performance impact.
■	Maximize available memory.
■	Manage index fragmentation.
■	Keep database administrator tasks in mind.



#>}

#----------------------------------------------------
#    Who is connected?    p.42 
#----------------------------------------------------
{<#

-- Get a count of SQL connections by IP address
SELECT dec.client_net_address ,
des.program_name ,
des.host_name ,
--des.login_name ,
COUNT(dec.session_id) AS connection_count
FROM sys.dm_exec_sessions AS des
INNER JOIN sys.dm_exec_connections AS dec
ON des.session_id = dec.session_id
-- WHERE LEFT(des.host_name, 2) = 'WK'
GROUP BY dec.client_net_address ,
des.program_name ,
des.host_name
-- des.login_name
-- HAVING COUNT(dec.session_id) > 1
ORDER BY des.program_name,
dec.client_net_address ;

#>}


#----------------------------------------------------
#   Who is connected by SSMS? p.44
#----------------------------------------------------
{<#

SELECT dec.client_net_address ,
des.host_name ,
dest.text
FROM sys.dm_exec_sessions des
INNER JOIN sys.dm_exec_connections dec
ON des.session_id = dec.session_id
CROSS APPLY sys.dm_exec_sql_text(dec.most_recent_sql_handle) dest
WHERE des.program_name LIKE 'Microsoft SQL Server Management Studio%'
ORDER BY des.program_name ,
dec.client_net_address


#>}


#----------------------------------------------------
#  Logins with more than one session p.47
#----------------------------------------------------
{<#

SELECT login_name ,
COUNT(session_id) AS session_count
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
GROUP BY login_name
ORDER BY login_name

#>}


#----------------------------------------------------
#  Identify sessions with context switching
#----------------------------------------------------
{<#

SELECT session_id ,
login_name ,
original_login_name
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
AND login_name <> original_login_name


#>}






#----------------------------------------------------
#  Identify inactive sessions
#----------------------------------------------------
{<#

DECLARE @days_old SMALLINT
SELECT @days_old = 5
SELECT des.session_id ,
des.login_time ,
des.last_request_start_time ,
des.last_request_end_time ,
des.[status] ,
des.[program_name] ,
des.cpu_time ,
des.total_elapsed_time ,
des.memory_usage ,
des.total_scheduled_time ,
des.total_elapsed_time ,
des.reads ,
des.writes ,
des.logical_reads ,
des.row_count ,
des.is_user_process
FROM sys.dm_exec_sessions des
INNER JOIN sys.dm_tran_session_transactions dtst
ON des.session_id = dtst.session_id
WHERE des.is_user_process = 1
AND DATEDIFF(dd, des.last_request_end_time, GETDATE()) > @days_old
AND des.status != 'Running'
ORDER BY des.last_request_end_time

#>}



#----------------------------------------------------
#  Identify idle sessions with orphaned transactions p.51
#----------------------------------------------------
{<#

SELECT des.session_id ,
des.login_time ,
des.last_request_start_time ,
des.last_request_end_time ,
des.host_name ,
des.login_name
FROM sys.dm_exec_sessions des
INNER JOIN sys.dm_tran_session_transactions dtst
ON des.session_id = dtst.session_id
LEFT JOIN sys.dm_exec_requests der
ON dtst.session_id = der.session_id
WHERE der.session_id IS NULL
ORDER BY des.session_id

#>}



#----------------------------------------------------
#   Blocking and locking columns p.55
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#   Returning the SQL text of ad hoc queries p.58 
#----------------------------------------------------
{<#

SELECT dest.text ,
dest.dbid ,
dest.objectid
FROM sys.dm_exec_requests AS der
CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
WHERE session_id = @@spid ;

#>}



#----------------------------------------------------
#  Listing 2.11: Retrieving the text for a currently executing batch. p.60 
#----------------------------------------------------
{<#

SELECT dest.text
FROM sys.dm_exec_requests AS der
CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) AS dest
WHERE session_id <> @@spid
AND text LIKE '%waitfor%' ;


#Listing 2.12: Creating the test stored procedure.
CREATE PROCEDURE dbo.test
AS
SELECT *
FROM sys.objects
WAITFOR DELAY '00:10:00';

#Listing 2.13: Returning the text of an executing stored procedure.
SELECT dest.dbid ,
dest.objectid ,
dest.encrypted ,
dest.text
FROM sys.dm_exec_requests AS der
CROSS APPLY sys.dm_exec_sql_text(der.sql_handle)
AS dest
WHERE objectid = object_id('test', 'p');
#>}



#----------------------------------------------------
#  Listing 2.14: Parsing the SQL text using statement_start_offset and statement_end_offset. p.63
#----------------------------------------------------
{<#
SELECT der.statement_start_offset ,
der.statement_end_offset ,
SUBSTRING(dest.text, der.statement_start_offset / 2,
( CASE WHEN der.statement_end_offset = -1
THEN DATALENGTH(dest.text)
ELSE der.statement_end_offset
END - der.statement_start_offset ) / 2)
AS statement_executing ,
dest.text AS [full statement code]
FROM sys.dm_exec_requests der
INNER JOIN sys.dm_exec_sessions des
ON des.session_id = der.session_id
CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) dest
WHERE des.is_user_process = 1
AND der.session_id <> @@spid
ORDER BY der.session_id ;

#>}



#----------------------------------------------------
#  Listing 2.15: Investigating offsets.p.63
#----------------------------------------------------
{<#

WAITFOR DELAY '00:01' ;
BEGIN TRANSACTION
-- WAITFOR DELAY '00:01' ;
INSERT INTO AdventureWorks.Production.ProductCategory
( Name, ModifiedDate )
VALUES ( 'Reflectors', GETDATE() )
ROLLBACK TRANSACTION
SELECT Name ,
ModifiedDate
FROM AdventureWorks.Production.ProductCategory
WHERE Name = 'Reflectors' ;
-- WAITFOR DELAY '00:01' ;

#>}

#----------------------------------------------------
#    Listing 2.16: Requests by CPU consumption. p.66
#----------------------------------------------------
{<#

SELECT der.session_id ,
DB_NAME(der.database_id) AS database_name ,
deqp.query_plan ,
SUBSTRING(dest.text, der.statement_start_offset / 2,
( CASE WHEN der.statement_end_offset = -1
THEN DATALENGTH(dest.text)
ELSE der.statement_end_offset
END - der.statement_start_offset ) / 2)
AS [statement executing] ,
der.cpu_time
--der.granted_query_memory
--der.wait_time
--der.total_elapsed_time
--der.reads
FROM sys.dm_exec_requests der
INNER JOIN sys.dm_exec_sessions des
ON des.session_id = der.session_id
CROSS APPLY sys.dm_exec_sql_text(der.sql_handle) dest
CROSS APPLY sys.dm_exec_query_plan(der.plan_handle) deqp
WHERE des.is_user_process = 1
AND der.session_id <> @@spid
ORDER BY der.cpu_time DESC ;
-- ORDER BY der.granted_query_memory DESC ;
-- ORDER BY der.wait_time DESC;
-- ORDER BY der.total_elapsed_time DESC;
-- ORDER BY der.reads DESC;

#>}


#----------------------------------------------------
#    Listing 2.17: Who is running what? p.67
#----------------------------------------------------
{<#

Who is running what at this instant
SELECT dest.text AS [Command text] ,
des.login_time ,
des.[host_name] ,
des.[program_name] ,
der.session_id ,
dec.client_net_address ,
der.status ,
der.command ,
DB_NAME(der.database_id) AS DatabaseName
FROM sys.dm_exec_requests der
INNER JOIN sys.dm_exec_connections dec
ON der.session_id = dec.session_id
INNER JOIN sys.dm_exec_sessions des
ON des.session_id = der.session_id
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS dest
WHERE des.is_user_process = 1

#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}




#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}




#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}




#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}




#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}





#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}



#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}

#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}


#----------------------------------------------------
#  
#----------------------------------------------------
{<#



#>}