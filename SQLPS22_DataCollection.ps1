<#-----------------------------------
#  performance  SQLPS22_DataCollection.ps1

\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\SQLPS22_DataCollection.ps1

CreateDate:  Jun.08.2014
LastDate :  

#author: a0921887912@gmail.com

onsql.mm ->   http://msdn.microsoft.com/en-us/library/bb677179.aspx
Get
New create,
set =configure = update
Delete
Enable,disable
start,stop
#>



















#--------------------------------------------
# 1    collection_sets   with TSQL
#--------------------------------------------
'
Data Collector Views (Transact-SQL)  count:7
    syscollector_collection_items (Transact-SQL)
    syscollector_collection_sets (Transact-SQL)
    syscollector_collector_types (Transact-SQL)
    syscollector_config_store (Transact-SQL)
    syscollector_execution_log (Transact-SQL)
    syscollector_execution_log_full (Transact-SQL)
    syscollector_execution_stats (Transact-SQL)

Data Collector Stored Procedures (Transact-SQL) :count:20
sp_syscollector_  
                 Collection_item (create, delete ,update
                 Collection_set  (create ,delete ,Update ,start, stop , run ,upload 
                 Collection_type (create ,delete ,update
                 cache_window (set
                 Warehouse_database_name (set
                 warehouse_instance_name  (set 
                 execution_log_tree (delete
                 Collector ( enable, disable .

'

## Get
use msdb

select * from syscollector_collection_sets


Collector ( enable, disable 

## start , Stop   
use msdb
EXEC sp_syscollector_start_collection_set @collection_set_id = 1;
EXEC sp_syscollector_stop_collection_set @collection_set_id = 2



#--------------------------------------------
# 2    collector 
#--------------------------------------------

## get

select * from syscollector_execution_log
select * from syscollector_execution_log


##  enable  ,disable
exec dbo.sp_syscollector_enable_collector
exec dbo.sp_syscollector_disable_collector

## start , stop

USE msdb;  GO  EXEC dbo.sp_syscollector_enable_collector ; EXEC dbo.sp_syscollector_disable_collector;





#--------------------------------------------
# 1    Enumerating the counter groups
#--------------------------------------------


#--------------------------------------------
# 1    Enumerating the counter groups
#--------------------------------------------