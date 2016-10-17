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
  insert into dbo."+ $ptable +" values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:02'  
end
"

DBCC Log()

Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_insert -QueryTimeout  7200 |out-null
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