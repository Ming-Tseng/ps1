<# Important Note -  be sure to dot-source the .ps1 file to include the function in your current PowerShell Session.  You need to do this before calling the function.  You can do this in your $profile or on an ad-hoc bases as the function is required.   For example, assuming the .ps1 file is stored in c:\powershellscripts 
. c:\powershellscripts\Connect-SPOnline.ps1 
EXAMPLE 1     This example will connect a user to SharePoint Online and will require a user     to provide a password for the credential sent to SharePoint Online. 
        Connect-SPOnline -User "craig@mysponlinesite.com" -Url "https://mysponlinesite-admin.sharepoint.com" EXAMPLE 2 
    This example will connect a user to SharePoint Online and will use a stored password for the credential     sent to SharePoint Online.     If this is the first time you are using the -Use StoredCredentials switch,     you will be prompted to provide a password so it can be saved in the location     defined by the StoredCredentialPath parameter.
   Connect-SPOnline -User "craig@mysponlinesite.com" -Url "https://mysponlinesite-admin.sharepoint.com" -UseStoredCredentials 
EXAMPLE 3     This example uses the PowerShell 3.0 spalatting technique to pass parameters to the function     and will connect a user to SharePoint Online using a stored password for the credential     sent to SharePoint Online.     If this is the first time you are using the -Use StoredCredentials switch,     you will be prompted to provide a password so it can be saved      in the location defined by the StoredCredentialPath parameter. 
 
           $SPOnlineParameters = @{                 User = "craig@mysponlinesite.com"                 Url = "https://mysponlinesite-admin.sharepoint.com" 
                UseStoredCredentials = $true                   }    
            Connect-SPOnline @SPOnlineParameters#>Function Connect-SPOnline {  #P1[CmdletBinding()]param (
        [Parameter(Position=0, Mandatory=$true)]        [string]$User, #= "craiglussier@phoenixlab.onmicrosoft.com",                [Parameter(Position=1, Mandatory=$true)]        [string]$Url, # = "https://phoenixlab-admin.sharepoint.com",                [Parameter(Position=2, Mandatory=$false)]        [switch]$UseStoredCredentials,                [Parameter(Position=3, Mandatory=$false)]        [string]$StoredCredentialPath = (Split-Path $profile) + "\StoredSPOnlineCredentials"  ) Begin { #p.13        Write-Verbose "Entering Begin Block: Connect-SPOnline"        Write-Verbose "Determine PowerShell Host Major Version"        $hostMajorVersion = $Host.Version.Major##------------------

        if ($hostMajorVersion -lt 3){#p.18
 Write-Error "The Connect-SPOnline function requires PowerShell Version 3. You are running PowerShell Version $hostMajorVersion. Exiting function." Exit
}#p.18
        else{#p.18
    Write-Verbose "Current PowerShell Version is $hostMajorVersion"
}#p.18

        Write-Verbose "Determine the 'bitness' of the current PowerShell Process"##------------------        $bitness = $null         if ([Environment]::Is64BitProces){#p.29 
    $bitness = "64" 
}#p.29 
        else{#p.29 
    $bitness = "32"
}#p.29   
        Write-Verbose "The current PowerShell process is $bitness-bit"##------------------
 $ModuleName = "Microsoft.Online.SharePoint.PowerShell" Write-Verbose "Determine if the $ModuleName module is loaded"
        try{ #p.40
            if (-not(Get-Module -name $name)) { #47
                    Write-Verbose "Load the SharePoint Online Module"                    Import-Module -Name $name -DisableNameChecking -ErrorAction Stop                    Write-Verbose "Successfully loaded the SharePoint Online Module"   
            }#47
            else {#47
                    Write-Verbose "The SharePoint Online Module was already loaded in this PowerShell session prior to executing this function."
            }#47
} #p.40
        catch {#p.40
            Write-Error "There was an error while attempting to load the SharePoint Online Module. Exiting function. Please note that the current PowerShell process is $bitness-bit. There are two versions of the SharePoint Online Management Shell which includes the $ModuleName module - a 32-bit version and 64-bit version. Please ensure that you have the correct version installed to run this function within this $bitness-bit PowerShell process. The SharePoint Online Management Shell is available for download at http://www.microsoft.com/en-us/download/details.aspx?id=35588."            Write-Error $_            Exit
         
}#p.40
        Write-Verbose "Leaving Begin Block: Connect-SPOnline"}#p.13
