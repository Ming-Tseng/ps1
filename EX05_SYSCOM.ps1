<#
C:\Users\administrator.CSD\OneDrive\download\PS1\EX05_SYSCOM
date: Jul.172015
author : Ming Tseng
taskschd.msc

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\EX05_SYSCOM.ps1

foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname         =$ps1fS.name
    $ps1fFullname     =$ps1fS.FullName 
    $ps1flastwritetime=$ps1fS.LastWriteTime
    $getdagte         = get-date -format yyyyMMdd
    $ps1length        =$ps1fS.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To "a0921887912@gmail.com","abcd12@gmail.com" -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  `
    -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length " `
    -Body "  ps1source from:me $ps1fname   " 
}


#>



# 31     mingbackup 
# 171   mingbackupfile  F1 to F2
# 337   mingbackuDB 
#  434   mingbackupfile  F2 to F3  ( Apr.20.2016 不再執行備份.由 690303@syscom onedrive )


















#---------------------------------------------------------------
# 31  mingbackup one ps1  @29
#---------------------------------------------------------------
powershell_ise c:\perflogs\mingbackup.ps1
# 29  backup onenote ps1 to 33(F2)

<#
C:\PerfLogs\mingbackup.ps1
date: Jul.172015
author : Ming Tseng
taskschd.msc
F1 to F2(144)
#>


gps -Name powershell | ?  id -ne  $pid  | Stop-Process

$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd

#$secpasswd = ConvertTo-SecureString "p@ssw0rds" -AsPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential "PMOCSD\administrator",$secpasswd
$logfile='H:\temp\29_mingbackupOnenotePS1_Log.txt'  # ri $logfile  ii $logfile
"   " | out-file -FilePath $logfile -Append # ii H:\temp\mingbackuplog.txt 
"  "+ (get-date -f yyyy-MM-dd_hh:mm:ss)  | out-file -FilePath $logfile -Append # ii H:\temp\mingbackuplog.txt 

#get-psdrive
Net use * /delete /y  #關鍵指令Oct.012015+

if ( (Test-Path X:\)  -eq $False) { New-PSDrive -Name X -PSProvider FileSystem -Root "\\192.168.112.144\d$" -Credential $credential -Persist }

#Get-PSDrive X |Remove-PSDrive 
#ii C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup
if ((Test-Path -Path C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup) -eq $false) #Nov.24 +
{
     Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -Subject "*** Ming Onenote PS1 backup failure  09:00PM/Monday at 29Host  taskschd name :Mingbackup  " `
    -Body "  C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup  failure line 26  "   
}
#------------------------------------------------------------------------------------------------
# 刪除 onenote_weeklybackup
if ((Test-Path -Path C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup) -eq $True)
{


ri C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup   –Recurse -Force -Confirm:$false   # OK manual


"(1)ri  C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup finish "+ (get-date -f MM-dd_hh:mm:ss)  | out-file -FilePath $logfile -Append # ii H:\temp\mingbackuplog.txt 
#------------------------------------------------------------------------------------------------
#  指定 33 的備份路徑
$str=get-date -Format yyyyMMdd
$f33mydata  ='X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\mydataII\PS1_'+$str
$f33dbbackup='X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\mydataII\SQL_Inventory_'+$str+'.bak'

#$f33mydata='X:\mydataII\PS1_'+$str
#$f33dbbackup='X:\mydataII\SQLDBbackup\SQL_Inventory_'+$str+'.bak'
#
#
start-sleep 5

Copy-Item -Path C:\onenote\ -Destination C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup –Recurse -Force  # OK about 5m48Sec

'(2) ci  c:\onenote to  C:\Users\administrator.CSD\oneDrive\onenote_weeklybackup  finish  '+(get-date -f hh:mm:ss)  | out-file -FilePath $logfile -Append

# (1) (2) 先執行ONENOTE 至 備份oneDrive 之中
#------------------------------------------------------------------------------------------------

$f33onenotebackup      ="X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\mydataII\onenotebackup"
$f33onenotebackupmydate="X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\mydataII\onenotebackup\mydata"

dir  $f33onenotebackup  | out-file -FilePath $logfile -Append  #  ii $logfile  增加此確認是否可以讀取子目錄  sep.21.2015+ ri $logfile

ri $f33onenotebackup –Recurse -Force -Confirm:$false  #  ii X:\mydataII\
cpi -Path C:\onenote -Destination $f33onenotebackup –Recurse -Force  # 

"(3) copy C:\onenote\  to  $f33onenotebackup  finish " +(get-date -f hh:mm:ss)  | out-file -FilePath $logfile -Append  

$u=(((gi $f33onenotebackupmydate).LastAccessTime).Day).ToString() 

if ($u.length -ne 2) {$u='0'+ $u}

$r=$str.Substring(6,2)

if ($r -ne $u) # if Not today send email 
{
    Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -Subject "*** Ming Onenote PS1 backup failure -- $str -- 09:00PM/Monday at 29 Host  taskschd name :Mingbackup  " `
    -Body "  C:\PerfLogs\mingbackup.ps1 ; C:\onenote\   ;  X:\mydataII\onenotebackup failure  "
}


