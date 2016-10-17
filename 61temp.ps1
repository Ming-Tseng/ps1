gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name

'
name                                                                             Version                                                                        
----                                                                             -------                                                                        
Microsoft SharePoint Foundation 2013 1033 Lang Pack                              15.0.4420.1017                                                                 
Microsoft SharePoint Foundation 2013 1033 SQL Express                            15.0.4420.1017                                                                 
Microsoft SharePoint Foundation 2013 Core                                        15.0.4420.1017                                                                 
Microsoft SharePoint Multilingual Solutions                                      15.0.4420.1017                                                                 
Microsoft SharePoint Multilingual Solutions English Language Pack                15.0.4420.1017                                                                 
Microsoft SharePoint Portal                                                      15.0.4420.1017                                                                 
Microsoft SharePoint Portal English Language Pack                                15.0.4420.1017                                                                 
Microsoft SharePoint Server 2013                                                 15.0.4420.1017                                                                 
PerformancePoint Services for SharePoint                                         15.0.4420.1017                                                                 
PerformancePoint Services in SharePoint 1033 Language Pack                       15.0.4420.1017                                                                 
SQL Server 2014 RS_SharePoint_SharedService                                      12.0.2000.8                                                                    
適用於 SharePoint 的 Microsoft SQL Server 2014 RS 增益集                                12.0.2000.8                                                                    
'

#& uninstallation from  appwiz.cpl
gwmi  Win32_Product  | ? name -Like *SharePoint*  |select name,Version |sort name
