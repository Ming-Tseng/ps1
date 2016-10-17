<#  SQLPS05_04_Lab
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_04_Lab.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createDate : Dec.15.2015
 UpdateDate : 
 history : 
 object : 
 relateion: 
 SQLPS05_DMV.ps1 line
 SQLPS0502_DMV_OSPerf
 +
#>


#--------------------------------------------------
#  table schema & basic info  ref  \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql005.ps1
#--------------------------------------------------
{<#

CREATE TABLE [dbo].[T61](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [smalldatetime] NULL,
	[insertHost] [nvarchar](128) NULL,
	[SPID] [int] NULL,
	[PPID] [int] NULL,
	[SYSTEMUSER] [nvarchar](255) NULL,
 CONSTRAINT [PK_T61] PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


GO
truncate table T61
select * from T61

CREATE TABLE [dbo].[BLTSQL005](
	[testSec] [int] NULL,
	[totalcount] [int] NULL,
	[totalSession] [int] NULL,
	[inserthost] [nvarchar](128) NULL,
	[insertDT] [datetime] NULL,
	[SPID] [int] NULL,
	[PPID] [int] NULL,
	[SYSTEMUSER] [nvarchar](255) NULL
) ON [PRIMARY]

GO




GO
select *,totalcount/testsec  as averageSec  from BLTSQL005
truncate table BLTSQL005



USE [SQL_inventory]
GO
ALTER ROLE [db_datareader] ADD MEMBER [usql2014x]
GO
USE [SQL_inventory]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [usql2014x]
GO

USE [SQL_inventory]
GO
CREATE USER [upmd2016] FOR LOGIN [upmd2016]
GO
USE [SQL_inventory]
GO
ALTER ROLE [db_datareader] ADD MEMBER [upmd2016]
GO
USE [SQL_inventory]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [upmd2016]
GO

$ServerInstance='pmd2016'

$hostaname='PMD2016'
$h1='2016BI' 
$h2='PMD'
$h3='sp2013'
$h4='SQL2014X'

$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$h2credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd


$pTServerInstance='PMD2016' $pGServerInstance='PMD2016'  $pTdatabase      ='SQL_inventory'$pGdatabase      ='SQL_inventory'$ptsec           ='10'



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
#>}




#---------------------------------------------------------------
#     1677_2551     scenario 5.2   實際開始寫入時間
#---------------------------------------------------------------
來自: \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS05_04_Lab.ps1     line:2592
# 單一 pmd2016  : local   call ps1  (run  powershell)
#5.2.1 
icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock {gps -Name powershell_ise |stop-process -force ; }
#5.2.2  如何讓Local定時自發執行不同PPID . (1) sp2013 remote call :不符此目的
                                      (2) taskschd 比較可行. 可以也需考量 taskschd.msc 執行上手時間
 

$tp1: taskschd.msc  startup time + 
$tp2: ps1 by call
$tp3: real insertDB
$tp4: close


$hhs='09' ;$hhm='50';$opt=$hhs+':'+$hhm+':00' 

#  scenario005.ps1
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\0S02_sets\scenario005.ps1
$TaskName       = "Tsql005_$hhs_hhm" # Tsql005_09_40


sqlviewbyTime 12:40:00 2015-12-15
waitrun 12 44
sqlviewbyTime 12:43:00 2015-12-15
waitrun 12 47
sqlviewbyTime 12:46:00 2015-12-15
'
upmd2016	8876	52	12/15/2015 12:46:11 PM	12/15/2015 12:46:08 PM	16	2	
upmd2016	8932	52	12/15/2015 12:43:10 PM	12/15/2015 12:43:07 PM	16	2	
upmd2016	16124	51	12/15/2015 12:40:10 PM	12/15/2015 12:40:07 PM	17	2　　<--Powershell 是不同PPID, 每一次都要 重新連接
'