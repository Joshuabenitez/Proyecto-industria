
<?php

  $maindir = "../../../";
  


  require_once($maindir."funciones/check_session.php");

  require_once($maindir."funciones/timeout.php");
 	require($maindir."conexion/config.inc.php");
		$idempleado= $_POST['no_empleado'];
		//echo $idempleado;
?>
<!DOCTYPE html>

<html lang="en">


<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
</head>

	
<body>

		      <!-- /.Filtracion Principal-->							
                                        
    <div id="wrapper">
		<h1 class="page-header">Consultas a Empleados</h1>
			<div class="box">
            <div class="box-header">
					  
				<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headingTwo">
			  <h4 class="panel-title">
				Establezca el Periodo de Tiempo
				
			  </h4>
			</div>
			 <div class="panel-body">
								
							   <div class="panel panel-green">
								<div class="panel-body">
					<p><label>Desde: </label>
					 <input type="date" id="fecha_i" name="datepicker_i" required  value=current()>
					<label>Hasta:  </label>

					<input type="date" id="fecha_f" name="datepicker_f" required val="-1" >
				
						</p>
							<p>	 
						</div></div></div></div>
							

	  
	  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        Avanzada 
			</a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
					    
			           <div class="panel panel-green">
					    <div class="panel-body">
						
						        
					<label align="center">Departamento:</label>
				
					<select class="panel-body" Id="area" name="area">
					<option value=-1>Ninguno</option>
					
					<?php
						$sql="select departamento_laboral.nombre_departamento from departamento_laboral";
                        $rec =$db->prepare($sql);
                        $rec->execute();

						//$rec1 = mysqli_query($conexion, "select departamento_laboral.nombre_departamento from departamento_laboral");
						while ($row =$rec->fetch()) {
							echo "<option>";
							echo $row['nombre_departamento'];
							echo "</option>";
						}
					?>
					
					</select>      
						
					<label align="center">Motivo :</label>
					
					<select class="panel-body" Id="motivo" name="motivo">
					 <option value=-1>Ninguno</option>

					
					<?php
					$sq2="SELECT descripcion from motivos";
                        $rec2 =$db->prepare($sq2);
                        $rec2->execute();

						//$rec1 = mysqli_query($conexion, "SELECT descripcion from motivos");
						while ($row = $rec2->fetch()) {
							echo "<option>";
							echo $row['descripcion'];
							echo "</option>";
						}
					?>
					</select>  

								
		  	  </p>				
			  
			    </div>
				</div>
				</div></div></div></div></div>
			   <p align="right">
			  
		
                                               
			 <input  id="btgenerar" class="btn btn-primary" type="submit"  value="Generar Reporte" /></td>
			 
		      <button id="reportePDF" class="btn btn-primary" data-mode="verPDF" data-id=$idDpto href="#">ExportarPDF</button>
   			
		    	  			
			   
			
			 
			 </p>
		
		   
           <!-- /.box-header -->
			
	 
 <div id="contenedor2" class="panel-body">
        <?php
        
       

         
     
        ?>
 </div>
  

<script>
$( document ).ready(function() {
//bTN PDF REPORTES 
	$("#reportePDF").on('click',function(){
         
		 area=$('select[name=area]').val();
		 motivo= $('select[name=motivo]').val();
		fecha_i= $("#fecha_i").val();
		fecha_f= $("#fecha_f").val();
		idempleado= "<?php echo $idempleado; ?>";							
   
			data={
									area: area,
									motivo:motivo,
									fecha_i: fecha_i,
									fecha_f: fecha_f
								
            };
            $.ajax({
                async:true,
                type: "GET",
                dataType: "html",
                contentType: "application/x-www-form-urlencoded",
                url:"pages/permisos/consultaempleado/crearpdfsolicitudes.php", 
                beforeSend: function()
               {
                $(".alert").remove();
                var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>Enviando .......................</div>';
                $("#proceso").append(me);
                 window.open('pages/permisos/consultaempleado/crearpdfsolicitudes.php?area='+area+'&motivo='+motivo+'&fecha_i='+fecha_i+'&fecha_f='+fecha_f+'&idempleado='+idempleado); 
                
               }, 
                success:function(){
                	$mensaje="Transaccion Exitosamente..............................................";
                  $(".alert").remove();
                  $me='<div class="alert alert-success" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong>'+$mensaje + '</strong></div>';
                  $("#proceso").append($me); 

                  

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

	$("#btgenerar").on('click',function(){
       	 area=$('select[name=area]').val();
		 motivo= $('select[name=motivo]').val();
		fecha_i= $("#fecha_i").val();
		fecha_f= $("#fecha_f").val();

			data = {
					idempleado: "<?php echo $idempleado; ?>",
					area: area,
					motivo:motivo,
					fecha_i: fecha_i,
					fecha_f: fecha_f
		
				};
								
            $.ajax({
                async:true,
                type: "GET",
                dataType: "html",
				data:data,
                contentType: "application/x-www-form-urlencoded",
                url:"pages/permisos/consultaempleado/Revision_consulta.php",
                beforeSend: function()
               {
                $(".alert").remove();
                var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>Enviando .......................</div>';
                $("#proceso").append(me); 
                 
                
               }, 
                success:function()
                {
                 
                 $mensaje="Transaccion Exitosamente..............................................";
                  $(".alert").remove();
                  $me='<div class="alert alert-success" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong>'+$mensaje + '</strong></div>';
                  $("#proceso").append($me); 
                 $("#contenedor2").load('pages/permisos/consultaempleado/Revision_consulta.php', data);

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

		}

);


	  


</script>

					
</body>
</html>
