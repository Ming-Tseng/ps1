import-module sqlps -DisableNameChecking



$tsq1=@"
SELECT distinct foldername FROM [SQL_inventory].[dbo].[FolderPhotoListS]  where ONOFF <> '0' order by foldername

"@

$q1S=invoke-sqlcmd -ServerInstance . -Database sql_inventory -Query  $tsq1

foreach ($q1 in $q1S)
{
    $fn=$q1.foldername
    $txtfn='d:\temp\photocheck\'+$fn+'.txt'

$q2=invoke-sqlcmd -ServerInstance . -Database sql_inventory -Query  " SELECT * FROM [SQL_inventory].[dbo].[FolderPhotoListS]  where foldername ='$fn'" 

'----------q2--------------------------'| out-file $txtfn -Append  -Width  300
$q2.foldername +'  '+ $q2.filecount   +'  '+ $q2.folderSize  | out-file $txtfn -Append  -Width  300


'----------q3--------------------------'| out-file $txtfn -Append 

$q3=invoke-sqlcmd -ServerInstance . -Database sql_inventory `
-Query  " select filename, 'ii',fileorgpath+'\'+filename ,FileLength ,FileLastWriteTime ,onoff  from FilePhotoListS  where  FilePhotoPath='$fn'  order by filename" |ft -AutoSize

$q3 | Out-String | out-file $txtfn -Append -Width  300  




'-----------q4-------------------------'| out-file $txtfn -Append 
$q4=invoke-sqlcmd -ServerInstance . -Database sql_inventory -Query  "  select 'ONOFF=0', count(filename) from FilePhotoListS  where  FilePhotoPath='$fn' and ONOFF='0'" |ft -AutoSize

$q4 | Out-String | out-file $txtfn -Append -Width  300   


'----------q5--------------------------'| out-file $txtfn -Append 

$q5=invoke-sqlcmd -ServerInstance . -Database sql_inventory `
-Query  " select filename, 'ii',fileorgpath+'\'+filename ,FileLength ,FileLastWriteTime ,onoff  from FilePhotoListS  where  FilePhotoPath='$fn' and ONOFF='2' order by filename" |ft -AutoSize

$q5 | Out-String | out-file $txtfn -Append -Width  300   

}