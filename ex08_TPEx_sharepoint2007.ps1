<#

Subject :Tpex SQL alwayson for Moniter System 
CreateDate: OCT.22.2015
filepath :  \\172.18.65.184\c$\PS1\.ps1
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\ex07_TPEx_sharepoint2007.ps1
history : 
. initial  #01 ~ #21


MOSS 
$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\ex07_TPEx_sharepoint2007.ps1

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
##-------------------------------------------------------------
##      15  info
##-------------------------------------------------------------
intranetAP01    172.17.8.21
bq-intranetAP01  172.17.8.21
bq-intranetAP02  172.17.8.22

hostname  #PMD

##-------------------------------------------------------------
##     24   ServerManager 
##-------------------------------------------------------------

get-Module ServerManager
Import-Module ServerManager
Add-WindowsFeature PowerShell-ISE

Set-ExecutionPolicy RemoteSigned
$PSVersionTable
'
PS C:\Users\Administrator> $PSVersionTable

Name                           Value                                                                                                                                       
----                           -----                                                                                                                                       
CLRVersion                     2.0.50727.4927                                                                                                                              
BuildVersion                   6.1.7600.16385                                                                                                                              
PSVersion                      2.0                                                                                                                                         
WSManStackVersion              2.0                                                                                                                                         
PSCompatibleVersions           {1.0, 2.0}                                                                                                                                  
SerializationVersion           1.1.0.1                                                                                                                                     
PSRemotingProtocolVersion      2.1                                                                                                                                         


'


##-------------------------------------------------------------
##   51 join AD 
##-------------------------------------------------------------

bq-intranetAP01   


##-------------------------------------------------------------
##   58 serial key
##-------------------------------------------------------------


sharepoint 2007 key:　F6YVR4XY7KRCVY437FBKG44PY
winodws 2008   GH3BM-2GTCD-JV4X9-M8XJR-TDKXV
SQL 2015        


##-------------------------------------------------------------
##  68 install Sharepoint 2007
##-------------------------------------------------------------

gwmi  Win32_Product  |select name,Version |ft -auto

(gwmi  Win32_Product).count # 23
'
PS C:\Users\Administrator> gwmi  Win32_Product  |select name,Version |ft -auto


name                                                                               Version       
----                                                                               -------       
Microsoft Office Shared Coms Chinese (Traditional) Language Pack                   12.0.6425.1000
Microsoft Office Document Lifecycle Components Chinese (Traditional) Language Pack 12.0.6425.1000
Microsoft Office Slide Library Chinese (Traditional) Language Pack                 12.0.6425.1000
Microsoft Windows SharePoint Services 3.0                                          12.0.6425.1000
Microsoft Windows SharePoint Services 3.0 1028 Lang Pack                           12.0.6425.1000
Microsoft Office Excel Services                                                    12.0.6425.1000
Microsoft Office Excel Services Web Front End Components                           12.0.6425.1000
Microsoft Office InfoPath Forms Services                                           12.0.6425.1000
Microsoft Office Document Lifecycle Components                                     12.0.6425.1000
Microsoft Office Slide Library                                                     12.0.6425.1000
Microsoft Office InfoPath Form Services Chinese (Traditional) Language Pack        12.0.6425.1000
Microsoft Office Excel Services Chinese (Traditional) Language Pack                12.0.6425.1000
Microsoft Office SharePoint Portal                                                 12.0.4518.1016
Microsoft Office Document Lifecycle Application Server Components                  12.0.6425.1000
Microsoft Search Front End                                                         12.0.6425.1000
Microsoft Office Search Server                                                     12.0.4518.1016
Microsoft Office SharePoint Server 2007                                            12.0.6425.1000
Microsoft Search Chinese (Traditional) Language Pack                               12.0.6425.1000
Microsoft Office SharePoint Portal Chinese (Traditional) Language Pack             12.0.6425.1000
Microsoft Office Shared Components                                                 12.0.6425.1000
Google Update Helper                                                               1.3.28.15     
Microsoft SQL Server 2005 Analysis Services ADOMD.NET                              9.00.1399.06  
Microsoft Report Viewer Redistributable 2005                                       8.0.50727.42  
'

##-------------------------------------------------------------
##   106 install SQL 2005
##-------------------------------------------------------------

C:\temp\SQL2005\CD1\Setup.exe
SQL Server Database services
chinese_Taiwan_Stroke

gwmi  Win32_Product  |select name,Version |ft -auto
'
PS C:\Users\Administrator> gwmi  Win32_Product  |select name,Version |ft -auto


name                                                                               Version       
----                                                                               -------       
Microsoft Office Shared Coms Chinese (Traditional) Language Pack                   12.0.6425.1000
Microsoft Office Document Lifecycle Components Chinese (Traditional) Language Pack 12.0.6425.1000
Microsoft Office Slide Library Chinese (Traditional) Language Pack                 12.0.6425.1000
Microsoft Windows SharePoint Services 3.0                                          12.0.6425.1000
Microsoft Windows SharePoint Services 3.0 1028 Lang Pack                           12.0.6425.1000
Microsoft Office Excel Services                                                    12.0.6425.1000
Microsoft Office Excel Services Web Front End Components                           12.0.6425.1000
Microsoft Office InfoPath Forms Services                                           12.0.6425.1000
Microsoft Office Document Lifecycle Components                                     12.0.6425.1000
Microsoft Office Slide Library                                                     12.0.6425.1000
Microsoft Office InfoPath Form Services Chinese (Traditional) Language Pack        12.0.6425.1000
Microsoft Office Excel Services Chinese (Traditional) Language Pack                12.0.6425.1000
Microsoft Office SharePoint Portal                                                 12.0.4518.1016
Microsoft Office Document Lifecycle Application Server Components                  12.0.6425.1000
Microsoft Search Front End                                                         12.0.6425.1000
Microsoft Office Search Server                                                     12.0.4518.1016
Microsoft Office SharePoint Server 2007                                            12.0.6425.1000
Microsoft Search Chinese (Traditional) Language Pack                               12.0.6425.1000
Microsoft Office SharePoint Portal Chinese (Traditional) Language Pack             12.0.6425.1000
Microsoft Office Shared Components                                                 12.0.6425.1000
Microsoft Office 2003 Web Components                                               11.0.6558.0   
Microsoft SQL Server VSS Writer                                                    9.00.1399.06  
Microsoft SQL Server 2005                                                          9.00.1399.06  
Google Update Helper                                                               1.3.28.15     
Microsoft SQL Server 2005 回溯相容性                                                    8.05.1054     
Microsoft SQL Server Native Client                                                 9.00.1399.06  
Microsoft SQL Server 2005 Analysis Services ADOMD.NET                              9.00.1399.06  
Microsoft Report Viewer Redistributable 2005                                       8.0.50727.42  
Microsoft SQL Server 安裝程式支援檔案 (英文)                                          9.00.1399.06 
'

