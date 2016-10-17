

<#  SP03_Serviceapplication  C:\Users\administrator.CSD\SkyDrive\download\PS1\SP03_Serviceapplication.ps1 \\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\SP03_Serviceapplication.ps1 auther : ming_tseng    a0921887912@gmail.com createData : Mar.06.2014 history : Sep.04.2014  object :   ref : http://njbblog.blogspot.tw/ $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SP03_Serviceapplication.ps1

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
}#>
#  11  SPServiceApplicationPool  
#  17    Excel Services cmdlets
# 100    service application  cmdlets
# 128    Business Data Catalog Service Application 
# 188    PerformancePoint Service Application
# 244    Secure Store Service Application
# 324    Visio Graphics Service Application

ASNP Microsoft.SharePoint.Powershell  

#------------------------------------
#  11  SPServiceApplicationPool  
#------------------------------------
powershell_ise \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SP01_installconfg.ps1

line   1413   SPServiceApplicationPool
#------------------------------------
#  17  Excel Services cmdlets
#------------------------------------
#{<#
http://njbblog.blogspot.tw/2014/01/sharepoint-2013-how-to-configure-excel.html


Description

This post describes how to configure the SharePoint Server 2013 Excel Service Application using PowerShell.


Solution

1)  Document the Naming Convention
Determine a naming convention for each of the Service Application components.  Document the naming convention.

Application Pool: SvcApp_SPServiceApplicationPool_01
Application Pool Service Account:  Domain\SvcAccount
Application:  SvcApp_SPExcelServiceApplication_01

2)  Prepare the Application Pool / Service Account
Example: Subscription Settings Application Pool: SvcApp_SPServiceApplicationPool_01 Application Pool Service Account:  Domain\SvcAccount

A) If you are using an existing application pool:
You do not need to create a Service Account nor an Application Pool.  Note the names of each.

Verify Application Pool.
Get-SPServiceApplicationPool | Select Name

Get the existing Application Pool.
$SvcAppPool = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_01"

B) If you are creating a new application pool:
Determine which service account you will use to run the application pool that will be assigned to the.  If you need to, create and register a service account to run the Subscription Settings Service Application.

Create the Service Application Pool and register it to the Service Account.
$SvcAppPool = New-SPServiceApplicationPool -Name "SvcApp_SPServiceApplicationPool_01"$AppPool = New-SPServiceApplicationPool -Account (Get-SPManagedAccount Domain\SvcAccount)

Verify Application Pool.
Get-SPServiceApplicationPool | Select Name

Get the existing Application Pool.
$SvcAppPool = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_01"

3)  Open the SharePoint 2013 Management Shell as Administrator.

4)  Create the Service Application and assign it to the Application Pool.
$SvcApp = New-SPExcelServiceApplication –ApplicationPool $SvcAppPool -Name "SvcApp_New-SPExcelServiceApplication_01"

Verify Service Application.
Get-SPServiceApplication | Select Name

Verify Service Application Proxy
Get-SPServiceApplicationProxy | Select Name


Notes
The Proxy is created when the New Service Application cmdlet is run.  It does not appear that the name of the Proxy may be set or changed independently for this Service Application.  


References

Microsoft TechNet (2012).  New-SPExcelServiceApplication.  Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ff607809.aspx.

Microsoft TechNet (2012).  Service application cmdlets in SharePoint 2013.  Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ee906561.aspx.

Microsoft TechNet (2012).  SharePoint 2013 - Service Applications.  Retrieved January 22, 2014 from http://social.technet.microsoft.com/wiki/contents/articles/12512.sharepoint-2013-service-applications.aspx.

#---
#------------------------------------
get-SPServiceApplicationPool
get-SPServiceApplication |ft -AutoSize



#>}
#------------------------------------
#   
#------------------------------------
Install-SPService

get-spservice

#------------------------------------
# 100  service application  cmdlets
#------------------------------------


Service application cmdlets in SharePoint 2013
http://technet.microsoft.com/en-us/library/ee906561(v=office.15).aspx
SharePoint 2013 Other Versions 1 out of 1 rated this helpful - Rate this topic

