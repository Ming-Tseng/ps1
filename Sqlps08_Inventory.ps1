
<#  Sqlps08_Inventory
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps08_Inventory.ps1
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps08_Inventory.ps1
 auther : ming_tseng    a0921887912@gmail.com
 CreateData : Mar.06.2014
 LastDate : APR.27.2014
 history : 




$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\Sqlps08_Inventory.ps1
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

# 01      Create  SQLInventory database
# 02 100  <Hosts>
# 03 150  insert/update Hosts
# 04 200  SQLServers information  with sQLPath
# 05 350  <SQLServers> with SERVERPROPERTY
# 05-1 1350 Function updateSQLServer with smo
# 05 450  function GetTCPPort
# 06 500  function GetSQLServiceStatus
# 07 550  function GetSQLstarttime
# 08 600  function GetSQLsystemDbDevice
# 09 650  <SQLDatabases>
# 10 650  Function GetSQLdatabases
# 11 750  Function GetSQLDBFileSize
# 12 800  GetDBfileNum
# 13 800  function updateMID
# 14 850  <HostsDisks>
# 15 900  Get  instance inventory  to CSV  p116
# 16 950  Get  Database information inventory  to CSV  p116
# 17 1000 Get  database using SMO
# 18 1200 GetHostDisks
# 19 1200  <SQLDisk>  + Function updateSQLDisks
# 20 1400  step by step DMV to SQL_inventory
# 21  1400  DBCC to SQL_inventory
# 22 1456 get  Table index  filegroup 
# 1590   WhatsGoingOnHistory
# 1612   SQLEventLog

#+ SQLEventLog
#+ SQLMonitor (alert, schedule, 
#+ PerfDisk
#+ perfCPU
#+ perfMemory
#+ perfNetwork
#+ perfalwayson
#+ perfreplication
#+ perfmirror
#+ DMVblock
#+ SQLstatus (view)
#+ historySQLDisks
#+ historyHostsDisk

# 99  ps1















ssms
#---------------------------------------------------------------
# 1  Create  SQL_Inventory database
#---------------------------------------------------------------
CREATE DATABASE [SQL_Inventory] ON(NAME = N'SQLInventory',FILENAME = N'H:\SQLDB\SQL_Inventory.mdf',SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024MB )LOG ON(NAME = N'SQLInventory_log',FILENAME = N'H:\SQLDB\SQL_Inventory_log.LDF',SIZE = 512MB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)


#---------------------------------------------------------------
# 2 100  Hosts
#---------------------------------------------------------------
USE [SQL_Inventory]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hosts]')
AND type in (N'U'))
DROP TABLE [dbo].[Hosts]
GOCREATE TABLE [dbo].[Hosts](
[MID] [varchar](128)  ,
[hostName] [varchar](128) ,
--[timeZone] [varchar](128) NULL,
--[enableDaylightSavingsTime] [bit] NULL,
[domain] [varchar](128) NULL,
[manufacturer] [varchar](128) NULL,
[model] [varchar](128) NULL,
--[systemType] [varchar](128) NULL,
--[systemStartupOptions] [varchar](128) NULL,
[numberOfProcessors] [tinyint] NULL,
[numberOfLogicalProcessors] [tinyint] NULL,
[totalPhysicalMemory] [int] NULL,
--[countryCode] [varchar](128) NULL,
[lastBootUpTime] [smalldatetime] NULL,
--[locale] [varchar](128) NULL,
[OS] [varchar](128) NULL,
[version] [varchar](128) NULL,
[servicePackMajorVersion] [varchar](10) NULL,
[servicePackMinorVersion] [varchar](10) NULL,
[buildNumber] [varchar](20) NULL,
[installDate] [datetime] NULL,
--[totalVisibleMemorySize] [bigint] NULL,
--[totalVirtualMemorySize] [bigint] NULL,
--[pagingFileSize] [bigint] NULL,
[IP1] [varchar](128) NULL,
[IP2] [varchar](128) NULL,
[IP3] [varchar](128) NULL,
[IP4] [varchar](128) NULL,
[IP5] [varchar](128) NULL,
[IP6] [varchar](128) NULL,
--[createDate] [smalldatetime]  NULL,
--[region] [char](2)  NULL,
--[location] [char](2)  NULL,
--[description] [varchar](500) NULL,
--[primaryBU] [varchar](128)  NULL,
[updateDate] [smalldatetime]  NULL)
 ON [PRIMARY]
GO


#---------------------------------------------------------------
# 3 150 insert/update Hosts
#---------------------------------------------------------------
Import-Module   activedirectory  -DisableNameChecking

$hostlist=Get-ADComputer -Filter *   -Properties   *  | ? Description -notlike  'Fail*' 

$hostlist='sp2013','sql2012x','2016BI','w2k8r2-2013'

foreach ($item in $hostlist)
{
    $item.Name
}

foreach ($item in $hostlist) { #86
   switch ($item.Name)  { # 87
        2016BI {$MID='34'} 
        DGPAP1 {$MID='39'} 
        DGPAP2 {$MID='40'} 
        SP2013 {$MID='29'} 
        SQL2012X {$MID='61'} 
        SP2013WFE {$MID='194'} 
        default {$MID="The color could not be determined."}
    }# 87
    
     $hostName=$item.Name
     $computerSystem = get-wmiobject Win32_ComputerSystem -ComputerName $hostName ; # $computerSystem |select *
            $manufacturer=$computerSystem.Manufacturer
            ;$Model=$computerSystem.Model
            ;$systemtype=$computerSystem.PCSystemType
            ;$LogicalProcessor=$computerSystem.NumberOfLogicalProcessors
            ;$PhyiscalProcessors=$computerSystem.NumberOfProcessors
            ;$domain=$computerSystem.Domain     
      #$computerprocessor = get-wmiobject Win32_processor -ComputerName $hostName ; # $computerprocessor |select *
       
       $IPArr = gwmi Win32_NetworkAdapterconfiguration -ComputerName $hostName | ? ipEnabled -Match 'True'; 

     # $IPArr = gwmi Win32_NetworkAdapterconfiguration -ComputerName $hostName | ? ipEnabled -Match 'True' | ?  DefaultIPGateway -ne $null;
      
      $IP1=$IPArr.Ipaddress[0];$IP2=$IPArr.Ipaddress[1];$IP3=$IPArr.Ipaddress[2]
      $IP4=$IPArr.Ipaddress[3];$IP5=$IPArr.Ipaddress[4];$IP6=$IPArr.Ipaddress[5]
            
     $computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $hostName  ;# $computerOS |select * 
        $OS= $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion        $OS = $OS.substring(25, $OS.length -25)        $version=$computerOS.Version        $servicePackMajorVersion=$computerOS.ServicePackMajorVersion        $servicePackMinorVersion=$computerOS.servicePackMinorVersion        $buildNumber=$computerOS.BuildNumber        $InstallDate=$computerOS.ConvertToDateTime($computerOS.InstallDate)        $TotalMemoryGigabytes=$computerSystem.TotalPhysicalMemory/1gb        $TotalMemoryGigabytes = [math]::round($TotalMemoryGigabytes, 2)        $LastReboot= $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)


      $sql_insert = @"INSERT INTO [Hosts] ([MID],[hostName],[manufacturer],[Model],[numberOfProcessors],[numberOfLogicalProcessors],[totalPhysicalMemory],[lastBootUpTime],[OS],[version],[servicePackMajorVersion],[servicePackMinorVersion],[buildNumber],[InstallDate],[IP1],[IP2],[IP3],[IP4],[IP5],[IP6],[domain],[updateDate]) VALUES ('$MID', '$hostName','$manufacturer','$Model' ,'$PhyiscalProcessors','$LogicalProcessor','$TotalMemoryGigabytes','$LastReboot','$OS','$version','$servicePackMajorVersion','$servicePackMinorVersion','$buildNumber','$InstallDate','$IP1','$IP2','$IP3','$IP4','$IP5','$IP6','$domain',getdate())"@$sql_insert#Invoke-Sqlcmd -Query $sql_insert -ServerInstance "sp2013" -Database SQL_inventory #-QueryTimeout
   }#86
