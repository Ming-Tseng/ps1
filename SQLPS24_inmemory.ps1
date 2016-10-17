<#

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\SQLPS24_inmemory.ps1


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SQLPS24_inmemory.ps1

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


#    2138   inmemory  table sample  how to know  is_memory_optimized
#   272   示範：記憶體中 OLTP 的效能改善

#--------------------------------------------------------------------------------
#  0 .  In-Memory OLTP (記憶體中最佳化)
#--------------------------------------------------------------------------------
https://msdn.microsoft.com/zh-tw/library/dn133186(v=sql.120).aspx

若要使用 In-Memory OLTP，可將經常存取的資料表定義為記憶體最佳化。 記憶體最佳化資料表是可完全交易且持久的，並能利用與以磁碟為基礎的資料表一樣的方式使用 Transact-SQL 來存取。 查詢可以參考記憶體最佳化資料表和以磁碟為基礎的資料表。 
交易可以更新記憶體最佳化資料表和以磁碟為基礎的資料表中的資料。 僅參考記憶體最佳化資料表的預存程序可原生編譯為機器碼，以進一步提升效能。
In-Memory OLTP 引擎的設計目的是，在衍生自高度向外擴充中間層的 OLTP 類型交易發生極高的工作階段並行處理時使用。 
使用了不需閂鎖的資料結構，以及開放式、多版本的並行控制。 結果是可針對資料庫交易進行線性比例調整來產生可預期、亞毫秒低延遲及高輸送量。 實際效能獲益取決於許多因素，
通常可以獲得 5 到 20 倍的效能提升。

01.使用記憶體最佳化資料表的需求	         討論有關使用記憶體最佳化資料表的硬體和軟體需求以及方針。
02.在 VM 環境中使用記憶體中的 OLTP	     涵蓋在虛擬化環境中使用 In-Memory OLTP。
03.記憶體中 OLTP 程式碼範例	             包含程式碼範例，示範如何建立及使用記憶體最佳化資料表。
04.記憶體最佳化資料表	                 介紹記憶體最佳化的資料表。
05.記憶體最佳化資料表變數	             程式碼範例，示範如何使用記憶體最佳化的資料表變數取代傳統資料表變數，以減少 tempdb 的使用量。
06.記憶體最佳化資料表上的索引	         介紹記憶體最佳化索引。
07.原生編譯的預存程序	                 介紹原生編譯的預存程序。
08.為記憶體中的 OLTP 管理記憶體	         了解及管理系統上的記憶體使用量。
09.建立及管理記憶體最佳化物件的儲存體	     討論資料與差異檔案 (儲存記憶體最佳化之資料表中的交易資訊)。
10.備份、還原及復原記憶體最佳化資料表	     討論記憶體最佳化資料表的備份、還原及復原。
11.記憶體中 OLTP 的 Transact-SQL 支援	 討論適用於 Transact-SQL 的 In-Memory OLTP 支援。
12.記憶體內部 OLTP 資料庫的高可用性支援	 討論可用性群組與 In-Memory OLTP 中的容錯移轉叢集。
13.記憶體中 OLTP 的 SQL Server 支援	 列出為支援記憶體最佳化資料表新增和更新的語法和功能。   https://msdn.microsoft.com/zh-tw/library/dn133189(v=sql.120).aspx
14.移轉至 In-Memory OLTP	             討論如何將以磁碟為基礎的資料表移轉到記憶體最佳化的資料表


您可以檢查 sys.databases (Transact-SQL) 目錄檢視中的 is_memory_optimized_elevate_to_snapshot_on 資料行來判斷這個選項的目前設定。
https://msdn.microsoft.com/zh-tw/library/ms178534.aspx
當工作階段設定 TRANSACTION ISOLATION LEVEL 設定為較低的隔離等級 READ COMMITTED 或 READ UNCOMMITTED 時，會使用 SNAPSHOT 隔離存取記憶體最佳化的資料表。



