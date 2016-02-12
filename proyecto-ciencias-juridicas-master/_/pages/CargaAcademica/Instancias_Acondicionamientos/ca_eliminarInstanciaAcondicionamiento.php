<?php

$maindir = "../../../";
include($maindir."conexion/config.inc.php");  

require_once($maindir."funciones/check_session.php");

require_once($maindir."funciones/timeout.php");
  
if(!isset( $_SESSION['user_id'] ))
{
  header('Location: '.$maindir.'login/logout.php?code=100');
  exit();
}

  try
  {
    $codigo = $_POST['codInstanciaA'];
    $stmt = $db->prepare("DELETE FROM `ca_aulas_instancias_acondicionamientos` WHERE `item` =?");
	     //Introduccion de parametros
    $stmt->execute(array($codigo));
     //var_dump($output);
     $mensaje = "Se eliminó el acondicionamiento";
     $codMensaje = 1;
      
    }catch(PDOExecption $e){
      $mensaje = 'Se encuentra asociado';
      $codMensaje = 0;
    }
    
    if($codMensaje == 1){
      echo '<div class="alert alert-danger alert-error">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> El registro ha sido eliminado ..! </strong>'.$mensaje.'</div>';
    }else{
      echo '<div class="alert alert-danger alert-error">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Error! </strong>'.$mensaje.'</div>';
  }
?>