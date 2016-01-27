<?php  
	session_start();
	$user_ID = $_SESSION['user_id'];
	include '../conexion/config.inc.php';
	$query = "UPDATE usuario SET esta_logueado = 0 where usuario_ID = '".$user_ID."' ;";
	$result = mysql_query($query, $conexion) or die("error en la consulta");
	$_SESSION = array();
	session_destroy();
?>