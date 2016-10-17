<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node COLOR="#ff0000" CREATED="1357782956450" LINK="onSQL.mm" MODIFIED="1387748690568" TEXT="Performance Tuning (59) ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <a href="http://technet.microsoft.com/en-us/sqlserver/bb671430">http://technet.microsoft.com/en-us/sqlserver/bb671430 </a>
    </p>
    <p>
      <a href="http://technet.microsoft.com/en-us/library/cc966540.aspx">http://technet.microsoft.com/en-us/library/cc966540.aspx&#160; </a>&#160; Troubleshooting Performance Problems in SQL Server 2005
    </p>
    <p>
      what is acceptable (performance vs Price)
    </p>
    <p>
      &quot;good&#160;&#160;enough &quot; tuning
    </p>
    <p>
      Too many server , Too many resource
    </p>
  </body>
</html></richcontent>
<node CREATED="1361170351920" MODIFIED="1379390987568" POSITION="right" TEXT="inspection">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      http://msdn.microsoft.com/zh-tw/library/ms191511.aspx
    </p>
  </body>
</html></richcontent>
<node CREATED="1361170917554" MODIFIED="1361171369643" TEXT="bult-in"/>
</node>
<node CREATED="1378273065666" MODIFIED="1379915514808" POSITION="right" TEXT="The Performance Tuning Process">
<node CREATED="1378273435298" MODIFIED="1378273450319" TEXT="Is any other resource-intensive application running on the same server"/>
<node CREATED="1378273460971" MODIFIED="1378273464442" TEXT="Is the capacity of the hardware subsystem capable of withstanding the maximum workload"/>
<node CREATED="1378273523886" MODIFIED="1378273526561" TEXT="Is SQL Server configured properly?"/>
<node CREATED="1378273532375" MODIFIED="1378273534265" TEXT="Is the database connection between SQL Server and the database application efficient?"/>
<node CREATED="1378273543268" MODIFIED="1378273545369" TEXT="Does the database des &#x2022; ign support the fastest data retrieval (and modification for an updatable database)?"/>
<node CREATED="1378273582742" MODIFIED="1378273584302" TEXT="Is the user workload, consisting of SQL queries, optimized to reduce the load on SQL Server"/>
<node CREATED="1378273597863" MODIFIED="1378273599126" TEXT="What processes are causing the system to slow down as reflected in the measurement of various wait states, performance counters, and dynamic management objects"/>
<node CREATED="1378273599746" MODIFIED="1378273615347" TEXT="Does the workload support the required level of concurrency?"/>
</node>
<node CREATED="1361169601745" MODIFIED="1379915517099" POSITION="right" TEXT="tools">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      http://msdn.microsoft.com/en-us/library/ms179428.aspx
    </p>
    <p>
      
    </p>
    <p>
      \\172.16.220.32\g$\microsoft\SQL\SQL&#25928;&#33021;&#35519;&#26657;\Advancedtuning.pptx
    </p>
  </body>
</html></richcontent>
<node CREATED="1361169655012" FOLDED="true" MODIFIED="1379901054322" TEXT="&#x53ef;&#x9760;&#x6027;&#x8207;&#x6548;&#x80fd;&#x76e3;&#x8996;&#x5668;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Performance Monitor&#160;&#160;Captures server activity
    </p>
    <p>
      
    </p>
    <p>
      Find out what is occurring at the server level
    </p>
    <p>
      Output to a file
    </p>
    <p>
      SQL counters can be captured via sys.dm_os_performance_counters
    </p>
  </body>
</html></richcontent>
<node CREATED="1361169752757" MODIFIED="1361169754306" TEXT="&#x6548;&#x80fd;&#x7269;&#x4ef6;"/>
<node CREATED="1361169759643" MODIFIED="1379390996760" TEXT="&#x6548;&#x80fd;&#x8a08;&#x6578;&#x5668;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <a href="onenote://C:/Users/Administrator/SkyDrive/onMicrosoft/SQL/Database%20Administration/Performance%20Tuning.one#**count%20index&amp;section-id={59AAAB96-4AAD-441A-966C-E3BD27A345C5}&amp;page-id={9A76FACE-3517-446D-92C6-72724F8AFD57}&amp;end">**count index</a>
    </p>
  </body>
</html></richcontent>
<node CREATED="1378691731270" MODIFIED="1378691733996" TEXT="Disk">
<node CREATED="1378691674018" MODIFIED="1378691687757" TEXT="PhysicalDisk: Avg. Disk sec/Write"/>
<node CREATED="1379389820565" MODIFIED="1379389823599" TEXT="Physical Disk&#x2014;% Disk Time     &#x5e73;&#x5747;&#x61c9;&#x4f4e;&#x65bc;50% "/>
<node CREATED="1378691699055" MODIFIED="1379389890715" TEXT="PhysicalDisk: Avg. Disk sec/Read">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="margin-right: 0in; font-family: Calibri; margin-left: 0in; margin-bottom: 0in; font-size: 12.0pt; margin-top: 0in">
      &#29992;&#20358;&#35413;&#20272;&#30913;&#30879;&#22823;&#23567;&#33287;CPU&#36895;&#24230;&#12290;&#25033;&#35442;&#20302;&#26044;&#30913;&#30879;&#23481;&#37327;&#30340;85%&#12290;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379389890696" MODIFIED="1379391413778" TEXT="Physical Disk&#x2014;Avg. Disk Writes/ sec">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="margin-right: 0in; font-family: Calibri; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      &#29992;&#20358;&#35413;&#20272;&#30913;&#30879;&#22823;&#23567;&#33287;CPU&#36895;&#24230;&#12290;&#25033;&#35442;&#20302;&#26044;&#30913;&#30879;&#23481;&#37327;&#30340;85%&#12290;
    </p>
    <p style="margin-right: 0in; font-family: Calibri; margin-left: 0in; margin-bottom: 0in; font-size: 12.0pt; margin-top: 0in">
      &#22914;&#26524;&#36039;&#26009;&#24235;&#25033;&#29992;&#31243;&#24335;&#24050;&#32147;&#37096;&#32626;&#65292;&#32780;&#29694;&#26377;&#30828;&#39636;&#29872;&#22659;&#23578;&#26410;&#21040;&#36948;&#26368;&#22823;I/O&#36039;&#26009;&#34389;&#29702;&#37327;&#65292;&#21487;&#20197;&#21033;&#29992;Physical Disk: Disk Reads/sec&#33287;Physical Disk: Disk Writes/sec&#35336;&#25976;&#22120;&#20358;&#21028;&#26039;&#27599;&#31186;&#35712;&#23531;&#27425;&#25976;&#65292;&#28982;&#24460;&#27604;&#23565;&#20043;&#21069;&#24314;&#31435;&#30340;&#25928;&#33021;&#22522;&#28310;&#65292;&#34249;&#27492;&#38928;&#20272;&#26410;&#20358;&#26576;&#27573;&#26178;&#38291;&#65288;&#20363;&#22914;&#19977;&#24180;&#65289;&#30340;&#36039;&#26009;&#25104;&#38263;&#29575;&#65292;&#30452;&#21040;&#30828;&#39636;&#35373;&#20633;&#19981;&#25975;&#20351;&#29992;&#38656;&#35201;&#26356;&#25563;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379389841205" MODIFIED="1379389852306" TEXT="Physical Disk&#x2014;Avg. Disk Queue Length  &#x6bcf;&#x500b;&#x78c1;&#x789f;&#x5e73;&#x5747;&#x61c9;&#x4f4e;&#x65bc;2&#x3002;&#x5982;&#x679c;&#x662f;5&#x500b;&#x78c1;&#x789f;&#x7684;&#x9663;&#x5217;&#xff0c;&#x6b64;&#x8a08;&#x6578;&#x5668;&#x5e73;&#x5747;&#x61c9;&#x8a72;&#x4f4e;&#x65bc;10&#x3002;"/>
<node CREATED="1378691775558" MODIFIED="1378691791461" TEXT="SQL Server:Buffer Manager:Page reads/sec "/>
<node CREATED="1378691830826" MODIFIED="1378691832962" TEXT="SQL Server:Buffer Manager:Page writes/sec"/>
<node CREATED="1378691837641" MODIFIED="1378691839469" TEXT="SQL Server:Buffer Manager:Checkpoint pages/sec"/>
<node CREATED="1378691844072" MODIFIED="1378691845763" TEXT="SQL Server:Buffer Manager:Lazy writes/sec"/>
</node>
<node CREATED="1378691735453" FOLDED="true" MODIFIED="1379390307052" TEXT="CPU">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      When you examine processor usage, consider the type of work that the instance of SQL Server performs. If SQL Server performs many calculations, such as queries involving aggregates or memory-bound queries that require no disk I/O, 100 percent of the processor's time can be used.&#22312;&#27298;&#26597;&#34389;&#29702;&#22120;&#20351;&#29992;&#37327;&#26178;&#65292;&#35531;&#32771;&#24942; SQL Server &#22519;&#34892;&#20491;&#39636;&#25152;&#22519;&#34892;&#30340;&#24037;&#20316;&#39006;&#22411;&#12290; &#22914;&#26524; SQL Server &#27491;&#22312;&#22519;&#34892;&#35377;&#22810;&#35336;&#31639;&#65292;&#20363;&#22914;&#29309;&#28041;&#21040;&#24409;&#32317;&#30340;&#26597;&#35426;&#65292;&#25110;&#19981;&#38656;&#35201;&#30913;&#30879; I/O &#30340;&#35352;&#25014;&#39636;&#32363;&#32080;&#26597;&#35426; (Memory-bound Query) &#26178;&#65292;&#23601;&#21487;&#20197;&#20351;&#29992; 100 % &#30340;&#34389;&#29702;&#22120;&#26178;&#38291;&#12290;
    </p>
    <p>
      &#160;If this causes the performance of other applications to suffer, try changing the workload. For example, dedicate the computer to running the instance of SQL Server.
    </p>
    <p>
      &#22914;&#26524;&#36889;&#23566;&#33268;&#20854;&#20182;&#25033;&#29992;&#31243;&#24335;&#30340;&#25928;&#33021;&#38477;&#20302;&#65292;&#35531;&#35722;&#26356;&#24037;&#20316;&#36000;&#36617;&#12290; &#20363;&#22914;&#65292;&#35731;&#27492;&#38651;&#33126;&#23560;&#38272;&#29992;&#20358;&#22519;&#34892; SQL Server &#22519;&#34892;&#20491;&#39636;
    </p>
  </body>
