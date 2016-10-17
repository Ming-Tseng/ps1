<#  Sqlps12_Security
 C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps12_Security.ps1
 createData : Mar.17.2014
 LastDate : APR.28.2014  , Mar.23.2015 Author :Ming Tseng  ,a0921887912@gmail.comremark 
 history : 
 object : tsql 
 Audit   auditing

 $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\Sqlps12_Security.ps1

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
}

#>

#01  Listing /set SQL Server service accounts p204
#02  Listing/ Set Authentication Modes        p210
#03  950 Listing failed login attempts        p220
#04  Listing logins, users, and database mappings  p222
#05  Listing login/user roles and permissions p225
#06  300 Creating / set Permission a login using SMO p227
#07  350  creating /assigning permission  a database user p.232
#08  createing a database Role p.237
#09  Fixing orphaned users p241
#10  Creating a credential  p.244
#11  600 Creating a proxy  p246
#12  Creating a database master key p.289
#13  700 Creating a certificate  p.291
#14  750  Creating symmetric and asymmetric keys P293
#15  800  How to link users and logins in an Availability Group  orphaned
#16  866  範例程式碼15-1：建立範例資料庫Northwind_ Audit
#17  866  範例程式碼15-2：在資料庫Northwind_Audit內，建立、修改與刪除資料庫物件
#18  933  範例程式碼15-3：建立登入帳戶wii，並賦予適當的權限
#19  960  範例程式碼15-4：利用登入帳戶wii，對資料表Custoemrs執行查詢與更新等作業
#20  977  範例程式碼15-5：使用sys.dm_server_audit_status動態管理檢視來查看各個「稽核」物件的目前狀態
#21  999  範例程式碼15-6：使用函數fn_get_audit_file分析「稽核」檔案.sql
#22  1060 範例程式碼15-7：建立、啟用與檢視「稽核」物件
#23  1077 範例程式碼15-8：建立與啟用「伺服器稽核規格」物件
#24  1099 範例程式碼15-9：檢視「伺服器稽核規格」物件的相關資料
#25  1111 範例程式碼15-10：檢視可用於設定的稽核動作、稽核動作群組與稽核類型的項目
#26  1150 範例程式碼15-11：建立與啟用「資料庫稽核規格」
#27  1168 範例程式碼15-12：檢視「資料庫稽核規格」物件的目前狀態
#28  1180 範例程式碼15-13：建立登入帳戶ps3，可以連線資料庫Northwind_Audit，並賦予適當的權限
#29  1208 範例程式碼15-14：查詢資料庫Northwind_Audit內的資料表
#30  1233 範例程式碼15-15：建立函數，篩選與分析所需的稽核資料#31  1333 Testing  server   Audit Specification
#32  1400 Testing  Database Audit Specification#33  1470  檢視/create/drop   Audit   20150610
#34  1500  Get audit actions   20150610#35  1800  sp_change_users_login  現有的資料庫使用者對應至 SQL Server 登入  20150720
#36  1800      執行個體之間傳送登入和密碼 sp_help_revlogin   sp_hexadecimal  20150721#37  2001     稽核SQL Server Audit新增強的功能(1) 
#38  2066      實作練習一
#39  2575     實作練習二：認識對稽核記錄檔案的篩選
#40  2778     實作練習三：認識使用者定義稽核群組




























#-------------------------------------------------------------------
# 01 Listing /set SQL Server service accounts p204
#-------------------------------------------------------------------
{<#
##--Get
1. Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
2. Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
3. Add the following script and run:
#replace KERRIGAN with your instance name
$instanceName = "sp2013"
$managedComputer = New-Object 'Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer' $instanceName
#list services
$managedComputer.Services |
Select Name, ServiceAccount, DisplayName, ServiceState |
Format-Table -AutoSize

$managedComputer.Services |select *

##--Set p.206

(2). Import the SQLPS module, and create a new Wmi.ManagedComputer object
as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
$instanceName = "KERRIGAN"
$managedComputer = New-Object -TypeName 'Microsoft.SqlServer.
Management.Smo.Wmi.ManagedComputer' -ArgumentList $instanceName

(3). Add the following script and run:
#get handle to service
#note we are using V3 simplified Where-Object syntax
$servicename = "SQLSERVERAGENT"
$sqlservice = $managedComputer.Services |
Where-Object Name -eq $servicename

#=================================
#Option 1: change account using bare text
#=================================
#might be ok as long as no one is looking over
#your shoulder, especially if you need to
#set password for many servers
$username = "QUERYWORKS\sqlagent01"
$password = "P@ssword"
$sqlservice.SetServiceAccount($username, $password)
#sleep to wait for account change to finish
Start-Sleep -s 1
#display new service account
$sqlservice.ServiceAccount
#=================================
#Option 2: change account using GetNetworkCredentials
#=================================
$username = "QUERYWORKS\sqlagent01"
$credential = Get-Credential -credential $username
#problem here: SetServiceAccount accepts two strings
#Get-Credential provides the password as securestring
#by default if you pass this to SetServiceAccount,
#you will get an error to pass, you need to use $credential.
GetNetworkCredential().password to
#get text equivalent
$sqlservice.SetServiceAccount($credential.UserName, $credential.GetNetworkCredential().Password)
#sleep to wait for account change to finish
Start-Sleep -s 1
#display new service account
$sqlservice.ServiceAccount
(4). Confirm that the service account has changed:
#list services
$managedComputer.Services |
Where Name -eq $servicename |
Select Name, ServiceAccount, DisplayName, ServiceState |
Format-Table -AutoSize
#>}
#-------------------------------------------------------------------
# 02 Listing/ Set Authentication Modes p210
#-------------------------------------------------------------------
{<#
##--Get
2. Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

3. Add the following script and run:
#display login mode
$server.settings.LoginMode

##-- Set
(2). Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
(3). Add the following script and run:
#according to MSDN, there are four (4) possible
#values for LoginMode:
#Normal, Integrated, Mixed and Unknown
#let's change ours to Integrated
$server.settings.LoginMode = [Microsoft.SqlServer.Management.Smo.ServerLoginMode]::Integrated
$server.Alter()
$server.Refresh()
#display login mode
$server.settings.LoginMode

#
Normal: SQL Authentication only
Integrated: Windows Authentication only
Mixed: SQL and Windows Authentication
Unknown: Unknown

#>}
#---------------------------------------------------------------
# 03   Listing failed login attempts  p220
#---------------------------------------------------------------
{<#

(2). Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3). Add the following script and run:
#According to MSDN:
#ReadErrorLog returns A StringCollection system object
#value that contains an enumerated list of errors
#from the SQL Server error log.
$server.ReadErrorLog() |Where-Object ProcessInfo -Like "*Logon*" |Where-Object Text -Like "*Login failed*" |Format-List

$server |select * 
#>}
#---------------------------------------------------------------
# 04  Listing logins, users, and database mappings  p222
#---------------------------------------------------------------
#{<#
#TSQL
USE master
GO
-- 查詢執行個體內SQL Server驗證的登入帳戶
SELECT name N'主體的名稱', principal_id N'主體的識別碼'
, sid N'主體的 SID (安全性識別碼)', type_desc N'主體類型的描述',
	is_disabled N'是否已被停用', create_date N'建立的日期時間'
	, modify_date N'修改的日期時間'
FROM sys.server_principals
WHERE type='S'

select * 
FROM sys.server_principals
WHERE type='S'

#PS1


(2)Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "sp2013"
$instanceName = "sql2012x"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3). Add the following script and run it:
#display login info
#these are two different ways of displaying login info
$server.Logins

$server.EnumWindowsUserInfo()
#List users, and database mappings
$server.Databases |
ForEach-Object {
#capture database object
$database = $_
#capture users in this database
$users = $_.Users
$users |
Where-Object { -not($_.IsSystemObject)} |
Select @{N="Login";E={$_.Login}},
@{N="User";E={$_.Name}},
@{N="DatabaseName";E={$database.Name}},
@{N="LoginType";E={$_.LoginType}},
@{N="UserType";E={$_.UserType}}
} |
Format-Table -AutoSize

#{<#  20140323 lab

$server.Databases |
ForEach-Object {
$database = $_
$users = $_.Users
$users 
}

$s4db=$server.Databases  | ? name -eq  backrest4 | select *
$s4db.users |select name 

$s4db.users|
Where-Object { -not ($_.IsSystemObject)} |
Select @{N="Login";E={$_.Login}},
@{N="User";E={$_.Name}},
@{N="DatabaseName";E={$database.Name}},
@{N="LoginType";E={$_.LoginType}},
@{N="UserType";E={$_.UserType}} |Format-Table -AutoSize

#>}


#---------------------------------------------------------------
# 05  Listing login/user roles and permissions p225
#---------------------------------------------------------------

(2). Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3). Add the following script and run it:

$server.Databases |
ForEach-Object {
#capture database object
$database = $_
#capture users in this database
$users = $_.Users
$users |
Where-Object { -not($_.IsSystemObject)} |
Select @{N="Login";E={$_.Login}},
@{N="User";E={$_.Name}},
@{N="DatabaseName";E={$database.name}},
@{N="DBRoles";E={$_.EnumRoles()}},
@{N="ObjectPermissions";E={$database.EnumObjectPermissions($_.Name)}}
} |
Format-Table -AutoSize

function listLoginUserRolesPermission ($instanceName){
#  $instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

$server.Databases |
ForEach-Object {
$database = $_
$users = $_.Users
$users |
Where-Object { -not($_.IsSystemObject)} |
Select @{N="Login";E={$_.Login}},
@{N="User";E={$_.Name}},
@{N="DatabaseName";E={$database.name}},
@{N="DBRoles";E={$_.EnumRoles()}},
@{N="ObjectPermissions";E={$database.EnumObjectPermissions($_.Name)}}
} |
Format-Table -AutoSize
}

A|out-file ri c:\temp\temp.txt

#
function listDBUser ($instanceName, $dbname)
{
#$instanceName = "sp2013"
  $server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
  $dbs=$server.Databases | ? name -EQ $dbname
foreach ($db in $dbs)
{
'      '
'---------'+$db.name
    $users=$db.users
    foreach ($user in $users)
    {
       $user.Name +"       " + $user.Login + "        "+$user.EnumRoles() 
    }

}  
}
listDBUser sp2013 AdventureWorks2014
listDBUser sp2013 backrest3
listDBUser sp2013 backrest4

#---------------------------------------------------------------
# 06 300 Creating / set Permission a login using SMO p227
#---------------------------------------------------------------
#{<#

##----- create 
##TSQL
CREATE LOGIN [eric]
WITH PASSWORD=N'YourSuperStrongPassword',
CHECK_EXPIRATION=OFF
GO


##ps

(2). Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3) Add the following script and run it:
$loginName = "eric"
# drop login if it exists
if ($server.Logins.Contains($loginName))
{
$server.Logins[$loginName].Drop()
}
$login = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login -ArgumentList $server, $loginName
$login.LoginType = [Microsoft.SqlServer.Management.Smo.LoginType]::SqlLogin
$login.PasswordExpirationEnabled = $false
# prompt for password
$pw = Read-Host "PW" –AsSecureString
$login.Create($pw)

##-- set
##TSQL
ALTER SERVER ROLE [dbcreator]
ADD MEMBER [eric]
GO
ALTER SERVER ROLE [setupadmin]
ADD MEMBER [eric]
GO
GRANT
ALTER ANY DATABASE,
ALTER SETTINGS
TO [eric]

##PS

(2). Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName

(3). Add the following script and run it:
#assumption is this login already exists
$loginName = "eric"
#assign server level roles
$login = $server.Logins[$loginName]
$login.AddToRole("dbcreator")
$login.AddToRole("setupadmin")
$login.Alter()
#grant server level permissions
$permissionset = New-Object Microsoft.SqlServer.Management.Smo.
ServerPermissionSet([Microsoft.SqlServer.Management.Smo.ServerPerm
ission]::AlterAnyDatabase)
$permissionset.Add([Microsoft.SqlServer.Management.Smo.ServerPermi
ssion]::AlterSettings)
$server.Grant($permissionset, $loginName)
#confirm server roles
$login.ListMembers()
#confirm permissions
$server.EnumServerPermissions($loginName) |
Select Grantee, PermissionType, PermissionState |
Format-Table -AutoSize

#>}

#-------------------------------------------------------------------
#07 350  creating /assigning permission  a database user p.232
#-------------------------------------------------------------------

##-- New
##TSQL
USE [AdventureWorks2008R2]
GO
CREATE USER [eric]
FOR LOGIN [eric]

##PS
(2). Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
(3). Add the following script and run it:
$loginName = "sqlsa"
#get login
$login = $server.Logins[$loginName]
#add a database mapping
$databasename = "AdventureWorks2014"
$database = $server.Databases[$databasename]
if($database.Users[$dbUserName])
{
$database.Users[$dbUserName].Drop()
}
$dbUserName = "eric"
$dbuser = New-Object `
-TypeName Microsoft.SqlServer.Management.Smo.User `
-ArgumentList $database, $dbUserName
$dbuser.Login = $loginName
$dbuser.Create()
(4). To confirm that the user has been created:
1. Open SQL Server Management Studio.
2. Expand Security and expand Logins.
3. Double-click the login called eric.
4. Highlight User Mapping from the left-hand pane. You should see that eric has been mapped to the AdventureWorks2008R2 database:

##-- set P.234

##TSQL
USE [AdventureWorks2008R2]
GO
GRANT
ALTER,
CREATE TABLE
TO [eric]

##PS
(2). Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
(3). Add the following script and run it:
$databasename = "AdventureWorks2008R2"
$database = $server.Databases[$databasename]
#get a handle to the database user we want
#to assign permissions to
$dbusername = "eric"
$dbuser = $database.Users[$dbusername]
#assign database permissions
$permissionset = New-Object Microsoft.SqlServer.Management.
Smo.DatabasePermissionSet([Microsoft.SqlServer.Management.Smo.DatabasePermission]::Alter)
$permissionset.Add([Microsoft.SqlServer.Management.Smo.DatabasePermission]::CreateTable)
#grant the permissions
$database.Grant($permissionset, $dbuser.Name)
#confirm permissions
$database.Users |
ForEach-Object {
$database.EnumDatabasePermissions($_.Name) |
Select PermissionState, PermissionType, Grantee
} |
Format-Table -AutoSize


#-------------------------------------------------------------------
#08 createing a database Role p.237
#-------------------------------------------------------------------

##TSQL
USE AdventureWorks2008R2
GO
CREATE ROLE [Custom Role]
GO
GRANT SELECT
ON SCHEMA::[HumanResources]
TO [Custom Role]
GRANT ALTER, CREATE TABLE
TO [Custom Role]


