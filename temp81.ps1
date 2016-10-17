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
function gethtmljpg ($htmlpage)
{
   #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/classified.htm'
   $htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
   #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm'
   $htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/questiom/1-5.htm'
   #$htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/02.htm'
   $htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/1-1-1/answer/14.htm'
    #$w=1
    '150 '+ $htmlpage  |out-file C:\rosatree\log.txt -Append

    $dt=(getlocalpath  $htmlpage) + '\' + (gethtmName  $htmlpage)  ;$dt; ii (getlocalpath  $htmlpage)
    Invoke-WebRequest -Uri $htmlpage -OutFile   $dt  # ii $dt 

    $e1S=invoke-WebRequest $htmlpage  ; #start $htmlpage
    $jS=$e1S.Images.src;$JS

    #  ---start download  this level jpg
    foreach ($j in $jS){ #161 foreach
    #}
    #$j='27.jpg'
    if ( ($j).Length -eq 6)
    { # if 169

        if (  $j.contains("answer/") )
        {
            
        }
        else
        {
            
        }

         $urlsite= $htmlpage.Substring(0, $htmlpage.LastIndexOf('/')+1   );$urlsite
         $srcpath =$urlsite +$j  ; $srcpath

         $destpath=getlocalpath $srcpath
         $destfile=$destpath+'\'+(getjpgname $j)  ;#ii $destpath 








    }  # if 169
    else
    {   # if 169
            $srcpath =$urlsite +(getjpgfullpath $j)  ; $srcpath
            $destfile=$destpath+'\'+(getjpgname $j)  ;#ii $destpath  
    }   # if 169







    if ( !($j.contains("answer")) -or !($j.contains("up")) )
    {
       Invoke-WebRequest -Uri $srcpath -OutFile   $destfile   
    }
    
    
   
    } #161 foreach

    #  ---start download  this level jpg

    if ( (($e1S.Links.href).count)  -gt 1)
    { #if 152
        #$hS=$e1S.Links.href
        foreach ($h in ($e1S.Links.href))
        {
              $w+=1
              $ht=$exeaddM+$h; "$w; 168 " + $ht |out-file C:\rosatree\log.txt -Append
              gethtmljpg  $ht
        }
    }  #if 152

}
gethtmljpg $exeadd 
ii  C:\rosatree\log.txt

ii  C:\rosatree\log.txt

gps notepad | Stop-Process -Force
ri c:\temp\listweb.txt
function getHTML ($htmlpage)
{
    $htmlindex='http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/'
    #''  |out-file c:\temp\listweb.txt -Append
    $htmlpage  |out-file c:\temp\listweb.txt -Append
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
    $u1;$u2

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
               $hname=$e1.Substring( $e1.LastIndexOf('/')+1,($e1.Length)-($e1.LastIndexOf('/'))-1)   
               $ht=$htmlindex+$u1+'/questiom/'+ $hname   ;#start $ht  
            }
            else
            {
              $ht=$htmlindex+$e1  
            }     
        }
        #'htm=  '+$ht  |out-file c:\temp\listweb.txt
        $ht  |out-file c:\temp\listweb.txt -Append

        $dt=(getlocalpath  $ht) + '\' + (gethtmName  $ht)  ;#start $dt
        $dt  |out-file c:\temp\listweb.txt  -Append
        #Invoke-WebRequest -Uri $ht -OutFile   $dt  #  start $dt
        
        #getJPG $ht
        
        getHTML $ht
    }
}

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



$xc

'
classified-no1-1.htm
classified-no1-2.htm
classified-no1-3.htm
classified-no2-1.htm
classified-no2-2.htm
classified-no2-3.htm
classified-no2-4.htm
classified-no2-5.htm
classified-no3-1.htm

'



function Get-MyADGroupMember ($GroupName) {
     $Members = (Get-ADGroupMember -Identity $GroupName).samAccountName
    foreach ($Member in $Members) {
        try {
            Write-Host "[$Member] is a member of group [$GroupName]"
            ## Test to see if the group member is a group itself
            if (Get-ADGroup -Identity $Member) {
                Get-MyADGroupMember -GroupName $Member
            }
        } catch {
  
        }
    }
}



md 


Start-Process  $urlpage

 http://eschool.hsjh.chc.edu.tw/~academ6/math/1984.htm

 | Out-File $destf1 ; 


invoke-WebRequest -Uri "http://eschool.hsjh.chc.edu.tw/~academ6/math/t cool/classified-no1-1.htm"  | Out-File c:\temp\
	
$q1=




Invoke-WebRequest -Uri "http://eschool.hsjh.chc.edu.tw/~academ6/math/t%20cool/1-1-1/questiom/02.jpg" -OutFile c:\temp\02.jpg
                        http://eschool.hsjh.chc.edu.tw/~academ6/math/icon/test-classified/no1-1.jpg

$q.Links.href
$q.Images.src