</html></richcontent>
<node CREATED="1378693281176" MODIFIED="1378693289194" TEXT="Process: Page Faults/sec&#xa0;"/>
<node CREATED="1378696459351" MODIFIED="1379386461897" TEXT="Processor:% Processor Time&#xa0;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      An efficient way to determine CPU usage is to use the&#160;Processor:% Processor Time&#160;counter in System Monitor.
    </p>
    <p>
      &#160;This counter monitors the amount of time the CPU spends executing a thread that is not idle. A consistent state of 80 percent to 90 percent may indicate the need to upgrade your CPU or add more processors.
    </p>
    <p>
      
    </p>
    <p>
      &#160;&#27492;&#35336;&#25976;&#22120;&#21487;&#30435;&#35222; CPU &#33457;&#36027;&#22312;&#22519;&#34892;&#38750;&#38290;&#32622;&#22519;&#34892;&#32210;&#19978;&#30340;&#26178;&#38291;&#37327;&#12290;&#29376;&#24907;&#32173;&#25345;&#22312; 80% &#21040; 90%&#65292;&#21487;&#33021;&#20195;&#34920;&#24517;&#38920;&#23559; CPU &#21319;&#32026;&#25110;&#22686;&#21152;&#26356;&#22810;&#34389;&#29702;&#22120;
    </p>
    <p style="margin-right: 0in; color: #343434; margin-bottom: 0in; margin-left: 0in; line-height: 23pt; font-size: 12.0pt; margin-top: 0in">
      <font face="Arial">CPU</font><font face="Corbel">&#21033;&#29992;&#29575;&#65292;&#35813;&#35745;&#25968;&#22120;&#26368;&#20026;&#24120;&#29992;&#65292;&#21487;&#20197;&#26597;&#30475;&#22788;&#29702;&#22120;&#26159;&#21542;&#22788;&#20110;&#39281;&#21644;&#29366;&#24577;&#65292;&#22914;&#26524;&#35813;&#20540;&#25345;&#32493;&#36229;&#36807;</font><font face="Arial">&#160; 95%</font><font face="Corbel">&#65292;&#23601;&#34920;&#31034;&#24403;&#21069;&#31995;&#32479;&#30340;&#29942;&#39048;&#20026;</font><font face="Arial">CPU</font><font face="Corbel">&#65292;&#21487;&#20197;&#32771;&#34385;&#22686;&#21152;&#19968;&#20010;&#22788;&#29702;&#22120;&#25110;&#26356;&#25442;&#19968;&#20010;&#24615;&#33021;&#26356;&#22909;&#30340;&#22788;&#29702;&#22120;&#12290;</font><font face="Arial">(</font><font face="Corbel">&#21442;&#32771;&#20540;&#65306;</font><font face="Arial">&lt;80%) </font>
    </p>
    <p style="margin-right: 0in; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      
    </p>
    <p style="margin-right: 0in; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      <span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">Processor:% Processor Time</font></span><span><font face="Corbel">&#160;&#160; </font></span><span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">&#24179;&#22343;&#25033;&#20302;&#26044;75%&#65288;&#26368;&#22909;&#20302;&#26044;50%&#65289;</font></span>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378696578723" MODIFIED="1378701287844" TEXT="System: %Total Processor Time&#xa0;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#160;To determine the average for all processors, use the&#160;System: %Total Processor Time&#160;counter instead.
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#31995;&#32479;&#20013;&#25152;&#26377;&#22788;&#29702;&#22120;&#37117;&#22788;&#20110;&#32321;&#24537;&#29366;&#24577;&#30340;&#26102;&#38388;&#30334;&#20998;&#27604;&#65292;&#23545;&#20110;&#22810;&#22788;&#29702;&#22120;&#31995;&#32479;&#26469;&#35828;&#65292;&#35813;&#20540;&#21487;&#20197;&#21453;&#26144;&#25152;&#26377;&#22788;&#29702;&#22120;&#30340;&#24179;&#22343;&#32321;&#24537;&#29366;&#24577;&#65292;&#35813;&#20540;&#20026;</span></font><font face="Arial"><span style="font-family: Arial">100%</span></font><font face="Corbel"><span style="font-family: Corbel">&#65292;&#22914;&#26524;&#26377;&#19968;&#21322;&#30340;&#22788;&#29702;&#22120;&#20026;&#32321;&#24537;&#29366;&#24577;&#65292;&#35813;&#20540;&#20026;</span></font><font face="Arial"><span style="font-family: Arial">50%</span></font>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378696672457" MODIFIED="1378701983814" TEXT="Processor: % Privileged Time ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Arial">CPU</font><font face="Corbel">&#22312;&#29305;&#26435;&#27169;&#24335;&#19979;&#22788;&#29702;&#32447;&#31243;&#25152;&#33457;&#30340;&#26102;&#38388;&#30334;&#20998;&#27604;&#12290;&#19968;&#33324;&#30340;&#31995;&#32479;&#26381;&#21153;&#65292;&#36827;&#22478;&#31649;&#29702;&#65292;&#20869;&#23384;&#31649;&#29702;&#31561;&#19968;&#20123;&#30001;&#25805;&#20316;&#31995;&#32479;&#33258;&#34892;&#21551;&#21160;&#30340;&#36827;&#31243;&#23646;&#20110;&#36825;&#31867;</font>
    </p>
    <p>
      
    </p>
    <p>
      Corresponds to the percentage of time the processor spends on execution of Microsoft Windows kernel commands, such as processing of SQL Server I/O requests. If this counter is consistently high when the&#160;Physical Disk&#160;counters are high, consider installing a faster or more efficient disk subsystem.&#30456;&#30070;&#26044;&#34389;&#29702;&#22120;&#33457;<font color="#ff0033">&#36027;&#22312;&#22519;&#34892; Microsoft Windows &#26680;&#24515;&#21629;&#20196;</font>&#160;(&#22914;&#34389;&#29702; SQL Server I/O &#35201;&#27714;) &#30340;&#26178;&#38291;&#30334;&#20998;&#27604;&#12290;
    </p>
    <p>
      &#160;&#30070;&#160;Physical Disk&#160;&#35336;&#25976;&#22120;&#24456;&#39640;&#26178;&#65292;&#22914;&#26524;&#36889;&#20491;&#35336;&#25976;&#22120;&#20063;&#25345;&#32396;&#20559;&#39640;&#65292;&#35531;&#32771;&#24942;&#25563;&#29992;&#36611;&#24555;&#25110;&#36611;&#26377;&#25928;&#29575;&#30340;&#30913;&#30879;&#23376;&#31995;&#32113; (Disk Subsystem)
    </p>
    <p>
      
    </p>
    <p>
      Proess &#28961;&#27861;&#33287; other process &#20849;&#20139;&#30340; pages&#25976;&#37327;&#12290;&#35442;&#35336;&#25976;&#22120;&#30340;&#20540;&#36611;&#22823;&#26178;&#65292;&#26377;&#21487;&#33021;&#26159;&#20839;&#23384;&#27945;&#38706;&#30340;&#20449;&#34399;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378696799559" MODIFIED="1378701424520" TEXT="Processor: %User Time">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#19982;</span></font><font face="Arial"><span style="font-family: Arial">%Privileged Time</span></font><font face="Corbel"><span style="font-family: Corbel">&#35745;&#25968;&#22120;&#27491;&#22909;&#30456;&#21453;&#65292;&#25351;&#30340;&#26159;&#22312;&#29992;&#25143;&#29366;&#24577;&#27169;&#24335;&#19979;</span></font><font face="Arial"><span style="font-family: Arial">(</span></font><font face="Corbel"><span style="font-family: Corbel">&#21363;&#38750;&#29305;&#26435;&#27169;&#24335;</span></font><font face="Arial"><span style="font-family: Arial">)</span></font><font face="Corbel"><span style="font-family: Corbel">&#30340;&#25805;&#20316;&#25152;&#33457;&#30340;&#26102;&#38388;&#30334;&#20998;&#27604;&#12290;&#22914;&#26524;&#35813;&#20540;&#36739;&#22823;&#65292;&#21487;&#20197;&#32771;&#34385;&#26159;&#21542;&#36890;&#36807;&#31639;&#27861;&#20248;&#21270;&#31561;&#26041;&#27861;&#38477;&#20302;&#36825;&#20010;&#20540;&#12290;&#22914;&#26524;&#35813;&#26381;&#21153;&#22120;&#26159;&#25968;&#25454;&#24211;&#26381;&#21153;&#22120;&#65292;&#23548;&#33268;&#27492;&#20540;&#36739;&#22823;&#30340;&#21407;&#22240;&#24456;&#21487;&#33021;&#26159;&#25968;&#25454;&#24211;&#30340;&#25490;&#24207;&#25110;&#26159;&#20989;&#25968;&#25805;&#20316;&#28040;&#32791;&#20102;&#36807;&#22810;&#30340;</span></font><font face="Arial"><span style="font-family: Arial">CPU</span></font><font face="Corbel"><span style="font-family: Corbel">&#26102;&#38388;&#65292;&#27492;&#26102;&#21487;&#20197;&#32771;&#34385;&#23545;&#25968;&#25454;&#24211;&#31995;&#32479;&#36827;&#34892;&#20248;&#21270;</span></font>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378696859195" MODIFIED="1379389184850" TEXT="System: Processor Queue Length">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="margin-right: 0in; color: #343434; margin-bottom: 0in; margin-left: 0in; line-height: 23pt; font-size: 12.0pt; margin-top: 0in">
      <font face="Corbel">Process &#22312;&#31561;&#24453;&#20998;&#37197;</font><font face="Arial">CPU</font><font face="Corbel">&#36164;&#28304;&#25152;&#25490;&#38431;&#21015;&#30340;&#38271;&#24230;&#65292;&#27492;&#38271;&#24230;&#19981;&#21253;&#25324;&#27491;&#22312;&#21344;&#26377;</font><font face="Arial">CPU</font><font face="Corbel">&#36164;&#28304;&#30340;&#32447;&#31243;&#12290;&#22914;&#26524;&#35813;&#38431;&#21015;&#30340;&#38271;&#24230;&#22823;&#20110;&#22788;&#29702;&#22120;&#20010;&#25968;</font><font face="Arial">+1</font><font face="Corbel">&#65292;&#23601;&#34920;&#31034;&#22788;&#29702;&#22120;&#26377;&#21487;&#33021;&#22788;&#20110;&#38459;&#22622;&#29366;&#24577;</font><font face="Arial">(</font><font face="Corbel">&#21442;&#32771;&#20540;&#65306;</font><font face="Arial">&lt;=</font><font face="?s?????">&#22788;&#29702;&#22120;&#20010;&#25968;</font><font face="Arial">+1)</font>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378701483326" MODIFIED="1378701523489" TEXT="%DPC Time">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#22788;&#29702;&#22120;&#22312;&#32593;&#32476;&#22788;&#29702;&#19978;&#28040;&#32791;&#30340;&#26102;&#38388;&#65292;&#35813;&#20540;&#36234;&#20302;&#36234;&#22909;&#12290;&#22312;&#22810;&#22788;&#29702;&#22120;&#31995;&#32479;&#20013;&#65292;&#22914;&#26524;&#36825;&#20010;&#20540;&#22823;&#20110;</span></font><font face="Arial"><span style="font-family: Arial">50%</span></font><font face="Corbel"><span style="font-family: Corbel">&#24182;&#19988;</span></font><font face="Arial"><span style="font-family: Arial">%Processor Time</span></font><font face="Corbel"><span style="font-family: Corbel">&#38750;&#24120;&#39640;&#65292;&#21152;&#20837;&#19968;&#20010;&#32593;&#21345;&#21487;&#33021;&#20250;&#25552;&#39640;&#24615;&#33021;&#12290;</span></font>
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1378691744378" MODIFIED="1379391000741" TEXT="Memory">
<node CREATED="1378692592497" MODIFIED="1379389791263" TEXT="Memory: Available Bytes">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="margin-right: 0in; margin-left: 0in; margin-bottom: 0in; line-height: 13pt; margin-top: 0in">
      indicates how many bytes of memory are currently available for use by processes. &#20195;&#34920;&#30446;&#21069;&#26377;&#22810;&#23569;&#35352;&#25014;&#39636;&#20301;&#20803;&#32068;&#21487;&#20379;&#34389;&#29702;&#24207;&#20351;&#29992;
    </p>
    <p style="margin-right: 0in; margin-bottom: 0in; margin-left: 0in; line-height: 13pt; margin-top: 0in">
      Low values for the&#160;Available Bytes&#160;counter can indicate that there is an overall shortage of memory on the computer or that an application is not releasing memory.&#160;&#160;&#33509; Available Bytes &#35336;&#25976;&#22120;&#30340;&#25976;&#20540;&#20559;&#20302;&#65292;&#20195;&#34920;&#38651;&#33126;&#25972;&#39636;&#22320;&#32570;&#20047;&#35352;&#25014;&#39636;&#65292;&#25110;&#26377;&#26576;&#20491;&#25033;&#29992;&#31243;&#24335;&#27794;&#26377;&#37323;&#20986;&#35352;&#25014;&#39636;
    </p>
    <p style="margin-right: 0in; color: #343434; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      <font face="Corbel">&#21097;&#20313;&#30340;&#21487;&#29992;&#29289;&#29702;&#20869;&#23384;&#65292;&#21333;&#20301;&#26159;&#20806;&#23383;&#33410;</font><font face="Arial">(</font><font face="Corbel">&#21442;&#32771;&#20540;&#65306;</font><font face="Arial">&gt;=10%)</font><font face="?s?????">&#12290;&#34920;&#26126;&#36827;&#31243;&#24403;&#21069;&#21487;&#20351;&#29992;&#30340;&#20869;&#23384;&#23383;&#33410;&#25968;,</font>
    </p>
    <p style="margin-right: 0in; color: #343434; margin-left: 0in; margin-bottom: 0in; line-height: 23pt; font-size: 12.0pt; margin-top: 0in">
      <font face="Corbel">&#22914;&#26524;</font><font face="Arial">&#160;Available Bytes </font><font face="Corbel">&#30340;&#20540;&#24456;&#23567;</font><font face="Arial">(4 MB </font><font face="Corbel">&#25110;&#26356;&#23567;</font><font face="Arial">)</font><font face="Corbel">&#65292;&#21017;&#35828;&#26126;&#35745;&#31639;&#26426;&#19978;&#24635;&#30340;&#20869;&#23384;&#21487;&#33021;&#19981;&#36275;&#65292;&#25110;&#26576;&#31243;&#24207;&#27809;&#26377;&#37322;&#25918;&#20869;&#23384; </font>
    </p>
    <p style="margin-right: 0in; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      
    </p>
    <p style="margin-right: 0in; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      <span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">Memory&#8212;Available Bytes</font></span><span style="font-family: Corbel" lang="en-US"><font face="Corbel">&#160;</font></span><span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">&#25033;&#35442;&#32173;&#25345;&#22312;50 MB&#20197;&#19978;</font></span>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378692601250" MODIFIED="1379389759064" TEXT="Memory: Pages/sec ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      indicates the number of pages that either were retrieved<font color="#ff0033">&#160;from disk</font>&#160; due to hard page faults <b>or</b>&#160;<font color="#ff0033">written to disk</font>&#160;to free space in the working set due to page faults.&#35336;&#25976;&#22120;&#26371;&#39023;&#31034;&#30001;&#26044;&#30828;&#39636;&#20998;&#38913;&#37679;&#35492;&#32780;&#33258;&#30913;&#30879;&#21462;&#20986;&#65292;&#25110;&#30001;&#26044;&#20998;&#38913;&#37679;&#35492;&#32780;&#23531;&#20837;&#30913;&#30879;&#65292;&#20197;&#37323;&#20986;&#24037;&#20316;&#38598;&#20839;&#31354;&#38291;&#30340;&#20998;&#38913;&#25976;
    </p>
    <p>
      A high rate for the&#160;Pages/sec&#160;counter could indicate excessive paging. Pages/sec &#35336;&#25976;&#22120;&#25976;&#20540;&#36942;&#39640;&#21487;&#33021;&#20195;&#34920;&#36942;&#24230;&#20998;&#38913;
    </p>
    <p style="margin-right: 0in; color: #343434; margin-bottom: 0in; margin-left: 0in; line-height: 23pt; font-size: 12.0pt; margin-top: 0in">
      <font face="Corbel">&#22914;&#26524;</font><font face="Arial">&#160;Pages/sec </font><font face="Corbel">&#30340;&#20540;&#20026;</font><font face="Arial">&#160;</font><font face="Arial" color="#ff0033">&#160; 20 </font><font face="Corbel" color="#ff0033">&#25110;&#26356;&#22823;</font><font face="Corbel">&#65292;&#37027;&#20040;&#24744;&#24212;&#35813;&#36827;&#19968;&#27493;&#30740;&#31350;&#39029;&#20132;&#25442;&#27963;&#21160;&#12290;</font><font face="Arial">Pages/sec </font><font face="Corbel">&#30340;&#20540;&#24456;&#22823;&#19981;&#19968;&#23450;&#34920;&#26126;&#20869;&#23384;&#26377;&#38382;&#39064;&#65292;&#32780;&#21487;&#33021;&#26159;&#36816;&#34892;&#20351;&#29992;&#20869;&#23384;&#26144;&#23556;&#25991;&#20214;&#30340;&#31243;&#24207;&#25152;&#33268;&#12290; </font>
    </p>
    <p style="margin-right: 0in; color: #343434; margin-left: 0in; margin-bottom: 0in; line-height: 23pt; font-size: 12.0pt; margin-top: 0in">
      <font face="Corbel">&#34920;&#31034;&#20026;&#20102;&#35299;&#20915;&#30828;&#38169;&#35823;&#32780;&#20174;&#30828;&#30424;&#19978;&#35835;&#21462;&#25110;&#20889;&#20837;&#30828;&#30424;&#30340;&#39029;&#25968;</font><font face="Arial">(</font><font face="Corbel">&#21442;&#32771;&#20540;&#65306;</font><font face="Arial">00~20)</font>
    </p>
    <p style="margin-right: 0in; color: #343434; margin-left: 0in; margin-bottom: 0in; line-height: 23pt; font-size: 12.0pt; margin-top: 0in">
      <font face="Corbel">&#24517;&#39035;&#21516;&#26102;&#30417;&#35270;</font><font face="Arial">Available Bytes</font><font face="Corbel">&#12289;</font><font face="Arial">Pages/sec </font><font face="Corbel">&#21644;</font><font face="Arial">&#160;&#160;Paging File % Usage</font><font face="Corbel">&#65292;&#20197;&#20415;&#30830;&#23450;&#26159;&#21542;&#21457;&#29983;&#36825;&#31181;&#24773;&#20917;&#12290;&#22914;&#26524;&#27491;&#22312;&#35835;&#21462;&#38750;&#32531;&#23384;&#20869;&#23384;&#26144;&#23556;&#25991;&#20214;&#65292;&#36824;&#24212;&#35813;&#26597;&#30475;&#32531;&#23384;&#27963;&#21160;&#26159;&#21542;&#27491;&#24120;</font>
    </p>
    <p style="margin-right: 0in; margin-bottom: 0in; margin-left: 0in; font-size: 12.0pt; margin-top: 0in">
      <span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">Memory&#8212;Pages/sec</font></span><span><font face="Corbel">&#160;&#160; </font></span><span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">&#24179;&#22343;&#25033;&#20302;&#26044;20&#65288;&#26368;&#22909;&#20302;&#26044;15&#65289;</font></span>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378692734916" MODIFIED="1378698149454" TEXT="Memory: Page Faults/sec">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      It make sure that the disk activity is not caused by paging
    </p>
    <p>
      
    </p>
    <p>
      &#24403;&#22788;&#29702;&#22120;&#22312;Memory&#20013;&#35835;&#21462;&#26576;&#19968;&#39029;&#20986;&#29616;&#38169;&#35823;&#26102;&#65292;&#23601;&#20250;&#20135;&#29983;&#32570;&#39029;&#20013;&#26029;&#65292;&#20063;&#23601;&#26159; page Fault&#12290;
    </p>
    <p>
      &#22914;&#26524;&#36825;&#20010;&#39029;&#20301;&#20110;Memory&#30340;&#20854;&#20182;&#20301;&#32622;&#65292;&#36825;&#31181;&#38169;&#35823;&#31216;&#20026;&#36719;&#38169;&#35823;&#65292;&#29992;Transition Fault/sec &#26469;&#34913;&#37327;;
    </p>
    <p>
      &#22914;&#26524;&#36825;&#20010;&#39029;&#20301;&#20110;disk &#19978;&#65292;&#24517;&#39035;&#20174;&#30828;&#30424;&#37325;&#26032;&#35835;&#21462;&#65292;&#36825;&#20010;&#38169;&#35823;&#25104;&#20026;&#30828;&#38169;&#35823;&#12290;
    </p>
    <p>
      &#30828;&#38169;&#35823;&#20250;&#20351;&#31995;&#32479;&#30340;&#36816;&#34892;&#25928;&#29575;&#24456;&#24555;&#23558;&#19979;&#26469;&#12290;
    </p>
    <p>
      Page Faults/sec&#36825;&#20010;&#35745;&#25968;&#22120;&#23601;&#34920;&#31034;&#27599;&#31186;&#38047;&#22788;&#29702;&#30340;&#38169;&#35823;&#39029;&#25968;&#65292;&#21253;&#25324;&#30828;&#38169;&#35823;&#21644;&#36719;&#38169;&#35823;&#12290;
    </p>
    <p>
      
    </p>
    <p>
      
    </p>
    <p>
      
    </p>
    <p>
      ---
    </p>
    <p>
      --
    </p>
    <p>
      ---
    </p>
    <p>
      The Microsoft Windows Virtual Memory Manager (VMM) takes pages from SQL Server and other processes as it trims the working-set sizes of those processes.
    </p>
    <p>
      &#30070;&#12300;Microsoft Windows &#34395;&#25836;&#35352;&#25014;&#39636;&#31649;&#29702;&#21729; (VMM)&#12301;&#20462;&#21098; SQL Server &#21644;&#20854;&#20182;&#34389;&#29702;&#24207;&#30340;&#24037;&#20316;&#38598;&#22823;&#23567;&#26178;&#65292;&#23427;&#26371;&#24478;&#36889;&#20123;&#34389;&#29702;&#24207;&#21462;&#24471;&#20998;&#38913;
    </p>
    <p>
      
    </p>
    <p>
      This VMM activity tends to cause page faults.For more information about resolving excessive paging, see the Windows operating system documentation.
    </p>
    <p>
      &#160;To determine whether SQL Server or another process is the cause of excessive paging, monitor the&#160;Process: Page Faults/sec&#160;counter for the SQL Server process instance.
    </p>
    <p>
      &#12290;&#160;&#27492; VMM &#27963;&#21205;&#26371;&#36896;&#25104;&#20998;&#38913;&#37679;&#35492;&#12290;&#160;&#33509;&#35201;&#21028;&#23450; SQL Server &#25110;&#20854;&#20182;&#34389;&#29702;&#24207;&#26159;&#21542;&#36896;&#25104;&#36942;&#24230;&#20998;&#38913;&#65292;&#35531;&#30435;&#35222; SQL Server &#34389;&#29702;&#24207;&#22519;&#34892;&#20491;&#39636;&#30340;&#160;Process: Page Faults/sec&#160;&#35336;&#25976;&#22120;
    </p>
    <p>
      
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378698162206" MODIFIED="1378698231104" TEXT="Page Input/sec ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#34920;&#31034;&#20026;&#20102;&#35299;&#20915;&#30828;&#38169;&#35823;&#32780;&#20889;&#20837;&#30828;&#30424;&#30340;&#39029;&#25968;</span></font><font face="Arial"><span style="font-family: Arial">(</span></font><font face="Corbel"><span style="font-family: Corbel">&#21442;&#32771;&#20540;&#65306;</span></font><font face="Arial"><span style="font-family: Arial">&gt;=Page Reads/sec)</span></font>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378698233388" MODIFIED="1378698270451" TEXT="Page Reads/sec ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#34920;&#31034;&#20026;&#20102;&#35299;&#20915;&#30828;&#38169;&#35823;&#32780;&#20174;&#30828;&#30424;&#19978;&#35835;&#21462;&#30340;&#39029;&#25968;&#12290;</span></font><font face="Arial"><span style="font-family: Arial">(</span></font><font face="Corbel"><span style="font-family: Corbel">&#21442;&#32771;&#20540;&#65306;</span></font><font face="Arial"><span style="font-family: Arial">&#160; &lt;=5)</span></font>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378693300380" MODIFIED="1378696321901" TEXT="Process: Working Set  ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      The&#160;Working&#160;Set&#160;counter shows the amount of memory that is used by a process.
    </p>
    <p>
      &#35336;&#25976;&#22120;&#39023;&#31034;&#34389;&#29702;&#24207;&#20351;&#29992;&#30340;&#35352;&#25014;&#39636;&#25976;&#37327;
    </p>
    <p>
      If this number is consistently below the amount of memory that is set by the&#160;min server memory&#160;and&#160;max server memory&#160;server options, SQL Server is configured to use too much memory.
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378696321877" MODIFIED="1379389952470" TEXT="SQL Server: Buffer Manager: Buffer Cache Hit Ratio ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      The&#160;Buffer Cache Hit Ratio&#160;counter is specific to an application. However, a rate of 90 percent or higher is desirable. Add more memory until the value is consistently greater than 90 percent. A value greater than 90 percent indicates that more than 90 percent of all requests for data were satisfied from the data cache.
    </p>
    <p>
      &#35336;&#25976;&#22120;&#23560;&#20379;&#25033;&#29992;&#31243;&#24335;&#20351;&#29992;&#12290; &#19981;&#36942;&#65292;&#20854;&#25976;&#20540;&#26368;&#22909;&#28858; 90% &#25110;&#26356;&#39640;&#12290; &#35531;&#25345;&#32396;&#22686;&#21152;&#35352;&#25014;&#39636;&#65292;&#30452;&#21040;&#35442;&#25976;&#20540;&#25345;&#32396;&#22823;&#26044; 90%&#12290; &#25976;&#20540;&#22823;&#26044; 90% &#20195;&#34920;&#26377;&#36229;&#36942; 90% &#30340;&#36039;&#26009;&#35201;&#27714;&#65292;&#21487;&#33258;&#36039;&#26009;&#24555;&#21462;&#20013;&#24471;&#21040;&#25152;&#38656;&#30340;&#36039;&#26009;
    </p>
    <p style="margin-right: 0in; font-family: Calibri; margin-left: 0in; margin-bottom: 0in; font-size: 12.0pt; margin-top: 0in">
      &#25033;&#35442;&#36229;&#36942;90%&#65288;&#29702;&#24819;&#20540;&#26159;&#25509;&#36817;99%&#65289;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378696379422" MODIFIED="1378696384355" TEXT="SQL Server: Buffer Manager: Database Pages"/>
