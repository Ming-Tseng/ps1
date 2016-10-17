
#---------------------------------------------
#  國中歷屆考題  90~ 105年
#---------------------------------------------
#最後可能是網路or Recursive 太多cycle.造成網路不明原因 當機.因此只好將第2層明細出來array. 再一一呼叫getHTML
如有中斷.再人工接續即可
如果有 資料夾名稱有 %20 ,去掉即可

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

#-------------------------------------------------------------------------------
#  國中歷屆考題
#-------------------------------------------------------------------------------


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
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/1-5.htm'
     #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/103-special-questiom/103s-30-31.htm'
     #$getlocalpath='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/105answer/05.htm'

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
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/102questiom/102-1-5.htm'         #1
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
    #''  |out-file c:\temp\listweb.txt -Append
    #'     ';$dt='';$ht=''
    #+'  142(1)  ' + $htmlpage  |out-file c:\temp\listweb.txt -Append
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test97-99.htm'         #1
    

    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/02.htm'
    #start $htmlpage

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
    $dt=(getlocalpath  $htmlpage)+'\'+(gethtmName $htmlpage)     ;# $dt 
    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt              #  start $dt  下載起頭頁(本頁)Html
    getJPG  $htmlpage                                            #  start $dt  下載起頭頁(本頁)JPGS
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
#{<#
共 42   subsite
$htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/'
$htmlpage ='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/years-test97-99.htm'
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



   $getsubsite=$htmlindex+$xc[28];getHTML $getsubsite  #http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/100-1questiom/100-1-6-10.htm
#>}

#---------------------------------------------
#---------------------------------------------
#  #years-test94-96.htm
#---------------------------------------------
#---------------------------------------------




#years-test90.htm

#---------------------------------------------
#---------------------------------------------
#  #years-test91-93.htm
#---------------------------------------------
#---------------------------------------------




#---------------------------------------------
#---------------------------------------------
#  #years-test90.htm
#---------------------------------------------
#---------------------------------------------




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

