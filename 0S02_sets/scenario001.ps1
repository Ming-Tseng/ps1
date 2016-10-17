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
graphical UI program    (TaskSchd.msc)
command-line equivalent (SchTasks.exe) 

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
#$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_timespanlen +" "+ $para_SampleInterval$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_timespanlen +" "+ $para_SampleInterval`+" "+ $para_Node1 +" "+ $para_node2
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once#Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "$env:USERDNSDOMAIN\$env:USERNAME" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 

"$env:USERDNSDOMAIN\$env:USERNAME"  

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




