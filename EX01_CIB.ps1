<#

C:\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\EX01_CIB.ps1

CreateDate: AUG.19.2015LastDate : AUG.19.2015Author :Ming Tseng  ,a0921887912@gmail.com  ming_tseng@syscom.com.twremark 


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\EX01_CIB.ps1

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

________________________________________________________________________________________________________________________________________

#00  base info
#01  Add-WindowsFeature PowerShell-ISE
#02  74 enable winrm & configuation
#03  109  get systeminfo
#04  139  get Disk
#05  173  get install product
#06  185  get services 
#07  197   get firewall rule 
#08  230　get SQL master_files
#09  246  　get SQL version
#10  269  　get SQL Job
#11  291 　get SQL databaseinfo
#12  312 　get SQL  serverinfo
#13  333 　get SQL backup 
#14  360  　get SQL SSIS  packages 
#15  get Host performance
#16  get SQL create script




#-----------------------------------
#00  base info
#-----------------------------------
$infoPath ='H:\'
$env:COMPUTERNAME  SP2013
COM-DB-SQL1   10.150.100.1
COM-DB-SQL2   10.150.100.2
COM-DB-SQL3   10.150.100.3
COM-DB-SQL5   10.150.100.5
COM-DB-SQL6   10.150.100.6
COM-DB-SQL7   10.150.100.7

$servers='COM-DB-SQL1','COM-DB-SQL2','COM-DB-SQL3','COM-DB-SQL5','COM-DB-SQL6','COM-DB-SQL7'
$servers='sp2013','PMD','sql2012x','2016BI'


$username = 'PMD\administrator'
$password = 'p@ssw0rd'


$PSVersionTable
<#
Name                           Value                                                      
----                           -----                                                      
CLRVersion                     2.0.50727.4927                                             
BuildVersion                   6.1.7600.16385                                             
PSVersion                      2.0                                                        
WSManStackVersion              2.0                                                        
PSCompatibleVersions           {1.0, 2.0}                                                 
SerializationVersion           1.1.0.1                                                    
PSRemotingProtocolVersion      2.1 

http://learn-powershell.net/2013/10/25/powershell-4-0-now-available-for-download/

Name                           Value                                                                                                                                     
----                           -----                                                                                                                                     
PSVersion                      4.0                                                                                                                                       
WSManStackVersion              3.0                                                                                                                                       
SerializationVersion           1.1.0.1                                                                                                                                   
CLRVersion                     4.0.30319.34014                                                                                                                           
BuildVersion                   6.3.9600.17400                                                                                                                            
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0}                                                                                                                      
PSRemotingProtocolVersion      2.2                                                                                                                                       
#>

#-----------------------------------
#01  Add-WindowsFeature PowerShell-ISE
#-----------------------------------
Import-Module ServerManager 
Add-WindowsFeature PowerShell-ISE

 Set-ExecutionPolicy RemoteSigned


#-----------------------------------
#02  74 enable winrm & configuation
#-----------------------------------
notepad  C:\Windows\System32\drivers\etc\hosts    add:  172.16.201.147          PMD

telnet  PMD  5985 # pass

Enable-PSRemoting   # Note: firewall port  5985 
Get-counter  use port
#Disable-PSRemoting


# if the remote computer is not in a trusted domain, 將  目標電腦(被控台(PMD))新增到 主控台(SP2013TrustedHosts 組態設定中
winrm qc # if need  run at COM-DB-SQLx
winrm e winrm/config/listener

winrm e winrm/config/listener
winrm set   winrm/config/client @{TrustedHosts="COM-DB-SQL1,COM-DB-SQL2,COM-DB-SQL3,COM-DB-SQL5,COM-DB-SQL6,COM-DB-SQL9,PMD"}  

#run sp2013
winrm set  winrm/config/client @{TrustedHosts="COM-DB-SQL1,COM-DB-SQL2,COM-DB-SQL3,COM-DB-SQL5,COM-DB-SQL6,COM-DB-SQL9,PMD2016"}  

winrm g winrm/config # get TrustedHosts

Test-WSMan -ComputerName PMD2016
Test-WSMan -ComputerName PMD

<#
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 2.0
#>
ping PMD2016  #  192.168.112.144
gps -ComputerName PMD2016
gps -ComputerName 192.168.112.144

icm -ComputerName PMD2016 -ScriptBlock {Stop-Process 12420}

gps -ComputerName PMD
get-counter -ComputerName 192.168.112.144
get-counter -ComputerName PMD2016
get-counter '\\192.168.112.144\\physicaldisk(_total)\% disk time'



gwmi Win32_Service  -ComputerName PMD2016 |select name 
gwmi Win32_Service  -ComputerName 192.168.112.144 |select name 


