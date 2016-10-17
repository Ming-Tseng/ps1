

<#SP05_OfficeWebAppsfilelocation : \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\SP05_OfficeWebApps.ps1\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\SP05_OfficeWebApps.ps1CreateDate: SEP.11.2015LastDate : Author :Ming Tseng  ,a0921887912@gmail.comremark 
email backup

$ps1fS=gi C:\Users\administrator.CSD\SkyDrive\download\PS1\OS00_Index.ps1
$ps1fS=gi C:\Users\Chao_Ming\OneDrive\download\PS1\OS00_Index.ps1  #s21
$ps1fS=gi C:\Users\Administrator\OneDrive\download\PS1\OS00_Index.ps1

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
#>

________________________________________________________________________________________________________________________________________
example :　　\\192.168.112.129\h$\mydataII\booksExample\excelDataPivotTable



#-----------------------------------------------------------------------------------
#  
#-----------------------------------------------------------------------------------






#-----------------------------------------------------------------------------------
#  
#-----------------------------------------------------------------------------------





#-----------------------------------------------------------------------------------
#  office data connection file odc
#-----------------------------------------------------------------------------------

& 'C:\Users\administrator.CSD\Documents\我的資料來源\北風公司 季業績總表.odc'


#-----------------------------------------------------------------------------------
#    odbc  dsn  dqy
#-----------------------------------------------------------------------------------
windows - odbc
%windir%\syswow64\odbcad32.exe
%windir%\system32\odbcad32.exe

dgy : Microsoft EXCEL  ODBC query file




#-----------------------------------------------------------------------------------
#   odc  Microsoft Office Data Connection
#-----------------------------------------------------------------------------------
C:\Users\infra1\Documents\My Data Sources

SPfarmSQL AdventureWorks SalesOrderDetail.odc



#-----------------------------------------------------------------------------------
#  offline cube
#-----------------------------------------------------------------------------------

at excel  > pivotchar tools > analyze > calculations > OLAP Tools > offline OLAP
   



#-----------------------------------------------------------------------------------
#  
#-----------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------
#  
#-----------------------------------------------------------------------------------