<#
程式路徑名稱  : E:\everyday-cron\everyQuarterly.ps1
程式功能     : 每季統計 34File 匯入TAODW_CSQ 
程式流程說明  : 將 
排程名稱     :
開發程式路徑名稱 C:\Users\administrator.CSD\OneDrive\download\PS1\EX17_TPTAO_everyQuarterly.ps1  host:33 ,user:infra1

程式路徑        F0=  E:\everyday-cron
匯入檔來源路徑   F1=  ii D:\olapdb
匯入檔工作路徑   F2=  ii D:\M3_Data\FACT\                   vil_adm_remedy_log.D
匯入檔備份路徑   F3=  E:\every-day-vil\yyyyMMdd(完整) ;      ii  E:\every-day-vil\
DSTX 程式路徑   FW=  D:\M3_SSIS\tao_q\tao_q\
相關資源路徑名稱  powershell_ise   E:\everyday-cron\EX1701_SQLScript.ps1

程式建立日期 :  MAY.23.2016
最後異動日期 :  MAY.31.2016
Author : ming_tseng@syscom.com.tw

測試用語法
ssms
cp   "E:\every-day-vil\20160526(完整)\vil_adm_remedy_log.D"    "D:\M3_Data\FACT\"  
ii   'E:\every-day-vil\20160526(完整)\vil_query_log.h'

vil_plate_susp_his
vil_query_log

ii E:\everyday-cron\importLogError.txt

vil_adj_traffic
vil_adm_remedy_log
vil_car_susp_his
vil_div_detail
vil_migrate
vil_motor_susp_his
vil_phone_xact
vil_query_log
vil_receipt_payment
vil_traffic_rule

vil_adj_traffic_q
vil_adm_remedy_log_q
vil_car_susp_his_q
vil_div_detail_q
vil_migrate_q
vil_motor_susp_his_q
vil_phone_xact_q
vil_plate_susp_his_q
vil_query_log_q
vil_receipt_payment_q
vil_traffic_rule_q

#>

#   54    參數設定 parameter  & configure
#   71    常用函數 function
#   134   copy   F1 to F2
#   179   copy   F1 to F3
#   203   使用Powershell 匯入 import  main  use Powershell
#   308   使用Powershell 匯入import  main  use dtsx
#   356   擷取資料庫筆數 DB  check 
#   364   比對匯入檔案筆數與資料庫筆數 compart  file count & Table count 


#-----------------------------------
#   54   參數設定  parameter  & configure
#-----------------------------------
$dbserver=$env:COMPUTERNAME  #匯入目的地主機
$dbname ="TAODW_CSQ"         #匯入目的地資料庫
$dr="@#"                     #分隔符號

$dt= get-date -Format yyyy-MM-dd
$dtcopy= get-date -Format yyyyMMdd
$pad="p@ssw0rds"
$F0= "E:\everyday-cron"  ;#$F0= "D:\everyday-cron"  mkdir $F0
$f1="D:\olapdb"          #$F0= "D:\everyday-cron"  mkdir $F0  ii $f1
$f2="D:\M3_Data\FACT\"
$f3="E:\every-day-vil"
$dlogfile= $F0+'\importLogError.txt'  ##dtsx 錯誤記錄檔
$ilogfile=$F0+'\importLog.txt'        ##ps1記錄檔

