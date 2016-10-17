SP01_01_install

#------------------------------------
http://autospinstaller.codeplex.com
#------------------------------------

H:\Microsoft\BI2015_ContentPackDemo\SharePoint Configuration Demo 15.2.6\Demo\SP\AutoSPInstaller\AutoSPInstallerInput.xml

# (0) configuraion xml  C:\Content Packs\Packs\SharePoint Configuration Demo 15.2.6\Demo\SP\AutoSPInstaller\AutoSPInstallerInput.xml
# (1) Region Setup Paths & Environment

$PSConfig="C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\BIN\psconfig.exe"
$PSConfigUI="C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\BIN\psconfigui.exe"
$script:DBPrefix="WIN-2S026UBRQFO_"

#Region External Functions 載入其它 Function
. "C:\Content Packs\Packs\SharePoint Configuration Demo 15.2.6\Demo\SP\AutoSPInstaller\AutoSPInstallerFunctions.ps1"
# 防止主機進行休眠   8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 是Sharepoint GUID 
Start-Process -FilePath "$env:SystemRoot\system32\powercfg.exe" -ArgumentList "/s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" -NoNewWindow




##############################################################################
#######################  PowerPivot Solution Deployment ######################
##############################################################################

# This function is a direct translation of the one used in ASSPIConfigExtension
# The method will be used to wait for the timer job deploying or retracting a solution to finish
# the parameter $deploy is a boll that indicates if this is a deployment or a retraction
Function WaitForSolutionDeployment
{
    param($solutionName, $deploy, $webApplication)
   
    $solution = Get-SPSolution $solutionName -ErrorAction:SilentlyContinue
    
    $count = 0
    while(!$solution -and $count -lt 10)
    {
        "PowerPivot Solution is not added to farm yet. Wait 3 seconds and check again."
        Start-Sleep -s 3
        ($count)++
        $solution = Get-SPSolution $solutionName -ErrorAction:SilentlyContinue
    }
    
    if(!$solution)
    {
        "PowerPivot solution does not exist in the farm"
        return
    }
    
    "Found solution " + $solutionName
    $activeServers = @($solution.Farm.Servers | where {$_.Status -eq "Online"})
    $serversInFarm = $activeServers.Count
    
    ## Wait for the job to start
    if (!$solution.JobExists)
    {
        "Timer job not yet running"
        $count = 0;
        ## We will wait up to 90 seconds per server to start the job
        $cyclesToWait = 30 * $serversInFarm;
        while (!$solution.JobExists -and $count -lt $cyclesToWait)
        {
            Start-Sleep -s 3
            ($count)++;
        }
        
        ## If after that time timer still doesn't exist, verify if it suceeded
        if (!$solution.JobExists)
        {
            if ($deploy -xor $solution.Deployed)
            {
                "Timer job did not start"
                # throw new Exception(Strings.ASSPIGeminiSolutionNoDeployed_Exception);
                return
            }
            else
            {
                "Timer job already finished"
                return
            }
        }
    }
    else
    {
        "Timer job already started"
    }

    if($deploy)
    {
        $deployText = "deployed"
    }
    else
    {
        $deployText = "retracted"
    }
    
    ## If deploy action and solution not deployed yet or retract and solution still deployed
    if (((!$solution.ContainsWebApplicationResource -and 
			($deploy -xor $solution.Deployed)) -or 
		($solution.ContainsWebApplicationResource -and 
			($deploy -xor ($solution.DeployedWebApplications -contains $webApplication)))))
    {
        "Solution not yet " + $deployText
        $count = 0

        ## We will wait up to 10 minutes per server
        $cyclesToWait = 100 * $serversInFarm;
        # We enter this cycle if solution is not yet deployed or retracted
        while (((!$solution.ContainsWebApplicationResource -and 
					($deploy -xor $solution.Deployed)) -or 
				($solution.ContainsWebApplicationResource -and 
					($deploy -xor ($solution.DeployedWebApplications -contains $webApplication)))) -and
				$count -lt $cyclesToWait)
        {
            Start-Sleep -s 3
            ($count)++

            ## Check every 3 minutes to see if job is aborted or failed
            ## Application still not deployed/retracted and job not running mean something is wrong
            ## We can't check geminSolution.JobStatus because it throws in the absence of a job.
            if (($count % 60 -eq 0) -and ($deploy -xor $solution.Deployed) -and !$solution.JobExists)
            {
                "We waited " + $count + " seconds for the solution to be " + $deployText + ". However, the PowerPivot solution is not yet " + $deployText + ". Please check whether SharePoint timer job is enabled. "
                break
            }
        }
    }
    else
    {
        "Solution already " + $deployText
    }

    ## Check if solution wasn't successfully deployed/retracted
    if (((!$solution.ContainsWebApplicationResource -and 
			($deploy -xor $solution.Deployed)) -or 
		($solution.ContainsWebApplicationResource -and 
			($deploy -xor ($solution.DeployedWebApplications -contains $webApplication)))))
    {
        "We waited " + $count + " seconds for the solution to be " + $deployText + ". However, the PowerPivot solution is not yet " + $deployText + ". Please check whether SharePoint timer job is enabled. "
        throw "Solution failed to " + $deployText + ", reason: " + ($solution.LastOperationDetails) + " at: " + ($solution.LastOperationEndTime)
    }

    "PowerPivot solution is successfully " + $deployText
}

Function DeployFarmSolution
{
	param($isSPBeta2)

	# Deploy solutions
	if ($isSPBeta2)
	{
		Install-SPSolution -Identity powerpivotfarmsolution.wsp -AddToLatestVersion -GACDeployment -Force
	}
	else
	{
		Install-SPSolution -Identity powerpivotfarmsolution.wsp –CompatibilityLevel NewVersion -GACDeployment -Force
	}
	WaitForSolutionDeployment powerpivotfarmsolution.wsp $true
    # Add solution in 14 compat mode, wait for timer job to be deleted
    Start-Sleep -s 20
    Install-SPSolution -Identity PowerPivotFarm14Solution.wsp -GACDeployment -Force
	WaitForSolutionDeployment PowerPivotFarm14Solution.wsp $true
}

