                C:\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps09_01_DGPA.ps1\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\Sqlps09_01_DGPA.ps1<#  Sqlps09_01_DGPA auther : ming_tseng    a0921887912@gmail.com createData : Sep.29.2014 for DGPA history :  object :    Invoke-Sqlcmd -Query 'select @@SERVERNAME' -ServerInstance $para_svrinstance -Database $para_database #-QueryTimeout#>

#---------------------------------------------------------------#  CREATE DATABASE   initial  NHRDB#---------------------------------------------------------------
{

$ivSQL="DGPAP2"
$ivdatabase='NHRDB'


Decalre

$DBName="NHRDB"
$LogName=$DBName+"_log"
$DBDataPath="H:\SQLDB\"+$DBName+".mdf"
$DBLogPath ="H:\SQLDB\"+$DBName+"_log.ldf"

 $sql_cretaeDB = @"CREATE DATABASE $DBName b 
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'$DBName', FILENAME = N'$DBDataPath' , SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'$LogName', FILENAME = N'$DBLogPath' , SIZE = 1024KB , FILEGROWTH = 10%)
GO"@ Invoke-Sqlcmd -Query $sql_cretaeDB -ServerInstance $ivSQL  #-QueryTimeout#Invoke-Sqlcmd -Query 'select @@SERVERNAME' -ServerInstance $ivSQL -Database $para_database #-QueryTimeou}
#---------------------------------------------------------------#  CREATE table  DBlist   #---------------------------------------------------------------
{

 $sql_createTable = @" Use $DBName
 CREATE TABLE [dbo].[DBlist]( DBName  [nvarchar](50),
 DBNumber[nvarchar](50),
 DBUnit  [nvarchar](50),
 DBcode  [nvarchar](50)
 )
 insert into [DBlist] values ('DB13NTPC3832','DB13','新北市政府','383200001A')
 insert into [DBlist] values ('DB01kaoG3832','DB01','高雄市政府','A39200001A')"@

Invoke-Sqlcmd -Query $sql_createTable -ServerInstance $ivSQL -Database $DBName #-QueryTimeout
}
#---------------------------------------------------------------#  CREATE DATABASE   from  DBlist#---------------------------------------------------------------
 {
 $DBlists = Invoke-Sqlcmd -Query "SELECT DBName FROM DBlist" -ServerInstance $ivSQL -Database $DBName
 foreach ($DBlist in $DBlists)
 { #p.66
    

$wDBName= $DBlist.DBName
$wLogName=$wDBName+"_log"
$wDBDataPath="H:\SQLDB\"+$wDBName+".mdf"
$wDBLogPath ="H:\SQLDB\"+$wDBName+"_log.mdf"

 $sql_cretaeDB = @"CREATE DATABASE $wDBName
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'$wDBName', FILENAME = N'$wDBDataPath' , SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'$wLogName', FILENAME = N'$wDBLogPath' , SIZE = 1024KB , FILEGROWTH = 10%)
GO"@
Invoke-Sqlcmd -Query $sql_cretaeDB -ServerInstance $ivSQL 
sleep 2
 } #p.66



 }
