<#-----------------------------------
#  text   OS07_file

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS07_file.ps1

#Date:  Dec.05.2013
#last update :  Jan.05.2016

#author: a0921887912@gmail.com
$subject  : hostname/node1  ,

(1) file create , edit , format, delete
(2)Format-Wide, Format-List, Format-Table, and Format-Custom
(3)
(4)

Use Windows PowerShell to Monitor System Performance
get-counter  outfile
Using Format Commands to Change Output View
PowerShell Script to save System, Application, Security event viewer logs from various servers into a CSV file

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS07_file.ps1

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




#   50 out-file
#  66    Using Format Commands to Change Output View
#  90    PowerShell Script to save System, Application, Security event viewer logs from various servers into a CSV file
#  200   mail all ps1 source to my Gmail 
#  200   Get disk FreeSpace & Size
#  212   compare two folder then copy difference
#  255   copy jpg * to folder by yyyyMMdd
#  300   merge two folder then copy difference by LastWriteTime
#  338   C:\PerfLogs\mingbackup.ps1
#  557   Backup Ming data to LOG @database
#  599   edit save  to file
#  613   remove folder if no any file
#  752   compare 2 Folder result to file
#  1006  save to excel xls xlsx csv  export-csv
#  1077  ConvertTo-Csv   ConvertFrom-Csv
#  1106  Import-Csv  ipcsv
#  1129  foreach string  to CSV 
#  1175   save folder data to csv (inclue directory and file )
#  1292   CSV to excel  xls  xlsx
#  1309   CSV to sql table 
#  1397  photo  CSV to sql table   + folderlocation
#  1535  Get filePhotoLists  copy jpg to filephotopath ( familyPhoto)
#  1851  Familyphoto all folder properties to DB  FolderPhotoGroupS Table   
#  1873  Explore Structure of an XML Document
#  2104  excel xlsx  xls    to CSV
#  2153  Get File to Table
#  2475  make mp3 filename
#   2539  get file path & file name
#   2551  edit MP3 tags





#--------------------------------------------
#   50 out-file
#--------------------------------------------

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  > D:\perfmon\sample1.csv
Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -SampleInterval 2 -MaxSamples 6  |out-file D:\perfmon\sampletxt.txt  -Append



Get-Content D:\perfmon\sampletxt.txt | ? { $_ -ne '' } >  D:\perfmon\sampletxt2.txt
$text = (Get-Content D:\perfmon\input.txt) -join "`r`n"
($text | Select-String '(?s)(?<=Text : \{)(.+?)(?=\})' -AllMatches).Matches | % { $text = $text.Replace($_.Value, ($_.Value -split "`r`n" | % { $_.Trim() }) -join " ")}
$text | Set-Content D:\perfmon\output.txt


#--------------------------------------------
#  66 Using Format Commands to Change Output View
#--------------------------------------------

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous   |fl -Property *

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  |ft -Property   Timestamp,Reading  -AutoSize  -HideTableHeaders

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  |ft   -HideTableHeaders


Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous  |ft   -HideTableHeaders -GroupBy Reading

Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec' -Continuous   | Format-Wide  -Property Timestamp


Get-Command Format-Wide -Property Name -Column 1

$x=  Get-Counter  '\\sp2013\PhysicalDisk(1 d:)\Disk Bytes/sec'  -SampleInterval 2 -MaxSamples 4 
$X |ft -HideTableHeaders
$x |gm |select Definition,name


#--------------------------------------------
#  90 PowerShell Script to save System, Application, Security event viewer logs from various servers into a CSV file
#--------------------------------------------

$objExcel = New-Object -comobject Excel.Application
$objExcel.visible = $True  # 打開excel
$objWorkbook = $objExcel.Workbooks.Add()  #增加 Excel workbooks you can see sheet1, sheet2 , sheet3..
$objSheet = $objWorkbook.Worksheets.Item(1)  # 指定第一頁 $objSheet = $objWorkbook.Worksheets.Item(2) 


 #insert column headings  <method1>
$objSheet.Cells.Item(1,1) = "Server"  
$objSheet.Cells.Item(1,2) = "LogName"  # 
$objSheet.Cells.Item(1,3) = "Time"
$objSheet.Cells.Item(1,4) = "Source"
$objSheet.Cells.Item(1,5) = "Message"

#insert column headings  <method2>
$row=3
$col=1
"Name", "Description", "OperatingSystem", "CPUCount","Memory (GB)", "Status", "Hostname" | % {
$objSheet.Cells.item($row,$col)=$_
$objSheet.Cells.item($row,$col).font.bold=$True
$col++
}


$objSheetFormat = $objSheet.UsedRange  # 設定使用過的區域
$objSheetFormat.Interior.ColorIndex = 19  #background color
$objSheetFormat.Font.ColorIndex = 11   #font color
$objSheetFormat.Font.Bold = $True    # Font Bold

$row = 1

$objSheetFormat = $objSheet.UsedRange
$objSheetFormat.EntireColumn.AutoFit()
$objSheetFormat.RowHeight = 15




$filepath='H:\scripts\'+(get-date -Format yyyyMMddhhmm).ToString()
if ($filepath) {
$objWorkbook.SaveAs("$filepath")+".xlsx"

}




<#
$servers ="sp2013","",""

foreach ($server in $servers)
{
  $row = $row + 1
  $AppLog = Get-EventLog -LogName Application -EntryType Error -computer $server -Newest 5
  $SecLog = Get-EventLog -LogName Security -EntryType Error -computer $server -Newest 5 -ea Silentlycontinue
  $SysLog = Get-EventLog -LogName System -EntryType Error -computer $server -Newest 5
  foreach ($Cat in $AppLog,$Syslog,$Seclog)
  {
    if ($cat -is [array])
    {
      if ($AppLog -contains $cat[0]) {$Catname = "Application"}
      if ($SecLog -contains $cat[0]) {$Catname = "Security"}
      if ($SysLog -contains $cat[0]) {$Catname = "System"}
      Foreach ($event in $cat)
      {
        $objSheet.Cells.Item($row,1).Font.Bold = $True
        $objSheet.Cells.Item($row,1) = $server
        $objSheet.Cells.Item($row,2) = $Catname
        $objSheet.Cells.Item($row,3) = $Event.TimeGenerated
        $objSheet.Cells.Item($row,4) = $Event.Source
        $objSheet.Cells.Item($row,5) = $Event.Message
        $row = $row + 1
      }
    }
  }
}
#>



#--------------------------------------------
#  200  mail all ps1 source to my Gmail 
#--------------------------------------------
$ps1fS=gi C:\Users\administrator.CSD\SkyDrive\download\PS1\*.ps1
$ps1S.Count
foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname=$ps1f.name
    $ps1fFullname=$ps1f.FullName 
    $ps1flastwritetime=$ps1f.LastWriteTime
    $getdagte= get-date -format yyyyMMdd

     Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
   -attachment $ps1fFullname  -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime"  -Body ' ' 
}

#--------------------------------------------
#  200   Get disk FreeSpace & Size
#--------------------------------------------


gwmi Win32_LogicalDisk -ComputerName  $env:computername -Filter "DriveType=3" | `
select Name, FileSystem,FreeSpace,BlockSize,Size  | % {$_.BlockSize= 
(($_.FreeSpace)/($_.Size))*100;$_.FreeSpace=($_.FreeSpace/1GB);$_.Size=($_.Size/1GB);$_} `
 | Format-Table Name, @{n='FS';e={$_.FileSystem}},@{n='Free, Gb';e={'{0:N2}'-f `
$_.FreeSpace}}, @{n='Free,%';e={'{0:N2}'-f $_.BlockSize}},@{n='Capacity ,Gb';e={'{0:N3}' `
-f $_.Size}} -AutoSize



$disk = Get-WmiObject Win32_LogicalDisk -ComputerName  $env:computername -Filter "DeviceID='C:'" |Select-Object Size,FreeSpace

$disk.Size
$disk.FreeSpace





#--------------------------------------------
# 212  compare two folder then copy difference 
#--------------------------------------------

$sourcepath     ='H:\temp\a'  #$sourcepath.Replace("H:\temp\a", "\\172.16.220.61\h$\temp\a")
$destinationPath='\\172.16.220.61\h$\temp\a'

$srcfileSf=Get-ChildItem $sourcepath -recurse
$dstfileSf=Get-ChildItem $destinationPath -recurse

#$srcfileS=Compare-Object -ReferenceObject $srcfileSf -DifferenceObject $dstfileSf
$i=$srcfileSf.count
foreach ($srcfile in $srcfileSf)
{
  $sf=$srcfile.FullName
  $dfx=$srcfile.FullName.Replace($sourcepath, $destinationPath)
  

  #if ((test-path $dfx) -eq $false) {
  if (!(test-path $dfx)) {
      Copy-Item $sf -destination $dfx -Force 
  }
  else{
      $df=gi $dfx
      if ($srcfile.LastWriteTime -gt $df.LastWriteTime)
        {
         Copy-Item $sf -destination $dfx -Force 
      }
  }


  $i;$i=$i-1

    #$srcfile |select name,LastWriteTime,FullName,Directory 
    #$srcfile |select *
    #$srcfileDirectory=$srcfile.Directory ;$srcfileDirectory
   
}






