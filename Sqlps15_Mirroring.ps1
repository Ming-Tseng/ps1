<#Sqlps15_Mirroring


\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SQLPS15_Mirroring.ps1

 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 history : 
 object : tsql
 CH11_永不停機概論.sql

 $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\SQLPS15_Mirroring.ps1

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

<#

Use using  master key 

DB: mingDB  & mingDB2
PrincipalHost    DGPAP1\SQL2008R2         C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008R2\MSSQL\DATA
MirroringHost    DGPAP2\SQL2008R2,5588    C:\Program Files (x86)\Microsoft SQL Server\MSSQL.1\MSSQL\Data         

Port :5023

csd\administrator

#>



#------------------------------------------
#  將用戶端連接至資料庫鏡像工作階段 (SQL Server
#------------------------------------------

初始化屬性和相關聯的連接字串關鍵字可讓用戶端自行指定容錯移轉夥伴的識別,,要連接至資料庫鏡像工作階段，用戶端可以使用 SQL Server Native Client 或 .NET Framework Data Provider for SQL Server。 針對 SQL Server 2014 資料庫設定之後，這兩個資料存取提供者就會完全支援資料庫鏡像

https://msdn.microsoft.com/zh-tw/library/ms175484.aspx

按照 20 至 30 秒的順序進行。 之後，如果資料存取提供者尚未逾時，它就會嘗試連接至容錯移轉夥伴。 如果連接逾時期限在連接成功之前到期，或容錯移轉夥伴無法使用，連接嘗試就會失敗。 如果容錯移轉夥伴可在登入逾時期限內，而且它目前是主體伺服器，則連接嘗試通常會成功。












#------------------------------------------
#  often maintain TSQL 
#------------------------------------------

##卡在“恢復”狀態   in “Restoring” state

BACKUP  DATABASE MyDatabase TO DISK = 'MyDatabase.bak'    WITH INIT --overwrite existing
RESTORE DATABASE MyDatabase FROM DISK = 'MyDatabase.bak'  WITH REPLACE --force restore over specified database
RESTORE DATABASE <database name> WITH RECOVERY

##
ALTER DATABASE database_name 
SET { <partner_option> | <witness_option> }
  <partner_option> ::=
    PARTNER { = 'partner_server' 
            | FAILOVER 
            | FORCE_SERVICE_ALLOW_DATA_LOSS
            | OFF
            | RESUME 
            | SAFETY { FULL | OFF }
            | SUSPEND 
            | TIMEOUT integer
            }
  <witness_option> ::=
    WITNESS { = 'witness_server' 
            | OFF 
            }

##
ALTER DATABASE database_name SET PARTNER FAILOVER  #Manually fails over the principal server to the mirror server. You can specify FAILOVER only on the principal server. This option is valid only when the SAFETY setting is FULL (the default).

ALTER DATABASE database_name SET PARTNER OFF
ALTER DATABASE database_name SET PARTNER SUSPEND
ALTER DATABASE database_name SET PARTNER RESUME
ALTER DATABASE database_name SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS
ALTER DATABASE database_name SET PARTNER SAFETY Full  #specify SAFETY only on the principal server.
ALTER DATABASE database_name SET PARTNER SAFETY OFF  #If SAFETY is set to OFF, the session runs in high-performance mode, and automatic failover and manual failover are not supported. 





#------------------------------------------
#  view & check 
#------------------------------------------

SELECT RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'

Pasted from <http://sharedderrick.blogspot.tw/2011/01/sql-server.html> 



## 
select name,recovery_model_desc from sys.databases
ALTER DATABASE mingDB  SET RECOVERY FULL;
Go

##
Firewall.cpl
Wf.msc
Telnet DGPAP2       5023


#------------------------------------------
#  setup  1  @PrincipalHost
#------------------------------------------

## 1  
資料庫鏡像端點是否已經存在
SELECT *  FROM sys.database_mirroring_endpoints

##
create master key encryption by password = '1qazXSW@';
GO
create certificate HOST_A_cert with subject = 'HOST_A certificate', start_date = '2008/11/01', expiry_date = '2030/11/01';
GO

Create endpoint endpoint_mirroring state = started
as tcp(listener_port = 7024, listener_ip = all)
for database_mirroring (authentication = certificate HOST_A_cert, encryption = disabled, role = all);
GO
Backup certificate HOST_A_cert to file = 'c:\temp\HOST_A_cert.cer';
GO
--
drop endpoint endpoint_mirroring   -- select * from sys.endpoints
drop certificate HOST_A_cert 
drop login HOST_A_login
drop user HOST_A_user
drop master key

##
ALTER ENDPOINT <Endpoint Name>
STATE = STARTED 
AS TCP (LISTENER_PORT = <port number>)
FOR database_mirroring (ROLE = ALL);



