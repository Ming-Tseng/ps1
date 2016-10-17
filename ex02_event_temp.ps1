<#
EX02_event_temp

C:\Users\administrator.CSD\SkyDrive\download\ps1\ex02_event_temp.ps1
#>



#write-eventlog -logname zMingeventLog -source zMingSource -eventID 3838 -entrytype Information `
#-message "2   Ming added a user-requested feature to the display." -category 1 -rawdata 10,20


$lastevent=Get-eventlog -ComputerName . -Source zMingSource -logname zMingeventLog  -Newest 1 | ?{$_.EventID -eq 3838}

$bodytext=$lastevent | select message

if (  $lastevent -ne $null ) {

$getdate=get-date -Format 'yyyy-MM-dd  HH:mm'

Send-MailMessage  -to "a0921887912@gmail.com" -Subject "[ $getdate ] event 3838 Trigger.." `
-body $bodytext `
-smtpserver "172.16.200.27" -from "ming_tseng@syscom.com.tw"

}


<#
$getdate=get-date -Format 'yyyy-MM-dd  HH:mm'

Send-MailMessage  -to "a0921887912@gmail.com" -Subject "$getdate  from : sp2013 via 172.16.200.27" `
-body $bodytext `
-smtpserver "172.16.200.27" -from "ming_tseng@syscom.com.tw"
#>