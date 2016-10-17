<#
Subject:DiskIO-measure
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS02_01_diskIO.ps1
Desc:
filename:  OS0201_diskIO.ps1
Date:Jan.08.2014
author: a0921887912@gmail.com

think
TSQL syntax
SQL configuration
Performance counter
DataFile not same location  with blg

parameter:
ts : start
t1
te : end
#>
set-alias sql invoke-sqlcmd
get-alias
#--------------------------------------------
# parameter
#--------------------------------------------

#Copy-Item h:\\scripts\GDx.ps1 -Destination "\\$h\C$\Program Files\Microsoft.NET\GD1.ps1" -force

$blgfilepath='c:\perfmon\diskIO_'+((get-date -Format HHmm)).ToString()+'.blg'  #

$perSecTransTimes    ="\PhysicalDisk(1 H:)\Disk Transfers/sec"  #每秒交易次數 < 400 /Sec  Per Disk
$AvgWritetoDiskTime  ="\PhysicalDisk(1 H:)\Avg. Disk sec/Write" #平均讀出時間   < 10m
$AvgReadfromDiskTime ="\PhysicalDisk(1 H:)\Avg. Disk sec/Read"  #平均寫入時間   < 10m
$AvgTrasnTime        ="\PhysicalDisk(1 H:)\Avg. Disk sec/Transfer"  #平均交易時間  
$PerSecDataAmount    ="\PhysicalDisk(1 H:)\Disk Bytes/sec"  #每秒交易量: < 800M Per Second
$DiskBusyRate        ="\PhysicalDisk(1 H:)\% Disk Time"  #Disk忙碌百分比 : <85%



$TestTSQL="
create table TestTB (
col1 int null,
col2 datetime null,
col3 int null,
col4 varchar(MAX)
)
;
declare @i as int
declare @max_i as int
declare @cnt as int
set @i = 0
set @max_i = 20000
while @i<@max_i
begin
   set @i = @i+1
   select @cnt=COUNT(*) from TestTB with (nolock)
   insert into TestTB values (@i  , GETDATE(), @cnt , REPLICATE ( cast ( @cnt as CHAR(8)), 100 )
   )
end
select COUNT(*), DATEDIFF(ms,min(col2),max(col2)) from TestTB with (nolock)
drop table TestTB
"
$TSQL_drop=" use M1 
drop table TestTB
"
#--------------------------------------------
# main
#--------------------------------------------
$tr = get-date;
#$t1 = [datetime] "5:10 PM";$t1 =  ($t0).AddMinutes(1)
#$t2 = [datetime] "5:12 PM";$t2 =  ($t0).AddMinutes(3)
$t1 =  $tr.AddMinutes(1)
$te =  $tr.AddMinutes(10)
#$ts.(20)AddSeconds
'(p.70)Begin--'+$tr
'(p.70)start--'+$t1;
##'(p.70)End  --'+$te


while ($te -ge $tr ) { #p.37

#if(($ts -ge $t1 ) -and ($r=$false) ){get-date |Out-File H:\scripts\while.txt -Append ; $r=$true }
# if(($tr -ge $t1 ) -and ($r -eq $false) -and ($tr.Second -eq 0)){get-date |Out-File H:\scripts\while.txt -Append ; $r=$true } 
  
  if(($tr.Minute -ge $t1.Minute )  -and ($tr.Second -eq 0 )){   #p.65
  
  # backgraud
    
$tj1=get-date ; '(p.83)tj1--  '+$tj1

$job1=start-job { param($blgfilepath) `
Get-counter -Counter "\PhysicalDisk(1 H:)\Disk Transfers/sec" ,"\PhysicalDisk(1 H:)\Avg. Disk sec/Write" `
,"\PhysicalDisk(1 H:)\Avg. Disk sec/Read","\PhysicalDisk(1 H:)\Avg. Disk sec/Transfer"`
,"\PhysicalDisk(1 H:)\Disk Bytes/sec" ,"\PhysicalDisk(1 H:)\% Disk Time" `
–Continuous  | Export-Counter -Path $blgfilepath -FileFormat blg -Force} -ArgumentList $blgfilepath

sleep 20

  # TSQL  Invoke-Sql
$ts1=get-date ; '(p.93)ts1--  '+$ts1
#Invoke-Sqlcmd -Query {drop table TestTB}  -ServerInstance "spm" -Database 'M1'
#Invoke-Sqlcmd -Query {use m1 ; select * from TestTB }  -ServerInstance "spm"   -Database 'M1'

Invoke-Sqlcmd -Query $TestTSQL  -ServerInstance "spm"  -Database 'M1' -QueryTimeout 600

<#
icm -ComputerName sql2012x  {param($TestTSQL) Invoke-Sqlcmd -Query $TestTSQL -Database 'M1' -QueryTimeout 600 `
 -ServerInstance "spm" -Username sql2012x -Password p@ssw0rd }  -ArgumentList $TestTSQL

icm -ComputerName sp2013wfe {param($TestTSQL) Invoke-Sqlcmd -Query $TestTSQL -Database 'M1' -QueryTimeout 600 `
 -ServerInstance "spm" -Username sp2013wfe -Password p@ssw0rd }  -ArgumentList $TestTSQL
 #>


$ts2=get-date ; '(p.97)ts2--  '+$ts2 
sleep 20

#--get-job *
stop-job *
remove-job *  #-id 8

"(p.105)SQL Execution  Time ="+($ts2-$ts1).TotalSeconds  +" seconds"
"----------------program finish-----"
Break
 
  } #p.65


$tr =get-date

}#p.37

<#

while ($te -ge $tr ) {

if
($tr.Second -eq 0)
{
  $tr;break

}
$tr =get-date;  "tr is  " + ($tr).ToString()
}
<#

$TestTSQL="create table TestTB (
col1 int null,
col2 datetime null,
col3 int null,
col4 varchar(MAX)
)
go
declare @i as int
declare @max_i as int
declare @cnt as int
set @i = 0
set @max_i = 20000
while @i<@max_i
begin
   set @i = @i+1
   select @cnt=COUNT(*) from TestTB with (nolock)
   insert into TestTB values (@i  , GETDATE(), @cnt , REPLICATE ( cast ( @cnt as CHAR(8)), 100 )
   )
end
select COUNT(*), DATEDIFF(ms,min(col2),max(col2)) from TestTB with (nolock)
"

--drop table TestTB


$TestTSQL="
select name,physical_name,size * 0.008172 as 'filesize(M) from  sys.master_files
order by size desc
"

$TestTSQL="use AdventureWorks2012SELECT ProductID, Name, ListPrice, ListPrice * 1.15 AS NewPriceFROM Production.ProductWHERE Name LIKE 'Mountain-%'ORDER BY ProductID ASC
"

$ct1=get-date 
Invoke-Sqlcmd -Query $TestTSQL  -ServerInstance "spm"  | ft -AutoSize
$ct2=get-date

"Totsl tims ="+($ct2-$ct1).TotalSeconds  +" seconds"






$t1=Get-Date -Format o
sleep 1
$t2=Get-Date -Format o
$t2 $t1

<#
#get-date -displayhint time


#get-date;(get-date).AddMinutes(10)


#get-date;(get-date).AddSeconds(1)
#>