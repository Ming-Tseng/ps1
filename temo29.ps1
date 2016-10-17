172.16.220.161          SPDB
172.16.220.39		sp.csd.syscom
172.16.220.39		sp1.csd.syscom
172.16.220.39		sp2.csd.syscom
172.16.220.40		ss.csd.syscom
172.16.220.29		ss2.csd.syscom
172.16.220.194		spload.csd.syscom


ping spload.csd.syscom
ssms
gsv
Start-Job {
$x=1
do
{
    $p2013bi= Test-Connection 2013Bi
    if ($p2013bi -eq $null)
    {
        get-date
        break
    }
}
until ($x -gt 10)
}
get-job
$y=1
do
{ '$y='+ $y
    
    if ($y -eq 5 )
    {
        get-date
        break
    }
    $Y+=1
}
until ($y -gt 10)
$d=(get-date -Format yy-MM-dd-hh:mm).ToString()
$d=(get-date -Format yy-MM-dd-hh:mm)

Start-Job{ #42  query 2013BI 
$y =1
do{
$gdate=$null
#$gdata=Invoke-Sqlcmd -ServerInstance 2013bi -Database SharePoint_Config_29 -Query 'select numsites from  [dbo].[SiteCounts]';
$gdate=Invoke-Sqlcmd -ServerInstance 2013bi -Database SharePoint_Config_29 -Query 'select getdate() as gdate';
sleep 2
if ($gdate.gdate -eq  $null){  
$d=(get-date -Format 'yyyy-MM-dd hh:mm')
   #$gdate.gdate
   Send-MailMessage  -To a0921887912@gmail.com -from a0921887912@gmail.com `
   -Subject "2013bi  DB out   $d"  `
   -SmtpServer "172.16.200.27"
   break
}   
}
until ($y -gt 10)
} #42

'2013bi  DB out   '+ (get-date -Format yy-MM-dd:hh:mm).ToString()
Get-job |select name , command |fl
Stop-job *
Remove-job *