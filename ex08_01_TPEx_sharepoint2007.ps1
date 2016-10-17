<#

Subject :Tpex SQL portal 
CreateDate: OCT.21.2015
filepath :  \\172.18.65.184\c$\PS1\.ps1
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\ex08_TPEx_sharepoint2007.ps1
history : 
. initial  #01 ~ #21


MOSS 

#>





##-------------------------------------------------------------
##      15  info
##-------------------------------------------------------------
intranetAP01    172.17.8.21
bq-intranetAP01  172.17.8.21
bq-intranetAP02  172.17.8.22

ping  intranetAP01

hostname  #BQ-intranetAP01
whoami   #ad\mossadmin

\\172.17.8.21\d$

\\172.17.8.21\d$\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\Data
              D:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\Data

D:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\DATA
D:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\DATA

##-------------------------------------------------------------
##      28   software
##-------------------------------------------------------------
D:\Software\SQL2005
D:\Software\powershell_ise\Windows6.0-KB968930-x64.msu  # enable powershell_ise
D:\Software\windows2008Source
D:\Software\MOSS 2007 SP1 X64\


enable powershell_ise  

##-------------------------------------------------------------
##     40   ServerManager 
##-------------------------------------------------------------

get-Module ServerManager
Import-Module ServerManager
Add-WindowsFeature PowerShell-ISE

Set-ExecutionPolicy RemoteSigned
$PSVersionTable
'
Name                           Value                                                                                                                                       
----                           -----                                                                                                                                       
CLRVersion                     2.0.50727.1434                                                                                                                              
BuildVersion                   6.0.6002.18111                                                                                                                              
PSVersion                      2.0                                                                                                                                         
WSManStackVersion              2.0                                                                                                                                         
PSCompatibleVersions           {1.0, 2.0}                                                                                                                                  
SerializationVersion           1.1.0.1                                                                                                                                     
PSRemotingProtocolVersion      2.1                                                                                                                                         
                                                                                                                                        


'


##-------------------------------------------------------------
##   66 join AD 
##-------------------------------------------------------------

bq-intranetAP01   


##-------------------------------------------------------------
##   58 serial key
##-------------------------------------------------------------


sharepoint 2007 key:　F6YVR4XY7KRCVY437FBKG44PY
winodws 2008          GH3BM-2GTCD-JV4X9-M8XJR-TDKXV
SQL 2015        


##-------------------------------------------------------------
##   106 install SQL 2005  &  SP2
##-------------------------------------------------------------

#C:\temp\SQL2005\CD1\Setup.exe
#SQL Server Database services
#chinese_Taiwan_Stroke
#gwmi  Win32_Product  |select name,Version |ft -auto
#C:\temp\SQL2005\CD1\Setup.exe  instlall management  tools

SqlWb

gwmi  Win32_Product  |select name,Version |ft -auto
(gwmi  Win32_Product).count # 12

'PS C:\Users\mossadmin> gwmi  Win32_Product  |select name,Version |ft -auto

name                                                           Version       
----                                                           -------       
VMware Tools                                                   9.10.0.2476743
Microsoft Office 2003 Web Components                           11.0.6558.0   
Microsoft SQL Server VSS Writer                                9.00.1399.06  
Microsoft SQL Server 2005                                      9.00.1399.06  
Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161 9.0.30729.6161
Microsoft SQL Server 2005 Tools                                9.00.1399.06  
SQLXML4                                                        9.00.1399.06  
Microsoft SQL Server 2005 回溯相容性                             8.05.1054     
Microsoft SQL Server Native Client                             9.00.1399.06  
Adobe Flash Player 18 ActiveX                                  18.0.0.232    
Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148 9.0.30729.4148
Microsoft SQL Server 安裝程式支援檔案 (英文)                       9.00.1399.06  
'

#  SQL Service pack sp2
D:\Software\SQL2005\SQLServer2005SP2-KB921896-x86-CHT.msu


##-------------------------------------------------------------
##  116 dbcreate TSQL
##-------------------------------------------------------------

D:\PS1\dbcreate.txt
sqlwb


##-------------------------------------------------------------
##   130  create sql alias  cliconfg
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
#Start-Process C:\Windows\System32\cliconfg.exe
Start-Process C:\Windows\SysWOW64\cliconfg.exe

#check 5.1
Invoke-Sqlcmd -Query "SELECT @@servername as hostname "  -ServerInstance "$AliasName" #-Database $dbName

