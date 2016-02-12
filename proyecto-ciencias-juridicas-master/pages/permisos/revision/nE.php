<?php

$maindir = "../../../";
require($maindir."conexion/config.inc.php");

 
if(isset($_GET['contenido']))
    {
      $contenido = $_GET['contenido'];
    }
  else
    {
      $contenido = 'permisos';
    }

  require_once($maindir."funciones/check_session.php");

  require_once($maindir."funciones/timeout.php");
  
   if(!isset( $_SESSION['user_id'] ))
  {
    header('Location: '.$maindir.'login/logout.php?code=100');
    exit();
  }
  
?>

<?php $idusuario= $_SESSION['user_id']; ?> 

<?php 
	
	$rol = $_SESSION['user_rol'];
	$nEE = $_SESSION['nEE'];
        
        $query ="Select permisos.id_Permisos, Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_Apellido, dias_permiso, 
        DATE_FORMAT(fecha,'%d-%m-%Y') as fecha, hora_inicio, hora_finalizacion, motivos.descripcion as mtd, permisos.estado,
        departamento_laboral.nombre_departamento from permisos inner join motivos on permisos.id_motivo=motivos.Motivo_ID 
        inner join empleado on empleado.No_Empleado=permisos.No_Empleado inner join persona on persona.N_identidad=empleado.N_identidad 
        inner join departamento_laboral on departamento_laboral.id_departamento_laboral = permisos.id_departamento 
        where permisos.revisarPor = $nEE AND permisos.estado = 'Espera' or permisos.estado = 'Aprobado' ORDER BY fecha asc";
        $consulta =$db->prepare($query);
        $consulta->execute();
?>

<!DOCTYPE html>

<html lang="en">


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
</head>
<!--<script type="text/javascript" src="../SistemaCienciasJuridicas/js/jquery-2.1.3.js"></script>-->
	
<body>

   <?php 
   if(isset($_GET['errores']))
   {
       $accion = $_GET['errores'];
        switch ($accion) 
        {
            case 1:
            $mensaje = "Exitosamente transaccion...........";
                echo '<div class="alert alert-success alert-error">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <strong> Success! </strong>'.$mensaje.'</div>';
                break;
           
            default:
                break;
        }
   }





    ?>



	<div id="proceso"></div>

    <div id="wrapper">
		<h1 class="page-header">Control de Permisos</h1>
			<div class="box">
            <div class="box-header">
           
            </div><!-- /.box-header -->
            <div class="box-body table-responsive">
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
                //echo <<<HTML <td><a href='javascript:ajax_("'$url'");'>$NroFolio</a></td>HTML;
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
					<button class="aprobarlo btn btn-primary  glyphicon glyphicon-thumbs-up"  title="Aprobar">
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
					<a class="open-Modal btn btn-primary"><i class="fa fa-edit"></i></a>
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
					<button class=" Exportar btn btn-danger pull-right"  data-id=$idP href="#">ExportarPDF</button>
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
           </div><!-- /.box-body -->
       </div><!-- /.box -->
</div>

<div id="contenedor2">

</div>


 <div class=" modal fade" id="compose-denegar" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	  <form role="form" id="form" name="form" action="#">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><i class="glyphicon glyphicon-floppy-disk"></i> Justificación de denegación </h4>
      </div>
              <div class="modal-body">
                  <div class="form-group">
                      <div class="input-group">
                              <div class="input-group">
								  <input id="Permiso" type="hidden" class="form-control" value = ""  required>
                                  <input id="observacion" type="text" class="form-control" placeholder="Justificaci&#243;n de Deniego"    required>
                                  <span class="input-group-btn">
                                      <button id="guardarJ "   class=" Denegarlo btn btn-primary"  >Finalizar</button>
                                  </span>
                              </div>
                           
                        
                      </div>   
                       
                  </div>
                  
              </div>
           <!--  <div class="modal-footer clearfix">
            <button name="submit" id="submit" class="insertarbg btn btn-primary pull-left"><i class="glyphicon glyphicon-pencil"></i> Insertar</button>
          </div>
           -->
                
                    
          </form>
    
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</div>


<div class="modal fade" id="Aprobar-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class=" modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 style="font-size:large;" class="modal-title">Confirmacion</h4>
      </div>
      <div  class="modal-body">

        <p style='display:none' id="codigo"></p>
        <p style='display:none' id="dias"></p>
        <center><p style="font-size:large;"  id="informacion"></p></center>
        
       
        
      </div>
      <div class="modal-footer">
       
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button id="button-Aprobacionm"  class="button-Aprobacion btn btn-danger ">Aprobar</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal --> 


