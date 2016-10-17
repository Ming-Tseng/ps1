
#temp      compare F1 & F2
#temp2  #  INSERT INTO [dbo].[FolderBackupLOG]   db
#temp3     check F1 & F2  save txt
#temp4     clear empty folder
#temp5  #  multi-folder to csv  @office
#temp6     save Photo to   Familyphoto  @home
#temp7     save to txt for jpg temp7
#temp8  #  check file replicator save to Txt
#temp9  #  get all file to  txt ( sort by name , lastwritetime ) 
#temp10  #  1535  Get filePhotoLists  copy jpg to filephotopath ( familyPhoto) for SQL





#
# compare F1 & F2
#
$Folder1     ='G:\FamilyPhoto' 
$Folder2     ='F:\FamilyPhoto'
$repfile     ='G:\temp\report_FtoGOK.txt'
$repfile2    ='G:\temp\report_FtoGNeedCheck.txt'

#$Folder1     ='H:\worklog\kmuh' 
#$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '

#----------------------------------------------------------------------------------------------------------list folder 1 compare to folder2 
$Folder1fS=Get-ChildItem $Folder1 -recurse -force ; $Folder1fS.Count


foreach ($Folder1f in $Folder1fS) {# 18 處理目錄 check Folder

    if ($Folder1f.PSIsContainer -eq $true){ # 17 folder YES
       $f1f =$Folder1f.FullName ; #$f1f
       $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f
       if ( (test-path $f2f) -eq $false){ # 21 if folder is null
        $f2f
        #mkdir $f2f
      }  # 21 if folder is null
     }  # 17 folder YES
}# 18 處理目錄 check Folder


 $i=$Folder1fS.count
foreach ($Folder1f in $Folder1fS){ # 33 處理檔案  check File
#}#-

 if ($Folder1f.PSIsContainer -eq $false){ # 31 IS file

 $f1f =$Folder1f.FullName ;# $f1f
 $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f


 if ((test-path $f2f) -eq $false) {
         $i.ToString()+" cp $f1f -destination $f2f -Force" |out-file $repfile -Append
  
      #Copy-Item $f1f -destination $f2f -Force 
  }# 假如folder2 沒有,則直接copy
  else{
      $df=gi $f2f ;$SF=gi $f1f 
      if ($Folder1f.LastWriteTime -gt $df.LastWriteTime)
        {
        $i.ToString()+' -> '+$f1f+'   ==== ' + $Folder1f.LastWriteTime |out-file $repfile2 -Append
        # '               -> '+$f2f+'   ==== ' + $df.LastWriteTime |out-file $repfile -Append

         #Copy-Item $f1f -destination $f2f -Force 
      } 
  }#假如folder2 有,則比較如是較晚日期.也copy
  $i;$i=$i-1;"f1tof2 -"+$f1f +' vs '+ $f2f
    #$srcfile |select name,LastWriteTime,FullName,Directory 
    #$srcfile |select *
    #$srcfileDirectory=$srcfile.Directory ;$srcfileDirectory

} # 31 IS file 
} # 33 處理檔案  check File

#----------------------------------------------------------------------------------------------------------  list folder 2 
$Folder2fS=Get-ChildItem $Folder2 -recurse; $Folder2fS.Count

foreach ($Folder2f in $Folder2fS) {# 118 處理目錄 check Folder
    if ($Folder2f.PSIsContainer -eq $true){ # 117 folder YES
       $f2f =$Folder2f.FullName ; #$f1f
       $f1f =$Folder2f.FullName.Replace($Folder2, $Folder1) ;#$f2f
       if ( (test-path $f1f) -eq $false){ # 121 if folder is null
        mkdir $f1f
      }  # 121 if folder is null
     }  # 117 folder YES
}# 118 處理目錄 check Folder


 $i=$Folder2fS.count
foreach ($Folder2f in $Folder2fS){ # 33 處理檔案  check File

 if ($Folder2f.PSIsContainer -eq $false){ # 31 IS file

  $f2f =$Folder2f.FullName;#$f2f
  $f1f =$Folder2f.FullName.Replace($Folder2, $Folder1);
  
  if ((test-path $f1f) -eq $false) {
   $i.ToString()+" cp $f2f -destination $f1f -Force" |out-file $repfile -Append
  
      Copy-Item $f2f -destination $f1f -Force 
  }# 假如folder2 沒有,則直接copy
  else{
      $df=gi $f1f
      if ($Folder2f.LastWriteTime -gt $df.LastWriteTime)
        {
         $i.ToString()+' -> '+$f2f+'   ==== ' + $Folder2f.LastWriteTime |out-file $repfile -Append
         '               -> '+$f1f+'   ==== ' + $df.LastWriteTime |out-file $repfile -Append

         Copy-Item $f2f -destination $f1f -Force 
      } 
  }#假如folder2 有,則比較如是較晚日期.也copy
  $i;$i=$i-1;"f2tof1 -"+$f2f

} # 31 IS file 
} # 33 處理檔案  check File




$Folder1fS=Get-ChildItem $Folder1 -recurse; 'F1 total= '+$Folder1fS.Count

$Folder2fS=Get-ChildItem $Folder2 -recurse; 'F2 total= '+$Folder2fS.Count

