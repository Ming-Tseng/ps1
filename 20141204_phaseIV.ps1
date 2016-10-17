<#
C:\Users\administrator.CSD\SkyDrive\download\PS1\20141204_phaseIV.ps1
from : 20141031  phase 2   version :run
author :ming_tseng
Create Date : Nov.03.2014
Last Date  :  Nov.29.2014
ssms


Import-Module 'sqlps'  -DisableNameChecking
#>
#-------------------------------------------------------------
#      main  Phase IV
#-------------------------------------------------------------

#SELECT <published_columns> FROM [dbo].[CPABT02M] WHERE B02IDNO in (select B02IDNO from restable Where B02SEDORG='379000000A')
#C:\Users\webhrreplad\Documents\CreatePublicationPhaseII.sql
#PhaseII

$runDBxx='??'

$publisher_login     ='sqlrepladmin'
$publisher_password  ='p@ssw0rdd'
#$publisher_password  ='1qaz@WSX3edc'

$pdbname       =
$job_login           ='CPAAD001\webhrreplad'
$job_password        ='1qaz2wsx#EDC'

$publicationName     =''
$subscriberNode      ='WEBHR-EDUDB'
$destination_db      =''

$subscriber_login    = 'sqlrepladmin'
$subscriber_password = ''
$ivSQL=$env:COMPUTERNAME
$nDB='NHRDB'

##0------------------------------
$sql_getDB="select distinct dbnumber from [zDBlist] where dbnumber not in ('WEBHR-DB10','WEBHR-DB11','WEBHR-DB12','WEBHR-DB13') order by dbnumber"
$sql_getDB="select distinct dbnumber from [zDBlist] order by dbnumber"
$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber = '$runDBxx' order by dbNumber"


