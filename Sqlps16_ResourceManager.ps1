<#Sqlps16_ResourceManager

 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 history : 
 object : tsql

 CH10_使用資源管理員.sql

#>


-------------------------------------------------------------------
--範例程式碼10-1：使用sp_configure啟用「專用管理員連接(DAC)」的遠端連線功能
-------------------------------------------------------------------
/*
根據預設，DAC 只會接聽回送IP位址 (127.0.0.1)、通訊埠 1434。

使用 sp_configure 將「remote admin connections」選項，設定為1。

remote admin connections 設定的可能值：
0 - 表示只允許本機連接使用 DAC
1 - 表示允許遠端連接使用 DAC
*/
--01 查詢是否已經啟用「專用管理員連接(DAC)」的遠端連線功能
SELECT name N'組態選項的名稱', value N'針對這個選項所設定的值', value_in_use N'這個選項目前有效的執行值',  
 description N'組態選項的描述'  
FROM sys.configurations  
WHERE name='remote admin connections'  
  
--02 設定啟用「專用管理員連接(DAC)」的遠端連線功能  
USE master
GO
sp_configure 'remote admin connections', 1;
GO
RECONFIGURE;
GO
  
--03 再度查詢是否已經啟用「專用管理員連接(DAC)」的遠端連線功能
SELECT name N'組態選項的名稱', value N'針對這個選項所設定的值', value_in_use N'這個選項目前有效的執行值',  
 description N'組態選項的描述'  
FROM sys.configurations  
WHERE name='remote admin connections'  

-------------------------------------------------------------------
--範例程式碼10-2：建立純量函數
-------------------------------------------------------------------
-- 建立純量函數(scalar function)
USE master
GO
-- 設定「資源管理員」不使用「分類函數」
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL);
GO
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnClassifierUser]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnClassifierUser]
GO
CREATE FUNCTION dbo.fnClassifierUser()
	RETURNS sysname 
	WITH SCHEMABINDING
AS
BEGIN
	RETURN
  (SELECT CASE SUSER_SNAME()
						WHEN 'rs01' THEN 'Report Group'
						WHEN 'erp01' THEN 'ERP Group'
					ELSE 'default' 
					END
  );
END
GO

-------------------------------------------------------------------
--範例程式碼10-3：建立登入帳戶與相關物件
-------------------------------------------------------------------
--01 建立登入帳戶：epr01 與 rs01
USE master
GO
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'erp01')
DROP LOGIN [erp01]
GO
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'rs01')
DROP LOGIN [rs01]
GO
CREATE LOGIN erp01 WITH PASSWORD = 'P@$$w0rderp01', CHECK_POLICY = OFF
GO
CREATE LOGIN rs01 WITH PASSWORD = 'P@$$w0rdrs01', CHECK_POLICY = OFF
GO

--02 建立耗用CPU資源的預存程序：up_Intensive01 與 up_Intensive02
USE tempdb
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Intensive01]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Intensive01]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Intensive02]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Intensive02]
GO
CREATE PROCEDURE up_Intensive01
AS
	DECLARE @dbname SYSNAME, @datetime2 datetime2
WHILE 1=1
BEGIN
	SET @dbname = DB_NAME();
	SET @datetime2 = SYSDATETIME();
END
GO
CREATE PROCEDURE up_Intensive02
AS
	DECLARE @appname SYSNAME, @datetimeoffset datetimeoffset
WHILE 1=1
BEGIN
	SET @appname = APP_NAME();
	SET @datetimeoffset = SYSDATETIMEOFFSET();
END
GO

--03 賦予登入帳戶具備執行預存程序的權限
USE [tempdb]
GO
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'erp01')
DROP USER [erp01]
GO
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'rs01')
DROP USER [rs01]
GO
CREATE USER [erp01] FOR LOGIN [erp01]
GO
CREATE USER [rs01] FOR LOGIN [rs01]
GO
GRANT EXECUTE ON [dbo].[up_Intensive01] TO [erp01]
GO
GRANT EXECUTE ON [dbo].[up_Intensive02] TO [rs01]
GO

