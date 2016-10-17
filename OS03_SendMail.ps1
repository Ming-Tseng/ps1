<## os03_SendMail

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS03_SendMail.ps1
C:\Users\administrator.CSD\SkyDrive\download\PS1\OS03_SendMail.ps1











#>
































#--------------------------------------------
#  1  Send-MailMessage
#-------------------------------------------- 

<#
Send-MailMessage 
[-To] <String[]> 
[-Subject] <String> 
[[-Body] <String> ] 
[[-SmtpServer] <String> ] 
-From <String> 
[-Attachments <String[]> ] 
[-Bcc <String[]> ] 
[-BodyAsHtml] 
[-Cc <String[]> ] 
[-Credential <PSCredential> ]    #Type a user name, such as "User01" or "Domain01\User01". Or, enter a PSCredential object, such as one from the Get-Credential cmdlet.
[-DeliveryNotificationOption <DeliveryNotificationOptions> ] 
[-Encoding <Encoding> ] 
[-Port <Int32> ] 
[-Priority <MailPriority> ] 
[-UseSsl] [ <CommonParameters>]
#>
$d=get-date -Format yy-MM-dd-hh:mm


## sample 1
send-mailmessage -from "User01 <user01@example.com>" -to "User02 <user02@example.com>", "User03 <user03@example.com>" 
-subject "Sending the Attachment" 
-body "Forgot to send the attachment. Sending now." 
-Attachments "data.csv" -priority High -dno onSuccess, onFailure -smtpServer smtp.fabrikam.com

##attachments sample 2
send-mailmessage -from "jgarritsen@cucompanies.com" -to "upfw@sp1.main.lan" -subject "New Files" `
 -Attachments @(Get-ChildItem "E:\Correspondent\UnderwritingSubmissionPKG" | Where {-NOT $_.PSIsContainer}) `
 -priority High -dno onSuccess, onFailure -smtpServer corporate2.main.lan
-Encoding UTF8
([System.Text.Encoding]::ASCII)
([System.Text.Encoding]::UTF8)


##  sample 3
## This command sends an e-mail message from User01 to the ITGroup mailing list with a copy (CC) to User02 and a blind carbon copy (BCC) to the IT manager (ITMgr).
##The command uses the credentials of a domain administrator and the UseSSL parameter.
send-mailmessage -to "User01 <user01@example.com>" -from "ITGroup <itdept@example.com>" 
-cc "User02 <user02@example.com>" -bcc "ITMgr <itmgr@example.com>" 
-subject "Don't forget today's meeting!" -credential domain01\admin01 -useSSL
-body @'


multi-line text



'@

<#
Send-MailMessage  -to "ming_tseng@syscom.com.tw" -Subject "subjectsubject" -body "bodybody" -smtpserver "172.16.200.27" -from "ming_tseng@syscom.com.tw"



C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command  "& { Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject 'Nov.28.2013'`
-body 'uuu   cc   uu' -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw' } "

(get-date).ToString()

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command  `
"& { Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject {$env:computername Sql server stop} -body (get-date).ToString() -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw'} "

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command  "& { Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject {$env:computername Sql server stop} -body vvvv   -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw'} "

#
-command  "& {Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject "$env:computername+'SQL Stop'"  -body (get-date).ToString()  -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw'} "

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command  "& { ping 172.16.220.34 > d:\temp\script31.txt ; ping 172.16.220.33 > d:\temp\script32.txt } "
#>









#--------------------------------------------
# 
#-------------------------------------------- 
Get-Service  | ?{$_.Name  -like '*SQL*'}
cls
net stop mssqlserver
sleep 5
net start mssqlserver
Get-Service  | ?{$_.Name  -like '*SQL*'}


#--------------------------------------------
#  2   150  syscom SMTP info  -smtpserver '172.16.200.27'  + taskschd
#-------------------------------------------- 
Task Scheduler 

<Edit Trigger>
 on an event

 Log: application
 Source:MSSSQLSERVER
 Event ID: 9689

 <Action>

 Action: Start a Program
 Settings
    Program/Script  : powershell
    Add arguments   :-command  "& {Send-MailMessage  -to 'ming_tseng@syscom.com.tw' -Subject "$env:computername+' SQL Stop'"  -body (get-date).ToString()  -smtpserver '172.16.200.27' -from 'ming_tseng@syscom.com.tw'} "

#--------------------------------------------
# 3  powershell run  ps1 file 
#-------------------------------------------- 
powershell.exe  -File C:\Users\administrator.CSD\SkyDrive\download\ps1\TestScript.ps1




#--------------------------------------------
# 4  200 Function SendMail 
#-------------------------------------------- 
# Send- Email Function 
Function SendMail 
{ 
 
   $message = New-Object System.Net.Mail.MailMessage 
   $message.From  = New-Object System.Net.Mail.MailAddress "sourceaddress@mail.com" 
   #$Address1 = New-Object System.Net.Mail.MailAddress "destinationaddress1@mail.com " 
   $Address2 = New-Object System.Net.Mail.MailAddress "destinationaddress2@mail.com" 
   $Address3 = New-Object System.Net.Mail.MailAddress "destinationaddress3@mail.com" 
   $Address4 = New-Object System.Net.Mail.MailAddress "destinationaddress4@mail.com" 
   $Address5 = New-Object System.Net.Mail.MailAddress "destinationaddress5@mail.com" 
 
 
 
   $message.To.Add($Address1) 
   $message.To.Add($Address2)  
   $message.To.Add($Address3) 
   $message.To.Add($Address4) 
   $message.To.Add($Address5) 
 
 
 
   $Address10 = New-Object System.Net.Mail.MailAddress "destinationaddress6@mail.com" 
   $Address11 = New-Object System.Net.Mail.MailAddress "destinationaddress7@mail.com" 
   $message.cc.Add($Address10) 
   $message.cc.Add($Address11) 
 
 
 
  $message.Subject = "Memory usage [" +$computerName + " –" + $Instance+ "]: " +$RAMPercentUsed+ "%" 
   $Body = "Physical Memory: "  +$RAMPercentFree+  "% `r`n`r`nCPU Usage: "  +$CPULoad+  "%"   
 
   $message.Body = $Body 
   $smtp = New-Object System.Net.Mail.SMTPClient –ArgumentList $MailServer 
   try { 
      $smtp.Send($message) 
   } 
   catch { 
     Write-Host "Error sending smtp mail : {0}" -f $Error.ToString() 
   } 
  $message.Dispose() 
} 


#--------------------------------------------
# 4  200 Function SendMail 
#--------------------------------------------