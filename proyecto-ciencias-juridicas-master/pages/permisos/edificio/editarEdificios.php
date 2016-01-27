<?php
	

	$maindir = "../../../"; 
	
    require($maindir ."conexion/config.inc.php");
	$id = $_POST['Edificio_ID'];
	$desc = $_POST['dedificio'];
		 
	$query="update edificios set descripcion = '$desc' where Edificio_ID = '$id';";
	
    $rec =$db->prepare($query);
    $rec->execute();
    if ($rec) {
    	echo 1;
    } else {
    	echo 5;
    }

	
	
?>