
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
    $no_cuenta = $_POST['no_cuenta'];

    $queryString = "DELETE FROM sa_estudiantes WHERE no_cuenta='".$no_cuenta."'";
    $query = mysql_query($queryString);

    if($query){
      $mensaje = "<div id = 'mensaje' class='alert alert-success alert-success'>
            <a href='#'' class='close' data-dismiss='alert'>&times;</a>
            <strong> Exito! </strong> EL usuario  se ha eliminado correctamente</div>";


     
    }else{
      $mensaje = "<div id = 'mensaje' class='alert alert-danger alert-danger'>
            <a href='#'' class='close' data-dismiss='alert'>&times;</a>
            <strong> Error! </strong>Problemas al Borrar el Estudiante</div>";
      // http_response_code(400);
    }
    
    echo $mensaje;
  }catch(PDOExecption $e){
    echo "<div id = 'mensaje' class='alert alert-danger alert-danger'>
            <a href='#'' class='close' data-dismiss='alert'>&times;</a>
            <strong> Error! </strong>Problemas al Borrar el Estudiante</div>";
    // http_response_code(500);
  }

  include 'mostrarEstudiantes.php';
?>
<script>
  $(document).ready(function(){
        setTimeout(function(){
            $('#mensaje').fadeOut(3000);
        },3000);

      });
</script>