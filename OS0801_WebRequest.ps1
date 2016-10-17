<#OS00_Indexfilelocation : \\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\ps1\OS0801_WebRequest.ps1\\172.16.220.29\c$\Users\administrator.CSD\OneDrive\download\PS1\\192.168.112.124\c$\Users\administrator.CSD\OneDrive\download\PS1\OS0801_WebRequest.ps1CreateDate: APR.30.2014LastDate : AUG.11.2015Author :Ming Tseng  ,a0921887912@gmail.comremark 
email backup


$ps1fS=gi C:\Users\administrator.CSD\OneDrive\download\ps1\OS0801_WebRequest.ps1

foreach ($ps1f in $ps1fS)
{
    start-sleep 1
    $ps1fname         =$ps1fS.name
    $ps1fFullname     =$ps1fS.FullName 
    $ps1flastwritetime=$ps1fS.LastWriteTime
    $getdagte         = get-date -format yyyyMMdd
    $ps1length        =$ps1fS.Length

    Send-MailMessage -SmtpServer  '172.16.200.27'  -To "a0921887912@gmail.com","abcd12@gmail.com" -from 'a0921887912@gmail.com' `
    -attachment $ps1fFullname  `
    -Subject "ps1source  -- $getdagte      --        $ps1fname       --   $ps1flastwritetime -- $ps1length " `
    -Body "  ps1source from:me $ps1fname   " 
}
#>


58  國中歷屆考題 (Local)
467 題庫補充  (Local)
990 考古題分類(Local)
#---------------------------------------------
#  國中歷屆考題  90~ 105年
#---------------------------------------------
#最後可能是網路or Recursive 太多cycle.造成網路不明原因 當機.因此只好將第2層明細出來array. 再一一呼叫getHTML
如有中斷.再人工接續即可
如果有 資料夾名稱有 %20 ,去掉即可
三部分function各自獨立
以  考古題分類  較完整. 
記得  MD folder 加上 |out-null 

$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test.htm'            ;#start $htmlpage
#Invoke-WebRequest -Uri $htmlpage -OutFile   C:\rosatree\years-test\years-test.htm
#years-test103-105.htm  v  
#years-test100-102.htm   由於由主頁Main 直接下載有問題．改成以各年度逐一下載
#years-test97-99.htm
#years-test94-96.htm
#years-test91-93.htm
#years-test90.htm



$urlpage='http://rosatree.myweb.hinet.net'

$urlsite='http://eschool.hsjh.chc.edu.tw/~academ6/math/1984.htm'
####################################################################################################
##-------------------------------------------------------------------------------
##   58 國中歷屆考題
##-------------------------------------------------------------------------------
###################################################################################################

function getjpgname     ($urlstring){     
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/103-special-questiom/103s-1-5.htm'
     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}  #得取JPG 檔名
function getjpgfullpath ($urlstring){     
     $a=$urlstring.indexof("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)




    return $yu
}
function gethtmName     ($urlstring){  
     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}  #得取 HTML 檔名
function getlocalpath   ($getlocalpath){  
     
     #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/classified-no1-1.htm'  #測試頁放這
 

     # '  34  getlocalpath    '+$getlocalpath  |out-file c:\temp\listweb.txt  -Append

     $a=$getlocalpath.Substring(45,($getlocalpath.Length-45));#$a
     $char = '/';$result = 0..($a.length - 1) | ? {$a[$_] -eq $char};#$result
     
     switch (  ($result).count  )
     {
         '1' {  $f1=$a.Substring(0, $result[0] ) ;if (   !(test-path "C:\rosatree\$f1")   ) {  MD "C:\rosatree\$f1" } ;$yu="C:\rosatree\$f1" }
         '2' {
               $f1=$a.Substring(0, $result[0] ) ;#$f1
               $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2 
               if (   !(test-path "C:\rosatree\$f1\$f2" )   ){    MD "C:\rosatree\$f1\$f2" }
                  $yu="C:\rosatree\$f1\$f2"
             }
         '3' {  
              $f1=$a.Substring(0, $result[1]-$result[0] ) ;#$f1
              $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2   
              $f3=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
         '4' {  
              $f1=$a.Substring(1, $result[1]-$result[0]-1 ) ;#$f1
              $f2=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f2   
              $f3=$a.Substring($result[2]+1, $result[3]-$result[2]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
     }
     #'  56  yu    '+$yu  |out-file c:\temp\listweb.txt  -Append
    return $yu
}  #得取 HTML 路徑 ; 如無即新增
function getjpglocalpath   ($getlocalpath){  
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/icon/years-test/years-test90.jpg'         #1
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test103-105.htm'  #2
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105questiom/105-1-5.htm'#3
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/01.htm'       #4
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/103-special-questiom/103s-1-5.htm'

    # '  34  getlocalpath    '+$getlocalpath  |out-file c:\temp\listweb.txt  -Append

     $a=$getlocalpath.Substring(45,($getlocalpath.Length-45));#$a
     $char = '/';$result = 0..($a.length - 1) | ? {$a[$_] -eq $char};#$result
     
     switch (  ($result).count  )
     {
         '1' {  $f1=$a.Substring(0, $result[0] ) ;if (   !(test-path "C:\rosatree\$f1")   ) {  MD "C:\rosatree\$f1" } ;$yu="C:\rosatree\$f1" }
         '2' {
               $f1=$a.Substring(0, $result[0] ) ;#$f1
               $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2 
               if (   !(test-path "C:\rosatree\$f1\$f2" )   ){    MD "C:\rosatree\$f1\$f2" }
                  $yu="C:\rosatree\$f1\$f2"
             }
         '3' {  
              $f1=$a.Substring(0, $result[1]-$result[0] ) ;#$f1
              $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2   
              $f3=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
         '4' {  
              $f1=$a.Substring(1, $result[1]-$result[0]-1 ) ;#$f1
              $f2=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f2   
              $f3=$a.Substring($result[2]+1, $result[3]-$result[2]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
     }
     '  	119 (3) getjpglocalpath yu    '+$yu  |out-file c:\temp\listweb.txt  -Append
    return $yu
}  # 得取 JPG 路徑  如無即新增
function getJPG    ($htmlpage){
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/1-1-4/questiom/1-5.htm'         # test here
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/119.htm'
    #start $htmlpage
    #'137   '+$htmlpage 
    $e1S=invoke-WebRequest $htmlpage  ; #start $htmlpage
    $jS=$e1S.Images.src;#$JS

   foreach ($j in $jS)
     { #303
        #}#--
        #'144  '+$j
         if (  !($j.Contains('up.jpg')) )
                    {
        if ( $j.Contains('../icon/years-test')   )
        { #105-1
             if ($j.Contains('up.jpg')   )
             {
                 
             }
             else
             {
             $srcpath ='http://eschool.hsjh.chc.edu.tw/~academ6/math/' + $j.Substring(3,($j.Length-3) ) ;#  start $srcpath
             $destfile=(getjpglocalpath $srcpath)+'\'+(gethtmName $srcpath) ;#start (getlocalpath $srcpath)
              #+'    		152 (4getJPG)   start   '+ $srcpath   |out-file c:\temp\listweb.txt -Append
              #+'    		152 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Append
               # '1&2' 
             }
        }  #105-1
        else
        {  #105-2
            if (  $j.Contains('answer.jpg')  )
            {  #120-1
                
                #'  167  not care'
            }  #120-1
            else
            {  #120-2
                if (  $htmlpage.Contains('questiom') )
                { #127-1
                  #  '   172 point'
                    $u1=$htmlpage.Substring(0,($htmlpage.LastIndexOf('/')))
                    $srcpath  = $u1+'/'+$j; #start $srcpath
                    $destfile=(getjpglocalpath $srcpath)+'\'+(gethtmName $srcpath) ;#start (getlocalpath $srcpath)
                   #+ '    		169 (4getJPG)   start   '+ $srcpath  |out-file c:\temp\listweb.txt -Append
                   #+ '    		169 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Append
                  #  'question'
                } #127-1
                else
                { #127-2
                    $u1=$htmlpage.Substring(0,($htmlpage.LastIndexOf('/')))
                    #$u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-6 ,6) ;#$u2 
                    $srcpath  = $u1+'/'+$j; #start $srcpath
                    $destfile=(getjpglocalpath $srcpath)+'\'+(gethtmName $srcpath) ;#start (getlocalpath $srcpath)
                    #+ '    		179 (4getJPG)   start   '+ $srcpath  |out-file c:\temp\listweb.txt -Append
                    #+ '    		179 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Append
                  #  'answer'
                } #127-2

            }  #120-2     


        }  #105-2

                     Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
                    }
        #'202  end'
    
  }    #303

}  # 下載此 URL 下的所有JPG


gps notepad | Stop-Process -Force 

if ((Test-Path C:\temp\listweb.txt )){ ri c:\temp\listweb.txt }

function getHTML ($htmlpage)
{  #166-0
    $htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'  #主頁(MAIN)位置  years-test100-102.htm
    #$htmlpage=$htmlindex+'years-test100-102.htm';  start  $htmlpage       #測試 起頭頁(本頁) 在網路上是否OK.
    
    #'     ';$dt='';$ht=''
    #+'  142(1)  ' + $htmlpage  |out-file c:\temp\listweb.txt -Append
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/classified-no1-1.htm'         #測試頁放這
    

    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/02.htm'
    #start $htmlpage
    <#
    if ($htmlpage.Contains('questiom')){
       #$htmlpage.LastIndexOf('l/') 
       $u1=$htmlpage.Substring(52,5);#$u1
       $u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-8 ,8);#$u2   
    }
    if ($htmlpage.Contains('answer')){
       #$htmlpage.LastIndexOf('/') 
       $u1=$htmlpage.Substring(54,$htmlpage.LastIndexOf('/')-61);#$u1
       $u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-6 ,6) ;#$u2   
    }   
    
    '267'
    #>

    $dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 
    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage   
    #'271'                                         #  start $dt  下載起頭頁(本頁)JPGS
    #$u1;$u2
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test103-105.htm'  #2
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105questiom/105-1-5.htm'#3
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/01.htm'       #4

    $e1S=invoke-WebRequest $htmlpage ; # $e1S.Links.href  本頁中(this) 所有link ( this all link) ex :102questiom/102-1-5.htm
    #$hhcounti=($e1S.Links.href).count; $hhcount=$hhcounti
    foreach ($e1 in ($e1S.Links.href))  # 
    {  # 196 -1
    #}#--
    #'249' + $e1
        #$hhcount.tostring() +'   total: '+ $hhcounti.tostring()  ; $hhcount-=1
        if ( !($e1.Contains('examination.html'))  ) # 排除 this all link 不要下載
        {  #199-2
            
            if ($e1.Contains('answer/') ) # (this all link) 如有
            { # 202-3.1
                #$e1  ;
                #$e1.Substring(3,$e1.Length-3) 
                $ht=$htmlindex+($e1.Substring(3,$e1.Length-3) )  ;# $ht
                $dt=(getlocalpath  $ht)+'\'+(gethtmName $ht)     ;# $dt
                #'    248 (2)   start   '+ $htmlindex  |out-file c:\temp\listweb.txt -Append
                #+'    248 (2)   start   '+ $ht  |out-file c:\temp\listweb.txt -Append
                #+'    248 (2)   start   '+ $dt  |out-file c:\temp\listweb.txt -Append

                #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/01.htm
                #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/05.htm

                #$ht
            } # 202-3.1
            else
            { # 202-3.2  #  (this all link) 中的標準URL
                $ht=$htmlindex+$e1  ; #$ 主頁(MAIN)+ (this all link)
                $dt=(getlocalpath  $ht)+'\'+(gethtmName $ht)  ; #$dt
                #+'    258 (2)   start   '+ $ht  |out-file c:\temp\listweb.txt -Append
                #+'    258 (2)   start   '+ $dt  |out-file c:\temp\listweb.txt -Append
            } # 202-3.2

               # '    189    start   '+ $ht  |out-file c:\temp\listweb.txt -Append
               # '    192    start   '+ $dt  |out-file c:\temp\listweb.txt  -Append

            Invoke-WebRequest -Uri $ht -OutFile   $dt  #  下載 (one of this all link) HTML檔  start $dt
            
            #sleep 3
            #$ht + '   >>HTML 下載完成  :'#+$r.ToString()
            getJPG  $ht　　;#下載 (one of this all link) 下的所有JPG
            $ht + '    >> JPGs 下載完成'
            getHTML $ht   # recursive 
        } #199-2
        
    }  # 196-1
    #------------
    #start $ht

        
        
    
}  #166-0



#---------------------------------------------
#---------------------------------------------
#  years-test103-105
#---------------------------------------------
#---------------------------------------------



#---------------------------------------------
#---------------------------------------------
#  years-test100-102
#---------------------------------------------
#---------------------------------------------
{<#
共41subsite
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'
$htmlpage ='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test100-102.htm'

 Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS
$e2S=invoke-WebRequest $htmlpage 
$cd=($e2S.Links.href).count
$xc = 0..$cd

$i = 0
foreach ($e2 in ($e2S.Links.href)) 
{
$xc[$i]=$e2
$i++
}
$xc[0];$xc[40]
$r=0
for ($i = 20; $i -lt $cd  ; $i++)
{ 
$r=$i;$r
     $t1=get-date
     #$xc[$i]
  $getsubsite=$htmlindex+$xc[$i];#$getsubsite
'開始　'+　$getsubsite + '  中... 時間是  '+　$t1.tostring()
 getHTML $getsubsite

}

  $getsubsite=$htmlindex+$xc[21];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm
ii c:\temp\listweb.txt


#>}
#---------------------------------------------
#---------------------------------------------
#  #years-test97-99.htm
#---------------------------------------------
#---------------------------------------------
{<#
共 42   subsite
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'
$htmlpage ='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test97-99.htm'
 Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS

$e2S=invoke-WebRequest $htmlpage 
$cd=($e2S.Links.href).count
$xc = 0..$cd

$i = 0
foreach ($e2 in ($e2S.Links.href)) 
{
$xc[$i]=$e2
$i++
}
$xc[0];$xc[41]

$r=0
for ($i = 33 ; $i -lt $cd  ; $i++) #jul.31.stop in 33
{ 
$r=$i;$r ;$t1=get-date #$xc[$i]
  $getsubsite=$htmlindex+$xc[$i];#$getsubsite
'開始　'+　$getsubsite + '  中... 時間是  '+　$t1.tostring()
 getHTML $getsubsite
 }



   $getsubsite=$htmlindex+$xc[35];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm
#>}

#---------------------------------------------
#---------------------------------------------
#  #years-test94-96.htm
#---------------------------------------------
#---------------------------------------------
{<#
共 42   subsite
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'
$htmlpage ='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test94-96.htm'
$dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 

    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS

$e2S=invoke-WebRequest $htmlpage 
$cd=($e2S.Links.href).count
$xc = 0..$cd

$i = 0
foreach ($e2 in ($e2S.Links.href)) 
{
$xc[$i]=$e2
$i++
}
$xc[0];$xc[41]


$r=0
for ($i = 0 ; $i -lt $cd  ; $i++) #jul.31.stop in 33
{ 
$r=$i;$r ;$t1=get-date #$xc[$i]
  $getsubsite=$htmlindex+$xc[$i];#$getsubsite
'開始　'+　$getsubsite + '  中... 時間是  '+　$t1.tostring()
 getHTML $getsubsite
 }
   $getsubsite=$htmlindex+$xc[1];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[7];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[14];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[21];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[28];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[35];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm
#>}





#---------------------------------------------
#---------------------------------------------
#  #years-test91-93.htm
#---------------------------------------------
#---------------------------------------------

{<#
共 38   subsite
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'
$htmlpage ='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test91-93.htm'
$dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 

    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS

$e2S=invoke-WebRequest $htmlpage 
$cd=($e2S.Links.href).count
$xc = 0..$cd

$i = 0
foreach ($e2 in ($e2S.Links.href)) 
{
$xc[$i]=$e2
$i++
}
$xc[0];$xc[37-1]

$r=0
for ($i = 0 ; $i -lt $cd  ; $i++) #jul.31.stop in 33
{ 
$r=$i;$r ;$t1=get-date #$xc[$i]
  $getsubsite=$htmlindex+$xc[$i];#$getsubsite
'開始　'+　$getsubsite + '  中... 時間是  '+　$t1.tostring()
 getHTML $getsubsite
 }
   $getsubsite=$htmlindex+$xc[0];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[7];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[14];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[20];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[26];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm

   $getsubsite=$htmlindex+$xc[32];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm
#>}


#---------------------------------------------
#---------------------------------------------
#  #years-test90.htm
#---------------------------------------------
#---------------------------------------------

#{<#
共 38   subsite
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'
$htmlpage ='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test90.htm'
$dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 

    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS

$e2S=invoke-WebRequest $htmlpage 
$cd=($e2S.Links.href).count
$xc = 0..$cd

$i = 0
foreach ($e2 in ($e2S.Links.href)) 
{
$xc[$i]=$e2
$i++
}
$xc[0];$xc[$cd-1]

$r=0
for ($i = 0 ; $i -lt $cd  ; $i++) #jul.31.stop in 33
{ 
$r=$i;$r ;$t1=get-date #$xc[$i]
  $getsubsite=$htmlindex+$xc[$i];#$getsubsite
'開始　'+　$getsubsite + '  中... 時間是  '+　$t1.tostring()
 getHTML $getsubsite
 }
   $getsubsite=$htmlindex+$xc[0];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm
 
 $sdf='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/90-2exercise%20questiom/90-2-1-5.htm'
     

 Invoke-WebRequest -Uri $sdf -OutFile   'C:\rosatree\years-test\90-2exercise questiom\90-2-1-5.htm'
   http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/90-2questiom/90-2-1-5.htm
   file:///C:/rosatree/years-test/90-1exercise%20questiom/90-1-1-5.htm

#>}





'開始　'+　$htmlpage + '  中... 時間是  '+　$t1.tostring()

try
{
    getHTML $htmlpage 
}
#catch [DivideByZeroException]
#{
#      '    293   start   '+ $ht  |out-file c:\temp\listweb.txt -Append
#      '    293   start   '+ $dt  |out-file c:\temp\listweb.txt -Append
#}
catch [System.Net.WebException],[System.Exception]
{
     '    298 (error)   start   '+ $ht  |out-file c:\temp\listweb.txt -Append
     '    298 (error)   start   '+ $dt  |out-file c:\temp\listweb.txt -Append
}
finally
{
    Write-Host "OK"
}



ii c:\temp\listweb.txt

####################################################################################################
##-------------------------------------------------------------------------------
##   467 題庫補充
##-------------------------------------------------------------------------------
###################################################################################################
taskschd.msc

appwiz.cpl
shutdown -s -f


$web = New-Object Net.WebClient
$web.DownloadString("http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/classified-no1-1.htm")  |out-file  c:\temp\classified-no1-1.htm
$web.DownloadString("http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/1-1-1/questiom/1-5.htm")  |out-file  c:\temp\1-5.htm
$web.DownloadString("http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/1-1-1/questiom/02.jpg")  |out-file  c:\temp\icon\test-classified\02.jpg
$web.DownloadData("http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/1-1-1/questiom/02.jpg") |out-file  c:\temp\icon\test-classified\02.jpg

/icon/test-classified/1-1-1.jpg

ii  c:\temp\icon\test-classified

notepad  c:\temp\classified-no1-1.htm
../icon/test-classified/chap1.jpg

2



$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/","C:\temp\file")

#---------------------------------------------
#
#---------------------------------------------
$Browser64 = "C:\Program Files\Internet Explorer\iexplore.exe" 
Start-Process $Browser64  -ArgumentList www.udn.comStart-Process $Browser64  http://rosatree.myweb.hinet.net/

$urlpage='http://rosatree.myweb.hinet.net'
Start-Process  $urlpage
Start-Process -FilePath $urlpage 



$urlsite='http://eschool.hsjh.chc.edu.tw/~academ6/math/1984.htm'


start  $urlsite


$destf1='c:\rosatree\1984.htm'
ii $destpath 
start $destf
ri $destf

$leftp=invoke-WebRequest -Uri $urlpage1
$leftp.Links.href


$exeaddM=$urlsite+'t cool/'                  
$exeadd=$exeaddM+'classified.htm' ; start $exeadd 
$yearstest=$urlsite+'years-test/years-test.htm'            ; start $yearstest
$testclassified=$urlsite+'test-classified/classified.htm'  ; start $testclassified

#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
$urlsite='http://eschool.hsjh.chc.edu.tw/~academ6/math/'
$destpath='C:\rosatree\icon\test-classified'
ii  $destpath

function getjpgname     ($urlstring){     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}
function getjpgfullpath ($urlstring){     
     $a=$urlstring.indexof("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)




    return $yu
}
function gethtmName    ($urlstring){  
     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}
function getlocalpath ($urlstring){  
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/1-5.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-5/questiom/30.jpg'
     
     $a=$urlstring.Substring(45,($urlstring.Length-45));#$a
     $char = '/';$result = 0..($a.length - 1) | ? {$a[$_] -eq $char};#$result
     
     switch (($result).count)
     {
         '1' {  $f1=$a.Substring(0, $result[0] ) ;if (   !(test-path "C:\rosatree\$f1")   ) {  MD "C:\rosatree\$f1" } ;$yu="C:\rosatree\$f1" }
         '3' {  
              $f1=$a.Substring(0, $result[1]-$result[0] ) ;#$f1
              $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2   
              $f3=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
         '4' {  
              $f1=$a.Substring(1, $result[1]-$result[0]-1 ) ;#$f1
              $f2=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f2   
              $f3=$a.Substring($result[2]+1, $result[3]-$result[2]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
     }
     
    return $yu
}


$e1S=invoke-WebRequest $exeadd
$jS=$e1S.Images.src;$jS

# Get html
$dt=(getlocalpath  $exeadd) + '\' + (gethtmName  $exeadd)  
Invoke-WebRequest -Uri $exeadd -OutFile   $dt  #  start $dt

# Get jpg
foreach ($j in $jS)
{
    $srcpath =$urlsite +(getjpgfullpath $j)
    $destfile=$destpath+'\'+(getjpgname $j)
    Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
}



ri  C:\rosatree\log.txt
$w=1

gethtmljpg $exeadd 
ii  C:\rosatree\log.txt

ii  C:\rosatree\log.txt

gps notepad | Stop-Process -Force
ri c:\temp\listweb.txt


$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-2/questiom/1-5.htm' ;
$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/6-10.htm' ;

getHTML $htmlpage 


ii c:\temp\listweb.txt


 |out-file c:\temp\listweb.txt
$ht='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/119.htm'




function getJPG ($htmlpage)
{
    $htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/'
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/1-5.htm' ;
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/6-10.htm' ;

    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/119.htm'
    #start $htmlpage

    $e1S=invoke-WebRequest $htmlpage  ; #start $htmlpage
    $jS=$e1S.Images.src;#$JS

   foreach ($j in $jS)
     { #303
        #}#--
        if ( $j.Contains('../icon/test-classified')   )
        {
             if ($j.Contains('up.jpg')   )
             {
                 
             }
             else
             {
             $srcpath ='http://eschool.hsjh.chc.edu.tw/~academ6/math/' + $j.Substring(3,($j.Length-3) )
             $destfile ='C:\rosatree\icon\test-classified'+'\'+$j.Substring($j.LastIndexOf('/')+1,(  ($j.Length)-($j.LastIndexOf('/')+1) )    )
               # '1&2' 
             }

             
        }
        else
        {
            if (  $j.Contains('answer.jpg')  )
            {
                $j
               # 'no care'
            }
            else
            {
                if (  $htmlpage.Contains('questiom') )
                {
                     $u1=$htmlpage.Substring(52,5);#$u1
                     $u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-8 ,8);#$u2   
                     #$hname=$e1.Substring( $e1.LastIndexOf('/')+1,($e1.Length)-($e1.LastIndexOf('/'))-1)   
                     #$ht=$htmlindex+$u1+'/questiom/'+ $hname   ;#start $ht  
                    $srcpath  = $htmlindex+$u1+'/'+$u2+'/'+$j; #start $srcpath
                    $destfile = 'C:\rosatree\t cool\'+$u1+'\questiom'+'\'+$j ; #start $destfile 
                  
                  #  'question'
                }
                else
                {
                    $u1=$htmlpage.Substring(52,$htmlpage.LastIndexOf('/')-59);#$u1
                    $u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-6 ,6) ;#$u2 
                      
                    $srcpath  = $htmlindex+$u1+'/'+$u2+'/'+$j; #start $srcpath
                    $destfile = 'C:\rosatree\t cool\'+$u1+'\answer'+'\'+$j ;# start $destfile
                  #  'answer'
                }

            }       


        }


        #$srcpath ;$destfile
        Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
    }    #303

   

   
}

start $srcpath
start $destfile


http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/../icon/test-classified/no6-2.jpg
C:\rosatree\ c\icon\test-classified\../icon/test-classified/no6-2.jpg











getHTML 'http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/classified.htm'

getHTML  'http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/classified-no1-1.htm'



gethtmljpg $exeadd |out-file C:\rosatree\log.txt -Append
  
gethtmljpg  'http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
gethtmljpg  'http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/1-5.htm'
start $dt
http://eschool.hsjh.chc.edu.tw/~academ6/math/classified-no3-1.htm
http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/classified-no1-1.htm

$exeadd 

http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm

PS C:\Users\administrator.CSD> gethtmljpg $exeadd 
0
gethtmljpg  'http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
1
gethtmljpg 'http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-2.htm'
2
gethtmljpg 'http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-3.htm'
3
http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no2-1.htm
4
http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no2-2.htm
5
http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no2-3.htm
6
http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no2-4.htm
7
http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no2-5.htm
8
http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no3-1.htm











# get href
($e1S.Links.href).count
$i=0;$exeaddarray =@()
foreach ($e1 in $e1S)
{
   $exeaddarray[$i]=$e1.Links.href
   $i+=1
}



invoke-WebRequest -Uri "http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm"  | Out-File c:\temp\
	
$q1=




Invoke-WebRequest -Uri "http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/1-1-1/questiom/02.jpg" -OutFile c:\temp\02.jpg
                        http://eschool.hsjh.chc.edu.tw/~academ6/math/icon/test-classified/no1-1.jpg

$q.Links.href
$q.Images.src







####################################################################################################
##-------------------------------------------------------------------------------
##   990 考古題分類
##-------------------------------------------------------------------------------
###################################################################################################

function getjpgname     ($urlstring){     
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/103-special-questiom/103s-1-5.htm'
     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}  #得取JPG 檔名
function getjpgfullpath ($urlstring){     
     $a=$urlstring.indexof("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)




    return $yu
}
function gethtmName     ($urlstring){  
     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}  #得取 HTML 檔名
#ex  gethtmName  http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/answer/01.htm
function getlocalpath   ($urlk){  
     
     #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/1-1-1/questiom/1-5.htm'  #測試頁放這
                    

     # '  34  getlocalpath    '+$getlocalpath  |out-file c:\temp\listweb.txt  -Append

     $a=$urlk.Substring(45,($urlk.Length-45));#$a
     $char = '/';$result = 0..($a.length - 1) | ? {$a[$_] -eq $char};#$result
     
     switch (  ($result).count  )
     {
         '1' {  $f1=$a.Substring(0, $result[0] ) ;if (   !(test-path "C:\rosatree\$f1")   ) {  MD "C:\rosatree\$f1"  | Out-Null } ;$yu="C:\rosatree\$f1" }
         '2' {
               $f1=$a.Substring(0, $result[0] ) ;#$f1
               $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2 
               if (   !(test-path "C:\rosatree\$f1\$f2" )   ){    MD "C:\rosatree\$f1\$f2" | Out-Null }
                  $yu="C:\rosatree\$f1\$f2"
             }
         '3' {  
              $f1=$a.Substring(0, $result[0] ) ;#$f1
              $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2   
              $f3=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" | Out-Null  } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
         '4' {  
              $f1=$a.Substring(1, $result[1]-$result[0]-1 ) ;#$f1
              $f2=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f2   
              $f3=$a.Substring($result[2]+1, $result[3]-$result[2]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3"  | Out-Null } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
     }
     '    getlocalpath  line 1002  '+$yu  |out-file c:\temp\listweb.txt  -Append
    return $yu
}  #得取 HTML 路徑 ; 如無即新增
#ex getlocalpath http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/answer/01.htm
function getjpglocalpath   ($getlocalpath){  
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/icon/years-test/years-test90.jpg'         #1
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test103-105.htm'  #2
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105questiom/105-1-5.htm'#3
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/01.htm'       #4
    #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/1-1-5/questiom/10.jpg'

    # '  34  getlocalpath    '+$getlocalpath  |out-file c:\temp\listweb.txt  -Append

     $a=$getlocalpath.Substring(45,($getlocalpath.Length-45));#$a
     $char = '/';$result = 0..($a.length - 1) | ? {$a[$_] -eq $char};#$result
     
     switch (  ($result).count  )
     {
         '1' {  $f1=$a.Substring(0, $result[0] ) ;if (   !(test-path "C:\rosatree\$f1")   ) {  MD "C:\rosatree\$f1" } ;$yu="C:\rosatree\$f1" }
         '2' {
               $f1=$a.Substring(0, $result[0] ) ;#$f1
               $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2 
               if (   !(test-path "C:\rosatree\$f1\$f2" )   ){    MD "C:\rosatree\$f1\$f2" }
                  $yu="C:\rosatree\$f1\$f2"
             }
         '3' {  
              $f1=$a.Substring(0, $result[0] ) ;#$f1
              $f2=$a.Substring($result[0]+1, $result[1]-$result[0]-1 ) ;#$f2   
              $f3=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
         '4' {  
              $f1=$a.Substring(1, $result[1]-$result[0]-1 ) ;#$f1
              $f2=$a.Substring($result[1]+1, $result[2]-$result[1]-1 ) ;#$f2   
              $f3=$a.Substring($result[2]+1, $result[3]-$result[2]-1 ) ;#$f3 
                if (   !(test-path "C:\rosatree\$f1\$f2\$f3" )   ){    MD "C:\rosatree\$f1\$f2\$f3" } 
                $yu="C:\rosatree\$f1\$f2\$f3" 
             }
     }
     '  	119 (3) getjpglocalpath yu    '+$yu  |out-file c:\temp\listweb.txt  -Append
    return $yu
}  # 得取 JPG 路徑  如無即新增
function getJPG    ($htmlpage){
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/classified-no1-1.htm'         # test here測試頁放這
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/1-1-5/questiom/6-10.htm      # test here測試頁放這
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/119.htm'
    #start $htmlpage
    #'137   '+$htmlpage 
    $e1S=invoke-WebRequest $htmlpage  ; #start $htmlpage
    $jS=$e1S.Images.src;#$JS
    #ex: $j='10.jpg'
   foreach ($j in $jS)
     { #303
        #}#--
        #'144  '+$j
         if (  !($j.Contains('up.jpg')) )
                    {
        if ( $j.Contains('../icon/test-classified')   )
        { #105-1
             if ($j.Contains('up.jpg')   )
             {
                 
             }
             else
             {
             $srcpath ='http://eschool.hsjh.chc.edu.tw/~academ6/math/' + $j.Substring(3,($j.Length-3) ) ;#  start $srcpath
             $destfile=(getjpglocalpath $srcpath)+'\'+(gethtmName $srcpath) ;#start (getlocalpath $srcpath)
              '    		152 (4getJPG)   start   '+ $srcpath   |out-file c:\temp\listweb.txt -Append
              '    		152 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Append
               # '1&2' 
             }
        }  #105-1
        else
        {  #105-2
            if (  $j.Contains('answer.jpg')  )
            {  #120-1
                
                #'  167  not care'
            }  #120-1
            else
            {  #120-2
                if (  $htmlpage.Contains('questiom') )
                { #127-1
                  #  '   172 point'
                    $u1=$htmlpage.Substring(0,($htmlpage.LastIndexOf('/')))
                    $srcpath  = $u1+'/'+$j; #start $srcpath
                    $destfile=(getjpglocalpath $srcpath)+'\'+(gethtmName $srcpath) ;#start (getlocalpath $srcpath)
                    '    		169 (4getJPG)   start   '+ $srcpath  |out-file c:\temp\listweb.txt -Append
                    '    		169 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Append
                  #  'question'
                } #127-1
                else
                { #127-2
                    $u1=$htmlpage.Substring(0,($htmlpage.LastIndexOf('/')))
                    #$u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-6 ,6) ;#$u2 
                    $srcpath  = $u1+'/'+$j; #start $srcpath
                    $destfile=(getjpglocalpath $srcpath)+'\'+(gethtmName $srcpath) ;#start (getlocalpath $srcpath)
                    '    		179 (4getJPG)   start   '+ $srcpath  |out-file c:\temp\listweb.txt -Append
                    '    		179 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Append
                  #  'answer'
                } #127-2

            }  #120-2     


        }  #105-2

                     Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
                    }
        #'202  end'
    
  }    #303

}  # 下載此 URL 下的所有JPG

# ex: getJPG  http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/answer/01.htm

gps notepad | Stop-Process -Force 

if ((Test-Path C:\temp\listweb.txt )){ ri c:\temp\listweb.txt }

function getHTML ($htmlpage)
{  #166-0
    $htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/'  #主頁(MAIN)位置  years-test100-102.htm
    #$htmlpage=$htmlindex+'years-test100-102.htm';  start  $htmlpage       #測試 起頭頁(本頁) 在網路上是否OK.
    
    #'     ';$dt='';$ht=''
    '  142(1)  ' + $htmlpage  |out-file c:\temp\listweb.txt -Append
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/1-1-1/questiom/1-5.htm'         #測試頁放這
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/classified-no4-3.htm'         #測試頁放這

    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/02.htm'
    #start $htmlpage
    <#
    if ($htmlpage.Contains('questiom')){
       #$htmlpage.LastIndexOf('l/') 
       $u1=$htmlpage.Substring(52,5);#$u1
       $u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-8 ,8);#$u2   
    }
    if ($htmlpage.Contains('answer')){
       #$htmlpage.LastIndexOf('/') 
       $u1=$htmlpage.Substring(54,$htmlpage.LastIndexOf('/')-61);#$u1
       $u2=$htmlpage.Substring($htmlpage.LastIndexOf('/')-6 ,6) ;#$u2   
    }   
    
    '267'
    #>

    $dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 
    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage   
    #'271'                                         #  start $dt  下載起頭頁(本頁)JPGS
    #$u1;$u2
    

    $e1S=invoke-WebRequest $htmlpage ; # $e1S.Links.href  本頁中(this) 所有link ( this all link) ex :102questiom/102-1-5.htm
    #$hhcounti=($e1S.Links.href).count; $hhcount=$hhcounti
    foreach ($e1 in ($e1S.Links.href))  # 
    {  # 196 -1
    #}#--
    #'249' + $e1
        #$hhcount.tostring() +'   total: '+ $hhcounti.tostring()  ; $hhcount-=1
        if ( !($e1.Contains('examination.html'))  ) # 排除 this all link 不要下載
        {  #199-2
            
            if ($e1.Contains('answer/') ) # (this all link) 如有 
            { # 202-3.1
                #$e1  ; start $ht  http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/1-1-1/answer/05.htm
                #$e1.Substring(3,$e1.Length-3) 
               
                 $a=$htmlpage.Substring(61,($htmlpage.Length-61));#$a
                 $char = '/';$result = 0..($a.length - 1) | ? {$a[$_] -eq $char};#$result
                 $f11=$a.Substring(0,$result[0])
                $ht=$htmlindex+$f11+'/'+($e1.Substring(3,$e1.Length-3) )  ;# $ht
                $x1=getlocalpath $ht ; $x2=gethtmName $ht
                $dt= $x1+'\'+ $x2     ;# $dt

                #$dt=(getlocalpath $ht)+'\'+(gethtmName $ht)     ;# $dt11
                #'    248 (2)   start   '+ $htmlindex  |out-file c:\temp\listweb.txt -Append
                '    248 (2)   start   '+ $ht  |out-file c:\temp\listweb.txt -Append
                '    248 (2)   start   '+ $dt  |out-file c:\temp\listweb.txt -Append

                #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/01.htm
                #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/05.htm

                #$ht
            } # 202-3.1
            else
            { # 202-3.2  #  (this all link) 中的標準URL
                $ht=$htmlindex+$e1  ; #$ 主頁(MAIN)+ (this all link)
                $x1=getlocalpath $ht ; $x2=gethtmName $ht
                $dt= $x1+'\'+ $x2     ;# $dt
                #$dt=(getlocalpath  $ht)+'\'+(gethtmName $ht)  ; #$dt
                '    258 (2)   start   '+ $ht  |out-file c:\temp\listweb.txt -Append
                '    258 (2)   start   '+ $dt  |out-file c:\temp\listweb.txt -Append
            } # 202-3.2

               # '    189    start   '+ $ht  |out-file c:\temp\listweb.txt -Append
               # '    192    start   '+ $dt  |out-file c:\temp\listweb.txt  -Append

            Invoke-WebRequest -Uri $ht -OutFile   $dt  #  下載 (one of this all link) HTML檔  start $dt
            
            #sleep 3
            $ht + '   >> HTML 下載完成  :'#+$r.ToString()
            getJPG  $ht　　;#下載 (one of this all link) 下的所有JPG line  1044
            $ht + '    >> JPGs 下載完成'
            getHTML $ht   # recursive 
        } #199-2
        
    }  # 196-1
    #------------
    #start $ht

        
        
    
}  #166-0



#------------

$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/'
$testclassified=$htmlindex+'test-classified/classified.htm'  ; start $testclassified

getHTML $testclassified

#####
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/'
$htmlpage =$testclassified
$dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 測試下載起頭頁(本頁)在Local硬碟路徑

    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS

$e2S=invoke-WebRequest $htmlpage 
$cd=($e2S.Links.href).count;$cd #21
$xc = 0..$cd
## 先擷取所有 起頭頁(本頁) 之下的 Links 存入陣列之中.
$i = 0
foreach ($e2 in ($e2S.Links.href)) 
{
$xc[$i]=$e2
$i++
}
$xc[0];$xc[$cd-1];'Total :'+$cd.ToString() +'   Links  '
#####
 gps notepad | Stop-Process -Force 
 if ((Test-Path C:\temp\listweb.txt )){ ri c:\temp\listweb.txt }
 cls
$r=0
for ($i = 0 ; $i -lt $cd  ; $i++) #jul.31.stop in 33
{ 
$r=$i;$r ;$t1=get-date #$xc[$i]
  $getsubsite=$htmlindex+$xc[$i];$getsubsite
  '開始　'+　$getsubsite + '  中... 時間是  '+　$t1.tostring()
   getHTML $getsubsite
 }

 #####


   $getsubsite=$htmlindex+$xc[14];getHTML $getsubsite  ;#start $getsubsite 
ii  c:\temp\listweb.txt



14
http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/classified-no4-3.htm
開始　http://eschool.hsjh.chc.edu.tw/~academ6/math/test-classified/classified-no4-3.htm  中... 時間是  8/1/2016 10:31:14 AM
Invoke-WebRequest : 無法將 'System.Object[]' 轉換為 'OutFile' 參數所需的 'System.String' 型別。不支援指定的方法。
位於 線路:66 字元:65
+                      Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
+                                                                 ~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Invoke-WebRequest]，ParameterBindingException
    + FullyQualifiedErrorId : CannotConvertArgument,Microsoft.PowerShell.Commands.InvokeWebRequestCommand
 