ALTER DATABASE SET 選項 (Transact-SQL)
https://msdn.microsoft.com/zh-tw/library/bb522682.aspx
#--------------------------------------------------------------------------------
#   troubleshooting     Jul.22.2016
#--------------------------------------------------------------------------------
{<#

昨天期交所我們做全系統連線測試IN MEMORY時發現，除了  query之外，程式資料異動至 DB時

會發生錯誤訊息，訊息內容如下 ：

 

「只有自動認可交易支援使用 READ COMMITTED 隔離等級存取記體最佳化資料表。

明確或隱含交易則不支援。請使用如 WITH (SNAPSHOT)的資料表提示，

為記體最佳化資料表提供支援的隔離等級。」

https://msdn.microsoft.com/zh-tw/library/dn133175(v=sql.120).aspx
搭配記憶體最佳化的資料表使用交易隔離等級的方針
https://msdn.microsoft.com/zh-tw/library/dn133187(v=sql.120).aspx                                                                                                                                              

  
記憶體最佳化資料表交易的重試邏輯方針   https://msdn.microsoft.com/zh-tw/library/dn169141(v=sql.120).aspx

記憶體最佳化的資料表中的交易        https://msdn.microsoft.com/zh-tw/library/dn133169(v=sql.120).aspx




TRY 後，應是TRANSACTION問題，已試過把TRANSACTION語法拿掉，就可正常異動資料， 但程式不能不做 TRANSACTION。 因此程式改了幾種寫法(更改隔離等級)，還是沒辦法解決這問題，

建議這個問題需要熟悉資料庫設定的人盡快協助處理。                                                                                                                      

(資料庫應有屬性可設定解決這問題- SA權限人員才可設定)


<ANSWER>
--當工作階段設定 TRANSACTION ISOLATION LEVEL 設定為較低的隔離等級 READ COMMITTED 或 READ UNCOMMITTED 時，
--會使用 SNAPSHOT 隔離存取記憶體最佳化的資料表。
--https://msdn.microsoft.com/zh-tw/library/ms178534.aspx
SELECT name, is_memory_optimized_elevate_to_snapshot_on
FROM sys.databases;  --1 = 最低隔離等級為 SNAPSHOT。  0 = 不提高隔離等級。

-- testMonitdb2 is 0

--ALTER DATABASE SET 選項
--ON  :當交易隔離等級設為 SNAPSHOT 以下的任何隔離等級時 (例如 READ COMMITTED 或 READ UNCOMMITTED)，記憶體最佳化資料表上之所有解譯的 Transact-SQL 作業都會在 SNAPSHOT 隔離下執行。 不論是在工作階段層級明確設定交易隔離等級，或隱含使用預設值，都會這樣做。
--OFF : 不會為記憶體最佳化資料表之解譯的 Transact-SQL 作業提高交易隔離等級。
--ref https://msdn.microsoft.com/zh-tw/library/bb522682.aspx
ALTER DATABASE testMonitdb2
SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT ON;  
GO

-- testMonitdb2 is 1

#>}
#--------------------------------------------------------------------------------
#   create  new 
#--------------------------------------------------------------------------------
# 

USE [master]
GO

/****** Object:  Database [MONDB]    Script Date: 2016/3/31 下午 03:10:47 ******/
DROP DATABASE [MONDB]
GO




md c:\imFG #: inmemoryFileGroup

CREATE DATABASE [MONDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MONDB', FILENAME = N'D:\SQLDW\MONDB.mdf' , SIZE = 5120KB , FILEGROWTH = 1024KB ),
 
 FILEGROUP [imoltp_mon] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
( NAME = N'imoltp_mon1', FILENAME = N'c:\imFG\imoltp_mon1' , MAXSIZE = UNLIMITED)
 LOG ON 
( NAME = N'MONDB_log', FILENAME = N'D:\SQLDW\MONDB_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MONDB] SET COMPATIBILITY_LEVEL = 120
GO




#----------------------------------------------------------------------------------------
#    2138   inmemory  table sample  how to know  is_memory_optimized
#----------------------------------------------------------------------------------------

INSERT INTO [dbo].[Product1]([ID] ,[Code] ,[Description],[Price])VALUES ('1','1','diskbase','1')
INSERT INTO [dbo].[Product2]([ID] ,[Code] ,[Description],[Price])VALUES ('2','2','memorybase','2')
INSERT INTO [dbo].[Product3]([ID] ,[Code] ,[Description],[Price])VALUES ('3','3','memorybase','3')


CREATE TABLE [dbo].[Product1]
   (
     ID INT NOT NULL PRIMARY KEY,
     Code VARCHAR(10) NOT NULL ,
     Description VARCHAR(200) NOT NULL ,
     Price FLOAT NOT NULL
);
GO

GO

CREATE TABLE [dbo].[Product2]
   (
      ID INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000),
      Code nVARCHAR(10) NOT NULL,
      Description nVARCHAR(200) NOT NULL,
      Price FLOAT NOT NULL
   )WITH (MEMORY_OPTIMIZED = ON,
          DURABILITY = SCHEMA_AND_DATA);
GO

CREATE TABLE [dbo].[Product3]
   (
      ID INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000),
      Code nVARCHAR(10)  NOT NULL,
      Description nVARCHAR(200) NOT NULL,
      Price FLOAT NOT NULL
   )WITH (MEMORY_OPTIMIZED = ON,
          DURABILITY = SCHEMA_AND_DATA);
GO


select name,is_memory_optimized from sys.tables


select * from Product1
select * from Product2
select * from Product3

#--------------------------------------------------------------------------------
#   Database Backup with Memory-Optimized Tables
#--------------------------------------------------------------------------------
https://blogs.technet.microsoft.com/dataplatforminsider/2013/06/26/sql-server-2014-in-memory-technologies-blog-series-introduction/

https://blogs.technet.microsoft.com/dataplatforminsider/2014/02/05/database-backup-with-memory-optimized-tables/


#--------------------------------------------------------------------------------
#
#--------------------------------------------------------------------------------

USE [master]
GO
ALTER DATABASE [MONDB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
EXEC master.dbo.sp_detach_db @dbname = N'MONDB', @skipchecks = 'false'
GO












#--------------------------------------------------------------------------------
#  記憶體最佳化 Advisor
#--------------------------------------------------------------------------------

https://msdn.microsoft.com/zh-tw/library/dn284308.aspx




#--------------------------------------------------------------------------------
#  使用記憶體最佳化資料表的需求
#--------------------------------------------------------------------------------
https://msdn.microsoft.com/zh-tw/library/dn170449.aspx


#--------------------------------------------------------------------------------
#  探索記憶體最佳化的資料表大小
#--------------------------------------------------------------------------------
https://msdn.microsoft.com/zh-tw/library/dn169142.aspx
傳回目前資料庫中每個 In-Memory OLTP 資料表 (使用者和系統) 的記憶體使用量統計資料。 
系統資料表具有負數物件識別碼，並且用於儲存 In-Memory OLTP 引擎的執行階段資訊。 

與使用者物件不同的是，系統資料表為內部物件且只存在於記憶體中，因而無法透過目錄檢視查看。 
系統資料表是用以儲存資訊，例如儲存體中所有資料/差異檔案的中繼資料、合併要求、差異檔案用於篩選資料列的標準、已卸除的資料表，以及復原與備份的相關資訊。 
假設 In-Memory OLTP 引擎最多可以有 8,192 個資料檔案和差異檔案組，若是大型的記憶體中資料庫，系統資料表佔用的記憶體可能只有數 MB 之多

查詢下列 DMV，取得配置給資料庫內之資料表和索引的記憶體：
-- finding memory for objects
SELECT OBJECT_NAME(object_id), * 
FROM sys.dm_db_xtp_table_memory_stats;

#--------------------------------------------------------------------------------
#  判斷是否應將資料表或預存程序匯出至記憶體中 OLTP
#--------------------------------------------------------------------------------
Determining if a Table or Stored Procedure Should Be Ported to In-Memory OLTP
https://msdn.microsoft.com/en-us/library/dn205133.aspx
https://msdn.microsoft.com/zh-tw/library/dn205133.aspx





#--------------------------------------------------------------------------------
#   272   示範：記憶體中 OLTP 的效能改善
#--------------------------------------------------------------------------------
{<#
步驟 1a︰使用 SQL Server 時的必要條件
  
CREATE DATABASE imoltp;    --  Transact-SQL  
go  
  
select * from sys.master_files where database_id =DB_ID('imoltp')


use imoltp
SELECT  sdf.name AS [FileName],size/128 AS [Size_in_MB],fg.name AS [File_Group_Name] 
 FROM sys.database_files sdf INNER JOIN sys.filegroups fg ON sdf.data_space_id=fg.data_space_id

ALTER DATABASE imoltp ADD FILEGROUP [imoltp_mod]   CONTAINS MEMORY_OPTIMIZED_DATA;  
  
ALTER DATABASE imoltp ADD FILE  (name = [imoltp_dir], filename= 'c:\data\imoltp_dir')  TO FILEGROUP imoltp_mod;  
go  
  
USE imoltp;  
go 

SELECT  sdf.name AS [FileName],size/128 AS [Size_in_MB],fg.name AS [File_Group_Name] 
 FROM sys.database_files sdf INNER JOIN sys.filegroups fg ON sdf.data_space_id=fg.data_space_id


 <步驟 2：建立記憶體最佳化資料表和 NCSProc>

 go  
DROP PROCEDURE IF EXISTS ncsp;  
DROP TABLE IF EXISTS sql;  
DROP TABLE IF EXISTS hash_i;  
DROP TABLE IF EXISTS hash_c;  
go  
  
CREATE TABLE [dbo].[sql] (  
  c1 INT NOT NULL PRIMARY KEY,  
  c2 NCHAR(48) NOT NULL  
);  
go  
  
CREATE TABLE [dbo].[hash_i] (  
  c1 INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT=1000000),  
  c2 NCHAR(48) NOT NULL  
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY = SCHEMA_AND_DATA);  
go  
  
CREATE TABLE [dbo].[hash_c] (  
  c1 INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT=1000000),  
  c2 NCHAR(48) NOT NULL  
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY = SCHEMA_AND_DATA);  
go  
  
CREATE PROCEDURE ncsp  
    @rowcount INT,  
    @c NCHAR(48)  
  WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER  
  AS   
  BEGIN ATOMIC   
  WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english')  
  DECLARE @i INT = 1;  
  WHILE @i <= @rowcount  
  BEGIN;  
    INSERT INTO [dbo].[hash_c] VALUES (@i, @c);  
    SET @i += 1;  
  END;  
END;  
go  
 
select name,is_memory_optimized from sys.tables

<步驟 3︰執行程式碼>

go  
SET STATISTICS TIME OFF;  
SET NOCOUNT ON;  
  
-- Inserts, one at a time.  
  
DECLARE @starttime DATETIME2 = sysdatetime();  
DECLARE @timems INT;  
DECLARE @i INT = 1;  
DECLARE @rowcount INT = 100000;  
DECLARE @c NCHAR(48) = N'12345678901234567890123456789012345678';  
  
-- Harddrive-based table and interpreted Transact-SQL.  
  
BEGIN TRAN;  
  WHILE @i <= @rowcount  
  BEGIN;  
    INSERT INTO [dbo].[sql] VALUES (@i, @c);  
    SET @i += 1;  
  END;  
COMMIT;  
  
SET @timems = datediff(ms, @starttime, sysdatetime());  
SELECT 'A: Disk-based table and interpreted Transact-SQL: '  
    + cast(@timems AS VARCHAR(10)) + ' ms';  
  
-- Interop Hash.  
  
SET @i = 1;  
SET @starttime = sysdatetime();  
  
BEGIN TRAN;  
  WHILE @i <= @rowcount  
    BEGIN;  
      INSERT INTO [dbo].[hash_i] VALUES (@i, @c);  
      SET @i += 1;  
    END;  
COMMIT;  
  
SET @timems = datediff(ms, @starttime, sysdatetime());  
SELECT 'B: memory-optimized table with hash index and interpreted Transact-SQL: '  
    + cast(@timems as VARCHAR(10)) + ' ms';  
  
-- Compiled Hash.  
  
SET @starttime = sysdatetime();  
  
EXECUTE ncsp @rowcount, @c;  
  
SET @timems = datediff(ms, @starttime, sysdatetime());  
SELECT 'C: memory-optimized table with hash index and native SP:'  
    + cast(@timems as varchar(10)) + ' ms';  
go  
  
DELETE sql;  
DELETE hash_i;  
DELETE hash_c;  
go  
select * from  sql
select * from  hash_i
select * from  hash_c

A: Disk-based table and interpreted Transact-SQL: 2789 ms
B: memory-optimized table with hash index and interpreted Transact-SQL: 4059 ms
C: memory-optimized table with hash index and native SP:2337 ms

#>}