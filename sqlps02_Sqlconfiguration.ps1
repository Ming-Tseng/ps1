<#sqlps02_Sqlconfiguration
C:\Users\administrator.CSD\SkyDrive\download\ps1\sqlps02_Sqlconfiguration.ps1
\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\sqlps02_Sqlconfiguration.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 history : APR.27.2014 +
 object : tsql


 $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\sqlps02_Sqlconfiguration.ps1

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

#  (1)Listing installed hotfixes and service packs using SMO
#  (2) Creating a filegroup
#  (3) 130  Adding secondary data files to a filegroup  p.l156 
#  (4) 200  Moving an index to a different filegroup  if OBJECT_ID
#  (5) 300  Checking /Reorganizing/rebuilding  index fragmentation  p162
#  (6) 355   Listing /Creating/scheduling SQL Server jobs / list only the failed jobs  p.178
#  (7)     Adding a SQL Server operator  jp.181
#  (8)
#  (9)
#  (10)
#  11  查詢 SQL Server 的產品版本
#  12  修改SQL伺服器名稱2
# 13      Adding a file to a database
# 14 700  Adding a filegroup with two files to a database
# 15      Adding two log files to a database
# 16  Removing a file from a database
# 17  Moving tempdb to a new location
# 18  Making a filegroup the default
# 19  Adding a Filegroup Using ALTER DATABASE
# 20  回傳 7 今天修改的
# 21  400 Creating a SQL Server instance object  p29
# 22  SQL Job view ,clear , start , stop  disable or enable JOB  by TSQL
# 23  modify a job
# 24  1015   FileGroup  for TSQL
# 25   1110  建立分割區資料表及索引  Partitioned Tables and Indexes
# 1215 Get Database Table column Data Type  
# 1353    max degree of parallelism  MAXDOP
# 1447    in-memory 
# 1466    Set or Change the Database Collation
#   1499  tempdb 移到新位置
#  98 temp













#---------------------------------------------------------------
#  (1)Listing installed hotfixes and service packs using SMO
#---------------------------------------------------------------
#replace this with your instance name
$instanceName = "SQL2012x"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

#to get the version
#major.minor.build.buildminor
#this should tell you collectively at what
#level your install is
$server.Information.VersionString
#from MSDN
#version of SQL Server
#RTM = Original release version
#SPn = Service pack version
#CTP, = Community Technology Preview version
$server.Information.ProductLevel

#to get hotfixes/updates/patches, we can use
#the Get-Hotfix cmdlet
#Get-Hotfix wraps the WMI class Win32_QuickFixEngineering
#but this may miss some updates or properties,
#depending on your OS
#this also does not include updates that are supplied by
#Microsoft Windows Installer (MSI)

#get all hotfixes
#note the Get-Hotfix cmdlet does not list updates
#applied by MSI (Microsoft Installer)
Get-Hotfix
#check if a specific hotfix is installed
Get-Hotfix -Id "KB2620704"

'
Terminology Description Cycle
RTM                   : Release to Manufacturing             Version of the product that isreleased to the market                N/A
Hotfix                :
Cumulative Update (CU):A package that contains a bundle of hotfixes that have passed an acceptance criteria
Service pack          : According to Microsofts official terminology guide, it is defined as follows
'

#---------------------------------------------------------------
#  (2)  Creating a filegroup  using SMO p.153
#---------------------------------------------------------------
ALTER DATABASE [TestDB]
ADD FILEGROUP [FGActive]
GO

#1. Open the PowerShell console by going to Start | Accessories | Windows PowerShell | Windows PowerShell ISE.
#2. Import the SQLPS module and create a new SMO Server object, as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
#3. Add the following script and run:
$databasename = "TestDB"
$database = $server.Databases[$databasename]
$fgname = "FGActive"
#For purposes of this test, we are going to drop this
#filegroup if it exists, so we can recreate it without
#any issues
if ($database.FileGroups[$fgname])
{
$database.FileGroups[$fgname].Drop()
}
#create the filegroup
$fg = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Filegroup -ArgumentList $database, $fgname
$fg.Create()
#4. Log in to Management Studio and confirm that the filegroup has been added:
a. Right-click on TestDB database and go to Properties.
b. On the left-hand pane, click on Filegroups. Check if the FGActive filegroup
is there.

#---------------------------------------------------------------
#  (3) 130 Adding secondary data files to a filegroup  p.l156 
#---------------------------------------------------------------
##TSQL
ALTER DATABASE [TestDB]
ADD FILEGROUP [FGActive]
GO
#In this recipe, we will accomplish this T-SQL equivalent:
ALTER DATABASE [TestDB]
ADD FILE ( NAME = N'datafile1',FILENAME = N'C:\Temp\datafile1.ndf')
TO FILEGROUP [FGActive]
GO

##
#1.PowerShell | Windows PowerShell ISE.
#2. Import the SQLPS module and create a new SMO Server object, as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#3. Add the following script and run:
$databasename = "TestDB"
$fgname = "FGActive"
$fg = $database.FileGroups[$fgname]
#Define a DataFile object on the file group and set the logical
#file name.
$df = New-Object -TypeName Microsoft.SqlServer.Management.SMO.
DataFile -ArgumentList $fg, "datafile1"
#Make sure to have a directory created to hold the designated data
#file
$df.FileName = "H:\\Temp\\datafile1.ndf"
#Call the Create method to create the data file on the instance of
#SQL Server.
$df.Create()
#---------------------------------------------------------------
#  (4) 200  Moving an index to a different filegroup  if OBJECT_ID
#---------------------------------------------------------------
## ----------------------- ready  using TSQL

USE AdventureWorks2012;
GO
--# Creates the TransactionsFG1 filegroup on the AdventureWorks2012 database
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP TransactionsFG1;
GO
/* Adds the TransactionsFG1dat3 file to the TransactionsFG1 filegroup. Please note that you will have to change the filename parameter in this statement to execute it without errors.
*/
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = TransactionsFG1dat3,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13\MSSQL\DATA\TransactionsFG1dat3.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP TransactionsFG1;