##PS
(2)2. Import the SQLPS module and create a new SMO Server object:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3)Add the following script and run it:
$databasename = "AdventureWorks2014"
$database = $server.Databases[$databasename]
#role
$rolename = "Custom Role"
if($database.Roles[$rolename])
{
$database.Roles[$rolename].Drop()
}
#let's assume this custom role, we want to grant
#everyone in this role select, insert access
#to the HumanResources Schema, in addition to the
#CreateTable permission
$dbrole = New-Object Microsoft.SqlServer.Management.Smo.DatabaseRole -ArgumentList $database, $rolename
$dbrole.Create()
#verify; list database roles
$database.Roles
#create a permission set to contain SELECT permissions
#for the HumanResources schema
$permissionset1 = New-Object Microsoft.SqlServer.Management.
Smo.ObjectPermissionSet([Microsoft.SqlServer.Management.Smo.ObjectPermission]::Select)
$permissionset1.Add([Microsoft.SqlServer.Management.Smo.ObjectPermission]::Select)
$hrschema = $database.Schemas["HumanResources"]
$hrschema.Grant($permissionset1, $dbrole.Name)
#create another permission set that contains
#CREATE TABLE and ALTER on this database
$permissionset2 = New-Object Microsoft.SqlServer.Management.Smo.
DatabasePermissionSet([Microsoft.SqlServer.Management.Smo.DatabasePermission]::CreateTable)
$permissionset2.Add([Microsoft.SqlServer.Management.Smo.DatabasePermission]::Alter)
$database.Grant($permissionset2, $dbrole.Name)
#to add member
#assume eric is already a user in the database
$username = "eric"
$dbrole.AddMember($username)
#confirm permissions
$database.Roles[$rolename] |
ForEach-Object {
$currentrole = $_
$database.EnumDatabasePermissions($_.Name) |
Select PermissionState, PermissionType, Grantee,
@{N="Members";E={$currentrole.EnumMembers()}}
} |
Format-Table -AutoSize


#-------------------------------------------------------------------
#09   Fixing orphaned users p241
#-------------------------------------------------------------------

## TSQL
USE [master]
GO
CREATE LOGIN [marymargaret]
WITH PASSWORD=N'P@ssword',
DEFAULT_DATABASE=[master],
CHECK_EXPIRATION=OFF,
CHECK_POLICY=OFF
GO
USE [AdventureWorks2008R2]
GO
CREATE USER [marymargaret]
FOR LOGIN [marymargaret]
GO
USE [master]
GO
DROP LOGIN [marymargaret]
GO
-- create another login, this will generate a
-- different SID
CREATE LOGIN [marymargaret]
WITH PASSWORD=N'P@ssword',
DEFAULT_DATABASE=[master],
CHECK_EXPIRATION=OFF,
CHECK_POLICY=OFF

##PS
2. Import the SQLPS module and create a new SMO Server object:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
3. Add the following script and run it:
$databasename = "AdventureWorks2008R2"
$database = $server.Databases[$databasename]
$loginname = "marymargaret"
$username = "marymargaret"
$user = $database.Users[$username]
#display current status
$user | Select Parent, Name, Login, LoginType, UserType


## there's more


Following the patterns of the previous recipes, you may have thought that we should be able
to use SMO to fix our orphaned user. This snippet of code should allow us to remap the user:
#unfortunately this doesn't work
$user.Login = "marymargaret"
$user.Alter()
$user.Refresh()
#-------------------------------------------------------------------
#10 Creating a credential  p.244
#-------------------------------------------------------------------
##TSQL


CREATE CREDENTIAL [filemanagercred]
WITH IDENTITY = N'QUERYWORKS\filemanager',
SECRET = N'YourSuperStrongPassword'


##PS
(2). Import the SQLPS module and create a new SMO Server object:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
(3). Add the following script and run it:
$identity = "QUERYWORKS\filemanager"
$credentialname = "filemanagercred"
if($server.Credentials.Contains($credentialname))
{$server.Credentials[$credentialname].Drop()
}
$credential=New-Object "Microsoft.SqlServer.Management.Smo.
Credential" $server, $credentialname
$credential.Create($identity, "YourSuperStrongPassword")
#list credentials
$server.Credentials


#-------------------------------------------------------------------
#11 600 Creating a proxy  p246
#-------------------------------------------------------------------
## TSQL
EXEC msdb.dbo.sp_add_proxy
@proxy_name = N'filemanagerproxy',
@credential_name = N'filemanagercred',
@enabled = 1,
@description = N'Proxy Account for PowerShell Agent Job steps'
EXEC msdb.dbo.sp_grant_login_to_proxy
@proxy_name = N'filemanagerproxy',
@login_name = N'QUERYWORKS\sqlagent'
-- PowerShell subsystem
EXEC msdb.dbo.sp_grant_proxy_to_subsystem
@proxy_name = N'filemanagerproxy',
@subsystem_id = 12
-- CmdExec subsystem
EXEC msdb.dbo.sp_grant_proxy_to_subsystem
@proxy_name = N'filemanagerproxy',
@subsystem_id = 12


##PS
2. Import the SQLPS module and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
3. Add the following script and run it:
$proxyname = "filemanagerproxy"
$credentialname = "filemanagercred"
$jobserver = $server.JobServer
if($jobserver.ProxyAccounts[$proxyname])
{
$jobserver.ProxyAccounts[$proxyname].Drop()
}
$proxy=New-Object "Microsoft.SqlServer.Management.Smo.Agent.
ProxyAccount" $jobserver, $proxyname, $credentialname, $true,
"Proxy Account for PowerShell Agent Job steps"
$proxy.Create()
#add sql server agent account - QUERYWORKS\sqlagent
$agentlogin = "QUERYWORKS\sqlagent"
$proxy.AddLogin($agentlogin)
$proxy.AddSubSystem([Microsoft.SqlServer.Management.Smo.Agent.AgentSubsystem]::PowerShell)
$proxy.AddSubSystem([Microsoft.SqlServer.Management.Smo.Agent.AgentSubsystem]::CmdExec)

#confirm, list proxy accounts
$jobserver.ProxyAccounts |
ForEach-Object {
$currproxy = $_
$subsytems = ($currproxy.EnumSubSystems() |
Select -ExpandProperty Name) -Join ","
$currproxy |
Select Name, CredentialName, CredentialIdentity,
@{N="Subsystems";E={$subsytems}}
} |
Format-Table -AutoSize


#-------------------------------------------------------------------
#12 Creating a database master key p.289
#-------------------------------------------------------------------
##T-SQL equivalent of what we are trying to accomplish is:
USE master
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD = 'P@ssword'
##PS

(2)Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
(3). Add the following script and run:
$VerbosePreference = "Continue"
$masterdb = $server.Databases["master"]
if($masterdb.MasterKey -eq $null)
{
$masterkey = New-Object Microsoft.SqlServer.Management.Smo.
MasterKey -ArgumentList $masterdb
$masterkey.Create("P@ssword")
Write-Verbose "Master Key Created : $($masterkey.CreateDate)"
}
$VerbosePreference = "SilentlyContinue"

#-------------------------------------------------------------------
#13  700 Creating a certificate  p.291
#-------------------------------------------------------------------
##TSQL
CREATE CERTIFICATE [Test Certificate]
WITH SUBJECT = N'This is a test certificate.',
START_DATE = N'02/10/2012',
EXPIRY_DATE = N'01/01/2015'

##PS
(2). Import the SQLPS module, and create a new SMO Server object:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
(3). Add the following script and run:
$certificateName = "Test Certificate"
$masterdb = $server.Databases["master"]
if ($masterdb.Certificates[$certificateName])
{
$masterdb.Certificates[$certificateName].Drop()
}
$certificate = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Certificate -ArgumentList $masterdb,$certificateName
#set properties
$certificate.StartDate = "February 10, 2012"
$certificate.Subject = "This is a test certificate."
$certificate.ExpirationDate = "January 01, 2015"
#create certificate
#you can optionally provide a password, but this
#certificate we created is protected by the master key
$certificate.Create()
#display all properties
$certificate | Select *


(5)confirm this via T-SQL, we can use the sys.certificates DMV to list all
certificates. Open SQL Server Management Studio, and execute the following
T-SQL statement:

SELECT *
FROM sys.certificates
WHERE [name] = 'Test Certificate'


#-------------------------------------------------------------------
#14 750  Creating symmetric and asymmetric keys P293
#-------------------------------------------------------------------
##Getting Ready
'In this recipe, we will use the TestDB database. If you don't already have this database,
log in the SQL Server Management Studio and execute the following T-SQL code:
'
IF DB_ID( TestDB') IS NULL
CREATE DATABASE TestDB
GO

Use TestDB
GO
CREATE USER [eric]
FOR LOGIN [eric]



##PS
(2)Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

(3)Add the following script and run:
#database handle
$databasename = "TestDB"
$database = $server.Databases[$databasename]

#----------------------------------------------
# 15   800  How to link users and logins in an Availability Group  orphaned
#----------------------------------------------

'You could also leverage contained databases here and have the database principal authenticate at the database level. 
That way you would not have to worry about orphaned users.
'
http://dba.stackexchange.com/questions/30036/how-to-link-users-and-logins-in-an-availability-group?answertab=votes#tab-top

#####  STEP 0  先確定Primary 在那一個Node
select primary_replica from sys.dm_hadr_availability_group_states


#####  STEP 1  Primary  @ N1  
connect TradeDB (118)
USE [master]
GO
CREATE LOGIN [eaieu] WITH PASSWORD=N'12345', DEFAULT_DATABASE=[Trade], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Trade]
GO
CREATE USER [eaieu] FOR LOGIN [eaieu]
GO

#檢查  118 , 117 login all ,   但是113 無法登入
學-check AGname, N1 Login pass , N2 failure


#####  STEP  2  Primary 轉至 192.22.168.113   change  Primary  to N2
##此步驟可由UI執行
connect 113

USE master
GO
ALTER AVAILABILITY GROUP [TradedbAG] FAILOVER;
GO
#確定Primary 在那一個Node -- select primary_replica from sys.dm_hadr_availability_group_states


#####  STEP3  找出被遺棄使用者 SID
connect 113

use Trade
exec sp_change_users_login 'report';
go

#複製  copy SID  ;  like   0xFAC5E9312A6A1645B4A3F24A3CC77B16

# 刪除原有的登入者  drop login eaieu

create login eaieu
with
    password = '12345',
    check_policy = off,
	DEFAULT_DATABASE=[Trade],     
	CHECK_EXPIRATION=OFF,
    sid = 0xFAC5E9312A6A1645B4A3F24A3CC77B16; --copy SID to here
go


#檢查  118 , 117 , 113 login all pass ,   
#-check AGname, N1  N2  all pass


#####  STEP4  change  Primary  to N1
connect N1

USE master
GO
ALTER AVAILABILITY GROUP [SPMAG] FAILOVER;
GO
select primary_replica from sys.dm_hadr_availability_group_states

check AGname, N1 Login  , N2  all pass



#-------------------------------------------------------------------
#   16  866  範例程式碼15-1：建立範例資料庫 Northwind_ Audit
#-------------------------------------------------------------------
USE master
GO
-- 備份資料庫Northwind，並搭配利用「備份壓縮(Backup Compression)」
BACKUP DATABASE [Northwind] 
TO  DISK = N'C:\myAdmin\Device\nw_Audit.bak' WITH FORMAT, 
	NAME = N'Northwind-完整 資料庫 備份', STATS = 10, COMPRESSION
GO

-- 復原資料庫為：Northwind_ Audit
RESTORE DATABASE [Northwind_Audit] 
FROM  DISK = N'C:\myAdmin\Device\nw_Audit.bak' 
WITH  FILE = 1,  
	MOVE N'Northwind' TO N'C:\myAdmin\DB\Northwind_Audit.mdf',  
	MOVE N'Northwind_log' TO N'C:\myAdmin\DB\Northwind_Audit_1.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO

