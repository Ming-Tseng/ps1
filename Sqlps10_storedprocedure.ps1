<#  Sqlps10_storedprocedure
 auther : ming_tseng    a0921887912@gmail.com createData : Mar.08.2014 history :  object :  System Stored Procedures  http://technet.microsoft.com/en-us/library/ms187961.aspx#>

#---------------------------------------------------------------
#   CREATE PROCEDURE
#---------------------------------------------------------------

sp_configure 'Show Advanced Options', 1
GO
RECONFIGURE
GO
sp_configure 'Ad Hoc Distributed Queries', 1
GO
RECONFIGURE
GOSELECT * INTO #TestTableT FROM OPENROWSET('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;','EXEC  sp_')


#---------------------------------------------------------------
#   CREATE PROCEDURE
#---------------------------------------------------------------

CREATE TABLE dbo.MyFamily(ID INT IDENTITY(1,1),Name VARCHAR(50))INSERT INTO dbo.MyFamily(Name)VALUES('Ming'),('Vera'),('Vanessa'),('En')goselect * from dbo.MyFamilyCREATE PROCEDURE dbo.MyFamilyASBEGINSELECT * FROM dbo.MyFamily WITH(NOLOCK)ENDGO

#---------------------------------------------------------------
#    get PROCEDURE  Text
#---------------------------------------------------------------
## --
select * from sys.objects  where type='P'

sp_helptext sp_who
##- 
use msdbSELECT o.name,m.definition  FROM 
sys.sql_modules m
join sys.objects o on o.object_id=m.object_id

#---------------------------------------------------------------
#   Search Text in Stored Procedure in SQL
#---------------------------------------------------------------
SELECT DISTINCT o.name AS Object_Name,o.type_desc
FROM sys.sql_modules m 
INNER JOIN sys.objects o 
ON m.object_id=o.object_id
WHERE m.definition Like '%[ABD]%'
WHERE m.definition Like '%\[ABD\]%' ESCAPE '\'
