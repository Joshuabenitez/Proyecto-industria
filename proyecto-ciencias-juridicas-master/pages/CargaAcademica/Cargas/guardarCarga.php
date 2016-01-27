
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

    $queryString = "SELECT N_Identidad FROM empleado e WHERE no_empleado='".$no_empleado."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    
    $dni_empleado = $row['N_Identidad'];
    
    $mensaje = insertarCarga($cod_periodo,$cod_estado,$no_empleado,$dni_empleado);
    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al guardar la carga.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function insertarCarga($cod_periodo,$cod_estado,$no_empleado,$dni_empleado){
    $queryString = "INSERT INTO ca_cargas_academicas(cod_periodo,cod_estado,no_empleado,dni_empleado) VALUES (".
                   $cod_periodo.",".$cod_estado.",'".$no_empleado."','".$dni_empleado."')";
                    
    $query = mysql_query($queryString);

    if($query){
      $mensaje = "<strong>¡Éxito! </strong> Se ha guardado una nueva carga acádemica. Si desea agregar clases a la carga dirijase a 'Asignación de Clases'";
    }
    else{
      $mensaje = "<strong>¡Error! </strong> Error al guardar.";
      http_response_code(400);
    }
    return $mensaje;
  }
?>