
<!---INFORMACION DE LA PAGINA- -->


<?php 


 // <!-- Declaramos la direccion raiz -->
  $maindir = "../../../";

// <!-- anadimos los archivos necesarios para trabajar-->

//acceso a bases de datos
include ($maindir.'conexion/config.inc.php');

// verifica la sesion

 
// // verifica el tiempo de la sesion 
//require_once($maindir."login/time_out.php");

  ?>

    <div>
      <h1 class="page-header">
          <small>historial de ingreso</small>
      </h1>
      <ol class="breadcrumb">
          <li class="active">
              <span class="fa fa-dashboard"></span></i> Administracion
          </li>
           <li class="active">
              <i class="fa fa-table"></i> Logs
          </li>
      </ol>
    </div>
     <div class="box-body table-responsive ">
       <table id = "tabla_logs"  class='table table-bordered table-striped display' cellspacing="0" >
          <thead>
            <tr style="background-color: rgb(71, 58, 147);">
              <th style= "color: white">Usuario</th>
              <th style= "color: white">Fecha Ingreso</th>
               <th style= "color: white">Hora Inicio</th>
              <th style= "color: white">Hora Salida</th>
              <th style= "color: white">IP</th>

            </tr>
          </thead>
          <tbody>
          <?php
          //ejecutamos la consulta con ayuda del archivo conexion.php que se encuentra arriba
            $query = $db->prepare("SELECT usuario_log,fecha_ingreso,date_format(fecha_ingreso,'%H:%i:%s') as Inicio,date_format(fecha_salida,'%H:%i:%s') as Salida,ip_conexion FROM usuario_logs ORDER BY fecha_ingreso DESC  ");
            $query->execute();


            
            // aqui se rellena las filas
           while($row= $query->fetch())
              {
               echo "<tr>
                       <td> $row[usuario_log] </td>
                       <td> $row[fecha_ingreso] </td>
                       <td> $row[Inicio] </td>
                       <td> $row[Salida]</td>
					             <td> $row[ip_conexion]</td>
                    </tr>";
              }
          ?> 
          </tbody>
      </table>
    </div>
    <!-- fin tabla -->
    

  
  <script type="text/javascript" charset="utf-8">
  $(document).ready(function() {
    $('#tabla_logs').dataTable(); // example es el id de la tabla
	});
	
</script>