#---------------------------------------------------------------#  view#---------------------------------------------------------------Invoke-Sqlcmd -Query $sql_cretaeDB -ServerInstance $ivSQL   -Database  DB01kaoG3832#---------------------------------------------------------------#  Get jobs#---------------------------------------------------------------FGetAllAgent{$sql_getAgent=@"--select j.name as [AgentName],c.name as[AgentType],c.category_id as [CategoryId],j.date_created as [DateCreated]
select j.name as [AgentName],c.name as[AgentType],j.date_created as [DateCreated]
from msdb.dbo.sysjobs j
join  msdb.dbo.syscategories c on j.category_id=c.category_id 
--where j.name like 'SP2013%'
order by date_created desc ,j.name
"@#$tb1=Invoke-Sqlcmd -Query $sql_getAgent -ServerInstance DGPAP2  |ft -AutoSize;$tb1 #$tb2=Invoke-Sqlcmd -Query $sql_getAgent -ServerInstance $distServer$tb1;$tb2function FGetAllAgent {
Invoke-Sqlcmd -Query $sql_getAgent -ServerInstance $distServer}}#---------------------------------------------------------------#  Get   all pubication#---------------------------------------------------------------{function FGetallpubication ()
{#p.142
    $sql_allpubication=@"select b.name [name],a.publication as [publication],a.publisher_db [publisherDB],a.publication_id [PublicationID]
 from distribution.dbo.MSpublications a
join sys.servers b on a.publisher_id=b.server_id order by b.name,a.publication,a.publisher_db"@Invoke-Sqlcmd -Query $sql_allpubication -ServerInstance $distServer 
}#p.142}#---------------------------------------------------------------#  droppublication#---------------------------------------------------------------{$sql_droppublication=@"use $wdbname ;exec sp_droppublication @publication = N'$PName'
GO
"@Invoke-Sqlcmd -Query $sql_droppublication -ServerInstance $publisherServer ##confirmInvoke-Sqlcmd -Query $sql_allpubication -ServerInstance $distServer
}Invoke-Sqlcmd -Query 'select @@SERVERNAME' -ServerInstance $distServer -Database $para_database #-QueryTimeout#---------------------------------------------------------------#  sp_helppublication#---------------------------------------------------------------Invoke-Sqlcmd -Query  "exec sp_helppublication" -ServerInstance $publisherServer -Database  $wdbname Invoke-Sqlcmd -Query  "exec sp_who2" -ServerInstance $publisherServer  # -Database  $wdbname #---------------------------------------------------------------#  ** main paratmeter #---------------------------------------------------------------$publisherServer='sp2013'$distServer='DGPAP2'$subscriberServer='DGPAP2'$wdbname='S4'$sdbname='DB01kaoG3832'$PName='sp2013_S4_To_DGPAP2_B01'$Pdescription='Transactional by Ming'$job_login='csd\administrator'$job_password='p@ssw0rd'$publisher_login='sa'$publisher_password='p@ssw0rd'$subscriber_login='sa'$subscriber_password='p@ssw0rd'#---------------------------------------------------------------#  sp_replicationdboption ( sql_enablereplication)#---------------------------------------------------------------{$sql_enablereplication=@"-- Enabling the replication database
use $wdbname
exec sp_replicationdboption @dbname = N'$wdbname', @optname = N'publish', @value = N'true'
"@


Invoke-Sqlcmd -Query $sql_enablereplication -ServerInstance $publisherServer  }#---------------------------------------------------------------#  add_logreader_agent#---------------------------------------------------------------# Get Invoke-Sqlcmd -Query $sql_getAgent -ServerInstance $distServer #{$sql_addlogreader_agent=@"

exec [$wdbname].sys.sp_addlogreader_agent @job_login = N'$job_login'
, @job_password = $job_password
, @publisher_security_mode = 0
, @publisher_login    = N'$publisher_login'
, @publisher_password = N'$publisher_password'
, @job_name = null
GO"@Invoke-Sqlcmd -Query $sql_addlogreader_agent -ServerInstance $publisherServer  -Database  $wdbnameInvoke-Sqlcmd -Query $sql_getAgent -ServerInstance DGPAP2  # passed}#---------------------------------------------------------------#  add publication#---------------------------------------------------------------Invoke-Sqlcmd -Query $sql_allpubication -ServerInstance $distServer Invoke-Sqlcmd -Query $sql_getAgent -ServerInstance $distServer {$sql_addpublication =@"
use [$wDBName]
exec sp_addpublication @publication = N'$PName'
, @description = N'$Pdescription'
, @sync_method = N'concurrent'
, @retention = 0
, @allow_push = N'true'
, @allow_pull = N'true'
, @allow_anonymous = N'true'
, @enabled_for_internet = N'false'
, @snapshot_in_defaultfolder = N'true'
, @compress_snapshot = N'false'
, @ftp_port = 21
, @allow_subscription_copy = N'false'
, @add_to_active_directory = N'false'
, @repl_freq = N'continuous'
, @status = N'active'
, @independent_agent = N'true'
, @immediate_sync = N'true'
, @allow_sync_tran = N'false'
, @allow_queued_tran = N'false'
, @allow_dts = N'false'
, @replicate_ddl = 1
, @allow_initialize_from_backup = N'false'
, @enabled_for_p2p = N'false'
, @enabled_for_het_sub = N'false'
GO"@Invoke-Sqlcmd -Query $sp_addpublication -ServerInstance $publisherServer  -Database $wDBName# getInvoke-Sqlcmd -Query $sql_allpubication -ServerInstance $distServer }#---------------------------------------------------------------#  add  publication_snapshot#---------------------------------------------------------------
Invoke-Sqlcmd -Query $sql_getAgent -ServerInstance $distServer 

