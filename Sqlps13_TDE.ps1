<#Sqlps13_TDE
  C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps13_TDE.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 LastDate : APR.28.2014
 object : tsql


#>

# 01 Setting up Transparent Data Encryption(TDE)  p.299


 #----------------------------------------------------------
 #
 #----------------------------------------------------------
--CDC test
--ming tseng
-- Jan.03.2013

/*************disable CDC **********/

-view
EXEC sys.sp_cdc_help_change_data_capture
select name, is_cdc_enabled from sys.databases


--Disable CDC on the table
--EXEC sys.sp_cdc_disable_table
--  @source_schema ='dbo',
--  @source_name ='Employee',
--  @capture_instance ='dbo_Employee'

--Disable CDC on the DB
--use TestDB
--EXEC sys.sp_cdc_disable_db.

/*************check CDC **********/
--declare @rc int
--exec @rc = sys.sp_cdc_enable_db
--select @rc
---- new column added to sys.databases: is_cdc_enabled
--select name, is_cdc_enabled from sys.databases
EXEC sys.sp_cdc_get_captured_columns @capture_instance ='dbo_Employee';
select name, type, type_desc, is_tracked_by_cdc from sys.tables

select o.name, o.type, o.type_desc 
from sys.objects o join sys.schemas  s 
on s.schema_id = o.schema_id
where s.name = 'cdc'

/*************1. create DB  table **********/
CREATE DATABASE TestDB;
Use Y3
GO
CREATE TABLE EmployeeM(
EIDM INT IDENTITY(1,1)PRIMARY KEY,
ENAMEM VARCHAR(50),
DEPTM VARCHAR(20)
);
INSERT INTO EmployeeM Values ('RamboM','ITM'),('JasonM','FinanceM'),('BradM','HRM');

/*This is a new feature in SQL Server 2008 for constructing your 
Insert query to be able to handle multiple inserts in one go.  */

SELECT * FROM Employee;
/*************2. enable CDC **********/
/*Enabling CDC on the Database TestDB*/
Use Y3
GO
EXEC sys.sp_cdc_enable_db


/*check  */
SELECT name,is_cdc_enabled FROM sys.databases WHERE name='Y3'
/*
name     is_cdc_enabled
-------- --------------
TestDB         1

(1 row(s) affected)
CDC enabled successfully on the DB TestDB 
*/



/*************3. enable CDC  on table**********/
EXEC sys.sp_cdc_enable_table
    @source_schema ='dbo',
    @source_name ='Y',
    @role_name ='YCDCRole',
    @supports_net_changes = 1
/*Messages Returned
Job 'cdc.TestDB_capture' started successfully.
Job 'cdc.TestDB_cleanup' started successfully.*/

SELECT name,is_tracked_by_cdc FROM sys.tables WHERE name='Y'
SELECT name,is_tracked_by_cdc FROM sys.tables WHERE name='Y'
/*
name        is_tracked_by_cdc
--------    -----------------
Employee     1

(1 row(s) affected)*/


/*************4. DML **********/
Use Y3
select * from y1.dbo.y ; select * from y3.dbo.y
DELETE FROM y1.dbo.y WHERE N1='Y112'
INSERT INTO y1.dbo.y VALUES('111','HR','CSD')
UPDATE y1.dbo.y SET N2='88' WHERE N1='Y99'
UPDATE y1.dbo.y SET N2='99' WHERE N1='Y99'
select * from y1.dbo.y ; select * from y3.dbo.y

/************************ test *******************/
DECLARE @Begin_LSN binary(10), @End_LSN binary(10),@Begin_LSNM binary(10), @End_LSNM binary(10)

-- get the first LSN 
set @Begin_LSN =sys.fn_cdc_get_min_lsn('dbo_Y')
print @Begin_LSN
-- get the last LSN 
set @End_LSN =sys.fn_cdc_get_max_lsn()
print @End_LSN
-- returns net changes
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Y(@Begin_LSN, @End_LSN,'ALL UPDATE OLD');

