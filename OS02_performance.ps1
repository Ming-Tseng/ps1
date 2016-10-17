<#-----------------------------------
#  performance  c02_performance.ps1
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS02_performance.ps1
CreateDate:  Dec.04.2013
LastDate :  

#author: a0921887912@gmail.com
$subject  : hostname/node1  ,
services.msc
(1)performance 
(2)resource 
(3)process
(4)service  monitor

firewall.cpl   enable "Windows 防火牆遠端管理 (RPC)"

OS02_01_diskIO.ps1
OS02_02_diskMulti.ps1
OS02_03_Sharepoint_SQL.ps1
OS02_04_Alwaysone.ps1

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS02_performance.ps1

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
resmon  = perfmon /res
perfmon
perfmon /rel  Reliability Monitor
taskschd.msc
# 1         Enumerating the counter groups
# 2         find right counter
# 3         accessing the counter' data
# 4   remote icm +  scriptblok + pararmeter  PowerShell DEEP DIVES ,port 445  p39
# 5    200  Using jobs for long-running tasks  icm -Asjob
# 6    249  Collecting and saving remote performance data to disk in a BLG file  PowerShell DEEP DIVES p41  ;Export-Counter
# 7    250  Import-Counter   Manipulating stored performance data from a file
# 8    300  real  Average
# 9    350  Get-AvGCPULoad.ps1   PowerShell DEEP DIVES P48
# 9-2  350  Get-AvgGlobalLoad.ps1   PowerShell DEEP DIVES P48
# 10        Find 常用效能計算器 
# 11        performance  Get-Counter  perfmon.exe
# 12   694      re-log existing data  http://technet.microsoft.com/en-us/library/hh849683.aspx
# 13        PerformanceCounterSampleSet
# 14  550  disk I/0  sample
# 15  600  disk I/0  sample
# 16  700  performance set list
# 17  750  $using parameter pass to remote  -AsJob 
# 18  878  relog  blg + blg
# 19  800  Data Collector Sets   
# 20  Using Format Commands to Change Output View 
# 21 1045  Import-Counter
#     1072  Missing SQL Server Performance Counters







#--------------------------------------------
# 1    Enumerating the counter groups
#--------------------------------------------

#Get-Counter [-ListSet] <String[]> [-ComputerName <String[]>] [<CommonParameters>]

Get-Counter –ListSet *
Get-Counter -ListSet * |sort CounterSetName  | Out-GridView

Get-Counter -ListSet * | Sort  CounterSetName | FT CounterSetName, Description –AutoSize





##  352  Counterset
Get-Counter -ListSet * | select Counter | Measure  | Select -ExpandProperty  Count
 
##  5329 counters 
Get-Counter -ListSet * | Select-Object -ExpandProperty Counter | Measure | Select-ExpandProperty Count

## Group  get count(*) by Counterset
Get-Counter -ListSet * | Select-Object -Property CounterSetName,@{n='#Counters';e={$_.counter.count}} |
 Sort-Object -Property CounterSetName | Format-Table –AutoSize
 
Get-Counter -ListSet "SQLServer:Database Replica" | Select-Object -Property CounterSetName,@{n='#Counters';e={$_.counter.count}} |
 Sort-Object -Property CounterSetName | Format-Table –AutoSize


'
CounterSetName             #Counters
--------------             ---------
SQLServer:Database Replica        11
'

#--------------------------------------------
# 2  find counter
#--------------------------------------------

Get-Counter -ListSet *disk*  |gm |select  Definition
Get-counter -ListSet  *network* | Select-Object -ExpandProperty Paths 
Get-counter -ListSet  *SQLServer* | Select-Object -ExpandProperty Paths 


#---1 Get counterSetname
Get-Counter -ListSet *SQLServer*  |select counterSetname

Get-Counter -ListSet *MSOLAP* | Select-Object -ExpandProperty Paths
#---2 
Get-Counter -ListSet  "SQLServer:Database Replica" |select counter |ft -AutoSize
Get-Counter -ListSet  "SQLServer:Database Replica" |Select-Object -ExpandProperty Paths
'
\SQLServer:Database Replica(*)\Recovery Queue
\SQLServer:Database Replica(*)\Redone Bytes/sec
\SQLServer:Database Replica(*)\Log Send Queue
\SQLServer:Database Replica(*)\Log Bytes Received/sec
\SQLServer:Database Replica(*)\File Bytes Received/sec
\SQLServer:Database Replica(*)\Mirrored Write Transactions/sec
\SQLServer:Database Replica(*)\Transaction Delay
\SQLServer:Database Replica(*)\Total Log requiring undo
\SQLServer:Database Replica(*)\Log remaining for undo
\SQLServer:Database Replica(*)\Redo Bytes Remaining
\SQLServer:Database Replica(*)\Redo blocked/sec
'
#--3 find
Get-Counter  -counter  '\SQLServer:Database Replica(*)\Transaction Delay' |Out-GridView
Get-Counter  -counter  '\sqlserver:database replica(194_sp_centraladmincontent)\transaction delay' -ComputerName sql2012x
Get-Counter  -counter  '\sqlserver:database replica(_total)\transaction delay' -ComputerName sql2012x


Get-Counter  -counter "SQLServer:Database Replica"
TypeName: Microsoft.PowerShell.Commands.GetCounter.CounterSet
'Name               MemberType    Definition                                    
----               ----------    ----------                                    
Counter            AliasProperty Counter = Paths                               

Equals             Method        bool Equals(System.Object obj)                
GetHashCode        Method        int GetHashCode()                             
GetType            Method        type GetType()                                
ToString           Method        string ToString()                             

CounterSetName     Property      string CounterSetName {get;}                  
CounterSetType     Property      System.Diagnostics.PerformanceCounterCatego...
Description        Property      string Description {get;}                     
MachineName        Property      string MachineName {get;}                     
Paths              Property      System.Collections.Specialized.StringCollection Paths {get;}                   
PathsWithInstances Property      System.Collections.Specialized.StringCollection PathsWithInstances {get;}      
'