{
$sql_addpublication_snapshot =@"
exec sp_addpublication_snapshot @publication = N'$PName'
, @frequency_type = 1
, @frequency_interval = 0
, @frequency_relative_interval = 0
, @frequency_recurrence_factor = 0
, @frequency_subday = 0
, @frequency_subday_interval = 0
, @active_start_time_of_day = 0
, @active_end_time_of_day = 235959
, @active_start_date = 0
, @active_end_date = 0
, @job_login = N'$job_login'
, @job_password = $job_password
, @publisher_security_mode = 0
, @publisher_login = N'$publisher_login'
, @publisher_password = N'$publisher_password'
"@

Invoke-Sqlcmd -Query $sql_addpublication_snapshot -ServerInstance $publisherServer  -Database $wDBName}

#---------------------------------------------------------------#  add article#---------------------------------------------------------------
{
$article='t2'
$sql_addarticle =@"
exec sp_addarticle @publication = N'$PName'
, @article = N'$article'
, @source_owner = N'dbo'
, @source_object = N'$article'
, @type = N'logbased'
, @description = null
, @creation_script = null
, @pre_creation_cmd = N'drop'
, @schema_option = 0x000000000803509F
, @identityrangemanagementoption = N'manual'
, @destination_table = N'$article'
, @destination_owner = N'dbo'
, @vertical_partition = N'false'
, @ins_cmd = N'CALL sp_MSins_dbo$article'
, @del_cmd = N'CALL sp_MSdel_dbo$article'
, @upd_cmd = N'SCALL sp_MSupd_dbo$article'
GO

"@

Invoke-Sqlcmd -Query $sql_addarticle -ServerInstance $publisherServer  -Database $wDBName

$sql_Getarticle =@"
use distribution
select name as [Name],b.publication as [publication],b.publisher_db [publisher_db],a.article  [article]  from [distribution].. MSarticles aJOIN sys.servers AS sub on a.publisher_id=sub.server_idjoin distribution.dbo.MSpublications b on b.publication_id=a.publication_idorder by a.publication_id  
"@
Invoke-Sqlcmd -Query $sql_Getarticle -ServerInstance $distServer #-Database $wDBName

#---------------------------------------------------------------

 $article='t2'
$sql_addarticle =@"
exec sp_addarticle @publication = N'$PName'
, @article = N'$article'
, @source_owner = N'dbo'
, @source_object = N'$article'
, @type = N'logbased'
, @description = null
, @creation_script = null
, @pre_creation_cmd = N'drop'
, @schema_option = 0x000000000803509F
, @identityrangemanagementoption = N'manual'
, @destination_table = N'$article'
, @destination_owner = N'dbo'
, @vertical_partition = N'false'
, @ins_cmd = N'CALL sp_MSins_dbo$article'
, @del_cmd = N'CALL sp_MSdel_dbo$article'
, @upd_cmd = N'SCALL sp_MSupd_dbo$article'
GO

"@

Invoke-Sqlcmd -Query $sql_addarticle -ServerInstance $publisherServer  -Database $wDBName
 }
 #---------------------------------------------------------------
 #  drop article
 #---------------------------------------------------------------
 {$article='t2'
$sql_droparticle =@"
 EXEC sp_droparticle 
  @publication = $PName, 
  @article = $article,
  @force_invalidate_snapshot = 1;
GO
"@
Invoke-Sqlcmd -Query $sql_droparticle -ServerInstance $publisherServer -Database $wDBName
}
#---------------------------------------------------------------
# Adding the transactional subscriptions
#---------------------------------------------------------------
{
$sql_addsubscriptions =@"
exec sp_addsubscription @publication = N'$PName'
, @subscriber = N'$subscriberServer'
, @destination_db = N'$sdbname'
, @subscription_type = N'Push'
, @sync_type = N'automatic'
, @article = N'all'
, @update_mode = N'read only'
, @subscriber_type = 0
"@

Invoke-Sqlcmd -Query $sql_addsubscriptions -ServerInstance $publisherServer  -Database $wDBName

$sql_addpushsubscription_agent =@"
exec sp_addpushsubscription_agent @publication = N'$PName'
, @subscriber = N'$subscriberServer'
, @subscriber_db = N'$sdbname'
, @job_login = N'$job_login'
, @job_password = $job_password
, @subscriber_security_mode = 0
, @subscriber_login = N'$subscriber_login'
, @subscriber_password = $subscriber_password
, @frequency_type = 64
, @frequency_interval = 1
, @frequency_relative_interval = 1
, @frequency_recurrence_factor = 0
, @frequency_subday = 4
, @frequency_subday_interval = 5
, @active_start_time_of_day = 0
, @active_end_time_of_day = 235959
, @active_start_date = 0
, @active_end_date = 0
, @dts_package_location = N'Distributor'
GO
"@
Invoke-Sqlcmd -Query $sql_addpushsubscription_agent -ServerInstance $publisherServer  -Database $wDBName

}
#---------------------------------------------------------------#   sql_pushReinitial#---------------------------------------------------------------
Insert into  sp2013.S4.dbo.t2  select * from sp2013.S4.dbo.bt2
INSERT INTO  sp2013.s4.dbo.t2  VALUES   ('B','元大中','1070004',GETDATE())
UPDATE sp2013.S4.dbo.t2  SET  [b01birthd] = '1070002' ,[Modtime] = getdate() WHERE [b01idno]='B' 
select * from sp2013.s4.dbo.t2
select * from DGPAP2.DB01kaoG3832.dbo.t2

