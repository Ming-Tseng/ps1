
<#-----------------------------------
#  performance  OS02_04_Alwayson.ps1
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS02_04_Alwayson.ps1


CreateDate:  Dec.04.2013
LastDate :  

#author: a0921887912@gmail.com
$subject  : hostname/node1  ,

OS02_01_diskIO.ps1
OS02_02_diskMulti.ps1
OS02_03_Sharepoint_SQL.ps1
OS02_04_Alwaysone.ps1   : ps1\0S02_sets  ( Baseline001.ps1 , makeAction001.ps1  , scenario001.ps1 , tsql001.ps1 )

#>


#  0 120  test data
#  1 150  SQLServer:Availability Replica  PCR
#  2 200  SQLServer:Database Replica   PCR
#  3 200  SQLServer:Database  PCR
#  function GetOneNodePCR 
#  function GetTwoNodePCR 























'
1
Log Generation
Log data is flushed to disk. This log must be replicated to the secondary replicas. 
The log records enter the send queue.
SQL Server:Database > Log bytes flushed\sec
'
Get-Counter -ListSet  "SQLServer:Database*"  |Select-Object -ExpandProperty Paths
Get-Counter -counter '\SQLServer:Databases(*)\Log Bytes Flushed/sec'

\SQLServer:Databases(_total)\Log Bytes Flushed/sec

'
2
Capture
Logs for each database is captured and sent to the corresponding partner queue (one per database-replica pair). 
This capture process runs continuously as long as the availability replica is connected and data movement is not suspended 
for any reason, and the database-replica pair is shown to be either Synchronizing or Synchronized. 

If the capture process is not able to scan and enqueue the messages fast enough, the log send queue builds up.

2.1 SQL Server:Availability Replica > Bytes Sent to Replica\sec
2.2 log_send_queue_size (KB)      
2.3 log_bytes_send_rate (KB/sec) 

on the primary replica.
'
Get-Counter -ListSet  "SQLServer:Availability *"  |Select-Object -ExpandProperty Paths
Get-Counter -counter '\SQLServer:Availability Replica(*)\Bytes Sent to Replica/sec'

\\sp2013\sqlserver:availability replica(spmag:sql2012x)\bytes sent to replica/sec
\\sp2013\sqlserver:availability replica(_total)\bytes sent to replica/sec

Get-Counter -ListSet  "SQLServer:Database*"  |Select-Object -ExpandProperty Paths


Get-Counter -ListSet  "SQLServer:Databases*"  |Select-Object -ExpandProperty Paths



3
Send
The messages in each database-replica queue is dequeued and sent across the wire to the respective secondary replica.
SQL Server:Availability Replica > Bytes sent to transport\secand SQL Server:Availability Replica > Message Acknowledgement Time (ms)
4
Receive and Cache
Each secondary replica receives and caches the message.
Performance counter SQL Server:Availabiltiy Replica > Log Bytes Received/sec
5
Log Harden
Log is flushed on the secondary replica for hardening. 
After the log flush, an acknowledgement is sent back to the primary replica.
Once the log is hardened, data loss is avoided.
Performance counter SQL Server:Database > Log Bytes Flushed/sec
Wait typeHADR_LOGCAPTURE_SYNC
6
Redo

Redo the flushed pages on the secondary replica. Pages are kept in the redo queue as 

SQL Server:Database > Log bytes flushed\sec
'
example

'

#---------------------------------------------------------------
#  0  120   test data
#--------------------------------------------------------------- 
truncate table  [dbo].[T6]
DROP TABLE [dbo].[T6]
GO
CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [PRIMARY]
GO



Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=10
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  WAITFOR DELAY '00:00:02'  
end
select * from dbo.t6 


{
<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\tsql001.ps1
C:\PerfLogs\\tsql001.ps1

taskschd.msc 
#>

$t1=get-date

if ((Get-Module -Name sqlps) -eq $null) {  Import-Module “sqlps” -DisableNameChecking}

$insertcount="1000000"

$sql_insert="Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <="+$insertcount+"
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:02'  
end

use SQL_Inventory
select * from dbo.t6
"
Invoke-Sqlcmd -ServerInstance spm -Database SQL_Inventory -Query $sql_insert -QueryTimeout  1800 |out-null
$t2=get-date

($t2-$t1).TotalMinutes
($t2-$t1).TotalSeconds
##truncate  table  dbo.t6 
<#{
timeout 1800 sec = 30 min

$insertcount="100000"  spend 


}
#>}