Function DeployWebAppSolution
{
    param($url, $webAppMaxFileSize, $isSPBeta2)
    # TODO: Validate Url, only valid Url's will be accepted
    # If we deploy ourt solution to a web app we also update the web app max file size
    if(!$webAppMaxFileSize)
    {
        $webAppMaxFileSize = 200
    }

    $targetWebApp = Get-SPWebApplication -Identity $url
    if ($webAppMaxFileSize -gt 0 -and $targetWebApp.MaximumFileSize -lt $webAppMaxFileSize)
    {
        $targetWebApp.MaximumFileSize = $webAppMaxFileSize
        $targetWebApp.Update()
    }

	if ($isSPBeta2)
	{
		Install-SPSolution -Identity powerpivotwebapplicationsolution.wsp -AddToLatestVersion -GACDeployment -Force -WebApplication $targetWebApp -FullTrustBinDeployment
	}
	else
	{
		Install-SPSolution -Identity powerpivotwebapplicationsolution.wsp –CompatibilityLevel NewVersion -GACDeployment -Force -WebApplication $targetWebApp -FullTrustBinDeployment
	}
    WaitForSolutionDeployment powerpivotwebapplicationsolution.wsp $true $targetWebApp
}

Function DeployWebAppSolutionToCentralAdmin
{
    # Deploy to central admin
    param($isSPBeta2)

    $centralAdmin = $(Get-SPWebApplication -IncludeCentralAdministration | Where { $_.IsAdministrationWebApplication -eq $TRUE})

	if ($isSPBeta2)
	{
		Install-SPSolution -Identity powerpivotwebapplicationsolution.wsp -AddToLatestVersion -GACDeployment -Force -WebApplication $centralAdmin -FullTrustBinDeployment
	}
	else
	{
		Install-SPSolution -Identity powerpivotwebapplicationsolution.wsp –CompatibilityLevel NewVersion -GACDeployment -Force -WebApplication $centralAdmin -FullTrustBinDeployment
	}
    WaitForSolutionDeployment powerpivotwebapplicationsolution.wsp $true $centralAdmin
}

Function InstallSiteCollectionFeatures
{
    # Install-SPFeature -path PowerPivotSiteCollection -Force
    # Install-SPFeature -path PowerPivotSiteCollection -CompatibilityLevel 14 -Force

	Install-SPFeature -path PowerPivotSite -Force
    Install-SPFeature -path PowerPivotSite -CompatibilityLevel 14 -Force
}

Function EnableSiteFeatures
{
    param($url, $enablePremiumFeature)
    $premiumFeature = "8581A8A7-CF16-4770-AC54-260265DDB0B2"

    # Enable-SPFeature -Identity "PowerPivotSiteCollection" -URL $url -Force
	Enable-SPFeature -Identity "PowerPivotSite" -URL $url -Force

    if($enablePremiumFeature)
    {
        $site = Get-SPSite $url
        if($site.Features[$premiumFeature] -eq $null)
        {
            Enable-SPFeature -Identity $premiumFeature -URL $url -Force
        }

        $site.Dispose()
    }
}

Function CheckECSUsageTracker
{
	param($ECSServiceApplicationName)

	### Retrieve ECS service application
	$ecsApp = Get-SPExcelServiceApplication | where {$_.DisplayName -eq $ECSServiceApplicationName}
	
	if($ecsApp)
	{
		if ($ecsApp.WorkbookModelUsageTracker -eq "Microsoft.AnalysisServices.SPAddin.Dashboard.WorkbookModelUsageTracker, Microsoft.AnalysisServices.SPAddin, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL")
		{
			  return $true
		}
	}
	return $false
}

Function SetECSUsageTracker
{
	param($ECSServiceApplicationName)

	### Retrieve ECS service application
	$ecsApp = Get-SPExcelServiceApplication | where {$_.DisplayName -eq $ECSServiceApplicationName}
	
	if($ecsApp)
	{
		$ecsApp | Set-SPExcelServiceApplication -WorkbookModelUsageTracker "Microsoft.AnalysisServices.SPAddin.Dashboard.WorkbookModelUsageTracker, Microsoft.AnalysisServices.SPAddin, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL"
	}
	else
	{
		throw "The ECS service application doesn't exist"
	}
}

Function CheckMSOLAP6AsECSTrustedProvider
{
	param($ECSServiceApplicationName)

	### Retrieve ECS service application
	$ecsApp = Get-SPExcelServiceApplication | where {$_.DisplayName -eq $ECSServiceApplicationName}
	
	if($ecsApp)
	{
		$provider = $ecsApp | Get-SPExcelDataProvider | where {$_.ProviderId -eq "MSOLAP.6"}
		#Check if provider exists
		if($provider)
		{
			  return $true
		}
		else
		{
			return $false
		}
	}
	else
	{
		return $false
	}
}

##############################################################################
#####################  Missing SharePoint Configuration ######################
##############################################################################
Function StartService
{
    param($serviceType)
	
	### make sure secure store service is started
	$serviceInstances = Get-SPServiceInstance | where {$_.GetType().FullName -eq $serviceType}
	foreach ( $serviceInstance in $serviceInstances)
	{
		if( $serviceInstance.Status -ne "Online") 
		{
			$serviceInstance | start-spserviceinstance
			"Started service"
		}
		else {"Service Instance is online"}
	} 

	$maxWaitTime = 60 #Time in seconds to wait
	$count = 0
	do
	{
		$online = $true
		$serviceInstances = Get-SPServiceInstance | where {$_.GetType().FullName -eq $serviceType}
		foreach($serviceInstance in $serviceInstances)
		{	
			if($serviceInstance.Status -ne "Online")
			{
				$online = $false
			}
		
			"Status(new): " + ($serviceInstance.Status)
		}
		($count)++	
		Start-Sleep -s 1
	}
	while(!$online -and ($count -lt $maxWaitTime))
	"Waited " + ($count) + " seconds for the service to be provisioned"

	if($serviceInstance.Status -ne "Online")
	{
		throw "Service could not be started"
	}
}

