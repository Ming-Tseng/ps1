<#-----------------------------------
#  remote   OS06_remote

#Date:  release
#last update :  

\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\OS06_remote.ps1


1.Starts or restarts the WinRM service
2. Sets the WinRM service startup type to Automatic
3. Creates a listener to accept requests from any Internet Protocol (IP) address
4. Enables inbound firewall exceptions for WSMAN traffic
5. Sets a target listener named Microsoft.powershell
6. Sets a target listener named Microsoft.powershell.workflow
7. Sets a target listener named Microsoft.powershell32

$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS06_remote.ps1

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
wf.msc

  -用戶端及遠端電腦位於不同的網域中，而且這兩個網域之間沒有信任關係。
 在檢查過上述問題之後，請嘗試下列動作:
  -在事件檢視器中，檢查與驗證相關的事件。
  -變更驗證方法; (1)將目的電腦新增至 WinRM 的 TrustedHosts 組態設定，(2)或是使用 HTTPS 傳輸。 (3) use New-Pssession 
# 1  firewall   netsh advfirewall firewall
# 2  Enable-PSRemoting
# 3 115  Creating a remote Windows PowerShell session
# 4  captures output from the remote Windows PowerShell session, as well as outputfrom the local session
# 5  Running a single Windows PowerShell command
# 189   驗證配置與 Kerberos 不同，或是用戶端電腦沒有加入網域， 到 TrustedHosts 組態設定中。
# 7  get all member machine info
# 8  Test-Connection
# 9  250   Get all computername pararmeter 
# 10 250  remote create scheuletasks 
# 310   turn on Winrm using AD Group Policy Editor
# 460  gwmi firewall port














#--------------------------------------------
# 1  firewall   netsh advfirewall firewall
#--------------------------------------------
Get-NetFirewallRule |Get-NetFirewallPortFilter

Get-NetFirewallPortFilter |select *


## Get

Specifies the network port on the remote computer used for this command. To connect to a remote computer,
 the remote computer must be listening on the port that the connection uses. 
 The default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Get-NetFirewallPortFilter | ?{ $_.LocalPort -Eq "5985" } |Get-NetFirewallRule #|select DisplayName
Get-NetFirewallPortFilter | ?{ $_.LocalPort -Eq "135" } |Get-NetFirewallRule #|select DisplayName




netsh advfirewall firewall show rule name=all profile=any dir=in  # profile=Domain,Private,Public,any
netsh advfirewall firewall show rule name=all profile=any dir=out
netsh advfirewall firewall show rule name=sql1433 profile=any
netsh advfirewall firewall show rule name="遠端桌面 - 使用者模式 (TCP-In)" profile=any
netsh advfirewall firewall show  LocalPort=1433  profile=any

## New
New-NetFirewallRule -DisplayName "SQL7025" -Direction Inbound –LocalPort 7025 -Protocol TCP -Action Allow

netsh advfirewall firewall add rule name="SQL7024" dir=in localport=7024 protocol=TCP action=allow

##  set

Set-NetFirewallRule -DisplayGroup "SQL7025" -Enabled True

netsh advfirewall firewall set rule name="SQL7024"  new enable=no
netsh advfirewall firewall set rule name="SQL7024"  new enable=yes

## Delete
#delete rule name=all protocol=tcp localport=80

Remove-NetFirewallRule -DisplayName "SQL7025"
Netsh advfirewall firewall Delete rule name="SQL7024"  

#--------------------------------------------
#2 Enable-PSRemoting  Port 445, 5985
#--------------------------------------------


Test-WSMan -ComputerName PMD2016
Test-WSMan -ComputerName DGPAP2

Enable-PSRemoting  -Force  # Note: firewall port  5985 
Get-counter  use port
Disable-PSRemoting
<#
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
#>

telnet PMD2016 5985

#--------------------------------------------
# 3   115  Creating a remote Windows PowerShell session
#--------------------------------------------



#-----Get
Get-PSSession ;gsn
Get-PSSession -Name sessPMD1

$sess = New-PSSession  -Name sesslocal

#-----New 



#( non-Domain)

$secpasswdPMD = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credPMD = New-Object System.Management.Automation.PSCredential "PMD\administrator",$secpasswdPMD
$cred2=Get-Credential
New-PSSession -ComputerName PMD -Credential $credPMD
icm -ComputerName PMD -Credential $credPMD -ScriptBlock {hostname}
icm -ComputerName PMD -Credential $credPMD -ScriptBlock {whoami}

