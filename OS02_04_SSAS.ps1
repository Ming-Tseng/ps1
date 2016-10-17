<#
OS02_04_SSAS.ps1
Desc:   for M3 
filename:   
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS02_04_SSAS.ps1

Date:Nov.18.2015
last: 

author: a0921887912@gmail.com
from : OS0201_diskIO.ps1

JOB , blg , 
#>

#---------------------------------------------------------------
#   Get basci info
#---------------------------------------------------------------

$dbinstance='PMD2016' 
$dbinstance='SP2013' 


$dbname    ='sql_inventory'


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
Invoke-Sqlcmd -Query $tsql_selectdbFileSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rd  |ft -AutoSize  
}
dbmdfldfSize PMD2016 sql_inventory


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
Invoke-Sqlcmd -Query $tsql_GetTableRowSize -ServerInstance  $dbinstance  -Database $dbname  -user sa  -password p@ssw0rd  |ft -AutoSize  

set statistics io on
set statistics time  on



#---------------------------------------------------------------
#   
#---------------------------------------------------------------
https://msdn.microsoft.com/en-us/library/hh230807.aspx


gsv -DisplayName *SQL*
Get-Counter -ListSet *MSOLAP* | Select-Object -ExpandProperty Paths
'
PS C:\Users\infra1> gsv -DisplayName *SQL*

Status   Name               DisplayName                           
------   ----               -----------                           
Stopped  MSOLAP$SSASMD      SQL Server Analysis Services (SSASMD) 
Stopped  MSOLAP$SSASPT      SQL Server Analysis Services (SSASPT) 
Stopped  MSOLAP$SSASTR      SQL Server Analysis Services (SSASTR) 
Running  MSSQL$SSDE         SQL Server (SSDE)                     
Stopped  MSSQL$SSDW         SQL Server (SSDW)                     
Stopped  SQLAgent$SSDE      SQL Server Agent (SSDE)               
Stopped  SQLAgent$SSDW      SQL Server Agent (SSDW)               
Running  SQLBrowser         SQL Server Browser                    
Running  SQLWriter          SQL Server VSS Writer


