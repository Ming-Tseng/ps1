<#-----------------------------------
#  performance  OS02_05_List.ps1.ps1
\\172.16.220.29\c$\Users\administrator.CSD\SkyDrive\download\ps1\OS02_05_List.ps1.ps1
CreateDate:  Jul.26.2014
LastDate :  

#Author   : a0921887912@gmail.com
$subject  : hostname/node1  ,
services.msc
(1)performance 
(2)resource 
(3)process
(4)service  monitor

firewall.cpl   enable "Windows 防火牆遠端管理 (RPC)"

OS02_01_diskIO.ps1
OS02_02_diskMulti.ps1
OS02_03_Sharepoint_SQL.ps1
OS02_04_Alwaysone.ps1
OS02_05_List.ps1
#>

#--------------------------------------------
# 
#--------------------------------------------
http://technet.microsoft.com/en-us/library/bb734903.aspx>


#--------------------------------------------
#  term
#--------------------------------------------
'execution time'
'Network latency': is the measure of how long a data packet takes to travel between two points. 
'Response Time':The two determining factors in response time are network latency, which is the time it takes a request to move through the server request queue, and request execution time.

'time-to-first-byte (TTFB) and the time-to-last-byte (TTLB)':  response-time measures



#--------------------------------------------
#   Throughput
#--------------------------------------------
{The following factors can diminish throughput: 
– Bandwidth 
– Page size 
-Application complexity 
}
'Web Service(_Total)\Get Requests/sec' : static HTML pages, you should use 
'Active Server Pages\Requests/sec'     :  ASP pages