C:\temp\SQL2005\CD1\Setup.exe  instlall management  tools

SqlWb

gwmi  Win32_Product  |select name,Version |ft -auto
(gwmi  Win32_Product).count # 32
'
PS C:\Users\Administrator> gwmi  Win32_Product  |select name,Version |ft -auto

name                                                                               Version       
----                                                                               -------       
Microsoft Office Shared Coms Chinese (Traditional) Language Pack                   12.0.6425.1000
Microsoft Office Document Lifecycle Components Chinese (Traditional) Language Pack 12.0.6425.1000
Microsoft Office Slide Library Chinese (Traditional) Language Pack                 12.0.6425.1000
Microsoft Windows SharePoint Services 3.0                                          12.0.6425.1000
Microsoft Windows SharePoint Services 3.0 1028 Lang Pack                           12.0.6425.1000
Microsoft Office Excel Services                                                    12.0.6425.1000
Microsoft Office Excel Services Web Front End Components                           12.0.6425.1000
Microsoft Office InfoPath Forms Services                                           12.0.6425.1000
Microsoft Office Document Lifecycle Components                                     12.0.6425.1000
Microsoft Office Slide Library                                                     12.0.6425.1000
Microsoft Office InfoPath Form Services Chinese (Traditional) Language Pack        12.0.6425.1000
Microsoft Office Excel Services Chinese (Traditional) Language Pack                12.0.6425.1000
Microsoft Office SharePoint Portal                                                 12.0.4518.1016
Microsoft Office Document Lifecycle Application Server Components                  12.0.6425.1000
Microsoft Search Front End                                                         12.0.6425.1000
Microsoft Office Search Server                                                     12.0.4518.1016
Microsoft Office SharePoint Server 2007                                            12.0.6425.1000
Microsoft Search Chinese (Traditional) Language Pack                               12.0.6425.1000
Microsoft Office SharePoint Portal Chinese (Traditional) Language Pack             12.0.6425.1000
Microsoft Office Shared Components                                                 12.0.6425.1000
Microsoft Visual Studio 2005 Premier Partner 版 - 繁體中文                              8.0.50727.42  
Microsoft Office 2003 Web Components                                               11.0.6558.0   
Microsoft SQL Server VSS Writer                                                    9.00.1399.06  
Microsoft SQL Server 2005                                                          9.00.1399.06  
Microsoft SQL Server 2005 Tools                                                    9.00.1399.06  
SQLXML4                                                                            9.00.1399.06  
Google Update Helper                                                               1.3.28.15     
Microsoft SQL Server 2005 回溯相容性                                                    8.05.1054     
Microsoft SQL Server Native Client                                                 9.00.1399.06  
Microsoft SQL Server 2005 Analysis Services ADOMD.NET                              9.00.1399.06  
Microsoft Report Viewer Redistributable 2005                                       8.0.50727.42  
Microsoft SQL Server 安裝程式支援檔案 (英文)                                                 9.00.1399.06  '


##-------------------------------------------------------------
##   
##-------------------------------------------------------------
enable : powershell_ise 

gwmi -class Win32_OperatingSystem -computername $env:COMPUTERNAME |select  Caption,OSArchitecture  #
'Microsoft Windows Server 2008 R2 Enterprise                                           64-bit   '

gwmi  Win32_Product  |select name,Version,Caption
appwiz.cpl
''

foreach($sProperty in $sOS)
{
   write-host $sProperty.Description
   write-host $sProperty.Caption
   write-host $sProperty.OSArchitecture
   write-host $sProperty.ServicePackMajorVersion
}


##-------------------------------------------------------------
##   218  create sql alias  cliconfg
##-------------------------------------------------------------


# SQL Server client alias
$AliasName = "SPFarmSQL"


#These are the two Registry locations for the SQL Alias locations
$x86 = "HKLM:\Software\Microsoft\MSSQLServer\Client\ConnectTo"
$x64 = "HKLM:\Software\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo"


#We're going to see if the ConnectTo key already exists, and create it if it doesn't.
if ((test-path -path $x86) -ne $True)
{
    write-host "$x86 doesn't exist"
    New-Item $x86
}
if ((test-path -path $x64) -ne $True)
{
    write-host "$x64 doesn't exist"
    New-Item $x64
}
  
$ServerName = $env:computername+'\SSDE'
#Adding the extra "fluff" to tell the machine what type of alias it is
$TCPAlias = ("DBMSSOCN," + $ServerName)
  
#Creating our TCP/IP Aliases
New-ItemProperty -Path $x86 -Name $AliasName -PropertyType String -Value $TCPAlias
New-ItemProperty -Path $x64 -Name $AliasName -PropertyType String -Value $TCPAlias
 
# Open cliconfig to verify the aliases
Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

#check 5.1
Invoke-Sqlcmd -Query "SELECT @@servername as hostname "  -ServerInstance "$AliasName" #-Database $dbName



##-------------------------------------------------------------
##      sql mirroring
##-------------------------------------------------------------