SELECT * FROM cdc.fn_cdc_get_net_changes_dbo_Y(@Begin_LSN, @End_LSN,'ALL');
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Y(@Begin_LSN, @End_LSN,'ALL');
select sys.fn_cdc_map_lsn_to_time(__$start_Lsn),* from [cdc].[dbo_Y_CT]
--DECLARE @Begin_LSNM binary(10), @End_LSNM binary(10)
SELECT @Begin_LSNM =sys.fn_cdc_get_min_lsn('dbo_Y')
print @Begin_LSNM
-- get the last LSN 
SELECT @End_LSNM =sys.fn_cdc_get_max_lsn()
--print @End_LSN
-- returns net changes


SELECT * FROM cdc.fn_cdc_get_net_changes_dbo_EmployeeM(@Begin_LSNM, @End_LSNM,'ALL');
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_EmployeeM(@Begin_LSNM, @End_LSNM,'ALL')

------------------------------------------------------------
EXEC sys.sp_cdc_get_captured_columns @capture_instance ='dbo_Y';
EXEC sys.sp_cdc_get_captured_columns @capture_instance ='dbo_EmployeeM';
EXEC sys.sp_cdc_help_change_data_capture






















 #












#-------------------------------------------------------------------
# 01 Setting up Transparent Data Encryption(TDE)  p.299
#-------------------------------------------------------------------

'In this recipe, we will enable Transparent Data Encryption (TDE) on the TestDB database.
If you do not already have this test database, log in the SQL Server Management Studio and
execute the following T-SQL code:
IF DB_ID(TestDB') IS NULL
CREATE DATABASE TestDB
GO
'You must already have a database master key for this TestDB database. If not, create it using the Creating a database master key recipe.
'

(1). Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
(2). Import the SQLPS module, and create a new SMO Server object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "KERRIGAN"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
(3). Add the following script and run:
$databasename = "TestDB"
$database = $server.Databases[$databasename]
#if not yet created, create or obtain a certificate
#protected by the master key
#this is equivalent to
<#
USE master
GO
CREATE CERTIFICATE [Encryption]
WITH SUBJECT = N'This is a test certificate.',
START_DATE = N'02/10/2012',
EXPIRY_DATE = N'01/01/2015'
#>
$certificateName = "Test Certificate"
$masterdb = $server.Databases["master"]
if ($masterdb.Certificates[$certificateName])
{
$masterdb.Certificates[$certificateName].Drop()
}
$certificate = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Certificate -ArgumentList $masterdb,$certificateName
#create certificate protected by the master key
$certificate.StartDate = "February 10, 2012"
$certificate.Subject = "This is a test certificate."
$certificate.ExpirationDate = "January 01, 2015"
#you can optionally provide a password, but this
#certificate we created is protected by the master key
$certificate.Create()
#create a database encryption key
#this is equivalent to
<#
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE [Test Certificate]
#>
$dbencryption = New-Object Microsoft.SqlServer.Management.Smo.DatabaseEncryptionKey
$dbencryption.Parent = $database
$dbencryption.EncryptionAlgorithm = [Microsoft.SqlServer.Management.Smo.DatabaseEncryptionAlgorithm]::Aes256

$dbencryption.EncryptionType = [Microsoft.SqlServer.Management.Smo.DatabaseEncryptionType]::ServerCertificate
#associate certificate name
$dbencryption.EncryptorName = $certificateName
$dbencryption.Create()
#enable TDE
#this is equivalent to :
<#
ALTER DATABASE [TestDB]
SET ENCRYPTION ON
#>
$database.EncryptionEnabled = $true
$database.Alter()
$database.Refresh()
#display TDE setting
$database.EncryptionEnabled


##Alternatively you can use the following T-SQL statement to confirm:
'The encryption_state = 3 means encryption of that database has already completed.
Notice also that tempdb is also encrypted. By default, if any user databases are
encrypted, tempdb also automatically gets encrypted.'
SELECT db.name ,
db.is_encrypted ,
dm.encryption_state ,
dm.percent_complete ,
dm.key_algorithm ,
dm.key_length
FROM sys.databases db
LEFT OUTER JOIN sys.dm_database_encryption_keys dm
ON db.database_id = dm.database_id



-------------------------------------------------------------------
--範例程式碼15-1：建立目標資料庫Northwind_TDE
-------------------------------------------------------------------
USE master
GO
-- 備份資料庫Northwind，並搭配利用「備份壓縮(Backup Compression)」
BACKUP DATABASE [Northwind] 
TO  DISK = N'C:\myAdmin\Device\nw_TDE.bak' WITH FORMAT, 
	NAME = N'Northwind-完整 資料庫 備份', STATS = 10, COMPRESSION
GO

-- 復原資料庫為：Northwind_TDE
RESTORE DATABASE [Northwind_TDE] 
FROM  DISK = N'C:\myAdmin\Device\nw_TDE.bak' 
WITH  FILE = 1,  
	MOVE N'Northwind' TO N'C:\myAdmin\DB\Northwind_TDE.mdf',  
	MOVE N'Northwind_log' TO N'C:\myAdmin\DB\Northwind_TDE_1.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO

-------------------------------------------------------------------
--範例程式碼15-2：建立「資料庫主要金鑰(DMK)」與「憑證」
-------------------------------------------------------------------
--01 建立「資料庫主要金鑰(DMK)」
/*
「資料庫主要金鑰(DMK)」是一個用來保護憑證私密金鑰和資料庫中非對稱金鑰的對稱金鑰。
建立資料庫主要金鑰時，會利用三重 DES 演算法和使用者提供的密碼來加密主要金鑰。
*/
USE master;
GO
CREATE MASTER KEY 
	ENCRYPTION BY PASSWORD = '!^(UseStrongPassword';
GO

--02 檢視是否已經利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)」。
/*
在 master 中之 sys.databases 目錄檢視的 is_master_key_encrypted_by_server 資料行，可以指出是否利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)」。
 */ 
