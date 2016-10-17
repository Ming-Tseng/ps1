<#SQLPS03
Runs a script containing statements from the languages (Transact-SQL and XQuery) and commands supported by the SQL Server sqlcmd utility.

Syntax
    Invoke-SqlCmd [[-Query] <string>] 
    [-AbortOnError <Boolean>] 
    [-ConnectionTimeout <int>] 
    [-Database <string>] [-DedicatedAdministratorConnection <Boolean>] [-DisableCommands <Boolean>] [-DisableVariables <Boolean>] [-EncryptConnection <Boolean>] [-ErrorLevel <int>] [-HostName <string>] [-IgnoreProviderContext <Boolean>] [-InputFile <string>] [-MaxBinaryLength <int>] [-MaxCharLength <int>] [-NewPassword <string>] [-OutputSqlErrors <Boolean>] [-Password <string>] [-QueryTimeout <int>] [-ServerInstance <psobject>] [-SeverityLevel <int>] [-SuppressProviderContextWarning <Boolean>] [-Username <string>] [-Variable <string[]>] [<CommonParameters>]


 get-pssnapin -Registered
 execute a simple query,
 multiple sqlcmd scripting variables to Invoke-Sqlcmd
 execute a  query sql  output to a file
 SQL Server provider for Windows PowerShell to navigate to an instance of the Database Engine
 insert
 create tabel  multi the SQLinstances
#>
ssms
gps -Name sqlservr |select Processname,path |fl
Set-Alias  sql Invoke-Sqlcmd

#---------------------------------------------------------------
#     get-pssnapin -Registered
#---------------------------------------------------------------
## Get
get-pssnapin -Registered  

Name        : SqlServerCmdletSnapin100PSVersion   : 2.0Description : This is a PowerShell snap-in that includes various SQL Server cmdlets.
Name        : SqlServerProviderSnapin100PSVersion   : 2.0Description : SQL Server Provider
## Add
Add-PSSnapin SqlServerCmdletSnapin100 # here live Invoke-SqlCmd
Add-PSSnapin SqlServerProviderSnapin100

#---------------------------------------------------------------
#     execute a simple query,
#---------------------------------------------------------------

Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery;" -ServerInstance "sp2013\SQLS2"

Invoke-Sqlcmd -Query "alter availability group SPMAG failover ;" 

-command  "& {Invoke-Sqlcmd -Query "alter availability group SPMAG failover ;"}"



#---------------------------------------------------------------
#     multiple sqlcmd scripting variables to Invoke-Sqlcmd
#---------------------------------------------------------------
$MyArray = "MyVar1 = 'String1'", "MyVar2 = 'String2'"Invoke-Sqlcmd -Query "SELECT `$(MyVar1) AS Var1, `$(MyVar2) AS Var2;" -Variable $MyArray

Invoke-Sqlcmd  "select * from t1" -database test -ServerInstance "sp2013\SQLS2"
$x=Invoke-Sqlcmd  "select count(*) from t1" -database test -ServerInstance "sp2013\SQLS2"
$x[0]
$x[4]

#---------------------------------------------------------------
#     execute a  query sql  output to a file
#---------------------------------------------------------------


Invoke-Sqlcmd -InputFile "C:\MyFolder\TestSQLCmd.sql" | Out-File -filePath "C:\MyFolder\TestSQLCmd.rpt"

Invoke-Sqlcmd -Query  'select @@servername' -ServerInstance "PM001" -Username 'sa' -Password 'p@ssw0rd1' 


#---------------------------------------------------------------
#     SQL Server provider for Windows PowerShell to navigate to an instance of the Database Engine
#---------------------------------------------------------------


Set-Location SQLSERVER:\SQL\MyComputer\MyInstance
Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery;" -ServerInstance (Get-Item .)

#---------------------------------------------------------------
#     insert  
#---------------------------------------------------------------
Set-Alias sql Invoke-Sqlcmd
$name=''

$sql_insert = "INSERT INTO [WebApps] ([Server],[WebSite],[State],[Bindings],[Path])
	 			VALUES ('$name', '$webSite', '$state', '$binding', '$path')"sql -Query $sql_insert -ServerInstance Spm -Database DB -QueryTimeout


