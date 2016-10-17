<#Sqlps20_policy

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps20_policy.ps1
 C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps20_policy.ps1
 auther : ming_tseng    a0921887912@gmail.com
 createData : Mar.17.2014
LastDate : APR.28.2014 
 object : tsql

 

#>

# 1：建立目標資料庫Northwind_PBM與使用者預存程序：dbo.sp_haha01
# 2：建立不符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為sp_
# 3：建立符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為np_
# 4：測試「原則」：預存程序的物件名稱之前置詞不得為sp_
# 5：建立違反原則的使用者自定預存程序，並檢視其錯誤訊息
# 6：利用xp_cmdshell擴充預存程序，執行顯示目錄命令
# 7：以原則為基礎的管理與系統檢視
# 8：刪除「以原則為基礎的管理」的歷史紀錄
# 9       Listing facets and facet properties  p252
# 10      Listing / Exporting  policies  p.254
# 11      Creating a condition  p.264
# 12  700  Creating  /Evaluating  a policy P.268
#  13   800 PBM default for alwayson
#  14   900 msdb.dbo.syspolicy_policies  for alwayson
#  15  900  msdb.dbo.syspolicy_conditions   msdb.dbo.syspolicy_conditions_internal    for alwayson
#  16  950  look for all  properties facts      Microsoft.SqlServer.Management.Smo Namespace


#-------------------------------------------------------------------
#  DMV  * knowledge
#-------------------------------------------------------------------
Facet     – a predefined set of properties that can be managed  for example , the table facet contains name, file group , Owner and etc. properties


Condition – a property expression that evaluates to True or False, e.g the state of a Facet , contains one or more Boolean AND, OR ,and NOT

Target    – an entity (a database, a table, an index) that is managed by PΒΜ

Policy    – a condition to be checked and/or enforced

Evaluation mode - On change: Prevent , On Change: Log , On Schedule ,On Demand  : some facet do not support all the evaluation 

central management Server -  
Category


C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Policies\DatabaseEngine\1033

#facet : 84itme  select * from msdb.dbo.syspolicy_management_facets  (pro_sql_server_2008_policy-based_management.pdf p.138)
'
management_facet_id	name	execution_mode
1	ApplicationRole	7
2	AsymmetricKey	7
3	Audit	4
4	AvailabilityDatabase	4
5	AvailabilityGroup	4
v6	AvailabilityReplica	4
v7	DatabaseReplicaState	4
8	BackupDevice	4
9	BrokerPriority	4
10	BrokerService	4
11	Certificate	4
12	Computer	4
13	Credential	4
14	CryptographicProvider	4
15	Database	4
16	DatabaseAuditSpecification	4
17	DatabaseDdlTrigger	4
18	DatabaseRole	7
19	DataFile	4
20	Default	4
21	DeployedDac	4
22	Endpoint	7
23	Utility	4
24	FileGroup	4
25	FullTextCatalog	4
26	FullTextIndex	4
27	FullTextStopList	4
v28	IAvailabilityGroupState	4
29	IDatabaseMaintenanceFacet	4
30	IDatabaseOptions	6
31	IDatabasePerformanceFacet	4
32	IDatabaseSecurityFacet	4
33	ILoginOptions	7
34	IMultipartNameFacet	7
35	INameFacet	4
36	ITableOptions	7
37	IUserOptions	7
38	IViewOptions	7
39	Index	4
40	IServerAuditFacet	4
41	IServerConfigurationFacet	6
42	IServerInformation	4
43	IServerPerformanceFacet	4
44	IServerProtocolSettingsFacet	4
45	IServerSecurityFacet	4
46	IServerSetupFacet	4
47	IServerSelectionFacet	0
48	IServerSettings	4
49	ISurfaceAreaConfigurationForAnalysisServer	0
50	ISurfaceAreaConfigurationForReportingServices	0
51	ISurfaceAreaFacet	6
52	LinkedServer	4
53	LogFile	4
54	Login	4
55	MessageType	4
56	PartitionFunction	4
57	PartitionScheme	4
58	Processor	4
59	PlanGuide	4
60	RemoteServiceBinding	4
61	ResourceGovernor	4
62	ResourcePool	7
63	Rule	4
64	Schema	7
65	SearchPropertyList	6
v66	Server	4
67	ServerAuditSpecification	4
68	ServerDdlTrigger	4
69	ServerRole	7
70	ServiceContract	4
71	ServiceQueue	4
72	ServiceRoute	4
73	Statistic	4
74	StoredProcedure	7
75	SymmetricKey	4
76	Synonym	4
77	Sequence	7
78	Table	4
79	Trigger	4
80	User	4
81	UserDefinedAggregate	4
82	UserDefinedDataType	4
83	UserDefinedFunction	7
84	UserDefinedTableType	4
85	UserDefinedType	4
86	View	4
87	Volume	4
88	WorkloadGroup	7
89	XmlSchemaCollection	4
90	IDataFilePerformanceFacet	4
91	ILogFilePerformanceFacet	4

