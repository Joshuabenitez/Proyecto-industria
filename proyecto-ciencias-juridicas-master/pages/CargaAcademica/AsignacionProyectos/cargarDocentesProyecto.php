<?php
	include '../../../conexion/config.inc.php';
	
	$q = $_POST['q'];
	if($q > 0){
		$queryString = "SELECT No_Empleado, Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido,cod_rol_proyecto FROM 
						persona p INNER JOIN ca_empleados_proyectos e ON p.N_Identidad = e.dni_empleado where cod_proyecto=".$q;
		$query = mysql_query($queryString);
		while($row = mysql_fetch_assoc($query)){
			$cod_rol = $row['cod_rol_proyecto'];
			if($cod_rol == 1)
				$rol = " (Coordinador)";
			else 
				$rol = "";
	    	echo "<option value='".$row['No_Empleado']."'>".$row['Primer_nombre']." ".$row['Segundo_nombre']." ".$row['Primer_apellido']." ".$row['Segundo_apellido'].$rol."</option>";
     	}
	}
?>