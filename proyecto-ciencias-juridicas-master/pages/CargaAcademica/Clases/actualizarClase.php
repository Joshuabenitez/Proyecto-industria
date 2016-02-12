
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
    $cod_asignatura = $_POST['cod_asignatura'];
    $cod_seccion = $_POST['cod_seccion'];
    $cod_aula = $_POST['cod_aula'];
    $no_empleado = $_POST['no_empleado']; 
    $cupos = $_POST['cupos'];
    $cod_carga = $_POST['cod_carga'];
    $strDias = $_POST['dias'];
    $cod_clase = $_POST['cod_clase'];
    $dias = explode(',',$strDias);

    $queryString = "SELECT N_Identidad FROM empleado e WHERE no_empleado='".$no_empleado."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    
    $dni_empleado = $row['N_Identidad'];
    
    $mensaje = actualizarClase($cod_asignatura,$cod_seccion,$cod_aula,$no_empleado,$dni_empleado,$cupos,$cod_carga,$dias,$cod_clase);
    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al actualizar la clase.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function actualizarClase($cod_asignatura,$cod_seccion,$cod_aula,$no_empleado,$dni_empleado,$cupos,$cod_carga,$dias,$cod_clase){
    $queryString = "UPDATE ca_cursos SET cod_asignatura=".$cod_asignatura.", cod_seccion=".$cod_seccion.
                   ", cod_aula=".$cod_aula.", no_empleado='".$no_empleado.
                   "', dni_empleado='".$dni_empleado."', cupos=".$cupos.", cod_carga=".$cod_carga.
                   " WHERE codigo=".$cod_clase;
                    
    $query = mysql_query($queryString);

    if($query){
      if(actualizarDias($dias,$cod_clase)){
        $mensaje = "<strong>¡Éxito! </strong> Se ha actualizado la clase.";
      }else{
        $mensaje = "<strong>¡Error! </strong> Error al actualizar días.";
        http_response_code(400);
      }
    }
    else{
      $mensaje = "<strong>¡Error! </strong> Error al actualizar la clase.";
      http_response_code(400);
    }
    return $mensaje;
  }

  function actualizarDias($dias, $id){
    $queryString = "DELETE FROM ca_cursos_dias WHERE cod_curso=".$id;
    $query = mysql_query($queryString);
    if(!$query)
        return false;

    foreach($dias as $dia){
      $queryString = "INSERT INTO ca_cursos_dias VALUES (".$id.",".$dia.")";
      $query = mysql_query($queryString);
      if(!$query)
        return false;
    }
    return true;
  }
?>