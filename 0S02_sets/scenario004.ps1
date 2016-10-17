<#

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\scenario004.ps1

C:\PerfLogs\scenario004.ps1

 createData : Jul.19.2014
 history : 使用<C>內建語法. Insert into * 僅  1777 筆 僅  100ms ,
 但是使用 <B> foreach  1777 筆 需   11  Sec   差很多
 
 author:Ming Tseng a0921887912@gmail.com

 週期排程收集  DMV sys.dm_os_performance_counters  to  Sql_inventory.statusOSPCRALL
 動態產生  out-file  C:\PerfLogs\Tsql04.ps1
 以及建立在 遠端  schetask

 [string]  $runschdNode,  執行schetask的主機
  [string] $TaskRunTime  ,開始執行時間
  [string] $timespanlenMin  ,執行多久 (分)
  [string] $SampleIntervalSec ,取樣秒數
  [string] $CollectIns  收集的SQL Instance
  [string] $inventoryIns,  儲存的 SQL instance
  [string] $inventorydb   :儲存的 SQL DB 
  .\scenario004 sp2013 1 "18:00:11" spm SQL_Inventory

#>

#---------------------------------------------------------------
#    < A >  CREATE TABLE
#---------------------------------------------------------------
<#table

USE [SQL_Inventory]
GO

ALTER TABLE [dbo].[statusOSPCRALL] DROP CONSTRAINT [DF_statusOSPCRALL_updateDate]
GO

/****** Object:  Table [dbo].[statusOSPCRALL]    Script Date: 7/19/2014 5:59:02 PM ******/
DROP TABLE [dbo].[statusOSPCRALL]
GO


