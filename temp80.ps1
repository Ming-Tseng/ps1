 $htmlpage='http://eschool.hsjh.chc.edu.tw/~academ6/math/years-test/102questiom/102-1-5.htm'
  $e1S=invoke-WebRequest   $htmlpage ; #start $htmlpage
    $jS=$e1S.Images.src;#$JS

   foreach ($j in $jS)
     { #303
        #}#--
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
              '    		152 (4getJPG)   start   '+ $srcpath   |out-file c:\temp\listweb.txt -Append
              '    		152 (4getJPG)   start   '+ $destfile  |out-file c:\temp\listweb.txt -Appe
               # '1&2' 
             }
        }  #105-1
        else
        {  #105-2
            if (  $j.Contains('answer.jpg')  )
            {  #120-1
                
                #'not care'
            }  #120-1
            else
            {  #120-2
                if (  $htmlpage.Contains('questiom') )
                { #127-1
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


        #$srcpath ;$destfile
          
                     Invoke-WebRequest -Uri $srcpath -OutFile   $destfile
                    }
        
    
  }    #303