
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
    $cod_carga = $_POST['cod_carga'];

    $queryString = "DELETE FROM ca_cargas_academicas WHERE codigo=".$cod_carga;
    $query = mysql_query($queryString); 

    if($query){
      $mensaje = "<strong>¡Éxito! </strong> Se ha eliminado la carga acádemica: ".$cod_carga;
    }else{
      $mensaje = "<strong>¡Error! </strong> Error al eliminar la carga.";
      http_response_code(400);
    }
    
    echo $mensaje;
  }catch(PDOExecption $e){
    echo "<strong>¡Error! </strong> Error al eliminar.";
    http_response_code(500);
  }
?>