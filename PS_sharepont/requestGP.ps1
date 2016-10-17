$webp="http://sp.csd.syscom/BDR-0/default.aspx","http://sp.csd.syscom/BDR-0/Documents/Forms/AllItems.aspx"`,"http://sp.csd.syscom/Shared%20Documents/Forms/AllItems.aspx"`,"http://sp.csd.syscom/Lists/Calendar/calendar.aspx"`,"http://sp.csd.syscom/winword/Forms/AllItems.aspx"`,"http://sp.csd.syscom/BICenterSite-0/Pages/Default.aspx"`,"http://sp.csd.syscom"

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
       }     }
until ($x -gt 1000)$t2=get-date($t2-$t1).TotalSeconds