#---------------------------------------------------------------
# 4  200  SQLServers information  with sQLPath
#---------------------------------------------------------------
$Node1='SP2013'
$SQLInstance1='Default'
$SQLPathInstance1="SQLSERVER:\sql\"+$Node1+"\"+$SQLInstance1 ; $SQLPathInstance1
cd  $SQLPathInstance1 ;ls

$objectInstance1=gi . ; $objectInstance1 |select * | sort name 

$objectInstance1|gm

PS SQLSERVER:\sql\SP2013\Default> $objectInstance1|gm


ActiveDirectory             : 
AffinityInfo                : Microsoft.SqlServer.Management.Smo.AffinityInfo
AuditLevel                  : Failure
Audits                      : {}
AvailabilityGroups          : {SPMAG}
BackupDevices               : {}
BackupDirectory             : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup
BrowserServiceAccount       : NT AUTHORITY\LOCALSERVICE
BrowserStartMode            : Auto
BuildClrVersion             : 4.0.30319
BuildClrVersionString       : v4.0.30319
BuildNumber                 : 3128
ClusterName                 : FC2
ClusterQuorumState          : NormalQuorum
ClusterQuorumType           : NodeAndFileshareMajority
Collation                   : Chinese_Taiwan_Stroke_CI_AS
CollationID                 : 53251
ComparisonStyle             : 196609
ComputerNamePhysicalNetBIOS : SP2013
Configuration               : Microsoft.SqlServer.Management.Smo.Configuration
ConnectionContext           : Data Source=SP2013;Integrated Security=True;MultipleActiveResultSets=False;Connect Timeout=30;Application Name="SQLPS (administrator@SP2013)"
Credentials                 : {}
CryptographicProviders      : {}
Databases                   : {194_SP_CentralAdminContent, 194_SP_ConfigDB, AdventureWorks2008, AdventureWorks2008R2...}
DefaultFile                 : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\
DefaultLog                  : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\
DefaultTextMode             : True
DisplayName                 : DEFAULT
DomainInstanceName          : SP2013
DomainName                  : SMO
Edition                     : Enterprise Edition (64-bit)
Endpoints                   : {Dedicated Admin Connection, Hadr_endpoint, TSQL Default TCP, TSQL Default VIA...}
EngineEdition               : EnterpriseOrDeveloper
ErrorLogPath                : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Log
Events                      : Microsoft.SqlServer.Management.Smo.ServerEvents
FilestreamLevel             : TSqlFullFileSystemAccess
FilestreamShareName         : MSSQLSERVER
FullTextService             : [SP2013]
HadrManagerStatus           : Running
Information                 : Microsoft.SqlServer.Management.Smo.Information
InstallDataDirectory        : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL
InstallSharedDirectory      : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL
InstanceName                : 
IsCaseSensitive             : False
IsClustered                 : False
IsDesignMode                : False
IsFullTextInstalled         : False
IsHadrEnabled               : True
IsSingleUser                : False
JobServer                   : [SP2013]
Language                    : English (United States)
Languages                   : {Arabic, British, ?e?tina, Dansk...}
LinkedServers               : {2013BI, repl_distributor, SQL2012X}
LoginMode                   : Mixed
Logins                      : {##MS_PolicyEventProcessingLogin##, ##MS_PolicyTsqlExecutionLogin##, CSD\administrator, CSD\Eadmin...}
Mail                        : [SP2013]
MailProfile                 : 
MasterDBLogPath             : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
MasterDBPath                : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
MaxPrecision                : 38
Name                        : SP2013
NamedPipesEnabled           : True
NetName                     : SP2013
NumberOfLogFiles            : -1
OleDbProviderSettings       : 
OSVersion                   : 6.2 (9200)
PerfMonMode                 : None
PhysicalMemory              : 8192
PhysicalMemoryUsageInKB     : 372080
Platform                    : NT x64
Processors                  : 2
ProcessorUsage              : 0
Product                     : Microsoft SQL Server
ProductLevel                : SP1
Properties                  : {Name=AuditLevel/Type=Microsoft.SqlServer.Management.Smo.AuditLevel/Writable=True/Value=Failure, Name=BackupDirectory/Type=System.String/Writabl
ProxyAccount                : [SP2013]
PSChildName                 : Default
PSDrive                     : SQLSERVER
PSIsContainer               : False
PSParentPath                : Microsoft.SqlServer.Management.PSProvider\SqlServer::SQLSERVER:\sql\SP2013
PSPath                      : Microsoft.SqlServer.Management.PSProvider\SqlServer::SQLSERVER:\sql\SP2013\Default
PSProvider                  : Microsoft.SqlServer.Management.PSProvider\SqlServer
ResourceGovernor            : Microsoft.SqlServer.Management.Smo.ResourceGovernor
ResourceLastUpdateDateTime  : 10/19/2012 3:30:00 PM
ResourceVersion             : 11.0.3000
ResourceVersionString       : 11.00.3000
Roles                       : {bulkadmin, dbcreator, diskadmin, LimitedDBA...}
RootDirectory               : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL
ServerAuditSpecifications   : {}
ServerType                  : Standalone
ServiceAccount              : csd\administrator
ServiceInstanceId           : MSSQL11.MSSQLSERVER
ServiceMasterKey            : Microsoft.SqlServer.Management.Smo.ServiceMasterKey
ServiceName                 : MSSQLSERVER
ServiceStartMode            : Auto
Settings                    : Microsoft.SqlServer.Management.Smo.Settings
SqlCharSet                  : 13
SqlCharSetName              : cp950
SqlDomainGroup              : NT SERVICE\MSSQLSERVER
SqlSortOrder                : 0
SqlSortOrderName            : bin_ascii_8
State                       : Existing
Status                      : Online
SystemDataTypes             : {bigint, binary, bit, char...}
SystemMessages              : {21, 21, 21, 21...}
TapeLoadWaitTime            : -1
TcpEnabled                  : True
Triggers                    : {}
Urn                         : Server[@Name='SP2013']
UserData                    : 
UserDefinedMessages         : {59998, 59999}
UserOptions                 : Microsoft.SqlServer.Management.Smo.UserOptions
Version                     : 11.0.3128
VersionMajor                : 11
VersionMinor                : 0
VersionString               : 11.0.3128.0


#---------------------------------------------------------------
#   
#---------------------------------------------------------------



#---------------------------------------------------------------
#   5 350   SQLServers with SERVERPROPERTY
#---------------------------------------------------------------

USE [SQL_Inventory]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N’[dbo].[SQLServers]’)
AND type in (N’U’))
DROP TABLE [dbo].[SQLServers]
GO
CREATE TABLE [dbo].[SQLServers](
[MID] [varchar](128) ,
[SQLClusterName][varchar](128) NULL,
[instanceName] [varchar](128)  NULL,
--[hostName] [varchar](128) Null,
--[MID] [varchar](128) ,
[OSclusterName] [varchar](128) NULL,
[status] [char](20)  NULL,
[SQLstarttime] [smalldatetime] NULL,
[Node1Host][varchar](128) ,
[Node2Host][varchar](128) ,
[Node3Host][varchar](128) ,
[Node4Host][varchar](128) ,
[NodeOwnerHost][varchar](128) ,
[tcpPort] [smallint] NULL,
--[serverNetworkProtocols] [varchar](128) NULL,
[version] [varchar](10) NULL,
[editionName] [varchar](128) NULL,
[versioninternal] [varchar](20) NULL,
[servicePack] [varchar](10) NULL,
[remark] [varchar](512) NULL,
[systemDbDevice] [varchar](512) NULL,
--[errorLogLocation] [varchar](512) NULL,
[collation] [varchar](128) NULL,
[minMemory] [bigint] NULL,
[maxMemory] [bigint] NULL,
[alwaysonStatus] [bit] NULL,
[alwaysonEnabled] [bit] NULL,
[IsClustered] [int] NULL,
--[createDate] [smalldatetime] NULL,
[updateDate] [smalldatetime] NULL,
)

