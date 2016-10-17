﻿<#
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
}
   
$rstring=Get-randomstring  (Get-Random -Minimum 1 -Maximum 254) ;#$rstring
DECLARE @rid int
Set @rid=(select max(rid)+1　as ridadd from t61)

INSERT INTO [dbo].[T61]([rid],[val],[rstring],[createDate],[updateDate],[inserthost],[SPID],[PPID],[SYSTEMUSER])
     VALUES (@rid ,'$val','$rstring',getdate(),$udate,'$ihost',@@SPID,'$ppid',SYSTEM_USER)
GO
"@

if ((get-date) -ge $tstop ){    $x=$tsec }
$i=$i+1
}until ($x -eq $tsec)
#($t2-$t1);$i=$i+1;$i
     VALUES ('$tsec','$i','$ts','$ihost',getdate(),@@SPID,'$ppid',SYSTEM_USER)
GO

$t1f=(Get-date -format  yyyy_MM_dd_HHmm)
$timespan = new-timespan -Minutes $timespanlen
 #$th='14' ;$tm='10'
}
$h2credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd

icm -ComputerName pmd2016 -Credential $h2credential -ScriptBlock $remotecommand 
#  88 C:\PerfLogs\TSQL005
#--------------------------------------------------

select * from T61 order by  createdate desc
select *,totalcount/testsec  as averageSec  from BLTSQL005 order by insertdt desc


--select max(createdate),min(createdate),(max(createdate)-min(createdate))  from T61  where  iid>1873
--order by  createdate desc