--04 賦予登入帳戶隸屬於資料庫Northwind的資料庫角色：db_datareader
USE [Northwind]
GO
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'erp01')
DROP USER [erp01]
GO
CREATE USER [erp01] FOR LOGIN [erp01]
GO
USE [Northwind]
GO
EXEC sp_addrolemember N'db_datareader', N'erp01'
GO

-------------------------------------------------------------------
--範例程式碼10-4：使用登入帳戶rs01執行預存程序
-------------------------------------------------------------------
sqlcmd -U rs01 -P P@$$w0rdrs01 -Q "EXEC tempdb.dbo.up_Intensive02"

-------------------------------------------------------------------
--範例程式碼10-5：觀察執行個體上的CPU排程器之相關資訊
-------------------------------------------------------------------
-- 觀察執行個體上的CPU排程器之相關資訊
/* sys.dm_os_schedulers (Transact-SQL) 

排程器的識別碼：
1. 所有用來執行一般查詢的排程器，其識別碼都小於 255。
2. 大於或等於 255 的排程器是 SQL Server 內部使用的排程器。
3. 255：代表專用管理員連接 (DAC)。
4. 識別碼 >= 255 的排程器稱為隱藏排程器。
5. 協調記憶體壓力的資源監視器會使用排程器 257 和排程器 258，每個 NUMA 節點各一個。

排程器的狀態：
1. HIDDEN 排程器用來處理 Database Engine 內部的要求。VISIBLE 排程器用來處理使用者要求。
2. OFFLINE 排程器對應到相似性遮罩中離線的處理器，因此不會用來處理任何要求。ONLINE 排程器對應到相似性遮罩中上線的處理器，可以用來處理執行緒。
3. DAC 指出排程器正在專用管理員連接下執行。

SQL Server 是否可以使用此處理器( is_online )：
在執行個體上，可以設定利用相似性遮罩，設定是否要使用此處理器。
*/
USE master
GO
SELECT scheduler_id N'排程器的識別碼', cpu_id N'與排程器之關聯 CPU 的識別碼', 
	status N'排程器的狀態', is_online N'SQL Server 是否可以使用此處理器'
FROM sys.dm_os_schedulers
GO

-------------------------------------------------------------------
--範例程式碼10-6：查詢各個「工作階段」，被歸類到哪一個「工作負載群組」
-------------------------------------------------------------------
-- 查詢各個「工作階段」，被歸類到哪一個「工作負載群組」
USE master
GO
SELECT s.session_id N'工作階段的識別碼', s.login_name N'登入帳戶',  status N'工作階段的狀態', g.name N'工作負載群組'
FROM sys.dm_exec_sessions s INNER JOIN sys.dm_resource_governor_workload_groups g
	ON s.group_id = g.group_id
WHERE s.session_id > 50
GO

-------------------------------------------------------------------
--範例程式碼10-7：觀察「工作階段」、「工作負載群組」、「 排程器」之間的關係
-------------------------------------------------------------------
--觀察「工作階段」、「工作負載群組」、「排程器」之間的關係
SELECT r.session_id N'工作階段的識別碼', s.login_name N'登入帳戶' , r.status N'工作階段的狀態', g.name N'工作負載群組', t.scheduler_id N'父排程器的識別碼'
FROM sys.dm_exec_requests r INNER JOIN sys.dm_os_tasks t
	ON r.task_address = t.task_address
	INNER JOIN sys.dm_resource_governor_workload_groups g
	ON r.group_id = g.group_id
	INNER JOIN sys.dm_exec_sessions s
	ON r.session_id = s.session_id
WHERE r.session_id>50

-------------------------------------------------------------------
--範例程式碼10-8：使用登入帳戶erp01執行預存程序
-------------------------------------------------------------------
sqlcmd -U erp01 -P P@$$w0rderp01 -Q "EXEC tempdb.dbo.up_Intensive01"

-------------------------------------------------------------------
--範例程式碼10-9：使用登入帳戶erp01執行「交叉聯結(CROSS JOIN)」
-------------------------------------------------------------------
sqlcmd -U erp01 -P P@$$w0rderp01 -Q " SELECT * FROM Northwind.dbo.Orders, Northwind.dbo.[Order Details], Northwind.dbo.[Products]"

