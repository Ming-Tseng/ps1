
<#
C:\Users\Administrator\Documents\migratetotraffic103.ps1




#>

#Get-ExecutionPolicy
#Set-ExecutionPolicy remotesigned
if  ( !(Get-Module  sqlps) ) {   Import-Module sqlps -DisableNameChecking }


vil_traffic_rule10312_def

TAOM2


  F:\TAOM2_DB\source\20141215(完整)\

  vil_traffic_rule,15975125,penalty,15975125,1970-01-01,2014-12-14      1597W
  select count    15975125

  ii  F:\TAOM2_DB\source\20141216\vil_traffic_rule.H
  
  notepad   F:\TAOM2_DB\source\20141216\vil_traffic_rule.H     #  vil_traffic_rule,13153,penalty,13153,2014-12-15,2014-12-15
  notepad   F:\TAOM2_DB\source\20141216\vil_migrate.H           #  vil_migrate,219,plate_no,219,2014-12-15,2014-12-15


  vil_migrate

  notepad   F:\TAOM2_DB\source\20150101\vil_traffic_rule.H     #  vil_traffic_rule,16654,penalty,16654,2014-12-31,2014-12-31
  notepad   F:\TAOM2_DB\source\20150101\vil_migrate.H           #  vil_migrate,219,plate_no,219,2014-12-15,2014-12-15



20141216
20150101


