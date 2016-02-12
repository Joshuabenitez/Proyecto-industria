<?php
	include '../../../conexion/config.inc.php';
	
	$stringQuery = "SELECT No_Empleado, Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido FROM persona p INNER JOIN empleado e ON p.N_Identidad = e.N_Identidad 
                                        WHERE e.No_Empleado not in (SELECT No_Empleado FROM ca_empleados_proyectos)";
	$query = mysql_query($stringQuery);
	while($row = mysql_fetch_assoc($query)){
    	echo "<option value='".$row['No_Empleado']."'>".$row['Primer_nombre']." ".$row['Segundo_nombre']." ".$row['Primer_apellido']." ".$row['Segundo_apellido']."</option>";
 	}
?>