ping PMD

icm -ComputerName PMD2016 -ScriptBlock {hostname} #|out-file 


#-----------------------------------
#03  109  get systeminfo
#-----------------------------------
$infoPath ='H:\'
$reportfile=$infoPath+'CIB_SYSTEMINFO.txt'
$username = 'PMD\administrator'
$password = 'p@ssw0rd'

$servers='sp2013','PMD','sql2012x','2016BI'
$servers='sp2013','sql2012x','2016BI'
ri $reportfile
# case 1

$cred = New-Object System.Management.Automation.PSCredential -ArgumentList @($username,(ConvertTo-SecureString -String $password -AsPlainText -Force))

Invoke-Command -ComputerName $servers -Credential $cred -ScriptBlock  {systeminfo}  | Out-File $reportfile -Append
Invoke-Command -ComputerName $servers  -ScriptBlock  {systeminfo} | Out-File $reportfile -Append ;ii $reportfile

# case 2
$infoPath ='H:\'
$reportfile=$infoPath+'CIB_Win32_OperatingSystem.txt'
$username = 'PMD\administrator'
$password = 'p@ssw0rd'
ri $reportfile
gwmi   Win32_OperatingSystem  -comp $servers |select * | Out-File $reportfile -Append  ;ii 

get-wmiobject Win32_OperatingSystem  ; $computerOS |select * 

#-----------------------------------
#04  139  get Disk
#-----------------------------------


$reportfile=$infoPath+'CIB_DISK.txt'
ri $reportfile
gwmi -ComputerName $servers -Class Win32_Volume | sort systemname,DriveLetter |`
select @{N="systemName";E={$_.systemname}} `
,@{N="Name";E={$_.Name}} `
,@{N="DriveLetter";E={$_.DriveLetter}} `
,@{N="DeviceType";E={switch ($_.DriveType){0 {"Unknown"}
1 {"No Root Directory"}
2 {"Removable Disk"}
3 {"Local Disk"}
4 {"Network Drive"}
5 {"Compact Disk"}
6 {"RAM"}
}};} `
,@{N="Size(GB)";E={"{0:N1}" -f($_.Capacity/1GB)}}`
,@{N="FreeSpace(GB)";E={"{0:N1}" -f($_.FreeSpace/1GB)}} `
,@{N="FreeSpacePercent";E={if ($_.Capacity -gt 0){"{0:P0}" -f($_.FreeSpace/$_.Capacity)}else{0}}} `
 |Format-Table -AutoSize |Out-File  $reportfile
 ii $reportfile






#-----------------------------------
#05  173  get install product
#-----------------------------------

