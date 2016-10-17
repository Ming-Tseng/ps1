<#
SP25_monitoring
Date : Feb.17.2014

#>

perfmon
#--------------------------------------------
# Get-SPLogEvent 
#--------------------------------------------

http://technet.microsoft.com/en-us/library/ff607589.aspx
C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\LOGS


Get-SPLogEvent 
[-AssignmentCollection <SPAssignmentCollection>] 
[-AsString <SwitchParameter>] 
[-ContextKey <String[]>] 
[-Directory <String>] 
[-MinimumLevel <String>]     
[-StartTime <DateTime>]       2/16/2007 12:15:12
[-EndTime <DateTime>] 

Get-SPLogEvent |select 
Timestamp
,Area      SharePoint Server,SharePoint Foundation
,Category   
,EventID
,Level    Medium,High
,Message

Get-SPLogEvent -MinimumLevel "Warning"
Get-SPLogEvent -Directory "C:\Logs" | Where-Object {$_.Level -eq "Warning"}

Get-SPLogEvent -StartTime "02/16/2014 23:00" -EndTime "02/17/2014 00:00" 

Get-SPLogEvent | ? {$_.Level -eq "Error" -and {$_.Area -eq "SharePoint Foundation "}

Get-SPLogEvent | Where-Object {$_.Level -eq "Information" }
Get-SPLogEvent | Where-Object {$_.Area -eq <Area>}
Get-SPLogEvent | Where-Object {$_.EventID -eq <EventID>}
Get-SPLogEvent | Where-Object {$_.Message -like "<string>"}
Get-SPLogEvent | Where-Object {$_.Process -like "<Process>"}

Get-SPLogEvent|select area |sort area

$x |select area 


#--------------------------------------------
# Get-SPLogEvent 
#--------------------------------------------
Get-SPLogEvent | Out-GridView
Get-SPLogEvent -MinimumLevel "Warning" -StartTime "02/16/2014 23:00" -EndTime "02/17/2014 00:00"  | Out-GridView
Get-SPLogEvent -StartTime "02/17/2014 12:17:00" -EndTime "02/17/2014 16:00"  | Out-GridView

MinimumLevel "Warning"
Get-SPLogLevel