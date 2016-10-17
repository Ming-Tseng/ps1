<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1347416202903" ID="ID_1250578232" LINK="MingLife.mm" MODIFIED="1347432153608" TEXT="Oracle WebCenter">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <a href="http://www.oraclefmw.com/2011/03/27/%E6%89%A9%E5%B1%95webcenter-space%E5%8E%9F%E7%90%86%E8%A7%A3%E6%9E%90/">http://www.oraclefmw.com/2011/03/27/%E6%89%A9%E5%B1%95webcenter-space%E5%8E%9F%E7%90%86%E8%A7%A3%E6%9E%90/ </a>
    </p>
    <p>
      <a href="http://www.oraclefmw.com/2011/03/27/%E6%89%A9%E5%B1%95webcenter-space%E5%8E%9F%E7%90%86%E8%A7%A3%E6%9E%90/">Oracle JDeveloper &#31995;&#63900;&#25991;&#31456;</a>
    </p>
  </body>
</html></richcontent>
<node CREATED="1347419481964" ID="ID_459686703" MODIFIED="1347419488663" POSITION="left" TEXT="JDeveloper"/>
<node CREATED="1347416316767" ID="ID_257326169" MODIFIED="1347416329126" POSITION="left" TEXT="Portal"/>
<node CREATED="1347417998853" ID="ID_769019768" MODIFIED="1347418003457" POSITION="left" TEXT="Function">
<node CREATED="1347418006415" ID="ID_834980086" MODIFIED="1347418030481" TEXT="UCM(Universal Content management"/>
<node CREATED="1347418031374" ID="ID_1065093323" MODIFIED="1347418031374" TEXT=""/>
</node>
<node CREATED="1347416696376" ID="ID_1574191829" MODIFIED="1347416726371" POSITION="left" TEXT="ADF">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Application Development Framework
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1347416329774" ID="ID_895249622" MODIFIED="1347416350543" POSITION="left" TEXT="Spaces"/>
<node CREATED="1378891028224" ID="ID_1310798732" MODIFIED="1378892286501" POSITION="right" TEXT="solution ">
<node CREATED="1378891116060" ID="ID_633326202" MODIFIED="1378891117482" TEXT="Envisioning Phase"/>
<node CREATED="1378891136610" ID="ID_921432428" MODIFIED="1378891138852" TEXT="Planning Phase"/>
<node CREATED="1378891178178" ID="ID_1038157404" MODIFIED="1378891179552" TEXT="Stabilizing Phase"/>
<node CREATED="1378891214872" ID="ID_1257306358" MODIFIED="1378891217808" TEXT="Deploying Phase"/>
<node COLOR="#ff0000" CREATED="1378891223170" FOLDED="true" ID="ID_198581545" MODIFIED="1378915673058" TEXT="Operations">
<node CREATED="1378891251237" ID="ID_1934425822" MODIFIED="1378891269266" TEXT="Windows Enviorment operations">
<node CREATED="1378891269946" ID="ID_1171111872" MODIFIED="1378891284667" TEXT="System administration"/>
<node CREATED="1378891300081" ID="ID_588973635" MODIFIED="1378891309083" TEXT="security administration"/>
<node CREATED="1378891310448" ID="ID_1621375997" MODIFIED="1378891319706" TEXT="Monitoring"/>
<node CREATED="1378891320434" ID="ID_77868666" MODIFIED="1378891322145" TEXT="alarm"/>
</node>
<node CREATED="1378891335895" ID="ID_1669444304" MODIFIED="1378891352240" TEXT="SQL Envirom">
<node CREATED="1378892000548" ID="ID_32170059" MODIFIED="1378892005916" TEXT="administration"/>
<node CREATED="1378892006427" ID="ID_1959370310" MODIFIED="1378892010383" TEXT="security"/>
<node CREATED="1378892011287" ID="ID_417011490" MODIFIED="1378892019165" TEXT="monitoring"/>
</node>
</node>
</node>
<node CREATED="1378892226058" ID="ID_322090481" MODIFIED="1378915674057" POSITION="right" TEXT="Guide">
<node CREATED="1378889200598" ID="ID_1810575801" MODIFIED="1378915680506" TEXT="Overview">
<node CREATED="1378889218828" FOLDED="true" ID="ID_1589278564" MODIFIED="1378917796201" TEXT="Main Migration Steps">
<node CREATED="1378915683136" ID="ID_429564361" MODIFIED="1378915705052" TEXT="1.map the Oracle tablespaces to SQL Server filegroups."/>
<node CREATED="1378915706175" ID="ID_1233609546" MODIFIED="1378915784874" TEXT="2map the Oracle schemas">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">2.1By default in SSMA, every Oracle schema becomes a separate SQL Server database. The target SQL&#160;Server schema in each of these databases is set to dbo&#8212;the predefined name for the database owner. Use this method if there are few references between Oracle schemas </span></font>
    </p>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">2.2 </span><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">Another approach is to map all Oracle schemas to one SQL&#160;Server database. In this case, an Oracle schema becomes a SQL&#160;Server schema with the same name. To use this method, you change the SSMA default settings. Use this method if different source schemas are deeply linked with each other</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378915831622" ID="ID_341610666" MODIFIED="1378915843885" TEXT="3.not to automate the security item migration in SSMA"/>
