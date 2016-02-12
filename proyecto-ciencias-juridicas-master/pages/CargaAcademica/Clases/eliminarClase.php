
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
    $cod_clase = $_POST['cod_clase'];

    $queryString = "DELETE FROM ca_cursos WHERE codigo=".$cod_clase;
    $query = mysql_query($queryString);

    if($query){
      $mensaje = "<strong>¡Éxito! </strong> Se ha eliminado la clase: ".$cod_clase;
    }else{
      $mensaje = "<strong>¡Error! </strong> Error al eliminar la clase.";
      http_response_code(400);
    }
    
    echo $mensaje;
  }catch(PDOExecption $e){
    echo "<strong>¡Error! </strong> Error al actualizar la clase.";
    http_response_code(500);
  }
?>