{<#
$sql_select="SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select count(*) from dbo.t7"

$arr=@();
$i=0
do
{
    $arr += ""
    $arr[$i]=Invoke-Sqlcmd -ServerInstance spm -Database SQL_Inventory -Query $sql_select -QueryTimeout  60 
    $arr[$i]
    [int]$arr[$i].Column1-[int]$arr[$i-1].Column1

    #$a = [math]::$arr[1]  -  [math]::$arr[$i-1]  
    sleep 10
    $i += 1
}
until ($x -gt 0)
#>}

#---------------------------------------------------------------
#  1 150  SQLServer:Availability Replica
#---------------------------------------------------------------
Get-Counter -ListSet  "SQLServer:Availability Replica*"  |Select-Object -ExpandProperty Paths 

{
PS C:\Users\administrator.CSD> Get-Counter -ListSet  "SQLServer:Availability Replica*"  |Select-Object -ExpandProperty Paths 

Get-Counter -counter '\SQLServer:Availability Replica(*)\Bytes Sent to Replica/sec'
\SQLServer:Availability Replica(*)\Sends to Replica/sec
\SQLServer:Availability Replica(*)\Bytes Sent to Transport/sec
\SQLServer:Availability Replica(*)\Sends to Transport/sec
Get-Counter -counter '\SQLServer:Availability Replica(*)\Bytes Received from Replica/sec'
\SQLServer:Availability Replica(*)\Receives from Replica/sec
\SQLServer:Availability Replica(*)\Flow Control Time (ms/sec)
\SQLServer:Availability Replica(*)\Flow Control/sec
\SQLServer:Availability Replica(*)\Resent Messages/sec
}

#---------------------------------------------------------------
#  2 200  SQLServer:Database Replica   PCR
#---------------------------------------------------------------
Get-Counter -ListSet  "SQLServer:Database Replica*"  |Select-Object -ExpandProperty Paths 
{PS C:\Users\administrator.CSD> Get-Counter -ListSet  "SQLServer:Database Replica*"  |Select-Object -ExpandProperty Paths 
\SQLServer:Database Replica(*)\Recovery Queue
Get-Counter -counter  '\SQLServer:Database Replica(*)\Redone Bytes/sec'
Get-Counter -counter '\SQLServer:Database Replica(*)\Log Send Queue'
Get-Counter -counter '\SQLServer:Database Replica(*)\Log Bytes Received/sec'
\SQLServer:Database Replica(*)\File Bytes Received/sec
Get-Counter -counter '\SQLServer:Database Replica(*)\Mirrored Write Transactions/sec'
Get-Counter -counter  '\SQLServer:Database Replica(*)\Transaction Delay'
\SQLServer:Database Replica(*)\Total Log requiring undo
\SQLServer:Database Replica(*)\Log remaining for undo
\SQLServer:Database Replica(*)\Redo Bytes Remaining
\SQLServer:Database Replica(*)\Redo blocked/sec
}

#---------------------------------------------------------------
#  3  200  SQLServer:Database  PCR
#---------------------------------------------------------------
Get-Counter -ListSet  "SQLServer:Database*"  |Select-Object -ExpandProperty Paths


{PS C:\Users\administrator.CSD> Get-Counter -ListSet  'SQLServer:Databases*'  |Select-Object -ExpandProperty Paths
\SQLServer:Databases(*)\Data File(s) Size (KB)
\SQLServer:Databases(*)\Log File(s) Size (KB)
\SQLServer:Databases(*)\Log File(s) Used Size (KB)
\SQLServer:Databases(*)\Percent Log Used
Get-Counter -counter '\SQLServer:Databases(*)\Active Transactions'
\SQLServer:Databases(*)\Transactions/sec
\SQLServer:Databases(*)\Repl. Pending Xacts
\SQLServer:Databases(*)\Repl. Trans. Rate
\SQLServer:Databases(*)\Log Cache Reads/sec
\SQLServer:Databases(*)\Log Cache Hit Ratio
\SQLServer:Databases(*)\Log Pool Requests/sec
\SQLServer:Databases(*)\Log Pool Cache Misses/sec
\SQLServer:Databases(*)\Log Pool Disk Reads/sec
\SQLServer:Databases(*)\Bulk Copy Rows/sec
Get-Counter -counter  '\SQLServer:Databases(*)\Bulk Copy Throughput/sec'
Get-Counter -counter  '\SQLServer:Databases(*)\Backup/Restore Throughput/sec'
\SQLServer:Databases(*)\DBCC Logical Scan Bytes/sec
\SQLServer:Databases(*)\Shrink Data Movement Bytes/sec
Get-Counter -counter '\SQLServer:Databases(*)\Log Flushes/sec'
Get-Counter -counter '\SQLServer:Databases(*)\Log Bytes Flushed/sec'
\SQLServer:Databases(*)\Log Flush Waits/sec
\SQLServer:Databases(*)\Log Flush Wait Time
\SQLServer:Databases(*)\Log Flush Write Time (ms)
\SQLServer:Databases(*)\Log Truncations
\SQLServer:Databases(*)\Log Growths
\SQLServer:Databases(*)\Log Shrinks
\SQLServer:Databases(*)\Tracked transactions/sec
\SQLServer:Databases(*)\Write Transactions/sec
\SQLServer:Databases(*)\Commit table entries


}

$x='\\sp2013\sqlserver:databases(_total)\log bytes flushed/sec','\\sql2012x\sqlserver:databases(_total)\log bytes flushed/sec'
Get-Counter -counter $x  -SampleInterval 2 -MaxSamples 5

{
PS C:\Users\administrator.CSD> Get-Counter -counter '\SQLServer:Databases(*)\Log Flushes/sec'

Timestamp                 CounterSamples                                       
---------                 --------------                                       
6/27/2014 9:32:08 AM      \\sp2013\sqlserver:databases(194_sp_centraladmincontent)\log flushes/sec :                                                                                      
                          \\sp2013\sqlserver:databases(194_sp_configdb)\log flushes/sec :                                        
                          \\sp2013\sqlserver:databases(sql_inventory)\log flushes/sec :                                                                                             
                          \\sp2013\sqlserver:databases(iamsp2013)\log flushes/sec :                                        
                          0                                                       
                          \\sp2013\sqlserver:databases(wss_content_spload)\log flushes/sec :                                        
                          0                                                     
                          \\sp2013\sqlserver:databases(mingdb)\log flushes/sec :                                                    
                          0                                                    
                          \\sp2013\sqlserver:databases(m220131226)\log flushes/sec :                                        
                          0                                                                                                         
                          \\sp2013\sqlserver:databases(tempdb)\log flushes/sec :                                                    
                          0                                                                                                          
                          \\sp2013\sqlserver:databases(s4)\log flushes/sec :   
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(model)\log flushes/sec :
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(repldesc2)\log flushes/sec :                                        
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(m1)\log flushes/sec :   
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(wss_content_pmd)\log flushes/sec :                                        
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(adventureworks2008)\log flushes/sec :                                        
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(msdb)\log flushes/sec : 
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(webhr_standard)\log flushes/sec :                                        
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(adventureworks2008r2)\log flushes/sec :                                      
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(agdb_sql2012)\log flushes/sec :                                        
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(adventureworks2012)\log flushes/sec :                                        
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(mssqlsystemresource)\log flushes/sec :                                       
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(_total)\log flushes/sec :                                                    
                          0                                                    
                                                                               
                          \\sp2013\sqlserver:databases(master)\log flushes/sec :                                                    
                          0                                                    
                                    }



#---------------------------------------------------------------
#  Get activeNode1
#---------------------------------------------------------------
########
Get-counter -list '*SQL*' | select CounterSetName
Get  all  instance of SQL 



######
Get-counter -listset  '*:General  Statistics*' | select -expandproerty Paths

$collectionMainName='Useconnections'
$BLGFile="C:\syscom\Perfmon\"+$collectionMainName+(get-date -format  yyyy_MM_dd_HHmm)+".blg"


$I1_UserConnectionS=activeNode1   




$activeNode1="\\"+(Get-clustergroup SPMAG).OwnerNode;$activeNode1


$activeNode="\\"+( Get-clustergroup 'SQL Server(MSSQLSERVER)).OwnerNode' 
#---------------------------------------------------------------
#  function GetOneNodePCR  
#---------------------------------------------------------------

function GetOneNodePCR ($AGGName, $counterSets, $BLGPath, $BLGName)
{
    $PrimaryNode="\\"+(Get-clustergroup $AGGName).OwnerNode;$PrimaryNode
    $SecondaryNode=$env:COMPUTERNAME
    
    $PrimaryPCR
    $SecondaryPCR
    $BLGFile=$BLGPath+$BLGName+(get-date -format  yyyy_MM_dd_HHmm)+".blg";$BLGFile


}

$PrimaryPCR="sqlserver:databases(_total)\log flushes/sec"

\\sp2013\sqlserver:database replica(sql_inventory)\log send queue
\\sp2013\sqlserver:databases(_total)\log bytes flushed/sec


$BLGPath="C:\Perfmon"
$BLGName="logflushessec"

GetPCSaveToBlg  SPMAG $counterSets $BLGPath $BLGName

#---------------------------------------------------------------
#  function PCRTwoNode_01   
#---------------------------------------------------------------

$Node1='sp2013'
$Node2='sql2012x'
$PCR_Node1= "\SQLServer:Availability Replica(_total)\Bytes Sent to Replica/sec","\SQLServer:Availability Replica(_total)\Bytes Sent to Transport/sec"`
,"\SQLServer:Database Replica(_total)\Mirrored Write Transactions/sec","\SQLServer:Database Replica(_total)\Transaction Delay" 


$PCR_Node2= "\SQLServer:Database Replica(_total)\Log Bytes Received/sec","\SQLServer:Database Replica(_total)\Log Send Queue"`
 ,"\SQLServer:Database Replica(_total)\Redone Bytes/sec" `
 

$BLGPath='C:\Perfmon'
$PCRMainName='testPCR001'
$TestSQL="selecti"
$SampleInterval=5
{<#  backup
function PCRTwoNode_template ($Node1 , $Node2 ,$PCR_Node1 ,$PCR_Node2 ,$BLGPath  ,$PCRMainName ,$TestSQL) {  #p1
   
   $BLGFile=$BLGPath+"\"+$PCRMainName+"_"+(get-date -format  yyyy_MM_dd_HHmm)+".blg";$BLGFile

   $PCR_all =@()
   for ($i = 0; $i -lt $PCR_Node1.Count ; $i++)
   {  $PCR_all += ""
      $PCR_all[$i]="\\"+$Node1+$PCR_Node1[$i]   } 
    $k=0
    for ($j = $i; $j -lt ($PCR_Node1.Count+$PCR_Node2.Count); $j++)
   {  $PCR_all += ""
      $PCR_all[$j]="\\"+$Node2+$PCR_Node2[$k] 
      $k += 1} 


   $ts=get-date  # start
   $t1 = $ts.addMinutes(1);
   $te = $ts.addMinutes(3);

   while ($te -ge $ts ) { #p.37
    if(($ts.Minute -ge $t1.Minute )  -and ($ts.Second -eq 0 )){   #p.65
    Sleep 10;$t2= (get-date).ToString() ; 'p2 blg begin   '+$t2
   
    Start-Job { Get-Counter $using:PCR_all   –Continuous  | Export-Counter -Path $using:blgFile -FileFormat blg -Force }   
   
    Sleep 10;$t3= (get-date) ; 'p3 tsql begin  '+$t3.ToString()
   ##
   # Invoke-Sqlcmd -ServerInstance $AGListen -Database $AGDB -Query $TestSQL001 -QueryTimeout 600
   #
     sleep 60
     
     Sleep 10;$t4= (get-date) ; 'p4 tsql end    '+$t4.ToString()
     ($t4-$t3).TotalMilliseconds

stop-job *
remove-job * #; Get-Job  #-id 8
#sleep 10
Break
    } #p.65
    $ts =get-date
}#p.37

 }  #p1
 #>}

 PCRTwoNode_template $Node1  $Node2 $PCR_Node1 $PCR_Node2 $BLGPath  $PCRMainName $TestSQL
##

 function PCRTwoNode_01 ($Node1 , $Node2 ,$PCR_Node1 ,$PCR_Node2 ,$BLGPath  ,$PCRMainName ,$TestSQL , ) {  #p1
   
   $BLGFile=$BLGPath+"\"+$PCRMainName+"_"+(get-date -format  yyyy_MM_dd_HHmm)+".blg";#$BLGFile

   $PCR_all =@()
   for ($i = 0; $i -lt $PCR_Node1.Count ; $i++)
   {  $PCR_all += ""
      $PCR_all[$i]="\\"+$Node1+$PCR_Node1[$i]   } 
    $k=0
    for ($j = $i; $j -lt ($PCR_Node1.Count+$PCR_Node2.Count); $j++)
   {  $PCR_all += ""
      $PCR_all[$j]="\\"+$Node2+$PCR_Node2[$k] 
      $k += 1} 


   $ts=get-date  # start
   $t1 = $ts.addMinutes(1);
   $te = $ts.addMinutes(3);

   while ($te -ge $ts ) { #p.37
    if(($ts.Minute -ge $t1.Minute )  -and ($ts.Second -eq 0 )){   #p.65
    Sleep 10;$t2= (get-date).ToString() ; #'p2 blg begin   '+$t2
   
    Get-Counter $PCR_all   –Continuous  | Export-Counter -Path $blgFile -FileFormat blg -Force 
   
    Sleep 10;$t3= (get-date) ;# 'p3 tsql begin  '+$t3.ToString()
   ##
   # Invoke-Sqlcmd -ServerInstance $AGListen -Database $AGDB -Query $TestSQL001 -QueryTimeout 600
   #
     sleep 60
     
     Sleep 10;$t4= (get-date) ;# 'p4 tsql end    '+$t4.ToString()
     ($t4-$t3).TotalMilliseconds

#stop-job *
#remove-job * #; Get-Job  #-id 8
#sleep 10
#Break
    } #p.65
    $ts =get-date
}#p.37

 }  #p1

  Start-Job { PCRTwoNode_01 $using:Node1 $using:Node2 $using:PCR_Node1 $using:PCR_Node2 $using:BLGPath  $using:PCRMainName $using:TestSQL }

  Get-Job

#---------------------------------------------------------------
#    \Baseline.ps1
#---------------------------------------------------------------
<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\Baseline.ps1
C:\PerfLogs\scheTest.ps1
UI taskschd.msc設定定時    執行 5 Sec 停止, 將記錄寫入 File
UI 內容 > 動作 > 編輯動作 > 設定 > 程式或指令碼 : powershell , 新增引數: C:\PerfLogs\scheTest.ps1
taskschd.msc 
#>
Param(
  [string]$timespanlen
)

$timespanlen=5
$SampleInterval=5
$Node1='sp2013'
$Node2='sql2012x'
$PCRMainName='Baseline_'+$Node1+'_'+$Node2+'='+$timespanlen+'_Minutes'
$BLGPath='C:\perflogs'
$TestSQL="selecti"
$x=0

$PCR_Node1= "\SQLServer:Availability Replica(_total)\Bytes Sent to Replica/sec","\SQLServer:Availability Replica(_total)\Bytes Sent to Transport/sec"`
,"\SQLServer:Database Replica(_total)\Mirrored Write Transactions/sec","\SQLServer:Database Replica(_total)\Transaction Delay" 


$PCR_Node2= "\SQLServer:Database Replica(_total)\Log Bytes Received/sec","\SQLServer:Database Replica(_total)\Log Send Queue"`
 ,"\SQLServer:Database Replica(_total)\Redone Bytes/sec" `
 

$t1 =Get-date;#$t1
$t1f=(Get-date -format  yyyy_MM_dd_HHmm)
$timespan = new-timespan -Minutes $timespanlen
#$timespan = new-timespan -Seconds  $timespan
$t2= $t1+ $timespan

$BLGFile=$BLGPath+"\"+$PCRMainName+"-"+$t1f+".blg";#$BLGFile

   $PCR_all =@()
   for ($i = 0; $i -lt $PCR_Node1.Count ; $i++)
   {  $PCR_all += ""
      $PCR_all[$i]="\\"+$Node1+$PCR_Node1[$i]   } 
    $k=0
    for ($j = $i; $j -lt ($PCR_Node1.Count+$PCR_Node2.Count); $j++)
   {  $PCR_all += ""
      $PCR_all[$j]="\\"+$Node2+$PCR_Node2[$k] 
      $k += 1} 
  
   $job100 =Start-Job { Get-Counter $using:PCR_all –Continuous -SampleInterval $using:SampleInterval | Export-Counter -Path $using:blgFile -FileFormat blg -Force }   
  #  Get-Counter $PCR_all –Continuous -SampleInterval $SampleInterval | Export-Counter -Path $blgFile -FileFormat blg -Force 

do
{
   if ($t1 -gt $t2)
    {
        sleep -Seconds 6
        stop-job $job100
        remove-job $job100 #; Get-Job  #-id 8
        #"Removejob ="+ (Get-date).tostring()
        break
        #exit
    }
     #sleep -Seconds 10
    $t1=(get-date); 
    
}
until ($x -gt 0)

# stop-job * remove-job *  get-job


#---------------------------------------------------------------
#    temp 
#---------------------------------------------------------------

SET STATISTICS TIME ON
select * from dbo.t6 where val= 948
SET STATISTICS TIME OFF

SET STATISTICS TIME ON
select * from dbo.t6 where rstring like  'DB7B8211-BE37-%' 
SET STATISTICS TIME OFF


#---------------------------------------------------------------
#---------------------------------------------------------------
#     scenario001
#---------------------------------------------------------------
#---------------------------------------------------------------
<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\scenario001.ps1

C:\PerfLogs\scenario001.ps1

 createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com


copy 0S02_sets\*.*  to C:\PerfLogs\

baselineXXX.ps1
tsqlXXX.ps1
makeActionXXX.ps1

case         ,    subPs1      ,    trigger at ,  Timelength  , remark
scenario001      baseLineXXX       11:00         4h            PCR list 
                 tsqlXXX           11:20         10m           insert 1M to t6
                 makeActionXXX     11:25                       sql2012x off
                 makeActionXXX     11:30                       sql2012x on


#>


#--------------------------------------------
#    baseLine001
#--------------------------------------------
$TaskStartTime    = "14:30:00" 
$TaskName         = "baseLine001"

$para_timespanlen='10'
$para_SampleInterval=5

$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +"   ,SampleInterval:" + $para_SampleInterval+"sec"
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_timespanlen +" "+ $para_SampleInterval
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once#Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 


#--------------------------------------------
#    tsql001
#--------------------------------------------
$TaskStartTime    = "14:32:00" 
$TaskName         = "tsql001"

$para_insertcount = "100000"
$para_svrinstance = "spm"
$para_pdatabase   = "SQL_Inventory"
$para_ptable      = "t7"


#$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +" Min "
$TaskDescr =  $TaskName +"  ServerInstance:"+ $para_svrinstance + " ,database: "+$para_pdatabase +", table :"+$para_ptable +" ,Count: "+$para_insertcount

$TaskCommand = "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_insertcount +" "+ $para_svrinstance+" "+ $para_pdatabase +" "+ $para_ptable$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once#Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false 
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 

#Get-ScheduledTask -taskname $TaskName | Get-ScheduledTaskInfo

#--------------------------------------------
#    makeAction001
#--------------------------------------------

$TaskStartTime    = "14:34:00" 
$TaskName         = "makeAction001"

$para_gsvNode="Sql2012x"
$para_gsvname="MSSQLSERVER"
$para_waitSec= 60

#$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +" Min "
$TaskDescr =  $TaskName +"  computerNode:"+ $para_gsvNode + " ,InstanceName: "+$para_gsvname +", Stop "+$para_waitSec +"  Seconds then reboot "

$TaskCommand = "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_gsvNode +" "+ $para_gsvname+" "+ $para_waitSec 
$TaskAction  = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once#Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false 
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 

#--------------------------------------------
#    save to SQL_inventory 
#--------------------------------------------







#---------------------------------------------------------------#
#---------------------------------------------------------------#
#                       Baseline001                             #
#---------------------------------------------------------------#
#---------------------------------------------------------------#
<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\Baseline001.ps1

C:\PerfLogs\Baseline001.ps1

createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com


taskschd.msc 
#>

Param(
  [string] $timespanlen,
  [int] $SampleInterval
)

#$timespanlen=5
#$SampleInterval=5
$Node1='sp2013'
$Node2='sql2012x'
#$PCRMainName=$Node1+'_'+$Node2+'_baseline_'+$timespan+' Minutes'
$PCRMainName='Baseline_'+$Node1+'_'+$Node2+'='+$timespanlen+'_Minutes'
$BLGPath='C:\perflogs'
$TestSQL="selecti"
$x=0

$PCR_Node1= "\SQLServer:Availability Replica(_total)\Bytes Sent to Replica/sec","\SQLServer:Availability Replica(_total)\Bytes Sent to Transport/sec"`
,"\SQLServer:Database Replica(_total)\Mirrored Write Transactions/sec","\SQLServer:Database Replica(_total)\Transaction Delay" 


$PCR_Node2= "\SQLServer:Database Replica(_total)\Log Bytes Received/sec","\SQLServer:Database Replica(_total)\Log Send Queue"`
 ,"\SQLServer:Database Replica(_total)\Redone Bytes/sec" `
 

$t1 =Get-date;#$t1
$t1f=(Get-date -format  yyyy_MM_dd_HHmm)
$timespan = new-timespan -Minutes $timespanlen
#$timespan = new-timespan -Seconds  $timespan
$t2= $t1+ $timespan

$BLGFile=$BLGPath+"\"+$PCRMainName+"-"+$t1f+".blg";#$BLGFile

   $PCR_all =@()
   for ($i = 0; $i -lt $PCR_Node1.Count ; $i++)
   {  $PCR_all += ""
      $PCR_all[$i]="\\"+$Node1+$PCR_Node1[$i]   } 
    $k=0
    for ($j = $i; $j -lt ($PCR_Node1.Count+$PCR_Node2.Count); $j++)
   {  $PCR_all += ""
      $PCR_all[$j]="\\"+$Node2+$PCR_Node2[$k] 
      $k += 1} 
  
   $job100 =Start-Job { Get-Counter $using:PCR_all –Continuous -SampleInterval $using:SampleInterval | Export-Counter -Path $using:blgFile -FileFormat blg -Force }   
  #  Get-Counter $PCR_all –Continuous -SampleInterval $SampleInterval | Export-Counter -Path $blgFile -FileFormat blg -Force 

do
{
   if ($t1 -gt $t2)
    {
        sleep -Seconds 6
        stop-job $job100
        remove-job $job100 #; Get-Job  #-id 8
        #"Removejob ="+ (Get-date).tostring()
        break
        #exit
    }
     #sleep -Seconds 10
    $t1=(get-date); 
    
}
until ($x -gt 0)

# stop-job * remove-job *  get-job

-
#---------------------------------------------------------------#
#---------------------------------------------------------------#
#    tsql001                                                    #
#---------------------------------------------------------------#
#---------------------------------------------------------------#
<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql001.ps1

C:\PerfLogs\tsql001.ps1


createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com
taskschd.msc 

insert 

tsql001.ps1 Count  ServerInstance database table 

tsql001.ps1 100  spm  SQL_Inventory t7 
#>


Param(
  [string] $insertcount,
  [string] $svrinstance,
  [string] $pdatabase,
  [string] $ptable
)
if ((Get-Module -Name sqlps) -eq $null) {  Import-Module “sqlps” -DisableNameChecking}

#$t1=get-date;$t1
#$insertcount="60"
#$svrinstance="spm"
#$pdatabase="SQL_Inventory"
#$ptable="t6"



$sql_insert="Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <="+$insertcount+"
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo."+$ptable+" values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:02'  
end
"
Invoke-Sqlcmd -ServerInstance spm -Database SQL_Inventory -Query $sql_insert -QueryTimeout  7200 |out-null
#Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_insert  |out-null

#$t2=get-date;$t2


#($t2-$t1).TotalMinutes
#($t2-$t1).TotalSeconds

##truncate  table  dbo.t6 
<#{
timeout 1800 sec = 30 min

$insertcount="100000"  0.1M spend  7.68min =461sec
$insertcount="1000000" 1M   spend  61min  about 300 c/sec



}
#>
#---------------------------------------------------------------#
#---------------------------------------------------------------#
#                     makeAction001                             #
#---------------------------------------------------------------#
#---------------------------------------------------------------#
<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\makeAction001.ps1

C:\PerfLogs\makeAction001.ps1

createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com

taskschd.msc 

make SQL off x , 

#>
Param(
  [string] $gsvNode,
  [string] $gsvname,
  [int] $waitSec
)

#$gsvNode="Sql2012x"
#$gsvname="MSSQLSERVER"
#$waitSec= 60


$sqlservice =gsv -Name $gsvname -ComputerName $gsvNode

$sqlservice.Stop()

sleep -Seconds  $waitSec

$sqlservice.Start()





#---------------------------------------------------------------#
#---------------------------------------------------------------#
#                     tsql002                                   #
#---------------------------------------------------------------#
#---------------------------------------------------------------#

<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql002.ps1

C:\PerfLogs\tsql002.ps1


createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com
taskschd.msc 

在特定時間(X :Min)內, random(Y:Sec) 隨機 每次新增 Z 筆 

$rnum=Get-Random -Minimum 1 -Maximum 101
$rnum.GetType()

tsql002.ps1 Count  ServerInstance database table 

tsql002.ps1 100  spm  SQL_Inventory t7 
#>


Param(
  [string] $Minutelength,
  [float]    $SecRandom,
  [int]    $Rowinsert,
  [string] $svrinstance,
  [string] $pdatabase,
  [string] $ptable
)
if ((Get-Module -Name sqlps) -eq $null) {  Import-Module “sqlps” -DisableNameChecking}



$Minutelength='2'
$SecRandom   =2.9
$Rowinsert   ="100"
$svrinstance ="spm"
$pdatabase   ="SQL_Inventory"
$ptable      ="t7"
$t1=get-date;#$t1
$timespan = new-timespan -Minutes $Minutelength
$t2= $t1+ $timespan



$sql_insert="Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <="+$Rowinsert+"
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo."+ $ptable +" values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
end
"


do
{

Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_insert -QueryTimeout  7200 |out-null
   if ($t1 -gt $t2)
    {
        break      
    }
    $rnum=Get-Random -Minimum 0.5 -Maximum $SecRandom ;#$rnum
    sleep -Seconds $rnum
    $t1=(get-date); 
    #$t1;$t2
    
}
until ($x -gt 0)


#$t2=get-date;$t2


#($t2-$t1).TotalMinutes
#($t2-$t1).TotalSeconds

##truncate  table  dbo.t6 
<#{
timeout 1800 sec = 30 min

$insertcount="100000"  0.1M spend  7.68min =461sec
$insertcount="1000000" 1M   spend  61min  about 300 c/sec
$insertcount="1000000" 1M   spend 
$insertcount="1000000" 1M   spend  
$insertcount="10000"        spend 
$insertcount="1000"         spend   3.5455648 Second
$insertcount="100"          spend   0.3632593 Second
do
{
     $rnum=Get-Random -Minimum 0.5 -Maximum $SecRandom ;$rnum
     sleep $rnum
}
until ($x -gt 0)

}
#>
$t1=get-date;#$t1
$sql_insert="Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=10000
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo."+ $ptable +" values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
end
"
Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_insert -QueryTimeout  7200 |out-null
$t2=get-date;#$t1
($t2-$t1).TotalMinutes
($t2-$t1).TotalSeconds