Process { #p.63 Write-Verbose "Entering Process Block: Connect-SPOnline"        if($UseStoredCredentials) { #p.66
Write-Verbose "The stored password for will be used to connect to SharePoint Online for the $User user credential." Write-Verbose "Remove Trailing Directory Slash \ if it exists in the StoredCredentialPath function parameter."$StoredCredentialPath = $StoredCredentialPath.TrimEnd("\")
Write-Verbose "Constructing path to stored credentials for user $User"
$fileName = "$StoredCredentialPath\$User-Connect-SPOnline-Credentials.txt"
             Write-Verbose "Check if stored credentials exist"            if(!(Test-Path $fileName)) {  #76Write-Warning "Stored credentials do not exist for $User - Stored credentials will be created." Write-Warning "You will be prompted for a password. This step will only occur the first time you use this functionality."Write-Verbose "Check to see if the stored credential path exists"
if(!(Test-Path $StoredCredentialPath)) { #p.79    try { #p.83    Write-Verbose "Creating directory to store credentials"    New-Item -Path $StoredCredentialPath -ItemType Directory | Out-Null    } #p.83    catch { #p.83    Write-Error "An error occurred while attemptiong to create the directory $StoredCredentialPath. Exiting function."    Write-Error $_    Exit    } #p.83}      #p.79else { #p.79     Write-Verbose "Stored credential path exists."} #p.79try { #p98Write-Verbose "Prompt for password"$credential = Get-Credential $User               Write-Verbose "Save credentials in $fileName"$credential.Password | ConvertFrom-SecureString | Set-Content $fileName -Force }#p98catch {#p98Write-Error "An error occurred while capturing credentials and saving the credentials in $fileName. Exiting function."Write-Error $_Exit}#p98            } #76            else { #76
 Write-Verbose "Stored Credentials exist"} #76
            
            $password = $null
            try {#117                Write-Verbose "Retrieving stored password from file."                $password = Get-Content $fileName | ConvertTo-SecureString                 Write-Verbose "Successfully retrieved stored password from file."
            }  #117
            catch {#117
                Write-Error "An error occurred while retrieving your stored secure credentials. Exiting function."
                Write-Error $_
                Exit
            }#117
            try {#128
                Write-Verbose "Creating credential object for $User with stored password to send to SharePoint Online"
                #
                #$user="csd\administrator"
               # $password="p@ssw0rd"
                $credential = New-Object System.Management.Automation.PSCredential $User, $password
                Write-Verbose "Connecting to SharePoint Online"
                Connect-SPOService -Url $Url -Credential $credential
                Write-Verbose "Connected to SharePoint Online"
            }#128
            catch {#128
                Write-Error "An error occurred while attempting to connect to SharePoint Online. Exiting function. Your issue is either with your Internet connection, the SharePoint Online Administration site URL you specified is incorrect, the credentials for the SharePoint Online Administration site you specified are incorrect or the SharePoint Online system itself is experiencing a problem. Please read the error message below carefully for clues on how to resolve your issue."
                Write-Error $_
                Exit            }#128
        } #p.66
        else {#p.66
            Write-Verbose "User elected to be prompted for credential password." 
            try {  #142
                Write-Warning "Provide a credential password for $User for site $URL. It is requried to connect to SharePoint Online."
                $credential = Get-Credential $User                 Write-Verbose "Connecting to SharePoint Online"                Connect-SPOService -Url $Url -Credential $credential
                Write-Verbose "Connected to SharePoint Online"
            }#142
            catch {#142
                Write-Error "An error occurred while attempting to connect to SharePoint Online. Exiting function. Your issue is either with your Internet connection, the SharePoint Online Administration site URL you specified is incorrect, the credentials for the SharePoint Online Administration site you specified are incorrect or the SharePoint Online system itself is experiencing a problem. Please read the error message below carefully for clues on how to resolve your issue."
                Write-Error $_
                Exit
            }#142
        }#p.66
        Write-Verbose "Leaving Process Block: Connect-SPOnline"
    }#p.63
}#P1