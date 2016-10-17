#Get-ExecutionPolicy
#---------------------------------------------
#  題庫補充   
#---------------------------------------------
$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
#$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
#$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-2/questiom/1-5.htm' ;
#$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/6-10.htm' ;

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
function gethtmName     ($urlstring){  
     $a=$urlstring.lastindexofany("/")+1
     $b=$urlstring.Length
     $yu=$urlstring.Substring($a,$b-$a)
    return $yu
}
function getlocalpath   ($getlocalpath){  
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/1-5.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
     #$urlstring='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-2/questiom/1-5.htm'
     '  34  getlocalpath    '+$getlocalpath  |out-file c:\temp\listweb.txt  -Append

     $a=$getlocalpath.Substring(45,($getlocalpath.Length-45));#$a
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
     '  56  yu    '+$yu  |out-file c:\temp\listweb.txt  -Append
    return $yu
}
function getJPG         ($htmlpage){
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
        if (  !($srcpath.Contains('up.jpg')) )
{
    Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
}
        
    
  }    #303

   

   
}


gps notepad | Stop-Process -Force
ri c:\temp\listweb.txt
function getHTML ($htmlpage)
{
    $htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/'
    #''  |out-file c:\temp\listweb.txt -Append
    #'  142'
    '  142  ' + $htmlpage  |out-file c:\temp\listweb.txt -Append
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified.htm'
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-2/questiom/1-5.htm' ;
    #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/6-10.htm' ;

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
    #$u1;$u2

    $e1S=invoke-WebRequest $htmlpage ;#$e1S.Links.href  
    foreach ($e1 in ($e1S.Links.href))
    {
        if ($e1.Contains('answer/'))  #../answer/18.htm
        {
            $hname=$e1.Substring( $e1.LastIndexOf('/')+1,($e1.Length)-($e1.LastIndexOf('/'))-1)   
            $ht=$htmlindex+$u1+'/answer/'+ $hname   ;#start $ht    
           # getHTML  $ht
        }
        else{
            if ($e1.Contains('questiom/'))
            {
                
                    
                    $u1=$e1.Substring(0,$e1.LastIndexOf('/questiom/') );#$u1
       
               
               $hname=$e1.Substring( $e1.LastIndexOf('/')+1,($e1.Length)-($e1.LastIndexOf('/'))-1)   
               $ht=$htmlindex+$u1+'/questiom/'+ $hname   ;#start $ht  
            }
            else
            {
              $ht=$htmlindex+$e1  
            }     
        }
        #'htm=  '+$ht  |out-file c:\temp\listweb.txt
        '    189    start   '+ $ht  |out-file c:\temp\listweb.txt -Append

        $dt=(getlocalpath  $ht)+'\'+(gethtmName $ht)  ; $dt
        '    192    start   '+$dt  |out-file c:\temp\listweb.txt  -Append
        Invoke-WebRequest -Uri $ht -OutFile   $dt  #  start $dt
        
        getJPG $ht
        
        getHTML $ht
    }
}



getHTML $htmlpage 


ii c:\temp\listweb.txt