<node CREATED="1378915974780" ID="ID_336483689" MODIFIED="1378916043146" TEXT="4. performing the Convert Schema command">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif">&#160;</font><font face="Arial,sans-serif" size="11.0pt">connecting to the source Oracle server, selecting the server that is running SQL Server as the target </font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916043137" ID="ID_289997629" MODIFIED="1378916084927" TEXT="5.execute the Migrate Data command">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">transfers the data from the source to the target tables</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1378889226578" FOLDED="true" ID="ID_128325679" MODIFIED="1378917181175" TEXT="Conversion of Database Objects">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">Not all Oracle database objects have direct equivalents in SQL&#160;Server. In many cases, SSMA creates additional objects to provide the proper emulation. General conversion rules are as follows:</span></font>
    </p>
  </body>
</html>
</richcontent>
<node CREATED="1378916205944" ID="ID_627922259" MODIFIED="1378916229700" TEXT=" 1.Oracle table">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">Each Oracle table is converted to a SQL&#160;Server table. During the conversion, all indexes, constraints, and triggers defined for a table are also converted. When determining the target table's structure</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916269920" ID="ID_46205655" MODIFIED="1378916411366" TEXT="2.An Oracle view "/>
<node CREATED="1378916335775" ID="ID_966539981" MODIFIED="1378916344652" TEXT="3.Oracle stored procedures"/>
<node CREATED="1378916405003" ID="ID_458578447" MODIFIED="1378916505158" TEXT="4.user-defined functions">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      &#160;if the converted function can be compatible with SQL&#160;Server requirements. Otherwise, SSMA creates two objects: one function and one stored procedure.
    </p>
    <p>
      The additional procedure incorporates all the logic of the original function and is invoked in a separate process
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916513315" ID="ID_1190964587" MODIFIED="1378916564579" TEXT="5.DML triggers">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt">are converted to SQL&#160;Server triggers, but because the trigger functionality is different, the number of triggers and their types can be changed. See a description of trigger conversion </font>
    </p>
    <p>
      
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916571018" ID="ID_918046109" MODIFIED="1378916620645" TEXT="6.packages">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt">o not have direct SQL&#160;Server equivalents. SSMA converts each packaged procedure or function into separate target subroutines and applies rules for stand-alone procedures or functions. </font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916622097" ID="ID_255155947" MODIFIED="1378916763704" TEXT="7.sequences">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      SQL Server has no exact equivalent to Oracle sequences. SSMA can use one of two sequence conversion methods.
    </p>
    <p>
      The first method is to convert a sequence to an SQL Server identity column. That is the optimal solution, but as Oracle sequence objects are not linked to tables, using sequences may not be compatible with identity column functionality.
    </p>
    <p>
      In that situation, SSMA uses a second method, which is to emulate sequences by additional tables. This is not as effective as the first method, but it ensures better compatibility with Oracle
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916781965" ID="ID_357469590" MODIFIED="1378916803449" TEXT="8.private synonyms">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">converted to SQL&#160;Server synonyms stored in the target database. SSMA converts public synonyms to synonyms defined in the <b>sysdb</b>&#160;database. </span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1378889234745" FOLDED="true" ID="ID_1159087121" MODIFIED="1378917174314" TEXT="Differences in SQL Languages">
<node CREATED="1378916894635" ID="ID_657633344" MODIFIED="1378916923478" TEXT="hierarchical queries,">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">Oracle and SQL Server use different dialects of the SQL language, but SSMA can solve most of the problems introduced by this. For example, Oracle uses CONNECT BY statements for hierarchical queries, while SQL&#160;Server implements hierarchical queries by using common table expressions. The syntax of common table expressions does not resemble the Oracle format, and the order of tree traversal is different. To learn how SSMA converts hierarchical queries</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916927982" ID="ID_1730435506" MODIFIED="1378916983489" TEXT="pseudocolumns">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      such as ROWID or ROWNUM, present a special problem. When converting ROWNUM, SSMA emulates it with the TOP keyword of the SELECT statement if this pseudocolumn is used only to limit the size of the result set
    </p>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">I</span></font>f the row numbers appear in a SELECT list, SSMA uses the ROW_NUMBER( ) function. The ROWID problem can be solved by an optional column named ROWID, which stores a unique identifier in SQL&#160;Server.
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378916990073" ID="ID_1458146794" MODIFIED="1378917023180" TEXT="dynamic SQL statements">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">not convert dynamic SQL statements because the actual statement is not known until execution time and, in most cases, it cannot be reconstructed at conversion time. There is a workaround: The Oracle metabase tree displayed in SSMA contains a special node named Statements in which you can create and convert ad hoc SQL statements. If you can manually reproduce the final form of a dynamic SQL command, you can convert it as an object in the Statements node</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1378889235939" FOLDED="true" ID="ID_1174523348" MODIFIED="1378917174986" TEXT="PL/SQL Conversion">
<node CREATED="1378917055881" ID="ID_1804935020" MODIFIED="1378917057298" TEXT="Transact-SQL"/>
<node CREATED="1378917063506" ID="ID_819226682" MODIFIED="1378917064802" TEXT="PL/SQL "/>
<node CREATED="1378917091210" ID="ID_1941225892" MODIFIED="1378917107117" TEXT="cursor functionality">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">Oracle cursor functionality is not identical to cursor functionality in SQL&#160;Server. SSMA handles the differences</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378917107111" ID="ID_1858346282" MODIFIED="1378917139778" TEXT="Oracle transactions">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">especially autonomous transactions. In many cases you must review the code generated by SSMA to make the transaction implementation best suited to your needs.</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1378917141161" ID="ID_36858356" MODIFIED="1378917169741" TEXT=" PL/SQL types">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">Records and collections are examples of this. SSMA can process most cases of PL/SQL record and collections usage</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
</node>
<node CREATED="1378889282713" FOLDED="true" ID="ID_381281570" MODIFIED="1378917793342" TEXT="Data Migration Architecture of SSMA for Oracle">
<node CREATED="1378889293330" ID="ID_518442884" MODIFIED="1378917434252" TEXT="Implementation in SSMA">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">better control, monitor, and optimize the process</span></font>
    </p>
  </body>