if  ( !(Get-Module  sqlps) ) {   Import-Module sqlps -DisableNameChecking }
#-----------------------------------
#   71  function
#-----------------------------------
function truncateall ()
{
    $TableListS=Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query "select name from sys.tables  where name <> 'ztranslog' "  -Username  sa  -Password $pad
foreach ($TableList in $TableListS){
   $tsql_truncate="truncate table "+$TableList.name
   Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_truncate -Username  sa  -Password $pad
  # $tsql_truncate
}
}
function Loginitial ($dt,$tablename)
{
# Loginitial 2016-05-25 vil_vehicle_kind_code
# $tablename="vil_vehicle_kind_code"
# $dt="2016-05-25"
 $tsql_Loginitial=" insert into [dbo].[ztranslog] ([importDT],[Tablename],[checkflag],[modifydt]) values ('$dt','$tablename',N'50Start',getdate())"

 Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_Loginitial -Username  sa -Password $pad
    
}
function Logupdate ( $dt ,$tablename, $colname , $colvalue)
{
 # Logupdate 2016-05-25 vil_vehicle_kind_code checkflag 02
# $tablename="vil_vehicle_kind_code"
# $dt="2016-05-25"
 $tsql_Logupdate=@"
 UPDATE [dbo].[ztranslog] SET $colname = '$colvalue' ,[modifydt]= getdate()
 where [importDT]='$dt' and  [Tablename]='$tablename'
"@
#$tsql_Logupdate
Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_Logupdate -Username  sa -Password $pad 
  
}
function checkLog ( $dt)
{
 # Logupdate 2016-05-25 vil_vehicle_kind_code checkflag 02
# $tablename="vil_vehicle_kind_code"
# $dt="2016-05-25"
 $checkLog=@"
SELECT * FROM [TAODW_CSQ].[dbo].[ztranslog]
  where importDT ='$dt'
"@
#$tsql_Logupdate
Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $checkLog -Username  sa -Password $pad 

}

function  countsum ( $tablename)
{
 # Logupdate 2016-05-25 vil_vehicle_kind_code checkflag 02
# $tablename="vil_vehicle_kind_code"
# $dt="2016-05-25"
 $tsql_countsum=@"
SELECT   count(*) as csum FROM [TAODW_CSQ].[dbo].$tablename
"@
#$tsql_Logupdate
$colvalue=Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $tsql_countsum -Username  sa -Password $pad 
Logupdate   $dt  $tablename  countSum   $colvalue.csum
}

function checkFileintegrity ()
{
   "--------------------------------------------------" | out-file $ilogfile -append 
  (get-date -Format yyyy-MM-dd-hh:mm:ss).tostring() + " 程式執行" | out-file $ilogfile -append
 $tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
where name <> 'ztranslog'
Go
"@
   
  
  $TableListL1=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad ;$fi='0' #準備Table名稱
foreach ($TableList in $TableListL1){
         $tableName=$TableList.name;#取得表格名稱

         switch ($tableName)
           {  'm3_vil_div'         {   $tableName="vil_div"   }
              'm3_vil_div_his'     {  $tableName="vil_div_his"   }}

         $fullpathD=$f1+'\'+$tableName+'.D' #取得資料檔案名稱
         $fullpathH=$f1+'\'+$tableName+'.H' #取得說明檔案名稱
    if (  (test-path $fullpathD ) -and ( test-path $fullpathH  )  ) {        
       #  資料檔案  說明檔案 是否存在
       $t =gc $fullpathD ;#$t.count ii $fullpathD
       $hf=gc $fullpathH;$p1=$hf.indexof(',');#$hf;$p1
       $p2=($hf.Substring($p1+1,$hf.Length-($p1+1))).indexof(',');#$p2
       #$hf;(($t.count)-1);$hf.Substring($p1+1,$p2)
       if ( (($t.count)-1) -ne $hf.Substring($p1+1,$p2) )
       {  (get-date -Format yyyy-mm-dd).tostring() + "  $tableName   匯入筆數不符+++++++++" | out-file $ilogfile -append
       }
     }
     else
     {   #資料檔案  說明檔案 不存在
         (get-date -Format yyyy-mm-dd).tostring() + "  $tableName    檔案不存在或不符" | out-file $ilogfile -append
         $fi='1'   
     }
    #  ii $ilogfile  ri  $ilogfile
}

return $fi


}

#-----------------------------------
#   111    files is ready 
#-----------------------------------

$r=checkFileintegrity