Function AddMSOLAP6AsECSTrustedProvider
{
	param($ECSServiceApplicationName)

	### Retrieve ECS service application
	$ecsApp = Get-SPExcelServiceApplication | where {$_.DisplayName -eq $ECSServiceApplicationName}
	
	if($ecsApp)
	{
		$provider = $ecsApp | Get-SPExcelDataProvider | where {$_.ProviderId -eq "MSOLAP.6"}
		#Check if provider exists
		if(!$provider)
		{
			  $ecsApp | New-SPExcelDataProvider -providerId "MSOLAP.6" -ProviderType oleDb -description "Microsoft OLE DB Provider for OLAP Services 12.0"
		}
	}
	else
	{
		throw "The ECS service application doesn't exist"
	}
}

Function CreateNewFarm
{
    param($dbServer, $configDbName, $adminContentDbName, $farmUser, $farmPassword, $farmPassPhrase, $port)
    # -cmd configdb -create -server '{1}' -database '{2}' " -user '{3}' -password '{4}' -passphrase '{5}' -admincontentdatabase '{6}' " +
    "Creating farm account with use " + $farmUser
    $farmAccount = New-Object System.Management.Automation.PSCredential ($farmUser, $farmPassword)
    "New-SPConfigurationDatabase" 
    New-SPConfigurationDatabase -DatabaseServer $dbServer -DatabaseName $configDbName -AdministrationContentDatabaseName $adminContentDbName -Passphrase $farmPassphrase -FarmCredentials $farmAccount

    # -cmd secureresources 
    "Initialize-SPResourceSecurity"
    Initialize-SPResourceSecurity

    # -cmd services -install 
    "Install-SPService"
    Install-SPService

    # -cmd installfeatures 
    "Install-SPFeature -AllExistingFeatures"
    Install-SPFeature -AllExistingFeatures

    # -cmd adminvs -provision -port {7} -windowsauthprovider onlyusentlm 
    "New-SPCentralAdministration"
    New-SPCentralAdministration -Port $port -WindowsAuthProvider "NTLM"

    # -cmd helpcollections -installall 
    "Install-SPHelpCollection -All"
    Install-SPHelpCollection -All

    # -cmd applicationcontent -install 
    "Install-SPApplicationContent"
    Install-SPApplicationContent
}

Function CreateWebApplication
{
    param($name, $url, $appPool, $appAccount, $appAccountPassword, $dbServer, $dbName)
    $appPoolManagedAccount = Get-SPManagedAccount $appAccount -ErrorAction:SilentlyContinue
    if($appPoolManagedAccount -eq $null)
    {
        $appPoolAccount = New-Object System.Management.Automation.PSCredential ($appAccount, $appAccountPassword)
        $appPoolManagedAccount = New-SPManagedAccount $appPoolAccount
    }

	$ap = New-SPAuthenticationProvider
	New-SPWebApplication -Name $name -ApplicationPool $appPool -ApplicationPoolAccount $appPoolManagedAccount -URL $url -DatabaseServer $dbServer -DatabaseName $dbName -AuthenticationProvider $ap
    iisreset
}

##############################################################################
#######################  Secure Store Configuration ##########################
##############################################################################
Function StartSecureStoreService
{
	### Constants
	$serviceName = "SecureStoreService"
	
	### make sure secure store service is started
	$serviceInstances = get-spserviceinstance | where {$_.Service -match $serviceName}
	foreach ( $serviceInstance in $serviceInstances)
	{
		if( $serviceInstance.Status -ne "Online") 
		{
			$serviceInstance | start-spserviceinstance
			"Started service"
		}
		else {"Service Instance is online"}
	} 

	$maxWaitTime = 60 #Time in seconds to wait
	$count = 0
	do
	{
		$online = $true
		$serviceInstances = get-spserviceinstance | where {$_.Service -match $serviceName}
		foreach($serviceInstance in $serviceInstances)
		{	
			if($serviceInstance.Status -ne "Online")
			{
				$online = $false
			}
		
			"Status(new): " + ($serviceInstance.Status)
		}
		($count)++	
		Start-Sleep -s 1
	}
	while(!$online -and ($count -lt $maxWaitTime))
	"Waited " + ($count) + " seconds for the service to be provisioned"
}

Function CreateSecureStoreApplicationService
{
	param($DbServerAddress, $ServiceApplicationName)
	### Constants
	$serviceName = "SecureStoreService"
	$dbName = $serviceName + "_" + [System.Guid]::NewGuid().ToString("N") 
	
	### Retrieve secure store service application
	$serviceapp = Get-SPServiceApplication | where {$_.DisplayName -eq $ServiceApplicationName}
	
	$pool = Get-SPServiceApplicationPool | where {$_ -match "SharePoint Web Services System"}
	
	### Only create service application if it doesn't exist already
	if(!$serviceapp)
	{
		### Add Secure Store Service Aplication
		New-SPSecureStoreServiceApplication -Name $ServiceApplicationName -partitionmode:$false -sharing:$false -databaseserver $DbServerAddress -databasename $dbName -applicationpool $pool -auditingEnabled:$true -auditlogmaxsize 30
	}
	else { throw "The secure store service application already exists"}
}

Function CreateSecureStoreApplicationServiceProxy
{
	param($serviceApplicationName, $proxyName)
	
	### Retrieve secure store service application proxy
	$proxy = Get-SPServiceApplicationProxy | where {$_.DisplayName -eq $proxyName}
	
	### Only create application proxy if it doesn't exist already
	if(!$proxy)
	{
		### Retrieve secure store service application
		$serviceapp = Get-SPServiceApplication | where {$_.DisplayName -eq $serviceApplicationName}
	
		### Add Secure Store Service Proxy
		$serviceapp | New-SPSecureStoreServiceApplicationProxy -defaultproxygroup:$true -name $proxyName 
	}
	else { throw "The secure store service application proxy already exists"}
}

