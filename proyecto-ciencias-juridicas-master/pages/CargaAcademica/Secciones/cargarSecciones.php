<?php
	include '../../../conexion/config.inc.php';
	
	echo "<thead>
	                  <tr>   
	                      <th>Sección</th>
	                      <th>Hora de Inicio</th>
	                      <th>Hora de Fin</th>
	                      <th></th>
	                  </tr>
	              </thead>
                  <tbody>";

	$queryString = "SELECT * FROM ca_secciones";

	$query = mysql_query($queryString);

	while($row = mysql_fetch_assoc($query)){
		$nuevoRegistro =	"<tr>".
								"<td id='".$row['codigo']."'>".$row['codigo']."</td>".
								"<td id='".$row['hora_inicio']."'>".$row['hora_inicio']."</td>".
		          			 	"<td id='".$row['hora_fin']."'>".$row['hora_fin']."</td>".
		          			 	// Botones
		          				"<td>".
		              			"&nbsp;&nbsp;<a class='elimina btn btn-danger fa fa-trash-o'></a></td> ".
					      	"</tr></tbody>";

    	echo $nuevoRegistro;
	}
?>