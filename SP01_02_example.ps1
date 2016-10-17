<#

SP01_02_example


#>
#------------------------------------
#  install  PowerPivot  
#------------------------------------

 gsv| ?{$_.DisplayName -like '*SharePoint*'}
'
Status   Name               DisplayName                           
------   ----               -----------                           
Stopped  DCLauncher15       Document Conversions Launcher for M...
Stopped  DCLoadBalancer15   Document Conversions Load Balancer ...
Stopped  OSearch15          SharePoint Server Search 15           
Running  SPAdminV4          SharePoint Administration             
Stopped  SPSearchHostCon... SharePoint Search Host Controller     
Running  SPTimerV4          SharePoint Timer Service              
Running  SPTraceV4          SharePoint Tracing Service            
Stopped  SPUserCodeV4       SharePoint User Code Host             
Stopped  SPWriterV4         SharePoint VSS Writer                 
'


gsv SP*
'
Status   Name               DisplayName                           
------   ----               -----------                           
Running  SPAdminV4          SharePoint Administration             
Running  Spooler            Print Spooler                         
Stopped  sppsvc             Software Protection                   
Stopped  SPSearchHostCon... SharePoint Search Host Controller     
Running  SPTimerV4          SharePoint Timer Service              
Running  SPTraceV4          SharePoint Tracing Service            
Stopped  SPUserCodeV4       SharePoint User Code Host             
Stopped  SPWriterV4         SharePoint VSS Writer    
'



#(Get-SPFarm).Products
'
Guid                                                                                                                                                            
----                                                                                                                                                            
9ff54ebc-8c12-47d7-854f-3865d4be8118                                                                                                                            
b7d84c2b-0754-49e4-b7be-7ee321dce0a9 
'
#----------------------------
Get-SPServer | select Name ,role,status      | ft -auto    

'Name             Role Status
----             ---- ------
SP2013WFE Application Online
SQL2012X      Invalid Online
'

 Get-SPDatabase |select name,type
'
Name                                                                             Type                                                                           
----                                                                             ----                                                                           
SecureStoreService_663b670a786249ea9de3476f4b8bc5dd                              Microsoft.Office.SecureStoreService.Server.SecureStoreServiceDatabase          
SharePoint_Config_1daf818fdeb04b568db2d84fff4ad511                               Configuration Database                                                         
DefaultPowerPivotServiceApplicationDB-38f1b067-9fcb-486e-8961-324be0634795       Microsoft.AnalysisServices.SPAddin.GeminiServiceDatabase                       
DefaultWebApplicationDB-ab4703ff-37d7-493e-8dc6-8d7bf57c261f                     Content Database                                                               
SharePoint_Admin_a030669b759e47f095a3b4ac65d90415                                Content Database                                                               
WSS_Logging 



PS C:\Program Files\Common Files\microsoft shared\web server extensions\15\bin> Get-SPDatabase |ft -AutoSize

Name                                                         Id                                   Type                                                          
----                                                         --                                   ----                                                          
SecureStoreService_663b670a786249ea9de3476f4b8bc5dd          14b1be61-91db-47a1-b7a6-19ee088c736a Microsoft.Office.SecureStoreService.Server.SecureStoreServi...
SharePoint_Config_1daf818fdeb04b568db2d84fff4ad511           f7ef6068-3dd0-423e-b39d-27e108dac34e Configuration Database                                        
PPS_Application_01_7889d5ccee414acaa2a432703e7d7b3a          d301c6c2-af5a-4693-832b-e39c614b18fb Microsoft.PerformancePoint.Scorecards.BIMonitoringServiceDa...
DefaultWebApplicationDB-ab4703ff-37d7-493e-8dc6-8d7bf57c261f 03da7240-4e44-4c23-afb1-0721573fda12 Content Database                                              
SharePoint_Admin_a030669b759e47f095a3b4ac65d90415            75f335eb-606d-4ba8-a046-a469363d460d Content Database                                              
WSS_Logging  


'

Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto
'
PS C:\Users\administrator.CSD> Get-SPServiceInstance -Server  $env:COMPUTERNAME    |select status,TypeName ,id  |sort Status,TypeName |ft -auto

  Status TypeName                                                      Id                                  
  ------ --------                                                      --                                  
  Online Central Administration                                        f21cce78-4d8a-400e-93c9-441140990b3b
  Online Claims to Windows Token Service                               5829837c-5e58-4971-a011-69bebb36aeee
  Online Distributed Cache                                             bae2d2bc-39c7-47be-ae35-9464ea3602b2
  Online Excel Calculation Services                                    24ff4cce-0712-46c5-9c80-1c42de606b5f
  Online Microsoft SharePoint Foundation Incoming E-Mail               1c499c25-e420-44cf-8aa2-b98c7553dbfc
  Online Microsoft SharePoint Foundation Web Application               239c2688-476b-4506-a09a-41ed3916bb0f
  Online Microsoft SharePoint Foundation Workflow Timer Service        a0560d91-e97a-4c8a-a146-a4a61dacf368
  Online Secure Store Service                                          42c36849-789d-46d9-9d23-9c9aaf4a9853
  Online SQL Server PowerPivot 系統服務                                 5d90e6bf-afa9-4c8c-a835-53aa45023a8f