'


select * from msdb.dbo.syspolicy_facet_events

select * from msdb.dbo.syspolicy_conditions      ;select * from msdb.dbo.syspolicy_conditions_internal

select * from msdb.dbo.syspolicy_policies        ; select * from msdb.dbo.syspolicy_policies_internal

select * from msdb.dbo.syspolicy_configuration



select *  from msdb.dbo.syspolicy_policy_categories
select *  from msdb.dbo.syspolicy_policy_categories_internal



select *  from msdb.dbo.syspolicy_policy_category_subscriptions
select *  from msdb.dbo.syspolicy_policy_category_subscriptions_internal


select *  from msdb.dbo.syspolicy_policy_execution_history
select *  from msdb.dbo.syspolicy_policy_execution_history_details
select *  from msdb.dbo.syspolicy_policy_execution_history_details_internal
select *  from msdb.dbo.syspolicy_policy_execution_history_internal

select * from msdb.dbo.syspolicy_system_health_state  
select * from msdb.dbo.syspolicy_system_health_state_internal

select * from msdb.dbo.syspolicy_target_sets       ;select * from msdb.dbo.syspolicy_target_sets_internal
select * from msdb.dbo.syspolicy_target_set_levels ; select * from msdb.dbo.syspolicy_target_set_levels_internal







#-------------------------------------------------------------------
#1：建立目標資料庫Northwind_PBM與使用者預存程序：dbo.sp_haha01
#-------------------------------------------------------------------
SELECT *  FROM msdb.dbo.syspolicy_facet_events


SELECT distinct target_type  FROM msdb.dbo.syspolicy_facet_events











#-------------------------------------------------------------------
#1：建立目標資料庫Northwind_PBM與使用者預存程序：dbo.sp_haha01
#-------------------------------------------------------------------
USE master
GO
-- 備份資料庫Northwind，並搭配利用「備份壓縮(Backup Compression)」
/*
若是你使用的不是SQL Server 2008 Enterprise 企業版本，將無法使用「備份壓縮」功能。
請移除 COMPRESSION 參數。
*/
BACKUP DATABASE [Northwind] 
TO  DISK = N'C:\myAdmin\Device\nw_PBM.bak' WITH FORMAT, 
	NAME = N'Northwind-完整 資料庫 備份', STATS = 10, COMPRESSION
GO

-- 復原資料庫為：Northwind_PBM
RESTORE DATABASE [Northwind_PBM] 
FROM  DISK = N'C:\myAdmin\Device\nw_PBM.bak' 
WITH  FILE = 1,  
	MOVE N'Northwind' TO N'C:\myAdmin\DB\Northwind_PBM.mdf',  
	MOVE N'Northwind_log' TO N'C:\myAdmin\DB\Northwind_PBM_1.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO

-- 建立使用者預存程序：dbo.sp_haha01
USE Northwind_PBM
GO
CREATE PROCEDURE dbo.sp_haha01
AS
	SELECT GETDATE(), N'使用者預存程序：dbo.sp_haha01'
GO
USE master
GO
#-------------------------------------------------------------------
#  New condition  msdb.dbo.sp_syspolicy_add_condition
#-------------------------------------------------------------------

Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'規範之使用者自定預存程序，其前置詞為np_', @description=N'建立符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為np_', @facet=N'StoredProcedure', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>LIKE</OpType>
  <Count>2</Count>
  <Attribute>
    <TypeClass>String</TypeClass>
    <Name>Name</Name>
  </Attribute>
  <Constant>
    <TypeClass>String</TypeClass>
    <ObjType>System.String</ObjType>
    <Value>np_%</Value>
  </Constant>
</Operator>', @is_name_condition=2, @obj_name=N'np_%', @condition_id=@condition_id OUTPUT
Select @condition_id

GO

#-------------------------------------------------------------------
#  New Policy  msdb.dbo.sp_syspolicy_add_policy 
#-------------------------------------------------------------------

Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'Ming規範之使用者自定預存程序，其前置詞為np__ObjectSet', @facet=N'StoredProcedure', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'Ming規範之使用者自定預存程序，其前置詞為np__ObjectSet', @type_skeleton=N'Server/Database/StoredProcedure', @type=N'PROCEDURE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/StoredProcedure', @level_name=N'StoredProcedure', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'Ming規範之使用者自定預存程序，其前置詞為np_', @condition_name=N'M規範之使用者自定預存程序，其前置詞為np_', @policy_category=N'MingTestPolicy', @execution_mode=1, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'Ming規範之使用者自定預存程序，其前置詞為np__ObjectSet'
Select @policy_id


GO


#-------------------------------------------------------------------
# 2：建立不符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為sp_
#-------------------------------------------------------------------
USE Northwind_PBM
GO

-- 建立不符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為sp_
CREATE PROCEDURE sp_EmployeeName
AS
	SELECT LastName,FirstName FROM dbo.Employees
