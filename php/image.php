<?php
#header('Content-type: image/jpg');
$param = $_SERVER["QUERY_STRING"];
preg_match("/(.*)=(.*)/",$param, $ps_a);
preg_match("/.*\/(\w+)\.(\w+)$/",$param, $ps_b);
$requestUrl = $ps_a[2];
#$requestUrl = 'http://pic.hxcdn.net/www/images/NOVELADMINIMAGES/20120726100943.jpg';

##$ch = curl_init();
##$timeout = 1;
##curl_setopt ($ch, CURLOPT_URL, $requestUrl);
##curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
##curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
###curl_setopt($ch, CURLOPT_PROXYAUTH, CURLAUTH_BASIC);
##curl_setopt($ch, CURLOPT_PROXY, "10.11.157.27");
##curl_setopt($ch, CURLOPT_PROXYPORT, 8741);
##
##//curl_setopt($ch, CURLOPT_PROXYUSERPWD, ":");
##
##curl_setopt($ch, CURLOPT_PROXYTYPE, CURLPROXY_HTTP);
##
##$file_contents = curl_exec($ch);
##curl_close($ch);
##echo $file_contents;
##
##$request = $ps_b[1]. "." .$ps_b[2];
##

$url = $requestUrl;
$L = explode(".",$url);
$type = strtolower($L[count($L)-1]);
if( in_array($type,array("jpg","jpeg","gif","ico","bmp","tif",'png')) ==false )
{
        $type = 'jpeg';
}
if ($type == 'jpg') {
        $type = 'jpeg';
}
$data = file_get_contents($url);

header("Content-Type: image/$type");
header('Content-Length: '.strlen($data));
print $data

#echo $request;

#file_put_contents($request, $file_contents);

#$handle=fopen($request, "w");
#fwrite($handle, $file_contents);
#fclose($handle);

?>

