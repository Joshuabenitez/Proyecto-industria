<?php
	require_once '../../../conexion/config.inc.php';
	
	$queryString = "SELECT * FROM ca_cursos";

	$query = mysql_query($queryString);
	echo "<thead>
	                  <tr>   
	                      <th>Código</th>
	                      <th>Carga</th>
	                      <th>Asignatura</th>
	                      <th>Docente</th>
	                      <th>Días</th>
	                      <th>Sección</th>
	                      <th>Edificio</th>
	                      <th>Aula</th>
	                      <th>Cupos</th>
	                      <th></th>
	                  </tr>
	              </thead>
                  <tbody>";

	while($row = mysql_fetch_assoc($query)){
		$docente = obtenerDocente($row['no_empleado']);
		$arrayDias = obtenerDias($row['codigo']); 
		$dias = implode(",", $arrayDias);
		$edificio = obtenerEdificio($row['cod_aula']);
		$cod_edificio = obtenerCodEdificio($row['cod_aula']);
		$aula = obtenerAula($row['cod_aula']);
    	

		$nuevoRegistro =	"<tr>".
								"<td id='".$row['codigo']."'>".$row['codigo']."</td>".
								"<td id='".$row['cod_carga']."'>".$row['cod_carga']."</td>".
		          			 	"<td id='".$row['cod_asignatura']."'>".$row['cod_asignatura']."</td>".
		          			 	"<td id='".$row['no_empleado']."'>".$docente."</td>".
		          			 	"<td id='".$dias."'>".$dias."</td>".
		          			 	"<td id='".$row['cod_seccion']."'>".$row['cod_seccion']."</td>".
		          			 	"<td id='".$cod_edificio."'>".$edificio."</td>".
		          			 	"<td id='".$row['cod_aula']."'>".$aula."</td>".
		          			 	"<td id='".$row['cupos']."'>".$row['cupos']."</td>".
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

	function obtenerDias($cod_curso){
            $dias = array();
            $queryString = "SELECT cod_dia from ca_cursos_dias where cod_curso =".$cod_curso;
            $query = mysql_query($queryString);

            while($row = mysql_fetch_assoc($query)){
                    switch ($row['cod_dia']) {
                            case 1: array_push($dias,"lun");break;
                            case 2: array_push($dias,"mar");break;
                            case 3: array_push($dias,"mier");break;
                            case 4: array_push($dias,"ju");break;
                            case 5: array_push($dias,"vi");break;
                            case 6: array_push($dias,"sa");break;
                            default:
                                    echo "ERROR AL OBTENER DÏAS";
                                    break;
                    }
            }

            return $dias;
	}

	function obtenerEdificio($cod_aula){
            global $db;
            $cod_aula = (int)$cod_aula;
            $queryString = $db -> prepare("SELECT descripcion FROM edificios where Edificio_ID in (select cod_edificio from ca_aulas where codigo =".$cod_aula.")");
            $queryString -> execute();
            $row = $queryString -> fetch(PDO::FETCH_ASSOC);		
            return $row['descripcion'];
	}

	function obtenerCodEdificio($cod_aula){
            global $db;
            $cod_aula = (int)$cod_aula;
            $queryString = $db -> prepare("SELECT cod_edificio FROM ca_aulas WHERE codigo =".$cod_aula);
            $queryString -> execute();
            $row = $queryString -> fetch(PDO::FETCH_ASSOC);		
            return $row['cod_edificio'];
	}

	function obtenerAula($cod_aula){
            global $db;
            $cod_aula = (int)$cod_aula;
            $queryString = $db -> prepare("SELECT numero_aula FROM ca_aulas where codigo =".$cod_aula);
            $queryString -> execute();
            $row = $queryString -> fetch(PDO::FETCH_ASSOC);
            return $row['numero_aula'];
	}
?>