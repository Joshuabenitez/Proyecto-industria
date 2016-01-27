<?php
session_start();
$maindir = "../";

require_once($maindir."conexion/config.inc.php");
//require_once("../Datos/conexion.php");
include '../conexion/config.inc.php';

/* Codigo que valida para que no se pueda cargar de retroseso el login */
if(isset($_SESSION['user_id']))
{
    header('Location: '.$maindir.'index.php');
    exit();
}

if(isset($_GET['usuario']) && isset($_GET['password']))
{  
  $LoginUsuario = $_GET['usuario'];
  $LoginPassword = $_GET['password'];
}
else
{
  header('Location: login.php?error_code=2');
  exit();
}

try{

    $stmt = $db->prepare("CALL sp_login(?,?)");
    $stmt->bindParam(1, $LoginUsuario, PDO::PARAM_STR); 
	  $stmt->bindParam(2, $LoginPassword, PDO::PARAM_STR);

	  $stmt->execute();	
 
    $result = $stmt -> fetch();
}
catch(PDOExecption $e)
{
   header('Location: login.php?error_code=3');
   exit();
} 

if($result)
{

  /* Codigo para validar si el esta o no logueado un usuario en el sitema */
  /* ++++++NO FUNCIONA ++++++*/
    if($result['esta_logueado'] == 1){
      header('Location: login.php?error_code=6');
      $stmt->closeCursor(); // Liberar result del statement anterior
      exit;
    }else
    {
        session_regenerate_id();
	$_SESSION['user_id'] = $result['id_Usuario'];
	$_SESSION['user_rol'] = $result['Id_Rol'];
        $_SESSION['logueado'] = $result['esta_logueado']; 
	$_SESSION['nombreUsuario'] = $LoginUsuario;
	$_SESSION['timeout'] = time();
        
        
	session_write_close();
        $stmt->closeCursor(); // Liberar result del statement anterior
      /* Cambia el contenido de la base de datos indicando que un usuario si esta */
      $query = "UPDATE usuario SET esta_logueado = 1 where id_Usuario = '".$_SESSION['user_id']."'";
      $result = mysql_query($query, $conexion) or die("error en la consulta");
      $stmt->execute();
      $stmt = null;

      function get_client_ip() {
          $ipaddress = '';
          if (getenv('HTTP_CLIENT_IP'))
              $ipaddress = getenv('HTTP_CLIENT_IP');
          else if(getenv('HTTP_X_FORWARDED_FOR'))
              $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
          else if(getenv('HTTP_X_FORWARDED'))
              $ipaddress = getenv('HTTP_X_FORWARDED');
          else if(getenv('HTTP_FORWARDED_FOR'))
              $ipaddress = getenv('HTTP_FORWARDED_FOR');
          else if(getenv('HTTP_FORWARDED'))
              $ipaddress = getenv('HTTP_FORWARDED');
          else if(getenv('REMOTE_ADDR'))
              $ipaddress = getenv('REMOTE_ADDR');
          else
              $ipaddress = 'UNKNOWN';
          return $ipaddress;
      }
    
    $user_ip = get_client_ip();
    
    try{
    
        $stmt = $db->prepare("CALL sp_log_user(?,?)");
        $stmt->bindParam(1, $_SESSION['user_id'], PDO::PARAM_STR); 
        $stmt->bindParam(2, $user_ip, PDO::PARAM_STR);
        $stmt->execute(); 

          $stmt = null;
          $db = null;
      }
      catch(PDOExecption $e)
      {
         header('Location: login.php?error_code=3');
         //die("We are unable to process your request. Please try again later");
      }
      header('Location: '.$maindir.'index.php?');
    }
 
}else
{
    //echo "<script>alert('Sorry wrong username or password')</script>";
    header('Location: login.php?error_code=1');
}

?>