GO
/*Creates the IX_Employee_OrganizationLevel_OrganizationNode index
  on the TransactionsPS1 filegroup and drops the original IX_Employee_OrganizationLevel_OrganizationNode index.
*/
CREATE NONCLUSTERED INDEX IX_Employee_OrganizationLevel_OrganizationNode
    ON HumanResources.Employee (OrganizationLevel, OrganizationNode)
    WITH (DROP_EXISTING = ON)
    ON TransactionsFG1;
GO










## -----------------------  ready  using SMO
'Using the TestDB database, or any database of your choice, let's create a table called Student
with a clustered primary key.
Open SQL Server Management Studio, and execute the following code:

if OBJECT_ID('tbProduct04','table') is not null
   drop table tbProduct04 ;
GO

'
USE TestDB
GO
## this is going to be stored to the default filegroup
IF OBJECT_ID(Student') IS NOT NULL
DROP TABLE Student
GO

CREATE TABLE Student
(
ID INT IDENTITY(1,1) NOT NULL,
FName VARCHAR(50),
CONSTRAINT [PK_Student] FG2 KEY CLUSTERED([ID] ASC)
on [FG2]
)
GO






#insert some sample data
# nothing fancy, every student will be called Joe for now :)
INSERT INTO Student(FName)
VALUES('Joe')
GO 20
INSERT INTO Student(FName)
SELECT FName FROM Student
GO 10
# check how many records are inserted
# this should give 20480
SELECT COUNT(*) FROM Student

#The T-SQL equivalent of what we are trying to accomplish in this recipe is as follows:
CREATE UNIQUE CLUSTERED INDEX PK_Student
ON dbo.Student
(
ID ASC
)
WITH (DROP_EXISTING=ON, ONLINE=ON)
ON FGStudent
GO

##-- using
#1. Open the PowerShell console by going to Start | Accessories | Windows PowerShell | Windows PowerShell ISE.

#2. Import the SQLPS module and create a new SMO Server object, as follows: import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

#3. Add the following script and run:
$databasename = "TestDB"
$database = $server.Databases[$databasename]
$tablename = "Student"
$table = $database.Tables[$tablename]
#now move to a different filegroup
$fgname = "FGStudent"
if ($database.FileGroups[$fgname])
{
$database.FileGroups[$fgname].Drop()
}
$fg = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Filegroup -ArgumentList $database, $fgname
$fg.Create()
$fg = $database.FileGroups[$fgname]

#create a datafile and specify the filename
$df = New-Object -TypeName Microsoft.SqlServer.Management.SMO.
DataFile -ArgumentList $fg, "studentdata"
$df.FileName = "c:\\Temp\\studentdata.ndf"

#create the datafile
$df.Create()
#now let's recreate the clustered index
#(Microsoft.SqlServer.Management.Smo.Index)
#onto the new filegroup
#note this is V3 syntax because of simplified Where-Object
$clusteredindex = $table.Indexes |
Where-Object IsClustered -eq $true
$clusteredindex.FileGroup = $fgname
$clusteredindex.Recreate()

#display which filegroup the table is on now
$table.Refresh()
$table.FileGroup


##--There's more...
'To move nonclustered indexes to a different filegroup, you will follow the same method
described in the previous recipe. Heres an example:
'
$idxname = $table.Indexes["idxname"]
$idxname.FileGroup = $fgname
$idxname.Recreate()
$idxname.Refresh()
$idxname.FileGroup
'If you are dealing with a clustered index that is not a primary key, you can also consider the
DropAndMove method of the Microsoft.SqlServer.Management.Smo.Index object.
This method drops the clustered index and recreates it in the specified filegroup.
'
$idxname.DropAndMove($fgname)








#---------------------------------------------------------------
#  (5)  300  Checking /Reorganizing/rebuilding  index fragmentation  p162
#---------------------------------------------------------------

##--  Checking

#We will investigate the index fragmentation of the Person.Person table in the AdventureWorks2008R2 database.
#1. Open the PowerShell console by going to Start | Accessories | Windows PowerShell | Windows PowerShell ISE.

#2. Import the SQLPS module and create a new SMO Server object, as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking;
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

#3. Add the following script and run:
$databasename = "AdventureWorks2008R2"
$database = $server.Databases[$databasename]
$tableName = "Person"
$schemaName = "Person"
$table = $database.Tables |
Where Schema -Like $schemaName |
Where Name -Like $tableName
#From MSDN:
#EnumFragmentation enumerates a list of
#fragmentation information for the index
#using the default fast fragmentation option.
$table.Indexes |
Foreach {
$_.EnumFragmentation() |
Select Index_Name, @{Name="Value";Expression={($_.
AverageFragmentation).ToString("0.0000")}}
} |
Format-Table -AutoSize



##-- Reorganizing/rebuilding
3. Add the following script and run:
$VerbosePreference = "Continue"
$databasename = "AdventureWorks2008R2"
$database = $server.Databases[$databasename]
$tableName = "Person"
$schemaName = "Person"
$table = $database.Tables |
Where Schema -Like $schemaName |
Where Name -Like $tableName
#From MSDN:
#EnumFragmentation enumerates a list of
#fragmentation information
#for the index using the default fast fragmentation option.
$table.Indexes |
ForEach-Object {
$_.EnumFragmentation() |
ForEach-Object {
$item = $_
#reorganize if 10 and 30% fragmentation
if($item.AverageFragmentation -ge 10 -and `
$item.AverageFragmentation -le 30 -and `
$item.Pages -ge 1000)
{
Write-Verbose "Reorganizing $index.Name ... "
$index.Reorganize()
}
#rebuild if more than 30%
elseif ($item.AverageFragmentation -gt 30 -and `
$item.Pages -ge 1000)
{
Write-Verbose "Rebuilding $index.Name ... "
$index.Rebuild()
}
}
}
$VerbosePreference = "SilentlyContinue"


#---------------------------------------------------------------
#  (6) 355 Listing /Creating/ schedule SQL Server jobs / list only the failed jobs  p.178 
#---------------------------------------------------------------

##-- Get 
(1)Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
(2). Import the SQLPS module and create a new SMO Server object, as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "DGPAP2"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
(3). Add the following script and run:
$jobs=$server.JobServer.Jobs
$jobs |
Select Name, OwnerLoginName, LastRunDate, LastRunOutcome |
Sort -Property Name |
Format-Table -AutoSize

##list only the failed jobs

$jobs=$server.JobServer.Jobs
$jobs |
Where LastRunOutcome -Like "Failed" |
Select Name, OwnerLoginName, LastRunDate, LastRunOutcome |
Format-Table -AutoSize

##--create jobs  p183

(3). Add the following script and run:
$jobName = "Test Job"
if($server.JobServer.Jobs[$jobName])
{
$server.JobServer.Jobs[$jobName].Drop()
}
$job = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Agent.Job -ArgumentList $server.JobServer, $jobName
#Specify which operator to inform and the completion action.
$operatorName = "jraynor"
$operator = $server.JobServer.Operators[$operatorName]
$job.OperatorToEmail = $operator.Name
#CompletionAction can be Never, OnSuccess, OnFailure, Always
$job.EmailLevel = [Microsoft.SqlServer.Management.SMO.Agent.CompletionAction]::OnFailure

#create
$job.Create()
#apply to local instance of SQL Server
$job.ApplyToTargetServer($instanceName)
#now let's add a simple T-SQL Job Step
$jobStep = New-Object Microsoft.SqlServer.Management.Smo.Agent.JobStep($job, "Test Job Step")
$jobStep.Subsystem = [Microsoft.SqlServer.Management.Smo.Agent.AgentSubSystem]::TransactSql
$jobStep.Command = "SELECT GETDATE()"
$jobStep.OnSuccessAction = [Microsoft.SqlServer.Management.Smo.Agent.StepCompletionAction]::QuitWithSuccess
$jobStep.OnFailAction = [Microsoft.SqlServer.Management.Smo.Agent.StepCompletionAction]::QuitWithFailure
$jobStep.Create()
(4). Use SQL Server Management Studio to check if this job has been created:

##--Scheduling jobs  p192


(3)Add the following script and run:
$jobserver = $server.JobServer
$jobname = "Test Job"
$job = $jobserver.Jobs[$jobname]
$jobschedule = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Agent.JobSchedule -ArgumentList $job, "Every Weekend Night 10PM"
#Values for FrequencyTypes are:
#AutoStart, Daily, Monthly, MonthlyRelative, OneTime,
#OnIdle, Unknown, Weekly
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::Weekly
<#
#from MSDN:
#These are the list of FrequencyInterval values
WeekDays.Sunday = 1
WeekDays.Monday = 2
WeekDays.Tuesday = 4
WeekDays.Wednesday = 8
WeekDays.Thursday = 16
WeekDays.Friday = 32
WeekDays.Saturday = 64
WeekDays.WeekDays = 62
WeekDays.WeekEnds = 65
WeekDays.EveryDay = 127
Combine values using an OR logical operator to set more than a
single day.
For example, combine WeekDays.Monday andWeekDays.Friday
(FrequencyInterval = 2 + 32 = 34) to schedule an activity for
Monday and Friday.
#>

#every Saturday and Sunday
#can also use 65
$jobschedule.FrequencyInterval = [Microsoft.SqlServer.Management.SMO.Agent.WeekDays]::WeekEnds
#set time
#3 parameters - hours, mins, days
#if we don't specify time, it will start at midnight
$starttime = New-Object -TypeName TimeSpan -ArgumentList 22, 0, 0
$jobschedule.ActiveStartTimeOfDay = $starttime
#frequency of recurrence
$jobschedule.FrequencyRecurrenceFactor = 1
$jobschedule.ActiveStartDate = "01/01/2012"
#Create the job schedule on the instance of SQL Agent.
$jobschedule.Create()

(4). Check the schedule from SQL Server Management Studio:
1. Go to Management Studio.
2. Under SQL Server Agent, double-click on Test Job.
3. Click on Schedules on the left-hand side pane. Confirm that the schedule has been created.



## The more
'$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::Weekly
The settings
that need to be set are:
1 FrequencyTypes
2 FrequencyInterval
3 ActiveStartTimeOfDay
4 FrequencyRecurrenceFactor
5 ActiveStartDate
'

#Note that valid FrequencyInterval values are as follows:
195
'Different values available for FrequencyTypes are: AutoStart, Daily, Monthly,
MonthlyRelative, OneTime, OnIdle, Unknown, and Weekly.
'
For FrequencyInterval, we need to set the value to every weekend:

#every Saturday and Sunday
#can also use 65
$jobschedule.FrequencyInterval = [Microsoft.SqlServer.Management.SMO.Agent.WeekDays]::WeekEnds

Note that valid FrequencyInterval values are as follows:
FrequencyInterval Value Notes
WeekDays.Sunday 1 20
WeekDays.Monday 2 21
WeekDays.Tuesday 4 22
WeekDays.Wednesday 8 23
WeekDays.Thursday 16 24
WeekDays.Friday 32 25
WeekDays.Saturday 64 26
WeekDays.WeekDays 62 Monday + Tuesday + ... + Friday
WeekDays.WeekEnds 65 Saturday + Sunday
WeekDays.EveryDay 127 Sunday + Monday + ... + Saturday


##-- for example

   #   (Every weekend at 10 P.M.)
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::Weekly
#every Saturday and Sunday
$jobschedule.FrequencyInterval = [Microsoft.SqlServer.Management.SMO.Agent.WeekDays]::WeekEnds
#10PM
$starttime = New-Object -TypeName TimeSpan -ArgumentList 22, 0, 0
$jobschedule.ActiveStartTimeOfDay = $starttime
$jobschedule.FrequencyRecurrenceFactor = 1


   #   (Every half hour between 8 A.M. and 4 P.M. on each weekday)
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::Weekly
<#
WeekDays.Sunday = 1
WeekDays.Monday = 2
WeekDays.Tuesday = 4
WeekDays.Wednesday = 8
WeekDays.Thursday = 16
WeekDays.Friday = 32
WeekDays.Saturday = 64
WeekDays.WeekDays = 62
WeekDays.WeekEnds = 65
WeekDays.EveryDay = 127
#>
#every weekday
$jobschedule.FrequencyInterval = 62
#every half hour
$jobschedule.FrequencySubDayTypes =[Microsoft.SqlServer.Management.SMO.Agent.FrequencySubDayTypes]::Minute
$jobschedule.FrequencySubDayInterval = 30
$jobschedule.ActiveStartDate = "01/01/2012"
#from 8-4
$starttime = New-Object -TypeName TimeSpan -ArgumentList 8, 0, 0
$jobschedule.ActiveStartTimeOfDay = $starttime
$endtime = New-Object -TypeName TimeSpan -ArgumentList 16, 0, 0
$jobschedule.ActiveEndTimeOfDay = $endtime


   #      (At 11:30 P.M. on the last day of every month)
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::MonthlyRelative
$jobschedule.FrequencyRelativeIntervals =[Microsoft.SqlServer.Management.SMO.Agent.FrequencyRelativeIntervals]::Last
#month end can fall any day, so we'll have
#to set interval to everyday
$jobschedule.FrequencyInterval = [Microsoft.SqlServer.Management.SMO.Agent.MonthlyRelativeWeekDays]::EveryDay
$jobschedule.FrequencyRecurrenceFactor = 1
$jobschedule.ActiveStartDate = "01/01/2012"
#start at 11:30 PM
#3 params - hours, mins, days
$starttime = New-Object -TypeName TimeSpan -ArgumentList 23, 30, 0
$jobschedule.ActiveStartTimeOfDay = $starttime

  #      (At noon on every Tuesday and Thursday)
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::Weekly
<#
WeekDays.Sunday = 1
WeekDays.Monday = 2
WeekDays.Tuesday = 4
WeekDays.Wednesday = 8
WeekDays.Thursday = 16
WeekDays.Friday = 32
WeekDays.Saturday = 64
WeekDays.WeekDays = 62
WeekDays.WeekEnds = 65
WeekDays.EveryDay = 127
#>
#every Tuesday and Thursday
#Tuesday = 4, Thursday = 16 so 20
$jobschedule.FrequencyInterval = 20
$jobschedule.FrequencyRecurrenceFactor = 1
$jobschedule.ActiveStartDate = "01/01/2012"
#noon
#3 params - hours, mins, days
$starttime = New-Object -TypeName TimeSpan -ArgumentList 12, 00, 0
$jobschedule.ActiveStartTimeOfDay = $ starttime


   #      (At 6 A.M. on every 3rd Friday of the month)
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::MonthlyRelative
$jobschedule.FrequencyRelativeIntervals =[Microsoft.SqlServer.Management.SMO.Agent.FrequencyRelativeIntervals]::Third
$jobschedule.FrequencyInterval = [Microsoft.SqlServer.Management.SMO.Agent.MonthlyRelativeWeekDays]::Friday
$jobschedule.FrequencyRecurrenceFactor = 1
$jobschedule.ActiveStartDate = "01/01/2012"
#start at 10:30 PM
$starttime = New-Object -TypeName TimeSpan -ArgumentList 6, 00, 0
$jobschedule.ActiveStartTimeOfDay = $starttime


    #      (At 11 P.M. on every last Thursday of the month)
$jobschedule.FrequencyTypes = [Microsoft.SqlServer.Management.SMO.Agent.FrequencyTypes]::MonthlyRelative
$jobschedule.FrequencyRelativeIntervals =[Microsoft.SqlServer.Management.SMO.Agent.FrequencyRelativeIntervals]::Last
$jobschedule.FrequencyInterval = [Microsoft.SqlServer.Management.SMO.Agent.MonthlyRelativeWeekDays]::Thursday
$jobschedule.FrequencyRecurrenceFactor = 1
$jobschedule.ActiveStartDate = "01/01/2012"
#11PM
$starttime = New-Object -TypeName TimeSpan -ArgumentList 23, 00, 0
$jobschedule.ActiveStartTimeOfDay = $starttime  

'Check out FrequencyTypes from the following URL:'
http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.agent.frequencytypes.aspx
'Frequency interval documentation can be found here:'
http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.agent.jobschedule.frequencyinterval(v=sql.110).aspx

#---------------------------------------------------------------
#  (7) 400  Adding a SQL Server operator  jp.181
#---------------------------------------------------------------
##
Operator name:
Operator e-mail :

(1). Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
(2). Import the SQLPS module and create a new SMO Server object, as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
(3). Add the following script and run:
$jobserver = $server.JobServer
$operatorName = "jraynor"
$operatorEmail = "jraynor@queryworks.local"
$operator = New-Object Microsoft.SqlServer.Management.Smo.Agent.Operator -ArgumentList $jobserver, $operatorName
$operator.EmailAddress = $operatorEmail
$operator.Create()
#verify by listing operators
$jobserver.Operators
(4). Open SQL Server Management Studio and check if the operator has been created.
Expand SQL Server Agent | Operators.

#---------------------------------------------------------------
#  (8)
#---------------------------------------------------------------




#---------------------------------------------------------------
#  (9)
#---------------------------------------------------------------


#---------------------------------------------------------------
# (10)
#---------------------------------------------------------------



#---------------------------------------------------------------
#  11  查詢 SQL Server 的產品版本
#---------------------------------------------------------------
SELECT RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'


#---------------------------------------------------------------
#  12  修改SQL伺服器名稱2
#---------------------------------------------------------------



DECLARE @sn sysname,@sno sysname;
SELECT @sn=cast(serverproperty('servername') as sysname),@sno=@@SERVERNAME;
IF @sno IS NULL
	BEGIN
		EXEC sp_addserver @server=@sn,@local = 'local';
		SELECT N'Finish the server name to revise, and has already stopped serving, please restart the server';
		SELECT N'完成伺服器名稱修改，並已停止服務，請重新啟動伺服器';
		SHUTDOWN WITH NOWAIT;
		RETURN;
	END
ELSE IF (@sn=@sno)
	BEGIN
		SELECT N'Do not need to revise the server name';
		SELECT N'無須修正伺服器名稱';
		RETURN;
	END
ELSE
	BEGIN
		EXEC sp_dropserver @sno;
		EXEC sp_addserver @server=@sn,@local = 'local';
		SELECT N'Finish the server name to revise, and has already stopped serving, please restart the server';
		SELECT N'完成伺服器名稱修改，並已停止服務，請重新啟動伺服器';
		SHUTDOWN WITH NOWAIT;
	END

#---------------------------------------------------------------
# 13  Adding a file to a database
#---------------------------------------------------------------

USE master;
GO
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = Test1dat2,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\t1dat2.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
);
GO

#---------------------------------------------------------------
# 14    700 Adding a filegroup with two files to a database
#---------------------------------------------------------------
USE master
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP Test1FG1;
GO
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = test1dat3,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\t1dat3.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),
(
    NAME = test1dat4,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\t1dat4.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP Test1FG1;
GO



CREATE DATABASE [mingDB]
ON PRIMARY
( NAME = N'StudentDB', FILENAME = N'C:\Temp\StudentDB.mdf'),
FILEGROUP [FG1]
( NAME = N'StudentData1', FILENAME = N'C:\Temp\StudentData1.ndf'),
( NAME = N'StudentData2', FILENAME = N'C:\Temp\StudentData2.ndf'),
FILEGROUP [FG2]
( NAME = N'StudentData3', FILENAME = N'C:\Temp\StudentData3.ndf')
LOG ON
( NAME = N'StudentDB_log', FILENAME = N'C:\Temp\StudentDB.ldf')
GO




#---------------------------------------------------------------
# 15  Adding two log files to a database
#---------------------------------------------------------------
USE master;
GO
ALTER DATABASE AdventureWorks2012 
ADD LOG FILE 
(
    NAME = test1log2,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\test2log.ldf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),
(
    NAME = test1log3,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\test3log.ldf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
);
GO

#---------------------------------------------------------------
# 16  Removing a file from a database
#---------------------------------------------------------------
USE master;
GO
ALTER DATABASE AdventureWorks2012 
MODIFY FILE
    (NAME = test1dat3,
    SIZE = 20MB);
GO





#---------------------------------------------------------------
# 17  Moving tempdb to a new location
#---------------------------------------------------------------
1. Determine the logical file names of the tempdb database and their current location on disk. 
SELECT name, physical_name
FROM sys.master_files
WHERE database_id = DB_ID('tempdb');
GO

2. Change the location of each file by using ALTER DATABASE.
USE master;
GO
ALTER DATABASE tempdb 
MODIFY FILE (NAME = tempdev, FILENAME = 'E:\SQLData\tempdb.mdf');
GO
ALTER DATABASE  tempdb 
MODIFY FILE (NAME = templog, FILENAME = 'E:\SQLData\templog.ldf');
GO
3. Stop and restart the instance of SQL Server. 
4. Verify the file change.
SELECT name, physical_name
FROM sys.master_files
WHERE database_id = DB_ID('tempdb');
5. Delete the tempdb.mdf and templog.ldf files from their original location





#---------------------------------------------------------------
#  18  Making a filegroup the default
#---------------------------------------------------------------

The following example makes the Test1FG1 filegroup created in example B the default filegroup. Then, the default filegroup is reset to the PRIMARY filegroup. Note that PRIMARY must be delimited by brackets or quotation marks.
Transact-SQL
Copy 
USE master;
GO
ALTER DATABASE AdventureWorks2012 
MODIFY FILEGROUP Test1FG1 DEFAULT;
GO
ALTER DATABASE AdventureWorks2012 
MODIFY FILEGROUP [PRIMARY] DEFAULT;
GO



#---------------------------------------------------------------
#  19 Adding a Filegroup Using ALTER DATABASE
#---------------------------------------------------------------
The following example adds a FILEGROUP that contains the FILESTREAM clause to the FileStreamPhotoDB database.
Copy 
--Create and add a FILEGROUP that CONTAINS the FILESTREAM clause to
--the FileStreamPhotoDB database.
ALTER DATABASE FileStreamPhotoDB
ADD FILEGROUP TodaysPhotoShoot
CONTAINS FILESTREAM
GO
--Add a file for storing database photos to FILEGROUP 
ALTER DATABASE FileStreamPhotoDB
ADD FILE
(
    NAME= 'PhotoShoot1',
    FILENAME = 'C:\Users\Administrator\Pictures\TodaysPhotoShoot.ndf'
)
TO FILEGROUP TodaysPhotoShoot
GO
#---------------------------------------------------------------
#  20  回傳 7 今天修改的
#---------------------------------------------------------------

/* 回傳 7 今天修改的*/
use WebHr_Standard
select * from sys.objects 
where  modify_date > GETDATE() -7
order by  modify_date




#---------------------------------------------------------------
# 21 400  Creating a SQL Server instance object  p29
#---------------------------------------------------------------

#create a variable for your instance name
$instanceName = "KERRIGAN"

#create your server instance
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

#set connection to mixed mode
$server.ConnectionContext.set_LoginSecure($false)
#set the login name
#of course we don't want to hardcode credentials here
#so we will prompt the user
#note password is passed as a SecureString type
$credentials = Get-Credential
#remove leading backslash in username
$login = $credentials.UserName -replace("\\", "")
$server.ConnectionContext.set_Login($login)
$server.ConnectionContext.set_SecurePassword($credentials.Password)

#check connection string
$server.ConnectionContext.ConnectionString
Write-Verbose "Connected to $($server.Name)"
Write-Verbose "Logged in as $($server.ConnectionContext.TrueLogin)"

#create your server instance
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName


#set connection to mixed mode
$server.ConnectionContext.set_LoginSecure($false)

#prompt
$credentials = Get-Credential


#remove leading backslash in username
$login = $credentials.UserName -replace("\\","")

$server.ConnectionContext.set_Login($login)
$server.ConnectionContext.set_SecurePassword($credentials.Password)

$login="administrator"
#prompt
$credentials = Get-Credential –Credential $login

$VerbosePreference = "Continue"


$VerbosePreference = "SilentlyContinue"



#---------------------------------------------------------------
# 22  SQL Job view ,clear , start , stop  disable or enable JOB  by TSQL
#---------------------------------------------------------------
http://msdn.microsoft.com/en-us/library/ms181367.aspx
 
 select * from dbo.sysjobs
 select * from msdb.dbo.sysjobsteps
 select * from dbo.sysjobactivity ## Contains information about current SQL Server Agent job activity and status.
 select * from dbo.sysschedules
 select * from dbo.sysjobservers

##
select j.name,c.name,c.category_id
from msdb.dbo.sysjobs j
join  msdb.dbo.syscategories c on j.category_id=c.category_id 
where j.name like 'SP2013%'
order by j.name

REPL-LogReader :13, REPL-Distribution: 10, REPL-Snapshot: 15

##  find out running job if you see
SELECT job.Name, job.job_ID ,job.Originating_Server ,activity.run_requested_Date
    ,datediff(minute, activity.run_requested_Date, getdate()) AS Elapsed
FROM  msdb.dbo.sysjobs_view job 
INNER JOIN msdb.dbo.sysjobactivity activity  ON (job.job_id = activity.job_id)
WHERE
    run_Requested_date is not null AND stop_execution_date is null
    AND job.name like 'SP2013%'


##
-- lists all aspects of the information for the job NightlyBackups.
USE msdb ;
GO

EXEC dbo.sp_help_job

##
-- lists all job information for the NightlyBackups job.
USE msdb ;
GO

EXEC dbo.sp_help_jobhistory  @job_name = N'NightlyBackups' ;
GO
##
-- example removes the history for a job named NightlyBackups.
USE msdb ;
GO

EXEC dbo.sp_purge_jobhistory
    @job_name = N'NightlyBackups' ;
GO
##
-- starts a job named Weekly Sales Data Backup.  
USE msdb ;
GO
EXEC msdb.dbo.sp_start_job N'Weekly Sales Data Backup' ;
GO
##
-- stops a job named Weekly Sales Data Backup
USE msdb ;
GO

EXEC dbo.sp_stop_job N'Weekly Sales Data Backup' ;
GO

-- changes the name, description, and enables status of the job NightlyBackups.
USE msdb ;
GO

EXEC dbo.sp_update_job
    @job_name = N'NightlyBackups',
    @new_name = N'NightlyBackups -- Disabled',
    @description = N'Nightly backups disabled during server migration.',
    @enabled = 1 ;
GO

#---------------------------------------------------------------
# 23   modify a job
#---------------------------------------------------------------


To modify a job
In Object Explorer, connect to an instance of the Database Engine, and then expand that instance.
On the toolbar, click New Query.
In the query window, use the following system stored procedures to modify a job.
Execute sp_update_job (Transact-SQL) to change the attributes of a job.
Execute sp_update_schedule (Transact-SQL) to change the scheduling details for a job definition.
Execute sp_add_jobstep (Transact-SQL) to add new job steps.
Execute sp_update_jobstep (Transact-SQL) to change pre-existing job steps.
Execute sp_delete_jobstep (Transact-SQL) to remove a job step from a job.
Additional stored procedures to modify any SQL Server Agent master job:
Execute sp_delete_jobserver (Transact-SQL) to delete a server currently associated with a job.
Execute sp_add_jobserver (Transact-SQL) to associate a server with the current job.


#---------------------------------------------------------------
# 24  1015   List All Objects Created on All Filegroups in Databas
#---------------------------------------------------------------

#{<#
## Get  all fileGroup

SELECT * FROM sys.filegroups
GO  

## ADD

USE master
GO
ALTER DATABASE [mingDB]
ADD FILEGROUP [FG1]
GO

ALTER DATABASE [mingDB]
ADD FILEGROUP [FG2]
GO

ALTER DATABASE [mingDB]
ADD FILE 
 (NAME = mingDBFG1F1,  FILENAME = 'H:\SQLDB\mingDBFG1F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = mingDBFG1F2,  FILENAME = 'H:\SQLDB\mingDBFG1F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG1;
GO

ALTER DATABASE [mingDB]
ADD FILE 
 (NAME = mingDBFG2F1,  FILENAME = 'H:\SQLDB\mingDBFG2F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = mingDBFG2F2,  FILENAME = 'H:\SQLDB\mingDBFG2F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = mingDBFG2F3,  FILENAME = 'H:\SQLDB\mingDBFG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG2;
GO


## remove
USE [MingDB]
GO
ALTER DATABASE [MingDB]  REMOVE FILE [mingDBFG1F1]
GO
ALTER DATABASE [MingDB]  REMOVE FILE [mingDBFG1F2]
GO
ALTER DATABASE [MingDB] REMOVE FILEGROUP [FG1]
GO



#-- Get filegroup , physical 
select y.name,  d.name, d.physical_name
from sys.filegroups y
left join [sys].[database_files] d on y.data_space_id=d.data_space_id

select * from [sys].[database_files] 
select * from sys.filegroups
select * from [sys].[data_spaces]

#--


##  List all Objects and Indexes per Filegroup / Partition
#system catalogues: sys.filegroups, sys.indexes, sys.database_files and sys.data_spaces.

SELECT OBJECT_NAME(i.[object_id]) AS [ObjectName]
	,i.[index_id] AS [IndexID]
	,i.[name] AS [IndexName]
	,i.[type_desc] AS [IndexType]
	,i.[data_space_id] AS [DatabaseSpaceID]
	,f.[name] AS [FileGroup]
	,d.[physical_name] AS [DatabaseFileName]
FROM [sys].[indexes] i
INNER JOIN [sys].[filegroups] f
	ON f.[data_space_id] = i.[data_space_id]
INNER JOIN [sys].[database_files] d
	ON f.[data_space_id] = d.[data_space_id]
INNER JOIN [sys].[data_spaces] s
	ON f.[data_space_id] = s.[data_space_id]
WHERE OBJECTPROPERTY(i.[object_id], 'IsUserTable') = 1
ORDER BY OBJECT_NAME(i.[object_id]),f.[name] ,i.[data_space_id]

##  add




#>}

#---------------------------------------------------------------
# 25   1110  建立分割區資料表及索引  Partitioned Tables and Indexes
#---------------------------------------------------------------
https://msdn.microsoft.com/zh-tw/library/ms188730.aspx
https://msdn.microsoft.com/zh-tw/library/ms190787.aspx
#To create a partitioned table
<#USE AdventureWorks2012;
GO
-- Adds four new filegroups to the AdventureWorks2012 database
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test1fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test2fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test3fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test4fg; 

-- Adds one file for each filegroup.
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = test1dat1,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\t1dat1.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test1fg;
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = test2dat2,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\t2dat2.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test2fg;
GO
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = test3dat3,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\t3dat3.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test3fg;
GO
ALTER DATABASE AdventureWorks2012 
ADD FILE 
(
    NAME = test4dat4,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\t4dat4.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test4fg;
GO
-- Creates a partition function called myRangePF1 that will partition a table into four partitions
CREATE PARTITION FUNCTION myRangePF1 (int)
    AS RANGE LEFT FOR VALUES (1, 100, 1000) ;
GO
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above
CREATE PARTITION SCHEME myRangePS1
    AS PARTITION myRangePF1
    TO (test1fg, test2fg, test3fg, test4fg) ;
GO
-- Creates a partitioned table called PartitionTable that uses myRangePS1 to partition col1
CREATE TABLE PartitionTable (col1 int PRIMARY KEY, col2 char(10))
    ON myRangePS1 (col1) ;
GO#>
#To determine if a table is partitioned
<#SELECT * 
FROM sys.tables AS t 
JOIN sys.indexes AS i 
    ON t.[object_id] = i.[object_id] 
    AND i.[type] IN (0,1) 
JOIN sys.partition_schemes ps 
    ON i.data_space_id = ps.data_space_id 
WHERE t.name = 'PartitionTable'; 
GO#>

#To determine the boundary values for a partitioned table
<#SELECT t.name AS TableName, i.name AS IndexName, p.partition_number, p.partition_id, i.data_space_id, f.function_id, f.type_desc, r.boundary_id, r.value AS BoundaryValue 
FROM sys.tables AS t
JOIN sys.indexes AS i
    ON t.object_id = i.object_id
JOIN sys.partitions AS p
    ON i.object_id = p.object_id AND i.index_id = p.index_id 
JOIN  sys.partition_schemes AS s 
    ON i.data_space_id = s.data_space_id
JOIN sys.partition_functions AS f 
    ON s.function_id = f.function_id
LEFT JOIN sys.partition_range_values AS r 
    ON f.function_id = r.function_id and r.boundary_id = p.partition_number
WHERE t.name = 'PartitionTable' AND i.type <= 1
ORDER BY p.partition_number;#>





#-- Query Table all  index


exec sp_helpindex tablename 查詢此table 下所有的 index
exec sp_spaceused tablename 查詢此table , index 所使用大小. 















#---------------------------------------------------------------
# 1215 Get Database Table column Data Type  Aug.10.2015
#---------------------------------------------------------------
<#
DROP TABLE [dbo].[MingColumnDataType]
GO

/****** Object:  Table [dbo].[MingColumnDataType]    Script Date: 2015/8/10 下午 02:27:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MingColumnDataType](
	[TableName] [nvarchar](50) NULL,
	[ColumnName] [nvarchar](50) NULL,
	[Datatype] [nvarchar](50) NULL,
	[MaxLength] [nvarchar](50) NULL,
	[precision] [nvarchar](50) NULL,
	[scale] [nvarchar](50) NULL,
	[is_nullable] [nvarchar](50) NULL,
	[PrimaryKey] [nvarchar](50) NULL
) ON [PRIMARY]

GO


select *  from 	MingColumnDataType  where tablename <> 'MingColumnDataType' order by columnname
select distinct tablename  from 	MingColumnDataType  

#>

Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query "truncate table [dbo].[MingColumnDataType]"

$tsql_Gettable="select name from sys.tables where is_ms_shipped=0 "
$DS=Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query $tsql_Gettable

foreach ($D in $DS)
{ #1247

$tableName=$D.name
$tsql_Getcolumn=@"
SELECT 
    c.name 'ColumnName',
    t.Name 'Datatype',
    c.max_length 'MaxLength',
    c.precision ,
    c.scale ,
    c.is_nullable,
    ISNULL(i.is_primary_key, 0) 'PrimaryKey'
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
WHERE
    c.object_id = OBJECT_ID('$tableName')
"@ 
#$tsql_Getcolumn

$GCS=Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query $tsql_Getcolumn

foreach ($GC in $GCS)
{ #1275

$GCColumnName =$GC.ColumnName
$GCDatatype   =$GC.Datatype
$GCMaxLength  =$GC.MaxLength
$GCprecision  =$GC.precision
$GCscale      =$GC.scale
$GCis_nullable=$GC.is_nullable
$GCPrimaryKey =$GC.PrimaryKey

$TSQL_insert=@"
INSERT INTO [dbo].[MingColumnDataType]
           ([TableName]
           ,[ColumnName]
           ,[Datatype]
           ,[MaxLength]
           ,[precision]
           ,[scale]
           ,[is_nullable]
           ,[PrimaryKey])
     VALUES
           ('$tableName'
           ,'$GCColumnName'
           ,'$GCDatatype'
           ,'$GCMaxLength'
           ,'$GCprecision'
           ,'$GCscale'
           ,'$GCis_nullable'
           ,'$GCPrimaryKey')
"@
#$TSQL_insert
Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query $TSQL_insert


} #1275
} #1247


$env:COMPUTERNAME

select * from sys.tables
select *  from 	MingColumnDataType  order by columnname
select *  from 	MingColumnDataType  order by tableName
#---------------------------------------------------------------
#  98 temp
#---------------------------------------------------------------

Import-Module “sqlps” -DisableNameChecking

$smo = 'Microsoft.SqlServer.Management.Smo.'
$wmi = new-object ($smo + 'Wmi.ManagedComputer').

# List the object properties, including the instance names.
$Wmi

# Enable the TCP protocol on the default instance.
$uri = "ManagedComputer[@Name='SQL2012X']/ ServerInstance[@Name='SQLX2']/ServerProtocol[@Name='Tcp']"
#$uri = "ManagedComputer[@Name='<computer_name>']/ ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"
$Tcp = $wmi.GetSmoObject($uri)
$tcp |gm
$TCP.state
$Tcp.IsEnabled = $True  #Enable
$Tcp.IsEnabled = $false  #Disable
$Tcp.Alter()  # confirm execution
$Tcp.IPAddresses

# Enable the named pipes protocol for the default instance.
$uri = "ManagedComputer[@Name='<computer_name>']/ ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Np']"
$Np = $wmi.GetSmoObject($uri)
$Np.IsEnabled = $true
$Np.Alter()
$Np

#---------------------------------------------------------------
#  1353    max degree of parallelism  MAXDOP
#---------------------------------------------------------------
use the max degree of parallelism option to limit the number of processors to use in parallel plan execution. 
SQL Server considers parallel execution plans for queries, index data definition language (DDL) operations
, and static and keyset-driven cursor population.

若要讓伺服器判斷平行處理原則的最大程度，請將此選項設定為 0 (預設值)。將平行處理原則的最大程度設定為 0 就會允許 SQL Server 使用所有可用的處理器 (最多 64 個處理器)。
若要抑制平行計畫的產生，請將 max degree of parallelism 設成 1。
將此值設成 1 到 32,767 的數字會指定單一查詢執行可用的最大處理器核心數目。如果指定的數值大於可用的處理器數目，就會使用可用處理器的實際數目。如果電腦只有一個處理器，則會忽略 max degree of parallelism 值


USE AdventureWorks2012 ;
GO 
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
EXEC sp_configure 'max degree of parallelism', 8;
GO
RECONFIGURE WITH OVERRIDE;
GO

#---------------------------------------------------------------
#  1447    in-memory 
#---------------------------------------------------------------

https://mva.microsoft.com/zh-tw/training-courses/sql-server-2014-inmemory--11108?l=20Lt9xKAB_9104984382
https://mva.microsoft.com/zh-tw/training-courses/sql-server-2014-inmemory--11109


#---------------------------------------------------------------
#  1466    Set or Change the Database Collation
#---------------------------------------------------------------

--Verify the collation setting.  
SELECT name, collation_name  
FROM sys.databases  
WHERE name = N'IamSP2013';  
GO  

--  SQL_Latin1_General_CP1_CI_AS
--  Chinese_Taiwan_Stroke_CI_AS
--   Latin1_General_CI_AS_KS_WS

USE master;  
GO  
ALTER DATABASE TAODW_CSQ  
COLLATE Chinese_Taiwan_Stroke_CS_AS ;  
GO  

SELECT name, collation_name  
FROM sys.databases  



#---------------------------------------------------------------
#   1499  tempdb 移到新位置
#---------------------------------------------------------------
tempdb 移到新位置
 由於在每次啟動 MSSQLSERVER 服務時都會重新建立 tempdb，因此您不需要實際移動資料和記錄檔。 在步驟 3 重新啟動此服務時，將會建立檔案。 在重新啟動此服務之前，tempdb 會繼續在現有的位置運作。
決定 tempdb 資料庫的邏輯檔案名稱，及它們目前在磁碟中的位置。
SELECT name, physical_name  
FROM sys.master_files  
WHERE database_id = DB_ID('tempdb');  
GO  

請利用 ALTER DATABASE 來變更每個檔案的位置。
USE master;  
GO  
ALTER DATABASE tempdb   
MODIFY FILE (NAME = tempdev, FILENAME = 'E:\SQLData\tempdb.mdf');  
GO  
ALTER DATABASE  tempdb   
MODIFY FILE (NAME = templog, FILENAME = 'E:\SQLData\templog.ldf');  
GO  

停止和重新啟動 SQL Server 執行個體。
確認檔案變更。
SELECT name, physical_name  
FROM sys.master_files  
WHERE database_id = DB_ID('tempdb');  

#---------------------------------------------------------------
#  
#---------------------------------------------------------------



#---------------------------------------------------------------
#  
#---------------------------------------------------------------