$GetD1S=Invoke-Sqlcmd  -Query $sql_getDB -ServerInstance $ivSQL  -Database $nDB ;$GetDS ;$GetDS.Count
foreach ($GetD1 in $GetD1S)
{  #++++++++++++++++++p.61  loop one
 
$runDBxx=$GetD1.dbnumber;$runDBxx

#-}#p.61

#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber = '$runDBxx' and DBName='376550000A_DB' order by dbNumber"
$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber = '$runDBxx' order by dbNumber"

#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  order by dbNumber"

$GetDS=Invoke-Sqlcmd  -Query $sql_getDB -ServerInstance $ivSQL  -Database $nDB ;$GetDS ;$GetDS.Count

foreach ($GetD in $GetDS)
{  #++++++++++++++++++p.95  loop two
 
 #}#x95

#$pdbname  = $GetD.DBNAME; $pdbname
$pdbname  = "NHRDB"
$DBNumberA= '376550000A_DB'
$DBNumberB= $DBNumberA.Substring(0,10)

if (($GetD.DBNumber).Length -eq 9)
{ #385
  $publicationName ='r'+($GetD.DBNumber).substring(6,2)+'0'+($GetD.DBNumber).substring(8,1)+'-'+($GetD.DBNAME).substring(0,5)
} #385
else #385
{ #385
  $publicationName ='r'+($GetD.DBNumber).substring(6,4)+'-'+($GetD.DBNAME).substring(0,5)   
}#385m
cls;$publicationName
$publicationName='rDB04-37655'
  
$dUnit=$getd.DBUnit

##2 ---------------------------- 啟用複寫資料庫  if logreader agent not exist 
{<#
$tsql2=@"
use master
exec sp_replicationdboption @dbname = N'$pdbname', @optname = N'publish', @value = N'true'
GO

exec [$pdbname].sys.sp_addlogreader_agent @job_login = N'$job_login'
, @job_password = N'$job_password', @publisher_security_mode = 0
, @publisher_login = N'$publisher_login', @publisher_password = N'$publisher_password'
GO
"@
cls;$tsql2

#
#invoke-sqlcmd  -ServerInstance $runDBxx  -Query  'select @@servername;select getdate()' -Username webhr  -Password $publisher_password
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql2 #-Username webhr  -Password $publisher_password

#>}
##3 ---------------------------- 正在加入交易式發行集
{<#
$dUnit=$getd.DBUnit
$tsql3=@"
use [$pdbname]
exec sp_addpublication @publication = N'$publicationName', @description = N'發行者   $runDBxx  '' $pdbname '' $DUnit'
, @sync_method = N'concurrent', @retention = 0, @allow_push = N'true'
, @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true'
, @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous'
, @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous'
, @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false'
, @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1
, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO
"@
cls;$tsql3
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql3 #-Username webhr  -Password $publisher_password
#>}
##4 ---------------------------- Snapshot 
{<#
$tsql4=@"
exec sp_addpublication_snapshot @publication = N'$publicationName', @frequency_type = 1, @frequency_interval = 0
, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0
, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959
, @active_start_date = 0, @active_end_date = 0, @job_login = N'$job_login', @job_password = N'$job_password'
, @publisher_security_mode = 0, @publisher_login = N'$publisher_login', @publisher_password = N'$publisher_password'
Go
"@
cls;$tsql4
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql4 -Database $pdbname 

#FGetAllAgent
#>}
##5 ---------------------------- 正在加入交易式發行項   
#{<#


 $tname='Restable'
 $FilterClause=" b02sedorg in ='$DBNumberB') ";$filterClause
 


$tsql5=@"
use [$pdbname]
exec sp_addarticle @publication = N'$publicationName', @article = N'$tname', @source_owner = N'dbo', @source_object = N'$tname'
, @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop'
, @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none'
, @destination_table = N'$tname', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false'
, @ins_cmd = N'CALL  [sp_MSins_dbo$tname]'
, @del_cmd = N'CALL  [sp_MSdel_dbo$tname]'
, @upd_cmd = N'SCALL [sp_MSupd_dbo$tname]'
, @filter_clause = N'$FilterClause'
GO

-- 正在加入發行項篩選
exec sp_articlefilter @publication = N'$publicationName', @article = N'$tname', @filter_name = N'FLTR_$tname-1__147'
, @filter_clause = N'$FilterClause'
, @force_invalidate_snapshot = 1, @force_reinit_subscription = 1

-- 正在加入發行項同步處理物件
exec sp_articleview @publication = N'$publicationName', @article = N'$tname', @view_name = N'SYNC_$tname-1__147'
, @filter_clause = N'$FilterClause'
, @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO
"@  
$tsql5
#Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql5 #-Username webhr  -Password $publisher_password

#>}

##6   ----------------------------正在加入交易式訂閱
#{<#
$tsql6=@"
use [$pdbname]
exec sp_addsubscription @publication = N'$publicationName', @subscriber = N'WEBHR-EDUDB', @destination_db = N'$DBNumberA'
, @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0

exec sp_addpushsubscription_agent @publication = N'$publicationName', @subscriber = N'WEBHR-EDUDB', @subscriber_db = N'$DBNumberA'
, @job_login = N'$job_login', @job_password = N'$job_password', @subscriber_security_mode = 0
, @subscriber_login = N'sqlrepladmin', @subscriber_password = N'p@ssw0rdd'
, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1
, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5
, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0
, @active_end_date = 0, @dts_package_location = N'Distributor'
GO
"@

cls;$tsql6
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql6 #-Username webhr  -Password $publisher_password


#FGetAllAgent;(FGetAllAgent).count
#>}

}  #+++++++++++++++++++++++++p.95   loop two


}#p.61 loop one

#-------------------------------------------------
#    subscriber 66 ResTalbe  from NHRDB.ResTable
#-------------------------------------------------
{<#


#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber <> 'WEBHR-DB15' order by dbNumber"
$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  order by dbNumber"

$GetDS=Invoke-Sqlcmd  -Query $sql_getDB -ServerInstance $ivSQL  -Database $nDB ;$GetDS ;$GetDS.Count

foreach ($GetD in $GetDS)
{  #290
$pdbname  = $GetD.DBNAME; #$pdbname

$tsql8=@"
use [NHRDB]
exec sp_addsubscription @publication = N'NHRDB_ResTable', @subscriber = N'WEBHR-EDUDB', @destination_db = N'$pdbname'
, @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0

exec sp_addpushsubscription_agent @publication = N'NHRDB_ResTable', @subscriber = N'WEBHR-EDUDB', @subscriber_db = N'$pdbname'
, @job_login = N'$job_login', @job_password = N'$job_password', @subscriber_security_mode = 0
, @subscriber_login = N'sqlrepladmin', @subscriber_password = N'p@ssw0rdd'
, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1
, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5
, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0
, @active_end_date = 0, @dts_package_location = N'Distributor'
GO
"@
$tsql8
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql8 #-Username webhr  -Password $publisher_password

} #290

2014-11-03 14:18:41.673	[A57000000A_DB].dbo.ResTable 	314720
select getdate(),'NHRDb.dbo.ResTable ',count(*) from NHRDb.dbo.ResTable           --WHERE B02SEDORG ='379000000A'
select getdate(),'[379000000A_DB].dbo.ResTable ',count(*) from [379000000A_DB].dbo.ResTable --WHERE B02SEDORG ='379000000A'
select getdate(),'[371000000A_DB].dbo.ResTable ',count(*) from [371000000A_DB].dbo.ResTable --WHERE B02SEDORG ='379000000A'
select getdate(),'[A57000000A_DB].dbo.ResTable ',count(*) from [A57000000A_DB].dbo.ResTable --WHERE B02SEDORG ='379000000A'

#>}


#-------------------------------------------------
#    drop  all  subscription & article  publication
#-------------------------------------------------
{<#
$ddbname='397000000A_DB'
$dpname='iDB04-39700'

$ddbname='382000000A_DB'
$dpname='iDB13-38200'

$ddbname='379000000A_DB'
$dpname='iDB15-37900'


#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber = 'WEBHR-DB12' order by dbNumber"
$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  order by dbNumber"

$GetDS=Invoke-Sqlcmd  -Query $sql_getDB -ServerInstance $ivSQL  -Database $nDB ;$GetDS ;$GetDS.Count
# about 5 min
foreach ($GetD in $GetDS)
{ #498

$pdbname  = $GetD.DBNAME; $pdbname

if (($GetD.DBNumber).Length -eq 9)
{ #385
  $publicationName ='i'+($GetD.DBNumber).substring(6,2)+'0'+($GetD.DBNumber).substring(8,1)+'-'+($GetD.DBNAME).substring(0,5)
} #385
else #385
{ #385
  $publicationName ='i'+($GetD.DBNumber).substring(6,4)+'-'+($GetD.DBNAME).substring(0,5)   
}#385m
#cls;$publicationName
  
$dUnit=$getd.DBUnit




#--------------sp_dropsubscription
$tsql8=@"
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @subscriber = N'WEBHR-EDUDB', @destination_db = N'NHRDB', @article = N'all'
GO
"@
$tsql8
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql8

}#498
#+++++++++++++++++++++++++++++drop all publication +++++++++++++++++++++++++++++++++++++
foreach ($GetD in $GetDS)
{ #529

$pdbname  = $GetD.DBNAME; $pdbname

if (($GetD.DBNumber).Length -eq 9)
{ #385
  $publicationName ='i'+($GetD.DBNumber).substring(6,2)+'0'+($GetD.DBNumber).substring(8,1)+'-'+($GetD.DBNAME).substring(0,5)
} #385
else #385
{ #385
  $publicationName ='i'+($GetD.DBNumber).substring(6,4)+'-'+($GetD.DBNAME).substring(0,5)   
}#385m
#cls;$publicationName
  
$dUnit=$getd.DBUnit

$tsql_87=@"
-- 正在卸除交易式發行項
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT01M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT02M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT02M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT03M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT03M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT04M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT04M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT05M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT05M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT06M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT06M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT07M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT07M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT08M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT08M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT10M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT10M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT13M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT13M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT16M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT16M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT19M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT19M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT20M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT20M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT21M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT21M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT21MD', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT21MD', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT22M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT22M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT23M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT23M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT34M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT34M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT35M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT35M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT36M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT36M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT37M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT37M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT38M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT38M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPABT51M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPABT51M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPACA01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPACA01M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAET01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAET01M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAET02M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAET02M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAET06M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAET06M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAET11M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAET11M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAOA01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAOA01M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAOA02M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAOA02M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAOA03M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAOA03M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPAOA04M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPAOA04M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPARA01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPARA01M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPARB01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPARB01M', @force_invalidate_snapshot = 1
GO
use [$pdbname]
exec sp_dropsubscription @publication = N'$publicationName', @article = N'CPARM01M', @subscriber = N'all', @destination_db = N'all'
GO
use [$pdbname]
exec sp_droparticle @publication = N'$publicationName', @article = N'CPARM01M', @force_invalidate_snapshot = 1
GO

-- 正在卸除交易式發行集
use [$pdbname]
exec sp_droppublication @publication = N'$publicationName'
GO
"@
$tsql_87
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql_87

} #529s
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++






#--------------
$tsql50="SELECT [tablename] FROM [NHRDB].[dbo].[zArticleList] where sysname='個人子系統' or (tablename in ('CPAET02M'))"
$GetArtS=Invoke-Sqlcmd  -Query $tsql50 -ServerInstance $ivSQL  -Database $nDB ; $GetArtS.Count

foreach ($GetArt in $GetArtS)
{ #p.898
  $tname=$GetArt.tablename;#$tname
$tsql9=@"
use [$ddbname]
exec sp_dropsubscription @publication = N'$dpname', @article = N'$tname', @subscriber = N'all', @destination_db = N'all'
GO

use [$ddbname]
exec sp_droparticle @publication = N'$dpname', @article = N'$tname', @force_invalidate_snapshot = 1
GO

"@
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql9
} #p.898



#>}



#-------------------------------------------------
#  re-initial 
#-------------------------------------------------
{ <#

$tsql_select=@"
select distinct p.publication as [Publication],p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id where publication <> 'NHRDB_ResTable' and Publication  not like 'idB13-%'and Publication  not like 'idB15-%'and Publication  not like 'idB08-%'and Publication  not like 'idB04-%'and Publication  not like 'idB03-%'and Publication  not like 'idB02-%'"@

$tsql_select=@"
select distinct p.publication as [Publication],p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id where publication <> 'NHRDB_ResTable' and Publication  like 'idB02%'"@


$getSubscriberS=Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql_select
$getSubscriberS.count

foreach ($getSubscriber in $getSubscriberS)
{ #511
$Publication=$getSubscriber.Publication
$publisherdb=$getSubscriber.publisherdb
#$subscriber=$getSubscriber.subscriber
    
$tsql_reinit=@"USE [$publisherdb]  EXEC sp_startpublication_snapshot @publication = N'$Publication';USE [$publisherdb] EXEC sp_reinitsubscription  @subscriber = N'WEBHR-EDUDB',@destination_db = N'NHRDB',@publication = N'$Publication';
"@
$tsql_reinit
#Start-Sleep 600
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql_reinit #-Username webhr  -Password $publisher_password
}  #511
#>}

#-------------------------------------------------
#    from distribution.dbo.MSpublications
#-------------------------------------------------
{
<#select b.name,a.publication,a.publisher_db,a.publication_id,' * ',* from distribution.dbo.MSpublications a
join sys.servers b on a.publisher_id=b.server_id order by b.name,a.publication,a.publisher_db

$tsql_select=@"
select distinct p.publication as [Publication],p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id where publication <> 'NHRDB_ResTable'"@
#>}

#-------------------------------------------------
#    truncate  table 
#-------------------------------------------------
{<#
#$tsql521="SELECT [tablename] FROM [NHRDB].[dbo].[zArticleList] where  tablename like  ('CPAOA0%M') or tablename like  ('CPAR%01M') or tablename in ('CPAET01M','CPAET06M','CPAET11M') "
$tsql521="SELECT [tablename] FROM [NHRDB].[dbo].[zArticleList]"

$GetArtS=Invoke-Sqlcmd  -Query $tsql521 -ServerInstance $ivSQL  -Database $nDB ; $GetArtS.Count

foreach ($GetArt in $GetArtS)
{ #p.truncate
  $tname=$GetArt.tablename;#$tname
  $tsql522=@"
--truncate table [NHRDB].[dbo].[$tname] ;
--truncate table [A09000000E_DB].[dbo].[$tname]
--select '$tname',count(*) from [A09000000E_DB].[dbo].[$tname]
select '$tname',count(*) from [NHRDB].[dbo].[$tname]

"@  
#$tsql522
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql522 -QueryTimeout 2400  #-Username webhr  -Password $publisher_password
} #p.truncate
#>

}

#-------------------------------------------------
#   insert into 
#-------------------------------------------------
{<#
$tsql_getDBList ='select dbname from NHRDB.dbo.zDBlist'
$GetArtSq=Invoke-Sqlcmd  -Query $tsql_getDBList -ServerInstance $ivSQL  -Database $nDB ; $GetArtSq.Count

foreach ($GetArtq in $GetArtSq)
{ #609
    $dblistn=$GetArtq.dbname ; $dblistn
$tsql521="SELECT [tablename] FROM [NHRDB].[dbo].[zArticleList] where  tablename like  ('CPAOA0%M') or tablename like  ('CPAR%01M') or tablename in ('CPAET01M','CPAET02M','CPAET06M','CPAET11M') "
$GetArtS=Invoke-Sqlcmd  -Query $tsql521 -ServerInstance $ivSQL  -Database $nDB ; $GetArtS.Count

foreach ($GetArt in $GetArtS)
{ #p.insert into
  $tname=$GetArt.tablename;#$tname
  switch ($tname)
  { # 212
  
      'CPAOA01M' { #01
$go=@"
      insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] 
      where OA1ORG IN (SELECT ORG_ID FROM ORG_CODE WHERE OA1ORG = Org_ID AND (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') 
      AND LVL2_ORG IN (SELECT OA1ORG FROM CPAOA01M))
"@
$go
     Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $go -QueryTimeout  3600
      
      }
  }# 212-
  }# insert into-
  } #609-    
      'CPAOA02M' {#02
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where  OA2ORG IN (SELECT ORG_ID FROM ORG_CODE WHERE OA2ORG=Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M )) "
      }
      
      'CPAOA03M' { #03
      
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where  OA3ORG IN (SELECT ORG_ID FROM ORG_CODE WHERE OA3ORG=Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301')  AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M )) ";
      }
      
      'CPAOA04M' {#04
      
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where OA4ORG IN (SELECT ORG_ID FROM ORG_CODE WHERE OA4ORG=Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M ))  ";
      } 
      
       'CPAET01M' {#05
      
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where E01SORCOD  IN (SELECT ORG_ID FROM ORG_CODE WHERE E01SORCOD =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M ))  ";
      } 
      
       'CPAET02M' {#06
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where E02IDNO IN (SELECT E01IDNO FROM CPAET01M (NOLOCK) WHERE E01SORCOD  IN (SELECT ORG_ID FROM ORG_CODE WHERE  E01SORCOD =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M ))) "
      } 
      
       'CPAET06M' {#07
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where E06SORCOD  IN (SELECT ORG_ID FROM ORG_CODE WHERE  E06SORCOD =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M )) ";
      } 
      
       'CPAET11M' {#08
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where E11SORCOD  IN (SELECT ORG_ID FROM ORG_CODE WHERE E11SORCOD =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M )) ";
      } 
       'CPARA01M' {#09
      
       $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where RAGORG  IN (SELECT ORG_ID FROM ORG_CODE WHERE RAGORG =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M )) ";
      } 
       'CPARB01M' {#10
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where RBGORG  IN (SELECT ORG_ID FROM ORG_CODE WHERE RBGORG =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M )) ";
      } 
      Default {
      $go="insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname] where RMID IN (SELECT RAID FROM CPARA01M (NOLOCK) WHERE RAGORG  IN (SELECT ORG_ID FROM ORG_CODE WHERE RAGORG =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301')  AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M ))) OR  RMID IN (SELECT  RBID FROM CPARB01M (NOLOCK) WHERE RBGORG  IN (SELECT ORG_ID FROM ORG_CODE WHERE RBGORG =Org_ID AND  (C_AFFECT_DATE is null or C_AFFECT_DATE='' or C_AFFECT_DATE>='0990301') AND LVL2_ORG IN  (SELECT OA1ORG FROM CPAOA01M ))) ";$filterClause
   }
  }#p.212
  $tsql522=@"
  $go
