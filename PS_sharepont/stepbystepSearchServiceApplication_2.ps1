<#http://blogs.msdn.com/b/russmax/archive/2009/10/20/sharepoint-2010-configuring-search-service-application-using-powershell.aspx

NOTE:  This has been updated as of 2/2/2010!   This has only been tested against SharePoint 2010 "without Fast integrated".  Thanks to Jon Waite for cleaning up some of these steps.
It might be necessary at some point to use PowerShell to provision search service applications.  For Example, setting up a search service application for hosted sites requires you to use PowerShell.  The following steps manually take you through this process and I highly recommend going through the steps to become more familiar with the command-lets.  ​ A sample powershell script is provided at the bottom of this blog. 
#>

##Creating Search Service Application using PowerShell
##0 Get Account
Get-SPProcessAccount 
$databaseServer = $env:COMPUTERNAME
$ServiceAppPool = "SharePoint Services Application PoolM"
$IndexLocation = "C:\SP2013_Search"
$SearchServiceApplicationName = "S2App"
$server = $env:COMPUTERNAME
$DatabaseName = "S2DB" 
. $profile
##############################################
##1. Create Application Pool
##############################################
##Creating a an application pool for your search service application and throwing the object into a variable called $ app:
      $app = new-spserviceapplicationpool –name search-apppool –account CSD\SPSearchSA 

##############################################
##2. Create search service application
##############################################

