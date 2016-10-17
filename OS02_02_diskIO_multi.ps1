<#
Subject:DiskIO-measure
Desc:  \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS02_02_diskIO_multi.ps1
filename:  OS0202_diskIO_multi.ps1
Date:Jan.09.2014
author: a0921887912@gmail.com
from : OS0201_diskIO.ps1
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

#--------------------------------------------
# parameter
#--------------------------------------------
$tDB="M1"
$tServerInstance="SPM"
$blgFile='c:\perfmon\diskIO_'+((get-date -Format HHmm)).ToString()+'.blg'
$runFile="C:\perfmon\TestSQL.ps1"
$Username='sa'
$perSecTransTimes    ="\PhysicalDisk(1 H:)\Disk Transfers/sec"  #每秒交易次數 < 400 /Sec  Per Disk
$AvgWritetoDiskTime  ="\PhysicalDisk(1 H:)\Avg. Disk sec/Write" #平均讀出時間   < 10m
$AvgReadfromDiskTime ="\PhysicalDisk(1 H:)\Avg. Disk sec/Read"  #平均寫入時間   < 10m
$AvgTrasnTime        ="\PhysicalDisk(1 H:)\Avg. Disk sec/Transfer"  #平均交易時間  
$PerSecDataAmount    ="\PhysicalDisk(1 H:)\Disk Bytes/sec"  #每秒交易量: < 800M Per Second
$DiskBusyRate        ="\PhysicalDisk(1 H:)\% Disk Time"  #Disk忙碌百分比 : <85%
$t2g=$False
$t3g=$False
$t4g=$False

$TestTSQL="
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
$TSQL_drop=" use M1 drop table TestTB"

$TSQL_create ="
create table TestTB (
col1 int null,
col2 datetime null,
col3 int null,
col4 varchar(MAX)
)
";

'$'+"TestTSQL= "" $TestTSQL """ | out-file $runFile  -force
"Invoke-Sqlcmd -Query "+ "$" +"TestTSQL -ServerInstance $tServerInstance  -Database $tDB -QueryTimeout 600 -Username $Username -Password p@ssw0rd  "| out-file $runFile  -Append

#--------------------------------------------
# main
#--------------------------------------------
$tr = get-date;
$t1 =  $tr.AddMinutes(1)
$te =  $tr.AddMinutes(10)

#--'(p.70)Begin--'+$tr
'(p.70)start--'+$t1;

while ($te -ge $tr ) { #p.37

  if(($tr.Minute -ge $t1.Minute )  -and ($tr.Second -eq 0 )){   #p.65
  
  # backgound
    
$tj1=get-date ; '(p.83)tj1--  '+$tj1 +'  blgFile= '+$blgFile

$job1=start-job { param($blgFile) `
Get-counter -Counter "\PhysicalDisk(1 H:)\Disk Transfers/sec" ,"\PhysicalDisk(1 H:)\Avg. Disk sec/Write" `
,"\PhysicalDisk(1 H:)\Avg. Disk sec/Read","\PhysicalDisk(1 H:)\Avg. Disk sec/Transfer"`
,"\PhysicalDisk(1 H:)\Disk Bytes/sec" ,"\PhysicalDisk(1 H:)\% Disk Time" `
–Continuous  | Export-Counter -Path $blgFile -FileFormat blg -Force} -ArgumentList $blgFile

  # TSQL  Invoke-Sql
$ts1=get-date ; '(p.93)SqlBegin--'+$ts1
$ts2=$ts1;$ts3=$ts1;$ts4=$ts1;   

Invoke-Sqlcmd -Query $TSQL_create  -ServerInstance $tServerInstance -Database $tDB -QueryTimeout 600

$job_local=start-job {param($TestTSQL,$tServerInstance,$tDB)Invoke-Sqlcmd -Query $TestTSQL   `
-ServerInstance $tServerInstance -Database $tDB -QueryTimeout 600} `
-ArgumentList $TestTSQL,$tServerInstance,$tDB

#Invoke-Sqlcmd -Query $TSQL_create  -ServerInstance spm -Database AdventureWorks2012 -QueryTimeout 600
#Invoke-Sqlcmd -Query $TestTSQL  -ServerInstance spm -Database AdventureWorks2012 -QueryTimeout 600


$job_sp2013wfe=start-job { param($runFile) icm sp2013wfe  -FilePath $runFile } -ArgumentList $runFile 
$job_sql2012x =start-job { param($runFile) icm sql2012x   -FilePath $runFile } -ArgumentList $runFile 

  do
  {
     # (get-date).ToString() +"     I'm Running"
    if(($job_local.State     -eq  'Completed') -and ($t2g -eq $False)) { $ts2=get-date ; '(p.115)local     Finish --' +$ts2 ;$t2g=$true }
    if(($job_sp2013wfe.State -eq  'Completed') -and ($t3g -eq $False)) { $ts3=get-date ; '(p.116)sp2013wfe Finish --' +$ts3 ;$t3g=$true }
    if(($job_sql2012x.State  -eq  'Completed') -and ($t4g -eq $False)) { $ts4=get-date ; '(p.117)sql2012x  Finish --' +$ts4 ;$t4g=$true }
  }
  until (($job_sql2012x.State  -eq  'Completed') -and ($job_sp2013wfe.State  -eq  'Completed') -and ($job_local.State  -eq  'Completed'))
   
   if($ts2 -eq $ts1){$ts2=get-date }
   if($ts3 -eq $ts1){$ts3=get-date }
   if($ts4 -eq $ts1){$ts4=get-date }
 
"(p.125)SQL Local      Execution  Time = "+($ts2-$ts1).TotalMinutes  +" Minutes"
"(p.126)SQL sp2013wfe  Execution  Time = "+($ts3-$ts1).TotalMinutes  +" Minutes"
"(p.127)SQL sql2012x   Execution  Time = "+($ts4-$ts1).TotalMinutes  +" Minutes"

sleep 10

remove-item $runFile
Invoke-Sqlcmd -Query $TSQL_drop  -ServerInstance $tServerInstance -Database $tDB -QueryTimeout 600
#--get-job *
stop-job *
remove-job *  #-id 8
sleep 10
Break
 
  } #p.65


$tr =get-date

}#p.37


<#

Export-Counter -InputObject (import-counter c:\perfmon\diskIO_1149.blg) -Path C:\perfmon\diskIO_1453.txt -FileFormat tsv -Force
Export-Counter -InputObject (import-counter c:\perfmon\diskIO_1153.blg) -Path C:\perfmon\diskIO_1153.csv -FileFormat csv -Force
#>