GO

#-------------------------------------------------------------------
# 3：建立符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為np_
#-------------------------------------------------------------------
USE Northwind_PBM
GO

-- 建立符合「原則」的「條件」規範之使用者自定預存程序，其前置詞為np_
CREATE PROCEDURE np_EmployeeName
AS
	SELECT LastName,FirstName FROM dbo.Employees
GO

-- 執行此使用者自定預存程序
EXEC np_EmployeeName
GO

#-------------------------------------------------------------------
# 4：測試「原則」：預存程序的物件名稱之前置詞不得為sp_
#-------------------------------------------------------------------
USE Northwind_PBM
GO

--01 建立符合「原則」的「條件」規範之使用者自定預存程序，其物件名稱之前置詞不得為 sp_
CREATE PROCEDURE up_EmployeeName02
AS
	SELECT LastName,FirstName FROM dbo.Employees
GO

--02 建立符合「原則」的「條件」規範之使用者自定預存程序，其物件名稱之前置詞不得為 sp_
CREATE PROCEDURE ap_EmployeeName02
AS
	SELECT LastName,FirstName FROM dbo.Employees
GO

--03 建立不符合「原則」的「條件」規範之使用者自定預存程序，其物件名稱之前置詞不得為 sp_
CREATE PROCEDURE sp_EmployeeName02
AS
	SELECT LastName,FirstName FROM dbo.Employees
GO

/* 遭遇到的錯誤訊息

'SQLSERVER:\SQL\SQL2K8\DEFAULT\Databases\Northwind_PBM\StoredProcedures\dbo.sp_EmployeeName02' 違反了原則 'mypo_資料庫Northwind_PBM的使用者自定預存程序之命名規範，前置詞需為np_%'。
此交易即將被回復。
原則條件: '@Name NOT LIKE 'sp_%''
原則描述: ''
其他說明: '' : ''
陳述式: '--03 建立不符合「原則」的「條件」規範之使用者自定預存程序，其前置詞不得為 sp_
CREATE PROCEDURE sp_EmployeeName02
AS
	SELECT LastName,FirstName FROM dbo.Employees
'。
訊息 3609，層級 16，狀態 1，程序 sp_syspolicy_dispatch_event，行 65
交易在觸發程序中結束。已中止批次。
*/

#-------------------------------------------------------------------
#--  5：建立違反原則的使用者自定預存程序，並檢視其錯誤訊息
#-------------------------------------------------------------------
USE Northwind_PBM
GO

--01 建立不符合「原則」的「條件」規範之使用者自定預存程序，其物件名稱之前置詞不得為 sp_
CREATE PROCEDURE sp_EmployeeName03
AS
	SELECT LastName,FirstName FROM dbo.Employees
GO

/* 遭遇到的錯誤訊息：

'SQLSERVER:\SQL\SQL2K8\DEFAULT\Databases\Northwind_PBM\StoredProcedures\dbo.sp_EmployeeName03' 違反了原則 'mypo_資料庫Northwind_PBM的使用者自定預存程序之命名規範，前置詞需為np_'。
此交易即將被回復。
原則條件: '@Name LIKE 'np_%''
原則描述: '為了讓物件名稱能具備一致性、避免與系統物件發生衝突、讓後續維護作業能夠平順進行，設計了使用者自定預存程序之命名規範，前置詞需為np_。參考文件：ob_01_資料庫物件命名規範。'
其他說明: '請參考開發文件：ob_01_資料庫物件命名規範，專案負責人：德瑞克，聯絡分機：123，啟用日期：2008年12月1日。' : 'http://sharedderrick.blogspot.com'
陳述式: '
--01 建立不符合「原則」的「條件」規範之使用者自定預存程序，其物件名稱之前置詞不得為 sp_
CREATE PROCEDURE sp_EmployeeName03
AS
	SELECT LastName,FirstName FROM dbo.Employees
'。
訊息 3609，層級 16，狀態 1，程序 sp_syspolicy_dispatch_event，行 65
交易在觸發程序中結束。已中止批次。
*/

#-------------------------------------------------------------------
#   6：利用xp_cmdshell擴充預存程序，執行顯示目錄命令
#-------------------------------------------------------------------
USE master
GO
--利用xp_cmdshell擴充預存程序，執行顯示目錄命令
EXEC xp_cmdshell 'dir c:\*.*'

/*
訊息 15281，層級 16，狀態 1，程序 xp_cmdshell，行 1
SQL Server 已封鎖元件 'xp_cmdshell' 的 程序 'sys.xp_cmdshell' 之存取，因為此元件已經由此伺服器的安全性組態關閉。
系統管理員可以使用 sp_configure 來啟用 'xp_cmdshell' 的使用。
如需有關啟用 'xp_cmdshell' 的詳細資訊，請參閱《SQL Server 線上叢書》中的＜介面區組態＞(Surface Area Configuration)。

Msg 15281, Level 16, State 1, Procedure xp_cmdshell, Line 1
SQL Server blocked access to procedure 'sys.xp_cmdshell' of component 
'xp_cmdshell' because this component is turned off as part of the security 
configuration for this server. 

A system administrator can enable the use of 'xp_cmdshell' by using sp_configure. 
For more information about enabling 'xp_cmdshell', 
see "Surface Area Configuration" in SQL Server Books Online.

*/