SPService                                      Install                                # Installs and provisions services on a farm.
SPServiceApplication                           Get ,set ,reomve, Publish/Unpublish    #Returns the specified service application.
SPServiceApplicationEndpoint                   Get ,set                               #Sets the host of an endpoint for a service application.
SPServiceApplicationPool                       Get,Set,New,remove                     #Returns the specified Internet Information Services (IIS) application pool.
SPServiceApplicationProxy                      Get,Remove                      #Returns an instance of the specified service application proxy.
SPServiceApplicationProxyGroup                 Get, New  ,Remove                #Returns the proxy group for the specified service application.
SPServiceApplicationProxyGroupMember           ADD, remove                      #
SPServiceContext                               Get                             #Returns a service context.
SPServiceHostConfig                            Get set                          #Configures one or more common settings for all Web services.
SPServiceInstance                              Get , Start , Stop
SPSiteSubscriptionBusinessDataCatalogConfig    remove                          #Removes the Business Data Connectivity Metadata Store for a partition.
SPSubscriptionSettingsServiceApplication       New                             # Creates a new subscription settings service application. 
SPTopologyServiceApplication                   Get ,set                        #Sets the properties on the topology service application of the local farm.
SPTopologyServiceApplicationProxy              get, set                        #Sets the proxy properties of the topology service application.
SPUsageApplication                             Get, New  set , remove          #Returns a specified usage application.
SPUsageDefinition                              Get, set                        #Sets the retention period for a usage provider.
SPUsageService                                 Get, set                        #Sets the properties of a usage service.


#------------------------------------
#  128   Business Data Catalog Service Application 
#------------------------------------
{
Description

This post describes how to configure the SharePoint Server 2013 Business Data Catalog Service Application using PowerShell.


Solution

1)  Document the Naming Convention
Determine a naming convention for each of the Service Application components.  Document the naming convention.

Application Pool: SvcApp_SPServiceApplicationPool_01
Application Pool Service Account:  Domain\SvcAccount
Application:  SvcApp_SPBusinessDataCatalogServiceApplication_01
Proxy:  SvcApp_SPBusinessDataCatalogServiceApplication_01_Proxy_01  
Database: SvcApp_SPBusinessDataCatalogServiceApplication_01_DB_01

2)  Prepare the Application Pool / Service Account
Example: Subscription Settings Application Pool: SvcApp_SPServiceApplicationPool_01 Application Pool Service Account:  Domain\SvcAccount

A) If you are using an existing application pool:
You do not need to create a Service Account nor an Application Pool.  Note the names of each. 

Verify Application Pool.
Get-SPServiceApplicationPool | Select Name 

Get the existing Application Pool.
$SvcAppPool = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_01"

B) If you are creating a new application pool:
Determine which service account you will use to run the application pool that will be assigned to the.  If you need to, create and register a service account to run the Subscription Settings Service Application.

Create the Service Application Pool and register it to the Service Account.
$SvcAppPool = New-SPServiceApplicationPool -Name "SvcApp_SPServiceApplicationPool_01"$AppPool = New-SPServiceApplicationPool -Account (Get-SPManagedAccount Domain\SvcAccount) 

Verify Application Pool.
Get-SPServiceApplicationPool | Select Name

Get the existing Application Pool.
$SvcAppPool = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_01"

3)  Open the SharePoint 2013 Management Shell as Administrator.

4)  Create the Service Application and assign it to the Application Pool.
$SvcApp = New-SPBusinessDataCatalogServiceApplication –ApplicationPool $SvcAppPool  -Name "SvcApp_ SPBusinessDataCatalogServiceApplication _01" -DatabaseName "SvcApp_ SPBusinessDataCatalogServiceApplication _01_DB_01"

Verify Service Application.
Get-SPServiceApplication | Select Name

5)  Create the Service Application Proxy and assign it to the Service Application. 
$SvcAppProxy = New-SPBusinessDataCatalogServiceApplicationProxy -Name "SvcApp_SPBusinessDataCatalogServiceApplication_01_Proxy_01" -ServiceApplication $SvcApp

Verify Service Application Proxy.
PS C:\ Get-SPServiceApplicationProxy | Select Name

}

