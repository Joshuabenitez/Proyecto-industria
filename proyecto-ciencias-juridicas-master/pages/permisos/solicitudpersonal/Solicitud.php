<?php
//Este codigo hace una validación de la sesión del usuario y del tiempo que esta lleva inactiva, para proceder a cerrarla
$maindir = "../../../";

if (isset($_GET['contenido'])) {
    $contenido = $_GET['contenido'];
} else {
    $contenido = 'gestion_de_folios';
}

require_once($maindir . "funciones/check_session.php");

require_once($maindir . "funciones/timeout.php");
?>

<?php
	//Esta seccion obtiene el nombre de usuario que ha iniciado sesión y lo guarda en una variable
	
    if(!isset( $_SESSION['user_id'] ))
  {
    header('Location: '.$maindir.'login/logout.php?code=100');
    exit();
  }else
  {

    $idusuario = $_SESSION['user_id'];
  }
   
	
	require($maindir."conexion/config.inc.php");
    $sql="select departamento_laboral.nombre_departamento from departamento_laboral where Id_departamento_laboral in( SELECT Id_departamento FROM empleado where No_Empleado in (Select No_Empleado from usuario where id_Usuario='$idusuario'))";
    $rec =$db->prepare($sql);
    $rec->execute();
    $row = $rec->fetch();
	//$conexion = mysqli_connect($host, $username, $password, $dbname);
	//$rec = mysqli_query($conexion, "select departamento_laboral.nombre_departamento from departamento_laboral where Id_departamento_laboral in( SELECT Id_departamento FROM empleado where No_Empleado in (Select No_Empleado from usuario where id_Usuario='$idusuario'))");
	//$row = mysqli_fetch_array($rec);
	//consulta datos del empleado
	$sql1="Select Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_Apellido,empleado.No_Empleado from persona 
			inner join empleado on persona.N_identidad=empleado.N_identidad
			where empleado.No_Empleado in (select usuario.No_Empleado from usuario where usuario.id_Usuario='".$idusuario."')";
    $rec =$db->prepare($sql1);
    $rec->execute();
    $row7 = $rec->fetch();
    // $rec7 = mysqli_query($conexion, "Select Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_Apellido,empleado.No_Empleado from persona 
	//		inner join empleado on persona.N_identidad=empleado.N_identidad
	//		where empleado.No_Empleado in (select usuario.No_Empleado from usuario where usuario.id_Usuario='".$idusuario."')");												
	//$row7= mysqli_fetch_array($rec7);
	//consulta de cantidad de Dias en el mes 
	$sql4="Select COUNT(permisos.id_Permisos)
	as Solicitudes from permisos where No_Empleado= '".$row7['No_Empleado']."' and MONTH(fecha )= MONTH(NOW()) and YEAR(fecha)=YEAR(NOW())
	 and estado='Aprobado'" ;
//	$Solicitudes_mes= mysqli_query($conexion, "Select COUNT(permisos.id_Permisos)
//	as Solicitudes from permisos where No_Empleado= '".$row7['No_Empleado']."' and MONTH(fecha )= MONTH(NOW()) and YEAR(fecha)=YEAR(NOW())
//	 and estado='Aprobado'" );
    $rec =$db->prepare($sql4);
    $rec->execute();
    $row_solicitud = $rec->fetch();


	//$row_solicitud = mysqli_fetch_array($Solicitudes_mes);

	
	//$result = mysqli_query($conexion, "SELECT No_Empleado FROM usuario  where id_Usuario='$idusuario'");
	//$row2 = mysqli_fetch_array($result);
	
	//$fquery = mysqli_query($conexion, "select fecha_solicitud, DATE_FORMAT(fecha, '%Y-%m-%d') from permisos inner join usuario on permisos.No_Empleado=usuario.No_Empleado where usuario.No_Empleado='".$row2['No_Empleado']."'");
	//$frow = mysqli_fetch_array($fquery);
?> 


<!--Las siguientes dos líneas hacen referencia a un par de archivos javascript que permite la utilizacion de algunas librerías -->
<!--<script type="text/javascript" src="../SistemaCienciasJuridicas/js/jquery-2.1.3.js"></script>-->
<script language="javascript" type="text/javascript">


    var f = new Date();
    var $fecha_a = (f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear()); //Este codigo obtiene los elementos de la fecha actual del sistema

  
