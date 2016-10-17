#--------------------------------------------------------
#如何管理遺失索引與維護索引的最佳數量
#--------------------------------------------------------



http://caryhsu.blogspot.tw/2012/12/blog-post.html

找出未使用的索引(Index)：
SELECT OBJECT_SCHEMA_NAME(I.OBJECT_ID) AS SchemaName,
       OBJECT_NAME(I.OBJECT_ID) AS ObjectName,
       I.NAME AS IndexName
FROM sys.indexes I
WHERE
-- only get indexes for user created tables
OBJECTPROPERTY(I.OBJECT_ID, 'IsUserTable') = 1
-- find all indexes that exists but are NOT used
AND NOT EXISTS ( 
SELECT index_id 
FROM sys.dm_db_index_usage_stats
WHERE OBJECT_ID = I.OBJECT_ID 
               AND I.index_id = index_id 
               -- limit our query only for the current db
               AND database_id = DB_ID()) 
ORDER BY SchemaName, ObjectName, IndexName

找出較不常使用的索引(Indexes)：
declare @dbid int
select @dbid = db_id()

select objectname=object_name(s.object_id), s.object_id,
          indexname=i.name, i.index_id,
          user_seeks, user_scans, user_lookups, user_updates
from sys.dm_db_index_usage_stats s, sys.indexes i
where database_id = @dbid and
      objectproperty(s.object_id,'IsUserTable') = 1
      and i.object_id = s.object_id
      and i.index_id = s.index_id
order by (user_seeks + user_scans + user_lookups + user_updates) asc



#--------------------------------------------------------
#索引分析與維護建議
#--------------------------------------------------------


索引分析與維護建議
http://caryhsu.blogspot.tw/2012/02/blog-post_14.html

效能調整 - 填滿因數對資料庫的影響
http://caryhsu.blogspot.tw/2012/02/blog-post.html
#--------------------------------------------------------
#
#--------------------------------------------------------
SQL Server 上大型資料表的索引效能調整與維護
http://caryhsu.blogspot.tw/2011/08/sql-server.html


#--------------------------------------------------------
#
#--------------------------------------------------------


#--------------------------------------------------------
#
#--------------------------------------------------------


#--------------------------------------------------------
#
#--------------------------------------------------------


#--------------------------------------------------------
#
#--------------------------------------------------------

#--------------------------------------------------------
#
#--------------------------------------------------------