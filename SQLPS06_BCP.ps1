<#
 BCP
 Bulk export using Powershell
 filelocation : C:\Users\administrator.CSD\SkyDrive\download\ps1\SQLPS06_BCP.ps1 CreateDate: Jan.02.2013 LastDate : APR.27.2014 Author :Ming Tseng  ,a0921887912@gmail.comremark 

SET STATISTICS TIME OFF /ON

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SQLPS06_BCP.ps1

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
#  (1)  50  bulk export using invoke-sqlcmd to CSV file
#  (2)  100 bulk export using BCP  P102
#  (3) 150  bulk import using BULK INSERT from CSV p.105

#(99)my test Person.persony #--------------------------------------------------------
#  (1)  50  bulk export using invoke-sqlcmd to CSV file
#--------------------------------------------------------make h:\temp
#import SQL Server module
Import-Module SQLPS -DisableNameChecking#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#database handle
$dbName = "AdventureWorks2008R2"
$db = $server.Databases[$dbName]

#export file name
$exportfile = "H:\Temp\Person_Person.csv"
$query = @"
SELECT
*
FROM
Person.Person
"@
Invoke-Sqlcmd -Query $query -ServerInstance "$instanceName" -Database $dbName |
Export-Csv -LiteralPath $exportfile -NoTypeInformation#--------------------------------------------------------
#  (2)  100 bulk export using BCP  P102
#--------------------------------------------------------#$instanceName = "sp2013"

$server = "sp2013"$table="AdventureWorks2008R2.Person.Person"$curdate = Get-Date -Format "yyyy-MM-dd_hmmtt" ;$foldername = "H:\Temp\Exports\"  ;$foldername 

#format file name
$formatfilename = "$($table)_$($curdate).fmt" ;$formatfilename

#export file name
$exportfilename = "$($table)_$($curdate).csv" ;$exportfilename

$destination_formatfilename="$foldername$formatfilename"          ;$destination_formatfilename
$destination_exportfilename = "$($foldername)$($exportfilename)"  ;$destination_exportfilename
#command to generate format file

$cmdformatfile = "bcp $table format nul -T -c -t `"|`" -r `"\n`" -f `"$($destination_formatfilename)`" -S $($server)" ;$cmdformatfile

#command to generate the export file
$cmdexport = "bcp $($table) out `"$destination_exportfilename`" -S $($server) -T -f `"$destination_formatfilename`""  ;$cmdexport<#
$cmdformatfile gives you something like this:

bcp AdventureWorks2008R2.Person.Person format nul -T -c -t "|" -r "\n" -f "H:\Temp\Exports\AdventureWorks2008R2.Person.Person_2014-04-27_1032AM.fmt" -S sp2013

PS C:\> 

$cmdexport gives you something like this:

bcp AdventureWorks2008R2.Person.Person out "C:\Temp\Exports\AdventureWorks2008R2.Person.Person_2011-12-27_913PM.csv" -SKERRIGAN -T -c -f "C:\Temp\Exports\AdventureWorks2008R2.Per
son.Person_2011-12-27_913PM.fmt"

#>
#run the format file command
Invoke-Expression $cmdformatfile#delay 1 sec, give server some time to generate the format file
#sleep helps us avoid race conditions
Start-Sleep -s 1

#run the export command
Invoke-Expression $cmdexport