</html>
</richcontent>
<node CREATED="1378917278579" ID="ID_570822178" MODIFIED="1378917280972" TEXT="NET Framework Data Provider for Oracle"/>
<node CREATED="1378917292650" ID="ID_332307432" MODIFIED="1378917294169" TEXT="Oracle Call Interface (OCI) "/>
<node CREATED="1378917307428" ID="ID_1925096297" MODIFIED="1378917309228" TEXT=".NET Framework Data Provider for OLE DB"/>
</node>
<node CREATED="1378889305682" ID="ID_91125593" MODIFIED="1378889307326" TEXT="Solution Layers&#x9;">
<node CREATED="1378917508362" ID="ID_1409098475" MODIFIED="1378917524669" TEXT="Client application, "/>
<node CREATED="1378917524670" ID="ID_826569500" MODIFIED="1378917531575" TEXT="an SSMA executable Stored procedures that serve as interfaces to all server actions"/>
<node CREATED="1378917531575" ID="ID_1006232064" MODIFIED="1378917531576" TEXT=" The database layer, which comprises two tables:"/>
<node CREATED="1378917544888" ID="ID_1573852982" MODIFIED="1378917554885" TEXT="The server executable, which starts as part of a SQL Server job, executes the data transfer, and reflects its status"/>
</node>
<node CREATED="1378889308111" ID="ID_882743229" MODIFIED="1378889316926" TEXT="Client Application"/>
<node CREATED="1378889337695" ID="ID_1569377509" MODIFIED="1378889340380" TEXT="Stored Procedures Interface"/>
<node CREATED="1378889341012" ID="ID_1729153249" MODIFIED="1378889350136" TEXT="Database Layer"/>
<node CREATED="1378889350368" ID="ID_1941893789" MODIFIED="1378889360609" TEXT="Migration Executable"/>
<node CREATED="1378889364062" ID="ID_1609893044" MODIFIED="1378889371066" TEXT="Message Handling"/>
<node CREATED="1378889374723" ID="ID_214461626" MODIFIED="1378917754779" TEXT="Validation of the Results">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif" size="11.0pt"><span lang="EN-US" style="line-height: 115%; font-size: 11.0pt; font-family: Arial,sans-serif">After the migration completes, the client must calculate the target table's row counts. If they are equal, the overall migration result is considered to be successful. Otherwise, the user is notified of the discrepancy and can view the source and destination counts</span></font>
    </p>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1378889591048" FOLDED="true" ID="ID_1661015" MODIFIED="1378917792382" TEXT="Migrating Oracle Data Types">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      14
    </p>
  </body>
