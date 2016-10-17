
$ServerInstance='pmd2016'

$hostaname='PMD2016'
$h1='2016BI' 
$h2='PMD'
$h3='sp2013'
$h4='SQL2014X'


#--------------------------------------------------
#  funciton 
#--------------------------------------------------
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
function  mysid (){
    Invoke-Sqlcmd -ServerInstance pmd2016 -Username sqlsa -Password p@ssw0rds -Query 'select @@spid as Mysid '|ft -auto
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

#--------------------------------------------------
#   
#--------------------------------------------------
GetSQLallSID
ssms

GetTableRowSize $ServerInstance SQL_inventory

killSID 53
KillSessionByLoginname  $ServerInstance sa
KillSessionByHostname  $ServerInstance sql2014x

ssms

#--------------------------------------------------
#   
#--------------------------------------------------




truncate table [T6]
truncate table [T8]
truncate table [T9]

USE [SQL_inventory]
GO
ALTER ROLE [db_owner] ADD MEMBER [upmd2016]
GO

GRANT VIEW SERVER STATE TO upmd2016

select *  from t8 p  join  t9 w on p.inserthost= w.host_name

$scriptblock = {
Get-Counter -Counter '\Processor(_total)\% Processor Time' |foreach { $_.CounterSamples }
}
Invoke-Command -ComputerName sp2014x  -ScriptBlock $scriptblock



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

#--------------------------------------------------
#   
#--------------------------------------------------
$hostaname='PMD2016'
$h1='2016BI' 
$h2='PMD'
$h3='sp2013'
$h4='SQL2014X'


$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$h1credential = New-Object System.Management.Automation.PSCredential "\infra1",$secpasswd

$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$h2credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd

icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock $remotecommand 

 $remotecommand = {get-date ;hostname}

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


$sql2014x=
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


#---
getallSid $ServerInstance sp2013;mysid
KillSessionByHostname PMD2016 sp2013



KillSessionByHostname PMD2016 sp2013
KillSessionByHostname PMD2016 PMD2016

getallSid $ServerInstance all
getallSid $ServerInstance sp2013
getallSid $ServerInstance pmd2016
getallSid $ServerInstance sql2014x
mysid

get-help invoke-sqlcmd -Detailed


get-random
Get-Random -minimum 1 -maximum 101

#--------------------------------------------------
#   TSQL005 , insert T61 
#--------------------------------------------------

# 將

GetTableRowSize $ServerInstance SQL_inventory

function TSQL005 ( $TServerInstance ,$GServerInstance ,$Tdatabase, $Gdatabase ,$tsec ){
 #  TSQL005   PMD2016 PMD2016 SQL_inventory SQL_inventory 20
 #  
 #  select *, totalcount/testsec as [aver/sec] from [BLTSQL005] order by insertdt desc
 #  select max(rid) from t6  ;select * from t61  where rid>1890 order by  rid  desc 


function Get-randomstring ($Length){

$set    = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
$result = ""
for ($x = 0; $x -lt $Length; $x++) {
    $result += $set | Get-Random
    }
return $result  
}#Get-randomstring  38#$Tdatabase='SQL_inventory'  #測試資料庫所在 PMD2016#$Gdatabase='SQL_inventory'  #收集測試資料庫所在 SP2013#$TServerInstance='PMD2016'  #ping $ServerInstance 測試主機#$GServerInstance='PMD2016'  #ping $ServerInstance 收集資料主機$uname='u'+ $env:COMPUTERNAME   #使用的帳號#$tsec=10 ;$x=0 ;$i=0$t1=get-date$tstop=$t1.AddSeconds($tsec)do{
   
$rstring=Get-randomstring  (Get-Random -Minimum 1 -Maximum 254) ;#$rstring$val =Get-Random -Minimum 0 -Maximum 100#$udate= get-date -Format  'yyyy-mm-dd hh:mm:ss'$udate=Get-Random -Minimum 42331.63 -Maximum 42391.23$ihost=hostname$tsql_t6Insert=@"
DECLARE @rid int
Set @rid=(select max(rid)+1　as ridadd from t6)

INSERT INTO [dbo].[T61]([rid],[val],[rstring],[createDate],[updateDate],[inserthost],[SPID],[SYSTEMUSER])
     VALUES (@rid ,'$val','$rstring',getdate(),$udate,'$ihost',@@SPID,SYSTEM_USER)
GO
"@#$tsql_t6InsertInvoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase -Query $tsql_t6Insert -Username $uname -Password p@ssw0rds |out-null

if ((get-date) -ge $tstop ){
    $x=$tsec 
}
$i=$i+1
}until ($x -eq $tsec)$t2=get-date
#($t2-$t1);$i=$i+1;$i $sql_536=@"select count(session_id) as ts ,@@spid as spid FROM sys.dm_exec_sessions  where  session_id > 50"@$totalSession=Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase `-Query $sql_536 -Username sqlsa -Password p@ssw0rds  $ts=$totalSession.ts $tspid=$totalSession.spid$tsql_result=@"INSERT INTO [dbo].[BLTSQL005] ([testSec],[totalcount],[totalSession],[inserthost],[insertDT],[SPID],[SYSTEMUSER])
     VALUES ('$tsec','$i','$ts','$ihost',getdate(),@@SPID,SYSTEM_USER)
GO
"@Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Gdatabase `-Query $tsql_result -Username $uname -Password p@ssw0rds }  #478  TSQL005     1.0TSQL005   PMD2016 PMD2016 SQL_inventory SQL_inventory 10#++++++++++++++++
$tsec=5 ;$x=0
$t1=get-date$tstop=$t1.AddSeconds($tsec)
do
{
  get-date
   if (  (get-date) -ge $tstop )
{
   $x=$tsec ;$x
} 
}
until ($x -eq $tsec)
$t2=get-date
($t2-$t1)