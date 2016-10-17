#
#  save to txt for jpg temp7
#
#$Folder1     ='E:\Product20120329Y' 
#$Folder2     ='\\172.16.220.33\f$\Microsoft_20150803\'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '

$GetfolderM  ='E:' 
$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
$ff= get-date -Format yyyyMMddmm
$repfile     ='e:\familyphoto\temp7'+$ff+'.txt'
$repfile2    ='c:\temp\temp5.csv'
#$getDs='testphoto','worklog','software'
$getDs='\Family2010821X\2005'


function folderproperites ($folderpath){
    #$folderpath='H:\movie2015'
#(gci $x -Recurse ) | % { $_.PSIsContainer -eq $false } 

# 找出所有的folder
#(gci $x -Recurse ) | ? {$_.PSIsContainer -eq  $true } |% {$_.name }
$frc=((gci $folderpath -Recurse -Force) | ? {$_.PSIsContainer -eq  $true }).count

# 找出所有的 Files
$fec=((gci $folderpath -Recurse -Force) | ? {$_.PSIsContainer -eq  $false }).count

# 找出Size
$fsize="{0:n1}" -f  ( ((gci $folderpath -Recurse -Force) | Measure-Object -property length -sum).Sum   / 1MB) 

$frc;$fec;$fsize

}
#$x=0
#do{if ( ((gps | ? Name -eq notepad) -ne $null )){ stop-process -name notepad -Force   };if (test-path $repfile ){ri $repfile  -Force }
# $x=$x+1
#} until ($x -gt 2)



foreach ($getD in $getDs) {


$cfolders=$getD; #$cfolders
$Getfolder=$GetfolderM+"\$cfolders" ; 'R1-- '+$Getfolder
  #}
   #$Getfolder=$Getfolder+'\DGPA' ; $Getfolder
     if ( (test-path $Getfolder ) -eq $true)
   {  #  687 防止此disk 沒有此folder

       


   $FolderfS=gci $Getfolder -recurse -Force; $i=$FolderfS.Count
 foreach ($Folderf in $FolderfS) {#646  
 
    if ($Folderf.PSIsContainer -eq $false){ # 17 folder YES
       $f1f =$Folderf.FullName ; #$f1f
       #$Folderf |select *

       #gi C:\microsoft\ACT |select *

       $subFoldercount=(folderproperites $f1f)[0]
       $filecount     =(folderproperites $f1f)[1]
       $folderSize    =(folderproperites $f1f)[2]
       $folderName    =$f1f.Substring(2,$f1f.Length-2)
        $gr=gi $f1f
       $Attributes    =$gr.Attributes
       
       #$folderName ="abd' s"

       $folderName =$folderName.Replace('''','-')

       $folderlevel = (0..($folderName.length - 1) | ? {$folderName[$_] -eq '\'}).count
       $createdate=get-date -Format yyyyMMdd
       $f1f+',filecount='+$filecount +',size='+$folderSize +'  subfolder ='+$subFoldercount  | out-file -FilePath $repfile  -Append 

$i.tostring() + ' R2-- '+$f1f;$i=$i-1
     } # 17 folder YES
     }#646

   } #  687 防止此disk 沒有此folder
       
 }

 ii $repfile

