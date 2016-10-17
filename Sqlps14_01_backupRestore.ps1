<#Sqlps14_01_backupRestore
 C:\Users\Chao_Ming\OneDrive\download\PS1\Sqlps14_01_backupRestore.ps1
 from : Sqlps14_backupRestore.ps1

 auther : ming_tseng    a0921887912@gmail.com
 createData : 
 LastDate : 
 history : 
 object : tsql


#>
# 1 * 600  Creating a filegroup backup   p329
# 2  
# 3 2100  BackRest3 DB  for TSQL  只執份部分FG Backup
# 4 2760  BackRest4 DB  for TSQL  只執份部分FG Backup 但中間不加trn  
# 5  
# 6  
# 7  
# 8  
# 9  
# 10 
# 11 
# 12 
# 13 
# 14 
# 15 
# 16 
# 17 
# 18 
# 19 
# 20 
# 21 
# 22 
# 23  929  LSN  function
# 24 
# 25 



#---------------------------------------------------------------
# 1 100  BackRest DB  for TSQL
#---------------------------------------------------------------
{<#   t0   #>}
{<# t0
$dbt='BackRest2'
CREATE DATABASE [BackRest2]
ON PRIMARY
 ( NAME = N'BackRest'    , FILENAME = N'H:\SQLDB\BackRest.mdf')
  LOG ON 
( NAME = N'BackRest_log', FILENAME = N'H:\SQLDB\BackRest.ldf')
GO


USE master
GO
ALTER DATABASE [BackRest2]
ADD FILEGROUP [FG1]
GO

ALTER DATABASE [BackRest2]
ADD FILEGROUP [FG2]
GO

ALTER DATABASE [BackRest2]
ADD FILEGROUP [FG3]
GO

ALTER DATABASE [BackRest2]
ADD FILE 
 (NAME = BackRestFG1F1,  FILENAME = 'H:\SQLDB\BackRestFG1F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRestFG1F2,  FILENAME = 'H:\SQLDB\BackRestFG1F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG1;
GO

ALTER DATABASE [BackRest2]
ADD FILE 
 (NAME = BackRestFG2F1,  FILENAME = 'H:\SQLDB\BackRestFG2F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRestFG2F2,  FILENAME = 'H:\SQLDB\BackRestFG2F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRestFG2F3,  FILENAME = 'H:\SQLDB\BackRestFG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG2;
GO

ALTER DATABASE [BackRest2]
ADD FILE 
 (NAME = BackRestFG3F1,  FILENAME = 'H:\SQLDB\BackRestFG3F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRestFG3F2,  FILENAME = 'H:\SQLDB\BackRestFG3F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
--,(NAME = BackRestFG2F3,  FILENAME = 'H:\SQLDB\BackRestFG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG3;
GO


selectFileGroupONPath sp2013 $dbt   selectFileGroupONPath sp2013 $dbt

FileGroup FileName      PhysicalName               state_desc
--------- --------      ------------               ----------
FG1       BackRestFG1F1 H:\SQLDB\BackRestFG1F1.ndf ONLINE    
FG1       BackRestFG1F2 H:\SQLDB\BackRestFG1F2.ndf ONLINE    
FG2       BackRestFG2F1 H:\SQLDB\BackRestFG2F1.ndf ONLINE    
FG2       BackRestFG2F2 H:\SQLDB\BackRestFG2F2.ndf ONLINE    
FG2       BackRestFG2F3 H:\SQLDB\BackRestFG2F3.ndf ONLINE    
FG3       BackRestFG3F1 H:\SQLDB\BackRestFG3F1.ndf ONLINE    
FG3       BackRestFG3F2 H:\SQLDB\BackRestFG3F2.ndf ONLINE    
PRIMARY   BackRest      H:\SQLDB\BackRest.mdf      ONLINE    


selectTableONFileGroup sp2013 $dbt


use BackRest2
CREATE TABLE [PRIMARY_TABLE]
(ID INT,
 NAME CHAR(4)) ON [PRIMARY];


IF OBJECT_ID('Student') IS NOT NULL
DROP TABLE Student
GO

CREATE TABLE Student
(
ID INT IDENTITY(1,1) NOT NULL,
FName VARCHAR(50),
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([ID] ASC)
on [FG2]
)
GO


CREATE UNIQUE CLUSTERED INDEX PK_Student
ON dbo.Student
(
ID ASC
)
WITH (DROP_EXISTING=ON, ONLINE=ON)
ON FG2
GO

use BackRest2
IF OBJECT_ID('T6') IS NOT NULL
DROP TABLE T6
GO
CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [FG1]
GO

selectTableONFileGroup sp2013 $dbt
ObjectName    IndexID IndexName  IndexType DatabaseSpaceID FileGroup DatabaseFileName          
----------    ------- ---------  --------- --------------- --------- ----------------          
PRIMARY_TABLE       0            HEAP                    1 PRIMARY   H:\SQLDB\BackRest.mdf     
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRestFG2F1.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRestFG2F2.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRestFG2F3.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRestFG1F1.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRestFG1F2.ndf
6


    INSERT INTO [PRIMARY_TABLE]
    SELECT 1, 'TEST'
    GO 100

    INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 20
    INSERT INTO Student(FName)
    SELECT FName FROM Student
    GO 10
    # check how many records are inserted
    # this should give 20480
    SELECT COUNT(*) FROM Student


    Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
    while @rid <= 1000
    begin
    select @val=cast((RAND()*1000) as int) ;-- print @val
    select @rstring=NEWID(); --print @rstring
    insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
    set @rid=@rid+1
    --WAITFOR DELAY '00:00:01'  
    end

select count(*) as PRIMARY_TABLE from backrest2.dbo.PRIMARY_TABLE
select count(*) as t6 from backrest2.dbo.t6
select count(*) as Student from backrest2.dbo.Student
select count(*) as t3 from backrest2.dbo.t1


selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/20/2015 4:07:00 PM 1000 1000 224 4BF806FA-DFF0-4DC5-B573-5B938D0333CB                                                           ...
5/20/2015 4:07:00 PM  999  999 208 4C19E7A3-C5B1-455B-8D2B-4DFBF95DB8CC                                                           ...
5/20/2015 4:07:00 PM  998  998 655 5C2377CF-A340-4953-985A-1BE04615856C                                                           ...
5/20/2015 4:07:00 PM  997  997 585 FA6D0513-1583-4CA8-B80D-7F958780A22B                                                           ...
5/20/2015 4:07:00 PM  996  996 298 E76CE76E-B080-4704-B521-75E4E3F301E5                                                           ...
1000

#}>
#>}

{<#  t1  Database full backup   #>}
{<#      
# PRIMARY_TABLE =100 , T6= 1000  , Student=20480 
$dbt='BackRest2'
function backupFBdatabase ([string] $instance, [string] $dbname,[string]$bakpath){ 
# backupFBdatabase sp2013 mingdb  \\SP2013\temp
#$instance='sp2013'
#$backuppath='\\SP2013\temp'
#$dbname='BackRest'

$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bak' ;#$bakFile

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' 
"@  
$tsql_backupdatabase
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance $instance 

#get-item $bakFile
}#function backupFBdatabase

backupFBdatabase sp2013 $dbt \\SP2013\temp

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:59:59' -24  # BackRest2_2015-05-20_16-08-47.bak

selectT6modtime sp2013  $dbt

createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/20/2015 4:07:00 PM 1000 1000 224 4BF806FA-DFF0-4DC5-B573-5B938D0333CB                                                           ...
5/20/2015 4:07:00 PM  999  999 208 4C19E7A3-C5B1-455B-8D2B-4DFBF95DB8CC                                                           ...
5/20/2015 4:07:00 PM  998  998 655 5C2377CF-A340-4953-985A-1BE04615856C                                                           ...
5/20/2015 4:07:00 PM  997  997 585 FA6D0513-1583-4CA8-B80D-7F958780A22B                                                           ...
5/20/2015 4:07:00 PM  996  996 298 E76CE76E-B080-4704-B521-75E4E3F301E5                                                           ...
1000

#>}

{<#  t2  trn 1    #>}
{<#      
PRIMARY_TABLE =200 , T6= 800  , Student=20480 
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T2'
    GO 100

deleteT6 sp2013 $dbt ' <= 200'
selectT6modtime sp2013  $dbt

createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/20/2015 4:07:00 PM 1000 1000 224 4BF806FA-DFF0-4DC5-B573-5B938D0333CB                                                           ...
5/20/2015 4:07:00 PM  999  999 208 4C19E7A3-C5B1-455B-8D2B-4DFBF95DB8CC                                                           ...
5/20/2015 4:07:00 PM  998  998 655 5C2377CF-A340-4953-985A-1BE04615856C                                                           ...
5/20/2015 4:07:00 PM  997  997 585 FA6D0513-1583-4CA8-B80D-7F958780A22B                                                           ...
5/20/2015 4:07:00 PM  996  996 298 E76CE76E-B080-4704-B521-75E4E3F301E5                                                           ...
800

backupLog $dbt \\SP2013\temp
selectT6modtime sp2013  backrest      
#BackRest2_2015-05-20_16-11-16.trn

#>}
{<#  t3  FG backup    #>}
{<#
PRIMARY_TABLE =300 , T6= 1000  , Student=20480     ,t1=100000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T3'
    GO 100

insertT6 $dbt 200

selectT6modtime sp2013  $dbt   
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/20/2015 4:12:00 PM 1200 200 908 6B4545DF-6F5C-4918-A85E-A8DCF60A4A1C                                                            ...
5/20/2015 4:12:00 PM 1199 199 863 C5F16C8A-1C68-4D16-9761-750DAB8859A6                                                            ...
5/20/2015 4:12:00 PM 1198 198 713 28F5A76B-2A4A-4C7A-A3E0-E4C20D0D7A5C                                                            ...
5/20/2015 4:12:00 PM 1197 197 481 E0BD63B3-0FAD-483E-A46C-028C1DB4E443                                                            ...
5/20/2015 4:12:00 PM 1196 196 602 2EC4007D-35DB-4B85-A654-4C8A23CF381C                                                            ...
1000

CREATE TABLE [dbo].[T1](
	[c1] [nchar](10) NOT NULL,
	[c2] [nchar](10) NULL,
	[c3] uniqueidentifier  NOT NULL DEFAULT (N'newsequentialid()') , 
	updateDate datetime,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [FG3]
) ON [FG3]

selectTableONFileGroup sp2013 $dbt

ObjectName    IndexID IndexName  IndexType DatabaseSpaceID FileGroup DatabaseFileName          
----------    ------- ---------  --------- --------------- --------- ----------------          
PRIMARY_TABLE       0            HEAP                    1 PRIMARY   H:\SQLDB\BackRest.mdf     
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRestFG2F1.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRestFG2F2.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRestFG2F3.ndf
T1                  1 PK_T1      CLUSTERED               4 FG3       H:\SQLDB\BackRestFG3F1.ndf
T1                  1 PK_T1      CLUSTERED               4 FG3       H:\SQLDB\BackRestFG3F2.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRestFG1F1.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRestFG1F2.ndf
8


DECLARE @counter smallint ,@val  int ;
SET @counter = 1;
WHILE @counter <= 1000
   BEGIN
      select @val=cast((RAND()*1000) as int)
      insert into [dbo].[T1] VALUES (@counter ,@val,NEWID(),getdate())
      SET @counter = @counter + 1
	    --WAITFOR DELAY '00:00:02' 
   END;

   backupFBFileGroup  sp2013 $dbt \\SP2013\temp Primary  #BackRest2_Primary_2015-05-20_16-15-30.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest2_FG1_2015-05-20_16-15-46.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest2_FG2_2015-05-20_16-16-01.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest2_FG3_2015-05-20_16-16-20.baf ( 備份中T1仍在新增當中...)
#>}


{<#  t4    trn 2  BackRest2_2015-05-20_16-17-19.trn #>}
{<#
PRIMARY_TABLE =300 , T6= 1000  , Student=20480     ,t1=100000 (備份中仍在新增當中..32767.)
backupLog $dbt \\SP2013\temp  #BackRest2_2015-05-20_16-17-19.trn


GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:10:00' -24

selectbackupset $dbt 

name      type               DBL               FLSN                LSN DiffLSN BST                  BET                  DurationSeco
                                                                                                                                   nd
----      ----               ---               ----                --- ------- ---                  ---                  ------------
BackRest2 L    50000000023900047  51000000025900001 126000000049600001         5/20/2015 4:17:19 PM 5/20/2015 4:17:20 PM            1
BackRest2 F    50000000023900047 120000000036400042 120000000038300001         5/20/2015 4:16:20 PM 5/20/2015 4:16:20 PM            0
BackRest2 F    50000000023900047 116000000029400040 116000000034800001         5/20/2015 4:16:01 PM 5/20/2015 4:16:01 PM            0
BackRest2 F    50000000023900047 104000000044000040 104000000070500001         5/20/2015 4:15:46 PM 5/20/2015 4:15:46 PM            0
BackRest2 F    50000000023900047  69000000035600194  70000000040700001         5/20/2015 4:15:30 PM 5/20/2015 4:15:30 PM            0
BackRest2 L    50000000023900047  50000000023900047  51000000025900001         5/20/2015 4:11:16 PM 5/20/2015 4:11:16 PM            0
BackRest2 D                    0  50000000023900047  50000000025900001         5/20/2015 4:08:47 PM 5/20/2015 4:08:48 PM            1
#>}



{<#  t5   FG Diff   #>}
{<#      
PRIMARY_TABLE =500  , Student=20480 , T6= 1 , T1=32767
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T5'
    GO 200

deleteT6 sp2013 $dbt '< 1000'

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  #BackRest2_PRIMARY_2015-05-20_16-32-54.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest2_FG1_2015-05-20_16-33-25.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest2_FG2_2015-05-20_16-33-38.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest2_FG3_2015-05-20_16-33-51.ddf

selectT6modtime sp2013  $dbt 
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/20/2015 4:07:00 PM 1000 1000 224 4BF806FA-DFF0-4DC5-B573-5B938D0333CB                                                           ...
1

#>}



{<#  t6    trn 3 BackRest2_2015-05-20_16-38-08.trn #>}
{<#      
PRIMARY_TABLE =600  , Student=0 , T6= 101 , T1=32767


 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T6'
    GO 100

 insertT6 $dbt 100

 Delete from  [dbo].[Student] 

 backupLog $dbt \\SP2013\temp    #BackRest2_2015-05-20_16-38-08.trn

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:10:00' -24

#>}


{<#  t7    trn 2 #>}
{<#      
PRIMARY_TABLE =700  , Student=200 , T6= 101 , T1=32767
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T7'
    GO 100

 insertT6 $dbt 100

  INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  #BackRest2_PRIMARY_2015-05-20_16-42-33.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest2_FG1_2015-05-20_16-42-49.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest2_FG2_2015-05-20_16-43-02.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest2_FG3_2015-05-20_16-43-14.ddf




#>}

{<#  t8    trn 4 #>}
{<#      
PRIMARY_TABLE =700  , Student=200 , T6= 101 , T1=32767
backupLog $dbt \\SP2013\temp    #BackRest2_2015-05-20_16-44-07.trn
GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:10:00' -24
#>}


{<#  t9    trn 5 #>}
{<#      
PRIMARY_TABLE =900  , Student=400 , T6= 200 , T1=32767
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T9'
    GO 100
 INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200
 insertT6 $dbt 99

backupLog $dbt \\SP2013\temp  #BackRest2_2015-05-20_16-47-01.trn


selectT6modtime sp2013  $dbt 
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/20/2015 4:46:00 PM 1399  99 329 662A640D-C06A-453F-9B47-5936AE1B3414                                                            ...
5/20/2015 4:46:00 PM 1398  98 987 75A1E8B0-5148-4A21-A838-F4E916978613                                                            ...
5/20/2015 4:46:00 PM 1397  97 401 0A52B5DE-3529-4CCA-94CC-0E9496DFF5BD                                                            ...
5/20/2015 4:46:00 PM 1396  96 389 4F62C229-1764-4234-A92E-FC7C8922DB4E                                                            ...
5/20/2015 4:46:00 PM 1395  95 737 9AEC361C-0DC3-4228-9388-01E61E84DEEF                                                            ...
200
#>}

{<#  t10    FG backup #>}
{<#      
PRIMARY_TABLE =1000  , Student=500 , T6= 500 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T10'
    GO 100
INSERT INTO Student(FName)
    VALUES('EN')
    GO 100
insertT6 $dbt 300

drop table t1

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY   #BackRest2_PRIMARY_2015-05-20_16-51-14.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1       #BackRest2_FG1_2015-05-20_16-51-25.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2       #BackRest2_FG2_2015-05-20_16-51-42.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3       #BackRest2_FG3_2015-05-20_16-51-52.ddf

selectT6modtime sp2013  $dbt

createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/20/2015 4:50:00 PM 1699 300 978 16AFFA4B-F39D-4C8D-9B18-BDC688A9D44C                                                            ...
5/20/2015 4:50:00 PM 1698 299 396 8F3D279D-0686-47F9-81B7-CB9382839656                                                            ...
5/20/2015 4:50:00 PM 1697 298 291 319DD10C-8480-4BB9-A3AB-2A96274CDF17                                                            ...
5/20/2015 4:50:00 PM 1696 297 802 77CBC511-0360-47C1-A3BD-B17B84DC939A                                                            ...
5/20/2015 4:50:00 PM 1695 296 626 EE158874-C11D-45A0-AE34-71BBFCDB01AB                                                            ...
500



#>}

{<#  t11    FG full backup  #>}
{<#      
PRIMARY_TABLE =1100  , Student=500 , T6= 500 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T11'
    GO 100
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp Primary  #BackRest2_Primary_2015-05-20_16-56-07.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest2_FG1_2015-05-20_16-56-20.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest2_FG2_2015-05-20_16-56-31.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest2_FG3_2015-05-20_16-56-47.baf




#>}

{<#  t12    trn BackRest2_2015-05-20_16-58-25.trn #>}
{<#      
PRIMARY_TABLE =1200  , Student=700 , T6= 700 , T1=1000
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T12'
    GO 100
INSERT INTO Student(FName)
    VALUES('EN')
    GO 200
insertT6 $dbt 200

backupLog $dbt \\SP2013\temp   #BackRest2_2015-05-20_16-58-25.trn

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-19  10:10:00' -24

#>}


{<#  t13   FG Diff  #>}
{<#      
PRIMARY_TABLE =1300  , Student=800 , T6= 1 , T1=1000
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T13'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
deleteT6 sp2013 $dbt '<= 500'

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  #BackRest2_PRIMARY_2015-05-20_17-01-42.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest2_FG1_2015-05-20_17-01-53.ddf
                                                         BackRest2_FG1_2015-05-20_17-02-10.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest2_FG2_2015-05-20_17-02-11.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest2_FG3_2015-05-20_17-02-48.ddf


selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/20/2015 4:07:00 PM 1000 1000 224 4BF806FA-DFF0-4DC5-B573-5B938D0333CB  

#>}

{<#  t14    trn  #>}
{<#      
PRIMARY_TABLE =1400  , Student=900 , T6= 1200 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'TESTT14'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
   
insertT6 $dbt 1199

backupLog $dbt \\SP2013\temp   #BackRest2_2015-05-20_17-06-45.trn
selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/20/2015 5:06:00 PM 3098 1199 277 F0C86F45-4792-4808-BA8A-8D3BE002A974                                                           ...
5/20/2015 5:06:00 PM 3097 1198 421 4A65C04D-9B17-4396-A327-41B52BD78C39                                                           ...
5/20/2015 5:06:00 PM 3096 1197 260 F02EEA0A-3EBE-4C62-BAB7-25FBBF5C1F03                                                           ...
5/20/2015 5:06:00 PM 3095 1196 173 78988894-BAA0-4FC2-8B87-9880D4F901F7                                                           ...
5/20/2015 5:06:00 PM 3094 1195 644 FA4BDB50-58BB-4DAA-8FF9-AF3C5B983049                                                           ...
1200

#>}

{<#  t15   FG Diff  #>}
{<#      
PRIMARY_TABLE =1500  , Student=1000 , T6= 2000 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T15'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
insertT6 $dbt 800

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  #BackRest2_PRIMARY_2015-05-20_17-08-47.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest2_FG1_2015-05-20_17-09-00.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest2_FG2_2015-05-20_17-09-18.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest2_FG3_2015-05-20_17-09-42.ddf


GetBDLFile  \\SP2013\temp\ $dbt '2015-05-19  10:10:00' -24


#>}

{<#  t16    trn 4 #>}
{<#      
PRIMARY_TABLE =1600  , Student=1000 , T6= 2000 , T1=100
CREATE TABLE [dbo].[T1](
	[c1] [nchar](10) NOT NULL,
	[c2] [nchar](10) NULL,
	[c3] uniqueidentifier  NOT NULL DEFAULT (N'newsequentialid()') , 
	updateDate datetime,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [FG3]
) ON [FG3]


backupLog $dbt \\SP2013\temp    #BackRest2_2015-05-20_17-13-51.trn

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-19  10:10:00' -24
#>}
{<#
selectbackupset $dbt
----      ----               ---               ----                --- -------            ---                  ---                  -
BackRest2 L    50000000023900047 197000000026100001 199000000035800001                    5/20/2015 5:13:51 PM 5/20/2015 5:13:51 PM 0
BackRest2 G    50000000023900047 199000000023600001 199000000023900001 192000000028600036 5/20/2015 5:09:42 PM 5/20/2015 5:09:42 PM 0
BackRest2 G    50000000023900047 199000000023300001 199000000023600001 192000000025000037 5/20/2015 5:09:18 PM 5/20/2015 5:09:19 PM 1
BackRest2 G    50000000023900047 199000000023000001 199000000023300001 192000000021800036 5/20/2015 5:09:00 PM 5/20/2015 5:09:01 PM 1
BackRest2 G    50000000023900047 199000000022100017 199000000023000001 192000000018900043 5/20/2015 5:08:47 PM 5/20/2015 5:08:47 PM 0
BackRest2 L    50000000023900047 193000000004900001 197000000026100001                    5/20/2015 5:06:45 PM 5/20/2015 5:06:45 PM 0
(t13)
BackRest2 G    50000000023900047 194000000044300001 194000000044600001 192000000028600036 5/20/2015 5:02:48 PM 5/20/2015 5:02:48 PM 0
BackRest2 G    50000000023900047 194000000044000001 194000000044300001 192000000025000037 5/20/2015 5:02:11 PM 5/20/2015 5:02:11 PM 0
BackRest2 G    50000000023900047 194000000043700001 194000000044000001 192000000021800036 5/20/2015 5:02:10 PM 5/20/2015 5:02:10 PM 0
BackRest2 G    50000000023900047 194000000043400001 194000000043700001 192000000021800036 5/20/2015 5:01:53 PM 5/20/2015 5:01:53 PM 0
BackRest2 G    50000000023900047 194000000042100026 194000000043400001 192000000018900043 5/20/2015 5:01:42 PM 5/20/2015 5:01:42 PM 0
(t12)
BackRest2 L    50000000023900047 191000000008800001 193000000004900001                    5/20/2015 4:58:26 PM 5/20/2015 4:58:26 PM 0
(T11 FG FB)
BackRest2 F    50000000023900047 192000000028600036 192000000030300001                    5/20/2015 4:56:47 PM 5/20/2015 4:56:47 PM 0
BackRest2 F    50000000023900047 192000000025000037 192000000026700001                    5/20/2015 4:56:31 PM 5/20/2015 4:56:31 PM 0
BackRest2 F    50000000023900047 192000000021800036 192000000023500001                    5/20/2015 4:56:20 PM 5/20/2015 4:56:20 PM 0
BackRest2 F    50000000023900047 192000000018900043 192000000020800001                    5/20/2015 4:56:08 PM 5/20/2015 4:56:08 PM 0
(t10 FG DIFF)
BackRest2 G    50000000023900047 192000000008400001 192000000008700001 120000000036400042 5/20/2015 4:51:52 PM 5/20/2015 4:51:52 PM 0
BackRest2 G    50000000023900047 192000000008100001 192000000008400001 116000000029400040 5/20/2015 4:51:42 PM 5/20/2015 4:51:42 PM 0
BackRest2 G    50000000023900047 192000000007800001 192000000008100001 104000000044000040 5/20/2015 4:51:25 PM 5/20/2015 4:51:25 PM 0
BackRest2 G    50000000023900047 192000000001600145 192000000007800001 69000000035600194  5/20/2015 4:51:14 PM 5/20/2015 4:51:14 PM 0
(t9)
BackRest2 L    50000000023900047 190000000033900001 191000000008800001                    5/20/2015 4:47:01 PM 5/20/2015 4:47:01 PM 0
(t8)
BackRest2 L    50000000023900047 189000000089000001 190000000033900001                    5/20/2015 4:44:07 PM 5/20/2015 4:44:07 PM 0
(t7 FG DIFF)
BackRest2 G    50000000023900047 190000000033600001 190000000033900001 120000000036400042 5/20/2015 4:43:14 PM 5/20/2015 4:43:14 PM 0
BackRest2 G    50000000023900047 190000000033300001 190000000033600001 116000000029400040 5/20/2015 4:43:02 PM 5/20/2015 4:43:02 PM 0
BackRest2 G    50000000023900047 190000000033000001 190000000033300001 104000000044000040 5/20/2015 4:42:49 PM 5/20/2015 4:42:49 PM 0
BackRest2 G    50000000023900047 190000000032400009 190000000033000001 69000000035600194  5/20/2015 4:42:33 PM 5/20/2015 4:42:33 PM 0
(t6)
BackRest2 L    50000000023900047 126000000049600001 189000000089000001                    5/20/2015 4:38:08 PM 5/20/2015 4:38:09 PM 1
(t5 FG DIFF)
BackRest2 G    50000000023900047 183000000005000001 183000000005300001 120000000036400042 5/20/2015 4:33:51 PM 5/20/2015 4:33:51 PM 0
BackRest2 G    50000000023900047 183000000004700001 183000000005000001 116000000029400040 5/20/2015 4:33:38 PM 5/20/2015 4:33:38 PM 0
BackRest2 G    50000000023900047 183000000004400001 183000000004700001 104000000044000040 5/20/2015 4:33:25 PM 5/20/2015 4:33:25 PM 0
BackRest2 G    50000000023900047 183000000003300021 183000000004400001 69000000035600194  5/20/2015 4:32:54 PM 5/20/2015 4:32:54 PM 0
(t4)
BackRest2 L    50000000023900047  51000000025900001 126000000049600001                    5/20/2015 4:17:19 PM 5/20/2015 4:17:20 PM 1
(t3 FG FB  )
BackRest2 F    50000000023900047 120000000036400042 120000000038300001                    5/20/2015 4:16:20 PM 5/20/2015 4:16:20 PM 0
BackRest2 F    50000000023900047 116000000029400040 116000000034800001                    5/20/2015 4:16:01 PM 5/20/2015 4:16:01 PM 0
BackRest2 F    50000000023900047 104000000044000040 104000000070500001                    5/20/2015 4:15:46 PM 5/20/2015 4:15:46 PM 0
BackRest2 F    50000000023900047  69000000035600194  70000000040700001                    5/20/2015 4:15:30 PM 5/20/2015 4:15:30 PM 0
(t2)
BackRest2 L    50000000023900047  50000000023900047  51000000025900001                    5/20/2015 4:11:16 PM 5/20/2015 4:11:16 PM 0
(t1 Database FB)
BackRest2 D                    0  50000000023900047  50000000025900001                    5/20/2015 4:08:47 PM 5/20/2015 4:08:48 PM 1
#>}

{<#---------------------------- Restore  658   T14  sql2012x #>}
{<#
select count(*) as PRIMARY_TABLE from backrest2.dbo.PRIMARY_TABLE
select count(*) as t6 from backrest2.dbo.t6
select count(*) as Student from backrest2.dbo.Student
select count(*) as T1 from backrest2.dbo.T1

#1. create new database by TSQL ,It must databse full backup 
USE [master]
GO

/****** Object:  Database [BackRest2]    Script Date: 5/20/2015 8:11:12 PM ******/
DROP DATABASE [BackRest2]
GO

/****** Object:  Database [BackRest2]    Script Date: 5/20/2015 8:11:12 PM ******/
CREATE DATABASE [BackRest2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BackRest', FILENAME = N'H:\SQLDB\BackRest.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG1] 
( NAME = N'BackRestFG1F1', FILENAME = N'H:\SQLDB\BackRestFG1F1.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB ), 
( NAME = N'BackRestFG1F2', FILENAME = N'H:\SQLDB\BackRestFG1F2.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB ), 
 FILEGROUP [FG2] 
( NAME = N'BackRestFG2F1', FILENAME = N'H:\SQLDB\BackRestFG2F1.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB ), 
( NAME = N'BackRestFG2F2', FILENAME = N'H:\SQLDB\BackRestFG2F2.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB ), 
( NAME = N'BackRestFG2F3', FILENAME = N'H:\SQLDB\BackRestFG2F3.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB ), 
 FILEGROUP [FG3] 
( NAME = N'BackRestFG3F1', FILENAME = N'H:\SQLDB\BackRestFG3F1.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB ), 
( NAME = N'BackRestFG3F2', FILENAME = N'H:\SQLDB\BackRestFG3F2.ndf' , SIZE = 5120KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB )
 LOG ON 
( NAME = N'BackRest_log', FILENAME = N'H:\SQLDB\BackRest.ldf' , SIZE = 29504KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

(T1)restoreFBdatabase 
    restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak
(t11) only one failure must all FBFilegroup
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-56-07.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-56-20.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-56-31.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-56-47.baf
(t12)
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-58-25.trn
(t14)
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_17-06-45.trn

#2. restore T1  

(T1) restoreFBdatabase  
restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak

(t11) restoreFBFileGroupNORECOVERY 
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-56-07.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-56-20.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-56-31.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-56-47.baf

(t13)restoreDiffFileGroup  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_PRIMARY_2015-05-20_17-01-42.ddf NORECOVERY 
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_17-02-10.ddf NORECOVERY  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_17-02-11.ddf NORECOVERY  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_17-02-48.ddf NORECOVERY 

restoreLOG  (t14)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_17-06-45.trn

#3. restore T11

#>}

{<#----------------------------  Restore  728   T16 #>}
{<#
(T1)   restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak

(t11) restoreFBFileGroupNORECOVERY 
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-56-07.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-56-20.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-56-31.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-56-47.baf

(T15)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_PRIMARY_2015-05-20_17-08-47.ddf NORECOVERY 
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_17-09-00.ddf NORECOVERY  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_17-09-18.ddf NORECOVERY  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_17-09-42.ddf NORECOVERY 


(T16)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_17-13-51.trn

#>}
{<#----------------------------  Restore    748  T8 ( T7 FG Diff point )  #>}
{<#
T7 是FG Diff 無法獨立restore.必須要配合trn
(T1)   restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak

(T3)
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-15-30.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-15-46.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-16-01.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-16-20.baf 


(T7)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ PRIMARY  BackRest2_PRIMARY_2015-05-20_16-42-33.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-42-49.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-43-02.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-43-14.ddf RECOVERY

(T8)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-44-07.trn # workable

#>}

{<#----------------------------  Restore     T9 #>}
{<#
(T1)   restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak

(T3)
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-15-30.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-15-46.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-16-01.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-16-20.baf 


(T7)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ PRIMARY  BackRest2_PRIMARY_2015-05-20_16-42-33.ddf noRECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-42-49.ddf noRECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-43-02.ddf noRECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-43-14.ddf noRECOVERY
(T8)
restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-44-07.trn
(T9)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-47-01.trn
#>}
{<#---------------------------- Restore   790   T11 #>}
 {<#
 T11 is FBFileGroup ,it isnot restore, must restore T12
(t1)  restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak
(t11)
restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-56-07.baf
restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-56-20.baf
restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-56-31.baf
restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-56-47.baf
(T12)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-58-25.trn
#>}

{<#---------------------------- Restore   805   T16 non all #>}
{<#
(T1)   restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak

(t11) restoreFBFileGroupNORECOVERY 
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-56-07.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-56-20.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-56-31.baf
#restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-56-47.baf
 必須要所有的FG Full backup (4個)都還原.才可以進行Diff

(T15)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_PRIMARY_2015-05-20_17-08-47.ddf NORECOVERY 
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_17-09-00.ddf NORECOVERY  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_17-09-18.ddf NORECOVERY  
#restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_17-09-42.ddf NORECOVERY 


restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_PRIMARY_2015-05-20_17-08-47.ddf RECOVERY 
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_17-09-00.ddf RECOVERY  
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_17-09-18.ddf RECOVERY  
#restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_17-09-42.ddf RECOVERY 
必須要所有的FG Diff backup (4個)都還原.才可以進行 restore LOG
(T16)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_17-13-51.trn

#>}


{<#  T17  Database full backup  BackRest2_2015-05-21_09-42-52.bak  #>}
{<#      
# PRIMARY_TABLE =1700 , T6= 1000  , Student=20480 
PRIMARY_TABLE =1700  , Student=1000 , T6= 2000 , T1=100
$dbt='BackRest2'
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T17'
    GO 200

function backupFBdatabase ([string] $instance, [string] $dbname,[string]$bakpath){ 
# backupFBdatabase sp2013 mingdb  \\SP2013\temp
#$instance='sp2013'
#$backuppath='\\SP2013\temp'
#$dbname='BackRest'

$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bak' ;#$bakFile

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' 
"@  
$tsql_backupdatabase
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance $instance 

#get-item $bakFile
}#function backupFBdatabase

backupFBdatabase sp2013 $dbt \\SP2013\temp  #BackRest2_2015-05-21_09-42-52.bak

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-21  23:59:59' -24  # 

selectT6modtime sp2013  $dbt
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/20/2015 5:08:00 PM 3898 800 359 97A295F3-13D6-4871-9B89-C1AD368C15A0                                                            ...
5/20/2015 5:08:00 PM 3897 799 682 D896404F-9A27-4BC5-981F-0BC1EA9919B4                                                            ...
5/20/2015 5:08:00 PM 3896 798 665 5355602C-5D41-42D3-8E4D-D7B94938A0C8                                                            ...
5/20/2015 5:08:00 PM 3895 797 340 61A4FDF7-972F-49E5-984A-CB87EA53FBB5                                                            ...
5/20/2015 5:08:00 PM 3894 796 929 D2C18DCB-DE94-4E17-942C-381AB5BAC587                                                            ...


2000


#>}


{<#  T18  trn  BackRest2_2015-05-21_09-47-38.trn  #>}
{<#

PRIMARY_TABLE =1800  , Student=1100 , T6= 2100 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T18'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
   
insertT6 $dbt 500

backupLog $dbt \\SP2013\temp   # BackRest2_2015-05-21_09-47-38.trn
selectT6modtime sp2013  $dbt
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 9:46:00 AM 3998 100 114 DFE85138-985D-4AEC-B69B-CAD17D9E8208                                                            ...
5/21/2015 9:46:00 AM 3997  99 160 A131B106-44B1-46C4-9698-C94B87675ADC                                                            ...
5/21/2015 9:46:00 AM 3996  98 599 B0866845-3037-4236-A539-9D02DFADB6F2                                                            ...
5/21/2015 9:46:00 AM 3995  97  18 8083AB1F-8FEB-4867-B2BC-A2446EDA06A1                                                            ...
5/21/2015 9:46:00 AM 3994  96 965 ACBDE3C8-3520-4432-B3E0-E4DD20A46486                                                            ...


2100
#>}

{<#  T19   trn  ? #>}
{<#

PRIMARY_TABLE =1900  , Student=1200 , T6= 2600 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T19'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
   
insertT6 $dbt 500

backupLog $dbt \\SP2013\temp   #BackRest2_2015-05-20_17-06-45.trn
selectT6modtime sp2013  $dbt
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 9:51:00 AM 4498 500 272 EE55E999-6C0D-4DE3-B9E5-95F9F6C3215B                                                            ...
5/21/2015 9:51:00 AM 4497 499 213 A2029FF6-3AAC-4815-A2D0-9C7AD95C2626                                                            ...
5/21/2015 9:51:00 AM 4496 498 428 3C1A21F1-2105-4F37-9F9A-5389D2AA4CA5                                                            ...
5/21/2015 9:51:00 AM 4495 497 532 9267D530-7E04-4930-B141-2AF0342906C9                                                            ...
5/21/2015 9:51:00 AM 4494 496 702 014F2BEA-6197-46F6-833F-D04E96ED96FC                                                            ...
2600
#>}

{<#  T20  Database diff  BackRest2_2015-05-21_09-58-14.dif  #>}
{<#

PRIMARY_TABLE =2000  , Student=2000 , T6= 2700 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T20'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
   
insertT6 $dbt 100

backupDiffdatabase $dbt \\SP2013\temp   #BackRest2_2015-05-21_09-58-14.dif

selectT6modtime sp2013  $dbt

createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 9:57:00 AM 4598 100 966 7F7157CD-5D92-40CC-AEE9-027EDD364475                                                            ...
5/21/2015 9:57:00 AM 4597  99  99 DC5A6CD0-CD9C-430E-B971-77B8D7576A81                                                            ...
5/21/2015 9:57:00 AM 4596  98 527 498801C0-E8A5-4748-BEAF-E298ABE4298B                                                            ...
5/21/2015 9:57:00 AM 4595  97 779 4583DCA2-3AEB-4557-A29F-B43BD6DD6E4F                                                            ...
5/21/2015 9:57:00 AM 4594  96 180 E89DA059-2AD2-4F14-AC13-004725706E16                                                            ...


2700

#>}

{<#  T21  trn  BackRest2_2015-05-21_09-59-50.trn #>}
{<#

PRIMARY_TABLE =2100  , Student=2100 , T6= 2800 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T21'
    GO 100
INSERT INTO Student(FName)
    VALUES('T21')
    GO 100
   
insertT6 $dbt 100

backupLog $dbt \\SP2013\temp   #BackRest2_2015-05-21_09-59-50.trn

selectT6modtime sp2013  $dbt

createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 9:59:00 AM 4698 100 403 0A67D805-AD7C-49FF-A2B3-5C3F68E7FEA6                                                            ...
5/21/2015 9:59:00 AM 4697  99 730 4A455FDF-3406-469B-A2F1-4242461F6B5D                                                            ...
5/21/2015 9:59:00 AM 4696  98 937 179F49BB-5B56-47A9-9E96-22BB9FDD3A3A                                                            ...
5/21/2015 9:59:00 AM 4695  97 348 CFE3D89A-64A5-4172-B116-B995217674AD                                                            ...
5/21/2015 9:59:00 AM 4694  96  75 3538F687-8D15-40CE-9740-D9CF50B14C7E                                                            ...


2800

#>}

{<#  T22 trn BackRest2_2015-05-21_10-00-59.trn #>}
{<#

PRIMARY_TABLE =2200  , Student=2200 , T6= 2900 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T22'
    GO 100
INSERT INTO Student(FName)
    VALUES('T22')
    GO 100
   
insertT6 $dbt 100

backupLog $dbt \\SP2013\temp   # BackRest2_2015-05-21_10-00-59.trn
selectT6modtime sp2013  $dbt
createdate             iid rid val rstring                                                                                           
----------             --- --- --- -------                                                                                           
5/21/2015 10:00:00 AM 4798 100 949 E8650E79-A50C-4200-8F73-0654C7A8B129                                                           ...
5/21/2015 10:00:00 AM 4797  99 629 55DC3E3A-F33F-4303-8A89-DBCEEED8DB7E                                                           ...
5/21/2015 10:00:00 AM 4796  98 158 D42E70C5-9123-413D-B1F2-EA104B0605F4                                                           ...
5/21/2015 10:00:00 AM 4795  97 568 BF7876BE-C8CC-4625-816E-617B0FFACDE4                                                           ...
5/21/2015 10:00:00 AM 4794  96 738 DF803906-8AD3-4613-8CB9-A1EC84BD9D67                                                           ...

2900
#>}

{<#  T23  Database diff  BackRest2_2015-05-21_10-02-57.dif  #>}
{<#

PRIMARY_TABLE =2300  , Student=2200 , T6= 3000 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T23'
    GO 100


   
insertT6 $dbt 100

backupDiffdatabase $dbt \\SP2013\temp   #BackRest2_2015-05-21_10-02-57.dif
selectT6modtime sp2013  $dbt

createdate             iid rid val rstring                                                                                           
----------             --- --- --- -------                                                                                           
5/21/2015 10:02:00 AM 4898 100 947 B7022C94-0727-4A6D-A444-269A69500C81                                                           ...
5/21/2015 10:02:00 AM 4897  99 440 0FF28BE9-FAE4-4C11-9DB2-A3D63C983244                                                           ...
5/21/2015 10:02:00 AM 4896  98 533 EC89BE65-EBB2-485B-A262-6BF2E5DFBC8E                                                           ...
5/21/2015 10:02:00 AM 4895  97 159 4E01BB31-1FEA-4C1A-B872-191B9BD278B9                                                           ...
5/21/2015 10:02:00 AM 4894  96 312 A55FD109-3C0D-4C1C-BEAF-9E37C5A3337A                                                           ...


3000
#>}

{<#  T24  trn  BackRest2_2015-05-21_10-06-42.trn #>}
{<#

PRIMARY_TABLE =2400  , Student=2400 , T6= 0 , T1=100
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T24'
    GO 100
INSERT INTO Student(FName)
    VALUES('T24')
    GO 200
   
truncateT6 $dbt

backupLog $dbt \\SP2013\temp   #BackRest2_2015-05-21_10-06-42.trn
selectT6modtime sp2013  $dbt


#>}

{<#
selectbackupset $dbt
name      type                DBL               FLSN                LSN DiffLSN            BST                   BET                 
----      ----                ---               ----                --- -------            ---                   ---                 
(T24   trn)
BackRest2 L    199000000036400188 202000000075200001 203000000027400001                    5/21/2015 10:06:42 AM 5/21/2015 10:06:4...
(T23  DB Diff)
BackRest2 I    199000000036400188 202000000107600017 202000000108500001 199000000036400188 5/21/2015 10:02:57 AM 5/21/2015 10:02:5...
(T22  trn)
BackRest2 L    199000000036400188 202000000032000001 202000000075200001                    5/21/2015 10:00:59 AM 5/21/2015 10:00:5...
(T21  trn )
BackRest2 L    199000000036400188 199000000070200001 202000000032000001                    5/21/2015 9:59:50 AM  5/21/2015 9:59:50 AM
(T20 DB Diff )
BackRest2 I    199000000036400188 201000000101100050 201000000103400001 199000000036400188 5/21/2015 9:58:14 AM  5/21/2015 9:58:14 AM
(T18)
BackRest2 L    199000000036400188 199000000035800001 199000000070200001                    5/21/2015 9:47:38 AM  5/21/2015 9:47:38 AM
(T17 DB FB)
BackRest2 D     50000000023900047 199000000036400188 199000000044100001                    5/21/2015 9:42:52 AM  5/21/2015 9:42:53 AM

BackRest2 L     50000000023900047 197000000026100001 199000000035800001                    5/20/2015 5:13:51 PM  5/20/2015 5:13:51 PM
BackRest2 G     50000000023900047 199000000023600001 199000000023900001 192000000028600036 5/20/2015 5:09:42 PM  5/20/2015 5:09:42 PM
BackRest2 G     50000000023900047 199000000023300001 199000000023600001 192000000025000037 5/20/2015 5:09:18 PM  5/20/2015 5:09:19 PM
BackRest2 G     50000000023900047 199000000023000001 199000000023300001 192000000021800036 5/20/2015 5:09:00 PM  5/20/2015 5:09:01 PM
BackRest2 G     50000000023900047 199000000022100017 199000000023000001 192000000018900043 5/20/2015 5:08:47 PM  5/20/2015 5:08:47 PM
BackRest2 L     50000000023900047 193000000004900001 197000000026100001                    5/20/2015 5:06:45 PM  5/20/2015 5:06:45 PM
BackRest2 G     50000000023900047 194000000044300001 194000000044600001 192000000028600036 5/20/2015 5:02:48 PM  5/20/2015 5:02:48 PM
BackRest2 G     50000000023900047 194000000044000001 194000000044300001 192000000025000037 5/20/2015 5:02:11 PM  5/20/2015 5:02:11 PM
BackRest2 G     50000000023900047 194000000043700001 194000000044000001 192000000021800036 5/20/2015 5:02:10 PM  5/20/2015 5:02:10 PM
BackRest2 G     50000000023900047 194000000043400001 194000000043700001 192000000021800036 5/20/2015 5:01:53 PM  5/20/2015 5:01:53 PM
BackRest2 G     50000000023900047 194000000042100026 194000000043400001 192000000018900043 5/20/2015 5:01:42 PM  5/20/2015 5:01:42 PM

#>}


{<#---------------------------- Restore   1112   T20 #>}
{<#
#-
(T20)  restoreDiffdatabase sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_09-58-14.dif #DIFF  無法單獨使用 ,that failure
#-
(T17)  restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-21_09-42-52.bak

(T20)  restoreDiffdatabase sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_09-58-14.dif # restored because no files are ready to rollforward.

#-
(T17)  restoreFBdatabaseNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_09-42-52.bak

(T20)  restoreDiffdatabase sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_09-58-14.dif # workable
                                                                                 


#>}

{<#---------------------------- Restore   1130   T23 #>}
{<#

(T17)  restoreFBdatabaseNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_09-42-52.bak

(T23)  restoreDiffdatabase sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_10-02-57.dif # workable
                                                                                 


#>}

{<#---------------------------- Restore   1141   T24 #>}
{<#

(T17)  restoreFBdatabaseNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_09-42-52.bak

(T23)  restoreFBdatabaseNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_10-02-57.dif                                                                         
(T24)  restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-21_10-06-42.trn   # workable

#>}

{<#----------------------------  Restore    1151  T4 T5 T6 ( T5 FG Diff point ) L:616 #>}
{<#
(T1)   restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak
       restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak
(T3)
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-15-30.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-15-46.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-16-01.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-16-20.baf 

   (T4 )restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-17-19.trn # workable

(T5)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ PRIMARY  BackRest2_PRIMARY_2015-05-20_16-32-54.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-33-25.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-33-38.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-33-51.ddf RECOVERY 

(T6)
restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-38-08.trn #workable

#>}


{<#----------------------------  Restore    1173  T10 ( T10 FG Diff point ) L:616 #>}
{<#
(T1)   restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak
       restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest2_2015-05-20_16-08-47.bak
(T3)
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-15-30.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-15-46.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-16-01.baf
restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-16-20.baf 


(T10)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ PRIMARY  BackRest2_PRIMARY_2015-05-20_16-51-14.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-51-25.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest2_FG2_2015-05-20_16-51-42.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest2_FG3_2015-05-20_16-51-52.ddf RECOVERY


(T12) restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-58-25.trn #
--(T4)  restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest2_2015-05-20_16-17-19.trn

restoreDBonline sp2013 $dbt
#>}
#---------------------------------------------------------------
# 2 1000  BackRest function   for ps1
#---------------------------------------------------------------

if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }
$dbt='BackRest2'

function selectFileGroupONPath ([string] $instance,[string] $dbname ){
# selectFileGroupONPath sp2013 mingdb
# $instance='sp2013'
$tsql_selectFPonPath=@"
select y.name as FileGroup,  d.name as FileName, d.physical_name as PhysicalName ,d.state_desc as state_desc
from sys.filegroups y
left join [sys].[database_files] d 
on y.data_space_id=d.data_space_id 
order by y.name;
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectFPonPath -Database $dbname  -ServerInstance  $instance
$y | ft -auto
$y.count
}#function selectFileGroupONPath
#selectFileGroupONPath sp2013 $dbt

function selectTableONFileGroup ([string] $instance,[string] $dbname ){
# selectTableONFileGroup sp2013 mingdb
# $instance='sp2013'
$tsql_selectTableONFileGroup=@"
SELECT OBJECT_NAME(i.[object_id]) AS [ObjectName]
	,i.[index_id] AS [IndexID]
	,i.[name] AS [IndexName]
	,i.[type_desc] AS [IndexType]
	,i.[data_space_id] AS [DatabaseSpaceID]
	,f.[name] AS [FileGroup]
	,d.[physical_name] AS [DatabaseFileName]
FROM [sys].[indexes] i
INNER JOIN [sys].[filegroups] f
	ON f.[data_space_id] = i.[data_space_id]
INNER JOIN [sys].[database_files] d
	ON f.[data_space_id] = d.[data_space_id]
INNER JOIN [sys].[data_spaces] s
	ON f.[data_space_id] = s.[data_space_id]
WHERE OBJECTPROPERTY(i.[object_id], 'IsUserTable') = 1
ORDER BY OBJECT_NAME(i.[object_id]),f.[name] ,i.[data_space_id]
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectTableONFileGroup -Database $dbname  -ServerInstance  $instance
$y | ft -auto
$y.count
}#function selectTableONFileGroup
#selectTableONFileGroup sql2012x  $dbt

function backupFBdatabase ([string] $instance, [string] $dbname,[string]$bakpath){ 
# backupFBdatabase sp2013 mingdb  \\SP2013\temp
#$backuppath='\\SP2013\temp'
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bak' ;#$bakFile

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' 
"@  
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance $instance 

get-item $bakFile
}#function backupFBdatabase

function backupFBFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string]$FGName){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
#$FGName='FGX'
# backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1
$bafFile=$backuppath+'\'+$dbname+'_'+$FGName+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.baf' ;#$bafFile 
switch ($FGName){
    'FGX' { 
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1',FILEGROUP = 'FG2'
     TO DISK = N'$bafFile';
GO
"@ }#FGX
    'FG1' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1'
     TO DISK = N'$bafFile';
GO
"@ }#FG1
    'FG2' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG2'
     TO DISK = N'$bafFile';
GO
"@ }#FG2
    'FG3' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG3'
     TO DISK = N'$bafFile';
GO
"@ }#FG3
    'PRIMARY' {
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'PRIMARY'
     TO DISK = N'$bafFile';
GO
"@}
}#switch

#$tsql_backupFG
Invoke-Sqlcmd  -Query  $tsql_backupFG  -QueryTimeout  2400  -ServerInstance $instance 
}#backupFBFileGroup
#backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1

function backupDiffdatabase ([string] $dbname,[string]$bakpath){
#$backuppath='\\SP2013\temp'
# backupDiffdatabase $dbt \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.dif' ;#$bakFile
#$trnFile=$backuppath+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.trn'

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' WITH DIFFERENTIAL
"@  
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance sp2013 

get-item $bakFile
}#function backupDiffdatabase
#backupDiffdatabase $dbt \\SP2013\temp
function backupDiffFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string]$FGName){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
#$FGName='FGX'
# backupDiffFileGroup  sp2013 mingdb \\SP2013\temp PRIMARY
$bafFile=$backuppath+'\'+$dbname+'_'+$FGName+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.ddf' ;#$bafFile 
switch ($FGName){
    'FGX' { 
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1',FILEGROUP = 'FG2'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL ;
GO
"@ }#FGX
    'FG1' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG1'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@ }#FG1
    'FG2' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG2'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@ }#FG2
    'FG3' {  
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'FG3'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@ }#FG3
    'PRIMARY' {
    $tsql_backupFG=@" 
    BACKUP DATABASE $dbname
    FILEGROUP = 'PRIMARY'
     TO DISK = N'$bafFile' WITH DIFFERENTIAL;
GO
"@}
}#switch

#$tsql_backupFG
Invoke-Sqlcmd  -Query  $tsql_backupFG  -QueryTimeout  2400  -ServerInstance $instance
}#backupDiffFileGroup
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY

function backupLog ([string] $dbname,[string]$bakpath){
#$backuppath='\\SP2013\temp'
# backupLog mingdb \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.trn' ;#$bakFile
#$trnFile=$backuppath+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.trn'

$tsql_backuplog=@"
   BACKUP Log $dbname TO  DISK = N'$bakFile'
"@  
Invoke-Sqlcmd  -Query  $tsql_backuplog  -QueryTimeout  2400  -ServerInstance sp2013 
}#function backupLog

function backupFG_FGX ([string] $instance,[string] $dbname,[string]$bakpath){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
$
$bakFile=$backuppath+'\'+$dbname+'_FGX_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bck' ;#$bakFile
  $tsql_backupFG=@"
--Back up the files in SalesGroup1.
BACKUP DATABASE $dbt
   FILEGROUP = 'FG1',
   FILEGROUP = 'FG2'
   TO DISK = N'$bakFile';
GO
"@
Invoke-Sqlcmd  -Query  $tsql_backupFG  -QueryTimeout  2400  -ServerInstance sp2013 
  
}#backupFG_FGX
function backupFG_PMRY ([string] $instance,[string] $dbname,[string]$bakpath){ 
#$instance='sp2013'
#$dbname  ='mingdb'
#$backuppath ='\\SP2013\temp'
#backupFG_PMRY  sp2013 mingdb  \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_PMRY_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bck' ;#$bakFile
  $tsql_backupPMRY=@"

BACKUP DATABASE $dbt
   FILEGROUP = 'Primary'
   TO DISK = N'$bakFile';
GO
"@
Invoke-Sqlcmd  -Query  $tsql_backupPMRY  -QueryTimeout  2400  -ServerInstance sp2013 
  
}#backupFG_PMRY

function deleteT6 ([string] $instance,[string] $dbname,[string] $lvalues){
 #  deleteT6 sp2013 mingdb '< 20'
 
  $tsql_DeleteT6=@"
  Delete from  [dbo].[T6] where rid $lvalues
"@  
#$tsql_DeleteT6
Invoke-Sqlcmd  -Query  $tsql_DeleteT6  -Database $dbname    -ServerInstance sp2013 

}#function deleteT6

function GetBDLFile ($bakpath, $dbname, $whatday ,$hourrange ){ #  1168 function
#$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto
#GetBDLFile  \\SP2013\temp\ mingdb '2015-05-05  10:10:00' -48
#$bakpath= '\\SP2013\temp\'
#$dbname  = 'mingdb'
#$whatday='2015-05-05  10:10:00'
#$hourrange =-48

$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.*';#$bpath
cd c:
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddHours($hourrange)
    $bakf |Select name ,creationTime,LastWriteTime,length |sort LastWriteTime -Descending
}# 1168 function GetbdlFile 

function GetBAFFile ($bakpath, $dbname, $whatday ,$hourrange ){ #  1168 function
#$d=GetBAFFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto
#GetBAFFile  \\SP2013\temp\ mingdb '2015-05-08  23:10:00' -48
#$bakpath= '\\SP2013\temp\'
#$dbname  = 'mingdb'
#$whatday='2015-05-05  10:10:00'
#$hourrange =-48

$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.baf';#$bpath
cd c:
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddHours($hourrange)
    $bakf |Select name ,creationTime,LastWriteTime,length |sort LastWriteTime -Descending
}# 1168 GetBAFFile

function insertT6 ([string]$dbname,$countx){
    #$dbname='mingdb'
    #$countx=50;'6--'+$countx
    #insertT6 $dbt 200
    $tsql_insertT6=@"
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <= $countx
begin
  select @val=cast((RAND()*1000) as int) ;-- print @val
  select @rstring=NEWID(); --print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:01'  
end
"@
Invoke-Sqlcmd  -Query  $tsql_insertT6  -Database $dbname -QueryTimeout  1800   -ServerInstance sp2013
}#insertT6

function restoreFBdatabase ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='backrest2'
#$backuppath='\\SP2013\temp\'
#$bFile='BackRest2_2015-05-20_16-08-47.bak'
# restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname from  DISK = N'$bakFile' with REPLACE --,RECOVERY
"@  
$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFBdatabase

function restoreFBdatabaseNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_00-02-11.bak'
#restoreFBdatabaseNORECOVERY sql2012x $dbt  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with REPLACE, NORECOVERY
"@  
$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreFBdatabaseNORECOVERY
#restoreFBdatabaseNORECOVERY sql2012x $dbt  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.bak
Function restoreFBFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string] $FGName ,[string] $bFile){
#$instance  ='sql2012x'
#$dbname    ='mingdb'
#$backuppath='\\SP2013\temp\'
#$FGName    ='FG1'
#$bFile     ='mingdb_FG1_2015-05-11_11-21-15.baf'
#restoreFBFileGroup  sql2012x mingdb  \\SP2013\temp\  FG1  mingdb_FG1_2015-05-11_11-21-15.baf
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM   DISK = N'$bakFile'
   with REPLACE ,RECOVERY
"@  
$tsql_restoreFBdatabase
$t1=get-date
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400
$t2=get-date

}#function restoreFBFileGroup

function restoreFBFileGroupNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $FGName ,[string] $bFile){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
#restoreFBFileGroupNORECOVERY  sql2012x mingdb  \\SP2013\temp\ FG1  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM   DISK = N'$bakFile'
   with REPLACE ,NORECOVERY
"@  
$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFBFileGroupNORECOVERY

function restoreDiffdatabase ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
 #$instance='sql2012x'
 #$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreDiffdatabase
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
function restoreDiffdatabaseNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreDiffdatabaseNORECOVERY
#restoreDiffdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif

function restoreDiffFileGroup ([string] $instance,[string] $dbname,[string]$bakpath,[string] $FGName ,[string] $bFile ,[string] $NORecovery){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
#restoreDiffFileGroup  sql2012x mingdb  \\SP2013\temp\ FG1  mingdb_2015-05-04_00-02-11.bak RECOVERY
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")

if ($NORecovery -eq 'Recovery'){
 $tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM   DISK = N'$bakFile'
   with RECOVERY
"@  
$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400   
} #if
else{
  $tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = '$FGName'
   FROM DISK = N'$bakFile'
   with NORECOVERY
"@  
$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400
  
} #else



}#function restoreDiffFileGroup

function restoreLogR?([string] $instance,[string] $dbname,[string]$bakpath,[string] $NORecovery){
#$backuppath='\\SP2013\temp'
# restoreLogR mingdb \\SP2013\temp
# restoreLogR sql2012x $dbt  Recovery
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.trn' ;#$bakFile
if ($NORecovery -eq 'Recovery' ){
    $tsql_restorelogR=@"
   restore Log $dbname from  DISK = N'$bakFile' 
"@  
Invoke-Sqlcmd  -Query  $tsql_restorelogR   -ServerInstance $instance -Database $dbname
} #if
else{
$tsql_restorelogR=@"
   restore Log $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restorelogR   -ServerInstance $instance -Database $dbname
} #else
}#function restoreLogR

function restoreLOG ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreLOG sql2012x $dbt  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore log $dbname from  DISK = N'$bakFile' with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance
}#function restoreLOG

function restoreLOGNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreLOGNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore log $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance
}#function restoreLOGNORECOVERY


function restoreDBonline ([string] $instance,[string] $dbname){
#$backuppath='\\SP2013\temp'
# restoreDBonline mingdb \\SP2013\temp
# restoreDBonline sp2013 mingdb
$tsql_restoreDBonline=@"
   restore Database $dbname with RECOVERY
"@  
$tsql_restoreDBonline
Invoke-Sqlcmd  -Query  $tsql_restoreDBonline   -ServerInstance $instance -Database $dbname
}#function restoreDBonline

function restoreFG_PMRY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
$instance='sp2013'
$dbname='mingdb'
$backuppath='\\SP2013\temp\'
$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
# restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = 'PRIMARY'
   FROM   DISK = N'$bakFile'
   with REPLACE --,RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFG_PMRY

function restoreFG_FGX ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_PMRY_2015-05-08_13-34-06.bck'
# restoreFG_FGX  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname 
   FILEGROUP = 'FG1',
   FILEGROUP = 'FG2'
   FROM   DISK = N'$bakFile'
   with REPLACE --,RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFG_FGX


function selectbackupset ([string] $dbname){
#$dbname='mingdb'
$tsql_selectbackupset=@"
SELECT
DATABASE_NAME as 'name',
type,
--RECOVERY_MODEL as '還原模式',
DATABASE_BACKUP_LSN  as 'DBL',
FIRST_LSN  as 'FLSN',
LAST_LSN as 'LSN',
DIFFERENTIAL_BASE_LSN as 'DiffLSN',
backup_start_date as 'BST', 
backup_finish_date as 'BET',
DATEDIFF(second, backup_start_date,backup_finish_date) as DurationSecond,
DATEDIFF(mi, backup_start_date,backup_finish_date) as Durationminute,
backup_size *0.000000001 as GB
FROM msdb.dbo.backupset 
WHERE DATABASE_NAME= '$dbname'
order by backup_finish_date desc 
"@  
$u=Invoke-Sqlcmd  -Query  $tsql_selectbackupset  -QueryTimeout  2400  -ServerInstance sp2013 

$u |ft -auto
}#function selectbackupset

function selectT6modtime ([string] $instance,[string] $dbname){
  $tsql_selectT6=@"
  select top 5 createdate,iid,rid,val,rstring from dbo.t6 order by createDate desc ,iid  desc
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname   -ServerInstance  $instance
$y|ft -AutoSize
$tsql_selectT6c=@"
  select count(rid)as cc from dbo.t6 
"@  
$m=Invoke-Sqlcmd  -Query  $tsql_selectT6c  -Database $dbname   -ServerInstance  $instance
$m.cc
}#function seledctT6modtime

function truncateT6 ([string] $dbname){
  $tsql_selectT6=@"
  truncate table  [dbo].[T6]
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname    -ServerInstance sp2013 
$y
}#function truncateT6
<#-----case1-----#>
{<#
if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }
truncateT6 $dbt ;
insertT6 mingdb 50    # 5/8/2015 1:26:00 PM  50  50 769 42768DB0-B17C-47BE-B4DD-EE1025F1FC38 ,


backupFG_PMRY  sp2013  mingdb  \\SP2013\temp  #save to mingdb_PMRY_2015-05-08_13-34-06.bck

selectFileGroupONPath  sp2013 $dbt


GetbdlFile  \\SP2013\temp\ mingdb '2015-05-08  23:10:00' -24 |fl

mingdb_FGX_2015-05-08_13-11-00.bck

truncateT6 $dbt ;
insertT6 mingdb 99  #5/8/2015 2:05:00 PM  99  99 180 0164EF1E-782E-403D-8893-A44920A4BE62 

$t1=get-date
restoreFG_PMRY  sp2013  mingdb  \\SP2013\temp\  mingdb_PMRY_2015-05-08_13-34-06.bck  1 min12 sec
$t2=get-date
$t2-$t1

selectT6modtime sp2013 mingdb
RESTORE DATABASE mingdb WITH RECOVERY;
#>}
<#-----case2-----#>
http://stackoverflow.com/questions/25841822/backup-and-restore-sql-server-database-filegroup
<#-----case  511  -----#>
{<#
#(3.0)  ref: sqlps02_Sqlconfiguration. 24  1015   List All Objects Created on All Filegroups in Databas

#2 create tabel on File Group
{0 create table t6 on FG1,create table t6 on FG1,



CREATE TABLE Student
(
ID INT IDENTITY(1,1) NOT NULL,
FName VARCHAR(50),
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([ID] ASC)
on [FG2]
)
GO


CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [FG1]
GO



}

selectFileGroupONPath sp2013 mingdb
selectTableONFileGroup sp2013 mingdb


#3.Insert T6  Student
{<#INSERT INTO Student(FName)
VALUES('Joe')
GO 20
INSERT INTO Student(FName)
SELECT FName FROM Student
GO 10
# check how many records are inserted
# this should give 20480
SELECT COUNT(*) FROM Student

truncateT6 $dbt ;seledctT6 $dbt

Student.count: 20480
T6:count=100


#>}
#4.First Fbbackup
{<#
backupFBdatabase sp2013 mingdb  \\SP2013\temp  # mingdb_2015-05-11_10-42-42.bak , T6 100, Student 20480

selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto    #mingdb_2015-05-11_10-42-42.bak

restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-11_10-42-42.bak

selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb

select count(*) from sql2012x.mingdb.dbo.student
selectFileGroupONPath sql2012x mingdb
selectTableONFileGroup sql2012x mingdb
#>}

#5.Delete T6 ,drop Student 
{<#
DeleteT6 sp2013 mingdb '< 20'
Drop table student
#>}


#6 backup FB FileGroup

{<#
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1 # mingdb_FG1_2015-05-11_11-21-15.baf  # T6.count 81
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG2   #mingdb_FG2_2015-05-11_11-22-47.baf  #student null
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  

select top 5 *  from mingdb.dbo.t6 order by createDate desc
select count(*) from mingdb.dbo.student

select top 5 *  from sql2012x.mingdb.dbo.t6 order by createDate desc
select count(*) from sql2012x.mingdb.dbo.student
#>}

#7 insert T6 119 , create student  add 90
{<#
INSERT INTO Student(FName)
VALUES('Hell Ming')
GO 90

insertT6 mingdb 119
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb

#>}
#8 backup DB FileGroup
{<#
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp FG1  #  mingdb_FG1_2015-05-11_11-49-33.ddf   t6 200
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp FG2  #  mingdb_FG2_2015-05-11_11-52-23.ddf    student 90.

selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#9 insert T6 =250
{<#
insertT6 mingdb 50
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb
#>}
# 10 backup Log 1 
{<#
backupLog mingdb \\SP2013\temp  #mingdb_2015-05-11_13-40-20.trn t6.count= 250
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#11 insert T6 =250
{<#
insertT6 mingdb 250
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb
#>}
#12  backup DB FileGroup 2
{<#
backupDiffFileGroup  sp2013 mingdb \\SP2013\temp FG1  #  mingdb_FG1_2015-05-11_13-51-26.ddf   t6.count= 500
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#13 insert T6 500 (count.1000)
{<#
insertT6 mingdb 500
selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb
#>}
#14 backup Log2
{<#
backupLog mingdb \\SP2013\temp  #mingdb_2015-05-11_13-56-12.trn  t6.count= 1000
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}
#15 Backup FB  FileGroup 2
{<#
<INDEX>
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG1  #mingdb_FG1_2015-05-11_14-20-52.baf # T6.count 1000
#>}
#16 insert student 
{<#
INSERT INTO Student(FName)
SELECT FName FROM Student

GO 10
#>}
#17 Backup FB  FileGroup 3
{<#
backupFBFileGroup  sp2013 mingdb \\SP2013\temp FG2  #mingdb_FG2_2015-05-11_14-26-02.baf #student 102400
selectbackupset $dbt 
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto  
#>}

#18  restre FG1 to 11-21-15 t6.count=81
GetbdlFile  H:\SQLServer\backups FGRestoreTEST  '2015-05-11  23:00:00' -24 |ft -auto  


selectT6modtime sp2013 mingdb

$t1=get-date
restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-11_10-42-42.bak  #1min 32 sec
$t2=get-date  ($t2-$t1)

selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb

#
$t1=get-date
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-11_10-42-42.bak   # 1 min 39sec
$t2=get-date

$t1=get-date
restoreFBdatabaseNORECOVERY sp2013 mingdb  \\SP2013\temp\ mingdb_2015-05-11_10-42-42.bak   # 1 min 39sec
$t2=get-date


$t1=get-date
restoreFBFileGroup  sp2013  mingdb  \\SP2013\temp\  FG1  mingdb_FG1_2015-05-11_11-21-15.baf # 36 sec
$t2=get-date

selectbackupset  FGRestoreTEST


 RESTORE HEADERONLY   FROM DISK = N'\\SP2013\temp\mingdb_FG1_2015-05-11_11-21-15.baf'
 StartDate 2015-05-11 11:21:20.000
 FLSN  2599000002457600180
 LLSN  2599000002465200001
 2599000002442400001


restoreDBonline sql2012x mingdb

selectFileGroupONPath sp2013 FGRestoreTEST
selectTableONFileGroup sp2013 FGRestoreTEST


#>}
<#-----case4-----#>


--Backup the files in the SalesGroup1 secondary filegroup.
BACKUP DATABASE $dbt
   FILE = 'SGrp1Fi2', 
   FILE = 'SGrp2Fi2' 
   TO DISK = 'G:\SQL Server Backups\Sales\SalesGroup1.bck';
GO

--Back up the files in SalesGroup1.
BACKUP DATABASE $dbt
   FILEGROUP = 'FG1',
   FILEGROUP = 'FG2'
   TO DISK = 'C:\MySQLServer\Backups\Sales\SalesFiles.bck';
GO

--Back up the files in SalesGroup1.
BACKUP DATABASE Sales
   FILEGROUP = 'SalesGroup1',
   FILEGROUP = 'SalesGroup2'
   TO DISK = 'C:\MySQLServer\Backups\Sales\SalesFiles.bck';
GO



#-- Restoring using FILE and FILEGROUP syntax
RESTORE DATABASE MyDatabase
   FILE = 'MyDatabase_data_1',
   FILE = 'MyDatabase_data_2',
   FILEGROUP = 'new_customers'
   FROM MyDatabaseBackups
   WITH 
      FILE = 9,
      NORECOVERY;
GO
-- Restore the log backups.

RESTORE LOG MyDatabase
   FROM MyDatabaseBackups
   WITH FILE = 10, 
      NORECOVERY;
GO
RESTORE LOG MyDatabase
   FROM MyDatabaseBackups
   WITH FILE = 11, 
      NORECOVERY;
GO
RESTORE LOG MyDatabase
   FROM MyDatabaseBackups
   WITH FILE = 12, 
      NORECOVERY;
GO
--Recover the database:
RESTORE DATABASE MyDatabase WITH RECOVERY;
GO


#---


RESTORE DATABASE Sales FILEGROUP=SalesGroup2 WITH RECOVERY


#---------------------------------------------------------------
# 3 2100  BackRest DB  for TSQL  只執份部分FG Backup
#---------------------------------------------------------------
{<#   t0   #>}
{<# t0
$dbt='BackRest3'
CREATE DATABASE [BackRest3]
ON PRIMARY
 ( NAME = N'BackRest3'    , FILENAME = N'H:\SQLDB\BackRest3.mdf')
  LOG ON 
( NAME = N'BackRest3_log', FILENAME = N'H:\SQLDB\BackRest3.ldf')
GO


USE master
GO
ALTER DATABASE [BackRest3]
ADD FILEGROUP [FG1]
GO

ALTER DATABASE [BackRest3]
ADD FILEGROUP [FG2]
GO

ALTER DATABASE [BackRest3]
ADD FILEGROUP [FG3]
GO

ALTER DATABASE [BackRest3]
ADD FILE 
 (NAME = BackRest3FG1F1,  FILENAME = 'H:\SQLDB\BackRest3FG1F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest3FG1F2,  FILENAME = 'H:\SQLDB\BackRest3FG1F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG1;
GO

ALTER DATABASE [BackRest3]
ADD FILE 
 (NAME = BackRest3FG2F1,  FILENAME = 'H:\SQLDB\BackRest3FG2F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest3FG2F2,  FILENAME = 'H:\SQLDB\BackRest3FG2F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest3FG2F3,  FILENAME = 'H:\SQLDB\BackRest3FG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG2;
GO

ALTER DATABASE [BackRest3]
ADD FILE 
 (NAME = BackRest3FG3F1,  FILENAME = 'H:\SQLDB\BackRest3FG3F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest3FG3F2,  FILENAME = 'H:\SQLDB\BackRest3FG3F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
--,(NAME = BackRestFG2F3,  FILENAME = 'H:\SQLDB\BackRestFG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG3;
GO


selectFileGroupONPath sp2013 $dbt   selectFileGroupONPath sp2013 $dbt

FileGroup FileName       PhysicalName                state_desc
--------- --------       ------------                ----------
FG1       BackRest3FG1F1 H:\SQLDB\BackRest3FG1F1.ndf ONLINE    
FG1       BackRest3FG1F2 H:\SQLDB\BackRest3FG1F2.ndf ONLINE    
FG2       BackRest3FG2F1 H:\SQLDB\BackRest3FG2F1.ndf ONLINE    
FG2       BackRest3FG2F2 H:\SQLDB\BackRest3FG2F2.ndf ONLINE    
FG2       BackRest3FG2F3 H:\SQLDB\BackRest3FG2F3.ndf ONLINE    
FG3       BackRest3FG3F1 H:\SQLDB\BackRest3FG3F1.ndf ONLINE    
FG3       BackRest3FG3F2 H:\SQLDB\BackRest3FG3F2.ndf ONLINE    
PRIMARY   BackRest3      H:\SQLDB\BackRest3.mdf      ONLINE    


8

selectTableONFileGroup sp2013 $dbt
0

use BackRest3
CREATE TABLE [PRIMARY_TABLE]
(ID INT,
 NAME CHAR(4)) ON [PRIMARY];


IF OBJECT_ID('Student') IS NOT NULL
DROP TABLE Student
GO

CREATE TABLE Student
(
ID INT IDENTITY(1,1) NOT NULL,
FName VARCHAR(50),
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([ID] ASC)
on [FG2]
)
GO


CREATE UNIQUE CLUSTERED INDEX PK_Student
ON dbo.Student
(
ID ASC
)
WITH (DROP_EXISTING=ON, ONLINE=ON)
ON FG2
GO

use BackRest3
IF OBJECT_ID('T6') IS NOT NULL
DROP TABLE T6
GO
CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [FG1]
GO

selectTableONFileGroup sp2013 $dbt
ObjectName    IndexID IndexName  IndexType DatabaseSpaceID FileGroup DatabaseFileName           
----------    ------- ---------  --------- --------------- --------- ----------------           
PRIMARY_TABLE       0            HEAP                    1 PRIMARY   H:\SQLDB\BackRest3.mdf     
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest3FG2F1.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest3FG2F2.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest3FG2F3.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest3FG1F1.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest3FG1F2.ndf
6


    INSERT INTO [PRIMARY_TABLE]
    SELECT 1, 'TEST'
    GO 100

    INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 20
    INSERT INTO Student(FName)
    SELECT FName FROM Student
    GO 10
    # check how many records are inserted
    # this should give 20480
    SELECT COUNT(*) FROM Student


    Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
    while @rid <= 1000
    begin
    select @val=cast((RAND()*1000) as int) ;-- print @val
    select @rstring=NEWID(); --print @rstring
    insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
    set @rid=@rid+1
    --WAITFOR DELAY '00:00:01'  
    end

select count(*) as PRIMARY_TABLE from backrest3.dbo.PRIMARY_TABLE
select count(*) as t6 from backrest3.dbo.t6
select count(*) as Student from backrest3.dbo.Student
select count(*) as t1 from backrest3.dbo.t1


selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 2:26:00 PM 1000 1000 619 E530D2F7-ACD3-43E8-928D-7D7B22958E9F                                                           ...
5/21/2015 2:26:00 PM  999  999 740 BC9FCE41-C588-4122-820F-867EF0943179                                                           ...
5/21/2015 2:26:00 PM  998  998 809 C0AD88D8-B759-4264-A722-BC2F6965B785                                                           ...
5/21/2015 2:26:00 PM  997  997 990 32F3CF38-3BDF-47FA-92BD-F126973579FF                                                           ...
5/21/2015 2:26:00 PM  996  996 936 AAE76813-156C-490C-85D0-D85EBBEBDDBB                                                           ...
1000

#}>
#>}

{<#  t1  Database full backup BackRest3_2015-05-21_14-27-13.bak  #>}
{<#      
# PRIMARY_TABLE =100 , T6= 1000  , Student=20480 
$dbt='BackRest3'

backupFBdatabase sp2013 $dbt \\SP2013\temp

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:59:59' -24  # BackRest3_2015-05-21_14-27-13.bak

selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 2:26:00 PM 1000 1000 619 E530D2F7-ACD3-43E8-928D-7D7B22958E9F                                                           ...
5/21/2015 2:26:00 PM  999  999 740 BC9FCE41-C588-4122-820F-867EF0943179                                                           ...
5/21/2015 2:26:00 PM  998  998 809 C0AD88D8-B759-4264-A722-BC2F6965B785                                                           ...
5/21/2015 2:26:00 PM  997  997 990 32F3CF38-3BDF-47FA-92BD-F126973579FF                                                           ...
5/21/2015 2:26:00 PM  996  996 936 AAE76813-156C-490C-85D0-D85EBBEBDDBB                                                           ...
1000

#>}

{<#  t2  trn 1  BackRest3_2015-05-21_14-29-33.trn  #>}
{<#      
PRIMARY_TABLE =200 , T6= 800  , Student=20480 
 
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T2'
    GO 100

deleteT6 sp2013 $dbt ' <= 200'
selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 2:26:00 PM 1000 1000 619 E530D2F7-ACD3-43E8-928D-7D7B22958E9F                                                           ...
5/21/2015 2:26:00 PM  999  999 740 BC9FCE41-C588-4122-820F-867EF0943179                                                           ...
5/21/2015 2:26:00 PM  998  998 809 C0AD88D8-B759-4264-A722-BC2F6965B785                                                           ...
5/21/2015 2:26:00 PM  997  997 990 32F3CF38-3BDF-47FA-92BD-F126973579FF                                                           ...
5/21/2015 2:26:00 PM  996  996 936 AAE76813-156C-490C-85D0-D85EBBEBDDBB                                                            ...
800

backupLog $dbt \\SP2013\temp
selectT6modtime sp2013  backrest      
#BackRest3_2015-05-21_14-29-33.trn

#>}
{<#  t3  FG backup    #>}
{<#
PRIMARY_TABLE =300 , T6= 1000  , Student=20480     ,t1=1000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T3'
    GO 100

insertT6 $dbt 200

selectT6modtime sp2013  $dbt   
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 2:30:00 PM 1200 200 536 F96EFCDF-5722-499F-93A9-55AD9DE7B565                                                            ...
5/21/2015 2:30:00 PM 1199 199 333 080D2EB6-2C5E-498D-AC5F-8E5FC3A682B3                                                            ...
5/21/2015 2:30:00 PM 1198 198 352 C32C27F4-63E8-4E8F-A59A-BF0B840A2FDF                                                            ...
5/21/2015 2:30:00 PM 1197 197 756 60C7CB75-57C8-49A4-B2B8-01D175B8D84F                                                            ...
5/21/2015 2:30:00 PM 1196 196 979 79DE40F9-7710-4469-8556-562FB23A80F8                                                            ...
1000

CREATE TABLE [dbo].[T1](
	[c1] [nchar](10) NOT NULL,
	[c2] [nchar](10) NULL,
	[c3] uniqueidentifier  NOT NULL DEFAULT (N'newsequentialid()') , 
	updateDate datetime,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [FG3]
) ON [FG3]

selectTableONFileGroup sp2013 $dbt
ObjectName    IndexID IndexName  IndexType DatabaseSpaceID FileGroup DatabaseFileName           
----------    ------- ---------  --------- --------------- --------- ----------------           
PRIMARY_TABLE       0            HEAP                    1 PRIMARY   H:\SQLDB\BackRest3.mdf     
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest3FG2F1.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest3FG2F2.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest3FG2F3.ndf
T1                  1 PK_T1      CLUSTERED               4 FG3       H:\SQLDB\BackRest3FG3F1.ndf
T1                  1 PK_T1      CLUSTERED               4 FG3       H:\SQLDB\BackRest3FG3F2.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest3FG1F1.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest3FG1F2.ndf
8


DECLARE @counter smallint ,@val  int ;
SET @counter = 1;
WHILE @counter <= 1000
   BEGIN
      select @val=cast((RAND()*1000) as int)
      insert into [dbo].[T1] VALUES (@counter ,@val,NEWID(),getdate())
      SET @counter = @counter + 1
	    --WAITFOR DELAY '00:00:02' 
   END;

   backupFBFileGroup  sp2013 $dbt \\SP2013\temp Primary  # BackRest3_Primary_2015-05-21_14-32-58.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1      # BackRest3_FG1_2015-05-21_14-33-14.baf
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG2     #
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG3     #
#>}


{<#  t4    trn BackRest3_2015-05-21_14-34-36.trn   #>}
{<#
PRIMARY_TABLE =300 , T6= 1000  , Student=20480     ,t1=1000
backupLog $dbt \\SP2013\temp  # BackRest3_2015-05-21_14-34-36.trn

selectbackupset $dbt 

name      type               DBL              FLSN               LSN DiffLSN BST                  BET                  DurationSecond
----      ----               ---              ----               --- ------- ---                  ---                  --------------
BackRest3 L    50000000023800047 51000000025800001 55000000015300001         5/21/2015 2:34:36 PM 5/21/2015 2:34:37 PM              1
BackRest3 F    50000000023800047 55000000013300036 55000000015000001         5/21/2015 2:33:14 PM 5/21/2015 2:33:14 PM              0
BackRest3 F    50000000023800047 55000000004300194 55000000012300001         5/21/2015 2:32:58 PM 5/21/2015 2:32:58 PM              0
BackRest3 L    50000000023800047 50000000023800047 51000000025800001         5/21/2015 2:29:33 PM 5/21/2015 2:29:33 PM              0
BackRest3 D                    0 50000000023800047 50000000025800001         5/21/2015 2:27:13 PM 5/21/2015 2:27:14 PM              1

#>}



{<#  t5   FG Diff   #>}
{<#      
PRIMARY_TABLE =500  , Student=20480 , T6= 1 , T1=32767
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T5'
    GO 200

deleteT6 sp2013 $dbt '< 1000'

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  # BackRest3_PRIMARY_2015-05-21_14-37-40.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      # BackRest3_FG1_2015-05-21_14-37-57.ddf
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #

selectT6modtime sp2013  $dbt 
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 2:26:00 PM 1000 1000 619 E530D2F7-ACD3-43E8-928D-7D7B22958E9F                                                           ...
1

#>}



{<#  t6    trn 3 BackRest3_2015-05-21_14-39-15.trn #>}
{<#      
PRIMARY_TABLE =600  , Student=0 , T6= 101 , T1=1000


 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T6'
    GO 100

 insertT6 $dbt 100

 Delete from  [dbo].[Student] 

 backupLog $dbt \\SP2013\temp    #BackRest3_2015-05-21_14-39-15.trn

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:10:00' -24

#>}


{<#  t7    FG Diff #>}
{<#      
PRIMARY_TABLE =700  , Student=200 , T6= 201 , T1=1000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T7'
    GO 100

 insertT6 $dbt 100

  INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200

#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  #
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      # BackRest3_FG2_2015-05-21_14-41-27.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      # BackRest3_FG3_2015-05-21_14-41-47.ddf




#>}

{<#  t8    trn BackRest3_2015-05-21_14-42-39.trn #>}
{<#      
PRIMARY_TABLE =700  , Student=200 , T6= 201 , T1=1000
backupLog $dbt \\SP2013\temp    #BackRest3_2015-05-21_14-42-39.trn
#>}


{<#  t9    trn BackRest3_2015-05-21_14-44-34.trn  #>}
{<#      
PRIMARY_TABLE =900  , Student=400 , T6= 300 , T1=32767
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T9'
    GO 200
 INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200
 insertT6 $dbt 99

backupLog $dbt \\SP2013\temp  #BackRest3_2015-05-21_14-44-34.trn


selectT6modtime sp2013  $dbt 
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 2:43:00 PM 1499  99 818 7C107CDF-188E-4B05-809F-092D37DD4E28                                                            ...
5/21/2015 2:43:00 PM 1498  98 388 97B92A57-ED73-475E-AFFA-13E0B00CF8EE                                                            ...
5/21/2015 2:43:00 PM 1497  97 754 01B15E99-5252-44F6-963A-0C237F8D39A2                                                            ...
5/21/2015 2:43:00 PM 1496  96 468 6D6BF1F8-0B31-48A6-9D40-6452F60B0175                                                            ...
5/21/2015 2:43:00 PM 1495  95 160 61E28E1B-F4B5-4D4A-8B87-DC662B4BCE54                                                             ...
300
#>}

{<#  t10    FG backup #>}
{<#      
PRIMARY_TABLE =1000  , Student=500 , T6= 600 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T10'
    GO 100
INSERT INTO Student(FName)
    VALUES('EN')
    GO 100
insertT6 $dbt 300

drop table t1

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY   #BackRest3_PRIMARY_2015-05-21_14-46-40.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1       #BackRest3_FG1_2015-05-21_14-46-53.ddf
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2       #
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3       #

selectT6modtime sp2013  $dbt

createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 2:46:00 PM 1799 300 140 479AF4ED-2480-4E27-BD0C-25129A5ABEB9                                                            ...
5/21/2015 2:46:00 PM 1798 299 154 3073B83D-E2F9-498E-BCB5-6A27D36DB3EA                                                            ...
5/21/2015 2:46:00 PM 1797 298 500 51F886D2-D754-45EB-BF11-61A9C6689560                                                            ...
5/21/2015 2:46:00 PM 1796 297 770 29477878-AC91-4E03-BE12-96F033274AFE                                                            ...
5/21/2015 2:46:00 PM 1795 296 398 0508E299-C1C6-469B-AD53-15978C6FE881                                                            ...
600
#>}

{<#  t11    FG full backup  #>}
{<#      
PRIMARY_TABLE =1100  , Student=500 , T6= 600 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T11'
    GO 100
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp Primary  #
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1      #
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest3_FG2_2015-05-21_14-49-25.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest3_FG3_2015-05-21_14-49-43.baf




#>}

{<#  t12    trn BackRest3_2015-05-21_14-52-02.trn #>}
{<#      
PRIMARY_TABLE =1200  , Student=700 , T6= 700 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T12'
    GO 100
INSERT INTO Student(FName)
    VALUES('EN')
    GO 200
insertT6 $dbt 100

backupLog $dbt \\SP2013\temp   #  BackRest3_2015-05-21_14-52-02.trn

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-19  10:10:00' -24

#>}


{<#  t13   FG Diff  #>}
{<#      
PRIMARY_TABLE =1300  , Student=800 , T6= 1 , T1=1000
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T13'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
deleteT6 sp2013 $dbt '<= 500'

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  #BackRest3_PRIMARY_2015-05-21_14-58-00.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #BackRest3_FG1_2015-05-21_14-58-12.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #BackRest3_FG2_2015-05-21_14-58-25.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #BackRest3_FG3_2015-05-21_14-58-38.ddf

selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 2:26:00 PM 1000 1000 619 E530D2F7-ACD3-43E8-928D-7D7B22958E9F 
1
#>}

{<#  t14    trn  BackRest3_2015-05-21_14-59-57.trn  #>}
{<#      
PRIMARY_TABLE =1400  , Student=900 , T6= 1200 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T14'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
   
insertT6 $dbt 1199

backupLog $dbt \\SP2013\temp   #BackRest3_2015-05-21_14-59-57.trn
selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 3:00:00 PM 3098 1199 303 126AC727-162A-45BC-958F-581646D59AB6                                                           ...
5/21/2015 3:00:00 PM 3097 1198 117 C9DC8AC0-B8D7-4C45-B59E-34724C2664F4                                                           ...
5/21/2015 3:00:00 PM 3096 1197  47 88723FCC-1A46-4770-907E-2F0947EECE80                                                           ...
5/21/2015 3:00:00 PM 3095 1196 125 05D8A47C-1868-4FD5-95C3-75B35D249511                                                           ...
5/21/2015 3:00:00 PM 3094 1195 119 6992E689-42DF-46EB-A717-8CFEE3BC7D3B                                                          ...
1200

#>}

{<#  t15   FG Diff  #>}
{<#      
PRIMARY_TABLE =1500  , Student=1000 , T6= 2000 , T1=drop
INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T15'
    GO 100
INSERT INTO Student(FName)
    VALUES('vera')
    GO 100
insertT6 $dbt 800

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  # BackRest3_PRIMARY_2015-05-21_15-02-17.ddf
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      #
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      # BackRest3_FG2_2015-05-21_15-02-39.ddf
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #
#>}

{<#  t16    trn BackRest3_2015-05-21_15-06-07.trn  #>}
{<#      
PRIMARY_TABLE =1600  , Student=1000 , T6= 2000 , T1=88

INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T16'
    GO 100

CREATE TABLE [dbo].[T1](
	[c1] [nchar](10) NOT NULL,
	[c2] [nchar](10) NULL,
	[c3] uniqueidentifier  NOT NULL DEFAULT (N'newsequentialid()') , 
	updateDate datetime,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [FG3]
) ON [FG3]

DECLARE @counter smallint ,@val  int ;
SET @counter = 1;
WHILE @counter <= 88
   BEGIN
      select @val=cast((RAND()*1000) as int)
      insert into [dbo].[T1] VALUES (@counter ,@val,NEWID(),getdate())
      SET @counter = @counter + 1
	    --WAITFOR DELAY '00:00:02' 
   END;

backupLog $dbt \\SP2013\temp    #BackRest3_2015-05-21_15-06-07.trn

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-19  10:10:00' -24
#>}
{<#
selectbackupset $dbt
BackRest3 L    50000000023800047 81000000012100001 85000000018800001                   5/21/2015 3:06:07 PM 5/21/2015 3:06:07 PM    0
BackRest3 G    50000000023800047 84000000047500001 84000000047800001 72000000049900041 5/21/2015 3:02:39 PM 5/21/2015 3:02:39 PM    0
BackRest3 G    50000000023800047 84000000046600017 84000000047500001 55000000004300194 5/21/2015 3:02:18 PM 5/21/2015 3:02:18 PM    0
BackRest3 L    50000000023800047 73000000044800001 81000000012100001                   5/21/2015 2:59:57 PM 5/21/2015 2:59:57 PM    0
(T13 FG Diff)
BackRest3 G    50000000023800047 76000000014000001 76000000014300001 72000000053700036 5/21/2015 2:58:38 PM 5/21/2015 2:58:38 PM    0
BackRest3 G    50000000023800047 76000000013700001 76000000014000001 72000000049900041 5/21/2015 2:58:25 PM 5/21/2015 2:58:25 PM    0
BackRest3 G    50000000023800047 76000000013400001 76000000013700001 55000000013300036 5/21/2015 2:58:12 PM 5/21/2015 2:58:12 PM    0
BackRest3 G    50000000023800047 76000000012100026 76000000013400001 55000000004300194 5/21/2015 2:58:00 PM 5/21/2015 2:58:00 PM    0
(T12 trn)
BackRest3 L    50000000023800047 70000000041600001 73000000044800001                   5/21/2015 2:52:02 PM 5/21/2015 2:52:02 PM    0
(T11 FG FB)
BackRest3 F    50000000023800047 72000000053700036 72000000055400001                   5/21/2015 2:49:43 PM 5/21/2015 2:49:43 PM    0
BackRest3 F    50000000023800047 72000000049900041 72000000051800001                   5/21/2015 2:49:25 PM 5/21/2015 2:49:25 PM    0
(T10 FG Diff)
BackRest3 G    50000000023800047 72000000039300001 72000000039600001 55000000013300036 5/21/2015 2:46:53 PM 5/21/2015 2:46:53 PM    0
BackRest3 G    50000000023800047 72000000032800153 72000000039300001 55000000004300194 5/21/2015 2:46:40 PM 5/21/2015 2:46:40 PM    0
(T9  trn)
BackRest3 L    50000000023800047 69000000027000001 70000000041600001                   5/21/2015 2:44:34 PM 5/21/2015 2:44:34 PM    0
(T8  trn)
BackRest3 L    50000000023800047 68000000022100001 69000000027000001                   5/21/2015 2:42:39 PM 5/21/2015 2:42:39 PM    0
(T7 FG Diff)
BackRest3 G    50000000023800047 69000000026700001 69000000027000001 50000000023800047 5/21/2015 2:41:47 PM 5/21/2015 2:41:47 PM    0
BackRest3 G    50000000023800047 69000000025800017 69000000026700001 50000000023800047 5/21/2015 2:41:27 PM 5/21/2015 2:41:27 PM    0
(T6  trn)
BackRest3 L    50000000023800047 55000000015300001 68000000022100001                   5/21/2015 2:39:15 PM 5/21/2015 2:39:15 PM    0
(T5 FG Diff)
BackRest3 G    50000000023800047 59000000003700001 59000000004000001 55000000013300036 5/21/2015 2:37:57 PM 5/21/2015 2:37:57 PM    0
BackRest3 G    50000000023800047 59000000001600046 59000000003700001 55000000004300194 5/21/2015 2:37:40 PM 5/21/2015 2:37:41 PM    1
(T4  trn)
BackRest3 L    50000000023800047 51000000025800001 55000000015300001                   5/21/2015 2:34:36 PM 5/21/2015 2:34:37 PM    1
(T3 FG FB)
BackRest3 F    50000000023800047 55000000013300036 55000000015000001                   5/21/2015 2:33:14 PM 5/21/2015 2:33:14 PM    0
BackRest3 F    50000000023800047 55000000004300194 55000000012300001                   5/21/2015 2:32:58 PM 5/21/2015 2:32:58 PM    0
(T2 )
BackRest3 L    50000000023800047 50000000023800047 51000000025800001                   5/21/2015 2:29:33 PM 5/21/2015 2:29:33 PM    0
(T1 )
BackRest3 D                    0 50000000023800047 50000000025800001                   5/21/2015 2:27:13 PM 5/21/2015 2:27:14 PM    1

#>}

{<#---------------------------- Restore  2676   T14  sql2012x #>}
{<#
select count(*) as PRIMARY_TABLE from backrest2.dbo.PRIMARY_TABLE
select count(*) as t6 from backrest2.dbo.t6
select count(*) as Student from backrest2.dbo.Student
select count(*) as T1 from backrest2.dbo.T1

#1. create new database by TSQL ,It must databse full backup 

#-
(T1)restoreFBdatabase 
    restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
    restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
(T3)
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest3_Primary_2015-05-21_14-32-58.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest3_FG1_2015-05-21_14-33-14.baf
(T10)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest3_PRIMARY_2015-05-21_14-37-40.ddf NORECOVERY 
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest3_FG1_2015-05-21_14-37-57.ddf NORECOVERY 

(T11) only one failure must all FBFilegroup L:2496
    #restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest2_Primary_2015-05-20_16-56-07.baf
    #restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest2_FG1_2015-05-20_16-56-20.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest3_FG2_2015-05-21_14-49-25.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest3_FG3_2015-05-21_14-49-43.baf
(t12)
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-52-02.trn
(t14)
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-59-57.trn 

#>}

{<#----------------------------  Restore  2695   T4 #>}
{<#
$dbt='BackRest3'
(T1)restoreFBdatabase 
    restoreFBdatabase            sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
    restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
(T2)
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
    #restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
(T3)
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest3_Primary_2015-05-21_14-32-58.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest3_FG1_2015-05-21_14-33-14.baf
    restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest3_Primary_2015-05-21_14-32-58.baf
    restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest3_FG1_2015-05-21_14-33-14.baf
(T4) 
    restoreLOG sql2012x           $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-34-36.trn 
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-34-36.trn 
(T6) 
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-39-15.trn
     restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-39-15.trn
(T8 ) 
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-42-39.trn
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-42-39.trn
#>}
{<#----------------------------  Restore    2708  T4 using trn #>}
{<#
(T1)restoreFBdatabase 
    #restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak #not work
    restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
(T2)
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
    #restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
(T4)
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-34-36.trn # workable
#>}



























#---------------------------------------------------------------
# 4 2760  BackRest4 DB  for TSQL  只執份部分FG Backup 但中間不加trn
#---------------------------------------------------------------
{<#   t0   #>}
{<# t0
$dbt='BackRest4'
CREATE DATABASE [BackRest4]
ON PRIMARY
 ( NAME = N'BackRest4'    , FILENAME = N'H:\SQLDB\BackRest4.mdf')
  LOG ON 
( NAME = N'BackRest4_log', FILENAME = N'H:\SQLDB\BackRest4.ldf')
GO


USE master
GO
ALTER DATABASE [BackRest4]
ADD FILEGROUP [FG1]
GO

ALTER DATABASE [BackRest4]
ADD FILEGROUP [FG2]
GO

ALTER DATABASE [BackRest4]
ADD FILEGROUP [FG3]
GO

ALTER DATABASE [BackRest4]
ADD FILE 
 (NAME = BackRest4FG1F1,  FILENAME = 'H:\SQLDB\BackRest4FG1F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest4FG1F2,  FILENAME = 'H:\SQLDB\BackRest4FG1F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG1;
GO

ALTER DATABASE [BackRest4]
ADD FILE 
 (NAME = BackRest4FG2F1,  FILENAME = 'H:\SQLDB\BackRest4FG2F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest4FG2F2,  FILENAME = 'H:\SQLDB\BackRest4FG2F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest4FG2F3,  FILENAME = 'H:\SQLDB\BackRest4FG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG2;
GO

ALTER DATABASE [BackRest4]
ADD FILE 
 (NAME = BackRest4FG3F1,  FILENAME = 'H:\SQLDB\BackRest4FG3F1.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
,(NAME = BackRest4FG3F2,  FILENAME = 'H:\SQLDB\BackRest4FG3F2.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
--,(NAME = BackRestFG2F3,  FILENAME = 'H:\SQLDB\BackRestFG2F3.ndf',SIZE = 5MB,MAXSIZE = 100MB,FILEGROWTH = 5MB)
  TO FILEGROUP FG3;
GO


selectFileGroupONPath sp2013 $dbt   selectFileGroupONPath sp2013 $dbt
FileGroup FileName       PhysicalName                state_desc
--------- --------       ------------                ----------
FG1       BackRest4FG1F1 H:\SQLDB\BackRest4FG1F1.ndf ONLINE    
FG1       BackRest4FG1F2 H:\SQLDB\BackRest4FG1F2.ndf ONLINE    
FG2       BackRest4FG2F1 H:\SQLDB\BackRest4FG2F1.ndf ONLINE    
FG2       BackRest4FG2F2 H:\SQLDB\BackRest4FG2F2.ndf ONLINE    
FG2       BackRest4FG2F3 H:\SQLDB\BackRest4FG2F3.ndf ONLINE    
FG3       BackRest4FG3F1 H:\SQLDB\BackRest4FG3F1.ndf ONLINE    
FG3       BackRest4FG3F2 H:\SQLDB\BackRest4FG3F2.ndf ONLINE    
PRIMARY   BackRest4      H:\SQLDB\BackRest4.mdf      ONLINE    
   


8

selectTableONFileGroup sp2013 $dbt
0

use BackRest4
CREATE TABLE [PRIMARY_TABLE]
(ID INT,
 NAME CHAR(4)) ON [PRIMARY];


IF OBJECT_ID('Student') IS NOT NULL
DROP TABLE Student
GO

CREATE TABLE Student
(
ID INT IDENTITY(1,1) NOT NULL,
FName VARCHAR(50),
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([ID] ASC)
on [FG2]
)
GO


CREATE UNIQUE CLUSTERED INDEX PK_Student
ON dbo.Student
(
ID ASC
)
WITH (DROP_EXISTING=ON, ONLINE=ON)
ON FG2
GO

use BackRest4
IF OBJECT_ID('T6') IS NOT NULL
DROP TABLE T6
GO
CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [FG1]
GO

selectTableONFileGroup sp2013 $dbt
ObjectName    IndexID IndexName  IndexType DatabaseSpaceID FileGroup DatabaseFileName           
----------    ------- ---------  --------- --------------- --------- ----------------           
PRIMARY_TABLE       0            HEAP                    1 PRIMARY   H:\SQLDB\BackRest4.mdf     
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest4FG2F1.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest4FG2F2.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest4FG2F3.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest4FG1F1.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest4FG1F2.ndf
6


    INSERT INTO [PRIMARY_TABLE]
    SELECT 1, 'TEST'
    GO 100

    INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 20
    INSERT INTO Student(FName)
    SELECT FName FROM Student
    GO 10
    # check how many records are inserted
    # this should give 20480
    SELECT COUNT(*) FROM Student


    Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
    while @rid <= 1000
    begin
    select @val=cast((RAND()*1000) as int) ;-- print @val
    select @rstring=NEWID(); --print @rstring
    insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
    set @rid=@rid+1
    --WAITFOR DELAY '00:00:01'  
    end
select count(*) as PRIMARY_TABLE from backrest4.dbo.PRIMARY_TABLE
select count(*) as t6 from backrest4.dbo.t6
select count(*) as Student from backrest4.dbo.Student
--select count(*) as t1 from backrest4.dbo.t1


selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 4:53:00 PM 1000 1000 673 39BAEAC1-354C-421C-AA44-73E86E9AE829                                                           ...
5/21/2015 4:53:00 PM  999  999 683 4EFAF4AF-A285-4CC6-B99E-81087C4772F2                                                           ...
5/21/2015 4:53:00 PM  998  998 167 C8A7A6A4-05D2-4269-9378-A3BFEE26FB5F                                                           ...
5/21/2015 4:53:00 PM  997  997 925 6C1DCF29-84D2-4679-B56D-CF4A360FC734                                                           ...
5/21/2015 4:53:00 PM  996  996 212 5267D360-D842-4F73-A607-DAFDC602C50C                                                            ...                                                          ...
1000

#}>
#>}

{<#  t1  Database full backup BackRest4_2015-05-21_17-02-53.bak  #>}
{<#      
# PRIMARY_TABLE =200 , T6= 800  , Student=20480 
$dbt='BackRest3'

backupFBdatabase sp2013 $dbt \\SP2013\temp

GetBDLFile  \\SP2013\temp\ $dbt '2015-05-20  23:59:59' -24  # BackRest3_2015-05-21_14-27-13.bak

selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 2:26:00 PM 1000 1000 619 E530D2F7-ACD3-43E8-928D-7D7B22958E9F                                                           ...
5/21/2015 2:26:00 PM  999  999 740 BC9FCE41-C588-4122-820F-867EF0943179                                                           ...
5/21/2015 2:26:00 PM  998  998 809 C0AD88D8-B759-4264-A722-BC2F6965B785                                                           ...
5/21/2015 2:26:00 PM  997  997 990 32F3CF38-3BDF-47FA-92BD-F126973579FF                                                           ...
5/21/2015 2:26:00 PM  996  996 936 AAE76813-156C-490C-85D0-D85EBBEBDDBB                                                           ...
1000

#>}

{<#  t2  trn 1  BackRest4_2015-05-21_17-05-24.trn  #>}
{<#      
PRIMARY_TABLE =200 , T6= 500  , Student=20480 
 
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T2'
    GO 100

deleteT6 sp2013 $dbt ' <= 500'

selectT6modtime sp2013  $dbt
createdate            iid  rid val rstring                                                                                           
----------            ---  --- --- -------                                                                                           
5/21/2015 4:53:00 PM 1000 1000 673 39BAEAC1-354C-421C-AA44-73E86E9AE829                                                           ...
5/21/2015 4:53:00 PM  999  999 683 4EFAF4AF-A285-4CC6-B99E-81087C4772F2                                                           ...
5/21/2015 4:53:00 PM  998  998 167 C8A7A6A4-05D2-4269-9378-A3BFEE26FB5F                                                           ...
5/21/2015 4:53:00 PM  997  997 925 6C1DCF29-84D2-4679-B56D-CF4A360FC734                                                           ...
5/21/2015 4:53:00 PM  996  996 212 5267D360-D842-4F73-A607-DAFDC602C50C                                                           ...
500

backupLog $dbt \\SP2013\temp
selectT6modtime sp2013  backrest      
#BackRest3_2015-05-21_14-29-33.trn

#>}
{<#  t3  FG backup    #>}
{<#
PRIMARY_TABLE =300 , T6= 700  , Student=20480     ,t1=1000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T3'
    GO 100

insertT6 $dbt 200

selectT6modtime sp2013  $dbt   
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 5:06:00 PM 1200 200  24 EAFC0270-5180-410F-9484-E4A47B801787                                                            ...
5/21/2015 5:06:00 PM 1199 199 920 63BEAE0C-CD93-4E34-A5DD-EC2EC567881E                                                            ...
5/21/2015 5:06:00 PM 1198 198 514 BA0B2743-770C-4380-888C-A84CC86026E1                                                            ...
5/21/2015 5:06:00 PM 1197 197 947 1EBC8884-9303-4126-814A-7D17C8D0636B                                                            ...
5/21/2015 5:06:00 PM 1196 196 420 6A702BC7-B39B-4450-9BD7-5B0B867ED7A9                                                            ...
1000

CREATE TABLE [dbo].[T1](
	[c1] [nchar](10) NOT NULL,
	[c2] [nchar](10) NULL,
	[c3] uniqueidentifier  NOT NULL DEFAULT (N'newsequentialid()') , 
	updateDate datetime,
 CONSTRAINT [PK_T1] PRIMARY KEY CLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [FG3]
) ON [FG3]

selectTableONFileGroup sp2013 $dbt
ObjectName    IndexID IndexName  IndexType DatabaseSpaceID FileGroup DatabaseFileName           
----------    ------- ---------  --------- --------------- --------- ----------------           
PRIMARY_TABLE       0            HEAP                    1 PRIMARY   H:\SQLDB\BackRest4.mdf     
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest4FG2F1.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest4FG2F2.ndf
Student             1 PK_Student CLUSTERED               3 FG2       H:\SQLDB\BackRest4FG2F3.ndf
T1                  1 PK_T1      CLUSTERED               4 FG3       H:\SQLDB\BackRest4FG3F1.ndf
T1                  1 PK_T1      CLUSTERED               4 FG3       H:\SQLDB\BackRest4FG3F2.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest4FG1F1.ndf
T6                  1 PK_T6      CLUSTERED               2 FG1       H:\SQLDB\BackRest4FG1F2.ndf
8


DECLARE @counter smallint ,@val  int ;
SET @counter = 1;
WHILE @counter <= 1000
   BEGIN
      select @val=cast((RAND()*1000) as int)
      insert into [dbo].[T1] VALUES (@counter ,@val,NEWID(),getdate())
      SET @counter = @counter + 1
	    --WAITFOR DELAY '00:00:02' 
   END;

   backupFBFileGroup  sp2013 $dbt \\SP2013\temp Primary  # BackRest4_Primary_2015-05-21_17-08-21.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1      # BackRest4_FG1_2015-05-21_17-08-35.baf
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG2     #
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG3     #
#>}


{<#  t4    trn BackRest3_2015-05-21_14-34-36.trn   #>}
{<#
PRIMARY_TABLE =300 , T6= 700  , Student=20480     ,t1=1000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T4'
    GO 100

insertT6 $dbt 200

selectT6modtime sp2013  $dbt   
createdate            iid rid val rstring                                                                                            
----------            --- --- --- -------                                                                                            
5/21/2015 5:10:00 PM 1400 200 927 5A1EF6B8-32F1-47E2-BFD7-68703DCCA8C3                                                            ...
5/21/2015 5:10:00 PM 1399 199 867 35483F8E-61D7-4D7E-8B69-EF718027D182                                                            ...
5/21/2015 5:10:00 PM 1398 198 752 4519743A-8BD9-430D-AEE5-282687B43AB0                                                            ...
5/21/2015 5:10:00 PM 1397 197  99 7C35B8A2-96EE-4AFF-BF77-CFFC42CABBAF                                                            ...
5/21/2015 5:10:00 PM 1396 196  27 189A2B71-9FFB-44F7-9862-DEC0503E9771                                                            ...
900





   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp Primary  # 
   #backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG1      # 
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG2     # BackRest4_FG2_2015-05-21_17-10-40.baf
   backupFBFileGroup  sp2013 $dbt \\SP2013\temp FG3     # BackRest4_FG3_2015-05-21_17-10-52.baf
#>}


{<#  t5    trn BackRest4_2015-05-21_17-12-46.trn #>}
{<#      
PRIMARY_TABLE =500  , Student=0 , T6= 1000 , T1=1000

 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T5'
    GO 100

 insertT6 $dbt 100

 Delete from  [dbo].[Student] 

 backupLog $dbt \\SP2013\temp    #BackRest3_2015-05-21_14-39-15.trn
#>}


{<#  t6    FG Diff #>}
{<#      
PRIMARY_TABLE =600  , Student=400 , T6= 1100 , T1=1000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T6'
    GO 100

 insertT6 $dbt 100

  INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200

backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  # BackRest4_PRIMARY_2015-05-21_17-16-25.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      # BackRest4_FG1_2015-05-21_17-16-46.ddf
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      # 
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      # 
#>}


{<#  t7    FG Diff #>}
{<#      
PRIMARY_TABLE =700  , Student=400 , T6= 1200 , T1=1000
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T7'
    GO 100

 insertT6 $dbt 100

  INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200

#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp PRIMARY  # 
#backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG1      # 
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG2      #  BackRest4_FG2_2015-05-21_17-18-49.ddf
backupDiffFileGroup  sp2013 $dbt \\SP2013\temp FG3      #  BackRest4_FG3_2015-05-21_17-19-08.ddf
#>}

{<#  t8    BackRest4_2015-05-21_17-22-18.trn #>}
{<#      
PRIMARY_TABLE =800  , Student=600 , T6= 1200 , T1=88
 INSERT INTO [PRIMARY_TABLE]
    SELECT 2, 'T8'
    GO 100
  INSERT INTO Student(FName)
    VALUES('vanessa')
    GO 200
backupLog $dbt \\SP2013\temp    #  BackRest4_2015-05-21_17-22-18.trn
#>}


{<#---------------------------- Restore  3133   T14  sql2012x #>}
#{<#
select count(*) as PRIMARY_TABLE from backrest4.dbo.PRIMARY_TABLE
select count(*) as t6 from backrest4.dbo.t6
select count(*) as Student from backrest4.dbo.Student
select count(*) as t1 from backrest4.dbo.t1

#1. create new database by TSQL ,It must databse full backup 

#-
(T1) 
              restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest4_2015-05-21_17-02-53.bak 
    restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest4_2015-05-21_17-02-53.bak 

(T2)         #restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest4_2015-05-21_17-05-24.trn 
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest4_2015-05-21_17-05-24.trn
   

(T3)
         restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest4_Primary_2015-05-21_17-08-21.baf
         restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1    BackRest4_FG1_2015-05-21_17-08-35.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest4_Primary_2015-05-21_17-08-21.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1    BackRest4_FG1_2015-05-21_17-08-35.baf

(T4)
          restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest4_FG2_2015-05-21_17-10-40.baf
          restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest4_FG3_2015-05-21_17-10-52.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG2  BackRest4_FG2_2015-05-21_17-10-40.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG3  BackRest4_FG3_2015-05-21_17-10-52.baf
    
(T5)          restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest4_2015-05-21_17-12-46.trn
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest4_2015-05-21_17-12-46.trn

(T6)
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ PRIMARY  BackRest4_PRIMARY_2015-05-21_17-16-25.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1      BackRest4_FG1_2015-05-21_17-16-46.ddf     RECOVERY


(T7)

restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG2   BackRest4_FG2_2015-05-21_17-18-49.ddf RECOVERY
restoreDiffFileGroup  sql2012x $dbt  \\SP2013\temp\ FG3   BackRest4_FG3_2015-05-21_17-19-08.ddf RECOVERY 

(T8)            restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest4_2015-05-21_17-22-18.trn
      restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest4_2015-05-21_17-22-18.trn

#>}

{<#----------------------------  Restore  2695   T4 #>}
{<#
$dbt='BackRest3'
(T1)restoreFBdatabase 
    restoreFBdatabase            sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
    restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
(T2)
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
    #restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
(T3)
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest3_Primary_2015-05-21_14-32-58.baf
    restoreFBFileGroupNORECOVERY  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest3_FG1_2015-05-21_14-33-14.baf
    restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ Primary  BackRest3_Primary_2015-05-21_14-32-58.baf
    restoreFBFileGroup  sql2012x $dbt  \\SP2013\temp\ FG1  BackRest3_FG1_2015-05-21_14-33-14.baf
(T4) 
    restoreLOG sql2012x           $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-34-36.trn 
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-34-36.trn 
(T6) 
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-39-15.trn
     restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-39-15.trn
(T8 ) 
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-42-39.trn
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-42-39.trn
#>}
{<#----------------------------  Restore    2708  T4 using trn #>}
{<#
(T1)restoreFBdatabase 
    #restoreFBdatabase  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak #not work
    restoreFBdatabaseNORECOVERY  sql2012x  $dbt  \\SP2013\temp\  BackRest3_2015-05-21_14-27-13.bak
(T2)
    restoreLOGNORECOVERY sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
    #restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-29-33.trn
(T4)
    restoreLOG sql2012x $dbt  \\SP2013\temp\ BackRest3_2015-05-21_14-34-36.trn # workable
#>}



#---------------------------------------------------------------
# 23  929  LSN 
#---------------------------------------------------------------
#{<#
SELECT
DATABASE_NAME as '資料庫名稱',
CASE [type]   
WHEN 'D' THEN N'資料庫' 
WHEN 'I' THEN N'差異資料庫' 
WHEN 'L' THEN N'紀錄' 
WHEN 'F' THEN N'檔案或檔案群組' 
WHEN 'G' THEN N'差異檔案' 
WHEN 'P' THEN N'部分' 
WHEN 'Q' THEN N'差異部分' 
ELSE N'NULL' 
END as '備份類型', 
--RECOVERY_MODEL as '還原模式',
DATABASE_BACKUP_LSN as '完整資料庫備份之LSN',
FIRST_LSN as '第一個LSN',
LAST_LSN as '下一個LSN',
DIFFERENTIAL_BASE_LSN as '差異備份的基底LSN',
backup_start_date as '備份開始時間', 
backup_finish_date as '備份完成時間',
backup_size *0.000000001
FROM msdb.dbo.backupset 
WHERE DATABASE_NAME='ssmatesterdb'
order by backup_finish_date desc


##-----------TEST DATA

if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }


$tsql_createT6=@"

if exists (select  * from sys.objects where object_id=object_id(N'T6'))
Drop table T6
GO

CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [PRIMARY]
GO

"@ #create table T6

Invoke-Sqlcmd  -Query  $tsql_createT6  -Database MingDB -QueryTimeout  1200   -ServerInstance sp2013

function backupFBdatabase ([string] $instance, [string] $dbname,[string]$bakpath){ 
# backupFBdatabase sp2013 mingdb  \\SP2013\temp
#$backuppath='\\SP2013\temp'
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.bak' ;#$bakFile

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' 
"@  
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance $instance 

get-item $bakFile
}#function backupFBdatabase

function backupDiffdatabase ([string] $dbname,[string]$bakpath){
#$backuppath='\\SP2013\temp'
# backupDiffdatabase mingdb \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.dif' ;#$bakFile
#$trnFile=$backuppath+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.trn'

$tsql_backupdatabase=@"
   BACKUP DATABASE $dbname TO  DISK = N'$bakFile' WITH DIFFERENTIAL
"@  
Invoke-Sqlcmd  -Query  $tsql_backupdatabase  -QueryTimeout  2400  -ServerInstance sp2013 

get-item $bakFile
}#function backupDiffdatabase

function backupLog ([string] $dbname,[string]$bakpath){
#$backuppath='\\SP2013\temp'
# backupLog mingdb \\SP2013\temp
$bakFile=$backuppath+'\'+$dbname+'_'+((get-date -Format yyyy-MM-dd_HH-mm-ss)).ToString()+'.trn' ;#$bakFile
#$trnFile=$backuppath+((get-date -Format yyyy_MM_dd_HHmm)).ToString()+'.trn'

$tsql_backuplog=@"
   BACKUP Log $dbname TO  DISK = N'$bakFile'
"@  
Invoke-Sqlcmd  -Query  $tsql_backuplog  -QueryTimeout  2400  -ServerInstance sp2013 
}#function backupLog


function  brprogress ([string] $instance){
# brprogress sql2012x
$tsql_select123=@"


    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT r.percent_complete
, DATEDIFF(MINUTE, start_time, GETDATE()) AS Age
, DATEADD(MINUTE, DATEDIFF(MINUTE, start_time, GETDATE()) /
percent_complete * 100, start_time) AS EstimatedEndTime
, t.Text AS ParentQuery
, SUBSTRING (t.text,(r.statement_start_offset/2) + 1,
((CASE WHEN r.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2
ELSE r.statement_end_offset
END - r.statement_start_offset)/2) + 1) AS IndividualQuery
, start_time
, DB_NAME(Database_Id) AS DatabaseName
, Status
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
WHERE session_id > 50
AND percent_complete > 0
ORDER BY percent_complete DESC
"@
Invoke-Sqlcmd  -Query  $tsql_select123  -QueryTimeout  2400  -ServerInstance $instance
}#function  brprogress
brprogress sql2012x


function GetbakFile ($bakpath, $dbname, $whatday,$type){ #p1089 function
#$bakpath= '\\SP2013\temp\' 
#$dbname  = 'mingdb'
#$whatday='2015-05-03  18:05:00'  
#$type   ='Getone'
# GetbakFile \\SP2013\temp\  mingdb  '2015-05-03  18:05:00'  Getone
$t=([datetime]$whatday);$t
#$t=([datetime]'2015-05-03  10:56:05')
$bpath=$bakpath+$dbname +'*.bak';#$bpath
cd c:
if ($type -eq 'sort')
{
 # '1'   
   $bakf=gi $bpath | ? LastWriteTime -LT  $t |sort  LastWriteTime -desc
   $bakf
}
else
{

if ($type -eq 'Getone'){#1104
    #'2'
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddDays(-1)
    $bakf |sort LastWriteTime -Descending
    #'3'
}#1104
}
    
}#p1089 function

#-- sort all backupFile
$rs=GetbakFile  \\SP2013\temp\  mingdb  2015-05-06  sort 
$rs  |select name,CreationTime,lastwritetime  |ft -auto
$rs  |select name,CreationTime,lastwritetime -last 1 |ft -auto

#--getone
$r=GetbakFile \\SP2013\temp\   mingdb  '2015-05-05  10:00:00'  Getone    ;$r |select name, creationTime,lastwriteTime
 
function GetBDLFile ($bakpath, $dbname, $whatday ,$hourrange ){ #  1168 function
#$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto
#GetBDLFile  \\SP2013\temp\ mingdb '2015-05-05  10:10:00' -48
#$bakpath= '\\SP2013\temp\'
#$dbname  = 'mingdb'
#$whatday='2015-05-05  10:10:00'
#$hourrange =-48

$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.*';#$bpath
cd c:
    $bakf=gi $bpath | ? creationTime -LT  $t |? creationTime -GT   $t.AddHours($hourrange)
    $bakf |Select name ,creationTime,LastWriteTime,length |sort LastWriteTime -Descending
}# 1168 function GetbdlFile 

function GetdifFile ($bakpath, $dbname, $whatday,$type){ #p1089 function
#$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-03  10:55:00'  Getone    ;$r |select name, creationTime,lastwriteTime -last 1
#$ds=GetdifFile  \\SP2013\temp\  mingdb  2015-05-04  sort 
#$ds  |select name,CreationTime,lastwritetime  |ft -auto
#$ds  |select name,CreationTime,lastwritetime -last 1 |ft -auto

$bakpath= '\\SP2013\temp\'
$dbname  = 'mingdb'
#$whatday='2015-05-04  22:05:00'
$whatday='5/4/2015 1:20:02 AM'
$type   ='Getone'
#GetdifFile \\SP2013\temp\   mingdb  '2015-05-05  10:10:00'  Getone 
$t=([datetime]$whatday);#$t
$bpath=$bakpath+$dbname +'*.dif';#$bpath
cd c:
if ($type -eq 'sort')
{
 # '1'   
   $bakf=gi $bpath | ? LastWriteTime -LE  $t |sort  LastWriteTime -desc
   $bakf
}
else
{

if ($type -eq 'Getone'){#1104
    #'2'
    $bakf= gi $bpath | ? LastWriteTime -lt  $t.AddSeconds(1) |? LastWriteTime -gt   $t.AddDays(-1)
    $bakf |sort LastWriteTime -Descending
    if ($bakf.count -eq 0)
    {
      $t.AddDays(-1).TOSTRING() + '~'  + $t.TOSTRING()   + '   No datA'
    }
    #'3'
}#1104
}
    
}# function GetdifFile

function insertT6 ([string]$dbname,$countx){
    #$dbname='mingdb'
    #$countx=50;'6--'+$countx
    $tsql_insertT6=@"
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <= $countx
begin
  select @val=cast((RAND()*1000) as int) ;-- print @val
  select @rstring=NEWID(); --print @rstring
  insert into dbo.t6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:01'  
end
"@
Invoke-Sqlcmd  -Query  $tsql_insertT6  -Database $dbname -QueryTimeout  1800   -ServerInstance sp2013
}#insertT6
insertT6 mingdb 7

function restoreFBdatabase ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sp2013'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_00-02-11.bak'
# restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   restore DATABASE $dbname from  DISK = N'$bakFile' with REPLACE --,RECOVERY
"@  
#$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase   -ServerInstance $instance -QueryTimeout 2400

}#function restoreFBdatabase

restoreFBdatabase  sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak 

function restoreFBdatabaseNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_00-02-11.bak'
#restoreFBdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.bak
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with REPLACE, NORECOVERY
"@  #$tsql_restoreFBdatabase
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreFBdatabaseNORECOVERY

function restoreDiffdatabase ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
 #$instance='sql2012x'
 #$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreFBdatabase=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreFBdatabase  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreDiffdatabase

function restoreDiffdatabaseNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore DATABASE $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance

}#function restoreDiffdatabaseNORECOVERY

function restoreLOG ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore log $dbname from  DISK = N'$bakFile' with RECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance
}#function restoreLOG

function restoreLOGNORECOVERY ([string] $instance,[string] $dbname,[string]$bakpath,[string] $bFile){
#$instance='sql2012x'
#$dbname='mingdb'
#$backuppath='\\SP2013\temp\'
#$bFile='mingdb_2015-05-04_01-20-01.dif'
#restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.dif
$bakFile=$backuppath+$bFile;$bakFile = $bakFile -replace(" ","")
$tsql_restoreDiffNR=@"
   REstore log $dbname from  DISK = N'$bakFile' with NORECOVERY
"@  
Invoke-Sqlcmd  -Query  $tsql_restoreDiffNR  -QueryTimeout  2400  -ServerInstance $instance
}#function restoreLOGNORECOVERY

function selectbackupset ([string] $dbname){
#$dbname='mingdb'
$tsql_selectbackupset=@"
SELECT
DATABASE_NAME as 'name',
type,
--RECOVERY_MODEL as '還原模式',
DATABASE_BACKUP_LSN  as 'DBL',
FIRST_LSN  as 'FLSN',
LAST_LSN as 'LSN',
DIFFERENTIAL_BASE_LSN as 'DiffLSN',
backup_start_date as 'BST', 
backup_finish_date as 'BET',
DATEDIFF(second, backup_start_date,backup_finish_date) as DurationSecond,
DATEDIFF(mi, backup_start_date,backup_finish_date) as Durationminute,
backup_size *0.000000001 as GB
FROM msdb.dbo.backupset 
WHERE DATABASE_NAME= '$dbname'
order by backup_finish_date desc 
"@  
$u=Invoke-Sqlcmd  -Query  $tsql_selectbackupset  -QueryTimeout  2400  -ServerInstance sp2013 

$u |ft -auto
}#function selectbackupset

function seledctT6 ([string] $dbname) {
  $tsql_selectT6=@"
  select createdate,* from dbo.t6 
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname -QueryTimeout  1800   -ServerInstance sp2013 
$y|ft -AutoSize
$y.count
}# selectT6
seledctT6 mingdb

function selectT6modtime ([string] $instance,[string] $dbname){
  $tsql_selectT6=@"
  select top 5 createdate,iid,rid,val,rstring from dbo.t6 order by createDate desc ,iid  desc
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname   -ServerInstance  $instance
$y|ft -AutoSize
$tsql_selectT6c=@"
  select count(rid)as cc from dbo.t6 
"@  
$m=Invoke-Sqlcmd  -Query  $tsql_selectT6c  -Database $dbname   -ServerInstance  $instance
$m.cc
}#function seledctT6modtime

function truncateT6 ([string] $dbname){
  $tsql_selectT6=@"
  truncate table  [dbo].[T6]
"@  
$y=Invoke-Sqlcmd  -Query  $tsql_selectT6  -Database $dbname    -ServerInstance sp2013 
$y
}#function truncateT6


#=================

$dbt='mingdb'
truncateT6 $dbt ;seledctT6 $dbt
seledctT6 $dbt

$t1=get-date
insertT6 mingdb 500000
$t2=get-date
$t2-$t1

# 
$t1=get-date
backupFBdatabase $dbt \\SP2013\temp
$t2=get-date
$t2-$t1

backupDiffdatabase mingdb \\SP2013\temp

selectbackupset $dbt  ;  selectbackupset FGRestoreTEST  
;GetbdlFile  H:\SQLServer\backups\ FGRestoreTEST '2015-05-14  23:00:00' -240 |ft -auto

selectT6modtime sp2013 mingdb
selectT6modtime sql2012x mingdb



<#
  1,0000   >  0M  8sec
 10,0000   >  1M 15 Sec  ; 1m18s
 50,0000 500K  >  7m 26s
100,0000 1M  >  16M 29 sec
#>
#case1
backupFBdatabase $dbt \\SP2013\temp
$fullb=GetbakFile \\SP2013\temp\   mingdb  '2015-05-04  23:59:59'  Getone    ;$fullb |select name, creationTime,lastwriteTime -first 2
   $fullbf=$fullb |select name -last 1
restoreFBdatabase sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-03_10-52-59.bak
truncateT6 $dbt ;seledctT6 $dbt
insertT6 mingdb 100
   selectT6modtime sp2013 mingdb
   selectT6modtime sql2012x mingdb
backupDiffdatabase mingdb \\SP2013\temp
   selectbackupset $dbt   

$d=GetdifFile \\SP2013\temp\   mingdb  '2015-05-04  22:05:00'  Getone    ;#$d |select name, creationTime,lastwriteTime -last 1

$d=GetdifFile \\SP2013\temp\ mingdb '5/4/2015 10:20:02 PM'  Getone    ;$d |select name, creationTime,lastwriteTime -last 1

$diff=$d |select name -last 1; $diff
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ $fullbf.name
                                                            
restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\  $diff.name
   selectT6modtime sp2013 mingdb
   selectT6modtime sql2012x mingdb


<#-----case2-----#>

restoreFBdatabase sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-03_10-58-38.bak
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ $fullbf.name

<#-----case3-----#>

GetbdlFile  \\SP2013\temp\ mingdb '2015-05-11  23:00:00' -240 |ft -auto #找出某天前24 所有備份記錄 (bak,dif,trn) ,copy LastWriteTime to GetbakFile

$fullb=GetbakFile \\SP2013\temp\   mingdb  '5/4/2015 12:04:50 AM'  Getone   # find GetbakFile 
   $fullbf=$fullb |select name  -First 2 ; $fullbf.name
$d=GetdifFile \\SP2013\temp\   mingdb  '5/4/2015 1:20:02 AM'  Getone ;$diff=$d |select name -last 1; $diff
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ $fullbf.name #進行bak復原
restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\  $diff.name #進行trn復原

selectT6modtime sp2013   mingdb
selectT6modtime sql2012x mingdb

<#-----case4-----#>
{<#
$dbt='mingdb'
$t1=get-date;$t1  ;truncateT6 $dbt ;seledctT6 $dbt
start-sleep 60
$t2=get-date;$t2  ;insertT6 mingdb 50
start-sleep 120
$t3=get-date;$t3
backupLog mingdb \\SP2013\temp
start-sleep 600
$t4=get-date;$t4
truncateT6 $dbt ;seledctT6 $dbt
start-sleep 120
$t5=get-date;$t5
insertT6 mingdb 100
   seledctT6modtime sp2013 mingdb
   seledctT6modtime sql2012x mingdb 

start-sleep 300
$t6=get-date ;'T6'+$t6.tostring() ;backupLog mingdb \\SP2013\temp

start-sleep 300
$t7=get-date ;'T7'+$t7.tostring() ;truncateT6 $dbt ;seledctT6 $dbt
start-sleep 30

$t8=get-date;'T8'+$t8.tostring()
insertT6 mingdb 300
   seledctT6modtime sp2013 mingdb
   seledctT6modtime sql2012x mingdb 

start-sleep 300
$t9=get-date;'T9'+$t9.tostring()
backupDiffdatabase mingdb \\SP2013\temp

start-sleep 300
$t10=get-date;'T10'+$t10.tostring()
truncateT6 $dbt ;seledctT6 $dbt
start-sleep 30
$t11=get-date;'T11'+$t11.tostring()
insertT6 mingdb 200
   seledctT6modtime sp2013 mingdb
   seledctT6modtime sql2012x mingdb 
start-sleep 300
$t12=get-date;'T12'+$t12.tostring()
backupLog mingdb \\SP2013\temp


#restore  to 300
GetbdlFile  \\SP2013\temp\ mingdb '2015-05-06  12:10:00' -240
restoreFBdatabaseNORECOVERY sql2012x mingdb  \\SP2013\temp\ mingdb_2015-05-04_00-02-11.bak #進行bak復原NORECOVERY
restoreDiffdatabase sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-06_11-05-55.dif        #進行dif復原RECOVERY
#restore  to 200
restoreFBdatabaseNORECOVERY   sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak #進行bak復原 NORECOVERY
$t2=get-date
restoreDiffdatabaseNORECOVERY sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-06_11-05-55.dif #進行dif復原 NORECOVERY
$t3=get-date;#t3-t2=32sec
restoreLOG   sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-06_11-16-26.trn  #進行trn復原 RECOVERY
$t4=get-date ;
#
$t2=get-date
restoreFBdatabase  sp2013 mingdb  \\SP2013\temp\  mingdb_2015-05-04_00-02-11.bak
$t3=get-date #1m 35Sec

selectbackupset $dbt   
#>}
<#-----case5-----#>
{<#
 當在備份期間內.如有大量的交易寫入,觀察是否

 原有500000,( mingdb_2015-05-04_00-02-11.bak)

step1: backupFBdatabase $dbt \\SP2013\temp 
step2:
DELETE FROM [dbo].[T6]
再新增 200000
step3:backupLog mingdb \\SP2013\temp
selectbackupset $dbt  

(1).T6.createdate  first , last   2015-05-06 14:27:00   ~ 2015-05-06 14:31:00
                   bak            5/6/2015    2:26:47 PM     5/6/2015 2:30:01 PM #194sec
                   trn            5/6/2015 2:49:07 PM  5/6/2015 2:49:27 PM   #20sec
(2). 將 bak restore to sql2012x
  GetbdlFile  \\SP2013\temp\ mingdb '2015-05-08  23:00:00' -240

  restoreFBdatabase  sql2012x  mingdb  \\SP2013\temp\ mingdb_2015-05-06_14-26-47.bak  # 2m22sec
(3)    
   GetbdlFile  \\SP2013\temp\ mingdb '2015-05-06  15:00:00' -24
 
 $t1=get-date
 restoreFBdatabaseNORECOVERY   sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-06_14-26-47.bak #進行bak復原 NORECOVERY  2m10sec
 $t2=get-date
 ($t2-$t1)

 $t3=get-date
 restoreLOG   sql2012x mingdb  \\SP2013\temp\  mingdb_2015-05-06_14-49-07.trn  #進行trn復原 RECOVERY   # 23sec
 $t4=get-date
 ($t4-$t3)


 (4)  

(99)
selectT6modtime sp2013   mingdb  
selectT6modtime sql2012x mingdb
selectbackupset $dbt  
#>}
#case6

##-----------TEST DATA end

#>}
$bak_d_1=189000022744500112
$bak_f_2=189000022782500001
$bak_l_4=190000007167100001

$trn_F_2=189000022782500001

$trn_D_3=190000007161300068
$trn_L_5=190000007184900001

$trn_L_5-$bak_l_4
$bak_l_4-$trn_D_3
$trn_D_3-$trn_F_2
$bak_f_2-$bak_d_1

$trn_L_5-$bak_l_4
$trn_L_5-$bak_l_4
















#---------------------------------------------------------------
# 24  2166  Recovery Paths 復原路徑
#---------------------------------------------------------------
# https://technet.microsoft.com/zh-tw/library/ms187486(v=sql.105).aspx

# 檢視備份與還原使用的 LSN

  RESTORE FILELISTONLY   FROM DISK = N'\\SP2013\temp\mingdb_FG1_2015-05-11_11-21-15.baf'


#---------------------------------------------------------------
# 25  2166   2200  Piecemeal Restore of Databases  分次還原
#---------------------------------------------------------------
#*****************************************************************
#  example [MyBigOrderDb]
#*****************************************************************
{<# MAY.13.2015 

<#   0  ---  
    考量能夠快速上線(當總有一天DB 移機, 雖有HA 也一樣會面臨)
	• Empty Primary FG. Primary Filegroup should be online in order for database to be online. It is good idea to keep primary filegroup empty and do not place any objects there.
	• Entities FG. This filegroup could store catalog tables, such as Customers, Articles and others.
	• One or more filegroups for the operational data. For example, if operational period is the current year, this filegroup can store Orders, OrderLineItems and related entities that stores current-year data.
	• One or more filegroups for the historical data. Those filegroups store data that is not required to support operational activity in the system.

create database [MyBigOrderDb]on primary(name = N'MyBigOrderDb', filename = N'c:\db\MyBigOrderDb.mdf'), filegroup [Entities] (name = N'MyBigOrderDB_Entities', filename = N'c:\db\MyBigOrderDB_Entities.ndf'), filegroup [FG2013] (name = N'MyBigOrderDB_FG2013', filename = N'c:\db\MyBigOrderDB_FG2013.ndf'), filegroup [FG2014] (name = N'MyBigOrderDB_FG2014', filename = N'c:\db\MyBigOrderDB_FG2014.ndf')log on(name = N'MyBigOrderDb_log', filename = N'c:\db\MyBigOrderDb_log.ldf')
create table dbo.Customers(    CustomerId int not null,    CustomerName nvarchar(64) not null,)on [Entities];
create table dbo.Articless( ArticlesId int not null, ArticleName nvarchar(64) not null,)on [Entities];
create partition function pfOrders(smalldatetime)as range rightfor values('2014-01-01');
create partition scheme psOrdersas partition pfOrdersto (FG2013,FG2014)go

create table dbo.Orders(    OrderId int not null,    OrderDate smalldatetime not null,    OrderNum varchar(32) not null,    constraint PK_Orders    primary key clustered(OrderDate, OrderId)    on psOrders(OrderDate))go
insert into dbo.Customers(CustomerId, CustomerName) values(1,'Customer 1');insert into dbo.Orders(OrderDate, OrderId, OrderNum)values    ('2013-01-01',1,'Order 1'),    ('2013-02-02',2,'Order 2'),    ('2014-01-01',3,'Order 3'),    ('2014-02-02',4,'Order 4')

#>}
<#   1  Full backup  --


backup database [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_Full.bak' with noformat, init, name = N'MyBigOrderDb-Full Database Backup',     compression, stats = 2
-- Differential backupbackup database [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_Diff.bak' with differential, noformat, init,     name = N'MyBigOrderDb-Differential Database Backup',     compression, stats = 2
-- Transaction logbackup log [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_Log.trn' with noformat, init, name = N'MyBigOrderDb-Tran Log',     compression, stats = 2

backup log [MyBigOrderDb] to disk = N'c:\db\MyBigOrderDb_TailLog.trn' with no_truncate, noformat, init, name = N'MyBigOrderDb-Tail Log',  compression, norecovery, stats = 2






 #>
<#   2  
 Restoring on another server -- 

-- 2   Restoring on another server   on sql2012x -- 
restore database [MyBigOrderDb]   FILEGROUP = 'primary', FILEGROUP = 'Entities', FILEGROUP = 'FG2014'from disk = N'C:\DB\MyBigOrderDb_Full.bak' with file = 1,move N'MyBigOrderDB' to N'c:\db\MyBigOrderDb.mdf', move N'MyBigOrderDB_Entities' to N'c:\db\MyBigOrderDb_Entities.ndf', move N'MyBigOrderDB_FG2014' to N'c:\db\MyBigOrderDb_2014.ndf', move N'MyBigOrderDb_log' to N'c:\db\MyBigOrderDb.ldf', NORECOVERY, partial, stats = 2;RESTORE FILELISTONLY  FROM Disk ='C:\DB\MyBigOrderDb_Full.bak'-- Diff Backuprestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Diff.bak' with file = 1,NORECOVERY, stats = 2;
-- Tran Logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Log.trn' with file = 1,NORECOVERY, stats = 2;
-- Tail-logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_TailLog.trn' with file = 1,NORECOVERY, stats = 2;
-- Recoveryrestore database [MyBigOrderDb] with RECOVERY;


use MyBigOrderDb
select * from dbo.Customers
select * from dbo.Articless
select * from dbo.Orders
select * from MyBigOrderDb.dbo.Customersselect * from MyBigOrderDb.dbo.Orders where OrderDate >= '2014-01-01'

#>
<#   3   --
-- Full Backup (restoring individual filegroup)restore database [MyBigOrderDb] FILEGROUP = 'FG2013'from disk = N'C:\DB\MyBigOrderDb_Full.bak' with file = 1,move N'MyBigOrderDB_FG2013' to N'c:\db\MyBigOrderDb_2013.ndf',  stats = 2;

-- Diff Backuprestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Diff.bak' with file = 1,stats = 2;

-- Tran Logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_Log.trn' with file = 1,stats = 2;

-- Tail-logrestore database [MyBigOrderDb] from disk = N'C:\DB\MyBigOrderDb_TailLog.trn' with file = 1,stats = 2;



 #>
 
#*****************************************************************
#  example[FGRestoreTEST]
#*****************************************************************
{<#/*  1  */drop database [FGRestoreTEST]CREATE DATABASE [FGRestoreTEST]
 ON  PRIMARY 
( NAME = N'FGRestoreTEST', FILENAME = N'h:\SQLServer\Data\FGRestoreTEST.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2010] 
( NAME = N'FG2010', FILENAME = N'h:\SQLServer\Data\FG2010.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2011] 
( NAME = N'FG2011', FILENAME = N'h:\SQLServer\Data\FG2011.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2012] 
( NAME = N'FG2012', FILENAME = N'h:\SQLServer\Data\FG2012.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2013] 
( NAME = N'FG2013', FILENAME = N'h:\SQLServer\Data\FG2013.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [FG2014] 
( NAME = N'FG2014', FILENAME = N'h:\SQLServer\Data\FG2014.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FGRestoreTEST_log', FILENAME = N'h:\SQLServer\Logs\FGRestoreTEST_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GOUSE [FGRestoreTEST];
GO

CREATE TABLE [PRIMARY_TABLE]
(ID INT,
 NAME CHAR(4)) ON [PRIMARY];

CREATE TABLE [FG2010_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2010];

 CREATE TABLE [FG2011_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2011];

CREATE TABLE [FG2012_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2012];

CREATE TABLE [FG2013_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2013];

CREATE TABLE [FG2014_TABLE]
(ID INT,
 NAME CHAR(4)) ON [FG2014];
 GO/*  2  */INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2010_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2011_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2012_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2013_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2014_TABLE]
SELECT 1, 'TEST'
GO 100/*  3  */USE [master];
GO
BACKUP DATABASE [FGRestoreTEST]
TO DISK = N'H:\SQLServer\Backups\FGRestoreTEST2.BAK';
GO/*  4   */BACKUP LOG [FGRestoreTEST]TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup.trn'WITH NORECOVERY

/*  5  */--http://msdn.microsoft.com/en-us/library/ms189906.aspx
BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY2.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2010'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20102.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2011'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20112.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2012'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20122.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2013'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_G20132.bak';

BACKUP DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2014'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak';
GO/*   6   */RESTORE DATABASE [FGRestoreTEST]   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST.bak'   WITH NORECOVERY;RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'PRIMARY'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY.bak'   WITH NORECOVERY;RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG2014.bak'   WITH NORECOVERY;
RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'PRIMARY'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF.bak'   WITH NORECOVERY;
/*   7  */

USE [FGRestoreTEST];
GO

INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
go 100

TRUNCATE TABLE [FG2014_TABLE];
GO

[PRIMARY_TABLE] 200 , 
[FG2014_TABLE] null
/*  8  */
BACKUP DATABASE [FGRestoreTest]
   FILEGROUP = 'PRIMARY'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF2.bak'
   WITH DIFFERENTIAL;

BACKUP DATABASE [FGRestoreTest]
   FILEGROUP = 'FG2014'
   TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   WITH DIFFERENTIAL;
GO


/*  9  */
USE [FGRestoreTEST];
GO

INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
go 100

INSERT INTO [FG2014_TABLE]
SELECT 1, 'NEW'
go 300

/*  10  */
USE [master];
go

BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn';
go
/*  11  */
BACKUP LOG [FGRestoreTEST_Dev]
TO DISK = 'C:\SQLServer\Backups\FGRestoreTest_TailLogBackup.trn'
WITH NORECOVERY;
GO
/*  12  */

BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup2.trn'
WITH NORECOVERY;
GO
/*  13.1  */

select count(*) from  FGRestoreTEST.dbo.PRIMARY_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2011_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2012_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2013_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2014_TABLEselect top (1) * from FGRestoreTEST.dbo.FG2014_TABLE

RESTORE DATABASE [FGRestoreTEST]
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST2.BAK'
   WITH replace , RECOVERY;

/*  13.2 */
BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup2.trn'
WITH NORECOVERY;

RESTORE DATABASE [FGRestoreTEST]
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST2.BAK'
   WITH  NORECOVERY;



RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY2.bak'
   WITH NORECOVERY;
--Restore FG2014 differential backupRESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak '   WITH NORECOVERY;
 --Restore PRIMARY differential backup
RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF2.bak'
   WITH NORECOVERY;

--Restore FG2014 differential backup
RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2014'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   WITH NORECOVERY;

RESTORE LOG [FGRestoreTEST]FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn'WITH NORECOVERY;
RESTORE DATABASE [FGRestoreTest] WITH RECOVERY;

/*  13.3  */
BACKUP LOG [FGRestoreTEST]
TO DISK = 'H:\SQLServer\Backups\FGRestoreTest_TailLogBackup2.trn'
WITH NORECOVERY;

select count(*) from  FGRestoreTEST.dbo.PRIMARY_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2011_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2012_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2013_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2014_TABLEselect top (1) * from FGRestoreTEST.dbo.FG2014_TABLE

RESTORE DATABASE [FGRestoreTEST]
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST2.BAK'
   WITH  NORECOVERY;



RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_PRIMARY2.bak'
   WITH NORECOVERY;
--Restore FG2014 differential backupRESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak '   WITH NORECOVERY;
 --Restore PRIMARY differential backup
RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_PRIMARYDIFF2.bak'
   WITH RECOVERY;

--Restore FG2014 differential backup
--RESTORE DATABASE [FGRestoreTEST]
   --FILEGROUP = 'FG2014'
   --FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   --WITH RECOVERY;

RESTORE LOG [FGRestoreTEST]FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn'WITH RECOVERY;
RESTORE DATABASE [FGRestoreTest] WITH RECOVERY;

/*  13.4  */
USE [FGRestoreTEST];
GO
TRUNCATE TABLE [FG2014_TABLE];

use master

RESTORE DATABASE [FGRestoreTEST]   FILEGROUP = 'FG2014'   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTEST_FG20142.bak '   WITH NORECOVERY;


RESTORE DATABASE [FGRestoreTEST]
   FILEGROUP = 'FG2014'
   FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_FG2014DIFF2.bak'
   WITH RECOVERY;


RESTORE LOG [FGRestoreTEST]FROM DISK = 'H:\SQLServer\Backups\FGRestoreTest_LogBackup2.trn'WITH RECOVERY;

RESTORE DATABASE [FGRestoreTest]     FILEGROUP = 'FG2014' WITH RECOVERY;

/*  15  */
--Then the transaction log backup:-
select count(*) from  FGRestoreTEST.dbo.PRIMARY_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2011_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2012_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2013_TABLEselect count(*) from  FGRestoreTEST.dbo.FG2014_TABLEselect top (1) * from FGRestoreTEST.dbo.FG2014_TABLEuse FGRestoreTESTselect * from sys.master_filesThe file or filegroup "FG2014" is not in a valid state for the "Recover Data Only" option to be used.
 Only secondary files in the OFFLINE or RECOVERY_PENDING state can be processed.
Msg 3013, Level 16, State 1, Line 1

#>}