#------------------------------------------------------------------------------------------------
ii $logfile
ii C:\Users\administrator.CSD\oneDrive\download\PS1\
MD $f33mydata #ii $f33mydata

dir $f33mydata   | out-file -FilePath $logfile -Append  #  ii $logfile 增加此確認是否可以讀取子目錄  sep.21.2015+

rm C:\Users\administrator.CSD\oneDrive\download\PS1\mm2015 –Recurse -Force # add mm2015  Oct.1.2015+
Copy-Item -Path C:\Users\administrator.CSD\OneDrive\download\mm2015\ -Destination C:\Users\administrator.CSD\oneDrive\download\PS1\ –Recurse -Force  #  add mm2015  Oct.1.2015+

Copy-Item -Path C:\Users\administrator.CSD\oneDrive\download\PS1\* -Destination $f33mydata –Recurse -Force  #  

"(4) ci ps1  to  $f33mydata " +(get-date -f HH:mm:ss)  | out-file -FilePath $logfile -Append


#------------------------------------------------------------------------------------------------
#'(5) backup SQL_inventory
#if ((Get-Module sqlps) -eq $false){  Import-Module sqlps -DisableNameChecking  }
$tsql_backup=@"
backup database sql_inventory to disk='$f33dbbackup'
"@
#invoke-sqlcmd 

 $p=gwmi Win32_LogicalDisk  -Credential $credential -ComputerName PMD2016 -Filter "DriveType=3" | `
select Name, FileSystem,FreeSpace,BlockSize,Size  | % {$_.BlockSize= 
(($_.FreeSpace)/($_.Size))*100;$_.FreeSpace=($_.FreeSpace/1GB);$_.Size=($_.Size/1GB);$_} `
 | Format-Table Name, @{n='FS';e={$_.FileSystem}},@{n='Free, Gb';e={'{0:N2}'-f `
$_.FreeSpace}}, @{n='Free,%';e={'{0:N2}'-f $_.BlockSize}},@{n='Capacity ,Gb';e={'{0:N3}' `
-f $_.Size}} -AutoSize
$p=$p |out-string

$r=gwmi Win32_LogicalDisk -ComputerName  $env:computername -Filter "DriveType=3" | `
select Name, FileSystem,FreeSpace,BlockSize,Size  | % {$_.BlockSize= 
(($_.FreeSpace)/($_.Size))*100;$_.FreeSpace=($_.FreeSpace/1GB);$_.Size=($_.Size/1GB);$_} `
 | Format-Table Name, @{n='FS';e={$_.FileSystem}},@{n='Free, Gb';e={'{0:N2}'-f `
$_.FreeSpace}}, @{n='Free,%';e={'{0:N2}'-f $_.BlockSize}},@{n='Capacity ,Gb';e={'{0:N3}' `
-f $_.Size}} -AutoSize
$r=$r |out-string

#Copy-Item -Path C:\onenote_20150528\onWorkLog -Destination C:\Users\administrator.CSD\SkyDrive\onWorkLog –Recurse -Force
#Copy-Item -Path C:\onenote_20150528\ -Destination H:\temp\ –Recurse -Force
#ri H:\temp\onenote_20150528 

