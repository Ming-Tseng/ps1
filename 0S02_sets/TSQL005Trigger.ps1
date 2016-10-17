<#
 \\192.168.112.129\c$\PerfLogs\TSQL005Trigger.ps1 # 129=61Node

#>


   

$pTServerInstance='PMD2016' $pGServerInstance='PMD2016'  $pTdatabase      ='SQL_inventory'$pGdatabase      ='SQL_inventory'$ptsec           ='10'

 . C:\PerfLogs\TSQL005.ps1  $pTServerInstance $pGServerInstance $pTdatabase $pGdatabase $ptsec


function waitrun ([string]$th,[string] $tm){
 #$th='14' ;$tm='10'[datetime]$b1 =  $th+':'+$tm+':00'do{   $d=get-date ; start-sleep 1  } until ($d -gt $b1);   
}#-----------------# -----call local #-----------------#1$t1=get-date;$t1waitrun 16 13 ;start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }#2waitrun 16 15 start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }#3waitrun 16 17 start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }#1waitrun 16 19 ;start-process powershell -Verb runas -ArgumentList  { . C:\PerfLogs\TSQL005.ps1 -pTI PMD2016 -pGI PMD2016 -pTd SQL_inventory -pGd SQL_inventory -ptsecond 10 }$t2=get-date; $t2-$t1; $pidii C:\temp\bb.txtget-job