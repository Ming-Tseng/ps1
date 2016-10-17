 <#   SQLPS0501_DMV_Transcation
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 history : from SQLPS05_DMV for Lock , deaklock  Lab

 object : tsql 

#>



#-------------------------
# Transaction processing pattern
#-------------------------

<#BEGIN TRY
    BEGIN TRAN
    SELECT 1/0
    PRINT 'Success'
    COMMIT
END TRY
    BEGIN CATCH
    ROLLBACK
PRINT 'An error has occurred'
END CATCH
#>




#-------------------------
# Creating the sample database and table
#-------------------------
CREATE DATABASE IWS_Temp
GO
USE IWS_Temp
CREATE TABLE [dbo].[tblCountry](
[CountryId] [int] IDENTITY(1,1) NOT NULL,
[Code] [char](3) NOT NULL,
[Description] [varchar](50) NOT NULL)




#-------------------------
# Starting an open transaction
#-------------------------
USE IWS_TEMP
BEGIN TRANSACTION
INSERT INTO [dbo].[tblCountry] ([Code], [Description])
VALUES('ENG', 'ENGLAND')

#-------------------------
# Selecting data from a table that has an open transaction against it
#-------------------------
USE IWS_TEMP
SELECT * FROM [dbo].[tblCountry]



#-------------------------
# Observing the current locks
#-------------------------
SELECT DB_NAME(resource_database_id) AS DatabaseName, request_session_id
, resource_type, request_status, request_mode
FROM sys.dm_tran_locks
WHERE request_session_id !=@@spid
ORDER BY request_session_id


#-------------------------
# sys.dm_tran_locks 
#-------------------------
select DB_name(database_id),*  FROM sys.dm_tran_database_transactions
select *  FROM sys.dm_tran_locks
select *  FROM sys.dm_os_waiting_tasks

SELECT resource_type  as [資源類型]
,resource_associated_entity_id  as [資料庫識別碼]
,request_status as [目前狀態]
, request_mode  as [要求的模式]
,request_session_id  as [工作階段識別碼]
,resource_description  as [資源的描述]
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID('tempdb')


SELECT object_name(object_id), *
    FROM sys.partitions
    WHERE hobt_id=3674937297983438848


SELECT 
        t1.resource_type,
        t1.resource_database_id,
        t1.resource_associated_entity_id,
        t1.request_mode,
        t1.request_session_id,
        t2.blocking_session_id
    FROM sys.dm_tran_locks as t1
    INNER JOIN sys.dm_os_waiting_tasks as t2
        ON t1.lock_owner_address = t2.resource_address;

	



#-------------------------
# 
#-------------------------