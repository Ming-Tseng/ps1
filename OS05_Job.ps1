<#-----------------------------------
#   Jobs OS05_job
#Date:  Dec.04.2013
#last update : 
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS05_Job.ps1
C:\Users\administrator.CSD\SkyDrive\download\PS1\OS05_Job.ps1

#author: a0921887912@gmail.com
$subject  : hostname/node1  ,

(1)JOB CMDLET , 
(2)Scheduled Tasks , 
(3)event
(4)

remark: Powershell 3.0  vs 2.0  Import-Module PSScheduledJob  first view  c00.ps1
#$
Scheduled Tasks
JOB CMDLET
Get-eventlogs
new  & clear & remove  & write-log
Get-WinEvent
Get-task
wevtutil el  #事件檢視器的 UI 操作的動作（查詢、匯出、封存等）都可以用 Wevtutil 來完成


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS05_Job.ps1

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

taskschd.msc 
taskmgr
eventvwr
show-eventlog -computername sql2012x

SCHTASKS

# 01       background
# 02  120  Scheduled Tasks  
# 03  250  New-ScheduledTaskAction
# 04  300  ScheduledTaskTrigger 
# 05  300  Register-ScheduledTask
# 06  400  schtasks.exe create  ScheduledTask 
#    x     time-based trigger vs Event-based triggers
# 07  500  Managing failover clusters with scheduled tasks
# 08  500  example   scheTest.ps1  
# 09  566  JOB CMDLET  
# 10  630  Get-eventlogs
# 11  700  new  & clear & remove  & write-log
# 12  760  Get-WinEvent
# 13  800  wevtutil 











#--------------------------------------------
#  1  background
#--------------------------------------------
graphical UI program    (TaskSchd.msc)
command-line equivalent (SchTasks.exe) 

Get-command -module PSScheduledJob  #"list all"   cmdlet
Get-Command –Module ScheduledTasks   #PowerShell 4.0  function
gcm –m ScheduledTasks.

