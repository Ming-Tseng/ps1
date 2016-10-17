<#

\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\EX14_TWSELOGPerf.ps1
create : Jan.22.2016
lastwriretime: Jan.25.2016 


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\EX14_TWSELOGPerf.ps1

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

EX14_TWSELOGPerf








#----------------------------------------------------------------
# 18  00  basic info  credential
#----------------------------------------------------------------
$S1Host=
$C1Host=
$S1SQLinstance=
$S1SQLDatabase=
$S1
 
tracet 

telnet SQL2008 1433
telnet SQL2008-F 1433



$secpasswd = ConvertTo-SecureString "p@xxxx" -AsPlainText -Force
$C1credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd



#----------------------------------------------------------------
# 23 01  Install SQL Server PowerShell Module (SQLPS) 
#----------------------------------------------------------------

# download 
https://www.microsoft.com/en-us/download/details.aspx?id=40855

# download 
https://www.microsoft.com/en-us/download/details.aspx?id=29065

# 安裝有順序
All you need to do is to download the following three packages from:
http://www.microsoft.com/en-us/download/details.aspx?id=29065
◾Microsoft® System CLR Types for Microsoft® SQL Server® 2012 (SQLSysClrTypes.msi)
◾Microsoft® SQL Server® 2012 Shared Management Objects (SharedManagementObjects.msi)
◾Microsoft® Windows PowerShell Extensions for Microsoft® SQL Server® 2012 (PowerShellTools.msi)

# 可以 appwiz.cpl 中看到三個安裝,加起來約 3.19M + 28.9M + 1.29M = 31M


#----------------------------------------------------------------
# 40 02  find current counter
#----------------------------------------------------------------
Get-counter -ListSet  *network* | Select-Object -ExpandProperty Paths 
'

'

#--------------------------------------------
# 46 03  Enable-PSRemoting  Port 445, 5985
#--------------------------------------------


Test-WSMan -ComputerName PMD2016
Test-WSMan -ComputerName DGPAP2

Enable-PSRemoting  -Force  # Note: firewall port  5985 
Get-counter  use port
Disable-PSRemoting
<#
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
#>

telnet PMD2016 5985




#---------------------------------------------------------------
#  69  04  local  create schetask.msc
#---------------------------------------------------------------
$hhs='09' ;$hhm='50';    $opt=$hhs+':'+$hhm+':00' 
$script={
$TaskStartTime = $using:opt
$TaskName = 'TSQL005'+'_'+$using:hhs+'_'+$using:hhm

$TaskDescr =  $TaskName +"  test length :"+ $using:ptsec + " sec , run at "+$TaskStartTime 

$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\TSQL005.ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $using:pTServerInstance +" "+ $using:pGServerInstance +" "+ $using:pTdatabase+" "+ $using:pGdatabase+" "+ $using:ptsec$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $using:TaskStartTime -Once

Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rds"  `
-RunLevel Highest -Description $TaskDescr -Force 
}
icm -ComputerName sp2013 -ScriptBlock $script