if ($r  -eq  '0' )  #檔案數與筆數是否相同  $r=0
{  # if 457
    

#-----------------------------------
#   134   copy   F1 to F2
#-----------------------------------
#  將34 檔案 copy 至工作路徑
$tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
where name <> 'ztranslog'
Go
"@

$TableListSA=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad ;$fi='0'
#$TableListSA.Count
#$t1=get-date
foreach ($TableList in $TableListSA){
         $tableName=$TableList.name;
             switch ($tableName)
           {  'm3_vil_div'         {  $tableName="vil_div"   }
              'm3_vil_div_his'     {  $tableName="vil_div_his"   }}


          $fullpathD=$f1+'\'+$tableName+'.D' 
          $fullpathH=$f1+'\'+$tableName+'.H'
    if (  (test-path $fullpathD ) -and ( test-path $fullpathH  )  ) {          $fi='1'   }
    if ( $fi -eq '1' ){  
          cp   "D:\olapdb\$tableName.D"  "$f2\$tableName.D" -Force  
          cp   "D:\olapdb\$tableName.H"  "$f2\$tableName.H" -Force  
      }
}
#$t2=get-date;#($t2-$t1)  #--41 sec
{<#
#ii  D:\olapdb ;  ii $f2   ri 
#cp   "E:\every-day-vil\20160526(完整)\vil_adm_remedy_log.D"    "D:\olapdb"  
#cp   "E:\every-day-vil\20160526(完整)\vil_adm_remedy_log.H"    "D:\olapdb"  


foreach ($TableList in $TableListSA){
         $tableName=$TableList.name;
          switch ($tableName)
    {  'm3_vil_div'         {   $tableName="vil_div"   }
        'm3_vil_div_his' {  $tableName="vil_div_his"   }}
          cp   "E:\every-day-vil\20160526(完整)\$tableName.D"  "D:\olapdb\$tableName.D" -Force  
          cp   "E:\every-day-vil\20160526(完整)\$tableName.H"  "D:\olapdb\$tableName.H" -Force  
}
#>}

#-----------------------------------
#   179   copy   F1 to F3
#-----------------------------------
#  將所有檔案  copy 至 備份路徑
$fpath="$f3\$dtcopy(完整)"  # ii 
if (   !( test-path $fpath )   )
{    mkdir  $fpath    ;# rm  "$f2\$dtcopy(完整)"
}

if ( $fi -eq '0' ){    cp  D:\olapdb\*.*  "$f3\$dtcopy(完整)" -Force    }

#-----------------------------------
#   203   import  main  use Powershell
#-----------------------------------

truncateall  #清除所有table內容

$fpath=$f2

$tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
--where name <> 'ztranslog'
--where name   in ('m3_vil_div','m3_vil_div_his','vil_accuse_no_code' )
where name  not in ('ztranslog','vil_adj_traffic','vil_adm_remedy_log','vil_car_susp_his','vil_div_detail','vil_migrate','vil_motor_susp_his','vil_phone_xact','vil_plate_susp_his','vil_query_log','vil_receipt_payment','vil_traffic_rule' )
Go
"@  # 排除使用 dtsx 的table
$TableListS=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad
#$TableListS.count
foreach ($TableList in $TableListS)
{ # 346 foreach one
#}#---

    $tableName=$TableList.name;#$tableName
    Loginitial $dt  $tableName  # 新增匯入記錄
    
    #由於匯入檔案名與 表格名不一致 ,需進行轉換
    switch ($tableName)
    {   'm3_vil_div'     {  $tableName="vil_div"   }
        'm3_vil_div_his' {  $tableName="vil_div_his"   }}
    #設定要匯入完整檔案路徑
    $fullpathD=$fpath+'\'+$tableName+'.D'  #$fullpathD
    $fullpathH=$fpath+'\'+$tableName+'.H'
    
    if ((test-path $fullpathD ) -and ( test-path $fullpathH  ) ) #檢查工作路徑是否已經有檔案
    { #350 if 檢查是否已經有檔案
      #$tableName +  '- ready' 
        
        $t1=get-date;
        $t=gc $fullpathD    -Encoding UTF8 # 讀取檔案 放入$t

         switch ($tableName)
        {  'vil_div'         {   $tableName="m3_vil_div"   }
           'vil_div_his'     {   $tableName="m3_vil_div_his"   }}
        
                      
        Logupdate $dt $tableName checkflag '118.GetFileFinished' #更新匯入記錄

        # 取出說明檔案所標記筆數值
        $hf=gc $fullpathH;$p1=$hf.indexof(',');#$hf;$p1
        $p2=($hf.Substring($p1+1,$hf.Length-($p1+1))).indexof(',');#$p2
        
            if ($hf.Substring($p1+1,$p2)  -ne ($t.count)-1) # 比對標記筆數值 與實際值
                {  #370
               Logupdate $dt $tableName fromdcb  (($t.count)-1) ;  Logupdate $dt $tableName checkflag '129.FileNoMatch' 
            } #370
            else
                {  #370  檔案筆數相同
                Logupdate $dt $tableName fromdcb (($t.count)-1);  Logupdate $dt $tableName checkflag '134.importing' 
        #  357  逐步新增-開始
             if (($t.count) -ne 1 )
            {#401
            $sr0=""
            $tsplit=$t[0].Split($dr) # 讀取第一列欄位名稱
            for ($i = 0; $i -lt $tsplit.count; $i=$i+2)
            {  $sr0=$sr0+'['+$tsplit[$i]+'],'  }
            $sr0=$sr0.Substring(0,$sr0.Length-1);#$sr1

            switch ($tableName)
            {
                'vil_div'        {   $TSQL_I1="INSERT INTO "+ " m3_vil_div "+" (" +$sr0 +") values "  }
                'vil_div_his' {   $TSQL_I1="INSERT INTO "+ " m3_vil_div_his "+" (" +$sr0 +") values "  }
                Default        {  $TSQL_I1 ="INSERT INTO "+ $tableName+" (" +$sr0 +") values "  }
            }
            
            for ($k = 1; $k -lt $t.count ; $k++) # 讀取列並寫入Table
            { #387 讀取列並寫入Table
            $tsplit=$t[$k].Split($dr);$sr=""
            for ($i = 0; $i -lt $tsplit.count; $i=$i+2)
            { $sr=$sr+'N'''+$tsplit[$i]+''','}
            $sr=$sr.Substring(0,$sr.Length-1);#$sr
            $sr='('+$sr+')';#$sr
            $TSQL_Insert=$TSQL_I1+$sr; #$TSQL_Insert

           Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $TSQL_Insert -Username  sa -Password $pad
           Logupdate $dt $tableName insertSQL $K

            } #387 讀取列並寫入Table
            }#401
         # 357  逐步新增-結束
       
         }#370  檔案筆數相同
            $t2=get-date;#($t2-$t1).TotalMinutes
            Logupdate $dt $tableName checkflag '163.impFinished'   #更新匯入記錄 己完成
            Logupdate $dt $tableName TotalMinutes ($t2-$t1).TotalMinutes   #更新匯入記錄  寫入總花費時間

    } #350 if  檢查是否已經有檔案
    else
    { #350 else
      Logupdate $dt $tableName checkflag '169.NotFoundFile'  #更新匯入記錄 找不到
    } #350 else

} # 346 foreach one

#-----------------------------------
#    308   import  main  use dtsx
#-----------------------------------
#  大筆數使用DTSX package (bulk insert) , 需先寫好 dtsx 放在D:\M3_SSIS\tao_q\tao_q\之下.
#   
$tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
--where name <> 'ztranslog'
--where name   in ('vil_adm_remedy_log' )
where name   in ('vil_adj_traffic','vil_adm_remedy_log','vil_car_susp_his','vil_div_detail','vil_migrate','vil_motor_susp_his','vil_phone_xact','vil_plate_susp_his','vil_query_log','vil_receipt_payment','vil_traffic_rule' )
--where name   in ('vil_adj_traffic','vil_adm_remedy_log','vil_car_susp_his','vil_migrate','vil_motor_susp_his','vil_phone_xact','vil_query_log','vil_receipt_payment','vil_traffic_rule' )
Go
"@
$TableListSB=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad
#$TableListSB.count

foreach ($TableList in $TableListSB)
{      $tableName=$TableList.name;#$tableName   # $tableName='vil_adj_traffic' 
 # }#--
         Loginitial $dt  $tableName  # 新增匯入記錄

            $t1=get-date;
            $FW='D:\M3_SSIS\tao_q\tao_q'
            switch ($tableName) #依表格名執行不同的  dtsx
            {
                'vil_adj_traffic'          {   dtexec  /f   $FW+'\vil_adj_traffic_q.dtsx' }
                'vil_adm_remedy_log'       {   dtexec  /f   $FW+'\vil_adm_remedy_log_q.dtsx' }
                'vil_car_susp_his'         {   dtexec  /f   $FW+'\vil_car_susp_his_q.dtsx' }
                'vil_div_detail'           {   dtexec  /f   $FW+'\vil_div_detail_q.dtsx' }
                'vil_migrate'              {   dtexec  /f   $FW+'\vil_migrate_q.dtsx' }
                'vil_motor_susp_his'       {   dtexec  /f   $FW+'\vil_motor_susp_his_q.dtsx' }
                'vil_phone_xact'           {   dtexec  /f   $FW+'\vil_phone_xact_q.dtsx' }
                'vil_plate_susp_his'       {   dtexec  /f   $FW+'\vil_plate_susp_his_q.dtsx' }
                'vil_query_log'            {   dtexec  /f   $FW+'\tao_q\vil_query_log_q.dtsx' }
                'vil_receipt_payment'      {   dtexec  /f   $FW+'\vil_receipt_payment_q.dtsx' }
                'vil_traffic_rule'         {   dtexec  /f   $FW+'\vil_traffic_rule_q.dtsx' }       
            }
             $t2=get-date;#($t2-$t1).TotalMinutes
            Logupdate $dt $tableName checkflag '163.impFinished' #更新匯入記錄  己完成
            Logupdate $dt $tableName TotalMinutes ($t2-$t1).TotalMinutes  #更新匯入記錄  寫入總花費時間
}

#-----------------------------------
#   356   DB  check 
#-----------------------------------
#  取得匯入完.資料庫中  筆數總數
foreach ($TableList in $TableListSA){
  $tableName=$TableList.name;
   countsum  $tablename    
}

#-----------------------------------
#   364  compart  file count & Table count 
#-----------------------------------
#  比對應匯入筆數與實際筆數
$Tsql_compare=@"
SELECT   Tablename, fromdcb ,insertSQL, countSum   FROM [TAODW_CSQ].[dbo].ztranslog 
where  importDT='$dt'
"@
$compcountS=Invoke-Sqlcmd -ServerInstance $dbserver -Database $dbname -Query $Tsql_compare -Username  sa -Password $pad 

foreach ($compcount in $compcountS)
{
     if (  (    $compcount.countSum    )  -ne  (  $compcount.fromdcb  )   )
     {
          #$compcount.Tablename + "    not match"
           Logupdate $dt $compcount.Tablename checkflag '345  ERROR'
     }
     else
     {
           Logupdate $dt  $compcount.Tablename checkflag '349 OK'
     }
}


#-----------------------------------
#   388   delete F1 & F2
#-----------------------------------
# 刪除  來源路徑  與 工作路徑 
rm  $f1\*.*
rm  $f2\*.*
#checkLog  2016-05-30

}# if 457