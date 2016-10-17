<#-----------------------------------
#  OS08_System
 
filelocation : 
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS08_System.ps1

C:\Users\administrator.CSD\SkyDrive\download\ps1\OS08_System.ps1


#CreateDate:  release
#last update : Jan.18.2014 
LastDate : APR.27.2014Author :Ming Tseng  ,a0921887912@gmail.com

Powershell HTTP Request
Networkremark    (IIS, Http request ,creds   , gsv , gps)

  $ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS08_System.ps1

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
________________________________________________________________________________________________________________________________________

# 01        Get-WmiObject  Gwmi
# 02        credential (Non-AD) 
# 03   60   Disk using gwmi
# 03-1 150  10500 Checking disk space usage using gwmi  p133
# 04   200  Stop service with Gwmi & gsv
# 05   200  get BIOS
# 06        Get curent logonserver
# 07        IIS
# 08  277      Net.WebRequest     ping sp.csd.syscom
# 09  300   Net.Webclient
# 10  350   attempt a connection until it is able to do so
# 11        shows how many bytes a the webpage that you are downloading is
# 12        Gets content from a web page on the Internet
# 13  400   repeart
# 14        get-wmiobject 
# 15        Get computer system and hardware information
# 16  450   Get-ItemProperty   GET regedit value  Use PowerShell to Easily Create New Registry Keys
# 17  450  check node Port  open close
# 18  500   Network  , adapter  NetIPConfiguration
#  510   Enable Powershell ISE from Windows Server 2008 R2
#  550  Change file extension associations
#  596  Computer Startup shutdown , logon , logoff Scripts
#  620  Execute Powershell and Prompt User to choice 
#  650  Get  Share folder  Path of computer
#  679   language  input  惱人的輸入法問題  & 候選字



#  1999  temp











#-------------------------
# 01         Get-WmiObject  Gwmi
#-------------------------

gwmi  Win32_Service -Credential WIN-MING\administrator -ComputerName WIN-MING
gwmi  Win32_Service -Credential pmd\administrator      -ComputerName PM001

#-------------------------
#02          credential (Non-AD) 
#-------------------------


$secpasswd = ConvertTo-SecureString "p@ssw0rd1" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "PMD\administrator",$secpasswd
gwmi  Win32_Service -Credential $credential -ComputerName PM001  # workable
icm -ComputerName PM001  {gsv} -Credential  $credential  # nonworkable

gwmi   Win32_Service  -ComputerName WIN-MING
gwmi win32_service -Filter "name='WinRM'"-ComputerName WIN-MING

#-------------------------
# 03   60   Disk using gwmi
#-------------------------
$y=get-WMIObject Win32_Volume | select Name, Label, Freespace, ` Filesystem, BlockSize, Capacity 
$y[0].name;$y[0].Label;$y[0].Capacity
$y[1].name;$y[1].Label;$y[1].Capacity;($y[1].Capacity)/1000000000
$y[2].name;$y[2].Label;($y[2].Freespace)/1073741824;($y[2].Capacity)/1073741824
$y[$y.Count-3].name;$y[3].Label;$y[3].Capacity;($y[3].Capacity)/1073741824
$y.Count |Ft
 
 $y| select *
 
 
 $Filter = @{Expression={$_.Name};Label="DiskName"}, `
          @{Expression={$_.Label};Label="Label"}, `
          @{Expression={$_.FileSystem};Label="FileSystem"}, `
          @{Expression={[int]$($_.BlockSize/1KB)};Label="BlockSizeKB"}, `
          @{Expression={[int]$($_.Capacity/1GB)};Label="CapacityGB"}, `
          @{Expression={[int]$($_.Freespace/1GB)};Label="FreeSpaceGB"}
Get-WmiObject Win32_Volume -ComputerName sql2012x | Format-Table $Filter -AutoSize

Get-WmiObject win32_volume -ComputerName spm |select *

gwmi win32_logicaldisk| select * ft -AutoSize
gwmi win32_volume  |select SystemName,name,DriveLetter, @Expression={[int]$($_.Capacity/1GB)}

