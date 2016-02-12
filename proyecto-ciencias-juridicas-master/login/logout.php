<?php
//include "../conexion/conn.php";
include '../conexion/config.inc.php';
if(isset($_SESSION['contenido']))
{
   $contenido = $_SESSION['contenido'];

}
elseif(isset($_GET['contenido']))
{
   $contenido = $_GET['contenido'];
}

if(isset($_GET['code']))
{
  $code = $_GET['code'];
  switch ($code) 
  {
      case 101:
        session_start();
          if(isset($_SESSION['user_id'])){
            $user_ID = $_SESSION['user_id'];
            $query = "UPDATE usuario SET esta_logueado = 0 where id_Usuario = '".$user_ID."' ;";
            $result = mysql_query($query, $conexion) or die("error en la consulta");
          }
          session_destroy(); // Destroying All Sessions
          if($contenido == 'index')
          {
            echo '<script>window.top.location.href="../login/login.php?error_code=5"</script>';
            exit();
          }
        echo '<script>window.top.location.href="../login/login.php?error_code=5"</script>';
        exit();
        break;
	  case 100:
          session_start();
          if(isset($_SESSION['user_id'])){
            $user_ID = $_SESSION['user_id'];
            $query = "UPDATE usuario SET esta_logueado = 0 where id_Usuario = '".$user_ID."' ;";
            $result = mysql_query($query, $conexion) or die("error en la consulta");
          }
          session_destroy(); // Destroying All Sessions
          if($contenido == 'index')
          {
            echo '<script>window.top.location.href="../login/login.php"</script>';
            exit();
          }
		  echo '<script>window.top.location.href="../login/login.php"</script>';
          exit();
	  break;
	  case 0:
          session_start();
          if(isset($_SESSION['user_id'])){
            $user_ID = $_SESSION['user_id'];
            $query = "UPDATE usuario SET esta_logueado = 0 where id_Usuario = '".$user_ID."' ;";
            $result = mysql_query($query, $conexion) or die("error en la consulta");
          }
          session_destroy(); // Destroying All Sessions
		  if($contenido == 'index')
          {
            echo '<script>window.top.location.href="../login/login.php?error_code=0"</script>';
            exit();
          }
          echo '<script>window.top.location.href="../login/login.php?error_code=0"</script>';
          exit();
	  break;
      default:
       // session_start();
         if(isset($_SESSION['user_id'])){
            $user_ID = $_SESSION['user_id'];
            $query = "UPDATE usuario SET esta_logueado = 0 where id_Usuario = '".$user_ID."' ;";
            $result = mysql_query($query, $conexion) or die("error en la consulta");
          }
     session_destroy(); // Destroying All Sessions
		  if($contenido == 'index')
          {
            echo '<script>window.top.location.href="../login/login.php?error_code=0"</script>';
            exit();
          }
          echo '<script>window.top.location.href="../login/login.php?error_code=0"</script>';
          exit();
	  break;
  }
}
else
{ 
  session_start();
  if(isset($_SESSION['user_id'])){
    $user_ID = $_SESSION['user_id'];
    $query = "UPDATE usuario SET esta_logueado = 0 where id_Usuario = '".$user_ID."' ;";
    $result = mysql_query($query, $conexion) or die("error en la consulta");
  }
  session_destroy(); // Destroying All Sessions 
  header("Location:   login.php"); // Redirecting To Home Page
}
?>