$secpasswdPMD2016 = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credPMD2016 = New-Object System.Management.Automation.PSCredential "pmocsd\infra1",$secpasswdPMD2016
icm -ComputerName PMD2016 -Credential $credPMD2016 -ScriptBlock {hostname;get-date}


# one session multimachine
$sessBoth=New-pssession -ComputerName sql2014x,2016BI -Name sessboth
ping 2016bi



#-----Enter  & exit
$sessPMD1=New-PSSession -ComputerName PMD -Credential $credPMD -Name sessPMD1
$sessPMD2=New-PSSession -ComputerName PMD -Credential $credPMD -Name sessPMD2
$sessPMD3=New-PSSession -ComputerName PMD -Credential $credPMD -Name  sessPMD3 ;gsn
$sessPMD2016A=New-PSSession -ComputerName PMD2016 -Credential $credPMD2016 -Name  sessPMD2016A ;gsn

icm  -session $sessPMD2016A -ScriptBlock {}

Enter-PSSession -Name sessPMD3 ;get-pssnapin  | ft -auto
Enter-PSSession -ComputerName PMD

exit-pssession


icm -session $sessPMD2 -ScriptBlock {hostname;get-date}
icm -comp sql2014x -ScriptBlock {hostname;get-date}


#-----remove
Get-PSSession |remove-PSSession 

gsn | rsn

#import-pssession
$sess = New-PSSession  -Name sesslocal
Import-PSSession $sess



New-PSSession -ComputerName PMD2016 -Credential $cred2
icm -ComputerName PMD2016 -Credential $cred2 -ScriptBlock {whoami}

Remove-PSSession -Id 34


ssms


##Get-PSSession | Remove-PSSession -id 72

$sql2012x = New-PSSession -ComputerName sql2012x -Credential csd\administrator
Enter-PSSession -ComputerName sp2013wfe
hostname

Get-Service -DisplayName 'SharePoint Administration'
Add-PSSnapin Microsoft.SharePoint.PowerShell
Hostname
Get-spserver |out-file e:\scripts\cc.txt
Get-SPWebApplication |out-file H:\scripts\cc.txt

exit  ; 

Get-WSManCredSSP


:example
$secpasswdPMD = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credPMD = New-Object System.Management.Automation.PSCredential "PMD\administrator",$secpasswdPMD
$secpasswdPMD2016 = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credPMD2016 = New-Object System.Management.Automation.PSCredential "pmocsd\infra1",$secpasswdPMD2016
$sessPMDA=New-PSSession -ComputerName PMD -Credential $credPMD -Name sessPMD1
$sessPMD2016A=New-PSSession -ComputerName PMD2016 -Credential $credPMD2016 -Name  sessPMD2016A ;
gsn

icm -Session $sessPMDA {gsv}
icm -Session $sessPMD2016A {gsv}
icm -Session $sessPMD2016A,$sessPMDA  {gsv}


#--------------------------------------------
# 4 captures output from the remote Windows PowerShell session, as well as outputfrom the local session
#--------------------------------------------

## Get
Get-PSSession

## new 

just run at powershell 
Start-Transcript
Enter-PSSession -ComputerName DGPAP1
gwmi win32_bios   | out-file  \\SP2013\repldata\t1223.txt
exit
Stop-Transcript

# 

##Remove-PSSession
Remove-PSSession -Id 1
Remove-PSSession  $DGPAP1

#--------------------------------------------
#5  Running a single Windows PowerShell command
#--------------------------------------------


## create
Invoke-Command -ComputerName DGPAP2 -ScriptBlock {gps |select -last 1}


icm -ComputerName sp2013wfe  {netsh advfirewall firewall show rule name=all profile=any dir=in}

icm -ComputerName DGPAP2  {Get-counter "\Processor(*)\% Processor Time" -SampleInterval 2 -MaxSamples 2}

Get-counter "\Processor(*)\% Processor Time" -SampleInterval 2 -MaxSamples 2 -ComputerName DGPAP2
Get-counter "\Processor(*)\% Processor Time" -SampleInterval 2 -MaxSamples 2 -ComputerName DGPAP1