<node CREATED="1378696390172" MODIFIED="1378696408755" TEXT="SQL Server: Memory Manager: Total Server Memory (KB)">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      If the&#160;Total&#160;Server&#160;Memory (KB)&#160;counter is consistently high compared to the amount of physical memory in the computer, it may indicate that more memory is required.&#160;
    </p>
    <p>
      
    </p>
    <p>
      &#35336;&#25976;&#22120;&#21644;&#38651;&#33126;&#20013;&#30340;&#23526;&#39636;&#35352;&#25014;&#39636;&#25976;&#37327;&#30456;&#27604;&#19968;&#30452;&#24456;&#39640;&#65292;&#21487;&#33021;&#20195;&#34920;&#38656;&#35201;&#26356;&#22810;&#30340;&#35352;&#25014;&#39636;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378698569215" MODIFIED="1378698591228" TEXT="cache Byte">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#25991;&#20214;&#31995;&#32479;&#30340;&#32531;&#23384;</span></font><font face="Arial"><span style="font-family: Arial">(</span></font><font face="Corbel"><span style="font-family: Corbel">&#40664;&#35748;&#20026;</span></font><font face="Arial"><span style="font-family: Arial">50%</span></font><font face="Corbel"><span style="font-family: Corbel">&#30340;&#21487;&#29992;&#29289;&#29702;&#20869;&#23384;</span></font><font face="Arial"><span style="font-family: Arial">)</span></font>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379389968953" MODIFIED="1379390004117" TEXT="SQL Server: Buffer Manager:Page Life Expectancy &#x7528;&#x4f86;&#x8a55;&#x4f30;&#x8a18;&#x61b6;&#x9ad4;&#x5927;&#x5c0f;&#xff0c;&#x61c9;&#x8a72;&#x7dad;&#x6301;&#x5728;300&#x79d2;&#x4ee5;&#x4e0a;&#x3002;"/>
<node CREATED="1379390015677" MODIFIED="1379390017502" TEXT="SQL Server: General Statistics&#x2014; User Connections &#x7528;&#x4f86;&#x8a55;&#x4f30;&#x8a18;&#x61b6;&#x9ad4;&#x5927;&#x5c0f;"/>
<node CREATED="1379390031290" MODIFIED="1379390037393" TEXT="SQL Server: Databases&#x2014; Transactions/sec  &#x7528;&#x4f86;&#x8a55;&#x4f30;&#x4ea4;&#x6613;&#x91cf;&#x591a;&#x5be1;&#x8207;CPU&#x901f;&#x5ea6;&#x3002;"/>
<node CREATED="1379390045153" MODIFIED="1379390046650" TEXT="SQL Server: Databases&#x2014;Data File(s) Size KB  &#x7528;&#x4f86;&#x8a55;&#x4f30;&#x8cc7;&#x6599;&#x6a94;&#x5927;&#x5c0f;"/>
<node CREATED="1379390094125" MODIFIED="1379390095789" TEXT="SQL Server: Databases&#x2014;Percent Log Used &#x7528;&#x4f86;&#x8a55;&#x4f30;&#x4ea4;&#x6613;&#x8a18;&#x9304;&#x6a94;&#x5927;&#x5c0f;&#x3002;"/>
<node CREATED="1379391016176" MODIFIED="1379391058595" TEXT="SQL Server:SQL Statistics-Batch Requests/sec">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="margin-right: 0in; font-family: Calibri; margin-left: 0in; margin-bottom: 0in; font-size: 12.0pt; margin-top: 0in">
      &#24448;&#19978;&#21040;&#36948;&#26576;&#20491;&#27700;&#24179;&#20301;&#32622;&#65292;&#25110;&#26159;&#21319;&#39640;&#24460;&#36264;&#26044;&#24179;&#31337;&#65292;&#36890;&#24120;&#23601;&#26159;&#36935;&#21040;&#25928;&#33021;&#29942;&#38968;&#12290;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1378697195622" MODIFIED="1378697204869" TEXT="Network">
<node CREATED="1379389913684" MODIFIED="1379389923346" TEXT="Network Interface&#x2014;Bytes Total/sec">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="margin-right: 0in; margin-left: 0in; margin-bottom: 0in; font-size: 12.0pt; margin-top: 0in">
      <span><font face="Corbel">&#160;</font></span><span style="font-family: Calibri" lang="zh-TW"><font face="Calibri">&#29992;&#20358;&#35413;&#20272;&#32178;&#36335;&#38971;&#23532;&#22823;&#23567;</font></span>
    </p>
  </body>
