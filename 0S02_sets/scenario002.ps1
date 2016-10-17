<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\scenario002.ps1

C:\PerfLogs\scenario002.ps1

 createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com

控制 N1, N2…. 上的Schedule task 同步進行 Load Test 

copy \\sql2012x\*\0S02_sets\*.*  to \\sql2012x\*.*  C:\PerfLogs\

baselineXXX.ps1
tsqlXXX.ps1
makeActionXXX.ps1

case         ,    subPs1      ,    trigger at ,  Timelength  , remark
scenario001      baseLineXXX       11:00         4h            PCR list 
                 tsqlXXX           11:20         10m           insert 1M to t6
                 makeActionXXX     11:25                       sql2012x off
                 makeActionXXX     11:30                       sql2012x on


#>

#---------------------------------------------------------------
# 
#---------------------------------------------------------------



$rnum=Get-Random -Minimum 1 -Maximum 101
$rnum.GetType()




#---------------------------------------------------------------
# 
#---------------------------------------------------------------

$script={
$TaskStartTime    = "14:30:00" 
$TaskName         = "baseLine001"

$para_timespanlen='10'
$para_SampleInterval=5

$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +"   ,SampleInterval:" + $para_SampleInterval+"sec"
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_timespanlen +" "+ $para_SampleInterval
$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once

Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
}

icm -ComputerName sp2013 -ScriptBlock $script


$TaskName         = "baseLine001"
icm -ComputerName sp2013 -ScriptBlock {Unregister-ScheduledTask –TaskName $using:TaskName  -Confirm:$false}