#-------------------------------------------------------------------
#   7：「以原則為基礎的管理」與系統檢視
#-------------------------------------------------------------------
USE msdb
GO

--01 系統檢視：syspolicy_system_health_state
/*
針對每一個以原則為基礎的管理原則和目標查詢運算式組合各顯示一個資料列。
使用 syspolicy_system_health_state 檢視表可透過程式設計方式檢查伺服器的原則健全狀態。
此檢視表會顯示每一個使用中 (已啟用) 原則之目標查詢運算式的最近健全狀態。
*/
SELECT * 
FROM msdb.dbo.syspolicy_system_health_state

--02 系統檢視：syspolicy_policy_execution_history
/*
顯示原則執行的時間、每一次執行的結果，以及任何發生之錯誤的相關資料。
*/
SELECT * 
FROM msdb.dbo.syspolicy_policy_execution_history

--03 系統檢視：syspolicy_policy_execution_history_details
/*
顯示已執行的條件運算式、運算式的目標、每一次執行的結果，以及任何發生之錯誤的相關詳細資料。
分析此檢視表，可以來判斷哪一個目標和條件運算式組合失敗、其失敗的時間，並檢閱相關錯誤。
*/
SELECT * 
FROM msdb.dbo.syspolicy_policy_execution_history_details

-- 顯示此原則的名稱、此條件的名稱及有關失敗的詳細資料
SELECT Pol.name AS Policy,  Cond.name AS Condition, PolHistDet.target_query_expression, 
	PolHistDet.execution_date, PolHistDet.result, PolHistDet.result_detail, 
	PolHistDet.exception_message, PolHistDet.exception 
FROM msdb.dbo.syspolicy_policies AS Pol JOIN msdb.dbo.syspolicy_conditions AS Cond
    ON Pol.condition_id = Cond.condition_id
JOIN msdb.dbo.syspolicy_policy_execution_history AS PolHist
    ON Pol.policy_id = PolHist.policy_id
JOIN msdb.dbo.syspolicy_policy_execution_history_details AS PolHistDet
    ON PolHist.history_id = PolHistDet.history_id
WHERE PolHistDet.result = 0 ;

#-------------------------------------------------------------------
#  8：刪除「以原則為基礎的管理」的歷史紀錄
#-------------------------------------------------------------------
USE msdb
GO

/*=========================================================*/
--01 檢視與刪除：伺服器的原則健全狀態
SELECT * 
FROM msdb.dbo.syspolicy_system_health_state_internal;  

-- 目前有兩種方式可以刪除原則的健全狀態
--EX1. 利用預存程序：sp_syspolicy_purge_health_state 來執行刪除
EXEC msdb.dbo.sp_syspolicy_purge_health_state 
	@target_tree_root_with_id=N'Server'

--EX2. 直接刪除資料表：syspolicy_system_health_state_internal 的資料
DELETE FROM msdb.dbo.syspolicy_system_health_state_internal;  

/*=========================================================*/
--02 檢視與刪除：原則執行的時間、每一次執行的結果，以及任何發生之錯誤的相關資料。
SELECT * 
FROM msdb.dbo.syspolicy_policy_execution_history_internal

-- 直接刪除資料表：syspolicy_policy_execution_history_internal 的資料
DELETE FROM msdb.dbo.syspolicy_policy_execution_history_internal

/*=========================================================*/
--03 檢視與刪除：已執行的條件運算式、運算式的目標、每一次執行的結果，以及任何發生之錯誤的相關詳細資料。
SELECT * 
FROM msdb.dbo.syspolicy_policy_execution_history_details_internal

-- 直接刪除資料表：syspolicy_policy_execution_history_details_internal 的資料
DELETE FROM msdb.dbo.syspolicy_policy_execution_history_details_internal

/*=========================================================*/
--04 使用預存程序：sp_syspolicy_purge_history 刪除資料
/*
預存程序：sp_syspolicy_purge_history 將刪除兩個資料表 syspolicy_policy_execution_history_internal 與 syspolicy_policy_execution_history_details_internal 的資料。
*/
EXEC msdb.dbo.sp_syspolicy_purge_history


#-------------------------------------------------------------------
#  9   300  Listing facets and facet properties  p252
#-------------------------------------------------------------------

Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking

#Add the following script and run:
[Microsoft.SqlServer.Management.Dmf.PolicyStore]::Facets |
ForEach-Object {
$facet = $_
$facet.FacetProperties |
Select @{N="FacetName";E={$facet.Name}},
@{N="PropertyName";E={$_.Name}},
@{N="PropertyType";E={$_.PropertyType}}
} |
Format-Table





#-------------------------------------------------------------------
#  10   Listing / Exporting  policies  p.254
#-------------------------------------------------------------------


##-- Get
$connectionstring = "server='SP2013';Trusted_Connection=true"
$conn = New-Object Microsoft.SQlServer.Management.Sdk.Sfc.SqlStoreConnection($connectionstring)
#NOTE notice how the namespace is still called DMF
#DMF - declarative management framework
#DMF was the old reference to Policy Based Management
$PolicyStore = New-Object Microsoft.SqlServer.Management.DMF.PolicyStore($conn)
$PolicyStore.Policies | Select Name, CreateDate, Condition, ObjectSet, Enabled |FL
$PolicyStore.Policies | Select Name, CreateDate, Condition, ObjectSet, Enabled |Out-GridView






##--exporting  P257
##Studio
(1). Log in to SQL Server Management Studio, and expand Management |Policy Management.
(2). Right-click on Conditions and select New Condition.
(3). Create a new condition:
    1. Set Name to PW Expiry Condition.
    2. Select Login Options for Facet.
    3. Use @PasswordExpirationEnabled = True for Expression.
    4. Click on OK when done.
(4). Right-click on Policies and select New Policy.
(5). Create a new policy:
    1. Type PW Expiry for Name.
    2. Use PW Expiry Condition for Check condition.
    3. Leave the checkbox for Against targets checked, since we want to target every login.
    4. Leave Evaluation Mode to On demand.
    5. Leave Server restriction to None.
    6. Click on OK when done.


##PS
1. Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
2. Import the SQLPS module as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
3. Add the following script and run:
$connectionstring = "server='KERRIGAN';Trusted_Connection=true"
$conn = New-Object Microsoft.SQlServer.Management.Sdk.Sfc.SqlStoreConnection($connectionstring)
#NOTE this is still called DMF, which stands for
#PBM's old name, Declarative Management Framework
$policystore = New-Object Microsoft.SqlServer.Management.DMF.PolicyStore($conn)
#change this to your policy name
$policyname = "PW Expiry"
$policy = $policystore.Policies[$policyname]
#create an XML writer, to enable us to
#write an XML file
$folder = "H:\Temp\"
$policyfilename = "$($policy.Name).xml"
$fullpath = Join-Path $folder $policyfilename
$xmlwriter = [System.Xml.XmlWriter]::Create($fullpath)
$policy.Serialize($xmlwriter)
$xmlwriter.Close()

##--exporting  P261
## Getting start
'In this recipe, we will use an XML policy that comes with the default SQL Server installation.
This policy is called Guest Permissions.xml, and is stored in C:\Program Files
(x86)\Microsoft SQL Server\110\Tools\Policies\DatabaseEngine\1033
'
(1)Open the PowerShell console by going to Start | Accessories | Windows
PowerShell | Windows PowerShell ISE.
(2). Import the SQLPS module, and create a new SMO Server object:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
(3). Add the following script and run:
$connectionstring = "server='KERRIGAN';Trusted_Connection=true"
$conn = New-Object Microsoft.SQlServer.Management.Sdk.Sfc.SqlStoreConnection($connectionstring)
#connect to policystore
$policyStore = New-Object Microsoft.SqlServer.Management.DMF.PolicyStore($conn)
#you can replace this with your own file
$policyXmlPath = "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Policies\DatabaseEngine\1033\Guest Permissions.xml"
$xmlReader = [System.Xml.XmlReader]::Create($policyXmlPath)
#ready to import
$policyStore.ImportPolicy($xmlReader, [Microsoft.SqlServer.Management.Dmf.ImportPolicyEnabledState]::Unchanged, $true, $true)

#list policies to confirm
$policyStore.Policies

##There's more...
The ImportPolicy method accepts four parameters:
 XMLReader that contains the policy
 ImportEnabledState
 A Boolean value for overwriteExistingPolicy
 A Boolean value for overwriteExistingCondition