icm -ComputerName sp2013wfe  {Get-NetFirewallPortFilter | ?{ $_.LocalPort -Eq "7026" } |Get-NetFirewallRule}
icm -ComputerName sp2013wfe  {New-NetFirewallRule -DisplayName "SQL7026" -Direction Inbound –LocalPort 7026 -Protocol TCP -Action Allow }
icm -ComputerName sp2013wfe  {Set-NetFirewallRule -DisplayName "SQL7026" -Enable False}
icm -ComputerName sp2013wfe  {Remove-NetFirewallRule -DisplayName "SQL7026"}

$DGPAP1 = New-PSSession -ComputerName DGPAP1 -Credential csd\administrator
Invoke-Command -Session $DGPAP1 -ScriptBlock {hostname}

$sn1 = New-PSSession -ComputerName sp2013wfe 
icm -Session $sn1 -ScriptBlock {Add-PsSnapIn Microsoft.SharePoint.PowerShell}
icm -session $sn1 {. E:\scripts\GD.ps1}  # run ps1(file in remote)

Invoke-Command -FilePath 'H:\scripts\GD.ps1' -ComputerName sp2013wfe  # run ps1 (file in local machine)

##Remove-PSSession
Remove-PSSession -Id 1

Remove-PSSession  $DGPAP1



#--------------------------------------------
#  6  189 驗證配置與 Kerberos 不同，或是用戶端電腦沒有加入網域， 則必須使用 HTTPS 傳輸，或是
#   將  目標電腦(被控台(PMD))新增到 主控台(SP2013 TrustedHosts 組態設定中。 請使用 winrm.cmd 來設定 TrustedHosts
#--------------------------------------------


http://blogs.technet.com/b/heyscriptingguy/archive/2013/11/29/remoting-week-non-domain-remoting.aspx

ping pmd
$sess= New-PSSession -ComputerName PMD
$sess= New-PSSession -ComputerName 172.16.201.147

error message: The WinRM client cannot process the request. If the authentication scheme is different from Keberos.or if the client computer is not joined to a domaion , then HTTPS  transport must be used or the destination machine must be added to the TrustedHost configuration setting . 
Use winrm.cmd to configure TrustedHosts.Note that computers in th TrustedHosts list might not be authenticated .you can get more information about that by running the following command

solution :（１）install a SSL certificate and use HTTPS to connect to the remote machine
           (2) add the machine to the trusted host list

Get-Item -Path WSMan:\localhost\Client\TrustedHosts
Get-WSManInstance -ResourceURI winrm/config/client
' 
PS C:\Users\administrator.CSD> Get-Item -Path WSMan:\localhost\Client\TrustedHosts

 WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client

Type            Name                           SourceOfValue   Value                                                                                            
----            ----                           -------------   -----                                                                                            
System.String   TrustedHosts                                   PMD,172.16.201.147                                                                               



PS C:\Users\administrator.CSD> Get-WSManInstance -ResourceURI winrm/config/client


cfg              : http://schemas.microsoft.com/wbem/wsman/1/config/client
lang             : zh-TW
NetworkDelayms   : 5000
URLPrefix        : wsman
AllowUnencrypted : false
Auth             : Auth
DefaultPorts     : DefaultPorts
TrustedHosts     : PMD,172.16.201.147
'

Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value 'PMD'


Get-Help * -Parameter ComputerName

Get-Item WSMan:\localhost\Client\TrustedHosts 
Get-Item WSMan:\localhost\Client\TrustedHosts |fl name,value

    Connect-WSMan -ComputerName pmd
    test-wsman -computername pmd

    Connect-WSMan -ComputerName sql2014x

Get-WSManInstance -ResourceURI winrm/config/client

set-item -Path WSMan:\localhost\Client\TrustedHosts -Value 'PMD' -Force
set-item -Path WSMan:\localhost\Client\TrustedHosts -Value '172.16.201.147' -Concatenate -Force
set-item -Path WSMan:\localhost\Client\TrustedHosts -Value 'sp2013' -Concatenate -Force