backup database [SSPSvc1-IndexDB]    to disk='D:\2011\SSPSvc1-IndexDB.bak'
backup database [SSPSvc1-SearchDB]   to disk='D:\2011\SSPSvc1-SearchDB.bak'
backup database [SSPWA_ContentDB]    to disk='D:\2011\SSPWA_ContentDB.bak'



1.	On the principal server, create a certificate and open a port for mirroring.
--On master database, create the database Master Key, if needed
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<test1234->';
GO
-- Make a certificate for this server instance.
USE master;
CREATE CERTIFICATE <MASTER_HostA_cert> 
   WITH SUBJECT = '<Master_HostA certificate>';
GO
--Create mirroring endpoint for server instance using the certificate
CREATE ENDPOINT Endpoint_Mirroring
   STATE = STARTED
   AS TCP (
      LISTENER_PORT=5024
      , LISTENER_IP = ALL
   ) 
   FOR DATABASE_MIRRORING ( 
      AUTHENTICATION = CERTIFICATE <MASTER_HostA_cert>
      , ENCRYPTION = REQUIRED ALGORITHM RC4
      , ROLE = ALL
   );
GO
2.	On the principal server, back up the certificate.
--Back up HOST_A certificate.
BACKUP CERTIFICATE MASTER_HostA_cert TO FILE = '<c:\MASTER_HostA_cert.cer>';
GO


3.	On the principal server, back up the database. This example uses the configuration database. Repeat for all databases.
USE master;
--Ensure that SharePoint_Config uses the full recovery model.
ALTER DATABASE SharePoint_Config
   SET RECOVERY FULL;
GO
USE SharePoint_Config
BACKUP DATABASE SharePoint_Config 
    TO DISK = '<c:\SharePoint_Config.bak>' 
    WITH FORMAT
GO
BACKUP Log SharePoint_Config 
    TO DISK = '<c:\SharePoint_Config_log.bak>' 
    WITH FORMAT
GO


4.	Copy the backup file to the mirror server. Repeat for all databases.
5.	By using any secure copy method, copy the backup certificate file (C:\HOST_HostA_cert.cer, for example) to the mirror and witness servers. 
Set up the mirror server for outbound connections
1.	On the mirror server, create a certificate and open a port for mirroring.
--On master database, create the database Master Key, if needed.
USE master;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<1234-test>';
GO
-- Make a certificate on the HOST_B server instance.
CREATE CERTIFICATE <HOST_HostB>
   WITH SUBJECT = '<HOST_HostB certificate for database mirroring>';
GO
--Create a mirroring endpoint for the server instance on HOST_B.
CREATE ENDPOINT Endpoint_Mirroring
   STATE = STARTED
   AS TCP (
      LISTENER_PORT=5024
      , LISTENER_IP = ALL
   ) 
   FOR DATABASE_MIRRORING ( 
      AUTHENTICATION = CERTIFICATE <HOST_HostB>
      , ENCRYPTION = REQUIRED ALGORITHM RC4
      , ROLE = ALL
   );
GO
2.	On the mirror server, back up the certificate.
--Back up HOST_B certificate.
BACKUP CERTIFICATE <HOST_HostB> TO FILE = '<C:\HOST_HostB_cert.cer>';
GO 

3.	By using any secure copy method, copy the backup certificate file (C:\HOST_HostB_cert.cer, for example) to the principal and witness servers. 
4.	On the mirror server, restore the database from the backup files. This example uses the configuration database. Repeat for all databases.
RESTORE DATABASE SharePoint_Config 
    FROM DISK = '<c:\SharePoint_Config.bak>' 
    WITH NORECOVERY
GO
RESTORE log SharePoint_Config 
FROM DISK = '<c:\SharePoint_Config_log.bak>' 
WITH NORECOVERY
GO
Set up the mirror server for inbound connections
On the mirror server, create a login and user for the principal server, associate the certificate with the user, and grant the login connect permissions for the partnership.
--Create a login on HOST_B for HOST_A
USE master;
CREATE LOGIN <MASTER_HostA_login> WITH PASSWORD = '<test1234->';
GO
--Create a user for that login.
CREATE USER <MASTER_HostA_user> FOR LOGIN <MASTER_HostA_login>;
GO
--Associate the certificate with the user
CREATE CERTIFICATE <MASTER_HostA_cert>
   AUTHORIZATION <MASTER_HostA_user>
   FROM FILE = '<c:\MASTER_HostA_cert.cer>' --do not try to use a network path, SQL Server will give an error about the key not being valid
GO
--Grant CONNECT permission on the login for the remote mirroring endpoint.
GRANT CONNECT ON ENDPOINT::Endpoint_Mirroring TO [<MASTER_HostA_login>];
GO

Set up the principal server for inbound connections
On the principal server, create a login and user for the mirror server, associate the certificate with the user, and grant the login connect permissions for the partnership.
--Create a login on HOST_A for HOST_B
USE master;
CREATE LOGIN <HOST_HostB_login> WITH PASSWORD = '<1234-test>';
GO
--Create a user for that login.
CREATE USER <HOST_HostB_user> FOR LOGIN <HOST_HostB_login>;
GO
--Associate the certificate with the user
CREATE CERTIFICATE <HOST_HostB_cert>
   AUTHORIZATION <HOST_HostB_user>
   FROM FILE = '<c:\HOST_HostB_cert.cer>' --do not try to use a network path, SQL Server will give an error about the key not being valid
GO
--Grant CONNECT permission on the login for the remote mirroring endpoint.
GRANT CONNECT ON ENDPOINT::Endpoint_Mirroring TO [<HOST_HostB_login>];
GO


