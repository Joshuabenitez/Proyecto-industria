
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
    
    $queryString = "SELECT cod_rol_proyecto FROM ca_empleados_proyectos WHERE no_empleado =".$no_empleado;
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    $cod_rol = $row['cod_rol_proyecto'];

    $queryString = "SELECT COUNT(*) AS Cuenta FROM ca_empleados_proyectos WHERE cod_proyecto =".$cod_proyecto;
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    $cantDocentes = $row['Cuenta'];

    if($cod_rol == 1) {
      if($cantDocentes > 1) {
        $mensaje = "<strong>¡Error! </strong> No puede eliminar al coordinador del proyecto.";
        http_response_code(400);
      } else {
        $mensaje = eliminarDocente($no_empleado,$cod_proyecto);
      }
    } else {
      $mensaje = eliminarDocente($no_empleado,$cod_proyecto);
    }
     
    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al asignar al docente.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function eliminarDocente($no_empleado, $cod_proyecto){
    $queryString = "DELETE FROM ca_empleados_proyectos WHERE no_empleado = '".$no_empleado."'";
    $query = mysql_query($queryString);

    if($query)
      $mensaje = "<strong>¡Éxito! </strong> Se ha eliminado al docente ".$no_empleado." del proyecto ".$cod_proyecto.".";
    else{
      $mensaje = "<strong>¡Error! </strong> Error al eliminar docente de proyecto.";
      http_response_code(400);
    }
    return $mensaje;
  }
?>

 
  
 