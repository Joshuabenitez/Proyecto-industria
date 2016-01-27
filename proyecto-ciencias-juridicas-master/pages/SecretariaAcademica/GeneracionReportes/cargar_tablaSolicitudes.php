<?php
      $mkdir = "../../../";
      include($mkdir."conexion/config.inc.php");
      $query  = $db->prepare('CALL SP_OBTENER_SOLICITUDES(@pcMensajeError)');
      $query->execute();
      $result1 = $query->fetchAll();


  echo "<div class='table-responsive'>
          <table id= 'tabla_Solicitudes' class='table table-striped table-bordered'cellspacing='0' width='100%'>
            <thead class = '' >
               <tr>
                    <th>Estudiante</th>  
                    <th>Fecha</th>   
                    <th>Observaciones</th>
                    <th>Estado</th>  
                    <th>DNI</th>
                    <th>Tipo Solicitud</th>
                    <th>Himno</th>
                </tr>
            </thead>
            <tbody id = 'tabla_filtrada'>";
        foreach($result1 as $row)
        {
         echo "<tr>
                  <td><center> $row[NOMBRE] </td></center>
                  <td><center> $row[FECHA_SOLICITUD]</td></center>
                  <td><center> $row[OBSERVACIONES]</td></center>
                  <td><center> $row[ESTADO]</td></center>
                  <td><center> $row[DNI_ESTUDIANTE]</td></center>
                  <td><center> $row[TIPO_SOLICITUD]</td></center>
                  <td><center> $row[APLICA_PARA_HIMNO]</td></center>
              </tr>";
        }
        echo "</tbody>
          </table> 
            </div> ";
 ?>
<script>
    $('#tabla_Solicitudes').dataTable({
            dom: 'Blfrtip',
        buttons: [

            {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: [ 0, ':visible' ]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                    columns: ':visible'
                },
                download: 'open'
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: ':visible'
                },
                download: 'open'
            },
            {
                extend: 'print',
                exportOptions: {
                    columns: ':visible'
                }
            },
            'colvis'
        ]
         });
</script>