﻿

$x=1
$t1=Get-date
do
{
$x+=1    
$x
foreach ($item in $webp) {
           $item
           
           $webRequest = [net.WebRequest]::Create($item )
           $webrequest.Credentials=new-object System.Net.NetworkCredential ("ming1", "p@ssw0rd", "csd.syscom")
           $webrequest.UseDefaultCredentials = $true
           $webrequest.GetResponse()
         'count ---'+ $x 
       }
until ($x -gt 1000)