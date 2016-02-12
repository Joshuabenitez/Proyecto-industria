
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

    $queryString = "DELETE FROM ca_secciones WHERE codigo=".$codigo;
    $query = mysql_query($queryString); 

    if($query){
      $mensaje = "<strong>¡Éxito! </strong> Se ha eliminado la sección: ".$codigo;
    }else{
      $mensaje = "<strong>¡Error! </strong> Error al eliminar la sección.";
      http_response_code(400);
    }
    
    echo $mensaje;
  }catch(PDOExecption $e){
    echo "<strong>¡Error! </strong> Error al eliminar.";
    http_response_code(500);
  }
?>