Set up the Mirroring Partners
1.	On the mirror server, set up the mirroring partnership. This example uses the configuration database. Repeat for all databases. 
Note: You must use the format TCP :// < system-address> : < port> to specify the address of the partner server that you are configuring. For more information, see Specifying a Server Network Address (Database Mirroring) (http://go.microsoft.com/fwlink/?LinkId=116405&clcid=0x409).
--At HOST_B, set server instance on HOST_A as partner (principal server):
ALTER DATABASE SharePoint_Config 
    SET PARTNER = '<TCP://databasemaster.adatum.com:5024>';
GO

2.	On the principal server, set up the mirroring partnership. This example uses the configuration database. Repeat for all databases.
Note: You must use the format TCP :// < system-address> : < port> to specify the address of the partner server that you are configuring. For more information, see Specifying a Server Network Address (Database Mirroring) (http://go.microsoft.com/fwlink/?LinkID=116405&clcid=0x409).
--At HOST_A, set server instance on HOST_B as partner (mirror server).
ALTER DATABASE SharePoint_Config
    SET PARTNER = '<TCP://databasemirror.adatum.com:5024>';
GO

Set up a Witness Server 
Each step lists the server on which it should be performed. Use Transact-SQL to send these commands to SQL Server. Placeholder information is denoted by angle brackets (<>). Replace that content, especially the sample passwords, with information specific to your deployment.
1.	On the witness server, set up the certificate and open the port.
--On master database, create the database Master Key, if needed
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<1234test->';
GO
-- Make a certificate for this server instance.
USE master;
CREATE CERTIFICATE <WITNESS_HostC_cert> 
   WITH SUBJECT = '<Witness_HostC certificate>';
GO
--Create mirroring endpoint for server instance using the certificate
CREATE ENDPOINT Endpoint_Mirroring
   STATE = STARTED
   AS TCP (
      LISTENER_PORT=5024
      , LISTENER_IP = ALL
   ) 
   FOR DATABASE_MIRRORING ( 
      AUTHENTICATION = CERTIFICATE <WITNESS_HostC_cert>
      , ENCRYPTION = REQUIRED ALGORITHM RC4
      , ROLE = ALL
   );
GO

2.	On the witness server, back up the certificate.
--Back up HOST_C certificate 
BACKUP CERTIFICATE <WITNESS_HostC_cert> TO FILE = '<c:\ WITNESS_HostC_cert.cer>';
GO

3.	By using any secure copy method, copy the backup certificate file (C:\WITNESS_HOSTC_cert.cer, for example) to the principal server and the mirror server.
4.	On the witness server, create logins and users for the principal and mirror servers, associate the certificates with the users, and grant the logins connect permissions for the partnership.
--Create a login on Witness HOST_C for Principal HOST_A
USE master;
CREATE LOGIN <MASTER_HostA_login> WITH PASSWORD = '<test1234->';
GO
--Create a user for that login.
CREATE USER <MASTER_HostA_user> FOR LOGIN <MASTER_HostA_login>;
GO
--Associate the certificate with the user
CREATE CERTIFICATE <MASTER_HostA_cert>
   AUTHORIZATION <MASTER_HostA_user>
   FROM FILE = '<c:\MASTER_HostA_cert.cer>' --do not try to use a network path, SQL Server will give an error about the key not being valid
GO
--Grant CONNECT permission on the login for the remote mirroring endpoint.
GRANT CONNECT ON ENDPOINT::Endpoint_Mirroring TO [<MASTER_HostA_login>];
GO
--Create Login for Mirror Host B
CREATE LOGIN <HOST_HostB_login> WITH PASSWORD = '<1234-test>';
GO
--Create a user for that login.
CREATE USER <HOST_HostB_user> FOR LOGIN <HOST_HostB_login>;
GO
--Associate the certificate with the user
CREATE CERTIFICATE <HOST_HostB_cert>
   AUTHORIZATION <HOST_HostB_user>
   FROM FILE = '<c:\HOST_HostB_cert.cer>' --do not try to use a network path, SQL Server will give an error about the key not being valid
GO
--Grant CONNECT permission on the login for the remote mirroring endpoint.
GRANT CONNECT ON ENDPOINT::Endpoint_Mirroring TO [<HOST_HostB_login>];
GO


5.	On the principal server, create a login and user  for the witness server, associate the certificate with the user, and grant the login connect permissions for the partnership. Repeat for the mirror server.
--Create a login on Master HostA for Witness HostC
USE master;
CREATE LOGIN <WITNESS_HostC_login> WITH PASSWORD = '<1234test->';
GO
--Create a user for that login.
CREATE USER <WITNESS_HostC_user> FOR LOGIN <WITNESS_HostC_login>;
GO
--Associate the certificate with the user
CREATE CERTIFICATE <WITNESS_HostC_cert>
   AUTHORIZATION <WITNESS_HostC_user>
   FROM FILE = '<c:\WITNESS_HostC_cert.cer>' --do not try to use a network path, SQL Server will give an error about the key not being valid
GO
--Grant CONNECT permission on the login for the remote mirroring endpoint.
GRANT CONNECT ON ENDPOINT::Endpoint_Mirroring TO [<WITNESS_HostC_login>];
GO


6.	On the principal server, attach the witness server. This example uses the configuration database. Repeat for all databases.
--Setup the Witness Server
ALTER DATABASE SharePoint_Config
    SET WITNESS = 
    '<TCP://databasewitness.adatum.com:5024>'
GO
Transfer permissions to the mirror server
When you set up a mirrored database, the SQL Server logins and permissions for the database to be used with a SharePoint farm are not automatically configured in the master and msdb databases on the mirror. Instead, you must configure the permissions for the required logins. 