PS C:\Users\infra1> Get-Counter -ListSet *MSOLAP* | Select-Object -ExpandProperty Paths
\MSOLAP$SSASMD:Connection\Current connections
\MSOLAP$SSASMD:Connection\Requests/sec
\MSOLAP$SSASMD:Connection\Total requests
\MSOLAP$SSASMD:Connection\Successes/sec
\MSOLAP$SSASMD:Connection\Total successes
\MSOLAP$SSASMD:Connection\Failures/sec
\MSOLAP$SSASMD:Connection\Total failures
\MSOLAP$SSASMD:Connection\Current user sessions
\MSOLAP$SSASMD:Locks\Current latch waits
\MSOLAP$SSASMD:Locks\Latch waits/sec
\MSOLAP$SSASMD:Locks\Current locks
\MSOLAP$SSASMD:Locks\Current lock waits
\MSOLAP$SSASMD:Locks\Lock requests/sec
\MSOLAP$SSASMD:Locks\Unlock requests/sec
\MSOLAP$SSASMD:Locks\Lock grants/sec
\MSOLAP$SSASMD:Locks\Lock denials/sec
\MSOLAP$SSASMD:Locks\Lock waits/sec
\MSOLAP$SSASMD:Locks\Total deadlocks detected
\MSOLAP$SSASMD:Threads\Short parsing idle threads
\MSOLAP$SSASMD:Threads\Short parsing busy threads
\MSOLAP$SSASMD:Threads\Short parsing job queue length
\MSOLAP$SSASMD:Threads\Short parsing job rate
\MSOLAP$SSASMD:Threads\Long parsing idle threads
\MSOLAP$SSASMD:Threads\Long parsing busy threads
\MSOLAP$SSASMD:Threads\Long parsing job queue length
\MSOLAP$SSASMD:Threads\Long parsing job rate
\MSOLAP$SSASMD:Threads\Query pool idle threads
\MSOLAP$SSASMD:Threads\Query pool busy threads
\MSOLAP$SSASMD:Threads\Query pool job queue length
\MSOLAP$SSASMD:Threads\Query pool job rate
\MSOLAP$SSASMD:Threads\Processing pool idle non-I/O threads
\MSOLAP$SSASMD:Threads\Processing pool busy non-I/O threads
\MSOLAP$SSASMD:Threads\Processing pool job queue length
\MSOLAP$SSASMD:Threads\Processing pool job rate
\MSOLAP$SSASMD:Threads\Processing pool idle I/O job threads
\MSOLAP$SSASMD:Threads\Processing pool busy I/O job threads
\MSOLAP$SSASMD:Threads\Processing pool I/O job queue length
\MSOLAP$SSASMD:Threads\Processing pool I/O job completion rate
\MSOLAP$SSASMD:Memory\Page Pool 64 Alloc KB
\MSOLAP$SSASMD:Memory\Page Pool 64 Lookaside KB
\MSOLAP$SSASMD:Memory\Page Pool 8 Alloc KB
\MSOLAP$SSASMD:Memory\Page Pool 8 Lookaside KB
\MSOLAP$SSASMD:Memory\Page Pool 1 Alloc KB
\MSOLAP$SSASMD:Memory\Page Pool 1 Lookaside KB
\MSOLAP$SSASMD:Memory\Cleaner Current Price
\MSOLAP$SSASMD:Memory\Cleaner Balance/sec
\MSOLAP$SSASMD:Memory\Cleaner Memory shrunk KB/sec
\MSOLAP$SSASMD:Memory\Cleaner Memory shrinkable KB
\MSOLAP$SSASMD:Memory\Cleaner Memory nonshrinkable KB
\MSOLAP$SSASMD:Memory\Cleaner Memory KB
\MSOLAP$SSASMD:Memory\Memory Usage KB
\MSOLAP$SSASMD:Memory\Memory Limit Low KB
\MSOLAP$SSASMD:Memory\Memory Limit High KB
\MSOLAP$SSASMD:Memory\AggCacheKB
\MSOLAP$SSASMD:Memory\Quota KB
\MSOLAP$SSASMD:Memory\Quota Blocked
\MSOLAP$SSASMD:Memory\Filestore KB
\MSOLAP$SSASMD:Memory\Filestore Page Faults/sec
\MSOLAP$SSASMD:Memory\Filestore Reads/sec
\MSOLAP$SSASMD:Memory\Filestore KB Reads/sec
\MSOLAP$SSASMD:Memory\Filestore Writes/sec
\MSOLAP$SSASMD:Memory\Filestore KB Write/sec
\MSOLAP$SSASMD:Memory\Filestore IO Errors/sec
\MSOLAP$SSASMD:Memory\Filestore IO Errors
\MSOLAP$SSASMD:Memory\Filestore Clock Pages Examined/sec
\MSOLAP$SSASMD:Memory\Filestore Clock Pages HaveRef/sec
\MSOLAP$SSASMD:Memory\Filestore Clock Pages Valid/sec
\MSOLAP$SSASMD:Memory\Filestore Memory Pinned KB
\MSOLAP$SSASMD:Memory\In-memory Dimension Property File KB
\MSOLAP$SSASMD:Memory\In-memory Dimension Property File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Dimension Property File KB
\MSOLAP$SSASMD:Memory\Dimension Property Files
\MSOLAP$SSASMD:Memory\In-memory Dimension Index (Hash) File KB
\MSOLAP$SSASMD:Memory\In-memory Dimension Index (Hash) File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Dimension Index (Hash) File KB
\MSOLAP$SSASMD:Memory\Dimension Index (Hash) Files
\MSOLAP$SSASMD:Memory\In-memory Dimension String File KB
\MSOLAP$SSASMD:Memory\In-memory Dimension String File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Dimension String File KB
\MSOLAP$SSASMD:Memory\Dimension String Files
\MSOLAP$SSASMD:Memory\In-memory Map File KB
\MSOLAP$SSASMD:Memory\In-memory Map File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Map File KB
\MSOLAP$SSASMD:Memory\Map Files
\MSOLAP$SSASMD:Memory\In-memory Aggregation Map File KB
\MSOLAP$SSASMD:Memory\In-memory Aggregation Map File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Aggregation Map File KB
\MSOLAP$SSASMD:Memory\Aggregation Map Files
\MSOLAP$SSASMD:Memory\In-memory Fact Data File KB
\MSOLAP$SSASMD:Memory\In-memory Fact Data File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Fact Data File KB
\MSOLAP$SSASMD:Memory\Fact Data Files
\MSOLAP$SSASMD:Memory\In-memory Fact String File KB
\MSOLAP$SSASMD:Memory\In-memory Fact String File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Fact String File KB
\MSOLAP$SSASMD:Memory\Fact String Files
\MSOLAP$SSASMD:Memory\In-memory Fact Aggregation File KB
\MSOLAP$SSASMD:Memory\In-memory Fact Aggregation File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Fact Aggregation File KB
\MSOLAP$SSASMD:Memory\Fact Aggregation Files
\MSOLAP$SSASMD:Memory\In-memory Other File KB
\MSOLAP$SSASMD:Memory\In-memory Other File KB/sec
\MSOLAP$SSASMD:Memory\Potential In-memory Other File KB
\MSOLAP$SSASMD:Memory\Other Files
\MSOLAP$SSASMD:Memory\VertiPaq Paged KB
\MSOLAP$SSASMD:Memory\VertiPaq Nonpaged KB
\MSOLAP$SSASMD:Memory\VertiPaq Memory-Mapped KB
\MSOLAP$SSASMD:Memory\Memory Limit Hard KB
\MSOLAP$SSASMD:Memory\Memory Limit VertiPaq KB
\MSOLAP$SSASMD:Cache\Current KB
\MSOLAP$SSASMD:Cache\KB added/sec
\MSOLAP$SSASMD:Cache\Current entries
\MSOLAP$SSASMD:Cache\Inserts/sec
\MSOLAP$SSASMD:Cache\Evictions/sec
\MSOLAP$SSASMD:Cache\Total inserts
\MSOLAP$SSASMD:Cache\Total evictions
\MSOLAP$SSASMD:Cache\Direct hits/sec
\MSOLAP$SSASMD:Cache\Misses/sec
\MSOLAP$SSASMD:Cache\Lookups/sec
\MSOLAP$SSASMD:Cache\Total direct hits
\MSOLAP$SSASMD:Cache\Total misses
\MSOLAP$SSASMD:Cache\Total lookups
\MSOLAP$SSASMD:Cache\Direct hit ratio
\MSOLAP$SSASMD:Cache\Total filtered iterator cache hits
\MSOLAP$SSASMD:Cache\Total filtered iterator cache misses
\MSOLAP$SSASMD:MDX\Number of calculation covers
\MSOLAP$SSASMD:MDX\Current number of evaluation nodes
\MSOLAP$SSASMD:MDX\Number of Storage Engine evaluation nodes
\MSOLAP$SSASMD:MDX\Number of cell-by-cell evaluation nodes
\MSOLAP$SSASMD:MDX\Number of bulk-mode evaluation nodes
\MSOLAP$SSASMD:MDX\Number of evaluation nodes that covered a single cell
\MSOLAP$SSASMD:MDX\Number of evaluation nodes with calculations at the same granularity
\MSOLAP$SSASMD:MDX\Current number of cached evaluation nodes
\MSOLAP$SSASMD:MDX\Number of cached Storage Engine evaluation nodes
\MSOLAP$SSASMD:MDX\Number of cached bulk-mode evaluation nodes
\MSOLAP$SSASMD:MDX\Number of cached ''other'' evaluation nodes
\MSOLAP$SSASMD:MDX\Number of evictions of evaluation nodes
\MSOLAP$SSASMD:MDX\Number of hash index hits in the cache of evaluation nodes
\MSOLAP$SSASMD:MDX\Number of cell-by-cell hits in the cache of evaluation nodes
\MSOLAP$SSASMD:MDX\Number of cell-by-cell misses in the cache of evaluation nodes
\MSOLAP$SSASMD:MDX\Number of subcube hits in the cache of evaluation nodes
\MSOLAP$SSASMD:MDX\Number of subcube misses in the cache of evaluation nodes
\MSOLAP$SSASMD:MDX\Total Sonar subcubes
\MSOLAP$SSASMD:MDX\Total cells calculated
\MSOLAP$SSASMD:MDX\Total recomputes
\MSOLAP$SSASMD:MDX\Total flat cache inserts
\MSOLAP$SSASMD:MDX\Total NON EMPTY
\MSOLAP$SSASMD:MDX\Total NON EMPTY for calculated members
\MSOLAP$SSASMD:MDX\Total NON EMPTY unoptimized
\MSOLAP$SSASMD:MDX\Total Autoexist
\MSOLAP$SSASMD:MDX\Total EXISTING
\MSOLAP$SSASMD:Processing\Rows read/sec
\MSOLAP$SSASMD:Processing\Total rows read
\MSOLAP$SSASMD:Processing\Rows converted/sec
\MSOLAP$SSASMD:Processing\Total rows converted
\MSOLAP$SSASMD:Processing\Rows written/sec
\MSOLAP$SSASMD:Processing\Total rows written
\MSOLAP$SSASMD:Proc Aggregations\Current partitions
\MSOLAP$SSASMD:Proc Aggregations\Total partitions
\MSOLAP$SSASMD:Proc Aggregations\Memory size rows
\MSOLAP$SSASMD:Proc Aggregations\Memory size bytes
\MSOLAP$SSASMD:Proc Aggregations\Rows merged/sec
\MSOLAP$SSASMD:Proc Aggregations\Rows created/sec
\MSOLAP$SSASMD:Proc Aggregations\Temp file rows written/sec
\MSOLAP$SSASMD:Proc Aggregations\Temp file bytes written/sec
\MSOLAP$SSASMD:Proc Indexes\Current partitions
\MSOLAP$SSASMD:Proc Indexes\Total partitions
\MSOLAP$SSASMD:Proc Indexes\Rows/sec
\MSOLAP$SSASMD:Proc Indexes\Total rows
\MSOLAP$SSASMD:Storage Engine Query\Current measure group queries
\MSOLAP$SSASMD:Storage Engine Query\Measure group queries/sec
\MSOLAP$SSASMD:Storage Engine Query\Total measure group queries
\MSOLAP$SSASMD:Storage Engine Query\Current dimension queries
\MSOLAP$SSASMD:Storage Engine Query\Dimension queries/sec
\MSOLAP$SSASMD:Storage Engine Query\Total dimension queries.
\MSOLAP$SSASMD:Storage Engine Query\Queries answered/sec
\MSOLAP$SSASMD:Storage Engine Query\Total queries answered
\MSOLAP$SSASMD:Storage Engine Query\Bytes sent/sec
\MSOLAP$SSASMD:Storage Engine Query\Total bytes sent
\MSOLAP$SSASMD:Storage Engine Query\Rows sent/sec
\MSOLAP$SSASMD:Storage Engine Query\Total rows sent
\MSOLAP$SSASMD:Storage Engine Query\Queries from cache direct/sec
\MSOLAP$SSASMD:Storage Engine Query\Queries from cache filtered/sec
\MSOLAP$SSASMD:Storage Engine Query\Queries from file/sec
\MSOLAP$SSASMD:Storage Engine Query\Total queries from cache direct
\MSOLAP$SSASMD:Storage Engine Query\Total queries from cache filtered
\MSOLAP$SSASMD:Storage Engine Query\Total queries from file
\MSOLAP$SSASMD:Storage Engine Query\Map reads/sec
\MSOLAP$SSASMD:Storage Engine Query\Map bytes/sec
\MSOLAP$SSASMD:Storage Engine Query\Data reads/sec
\MSOLAP$SSASMD:Storage Engine Query\Data bytes/sec
\MSOLAP$SSASMD:Storage Engine Query\Avg time/query
\MSOLAP$SSASMD:Storage Engine Query\Network round trips/sec
\MSOLAP$SSASMD:Storage Engine Query\Total network round trips
\MSOLAP$SSASMD:Storage Engine Query\Flat cache lookups/sec
\MSOLAP$SSASMD:Storage Engine Query\Flat cache hits/sec
\MSOLAP$SSASMD:Storage Engine Query\Calculation cache lookups/sec
\MSOLAP$SSASMD:Storage Engine Query\Calculation cache hits/sec
\MSOLAP$SSASMD:Storage Engine Query\Persisted cache lookups/sec
\MSOLAP$SSASMD:Storage Engine Query\Persisted cache hits/sec
\MSOLAP$SSASMD:Storage Engine Query\Dimension cache lookups/sec
\MSOLAP$SSASMD:Storage Engine Query\Dimension cache hits/sec
\MSOLAP$SSASMD:Storage Engine Query\Measure group cache lookups/sec
\MSOLAP$SSASMD:Storage Engine Query\Measure group cache hits/sec
\MSOLAP$SSASMD:Storage Engine Query\Aggregation lookups/sec
\MSOLAP$SSASMD:Storage Engine Query\Aggregation hits/sec
\MSOLAP$SSASMD:Data Mining Model Processing\Cases/sec
\MSOLAP$SSASMD:Data Mining Model Processing\Current models processing
\MSOLAP$SSASMD:Data Mining Prediction\Predictions/sec
\MSOLAP$SSASMD:Data Mining Prediction\Rows/sec
\MSOLAP$SSASMD:Data Mining Prediction\Concurrent DM queries
\MSOLAP$SSASMD:Data Mining Prediction\Queries/sec
\MSOLAP$SSASMD:Data Mining Prediction\Total Queries
\MSOLAP$SSASMD:Data Mining Prediction\Total Rows
\MSOLAP$SSASMD:Data Mining Prediction\Total Predictions
\MSOLAP$SSASMD:Proactive Caching\Notifications/sec
\MSOLAP$SSASMD:Proactive Caching\Processing Cancellations/sec
\MSOLAP$SSASMD:Proactive Caching\Proactive Caching Begin/sec
\MSOLAP$SSASMD:Proactive Caching\Proactive Caching Completion/sec
\MSOLAP$SSASPT:Connection\Current connections
\MSOLAP$SSASPT:Connection\Requests/sec
\MSOLAP$SSASPT:Connection\Total requests
\MSOLAP$SSASPT:Connection\Successes/sec
\MSOLAP$SSASPT:Connection\Total successes
\MSOLAP$SSASPT:Connection\Failures/sec
\MSOLAP$SSASPT:Connection\Total failures
\MSOLAP$SSASPT:Connection\Current user sessions
\MSOLAP$SSASPT:Locks\Current latch waits
\MSOLAP$SSASPT:Locks\Latch waits/sec
\MSOLAP$SSASPT:Locks\Current locks
\MSOLAP$SSASPT:Locks\Current lock waits
\MSOLAP$SSASPT:Locks\Lock requests/sec
\MSOLAP$SSASPT:Locks\Unlock requests/sec
\MSOLAP$SSASPT:Locks\Lock grants/sec
\MSOLAP$SSASPT:Locks\Lock denials/sec
\MSOLAP$SSASPT:Locks\Lock waits/sec
\MSOLAP$SSASPT:Locks\Total deadlocks detected
\MSOLAP$SSASPT:Threads\Short parsing idle threads
\MSOLAP$SSASPT:Threads\Short parsing busy threads
\MSOLAP$SSASPT:Threads\Short parsing job queue length
\MSOLAP$SSASPT:Threads\Short parsing job rate
\MSOLAP$SSASPT:Threads\Long parsing idle threads
\MSOLAP$SSASPT:Threads\Long parsing busy threads
\MSOLAP$SSASPT:Threads\Long parsing job queue length
\MSOLAP$SSASPT:Threads\Long parsing job rate
\MSOLAP$SSASPT:Threads\Query pool idle threads
\MSOLAP$SSASPT:Threads\Query pool busy threads
\MSOLAP$SSASPT:Threads\Query pool job queue length
\MSOLAP$SSASPT:Threads\Query pool job rate
\MSOLAP$SSASPT:Threads\Processing pool idle non-I/O threads
\MSOLAP$SSASPT:Threads\Processing pool busy non-I/O threads
\MSOLAP$SSASPT:Threads\Processing pool job queue length
\MSOLAP$SSASPT:Threads\Processing pool job rate
\MSOLAP$SSASPT:Threads\Processing pool idle I/O job threads
\MSOLAP$SSASPT:Threads\Processing pool busy I/O job threads
\MSOLAP$SSASPT:Threads\Processing pool I/O job queue length
\MSOLAP$SSASPT:Threads\Processing pool I/O job completion rate
\MSOLAP$SSASPT:Memory\Page Pool 64 Alloc KB
\MSOLAP$SSASPT:Memory\Page Pool 64 Lookaside KB
\MSOLAP$SSASPT:Memory\Page Pool 8 Alloc KB
\MSOLAP$SSASPT:Memory\Page Pool 8 Lookaside KB
\MSOLAP$SSASPT:Memory\Page Pool 1 Alloc KB
\MSOLAP$SSASPT:Memory\Page Pool 1 Lookaside KB
\MSOLAP$SSASPT:Memory\Cleaner Current Price
\MSOLAP$SSASPT:Memory\Cleaner Balance/sec
\MSOLAP$SSASPT:Memory\Cleaner Memory shrunk KB/sec
\MSOLAP$SSASPT:Memory\Cleaner Memory shrinkable KB
\MSOLAP$SSASPT:Memory\Cleaner Memory nonshrinkable KB
\MSOLAP$SSASPT:Memory\Cleaner Memory KB
\MSOLAP$SSASPT:Memory\Memory Usage KB
\MSOLAP$SSASPT:Memory\Memory Limit Low KB
\MSOLAP$SSASPT:Memory\Memory Limit High KB
\MSOLAP$SSASPT:Memory\AggCacheKB
\MSOLAP$SSASPT:Memory\Quota KB
\MSOLAP$SSASPT:Memory\Quota Blocked
\MSOLAP$SSASPT:Memory\Filestore KB
\MSOLAP$SSASPT:Memory\Filestore Page Faults/sec
\MSOLAP$SSASPT:Memory\Filestore Reads/sec
\MSOLAP$SSASPT:Memory\Filestore KB Reads/sec
\MSOLAP$SSASPT:Memory\Filestore Writes/sec
\MSOLAP$SSASPT:Memory\Filestore KB Write/sec
\MSOLAP$SSASPT:Memory\Filestore IO Errors/sec
\MSOLAP$SSASPT:Memory\Filestore IO Errors
\MSOLAP$SSASPT:Memory\Filestore Clock Pages Examined/sec
\MSOLAP$SSASPT:Memory\Filestore Clock Pages HaveRef/sec
\MSOLAP$SSASPT:Memory\Filestore Clock Pages Valid/sec
\MSOLAP$SSASPT:Memory\Filestore Memory Pinned KB
\MSOLAP$SSASPT:Memory\In-memory Dimension Property File KB
\MSOLAP$SSASPT:Memory\In-memory Dimension Property File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Dimension Property File KB
\MSOLAP$SSASPT:Memory\Dimension Property Files
\MSOLAP$SSASPT:Memory\In-memory Dimension Index (Hash) File KB
\MSOLAP$SSASPT:Memory\In-memory Dimension Index (Hash) File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Dimension Index (Hash) File KB
\MSOLAP$SSASPT:Memory\Dimension Index (Hash) Files
\MSOLAP$SSASPT:Memory\In-memory Dimension String File KB
\MSOLAP$SSASPT:Memory\In-memory Dimension String File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Dimension String File KB
\MSOLAP$SSASPT:Memory\Dimension String Files
\MSOLAP$SSASPT:Memory\In-memory Map File KB
\MSOLAP$SSASPT:Memory\In-memory Map File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Map File KB
\MSOLAP$SSASPT:Memory\Map Files
\MSOLAP$SSASPT:Memory\In-memory Aggregation Map File KB
\MSOLAP$SSASPT:Memory\In-memory Aggregation Map File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Aggregation Map File KB
\MSOLAP$SSASPT:Memory\Aggregation Map Files
\MSOLAP$SSASPT:Memory\In-memory Fact Data File KB
\MSOLAP$SSASPT:Memory\In-memory Fact Data File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Fact Data File KB
\MSOLAP$SSASPT:Memory\Fact Data Files
\MSOLAP$SSASPT:Memory\In-memory Fact String File KB
\MSOLAP$SSASPT:Memory\In-memory Fact String File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Fact String File KB
\MSOLAP$SSASPT:Memory\Fact String Files
\MSOLAP$SSASPT:Memory\In-memory Fact Aggregation File KB
\MSOLAP$SSASPT:Memory\In-memory Fact Aggregation File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Fact Aggregation File KB
\MSOLAP$SSASPT:Memory\Fact Aggregation Files
\MSOLAP$SSASPT:Memory\In-memory Other File KB
\MSOLAP$SSASPT:Memory\In-memory Other File KB/sec
\MSOLAP$SSASPT:Memory\Potential In-memory Other File KB
\MSOLAP$SSASPT:Memory\Other Files
\MSOLAP$SSASPT:Memory\VertiPaq Paged KB
\MSOLAP$SSASPT:Memory\VertiPaq Nonpaged KB
\MSOLAP$SSASPT:Memory\VertiPaq Memory-Mapped KB
\MSOLAP$SSASPT:Memory\Memory Limit Hard KB
\MSOLAP$SSASPT:Memory\Memory Limit VertiPaq KB
\MSOLAP$SSASPT:Cache\Current KB
\MSOLAP$SSASPT:Cache\KB added/sec
\MSOLAP$SSASPT:Cache\Current entries
\MSOLAP$SSASPT:Cache\Inserts/sec
\MSOLAP$SSASPT:Cache\Evictions/sec
\MSOLAP$SSASPT:Cache\Total inserts
\MSOLAP$SSASPT:Cache\Total evictions
\MSOLAP$SSASPT:Cache\Direct hits/sec
\MSOLAP$SSASPT:Cache\Misses/sec
\MSOLAP$SSASPT:Cache\Lookups/sec
\MSOLAP$SSASPT:Cache\Total direct hits
\MSOLAP$SSASPT:Cache\Total misses
\MSOLAP$SSASPT:Cache\Total lookups
\MSOLAP$SSASPT:Cache\Direct hit ratio
\MSOLAP$SSASPT:Cache\Total filtered iterator cache hits
\MSOLAP$SSASPT:Cache\Total filtered iterator cache misses
\MSOLAP$SSASPT:MDX\Number of calculation covers
\MSOLAP$SSASPT:MDX\Current number of evaluation nodes
\MSOLAP$SSASPT:MDX\Number of Storage Engine evaluation nodes
\MSOLAP$SSASPT:MDX\Number of cell-by-cell evaluation nodes
\MSOLAP$SSASPT:MDX\Number of bulk-mode evaluation nodes
\MSOLAP$SSASPT:MDX\Number of evaluation nodes that covered a single cell
\MSOLAP$SSASPT:MDX\Number of evaluation nodes with calculations at the same granularity
\MSOLAP$SSASPT:MDX\Current number of cached evaluation nodes
\MSOLAP$SSASPT:MDX\Number of cached Storage Engine evaluation nodes
\MSOLAP$SSASPT:MDX\Number of cached bulk-mode evaluation nodes
\MSOLAP$SSASPT:MDX\Number of cached 'other' evaluation nodes
\MSOLAP$SSASPT:MDX\Number of evictions of evaluation nodes
\MSOLAP$SSASPT:MDX\Number of hash index hits in the cache of evaluation nodes
\MSOLAP$SSASPT:MDX\Number of cell-by-cell hits in the cache of evaluation nodes
\MSOLAP$SSASPT:MDX\Number of cell-by-cell misses in the cache of evaluation nodes
\MSOLAP$SSASPT:MDX\Number of subcube hits in the cache of evaluation nodes
\MSOLAP$SSASPT:MDX\Number of subcube misses in the cache of evaluation nodes
\MSOLAP$SSASPT:MDX\Total Sonar subcubes
\MSOLAP$SSASPT:MDX\Total cells calculated
\MSOLAP$SSASPT:MDX\Total recomputes
\MSOLAP$SSASPT:MDX\Total flat cache inserts
\MSOLAP$SSASPT:MDX\Total NON EMPTY
\MSOLAP$SSASPT:MDX\Total NON EMPTY for calculated members
\MSOLAP$SSASPT:MDX\Total NON EMPTY unoptimized
\MSOLAP$SSASPT:MDX\Total Autoexist
\MSOLAP$SSASPT:MDX\Total EXISTING
\MSOLAP$SSASPT:Processing\Rows read/sec
\MSOLAP$SSASPT:Processing\Total rows read
\MSOLAP$SSASPT:Processing\Rows converted/sec
\MSOLAP$SSASPT:Processing\Total rows converted
\MSOLAP$SSASPT:Processing\Rows written/sec
\MSOLAP$SSASPT:Processing\Total rows written
\MSOLAP$SSASPT:Proc Aggregations\Current partitions
\MSOLAP$SSASPT:Proc Aggregations\Total partitions
\MSOLAP$SSASPT:Proc Aggregations\Memory size rows
\MSOLAP$SSASPT:Proc Aggregations\Memory size bytes
\MSOLAP$SSASPT:Proc Aggregations\Rows merged/sec
\MSOLAP$SSASPT:Proc Aggregations\Rows created/sec
\MSOLAP$SSASPT:Proc Aggregations\Temp file rows written/sec
\MSOLAP$SSASPT:Proc Aggregations\Temp file bytes written/sec
\MSOLAP$SSASPT:Proc Indexes\Current partitions
\MSOLAP$SSASPT:Proc Indexes\Total partitions
\MSOLAP$SSASPT:Proc Indexes\Rows/sec
\MSOLAP$SSASPT:Proc Indexes\Total rows
\MSOLAP$SSASPT:Storage Engine Query\Current measure group queries
\MSOLAP$SSASPT:Storage Engine Query\Measure group queries/sec
\MSOLAP$SSASPT:Storage Engine Query\Total measure group queries
\MSOLAP$SSASPT:Storage Engine Query\Current dimension queries
\MSOLAP$SSASPT:Storage Engine Query\Dimension queries/sec
\MSOLAP$SSASPT:Storage Engine Query\Total dimension queries.
\MSOLAP$SSASPT:Storage Engine Query\Queries answered/sec
\MSOLAP$SSASPT:Storage Engine Query\Total queries answered
\MSOLAP$SSASPT:Storage Engine Query\Bytes sent/sec
\MSOLAP$SSASPT:Storage Engine Query\Total bytes sent
\MSOLAP$SSASPT:Storage Engine Query\Rows sent/sec
\MSOLAP$SSASPT:Storage Engine Query\Total rows sent
\MSOLAP$SSASPT:Storage Engine Query\Queries from cache direct/sec
\MSOLAP$SSASPT:Storage Engine Query\Queries from cache filtered/sec
\MSOLAP$SSASPT:Storage Engine Query\Queries from file/sec
\MSOLAP$SSASPT:Storage Engine Query\Total queries from cache direct
\MSOLAP$SSASPT:Storage Engine Query\Total queries from cache filtered
\MSOLAP$SSASPT:Storage Engine Query\Total queries from file
\MSOLAP$SSASPT:Storage Engine Query\Map reads/sec
\MSOLAP$SSASPT:Storage Engine Query\Map bytes/sec
\MSOLAP$SSASPT:Storage Engine Query\Data reads/sec
\MSOLAP$SSASPT:Storage Engine Query\Data bytes/sec
\MSOLAP$SSASPT:Storage Engine Query\Avg time/query
\MSOLAP$SSASPT:Storage Engine Query\Network round trips/sec
\MSOLAP$SSASPT:Storage Engine Query\Total network round trips
\MSOLAP$SSASPT:Storage Engine Query\Flat cache lookups/sec
\MSOLAP$SSASPT:Storage Engine Query\Flat cache hits/sec
\MSOLAP$SSASPT:Storage Engine Query\Calculation cache lookups/sec
\MSOLAP$SSASPT:Storage Engine Query\Calculation cache hits/sec
\MSOLAP$SSASPT:Storage Engine Query\Persisted cache lookups/sec
\MSOLAP$SSASPT:Storage Engine Query\Persisted cache hits/sec
\MSOLAP$SSASPT:Storage Engine Query\Dimension cache lookups/sec
\MSOLAP$SSASPT:Storage Engine Query\Dimension cache hits/sec
\MSOLAP$SSASPT:Storage Engine Query\Measure group cache lookups/sec
\MSOLAP$SSASPT:Storage Engine Query\Measure group cache hits/sec
\MSOLAP$SSASPT:Storage Engine Query\Aggregation lookups/sec
\MSOLAP$SSASPT:Storage Engine Query\Aggregation hits/sec
\MSOLAP$SSASPT:Data Mining Model Processing\Cases/sec
\MSOLAP$SSASPT:Data Mining Model Processing\Current models processing
\MSOLAP$SSASPT:Data Mining Prediction\Predictions/sec
\MSOLAP$SSASPT:Data Mining Prediction\Rows/sec
\MSOLAP$SSASPT:Data Mining Prediction\Concurrent DM queries
\MSOLAP$SSASPT:Data Mining Prediction\Queries/sec
\MSOLAP$SSASPT:Data Mining Prediction\Total Queries
\MSOLAP$SSASPT:Data Mining Prediction\Total Rows
\MSOLAP$SSASPT:Data Mining Prediction\Total Predictions
\MSOLAP$SSASPT:Proactive Caching\Notifications/sec
\MSOLAP$SSASPT:Proactive Caching\Processing Cancellations/sec
\MSOLAP$SSASPT:Proactive Caching\Proactive Caching Begin/sec
\MSOLAP$SSASPT:Proactive Caching\Proactive Caching Completion/sec
\MSOLAP$SSASTR:Connection\Current connections
\MSOLAP$SSASTR:Connection\Requests/sec
\MSOLAP$SSASTR:Connection\Total requests
\MSOLAP$SSASTR:Connection\Successes/sec
\MSOLAP$SSASTR:Connection\Total successes
\MSOLAP$SSASTR:Connection\Failures/sec
\MSOLAP$SSASTR:Connection\Total failures
\MSOLAP$SSASTR:Connection\Current user sessions
\MSOLAP$SSASTR:Locks\Current latch waits
\MSOLAP$SSASTR:Locks\Latch waits/sec
\MSOLAP$SSASTR:Locks\Current locks
\MSOLAP$SSASTR:Locks\Current lock waits
\MSOLAP$SSASTR:Locks\Lock requests/sec
\MSOLAP$SSASTR:Locks\Unlock requests/sec
\MSOLAP$SSASTR:Locks\Lock grants/sec
\MSOLAP$SSASTR:Locks\Lock denials/sec
\MSOLAP$SSASTR:Locks\Lock waits/sec
\MSOLAP$SSASTR:Locks\Total deadlocks detected
\MSOLAP$SSASTR:Threads\Short parsing idle threads
\MSOLAP$SSASTR:Threads\Short parsing busy threads
\MSOLAP$SSASTR:Threads\Short parsing job queue length
\MSOLAP$SSASTR:Threads\Short parsing job rate
\MSOLAP$SSASTR:Threads\Long parsing idle threads
\MSOLAP$SSASTR:Threads\Long parsing busy threads
\MSOLAP$SSASTR:Threads\Long parsing job queue length
\MSOLAP$SSASTR:Threads\Long parsing job rate
\MSOLAP$SSASTR:Threads\Query pool idle threads
\MSOLAP$SSASTR:Threads\Query pool busy threads
\MSOLAP$SSASTR:Threads\Query pool job queue length
\MSOLAP$SSASTR:Threads\Query pool job rate
\MSOLAP$SSASTR:Threads\Processing pool idle non-I/O threads
\MSOLAP$SSASTR:Threads\Processing pool busy non-I/O threads
\MSOLAP$SSASTR:Threads\Processing pool job queue length
\MSOLAP$SSASTR:Threads\Processing pool job rate
\MSOLAP$SSASTR:Threads\Processing pool idle I/O job threads
\MSOLAP$SSASTR:Threads\Processing pool busy I/O job threads
\MSOLAP$SSASTR:Threads\Processing pool I/O job queue length
\MSOLAP$SSASTR:Threads\Processing pool I/O job completion rate
\MSOLAP$SSASTR:Memory\Page Pool 64 Alloc KB
\MSOLAP$SSASTR:Memory\Page Pool 64 Lookaside KB
\MSOLAP$SSASTR:Memory\Page Pool 8 Alloc KB
\MSOLAP$SSASTR:Memory\Page Pool 8 Lookaside KB
\MSOLAP$SSASTR:Memory\Page Pool 1 Alloc KB
\MSOLAP$SSASTR:Memory\Page Pool 1 Lookaside KB
\MSOLAP$SSASTR:Memory\Cleaner Current Price
\MSOLAP$SSASTR:Memory\Cleaner Balance/sec
\MSOLAP$SSASTR:Memory\Cleaner Memory shrunk KB/sec
\MSOLAP$SSASTR:Memory\Cleaner Memory shrinkable KB
\MSOLAP$SSASTR:Memory\Cleaner Memory nonshrinkable KB
\MSOLAP$SSASTR:Memory\Cleaner Memory KB
\MSOLAP$SSASTR:Memory\Memory Usage KB
\MSOLAP$SSASTR:Memory\Memory Limit Low KB
\MSOLAP$SSASTR:Memory\Memory Limit High KB
\MSOLAP$SSASTR:Memory\AggCacheKB
\MSOLAP$SSASTR:Memory\Quota KB
\MSOLAP$SSASTR:Memory\Quota Blocked
\MSOLAP$SSASTR:Memory\Filestore KB
\MSOLAP$SSASTR:Memory\Filestore Page Faults/sec
\MSOLAP$SSASTR:Memory\Filestore Reads/sec
\MSOLAP$SSASTR:Memory\Filestore KB Reads/sec
\MSOLAP$SSASTR:Memory\Filestore Writes/sec
\MSOLAP$SSASTR:Memory\Filestore KB Write/sec
\MSOLAP$SSASTR:Memory\Filestore IO Errors/sec
\MSOLAP$SSASTR:Memory\Filestore IO Errors
\MSOLAP$SSASTR:Memory\Filestore Clock Pages Examined/sec
\MSOLAP$SSASTR:Memory\Filestore Clock Pages HaveRef/sec
\MSOLAP$SSASTR:Memory\Filestore Clock Pages Valid/sec
\MSOLAP$SSASTR:Memory\Filestore Memory Pinned KB
\MSOLAP$SSASTR:Memory\In-memory Dimension Property File KB
\MSOLAP$SSASTR:Memory\In-memory Dimension Property File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Dimension Property File KB
\MSOLAP$SSASTR:Memory\Dimension Property Files
\MSOLAP$SSASTR:Memory\In-memory Dimension Index (Hash) File KB
\MSOLAP$SSASTR:Memory\In-memory Dimension Index (Hash) File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Dimension Index (Hash) File KB
\MSOLAP$SSASTR:Memory\Dimension Index (Hash) Files
\MSOLAP$SSASTR:Memory\In-memory Dimension String File KB
\MSOLAP$SSASTR:Memory\In-memory Dimension String File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Dimension String File KB
\MSOLAP$SSASTR:Memory\Dimension String Files
\MSOLAP$SSASTR:Memory\In-memory Map File KB
\MSOLAP$SSASTR:Memory\In-memory Map File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Map File KB
\MSOLAP$SSASTR:Memory\Map Files
\MSOLAP$SSASTR:Memory\In-memory Aggregation Map File KB
\MSOLAP$SSASTR:Memory\In-memory Aggregation Map File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Aggregation Map File KB
\MSOLAP$SSASTR:Memory\Aggregation Map Files
\MSOLAP$SSASTR:Memory\In-memory Fact Data File KB
\MSOLAP$SSASTR:Memory\In-memory Fact Data File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Fact Data File KB
\MSOLAP$SSASTR:Memory\Fact Data Files
\MSOLAP$SSASTR:Memory\In-memory Fact String File KB
\MSOLAP$SSASTR:Memory\In-memory Fact String File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Fact String File KB
\MSOLAP$SSASTR:Memory\Fact String Files
\MSOLAP$SSASTR:Memory\In-memory Fact Aggregation File KB
\MSOLAP$SSASTR:Memory\In-memory Fact Aggregation File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Fact Aggregation File KB
\MSOLAP$SSASTR:Memory\Fact Aggregation Files
\MSOLAP$SSASTR:Memory\In-memory Other File KB
\MSOLAP$SSASTR:Memory\In-memory Other File KB/sec
\MSOLAP$SSASTR:Memory\Potential In-memory Other File KB
\MSOLAP$SSASTR:Memory\Other Files
\MSOLAP$SSASTR:Memory\VertiPaq Paged KB
\MSOLAP$SSASTR:Memory\VertiPaq Nonpaged KB
\MSOLAP$SSASTR:Memory\VertiPaq Memory-Mapped KB
\MSOLAP$SSASTR:Memory\Memory Limit Hard KB
\MSOLAP$SSASTR:Memory\Memory Limit VertiPaq KB
\MSOLAP$SSASTR:Cache\Current KB
\MSOLAP$SSASTR:Cache\KB added/sec
\MSOLAP$SSASTR:Cache\Current entries
\MSOLAP$SSASTR:Cache\Inserts/sec
\MSOLAP$SSASTR:Cache\Evictions/sec
\MSOLAP$SSASTR:Cache\Total inserts
\MSOLAP$SSASTR:Cache\Total evictions
\MSOLAP$SSASTR:Cache\Direct hits/sec
\MSOLAP$SSASTR:Cache\Misses/sec
\MSOLAP$SSASTR:Cache\Lookups/sec
\MSOLAP$SSASTR:Cache\Total direct hits
\MSOLAP$SSASTR:Cache\Total misses
\MSOLAP$SSASTR:Cache\Total lookups
\MSOLAP$SSASTR:Cache\Direct hit ratio
\MSOLAP$SSASTR:Cache\Total filtered iterator cache hits
\MSOLAP$SSASTR:Cache\Total filtered iterator cache misses
\MSOLAP$SSASTR:MDX\Number of calculation covers
\MSOLAP$SSASTR:MDX\Current number of evaluation nodes
\MSOLAP$SSASTR:MDX\Number of Storage Engine evaluation nodes
\MSOLAP$SSASTR:MDX\Number of cell-by-cell evaluation nodes
\MSOLAP$SSASTR:MDX\Number of bulk-mode evaluation nodes
\MSOLAP$SSASTR:MDX\Number of evaluation nodes that covered a single cell
\MSOLAP$SSASTR:MDX\Number of evaluation nodes with calculations at the same granularity
\MSOLAP$SSASTR:MDX\Current number of cached evaluation nodes
\MSOLAP$SSASTR:MDX\Number of cached Storage Engine evaluation nodes
\MSOLAP$SSASTR:MDX\Number of cached bulk-mode evaluation nodes
\MSOLAP$SSASTR:MDX\Number of cached 'other' evaluation nodes
\MSOLAP$SSASTR:MDX\Number of evictions of evaluation nodes
\MSOLAP$SSASTR:MDX\Number of hash index hits in the cache of evaluation nodes
\MSOLAP$SSASTR:MDX\Number of cell-by-cell hits in the cache of evaluation nodes
\MSOLAP$SSASTR:MDX\Number of cell-by-cell misses in the cache of evaluation nodes
\MSOLAP$SSASTR:MDX\Number of subcube hits in the cache of evaluation nodes
\MSOLAP$SSASTR:MDX\Number of subcube misses in the cache of evaluation nodes
\MSOLAP$SSASTR:MDX\Total Sonar subcubes
\MSOLAP$SSASTR:MDX\Total cells calculated
\MSOLAP$SSASTR:MDX\Total recomputes
\MSOLAP$SSASTR:MDX\Total flat cache inserts
\MSOLAP$SSASTR:MDX\Total NON EMPTY
\MSOLAP$SSASTR:MDX\Total NON EMPTY for calculated members
\MSOLAP$SSASTR:MDX\Total NON EMPTY unoptimized
\MSOLAP$SSASTR:MDX\Total Autoexist
\MSOLAP$SSASTR:MDX\Total EXISTING
\MSOLAP$SSASTR:Processing\Rows read/sec
\MSOLAP$SSASTR:Processing\Total rows read
\MSOLAP$SSASTR:Processing\Rows converted/sec
\MSOLAP$SSASTR:Processing\Total rows converted
\MSOLAP$SSASTR:Processing\Rows written/sec
\MSOLAP$SSASTR:Processing\Total rows written
\MSOLAP$SSASTR:Proc Aggregations\Current partitions
\MSOLAP$SSASTR:Proc Aggregations\Total partitions
\MSOLAP$SSASTR:Proc Aggregations\Memory size rows
\MSOLAP$SSASTR:Proc Aggregations\Memory size bytes
\MSOLAP$SSASTR:Proc Aggregations\Rows merged/sec
\MSOLAP$SSASTR:Proc Aggregations\Rows created/sec
\MSOLAP$SSASTR:Proc Aggregations\Temp file rows written/sec
\MSOLAP$SSASTR:Proc Aggregations\Temp file bytes written/sec
\MSOLAP$SSASTR:Proc Indexes\Current partitions
\MSOLAP$SSASTR:Proc Indexes\Total partitions
\MSOLAP$SSASTR:Proc Indexes\Rows/sec
\MSOLAP$SSASTR:Proc Indexes\Total rows
\MSOLAP$SSASTR:Storage Engine Query\Current measure group queries
\MSOLAP$SSASTR:Storage Engine Query\Measure group queries/sec
\MSOLAP$SSASTR:Storage Engine Query\Total measure group queries
\MSOLAP$SSASTR:Storage Engine Query\Current dimension queries
\MSOLAP$SSASTR:Storage Engine Query\Dimension queries/sec
\MSOLAP$SSASTR:Storage Engine Query\Total dimension queries.
\MSOLAP$SSASTR:Storage Engine Query\Queries answered/sec
\MSOLAP$SSASTR:Storage Engine Query\Total queries answered
\MSOLAP$SSASTR:Storage Engine Query\Bytes sent/sec
\MSOLAP$SSASTR:Storage Engine Query\Total bytes sent
\MSOLAP$SSASTR:Storage Engine Query\Rows sent/sec
\MSOLAP$SSASTR:Storage Engine Query\Total rows sent
\MSOLAP$SSASTR:Storage Engine Query\Queries from cache direct/sec
\MSOLAP$SSASTR:Storage Engine Query\Queries from cache filtered/sec
\MSOLAP$SSASTR:Storage Engine Query\Queries from file/sec
\MSOLAP$SSASTR:Storage Engine Query\Total queries from cache direct
\MSOLAP$SSASTR:Storage Engine Query\Total queries from cache filtered
\MSOLAP$SSASTR:Storage Engine Query\Total queries from file
\MSOLAP$SSASTR:Storage Engine Query\Map reads/sec
\MSOLAP$SSASTR:Storage Engine Query\Map bytes/sec
\MSOLAP$SSASTR:Storage Engine Query\Data reads/sec
\MSOLAP$SSASTR:Storage Engine Query\Data bytes/sec
\MSOLAP$SSASTR:Storage Engine Query\Avg time/query
\MSOLAP$SSASTR:Storage Engine Query\Network round trips/sec
\MSOLAP$SSASTR:Storage Engine Query\Total network round trips
\MSOLAP$SSASTR:Storage Engine Query\Flat cache lookups/sec
\MSOLAP$SSASTR:Storage Engine Query\Flat cache hits/sec
\MSOLAP$SSASTR:Storage Engine Query\Calculation cache lookups/sec
\MSOLAP$SSASTR:Storage Engine Query\Calculation cache hits/sec
\MSOLAP$SSASTR:Storage Engine Query\Persisted cache lookups/sec
\MSOLAP$SSASTR:Storage Engine Query\Persisted cache hits/sec
\MSOLAP$SSASTR:Storage Engine Query\Dimension cache lookups/sec
\MSOLAP$SSASTR:Storage Engine Query\Dimension cache hits/sec
\MSOLAP$SSASTR:Storage Engine Query\Measure group cache lookups/sec
\MSOLAP$SSASTR:Storage Engine Query\Measure group cache hits/sec
\MSOLAP$SSASTR:Storage Engine Query\Aggregation lookups/sec
\MSOLAP$SSASTR:Storage Engine Query\Aggregation hits/sec
\MSOLAP$SSASTR:Data Mining Model Processing\Cases/sec
\MSOLAP$SSASTR:Data Mining Model Processing\Current models processing
\MSOLAP$SSASTR:Data Mining Prediction\Predictions/sec
\MSOLAP$SSASTR:Data Mining Prediction\Rows/sec
\MSOLAP$SSASTR:Data Mining Prediction\Concurrent DM queries
\MSOLAP$SSASTR:Data Mining Prediction\Queries/sec
\MSOLAP$SSASTR:Data Mining Prediction\Total Queries
\MSOLAP$SSASTR:Data Mining Prediction\Total Rows
\MSOLAP$SSASTR:Data Mining Prediction\Total Predictions
\MSOLAP$SSASTR:Proactive Caching\Notifications/sec
\MSOLAP$SSASTR:Proactive Caching\Processing Cancellations/sec
\MSOLAP$SSASTR:Proactive Caching\Proactive Caching Begin/sec
\MSOLAP$SSASTR:Proactive Caching\Proactive Caching Completion/sec

PS C:\Users\infra1> 

'