#-------------------------------------------------------------------
#  17  866 範例程式碼15-2：在資料庫Northwind_Audit內，建立、修改與刪除資料庫物件
#-------------------------------------------------------------------
{<#
USE Northwind_Audit
GO

-------------------------------------------------------------------------------------------
--建立資料庫物件
-------------------------------------------------------------------------------------------
CREATE TABLE NewTable (Field1 int not null primary key)
GO
CREATE VIEW NewView AS SELECT * FROM NewTable
GO
CREATE SYNONYM NewSynonym FOR NewTable
GO
CREATE FUNCTION NewFunction (@InParm INT) RETURNS INT AS BEGIN RETURN @InParm END
GO
CREATE PROCEDURE NewProcedure (@InParm INT) AS BEGIN Set @InParm = 0 END
GO
CREATE TRIGGER NewTrigger ON NewTable AFTER INSERT AS RAISERROR ('This is a dummy table', 16, 10);
GO
-------------------------------------------------------------------------------------------
--修改先前所建立的部分資料庫物件
-------------------------------------------------------------------------------------------
ALTER TABLE NewTable ADD Cdata varchar(20)
GO
ALTER PROC NewProcedure AS SELECT GETDATE()
GO

-------------------------------------------------------------------------------------------
--刪除先前所建立的資料庫物件
-------------------------------------------------------------------------------------------
DROP TRIGGER NewTrigger
GO
DROP PROCEDURE NewProcedure
GO
DROP FUNCTION NewFunction
GO
DROP SYNONYM NewSynonym
GO
DROP VIEW NewView
GO
DROP TABLE NewTable
GO
#>}
#-------------------------------------------------------------------
#  18  933  範例程式碼15-3：建立登入帳戶wii，並賦予適當的權限
#-------------------------------------------------------------------
{<#
USE master
GO

-- 建立登入帳戶wii，密碼是P@ssw0rd
CREATE LOGIN wii 
	WITH PASSWORD=N'P@ssw0rd', 
	DEFAULT_DATABASE=Northwind_Audit, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

-- 允許能夠存取資料庫 Northwind_Audit
USE Northwind_Audit
GO
CREATE USER wii FOR LOGIN wii
GO

--資料表：Customers ，假設包含了重要敏感的資訊，例如：Password、SSN、Phone等等
SELECT * FROM dbo.Customers
GO

--賦予使用者 wii，具備對資料表：Customers、Orders，適當的權限：SELECT
GRANT SELECT ON dbo.Customers TO wii
GRANT SELECT ON dbo.Orders TO wii
GO
#>}
#-------------------------------------------------------------------
#   19 960  範例程式碼15-4：利用登入帳戶wii，對資料表Custoemrs執行查詢與更新等作業
#-------------------------------------------------------------------
{<#
--00 以使用者wii身分執行以下的陳述式。連線到資料庫Northwind_Audit
USE Northwind_Audit
GO

--01 查詢資料表Customers，可以被「稽核」所記錄
SELECT * FROM dbo.Customers

--02 查詢資料表Orders，「稽核」並未設計要記錄此物件
SELECT * FROM dbo.Orders

--03 查詢資料表Customers，可以被「稽核」所記錄
SELECT * FROM dbo.Customers

--04 更新資料表Customers，雖然使用者wii沒有具備更新的權限，但仍將被「稽核」所記錄
UPDATE dbo.Customers
SET CompanyName='Audit'
WHERE CustomerID='ALFKI'
/*
訊息 229，層級 14，狀態 5，行 2
結構描述 'dbo'，資料庫 'Northwind_Audit'，物件 'Customers' 沒有 UPDATE 權限。
*/

--05 查詢資料表Customers，並且加入條件式篩選當CustomerID='ALFKI'的資料列，可以被「稽核」所記錄
SELECT * FROM dbo.Customers
WHERE CustomerID='ALFKI'

--06 執行內部連結(inner join)，查詢資料表Customers與Orders，可以被「稽核」所記錄
SELECT OrderID,city
FROM Customers INNER JOIN dbo.Orders
	ON Customers.CustomerID=Orders.CustomerID

--07 有趣的現象：搭配使用 TOP 關鍵字
SELECT TOP 1 * FROM dbo.Customers
WHERE CustomerID='ALFKI'
#>}
#-------------------------------------------------------------------
# 20  977 範例程式碼15-5：使用sys.dm_server_audit_status動態管理檢視來查看各個「稽核」物件的目前狀態
#-------------------------------------------------------------------
{<#
--01 檢視「稽核」SQL Server Audit的狀態
/*
sys.dm_server_audit_status (Transact-SQL) 
為每一個伺服器稽核各傳回一個資料列，指示此稽核的目前狀態。
*/
USE master
GO
--
SELECT audit_id N'稽核的識別碼', name N'稽核的名稱', status_desc N'伺服器稽核狀態', 
	status_time N'上一次狀態變更的時間戳記', audit_file_size N'稽核檔案大小(KB)', 
	audit_file_path N'稽核檔案目標的完整路徑名稱'
FROM sys.dm_server_audit_status;
#>}
#-------------------------------------------------------------------
#   21  999  範例程式碼15-6：使用函數fn_get_audit_file分析「稽核」檔案.sql
#-------------------------------------------------------------------
{<#
--EX1 分析與篩選「稽核」檔案內的資料：檢視指定的稽核檔案
/*
fn_get_audit_file (Transact-SQL) 
從伺服器稽核建立的稽核檔案中傳回資訊。

語法：
fn_get_audit_file ( file_pattern, {default | initial_file_name | NULL }, {default | audit_file_offset | NULL } )

第一個引數是：file_pattern
針對要讀取的稽核檔案集合指定目錄或路徑及檔案名稱。

將執行 sys.dm_server_audit_status 的結果，在資料行 audit_file_path 的內容值部分，填入到第一個引數內。
*/
SELECT * 
FROM sys.fn_get_audit_file (N'C:\myAdmin\Audit_Logs\稽核登入帳戶存取指定的資料表_E5BB026F-2D7A-48F5-A98F-1223C422F16B_0_128789673957910000.sqlaudit',default,default);

--EX2 搭配使用「*」萬用字元，可將同一個「稽核」物件所產生的多個稽核檔案，皆載入到系統內進行分析
SELECT * 
FROM sys.fn_get_audit_file (N'C:\myAdmin\Audit_Logs\稽核登入帳戶存取指定的資料表_*.sqlaudit',default,default);

--EX3 請留意：資料行event_time存放的是格林威治標準時間(GMT)
SELECT event_time N'稽核動作引發時的日期時間(GMT)', server_principal_name N'登入帳戶', 
	database_principal_name N'資料庫使用者',database_name N'資料庫', object_name N'物件名稱', statement N'TSQL 陳述式'
FROM sys.fn_get_audit_file (N'C:\myAdmin\Audit_Logs\稽核登入帳戶存取指定的資料表_*.sqlaudit',default,default);

--EX4 轉為台北時區(GMT+08:00)的日期時間(利用資料類型 datetimeoffset 與函數 SWITCHOFFSET)
SELECT SWITCHOFFSET(CAST(event_time AS datetimeoffset ),'+08:00') N'稽核動作引發時的日期時間(台北時區GMT+08:00)', 
	server_principal_name N'登入帳戶', database_principal_name N'資料庫使用者',
	database_name N'資料庫', object_name N'物件名稱', statement N'TSQL 陳述式'
FROM sys.fn_get_audit_file (N'C:\myAdmin\Audit_Logs\稽核登入帳戶存取指定的資料表_*.sqlaudit',default,default);

--EX5 將位於指定資料夾內的每一個稽核檔案，都載入到系統內進行分析
SELECT * 
FROM sys.fn_get_audit_file ('C:\myAdmin\Audit_Logs\*',default,default);

--EX6 轉為台北時區(GMT+08:00)的日期時間
SELECT SWITCHOFFSET(CAST(event_time AS datetimeoffset ),'+08:00') N'稽核動作引發時的日期時間(台北時區GMT+08:00)', 
	server_principal_name N'登入帳戶', database_principal_name N'資料庫使用者',
	database_name N'資料庫', object_name N'物件名稱', statement N'TSQL 陳述式'
FROM sys.fn_get_audit_file ('C:\myAdmin\Audit_Logs\*',default,default);
#>}
#-------------------------------------------------------------------
#  22  1060  範例程式碼15-7：建立、啟用與檢視「稽核」物件
#-------------------------------------------------------------------
{<#
--01 建立「稽核(SQL Server Audit)」
USE master
GO

CREATE SERVER AUDIT [稽核資料庫的查詢行為]
TO FILE 
(	FILEPATH = N'C:\myAdmin\Audit_Logs'
	,MAXSIZE = 10 MB
	,MAX_ROLLOVER_FILES = 100
	,RESERVE_DISK_SPACE = OFF)
WITH
	(	QUEUE_DELAY = 1000,ON_FAILURE = CONTINUE)
GO

--02 啟用此「稽核」物件
ALTER SERVER AUDIT [稽核資料庫的查詢行為]
	WITH (STATE = ON)
GO

--03 使用目錄檢視sys.server_audits檢視「稽核」物件的目前狀態
SELECT name N'稽核', is_state_enabled N'啟用',type_desc N'稽核類型',  queue_delay N'寫入磁碟前等候時間(毫秒)',
	create_date N'建立日期時間', modify_date '修改日期時間'
FROM sys.server_audits
#>}
#-------------------------------------------------------------------
#  23   1077 範例程式碼15-8：建立與啟用「伺服器稽核規格」物件
#-------------------------------------------------------------------
{<#
--01 建立「伺服器稽核規格」物件
USE master
GO

CREATE SERVER AUDIT SPECIFICATION [監控帳戶登入成功事件]
FOR SERVER AUDIT [稽核資料庫的查詢行為]
	ADD (SUCCESSFUL_LOGIN_GROUP)
GO

--02 啟用此「伺服器稽核規格」物件
ALTER SERVER AUDIT SPECIFICATION [監控帳戶登入成功事件]
	WITH (STATE = ON)
GO
#>}
#-------------------------------------------------------------------
# 24  1099 範例程式碼15-9：檢視「伺服器稽核規格」物件的相關資料
#-------------------------------------------------------------------
{<#
--01 檢視「伺服器稽核規格」物件
SELECT name N'伺服器稽核規格', is_state_enabled N'是否已啟用',
	create_date N'建立日期時間', modify_date N'修改日期時間'
FROM sys.server_audit_specifications

--02 檢視「伺服器稽核規格」物件的詳細資料(動作)
/*
在中文版本的線上說明：「SQL Server 2008 線上叢書 (August 2008)」 版本上，可能有錯誤，誤植為：
sys.server_audit_specifications_details 
在 specifications 部分，多了一個 s 字元。正確可用的目錄檢視為：sys.server_audit_specification_details。
*/
SELECT audit_action_id N'稽核動作的識別碼', audit_action_name N'稽核動作或稽核動作群組的名稱', 
	class_desc N'稽核動作套用的物件之類別名稱', is_group N'是否為動作群組'
FROM sys.server_audit_specification_details
#>}
#-------------------------------------------------------------------
# 25  1111  範例程式碼15-10：檢視可用於設定的稽核動作、稽核動作群組與稽核類型的項目
#-------------------------------------------------------------------
{<#
--01 檢視可用於設定的稽核動作、稽核動作群組的資料
/*
可用於設定的稽核動作、稽核動作群組的資料，現已有 454 項可供使用。
例如：動作群組名稱 ：SUCCESSFUL_LOGIN_GROUP，表示主體已成功登入 SQL Server。其條件式為：action_id='LGSD'
*/
SELECT * FROM sys.dm_audit_actions

--
SELECT * FROM sys.dm_audit_actions
WHERE action_id='LGSD'

--02 檢視可用於稽核的類型：class_type
/*
可用稽核的類型，現已有 88 種類型可供使用。 #sql2104
*/
SELECT * 
FROM sys.dm_audit_class_type_map
ORDER BY securable_class_desc
#>}
#-------------------------------------------------------------------
# 26  1150  範例程式碼15-11：建立與啟用「資料庫稽核規格」
#-------------------------------------------------------------------
{<#
--01 建立「資料庫稽核規格」物件
USE [Northwind_Audit]
GO

CREATE DATABASE AUDIT SPECIFICATION [監控每位使用者的查詢事件]
FOR SERVER AUDIT [稽核資料庫的查詢行為]
	ADD (SELECT ON SCHEMA::[dbo] BY [public])
GO

/*
部分語法：
...
{
      action [ ,...n ]ON [ class :: ] securable BY principal [ ,...n ]
}
...

使用的參數說明
class：這是安全性實體上的類別名稱。
securable(安全性實體 )：這是資料庫中套用稽核動作或稽核動作群組的資料表、檢視表或其他安全性實體物件。
principal(主體)：這是套用稽核動作或稽核動作群組的 SQL Server 主體名稱。
*/

--02 啟用「資料庫稽核規格」物件
ALTER DATABASE AUDIT SPECIFICATION [監控每位使用者的查詢事件]
	WITH (STATE = ON)
GO
#>}
#-------------------------------------------------------------------
#  27   1168 範例程式碼15-12：檢視「資料庫稽核規格」物件的目前狀態
#-------------------------------------------------------------------
--01 檢視「資料庫稽核規格」的資料
SELECT name N'資料庫稽核規格', is_state_enabled N'是否已啟用', 
	create_date N'建立日期時間', modify_date N'修改日期時間'
FROM sys.database_audit_specifications 

--02 檢視「資料庫稽核規格」的詳細資料(動作)
SELECT audit_action_id N'稽核動作的識別碼', audit_action_name N'稽核動作或稽核動作群組的名稱', 
	class_desc N'稽核的物件類別之描述', is_group N'是否為動作群組'
FROM sys.database_audit_specification_details

#-------------------------------------------------------------------
#   28  1180 範例程式碼15-13：建立登入帳戶ps3，可以連線資料庫Northwind_Audit，並賦予適當的權限
#-------------------------------------------------------------------
{<#
--01 建立登入帳戶：ps3，密碼是：P@ssw0rd
USE [master]
GO

CREATE LOGIN [ps3] 
	WITH PASSWORD=N'P@ssw0rd', DEFAULT_DATABASE=[Northwind_Audit], 
		CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

--02 允許登入帳戶：ps3，能夠連線到資料庫 Northwind_Audit
USE [Northwind_Audit]
GO

CREATE USER [ps3] 
	FOR LOGIN [ps3]
GO

--03 將登入帳戶：ps3，加入到資料庫角色 db_datareader 內。
EXEC sp_addrolemember N'db_datareader', N'ps3'
GO
#>}
#-------------------------------------------------------------------
#  29  1208 範例程式碼15-14：查詢資料庫Northwind_Audit內的資料表
#-------------------------------------------------------------------
--01 查詢資料庫內的資料表
USE Northwind_Audit
GO

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders
SELECT * FROM dbo.Products
SELECT * FROM dbo.Suppliers

#-------------------------------------------------------------------
#  30   1233 範例程式碼15-15：建立函數，篩選與分析所需的稽核資料
#-------------------------------------------------------------------
{<#
--01 建立多重陳述式資料表值函數：ufn_AuditReport
USE [master]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_AuditReport]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_AuditReport]
GO

CREATE FUNCTION dbo.ufn_AuditReport
	(@filepath varchar(1000))
RETURNS @retAuditReport TABLE
(
	[session_id] [int] NULL,
	[server_principal_name] [sysname] NOT NULL,
	[ip] [nvarchar](100) NULL,
	[login_time] [datetimeoffset](7) NULL,
	[database_name] [sysname] NOT NULL,
	[action_time] [datetimeoffset](7) NULL,
	[tsql] [nvarchar](4000) NULL
)
AS
BEGIN
	DECLARE @tsl TABLE
		(RN int, session_id int, event_time datetime2 , server_principal_name sysname , 
		server_principal_id int, database_name sysname, statement nvarchar(4000) )

	DECLARE @tlgis TABLE
		(RN int IDENTITY(1,1), event_time datetime2, additional_information nvarchar(4000) )

	-- 條件式為WHERE action_id IN('SL') ，也就是動作識別碼為：SELECT
	INSERT @tsl
	SELECT  ROW_NUMBER() OVER(ORDER BY event_time) 'RN',
		session_id, event_time, server_principal_name, server_principal_id, database_name, statement
	FROM sys.fn_get_audit_file (@filepath,default,default)
	WHERE action_id IN('SL') 

	DECLARE @rid INT=1
	DECLARE @tslRN INT=(SELECT MAX(RN) FROM @tsl)

	WHILE @tslRN>=@rid
	BEGIN
		DECLARE @session_id int =(SELECT session_id FROM @tsl WHERE RN=@rid)
		DECLARE @event_time datetime2 =(SELECT event_time FROM @tsl WHERE RN=@rid)
		DECLARE @server_principal_id int =(SELECT server_principal_id FROM @tsl WHERE RN=@rid)

	-- 條件式為WHERE action_id IN('LGIS') ，也就是動作識別碼為：LOGIN SUCCEEDED
		INSERT @tlgis(event_time, additional_information)
		SELECT TOP (1) event_time,additional_information
		FROM sys.fn_get_audit_file (@filepath,default,default)
		WHERE action_id='LGIS' AND session_id=@session_id AND server_principal_id=@server_principal_id 
			AND event_time<@event_time
		ORDER BY event_time DESC

		SET @rid+=1
	END

	-- 資料行additional_information，存放了客戶端主機的IP位址，是以XML結構方式呈現，所以需要利用XQuery來取得所需的資料
	INSERT @retAuditReport
	SELECT s.session_id , s.server_principal_name,
		(CAST(g.additional_information AS XML)).value('
			declare default element namespace "http://schemas.microsoft.com/sqlserver/2008/sqlaudit_data";
			(action_info/address)[1]','nvarchar(100)') N'ip',
		SWITCHOFFSET(CAST(g.event_time AS datetimeoffset ),'+08:00') N'login_time', s.database_name ,
		SWITCHOFFSET(CAST(s.event_time AS datetimeoffset ),'+08:00') N'action_time',  s.statement N'tsql'
	FROM @tsl s INNER JOIN @tlgis g
		ON s.RN=g.RN
	RETURN

END;
GO

/*=========================================================*/
--02 利用函數 ufn_AuditReport 分析稽核的記錄檔案
SELECT session_id N'工作階段識別碼', server_principal_name N'登入帳戶', ip N'用戶端主機位址', database_name N'資料庫',  action_time N'稽核動作引發的日期時間(台北時區GMT+08:00', tsql N'T-SQL 陳述式'
FROM dbo.ufn_AuditReport(N'C:\myAdmin\Audit_Logs\*')



#>}

#-------------------------------------------------------------------
#  31 1333  Testing  server Audit Specification
#-------------------------------------------------------------------
{<#

--Creates a SQL Server Audit and Server Audit Specification
USE master; GO-- Create the server auditCREATE SERVER AUDIT permissionChangesTO FILE ( FILEPATH = 'C:\',MAXSIZE = 1 GB)WITH( ON_FAILURE = CONTINUE)GO

--Creates a Server Audit SpecificationCREATE SERVER AUDIT SPECIFICATION serverSpecFOR SERVER AUDIT exampleAuditADD (SERVER_ROLE_MEMBER_CHANGE_GROUP)GO



-- Create the server audit specificationCREATE SERVER AUDIT SPECIFICATION serverPermissionChangesFOR SERVER AUDIT permissionChangesADD (SERVER_ROLE_MEMBER_CHANGE_GROUP),ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP),ADD (SERVER_PERMISSION_CHANGE_GROUP),ADD (SERVER_OBJECT_PERMISSION_CHANGE_GROUP),ADD (DATABASE_PERMISSION_CHANGE_GROUP),ADD (DATABASE_OBJECT_PERMISSION_CHANGE_GROUP)GO


-- Turn the audit and server audit specification ON ALTER SERVER AUDIT permissionChanges WITH(STATE = ON)GO
ALTER SERVER AUDIT SPECIFICATION serverPermissionChangesWITH (STATE = ON)GO

-- Creates actions that the audit will pick up
CREATE LOGIN auditTestWITH PASSWORD = 'Test123!'GO
ALTER SERVER ROLE sysadminADD MEMBER auditTestGO
ALTER SERVER ROLE sysadminDROP MEMBER auditTestGO
ALTER SERVER ROLE serveradmin
ADD MEMBER auditTestGO
ALTER SERVER ROLE processAdminADD MEMBER auditTest

--To review the contents of the audit,USE master;GOSELECT event_time,server_principal_name, object_name, statement,* FROM fn_get_audit_file('C:\perm*',NULL, NULL)
#>}


#-------------------------------------------------------------------
#32  1400 Testing  Database Audit Specification  
#-------------------------------------------------------------------
資料庫稽核規格 在 資料庫> 安全性 內
{<#

USE master; 
GO
-- Create the server audit
CREATE SERVER AUDIT salaryViewing
TO FILE ( FILEPATH = 'H:\sqlauditfile', MAXSIZE = 1 GB)
GO

-- Create the database audit specification in the database you want audited(1) for all database 
use AdventureWorks2014
CREATE DATABASE AUDIT SPECIFICATION [userSelect]
FOR SERVER AUDIT [UserAction]
	ADD (SELECT,insert,update,delete  ON SCHEMA::[dbo] BY [public])
GO

-- Create the database audit specification in the database you want audited(2) only one table
USE AdventureWorks2012
GO
CREATE DATABASE AUDIT SPECIFICATION salaryOueries
FOR SERVER AUDIT salaryViewing
ADD (SELECT,UPDATE ON HumanResources.EmployeePayHistory by dbo),
ADD (DATABASE_PRINCIPAL_CHANGE_GROUP)
GO



USE master; 
GO
ALTER SERVER AUDIT salaryViewing
WITH (STATE = ON)
GO


USE AdventureWorks2012 
GO
ALTER DATABASE AUDIT SPECIFICATION salaryOueries
WITH (STATE = OFF)
GO

USE AdventureWorks2012 
GO
ALTER DATABASE AUDIT SPECIFICATION salaryOueries
WITH (STATE = ON)
GO


SELECT TOP 10 *
FROM AdventureWorks2012.HumanResources.EmployeePayHistory

SELECT JobTitle, Rate,RateChangeDate
FROM AdventureWorks2012.HumanResources.Employee e
JOIN AdventureWorks2012.HumanResources.EmployeePayHistory eh
ON e.BusinessEntityID = eh.BusinessEntityID ORDER BY JobTitle, RateChangeDate DESC

SELECT JobTitle, Rate,RateChangeDate
FROM AdventureWorks2012.HumanResources.Employee e
JOIN AdventureWorks2012.HumanResources.EmployeePayHistory eh
ON e.BusinessEntityID = eh.BusinessEntityID WHERE rate > 50.
ORDER BY JobTitle, RateChangeDate DESC
GO

CREATE LOGIN auditTest with password = 'abc123'
GO
USE AdventureWorks2012
GO
--CREATE USER sneakyUser FOR LOGIN auditTest
--GO
USE [AdventureWorks2012]
GO
CREATE USER [CSD\sql1] FOR LOGIN [CSD\sql1]
GO



SELECT event_time,server_principal_name,database_principal_name,
object_name, statement,*
FROM fn_get_audit_file ('H:\sqlauditfile\sal*',NULL, NULL)


SELECT  event_time,server_principal_name,database_principal_name,
object_name, statement into dbo.a1
FROM fn_get_audit_file ('H:\sqlauditfile\sal*',NULL, NULL)
select * from a1

#>}

#-------------------------------------------------------------------
#33  1470   檢視/create/drop   Audit   20150610
#-------------------------------------------------------------------
##Get
use AdventureWorks2012
select * from sys.server_audits ;select name,is_state_enabled from sys.server_audits
select * from sys.database_audit_specifications
select * from sys.database_audit_specification_details
select * from sys.server_audit_specifications
select * from sys.server_audit_specification_details
select name,log_file_name,log_file_name,modify_date,create_date,* from sys.server_file_audits

## 



## delete
USE [master]
GO
ALTER SERVER AUDIT [tx]  WITH (STATE = OFF)
GO
USE [master]
GO
/****** Object:  Audit [tx]    Script Date: 6/11/2015 1:57:12 PM ******/
DROP SERVER AUDIT [tx]
GO



#-------------------------------------------------------------------
#34  1500   Get audit actions   20150610
#-------------------------------------------------------------------
#---傳回稽核記錄檔中可報告的每一個稽核動作及 SQL Server Audit 中可設定之每一個稽核動作群組的資料列
select * from sys.dm_audit_actions order by class_desc 
# 507 role
select containing_group_name,name,covering_parent_action_name,covering_action_name from sys.dm_audit_actions order by 1
<#  41 group 
NULL  select distinct  containing_group_name from sys.dm_audit_actions order by 1
APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
AUDIT_CHANGE_GROUP
BACKUP_RESTORE_GROUP
BROKER_LOGIN_GROUP
DATABASE_CHANGE_GROUP
DATABASE_LOGOUT_GROUP
DATABASE_MIRRORING_LOGIN_GROUP
DATABASE_OBJECT_ACCESS_GROUP
DATABASE_OBJECT_CHANGE_GROUP
DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP
DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
DATABASE_OPERATION_GROUP
DATABASE_OWNERSHIP_CHANGE_GROUP
DATABASE_PERMISSION_CHANGE_GROUP
DATABASE_PRINCIPAL_CHANGE_GROUP
DATABASE_PRINCIPAL_IMPERSONATION_GROUP
DATABASE_ROLE_MEMBER_CHANGE_GROUP
DBCC_GROUP
FAILED_DATABASE_AUTHENTICATION_GROUP
FAILED_LOGIN_GROUP
FULLTEXT_GROUP
LOGIN_CHANGE_PASSWORD_GROUP
LOGOUT_GROUP
SCHEMA_OBJECT_ACCESS_GROUP
SCHEMA_OBJECT_CHANGE_GROUP
SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP
SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP
SERVER_OBJECT_CHANGE_GROUP
SERVER_OBJECT_OWNERSHIP_CHANGE_GROUP
SERVER_OBJECT_PERMISSION_CHANGE_GROUP
SERVER_OPERATION_GROUP
SERVER_PERMISSION_CHANGE_GROUP
SERVER_PRINCIPAL_CHANGE_GROUP
SERVER_PRINCIPAL_IMPERSONATION_GROUP
SERVER_ROLE_MEMBER_CHANGE_GROUP
SERVER_STATE_CHANGE_GROUP
SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP
SUCCESSFUL_LOGIN_GROUP
TRACE_CHANGE_GROUP
USER_CHANGE_PASSWORD_GROUP
USER_DEFINED_AUDIT_GROUP
#>#

#---sys.dm_server_audit_status  提供有關稽核之目前狀態的資訊。
select * from  sys.dm_server_audit_status
SELECT audit_id N'稽核的識別碼', name N'稽核的名稱', status_desc N'伺服器稽核狀態', 
	status_time N'上一次狀態變更的時間戳記', audit_file_size N'稽核檔案大小(KB)', 
	audit_file_path N'稽核檔案目標的完整路徑名稱'
FROM sys.dm_server_audit_status;

<#
udit_id
int
稽核的識別碼。 對應至 sys.audits 目錄檢視中的 audit_id 欄位。
name
sysname
稽核的名稱。 與 sys.server_audits 目錄檢視中的 name 欄位相同。

status   tinyint    伺服器稽核的數值狀態：
0 – 已開始
1 – 失敗

status_desc   nvarchar(60)    顯示伺服器稽核狀態的字串：
- STARTED
- FAILED


status_time
datetime2
稽核之上一次狀態變更的時間戳記 (以 UTC 為單位)。


event_session_address
varbinary(8)
與稽核相關聯之擴充的事件工作階段的位址。 與 sys.db_xe_sessions.address 目錄檢視有關。
audit_file_path
nvarchar(260)
目前正在使用之稽核檔案目標的完整路徑和檔案名稱。 只會針對檔案稽核填入。
audit_file_size
bigint
稽核檔案的近似大小 (以位元組為單位)。 只會針對檔案稽核填入。



#>

sys.dm_audit_class_type_map

##fn_get_audit_file  fn_get_audit_file  從伺服器稽核建立的稽核檔案中傳回資訊。
<#  https://msdn.microsoft.com/zh-tw/library/cc280765.aspx
資料行名稱
型別
說明
event_time
datetime2
可稽核的動作引發時的日期和時間。 不可為 Null。
sequence_number
int
追蹤單一稽核記錄中太長而無法納入稽核寫入緩衝區內的記錄順序。 不可為 Null。
action_id
varchar(4)
動作的識別碼。 不可為 Null。
succeeded
bit
1 = 成功
0 = 失敗
指示觸發此事件的動作是否成功。 不可為 Null。 若為登入事件以外的所有事件，這只會報告權限檢查成功或失敗，而不會報告作業成功或失敗。
permission_bitmask
varbinary(16)
在某些動作中，這就是已授與、拒絕或撤銷的權限。
is_column_permission
bit
1 = true
0 = false
指出這是否為資料行層級權限的旗標。 不可為 Null。 當 permission_bitmask = 0 時會傳回 0。
session_id
smallint
事件發生所在之工作階段的識別碼。 不可為 Null。
server_principal_id
int
動作執行所在之登入環境的識別碼。 不可為 Null。
database_principal_id
int
動作執行所在之資料庫使用者環境的識別碼。 不可為 Null。 如果不適用則傳回 0。 例如，伺服器作業。
target_server_principal_id
int
GRANT/DENY/REVOKE 作業執行所在的伺服器主體。 不可為 Null。 如果不適用則傳回 0。
target_database_principal_id
int
GRANT/DENY/REVOKE 作業執行所在的資料庫主體。 不可為 Null。 如果不適用則傳回 0。
object_id
int
稽核發生所在之實體的識別碼。 這包括下列項目：
伺服器物件
資料庫
資料庫物件
結構描述物件
不可為 Null。 如果此實體為伺服器本身或是稽核並未在物件層級上執行，則會傳回 0。 例如驗證。
class_type
varchar(2)
稽核發生所在之可稽核的實體類型。 不可為 Null。
session_server_principal_name
sysname
工作階段的伺服器主體。 可設為 Null。
server_principal_name
sysname
目前的登入。 可設為 Null。
server_principal_sid
varbinary
目前的登入 SID。 可設為 Null。
database_principal_name
sysname
目前的使用者。 可設為 Null。 如果無法使用則傳回 NULL。
target_server_principal_name
sysname
動作的目標登入。 可設為 Null。 如果不適用則傳回 NULL。
target_server_principal_sid
varbinary
目標登入的 SID。 可設為 Null。 如果不適用則傳回 NULL。
target_database_principal_name
sysname
動作的目標使用者。 可設為 Null。 如果不適用則傳回 NULL。
server_instance_name
sysname
稽核發生所在的伺服器執行個體名稱。 使用標準的 server\instance 格式。
database_name
sysname
動作發生所在的資料庫環境。 可設為 Null。 如果是伺服器層級所發生的稽核，則會傳回 NULL。
schema_name
sysname
動作發生所在的結構描述環境。 可設為 Null。 如果是發生在結構描述外部的稽核，則傳回 NULL。
object_name
sysname
稽核發生所在之實體的名稱。 這包括下列項目：
伺服器物件
資料庫
資料庫物件
結構描述物件
可設為 Null。 如果此實體為伺服器本身或是稽核並未在物件層級上執行，則會傳回 NULL。 例如驗證。
statement
nvarchar(4000)
TSQL 陳述式 (如果存在的話)。 可設為 Null。 如果不適用則傳回 NULL。
additional_information
nvarchar(4000)
只套用到單一事件的唯一資訊會以 XML 形式傳回。 少量的可稽核動作有包含這類資訊。
針對具有相關聯 TSQL 堆疊的動作，以 XML 格式顯示 TSQL 堆疊的單一層級。 此 XML 格式為：
<tsql_stack><frame nest_level = '%u' database_name = '%.*s' schema_name = '%.*s' object_name = '%.*s' /></tsql_stack>
Frame nest_level 表示框架的目前巢狀層級。 模組名稱會以三部分格式表示 (database_name、schema_name 和 object_name)。 系統將剖析模組名稱以逸出無效的 Xml 字元，例如 '<'、'>'、'/' 和 '_x'。 這些字元將逸出為 _xHHHH_。 HHHH 代表字元的四位數十六進位 UCS-2 碼。
可設為 Null。 當此事件未報告其他資訊時，則會傳回 NULL。
file_name
varchar(260)
記錄來自之稽核記錄檔的路徑和名稱。 不可為 Null。
audit_file_offset
bigint
檔案中包含稽核記錄的緩衝區位移。 不可為 Null。
user_defined_event_id
smallint
使用者定義的事件識別碼會當做引數傳遞給 sp_audit_write。 如果是系統事件則為 NULL (預設值)，使用者定義的事件則為非零值。 如需詳細資訊，請參閱＜sp_audit_write (Transact-SQL)＞。
適用於：SQL Server 2012 至 SQL Server 2014。
user_defined_information
nvarchar(4000)
用來記錄使用者想要利用 sp_audit_write 預存程序記錄在稽核記錄中的任何額外資訊。
適用於：SQL Server 2012 至 SQL Server 2014。
#>


#-------------------------------------------------------------------
#35  1800  sp_change_users_login  現有的資料庫使用者對應至 SQL Server 登入  20150720
#-------------------------------------------------------------------
sp_change_users_login [ @Action = ] 'action' #將目前資料庫中指定的 user 連結到現有的 SQL Server login。 必須指定 user 和 login。 password 必須是 NULL 或不指定
    [ , [ @UserNamePattern = ] 'user' ] 
    [ , [ @LoginName = ] 'login' ] 
    [ , [ @Password = ] 'password' ]
[;]

#產生目前資料庫中的使用者及其安全性識別碼 (SID) 的報表
EXEC sp_change_users_login 'Report';

# 將資料庫使用者對應至新的 SQL Server 登入 , 第一次對應至其他登入的資料庫使用者 MB-Sales，會重新對應至登入 MaryB
--Create the new login.
CREATE LOGIN MaryB WITH PASSWORD = '982734snfdHHkjj3';
GO
--Map database user MB-Sales to login MaryB.
USE AdventureWorks2012;
GO
EXEC sp_change_users_login 'Update_One', 'MB-Sales', 'MaryB';
GO
#使用者對應至登入，視需要建立新的登入
USE AdventureWorks2012;
GO
EXEC sp_change_users_login 'Auto_Fix', 'Mary', NULL, 'B3r12-3x$098f6';
GO

#-------------------------------------------------------------------
#36  1800      執行個體之間傳送登入和密碼 sp_help_revlogin   sp_hexadecimal  20150721
#-------------------------------------------------------------------
please ref Sqlps12_01_sp_help_revlogin.ps1

將登入和密碼從伺服器 A 上的 SQL Server 執行個體傳送到伺服器 B 上的 SQL Server 執行個體，請依照下列步驟執行：


(1)在伺服器 A 上，啟動 SQL Server Management Studio，然後連線至先前從該處移動資料庫的 SQL Server 的執行個體。
(2)開啟新的 [查詢編輯器] 視窗，然後執行下列指令碼。

<#USE master
GO
IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
DROP PROCEDURE sp_hexadecimal
GO
CREATE PROCEDURE sp_hexadecimal
@binvalue varbinary(256),
@hexvalue varchar (514) OUTPUT
AS
DECLARE @charvalue varchar (514)
DECLARE @i int
DECLARE @length int
DECLARE @hexstring char(16)
SELECT @charvalue = '0x'
SELECT @i = 1
SELECT @length = DATALENGTH (@binvalue)
SELECT @hexstring = '0123456789ABCDEF'
WHILE (@i <= @length)
BEGIN
DECLARE @tempint int
DECLARE @firstint int
DECLARE @secondint int
SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
SELECT @firstint = FLOOR(@tempint/16)
SELECT @secondint = @tempint - (@firstint*16)
SELECT @charvalue = @charvalue +
SUBSTRING(@hexstring, @firstint+1, 1) +
SUBSTRING(@hexstring, @secondint+1, 1)
SELECT @i = @i + 1
END

SELECT @hexvalue = @charvalue
GO
 
IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL
DROP PROCEDURE sp_help_revlogin
GO
CREATE PROCEDURE sp_help_revlogin @login_name sysname = NULL AS
DECLARE @name sysname
DECLARE @type varchar (1)
DECLARE @hasaccess int
DECLARE @denylogin int
DECLARE @is_disabled int
DECLARE @PWD_varbinary  varbinary (256)
DECLARE @PWD_string  varchar (514)
DECLARE @SID_varbinary varbinary (85)
DECLARE @SID_string varchar (514)
DECLARE @tmpstr  varchar (1024)
DECLARE @is_policy_checked varchar (3)
DECLARE @is_expiration_checked varchar (3)

DECLARE @defaultdb sysname
 
IF (@login_name IS NULL)
DECLARE login_curs CURSOR FOR

SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
sys.server_principals p LEFT JOIN sys.syslogins l
ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name <> 'sa'
ELSE
DECLARE login_curs CURSOR FOR


SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
sys.server_principals p LEFT JOIN sys.syslogins l
ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name = @login_name
OPEN login_curs

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
IF (@@fetch_status = -1)
BEGIN
PRINT 'No login(s) found.'
CLOSE login_curs
DEALLOCATE login_curs
RETURN -1
END
SET @tmpstr = '/* sp_help_revlogin script '
PRINT @tmpstr
SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
PRINT @tmpstr
PRINT ''
WHILE (@@fetch_status <> -1)
BEGIN
IF (@@fetch_status <> -2)
BEGIN
PRINT ''
SET @tmpstr = '-- Login:' + @name
PRINT @tmpstr
IF (@type IN ( 'G', 'U'))
BEGIN -- NT authenticated account/group

SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'
END
ELSE BEGIN -- SQL Server authentication
-- obtain password and sid
SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )
EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT
EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT
 
-- obtain password policy state
SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
 
SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'

IF ( @is_policy_checked IS NOT NULL )
BEGIN
SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked
END
IF ( @is_expiration_checked IS NOT NULL )
BEGIN
SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked
END
END
IF (@denylogin = 1)
BEGIN -- login is denied access
SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )
END
ELSE IF (@hasaccess = 0)
BEGIN -- login exists but does not have access
SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )
END
IF (@is_disabled = 1)
BEGIN -- login is disabled
SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'
END
PRINT @tmpstr
END

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
END
CLOSE login_curs
DEALLOCATE login_curs
RETURN 0
GO
#>

(3)執行下列陳述式

EXEC sp_help_revlogin
           產生的輸出指令碼是登入指令碼。這個登入指令碼會建立具有原始「安全性識別碼」(SID) 和原始密碼的登入。

(4)在伺服器 B 上，啟動 SQL Server Management Studio，然後連線至先前將資料庫移至該處的 SQL Server 的執行個體。
(5)開啟新的 [查詢編輯器] 視窗，然後執行在步驟 3 中產生的輸出指令碼。
備註
在伺服器 B 上的執行個體上執行輸出指令碼之前，請先檢閱下列資訊：
r1:仔細檢閱輸出指令碼。如果伺服器 A 和伺服器 B 是在不同的網域中，您必須修改輸出指令碼。然後，您必須在 CREATE LOGIN 陳述式中，使用新的網域名稱取代原始的網域名稱。在新網域中授與存取權的整合式登入沒有與原始網域中的登入相同的 SID。因此，使用者是孤立於這些登入之外。 如需有關如何解決這些孤立使用者的詳細資訊，請按一下下面的文件編號，檢視「Microsoft 知識庫」中的文件：
240872 INF：如何解決在 SQL Server 之間移動資料庫的權限問題
如果伺服器 A 和伺服器 B 是在相同的網域中，就會使用相同的 SID。因此，使用者不可能是孤立的。
r2:在輸出指令碼中，登入是使用加密的密碼而建立的。這是因為 CREATE LOGIN 陳述式中的 HASHED 引數的緣故。這個引數會指定在 PASSWORD 引數之後輸入的密碼已經是雜湊密碼。
r3:根據預設，只有 sysadmin 固定伺服器角色的成員可以從 sys.server_principals 檢視執行 SELECT 陳述式。除非 sysadmin 固定伺服器角色的成員授與必要權限給使用者，否則使用者無法建立或執行輸出指令碼。
r4:本文中的步驟無法為特定登入傳送預設資料庫資訊。這是因為預設資料庫不一定永遠在伺服器 B 上。如果要定義登入的預設資料庫，請傳入登入名稱和預設資料庫做為引數，藉此使用 ALTER LOGIN 陳述式。
r5:伺服器 A 的排序順序可能不必區分大小寫，伺服器 B 的排序順序則可能要區分大小寫。
   在這種情況中，在您將登入和密碼傳送到伺服器 B 上的執行個體之後，使用者必須將密碼中的所有字母以大寫字母輸入。

或者，伺服器 A 的排序順序可能要區分大小寫，伺服器 B 的排序順序則可能不必區分大小寫。在這種情況中，使用者無法使用您傳送到伺服器 B 上的執行個體的登入和密碼來登入，除非下列其中一種情況成立：
        原始密碼中沒有字母。
        原始密碼中的所有字母都是大寫字母。
伺服器 A 和伺服器 B 的排序順序可能要區分大小寫，也可能不必區分大小寫。在上述情況中，使用者不會遇到問題。

已存在於伺服器 B 上執行個體中的登入名稱可能會與輸出指令碼中的名稱相同。在這種情況中，當您在伺服器 B 上的執行個體上執行輸出指令碼時，會收到下列錯誤訊息：
        訊息 15025，層級 16，狀態 1，行 1
        伺服器主體 'MyLogin' 已經存在。

同樣地，已存在於伺服器 B 上執行個體中的登入 SID 可能會與輸出指令碼中的 SID 相同。在這種情況中，當您在伺服器 B 上的執行個體上執行輸出指令碼時，會收到下列錯誤訊息：
        訊息 15433，層級 16，狀態 1，行 1
        提供的參數 sid 正在使用中。
因此，您必須執行下列操作：
        1.仔細檢閱輸出指令碼。
        2.檢查伺服器 B 上執行個體中的 sys.server_principals 檢視的內容。
        3.解決這些錯誤訊息。
在 SQL Server 2005 中，登入的 SID 會用來做為實作資料庫層級存取的基礎。在伺服器上的兩個不同資料庫中，登入可能會有兩個不同的 SID。在這種情況中，登入只能存取其 SID 與 sys.server_principals 檢視中的 SID 相符的資料庫。如果兩個資料庫是從兩個不同的伺服器合併的，可能就會發生這個問題。如果要解決這個問題，請使用 DROP USER 陳述式從其 SID 不符的資料庫手動移除登入。然後，使用 CREATE USER 陳述式再次加入登入。



#-------------------------------------------------------------------
#37  2001     稽核SQL Server Audit新增強的功能(1) 
#-------------------------------------------------------------------
http://blogs.uuu.com.tw/Articles/post/2012/05/10/%E6%96%B0%E6%89%8B%E5%AD%B8SQL-Server-2012%E7%A8%BD%E6%A0%B8SQL-Server-Audit%E6%96%B0%E5%A2%9E%E5%BC%B7%E7%9A%84%E5%8A%9F%E8%83%BD(1).aspx

前言
隨著企業開始正視資訊安全的重要性，存取資料的稽核紀錄將變得重要。在SQL Server 2008版本開始導入一套全新的稽核系統：SQL Server Audit，讓管理人員不但可以精確地紀錄所需要之稽核資訊，而且利用「擴充事件(Extended Event)」來監視系統。

所謂的「擴充事件」，是一種耗用資源少的輕量型效能監視系統，這也是在SQL Server 2008版本開始提供。如今在SQL Server 2012版本，增加了更多彈性與自訂的功能。

 

伺服器稽核新增強的功能
以下整理了SQL Server 2012版本在「伺服器稽核(SQL Server Audit)」上新增強的功能：

所有SQL Server版本都支援「伺服器層級稽核(Server Level Audit)」。但是「資料庫層級稽核(Database Level Audit)」，則限於Enterprise、Developer以及Evaluation版本。
強化對稽核檔案記錄寫入失敗的處理，並且提供了繼續、關閉伺服器以及失敗作業等選項。
新增加對稽核記錄檔的篩選。例如，在CREATE SERVER AUDIT可以搭配使用WHERE條件式，篩選符合條件式的資料才能存放到稽核記錄檔上。
在先前版本中，稽核記錄可能具有不定數目的記錄檔，或在預先定義的數目之後換用。現在，已經導入了新的選項，可設定稽核檔案的數目上限而不換用，讓客戶能夠控制所收集的稽核資訊數量，而不會遺失稽核記錄。
新增「稽核動作群組」：USER_DEFINED_AUDIT_GROUP。它讓你可以自定使用者所需的稽核事件。使用系統預存程序：sp_audit_write，則可以將使用者定義稽核事件加入至 USER_DEFINED_AUDIT_GROUP。
提供了T-SQL堆疊(Stack) 框架資訊與動作相關聯的T-SQL堆疊資訊，這是以XML格式顯示。可以利用系統預存函數「sys.fn_get_audit_file」來查詢。
支援監視「自主資料庫」的資料庫使用者。
稽核記錄失敗時的處理

舉例來說：如果寫入的目標目錄是位於遠端共用上，若是發生網路中斷事件，「伺服器稽核」可以設定為能夠於恢復網路連接後，繼續執行服務。此外，也導入發生寫入記錄目標失敗時，讓此作業失敗的新功能。

有關於強化稽核檔案寫入失敗的處理，以下提供更進一步的說明：

「繼續(CONTINUE)」
若發生稽核記錄寫入失敗時，系統不會保留稽核記錄。「伺服器稽核」是會繼續嘗試記錄事件，而且之後，如果失敗狀況已解決，就會恢復稽核作業。
使用此選項可能會違反安全性原則，因為可能會有遺漏未稽核到的活動。這項功能，適用於資料庫系統的運行作業比維持完整稽核更重要時，請使用此選項。

「關閉伺服器(SHUTDOWN)」
這是在SQL Server 2008版本就已經提供的功能。若是發生稽核記錄寫入失敗時，系統將會強制伺服器關閉。發出此內容的登入必須具有SHUTDOWN權限。
如果登入的帳戶沒有此權限，這個功能將會失敗，而且會引發錯誤訊息，不會發生稽核的事件。這項功能，適用於當稽核失敗可能危害系統的安全性或完整性時，請使用此選項。

「失敗作業(FAIL OPERATION)」
如果資料庫動作導致發生稽核的事件，但卻發生稽核記錄寫入失敗時，這些動作就會失敗。也就是說，稽核事件的動作無法繼續進行，也不會發生稽核的事件。
稽核會繼續嘗試記錄事件，而且如果失敗狀況已解決，就會恢復稽核。這項功能，適用於當維持完整稽核是比資料庫系統的運行作業更重要時，請使用此選項。
這是以交易的方式來進行，若是因故發生無法寫入稽核記錄的事件，系統將會回復此交易。但是，這只包含有使用「稽核」組態的對象，若有未受到稽核的對象，則不受到交易回復的影響，仍將繼續執行。
舉例來說：以客戶、訂單兩個資料表為例，因為客戶資料表包含了機密資料，你僅在客戶資料表上設定了「稽核」。此選項能夠以交易的方式回復客戶資料表，但是因為沒有在訂單資料表上設定「稽核」，所以，仍是可以對訂單資料表繼續作業。


v設定最大換用檔案與最大檔案數目
最大換用檔案(Maximum rollover files):此選項用於設定除了目前的檔案外，還要保留多少份的檔案數量之上限。對「檔案大小上限」所輸入的參數值必須要是整數，預設是無限制，系統會自動填入：2147483647。
每當「稽核」重新啟動(例如：執行個體重新啟動或是對「稽核」設定停用後再度啟用)，或者是，檔案數量已經達到「檔案大小上限」所設定的空間時，系統就會評估此參數。在評估「最大換用檔案」時，如果檔案的數量已經超過其所設定值時，系統會自動刪除最舊版本的檔案。
如果將「最大換用檔案」設定為0，則每次在評估「最大換用檔案」的設定時，系統都會建立新的檔案。每次評估「最大換用檔案」的設定值時，系統只會自動刪除一個檔案。

最大檔案數目(MAX FILES):在SQL Server 2012版本上新增加了「最大檔案數目」選項，可以指定可建立的最大稽核檔案之數目。若是達到此限制，系統不會換用最初的第一個檔案。
因此，當達到MAX_FILES選項限制時，任何會被觸發進而產生稽核事件的動作，都會遭遇到失敗並接收到錯誤訊息。

在設定「最大換用檔案」後，搭配使用「最大檔案數目」選項，可以避免發生被人惡意洗稽核記錄的情形。


v認識稽核檔案的存取權

這要提醒你的是：系統會將「稽核」的結果傳送到事先所定義的「目標」內存放，若將「目標」組態為二進位檔案，這是使用SQL Server服務啟動帳戶的身分來寫入與讀取。因此，請確認SQL Server服務啟動帳戶對於目標的檔案位置有足夠的讀取和寫入權限。若是權限不足，在建立「伺服器稽核」時，就會遭遇到以下的錯誤訊息，以及下圖所示：
訊息 33072，層級 16，狀態 1，行 2
稽核記錄檔路徑無效。

V若要將SQL Server Audit的目標記錄檔案直接寫入到網路共用資料夾，需要進行以下的設定：
SQL Server服務的服務啟動帳戶，需要使用指定的登入帳戶。
此登入帳戶需要對於遠端的網路共用資料夾，具備寫入與讀取的權限。
請使用「通用命名慣例(Universal Naming Convention，UNC)」命名格式來存取。

#-------------------------------------------------------------------
#  38  2066     實作練習一 將SQL Server Audit的目標記錄檔案寫入到網路共用資料夾
#-------------------------------------------------------------------
  

{<#  實作練習一  

2091 任務一：建立SQL Server Audit伺服器稽核，將目標記錄檔案寫入到遠端的網路共用資料內
2187 任務二：建立伺服器稽核規格
2256 任務三：建立、修改與刪除資料庫與檢視稽核記錄
2334 任務四：調整稽核記錄失敗時的處理
      2337 選擇：「繼續」模式
      2363 選擇：「失敗作業」模式
      2438 選擇：「關閉伺服器」模式 
2490 任務五：調整稽核檔案數目上限


：
在本次練習將一併介紹SQL Server Audit新增強的功能。

準備工作
1. 準備兩台伺服器：一台安裝SQL Server的資料庫伺服器，一台伺服器提供網路共用。在本次實作練習環境中，使用OPM擔任資料庫伺服器，使用OP1擔任網路共用伺服器。

2. 建立共用的登入帳戶，請擇一執行即可：

若在網域環境，請建立一個網域登入帳戶：advop，密碼為：P@ssw0rd。
若非網域環境，替代方案是可以在兩台伺服器上，建立相同名稱、密碼的本機登入帳戶：advop，密碼為：P@ssw0rd。
3. 將此登入帳戶：advop，加入到以下本機Administrators群組內。

4. 將此網域登入帳戶：advop，加入到SQL Server執行個體的伺服器角色：sysadmin內。

5. 在擔任網路共用的伺服器上，建立資料夾：C:\myAdmin\Audit_Logs。並設定此網域登入帳戶：advop對此資料夾的「共用使用權限」為「完全控制」。

6. 設定使用此advop網域登入帳戶來當做SQL Server服務啟動帳戶。

2091 任務一：建立SQL Server Audit伺服器稽核，將目標記錄檔案寫入到遠端的網路共用資料內

步驟 1. 使用SSMS管理工具，連線到目標伺服器，使用「物件總管」，展開指定的伺服器「安全性」\「稽核」節點。

步驟 2. 在「稽核」節點上，滑鼠右鍵選擇「新增稽核」。

步驟 3. 在「建立稽核」視窗填入以下的參數：

在「稽核名稱」方塊輸入：稽核資料庫的異動_UNC。
在「佇列延遲(以毫秒為單位)」方塊輸入：1000。
在「於稽核記錄失敗」方塊點選：「繼續」。
在「稽核目的地」方塊選擇：「檔案」。
在「檔案路徑」方塊輸入：\\OP1\Audit_Logs。
點選「確定」，完成設定。
驟 4. 在「稽核」物件：稽核資料庫的異動_UNC上，滑鼠右鍵，選擇「啟用稽核」。

步驟 5. 在「啟用稽核」視窗，點選「關閉」。

或是，使用以下的範例程式碼來建立與啟用SQL Server Audit「伺服器稽核」。請參考下圖所示：

-- 01_建立「伺服器稽核」，將目標記錄檔案寫入到遠端的網路共用資料內

USE [master]

GO

IF EXISTS (SELECT * FROM sys.server_audits WHERE name = N'稽核資料庫的異動_UNC')

BEGIN

ALTER SERVER AUDIT [稽核資料庫的異動_UNC]

WITH (STATE = OFF);

DROP SERVER AUDIT [稽核資料庫的異動_UNC]

END

GO

CREATE SERVER AUDIT [稽核資料庫的異動_UNC]

TO FILE

( FILEPATH = N'\\OP1\Audit_Logs'

,MAXSIZE = 0 MB

,MAX_ROLLOVER_FILES = 2147483647

,RESERVE_DISK_SPACE = OFF

)

WITH

( QUEUE_DELAY = 1000

,ON_FAILURE = CONTINUE

)

GO

-- 02_啟用此「伺服器稽核」：稽核資料庫的異動_UNC

ALTER SERVER AUDIT [稽核資料庫的異動_UNC]

WITH (STATE = ON);

GO

-- 03_使用sys.dm_server_audit_status動態管理檢視，檢視「伺服器稽核」SQL Server Audit的狀態

SELECT audit_id N'稽核的識別碼', name N'稽核的名稱', status_desc N'伺服器稽核狀態',

status_time N'上一次狀態變更的時間戳記', audit_file_size N'稽核檔案大小(KB)',

audit_file_path N'稽核檔案目標的完整路徑名稱'

FROM sys.dm_server_audit_status;

GO

-- 04_使用sys.server_audits目錄檢視，檢視「伺服器稽核」物件的目前狀態

SELECT name N'稽核',type_desc N'稽核類型', on_failure_desc N'寫入動作失敗時',

is_state_enabled N'啟用',queue_delay N'寫入磁碟前等候時間(毫秒)',

create_date N'建立日期時間', modify_date '修改日期時間'

FROM sys.server_audits

GO

2187 任務二：建立伺服器稽核規格

在伺服器層級的稽核動作群組上，使用的是：DATABASE_CHANGE_GROUP，這是指每當建立、改變或卸除任何資料庫時，就會引發這個事件。

步驟 1. 使用「物件總管」，展開指定的伺服器「安全性」\「伺服器稽核規格」節點。

步驟 2. 在「伺服器稽核規格」節點，滑鼠右鍵選擇「新增伺服器稽核規格」。

步驟 3. 在「建立伺服器稽核規格」視窗，輸入以下的參數：

在「名稱」方塊輸入：監視每當發生建立、改變或卸除任何資料庫的事件。
在「稽核」方塊選取：稽核資料庫的異動_UNC。
在「稽核動作類型」方塊選擇：DATABASE_CHANGE_GROUP。
點選「確定」完成設定
步驟 4. 在「伺服器稽核規格」物件：當建立、改變或卸除伺服器主體，滑鼠右鍵選擇「啟用伺服器稽核規格」。

步驟 5. 在「啟用伺服器稽核規格」視窗，點選「關閉」。請參考下圖所示：

圖6：檢視已經建立的伺服器稽核以及對應的伺服器稽核規格

或是，使用以下的範例程式碼來建立與啟用伺服器稽核規格。請參考下圖所示：

-- 01_建立「伺服器稽核規格」：監視每當發生建立、改變或卸除任何資料庫的事件

USE [master]

GO

IF EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = N'監視每當發生建立、改變或卸除任何資料庫的事件')

BEGIN

ALTER SERVER AUDIT SPECIFICATION [監視每當發生建立、改變或卸除任何資料庫的事件]

WITH (STATE = OFF);

DROP SERVER AUDIT SPECIFICATION [監視每當發生建立、改變或卸除任何資料庫的事件]

END

GO

CREATE SERVER AUDIT SPECIFICATION [監視每當發生建立、改變或卸除任何資料庫的事件]

FOR SERVER AUDIT [稽核資料庫的異動_UNC]

ADD (DATABASE_CHANGE_GROUP)

GO

-- 02_啟用此「伺服器稽核規格」：監視每當發生建立、改變或卸除任何資料庫的事件

ALTER SERVER AUDIT SPECIFICATION [監視每當發生建立、改變或卸除任何資料庫的事件]

WITH (STATE = ON);

GO

-- 03_檢視「伺服器稽核規格」物件

SELECT name N'伺服器稽核規格', is_state_enabled N'是否已啟用',

create_date N'建立日期時間', modify_date N'修改日期時間'

FROM sys.server_audit_specifications

GO


2256任務三：建立、修改與刪除資料庫與檢視稽核記錄

步驟 1. 使用「物件總管」，建立、修改與刪除資料庫，或是執行以下的範例程式碼：

-- 01_建立資料庫：DB_Audit02

USE master

GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DB_Audit02')

DROP DATABASE [DB_Audit02]

GO

CREATE DATABASE DB_Audit02

GO

-- 02_啟用資料庫屬性：AUTO_SHRINK

ALTER DATABASE [DB_Audit02]

SET AUTO_SHRINK ON WITH NO_WAIT

GO

-- 03_刪除此資料庫：DB_Audit02

DROP DATABASE DB_Audit02

GO

步驟 2. 在「物件總管」，展開指定的伺服器「安全性」\「稽核」節點。

步驟 3. 在「稽核」物件：稽核資料庫的異動_UNC上，滑鼠右鍵選擇「檢視稽核紀錄」。這裡面記錄了詳盡的資訊。

步驟 4. 點選「關閉」，完成檢視稽核目標記錄。

或是，使用以下的範例程式碼來檢視稽核目標記錄：

-- 01_使用fn_get_audit_file系統安全函數來檢視稽核檔案的內容

-- 請留意：event_time資料行存放的是格林威治標準時間(GMT)。

USE master

GO

SELECT *

FROM sys.fn_get_audit_file ('\\OP1\Audit_Logs\\*',default,default)

ORDER BY 1 DESC;

GO

-- 02_移轉為伺服器所在地時區

SELECT SWITCHOFFSET (CAST(event_time AS datetimeoffset), datepart(TZoffset,sysdatetimeoffset())) N'引發時的日期時間(伺服器所在地時區)',

server_principal_name N'登入帳戶', database_principal_name N'資料庫使用者',

database_name N'資料庫', object_name N'物件名稱', statement N'TSQL 陳述式'

FROM sys.fn_get_audit_file ('\\OP1\Audit_Logs\\*',default,default)

ORDER BY 1 DESC;

GO

結語
在本期文章中，介紹了伺服器稽核新增強的功能、稽核記錄失敗時的處理、設定最大換用檔案與最大檔案數目、認識稽核檔案的存取權、將SQL Server Audit的目標記錄檔案寫入到網路共用資料夾等主題。

2334 任務四：調整稽核記錄失敗時的處理

2337選擇：「繼續」模式

步驟 1. 在擔任網路共用伺服器上，關閉先前分享的資料夾。

步驟 2. 回到資料庫伺服器上，使用「物件總管」，建立、修改與刪除資料庫，或是執行先前的範例程式碼3。

因為事先關閉了網路分享資料夾，這將導致觸發的事件無法寫入到稽核記錄檔案內。但先前在建立「伺服器稽核」時，在「於稽核記錄失敗時」區域，預設所組態的是「繼續」。因此，系統仍是可以正常執行，但是在Windows事件檢視器上將可以觀察到以下的錯誤訊息，請參考下圖所示：

-- Windows事件檢視器的應用程式記錄 
SQL Server Audit 無法寫入檔案 '\\OP1\Audit_Logs\稽核資料庫的異動_UNC_F378D9C3-4CD7-41E9-B37C-D483C62935FA.sqlaudit'。
在SQL Server錯誤記錄檔上將可以觀察到以下的錯誤訊息，請參考下圖所示：

-- SQL Server錯誤記錄檔 
訊息 
Error: 33202, Severity: 17, State: 1. 
訊息 
SQL Server Audit could not write to file '\\OP1\Audit_Logs\稽核資料庫的異動_UNC_F378D9C3-4CD7-41E9-B37C-D483C62935FA.sqlaudit'.

或是，執行以下的範例程式碼來查詢「伺服器稽核」的運行狀態，並請參考下圖5所示：

-- 01_使用sys.dm_server_audit_status動態管理檢視，檢視「伺服器稽核」SQL Server Audit的狀態 
SELECT audit_id N'稽核的識別碼', name N'稽核的名稱', status_desc N'伺服器稽核狀態', 
    status_time N'上一次狀態變更的時間戳記', audit_file_size N'稽核檔案大小(KB)', 
    audit_file_path N'稽核檔案目標的完整路徑名稱' 
FROM sys.dm_server_audit_status; 
GO


2363 選擇：「失敗作業」模式

步驟 3. 在擔任網路共用伺服器上，再度分享先前的資料夾。

步驟 4. 回到資料庫伺服器上，使用「物件總管」，在「伺服器稽核」物件：稽核資料庫的異動_UNC上，先停用此「伺服器稽核」，在「於稽核記錄失敗」區域，設定為「失敗作業」，再重新啟用此「伺服器稽核」。

或是，執行以下的範例程式碼：

-- 01_停用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = OFF); 
GO 
-- 02_在「於稽核記錄失敗」參數，設定為「失敗作業」 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH(    ON_FAILURE = FAIL_OPERATION) 
GO 
-- 03_啟用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = ON); 
GO
範例程式碼6：變更伺服器稽核的屬性為：失敗作業

若是沒有先停用此「伺服器稽核」，就試圖去變更其屬性，將遭遇到以下的錯誤訊息，請參考下圖所示： 
訊息 33071，層級 16，狀態 1，行 2 
這個命令要求必須停用 稽核。請停用 稽核 後，再重新執行這個命令。
在本次實作練習中，若是沒有先啟用遠端的網路分享資料夾功能，導致無法存取稽核目標檔案，將遭遇到以下的錯誤訊息，請參考下圖所示：

訊息 33222，層級 16，狀態 1，行 1 
稽核 '稽核資料庫的異動_UNC' 無法進行 start。 
如需詳細資訊，請參閱 SQL Server 錯誤記錄檔。 
您還可以查詢 sys.dm_os_ring_buffers，其中 ring_buffer_type = 'RING_BUFFER_XE_LOG'。
在SQL Server錯誤記錄檔上將可以觀察到以下的錯誤訊息，請參考下圖所示：

錯誤: 33206，嚴重性: 17，狀態: 1。 
SQL Server Audit failed to create the audit file '\\OP1\Audit_Logs\稽核資料庫的異動_UNC_F0F90B89-9EFC-4593-A07F-6B6FA9CD65BE.sqlaudit'. 
Make sure that the disk is not full and that the SQL service account has the required permissions to create and write to the file.

步驟 5. 使用「物件總管」，建立、修改與刪除資料庫，或是，執行先前的範例程式碼3。 
步驟 6. 使用「物件總管」，檢視稽核記錄，或是，執行範例程式碼4來檢視稽核記錄。

步驟 7. 在擔任網路共用伺服器上，關閉先前分享的資料夾。 
步驟 8. 回到資料庫伺服器上，使用「物件總管」，建立、修改與刪除資料庫，或是執行先前的範例程式碼3。

因為事先關閉了網路分享資料夾，這將導致觸發的事件無法寫入到稽核記錄檔案內。但先前在建立「伺服器稽核」時，在「於稽核記錄失敗時」區域，預設所組態的是「失敗作業」。因此，這將導致建立、修改與刪除資料庫等作業都會失敗，無法執行。

 

訊息 15247，層級 16，狀態 15，行 1 
使用者沒有執行此動作的權限。


在SQL Server錯誤記錄檔上將可以觀察到以下的錯誤訊息，請參考下圖所示：

錯誤: 33239，嚴重性: 16，狀態: 1。 
An error occurred while auditing this operation. Fix the error in the audit and then retry this operation.



SQL Server錯誤記錄檔：無法存取稽核目標檔案，導致「失敗作業」，錯誤識別碼：33239

Windows事件檢視器上將可以觀察到以下的錯誤訊息，請參考下圖所示：

稽核此作業時發生錯誤。請修正核此中的錯誤，然後重試此作業。






2438 選擇：「關閉伺服器」模式 
步驟 9. 在擔任網路共用伺服器上，再度分享先前的資料夾。 
步驟10. 回到資料庫伺服器上，使用「物件總管」，在「伺服器稽核」：稽核資料庫的異動_UNC上，先停用此「伺服器稽核」，在「於稽核記錄失敗」區域，設定為「關閉伺服器」，再重新啟用此「伺服器稽核」。 
或是，執行以下的範例程式碼：

-- 01_停用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = OFF); 
GO 
-- 02_在「於稽核記錄失敗」參數，設定為「關閉伺服器」 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH(    ON_FAILURE = SHUTDOWN) 
GO 
-- 03_啟用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = ON); 
GO

範例程式碼7：變更伺服器稽核的屬性為：關閉伺服器

步驟11. 使用「物件總管」，建立、修改與刪除資料庫，或是執行先前的範例程式碼3。 
步驟12. 使用「物件總管」，檢視稽核記錄，或是，執行範例程式碼4來檢視稽核記錄。

步驟13. 在擔任網路共用伺服器上，關閉先前分享的資料夾。 
步驟14. 回到資料庫伺服器上，使用「物件總管」，建立、修改與刪除資料庫，或是執行先前的範例程式碼3。

因為事先關閉了網路分享資料夾，這將導致觸發的事件無法寫入到稽核記錄檔案內。但先前在建立「伺服器稽核」時，在「於稽核記錄失敗時」區域，預設所組態的是「關閉伺服器」。因此，這將導致此執行個體自動關機，停止服務。在Windows事件檢視器上將可以觀察到以下的錯誤訊息，請參考下圖所示：

事件識別碼：33219 
伺服器已停止，因為 SQL Server Audit '稽核資料庫的異動_UNC' 設定為於失敗時關閉。 
如果要對此問題進行疑難排解，請在伺服器啟動時使用 -m 旗標 (單一使用者模式)，以略過稽核所產生的關機。 
-- 
事件識別碼：19019 
MSSQLSERVER 服務非預期地結束.


此執行個體已經被強迫關機，停止服務，你之後也無法啟動此執行個體。若沒有修復讓其能夠存取稽核目標檔案，那就只能使用-m旗標(單一使用者模式)方式來啟動執行個體，修改「伺服器稽核」的屬性。

步驟15. 在擔任網路共用伺服器上，再度分享先前的資料夾。 
步驟16. 重新啟動此執行個體。 
步驟17. 檢視SQL Server錯誤記錄檔將可以觀察到以下的錯誤訊息，請參考下圖所示：

The server was stopped because SQL Server Audit '稽核資料庫的異動_UNC' is configured to shut down on failure. 
To troubleshoot this issue, use the -m flag (Single User Mode) to bypass Audit-generated shutdowns when the server is starting.


2490 任務五：調整稽核檔案數目上限
步驟 1. 在擔任網路共用伺服器上，先將分享資料夾內稽核目標檔案，除了目前正在使用的無法刪除外，其餘的請全部都刪除掉。 
步驟 2. 回到資料庫伺服器上，使用「物件總管」，在「伺服器稽核」：稽核資料庫的異動_UNC上，先停用此「伺服器稽核」。設定此「伺服器稽核」以下的屬性：

在「於稽核記錄失敗」區域，設定為「失敗作業」。
在「稽核檔案數目上限」區域，點選：「最大檔案數目」，在「檔案數目」方塊，輸入：2。
再重新啟用此稽核。或是，執行以下的範例程式碼。請參考下圖所示：
-- 01_停用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = OFF); 
GO 
-- 02_在「於稽核記錄失敗」參數，設定為「失敗作業」 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH(    ON_FAILURE = FAIL_OPERATION) 
GO 
-- 03_設定「最大檔案數目」的數量為：2 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    TO FILE (MAX_FILES = 2) 
GO 
-- 04_啟用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = ON); 
GO


步驟 2. 使用「物件總管」，在「稽核」物件：稽核資料庫的異動_UNC上，先停用此「伺服器稽核」，在啟用此「伺服器稽核」，前述的動作，請重複兩次。或是，執行以下的範例程式碼：

-- 01_停用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = OFF); 
GO 
-- 02_啟用此「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
    WITH (STATE = ON); 
GO
範例程式碼9：對伺服器稽核先停用後再度啟用

應該會遭遇到啟用「伺服器稽核」失敗的錯誤訊息，請參考圖14與15，以及下圖所示。

訊息 33222，層級 16，狀態 1，行 1 
稽核 '稽核資料庫的異動_UNC' 無法進行 start。如需詳細資訊，請參閱 SQL Server 錯誤記錄檔。 
您還可以查詢 sys.dm_os_ring_buffers，其中 ring_buffer_type = 'RING_BUFFER_XE_LOG'。

我們在「伺服器稽核」上，在「稽核檔案數目上限」區域，特別設定其「最大檔案數目」為：2。

再多次的先停用此「伺服器稽核」與啟用此「伺服器稽核」。因為每次啟用「伺服器稽核」，系統就會自動產生一份新的稽核目標檔案，如此作法，就會超過當初在稽核檔案數目上所設定的上限值，導致無法啟用此「伺服器稽核」。

步驟 3. 使用「物件總管」，先停用後刪除此「伺服器稽核」以及其「伺服器稽核規格」。或是，執行以下的範例程式碼：

-- 01_停用以及刪除「伺服器稽核」：稽核資料庫的異動_UNC 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audits WHERE name = N'稽核資料庫的異動_UNC') 
BEGIN 
    ALTER SERVER AUDIT [稽核資料庫的異動_UNC] 
        WITH (STATE = OFF) 
    DROP SERVER AUDIT [稽核資料庫的異動_UNC] 
END 
GO 
-- 02_停用以及刪除「伺服器稽核規格」：監視每當發生建立、改變或卸除任何資料庫的事件 
IF  EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = N'監視每當發生建立、改變或卸除任何資料庫的事件') 
BEGIN 
    ALTER SERVER AUDIT SPECIFICATION [監視每當發生建立、改變或卸除任何資料庫的事件] 
        WITH (STATE = OFF) 
    DROP SERVER AUDIT SPECIFICATION [監視每當發生建立、改變或卸除任何資料庫的事件] 
END 
GO
範例程式碼10：對伺服器稽核與伺服器稽核規格分別執行：停用及刪除


#>}

#-------------------------------------------------------------------
#  39   2575     實作練習二：認識對稽核記錄檔案的篩選
#-------------------------------------------------------------------
http://blogs.uuu.com.tw/Articles/post/2012/10/03/%E6%96%B0%E6%89%8B%E5%AD%B8SQL-Server-2012%E7%A8%BD%E6%A0%B8SQL-Server-Audit%E6%96%B0%E5%A2%9E%E5%BC%B7%E7%9A%84%E5%8A%9F%E8%83%BD(2).aspx


2585 任務一：建立伺服器稽核與加入WHERE子句
2641 任務二：建立伺服器稽核規格
2677 任務三：測試備份資料庫與檢視稽核記錄


{<#
準備工作

請事先在本機伺服器上建立以下的資料夾： 

C:\myAdmin\Device。
C:\myAdmin\Audit_Logs。

 

步驟 1. 使用SSMS管理工具，建立「伺服器稽核」，在「建立稽核」視窗，設定以下的屬性： 

「伺服器稽核」命名為：稽核備份或還原資料庫作業。
點選左邊窗格的「篩選」，右邊窗格，輸入WHERE子句：database_name = 'Northwind'。
請參考下圖所示，或是，執行以下的範例程式碼：

若要篩選稽核記錄的內容，能夠使用的資料行名稱是英文名稱，可以藉由執行sys.fn_get_audit_file系統預存函數來查詢可以使用哪些資料行的名稱。

-- 01_建立「伺服器稽核」：稽核備份或還原資料庫作業，WHERE子句篩選式：Northwind 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audits WHERE name = N'稽核備份或還原資料庫作業') 
    BEGIN 
        ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
            WITH (STATE = OFF); 
        DROP SERVER AUDIT [稽核備份或還原資料庫作業] 
    END 
GO 
CREATE SERVER AUDIT [稽核備份或還原資料庫作業] 
TO FILE 
(    FILEPATH = N'C:\myAdmin\Audit_Logs' 
    ,MAXSIZE = 0 MB 
    ,MAX_ROLLOVER_FILES = 2147483647 
    ,RESERVE_DISK_SPACE = OFF ) 
WITH 
(    QUEUE_DELAY = 1000 
    ,ON_FAILURE = CONTINUE ) 
WHERE    database_name = 'Northwind' -- WHERE子句篩選式：Northwind 
GO 
-- 02_啟用此「伺服器稽核」：稽核備份或還原資料庫作業 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    WITH (STATE = ON); 
GO 
-- 03_使用sys.dm_server_audit_status動態管理檢視，檢視「伺服器稽核」SQL Server Audit的狀態 
SELECT audit_id N'稽核的識別碼', name N'稽核的名稱', status_desc N'伺服器稽核狀態', 
    status_time N'上一次狀態變更的時間戳記', audit_file_size N'稽核檔案大小(KB)', 
    audit_file_path N'稽核檔案目標的完整路徑名稱',* 
FROM sys.dm_server_audit_status; 
GO 
-- 04_使用sys.server_audits目錄檢視，檢視「伺服器稽核」物件的目前狀態，包含：WHERE子句篩選式 
SELECT name N'稽核', type_desc N'稽核類型',  on_failure_desc N'寫入動作失敗時', 
    predicate N'述詞運算式', is_state_enabled N'啟用', queue_delay N'寫入磁碟前等候時間(毫秒)', 
    create_date N'建立日期時間', modify_date '修改日期時間' 
FROM sys.server_audits 
GO


2641 任務二：建立伺服器稽核規格
步驟 1. 使用「物件總管」，建立「伺服器稽核規格」，在「建立伺服器稽核規格」視窗，輸入以下的參數： 

將「伺服器稽核規格」命名為：監視每當執行備份或是還原資料庫的事件。
在「稽核動作群組類型」部分，選擇：BACKUP_RESTORE_GROUP。
在伺服器層級的稽核動作群組上，使用的是：BACKUP_RESTORE_GROUP，這是指每當發出執行備份或是還原資料庫命令時，就會引發這個事件。 
或是，執行以下的範例程式碼：

-- 01_建立「伺服器稽核規格」：監視每當執行備份或是還原資料庫的事件 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = N'監視每當執行備份或是還原資料庫的事件') 
    BEGIN 
        ALTER SERVER AUDIT SPECIFICATION [監視每當執行備份或是還原資料庫的事件] 
            WITH (STATE = OFF); 
        DROP SERVER AUDIT SPECIFICATION [監視每當執行備份或是還原資料庫的事件] 