Disabled Access Database Service 2010                                  eb3b41ee-304a-4256-b95b-3527899df1de
Disabled Access Services                                               fb46a77c-2cc0-4363-aa5a-4d30d5c843e8
Disabled App Management Service                                        41b67dfe-fb45-473e-833d-bf482d982841
Disabled Business Data Connectivity Service                            33c17d42-c01c-4829-ab0c-a999a737d366
Disabled Document Conversions Launcher Service                         dede13d3-1465-4c9f-a853-0bb9f43a6a2e
Disabled Document Conversions Load Balancer Service                    542a3316-7250-42be-af89-16973d66ad18
Disabled Lotus Notes Connector                                         b32d22af-71fa-460a-9db9-56a9acffc869
Disabled Machine Translation Service                                   6c4ac42f-497f-4e6c-8fbc-9d8cfaf97db5
Disabled Managed Metadata Web Service                                  81d0e849-479e-4550-b6be-a9c3befad5d1
Disabled Microsoft SharePoint Foundation Sandboxed Code Service        605a85aa-d516-4b64-92f4-37354de36515
Disabled Microsoft SharePoint Foundation Subscription Settings Service 214b61b9-1b2d-45ac-bdbb-47b132a2a228
Disabled PerformancePoint Service                                      82e8b15d-ccb3-4297-a2f5-d9f826bfe203
Disabled PowerPoint Conversion Service                                 41a37604-7e92-46e4-b74d-2e75e1761e07
Disabled Request Management                                            835a780c-29ac-404d-b652-bff878a81c3a
Disabled Search Host Controller Service                                aeafd3a6-c3f4-4b93-b66a-ca687cf40465
Disabled Search Query and Site Settings Service                        c5ab63a1-fee5-47a5-a828-d05a4df4ec8f
Disabled SharePoint Server Search                                      8a15e54e-115e-451e-9c47-116b330fbc68
Disabled User Profile Service                                          cf0dbccc-ffe7-4089-9d45-a40c8f3105ab
Disabled User Profile Synchronization Service                          288cc455-b28a-426a-b058-340be76639c2
Disabled Visio Graphics Service                                        aedc1a04-e633-4ec9-a8fa-7b57ef048c20
Disabled Word Automation Services                                      1b07f000-6331-468d-9cbc-68f46c31d0d1
Disabled Work Management Service                                       231ada50-ae23-4092-a34e-bcc9029169e1
'



PS C:\Users\administrator.CSD> Get-SPServiceApplication  |select name,typename 
'
Name                                                                             TypeName                                                                       
----                                                                             --------                                                                       
Secure Store Service                                                             Secure Store Service Application                                               
ExcelServiceApp1                                                                 Excel Services Application Web Service Application                             
Default PowerPivot Service Application                                           PowerPivot 服務應用程式                                                              
SecurityTokenServiceApplication                                                  Security Token Service Application                                             
Topology                                                                         Application Discovery and Load Balancer Service Application                    
WSS_UsageApplication                                                             Usage and Health Data Collection Service Application                           
'



PS C:\Users\administrator.CSD> Get-SPServiceApplicationProxy 
'
DisplayName          TypeName             Id                                  
-----------          --------             --                                  
Default PowerPivo... PowerPivot 服務應用程式... 6da7d205-86f2-413a-982a-c17d507568d8
Secure Store Proxy   Secure Store Serv... 40cd2263-5ec4-4484-b215-bb663c94f4e1
Application Disco... Application Disco... c9d41fd0-de31-494f-8294-772619afc98c
ExcelServiceApp1     Excel Services Ap... 3ba5fe7e-1d87-47a3-b8f5-652591365052
WSS_UsageApplication Usage and Health ... d8a44648-6845-402e-b48a-f0b3cae27ad8
'


PS C:\Users\administrator.CSD> Get-SPServiceApplicationProxy |ft -AutoSize
'
DisplayName                                                                                            TypeName                                                 
-----------                                                                                            --------                                                 
Default PowerPivot Service Application                                                                 PowerPivot 服務應用程式 Proxy                                  
Secure Store Proxy                                                                                     Secure Store Service Application Proxy                   
Application Discovery and Load Balancer Service Application Proxy_ea251c59-c107-400e-a937-dbf79a58686c Application Discovery and Load Balancer Service Applic...
ExcelServiceApp1                                                                                       Excel Services Application Web Service Application Proxy 
WSS_UsageApplication                                                                                   Usage and Health Data Collection Proxy                   
'