##
Get-Counter -ListSet *disk* | Select-Object -ExpandProperty Paths |gm
'
\SharePoint Disk-Based Cache(*)\Old Blob Cache Folders Pending Delete
\SharePoint Disk-Based Cache(*)\Total Objects Currently Being Transferred to blob cache
\SharePoint Disk-Based Cache(*)\Total objects in Blob Cache
\SharePoint Disk-Based Cache(*)\Total blob index writes
\SharePoint Disk-Based Cache(*)\Total number of objects added to blob cache
\SharePoint Disk-Based Cache(*)\Blob cache hit ratio
\SharePoint Disk-Based Cache(*)\Blob cache miss count
\SharePoint Disk-Based Cache(*)\Blob cache misses / sec
....
'

#--------------------------------------------
# 3   accessing the counter' data
#--------------------------------------------
Get-Counter [[-Counter] <String[]>] 
[-ComputerName <String[]>] 
[-Continuous]
[<SwitchParameter>]] 
[-MaxSamples <Int64>] 
[-SampleInterval <Int32>]
[<CommonParameters>]

Get-Counter -Counter '\Processor(*)\% Processor Time'
Get-Counter -Counter '\Processor(_total)\% Processor Time'

## Controlling the sampling and the collection interval
Get-Counter -Counter '\Processor(_total)\% Processor Time' –MaxSample 5
Get-Counter -Counter '\Processor(_total)\% Processor Time' –MaxSample 3 -SampleInterval 5

Get-Counter -Counter '\Processor(_total)\% Processor Time' –MaxSample 5 -ComputerName sql2012x

#--------------------------------------------
# 4   remote icm +  scriptblok + pararmeter  PowerShell DEEP DIVES ,port 445& 135   p39
#--------------------------------------------
'Remote Service Management (NP-In)  : port 445 '
Get-Counter -Counter '\Processor(_total)\% Processor Time' –ComputerName DGPAp1,DGPAp2

Get-Counter -Counter `
 '\\DGPAp1\Processor(_total)\% Processor Time'`
,'\\DGPAp2\Processor(_total)\% Processor Time'

$PCR="\Processor(_total)\% Processor Time","\Processor(_total)\% Processor Time"
$Node="DGPAp1","DGPAp2"
do
{
   Get-Counter -Counter $PCR –ComputerName $Node
   sleep 2 
}
until ($x -gt 0)



'PowerShell uses serialization.
That means the data you receive from a remote computer is serialized into XML
to cross the network and then deserialized on your local machine

Setting a value of two levels of depth would be sufficient.
'

$scriptblock = {Get-Counter -Counter '\Processor(_total)\% Processor Time'}
Invoke-Command -ComputerName sql2014x -ScriptBlock $scriptblock # pass Nov.18.2015

$r = Invoke-Command -ComputerName DGPAp1,DGPAp2 -ScriptBlock $scriptblock

$r[0].CounterSamples
#$r |select *
$r.CounterSamples  #two levels of depth

Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample

# other 1

$scriptblock = {
Get-Counter -Counter '\Processor(_total)\% Processor Time' |foreach { $_.CounterSamples }
}
Invoke-Command -ComputerName DGPAp1  -ScriptBlock $scriptblock
'
Path                InstanceName                CookedValue PSComputerName     
----                ------------                ----------- --------------     
\\dgpap1\process... _total                 1.58643417920762 DGPAp1             


'
# other 2  -error

$scriptblock = {
Update-TypeData -TypeName Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet -SerializationDepth 2 –force
Get-Counter -Counter '\Processor(_total)\% Processor Time'
}
$r = Invoke-Command -ComputerName sql2014x  -ScriptBlock $scriptblock
$r | Select-Object –ExpandProperty CounterSamples

$r.CounterSamples |select CookedValue
$r.CounterSamples.CookedValue
#--------------------------------------------
# 5  200  Using jobs for long-running tasks  icm -Asjob
#--------------------------------------------
$scriptblock = {
Get-Counter -Counter '\Processor(_total)\% Processor Time' |foreach { $_.CounterSamples }
}
$r = Invoke-Command -Computer DGPAp1  -ScriptBlock $scriptblock –AsJob
$r | Receive-Job | Select-Object -ExpandProperty CounterSamples



stop-job 5
remove-job *; get-job 
#--------------------------------------------
# 6   249 Collecting and saving remote performance data to disk in a BLG file  PowerShell DEEP DIVES p41  ;Export-Counter
#--------------------------------------------
'Export-Counter
 [-Path] <String> 
 [-Circular [<SwitchParameter>]]
[-FileFormat <String>] 
[-Force [<SwitchParameter>]] 
[-MaxSize <UInt32>]
-InputObject <PerformanceCounterSampleSet[]> 
[<CommonParameters>]
'
#--- to BLG 
Saving the data to a binary file (BLG)
$counters = '\Processor(*)\% Processor Time',
'\Memory\Committed Bytes',
'\Memory\Available Bytes', '\Memory\Pages/sec',
'\Process(*)\Working Set - Private',
'\PhysicalDisk(_Total)\Disk Reads/sec',
'\PhysicalDisk(_Total)\Disk Writes/sec'

Get-Counter -Counter $counters -MaxSamples 120 -SampleInterval 1 | Export-Counter -Path C:\perfmon\capture1.blg -FileFormat blg