</html></richcontent>
</node>
</node>
</node>
<node CREATED="1361169760837" MODIFIED="1361169767038" TEXT="&#x4f8b;&#x9805;">
<node CREATED="1378699833043" MODIFIED="1378701199992" TEXT="&#x68c0;&#x67e5;&#x8fc7;&#x4e8e;&#x9891;&#x7e41;&#x7684;&#x9875;&#x4ea4;&#x6362;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p style="font-size: 12.0pt; margin-bottom: 0in; margin-right: 0in; line-height: 23pt; color: #343434; font-family: Corbel; margin-left: 0in; margin-top: 0in">
      &#30001;&#20110;&#36807;&#22810;&#30340;swap &#35201;&#20351;&#29992;&#22823;&#37327;&#30340;&#30828;&#30424;&#31354;&#38388;&#65292;&#22240;&#27492;&#26377;&#21487;&#33021;&#23558;&#23548;&#33268;&#23558;&#39029;&#20132;&#25442;Memory &#19981;&#36275;&#65292;&#36825;&#23481;&#26131;&#19982;&#23548;&#33268;&#39029;&#20132;&#25442;&#30340;&#30913;&#30424;&#29942;&#39048;&#28151;&#28102;&#12290;
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; font-family: Corbel; margin-left: 0in; margin-top: 0in">
      &#22240;&#27492;&#65292;&#22312;&#30740;&#31350;&#20869;&#23384;&#19981;&#36275;&#19981;&#22826;&#26126;&#26174;&#30340;&#39029;&#20132;&#25442;&#30340;&#21407;&#22240;&#26102;&#65292;&#24744;&#24517;&#39035;&#36319;&#36394;&#22914;&#19979;&#30340;&#30913;&#30424;&#20351;&#29992;&#24773;&#20917;&#35745;&#25968;&#22120;&#21644;&#20869;&#23384;&#35745;&#25968;&#22120;&#65306;
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; font-family: Arial; margin-left: 0in; margin-top: 0in">
      &#183; Physical Disk\ % Disk Time
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; font-family: Arial; margin-left: 0in; margin-top: 0in">
      &#183; Physical Disk\ Avg.Disk Queue Length
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#20363;&#22914;&#65292;&#21253;&#25324;</span></font><font face="Arial"><span style="font-family: Arial">&#160;Page Reads/sec </span></font><font face="Corbel"><span style="font-family: Corbel">&#21644;</span></font><font face="Arial"><span style="font-family: Arial">&#160;% Disk Time </span></font><font face="Corbel"><span style="font-family: Corbel">&#21450;</span></font><font face="Arial"><span style="font-family: Arial">&#160;Avg.Disk Queue Length</span></font><font face="Corbel"><span style="font-family: Corbel">&#12290; </span></font>
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#22914;&#26524;&#39029;&#38754;&#35835;&#21462;(</span></font><font face="Arial"><span style="font-family: Arial">Page Reads/sec</span></font><font face="Corbel"><span style="font-family: Corbel">)&#25805;&#20316;&#36895;&#29575;&#24456;&#20302;&#65292;&#21516;&#26102;</span></font><font face="Arial"><span style="font-family: Arial">&#160;% Disk Time </span></font><font face="Corbel"><span style="font-family: Corbel">&#21644;</span></font><font face="Arial"><span style="font-family: Arial">&#160;Avg.Disk Queue Length</span></font><font face="Corbel"><span style="font-family: Corbel">&#30340;&#20540;&#24456;&#39640;&#65292;&#21017;&#21487;&#33021;&#26377;&#30913;&#30424;&#29942;&#24452;&#12290; </span></font>
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#20294;&#26159;&#65292;&#22914;&#26524;&#38431;&#21015;&#38271;&#24230;(</span></font>Physical Disk\ Avg.Disk Queue Length<font face="Corbel"><span style="font-family: Corbel">)&#22686;&#21152;&#30340;&#21516;&#26102;&#39029;&#38754;&#35835;&#21462;&#36895;&#29575;(</span></font><font face="Arial"><span style="font-family: Arial">Page Reads/sec</span></font><font face="Corbel"><span style="font-family: Corbel">)&#24182;&#26410;&#38477;&#20302;&#65292;&#21017;&#20869;&#23384;&#19981;&#36275;&#12290;</span></font>
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#35201;&#30830;&#23450;&#36807;&#22810;&#30340;&#39029;&#20132;&#25442;&#23545;&#30913;&#30424;&#27963;&#21160;&#30340;&#24433;&#21709;&#65292;&#35831;&#23558;</span></font><font face="Arial"><span style="font-family: Arial">&#160;<b>Physical Disk\ Avg.Disk sec/Transfer</b>&#160;</span></font><font face="Corbel"><span style="font-family: Corbel">&#21644;</span></font><font face="Arial"><span style="font-family: Arial">&#160;<b>Memory\ Pages/sec </b></span></font><font face="Corbel"><span style="font-family: Corbel">&#35745;&#25968;&#22120;&#30340;&#20540;&#22686;&#22823;&#25968;&#20493;&#12290; </span></font>
    </p>
    <p style="font-size: 12.0pt; margin-bottom: 0in; line-height: 23pt; margin-right: 0in; color: #343434; margin-left: 0in; margin-top: 0in">
      <font face="Corbel"><span style="font-family: Corbel">&#22914;&#26524;&#36825;&#20123;&#35745;&#25968;&#22120;&#30340;&#35745;&#25968;&#32467;&#26524;&#36229;&#36807;&#20102;</span></font><font face="Arial"><span style="font-family: Arial">&#160;0.1</span></font><font face="Corbel"><span style="font-family: Corbel">&#65292;&#37027;&#20040;&#39029;&#20132;&#25442;&#23558;&#33457;&#36153;&#30334;&#20998;&#20043;&#21313;&#20197;&#19978;&#30340;&#30913;&#30424;&#35775;&#38382;&#26102;&#38388;&#12290;&#22914;&#26524;&#38271;&#26102;&#38388;&#21457;&#29983;&#36825;&#31181;&#24773;&#20917;&#65292;&#37027;&#20040;&#24744;&#21487;&#33021;&#38656;&#35201;&#26356;&#22810;&#30340;&#20869;&#23384;</span></font>
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1361169769901" MODIFIED="1361169789777" TEXT="&#x5716;&#x8868;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#32218;&#36335;
    </p>
    <p>
      &#38263;&#26781;&#22294;&#21015;
    </p>
    <p>
      &#22577;&#21578;
    </p>
    <p>
      &#21312;&#22495;
    </p>
    <p>
      &#22534;&#30090;&#21312;&#22495;&#22294;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361169789768" MODIFIED="1361169790627" TEXT="&#x5373;&#x6642;&#x76e3;&#x770b;"/>
<node CREATED="1361169790930" MODIFIED="1361169824400" TEXT="&#x9577;&#x671f;&#x89c0;&#x5bdf;"/>
</node>
<node CREATED="1361169664428" MODIFIED="1363332322604" TEXT="SQL Trace &#x8207;SQL Server Profiler">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQL Profiler &#26159;&#22294;&#24418;&#21270;&#24037;&#20855;&#65292;&#20197;&#30435;&#25511;SQL Server &#30340;&#160;&#21508;&#31278;&#20107;&#20214;
    </p>
    <p>
      Find out what is occurring internally in SQL Server
    </p>
    <p>
      Output to a trace file
    </p>
    <p>
      Profiler can correlate a trace file and a Performance Monitor file by time
    </p>
    <p>
      http://msdn.microsoft.com/en-us/library/ms191152.aspx
    </p>
  </body>
</html></richcontent>
<node CREATED="1361170010481" MODIFIED="1361170012664" TEXT="SQL Trace &#x2013; Server-side"/>
<node CREATED="1361170013040" MODIFIED="1363333299528" TEXT="ad">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#30435;&#25511;SQL Server &#30340;&#21508;&#31278;&#27963;&#21205;&#65292;&#29986;&#29983;&#21508;&#31278;&#32000;&#37636;&#27284;&#20379;&#20107;&#24460; &#20998;&#26512;
    </p>
    <p>
      &#33287;Database Engine Tuning Advisor &#25645;&#37197;&#20351;&#29992;
    </p>
    <p>
      &#33287;Performance Monitor &#25972;&#21512;
    </p>
    <p>
      &#35386;&#26039;&#21839;&#38988;
    </p>
    <p>
      &#28858;&#25033;&#29992;&#31243;&#24335;&#38500;&#37679;
    </p>
    <p>
      &#37325;&#28436;&#19968;&#27425;&#65292;&#20197;&#27169;&#25836;&#25110;&#37325;&#26032;&#29986;&#29983;&#21839;&#38988;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1361169665622" MODIFIED="1361170503448" TEXT="Database Engine Tuning Advisor">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#24314;&#31435;&#19968;&#20491;&#26032;&#30340;&#36899;&#32218;
    </p>
    <p>
      &#25351;&#23450;&#38656;&#35201;&#20998;&#26512;&#30340;&#20358;&#28304;
    </p>
    <p>
      &#35373;&#23450;&#25928;&#33021;&#35519;&#25972;&#36984;&#38917;
    </p>
    <p>
      &#22519;&#34892;&#20998;&#26512;
    </p>
    <p>
      &#27298;&#35222;&#20998;&#26512;&#32080;&#26524;
    </p>
    <p>
      &#23526;&#34892;&#20998;&#26512;&#32080;&#26524;&#20043;&#24314;&#35696;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361169672701" MODIFIED="1379918094283" TEXT="Management Studio &#x6a19;&#x6e96;&#x5831;&#x8868;">
<node CREATED="1379915731274" MODIFIED="1379915733133" TEXT="Server">
<node CREATED="1379918106307" MODIFIED="1379918293620" TEXT="Server Dashboard  "/>
<node CREATED="1379918293621" MODIFIED="1379918301235" TEXT="Configuration Changes History "/>
<node CREATED="1379918301236" MODIFIED="1379918308198" TEXT="Schema Changes History "/>
<node CREATED="1379918308198" MODIFIED="1379918367686" TEXT="Scheduler Health "/>
<node CREATED="1379918367686" MODIFIED="1379918373973" TEXT="Memory Consumption "/>
<node CREATED="1379918373973" MODIFIED="1379918378964" TEXT="Activity &#x2013; All Blocking Transactions "/>
<node CREATED="1379918378964" MODIFIED="1379918383320" TEXT="Activity &#x2013; All Cursors "/>
<node CREATED="1379918383321" MODIFIED="1379918387573" TEXT="Activity &#x2013; Top Cursors "/>
<node CREATED="1379918387574" MODIFIED="1379918391923" TEXT="Activity &#x2013; All Sessions "/>
<node CREATED="1379918391923" MODIFIED="1379918396220" TEXT="Activity &#x2013; Top Sessions "/>
<node CREATED="1379918396220" MODIFIED="1379918400705" TEXT="Activity &#x2013; Dominant Sessions "/>
<node CREATED="1379918400706" MODIFIED="1379918419952" TEXT="Activity &#x2013; Top Connections "/>
<node CREATED="1379918419953" MODIFIED="1379918427391" TEXT="Top Transactions by Age "/>
<node CREATED="1379918427392" MODIFIED="1379918431516" TEXT="Top Transactions by Blocked Transactions Count "/>
<node CREATED="1379918431516" MODIFIED="1379918444803" TEXT="Top Transactions by Locks Count "/>
<node CREATED="1379918444803" MODIFIED="1379918459953" TEXT="Performance &#x2013; Batch Execution Statistics "/>
<node CREATED="1379918459953" MODIFIED="1379918464747" TEXT="Performance &#x2013; Object Execution Statistics "/>
<node CREATED="1379918464747" MODIFIED="1379918471307" TEXT="Performance &#x2013; Top Queries by Average CPU Time "/>
<node CREATED="1379918471308" MODIFIED="1379918476501" TEXT="Performance &#x2013; Top Queries by Average IO "/>
<node CREATED="1379918476502" MODIFIED="1379918481717" TEXT="Performance &#x2013; Top Queries by Total CPU Time "/>
<node CREATED="1379918481717" MODIFIED="1379918494807">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Performance &#8211; Top Queries by Total IO
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379918494809" MODIFIED="1379918505725">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Server Broker Statistics
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379918505727" MODIFIED="1379918505731">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Transaction Log Shipping Status
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1379915733610" MODIFIED="1379915735753" TEXT="Databases">
<node CREATED="1379918115786" MODIFIED="1379918117464" TEXT="Disk Usage Disk Usage by Top Tables Disk Usage by Table Disk Usage by Partition Backup and Restore Events All Transactions All Blocking Transactions Top Transactions by Age Top Transactions by Blocked Transactions Count Top Transactions by Locks Count Resource Locking Statistics by Objects Object Execution Statistics Database Consistency History Index Usage Statistics Index Physical Statistics Schema Changes History User Statistics"/>
</node>
<node CREATED="1379915736646" MODIFIED="1379915747119" TEXT="Logins">
<node CREATED="1379918125036" MODIFIED="1379918126395" TEXT="Login Statistics Login Failures Resource Locking Statistics by Logins"/>
</node>
<node CREATED="1379915747819" MODIFIED="1379915754494" TEXT="SQL server agent">
<node CREATED="1379918164618" MODIFIED="1379918195525">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Job Steps Execution History
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379918186973" MODIFIED="1379918201860">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Top Jobs
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1379915757607" MODIFIED="1379915764988" TEXT="Manageement">
<node CREATED="1379918136043" MODIFIED="1379918145845">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Tasks
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1379918145847" MODIFIED="1379918145851">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Number of Errors
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1379915738566" MODIFIED="1379915781151" TEXT="Notification Services">
<node CREATED="1379918155467" MODIFIED="1379918158077" TEXT="General"/>
</node>
</node>
<node CREATED="1361169679387" MODIFIED="1361169684915" TEXT="Performance Dashboard Reports"/>
<node CREATED="1361169685137" FOLDED="true" MODIFIED="1363146476289" TEXT="&#x8cc7;&#x6599;&#x6536;&#x96c6;&#x5668;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      1.&#19968;&#32068;&#36981;&#24490;Reporting Services &#23450;&#32681;&#30340;&#23458;&#35069;&#21270;&#22577;&#34920;
    </p>
    <p>
      2.&#25972;&#21512;SQL Server Management Studio
    </p>
    <p>
      3.Report Viewer &#25511;&#21046;&#38917;
    </p>
    <p>
      4.&#37341;&#23565;SQL Server 2005 SP2 &#20043;&#24460;&#30340;&#25928;&#33021;&#30435;&#25511;
    </p>
    <p>
      5.&#34249;&#30001;&#23384;&#21462;SQL Server 2005 &#25152;&#25552;&#20379;&#30340;&#31995;&#32113;&#29289;&#20214;&#65292;&#21576;&#29694;SQL Server 2005 &#22519;&#34892;&#20491;&#39636;&#30070;&#19979;&#36939;&#20316;&#30340;&#24773;&#24418;&#65292;&#34249;&#20197;&#20998;&#26512;&#25928;&#33021;&#21839;&#38988;
    </p>
  </body>
</html></richcontent>
<node CREATED="1361169840813" MODIFIED="1361169841784" TEXT="&#x6392;&#x7a0b;"/>
<node CREATED="1361169847993" MODIFIED="1361169848796" TEXT="&#x505c;&#x6b62;&#x689d;&#x4ef6;"/>
<node CREATED="1361169849235" MODIFIED="1361169854618" TEXT="&#x5de5;&#x4f5c;"/>
<node CREATED="1361169854864" MODIFIED="1363067512536" TEXT="&#x8cc7;&#x6599;&#x6536;&#x96c6;&#x5668;">
<node CREATED="1361169866253" MODIFIED="1361169867785" TEXT="&#x6548;&#x80fd;&#x8a08;&#x6578;&#x5668;&#x8cc7;&#x6599;&#x6536;&#x96c6;&#x5668;"/>
<node CREATED="1361169868464" MODIFIED="1361169874296" TEXT="&#x4e8b;&#x4ef6;&#x8ffd;&#x8e64;&#x8cc7;&#x6599;&#x6536;&#x96c6;&#x5668;"/>
<node CREATED="1361169874511" MODIFIED="1361169880109" TEXT="&#x7d44;&#x614b;&#x8cc7;&#x6599;&#x6536;&#x96c6;&#x5668;"/>
<node CREATED="1361169880331" MODIFIED="1361169886347" TEXT="&#x6548;&#x80fd;&#x8a08;&#x6578;&#x5668;&#x8b66;&#x8a0a;"/>
</node>
</node>
<node CREATED="1361169690622" MODIFIED="1361169695992" TEXT="&#x67e5;&#x8a62;&#x57f7;&#x884c;&#x8a08;&#x756b;"/>
<node CREATED="1363146479681" FOLDED="true" MODIFIED="1378279891878" TEXT="&#x58d3;&#x529b;&#x6e2c;&#x8a66;&#x5de5;&#x5177;&#x7a0b;&#x5f0f; ">
<node CREATED="1363146484051" MODIFIED="1363146503100">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Microsoft Application Center Test&#160;&#160;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363146503103" MODIFIED="1363146509158">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Microsoft Web Application Stress Tool&#160;&#160;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363146509165" MODIFIED="1363146514540">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      LoadSim.exe
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363146514544" MODIFIED="1363146514545">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#33258;&#34892;&#25776;&#23531;&#28204;&#35430;&#31243;&#24335;&#160;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1363158517043" MODIFIED="1363158519327" TEXT="Distributed Replay Utility"/>
<node CREATED="1363158542121" MODIFIED="1363158551988" TEXT="Database Console Commands (DBCC)"/>
<node CREATED="1363158553686" FOLDED="true" MODIFIED="1378272817951" TEXT="DMV Dynamic Management View">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#160;dm &#38283;&#38957; for select wait_type , wait_time_me from sys.dm_os_wait_stats
    </p>
    <p>
      Dynamic management Function&#160;&#160;vs Dynamic management View
    </p>
    <p>
      &#160;
    </p>
  </body>