//Esta función se realiza cuando el documento ya esta listo
    $(document).ready(function() {

        $("form").submit(//Se realiza cuando se ejecuta un "submit" en el formulario, el "submit" se encuentra en el boton "Envíar Solicitud"
		             
						function(e) {

							e.preventDefault();
								data = {
									idusuario: "<?php echo $idusuario; ?>",
									nombre: $('input:text[name=nombre]').val(),
									area: "<?php echo $row['nombre_departamento']?>",
									motivo: $('select[name=motivo]').val(),
									edificio: $('select[name=edificio]').val(),
                  jefe: $('select[name=jefe]').val(),
									horaf: $("#horaf").val(),
									horai: $("#horai").val(),
									fecha: $("#fecha").val(),
									cantidad: $("#cantidad").val(),
									fecha_solic: $fecha_a,
                  tipoPermiso: $('select[name=tipoDePermiso]').val()
								};  //la seccion de codigo anterior almacena en un conjunto data las variables que 
								//la funcion enviara para que se ejecute la consulta en el archivo php
							$.ajax({
								async: true,
								type: "POST",
								 dataType: "html",
								// contentType: "application/x-www-form-urlencoded",
								url: 'pages/permisos/solicitudpersonal/Isolicitud.php',
							    beforeSend:function()
                                {
                                 $(".alert").remove();
                                  var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>cargando ..............</div>';
                                 $("#proceso").append(me); 


                                },
                                success: function(response)
								                {
                                   $dato=response.trim();

                                   if ($dato==1) 
                                   	{    $("#contenedor").empty();
                                   		$("#contenedor").load('pages/permisos/solicitudpersonal/Solicitud.php?errores='+$dato);


                                   	} 
                                   	else
                                   		{ if ($dato==2) 
                                   			{
                                   				$(".alert").remove();
                                                 var me='<div class="alert alert-danger  alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Error !!  </strong>Ya tiene una solicitud de permiso con la fecha ingresada</div>';
                                                 $("#proceso").append(me);


                                   			} 
                                   			else
                                   				{
                                   					if ($dato==3)
                                   					 {
                                   					 	$(".alert").remove();
                                                        var me='<div class="alert alert-danger  alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Error !!  </strong>Solamente puede realizar una solicitud por día</div>';
                                                        $("#proceso").append(me);



                                   					 } else
                                   					 { if ($dato==4) 
                                   					 	{
                                   					 		$(".alert").remove();
                                                            var me='<div class="alert alert-danger  alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Error !! </strong>Hay traslape de fechas con una solicitud previa</div>';
                                                             $("#proceso").append(me);



                                   					 	} else
                                   					 	{
                                   					 		$(".alert").remove();
                                                            var me='<div class="alert alert-danger  alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Error !!   </strong>'+dato+'</div>';
                                                            $("#proceso").append(me);


                                   					 	};




                                   					 };


                                   				};


                                   		};

								},
								data: data,
								timeout: 4000,
								error: function(result)
								{
                                    $(".alert").remove();
                                    var me='<div class="alert alert-success" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong> '+ result.status + ' ' + result.statusText+'</strong></div>';
                                    $("#proceso").append(me);
									
								}
							}); //La función implemente ajax para enviar la información a otros 
							//documentos que realizaran otros procedimientos sin necesidad de refrescar toda la pagina
							return false;
						}
						
		
		);
    });

    



</script>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">