<script language="javascript" type="text/javascript">


$(document).on("click", ".open-Modal", function () {
	id = $(this).parents("tr").find("td").eq(0).html();
	$(".modal-body #Permiso").val(id);
	$('#compose-denegar').modal('show'); 

});
$(document).on("click", ".aprobarlo", function () {
	var id=$(this).parents("tr").find("td").eq(0).html();
	var diasd=$(this).parents("tr").find("td").eq(2).html();
    $('#Aprobar-modal #codigo').text(id);
    $('#Aprobar-modal #dias').text(diasd);
    var descripcion= $(this).parents("tr").find("td").eq(1).html();
    var d = " Desea Aprobar el  permiso  "+descripcion;
    $('#Aprobar-modal #informacion').text(d);
	$('#Aprobar-modal').modal('show'); 

});

$(document).ready(function() {
	$(".Exportar").on('click',function(){
          
          id1 = $(this).data('id'); 
			data={
            id1:id1
            };
            $.ajax({
                async:true,
                type: "GET",
                dataType: "html",
                contentType: "application/x-www-form-urlencoded",
                url:"pages/permisos/revision/crear_pdfpermiso.php", 
               beforeSend: function()
               {
                $(".alert").remove();
                var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>Enviando .......................</div>';
                $("#proceso").append(me); 
               	window.open('pages/permisos/revision/crear_pdfpermiso.php?id1='+id1);
               },

                success:function()
                {
                  $("#contenedor").empty();	
                  $("#contenedor").load('pages/permisos/revision/Revision.php?errores=1');
                 

                },
                timeout:4000,
                error:function(result)
                {
                   $(".alert").remove();
                  var me='<div class="alert alert-danger" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong>'+result.status + ' ' + result.statusText+'</strong></div>';
                  $("#proceso").append(me);
                	
                }
                

            }); 
            
          
        });
});



var x;
x = $(document);
x.ready(inicio);

	function inicio()
	{
		var x;
		x = $('.button-Aprobacion');
		x.click(Aprobacion);
		
		var a;
		a = $('.Denegarlo');
		a.click(Denegacion);
	};
	
	
	function Aprobacion()
	{  
		//var pid=$(this).parents("tr").find("td").eq(0).html();
		//var diasp=$(this).parents("tr").find("td").eq(2).html();
		var pid=$('#Aprobar-modal #codigo').text();
		var diasp=$('#Aprobar-modal #dias').text();			
		data ={codigo:pid, cdias:diasp, usr:"<?php echo $idusuario ?>", rol:"<?php echo $rol ?>"}; 
	    
		$.ajax({
			data:data,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
		    url:'pages/permisos/revision/aprobarSolicitud.php',  

		    timeout: 4000,
			beforeSend: function(){ 

             $(".alert").remove();
                var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>"cargando .............."</div>';
                $("#proceso").append(me);


			 },
			success: function(response)
			{
			
			$("#contenedor").empty();
            $dato=response.trim();
            $("#contenedor").load('pages/permisos/revision/Revision.php?errores='+$dato);


			},
			error: function(result)
			{

				$(".alert").remove();
                 var me='<div class="alert alert-danger" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong> '+ result.status + ' ' + result.statusText+'</strong></div>';
                $("#proceso").append(me);




			}		
		
		});

     
        

            
		
	}
	
	
	function Denegacion()
	{
		
		var data ={idpermiso:$('#Permiso').val(), obs:$('#observacion').val()};
	    $('#compose-denegar').modal('hide');  	 
				 $.ajax({
		 	    
                data:  data,
                url:   'pages/permisos/revision/denegarSolicitud.php',
                type:  'POST',
                dataType:'html',
                beforeSend: function () {
                 
                  $(".alert").remove();
                var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>"cargando .............."</div>';
                $("#proceso").append(me);
                
                    
                },
                success:  function (response) {
                
               $("#contenedor").empty();
                 $dato=response.trim();
                 $("#contenedor").load('pages/permisos/revision/Revision.php?errores='+$dato);                        
                        
                          
                },
                error : function(result) {
                 $(".alert").remove();
                var me='<div class="alert alert-success" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong>'+result.status + ' ' + result.statusText+'</strong></div>';
                  $("#proceso").append(me);
        
                 }
 
    
        });
   
     
    
   

     
     
	
	}
            
	

</script>

					
</body>
</html>
