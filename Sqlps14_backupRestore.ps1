<#Sqlps14_backupRestore
 C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps14_backupRestore.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 LastDate : APR.28.2014
 history : Mar.26.2014 +
 object : tsql

 $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\Sqlps14_backupRestore.ps1

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
# 1  交易記錄檔的使用狀況
# 2  截斷交易記錄 &  簡單完整模式
# 3  移動資料或記錄檔
# 123  壓縮記錄檔  SHRINK   FILE
# 5  結尾記錄備份 
# 6 127   備份 
# 7  還原資料庫 + 移動檔案    http://technet.microsoft.com/zh-tw/library/ms186858.aspx#examples
# 8  交易記錄還原到標記
# 9  清除檔案 
# 10 200 Changing database recovery model  using SMO p.30
# 11 300  Listing backup history  P309
# 12 300  Creating a backup device  p.310 
# 13      Listing backup header and file listinformation  p312
# 14 400  Creating a full backup  p316
# 15 500  Creating a backup on mirrored media sets  p321
# 16 550  Creating a differential backup   p324
# 17 600  Creating a transcation log  backup   p327
# 18 * 600  Creating a filegroup backup   p329
# 19      Restoring a database to a point in time   p332
# 20 800  Performing an online piecemeal restore p.34
# 21 800 Recovery-Only Database Restore  在不還原資料的情況下復原資料庫
# 22 How to read the SQL Server Database Transaction Log   sys.fn_dblog(NULL,NULL)
# 23  929  LSN  function
# 24 2166  Recovery Paths 復原路徑
# 25 * 2200  Piecemeal Restore of Databases  分次還原
# 26  2353    Logspace  DBSizeInfo   


















#---------------------------------------------------------------
#  1 交易記錄檔的使用狀況
#---------------------------------------------------------------

DBCC SQLPERF('LOGSPACE')
DBCC LOGINFO

#---------------------------------------------------------------
# 2  截斷交易記錄 &  簡單完整模式
#---------------------------------------------------------------
在「簡單」復原模式下，DB Engine 會在每一個檢查點（checkpoint）之後，自動進行截斷交易記錄。 
在「完整」或「大量記錄」復原模式下，只要執行「交易記錄」備份，DB Engine 就會自動進行截斷交易記錄。

## SQL2005
BACKUP LOG [TestDB] WITH TRUNCATE_ONLY

## SQL 2008 2012
--先變更為簡單模式
USE [TestDB]
GO
ALTER DATABASE [TestDB] SET RECOVERY SIMPLE WITH NO_WAIT

--壓縮資料庫
DBCC SHRINKFILE([log_file_name]/log_file_number, wanted_size)
DBCC SHRINKFILE(TestDB_log, 20) 單位為 M Byte

--再變更回完整模式
ALTER DATABASE [TestDB] SET RECOVERY FULL WITH NO_WAIT
GO

# 另一方法
USE YOURDB 
SELECT file_id, name, physical_name FROM sys.database_files;
SELECT * FROM sys.database_files; 
DBCC SHRINKFILE (2, 100);
DBCC LOGINFO;


#---------------------------------------------------------------
# 3  移動資料或記錄檔
#---------------------------------------------------------------
## Get
SELECT name, physical_name AS CurrentLocation, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'<database_name>');

## Move
ALTER DATABASE database_name SET OFFLINE;

ALTER DATABASE database_name MODIFY FILE ( NAME = logical_name , FILENAME = 'new_path\os_file_name' );

ALTER DATABASE database_name SET ONLINE;
#---------------------------------------------------------------
# 123  壓縮記錄檔  SHRINK   FILE
#---------------------------------------------------------------
## 必須先截斷交易記錄 ,交易記錄沒有被截斷，使用 DBCC SHRINKFILE 壓縮，得不到什麼效果
USE UserDB;
GO
DBCC SHRINKFILE (DataFile1, 7);
GO


DBCC Shrinkdatabase  databasename | database_id , Target_percent ,NoTruncate, truncateonly
with  no_informsgs

NoTruncate:  不要截斷.只需將檔案末端資料往前移
truncateonly : 只要截斷 檔案末端未使用空間, 不將資料往前移

DBCC Shrinkdatabase( dbname, truncateonly); #截斷 檔案末端未使用空間
DBCC Shrinkdatabase( dbname, truncateonly); #
 DBCC Shrinkdatabase( dbname, 10);  # 保留10%可用空間
DBCC Shrinkfile (Fg22,  5  ) 
DBCC shrinkfile (FG22, emptyfile) #  將檔案內資料移至並它檔案
alter database adventure2012  remove file FG22

#---------------------------------------------------------------
#  5結尾記錄備份  
#---------------------------------------------------------------
「結尾記錄備份」(tail-log backup) 可擷取任何尚未備份的記錄檔記錄 (「記錄結尾」(tail of the log))，來防止工作遺失，
並保持記錄鏈結完整。 將 SQL Server 資料庫復原到最新時間點之前，必須備份其交易記錄的結尾。 
結尾記錄備份會是資料庫之復原計畫中感興趣的最後一個備份。

##資料庫在線上
 Backup LOG AdventureWorks TO Disk='D:\DBBackup\AdventureWorks.trn' NO_TRUNCATE 


#---------------------------------------------------------------
#  127  6 備份    
#---------------------------------------------------------------
##備份完整資料庫
-- AdventureWorks資料庫至 D:\DBBackup 目錄中

Backup Database AdventureWorks TO Disk='D:\DBBackup\AdventureWorks.bak'



BACKUP DATABASE [multLogFile] TO  DISK = N'H:\SQLData\Backup\multLogFile_backup_2016_04_21_112435_1962721.bak' 
       WITH NOFORMAT, NOINIT,  NAME = N'multLogFile_backup_2016_04_21_112435_1962721', SKIP, REWIND, NOUNLOAD,  STATS = 10


BACKUP DATABASE [multLogFile] TO  DISK = N'H:\SQLData\Backup\multLogFile_backup_2016_04_21_112642_0662974.bak' 
      WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'multLogFile_backup_2016_04_21_112642_0662974', SKIP, REWIND, NOUNLOAD,  STATS = 10

BACKUP LOG [multLogFile] TO  DISK = N'H:\SQLData\Backup\multLogFile_backup_2016_04_21_112721_4803439.trn' 
       WITH NOFORMAT, NOINIT,  NAME = N'multLogFile_backup_2016_04_21_112721_4803439', SKIP, REWIND, NOUNLOAD,  STATS = 10


ii H:\SQLData\Backup\
rm H:\SQLData\Backup\*.*

#---------------------------------------------------------------
#  7還原資料庫 + 移動檔案    http://technet.microsoft.com/zh-tw/library/ms186858.aspx#examples
#---------------------------------------------------------------

RESTORE FILELISTONLY  FROM Disk ='path of *.bak'

RESTORE DATABASE AdventureWorks2012
   FROM Disk ='path of *.bak'
   WITH NORECOVERY, 
      MOVE 'AdventureWorks2012_Data' TO 'location of DB File   ex :NewAdvWorks.mdf', 
      MOVE 'AdventureWorks2012_Log'  TO 'location of Log File  ex :NewAdvWorks.ldf';

RESTORE LOG AdventureWorks2012
   FROM Disk ='path of *.trn'
   WITH RECOVERY;


RESTORE DATABASE AdventureWorks2012
   FROM Disk ='path of *.trn'
   WITH replace , 
      MOVE 'AdventureWorks2012_Data' TO 'location of DB File   ex :NewAdvWorks.mdf', 
      MOVE 'AdventureWorks2012_Log'  TO 'location of Log Fiel  ex :NewAdvWorks.ldf';



#---------------------------------------------------------------
# 8 交易記錄還原到標記
#---------------------------------------------------------------
USE AdventureWorks2012
GO
BEGIN TRANSACTION ListPriceUpdate
   WITH MARK 'UPDATE Product list prices';
GO

      UPDATE Production.Product
      SET ListPrice = ListPrice * 1.10
      WHERE ProductNumber LIKE 'BK-%';
GO

COMMIT TRANSACTION ListPriceUpdate;
GO

-- Time passes. Regular database 
-- and log backups are taken.
-- An error occurs in the database.


USE master;
GO

RESTORE DATABASE AdventureWorks2012
FROM AdventureWorksBackups
WITH FILE = 3, NORECOVERY;
GO

RESTORE LOG AdventureWorks2012
   FROM AdventureWorksBackups 
   WITH FILE = 4,
   RECOVERY, 
   STOPATMARK = 'UPDATE Product list prices';

#---------------------------------------------------------------
# 9 清除檔案 
#---------------------------------------------------------------

清除檔案，使其能從資料庫中移除的程序。 在此範例中會先建立一個資料檔，然後假設該檔案包含資料

USE AdventureWorks2012;
GO
-- Create a data file and assume it contains data.
ALTER DATABASE AdventureWorks2012 
ADD FILE (
    NAME = Test1data,
    FILENAME = 'C:\t1data.ndf',
    SIZE = 5MB
    );
GO
-- Empty the data file.
DBCC SHRINKFILE (Test1data, EMPTYFILE);
GO
-- Remove the data file from the database.
ALTER DATABASE AdventureWorks2012
REMOVE FILE Test1data;
GO



#---------------------------------------------------------------
# 10 200 Changing database recovery model  using SMO p.306
#---------------------------------------------------------------

$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
$databasename = "AdventureWorks2008R2"
$database = $server.Databases[$databasename]
#possible values for RecoveryModel are
#Full, Simple and BulkLogged
$database.DatabaseOptions.RecoveryModel = [Microsoft.SqlServer.
Management.Smo.RecoveryModel]::Simple
$database.Alter()
$database.Refresh()
#list Recovery Model again
$database.DatabaseOptions.RecoveryModel
#remember to change the recovery model back
#to full for the next recipes

## There's more
RecoveryModel is a database property that specifies what backup and restore operations are permitted. 
There are three possible values for RecoveryModel: Full, BulkLogged, and Simple.

Full and BulkLogged recovery models allow the use of logfiles for backup and restore purposes. 
The Full recovery model heavily uses the transaction logfiles, and allows for point-in-time recovery.
The BulkLogged recovery model minimally logs the bulk events. If there are no bulk events in the system, then point-in-time recovery is possible. If there are bulk events, however, pointin-
time recoverability will be affected, and it is possible not to be able to recover from your
logfiles at all. See Paul Randal's blog post on A SQL Server DBA myth a day: (28/30) BULK_

LOGGED recovery model:
http://www.sqlskills.com/BLOGS/PAUL/post/A-SQL-Server-DBA-myth-a-day-(2830)-BULK_LOGGED-recovery-model.aspx

The Simple recovery model does not support transaction log backups and restores at all. This means that there is no point-in-time recovery possible, and the window for data
loss could be large. Simple recovery model, therefore, is not a recommended setting for production servers; it can be a setting used for development and sandbox servers, or any
instance where data loss would not be critical.
The RecoveryModel you choose in your environment will typically be determined by the
company's Recovery Point Objective (RPO) and Recovery Time Objective (RTO), although in
most cases the recommended setting would be Full recovery model.
Read more about RecoveryModel from MSDN:
http://msdn.microsoft.com/en-us/library/ms189275(v=sql.110).aspx


##




#---------------------------------------------------------------
# 11  300  Listing backup history  P309
#---------------------------------------------------------------

(2)Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
(3). Add the following script and run:
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#display date of last backup
$server.Databases |
Select Name, RecoveryModel, LastBackupDate,
LastDifferentialBackupDate, LastLogBackupDate |
Format-Table -AutoSize




#---------------------------------------------------------------
# 12 300  Creating a backup device  p.310 
#---------------------------------------------------------------

##The equivalent T-SQL of what we are trying to accomplish is:
EXEC master.dbo.sp_addumpdevice @devtype = N'disk',
@logicalname = N'Full Backups',
@physicalname = N'C:\Backup\backupfile.bak'

##
(2)Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
(3). Add the following script and run:
$instanceName = "sp2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.
Smo.Server -ArgumentList $instanceName
#this file will be created by PowerShell/SMO
$backupfilename = "Full Backups"
$backupfile = "C:\Backup\backupfile.bak"
$backupdevice = New-Object Microsoft.SqlServer.Management.Smo.BackupDevice($server,$backupfilename)
#BackupDeviceType values are:
#CDRom, Disk, FloppyA, FloppyB, Tape, Pipe, Unknown
$backupdevice.BackupDeviceType = [Microsoft.SqlServer.Management.Smo.BackupDeviceType]::Disk
$backupdevice.PhysicalLocation = $backupfile
$backupdevice.Create()
#list backup devices
$server.BackupDevices
(4)Confirm by using SQL Server Management Studio. Log in to your instance and expand
Backup Devices. You should see the new backup device you created in PowerShell.

#---------------------------------------------------------------
# 13 Listing backup header and file listinformation  p312
#---------------------------------------------------------------

##
(2)Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
(3). Add the following script and run:
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$smoRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore
#replace this with your backup file
$backupfile = "AdventureWorks2008R2_Full_20120205231407.bak"
#change this to where your backup directory is
#in our case we're using default backup directory
$backupfilepath = Join-Path $server.Settings.BackupDirectory
$backupfile
$smoRestore.Devices.AddDevice($backupfilepath, [Microsoft.SqlServer.Management.Smo.DeviceType]::File)
$smoRestore.ReadBackupHeader($server)
$smoRestore.ReadFileList($server)

(4)To display the file list information, add the following script and run:
Notice that you can see properties such as LogicalName, PhysicalName,
FileGroupName, and Size of both the data and logfiles associated with
this backup file.

$smoRestore.ReadFileList($server)


##Microsoft.SqlServer.Management.Smo. Restore class lists all the backup headers

 BackupName and Description
 BackupType
 Compressed
 ServerName
 DatabaseName
 DatabaseVersion and DatabaseCreationDate
 BackupSize
 CheckpointLSN
 DatabaseBackupLSN
 Backup start and finish date



#---------------------------------------------------------------
# 14  400  Creating a full backup  p316
#---------------------------------------------------------------

