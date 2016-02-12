 <?php
  include '../../../Datos/conexion.php';
?>    

<?php
  $resultado= mysql_query("SELECT codigo, nombre FROM sa_tipos_solicitud");
  while ($row = mysql_fetch_array($resultado)) 
  {
    $codigo = $row['codigo'];
    $nom=$row['nombre'];
    ?>
    <tr height="50px">
      <td id="codigo">
        <?php echo $codigo ?>
      </td>
      <td id="nombreT">
        <?php echo $nom ?>
      </td>
      <td>
        <center>
          <button type="button"  id="editarSolicitud" href="#" class="editarSolicitud btn btn-primary glyphicon glyphicon-edit"  data-toggle="modal" data-target="#editarModal" data-whatever="@mdo"></button>
        </center>
      </td>
      <td>
        <center>
          <button type="button"  id="eliminarSolicitud" href="#" class="eliminaSolicitud btn btn-danger glyphicon glyphicon-trash"></button>
        </center>
      </td>
    </tr>
    <?php
  } 
?>

            