USE master;
GO
SELECT name N'資料庫', is_master_key_encrypted_by_server N'是否已經利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)」'
FROM master.sys.databases
WHERE name='master'

--03 建立自簽「憑證」
CREATE CERTIFICATE MySrvCert
	WITH SUBJECT = 'My DEK Certificate for Sensitive Data';
GO

--04 檢視已經建立的「憑證」
SELECT name N'憑證名稱', subject N'憑證的主旨', expiry_date N'憑證逾期時間', start_date N'憑證生效時間',
	pvt_key_encryption_type_desc N'私密金鑰加密方式', cert_serial_number N'憑證的序號', pvt_key_last_backup_date N'憑證的私密金鑰上一次匯出的日期時間'
FROM sys.certificates

-------------------------------------------------------------------
--範例程式碼15-3：附加資料庫
-------------------------------------------------------------------
--01 附加資料庫：Northwind_TDE，在執行個體：SQL2K8\I2 上執行。
USE [master]
GO

CREATE DATABASE [Northwind_TDE] ON 
( FILENAME = N'C:\myAdmin\I2\Northwind_TDE.mdf' ),
( FILENAME = N'C:\myAdmin\I2\Northwind_TDE_1.ldf' )
 FOR ATTACH
GO

/* 顯示的「訊息」
訊息 33111，層級 16，狀態 3，行 2
找不到指模為 '0x085B149431E9072D719F2C75A41158F9ADD0D697' 的伺服器 憑證。
*/

-------------------------------------------------------------------
--範例程式碼15-4：還原資料庫
-------------------------------------------------------------------
--01 還原資料庫：Northwind_TDE，在執行個體：SQL2K8\I2 上執行。
-- 還原的資料夾路徑：C:\myAdmin\I2
USE master
GO

RESTORE DATABASE [Northwind_TDE] 
FROM  DISK = N'C:\myAdmin\Device\nw_TDE.bak' 
WITH  FILE = 1,  
	MOVE N'Northwind' TO N'C:\myAdmin\I2\Northwind_TDE_2.mdf',  
	MOVE N'Northwind_log' TO N'C:\myAdmin\I2\Northwind_TDE_2.LDF',  
NOUNLOAD,  REPLACE,  STATS = 10
GO

