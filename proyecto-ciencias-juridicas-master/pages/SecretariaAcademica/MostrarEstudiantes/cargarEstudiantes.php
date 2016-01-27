<?php
	include ('../../../conexion/config.inc.php');
	
	$queryString = "SELECT * FROM sa_estudiantes";

	$query = mysql_query($queryString);
	echo "<thead>
	                  <tr>   
	                      <th>Cuenta</th>
	                      <th>Identidad</th>
	                      <th>Estudiante</th>
	                      <th>Correo</th>
	                      <th>Indice</th>
	                      <th>Mención Honorífica</th>
	                      <th>Solicitudes</th>
	                      <th></th>
	                  </tr>
	              </thead>
                  <tbody>";

	while($row = mysql_fetch_assoc($query)){
		$estudiante = obtenerEstudiante($row['dni']);
		$correo = obtenerCorreo($row['dni']);
		$mencion = obtenerMencion($row['dni']);
    	$solicitudes = obtenercantidadSolicitudes($row['dni']);

		$nuevoRegistro =	"<tr>".
								"<td id='".$row['no_cuenta']."'>".$row['no_cuenta']."</td>".
								"<td id='".$row['dni']."'>".$row['dni']."</td>".
		          			 	"<td id='".$row['no_cuenta']."'>".$estudiante."</td>".
		          			 	"<td id='".$row['dni']."'>".$correo."</td>".
		          			 	"<td id='".$row['indice_academico']."'>".$row['indice_academico']."</td>".
		          			 	"<td id='".$mencion."'>".$mencion."</td>".
		          			 	"<td id='".$solicitudes."'>".$solicitudes."</td>".
		          			 	// Botones
		          				"<td><a data-no_cuenta = '".$row['no_cuenta']."' class='edit_estudiante btn btn-info fa fa-pencil'></a>".
		              			"&nbsp;&nbsp;<a class='elimina btn btn-danger fa fa-trash-o'></a></td> ".
					      	"</tr></tbody>";

    	echo $nuevoRegistro;
	}

	function obtenerEstudiante($dni){
		$queryString = "SELECT Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido FROM 
						persona p INNER JOIN sa_estudiantes e ON p.N_Identidad = e.dni WHERE e.dni = '".$dni."'";
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);
		return $row['Primer_nombre']." ".$row["Segundo_nombre"]." ".$row["Primer_apellido"]." ".$row["Segundo_apellido"];
	}

	function obtenerCorreo($dni){
		$queryString = "SELECT correo from sa_estudiantes_correos where dni_estudiante ='".$dni."'";
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);		
		return $row['correo'];
	}

	function obtenerMencion($dni){
		$queryString = "SELECT descripcion FROM sa_menciones_honorificas WHERE codigo in (SELECT cod_mencion FROM sa_estudiantes_menciones_honorificas WHERE dni_estudiante ='".$dni."')";
		
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);		
		return $row['descripcion'];
	}

	function obtenercantidadSolicitudes($dni){
		$queryString = "SELECT COUNT(*) AS cuenta FROM sa_solicitudes WHERE dni_estudiante ='".$dni."'";
		
		$query = mysql_query($queryString);
		$row = mysql_fetch_assoc($query);		
		return $row['cuenta'];
	}
?>

