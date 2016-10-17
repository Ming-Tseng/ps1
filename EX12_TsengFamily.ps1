<#
\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\EX12_TsengFamily.ps1
Date: Nov.30.2015

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\EX12_TsengFamily.ps1

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

#ONOFF code
0: ok copy
1:New
2:Different
3:Same
4:Bypass not handle
5:手動刪除 onoff=5  & filelength='0' ;Line:408
6: ONOFF=2 已處理 
7: lose

A:

主流程步驟 (新圖檔匯入)  #整合為一支  945
1.   各HD 各有 toFamilyPhotoxxxx 
2.   執行比對 title:20 line:74   先檢查是否匯入 測是可己重覆
3.   Temp 9 (folder photo to csv)
4.   OS07_Files.ps1 line: 1397 ( CSV to table FilePhotoListS , ONOFF=1 ) 可先用 FilePhotoListSTemp 
5.   排除不處理的副檔名. ONOFF=4 ref:line51
6.   OS07_files.ps1 line: 1535 temp10 ( photofile copy  FamilyPhoto)
7.


副流程步驟 (圖檔檢查)
1. line:20
2.
3.

Copy 流程步驟

#1 解決差 2sec 內 相同檔名,只要是Filelength 相同 視為相同.

#2 同名.同月 但是 圖檔不同 .

#3 


# 11          tsql  Nov.30.3015
# 20  74  check import File (ex:Family2010821X)  所有檔案是否已存放在 FamilyPhoto  之中了# 241     check 由 Table（FilePhotoListS  Familyphoto 是否可以讀取  file properties# 255     clear empty folder
# 284     delelte  Hidden   Thumbs.db
# 296     ONOFF=2 之處理
#  408       update ONOFF = 5 手動, filelength=0  ,then delete physical file# 572     rename  0 + FileName 
# 587     人工排除 重覆 # 740     folder 內檔案數,大小  [FolderPhotoListS]
# 825     compare two folder  &　F1 copy to F2# 945    New file import

#-----------------------------------------------------------------------------------#  11  tsql  Nov.30.3015#-----------------------------------------------------------------------------------
USE [SQL_inventory]
GO