#-------------------------
$iSQLInstance="sp2013"
$iDatabase ='SQL_inventory'
 $Tsql="SELECT @@servername N'InstanceName',
 RIGHT(LEFT(@@VERSION,25),4) N'version' , 
 SERVERPROPERTY('ProductVersion') N'versioninternal',
 SERVERPROPERTY('ProductLevel') N'servicePack',
 SERVERPROPERTY('Edition') N'editionName',
 @@VERSION N'remark'
 ,SERVERPROPERTY('IsClustered') N'IsClustered'
 ,SERVERPROPERTY('HadrManagerStatus') N'alwaysonStatus' 
 ,SERVERPROPERTY('IsHadrEnabled') N'alwaysonEnabled' 
 ,SERVERPROPERTY('Collation') N'Collation'
 "
 #HadrManagerStatus :Indicates whether the AlwaysOn Availability Groups manager 
 #0 = Not started, pending communication.
 #1 = Started and running
 #2 = Not started and failed.
 #AlwaysOn Availability Groups is enabled on this server instance.
 #0 = The AlwaysOn Availability Groups feature is disabled.
 #1 = The AlwaysOn Availability Groups feature is enabled.

$hostlist = Invoke-Sqlcmd -Query "SELECT hostName FROM Hosts" -ServerInstance $iSQLInstance -Database $iDatabase

foreach ($item in $hostlist) { #86
   
    $hostName=$item.hostName;# Write-Host '#7---------' $hostName

    #$SQLgsvs=icm -ComputerName  $hostName -ScriptBlock {gsv | ? Name -like 'MSSQL*'} ##V3
    $SQLgsvs=icm -ComputerName  $item.hostName -ScriptBlock { gsv | ?  { $_.DisplayName -like 'SQL Server (*'}}

    #icm -ComputerName   $item.hostName -ScriptBlock { gsv | ?  { $_.DisplayName -like 'SQL Server (*'}}
    #icm -ComputerName  DGPAP2  { gsv | ?  { $_.DisplayName -like 'SQL Server (*'}}
    #icm -ComputerName  DGPAP2  { Invoke-Sqlcmd -Query "SELECT getdate()" -ServerInstance DGPAP2\SQL2008R2}

    Foreach ($SQLgsv in $SQLgsvs)
    { #.18
       # '            ---#20SQLgsv ---' + $SQLgsv.name  
     if (($SQLgsv.name).IndexOf('$') -eq -1)  #default
     { #23
         $pInstanceName='MSSQLSERVER'
         $gSQLInstance=$hostName
     }#23
     else{#23
     $pInstanceName=($SQLgsv.name).Substring(($SQLgsv.name).IndexOf('$')+1,($SQLgsv.name).Length- ($SQLgsv.name).IndexOf('$')-1) ;
     $gSQLInstance =$hostName+"\"+$pInstanceName
     #$pInstanceName
     #$SQLPort

     }#23
 
     if ($pInstanceName -ne 'SQLEXPRESS')
       {#34
          
        $TsqlGet=Invoke-Sqlcmd -Query $Tsql -ServerInstance $gSQLInstance # -Database $gDatabase
        $tInstanceName=$TsqlGet.InstanceName
        $tVersion=$TsqlGet.version
        $teditionName=$TsqlGet.editionName
        $tversioninternal=$TsqlGet.versioninternal
        $tservicePack=$TsqlGet.servicePack
        $tremark=$TsqlGet.remark        $TalwaysonStatus=$TsqlGet.alwaysonStatus        $TalwaysonEnabled=$TsqlGet.alwaysonEnabled        $TIsClustered=$TsqlGet.IsClustered        $tCollation=$TsqlGet.Collation    $sql_insert = @"INSERT INTO [SQLServers] ([instanceName],[Node1Host],[editionName],[Version],[versioninternal],[servicePack],[remark],[alwaysonStatus],[alwaysonEnabled],[IsClustered],[Collation],[updateDate]) VALUES ('$tInstanceName', '$hostName','$teditionName','$tVersion','$tversioninternal','$tservicePack','$tremark','$TalwaysonStatus','$TalwaysonEnabled','$TIsClustered','$tCollation',getdate())"@Invoke-Sqlcmd -Query $sql_insert -ServerInstance "sp2013" -Database SQL_inventory #-QueryTimeout
       }#34  
    }#.18
    
   }#86

  
#---------------------------------------------------------------
#  5 450  function GetTCPPort
#---------------------------------------------------------------   
# GetTCPPort  sp2013  SQL_inventory  DGPAP2\SQL2008R2 

