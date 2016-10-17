# temp9  folderphoto to csv file
#  2
#
#$Folder1     ='E:\Product20120329Y' 
#$Folder2     ='\\172.16.220.33\f$\Microsoft_20150803\'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '

#$GetfolderM  ='C:\DCIM' #office
$GetfolderM  ='J:\toFamilyphoto20121209' #home
# 檔名如有 ,(逗號)出現 會出問題


#$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
#$ff= get-date -Format yyyyMMddmm

#$repfile     ='C:\temp\temp9.csv'#OFFICE
$repfile     ='D:\temp\temp9_toFamilyphoto20121209.csv' #home 檔案大小會在執行中繼續成長.
if (Test-Path $rpfile ){ ri $rpfile -Force  }
#$repfile     ='C:\temp\temp9_'+$ff+'.txt' 

#$repfile     ='C:\temp\temp9_.csv'

#$repfile2    ='c:\temp\temp9.csv'
#$getDs='testphoto','worklog','software'
$getDs=gci $GetfolderM -Recurse  ; $k=$getDS.Count

$getDs=gci $GetfolderM  ; $k=$getDS.Count
function veage ([Datetime] $photoD ){
[datetime]$ebirthday = "06/05/2011 12:27:00"
[datetime]$vbirthday = "02/09/2005 11:43:00"
#[datetime]$ebirthday = "06/05/2011 23:59:59"
#[datetime]$vbirthday = "02/09/2005 23:59:59"
if ($vbirthday -gt $photoD){#17

($photoD.year).tostring()+"01_V0000_E0000"    
} #17
else
{ #20
$vspan = $photoD - $vbirthday
$vage = New-Object DateTime -ArgumentList $vSpan.Ticks
$vyear=$vage.Year -1
$vmonth=$vage.Month -1
if ( $ebirthday -lt $photoD )
{
$espan = $photoD - $ebirthday
$eage = New-Object DateTime -ArgumentList $eSpan.Ticks
$eyear=$eage.Year -1
$emonth=$eage.Month -1 
if (($eyear).tostring().length -eq 1) {$eyear="0"+$eyear }
if (($emonth).tostring().length -eq 1){$emonth="0"+$emonth }

}
else
{
 $eyear="00"
 $emonth="00"   
}

if (($vyear).tostring().length -eq 1) {$vyear="0"+$vyear }
if (($vmonth).tostring().length -eq 1){$vmonth="0"+$vmonth }

#if (($photoD.month).length -eq 1)
#{  $NM="0"+$photoD.month}

if ((($photoD.month).tostring()).length -eq 1)
{
    $NM="0"+$photoD.month
}
else
{
    $NM=$photoD.month
}

($photoD.year).tostring()+$NM+"_V"+$vyear+$vmonth+"_E"+$eyear+$emonth  
}#20



}

run here

$t1=get-date
'FileName;FilePhotoPath;FileLastWriteTime;FileOrgPath;FileExtension;FileSize;Filelength;modifydate;remark;ONOFF' | out-file -FilePath $repfile  -Append 
#ii $repfile
foreach ($getD in $getDs) {
$k=$k-1
$cfolders=$getD; #$cfolders
$Getfolder=$GetfolderM+"\$cfolders" ; $k.ToString() +' R1 -- '+$Getfolder +'  ii '+ $getD.FullName

#$Getfolder='C:\DCIM\IMG_6888.JPG'
#$Getfolder='C:\DCIM\P_20150321_133106.JPG'


#}#-
   #$Getfolder=$Getfolder+'\DGPA' ; $Getfolder
     if ( (test-path $Getfolder ) -eq $true) {  #  687 防止此disk 沒有此folder
       
     if ((gi $Getfolder).PSIsContainer -eq $false)
     { # 94
         $FolderfS=gci $Getfolder ; $i=$FolderfS.Count
     }# 94
     else
     {# 94
         $FolderfS=gci $Getfolder -Recurse -Force ; $i=$FolderfS.Count
     }# 94

   
   #(gci C:\DCIM\124___09 -Recurse ).count
   #gci C:\DCIM\IMG_6888.JPG -recurse

foreach ($Folderf in $FolderfS) {#646  
    #  'R2-- '+$Folderf.fullName
    if ($Folderf.PSIsContainer -eq $false){ # 17 folder YES
       $FileName          =$Folderf.Name ; #1
       $FileLastWriteTime =$Folderf.LastWriteTime ; #3
       $FilePhotoPath     = veage $FileLastWriteTime #2
       $FileOrgPath      =$Folderf.Directoryname ; #$4
       $FileExtension    =($Folderf.Extension).Substring(1,($Folderf.Extension).Length-1) ; #5
       [float]$FileSize       ="{0:n2}" -f (($Folderf.Length) / 1000000) ; #6
       $Filelength      =$Folderf.Length #7
       $modifydate      =get-date -Format yyyyMMdd  #8
     

$FileName+';'+$FilePhotoPath+';'+$FileLastWriteTime +';'+$FileOrgPath +';'+$FileExtension+';'+$FileSize+';'+$Filelength+';'+$modifydate+';;'+'1' | out-file -FilePath $repfile  -Append 

        #$i.tostring() + ' R2-- '+$f1f;$i=$i-1
     } # 17 folder YES
 }#646

   } #  687 防止此disk 沒有此folder
       
 }
 $t2=get-date
 $t2-$t1
 ii $repfile

 <##home
Days              : 0
Hours             : 5
Minutes           : 14
Seconds           : 46
Milliseconds      : 392
Ticks             : 188863926618
TotalDays         : 0.218592507659722
TotalHours        : 5.24622018383333
TotalMinutes      : 314.77321103
TotalSeconds      : 18886.3926618
TotalMilliseconds : 18886392.6618

R1-- G:\Family2010821X\photots
Exception calling "Substring" with "2" argument(s): "startIndex cannot be large
r than length of string.
Parameter name: startIndex"
At C:\Users\Chao_Ming\OneDrive\download\PS1\temp9.ps1:113 char:8
+        $FileExtension    =($Folderf.Extension).Substring(1,($Folderf.Extensio
n). ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
    + FullyQualifiedErrorId : ArgumentOutOfRangeException
 
Exception calling "Substring" with "2" argument(s): "startIndex cannot be large
r than length of string.
Parameter name: startIndex"
At C:\Users\Chao_Ming\OneDrive\download\PS1\temp9.ps1:113 char:8
+        $FileExtension    =($Folderf.Extension).Substring(1,($Folderf.Extensio
n). ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
    + FullyQualifiedErrorId : ArgumentOutOfRangeException
 
R1-- G:\Family2010821X\photo_B
R1-- G:\Family2010821X\pixnet
R1-- G:\Family2010821X\Vacations
R1-- G:\Family2010821X\vanessa-computer-20121012
R1-- G:\Family2010821X\Vanessa-Learning
Exception calling "Substring" with "2" argument(s): "startIndex cannot be large
r than length of string.
Parameter name: startIndex"
At C:\Users\Chao_Ming\OneDrive\download\PS1\temp9.ps1:113 char:8
+        $FileExtension    =($Folderf.Extension).Substring(1,($Folderf.Extensio
n). ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
    + FullyQualifiedErrorId : ArgumentOutOfRangeException
 
R1-- G:\Family2010821X\Vera-Others
R1-- G:\Family2010821X\vv
R1-- G:\Family2010821X\Wmv
#>