Get-Item WSMan:\localhost\Client\TrustedHosts |fl name,value
icm -ComputerName pmd -ScriptBlock {get-date}
'
[pmd] 連線到遠端伺服器 pmd 失敗，傳回下列錯誤訊息: WinRM 無法處理要求。使用 Kerberos 驗證時發生下列錯誤: 找不到電腦 pmd。請確認電腦存在於網路上，且提供的名稱拼寫正確。 如需詳細資訊，請參閱 about_Remote_Troubleshooting 說明主題。
    + CategoryInfo          : OpenError: (pmd:String) [], PSRemotingTransportException
    + FullyQualifiedErrorId : NetworkPathNotFound,PSSessionStateBroken
'

$secpasswdPMD = ConvertTo-SecureString "p@ssw0rds" -AsPlainText -Force
$credPMD = New-Object System.Management.Automation.PSCredential "PMD\administrator",$secpasswdPMD
icm -ComputerName pmd -ScriptBlock {get-date} -Credential  $credPMD
'
Wednesday, November 18, 2015 9:20:32 AM

'

gsn
'
 gsn

 Id Name            ComputerName    State         ConfigurationName     Availability
 -- ----            ------------    -----         -----------------     ------------
  6 sessPMD2016A    PMD2016         Broken        Microsoft.PowerShell          None
  5 sessPMD1        PMD             Opened        Microsoft.PowerShell     Available
'

New-PSSession -ComputerName sql2014x

下列方式在某些版本可以執行.比較穩定為  加上$session  ,NOv.18.2015
<#

about_Remote_Troubleshooting


set-executionPolicy RemoteSigned
#1 start  run as administrator
#2 get-service winrm 
#3  To configure Windows PowerShell for remoting, type the following command:
Enable-PSRemoting –force #run as PMD(被控端)
Set-WSManQuickConfig     #run as PMD
WinRM Service GPO Configuration  (1) allow remote server management through WinRM
                                 (2)windows Powershell  remotesigned 
                                 (3)windows remote management  WinRM Client
                                                               WinRM Service

#4  if the remote computer is not in a trusted domain, the remote computer might not be able to authenticate your credentials.
To enable authentication, you need to add the remote computer to the list of trusted hosts for the local computer in WinRM. To do so, type: 
winrm s winrm/config/client '@{TrustedHosts="RemoteComputer"}'
#5  This command analyzes and configures the WinRM service.
winrm qc  #in the DOS

# get TrustedHosts
winrm get winrm/config/client
# drop TrustedHosts ,沒有法子刪除只有再重設一次,將不需要的Host 移走就可以
 Theres no way to remove a particular host or network from TrustedHosts, so you have to "reconstruct" the entire hash.
winrm set    winrm/config/client @{TrustedHosts=" "}
 

 icm -comp pmd2016 -ScriptBlock {hostname} # failure
icm -comp 172.16.201.144 -ScriptBlock {hostname} # failure

winrm help config

________________________________________________________________________________________________________________________________________

winrm g winrm/config # get TrustedHosts
winrm e winrm/config/listener

winrm set    winrm/config/client @{TrustedHosts="PMD2016"}  # in the DOS 要在 主控台(SP2013) 上設定被控台(PMD) 要在DOS上執行
winrm set    winrm/config/client @{TrustedHosts="SP2013"}   # in the DOS 要在 主控台(SP2013) 上設定被控台(PMD) 要在DOS上執行
winrm d winrm/config/client @{TrustedHosts="SP2013"}


winrm set winrm/config/client @{TrustedHosts="PMD2016"}  # in the DOS 
winrm set winrm/config/client @{TrustedHosts="PMD"}      # in the DOS


ping eventdb1
ping sp2013


winrm id -r:PMD

winrm help config
winrm -?
winrm d -?


範例: 接聽電腦上所有 IP 的 HTTP 要求:
  winrm create winrm/config/listener?Address=*+Transport=HTTP
icm -comp pmd -ScriptBlock {hostname} # failure

範例: 停用給定的接聽程式
  winrm set winrm/config/listener?Address=IP:1.2.3.4+Transport=HTTP @{Enabled="false"}

範例: 啟用用戶端上的基本驗證但不啟用服務:
  winrm set winrm/config/client/auth @{Basic="true"}

範例: 針對所有工作群組電腦啟用 Negotiate。
  winrm set winrm/config/client @{TrustedHosts="<local>"}


  PS C:\Windows\System32\WindowsPowerShell\v1.0> winrm qc 
WinRM 已設定為在此電腦上接收要求。
此電腦上的 WinRM 已設定為可接受遠端管理。

