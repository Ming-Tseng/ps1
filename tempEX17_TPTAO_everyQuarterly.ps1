<#

E:\everyday-cron\everyQuarterly.ps1

C:\Users\administrator.CSD\OneDrive\download\PS1\EX17_TPTAO_everyQuarterly.ps1

F1=  ii D:\olapdb
F2=  ii   D:\M3_Data\FACT\                   vil_adm_remedy_log.D
F3=  E:\every-day-vil\yyyyMMdd(完整) ;   ii  E:\every-day-vil\
         ii  D:\M3_SSIS\tao_q
E:\every-day-vil\20160526(完整)
powershell_ise   E:\everyday-cron\EX1701_SQLScript.ps1

SSIS  D:\M3_SSIS\tao_q

ssms
cp   "E:\every-day-vil\20160526(完整)\vil_adm_remedy_log.D"    "D:\M3_Data\FACT\"  

ii  'E:\every-day-vil\20160526(完整)\vil_query_log.h'

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

#-----------------------------------
#     parameter  & configure
#-----------------------------------
$dbserver=$env:COMPUTERNAME
$dbname ="TAODW_CSQ"
$dr="@#"
$ilogfile='E:\everyday-cron\importLogError.txt'
$dt= get-date -Format yyyy-MM-dd
$dtcopy= get-date -Format yyyyMMdd
$pad="tao_m3_789"
$f1="D:\olapdb"
$f2="D:\M3_Data\FACT\"
$f3="E:\every-day-vil"

 
$ilogfile=$fpath+'\importLog.txt'
if  ( !(Get-Module  sqlps) ) {   Import-Module sqlps -DisableNameChecking }
#-----------------------------------
#     function
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


#-----------------------------------
#     copy   F1 to F2
#-----------------------------------
$tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
where name <> 'ztranslog'
Go
"@

$TableListSA=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad ;$fi='0'
#$TableListSA.Count
$t1=get-date
foreach ($TableList in $TableListSA){
         $tableName=$TableList.name;
             switch ($tableName)
           {  'm3_vil_div'         {   $tableName="vil_div"   }
        'm3_vil_div_his' {  $tableName="vil_div_his"   }}


         $fullpathD=$f1+'\'+$tableName+'.D' 
          $fullpathH=$f1+'\'+$tableName+'.H'
    if (  (test-path $fullpathD ) -and ( test-path $fullpathH  )  ) {          $fi='1'   }
    if ( $fi -eq '1' ){  
          cp   "D:\olapdb\$tableName.D"  "$f2\$tableName.D" -Force  
          cp  "D:\olapdb\$tableName.H"  "$f2\$tableName.H" -Force  
      }
}
$t2=get-date;($t2-$t1)  #--41 sec
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
#     copy   F1 to F3
#-----------------------------------
$fpath="$f3\$dtcopy(完整)"  # ii 
if (   !( test-path $fpath )   )
{    mkdir  $fpath    ;# rm  "$f2\$dtcopy(完整)"
}
$tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
where name <> 'ztranslog'
Go
"@

$TableListS=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad ;$fi='0'
foreach ($TableList in $TableListS){
         $tableName=$TableList.name;
         $fullpathD=$f1+'\'+$tableName+'.D' 
          $fullpathH=$f1+'\'+$tableName+'.H'
    if (  (test-path $fullpathD ) -and ( test-path $fullpathH  )  ) {          $fi='1'   }
}
if ( $fi -eq '1' ){    cp  D:\olapdb\*.*  "$f2\$dtcopy(完整)" -Force    }

#-----------------------------------
#     import  main  use Powershell
#-----------------------------------
truncateall

$fpath=$f2