$t=gwmi win32_logicaldisk -ComputerName sql2012x -Filter "FileSystem='NTFS'" |select name,size,freespace
gwmi win32_logicaldisk -ComputerName sql2012x -Filter "FileSystem='NTFS'" |select name,size,freespace
$t[0].name;$t[0].size;($t[0].freespace)/1073741824;
$a=[math]::round(($t[0].size)/1073741824, 0)
$b=[math]::round(($t[0].freespace)/1073741824, 0)
$a;$b
"{0:P0}" -f ($b/$a)

$Filter = @{Expression={$_.DriveLetter};Label="DriveLetter"}, `
          @{Expression={$_.Label};Label="Label"}, `
          #@{Expression={$_.FileSystem};Label="FileSystem"}, `
          @{Expression={[int]$($_.BlockSize/1KB)};Label="BlockSizeKB"}, `
          @{Expression={[int]$($_.Capacity/1GB)};Label="CapacityGB"}, `
          @{Expression={[int]$($_.Freespace/1GB)};Label="FreeSpaceGB"}
$diskx=gwmi Win32_Volume -ComputerName sql2012x | Format-Table $Filter -AutoSize
$diskx.capacityGB
$diskx=gwmi Win32_Volume  $r=gwmi -Query "select * from win32_service where name='WinRM'" -ComputerName sp2013, sql2012x `
 | select PSComputerName, ExitCode, Name, ProcessID, StartMode, State, Status
$diskx -filter "DriveLetter='c'"


$x=Get-WmiObject win32_service  |select name ,  StartMode  -filter "name='WinRM'"
$x[0].StartMode

gwmi Win32_Volume 


##
$r=gwmi -Query "select * from win32_service where name='WinRM'" -ComputerName sp2013, sql2012x `
 | select PSComputerName, ExitCode, Name, ProcessID, StartMode, State, Status

$w=gwmi win32_service -Filter "name='WinRM'"-ComputerName sp2013, sql2012x `
 | select PSComputerName, ExitCode, Name, ProcessID, StartMode, State, Status

 $r[0].PSComputerName
 $r[1].PSComputerName; $R[1].Name;$R[1].ProcessID;$R[1].StartMode;$R[1].State;$R[1].Status





#---------------------------------------------------------------
#  03-1  150  10500 Checking disk space usage using gwmi  p133
#---------------------------------------------------------------
#get server list
$servers = @("PMD","sql2012x")
#this can come from a file instead of hardcoding the servers
#servers = Get-Content <filename>

gwmi -ComputerName $servers -Class Win32_Volume |
select @{N="systemName";E={$_.systemname}} `
,@{N="Name";E={$_.Name}} `
,@{N="DriveLetter";E={$_.DriveLetter}} `
,@{N="DeviceType";E={switch ($_.DriveType){0 {"Unknown"}
1 {"No Root Directory"}
2 {"Removable Disk"}
3 {"Local Disk"}
4 {"Network Drive"}
5 {"Compact Disk"}
6 {"RAM"}
}};} `
,@{N="Size(GB)";E={"{0:N1}" -f($_.Capacity/1GB)}}`
,@{N="FreeSpace(GB)";E={"{0:N1}" -f($_.FreeSpace/1GB)}} `
,@{N="FreeSpacePercent";E={if ($_.Capacity -gt 0){"{0:P0}" -f($_.FreeSpace/$_.Capacity)}else{0}}} `
 |Format-Table -AutoSize



gwmi -ComputerName $servers -Class Win32_Volume |
Select @{N="Name";E={$_.Name}},
@{N="DriveLetter";E={$_.DriveLetter}},@{N="DeviceType";
E={switch ($_.DriveType)
{
0 {"Unknown"}
1 {"No Root Directory"}
2 {"Removable Disk"}
3 {"Local Disk"}
4 {"Network Drive"}
5 {"Compact Disk"}
6 {"RAM"}
}};
},@{N="Size(GB)";E={"{0:N1}" -f($_.Capacity/1GB)}},
@{N="FreeSpace(GB)";E={"{0:N1}" -f($_.FreeSpace/1GB)}},
@{N="FreeSpacePercent";E={
if ($_.Capacity -gt 0)
{
"{0:P0}" -f($_.FreeSpace/$_.Capacity)
}
else
{
0}}} |
Format-Table -AutoSize