#--------------------------------------------
#   			The Network and Server
#--------------------------------------------
{<#             Object/Counter  (Resource)            :Threshold                 ->Comments
PhysicalDisk\% Disk Time        :90%  
                                ->None
PhysicalDisk\Disk Reads/sec     :Depends on manufacturer's specifications
PhysicalDisk\Disk       
                                ->Check the disk's specified transfer rate to verify that the logged rate doesn't exceed specifications.(1) 
PhysicalDisk\ Current Disk Queue Length      :Number of spindles plus 2
                                 ->This is an instantaneous counter; observe its value over several intervals. For an average over time, use PhysicalDisk\ Avg. Disk Queue Length
Memory\Available Bytes          :Less than 4 MB
                                ->Research memory usage, and then add memory, if needed.
Memory\Pages/sec                :20
                                ->Research paging activity, the activity that occurs when data is swapped out of memory and stored on disk when memory is low.
Network Segment\% Net utilization   :Depends on network type (Network      )
			                    ->For Ethernet networks, the recommended threshold is 30 percent.
Paging File\% Usage             :99%  (Paging File  )
                                ->Review this value in conjunction with Available Bytes and Pages/sec to understand paging activity on your system.
Processor\% Processor Time      :85%
                                ->Isolate the process that is using a high percentage of processor time. Upgrade to a faster processor, or install an additional processor.
Processor\ Interrupts/sec       :Depends on the processor
			                    ->A dramatic increase in this counter with a corresponding increase in system activity indicates a hardware problem. Identify the network adapter that is causing the interrupts.
Server\Bytes Total/sec (Server      )
                                ->If the sum Bytes for all servers is roughly equal to the maximum transfer rates for your network, you might need to segment the network.
Server\Work Item Shortages      :3 (Server       )
                                ->If this value reaches the threshold, consider tuning InitWorkItems or MaxWorkItems in the registry.
Server\Pool Paged Peak          :Amount of physical RAM (Server       )
                                ->This value indicates the maximum paging file size and the amount of physical memory.
Server Work Queues\Queue Length :4  (Server       )
                                ->If this value reaches the threshold, there may be a processor bottleneck. This is an instantaneous counter; observe it over several intervals.
System\Processor Queue Length   :2 (Multiple Processors  )
                                ->This is an instantaneous counter; observe it over several intervals.
Network Interface: Bytes Total/sec 
                                ->Use to determine if your network connection is creating a bottleneck. Compare this counter to the total band-width of your network adapter. You should be using no more than 50 percent of the network adapter capacity.
Web Service: Maximum Connections
Web Service: Total Connection Attempts 
                                ->If you are running other services that use the network connection, you should monitor these counters to ensure that the Web server can use as much of the connection as it needs.

Processor: %Processor Time, 
Network Interface Connection: Bytes Total/sec
PhysicalDisk: %Disk Time 
                                ->If all three of these counters have high values, the hard disk is not causing a bottleneck. However, if %Disk Time is high and the other two counters are low, the disk might be the bottleneck.


#>}


#--------------------------------------------
#    			The Web Server
#--------------------------------------------
{<#

Memory:Available Bytes 
                             ->Indicates available memory. At least 10 percent of memory should be available for peak use.
Memory:Page Faults/sec 
Memory:Pages Input/sec
Memory:Page Reads/sec 
                             ->Use the first counter to determine the overall rate at which the system is handling hard and soft page faults. Memory:Pages Input/sec, which should be greater than or equal to Memory:Page Reads/sec, indicates the hard page fault rate. If these numbers are high, it's likely that too much memory is dedicated to the caches.

Memory: Cache Bytes, 
Internet Information Services Global: File Cache Hits %, 
Internet Information Services Global: File Cache Hits 
Internet Information Services Global: File Cache Flushes 
                              ->Because IIS automatically trims the file system cache if it is running out of memory, you can use the File Cache Hits % counter trend to monitor memory availability. Use the second counter to see how well IIS is using the file cache. On a site made up mostly of static files, this value should be 80 percent or higher. You can compare Internet Information Services Global: File Cache Hits and Internet Information Services Global: File Cache Flushes to determine whether objects are flushed too quickly (more often than they need to be) or too slowly (thus, wasting memory).


Page File Bytes: Total 
                              ->Indicates the size of the paging file. The paging file on the system drive should be at least twice the size of physical memory. You can improve performance by striping the paging file across multiple disks.
Memory: Pool Paged Bytes, Memory:Pool Nonpaged Bytes, 
Process: Pool Paged Bytes:Inetinfo, 
Process: Pool Nonpaged Bytes:Inetinfo, 
Process: Pool Paged Bytes: dllhost#n, and 
Process: Pool Nonpaged Bytes: dllhost#n 
                              ->Use these counters to monitor the pool space for all of the processes on the server as well as those used directly by IIS, either by the Inetinfo or Dllhost processes.
                              +Tip Besides adding more memory, you can enhance memory performance by: 
                              w Improving data organization on the disk.
                              w Implementing disk mirroring or striping.
                              w Replacing Common Gateway Interface (CGI) applications with ISAPI or ASP applications.
                              w Increasing paging file size.
                              w Retiming the IIS file cache.
                              w Eliminating unnecessary features.
                              w Changing the balance of the file system cache to the IIS working set.
System: Processor Queue Length 
                              ->Use to flag a bottleneck. If this counter has a sustained value of two or more threads, there is likely a bottleneck.
Processor: %Processor Time 
                              ->Use to flag a bottleneck. A bottleneck is indicated by a high Processor: %Processor Time value and values that are well below capacity for the network adapter and disk I/O.
Thread: Context Switch/ sec:Dllhost#n=>Thread#, 
Thread: Context Switch/sec:Inetinfo=> Thread#, and 
System: Context Switches/sec 
                              ->Use to determine whether to increase the size of the thread pool.
							  w If the counters in Table 10.3 indicate a processor bottleneck, you have to determine if the current workload is significantly CPU-intensive. If it is, it's unlikely that a single system will be able to keep up with processing requests, even if it has multiple CPUs. The only remedy in this scenario is to add another server. 


#>}
#--------------------------------------------
# 
#--------------------------------------------



#--------------------------------------------
# 
#--------------------------------------------



#--------------------------------------------
# 
#--------------------------------------------