$tsql_GetTableList=@"
use [TAODW_CSQ]
--Go
select name from sys.tables 
--where name <> 'ztranslog'
--where name   in ('m3_vil_div','m3_vil_div_his','vil_accuse_no_code' )
where name  not in ('ztranslog','vil_adj_traffic','vil_adm_remedy_log','vil_car_susp_his','vil_div_detail','vil_migrate','vil_motor_susp_his','vil_phone_xact','vil_plate_susp_his','vil_query_log','vil_receipt_payment','vil_traffic_rule' )
Go
"@
$TableListS=Invoke-Sqlcmd -ServerInstance $dbserver  -Query $tsql_GetTableList  -Username  sa  -Password  $pad
#$TableListS.count
foreach ($TableList in $TableListS)
{ # 346 foreach one
#}#---


    $tableName=$TableList.name;#$tableName
    Loginitial $dt  $tableName
    switch ($tableName)
    {  'm3_vil_div'         {   $tableName="vil_div"   }
        'm3_vil_div_his' {  $tableName="vil_div_his"   }}
   # $tableName


    $fullpathD=$fpath+'\'+$tableName+'.D'  #$fullpathD
    $fullpathH=$fpath+'\'+$tableName+'.H'
    
    if ((test-path $fullpathD ) -and ( test-path $fullpathH  ) ) #檢查是否已經有檔案
    { #350 if 檢查是否已經有檔案
      #$tableName +  '- ready' 
        
        $t1=get-date;
        $t=gc $fullpathD    -Encoding UTF8 # 讀取檔案 放入$t
         switch ($tableName)
        {  'vil_div'         {   $tableName="m3_vil_div"   }
        'vil_div_his'     {   $tableName="m3_vil_div_his"   }}
        
                      
        Logupdate $dt $tableName checkflag '118.GetFileFinished'

        #$fullpathH="H:\TPTAODB\20160117\vil_car_susp_his.H"
        $hf=gc $fullpathH;$p1=$hf.indexof(',');#$hf;$p1
        #$hf=$hf.Substring($p1,$hf.Length-1)
        #$hf.Substring(22,$hf.Length-22)
        $p2=($hf.Substring($p1+1,$hf.Length-($p1+1))).indexof(',');#$p2
        #$hf.Substring($p1+1,$p2)
            if ($hf.Substring($p1+1,$p2)  -ne ($t.count)-1)
                {  #370
               Logupdate $dt $tableName fromdcb  (($t.count)-1) ;  Logupdate $dt $tableName checkflag '129.FileNoMatch' 
            } #370
                else
                {  #370  檔案筆數相同
                Logupdate $dt $tableName fromdcb (($t.count)-1);  Logupdate $dt $tableName checkflag '134.importing' 
        #  357
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
         # 357
       
         }#370  檔案筆數相同
            $t2=get-date;#($t2-$t1).TotalMinutes
            Logupdate $dt $tableName checkflag '163.impFinished'
            Logupdate $dt $tableName TotalMinutes ($t2-$t1).TotalMinutes

    } #350 if  檢查是否已經有檔案
    else
    { #350 else
      Logupdate $dt $tableName checkflag '169.NotFoundFile'
    } #350 else

} # 346 foreach one

#-----------------------------------
#     import  main  use dtsx
#-----------------------------------
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
         Loginitial $dt  $tableName
         $fullpathH=$fpath+$tableName+'.H'  # ii  $fullpathH
         $hf=gc $fullpathH;$p1=$hf.indexof(',');#$hf;$p1
          $p2=($hf.Substring($p1+1,$hf.Length-($p1+1))).indexof(',');#$p2
            if ($hf.Substring($p1+1,$p2)  -ne ($t.count)-1)
          {
               Logupdate $dt $tableName fromdcb ($hf.Substring($p1+1,$p2) );  Logupdate $dt $tableName checkflag '134.importing' 
           }
         $t1=get-date;
            switch ($tableName)
            {
                'vil_adj_traffic'               {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_adj_traffic_q.dtsx }
                'vil_adm_remedy_log' {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_adm_remedy_log_q.dtsx }
                'vil_car_susp_his'          {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_car_susp_his_q.dtsx }
                'vil_div_detail'              {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_div_detail_q.dtsx }
                'vil_migrate'                  {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_migrate_q.dtsx }
                'vil_motor_susp_his'    {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_motor_susp_his_q.dtsx }
                'vil_phone_xact'            {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_phone_xact_q.dtsx }
                'vil_plate_susp_his'       {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_plate_susp_his_q.dtsx }
                'vil_query_log'               {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_query_log_q.dtsx }
                'vil_receipt_payment'  {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_receipt_payment_q.dtsx }
                'vil_traffic_rule'             {   dtexec  /f     D:\M3_SSIS\tao_q\tao_q\vil_traffic_rule_q.dtsx }       
            }
             $t2=get-date;#($t2-$t1).TotalMinutes
            Logupdate $dt $tableName checkflag '163.impFinished'
            Logupdate $dt $tableName TotalMinutes ($t2-$t1).TotalMinutes
}

#******************************************************
#-----------------------------------
#     DB  check 
#-----------------------------------
foreach ($TableList in $TableListSA){
  $tableName=$TableList.name;
   countsum  $tablename    
}

#-----------------------------------
#    compart  file count & Table count 
#-----------------------------------

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
#     delete F1 & F2
#-----------------------------------
rm $f1\*.*
rm  $f2\*.*
#checkLog  2016-05-30