# example 1  Collecting and saving remote performance data to disk in a BLG file
#requires -version 3.0
$counters = '\Processor(*)\% Processor Time',
'\Memory\Committed Bytes',
'\Memory\Available Bytes', '\Memory\Pages/sec',
'\Process(*)\Working Set - Private',
'\PhysicalDisk(_Total)\Disk Reads/sec',
'\PhysicalDisk(_Total)\Disk Writes/sec'
Invoke-Command -ScriptBlock { Get-Counter -Counter $using:counters -MaxSamples 120 -SampleInterval 1 |
Export-Counter -Path C:\PerfLogs\capture2.blg -FileFormat blg } `
-AsJob -ComputerName DGPAP1, DGPAP1

$PCR="\Processor(_total)\% Processor Time"
$jobx=
start-job  {Get-Counter $using:PCR -MaxSamples 61 -SampleInterval 1 |Export-Counter -Path C:\PerfLogs\capture7.blg -FileFormat blg -force}


get-job


icm  { Get-Counter -Counter $using:counters -MaxSamples 120 -SampleInterval 1|
Export-Counter -Path C:\PerfLogs\capture2.blg -FileFormat blg  -Force } -ComputerName DGPAP2  -AsJob


get-job
remove-job 7

#--- to CSV
 Get-Counter -Counter $counters -MaxSamples 120 -SampleInterval 1 |
➥ Export-Counter -Path C:\PerfLogs\capture1.csv -FileFormat csv

#--------------------------------------------
# 7  250  Import-Counter   Manipulating stored performance data from a file
#--------------------------------------------
'
Import-Counter [-Path] <String[]> 
[-Counter <String[]>]
[-EndTime <DateTime>] 
[-MaxSamples <Int64>] 
[-StartTime <DateTime>]

Import-Counter 
[-Path] <String[]> 
-ListSet <String[]>

Import-Counter 
[-Path] <String[]> 
[-Summary [<SwitchParameter>]]
'
#

$PCR="\Processor(*)\% Processor Time"
start-job {Get-Counter  $using:PCR -MaxSamples 30 -SampleInterval 2 |Export-Counter -Path C:\PerfLogs\capture2.blg -FileFormat blg -Force }

Get-Counter  $PCR -MaxSamples 30 -SampleInterval 2

remove-job * ; Receive-Job -Name Job20
get-job

Import-Counter -Path  C:\PerfLogs\capture2.blg  -Summary 
Import-Counter -Path  C:\PerfLogs\capture2.blg  -Listset *

#
get-Counter -MaxSamples 30 -SampleInterval 2  |  Export-Counter -Path h:\Temp\temp.csv -FileFormat csv  -Force
get-Counter -MaxSamples 30 -SampleInterval 2  |  Export-Counter -Path h:\Temp\temp.blg -FileFormat blg ;

ii h:\Temp\temp.csv ;  ri h:\Temp\temp.csv 
ii h:\Temp\temp.blg  ; ri h:\Temp\temp.blg

$data=Import-Counter -Path h:\Temp\temp.csv  –ErrorAction 'SilentlyContinue'
$idata  =Import-Counter -Path h:\Temp\temp.csv  -counter "\\sp2013\network interface(red hat virtio ethernet adapter)\bytes total/sec" –ErrorAction 'SilentlyContinue'
$data | Export-Counter -Path h:\Temp\temp1.blg -FileFormat blg ;ii h:\Temp\temp1.blg
$data.Count
$Data[0];$Data[29]

.CounterSamples 
$Data[0].CounterSamples | Format-Table -Property Path

Import-Counter -Path h:\Temp\temp.csv  -ListSet *
'
CounterSetName     : physicaldisk
MachineName        : \\sp2013
CounterSetType     : SingleInstance
Description        : Physical Disk 效能物件包含了數個計數器，用來監視電腦上的磁碟機或固定式硬碟。磁碟機用來儲存檔案，程式及分頁資料，並且可以進行讀取操作來抓取資料，或寫入變更的資料。實體磁碟計數器的值是個別邏輯磁碟 (或磁碟分割) 計數值的總和。
Paths              : {\\sp2013\physicaldisk(*)\current disk queue length, \\sp2013\physicaldisk(*)\% disk time}
PathsWithInstances : {\\sp2013\physicaldisk(_total)\current disk queue length, \\sp2013\physicaldisk(_total)\% disk time}
Counter            : {\\sp2013\physicaldisk(*)\current disk queue length, \\sp2013\physicaldisk(*)\% disk time}

CounterSetName     : memory
MachineName        : \\sp2013
CounterSetType     : SingleInstance
Description        : [Memory] 效能物件包含數個計數器，這些計數器描述電腦中實體記憶體與虛擬記憶體的行為。實體記憶體是電腦上的隨機存取記憶體。虛擬記憶體則是由實體記憶體空間與磁碟空間所組成。許多記憶體計數器都會監視「分頁操作」，所謂「分頁操作」是指程式碼頁與資料頁
                     在磁碟與實體記憶體之間的移動。過度分頁是記憶體不足時會發生的情形，這會造成延遲並干擾所有系統處理程序。
Paths              : {\\sp2013\memory\% committed bytes in use, \\sp2013\memory\cache faults/sec}
PathsWithInstances : {}
Counter            : {\\sp2013\memory\% committed bytes in use, \\sp2013\memory\cache faults/sec}

CounterSetName     : processor
MachineName        : \\sp2013
CounterSetType     : SingleInstance
Description        : Processor 效能物件包含數個計數器，負責計算處理器活動狀況。處理器是電腦的一部分，可執行數學及邏輯的計算、初始化周邊裝置的操作，並執行處理程序的執行緒。一台電腦可以有數個處理器。不同的處理器物件例項代表不同的處理器。
Paths              : {\\sp2013\processor(*)\% processor time}
PathsWithInstances : {\\sp2013\processor(_total)\% processor time}
Counter            : {\\sp2013\processor(*)\% processor time}

CounterSetName     : network interface
MachineName        : \\sp2013
CounterSetType     : MultiInstance
Description        : Network Interface 效能物件含有數個計數器，用來計算透過網路連線傳送及接收位元組和封包的速率。它也包含監視連線錯誤的計數器。
Paths              : {\\sp2013\network interface(*)\bytes total/sec}
PathsWithInstances : {\\sp2013\network interface(isatap.{0dfe1266-8578-4fc7-9019-29e96268fd0c})\bytes total/sec, \\sp2013\network 
                     interface(isatap.cake.localdomain)\bytes total/sec, \\sp2013\network 
                     interface(isatap.{7d3a7140-dffe-4296-a66a-9b20fa0e2963})\bytes total/sec, \\sp2013\network interface(red hat virtio ethernet 
                     adapter _2)\bytes total/sec...}
Counter            : {\\sp2013\network interface(*)\bytes total/sec}

'


#
$data=Import-Counter -Path C:\PerfLogs\capture2.blg   –ErrorAction 'SilentlyContinue'
$data[1].Timestamp - $data[0].Timestamp | Select-Object TotalSeconds
($data[1].Timestamp - $data[0].Timestamp).TotalMilliseconds






#--------------------------------------------
# 8  300  real  Average
#--------------------------------------------
 what is avg. disk sec/write 

$data=Import-Counter -Path C:\perfmon\diskIO_1356.blg -Summary
'
Import-Counter -Path C:\perfmon\diskIO_1356.blg -Summary

OldestRecord                   NewestRecord                   SampleCount      
------------                   ------------                   -----------      
1/9/2014 1:57:02 PM            1/9/2014 2:06:55 PM            588              
'
($data.NewestRecord - $data.OldestRecord).TotalMinutes '9.87315 min '

$data = Import-Counter -Path C:\perfmon\diskIO_1356.blg `
-Counter '\\sp2013\physicaldisk(1 h:)\avg. disk sec/write'
$data.Count #'588'
$date |select *
# Overall average calculation
Status           : 0
$d = $data | Select-Object -Expand countersamples | where status -eq 0
$real= $d[0..($d.Count-1)] | Measure-Object –Property cookedvalue -Average
$real.Count; $real.Average
'
Count    : 588
Average  : 0.000810088770276099
Sum      : 
Maximum  : 
Minimum  : 
Property : CookedValue