#---------------------------------------------------------
#   255  copy jpg * to folder by yyyyMMdd
#---------------------------------------------------------
$sourcepath     ='D:\a'  #$sourcepath.Replace("H:\temp\a", "\\172.16.220.61\h$\temp\a")
$sourcepath     ='e:\a'  #$sourcepath.Replace("H:\temp\a", "\\172.16.220.61\h$\temp\a")
$destinationPath='e:\b'

$srcfileSf= Get-ChildItem $sourcepath      -recurse
$dstfileSf= Get-ChildItem $destinationPath -recurse


$i=$srcfileSf.count


foreach ($srcfile in $srcfileSf)
{
if ($srcfile.Attributes -NE 'Directory')
{
$i;
  $srcfile.FullName
  $sf=$srcfile.LastWriteTime;
  #$sf.Year
  #$sf.Month
  #$sf.Day
  $dfdir=$destinationPath+'\'+$sf.Year+'\'+$sf.Month+'\'
  $dfpath=$destinationPath+'\'+$sf.Year+'\'+$sf.Month+'\'+$srcfile.Name
  #$dfpath

  if ( (test-path $dfdir) -eq $false)
  {
      mkdir $dfdir
  }
  $sf.DateTime
  $dfpath
  cpi $srcfile.FullName -destination $dfpath -Force 

    $i=$i-1
    }
}


$x=

Get-ChildItem 'e:\b'  -recurse   ;$x.count

#--------------------------------------------------------------------------
# 300  merge two folder then copy difference by LastWriteTime  Jul.29.2015
#--------------------------------------------------------------------------
# 先執行 613  remove folder if no any file, 清除 empty folder 
#{<#

$Folder1     ='\\172.16.220.33\f$\worklog' 
$Folder2     ='\\172.16.220.33\f$\worklog_20130508Y'
$repfile     ='H:\report.txt '
$repfile2     ='H:\report2.txt '

#$Folder1     ='H:\worklog\kmuh' 
#$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
#$repfile     ='H:\report.txt '
#$repfile2     ='H:\report2.txt '

#----------------------------------------------------------------------------------------------------------list folder 1 compart to folder2 
$Folder1fS=Get-ChildItem $Folder1 -recurse;# $Folder1fS.Count


foreach ($Folder1f in $Folder1fS) {# 18 處理目錄 check Folder
    if ($Folder1f.PSIsContainer -eq $true){ # 17 folder YES
       $f1f =$Folder1f.FullName ; #$f1f
       $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f
       if ( (test-path $f2f) -eq $false){ # 21 if folder is null
        mkdir $f2f
      }  # 21 if folder is null
     }  # 17 folder YES
}# 18 處理目錄 check Folder


 $i=$Folder1fS.count