+++

##-------------------------------------------------------------
##  182  backup database
##-------------------------------------------------------------

'
dbcc sqlperf(logspace)
master	                 6.117188	28.22478	0
tempdb	                 1.742188	38.78924	0
model	                 0.9921875	87.40157	0
msdb	                10.92969	38.52752	0
Farm_config	             1.992188	38.2598	0
WebappS_admin	         2.742188	69.37322	0
WSS_Search_INTRANETAP01	28.80469	31.43138	0
PortalWA_ContentDB	   739.4922	2.769267	0
SSPWA_ContentDB	       120.7422	98.51585	0
MysiteWA_ContentDB	  1585.43	89.90742	0
SRDSummary	          9697.867	0.9599707	0
SSP2DB	                28.80469	21.11303	0
33606DB	                 1.742188	34.1648	0
SSP2SearchDB	       160.8047	7.243842	0'


backup database [33606DB] to disk ='\\172.18.8.21\d$\dbbackup\33606DB_20151022.bak' #don't work

--backup database [33606DB]          to disk ='d:\dbbackup\33606DB_20151022A.bak'
--backup log      [33606DB]          to disk ='d:\dbbackup\33606DB_20151022A.trn'

--backup database Farm_config        to disk ='d:\dbbackup\Farm_config_20151022.bak'

backup database MysiteWA_ContentDB to disk ='d:\dbbackup\MysiteWA_ContentDB_20151022.bak'
backup log MysiteWA_ContentDB to disk ='d:\dbbackup\MysiteWA_ContentDB_20151022.trn'  #--10.654 秒

backup database PortalWA_ContentDB to disk ='d:\dbbackup\PortalWA_ContentDB_20151022.bak'
backup log PortalWA_ContentDB to disk ='d:\dbbackup\PortalWA_ContentDB_20151022.trn'

--backup database SRDSummary         to disk ='d:\dbbackup\SRDSummary_20151022.bak' # 6G speed 33min
--backup log SRDSummary         to disk ='d:\dbbackup\SRDSummary_20151022.trn'      # 9G speed 35min

backup database SSP2DB             to disk ='d:\dbbackup\SSP2DB_20151022.bak'  
--backup log      SSP2DB             to disk ='d:\dbbackup\SSP2DB_20151022.trn' #--復原模式為 SIMPLE 

backup database SSP2SearchDB       to disk ='d:\dbbackup\SSP2SearchDB_20151022.bak'
--backup log      SSP2SearchDB       to disk ='d:\dbbackup\SSP2SearchDB_20151022.trn' #--復原模式為 SIMPLE 

backup database SSPWA_ContentDB    to disk ='d:\dbbackup\SSPWA_ContentDB_20151022.bak'
backup log      SSPWA_ContentDB    to disk ='d:\dbbackup\SSPWA_ContentDB_20151022.trn'

--backup database WebappS_admin      to disk ='d:\dbbackup\WebappS_admin_20151022.bak'
--backup database WSS_Search_INTRANETAP01   to disk ='d:\dbbackup\WSS_Search_INTRANETAP01_20151022.bak'

已處理資料庫 'PortalWA_ContentDB' 的 4435080 頁，檔案 1 上的檔案 'PortalWA_ContentDB'。
已處理資料庫 'PortalWA_ContentDB' 的 8 頁，檔案 1 上的檔案 'PortalWA_ContentDB_log'。
BACKUP DATABASE 已於 253.652 秒內成功處理了 4435088 頁 (143.236 MB/sec)。


restore database [33606DB]  from disk ='d:\dbbackup\33606DB_20151022A.bak' with replace,norecovery
restore Log [33606DB]  from disk ='d:\dbbackup\33606DB_20151022A.trn' with recovery


restore database MysiteWA_ContentDB from disk ='d:\dbbackup\MysiteWA_ContentDB_20151022.bak' with replace,norecovery
restore log MysiteWA_ContentDB from disk ='d:\dbbackup\MysiteWA_ContentDB_20151022.trn' with recovery

restore database PortalWA_ContentDB from disk ='d:\dbbackup\PortalWA_ContentDB_20151022.bak' with replace,norecovery # 177.460 秒內成功處理
restore log PortalWA_ContentDB from disk ='d:\dbbackup\PortalWA_ContentDB_20151022.trn' with recovery                #0.042 秒內成功處理了 12 頁 

