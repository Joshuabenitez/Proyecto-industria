
<?php

$maindir = "../../../";
include($maindir."conexion/config.inc.php");  
  

  require_once($maindir."funciones/check_session.php");

  require_once($maindir."funciones/timeout.php");
  
  if(!isset( $_SESSION['user_id'] ))  {
    header('Location: '.$maindir.'login/logout.php?code=100');
    exit();
  }


  try{
    $codigo = $_POST['codigo'];
    $hora_inicio = $_POST['hora_inicio'];
    $hora_fin = $_POST['hora_fin'];

    $queryString = "UPDATE ca_secciones SET hora_inicio='".$hora_inicio."', hora_fin='".$hora_fin.
                   "' WHERE codigo=".$codigo;

    $query = mysql_query($queryString);

    if($query){
      $mensaje = "<strong>¡Éxito! </strong> Se ha actualizado la sección.";
    }
    else{
      $mensaje = "<strong>¡Error! </strong> Error al actualizar.";
      http_response_code(400);
    }

    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al actualizar la sección.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }
?>