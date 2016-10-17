#
# check F1 & F2
#

$Folder1     ='\\172.16.220.33\f$\Microsoft\' 
#$Folder1     ='X:\worklog\'
$Folder2     ='\\172.16.220.33\f$\Microsoft_20150803\'
$repfile     ='H:\report.txt'
$repfile2    ='H:\report2.txt'


#$Folder1     ='H:\worklog\kmuh\x' 
#$Folder2     ='H:\worklog20130508Y\KMUH_20141013\x'
#$repfile     ='H:\report.txt '#
$repfile2     ='H:\report2.txt'

ri  $repfile2 
  ' ++++++++++++++++++++F1++++++++++++++++++++++++++++++++++++++++++++++++++++++  ' |out-file $repfile2 -Append
#----------------------------------------------------------------------------------------------------------check F1 to F2

$Folder1fS = Get-ChildItem $Folder1 -recurse ; $Folder1fS.Count

$i=$Folder1fS.count
foreach ($Folder1f in $Folder1fS){
        
        $f1f =$Folder1f.FullName ;# $f1f
        $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f

    if ( ($Folder1f.PSIsContainer -eq $true) -and ((test-path $f2f) -eq $false)   ){ # 17 folder YES
     'F2 folder Not Found  -  '+   $f2f |out-file $repfile2 -Append
     '   ' |out-file $repfile2 -Append 
}     # 17 folder YES

  if ( ($Folder1f.PSIsContainer -eq $false)   ){ # 32 files YES
     
       if ( ($Folder2f.PSIsContainer -eq $false)   ){ # 57 files YES
      

     if ((test-path $f2f) -eq $false)
     {
      'F2 file  Not Found  -  '+   $f2f |out-file $repfile2 -Append
      '   ' |out-file $repfile2 -Append  
     }
     else
     {
     $df=gi $f2f
          if ($Folder1f.LastWriteTime -notmatch $df.LastWriteTime){
      'LastWriteTime  Not match  -  '+   $f1f |out-file $repfile2 -Append
      '   ' |out-file $repfile2 -Append
      }

         
     }
}     # 57 files YES
    


}     # 32 files YES
  'F1   -  '+$i.ToString();$i=$i-1

 }

  ' ++++++++++++++++++++F2++++++++++++++++++++++++++++++++++++++++++++++++++++++  ' |out-file $repfile2 -Append
 #----------------------------------------------------------------------------------------------------------check F2 to F1

$Folder2fS=Get-ChildItem $Folder2 -recurse; $Folder2fS.Count
$i=$Folder2fS.count

foreach ($Folder2f in $Folder2fS){
        
        $f2f =$Folder2f.FullName ;# $f1f
        $f1f =$Folder2f.FullName.Replace($Folder2, $Folder1) ;#$f2f

    if ( ($Folder2f.PSIsContainer -eq $true) -and ((test-path $f1f) -eq $false)   ){ # 17 folder YES
     'F1 folder Not Found  -  '+   $f1f |out-file $repfile2 -Append
     '   ' |out-file $repfile2 -Append 
}     # 17 folder YES

  if ( ($Folder2f.PSIsContainer -eq $false)   ){ # 57 files YES
      

     if ((test-path $f1f) -eq $false)
     {
      'F1 file  Not Found  -  '+   $f1f |out-file $repfile2 -Append
      '   ' |out-file $repfile2 -Append  
     }
     else
     {
     $df=gi $f1f
      if ($Folder2f.LastWriteTime -notmatch $df.LastWriteTime){
      'LastWriteTime  Not match  -  '+   $f2f |out-file $repfile2 -Append
      '   ' |out-file $repfile2 -Append
      }
         
     }
}     # 57 files YES

 'F2   -  '+$i.ToString();$i=$i-1
 }


 
$Folder1fS=Get-ChildItem $Folder1 -recurse; 'F1 total= '+$Folder1fS.Count

$Folder2fS=Get-ChildItem $Folder2 -recurse; 'F2 total= '+$Folder2fS.Count

notepad $repfile2


<#

$f1='\\172.16.220.33\f$\mydata\PMP\PMBOK.2004.第三版[中文版].pdf'
$f2='\\172.16.220.33\f$\mydata_20130805Y\PMP\PMBOK.2004.第三版[中文版].pdf'

$f1='H:\worklog20130508Y\KMUH_20141013\x\PMBOK.2004.第三版[中文版].pdf'
$f='\\172.16.220.33\f$\mydata\book_example_performance_Tuning\Ch06\Ch06_SQL\程式碼列表 6.6：透過系統檢視查詢資料庫內資料表使用的硬碟空間分配SELECT a3.name AS [Schema 名稱],SELECT a3.name AS [Schema 名稱],.sql'
Test-Path  $f1
Test-Path  $f2



#>