##T-SQL syntax that will be generated by this PowerShell recipe will look similar to:
BACKUP DATABASE [AdventureWorks2008R2]
TO DISK = N'C:\Backup\AdventureWorks2008R2_Full_20120227092409.bak'
WITH NOFORMAT, INIT,
NAME = N'AdventureWorks2008R2 Full Backup',
NOSKIP, REWIND, NOUNLOAD, COMPRESSION,
STATS = 10, CHECKSUM



##PS
(2). Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
(3). Add the following script and run:
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$databasename = "AdventureWorks2008R2"
$timestamp = Get-Date -Format yyyyMMddHHmmss
$backupfolder = "C:\Backup\"
$backupfile = "$($databasename)_Full_$($timestamp).bak"
$fullBackupFile = Join-Path $backupfolder $backupfile
Backup-SqlDatabase `
-ServerInstance $instanceName `
-Database $databasename `
-BackupFile $fullBackupFile `
-Checksum `
-Initialize `
-BackupSetName "$databasename Full Backup" `
-CompressionOption On

(4). Confirm by reading the backup header. Add the following script and run:
#confirm by reading the header
#backup type for full is 1
#this is a block of code you would want to put
#in a function so you can use anytime
$smoRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore
$smoRestore.Devices.AddDevice($fullBackupFile, [Microsoft.SqlServer.Management.Smo.DeviceType]::File)
$smoRestore.ReadBackupHeader($server)
$smoRestore.ReadFileList($server)

##There's more...
Although there is already a cmdlet available for backing up databases, it will also be useful to
look at how you can do the backups via SMO. Using SMO may be the more code-heavy way of
tackling a database backup in PowerShell, but it is nonetheless still very powerful and flexible.
The cmdlet can be viewed as simply a wrapper to the SMO backup methods. Taking a peek at
how this is done can be a beneficial exercise.
The first few steps for this approach are similar to the steps we have for this recipe:
import SQLPS, and create the SMO server object. After that, we will need to create
an SMO Backup object.
$databasename = "AdventureWorks2008R2"
$timestamp = Get-Date -Format yyyyMMddHHmmss
$backupfolder = "C:\Backup\"
$backupfile = "$($databasename)_Full_$($timestamp).bak"
$fullBackupFile = Join-Path $backupfolder $backupfile
#This belongs in Microsoft.SqlServer.SmoExtended assembly
$smoBackup = New-Object Microsoft.SqlServer.Management.Smo.Backup
With a handle to the SMO backup object, you will have more granular control over what values
are set to which properties. Action can be any of Database, File, or Log.
$smoBackup.Action = [Microsoft.SqlServer.Management.Smo.
BackupActionType]::Database
$smoBackup.BackupSetName = "$databasename Full Backup"
$smoBackup.Database = $databasename
$smoBackup.MediaDescription = "Disk"
$smoBackup.Devices.AddDevice($fullBackupFile, "File")
$smoBackup.Checksum = $true
$smoBackup.Initialize = $true
$smoBackup.CompressionOption = [Microsoft.SqlServer.Management.Smo.
BackupCompressionOptions]::On
You can also optionally set up your own event notification on the backup progress using the
Microsoft.SqlServer.Management.Smo.PercentCompleteEventHandler and
Microsoft.SqlServer.Management.Common.ServerMessageEventHandler classes.
#the notification part below is optional
#it just creates an
#event handler that indicates progress every 20%
$smoBackup.PercentCompleteNotification = 20
$percentEventHandler = [Microsoft.SqlServer.Management.Smo.
PercentCompleteEventHandler] {
Write-Host "Backing up $($databasename)...$($_.Percent)%"
}
$completedEventHandler = [Microsoft.SqlServer.Management.Common.
ServerMessageEventHandler] {
Write-Host $_.Error.Message
}
$smoBackup.add_PercentComplete($percentEventHandler)
$smoBackup.add_Complete($completedEventHandler)
When done setting the properties, you can just invoke the SqlBackup method of the SMO
Backup class and pass the server object:
#backup
$smoBackup.SqlBackup($server)
Conversely, when you do a restore with SMO, the steps are going to be pretty similar. You
will need to create the SMO Restore object, set the properties, and call the SqlRestore
method of the Restore class in the end.


More about Backup and PercentCompleteEventHandler
Learn more about these SMO classes:
ff BackupRestoreBase: http://msdn.microsoft.com/en-us/library/
microsoft.sqlserver.management.smo.backuprestorebase.
percentcomplete.aspx
ff PercentCompleteEventHandler: http://msdn.microsoft.com/
en-us/library/microsoft.sqlserver.management.smo.
percentcompleteeventhandler.aspx



#---------------------------------------------------------------
# 15  500  Creating a backup on mirrored media sets  p321
#---------------------------------------------------------------

## TSQL
BACKUP DATABASE [AdventureWorks2008R2]
TO DISK = N'AdventureWorks2008R2.bak'
MIRROR TO DISK = N'C:\Backup\AdventureWorks2008R2_Full_20120227092409_Copy1.bak'
MIRROR TO DISK = N'C:\Backup\AdventureWorks2008R2_Full_20120227092409_Copy2.bak'
WITH FORMAT, INIT,
NAME = N'AdventureWorks2008R2 Full Backup', SKIP, REWIND,
NOUNLOAD, COMPRESSION, STATS = 10, CHECKSUM


## PS
Add the following script and run:
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$databasename = "AdventureWorks2008R2"

#create filenames, which we will use as Device
$databasename = "AdventureWorks2008R2"
$timestamp = Get-Date -Format yyyyMMddHHmmss
$backupfolder = "C:\Backup\"
$backupfile1 = Join-Path $backupfolder "$($databasename)_Full_$($timestamp)_Copy1.bak"
$backupfile2 = Join-Path $backupfolder "$($databasename)_Full_$($timestamp)_Copy2.bak"
#create a backup device list
#in this example, we will only use two (2)
#mirrored media sets
#note a maximum of four (4) is allowed
$backupDevices = New-Object Microsoft.SqlServer.Management.Smo.BackupDeviceList(2)
$backupDevices.AddDevice($backupfile1, [Microsoft.SqlServer.Management.Smo.DeviceType]::File)
$backupDevices.AddDevice($backupfile2, [Microsoft.SqlServer.Management.Smo.DeviceType]::File)
#backup database
Backup-SqlDatabase `
-ServerInstance $instanceName `
-Database $databasename `
-BackupSetName "$databasename Full Backup" `
-Checksum `
-Initialize `
-FormatMedia `
-SkipTapeHeader `
-MirrorDevices $backupDevices `
-CompressionOption On

##
-Initialize Specifies backup set contained in the file or backup device will be overwritten
-FormatMedia Overwrites existing media header information, and creates a new media set
-SkipTapeHeader Skip checking backup tape expiration
-MirrorDevices Allows backup on mirrored media sets; accepts a BackupDeviceList array

#---------------------------------------------------------------
# 16 550  Creating a differential backup   p324
#---------------------------------------------------------------
##Getting Ready
'
We will use the AdventureWorks2008R2 database for this recipe. 
We will create a differential compressed backup of the database to a timestamped .bak file in the
H:\Backup folder. Feel free to use a database of your choice for this task.
'
##T-SQL syntax that will be generated by this PowerShell recipe will look similar to:
BACKUP DATABASE [AdventureWorks2008R2]
TO DISK = N'H:\Backup\AdventureWorks2008R2_Diff_20120227092409.bak'
WITH DIFFERENTIAL , NOFORMAT, INIT,
NAME = N'AdventureWorks2008R2 Diff Backup',
NOSKIP, REWIND, NOUNLOAD, COMPRESSION,
STATS = 10, CHECKSUM


##PS
(3). Add the following script and run:
$instanceName = "SP2013"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.
Server -ArgumentList $instanceName
$databasename = "AdventureWorks2008R2"
$timestamp = Get-Date -Format yyyyMMddHHmmss
$backupfolder = "C:\Backup\"
$backupfile = "$($databasename)_Diff_$($timestamp).bak"
$diffBackupFile = Join-Path $backupfolder $backupfile
Backup-SqlDatabase `
-ServerInstance $instanceName `
-Database $databasename `
-BackupFile $diffBackupFile `
-Checksum `
-Initialize `
-Incremental `
-BackupSetName "$databasename Diff Backup" `
-CompressionOption On

(4) Confirm by reading the backup header. Add the following script and run:
#confirm by reading the header
#backup type for differential is 5
#this is a block of code you would want to put
#in a function so you can use anytime
$smoRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore
$smoRestore.Devices.AddDevice($diffBackupFile, [Microsoft.SqlServer.Management.Smo.DeviceType]::File)
$smoRestore.ReadBackupHeader($server)
$smoRestore.ReadFileList($server)


#---------------------------------------------------------------
# 17 600  Creating a transcation log  backup   p327
#---------------------------------------------------------------


##T-SQL syntax that will be generated by this PowerShell recipe will look similar to:
BACKUP LOG [AdventureWorks2008R2]
TO DISK = N'C:\Backup\AdventureWorks2008R2_Txn_20120815235319.trn'
WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, STATS = 10


##PS
3. Add the following script and run:
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#create a transaction log backup
$databasename = "AdventureWorks2008R2"
$timestamp = Get-Date -Format yyyyMMddHHmmss
$backupfolder = "H:\Backup\"
$backupfile = "$($databasename)_Txn_$($timestamp).trn"
$txnBackupFile = Join-Path $backupfolder $backupfile

Backup-SqlDatabase `
-BackupAction Log `
-ServerInstance $instanceName `
-Database $databasename `
-BackupFile $txnBackupFile