#---------------------------------------------------------------
#  91 05  remote create schetask.msc
#---------------------------------------------------------------
 scenario005.ps1  $destNode 


 function createTaskschTsql005 ($destNode, [string] $hhs ,[string]$hhm){
#$hhs='09' ;$hhm='50';    

switch ($destNode){
   'PMD2016' {$user='PMOCSD\infra1'  ; $pwd='p@ssw0rd'}
   'sp2013'  {$user='csd\administrator'; $pwd='p@ssw0rds'}
    Default  {$user='csd\administrator'; $pwd='p@ssw0rds'}
    }

$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$h2credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd

$opt=$hhs+':'+$hhm+':00' 
$script={
$TaskStartTime = $using:opt
$TaskName = 'TSQL005'+'_'+$using:hhs+'_'+$using:hhm ;

$TaskDescr =  $TaskName +"  test length :"+ $using:ptsec + " sec , run at "+$TaskStartTime 

$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\TSQL005.ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $using:pTServerInstance +" "+ $using:pGServerInstance +" "+ $using:pTdatabase+" "+ $using:pGdatabase+" "+ $using:ptsec$TaskAction  = New-ScheduledTaskAction  -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once

Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User $using:user -Password $using:pwd  `
-RunLevel Highest -Description $TaskDescr -Force 

}

switch ($destNode){
    'sp2013' {icm -ComputerName sp2013 -ScriptBlock $script}
    'PMD2016' {icm -ComputerName PMD2016 -Credential $h2credential -ScriptBlock $script}
    'SQL2014X' {icm -ComputerName SQL2014X -ScriptBlock $script}
    'PMD' {icm -ComputerName PMD  -Credential h5credential  -ScriptBlock $script}
    Default {icm -ComputerName sp2013 -ScriptBlock $script}}


 }

 createTaskschTsql005 sp2013  12 12

 createTaskschTsql005 SQL2014X  11 12 #ok

 createTaskschTsql005 PMD2016  12 40
 createTaskschTsql005 PMD2016  12 43
 createTaskschTsql005 PMD2016  12 46


#---------------------------------------------------------------
# 147 06  TSQL (PilotTSQL)
#---------------------------------------------------------------
 $tsql_result=@"select ROW_NUMBER()over(order by MSGIDSERIAL) [COUNTER],* from 
        ( SELECT '' as SAMECOUNT , MSGIDSERIAL, MSGID, MARKET, LOGTYPE, CLASS,     RTRIM(NODENAME) AS NODENAME, MSGDATE, MSGTIME, RTRIM(MSGTYPE) AS MSGTYPE
 , SUBSYSTEM, SYSTEM, RTRIM(APNAME) AS APNAME, ERRORCODE, MSGBODY, MSGFORMAT, ERRORCODE2, MSGBODY2, MSGTAIL1, MSGTAIL2, RESERVE1
 , RESERVE2, RESERVE3, LOGID, RECTIME, HANDLE, SYSTYPE, CHECKHANDLE, ERRORTYPE, ERRORLEVEL, NEEDCALLOUT, TANDEMCOUNT, ACCOUNT, HANDLETIME
 , CALLOUTTIME, DEFINEERRORLEVEL, INFOUSER, INFOTIME, JOBNO, JOBNAME, PROCESSNAME, ALERT, ISABEND, NBACTION, INFOHANDLE, INFONO 
 FROM ERRORLOG WHERE MARKET IN (0) AND NODENAME IN ('\TSEK', '\TSEV', '\TSEK2', '\TSEV2', 'I4M', 'CTM', 'NFIX', 'FWDR', 'FDS')
  AND CLASS IN (0,1,2,8) AND ERRORLEVEL IN (0,1,2) AND (MSGTIME>=0) AND MSGIDSERIAL<=32757873 AND isnull(RESERVE3,'') = '' UNION SELECT '' 
  as SAMECOUNT , MSGIDSERIAL, MSGID, MARKET, LOGTYPE, CLASS, RTRIM(NODENAME) AS NODENAME, MSGDATE, MSGTIME, RTRIM(MSGTYPE) 
  AS MSGTYPE, SUBSYSTEM, SYSTEM, RTRIM(APNAME) 
  AS APNAME, ERRORCODE, MSGBODY, MSGFORMAT, ERRORCODE2, MSGBODY2, MSGTAIL1, MSGTAIL2, RESERVE1, RESERVE2, RESERVE3, LOGID, RECTIME, HANDLE, SYSTYPE, CHECKHANDLE, ERRORTYPE, ERRORLEVEL, NEEDCALLOUT, TANDEMCOUNT, ACCOUNT, HANDLETIME, CALLOUTTIME, DEFINEERRORLEVEL, INFOUSER, INFOTIME, JOBNO, JOBNAME, PROCESSNAME, ALERT, ISABEND, NBACTION, INFOHANDLE, INFONO FROM ERRORLOG  WHERE RESERVE3 = '3301690122'  ) AS T order by MSGIDSERIAL
"@$t1=Get-dateInvoke-Sqlcmd -ServerInstance $TServerInstance -Database $Gdatabase `-Query $tsql_result -Username $uname -Password p@yyyy $t2=Get-date; $t2-$t1#---------------------------------------------------------------
# 169 07  
#---------------------------------------------------------------