--restore database SRDSummary         from disk ='d:\dbbackup\SRDSummary_20151022.bak' with replace,norecovery
--restore log SRDSummary         from disk ='d:\dbbackup\SRDSummary_20151022.trn'  with recovery

restore database SSP2DB             from disk ='d:\dbbackup\SSP2DB_20151022.bak'  with replace
--restore log      SSP2DB             from disk ='d:\dbbackup\SSP2DB_20151022.trn'  with recovery

restore database SSP2SearchDB       from disk ='d:\dbbackup\SSP2SearchDB_20151022.bak'  with replace
--restore log      SSP2SearchDB       from disk ='d:\dbbackup\SSP2SearchDB_20151022.trn' with recovery

restore database SSPWA_ContentDB    from disk ='d:\dbbackup\SSPWA_ContentDB_20151022.bak'  with replace,norecovery
restore log      SSPWA_ContentDB    from disk ='d:\dbbackup\SSPWA_ContentDB_20151022.trn'  with recovery


##-------------------------------------------------------------
##  210 install Sharepoint 2007
##-------------------------------------------------------------


D:\Software\MOSS 2007 SP1 X64\setup.exe
F6YVR4XY7KRCVY437FBKG44PY
gwmi  Win32_Product  |select name,Version |ft -auto

(gwmi  Win32_Product).count # 34
SPFarmSQL

'
(IN bq-intranetap01)
PS C:\Program Files\Common Files\microsoft shared\web server extensions\12\bin> gwmi  Win32_Product  |select name,Version |ft -auto

name                                                                               Version       
----                                                                               -------       
Microsoft Office Shared Coms Chinese (Traditional) Language Pack                   12.0.6219.1000
Microsoft Office Document Lifecycle Components Chinese (Traditional) Language Pack 12.0.6219.1000
Microsoft Office Slide Library Chinese (Traditional) Language Pack                 12.0.6219.1000
Microsoft Windows SharePoint Services 3.0                                          12.0.6219.1000
Microsoft Windows SharePoint Services 3.0 1028 Lang Pack                           12.0.6219.1000
Microsoft Office Excel Services                                                    12.0.6219.1000
Microsoft Office Excel Services Web Front End Components                           12.0.6219.1000
Microsoft Office InfoPath Forms Services                                           12.0.6219.1000
Microsoft Office Document Lifecycle Components                                     12.0.6219.1000
Microsoft Office Slide Library                                                     12.0.6219.1000
Microsoft Office InfoPath Form Services Chinese (Traditional) Language Pack        12.0.6219.1000
Microsoft Office Excel Services Chinese (Traditional) Language Pack                12.0.6219.1000
Microsoft Office SharePoint Portal                                                 12.0.6219.1000
Microsoft Office Document Lifecycle Application Server Components                  12.0.6219.1000
Microsoft Search Front End                                                         12.0.6219.1000
Microsoft Search                                                                   12.0.6219.1000
Microsoft Office SharePoint Server 2007                                            12.0.6219.1000
Microsoft Search Chinese (Traditional) Language Pack                               12.0.6219.1000
Microsoft Office SharePoint Portal Chinese (Traditional) Language Pack             12.0.6219.1000
Microsoft Office Shared Components                                                 12.0.6219.1000
VMware Tools                                                                       9.10.0.2476743
Microsoft SQL Server 2005 回溯相容性                                                    8.05.2004     
Microsoft Office 2003 Web Components                                               11.0.6558.0   
Microsoft SQL Server 2005                                                          9.2.3042.00   
Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161                     9.0.30729.6161
Microsoft SQL Server 2005 Tools                                                    9.2.3042.00   
SQLXML4                                                                            9.00.3042.00  
Microsoft SQL Server Native Client                                                 9.00.3042.00  
Microsoft SQL Server 2005 Analysis Services ADOMD.NET                              9.00.1399.06  
Adobe Flash Player 18 ActiveX                                                      18.0.0.232    
Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148                     9.0.30729.4148
Microsoft Report Viewer Redistributable 2005                                       8.0.50727.42  
Microsoft SQL Server 安裝程式支援檔案 (英文)                                           9.00.3042.00  
Microsoft SQL Server VSS Writer                                                    9.00.3042.00  



(IN SYSCOM)
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
Google Update Helper                                                                1.3.28.15     
Microsoft SQL Server 2005 Analysis Services ADOMD.NET                               9.00.1399.06  
Microsoft Report Viewer Redistributable 2005                                        8.0.50727.42  
'

