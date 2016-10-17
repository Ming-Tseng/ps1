<#
baseline performance record  for TPEx

C:\Users\Chao_Ming\OneDrive\download\PS1\ex06_TPEx_baseline.ps1

#>

#01  10 connect bq-monap01  & TSQLTest
#02  95 bulk insert T6  one-session single table
#03     bulk insert  multi-session
#04  186  manual failover  
# scenario A  Node1 online  to node2 online and  node2 to node1 using manual   199
# scenario B  node2 to node3   219
# scenario C  node3 to node1  but lost data  245
# scenario C.1  node3 to node1  using  RESUME   287




#-----------------------------------------
#01  10  connect bq-monap01  & TSQLTest
#-----------------------------------------

winrm set winrm/config/client @{TrustedHosts="bq-monap01"}

$cred= get-Credential bq-monap01\administrator 
icm -ComputerName bq-monap01 -ScriptBlock {hostname} -Credential $cred

$remcommand={Invoke-Sqlcmd -ServerInstance monDBagl -Database TEST -Username sa -Password p@ssw0rd -Query 'select @@servername'};$remcommand
icm -ComputerName bq-monap01 -ScriptBlock $remcommand  -Credential $cred

Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Username sa -Password p@ssw0rd -Query 'select * from T1'

Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Username sa -Password p@ssw0rd -Query $tsql_T1select #workable

Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1select #workable
Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1create #workable
Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1drop   #workable
Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1insert #workable


icm -ComputerName bq-monap01 -ScriptBlock $remcommand  -Credential $cred


$tsql_T1select="select * from TEST.dbo.T1 "


$tsql_T1create=@"


USE [TEST]
GO

