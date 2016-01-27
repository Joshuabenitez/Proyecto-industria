
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
    $no_empleado = $_POST['no_empleado'];
    $cod_proyecto = $_POST['cod_proyecto'];
    $cod_rol = $_POST['cod_rol'];

    $queryString = "SELECT N_Identidad FROM empleado e WHERE no_empleado='".$no_empleado."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    
    $dni_empleado = $row['N_Identidad'];

    $queryString = "SELECT no_empleado FROM ca_empleados_proyectos WHERE cod_rol_proyecto = 1 AND cod_proyecto =".$cod_proyecto;
    $query = mysql_query($queryString);
    $flag = false;

    while($row = mysql_fetch_assoc($query))
      $flag = true;
    
    if($flag) {
      if($cod_rol == 1) {
        $mensaje = "<strong>¡Error! </strong> Ya existe un coordinador para el proyecto.";
        http_response_code(400);
      } else {
        $mensaje = insertarDocente($no_empleado,$dni_empleado,$cod_proyecto,$cod_rol);
      }
    } else {
      if($cod_rol == 2) {
        $mensaje = "<strong>¡Error! </strong> Debe asignar un coordinador para el proyecto.";
        http_response_code(400);
      } else {
        $mensaje = insertarDocente($no_empleado,$dni_empleado,$cod_proyecto,$cod_rol);
      }
    }
     
    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al asignar al docente.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function insertarDocente($no_empleado,$dni_empleado,$cod_proyecto,$cod_rol){
    $queryString = "INSERT INTO ca_empleados_proyectos VALUES ('".$no_empleado."','".$dni_empleado."',".$cod_proyecto.",".$cod_rol.")";
    $query = mysql_query($queryString);

    if($query)
      $mensaje = "<strong>¡Éxito! </strong> Se ha asignado el docente ".$no_empleado." al proyecto ".$cod_proyecto.".";
    else{
      $mensaje = "<strong>¡Error! </strong> Error al asignar al docente.";
      http_response_code(400);
    }
    return $mensaje;
  }
?>

 
  
 