#---------------------------------------------------------------
# 18 600  Creating a filegroup backup   p329
#---------------------------------------------------------------
{<# Getting ready   CREATE DATABASE [StudentDB]
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


##PS
Add the following script and run:
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$databasename = "StudentDB"
$timestamp = Get-Date -Format yyyyMMddHHmmss
#create a file to backup FG1 filegroup
$backupfolder = "C:\Backup\"
$backupfile   = "$($databasename)_FG1_$($timestamp).bak"
$fgBackupFile = Join-Path $backupfolder $backupfile
Backup-SqlDatabase `
-BackupAction Files `
-DatabaseFileGroup "FG1" `
-ServerInstance $instanceName `
-Database $databasename `
-BackupFile $fgBackupFile `
-Checksum `
-Initialize `
-BackupSetName "$databasename FG1 Backup" `
-CompressionOption On


#confirm by reading the header
#backup type for files is 4
#this is a block of code you would want to put
#in a function so you can use anytime
$smoRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore
$smoRestore.Devices.AddDevice($fgBackupFile, [Microsoft.SqlServer.Management.Smo.DeviceType]::File)
$smoRestore.ReadBackupHeader($server)
#>}
#sqlps02_Sqlconfiguration.# 24  1015   List All Objects Created on All Filegroups in Databas

#A filegroup named FG1 that has the files mingDBFG1F1 and mingDBFG1F2.
#A filegroup named FG2 that has the files mingDBFG2F1 and mingDBFG2F2.

if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }
$dbt='mingDB'

function selectFileGroupONPath ([string] $instance,[string] $dbname ){
# selectFileGroupONPath sp2013 mingdb
# $instance='sp2013'
$tsql_selectFPonPath=@"
select y.name as FileGroup,  d.name as FileName, d.physical_name as PhysicalName ,d.state_desc as state_desc
from sys.filegroups y
left join [sys].[database_files] d 
on y.data_space_id=d.data_space_id 
order by y.name;
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectFPonPath -Database $dbname  -ServerInstance  $instance
$y | ft -auto
$y.count
}#function selectFileGroupONPath
selectFileGroupONPath sp2013 FGRestoreTEST
selectFileGroupONPath sql2012x FGRestoreTEST
selectFileGroupONPath sql2012x MyBigOrderDb

function selectTableONFileGroup ([string] $instance,[string] $dbname ){
# selectTableONFileGroup sp2013 mingdb
# $instance='sp2013'
$tsql_selectTableONFileGroup=@"
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
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectTableONFileGroup -Database $dbname  -ServerInstance  $instance
$y | ft -auto
$y.count
}#function selectTableONFileGroup
selectTableONFileGroup sql2012x  MyBigOrderDb
selectTableONFileGroup sp2013  FGRestoreTEST
selectTableONFileGroup sql2012x  FGRestoreTEST
selectTableONFileGroup sp2013 $dbt

[string] $dbname,[string]$bakpath

function backupFBFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string]$FGName){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
#$FGName='FGX'
# backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1
$bafFile=$backuppath+'\'+$dbname+'_'+$FGName+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.baf' ;#$bafFile 
switch ($FGName){
    'FGX' { 
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1',FILEGROUP = 'FG2'
     TO DISK = N'$bafFile';
GO
"@ }#FGX
    'FG1' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1'
     TO DISK = N'$bafFile';
GO
"@ }#FG1
    'FG2' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG2'
     TO DISK = N'$bafFile';
GO
"@ }#FG2
    'PRIMARY' {
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'PRIMARY'
     TO DISK = N'$bafFile';
GO
"@}
}#switch

#$tsql_backupFG
Invoke-Sqlcmd  -Query  $tsql_backupFG  -QueryTimeout  2400  -ServerInstance $instance 
}#backupFBFileGroup
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1

function backupDiffFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string]$FGName){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
#$FGName='FGX'
# backupDiffFileGroup  sp2013 mingdb \\SP2013\temp PRIMARY
$bafFile=$backuppath+'\'+$dbname+'_'+$FGName+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.ddf' ;#$bafFile 
switch ($FGName){
    'FGX' { 
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1',FILEGROUP = 'FG2'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL ;
GO
"@ }#FGX
    'FG1' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@ }#FG1
    'FG2' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG2'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@ }#FG2
    'PRIMARY' {
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'PRIMARY'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@}
}#switch

#$tsql_backupFG
Invoke-Sqlcmd  -Query  $tsql_backupFG  -QueryTimeout  2400  -ServerInstance $instance
}#backupDiffFileGroup
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp PRIMARY


function backupFG_FGX ([string] $instance,[string] $dbname,[string]$bakpath){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
$
$bakFile=$backuppath+'\'+$dbname+'_FGX_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bck' ;#$bakFile
  $tsql_backupFG=@"
--Back up the files in SalesGroup1.
BACKUP DATABASE $dbt
   FILEGROUP = 'FG1',
   FILEGROUP = 'FG2'
   TO DISK = N'$bakFile';
GO
"@
Invoke-Sqlcmd  -Query  $tsql_backupFG  -QueryTimeout  2400  -ServerInstance sp2013 
  
}#backupFG_FGX
function backupFG_PMRY ([string] $instance,[string] $dbname,[string]$bakpath){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
#backupFG_PMRY  sp2013 mingdb  \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_PMRY_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bck' ;#$bakFile
  $tsql_backupPMRY=@"

BACKUP DATABASE $dbt
   FILEGROUP = 'Primary'
   TO DISK = N'$bakFile';
GO
"@
Invoke-Sqlcmd  -Query  $tsql_backupPMRY  -QueryTimeout  2400  -ServerInstance sp2013 
  
}#backupFG_PMRY

function deleteT6 ([string] $instance,[string] $dbname,[string] $lvalues){
 #  deleteT6 sp2013 mingdb '< 20'
 
  $tsql_DeleteT6=@"
  Delete from  [dbo].[T6] where rid $lvalues
"@  
#$tsql_DeleteT6
Invoke-Sqlcmd  -Query  $tsql_DeleteT6  -Database $dbname    -ServerInstance sp2013 

}#function deleteT6

function GetBAFFile ($bakpath, $dbname, $whatday ,$hourrange ){ #  1168 function
#$d=GetBAFFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto
#GetBAFFile  \\SP2013\temp\ mingdb '2015-05-08  23:10:00' -48
#$bakpath= '\\SP2013\temp\'
#$dbname  = 'mingdb'
#$whatday='2015-05-05  10:10:00'
#$hourrange =-48

$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.baf';#$bpath
cd c:
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddHours($hourrange)
    $bakf |Select name ,creationTime,LastWriteTime,length |sort LastWriteTime -Descending
}# 1168 GetBAFFile

Function restoreFBFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string] $FGName ,[string] $bFile){
#$instance  ='sql2012x'
#$dbname    ='mingdb'
#$backuppath='\\SP2013\temp\'
#$FGName    ='FG1'
#$bFile     ='mingdb_FG1_2015-05-11_11-21-15.baf'
#restoreFBFileGroup  sql2012x mingdb  \\SP2013\temp\  FG1  mingdb_FG1_2015-05-11_11-21-15.baf
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM   DISK = N'$bakFile'
   with REPLACE ,RECOVERY
"@  
#$tsql_restoreFBdatabase
$t1=get-date
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400
$t2=get-date

}#function restoreFBFileGroup

function restoreFBFileGroupNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $FGName ,[string] $bFile){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
#restoreFBFileGroupNORECOVERY  sql2012x mingdb  \\SP2013\temp\ FG1  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM   DISK = N'$bakFile'
   with REPLACE ,NORECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFBFileGroupNORECOVERY

function restoreDiffFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string] $FGName ,[string] $bFile ,[string] $NORecovery){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
#restoreDiffFileGroup  sql2012x mingdb  \\SP2013\temp\ FG1  mingdb_2015-05-04_00-02-11.bak RECOVERY
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")

if ($NORecovery -eq 'Recovery'){
 $tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM   DISK = N'$bakFile'
   with RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400   
} #if
else{
  $tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM DISK = N'$bakFile'
   with NORECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400
  
} #else



}#function restoreDiffFileGroup

function restoreLogR ([string] $instance,[string] $dbname,[string]$bakpath,[string] $NORecovery){
#$backuppath='\\SP2013\temp'
# backupLog mingdb \\SP2013\temp
# backupLogR 
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.trn' ;#$bakFile
if ($NORecovery -eq 'Recovery' ){
    $tsql_restorelogR=@"
   restore Log $dbname from  DISK = N'$bakFile' 
"@  
Invoke-Sqlcmd  -Query  $tsql_restorelogR   -ServerInstance $instance -Database $dbname
} #if
else{
$tsql_restorelogR=@"
   restore Log $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restorelogR   -ServerInstance $instance -Database $dbname
} #else
}#function restoreLogR

function restoreDBonline ([string] $instance,[string] $dbname){
#$backuppath='\\SP2013\temp'
# restoreDBonline mingdb \\SP2013\temp
# restoreDBonline sp2013 mingdb
$tsql_restoreDBonline=@"
   restore Database $dbname with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDBonline   -ServerInstance $instance -Database $dbname
}#function restoreDBonline

function restoreFG_PMRY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
$instance='sp2013'
$dbname='mingdb'
$backuppath='\\SP2013\temp\'
$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
# restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = 'PRIMARY'
   FROM   DISK = N'$bakFile'
   with REPLACE --,RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFG_PMRY

function restoreFG_FGX ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
# restoreFG_FGX  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = 'FG1',
   FILEGROUP = 'FG2'
   FROM   DISK = N'$bakFile'
   with REPLACE --,RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFG_FGX





<#-----case1-----#>
{<#
if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }
truncateT6 $dbt ;
insertT6 mingdb 50    # 5/8/2015 1:26:00 PM  50  50 769 42768DB0-B17C-47BE-B4DD-EE1025F1FC38 ,


backupFG_PMRY  sp2013  mingdb  \\SP2013\temp  #save to mingdb_PMRY_2015-05-08_13-34-06.bck

selectFileGroupONPath  sp2013 $dbt


GetbdlFile  \\SP2013\temp\ mingdb '2015-05-08  23:10:00' -24 |fl

mingdb_FGX_2015-05-08_13-11-00.bck

truncateT6 $dbt ;
insertT6 mingdb 99  #5/8/2015 2:05:00 PM  99  99 180 0164EF1E-782E-403D-8893-A44920A4BE62 

$t1=get-date
restoreFG_PMRY  sp2013  mingdb  \\SP2013\temp\  mingdb_PMRY_2015-05-08_13-34-06.bck  1 min12 sec
$t2=get-date
$t2-$t1

selectT6modtime sp2013 mingdb
RESTORE DATABASE mingdb WITH RECOVERY;
#>}
<#-----case2-----#>
http://stackoverflow.com/questions/25841822/backup-and-restore-sql-server-database-filegroup
<#-----case  511  -----#>
{<#
#(3.0)  ref: sqlps02_Sqlconfiguration. 24  1015   List All Objects Created on All Filegroups in Databas

#2 create tabel on File Group
{0 create table t6 on FG1,create table t6 on FG1,



CREATE TABLE Student
(
ID INT IDENTITY(1,1) NOT NULL,
FName VARCHAR(50),
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([ID] ASC)
on [FG2]
)
GO


CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [FG1]
GO



}

selectFileGroupONPath sp2013 mingdb
selectTableONFileGroup sp2013 mingdb


#3.Insert T6  Student
{<#INSERT INTO Student(FName)
VALUES('Joe')
GO 20
INSERT INTO Student(FName)
SELECT FName FROM Student
GO 10
# check how many records are inserted
# this should give 20480
SELECT COUNT(*) FROM Student

truncateT6 $dbt ;seledctT6 $dbt

Student.count: 20480
T6:count=100


#>}
#4.First Fbbackup
{<#
backupFBdatabase sp2013 mingdb  \\SP2013\temp  # mingdb_2015-05-11_10-42-42.bak , T6 100, Student 20480

selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto    #mingdb_2015-05-11_10-42-42.bak

restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-11_10-42-42.bak

selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb

select count(*) from sql2012x.mingdb.dbo.student
selectFileGroupONPath sql2012x mingdb
selectTableONFileGroup sql2012x mingdb
#>}

#5.Delete T6 ,drop Student 
{<#
DeleteT6 sp2013 mingdb '< 20'
Drop table student
#>}


#6 backup FB FileGroup

{<#
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1 # mingdb_FG1_2015-05-11_11-21-15.baf  # T6.count 81
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG2   #mingdb_FG2_2015-05-11_11-22-47.baf  #student null
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  

select top 5 *  from mingdb.dbo.t6 order by createDate desc
select count(*) from mingdb.dbo.student

select top 5 *  from sql2012x.mingdb.dbo.t6 order by createDate desc
select count(*) from sql2012x.mingdb.dbo.student
#>}

#7 insert T6 119 , create student  add 90
{<#
INSERT INTO Student(FName)
VALUES('Hell Ming')
GO 90

insertT6 mingdb 119
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb

#>}
#8 backup DB FileGroup
{<#
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp FG1  #  mingdb_FG1_2015-05-11_11-49-33.ddf   t6 200
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp FG2  #  mingdb_FG2_2015-05-11_11-52-23.ddf    student 90.

selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#9 insert T6 =250
{<#
insertT6 mingdb 50
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb
#>}
# 10 backup Log 1 
{<#
backupLog mingdb \\SP2013\temp  #mingdb_2015-05-11_13-40-20.trn t6.count= 250
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#11 insert T6 =250
{<#
insertT6 mingdb 250
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb
#>}
#12  backup DB FileGroup 2
{<#
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp FG1  #  mingdb_FG1_2015-05-11_13-51-26.ddf   t6.count= 500
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#13 insert T6 500 (count.1000)
{<#
insertT6 mingdb 500
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb
#>}
#14 backup Log2
{<#
backupLog mingdb \\SP2013\temp  #mingdb_2015-05-11_13-56-12.trn  t6.count= 1000
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#15 Backup FB  FileGroup 2
{<#
<INDEX>
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1  #mingdb_FG1_2015-05-11_14-20-52.baf # T6.count 1000
#>}
#16 insert student 
{<#
INSERT INTO Student(FName)
SELECT FName FROM Student

GO 10
#>}
#17 Backup FB  FileGroup 3
{<#
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG2  #mingdb_FG2_2015-05-11_14-26-02.baf #student 102400
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}

#18  restre FG1 to 11-21-15 t6.count=81
GetbdlFile  H:\SQLServer\backups FGRestoreTEST  '2015-05-11  23:00:00' -24 |ft -auto  


selectT6modtime sp2013 mingdb

$t1=get-date
restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-11_10-42-42.bak  #1min 32 sec
$t2=get-date  ($t2-$t1)

selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb

#
$t1=get-date
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-11_10-42-42.bak   # 1 min 39sec
$t2=get-date

$t1=get-date
restoreFBdatabaseNORECOVERY sp2013 mingdb  \\SP2013\temp\ mingdb_2015-05-11_10-42-42.bak   # 1 min 39sec
$t2=get-date


$t1=get-date
restoreFBFileGroup  sp2013  mingdb  \\SP2013\temp\  FG1  mingdb_FG1_2015-05-11_11-21-15.baf # 36 sec
$t2=get-date

selectbackupset  FGRestoreTEST
selectTableONFileGroup sql2012x FGRestoreTESTselectFileGroupONPath sql2012x FGRestoreTEST

 RESTORE HEADERONLY   FROM DISK = N'\\SP2013\temp\mingdb_FG1_2015-05-11_11-21-15.baf'
 StartDate 2015-05-11 11:21:20.000
 FLSN  2599000002457600180
 LLSN  2599000002465200001
 2599000002442400001


restoreDBonline sql2012x mingdb

selectFileGroupONPath sp2013 FGRestoreTEST
selectTableONFileGroup sp2013 FGRestoreTEST


#>}
<#-----case4-----#>


--Backup the files in the SalesGroup1 secondary filegroup.
BACKUP DATABASE $dbt
   FILE = 'SGrp1Fi2', 
   FILE = 'SGrp2Fi2' 
   TO DISK = 'G:\SQL Server Backups\Sales\SalesGroup1.bck';
GO

--Back up the files in SalesGroup1.
BACKUP DATABASE $dbt
   FILEGROUP = 'FG1',
   FILEGROUP = 'FG2'
   TO DISK = 'C:\MySQLServer\Backups\Sales\SalesFiles.bck';
GO

--Back up the files in SalesGroup1.
BACKUP DATABASE Sales
   FILEGROUP = 'SalesGroup1',
   FILEGROUP = 'SalesGroup2'
   TO DISK = 'C:\MySQLServer\Backups\Sales\SalesFiles.bck';
GO



#-- Restoring using FILE and FILEGROUP syntax
RESTORE DATABASE MyDatabase
   FILE = 'MyDatabase_data_1',
   FILE = 'MyDatabase_data_2',
   FILEGROUP = 'new_customers'
   FROM MyDatabaseBackups
   WITH 
      FILE = 9,
      NORECOVERY;
GO
-- Restore the log backups.

RESTORE LOG MyDatabase
   FROM MyDatabaseBackups
   WITH FILE = 10, 
      NORECOVERY;
GO
RESTORE LOG MyDatabase
   FROM MyDatabaseBackups
   WITH FILE = 11, 
      NORECOVERY;
GO
RESTORE LOG MyDatabase
   FROM MyDatabaseBackups
   WITH FILE = 12, 
      NORECOVERY;
GO
--Recover the database:
RESTORE DATABASE MyDatabase WITH RECOVERY;
GO


#---


RESTORE DATABASE Sales FILEGROUP=SalesGroup2 WITH RECOVERY

#---------------------------------------------------------------
# 19    Restoring a database to a point in time   p332
#---------------------------------------------------------------
'three different backup types:
 Full backup
 Differential backup
 Transaction log backup

 Step 1 – Gather your backup files
 Step 2 – Restore the last good full backup, with NORECOVERY
 Step 3 – Restore the last good differential backup taken after the full backup you just restored, with NORECOVERY
 Step 4 – Restore the transaction logs taken after your differential backup
'

we will restore the AdventureWorks2008R2 database to a second instance,
KERRIGAN\SQL01, up to 2012-04-07 08:21:59. This means that after the point-in-time
restore, we should have only four timestamped Student tables in KERRIGAN\SQL01
restored database:
 StudentFull_201204070818
 StudentDiff_201204070819
 StudentTxn_201204070820
 StudentTxn_201204070821

 ##PS
(3) Add the following script and run:
$instanceName = "KERRIGAN\SQL01"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
#backupfilefolder
$backupfilefolder = "C:\Backup\"
#look for the last full backupfile
#you can be more specific and specify filename
$fullBackupFile =
Get-ChildItem $backupfilefolder -Filter "*Full*" |
Sort -Property LastWriteTime -Descending |
Select -Last 1
#read the filelist info within the backup file
#so that we know which other files we need to restore
$smoRestore = New-Object Microsoft.SqlServer.Management.Smo.
Restore
$smoRestore.Devices.AddDevice($fullBackupFile.FullName,
[Microsoft.SqlServer.Management.Smo.DeviceType]::File)
$filelist = $smoRestore.ReadFileList($server)
#read headers of the full backup file,
#because we are restoring to a default instance, we will
#need to specify we want to move the files
#to the default data directory of our KERRIGAN\SQL01 instance
$relocateFileList = @()
$relocatePath = "C:\Program Files\Microsoft SQL Server\MSSQL11.
SQL01\MSSQL\DATA"
#we are putting this in an array in case we have
#multiple data and logfiles associated with the database
foreach($file in $fileList)
{
#restore to different instance
#replace default directory path for both
$relocateFile = Join-Path $relocatePath (Split-Path $file.
PhysicalName -Leaf)
$relocateFileList += New-Object Microsoft.SqlServer.
Management.Smo.RelocateFile($file.LogicalName, $relocateFile)
}
#let's timestamp our restored databasename
#this is strictly for testing our recipe
$timestamp = Get-Date -Format yyyyMMddHHmmss
$restoredDBName = "AWRestored_$($timestamp)"
#====================================================
#restore the full backup to the new instance name
#====================================================
#note we have a NoRecovery option, because we have
#additional files to restore
Restore-SqlDatabase `
-ReplaceDatabase `
-ServerInstance $instanceName `
-Database $restoredDBName `
-BackupFile $fullBackupFile.FullName `
-RelocateFile $relocateFileList `
-NoRecovery
#====================================================
#restore last differential
#note the database is still in Restoring State
#====================================================
#using PowerShell V2 Where syntax
$diffBackupFile =
Get-ChildItem $backupfilefolder -Filter "*Diff*" |
Where {$_.LastWriteTime -ge $fullBackupFile.LastWriteTime} |
Sort -Property LastWriteTime -Descending |
Select -Last 1
Restore-SqlDatabase `
-ReplaceDatabase `
-ServerInstance $instanceName `
-Database $restoreddbname `
-BackupFile $diffBackupFile.FullName `
-NoRecovery
#====================================================
#restore all transaction log backups from last
#differential up to 2012-04-07 08:21:59
#====================================================
#identify the last txn log backup file we need to restore
#we need this so we can specify point in time
$lastTxnFileName = "AdventureWorks2008R2_Txn_201204070821"
$lastTxnBackupFile =
Get-ChildItem $backupfilefolder -Filter "*$lastTxnFileName*"
#restore all transaction log backups after the
#last differential, except the last transaction
#backup that requires the point-in-time restore
foreach ($txnBackup in Get-ChildItem $backupfilefolder -Filter
"*Txn*" |
Where {$_.LastWriteTime -ge $diffBackupFile.LastWriteTime -and
$_.LastWriteTime -lt $lastTxnBackupFile.LastWriteTime} |
Sort -Property LastWriteTime)
{
Restore-SqlDatabase `
-ReplaceDatabase `
-ServerInstance $instanceName `
-Database $restoreddbname `
-BackupFile $txnBackup.FullName `
-NoRecovery
}
#restore last txn backup file to point in time
#restore only up to 2012-04-07 08:21:59
#this time we are going to restore using with recovery
Restore-SqlDatabase `
-ReplaceDatabase `
-ServerInstance $instanceName `
-Database $restoreddbname `
-BackupFile $lastTxnBackupFile.FullName `
-ToPointInTime "2012-04-07 08:21:59"




#---------------------------------------------------------------
# 21  800 Recovery-Only Database Restore  在不還原資料的情況下復原資料庫
#---------------------------------------------------------------
restore data 還原 vs recovery database 復原


RESTORE DATABASE AdventureWorks2012  WITH RECOVERY
RESTORE DATABASE Sales FILEGROUP=SalesGroup2 WITH RECOVERY


#---------------------------------------------------------------
# 22 How to read the SQL Server Database Transaction Log   sys.fn_dblog(NULL,NULL)
#---------------------------------------------------------------


在 TSQL 加上 BEGIN TRANSACTION  及  COMMIT TRANSACTION  可以用 WHERE [Transaction Name]='DELETE'  

找出  Transaction ID  可以得出此次  [Begin Time]  (Operation : LOP_BEGIN_XACT  ,  )    在找出  LOP_COMMIT_XACT    [End Time] 


BEGIN TRANSACTION SplitPage;
USE S1;
DELETE Location 
WHERE [Sr.No]>80
Go
COMMIT TRANSACTION SplitPage;
GO

SELECT 
 [Current LSN],
 [Transaction ID],[Operation],[Transaction Name],[Begin Time],[End Time],[CONTEXT],[AllocUnitName],[Page ID],[Slot ID],
 [Number of Locks],
 [Lock Information]
FROM sys.fn_dblog(NULL,NULL)
--WHERE [Transaction Name]='DELETE' 
--WHERE [Transaction ID]='0000:0000518e'
WHERE [Transaction ID]='0000:0000518b'
GO


select [Transaction ID] ,count([Transaction ID]) ,[Transaction Name],[Begin Time],[End Time]
from sys.fn_dblog(NULL,NULL) 
group by [Transaction Name],[Transaction ID],[Begin Time],[End Time]
order by [Transaction ID],[Transaction Name] desc



##

select [Current LSN],
       [Operation],
       [Transaction Name],
       [Transaction ID],
       [Transaction SID],
       [SPID],
       [Begin Time]
FROM   fn_dblog(null,null)


use s1
truncate table [Location]

##
select getdate(),COUNT(*) from fn_dblog(null,null)  -- 492
backup database s1 to disk='c:\temp\x1.bak'
backup log s1 to disk='c:\temp\x1.trn'
select getdate(),COUNT(*) from fn_dblog(null,null)  -- 20

##
select getdate(),COUNT(*) from fn_dblog(null,null)  -- 20
WAITFOR DELAY  '0:0:5'
go  3


select [Transaction ID] ,count([Transaction ID]) 
from sys.fn_dblog(NULL,NULL) 
group by [Transaction ID]


DBCC Log(s1)

--
SELECT
 [Current LSN],[Operation],[Begin Time],[End Time],[Transaction ID],[Transaction Name],[CONTEXT],[AllocUnitName],[Page ID],[Slot ID],
 [Number of Locks],[Lock Information]
FROM sys.fn_dblog(NULL,NULL)
WHERE Operation IN --('LOP_DELETE_ROWS')
   ('LOP_INSERT_ROWS','LOP_MODIFY_ROW',
    'LOP_DELETE_ROWS','LOP_BEGIN_XACT','LOP_COMMIT_XACT')  


CREATE TABLE [Location] (
    [Sr.No] INT IDENTITY,
    [Date] DATETIME DEFAULT GETDATE (),
    [City] CHAR (25) DEFAULT 'Bangalore');

	INSERT INTO Location DEFAULT VALUES ;
GO 100

select * from [Location]

UPDATE Location
SET City='New Delhi'
WHERE [Sr.No]<5
GO
DELETE Location 
WHERE [Sr.No]>90
Go



SELECT
 [Current LSN],[Operation],[Begin Time],[End Time],[Transaction ID],[Transaction Name],[CONTEXT],[AllocUnitName],[Page ID],[Slot ID],
 [Number of Locks],[Lock Information]
FROM sys.fn_dblog(NULL,NULL)
WHERE Operation IN --('LOP_DELETE_ROWS')
   ('LOP_INSERT_ROWS','LOP_MODIFY_ROW',
    'LOP_DELETE_ROWS','LOP_BEGIN_XACT','LOP_COMMIT_XACT')  



##
SET NOCOUNT ON
DECLARE @LSN NVARCHAR(46)
DECLARE @LSN_HEX NVARCHAR(25)
DECLARE @trx_id NVARCHAR(28) = '0000:00005197'
DECLARE @tbl TABLE (id INT identity(1,1), i VARCHAR(10))
DECLARE @stmt VARCHAR(256)
SET @LSN = (SELECT TOP 1 [Current LSN] FROM fn_dblog(NULL, NULL) WHERE [Transaction ID] = @trx_id)
SET @stmt = 'SELECT CAST(0x' + SUBSTRING(@LSN, 1, 8) + ' AS INT)'
Print @LSN
Print @stmt
INSERT @tbl EXEC(@stmt)
SET @stmt = 'SELECT CAST(0x' + SUBSTRING(@LSN, 10, 8) + ' AS INT)'
INSERT @tbl EXEC(@stmt)
SET @stmt = 'SELECT CAST(0x' + SUBSTRING(@LSN, 19, 4) + ' AS INT)'
INSERT @tbl EXEC(@stmt)
SET @LSN_HEX =
 (SELECT i FROM @tbl WHERE id = 1) + ':' + (SELECT i FROM @tbl WHERE id = 2) + ':' + (SELECT i FROM @tbl WHERE id = 3)
 print @LSN_HEX 
SELECT [Current LSN], [Operation], [Context], [Transaction ID], [AllocUnitName], [Page ID]
, [Transaction Name], [Parent Transaction ID], [Description] 
FROM fn_dblog(@LSN_HEX, NULL)

select * FROM fn_dblog('131:273:4',null)


#---------------------------------------------------------------
# 23  929  LSN 
#---------------------------------------------------------------
#{<#
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


##-----------TEST DATA

if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }


$tsql_createT6=@"

if exists (select  * from sys.objects where object_id=object_id(N'T6'))
Drop table T6
GO

CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [PRIMARY]
GO

"@ #create table T6

Invoke-Sqlcmd  -Query  $tsql_createT6  -Database MingDB -QueryTimeout  1200   -ServerInstance sp2013

function backupFBdatabase ([string] $instance, [string] $dbname,[string]$bakpath){ 
# backupFBdatabase sp2013 mingdb  \\SP2013\temp
#$backuppath='\\SP2013\temp'
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bak' ;#$bakFile

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' 
"@  
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance $instance 

get-item $bakFile
}#function backupFBdatabase

function backupDiffdatabase ([string] $dbname,[string]$bakpath){
#$backuppath='\\SP2013\temp'
# backupDiffdatabase mingdb \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.dif' ;#$bakFile
#$trnFile=$backuppath+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.trn'

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' WITH DIFFERENTIAL
"@  
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance sp2013 

get-item $bakFile
}#function backupDiffdatabase

function backupLog ([string] $dbname,[string]$bakpath){
#$backuppath='\\SP2013\temp'
# backupLog mingdb \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.trn' ;#$bakFile
#$trnFile=$backuppath+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.trn'

$tsql_backuplog=@"
   BACKUP Log $dbname TO  DISK = N'$bakFile'
"@  
Invoke-Sqlcmd  -Query  $tsql_backuplog  -QueryTimeout  2400  -ServerInstance sp2013 
}#function backupLog


function  brprogress ([string] $instance){
# brprogress sql2012x
$tsql_select123=@"


    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT r.percent_complete
, DATEDIFF(MINUTE, start_time, GETDATE()) AS Age
, DATEADD(MINUTE, DATEDIFF(MINUTE, start_time, GETDATE()) /
percent_complete * 100, start_time) AS EstimatedEndTime
, t.Text AS ParentQuery
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS IndividualQuery
, start_time
, DB_NAME(Database_Id) AS DatabaseName
, Status
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
WHERE session_id > 50
AND percent_complete > 0
ORDER BY percent_complete DESC
"@
Invoke-Sqlcmd  -Query  $tsql_select123  -QueryTimeout  2400  -ServerInstance $instance
}#function  brprogress
brprogress sql2012x


function GetbakFile ($bakpath, $dbname, $whatday,$type){ #p1089 function
#$bakpath= '\\SP2013\temp\' 
#$dbname  = 'mingdb'
#$whatday='2015-05-03  18:05:00'  
#$type   ='Getone'
# GetbakFile \\SP2013\temp\  mingdb  '2015-05-03  18:05:00'  Getone
$t=([datetime]$whatday);$t
#$t=([datetime]'2015-05-03  10:56:05')
$bpath=$bakpath+$dbname +'*.bak';#$bpath
cd c:
if ($type -eq 'sort')
{
 # '1'   
   $bakf=gi $bpath | ? LastWriteTime -LT  $t |sort  LastWriteTime -desc
   $bakf
}
else
{

if ($type -eq 'Getone'){#1104
    #'2'
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddDays(-1)
    $bakf |sort LastWriteTime -Descending
    #'3'
}#1104
}
    
}#p1089 function

#-- sort all backupFile
$rs=GetbakFile  \\SP2013\temp\  mingdb  2015-05-06  sort 
$rs  |select name,CreationTime,lastwritetime  |ft -auto
$rs  |select name,CreationTime,lastwritetime -last 1 |ft -auto

#--getone
$r=GetbakFile \\SP2013\temp\   mingdb  '2015-05-05  10:00:00'  Getone    ;$r |select name, creationTime,lastwriteTime
 
function GetBDLFile ($bakpath, $dbname, $whatday ,$hourrange ){ #  1168 function
#$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto
#GetBDLFile  \\SP2013\temp\ mingdb '2015-05-05  10:10:00' -48
#$bakpath= '\\SP2013\temp\'
#$dbname  = 'mingdb'
#$whatday='2015-05-05  10:10:00'
#$hourrange =-48

$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.*';#$bpath
cd c:
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddHours($hourrange)
    $bakf |Select name ,creationTime,LastWriteTime,length |sort LastWriteTime -Descending
}# 1168 function GetbdlFile 

function GetdifFile ($bakpath, $dbname, $whatday,$type){ #p1089 function
#$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto

$bakpath= '\\SP2013\temp\'
$dbname  = 'mingdb'
#$whatday='2015-05-04  22:05:00'
$whatday='5/4/2015 1:20:02 AM'
$type   ='Getone'
#GetdifFile \\SP2013\temp\   mingdb  '2015-05-05  10:10:00'  Getone 
$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.dif';#$bpath
cd c:
if ($type -eq 'sort')
{
 # '1'   
   $bakf=gi $bpath | ? LastWriteTime -LE  $t |sort  LastWriteTime -desc
   $bakf
}
else
{

if ($type -eq 'Getone'){#1104
    #'2'
    $bakf= gi $bpath | ? LastWriteTime -lt  $t.AddSeconds(1) |? LastWriteTime -gt   $t.AddDays(-1)
    $bakf |sort LastWriteTime -Descending
    if ($bakf.count -eq 0)
    {
      $t.AddDays(-1).TOSTRING() + '~'  + $t.TOSTRING()   + '   No datA'
    }
    #'3'
}#1104
}
    
}# function GetdifFile

function insertT6 ([string]$dbname,$countx){
    #$dbname='mingdb'
    #$countx=50;'6--'+$countx
    $tsql_insertT6=@"
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <= $countx
begin
  select @val=cast((RAND()*1000) as int) ;-- print @val
  select @rstring=NEWID(); --print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:01'  
end
"@
Invoke-Sqlcmd  -Query  $tsql_insertT6  -Database $dbname -QueryTimeout  1800   -ServerInstance sp2013
}#insertT6
insertT6 mingdb 7

function restoreFBdatabase ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_00-02-11.bak'
# restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname from  DISK = N'$bakFile' with REPLACE --,RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFBdatabase

restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak 

function restoreFBdatabaseNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_00-02-11.bak'
#restoreFBdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with REPLACE, NORECOVERY
"@  #$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreFBdatabaseNORECOVERY

function restoreDiffdatabase ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
 #$instance='sql2012x'
 #$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreDiffdatabase

function restoreDiffdatabaseNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreDiffdatabaseNORECOVERY

function restoreLOG ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore log $dbname from  DISK = N'$bakFile' with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance
}#function restoreLOG

function restoreLOGNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore log $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance
}#function restoreLOGNORECOVERY

function selectbackupset ([string] $dbname){
#$dbname='mingdb'
$tsql_selectbackupset=@"
SELECT
DATABASE_NAME as 'name',
type,
--RECOVERY_MODEL as '還原模式',
DATABASE_BACKUP_LSN  as 'DBL',
FIRST_LSN  as 'FLSN',
LAST_LSN as 'LSN',
DIFFERENTIAL_BASE_LSN as 'DiffLSN',
backup_start_date as 'BST', 
backup_finish_date as 'BET',
DATEDIFF(second, backup_start_date,backup_finish_date) as DurationSecond,
DATEDIFF(mi, backup_start_date,backup_finish_date) as Durationminute,
backup_size *0.000000001 as GB
FROM msdb.dbo.backupset 
WHERE DATABASE_NAME= '$dbname'
order by backup_finish_date desc 
"@  
$u=Invoke-Sqlcmd  -Query  $tsql_selectbackupset  -QueryTimeout  2400  -ServerInstance sp2013 

$u |ft -auto
}#function selectbackupset

function seledctT6 ([string] $dbname) {
  $tsql_selectT6=@"
  select createdate,* from dbo.t6 
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname -QueryTimeout  1800   -ServerInstance sp2013 
$y|ft -AutoSize
$y.count
}# selectT6
seledctT6 mingdb

