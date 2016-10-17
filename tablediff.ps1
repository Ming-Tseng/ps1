tablediff 
-sourceserver "SQL2005" 
-sourcedatabase "MyDB1" 
-sourcetable "ABC" 
-destinationserver "SQL2005" 
-destinationdatabase "MyDB2" 
-destinationtable "ABC"





####  39
use s1
CREATE TABLE dbo.CompareTable (col1 int identity(1,1),col2 varchar(10))
GO
INSERT INTO dbo.CompareTable (col2)
SELECT 'test' UNION ALL
SELECT 'test1' UNION ALL
SELECT 'test2'
GO

select * from dgpap1.S1.dbo.CompareTable 

CREATE TABLE dbo.CompareTable1 (col1 int identity(1,1),col2 varchar(10))
GO
INSERT INTO dbo.CompareTable1 (col2)
SELECT 'test' UNION ALL
SELECT 'test1' UNION ALL
SELECT 'test2'
GO

####   40
use D1
CREATE TABLE dbo.CompareTable(col1 int identity(1,1),col2 varchar(10))
GO
INSERT INTO dbo.CompareTable (col2)
SELECT 'test1' UNION ALL
SELECT 'test2'
GO
CREATE TABLE dbo.CompareTable1 (col1 int identity(1,1),col2 varchar(10))
GO
INSERT INTO dbo.CompareTable1 (col2)
SELECT 'test' UNION ALL
SELECT 'test1' UNION ALL
SELECT 'test2'
GO

##
SELECT * FROM dgpap1.S1.dbo.CompareTable
SELECT * FROM dgpap1.S1.dbo.CompareTable1
SELECT * FROM dgpap2.D1.dbo.CompareTable
SELECT * FROM dgpap2.D1.dbo.CompareTable1

& "C:\Program Files\Microsoft SQL Server\110\COM\tablediff.exe" `
-SourceServer dgpap1 `
-SourceDatabase S1 `
-sourcetable CompareTable `
-DestinationServer dgpap2 `
-DestinationDatabase D1 `
-destinationtable  CompareTable -c -f H:\Z\Script
  
& "C:\Program Files\Microsoft SQL Server\110\COM\tablediff.exe" `
-SourceServer dgpap1 `
-SourceDatabase S1 `
-sourcetable CompareTable1 `
-DestinationServer dgpap2 `
-DestinationDatabase D1 `
-destinationtable  CompareTable1 -c -f H:\Z\Script1



# Date:     25/02/2013
# Author:   Ana Mihalj
# Description:  PS script to execute tablediff to compere and find all differences in data between 2 databases.
# Version:  1.0
# Example Execution: (with default parameters) .\TableDiffWithParam.ps1
# or with non-default parameters
# .\TableDiffWithParam.ps1 -SourceServer SERVER\INSTANCE -SourceDatabase SourceDB -DestinationServer SERVER\INSTANCE -DestinationDatabase DestinationDB -OutputFolder D:\Folder
 
param( [string]$SourceServer = "SERVER\INSTANCE",
[string]$SourceDatabase = "SourceDB",
[string]$DestinationServer = "SERVER\INSTANCE",
[string]$DestinationDatabase = "DestinationDB",
[string]$OutputFolder = "D:\Folder"
)

$SourceServer        = "dgpap1"
$SourceDatabase      = "S1"
$DestinationServer   = "dgpap2"
$DestinationDatabase = "D1"
$OutputFolder        = "H:\Z"

#set path to tablediff utility
$tablediff = "C:\Program Files\Microsoft SQL Server\110\COM\tablediff.exe"
 
