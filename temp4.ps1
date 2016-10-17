#
# clear empty folder
#
$Folder2     ='\\172.16.220.33\f$\microsoft_20150803'

$x=0;
do
{
    $Folder2fS=Get-ChildItem $Folder2 -recurse; $Folder2fS.Count
foreach ($Folder2f in $Folder2fS){
 if ($Folder2f.PSIsContainer -eq $true){

      if (( Get-ChildItem   $Folder2f.FullName).count  -eq 0 ) {
      $Folder2f.FullName |out-file H:\removeFolderList.txt -append 
          # ri  $Folder2f.FullName -Force -Confirm:$false
      }}# ri 
}

$x=$x+1
}
until ($x -gt 3)