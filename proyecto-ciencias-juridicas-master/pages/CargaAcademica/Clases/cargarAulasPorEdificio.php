<?php
	include '../../../conexion/config.inc.php';
	
	$q = $_POST['q'];
	if($q > 0){
		$queryString = "SELECT * FROM ca_aulas WHERE cod_edificio = ".$q;

		$query = mysql_query($queryString);
		echo "<option value=0> Seleccione una opción </option>";
		while($row = mysql_fetch_assoc($query))
	    	echo "<option value='".$row['codigo']."'>".$row['numero_aula']."</option>";
	}
	else
		echo "<option value=0> Seleccione una opción </option>";
?>