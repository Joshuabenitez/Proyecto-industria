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
      if(!isset($_SESSION)){
    session_start();
}
 $aula = $_SESSION['aula'];
	  $nombre = $_POST['nombreInstanciaA'];
    
     $stmt = $db->prepare("INSERT INTO `ca_aulas_instancias_acondicionamientos`(`cod_aula`, `cod_instancia_acondicionamiento`) VALUES (?,?)");
	     //Introducciworworon de parametros
     $stmt->execute(array($aula, $nombre)); 
       

     //var_dump($output);
     $mensaje = "Se agrego un acondicionamiento";
     $codMensaje = 1;
      
    }catch(PDOExecption $e){
      $mensaje = 'Error al ingresar el registro o registro actualmente existente.';
      $codMensaje = 0;
    }
    
    if($codMensaje == 1){
      echo '<div class="alert alert-success alert-succes">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Registro almacenado con éxito..! </strong>'.$mensaje.'</div>';
    }else{
      echo '<div class="alert alert-danger alert-error">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Error! </strong>'.$mensaje.'</div>';
  }
  
?>