#$searchapp = new-spenterprisesearchserviceapplication -name MSearchServiceApplication -applicationpool $app
st
$searchApp = New-SPEnterpriseSearchServiceApplication -Name $SearchServiceApplicationName -ApplicationPool $app `
-DatabaseServer $databaseServer -DatabaseName $DatabaseName
tt
##Note: Add the -partitioned switch after -name if the search service application will be consumed in a hosted environment.                        

##############################################
##3. Create search service application proxy
##############################################
st 
$searchApp=Get-SPEnterpriseSearchServiceApplication S2App 
$proxy = new-spenterprisesearchserviceapplicationproxy -name searchserviceapplicationproxy -Uri $searchapp.uri.absoluteURI         
$proxy.status 
tt

##############################################
##4.  Ensure the local search service instance is started
##############################################
(get-spenterprisesearchserviceinstance –local).status

if ((get-spenterprisesearchserviceinstance –local).status -ne "Online"){
Start-SpEnterpriseSearchServiceInstance -identity (get-spenterprisesearchserviceinstance)
}

##############################################
#5.  Provision Search Administration Component
##############################################
#Configure the administration component of the associated Searchserviceapplication.  You can do this with the following command:
set-spenterprisesearchadministrationcomponent –searchapplication $searchapp –searchserviceinstance (get-spenterprisesearchserviceinstance)

##############################################
##6. Provision Crawl Component and Activate
##############################################
#By default, a search application created in PowerShell has a crawl topology but is missing the following:
#· crawl component           
#· query component
#You cannot add a crawl\query component to the default crawl\query topology because it's set as active and the property is read only.  The easiest way around this is creating a new crawl topology and new query topology.  After creating both, they will be set as inactive by default.  This allows for both crawl components to be added to crawl topology and query component to be added to newly created query topology. Finally, you can set this new crawl topology to active. 
st
#a. Create Crawl Topology
$ct = $searchapp | new-spenterprisesearchcrawltopology
Get-SPEnterpriseSearchServiceApplication |Get-SPEnterpriseSearchCrawlTopology 

#b. Create a new Crawl Store
$csid = $SearchApp.CrawlStores | select id
$CrawlStore = $SearchApp.CrawlStores.item($csid.id)
 
#c. Create a new Crawl Component
#Create a crawl component for new crawl topology by passing the variables representing the crawl topology, search instance, and crawlstore.
$hname = hostname
new-spenterprisesearchcrawlcomponent -crawltopology $ct -crawldatabase $Crawlstore -searchserviceinstance $hname
 
#d. Finally, set the new crawl topology as active.
$ct | set-spenterprisesearchcrawltopology -active
tt
############################################## 
##7.  Create Query Components and Activate
##############################################
a. Create a new Query Topology 
$qt = $searchapp | new-spenterprisesearchquerytopology -partitions 1
 
b. Create a variable for the Query Partition
$p1 = ($qt | get-spenterprisesearchindexpartition)
 
c. Create a new Query Component
new-spenterprisesearchquerycomponent -indexpartition $p1 -querytopology $qt -searchserviceinstance (get-spenterprisesearchserviceinstance)
 
d. Create a variable for the Property Store DB
$PSID = $SearchApp.PropertyStores | Select id
$PropDB = $SearchApp.PropertyStores.Item($PSID.id)
 
e. Set the Query Partition to use the Property Store DB
$p1 | set-spenterprisesearchindexpartition -PropertyDatabase $PropDB
 
f.  Activate the Query Topology
$qt | Set-SPEnterpriseSearchQueryTopology -Active

Get-SPEnterpriseSearchServiceApplication
gh Get-SPEnterpriseSearchQueryTopology -full 


==========================================================
Sample Script
Thanks is in store to Colin at MSFT for taking the cmdlets above and throwing together a great sample script.   Copy the script below and save it as a .PS1 file.  
Note:  When provisioning a search service application for hosted “multi-tenant” sites, the following cmd-lets must contain the –partitioned parameter.
		○ New-SPEnterpriseSearchServiceApplication (Step 3 below)
		○ New-SPEnterpriseSearchServiceApplicationProxy (Step 4 below)
	 
Add-PSSnapin Microsoft.SharePoint.PowerShell
# 1.Setting up some initial variables. 
write-host 1.Setting up some initial variables. 
$SSAName = "ContosoSearch" 
$SVCAcct = "Contoso\administrator" 
$SSI = get-spenterprisesearchserviceinstance -local 
$err = $null
# Start Services search services for SSI 
write-host Start Services search services for SSI 
Start-SPEnterpriseSearchServiceInstance -Identity $SSI
# 2.Create an Application Pool. 
write-host 2.Create an Application Pool. 
$AppPool = new-SPServiceApplicationPool -name $SSAName"-AppPool" -account $SVCAcct
# 3.Create the SearchApplication and set it to a variable 
write-host 3.Create the SearchApplication and set it to a variable 
$SearchApp = New-SPEnterpriseSearchServiceApplication -Name $SSAName -applicationpool $AppPool -databasename $SSAName"_AdminDB"
#4 Create search service application proxy 
write-host 4 Create search service application proxy 
$SSAProxy = new-spenterprisesearchserviceapplicationproxy -name $SSAName"ApplicationProxy" -Uri $SearchApp.Uri.AbsoluteURI
# 5.Provision Search Admin Component. 
write-host 5.Provision Search Admin Component. 
set-SPenterprisesearchadministrationcomponent -searchapplication $SearchApp  -searchserviceinstance $SSI
# 6.Create a new Crawl Topology. 
write-host 6.Create a new Crawl Topology. 
$CrawlTopo = $SearchApp | New-SPEnterpriseSearchCrawlTopology
# 7.Create a new Crawl Store. 
write-host 7.Create a new Crawl Store. 
$CrawlStore = $SearchApp | Get-SPEnterpriseSearchCrawlDatabase
# 8.Create a new Crawl Component. 
write-host 8.Create a new Crawl Component. 
New-SPEnterpriseSearchCrawlComponent -CrawlTopology $CrawlTopo -CrawlDatabase $CrawlStore -SearchServiceInstance $SSI
# 9.Activate the Crawl Topology. 
write-host 9.Activate the Crawl Topology. 
do 
{ 
    $err = $null 
    $CrawlTopo | Set-SPEnterpriseSearchCrawlTopology -Active -ErrorVariable err 
    if ($CrawlTopo.State -eq "Active") 
    { 
        $err = $null 
    } 
    Start-Sleep -Seconds 10 
} 
until ($err -eq $null)
# 10.Create a new Query Topology. 
write-host 10.Create a new Query Topology. 
$QueryTopo = $SearchApp | New-SPenterpriseSEarchQueryTopology -partitions 1
# 11.Create a variable for the Query Partition 
write-host 11.Create a variable for the Query Partition 
$Partition1 = ($QueryTopo | Get-SPEnterpriseSearchIndexPartition)
# 12.Create a Query Component. 
write-host 12.Create a Query Component. 
New-SPEnterpriseSearchQueryComponent -indexpartition $Partition1 -QueryTopology $QueryTopo -SearchServiceInstance $SSI
# 13.Create a variable for the Property Store DB. 
write-host 13.Create a variable for the Property Store DB. 
$PropDB = $SearchApp | Get-SPEnterpriseSearchPropertyDatabase
# 14.Set the Query Partition to use the Property Store DB. 
write-host 14.Set the Query Partition to use the Property Store DB. 
$Partition1 | Set-SPEnterpriseSearchIndexPartition -PropertyDatabase $PropDB
# 15.Activate the Query Topology. 
write-host 15.Activate the Query Topology. 
do 
{ 
    $err = $null 
    $QueryTopo | Set-SPEnterpriseSearchQueryTopology -Active -ErrorVariable err -ErrorAction SilentlyContinue 
    Start-Sleep -Seconds 10 
    if ($QueryTopo.State -eq "Active") 
        { 
            $err = $null 
        } 
} 
until ($err -eq $null)
Write-host "Your search application $SSAName is now ready"

gh Get-SPEnterpriseSearchQueryTopology -full