C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\12\LOGS


SPFarmSQL
SharePoint_Config
http://bq-intranetap01:2688/


#icm -comp intranetAP01 -script {hostname}
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
##      sql mirroring
##-------------------------------------------------------------
{<#
telnet intranetAP01 7024
telnet intranetAP01 7025

backup database [SSPSvc1-IndexDB]    to disk='D:\2011\SSPSvc1-IndexDB.bak'
backup database [SSPSvc1-SearchDB]   to disk='D:\2011\SSPSvc1-SearchDB.bak'
backup database [SSPWA_ContentDB]    to disk='D:\2011\SSPWA_ContentDB.bak'



1.	On the principal server, create a certificate and open a port for mirroring.
--On master database, create the database Master Key, if needed
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '' ;
GO
-- Make a certificate for this server instance.
USE master;
CREATE CERTIFICATE <MASTER_HostA_cert> 
   WITH SUBJECT = ;
GO
--Create mirroring endpoint for server instance using the certificate
CREATE ENDPOINT Endpoint_Mirroring
   STATE = STARTED
   AS TCP (
      LISTENER_PORT=5024, LISTENER_IP = ALL
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

#>}

##-------------------------------------------------------------
##      sharepoint  farm
##-------------------------------------------------------------




##-------------------------------------------------------------
##     626 sharepoint 2007 restore for intranetap01
##-------------------------------------------------------------

C:\Windows\System32\drivers\etc\hosts

172.17.8.21	intranet.gretai.org.tw
#172.18.8.21	intranet.gretai.org.tw

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
#$installuserpwd=""

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
$PortalWA_databaseserver="SPFarmSQL" 
$PortalWA_databasename="PortalWA_ContentDB" 
$PortalWA_apidname="Portal_AppPool" 
$PortalWA_apidlogin=$installuser
$PortalWA_apidpwd=$installuserpwd
$PortalWA_Desc="Portal_WA"

ping intranet.gretai.org.tw

##  createNew
.\stsadm -o extendvs -url $PortalWA_url -ownerlogin $PortalWA_ownerlogin -owneremail $PortalWA_owneremail -exclusivelyusentlm -databaseserver $PortalWA_databaseserver -databasename $PortalWA_databasename -donotcreatesite -apcreatenew -apidname $PortalWA_apidname -apidtype configurableid -apidlogin $PortalWA_apidlogin -apidpwd $PortalWA_apidpwd -description $PortalWA_Desc

## restore
$t1=get-date
.\stsadm -o extendvs -url $PortalWA_url -ownerlogin $PortalWA_ownerlogin -owneremail $PortalWA_owneremail -exclusivelyusentlm -databaseserver $PortalWA_databaseserver -databasename $PortalWA_databasename -apidname $PortalWA_apidname -apidtype configurableid  -apidlogin $PortalWA_apidlogin -apidpwd $PortalWA_apidpwd -description $PortalWA_Desc
$t2=get-date
$t2-$t1  # 1min 44sec  workable .Oct.23.2015

-url                -url               http://intranet.gretai.org.tw:80
-ownerlogin         -ownerlogin        AD\mossadmin
-owneremail         -owneremail        mossadmin@mail.gretai.org.tw
-databaseserver     -databaseserver    SPFarmSQL
-databasename       -databasename      PortalWA_ContentDB
-description        -description       Portal_WA
-apidname           -apidname          Portal_AppPool
-apidtype           -apidtype          configurableid 
-apidlogin          -apidlogin         AD\mossadmin
-apidpwd            -apidpwd           $PortalWA_apidpwd
-exclusivelyusentlm  -exclusivelyusentlm
donotcreatesite -apcreatenew 

'
STSADM.EXE : IIS 網站已使用 Windows SharePoint Services 進行擴充，但在建立預設網站 "http://intranet.gretai.org.tw/" 時發生下列錯誤。請修正輸入並再次嘗試建立預設網站。錯誤: 另一個網站已經存在於 http://intranet.gretai.org.tw。在嘗試
以相同 URL 建立新網站之前請先刪除此網站、選擇新的 URL 或在您原本指定的路徑建立新的包含網站。
'



#stsadm -o unextendvs -url $PortalWA_url  -deletecontent -deleteiissites
iisreset

write-host "----------------------07-SSP_webApplication-" 
$SSPWA_url = "http://center.gretai.org.tw:8688" 
$SSPWA_ownerlogin = $installuser
$SSPWA_owneremail = $farmcontactemail
#$SSPWA_databaseserver=$env:COMPUTERNAME 
$SSPWA_databaseserver="SPFarmSQL" 
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






write-host "----------------------08-mysite_webApplication-------------------" 

ping mysite.gretai.org.tw

$MysiteWA_url = "http://mysite.gretai.org.tw:8080" 
$MysiteWA_ownerlogin = $installuser
$MysiteWA_owneremail = $farmcontactemail
#$MysiteWA_databaseserver=$env:COMPUTERNAME 
$MysiteWA_databaseserver="SPFarmSQL"
$MysiteWA_databasename="MysiteWA_ContentDB" 
$MysiteWA_apidname="Mysite_AppPool" 
$MysiteWA_apidlogin=$installuser
$MysiteWA_apidpwd=$installuserpwd
$MysiteWA_Desc="Mysite_WA"

#$teststring =".\stsadm -o extendvs -url $MysiteWA_url -ownerlogin $MysiteWA_ownerlogin -owneremail $MysiteWA_owneremail -exclusivelyusentlm -databaseserver $MysiteWA_databaseserver -databasename $MysiteWA_databasename -donotcreatesite -apcreatenew -apidname $MysiteWA_apidname -apidtype configurableid -apidlogin $MysiteWA_apidlogin -apidpwd $MysiteWA_apidpwd -description $MysiteWA_Desc"
.\stsadm -o extendvs -url $MysiteWA_url -ownerlogin $MysiteWA_ownerlogin -owneremail $MysiteWA_owneremail -exclusivelyusentlm -databaseserver $MysiteWA_databaseserver -databasename $MysiteWA_databasename -donotcreatesite -apcreatenew -apidname $MysiteWA_apidname -apidtype configurableid -apidlogin $MysiteWA_apidlogin -apidpwd $MysiteWA_apidpwd -description $MysiteWA_Desc
#stsadm -o unextendvs -url $MysiteWA_url  -deletecontent -deleteiissites

$t1=get-date
.\stsadm -o extendvs -url $MysiteWA_url -ownerlogin $MysiteWA_ownerlogin -owneremail $MysiteWA_owneremail -exclusivelyusentlm -databaseserver $MysiteWA_databaseserver -databasename $MysiteWA_databasename -apidname $MysiteWA_apidname -apidtype configurableid -apidlogin $MysiteWA_apidlogin -apidpwd $MysiteWA_apidpwd -description $MysiteWA_Desc
$t2=get-date
$t2-$t1  # 1min 47sec  workable .Oct.23.2015



-url              http://mysite.gretai.org.tw:8080
-ownerlogin       AD\mossadmin
-owneremail       mossadmin@mail.gretai.org.tw
-exclusivelyusentlm 
-databaseserver   SPFarmSQL
-databasename     MysiteWA_ContentDB
-apidname         Mysite_AppPool
-apidtype         
-apidlogin        AD\mossadmin
-apidpwd          $MysiteWA_apidpwd 
-description      Mysite_WA
#count:11

iisreset



##-------------------------------------------------------------
##     827 sharepoint 2007 configuration 搜尋
##-------------------------------------------------------------


####  Office SharePoint Server 搜尋服務設定 

管理中心 > 作業 > 伺服器上的服務    
伺服器上的服務: BQ-INTRANETAP01 
  
設定伺服器 BQ-INTRANETAP01 的 Office SharePoint Server 搜尋服務設定  (http://intranetap01:2688/_admin/SearchServiceInstanceSettings.aspx?ServerId=3431feb0-5867-4cfc-9423-b862ba31f238&Source=%2F%5Fadmin%2Fserver%2Easpx )
(v)使用此伺服器為內容編製索引 
(v)使用此伺服器服務搜尋查詢 

電子郵件地址
使用者名稱 
預設索引檔案位置: C:\Program Files\Microsoft Office Servers\12.0\Data\Office Server\Applications  
 
Office SharePoint Server 搜尋    已啟動  
 
####  Windows SharePoint Services 搜尋服務設定 

管理中心 > 作業 > 伺服器上的服務 > Windows SharePoint Services 搜尋服務設定    (http://intranetap01:2688/_admin/SPSearchServiceInstanceSettings.aspx?ServerId=3431feb0-5867-4cfc-9423-b862ba31f238) 
設定伺服器 INTRANETAP01 的 Windows SharePoint Services 搜尋服務設定  
 
服務帳戶      AD\mossadmin
內容存取帳戶   AD\mossadmin
搜尋資料庫    資料庫伺服器   SPFarmSQL
            資料庫名稱     WSS_Search_BQ-INTRANETAP01
            資料庫驗證     Windows 驗證 (建議使用)
索引排程      33~37


 
 
 
'
BQ









GT

Excel Calculation Services                  已啟動   
Office SharePoint Server 搜尋               已啟動  
Windows SharePoint Services Web 應用程式     已啟動 
Windows SharePoint Services 內送電子郵件     已啟動 
Windows SharePoint Services 說明搜尋         已啟動 
文件轉換負載平衡器服務                        已啟動 
文件轉換啟動器服務                            已啟動 
管理中心                                   已啟動 
 
'



##-------------------------------------------------------------
##   889  伺服器陣列中的伺服器  
##-------------------------------------------------------------

'GT'
管理中心 > 作業 > 伺服器陣列中的伺服器   
伺服器陣列中的伺服器                          12.0.0.6219  

伺服器陣列資訊                              版本: 12.0.0.6219 
設定資料庫伺服器: INTRANETAP01 
設定資料庫名稱: Farm_config 
---------------------------------------------------
INTRANETAP01  Excel Calculation Services 
Office SharePoint Server 搜尋 
Windows SharePoint Services Web 應用程式 
Windows SharePoint Services 內送電子郵件 
Windows SharePoint Services 資料庫 
Windows SharePoint Services 說明搜尋 
文件轉換負載平衡器服務 
文件轉換啟動器服務 
管理中心 

mail.gretai.org.tw  Windows SharePoint Services 外寄電子郵件 

##-------------------------------------------------------------
##   913  建立   SSP  新的共用服務提供者  
##-------------------------------------------------------------
管理中心 > 應用程式管理 > 管理此伺服器陣列的共用服務 > 新的共用服務提供者    
新的共用服務提供者  

#step 1
建立新的 Web 應用程式 
$SSPWA_url = "http://center.gretai.org.tw:8688" 
$SSPWA_ownerlogin = $installuser
$SSPWA_owneremail = $farmcontactemail
#$SSPWA_databaseserver=$env:COMPUTERNAME 
$SSPWA_databaseserver="SPFarmSQL" 
$SSPWA_databasename="SSPWA_ContentDB" 
$SSPWA_apidname="SSP_Adm_AppPool" 
$SSPWA_apidlogin=$installuser
$SSPWA_apidpwd=$installuserpwd
$SSPWA_Desc="SSP_WA"

IIS 網站 描述: SSP
連接埠   27658
安全性設定 驗證提供者: NTLM
負載平衡 URL :http://BQ-INTRANETAP01:27658/
應用程式集區 應用程式集區名稱 :SharePoint-SSP-27658
           可設定  AD\mossadmin 

資料庫名稱與驗證 : 資料庫伺服器 
                資料庫名稱 SSPWA_ContentDB
                
#step 2

<SSP 名稱> :SSPSrv                
    Web 應用程式 SSP             
    SSP 管理網站 URL :http://bq-intranetap01:27658/ssp/admin
<我的網站位置> Web 應用程式 :MySite_WA
           我的網站位置 URL : http://mysite.gretai.org.tw:8088/
           
<SSP 服務認證> 使用者名稱   AD\mossadmin 

<SSP 資料庫>  SSPDB

<搜尋資料庫>   SSPSearchDB                        
                
<索引伺服器>   

索引伺服器    BQ-INTRANETAP01 

 
索引檔案位置路徑    C:\Program Files\Microsoft Office Servers\12.0\Data\Office Server\Applications


inetgmr: appPool :  SSPSrv
         site:   :  SSP
         
         
  共用服務管理網站       
         

Note: new relation for mysite
               
成功建立共用服務提供者  
已成功建立及設定所有共用服務! 這些共用服務包括: 

商務資料目錄
Office SharePoint Server 搜尋
Excel Services
使用者設定檔應用程式
工作階段狀態

若要檢視此 SSP 的管理頁面，請移至 共用服務管理網站。

否則，請按一下 [確定]，返回「管理此伺服器陣列共用服務」頁面。  
 
 
    
 
 
               
##-------------------------------------------------------------
##    remark
##-------------------------------------------------------------




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
 
 

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                