#check the folder for generated file
explorer.exe $foldername#--------------------------------------------------------
#  (3) 150  bulk import using BULK INSERT from CSV p.105
#--------------------------------------------------------##Getting readyCREATE SCHEMA [Test]
GOCREATE TABLE [Test].[Person](
[BusinessEntityID] [int] NOT NULL PRIMARY KEY,
[PersonType] [nchar](2) NOT NULL,
[NameStyle] [dbo].[NameStyle] NOT NULL,
[Title] [nvarchar](8) NULL,
[FirstName] [dbo].[Name] NOT NULL,
[MiddleName] [dbo].[Name] NULL,
[LastName] [dbo].[Name] NOT NULL,
[Suffix] [nvarchar](10) NULL,
[EmailPromotion] [int] NOT NULL,
[AdditionalContactInfo] [xml] NULL,
[Demographics] [xml] NULL,
[rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL,
[ModifiedDate] [datetime] NOT NULL
)
GOH:\Temp\Exports.#function global:Import-Person {function Import-Person {
<#
.SYNOPSIS
Very simple function to get number
of records in Test.Person
.NOTES
Author : Donabel Santos
.LINK
http://www.sqlmusings.com
#>
param([string]$instanceName,[string]$dbName)$query = @"
TRUNCATE TABLE Test.Person
GO
BULK INSERT AdventureWorks2008R2.Test.Person
FROM 'C:\Temp\Exports\AdventureWorks2008R2.Person.Person.csv'
WITH
(
FIELDTERMINATOR ='|',
ROWTERMINATOR ='\n'
)
SELECT COUNT(*) AS NumRecords
FROM AdventureWorks2008R2.Test.Person
"@;

#check number of records
Invoke-Sqlcmd -Query $query `
-ServerInstance "$instanceName" `
-Database $dbName
}$instanceName = "SP2013"
$dbName = "AdventureWorks2008R2"
Import-Person $instanceName $dbName#--------------------------------------------------------
#  (4)  200  bulk import using bcp  p.110
#--------------------------------------------------------## Getting ReadyCREATE SCHEMA [Test]
GO
CREATE TABLE [Test].[Person](
[BusinessEntityID] [int] NOT NULL PRIMARY KEY,
[PersonType] [nchar](2) NOT NULL,
[NameStyle] [dbo].[NameStyle] NOT NULL,
[Title] [nvarchar](8) NULL,
[FirstName] [dbo].[Name] NOT NULL,
[MiddleName] [dbo].[Name] NULL,
[LastName] [dbo].[Name] NOT NULL,
[Suffix] [nvarchar](10) NULL,
[EmailPromotion] [int] NOT NULL,
[AdditionalContactInfo] [xml] NULL,
[Demographics] [xml] NULL,
[rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL,
[ModifiedDate] [datetime] NOT NULL
)
GO##Import-Module SQLPS -DisableNameChecking
$instanceName = "SP2013"
$dbName = "AdventureWorks2008R2"function Truncate-Table {
param([string]$instanceName,[string]$dbName)
$query = @"
TRUNCATE TABLE Test.Person
"@
#check number of records
Invoke-Sqlcmd -Query $query `
-ServerInstance $instanceName `
-Database $dbName
}function Get-PersonCount {
param([string]$instanceName,[string]$dbName)
$query = @"
SELECT COUNT(*) AS NumRecords
FROM Test.Person
"@
#check number of records
Invoke-Sqlcmd -Query $query `
-ServerInstance $instanceName `
-Database $dbName
}#let's clean up the Test.Person table first
Truncate-Table $instanceName $dbName
$server = "sp2013"
$table = "AdventureWorks2008R2.Test.Person"
$importfile = "C:\Temp\Exports\AdventureWorks2008R2.Person.Person.csv"

#command to import from csv
$cmdimport = "bcp $($table) in `"$($importfile)`" -S$server -T -c -t `"|`" -r `"\n`" "<#
$cmdimport gives you something like this:
bcp AdventureWorks2008R2.Test.Person in "C:\Temp\Exports\AdventureWorks2008R2.Person.Person.csv" –S SP2013 -T -c -t "|" -r "\n"
#>#run the import command
Invoke-Expression $cmdimport

#delay 1 sec, give server some time to import records
#sleep helps us avoid race conditions
Start-Sleep -s 2
Get-PersonCount $instanceName $dbName#--------------------------------------------------------
#  
#--------------------------------------------------------#--------------------------------------------------------
#  
#--------------------------------------------------------#--------------------------------------------------------
#  
#--------------------------------------------------------#--------------------------------------------------------
#  
#--------------------------------------------------------#--------------------------------------------------------
#  
#--------------------------------------------------------bcp AdventureWorks.Sales.Currency out Currency.dat -T -c #-T 指定 bcp 公用程式使用整合式安全性的信任連接  -c利用字元資料類型來執行作業。 
 bcp AdventureWorks.Sales.Currency out Currency.dat -c -U<login_id>
 -S<server_name\instance_name>

bcp AdventureWorks2012.Person.persony format nul -c -t, -x -f persony.Xml -T

#--------------------------------------------------------
# (99)      C5S300KR50K
#C520KS26GR50K   529435	26066.9844	51627.13876	44263.56846
#--------------------------------------------------------
$serverinstance='SPM'
$outtabletabe='AdventureWorks2012.Production.Illustration'
$filename='c:\temp\'+ 'Illustration' 
$intable='AdventureWorks2012.dbo.C5S300KR50K'
  
bcp $outtabletabe out  $filename".dat" -T  -c -S $serverinstance
bcp $outtabletabe format nul -c -t -f $filename'.Fmt' -T    -S $serverinstance

$ts1=get-date
for ($i = 1; $i -lt 2800000; $i++)
{ 
   bcp $intable in $filename'.dat'  -f $filename'.Fmt' -T -c 
}
$ts4=get-date
"(p.31  Execution  Time = "+($ts4-$ts1).TotalMinutes  +" Minutes"




bcp AdventureWorks2012.Person.persony out  c:\temp\persony.dat -T  -c 


bcp AdventureWorks2012.Person.persony out  c:\temp\persony.dat -T  -c 

bcp AdventureWorks2012.Sales.Currency out c:\temp\Currency.dat -T -c
#---------------------------------------
#  Person.persony                    ( 779941	507.9453	682.89687        	682.74982  )
#  dbo.C800KMS500MR07K	 (779941	406.7578	546.85736     	546.63679  bcp in  size
#---------------------------------------
$outtable='AdventureWorks2012.Person.persony'
$filename='c:\temp\'+ 'persony' 
$intable='mingDB.dbo.C800KMS500MR07K'

$filename+".dat"

$t1=get-date
bcp $outtable out   $filename".dat"  -T  -c -S SPM  # 199M
$t2=get-date; "  Execution  Time = "+($t2-$t1).TotalSeconds  +" Minutes"   #26.289673sec

bcp $outtable format nul -c -t -f $filename'.Fmt' -T -S SPM    #2K

$t1=get-date
 bcp $intable in $filename'.dat'  -f $filename'.Fmt' -T -c   -S SPM 
$t2=get-date; "  Execution  Time = "+($t2-$t1).TotalSeconds  +" Seconds"  #64.9607492 Seconds  ,時間 (毫秒) 總計     : 63188  平均 : (每秒 12343.18 資料列)


#---------------------------------------
# dbo.C4MS1GR3K   	4019495	892.6328	 232.86342	           232.85934
# dbo.C4MS1GR3k	   4019495	    892.6328	 232.86342	           232.85934
#---------------------------------------
$outtable='mingDB.dbo.C4MS1GR3K'
$filename='c:\temp\'+ 'C4MS1GR3K' 
$intable='mingDB.dbo.C4MS1GR3K'



$t1=get-date
bcp $outtable out   $filename".dat"  -T  -c -S SPM  # 563M
$t2=get-date; "  Execution  Time = "+($t2-$t1).TotalSeconds  +" Seconds"   #   42.5450654 sec

bcp $outtable format nul -c -t -f $filename'.Fmt' -T -S SPM    #2K
bcp $outtable format nul -c -t -x -f  $filename'.Xml' -T -S SPM 

$t1=get-date
 bcp $intable in $filename'.dat'  -f $filename'.Fmt' -T -c   -S SPM 
$t2=get-date; "  Execution  Time = "+($t2-$t1).TotalSeconds  +" Seconds"  #136.4061528 Seconds  ,時間 (毫秒) 總計     : 134453 平均 : (每秒 29895.17 資料列)

#---------------------------------------
# dbo.AllDocStreams	         7805	   17241.2031	2316298.75823	      2272470.24625  
#[WSS_Content_PMD].[dbo].[AllDocStreams]
# C8KS17GR3M 
#    AllDocStreams0100.dat
#---------------------------------------
$outtable='[WSS_Content_PMD].[dbo].[AllDocStreams]'
$filename='c:\temp\'+ 'AllDocStreams' 
$intable='mingDB.dbo.C8KS17GR3M'



$t1=get-date
#bcp $outtable out   $filename".dat"  -T  -c -S SPM  # 
bcp "SELECT   *  FROM [WSS_Content_PMD].[dbo].[AllDocStreams] " queryout  $filename".dat"  -T  -c -S SPM  
$t2=get-date; "  Execution  Time = "+($t2-$t1).TotalMinutes  +" Minutes"   #   

bcp $outtable format nul -c -t -f $filename'.Fmt' -T -S SPM    #1K
##  in 
$t1=get-date
bcp $intable in C:\temp\AllDocStreams0100.dat  -f $filename'.Fmt' -T -c   -S SPM 
#bcp $intable in C:\temp\AllDocStreams0500.dat  -f $filename'.Fmt' -T -c   -S SPM 
#  bcp $intable in C:\temp\AllDocStreams1000.dat  -f $filename'.Fmt' -T -c   -S SPM 
  bcp $intable in C:\temp\AllDocStreams2000.dat  -f $filename'.Fmt' -T -c   -S SPM 
$t2=get-date; "  Execution  Time = "+($t2-$t1).TotalMinutes  +" Minutes"  #136.4061528 Seconds  ,時間 (毫秒) 總計     : 134453 平均 : (每秒 29895.17 資料列)


<####################################################################>
C8KS17GR3M

$outtable='mingDB.dbo.C8KS17GR3M'
$filename='c:\temp\'+ 'C8KS17GR3M_100' 
$intable='mingDB.dbo.C8KS17GR3M'

bcp $outtable out   $filename".dat"  -T  -c -S SPM  # 563M
bcp $outtable format nul -c -t -f $filename'.Fmt' -T -S SPM    #1K













#---------------------------------------
USE mingdb
GO
truncate table [dbo].C8KS17GR3M
GO
SET STATISTICS TIME ON
BULK INSERT C8KS17GR3M 
   FROM 'C:\temp\AllDocStreams0500.dat' 
   WITH (FORMATFILE = 'c:\temp\AllDocStreams.Fmt');
GO
SET STATISTICS TIME OFF


SELECT count(*) FROM C8KS17GR3M;
GO
#---------------------------------------


$ts1=get-date
for ($i = 1; $i -lt 2800000; $i++)
{ 
  
}
$ts4=get-date