{<#
http://blogs.technet.com/b/heyscriptingguy/archive/2013/11/23/using-scheduled-tasks-and-scheduled-jobs-in-powershell.aspx
Scheduled tasks are much more general than scheduled jobs.

Scheduled tasks are much more general than scheduled jobs. The Task Scheduler graphical UI program (TaskSchd.msc), and its command-line equivalent (SchTasks.exe) have been part of Windows since some of the earliest days of the operating system. They enable you to schedule the running of almost any program or process, in any security context, triggered by a timer or a wide variety of system events.

Scheduled tasks are a core infrastructure component of Windows and, they are used extensively by many Windows components and other products that run on Windows. Although SchTasks.exe enables you to fully interact with your tasks from a command line, it is not object-oriented, as are the ScheduledTask module’s cmdlets. Each cmdlet consumes, processes, or returns an object, unlike the older command-line tools that generally consume and emit only text strings.

The only thing that is really missing from a scheduled task is the native ability to capture and manipulate the output of the task. Because a scheduled task can run almost anything that is runnable on a Windows computer, it’s not possible to anticipate and capture the output of a scheduled task. According to Windows PowerShell MVP, Karl Prosser, the output of scheduled tasks goes to "the same place where your clothes dryer puts your lost socks."

Because a scheduled job is always Windows PowerShell script, even if that script is used to run a non-Windows PowerShell program, it is possible for the system to capture that predictable output: the Windows PowerShell object that is returned at the end of the script block. However, that’s a relatively minor limitation because there is nothing to prevent your scheduled task from saving its output to disk in some form that you can later retrieve and manipulate.


#>}




## install
Import-Module ScheduledTasks 
Import-Module PSScheduledJob



## Get-command -module PSScheduledJob 
JobTrigger    (Get, Add ,Disable/Enable,New,Remove,Set )
ScheduledJob  (Get ,Disable/Enable,Register/Unregister,Set )
ScheduledJobOption   (Get,New,Set)


## Get-Command –Module ScheduledTasks  
ClusteredScheduledTask   (Get,Register/Unregister,Set) 
ScheduledTask            (Disable,Enable,Export,Get,New,Set,Register/Unregister,Start/Stop )
ScheduledTaskAction      (New)
ScheduledTaskInfo        (Get)
ScheduledTaskPrincipal   (New)
ScheduledTaskSettingsSet (New)
ScheduledTaskTrigger     (New)


##
Get-ScheduledJob







#--------------------------------------------
#   2  120  Scheduled Tasks  
#--------------------------------------------
http://technet.microsoft.com/en-us/library/jj649816.aspx

##Get-ScheduledTask :Gets the task definition object of a scheduled task that is registered on the local computer.
Get-ScheduledTask [[-TaskName] <String[]> ] [[-TaskPath] <String[]> ] [-AsJob] [-CimSession <CimSession[]> ] [-ThrottleLimit <Int32> 
{<# TypeName: Microsoft.Management.Infrastructure.CimInstance#Root/Microsoft/Windows/TaskScheduler/MSFT_ScheduledTask

Name                      MemberType     Definition                                                                                                             
----                      ----------     ----------                                                                                                             
Clone                     Method         System.Object ICloneable.Clone()                                                                                       
Dispose                   Method         void Dispose(), void IDisposable.Dispose()                                                                             
Equals                    Method         bool Equals(System.Object obj)                                                                                         
GetCimSessionComputerName Method         string GetCimSessionComputerName()                                                                                     
GetCimSessionInstanceId   Method         guid GetCimSessionInstanceId()                                                                                         
GetHashCode               Method         int GetHashCode()                                                                                                      
GetObjectData             Method         void GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serialization.StreamingContex...
GetType                   Method         type GetType()                                                                                                         
ToString                  Method         string ToString()                                                                                                      
Actions                   Property       CimInstance#InstanceArray Actions {get;set;}                                                                           
Author                    Property       string Author {get;set;}                                                                                               
Date                      Property       string Date {get;set;}                                                                                                 
Description               Property       string Description {get;set;}                                                                                          
Documentation             Property       string Documentation {get;set;}                                                                                        
Principal                 Property       CimInstance#Instance Principal {get;set;}                                                                              
PSComputerName            Property       string PSComputerName {get;}                                                                                           
SecurityDescriptor        Property       string SecurityDescriptor {get;set;}                                                                                   
Settings                  Property       CimInstance#Instance Settings {get;set;}                                                                               
Source                    Property       string Source {get;set;}                                                                                               
TaskName                  Property       string TaskName {get;}                                                                                                 
TaskPath                  Property       string TaskPath {get;}                                                                                                 
Triggers                  Property       CimInstance#InstanceArray Triggers {get;set;}                                                                          
URI                       Property       string URI {get;}                                                                                                      
Version                   Property       string Version {get;set;}                                                                                              
State                     ScriptProperty System.Object State {get=[Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]($this.PSBase.Ci...
#>}

$y=Get-ScheduledTask -TaskName '*sql*'; $y |gm
$x=Get-ScheduledTask  | ? {$_.TaskName -like '*Application_MSSQLSERVER_9689*'} ;$x.TaskName

#Get-ScheduledTaskInfo  :Gets run-time information for a scheduled task.
Get-ScheduledTaskInfo -TaskName 'baseline'  |select *  ;Get-ScheduledTaskInfo -TaskName 'SQL 9689'  |select *  ;
Get-ScheduledTask -TaskName 'baseline' |select * ;   Get-ScheduledTask -TaskName 'SQL 9689' |select *

Get-ScheduledTaskInfo -TaskName '\Event Viewer Tasks\Application_MSSQLSERVER_9689'
Get-ScheduledTask  | ? {$_.TaskName -like '*Application_MSSQLSERVER_9689*'} |Get-ScheduledTaskInfo
Get-ScheduledTask -TaskPath "\Event Viewer Tasks\" | Get-ScheduledTaskInfo
$x=Get-ScheduledTask ;$x.count

##New

-command  "& {Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject "$env:computername+' SQL Stop'"  -body (get-date).ToString()  -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw'} "



#ex1 simple
$TaskName='Notepad As Admin at 10AM'
$ST_A = New-ScheduledTaskAction –Execute “c:\windows\system32\notepad.exe”
$ST_T = New-ScheduledTaskTrigger -Once -At 10:00
Register-ScheduledTask –TaskName “Notepad As Admin at 10AM” -Action $ST_A –Trigger $ST_T –User “csd\Administrator”

Get-ScheduledTask $TaskName  | Get-ScheduledTaskInfo



#ex2 run -file
$TaskName = "zMingScheduledTask"
$TaskDescr =" Description "
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript = "H:\scripts\MingTestPS1.ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript"$TaskStartTime = [datetime]::Now.AddMinutes(2) 
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -OnceRegister-ScheduledTask -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "System" -RunLevel Highest -Description $TaskDescr 

#ex3 run -file + parameter
$para1='2'
$TaskName = "zbaseline"
$TaskDescr =" baseline test add 1 Min, run 2 Min "
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript = "C:\PerfLogs\Baseline.ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " +$para1$TaskStartTime = [datetime]::Now.AddMinutes(1) 
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -OnceRegister-ScheduledTask -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "System" -RunLevel Highest -Description $TaskDescr 

Get-ScheduledTask $TaskName  | Get-ScheduledTaskInfo


## ex4 , directory 
$TaskName = "SQL 9689"
$TaskDescr ="  Send-MailMessage  when host eventid:9689 Trigger  "
$TaskCommand = "powershell" #$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
#$TaskScript = "& {Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject 'SQL Event 9689'  -body 'yyy'  -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw' } "
$TaskScript = "& {Send-MailMessage  -to  ming_tseng@syscom.com.tw  -Subject 'SQL2012X SQL Event 9689'   -body (get-date).ToString()  -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw' } "$TaskArg =  "-command  $TaskScript"$TaskStartTime = [datetime]::Now.AddMinutes(1) 
$TaskAction  = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -OnceRegister-ScheduledTask -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "System" -RunLevel Highest -Description $TaskDescr 



## Delete

Unregister-ScheduledTask –TaskName $TaskName  -Confirm:$false;Get-ScheduledTask  
Get-ScheduledJob




##Start   /stop

Start-ScheduledTask $TaskName

## Set
$Time = New-ScheduledTaskTrigger -At 10:23:50 -Once
Set-ScheduledTask –TaskName $TaskName –Trigger $Time

#--------------------------------------------
#   3  250  New-ScheduledTaskAction
#--------------------------------------------
Parameter Set: Exec
New-ScheduledTaskAction [-Execute] <String> 
[[-Argument] <String> ] 
[[-WorkingDirectory] <String> ] 
[-AsJob] [-CimSession <CimSession[]> ] 
[-Id <String> ] 
[-ThrottleLimit <Int32> ] 
[ <CommonParameters>]


$para1='1'
$TaskName = "zbaseline"
$TaskDescr =" baseline test add 1 Min, run 2 Min "
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\Baseline.ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para1$TaskStartTime = "11:20:00" 
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once
Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 


#--------------------------------------------
#  4 300  ScheduledTaskTrigger 
#--------------------------------------------



## Jul.17.2014 目前  New-ScheduledTaskTrigger (只有 -once, -atLogOn , -AsStartup , -Daily , -Weekly) 未發現 -attrigger 
 在UI 設定上 , 
     on a schedule , at log on , At startup ,
     on idle , on an event , 
     at tasks creation/modificatin , 
     on connection to user sessin , on disconnectin from user session,
     on workstation lock , on workstation unlock 
{<#Parameter Set: Once
New-ScheduledTaskTrigger [-Once] -At <DateTime> [-RandomDelay <TimeSpan> ] [-RepetitionDuration <TimeSpan> ] [-RepetitionInterval <TimeSpan> ] [ <CommonParameters>]

Parameter Set: AtLogon
New-ScheduledTaskTrigger [-AtLogOn] [-RandomDelay <TimeSpan> ] [-User <String> ] [ <CommonParameters>]

Parameter Set: AtStartup
New-ScheduledTaskTrigger [-AtStartup] [-RandomDelay <TimeSpan> ] [ <CommonParameters>]

Parameter Set: Daily
New-ScheduledTaskTrigger [-Daily] -At <DateTime> [-DaysInterval <Int32> ] [-RandomDelay <TimeSpan> ] [ <CommonParameters>]

Parameter Set: Weekly
New-ScheduledTaskTrigger [-Weekly] -At <DateTime> -DaysOfWeek {Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday}[] [-RandomDelay <TimeSpan> ] [-WeeksInterval <Int32> ] [ <CommonParameters>]

#>}

#--------------------------------------------
#  5  300  Register-ScheduledTask
#--------------------------------------------
## 


Parameter Set: User
Register-ScheduledTask [-TaskName] <String> 
[[-TaskPath] <String> ] 
[-Action] <CimInstance[]> 
[[-Trigger] <CimInstance[]> ] 
[[-Settings] <CimInstance> ] 
[[-User] <String> ] 
[[-Password] <String> ] 
[[-RunLevel] <RunLevelEnum> ] 
[[-Description] <String> ] 
[-AsJob] 
[-CimSession <CimSession[]> ] 
[-Force] [-ThrottleLimit <Int32> ] 
[ <CommonParameters>]

Parameter Set: Object
Register-ScheduledTask 
[[-TaskName] <String> ] 
[[-TaskPath] <String> ] 
[-InputObject] <CimInstance> 
[[-User] <String> ] 
[[-Password] <String> ] 
[-AsJob] [-CimSession <CimSession[]> ] 
[-Force] [-ThrottleLimit <Int32> ] 
[ <CommonParameters>]

Parameter Set: Principal
Register-ScheduledTask [-TaskName] <String> [[-TaskPath] <String> ] [-Action] <CimInstance[]> [[-Trigger] <CimInstance[]> ] [[-Settings] <CimInstance> ] [[-Principal] <CimInstance> ] [[-Description] <String> ] [-AsJob] [-CimSession <CimSession[]> ] [-Force] [-ThrottleLimit <Int32> ] [ <CommonParameters>]

Parameter Set: Xml
Register-ScheduledTask [-TaskName] <String> [[-TaskPath] <String> ] [-Xml] <String> [[-User] <String> ] [[-Password] <String> ] [-AsJob] [-CimSession <CimSession[]> ] [-Force] [-ThrottleLimit <Int32> ] [ <CommonParameters>]

Register-ScheduledTask   
-TaskName "$TaskName"
-Action $TaskAction 
-Trigger $Tasktrigger 
-User "csd\administrator" 

-RunLevel Highest 
-Description $TaskDescr 







#--------------------------------------------
#   6 400   schtasks.exe create  ScheduledTask 
#--------------------------------------------
 http://technet.microsoft.com/en-us/magazine/ff356867.aspx
{
<#Use SchTasks.exe to Create and Manage TasksThe Schtasks.exe command-line interface utility allows an administrator to create, delete, query, change, run, and end scheduled tasks on a local or remote system through the command shell. Here’s an overview of its syntax and parameters. 

Follow Our Daily Tips
RSS | Twitter | Blog | Facebook

Tell Us Your Tips
Share your tips and tweaks.
Command Syntax
The SchTasks.exe command interface uses the following syntax: 
SCHTASKS /<parameter> [arguments] 

Command Parameters
The available parameters for SchTasks.exe are as follows: 
/Create Creates a new scheduled task
/Delete Deletes the scheduled task(s)
/Query Displays all scheduled tasks
/Change Changes the properties of the scheduled task
/Run Runs the scheduled task immediately
/End Stops the currently running scheduled task
/? Displays a help message

<Creating Tasks>
The general syntax for Schtasks.exe is as follows: 
SCHTASKS /Create [/S system [/U <username> [/P [<password>]]]] [/RU <username> [/RP <password>]] /SC schedule [/MO <modifier>] [/D <day>] [/M <months>] [/I <idletime>] /TN <taskname> /TR <taskrun> [/ST <starttime>] [/RI <interval>] [ {/ET <endtime> | /DU <duration>} [/K] [/XML <xmlfile>] [/V1]] [/SD <startdate>] [/ED <enddate>] [/IT] [/Z] [/F] 

The following is an example command: 
SCHTASKS /Create /S system /U user /P password /RU runasuser /RP runaspassword /SC HOURLY /TN rtest1 /TR notepad 
<Deleting TaskS>
The general syntax for deleting a task is as follows: 
SCHTASKS /Delete [/S <system> [/U <username> [/P [<password>]]]] /TN <taskname> [/F] The following is an example command: 
SCHTASKS /Delete /TN "Backup and Restore” 

<Running Tasks>
The general syntax for running a task is as follows: 
SCHTASKS /Run [/S <system> [/U <username> [/P [<password>]]]] /TN <taskname> The following is an example command: 
SCHTASKS /Run /TN "Start Backup" 

<Ending Tasks>
The general syntax for ending a task is as follows: 
SCHTASKS /End [/S <system> [/U <username> [/P [<password>]]]] /TN <taskname> The following is an example command: 
SCHTASKS /End /TN "Start Backup" 
<Querying Tasks>
The general syntax for querying a task is as follows: SCHTASKS /Query [/S <system> [/U <username> [/P [<password>]]]] [/FO <format>] [/NH] [/V] [/?] The following is an example command: 
SCHTASKS /Query /S system /U user /P password SCHTASKS /Query /FO LIST /V 
<Changing Tasks>
The general syntax for changing a task is as follows: 
SCHTASKS /Change [/S <system> [/U <username> [/P [<password>]]]] /TN <taskname> { [/RU <runasuser>] [/RP <runaspassword>] [/TR <taskrun>] [/ST <starttime>] [/RI <interval>] [ {/ET <endtime> | /DU <duration>} [/K]] [/SD <startdate>] [/ED <enddate>] [/ENABLE | /DISABLE] [/IT] [/Z] } 
The following is an example command: SCHTASKS /Change /RP password /TN "Backup and Restore" 
From the Microsoft Press book The Windows 7 Resource Kit by Mitch Tulloch, Tony Northrup, Jerry Honeycutt, Ed Wilson, and the Windows 7 Team at Microsoft.
#>
}


Function Create-ScheduledTask   {            
    param(            
      [string]$ComputerName = "localhost",            
      [string]$RunAsUser = "System",            
      [string]$TaskName = "Configure-DC1",            
      [string]$TaskRun = "'PowerShell.exe -NoLogo -File C:\Configure-DC1.ps1'",            
      [string]$Schedule = "ONLOGON"            
           )                            

                                                            

  $Command = "schtasks.exe /create /s $ComputerName /ru $RunAsUser /tn $TaskName /tr $TaskRun /sc $Schedule /F"            

  Invoke-Expression $Command            

 }


#--------------------------------------------
#    x   time-based trigger vs Event-based triggers
#--------------------------------------------
Event-based triggers
Much simpler when using PowerShell version 4
$TaskName = "MyScheduledTask"
$TaskDescr
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript = "C:\scripts\myscript.ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript"$TaskStartTime = [datetime]::Now.AddMinutes(1) 
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once#multi Time$TaskTrigger = @()for ($i = 1; $i -lt 24; $i++)
{ 
    $is=$i.ToString();#$i

    $TaskRunTime=""+$is+":30:00";$TaskRunTime
    $TaskTrigger += New-ScheduledTaskTrigger -Daily -At $TaskRunTime
}$TaskTrigger
$TaskTrigger += New-ScheduledTaskTrigger -Daily -At 03:00
$TaskTrigger += New-ScheduledTaskTrigger -Daily -At 09:00
$TaskTrigger += New-ScheduledTaskTrigger -Daily -At 15:00
$TaskTrigger += New-ScheduledTaskTrigger -Daily -At 21:Register-ScheduledTask -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "System" -RunLevel Highest
## Jul.17.2014 目前  New-ScheduledTaskTrigger (只有 -once, -atLogOn , -AsStartup , -Daily , -Weekly) 未發現 -at trigger 
{<#Parameter Set: Once
New-ScheduledTaskTrigger [-Once] -At <DateTime> [-RandomDelay <TimeSpan> ] [-RepetitionDuration <TimeSpan> ] [-RepetitionInterval <TimeSpan> ] [ <CommonParameters>]

Parameter Set: AtLogon
New-ScheduledTaskTrigger [-AtLogOn] [-RandomDelay <TimeSpan> ] [-User <String> ] [ <CommonParameters>]

Parameter Set: AtStartup
New-ScheduledTaskTrigger [-AtStartup] [-RandomDelay <TimeSpan> ] [ <CommonParameters>]

Parameter Set: Daily
New-ScheduledTaskTrigger [-Daily] -At <DateTime> [-DaysInterval <Int32> ] [-RandomDelay <TimeSpan> ] [ <CommonParameters>]

Parameter Set: Weekly
New-ScheduledTaskTrigger [-Weekly] -At <DateTime> -DaysOfWeek {Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday}[] [-RandomDelay <TimeSpan> ] [-WeeksInterval <Int32> ] [ <CommonParameters>]

#>}

#--------------------------------------------
#  7 500  Managing failover clusters with scheduled tasks
#--------------------------------------------

On a specific resource
On any node
On the cluster:(all)
Get-ClusteredScheduledTask 







#--------------------------------------------
#  8  500  example   scheTest.ps1  
#--------------------------------------------


<#
## 
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\scheTest.ps1
C:\PerfLogs\scheTest.ps1

taskschd.msc 
UI taskschd.msc設定定時    執行 5 Sec 停止, 將記錄寫入 File
UI 內容 > 動作 > 編輯動作 > 設定 > 程式或指令碼 : powershell , 新增引數: C:\PerfLogs\scheTest.ps1
#>

$t1=(get-date)
$timespan = new-timespan -Seconds 5
$t2= $t1+ $timespan
$t1;$t2
$x=0
$runFile="C:\perflogs\TestSQL.txt"
if ( (Test-Path $runFile) -eq $True )
{
  Remove-Item $runFile  
}


"start -"+$t1.ToString() | Out-File $runFile -Append 
do
{
   if ($t1 -gt $t2)
    {
        
        "end   -"+ $t1.ToString() | Out-File $runFile -Append 
        break
    }
    
    $t1=(get-date); 
    
}
until ($x -gt 0)



#--------------------------------------------
# 9 566  JOB CMDLET  
# http://technet.microsoft.com/zh-TW/library/dd315273.aspx
#--------------------------------------------
<#
Start-Job        在本機電腦上啟動背景工作。
Get-Job          取得在目前工作階段中啟動的背景工作。
Receive-Job      取得背景工作的結果。
Stop-Job         停止背景工作。
Wait-Job         隱藏命令提示字元，直到一個或所有工作完成。
Remove-Job       刪除背景工作。
Invoke-Command   AsJob 參數會在遠端電腦上以背景工作執行命令。您也可以使用 
Invoke-Command   遠端執行任何工作命令，包括 Start-Job 命令。
#>

"背景中執行命令或運算式，且與目前工作階段沒 有互動的相關資訊。"
## get job  gh get-job -full
cls;Get-Job 
 $job = get-job -id 24 
 $job |select command
#Receive-Job Cmdlet  Start-Job Cmdlet 會傳回代表工作的工作物件，但不包含結果取得背景工作的結果 .so using  receive-job 取得結果

receive-job -job $job
$results = receive-job -job $job
receive-job -job $job > results.txt
receive-job -job $job -keep  "尚未完成的工作上使用 Keep 參數的效果  ,Receive-Job 會傳回目前為止已產生的所有結果 "

#可讓您等候特定工作、所有工作或任何工作的完成
wait-job -ID 10
wait-job -ID 10 -timeout 120  #使用 Timeout 參數，將等候時間限制為 120 秒。若超過時間，命令提示字元便會傳回，但工作仍在背景繼續執行



## set job
"停止工作"
$job = start-job -scriptblock {get-eventlog -log system} 
$job | stop-job 

"刪除工作 To remove the job, first stop the job,"
remove-job -job $job  ;Get-Job 

Remove-Job * -Id 2
##啟動執行 Get-Process 命令的背景工作
start-job -scriptblock {get-process}
start-job -scriptblock { Get-counter -Counter "\Processor(_Total)\% Processor Time" –Continuous }

$job = start-job -scriptblock {get-process}   #啟動一個工作物件，並將產生的工作物件儲存到 $job 變數。 

## pass variable to start-job

Start-Job -Scriptblock {param($p) "`$p is $p"} -Arg 'Server1'

$pingblock = {param($servername) pathping $servername | Out-File C:\...\ServerPing.txt}
Start-Job $pingblock -Arg Server1


$PCR="\Processor(_total)\% Processor Time"
$jobx=
start-job   {Get-Counter $using:PCR -MaxSamples 61 -SampleInterval 1 |Export-Counter -Path C:\PerfLogs\capture7.blg -FileFormat blg -force}
get-job

#--------------------------------------------
# 10 630  Get-eventlogs
#--------------------------------------------
Get-EventLog -LogName 

Get-EventLog -LogName Application 
-Newest  10 -UserName  
-Source   #  MSSQLSERVER  ,MSSQL$SQLS2  ex : all $events | group-object -property source -noelement 
-Message  # get-eventlog -logname "Application" -message "*failed*" -newest 10
-EntryType  #  Error, Information, FailureAudit, SuccessAudit, and Warning ex
-InstanceId  # Gets only events with the specified instance IDs.
-after
-before #get-eventlog -log "Windows PowerShell" -entrytype Error -after $may31 -before $july1
-ComputerName


Get-Eventlog -List -ComputerName sp2013   # logname  Application, Security , System  ,Windows PowerShell


Get-eventlog -newest 5 -logname 'Windows PowerShell'
Get-eventlog -newest 5 -Source MSSQLSERVER  -logname Application
Get-eventlog -newest 5 -logname Application


$a = get-eventlog -log System -newest 1
##  Group event
$events = get-eventlog -logname Application -newest 1000
$events | group-object -property source -noelement | sort-object -property count –descending #|fl

##  get all source  and sort 
$events = get-eventlog -logname Application -newest 989
$events | group-object -property source -noelement |sort -Property name 

## late detail
$a = get-eventlog -log System -newest 1
$a  |gm
$a |select * 

##  Get mulit-server event
Get-eventlog -logname "Application" -computername sp2013, sql2012x, sp2013wfe  -Newest  2
Get-eventlog -logname "Application" -computername sp2013, sql2012x, sp2013wfe  -Source MSSQLSERVER -EntryType Error -Newest  5


## filter eventID
get-eventlog -log application | ?  {$_.eventID -eq 9689}       
get-eventlog -log application | ?  {$_.eventID -eq 9689} |select EventID,MachineName        



##  occurred Time  and exports
$20131231_000000 = get-date '12/31/13 00:00:00'
$20140111_000000 = get-date '1/1/14 00:00:00'
$20140111_235959 = get-date '1/11/14  23:59:59'

Get-eventlog -log application -entrytype Error -after $20131231_000000 -before $20140111_000000   | Export-Csv "H:\temp\169.csv" -Force


Get-eventlog -log application -entrytype Error `
 -after  (get-date '1/6/14  00:00:00').ToString() `
 -before (get-date '1/10/14  00:00:00').ToString()  `
 | Export-Csv "H:\temp\174.csv" -Force



Get-eventlog -log application  `
 -after  (get-date '1/6/14  00:00:00').ToString() `
 -before (get-date '1/10/14  00:00:00').ToString()  | ?  {$_.eventID -eq 9689}  `
 | Export-Csv "H:\temp\174.csv" -Force

#--------------------------------------------
# 11 700 new  & clear & remove  & write-log
#--------------------------------------------
New-EventLog 
[-LogName] <String> 
[-Source] <String[]> 
[[-ComputerName] <String[]> ] 
[-CategoryResourceFile <String> ] 
[-MessageResourceFile <String> ] 
[-ParameterResourceFile <String> ] 
[ <CommonParameters>]

new-eventlog -source zMingSource -logname zMingeventLog #-MessageResourceFile C:\Test\TestApp.dll
get-eventlog -list
get-eventlog -ComputerName . -Source zMingeventLog -logname zMingeventLog

##
Write-EventLog 
[-LogName] <String> 
[-Source] <String> 
[-EventId] <Int32> 
[[-EntryType] <EventLogEntryType> ] 
[-Message] <String> 
[-Category <Int16> ] 
[-ComputerName <String> ] 
[-RawData <Byte[]> ] 
[ <CommonParameters>]

write-eventlog -logname zMingeventLog -source zMingSource -eventID 3838 -entrytype Information `
-message "Ming added a user-requested feature to the display." -category 1 -rawdata 10,20

write-eventlog -logname zMingeventLog -source zMingSource -eventID 3838 -entrytype Information `
-message "097   Ming added a user-requested feature to the display." -category 1 -rawdata 10,20

Get-eventlog -ComputerName . -Source zMingSource -logname zMingeventLog


##
clear-eventlog -logname MingeventLog  -computername sp2013

## remove-eventLog 

Remove-EventLog 
[-LogName] <String[]> 
[[-ComputerName] <String[]> ] 
[-Confirm] 
[-WhatIf] 
[ <CommonParameters>]

#
remove-eventlog -logname MingeventLog
get-eventlog -list
##




#--------------------------------------------
# 12  760 Get-WinEvent
#--------------------------------------------
Get-WinEvent -ListLog  *

$x=Get-Winevent -path H:\temp\Application1603.evtx 
$x |gm

##如何建立 event 自訂檢視
如何建立event 自訂檢視
先由UI > 建立檢視 > View XML 頁次 








#--------------------------------------------
# 13  800  wevtutil 
#--------------------------------------------
wevtutil 
[{el | enum-logs}] 
[{gl | get-log} <;Logname> [/f:<Format>]]
[{sl | set-log} <;Logname> [/e:<Enabled>] [/i:<Isolation>] [/lfn:<Logpath>] [/rt:<Retention>] [/ab:<Auto>] [/ms:<Size>] [/l:<Level>] [/k:<Keywords>] [/ca:<Channel>] [/c:<Config>]] 
[{ep | enum-publishers}] 
[{gp | get-publisher} <;Publishername> [/ge:<Metadata>] [/gm:<Message>] [/f:<Format>]] [{im | install-manifest} <Manifest>] 
[{um | uninstall-manifest} <;Manifest>] [{qe | query-events} <Path> [/lf:<Logfile>] [/sq:<Structquery>] [/q:<Query>] [/bm:<Bookmark>] [/sbm:<Savebm>] [/rd:<Direction>] [/f:<Format>] [/l:<Locale>] [/c:<Count>] [/e:<Element>]] 
[{gli | get-loginfo} <;Logname> [/lf:<Logfile>]] 
[{epl | export-log} <;Path> <Exportfile> [/lf:<Logfile>] [/sq:<Structquery>] [/q:<Query>] [/ow:<Overwrite>]] 
[{al | archive-log} <;Logpath> [/l:<Locale>]] 
[{cl | clear-log} <Logname> [/bu:<Backup>]] [/r:<Remote>] [/u:<Username>] [/p:<Password>] [/a:<Auth>] [/uni:<Unicode>]


wevtutil el -?

wevtutil el   #利用 el 參數列出目前可供查詢的事件名稱  vs Get-eventlog -list

wevtutil epl MingeventLog  H:\Tasklog.evtx #匯出紀錄事件名稱,匯出的副檔名以 evtx 命名




## save to evtx 
wevtutil epl System H:\temp\system1603.evtx
wevtutil epl Application H:\temp\Application1603.evtx
wevtutil epl System "\\london\shared\$($computer)_systemlog.evtx" /remote:$computer /overwrite:true

wevtutil gli Application


$start = '1/1/2012'
$end = '1/2/2012'
function GetMilliseconds ($date) {
    $ts = New-TimeSpan -Start $date -End (Get-Date)
    [math]::Round($ts.TotalMilliseconds)
    } # end function
$startDate = GetMilliseconds(Get-Date $start)
$endDate = GetMilliseconds(Get-Date $end)
wevtutil epl Application test.evtx /q:"*[System[TimeCreated[timediff(@SystemTime) >= $endDate] and TimeCreated[timediff(@SystemTime) <= $startDate]]]"


#--------------------------------------------
# get-task 
#--------------------------------------------


#--------------------------------------------
# event gm and  select * 
#--------------------------------------------
{
<#PS SQLSERVER:\> $a = get-eventlog -log System -newest 1
$a  |gm
$a |select * 


   TypeName: System.Diagnostics.EventLogEntry#System/Service Control Manager/1073748860

Name                      MemberType     Definition                                                                                              
----                      ----------     ----------                                                                                              
Disposed                  Event          System.EventHandler Disposed(System.Object, System.EventArgs)                                           
CreateObjRef              Method         System.Runtime.Remoting.ObjRef CreateObjRef(type requestedType)                                         
Dispose                   Method         void Dispose(), void IDisposable.Dispose()                                                              
Equals                    Method         bool Equals(System.Diagnostics.EventLogEntry otherEntry), bool Equals(System.Object obj)                
GetHashCode               Method         int GetHashCode()                                                                                       
GetLifetimeService        Method         System.Object GetLifetimeService()                                                                      
GetObjectData             Method         void ISerializable.GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime....
GetType                   Method         type GetType()                                                                                          
InitializeLifetimeService Method         System.Object InitializeLifetimeService()                                                               
ToString                  Method         string ToString()                                                                                       
Category                  Property       string Category {get;}                                                                                  
CategoryNumber            Property       int16 CategoryNumber {get;}                                                                             
Container                 Property       System.ComponentModel.IContainer Container {get;}                                                       
Data                      Property       byte[] Data {get;}                                                                                      
EntryType                 Property       System.Diagnostics.EventLogEntryType EntryType {get;}                                                   
Index                     Property       int Index {get;}                                                                                        
InstanceId                Property       long InstanceId {get;}                                                                                  
MachineName               Property       string MachineName {get;}                                                                               
Message                   Property       string Message {get;}                                                                                   
ReplacementStrings        Property       string[] ReplacementStrings {get;}                                                                      
Site                      Property       System.ComponentModel.ISite Site {get;set;}                                                             
Source                    Property       string Source {get;}                                                                                    
TimeGenerated             Property       datetime TimeGenerated {get;}                                                                           
TimeWritten               Property       datetime TimeWritten {get;}                                                                             
UserName                  Property       string UserName {get;}                                                                                  
EventID                   ScriptProperty System.Object EventID {get=$this.get_EventID() -band 0xFFFF;}                                           

EventID            : 7036
MachineName        : SP2013.CSD.syscom
Data               : {119, 0, 117, 0...}
Index              : 134672
Category           : (0)
CategoryNumber     : 0
EntryType          : Information
Message            : The Windows Update service entered the 停止 state.
Source             : Service Control Manager
ReplacementStrings : {Windows Update, 停止}
InstanceId         : 1073748860
TimeGenerated      : 1/20/2014 11:01:55 AM
TimeWritten        : 1/20/2014 11:01:55 AM
UserName           : 
Site               : 
Container          : 

#>

}

#--------------------------------------------
#
#-------------------------------------------- 