'

##

$data | Select-Object -Expand countersamples |select * 
'
Path             : \\sp2013\physicaldisk(1 h:)\avg. disk sec/write
InstanceName     : 1 h:
CookedValue      : 0.000872897188429015
RawValue         : 2817390068
SecondValue      : 997938
MultipleCount    : 1
CounterType      : AverageTimer32
Timestamp        : 1/9/2014 1:58:12 PM
Timestamp100NSec : 130337494924120000
Status           : 0
DefaultScale     : 3
TimeBase         : 3579545
'
$data | Select  countersamples
'
CounterSamples                                                                                                                                                               
--------------                                                                                                                                                               
{1 h:}                                                                                                                                                                       
{1 h:} 
'

$data | Select -Expand countersamples
'
Path                                                      InstanceName                                            CookedValue
----                                                      ------------                                            -----------
\\sp2013\physicaldisk(1 h:)\avg. disk sec/write           1 h:                                                  0.000853842941147333
\\sp2013\physicaldisk(1 h:)\avg. disk sec/write           1 h:                                                  0.000828568423971112

'

$data |  Export-Counter -Path C:\PerfLogs\capture2+1.blg 
#--------------------------------------------
# 9 350  Get-AvGCPULoad.ps1   PowerShell DEEP DIVES P48
#--------------------------------------------
#requires -version 3.0
Param (
[parameter(Mandatory=$true)]  [string]$File,
[parameter(Mandatory=$false)] [int] $interval = 5 # default value
)
#Counter’s path to collect
$counter = '\\*\Processor(_Total)\% Processor Time'
$data = Import-Counter -path $file -Counter $counter
#Filters out the erroneous counter values
$d = $data | Select-Object -Expand countersamples |Where status -eq 0

# Loop starts at index 1 to avoid bad data at index 0
for ($i=1; $i -lt $d.count ; $i+=$interval)
{
# Custom object creation with two properties (timestamp and CPUAvg)
New-Object -TypeName PSObject -Property @{Timestamp = $d[$i].Timestamp; CPUAvg = $d[$i..($i+($interval - 1))] |
Measure-Object -Prop cookedvalue -Average | Select-Object -ExpandProperty Average
}
}
#call the script and provide a BLG file path and an interval:
./Get-AvgCPULoad.ps1 -File C:\temp\DataCollector01.blg –interval 10
'
Timestamp                         CPUAvg
---------                         ------
06/11/2012 11:00:29 PM       89.7425991823448
06/11/2012 11:10:28 PM       99.9192712443985
06/11/2012 11:20:28 PM       99.2941515599998
06/11/2012 11:30:28 PM       96.1755994404801
06/11/2012 11:40:28 PM       18.2450261493011
06/11/2012 11:50:28 PM       27.4416675911747