"@ 
$tsql522
Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $tsql522 -QueryTimeout  3600
} #p.insert into

}  #609




#--insert into  [NHRDB].dbo.[$tname] select * from [$dblistn].[dbo].[$tname]

#>}

#-------------------------------------------------
#    backup 
#-------------------------------------------------
{<#
dbcc sqlperf('logspace')

Backup database  nhrdb to disk='D:\repldata\WEBHR.bak'
Backup Log  nhrdb to disk='D:\repldata\WEBHR.trn'


#>}


#-------------------------------------------------
#  TSQL check 
#-------------------------------------------------
{<#




select getdate(),'NHRDb.dbo.ResTable ',count(*) from NHRDb.dbo.ResTable           WHERE B02SEDORG ='379000000A'
select getdate(),'[379000000A_DB].dbo.ResTable ',count(*) from [379000000A_DB].dbo.ResTable WHERE B02SEDORG ='379000000A'


select getdate(),'N[379000000A_DB].dbo.CPABT01M ',count(*) from  [379000000A_DB].dbo.CPABT01M a
select getdate(),'NHRDb.dbo.CPABT01M ',count(*) as N from NHRDb.dbo.CPABT01M
select getdate(),'N[379000000A_DB].dbo.CPABT02M ',count(*) from  [379000000A_DB].dbo.CPABT02M a
select getdate(),'NHRDb.dbo.CPABT02M ' as N,count(*) from NHRDb.dbo.CPABT02M

select getdate(),'N[379000000A_DB].dbo.CPAOA01M ',count(*) from  [379000000A_DB].dbo.CPAOA01M a
select getdate(),'NHRDb.dbo.CPAOA01M' as N,count(*) from NHRDb.dbo.CPAOA01M                              

#------------------------------ -----------
N[379000000A_DB].dbo.CPABT01M  126869
#------------------- -----------
NHRDb.dbo.CPABT01M  72137
#------------------------------ -----------
N[379000000A_DB].dbo.CPABT02M  128615
#------------------- -----------
NHRDb.dbo.CPABT02M  72204

                               
#------------------------------ -----------
N[379000000A_DB].dbo.CPAOA01M  507
#------------------- -----------
NHRDb.dbo.CPAOA01M  507




                                            
----------------------- ------------------- -----------
2014-11-03 12:17:42.473 NHRDb.dbo.ResTable  78848
----------------------- ----------------------------- -----------
2014-11-03 12:17:42.570 [379000000A_DB].dbo.ResTable  78848
----------------------- ------------------------------ -----------
2014-11-03 12:17:42.663 N[379000000A_DB].dbo.CPABT01M  126874
----------------------- ------------------- -----------
2014-11-03 12:17:42.703 NHRDb.dbo.CPABT01M  72138
----------------------- ------------------------------ -----------
2014-11-03 12:17:42.730 N[379000000A_DB].dbo.CPABT02M  128619
----------------------- ------------------- -----------
2014-11-03 12:17:42.753 NHRDb.dbo.CPABT02M  72205
----------------------- ------------------------------ -----------
2014-11-03 12:17:42.780 N[379000000A_DB].dbo.CPAOA01M  507                  
#----------------------- ------------------ -----------
2014-11-03 12:17:42.780 NHRDb.dbo.CPAOA01M 507

#>}
<#
nono

use [371000000A_DB]
exec sp_addarticle @publication = N'88', @article = N'CPARM01M', @source_owner = N'dbo'
, @source_object = N'CPARM01M', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'none'
, @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'CPARM01M'
, @destination_owner = N'dbo', @vertical_partition = N'false'
, @ins_cmd = N'CALL sp_MSins_dboCPARM01M'
, @del_cmd = N'CALL sp_MSdel_dboCPARM01M'
, @upd_cmd = N'SCALL sp_MSupd_dboCPARM01M'
GO
a

delete

use [371000000A_DB]
exec sp_addarticle @publication = N'88', @article = N'CPARM01M', @source_owner = N'dbo'
, @source_object = N'CPARM01M', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'delete'
, @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'CPARM01M'
, @destination_owner = N'dbo', @vertical_partition = N'false'
, @ins_cmd = N'CALL sp_MSins_dboCPARM01M'
, @del_cmd = N'CALL sp_MSdel_dboCPARM01M'
, @upd_cmd = N'SCALL sp_MSupd_dboCPARM01M'
GO
#>
($tt2-$tt1).TotalMinutes
($tt2-$tt1).TotalSeconds


#-------------------------------------------------
#    find
#-------------------------------------------------
{<#

$sql_alldb ="select DBNAME,DBNumber,DBUnit from zDBList   order by dbNumber"
#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  order by dbNumber"

$GetDS_alldbS=Invoke-Sqlcmd  -Query $sql_alldb -ServerInstance $ivSQL  -Database $nDB ;#$GetDS_alldbS.Count
$eid='A127718977'

#$i=$GetDS_alldbS.Count
foreach ($GetDS_alldb in $GetDS_alldbS)
{ #331
#$i
$pdbname=$GetDS_alldb.DBNAME; #$pdbname

$tsql521="select '$pdbname',count(*) as countx ,e01Idno,e01sorcod  from [$pdbname].[dbo].[CPAET01M] where E01IDNO='$eid' group by  e01Idno,e01sorcod "
$GetArtS=Invoke-Sqlcmd  -Query $tsql521 -ServerInstance $ivSQL  -Database $nDB ; #$GetArtS

$GetArtS


#$i=$i-1
} #331a

select * from [$pdbname].[dbo].[CPAET01M] where E01IDNO='A127718977' 
select * from [376500000A_DB].[dbo].[CPAET01M] where E01IDNO='A127718977' 


#>}