/* 顯示的「訊息」
訊息 33111，層級 16，狀態 3，行 2
找不到指模為 '0x085B149431E9072D719F2C75A41158F9ADD0D697' 的伺服器 憑證。
訊息 3013，層級 16，狀態 1，行 2
RESTORE DATABASE 正在異常結束。
*/

-------------------------------------------------------------------
--範例程式碼15-5：將憑證匯出至檔案
-------------------------------------------------------------------
--01 匯出「憑證」和「私密金鑰」。
USE master
GO
BACKUP CERTIFICATE MySrvCert
TO FILE = 'C:\myAdmin\Cert\MySrvCert'
	WITH PRIVATE KEY (FILE='C:\myAdmin\Cert\MySrvCertPriK',
	ENCRYPTION BY PASSWORD='!^(UseStrongPassword')
GO

-------------------------------------------------------------------
--範例程式碼15-6：建立「資料庫主要金鑰(DMK)」與匯入先前匯出的「憑證」檔案
-------------------------------------------------------------------
--01 建立「資料庫主要金鑰(DMK)」。
USE master
GO 
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = 'UseDifferentStrongPassword%^^'
GO

--02 建立「憑證」，匯入先前匯出的「憑證」檔案。
CREATE CERTIFICATE MySrvCert
FROM FILE='C:\myAdmin\Cert\MySrvCert'
	WITH PRIVATE KEY (FILE = 'C:\myAdmin\Cert\MySrvCertPriK',
	DECRYPTION BY PASSWORD='!^(UseStrongPassword')
GO

-------------------------------------------------------------------
--範例程式碼15-7：建立範例資料庫
-------------------------------------------------------------------
/*
目標建立兩個一模一樣的資料庫：RW、RW_TDE。
單一資料庫的大小為：1.29 GB。
*/
/*------------------------------------------------------------------------------*/
--01 建立資料庫：RW
USE [master]
GO
CREATE DATABASE [RW] ON  PRIMARY 
( NAME = N'RW', FILENAME = N'C:\myAdmin\DB\RW.mdf' , 
	SIZE = 1048576KB , FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'RW_log', FILENAME = N'C:\myAdmin\DB\RW_log.ldf' , 
	SIZE = 102400KB , FILEGROWTH = 10%)
GO

/*------------------------------------------------------------------------------*/
--02 建立資料表：Orders1G
CREATE TABLE RW.dbo.Orders1G
(SID int IDENTITY(1,1), 
	[OrderID] [int] NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL )
GO

/*------------------------------------------------------------------------------*/
--03 新增資料列
/*
對此資料表dbo.Orders1G，執行新增資料列作業：
1. 資料來源：Northwind.dbo.Orders。
2. 使用的磁碟空間(MB)：1324。
3. 資料實際上使用的空間(MB)：1269.4375。
4. 每一筆資料列都不相同。
5. 在資料表：Orders1G 內，小計有：6640,000 筆。
*/
SET NOCOUNT ON
GO
DECLARE @cnt INT=1

WHILE @cnt<=8000
BEGIN
	INSERT RW.dbo.Orders1G
	SELECT  OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, 
		Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
	FROM    Northwind.dbo.Orders
	
	SET @cnt+=1
END

SELECT COUNT(*) FROM RW.dbo.Orders1G

/*------------------------------------------------------------------------------*/
--04 產生資料庫：RW_TDE。
/*
備份資料庫：RW，並還原成資料庫：RW_TDE。
因此，資料庫：RW 與 資料庫：RW_TDE 是一模一樣的資料庫。
*/
BACKUP DATABASE [RW] 
TO  DISK = N'C:\myAdmin\Device\RW01.bak' 
	WITH FORMAT, COMPRESSION,  STATS = 10
GO

RESTORE DATABASE [RW_TDE] 
FROM  DISK = N'C:\myAdmin\Device\RW01.bak' 
WITH  FILE = 1,  
	MOVE N'RW' TO N'C:\myAdmin\DB\RW_TDE.mdf',  
	MOVE N'RW_log' TO N'C:\myAdmin\DB\RW_TDE_1.ldf',  
	REPLACE,  STATS = 10
GO