________________________________________________________________________________________________________________________________________



PS C:\Windows\System32\WindowsPowerShell\v1.0> winrm g winrm/config
Config
    MaxEnvelopeSizekb = 150
    MaxTimeoutms = 60000
    MaxBatchItems = 32000
    MaxProviderRequests = 4294967295
    Client
        NetworkDelayms = 5000
        URLPrefix = wsman
        AllowUnencrypted = false
        Auth
            Basic = true
            Digest = true
            Kerberos = true
            Negotiate = true
            Certificate = true
            CredSSP = false
        DefaultPorts
            HTTP = 5985
            HTTPS = 5986
        TrustedHosts
    Service
        RootSDDL = O:NSG:BAD:P(A;;GA;;;BA)S:P(AU;FA;GA;;;WD)(AU;SA;GWGX;;;WD)
        MaxConcurrentOperations = 4294967295
        MaxConcurrentOperationsPerUser = 15
        EnumerationTimeoutms = 60000
        MaxConnections = 25
        MaxPacketRetrievalTimeSeconds = 120
        AllowUnencrypted = false
        Auth
            Basic = false
            Kerberos = true
            Negotiate = true
            Certificate = false
            CredSSP = false
            CbtHardeningLevel = Relaxed
        DefaultPorts
            HTTP = 5985
            HTTPS = 5986
        IPv4Filter = *
        IPv6Filter = *
        EnableCompatibilityHttpListener = false
        EnableCompatibilityHttpsListener = false
        CertificateThumbprint
    Winrs
        AllowRemoteShellAccess = true
        IdleTimeout = 180000
        MaxConcurrentUsers = 5
        MaxShellRunTime = 2147483647
        MaxProcessesPerShell = 15
        MaxMemoryPerShellMB = 150
        MaxShellsPerUser = 5


________________________________________________________________________________________________________________________________________

PS C:\Windows\System32\WindowsPowerShell\v1.0> winrm e winrm/config/listener 
Listener
    Address = *
    Transport = HTTP
    Port = 5985
    Hostname
    Enabled = true
    URLPrefix = wsman
    CertificateThumbprint
    ListeningOn = 127.0.0.1, 172.16.201.147, 192.168.112.55, ::1, fe80::5efe:172.16.201.147%12, fe80::5efe:192.168.112.55%14, fe80::80e8:91
10:5d46:6e13%11, fe80::b515:20ad:ad61:d1c8%13


________________________________________________________________________________________________________________________________________

winrm set winrm/config/client @{TrustedHosts="PMD"}
#>
#--------------------------------------------
# 7. get all member machine info
#--------------------------------------------

$cn = "sp2013","sp2013wfe","sql2012x","2013BI","DGPAP1","DGPAP2"
$cred = get-credential csd\administrator
Invoke-Command -cn $cn -cred $cred -ScriptBlock {gwmi win32_bios}

#--------------------------------------------
# 8 Test-Connection
#--------------------------------------------
$x=Test-Connection spm; $x |gm  ;$x.StatusCode
if ($x.StatusCode -eq '0'){"online"} else {"offline"}

#--------------------------------------------
# 9 250   Get all computername pararmeter 
#--------------------------------------------

Get-Command  | where {$_.Parameters } 
Get-Command  "out*"

Stop-Computer -ComputerName


#--------------------------------------------
# 10 250  remote create scheuletasks 
#--------------------------------------------