</html></richcontent>
<node CREATED="1376876645543" MODIFIED="1376877025768" TEXT="&#x7cfb;&#x7d71;&#x4e2d;&#x7e7c;&#x8cc7;&#x6599;"/>
<node CREATED="1376877026520" MODIFIED="1376877051659" TEXT="&#x52d5;&#x614b;&#x7ba1;&#x7406;&#x6aa2;&#x8996;"/>
<node CREATED="1376877399756" MODIFIED="1376877427908" TEXT="&#x52d5;&#x614b;&#x7ba1;&#x7406;&#x51fd;&#x6578;"/>
<node CREATED="1377479647112" MODIFIED="1377480386602" TEXT="catalog  total:21">
<node CREATED="1377479658194" MODIFIED="1377479821541" TEXT="AlwaysOn Availability Group ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      AlwaysOn &#21487;&#29992;&#24615;&#32676;&#32068;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;&#21644;&#20989;&#25976;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479669893" MODIFIED="1377479833789" TEXT="Change Data Capture ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#30064;&#21205;&#36039;&#26009;&#25847;&#21462;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479706499" MODIFIED="1377479840163" TEXT="Change Tracking">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#35722;&#26356;&#36861;&#36452;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479764533" MODIFIED="1377479851395" TEXT="Common Language Runtime">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Common Language Runtime &#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479782587" MODIFIED="1377479855760" TEXT="Database Mirroring">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36039;&#26009;&#24235;&#37857;&#20687;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479870625" MODIFIED="1377480395715" TEXT="Database">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36039;&#26009;&#24235;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479883433" MODIFIED="1377480399541" TEXT="Execution">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#22519;&#34892;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;&#21644;&#20989;&#25976;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479907363" MODIFIED="1377480405232" TEXT="Extended Events">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#25844;&#20805;&#30340;&#20107;&#20214;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479945661" MODIFIED="1377480410693" TEXT="Filestream and FileTable ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Filestream &#21450; FileTable &#21205;&#24907;&#31649;&#29702;&#27298;&#35222; (Transact-SQL)
    </p>
    <p>
      Filestream and FileTable Dynamic Management Views (Transact-SQL)
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479973622" MODIFIED="1377480416487" TEXT="Full-Text Search and Semantic Search ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#20840;&#25991;&#27298;&#32034;&#25628;&#23563;&#21644;&#35486;&#24847;&#25628;&#23563;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      Full-Text Search and Semantic Search Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377479998736" MODIFIED="1377481166637" TEXT="I/O">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      I/O &#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;&#21644;&#20989;&#25976;
    </p>
    <p>
      I/O Related Dynamic Management Views and Functions
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480028686" MODIFIED="1377481170994" TEXT="Index">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#32034;&#24341;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;&#21644;&#20989;&#25976;
    </p>
    <p>
      Index Related Dynamic Management Views and Functions
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480052675" MODIFIED="1377481175411" TEXT="Object ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#29289;&#20214;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;&#21644;&#20989;&#25976;
    </p>
    <p>
      Object Related Dynamic Management Views and Functions
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480081269" MODIFIED="1377481179460" TEXT="Query ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#26597;&#35426;&#36890;&#30693;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      Query Notifications Related Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480130307" MODIFIED="1377481186400" TEXT="Replication">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#35079;&#23531;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      Replication Related Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480157587" MODIFIED="1377481191573" TEXT="Resource Governor ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36039;&#28304;&#31649;&#29702;&#21729;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      Resource Governor Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480182164" MODIFIED="1377481195510" TEXT="SQL Server Operating System ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQL Server &#20316;&#26989;&#31995;&#32113;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      SQL Server Operating System Related Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480229318" MODIFIED="1377481200096" TEXT="Security ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#23433;&#20840;&#24615;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      Security Related Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480253039" MODIFIED="1377481207704" TEXT="Service Broker ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Service Broker &#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;
    </p>
    <p>
      Service Broker Related Dynamic Management Views
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1377480350498" MODIFIED="1377481213025" TEXT="Transaction">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#20132;&#26131;&#30456;&#38364;&#30340;&#21205;&#24907;&#31649;&#29702;&#27298;&#35222;&#21644;&#20989;&#25976;
    </p>
    <p>
      Transaction Related Dynamic Management Views and Functions
    </p>
  </body>
</html></richcontent>
</node>
</node>
</node>
<node CREATED="1363158571530" MODIFIED="1363158578784" TEXT="&#x8ffd;&#x8e64;&#x65d7;&#x6a19;"/>
<node CREATED="1363332540303" FOLDED="true" MODIFIED="1363332709529" TEXT="SQLDiag/PSSDiag">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Collects a variety of diagnostic data
    </p>
    <p>
      
    </p>
    <p>
      http://msdn.microsoft.com/en-us/library/ms162833.aspx
    </p>
  </body>
</html></richcontent>
<node CREATED="1363332601576" MODIFIED="1363332611441" TEXT="Windows Performance Logs "/>
<node CREATED="1363332611442" MODIFIED="1363332618241">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Windows Event Logs
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363332618244" MODIFIED="1363332623915">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQL Traces
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363332623919" MODIFIED="1363332627675">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQL blocking info
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363332627680" MODIFIED="1363332627681">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQL Configuration info
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1363332557778" MODIFIED="1363332657805" TEXT="SQLNexus">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Analyzes SQLDiag/PSSDiag data
    </p>
    <p>
      http://sqlnexus.codeplex.com/
    </p>
    <p>
      
    </p>
    <p>
      Creates easy to interpret reports and graphs
    </p>
    <p>
      Finds most expensive queries in trace files
    </p>
    <p>
      Provides details on resource waits statistics
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363333377012" MODIFIED="1363333467843" TEXT="RML Utilities">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Diagnoses SQL Server Performance Data
    </p>
    <p>
      
    </p>
    <p>
      ReadTrace &#8211; consumes trace files
    </p>
    <p>
      Reporter &#8211; provides easy to understand reports on trace data consumed using Readtrace
    </p>
    <p>
      OStress &#8211; replays and stress tests queries
    </p>
    <p>
      ORCA &#8211; Ostress replay control agent
    </p>
    <p>
      
    </p>
    <p>
      http://blogs.msdn.com/b/psssql/archive/tags/rml+utilities/
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363333393846" MODIFIED="1363333403047" TEXT="PAL Tool"/>
<node CREATED="1378279901884" MODIFIED="1378279947678" TEXT="SQLIO">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQLIO Disk Subsystem Benchmark Tool
    </p>
    <p>
      <a href="http://www.microsoft.com/en-us/download/details.aspx?displaylang=en&amp;id=20163">http://www.microsoft.com/en-us/download/details.aspx?displaylang=en&amp;id=20163</a>
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378279947658" MODIFIED="1378279976034" TEXT="SQLIO Disk Subsystem Benchmark Tool"/>
<node CREATED="1378280625538" MODIFIED="1378280667104" TEXT="SQLIOSim">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      simulate SQL Server activity on a disk subsystem
    </p>
    <p>
      <a href="http://support.microsoft.com/kb/231619">http://support.microsoft.com/kb/231619</a>
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1361169595377" FOLDED="true" MODIFIED="1378281935648" POSITION="right" TEXT="method">
<node CREATED="1361168236447" FOLDED="true" MODIFIED="1363158182292" TEXT="&#x52a0;&#x901f;&#x8cc7;&#x6599;&#x5eab;&#x8655;&#x7406;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      database level
    </p>
  </body>
</html></richcontent>
<node CREATED="1361168581735" MODIFIED="1363146124913" TEXT="&#x8cc7;&#x6599;&#x8868;&#x8a2d;&#x8a08;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36039;&#26009;&#22411;&#24907;&#12289;&#27396;&#20301;&#25976;&#37327;&#12289;&#27491;&#35215;&#21270;&#31243;&#24230;
    </p>
    <p>
      &#8226;&#160;&#36039;&#26009;&#34920;&#35373;&#35336;
    </p>
    <p>
      &#8211;&#160;&#36039;&#26009;&#27396;&#20301;&#22411;&#24907;&#33287;&#38263;&#24230;&#35201;&#36969;&#20999;
    </p>
    <p>
      &#8211;&#160;&#20027;&#37749;&#65288;&#21474;&#38598;&#32034;&#24341;&#65289;&#33287;&#22806;&#37749;
    </p>
    <p>
      &#8211;&#160;&#27491;&#35215;&#21270;&#33287;&#36039;&#26009;&#34920;&#30340;&#20999;&#21106;&#21644;&#21512;&#20341;
    </p>
    <p>
      &#8226;&#160;&#36991;&#20813;&#21069;&#31471;&#31243;&#24335;&#30452;&#25509;&#23384;&#21462;&#22522;&#30990;&#36039;&#26009;&#34920;
    </p>
    <p>
      &#8211;&#160;&#20760;&#37327;&#36879;&#36942;&#38928;&#23384;&#31243;&#24207;&#12289;&#27298;&#35222;&#34920;&#20197;&#21450;&#20351;&#29992;&#32773;&#33258;&#35330;&#20989;&#25976;&#20358;&#23384;&#21462;&#36039;&#26009;&#65292;&#19981;&#35201;&#20197;&#31243;&#24335;&#30452;&#25509;&#23384;&#21462;&#36039;&#26009;&#34920;
    </p>
    <p>
      &#8226;&#160;&#25928;&#29575;&#36611;&#20339;&#65292;&#26356;&#26377;&#24392;&#24615;&#30340;&#23433;&#20840;&#35373;&#23450;&#65292;&#25552;&#20379;&#20462;&#25913;&#36039;&#26009;&#34920;&#26550;&#27083;&#160;&#30340;&#31354;&#38291;
    </p>
    <p>
      &#8226;&#160;&#20998;&#38283;&#32218;&#19978;&#20132;&#26131;&#33287;&#32218;&#19978;&#20998;&#26512;&#30340;&#23384;&#21462;
    </p>
    <p>
      80-20 &#23450;&#24459;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361168583882" MODIFIED="1363146658914" TEXT="&#x7d22;&#x5f15;&#x8a2d;&#x8a08;">
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#21892;&amp;#29992;&amp;#32034;&amp;#24341;&amp;#25552;&amp;#21319;&amp;#26597;&amp;#35426;&amp;#20043;&amp;#25928;&amp;#33021;&lt;b&gt;&lt;font size=&quot;40.0pt&quot; face=&quot;?L?n??????&quot; color=&quot;#FFFF99&quot;&gt;&lt;/span&gt;&lt;/font&gt;&lt;/b&gt;&lt;span&gt;&lt;b&gt;&lt;font size=&quot;40.0pt&quot; face=&quot;?L?n??????&quot; color=&quot;#FFFF99&quot;&gt;&lt;/span&gt;&lt;/font&gt;&lt;/b&gt;
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#160;&amp;#24314;&amp;#31435;&amp;#32034;&amp;#24341; 
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#160;&amp;#32173;&amp;#35703;&amp;#32034;&amp;#24341;
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#160;&amp;#35206;&amp;#33995;&amp;#32034;&amp;#24341;
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#160;&amp;#32034;&amp;#24341;&amp;#27298;&amp;#35222;
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#160;&amp;#22312;&amp;#35336;&amp;#31639;&amp;#27396;&amp;#20301;&amp;#19978;&amp;#24314;&amp;#31435;&amp;#32034;&amp;#24341;
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#160;&amp;#32113;&amp;#35336;
    &lt;/p&gt;
    &lt;p&gt;
      
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#21474;&amp;#38598;&amp;#32034;&amp;#24341;vs. &amp;#38750;&amp;#21474;&amp;#38598;&amp;#32034;&amp;#24341;

    &lt;/p&gt;
    &lt;p&gt;
      &amp;#35336;&amp;#31639;&amp;#22411;&amp;#27396;&amp;#20301;+&amp;#32034;&amp;#24341;
    &lt;/p&gt;
    &lt;p&gt;
      &amp;#32034;&amp;#24341;&amp;#27298;&amp;#35222;&amp;#34920;
    &lt;/p&gt;
    &lt;p&gt;
      XML&amp;#32034;&amp;#24341;&amp;#12289;&amp;#20840;&amp;#25991;&amp;#27298;&amp;#32034;
    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
<node CREATED="1361169461866" MODIFIED="1361169465934" TEXT="&#x58d3;&#x7e2e;&#x7d22;&#x5f15;"/>
<node COLOR="#338800" CREATED="1361169469809" MODIFIED="1361169482888" TEXT="&#x7be9;&#x9078;&#x7d22;&#x5f15;(Filtered indexes)"/>
</node>
<node CREATED="1361168593594" MODIFIED="1361168650797" TEXT="&#x8cc7;&#x6599;&#x5eab;&#x7269;&#x4ef6;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#38928;&#23384;&#31243;&#24207;&#12289;&#20351;&#29992;&#32773;&#33258;&#35330;
    </p>
    <p>
      &#20989;&#25976;&#12289;CLR&#32068;&#20214;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361169044752" MODIFIED="1361169047962" TEXT="&#x8cc7;&#x6599;&#x8868;&#x58d3;&#x7e2e;"/>
<node CREATED="1361169064750" MODIFIED="1361169066009" TEXT="&#x5099;&#x4efd;&#x58d3;&#x7e2e;"/>
<node CREATED="1363146760934" MODIFIED="1363155396077" TEXT="&#x9396;&#x5b9a; ">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      \\172.16.220.32\g$\microsoft\SQL\SQL&#25928;&#33021;&#35519;&#26657;\Microsoft SQL Server 2005 &#25928;&#33021;&#20877;&#36914;&#38542; (Performance Tuning) &#24375;&#25163;&#29151; Part 3.ppt
    </p>
    <p>
      &#33936;&#38598;&#31243;&#24207;(spid) &#30340;&#36039;&#35338;
    </p>
    <p>
      sp_who&#12289;sp_who2
    </p>
    <p>
      SELECT * FROM sys.sysprocesses
    </p>
    <p>
      
    </p>
    <p>
      &#33936;&#38598;&#37782;&#23450;&#30340;&#36039;&#35338;
    </p>
    <p>
      sp_lock&#12289;DBCC Page
    </p>
    <p>
      SELECT * FROM sys.dm_tran_locks
    </p>
    <p>
      
    </p>
    <p>
      &#33936;&#38598;SQL Profiler &#36861;&#36452;
    </p>
    <p>
      
    </p>
    <p>
      &#33936;&#38598;&#31995;&#32113;&#25928;&#33021;&#30435;&#25511;&#35352;&#37636;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#20351;&#29992;&#36861;&#36452;&#26071;&#27161;&#8211;&#38750;&#24517;&#35201;&#19981;&#35201;&#20351;&#29992;
    </p>
    <p>
      &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#22312;&#30456;&#21516;&#30340;&#26178;&#38291;&#20839;&#33936;&#38598;&#25152;&#26377;&#30340;&#36039;&#35338;&#65292;&#20197;&#20132;&#20114;&#21443;&#29031;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361169255888" MODIFIED="1363146754216" TEXT="&#x8a9e;&#x6cd5;">