</html></richcontent>
<node CREATED="1378889603427" ID="ID_1373182209" MODIFIED="1378889604616" TEXT="Numeric Data Types"/>
<node CREATED="1378889610451" ID="ID_1334352973" MODIFIED="1378889613045" TEXT="Character Data Types"/>
<node CREATED="1378889617354" ID="ID_702339067" MODIFIED="1378889621588" TEXT="Date and Time"/>
<node CREATED="1378889633749" ID="ID_834705486" MODIFIED="1378889636918" TEXT="Boolean Type"/>
<node CREATED="1378889640660" ID="ID_501496681" MODIFIED="1378889643726" TEXT="Large Object Types"/>
<node CREATED="1378889647259" ID="ID_425476217" MODIFIED="1378889651100" TEXT="XML Type"/>
<node CREATED="1378889654194" ID="ID_106288541" MODIFIED="1378889657715" TEXT="ROWID Types"/>
</node>
<node CREATED="1378889661901" ID="ID_126738643" MODIFIED="1378889663649" TEXT="Migrating Oracle Spatial Data"/>
<node CREATED="1378889681360" FOLDED="true" ID="ID_1118145981" MODIFIED="1378916460915" TEXT="Emulating Oracle System Objects">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <p>
      <font face="Arial,sans-serif">Note that Oracle procedures can use <i>nested subprograms</i>, which means that another procedure or function can be declared and called locally within the main procedure. </font>
    </p>
    <p>
      <font face="Arial,sans-serif">The current version of SSMA does not support nested subprograms, but you can find methods to manually convert them in</font>
    </p>
  </body>
