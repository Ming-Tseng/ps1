<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\scenario003.ps1

C:\PerfLogs\scenario003.ps1

 createData : Jul.19.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com

 週期排程收集  "DBCC SQLPERF('LOGSPACE')"  to  Sql_inventory
 動態產生  out-file  C:\PerfLogs\Tsql003.ps1
 以及建立在 遠端  schetask

$para_svrinstance="spm"
$para_database   ="SQL_Inventory"
$TaskName         = "Tsql003"
$TaskStartTime    = "14:30:00" 

.\scenario003 sp2013 1 "18:00:11" spm SQL_Inventory

#>



#---------------------------------------------------------------
# 
#---------------------------------------------------------------

Param(
  [string] $destNode,
  [string] $TaskRunTime,
  [string] $DaysInterval,
  [string] $para_svrinstance,
  [string] $para_database 
)

$destNode="sp2013"
$DaysInterval="1"
$TaskRunTime="17:12:00"
$para_svrinstance="spm"
$para_database="SQL_Inventory"

#$filedest='\\sql2012x\C$\PerfLogs\1.ps1'
#---------------------------------------------------------------
#   out-file 
#---------------------------------------------------------------

$filedest ="\\"+$destnode+'\C$\PerfLogs\Tsql003.ps1'
## file column don't over 80 -Width 160
$Filecontent={
Param(
  [string] $para_ins,
  [string] $para_db
)
#$para_ins="spm"
#$para_db   ="SQL_Inventory"

if ((Get-Module -Name sqlps) -eq $null) 
{  Import-Module “sqlps” -DisableNameChecking}
$tquery="DBCC SQLPERF('LOGSPACE')"
$LOGSPACES = Invoke-Sqlcmd  -ServerInstance $para_svrinstance -Query $tquery

foreach ($LOGSPACE in $LOGSPACES)
{ #p90
    #for ($i = 0; $i -lt ($LOGSPACE.ItemArray).Count; $i++)
    #{ #p.1396
       $vDatabaseName=$LOGSPACE[0]
       $vLogSizeMB=$LOGSPACE[1] 
       $vLogSpaceUsed=$LOGSPACE[2] 
       $vStatus=$LOGSPACE[3]  
     #}#p.1396

$sql_insert =@" 
INSERT INTO [dbo].[statusLogSize]
           ([DatabaseName]
           ,[LogSizeMB]
           ,[LogSpaceUsed]
           ,[Status])
     VALUES
           ('$vDatabaseName'
           ,'$vLogSizeMB'  
           ,'$vLogSpaceUsed'
           ,'$vStatus'
           )
"@
       #$sql_insert 
Invoke-Sqlcmd -Query $sql_insert -ServerInstance $para_ins -Database $para_db
}#p90
}
cd c:\
$Filecontent |  Out-File  $filedest -Width 160 -force

#---------------------------------------------------------------
#  schetask.msc
#---------------------------------------------------------------

icm -ComputerName $destNode -ScriptBlock {
#$TaskRunTime    = "14:30:00" 
$TaskName       = "Tsql003"

$TaskDescr =  $TaskName +"  check logSpaceUsed % :  DaysInterval each "+$using:DaysInterval +" Day  ,TaskRunTime:" + $using:TaskRunTime 
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $using:para_svrinstance +" "+ $using:para_database
$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval $using:DaysInterval -At $using:TaskRunTime 
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "$env:USERDOMAIN\$env:USERNAME" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
}
#icm -ComputerName $destNode  -ScriptBlock {Unregister-ScheduledTask –TaskName $using:TaskName  -Confirm:$false}

{<#
#---------------------------------------------------------------
#  schetask.msc
#---------------------------------------------------------------
$script={
#$TaskRunTime    = "14:30:00" 
$TaskName       = "Tsql003"

$para_timespanlen='10'
$para_SampleInterval=5

$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +"   ,SampleInterval:" + $para_SampleInterval+"sec"
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_svrinstance +" "+ $para_database
$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" #$TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once
$TaskTrigger = New-ScheduledTaskTrigger -Daily -DaysInterval 2 -At "01:01:01" 
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "$env:USERDOMAIN\$env:USERNAME" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
##Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false 
}

icm -ComputerName $destNode -ScriptBlock $script
#icm -ComputerName sp2013 -ScriptBlock {Unregister-ScheduledTask –TaskName $using:TaskName  -Confirm:$false}
#>}