#get tables for compare
if ($SourceServer.Contains("\") -eq "True")
{ $Tables = Get-ChildItem SQLSERVER:\SQL\$SourceServer\Databases\$SourceDatabase\Tables\ | SELECT name }
else
{ $Tables = Get-ChildItem SQLSERVER:\SQL\$SourceServer\Default\Databases\$SourceDatabase\Tables\ | SELECT name }

#$Tables='CompareTable','CompareTable1'
 
#create output folder if it does not exist
if ((Test-Path $OutputFolder) -eq $false)
{
md $OutputFolder
}
 
#Output file
$OutputFile = $OutputFolder+"\Output.txt"
 
#for each table
foreach($table in $Tables)
{ #p133
#create new file name for the Transact-SQL script file
$DiffScript = $OutputFolder+"\"+$table+".sql"

#If file exists throw the errror.
#if ((Test-Path $DiffScript) -eq $true)
#{
#throw "The file " + $DiffScript + " already exists."
#}
 
#execute tablediff
#& $tablediff -sourceserver $SourceServer -sourcedatabase $SourceDatabase -sourcetable $table.Name -destinationserver $DestinationServer -destinationdatabase $DestinationDatabase -destinationtable $table.Name -strict -c -o $OutputFile -f $DiffScript

& $tablediff -sourceserver $SourceServer -SourceDatabase $SourceDatabase -sourcetable $table -destinationserver $DestinationServer -destinationdatabase $DestinationDatabase -destinationtable $table -strict -c -o $OutputFile -f $DiffScript

 
# check the return value and throw an exception if needed
# tablediff return values: 0 - Success, 1 - Critical error, 2 - Table differences
#if ($LastExitCode -eq 1)
#{
#throw "Error on table " + $table.Name + " with exit code $LastExitCode"
#}

}  #p133


{<#


select *    FROM DGPAP1.[S3].[dbo].[t5]
select *    FROM DGPAP1.[S3].[dbo].[t6]

#-------
Declare @rid as int =9 , @val  int , @rstring  nvarchar(255);
while @rid <=14
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  --select @rstring=NEWID(); print @rstring
  set @rstring='39 insert'
  insert into DGPAP1.[S3].[dbo].[t5] values (@rid,@val,@rstring,getdate(),getdate())  set @rid=@rid+1end
select set mrid=max(rid) from DGPAP1.[S3].[dbo].[t5]




  select * from  [win-ming].[S3].[dbo].[T5]


---
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=10
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
end
select * from dbo.t6 

CREATE TABLE ExampleTable (PriKey int PRIMARY KEY, timestamp);
select * from ExampleTable

CREATE TABLE ExampleTable2 (PriKey int PRIMARY KEY, VerCol rowversion,xnow datetime) ;
drop table ExampleTable2

select * from ExampleTable
select *,convert(datetime,VerCol,121) as TS  from ExampleTable2

INSERT INTO ExampleTable2 (PriKey,xnow) VALUES (1,getdate());
INSERT INTO ExampleTable2 (PriKey,xnow) VALUES (2,getdate());


INSERT INTO ExampleTable2 (PriKey,xnow) VALUES (3,getdate());

select *,convert(datetime,VerCol,121) as TS  from ExampleTable2

CREATE TABLE MyTestTable(
RowID INT IDENTITY(1,1) NOT NULL
,[TimeStamp] TIMESTAMP
,[SmallDateTime] SMALLDATETIME
,[DateTime]  DATETIME)

CREATE TABLE MyTestTable1(
RowID INT IDENTITY(1,1) NOT NULL
,TIMESTAMP
,[SmallDateTime] SMALLDATETIME
,[DateTime]  DATETIME)

truncate table MyTestTable
truncate table MyTestTable1

select * from sql_inventory.dbo.MyTestTable

INSERT INTO MyTestTable([SmallDateTime],[DateTime])VALUES(GETDATE(), GETDATE())
select * from sql_inventory.dbo.MyTestTable

INSERT INTO MyTestTable1([SmallDateTime],[DateTime])VALUES(GETDATE(), GETDATE())
select * from sql_inventory.dbo.MyTestTable1

select *,convert(datetime,TimeStamp,108) as TS, TimeStamp  + [DateTime] from sql_inventory.dbo.MyTestTable
select *,convert(datetime,TimeStamp,121) as TS from sql_inventory.dbo.MyTestTable1

UPDATE MyTestTable SET SmallDateTime=0 WHERE RowID = 1

select CONVERT(DATE, timestamp, 112), count(*)
from MyTestTable-- where <tms column > '2012-09-10'


SELECT CONVERT (datetime, SYSDATETIME())
    ,CONVERT (datetime, SYSDATETIMEOFFSET())
    ,CONVERT (datetime, SYSUTCDATETIME())
    ,CONVERT (datetime, CURRENT_TIMESTAMP)
    ,CONVERT (datetime, GETDATE())
    ,CONVERT (datetime, GETUTCDATE());

SELECT CONVERT (time, SYSDATETIME())
    ,CONVERT (time, SYSDATETIMEOFFSET())
    ,CONVERT (time, SYSUTCDATETIME())
    ,CONVERT (time, CURRENT_TIMESTAMP)
    ,CONVERT (time, GETDATE())
    ,CONVERT (time, GETUTCDATE());

select CONVERT(VARCHAR(10), timestamp, 112), count(*)
from MyTestTable  
group by CONVERT(VARCHAR(10), timestamp , 112); 
#>}