## We can also shorten this by using N for Name and E for Expression:
Select @{Name="Name";Expression={$_.Name}},
Select @{N="Name";E={$_.Name}},


#-------------------------
# 04  200  Stop service with Gwmi & gsv
#-------------------------
(gwmi -Class Win32_Service -Filter "name='MSSQLSERVER'" -ComputerName sql2012x).StopService()
(gwmi -Class Win32_Service -Filter "name='MSSQLSERVER'" -ComputerName sql2012x).Status
(gsv -Name MSSQLSERVER -ComputerName sql2012x).Status

#-------------------------
# 05  200  get BIOS
#-------------------------
gwmi  Win32_Bios | select *
gwmi  Win32_Bios | FL -Property






#-------------------------
#   06  Get curent logonserver
#-------------------------
#-[System.Environment]::GetEnvironmentVariable("logonserver")

#-$ServerInstences | % {Invoke-Sqlcmd -Query 'drop table PS_Table' -ServerInstance $_ -Database $DBName }

#-------------------------
# IIS admin   Application Pools, Web sites, Web applications and virtual directories
#-------------------------
Get-Website 



#-------------------------
# 07    IIS
#-------------------------
Import-Module WebApplication -DisableNameChecking

$Servername = "Your Server Name"
$Sitename = "Name of your IIS Site"
Get-Counter "\\web service($SiteName)\current connections"


Get-Counter -ListSet *
Get-Module
Get-WebApplication -Site "Default Web Site"
Get-website 