END 
GO 
CREATE SERVER AUDIT SPECIFICATION [監視每當執行備份或是還原資料庫的事件] 
    FOR SERVER AUDIT [稽核備份或還原資料庫作業] 
    ADD (BACKUP_RESTORE_GROUP) 
GO 
-- 02_啟用此「伺服器稽核規格」：監視每當執行備份或是還原資料庫的事件 
ALTER SERVER AUDIT SPECIFICATION [監視每當執行備份或是還原資料庫的事件] 
    WITH (STATE = ON); 
GO 
-- 03_檢視「伺服器稽核規格」物件 
SELECT name N'伺服器稽核規格', is_state_enabled N'是否已啟用', 
    create_date N'建立日期時間', modify_date N'修改日期時間' 
FROM sys.server_audit_specifications 
GO

範例程式碼12：建立與啟用伺服器稽核規格：監視每當執行備份或是還原資料庫的事件


2677 任務三：測試備份資料庫與檢視稽核記錄
步驟 1. 使用SSMS管理工具，對pubs、Northwind、master以及msdb等資料庫執行備份作業。或是，執行以下的範例程式碼：

-- 備份資料庫：pubs、Northwind、master以及msdb 
USE master 
GO 
BACKUP DATABASE [pubs] 
    TO  DISK = N'C:\myAdmin\Device\pubs.bak' 
    WITH FORMAT,  NAME = N'pubs-完整 資料庫 備份', COMPRESSION 