Function UpdateSecureStoreMasterKey
{
	param($proxyName, $farmPassPhrase)
		
	### Retrieve secure store service application proxy
	$proxy = Get-SPServiceApplicationProxy | where {$_.DisplayName -eq $proxyName}

	if($proxy)
	{
		Update-SPSecureStoreMasterKey -ServiceApplicationProxy $proxy -Passphrase $farmPassPhrase
		start-sleep -s 60
		
		Update-SPSecureStoreApplicationServerKey -ServiceApplicationProxy $proxy -Passphrase $farmPassPhrase
		start-sleep -s 60

        WaitForMasterKeyPropagation
	}
	else
	{
		throw "Secure Store Service Application proxy doesn't exist"
	}
}

Function WaitForMasterKeyPropagation
{
    $old = $ErrorActionPreference
    $ErrorActionPreference = "Stop"
    $successFullAttempts = 0
    $farm = Get-SPFarm

    $maxWaitTime = 600 #Time in seconds to wait
	$count = 0
    while($successFullAttempts -lt 3 -and $count -lt $maxWaitTime)
    {
        try
        {
            CheckSecureStoreStatus
            Start-Sleep -s (2 * $farm.Servers.Count)
            $count += (2 * $farm.Servers.Count)
            ($successFullAttempts)++
        }
        catch
        {
            "Master key not yet propagated"
            "Waited " + ($count) + " seconds for the master key to be ready"
            ($count)++
            Start-Sleep -s 1
        }
    }

    $ErrorActionPreference = $old

    "Waited aproximately " + ($count) + " seconds for the master key to be ready"
    if($notDeployed)
    {
        "Master key failed to propagate"
    }
}

Function CreateSecureStoreApplication
{
	param($individualAppID, $individualFriendlyName, $context)
		
	### Common variables
	
	$pw = new-spsecurestoreapplicationfield -Name "Password" -Type WindowsPassword -Masked:$true
	$un = new-spsecurestoreapplicationfield -Name "User Name" -Type WindowsUserName -Masked:$false
	
	$fields = $un, $pw
	
	### Setup Individual ID
	$pp = get-powerpivotserviceapplication -ServiceContext $context
	if($pp)
	{
        
		$targetApplicationAdministrator = $pp.ApplicationPool.ProcessAccountName
		$userClaims = New-SPClaimsPrincipal -Identity $targetApplicationAdministrator -IdentityType WindowsSamAccountName
		$targetApp = New-SPSecureStoreTargetApplication -Name $individualAppID -FriendlyName $individualFriendlyName -ApplicationType Individual
		$pp | Set-PowerPivotServiceApplication -UnattendedAccount $individualAppId -Confirm:$false
		# Update the service app to use the $individualAppId as
		$sssapp = Get-SPSecureStoreApplication -All -ServiceContext $context | where {$_.TargetApplication.ApplicationId -eq $individualAppID}
        
		### If secure store app doesn't exist then create one
		if(!$sssapp)
		{
			New-SPSecureStoreApplication -TargetApplication $targetApp -ServiceContext $context -Fields $fields -Administrator $userClaims 
			"Secure Store Service Application created"
		}
		else
		{
			### If application already exists update it
			Set-SPSecureStoreApplication -Identity $sssapp -TargetApplication $targetApp -Fields $fields -Administrator $userClaims -Confirm:$false
			"Secure Store Service Application updated"
		}
	}
	else
	{
		throw "Power Pivot Service Application doesn't exist under current context"
	}
}

Function CheckSecureStoreCredentials
{
	param($siteUrl, $individualAppID)
	
	### get context
    $site = Get-SPSite -Identity $siteUrl -ErrorAction:SilentlyContinue
    if($site)
    {
	    $context = $site | Get-SPServiceContext
        $site.Dispose()
    }
    else
    {
        return $false
    }

	if($context)
	{
		$sssapp = Get-SPSecureStoreApplication -All -ServiceContext $context | where {$_.TargetApplication.ApplicationId -eq $individualAppID}
		
		### If secure store app does exist then return true
		if($sssapp)
		{
			return $true
		} 
		else
		{
			return $false
		}
	}
	else
	{
		return $true
	}
}

## Make sure Secure Store is functioning by trying to get SecureStoreApplications
Function CheckSecureStoreStatus
{
	### get context
	$context = Get-SPSite | Get-SPServiceContext
	
	### Try to get secure store application, it will hit exception if master key is not set.
	### $context won't be null if there is a existing spsite.
	### If no spsite available, then we need to skip this test and rely on other checks.
	if($context.Count -gt 0)
	{
		$sssapp = Get-SPSecureStoreApplication -All -ServiceContext $context[0]
	} else 
	{
		if($context)
		{
			$sssapp = Get-SPSecureStoreApplication -All -ServiceContext $context
		}
	}
}