icm -comp sp2013wfe { Import-Module WebApplication;  Get-website  }
icm -comp sql2012x {   Get-website  }
Get-Website | select name
#-------------------------
# 08   277 Net.WebRequest     ping sp.csd.syscom
#-------------------------
$webp="http://ss2.csd.syscom/test.aspx"
$webp="http://sp.csd.syscom"$webp="http://sp.csd.syscom/BDR-0/default.aspx","http://sp.csd.syscom/BDR-0/Documents/Forms/AllItems.aspx"`,"http://sp.csd.syscom/Shared%20Documents/Forms/AllItems.aspx"`,"http://sp.csd.syscom/Lists/Calendar/calendar.aspx"`,"http://sp.csd.syscom/winword/Forms/AllItems.aspx"`,"http://sp.csd.syscom/BICenterSite-0/Pages/Default.aspx"`,"http://sp.csd.syscom"

$x=1
$t1=Get-date
do
{
$x+=1    
$x
foreach ($item in $webp) {
           $item
           
           $webRequest = [net.WebRequest]::Create($item )
           $webrequest.Credentials=new-object System.Net.NetworkCredential ("sql1", "p@ssw0rd", "csd.syscom")
           $webrequest.UseDefaultCredentials = $true
           $webrequest.GetResponse()
          
       }       }
until ($x -gt 100)$t2=get-date($t2-$t1).TotalSeconds$webp[1];  $webp[2]$webRequest = [net.WebRequest]::Create($webp[1])
$webrequest.Credentials=new-object System.Net.NetworkCredential ("ww", "p@ssw0rd", "csd.syscom")
$webrequest.UseDefaultCredentials = $true
#$webRequest | gm

$webrequest.GetResponse()

$webrequestx.GetResponse()

$webp="http://sp.csd.syscom"$webRequestx = [net.WebRequest]::Create($webp)
$webrequestx.Credentials=new-object System.Net.NetworkCredential ("ming", "p@ssw0rd", "csd.syscom")
$webrequestx.UseDefaultCredentials = $true
$webrequestx.GetResponse()









#-------------------------
# 09  300 Net.Webclient
#-------------------------
# method1
$webp="http://ss2.csd.syscom/test.aspx"
$web=New-Object Net.Webclient
$web |gm
$web.DownloadString("http://ss2.csd.syscom")


$web.DownloadString("http://ss2.csd.syscom/test3.aspx")


try
{
    $web.DownloadString("http://ss2.csd.syscom/test3.aspx")
}
catch 
{
    Write-Warning "$($error[0])"
}


# method2
$r = [System.Net.WebRequest]::Create("http://url/")
$resp = $r.GetResponse()
$reqstream = $resp.GetResponseStream()
$sr = new-object System.IO.StreamReader $reqstream
$result = $sr.ReadToEnd()
write-host $result
 
 $r = Invoke-WebRequest ss2.csd.syscom

 Invoke-RestMethod
 With Powershell v3.0, you have Invoke-WebRequest and Invoke-RestMethod cmdlets which can be used for similar purposes
#-----------------------------------------------
#10 350  attempt a connection until it is able to do so
#-----------------------------------------------
 Begin{   
    $webobject = New-Object System.Net.WebClient
    $flag = $false
    $webpage='http://ss2.csd.syscom/test2.aspx'    ping ss2.csd.syscomProcess{
    While ($flag -eq $false) {
        Try {
            $webobject.DownloadString($webpage)
            $flag = $True
            }
        Catch {
            Write-host -fore Red  "Access down..."
           # Write-host -fore Red -nonewline "Access down..."

            }
        }
    }    end
{ Write-Host -fore Green "Access is back"}
#-------------------------
# 11  shows how many bytes a the webpage that you are downloading is
#-------------------------$webp="http://sp.csd.syscom"

$t1=get-date$webclient = new-object System.Net.WebClient
$webclient.Credentials = new-object System.Net.NetworkCredential ("administrator", "p@ssw0rd", "csd.syscom")
$webClient.UseDefaultCredentials = $true
$webpage = $webclient.DownloadString($webp)$t2=get-date($t2-$t1).TotalSeconds


$downsize="{0} bytes" -f ($webclient.DownloadString($webp)).length.toString("###,###,##0");$downsize



#-------------------------
# 12  Gets content from a web page on the Internet.
#-------------------------



#-------------------------
# 13  400   repeart
#-------------------------
$x=1
do
{
   clear
 
    get-counter "\\sp2013\web service(Default Web Site)\current connections"
    sleep 1
    get-counter "\\sp2013\web service(Default Web Site)\current connections"
    sleep 1
}
until ($x -gt10)



$x=1
do
{
   clear
 
    Get-counter "\\DGPAP1\web service(sp)\current connections"
    sleep 1
    Get-counter "\\DGPAP1\web service(sp2)\current connections"

 
    sleep 1
}
until ($x -gt10)



icm -comp DGPAP1 {gps w3wp}
icm -comp DGPAP1 {gps w3wp |Stop-Process -name w3wp  -Confirm  -passthru }


#-------------------------
#   14  get-wmiobject 
#-------------------------
Get-WmiObject Aliases :gwmi
## get all Gwmi 
gwmi -List *
gwmi -List *process*

## 
 
gsv -Name '*sql*'
gsv | ? DisplayName -notlike 'SQL*'

#-----------------------------------------------
# 15 450   Get computer system and hardware information
#-----------------------------------------------


$computerSystem = get-wmiobject Win32_ComputerSystem ; 
$computerBIOS = get-wmiobject Win32_BIOS   ; $computerBIOS |select * 
$computerOS = get-wmiobject Win32_OperatingSystem  ; $computerOS |select * 
cls"System Information for: " + $computerSystem.Name
"""Manufacturer: " + $computerSystem.Manufacturer"Model: " + $computerSystem.Model"Serial Number: " + $computerBIOS.SerialNumber"Operating System: " + $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion"Total Memory in Gigabytes: " + $computerSystem.TotalPhysicalMemory/1gb"User logged In: " + $computerSystem.UserName"Last Reboot: " + $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)





#-----------------------------------------------
# 16 450 Get-ItemProperty   GET regedit value    Use PowerShell to Easily Create New Registry Keys
#-----------------------------------------------
use administrator

  $pInstanceName='MSSQLServer'
       $path='HKLM:\SOFTWARE\Microsoft\MSSQLServer\MSSQLServer\SuperSocketNetLib\Tcp'
       $SQLPort=icm -ComputerName 'DGPAP1' {param($path) (Get-ItemProperty -path $path).TcpPort } -ArgumentList $path
# get
regedit
get-psdrive  (HKLM: HKEY_LOCAL_MACHINE , HKCU: HKEY_CURRENT_USER)
cd HKLM:\
cd HKCU:\

cd 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'; ls  


HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout
# new & set


New-Item -Path HKCU:\Software -Name MING –Force
cd 'HKCU:\Software'
Set-Item -Path HKCU:\Software\MING -Value “MING key”

Md "HKCU:\Software\Testing\" 
New-ItemProperty "HKCU:\Software\Testing\" -Name "MyValue" -Value 12 -PropertyType "DWord" 

New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" `
-Name "IgnoreRemoteKeyboardLayout" -Value 1 -PropertyType "DWord" 