-------------------------------------------------------------------
--範例程式碼15-8：檢視資料庫的空間
-------------------------------------------------------------------
--01 檢視資料庫：RW 與 RW_TDE 的空間大小。
/*
執行「透明資料加密(TDE)」之前。
任一個資料庫的資料實際上使用的空間(MB)：1269.437500。
*/
USE RW
GO
SELECT DB_NAME() N'資料庫名稱', name N'邏輯檔案名稱' , size/128.0 N'使用的磁碟空間(MB)' ,  
 CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 N'資料實際上使用的空間(MB)'  
 ,size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 N'剩餘的可用空間(MB)'  
FROM sys.database_files;  

--
USE RW_TDE
GO
SELECT DB_NAME() N'資料庫名稱', name N'邏輯檔案名稱' , size/128.0 N'使用的磁碟空間(MB)' ,  
 CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 N'資料實際上使用的空間(MB)'  
 ,size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 N'剩餘的可用空間(MB)'  
FROM sys.database_files;  
GO

-------------------------------------------------------------------
--範例程式碼15-9：建立「資料庫主要金鑰(DMK)」
-------------------------------------------------------------------
--01 檢視是否已經利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)」。
/*
在 master 中之 sys.databases 目錄檢視的 is_master_key_encrypted_by_server 資料行，可以指出是否利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)」。
 */ 
 USE master;
GO
SELECT name N'資料庫', is_master_key_encrypted_by_server N'是否已經利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)'
FROM master.sys.databases
WHERE name='master'

--
SELECT * FROM sys.symmetric_keys

-- 02 判斷是否需要建立「資料庫主要金鑰」。若是已經有利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)，就無需再建立。
IF NOT EXISTS(SELECT name FROM master.sys.databases WHERE name='master' AND is_master_key_encrypted_by_server=1)
BEGIN
	CREATE MASTER KEY 
	ENCRYPTION BY PASSWORD = 'Sligachan*01*';
END

--03 檢視是否已經利用「服務主要金鑰」來加密「資料庫主要金鑰」。
SELECT name N'資料庫', is_master_key_encrypted_by_server N'是否已經利用「服務主要金鑰(SMK)」來加密「資料庫主要金鑰(DMK)'
FROM master.sys.databases
WHERE name='master'

-------------------------------------------------------------------
--範例程式碼15-10：建立「憑證」
-------------------------------------------------------------------
--01 建立「憑證」
USE master
GO

CREATE CERTIFICATE myRW_Cert
	WITH SUBJECT = 'myRW DEK Certificate';
GO

--02 檢視已經建立的「憑證」
SELECT name N'憑證名稱', subject N'憑證的主旨', expiry_date N'憑證逾期時間', start_date N'憑證生效時間',
	pvt_key_encryption_type_desc N'私密金鑰加密方式', cert_serial_number N'憑證的序號', pvt_key_last_backup_date N'憑證的私密金鑰上一次匯出的日期時間'
FROM sys.certificates

-------------------------------------------------------------------
--範例程式碼15-11：建立加密金鑰(DEK)與啟用「透用資料加密(TDE)」
-------------------------------------------------------------------
--01 對資料庫：RW_TDE，建立用「透明資料加密」的「資料庫加密金鑰」。
USE RW_TDE;
GO

CREATE DATABASE ENCRYPTION KEY
	WITH ALGORITHM = AES_128
	ENCRYPTION BY SERVER CERTIFICATE myRW_Cert;
GO

/* 特別提醒你的警告訊息：

警告: 用來加密資料庫加密金鑰的憑證尚未備份。您應該立即備份此憑證和與此憑證關聯的私密金鑰。
萬一憑證無法使用時，或者您必須還原資料庫或將它附加到另一部伺服器時，就必須有憑證和私密金鑰的備份，否則就無法開啟資料庫。
*/

--02 設定啟用「透明資料加密(TDE)」
/*
在資料庫層級啟用加密時，所有的檔案群組都會加密。
任何新的檔案群組都會繼承加密的屬性。
如果資料庫內有任何檔案群組設定為 READ ONLY，則資料庫加密作業將會失敗。
*/
USE master;
GO
ALTER DATABASE RW_TDE
	SET ENCRYPTION ON;
GO