</html>
</richcontent>
<node CREATED="1378889707784" ID="ID_971976046" MODIFIED="1378889709021" TEXT="Converting Oracle System Views"/>
<node CREATED="1378889709477" ID="ID_77208243" MODIFIED="1378889715828" TEXT="Converting Oracle System Functions"/>
<node CREATED="1378889716180" ID="ID_1780997204" MODIFIED="1378889722519" TEXT="Converting Oracle System Packages"/>
</node>
<node CREATED="1378889730365" FOLDED="true" ID="ID_1249377420" MODIFIED="1378889748626" TEXT="Converting Nested PL/SQL Subprograms">
<node CREATED="1378889736746" ID="ID_1691074942" MODIFIED="1378889737871" TEXT="Inline Substitution"/>
<node CREATED="1378889743657" ID="ID_1248661589" MODIFIED="1378889745963" TEXT="Emulation by Using Transact-SQL Subprograms"/>
</node>
<node CREATED="1378889749498" FOLDED="true" ID="ID_729949966" MODIFIED="1378890098027" TEXT="Migrating Oracle User-Defined Functions">
<node CREATED="1378889751188" ID="ID_959797240" MODIFIED="1378889756659" TEXT="Conversion Algorithm"/>
<node CREATED="1378889763064" ID="ID_1283531396" MODIFIED="1378889764359" TEXT="Converting Function Calls"/>
</node>
<node CREATED="1378889781958" FOLDED="true" ID="ID_852336471" MODIFIED="1378889901316" TEXT="Migrating Oracle Triggers">
<node CREATED="1378889789845" ID="ID_761849766" MODIFIED="1378889791026" TEXT="Conversion Patterns"/>
</node>
<node CREATED="1378889827621" FOLDED="true" ID="ID_1966057457" MODIFIED="1378889903109" TEXT="Emulating Oracle Packages&#x9;97 ">
<node CREATED="1378889839108" ID="ID_1415175360" MODIFIED="1378889848243" TEXT="Converting Procedures and Functions&#x9;97 "/>
<node CREATED="1378889848243" ID="ID_536102844" MODIFIED="1378889858519" TEXT="Converting Overloaded Procedures&#x9;98 "/>
<node CREATED="1378889858519" ID="ID_1160383439" MODIFIED="1378889865220" TEXT="Converting Packaged Variables&#x9;98 "/>
<node CREATED="1378889865221" ID="ID_720214900" MODIFIED="1378889871861" TEXT="Converting Packaged Cursors&#x9;99 "/>
<node CREATED="1378889871861" ID="ID_1607121344" MODIFIED="1378889880323" TEXT="Converting Initialization Section&#x9;100 "/>
<node CREATED="1378889880323" ID="ID_305328313" MODIFIED="1378889880324" TEXT="Package Conversion Code Example&#x9;102"/>
</node>
<node CREATED="1378889917042" FOLDED="true" ID="ID_1697585733" MODIFIED="1378889984372" TEXT=" Emulating Oracle Sequences&#x9;104 ">
<node CREATED="1378889922766" ID="ID_1007321247" MODIFIED="1378889930945" TEXT="How SSMA for Oracle V4.0 Creates and Drops Sequences&#x9;104 "/>
<node CREATED="1378889930945" ID="ID_4293651" MODIFIED="1378889938117" TEXT="NEXTVAL and CURRVAL Simulation in SSMA for Oracle V4.0&#x9;106 "/>
<node CREATED="1378889938118" ID="ID_201228559" MODIFIED="1378889938119" TEXT="Examples of Conversion&#x9;107"/>
</node>
<node CREATED="1378889950247" FOLDED="true" ID="ID_1349413846" MODIFIED="1378889983654" TEXT="Migrating Hierarchical Queries&#x9;111 ">
<node CREATED="1378889957662" ID="ID_409465891" MODIFIED="1378889965677" TEXT="Emulating Oracle Exceptions&#x9;115 "/>
<node CREATED="1378889965677" ID="ID_1392471160" MODIFIED="1378889972868" TEXT="Exception Raising&#x9;115 "/>
<node CREATED="1378889972869" ID="ID_18391416" MODIFIED="1378889980293" TEXT="Exception Handling&#x9;117 "/>
<node CREATED="1378889980293" ID="ID_111095527" MODIFIED="1378889980294" TEXT="SSMA Exceptions Migration&#x9;118"/>
</node>
<node CREATED="1378890053755" FOLDED="true" ID="ID_1859714453" MODIFIED="1378890226221" TEXT="Simulating Oracle Transactions in SQL Server 2008&#x9;">
<node CREATED="1378890060886" ID="ID_924393011" MODIFIED="1378890105215" TEXT="Choosing a Transaction Management Model&#x9;136 "/>
<node CREATED="1378890105215" ID="ID_941347790" MODIFIED="1378890109750" TEXT="Autocommit Transactions&#x9;136 "/>
<node CREATED="1378890109751" ID="ID_1635854322" MODIFIED="1378890114419" TEXT="Implicit Transactions&#x9;136 "/>
<node CREATED="1378890114420" ID="ID_1395024118" MODIFIED="1378890122403" TEXT="Explicit Transactions&#x9;136 "/>
<node CREATED="1378890122403" ID="ID_1786716947" MODIFIED="1378890129286" TEXT="Choosing a Concurrency Model&#x9;137 "/>
<node CREATED="1378890129287" ID="ID_1321100853" MODIFIED="1378890129288" TEXT="Make Transaction Behavior Look Like Oracle&#x9;137"/>
</node>
<node CREATED="1378890069826" FOLDED="true" ID="ID_1719668757" MODIFIED="1378890478874" TEXT="Simulating Oracle Autonomous Transactions&#x9;138 ">
<node CREATED="1378890075947" ID="ID_304028057" MODIFIED="1378890165047" TEXT="Simulating Autonomous Procedures and Packaged Procedures&#x9;139 "/>
<node CREATED="1378890165048" ID="ID_1641325946" MODIFIED="1378890171358" TEXT="Simulating Autonomous Functions and Packaged Functions&#x9;140 "/>
<node CREATED="1378890171359" ID="ID_1125150886" MODIFIED="1378890178719">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Simulation of Autonomous Triggers&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;141
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378890178723" ID="ID_220148919" MODIFIED="1378890178734">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Code Example&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;142
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1378890084292" FOLDED="true" ID="ID_1092548508" MODIFIED="1378890479751" TEXT="Migrating Oracle Records and Collections&#x9;">
<node CREATED="1378890089917" ID="ID_626291398" MODIFIED="1378890185513" TEXT="Implementing Collections&#x9;143 "/>
<node CREATED="1378890185514" ID="ID_1430851385" MODIFIED="1378890189971" TEXT="Implementing Records&#x9;153 "/>
<node CREATED="1378890189971" ID="ID_1006081116" MODIFIED="1378890196439" TEXT="Implementing Records and Collections via XML&#x9;155 "/>
<node CREATED="1378890196439" ID="ID_1432015238" MODIFIED="1378890202414">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Sample Functions for XML Record Emulation&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;158
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1378890202418" ID="ID_1007339009" MODIFIED="1378890202424">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      Emulating Records and Collections via CLR UDT&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;159
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1378889992227" FOLDED="true" ID="ID_529332302" MODIFIED="1378890096072" TEXT="Migrating Oracle Cursors&#x9;121 ">
<node CREATED="1378889999141" ID="ID_734154458" MODIFIED="1378890006648" TEXT="Syntax&#x9;121 "/>
<node CREATED="1378890006649" ID="ID_217054533" MODIFIED="1378890013249" TEXT="Declaring a Cursor&#x9;122 "/>
<node CREATED="1378890013249" ID="ID_1833792404" MODIFIED="1378890017621" TEXT="Opening a Cursor&#x9;124 "/>
<node CREATED="1378890017621" ID="ID_1801750351" MODIFIED="1378890022508" TEXT="Fetching Data&#x9;125 "/>
<node CREATED="1378890022509" ID="ID_1169734352" MODIFIED="1378890029343" TEXT="CURRENT OF Clause&#x9;130 "/>
<node CREATED="1378890029343" ID="ID_1263371744" MODIFIED="1378890036209" TEXT="Closing a Cursor&#x9;130 "/>
<node CREATED="1378890036209" ID="ID_1204356692" MODIFIED="1378890036210" TEXT="Examples of SSMA for Oracle V4.0 Conversion&#x9;132"/>
</node>
</node>
</node>
</map>