#------------------------------------------
#  step2  Endpoints  @ MirroringHost
#------------------------------------------
## 1  mirroring_endpoints
SELECT *  FROM sys.database_mirroring_endpoints
SELECT name, port FROM sys.tcp_endpoints
##
create master key encryption by password = '1qazXSW@';
create certificate HOST_B_cert with subject = 'HOST_B certificate', start_date = '2008/11/01', expiry_date = '2030/11/01';

Create endpoint endpoint_mirroring state = started
as tcp(listener_port = 7024, listener_ip = all)
for database_mirroring (authentication = certificate HOST_B_cert, encryption = disabled, role = all);


Backup certificate HOST_B_cert to file = 'c:\temp\HOST_B_cert.cer';

-
drop endpoint endpoint_mirroring
drop certificate HOST_B_cert 
drop login HOST_B_login
drop user HOST_B_user
drop master key

#------------------------------------------
#  step3  backup   mingDB       @ PrincipalHost
#-----------------------------------------
create login HOST_B_login with PASSWORD = '1qazXSW@';
GO 
create user HOST_B_user from login HOST_B_login;
GO 
Create certificate HOST_B_cert
Authorization HOST_B_user
From file = 'c:\temp\HOST_B_cert.cer';
GO 
Grant CONNECT ON Endpoint::endpoint_mirroring to [HOST_B_login];
GO

--
--drop certificate HOST_B_cert 
--drop login HOST_B_login
--drop user HOST_B_user



#------------------------------------------
#  step4  backup   mingDB       @ MirroringHost
#-----------------------------------------

create login HOST_A_login with PASSWORD = '1qazXSW@';
GO 
create user HOST_A_user from login HOST_A_login;
GO 
Create certificate HOST_A_cert
Authorization HOST_A_user
From file = 'c:\temp\HOST_A_cert.cer';
GO 



Grant CONNECT ON Endpoint::Endpoint_mirroring to [HOST_A_login];
GO 
--drop certificate HOST_A_cert 
--drop login HOST_A_login
--drop user HOST_A_user


##
DROP ENDPOINT Endpoint5023


#------------------------------------------
#  step  5 backup   mingDB       @ PrincipalHost
#-----------------------------------------

Backup database mingDB  to disk ='c:\temp\mingDB20140224-1.bak'
Backup log mingDB  to disk ='c:\temp\mingDB20140224-1_log.trn'  

RESTORE FILELISTONLY FROM  disk='c:\temp\mingDB20140224-1.bak'

Copy  File  to  MirroringHost
Get  LogicalName   mingDB ,mingDB_log