function GetTCPPort ($iSQLInstance,$iDatabase,$pInstanceName)
{
    $SQLPort=""
    #$iSQLInstance="sp2013"
    #$iDatabase='SQL_inventory'
    #$pInstanceName='SQL2012X\SQLX2'#    DGPAP2\SQL2008R2      SP2013\SQLS2
     #$pInstanceName='SP2013'
     if ($pInstanceName.IndexOf('\') -eq -1) {
         $sInstanceName='MSSQLSERVER'}
     else{
         $sInstanceName=$pInstanceName.Substring($pInstanceName.IndexOf('\')+1,$pInstanceName.Length- $pInstanceName.IndexOf('\')-1) ;
     }
     #$sInstanceName

    $sqlstring="SELECT Node1Host,versioninternal FROM SQLServers where InstanceName = '$pInstanceName'"

    $sqlget = Invoke-Sqlcmd -Query $sqlstring -ServerInstance $iSQLInstance -Database $iDatabase

   switch (($sqlget.versioninternal).Substring(0,4))
   {
       '10.5' { #2009
                if ($sInstanceName -eq 'MSSQLSERVER')
                {
       $path='HKLM:\SOFTWARE\Microsoft\MSSQLServer\MSSQLServer\SuperSocketNetLib\Tcp'
       $SQLPort=icm -ComputerName ($sqlget.Node1Host) {param($path) (Get-ItemProperty -path $path).TcpPort } -ArgumentList $path
   
                }
                else
                {
       
       $path="HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$sInstanceName\MSSQLServer\SuperSocketNetLib\Tcp"
       $SQLPort=icm -ComputerName ($sqlget.Node1Host) {param($path) (Get-ItemProperty -path $path).TcpPort } -ArgumentList $path
                
                }
                }  #2009
      
       '11.0' { #2253
               if ($sInstanceName -eq 'MSSQLSERVER')
                {
                $path='HKLM:\SOFTWARE\Microsoft\MSSQLServer\MSSQLServer\SuperSocketNetLib\Tcp'
                $SQLPort=icm -ComputerName ($sqlget.Node1Host) {param($path) (Get-ItemProperty -path $path).TcpPort } -ArgumentList $path
        
                }
                else
                {
       $path="HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$sInstanceName\MSSQLServer\SuperSocketNetLib\Tcp"
       $SQLPort=icm -ComputerName ($sqlget.Node1Host) {param($path) (Get-ItemProperty -path $path).TcpPort } -ArgumentList $path
        
                }
                } #2253
       Default {}
   }
   $SQLPort
      
}



$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName FROM SQLServers" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
  $in=$instanceName.instanceName
  $TCP=GetTCPPort  sp2013  SQL_inventory  $in
  $sql_update= "update SQLServers set tcpport=$TCP  where  instanceName = '$in' "
  Invoke-Sqlcmd -Query $sql_update -ServerInstance "sp2013" -Database "SQL_inventory"  #-QueryTimeout
}

#---------------------------------------------------------------
# 6  500  function GetSQLServiceStatus
#--------------------------------------------------------------- 
function GetSQLServiceStatus ($pInstanceName)
{
    $SQLStatus="" 
    #$pInstanceName='SP2013\SQLS2'#    DGPAP2\SQL2008R2      SP2013\SQLS2  SQL2012X\SQLX2
     #$pInstanceName='SP2013'
     if ($pInstanceName.IndexOf('\') -eq -1) {
         $sInstanceName='MSSQLSERVER'
         $sHostname=$pInstanceName
         }
     else{
         $sHostname=$pInstanceName.Substring(0,$pInstanceName.IndexOf('\'))
         $sInstanceName=$pInstanceName.Substring($pInstanceName.IndexOf('\')+1,$pInstanceName.Length- $pInstanceName.IndexOf('\')-1) ;
         $sInstanceName='MSSQL$'+$sInstanceName
         }
    
     $SQLStatus= (gsv -ComputerName $sHostname -Name $sInstanceName).Status 
     $SQLStatus  
}

# 
#GetSQLServiceStatus  DGPAP2\SQL2008R2 
#GetSQLServiceStatus SP2013

$iSQLInstance="sp2013"
$iDatabase='SQL_inventory'
$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName FROM SQLServers" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
  $in=$instanceName.instanceName
  $SQLStatus=GetSQLServiceStatus  $in
  $sql_update= "update SQLServers set [Status]='$SQLStatus' , [updateDate]=getdate() where  instanceName = '$in'"
  Invoke-Sqlcmd -Query $sql_update -ServerInstance "sp2013" -Database "SQL_inventory"  #-QueryTimeout
}
#---------------------------------------------------------------
# 7 550 function GetSQLServiceStatus
#---------------------------------------------------------------
function GetSQLstarttime ($pInstanceName)
{
    
    $GetSQLstarttime=""
    #$pInstanceName='SQL2012X\SQLX2'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    $sqlstring='select sqlserver_start_time from sys.dm_os_sys_info'
    $GetSQLstarttime=(Invoke-Sqlcmd -Query $sqlstring -ServerInstance $pInstanceName).sqlserver_start_time
    $GetSQLstarttime
}

# 
#GetSQLstarttime  DGPAP2\SQL2008R2 
#GetSQLstarttime SP2013WFE

$iSQLInstance="sp2013"
$iDatabase='SQL_inventory'
$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName FROM SQLServers" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
  $in=$instanceName.instanceName
  $GetSQLstarttime= GetSQLstarttime  $in
  $sql_update= "update SQLServers set [SQLstarttime]='$GetSQLstarttime' , [updateDate]=getdate() where  instanceName = '$in'"
  #$sql_update
  Invoke-Sqlcmd -Query $sql_update -ServerInstance "sp2013" -Database "SQL_inventory"  #-QueryTimeout
}



#---------------------------------------------------------------
#  8 600 function GetSQLsystemDbDevice
#---------------------------------------------------------------
function GetSQLsystemDbDevice ($pInstanceName)
{
    
    $GetSQLstarttime=""
    #$pInstanceName='SQL2012X\SQLX2'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    $sqlstring="select physical_name from sys.master_files where name='master'"
    $GetSQLsystemDbDevice=(Invoke-Sqlcmd -Query $sqlstring -ServerInstance $pInstanceName).physical_name
    $GetSQLsystemDbDevice
}

# 
#GetSQLstarttime  DGPAP2\SQL2008R2 
#GetSQLstarttime SP2013WFE

$iSQLInstance="sp2013"
$iDatabase='SQL_inventory'
$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName FROM SQLServers" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
  $in=$instanceName.instanceName
  $GetSQLsystemDbDevice= GetSQLsystemDbDevice  $in
  $sql_update= "update SQLServers set [systemDbDevice]='$GetSQLsystemDbDevice' , [updateDate]=getdate() where  instanceName = '$in'"
  #$sql_update
  Invoke-Sqlcmd -Query $sql_update -ServerInstance "sp2013" -Database "SQL_inventory"  #-QueryTimeout
}


#---------------------------------------------------------------
#  9  650  SQLDatabases
#---------------------------------------------------------------

USE [SQL_Inventory]
GO


DROP TABLE [dbo].SQLDatabases
GO
CREATE TABLE [dbo].SQLDatabases(
    [instanceName] [varchar](128)  NULL,
	[MID] [varchar](128),
	[Databasename] [sysname]  NULL,
	[DataFilePath] nvarchar(255) NULL,
	[DataFileSizeG] float NULL,
	[LogFilePath] nvarchar(255) NULL,
	[LogFileSizeG] float  NULL,
	[file_idnum]  [nvarchar](60) NULL,
	[database_id] [int]  NULL,
	[compatibility_level] [tinyint]  NULL,
	[create_date] [datetime]  NULL,
	[drop_date][datetime]  NULL,
	[collation_name] [sysname] NULL,
	[recovery_model_desc] [nvarchar](60) NULL,
	[state_desc] [nvarchar](60) NULL,
	[is_published] [bit]  NULL,
	[is_subscribed] [bit]  NULL,
	[is_distributor] [bit]  NULL,
	[user_access_desc] [nvarchar](60) NULL,
	[updateDate] [smalldatetime] NULL,
	
	) ON [PRIMARY]

GO


#---------------------------------------------------------------
#  10 650 function GetSQLdatabases
#---------------------------------------------------------------
function GetSQLdatabases ($pInstanceName)
{
    
    #$pInstanceName='2013BI'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    $sqlstring="select name,database_id,compatibility_level,create_date,collation_name,recovery_model_desc,state_desc
,is_published,is_subscribed,is_distributor,user_access_desc from  master.sys.databases"
    $GetSQLdatabases=(Invoke-Sqlcmd -Query $sqlstring -ServerInstance $pInstanceName)
    $GetSQLdatabases
    foreach ($GetSQLdatabase  in $GetSQLdatabases )
{ #1235
       $databasename=$GetSQLdatabase.name
       $databaseid=$GetSQLdatabase.database_id
       $compatibilitylevel=$GetSQLdatabase.compatibility_level
       
       $createdate=$GetSQLdatabase.create_date
       $collationname=$GetSQLdatabase.collation_name
       $recovery_model_desc=$GetSQLdatabase.recovery_model_desc
       $statedesc=$GetSQLdatabase.state_desc
          
       $ispublished=$GetSQLdatabase.is_published
       $issubscribed=$GetSQLdatabase.is_subscribed
       $isdistributor=$GetSQLdatabase.is_distributor 
       $useraccessdesc=$GetSQLdatabase.user_access_desc
            
              $sql_insert = @"INSERT INTO [SQLDatabases] ([instanceName],[databasename],[database_id],[compatibility_level],[create_date],[collation_name],[recovery_model_desc],[state_desc],[is_published],[is_subscribed],[is_distributor],[user_access_desc],[updateDate]) VALUES ('$pinstanceName', '$databasename','$databaseid','$compatibilitylevel' ,'$createdate','$collationname','$recovery_model_desc','$statedesc','$ispublished','$issubscribed','$isdistributor','$useraccessdesc',getdate())"@
 $sql_insert 
 Invoke-Sqlcmd -Query $sql_insert -ServerInstance "sp2013" -Database SQL_inventory #-QueryTimeout

}#1235

}

# 
#GetSQLstarttime  DGPAP2\SQL2008R2 
#GetSQLstarttime SP2013WFE

$iSQLInstance="sp2013"
$iDatabase='SQL_inventory'
$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName FROM SQLServers" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
  $in=$instanceName.instanceName
  $GetSQLsystemDbDevice= GetSQLdatabases  $in  
}

#---------------------------------------------------------------
# 11 750  function GetSQLDBFileSize
#---------------------------------------------------------------
function GetSQLDBFileSize ($pInstanceName,[int] $databaseid)
{
    
    #$databaseid='5'#    DGPAP2\SQL2008R2      SP2013\SQLS2
    #$pInstanceName='sp2013'
    $sqlstring1="select physical_name as [DataFilePath],Size *0.000008 as [DataFileSizeG]
    from msdb.sys.master_files where type=0   and FILE_ID=1 and database_id='$databaseid'"

    $GetSQLFile1=(Invoke-Sqlcmd -Query $sqlstring1 -ServerInstance $pInstanceName)
    $DataPath=$GetSQLFile1.DataFilePath
    $Datasize=$GetSQLFile1.DataFileSizeG

    $sqlstring2="select physical_name as [LogFilePath],Size *0.000008 as [LogFileSizeG]
    from msdb.sys.master_files where type=1   and FILE_ID=2 and database_id='$databaseid'"

    $GetSQLFile2=(Invoke-Sqlcmd -Query $sqlstring2 -ServerInstance $pInstanceName)
    $LogPath=$GetSQLFile2.LogFilePath
    $Logsize=$GetSQLFile2.LogFileSizeG
    $DataPath,$Datasize,$LogPath,$Logsize

}


$iSQLInstance="sp2013"
$iDatabase='SQL_inventory'
$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName,database_id FROM SQLDatabases" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
 
  $Fileset= GetSQLDBFileSize  ($instanceName.instanceName) ($instanceName.database_id) 
  $dl=$Fileset[0];$ds=$Fileset[1];$ll=$Fileset[2];$ls=$Fileset[3]
  $inx=$instanceName.instanceName
  $dix=$instanceName.database_id
  $sql_update= "update SQLDatabases set [DataFilePath]='$dl', [DataFileSizeG]='$ds' 
  , [LogFilePath]='$ll' , [LogFileSizeG]='$ls' , [updateDate]=getdate() where  instanceName = '$inx' and  database_id= '$dix'"
  #$sql_update
  Invoke-Sqlcmd -Query $sql_update -ServerInstance "sp2013" -Database "SQL_inventory"  #-QueryTimeout

}

#---------------------------------------------------------------
# 12 800  GetDBfileNum
#---------------------------------------------------------------
function GetDBfileNum ($pInstanceName)
{
  
    $sqlstring1="select database_id,count(file_id) as [cfid] from msdb.sys.master_files  group by database_id"

    $fileidcounts=(Invoke-Sqlcmd -Query $sqlstring1 -ServerInstance $pInstanceName)
   foreach ($fileidcount  in $fileidcounts )
{ #1027
     $databaseid=$fileidcount.database_id
     $cfid=$fileidcount.cfid
  $sql_update= "update SQLDatabases set [file_idnum]='$cfid' , [updateDate]=getdate() where  instanceName = '$pInstanceName' and  database_id= '$databaseid'"

  Invoke-Sqlcmd -Query $sql_update -ServerInstance "sp2013" -Database "SQL_inventory"  #-QueryTimeout
}#1027

}
#GetDBfileNum  "sp2013" 

$iSQLInstance="sp2013"
$iDatabase='SQL_inventory'
$instanceNames = Invoke-Sqlcmd -Query "SELECT instanceName,database_id FROM SQLDatabases" -ServerInstance $iSQLInstance -Database $iDatabase
foreach ($instanceName  in $instanceNames )
{
  GetDBfileNum  ($instanceName.instanceName) 
}



#---------------------------------------------------------------
# 13 800  function updateMID
#---------------------------------------------------------------
function updateMID ($udatabase,$ivSQL,$ivDatabase)
{
#$ivSQL="spm"
#$ivDatabase='SQL_inventory'
#$udatabase='HostsDisks'
  
    $sqlstring="select distinct d.hostname ,h.mid as [mid] from  hosts H join  $udatabase D on d.hostName=H.hostName"

    $GetMIDs=Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivDatabase
   foreach ($GetMID  in $GetMIDs )
{ #1027
     $tmid=$GetMID.mid
     $phostname=$GetMID.hostname
     $sql_update= "update $udatabase set [Mid]='$tmid' where  hostName = '$phostname'"
     #$sql_update
     Invoke-Sqlcmd -Query $sql_update -ServerInstance $ivSQL  -Database $ivDatabase  #-QueryTimeout
}#1027

}
updateMID  HostsDisks SPM SQL_i_inventory
updateMID  SQLDisks SPM SQL_i_inventory

#---------------------------------------------------------------
# 14 850  table HostsDisks
#---------------------------------------------------------------



USE [SQL_Inventory]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id =
OBJECT_ID(N'[dbo].[HostsDisks]') AND type in (N'U'))
DROP TABLE [dbo].[HostsDisks]
GO
CREATE TABLE [dbo].HostsDisks(
[MID] [varchar](128) ,
[instanceName] [varchar](128),
[hostName] [varchar](128) Null,
[drive] [char](5)  NULL,
[totalSizeG] [bigint],
[freeSpaceG] [bigint],
[total_datafile_sizeG] bigint,
[total_logfile_sizeG] bigint,
[total_filestream_sizeG] bigint,
[total_fulltext_sizeG] bigint,
[updateDate] [smalldatetime] NOT NULL default getDate()
)
GO

select * from HostsDisks


#---------------------------------------------------------------
# 15 900  get  instance information inventory  to CSV  p116
#---------------------------------------------------------------

#replace this with your instance name
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName


#specify folder and filename to be produced
$folder = "H:\Temp"
$currdate = Get-Date -Format "yyyy-MM-dd_hmmtt"
$filename = "$($instanceName)_InstanceInventory_$($currdate).csv"
$fullpath = Join-Path $folder $filename

#export all “server” object properties
#note we are using V3 simplified Where-Object syntax

$server | gm |
? Name -ne "SystemMessages" |
? MemberType -eq "Property" |
Select Name, @{Name="Value";Expression={$server.($_.Name)}} |
Export-Csv -Path $fullpath -NoTypeInformation


#jobs are also extremely important to monitor, archive export all job names + last run date and result

$server.JobServer.Jobs |
Select @{Name="Name";Expression={"Job: $($_.Name)"}}, @{Name="Value";Expression={"Last run: $($_.LastRunDate)($($_.LastRunOutcome))" }} |
Export-Csv -Path $fullpath -NoTypeInformation -Append
#show file in explorer
explorer $folder

##


$Ri=$server | gm |
? Name -ne "SystemMessages" |
? MemberType -eq "Property" |
Select Name, @{Name="Value";Expression={$server.($_.Name)}} 


$ri.Count  #108
$ri[1].Name;
$ri[1].Value
$ri[2].Name;$ri[2].Value
$ri[60].Name;$ri[60].Value
$ri[107].Name;$ri[107].Value

#---------------------------------------------------------------
# 16 950  get  Database information inventory  to CSV  p116
#---------------------------------------------------------------
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#specify folder and filename to be produced
$folder = "H:\Temp"
$currdate = Get-Date -Format "yyyy-MM-dd_hmmtt"
$filename = "$($instanceName)_DatabaseInventory_$($currdate).csv"
$fullpath = Join-Path $folder $filename

$result = @()



#get properties of all databases in instance
foreach ($db in $server.Databases)
{
$item = $null
#capture info you want to capture into a hash
#the hash will make it easier to export to CSV


$hash = @{
"DatabaseName" = $db.Name
"CreateDate" = $db.CreateDate
"Owner" = $db.Owner
"RecoveryModel" = $db.RecoveryModel
"SizeMB" = $db.Size
"DataSpaceUsage" = ($db.DataSpaceUsage/1MB).ToString("0.00")
"IndexSpaceUsage" = ($db.IndexSpaceUsage/1MB).ToString("0.00")
"Collation" = $db.Collation
"Users" = (($db.Users | Foreach {$_.Name}) -join",")
"UserCount" = $db.Users.Count
"TableCount" = $db.Tables.Count
"SPCount" = $db.StoredProcedures.Count
"UDFCount" = $db.UserDefinedFunctions.Count
"ViewCount" = $db.Views.Count
"TriggerCount" = $db.Triggers.Count
"LastBackupDate" = $db.LastBackupDate
"LastDiffBackupDate" = $db.LastDifferentialBackupDate
"LastLogBackupDate" = $db.LastBackupDate
}
#create a new "row" and add to the results array
$item = New-Object PSObject -Property $hash
$result += $item
}
#export result to CSV
#note CSV can be opened in Excel, which is handy

$result |
Select DatabaseName, CreateDate, Owner, RecoveryModel,
SizeMB, DataSpaceUsage, IndexSpaceUsage, Collation, UserCount,
TableCount, SPCount, ViewCount, TriggerCount, LastBackupDate,
LastDiffBackupDate, LastLogBackupDate, Users |
Export-Csv -Path $fullpath -NoTypeInformation
#view folder
explorer $folder
#---------------------------------------------------------------
#  17  1000 get database using SMO
#---------------------------------------------------------------

{
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

foreach ($db in $server.Databases)
{$db | select *}

Name                                     : WSS_Content_spload
DatabaseOwnershipChaining                : False
ExtendedProperties                       : {}
DatabaseOptions                          : Microsoft.SqlServer.Management.Smo.DatabaseOptions
Synonyms                                 : {}
Sequences                                : {}
Federations                              : 
Tables                                   : {AllDocs, AllDocVersions,AllFileFragments, AllLinks...}
StoredProcedures                         : {proc_AcquireSiteUpgradeSession,proc_ActivateFeature,  proc_AddAuditEntry,  proc_AddAuditEntryFromSql...}
Assemblies                               : {Microsoft.SqlServer.Types}
UserDefinedTypes                         : {}
UserDefinedAggregates                    : {}
FullTextCatalogs                         : {}
FullTextStopLists                        : {}
SearchPropertyLists                      : {}
Certificates                             : {}
SymmetricKeys                            : {}
AsymmetricKeys                           : {}
DatabaseEncryptionKey                    : Microsoft.SqlServer.Management.Smo.DatabaseEncryptionKey
ExtendedStoredProcedures                 : {sp_AddFunctionalUnitToComponent,sp_audit_write, sp_availability_group_command_internal, sp_begin_parallel_nested_tran...}
UserDefinedFunctions                     : {fn_AllDocs_DiffLevelDiffNextBSN,fn_AllDocs_HasStream,fn_AllDocs_Id_Top1,fn_AllDocVersions_HasStream...}
Views                                    : {Docs, Lists, Sec_SiteGroupsView, Sites...}
Users                                    : {dbo, guest, INFORMATION_SCHEMA, sys}
DatabaseAuditSpecifications              : {}
Schemas                                  : {db_accessadmin, db_backupoperator, db_datareader, db_datawriter...}
Roles                                    : {db_accessadmin, db_backupoperator, db_datareader, db_datawriter...}
ApplicationRoles                         : {}
LogFiles                                 : {WSS_Content_spload_log}
FileGroups                               : {PRIMARY}
PlanGuides                               : {}
Defaults                                 : {}
Rules                                    : {}
UserDefinedDataTypes                     : {tCompressedBinary, tCompressedString, tContentTypeId, tPermMask...}
UserDefinedTableTypes                    : {tvpAppResourceEntries, tvpArrayOfBigInts, tvpArrayOfBinary, tvpArrayOfBits...}
XmlSchemaCollections                     : {}
PartitionFunctions                       : {}
PartitionSchemes                         : {}
ActiveDirectory                          : 
MasterKey                                : 
Triggers                                 : {}
DefaultLanguage                          : Microsoft.SqlServer.Management.Smo.DefaultLanguage
DefaultFullTextLanguage                  : Microsoft.SqlServer.Management.Smo.DefaultLanguage
ServiceBroker                            : Microsoft.SqlServer.Management.Smo.Broker.ServiceBroker
IsVarDecimalStorageFormatEnabled         : True
Parent                                   : [sp2013]
ActiveConnections                        : 2
AnsiNullDefault                          : False
AnsiNullsEnabled                         : False
AnsiPaddingEnabled                       : False
AnsiWarningsEnabled                      : False
ArithmeticAbortEnabled                   : False
AutoClose                                : False
AutoCreateStatisticsEnabled              : False
AutoShrink                               : False
AutoUpdateStatisticsAsync                : False
AutoUpdateStatisticsEnabled              : False
AvailabilityDatabaseSynchronizationState : 
AvailabilityGroupName                    : 
BrokerEnabled                            : True
CaseSensitive                            : False
ChangeTrackingAutoCleanUp                : False
ChangeTrackingEnabled                    : False
ChangeTrackingRetentionPeriod            : 0
ChangeTrackingRetentionPeriodUnits       : None
CloseCursorsOnCommitEnabled              : False
Collation                                : Latin1_General_CI_AS_KS_WS
CompatibilityLevel                       : Version110
ConcatenateNullYieldsNull                : False
ContainmentType                          : None
CreateDate                               : 2/17/2014 4:09:17 PM
DatabaseGuid                             : a9859ac7-3fb3-49da-b506-ac72fa118e4d
DatabaseSnapshotBaseName                 : 
DataSpaceUsage                           : 19552
DateCorrelationOptimization              : False
DboLogin                                 : True
DefaultFileGroup                         : PRIMARY
DefaultFileStreamFileGroup               : 
DefaultFullTextCatalog                   : 
DefaultSchema                            : dbo
EncryptionEnabled                        : False
FilestreamDirectoryName                  : 
FilestreamNonTransactedAccess            : Off
HonorBrokerPriority                      : False
ID                                       : 19
IndexSpaceUsage                          : 8304
IsAccessible                             : True
IsDatabaseSnapshot                       : False
IsDatabaseSnapshotBase                   : False
IsDbAccessAdmin                          : True
IsDbBackupOperator                       : True
IsDbDatareader                           : True
IsDbDatawriter                           : True
IsDbDdlAdmin                             : True
IsDbDenyDatareader                       : False
IsDbDenyDatawriter                       : False
IsDbOwner                                : True
IsDbSecurityAdmin                        : True
IsFullTextEnabled                        : True
IsMailHost                               : False
IsManagementDataWarehouse                : False
IsMirroringEnabled                       : False
IsParameterizationForced                 : False
IsReadCommittedSnapshotOn                : False
IsSystemObject                           : False
IsUpdateable                             : True
LastBackupDate                           : 2/17/2014 4:07:36 PM
LastDifferentialBackupDate               : 1/1/0001 12:00:00 AM
LastLogBackupDate                        : 2/17/2014 4:10:07 PM
LocalCursorsDefault                      : False
LogReuseWaitStatus                       : LogBackup
MirroringFailoverLogSequenceNumber       : 0
MirroringID                              : 00000000-0000-0000-0000-000000000000
MirroringPartner                         : 
MirroringPartnerInstance                 : 
MirroringRedoQueueMaxSize                : 0
MirroringRoleSequence                    : 0
MirroringSafetyLevel                     : None
MirroringSafetySequence                  : 0
MirroringStatus                          : None
MirroringTimeout                         : 0
MirroringWitness                         : 
MirroringWitnessStatus                   : None
NestedTriggersEnabled                    : True
NumericRoundAbortEnabled                 : False
Owner                                    : CSD\administrator
PageVerify                               : Checksum
PrimaryFilePath                          : C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA
QuotedIdentifiersEnabled                 : False
ReadOnly                                 : False
RecoveryForkGuid                         : 4775f100-8e2f-4dcf-817b-610e0f67a8a6
RecoveryModel                            : Full
RecursiveTriggersEnabled                 : False
ReplicationOptions                       : None
ServiceBrokerGuid                        : a16f3607-7699-438c-a80a-9064fd12e054
Size                                     : 381.0625
SnapshotIsolationState                   : Disabled
SpaceAvailable                           : 1672
Status                                   : Normal
TargetRecoveryTime                       : 0
TransformNoiseWords                      : False
Trustworthy                              : False
TwoDigitYearCutoff                       : 2049
UserAccess                               : Multiple
UserName                                 : dbo
Version                                  : 706
IsDbManager                              : 
IsFederationMember                       : 
IsLoginManager                           : 
Events                                   : Microsoft.SqlServer.Management.Smo.DatabaseEvents
Urn                                      : Server[@Name='SP2013']/Database[@Name='WSS_Content_spload']
Properties                               : {Name=ActiveConnections/Type=System.Int32/Writable=False/Value=2, Name=AutoClose/Type=System.Boolean/Writable=True/Value=False, Name=AutoShrink/
                                           Type=System.Boolean/Writable=True/Value=False, Name=CompatibilityLevel/Type=Microsoft.SqlServer.Management.Smo.CompatibilityLevel/Writable=True/Value=Version110...}
UserData                                 : 
State                                    : Existing
IsDesignMode                             : False

}
#---------------------------------------------------------------
#  18  1200 GetHostDisks
#---------------------------------------------------------------

{

$ivSQL="SPM"
$ivdatabase='SQL_inventory'

#-function GetHostDisks ($hostname) 
#-{ #5
   $sqlstring="select distinct Node1Host from SQLServers" 
   $Get1s=(Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivdatabase)
   #$Get1s
   

   foreach ($Get1 in $Get1s)
   {#245
     $hostname1=$Get1.Node1Host 
     #  '-----------'+$Get1.SQLClusterName  + ' --- '+ $Get1.Node1Host
     $rs=gwmi win32_logicaldisk -ComputerName $hostname1 -Filter "FileSystem='NTFS'" |select name,size,freespace
    

     if ($rs -eq $Null){ contiune }
     foreach($r in $rs)
     {#105
     #$Get1.SQLClusterName
     #$Get1.Node1Host
     $disklabel=$r.name
    
     $totalsize=[math]::round(($r.size)/1073741824, 0)
     $FreeSize =[math]::round(($r.freespace)/1073741824, 0)
     #$disklabel + ' -- ' +$totalsize +' -- '+ $FreeSize
     
     $sqlstring="select hostName from HostsDisks where  drive= '"+$disklabel +"' and totalSizeG = '"+ $totalsize + "' and hostName = '"+ $hostname1 + "' "  
    
     
     $Get2s=(Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivdatabase)
      if ($Get2s -ne $Null)
      {#90
          'Update'
          #$sql_update= "update HostsDisks set [file_idnum]='$cfid' , [updateDate]=getdate() where  instanceName = '$pInstanceName' and  database_id= '$databaseid'"
      }#90
      else
      {#90
         $sql_insert = @"INSERT INTO [HostsDisks] ([hostname],[drive],[totalSizeG],[freeSpaceG],[updateDate]) VALUES ('$hostname1', '$disklabel','$totalsize' ,'$FreeSize',getdate())"@$sql_insert#Invoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivdatabase #-QueryTimeout
      }#90
     }#105
   }#245
#-}#5
}
#---------------------------------------------------------------
# 19 1200  <SQLDisk>  + Function updateSQLDisks
#---------------------------------------------------------------
 


USE [SQL_Inventory]
GO

DROP TABLE [dbo].[SQLDisks]
GO
CREATE TABLE [dbo].SQLDisks(
[MID] [varchar](128) ,
[SQLCluster] [varchar](128) ,
[SQLInstance] [varchar](128),
[hostName] [varchar](128) Null,
[Databasename] [varchar](128) Null,
[DBLOGFilename] [varchar](128) Null,
[physicalName] [varchar](256) Null,
[drive] [char](5)  NULL,
[GetSizeG] [float],
[updateDate] [smalldatetime] NOT NULL default getDate()
)
GO

select * from SQLDisks

##---------
#$ivSQL="spm"
#$ivDatabase='SQL_inventory'

function updateSQLdisks ($ivSQL,$ivDatabase)
{ #5
#$ivSQL="SPM"
#$ivdatabase='SQL_inventory'

   #$sqlstring="select distinct instanceName from SQLServers" 
   $Get1s=(Invoke-Sqlcmd -Query "select distinct instanceName from SQLServers"  -ServerInstance $ivSQL -Database $ivdatabase)
   #$Get1s
   

   foreach ($Get1 in $Get1s)
   {#245
    $sqlstring="select DB_NAME(database_id) as gdatabase,name as Filename ,physical_name,size*0.000008 as [getsizeG] from sys.master_files 
    where DB_NAME(database_id) not in ('master','tempdb','model','msdb') order by DB_NAME(database_id)"
    $gSQLinstname=$Get1.instanceName
  
     $rs=Invoke-Sqlcmd -Query $sqlstring  -ServerInstance $Get1.instanceName # -Database $ivdatabase
      

     if ($rs -eq $Null){ contiune }
     
     foreach($r in $rs)
     {#105
   
   
     $gDatbaseName=$r.gdatabase
     $gDBFilename=$r.filename
     $gphysical_name =$r.physical_name
     $ggetsizeG =$r.getsizeG 
     $gdrive=$gphysical_name.Substring(0,2)

     #$gDatbaseName; $gfilename ; $gphysical_name ;$ggetsizeG
     
     
     $sqlstring="select SQLinstance from SQLDisks where  SQLinstance= '"+$gSQLinstname +"' and DatabaseName = '"+ $gDatbaseName + "' and DBLOGFilename= '"+$gDBFilename +"' "  
    
      
     $Get2s=Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivdatabase
      
      if ($Get2s -ne $Null)
      {#90 'Update  GetSizeG  updateDate'
          #$sql_update= "update HostsDisks set [file_idnum]='$cfid' , [updateDate]=getdate() where  instanceName = '$pInstanceName' and  database_id= '$databaseid'"
      }#90
      else
      {#90 'insert'
                $sql_insert = @"INSERT INTO [SQLDisks] ([SQLInstance],[Databasename],[DBLOGFilename],[physicalName],[GetSizeG],[drive],[updateDate]) VALUES ('$gSQLinstname', '$gDatbaseName','$gDBFilename' ,'$gphysical_name','$gGetSizeG','$gdrive',getdate())"@#$sql_insertInvoke-Sqlcmd -Query $sql_insert -ServerInstance $ivSQL -Database $ivdatabase #-QueryTimeout
     
      }#90
      
     }#105
     
   }#245
}#5

updateSQLdisks spm SQL_inventory SQLDisks


##---update MID ,hostname for 
$ivSQL="spm"
$ivDatabase='SQL_inventory'
$udatabase='SQLDisks'
  
    $sqlstring="select distinct h.instancename as instancename,h.mid  as [mid] ,node1host as [node1host] from  SQLServers H join  SQLDisks D on d.sQLinstance=H.instancename"

    $GetMIDs=Invoke-Sqlcmd -Query $sqlstring -ServerInstance $ivSQL -Database $ivDatabase
   foreach ($GetMID  in $GetMIDs )
{ #1027
     $tmid=$GetMID.mid
     $phostname=$GetMID.node1host
     $ginstancename=$GetMID.instancename
     $sql_update= "update SQLDisks set [Mid]= '"+$tmid+"', hostname= '" +$phostname+"'  where  sQLinstance = '"+$ginstancename +"'"
     $sql_update
     Invoke-Sqlcmd -Query $sql_update -ServerInstance $ivSQL  -Database $ivDatabase  #-QueryTimeout
}#1027

##---- check TSQL


select Databasename,physicalName,GetSizeG,totalSizeG,freeSpaceG from SQLDisks s
join hostsdisks h on s.mid=h.mid
where h.mid='39' and h.drive=s.drive




#---------------------------------------------------------------
# 20  1400  step by step DMV to SQL_inventory
#---------------------------------------------------------------


step 1 : select * into statusOSPCR FROM sys.dm_os_performance_counters
step 2 : open table desgin on SSMS + [updateDate] [datetime] NULL  
       ALTER TABLE [dbo].[statusLogSize] ADD  CONSTRAINT [DF_statusLogSize_updateDate]  DEFAULT (getdate()) FOR [updateDate]
Step 3 : script table as  drop and create
step 4 : 

SELECT 
    c.name 'Column Name',
    t.Name 'Data type',
    c.max_length 'Max Length',
    c.precision ,
    c.scale ,
    c.is_nullable,
    ISNULL(i.is_primary_key, 0) 'Primary Key'
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE
    c.object_id = OBJECT_ID('[dm_hadr_database_replica_cluster_states]')









#---------------------------------------------------------------
# 21  1400  DBCC to SQL_inventory
#---------------------------------------------------------------
{<#
## table 
{
USE [SQL_Inventory]
GO

ALTER TABLE [dbo].[statusLogSize] DROP CONSTRAINT [DF_statusLogSize_updateDate]
GO

/****** Object:  Table [dbo].[statusLogSize]    Script Date: 7/19/2014 9:26:36 AM ******/
DROP TABLE [dbo].[statusLogSize]
GO

/****** Object:  Table [dbo].[statusLogSize]    Script Date: 7/19/2014 9:26:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[statusLogSize](
	[DatabaseName] [nvarchar](255) NOT NULL,
	[LogSizeMB] [float] NULL,
	[LogSpaceUsed] [float] NULL,
	[Status] [int] NULL,
	[updateDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[statusLogSize] ADD  CONSTRAINT [DF_statusLogSize_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
}

##  main p90
Param(
  [string] $para_svrinstance,
  [string] $para_database
)
#$para_svrinstance="spm"
#$para_database   ="SQL_Inventory"

$LOGSPACES = Invoke-Sqlcmd  -ServerInstance $para_svrinstance -Query "DBCC SQLPERF('LOGSPACE')"
foreach ($LOGSPACE in $LOGSPACES)
{ #p90
    #for ($i = 0; $i -lt ($LOGSPACE.ItemArray).Count; $i++)
    #{ #p.1396
       $vDatabaseName=$LOGSPACE[0]
       $vLogSizeMB=$LOGSPACE[1] 
       $vLogSpaceUsed=$LOGSPACE[2] 
       $vStatus=$LOGSPACE[3]  
     #}#p.1396

$sql_insert =@" 
INSERT INTO [dbo].[statusLogSize]
           ([DatabaseName]
           ,[LogSizeMB]
           ,[LogSpaceUsed]
           ,[Status])
     VALUES
           ('$vDatabaseName'
           ,'$vLogSizeMB'  
           ,'$vLogSpaceUsed'
           ,'$vStatus'
           )
"@
       #$sql_insert 
       Invoke-Sqlcmd -Query $sql_insert -ServerInstance $para_svrinstance -Database $para_database #-QueryTimeout
      
    
}#p90

$sql_select ="select * from [SQL_Inventory].[dbo].[statusLogSize] order by logSpaceused desc"
{
  select * from [SQL_Inventory].[dbo].[statusLogSize] order by logSpaceused desc

  truncate table [SQL_Inventory].[dbo].[statusLogSize]
  select * from [SQL_Inventory].[dbo].[statusLogSize] order by logSpaceused desc
  }
$LOGSPACE[18]
($LOGSPACE[0].ItemArray).Count
$LOGSPACE[0][2]
$LOGSPACE.Count
#>}

#---------------------------------------------------------------
# 22   1456  get  Table index  filegroup 
#---------------------------------------------------------------
{<#
use mingDB
SELECT o.[name], o.[type], i.[name], i.[index_id], f.[name]
FROM sys.indexes i
INNER JOIN sys.filegroups f ON i.data_space_id = f.data_space_id
INNER JOIN sys.all_objects o ON i.[object_id] = o.[object_id]
WHERE  o.type='U'

WHERE i.data_space_id = f.data_space_id and o.type='U'
AND i.data_space_id = 2 -- Filegroup
GO
select * from sys.indexes
select * from sys.tables WHERE  type='U'
select * from sys.filegroups 
select name,* from sys.all_objects where type='U'

select * from sys.all_objects 
join  sys.filegroups  
ON i.[object_id] = o.[object_id]
#>}

#---------------------------------------------------------------
# 99  ps1
#---------------------------------------------------------------
drop table [dbo].[ps1]

CREATE TABLE [dbo].[ps1](
	[Filename] [varchar](128) NOT NULL,
	[Description] [varchar](500) NULL,
	[Tab] [varchar](500) NULL,
	[Parent] [varchar](500) NULL,
	[createDate] [smalldatetime] NOT NULL,
	[updateDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ps1] PRIMARY KEY CLUSTERED ([Filename] ASC)
) 

GO

ALTER TABLE [dbo].[ps1]
ADD CONSTRAINT DF_ps1_createDate
DEFAULT (getdate()) FOR createDate
GO

ALTER TABLE [dbo].[ps1]
ADD CONSTRAINT DF_ps1_updateDate
DEFAULT (getdate()) FOR updateDate
GO



use SQL_Inventory

update ps1 set  Description=N'IIS  gps gsv wmi'
,updatedate=getdate()
 where [Filename]='OS08_System'

select * from ps1 where tab like '%profile%' and parent is null

delete from ps1 where [Filename] like 'sq%'
truncate table ps1

Insert into  ps1 (Filename,Description,tab,parent) VALUES 
('OS00_Index'      ,N'Index',N'Index',Null)
('OS01_General'    ,N'pipeline,function,workflow, snap-in ',N'profile ,math ,string ,Time ,other ,variable ,array,',Null)
('OS02_performance',N'Powershell start',N'powershell',Null)
('OS03_SendMail'   ,N'Powershell start',N'powershell',Null)
('OS04_firewall'   ,N'create firewall',N'powershell',Null)
('OS05_Job'        ,N'job , schedule task',N'job , scheduletask , Event',Null)
('OS06_remote'     ,N'enabling,disabling, session',N'powershell',Null)
('OS07_file'       ,N'Powershell start',N'powershell',Null)
('OS08_System'     ,N'IIS , Server manage, HyperV, Network,DNS',N'WmiObject',Null)
('OS09_modules'    ,N'type,import ,reload, write, check ',N'powershell',Null)
('OS10_AD'         ,N'installation AD, Account ,Group policy ,Domain Controller ',N'AD ',Null)
('OS11_UC'         ,N'Exchange ,Lync , Office365 ,sharepoint Online',N'exchagne,Lync ',Null)
('OS12_cloud'      ,N'Azure  install, connection, ',N'cloud ',Null)
('OS13_SC'         ,N'SystemCenter ',N'cloud ',Null)
('OS14_Vendor'     ,N'VMWare ,Citrix ,Cisco ,Quest ',N'cloud ',Null)
('OS15_cluster'    ,N'cluster , ',N' ',Null)



('OS02_01_diskIO'  ,N'Powershell start','powershell',N'OS02_performance')
('OS02_02_diskIO_multi',N'Powershell start','powershell',N'OS02_performance')
('OS02_03_Sharepoint_SQL'  ,N'Sharepoint 2013 + SQL 2012','powershell',N'OS02_performance')



Insert into  ps1 (Filename,Description,tab,parent) VALUES 
('SQLPS00_enable'            ,N'Basic Task','powershell',NULL)
('SQLPS01_alwayson'          ,N'Powershell start','powershell',NULL)
('SQLPS02_Sqlconfiguration'  ,N'filegroup ,index fragmentation ,job ,operator','powershell',NULL)
('SQLPS03_Invoke'            ,N'Powershell start','powershell',NULL)
('SQLPS04_extendedevent'     ,N'Powershell start','powershell',NULL)
('SQLPS05_DMV'               ,N'Powershell start','powershell',NULL)
('SQLPS05_01_DMV_OSPerf'     ,N'Powershell start','powershell',N'SQLPS05_DMV')
('SQLPS05_02_DMV_Transcation',N'lock ,block, deadlock','powershell',N'SQLPS05_DMV')
('SQLPS06_BCP'               ,N'BCP','powershell',NULL)
('SQLPS07_General'           ,N'advnaced administrator Tasks , event alert',N'EXEC (@SQL)',NULL)
('SQLPS08_Inventory'         ,N'Inventory','powershell',NULL)
('SQLPS09_replication'       ,NULL,'powershell',NULL)
('SQLPS10_storedprocedure'   ,NULL,'powershell',NULL)
('SQLPS11_alert'             ,N'alert,database Mail,',N'   ',NULL)
('SQLPS12_security'           NULL,'security ,Aduit',NULL)
('SQLPS13_TDE'               ,NULL,'powershell',NULL)
('SQLPS14_backupRestore'     ,NULL,'powershell',NULL)
('SQLPS15_Mirroring'         ,N'Mirroring','powershell',NULL)
('SQLPS16_ResourceManager'   ,NULL,'powershell',NULL)
('SQLPS17_triggers'          ,NULL,'powershell',NULL)
('SQLPS18_Profiler'          ,N'change tacking,trace,distribut Replay',N'change tacking,trace,',NULL)
('SQLPS19_Agent'             ,NULL,'powershell',NULL)
('SQLPS20_policy'            ,NULL,'powershell',NULL)
('SQLPS21_BI'                ,N'SSRS ,SSAS ,SSIS ',N'powershell',NULL)



Insert into  ps1 (Filename,Description,tab,parent) VALUES ('OS07_file',N'Powershell start','powershell',N'OS02_performance')


select * from ps1
truncate table ps1











#---------------------------------------------------------------
# 1590   WhatsGoingOnHistory
#---------------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTEDCREATE TABLE dbo.WhatsGoingOnHistory([Runtime] [DateTime],[session_id] [smallint] NOT NULL,[login_name] [varchar](128) NOT NULL,[host_name] [varchar](128) NULL,[DBName] [varchar](128) NULL,[Individual Query] [varchar](max) NULL,[Parent Query] [varchar](200) NULL,[status] [varchar](30) NULL,[start_time] [datetime] NULL,[wait_type] [varchar](60) NULL,[program_name] [varchar](128) NULL
)
GO


#---------------------------------------------------------------
# 1612   SQLEventLog
#---------------------------------------------------------------

https://msdn.microsoft.com/zh-tw/library/ms164086(v=sql.120).aspx


select * from sys.messages where language_id='1028' and message_id=49904 

select * from sys.messages where language_id='1028' and is_event_logged=1 and message_id=9689 

select * from sys.messages where language_id='1028' and message_id=3408 
select * from sys.messages where language_id='1028' and message_id=9689 
select * from sys.messages where language_id='1028' and message_id=26060
select * from sys.messages where language_id='1028' and message_id=17148 
select * from sys.messages where language_id='1028' and message_id=19032 