<?php

// load ZabbixApi
require 'ZabbixApi.class.php';

$password  =getenv("ZABBIX_PASSWORD");
$hostname  =getenv("HOST");
$zabbixkey =getenv("KEY");
$time_range=getenv("RANGE");

    // connect to Zabbix API
$api = new ZabbixApi('http://localhost/zabbix/api_jsonrpc.php', 'admin', $password);
// use extended output for all further requests
$api->setDefaultParams(array(
    'output' => 'extend'
));

$host = $api->hostGet(array(
    "filter" => array( $hostname ) 
));

if(count($host)!=1){
    throw new Exception("host query returned 2 or more host.");
}

$item = $api->itemGet(array(
    "filter" => array("key_" => $zabbixkey)  ,
    "hostids" => $host[0]->hostid
));
if(count($item)!=1){
    throw new Exception("item query returned 2 or more host.");
}

$history = $api->historyGet( array (
    'history' => $item[0]->value_type ,
    'sortfield' => array('itemid','clock'),
    'itemids' => $item[0]->itemid ,
    'time_from' => time() - (int)$time_range 
));

echo "'$hostname $zabbixkey'\n";

foreach($history as $hist){
    echo $hist->value;
    echo "\n";
}

?>