/****** Object:  Table [dbo].[FilePhotoListS]    Script Date: 1/5/2016 4:42:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FilePhotoListS](
	[FileName] [nvarchar](100) NOT NULL,
	[FilePhotoPath] [nvarchar](20) NULL,
	[FileLastWriteTime] [datetime] NULL,
	[FileOrgPath] [nvarchar](200) NOT NULL,
	[FileExtension] [nvarchar](20) NULL,
	[FileSize] [float] NULL,
	[FileLength] [nvarchar](50) NULL,
	[modifydate] [date] NULL,
	[remark] [nvarchar](250) NULL,
	[ONOFF] [nvarchar](10) NULL,
 CONSTRAINT [PK_FilePhotoListS] PRIMARY KEY CLUSTERED 
(
	[FileName] ASC,
	[FileOrgPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[FilePhotoListS]  WITH CHECK ADD  CONSTRAINT [FK_FilePhotoListS_FilePhotoListS] FOREIGN KEY([FileName], [FileOrgPath])
REFERENCES [dbo].[FilePhotoListS] ([FileName], [FileOrgPath])
GO

ALTER TABLE [dbo].[FilePhotoListS] CHECK CONSTRAINT [FK_FilePhotoListS_FilePhotoListS]
GO

ALTER TABLE [dbo].[FilePhotoListS]  WITH CHECK ADD  CONSTRAINT [FK_FilePhotoListS_FilePhotoListS1] FOREIGN KEY([FileName], [FileOrgPath])
REFERENCES [dbo].[FilePhotoListS] ([FileName], [FileOrgPath])
GO

ALTER TABLE [dbo].[FilePhotoListS] CHECK CONSTRAINT [FK_FilePhotoListS_FilePhotoListS1]
GO


#+++++++++++++++++++++++++++++
USE [SQL_inventory]
GO

/****** Object:  Table [dbo].[FolderPhotoListS]    Script Date: 1/5/2016 4:44:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FolderPhotoListS](
	[folderName] [nvarchar](510) NULL,
	[filecount] [int] NULL,
	[folderSize] [float] NULL,
	[folderTab] [nvarchar](255) NULL,
	[beforeinfo] [nvarchar](255) NULL,
	[folderCheckFlag] [nvarchar](20) NULL,
	[modifydate] [date] NULL,
	[ONOFF] [nvarchar](20) NULL
) ON [PRIMARY]

GO

#+++++++++++++++++++++++++++++





select distinct FileExtension ,ONOFF  from FilePhotoListS    order by FileExtension
select *  from FilePhotoListS   where FileExtension='dthumb' order by FileExtension
update FilePhotoListS set onoff=4  where FileExtension='dthumb' 

select distinct  filephotopath from sQL_inventory.dbo.FilePhotoListS      --301
select distinct  foldername    from [FolderPhotoListS]  --301


select * from FilePhotoListS  where ONOFF=1 and modifydate='2015-12-08'--6062
select distinct FileExtension from FilePhotoListS  where ONOFF=1 and modifydate='2015-12-08' order by FileExtension--6062



select * from FilePhotoListS  where  modifydate='2015-12-08' and FileExtension='zip'
select * from FilePhotoListS  where  modifydate='2015-12-08' and FileName like '.%'--6062
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='cdr_的備份'    
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='dthumb'   
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='mht' 
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='rar' 
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='exe' 
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='themepack' 
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='TDT' 
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='TID' 
--update FilePhotoListS set ONOFF=4 where  modifydate='2015-12-08' and FileExtension='zip' 
update FilePhotoListS set ONOFF=5 where  ONOFF=1 and FileName=N'《SQL Server 2012实施与管理实战指南》.(俞榕刚，朱桦).[PDF].@ckook.pdf'

#
select FilePhotoPath , filename,ONOFF ,FileLastWriteTime,FileLength,FileOrgPath
from FilePhotoListS  where  FilePhotoPath='201303_V0801_E0109' 
and  filename in (select filename from FilePhotoListS  where ONOFF ='2' and FilePhotoPath='201303_V0801_E0109') order by filename,ONOFF

-- update FilePhotoListS  set onoff=6 where ONOFF in ('2') and FilePhotoPath='201303_V0801_E0109'


select FilePhotoPath,count(ONOFF) from FilePhotoListS 
 where  ONOFF=1
 group by FilePhotoPath
 order by FilePhotoPath

  
  select * from FilePhotoListS  where FileName like '%DSCN9920%' and FilePhotoPath='200708_V0206_E0000'
#-----------------------------------------------------------------------------------#   20  74   check import File (ex:Family2010821X)  所有檔案是否已存放在 FamilyPhoto  之中了#-----------------------------------------------------------------------------------
Family2010821X 是否都已在  Table（FilePhotoListS）之中.
Import-Module sqlps -DisableNameChecking

$ivsql='172.16.220.33'
$ndb='SQL_inventory'
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

$drivelable='F:\'
$rpfile=$drivelable+'temp\rep20.txt' ; #ri  $rpfile
$folder1='J:\toFamilyPhoto201512\'
$folder1='J:\'
#$familyPhotopath     ='F:\Family2010821X\00待整理區W01' 


#  Run here

$folder2='toFamilyPhoto201512' 
$familyPhotopath     =$folder1+$folder2
$rpfile=$drivelable+'temp\rep20j_'+$folder2+'.txt' ; #ri  $rpfile
if (Test-Path $rpfile ){ ri $rpfile -Force  }
$srcfileS=Get-ChildItem $familyPhotopath -recurse ;$i=$srcfileS.Count
'begin '+$familyPhotopath +' ,  total: ' +$i.tostring()  | out-file $rpfile -append
foreach ($srcfile in $srcfileS)
{  
   $fname  = $srcfile.Name 
   $flwt   = $srcfile.LastWriteTime
   $flength= $srcfile.length
   $tsql_20=@"
select '$drivelable'+'Familyphoto\'+ FilePhotoPath +'\'+FileName  as [RT20]  from FilePhotoListS  where filename='$fname' and FileLastWriteTime='$flwt' and FileLength='$flength' and onoff='0'  
"@
#$tsql_20
$x20=Invoke-Sqlcmd -Query $tsql_20 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds ;
#$x20.RT20
$FilePhotoPath     = veage $flwt #2
if ($x20.RT20 -ne $null)
{  # 如有在 FilePhotoPath 找到此File ,gci 也OK. 刪直接刪除
    #'58 '+$srcfile.fullName   | out-file $rpfile -append
    try
    {
    gci $x20.RT20 -ErrorAction stop |Out-Null

    #'ri '+$srcfile.fullName   | out-file $rpfile -append
     ri $srcfile.fullName  -Force
    #'ii '+$srcfile.fullName  +'        ; ' + 'ii  F:\FamilyPhoto\'+$FilePhotoPath+'\'+$fname    |out-file $rpfile -append ; #ii $rpfile
    #F:\Family2010821X\00待整理區W01\8\test999.jpg 
    }
    catch 
    {
    'ii ' + $srcfile.fullName +'; ii  ' + $x20.RT20 +'   # read error' | out-file $rpfile -append ;#ii $rpfile  ri $rpfile
}
}
else
{
    
    $i.ToString()+'                         '  |out-file $rpfile -append ; #ii $rpfile


    'ii '+$srcfile.fullName  +'        ; ' + 'ii  F:\FamilyPhoto\'+$FilePhotoPath+'\'+$fname    |out-file $rpfile -append ; #ii $rpfile
    '                                   '  |out-file $rpfile -append ; #ii $rpfile
    $tpf='F:\FamilyPhoto\'+$FilePhotoPath+'\'+$fname

    if (!(test-path  $tpf))  # 如有在 F找不到.需特別警示
    {
      '  ???????????????????????????????????????????????????????????   '  |out-file $rpfile -append ; #ii $rpfile
      '                                   '  |out-file $rpfile -append ; #ii $rpfile
    }

}


# 'ii ' + $x20.RT20   +' #-----  checked ------ ii '+$srcfile.fullName   | out-file $rpfile -append ; #   ii $rpfile
$i=$i-1;$i
}
ii $rpfile

#-----------------------------------------------------------------------------------#   #-----------------------------------------------------------------------------------

$tsql_ssms=@"
select FilePhotoPath ,FileName,onoff,FileOrgPath,FileLastWriteTime,FileLength
from FilePhotoListS  where filename='IMG_0344.jpg' 
--and FileLastWriteTime='$flwt' and FileLength='$flength' and onoff='0'  
order by filePhotopath

"@
Invoke-Sqlcmd -Query $tsql_ssms -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds |Out-GridView ;

$tsql_ssms=@"
select 'F:\'+'Familyphoto\'+ FilePhotoPath +'\'+FileName  as [RT20]  from FilePhotoListS  
where filename='IMG_0886.JPG' and FileLastWriteTime='07/07/2012 11:58:20' and FileLength='620356' and onoff='0' 

"@

Invoke-Sqlcmd -Query $tsql_ssms -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds |Out-GridView ;


gi  F:\Family2010821X\00待整理區W01\8\IMG_0680.JPG

#-----------------------------------------------------------------------------------#   241  check 由 Table（FilePhotoListS  Familyphoto 是否可以讀取  file properties#-----------------------------------------------------------------------------------Import-Module sqlps -DisableNameChecking

$familyPhotopath     ='F:\familyPhoto'  #$sourcepath.Replace("H:\temp\a", "\\172.16.220.61\h$\temp\a")


$srcfileSf=Get-ChildItem $sourcepath -recurse


#-----------------------------------------------------------------------------------
#  255   clear empty folder
#-----------------------------------------------------------------------------------
如有子目錄,需要再執行多次

$Folder2     ='F:\Family2010821X'


 $Folder2fS=Get-ChildItem $Folder2 -recurse; $Folder2fS.Countj;$i=0
foreach ($Folder2f in $Folder2fS){

 #$Folder2f.PSIsContainer
  if ($Folder2f.PSIsContainer -eq $true){
   $i=$i+1 
   #$Folder2f.fullname 
   #(Get-ChildItem   $Folder2f.FullName).count
if (( Get-ChildItem   $Folder2f.FullName).count  -eq 0 ) {
      '0   = '+$Folder2f.fullname 
       'ii ''' + $Folder2f.fullname +'''' | out-file $rpfile -Append

      #$Folder2f.FullName |out-file f:\temp\removeFolderList.txt -append  ;#ri  f:\temp\removeFolderList.txt -force
      rm  $Folder2f.FullName -Force -Confirm:$false
      }
  
 
  }

}
$i


#-----------------------------------------------------------------------------------
#   284 delelte  Hidden   Thumbs.db
#-----------------------------------------------------------------------------------
$Folder2     ='J:\toFamilyPhoto201512'
$Folder2fS=Get-ChildItem $Folder2 -recurse -Hidden  ; $Folder2fS.Countj;$i=0
foreach ($Folder2f in $Folder2fS){
$i=$i+1 
 $Folder2f.fullname
 ri $Folder2f.fullname -Force
}
$i

#-----------------------------------------------------------------------------------#   296 ONOFF=2 之處理   Dec.10.2015#-----------------------------------------------------------------------------------


function updatep ($filename, $FilePhotoPath,$sonoff,$uonoff){
$ivsql='172.16.220.33'
$ndb='SQL_inventory'
  $tsql = @"
update FilePhotoListS set ONOFF='$uonoff' 
--select onoff,*  from  filephotolists
--delete from  filephotolists
where  filename='$filename' and FilePhotoPath='$FilePhotoPath' 
--and FileLastWriteTime='06/06/2011 16:07:26'
--and FileLength='1666752'
--and fileorgpath='E:\Family2010821X\2012\20120920'
and onoff='$sonoff'
"@
#$tsql

Invoke-Sqlcmd -Query $tsql -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds | Out-GridView ;
  
} 
function selectp ($filename, $FilePhotoPath){
$ivsql='172.16.220.33'
$ndb='SQL_inventory'
  $tsql = @"
--update FilePhotoListS set ONOFF='$uonoff' 
select onoff,*  from  filephotolists
--delete from  filephotolists
where  filename='$filename' and FilePhotoPath='$FilePhotoPath' 
--and FileLastWriteTime='06/06/2011 16:07:26'
--and FileLength='1666752'
--and fileorgpath='E:\Family2010821X\2012\20120920'
--and onoff='$sonoff'
"@
#$tsql

Invoke-Sqlcmd -Query $tsql -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds #| Out-GridView ;
  
}
function selectpv ($filename, $FilePhotoPath){
$ivsql='172.16.220.33'
$ndb='SQL_inventory'
  $tsql = @"
--update FilePhotoListS set ONOFF='$uonoff' 
select onoff,*  from  filephotolists
--delete from  filephotolists
where  filename='$filename' and FilePhotoPath='$FilePhotoPath' 
--and FileLastWriteTime='06/06/2011 16:07:26'
--and FileLength='1666752'
--and fileorgpath='E:\Family2010821X\2012\20120920'
--and onoff='$sonoff'
"@
#$tsql

Invoke-Sqlcmd -Query $tsql -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds | Out-GridView ;
  
}
function selectpv2 ($filename){
$ivsql='172.16.220.33'
$ndb='SQL_inventory'
  $tsql = @"

select *  from  filephotolists
--delete from  filephotolists
where  filename='$filename' --and FilePhotoPath='$FilePhotoPath' 
--and FileLastWriteTime='06/06/2011 16:07:26'
--and FileLength='1666752'
--and fileorgpath='E:\Family2010821X\2012\20120920'
--and onoff='$sonoff'
"@
#$tsql

Invoke-Sqlcmd -Query $tsql -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds | Out-GridView ;
  
}
selectpv2 IMG_9783.jpg

updatep DSCN2242.JPG 200507_V0004_E0000  2  6
selectp DSCN2242.JPG 200507_V0004_E0000

ii	f:\familyphoto\200906_V0404_E0000\IMG_9783.jpg	
ii	f:\familyphoto\200810_V0308_E0000\MVI_2816.avi	



ii 'F:\Family2010821X\2005\20050709\DSCN2242.JPG' ;  ii F:\familyphoto\200507_V0004_E0000\DSCN2242.JPG
ii 'F:\Family2010821X\2005\20050709\'

cpi 'F:\Family2010821X\00待整理區W01\photos-20130202\IMG_0316.JPG' J:\toFamilyphoto20121209\IMG_0316.JPG
cpi
ri   'F:\Family2010821X\00待整理區W09\photos-20140502\105_PANA\P1050594.JPG'


$f1='DSCN2244.JPG'; $f2='200507_V0004_E0000'

selectp $f1 $f2
updatep $f1 $f2  2  6  ;selectp $f1 $f2
#----------------------------

Import-Module sqlps -DisableNameChecking

$ivsql='172.16.220.33'
$ndb='SQL_inventory'

#run here  onoff=2 to txt

$drivelable='F:\'
$rpfile='D:\temp\onoff2Sn3.txt' ; #ri  $rpfile

if (Test-Path $rpfile ){ ri $rpfile -Force  }
$tsql_onoff352=@"
select   FilePhotoPath , filename ,FileLastWriteTime,FileLength,FileOrgPath
from FilePhotoListS  where onoff='2'-- and filename='IMG_0872.JPG'
order by  FilePhotoPath,FileOrgPath,filename
"@
$ONOFF2S =Invoke-Sqlcmd -Query $tsql_onoff352 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds #|Out-GridView ;
$i=$ONOFF2S.Count
foreach ($ONOFF2 in $ONOFF2S){  # 311 
    '---------------------------------------------------------------------------' | out-file $rpfile -Append
$i.ToString() | out-file $rpfile -Append ;$i=$i-1 ;$i
    $fn2  =$ONOFF2.filename          ;  #'fn2filename  '+$fn2
    $fpp2 =$ONOFF2.FilePhotoPath     ;  #'fn2FilePhotoPath'+$fpp2
    $flwt2=$ONOFF2.FileLastWriteTime ;  #'fn2FileLastWriteTime'+$flwt2
    $flen2=$ONOFF2.FileLength        ;  #'fn2FileLength'+$flen2
    $fop2 =$ONOFF2.FileOrgPath       ;  #'fn2FileOrgPath'+$fop2

    if ($fop2.Substring(3,1) -eq 'F')  {  $fop2=$drivelable+$fop2.Substring(3,($fop2.Length-3)); }
    if ($fop2.Substring(3,1) -eq 'T')  {  $fop2='J:\'+$fop2.Substring(3,($fop2.Length-3)); }
    


        

    $tsql_onoff369=@"
select   FilePhotoPath , filename ,FileLastWriteTime,FileLength,FileOrgPath
from FilePhotoListS  where onoff='0' and filename='$fn2' and FilePhotoPath='$fpp2'
"@
#$tsql_onoff369

$ONOFF0 =Invoke-Sqlcmd -Query $tsql_onoff369 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds #|Out-GridView ;
    $fn0 =$ONOFF0.filename           ;  #'fn0filename  '+$fn0
    $fpp0=$ONOFF0.FilePhotoPath      ;  #'fn0FilePhotoPath'+$fpp0
    $flwt0=$ONOFF0.FileLastWriteTime ;  #'fn0FileLastWriteTime'+$flwt0
    $flen0=$ONOFF0.FileLength        ;  #'fn0FileLength'+$flen0
    $fop0=$ONOFF0.FileOrgPath        ;  #'fn0FileOrgPath'+$fop0

    if ($fop0.Substring(3,1) -eq 'f') { $fop0=$drivelable+$fop0.Substring(3,($fop0.Length-3))}
    if ($fop0.Substring(3,1) -eq 't') { $fop0='J:\'+$fop0.Substring(3,($fop0.Length-3))}

    
    #ii $rpfile  ri $rpfile
    '                   :  fn0              fn2'   | out-file $rpfile -Append
    'filename          :'+$fn0+       '  ' +$fn2   | out-file $rpfile -Append
    'FilePhotoPath     :'+$fpp0+      '  ' +$fpp2  | out-file $rpfile -Append
    'FileLastWriteTime :'+$flwt0+     '  ' +$flwt2 | out-file $rpfile -Append
    'FileLength        :'+$flen0+     '  ' +$flen2 | out-file $rpfile -Append
    #'FileOrgPath       :'+$fop0+      '  ' +$fop2  | out-file $rpfile -Append
    '    '  | out-file $rpfile -Append

    #Write-Host -NoNewline '-------          : fn0   ,           '  ' fn2' `r`n
    #Write-Host -NoNewline 'filename          :'$fn0   ,    '  ' $fn2 `r`n
    #Write-Host -noNewline 'FilePhotoPath     :'$fpp0  ,    '  ' $fpp2 `r`n
    #Write-Host -NoNewline 'FileLastWriteTime :'$flwt0 ,    '  ' $flwt2 `r`n
    #Write-Host -NoNewline 'FileLength        :'$flen0 ,    '  ' $flen2 `r`n
    #Write-Host -NoNewline 'FileOrgPath       :'$fop0  ,    '  ' $fop2 `r`n
     #''| out-file $rpfile -Append
    'cpi '''+$fop2+'\'+$fn2 +     ''''   + ' J:\toFamilyphoto20121209\J20151210'+'\'+$fn0 | out-file $rpfile -Append

     'ii '''+$fop2+'\'''  | out-file $rpfile -Append
     '    '  | out-file $rpfile -Append
     'ii '''+$fop2+'\'+$fn2 +     ''' ;  ii '+'F:\familyphoto\'+$fpp0+'\'+$fn0 | out-file $rpfile -Append
      '    '  | out-file $rpfile -Append
     'selectp '+ $fn0 +'  '+ $fpp0                                                 | out-file $rpfile -Append
     'updatep '+$fn0+'  '+$fpp0+'  '+2+'  '+6 +' ;'+ 'selectpv '+ $fn0 +'  '+ $fpp0 +' ; '+ 'ri '''+$fop2+'\'+$fn2 +     ''''     | out-file $rpfile -Append

     <#
     #相差 1 &2  sec ,大小相同. 即update onoff=3 以及 刪除 來源目錄中的檔案
     if ( (($flwt2.Second -eq ($flwt0.AddSeconds(-2)).second ) -or ($flwt0.Second -eq ($flwt2.AddSeconds(-2)).second ))   -and  ($flen0 -eq $flen2) )
     {
    '---------------------------------------------------------------------------' | out-file $rpfile -Append
    '-------           :  fn0              fn2'    | out-file $rpfile -Append
    'filename          :'+$fn0+       '  ' +$fn2   | out-file $rpfile -Append
    'FilePhotoPath     :'+$fpp0+      '  ' +$fpp2  | out-file $rpfile -Append
    'FileLastWriteTime :'+$flwt0+     '  ' +$flwt2 | out-file $rpfile -Append
    'FileLength        :'+$flen0+     '  ' +$flen2 | out-file $rpfile -Append
    'FileOrgPath       :'+$fop0+      '  ' +$fop2  | out-file $rpfile -Append
    ''| out-file $rpfile -Append
    'ii '''+$fop2+'\'+$fn2 +     ''' ;  ii '+'F:\familyphoto\'+$fpp0+'\'+$fn0 | out-file $rpfile -Append
    'ii '''+$fop2+'\'''  | out-file $rpfile -Append    
     }
     
     # 列出只有檔名filename FileLastWriteTime 及 filephotopath 相同 . 
     if ( (   ($flwt2 -ne $flwt0 ) -and ($flen0 -ne $flen2 )  )   -and  ($fn0 -eq $fn2) )
     {
    '---------------------------------------------------------------------------' | out-file $rpfile -Append
    '-------           :  fn0              fn2'    | out-file $rpfile -Append
    'filename          :'+$fn0+       '  ' +$fn2   | out-file $rpfile -Append
    'FilePhotoPath     :'+$fpp0+      '  ' +$fpp2  | out-file $rpfile -Append
    'FileLastWriteTime :'+$flwt0+     '  ' +$flwt2 | out-file $rpfile -Append
    'FileLength        :'+$flen0+     '  ' +$flen2 | out-file $rpfile -Append
    'FileOrgPath       :'+$fop0+      '  ' +$fop2  | out-file $rpfile -Append
    ''| out-file $rpfile -Append
    'ii '''+$fop2+'\'+$fn2 +     ''' ;  ii '+'F:\familyphoto\'+$fpp0+'\'+$fn0 | out-file $rpfile -Append
    'ii '''+$fop2+'\'''  | out-file $rpfile -Append    
     
     
     }
   #>
#select   FilePhotoPath , filename ,FileLastWriteTime,FileLength,FileOrgPath,ONOFF
#from FilePhotoListS  where filename='DSCN3947.JPG' and FilePhotoPath='200508_V0006_E0000''

}  # 311
ii $rpfile

#-----------------------------------------------------------------------------------#  408       update ONOFF = 5 手動, filelength=0  ,then delete physical file#-----------------------------------------------------------------------------------
{<# 先將檢查不對改為５，再將此實體檔案刪除

update FilePhotoListS set ONOFF=5 where  FileLength=0 and FileSize=0

$tsql533=@"
select * from FilePhotoListS where ONOFF= 5 order by FilePhotoPath desc
"@

Invoke-Sqlcmd -Query $tsql533 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds | Out-GridView ;
$tsql538=@"
select 'G:\Familyphoto\'+ FilePhotoPath +'\'+FileName  as [RT20],filelength  from FilePhotoListS  where  onoff='5'  
"@

$delfileS=Invoke-Sqlcmd -Query $tsql538 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds  ;

foreach ($delfile in $delfileS)
{
    $fx=$delfile.RT20

    if ( (Test-path $fx ) -eq  $true)
    {
        ri $fx -Force
    }
    else
    {
     $fx | out-file d:\temp\delfile.txt -Append
    }

}

ii d:\temp\delfile.txt

--update FilePhotoListS set ONOFF=5   where FileExtension = 'avi' and FilePhotoPath='201211_V0709_E0105' and modifydate='2015-08-15'



#>}
#-----------------------------------------------------------------------------------#   572  rename  0 + FileName  #-----------------------------------------------------------------------------------


{<#
$Folder1     ='J:\toFamilyPhoto201512\100NIKON' 
$Folder1fS=Get-ChildItem $Folder1 -recurse -force ; $Folder1fS.Count

foreach ($Folder1f in $Folder1fS) {# 18 處理目錄 check Folder
#}#-
$ff=$Folder1f.FullName
$nf='0'+$Folder1f.Name
Rename-Item  -Path $ff -NewName $nf
}

#>}
#-----------------------------------------------------------------------------------#   587  人工排除 重覆 #-----------------------------------------------------------------------------------
{<#


#case1
ii J:\toFamilyphoto20121209\100NIKON\  # total:502file  0DSCN0001.JPG~  0DSCN9987.JPG


#caseII   200505_V0003_E0000
ii F:\familyphoto\200505_V0003_E0000
ii j:\toFamilyPhoto201512\family20120425X\2005X\050520   # 18file

select  *
from FilePhotoListS  where  filename='DSCN1388.JPG' and FilePhotoPath='200505_V0003_E0000'
:DSCN1386.JPG  
:DSCN1387.JPG  
:DSCN1388.JPG  
#caseIII  200507_V0004_E0000
H:\toFamilyPhoto201512\family20120425X\2005X\20050820  #total 86files
:DSCN2095.JPG  
:DSCN2122.JPG  
:DSCN2123.JPG
:DSCN2126.JPG  
:DSCN2242.JPG  
:DSCN2244.JPG  
:DSCN2246.JPG  
:DSCN2247.JPG  
:DSCN2248.JPG 
:DSCN2269.JPG 
:DSCN2271.JPG  
:DSCN2272.JPG  
:DSCN2269.JPG  
:DSCN2270.JPG  

#caseIV 200508_V0006_E0000
J:\toFamilyPhoto201512\family20120425X\2005X\20050823\ #total:17files
J:\toFamilyPhoto201512\family20120425X\2005X\20050828\ #total:10files

#caseIV 200509_V0007_E0000
    J:\toFamilyPhoto201512\family20120425X\2005X\200509\baby photo-050917\ #1files
ii 'J:\toFamilyPhoto201512\family20120425X\2005X\20050917\' #119 files
    j:\toFamilyPhoto201512\family20120425X\2005X\20050918 # 83
    J:\toFamilyPhoto201512\family20120425X\2005X\20050924\ # 50
ii 'J:\toFamilyPhoto201512\family20120425X\2005X\20050925\' #32
ii 'J:\toFamilyPhoto201512\family20120425X\2005X\20050928\' #1
ii 'J:\toFamilyPhoto201512\family20120425X\2005X\20051010\' #60
#case V 200509_V0006_E0000
J:\toFamilyPhoto201512\family20120425X\2005X\20050910\ #14files

#case VI 200509_V0006_E0000

#case V  200510_V0008_E0000   
ii 'J:\toFamilyPhoto201512\family20120425X\2005X\20051015\' #19#case VI  200803_V0300_E0000ii 'J:\toFamilyPhoto201512\family20120425X\2008\20080301\' #7#case VII 200803_V0301_E0000ii 'J:\toFamilyPhoto201512\family20120425X\2008\20080328-0405\' #4#case VIII 201001_V0410_E0000ii 'J:\toFamilyPhoto201512\family20120425X\2010X\20100101\' #11ii 'J:\toFamilyPhoto201512\family20120425X\2010X\20100102\' #59#case IX   201003_V0501_E0000ii 'J:\toFamilyPhoto201512\family20120425X\2010X\20100331-1\' #16#case X   201005_V0502_E0000ii 'J:\toFamilyPhoto201512\family20120425X\2010X\20100510\'  #21#case XI  201009_V0507_E0000ii 'J:\toFamilyPhoto201512\family20120425X\2010X\20100912\'#case 12  201202_V0611_E0008  (diff)ii 'J:\toFamilyPhoto201512\family20120425X\2012\20120203\'#case 13  201201_V0611_E0007  (diff)select  * from FilePhotoListS  where  filename='IMG_8412.JPG' and FilePhotoPath='201201_V0611_E0007'ii 'J:\toFamilyPhoto201512\family20120425X\2012\20120203\100CANON\'  #254ii 'J:\toFamilyPhoto201512\family20120425X\2012\20120203\101CANON\'  #134#case 14  201202_V0611_E0008  (diff)select  *  from FilePhotoListS  where  filename='IMG_9196.JPG' and FilePhotoPath='201202_V0611_E0008'ii 'J:\toFamilyPhoto201512\family20120425X\2012\20120203\102CANON\'ii 'J:\toFamilyPhoto201512\family20120425X\2012\20120209\'  #4#case 15  201312_V0810_E0206  (diff)ii 'J:\toFamilyPhoto201512\vanessaDreams20131224\Dad\'#>}#-----------------------------------------------------------------------------------#   740  folder 內檔案數,大小   [FolderPhotoListS]#-----------------------------------------------------------------------------------#{<#
#$GetfolderM  ='E:' 

Import-Module sqlps -DisableNameChecking
$ivsql='172.16.220.33'
$ndb='SQL_inventory'

$drivedest     ='H'
$Getfolder     ='H:\FamilyPhoto'
$ff= get-date -Format yyyyMMddmm
$repfile     =$drivedest+':\temp\740Getcount.txt'
$repfile2    =$drivedest+':\temp\740Getcount.csv'

 #$FolderfS=gci $Getfolder -recurse -Force; $i=$FolderfS.Count;$i
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

$t1=get-date
if ( (test-path $Getfolder ) -eq $true)
   {  #  687 防止此disk 沒有此folder

   $FolderfS=gci $Getfolder -recurse -Force; $i=$FolderfS.Count
 foreach ($Folderf in $FolderfS) {#646  
    if ($Folderf.PSIsContainer -eq $true){ # 17 folder YES
       $f1f =$Folderf.FullName ; #$f1f
       $fName=$Folderf.name
       #$Folderf |select *

       #gi C:\microsoft\ACT |select *

       $subFoldercount=(folderproperites $f1f)[0]
       $filecount     =(folderproperites $f1f)[1]
       [float]$folderSize    =(folderproperites $f1f)[2]

       $folderName    =$f1f.Substring(2,$f1f.Length-2)
        $gr=gi $f1f
       $Attributes    =$gr.Attributes
       
       #$folderName ="abd' s"

       #$folderName =$folderName.Replace('''','-')
       #$folderlevel = (0..($folderName.length - 1) | ? {$folderName[$_] -eq '\'}).count
       $executedate=get-date -Format yyyyMMdd
       $tsql_syncGet=@"
       --update FolderPhotoListS set ONOFF=0
       select filecount,folderSize,ONOFF,beforeinfo from [FolderPhotoListS] where  folderName='$fName'
"@

try
{
$x742=Invoke-Sqlcmd -Query $tsql_syncGet -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds ;   
 }
catch
{
Write-Host " exception !!! break"
#$error.exception | out-file $rpfile -append
break;
}


if ($x742.ONOFF -eq $Null)
{
    
       $tsql_syncinsert=@"
       INSERT INTO [dbo].[FolderPhotoListS]([folderName],[filecount],[folderSize] ,[modifydate],[ONOFF])
      VALUES(N'$fName','$filecount','$folderSize','$executedate','1')
"@
$tsql_syncinsert
}
else 
{  
         if (($x742.beforeinfo).length -eq 1)
         {
             $ut=''
         }
       $before=$ut+($x742.filecount).ToString() +"   "+ ($x742.folderSize).ToString()+";"
       $tsql_syncupdate=@"
update [FolderPhotoListS] 
set [filecount]='$filecount',[folderSize]='$folderSize',[modifydate]='$executedate',[beforeinfo]= N'$before'
where [folderName]='$fName'
"@
$tsql_syncupdate
}
    #   $f1f+',filecount='+$filecount +',size='+$folderSize +'  subfolder ='+$subFoldercount  | out-file -FilePath $repfile  -Append 
       #$i.tostring() + ' R2-- '+$f1f;$i=$i-1
     } # 17 folder YES
     }#646
   } #  687 防止此disk 沒有此folder
$t2=get-date;$t2-$t1;
   
#9 min 10 sec; 6min 31sec
ii $repfile
 #>}#-----------------------------------------------------------------------------------#  825  compare two folder  &　F1 copy to F2#-----------------------------------------------------------------------------------{<#
# compare F1 & F2
#
$Folder1     ='H:\FamilyPhoto' 
$Folder1     ='D:\FamilyPhoto' # source 

$Folder2     ='G:\FamilyPhoto'
$Folder2     ='G:\FamilyPhoto'

$repfile     ='G:\temp\report_cp.txt'
$repfile2    ='G:\temp\report_FtoGNeedCheck.txt'
$repfile3    ='G:\temp\report_same.txt'
#$Folder1     ='H:\worklog\kmuh' 
#$Folder2     ='H:\worklog20130508Y\KMUH_20141013'
#$repfile     ='H:\report.txt '
#$repfile2    ='H:\report2.txt '
H:\FamilyPhoto\201409_V0906_E0302
G:\FamilyPhoto\201409_V0906_E0302
#----------------------------------------------------------------------------------------------------------list folder 1 compare to folder2 
$Folder1fS=Get-ChildItem $Folder1 -recurse -force ; $Folder1fS.Count

foreach ($Folder1f in $Folder1fS) {# 18 處理目錄 check Folder

    if ($Folder1f.PSIsContainer -eq $true){ # 17 folder YES
       $f1f =$Folder1f.FullName ; #$f1f
       $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f
       if ( (test-path $f2f) -eq $false){ # 21 if folder is null
        $f2f
        mkdir $f2f
      }  # 21 if folder is null
     }  # 17 folder YES
}# 18 處理目錄 check Folder

$t1=get-date
$i=$Folder1fS.count
foreach ($Folder1f in $Folder1fS){ # 33 處理檔案  check File
#}#-

 if ($Folder1f.PSIsContainer -eq $false){ # 31 IS file

 $f1f =$Folder1f.FullName ;# $f1f
 $f2f =$Folder1f.FullName.Replace($Folder1, $Folder2) ;#$f2f


 if ((test-path $f2f) -eq $false) {
         "$i"+ '; ii '+  $f1f +' ;  ii '+ $f2f  |out-file $repfile -Append # ii $repfile2
  
      Copy-Item $f1f -destination $f2f -Force 
  }# 假如folder2 沒有,則直接copy
  else{
      $df=gi $f2f ;$SF=gi $f1f 
      if ($Folder1f.LastWriteTime -gt $df.LastWriteTime)
        {
        $i.ToString()+' -> '+$f1f+'   ==== ' + $Folder1f.LastWriteTime |out-file $repfile2 -Append
        # '               -> '+$f2f+'   ==== ' + $df.LastWriteTime |out-file $repfile -Append ii $repfile2

         #Copy-Item $f1f -destination $f2f -Force 不用copy .only check 
      } 
  }#假如folder2 有,則比較如是較晚日期.也copy
  #$i;$i=$i-1; 'ii ' +$f1f +' ; ii '+ $f2f |out-file $repfile3 -Append
    #$srcfile |select name,LastWriteTime,FullName,Directory 
    #$srcfile |select *
    #$srcfileDirectory=$srcfile.Directory ;$srcfileDirectory

} # 31 IS file 
} # 33 處理檔案  check File$t2=get-date;($t2-$t1)#Jan.01.2016 @17min23sec not display total : 519G , 90191 file 339 folder#jan.022016  @27min20sec  H : 518G,90233file,339folders, G :519G 90307file,339Files#>}#-----------------------------------------------------------------------------------#  945  New file import#-----------------------------------------------------------------------------------#收集各硬碟匯入#open powershell_ise use as administrator#比較 filename, filelength, filelastwritetime
Import-Module sqlps -DisableNameChecking

$ivsql='172.16.220.33'
$ndb='SQL_inventory'
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

$drivedest='H'

#$familyPhotopath     ='F:\Family2010821X\00待整理區W01' 

#  Run 1 here start
$drivefrom='J:\family_20101114\044_3Y11M_20090125\'   #import drive    ii $drivefrom
$directoryfrom='20090102'  

$folderfrom           =$drivefrom+$directoryfrom     #import folder     (from) ii $folderfrom
$checkb=$directoryfrom+'C' 
$folderfrombackup     =$drivefrom+$checkb    #import folder     (from)
copy-item  $folderfrom  $folderfrombackup -Recurse -Force  #將處理目錄先加copy一份,自動產出文件, 再檢查
$folderto=$drivedest+':\FamilyPhoto\'     #destination folder(to)
$rpfile  =$drivedest+':\temp\rep_newfile.txt' ; #ii  $rpfile ; ri $rpfile
if (Test-Path $rpfile ){ ri $rpfile -Force  }
$srcfileS=Get-ChildItem $folderfrom -recurse ;$i=$srcfileS.Count;$i
#$srcfileS=  gci  'J:\toFamilyphoto20121209\rename1\IMG_0316.jpg'
#'begin '+$familyPhotopath +' ,  total: ' +$i.tostring()  | out-file $rpfile -append
foreach ($srcfile in $srcfileS)
{  #1030 loop 1
   #先依
   $FileOrgPath  =$srcfile.Directoryname  #4
   $fullnamefrom   = $srcfile.fullName           #1   
   $checkfullname = $fullnamefrom -replace $directoryfrom,$checkb
   $fnamefrom   = $srcfile.Name           #1
   $flwtfrom    = $srcfile.LastWriteTime  #3
   $flengthfrom = $srcfile.length         #7
   $FilePhotoPath     = veage $flwtfrom #2  veage 
   $FileExtension     =($srcfile.Extension).Substring(1,($srcfile.Extension).Length-1) ; #5
   [float]$FileSize   ="{0:n2}" -f (($srcfile.Length) / 1000000) ; #6
   $modifydate      =get-date -Format yyyyMMdd  #8
   $fmkdir=$folderto+$FilePhotoPath
   $fileto=$folderto+$FilePhotoPath+'\'+$fnamefrom

#}#-   #  query table (filename, filelength, filelastwriteTime 
# ii G:\FamilyPhoto\201207_V0705_E0101\IMG_1157.JPG

 if ((test-path $fmkdir)  -eq $false){ # 117 目錄路徑檢查
      mkdir $fmkdir
       '''New folder;  mkdir 943 '' ; ii '''+$fmkdir +'''; ii '+$fmkdir  | out-file $rpfile -append
      }  # 117 目錄路徑檢查


$tsql_1044=@"
select distinct ONOFF  from FilePhotoListS 
 where filename=N'$fnamefrom' and FileLastWriteTime='$flwtfrom' and FileLength='$flengthfrom' 
"@
$error.Clear()
try
{
$x1052=Invoke-Sqlcmd -Query $tsql_1044 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds ;

   switch ($x1052.ONOFF)
   {
       $null {  # ---------------------- switch  null 1056 
        $TSQL_insert=@"
INSERT INTO [dbo].[FilePhotoListS]([FileName],[FilePhotoPath],[FileLastWriteTime],[FileOrgPath]
           ,[FileExtension],[FileSize],[FileLength],[modifydate],[remark],[ONOFF])
     VALUES(N'$fnamefrom','$FilePhotoPath','$flwtfrom',N'$FileOrgPath','$FileExtension','$FileSize','$flengthfrom','$modifydate','','1')
"@
        $TSQL_insert

        Invoke-Sqlcmd -Query $TSQL_insert -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds ;
       
         cpi  $fullnamefrom $fileto 
         if ((Test-Path $fileto) -eq $True ) { #ri $fullnamefrom  
           ri $fullnamefrom  -Force
         }
                  
         '''New file '' ; ii '''+$checkfullname +'''; ii ' +$fileto | out-file $rpfile -append
         } ##----------------------------  switch  null 1056 
       
       '0' {    #++++++++++++++++++++++++++++ switch  onoff=0 1072 
       if ((Test-Path $fileto) -eq $True){ 
            ri  "$fullnamefrom" -force  #雖刪除,可至 $checkb 檢查
          '''ONOFF =0;  ri'' ; ii '''+$checkfullname +'''; ii '+$fileto  | out-file $rpfile -append
        }  # in table + testpath true 1063
      else{  # in table + testpath false 1066
        cpi "$fullnamefrom" $fileto -Force
        '''ONOFF =0;  cpi'' ; ii '''+$checkfullname +'''; ii '+$fileto  | out-file $rpfile -append
        
        }  

        
      
        } #++++++++++++++++++++++++++++ switch onoff=0 1072 
       
       '1' { #******************* onoff=1
           ri  "$fullnamefrom" -force
           '''ONOFF =1,993 ;  ri'' ; ii '''+$checkfullname +'''; ii '+$fileto  | out-file $rpfile -append
       } #******************* onoff=1
       
       '5' {break} #出現 FileLength=0 and FileSize=0 必須強制中斷
       
       '6' { #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% onoff=6

          $tsql_1096=@"
select filelength,FileLastWriteTime  from FilePhotoListS where filename='$fnamefrom' and ONOFF=0 and FilePhotoPath='$FilePhotoPath'
"@
 $r1099=Invoke-Sqlcmd -Query $tsql_1096 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds
 if (  ($r1099.filelength -eq $flengthfrom) -or ($r1099.FileLastWriteTime -eq $flwtfrom)                   )
 {
      ri $fullnamefrom -Force
      '''ONOFF =6, 1007 ri '' ;  ii '''+$checkfullname +'''  ; ii '''+ $fileto+''''  | out-file $rpfile -append
 }

 else {

 #檢查是否有改名了
 $TSQL_select7=@"
select ONOFF from FilePhotoListS where filename='0$fnamefrom' and FilePhotoPath='$FilePhotoPath'
"@
 $r1010=Invoke-Sqlcmd -Query $TSQL_select7 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds


  if (($r1010.ONOFF) -eq $Null) #
  {
    $TSQL_insert7=@"
INSERT INTO [dbo].[FilePhotoListS]([FileName],[FilePhotoPath],[FileLastWriteTime],[FileOrgPath]
           ,[FileExtension],[FileSize],[FileLength],[modifydate],[remark],[ONOFF])
     VALUES(N'0$fnamefrom','$FilePhotoPath','$flwtfrom',N'$FileOrgPath','$FileExtension','$FileSize','$flengthfrom','$modifydate','','1')
"@
    #$TSQL_insert7
    Invoke-Sqlcmd -Query $TSQL_insert7 -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds ;
    rni  $fullnamefrom "0$fnamefrom"

    $fullnamefromn=$folderfrom+'\0'+$fnamefrom
    $fileton=$folderto+$FilePhotoPath+'\0'+$fnamefrom
    cpi  $fullnamefromn $fileton 
    start-sleep 2
      '''ONOFF =6 1034 rename & insert '' ;  ii '''+$fileto +'''  ; ii '''+ $fileton+'''' | out-file $rpfile -append
    ri $fullnamefromn -Force   
  }
  if (($r1010.ONOFF) -eq 0)
  {
      ri $fullnamefrom -Force
      '''ONOFF =6 1040 already rename  '' ;  ii '''+$fileto +'''  ; ii '''+ $fileton+'''' | out-file $rpfile -append      
  }
 }
            
       }  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% onoff=6
       Default {}
   }

#}#-
}
catch
{
Write-Host "Other exception"
$error.exception | out-file $rpfile -append
break;
}

}#1030 loop 1
ii   $rpfile
#  Run here stop #  Run 2完成一批之後. 以 ONOFF=1  start以 Filephotopath 排序人工檢查.以及 update $Tsql_Filephotopath=@"select distinct Filephotopath from FilePhotoListS  where ONOFF=1 order by FilePhotoPath"@$qs=Invoke-Sqlcmd -Query $Tsql_Filephotopath -ServerInstance $ivsql -Database $ndb  -Username sa -Password p@ssw0rds ;
foreach ($q in $qs)
{
   'ii '+$folderto+$q.Filephotopath
}{declare @fpp nvarchar(100)
set  @fpp='201510_V1008_E0404'

select * from FilePhotoListS where FilePhotoPath=@fpp  and ONOFF ='1'
 select FilePhotoPath , filename,ONOFF ,FileLastWriteTime,FileLength,FileSize,FileOrgPath,modifydate
from FilePhotoListS  where  FilePhotoPath=@fpp
and  filename in (select filename from FilePhotoListS  where ONOFF ='1' and FilePhotoPath=@fpp) order by filename,ONOFF

 --select * from FilePhotoListS  where FilePhotoPath=@fpp and filename  in  ('466764894.889398.mp4','32618.jpg')
select filename from FilePhotoListS where FilePhotoPath=@fpp  group by filename having count(ONOFF)>=2

update FilePhotoListS set ONOFF=6 where ONOFF=1 and filename in ( select filename from FilePhotoListS where FilePhotoPath=@fpp  group by filename having count(ONOFF)>=2 )

update FilePhotoListS set ONOFF=0 where   ONOFF=1 and FilePhotoPath=@fpp
}

#  run 3  最後才刪除所有folder 
#-----------------------------------------------------------------------------------#  1120   FolderTab#-----------------------------------------------------------------------------------

Select *　from SQL_inventory.dbo.FolderPhotoListS
Select *　from SQL_inventory.dbo.FolderPhotoListS where foldertab like '%出生%'




update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200001_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200201_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200301_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200401_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200501_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N'小乖出生;' where folderName='200502_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200503_V0000_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200503_V0001_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200504_V0001_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200504_V0002_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200505_V0002_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200505_V0003_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200506_V0003_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200506_V0004_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200507_V0004_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200507_V0005_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200508_V0005_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200508_V0006_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200509_V0006_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200509_V0007_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200510_V0007_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200510_V0008_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200511_V0008_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200511_V0009_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200512_V0009_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200512_V0010_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200601_V0010_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200601_V0011_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200602_V0011_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200602_V0100_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200603_V0100_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200603_V0101_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200604_V0101_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200604_V0102_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200605_V0102_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200605_V0103_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200606_V0103_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200606_V0104_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200607_V0104_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200607_V0105_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200608_V0105_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200608_V0106_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200609_V0106_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200609_V0107_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200610_V0107_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200610_V0108_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200611_V0108_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200611_V0109_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200612_V0109_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200612_V0110_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200701_V0110_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200701_V0111_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200702_V0111_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200702_V0200_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200703_V0200_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200703_V0201_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200704_V0201_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200704_V0202_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200705_V0202_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200705_V0203_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200706_V0203_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200706_V0204_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200707_V0204_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200707_V0205_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200708_V0205_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200708_V0206_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200709_V0206_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200709_V0207_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200710_V0207_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200710_V0208_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200711_V0208_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200711_V0209_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200712_V0209_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200712_V0210_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200801_V0210_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200801_V0211_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200802_V0211_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200802_V0300_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200803_V0300_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200803_V0301_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200804_V0301_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200804_V0302_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200805_V0302_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200805_V0303_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200806_V0303_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200806_V0304_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200807_V0304_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200807_V0305_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200808_V0305_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200808_V0306_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200809_V0306_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200809_V0307_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200810_V0307_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200810_V0308_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200811_V0308_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200811_V0309_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200812_V0309_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200812_V0310_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200901_V0310_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200901_V0311_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200902_V0311_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200902_V0400_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200903_V0400_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200903_V0401_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200904_V0401_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200904_V0402_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200905_V0402_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200905_V0403_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200906_V0403_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200906_V0404_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200907_V0404_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200907_V0405_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200908_V0405_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200908_V0406_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200909_V0406_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200909_V0407_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200910_V0407_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200910_V0408_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200911_V0408_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200911_V0409_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200912_V0409_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='200912_V0410_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201001_V0410_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201001_V0411_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201002_V0411_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201002_V0500_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201003_V0500_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201003_V0501_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201004_V0501_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201004_V0502_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201005_V0502_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201005_V0503_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201006_V0503_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201006_V0504_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201007_V0504_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201007_V0505_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201008_V0505_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201008_V0506_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201009_V0506_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201009_V0507_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201010_V0507_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201010_V0508_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201011_V0508_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201011_V0509_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201012_V0509_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201012_V0510_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201101_V0510_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201101_V0511_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201102_V0511_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201102_V0600_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201103_V0600_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201103_V0601_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201104_V0602_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201105_V0603_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N'恩恩出生;' where folderName='201106_V0603_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201106_V0604_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201107_V0604_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201107_V0604_E0001'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201107_V0605_E0001'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201108_V0605_E0001'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201108_V0605_E0002'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201108_V0606_E0002'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201109_V0606_E0002'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201109_V0606_E0003'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201109_V0607_E0003'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201110_V0607_E0003'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201110_V0607_E0004'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201110_V0608_E0004'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201111_V0608_E0004'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201111_V0608_E0005'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201111_V0609_E0005'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201112_V0609_E0005'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201112_V0609_E0006'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201112_V0610_E0006'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201201_V0610_E0006'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201201_V0610_E0007'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201201_V0611_E0007'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201202_V0611_E0008'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201202_V0700_E0008'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201203_V0700_E0008'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201203_V0700_E0009'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201203_V0701_E0009'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201204_V0701_E0009'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201204_V0701_E0010'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201204_V0702_E0010'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201205_V0702_E0010'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201205_V0702_E0011'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201205_V0703_E0011'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201206_V0703_E0011'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201206_V0703_E0100'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201206_V0704_E0100'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201207_V0704_E0100'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201207_V0704_E0101'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201207_V0705_E0101'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201208_V0705_E0101'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201208_V0705_E0102'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201208_V0706_E0102'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201209_V0706_E0102'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201209_V0706_E0103'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201209_V0707_E0103'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201210_V0707_E0104'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201210_V0708_E0104'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201211_V0708_E0105'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201211_V0709_E0105'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201212_V0709_E0105'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201212_V0709_E0106'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201212_V0710_E0106'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201301_V0710_E0106'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201301_V0710_E0107'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201301_V0711_E0107'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201302_V0711_E0107'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201302_V0711_E0108'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201302_V0800_E0108'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201303_V0800_E0108'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201303_V0800_E0109'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201303_V0801_E0109'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201304_V0801_E0109'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201304_V0801_E0110'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201304_V0802_E0110'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201305_V0802_E0110'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201305_V0802_E0111'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201305_V0803_E0111'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201306_V0803_E0111'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201306_V0803_E0200'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201306_V0804_E0200'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201307_V0804_E0200'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201307_V0804_E0201'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201307_V0805_E0201'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201308_V0805_E0202'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201308_V0806_E0202'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201309_V0806_E0202'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201309_V0806_E0203'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201309_V0807_E0203'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201310_V0807_E0204'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201310_V0808_E0204'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201311_V0808_E0204'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201311_V0808_E0205'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201311_V0809_E0205'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201312_V0809_E0205'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201312_V0809_E0206'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201312_V0810_E0206'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201401_V0810_E0206'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201401_V0810_E0207'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201401_V0811_E0207'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201402_V0811_E0207'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201402_V0811_E0208'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201402_V0900_E0208'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201403_V0900_E0208'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201403_V0900_E0209'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201403_V0901_E0209'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201404_V0901_E0209'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201404_V0901_E0210'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201404_V0902_E0210'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201405_V0902_E0210'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201405_V0902_E0211'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201405_V0903_E0211'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201406_V0903_E0211'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201406_V0903_E0300'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201406_V0904_E0300'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201407_V0904_E0300'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201407_V0904_E0301'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201407_V0905_E0301'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201408_V0905_E0301'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201408_V0905_E0302'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201408_V0906_E0302'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201409_V0906_E0302'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201409_V0906_E0303'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201409_V0907_E0303'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201410_V0907_E0303'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201410_V0907_E0304'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201410_V0908_E0304'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201411_V0908_E0304'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201411_V0908_E0305'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201411_V0909_E0305'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201412_V0909_E0305'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201412_V0909_E0306'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201412_V0910_E0306'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201501_V0910_E0306'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201501_V0910_E0307'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201501_V0911_E0307'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201502_V0911_E0307'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201502_V0911_E0308'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201502_V1000_E0308'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201503_V1000_E0308'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201503_V1000_E0309'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201503_V1001_E0309'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201504_V1001_E0309'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201504_V1001_E0310'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201504_V1002_E0310'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201505_V1002_E0310'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201505_V1002_E0311'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201505_V1003_E0311'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201506_V1003_E0311'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201506_V1003_E0400'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201506_V1004_E0400'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201507_V1004_E0400'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201507_V1004_E0401'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201507_V1005_E0401'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201508_V1005_E0401'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201508_V1005_E0402'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201508_V1006_E0402'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201104_V0601_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201105_V0602_E0000'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201509_V1006_E0402'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201509_V1006_E0403'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201509_V1007_E0403'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201510_V1007_E0403'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201510_V1007_E0404'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201510_V1008_E0404'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201511_V1008_E0404'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201511_V1008_E0405'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201511_V1009_E0405'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201512_V1009_E0405'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201512_V1009_E0406'
update SQL_inventory.dbo.FolderPhotoListS Set foldertab =N';' where folderName='201512_V1010_E0406'










gci I:\ToWhite\family20120403X\00待整理區\photo0820\d.jpg |select * 

ii I:\ToWhite\family20120403X\00待整理區\photo0820\d.jpg

ii I:\ToWhite\Photo20150819\msi-D\En-study 

3gp	0
3gp	2
3gp	3
3gpp	0
aac	0
aac	3
ai	0
amr	0
amr	3
apk	0
AVI	0
avi	2
avi	3
bak	0
BDM	0
BDM	3
cdr	0
cdr	3
CPI	4
CTG	0
CTG	2
CTG	3
DAT	0
DAT	3
db	4
doc	0
doc	2
doc	3
doc	4
docx	0
docx	1
docx	2
docx	3
docx	4
dotx	0
DS_Store	4
dthumb	0
dthumb	3
eps	0
ETG	0
ETG	3
exe	0
exe	2
exe	3
flv	0
flv	3
gif	0
gif	3
ini	0
ini	4
iso	0
jpeg	0
jpg	0
jpg	1
jpg	2
jpg	3
jpg_170x128	4
jpg_320x240	4
jpg_56x42	4
lnk	0
lnk	3
m4a	0
mht	0
MOV	0
MOV	2
MOV	3
mp3	0
mp3	2
mp4	0
mp4	2
MP4	3
mp4_170x128	0
mp4_320x240	0
mp4_56x42	0
MPG	0
MPG	3
MPL	0
MPL	3
MTS	0
MTS	2
MTS	3
ogg	0
PCX	0
PCX	3
pdf	0
pdf	1
pdf	2
pdf	3
png	0
png	3
ppt	0
pptx	0
psd	0
psd	3
rar	0
rar	2
rar	3
srt	0
swf	0
TBL	0
TBL	3
TDT	0
TDT	2
TDT	3
TGA	0
TGA	3
THM	0
THM	3
TID	0
TID	2
TID	3
TIF	0
TIF	3
tmp	0
tmp	3
tmp	4
txt	0
WAV	0
WAV	3
wma	0
wma	3
wmv	0
xls	0
xlsx	0
xlsx	4
zip	0



#-------------------------------------------------------------------------------------

select   distinct FilePhotoPath
from FilePhotoListS  where onoff='2' 
order by  FilePhotoPath--,filename



select count(ONOFF)
from FilePhotoListS  where ONOFF in ('2') and FilePhotoPath='200509_V0006_E0000'


select FilePhotoPath , filename,ONOFF ,FileLastWriteTime,FileLength,FileOrgPath
from FilePhotoListS  where ONOFF in ('0','2') and FilePhotoPath='200509_V0006_E0000'
order by  filename--,filename 

update FilePhotoListS  set onoff=6 where ONOFF in ('2') and FilePhotoPath='200507_V0005_E0000'

---
#-------------------------------------------------------------------------------------
200507_V0005_E0000


200509_V0006_E0000
200510_V0007_E0000
200609_V0107_E0000
200701_V0111_E0000
200708_V0206_E0000
200709_V0207_E0000
200712_V0209_E0000
200802_V0300_E0000
200803_V0300_E0000
200803_V0301_E0000
200804_V0301_E0000
200804_V0302_E0000
200805_V0302_E0000
200806_V0304_E0000
200807_V0305_E0000
200808_V0306_E0000
200810_V0307_E0000
200810_V0308_E0000
200811_V0308_E0000
200811_V0309_E0000
200812_V0309_E0000
200812_V0310_E0000
200902_V0400_E0000
200903_V0400_E0000
200903_V0401_E0000
200904_V0401_E0000
200904_V0402_E0000
200905_V0403_E0000
200907_V0404_E0000
200912_V0410_E0000
201003_V0501_E0000
201005_V0502_E0000
201007_V0504_E0000
201007_V0505_E0000
201008_V0506_E0000
201009_V0507_E0000
201012_V0510_E0000
201102_V0600_E0000
201106_V0603_E0000
201106_V0604_E0000
201108_V0606_E0002
201109_V0606_E0003
201109_V0607_E0003
201201_V0611_E0007
201202_V0611_E0008
201204_V0702_E0010
201207_V0704_E0101
201207_V0705_E0101
201208_V0706_E0102
201209_V0707_E0103
201211_V0709_E0105
201212_V0710_E0106
201302_V0800_E0108
201303_V0801_E0109
201312_V0810_E0206
201401_V0811_E0207
201402_V0811_E0207
201402_V0900_E0208
201404_V0902_E0210
201405_V0902_E0210
201405_V0902_E0211
201405_V0903_E0211
201406_V0903_E0211
201406_V0903_E0300
201406_V0904_E0300
201407_V0904_E0301
201407_V0905_E0301
201408_V0905_E0302
201408_V0906_E0302
201409_V0907_E0303
201410_V0907_E0303
201410_V0907_E0304
201410_V0908_E0304
201411_V0909_E0305
201412_V0910_E0306
201501_V0911_E0307
201502_V0911_E0307
201502_V0911_E0308
201502_V1000_E0308
201503_V1000_E0308
201503_V1000_E0309
201503_V1001_E0309
201504_V1002_E0310
201505_V1003_E0311
201506_V1003_E0400
201507_V1004_E0400