<!--<script type="text/javascript" src="../sl/jquery-2.1.3.js"></script>
<script language="javascript" type="text/javascript"></script>-->
         <link href="css/bootstrap.min.css" rel="stylesheet">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
    </head>

    <body>
    	<?php 
    	if(isset($_GET['errores']))
            {
       $accion = $_GET['errores'];
        switch ($accion) 
        {
            case 1:
            $mensaje = "Solicitud ingresada Exitosamente...........................";
                echo '<div class="alert alert-success alert-error">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <strong> Success! </strong>'.$mensaje.'</div>';
                
                break;
           
            default:
                break;
        }
           }


    	 ?>

    	<div id="proceso">

    	</div>

       
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Solicitud</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Llene los campos con la información solicitada
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form id="formulario">
                                       
										<div class="form-group">
                                       

												   <?php
													
													echo " <h5><label>Nombre :  </label>";
													echo " ";
													echo strtoupper ($row7['Primer_nombre']);
													echo " ";
													echo strtoupper ($row7['Segundo_nombre']);
													echo " ";
													echo strtoupper ($row7['Primer_apellido']);
													echo " ";
													echo strtoupper ($row7['Segundo_Apellido']);
																									
													
                                                ?>

                                        </div>

                                        <div color: 'black' class="form-group" >
										<?php
											echo "<h5>";
											echo "<label>Departamento:</label>";
											echo " ";
												echo strtoupper ($row['nombre_departamento']);
												echo "</h5>";

										?>											
                                        </div>
											  <div>										 
											
													<?php
											echo "<h5>";
											echo "<label>Días aprobados este mes:</label>";
											echo " ";
												echo strtoupper ($row_solicitud['Solicitudes']);
												echo "</h5>";

													?>	
                                            
											</div>
                                        <div class="form-group">
                                            <label>Solicito permiso por motivo de :</label>
                                            <select class="form-control" Id="motivo" name="motivo">


											<?php
											/* Este codigo jala los datos que hay en la tabla de motivos y los muestra en el 
											  combobox */
											     $ql2="SELECT descripcion from motivos";
											     $rec2 =$db->prepare($ql2);
                                                 $rec2->execute();
                                                 
												while ($row = $rec2->fetch()) {
													echo "<option>";
													echo $row['descripcion'];
													echo "</option>";
												}
											?>
											</select>                                       
                                        </div>
                        <div class="form-group">
                                            <label>Tipo De Permiso :</label>
                                            <select class="form-control" Id="tipoDePermiso" name="tipoDePermiso">


                      <?php
                      /* Este codigo jala los datos que hay en la tabla de motivos y los muestra en el 
                        combobox */
                           $ql2="SELECT tipo_permiso from tipodepermiso";
                           $rec2 =$db->prepare($ql2);
                                                 $rec2->execute();
                                                 
                        while ($row = $rec2->fetch()) {
                          echo "<option>";
                          echo $row['tipo_permiso'];
                          echo "</option>";
                        }
                      ?>
                      </select>                                       
                                        </div>
										
                                        <div class="form-group">
                                            <label>Edificio donde tiene registrada su asistencia :</label>
                                            <select class="form-control" Id="edificio" name="edificio">
                                                <?php
                                                    $sql3="SELECT descripcion from edificios";
                                                    $rec2 =$db->prepare($sql3);
                                                    $rec2->execute();
													
                                                    while ($row = $rec2->fetch()) {
                                                            echo "<option>";
                                                            echo $row['descripcion'];
                                                            echo "</option>";
                                                    }
													
                                                ?>
                                            </select>                                       
                                        </div>
                                        <div class="form-group">
                                            <label>Jefe inmediato :</label>
                                            <select class="form-control" id="jefe" name="jefe">
                                                <?php
                                                    $sql4 = "SELECT 
	CONCAT(
		persona.Primer_nombre, ' ', persona.Primer_apellido
	) AS nombre, 
	(
		SELECT 
			empleado.No_Empleado 
		FROM 
			empleado 
		WHERE 
			empleado.N_identidad = persona.N_identidad
	) AS NoEmpleado 
FROM 
	persona 
WHERE 
	persona.N_identidad IN (
		SELECT 
			empleado.N_identidad 
		FROM 
			empleado 
		WHERE 
			empleado.No_Empleado IN (
				SELECT 
					empleado_has_cargo.No_Empleado 
				FROM 
					empleado_has_cargo 
				WHERE 
					empleado_has_cargo.recibirNotificacion = 1
			)
	)";
                                                    $rec3 =$db->prepare($sql4);
                                                    $rec3->execute();
                                                    while ($row = $rec3->fetch()) {
                                                            echo "<option value=$row[NoEmpleado]>";
                                                            echo $row['nombre'];
                                                            echo "</option>";
                                                    }
                                                ?>
                                            </select>                                       
                                        </div>
                                        <div>
                                            <label>Rango de fechas:</label>											 

                                            <p> <input type="number" id="cantidad" name="cantidad" min="0" max="5" value="0" required ></p>
                                        </div>
									
                                        <div>
                                            <label>Fecha:</label>

                                            <p> <input type="date" id="fecha" placeholder="aaaa-mm-dd" > El formato de la fecha es año-mes-dia</p>												
                                        <table>
                                            <tr><label>Hora Inicio:</label>											
                                            <p>	<input type="time" name="horai" min=6:00 max=22:00 step=900 id="horai" value="1:00 pm" required></p>
                                      
                                            <label>Hora Finalización:</label>
                                            <p><input type="time" name="horaf" min=6:00 max=22:00 step=900 id="horaf" value="2:00 pm" required></p>									

                                            <div>
                                                <input id="bt" class="btn btn-primary" type="submit"  value="Enviar Solicitud" /></td>
                                                <div id="respuesta"></div>
                                            </div> </tr>
											</table>
                                    </form>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		
    </body>
</html>