function selectT6modtime ([string] $instance,[string] $dbname){
  $tsql_selectT6=@"
  select top 5 createdate,iid,rid,val,rstring from dbo.t6 order by createDate desc ,iid  desc
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname   -ServerInstance  $instance
$y|ft -AutoSize
$tsql_selectT6c=@"
  select count(rid)as cc from dbo.t6 
"@  
$m=Invoke-Sqlcmd  -Query  $tsql_selectT6c  -Database $dbname   -ServerInstance  $instance
$m.cc
}#function seledctT6modtime

function truncateT6 ([string] $dbname){
  $tsql_selectT6=@"
  truncate table  [dbo].[T6]
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname    -ServerInstance sp2013 
$y
}#function truncateT6


#=================

$dbt='mingdb'
truncateT6 $dbt ;seledctT6 $dbt
seledctT6 $dbt

$t1=get-date
insertT6 mingdb 500000
$t2=get-date
$t2-$t1

# 
$t1=get-date
backupFBdatabase $dbt \\SP2013\temp
$t2=get-date
$t2-$t1

backupDiffdatabase mingdb \\SP2013\temp

selectbackupset $dbt  ;  selectbackupset FGRestoreTEST  
;GetbdlFile  H:\SQLServer\backups\ FGRestoreTEST '2015-05-14  23:00:00' -240 |ft -auto

selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb



<#
  1,0000   >  0M  8sec
 10,0000   >  1M 15 Sec  ; 1m18s
 50,0000 500K  >  7m 26s
100,0000 1M  >  16M 29 sec
#>
#case1
backupFBdatabase $dbt \\SP2013\temp
$fullb=GetbakFile \\SP2013\temp\   mingdb  '2015-05-04  23:59:59'  Getone    ;$fullb |select name, creationTime,lastwriteTime -first 2
   $fullbf=$fullb |select name -last 1
restoreFBdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.bak
truncateT6 $dbt ;seledctT6 $dbt
insertT6 mingdb 100
   selectT6modtime sp2013 mingdb
   selectT6modtime sql2012x mingdb
backupDiffdatabase mingdb \\SP2013\temp
   selectbackupset $dbt   

$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-04  22:05:00'  Getone    ;#$d |select name, creationTime,lastwriteTime -last 1

$d=GetdifFile \\SP2013\temp\ mingdb '5/4/2015 10:20:02 PM'  Getone    ;$d |select name, creationTime,lastwriteTime -last 1

$diff=$d |select name -last 1; $diff
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ $fullbf.name
                                                            
restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\  $diff.name
   selectT6modtime sp2013 mingdb
   selectT6modtime sql2012x mingdb


<#-----case2-----#>

restoreFBdatabase sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-03_10-58-38.bak
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ $fullbf.name

<#-----case3-----#>

GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto #找出某天前24 所有備份記錄 (bak,dif,trn) ,copy LastWriteTime to GetbakFile

$fullb=GetbakFile \\SP2013\temp\   mingdb  '5/4/2015 12:04:50 AM'  Getone   # find GetbakFile 
   $fullbf=$fullb |select name  -First 2 ; $fullbf.name
$d=GetdifFile \\SP2013\temp\   mingdb  '5/4/2015 1:20:02 AM'  Getone ;$diff=$d |select name -last 1; $diff
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ $fullbf.name #進行bak復原
restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\  $diff.name #進行trn復原

selectT6modtime sp2013   mingdb
selectT6modtime sql2012x mingdb

