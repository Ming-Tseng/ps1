## SharePoint Reference
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") 
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Administration") 
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server.Search.Administration") 
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server.Search") 
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server") 

function global:Get-CrawlHistory($url)
{
 trap [Exception] {
  write-error $("ERROR: " + $_.Exception.GetType().FullName); 
  write-error $("ERROR: " + $_.Exception.Message); 
 
  continue;   
 }
$SPsite = Get-SPsite -Identity $Url
 #$s = new-Object Microsoft.SharePoint.SPSite($url);
 $c = [Microsoft.Office.Server.Search.Administration.SearchContext]::GetContext($SPsite);
 $h = new-Object Microsoft.Office.Server.Search.Administration.CrawlHistory($c);

 Write-OutPut $h.GetCrawlHistory();

 $s.Dispose();
}
#$Url="http://sp.csd.syscom"

Get-CrawlHistory -url $Url  |fl