#------------------------------------
#  188  PerformancePoint Service Application
#------------------------------------
{Description

This post describes how to configure the SharePoint Server 2013 PerformancePoint Service Application using PowerShell.


Solution

1)  Document the Naming Convention
Determine a naming convention for each of the Service Application components.  Document the naming convention.

Application Pool: SvcApp_SPServiceApplicationPool_01
Application Pool Service Account:  Domain\SvcAccount
Application:  SvcApp_SPPerformancePointServiceApplication_01

2)  Prepare the Application Pool / Service Account
Example: Subscription Settings Application Pool: SvcApp_SPServiceApplicationPool_01 Application Pool Service Account:  Domain\SvcAccount

A) If you are using an existing application pool:
You do not need to create a Service Account nor an Application Pool.  Note the names of each.

Verify Application Pool.
Get-SPServiceApplicationPool | Select Name

Get the existing Application Pool.
$SvcAppPool = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_01"

B) If you are creating a new application pool:
Determine which service account you will use to run the application pool that will be assigned to the.  If you need to, create and register a service account to run the Subscription Settings Service Application.

Create the Service Application Pool and register it to the Service Account.
$SvcAppPool = New-SPServiceApplicationPool -Name "SvcApp_SPServiceApplicationPool_01"$AppPool = New-SPServiceApplicationPool -Account (Get-SPManagedAccount Domain\SvcAccount)

Verify Application Pool.
Get-SPServiceApplicationPool | Select Name

Get the existing Application Pool.
$SvcAppPool = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_01"

3)  Open the SharePoint 2013 Management Shell as Administrator.

4)  Create the Service Application and assign it to the Application Pool.
$SvcApp = New-SPPerformancePointServiceApplication –ApplicationPool $SvcAppPool -Name "SvcApp_SPPerformancePointServiceApplication_01" -DatabaseName "SvcApp_SPPerformancePointServiceApplication_01_DB_01" -DatabaseServer "SQL Alias Name"

Verify Service Application.
Get-SPServiceApplication | Select Name

5)  Create the Service Application Proxy and assign it to the Service Application.
$SvcAppProxy = New-SPPerformancePointServiceApplicationProxy -Name "SvcApp_SPPerformancePointServiceApplication_01_Proxy_01" -ServiceApplication $SvcApp

Verify Service Application Proxy
Get-SPServiceApplicationProxy | Select Name

}
#------------------------------------
# 244   Secure Store Service Application
#------------------------------------
{<#
Description

This post describes how to configure the SharePoint Server 2013 Secure Store Service Application using PowerShell.

Solution

1)  Document the Naming Convention
Determine a naming convention for each of the Secure Store Service Application components.  Document the naming convention.

Example:
Application Pool Service Account:  Domain\SvcAccount (this should already be created) 
Application Pool: SvcApp_SPServiceApplicationPool_02 (this should already be created)
Service Application: SvcApp_SPSecureStoreServiceApplication_01
Database: SvcApp_SPSecureStoreServiceApplication_01_DB_01
Service Application Proxy:  SvcApp_SPSecureStoreServiceApplication_01_Proxy_01
2)  Open the SharePoint 2013 Management Shell as Administrator.
3)  Start the Secure Store Service.
Get-SPServiceInstance | Where {$_.TypeName -like "Secure Store Service"}

Use the Get-SPServiceInstance cmdlet to get the ID Numbers of the SPServiceInstance(s).  Once you have the ID Numbers, use the numbers to start each SPServiceInstance.  Once fully started, the status of each will show as "Online".

Example:
Start-SPServiceInstance 67877d63-bff4-4521-867a-ef4979ba07ce

Start-SPServiceInstance IDNumber1
Start-SPServiceInstance IDNumber2

3)  Verify the Name of the Application Pool.
Get-SPServiceApplicationPool | Select Name

4)  Set the Service Application Pool in a variable.
$SvcAppPool02 = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_02"

5)  Create the Secure Store Service Application.  Specify the Application Pool, the AuditingEnabled setting, the Service Application Name, the Database Name, and the Database Server Name.
$SvcApp = New-SPSecureStoreServiceApplication -ApplicationPool $SvcAppPool –AuditingEnabled:$false -Name "SvcApp_SPSecureStoreServiceApplication_01" -DatabaseName "SvcApp_SPSecureStoreServiceApplication_01_DB_01" -DatabaseServer "SQL Server Alias"
 