-------------------------------------------------------------------
--範例程式碼15-12：檢視關於資料庫加密狀態的資訊
-------------------------------------------------------------------
--01  檢視關於資料庫加密狀態的資訊。
/*
sys.dm_database_encryption_keys 
傳回關於資料庫加密狀態及其相關聯之資料庫加密金鑰的資訊。

--
資料行名稱：encryption_state 

指出資料庫已加密或未加密。

0 = 沒有資料庫加密金鑰存在，未加密
1 = 未加密
2 = 加密進行中
3 = 已加密
4 = 金鑰變更進行中
5 = 解密進行中

資料行名稱：percent_complete
資料庫加密狀態變更的完成百分比。如果沒有狀態變更，這將會是 0。
*/
USE master
GO
SELECT DB_NAME(database_id) N'資料庫',encryption_state N'加密狀態',percent_complete N'完成百分比'
FROM sys.dm_database_encryption_keys
GO

-------------------------------------------------------------------
--範例程式碼15-13：檢視資料表的使用空間、資料列之筆數等等資料
-------------------------------------------------------------------
--01 檢視資料表：dbo.Orders1G 的使用空間、資料列之筆數等等資料
USE RW
GO
SELECT DB_NAME() N'資料庫',a3.name AS N'結構描述', a2.name AS N'資料表', a1.rows AS N'資料列筆數', 
	(a1.reserved + ISNULL(a4.reserved,0))* 8 AS N'已保留(KB)', a1.data * 8 AS '資料使用空間(KB)',
	(CASE WHEN (a1.used + ISNULL(a4.used,0)) > a1.data THEN (a1.used + ISNULL(a4.used,0)) - a1.data ELSE 0 END) * 8 AS N'索引(KB)',
	(CASE WHEN (a1.reserved + ISNULL(a4.reserved,0)) > a1.used THEN (a1.reserved + ISNULL(a4.reserved,0)) - a1.used ELSE 0 END) * 8 AS N'未使用(KB)'
FROM (
	SELECT ps.object_id, SUM (CASE WHEN (ps.index_id < 2) THEN row_count ELSE 0 END ) AS [rows],
		SUM (ps.reserved_page_count) AS reserved,
		SUM (CASE WHEN (ps.index_id < 2) THEN (ps.in_row_data_page_count + ps.lob_used_page_count + ps.row_overflow_used_page_count)
			ELSE (ps.lob_used_page_count + ps.row_overflow_used_page_count) END) AS data,
		SUM (ps.used_page_count) AS used
	FROM sys.dm_db_partition_stats ps
	GROUP BY ps.object_id) AS a1
LEFT OUTER JOIN 
	(SELECT it.parent_id, SUM(ps.reserved_page_count) AS reserved, SUM(ps.used_page_count) AS used
	 FROM sys.dm_db_partition_stats ps INNER JOIN sys.internal_tables it ON (it.object_id = ps.object_id)
	 WHERE it.internal_type IN (202,204)
	 GROUP BY it.parent_id) AS a4 ON (a4.parent_id = a1.object_id)
INNER JOIN sys.all_objects a2  ON ( a1.object_id = a2.object_id ) 
INNER JOIN sys.schemas a3 ON (a2.schema_id = a3.schema_id)
WHERE a2.type <> N'S' and a2.type <> N'IT'
ORDER BY a3.name, a2.name
GO
USE RW_TDE
GO
SELECT DB_NAME() N'資料庫',a3.name AS N'結構描述', a2.name AS N'資料表', a1.rows AS N'資料列筆數', 
	(a1.reserved + ISNULL(a4.reserved,0))* 8 AS N'已保留(KB)', a1.data * 8 AS '資料使用空間(KB)',
	(CASE WHEN (a1.used + ISNULL(a4.used,0)) > a1.data THEN (a1.used + ISNULL(a4.used,0)) - a1.data ELSE 0 END) * 8 AS N'索引(KB)',
	(CASE WHEN (a1.reserved + ISNULL(a4.reserved,0)) > a1.used THEN (a1.reserved + ISNULL(a4.reserved,0)) - a1.used ELSE 0 END) * 8 AS N'未使用(KB)'
