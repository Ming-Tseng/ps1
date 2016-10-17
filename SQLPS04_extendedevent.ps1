<#SQLPS04_extendedevent
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\PS1\SQLPS04_extendedevent.ps1


xe_packages
xe_objects  (event)
xe_object_columns   查詢特定事件結構描述
xe_sessions
#>






































#---------------------------------------------------------------
#     
#---------------------------------------------------------------
Invoke-Sqlcmd

$dbs1="SQLSERVER:\SQL\sp2013\DEFAULT\Databases"
$dbs2="SQLSERVER:\SQL\sp2013\SQLS2\Databases"
$dbs_test="SQLSERVER:\SQL\sp2013\SQLS2\Databases\test" ; cd  $dbs_test
cd  $dbs1;ls #List Database
cd test; cd tables;ls

ls
cd SQL;  #SQLSERVER:\SQL\sp2013
cd sp2013;ls;pwd   #Instance Name  DEFAULT ;SQLS2 
cd DEFAULT;ls
cd Databases ; ls

#---------------------------------------------------------------
#     dm_xe_packages  擴充事件封裝
#---------------------------------------------------------------
Invoke-Sqlcmd "SELECT * from sys.dm_xe_packages;"  -ServerInstance spm |select name


<#
package0   擴充事件系統物件。這是預設封裝。                                                                                                                                       
sqlos      SQL Server 作業系統 (SQLOS) 相關的物件                                                                                                                                      
XeDkPkg    Extended events for SQLDK binary                                                                                                                                      
sqlserver                                                                                                                                        
SecAudit     僅提供SQL Server Audit                                                                                                                                       
ucs          Extended events for Unified Communications Stack                                                                                                                                      
sqlclr       Extended events for SQL CLR                                                                                                                                     
filestream    Extended events for SQL Server FILESTREAM and FileTable                                                                                                                                   
sqlserver     SQL Server 相關的物件 Extended events for Microsoft SQL Server
#>


#---------------------------------------------------------------
#    事件(Events):
#---------------------------------------------------------------
$tsql="select * from sys.dm_xe_objects;"
$tsql="select * from sys.dm_xe_objects where object_type = 'event' order by name ;"
Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto


#---------------------------------------------------------------
#    查詢特定事件結構描述(sys.dm_xe_object_columns)
#---------------------------------------------------------------
$tsql="select * from sys.dm_xe_object_columns"
$tsql="select * from sys.dm_xe_object_columns where object_name='audit_event'"
Invoke-Sqlcmd $tsql  -ServerInstance spm  |ft -auto


#---------------------------------------------------------------
#    述詞(Predicates):
#述詞是一組邏輯規則，這些規則會在處理事件時加以評估。
#如此可讓擴充的事件使用者選擇性地擷取以特定準則為根據的事件資料
#---------------------------------------------------------------
$tsql="select * from sys.dm_xe_object_columns"
$tsql="select * from sys.dm_xe_objects where object_type in ('pred_compare', 'pred_source') order by name "
Invoke-Sqlcmd $tsql  -ServerInstance spm  |ft -auto


#---------------------------------------------------------------
#    動作(Actions):
#動作是針對事件的程式設計形式的回應或回應序列。
#動作會繫結至事件，而每一個事件都可以有一組獨特的動作
#---------------------------------------------------------------

$tsql="select * from sys.dm_xe_object"
$tsql="select * from sys.dm_xe_objects where object_type='action' order by name "
Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto


#---------------------------------------------------------------
#    目標(Target):
#目標會處理事件 (在引發事件的執行緒上同步處理，或是在系統提供的執行緒上非同步處理)。
#一般來說，當必須維護特定的資料順序時，就會使用同步處理。
#擴充的事件會提供幾個目標，您可適當地使用這些目標來導向事件輸出。
#---------------------------------------------------------------
$tsql=" "
$tsql="select * from sys.dm_xe_objects where object_type='target' order by name "
Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto





#---------------------------------------------------------------
#    工作階段(Sessions):
#工作階段是一個集合，可以包含數個物件，如事件、述詞、目標和動作。
#--查詢所有工作階段所使用 buffer size(記憶體)和其他資訊。
#---------------------------------------------------------------

$tsql=" "
$tsql="select * from sys.dm_xe_sessions"
Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto



#---------------------------------------------------------------
#    類型和對應(Types and Maps):
Type 會封裝位元組集合的長度和特性，以便能夠解譯資料。
Maps 會將內部值對應到字串，如此可讓使用者得知該值所表示的意義。

#---------------------------------------------------------------

$tsql="select * from sys.dm_xe_objects where object_type in ('map', 'type') order by name "
$tsql="select * from sys.dm_xe_map_values"   #--查詢所有類型和對應
Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto


$tsql=" "
$tsql="select map_key, map_value from sys.dm_xe_map_values where name = 'lock_mode' "   #--取得鎖定模式對應值
Invoke-Sqlcmd $tsql  -ServerInstance spm |ft -auto