GO 
BACKUP DATABASE [Northwind] 
    TO  DISK = N'C:\myAdmin\Device\Northwind.bak' 
    WITH FORMAT,  NAME = N'Northwind-完整 資料庫 備份', COMPRESSION 
GO 
BACKUP DATABASE [master] 
    TO  DISK = N'C:\myAdmin\Device\master.bak' 
    WITH FORMAT,  NAME = N'master-完整 資料庫 備份', COMPRESSION 
GO 
BACKUP DATABASE [msdb] 
    TO  DISK = N'C:\myAdmin\Device\msdb.bak' 
    WITH FORMAT,  NAME = N'msdb-完整 資料庫 備份', COMPRESSION 
GO

範例程式碼13：備份資料庫pubs、Northwind、master以及msdb

步驟 2. 再重複執行步驟1的動作。 
步驟 3. 檢查此稽核的稽核記錄，應該僅能看到Northwind資料庫的備份稽核記錄，卻無法看到其他資料庫的備份稽核記錄，這是因為我們先前在「伺服器稽核」上加入了WHERE字句僅篩選了此資料庫。

步驟 4. 先停用「伺服器稽核」：稽核備份或還原資料庫作業，修改此「伺服器稽核」，設定以下的屬性： 

點選左邊窗格的「篩選」，右邊窗格，輸入WHERE子句：database_name = 'Northwind' OR database_name =  'pubs'。請參考下圖所示：