# delete 

Remove-Item -Path HKCU:\Software\MING

#-------------------------
# 17 450  check node Port  open close
#-------------------------
function checknodePort ($node,$port)
{#1

$tcpclient = New-object System.Net.Sockets.TcpClient
$async=$tcpclient.beginConnect($node,$port,$Null,$null)
sleep 1

$wait=$async.AsyncWaitHandle.WaitOne($timeout,$false)
if (-Not $wait)
{#2
 $node +' Port:  '+   $port +'  close'
}#2
else
{#2
$node +' Port:  '+   $port +'  open'
}#2

}#1

checknodePort  "172.16.201.147" 139

for($i=22; $i -lt 500 ; $i++)
{
checknodePort  "172.16.220.194" $i
checknodePort  "172.16.201.147" $i
}

$ps='137','138','139','445'#,'389','445','464','138'
foreach ($p in $ps )
{
checknodePort  "172.16.220.40" $p
}
telnet 172.16.220.40 139

net use \\172.16.201.147\cluster /User:ming 'p@ssw0rd'
net use \\172.16.201.147\cluster /User:ming 'p@ssw0rd'

#----------------------------------------------
# 18 500  Network  , adapter  NetIPConfiguration
#----------------------------------------------
Get-NetIPAddress


Get-NetAdapter


gip = Get-NetIPConfiguration
GIP -Detailed



Test-NetConnection

$PSVersionTable.PSVersion


#----------------------------------------------
# 510   Enable Powershell ISE from Windows Server 2008 R2  + Windows  2003 R2
#----------------------------------------------

 Import-Module ServerManager 
 Add-WindowsFeature PowerShell-ISE


 #Using Server Explorer

Open the Server Explorer
Navigate to the Features Node
Right-click on Features node, select “Add Features”
You will get Add Features wizard with list of features provided with checkboxes.
Check the “Windows PowerShell Integrated Scripting Environment (ISE)”
Click on Next button
Click on Install button


# Windows  2003 R2

http://blogs.technet.com/b/danstolts/archive/2011/03/07/how-to-install-powershell-on-windows-server-2003-and-enable-remote-powershell-management-all-servers-should-have-this-done.aspx

Windows   https://support.microsoft.com/en-us/kb/968929

DownloadDownload the Windows Management Framework Core for Windows Server 2003 package now.

WindowsServer2003-KB968930-x86-CHT.exe

DownloadDownload the Windows Management Framework Core for Windows Server 2003 x64 Edition package now.

WindowsServer2003-KB968930-x64-CHT.exe


#----------------------------------------------
#  550  Change file extension associations
#----------------------------------------------
in MSDOS model

PS C:\Users\Administrator> cmd
Microsoft Windows [版本 6.3.9600]
(c) 2013 Microsoft Corporation. All rights reserved.

C:\Users\Administrator>assoc .txt  # 
.txt=txtfile                       #先找出來 txt 的 txtfile 

C:\Users\Administrator>ftype txtfile  # 使用 ftype 得知 由什麼program 來
txtfile=%SystemRoot%\system32\NOTEPAD.EXE %1 

HOW TO SETup  ps1 default open  Powershell_ise  
$env:path
<#
C:\Windows\system32
;C:\Windows;C:\Windows\System32\Wbem
;C:\Windows\System32\WindowsPowerShell\v1.0\
;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\
;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\
;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\
;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\
;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\
;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\


C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe

#>


C:\Users\Administrator>


C:\Users\Administrator>
ftype Microsoft.PowerShellScript.1="C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe" "%1"

Microsoft.PowerShellScript.1="C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe" "%1"

 #這樣子就可以設定 .ps1 由 powershell_ise 開啟


#----------------------------------------------
#  596  Computer Startup shutdown , logon , logoff Scripts   Aug.25.2015
#----------------------------------------------