6)  Verify the Service Application.
Get-SPServiceApplication | Select Name

7)  Create the Service Application Proxy and assign it to the Service Application.
$SvcAppProxy = New-SPSecureStoreServiceApplicationProxy -Name "SvcApp_SPSecureStoreServiceApplication_01_Proxy_01" -ServiceApplication $SvcApp

8)  Verify Service Application Proxy.
Get-SPServiceApplicationProxy | Select Name


References

Farid, S. (2011).  Configure Secure Store Service using PowerShell.  Retrieved January 22, 2014 from http://samirfarid.wordpress.com/2011/11/28/configure-secure-store-service-using-powershell. 

Microsoft TechNet (2014).  Configure the Secure Store Service in SharePoint 2013.   Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ee806866.aspx.

Microsoft TechNet (2014).  New-SPSecureStoreServiceApplication.  Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ff608083.aspx.

Microsoft TechNet (2014).  New-SPSecureStoreServiceApplicationProxy.  Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ff607856.aspx.

Microsoft TechNet (2014).  Secure Store Service cmdlets in SharePoint 2013.  Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ee906549.aspx.

Microsoft TechNet (2014).  Service application cmdlets in SharePoint 2013.  Retrieved January 22, 2014 from http://technet.microsoft.com/en-us/library/ee906561.aspx.

Microsoft TechNet (2014).  SharePoint 2013 - Service Applications.  Retrieved January 22, 2014 from http://social.technet.microsoft.com/wiki/contents/articles/12512.sharepoint-2013-service-applications.aspx.
Posted by Nicholas Bisciotti at 12:45 PM   
Labels: PowerShell, SharePoint 2013, SharePoint Installation and Configuration




#>}
#------------------------------------
#  324   Visio Graphics Service Application
#------------------------------------
{<#

Description

This post describes how to configure the SharePoint Server 2013 Visio Graphics Service Application using PowerShell.

Solution

1)  Document the Naming Convention

Determine a naming convention for each of the Visio Graphics Service Application components.  Document the naming convention.

Example:
Application Pool Service Account:  Domain\SvcAccount (this should already be created) 
Application Pool: SvcApp_SPServiceApplicationPool_02 (this should already be created)
Service Application: SvcApp_SPVisioServiceApplication_01 
Service Application Proxy:  SvcApp_SPVisioServiceApplication_01_Proxy_01

2)  Open the SharePoint 2013 Management Shell as Administrator.

3)  Verify the Name of the Application Pool.
Get-SPServiceApplicationPool | Select Name

4)  Set the Service Application Pool in a variable.
$SvcAppPool02 = Get-SPServiceApplicationPool "SvcApp_SPServiceApplicationPool_02"

5)  Create the Service Application and assign it to the Application Pool.
$SvcApp = New-SPVisioServiceApplication -ApplicationPool $SvcAppPool02 -Name "SvcApp_SPVisioServiceApplication_01"
 
6)  Verify the Service Application.
Get-SPServiceApplication | Select Name

5)  Create the Service Application Proxy and assign it to the Service Application.
$SvcAppProxy = New-SPVisioServiceApplicationProxy -ServiceApplication SvcApp_SPVisioServiceApplication_01 -Name "SvcApp_SPVisioServiceApplication_01_Proxy_01"

7)  Verify Service Application Proxy.
Get-SPServiceApplicationProxy | Select Name

#>}


#------------------------------------
#  369  
#------------------------------------

Get-SPServiceInstance 
Disabled Managed Metadata Web Service              a183ac38-690f-4213-8c6c-b293fa8356a1
Disabled User Profile Service                      fb3e7674-504a-41f6-9979-51270a624d61


#-----------------------------------
#  379  Metadata  Service
#-----------------------------------

#Get 
Get-SPServiceApplication | ? TypeName -eq 'Managed Metadata Service'
get-SPMetadataServiceApplication -Identity d749517b-6c7d-4be7-88f5-567114c84740 |select *