完成後，再度啟用此「伺服器稽核」。或是，執行以下的範例程式碼：

-- 01_停用此「伺服器稽核」：稽核備份或還原資料庫作業 
USE master 
GO 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    WITH (STATE = OFF); 
GO 
-- 02_修改WHERE子句篩選式，包含：Northwind與pubs資料庫 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    WHERE database_name = 'Northwind' OR database_name =  'pubs' 
GO 
-- 03_啟用此「伺服器稽核」：稽核備份或還原資料庫作業 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    WITH (STATE = ON); 
GO
範例程式碼14：修改伺服器稽核的WHERE子句篩選式，包含：Northwind與pubs資料庫

在範例程式碼14中，經過測試好像不能使用IN邏輯運算子。

步驟 5. 再重複執行步驟1的動作。檢查此稽核的稽核記錄，已經可以看到Northwind以及pubs資料庫的備份稽核記錄，卻無法看到其他資料庫的備份稽核記錄，這是因為我們先前在「伺服器稽核」上修改了WHERE字句，加入篩選了這兩個資料庫。請參考下圖所示：

步驟 6. 先停用「伺服器稽核」：稽核備份或還原資料庫作業，移除「篩選」窗格的內容，再度啟用此「伺服器稽核」。或是，執行以下的範例程式碼：