/****** Object:  Table [dbo].[T1]    Script Date: 2015/10/14 下午 12:05:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[T1](
	[a] [nchar](10) NULL,
	[b] [nchar](10) NULL
) ON [PRIMARY]

GO
"@
$tsql_T1drop=@"
USE [TEST]
GO

Drop table T1
GO
"@
$tsql_T1insert=@"
USE [TEST]
GO

insert into [dbo].[T1] values ('a','1') ,('b','2')
GO
"@
$tsql_T1truncate=@"
USE [TEST]
GO

truncate table  [T1]
GO
"@


Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1select #workable
Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1create #workable
Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1drop #workable
Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1truncate #workable

Invoke-Sqlcmd -HostName bq-monap01 -ServerInstance monDBagl -Database TEST -Query $tsql_T1insert #workable


#-----------------------------------------
#  02 95  bulk insert T6  one-session single table
#-----------------------------------------


$Thost='bq-monap01'
$db01='bq-mondb01'
$db02='bq-mondb02'
$db03='tc-mondb01'
$tDB='TEST'
$tSI='monDBagl'

$tsql_T6truncate="truncate table  [dbo].[T6]"
$insertcount='10'
$tsql_T6insert=@"
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <= $insertcount 
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.T6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:02'  
end
"@;$tsql_T6insert
$tsql_T6CREATE="
CREATE TABLE [dbo].[T6](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[val] [int] NULL,
	[rstring] [nchar](255) NULL,
	createDate smalldatetime,
	updateDate smalldatetime,
 CONSTRAINT [PK_T6] PRIMARY KEY (iid)) ON [PRIMARY]
GO
"
$tsql_T6Select="select iid,rid,val,createDate,rstring from  [dbo].[T6]"
$tsql_T6last10="select top 10 iid,rid,val,createDate,rstring from  [dbo].[T6] order by iid desc"
$tsql_T6top10="select top 10 iid,rid,val,createDate,rstring from  [dbo].[T6] order by iid "

ssms


#Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6CREATE 

function T6insert ($insertcount){
#$insertcount='10'
$tsql_T6insert=@"
Declare @rid as int =1 , @val  int , @rstring  nvarchar(255);
while @rid <= $insertcount 
begin
  select @val=cast((RAND()*1000) as int) ; print @val
  select @rstring=NEWID(); print @rstring
  insert into dbo.T6 values (@rid,@val,@rstring,getdate(),getdate())
  
  set @rid=@rid+1
  --WAITFOR DELAY '00:00:02'  
end
"@;$tsql_T6insert
    
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6insert  -QueryTimeout 1200
}

$t1=get-date
T6insert 1000
$t2=get-date;($t2-$t1)
# 1W - 7 sec
# 10W - 1m 14 sec
# 50W
# 100W -over 10m Powershell timeout

Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6truncate 

Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6top10  |ft -AutoSize
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize



Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6Select |ft -AutoSize



Invoke-Sqlcmd -HostName $db02 -ServerInstance $tSI -Database $tDB -Query $tsql_T6Select 
Invoke-Sqlcmd -HostName $db03 -ServerInstance $tSI -Database $tDB -Query $tsql_T6Select 

#-----------------------------------------
#  03   bulk insert  multi-session
#-----------------------------------------



#-----------------------------------------
#  04  186  manual failover  Oct.15.2015
#-----------------------------------------

$Thost='bq-monap01'
$db01='bq-mondb01'
$db02='bq-mondb02'
$db03='tc-mondb01'
$tDB='TEST'
$tSI='monDBagl'


# scenario A  Node1 online  to node2 online and  node2 to node1 using manual   199
{<#
--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect BQ-MONDB02
$tsql_syncfailover=@"
use master 
GO
ALTER AVAILABILITY GROUP [MonG1] FAILOVER;
"@

function failoverto ($param1, $param2)
{
if ($x -gt $y)  {   }
Invoke-Sqlcmd -HostName $db02 -ServerInstance bq-mondb01 -Query $tsql_failover     
}

Invoke-Sqlcmd -HostName $db02 -ServerInstance bq-mondb02 -Query $tsql_failover     
Invoke-Sqlcmd -HostName $db01 -ServerInstance bq-mondb01 -Query $tsql_failover     
#>}

# scenario B  node2 to node3   219
{<#
before : primary =node2 count :  50W
after :  primary =node3 count :  50W


Invoke-Sqlcmd -HostName $db03 -ServerInstance  tc-mondb01  -Query 'select @@servername'
$tsql_nosyncfailover=@"
use master 
GO
ALTER AVAILABILITY GROUP [MonG1] FORCE_FAILOVER_ALLOW_DATA_LOSS;
"@

Invoke-Sqlcmd -HostName $db03 -ServerInstance  tc-mondb01  -Query $tsql_nosyncfailover   

ping mondbagl # 172.19.65.183  pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6top10  |ft -AutoSize #pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize count=50W


Invoke-Sqlcmd -HostName $db01 -ServerInstance bq-mondb01 -Query $tsql_failover     
#>}


# scenario C  node3 to node1  but lost data  245

DELETE FROM [dbo].[T6]   WHERE iid='499999'
GO

Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W
'PS SQLSERVER:\> Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W

   iid    rid val createDate             rstring                                                                                   
   ---    --- --- ----------             -------                                                                                   
499999 499999 472 2015/10/14 下午 01:38:00 89AA5DF2-0E42-47FC-8C91-FBFFF38A276D                                                   ...
499998 499998 847 2015/10/14 下午 01:38:00 E237521E-5509-4851-AD06-A18DF2560D11                                                   ...
499997 499997 714 2015/10/14 下午 01:38:00 F74348EA-CAB9-4D1A-8EB2-79EAB0E18E92  '

before : primary =node3 count :  499999
failover to node1
after :  primary =node1 count :  500000

$tsql_nosyncfailover=@"
use master 
GO
ALTER AVAILABILITY GROUP [MonG1] FORCE_FAILOVER_ALLOW_DATA_LOSS;
"@

Invoke-Sqlcmd -HostName $db01 -ServerInstance bq-mondb01 -Query $tsql_nosyncfailover     

ping mondbagl # 172.18.65.183  pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6top10  |ft -AutoSize #pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W

## then  sync stop

## how to solve it
$tsql_RESUME=" ALTER DATABASE [TEST] SET HADR RESUME;"
DELETE FROM [dbo].[T6]   WHERE iid='499999'

Invoke-Sqlcmd -HostName $db01 -ServerInstance bq-mondb01 -Query $tsql_RESUME
Invoke-Sqlcmd -HostName $db02 -ServerInstance bq-mondb02 -Query $tsql_RESUME     
Invoke-Sqlcmd -HostName $db03 -ServerInstance tc-mondb01 -Query $tsql_RESUME     
     

# scenario C.1  node3 to node1   RESUME   287

(1) before : primary =node1 count :  1000
(2) failover to node3
(3) DELETE iid='1000'
(4) RESUME 
(5) failover to node1 
(6) RESUME


$maxrow='1000'
(1)
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6truncate 
T6insert $maxrow

Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W

(2)
Invoke-Sqlcmd -HostName $db03 -ServerInstance  tc-mondb01  -Query $tsql_nosyncfailover   
ping mondbagl # 172.19.65.183  pass

(3)
$tsql_deletemax=@"
use TEST
Go
DELETE FROM [dbo].[T6]   WHERE iid='$maxrow'
"@

Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB  -Query  $tsql_deletemax
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W
 
(4) RESUME 

$tsql_RESUME=" ALTER DATABASE [TEST] SET HADR RESUME;"
#Invoke-Sqlcmd -HostName $db01 -ServerInstance bq-mondb01 -Query $tsql_RESUME
Invoke-Sqlcmd -HostName $db02 -ServerInstance bq-mondb02 -Query $tsql_RESUME     
Invoke-Sqlcmd -HostName $db03 -ServerInstance tc-mondb01 -Query $tsql_RESUME     
     
ping mondbagl # 172.18.65.183  pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6top10  |ft -AutoSize #pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W



(5) node3 to node1

Invoke-Sqlcmd -HostName $db01 -ServerInstance bq-mondb01 -Query $tsql_nosyncfailover     
ping mondbagl # 172.18.65.183  pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6top10  |ft -AutoSize #pass
Invoke-Sqlcmd -HostName $Thost -ServerInstance $tSI -Database $tDB -Query $tsql_T6last10 |ft -AutoSize #count=50W

(6) RESUME 
Invoke-Sqlcmd -HostName $db02 -ServerInstance bq-mondb02 -Query $tsql_RESUME     
Invoke-Sqlcmd -HostName $db03 -ServerInstance tc-mondb01 -Query $tsql_RESUME   

#-----------------------------------------
#  03   bulk insert  multi-session
#-----------------------------------------



icm -ComputerName bq-monap01 -ScriptBlock $remcommand  -Credential $cred

icm -ComputerName bq-monap01 `
-ScriptBlock {Invoke-Sqlcmd -ServerInstance monDBagl -Query 'select @@servername' -Username sa -Password p@ssw0rd} -Credential $cred



get-module

Invoke-Sqlcmd -ServerInstance monDBagl -Query 'select @@servername' -Username sa -Password p@ssword


icm -ComputerName bq-mondb02 -ScriptBlock {hostname} #-Credential bq-monap01\administrator 

New-PSSession -ComputerName bq-monap01 -Credential bq-monap01\administrator 




$cnts='',''

Get-Counter 

Test-WSMan bq-monap01






Telnet bq-monap01 5985


ping bq-monap01
ping bq-monap02


Get-Counter -ComputerName bq-monap01


Get-Counter -ComputerName tc-mondb01
Get-Counter -ComputerName bq-mondb02


cls
Get-Counter -ComputerName tc-mondb01,bq-mondb01,bq-mondb02


$cnt= '\\tc-mondb01\\network interface(vmxnet3 ethernet adapter _2)\bytes total/sec','\\bq-mondb01\\network interface(cisco vic ethernet interface)\bytes total/sec' `
,'\\bq-mondb02\\network interface(cisco vic ethernet interface)\bytes total/sec'



Get-Counter  $cnt -MaxSamples 100 -SampleInterval 5 |Export-Counter -Path C:\PerfLogs\Networok.blg -FileFormat blg -Force
ii C:\PerfLogs\Networok.blg



'
PS C:\Users\infoadm> Get-Counter -ComputerName tc-mondb01,bq-mondb01,bq-mondb02

Timestamp                 CounterSamples                                                                                      
---------                 --------------                                                                                      
2015/10/12 下午 12:11:28    \\tc-mondb01\\network interface(vmxnet3 ethernet adapter)\bytes total/sec :                         
                          300.76055457183                                                                                     
                                                                                                                              
                          \\tc-mondb01\\network interface(vmxnet3 ethernet adapter _2)\bytes total/sec :                      
                          27997.5509876898                                                                                    
                                                                                                                              
                          \\tc-mondb01\\network interface(isatap.{565ba096-f65e-49dc-8aa8-eef39252b4dd})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\tc-mondb01\\network interface(isatap.{ef2fbab8-359c-4c91-a7e4-dd03aababb4e})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\tc-mondb01\\network interface(isatap.{a51fcf69-856b-4831-bd1a-71b54582ff7f})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb01\\network interface(cisco vic ethernet interface)\bytes total/sec :                     
                          62287.5837044974                                                                                    
                                                                                                                              
                          \\bq-mondb01\\network interface(cisco vic ethernet interface _3)\bytes total/sec :                  
                          707.879027925482                                                                                    
                                                                                                                              
                          \\bq-mondb01\\network interface(isatap.{39da359a-0b74-4faa-840b-91630d55f7fe})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb01\\network interface(isatap.{cc3c4b75-c411-4be0-9667-bd0d96b0e6b2})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb01\\network interface(isatap.{42be8f15-19f7-4878-b055-37d8299108a1})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb02\\network interface(cisco vic ethernet interface)\bytes total/sec :                     
                          33402.3220075451                                                                                    
                                                                                                                              
                          \\bq-mondb02\\network interface(cisco vic ethernet interface _3)\bytes total/sec :                  
                          710.687702288194                                                                                    
                                                                                                                              
                          \\bq-mondb02\\network interface(isatap.{f385ec49-c5f3-4d4b-9eac-412df77ee999})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb02\\network interface(isatap.{1ce750e2-2b53-4a3f-8266-3c13f52de364})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb02\\network interface(isatap.{8f2b50db-80a9-464d-9e23-d8fc3c70f222})\bytes total/sec :    
                          0                                                                                                   
                                                                                                                              
                          \\tc-mondb01\\processor(_total)\% processor time :                                                  
                          0.291086253326933                                                                                   
                                                                                                                              
                          \\bq-mondb01\\processor(_total)\% processor time :                                                  
                          0.0492787008075091                                                                                  
                                                                                                                              
                          \\bq-mondb02\\processor(_total)\% processor time :                                                  
                          0.00117331956638322                                                                                 
                                                                                                                              
                          \\tc-mondb01\\memory\% committed bytes in use :                                                     
                          5.64197708993015                                                                                    
                                                                                                                              
                          \\bq-mondb01\\memory\% committed bytes in use :                                                     
                          4.88057380230597                                                                                    
                                                                                                                              
                          \\bq-mondb02\\memory\% committed bytes in use :                                                     
                          2.15069454983498                                                                                    
                                                                                                                              
                          \\tc-mondb01\\memory\cache faults/sec :                                                             
                          0.957836161056782                                                                                   
                                                                                                                              
                          \\bq-mondb01\\memory\cache faults/sec :                                                             
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb02\\memory\cache faults/sec :                                                             
                          0                                                                                                   
                                                                                                                              
                          \\tc-mondb01\\physicaldisk(_total)\% disk time :                                                    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb01\\physicaldisk(_total)\% disk time :                                                    
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb02\\physicaldisk(_total)\% disk time :                                                    
                          0                                                                                                   
                                                                                                                              
                          \\tc-mondb01\\physicaldisk(_total)\current disk queue length :                                      
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb01\\physicaldisk(_total)\current disk queue length :                                      
                          0                                                                                                   
                                                                                                                              
                          \\bq-mondb02\\physicaldisk(_total)\current disk queue length :                                      
                          0                                                                                                   
                                                                                                                              
                                                                                                                              




'


telnet 172.18.65.185 5022

icm -ComputerName bq-mondb02 -ScriptBlock {shutdown -r -f}

ping bq-mondb02 -t




ping 172.18.8.21