Get-SPServiceApplicationProxy | Select Name

# create
# 1 servicesInstance 
Get-SPServiceInstance | ?  TypeName -eq 'Managed Metadata Web Service' 

Get-SPServiceInstance | ?  TypeName -eq 'Managed Metadata Web Service'  |Start-SPServiceInstance
# 2 srvapp   http://win-2s026ubrqfo:2013/_admin/ServiceApplications.aspx
New-SPMetadataServiceApplication -Name "MetadataServiceApp1" -ApplicationPool "BIApplicationPool" -DatabaseName "MetadataDB1"
New-SPMetadataServiceApplicationProxy -Name "MetadataServiceProxy1" -ServiceApplication "MetadataServiceApp1"

# 3 remove

$MetadaSrvAppProxy=Get-SPServiceApplicationProxy  | ? TypeName -eq 'Managed Metadata Service 連線'
Remove-SPServiceApplicationProxy $MetadaSrvAppProxy -Confirm:$false 

$MetadaSrvApp=Get-SPServiceApplication | ? TypeName -eq 'Managed Metadata Service'
Remove-SPServiceApplication $MetadaSrvApp -RemoveData -Confirm:$false 





$SSSSPA=Get-SPServiceApplication -Name SvcApp_SPSecureStoreServiceApplication_01
Remove-SPServiceApplication $SSSSPA -RemoveData -Confirm:$false 


#-----------------------------------
#  414  Profile  Service
#-----------------------------------

get-command *spProfile* 
Cmdlet          Add-SPProfileLeader                                ..                                          
Cmdlet          Add-SPProfileSyncConnection                        ..                                          
Cmdlet          Get-SPProfileLeader                                ..                                          
Cmdlet          Get-SPProfileServiceApplicationSecurity            ..                                          
Cmdlet          Move-SPProfileManagedMetadataProperty              .SharePoint.Powershell                                          
Cmdlet          New-SPProfileServiceApplication                    .SharePoint.Powershell                                          
Cmdlet          New-SPProfileServiceApplicationProxy               .SharePoint.Powershell                                          
Cmdlet          Remove-SPProfileLeader                             .SharePoint.Powershell                                          
Cmdlet          Remove-SPProfileSyncConnection                     .SharePoint.Powershell                                          
Cmdlet          Set-SPProfileServiceApplication                    .SharePoint.Powershell                                          
Cmdlet          Set-SPProfileServiceApplicationProxy               .SharePoint.Powershell                                          
Cmdlet          Set-SPProfileServiceApplicationSecurity            .SharePoint.Powershell                                          
Cmdlet          Update-SPProfilePhotoStore                                                                  

Get-SPProfileServiceApplication

# create 
Get-SPServiceInstance | ? {$_.TypeName -eq "User Profile Service"} | Start-SPServiceInstance > $null

$userProfileSAName ='UPA'
$saAppPoolName='BIApplicationPool'
$databaseServerName='WIN-2S026UBRQFO'
$databaseServerName='SPFarmSQL'

$userProfileService = New-SPProfileServiceApplication -Name $userProfileSAName `
-ApplicationPool $saAppPoolName `
-ProfileDBServer $databaseServerName     -ProfileDBName "ProfileDB" `
-SocialDBServer  $databaseServerName     -SocialDBName  "SocialDB" `
-ProfileSyncDBServer $databaseServerName -ProfileSyncDBName "SyncDB"

New-SPProfileServiceApplicationProxy -Name "$userProfileSAName Proxy" `
-ServiceApplication $userProfileService -DefaultProxyGroup


# drop 

$upsSrvAppProxy=Get-SPServiceApplicationProxy  | ? TypeName -eq 'User Profile Service Application Proxy'
Remove-SPServiceApplicationProxy $upsSrvAppProxy -Confirm:$false 


$upsSrvApp=Get-SPServiceApplication | ? displayname -eq 'UPA'
$upsSrvApp=Get-SPServiceApplication | ? displayname -eq 'UserProfileSA'

Remove-SPServiceApplication $upsSrvApp -RemoveData -Confirm:$false 



#-----------------------------------
#  465  mysite  Service
#-----------------------------------