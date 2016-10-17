<#  Sqlps09_replication auther : ming_tseng    a0921887912@gmail.com createData : Mar.06.2014 history :  object :   \\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\Sqlps09_replication.ps1$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\Sqlps09_replication.ps1

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
#>ssmssqlmonitor
# 01 Test data  
# 02 224  Get Publisher  
# 03 354  Get 散發者設定
# 04 379  Get Subscriber 
# 05 401  create publication  
# 06 485  create  publication    merge 
# 07 525  drop publication  
# 08 541  Remove replication objects from the database. 
# 09 551  create subscription     
# 10 597  drop subscription     
# 11 618  將交易式提取Pull或匿名訂閱標示為在下次執行散發代理程式時重新初始化。 這個預存程序執行於提取訂閱資料庫的訂閱者端
# 12 681  article
# 13      監視複寫  http://technet.microsoft.com/zh-tw/library/ms152751.aspx
# 14  5)   Monitoring Replication with System Monitor http://technet.microsoft.com/en-us/library/ms151754.aspx
# 15       agent job and MSreplication_monitordata
# 16  MSdistribution_status
# 17  http://basitaalishan.com/2012/07/25/transact-sql-script-to-monitor-replication-status/# 18  un- distribute command# 19  stop /start  distribution_agent# 20 1200  stop / start  replicatoin Jobs#    1300  View and Modify Replication Security Settings<Transaction>Publisher: DGPAP1 (DB: S1 , Publishion: CA) ,Distributor: DGPAP2Subscriber : 2013BI  (DB: S2)<Merge replication >Publisher: DGPAP1 (DB: S3 , Publishion: ObserveIT) ,Distributor: DGPAP2Subscriber : 2013BI  (DB: S3)
<peer to peer replication >Publisher: SP2013 (DB: S4 , Publishion: P2P) ,Distributor: DGPAP2Subscriber : SQL2012X  (DB: S4)#---------------------------------------------------------------#  1 Test data  #--------------------------------------------------------------#{<#
CREATE DATABASE [S4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'S4', FILENAME = N'H:\SQLDB\S4.mdf' , SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'S4_log', FILENAME = N'H:\SQLDB\S4_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO

CREATE DATABASE [S3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'S3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\S3.mdf' , SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'S3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\S3_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO

#----[T1]
drop table [dbo].[T1]

truncate table  [dbo].[T1]

CREATE TABLE [dbo].[T1](
	[c1] [nchar](10) NOT NULL,
	[c2] [nchar](10) NULL,
	[c3] uniqueidentifier  NOT NULL DEFAULT (N'newsequentialid()') , 
	updateDate datetime,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

truncate table  [dbo].[T1]

DECLARE @counter smallint ,@val  int ;
SET @counter = 1;
WHILE @counter <= 1000
   BEGIN
      select @val=cast((RAND()*1000) as int)
      insert into [dbo].[T1] VALUES (@counter ,@val,NEWID(),getdate())
      SET @counter = @counter + 1
	    --WAITFOR DELAY '00:00:02' 
   END;
GO

#------------[T6]

truncate table  [dbo].[T6]
DROP TABLE [dbo].[T6]
GO


CREATE TABLE [dbo].[T6]( # 有2款T6
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [PRIMARY]
GO


CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [smalldatetime] NULL,
	[insertHost] [nvarchar](128) NULL,
 CONSTRAINT [PK_T6] PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=10
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  WAITFOR DELAY '00:00:02'  
end
select * from dbo.t6 


Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=10
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
end
select * from dbo.t6 
#------------[T5]
DROP TABLE [dbo].[T5]
CREATE TABLE [dbo].[T5](
	[rid] [int] NOT NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	[createDate] [smalldatetime] NULL,
	[updateDate] [smalldatetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_T5] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[T5] ADD  CONSTRAINT [MSmerge_df_rowguid_BA73F9B9ABB84CBFB83026AA11A0A74F]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
#-----  Hosts
DROP TABLE [dbo].[Hosts]
GO


CREATE TABLE [dbo].[Hosts](
	[MID] [varchar](128) NULL,
	[hostName] [varchar](128) NULL,
	[domain] [varchar](128) NULL,
	[IP1] [varchar](128) NULL,
	[IP2] [varchar](128) NULL,
	[updateDate] [smalldatetime] NULL,
	[manufacturer] [varchar](128) NULL,
	[model] [varchar](128) NULL,
	[numberOfProcessors] [tinyint] NULL,
	[numberOfLogicalProcessors] [tinyint] NULL,
	[totalPhysicalMemory] [int] NULL,
	[lastBootUpTime] [smalldatetime] NULL,
	[OS] [varchar](128) NULL,
	[version] [varchar](128) NULL,
	[servicePackMajorVersion] [varchar](10) NULL,
	[servicePackMinorVersion] [varchar](10) NULL,
	[buildNumber] [varchar](20) NULL,
	[installDate] [datetime] NULL,
	[IP3] [varchar](128) NULL,
	[IP4] [varchar](128) NULL,
	[IP5] [varchar](128) NULL,
	[IP6] [varchar](128) NULL
) ON [PRIMARY]

GO
$hostlist='sp2013','sql2012x','2016BI','w2k8r2-2013'


foreach ($item in $hostlist)
{
    $item.Name
}

foreach ($item in $hostlist) { #86
   switch ($item.Name)  { # 87
        2016BI {$MID='34'} 
        DGPAP1 {$MID='39'} 
        DGPAP2 {$MID='40'} 
        SP2013 {$MID='29'} 
        SQL2012X {$MID='61'} 
        SP2013WFE {$MID='194'} 
        default {$MID="The color could not be determined."}
    }# 87
    
     $hostName=$item.Name
     $computerSystem = get-wmiobject Win32_ComputerSystem -ComputerName $hostName ; # $computerSystem |select *
            $manufacturer=$computerSystem.Manufacturer
            ;$Model=$computerSystem.Model
            ;$systemtype=$computerSystem.PCSystemType
            ;$LogicalProcessor=$computerSystem.NumberOfLogicalProcessors
            ;$PhyiscalProcessors=$computerSystem.NumberOfProcessors
            ;$domain=$computerSystem.Domain     
      #$computerprocessor = get-wmiobject Win32_processor -ComputerName $hostName ; # $computerprocessor |select *
       
       $IPArr = gwmi Win32_NetworkAdapterconfiguration -ComputerName $hostName | ? ipEnabled -Match 'True'; 

     # $IPArr = gwmi Win32_NetworkAdapterconfiguration -ComputerName $hostName | ? ipEnabled -Match 'True' | ?  DefaultIPGateway -ne $null;
      
      $IP1=$IPArr.Ipaddress[0];$IP2=$IPArr.Ipaddress[1];$IP3=$IPArr.Ipaddress[2]
      $IP4=$IPArr.Ipaddress[3];$IP5=$IPArr.Ipaddress[4];$IP6=$IPArr.Ipaddress[5]
            
     $computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $hostName  ;# $computerOS |select * 
        $OS= $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion        $OS = $OS.substring(25, $OS.length -25)        $version=$computerOS.Version        $servicePackMajorVersion=$computerOS.ServicePackMajorVersion        $servicePackMinorVersion=$computerOS.servicePackMinorVersion        $buildNumber=$computerOS.BuildNumber        $InstallDate=$computerOS.ConvertToDateTime($computerOS.InstallDate)        $TotalMemoryGigabytes=$computerSystem.TotalPhysicalMemory/1gb        $TotalMemoryGigabytes = [math]::round($TotalMemoryGigabytes, 2)        $LastReboot= $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)


      $sql_insert = @"INSERT INTO [Hosts] ([MID],[hostName],[manufacturer],[Model],[numberOfProcessors],[numberOfLogicalProcessors],[totalPhysicalMemory],[lastBootUpTime],[OS],[version],[servicePackMajorVersion],[servicePackMinorVersion],[buildNumber],[InstallDate],[IP1],[IP2],[IP3],[IP4],[IP5],[IP6],[domain],[updateDate]) VALUES ('$MID', '$hostName','$manufacturer','$Model' ,'$PhyiscalProcessors','$LogicalProcessor','$TotalMemoryGigabytes','$LastReboot','$OS','$version','$servicePackMajorVersion','$servicePackMinorVersion','$buildNumber','$InstallDate','$IP1','$IP2','$IP3','$IP4','$IP5','$IP6','$domain',getdate())"@$sql_insert#Invoke-Sqlcmd -Query $sql_insert -ServerInstance "sp2013" -Database SQL_inventory #-QueryTimeout
   }#86

$ivsql='172.16.220.33'
$ndb='SQL_inventory'
$newdate=get-date -format 'yyyy-MM-dd HH:mm:ss'
$nowIP= (Get-WmiObject -class "Win32_NetworkAdapterConfiguration" -computername $env:computername | Where {$_.IPEnabled -Match "True"}).ipaddress[0]
$tsql_update="UPDATE [dbo].[Hosts] SET IP1 ='"+$nowIP+"', updatedate='"+$newdate+"' WHERE MID='T61'"
#$tsql_update

Invoke-Sqlcmd -Query $tsql_update -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds


##-------  [T8]DROP TABLE [dbo].[T8]
GO

CREATE TABLE [dbo].[T8](
	[insertHost] [nvarchar](128) NULL,
	[insertDT] [datetime] NOT NULL,
	[insertuser] [nvarchar](128) NULL,
	[Randfloat] [float] NULL,
	[NewID] [uniqueidentifier] NULL,
	[object_name] [nvarchar](128) NOT NULL,
	[counter_name] [nvarchar](128) NOT NULL,
	[instance_name] [nvarchar](128) NULL,
	[cntr_value] [bigint] NOT NULL,
	[cntr_type] [int] NOT NULL
) ON [PRIMARY]

GO


insert T8
select HOST_NAME() as insertHost,getdate() as insertDT,suser_name() as insertuser ,RAND() *1000 as Randfloat ,NEWID() as NewID, *
from sys.dm_os_performance_counters



##-------  [T9]


DROP TABLE [dbo].[T9]
GO



CREATE TABLE [dbo].[T9](
	[Runtime] [datetime] NULL,
	[session_id] [smallint] NOT NULL,
	[login_name] [varchar](128) NOT NULL,
	[host_name] [varchar](128) NULL,
	[DBName] [varchar](128) NULL,
	[Individual Query] [varchar](max) NULL,
	[Parent Query] [varchar](200) NULL,
	[status] [varchar](30) NULL,
	[start_time] [datetime] NULL,
	[wait_type] [varchar](60) NULL,
	[program_name] [varchar](128) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


INSERT INTO dbo.T9
SELECT
GETDATE()
, s.session_id
, s.login_name
, s.host_name
, DB_NAME(r.database_id) AS DBName
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS [Individual Query]
, SUBSTRING(text, 1, 200) AS [Parent Query]
, r.status
, r.start_time
, r.wait_type
, s.program_name
FROM sys.dm_exec_sessions s
INNER JOIN sys.dm_exec_connections c ON s.session_id = c.session_id
INNER JOIN sys.dm_exec_requests r ON c.connection_id = r.connection_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE s.session_id > 50
AND r.session_id != @@spid


#-------
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=5
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  --select @rstring=NEWID(); print @rstring
  set @rstring='39 insert'
  insert into dbo.t5 values (@rid,@val,@rstring,getdate(),getdate())  set @rid=@rid+1end
select * from dbo.t5 #-------insert into [t5] values (6,cast((RAND()*1000) as int),'29 insert',getdate(),getdate())
insert into [t5] values (7,cast((RAND()*1000) as int),'61 insert',getdate(),getdate())
update [t5] set updateDate=getdate(),val=29 where rid=2
select * from [dbo].[T5]insert into [t5] values (6,cast((RAND()*1000) as int),'39 insert',getdate(),getdate(),NEWID())
insert into [t5] values (7,cast((RAND()*1000) as int),'39 insert',getdate(),getdate(),NEWID())
insert into [t5] values (8,cast((RAND()*1000) as int),'39 insert',getdate(),getdate(),NEWID())
insert into [t5] values (9,cast((RAND()*1000) as int),'39 insert',getdate(),getdate(),NEWID())
select * from [dbo].[T5]insert into [t5] values (6,cast((RAND()*1000) as int),CONVERT(varchar(255), NEWID()),getdate(),getdate())
insert into [t5] values (7,cast((RAND()*1000) as int),CONVERT(varchar(255), NEWID()),getdate(),getdate())
insert into [t5] values (8,cast((RAND()*1000) as int),CONVERT(varchar(255), NEWID()),getdate(),getdate())
insert into [t5] values (9,cast((RAND()*1000) as int),CONVERT(varchar(255), NEWID()),getdate(),getdate())
insert into [t5] values (10,cast((RAND()*1000) as int),CONVERT(varchar(255), NEWID()),getdate(),getdate())
select * from dbo.t5 delete from t5 where rid=7WAITFOR TIME '22:20:00'  --wait  until  22.PM
GO
PRINT GETDATE()
EXEC master.dbo.dba_BlockTracer
IF @@ROWCOUNT > 0    -- if blocking occuring
		BEGIN
		SELECT GETDATE() AS TIME     -- execute 
		EXEC master.dbo.dba_WhatSQLIsExecuting
END
WAITFOR DELAY '00:00:15'   -- wait 15 sec
GO 500       -#>}#---------------------------------------------------------------# 2  224   Publisher    #--------------------------------------------------------------{<###  Get Publisher.name,  publication, publisher_db,a.publication_idselect b.name,a.publication,a.publisher_db,a.publication_id,' * ',* from distribution.dbo.MSpublications a
join sys.servers b on a.publisher_id=b.server_id order by b.name,a.publication,a.publisher_db## Get Pulisher, SubScriberselect distinct p.publication as [Publication],p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id##select * from distribution.dbo.MSdistribution_agents order by publisher_id

select  b.name,a.publication,a.name,' * ' ,* from distribution.dbo.MSdistribution_agents a
join sys.servers b on a.publisher_id=b.server_id
order by b.name,a.publication##  get all agent use distribution
select * from dbo.MSdistribution_agents
##$tsql_select=@"use distributionSELECT  pub.data_source AS Publisher ,
        a.Publisher_db ,
        p.Publication ,
        --CASE WHEN msd.security_mode = 1 THEN 'Windows Auth'
        --     WHEN msd.security_mode = 0
        --     THEN 'SQL Auth (Login=' + msd.login + ')'
        --END AS Pub_Authentication_Mode ,
        --msd.Publisher_type ,
		'-->' as [TO],
        sub.data_source AS Subscriber ,
        s.Subscriber_db ,
        CASE WHEN s.status = 0 THEN 'Inactive'
             WHEN s.status = 1 THEN 'Subscribed'
             WHEN s.status = 2 THEN 'Active'
        END AS Sub_Status ,
        CASE WHEN s.subscription_type = 0 THEN 'Push'
             WHEN s.subscription_type = 1 THEN 'Pull'
             WHEN s.subscription_type = 2 THEN 'Anonymous'
        END AS Subscription_type ,
        CASE WHEN sync_type = 1 THEN 'Automatic'
             WHEN sync_type = 2 THEN 'No synchronization'
        END AS Sync_type ,
        CASE WHEN msi.security_mode = 1 THEN 'Windows'
             WHEN msi.security_mode = 0 THEN 'SQL (Login=' + msd.login + ')'
        END AS Sub_Authentication_Mode ,
        ag.name AS Distribution_Agent_JobName ,
        pro.profile_name AS Agent_Profile
FROM    ( SELECT DISTINCT
                    publisher_id ,
                    publisher_db ,
                    publication_id
          FROM      distribution.dbo.MSarticles
        ) AS a
JOIN ( SELECT DISTINCT
                publisher_database_id ,
                publisher_id ,
                publisher_db ,
                publication_id ,
                subscriber_db ,
                subscriber_id ,
                subscription_type ,
                status ,
                update_mode ,
                sync_type ,
                nosync_type,
                agent_id
       FROM     distribution.dbo.MSsubscriptions
     ) AS s ON a.publication_id = s.publication_id
JOIN sys.servers AS sub ON s.subscriber_id = sub.server_id
JOIN distribution.dbo.MSpublications AS p ON s.publication_id = p.publication_id
JOIN sys.servers AS pub ON p.publisher_id = pub.server_id
JOIN msdb.dbo.MSdistpublishers AS msd ON msd.name = pub.name
JOIN distribution.dbo.MSsubscriber_info msi ON msi.subscriber = sub.name AND msi.publisher = pub.name
INNER JOIN dbo.MSdistribution_agents AS ag ON s.agent_id = ag.id
INNER JOIN msdb.dbo.MSagent_profiles AS pro ON ag.profile_id = pro.profile_id
order by pub.data_source,p.publication,a.publisher_db
"@

$Ss=Invoke-Sqlcmd -Query $tsql_select -ServerInstance DGPAP2 -Database distribution
$i=0
$Ss.Count
foreach ($s in $Ss)
{
   $s.Publisher +'  --['+$s.Publication +'] -- ' + $s.Publisher_db +' -->  ' +$s.Subscriber +'+/  '+ $s.Subscriber_db
}



$x[0].Publisher


'SP2013	    S4	P2P	SQL Auth (Login=mingX)	MSSQLSERVER	SQL2012X	S4	Active	Push	No synchronization	Windows	SP2013-S4-P2P-SQL2012X-64	Default agent profile
SP2013	    S4	SP2013S4	SQL Auth (Login=mingX)	MSSQLSERVER	DGPAP2	D1	Active	Push	Automatic	Windows	SP2013-S4-SP2013S4-DGPAP2-110	Default agent profile
SQL2012X	S4	P2P	Windows Auth	MSSQLSERVER	SP2013	S4	Active	Push	No synchronization	Windows	SQL2012X-S4-P2P-SP2013-65	Default agent profile
DGPAP1	    S3	U3S3_repladminAD_blockUNC	Windows Auth	MSSQLSERVER	WIN-MING	S3	Active	Push	Automatic	Windows	DGPAP1-S3-U3S3_repladminAD_bloc-WIN-MING-98	Default agent profile
DGPAP1	    S2	U5S2_repladmin_nonSQLsa	Windows Auth	MSSQLSERVER	WIN-MING	S2	Active	Push	Automatic	Windows	DGPAP1-S2-U5S2_repladmin_nonSQL-WIN-MING-104	Default agent profile
DGPAP1	    S1	DGPAP1S1	Windows Auth	MSSQLSERVER	DGPAP2	D1	Active	Push	Automatic	Windows	DGPAP1-S1-DGPAP1S1-DGPAP2-107	Default agent profile
DGPAP2	    D1	DGPAP2Psa	Windows Auth	MSSQLSERVER	DGPAP1	S1	Active	Push	Automatic	Windows	DGPAP2-D1-DGPAP2Psa-DGPAP1-115	Default agent profile
DGPAP2	    D1	DGPAP2Psa	Windows Auth	MSSQLSERVER	SP2013	S4	Active	Push	Automatic	Windows	DGPAP2-D1-DGPAP2Psa-SP2013-116	Default agent profile' [name]                             [MSdistribution_agents] [publisher_id]    [MSpublications] [MSdistribution_agents] [publisher_db]    [MSpublications] [MSdistribution_agents] [publication]     [MSpublications] [MSdistribution_agents] [publication_id]  [MSpublications] [MSdistribution_agents] [description]     [MSpublications] [MSdistribution_agents] [publisher_database_id] [srvname] [dbname]--use distributionSELECT name as 發行集散發者的名稱,working_directory as 工作目錄名稱  ,* FROM msdb..MSdistpublishers --- at distributor  (Publisher,Subscriber,...) show all status use distribution
SELECT * FROM MSsubscriber_info'
publisher,subscriber
DGPAP1	   DGPAP2
DGPAP1	   win-ming
DGPAP2	   DGPAP1
DGPAP2	   sp2013
SP2013	   DGPAP2
SP2013	   SQL2012X
SQL2012X   SP2013'-- at Publisher  --http://technet.microsoft.com/zh-tw/library/ms190493.aspxuse s1  --exec sp_helpsubscription 
GOsubscriber訂閱者的名稱,publication發行集的名稱,article發行項的名稱,destination database目的地資料庫名稱subscription status 訂閱狀態:(0 = 非使用中,1 = 已訂閱,2 = 使用中)synchronization type 訂閱同步處理類型 (1 = 自動 ,2 = 無)subscription name  訂閱的名稱subscriber_login  訂閱者端的登入名稱-- at Subscriberuse s2SELECT * 
FROM MSreplication_subscriptionspublisher,publisher_db,publication 發行者的名稱 ,發行者資料庫 ,發行集的名稱independent_agent 指出這個發行集是否有獨立的散發代理程式。distribution_agent  散發代理程式的名稱Time:前次由散發代理程式更新的時間#>}#---------------------------------------------------------------# 3 354   Distributor 散發者設定#--------------------------------------------------------------{<#sp_get_distributor (Transact-SQL)來判斷伺服器是否已經設定為散發者。-- run Publisheruse s1EXEC sp_helpdistributor go----Get每個發行集--http://technet.microsoft.com/zh-tw/library/ms186317.aspxuse distribution
SELECT * FROM MSpublications publisher_id 發行者的識別碼。publication   發行集的名稱  publication_id發行集的識別碼publication_type 發行集的類型：0 = 交易式。1 = 快照式。 2 = 合併式retention#>}#---------------------------------------------------------------# 4 379  Get Subscriber #--------------------------------------------------------------{<#--run at Publisher  顯示與訂閱者有關的資訊。use s1 exec sp_helpsubscription
exec sp_helpsubscriberinfo
go

subscriber   訂閱者的名稱
publication  發行集的名稱
article 發行項的名稱subscription status訂閱狀態： 0 = 非使用中 ,1 = 已訂閱, 2 = 使用中synchronization type  訂閱同步處理類型  1 = 自動  ,2 = 無subscription name  訂閱的名稱update mode  0 = 唯讀   1 = 立即更新訂閱subscriber_security_mode  訂閱者端的安全性模式，1 表示 Windows 驗證，0 表示 SQL Server 驗證Distrib_agent_name  同步處理訂閱的代理程式作業的名稱Frequency_type :  散發代理程式的執行頻率   64 = 自動啟動Frequency_interval frequency_type 設定的頻率所套用的值#>}#---------------------------------------------------------------# 5 401  create publication     #--------------------------------------------------------------{<#use [S1]
exec sp_replicationdboption @dbname = N'S1', @optname = N'publish', @value = N'true'
GO

use [S1]
exec [S1].sys.sp_addlogreader_agent @job_login = N'csd\administrator'
, @job_password = N'p@ssw0rd', @publisher_security_mode = 0, @publisher_login = N'sa'
, @publisher_password = N'p@ssw0rd', @job_name = null
GO

-- Adding the transactional publication
use [S1]
exec sp_addpublication @publication = N'CA'
, @description = N'Transactional publication of database ''S1'' from Publisher ''DGPAP1''.'
, @sync_method = N'concurrent', @retention = 0, @allow_push = N'true'
, @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false'
, @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21
, @ftp_login = N'anonymous', @allow_subscription_copy = N'false'
, @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active'
, @independent_agent = N'true', @immediate_sync = N'true'
, @allow_sync_tran = N'false', @autogen_sync_procs = N'false'
, @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1
, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'CA'
, @frequency_type = 1, @frequency_interval = 0
, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0
, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0
, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0
, @job_login = N'csd\administrator', @job_password = N'p@ssw0rd', @publisher_security_mode = 0
, @publisher_login = N'sa', @publisher_password = N'p@ssw0rd'

####

USE s1;
GO
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
GO
BEGIN TRANSACTION;

     exec sp_addarticle @publication = N'CA', @article = N'T1', @source_owner = N'dbo'
     , @source_object = N'T1', @type = N'logbased', @description = null
     , @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F
     , @identityrangemanagementoption = N'manual', @destination_table = N'T1'
     , @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboT1'
     , @del_cmd = N'CALL sp_MSdel_dboT1', @upd_cmd = N'SCALL sp_MSupd_dboT1'

GO
COMMIT TRANSACTION;
GO


 use default
use [S1]
exec sp_addarticle @publication = N'CA', @article = N'T1', @source_owner = N'dbo'
, @source_object = N'T1', @type = N'logbased', @description = N'', @creation_script = null
, @pre_creation_cmd = N'drop', @schema_option = 0x000000000883589F
, @identityrangemanagementoption = N'manual', @destination_table = N'T1'
, @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboT1'
, @del_cmd = N'CALL sp_MSdel_dboT1', @upd_cmd = N'SCALL sp_MSupd_dboT1'
GO



use [S1]
exec sp_addarticle @publication = N'CA', @article = N'T6', @source_owner = N'dbo', @source_object = N'T6', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'T6', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboT6', @del_cmd = N'CALL sp_MSdel_dboT6', @upd_cmd = N'SCALL sp_MSupd_dboT6'
GO


-- Drop the transactional article.

USE [S1]
EXEC sp_droparticle 
  @publication = N'CA', 
  @article = N'T1',
  @force_invalidate_snapshot = 1;
GO
#>}
#---------------------------------------------------------------#  6 485 create  publication    merge #--------------------------------------------------------------
{<#use [S3]
exec sp_replicationdboption @dbname = N'S3', @optname = N'merge publish', @value = N'true'
GO
-- Adding the merge publication
use [S3]
exec sp_addmergepublication @publication = N'observe'
, @description = N'Merge publication of database ''S3'' from Publisher ''DGPAP1''.'
, @sync_mode = N'native', @retention = 14, @allow_push = N'true', @allow_pull = N'true'
, @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true'
, @compress_snapshot = N'false', @ftp_port = 21, @ftp_subdirectory = N'ftp', @ftp_login = N'anonymous'
, @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @dynamic_filters = N'false'
, @conflict_retention = 14, @keep_partition_changes = N'false', @allow_synctoalternate = N'false'
, @max_concurrent_merge = 0, @max_concurrent_dynamic_snapshots = 0, @use_partition_groups = null
, @publication_compatibility_level = N'100RTM', @replicate_ddl = 1, @allow_subscriber_initiated_snapshot = N'false'
, @allow_web_synchronization = N'false', @allow_partition_realignment = N'true', @retention_period_unit = N'days'
, @conflict_logging = N'both', @automatic_reinitialization_policy = 0
GO


exec sp_addpublication_snapshot @publication = N'observe', @frequency_type = 1, @frequency_interval = 0
, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0
, @frequency_subday_interval = 0, @active_start_time_of_day = 500, @active_end_time_of_day = 235959
, @active_start_date = 0, @active_end_date = 0, @job_login = N'csd\administrator', @job_password = N'p@ssw0rd'
, @publisher_security_mode = 0, @publisher_login = N'sa', @publisher_password = N'p@ssw0rd'


use [S3]
exec sp_addmergearticle @publication = N'observe', @article = N'T5', @source_owner = N'dbo', @source_object = N'T5'
, @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop'
, @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo'
, @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null
, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false'
, @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0
, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false'
, @partition_options = 0
GO
#>}#---------------------------------------------------------------#  7 525 drop publication     #--------------------------------------------------------------{<#-- <transaction>$sql_getPublication =select publisher_db,publication, agent_name,agent_type from [distribution]..MSreplication_monitordata b$GetpublicationS=Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $sql_getPublication #-Username webhr  -Password $publisher_password
foreach ($Getpublication in $GetpublicationS)
{ # 575
     $publisherdb=$Getpublication.publisher_db
     $publicationN=$Getpublication.publication

     $sp_droppublication=@"
    USE [$publisherdb]
    EXEC sp_droppublication @publication = N'$publicationN';
     "@ 
   Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $sp_droppublication #-Username webhr  -Password $publisher_password

}#575
#-- <merge>
USE [S3]
EXEC sp_dropmergepublication @publication = @publication;
##  force delete  publicationUSE [s3]
EXEC sp_removedbreplication#>}#---------------------------------------------------------------# 8 541 Remove replication objects from the database.    #--------------------------------------------------------------{<#USE [master]
EXEC sp_replicationdboption 
  @dbname = @publicationDB, 
  @optname = N'publish', 
  @value = N'false';
GO
#>}
#---------------------------------------------------------------# 9 551  create subscription     #--------------------------------------------------------------{<##-- <transaction>use [S1]
exec sp_addsubscription @publication = N'CA'
, @subscriber = N'2013bi', @destination_db = N'S2', @subscription_type = N'Push'
, @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0

exec sp_addpushsubscription_agent @publication = N'CA', @subscriber = N'2013bi'
, @subscriber_db = N'S2', @job_login = N'csd\administrator', @job_password = N'p@ssw0rd'
, @subscriber_security_mode = 0, @subscriber_login = N'sa', @subscriber_password = N'p@ssw0rd'
, @frequency_type = 64, @frequency_interval = 0, @frequency_relative_interval = 0
, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0
, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 20140310
, @active_end_date = 99991231, @enabled_for_syncmgr = N'False', @dts_package_location = N'Distributor'
GO
#-- <merge>
-----------------BEGIN: Script to be run at Publisher 'DGPAP1'-----------------
use [S3]
exec sp_addmergesubscription @publication = N'observe', @subscriber = N'2013BI'
, @subscriber_db = N'S3', @subscription_type = N'Push', @sync_type = N'Automatic'
, @subscriber_type = N'Local', @subscription_priority = 0, @description = null
, @use_interactive_resolver = N'False'

exec sp_addmergepushsubscription_agent @publication = N'observe'
, @subscriber = N'2013BI', @subscriber_db = N'S3', @job_login = N'csd\administrator'
, @job_password = N'p@ssw0rd', @subscriber_security_mode = 0, @subscriber_login = N'sa'
, @subscriber_password = N'p@ssw0rd', @publisher_security_mode = 1, @frequency_type = 1
, @frequency_interval = 0, @frequency_relative_interval = 0
, @frequency_recurrence_factor = 0, @frequency_subday = 0
, @frequency_subday_interval = 0, @active_start_time_of_day = 0
, @active_end_time_of_day = 0, @active_start_date = 0
, @active_end_date = 19950101, @enabled_for_syncmgr = N'False'
GO
-----------------END: Script to be run at Publisher 'DGPAP1'-----------------






#>}
#---------------------------------------------------------------# 10 597  drop subscription     #--------------------------------------------------------------#{<#


$sql_getsubscriber="@
select distinct p.publication as [Publication],p.publisher_db as [publisherdb],r.name as [subscriber],s.subscriber_db as [subscriberdb]
from distribution.dbo.MSpublications  p 
join distribution.dbo.MSsubscriptions  s on p.publication_id=s.publication_id
join sys.servers  r on s.subscriber_id =r.server_id 
where Publication like '%ER%'
@"
$subscriberS=Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $sql_getPublication #-Username webhr  -Password $publisher_password
foreach ($subscriber in $subscriberS)
{ # 575
     $PublishN=$Getpublication.Publication
     $PublishDB=$Getpublication.publisher_db
     $subscribermachine=$Getpublication.subscriber

     $sp_dropsubscriber=@"
    USE [$PublishDB]  
  EXEC sp_dropsubscription 
  @publication = N'$PublishN', 
  @article = N'all',
  @subscriber = N'$subscribermachine';
GO
"@ 
   Invoke-Sqlcmd  -ServerInstance $ivSQL  -Query  $sp_dropsubscriber #-Username webhr  -Password $publisher_password

}#575

-- <transaction>
-- at publisherUSE S1  
EXEC sp_dropsubscription 
  @publication = N'ca', 
  @article = N'all',
  @subscriber = N'2013BI';
GO
#-- <merge>
USE [S3]
EXEC sp_dropmergesubscription 
  @publication = [Observe], 
  @subscriber = [2013BI], 
  @subscriber_db =[S3];
GO#>}#---------------------------------------------------------------# 11 618  將交易式提取Pull或匿名訂閱標示為在下次執行散發代理程式時重新初始化。 這個預存程序執行於提取訂閱資料庫的訂閱者端#--------------------------------------------------------------{<#-- Pull 執行於提取訂閱資料庫的訂閱者端DECLARE @publicationDB AS sysname;DECLARE @publication AS sysname;SET @publicationDB = N'AdventureWorks2012';SET @publication = N'AdvWorksProductTran';
USE [AdventureWorks2012Replica]
-- Execute at the Subscriber to reinitialize the pull subscription. 
EXEC sp_reinitpullsubscription 
    @publisher = $(PubServer),
    @publisher_db = @publicationDB,
    @publication = @publication;
GO
	-- Start the Distribution Agent.
--Push  執行於發送訂閱的發行者端。
DECLARE @subscriptionDB AS sysname;DECLARE @publication AS sysname;SET @subscriptionDB = N'S2';SET @publication = N'CA';
USE S1
-- Execute at the Publisher to reinitialize the push subscription.
EXEC sp_reinitsubscription @subscriber = $(SubServer),@destination_db = @subscriptionDB,@publication = @publication;
GO--example-------------------------------
--<transction>USE S1EXEC sp_startpublication_snapshot @publication = N'CA';GO-- Start the snapshot Agent.USE S1EXEC sp_reinitsubscription @subscriber = N'2013BI',@destination_db = N'S2',@publication = N'CA';
GO--<Merge>
USE S3EXEC sp_startpublication_snapshot @publication = N'observe';


USE [S3](need check again ,Mar.19.2014)
-- Execute at the Publisher to reinitialize the push subscription. 
-- Pending changes at the Subscrber are lost.
EXEC sp_reinitmergesubscription 
    @subscriber = N'2013BI',
    @subscriber_db = N'S3',
    @publication = @publication,
    @upload_first = N'True';
GO
-- Start the Distribution Agent.#>}
#---------------------------------------------------------------# 12 681  article#---------------------------------------------------------------




#---------------------------------------------------------------# 13 689 監視複寫  http://technet.microsoft.com/zh-tw/library/ms152751.aspx#---------------------------------------------------------------
{<#
1)Microsoft  SQL Server 複寫監視器 :「複寫監視器」是最重要的複寫監視工具，可呈現所有複寫活動以發行者為焦點的檢視。 如需詳細資訊，請參閱＜監視複寫＞。 
2)Microsoft SQL Server Management Studio  :Management Studio 提供「複寫監視器」的存取權。 還允許您檢視下列代理程式記錄的目前狀態和上一條訊息，並允許您啟動及停止每一個代理程式：「記錄讀取器代理程式」、「快照代理程式」、「合併代理程式」及「散發代理程式」。 如需詳細資訊，請參閱＜監視複寫代理程式＞。 
3)Transact-SQL 和 Replication Management Objects (RMO) :兩個介面均可讓您監視「散發者」端所有類型的複寫。 合併式複寫還提供了監視「訂閱者」端複寫的能力。 
4)複寫代理程式事件的警示 :複寫提供了一些複寫代理程式事件的預先定義警示，必要時您還可以建立其他警示。 警示可用於觸發對事件的自動回應及 (或) 通知管理員。 如需詳細資訊，請參閱＜使用複寫代理程式事件的警示＞。 5)系統監視器 :「系統監視器」提供了許多複寫計數器，有助於監視效能。 如需詳細資訊，請參閱＜使用系統監視器監視複寫＞。 
#>}使用複寫代理程式事件的警示#---------------------------------------------------------------#  4) 使用複寫代理程式事件的警示 http://technet.microsoft.com/zh-tw/library/ms151752.aspx#---------------------------------------------------------------ref Sqlps11_alert.ps1在複寫監視器中設定臨界值和警告設定預先定義的複寫警示 (SQL Server Management Studio)#---------------------------------------------------------------# 14  5) Monitoring Replication with System Monitor http://technet.microsoft.com/en-us/library/ms151754.aspx#---------------------------------------------------------------SQL Server: Replication SnapshotSQL Server: Replication Logreader        Logreader: Delivered Cmds/sec     每秒傳送到散發者的命令數        Logreader: Delivered Trans/sec    每秒傳送到散發者的交易數        Logreader: Delivery Latency     「發行者」套用交易時，該交易傳送至「散發者」所花費的時間，以毫秒為單位SQL Server: Replication Dist.         (Dist: Delivered Cmds/sec  每秒傳遞至「訂閱者」的命令數。         ,Dist: Delivered Trans/sec 每秒傳遞至「訂閱者」的交易數        ,Dist: Delivery Latency  目前從交易傳送到分配者到交易在「訂閱者」套用所經過的時間 (毫秒))#---------------------------------------------------------------#  15  agent job and MSreplication_monitordata#---------------------------------------------------------------select  a.name  as N'作業名稱',a.category_id,b.agent_id,b.agent_name,CASE b.agent_type WHEN 1     THEN '快照集代理程式' WHEN 2      THEN '記錄讀取器代理程式' WHEN 3      THEN '散發代理程式' WHEN 4      THEN '合併代理程式' WHEN 9      THEN '佇列讀取器代理程式'  END AS '複寫代理程式的類型',CASE b.status WHEN 1     THEN '1 = 已啟動' WHEN 2      THEN '2 = 成功' WHEN 3      THEN '3 = 進行中' WHEN 4      THEN '4 = 閒置' WHEN 5      THEN '5 = 重試中'  WHEN 6      THEN '6 = 失敗' END AS '代理程式的狀態',b.isagentrunningnow,b.last_distsync  AS '上次執行散發代理程式的日期和時間'from  msdb.dbo.sysjobs ajoin  [distribution]..MSreplication_monitordata bon a.job_id=b.job_id#---------------------------------------------------------------# 16  MSdistribution_status#---------------------------------------------------------------select * FROM [distribution]..MSdistribution_status#---------------------------------------------------------------#MSdistribution_status      http://msdn.microsoft.com/en-us/library/ms187401.aspx#MSdistribution_agents#MSArticles   http://msdn.microsoft.com/en-us/library/ms175027.aspx#MSreplication_monitordata  http://msdn.microsoft.com/en-us/library/ms186912.aspx#MSdistribution_history#servers          http://msdn.microsoft.com/en-us/library/ms178530.aspx#---------------------------------------------------------------Replication Tables   #http://msdn.microsoft.com/en-US/library/ms179855.aspxReplication Tables in the master DatabaseReplication Tables in the msdb DatabaseReplication Tables in the Distribution DatabaseReplication Tables in the Publication DatabaseReplication Tables in the Subscription Database#---------------------------------------------------------------# 17   http://basitaalishan.com/2012/07/25/transact-sql-script-to-monitor-replication-status/#---------------------------------------------------------------{<#USE [distribution]IF OBJECT_ID('Tempdb.dbo.#ReplStats') IS NOT NULL  DROP TABLE #ReplStats CREATE TABLE [dbo].[#ReplStats] (    [DistributionAgentName] [nvarchar](100) NOT NULL    ,[DistributionAgentStartTime] [datetime] NOT NULL    ,[DistributionAgentRunningDurationInSeconds] [int] NOT NULL    ,[IsAgentRunning] [bit] NULL    ,[ReplicationStatus] [varchar](14) NULL    ,[LastSynchronized] [datetime] NOT NULL    ,[Comments] [nvarchar](max) NOT NULL    ,[Publisher] [sysname] NOT NULL    ,[PublicationName] [sysname] NOT NULL    ,[PublisherDB] [sysname] NOT NULL    ,[Subscriber] [nvarchar](128) NULL    ,[SubscriberDB] [sysname] NULL    ,[SubscriptionType] [varchar](64) NULL    ,[DistributionDB] [sysname] NULL    ,[Article] [sysname] NOT NULL    ,[UndelivCmdsInDistDB] [int] NULL    ,[DelivCmdsInDistDB] [int] NULL    ,[CurrentSessionDeliveryRate] [float] NOT NULL    ,[CurrentSessionDeliveryLatency] [int] NOT NULL    ,[TotalTransactionsDeliveredInCurrentSession] [int] NOT NULL    ,[TotalCommandsDeliveredInCurrentSession] [int] NOT NULL    ,[AverageCommandsDeliveredInCurrentSession] [int] NOT NULL    ,[DeliveryRate] [float] NOT NULL    ,[DeliveryLatency] [int] NOT NULL    ,[TotalCommandsDeliveredSinceSubscriptionSetup] [int] NOT NULL    ,[SequenceNumber] [varbinary](16) NULL    ,[LastDistributerSync] [datetime] NULL    ,[Retention] [int] NULL    ,[WorstLatency] [int] NULL    ,[BestLatency] [int] NULL    ,[AverageLatency] [int] NULL    ,[CurrentLatency] [int] NULL    ) ON [PRIMARY] INSERT INTO #ReplStatsSELECT da.[name] AS [DistributionAgentName]    ,dh.[start_time] AS [DistributionAgentStartTime]    ,dh.[duration] AS [DistributionAgentRunningDurationInSeconds]    ,md.[isagentrunningnow] AS [IsAgentRunning]    ,CASE md.[status]         WHEN 1 THEN '1 - Started'         WHEN 2 THEN '2 - Succeeded'         WHEN 3 THEN '3 - InProgress'         WHEN 4 THEN '4 - Idle'         WHEN 5 THEN '5 - Retrying'         WHEN 6 THEN '6 - Failed'         END AS [ReplicationStatus]    ,dh.[time] AS [LastSynchronized]    ,dh.[comments] AS [Comments]    ,md.[publisher] AS [Publisher]    ,da.[publication] AS [PublicationName]    ,da.[publisher_db] AS [PublisherDB]    ,CASE        WHEN da.[anonymous_subid] IS NOT NULL            THEN UPPER(da.[subscriber_name])        ELSE UPPER(s.[name])        END AS [Subscriber]    ,da.[subscriber_db] AS [SubscriberDB]    ,CASE da.[subscription_type]        WHEN '0'            THEN 'Push'        WHEN '1'            THEN 'Pull'        WHEN '2'            THEN 'Anonymous'        ELSE CAST(da.[subscription_type] AS [varchar](64))        END AS [SubscriptionType]    ,md.[distdb] AS [DistributionDB]    ,ma.[article] AS [Article]    ,ds.[UndelivCmdsInDistDB]    ,ds.[DelivCmdsInDistDB]    ,dh.[current_delivery_rate] AS [CurrentSessionDeliveryRate]    ,dh.[current_delivery_latency] AS [CurrentSessionDeliveryLatency]    ,dh.[delivered_transactions] AS [TotalTransactionsDeliveredInCurrentSession]    ,dh.[delivered_commands] AS [TotalCommandsDeliveredInCurrentSession]    ,dh.[average_commands] AS [AverageCommandsDeliveredInCurrentSession]    ,dh.[delivery_rate] AS [DeliveryRate]    ,dh.[delivery_latency] AS [DeliveryLatency]    ,dh.[total_delivered_commands] AS [TotalCommandsDeliveredSinceSubscriptionSetup]    ,dh.[xact_seqno] AS [SequenceNumber]    ,md.[last_distsync] AS [LastDistributerSync]    ,md.[retention] AS [Retention]    ,md.[worst_latency] AS [WorstLatency]    ,md.[best_latency] AS [BestLatency]    ,md.[avg_latency] AS [AverageLatency]    ,md.[cur_latency] AS [CurrentLatency]FROM [distribution]..[MSdistribution_status] dsINNER JOIN [distribution]..[MSdistribution_agents] da ON da.[id] = ds.[agent_id]INNER JOIN [distribution]..[MSArticles] ma ON ma.publisher_id = da.publisher_id AND ma.[article_id] = ds.[article_id]INNER JOIN [distribution]..[MSreplication_monitordata] md ON [md].[job_id] = da.[job_id]INNER JOIN [distribution]..[MSdistribution_history] dh ON [dh].[agent_id] = md.[agent_id] AND md.[agent_type] = 3INNER JOIN [master].[sys].[servers] s ON s.[server_id] = da.[subscriber_id]--Created WHEN your publication has the immediate_sync property set to true. This property dictates --whether snapshot is available all the time for new subscriptions to be initialized. --This affects the cleanup behavior of transactional replication. If this property is set to true, --the transactions will be retained for max retention period instead of it getting cleaned up--as soon as all the subscriptions got the change. WHERE da.[subscriber_db] <> 'virtual'AND da.[anonymous_subid] IS NULLAND dh.[start_time] = (        SELECT TOP 1 start_time        FROM [distribution]..[MSdistribution_history] a        INNER JOIN [distribution]..[MSdistribution_agents] b ON a.[agent_id] = b.[id]            AND b.[subscriber_db] <> 'virtual'        WHERE [runstatus] <> 1        ORDER BY [start_time] DESC        )    AND dh.[runstatus] <> 1
SELECT 'Transactional Replication Summary' AS [Comments];SELECT [DistributionAgentName]    ,[DistributionAgentStartTime]    ,[DistributionAgentRunningDurationInSeconds]    ,[IsAgentRunning]    ,[ReplicationStatus]    ,[LastSynchronized]    ,[Comments]    ,[Publisher]    ,[PublicationName]    ,[PublisherDB]    ,[Subscriber]    ,[SubscriberDB]    ,[SubscriptionType]    ,[DistributionDB]    ,SUM([UndelivCmdsInDistDB]) AS [UndelivCmdsInDistDB]    ,SUM([DelivCmdsInDistDB]) AS [DelivCmdsInDistDB]    ,[CurrentSessionDeliveryRate]    ,[CurrentSessionDeliveryLatency]    ,[TotalTransactionsDeliveredInCurrentSession]    ,[TotalCommandsDeliveredInCurrentSession]    ,[AverageCommandsDeliveredInCurrentSession]    ,[DeliveryRate]    ,[DeliveryLatency]    ,[TotalCommandsDeliveredSinceSubscriptionSetup]    ,[SequenceNumber]    ,[LastDistributerSync]    ,[Retention]    ,[WorstLatency]    ,[BestLatency]    ,[AverageLatency]    ,[CurrentLatency]FROM #ReplStatsGROUP BY [DistributionAgentName]    ,[DistributionAgentStartTime]    ,[DistributionAgentRunningDurationInSeconds]    ,[IsAgentRunning]    ,[ReplicationStatus]    ,[LastSynchronized]    ,[Comments]    ,[Publisher]    ,[PublicationName]    ,[PublisherDB]    ,[Subscriber]    ,[SubscriberDB]    ,[SubscriptionType]    ,[DistributionDB]    ,[CurrentSessionDeliveryRate]    ,[CurrentSessionDeliveryLatency]    ,[TotalTransactionsDeliveredInCurrentSession]    ,[TotalCommandsDeliveredInCurrentSession]    ,[AverageCommandsDeliveredInCurrentSession]    ,[DeliveryRate]    ,[DeliveryLatency]    ,[TotalCommandsDeliveredSinceSubscriptionSetup]    ,[SequenceNumber]    ,[LastDistributerSync]    ,[Retention]    ,[WorstLatency]    ,[BestLatency]    ,[AverageLatency]    ,[CurrentLatency] SELECT 'Transactional Replication Summary Details' AS [Comments];SELECT [Publisher]    ,[PublicationName]    ,[PublisherDB]    ,[Article]    ,[Subscriber]    ,[SubscriberDB]    ,[SubscriptionType]    ,[DistributionDB]    ,SUM([UndelivCmdsInDistDB]) AS [UndelivCmdsInDistDB]    ,SUM([DelivCmdsInDistDB]) AS [DelivCmdsInDistDB]FROM #ReplStatsGROUP BY [Publisher]    ,[PublicationName]    ,[PublisherDB]    ,[Article]    ,[Subscriber]    ,[SubscriberDB]    ,[SubscriptionType]    ,[DistributionDB]#>}#---------------------------------------------------------------#   18  un-distribute command#---------------------------------------------------------------{<#

$tsql_select="
SELECT 
(CASE  
    WHEN mdh.runstatus =  '1' THEN 'Start - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '2' THEN 'Succeed - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '3' THEN 'InProgress - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '4' THEN 'Idle - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '5' THEN 'Retry - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '6' THEN 'Fail - '+cast(mdh.runstatus as varchar)
    ELSE CAST(mdh.runstatus AS VARCHAR)
END) [Run Status], 
mda.subscriber_db [Subscriber DB], 
mda.publication [PUB Name],
right(left(mda.name,LEN(mda.name)-(len(mda.id)+1)), LEN(left(mda.name,LEN(mda.name)-(len(mda.id)+1)))-(10+len(mda.publisher_db)+(case when mda.publisher_db='ALL' then 1 else LEN(mda.publication)+2 end))) [SUBSCRIBER],
CONVERT(VARCHAR(25),mdh.[time]) [LastSynchronized],
und.UndelivCmdsInDistDB [UndistCom], 
mdh.comments [Comments], 
'select * from distribution.dbo.msrepl_errors (nolock) where id = ' + CAST(mdh.error_id AS VARCHAR(8)) [Query More Info],
mdh.xact_seqno [SEQ_NO],
(CASE  
    WHEN mda.subscription_type =  '0' THEN 'Push' 
    WHEN mda.subscription_type =  '1' THEN 'Pull' 
    WHEN mda.subscription_type =  '2' THEN 'Anonymous' 
    ELSE CAST(mda.subscription_type AS VARCHAR)
END) [SUB Type],

mda.publisher_db+' - '+CAST(mda.publisher_database_id as varchar) [Publisher DB],
mda.name [Pub - DB - Publication - SUB - AgentID]
FROM distribution.dbo.MSdistribution_agents mda 
LEFT JOIN distribution.dbo.MSdistribution_history mdh ON mdh.agent_id = mda.id 
JOIN 
    (SELECT s.agent_id, MaxAgentValue.[time], SUM(CASE WHEN xact_seqno > MaxAgentValue.maxseq THEN 1 ELSE 0 END) AS UndelivCmdsInDistDB 
    FROM distribution.dbo.MSrepl_commands t (NOLOCK)  
    JOIN distribution.dbo.MSsubscriptions AS s (NOLOCK) ON (t.article_id = s.article_id AND t.publisher_database_id=s.publisher_database_id ) 
    JOIN 
        (SELECT hist.agent_id, MAX(hist.[time]) AS [time], h.maxseq  
        FROM distribution.dbo.MSdistribution_history hist (NOLOCK) 
        JOIN (SELECT agent_id,ISNULL(MAX(xact_seqno),0x0) AS maxseq 
        FROM distribution.dbo.MSdistribution_history (NOLOCK)  
        GROUP BY agent_id) AS h  
        ON (hist.agent_id=h.agent_id AND h.maxseq=hist.xact_seqno) 
        GROUP BY hist.agent_id, h.maxseq 
        ) AS MaxAgentValue 
    ON MaxAgentValue.agent_id = s.agent_id 
    GROUP BY s.agent_id, MaxAgentValue.[time] 
    ) und 
ON mda.id = und.agent_id AND und.[time] = mdh.[time] 
where mda.subscriber_db<>'virtual' -- created when your publication has the immediate_sync property set to true. This property dictates whether snapshot is available all the time for new subscriptions to be initialized. This affects the cleanup behavior of transactional replication. If this property is set to true, the transactions will be retained for max retention period instead of it getting cleaned up as soon as all the subscriptions got the change.
--and mdh.runstatus='6' --Fail
--and mdh.runstatus<>'2' --Succeed
order by mdh.[time]"Invoke-Sqlcmd -Query $tsql_select -ServerInstance  DGPAP2  -Database distribution |ft -AutoSize$tsql_select="
use distribution
SELECT 
(CASE  
    WHEN mdh.runstatus =  '1' THEN 'Start - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '2' THEN 'Succeed - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '3' THEN 'InProgress - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '4' THEN 'Idle - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '5' THEN 'Retry - '+cast(mdh.runstatus as varchar)
    WHEN mdh.runstatus =  '6' THEN 'Fail - '+cast(mdh.runstatus as varchar)
    ELSE CAST(mdh.runstatus AS VARCHAR)
END) [Run Status], 
mda.subscriber_db [Subscriber DB], 
mda.publication [PUB Name],
--right(left(mda.name,LEN(mda.name)-(len(mda.id)+1)), LEN(left(mda.name,LEN(mda.name)-(len(mda.id)+1)))-(10+len(mda.publisher_db)+(case when mda.publisher_db='ALL' then 1 else LEN(mda.publication)+2 end))) [SUBSCRIBER],
--CONVERT(VARCHAR(25),mdh.[time]) [LastSynchronized],
und.UndelivCmdsInDistDB [UndistCom], 
mdh.comments [Comments]
--'select * from distribution.dbo.msrepl_errors (nolock) where id = ' + CAST(mdh.error_id AS VARCHAR(8)) [Query More Info],
--mdh.xact_seqno [SEQ_NO],
--(CASE  
--    WHEN mda.subscription_type =  '0' THEN 'Push' 
--    WHEN mda.subscription_type =  '1' THEN 'Pull' 
--    WHEN mda.subscription_type =  '2' THEN 'Anonymous' 
--    ELSE CAST(mda.subscription_type AS VARCHAR)
--END) [SUB Type],

--mda.publisher_db+' - '+CAST(mda.publisher_database_id as varchar) [Publisher DB],
--mda.name [Pub - DB - Publication - SUB - AgentID]



FROM distribution.dbo.MSdistribution_agents mda 
LEFT JOIN distribution.dbo.MSdistribution_history mdh ON mdh.agent_id = mda.id 
JOIN 
    (SELECT s.agent_id, MaxAgentValue.[time], SUM(CASE WHEN xact_seqno > MaxAgentValue.maxseq THEN 1 ELSE 0 END) AS UndelivCmdsInDistDB 
    FROM distribution.dbo.MSrepl_commands t (NOLOCK)  
    JOIN distribution.dbo.MSsubscriptions AS s (NOLOCK) ON (t.article_id = s.article_id AND t.publisher_database_id=s.publisher_database_id ) 
    JOIN 
        (SELECT hist.agent_id, MAX(hist.[time]) AS [time], h.maxseq  
        FROM distribution.dbo.MSdistribution_history hist (NOLOCK) 
        JOIN (SELECT agent_id,ISNULL(MAX(xact_seqno),0x0) AS maxseq 
        FROM distribution.dbo.MSdistribution_history (NOLOCK)  
        GROUP BY agent_id) AS h  
        ON (hist.agent_id=h.agent_id AND h.maxseq=hist.xact_seqno) 
        GROUP BY hist.agent_id, h.maxseq 
        ) AS MaxAgentValue 
    ON MaxAgentValue.agent_id = s.agent_id 
    GROUP BY s.agent_id, MaxAgentValue.[time] 
    ) und 
ON mda.id = und.agent_id AND und.[time] = mdh.[time] 
where mda.subscriber_db<>'virtual' -- created when your publication has the immediate_sync property set to true. This property dictates whether snapshot is available all the time for new subscriptions to be initialized. This affects the cleanup behavior of transactional replication. If this property is set to true, the transactions will be retained for max retention period instead of it getting cleaned up as soon as all the subscriptions got the change.
--and mdh.runstatus='6' --Fail
--and mdh.runstatus<>'2' --Succeed
order by mdh.[time]"do
{
    Invoke-Sqlcmd -Query $tsql_select -ServerInstance  DGPAP2  -Database distribution |ft -AutoSize
    sleep 3
}
until ($x -gt 0)#>}#---------------------------------------------------------------#   19  stop /start  distribution_agent#---------------------------------------------------------------sp_MSstopdistribution_agent @publisher, @publisher_db, @publication, @subscriber, @subscriber_db


exec sp_MSstopdistribution_agent 'DGPAP1', 'S1', 'DGPAP1S1', 'DGPAP2', 'D1'


sp_MSstartdistribution_agent 'DGPAP1', 'S1', 'DGPAP1S1', 'DGPAP2', 'D1'#---------------------------------------------------------------#  1200 20  stop / start  replicatoin Jobs#---------------------------------------------------------------#{<#	


select publication, agent_name,agent_type from [distribution]..MSreplication_monitordata bwhere agent_type='1' snapshto '2' lodreader '3' distinct agent 

select publication, agent_name,agent_type from [distribution]..MSreplication_monitordata bwhere agent_type='3' and publication like '%d%'


1.  stop    all agent 
	EXEC msdb.dbo.sp_stop_job N'DGPAP1-S1-42'	                --39.S1 LogReader	13
	EXEC msdb.dbo.sp_stop_job N'DGPAP1-S1-DGPAP1S1-DGPAP2-107'	--39.S1 -Distribution	10
	EXEC msdb.dbo.sp_stop_job N'SP2013-S4-SP2013S4-DGPAP2-110' ;--29.S4 Distribution
	EXEC msdb.dbo.sp_stop_job N'SP2013-S4-28' ;                 --29.S4 LogReader
			
	EXEC DGPAP2.msdb.dbo.sp_start_job N'DGPAP1-S1-42'	                  --39.S1 LogReader	13
	EXEC DGPAP2.msdb.dbo.sp_start_job N'DGPAP1-S1-DGPAP1S1-DGPAP2-107'	  --39.S1 -Distribution	10
	EXEC DGPAP2.msdb.dbo.sp_start_job N'SP2013-S4-SP2013S4-DGPAP2-110' ; --29.S4 Distribution
	EXEC DGPAP2.msdb.dbo.sp_start_job N'SP2013-S4-28' ;                  --29.S4 LogReader
	
	EXEC msdb.dbo.sp_start_job N'SP2013-S4-SP2013S4-49' ; --29.S4 Snapshot	
	EXEC msdb.dbo.sp_stop_job N'DGPAP1-S1-DGPAP1S1-48'	--39.S1 -Snapshot	15
	
	
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-51'	                --REPL-LogReader
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-DGPAP2Psa-52'	        --REPL-Snapshot
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-DGPAP2Psa-DGPAP1-115'	--REPL-Distribution
	EXEC msdb.dbo.sp_stop_job N'DGPAP2-D1-DGPAP2Psa-SP2013-116'	--REPL-Distribution
	
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-51'	                --REPL-LogReader
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-DGPAP2Psa-52'	        --REPL-Snapshot
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-DGPAP2Psa-DGPAP1-115'	--REPL-Distribution
	EXEC msdb.dbo.sp_start_job N'DGPAP2-D1-DGPAP2Psa-SP2013-116'	--REPL-Distribution
#>}#---------------------------------------------------------------#    1300  View and Modify Replication Security Settings#---------------------------------------------------------------https://msdn.microsoft.com/en-us/library/ms151761.aspx#TsqlProcedurehttps://msdn.microsoft.com/zh-tw/library/ms187397.aspx#---------------------------------------------------------------#   #---------------------------------------------------------------select UndelivCmdsInDistDB as N'暫止傳遞給訂閱者的命令數', DelivCmdsInDistDB as N'傳遞給訂閱者的命令數', msa.publisher_db, publication,article,destination_object,source_owner,source_object,comments,start_time,[time],duration,delivered_transactions,total_delivered_commands,delivery_rate,updateable_row,xact_seqno
from msdistribution_status mss 
inner join MSarticles msa on mss.article_id = msa.article_id inner join MSdistribution_history msd  on msd.agent_id = mss.agent_idinner join MSpublications msp on  msp.publication_id = msa.publication_id#---------------------------------------------------------------#   #---------------------------------------------------------------select  a.Publisher    as N'發行者的名稱',a.publisher_db as N'發行集資料庫的名稱',a.agent_name as N'複寫代理程式作業的名稱',a.agent_id  as N'識別複寫代理程式。'from [distribution]..MSreplication_monitordata aorder by  a.agent_id select b.publisher_db N'發行者資料庫的名稱',b.article as N'發行項的名稱',b.article_id as N'發行項的識別碼'from [distribution].. MSarticles bselect c.article_id  as N'識別發行項',c.UndelivCmdsInDistDB as N'暫止傳遞給訂閱者的命令數',c.DelivCmdsInDistDB  as N'傳遞給訂閱者的命令數'FROM [distribution]..[MSdistribution_status] c#---------------------------------------------------------------#   sp_dropdistributor#---------------------------------------------------------------use [master]
exec sp_dropdistributor @no_checks = 1, @ignore_distributor = 1
GO



#---------------------------------------------------------------
# system tables used in Sql Server replication
#---------------------------------------------------------------

#Replication Tables in the master database...

MSreplication_options

#Replication Tables in the msdb database...
MSagentparameterlist
MSdbms
MSdbms_map
MSdbms_datatype
MSdbms_datatype_mapping
MSreplmonthresholdmetrics
sysreplicationalerts

#Replication Tables in the distribution database...
use distribution
MSagent_parameters
MSagent_profiles
MSarticles
MScached_peer_lsns
MSdistpublishers
MSdistribution_agents
MSdistribution_history
MSdistributiondbs
MSdistributor
MSlogreader_agents
MSlogreader_history
MSmerge_agents
MSmerge_history
MSmerge_sessions
MSmerge_subscriptions
MSpublication_access
MSpublicationthresholds
MSpublications
MSpublisher_databases
MSreplication_objects
MSreplication_subscriptions
MSrepl_commands
MSrepl_errors
MSrepl_originators
MSrepl_transactions
MSrepl_version
MSsnapshot_agents
MSsnapshot_history
MSsubscriber_info
MSsubscriber_schedule
MSsubscriptions
MSsubscription_properties
MStracer_history
MStracer_tokens

#Additionally, these tables in the distribution database are used for replicating data from non-SQL Server publishers...
use  non-SQL Server publishers.
IHarticles
IHcolumns
IHconstrainttypes
IHindextypes
IHpublications
IHpublishercolumnconstraints
IHpublishercolumnindexes
IHpublishercolumns
IHpublisherconstraints
IHpublisherindexes
IHpublishers
IHpublishertables
IHsubscriptions


#Replication tables in the publication database...
 use publication database...
MSdynamicsnapshotjobs
MSdynamicsnapshotviews
MSmerge_altsyncpartners
MSmerge_conflicts_info
MSmerge_contents
MSmerge_current_partition_mappings
MSmerge_dynamic_snapshots
MSmerge_errorlineage
MSmerge_generation_partition_mappings
MSmerge_genhistory
MSmerge_identity_range
MSmerge_metadataaction_request
MSmerge_partition_groups
MSmerge_past_partition_mappings
MSmerge_replinfo
MSmerge_settingshistory
MSmerge_tombstone
MSpeer_lsns
MSpeer_request
MSpeer_response
MSpub_identity_range
sysarticlecolumns
sysarticles
sysarticleupdates
sysmergearticlecolumns
sysmergearticles
sysmergepartitioninfo
sysmergepublications
sysmergeschemaarticles
sysmergeschemachange
sysmergesubscriptions
sysmergesubsetfilters
syspublications
sysschemaarticles
syssubscriptions
systranschemas


#Replication tables in the subscription database...

MSdynamicsnapshotjobs
MSdynamicsnapshotviews
MSmerge_altsyncpartners
MSmerge_conflicts_info
MSmerge_contents
MSmerge_current_partition_mappings
MSmerge_dynamic_snapshots
MSmerge_errorlineage
MSmerge_generation_partition_mappings
MSmerge_genhistory
MSmerge_identity_range
MSmerge_metadataaction_request
MSmerge_partition_groups
MSmerge_past_partition_mappings
MSmerge_replinfo
MSmerge_settingshistory
MSmerge_tombstone
MSpeer_lsns
MSrepl_queuedtraninfo
MSsnapshotdeliveryprogress
MSsubscription_properties
sysmergearticlecolumns
sysmergearticles
sysmergepartitioninfo
sysmergepublications
sysmergeschemaarticles
sysmergeschemachange
sysmergesubscriptions
sysmergesubsetfilters
systranschemas

#---------------------------------------------
#
#---------------------------------------------


Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <=10
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  --set @rstring='39 insert'
  insert into dbo.t7 values (@rid,@val,@rstring,getdate(),getdate())  set @rid=@rid+1end
select * from dbo.t7

truncate table  [dbo].[T7]


DROP TABLE [dbo].[T7]
Use S3
CREATE TABLE [dbo].[T7](
	[rid] [int] Not NULL,
	[val] [int] Not NULL,
	[rstring] [nchar](255) NULL,
    createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T7] PRIMARY KEY (rid)) ON [PRIMARY]
GO

select * from [dbo].[T7]

ALTER TABLE [T7] DROP CONSTRAINT [PK_T7]
ALTER TABLE [T7] ADD CONSTRAINT [PK_T7] PRIMARY KEY ([rid], [val] );

ALTER TABLE [T7] ADD CONSTRAINT [PK_T7] PRIMARY KEY ([rid]);