<#
Ex01_event1135
#>
$sendsrv= $env:COMPUTERNAME
switch($sendsrv)
{
'00DPHCSSL03'  {$sendIP='10.0.21.113'}
'00DPHCSSL04'  {$sendIP='10.0.21.114'}
'01DPHCSSL03'  {$sendIP='10.1.21.103'}
'01DPHCSSL04'  {$sendIP='10.1.21.104'}
}

if (  Get-eventlog -LogName system | ?{$_.EventID -eq 1135} -ne $null ) {
$FailureSrv=((Get-eventlog -LogName system | ?{$_.EventID -eq 1135}).ReplacementStrings).Substring(0,11)

$TimeGenerated=(Get-eventlog -LogName system | ?{$_.EventID -eq 1135}).TimeGenerated
$FailureIP=Test-Connection $FailureSrv   |select  IPV4Address
#Get-eventlog -LogName system | ?{$_.EventID -eq 1135} |select *

Send-MailMessage -from 'SQLPool@mvdis.gov.tw' -to 'a0921887912@gmail.com'  -Cc  'ming_tseng@syscom.com.tw'`
-subject "SQLAssetDB  節點管理員   $FailureSrv ($FailureIP)      : $TimeGenerated   -- 節點通訊中斷   send by  $sendsrv   ($sendIP )  " -SmtpServer '10.0.9.17'
}