#-------------------------------------------------------------------
#  11  450   Creating a condition  p.264
#-------------------------------------------------------------------
'we will create a condition called xp_cmdshell is disabled, which checks the Server Security facet, XPCmdShellEnabled.
'
(1). Open the PowerShell ISE. Go to Start | Accessories | Windows PowerShell |
Windows PowerShell ISE.
(2). Import the SQLPS module, and create a new connection object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
$connectionstring ="server='KERRIGAN';Trusted_Connection=true"
$conn = New-Object Microsoft.SQlServer.Management.Sdk.Sfc.SqlStoreConnection($connectionstring)
$policystore = New-Object Microsoft.SqlServer.Management.DMF.PolicyStore($conn)
(3). Add the following script and run:
$conditionName = "xp_cmdshell is disabled"
if ($policystore.Conditions[$conditionName])
{
$policystore.Conditions[$conditionName].Drop()
}
#facet name
#we are retrieving facet name in this manner because
#some facet names are different from the display names
#note this is PowerShell V3 syntax Where-Object syntax
$selectedfacetdisplayname = "Server Security"
$selectedfacet = [Microsoft.SqlServer.Management.Dmf.PolicyStore]::Facets |
Where-Object DisplayName -eq $selectedfacetdisplayname
#if you want to use PowerShell V2 syntax, use the
#following for the Where-Object clause:
#Where-Object {
#$_.DisplayName -eq $selectedfacetdisplayname
#}
#display, for visual reference
$selectedfacet.Name
#create condition
$condition = New-Object Microsoft.SqlServer.Management.Dmf.Condition($conn, $conditionName)
$condition.Facet = $selectedfacet.Name
#a condition consists of a facet, an operator,
#and a value to compare to
$op = [Microsoft.SqlServer.Management.Dmf.OperatorType]::EQ
$attr = New-Object Microsoft.SqlServer.Management.Dmf.ExpressionNodeAttribute("XPCmdShellEnabled")
$value = [Microsoft.SqlServer.Management.Dmf.ExpressionNode]::Cons
tructNode($false)
#create the expression node
#this is equivalent to "@XPCmdShellEnabled = false"
$expressionNode = New-Object Microsoft.SqlServer.Management.Dmf.
ExpressionNodeOperator($op, $attr, $value)

#display expression node that was constructed
$expressionNode
#assign the expression node to the condition, and create
$condition.ExpressionNode = $expressionNode
$condition.Create()
#confirm by displaying conditions in PolicyStore
$policystore.Conditions |
Where Name -eq $conditionName |
Select Name, Facet, ExpressionNode |
Format-Table -AutoSize

## Confirm visually from SQL Server Management Studio:
1. Connect to SSMS.
2. Go to Management and expand Policy Management | Conditions
3. Double-click on the xp_cmdshell is disabled condition


#-------------------------------------------------------------------
#  12  700  Creating  /Evaluating  a policy P.268
#-------------------------------------------------------------------
'
In this recipe, we will use a condition called xp_cmdshell is disabled, which we created in
a previous recipe. Feel free to substitute this with a condition that is available in your instance.
'
(2)Import the SQLPS module, and create a new connection object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
$connectionstring = "server='KERRIGAN';Trusted_Connection=true"
$conn = New-Object Microsoft.SQlServer.Management.Sdk.Sfc.
SqlStoreConnection($connectionstring)
$policystore = New-Object Microsoft.SqlServer.Management.DMF.
PolicyStore($conn)
(3). Add the following script and run:
$policyName = "xp_cmdshell must be disabled"
$conditionName = "xp_cmdshell is disabled"
if ($policystore.Policies[$policyName])
{
$policystore.Policies[$policyName].Drop()
}
#facet name this policy refers to
#note we are using PowerShell V3 syntax in
#Where-Object
$selectedfacetdisplayname = "Server Security"
$selectedfacet = [Microsoft.SqlServer.Management.Dmf.PolicyStore]::Facets |
Where DisplayName -eq $selectedfacetdisplayname
#if you want to use PowerShell V2 syntax, use the
#following for the Where-Object clause:
#Where-Object {$_.DisplayName -eq
#$selectedfacetdisplayname}
#create objectset
#objectset represents a policy-based management set of objects
$objectsetName = "$($policyName)_ObjectSet"
$objectset = New-Object Microsoft.SqlServer.Management.Dmf.ObjectSet($policystore, $objectsetName)
$objectset.Facet = $selectedfacet.Name
$objectset.Create()
#confirm, display objectset name
#again we are using PowerShell V3 simplified
#Where-Object syntax here
$objectset.Name
$policystore.ObjectSets |
Where Name -eq $objectsetName | FL

#if using PowerShell V2, use
#Where {$_.Name -eq $objectsetName} | Format-List
#create policy
$policy = New-Object Microsoft.SQLServer.Management.Dmf.Policy($conn, $policyName)
#assumption here is conditions have been pre-created
#if not, see recipe for creating a condition
$policy.Condition=$conditionName
$policy.ObjectSet = $objectsetName
$policy.AutomatedPolicyEvaluationMode=[Microsoft.SqlServer.Management.Dmf.AutomatedPolicyEvaluationMode]::None
$policy.Create()
#confirm, display policies
#PowerShell V3 syntax
$policystore.Policies |
Where-Object Name -eq $policyName
#PowerShell V2
#Where-Object {$_.Name -eq $policyName}


## The valid values for evaluation mode are:
None            :No policy checking
Enforce         :Use DDL triggers to evaluate or prevent policy violations
CheckOnChanges  :Use event notification to evaluate a policy whenchanges happen
CheckOnSchedule :Use SQL Server Agent to evaluate a policy based on schedule


