
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
    $dias = explode(',',$strDias);


    $queryString = "SELECT N_Identidad FROM empleado e WHERE no_empleado='".$no_empleado."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    
    $dni_empleado = $row['N_Identidad'];
    
    $mensaje = insertarClase($cod_asignatura,$cod_seccion,$cod_aula,$no_empleado,$dni_empleado,$cupos,$cod_carga,$dias);
    echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al guardar la clase." . $e;
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function insertarClase($cod_asignatura,$cod_seccion,$cod_aula,$no_empleado,$dni_empleado,$cupos,$cod_carga,$dias){
    $queryString = "INSERT INTO ca_cursos (cod_asignatura,cod_seccion,cod_aula,no_empleado,dni_empleado,cupos,cod_carga) 
                    VALUES (".$cod_asignatura.",".$cod_seccion.",".$cod_aula.",'".$no_empleado."','".$dni_empleado."',".$cupos.",".$cod_carga.")";
                    
    $query = mysql_query($queryString);

    if($query){
      $id=mysql_insert_id();

      if(insertarDias($dias,$id)){
        $mensaje = "<strong>¡Éxito! </strong> Se ha guardado la clase.";
      }else{
        $mensaje = "<strong>¡Error! </strong> Error al guardar.";
        http_response_code(400);
      }
    }
    else{
      $mensaje = "<strong>¡Error! </strong> Error al guardar.";
      http_response_code(400);
    }
    return $mensaje;
  }

  function  insertarDias($dias, $id){
    foreach($dias as $dia){
      $queryString = "INSERT INTO ca_cursos_dias VALUES (".$id.",".$dia.")";
      $query = mysql_query($queryString);
      if(!$query)
        return false;
    }
    return true;
  }
?>