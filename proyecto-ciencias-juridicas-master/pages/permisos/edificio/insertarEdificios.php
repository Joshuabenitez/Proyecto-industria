<?php
   $maindir = "../../../"; 
   require($maindir ."conexion/config.inc.php");
   
	
	$edificio = $_POST['dedificio'];
	$query =  "INSERT INTO edificios(descripcion) VALUES('$edificio')";
	$rec =$db->prepare($query);
    $rec->execute();
    if ($rec) {
    	echo 1;
    } else {
        echo 5;
    }
    
?>