/****** Object:  Table [dbo].[[statusOSPCRALL]]    Script Date: 7/19/2014 5:59:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[statusOSPCRALL](
	[instance_name] [nchar](128) NULL,
	[counter_name] [nchar](128) NULL,
	[cntr_value] [bigint] NULL,
	[object_name] [nchar](128) NULL,
	[updateDate] [datetime] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[statusOSPCRALL] ADD  CONSTRAINT [DF_statusOSPCRALL_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO














#>
#---------------------------------------------------------------
#    < B >  use foreach  保留 不使用
#---------------------------------------------------------------
{<#

Param(
  [string] $runSchdNode,
  [string] $TaskRunTime,
  [string] $SecsInterval,
  [string] $CollectIns,
  [string] $inventoryIns,
  [string] $inventorydb 
)

$runSchdNode ="sp2013"
$TaskRunTime ="17:12:00"
$SampleIntervalSec="5"
$CollectIns  ="spm"
$inventoryIns="spm"
$inventorydb ="SQL_Inventory"

#$filedest='\\sql2012x\C$\PerfLogs\1.ps1'
#---------------------------------------------------------------
#   out-file  Tsql004.ps1
#---------------------------------------------------------------

$filedest ="\\"+$runSchdNode+'\C$\PerfLogs\Tsql004.ps1'
## file column don't over 80 -Width 160
$Filecontent={
Param(
  [string] $inventoryIns,
  [string] $inventorydb
)
#$inventoryIns="spm"
#$inventorydb   ="SQL_Inventory"

if ((Get-Module -Name sqlps) -eq $null) {Import-Module “sqlps” -DisableNameChecking}
$t1=get-date;$t1
#$tquery="select * FROM sys.dm_os_performance_counters where counter_name='Transactions/sec'"
$tquery="select  *  FROM sys.dm_os_performance_counters"
$DMVOSPCRS = Invoke-Sqlcmd  -ServerInstance $CollectIns -Query $tquery

$t2=get-date;$t2
$DMVOSPCRS.Count
foreach ($DMVOSPCR in $DMVOSPCRS)
{ #p90
 
       $vinstance_name=($DMVOSPCR[2]).Trim()
       $vcounter_name =($DMVOSPCR[1]).Trim()
       $vcntr_value   =$DMVOSPCR[3]
       $vobject_name  =($DMVOSPCR[0]).Trim()
     if (($vinstance_name).Contains("'") -eq $True)
     { $vinstance_name=$vinstance_name -replace("'"," ")}
       
$sql_insert =@" 
INSERT INTO [dbo].[statusOSPCRALL]
           ([instance_name]
           ,[counter_name]
           ,[cntr_value]
           ,[object_name]
           )
     VALUES
           ('$vinstance_name'
           ,'$vcounter_name'  
           ,'$vcntr_value'
           ,'$vobject_name'
           )
"@
    #$sql_insert 
    Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb
}#p90
$t3=get-date;$t3

($t2-$t1).TotalSeconds
($t3-$t2).TotalSeconds
1777 need 11 Sec

}

cd c:\
$Filecontent |  Out-File  $filedest -Width 160 -force
insert into statusOSPCRALL (instance_name,counter_name,cntr_value,object_name) select instance_name,counter_name,cntr_value,object_name   FROM sys.dm_os_performance_counters  
#>}

'

Sunday, July 20, 2014 8:27:48 PM
Sunday, July 20, 2014 8:27:48 PM
1777
Sunday, July 20, 2014 8:27:59 PM
0.0830459
11.7673964 sec
'
#---------------------------------------------------------------
#    < C >   內建語法. Insert into *   
#---------------------------------------------------------------
<#  有一個 問題是  collectionInstance 必須是  inventroyInstance 同一個 

Param(
  [string] $runSchdNode,
  [string] $TaskRunTime,
  [string] $timespanlenMin,
  [string] $SampleIntervalSec,
  [string] $CollectIns,
  [string] $inventoryIns,
  [string] $inventorydb 
)
#>
$runSchdNode ="sp2013"
$TaskRunTime ="17:12:00"
$timespanlenMin=1
$SampleIntervalSec=5
$CollectIns  ="spm"
$inventoryIns="spm"
$inventorydb ="SQL_Inventory"

#$filedest='\\sql2012x\C$\PerfLogs\1.ps1'
#---------------------------------------------------------------
#   < C1 >  out-file 
#---------------------------------------------------------------

$filedest ="\\"+$runSchdNode+'\C$\PerfLogs\Tsql004.ps1'
## file column don't over 80 -Width 160




$Filecontent={  #p.188
Param(
  [string] $inventoryIns,
  [string] $inventorydb
  )
  $t1=get-date;$t1
$runSchdNode ="sp2013"
$TaskRunTime ="17:12:00"
$timespanlenMin=1
$SampleIntervalSec=3
$CollectIns  ="spm"
$inventoryIns="spm"
$inventorydb ="SQL_Inventory"

if ((Get-Module -Name sqlps) -eq $null) {Import-Module “sqlps” -DisableNameChecking}

#$timespan = new-timespan -Minutes $timespanlenMin
#$timespan=''''+($timespan.Hours).ToString()+':'+($timespan.Minutes).ToString()+':'+($timespan.Seconds).ToString()+''''
if ($SampleIntervalSec -gt 60)  { $SampleIntervalSec= 59}
$timespan='''0:0:'+$SampleIntervalSec.ToString()+''''
$Gonum=[math]::round(($timespanlenMin *60)/$SampleIntervalSec)
$vquerytimeout=$timespanlenMin *70

$sql_insert=@"
insert into statusOSPCRALL (instance_name,counter_name,cntr_value,object_name) 
select instance_name,counter_name,cntr_value,object_name   FROM sys.dm_os_performance_counters  
WAITFOR DELAY $timespan 
GO $Gonum       

"@
 Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb -QueryTimeout $vquerytimeout
 $t2=get-date;$t2
 ($t2-$t1).TotalSeconds
} #p.188

cd c:\
$Filecontent |  Out-File  $filedest -Width 160 -force#truncate table [statusOSPCRALL]
#select * from [statusOSPCRALL]
#select distinct updatedate from [statusOSPCRALL] order by updatedate
#select * from [sp2013].msdb.sys.dm_os_performance_counters
#select * from sql2012x.msdb.sys.dm_os_performance_counters
#---------------------------------------------------------------
#   < C2 > schetask.msc
#---------------------------------------------------------------

icm -ComputerName $destNode -ScriptBlock {

$TaskName       = "Tsql004"
$TaskDescr =  $TaskName +"  check logSpaceUsed % :  DaysInterval each "+$using:DaysInterval +" Day  ,TaskRunTime:" + $using:TaskRunTime 
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $using:para_svrinstance +" "+ $using:para_database
$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -OnceRegister-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "$env:USERDOMAIN\$env:USERNAME" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
}
#icm -ComputerName $destNode  -ScriptBlock {Unregister-ScheduledTask –TaskName $using:TaskName  -Confirm:$false}

{<#
#---------------------------------------------------------------
#  <D >  use link server
#---------------------------------------------------------------
#不能使用 spm 必須使用  Hostname

#link server 
insert into sql2012x.[IamSQL2012X].[dbo].[statusOSPCRALL] (instance_name,counter_name,cntr_value,object_name) 
select instance_name,counter_name,cntr_value,object_name   
FROM sp2013.msdb.sys.dm_os_performance_counters  

##  data access
USE [master]
GO
EXEC master.dbo.sp_serveroption @server=N'SP2013', @optname=N'data access', @optvalue=N'true'
GO

##------
#run node as sql2012x

$inventoryIns='sql2012x'
$inventorydb='IamSQL2012X'

$x=1
do
{
$t1=get-date;$t1
$sql_insert=@"
insert into sql2012x.[IamSQL2012X].[dbo].[statusOSPCRALL] (instance_name,counter_name,cntr_value,object_name) 
select instance_name,counter_name,cntr_value,object_name   
FROM sp2013.msdb.sys.dm_os_performance_counters   
"@
 $t2=get-date;$t2
 Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb
 $t3=get-date;$t3

$x.tostring() +' p1 = '+ ($t2-$t1).TotalSeconds
$x.tostring() +' p2 = '+ ($t3-$t2).TotalSeconds
   sleep 2
   $x +=1
}
until ($x -gt 5)  
'
2014年7月20日 下午 07:41:51
2014年7月20日 下午 07:41:51
2014年7月20日 下午 07:41:51
1 p1 = 0.0205342
1 p2 = 0.2195892
2014年7月20日 下午 07:41:53
2014年7月20日 下午 07:41:53
2014年7月20日 下午 07:41:53
2 p1 = 0.0019592
2 p2 = 0.4338217
2014年7月20日 下午 07:41:55
2014年7月20日 下午 07:41:55
2014年7月20日 下午 07:41:55
3 p1 = 0.0029263
3 p2 = 0.1886958
2014年7月20日 下午 07:41:58
2014年7月20日 下午 07:41:58
2014年7月20日 下午 07:41:58
4 p1 = 0.0048788
4 p2 = 0.2617783
2014年7月20日 下午 07:42:00
2014年7月20日 下午 07:42:00
2014年7月20日 下午 07:42:00
5 p1 = 0.0029838
5 p2 = 0.1629677

'

##------
對比   $inventoryIns='spm'   $inventorydb='sql_inventory'
收集的SQL Instance   儲存的 SQL instance  以及 執行schetask的主機 不同情況
   300ms  ,  100m
##------
#run node as sql2012x and sp2013  same result
$inventoryIns='spm'
$inventorydb='sql_inventory'

$x=1
do
{
    

$t1=get-date;$t1
$sql_insert=@"
insert into statusOSPCRALL (instance_name,counter_name,cntr_value,object_name) select instance_name,counter_name,cntr_value,object_name   
FROM sys.dm_os_performance_counters   
"@

 $t2=get-date;$t2
 Invoke-Sqlcmd -Query $sql_insert -ServerInstance $inventoryIns -Database $inventorydb
 $t3=get-date;$t3

$x.tostring() +' p1 = '+ ($t2-$t1).TotalSeconds
$x.tostring() +' p2 = '+ ($t3-$t2).TotalSeconds

   sleep 2
    $x +=1
}
until ($x -gt 5)  

'
2014年7月20日 下午 07:49:35
2014年7月20日 下午 07:49:35
2014年7月20日 下午 07:49:35
1 p1 = 0.0311812
1 p2 = 0.0907773
2014年7月20日 下午 07:49:37
2014年7月20日 下午 07:49:37
2014年7月20日 下午 07:49:37
2 p1 = 0.0030149
2 p2 = 0.067347
2014年7月20日 下午 07:49:39
2014年7月20日 下午 07:49:39
2014年7月20日 下午 07:49:39
3 p1 = 0.002952
3 p2 = 0.0624364
2014年7月20日 下午 07:49:41
2014年7月20日 下午 07:49:41
2014年7月20日 下午 07:49:41
4 p1 = 0.0059132
4 p2 = 0.0566095
2014年7月20日 下午 07:49:43
2014年7月20日 下午 07:49:43
2014年7月20日 下午 07:49:43
5 p1 = 0.0029101
5 p2 = 0.0704322'




#>}