#------------------------------------------------------------------------------------------------
if ((Test-path $f33mydata ) -eq $false)
{
Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -Subject "*** Ming Onenote PS1 backup failure -- $str -- 09:00PM/Monday at 29Host  taskschd name :Mingbackup  " `
    -Body "  C:\PerfLogs\mingbackup.ps1 line 135 ; $f33mydata  ;  X:\mydataII\onenote_weeklybackup  failure  " -Attachments $logfile

}
else
{
    
Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' -Attachments $logfile `
    -Subject "Ming Onenote PS1 backup OK -- $str -- taskschd name :Mingbackup 09:00PM/Monday at 29Host  " `
-Body  @"
$env:computername 
$r
------
PM2016(33)
$p
------

    
"@

start-sleep -s 10
 ri $logfile

}

}




#---------------------------------------------------------------
#  171   mingbackupfile  F1 to F2(33)
#---------------------------------------------------------------
powershell_ise C:\PerfLogs\mingbackupfile.ps1
<#

F1  to  F2

C:\PerfLogs\mingbackupfile.ps1
taskschd.msc
CreateDate: Aug.25.2015LastDate : Author :Ming Tseng  ,a0921887912@gmail.comremark taskschd.msc
email backup

$ps1fS=gi C:\Users\administrator.CSD\SkyDrive\download\PS1\OS00_Index.ps1
$ps1fS=gi C:\Users\Chao_Ming\OneDrive\download\PS1\OS00_Index.ps1  #s21
$ps1fS=gi C:\PerfLogs\mingbackupfile  # 29

foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname=$ps1f.name
    $ps1fFullname=$ps1f.FullName 
    $ps1flastwritetime=$ps1f.LastWriteTime
    $getdagte= get-date -format yyyyMMdd
    $ps1length=$ps1f.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length "  -Body "  ps1source from:me $ps1fname   " 
}


F1
   55  34:software
105    61:software2015
156  61:mydata
206  61:mydateII
258  29:worklog
311  29:RFP
363  29:micorosoft
416  29:Proposal

F2

compare F1 copy F2   
#>


gps -Name powershell | ?  id -ne  $pid  |Stop-Process


$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "PMOCSD\infra1",$secpasswd

#get-psdrive
if ( (Test-Path X:\)  -eq $False) { New-PSDrive -Name X -PSProvider FileSystem -Root "\\192.168.112.144\d$" -Credential $credential -Persist }
#Net use * /delete /y


if ( (Test-Path X:\)  -eq $False) { Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
     -Subject " mingbackupfileF1toF2 -- PSDrive X error           --  29   C:\PerfLogs\mingbackupfile.ps1 "   `
     -Body "   sp2013  29   C:\PerfLogs\mingbackupfile.ps1   line:62     " }



$repfile ='c:\temp\mingbackupfile.txt' ; #ii $repfile

  function refilename ($foldername){
$FS=(Get-ChildItem $foldername -recurse -force)

foreach ($F in $FS)
{
       if ((($F.name).contains("[")) -eq $true )
  {
      $OF=$F.FullName;$OF
      $NF=$F.Name
      $NF=$NF.Replace('[','(')
      $NF=$NF.Replace(']',')')
      #$NF=$F.DirectoryName+'\'+$NF
      $NF

  # Rename $OF $NF
   $command = " CMD.EXE /C  Rename '$OF'    '$NF' "

   $command

Invoke-Expression -Command $command 
  }

   
}#foreach

    
}

#refilename '\\192.168.112.129\H$\mydata'
#refilename '\\192.168.112.129\H$\mydataII'
#refilename 'H:\Proposal'
#refilename 'H:\RFP'
#refilename 'H:\worklog'
#refilename  '\\192.168.112.123\c$\software' 

#refilename H:\mydata

