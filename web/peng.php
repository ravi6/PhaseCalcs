<?php
// Author: Ravi Saripalli
// header('Content-Type: application/json');
$fp = fopen("debug", "a+");

date_default_timezone_set('UTC');
$today = date('Y-m-d H:i:s');


fwrite($fp, "\n\n") ;
fwrite($fp, "===============================================\n") ;
fwrite($fp, "               " . $today . "                  \n") ;
fwrite($fp, "===============================================\n") ;

$query = $_SERVER['QUERY_STRING']; // get query string
fwrite($fp, ("Received:\n\t " . $query . "\n"));

$query = str_replace('%22','"', $query); // double quote translation
$query = json_decode($query) ;  // convert to array

$y = $query->y ; // gets into php array
$y = "[" . implode(", ", $y) . "]" ;  // now we have array as mat string
$bPmax = $query->bPmax ; // Bubble Curve Limit
$dPmax = $query->dPmax ; // Dew Curve Limit

//$cmd =  "octave " . "y=" . json_encode($y) ;
$cmd = "octave " . "-q --eval \" peng(" 
	. $y . ", " . $bPmax . ", " . $dPmax . ");\"" ;
fwrite($fp, ("SimCmd:\n\t " . $cmd . "\n"));


// Execute, parse results and send json back
$ans = system($cmd, $retval);             // execute and get last line 
fwrite($fp,("SimResult:\n\t" ."[". $retval ."]    " .   $ans . "\n"));

if (! $retval)
{
  // $ans = str_replace(",", "&", $ans);    
  //$ret = parse_str($ans, $resp);           // turns it into array
  //$response = json_encode($resp, JSON_PRETTY_PRINT) ; // array to json
  echo "done" ;  // stringifies and sends it back  (phew!!)
}
else {
	echo "failed" ;
};
  fclose($fp);

?>
