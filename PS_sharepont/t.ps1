$t0 = get-date;
#$t1 = [datetime] "5:10 PM";$t1 =  ($t0).AddMinutes(1)
#$t2 = [datetime] "5:12 PM";$t2 =  ($t0).AddMinutes(3)

$t1 =  (get-date).AddMinutes(1)
$t2 =  (get-date).AddMinutes(3)
$r=$false 
#get-date;$t1;$t2

<#
if ($t0 -ge $t1 )
{"t0"+($t0).ToString()}
else
{'t1' }
#>

while ($t2 -ge $t0 ) {

  if($t0 -ge $t1  -and $r=$false ){get-date |Out-File H:\scripts\while.txt -Append ; $r=$true}

$t0 =get-date;  "t0 is  " + ($t0).ToString()

#$t0 =$t0.AddSeconds(1);  "t0 is  " + ($t0).ToString()
}
#/

<#
#get-date -displayhint time


#get-date;(get-date).AddMinutes(10)


#get-date;(get-date).AddSeconds(1)
#>