#-----------------------------------------------------------------------
#    vil_traffic_rule10312_def. index
#-----------------------------------------------------------------------
{<#

USE [TAOM2]
GO

/****** Object:  Index [tkt-plt-Index-20160921]    Script Date: 2016/9/21 上午 08:46:31 ******/
CREATE CLUSTERED INDEX [tkt-plt-Index-20160921] ON [dbo].[vil_traffic_rule10312_def]
(
	[vil_ticket] ASC,
	[plate_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

create index spend 21m06s
#>}

#-----------------------------------------------------------------------
#      create table vil_migrate  
#-----------------------------------------------------------------------
{<#


USE [TAOM2]
GO

/****** Object:  Table [dbo].[vil_migrate]    Script Date: 2016/9/21 上午 08:48:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[vil_migrate](
	[plate_no] [nchar](15) NOT NULL,
	[car_kind_no] [nchar](4) NULL,
	[vehicle_kind_no] [nchar](1) NULL,
	[vil_ticket] [nchar](11) NOT NULL,
	[punish_id] [nchar](10) NULL,
	[rule1_no] [int] NULL,
	[rule2_no] [int] NULL,
	[accuse_no] [nchar](4) NULL,
	[old_dmv] [nchar](2) NULL,
	[close_no] [nchar](2) NULL,
	[hold] [nchar](3) NULL,
	[new_accuse_no] [nchar](4) NULL,
	[new_dmv] [nchar](2) NULL,
	[migrate_reason] [nchar](2) NULL,
	[migrate_doc] [nchar](50) NULL,
	[migrate_date] [date] NULL,
	[update_uid] [nchar](20) NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO

#>}
#-----------------------------------------------------------------------
#     main ()
#-----------------------------------------------------------------------
#{<#
#$tlogfile="F:\TAOM2_DB\source\"+$fn_+"trffic.txt"  #  ii $ilogfile  ,   ri  $ilogfile
#$mlogfile="F:\TAOM2_DB\source\"+$fn_+"migrate.txt"  #  ii $ilogfile  ,   ri  $ilogfile

$fs=gci  F:\TAOM2_DB\source
$fs | ? name -ne '20141215(完整)'

#foreach ($fn in $fs)
#{  #  120
#$fn=$fn.Name

#    000---------------------------------------
$fn='20141217'

if  ( !(Get-Module  sqlps) ) {   Import-Module sqlps -DisableNameChecking }
$dbserver=$env:COMPUTERNAME
$dbname ="TAOM2"
$dr="@#"
$tableName='vil_traffic_rule10312_def'
    
$tlogfile ="F:\TAOM2_DB\source\"+$fn+"_trffic.txt"  #  ii $ilogfile  ,   ri  $ilogfile
$mlogfile="F:\TAOM2_DB\source\"+$fn+"_migrate.txt"  #  ii $ilogfile  ,   ri  $ilogfile

#    111---------------------------------------
$t1=get-date;
$fullpathD="F:\TAOM2_DB\source\$fn\vil_traffic_rule.D"
$t=gc $fullpathD    -Encoding UTF8 # 讀取檔案 放入$t 
$y=$t.count;
            #$sr0=""
            #$tsplit=$t[0].Split($dr) # 讀取第一列欄位名稱
            #for ($i = 0; $i -lt $tsplit.count; $i=$i+2)
            #{  $sr0=$sr0+'['+$tsplit[$i]+'],'  }
            #$sr0=$sr0.Substring(0,$sr0.Length-1); #$sr0$t
            #$TSQL_I1 ="INSERT INTO "+ $tableName+" (" +$sr0 +") values " 
            $TSQL_I1 ="INSERT INTO "+ $tableName+" values " 

 for ($k = 1; $k -lt $t.count ; $k++) # 讀取列並寫入Table
 { #123
 $y;$y=$y-1
 $tsplit=$t[$k].Split($dr) # 讀取第一列欄位名稱
 $fvil_ticket= $tsplit[0]   ; # $fvil_ticket
 $fplate_no= $tsplit[4 ]   ; # $fplate_no 
 $tql_select="select count(vil_ticket) as [cxt] from [dbo].[vil_traffic_rule10312_def] where vil_ticket='$fvil_ticket' and    plate_no='$fplate_no'"
 $tql_delete="delete from  [dbo].[vil_traffic_rule10312_def] where vil_ticket='$fvil_ticket' and    plate_no='$fplate_no'"
          $sr="" 
         for ($i = 0; $i -lt $tsplit.count; $i=$i+2)   { $sr=$sr+'N'''+$tsplit[$i]+''','}
               $sr=$sr.Substring(0,$sr.Length-1);#$sr
               $sr='('+$sr+')';#$sr
               $TSQL_Insert=$TSQL_I1+$sr; # $TSQL_Insert
           
 if (   (Invoke-Sqlcmd -Query $tql_select -ServerInstance $dbserver  -Database $dbname  ).cxt -eq 0)
 {# add new
  Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $TSQL_Insert 
 "ADD           -      $fvil_ticket    $fplate_no    "  |out-file $tlogfile  -Append 

 }
 else
 {
   # delete
  Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tql_delete  
  Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $TSQL_Insert
 "Update      -      $fvil_ticket    $fplate_no    "  |out-file $tlogfile  -Append
   }
 
 }   #123
$t2=get-date;  '        total procedue time   Minute       '+($t2-$t1).TotalMinutes| out-file   $tlogfile -Append 

#    222---------------------------------------
$t1=get-date

$fullpathD="F:\TAOM2_DB\source\$fn\vil_migrate.D" ; #notepad  $fullpathD
 $v=gc $fullpathD    -Encoding UTF8 # 讀取檔案 放入$t 
$y=$v.count;

 for ($k = 1; $k -lt $v.count ; $k++) # 讀取列並寫入Table
 { #177
 $y;$y=$y-1

$tsplit=$v[$k].Split($dr) # 讀取第一列欄位名稱
$fvil_ticket= $tsplit[6]  ; #  $fvil_ticket
$fplate_no= $tsplit[0 ]   ;  #$fplate_no
$fnew_dmv=$tsplit[24] ; #$fnew_dmv 
$fclose_no=$tsplit[18]  ; #$fclose_no
$fmigrate_date=$tsplit[30] ; # $fmigrate_date
$fupdate_uid  =$tsplit[32] ;  #$fupdate_uid

$tql_select="select count(vil_ticket) as [cxt] from [dbo].[vil_traffic_rule10312_def] where vil_ticket='$fvil_ticket' and    plate_no='$fplate_no'"
 #$tql_delete="delete from  [dbo].[vil_traffic_rule10312_def] where vil_ticket='$fvil_ticket' and    plate_no='$fplate_no'"
    #      $sr="" 
    #     for ($i = 0; $i -lt $tsplit.count; $i=$i+2)   { $sr=$sr+'N'''+$tsplit[$i]+''','}
    #           $sr=$sr.Substring(0,$sr.Length-1);#$sr
    #           $sr='('+$sr+')';#$sr
    #           $TSQL_Insert=$TSQL_I1+$sr; # $TSQL_Insert

$tsql_update4=@"
UPDATE [dbo].[vil_traffic_rule10312_def]
   SET  [adj_no] = N' $fnew_dmv'
      ,[close_no] = N'$fclose_no'
      ,[up_date] = N'$fmigrate_date'
      ,[update_uid] = N'$fupdate_uid'
 WHERE   vil_ticket='$fvil_ticket' and    plate_no='$fplate_no'
GO
"@

$tsql_update3=@"
UPDATE [dbo].[vil_traffic_rule10312_def]
   SET  [close_no] = N'$fclose_no'
      ,[up_date] = N'$fmigrate_date'
      ,[update_uid] = N'$fupdate_uid'
 WHERE   vil_ticket='$fvil_ticket' and    plate_no='$fplate_no'
GO
"@

           
 if (   (Invoke-Sqlcmd -Query $tql_select -ServerInstance $dbserver  -Database $dbname  ).cxt -eq 1)
 {# add new
#    'update ' 
    
    if (  ($fnew_dmv.Length) -ne 0  )
    {
  Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_update4 #-Username  sa -Password $pad
 "Update 4    -      $fvil_ticket    $fplate_no   $fnew_dmv   $fclose_no  $fmigrate_date    $fupdate_uid   "  |out-file $mlogfile  -Append
    }
    else
    {
  Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_update3
 "Update 3    -      $fvil_ticket    $fplate_no   $fnew_dmv   $fclose_no  $fmigrate_date    $fupdate_uid   "  |out-file $mlogfile  -Append
    }
 }
 else
 {
  #'log to file '
 "NotFound -      $fvil_ticket    $fplate_no    "  |out-file $mlogfile  -Append
   
     # delete
  #Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tql_delete  
   # add new 
  #Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $TSQL_Insert
 }
 }   #177

$t2=get-date;  '        total procedue time    Min    '+($t2-$t1).TotalMinutes| out-file   $mlogfile -Append 

#    222---------------------------------------





#}  #120
#>}



#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
{<#

#>}



#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
{<#

#>}




#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
{<#

#>}



#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
{<#

#>}



#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
{<#

#>}