<node CREATED="1361169083091" MODIFIED="1361169084319" TEXT="&#x4e00;&#x6b21;&#x53ef;&#x65b0;&#x589e;&#x591a;&#x7b46;&#x8cc7;&#x6599;"/>
<node CREATED="1361169084926" MODIFIED="1361169093157" TEXT="&#x5e38;&#x6578;&#x8cc7;&#x6599;&#x8868;"/>
<node CREATED="1361169565952" MODIFIED="1361169567701" TEXT="&#x8cc7;&#x6599;&#x8868;&#x503c;&#x53c3;&#x6578;"/>
</node>
</node>
<node CREATED="1361168286449" FOLDED="true" MODIFIED="1363158183385" TEXT="&#x589e;&#x52a0;&#x4f3a;&#x670d;&#x5668;&#x8655;&#x7406;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      instance level
    </p>
  </body>
</html></richcontent>
<node CREATED="1361168682816" MODIFIED="1363146331539" TEXT="&#x78c1;&#x789f;&#x898f;&#x5283;">
<node CREATED="1361168715591" MODIFIED="1361168717815" TEXT="&#x78c1;&#x789f;&#x9663;&#x5217;&#x6700;&#x4f73;&#x5316;">
<node CREATED="1361168785366" MODIFIED="1361168825408" TEXT="&#x8cc7;&#x6599;&#x5206;&#x5272;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36039;&#26009;&#34920;&#33287;&#32034;&#24341;&#30340;&#20998;&#21106;&#160;&#160;: &#20786;&#23384;&#33267;&#19981;&#21516;&#30340;&#27284;&#26696;&#32676;&#32068;
    </p>
    <p>
      &#21934;&#19968;&#36039;&#26009;&#34920;&#65295;&#32034;&#24341;&#21312;&#20998;&#25104;&#19981;&#21516;&#20786;&#23384;&#39636;
    </p>
    <p>
      &#20351;&#29992;Range &#20998;&#21106;&#25216;&#34899;&#36914;&#34892;&#36039;&#26009;&#20998;&#32068;
    </p>
    <p>
      &#27511;&#21490;&#36039;&#26009;&#33287;&#32218;&#19978;&#36039;&#26009;&#31649;&#29702;&#26356;&#23481;&#26131;
    </p>
    <p>
      &#25552;&#21319;&#36039;&#26009;&#24235;&#20633;&#20221;&#33287;&#36996;&#21407;&#30340;&#25928;&#29575;
    </p>
    <p>
      &#25552;&#21319;&#36039;&#26009;&#21034;&#38500;&#33287;&#22823;&#37327;&#36039;&#26009;&#36617;&#20837;&#30340;&#25928;&#29575;
    </p>
    <p>
      &#28187;&#23569;&#27511;&#21490;&#36039;&#26009;&#32034;&#24341;&#38626;&#25955;&#33287;&#37325;&#25972;&#30340;&#29376;&#27841;
    </p>
    <p>
      &#31777;&#21270;&#25033;&#29992;&#31243;&#24335;&#38283;&#30332;&#33287;&#36039;&#26009;&#24235;&#31649;&#29702;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1361168721091" MODIFIED="1361168898990" TEXT="Tempdb &#x4e4b;&#x898f;&#x5283;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Tempdb&#20043;&#29992;&#36884;
    </p>
    <p>
      &#26283;&#23384;&#36039;&#26009;&#34920;&#12289;&#23376;&#26597;&#35426;&#12289;HASH JOIN&#12289;ORDER BY&#12289;
    </p>
    <p>
      GROUP BY&#12289;SELECT DISTINCT&#12289;&#24555;&#29031;&#24335;&#20132;&#26131;&#38548;&#38626;&#31561;&#32026;&#12289;
    </p>
    <p>
      &#32218;&#19978;&#32034;&#24341;&#32173;&#35703;&#20316;&#26989;
    </p>
    <p>
      
    </p>
    <p>
      &#22823;&#37327;&#20351;&#29992;Tempdb &#26178;&#20043;&#35373;&#23450;
    </p>
    <p>
      &#30906;&#20445;Tempdb &#26377;&#36275;&#22816;&#30340;&#36039;&#26009;&#27284;&#22823;&#23567;
    </p>
    <p>
      &#23559;Tempdb &#30340;&#36039;&#26009;&#27284;&#25351;&#23450;&#33267;&#19981;&#21516;&#30340;&#30913;&#30879;&#32068;
    </p>
    <p>
      &#22914;&#26524;&#26159;SQL Server &#26377;&#22810;&#20491;CPU &#26178;&#65292;&#24314;&#35696;Tempdb &#30340;&#36039;
    </p>
    <p>
      &#26009;&#27284;&#20491;&#25976;&#33287;CPU &#26680;&#24515;&#25976;&#30456;&#21516;
    </p>
    <p>
      MS KB328551
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361168722453" MODIFIED="1363146373599" TEXT="&#x4ea4;&#x6613;&#x8a18;&#x9304;&#x6a94;&#x8207;&#x8cc7;&#x6599;&#x6a94;&#x5132;&#x5b58;&#x65bc;&#x4e0d;&#x540c;&#x78c1;&#x789f;&#x7d44;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#23559;&#32147;&#24120;&#35201;&#26597;&#35426;&#25110;&#26356;&#26032;&#30340;&#36039;&#26009;&#34920;&#65292;&#25351;&#23450;&#23384;&#25918;&#26044;&#19981;&#21516;&#30913;&#30879;&#32068;&#30340;&#27284;&#26696;&#32676;&#32068;
    </p>
    <p>
      &#23559;&#38750;&#21474;&#38598;&#32034;&#24341;&#65292;&#25351;&#23450;&#23384;&#25918;&#26044;&#19981;&#21516;&#30913;&#30879;&#32068;&#30340;&#27284;&#26696;&#32676;&#32068;
    </p>
    <p>
      &#23559;&#24120;&#29992;&#30340;&#29694;&#26377;&#36039;&#26009;&#33287;&#27511;&#21490;&#36039;&#26009;&#20998;&#21106;&#20786;&#23384;&#33267;&#19981;&#21516;&#30340;&#36039;&#26009;&#34920;&#65292;&#20006;&#25351;&#23450;&#23384;&#25918;&#26044;&#19981;&#21516;&#30913;&#30879;&#32068;&#30340;&#27284;&#26696;&#32676;&#32068;
    </p>
    <p>
      &#25110;&#32771;&#24942;&#25505;&#29992;&#20998;&#21106;&#36039;&#26009;&#34920;&#33287;&#36039;&#26009;&#22739;&#32302;
    </p>
    <p>
      &#36991;&#20813;&#36942;&#29105;&#25110;&#36942;&#22823;&#30340;&#36039;&#26009;&#34920;&#65292;&#21487;&#20197;&#32771;&#24942;&#20877;&#20999;&#21106;
    </p>
    <p>
      &#36879;&#36942;ISUD &#34920;&#20358;&#27298;&#39511;&#26159;&#21542;&#26377;&#36942;&#29105;&#36039;&#26009;&#34920;&#25110;&#27396;&#20301;
    </p>
    <p>
      &#36991;&#20813;&#36942;&#22810;&#30340;Join&#65292;&#32771;&#24942;&#21453;&#27491;&#35215;&#21123;
    </p>
    <p>
      &#22312;&#20462;&#25913;&#25110;&#21034;&#38500;&#29289;&#20214;&#26178;&#65292;&#36879;&#36942;VSTS DB Pro/Enterprise Manager/Management Studio &#25110; sp_depends &lt;&#29289;&#20214;&gt;&#160;&#27298;&#35222;&#26159;&#21542;&#26377;&#30456;&#38364;&#29289;&#20214;
    </p>
    <p>
      Scale Up / Scale Out
    </p>
    <p>
      &#22823;&#37327;&#12289;&#19981;&#24120;&#29992;&#30340;&#36039;&#26009;&#25918;&#22312;&#36895;&#24230;&#24930;&#30340;&#20786;&#23384;&#39636;&#19978;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361168728667" MODIFIED="1361168993707" TEXT="&#x591a;&#x500b;&#x6a94;&#x6848;&#x7fa4;&#x7d44;&#x642d;&#x914d;&#x591a;&#x500b;&#x8cc7;&#x6599;&#x6a94;&#x6848;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#22810;&#20491;&#36039;&#26009;&#27284;&#26696;&#24517;&#38920;&#24314;&#31435;&#28858;&#21516;&#27171;&#30340;&#21021;&#22987;&#22823;&#23567;&#65292;&#21516;&#27171;&#30340;&#25104;&#38263;&#22823;&#23567;&#65292;
    </p>
    <p>
      &#21542;&#21063;&#36039;&#26009;&#27284;&#26696;&#26371;&#20197;&#27284;&#26696;&#22823;&#23567;&#30340;&#27604;&#20363;&#23531;&#20837;&#65292;&#36896;&#25104;&#30913;&#30879;I/O &#19981;&#24179;&#22343;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361168734121" MODIFIED="1361168738803" TEXT="&#x5206;&#x5272;&#x8cc7;&#x6599;&#x8868;&#x3001;&#x5206;&#x5272;&#x7d22;&#x5f15;&#x3001;&#x8cc7;&#x6599;&#x8868;&#x58d3;&#x7e2e;"/>
</node>
<node CREATED="1361168693322" MODIFIED="1361168694286" TEXT="64&#x4f4d;&#x5143;&#x7cfb;&#x7d71;"/>
<node CREATED="1361168694621" MODIFIED="1361168700697" TEXT="&#x5145;&#x8db3;&#x7684;&#x8a18;&#x61b6;&#x9ad4;"/>
<node CREATED="1361169071762" MODIFIED="1361169215852" TEXT="&#x8cc7;&#x6e90;&#x7ba1;&#x7406;&#x54e1;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#20998;&#25955;&#21487;&#20381;&#26781;&#20214;&#21312;&#20998;&#24037;&#20316;&#36000;&#33655;( &#25033;&#29992;&#31243;&#24335;,&#30331;&#20837;&#24115;&#34399;,&#36039;&#26009;&#24235;)
    </p>
    <p>
      
    </p>
    <p>
      &#24037;&#20316;&#36000;&#33655;&#38480;&#21046;&#26781;&#20214;(&#35352;&#25014;&#39636;&#25480;&#33287;%,CPU &#26178;&#38291;,&#25480;&#33287;&#36926;&#26178;,&#26368;&#22823;&#35201;&#27714;&#25976;)
    </p>
    <p>
      
    </p>
    <p>
      
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1361169102042" FOLDED="true" MODIFIED="1363144761566" TEXT="&#x66f4;&#x512a;&#x8d8a;&#x7684;&#x5132;&#x5b58;&#x9ad4;&#x7d50;&#x69cb;">
<node CREATED="1361169409385" MODIFIED="1361169410748" TEXT="HierarchyID &#x8cc7;&#x6599;&#x985e;&#x578b;"/>
<node CREATED="1361169411082" MODIFIED="1361169419727" TEXT="&#x758f;&#x9b06;&#x8cc7;&#x6599;&#x884c;(Sparse Columns)"/>
<node CREATED="1361169419965" MODIFIED="1361169419965" TEXT=""/>
</node>
</node>
<node CREATED="1361168305332" FOLDED="true" MODIFIED="1363158185091" TEXT="&#x591a;&#x90e8;&#x4f3a;&#x670d;&#x5668;&#x67b6;&#x69cb;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      server&#160; level
    </p>
  </body>
</html></richcontent>
<node CREATED="1361168994609" MODIFIED="1361168995785" TEXT="&#x5206;&#x6563;&#x5f0f;&#x67e5;&#x8a62;"/>
<node CREATED="1361168996410" MODIFIED="1361169004783" TEXT="&#x5206;&#x5272;&#x6aa2;&#x8996;&#x8868;"/>
<node CREATED="1361169009734" MODIFIED="1361169010665" TEXT="&#x8907;&#x5beb;"/>
<node CREATED="1361169010992" MODIFIED="1361169016765" TEXT="&#x53ef;&#x64f4;&#x5145;&#x5171;&#x7528;&#x8cc7;&#x6599;&#x5eab;"/>
</node>
<node CREATED="1361168595524" MODIFIED="1363146698757" TEXT="&#x7a0b;&#x5f0f;&#x8a2d;&#x8a08;">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Application level
    </p>
    <p>
      
    </p>
    <p>
      &#36039;&#26009;&#25351;&#27161;vs. &#36039;&#26009;&#38598;
    </p>
    <p>
      TRUNCATE TABLE
    </p>
    <p>
      BULK INSERT
    </p>
    <p>
      &#26597;&#35426;&#35486;&#27861;&#12289;&#20132;&#26131;&#34389;&#29702;&#12289;
    </p>
    <p>
      MARS&#12289;&#38750;&#21516;&#27493;&#34389;&#29702;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1363158592978" FOLDED="true" MODIFIED="1378281957943" POSITION="right" TEXT="Step">
<node CREATED="1363158611925" MODIFIED="1376637429836">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#27770;&#23450;&#24744;&#30340;&#30435;&#35222;&#30446;&#27161;&#12290;
    </p>
  </body>
