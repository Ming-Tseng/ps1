#########################################
####   參數定義                      ####
#########################################
$date01=get-date -Format yyyyMMdd
$date02=get-date -Format HHmm
$workpath="E:\PowerShell-cron\pc-perf-output\"+$date01
$dbserver=$env:computername
$dbserverIP="N`"10.12.2.14`","
$dbname="judgem3"
$tableName="tbl_perf"
$pad="a1234567@"
$dr = ","
$dr01="`""
#$field_name="servername00,datetime_create,porcessor_total,memory_committed,memory_commit_limit"
$field_name="datetime_create,porcessor_total,memory_committed,memory_commit_limit"
$TSQL_I1 ="INSERT INTO "+ $tableName+" (" +$field_name+") values "

USE [judgem3]
GO

/****** Object:  Table [dbo].[tbl_perf]    Script Date: 2016/9/22 上午 11:32:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_perf](
	[servername00]    [nvarchar](50) NULL,
	[datetime_create] [nvarchar](100) NULL,
	[porcessor_total] [nvarchar](100) NULL,
	[memory_committed] [nvarchar](100) NULL,
	[memory_commit_limit] [nvarchar](100) NULL
) ON [PRIMARY]

GO




#########################################
####   參數驗證                      ####
#########################################
$date01
$date02
$workpath
$dbserver
$dbname
$pad="a1234567@"

#$t=gc $fullpathD
$dr = ","
$t=gc E:\PowerShell-cron\pc-perf-output\20160922\14-20160922-6.csv
 if (($t.count) -ne 1 )
 {
 <#  讀取列名，本處不用
            {#401            
  #          $sr0=""
    #        $tsplit=$t[0].Split($dr) # 讀取第一列欄位名稱
      #      $tsplit=$tsplit.Split($dr01)
  #          for ($i = 0; $i -lt $tsplit.count; $i=$i+2)
  #          {  $sr0=$sr0+'['+$tsplit[$i]+'],'  }
   #         $sr0=$sr0.Substring(0,$sr0.Length-1);#$sr1
 #>         
            for ($k = 1; $k -lt $t.count ; $k++) # 讀取列並寫入Table
            { #387 讀取列並寫入Table
            $tsplit=$t[$k].Split($dr);$sr=""
<#            
            for ($i = 0; $i -lt $tsplit.count; $i=$i+1)
           { $sr=$sr+'N'+$tsplit[$i]+','}
            $sr=$sr.Substring(0,$sr.Length-1);#$sr
            $sr='('+$sr+')';#$sr
            $TSQL_Insert=$TSQL_I1+$sr; #$TSQL_Insert
            }
   #>
     
      for ($i = 0; $i -lt $tsplit.count; $i=$i+1)
           { $sr=$sr+$tsplit[$i]+','}
            $sr=$sr.Substring(0,$sr.Length-1);#$sr
            $sr='('+$sr+')';#$sr
            $TSQL_Insert=$TSQL_I1+$sr; #$TSQL_Insert
            }
          $TSQL_Insert = "INSERT INTO tbl_perf (datetime_create,porcessor_total,memory_committed,memory_commit_limit) values (09/22/2016000:000,0.0042431532821907147,55217229824,77809864704)"
           Invoke-Sqlcmd -ServerInstance 10.12.2.14 -Database $dbname -Query $TSQL_Insert -Username  sa -Password tao_m3_789
  }

  
  #INSERT INTO tbl_perf (datetime_create,porcessor_total,memory_committed,memory_commit_limi
#t) values ("09/22/2016 06:00:14.749","0.0042431532821907147","55217229824","77809864704")
  

#$tsql_import_tbl_perf="BULK INSERT  judgem3.dbo.v_tbl_perf FROM "+$workpath+"\"+$date01+"1.csv" 
#$tsql_import_tbl_perf

#I#nvoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_import_tbl_perf -Username judgem3user -Password $pad


#$#tsql_count_tbl_perf=@"
 #   select count(*) from tbl_perf
#"@

#Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_count_tbl_perf -Username judgem3user -Password $pad



  





<#
#########################################
#取得安裝記憶體
#########################################
$cs = Get-WmiObject -class Win32_ComputerSystem 
$total_mem = $cs.TotalPhysicalMemory
#>

#########################################
####   計算磁碟空間                  ####
####   只要統計1次                   ####
#########################################
<#
$strComputer = "." 
$Disks = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3"`
 -ComputerName $strComputer 
foreach ($Disk in $Disks) 
{ 
 
$ID = "磁碟機代碼：{0}" -f $Disk.DeviceID 
$Label = "磁碟機名稱：{0}" -f $Disk.VolumeName 
$Size = "磁碟機大小：{0:0.0} GB" -f ($Disk.Size / 1GB) 
$FreeSpace = "剩餘的空間：{0:0.0} GB" -f ($Disk.FreeSpace / 1GB) 
$Used = ([int64]$Disk.size - [int64]$Disk.FreeSpace) 
$SpaceUsed = "已用的空間：{0:0.0} GB" -f ($Used / 1GB) 
$Percent = ($Used * 100.0)/$Disk.Size 
$Percent = "已用的比例：{0:N0}" -f $Percent 
"---------------------" 
"$ID" 
"$Label" 
"$Size" 
"$FreeSpace" 
"$SpaceUsed" 
"$Percent %"
}
#>