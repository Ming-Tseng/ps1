
<#Sqlps17_trigger
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps17_triggers.ps1
C:\Users\administrator.CSD\SkyDrive\download\PS1\Sqlps17_triggers.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Aug.13.2014
 history : 
 object : tsql

 DML trigger
 DDL 
 eventvwr

 $ps1fS=gi C:\Users\administrator.CSD\SkyDrive\download\PS1\Sqlps17_triggers.ps1
foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname=$ps1f.name
    $ps1fFullname=$ps1f.FullName 
    $ps1flastwritetime=$ps1f.LastWriteTime
    $getdagte= get-date -format yyyyMMdd
    $ps1length=$ps1f.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length "  -Body "  ps1source from:me $ps1fname   " 
}
#>












#  50  DML trigger  新增更改刪除 another Table
#  200 DDL trigger   
#  300  RAISERROR 透過對 CREATE_TABLE 事件建立觸發程序，記錄建立者的帳號到 Windows Event Log
#  350  DDL 觸發程序搭配資料表記錄使用者對資料庫的變更動作
#   400   sys.messages 目錄檢檢視
#  485   登入觸發程序  Logon Triggers#  513   creating a DDL trigger for the CREATE LOGIN facet which sends an email via sp_send_dbmail
#  535  使用 EVENTDATA 函數 
#  607 DML  trigger  for DGPA 