We recommend that you transfer your logins and permissions from the principal server to the mirror server by running a script. The script that we recommend that you use is available in Knowledge Base article 918992: How to transfer the logins and the passwords between instances of SQL Server 2005 (http://go.microsoft.com/fwlink/?LinkId=122053&clcid=0x409).



##-------------------------------------------------------------
##      sharepoint point farm
##-------------------------------------------------------------




##-------------------------------------------------------------
##   
##-------------------------------------------------------------

#01##12#############################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2008 enterprise tw, sql 2k5 std , moss 2k8 enterprise
#History    :
#object : Gretai security
#
# cd env:Path 
#
# debug:12

 

write-host "--01-variable-" 
# import-csv
#[Environment]::SetEnvironmentVariable("Path", "$env:path;$env:commonprogramfiles\microsoft shared\web server extensions\12\bin\", "machine")
#[environment]::GetEnvironmentVariable("Path","machine") #get
#[Environment]::SetEnvironmentVariable("Path",$null,"machine") #delete 
# $env:path
$servername=$env:COMPUTERNAME 
$Farm_ConfigurationDatabase="Farm_config"
$dbuser="sa"
$dbpwd="p@ssw0rd"

$installuser="$env:userdomain\$env:USERNAME"
$installuserpwd="p@ssw0rd"
$webapplicatiosadmin="WebappS_admin"
$farmcontactemail="mossadmin@mail.gretai.org.tw"
$centralport="2688"
cd "$env:commonprogramfiles\microsoft shared\web server extensions\12\bin\"


write-host "--02-create db using-"

#$teststring ="psconfig -cmd configdb -create -server $servername -database $Farm_ConfigurationDatabase -dbuser $dbuser -dbpassword $dbpwd -user $installuser -password $installuserpwd -admincontentdatabase $webapplicatiosadmin"
#$teststring
#.\psconfig -help configdb
#.\psconfig  -cmd configdb -disconnect  
#  .\psconfig  -cmd configdb -connect -server $servername -database $Farm_ConfigurationDatabase -dbuser $dbuser -dbpassword $dbpwd -user $installuser -password $installuserpwd

.\psconfig -cmd configdb -create -server $servername -database $Farm_ConfigurationDatabase -dbuser $dbuser -dbpassword $dbpwd -user $installuser -password $installuserpwd -admincontentdatabase $webapplicatiosadmin

 
write-host "--03-config using psconfig-" 
.\PSConfig -cmd helpcollections installall


write-host "--04-config services  using psconfig -"
.\PSConfig -cmd services -install
#stsadm -o spsearch -action start -farmserviceaccount domain\user -farmservicepassword MyPassword
.\stsadm -o spsearch -action start -farmserviceaccount $installuser -farmservicepassword $installuserpwd
#stsadm -o osearch -action start -role IndexQuery -farmserviceaccount domain\user -farmservicepassword MyPassword -farmcontactemail user@domain.com
.\stsadm -o osearch -action start -role IndexQuery -farmserviceaccount $installuser  -farmservicepassword $installuserpwd -farmcontactemail $farmcontactemail
.\psconfig -cmd services -provision

write-host "--05-installfeatures  using psconfig -"
.\PSConfig -cmd installfeatures
.\PSConfig -cmd adminvs -provision -port $centralport -windowsauthprovider onlyusentlm
.\PSConfig -cmd applicationcontent -install

write-host "--center admin finish -----"

 

################################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2k8 enterprise tw, sql 2k5 std , moss 2k7 enterprise
#History    :
#filename   :stsadm.ps1
#
# cd env:Path 
#.\stsadm -help
# debug:8
###############################################

write-host "--06-portal_webApplication----------------------"
#$installuserpwd="moss1688"

$PortalWA_url = "http://intranet.gretai.org.tw:80" 
$PortalWA_ownerlogin = $installuser
$PortalWA_owneremail = $farmcontactemail
$PortalWA_databaseserver=$env:COMPUTERNAME 
$PortalWA_databasename="PortalWA_ContentDB" 
$PortalWA_apidname="Portal_AppPool" 
$PortalWA_apidlogin=$installuser
$PortalWA_apidpwd=$installuserpwd
$PortalWA_Desc="Portal_WA"

.\stsadm -o extendvs -url $PortalWA_url -ownerlogin $PortalWA_ownerlogin -owneremail $PortalWA_owneremail -exclusivelyusentlm -databaseserver $PortalWA_databaseserver -databasename $PortalWA_databasename -donotcreatesite -apcreatenew -apidname $PortalWA_apidname -apidtype configurableid -apidlogin $PortalWA_apidlogin -apidpwd $PortalWA_apidpwd -description $PortalWA_Desc
#stsadm -o unextendvs -url $PortalWA_url  -deletecontent -deleteiissites
iisreset

write-host "--07-SSP_webApplication-" 
$SSPWA_url = "http://center.gretai.org.tw:8688" 
$SSPWA_ownerlogin = $installuser
$SSPWA_owneremail = $farmcontactemail
$SSPWA_databaseserver=$env:COMPUTERNAME 
$SSPWA_databasename="SSPWA_ContentDB" 
$SSPWA_apidname="SSP_Adm_AppPool" 
$SSPWA_apidlogin=$installuser
$SSPWA_apidpwd=$installuserpwd
$SSPWA_Desc="SSP_WA"

#$teststring =".\stsadm -o extendvs -url $SSPWA_url -ownerlogin $SSPWA_ownerlogin -owneremail $SSPWA_owneremail -exclusivelyusentlm -databaseserver $SSPWA_databaseserver -databasename $SSPWA_databasename -donotcreatesite -apcreatenew -apidname $SSPWA_apidname -apidtype configurableid -apidlogin $SSPWA_apidlogin -apidpwd $SSPWA_apidpwd -description $SSPWA_Desc"
.\stsadm -o extendvs -url $SSPWA_url -ownerlogin $SSPWA_ownerlogin -owneremail $SSPWA_owneremail -exclusivelyusentlm -databaseserver $SSPWA_databaseserver -databasename $SSPWA_databasename -donotcreatesite -apcreatenew -apidname $SSPWA_apidname -apidtype configurableid -apidlogin $SSPWA_apidlogin -apidpwd $SSPWA_apidpwd -description $SSPWA_Desc
#stsadm -o unextendvs -url $SSPWA_url  -deletecontent -deleteiissites
iisreset

#.\stsadm -help
write-host "--08-mysite_webApplication-" 
$MysiteWA_url = "http://mysite.gretai.org.tw:8088" 
$MysiteWA_ownerlogin = $installuser
$MysiteWA_owneremail = $farmcontactemail
$MysiteWA_databaseserver=$env:COMPUTERNAME 
$MysiteWA_databasename="MysiteWA_ContentDB" 
$MysiteWA_apidname="Mysite_AppPool" 
$MysiteWA_apidlogin=$installuser
$MysiteWA_apidpwd=$installuserpwd
$MysiteWA_Desc="Mysite_WA"

#$teststring =".\stsadm -o extendvs -url $MysiteWA_url -ownerlogin $MysiteWA_ownerlogin -owneremail $MysiteWA_owneremail -exclusivelyusentlm -databaseserver $MysiteWA_databaseserver -databasename $MysiteWA_databasename -donotcreatesite -apcreatenew -apidname $MysiteWA_apidname -apidtype configurableid -apidlogin $MysiteWA_apidlogin -apidpwd $MysiteWA_apidpwd -description $MysiteWA_Desc"
.\stsadm -o extendvs -url $MysiteWA_url -ownerlogin $MysiteWA_ownerlogin -owneremail $MysiteWA_owneremail -exclusivelyusentlm -databaseserver $MysiteWA_databaseserver -databasename $MysiteWA_databasename -donotcreatesite -apcreatenew -apidname $MysiteWA_apidname -apidtype configurableid -apidlogin $MysiteWA_apidlogin -apidpwd $MysiteWA_apidpwd -description $MysiteWA_Desc
#stsadm -o unextendvs -url $MysiteWA_url  -deletecontent -deleteiissites
iisreset

write-host "--09-manage webpath--------------" 
#.\stsadm -o deletepath -url  http://otcmis/sites 
#.\stsadm -o deletepath -url  http://otcmis/
# .\stsadm -o addpath -url http://otcmis/intranet -type Explicitinclusion

 
iisreset
write-host "--10-create top-level------------"

$TL_url="http://intranet.gretai.org.tw"
$TL_owneremail=$farmcontactemail
$TL_ownerlogin=$installuser
$TL_ownername="MOSSADMIN管理"
$TL_title="證券櫃檯買賣中心-新版內部網站及知識庫管理系統"
$TL_desc="新版內部網站及知識庫管理系統"
$TL_sitetemplate="STS#0" 
#hostheaderwebapplicationurl http://otcmis/intranet/
#quota 
.\stsadm -o createsite -url $TL_url -owneremail $TL_owneremail -ownerlogin $installuser -ownername  $TL_ownername -title $TL_title -description $TL_desc -sitetemplate $TL_sitetemplate

#stsadm -o deletesite -url http://otcmis/intranet


write-host "--11-SSPServcie-"

$SSPsvc_title ="SSP_Svc1" 
$SSPsvc_admin_url= $SSPWA_url 
$SSPsvc_mysite_url =$MysiteWA_url
$SSPsvc_login=$installuser 
$SSPsvc_pwd= $installuserpwd
$SSPsvc_index_dbserver=$env:COMPUTERNAME 
$SSPsvc_index_dbname="SSPSvc1-IndexDB" 
$SSPsvc_search_dbserver=$env:COMPUTERNAME 
$SSPsvc_search_dbname="SSPSvc1-SearchDB" 
$SSPsvc_indexlocation= "c:\Program Files\Microsoft Office Servers\12.0\Data\Office Server\Applications"

.\stsadm -o createssp -title $SSPsvc_title -url $SSPsvc_admin_url -mysiteurl $SSPsvc_mysite_url -ssplogin $installuser -indexserver $env:COMPUTERNAME -indexlocation $SSPsvc_indexlocation -ssppassword $installuserpwd -sspdatabaseserver $env:COMPUTERNAME -sspdatabasename $SSPsvc_index_dbname  -searchdatabaseserver $env:COMPUTERNAME -searchdatabasename $SSPsvc_search_dbname -searchsqlauthlogin  $dbuser -searchsqlauthpassword $dbpwd -sspsqlauthlogin $dbuser  -sspsqlauthpassword $dbpwd


#.\stsadm -o deletessp -title $SSPsvc_title  -deletedatabases 
# edit  C:\Windows\System32\drivers\etc
# 
################################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2k8 enterprise tw, sql 2k5 std , moss 2k7 enterprise
#History    :
#filename   :createweb.ps1
#
# cd env:Path 
#.\stsadm -help
# debug:3
###############################################

write-host "--12-read csv----------------------"

$filename = "d:\temp\site_structure.csv"
cat $filename > d:\temp.csv #make utf8
import-csv d:\temp.csv | foreach {$desc=$_.desc
$title=$_.title
$url_top=$_.url_top
$url_sub=$_.url_sub
$subweburl="$url_top/$url_sub"
$sitetemplate=$_.sitetemplate
#$teststring=" stsadm -o createweb -url $subweburl -sitetemplate $sitetemplate -title $title -description $desc"

#.\stsadm -o createweb -url $subweburl -sitetemplate $sitetemplate -title $title -description $desc
.\stsadm -o deleteweb -url $subweburl
#write-host "--$title-ok-----"

}

remove-item d:\temp.csv

#---------------------------------------------
#setup rm+powershell
#1.1uninstall powershell 1.0 , install powershell 2.0 CTP2  ;  $psversiontable  ; 
#1.2 servermanagercmd -i net-framework  # .net 3.0

#2. check RM  , c:\windows\system32\WsmSvc.dll > properties > detailed > great than 6.0.6001.18089
#2.firewall.cpl
#2.3chcp : 950

#3.1 set-executionpolicy RemoteSigned
#3.2 enable powershell remoting feature : 
  # & $pshome\configure-wsman.ps1
#4.in DOS 
#M: winrm set winrm/config/client @{TrustedHosts="principal"}
#M: winrm id -r:principal
  
#5.open powershell
#M: icm -comp mirror  gps

#6: runspace
#$r = new-runspace -computername principal
#icm -run $r {rm c:\temp3}
  
 
#13###############################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2k8 enterprise tw, sql 2k5 std , moss 2k7 enterprise
#History    :
#filename   :code_list.ps1
#
# cd env:Path 
#.\stsadm -help
# debug:3
###############################################
 
 
 write-host "--13-create lists @ toplevel----------------------"
 
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint”) 
$url="http://intranet.gretai.org.tw"
$listTemplate="DocumentLibrary"
$spsite = new-object Microsoft.SharePoint.SPSite($url)
#$spsite.allwebs| select url
#foreach ($i in $spsite.allwebs)
#{
#$x=$i.name
#if ((($i.name).length) -gt 3)
#{
#$subweb="$url/$x"  
"----------$subweb--------"
#$spsite1 = new-object Microsoft.SharePoint.SPSite("$subweb")
#$spsite1 |select url
$spweb  =$spsite.openweb()
$splist =$spweb.Lists 
#$splist | select title

