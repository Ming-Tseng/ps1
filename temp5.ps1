#
# multi-folder Properties to SQL table   ref : OS07_file.ps1 L:1851

#$Folder1     ='E:\Product20120329Y' 
#$Folder2     ='\\172.16.220.33\f$\Microsoft_20150803\'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '
$GetfolderM  ='E:' 
$Getfolder     ='E:\FamilyPhoto'
$repfile     ='E:\OS07_file_1851_temp5.txt'
$repfile2    ='c:\temp\temp5.csv'
#$getDs='microsoft','worklog','software'
$getDs='FamilyPhoto'

Import-Module  sqlps -DisableNameChecking
#Invoke-Sqlcmd -ServerInstance 172.16.220.33 -Query 'select @@servername' -Username sa -Password p@ssw0rd


function folderproperties ($folderpath){
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

 $FolderfS=gci $Getfolder ; $FolderfS.Count

foreach ($Folderf in $FolderfS) {

  $folderName   = $Folderf.Name
  $filecount     =(folderproperties $Folderf.FullName)[1]
  $folderSize    =(folderproperties $Folderf.FullName)[2]
  $folderlevel = '1'


  $sql_insert=@"
  INSERT INTO [dbo].[FolderPhotoListS]
           ([folderName] ,[filecount] ,[folderSize] ,[folderCheckFlag] ,[modifydate] ,[ONOFF])
     VALUES
           ('$folderName','$filecount','$folderSize','1' ,getdate() ,'1')
GO
"@

Invoke-Sqlcmd -ServerInstance 172.16.220.33 -Query $sql_insert  -Database SQL_inventory -Username sa -Password p@ssw0rd


} #-




$x=0
do{if ( ((gps | ? Name -eq excel) -ne $null )){ stop-process -name excel -Force   };if (test-path $repfile2){ri $repfile2 -Force }
 $x=$x+1
} until ($x -gt 2)

   
   #$Getfolder=$Getfolder+'\DGPA' ; $Getfolder
     if ( (test-path $Getfolder ) -eq $true)
   {  #  687 防止此disk 沒有此folder

       #$f1f=$Getfolder.FullName;'R2-- '+$f1f
       $subFoldercount=(folderproperties $Getfolder)[0]
       (folderproperties $Getfolder)[1]
       (folderproperties $Getfolder)[2]
       $f1f.Substring(2,$Getfolder.Length-2)
       $folderName =$folderName.Replace('''','-')
       
       $gr=gi $Getfolder
       $Attributes    =$gr.Attributes
       New-Object -TypeName PSObject  -Property @{ FolderGroup = $cfolders 
;FolderName = $Getfolder 
;subFoldercount =$subFoldercount
;檔案總數 =$filecount
;folderSizeMB=$folderSize
;folderlevel=$folderlevel
;Attributes =$Attributes  } `
| Select-Object FolderGroup,FolderName ,subFoldercount,檔案總數,folderSizeMB,folderlevel,Attributes  `
| Export-Csv -Path $repfile2 -Append  -NoTypeInformation  -Encoding utf8 



   $FolderfS=gci $Getfolder -recurse -Force; $i=$FolderfS.Count
 foreach ($Folderf in $FolderfS) {#646  
 
   # if ($Folderf.PSIsContainer -eq $true){ # 17 folder YES
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

New-Object -TypeName PSObject  -Property @{ FolderGroup = $cfolders 
;FolderName = $f1f 
;subFoldercount =$subFoldercount
;檔案總數 =$filecount
;folderSizeMB=$folderSize
;folderlevel=$folderlevel 
;Attributes =$Attributes  } `
| Select-Object FolderGroup,FolderName ,subFoldercount,檔案總數,folderSizeMB,folderlevel,Attributes  `
| Export-Csv -Path $repfile2 -Append  -NoTypeInformation  -Encoding utf8 
#| Select-Object FolderGroup,FolderName ,subFoldercount | Export-Csv -Path $repfile2 -Append -Encoding Unicode -NoTypeInformation -Delimiter ','

$i.tostring() + ' R2-- '+$f1f;$i=$i-1
   #  } # 17 folder YES
     }#646

   } #  687 防止此disk 沒有此folder
       
 }

 ii $repfile2