foreach ($Folder1f in $Folder1fS){ # 33 處理檔案  check File


 if ($Folder1f.PSIsContainer -eq $false){ # 31 IS file

 $f1f =$Folder1f.FullName ;# $f1f
 $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f


 if ((test-path $f2f) -eq $false) {
         $i.ToString()+" cp $f1f -destination $f2f -Force" |out-file $repfile -Append
  
      Copy-Item $f1f -destination $f2f -Force 
  }# 假如folder2 沒有,則直接copy
  else{
      $df=gi $f2f
      if ($Folder1f.LastWriteTime -gt $df.LastWriteTime)
        {
        $i.ToString()+' -> '+$f1f+'   ==== ' + $Folder1f.LastWriteTime |out-file $repfile -Append
         '               -> '+$f2f+'   ==== ' + $df.LastWriteTime |out-file $repfile -Append

         Copy-Item $f1f -destination $f2f -Force 
      } 
  }#假如folder2 有,則比較如是較晚日期.也copy
  $i;$i=$i-1;"f1tof2 -"+$f1f
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

start-sleep 60
#----------------------------------------------------------------------------------------------------------ri  Folder2fS is null

$Folder2fS=Get-ChildItem $Folder2 -recurse; #$Folder2fS.Count
foreach ($Folder2f in $Folder2fS){
 if ($Folder2f.PSIsContainer -eq $true){
      if (( Get-ChildItem   $Folder2f.FullName).count  -eq 0 ) {
           ri  $Folder2f.FullName 
      }}# ri 
}

start-sleep 60
#----------------------------------------------------------------------------------------------------------ri Folder1fS is null
$Folder1fS=Get-ChildItem $Folder1 -recurse; #$Folder1fS.Count
foreach ($Folder1f in $Folder1fS){
 if ($Folder1f.PSIsContainer -eq $true){
     #$Folder1f.FullName 
      if (( Get-ChildItem   $Folder1f.FullName).count  -eq 0 ) {
           ri  $Folder1f.FullName 
      }}# ri 
}
$Folder1fS=Get-ChildItem $Folder1 -recurse; 'F1 total= '+$Folder1fS.Count

$Folder2fS=Get-ChildItem $Folder2 -recurse; 'F2 total= '+$Folder2fS.Count
#----------------------------------------------------------------------------------------------------------check
<#
$Folder1fS=Get-ChildItem $Folder1 -recurse; $Folder1fS.Count
$i=$Folder1fS.count

foreach ($Folder1f in $Folder1fS){
 
 $f1f =$Folder1f.FullName ;# $f1f
 $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f
 if ((test-path $f2f) -eq $false) {
         $i.ToString()+" cp $f1f -destination $f2f -Force" |out-file $repfile2 -Append  
  }# 假如folder2 沒有,則直接copy
  else{
      $df=gi $f2f
      if ($Folder1f.LastWriteTime -gt $df.LastWriteTime)
        {
        $i.ToString()+' ->        '+$f1f+'   ==== ' + $Folder1f.LastWriteTime |out-file $repfile2 -Append
         '  -> '+$f2f+'   ==== ' + $df.LastWriteTime |out-file $repfile2 -Append
        '      '|out-file $repfile2 -Append
      } 
  }#假如folder2 有,則比較如是較晚日期.也copy
  $i;$i=$i-1
    #$srcfile |select name,LastWriteTime,FullName,Directory 
    #$srcfile |select *
    #$srcfileDirectory=$srcfile.Directory ;$srcfileDirectory
}
#>

#>}
#--------------------------------------------------------------------------
#  338  C:\PerfLogs\mingbackup.ps1
#--------------------------------------------------------------------------
<#
C:\PerfLogs\mingbackup.ps1
date: Jul.172015
author : Ming Tseng
taskschd.msc
#>

$secpasswd = ConvertTo-SecureString "p@ssw0rd1" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "PMD\administrator",$secpasswd

if ((Test-Path -Path C:\Users\administrator.CSD\SkyDrive\onenote_20150528) -eq $True)
{
    

ri C:\Users\administrator.CSD\SkyDrive\onenote_20150528  –Recurse -Force 
ri \\172.16.220.33\f$\mydataII\onenote_20150528  –Recurse -Force 

$str=get-date -Format yyyyMMdd
$f33mydata='\\172.16.220.33\f$\mydataII\pS1_'+$str
start-sleep 5

Copy-Item -Path C:\onenote_20150528\ -Destination C:\Users\administrator.CSD\SkyDrive\ –Recurse -Force

Copy-Item -Path C:\onenote_20150528\ -Destination \\172.16.220.33\f$\mydataII –Recurse -Force

Copy-Item -Path C:\Users\administrator.CSD\SkyDrive\download\PS1 -Destination $f33mydata –Recurse -Force

 

 $p=gwmi Win32_LogicalDisk  -Credential $credential -ComputerName PM001 -Filter "DriveType=3" | `
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

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To 'a0921887912@gmail.com' -from 'a0921887912@gmail.com' `
    -Subject "Ming Onenote PS1 backup OK -- $str -- taskschd name :MingOnenotePS1_week_backup 12:00PM " `
-Body  @"
$env:computername 
$r
------
PM001(33)
$p
------
<#
C:\PerfLogs\mingbackup.ps1
date: Jul.172015
author : Ming Tseng
taskschd.msc
#>

`$secpasswd = ConvertTo-SecureString "p@ssw0rd1" -AsPlainText -Force
`$credential = New-Object System.Management.Automation.PSCredential "PMD\administrator",`$secpasswd

if ((Test-Path -Path C:\Users\administrator.CSD\SkyDrive\onenote_20150528) -eq `$True)
{
    

ri C:\Users\administrator.CSD\SkyDrive\onenote_20150528  –Recurse -Force 
ri \\172.16.220.33\f$\mydataII\onenote_20150528  –Recurse -Force 

`$str=get-date -Format yyyyMMdd
`$f33mydata='\\172.16.220.33\f$\mydataII\pS1_'+`$str
start-sleep 5

Copy-Item -Path C:\onenote_20150528\ -Destination C:\Users\administrator.CSD\SkyDrive\ –Recurse -Force

Copy-Item -Path C:\onenote_20150528\ -Destination \\172.16.220.33\f$\mydataII –Recurse -Force

Copy-Item -Path C:\Users\administrator.CSD\SkyDrive\download\PS1 -Destination `$f33mydata –Recurse -Force

 

 `$p=gwmi Win32_LogicalDisk  -Credential `$credential -ComputerName PM001 -Filter "DriveType=3" | `
select Name, FileSystem,FreeSpace,BlockSize,Size  | % {$_.BlockSize= 
(($_.FreeSpace)/($_.Size))*100;$_.FreeSpace=($_.FreeSpace/1GB);$_.Size=($_.Size/1GB);$_} `
 | Format-Table Name, @{n='FS';e={$_.FileSystem}},@{n='Free, Gb';e={'{0:N2}'-f `
$_.FreeSpace}}, @{n='Free,%';e={'{0:N2}'-f $_.BlockSize}},@{n='Capacity ,Gb';e={'{0:N3}' `
-f $_.Size}} -AutoSize
`$p=`$p |out-string

`$r=gwmi Win32_LogicalDisk -ComputerName  `$env:computername -Filter "DriveType=3" | `
select Name, FileSystem,FreeSpace,BlockSize,Size  | % {`$_.BlockSize= 
((`$_.FreeSpace)/(`$_.Size))*100;`$_.FreeSpace=(`$_.FreeSpace/1GB);`$_.Size=(`$_.Size/1GB);`$_} `
 | Format-Table Name, @{n='FS';e={`$_.FileSystem}},@{n='Free, Gb';e={'{0:N2}'-f `
`$_.FreeSpace}}, @{n='Free,%';e={'{0:N2}'-f `$_.BlockSize}},@{n='Capacity ,Gb';e={'{0:N3}' `
-f `$_.Size}} -AutoSize
`$r=`$r |out-string
    
"@


}


#--------------------------------------------------------------------------
# 557  Backup Ming data  LOG @database   Jul.29.2015
#--------------------------------------------------------------------------
<#
USE [SQL_Inventory]
GO
CREATE TABLE [dbo].[FolderGroupS](
	[folderGroup] [nvarchar](50) NOT NULL,
	[folderowner] [varchar](128) NULL,
	[remark] [nvarchar](250) NULL,
	[folderSize] [int] NULL,
	[ONOFF] [nvarchar](10) NULL,
	[modifydate] [date] NULL
) ON [PRIMARY]

GO
USE [SQL_Inventory]
GO

/****** Object:  Table [dbo].[FolderBackupLOG]    Script Date: 7/31/2015 1:43:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FolderBackupLOG](
	[folderGroup] [nvarchar](50) NULL,
	[folderName] [nvarchar](255) NOT NULL,
	[createdate] [date] NOT NULL,
	[filecount] [int] NULL,
	[subFoldercount] [int] NULL,
	[folderSize] [nvarchar](10) NULL,
	[ONOFF] [nvarchar](10) NULL,
	[folderlevel] [nvarchar](10) NULL,
	[modifydate] [date] NOT NULL,
 CONSTRAINT [PK_FolderBackupLOG] PRIMARY KEY CLUSTERED 
(
	[folderName] ASC,
	[createdate] ASC,
	[modifydate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO




INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('cloud','cloud','1')
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Family','Family','1')
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Microsoft','Microsoft','1')
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Movie','Movie','1')
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Mydata','Mydata','1')
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('MydataII','存放onenote PS1','1') 
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Product','Product','1')
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Proposal','Proposal','1') 
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('RFP','RFP','1')        
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('Software','Software','1')        
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('TV','TV','1')        
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('WorkLog','WorkLog','1')        
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('GoogleDrive','GoogleDrive','1')        
INSERT INTO [dbo].[folderGroupS] (folderGroup,remark,ONOFF ) VALUES ('GoolgeDriveBackup','GoolgeDriveBackup','1')        
#>

# step 1  relist X2000  worklog, worklog20130508Y, 

# step  copy Y to X2000 : Microsoft, mydata , mydataII, Proposal ,RFP , Product fee
# step sync

# get info to FileBackup


use  SQL_Inventory

select folderlevel,foldername,filecount,subFoldercount,foldersize
 from [dbo].[FolderBackupLOG] 
 where 
 --folderlevel='2' --or folderlevel='3' 
 --and
  folderGroup='software'
 --and
 --filecount=0
 -- and
 -- subfoldercount=0


 order by folderName

--select distinct folderGroup from [dbo].[FolderBackupLOG] 


 --delete from [FolderBackupLOG] where folderGroup='Proposal'
--drop table [FolderBackupLOG]
--truncate table [FolderBackupLOG]

select folderGroup, sum(TRY_CONVERT(float,foldersize)) as size ,sum(subFoldercount) as subfolder ,sum(filecount) as filecount
from [FolderBackupLOG]
where folderlevel='2'
group by folderGroup



# SQL table to Excel 
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
     if ( (test-path $Getfolder ) -eq $true)
   {  #  687 防止此disk 沒有此folder

   $FolderfS=gci $Getfolder -recurse -Force; $FolderfS.Count

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
   $Getfolder=$GetfolderM+"\$cfolders" ;# $Getfolder
   #$f1f =$Getfolder.FullName ; $f1f
       $subFoldercount=(folderproperites $Getfolder)[0]
       $filecount     =(folderproperites $Getfolder)[1]
       $folderSize    =(folderproperites $Getfolder)[2]
       $folderName    =$Getfolder.Substring(18,$Getfolder.Length-18)

       #$folderName ="abd' s"

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

#--------------------------------------------------------------------------
#  599 edit save  to file
#--------------------------------------------------------------------------

$filename="H:\scripts\time_"+ (get-date -Format yyyyMMdd-HHmm).ToString() +  ".ps1" $filedest='\\sql2012x\C$\PerfLogs\1.ps1'$y=123$Filecontent={<#a0921887912#>$t1=get-date;$t1$x='+$y+'$a=gps -name "*sql*"}cd c:\$Filecontent |  Out-File  $filedest -Width 160 -force
Get-Content  $filename
$Filecontent |  Out-File  $filedest  -force

Test-Path $filedest  

Copy-Item $filename -Destination $filedest -force
Remove-Item $filedest  -force

#--------------------------------------------------------------------------
# 613  remove folder if no any file    Jul.30.2015
#--------------------------------------------------------------------------
#清除至總數為一致!
$Folder2     ='\\172.16.220.33\f$\RFP'
$Folder2     ='\\172.16.220.33\f$\worklog'
$Folder2     ='\\172.16.220.33\f$\mydata'
$Folder2     ='\\172.16.220.33\f$\mydataII'
$Folder2     ='\\172.16.220.33\f$\software'
$Folder2     ='\\172.16.220.33\f$\proposal'
$Folder2     ='\\172.16.220.33\f$\microsoft_20150803'

$x=0;
do
{
    $Folder2fS=Get-ChildItem $Folder2 -recurse; $Folder2fS.Count
foreach ($Folder2f in $Folder2fS){
 if ($Folder2f.PSIsContainer -eq $true){

      if (( Get-ChildItem   $Folder2f.FullName).count  -eq 0 ) {
      $Folder2f.FullName |out-file H:\removeFolderList.txt -append 
           ri  $Folder2f.FullName -Force -Confirm:$false
      }}# ri 
}

$x=$x+1
}
until ($x -gt 3)


#--------------------------------------------------------------------------
# 752  compare 2 Folder result to file  Jul.31.2015
#--------------------------------------------------------------------------
#{<#
$Folder1     ='\\172.16.220.33\e$\Microsoft_20150803\' 
$Folder2     ='\\172.16.220.33\f$\Microsoft_20150817\'
$repfile     ='H:\report.txt'
$repfile2    ='H:\report2.txt'


$Folder1     ='H:\worklog\kmuh\x' 
$Folder2     ='H:\worklog20130508Y\KMUH_20141013\x'
$repfile     ='H:\report.txt '
$repfile2    ='H:\report2.txt '


ri  $repfile2 
  ' ++++++++++++++++++++F1++++++++++++++++++++++++++++++++++++++++++++++++++++++  ' |out-file $repfile2 -Append
#----------------------------------------------------------------------------------------------------------check F1 to F2

$Folder1fS=Get-ChildItem $Folder1 -recurse; $Folder1fS.Count
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




#>}

#--------------------------------------------------------------------------
# 1006  save to excel xls xlsx csv
#--------------------------------------------------------------------------
blogs.technet.com/b/heyscriptingguy/archive/2014/01/10/powershell-and-excel-fast-safe-and-reliable.aspx

 <#
 export-csv  epcsv
Parameter Set: Delimiter
Export-Csv [
[-Path] <String> ] [
[-Delimiter] <Char> ]   The default is a comma (,). Enter a character, such as a colon (:). To specify a semicolon (;), enclose it in quotation marks.
-InputObject <PSObject> 
[-Append] 
[-Encoding <String> {Unicode | UTF7 | UTF8 | ASCII | UTF32 | BigEndianUnicode | Default | OEM} ] 
[-Force] 
[-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] 
[-InformationVariable <System.String> ] 
[-LiteralPath <String> ] 
[-NoClobber]   Do not overwrite (replace the contents) of an existing file. By default, if a file exists in the specified path, Export-CSV overwrites the file without warning.
[-NoTypeInformation] 
[-Confirm] 
[-WhatIf] 
[ <CommonParameters>]

Parameter Set: UseCulture
Export-Csv 
[[-Path] <String> ] 
-InputObject <PSObject> 
[-Append] 
[-Encoding <String> {Unicode | UTF7 | UTF8 | ASCII | UTF32 | BigEndianUnicode | Default | OEM} ] 
[-Force] 
[-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] 
[-InformationVariable <System.String> ] 
[-LiteralPath <String> ] 
[-NoClobber] 
[-NoTypeInformation] 
[-UseCulture]   Use the list separator for the current culture as the item delimiter. The default is a comma (,).
 [-Confirm] 
 [-WhatIf]  Shows what would happen if the cmdlet runs. The cmdlet is not run.
 [ <CommonParameters>]
#>

get-process notepad | select-object basePriority,ID,SessionID,WorkingSet | export-csv -path c:\temp\data.csv

invoke-item c:\temp\data1.csv

Get-process | export-csv c:\temp\data.csv -Delimiter "," -force
Get-process | export-csv c:\temp\data.csv -UseCulture  -force
Get-process | export-csv c:\temp\data1.csv -NoTypeInformation  -force

Get-date | select-object –property DateTime, Day, DayOfWeek, DayOfYear | export-csv –path c:\temp\Date3.csv

gps | epcsv c:\temp\test.txt  #  ii  c:\temp\test.txt 
gps | epcsv c:\temp\test.txt -force -notype


$Outputstring = "dog","Cat","Mouse"

$OutputString | Export-Csv C:\temp\csvTest.csv 
ii C:\temp\csvTest.csv 


$objTable | Export-CSV $AttachmentPath
#-------------------------------------------------------------------------------------------------
#  1077  ConvertTo-Csv   ConvertFrom-Csv
#-------------------------------------------------------------------------------------------------
# converts objects into a series of comma-separated value (CSV) variable-length strings.

get-process notepad | convertto-csv -Delimiter ';'

get-eventlog -log "windows powershell" | convertto-csv -useculture

$date = get-date
convertto-csv -inputobject $date -delimiter ";" -notypeinformation

"DisplayHint";"DateTime"             ;"Date";"Day";"DayOfWeek";"DayOfYear";"Hour";"Kind";"Millisecond";"Minute";"Month";"Second";"Ticks";"TimeOfDay";"Year"

"DateTime";"2015年8月6日 上午 11:26:59";"2015/8/6 上午 12:00:00";"6";"Thursday";"218";"11";"Local";"233";"26";"8";"59";"635744572192339957";"11:26:59.2339957";"2015"

#-------------------------------------------------------------------------------------------------


$date = get-date | convertto-csv -delimiter ";"
convertfrom-csv -inputobject $date -delimiter ";"


$j = start-job -scriptblock { get-process } | convertto-csv
$header = "MoreData","StatusMessage","Location","Command","State","Finished","InstanceId","SessionId","Name","ChildJobs","Output","Error","Progress","Verbose","Debug","Warning","StateChanged"# Delete header from $j
$j = $j[0], $j[2..($j.count - 1)]
$j | convertfrom-csv -header $header

 
#-------------------------------------------------------------------------------------------------
#  1106  Import-Csv  ipcsv
#-------------------------------------------------------------------------------------------------

Parameter Set: Delimiter
Import-Csv [
[-Path] <String[]> ] 
[[-Delimiter] <Char> ] 
[-Encoding <String> {Unicode | UTF7 | UTF8 | ASCII | UTF32 | BigEndianUnicode | Default | OEM} ] 
[-Header <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] 
[-InformationVariable <System.String> ] 
[-LiteralPath <String[]> ] [ <CommonParameters>]

Parameter Set: UseCulture
Import-Csv [[-Path] <String[]> ] -UseCulture [-Encoding <String> {Unicode | UTF7 | UTF8 | ASCII | UTF32 | BigEndianUnicode | Default | OEM} ] [-Header <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-LiteralPath <String[]> ] [ <CommonParameters>]

get-process | export-csv c:\temp\processes.csv
$ps = Import-Csv c:\temp\processes.csv
foreach ($p in $ps)
{
$p.path
}
#--------------------------------------------------------------------------
# 1129   foreach string  to CSV   Aug.07.2015
#--------------------------------------------------------------------------

$Folder1     ='C:\software' 
$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
$repfile     ='c:\temp\temp5.txt'
$repfile2    ='c:\temp\temp5.csv'

if ( ((gps | ? Name -eq excel) -ne $null )){ stop-process -name excel -Force   };if (test-path $repfile2){ri $repfile2 -Force }

if (test-path $repfile ){ri $repfile -Force  }

$Folder1fS =Get-ChildItem $Folder1 -recurse;

foreach ($Folder1f in $Folder1fS) {# 18 處理目錄 check Folder
   if ($Folder1f.PSIsContainer -eq $false){ # 17 folder YES
       $f1f =$Folder1f.FullName ;# $f1f
       
     New-Object -TypeName PSObject -Property @{ FullName = $f1f ;'size MB' =( "{0:N2}" -f ($Folder1f.Length/ 1Mb)) } `
| Select-Object FullName,'size MB'  | Export-Csv -Path $repfile2 -Append  -NoTypeInformation

     }  # 17 folder YES
}# 18 處理目錄 check Folder

ii  $repfile2 




#--------------------------------------------------------------------------
# 1175    save folder data to csv (inclue directory and file ) Aug.07.2015
#--------------------------------------------------------------------------
#$Folder1     ='E:\Product20120329Y' 
#$Folder2     ='\\172.16.220.33\f$\Microsoft_20150803\'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '

$GetfolderM  ='C:' 
$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
$repfile     ='c:\temp\temp5.txt'
$repfile2    ='c:\temp\temp5.csv'
$getDs='microsoft','worklog','software'

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
$x=0
do{if ( ((gps | ? Name -eq excel) -ne $null )){ stop-process -name excel -Force   };if (test-path $repfile2){ri $repfile2 -Force }
 $x=$x+1
} until ($x -gt 2)



foreach ($getD in $getDs) {


$cfolders=$getD; #$cfolders
$Getfolder=$GetfolderM+"\$cfolders" ; 'R1-- '+$Getfolder
   
   #$Getfolder=$Getfolder+'\DGPA' ; $Getfolder
     if ( (test-path $Getfolder ) -eq $true)
   {  #  687 防止此disk 沒有此folder

       #$f1f=$Getfolder.FullName;'R2-- '+$f1f
       $subFoldercount=(folderproperites $Getfolder)[0]
       $filecount     =(folderproperites $Getfolder)[1]
       $folderSize    =(folderproperites $Getfolder)[2]
       $folderName    =$f1f.Substring(2,$Getfolder.Length-2)
       $folderName =$folderName.Replace('''','-')
       $folderlevel = '1'
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

 #--1294--temp9
 <## temp9
#  2
#
#$Folder1     ='E:\Product20120329Y' 
#$Folder2     ='\\172.16.220.33\f$\Microsoft_20150803\'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '
$t1=get-date
#$GetfolderM  ='C:\DCIM' #office
$GetfolderM  ='G:\Family2010821X' #home
#$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
#$ff= get-date -Format yyyyMMddmm

#$repfile     ='C:\temp\temp9.csv'#OFFICE
$repfile     ='G:\temp\temp9_2.csv' #home
#$repfile     ='C:\temp\temp9_'+$ff+'.txt' 
ri $repfile  
#$repfile     ='C:\temp\temp9_.csv'

#$repfile2    ='c:\temp\temp9.csv'
#$getDs='testphoto','worklog','software'
$getDs=gci $GetfolderM


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

'FileName;FilePhotoPath;FileLastWriteTime;FileOrgPath;FileExtension;FileSize;Filelength;modifydate;remark;ONOFF' | out-file -FilePath $repfile  -Append 
foreach ($getD in $getDs) {
$cfolders=$getD; #$cfolders
$Getfolder=$GetfolderM+"\$cfolders" ; 'R1-- '+$Getfolder
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
 #ii $repfile

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
#>#>

 #----temp9


#--------------------------------------------------------------------------
# 1292  CSV to excel  xls  xlsx   Aug.10.2015
#--------------------------------------------------------------------------
#{<#

$csvpath='c:\temp\temp.csv'
$xl=New-Object -com "Excel.Application" 
$wb=$xl.workbooks.open($csvpath)

$xlout=$csvpath.Replace('.csv','xlsx') 
$xlout='c:\temp\temp.xlsx'

$wb.SaveAs($xlOut,51) 
$xl.Quit()



#>}




#--------------------------------------------------------------------------
# 1309  CSV to sql table 
#--------------------------------------------------------------------------
<#


#>
#{<#

Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query "xtruncate table [dbo].[FilePhotoListS]"


$fPath = 'C:\temp\temp9_2015081241.txt'

$fPath = 'c:\temp\temp5.csv'

#$folderName ="C:\mydata\ebook\2013ebook\SharePoint 2013 User's Guide- 4th Edition.pdf"
ii $fPath
$ps = Import-Csv $fPath

foreach ($gc in $ps) {  #1353
$folderGroup     =$GC.FileName
$folderName      =$GC.folderName
$subFoldercount  =$GC.subFoldercount
$filecount       =$GC.檔案總數
[float]$folderSize      =$GC.folderSizeMB
$folderlevel     =$GC.folderlevel
$FAttributes     =$GC.Attributes
$modifydate      =get-date -Format yyyyMMdd

$folderName =$folderName.Replace('''','-')

$TSQL_insert=@"
INSERT INTO [dbo].[FileListS]
            ([folderGroup]
           ,[folderName]
           ,[subFoldercount]
           ,[filecount]
           ,[folderSize]
           ,[folderlevel]
           ,[FAttributes]
           ,[modifydate]
           ,[ONOFF])
     VALUES
           ('$folderGroup'
           ,'$folderName'
           ,'$subFoldercount'
           ,'$filecount'
           ,'$folderSize'
           ,'$folderlevel'
           ,'$FAttributes'
           ,'$modifydate'
           ,'1')
"@
$TSQL_insert
#Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query $TSQL_insert
} #1353


#>



#>}


#--------------------------------------------------------------------------
#  1397  photo  CSV to sql table   + folderlocation
#--------------------------------------------------------------------------


<#
USE [SQL_inventory]
GO



#>
#
Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query "xtruncate table [dbo].[FilePhotoListS]"


$fPath = 'd:\temp\temp9_1.csv'

#ii $fPath 
#$folderName ="C:\mydata\ebook\2013ebook\SharePoint 2013 User's Guide- 4th Edition.pdf"

$ps = Import-Csv $fPath -Delimiter ';'
$i=$ps.Count

$t1=get-date
foreach ($gc in $ps) {  #1353
#}#-
 $i;$i=$i-1
$FileName     =$GC.FileName
$FileName =$FileName.Replace(',','-')
$FilePhotoPath      =$GC.FilePhotoPath
$FileLastWriteTime  =$GC.FileLastWriteTime
$FileOrgPath       =$GC.FileOrgPath
$FileExtension       =$GC.FileExtension
$FileSize     =$GC.FileSize
$FileLength     =$GC.Filelength
#$modifydate     =$GC.modifydate
$modifydate      =get-date -Format yyyyMMdd

#$folderName =$folderName.Replace('''','-')

$TSQL_insert=@"
--INSERT INTO [dbo].[FilePhotoListSTemp]
INSERT INTO [dbo].[FilePhotoListS]
           ([FileName]
           ,[FilePhotoPath]
           ,[FileLastWriteTime]
           ,[FileOrgPath]
           ,[FileExtension]
           ,[FileSize]
           ,[FileLength]
           ,[modifydate]
           ,[remark]
           ,[ONOFF])
     VALUES
           (N'$FileName'
           ,'$FilePhotoPath'
           ,'$FileLastWriteTime'
           ,N'$FileOrgPath'
           ,'$FileExtension'
           ,'$FileSize'
           ,'$FileLength'
           ,'$modifydate'
           ,''
           ,'1')
"@
#$TSQL_insert
Invoke-Sqlcmd -ServerInstance . -Database SQL_inventory -Query $TSQL_insert
} #1353
$t2=get-date
$t2-$t1
<#

Days              : 0
Hours             : 0
Minutes           : 15
Seconds           : 5
Milliseconds      : 321
Ticks             : 9053212288
TotalDays         : 0.010478254962963
TotalHours        : 0.251478119111111
TotalMinutes      : 15.0886871466667
TotalSeconds      : 905.3212288
TotalMilliseconds : 905321.2288
--select * from [FileListS] where fattributes='Directory'

--and foldername not like 'C:\mydata\ebook\微軟1%'
--and foldername not like 'C:\mydata\ebook\微軟2%'

SELECT count(*) FROM  [dbo].[FilePhotoListS]

  select * from filephotogroup 


UPDATE [dbo].[FilePhotoListS]   SET [ONOFF] = 1  WHERE FileExtension in ('mm') 
GO


select * from [FileListS] where foldername like 'C:\mydata\ebook\微軟2%' and folderlevel in ('1','2','3','4') order by foldersize desc

 SELECT filename,FileLastWriteTime,FileLength,count(filename) as count  into filephotogroup  FROM  [dbo].[FilePhotoListS] 
group by filename, FileLastWriteTime,FileLength
having count(filename) > 1

SELECT filename,FileLastWriteTime,FileLength,count(filename) FROM  [dbo].[FilePhotoListS] 
group by filename, FileLastWriteTime,FileLength
having count(filename) > 1  order by filename
  

select d.filename,fileorgpath,d.filelastwriteTime,d.filelength,count,filesize,fileextension from filephotogroup  g
join  [FilePhotoListS] d on g.filename=d.filename order by d.filename
  
select d.filename,fileorgpath,d.filephotopath,d.filelastwriteTime,d.filelength,count,filesize,fileextension from filephotogroup  g
join  [FilePhotoListS] d on g.filename=d.filename 
where d.fileextension not in('CPI','tmp','MPL','ini')
order by d.filename
  

#>

#--------------------------------------------------------------------------
#  1535  Get filePhotoLists  copy jpg to filephotopath ( familyPhoto) for SQL
#--------------------------------------------------------------------------
<#
1294(temp9) : make Family2010821X  to  temp9_x.csv
1397  import-csv() to table filephotolists
1535  get table filephotolists  copy jpg to familyphoto

aug17.166771 

select * into FilePhotoListS20150824 FROM  [dbo].[FilePhotoListS]

ONFF=0 
ONFF=1 copy first
ONFF=2 no same
ONFF=0 same


#>

Import-Module sqlps -DisableNameChecking

$ivsql=$env:computername  #WIN-2S026UBRQFO

$ndb='SQL_inventory'
$sourfolder='G:\'
$destFolder='c:\temp\'
$destFolder='E:\FamilyPhoto\'
$reportfileCOPY    =$destFolder+(get-date -format MMdd)+"_COPYSQL.txt"
$reportfile2_nosame=$destFolder+(get-date -format MMdd)+"_NoSame.txt"
$reportfile3_same  =$destFolder+(get-date -format MMdd)+"_Same.txt"

#$reportfileERRoRCSV=$destFolder+(get-date -format MMdd)+"_ERRORCSV.txt"
#$reportfileERRoRSQL=$destFolder+(get-date -format MMdd)+"_ERRORSQL.txt"

#start
#---1 GET filephotolists distinct filephotopath mkdir (1)處理 分檔目錄建立.
$tsql_distict="SELECT distinct filephotopath as fpp FROM  [dbo].[FilePhotoListS] order by filephotopath "
#$tsql_distict="SELECT count(*) FROM  [dbo].[FilePhotoListS]"


$a1 = Invoke-Sqlcmd -Query $tsql_distict -ServerInstance $ivsql -Database $ndb
foreach ($a in $a1){
    $fx=$destFolder+$a.fpp
    if ((test-path $fx) -eq $false)
    {
        mkdir  $fx
    }
}


#---2 select filephotolists where onff=0  (2) 準備好 存入 目錄路徑
$tsql_onff=@"
SELECT top 1 filephotopath+'\'+filename as dfullname --到達路徑
,fileorgpath+'\'+filename as sfullname              --來源目錄
,filename,FileLength,FileLastWriteTime ,filephotopath
FROM  [dbo].[FilePhotoListS] where onoff <> 0
"@

$a2S = Invoke-Sqlcmd -Query $tsql_onff -ServerInstance $ivsql -Database $ndb
$a2S.dfullname

foreach ($a2 in $a2S)
{  #1770 a2
#} #-
    $a2.filename
    $sfullname=$destFolder+$a2.sfullname
    $dfullname=$destFolder+$a2.dfullname
    if ((test-path $dfullname) -eq $false)  # 到達檔案 是否已有檔案. 如果沒有COPY
    { #1779  copy first  
       copy-item -Path $sfullname -Destination $dfullname -force

       $tsql_update1="update [FilePhotoListS]  set ONOFF=1  where filephotopath=$filephotopath and filename=$filename"
      # Invoke-Sqlcmd -Query $tsql_update1 -ServerInstance $ivsql -Database $ndb
      # $tsql_update1 |out-file $reportfileCOPY -Append 
    }#1779  copy first  
    else  已相同有檔案十木
    {#1779  destination  and source file  replicator

    $psfullname = gci $sfullname # real get source physical file
    $psFileLength=$psfullname.FileLength
    $psFileLastWriteTime=$psfullname.FileLastWriteTime

    $pdfullname = gci $dfullname # real get destination physical file
    $pdFileLength=$pdfullname.FileLength
    $pdFileLastWriteTime=$pdfullname.FileLastWriteTime

        if ($x -lt $y)
        {  #1812 no same  onoff=2
            $tsql_update2="update [FilePhotoListS]  set ONOFF=2  where filephotopath=$filephotopath and filename=$filename"
            # Invoke-Sqlcmd -Query $tsql_update1 -ServerInstance $ivsql -Database $ndb
            # $tsql_update1 |out-file $reportfile2_nosame -Append 
            $a2.filename+';'+$sfullname+';'+$a2.FileLength+';'+$a2.FileLastWriteTime +';'+$a2.filephotopath |out-file $reportfile2_nosame -Append 
        }  #1812 no same  onoff=2
        
        else
        
        {  #1816 same  onff=3
             $tsql_update3="update [FilePhotoListS]  set ONOFF=3  where filephotopath=$filephotopath and filename=$filename"
             #Invoke-Sqlcmd -Query $tsql_update3 -ServerInstance $ivsql -Database $ndb
             $tsql_update3 |out-file $reportfile3_same -Append 
             $a2.filename+';'+$sfullname+';'+$a.FileLength+';'+$a.FileLastWriteTime +';'+$a2.filephotopath |out-file $reportfile3_same -Append 
        }   #1816 same  onff=3
       

   
    
   
    
    }#1779  destination  and source file  replicator



}  #1770  a2


#3 test-path filephotopath * filename
#4 check filelenght & lastwrietime
#5  update ONOFF=1

#--------------------------------------------------------------------------
#  1851  Familyphoto all folder properties to DB  FolderPhotoGroupS Table   
#--------------------------------------------------------------------------
temp5.ps1

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







#--------------------------------------------------------------------------
# 1873  Explore Structure of an XML Document
#--------------------------------------------------------------------------
$inputFile="H:\Microsoft\BI2015_ContentPackDemo\SharePoint Configuration Demo 15.2.6\Demo\SP\AutoSPInstaller\AutoSPInstallerInput.xml"
[xml]$xmlinput = (Get-Content $inputFile) 

$xmlinput | fl * -force

$xmlinput.InnerXml
$xmlinput.InnerXml.Split('</>')

$xmlinput.SelectNodes("//*[@Provision]")
$xmlinput.SelectNodes("//*[@Install]")

$xmlinput.SelectNodes("//*[AdminComponent]")


 $xmlinput.SelectNodes("//*[@Provision]
 |//*[@Install]
 |//*[CrawlComponent]
 |//*[QueryComponent]
 |//*[SearchQueryAndSiteSettingsServers]
 |//*[AdminComponent]
 |//*[IndexComponent]
 |//*[ContentProcessingComponent]
 |//*[AnalyticsProcessingComponent]
 |//*[@Start]")

$xmlinput.SelectNodes("//*[SearchCenterUrl]")


 
###

To load this sample XML file, you can use any of these:

$mydoc = [xml] @"
<catalogz>
   <bookz id="bk101">
      <authorz>1Gambardella, Matthew</authorz>
      <title>XML Developer's Guide</title>
      <genre>Computer</genre>
      <price>44.95</price>
      <publish_date>2000-10-01</publish_date>
      <description>An in-depth look at creating applications
      with XML.</description>
   </bookz>
   <bookz id="bk102">
      <authorz>2Ralls, Kim</authorz>
      <title>Midnight Rain</title>
      <genre>Fantasy</genre>
      <publish_date>2000-12-16</publish_date>
      <description>A former architect battles corporate zombies,
      an evil sorceress, and her own childhood to become queen
      of the world.</description>
   </bookz>
   <bookz id="bk103">
      <authorz>3Ralls, Kim</authorz>
      <title>Midnight Rain</title>
      <genre>Fantasy</genre>
      <price>5.95</price>
      <publish_date>2000-12-16</publish_date>
   </bookz>
</catalogz>
"@

$mydoc.SelectNodes("//authorz") |select Name,ParentNode,InnerXml
<#
#text                                                                                                                                                    
-----                                                                                                                                                    
Gambardella, Matthew                                                                                                                                     
Ralls, Kim 

#>

$mydoc |select * | sort name
<#

Attributes         : 
BaseURI            : 

ChildNodes         : {Catalogz}
DocumentElement    : Catalogz
DocumentType       : 
FirstChild         : Catalogz
HasChildNodes      : True
Implementation     : System.Xml.XmlImplementation
InnerText          : 
InnerXml           : <Catalogz><bookz id="bk101"><authorz>Gambardella, 
IsReadOnly         : False
LastChild          : Catalogz
LocalName          : #document
Name               : #document
NameTable          : System.Xml.NameTable
NamespaceURI       : 
NextSibling        : 
NodeType           : Document
OuterXml           : <Catalogz><bookz id="bk101"><authorz>Gambardella, 
OwnerDocument      : 
ParentNode         : 
Prefix             : 
PreserveWhitespace : False
PreviousSibling    : 
SchemaInfo         : System.Xml.Schema.XmlSchemaInfo
Schemas            : System.Xml.Schema.XmlSchemaSet
Value              : 
XmlResolver        : 

catalogz           : Catalogz
#>


$mydoc.catalogz |select *
$mydoc.SelectSingleNode("//bookz")   #第一筆有bookz  Node
$mydoc.SelectSingleNode("//*[price]") |select * #find out 有Price 的 第一筆 Node


$mydoc.SelectNodes("//price")     |select name,innerXml #find out value of Price 找出所有Price 的值
$mydoc.SelectNodes("//*[price]")  |select id  # find out Node of  have price 找出所有Price 的 Nodes

$mydoc.SelectNodes("//*[@id]")  |select id,Name # 找出所有 Attribute 有id 的 Nodes




$mydoc.SelectSingleNode("//book[2]")

$mydoc.SelectNodes("//author") |select -Unique




$mydoc.SelectSingleNode("//Catalogz") |select *    #  Entire Catalog # 大小寫有差
$mydoc.SelectNodes("//bookz")   #book collection
$mydoc.SelectNodes("//bookz").Item(0)  # 1st book 	
$mydoc.SelectNodes("//bookz").Item(1)  # 2nd book 
$mydoc.SelectSingleNode("//bookz[last()]")  # last book

$mydoc.SelectSingleNode("//bookz[1]/authorz").InnerText
$mydoc.SelectSingleNode("//bookz[2]/authorz").InnerText # Author of 2nd book
$mydoc.SelectSingleNode("//bookz[3]/authorz").InnerText

    $mydoc.SelectNodes("//bookz[price > 40]")  # book over 40
    $mydoc.SelectNodes("//*[price > 40]")  # book over 40

$xmlinput.SelectNodes("//*[Database = 'Content_AdminDB' ]") #找出Database TAB 中有 Content_AdminDB Value
$xmlinput.SelectNodes("//*[ConfigDB='SharePoint_ConfigDB']") |select localname #找出 element 中的 其值為 SharePoint_ConfigDB的 Node


$mydoc.SelectSingleNode("//bookz[1]/@id").Value # ID for  1st book 
ex
$mydoc.SelectNodes("//*[description]")   #找出所有Nodes 之中,有 description Tab

$mydoc.SelectNodes("//*[price]")  
$mydoc.SelectNodes("//*[@price]")  

$mydoc.SelectNodes("//*[description]|//*[price]")   # 找出所有Nodes 之中,只要符合有 description & Price 即可



Function GetFromNode([System.Xml.XmlElement]$node, [string] $item)
{
    $value = $node.GetAttribute($item)
    If ($value -eq "")
    {
        $child = $node.SelectSingleNode($item);
        If ($child -ne $null)
        {
            Return $child.InnerText;
        }
    }
    Return $value;
}

Function GetFromNode([xml]$node, [string] $item)
{
    $value = $node.GetAttribute($item)
    If ($value -eq "")
    {
        $child = $node.SelectSingleNode($item);
        If ($child -ne $null)
        {
            Return $child.InnerText;
        }
    }
    Return $value;
}

GetFromNode '$mydoc.catalogz.bookz' price

#--------------------------------------------------------------------------
#   2104 excel xlsx  xls    to CSV
#--------------------------------------------------------------------------

# 將execl 各sheet 　存在不同的 CSV

Function ExportWSToCSV ($excelFileName, $csvLoc)
{
    $excelFile = "H:\temp\" + $excelFileName + ".xlsx"
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $wb = $E.Workbooks.Open($excelFile)
    foreach ($ws in $wb.Worksheets)
    {
        $n = $excelFileName + "_" + $ws.Name
        $ws.SaveAs($csvLoc + $n + ".csv", 6)
    }
    $E.Quit()
}

ExportWSToCSV -excelFileName "NETL_SSIS Performance Counter" -csvLoc "H:\temp\"

# open excel

$excelFile  = 'H:\temp\dbmemory.xlsx'
 
# Open the Excel document and pull in the 'Play' worksheet
$Excel = New-Object -Com Excel.Application
$Excel.Visible=$false
$Excel.DisplayAlerts=$false

$wb = $Excel.Workbooks.Open($excelFile) 

foreach ($ws in $wb.Worksheets)
    {
        $n = $excelFileName + "_" + $ws.Name
    }


$page = 'dbmemory'
$ws = $Workbook.worksheets | where-object {$_.Name -eq $page}



$Workbook |gm


gps -ProcessName EXCEL

Stop-Process -Id 7084


#--------------------------------------------------------------------------
#   2153  Get File/folder  to Table
#--------------------------------------------------------------------------

CREATE TABLE [dbo].[FolderListS](
	[folderGroup] [nvarchar](100) NULL,
	[folderName] [nvarchar](510) NULL,
	[subFoldercount] [int] NULL,
	[filecount] [int] NULL,
	[folderSize] [float] NULL,
	[folderlevel] [nvarchar](20) NULL,
	[FAttributes] [nvarchar](20) NULL,
	[modifydate] [date] NULL,
	[ONOFF] [nvarchar](20) NULL
) ON [PRIMARY]
CREATE TABLE [dbo].[FileListS](
	[FileName] [nvarchar](255) NULL,
	[folderName] [nvarchar](510) NULL,
	[FileLastWriteTime] [datetime] NULL,
	[FileSize] [float] NULL,
	[FileLength] [nvarchar](50) NULL,
	[FileExtension] [nvarchar](20) NULL,
	[modifydate] [date] NULL,
	[remark] [nvarchar](250) NULL,
	[ONOFF] [nvarchar](20) NULL
) ON [PRIMARY]
#--

Select *　from SQL_inventory.dbo.[FolderListS] dl
join FileListS fl on dl.folderName=fl.folderName 
where folderGroup='Movie' 

#--

Select  dl.folderName ,count(dl.folderName)　from SQL_inventory.dbo.[FolderListS] dl
join FileListS fl on dl.folderName=fl.folderName 
where folderGroup='Movie'  and   folderlevel = 2 
group by dl.folderName 
order by folderName desc
#--

Select *　from SQL_inventory.dbo.[FileListS] order by folderName
Select *　from SQL_inventory.dbo.[FolderListS] where ONOFF=1 and folderlevel =1  and folderGroup='Software2015' order by folderGroup 

Select *　from SQL_inventory.dbo.[FolderGroupS]
Select *　from SQL_inventory.dbo.[FolderListS]
Select *　from SQL_inventory.dbo.[FileListS]

Select *　from SQL_inventory.dbo.[FolderPhotoListS]
Select *　from SQL_inventory.dbo.[FilePhotoListS]   incoming  styles  招標文件-玉


#---------folder list import
function folderproperites ($folderpath){
    #$folderpath='H:\movie2015'
    
    #$folderpath='D:\RFP\桃園國際機場-機場安全監控設備工程\incoming'
    # $folderpath='D:\RFP\桃園國際機場-機場安全監控設備工程\01\CC1000905_01'
    #$folderpath= ii 'D:\RFP\桃園國際機場-機場安全監控設備工程\incoming\CC1000905_01\招標文件'
#(gci $x -Recurse ) | % { $_.PSIsContainer -eq $false } 

# 找出所有的folder
#(gci $x -Recurse ) | ? {$_.PSIsContainer -eq  $true } |% {$_.name }
$frc=((gci $folderpath -Recurse -Force) | ? {$_.PSIsContainer -eq  $true }).count

# 找出所有的 Files
$fec=((gci $folderpath -Recurse -Force) | ? {$_.PSIsContainer -eq  $false }).count

# 找出Size
 #$fsize="{0:n1}" -f  ( ((gci $folderpath -Recurse -Force) | Measure-Object -property length -sum).Sum   / 1MB) 

$y=(gci $folderpath -Recurse -Force) | gm | select Name
if (  ($y | ? name -EQ 'length').name -eq 'Length' )
{
     $fsize="{0:n1}" -f  ( ((gci $folderpath -Recurse -Force) | Measure-Object -property length -sum).Sum   / 1MB) 
}
else
{
        $fsize=0.0
}
$frc;$fec;$fsize
}

$ivsql ='PMD2016'
$ndb   ='SQL_Inventory'
$GetfolderM  ='D:' 

$tsql_GetfolderS=@"
 select folderGroup from folderGroupS where ONoff='0'
"@

$getDs=Invoke-Sqlcmd -Query $tsql_GetfolderS -ServerInstance $ivsql -Database $ndb ;  #$getDs.Count


$t1=get-date
foreach ($getD in $getDs) { #foreach loop1 
#}#-
$cfolders=$getD.folderGroup; #$cfolders
$Getfolder=$GetfolderM+"\$cfolders" ; #'R1-- '+$Getfolder
#$Getfolder='D:\Cloud'
   if ( (test-path $Getfolder ) -eq $true)   {  #  687 防止此disk 沒有此folder
   try {
       $folderGroup     =$cfolders
       $subFoldercount=(folderproperites $Getfolder)[0]
       $filecount     =(folderproperites $Getfolder)[1]
       $folderSize    =(folderproperites $Getfolder)[2]
       $folderName    =$Getfolder.Substring(2,$Getfolder.Length-2)
       $folderName    =$folderName.Replace('''','-');'   111'+$foldername
       $folderlevel   = '1'
       $gr=gi $Getfolder
       $Attributes    =$gr.Attributes
       $modifydate    =get-date -Format yyyyMMdd

$TSQL_insert=@"
INSERT INTO [dbo].[FolderListS] ([folderGroup],[folderName],[subFoldercount],[filecount],[folderSize],[folderlevel]
 ,[FAttributes] ,[modifydate],[ONOFF])
     VALUES('$folderGroup','$folderName','$subFoldercount','$filecount','$folderSize','$folderlevel'
           ,'$FAttributes' ,'$modifydate','1')
"@
#$TSQL_insert
Invoke-Sqlcmd -Query $TSQL_insert -ServerInstance $ivsql -Database $ndb ; # $getDs.Count

  $FolderfS=gci $Getfolder -recurse -Force; $i=$FolderfS.Count ;

   foreach ($Folderf in $FolderfS) {#646 
        #}#646-
            if ($Folderf.PSIsContainer -eq $true){ # 17 folder YES
                
                #for ($J = 1; $j -lt 9; $j++) {  break;$j  }

                $f1f =$Folderf.FullName ; #$f1f
                $folderName    =$f1f.Substring(2,$f1f.Length-2)
                $folderName =$folderName.Replace('''','-')  ;#'ii '+$GetfolderM+$foldername
                $subFoldercount=(folderproperites $f1f)[0]
                $filecount     =(folderproperites $f1f)[1]
                $folderSize    =(folderproperites $f1f)[2]
              
                #$folderlevel = '1'
                $folderlevel = (0..($folderName.length - 1) | ? {$folderName[$_] -eq '\'}).count

                $gr=gi $Getfolder
                $FAttributes   =$gr.Attributes

$folderGroup     =$cfolders
[int]$filecount       =$filecount 
[float]$folderSize      =$folderSize

$TSQL_insert=@"
INSERT INTO [dbo].[FolderListS] ([folderGroup],[folderName],[subFoldercount],[filecount],[folderSize],[folderlevel]
 ,[FAttributes] ,[modifydate],[ONOFF])
     VALUES('$folderGroup','$folderName','$subFoldercount','$filecount','$folderSize','$folderlevel'
           ,'$FAttributes' ,'$modifydate','1')
"@
#$TSQL_insert
Invoke-Sqlcmd -Query $TSQL_insert -ServerInstance $ivsql -Database $ndb ; # $getDs.Count
             } # 17 folder YES
         }#646
         }
         catch {
          '--------------------error stop !!-------'
 $TSQL_insert
 $Error.Exception
 break;   
         }
   } #  687 防止此disk 沒有此folder
 
} #foreach loop1 
$t2=get-date;($t2-$t1)
 

# 2hrs29Min 
# 2hr 55  31794

  
#------ri  -1  for PMD2016  subFoldercount=0 and filecount=0
$t1=get-date
$rpfile='D:\temp\EMPTYFOLDER.txt' ; #ri  $rpfile
if (Test-Path $rpfile ){ ri $rpfile -Force  }
$tsql_deleemptyfolder=@"
Select 'D:\'+folderGroup as [fn]　from SQL_inventory.dbo.[FolderGroupS] --where subFoldercount=0 and filecount=0 and ONOFF=0
"@

$rfns=Invoke-Sqlcmd -Query $tsql_deleemptyfolder -ServerInstance $ivsql -Database $ndb ; # $getDs.Count

foreach ($rfn in $rfns)
{
#}#-
    $Folder2fS=Get-ChildItem $rfn.fn -recurse; $Folder2fS.Countj;$i=0
    foreach ($Folder2f in $Folder2fS){

 #$Folder2f.PSIsContainer
  if ($Folder2f.PSIsContainer -eq $true){
   $i=$i+1 
   #$Folder2f.fullname 
   #(Get-ChildItem   $Folder2f.FullName).count
if (( Get-ChildItem   $Folder2f.FullName).count  -eq 0 ) {
      #'''0'' ;  ii ''+"$Folder2f.fullname"+''' 
     
      'ii ''' + $Folder2f.fullname +'''' | out-file $rpfile -Append

      #$Folder2f.FullName |out-file f:\temp\removeFolderList.txt -append  ;#ri  f:\temp\removeFolderList.txt -force
      ri  $Folder2f.FullName -Force -Confirm:$false
      }
  
 
  }

}
    
}


$i 
ii $rpfile
$t2=get-date;$t2-$t1  # 9 min 18 sec 
  
#-----ri  -2  for sp2013 and SQL2014X  subFoldercount=0 and filecount=0 

$Folder2     ='D:\WorkLog'
$Folder2     ='D:\cloud'                                                                                                                                    
$Folder2     ='D:\Family '                                                                                                                                  
$Folder2     ='D:\Microsoft'                                                                                                                                
$Folder2     ='D:\Movie'                                                                                                                                    
$Folder2     ='D:\Mydata'                                                                                                                                   
$Folder2     ='D:\MydataII'                                                                                                                                 
$Folder2     ='D:\Product'                                                                                                                                  
$Folder2     ='D:\Proposal'                                                                                                                                 
$Folder2     ='D:\RFP'                                                                                                                                      
$Folder2     ='D:\Software'                                                                                                                                 
$Folder2     ='D:\TV'                                                                                                                                       
$Folder2     ='D:\WorkLog'                                                                                                                                  
$Folder2     ='D:\GoogleDrive'                                                                                                                              
$Folder2     ='D:\GoolgeDriveBackup'                                                                                                                        
$Folder2     ='D:\Software2015' 

$rpfile='D:\temp\EMPTYFOLDER.txt' ; #ri  $rpfile

if (Test-Path $rpfile ){ ri $rpfile -Force  }

 $Folder2fS=Get-ChildItem $Folder2 -recurse; $Folder2fS.Countj;$i=0
foreach ($Folder2f in $Folder2fS){

 #$Folder2f.PSIsContainer
  if ($Folder2f.PSIsContainer -eq $true){
   $i=$i+1 
   #$Folder2f.fullname 
   #(Get-ChildItem   $Folder2f.FullName).count
if (( Get-ChildItem   $Folder2f.FullName).count  -eq 0 ) {
      #'''0'' ;  ii ''+"$Folder2f.fullname"+''' 
     
      'ii ''' + $Folder2f.fullname +'''' | out-file $rpfile -Append

      #$Folder2f.FullName |out-file f:\temp\removeFolderList.txt -append  ;#ri  f:\temp\removeFolderList.txt -force
      ri  $Folder2f.FullName -Force -Confirm:$false
      }
  
 
  }

}
$i
ii $rpfile

#---------file import

<#
CREATE TABLE [dbo].[FileListS](
	[FileName] [nvarchar](255) NULL,
	[folderName] [nvarchar](510) NULL,
	[FileLastWriteTime] [datetime] NULL,
	[FileSize] [float] NULL,
	[FileLength] [nvarchar](50) NULL,
	[FileExtension] [nvarchar](20) NULL,
	[modifydate] [date] NULL,
	[remark] [nvarchar](250) NULL,
	[ONOFF] [nvarchar](20) NULL
) ON [PRIMARY]

GO
#>


$tsql_GetfolderS=@"
 select folderGroup from folderGroupS where ONoff='0' order by folderGroup
 --select folderGroup from folderGroupS where folderGroup='Software2015'
"@
$getDs=Invoke-Sqlcmd -Query $tsql_GetfolderS -ServerInstance $ivsql -Database $ndb ;  #$getDs.Count

$t1=get-date
foreach ($getD in $getDs) { #foreach loop1 
#}#-
$cfolders=$getD.folderGroup; #$cfolders
$Getfolder=$GetfolderM+"\$cfolders" ; #'R1-- '+$Getfolder
#$Getfolder='D:\Cloud'
   if ( (test-path $Getfolder ) -eq $true)   {  #  687 防止此disk 沒有此folder

$Error.Clear()
  $FilefS=gci $Getfolder -recurse -Force; $i=$FolderfS.Count ;

   foreach ($Filef in $FilefS) {#646 
        #}#646-
 
            if ($Filef.PSIsContainer -eq $False){ # 17 folder YES
                
                #for ($J = 1; $j -lt 9; $j++) {  break;$j  }
                #$filef.FullName
                $FileName =$Filef.Name ; #$FileName
                $FileName =$FileName.Replace('''','-')

                $filedirectory=($Filef.DirectoryName).Substring(2, (($Filef.DirectoryName).length)-2 )
                $filedirectory =$filedirectory.Replace('''','-')
                
                #($Filef.DirectoryName).Substring(2,17)
                #("123345").Substring(0,4)

                $lwt=$Filef.LastWriteTime
                
                [float]$FileSize   ="{0:n2}" -f (($Filef.Length) / 1000000) ; #6
                $flength=$Filef.Length
                
                if (($Filef.Extension).Length -eq 0){$FileExtension=''}
                else {$FileExtension =($Filef.Extension).Substring(1,($Filef.Extension).Length-1)}

                if (($FileExtension).Length -gt 19){$FileExtension=$FileExtension.Substring(0,19)}
                
                $modifydate      =get-date -Format yyyyMMdd  #8
	$TSQL_insert=@"
INSERT INTO [dbo].[FileListS]
 ([FileName] ,[folderName],[FileLastWriteTime],[FileSize],[FileLength],[FileExtension],[modifydate],[ONOFF])
     VALUES  (N'$FileName ',N'$filedirectory','$lwt','$FileSize','$flength','$FileExtension','$modifydate','1')       
GO

"@
#$TSQL_insert
try {
Invoke-Sqlcmd -Query $TSQL_insert -ServerInstance $ivsql -Database $ndb  -AbortOnError ; # $getDs.Count
}
catch {
 '--------------------error stop !!-------'
 $TSQL_insert
 $Error.Exception
 break;
}          
            
             } # 17 folder YES


         }#646

   } #  687 防止此disk 沒有此folder
       
} #foreach loop1 
$t2=get-date;($t2-$t1)

# FileListS = 19Min  53Sec display off  -245330
# FileListS = 22Min  54Sec display off  -245329


#--------------------------------------------------------------------------
#   2475  make mp3 filename
#--------------------------------------------------------------------------

gps notepad |Stop-Process -Force
ri h:\temp4\error.txt
$u='letter_z'
$fs=gci "C:\Users\administrator.CSD\Desktop\English1200-0514\$u\sounds\"
$ft="C:\Users\administrator.CSD\Desktop\English1200-0514\$u\"

foreach ($f in $fs)
{
#}--
   '           '
   '--------------------------------------------------'
  
     $newname=''
     $w1=($f.Name).IndexOf("0")
     
    if ( $w1 -gt  0 )
    {
        try
        {
         $befname=$f.FullName;
        $fn=($f.Name).Substring(0,$w1);$fn
        $fb=$f.BaseName
       $htmlfile=$ft+$fn+'.html';  $htmlfile
       $curlregex=($f.Name)
        $aa=(Select-String -Path  $htmlfile -pattern $curlregex).tostring();$aa
        
        #f1
         #$st=".mp3')"" class=""word5"""
         #$i1=$aa.IndexOf($st)+22; $i1
        
        #f2
        $st=".mp3')"">"
        $i1=$aa.IndexOf('mp3'')">')+7; $i1
       
        $i2=$aa.IndexOf('</a>'); $i2
        #$i2=$aa.IndexOf('<br />'); $i2

        $sa=(($aa.substring($i1,$i2-$i1)).trim()).replace('?','.');$sa
        $newname=$fb+'_'+$sa+'.mp3' ;$newname ;
        Rename-Item -Path $befname -NewName $newname
         #$befname
         #$newname
        }
        catch [DivideByZeroException]
        {
           "notepad  $htmlfile"  |out-file h:\temp4\error.txt -Append 
        }
        catch [System.Net.WebException],[System.Exception]
        {
            "notepad  $htmlfile"  |out-file h:\temp4\error.txt -Append 
        }
        finally
        {
            
        }
    } 
}

ii  h:\temp4\error.txt

#--------------------------------------------------------------------------
#   2539  get file path & file name
#--------------------------------------------------------------------------


$path = 'D:\englishstudy\word1000\english_travel\P2_05.mp3'
$shell = New-Object -COMObject Shell.Application
$folder = Split-Path $path
$file   = Split-Path $path -Leaf

#--------------------------------------------------------------------------
#   2551  edit MP3 tags
#--------------------------------------------------------------------------
http://www.toddklindt.com/blog/Lists/Posts/Post.aspx?ID=468
http://download.banshee.fm/taglib-sharp/2.1.0.0/

記得將DLL 檔 unLock,才可以使用

# Load the assembly. I used a relative path so I could off using the Resolve-Path cmdlet 
[Reflection.Assembly]::LoadFrom( (Resolve-Path "d:\temp\taglib-sharp.dll"))

# Load up the MP3 file. Again, I used a relative path, but an absolute path works too 
$media = [TagLib.File]::Create((resolve-path $path ))
$media.tag | Get-Member
# set the tags 
$media.Tag.Album = "Todd Klindt's SharePoint Netcast" 
$media.Tag.Year = "2014" 
$media.Tag.Title = "p2_05" 
$media.Tag.Track = "185" 
$media.Tag.AlbumArtists = "Todd Klindt" 
$media.Tag.Comment = "http://www.toddklindt.com/blog"

# Load up the picture and set it 
$pic = [taglib.picture]::createfrompath("c:\Dropbox\Netcasts\Todd Netcast 1 - 480.jpg") 
$media.Tag.Pictures = $pic

# Save the file back 
$media.Save() 


for example 1

[Reflection.Assembly]::LoadFrom( (Resolve-Path "d:\temp\taglib-sharp.dll"))
$ds='D:\englishstudy\word1000\english_travel'

 $mp3S=gci $ds ; $mp3S.Count


 foreach ($mp3 in $mp3S)
 {
     
     $fullpath=$mp3.FullName
     $mp3n    =$mp3.Name
     $media = [TagLib.File]::Create((resolve-path $fullpath ))

     $media.Tag.Title = $mp3n
     $media.Save() 
 }

 for example 2
 [Reflection.Assembly]::LoadFrom( (Resolve-Path "d:\temp\taglib-sharp.dll"))
$ds='D:\englishstudy\word1000\english_travel'

 $mp3S=gci $ds ; $mp3S.Count


 foreach ($mp3 in $mp3S)
 {
     
     $fullpath=$mp3.FullName
     $mp3n    =$mp3.Name
     $media = [TagLib.File]::Create((resolve-path $fullpath ))
     $an=$media.Tag.Artists
     $newname=$an[0]+$mp3n
     $newname
     #$media.Tag.Title = $mp3n
     #$media.Save() 
     Rename-Item -Path $fullpath -NewName $newname
 }

#--------------------------------------------------------------------------
#  
#--------------------------------------------------------------------------



#--------------------------------------------------------------------------
#  
#--------------------------------------------------------------------------



#--------------------------------------------------------------------------
#  
#--------------------------------------------------------------------------



#--------------------------------------------------------------------------
#  
#--------------------------------------------------------------------------



#--------------------------------------------------------------------------
#  
#--------------------------------------------------------------------------