$splist.add("announce內部公告","內部公告",$listTemplate) #1
$splist.add("regulation內部規章","內部規章",$listTemplate)#2
$splist.add("project專題研究","專題研究",$listTemplate)#3
$splist.add("laws法令彙編","法令彙編",$listTemplate)#4
$splist.add("ISOzone專區","ISO專區",$listTemplate)#5
$splist.add("activity中心對外活動","中心對外活動",$listTemplate)#6
$splist.add("examdata證券發行交易題庫","證券發行交易題庫",$listTemplate)#7


#}
#}
###########################################
$listTitle1="announce內部公告"
function Lists_udpate1([string] $url,[string] $listTitle1)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle1 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "內部公告"                    
$splist.update()
}
###########################################
$listTitle2="regulation內部規章"
function Lists_udpate2([string] $url,[string] $listTitle2)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle2 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "內部規章"                    
$splist.update()
}
###########################################
$listTitle3="project專題研究"
function Lists_udpate3([string] $url,[string] $listTitle3)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle3 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "專題研究"                    
$splist.update()
}
###########################################


$listTitle4="laws法令彙編"
function Lists_udpate4([string] $url,[string] $listTitle4)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle4 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "法令彙編"                    
$splist.update()
}

###########################################
$listTitle5="ISOzone專區"
function Lists_udpate5([string] $url,[string] $listTitle5)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle5 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "ISO專區"                    
$splist.update()
}

