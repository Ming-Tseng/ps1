<#
Subject:OS04_firewall
Desc:
filename:  OS0202_diskIO_multi.ps1
Date:Jan.09.2014
author: a0921887912@gmail.com
from : OS0201_diskIO.ps1
think
TSQL syntax
SQL configuration
Performance counter
DataFile not same location  with blg

parameter:
ts : start
t1
te : end
#>
wf.msc
#--------------------------------------------
#  firewall   netsh advfirewall firewall
#--------------------------------------------
Get-NetFirewallRule |Get-NetFirewallPortFilter

Get-NetFirewallPortFilter |select *


## Get

Specifies the network port on the remote computer used for this command. To connect to a remote computer,
 the remote computer must be listening on the port that the connection uses. 
 The default ports are 5985 (the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Get-NetFirewallPortFilter | ?{ $_.LocalPort -Eq "5985" } |Get-NetFirewallRule #|select DisplayName
Get-NetFirewallRule -DisplayGroup "SQL7025"


netsh advfirewall firewall show rule name=all profile=any dir=in  # profile=Domain,Private,Public,any
netsh advfirewall firewall show rule name=all profile=any dir=out
netsh advfirewall firewall show rule name=sql1433 profile=any
netsh advfirewall firewall show rule name="遠端桌面 - 使用者模式 (TCP-In)" profile=any
netsh advfirewall firewall show  LocalPort=1433  profile=any

## New
New-NetFirewallRule -DisplayName "SQL7025" -Direction Inbound –LocalPort 7025 -Protocol TCP -Action Allow

icm -ComputerName SQL2012X {New-NetFirewallRule -DisplayName "SQL1435_UDP" -Direction Inbound –LocalPort 1435 -Protocol UDP -Action Allow}


netsh advfirewall firewall add rule name="SQL7024" dir=in localport=7024 protocol=TCP action=allow

icm -ComputerName DGPAP1 {netsh advfirewall firewall add rule name="SQL1434_UDP" dir=in localport=1434 protocol=UDP action=allow}

##  set

Set-NetFirewallRule -DisplayGroup "SQL7025" -Enabled True

netsh advfirewall firewall set rule name="SQL7024"  new enable=no
netsh advfirewall firewall set rule name="SQL7024"  new enable=yes

## Delete
#delete rule name=all protocol=tcp localport=80

Remove-NetFirewallRule -DisplayName "SQL7025"
Netsh advfirewall firewall Delete rule name="SQL7024"  




#----------------------------------
#-  
#-
#----------------------------------

install-windowsfeature  Telnet-Client 
firewall.cpl
wf.msc


#----------------------------------
#-  IP  look up  Hostanme
#----------------------------------

nslookup  172.16.220.29
ping -a 172.16.220.161 
nbtstat -A 172.16.220.161  # + MAC address

arp -a

#----------------------------------
#-
#-
#----------------------------------

172.16.220.161 1433 
telnet 172.16.220.194 50736
telnet 172.16.220.161 1433 
telnet 172.16.220.161 5022

telnet SPM 5023



#----------------------------------
#-
#----------------------------------

netstat -aon | more
netstat -aon 5  > D:\netstat\1125.txt



#----------------------------------
#-
#----------------------------------





#----------------------------------
#-
#----------------------------------





#----------------------------------
#-
#----------------------------------



#----------------------------------
#-
#----------------------------------