FROM (
	SELECT ps.object_id, SUM (CASE WHEN (ps.index_id < 2) THEN row_count ELSE 0 END ) AS [rows],
		SUM (ps.reserved_page_count) AS reserved,
		SUM (CASE WHEN (ps.index_id < 2) THEN (ps.in_row_data_page_count + ps.lob_used_page_count + ps.row_overflow_used_page_count)
			ELSE (ps.lob_used_page_count + ps.row_overflow_used_page_count) END) AS data,
		SUM (ps.used_page_count) AS used
	FROM sys.dm_db_partition_stats ps
	GROUP BY ps.object_id) AS a1
LEFT OUTER JOIN 
	(SELECT it.parent_id, SUM(ps.reserved_page_count) AS reserved, SUM(ps.used_page_count) AS used
	 FROM sys.dm_db_partition_stats ps INNER JOIN sys.internal_tables it ON (it.object_id = ps.object_id)
	 WHERE it.internal_type IN (202,204)
	 GROUP BY it.parent_id) AS a4 ON (a4.parent_id = a1.object_id)
INNER JOIN sys.all_objects a2  ON ( a1.object_id = a2.object_id ) 
INNER JOIN sys.schemas a3 ON (a2.schema_id = a3.schema_id)
WHERE a2.type <> N'S' and a2.type <> N'IT'
ORDER BY a3.name, a2.name
GO

-------------------------------------------------------------------
--範例程式碼15-14：查詢未啟用「透明資料加密」的資料表
-------------------------------------------------------------------
--01 將目前資料庫的所有中途分頁 (Dirty Page) 寫入磁碟中。
/*
「中途分頁」是已進入緩衝區快取中，也已修改過，但尚未寫入磁碟的資料頁面。藉由建立一個點來確保所有中途分頁都已寫入磁碟中，檢查點可讓稍後的復原節省時間。
*/
USE RW
GO
CHECKPOINT 
GO

--02 移除所有的緩衝區 
DBCC DROPCLEANBUFFERS
GO

--03 顯示剖析、編譯和執行每個陳述式所需要的毫秒數。
SET STATISTICS TIME ON
GO

--04 查詢未啟用「透明資料加密(TDE)」的資料庫之資料表：RW.dbo.Orders1G
SELECT COUNT(*) FROM RW.dbo.Orders1G

/* 回傳的「訊息」
DBCC 的執行已經完成。如果 DBCC 印出錯誤訊息，請連絡您的系統管理員。
SQL Server 剖析與編譯時間: 
   CPU 時間 = 0 ms，經過時間 = 46 ms。

(1 個資料列受到影響)

 SQL Server 執行次數: 
，CPU 時間 = 2137 ms，經過時間 = 21419 ms。
*/

-------------------------------------------------------------------
--範例程式碼15-15：查詢已啟用「透明資料加密(TDE)」的資料表
-------------------------------------------------------------------
--01 將目前資料庫的所有中途分頁 (Dirty Page) 寫入磁碟中。
/*
「中途分頁」是已進入緩衝區快取中，也已修改過，但尚未寫入磁碟的資料頁面。藉由建立一個點來確保所有中途分頁都已寫入磁碟中，檢查點可讓稍後的復原節省時間。
*/
USE RW_TDE
GO
CHECKPOINT 
GO

--02 移除所有的緩衝區 
DBCC DROPCLEANBUFFERS
GO

--03 顯示剖析、編譯和執行每個陳述式所需要的毫秒數。
SET STATISTICS TIME ON
GO

--04 查詢已啟用「透明資料加密」的資料庫之資料表：RW_TDE.dbo.Orders1G
SELECT COUNT(*) FROM RW_TDE.dbo.Orders1G

/* 回傳的「訊息」
DBCC 的執行已經完成。如果 DBCC 印出錯誤訊息，請連絡您的系統管理員。
SQL Server 剖析與編譯時間: 
   CPU 時間 = 15 ms，經過時間 = 27 ms。

(1 個資料列受到影響)

 SQL Server 執行次數: 
，CPU 時間 = 12979 ms，經過時間 = 21989 ms。
*/