###########################################
$listTitle6="activity中心對外活動"
function Lists_udpate1([string] $url,[string] $listTitle1)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle6 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "中心對外活動"                    
$splist.update()
}

###########################################
$listTitle7="examdata證券發行交易題庫"
function Lists_udpate1([string] $url,[string] $listTitle1)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb()
$splist =$spweb.Lists | ?{$_.title -eq $listTitle7 }
$splist.OnQuickLaunch = "ture"  
$splist.title = "證券發行交易題庫"                    
$splist.update()
}

###############update all folders######################
$url="http://otcmis/intranet"
$spsite = new-object Microsoft.SharePoint.SPSite($url)
#$spsite.allwebs| select url
foreach ($i in $spsite.allwebs)
{
$x=$i.name


if ((($i.name).length) -gt 3)
{
$subweb="$url/$x"  
#Lists_udpate1  $subweb $listTitle1
#Lists_udpate2  $subweb $listTitle2
#Lists_udpate3  $subweb $listTitle3
#Lists_udpate4  $subweb $listTitle4
Lists_udpate5  $subweb $listTitle5


}
}

 


###############show all folders######################
$url="http://otcmis/intranet"
$spsite = new-object Microsoft.SharePoint.SPSite($url)
#$spsite.allwebs| select url
foreach ($i in $spsite.allwebs)
{
$x=$i.name


if ((($i.name).length) -gt 3)
{
$subweb="$url/$x"  
"-----------$subweb------------"
$spsite1 = new-object Microsoft.SharePoint.SPSite("$subweb")
$spweb1  =$spsite1.openweb() 
$spweb1.lists | select title
}
}  
#14###############################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2k8 enterprise tw, sql 2k5 std , moss 2k7 enterprise
#History    :
#filename   :code_list.ps1
#
#1.announce內部公告","內部公告"
#2.regulation內部規章","內部規章"
#3.project專題研究","專題研究"
#4.laws法令彙編","法令彙編"
#5.ISOzone專區","ISO專區"
#6.activity中心對外活動","ISO專區",$listTemplate)#6
#7.examdata證券發行交易題庫","ISO專區",$listTemplate)#7
###############################################

 write-host "--14-create folders @ toplevel----------------------"
  
 
$url="http://intranet.gretai.org.tw"
$list1="announce"
$list2="regulation"
$list3="project"
$list4="laws"
$list5="ISOzone"
$list6="activity"
$list7="examdata"


$arrayfolder1="主管業務會報會議紀錄","勞資及退委會議紀錄","送件申請案注意事項","服務楷模","獎懲通知","任免通知","內部通知" #6
$arrayfolder2="員工服務手冊","職工福利","人事表單","退休","文書管理","財務表單","分層負責","總務","文書表單"#8
$arrayfolder3="主管業務會報會議紀錄","勞資及退委會議紀錄"#1
$arrayfolder4="加強申請上櫃及興櫃公司公開風險揭露","證券商及期貨商內部人從事交易之規範"#1
$arrayfolder5="品質政策","品質目標","品質手冊","資通安全政策","資通安全目標","資通安全手冊","程序書","指導書","文件紀錄一覽表","工作計畫","職務代理人名冊","軟體版權","病毒訊息","相關網站","常用表格","資安公告","資安新聞"#16
$arrayfolder6="中心對外活動"
$arrayfolder7="一上櫃審查類","二承銷業務類","三募集與發行類","四上櫃監理類","五資產證券化類","六其他類"#5