</html></richcontent>
<node CREATED="1363158686237" MODIFIED="1363158692976" TEXT="&#x5efa;&#x7acb;&#x6548;&#x80fd;&#x57fa;&#x6e96;&#x7dda;&#x3002; "/>
<node CREATED="1363158692978" MODIFIED="1363158698410" TEXT="&#x8b58;&#x5225;&#x6548;&#x80fd;&#x8b8a;&#x66f4;&#x8da8;&#x52e2;&#x3002; "/>
<node CREATED="1363158698410" MODIFIED="1363158701890" TEXT="&#x8a3a;&#x65b7;&#x7279;&#x5b9a;&#x6548;&#x80fd;&#x554f;&#x984c;&#x3002; "/>
<node CREATED="1363158701892" MODIFIED="1363158704955" TEXT="&#x8b58;&#x5225;&#x8981;&#x6700;&#x4f73;&#x5316;&#x7684;&#x5143;&#x4ef6;&#x6216;&#x8655;&#x7406;&#x5e8f;&#x3002; "/>
<node CREATED="1363158704957" MODIFIED="1363158708326" TEXT="&#x6bd4;&#x8f03;&#x4e0d;&#x540c;&#x7528;&#x6236;&#x7aef;&#x61c9;&#x7528;&#x7a0b;&#x5f0f;&#x5728;&#x6548;&#x80fd;&#x4e0a;&#x7684;&#x5f71;&#x97ff;&#x3002; "/>
<node CREATED="1363158708327" MODIFIED="1363158711662" TEXT="&#x7a3d;&#x6838;&#x4f7f;&#x7528;&#x8005;&#x6d3b;&#x52d5;&#x3002; "/>
<node CREATED="1363158711664" MODIFIED="1363158716166" TEXT="&#x4ee5;&#x4e0d;&#x540c;&#x7684;&#x8ca0;&#x8f09;&#x4f86;&#x6e2c;&#x8a66;&#x4f3a;&#x670d;&#x5668;&#x3002; "/>
<node CREATED="1363158716168" MODIFIED="1363158721205">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#28204;&#35430;&#36039;&#26009;&#24235;&#26550;&#27083;&#12290;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363158721211" MODIFIED="1363158724489">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#28204;&#35430;&#32173;&#35703;&#25490;&#31243;&#12290;&#160;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363158724494" MODIFIED="1363158727976">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#28204;&#35430;&#20633;&#20221;&#33287;&#36996;&#21407;&#35336;&#30059;&#12290;&#160;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363158727979" MODIFIED="1363158727980">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#27770;&#23450;&#20462;&#25913;&#30828;&#39636;&#32068;&#24907;&#30340;&#26178;&#38291;&#12290;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1363158626056" MODIFIED="1363158631910">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36984;&#21462;&#36969;&#30070;&#30340;&#24037;&#20855;&#12290;
    </p>
  </body>
</html></richcontent>
<node CREATED="1363158659031" MODIFIED="1363158659031" TEXT=""/>
</node>
<node CREATED="1363158631915" MODIFIED="1363158763669">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#160;&#35672;&#21029;&#35201;&#30435;&#35222;&#30340;&#20803;&#20214;&#12290;&#160;
    </p>
  </body>
</html></richcontent>
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#30435;&amp;#35222;SQL Server &amp;#22519;&amp;#34892;&amp;#20491;&amp;#39636;&amp;#30340;&amp;#31532;&amp;#19977;&amp;#20491;&amp;#27493;&amp;#39519;&amp;#26159;&amp;#35672;&amp;#21029;&amp;#24744;&amp;#30435;&amp;#35222;&amp;#30340;&amp;#20803;&amp;#20214;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;start&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt45&quot; data-source=&quot;&quot; align=&quot;start&quot; data-guid=&quot;cd76b21f29db1abf4a2118f4e1380f8a&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#20363;&amp;#22914;&amp;#65292;&amp;#22914;&amp;#26524;&amp;#20351;&amp;#29992; SQL Server Profiler 
      &amp;#20358;&amp;#36861;&amp;#36452;&amp;#20282;&amp;#26381;&amp;#22120;&amp;#65292;&amp;#24744;&amp;#21487;&amp;#20197;&amp;#23450;&amp;#32681;&amp;#36861;&amp;#36452;&amp;#20358;&amp;#25910;&amp;#38598;&amp;#29305;&amp;#23450;&amp;#20107;&amp;#20214;&amp;#30340;&amp;#36039;&amp;#26009;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;start&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt46&quot; data-source=&quot;&quot; align=&quot;start&quot; data-guid=&quot;e517a1a1d19529633caf818a918c1b6a&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#24744;&amp;#20063;&amp;#21487;&amp;#20197;&amp;#25490;&amp;#38500;&amp;#19981;&amp;#31526;&amp;#21512;&amp;#24773;&amp;#27841;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;

    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158635377" MODIFIED="1363158782586">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#36984;&#21462;&#36889;&#20123;&#20803;&#20214;&#30340;&#27161;&#28310;&#12290;&#160;
    </p>
  </body>
</html></richcontent>
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#35672;&amp;#21029;&amp;#35201;&amp;#30435;&amp;#35222;&amp;#30340;&amp;#20803;&amp;#20214;&amp;#20043;&amp;#24460;&amp;#65292;&amp;#35531;&amp;#27770;&amp;#23450;&amp;#24744;&amp;#30435;&amp;#35222;&amp;#30340;&amp;#20803;&amp;#20214;&amp;#27161;&amp;#28310;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;start&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt48&quot; data-source=&quot;&quot; align=&quot;start&quot; data-guid=&quot;da8aa48220c6e47952241698509cd4d0&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#20363;&amp;#22914;&amp;#65292;&amp;#36984;&amp;#21462;&amp;#35201;&amp;#32013;&amp;#20837;&amp;#36861;&amp;#36452;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#20043;&amp;#24460;&amp;#65292;&amp;#24744;&amp;#21487;&amp;#20197;&amp;#36984;&amp;#25799;&amp;#21482;&amp;#21253;&amp;#21547;&amp;#20107;&amp;#20214;&amp;#30340;&amp;#29305;&amp;#23450;&amp;#36039;&amp;#26009;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;start&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt49&quot; data-source=&quot;&quot; align=&quot;start&quot; data-guid=&quot;afaef7374fc8d86a3013abd6a99b431a&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#23559;&amp;#36861;&amp;#36452;&amp;#38480;&amp;#21046;&amp;#22312;&amp;#33287;&amp;#36861;&amp;#36452;&amp;#30456;&amp;#38364;&amp;#30340;&amp;#36039;&amp;#26009;&amp;#19978;&amp;#65292;&amp;#21487;&amp;#20197;&amp;#23559;&amp;#22519;&amp;#34892;&amp;#36861;&amp;#36452;&amp;#25152;&amp;#38656;&amp;#30340;&amp;#31995;&amp;#32113;&amp;#36039;&amp;#28304;&amp;#28187;&amp;#21040;&amp;#26368;&amp;#23567;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;

    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158639201" MODIFIED="1363158816194">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#30435;&#35222;&#20282;&#26381;&#22120;&#12290;&#160;
    </p>
  </body>
</html></richcontent>
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#33509;&amp;#35201;&amp;#30435;&amp;#35222;&amp;#20282;&amp;#26381;&amp;#22120;&amp;#65292;&amp;#35531;&amp;#22519;&amp;#34892;&amp;#24744;&amp;#24050;&amp;#35373;&amp;#23450;&amp;#20358;&amp;#33936;&amp;#38598;&amp;#36039;&amp;#26009;&amp;#30340;&amp;#30435;&amp;#35222;&amp;#24037;&amp;#20855;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;start&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt51&quot; data-source=&quot;&quot; align=&quot;start&quot; data-guid=&quot;48476bc7d8333a915889b7284f5c9241&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#20363;&amp;#22914;&amp;#65292;&amp;#23450;&amp;#32681;&amp;#36861;&amp;#36452;&amp;#20043;&amp;#24460;&amp;#65292;&amp;#24744;&amp;#21487;&amp;#20197;&amp;#22519;&amp;#34892;&amp;#36861;&amp;#36452;&amp;#20358;&amp;#33936;&amp;#38598;&amp;#20282;&amp;#26381;&amp;#22120;&amp;#20013;&amp;#25152;&amp;#24341;&amp;#30332;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#20043;&amp;#30456;&amp;#38364;&amp;#36039;&amp;#26009;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;

    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158642606" MODIFIED="1376637430925">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#20998;&#26512;&#36039;&#26009;&#12290;
    </p>
  </body>
</html></richcontent>
<node CREATED="1363158879408" MODIFIED="1363158963335" TEXT="&#x5957;&#x7528;&#x7be9;&#x9078;&#x4f86;&#x9650;&#x5236;&#x8981;&#x6536;&#x96c6;&#x7684;&#x4e8b;&#x4ef6;&#x8cc7;&#x6599;&#x3002; ">
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#38480;&amp;#21046;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#21487;&amp;#35731;&amp;#31995;&amp;#32113;&amp;#25226;&amp;#28966;&amp;#40670;&amp;#25918;&amp;#22312;&amp;#30435;&amp;#35222;&amp;#26696;&amp;#20363;&amp;#30456;&amp;#38364;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#19978;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;left&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt57&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;4d6e84c0f83b361335aada65adec326d&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#20363;&amp;#22914;&amp;#65292;&amp;#33509;&amp;#24744;&amp;#35201;&amp;#30435;&amp;#35222;&amp;#24930;&amp;#36895;&amp;#26597;&amp;#35426;&amp;#65292;&amp;#21487;&amp;#20197;&amp;#20351;&amp;#29992;&amp;#31721;&amp;#36984;&amp;#20358;&amp;#38480;&amp;#21046;&amp;#21482;&amp;#30435;&amp;#35222;&amp;#25033;&amp;#29992;&amp;#31243;&amp;#24335;&amp;#23565;&amp;#29305;&amp;#23450;&amp;#36039;&amp;#26009;&amp;#24235;&amp;#22519;&amp;#34892;&amp;#36229;&amp;#36942;&amp;#19977;&amp;#21313;&amp;#31186;&amp;#20197;&amp;#19978;&amp;#30340;&amp;#26597;&amp;#35426;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt58&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;acaf02bf57bfd8ee699709003c30c97f&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#22914;&amp;#38656;&amp;#35443;&amp;#32048;&amp;#36039;&amp;#35338;&amp;#65292;&amp;#35531;&amp;#21443;&amp;#38321;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms188627.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;
&amp;#35373;&amp;#23450;&amp;#36861;&amp;#36452;&amp;#31721;&amp;#36984;(Transact-SQL)&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;&amp;#65310;&amp;#21644;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms175520.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;
&amp;#31721;&amp;#36984;&amp;#36861;&amp;#36452;&amp;#20013;&amp;#30340;&amp;#20107;&amp;#20214; (SQL Server Profiler)&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;
&amp;#160;&amp;#65310;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;
    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158885306" MODIFIED="1363158966028" TEXT="&#x76e3;&#x8996; (&#x64f7;&#x53d6;) &#x4e8b;&#x4ef6;&#x3002; ">
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#19968;&amp;#26086;&amp;#21855;&amp;#29992;&amp;#24460;&amp;#65292;&amp;#20351;&amp;#29992;&amp;#20013;&amp;#30340;&amp;#30435;&amp;#35222;&amp;#26371;&amp;#24478;&amp;#25351;&amp;#23450;&amp;#30340;&amp;#25033;&amp;#29992;&amp;#31243;&amp;#24335;&amp;#12289;SQL Server &amp;#22519;&amp;#34892;&amp;#20491;&amp;#39636;&amp;#25110;&amp;#20316;&amp;#26989;&amp;#31995;&amp;#32113;&amp;#20013;&amp;#25847;&amp;#21462;&amp;#36039;&amp;#26009;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;left&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt61&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;d98ad860e5aa7f129a43c65c4203eb7f&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;
      &amp;#20363;&amp;#22914;&amp;#65292;&amp;#20351;&amp;#29992;&amp;#12300;&amp;#31995;&amp;#32113;&amp;#30435;&amp;#35222;&amp;#22120;&amp;#12301;&amp;#30435;&amp;#35222;&amp;#30913;&amp;#30879;&amp;#27963;&amp;#21205;&amp;#26178;&amp;#65292;&amp;#30435;&amp;#35222;&amp;#26371;&amp;#25847;&amp;#21462;&amp;#30913;&amp;#30879;&amp;#35712;&amp;#23531;&amp;#21205;&amp;#20316;&amp;#31561;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#65292;&amp;#20006;&amp;#39023;&amp;#31034;&amp;#22312;&amp;#34722;&amp;#24149;&amp;#19978;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt62&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;0ba7879705aca75baf0d4b0c599c4aee&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#22914;&amp;#38656;&amp;#35443;&amp;#32048;&amp;#36039;&amp;#35338;&amp;#65292;&amp;#35531;&amp;#21443;&amp;#38321;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms191246.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;
&amp;#30435;&amp;#35222;&amp;#36039;&amp;#28304;&amp;#20351;&amp;#29992;&amp;#29376;&amp;#27841; (&amp;#31995;&amp;#32113;&amp;#30435;&amp;#35222;&amp;#22120;)&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;
&amp;#160;&amp;#65310;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;
    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158889489" MODIFIED="1363158985278" TEXT="&#x5132;&#x5b58;&#x64f7;&#x53d6;&#x7684;&#x4e8b;&#x4ef6;&#x8cc7;&#x6599;&#x3002; ">
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#20786;&amp;#23384;&amp;#25847;&amp;#21462;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#21487;&amp;#35731;&amp;#24744;&amp;#31245;&amp;#24460;&amp;#20998;&amp;#26512;&amp;#65292;&amp;#25110;&amp;#29978;&amp;#33267;&amp;#20351;&amp;#29992;Distributed Replay Utility &amp;#25110; SQL Server Profiler 
      &amp;#20358;&amp;#37325;&amp;#26032;&amp;#22519;&amp;#34892;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;left&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt65&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;2c5776862b711dc2744940a16d6077fc&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;
&amp;#160;&amp;#24744;&amp;#21487;&amp;#23559;&amp;#25847;&amp;#21462;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#20786;&amp;#23384;&amp;#21040;&amp;#27284;&amp;#26696;&amp;#65292;&amp;#32780;&amp;#27284;&amp;#26696;&amp;#21487;&amp;#20197;&amp;#37325;&amp;#26032;&amp;#36617;&amp;#20837;&amp;#21040;&amp;#21407;&amp;#20808;&amp;#24314;&amp;#31435;&amp;#35442;&amp;#27284;&amp;#26696;&amp;#30340;&amp;#24037;&amp;#20855;&amp;#20013;&amp;#65292;&amp;#20197;&amp;#36914;&amp;#34892;&amp;#20998;&amp;#26512;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt66&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;8bbf4e61099c0c8c0d303775ffacf500&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;SQL Server Profiler &amp;#20801;&amp;#35377;&amp;#23559;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#20786;&amp;#23384;&amp;#21040; SQL Server 
      &amp;#36039;&amp;#26009;&amp;#34920;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt67&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;5b7d29296b3c287d25519ad2c584d4f3&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;
