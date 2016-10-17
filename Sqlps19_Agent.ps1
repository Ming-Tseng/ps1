<#Sqlps19_Agent

 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
 history : 
 object : tsql

 CH04_SQL Server Agent Proxy   與多伺服器作業.sql

#>

#-------------------------------------------------------------------
#1 40 SQL Server Agent Tables    http://technet.microsoft.com/en-us/library/ms181367.aspx
#-------------------------------------------------------------------
use msdb
select * from dbo.sysjobs


select 
j.name as [作業名稱]
,jc.name as [Name of the category]
,j.enabled  as [是否啟用]
,js.step_id  as [步驟的識別碼]
,js.step_name  as [步驟的名稱]
,js.command as [所執行的命令]
,js.retry_attempts  as  [失敗時的重試次數]
,last_run_duration as [上次執行步驟的持續期間 (hhmmss)]
,js.last_run_date   as  [上次開始執行步驟的日期]
,js.last_run_time  as [上次開始執行步驟的時間 (hhmmss)]
,js.proxy_id  as [作業步驟的 Proxy]
,*
from dbo.sysjobs  j
join dbo.sysjobsteps js on  j.job_id = js.job_id
join dbo.syscategories jc on jc.category_id=j.category_id

where  j.name  like '%DGPAP1%'


#-------------------------------------------------------------------
#--範例程式碼4-1：使用xcopy指令複製檔案
#-------------------------------------------------------------------
/*
基礎語法：copy 來源檔案 網路共用路徑

其中，網路共用路徑，需要使用完整通用命名慣例 (universal naming convention，UNC) 名稱。UNC 名稱的格式為：
\\<Systemname>\<ShareName>\<Path>

以下範例，將檔案C:\myFile.txt，複製到伺服器 PSP1 的分享資料夾 shared 內，例如：
*/
xcopy C:\myFile.txt \\RSP1\shared 

#-------------------------------------------------------------------
#--範例程式碼4-2：新增「多伺服器作業」到sysdownloadlist系統資料表，提供給「目標伺服器」下載和執行之用
#-------------------------------------------------------------------
-- 查詢「作業」的名稱與作業的唯一識別碼
USE master
GO
SELECT job_id N'作業的唯一識別碼', name N'作業'
FROM msdb.dbo.sysjobs
GO
-- 執行預存程序sp_post_msx_operation
/*
將「多伺服器作業」的資訊，新增到系統資料庫msdb的sysdownloadlist系統資料表中，以提供給「目標伺服器」下載和執行之用
*/
EXECUTE msdb.dbo.sp_post_msx_operation 
@operation='INSERT',  
@object_type ='JOB', @job_id='<job id>'
GO

#-------------------------------------------------------------------
#--範例程式碼4-3：執行預存程序sp_post_msx_operation，設定「輪詢間隔」的頻率
#-------------------------------------------------------------------
-- 執行預存程序sp_post_msx_operation，變更「輪詢間隔」
/*
使用參數說明：
@operation='SET-POLL'，設定所要公布的動作類型為：「SET-POLL」，設定「輪詢間隔」。
@object_type ='SERVER'，設定所要使用的物件類型為：「SERVER」。
@specific_target_server = '目標伺服器'，設定適用於此動作的「目標伺服器」之名稱。但若沒有使用@specific_target_server此參數，將對全部的「目標伺服器」進行公布。
@value=60，設定「輪詢間隔」，以秒鐘為單位，可填入合適的間隔秒數。
*/
USE master
GO
EXECUTE msdb.dbo.sp_post_msx_operation 
	@operation='SET-POLL', 
	@object_type ='SERVER', 
	@specific_target_server = '目標伺服器',
	@value=60
GO

#-------------------------------------------------------------------
#--範例程式碼4-4：建立資料庫DB_MSX
#-------------------------------------------------------------------
-- 建立資料庫DB_MSX
USE master
GO
IF EXISTS(SELECT name FROM sys.databases WHERE name=N'DB_MSX')
DROP DATABASE DB_MSX
GO
CREATE DATABASE DB_MSX
GO
