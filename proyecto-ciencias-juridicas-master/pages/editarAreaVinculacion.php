<?php

include '../Datos/conexion.php';

$codigoArea = $_POST['codigoArea'];
$nombreArea = NULL;
$codigoFacultad = NULL;

$consulta = "SELECT * FROM ca_vinculaciones WHERE codigo = " . $codigoArea;

if ($resultado = $conectar->query($consulta)) {

    while ($fila = $resultado->fetch_row())
    {
        $nombreArea = $fila[1];
        $codigoFacultad = $fila[2];
    }
    $resultado->close();
}

$GLOBALS['option'] = "";
$queryFacultades = mysql_query("SELECT * FROM ca_facultades");
while($row = mysql_fetch_assoc($queryFacultades)){
  $option .= ("<option value='".$row['codigo']."'");
  if($row['codigo'] === $codigoFacultad){
    $option .= " selected";
  }
  $option .= (">".$row['nombre']."</option>");
}

$conectar->close();
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <link href="css/prettify.css" rel="stylesheet">
  <script src="js/prettify.js"></script>

  <script>
    $(document).ready(function() {
      $("form").submit(function(e) {
        e.preventDefault();
        $("#editarAreaVinculacion").modal('hide');
        data = {
          accion: 2,
          nombreArea: $("#nombreAreaEd").val(),
          codigoArea: <?php echo $codigoArea; ?>,
          codigoFacultad: $("#facultadEd").val()
        };
        $.ajax({
          async: true,
          type: "POST",
          dataType: "html",
          //contentType: "application/x-www-form-urlencoded",
          success: llegadaActualizarArea,
          //timeout: 4000,
          //error: problemas
        });
        //limpiarCampos();
        return false

      });
    });

    function llegadaActualizarArea() {
      $("#contenedor2").load('Datos/ca_gestionar_areas_vinculacion.php', data);
    }
  </script>
</head>
<body>
  <input type="hidden" id="codigoArea" value="<?php echo $codigoArea; ?>">
  <form role="form" id="form" name="form">
    <div class="form-group">
      <label class="control-label">Nombre Área</label>
      <input id="nombreAreaEd" name="nombreAreaEd" class="form-control" value="<?php echo $nombreArea; ?>">
    </div>
    <div class="form-group">
      <label class="control-label">Facultad</label>
      <select class="form-control" id="facultadEd" name="facultadEd">
        <?php echo $option; ?>
      </select>
    </div>
    <div class="modal-footer">
      <button id="guardar" class="btn btn-primary">Guardar</button>
    </div>
  </form>
</body>

</html>