Function CreateUnattendedAccountForDataRefresh
{
	param($siteUrl, $individualAppID, $individualFriendlyName, $unattendedAccountUser,$unattendedAccountPwdSecureString)
		
	### Setup Individual ID
	### get context
	"Obtaining service context for Url: ($siteUrl)"
	$context = Get-SPSite -Identity $siteUrl | Get-SPServiceContext
	if($context)
	{
		"Obtaining PowerPivotServiceApplication associated with current context"
		$pp = get-powerpivotserviceapplication -ServiceContext $context
	}

	if($pp)
	{
		$targetApplicationAdministrator = $pp.ApplicationPool.ProcessAccountName
		"Retrieving PowerPivotServiceApplication application pool process account: ($targetApplicationAdministrator)"
		$targetApplicationAdministratorClaims = New-SPClaimsPrincipal -Identity $targetApplicationAdministrator -IdentityType WindowsSamAccountName
	}
	
	$unattendedAccountUserSecureString = ConvertTo-SecureString $unattendedAccountUser -AsPlainText -Force
	
	if($context -and $targetApplicationAdministratorClaims)
	{
		"Create secure store application"
		WaitForMasterKeyPropagation
		CreateSecureStoreApplication $individualAppID $individualFriendlyName $context
	
		### Get secure store application
		$sssapp = Get-SPSecureStoreApplication -All -ServiceContext $context | where {$_.TargetApplication.ApplicationId -eq $individualAppID}
		
		### Update credentials
		"Update secure store credential mapping"
		WaitForMasterKeyPropagation
		Update-SPSecureStoreCredentialMapping -Principal $targetApplicationAdministratorClaims -identity $sssapp -Values $unattendedAccountUserSecureString,$unattendedAccountPwdSecureString
	}
	else
	{
		throw "Cannot create unattended account for data refresh because there is no enough information to locate current proxy group."
	}
}

Function CheckExcelBIServer
{
	$ecsApps = Get-SPExcelServiceApplication

	foreach ($app in $ecsApps)
	{
		$biServer = Get-SPExcelBIServer -ExcelServiceApplication $app
		if ($biServer)
		{
			return $false;
		}
	}

	return $true;
}

