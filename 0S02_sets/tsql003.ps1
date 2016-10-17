<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql003.ps1

C:\PerfLogs\tsql003.ps1
createData : Aug.07.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com
taskschd.msc 

create database SQL_inventory

select count(*)  into xxx

USE [SQL_inventory]
GO

/****** Object:  Table [dbo].[tablecount]    Script Date: 2014/8/7 下午 04:11:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tablecount](
	[tablename] [nvarchar](255) NULL,
	[countvalue] [int] NULL,
	[updateDate] [datetime] NULL,
	[SQLinstance] [nvarchar](50) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tablecount] ADD  CONSTRAINT [DF_tablecount_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO

select * from spm.SQL_inventory.[dbo].[tablecount]
truncate table SQL_inventory.[dbo].[tablecount]
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
#$svrinstance="TRADEDB114"
#$pdatabase="SQL_inventory"
#$ptable="t6"
$tablelistS='AllowList080_2','custom'
do
{
  foreach ($tablelist in $tablelistS)
{
  $sql_select ="
insert into SQL_inventory.[dbo].[tablecount] select '"+ $tablelist +"' ,count(*),GETDATE(), 'TRADEDB114' from trade.[dbo].["+$tablelist+"]
insert into SQL_inventory.[dbo].[tablecount] select '"+ $tablelist +"' ,count(*),GETDATE(), 'TRADESQLCLUSTER' from TRADESQLCLUSTER.trade.[dbo].["+$tablelist+"]
waitfor delay '0:0:2'
go 5
"  
}  


}
until ($x -gt 0)




$tablelistS='AllowList080_2','custom'

foreach ($tablelist in $tablelistS)
{
  $sql_select ="
insert into SQL_inventory.[dbo].[tablecount] select '"+ $tablelist +"' ,count(*),GETDATE(), 'TRADEDB114' from trade.[dbo].["+$tablelist+"]
insert into SQL_inventory.[dbo].[tablecount] select '"+ $tablelist +"' ,count(*),GETDATE(), 'TRADESQLCLUSTER' from TRADESQLCLUSTER.trade.[dbo].["+$tablelist+"]
waitfor delay '0:0:2'
go 5
"  
}

Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_select -QueryTimeout  7200 |out-null



#Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_insert  |out-null

#$t2=get-date;$t2


#($t2-$t1).TotalMinutes
#($t2-$t1).TotalSeconds

##truncate  table  dbo.t6 
<#{
timeout 1800 sec = 30 min



$insertcount="1000000" 1M   spend  61min  about 300 c/sec
$insertcount="100000"  0.1M spend  7.68min =461sec
$insertcount="10000"        spend   37.8254482
$insertcount="1000"         spend   3.5455648 Second
$insertcount="100"          spend   0.3632593 Second

}
#>