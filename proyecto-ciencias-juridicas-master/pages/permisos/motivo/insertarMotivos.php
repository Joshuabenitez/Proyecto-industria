<?php
	
   $maindir = "../../../"; 
   require($maindir ."conexion/config.inc.php");
	$motivo =  $_POST['dmotivo'];	
	$query = "INSERT INTO motivos(descripcion) VALUES ('$motivo')";
	$rec =$db->prepare($query);
    $rec->execute();
    if ($rec) {
    	echo 1;
    } else {
        echo 5;
    }
    
	
?>