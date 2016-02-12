
<?php

error_reporting(E_ALL ^ E_DEPRECATED);

 $host = 'mysqlv115';
 $dbname = 'ccjj';
 $username = 'ddvderecho';
 $password = 'DDVD3recho';
 $conexion = mysql_connect($host, $username, $password);
 mysql_select_db($dbname);

?> 
