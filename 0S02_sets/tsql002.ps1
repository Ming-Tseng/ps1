<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\tsql002.ps1

C:\PerfLogs\tsql002.ps1


createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com
taskschd.msc 

在特定時間(X :Min)內, random(Y:Sec) 隨機 每次新增 Z 筆 

$rnum=Get-Random -Minimum 1 -Maximum 101
$rnum.GetType()

tsql002.ps1 Count  ServerInstance database table 

tsql002.ps1 100  spm  SQL_Inventory t7 
#>


Param(
  [string] $Minutelength,
  [float]    $SecRandom,
  [int]    $Rowinsert,
  [string] $svrinstance,
  [string] $pdatabase,
  [string] $ptable
)
if ((Get-Module -Name sqlps) -eq $null) {  Import-Module “sqlps” -DisableNameChecking}



$Minutelength='2'
$SecRandom   =2.9
$Rowinsert   ="50"
$svrinstance ="spm"
$pdatabase   ="SQL_Inventory"
$ptable      ="t7"
$t1=get-date;#$t1
$timespan = new-timespan -Minutes $Minutelength
$t2= $t1+ $timespan



$sql_insert="Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <="+$Rowinsert+"
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo."+ $ptable +" values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
end
"


do
{

Invoke-Sqlcmd -ServerInstance $svrinstance -Database $pdatabase -Query $sql_insert -QueryTimeout  7200 |out-null
   if ($t1 -gt $t2)
    {
        break      
    }
    $rnum=Get-Random -Minimum 0.5 -Maximum $SecRandom ;#$rnum
    sleep -Seconds $rnum
    $t1=(get-date); 
    $t1;$t2
    
}
until ($x -gt 0)


#$t2=get-date;$t2


#($t2-$t1).TotalMinutes
#($t2-$t1).TotalSeconds

##truncate  table  dbo.t6 
<#{
timeout 1800 sec = 30 min

$insertcount="100000"  0.1M spend  7.68min =461sec
$insertcount="1000000" 1M   spend  61min  about 300 c/sec

do
{
     $rnum=Get-Random -Minimum 0.5 -Maximum $SecRandom ;$rnum
     sleep $rnum
}
until ($x -gt 0)

}
#>

