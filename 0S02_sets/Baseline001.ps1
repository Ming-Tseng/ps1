<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\Baseline001.ps1

C:\PerfLogs\Baseline001.ps1

createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com


taskschd.msc 



#>

get-counter     "*SQLServer:Database*" 


Param(
  [string] $timespanlen,
  [int]    $SampleInterval,
  [string] $Node1,
  [string] $Node2
)

#$timespanlen=5
#$SampleInterval=5
#$Node1='sp2013'
#$Node2='sql2012x'
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