'
#--------------------------------------------
# 9-2  350   Get-AvgGlobalLoad.ps1   PowerShell DEEP DIVES P48
#--------------------------------------------
{
Param (
[parameter(Mandatory=$true)]
[string]$File,
[parameter(Mandatory=$false)]
[int]$interval = 5
)
$counter = '\\*\Processor(_Total)\% Processor Time',
'\\*\Memory\Available Bytes',
'\\*\Memory\Pages/sec'

$data = Import-Counter -path $file -Counter $counter

$d = $data | where {$_.countersamples.status -eq 0}

for ($i=1; $i -lt $d.count ; $i+=$interval)
{
$UBound = $i+($interval-1)
New-Object -TypeName PSObject -Property ([Ordered]@{Timestamp = $d[$i].Timestamp; CPUAvg = [int]($d[$i..$UBound] |
where {$_.CounterSamples.Path -like $counter[0]} |
foreach {$_.countersamples[0].cookedvalue} |
Measure-Object -Average |
Select-Object -ExpandProperty Average )

;MemoryAvailableByteAvg = [int](($d[$i..$UBound] |
where {$_.CounterSamples.Path -like $counter[1]} |
foreach {$_.countersamples[1].cookedvalue} |
Measure-Object -Average |
Select-Object -ExpandProperty Average) / 1MB)

;MemoryPageAvg = [int]($d[$i..$UBound] |
where {$_.CounterSamples.Path -like $counter[2]} |
foreach {$_.countersamples[2].cookedvalue} |
Measure-Object -Average |
Select-Object -ExpandProperty Average)
})
}
./Get-AvgGlobalLoad.ps1 -File C:\temp\DataCollector01.blg -interval 10

'
Timestamp                     CPUAvg MemoryAvailableByteAvg MemoryPageAvg
---------                     ------ ---------------------- -------------
06/11/2014 11:00:29 PM            90                      48          313
06/11/2014 11:10:28 PM           100                      36          314
06/11/2014 11:20:28 PM            99                      24          701
06/11/2014 11:30:28 PM            96                     108          498
06/11/2014 11:40:28 PM            18                      70          393
06/11/2014 11:50:28 PM            27                      58          945
'
'
This presents a pretty clear picture. Your monitored system, in addition to the CPU
performance issue, is also running out of physical memory and is using the swap file a
lot. It would be worth digging deeper in order to find the responsible process or processes.
As long as the data is available you could write such a script to find the source
of the problem
'
}
#--------------------------------------------
# 10 find 常用效能計算器
#--------------------------------------------
{

\\DGPAP1\web service(sp)\current connections  # get-counter "\\$ServerName\web service($SiteName)\current connections"
SQLServer:General Statistics  # use connection 
$perSecTransTimes    ="\PhysicalDisk(1 H:)\Disk Transfers/sec"  #每秒交易次數 < 400 /Sec  Per Disk
$AvgWritetoDiskTime  ="\PhysicalDisk(1 H:)\Avg. Disk sec/Write" #平均讀出時間   < 10m
$AvgReadfromDiskTime ="\PhysicalDisk(1 H:)\Avg. Disk sec/Read"  #平均寫入時間   < 10m
$AvgTrasnTime        ="\PhysicalDisk(1 H:)\Avg. Disk sec/Transfer"  #平均交易時間  
$PerSecDataAmount    ="\PhysicalDisk(1 H:)\Disk Bytes/sec"  #每秒交易量: < 800M Per Second
$DiskBusyRate        ="\PhysicalDisk(1 H:)\% Disk Time"  #Disk忙碌百分比 : <85%
}
#--------------------------------------------
# 12  performance   Get-Counter   perfmon.exe
#--------------------------------------------
{
##get

Get-Counter -ListSet * |select  CounterSetName |sort CounterSetName
(get-counter -listset "sharepoint foundation").paths

$fileName = "scenario{0:yyyyMMdd-HHmmss}.blg" -f (Get-Date)




Get-help get-counter -full

Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -MaxSamples 3
Get-counter -Counter "\Memory\Available KBytes" –Continuous

Get-counter "\\sql2012x\physicaldisk(_total)\% disk time"   –Continuous


Get-counter "\\sp2013\physicaldisk(_total)\LogicalDisk\% Free Space"   –Continuous
Get-counter "\LogicalDisk\% Free Space"   –Continuous

# list 
Get-Counter -ListSet * ;$x.count ; $x|gm #"counts=306", CounterSetName,CounterSetType,Description,Paths,PathsWithInstances


# performance counters in the Memory counter set on the local computer.
(Get-Counter -ListSet Memory).Paths   
(Get-Counter -ListSet Memory).Paths | ? {$_ -like "*Cache*"}

(Get-Counter -List PhysicalDisk).PathsWithInstances  # PhysicalDisk performance counters, including the instance names.

(Get-Counter -ListSet PhysicalDisk).Paths 
(Get-Counter -ListSet PhysicalDisk).Paths  |  ? {$_ -like "*Write*"}

Get-Counter "\PhysicalDisk(*)\Avg. Disk sec/Transfer"  #可由(*)先得磁碟機代號 

Get-Counter  '\\sp2013\physicaldisk(0 c:)\Disk Writes/sec' -SampleInterval 2  -Continuous
Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  > D:\perfmon\sample1.csv
Get-Counter  '\\sp2013\PhysicalDisk(_total)\Disk Bytes/sec' -SampleInterval 2 -MaxSamples 6  |out-file D:\perfmon\sampletxt.txt  -Append


# 合併所需地counter
$cMemory=(Get-Counter -ListSet Memory).Paths | ? {$_ -like "*Cache*"}
$cPhysicalDisk=(Get-Counter -ListSet PhysicalDisk).Paths  |  ? {$_ -like "*Write*"}
$cSum=$cMemory+$cPhysicalDisk
Get-Counter -Counter $cSum 
Get-Counter -Counter $cSum   -MaxSamples 4 -SampleInterval 1  | Export-Counter -Path D:\perfmon\cSum.blg -FileFormat blg

#
 $DiskReads = "\LogicalDisk(C:)\Disk Reads/sec"
  $DiskReads | Get-Counter -Computer sp2013, SQL2012X -MaxSamples 10 #The command uses the MaxSamples parameter to limit the output to 10 samples.
#PerformanceCounterSample object
{
$Counter = "\\SERVER01\Process(Idle)\% Processor Time"
$Data = Get-Counter $Counter
$Data.CounterSamples | Format-List –Property *
}
# runs a Get-Counter command as background job.
Start-Job -ScriptBlock {Get-Counter -Counter "\LogicalDisk(_Total)\% Free Space" -MaxSamples 1000}

# find the percentage of free disk space on 50 computers selected randomly from the 
Get-Counter -ComputerName (Get-Random Servers.txt -Count 50) -Counter "\LogicalDisk(*)\% Free Space"


#shows how to associate counter data with the computer on which it originated, and how to manipulate the data.
 $DiskSpace = Get-Counter "\LogicalDisk(_Total)\% Free Space" -ComputerName s1, s2
 $DiskSpace
 $DiskSpace.CounterSamples | Format-Table -AutoSize "notice  Path,InstanceName,CookedValue"
 $DiskSpace.countersamples[0] | Format-Table -Property *
 $DiskSpace.CounterSamples | Where-Object {$_.CookedValue -lt 15}   "get only the counter samples with a CookedValue of less than 15."

 #sort the performance counter data that you retrieve.
 $p = Get-counter '\Process(*)\% Processor Time'
  $p.CounterSamples | Sort-Object -Property CookedValue -Descending | Format-Table -Auto

#find the processes on the computer with the largest working sets
$ws = Get-Counter "\Process(*)\Working Set - Private"
 $ws.CounterSamples | Sort-Object -Property CookedValue -Descending | Format-Table -Property InstanceName, CookedValue -AutoSize

#gets a series of samples of the Processor\% Processor Time counter at the default one second interval. To stop the command, press CTRL + C.
Get-Counter -Counter "\Processor(_Total)\% Processor Time" -Continuous

## export
Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous | Export-counter -Path C:\perfmon\Disk_Bytes.blg -Force
Get-counter "\Processor(*)\% Processor Time" -SampleInterval 2 -MaxSamples 100 | Export-counter -Path D:\perfmon\Processor_Time.blg
Get-counter "\Processor(*)\% Processor Time" -SampleInterval 2 -MaxSamples 100 | Export-counter -Path D:\perfmon\Processor_Time.blg

Get-counter "\\sp2013\physicaldisk(_total)\% disk time" -SampleInterval 1 -MaxSamples 4 | Export-counter -Path $home\disk_time.csv

Get-Counter -Counter (get-Counter -ListSet memory).paths -MaxSamples 4 -SampleInterval 1  | Export-Counter -Path D:\perfmon\memory.blg -FileFormat blg
Get-Counter -Counter (get-Counter -ListSet memory).paths -MaxSamples 4  -SampleInterval 1 | Export-Counter -Path D:\perfmon\memory.csv -FileFormat csv

Get-Counter -Counter (get-Counter -ListSet memory).paths -MaxSamples 4000 -SampleInterval 1 | Export-Counter -Path D:\perfmon\memory.blg -FileFormat blg -MaxSize 1 -Force

Export-Counter -InputObject (import-counter C:\perfmon\Disk_Bytes.blg) -Path C:\perfmon\Disk_Bytes.txt -FileFormat tsv -Force

#
$c = Get-Counter -ComputerName Server01 -Counter "\Process(*)\Working Set - Private" -MaxSamples 20
$c | Export-Counter -Path \\Server01\Perf\WorkingSet.blg


# import-counter
Import-Counter  $home\disk_time.csv | Export-Counter -Path $home\ThreadTest.blg -Circular -MaxSize $1GBinBytes
}
#--------------------------------------------
# 13  694 re-log existing data  http://technet.microsoft.com/en-us/library/hh849683.aspx
#--------------------------------------------
$All = Import-Counter DiskSpace.blg
$LowSpace = $All.CounterSamples | where {$_.CookedValues -lt 15}
$LowSpace | Export-Counter -Path LowDiskSpace.blg