#---------------------------------------------------------------
#  50  DML trigger  新增更改刪除 another Table
#---------------------------------------------------------------
{<#
##Table_1  (ID ,Textfield1, Field1 )
##Table_2  (ID ,Textfield1)
當Table2_ 新增更改.將 [table2 的欄位] 合併   [table1 的欄位]  Update Table_1
當Table_2  刪除時.同步刪除 Table_1   同一筆為pk



USE [D1]
GO

/****** Object:  Table [dbo].[Table_1]    Script Date: 8/13/2014 9:57:37 AM ******/
DROP TABLE [dbo].[Table_1]
GO

/****** Object:  Table [dbo].[Table_1]    Script Date: 8/13/2014 9:57:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Table_1](
	[ID] [nchar](10) NULL,
	[Textfield1] [nvarchar](50) NULL,
	[Field1] [nvarchar](50) NULL
) ON [PRIMARY]

GO


USE [D1]
GO

/****** Object:  Table [dbo].[Table_2]    Script Date: 8/13/2014 9:58:32 AM ******/
DROP TABLE [dbo].[Table_2]
GO

/****** Object:  Table [dbo].[Table_2]    Script Date: 8/13/2014 9:58:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Table_2](
	[ID] [nchar](10) NULL,
	[Textfield2] [nvarchar](50) NULL
) ON [PRIMARY]

GO



##

USE [D1]
GO

/****** Object:  Trigger [trTable2_Change]    Script Date: 8/13/2014 10:03:10 AM ******/
DROP TRIGGER [dbo].[trTable2_Change]
GO

/****** Object:  Trigger [dbo].[trTable2_Change]    Script Date: 8/13/2014 10:03:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[trTable2_Change]  ON [dbo].[Table_2] AFTER INSERT, UPDATE
  AS
UPDATE Table_1 SET Field1 = Table_1.TextField1 + I.TextField2
FROM Table_1 INNER JOIN Inserted I ON Table_1.ID = I.ID

GO


##
USE [D1]
GO

/****** Object:  Trigger [trTable2_Delete]    Script Date: 8/13/2014 10:03:39 AM ******/
DROP TRIGGER [dbo].[trTable2_Delete]
GO

/****** Object:  Trigger [dbo].[trTable2_Delete]    Script Date: 8/13/2014 10:03:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[trTable2_Delete] 
ON [dbo].[Table_2] 
AFTER DELETE
AS
delete from  Table_1  where ID = (SELECT ID FROM DELETED)
GO

####### test 
truncate table Table_1
truncate table Table_2

select * from Table_1
select * from Table_2

insert into Table_1 values ('a','t1a','t1af')
insert into Table_1 values ('b','t1b','t1bf')
insert into Table_1 values ('c','t1c','t1cf')


insert into Table_2 values ('a','t2a')

delete from  Table_2  where ID ='c'

insert into Table_2 values ('c','t2c')

update  Table_2 set ID='c' where ID='c'

#>}
#---------------------------------------------------------------#  200 DDL trigger   #---------------------------------------------------------------#{<###------ Get Trigger 查詢觸發程序 關的管理資訊
       SELECT * FROM sys.server_triggers   SELECT * FROM sys.triggers    #--檢視觸發程序的語法定義
   SELECT definition FROM sys.sql_modules 
   WHERE [object_id]=
    (SELECT [object_id] FROM sys.triggers
    WHERE name=’ safety’)
    GO##------ CreateCREATE TRIGGER ddl_trig_database 
ON ALL SERVER 
FOR CREATE_DATABASE 
AS 
    PRINT 'Database Created.'
    SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
GO
DROP TRIGGER ddl_trig_database
ON ALL SERVER;
GO##------ set ##------ enable
啟用 DDL 觸發程序
ENABLE TRIGGER (Transact-SQL)
ALTER TABLE (Transact-SQL)            #啟用在伺服器範圍建立的所有 DDL 觸發程序            USE AdventureWorks2012;
                GO
            ENABLE Trigger ALL ON ALL SERVER;
            GO##------ disable 停用 DDL 觸發程序
DISABLE TRIGGER (Transact-SQL)
ALTER TABLE (Transact-SQL)USE AdventureWorks2012;
GO
DISABLE TRIGGER Person.uAddress ON Person.Address;
GO
ENABLE Trigger Person.uAddress ON Person.Address;
GO##------ Drop  IF EXISTS (SELECT * FROM sys.server_triggers  WHERE name = 'ddl_trig_database')
DROP TRIGGER ddl_trig_database
ON ALL SERVER;
GODROP TRIGGER safety
ON DATABASE;## example 每當資料庫中發生 DROP_TABLE 或 ALTER_TABLE 事件時，就會引發 DDL 觸發程序 safety     資料庫範圍建立 DDL 觸發程序 safety，然後再停用它     透過 ROLLBACK 放棄掉對資料物件定義所做的變更use M1
IF EXISTS (SELECT * FROM sys.triggers WHERE parent_class = 0 AND name = 'safety')
DROP TRIGGER safety ON DATABASE;
GO

CREATE TRIGGER safety 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
   PRINT 'You must disable Trigger "safety" to drop or alter tables!' 
   ROLLBACK;
GO


SELECT * FROM sys.triggers
    WHERE parent_class = 0 AND name = 'safety'
GO

DISABLE TRIGGER safety ON DATABASE;
GO
ENABLE TRIGGER safety ON DATABASE;
GO


##--範例程式碼9-4：利用 DDL觸發程序避免資料表被刪除

ALTER TRIGGER safety 
ON DATABASE 
FOR DROP_TABLE
AS 
DECLARE @data XML =EVENTDATA()
DECLARE @SchemaName nvarchar(max)
DECLARE @TableName nvarchar(max)
SET @SchemaName=EVENTDATA().value('(/EVENT_INSTANCE/SchemaName)[1]','sysname')
SET @TableName=EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','sysname')
IF @SchemaName = 'dbo' AND @TableName ='Order Details'
BEGIN
	DECLARE @msg NVARCHAR(MAX)=N'你不能刪除這個資料表：['+ @SchemaName + '].[' + @TableName + ']'
	RAISERROR (@msg,16,1)
	ROLLBACK TRAN
END
GO


#>}

#-------------------------------------------------------------------
#- 300  RAISERROR 透過對 CREATE_TABLE 事件建立觸發程序，記錄建立者的帳號到 Windows Event Log
#-------------------------------------------------------------------
#{<#
RAISERROR ( { msg_id | msg_str | @local_variable }
    { ,severity ,state }
    [ ,argument [ ,...n ] ] )
    [ WITH option [ ,...n ] ]
severity :0 到 18 的嚴重性層級。 從 19 到 25 的嚴重性層級只能由系統管理員 (sysadmin) 固定伺服器角色成員或具有 ALTER TRACE 權限的使用者指定。 因為從 19 到 25 的嚴重性層級需要 WITH LOG 選項。 小於 0 的嚴重性層級會被解譯為 0。 大於 25 的嚴重性層級會被解譯為 25。
argument:這些參數是用於 msg_str 或對應於 msg_id 的訊息中所定義變數的替代。 可以有 0 或更多的替代參數，但是替代參數的總數不能超過 20。 每一個替代參數都可以是區域變數或以下任何資料類型：tinyint、smallint、int、char、varchar、nchar、nvarchar、binary 或 varbinary。 不支援其他資料類型。
option : Microsoft SQL Server Database Engine 執行個體的錯誤記錄檔和應用程式記錄檔中記錄錯誤。 記錄在錯誤記錄檔中的錯誤目前最大限制為 440 位元組。 只有系統管理員 (sysadmin) 固定伺服器角色成員，或具有 ALTER TRACE 權限的使用者可以指定 WITH LOG。


## RAISERROR 陳述式中，N'number' 的第一個引數會取代 %s 的第一個轉換規格，而第二個引數 5 則會取代 %d. 的第二個轉換規格。
RAISERROR (N'This is message %s %d.', -- Message text.
           10, -- Severity,
           1, -- State,
           N'number', -- First argument.
           5); -- Second argument.
-- The message text returned is: This is message number 5.
GO

RAISERROR (N'<<%*.*s>>', -- Message text.
           10, -- Severity,
           1, -- State,
           7, -- First argument used for width.
           3, -- Second argument used for precision.
           N'abcde'); -- Third argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
RAISERROR (N'<<%7.3s>>', -- Message text.
           10, -- Severity,
           1, -- State,
           N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO

##TRY 區塊內使用 RAISERROR，使執行位置跳到相關聯的 CATCH 區塊。 這個範例也會顯示如何利用 RAISERROR，來傳回叫用 CATCH 區塊之錯誤的相關資訊
BEGIN TRY
    -- RAISERROR with severity 11-19 will cause execution to 
    -- jump to the CATCH block.
    RAISERROR ('Error raised in TRY block.', -- Message text.
               16, -- Severity.
               1 -- State.
               );
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;

##使用本機變數為 RAISERROR 陳述式提供訊息文字
DECLARE @StringVariable NVARCHAR(50);
SET @StringVariable = N'<<%7.3s>>';

RAISERROR (@StringVariable, -- Message text.
           10, -- Severity,
           1, -- State,
           N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
##--有任何人新增資料表，就將他記錄到 Windows 的 event log
CREATE TRIGGER reminder
ON DATABASE
FOR CREATE_TABLE 
AS
   DECLARE @str NVARCHAR(100)
   SET @str=suser_sname() +N' 新建立了一個資料表'
   RAISERROR(@str,10,1) WITH LOG
GO

You can do a variety of Error logging methods here in this way -
1 ) send email
2 ) write to table
3 ) log to sql via RAISERROR (as abover)


Read more: http://sqlsolace.blogspot.com/2010/12/logging-errors-to-sql-logs-via.html#ixzz3gPVNcUh7

ERROR_NUMBER() - returns the number of the error.
ERROR_SEVERITY() - returns the severity.
ERROR_STATE() - returns the error state number.
ERROR_PROCEDURE() - returns the name of the stored procedure or trigger where the error occurred.
ERROR_LINE() - returns the line number inside the routine that caused the error.
ERROR_MESSAGE() - returns the complete text of the error message. The text includes the values supplied for any substitutable parameters, such as lengths, object names, or times.

Read more: http://sqlsolace.blogspot.com/2010/12/logging-errors-to-sql-logs-via.html#ixzz3gPVIEhcn

## exanoke


#>}
#-------------------------------------------------------------------
#  350  DDL 觸發程序搭配資料表記錄使用者對資料庫的變更動作
#-------------------------------------------------------------------
{<#
--透過 EVENTDATA 函數取得 DDL 執行時相關的環境資料
--並透過 XQuery 解析內容，另外存放到資料表中
USE Northwind;
GO
CREATE TABLE tblDdlLog (
PostTime datetime2(3) DEFAULT(SYSDATETIME()),
LoginName nvarchar(100),
DB_User nvarchar(100),Object sysname, 
Event nvarchar(100), 
TSQL nvarchar(2000),
EventData XML);
GO

CREATE TRIGGER log 
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS 
AS
DECLARE @data XML = EVENTDATA()
INSERT tblDdlLog 
   (LoginName, DB_User, Object, Event, TSQL, EventData) 
   VALUES 
   ( 
   CONVERT(nvarchar(100), @data.query('data(//LoginName)')),
   CONVERT(nvarchar(100), CURRENT_USER), 
   CONVERT(sysname,@data.query('data(//ObjectName)')), 
   CONVERT(nvarchar(100), @data.query('data(//EventType)')),
   CONVERT(nvarchar(2000), @data.query('data(//TSQLCommand)')),
	@data) ;
GO

--測試先前建立的觸發程序
CREATE TABLE TestTable (a int)
ALTER TABLE TestTable Add b nvarchar(10)
DROP TABLE TestTable ;
GO
--查詢記錄的結果
SELECT * FROM tblDdlLog ;


#>}
#-------------------------------------------------------------------
#   400   sys.messages 目錄檢檢視
#-------------------------------------------------------------------
select * from sys.messages 

#用 sp_addmessage 系統預存程序，將訊息編號為 50005 的訊息加入至 sys.messages 目錄檢視中。

sp_addmessage @msgnum = 50005,
              @severity = 10,
              @msgtext = N'<<%7.3s>>';
GO
RAISERROR (50005, -- Message id.
           10, -- Severity,
           1, -- State,
           N'abcde'); -- First argument supplies the string.
-- The message text returned is: <<    abc>>.
GO
sp_dropmessage @msgnum = 50005;
GO


#---------------------------------------------------------------#   DDL Events list #---------------------------------------------------------------
https://msdn.microsoft.com/en-us/library/bb522542.aspx

# Server or Database Scope
CREATE_LOGIN
ALTER_LOGIN
DROP_LOGIN

# Server Scope

#---------------------------------------------------------------#  485   登入觸發程序  Logon Triggers   Jul.24.2015#---------------------------------------------------------------
https://msdn.microsoft.com/zh-tw/library/bb326598.aspx
 當 SQL Server 執行個體建立使用者工作階段時，就會引發這個事件。 登入觸發程序會在登入驗證階段結束之後，但在使用者工作階段實際建立之前引發
#如果登入 login_test 已經建立三個使用者工作階段，登入觸發程序就會拒絕該登入對 SQL Server 所起始的登入嘗試。
USE master;
GO
CREATE LOGIN login_test WITH PASSWORD = '3KHJ6dhx(0xVYsdf' MUST_CHANGE,
    CHECK_EXPIRATION = ON;
GO
GRANT VIEW SERVER STATE TO login_test;
GO

CREATE TRIGGER connection_limit_trigger
ON ALL SERVER WITH EXECUTE AS 'login_test'
FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'login_test' AND
    (SELECT COUNT(*) FROM sys.dm_exec_sessions
            WHERE is_user_process = 1 AND
                original_login_name = 'login_test') > 3
    ROLLBACK;
END;


#---------------------------------------------------------------#  513   creating a DDL trigger for the CREATE LOGIN facet which sends an email via sp_send_dbmail    Jul.24.2015#---------------------------------------------------------------
CREATE TRIGGER LoginCreateTrigger ON ALL SERVER
FOR CREATE_LOGIN
AS
BEGIN
	DECLARE @data XML;
	SET @data = EVENTDATA();
	EXECUTE MSDB.DBO.sp_send_dbmail @profile_name = , @recipients = '', @subject = 'Login Created Alert', @body = @data, @body_format = 'HTML'
END


CREATE TRIGGER LoginCreateTrigger ON ALL SERVER
FOR CREATE_LOGIN
AS
BEGIN
	DECLARE @data XML;
	SET @data = EVENTDATA();
    Print @data 
END

Drop TRIGGER LoginCreateTrigger

#---------------------------------------------------------------#  535  使用 EVENTDATA 函數      Jul.24.2015#---------------------------------------------------------------https://msdn.microsoft.com/zh-tw/library/ms187909.aspx
eventvwr
#----------------------------
USE [master]
GO
CREATE LOGIN [su5] WITH PASSWORD=N'1234asdf', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [su5]
GO

drop login su5 
#-----------
CREATE TRIGGER LoginCreateTrigger ON ALL SERVER
FOR CREATE_LOGIN
AS
BEGIN
	DECLARE @data XML;
	SET @data = EVENTDATA();
	select @data
END
#----------------------------
CREATE TRIGGER LoginCreateTrigger ON ALL SERVER
FOR CREATE_LOGIN
AS
BEGIN
	DECLARE @createloginName nvarchar(max);
	DECLARE @whologinName nvarchar(max);
	--SET @cloginName = EVENTDATA();
	--select @data
	Set @whologinName= EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
    Set @createloginName=EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)')
    Print @whologinName +'create login'+@createloginName 
	--ROLLBACK
    RAISERROR(@createloginName,10,1) WITH LOG
END

drop TRIGGER LoginCreateTrigger  ON ALL SERVER
#----------------------------

<EVENT_INSTANCE>
  <EventType>CREATE_LOGIN</EventType>
  <PostTime>2015-07-25T21:32:33.057</PostTime>
  <SPID>54</SPID>
  <ServerName>SP2013</ServerName>
  <LoginName>CSD\administrator</LoginName>
  <ObjectName>su5</ObjectName>
  <ObjectType>LOGIN</ObjectType>
  <DefaultLanguage>us_english</DefaultLanguage>
  <DefaultDatabase>master</DefaultDatabase>
  <LoginType>SQL Login</LoginType>
  <SID>Twa20eHh8E2uS8H+93ujgA==</SID>
  <TSQLCommand>
    <SetOptions ANSI_NULLS="ON" ANSI_NULL_DEFAULT="ON" ANSI_PADDING="ON" QUOTED_IDENTIFIER="ON" ENCRYPTED="FALSE" />
    <CommandText>CREATE LOGIN [su5] WITH PASSWORD=N'******', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
</CommandText>
  </TSQLCommand>
</EVENT_INSTANCE>
RAISERROR('Test of custom error logging', 18, 1) WITH LOG 


#-------------------------------------------------------------------
#  607 DML  trigger  for DGPA 
#-------------------------------------------------------------------

# UPDATE    if     exists(SELECT * from inserted) and exists (SELECT * from deleted)
# INserted  if     exists(SELECT * from inserted) and not exists (SELECT * from deleted)
# Delete    if not exists(SELECT * from inserted) and exists (SELECT * from deleted)
create trigger [dbo].[UpdateRestable]
on [dbo].[ResTable]
After update
as
declare @idno nvarchar(12)
--20150112 create by Ming 
Begin

if exists(SELECT * from inserted) and exists (SELECT * from deleted)
	--SET @activity = 'UPDATE';
	SELECT @idno = b02idno from inserted i;   
    begin
    if (select count(b02idno) from  [dbo].[ResTable]  where B02IDNO=@idno and B02SEDORG='$GetDN' )=1
    	BEGIN	
    INSERT INTO NHRDB.[dbo].[SyncQueue]([SyncTable],[DBName],[SyncIDno],[SyncStatus],[SyncModTime])
    VALUES('Restable','$GetDName',@idno,0,GETDATE())
		END
	END

if exists(SELECT * from inserted) and not exists (SELECT * from deleted)
    SET @activity = 'INserted';
	SELECT @idno = b02idno from inserted i;   
    begin
    if (select count(b02idno) from  [dbo].[ResTable]  where B02IDNO=@idno and B02SEDORG='$GetDN' )=1
    	BEGIN	
    INSERT INTO NHRDB.[dbo].[SyncQueue]([SyncTable],[DBName],[SyncIDno],[SyncStatus],[SyncModTime])
    VALUES('Restable','$GetDName',@idno,0,GETDATE())
	
		END
	END

  if not exists(SELECT * from inserted) and exists (SELECT * from deleted)
    SET @activity = 'Delete';
	SELECT @idno = b02idno from inserted i;   
    begin
    if (select count(b02idno) from  [dbo].[ResTable]  where B02IDNO=@idno and B02SEDORG='$GetDN' )=1
    	BEGIN	
    INSERT INTO NHRDB.[dbo].[SyncQueue]([SyncTable],[DBName],[SyncIDno],[SyncStatus],[SyncModTime])
    VALUES('Restable','$GetDName',@idno,0,GETDATE())
	END
	END
END
GO

#-------------------------------------------------------------------
#http://sqlsolace.blogspot.tw/2010/12/logging-errors-to-sql-logs-via.html
#-------------------------------------------------------------------
RAISERROR('Test of custom error logging', 18, 1) WITH LOG 


BEGIN TRY  
   BEGIN TRANSACTION   
  
 -- Do action that we want rolled back if an error occurs  
 DELETE Person.Address WHERE AddressID = 1    
  
   COMMIT  
END TRY  
  
BEGIN CATCH  
  IF @@TRANCOUNT > 0  
     ROLLBACK  
  
 DECLARE @ErrorMessage NVARCHAR(4000)  
 DECLARE @ErrorSeverity INT  
  
 SELECT  
  @ErrorMessage = ERROR_MESSAGE(),  
  @ErrorSeverity = ERROR_SEVERITY()  
  
 RAISERROR(@ErrorMessage, @ErrorSeverity, 1) WITH LOG  
   
END CATCH 


Read more: http://sqlsolace.blogspot.com/2010/12/logging-errors-to-sql-logs-via.html#ixzz3gPacnFsv



-------------------------------------------------------------------
--範例程式碼9-6：建立 Server層級的DDL觸發程序
-------------------------------------------------------------------
CREATE TRIGGER ddl_trig_login 
ON ALL SERVER 
FOR DDL_LOGIN_EVENTS 
AS 
    PRINT N'修改登入事件.'
    SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
GO

#-------------------------------------------------------------------
#--範例程式碼9-7：透過LOGON事件所引發的觸發程序，確認哪些應用程式不可以連接到SQL Server
#-------------------------------------------------------------------
CREATE TRIGGER IntelliSense_Connection_Limit_Trigger
ON ALL SERVER FOR LOGON
AS
BEGIN
	--如果應用程式名稱如下，則是 SQL Server Management Studio 用來查詢
	--IntelliSense 資訊的連接，透過 ROLLBACK 指令，直接放棄建立連接
	IF APP_NAME()
	LIKE '%Microsoft SQL Server Management Studio - Transact-SQL IntelliSense%'
		ROLLBACK;
END;
GO

-------------------------------------------------------------------
--範例程式碼9-8：SQL Server透過DDL 觸發程序來評估原則
-------------------------------------------------------------------
CREATE TRIGGER [syspolicy_server_trigger] ON ALL SERVER 
WITH EXECUTE AS '##MS_PolicyEventProcessingLogin##'
FOR ALTER_AUTHORIZATION_DATABASE,ALTER_PROCEDURE,ALTER_SCHEMA,CREATE_PROCEDURE,RENAME
AS
BEGIN
		DECLARE @event_data xml
		SELECT @event_data = EVENTDATA()
		EXEC [msdb].[dbo].[sp_syspolicy_dispatch_event] @event_data = @event_data, @synchronous = 1
END
GO

-------------------------------------------------------------------
--範例程式碼：建立事件通知架構
-------------------------------------------------------------------
USE Northwind
GO
--首先要啟動某個 DB 的 Service Broker Services 才可以產生事件的通知
--當下只能有一條連線連到Northwind資料庫才可以設定
ALTER DATABASE Northwind SET ENABLE_BROKER

--建立存放通知的資料表，如果資料表已經存在就先刪除
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id=Object_id(N'dbo.AuditLog') AND OBJECTPROPERTY(id,N'IsTable')=1)
	DROP TABLE dbo.AuditLog
GO
CREATE TABLE AuditLog
(Command NVARCHAR(1000),
PostTime NVARCHAR(24),
HostName Nvarchar(100),
LoginName Nvarchar(100)
)

--建立寄送通知的服務
--建立 Queue
CREATE QUEUE NotifyQueue

--以佇列為基礎建立服務，並參照系統提供的 notification contract
CREATE SERVICE NotifyService
ON QUEUE NotifyQueue
([http://schemas.microsoft.com/SQL/Notifications/PostEventNotification])

--為服務建立 route 以定義 Service Broker 位服務寄送訊息的位置
CREATE ROUTE NotifyRoute
WITH SERVICE_NAME='NotifyService',
ADDRESS = 'LOCAL'

--建立資料庫的 event notification
CREATE EVENT NOTIFICATION NotifyCreate_Table
ON DATABASE
FOR CREATE_TABLE  -- 當 Create Table 時就要丟出 Event Notification
TO SERVICE 'NotifyService','current database'
GO


--建立一個資料表以觸發 Notification
CREATE TABLE T1(c1 INT)


SELECT * FROM NotifyQueue

--檢查是否有因為建立資料表，而事件通知丟出的訊息進入到 Queue
SELECT status,priority,message_body,CONVERT(XML,message_body) FROM dbo.NotifyQueue


-------------------------------------------------------------------
--範例程式碼9-9：從佇列中取出事件通知所記錄的事件資訊，並透過 XQuery 語法解析其內容
-------------------------------------------------------------------
--處理因為事件通知而寄發到佇列的訊息，
--將結果放入到先前建立的 AuditLog 資料表
DECLARE @messageTypeName NVARCHAR(256),
		@messageBody XML
;RECEIVE TOP(1)			  --從 NotifyQueue 中收信息
	@messageTypeName=message_type_name,
	@messageBody = message_body
	FROM dbo.NotifyQueue;

IF @@ROWCOUNT=0 RETURN

--Show 一下 messageBody 其實是以 XML 描述的事件細節資料
SELECT @messageTypeName MessageTypeName,CONVERT(NVARCHAR(1000),@messageBody) MessageBody

--宣告承接各種資料的變數
DECLARE @cmd NVARCHAR(1000)
DECLARE @PostTime NVARCHAR(24)
DECLARE @Hostname NVARCHAR(100)
DECLARE @LoginName NVARCHAR(100)

--以 XQuery 取得事件資料細節
SET @cmd=@messageBody.value('data(//TSQLCommand//CommandText)[1]','NVARCHAR(200)')
SET @PostTime=@messageBody.value('data(//PostTime)[1]','NVARCHAR(24)')
SET @HostName=@messageBody.value('data(//ServerName)[1]','SYSNAME')
SET @LoginName=@messageBody.value('data(//LoginName)[1]','NVARCHAR(50)')

INSERT INTO AuditLog(Command,PostTime,HostName,LoginName) 
VALUES(@cmd,@PostTime,@HostName,@LoginName)
GO
SELECT * FROM AuditLog
GO


-------------------------------------------------------------------
--範例程式碼9-10：建立與測試事件通知所提供的簡易追蹤
-------------------------------------------------------------------
--Trace Event 只能用在 Server Level 
CREATE EVENT NOTIFICATION Trace_Object 
ON SERVER 
FOR TRC_OBJECTS  --Object 的新增修改刪除
TO SERVICE 'NotifyService','current database'

--故意刪除資料表檢視所取得的 Trace
DROP TABLE t1

--查詢 Trace Event 所提供的資料
SELECT *,CONVERT(XML,message_body) FROM dbo.NotifyQueue

