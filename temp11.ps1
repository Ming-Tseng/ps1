
#Microsoft.SqlServer.Management.SqlScriptPublish.ScriptPublishWizard
C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Microsoft.SqlServer.Management.SqlScriptP‌​ublishUI.dll
     
# Microsoft.SqlServer.Management.UI.GenerateScript
C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\ReplicationDialog.dll
    
    
Get-SqlDatabase -ServerInstance .
	
I don't see powershell with SQLPSX mentioned in any of these answers... 
I personally haven't played with it but it looks beautifully simple to use and ideally suited to this type of automation tasks, with tasks like:

Get-SqlDatabase -dbname test -sqlserver server | Get-SqlTable | Get-SqlScripter | Set-Content -Path C:\script.sql
Get-SqlDatabase -dbname test -sqlserver server | Get-SqlStoredProcedure | Get-SqlScripter
Get-SqlDatabase -dbname test -sqlserver server | Get-SqlView | Get-SqlScripter


Get-SqlDatabase $env:COMPUTERNAME
Get-SqlInstance 


Get-SqlDatabase -dbname test -sqlserver server | Get-SqlTable | Get-SqlScripter | Set-Content -Path C:\script.sql

     
       C:\Program Files\Microsoft SQL Server\120\Tools\Binn\ManagementStudio

$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $env:COMPUTERNAME

$server.Databases["SQL_inventory"]
$dbS=$server.Databases 

$databasename = "SQL_inventory"
$database = $server.Databases[$databasename]

using Microsoft.SqlServer.Management.Smo;
using Microsoft.SqlServer.Management.Sdk.Sfc;
...
// Connect to the local, default instance of SQL Server. 
Server srv = new Server();

// Reference the database.  
Database db = srv.Databases["YOURDBHERE"];

Scripter scrp = new Scripter(srv);
$scrp = New-Object -TypeName Microsoft.SqlServer.Management.Sdk.Sfc  -ArgumentList $env:COMPUTERNAME


scrp.Options.ScriptDrops = false;
scrp.Options.WithDependencies = true;
scrp.Options.Indexes = true;   // To include indexes
scrp.Options.DriAllConstraints = true;   // to include referential constraints in the script
scrp.Options.Triggers = true;
scrp.Options.FullTextIndexes = true;
scrp.Options.NoCollation = false;
scrp.Options.Bindings = true;
scrp.Options.IncludeIfNotExists = false;
scrp.Options.ScriptBatchTerminator = true;
scrp.Options.ExtendedProperties = true;

scrp.PrefetchObjects = true; // some sources suggest this may speed things up

var urns = new List<Urn>();

// Iterate through the tables in database and script each one   
foreach (Table tb in db.Tables)
{
    // check if the table is not a system table
    if (tb.IsSystemObject == false)
    {
        urns.Add(tb.Urn);
    }
}

// Iterate through the views in database and script each one. Display the script.   
foreach (View view in db.Views)
{
    // check if the view is not a system object
    if (view.IsSystemObject == false)
    {
        urns.Add(view.Urn);
    }
}

// Iterate through the stored procedures in database and script each one. Display the script.   
foreach (StoredProcedure sp in db.StoredProcedures)
{
    // check if the procedure is not a system object
    if (sp.IsSystemObject == false)
    {
        urns.Add(sp.Urn);
    }
}

StringBuilder builder = new StringBuilder();
System.Collections.Specialized.StringCollection sc = scrp.Script(urns.ToArray());
foreach (string st in sc)
{
    // It seems each string is a sensible batch, and putting GO after it makes it work in tools like SSMS.
    // Wrapping each string in an 'exec' statement would work better if using SqlCommand to run the script.
    builder.AppendLine(st);
    builder.AppendLine("GO");
}

return builder.ToString();