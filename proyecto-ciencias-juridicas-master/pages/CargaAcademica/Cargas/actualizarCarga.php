
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
    $cod_periodo = $_POST['cod_periodo'];
    $cod_estado = $_POST['cod_estado'];
    $no_empleado = $_POST['no_empleado'];
    $cod_carga = $_POST['cod_carga'];

    $queryString = "SELECT N_Identidad FROM empleado e WHERE no_empleado='".$no_empleado."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    
    $dni_empleado = $row['N_Identidad'];
    
    $mensaje = actualizarCarga($cod_carga,$cod_periodo,$cod_estado,$no_empleado,$dni_empleado);
    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al actualizar la carga.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function actualizarCarga($cod_carga,$cod_periodo,$cod_estado,$no_empleado,$dni_empleado){
    $queryString = "UPDATE ca_cargas_academicas SET cod_periodo=".$cod_periodo.", cod_estado=".$cod_estado.
                   ", no_empleado='".$no_empleado."', dni_empleado='".$dni_empleado."'".
                   " WHERE codigo=".$cod_carga;
                    
    $query = mysql_query($queryString);

    if($query){
      $mensaje = "<strong>¡Éxito! </strong> Se ha actualizado la carga.";
    }
    else{
      $mensaje = "<strong>¡Error! </strong> Error al actualizar la carga.";
      http_response_code(400);
    }
    return $mensaje;
  }
?>