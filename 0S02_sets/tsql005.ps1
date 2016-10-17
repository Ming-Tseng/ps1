<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql005.ps1
C:\Users\administrator.CSD\OneDrive\download\PS1\0S02_sets\tsql005.ps1


C:\PerfLogs\tsql005.ps1

createData : Dec.01.2015
 history : 
 author:Ming Tseng a0921887912@gmail.com
taskschd.msc 

insert 

#>

#--------------------------------------------------
#  
#--------------------------------------------------

CREATE TABLE [dbo].[T61](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [smalldatetime] NULL,
	[insertHost] [nvarchar](128) NULL,
	[SPID] [int] NULL,
	[PPID] [int] NULL,
	[SYSTEMUSER] [nvarchar](255) NULL,
 CONSTRAINT [PK_T61] PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


GO
truncate table T61
select * from T61

CREATE TABLE [dbo].[BLTSQL005](
	[testSec] [int] NULL,
	[totalcount] [int] NULL,
	[totalSession] [int] NULL,
	[inserthost] [nvarchar](128) NULL,
	[insertDT] [datetime] NULL,
	[SPID] [int] NULL,
	[PPID] [int] NULL,
	[SYSTEMUSER] [nvarchar](255) NULL
) ON [PRIMARY]

GO




GO
select *,totalcount/testsec  as averageSec  from BLTSQL005
truncate table BLTSQL005



USE [SQL_inventory]
GO
ALTER ROLE [db_datareader] ADD MEMBER [usql2014x]
GO
USE [SQL_inventory]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [usql2014x]
GO

USE [SQL_inventory]
GO
CREATE USER [upmd2016] FOR LOGIN [upmd2016]
GO
USE [SQL_inventory]
GO
ALTER ROLE [db_datareader] ADD MEMBER [upmd2016]
GO
USE [SQL_inventory]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [upmd2016]
GO


#--------------------------------------------------
#  88 C:\PerfLogs\TSQL005
#--------------------------------------------------

Param(
  [string]$pTServerInstance,
  [string]$pGServerInstance,
  [string]$pTdatabase,
  [string]$pGdatabase,
  [int]   $ptsec
)

function TSQL005 ( $TServerInstance ,$GServerInstance ,$Tdatabase, $Gdatabase ,$tsec ){
 #  TSQL005   PMD2016 PMD2016 SQL_inventory SQL_inventory 20
 #  
 #  select *, totalcount/testsec as [aver/sec] from [BLTSQL005] order by insertdt desc
 #  select max(rid) from t6  ;select * from t61  where rid>1890 order by  rid  desc 


function Get-randomstring ($Length){

$set    = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
$result = ""
for ($x = 0; $x -lt $Length; $x++) {
    $result += $set | Get-Random
    }
return $result  
}#Get-randomstring  38#$Tdatabase='SQL_inventory'  #測試資料庫所在 PMD2016#$Gdatabase='SQL_inventory'  #收集測試資料庫所在 SP2013#$TServerInstance='PMD2016'  #ping $ServerInstance 測試主機#$GServerInstance='PMD2016'  #ping $ServerInstance 收集資料主機#$uname='u'+ $env:COMPUTERNAME   #使用的帳號$uname='sqlsa'   #使用的帳號#$tsec=10 ;$x=0 ;$i=0$t1=get-date$tstop=$t1.AddSeconds($tsec)$ppid=$PIDdo{
   
$rstring=Get-randomstring  (Get-Random -Minimum 1 -Maximum 254) ;#$rstring$val =Get-Random -Minimum 0 -Maximum 100#$udate= get-date -Format  'yyyy-mm-dd hh:mm:ss'$udate=Get-Random -Minimum 42331.63 -Maximum 42391.23$ihost=hostname$tsql_t6Insert=@"
DECLARE @rid int
Set @rid=(select max(rid)+1　as ridadd from t61)

INSERT INTO [dbo].[T61]([rid],[val],[rstring],[createDate],[updateDate],[inserthost],[SPID],[PPID],[SYSTEMUSER])
     VALUES (@rid ,'$val','$rstring',getdate(),$udate,'$ihost',@@SPID,'$ppid',SYSTEM_USER)
GO
"@#$tsql_t6InsertInvoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase -Query $tsql_t6Insert -Username $uname -Password p@ssw0rds |out-null

if ((get-date) -ge $tstop ){    $x=$tsec }
$i=$i+1
}until ($x -eq $tsec)$t2=get-date
#($t2-$t1);$i=$i+1;$i $sql_536=@"select count(session_id) as ts ,@@spid as spid FROM sys.dm_exec_sessions  where  session_id > 50"@$totalSession=Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Tdatabase `-Query $sql_536 -Username sqlsa -Password p@ssw0rds  $ts=$totalSession.ts $tspid=$totalSession.spid $tsql_result=@"INSERT INTO [dbo].[BLTSQL005] ([testSec],[totalcount],[totalSession],[inserthost],[insertDT],[SPID],[PPID],[SYSTEMUSER])
     VALUES ('$tsec','$i','$ts','$ihost',getdate(),@@SPID,'$ppid',SYSTEM_USER)
GO
"@#Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Gdatabase `#-Query $tsql_result -Username $uname -Password p@ssw0rds Invoke-Sqlcmd -ServerInstance $TServerInstance -Database $Gdatabase -Query $tsql_result }  #478  TSQL005     1.0TSQL005   $pTI  $pGI  $pTd  $pGd  $ptsecondTSQL005   SP2013  SP2013  multLogFile  multLogFile  1800#-------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-----\\192.168.112.124\c$\PerfLogs\Sessiontest$x='jmonx'$y='jpax'$icmsb={. C:\PerfLogs\Sessiontest.ps1 $using:x $using:y}icm -ComputerName sql2014x -ScriptBlock $sbicm -ComputerName sql2014x -ScriptBlock $sbicm -ComputerName sql2014x -ScriptBlock $sbPMD2016 PMD2016 SQL_inventory SQL_inventory 10$pTServerInstance='PMD2016' $pGServerInstance='PMD2016'  $pTdatabase      ='SQL_inventory'$pGdatabase      ='SQL_inventory'$ptsec           ='10'$pTServerInstance='SP2013' $pGServerInstance='SP2013'  $pTdatabase      ='multLogFile'$pGdatabase      ='multLogFile'$ptsec           ='10'$icmsb181={. C:\PerfLogs\TSQL005Trigger.ps1 $using:pTServerInstance  `$using:pGServerInstance  $using:pTdatabase $using:pGdatabase $using:ptsec}$t1=get-dateicm -ComputerName sql2014x -ScriptBlock $icmsb181 $t2=get-date$t2-$t1icm -ComputerName sql2014x -ScriptBlock $icmsb181 -AsJobicm -ComputerName sql2014x -ScriptBlock { gps -Name notepad |Stop-Process -Force -Confirm:$false}$t1=get-date;$t1icm -ComputerName sql2014x -ScriptBlock {. C:\PerfLogs\TSQL005 PMD2016 PMD2016 SQL_inventory SQL_inventory 10} -AsJob$t2=get-date; $t2-$t1$t1=get-date;$t1start-sleep 1$t2=get-date; $t2-$t1$t1 =Get-date;#$t1
$t1f=(Get-date -format  yyyy_MM_dd_HHmm)
$timespan = new-timespan -Minutes $timespanlenget-jobGet-Job |Remove-Job * ; Get-Job$t1f=(Get-date -format  yyyy_MM_dd_HHmm)$tm='59'$td='12/22/2012 03:'+$tm+':00' ;$td[datetime]$b1 = '12/22/2012 03:59:00 ' ;$b1function waitrun ([string]$th,[string] $tm){
 #$th='14' ;$tm='10'[datetime]$b1 =  $th+':'+$tm+':00'do{   $d=get-date ; start-sleep 1  } until ($d -gt $b1);   
}waitrun 14 40 ;TSQL005   PMD2016 PMD2016 SQL_inventory SQL_inventory 10icm -ComputerName sql2014x -ScriptBlock {. C:\PerfLogs\TSQL005 PMD2016 PMD2016 SQL_inventory SQL_inventory 10} -AsJobicm -ComputerName sql2014x -ScriptBlock {. C:\PerfLogs\TSQL005 PMD2016 PMD2016 SQL_inventory SQL_inventory 10} -AsJobicm -ComputerName sql2014x -ScriptBlock {. C:\PerfLogs\TSQL005 PMD2016 PMD2016 SQL_inventory SQL_inventory 10} -AsJobicm -ComputerName sql2014x -ScriptBlock {. C:\PerfLogs\TSQL005 PMD2016 PMD2016 SQL_inventory SQL_inventory 10} -AsJobicm -ComputerName sql2014x -ScriptBlock {. C:\PerfLogs\TSQL005 PMD2016 PMD2016 SQL_inventory SQL_inventory 10} -AsJob. C:\PerfLogs\TSQL005.ps1 -TServerInstance "PMD2016" -GServerInstance PMD2016 -Tdatabase SQL_inventory -Gdatabase SQL_inventory -tsec 10 '$pTI  $pGI  $pTd  $pGd  $ptsecond' |out-file C:\temp\aa.txt -Append$t1=get-date;$t1. C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 $t2=get-date; $t2-$t1#-----------------# -----call local #-----------------#1$t1=get-date;$t1waitrun 15 50 ;start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }#2waitrun 15 52 start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }#3waitrun 15 54 start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }#1waitrun 15 56 ;start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }$t2=get-date; $t2-$t1; $pid#-----------------# -----call remote #-----------------$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$h2credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd

icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock $remotecommand $ptsecond=9$remotecommand = {. C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond $using:ptsecond  }icm -ComputerName sql2014x -ScriptBlock $remotecommand  -AsJobicm -ComputerName sql2014x -ScriptBlock $remotecommand  -AsJobicm -ComputerName sql2014x -ScriptBlock $remotecommand  -AsJob$t1=get-dateicm -ComputerName PMD2016 -Credential $h2credential  -ScriptBlock $remotecommand  -AsJob $t2=get-date;($t2-$t1)#--------------------------------------------------
#  88 C:\PerfLogs\TSQL005
#----------------------------------------------------truncate table T61

select * from T61 order by  createdate desc
select *,totalcount/testsec  as averageSec  from BLTSQL005 order by insertdt desc


--select max(createdate),min(createdate),(max(createdate)-min(createdate))  from T61  where  iid>1873
--order by  createdate desc
