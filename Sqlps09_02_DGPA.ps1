                C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps09_02_DGPA.ps1\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps09_02_DGPA.ps1<#  Sqlps09_01_DGPA auther : ming_tseng    a0921887912@gmail.com createData : Sep.29.2014 for DGPA history :  object :    Invoke-Sqlcmd -Query 'select @@SERVERNAME' -ServerInstance $para_svrinstance -Database $para_database #-QueryTimeout Phase I ;  from 66 database to NHRDB.xxxxx#>#----------------------------------------------------------------------------
#    main  Oct.30.2014
#----------------------------------------------------------------------------

$runDBxx='WEBHR-DB14'
$publisher_login     ='webhr'
$publisher_password  ='webhr~db14'
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

##0
#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber = '$runDBxx' and DBName='371750000A_DB' order by dbNumber"

$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  where  DBNumber = '$runDBxx' order by dbNumber"
#$sql_getDB="select DBNAME,DBNumber,DBUnit from zDBList  order by dbNumber"

$GetDS=Invoke-Sqlcmd  -Query $sql_getDB -ServerInstance $ivSQL  -Database $nDB ;$GetDS ;$GetDS.Count

foreach ($GetD in $GetDS)
{  #p.95
#}#x
## 1 Get DBName

$pdbname  = $GetD.DBNAME; $pdbname

if (($GetD.DBNumber).Length -eq 9)
{ #385
  $publicationName ='n'+($GetD.DBNumber).substring(6,2)+'0'+($GetD.DBNumber).substring(8,1)+'-'+($GetD.DBNAME).substring(0,5)
} #385
else #385
{ #385
  $publicationName ='n'+($GetD.DBNumber).substring(6,4)+'-'+($GetD.DBNAME).substring(0,5)   
}#385
cls;$publicationName
  
$dUnit=$getd.DBUnit
 

'enter  #2'
#2 ---------------------------- 啟用複寫資料庫  if logreader agent not exist 
$tsql2=@"
use master
exec sp_replicationdboption @dbname = N'$pdbname', @optname = N'publish', @value = N'true'
GO

exec [$pdbname].sys.sp_addlogreader_agent @job_login = N'$job_login'
, @job_password = N'$job_password', @publisher_security_mode = 0
, @publisher_login = N'$publisher_login', @publisher_password = N'$publisher_password'
GO
"@
$tsql2

#
#invoke-sqlcmd  -ServerInstance $runDBxx  -Query  'select @@servername;select getdate()' -Username webhr  -Password $publisher_password
Invoke-Sqlcmd  -ServerInstance $runDBxx  -Query  $tsql2 -Username webhr  -Password $publisher_password


#3---------------------------- 正在加入交易式發行集

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
Invoke-Sqlcmd  -ServerInstance $runDBxx  -Query  $tsql3 -Username webhr  -Password $publisher_password


#4 ---------------------------- Snapshot 

$tsql4=@"
exec sp_addpublication_snapshot @publication = N'$publicationName', @frequency_type = 1, @frequency_interval = 0
, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0
, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959
, @active_start_date = 0, @active_end_date = 0, @job_login = N'$job_login', @job_password = N'$job_password'
, @publisher_security_mode = 0, @publisher_login = N'$publisher_login', @publisher_password = N'$publisher_password'
Go
"@
cls;$tsql4
Invoke-Sqlcmd  -ServerInstance $runDBxx  -Query  $tsql4 -Username webhr  -Password $publisher_password -Database $pdbname 

#FGetAllAgent

##5 ----------------------------  正在加入交易式發行項

#$sql_GetArticle="SELECT [tablename] FROM [NHRDB].[dbo].[zArticleList]"
$GetArtS=Invoke-Sqlcmd  -Query "SELECT [tablename] FROM [NHRDB].[dbo].[zArticleList]" -ServerInstance $ivSQL  -Database $nDB ; #$GetArtS.Count

foreach ($GetArt in $GetArtS)
{ #p.443
  $tname=$GetArt.tablename;#$tname

$tsql5=@"
use [$pdbname]
exec sp_addarticle @publication = N'$publicationName', @article = N'$tname', @source_owner = N'dbo', @source_object = N'$tname'
, @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop'
, @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none'
, @destination_table = N'$tname', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false'
, @ins_cmd = N'CALL  [sp_MSins_dbo$tname]'
, @del_cmd = N'CALL  [sp_MSdel_dbo$tname]'
, @upd_cmd = N'SCALL [sp_MSupd_dbo$tname]'
GO
"@  
$tsql5
Invoke-Sqlcmd  -ServerInstance $runDBxx  -Query  $tsql5 -Username webhr  -Password $publisher_password

} #p.443

##6   ----------------------------正在加入交易式訂閱

$tsql6=@"
use [$pdbname]
exec sp_addsubscription @publication = N'$publicationName', @subscriber = N'WEBHR-EDUDB', @destination_db = N'$pdbname'
, @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0

exec sp_addpushsubscription_agent @publication = N'$publicationName', @subscriber = N'WEBHR-EDUDB', @subscriber_db = N'$pdbname'
, @job_login = N'$job_login', @job_password = N'$job_password', @subscriber_security_mode = 0
, @subscriber_login = N'sqlrepladmin', @subscriber_password = N'p@ssw0rdd'
, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1
, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5
, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0
, @active_end_date = 0, @dts_package_location = N'Distributor'
GO
"@

cls;$tsql6
Invoke-Sqlcmd  -ServerInstance $runDBxx  -Query  $tsql6 -Username webhr  -Password $publisher_password


} #p.95  main loop