$script={
$TaskStartTime    = "14:30:00" 
$TaskName         = "baseLine001"

$para_timespanlen='10'
$para_SampleInterval=5

$TaskDescr =  $TaskName +"  test length :"+ $para_timespanlen + " Min, run at "+$TaskStartTime +"   ,SampleInterval:" + $para_SampleInterval+"sec"
$TaskCommand = "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe"
$TaskScript  = "C:\PerfLogs\"+$TaskName+".ps1"
$TaskArg = "-WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted -file $TaskScript " + $para_timespanlen +" "+ $para_SampleInterval
$TaskAction = New-ScheduledTaskAction -Execute "$TaskCommand" -Argument "$TaskArg" $TaskTrigger = New-ScheduledTaskTrigger -At $TaskStartTime -Once

Register-ScheduledTask   -Action $TaskAction -Trigger $Tasktrigger -TaskName "$TaskName" -User "csd\administrator" -Password "p@ssw0rd"  `
-RunLevel Highest -Description $TaskDescr -Force 
}

icm -ComputerName sp2013 -ScriptBlock $script
#--------------------------------------------
# temp
#--------------------------------------------
Test-Connection sp2013wfe

icm -ComputerName sp2013wfe {gps | ? {$_.ProcessName -eq 'calc'}}
icm -ComputerName sp2013wfe {Stop-Process -Name 'calc'}


Invoke-Command -FilePath 'H:\scripts\GD.ps1' -ComputerName sp2013wfe


Invoke-Command -ComputerName DGPAP1 -ScriptBlock {gps |select -last 1}

Get-PSSession
Remove-PSSession -id 70
$sn1 = New-PSSession -ComputerName sp2013wfe 
icm -Session $sn1 -ScriptBlock {Add-PsSnapIn Microsoft.SharePoint.PowerShell}
icm -session $sn1 {. E:\scripts\GD.ps1}

icm -session $sn1 {Get-PSSnapin}

. H:\scripts\GD.ps1


Enter-PSSession -ComputerName sp2013wfe
notepad
calc

exit

icm -ComputerName sp2013wfe {c:\Windows\System32\notepad.exe}

$x=icm -ComputerName sp2013wfe {Hostname}

icm -ComputerName sp2013wfe {Stop-Process -name notepad   }


icm -ComputerName sp2013wfe {Stop-Process -Name 'calc'}

icm -ComputerName sp2013wfe {get-spserver}

icm -ComputerName sql2012x {gps | ? {$_.ProcessName -eq 'notepad'}}
icm -ComputerName sql2012x {notepad}


Enter-PSSession



get-spserver

#--------------------------------------------
# 310   turn on Winrm icm using AD Group Policy Editor
#--------------------------------------------
https://4sysops.com/archives/enable-powershell-remoting/

# (1)enable 
open your Group Policy Editor 
navigate to the following path: Computer Configuration\Policies\Administrative Templates\Windows Components\Windows Remote Management (WinRM)\WinRM Service
As you can see in the following screenshot, the policy that we enable is called Allow remote server management through WinRM, and we should both enable the policy and set the IPv4/IPv6 filters to all (*).


# (2) Set WinRM service to automatic startup
Second, we need to ensure that the WinRM service is set for automatic startup. 
Navigate to:   Computer Configuration\Policies\Windows Settings\Security Settings\System Services
Select the Windows Remote Management (WS-Management) service and set it for automatic startup.

# 3 Configure Windows Firewall  (wf.msc)
Computer Configuration\Policies\Windows Settings\Security Settings\Windows Firewall with Advanced Security\Windows Firewall with Advanced Security
You shall want to set inbound and outbound allowances for the Windows Remote Management predefined rule as shown in the following figure.

Cool! Now push out the Group Policy, reboot all affected computers, and you are done.

Windows 遠端管理 - 相容模式 (HTTP-In)  :80
Windows 遠端管理 (HTTP-In)  Windows 遠端管理 (透過 WS-Management 執行) 的輸入規則。[TCP 5985] : TCP 5985
Windows 遠端管理 (HTTP-In)  網域 私人  TCP 5985  <-- this a correct 


#--------------------------------------------
# 460  gwmi firewall port
#--------------------------------------------
gwmi open 

Windows Management Instrumentation (DCOM-In)  :135 
Windows Management Instrumentation (WMI-In)  允許遠端 Windows Management Instrumentation 之 WMI 流量的輸入規則。[TCP]

#--------------------------------------------
# 474   step by step      nov.09.2015
#--------------------------------------------

# control: sp2013 , controled : PMD
# get-counter  必須要開  DFS管理 (DCOM-IN:135  , SMB-In  : 445) + 需有 相同的　user account & pwd


#--- get-counter
whoami # csd\administrator
ping pmd2016  
ping 172.16.220.33 

get-counter -comp pmd  #pass  必須要開  DFS管理 (DCOM-IN:135  , SMB-In  : 445)

whoami  # csd\administrator @sp2013 , 
ping pmd2016  #192.168.112.144
get-counter -comp pmd2016 #failure # Pmd2016 ,sp2013 需有相同的　user account & pwd
get-counter -comp 192.168.112.144 # pass IP 可以過, 但是Hostname 不可以過???  原因如上.  (Pmd2016 ,sp2013 需有 相同的　user account & pwd)

telnet pmd2016 135
Get-counter -comp pmd2016  # if pmocsd\administrator 被停用.則就無法 Get
另一個測試 
# 登入使用  CSD\infra1 pwd: p@ssword (pmocsd\administrator被停用中 ) ,密碼也是需一致！
'
whoami #csd\infra1
Get-counter -comp pmd2016  #  pass Nov.18.2015
get-counter -comp 172.16.220.33 
'
#
#


get-counter -comp 172.16.220.33 

# 3   115  Creating a remote Windows PowerShell session
#---- icm  please ref   
ping pmd  #172.16.201.147

Test-WSMan pmd 
telnet   pmd  5985
icm -comp pmd -ScriptBlock {hostname} # failure

gps -Name notepad -ComputerName pmd
gsv -ComputerName pmd

telnet   pmd2016  5985 #psas
ping pmd2016 # 172.16.201.144
icm -comp pmd2016 -ScriptBlock {hostname} # failure
icm -comp 172.16.201.144 -ScriptBlock {hostname} # failure


icm -comp sql2014x -ScriptBlock {hostname} # pass

#------------------------------ gwmi 




$secpasswd = ConvertTo-SecureString "p@ssw0rd" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential "PMD\infra1",$secpasswd
$credential = New-Object System.Management.Automation.PSCredential "pmocsd\infra1",$secpasswd
 # 

gwmi   win32_share    -comp  pmd2016 -Credential $credential   # pass Nov.18.2015
gwmi   Win32_Service  -comp  pmd2016 -Credential $credential   # pass
'
PS SQLSERVER:\> gwmi   win32_share  -comp  pmd2016 -Credential $credential   # 

Name                                                  Path                                                  Description                                         
----                                                  ----                                                  -----------                                         
ADMIN$                                                C:\Windows                                            遠端管理                                                
Backup                                                D:\SQLData\Backup                                                                                         
C$                                                    C:\                                                   預設共用                                                
D$                                                    D:\                                                   預設共用                                                
IPC$                                                                                                        遠端 IPC                                              
NETLOGON                                              C:\Windows\SYSVOL\sysvol\PMOCSD.SYSCOM.COM\SCRIPTS    登入伺服器共用                                             
SYSVOL                                                C:\Windows\SYSVOL\sysvol                              登入伺服器共用                                             
'


$secpasswd2 = ConvertTo-SecureString "p@ssw0rds" -AsPlainText -Force
$credential2 = New-Object System.Management.Automation.PSCredential "PMD\administrator",$secpasswd2
gwmi   Win32_Service  -comp  pmd -Credential $credential2 # pass Nov.18.2015

gwmi   win32_share -comp  sql2014x  # pass

*****關閉下列 firewall.cpl 仍可以遠端執行

Active Directory 網域控制站 - W32Time (NTP-UDP-In)
Hyper-V 管理用戶端 - WMI (DCOM-In)     # TCP 135
DFS 管理 (DCOM-In)                    # TCP 135
檔案伺服器遠端管理 (DCOM-In)            # TCP 135 
Windows Management Instrumentation (ASync-In)
Windows Management Instrumentation (DCOM-In)  # TCP 135
Windows Management Instrumentation (WMI-In)

#Securing a Remote WMI Connection
https://msdn.microsoft.com/en-us/library/aa393266(v=vs.85).aspx

#Connecting Through Windows Firewall
https://msdn.microsoft.com/en-us/library/aa389286(v=vs.85).aspx
netsh firewall add portopening protocol=tcp port=135 name=DCOM_TCP135
netsh firewall add allowedprogram program=%windir%\system32\wbem\unsecapp.exe name=UNSECAPP







Enter-PSSession
New-PSSession
Remove-PSSession
Connect-PSSession
Invoke-Command
New-PSSessionConfigurationFile
about_Session_Configuration_Files
about_Session_Configurations
Get-CimAssociatedInstance
Get-CimClass
Get-CimInstance
Get-CimSession
Invoke-CimMethod
New-CimInstance
New-CimSession
New-CimSessionOption
Register-CimIndicationEvent
Remove-CimInstance
Remove-CimSession
Set-CimInstance
