#
# INSERT INTO [dbo].[FolderBackupLOG] 
#

if ((get-module 'sqlps') -eq $Null){    Import-Module 'sqlps' -DisableNameChecking    }  


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

$GetfolderM = '\\172.16.220.33\f$' 
$ivsql='SP2013'
$ndb='SQL_Inventory'

cd C:\ # cd  SQLSERVER:\



$tsql_GetfolderS=@"
 select folderGroup from folderGroupS where ONoff='1'
"@

$getDs=Invoke-Sqlcmd -Query $tsql_GetfolderS -ServerInstance $ivsql -Database $ndb ;  $getDs.Count



foreach ($getD in $getDs)
{ # 634  loop 1

   $cfolders=$getD.folderGroup; #$cfolders

   $Getfolder=$GetfolderM+"\$cfolders" ; $Getfolder
   #$Getfolder=$Getfolder+'\DGPA' ; $Getfolder
     if ( (test-path $Getfolder ) -eq $true){  #  687 防止此disk 沒有此folder

   $FolderfS=gci $Getfolder -recurse -Force; #$FolderfS.Count

    foreach ($Folderf in $FolderfS) {#646  
       if ($Folderf.PSIsContainer -eq $true){ # 17 folder YES
       $f1f =$Folderf.FullName ; $f1f

       $subFoldercount=(folderproperites $f1f)[0]
       $filecount     =(folderproperites $f1f)[1]
       $folderSize    =(folderproperites $f1f)[2]
       $folderName    =$f1f.Substring(18,$f1f.Length-18)

       #$folderName ="abd' s"

       $folderName =$folderName.Replace('''','-')

       $folderlevel = (0..($folderName.length - 1) | ? {$folderName[$_] -eq '\'}).count
       $createdate=get-date -Format yyyyMMdd

       $tql_select="select count(folderName) as [cxt] from [dbo].[FolderBackupLOG] where folderName='$folderName'"

      $tql_update=@"
      UPDATE [dbo].[FolderBackupLOG]
       SET [filecount] = '$filecount'
      ,[subFoldercount] = '$subFoldercount'
      ,[folderSize] = '$folderSize'
      ,[modifydate] = '$createdate'
       WHERE [folderGroup] = '$cfolders'
       and [folderName] = '$folderName'   
GO
"@ #保留不使用

       if ((Invoke-Sqlcmd -Query $tql_select -ServerInstance $ivsql -Database $ndb).cxt -eq 0 ){ # 680 new
           
$tql_insert=@"
INSERT INTO [dbo].[FolderBackupLOG] 
VALUES ('$cfolders','$folderName','$filecount','$subFoldercount','$folderSize','1','$folderlevel','$createdate','$createdate')

"@
       Invoke-Sqlcmd -Query $tql_insert -ServerInstance $ivsql -Database $ndb

       } # 680 new
       else{  #685 update ; 由於是保留完成LOG 因此不進行Update
           
$tql_insert=@"
INSERT INTO [dbo].[FolderBackupLOG] 
VALUES ('$cfolders','$folderName','$filecount','$subFoldercount','$folderSize','1','$folderlevel','$createdate','$createdate')

"@
       Invoke-Sqlcmd -Query $tql_insert -ServerInstance $ivsql -Database $ndb

       } #685 update




      }
     }#646

   } #  687 防止此disk 沒有此folder
       
    
} # 634  loop 1


foreach ($getD in $getDs)
{ # 113  loop 2

   $cfolders=$getD.folderGroup; #$cfolders
   $Getfolder=$GetfolderM+"\$cfolders" ; $Getfolder

#$Getfolder='\\172.16.220.33\f$\Proposal'
#$Getfolder='\\172.16.220.33\f$\RFP'
  
   #$f1f =$Getfolder.FullName ; $f1f
       $subFoldercount=(folderproperites $Getfolder)[0]
       $filecount     =(folderproperites $Getfolder)[1]
       $folderSize    =(folderproperites $Getfolder)[2]
       $folderName    =$Getfolder.Substring(18,$Getfolder.Length-18)
       $folderName =$folderName.Replace('''','-')

       $folderlevel = '1'
       $createdate=get-date -Format yyyyMMdd

       $tql_select="select count(folderName) as [cxt] from [dbo].[FolderBackupLOG] where folderName='$folderName'"

       $tql_update=@"
      UPDATE [dbo].[FolderBackupLOG]
       SET [filecount] = '$filecount'
      ,[subFoldercount] = '$subFoldercount'
      ,[folderSize] = '$folderSize'
      ,[modifydate] = '$createdate'
       WHERE [folderGroup] = '$cfolders'
       and [folderName] = '$folderName'   
GO
"@ #保留不使用

       if ((Invoke-Sqlcmd -Query $tql_select -ServerInstance $ivsql -Database $ndb).cxt -eq 0 ){ # 680 new
           
$tql_insert=@"
INSERT INTO [dbo].[FolderBackupLOG] 
VALUES ('$cfolders','$folderName','$filecount','$subFoldercount','$folderSize','1','$folderlevel','$createdate','$createdate')

"@
       Invoke-Sqlcmd -Query $tql_insert -ServerInstance $ivsql -Database $ndb

       } # 680 new
       else{  #685 update ; 由於是保留完成LOG 因此不進行Update
           
$tql_insert=@"
INSERT INTO [dbo].[FolderBackupLOG] 
VALUES ('$cfolders','$folderName','$filecount','$subFoldercount','$folderSize','1','$folderlevel','$createdate','$createdate')

"@
       Invoke-Sqlcmd -Query $tql_insert -ServerInstance $ivsql -Database $ndb

       } #685 update

       } # 113  loop 2



     

   