##--Evaluating p272
'
In this recipe, we will evaluate the policy xp_cmdshell must be disabled, which we
created in a previous recipe. We also want to export this to an XML file, so we can see two
different ways of evaluating the policy. Use the Exporting a policy recipe to export the policy
xp_cmdshell must be disabled and save it in C:\Temp. Alternatively you can:
1. Log in to SQL Server Management Studio.
2. Go to Management | Policy Management and expand Policies.
3. Right-click on the policy xp_cmdshell must be disabled, and select Export Policy.
4. Save this policy in C:\Temp.
Feel free to substitute this with a policy that is available in your instance.'

(2). Import the SQLPS module, and create a new connection object as follows:
#import SQL Server module
Import-Module SQLPS -DisableNameChecking
$instanceName = "KERRIGAN"
$connectionstring = "server='KERRIGAN';Trusted_Connection=true"
$conn = New-Object Microsoft.SQlServer.Management.Sdk.Sfc.
SqlStoreConnection($connectionstring)
$policystore = New-Object Microsoft.SqlServer.Management.DMF.PolicyStore($conn)

(3). Add the following script and run:
$policyName = "xp_cmdshell must be disabled"
$policy = $policystore.Policies[$policyName]
#evaluate using the Evaluate() method
$policy.Evaluate([Microsoft.SqlServer.Management.DMF.AdHocPolicyEvaluationMode]::Check,$conn)
#check evaluation history
Write-Host "$("=" * 100)`n Evaluation Histories`n $("=" * 100)"
$policy.EvaluationHistories
#an alternative way to invoke a policy is
#to use the Invoke-PolicyEvaluation cmdlet instead
#of using the Evaluate() method
#however you need to have a handle to the actual XML file
#this alternative way allows you to capture the results
#which you can save to another XML file
#assuming we have this policy definition in
$file = "C:\Temp\$($policyName).xml"
$result = Invoke-PolicyEvaluation -Policy $file -TargetServer
$instanceName
#display results
Write-Host "$("=" * 100)`n Invocation Result`n $("=" * 100)"
$result

#-------------------------------------------------------------------
#  13   800 PBM default for alwayson
#-------------------------------------------------------------------

 Overall, we define 8 categories in this release – a warning and error category for four different target types.  Here is the full list:


• Availability database errors
Availability database warnings
	○ Policies in these categories run against availability databases (also referred to as database replicas in other parts of the system). The corresponding facet is "Database Replica State".
                                   7:DatabaseReplicaState


• Availability group errors      (any replica role)
Availability group warnings      (any replica role)
	Policies in these categories run against availability groups.  The “any replica role” qualifier indicates that these policies can be run on any replica within the availability group.  
	For example, if I launch the dashboard from a secondary replica, policies in this category will be evaluated.  
	Note that some policies in this category target the underlying Server object. 
	This is necessary to verify properties of the WSFC cluster that are exposed on the Server facet. 
	The corresponding facets are "Availability Group State" and "Server".(28: IAvailabilityGroupState, 66:Server )

• Availability group errors      (primary replica only)\ 
Availability group warnings (primary replica only)
	○ Policies in these categories also run against availability groups.  However the “primary replica only” qualifier indicates that these policies will not be executed on a secondary replica.  For example, if I launch the dashboard from a secondary replica, these policies will not be executed. 
	○ The corresponding facets are "Availability Group State" and "Server".  (IAvailabilityGroupState)

• Availability replica errors\ 
Availability replica warnings
	○ Policies in these categories run against availability replicas. The corresponding facet is "Availability Replica".   (6: AvailabilityReplica)

'
 select name, facet,* from msdb.dbo.syspolicy_policies_internal order by name

AlwaysOn Ag Automatic Failover Health                        IAvailabilityGroupState id:28 Description ID:41406  Helptext ID:41405
AlwaysOn Ag Online State Health                              IAvailabilityGroupState id:28 Description ID:41404  Helptext ID:41403
AlwaysOn Ag Replicas Connection Health                       IAvailabilityGroupState id:28 Description ID:41414  Helptext ID:41413
AlwaysOn Ag Replicas Data Synchronization Health             IAvailabilityGroupState id:28 Description ID:41408  Helptext ID:41407
AlwaysOn Ag Replicas Role Health                             IAvailabilityGroupState id:28 Description ID:41412  Helptext ID:41411
AlwaysOn Ag Synchronous Replicas DataSynchronization  Health IAvailabilityGroupState id:28 Description ID:41410  Helptext ID:41409
AlwaysOn Ag WSFCluster Health                                Server                  id:66 Description ID:41402  Helptext ID:41401
AlwaysOn Ar Connection Health                                AvailabilityReplica     id:6  Description ID:41418  Helptext ID:41417
AlwaysOn Ar Data SynchronizationHealth                       AvailabilityReplica     id:6  Description ID:41420  Helptext ID:41419
AlwaysOn Ar Join StateHealth                                 AvailabilityReplica     id:6  Description ID:41428  Helptext ID:41427
AlwaysOn Ar Role Health                                      AvailabilityReplica     id:6  Description ID:41416  Helptext ID:41415
AlwaysOn Dbr Data Synchronization                            DatabaseReplicaState    id:7  Description ID:41426  Helptext ID:41425
AlwaysOn Dbr Join State                                      DatabaseReplicaState    id:7  Description ID:41424  Helptext ID:41423
AlwaysOn Dbr Suspend State                                   DatabaseReplicaState    id:7  Description ID:41422  Helptext ID:41421
IsHadrEnabled                                                Server                  id:66