&amp;#22312;&amp;#24314;&amp;#31435;&amp;#25928;&amp;#33021;&amp;#22522;&amp;#28310;&amp;#26178;&amp;#65292;&amp;#20786;&amp;#23384;&amp;#25847;&amp;#21462;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#23601;&amp;#24456;&amp;#37325;&amp;#35201;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt68&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;0edc9dac1214bcc7ec9fe1e46407e670&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#25928;&amp;#33021;&amp;#22522;&amp;#28310;&amp;#36039;&amp;#26009;&amp;#26371;&amp;#20786;&amp;#23384;&amp;#36215;&amp;#20358;&amp;#65292;&amp;#20006;&amp;#22312;&amp;#27604;&amp;#36611;&amp;#26368;&amp;#36817;&amp;#25847;&amp;#21462;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#26178;&amp;#20351;&amp;#29992;&amp;#65292;&amp;#20197;&amp;#21028;&amp;#26039;&amp;#25928;&amp;#33021;&amp;#26159;&amp;#21542;&amp;#28858;&amp;#26368;&amp;#20339;&amp;#21270;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt69&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;b10e019f15941f96ceb2d0f4aaedd777&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#22914;&amp;#38656;&amp;#35443;&amp;#32048;&amp;#36039;&amp;#35338;&amp;#65292;&amp;#35531;&amp;#21443;&amp;#38321;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms187929.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;
SQL Server Profiler &amp;#31684;&amp;#26412;&amp;#21644;&amp;#27402;&amp;#38480;&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;&amp;#65310;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;

    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158892819" MODIFIED="1363158995975">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#24314;&#31435;&#21253;&#21547;&#25351;&#23450;&#35373;&#23450;&#30340;&#36861;&#36452;&#31684;&#26412;&#20358;&#25847;&#21462;&#20107;&#20214;&#12290;
    </p>
  </body>
</html></richcontent>
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#36861;&amp;#36452;&amp;#31684;&amp;#26412;&amp;#20013;&amp;#21253;&amp;#21547;&amp;#20107;&amp;#20214;&amp;#26412;&amp;#36523;&amp;#12289;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#21644;&amp;#29992;&amp;#20358;&amp;#25847;&amp;#21462;&amp;#36039;&amp;#26009;&amp;#30340;&amp;#31721;&amp;#36984;&amp;#31561;&amp;#30456;&amp;#38364;&amp;#35215;&amp;#26684;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;left&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt72&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;d91aadf489d54bcef4f1cbf2d1695526&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#36889;&amp;#20123;&amp;#31684;&amp;#26412;&amp;#31245;&amp;#24460;&amp;#21487;&amp;#20197;&amp;#29992;&amp;#20358;&amp;#30435;&amp;#35222;&amp;#29305;&amp;#23450;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#32068;&amp;#21512;&amp;#65292;&amp;#32780;&amp;#19981;&amp;#38656;&amp;#37325;&amp;#26032;&amp;#23450;&amp;#32681;&amp;#20107;&amp;#20214;&amp;#12289;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#33287;&amp;#31721;&amp;#36984;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt73&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;09e007bb291dad25a8fb6d8db96726b3&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;
      &amp;#20363;&amp;#22914;&amp;#65292;&amp;#22914;&amp;#26524;&amp;#24744;&amp;#35201;&amp;#26178;&amp;#24120;&amp;#30435;&amp;#35222;&amp;#27515;&amp;#32080;&amp;#30340;&amp;#25976;&amp;#30446;&amp;#33287;&amp;#38519;&amp;#20837;&amp;#27515;&amp;#32080;&amp;#30340;&amp;#20351;&amp;#29992;&amp;#32773;&amp;#25976;&amp;#30446;&amp;#65292;&amp;#24744;&amp;#21487;&amp;#20197;&amp;#24314;&amp;#31435;&amp;#19968;&amp;#20491;&amp;#23450;&amp;#32681;&amp;#36889;&amp;#20123;&amp;#20107;&amp;#20214;&amp;#12289;&amp;#20107;&amp;#20214;&amp;#36039;&amp;#26009;&amp;#33287;&amp;#20107;&amp;#20214;&amp;#31721;&amp;#36984;&amp;#30340;&amp;#31684;&amp;#26412;&amp;#12289;&amp;#20786;&amp;#23384;&amp;#31684;&amp;#26412;&amp;#65292;&amp;#28982;&amp;#24460;&amp;#22312;&amp;#19979;&amp;#27425;&amp;#35201;&amp;#30435;&amp;#35222;&amp;#27515;&amp;#32080;&amp;#26178;&amp;#37325;&amp;#26032;&amp;#22871;&amp;#29992;&amp;#27492;&amp;#31721;&amp;#36984;&amp;#12290;
&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt74&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;e34cc545502672366e8b05feddad46c4&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;SQL Server Profiler &amp;#26371;&amp;#37341;&amp;#23565;&amp;#36889;&amp;#20491;&amp;#30446;&amp;#30340;&amp;#20351;&amp;#29992;&amp;#36861;&amp;#36452;&amp;#31684;&amp;#26412;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt75&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;cc0ee31fa858960f0f35fecd237d7ffe&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#22914;&amp;#38656;&amp;#35443;&amp;#32048;&amp;#36039;&amp;#35338;&amp;#65292;&amp;#35531;&amp;#21443;&amp;#38321;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms190177.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;
&amp;#35373;&amp;#23450;&amp;#36861;&amp;#36452;&amp;#23450;&amp;#32681;&amp;#38928;&amp;#35373;&amp;#20540; (SQL Server Profiler)&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;
&amp;#160;&amp;#65310;&amp;#21644;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms175070.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;&amp;#24314;&amp;#31435;&amp;#36861;&amp;#36452;&amp;#31684;&amp;#26412; (SQL Server Profiler)&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;
&amp;#160;&amp;#65310;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;
    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
<node CREATED="1363158898579" MODIFIED="1363159020358">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#20998;&#26512;&#25847;&#21462;&#30340;&#20107;&#20214;&#36039;&#26009;&#12290;&#160;
    </p>
  </body>
</html></richcontent>
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#28858;&#20102;&#36914;&#34892;&#20998;&#26512;&#65292;&#25847;&#21462;&#30340;&#20107;&#20214;&#36039;&#26009;&#26371;&#36617;&#20837;&#25847;&#21462;&#36039;&#26009;&#30340;&#25033;&#29992;&#31243;&#24335;&#20013;&#12290;&#20363;&#22914;&#65292;&#24478;SQL Server Profiler &#25847;&#21462;&#30340;&#36861;&#32305;&#21487;&#20197;&#37325;&#26032;&#36617;&#20837; SQL Server Profiler &#20013;&#65292;&#20197;&#20379;&#27298;&#35222;&#33287;&#20998;&#26512;&#12290; &#22914;&#38656;&#35443;&#32048;&#36039;&#35338;&#65292;&#35531;&#21443;&#38321;&#65308;&#20351;&#29992; SQL Server Profiler &#27298;&#35222;&#21644;&#20998;&#26512;&#36861;&#36452;&#65310;&#12290;
    </p>
    <p>
      &#20998;&#26512;&#20107;&#20214;&#36039;&#26009;&#28041;&#21450;&#21028;&#26039;&#30332;&#29983;&#20309;&#20107;&#33287;&#30332;&#29983;&#30340;&#21407;&#22240;&#12290;&#36889;&#38917;&#36039;&#35338;&#21487;&#35731;&#24744;&#21033;&#29992;Transact-SQL &#38515;&#36848;&#24335;&#25110;&#38928;&#23384;&#31243;&#24207;&#31561; (&#35222;&#22519;&#34892;&#30340;&#20998;&#26512;&#39006;&#22411;&#32780;&#23450;)&#65292;&#22519;&#34892;&#35722;&#26356;&#20197;&#25913;&#21892;&#25928;&#33021;&#65292;&#20363;&#22914;&#22686;&#21152;&#26356;&#22810;&#35352;&#25014;&#39636;&#12289;&#35722;&#26356;&#32034;&#24341;&#12289;&#20462;&#27491;&#31243;&#24335;&#30908;&#21839;&#38988;&#12290; &#20363;&#22914;&#65292;&#24744;&#21487;&#20197;&#20351;&#29992; Database Engine Tuning Advisor &#20358;&#20998;&#26512;&#24478; SQL Server Profiler &#25847;&#21462;&#30340;&#36861;&#36452;&#65292;&#20006;&#26681;&#25818;&#32080;&#26524;&#25552;&#20379;&#32034;&#24341;&#24314;&#35696;&#12290;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1363158902354" MODIFIED="1363159027003">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#37325;&#26032;&#22519;&#34892;&#25847;&#21462;&#30340;&#20107;&#20214;&#36039;&#26009;&#12290;
    </p>
  </body>
</html></richcontent>
<richcontent TYPE="NOTE">&lt;html&gt;
  &lt;head&gt;
    
  &lt;/head&gt;
  &lt;body&gt;
    &lt;p&gt;
      &amp;#20107;&amp;#20214;&amp;#37325;&amp;#26032;&amp;#22519;&amp;#34892;&amp;#21487;&amp;#35731;&amp;#24744;&amp;#20223;&amp;#36896;&amp;#21407;&amp;#20808;&amp;#25847;&amp;#21462;&amp;#36039;&amp;#26009;&amp;#30340;&amp;#36039;&amp;#26009;&amp;#24235;&amp;#29872;&amp;#22659;&amp;#20358;&amp;#24314;&amp;#31435;&amp;#28204;&amp;#35430;&amp;#21103;&amp;#26412;&amp;#65292;&amp;#28982;&amp;#24460;&amp;#27169;&amp;#25836;&amp;#21407;&amp;#26412;&amp;#30332;&amp;#29983;&amp;#22312;&amp;#23526;&amp;#38555;&amp;#31995;&amp;#32113;&amp;#30340;&amp;#29376;&amp;#27841;&amp;#20358;&amp;#37325;&amp;#35079;&amp;#22519;&amp;#34892;&amp;#25847;&amp;#21462;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#12290;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;/sentencetext&gt;&lt;/font&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; align=&quot;left&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt85&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;36859505af6cb9abb94af0eef364a1b2&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#21482;&amp;#26377;Distributed Replay Utility &amp;#25110; SQL Server 
      Profiler &amp;#25552;&amp;#20379;&amp;#36889;&amp;#38917;&amp;#21151;&amp;#33021;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt86&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;abc67a6522bfcadf2a5448298f4b1e26&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;
&amp;#160;&amp;#24744;&amp;#21487;&amp;#20197;&amp;#20351;&amp;#29992;&amp;#21407;&amp;#26412;&amp;#30340;&amp;#30332;&amp;#29983;&amp;#36895;&amp;#24230;&amp;#12289;&amp;#30433;&amp;#37327;&amp;#21152;&amp;#24555; (&amp;#29992;&amp;#20197;&amp;#39493;&amp;#31574;&amp;#31995;&amp;#32113;) &amp;#25110;&amp;#29978;&amp;#33267;&amp;#19968;&amp;#27425;&amp;#19968;&amp;#20491;&amp;#27493;&amp;#39519;&amp;#20358;&amp;#37325;&amp;#26032;&amp;#22519;&amp;#34892;&amp;#36889;&amp;#20123;&amp;#20107;&amp;#20214;&amp;#65292;&amp;#20197;&amp;#20415;&amp;#22312;&amp;#30332;&amp;#29983;&amp;#27599;&amp;#20491;&amp;#20107;&amp;#20214;&amp;#20043;&amp;#24460;&amp;#20998;&amp;#26512;&amp;#31995;&amp;#32113;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt87&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;e8e340c51244dd8542da7b2f41565917&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#34249;&amp;#30001;&amp;#22312;&amp;#28204;&amp;#35430;&amp;#29872;&amp;#22659;&amp;#19979;&amp;#20998;&amp;#26512;&amp;#30906;&amp;#23526;&amp;#30340;&amp;#20107;&amp;#20214;&amp;#65292;&amp;#21487;&amp;#20197;&amp;#36991;&amp;#20813;&amp;#25613;&amp;#23475;&amp;#23526;&amp;#38555;&amp;#31995;&amp;#32113;&amp;#12290;&lt;/sentencetext&gt;&lt;span class=&quot;Apple-converted-space&quot;&gt;
&amp;#160;&amp;#160;&lt;/span&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span align=&quot;left&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; float: none; display: inline !important; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot;&gt;&lt;/font&gt;&lt;/span&gt;&lt;font size=&quot;12px&quot; face=&quot;Segoe UI, Lucida Grande, Verdana, Arial, Helvetica, sans-serif&quot; color=&quot;rgb(42, 42, 42)&quot;&gt;&lt;span space=&quot;preserve&quot; xml=&quot;#DEFAULT&quot; id=&quot;mt88&quot; data-source=&quot;&quot; align=&quot;left&quot; data-guid=&quot;bd7fffdacce31045e99674f146b7df14&quot; style=&quot;white-space: normal; text-transform: none; font-variant: normal; word-spacing: 0px; text-indent: 0px; line-height: 18px; letter-spacing: normal&quot; class=&quot;sentence&quot;&gt;&lt;/font&gt;&lt;sentencetext xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&amp;#22914;&amp;#38656;&amp;#35443;&amp;#32048;&amp;#36039;&amp;#35338;&amp;#65292;&amp;#35531;&amp;#21443;&amp;#38321;&amp;#65308;&lt;span xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;&lt;a style=&quot;color: rgb(3, 105, 122); text-decoration: none&quot; href=&quot;http://msdn.microsoft.com/zh-tw/library/ms190995.aspx&quot;&gt;&lt;font color=&quot;rgb(3, 105, 122)&quot;&gt;
&amp;#37325;&amp;#26032;&amp;#22519;&amp;#34892;&amp;#36861;&amp;#36452;&lt;/font&gt;&lt;/a&gt;&lt;/span&gt;&amp;#65310;&amp;#12290;&lt;/sentencetext&gt;&lt;/span&gt;
    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;</richcontent>
</node>
</node>
</node>
<node CREATED="1378281959421" FOLDED="true" MODIFIED="1378691647229" POSITION="right" TEXT="performance Killers">
<node CREATED="1378281974828" MODIFIED="1378281986750" TEXT="Poor indexing"/>
<node CREATED="1378281990603" MODIFIED="1378281991528" TEXT="Inaccurate statistics"/>
<node CREATED="1378281991989" MODIFIED="1378281999632" TEXT="Poor query design"/>
<node CREATED="1378282000014" MODIFIED="1378282008778" TEXT="Poor execution plans, usually caused by bad parameter sniffing"/>
<node CREATED="1378282009881" MODIFIED="1378282016948" TEXT="Excessive blocking and deadlocks"/>
<node CREATED="1378282017241" MODIFIED="1378282023822" TEXT="Non-set-based operations, usually T-SQL cursors"/>
<node CREATED="1378282024135" MODIFIED="1378282030015" TEXT="Poor database design"/>
<node CREATED="1378282030374" MODIFIED="1378282035966" TEXT="Excessive fragmentation"/>
<node CREATED="1378282036218" MODIFIED="1378282042096" TEXT="Nonreusable execution plans"/>
<node CREATED="1378282048150" MODIFIED="1378282049130" TEXT="Frequent recompilation of queries"/>
<node CREATED="1378282049735" MODIFIED="1378282056993" TEXT="Improper use of cursors"/>
<node CREATED="1378282057543" MODIFIED="1378282067727" TEXT="Improper configuration of the database log"/>
<node CREATED="1378282068115" MODIFIED="1378282074164" TEXT="Excessive use or improper configuration of tempdb"/>
</node>
</node>
</map>
