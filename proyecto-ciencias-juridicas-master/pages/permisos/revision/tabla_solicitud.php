 <?php 

 $maindir = "../../../";


 
require($maindir."conexion/config.inc.php");
	$idusuario= $_SESSION['user_id'];
	$rol = $_SESSION['user_rol'];
	
	if($rol == 30){
		$sql1="SELECT  Id_departamento FROM empleado where No_Empleado in (Select No_Empleado from usuario where id_Usuario='".$idusuario."')";
        $rec =$db->prepare($sql1);
        $rec->execute();
        $extraido=$rec->fetch();
		
		  $query= "Select permisos.id_Permisos, Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_Apellido, dias_permiso, 
			DATE_FORMAT(fecha,'%d-%m-%Y') as fecha, hora_inicio, hora_finalizacion, motivos.descripcion as mtd, permisos.estado,
			departamento_laboral.nombre_departamento from permisos inner join motivos on permisos.id_motivo=motivos.Motivo_ID 
			inner join empleado on empleado.No_Empleado=permisos.No_Empleado inner join persona on persona.N_identidad=empleado.N_identidad 
			inner join departamento_laboral on departamento_laboral.id_departamento_laboral = permisos.id_departamento where permisos.id_departamento = '".$extraido['Id_departamento']."' and
			permisos.estado = 'Espera' or permisos.estado = 'Aprobado' ORDER BY fecha asc";
			$consulta =$db->prepare($query);
            $consulta->execute();

			

	}else{
		if($rol == 50){
			$query ="Select permisos.id_Permisos, Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_Apellido, dias_permiso, 
			DATE_FORMAT(fecha,'%d-%m-%Y') as fecha, hora_inicio, hora_finalizacion, motivos.descripcion as mtd, permisos.estado,
			departamento_laboral.nombre_departamento from permisos inner join motivos on permisos.id_motivo=motivos.Motivo_ID 
			inner join empleado on empleado.No_Empleado=permisos.No_Empleado inner join persona on persona.N_identidad=empleado.N_identidad 
			inner join departamento_laboral on departamento_laboral.id_departamento_laboral = permisos.id_departamento 
			where permisos.estado = 'Espera' or permisos.estado = 'Aprobado' ORDER BY fecha asc";
			$consulta =$db->prepare($query);
            $consulta->execute();


			
		}
	}
?>




 <?php
            
			    echo <<<HTML
					<table id="tabla_Solicitudes" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th style='display:none'><strong>Permiso</strong></th>
								<th><strong> Nombre</strong></th>
								<!--<th><strong>Segundo Nombre</strong></th>
								<th><strong>Primer Apellido</strong></th>
								<th><strong>Segundo Apellido</strong></th>-->
								<th><strong>D&#237;as</strong></th>
								<th><strong>Fecha Solicitud</strong></th>
								<th><strong>Hora Inicio</strong></th>
								<th><strong>Hora Finalizaci&#243;n</strong></th>												
								<th><strong>Motivo</strong></th>
								<th><strong>Departamento</strong></th>
								<th><strong>Aprobar</strong></th>
								<th><strong>Denegar</strong></th>
								<th><strong>Exportar</strong></th>
							</tr>
						</thead>
						<tbody>
HTML;
               

               $rowcount=$consulta->rowCount();
  printf("Result set has %d rows.\n",$rowcount);
            while ($row = $consulta->fetch())  {
             
            $idP = $row['id_Permisos'];
            $pnombre = $row['Primer_nombre'];
			$snombre = $row['Segundo_nombre'];
			$papellido = $row['Primer_apellido'];
			$sapellido = $row['Segundo_Apellido'];
			$dias = $row['dias_permiso'];
			$fecha = $row['fecha'];
            $horaI = $row['hora_inicio'];
			$horaF = $row['hora_finalizacion'];			
			$motivo = $row['mtd'];
			$estado = $row['estado'];
			$Depto = $row['nombre_departamento'];
			
            
                echo "<tr  data-id='".$idP."'>";
                echo <<<HTML
                <td style='display:none'>$idP</td>

HTML;
                
                echo <<<HTML
                <td>
				
				$pnombre
			    $snombre 
				$papellido 
				$sapellido 
				
				
</td>
HTML;
    
                echo <<<HTML
                <td>$dias</td>
HTML;
                echo <<<HTML
                <td>$fecha</td>
HTML;
                echo <<<HTML
                <td>$horaI</td>
HTML;
                echo <<<HTML
                <td>$horaF</td>
HTML;
                echo <<<HTML
                <td>$motivo</td>
HTML;
                echo <<<HTML
                <td>$Depto</td>
HTML;
			   if($estado=="Espera" or $estado == "Visto"){
				echo<<<HTML
				<td><center>
					<button class="aprobarlo btn btn-primary glyphicon glyphicon-thumbs-up" data-toggle="modal" data-target="#Aprobar-modal"  title="Aprobar">
                </center></td>
HTML;
				}else{ echo <<<HTML
				<td><center>
					<button class="btn btn-default  glyphicon glyphicon-thumbs-up" disabled = "true" title="Aprobar">
                </center></td>
HTML;
				}
				
				if($estado=="Espera" or $estado == "Visto"){
				echo<<<HTML
				<td><center>
					<a class="open-Modal btn btn-primary" data-toggle="modal" data-id=$idP data-target="#compose-denegar"><i class="fa fa-edit"></i></a>
                </center></td>
HTML;
				}else{ echo <<<HTML
				<td><center>
					<a class="btn btn-default" data-toggle="modal" disabled = "true" data-target="#"><i class="fa fa-edit"></i></a>
                </center></td>
HTML;
				}
			    if($estado=="Aprobado"){
				echo<<<HTML
				<td><center>
					<button class=" Exportar btn btn-danger pull-right" data-mode="verPDF" data-id=$idP href="#">ExportarPDF</button>
                </center></td>
HTML;
				}else{
				echo<<<HTML
				<td><center>
					<button class="btn btn-default pull-right" disabled = "true">ExportarPDF</button>
                </center></td>
HTML;
				}
                echo "</tr>";

            }

             
            ?>