-- 01_停用此「伺服器稽核」：稽核備份或還原資料庫作業 
USE master 
GO 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    WITH (STATE = OFF); 
GO 
-- 02_移除WHERE子句篩選式 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    REMOVE WHERE; 
GO 
-- 03_啟用此「伺服器稽核」：稽核備份或還原資料庫作業 
ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
    WITH (STATE = ON); 
GO
範例程式碼15：移除WHERE子句篩選式

步驟 7. 再重複執行步驟1的動作。檢查此稽核的稽核記錄。應該可以看記錄了每個資料庫的備份稽核記錄。 
步驟 8. 停用以及刪除「伺服器稽核」與「伺服器稽核規格」。或是，執行以下的範例程式碼：

-- 01_停用以及刪除「伺服器稽核」：稽核備份或還原資料庫作業 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audits WHERE name = N'稽核備份或還原資料庫作業') 
BEGIN 
    ALTER SERVER AUDIT [稽核備份或還原資料庫作業] 
        WITH (STATE = OFF) 
    DROP SERVER AUDIT [稽核備份或還原資料庫作業] 
END 
GO 
-- 02_停用以及刪除「伺服器稽核規格」：監視每當發生建立、改變或卸除任何資料庫的事件 
IF  EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = N'監視每當執行備份或是還原資料庫的事件') 
BEGIN 
    ALTER SERVER AUDIT SPECIFICATION [監視每當執行備份或是還原資料庫的事件] 
        WITH (STATE = OFF) 
    DROP SERVER AUDIT SPECIFICATION [監視每當執行備份或是還原資料庫的事件] 
END 
GO

範例程式碼16：停用及刪除：對伺服器稽核與伺服器稽核規格分別執行

#>}


