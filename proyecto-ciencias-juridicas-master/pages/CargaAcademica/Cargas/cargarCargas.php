<?php
	include '../../../conexion/config.inc.php';
	
	$queryString = "SELECT * FROM ca_cargas_academicas";

	$query = mysql_query($queryString);
	echo "<thead>
	                  <tr>   
	                      <th>Código</th>
	                      <th>Encargado</th>
	                      <th>Período</th>
	                      <th>Estado</th>
	                      <th></th>
	                  </tr>
	              </thead>
                  <tbody>";

	while($row = mysql_fetch_assoc($query)){
		$docente = obtenerDocente($row['no_empleado']);
		$estado = obtenerEstado($row['cod_estado']);
		$periodo = obtenerPeriodo($row['cod_periodo']);

		$nuevoRegistro =	"<tr>".
								"<td id='".$row['codigo']."'>".$row['codigo']."</td>".
								"<td id='".$row['no_empleado']."'>".$docente."</td>".
		          			 	"<td id='".$row['cod_periodo']."'>".$periodo."</td>".
		          			 	"<td id='".$row['cod_estado']."'>".$estado."</td>".
		          			 	// Botones
		          				"<td><a class='editar btn btn-info fa fa-pencil'></a>".
		              			"&nbsp;&nbsp;<a class='elimina btn btn-danger fa fa-trash-o'></a></td> ".
					      	"</tr></tbody>";

    	echo $nuevoRegistro;
	}

	function obtenerDocente($no_empleado){
		$queryString = "SELECT No_Empleado, Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido FROM 
						persona p INNER JOIN empleado e ON p.N_Identidad = e.N_Identidad where no_empleado='".$no_empleado."'";
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);
		return $row['Primer_nombre']." ".$row["Segundo_nombre"]." ".$row["Primer_apellido"]." ".$row["Segundo_apellido"];
	}

	function obtenerEstado($cod_estado){
		$queryString = "SELECT descripcion FROM 
						ca_estados_carga WHERE codigo =".$cod_estado;
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);		
		return $row['descripcion'];
	}

	function obtenerPeriodo($cod_periodo){
		$queryString = "SELECT nombre FROM 
						sa_periodos WHERE codigo =".$cod_periodo;
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);		
		return $row['nombre'];
	}
?>