方法有二, 1是taskscd的 atstartup  1是 gpedit.msc
$Trigger = New-ScheduledTaskTrigger -AtStartup
    Register-ScheduledJob -Name ResumeWorkflow -Trigger $Trigger -ScriptBlock { Import-Module PSWorkflow; Get-Job -State Suspended | Resume-Job }
    


#1 
make a ps1 like email 
#2
gpedit.msc

#
Computer Configuration > Windows Settings > Scripts (Startup/Shutdown)  > startup > powershell script > new  
   exeut : powershell
   parameter :  -file  C:\PerfLogs\reboot6005.ps1




#----------------------------------------------
#  620  Execute Powershell and Prompt User to choice Sep.03.2015
#----------------------------------------------
$myCommand = 'Add-WindowsFeature ,Windows-Identity-Foundation,Server-Media-Foundation,Xps-Viewer -source C:\sxs '
 $operation = Invoke-Expression $myCommand 
  if ($operation.RestartNeeded -eq "Yes") { 
        
      	   #Prompt User for Restart
	   $title = "Restart your server now?"
	   $message = "Would you like to restart your server now? It is required to complete the Windows Role/Feature Installation."

	   $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
	         "Restarts your Windows Server 2012 server now to complete the Role/Feature installation."

	   $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
	    "Does not restart your server now... But you should..."

	   $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

	   $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

	   switch ($result)
	   {
	        0 {Restart-Computer;}
	        1 {"Your server will not restart at this time. Before installing the Pre-requisite files, restart your computer."}
	   }


        }
#----------------------------------------------
#  650  Get  Share folder  Path of computer
#----------------------------------------------
gwmi -Class win32_share -ComputerName PMD2016
gwmi -Class win32_share -ComputerName sql2014x
gwmi -Class win32_share -ComputerName 2016Bi


#----------------------------------------------
#  679    language  input
#----------------------------------------------
as adminsitrator UI

http://www.weithenn.org/2014/07/windows-server-2012-r2-keyboard-layout.html
> control 
> language >new language  > 9筆  > english > english (United States) >  up 
>  控制台\時鐘、語言和區域\語言
   控制台\時鐘、語言和區域\語言\進階設定  > 覆寫預設輸入法  > 英文(美國)-US


   New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" `
-Name "IgnoreRemoteKeyboardLayout" -Value 1 -PropertyType "DWord" 

shutdown -s -f
  
 
 http://welovewindows.hk/post19016
 #--

 (2)當然大家亦可以自行建立登錄檔, 大家只需要在桌面上按右鍵>新增文件檔, 再把以下相應的文字複制到記事本內 並另存新檔為 .REG 副檔名的登錄檔就可以了!

 速成機碼如下:
'D:\OneDrive_SYSCOM690303\OneDrive - SYSCOM COMPUTER ENGINEERING CO\Microsoft\WindowsX\quick_input.reg'
 

Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{6024B45F-5C54-11D4-B921-0080C882687E}]
"IconFile"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,\
  74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,49,\
  00,4d,00,45,00,5c,00,49,00,4d,00,45,00,54,00,43,00,31,00,30,00,5c,00,49,00,\
  6d,00,54,00,43,00,54,00,69,00,70,00,2e,00,44,00,4c,00,4c,00,00,00
"Display Description"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,\
  52,00,6f,00,6f,00,74,00,25,00,5c,00,53,00,59,00,53,00,54,00,45,00,4d,00,33,\
  00,32,00,5c,00,69,00,6e,00,70,00,75,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,\
  2d,00,35,00,31,00,31,00,31,00,00,00
"Enable"=dword:00000000
"IconIndex"=dword:00000005
"Description"="Microsoft Quick (Old)"
"ProfileFlags"=dword:00000004



 
 進入選項後按"新增輸入法"
 如果登錄碼成功修改系統設定的話, 大家就會出現以下畫面, 點選 “IME" 微軟速成/倉頡 並按"新增"

假設大家未能找到IME 速成/倉頡的話, 可以重新啟動電腦一次再試。
成功新增輸入法後, 大家會發現新增的速成/倉頡左邊是沒有圖示的, 而且在語言設定頁內更會有"選項"呢!
以速成為例, 大家可以自由設定侯選字的大小, 反查輸入字根及相關字詞等有用選項

#----------------------------------------------
#  1999  temp
#----------------------------------------------