function folder_add ([string] $url ,[string] $list,[string] $folder)
{
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb  =$spsite.openweb() #$spweb.url
$spfolders =$spweb.folders
$spfolders.add("$list/$folder")
}

#folder_add  $url $list $folder

$spsite = new-object Microsoft.SharePoint.SPSite($url)
#$spsite.allwebs| select url
#foreach ($i in $spsite.allwebs)
#{
#$x=$i.name


#if ((($i.name).length) -gt 3)
#{
#"-----------$subweb------------"


folder_add  "$url" $list1 $arrayfolder1[0]
folder_add  "$url" $list1 $arrayfolder1[1]
folder_add  "$url" $list1 $arrayfolder1[2]
folder_add  "$url" $list1 $arrayfolder1[3]
folder_add  "$url" $list1 $arrayfolder1[4]
folder_add  "$url" $list1 $arrayfolder1[5]
folder_add  "$url" $list1 $arrayfolder1[6]

folder_add  "$url" $list2 $arrayfolder2[0]
folder_add  "$url" $list2 $arrayfolder2[1]
folder_add  "$url" $list2 $arrayfolder2[2]
folder_add  "$url" $list2 $arrayfolder2[3]
folder_add  "$url" $list2 $arrayfolder2[4]
folder_add  "$url" $list2 $arrayfolder2[5]
folder_add  "$url" $list2 $arrayfolder2[6]
folder_add  "$url" $list2 $arrayfolder2[7]
folder_add  "$url" $list2 $arrayfolder2[8]

folder_add  "$url" $list3 $arrayfolder3[0]
folder_add  "$url" $list3 $arrayfolder3[1]


folder_add  "$url" $list4 $arrayfolder4[0]
folder_add  "$url" $list4 $arrayfolder4[1]

folder_add  "$url" $list5 $arrayfolder5[0]
folder_add  "$url" $list5 $arrayfolder5[1]
folder_add  "$url" $list5 $arrayfolder5[2]
folder_add  "$url" $list5 $arrayfolder5[3]
folder_add  "$url" $list5 $arrayfolder5[4]
folder_add  "$url" $list5 $arrayfolder5[5]
folder_add  "$url" $list5 $arrayfolder5[6]
folder_add  "$url" $list5 $arrayfolder5[7]
folder_add  "$url" $list5 $arrayfolder5[8]
folder_add  "$url" $list5 $arrayfolder5[9]
folder_add  "$url" $list5 $arrayfolder5[10]
folder_add  "$url" $list5 $arrayfolder5[11]
folder_add  "$url" $list5 $arrayfolder5[12]
folder_add  "$url" $list5 $arrayfolder5[13]
folder_add  "$url" $list5 $arrayfolder5[14]
folder_add  "$url" $list5 $arrayfolder5[15]
folder_add  "$url" $list5 $arrayfolder5[16]

 

folder_add  "$url" $list7 $arrayfolder7[0]
folder_add  "$url" $list7 $arrayfolder7[1]
folder_add  "$url" $list7 $arrayfolder7[2]
folder_add  "$url" $list7 $arrayfolder7[3]
folder_add  "$url" $list7 $arrayfolder7[4]
folder_add  "$url" $list7 $arrayfolder7[5]
#}
#}
#15###############################################
#subject    : batch for sharepoint 2007 
#author     : Ming_Tseng(a0921887912@gmail.com)
#enviornment: windows 2k8 enterprise tw, sql 2k5 std , moss 2k7 enterprise
#History    :
#filename   :code_list.ps1
#
#1.announce內部公告","內部公告"
#2.regulation內部規章","內部規章"
#3.project專題研究","專題研究"
#4.laws法令彙編","法令彙編"
#5.ISOzone專區","ISO專區"
#6.activity中心對外活動","ISO專區",$listTemplate)#6
#7.examdata證券發行交易題庫","ISO專區",$listTemplate)#7
###############################################
write-host "--15-create fields @ toplevel----------------------"
 
#function listFields_add ([string]$url,[string]$listName){
$url="http://intranet.gretai.org.tw"
$listName ="內部公告"
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb=$spsite.openweb()
## $spweb.Lists |select title
$splist=$spweb.Lists | ? {$_.title -eq $listName} 
$spfiledcollection=$splist.Fields 
## $spfiledcollection |select title
## $spfiledcollection.Count
$spfiledcollection.Add("yy","text",'false')   #instance.Add(strDisplayName, type, bRequired)
$spfiledcollection.Add("mm","text",'false')
$spfiledcollection.Add("dd","text",'false')
$spfiledcollection.Add("isono","text",'false')

$listName ="內部公告"
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb=$spsite.openweb()
## $spweb.Lists |select title
$splist=$spweb.Lists | ? {$_.title -eq $listName} 
$spfiledcollection=$splist.Fields 
## $spfiledcollection |select title
## $spfiledcollection.Count

$t=$spfiledcollection | ? {$_.InternalName -eq "yy"} 
$t.title="年"
$t.Description="年"
$t.Required=$false
$t.Update()

$t=$spfiledcollection | ? {$_.InternalName -eq "mm"} 
$t.title="月"
$t.Description="月"
$t.Required=$false
$t.Update()

$t=$spfiledcollection | ? {$_.InternalName -eq "dd"} 
$t.title="日"
$t.Description="日"
$t.Required =$false
$t.Update()

$listName ="ISO專區"
$spsite = new-object Microsoft.SharePoint.SPSite($url)
$spweb1=$spsite.openweb()
$splist=$spweb.Lists | ? {$_.title -eq $listName} 
$spfiledcollection=$splist.Fields 
## $spfiledcollection |select title
## $spfiledcollection.Count
$spfiledcollection.Add("isono","text",'false')
$t=$spfiledcollection | ? {$_.InternalName -eq "isono"} 
$t.title="ISO文件編號"
$t.Description="ISO文件編號"
$t.Required =$false
$t.Update()
 
 