function F1toF2 ($Folder1, $Folder2){  #  525 function
   #$Folder1  ='\\192.168.112.129\H$\mydata' 
   #$Folder2  ='X:\mydata'
$nowdate= Get-Date -Format 'yyyy-MM-dd HH:mm:ss'    
 "--------------------- $Folder2 ------------" | out-file  $repfile -Append -Encoding unicode -Width 160

$Folder1fS=Get-ChildItem $Folder1 -recurse -force ; ##$Folder1fS.Count
foreach ($Folder1f in $Folder1fS) {# 18 處理目錄 check Folder
    if ($Folder1f.PSIsContainer -eq $true){ # 17 folder YES
       $f1f =$Folder1f.FullName ; #$f1f
       $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f
       if ( (test-path $f2f) -eq $false){ # 21 if folder is null
       $nowdate + '- new folder--' + $f2f  | out-file  $repfile -Append -Encoding unicode -Width 160
        mkdir $f2f |out-null
      }  # 21 if folder is null   
     }  # 17 folder YES
}# 18 處理目錄 check Folder
#$i=$Folder1fS.count
foreach ($Folder1f in $Folder1fS){ # 33 處理檔案  check File

 if ($Folder1f.PSIsContainer -eq $false){ # 31 IS file

 $f1f =$Folder1f.FullName ;# $f1f
 $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f

 if ((test-path $f2f) -eq $false) {
       #  $i.ToString()+" cp $f1f -destination $f2f -Force" #|out-file $repfile -Append
      
      $nowdate +'-new file--'+ $f2f  | out-file  $repfile -Append -Encoding unicode -Width 160      
      Copy-Item $f1f -destination $f2f -Force 
  }# 假如folder2 沒有,則直接copy
  else{
      $df=gi $f2f -Force
      if ($Folder1f.LastWriteTime -gt $df.LastWriteTime)
        {
        #$i.ToString()+' -> '+$f1f+'   ==== ' + $Folder1f.LastWriteTime |out-file $repfile -Append
        # '               -> '+$f2f+'   ==== ' + $df.LastWriteTime |out-file $repfile -Append
        $nowdate +'-update file--'+ $f2f  | out-file  $repfile -Append -Encoding unicode -Width 160     
         Copy-Item $f1f -destination $f2f -Force 
      } 
  }#假如folder2 有,則比較如是較晚日期.也copy
  #$i;$i=$i-1;"f1tof2 -"+$f1f
        } # 31 IS file 
    } # 33 處理檔案  check File
}  #  525 function

$f33Microsoft ="X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\Microsoft"
$f33software  ="X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\software"
$f33mydataII  ="X:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\mydataII"

#ii $f33mydataII
#ii 'X:\software'

F1toF2 H:\Microsoft $f33Microsoft
F1toF2 '\\192.168.112.129\H$\mydata'   X:\mydata
F1toF2 '\\192.168.112.129\H$\mydataII' $f33mydataII
F1toF2 H:\Proposal X:\Proposal
F1toF2 H:\RFP X:\RFP
#F1toF2 '\\192.168.112.123\c$\software' $f33software  # only in 690303@syscom
F1toF2 '\\192.168.112.129\H$\software2015' 'X:\software2015'
F1toF2 H:\worklog X:\worklog


$newdate=get-date -format 'yyyy-MM-dd HH:mm:ss'

   Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
     -Subject " mingbackupfileF1toF2 -- $newdate      -- F1 to F2  @ 29           --   C:\PerfLogs\mingbackupfile.ps1 "   -attachment $repfile  `
     -Body "   Friday 20:00 each week , schedule mingbackupfile run at sp2013        F1 to F2         "

## 
Start-Sleep 10 
 ri $repfile
#  ii $repfile



#---------------------------------------------------------------
# 337  mingbackuDB 
#---------------------------------------------------------------
{<#
{<#
#  216   C:\PerfLogs\mingbackupDB.ps1

C:\PerfLogs\mingbackupDB.ps1

taskschd.msc

#>}
if ((Get-Module sqlps) -eq $null){ Import-Module sqlps -DisableNameChecking }

$pmdF ='\\PMD2016\Backup\SQL_Inventory_'+(get-date -Format yyyyMMdd)+'.bak'

$tsql_backup=@"
backup database sql_inventory to disk = '$pmdF'
"@
#$tsql_backup
Invoke-Sqlcmd -ServerInstance '192.168.112.144' -Query $tsql_backup -Username sa -Password 'p@ssw0rd' -QueryTimeout 1200

start-sleep 10

$tsql_restore=@"
RESTORE DATABASE SQL_inventory
   FROM Disk ='$pmdF'
   WITH RECOVERY ,Replace , 
      MOVE 'SQL_inventory'      TO 'H:\SQLData\SQL_inventory.mdf', 
      MOVE 'SQL_inventory_log'  TO 'C:\SQLLog\SQL_inventory_log.ldf';
"@
Invoke-Sqlcmd -ServerInstance sql2012x -Query $tsql_restore  -QueryTimeout 2400

start-sleep 10

$sql2012F ='H:\mydataII\SQLDBbackup\SQL_Inventory_'+(get-date -Format yyyyMMdd)+'.bak'
$tsql_backup2=@"
backup database sql_inventory to disk='$sql2012F'
"@
#$tsql_backup2
Invoke-Sqlcmd -ServerInstance $env:COMPUTERNAME -Query $tsql_backup2 -QueryTimeout 2400


#>}




#---------------------------------------------------------------
# # 434   mingbackupfile  F2 to F3
#---------------------------------------------------------------




#---------------------------------------------------------------
# 
#---------------------------------------------------------------