#-------------------------------------------------------------------
#  40   2778     實作練習三：認識使用者定義稽核群組
#-------------------------------------------------------------------
2791 任務一：建立伺服器稽核
2837 任務二：建立伺服器稽核規格
2872 任務三：測試觸發使用者定義稽核群組與檢視稽核記錄

{<#
在SQL Server 2012版本上新增加了「使用者定義稽核群組」，讓你可以自行在指定的層級上設定所需的稽核群組，所包含了兩個層級，分別是：「伺服器稽核規格」或是「資料庫稽核規格」。

在設計好「使用者定義稽核群組」後，再利用sp_audit_write系統預存程序於指定的情況時執行，此系統預存程序可以將使用者所定義的稽核事件傳遞觸發到此「使用者定義稽核群組」上。

由於是讓使用者可以設計所需的稽核事件，傳送的資料也都可以自訂。所以，在稽核目標記錄上，額外提供了T-SQL堆疊(Stack) 框架資訊以及與動作相關聯的T-SQL堆疊資訊，這是以XML格式顯示，一樣可以使用sys.fn_get_audit_file系統預存函數來查詢。


2791 任務一：建立伺服器稽核
步驟 1. 使用SSMS管理工具，建立「伺服器稽核」，在「建立稽核」視窗，設定以下的屬性： 

「伺服器稽核」命名為：稽核使用者定義稽核群組。
或是，執行以下的範例程式碼：

-- 01_建立「伺服器稽核」：稽核使用者定義稽核群組 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audits WHERE name = N'稽核使用者定義稽核群組') 
    BEGIN 
        ALTER SERVER AUDIT [稽核使用者定義稽核群組] 
            WITH (STATE = OFF); 
        DROP SERVER AUDIT [稽核使用者定義稽核群組] 
    END 
GO 
CREATE SERVER AUDIT [稽核使用者定義稽核群組] 
TO FILE 
(    FILEPATH = N'C:\myAdmin\Audit_Logs' 
    ,MAXSIZE = 0 MB 
    ,MAX_ROLLOVER_FILES = 2147483647 
    ,RESERVE_DISK_SPACE = OFF ) 
WITH 
(    QUEUE_DELAY = 1000 
    ,ON_FAILURE = CONTINUE ) 
GO 
-- 02_啟用此「伺服器稽核」：稽核使用者定義稽核群組 
ALTER SERVER AUDIT [稽核使用者定義稽核群組] 
    WITH (STATE = ON); 
GO 
-- 03_使用sys.dm_server_audit_status動態管理檢視，檢視「伺服器稽核」SQL Server Audit的狀態 
SELECT audit_id N'稽核的識別碼', name N'稽核的名稱', status_desc N'伺服器稽核狀態', 
    status_time N'上一次狀態變更的時間戳記', audit_file_size N'稽核檔案大小(KB)', 
    audit_file_path N'稽核檔案目標的完整路徑名稱',* 
FROM sys.dm_server_audit_status; 
GO 
-- 04_使用sys.server_audits目錄檢視，檢視「伺服器稽核」物件的目前狀態，包含：WHERE子句篩選式 
SELECT name N'稽核', type_desc N'稽核類型',  on_failure_desc N'寫入動作失敗時', 
    predicate N'述詞運算式', is_state_enabled N'啟用', queue_delay N'寫入磁碟前等候時間(毫秒)', 
    create_date N'建立日期時間', modify_date '修改日期時間' 
FROM sys.server_audits 
GO

範例程式碼17：建立與啟用伺服器稽核：稽核使用者定義稽核群組

2837 任務二：建立伺服器稽核規格
步驟 1. 使用「物件總管」，建立「伺服器稽核規格」，在「建立伺服器稽核規格」視窗，輸入以下的參數：

將「伺服器稽核規格」命名為：監視sp_audit_write所引發的事件。
在「稽核動作群組類型」部分，選擇：USER_DEFINED_AUDIT_GROUP。
在伺服器層級的稽核動作群組上，使用的是：USER_DEFINED_AUDIT_GROUP，這是指每當執行sp_audit_write系統預存程序時，就會引發這個事件。請參考下圖所示：2791 
或是，執行以下的範例程式碼：

-- 01_建立「伺服器稽核規格」：監視sp_audit_write所引發的事件 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = N'監視sp_audit_write所引發的事件') 
    BEGIN 
        ALTER SERVER AUDIT SPECIFICATION [監視sp_audit_write所引發的事件] 
            WITH (STATE = OFF); 
        DROP SERVER AUDIT SPECIFICATION [監視sp_audit_write所引發的事件] 
END 
GO 
CREATE SERVER AUDIT SPECIFICATION [監視sp_audit_write所引發的事件] 
    FOR SERVER AUDIT [稽核使用者定義稽核群組] 
    ADD (USER_DEFINED_AUDIT_GROUP) 
GO 
-- 02_啟用此「伺服器稽核規格」：監視sp_audit_write所引發的事件 
ALTER SERVER AUDIT SPECIFICATION [監視sp_audit_write所引發的事件] 
    WITH (STATE = ON); 
GO 
-- 03_檢視「伺服器稽核規格」物件 
SELECT name N'伺服器稽核規格', is_state_enabled N'是否已啟用', 
    create_date N'建立日期時間', modify_date N'修改日期時間' 
FROM sys.server_audit_specifications 
GO

範例程式碼18：建立與啟用伺服器稽核規格：監視sp_audit_write所引發的事件

2872 任務三：測試觸發使用者定義稽核群組與檢視稽核記錄

步驟 1. 執行以下的範例程式碼來建立巢狀式呼叫的使用者預存程序：

-- 01_建立使用者預存程序：nest1 
USE tempdb 
GO 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nest1]') AND type in (N'P', N'PC')) 
    DROP PROCEDURE [dbo].[nest1] 
GO 
CREATE PROCEDURE nest1 
AS 
    DECLARE @nestlevel nvarchar(19) 
    SET @nestlevel =N'存取被監控的物件，巢狀層級：'+CAST(@@NESTLEVEL AS nvarchar(10)) 
    SELECT @nestlevel 
    EXEC sp_audit_write 
        @user_defined_event_id = 11, @succeeded =  0 , @user_defined_information = @nestlevel; 
GO 
-- 02_建立使用者預存程序：nest2 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nest2]') AND type in (N'P', N'PC')) 
    DROP PROCEDURE [dbo].[nest2] 
GO 
CREATE PROCEDURE nest2 
AS 
    DECLARE @nestlevel nvarchar(19) 
    SET @nestlevel =N'存取被監控的物件，巢狀層級：'+CAST(@@NESTLEVEL AS nvarchar(10)) 
    SELECT @nestlevel 
    EXEC sp_audit_write 
        @user_defined_event_id = 12, @succeeded =  0 , @user_defined_information = @nestlevel; 
    EXEC nest1 
GO
範例程式碼19：建立巢狀式呼叫使用者預存程序

在範例程式碼19中，我們建立了兩個使用者預存程序：nest1與nest2。在nest2使用者預存程序內，會再執行nest2使用者預存程序，形成所謂的巢狀式呼叫使用者預存程序。

在nest1與nest2使用者預存程序中，都呼叫執行了sp_audit_write系統預存程序，以下是其使用的參數之說明：

@user_defined_event_id：由使用者定義並且記錄在稽核記錄之 user_defined_event_id 資料行中的參數，其使用的資料類型是smallint。
@succeeded：由使用者傳遞的參數，用於指出事件是否成功。這會顯示在稽核記錄的succeeded資料行中，其使用的資料類型是bit。
@user_defined_information：由使用者自行定義所要記錄的訊息。這會顯示在稽核記錄的user_defined_information資料行中，其使用的資料類型是nvarchar(4000)。
此系統預存程序也有傳回碼值可以使用，0表示成功，1表示失敗，若發生輸入參數錯誤，或是無法寫入目標稽核記錄都會造成失敗。

在此範例程式中，我們在@user_defined_information參數內，搭配使用了@@NESTLEVEL組態函數，來傳回本機伺服器中執行目前預存程序的巢狀層級(最初值是0)。

步驟 2. 執行以下的範例程式碼來執行先前建立的使用者預存程序，請參考下圖來檢視其執行結果：

-- 01_執行巢狀式呼叫預存程序：nest2 
USE tempdb 
GO 
EXEC nest2 
GO 
-- 02_直接執行系統預存程序：sp_audit_write 
EXEC sp_audit_write 
    @user_defined_event_id =  88 , @succeeded =  0 , 
    @user_defined_information = N'直接執行系統預存程序：sp_audit_write' ; 
GO

在圖28中，可以觀察到由@@NESTLEVEL組態函數，所傳回本機伺服器中執行目前預存程序的巢狀層級。

步驟 3. 檢視「伺服器稽核」的稽核目標記錄，或是，執行以下的範例程式碼，請參考下圖所示：

-- 01_使用fn_get_audit_file系統安全函數來檢視稽核檔案的內容 
-- 移轉為伺服器所在地時區，增加資料行：additional_information、user_defined_event_id、user_defined_information 
SELECT SWITCHOFFSET (CAST(event_time AS datetimeoffset), datepart(TZoffset,sysdatetimeoffset())) N'引發時的日期時間(伺服器所在地時區)', 
    server_principal_name N'登入帳戶', database_principal_name N'資料庫使用者', 
    database_name N'資料庫', object_name N'物件名稱', statement N'TSQL 陳述式', 
    additional_information N'其他資訊', user_defined_event_id N'使用者定義事件識別碼', 
user_defined_information N'使用者定義資訊' 
FROM sys.fn_get_audit_file ('C:\myAdmin\Audit_Logs\*',default,default) 
ORDER BY 1 DESC; 
GO
範例程式碼21：使用fn_get_audit_file系統安全函數查詢使用者定義稽核事件
以下是執行nest2使用者預存程序後，在稽核目標記錄內所產生的資料：

其他資訊：<tsql_stack><frame nest_level = '2' database_name = 'tempdb' schema_name = 'dbo' object_name = 'nest2'/></tsql_stack> 
使用者定義事件識別碼：12 
使用者定義資訊：存取被監控的物件，巢狀層級：1
以下是nest2使用者預存程序呼叫nest1使用者預存程序後，在稽核目標記錄內所產生的資料：

其他資訊：<tsql_stack><frame nest_level = '3' database_name = 'tempdb' schema_name = 'dbo' object_name = 'nest1'/></tsql_stack> 
使用者定義事件識別碼：11 
使用者定義資訊：存取被監控的物件，巢狀層級：2
以下是直接執行sp_audit_write系統預存程序後，在稽核目標記錄內所產生的資料：

其他資訊： 
使用者定義事件識別碼：88 
使用者定義資訊：直接執行系統預存程序：sp_audit_write
在additional_informatio(其他資訊)資料行部分，其輸出的資料格式為XML，請參考如下： 

<tsql_stack><frame nest_level = '%u' database_name = '%.*s' schema_name = '%.*s' object_name = '%.*s' /></tsql_stack>
其中Frame nest_level表示框架的目前巢狀層級。而模組名稱，會以三部分格式表示(database_name、schema_name以及object_name)。如果輸出的模組名稱包含了無效的XML字元，系統在剖析時會自動將這些字元逸出為格式：_xHHHH_，其中HHHH 代表字元的四位數十六進位UCS-2碼。無效的XML字元，例如有：'<'、'>'、'/' 和 '_x'等。

步驟 4. 使用「物件總管」，停用以及刪除「伺服器稽核」以及「伺服器稽核規格」，或是，執行以下的範例程式碼：

-- 01_停用以及刪除「伺服器稽核」：稽核使用者定義稽核群組 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audits WHERE name = N'稽核使用者定義稽核群組') 
    BEGIN 
        ALTER SERVER AUDIT [稽核使用者定義稽核群組] 
            WITH (STATE = OFF); 
        DROP SERVER AUDIT [稽核使用者定義稽核群組] 
    END 
GO 
-- 02_停用以及刪除「伺服器稽核規格」：監視sp_audit_write所引發的事件 
USE [master] 
GO 
IF  EXISTS (SELECT * FROM sys.server_audit_specifications WHERE name = N'監視sp_audit_write所引發的事件') 
    BEGIN 
        ALTER SERVER AUDIT SPECIFICATION [監視sp_audit_write所引發的事件] 
            WITH (STATE = OFF); 
        DROP SERVER AUDIT SPECIFICATION [監視sp_audit_write所引發的事件] 
END 
GO

範例程式碼22：停用以及刪除伺服器稽核與伺服器稽核規格

結語
在本期文章中，介紹了調整稽核記錄失敗時的處理、調整稽核檔案數目上限、認識對稽核記錄檔案的篩選以及認識使用者定義稽核群組等主題。


#>}


#========================================================
# Create Database Master Key
#========================================================
#this is equivalent to:
<#
USE TestDB
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD = 'P@ssword'
#>
#create (user) database master key
#if this doesn't exist yet
$dbmk = New-Object Microsoft.SqlServer.Management.Smo.MasterKey -ArgumentList $database
$dbmk.Create("P@ssword")


#========================================================
# Create Asymmetric Key
#========================================================
#this is equivalent to:
<#
USE TestDB
GO
CREATE ASYMMETRIC KEY [EncryptionAsymmetricKey]
AUTHORIZATION [eric]
WITH ALGORITHM = RSA_2048
#>
$asymk = New-Object Microsoft.SqlServer.Management.Smo.AsymmetricKey -ArgumentList $database, "EncryptionAsymmetricKey"
#replace this with a known database user in the
#database you are using for this recipe
$asymk.Owner = "eric"
$asymk.Create([Microsoft.SqlServer.Management.Smo.AsymmetricKeyEncryptionAlgorithm]::Rsa2048)

#========================================================
# Create Symmetric Key
#========================================================
#this is equivalent to :
<#
CREATE CERTIFICATE [Encryption]
WITH SUBJECT = N'This is a test certificate.',
START_DATE = N'02/10/2012',
EXPIRY_DATE = N'01/01/2015'
#>
#create certificate first to be used for Symmetric Key
$cert = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Certificate -ArgumentList $database, "Encryption"
$cert.StartDate = "February 10, 2012"
$cert.Subject = "This is a test certificate."
$cert.ExpirationDate = "January 01, 2015"
$cert.Create()
#create a symmetric key based on certificate
#this is equivalent to :

<#
CREATE SYMMETRIC KEY [EncryptionSymmetricKey]
WITH ALGORITHM = TRIPLE_DES
ENCRYPTION BY CERTIFICATE [Encryption]
#>
$symk = New-Object Microsoft.SqlServer.Management.Smo.SymmetricKey -ArgumentList $database, "EncryptionSymmetricKey"
$symkenc = New-Object Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryption ([Microsoft.SqlServer.Management.Smo.KeyEncryptionType]::Certificate, "Encryption")
$symk.Create($symkenc, [Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionAlgorithm]::TripleDes)
#list each object we created
$dbmk.Parent
$cert.Name
$asymk
$symk

##following T-SQL statement to confirm the existence of the
database master key, certificate, symmetric, and asymmetric keys we created in this recipe:
SELECT 'DB Master Key' ,
is_master_key_encrypted_by_server
FROM sys.databases
WHERE [name] = 'TestDB'
SELECT 'Certificate' , *
FROM sys.certificates
WHERE [name] = 'Encryption'
SELECT 'Asymmetric Key' , *
FROM sys.asymmetric_keys
WHERE [name] = 'EncryptionAsymmetricKey'
SELECT 'Symmetric Key' , *
FROM sys.symmetric_keys
WHERE [name] = 'EncryptionSymmetricKey'