delete from  DGPAP2.DB01kaoG3832.dbo.t2 where b01idno ='B'
delete from  sp2013.s4.dbo.t2 where b01idno ='B'


select  a.name from distribution.dbo.MSdistribution_agents a
join sys.servers b on a.publisher_id=b.server_id
where publication='sp2013_S4_To_DGPAP2_B01'
order by b.name,a.publication


 reinitPx sp2013 sp2013_S4_To_DGPAP2_B01 DGPAP2
function reinitPx 
{ #p.63 
Param(
  [string] $publisherServer,
  [string] $PName,
  [string] $distServer
)
$dDBName='distribution'
##
$tsql_select=@"      
select distinct p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id
where p.publication='$PName'
"@
$getpublication=Invoke-Sqlcmd -Query $tsql_select -ServerInstance $distServer  -Database $dDBName
$publisherdb =$getpublication.publisherdb
$subscriber  =$getpublication.subscriber
$subscriberdb=$getpublication.subscriberdb
##
$tsql_selectagent=@"  
select name FROM [distribution]..MSsnapshot_agents where publication='$PName'
"@
$snapshotagent=Invoke-Sqlcmd -Query $tsql_selectagent -ServerInstance $distServer  -Database $dDBName
$snapshotA=$snapshotagent.name
##$tsql_select=@" use $publisherdb
EXEC sp_reinitsubscription 
    @subscriber     = N'$subscriber',
    @destination_db = N'$subscriberdb',
    @publication    = N'$PName';
GO"@Invoke-Sqlcmd -Query $tsql_select -ServerInstance $publisherServer  -Database $publisherdbsleep 3##$tsql_start=@" EXEC sp_start_job N'$snapshotA'"@ Invoke-Sqlcmd -Query $tsql_start -ServerInstance $distServer  -Database 'msdb'}#p.63

REPL-Distribution
REPL-Snapshot
REPL-LogReader




#---------------------------------------------------------------#   20  stop / start  replicatoin Jobs#---------------------------------------------------------------

{
	1.  stop    all agent 
	EXEC msdb.dbo.sp_stop_job N'DGPAP1-S1-42'	                --39.S1 LogReader	13
	EXEC msdb.dbo.sp_stop_job N'DGPAP1-S1-DGPAP1S1-DGPAP2-107'	--39.S1 -Distribution	10
	EXEC msdb.dbo.sp_stop_job N'SP2013-S4-SP2013S4-DGPAP2-110' ;--29.S4 Distribution
	EXEC msdb.dbo.sp_stop_job N'SP2013-S4-28' ;                 --29.S4 LogReader
			
	EXEC DGPAP2.msdb.dbo.sp_start_job N'DGPAP1-S1-42'	                  --39.S1 LogReader	13
	EXEC DGPAP2.msdb.dbo.sp_start_job N'DGPAP1-S1-DGPAP1S1-DGPAP2-107'	  --39.S1 -Distribution	10
	EXEC DGPAP2.msdb.dbo.sp_start_job N'SP2013-S4-SP2013S4-DGPAP2-110' ; --29.S4 Distribution
	EXEC DGPAP2.msdb.dbo.sp_start_job N'SP2013-S4-28' ;                  --29.S4 LogReader
	
	EXEC msdb.dbo.sp_start_job N'SP2013-S4-SP2013S4-49' ;             --29.S4 Snapshot	
	EXEC msdb.dbo.sp_stop_job N'DGPAP1-S1-DGPAP1S1-48'	--39.S1 -Snapshot	15
	
	
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-51'	                --REPL-LogReader
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-DGPAP2Psa-52'	        --REPL-Snapshot
	EXEC msdb.dbo.sp_stop_job N'SP2013-S4-sp2013_S4_To_DGPAP2_B-DGPAP2-133'	--REPL-Distribution
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-DGPAP2Psa-SP2013-116'	--REPL-Distribution
	
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-51'	                --REPL-LogReader
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-DGPAP2Psa-52'	        --REPL-Snapshot
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-DGPAP2Psa-DGPAP1-115'	--REPL-Distribution
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-DGPAP2Psa-SP2013-116'	--REPL-Distribution
}#---------------------------------------------------------------#    Agent status#---------------------------------------------------------------FGetallAgentStatusFGetAgentStatus
{#-Database $wDBNamefunction FGetAgentStatus ( [string]  $AgentName)
{
$sql_k=@"
	     SELECT 1 
          FROM msdb.dbo.sysjobs J 
          JOIN msdb.dbo.sysjobactivity A 
              ON A.job_id=J.job_id 
          WHERE J.name=N'$AgentName' 
          AND A.run_requested_date IS NOT NULL 
          AND A.stop_execution_date IS NULL
"@
  #(Invoke-Sqlcmd -Query $sql_k -ServerInstance $distserver).count
  if ((Invoke-Sqlcmd -Query $sql_k -ServerInstance $distserver).count -eq 0 )
  {
      'stopped'
  }
  else
  {
      'running' 
  }
  
}FGetAgentStatus 'SP2013-S4-sp2013_S4_To_DGPAP2_B-DGPAP2-133' FGetAgentStatus 'SP2013-S4-sp2013_S4_To_DGPAP2_B01-60' FGetAgentStatus 'SP2013-S4-58' function FGetallAgentStatus ()
{
   Foreach ($item in FGetallAgent)
{
 # Write-Host  GetAgentStatus $item.AgentName # -nonewline ; $item
 write-Host $item[0] '[' $item[1] ']   --'  -NoNewline ;    FGetAgentStatus $item.AgentName
}                  
    
} }                                  
#---------------------------------------------------------------#   #----------------------------------------------------------------- Adding the transactional articles
use [S1]
exec sp_addarticle @publication = N'DGPAP1S1'
, @article = N'T2'
, @source_owner = N'dbo'
, @source_object = N'T2'
, @type = N'logbased'
, @description = N''
, @creation_script = N''
, @pre_creation_cmd = N'delete'  --套用這個發行項的快照集時，在訂閱者端偵測到現有的同名物件，系統應該採取的動作
, @schema_option = 0x000000000803109F
, @identityrangemanagementoption = N'none'
, @destination_table = N'T2'
, @destination_owner = N'dbo'
, @status = 24
, @vertical_partition = N'false'
, @ins_cmd = N'CALL [sp_MSins_dboT2]'
, @del_cmd = N'CALL [sp_MSdel_dboT2]'
, @upd_cmd = N'SCALL [sp_MSupd_dboT2]'
, @filter_clause = N'B01IDNO in (SELECT B02IDNO FROM p WHERE B02SORCOD = ''s1'')'

-- Adding the article filter
exec sp_articlefilter @publication = N'DGPAP1S1'
, @article = N'T2'
, @filter_name = N'FLTR_T2_1__55'
, @filter_clause = N'B01IDNO in (SELECT B02IDNO FROM p WHERE B02SORCOD = ''s1'')'
, @force_invalidate_snapshot = 1
, @force_reinit_subscription = 1

-- Adding the article synchronization object
exec sp_articleview @publication = N'DGPAP1S1'
, @article = N'T2'
, @view_name = N'SYNC_T2_1__55'
, @filter_clause = N'B01IDNO in (SELECT B02IDNO FROM p WHERE B02SORCOD = ''s1'')'
, @force_invalidate_snapshot = 1
, @force_reinit_subscription = 1
GO#---------------------------------------------------------------#    R  & bR#---------------------------------------------------------------
##
 use nhrdb
  select * into dbo.R  from [D1].[dbo].[bp]

##  R & bR
CREATE TABLE [dbo].[R](
	[b02idno] [varchar](10) NOT NULL,
	[b02name] [nvarchar](20) NOT NULL,
	[B02SORCOD] [varchar](10) NOT NULL,
	[Modtime] [datetime] NOT NULL,
 CONSTRAINT [PK_R] PRIMARY KEY CLUSTERED 
(
	[b02idno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
##

insert  into bR select * from R
insert  into R select * from bR

#---------------------------------------------------------------#    T2 #---------------------------------------------------------------
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[T2](
	[b01idno] [varchar](10) NOT NULL,
	[b01name] [nvarchar](20) NOT NULL,
	[b01birthd] [varchar](7) NOT NULL,
	[Modtime] [datetime] NOT NULL,
 CONSTRAINT [PK_T2] PRIMARY KEY CLUSTERED 
(
	[b01idno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

#---------------------------------------------------------------#     CreatePublication#---------------------------------------------------------------  SELECT * FROM [dbo].[t2] WHERE [b01idno]  in (SELECT B02IDNO FROM NHRDB.dbo.R WHERE B02SORCOD = 's4')\\DGPAP2\ReplData\uncC:\Users\administrator.CSD\Documents\1007CreatePublicationDB01.sql##
select b.name,a.publication,a.publisher_db,a.publication_id,' * ',* from distribution.dbo.MSpublications a
join sys.servers b on a.publisher_id=b.server_id order by b.name,a.publication,a.publisher_db

##
select distinct p.publication as [Publication],p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id
##
FGetAllAgent
FGetallAgentStatus
#---------------------------------------------------------------#     NewSubscription#---------------------------------------------------------------C:\Users\administrator.CSD\Documents\1007NewSubscriptionDB01.sql#---------------------------------------------------------------#    Tsql#--------------------------------------------------------------- select *  FROM [NHRDB].[dbo].[R] select *  FROM [DB01kaoG3832].[dbo].[t2]  select *  FROM [DB13NTPC3832].[dbo].[t2]   select *  FROM [NHRDB].[dbo].[t2]#---------------------------------------------------------------#    b02idno = H  add sp2013.S4 & add  NHRDB.R#---------------------------------------------------------------
#先動  R 再 新增 sp2013 S4.t2
INSERT INTO [dgpap2].[NHRDB].[dbo].[R] VALUES  ('H','小叮噹','S4',GETDATE() )
delete from [dgpap2].[NHRDB].[dbo].[R]  where  [b02idno]='H' INSERT INTO  SP2013.s4.dbo.t2  VALUES   ('H','小叮噹','1030001',GETDATE()) 
INSERT INTO  SP2013.s4.dbo.t2  VALUES   ('G','大雄' ,'1030002',GETDATE())  
 delete from SP2013.s4.dbo.t2  where  [b01idno]='H' 
delete from [DB01kaoG3832].[dbo].[t2]  where  [b01idno]='H' delete from dgpap1.s1.dbo.t2  where  [b01idno]='H' delete from  [NHRDB].[dbo].[t2]UPDATE  dgpap2.d1.dbo.p   SET  [B02SORCOD] = 'S4' ,[Modtime] = getdate()    WHERE [b02idno]='B' #---------------------------------------------------------------#------1008-----------------------------------------------------#---------------------------------------------------------------csd\administratorselect * from s4.dbo.t2 t
join s4.dbo.p p on t.b01idno=p.b02idno
where p.B02SORCOD='s4'

select * from s4.dbo.pselect '[NHRDB][R]',*  FROM [NHRDB].[dbo].[R]select '[SP2013][s4][t2]',* from SP2013.s4.dbo.t2 select '[DB01kaoG3832][t2]',*  FROM [DB01kaoG3832].[dbo].[t2]--select *  FROM [DB13NTPC3832].[dbo].[t2]select '[NHRDB][t2]',*  FROM [NHRDB].[dbo].[t2]exec sp_addpublication @publication = N'DB01'
, @add_to_active_directory = N'false'
, @allow_anonymous = N'true'
, @allow_dts = N'false'
, @allow_initialize_from_backup = N'false'
, @allow_pull = N'true'
, @allow_push = N'true'
, @allow_queued_tran = N'false'
, @allow_subscription_copy = N'false'
, @allow_sync_tran   = N'false'
, @autogen_sync_procs = N'false'
, @compress_snapshot = N'false'
, @description = N'Transactional publication of database ''DB01kaoG3832'' from Publisher ''DGPAP2''.'
, @enabled_for_het_sub = N'false'
, @enabled_for_internet = N'false'
, @enabled_for_p2p = N'false'
, @ftp_login = N'anonymous'
, @ftp_port = 21
, @immediate_sync    = N'true'
, @independent_agent = N'true'
, @repl_freq = N'continuous'
, @replicate_ddl = 1
, @retention = 0
, @snapshot_in_defaultfolder = N'true'
, @status = N'active'
, @sync_method = N'concurrent'    // N'native'
GO

##-- Adding the transactional articles
use [DB01kaoG3832]
exec sp_addarticle @publication = N'DB01'
, @article = N't2'
, @creation_script = N''
, @del_cmd = N'SQL'
, @description = N''
, @destination_owner = N'dbo'
, @destination_table = N't2'
, @filter_clause = N'[b01idno] in  (SELECT B02IDNO FROM NHRDB.dbo.R WHERE B02SORCOD = ''s4'')' 定義水平篩選的限制 (WHERE) 子句
, @identityrangemanagementoption = N'none'
, @ins_cmd = N'SQL'
, @pre_creation_cmd = N'drop'
, @schema_option = 0x000000000803509F
, @source_object = N't2'
, @source_owner = N'dbo'
, @status = 8
, @type = N'logbased'  發行項的類型
, @upd_cmd = N'SQL'
, @vertical_partition = N'false'

##-- Adding the article filter
exec sp_articlefilter @publication = N'DB01'
, @article = N't2'
, @filter_name = N'FLTR_t2_1__60'
, @filter_clause = N'[b01idno] in  (SELECT B02IDNO FROM NHRDB.dbo.R WHERE B02SORCOD = ''s4'')'
, @force_invalidate_snapshot = 1
, @force_reinit_subscription = 1

##-- Adding the article synchronization object
exec sp_articleview @publication = N'DB01'
, @article = N't2'
, @view_name = N'SYNC_t2_1__60'
, @filter_clause = N'[b01idno] in  (SELECT B02IDNO FROM NHRDB.dbo.R WHERE B02SORCOD = ''s4'')'
, @force_invalidate_snapshot = 1
, @force_reinit_subscription = 1
GO





#+++++++


-- 正在啟用複寫資料庫
use master
exec sp_replicationdboption @dbname = N'379000000A_DB', @optname = N'publish', @value = N'true'
GO

exec [379000000A_DB].sys.sp_addlogreader_agent @job_login = N'CPAAD001\webhrreplad', @job_password = null
, @publisher_security_mode = 0, @publisher_login = N'sqlrepladmin', @publisher_password = N''
GO
-- 正在加入交易式發行集
use [379000000A_DB]
exec sp_addpublication @publication = N'PhaseII', @description = N'來自發行者 ''WEBHR-EDUDB'' 的資料庫 ''379000000A_DB'' 交易式發行集。'
, @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true'
, @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21
, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous'
, @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false'
, @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false'

, @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'PhaseII', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0
, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0
, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0
, @job_login = N'CPAAD001\webhrreplad', @job_password = null, @publisher_security_mode = 0, @publisher_login = N'sqlrepladmin'
, @publisher_password = N''


exec sp_grant_publication_access @publication = N'PhaseII', @login = N'sa'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'BUILTIN\ADMINISTRATORS'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'CPAAD001\domain admins'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'CPAAD001\webhrreplad'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'WEBHR-EDUDB\Administrator'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'NT SERVICE\Winmgmt'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'NT SERVICE\SQLWriter'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'NT SERVICE\SQLSERVERAGENT'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'NT Service\MSSQLSERVER'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'distributor_admin'
GO
exec sp_grant_publication_access @publication = N'PhaseII', @login = N'webhr'
GO

-- 正在加入交易式發行項
use [379000000A_DB]
exec sp_addarticle @publication = N'PhaseII', @article = N'CPABT02M', @source_owner = N'dbo', @source_object = N'CPABT02M'
, @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'delete'
, @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'CPABT02M'
, @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboCPABT02M]'
, @del_cmd = N'CALL [sp_MSdel_dboCPABT02M]', @upd_cmd = N'SCALL [sp_MSupd_dboCPABT02M]'
, @filter_clause = N'B02IDNO in (select B02IDNO from restable Where B02SEDORG=''379000000A'')'

-- 正在加入發行項篩選
exec sp_articlefilter @publication = N'PhaseII', @article = N'CPABT02M', @filter_name = N'FLTR_CPABT02M_1__147'
, @filter_clause = N'B02IDNO in (select B02IDNO from restable Where B02SEDORG=''379000000A'')', @force_invalidate_snapshot = 1

, @force_reinit_subscription = 1

-- 正在加入發行項同步處理物件
exec sp_articleview @publication = N'PhaseII', @article = N'CPABT02M', @view_name = N'SYNC_CPABT02M_1__147'
, @filter_clause = N'B02IDNO in (select B02IDNO from restable Where B02SEDORG=''379000000A'')'
, @force_invalidate_snapshot = 1, @force_reinit_subscription = 1
GO