#------------------------------------------
#  step  6  @ MirroringHost
#------------------------------------------
USE master
GO
CREATE DATABASE mingDB 
ON     ( NAME = mingDB , FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\mingDB.mdf' )
LOG ON  ( NAME = 'mingDB_log',   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\mingDB_log.ldf' )
GO

#

USE master
GO
CREATE DATABASE mingDB 
ON     ( NAME = mingDB , FILENAME = 'C:\SQLDB\mingDB.mdf' )
LOG ON  ( NAME = 'mingDB_log',   FILENAME = 'C:\SQLDB\mingDB_log.ldf' )
GO




C:\SQLDB

#------------------------------------------
#  step  7   @ MirroringHost
#------------------------------------------

## Get
select name, state_desc  from sys.databases

Restore database mingDB from disk ='c:\temp\mingDB20140224.bak'  
with replace ,norecovery
, MOVE 'mingDB ' TO 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\mingDB.mdf'
, MOVE 'mingDB_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\mingDB_log.ldf'

#

select name, state_desc  from sys.databases

Restore database mingDB from disk ='c:\temp\mingDB20140224.bak'  
with replace ,norecovery
, MOVE 'mingDB ' TO 'C:\SQLDB\mingDB.mdf'
, MOVE 'mingDB_log' TO 'C:\SQLDB\mingDB_log.ldf'

RESTORE LOG mingDB 
    FROM DISK = 'c:\temp\mingDB20140224-1_log.trn' 
    WITH FILE=1, NORECOVERY
GO


#------------------------------------------
#  step 8   @ MirroringHost
#------------------------------------------
Alter database mingDB set partner = 'TCP://DGPAp1:7024';  
go
Alter database mingDB set partner = 'TCP://172.16.220.39:7024';  
go


TCP://SP2013.csd.syscom:5022

TCP://sql2014x.csd.syscom:5022


ping sql2014x
telnet sql2014x  7024
telnet sql2014x  3389
telnet SP2013  5022

Alter database mingDB set partner = 'TCP://172.16.220.39:7024';  
go


#------------------------------------------
#  step   7   @ PrincipalHost
#------------------------------------------

Alter database mingDB set partner = 'TCP://DGPAp2:7024';  
Go

Alter database mingDB set partner = 'TCP://172.16.220.40:7024';  
go

#------------------------------------------
#  step   8  maintain  @ PrincipalHost
#------------------------------------------

SELECT name,state_desc FROM sys.database_mirroring_endpoints
SELECT name, port FROM sys.tcp_endpoints
DROP ENDPOINT endpoint_mirroring

## 
Alter database  mingDB  SET PARTNER OFF
Alter Database  mingDB  SET PARTNER FAILOVER

Resume a Database Mirroring Session (Transact-SQL)
    ALTER DATABASE mingDB SET PARTNER RESUME
## stop restoring 
RESTORE DATABASE MyDatabase WITH RECOVERY 

Pasted from <http://stackoverflow.com/questions/520967/sql-server-database-stuck-in-restoring-state> 


Select  database_id ,mirroring_state_desc ,mirroring_partner_instance ,mirroring_role_desc
from sys.database_mirroring
where mirroring_state_desc is not null

資料庫鏡像工作階段強制服務
ALTER DATABASE <database_name> SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS


#------------------------------------------
#  mirroring work
#------------------------------------------

## 
Alter database  mingDB  SET PARTNER OFF
Alter Database  mingDB  SET PARTNER FAILOVER

Resume a Database Mirroring Session (Transact-SQL)
ALTER DATABASE mingDB SET PARTNER RESUME
## stop restoring 
RESTORE DATABASE MyDatabase
WITH RECOVERY 


Select  database_id ,mirroring_state_desc ,mirroring_partner_instance ,mirroring_role_desc
from sys.database_mirroring
where mirroring_state_desc is not null

資料庫鏡像工作階段強制服務
ALTER DATABASE <database_name> SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS
#------------------------------------------
#  Estimate the Interruption of Service During Role Switching 
#------------------------------------------
預估角色切換期間的服務中斷時間
http://msdn.microsoft.com/en-us/library/ms187465.aspx

##  1 自動容錯移轉
For automatic failover, two factors contribute to the time service is interrupted:
the time required for the mirror server to recognize that the principal server instance has failed,
that is error detection, plus the time required to fail over the database, that is failover time.
對於自動容錯移轉，有兩個因素構成服務中斷時間：
1.1.鏡像伺服器辨識主體伺服器執行個體失敗所需的時間，即錯誤偵測，
1.2.加上資料庫容錯移轉所需的時間，即容錯移轉時間
容錯移轉時間= 錯誤偵測時間 +  資料庫容錯移轉所需時間
，預設的逾時期間。: 10 秒


>若要變更逾時值 (僅高安全性模式)
   ALTER DATABASE <database> SET PARTNER   TIMEOUT integer
>檢視目前的逾時值
select mirroring_connection_timeout from sys.database_mirroring --等待夥伴或見證回應的秒數，過了這段時間，便將它們視為無法使用。 預設的逾時值是 10 秒。


##  2 強制服務作業
For a forced-service operation, though a failure has occurred, detecting and responding to the failure depends on human responsiveness. 
However, estimating the potential interruption of service is limited to estimating the time for the mirror server to switch roles after the forced service command is issued.

對於強制服務作業，雖然發生失敗，失敗的偵測和回應視人員回應而定。 
不過，預估可能的服務中斷，僅限於預估發出強制服務命令之後鏡像伺服器切換角色的時間。


##


wf.msc



#------------------------------------------
#  mirroring system View
#------------------------------------------
select @@SERVERNAME
select DB_name(database_id)  
,mirroring_state_desc  as [工作階段的狀態]
,mirroring_role_desc   as [本機資料庫在鏡像中所扮演之角色的描述]
,mirroring_safety_level_desc  as [更新交易安全設定]
,mirroring_partner_name      as [資料庫鏡像夥伴的伺服器名稱]
,mirroring_partner_instance  as [其他夥伴的執行個體名稱和電腦名稱]
,mirroring_partner_name      as[資料庫鏡像見證的伺服器名稱]
,mirroring_connection_timeout  as [鏡像連接逾時 (以秒為單位)]
,mirroring_witness_name      as [資料庫鏡像見證的伺服器名稱]
,mirroring_role_sequence   as[因容錯移轉或強制服務而切換主體和鏡像角色的次數]
 from sys.database_mirroring where mirroring_guid is not null


##
select @@SERVERNAME
select DB_name(database_id)  
,mirroring_failover_lsn  as [保證寫入雙方磁碟的最新交易記錄的記錄序號 (LSN)]
-- 在容錯移轉之後，夥伴會使用 mirroring_failover_lsn 做為重新調整點，新鏡像伺服器從此處開始同步處理新鏡像資料庫與新主體資料庫。]
,mirroring_end_of_log_lsn     as [已排清至磁碟的本機記錄檔結束]
-- 這相當於鏡像伺服器中的強化 LSN (請參閱 mirroring_failover_lsn 資料行)。
,mirroring_replication_lsn   as [複寫可傳送的最大 LSN]
 from sys.database_mirroring where mirroring_guid is not null



#------------------------------------------
#  Use Warning Thresholds and Alerts on Mirroring Performance Metrics
#------------------------------------------
使用鏡像效能標準的警告臨界值與警示

http://msdn.microsoft.com/en-us/library/ms408393.aspx

##Performance Metrics and Warning Thresholds


##Setting Up and Managing Warning Thresholds


##Using Alerts for a Mirrored Database



##Related Tasks




#------------------------------------------
#  SQLServer:Database Mirroring  PCR
#------------------------------------------

Bytes Received/sec  : Number of bytes received per second.
Bytes Sent/sec
Log Bytes Received/sec
Log Bytes Redone from Cache/sec
Log Bytes Sent from Cache/sec
Log Bytes Sent/sec
Log Compressed Bytes Rcvd/sec
Log Compressed Bytes Sent/sec
Log Harden Time (ms)
Log Remaining for Undo KB
Log Scanned for Undo KB
Log Send Flow Control Time (ms)
Log Send Queue KB
Mirrored Write Transactions/sec
Pages Sent/sec
Receives/sec
Redo Bytes/sec
Redo Queue KB
Send/Receive Ack Time
Sends/sec
Transaction Delay


#--*****************************************************************
#--實作練習11-1：資料庫鏡像建置
#--*****************************************************************
#---------------------------------------------------------------------------
#任務一：前置作業
#---------------------------------------------------------------------------
--Step01.先於主要伺服器建立MIRROR_QQ範例資料庫：

use master;
--建立新的資料庫 MIRROR_QQ
create database MIRROR_QQ;
--修改newdb的recovery model 成為full
ALTER DATABASE MIRROR_QQ
SET RECOVERY FULL



--Step02.備份主要伺服器的MIRROR_QQ資料庫：
BACKUP DATABASE MIRROR_QQ to DISK='C:\ MIRROR_QQ.bak' with init


--Step03.將MIRROR_QQ資料庫之備份檔以「WITH NORECOVERY」還原至鏡像伺服器，以承接後續的交易資料：
--在「鏡像伺服器」建立新的資料庫 MIRROR_QQ
RESTORE DATABASE MIRROR_QQ
FROM DISK ='C:\ MIRROR_QQ.bak'with replace,norecovery,
MOVE 'MIRROR_QQ' TO 'C:\Program Files\Microsoft SQL Server\MSSQL10.I2\MSSQL\DATA\MIRROR_QQ.mdf',
MOVE 'MIRROR_QQ_LOG' TO 'C:\Program Files\Microsoft SQL Server\MSSQL10.I2\MSSQL\DATA\MIRROR_QQ_log.ldf'


--Step04.使用 INIT 選項備份 AdventureWorks 資料庫備份至相同路徑，
--再使用 Step02 的 RESTORE HEADERONLY 指令檢視備份結果

BACKUP DATABASE Northwind TO DISK='D:\DBBackup\AdventureWorks.Bak'
WITH INIT


#---------------------------------------------------------------------------
#任務四：驗證資料庫鏡像
#---------------------------------------------------------------------------
--Step01.
USE MIRROR_QQ
--建立新資料表
CREATE TABLE [dbo].[MIRROR_QQ](
[id]   [int] IDENTITY(1,1) NOT NULL,
[CardName] [varchar](20) NULL,
[Date]   [datetime] NULL DEFAULT (getdate()))
--填入資料	
INSERT INTO dbo.MIRROR_QQ
VALUES('JIOU',DEFAULT)
INSERT INTO dbo.MIRROR_QQ
VALUES('CANDY',DEFAULT)


--Step02.
USE MIRROR_QQ
SELECT * FROM MIRROR_QQ




#--*****************************************************************
#實作練習11-2：建置記錄傳送
#--*****************************************************************

#---------------------------------------------------------------------------
#任務一：前置作業
#---------------------------------------------------------------------------
--Step01.
--建立資料庫
CREATE DATABASE LOGSHPPING_QQ
GO

--設定完整復原模式
ALTER DATABASE LOGSHPPING_QQ
SET RECOVERY FULL

GO

--建立測試資料表
USE LOGSHPPING_QQ
GO

CREATE TABLE test1
( T1 int identity primary key, --主索引鍵
  T2 varchar(10))