<#-----case4-----#>
{<#
$dbt='mingdb'
$t1=get-date;$t1  ;truncateT6 $dbt ;seledctT6 $dbt
start-sleep 60
$t2=get-date;$t2  ;insertT6 mingdb 50
start-sleep 120
$t3=get-date;$t3
backupLog mingdb \\SP2013\temp
start-sleep 600
$t4=get-date;$t4
truncateT6 $dbt ;seledctT6 $dbt
start-sleep 120
$t5=get-date;$t5
insertT6 mingdb 100
   seledctT6modtime sp2013 mingdb
   seledctT6modtime sql2012x mingdb 

start-sleep 300
$t6=get-date ;'T6'+$t6.tostring() ;backupLog mingdb \\SP2013\temp

start-sleep 300
$t7=get-date ;'T7'+$t7.tostring() ;truncateT6 $dbt ;seledctT6 $dbt
start-sleep 30

$t8=get-date;'T8'+$t8.tostring()
insertT6 mingdb 300
   seledctT6modtime sp2013 mingdb
   seledctT6modtime sql2012x mingdb 

start-sleep 300
$t9=get-date;'T9'+$t9.tostring()
backupDiffdatabase mingdb \\SP2013\temp

start-sleep 300
$t10=get-date;'T10'+$t10.tostring()
truncateT6 $dbt ;seledctT6 $dbt
start-sleep 30
$t11=get-date;'T11'+$t11.tostring()
insertT6 mingdb 200
   seledctT6modtime sp2013 mingdb
   seledctT6modtime sql2012x mingdb 
start-sleep 300
$t12=get-date;'T12'+$t12.tostring()
backupLog mingdb \\SP2013\temp


#restore  to 300
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-06  12:10:00' -240
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-04_00-02-11.bak #進行bak復原NORECOVERY
restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-06_11-05-55.dif        #進行dif復原RECOVERY
#restore  to 200
restoreFBdatabaseNORECOVERY   sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak #進行bak復原 NORECOVERY
$t2=get-date
restoreDiffdatabaseNORECOVERY sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-06_11-05-55.dif #進行dif復原 NORECOVERY
$t3=get-date;#t3-t2=32sec
restoreLOG   sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-06_11-16-26.trn  #進行trn復原 RECOVERY
$t4=get-date ;
#
$t2=get-date
restoreFBdatabase  sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$t3=get-date #1m 35Sec

selectbackupset $dbt   
#>}
<#-----case5-----#>
{<#
 當在備份期間內.如有大量的交易寫入,觀察是否

 原有500000,( mingdb_2015-05-04_00-02-11.bak)

step1: backupFBdatabase $dbt \\SP2013\temp 
step2:
DELETE FROM [dbo].[T6]
再新增 200000
step3:backupLog mingdb \\SP2013\temp
selectbackupset $dbt  

(1).T6.createdate  first , last   2015-05-06 14:27:00   ~ 2015-05-06 14:31:00
                   bak            5/6/2015    2:26:47 PM     5/6/2015 2:30:01 PM #194sec
                   trn            5/6/2015 2:49:07 PM  5/6/2015 2:49:27 PM   #20sec
(2). 將 bak restore to sql2012x
  GetbdlFile  \\SP2013\temp\ mingdb '2015-05-08  23:00:00' -240

  restoreFBdatabase  sql2012x  mingdb  \\SP2013\temp\ mingdb_2015-05-06_14-26-47.bak  # 2m22sec
(3)    
   GetbdlFile  \\SP2013\temp\ mingdb '2015-05-06  15:00:00' -24
 
 $t1=get-date
 restoreFBdatabaseNORECOVERY   sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-06_14-26-47.bak #進行bak復原 NORECOVERY  2m10sec
 $t2=get-date
 ($t2-$t1)

 $t3=get-date
 restoreLOG   sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-06_14-49-07.trn  #進行trn復原 RECOVERY   # 23sec
 $t4=get-date
 ($t4-$t3)


 (4)  

(99)
selectT6modtime sp2013   mingdb  
selectT6modtime sql2012x mingdb
selectbackupset $dbt  
#>}
#case6

##-----------TEST DATA end

#>}
$bak_d_1=189000022744500112
$bak_f_2=189000022782500001
$bak_l_4=190000007167100001

$trn_F_2=189000022782500001

$trn_D_3=190000007161300068
$trn_L_5=190000007184900001

$trn_L_5-$bak_l_4
$bak_l_4-$trn_D_3
$trn_D_3-$trn_F_2
$bak_f_2-$bak_d_1

$trn_L_5-$bak_l_4
$trn_L_5-$bak_l_4
















#---------------------------------------------------------------
# 24  2166  Recovery Paths 復原路徑
#---------------------------------------------------------------
# https://technet.microsoft.com/zh-tw/library/ms187486(v=sql.105).aspx

# 檢視備份與還原使用的 LSN

  RESTORE FILELISTONLY   FROM DISK = N'\\SP2013\temp\mingdb_FG1_2015-05-11_11-21-15.baf'


#---------------------------------------------------------------
# 25  2166   2200  Piecemeal Restore of Databases  分次還原
#---------------------------------------------------------------
#*****************************************************************
#  example [MyBigOrderDb]
#*****************************************************************
{<# MAY.13.2015 

<#   0  ---  
    考量能夠快速上線(當總有一天DB 移機, 雖有HA 也一樣會面臨)
	• Empty Primary FG. Primary Filegroup should be online in order for database to be online. It is good idea to keep primary filegroup empty and do not place any objects there.
	• Entities FG. This filegroup could store catalog tables, such as Customers, Articles and others.
	• One or more filegroups for the operational data. For example, if operational period is the current year, this filegroup can store Orders, OrderLineItems and related entities that stores current-year data.
	• One or more filegroups for the historical data. Those filegroups store data that is not required to support operational activity in the system.

create database [MyBigOrderDb]on primary(name = N'MyBigOrderDb', filename = N'c:\db\MyBigOrderDb.mdf'), filegroup [Entities] (name = N'MyBigOrderDB_Entities', filename = N'c:\db\MyBigOrderDB_Entities.ndf'), filegroup [FG2013] (name = N'MyBigOrderDB_FG2013', filename = N'c:\db\MyBigOrderDB_FG2013.ndf'), filegroup [FG2014] (name = N'MyBigOrderDB_FG2014', filename = N'c:\db\MyBigOrderDB_FG2014.ndf')log on(name = N'MyBigOrderDb_log', filename = N'c:\db\MyBigOrderDb_log.ldf')
create table dbo.Customers(    CustomerId int not null,    CustomerName nvarchar(64) not null,)on [Entities];
create table dbo.Articless( ArticlesId int not null, ArticleName nvarchar(64) not null,)on [Entities];
create partition function pfOrders(smalldatetime)as range rightfor values('2014-01-01');
create partition scheme psOrdersas partition pfOrdersto (FG2013,FG2014)go

create table dbo.Orders(    OrderId int not null,    OrderDate smalldatetime not null,    OrderNum varchar(32) not null,    constraint PK_Orders    primary key clustered(OrderDate, OrderId)    on psOrders(OrderDate))go
insert into dbo.Customers(CustomerId, CustomerName) values(1,'Customer 1');insert into dbo.Orders(OrderDate, OrderId, OrderNum)values    ('2013-01-01',1,'Order 1'),    ('2013-02-02',2,'Order 2'),    ('2014-01-01',3,'Order 3'),    ('2014-02-02',4,'Order 4')

#>}
<#   1  Full backup  --


backup database [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_Full.bak' with noformat, init, name = N'MyBigOrderDb-Full Database Backup',     compression, stats = 2
-- Differential backupbackup database [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_Diff.bak' with differential, noformat, init,     name = N'MyBigOrderDb-Differential Database Backup',     compression, stats = 2
-- Transaction logbackup log [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_Log.trn' with noformat, init, name = N'MyBigOrderDb-Tran Log',     compression, stats = 2

backup log [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_TailLog.trn' with no_truncate, noformat, init, name = N'MyBigOrderDb-Tail Log',  compression, norecovery, stats = 2






 #>
<#   2  
 Restoring on another server -- 

-- 2   Restoring on another server   on sql2012x -- 
restore database [MyBigOrderDb]   FILEGROUP = 'primary', FILEGROUP = 'Entities', FILEGROUP = 'FG2014'from disk = N'C:\DB\MyBigOrderDb_Full.bak' with file = 1,move N'MyBigOrderDB' to N'c:\db\MyBigOrderDb.mdf', move N'MyBigOrderDB_Entities' to N'c:\db\MyBigOrderDb_Entities.ndf', move N'MyBigOrderDB_FG2014' to N'c:\db\MyBigOrderDb_2014.ndf', move N'MyBigOrderDb_log' to N'c:\db\MyBigOrderDb.ldf', NORECOVERY, partial, stats = 2;RESTORE FILELISTONLY  FROM Disk ='C:\DB\MyBigOrderDb_Full.bak'-- Diff Backuprestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Diff.bak' with file = 1,NORECOVERY, stats = 2;
-- Tran Logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Log.trn' with file = 1,NORECOVERY, stats = 2;
-- Tail-logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_TailLog.trn' with file = 1,NORECOVERY, stats = 2;
-- Recoveryrestore database [MyBigOrderDb] with RECOVERY;


use MyBigOrderDb
select * from dbo.Customers
select * from dbo.Articless
select * from dbo.Orders
select * from MyBigOrderDb.dbo.Customersselect * from MyBigOrderDb.dbo.Orders where OrderDate >= '2014-01-01'

#>
<#   3   --
-- Full Backup (restoring individual filegroup)restore database [MyBigOrderDb] FILEGROUP = 'FG2013'from disk = N'C:\DB\MyBigOrderDb_Full.bak' with file = 1,move N'MyBigOrderDB_FG2013' to N'c:\db\MyBigOrderDb_2013.ndf',  stats = 2;

-- Diff Backuprestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Diff.bak' with file = 1,stats = 2;

-- Tran Logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Log.trn' with file = 1,stats = 2;

-- Tail-logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_TailLog.trn' with file = 1,stats = 2;



 #>
 
#---------------------------------------------------------------
# 26  2353    Logspace  DBSizeInfo   
#---------------------------------------------------------------
利用排程.可以記錄mdf ,ldf  logspace 的大小.

$dbS     = Invoke-Sqlcmd -query "exec  dbsizeinfo" -ServerInstance  sp2013   -Database forMirrorTest
$csvpath = 'c:\temp3\dbsizeinfo.csv'
$dbS[7] |Export-Csv -path $csvpath -Append  -NoTypeInformation -Encoding UTF8
ii $csvpath




USE [master]
GO
/****** Object:  StoredProcedure [dbo].[dbsizeinfo]    Script Date: 2016/6/13 下午 01:17:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF OBJECT_ID('tempdb.dbo.#space') IS NOT NULL

    DROP TABLE #space

CREATE TABLE #space (

      database_id INT PRIMARY KEY

    , data_used_size DECIMAL(18,2)

    , log_used_size DECIMAL(18,2)

)



DECLARE @SQL NVARCHAR(MAX)




SELECT @SQL = STUFF((

    SELECT '

    USE [' + d.name + ']

    INSERT INTO #space (database_id, data_used_size, log_used_size)

    SELECT

          DB_ID()

        , SUM(CASE WHEN [type] = 0 THEN space_used END)

        , SUM(CASE WHEN [type] = 1 THEN space_used END)

    FROM (

        SELECT s.[type], space_used = SUM(FILEPROPERTY(s.name, ''SpaceUsed'') * 8. / 1024)

        FROM sys.database_files s

        GROUP BY s.[type]

    ) t;'

    FROM sys.databases d

    WHERE d.[state] = 0

    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '')




EXEC sys.sp_executesql @SQL




--select * from #space

SELECT

      d.database_id    as databaseid

    , d.name           as dname

    , d.state_desc     as dstatedesc

    , d.recovery_model_desc as drecoverymodeldesc

    , t.total_size     as ttotalsize

    , t.data_size      as tdatasize

    , s.data_used_size as sdatausedsize

    , t.log_size       as tlogsize

    , s.log_used_size  as slogusedsize

    , bu.full_last_date  as bufulllastdate

    , bu.full_size     as bufullsize

    , bu.log_last_date as buloglastdate

    , bu.log_size      as bulogsize

FROM (

    SELECT

          database_id

        , log_size   = CAST(SUM(CASE WHEN [type] = 1 THEN size END) * 8. / 1024 AS DECIMAL(18,2))

        , data_size  = CAST(SUM(CASE WHEN [type] = 0 THEN size END) * 8. / 1024 AS DECIMAL(18,2))

        , total_size = CAST(SUM(size) * 8. / 1024 AS DECIMAL(18,2))

    FROM sys.master_files

    GROUP BY database_id

) t

JOIN sys.databases d ON d.database_id = t.database_id

LEFT JOIN #space s   ON d.database_id = s.database_id

LEFT JOIN (

    SELECT

          database_name

        , full_last_date = MAX(CASE WHEN [type] = 'D' THEN backup_finish_date END)

        , full_size = MAX(CASE WHEN [type] = 'D' THEN backup_size END)

        , log_last_date = MAX(CASE WHEN [type] = 'L' THEN backup_finish_date END)

        , log_size = MAX(CASE WHEN [type] = 'L' THEN backup_size END)

    FROM (

        SELECT

              s.database_name

            , s.[type]

            , s.backup_finish_date

            , backup_size =

                        CAST(CASE WHEN s.backup_size = s.compressed_backup_size

                                    THEN s.backup_size

                                    ELSE s.compressed_backup_size

                        END / 1048576.0 AS DECIMAL(18,2))

            , RowNum = ROW_NUMBER() OVER (PARTITION BY s.database_name, s.[type] ORDER BY s.backup_finish_date DESC)

        FROM msdb.dbo.backupset s

        WHERE s.[type] IN ('D', 'L')

    ) f

    WHERE f.RowNum = 1

    GROUP BY f.database_name

) bu ON d.name = bu.database_name

ORDER BY t.total_size DESC




#*****************************************************************
#  example[FGRestoreTEST]
#*****************************************************************
{<#/*  1  */drop database [FGRestoreTEST]CREATE DATABASE [FGRestoreTEST]
 ON  PRIMARY 
( NAME = N'FGRestoreTEST', FILENAME = N'h:\SQLServer\Data\FGRestoreTEST.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2010] 
( NAME = N'FG2010', FILENAME = N'h:\SQLServer\Data\FG2010.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2011] 
( NAME = N'FG2011', FILENAME = N'h:\SQLServer\Data\FG2011.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2012] 
( NAME = N'FG2012', FILENAME = N'h:\SQLServer\Data\FG2012.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2013] 
( NAME = N'FG2013', FILENAME = N'h:\SQLServer\Data\FG2013.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2014] 
( NAME = N'FG2014', FILENAME = N'h:\SQLServer\Data\FG2014.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FGRestoreTEST_log', FILENAME = N'h:\SQLServer\Logs\FGRestoreTEST_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GOUSE [FGRestoreTEST];
GO

CREATE TABLE [PRIMARY_TABLE]
(ID INT,
 NAME CHAR(4)) ON [PRIMARY];

CREATE TABLE [FG2010_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2010];

 CREATE TABLE [FG2011_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2011];

CREATE TABLE [FG2012_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2012];

CREATE TABLE [FG2013_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2013];

CREATE TABLE [FG2014_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2014];
 GO/*  2  */INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2010_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2011_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2012_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2013_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2014_TABLE]
SELECT 1, 'TEST'
GO 100/*  3  */USE [master];
GO
BACKUP DATABASE [FGRestoreTEST]
TO DISK = N'H:\SQLServer\Backups\FGRestoreTEST2.BAK';
GO/*  4   */BACKUP LOG [FGRestoreTEST]TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup.trn'WITH NORECOVERY

/*  5  */--http://msdn.microsoft.com/en-us/library/ms189906.aspx
BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY2.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2010'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20102.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2011'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20112.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2012'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20122.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2013'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_G20132.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2014'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak';
GO/*   6   */RESTORE DATABASE [FGRestoreTEST]   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST.bak'   WITH NORECOVERY;RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'PRIMARY'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY.bak'   WITH NORECOVERY;RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG2014.bak'   WITH NORECOVERY;
RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'PRIMARY'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF.bak'   WITH NORECOVERY;
/*   7  */

USE [FGRestoreTEST];
GO

INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
go 100

TRUNCATE TABLE [FG2014_TABLE];
GO

[PRIMARY_TABLE] 200 , 
[FG2014_TABLE] null
/*  8  */
BACKUP DATABASE [FGRestoreTest]
   FILEGROUP = 'PRIMARY'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF2.bak'
   WITH DIFFERENTIAL;

BACKUP DATABASE [FGRestoreTest]
   FILEGROUP = 'FG2014'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   WITH DIFFERENTIAL;
GO


/*  9  */
USE [FGRestoreTEST];
GO

INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
go 100

INSERT INTO [FG2014_TABLE]
SELECT 1, 'NEW'
go 300

/*  10  */
USE [master];
go

BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn';
go
/*  11  */
BACKUP LOG [FGRestoreTEST_Dev]
TO DISK = 'C:\SQLServer\Backups\FGRestoreTest_TailLogBackup.trn'
WITH NORECOVERY;
GO
/*  12  */

BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup2.trn'
WITH NORECOVERY;
GO
/*  13.1  */

select count(*) from  FGRestoreTEST.dbo.PRIMARY_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2011_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2012_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2013_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2014_TABLEselect top (1) * from FGRestoreTEST.dbo.FG2014_TABLE

RESTORE DATABASE [FGRestoreTEST]
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST2.BAK'
   WITH replace , RECOVERY;

/*  13.2 */
BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup2.trn'
WITH NORECOVERY;

RESTORE DATABASE [FGRestoreTEST]
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST2.BAK'
   WITH  NORECOVERY;



RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY2.bak'
   WITH NORECOVERY;
--Restore FG2014 differential backupRESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak '   WITH NORECOVERY;
 --Restore PRIMARY differential backup
RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF2.bak'
   WITH NORECOVERY;

--Restore FG2014 differential backup
RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2014'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   WITH NORECOVERY;

RESTORE LOG [FGRestoreTEST]FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn'WITH NORECOVERY;
RESTORE DATABASE [FGRestoreTest] WITH RECOVERY;

/*  13.3  */
BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup2.trn'
WITH NORECOVERY;

select count(*) from  FGRestoreTEST.dbo.PRIMARY_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2011_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2012_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2013_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2014_TABLEselect top (1) * from FGRestoreTEST.dbo.FG2014_TABLE

RESTORE DATABASE [FGRestoreTEST]
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST2.BAK'
   WITH  NORECOVERY;



RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY2.bak'
   WITH NORECOVERY;
--Restore FG2014 differential backupRESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak '   WITH NORECOVERY;
 --Restore PRIMARY differential backup
RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF2.bak'
   WITH RECOVERY;

--Restore FG2014 differential backup
--RESTORE DATABASE [FGRestoreTEST]
   --FILEGROUP = 'FG2014'
   --FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   --WITH RECOVERY;

RESTORE LOG [FGRestoreTEST]FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn'WITH RECOVERY;
RESTORE DATABASE [FGRestoreTest] WITH RECOVERY;

/*  13.4  */
USE [FGRestoreTEST];
GO
TRUNCATE TABLE [FG2014_TABLE];

use master

RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak '   WITH NORECOVERY;


RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2014'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   WITH RECOVERY;


RESTORE LOG [FGRestoreTEST]FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn'WITH RECOVERY;

RESTORE DATABASE [FGRestoreTest]     FILEGROUP = 'FG2014' WITH RECOVERY;

/*  15  */
--Then the transaction log backup:-
select count(*) from  FGRestoreTEST.dbo.PRIMARY_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2011_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2012_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2013_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2014_TABLEselect top (1) * from FGRestoreTEST.dbo.FG2014_TABLEuse FGRestoreTESTselect * from sys.master_filesThe file or filegroup "FG2014" is not in a valid state for the "Recover Data Only" option to be used.
 Only secondary files in the OFFLINE or RECOVERY_PENDING state can be processed.
Msg 3013, Level 16, State 1, Line 1

#>}


--*****************************************************************
--12-1-1∣覆寫或格式化媒體集
--*****************************************************************

--檢視備份檔 AdventureWorks.bak 的內容

RESTORE Headeronly From Disk='D:\DBBackup\AdventureWorks.bak'



-----------------------------------------------------------------
--Step01.使用 NOINIT 選項將備份 "附加" 到檔案媒體中

BACKUP DATABASE Northwind TO DISK='D:\DBBackup\AdventureWorks.bak'
WITH NAME=N'AdventureWorks-完整資料庫備份', NOINIT


--Step02.檢視備份檔附加後的內容
RESTORE HEADERONLY FROM DISK='D:\DBBackup\AdventureWorks.Bak'


--Step03.使用 FILE 選項指定要復原的"備份組"
RESTORE DATABASE Northwind FROM DISK='D:\DBBackup\AdventureWorks.Bak'
WITH FILE=2

--Step04.使用 INIT 選項備份 AdventureWorks 資料庫備份至相同路徑，
--再使用 Step02 的 RESTORE HEADERONLY 指令檢視備份結果

BACKUP DATABASE Northwind TO DISK='D:\DBBackup\AdventureWorks.Bak'
WITH INIT



#-----------------------------------------------------------------
#--下列語法備份的檔案會保留2 日，若未達兩日以上而強制覆蓋會發生備份失敗
BACKUP DATABASE AdventureWorks TO DISK='D:\DBBackup\Northwind.Bak'
WITH RETAINDAYS = 2

--使用下列語法強制覆蓋上一個步驟所產生的備份檔會發生錯誤訊息
BACKUP DATABASE AdventureWorks TO DISK='D:\DBBackup\AdventureWorks.Bak'
WITH RETAINDAYS = 2,INIT


#--*****************************************************************
#--12-1-2∣媒體家族
#--*****************************************************************

--將 D:\DBBackup 資料夾內的 AdventureWorks.Bak 備份檔刪除後，使用下列語法測試備份結果
--Step01.簡單備份
BACKUP DATABASE AdventureWorks
TO DISK=N'D:\DBBackup\AdventureWorks.Bak'
WITH INIT

#-------------------------------------------
#--Step02.將備分資料同時寫入兩個不同的裝置
BACKUP DATABASE AdventureWorks
TO DISK=N'D:\DBBackup\AWorks1.Bak',
DISK=N'\\Backup\AWorksWorks2.Bak'
WITH FORMAT

--檢視備本結果
RESTORE LABELONLY FROM DISK=N'D:\DBBackup\AWorks1.Bak'
RESTORE LABELONLY FROM DISK= N'\\Backup\AWorksWorks2.Bak'


#--*****************************************************************
#--12-1-3∣鏡像備份媒體集
#--*****************************************************************

--將 D:\DBBackup 資料夾內的 AdventureWorks.Bak 備份檔刪除後，使用下列語法測試備份結果
--將 AdventureWorks 資料庫備份至兩個不同的目的地
BACKUP DATABASE AdventureWorks
TO DISK=N'D:\DBBackup\AdventureWorks.Bak'
MIRROR TO DISK=N'\\DBBackup\AdventureWorks.Bak'
WITH FORMAT


--還原僅需一份備份即可
RESTORE DATABASE AdventureWorks FROM DISK=N'\\DBBackup\AdventureWorks.Bak'
WITH REPLACE




#--*****************************************************************
#--12-1-4∣僅限複製備份
#--*****************************************************************


/*------------------------------------------------------------------
      範例程式碼12-1：
      臨時取走的完整備份會破壞完整備份與差異備份間的接續關係 
------------------------------------------------------------------*/

BACKUP DATABASE AdventureWorks TO DISK=N'D:\DBBackup\AdventureWorks.Bak'
WITH INIT
GO

--稍做一點變更
UPDATE AdventureWorks.Purchasing.PurchaseOrderDetail SET ReceivedQty=ReceivedQty+1
WHERE PurchaseOrderID=1 AND PurchaseOrderDetailID=1
GO
--臨時要取一個完整備份
BACKUP DATABASE AdventureWorks TO DISK=N'D:\DBBackup\AdventureWorksAdHoc.Bak'
WITH INIT
GO
--原有的時間順序所做的差異式備份
BACKUP DATABASE AdventureWorks TO DISK=N'D:\DBBackup\AdventureWorksDiff.Bak'
WITH INIT,DIFFERENTIAL
GO
--無法從原有的備份順序還原
RESTORE DATABASE AdventureWorks FROM DISK=N'D:\DBBackup\AdventureWorks.Bak'
WITH REPLACE,NORECOVERY
GO
--Diff 所記載和最後一次完整備份間的差異變成是與ad-hoc 那次完整備份的差異
--會有錯誤發生

RESTORE DATABASE AdventureWorks FROM DISK=N'D:\DBBackup\AdventureWorksDiff.Bak'
WITH RECOVERY

#/*------------------------------------------------------------------
#      範例程式碼12-2：
#      臨時取走的交易紀錄備份會破壞交易紀錄備份間的接續關係
#------------------------------------------------------------------*/


BACKUP DATABASE AdventureWorks TO DISK='D:\DBBackup\AdventureWorks.bak'
WITH INIT
--稍做更新

UPDATE AdventureWorks.Purchasing.PurchaseOrderDetail SET ReceivedQty=ReceivedQty+1
WHERE PurchaseOrderID=1 AND PurchaseOrderDetailID=1
--臨時備一份交易紀錄，可以搭配先前做的完整備份，取走後，毀了原來交易記錄的順序

BACKUP LOG AdventureWorks TO DISK='D:\DBBackup\AdventureWorksAdHocLog.bak'

BACKUP LOG AdventureWorks TO DISK='D:\DBBackup\AdventureWorksLog.bak'
WITH INIT

RESTORE DATABASE AdventureWorks FROM DISK='D:\DBBackup\AdventureWorks.bak'
WITH NORECOVERY,REPLACE

RESTORE LOG AdventureWorks FROM DISK='D:\DBBackup\AdventureWorksLog.bak'
WITH RECOVERY


#--*****************************************************************
#--12-1-5∣備份密碼與備份組密碼
#--*****************************************************************

--設定備份密碼
BACKUP DATABASE AdventureWorks TO DISK=N'D:\DBBackup\AdventureWorks.Bak'
WITH INIT,PASSWORD='password'

--需搭配密碼的還原
RESTORE DATABASE AdventureWorks
FROM DISK=N'D:\DBBackup\AdventureWorks.Bak'
WITH PASSWORD='password',REPLACE



--使用下列語法備份的檔案會保護備份檔免於遭到覆寫(請先刪除 D:\DBBackup 中的備份檔 AdventureWorks.Bak)
BACKUP DATABASE AdventureWorks TO DISK='D:\DBBackup\AdventureWorks.Bak'
WITH MEDIAPASSWORD='password'
--若未指定密碼，或密碼錯誤將無法備份到相同的媒體集
BACKUP DATABASE AdventureWorks TO DISK='D:\DBBackup\AdventureWorks.Bak'

--透過Format選項強制覆蓋原內容
BACKUP DATABASE AdventureWorks TO DISK='D:\DBBackup\AdventureWorks.Bak'
WITH FORMAT

--*****************************************************************
--12-2 復原
--*****************************************************************

/*------------------------------------------------------------------
    範例程式碼12-3：
    透過交易標示的位置，還原到特定的點
------------------------------------------------------------------*/


ALTER DATABASE Northwind SET RECOVERY FULL

BACKUP DATABASE Northwind TO DISK='C:\temp\nwind.bak' WITH INIT

CREATE TABLE Northwind.dbo.t(c1 INT)

BACKUP LOG Northwind TO DISK='C:\temp\nwind.trn' WITH INIT

BEGIN TRAN insertData WITH MARK '新增記錄'
		INSERT Northwind.dbo.t VALUES(1)
		INSERT Northwind.dbo.t VALUES(2)
COMMIT TRAN

BEGIN TRAN deleteTable WITH MARK '刪除記錄'
		DELETE Northwind.dbo.t WHERE c1=1
COMMIT TRAN

--10:33:40 發生人為災難
BEGIN TRAN deleteTable WITH MARK '刪除記錄'
		DELETE Northwind.dbo.t
COMMIT TRAN


--備結尾記錄，且要求資料庫進入到 Norecovery 狀態，免得中間有人改
BACKUP LOG Northwind TO DISK='C:\temp\nwindTail.trn' WITH NORECOVERY,INIT

RESTORE DATABASE Northwind FROM DISK='C:\temp\nwind.bak' WITH NORECOVERY,REPLACE
RESTORE LOG Northwind FROM DISK='C:\temp\nwind.trn' WITH NORECOVERY

RESTORE LOG Northwind FROM DISK='C:\temp\nwindTail.trn'
WITH STOPBEFOREMARK='deleteTable' AFTER '20090326 10:33:40',RECOVERY

--*****************************************************************
--12-2-2∣　STANDBY
--*****************************************************************

/*------------------------------------------------------------------
    範例程式碼12-4：
    模擬在備份時，交易正完成一半
------------------------------------------------------------------*/

-->0<--
ALTER DATABASE Northwind SET RECOVERY FULL
BACKUP DATABASE Northwind TO DISK='C:\temp\nwind.bak' WITH INIT
--1. 切換到另一條連接執行做一半的交易
-->2<--
BACKUP LOG Northwind TO DISK='C:\temp\nwind1.trn' WITH INIT
--3. 切換到另一條連接完成前一個交易，並開啟新交易
-->4<--
BACKUP LOG Northwind TO DISK='C:\temp\nwind2.trn' WITH INIT
--5. 切換到另一條連接完成前一個交易


/*------------------------------------------------------------------
    範例程式碼12-5：
    一段時間內，完成多次交易
------------------------------------------------------------------*/
-->1<--
BEGIN TRAN
CREATE TABLE Northwind.dbo.t(c1 int)
--2. 切換到另一條連接執行交易紀錄備份
-->3<--
Commit
BEGIN Tran
INSERT Northwind.dbo.t VALUES(1)
--4. 切換到另一條連接執行交易紀錄備份
-->5<--
Commit


/*------------------------------------------------------------------
    範例程式碼12-6：
    透過STANDBY驗證需要還原到交易的哪個階段
------------------------------------------------------------------*/


-->6<-- 從Standby 還原驗證結果
BACKUP LOG Northwind TO DISK='C:\temp\nwindTail.trn' WITH NORECOVERY,INIT
RESTORE DATABASE Northwind FROM DISK='C:\temp\nwind.bak'
WITH STANDBY='C:\temp\nwindStandby.trn'
--因為是StandBy 所以可以查詢一般資料
SELECT * FROM Northwind.dbo.Customers
RESTORE LOG Northwind FROM DISK='C:\temp\nwind1.trn'
WITH STANDBY='C:\temp\nwindStandby.trn'
--這個備份交易記錄時，未完成交易，所以透過standby 查詢，
--資料表還不存在
SELECT * FROM Northwind.dbo.t
RESTORE LOG Northwind FROM DISK='C:\temp\nwind2.trn'
WITH STANDBY='C:\temp\nwindStandby.trn'
--建立資料表的交易完成，所以可查詢該資料表，但新增記錄尚未完成交易
--所以查詢不到值
SELECT * FROM Northwind.dbo.t
RESTORE LOG Northwind FROM DISK='C:\temp\nwindTail.trn'
WITH RECOVERY
SELECT * FROM Northwind.dbo.t



--*****************************************************************
--12-2-3∣資料分頁還原
--*****************************************************************

/*------------------------------------------------------------------
    範例程式碼12-7：
    透過2進位編輯程式製造分頁錯誤
------------------------------------------------------------------*/

BACKUP DATABASE Northwind TO DISK='C:\temp\nwind.bak' WITH INIT
ALTER DATABASE Northwind SET OFFLINE
--透過 Visual Studio 修改資料分頁
ALTER DATABASE Northwind SET ONLINE
/*
訊息 824，層級 24，狀態 2，行 1
SQL Server 偵測到邏輯的一致性 I/O 錯誤: 不正確的總和檢查碼 (預期: 0x83e8e0eb; 實際:
0x8268e0eb)。
這是當在檔案 'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\
MSSQL\DATA\Northwind.mdf' 中位移
0x00000000176000 的資料庫識別碼 7 之頁面 (1:187) 進行 讀取 的期間所發生的。SQL Server
錯誤記錄檔和系統事件記錄檔中的訊息，或許可以提供其他詳細資訊。這是嚴重的錯誤狀況，且可能會損
及資料庫的完整性，
所以必須立即更正。請執行完整的資料庫一致性檢查 (DBCC CHECKDB)。會導致這個錯誤的原因有許
多可能性;
如需詳細資訊，請參閱《SQL Server 線上叢書》。
*/
SELECT * FROM Northwind.dbo.Customers



/*------------------------------------------------------------------
    範例程式碼12-8：
    還原個別資料分頁
------------------------------------------------------------------*/

--先備份結尾記錄
BACKUP LOG Northwind TO DISK='C:\temp\nwindTail.trn' WITH NORECOVERY,INIT

--分頁還原
RESTORE DATABASE Northwind PAGE='1:187' FROM DISK='C:\temp\nwind.bak' WITH
NORECOVERY

--分頁還原後，透過從完整備份以來的交易記錄，讓所有的資料頁取得一致的內容
RESTORE LOG Northwind FROM DISK='C:\temp\nwindTail.trn' WITH RECOVERY

--驗證資料是否可以存取
SELECT * FROM Northwind.dbo.Customers



--*****************************************************************
--12-2-4∣透過DBCC CheckDB修復資料分頁
--*****************************************************************


/*------------------------------------------------------------------
    範例程式碼12-9：
    製造索引資料錯誤，透過DBCC CHECKDB修復
------------------------------------------------------------------*/

insert northwind.dbo.customers(customerid,companyname,city) values('aaaaa',
'abcdef','1qaz2wsx')
alter database northwind set offline
--故意損毀 City 索引內容
--透過 Visual Studio 修改 mdf 檔案，搜尋 1qaz2wsx，
--但要注意頁面內只含有叢集索引鍵值aaaaa和City索引鍵值1qaz2wsx
--而不是屬於資料表/叢集索引的頁面，若是搜尋到該資料表/叢集索引頁面
--會同時包含aaaaa、abcdef、1qaz2wsx三個值
alter database northwind set online
--資料表本身依然可以查詢
select * from Northwind.dbo.customers
--使用到該索引時失敗
select city from Northwind.dbo.customers
--以DBCC CheckDB確認資料庫的一致性
/*
DBCC 對 'Customers' 的結果。
訊息 8928，層級 16，狀態 1，行 1
物件識別碼 53575229，索引識別碼 2，資料分割識別碼 72057594039173120，配置單位識別碼
72057594040352768 (類型 In-row data): 頁面 (1:195) 無法處理。請參閱其他錯誤以取得
詳細資料。
訊息 8939，層級 16，狀態 98，行 1
資料表錯誤: 物件識別碼 53575229，索引識別碼 2，資料分割識別碼 72057594039173120，配
置單位識別碼 72057594040352768 (類型 In-row data)，頁面 (1:195)。測試 (IS_OFF
(BUF_IOERR, pBUF->bstat)) 失敗。值為 12716041 和 -4。
物件 "Customers" 在 4 頁面中有 92 個資料列。
⋯
CHECKDB 發現了資料庫 'Northwind' 中 0 個配置錯誤和 2 個一致性錯誤。
repair_allow_data_loss 是 DBCC CHECKDB (Northwind) 所發現之錯誤的最小修復層級。
⋯
*/
dbcc checkdb(Northwind)
--透過 DBCC 修復資料庫
alter database northwind set single_user
dbcc checkdb(Northwind,repair_allow_data_loss)
alter database northwind set online
alter database northwind set multi_user

--*****************************************************************
--12-2-5∣資料庫快照集還原
--*****************************************************************


CREATE DATABASE nwindSnapshot1200 ON(Name='Northwind',FileName='C:\temp\
nwindsnapshot')
AS SNAPSHOT OF Northwind


UPDATE Northwind.dbo.Customers SET Country='USA'


UPDATE Northwind.dbo.Customers SET Country=s.Country
FROM Northwind.dbo.Customers c JOIN nwindSnapshot1200.dbo.Customers s
ON c.CustomerID=s.CustomerID


UPDATE Northwind.dbo.Customers SET Country='USA'
UPDATE Northwind.dbo.Orders SET Freight=10

RESTORE DATABASE Northwind FROM DATABASE_SNAPSHOT='nwindSnapshot1200'

DROP DATABASE nwindSnapshot1200


--*****************************************************************
--12-3-2∣備份進度回報
--*****************************************************************

BACKUP DATABASE AdventureWorks TO DISK=N'd:\temp\Adv.bak'
WITH INIT,STATS=10

--*****************************************************************
--12-3-3∣檔案和檔案群組備份
--*****************************************************************

/*------------------------------------------------------------------
		範例程式碼12-10：
		建立測試用資料庫、新增記錄，並針對個別檔案備份
------------------------------------------------------------------*/

--須以SQLCMD mode 執行這個範例
USE [master]
GO
--DROP DATABASE Nwind
--透過SqlCmd 執行準備工作
!!md C:\myAdmin\DB
!!md C:\myAdmin\Backup
--因為要做File 的備份/還原，所以需要建立多個File
CREATE DATABASE [Nwind] ON
PRIMARY( NAME=N'Nwind_P',FILENAME = N'C:\myAdmin\DB\Nwind_P.mdf' ),
FILEGROUP GroupA( NAME=N'Nwind_A',FILENAME = N'C:\myAdmin\DB\Nwind_A.ndf' )
GO
--在各檔案群組各放一個資料表
USE Nwind
GO
CREATE TABLE tbP(c1 INT,c2 nvarchar(10)) ON [PRIMARY]
CREATE TABLE tbA(c1 INT,c2 nvarchar(10)) ON [GroupA]
GO
--執行個別的檔案備份，而非完整備份
BACKUP DATABASE Nwind FILE='Nwind_P' TO DISK=N'C:\myAdmin\Backup\NwindP.
bak' WITH INIT
-- 新增資料
INSERT Nwind.dbo.tbP VALUES(1,'P1')
INSERT Nwind.dbo.tbA VALUES(1,'A1')
BACKUP LOG Nwind TO DISK=N'C:\myAdmin\Backup\Nwind1.trn' WITH INIT
-- 新增資料
INSERT Nwind.dbo.tbP VALUES(2,'P2')
INSERT Nwind.dbo.tbA VALUES(2,'A2')
--執行個別的檔案備份，而非完整備份
BACKUP DATABASE Nwind FILE='Nwind_A' TO DISK=N'C:\myAdmin\Backup\NwindA.
bak' WITH INIT

INSERT Nwind.dbo.tbP VALUES(3,'P3')
INSERT Nwind.dbo.tbA VALUES(3,'A3')
BACKUP LOG Nwind TO DISK=N'C:\myAdmin\Backup\Nwind2.trn' WITH INIT


/*------------------------------------------------------------------
		範例程式碼12-11：
		停止SQL Server執行個體服務，刪除其中一個資料庫檔案以模擬損毀
------------------------------------------------------------------*/

--毀掉資料
--使用SQLCMD 模式，標記以下四句話後，一起執行
--執行完畢後要重新連接SQL Server
!!net stop mssqlserver /Y
-- 破壞C:\myAdmin\DB\Nwind_B.ndf
!!Del C:\myAdmin\DB\Nwind_A.bad
!!ren "C:\myAdmin\DB\Nwind_A.ndf" *.BAD
!!net start mssqlserver /Y
/*
訊息，層級，狀態，行
檔案無法存取、記憶體或磁碟空間不足，因此無法開啟資料庫'Nwind'。詳細資訊請參閱SQL Server
錯誤記錄檔。
*/
-- 檢查SQL Server 記錄檔
SELECT * FROM Nwind.dbo.tbP


/*------------------------------------------------------------------
		範例程式碼12-12：
		備份結尾記錄，復原檔案與交易記錄
------------------------------------------------------------------*/
-- 備份結尾記錄
BACKUP LOG nwind TO DISK='C:\myAdmin\Backup\NwindTail.trn' WITH INIT,NO_
TRUNCATE
-- 復原檔案
RESTORE DATABASE nwind FILE='Nwind_A' FROM DISK=N'C:\myAdmin\Backup\NwindA.bak'
WITH NORECOVERY

RESTORE LOG Nwind FROM DISK=N'C:\myAdmin\Backup\Nwind2.trn' WITH NORECOVERY
-- 還原結尾記錄，讓各資料庫檔完成一致
RESTORE LOG Nwind FROM DISK='C:\myAdmin\Backup\NwindTail.trn' WITH RECOVERY
-- 分析資料，可以完整查詢所有的資料內容
SELECT * FROM Nwind.dbo.tbP
UNION ALL
SELECT * FROM Nwind.dbo.tbA


--******************************************************************
--12-4 線上還原
--******************************************************************

/*------------------------------------------------------------------
		範例程式碼12-13：
		在Northwind範例資料庫中新增唯讀檔案群組
------------------------------------------------------------------*/
ALTER DATABASE Northwind ADD FILEGROUP fgHistory
ALTER DATABASE Northwind ADD FILE(NAME=Northwind_History,FILENAME='C:\temp\
Northwind_History.ndf') TO FILEGROUP fgHistory
GO
USE [Northwind]
CREATE TABLE [dbo].[OrderDetailsHistory](
[OrderID] [int] NOT NULL,
[ProductID] [int] NOT NULL,
[UnitPrice] [money] NOT NULL,
[Quantity] [smallint] NOT NULL,
[Discount] [real] NOT NULL,
) ON [fgHistory]
GO
INSERT OrderDetailsHistory SELECT * FROM [Order Details]
--設定檔案群組為唯讀
ALTER DATABASE Northwind SET Single_User
ALTER DATABASE Northwind MODIFY FILEGROUP fgHistory READ_ONLY
ALTER DATABASE Northwind SET MULTI_USER


/*------------------------------------------------------------------
		範例程式碼12-14：
		線上還原唯讀的檔案群組
------------------------------------------------------------------*/

-- 僅備份可讀寫的檔案群組，可以搭配READ_WRITE_FILEGROUPS
BACKUP DATABASE Northwind READ_WRITE_FILEGROUPS TO DISK='C:\temp\NorthwindRW.bak'

RESTORE FILELISTONLY FROM DISK='C:\temp\NorthwindRW.bak'

-- 備份唯讀檔案群組
BACKUP DATABASE Northwind FILEGROUP='fgHistory' TO DISK='C:\temp\NorthwindR.bak'
RESTORE FILELISTONLY FROM DISK='C:\temp\NorthwindR.bak'
--備份完畢後，模擬人為災難，例如錯刪資料庫：
-- 模擬災難
DROP DATABASE Northwind
--還原主要檔案群組後，即可讀寫該資料庫
--接著進行「線上還原」
RESTORE DATABASE Northwind FILEGROUP='PRIMARY'
FROM DISK='C:\temp\NorthwindRW.bak' WITH PARTIAL, RECOVERY;

--「線上還原」模式可以存取已經還原的內容
SELECT * FROM Northwind.dbo.Customers
UPDATE TOP(1) Northwind.dbo.Orders SET Freight+=1
--若存取到未還原的部分，將會出現錯誤
/*
訊息8653，層級16，狀態1，行1
查詢處理器無法產生資料表或檢視'OrderDetailsHistory' 的計劃，因為資料表存在於非線上的檔
案群組中。
*/
SELECT * FROM Northwind.dbo.OrderDetailsHistory
--單獨還原唯讀的檔案群組
RESTORE DATABASE Northwind FILEGROUP='fgHistory'
FROM DISK='C:\temp\NorthwindR.bak' WITH RECOVERY;
SELECT * FROM Northwind.dbo.OrderDetailsHistory


/*------------------------------------------------------------------
		範例程式碼12-15：
		線上還原唯讀的檔案群組
------------------------------------------------------------------*/


--須以SQLCMD mode 執行這個範例
USE [master]
GO
--DROP DATABASE Nwind
--因為要做File 的備份/還原，所以需要建立多個File
CREATE DATABASE [Nwind] ON PRIMARY( NAME=N'Nwind_P',FILENAME = N'C:\
myAdmin\DB\Nwind_P.mdf' ),
FILEGROUP GroupA( NAME=N'Nwind_A',FILENAME = N'C:\myAdmin\DB\Nwind_A.ndf' ),
FILEGROUP GroupB( NAME=N'Nwind_B',FILENAME = N'C:\myAdmin\DB\Nwind_B.ndf' )
GO
USE Nwind
--在各檔案群組各放一個資料表
CREATE TABLE tbP(c1 INT,c2 nvarchar(10)) ON [PRIMARY]
CREATE TABLE tbA(c1 INT,c2 nvarchar(10)) ON [GroupA]
CREATE TABLE tbB(c1 INT,c2 nvarchar(10)) ON [GroupB]


/*------------------------------------------------------------------
		範例程式碼12-16：
		線上還原唯讀的檔案群組
------------------------------------------------------------------*/

BACKUP DATABASE Nwind TO DISK=N'C:\myAdmin\Backup\Nwind.bak' WITH INIT
-- 新增資料
INSERT Nwind.dbo.tbP VALUES(1,'P')
INSERT Nwind.dbo.tbA VALUES(1,'A')
INSERT Nwind.dbo.tbB VALUES(1,'B')
--在Management Studio進入SqlCmd模式，毀掉資料檔
!!net stop mssqlserver /Y
-- 破壞C:\myAdmin\DB\Nwind_B.ndf
!!Del C:\myAdmin\DB\Nwind_A.bad
!!ren "C:\myAdmin\DB\Nwind_A.ndf" *.BAD
!!net start mssqlserver /Y
--重新啟動服務，查詢資料時，發生以下的錯誤

/*
訊息，層級，狀態，行
檔案無法存取、記憶體或磁碟空間不足，因此無法開啟資料庫'Nwind'。詳細資訊請參閱SQL Server 錯誤記錄檔。
*/

SELECT * FROM Nwind.dbo.tbP
-- 檢查資料庫的狀態
-- Nwind 在RECOVERY_PENDING 狀態
SELECT name, state_desc
FROM sys.databases


/*------------------------------------------------------------------
		範例程式碼12-17：
		存取發生錯誤的資料庫依然在線上的部分，並備份結尾交易記錄
------------------------------------------------------------------*/

-- 設定個別檔案為離線狀態
ALTER DATABASE Nwind
MODIFY FILE (name = N'Nwind_A', OFFLINE)
go
-- 設定資料庫為線上狀態
ALTER DATABASE Nwind SET ONLINE
go

-- 分析各個資料檔案的屬性-- OFFLINE
SELECT name, physical_name, state_desc, is_read_only , read_only_lsn
FROM Nwind.sys.database_files
-- 分析資料，僅有tbA 錯誤
SELECT * FROM Nwind.dbo.tbP
GO
SELECT * FROM Nwind.dbo.tbA -- 錯誤
GO
SELECT * FROM Nwind.dbo.tbB
GO
INSERT Nwind.dbo.tbP VALUES(2,'P')
GO
/*
訊息，層級，狀態，行
查詢處理器無法產生資料表或檢視'tbB' 的計劃，因為資料表存在於非線上的檔案群組中。
*/
INSERT Nwind.dbo.tbA VALUES(2,'A') --錯誤
GO
INSERT Nwind.dbo.tbB VALUES(2,'B')
-- 在系統發生錯誤後，要備份結尾交易記錄!!!!
BACKUP LOG Nwind
TO DISK ='C:\myAdmin\Backup\Nwind.trn'
WITH NAME = 'LOG_backupset',INIT,NO_TRUNCATE



/*------------------------------------------------------------------
		範例程式碼12-18：
		線上復原資料庫發生錯誤的檔案 / 檔案群組
------------------------------------------------------------------*/

-- 復原個別資料庫檔案
/*
已處理資料庫'Nwind' 的8 頁，檔案1 上的檔案'Nwind_A'。
向前復原目前的起始點位於記錄序號(LSN) 29000000022800001。必須有超過LSN 29000000030200001
的其他向前復原，才能完成還原順序。
RESTORE DATABASE ... FILE=<name> 已於0.045 秒內成功處理了8 頁(1.388 MB/sec)。
*/
RESTORE DATABASE Nwind FILE = N'Nwind_A'
FROM DISK ='C:\myAdmin\Backup\Nwind.bak'
WITH RECOVERY
-- 分析各個資料檔案的屬性-- RESTORING
SELECT name, physical_name, state_desc, is_read_only , read_only_lsn
FROM Nwind.sys.database_files
-- 復原結尾交易記錄，讓復原的資料和其他既有資料變得一致
RESTORE LOG Nwind

FROM DISK ='C:\myAdmin\Backup\Nwind.trn'
WITH RECOVERY
-- 分析各個資料檔案的屬性-- ONLINE
SELECT name, physical_name, state_desc, is_read_only , read_only_lsn
FROM Nwind.sys.database_files
-- 分析資料，可以完整出來所有的資料內容
SELECT * FROM Nwind.dbo.tbP
UNION ALL
SELECT * FROM Nwind.dbo.tbA
UNION ALL
SELECT * FROM Nwind.dbo.tbB