AlwaysOn Ag Automatic Failover Health                         Condition   Alwayson Policy Description ID:41406
AlwaysOn Ag Online State Health                               Condition
AlwaysOn Ag Replicas Connection Health                        Condition
AlwaysOn Ag Replicas Data Synchronization Health              Condition
AlwaysOn Ag Replicas Role Health                              Condition
AlwaysOn Ag Synchronous Replicas DataSynchronization  Health  Condition
AlwaysOn Ag WSFCluster Health                                 Condition    Alwayson Policy Description ID:41402
                                                              
AlwaysOn Ar Connection Health                                 Condition
AlwaysOn Ar Data SynchronizationHealth                        Condition
AlwaysOn Ar Join StateHealth                                  Condition
AlwaysOn Ar Role Health                                       Condition
                                                              
AlwaysOn Dbr Data Synchronization                             Condition
AlwaysOn Dbr Join State                                       Condition
AlwaysOn Dbr Suspend State                                    Condition
IsHadrEnabled

'


cd SQLSERVER:\SQL\sql2012x\DEFAULT\AvailabilityGroups 

Test-SqlAvailabilityGroup spmag -ShowPolicyDetails -AllowUserPolicies
Test-SqlAvailabilityReplica  SQLSERVER:\SQL\sql2012x\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas\sp2013  –NoRefresh 

Test-SqlAvailabilityReplica  SQLSERVER:\SQL\sp2013\DEFAULT\AvailabilityGroups\spmag\AvailabilityReplicas\sp2013
sqlps
#-------------------------------------------------------------------
#  14 900        msdb.dbo.syspolicy_policies  for alwayson
#-------------------------------------------------------------------

policy_id           :15                                                 
name                :AlwaysOnAgReplicasConnectionHealthPolicy  
condition_id        :5                                         
root_condition_id   :11                                        
date_created        :2013-08-14 11:45:30.033                   
execution_mode      :0  (0: on demand  , 1:on change: prevent     ,2:on change : log only   ,4:on schedule )                                        
policy_category_id  :6                                         
schedule_uid        :00000000-0000-0000-0000-000000000000    6E136F62-57F6-4EF1-8EFF-43A90949085D   
description         :Alwayson Policy Description ID:41414      
help_text           :Alwayson Policy Helptext ID:41413         
help_link           :swb.agdashboard.agp7allconnected.issues.f1
object_set_id       :15                                         
is_enabled          :0                                         
job_id              :NULL   ED18693E-48AE-426C-B48D-D5344B5C8182                                     
created_by          :sa                                        
modified_by         :NULL     CSD\Administrator                                 
date_modified       :NULL     2014-07-24 10:07:56.880                                 
is_system           :1  (1: system , 0: user) 


#-------------------------------------------------------------------
#  15  900  msdb.dbo.syspolicy_conditions   msdb.dbo.syspolicy_conditions_internal    for alwayson
#-------------------------------------------------------------------



condition_id	       :1
name	               :AlwaysOnAgAutomaticFailoverHealthCondition
date_created	       :2012-02-10 21:09:39.087
description	           :
created_by	           :sa
modified_by	           :sa
date_modified	       :2012-02-10 21:09:39.140
is_name_condition	   :0
facet	               :IAvailabilityGroupState	   ,facet_id  28
expression	           :<Operator> </Operator>
obj_name	           :
is_system              :1





#-------------------------------------------------------------------
#  16  950  look for all  properties facts      Microsoft.SqlServer.Management.Smo Namespace
#-------------------------------------------------------------------
http://msdn.microsoft.com/en-us/library/Microsoft.SqlServer.Management.Smo(v=sql.110).aspx


#-------------------------------------------------------------------
#          
#-------------------------------------------------------------------

Invoke-PolicyEvaluation


sl "SQLSERVER:\SQLPolicy\MyComputer\DEFAULT\Policies"
Get-Item "Database Status" | Invoke-PolicyEvaluation -TargetServerName "MYCOMPUTER"

http://msdn.microsoft.com/en-us/library/cc645987.aspx

Invoke-PolicyEvaluation -Policy "C:\Program Files\Microsoft SQL Server\120\Tools\Policies\DatabaseEngine\1033\Database Status.xml" -TargetServerName "MYCOMPUTER"


Get-Alias