#--------------------------------------------
# 14 550  PerformanceCounterSampleSet
#--------------------------------------------
$memory=(get-Counter -ListSet memory).paths
$t=Get-Counter -Counter $memory
[int64]::MaxValue

$t |gm  # 
<#$t |gm
   TypeName: Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet

Name           MemberType     Definition                                                                                                                        
----           ----------     ----------                                                                                                                        
Equals         Method         bool Equals(System.Object obj)                                                                                                    
GetHashCode    Method         int GetHashCode()                                                                                                                 
GetType        Method         type GetType()                                                                                                                    
ToString       Method         string ToString()                                                                                                                 
CounterSamples Property       Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSample[] CounterSamples {get;set;}                                     
Timestamp      Property       datetime Timestamp {get;set;}                                                                                                     
Readings       ScriptProperty System.Object Readings {get=$strPaths = ""... 
#>


#$t[0].CounterSamples | gm

$t.CounterSamples

$t | % { $_.counterSamples } | sort path | ft timestamp, path, cookedvalue
$t | % { $_.counterSamples } | sort path | ft timestamp, path, cookedvalue -Wrap –AutoSize
$t | % { $_.counterSamples } | sort path | ft timestamp, path, cookedvalue -Wrap –AutoSize |out-file D:\perfmon\sampletxt.txt  -Append
 
# HideTableHeaders
|ft -HideTableHeaders

#-------------------------------------------- 
Get-Process


Get-Service  | ? {$_.displayname -like '*sql*'}


Get-Command *VM*


Enable-VMResourceMetering –VMName Greendale-VM



#--------------------------------------------
# 15 600  disk I/0  sample
#--------------------------------------------
{
$perSecTransTimes    ="\PhysicalDisk(1 H:)\Disk Transfers/sec"  #每秒交易次數 < 400 /Sec  Per Disk
$AvgWritetoDiskTime  ="\PhysicalDisk(1 H:)\Avg. Disk sec/Write" #平均讀出時間   < 10m
$AvgReadfromDiskTime ="\PhysicalDisk(1 H:)\Avg. Disk sec/Read"  #平均寫入時間   < 10m
$AvgTrasnTime        ="\PhysicalDisk(1 H:)\Avg. Disk sec/Transfer"  #平均交易時間  
$PerSecDataAmount    ="\PhysicalDisk(1 H:)\Disk Bytes/sec"  #每秒交易量: < 800M Per Second
$DiskBusyRate        ="\PhysicalDisk(1 H:)\% Disk Time"  #Disk忙碌百分比 : <85%
#$DiskBusyRate , $perSecTransTimes,$AvgWritetoDiskTime,$AvgWritetoDiskTime,`
#,$AvgTrasnTime+$PerSecDataAmount


$t1=get-date ; $t1
Get-Counter -Counter $perSecTransTimes ,$AvgWritetoDiskTime,$AvgReadfromDiskTime,$AvgTrasnTime,`
$PerSecDataAmount ,$DiskBusyRate -MaxSamples 120 -SampleInterval 1 `
| Export-Counter -Path H:\perfmon\diskx.blg -FileFormat blg -Force
$t2=get-date ; $t2
$t1 - $t2


-MaxSamples 4 -SampleInterval 1 | Export-Counter -Path D:\perfmon\memory.blg -FileFormat blg

$t1=get-date ; 't1- '+$t1
$job=start-job -scriptblock { Get-Counter -Counter "\Processor(_Total)\% Processor Time"  -SampleInterval 1 -Continuous `
  | Export-Counter -Path H:\perfmon\run.blg -FileFormat blg -Force 
  }



sleep 10
$t2=get-date ; 't1- '+$t2
$t1 - $t2
$job | stop-job ;#$job | Remove-Job
Get-Job
   

}


#--------------------------------------------
# 16 700  performance set list
#--------------------------------------------
{
.NET CLR 
Access Services
APP_POOL_WAS
AppFabric Caching
ASP.NET
BITS Net Utilization
Browser
Browser CEIP 
Cache
Classification Engine
Cluster  (API Calls ,API Handles ,Checkpoint Manager ,CSV Block Redirection ,CSV Coordinator ,CSV File System ,CSV Volume Cache ,CSV Volume Manager ,Database ,Global Update Manager Messages ,Multicast Request-Response Messages ,Network Messages ,Network Reconnections ,Resource Control Manager ,Resources) 
CMS URL Redirection
Database
Distributed Transaction Coordinator
Document Conversions
Education Services
Event
HTTP Service
Hyper-V Dynamic Memory Integration Service 
InfoPath Forms Services 
Internet Information Services Global
IPHTTPS
IPsec
IPv4 , IPv6

LogicalDisk
Memory
MSSQL$SQLS2
Network Adapter
Network Interface
Network QoS Policy
Netlogon
Network Adapter
Network Interface
Network QoS Policy
Office Web Apps
PhysicalDisk
Process
Processor
Search
Security
Server
Services Infrastructure - Logging
SharePoint


SQLAgent$SQLS2
SQLServer
System
TCPv4
USB
Visio Server
W3SVC_W3WP 
WAS_W3WP 
Web Service 
WFPv4 
WMI Objects


}

#--------------------------------------------
# 17  750 $using parameter pass to remote  -AsJob 
#--------------------------------------------

$counters = '\Processor(*)\% Processor Time',
'\Memory\Committed Bytes',
'\Memory\Available Bytes', '\Memory\Pages/sec',
'\Process(*)\Working Set - Private',
'\PhysicalDisk(_Total)\Disk Reads/sec',
'\PhysicalDisk(_Total)\Disk Writes/sec'

icm { Get-Counter -Counter $using:counters -MaxSamples 10 -SampleInterval 1 } -ComputerName sql2012x

$counters = '\Processor(*)\% Processor Time'

 Get-Counter -Counter $counters -MaxSamples 4 -SampleInterval 1  -ComputerName sql2012x  `
| Export-Counter -Path H:\perfmon\capture1.blg -FileFormat blg -Force


#  將blg 放在remote machine 之上, 
Get-Counter -Counter $using:counters -MaxSamples 120 -SampleInterval 1 | Export-Counter -Path C:\PerfLogs\capture1.blg -FileFormat blg } `
-AsJob -ComputerName sql2012x, ws2012us-1

#--------------------------------------------
# 18  878  relog  blg + blg
#-------------------------------------------- 
{
$Data= Import-Counter  H:\perfmon\diskIO_0850.blg , H:\perfmon\diskIO_1706.blg
$Data | Export-Counter H:\perfmon\merge.blg -FileFormat blg -Force

$Data.count  
$Data[244].Timestamp
$Data[0].CounterSamples | Format-Table -Property Path

$Data1=Import-Counter  H:\perfmon\diskIO_0850.blg
$Data2=Import-Counter  H:\perfmon\diskIO_1706.blg
$Data1.Count; $Data2.Count

$Data1[117].Timestamp
$Data2[117].Timestamp


Import-Counter -Path H:\perfmon\merge.blg -Summary
Import-Counter -Path H:\perfmon\diskIO_1706.blg -Listset *

Import-Counter  H:\perfmon\diskIO_0850.blg -Summary
Import-Counter  H:\perfmon\diskIO_1706.blg -Summary
$Data |gm
}
#--------------------------------------------
# 19  800 Data Collector Sets 
#-------------------------------------------- 
{
$datacollectorset = New-Object -COM Pla.DataCollectorSet
$xml = Get-Content C:\temp\PerfmonTemplate.xml
$datacollectorset.SetXml($xml)
$datacollectorset.Commit("$DataCollectorName" , $null , 0x0003) | Out-Null
$datacollectorset.start($false)
}



<#

.SYNOPSIS
 Create a New Perfmon Data Collector Set from an XML input
.DESCRIPTION
 Create a New Perfmon Data Collector Set from an XML input
 Use PowerShell remoting to create these on a remote server.
 Remoting must be enabled on target servers

.NOTES

 Authors:  Jonathan Medd

.PARAMETER CSVFilePath
 Path of CSV file to import
.PARAMETER XMLFilePath
 Path of XML file to import
.PARAMETER DataCollectorName
 Name of new Data Collector. This should match the name in the XML file
.EXAMPLE
 New-DataCollectorSet
 -CSVFilePath C:\Scripts\Servers.csv 
 -XMLFilePath C:\Scripts\PerfmonTemplate.xml 
 -DataCollectorName CPUIssue
#>

param (

 [parameter(Mandatory=$True,HelpMessage='Path of CSV file to import')] $CSVFilePath
 ,[parameter(Mandatory=$True,HelpMessage='Path of XML file to import')] $XMLFilePath
 ,[parameter(Mandatory=$True,HelpMessage='Name of new Data Collector')] $DataCollectorName

 )

# Test for existence of supplied CSV and XML files
if (Test-Path $CSVFilePath){
 }
else{

 Write-Host "Path to CSV file is invalid, exiting script"

 Exit

 }


if (Test-Path $XMLFilePath){

 }
else{

 Write-Host "Path to XML file is invalid, exiting script"

 Exit
 }
 

# Generate list of servers to create Perfmon Data Collector Sets on

$servers = Get-Content $CSVFilePath

 

foreach ($server in $servers){

 
Write-Host "Creating Data Collector Set on $Server"

# Test if the folder C:\temp exists on the target server

if (Test-Path "\\$server\c$\Temp"){
 # Copy the XML file to the target server
 Copy-Item $XMLFilePath "\\$server\c$\Temp"
 # Use PowerShell Remoting to execute script block on target server
 Invoke-Command -ComputerName $server -ArgumentList $DataCollectorName -ScriptBlock {param($DataCollectorName)
 # Create a new DataCollectorSet COM object, read in the XML file,
 # use that to set the XML setting, create the DataCollectorSet,
 # start it.
 $datacollectorset = New-Object -COM Pla.DataCollectorSet
 $xml = Get-Content C:\temp\PerfmonTemplate.xml
 $datacollectorset.SetXml($xml)
 $datacollectorset.Commit("$DataCollectorName" , $null , 0x0003) | Out-Null
 $datacollectorset.start($false)
 }
 
 # Remove the XML file from the target server
 Remove-Item "\\$server\c$\Temp\PerfmonTemplate.xml"
 }
else{
 Write-Host "Target Server does not contain the folder C:\Temp"
 }
}




#--------------------------------------------
#  20 Using Format Commands to Change Output View
#--------------------------------------------

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous   |fl -Property *Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  |ft -Property   Timestamp,Reading  -AutoSize  -HideTableHeadersGet-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  |ft   -HideTableHeadersGet-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  |ft   -HideTableHeaders -GroupBy Reading

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous   | Format-Wide  -Property Timestamp


Get-Command Format-Wide -Property Name -Column 1

$X |ft -HideTableHeaders
$x |gm |select Definition,name



#--------------------------------------------
#  21 1045  Import-Counter
#--------------------------------------------
Get-AvgCPULoad.ps1

#requires -version 3.0
Param (
[parameter(Mandatory=$true)][string]$File,
[parameter(Mandatory=$false)][int]$interval = 5 # default value
)

$counter = '\\*\Processor(_Total)\% Processor Time'
$data    = Import-Counter -path $file -Counter $counter
$d = $data | Select -Expand countersamples | Where status -eq 0

For ($i=1; $i -lt $d.count ; $i+=$interval) {

New-Object -TypeName PSObject -Property @{
Timestamp = $d[$i].Timestamp;
CPUAvg = $d[$i..($i+($interval - 1))] | Measure -Prop cookedvalue -Average | Select -ExpandProperty Average
}

}

#./Get-AvgCPULoad.ps1 -File C:\temp\DataCollector01.blg –interval 10

#--------------------------------------------
# 1072  Missing SQL Server Performance Counters
#-------------------------------------------- 
remember  in msdos (cmd)
http://blog.sqlauthority.com/2014/11/07/sql-server-performance-counter-missing-how-to-get-them-back/

cd 'c:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Binn'
cd 'C:\Program Files\Microsoft SQL Server\MSSQL12.SSDE\MSSQL\Binn'
cd 'C:\Program Files\Microsoft SQL Server\MSSQL12.SSDW\MSSQL\Binn'

To unload counter
    (1) unlodctr MSSQLSERVER
    (2) unlodctr MSSQL$SSDE

To load counter
    (1)lodctr “E:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Binn\perf-MSSQLSERVERsqlctr.ini”
    (2)c:\Program Files\Microsoft SQL Server\MSSQL12.SSDE\MSSQL\Binn>   lodctr perf-SQLAgent$SSDEsqlagtctr.ini
    (2)c:\Program Files\Microsoft SQL Server\MSSQL12.SSDE\MSSQL\Binn>   lodctr perf-MSSQL$SSDEsqlctr.ini

   lodctr  c:\Program Files\Microsoft SQL Server\MSSQL12.SSDE\MSSQL\Binn\perf-MSSQL$SSDEsqlctr.ini
restart Powershell_ise & perfmon 




SSIS  #SQL2014
     unlodctr DTSPipeline120
     unlodctr MsDtsServer120

    lodctr  C:\Program Files\Microsoft SQL Server\120\DTS\Binn\perf-DTSPipeline120DTSPERF.INI  

    cd C:\Program Files\Microsoft SQL Server\120\DTS\Binn   
lodctr    perf-DTSPipeline120DTSPERF.INI
lodctr    perf-MsDtsServer120DTSSVCPERF.INI


#--------------------------------------------
# 99 Task Manager 
#-------------------------------------------- 
##Get
gps -Name sqlservr |select id,name,path  |ft -AutoSize
gps | ?{$_.name -eq 'sqlservr'} |select id,name,path  |ft -AutoSize
<#Id Name     Path                                                                             
  -- ----     ----                                                                             
 776 sqlservr C:\Program Files\Microsoft SQL Server\MSSQL11.SQLS2\MSSQL\Binn\sqlservr.exe      
6688 sqlservr C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Binn\sqlservr.exe
#>



Get-Process | sort  Handles  -Descending%
gps -id 776  | select  ProcessName,Handles , FileVersion,ProductVersion , StartTime ,PM ,CPU,WorkingSet
gps -id 6688 | select  ProcessName,Handles , FileVersion,ProductVersion , StartTime ,PM ,CPU,WorkingSet

gps -id 776 | select pm ,{expression={PM/1024}

@{ Name="Size";Expression={ ($_ | Get-ChildItem -Recurse |
Measure-Object -Sum Length).Sum + 0 } }

10.18mb / 215kb

[math] |get-member  -MemberType method
[math]::pi 
[math]::pow(2,10) 
 28 % 5

Get-Process | ?{$_.id -eq '3856'} |select * 

Get-Process -id 3856  |select path
Get-Process -id 776  |select *

Get-Process -id 776  |select cpu
sleep 2
Get-Process -id 776  |select cpu
sleep 2
Get-Process -id 776  |select cpu

gps -ComputerName sql2012x

get-help gps -full

gps 

##create



 

##setup

##delete
Stop-Process -id xxx -Confirm

#--------------------------------------------
# xxxxxxxxxxxxxxxx
#--------------------------------------------




#--------------------------------------------
# xxxxxxxxxxxxxxxx
#--------------------------------------------




