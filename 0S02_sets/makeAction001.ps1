<#
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\0S02_sets\makeAction001.ps1

C:\PerfLogs\makeAction001.ps1

createData : Jul.17.2014
 history : 
 author:Ming Tseng a0921887912@gmail.com

taskschd.msc 

make SQL off x , 

#>
Param(
  [string] $gsvNode,
  [string] $gsvname,
  [int] $waitSec
)

#$gsvNode="Sql2012x"
#$gsvname="MSSQLSERVER"
#$waitSec= 60


$sqlservice =gsv -Name $gsvname -ComputerName $gsvNode

$sqlservice.Stop()

sleep -Seconds  $waitSec

$sqlservice.Start()