#---------------------------------------------------------------
#    查看所有可用的事件，連同關鍵字與通道，請使用下列查詢 
#---------------------------------------------------------------

SELECT p.name, c.event, k.keyword, c.channel, c.description FROM
   (
   SELECT event_package = o.package_guid, o.description, 
   event=c.object_name, channel = v.map_value
   FROM sys.dm_xe_objects o
   LEFT JOIN sys.dm_xe_object_columns c ON o.name = c.object_name
   INNER JOIN sys.dm_xe_map_values v ON c.type_name = v.name 
   AND c.column_value = cast(v.map_key AS nvarchar)
   WHERE object_type = 'event' AND (c.name = 'CHANNEL' or c.name IS NULL)
   ) c LEFT JOIN 
   (
   SELECT event_package = c.object_package_guid, event = c.object_name, 
   keyword = v.map_value
   FROM sys.dm_xe_object_columns c INNER JOIN sys.dm_xe_map_values v 
   ON c.type_name = v.name AND c.column_value = v.map_key 
   AND c.type_package_guid = v.object_package_guid
   INNER JOIN sys.dm_xe_objects o ON o.name = c.object_name 
   AND o.package_guid = c.object_package_guid
   WHERE object_type = 'event' AND c.name = 'KEYWORD' 
   ) k
   ON
   k.event_package = c.event_package AND (k.event=c.event or k.event IS NULL)
   INNER JOIN sys.dm_xe_packages p ON p.guid = c.event_package
   --where c.event ='file_write_completed'

ORDER BY keyword desc, channel, event


http://msdn.microsoft.com/zh-tw/library/ff878413.aspx

#---------------------------------------------------------------
#    使用擴充事件   監視   系統活動  
#---------------------------------------------------------------
##1在查詢編輯器中，發出下列陳述式來建立事件工作階段及加入兩個事件。 這些 checkpoint_begin 和 checkpoint_end 事件會在資料庫中斷點的開頭和結尾引發
CREATE EVENT SESSION test0
ON SERVER
ADD EVENT sqlserver.checkpoint_begin,
ADD EVENT sqlserver.checkpoint_end
WITH (MAX_DISPATCH_LATENCY = 1 SECONDS)
go
##2加入具有 32 個值區的值區目標，以根據資料庫識別碼計算中斷點的數目。
ALTER EVENT SESSION test0
ON SERVER
ADD TARGET package0.histogram
(
      SET slots = 32, filtering_event_name = 'sqlserver.checkpoint_end', source_type = 0, source = 'database_id'
)
go
##3發出下列陳述式來加入 ETW 目標， 如此將可讓您看到開頭和結束事件，這可用來判斷中斷點所花的時間長度。
ALTER EVENT SESSION test0
ON SERVER
ADD TARGET package0.etw_classic_sync_target
go

##4.發出下列陳述式，以啟動工作階段及開始事件收集。
ALTER EVENT SESSION test0
ON SERVER
STATE = start
go

##5發出下列陳述式來引發三個事件。
USE tempdb
      checkpoint
go
USE master
      checkpoint
      checkpoint
go
##6發出下列陳述式來檢視事件計數。
SELECT CAST(xest.target_data AS xml) Bucketizer_Target_Data_in_XML
FROM sys.dm_xe_session_targets xest
JOIN sys.dm_xe_sessions xes ON xes.address = xest.event_session_address
JOIN sys.server_event_sessions ses ON xes.name = ses.name
WHERE xest.target_name = 'histogram' AND xes.name = 'test0'
go

##7在命令提示字元下，發出下列命令來檢視 ETW 資料
logman query -ets --- List the ETW sessions. This is optional.
logman update XE_DEFAULT_ETW_SESSION -fd -ets --- Flush the ETW log.
tracerpt %temp%\xeetw.etl -o xeetw.txt --- Dump the events so they can be seen.

##8發出下列陳述式，以停止事件工作階段，並從伺服器中將它移除。
ALTER EVENT SESSION test0
ON SERVER
STATE = STOP
go
 
DROP EVENT SESSION test0
ON SERVER
go
#---------------------------------------------------------------
#    擴充的事件   目錄檢視 (Transact-SQL)
#---------------------------------------------------------------
select * from sys.server_event_sessions
select * from sys.server_event_session_fields
select * from sys.server_event_session_actions
select * from sys.server_event_session_targets
select * from sys.server_event_session_events


#---------------------------------------------------------------
#    擴充事件動態管理檢視
#---------------------------------------------------------------
select * from  sys.dm_xe_map_values
select * from  sys.dm_xe_object_columns
select * from  sys.dm_xe_objects
select * from  sys.dm_xe_packages
select * from  sys.dm_xe_session_event_actions
select * from  sys.dm_xe_session_events
select * from  sys.dm_xe_session_object_columns
select * from  sys.dm_xe_session_targets
select * from  sys.dm_xe_sessions
 


#---------------------------------------------------------------
#    Temp
#---------------------------------------------------------------



#---------------------------------------------------------------
#    Temp
#---------------------------------------------------------------