#-------------------------
#  create tabel  multi the SQLinstances
#-------------------------
$ServerInstences = Get-Content "H:\temp\ServerInstances.txt"spm
DGPAP1
DGPAP2

# 字串中, 使用符號  use @""@ , {   }
$SQLQuery = @"    
CREATE TABLE [dbo].[PS_Table]
(
[ID] [int] IDENTITY(1,1) NOT NULL,
[Name] [varchar](50) NULL,
[Age] [int] NULL,
CONSTRAINT [PK_PS_Table] PRIMARY KEY CLUSTERED ([ID] ASC)
)
"@
#he database we want to execute it against, regardless of the instance$DBName = "MingDB"#iterating through all instances.$ServerInstences | % {
Invoke-Sqlcmd -Query $SQLQuery -ServerInstance $_ -Database $DBName 

#---------------------------------------------------------------
#     example : Get table variable to all value insert into sql table 
#---------------------------------------------------------------
$names = Invoke-Sqlcmd -Query "SELECT Name FROM Servers" -ServerInstance "Server" -Database "DB"
	
ForEach ($row in $names) {
		
		$name = $row.ItemArray[0]
		$website = ""
		$state = ""
		$binding = ""
		$path = ""
		
        If (Test-Connection -comp $name -count 1 -Quiet) {
            
			# command for remote box
			cls
			$command = {
			    Import-Module 'WebAdministration'
			    dir "IIS:\Sites"
			}
			
			#connection for remote box
			#$session = New-PSSession -ComputerName $name
			
			$sites = Invoke-Command -ComputerName $name -ScriptBlock $command
			
            #$sites = dir "IIS:\Sites\"
            ## $children = $sites.children
            ForEach ($child in $sites) {
            
				$website = $child.name
				$state = $child.state
	    		ForEach ($b in $child.bindings.Collection) {
					$binding += "[" + $b.protocol + "," + $b.bindingInformation + "]"
				}
				$path = $child.physicalPath
				
				$temp = "" | Select Server, WebSite, State, Bindings, Path
	            $temp.Server = $name
	            $temp.WebSite = $child.name
	            $temp.State = $child.state
	            $temp.Bindings = $binding
	            $temp.Path = $child.physicalPath
	            $report += $temp
				
				$sql_insert = "INSERT INTO [WebApps] ([Server],[WebSite],[State],[Bindings],[Path])
	 			VALUES ('$name', '$webSite', '$state', '$binding', '$path')"
				
				Invoke-Sqlcmd -Query $sql_insert -ServerInstance "Server" -Database "DB"
            }
        }
		else
		{
			$sql_insert = "INSERT INTO [WebApps] ([Server],[WebSite])
 			VALUES ('$name', 'none found')"
			
			Invoke-Sqlcmd -Query $sql_insert -ServerInstance "Server" -Database "DB"
		}


#---------------------------------------------------------------
#     temp 
#---------------------------------------------------------------
Invoke-Sqlcmd

$dbs1="SQLSERVER:\SQL\sp2013\DEFAULT\Databases"
$dbs2="SQLSERVER:\SQL\sp2013\SQLS2\Databases"
$dbs_test="SQLSERVER:\SQL\sp2013\SQLS2\Databases\test" ; cd  $dbs_test
cd  $db2;ls
cd test; cd tables;ls

ls
cd SQL;  #SQLSERVER:\SQL\sp2013
cd sp2013;ls;pwd   #Instance Name  DEFAULT ;SQLS2 
cd DEFAULT;ls
cd Databases ; ls

<#
SQLSERVER:\SQL\sp2013\DEFAULT
----------------------------------
Audits
AvailabilityGroups
BackupDevices
Credentials
CryptographicProviders
Databases
Endpoints
JobServer
Languages
LinkedServers
Logins
Mail
ResourceGovernor
Roles
ServerAuditSpecifications
SystemDataTypes
SystemMessages
Triggers
UserDefinedMessages
#>











#---------------------------------------------------------------
#     temp 
#---------------------------------------------------------------



#---------------------------------------------------------------
#     temp 
#---------------------------------------------------------------



#---------------------------------------------------------------
#     temp 
#---------------------------------------------------------------


#---------------------------------------------------------------
#     temp 
#---------------------------------------------------------------