$reportfile=$infoPath+'CIB_Win32_Product.txt'
ri $reportfile
gwmi -Class Win32_Product -ComputerName  $servers   |select PSComputerName,Name,version,InstallLocation,Caption,Description,InstallDate,packageName `
|Format-Table -AutoSize |Out-File  $reportfile -Width  1024

ii $reportfile


#-----------------------------------
#06  185  get services 
#-----------------------------------
$reportfile=$infoPath+'CIB_Services.txt'
#ri $reportfile
foreach ($server in $servers)
{
    $server |Out-File  $reportfile  -Append 
    gsv -ComputerName $server |Out-File  $reportfile  -Append
}
ii $reportfile

#-----------------------------------
#07 197   get firewall rule 
#-----------------------------------
Get-NetFirewallProfile  -name   Private ,Public,Domain
$reportfile=$infoPath+'CIB_FirewallRule.txt'

$ScriptBlock={Get-NetFirewallProfile -Name Public | Get-NetFirewallRule | select name,DisplayGroup, displayname, enabled}



$cred = New-Object System.Management.Automation.PSCredential -ArgumentList @($username,(ConvertTo-SecureString -String $password -AsPlainText -Force))

foreach ($server in $servers)
{
 $server |Out-File  $reportfile  -Append 
#icm -ComputerName PMD     -ScriptBlock $ScriptBlock -Credential $cred  | Out-File $reportfile -Append
icm -ComputerName $server  -ScriptBlock $ScriptBlock     |ft -AutoSize  | Out-File $reportfile -Append
}

ii $reportfile

#-----------------------------------
#08 230　get SQL master_files
#-----------------------------------
 Add-PSSnapin SqlServerCmdletSnapin100


Import-Module sqlps -DisableNameChecking
Import-Module  'C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS' -DisableNameChecking
$ivsql="sp2013"


$reportfile=$infoPath+'CIB_master_files.txt'
$tsql_masterfile="select name,physical_name,size *0.000008 from sys.master_files"

 Invoke-Sqlcmd -Query $tsql_masterfile -ServerInstance $ivsql |Out-File  $reportfile  -Append

#-----------------------------------
#09 246  　get SQL version
#-----------------------------------
$reportfile=$infoPath+'CIB_SQLEdition.txt'


$tsql_SQLedition=@"
SELECT 
  @@servername N'SQLServerName',
 RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'
"@

foreach ($server in $servers)
{
    Invoke-Sqlcmd -Query $tsql_SQLedition -ServerInstance $server |Out-File  $reportfile  -Append
}


#-----------------------------------
#10 269  　get SQL Job
#-----------------------------------
$reportfile=$infoPath+'CIB_SQLJob.txt'



foreach ($server in $servers)
{
$server |Out-File  $reportfile  -Append 
#$server = "WIN-2S026UBRQFO"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $server

$jobs=$server.JobServer.Jobs
$jobs |
Select Name, OwnerLoginName, LastRunDate, LastRunOutcome |
Sort -Property Name |
Format-Table -AutoSize  |Out-File  $reportfile  -Append

}


#-----------------------------------
#11  291 　get SQL databaseinfo
#-----------------------------------
$reportfile=$infoPath+'CIB_DatabaseInfo.txt'
foreach ($server in $servers)
{
$server |Out-File  $reportfile  -Append 
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $server
$dbS=$server.Databases 

$i=$dbS.Count
foreach ($db in $dbS)
{
    "------$i--------------------$db.name-------------------------" | out-file c:\temp\master.txt -Append 
    $db |select * | out-file c:\temp\master.txt -Append -force
    ;$i=$i-1
}

}
ri $reportfile
ii $reportfile
#-----------------------------------
#12 312 　get SQL  serverinfo
#-----------------------------------

$reportfile=$infoPath+'CIB_SQLInfo.txt'
foreach ($server in $servers)
{
$server |Out-File  $reportfile  -Append 
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $server
$server |select * |out-file |Out-File  $reportfile  -Append
$server.Information|Out-File  $reportfile  -Append

"------------------------------------------------------------"|Out-File  $reportfile  -Append 

}
ri $reportfile
ii $reportfile




#-----------------------------------
#13 333 　get SQL backup 
#-----------------------------------

SELECT
DATABASE_NAME as '資料庫名稱',
CASE [type]   
WHEN 'D' THEN N'資料庫' 
WHEN 'I' THEN N'差異資料庫' 
WHEN 'L' THEN N'紀錄' 
WHEN 'F' THEN N'檔案或檔案群組' 
WHEN 'G' THEN N'差異檔案' 
WHEN 'P' THEN N'部分' 
WHEN 'Q' THEN N'差異部分' 
ELSE N'NULL' 
END as '備份類型', 
--RECOVERY_MODEL as '還原模式',
DATABASE_BACKUP_LSN as '完整資料庫備份之LSN',
FIRST_LSN as '第一個LSN',
LAST_LSN as '下一個LSN',
DIFFERENTIAL_BASE_LSN as '差異備份的基底LSN',
backup_start_date as '備份開始時間', 
backup_finish_date as '備份完成時間',
backup_size *0.000000001
FROM msdb.dbo.backupset 
WHERE DATABASE_NAME='ssmatesterdb'
order by backup_finish_date desc
#-----------------------------------
#14 360  　get SQL SSIS  packages 
#-----------------------------------
-- List all SSIS packages stored in msdb database. 
SELECT PCK.name AS PackageName 
      ,PCK.[description] AS [Description] 
      ,FLD.foldername AS FolderName 
      ,CASE PCK.packagetype 
            WHEN 0 THEN 'Default client' 
            WHEN 1 THEN 'I/O Wizard' 
            WHEN 2 THEN 'DTS Designer' 
            WHEN 3 THEN 'Replication' 
            WHEN 5 THEN 'SSIS Designer' 
            WHEN 6 THEN 'Maintenance Plan' 
            ELSE 'Unknown' END AS PackageTye 
      ,LG.name AS OwnerName 
      ,PCK.isencrypted AS IsEncrypted 
      ,PCK.createdate AS CreateDate 
      ,CONVERT(varchar(10), vermajor) 
       + '.' + CONVERT(varchar(10), verminor) 
       + '.' + CONVERT(varchar(10), verbuild) AS Version 
      ,PCK.vercomments AS VersionComment 
      ,DATALENGTH(PCK.packagedata) AS PackageSize 
FROM msdb.dbo.sysdtspackages90 AS PCK 
     INNER JOIN msdb.dbo.sysdtspackagefolders90 AS FLD 
         ON PCK.folderid = FLD.folderid 
     INNER JOIN sys.syslogins AS LG 
         ON PCK.ownersid = LG.sid 
ORDER BY PCK.name;




#-----------------------------------
#16 411 　get SQL create script
#-----------------------------------
Generate a Script 


In Object Explorer, expand Databases, right-click a "database", point to "Tasks", and then click Generate Scripts. 
Follow the steps in the wizard to script the database objects.
On the Choose Objects page, select the objects to be included in the script. For more information, see Generate and Publish Scripts Wizard (Choose Objects Page).
On the Set Scripting Options page, select Save scripts to a specific location.
To specify advanced scripting options, select the Advanced button in the Save scripts to a specific location section.
Select the location for the generated script: to a file, a Database Engine Query Editor window, or the Clipboard.
For more information, see Generate and Publish Scripts Wizard (Set Scripting Options Page).
On the Summary page, review your selections. Click Previous to change your selections. Click Next to generate a script of the objects you selected. For more information, see Generate and Publish Scripts Wizard (Summary Page).
On the Save or Publish Scripts page, monitor the progress of the script generation. For more information, see Generate and Publish Scripts Wizard (Save or Publish Scripts Page)
Object Explorer Script as Menu

You can use the Object Explorer Script as menu to script a single object, script multiple objects, or script multiple statement


#-----------------------------------
#15  　get Host performance
#-----------------------------------


#-----------------------------------
# step1  General script  at  A  & B SQLServer 
#-----------------------------------
$Filepath='D:\MyScriptsDirectory' # local directory to save build-scripts to
$DataSource='PMD2016'             # server name and instance
$Database='SQL_inventory'         # the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource

if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};

$transfer = new-object ("$My.Transfer") $db
$CreationScriptOptions = new-object ("$My.ScriptingOptions") 
$CreationScriptOptions.ExtendedProperties= $true # yes, we want these
$CreationScriptOptions.DRIAll  = $true # and all the constraints 
$CreationScriptOptions.Indexes = $true # Yup, these would be nice
$CreationScriptOptions.Triggers= $true # This should be included when scripting a database
$CreationScriptOptions.ScriptBatchTerminator = $true # this only goes to the file
$CreationScriptOptions.IncludeHeaders = $true; # of course
$CreationScriptOptions.ToFileOnly = $true #no need of string output as well
$CreationScriptOptions.IncludeIfNotExists = $true # not necessary but it means the script can be more versatile
$CreationScriptOptions.Filename =  "$($FilePath)\$($Database)_Build.sql"; 

$transfer = new-object ("$My.Transfer") $s.Databases[$Database]

$transfer.options=$CreationScriptOptions # tell the transfer object of our preferences
$transfer.ScriptTransfer()
"All done"

#-----------------------------------
# step2  compare-two file 
#-----------------------------------
$A='D:\MyScriptsDirectory\SQL_inventory_Build_A.sql'
$B='D:\MyScriptsDirectory\SQL_inventory_Build_B.sql'



function Compare-Files{
param(
$file1,
$file2,
[switch]$IncludeEqual
)
$content1 = Get-Content $file1
$content2 = Get-Content $file2


#$comparedLines = Compare-Object $content1 $content2 -IncludeEqual:$IncludeEqual | group { $_.InputObject.ReadCount } | sort Name
$comparedLines = Compare-Object $content1 $content2 | group { $_.InputObject.ReadCount } | sort Name


$comparedLines | foreach {
$curr=$_
switch ($_.Group[0].SideIndicator){
“==” { $right=$left = $curr.Group[0].InputObject;break}
“=>” { $right,$left = $curr.Group[0].InputObject,$curr.Group[1].InputObject;break }
“<=" { $right,$left = $curr.Group[1].InputObject,$curr.Group[0].InputObject;break }
}
[PSCustomObject] @{
Line = $_.Name
Left = $left
Right = $right
}
}
}



Compare-Files $A $B
[switch]$IncludeEqual
)
$content1 = Get-Content $file1
$content2 = Get-Content $file2


#$comparedLines = Compare-Object $content1 $content2 -IncludeEqual:$IncludeEqual | group { $_.InputObject.ReadCount } | sort Name
$comparedLines = Compare-Object $content1 $content2 | group { $_.InputObject.ReadCount } | sort Name


$comparedLines | foreach {
$curr=$_
switch ($_.Group[0].SideIndicator){
“==” { $right=$left = $curr.Group[0].InputObject;break}
“=>” { $right,$left = $curr.Group[0].InputObject,$curr.Group[1].InputObject;break }
“<=" { $right,$left = $curr.Group[1].InputObject,$curr.Group[0].InputObject;break }
}
[PSCustomObject] @{
Line = $_.Name
Left = $left
Right = $right
}
}
}



Compare-Files $A $B

________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________



________________________________________________________________________________________________________________________________________