Function AddExcelBIServer
{
	param($EcsServiceApp, $BIServers)

	foreach ($server in $BIServers)
	{
		New-SPExcelBIServer -ServerId $server -ExcelServiceApplication $EcsServiceApp
	}
}
# SIG # Begin signature block
# MIIkDwYJKoZIhvcNAQcCoIIkADCCI/wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCX9c0H8Us3jIwq
# NGgRzWWAz+PeJui/QyAsI9PcgMF1GaCCDZIwggYQMIID+KADAgECAhMzAAAAGne7
# dLMH0Ra4AAAAAAAaMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMTMwOTI0MTc0MTQxWhcNMTQxMjI0MTc0MTQxWjCBgzEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjENMAsGA1UECxMETU9Q
# UjEeMBwGA1UEAxMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMIIBIjANBgkqhkiG9w0B
# AQEFAAOCAQ8AMIIBCgKCAQEA5XwvLQyp7HqoNOBMP39JDg22Fa0ZE95SiiaZFXGp
# YicHN6WDMIJibAuj/QYNFxQG5uCtzJWWCiBaopbh4FcwPF1im8VdiQzQNN/Z2Po1
# 7xEji8D560r0OdovcRDrEbMsN6Nw6IYXPu8qRtCOx7lIAKE38cfI59Iea0oq8sZM
# HXCffMNoQo487YEaUuM+MpQ9fhjxm+RLXBHk1sOFHmwDMHO8yagBfZ2t0fVz8Fsa
# ey8fizK+s461O9n3//NfsxN8E5NXuKBeNZiDoTQ08sUEn7n+RhcMkd/vD1X27Mw5
# yWFloSnuvhE3G7duQlXJzDXRUrMDcJyYNJ4pNqkXGV8LvwIDAQABo4IBfzCCAXsw
# HwYDVR0lBBgwFgYIKwYBBQUHAwMGCisGAQQBgjdMCAEwHQYDVR0OBBYEFCQrPcqQ
# nJ4odXI8zwyzPeasJFZZMFEGA1UdEQRKMEikRjBEMQ0wCwYDVQQLEwRNT1BSMTMw
# MQYDVQQFEyozMTY0MisyODYwYjUyZS1jNGEzLTQ1NGQtYmMxZS0zMmM1YWRkMTdl
# OTAwHwYDVR0jBBgwFoAUSG5k5VAF04KqFzc3IrVtqMp1ApUwVAYDVR0fBE0wSzBJ
# oEegRYZDaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWljQ29k
# U2lnUENBMjAxMV8yMDExLTA3LTA4LmNybDBhBggrBgEFBQcBAQRVMFMwUQYIKwYB
# BQUHMAKGRWh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2VydHMvTWlj
# Q29kU2lnUENBMjAxMV8yMDExLTA3LTA4LmNydDAMBgNVHRMBAf8EAjAAMA0GCSqG
# SIb3DQEBCwUAA4ICAQARcmAL8qwmtgQFZtw4WNfUbNojqmAtQSi4az+Ucv8+YlFl
# WRcxUQs/1AkOODaDKed4mFRtpBbBLkTAyFGgPtJQRYXmwrx5bltbNOEW1DE5xSNZ
# twfnTLGJT4Bix1egSX6ewxjAIkbosG3mIMYpHwiahG3KgA6Dvb0W3n++CPPNgHmR
# 0/jc6ENM9mYCEmr0gI5LBtFtiAxb0YEc7fSyEcWQL1SbjWAHJCGBbTTLkp2OqkAT
# QqwgP+D2EGXAW8qAqNqO74Zal6T1EUuGhW9iq4ouoE8oDRL5xc2RRwMKxDbJY9fd
# 94V6WP1bh+xmwZj8je5YeqKe0R17iUmOHvs+w7KK7sRnSKV1sf3ObKazoOAUV4hv
# fEjxSIxPkh6rbCRkDLqxrojpXY0vPwtRAlxqrKwZTNRMel+5G7VONa5rsb/YWiit
# SMoVU7iLtCyM6sSkE+SXGVEm8SAffqTD467He4n5Y6G2qAZcQt34ZHfvBjGlH+kR
# X8ukoBVonRjxKHt6E65yRiC/In0ITCDSMJYxDZbUJ/RGRWAtkczX8LpUeUZNnjDo
# 2yArMLZyFbFBp5TgopQlB/z4ee0mwvBmPY+D/vrjlEEznXdGvSWsAqSrSOqHbVtA
# vSbv9RgXORz8yd3Z7L7TpAVkgLjXu3q1IcYII3uBspyMPFz7C+JT4sHpug9fUDCC
# B3owggVioAMCAQICCmEOkNIAAAAAAAMwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29m
# dCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eSAyMDExMB4XDTExMDcwODIwNTkw
# OVoXDTI2MDcwODIxMDkwOVowfjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjEoMCYGA1UEAxMfTWljcm9zb2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAx
# MTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKvw+nIQHC6t2G6qghBN
# NLrytlghn0IbKmvpWlCquAY4GgRJun/DDB7dN2vGEtgL8DjCmQawyDnVARQxQtOJ
# DXlkh36UYCRsr55JnOloXtLfm1OyCizDr9mpK656Ca/XllnKYBoF6WZ26DJSJhIv
# 56sIUM+zRLdd2MQuA3WraPPLbfM6XKEW9Ea64DhkrG5kNXimoGMPLdNAk/jj3gcN
# 1Vx5pUkp5w2+oBN3vpQ97/vjK1oQH01WKKJ6cuASOrdJXtjt7UORg9l7snuGG9k+
# sYxd6IlPhBryoS9Z5JA7La4zWMW3Pv4y07MDPbGyr5I4ftKdgCz1TlaRITUlwzlu
# ZH9TupwPrRkjhMv0ugOGjfdf8NBSv4yUh7zAIXQlXxgotswnKDglmDlKNs98sZKu
# HCOnqWbsYR9q4ShJnV+I4iVd0yFLPlLEtVc/JAPw0XpbL9Uj43BdD1FGd7P4AOG8
# rAKCX9vAFbO9G9RVS+c5oQ/pI0m8GLhEfEXkwcNyeuBy5yTfv0aZxe/CHFfbg43s
# TUkwp6uO3+xbn6/83bBm4sGXgXvt1u1L50kppxMopqd9Z4DmimJ4X7IvhNdXnFy/
# dygo8e1twyiPLI9AN0/B4YVEicQJTMXUpUMvdJX3bvh4IFgsE11glZo+TzOE2rCI
# F96eTvSWsLxGoGyY0uDWiIwLAgMBAAGjggHtMIIB6TAQBgkrBgEEAYI3FQEEAwIB
# ADAdBgNVHQ4EFgQUSG5k5VAF04KqFzc3IrVtqMp1ApUwGQYJKwYBBAGCNxQCBAwe
# CgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0j
# BBgwFoAUci06AjGQQ7kUBU7h6qfHMdEjiTQwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0
# cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvTWljUm9vQ2Vy
# QXV0MjAxMV8yMDExXzAzXzIyLmNybDBeBggrBgEFBQcBAQRSMFAwTgYIKwYBBQUH
# MAKGQmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2Vy
# QXV0MjAxMV8yMDExXzAzXzIyLmNydDCBnwYDVR0gBIGXMIGUMIGRBgkrBgEEAYI3
# LgMwgYMwPwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lv
# cHMvZG9jcy9wcmltYXJ5Y3BzLmh0bTBABggrBgEFBQcCAjA0HjIgHQBMAGUAZwBh
# AGwAXwBwAG8AbABpAGMAeQBfAHMAdABhAHQAZQBtAGUAbgB0AC4gHTANBgkqhkiG
# 9w0BAQsFAAOCAgEAZ/KGpZjgVHkaLtPYdGcimwuWEeFjkplCln3SeQyQwWVfLiw+
# +MNy0W2D/r4/6ArKO79HqaPzadtjvyI1pZddZYSQfYtGUFXYDJJ80hpLHPM8QotS
# 0LD9a+M+By4pm+Y9G6XUtR13lDni6WTJRD14eiPzE32mkHSDjfTLJgJGKsKKELuk
# qQUMm+1o+mgulaAqPyprWEljHwlpblqYluSD9MCP80Yr3vw70L01724lruWvJ+3Q
# 3fMOr5kol5hNDj0L8giJ1h/DMhji8MUtzluetEk5CsYKwsatruWy2dsViFFFWDgy
# cScaf7H0J/jeLDogaZiyWYlobm+nt3TDQAUGpgEqKD6CPxNNZgvAs0314Y9/HG8V
# fUWnduVAKmWjw11SYobDHWM2l4bf2vP48hahmifhzaWX0O5dY0HjWwechz4GdwbR
# BrF1HxS+YWG18NzGGwS+30HHDiju3mUv7Jf2oVyW2ADWoUa9WfOXpQlLSBCZgB/Q
# ACnFsZulP0V3HjXG0qKin3p6IvpIlR+r+0cjgPWe+L9rt0uX4ut1eBrs6jeZeRhL
# /9azI2h15q/6/IvrC4DqaTuv/DDtBEyO3991bWORPdGdVk5Pv4BXIqF4ETIheu9B
# CrE/+6jMpF3BoYibV3FWTkhFwELJm3ZbCoBIa/15n8G9bW1qyVJzEw16UM0xghXT
# MIIVzwIBATCBlTB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
# MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MSgwJgYDVQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExAhMzAAAA
# Gne7dLMH0Ra4AAAAAAAaMA0GCWCGSAFlAwQCAQUAoIG+MBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqG
# SIb3DQEJBDEiBCA7jhMEYUZ3D2gfGwDUTPfdLPPRB4bLeVe1GIangOx94TBSBgor
# BgEEAYI3AgEMMUQwQqAggB4AUwBRAEwAIABTAGUAcgB2AGUAcgAgADIAMAAxADSh
# HoAcaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3NxbDANBgkqhkiG9w0BAQEFAASC
# AQBpFlt0QLZTDUjNXALpQHWIDhHgEITQa4+4zCuirxz64RRTR/Ym+0d3zGIacziX
# 4wn28ZgCXrwq1NvSlIeBxA4DqAO8+2LJeIKmvHcNvwXvQHeQyHXoHmFjtWRgY9bH
# kySN9nnehXHlV0aP+ofOELgQ80utAdBiqCj/NFxbOhoaQwVOZV0rv8Hfy77GOFPf
# TiHv9bogKdxuS9AFhQsn8NNrNKXvBntkBYVH+et2OfVq3HOIW1Qa5OJoX6L0sJ9J
# /zk337d+PN3D6AtOVUKjAVeuBj81MEA1APCnD3oQMgZ+YyLpqp0Xk8pRHwgomE00
# GExo7PYH1KpecgbnvRbH5mu5oYITTTCCE0kGCisGAQQBgjcDAwExghM5MIITNQYJ
# KoZIhvcNAQcCoIITJjCCEyICAQMxDzANBglghkgBZQMEAgEFADCCAT0GCyqGSIb3
# DQEJEAEEoIIBLASCASgwggEkAgEBBgorBgEEAYRZCgMBMDEwDQYJYIZIAWUDBAIB
# BQAEILHLtBpxPV56ce47tY/CArW9NSXsbGxjidMSq5NpW5TIAgZS3pby2uAYEzIw
# MTQwMjIxMTMxOTEzLjM1NVowBwIBAYACAfSggbmkgbYwgbMxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xDTALBgNVBAsTBE1PUFIxJzAlBgNVBAsT
# Hm5DaXBoZXIgRFNFIEVTTjpCOEVDLTMwQTQtNzE0NDElMCMGA1UEAxMcTWljcm9z
# b2Z0IFRpbWUtU3RhbXAgU2VydmljZaCCDtAwggZxMIIEWaADAgECAgphCYEqAAAA
# AAACMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBB
# dXRob3JpdHkgMjAxMDAeFw0xMDA3MDEyMTM2NTVaFw0yNTA3MDEyMTQ2NTVaMHwx
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1p
# Y3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMIIBIjANBgkqhkiG9w0BAQEFAAOC
# AQ8AMIIBCgKCAQEAqR0NvHcRijog7PwTl/X6f2mUa3RUENWlCgCChfvtfGhLLF/F
# w+Vhwna3PmYrW/AVUycEMR9BGxqVHc4JE458YTBZsTBED/FgiIRUQwzXTbg4CLNC
# 3ZOs1nMwVyaCo0UN0Or1R4HNvyRgMlhgRvJYR4YyhB50YWeRX4FUsc+TTJLBxKZd
# 0WETbijGGvmGgLvfYfxGwScdJGcSchohiq9LZIlQYrFd/XcfPfBXday9ikJNQFHR
# D5wGPmd/9WbAA5ZEfu/QS/1u5ZrKsajyeioKMfDaTgaRtogINeh4HLDpmc085y9E
# uqf03GS9pAHBIAmTeM38vMDJRF1eFpwBBU8iTQIDAQABo4IB5jCCAeIwEAYJKwYB
# BAGCNxUBBAMCAQAwHQYDVR0OBBYEFNVjOlyKMZDzQ3t8RhvFM2hahW1VMBkGCSsG
# AQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTAD
# AQH/MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0w
# S6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYI
# KwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWlj
# Um9vQ2VyQXV0XzIwMTAtMDYtMjMuY3J0MIGgBgNVHSABAf8EgZUwgZIwgY8GCSsG
# AQQBgjcuAzCBgTA9BggrBgEFBQcCARYxaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L1BLSS9kb2NzL0NQUy9kZWZhdWx0Lmh0bTBABggrBgEFBQcCAjA0HjIgHQBMAGUA
# ZwBhAGwAXwBQAG8AbABpAGMAeQBfAFMAdABhAHQAZQBtAGUAbgB0AC4gHTANBgkq
# hkiG9w0BAQsFAAOCAgEAB+aIUQ3ixuCYP4FxAz2do6Ehb7Prpsz1Mb7PBeKp/vpX
# bRkws8LFZslq3/Xn8Hi9x6ieJeP5vO1rVFcIK1GCRBL7uVOMzPRgEop2zEBAQZvc
# XBf/XPleFzWYJFZLdO9CEMivv3/Gf/I3fVo/HPKZeUqRUgCvOA8X9S95gWXZqbVr
# 5MfO9sp6AG9LMEQkIjzP7QOllo9ZKby2/QThcJ8ySif9Va8v/rbljjO7Yl+a21dA
# 6fHOmWaQjP9qYn/dxUoLkSbiOewZSnFjnXshbcOco6I8+n99lmqQeKZt0uGc+R38
# ONiU9MalCpaGpL2eGq4EQoO4tYCbIjggtSXlZOz39L9+Y1klD3ouOVd2onGqBooP
# iRa6YacRy5rYDkeagMXQzafQ732D8OE7cQnfXXSYIghh2rBQHm+98eEA3+cxB6ST
# OvdlR3jo+KhIq/fecn5ha293qYHLpwmsObvsxsvYgrRyzR30uIUBHoD7G4kqVDmy
# W9rIDVWZeodzOwjmmC3qjeAzLhIp9cAvVCch98isTtoouLGp25ayp0Kiyc8ZQU3g
# hvkqmqMRZjDTu3QyS99je/WZii8bxyGvWbWu3EQ8l1Bx16HSxVXjad5XwdHeMMD9
# zOZN+w2/XU/pnR4ZOC+8z1gFLu8NoFA12u8JJxzVs341Hgi62jbb01+P3nSISRIw
# ggTaMIIDwqADAgECAhMzAAAAKp9LI1/PsPCdAAAAAAAqMA0GCSqGSIb3DQEBCwUA
# MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMT
# HU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTEzMDMyNzIwMTMxNFoX
# DTE0MDYyNzIwMTMxNFowgbMxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xDTALBgNVBAsTBE1PUFIxJzAlBgNVBAsTHm5DaXBoZXIgRFNFIEVTTjpC
# OEVDLTMwQTQtNzE0NDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJWkWWZ2qHIlAdIB
# fg86T1PHeSmGw1r5l8NeG86x6V14jqoHTAf++cV355DAGBRpV1YNJgm7JvG9g9y0
# SMcKpln9xhO+g7LuWZdjQMDv1mg0g6M3ScDXsaV0T7wCYCFUhqSXrWOYICzHPqrX
# QNNhBH3FPV3r5SvwDF+7PGStwes0svDe61wOCEZPr+puYJGGFIzUZeB4M/mf/cdB
# lk7T6yh7O4E15YytLOc0l9LUH9LVu/MNpuTuL6RWpQbh0+EmJTCEukldx85sU+Gj
# 8T1KdxCuB8EaFelVXPBANlqOKE7JEvqNsAwlGS+05BNGA0uDIIlb4r4Dongv+0TW
# /6C/t80CAwEAAaOCARswggEXMB0GA1UdDgQWBBRrmX5GU3jxzASHyk1G4T3iyZz1
# gTAfBgNVHSMEGDAWgBTVYzpcijGQ80N7fEYbxTNoWoVtVTBWBgNVHR8ETzBNMEug
# SaBHhkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9N
# aWNUaW1TdGFQQ0FfMjAxMC0wNy0wMS5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsG
# AQUFBzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Rp
# bVN0YVBDQV8yMDEwLTA3LTAxLmNydDAMBgNVHRMBAf8EAjAAMBMGA1UdJQQMMAoG
# CCsGAQUFBwMIMA0GCSqGSIb3DQEBCwUAA4IBAQAnZLSQsWLvIUIy+rqs9JEFh1i2
# TGGZj/aDhOHmnWlwkR9rtvcFIHNPXhTrfOlxiXLyX4h6exQuLr2QuYy6RuGRKvOa
# 545KnNNxZlkSPJ50f1vvSuZyUoldRHJTznF9S8RCoEqjS+WF6demDfhGwfsz/x+O
# PVxCIfXnE3M4nEiz4ITVnxQ1E5m8k0kIcMW+uh7C+edZgI/aPDz7S+VNvWd5zLyw
# DQnOQAaQgpXt3hHtbZrCBH8NL6KJ5oX4AxzNnxAyhXzMNHyMk62VmOAciHTvQ5Mh
# vs7+BIGcn7aoE1D3dF1QIYfbsMs/DkjbKYWuy9wuZG9iFVWde8bEEhUiV4l6oYID
# eTCCAmECAQEwgeOhgbmkgbYwgbMxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xDTALBgNVBAsTBE1PUFIxJzAlBgNVBAsTHm5DaXBoZXIgRFNFIEVT
# TjpCOEVDLTMwQTQtNzE0NDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# U2VydmljZaIlCgEBMAkGBSsOAwIaBQADFQAkfYJ44IESW3V+5Lg8GfLZezz94qCB
# wjCBv6SBvDCBuTELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEN
# MAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBOVFMgRVNOOkIwMjctQzZG
# OC0xRDg4MSswKQYDVQQDEyJNaWNyb3NvZnQgVGltZSBTb3VyY2UgTWFzdGVyIENs
# b2NrMA0GCSqGSIb3DQEBBQUAAgUA1rEbBDAiGA8yMDE0MDIyMTAwMjMzMloYDzIw
# MTQwMjIyMDAyMzMyWjB3MD0GCisGAQQBhFkKBAExLzAtMAoCBQDWsRsEAgEAMAoC
# AQACAh8AAgH/MAcCAQACAhXyMAoCBQDWsmyEAgEAMDYGCisGAQQBhFkKBAIxKDAm
# MAwGCisGAQQBhFkKAwGgCjAIAgEAAgMW42ChCjAIAgEAAgMHoSAwDQYJKoZIhvcN
# AQEFBQADggEBADB0txe33u39s/EPRxtPm6fuGECvIc4sAzP4gwCwLFUBEQFhFR+l
# ustCSQgiOjxTwk72m0SbIyJZhGHuV4FHJhEc9Zpv64r6eZFg/z3mnwEEOqzqepae
# d3tCNqq0jx2HC5+KtrZMiVS+nRUn2JDYC9rPhh6ga/urw8jeXNUVsGprPkTU0ygz
# tvLjfW0kwkQ7qLPZhQFw8dk+SoapMnhkluP6X4vadhfv5PInOpY/yYQ0kvwwyvWR
# LD3i1MHd99+nJR23kPrhir8zrX+hi/nM81TyMAVgHuIDvP6a32b6eXpcsQbl0oxR
# YJCbMkCP1taYkbjna4Vz/PFFHgOSGO44hq4xggL1MIIC8QIBATCBkzB8MQswCQYD
# VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
# MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAACqfSyNfz7DwnQAAAAAAKjANBglg
# hkgBZQMEAgEFAKCCATIwGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqG
# SIb3DQEJBDEiBCAN2/Azy/OcPxO1sK33pY133taYz2a7HBBtBRFYJl+PlDCB4gYL
# KoZIhvcNAQkQAgwxgdIwgc8wgcwwgbEEFCR9gnjggRJbdX7kuDwZ8tl7PP3iMIGY
# MIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQG
# A1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAAqn0sjX8+w
# 8J0AAAAAACowFgQUJMTSbcB63Z/xIACr23tPl5mQbk0wDQYJKoZIhvcNAQELBQAE
# ggEAPzz0KptYJbTSqMq/xeKLKzpCrH1IjoDyu/hFrll3LwOq1y2jgKGo65LrUSGW
# X+YBb4F9syANnXL9vBCTKL1WqdUZ7GsQJvVYXaQlmNDIuDkJFnygeNXL+u4fmjzH
# n7sTQ7kETt9lul8TVBesI26CXmQ1lC9MWakcljn87DPCowGKnUsSBIwsOj85ywqk
# u9KZR2EO8KmBhumtWRS1U4euP0psQiTxvMefzlfB/RZWgc6Uy7oj33B3b6KnXhkF
# mI9ihak3S5gvoFWTxGImllBoD0FZLSRB5awgjbsirl4tLPmlCwNmzwAUGXzprfHH
# pl+yJe6ecXOSXp67ib2C3e1Qnw==
# SIG # End signature block
