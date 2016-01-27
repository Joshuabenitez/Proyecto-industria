
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


    $queryString = "SELECT * FROM sa_estudiantes WHERE no_cuenta='".$no_cuenta."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    
    $dni = $row['dni'];
    $aniosEstudioDerecho1 = $row['anios_inicio_estudio'];
    $aniosEstudioDerecho2 = $row['anios_final_estudio'];
    $aniosEstudiosFinal1 = $row['aniosDerecho1'];
    $aniosEstudiosFinal2 = $row['aniosDerecho2'];

    $indice_academico = $row['indice_academico'];
    $fecha_registro = $row['fecha_registro'];
    $uv_acumulados = $row['uv_acumulados'];
    $cod_plan_estudio = $row['cod_plan_estudio'];
    $cod_ciudad_origen = $row['cod_ciudad_origen'];
    $cod_orientacion = $row['cod_orientacion'];
    $cod_residencia_actual = $row['cod_residencia_actual'];
    $grupoEtnico = $row['grupo_etnico'];
    $carreraAnterior = $row['carrera_anterior'];

    $correo = obtenerCorreo($dni);
    $tipo = obtenerTipo($dni);
    $mencion = obtenerMencion($dni);
    $telefono = obtenerTelefono($dni);
    
    $Primer_nombre = "";
    $Segundo_nombre = "";
    $Primer_apellido = "";
    $Segundo_apellido = "";
    $Sexo = "";
    $Fecha_nacimiento = "";
    $Estado_Civil = "";
    $Nacionalidad = "";
    $Direccion = "";
    $personales = obtenerPersonales($dni);

    $arreglo = array( 'no_cuenta' => $no_cuenta,
                      'dni' => $dni,
                      'aniosEstudioDerecho1' => $aniosEstudioDerecho1,
                      'ịndice_academico' => $indice_academico,
                      'fecha_registro' => $fecha_registro,
                      'uv_acumulados' => $uv_acumulados,
                      'cod_plan_estudio' => $cod_plan_estudio,
                      'cod_ciudad_origen' => $cod_ciudad_origen,
                      'cod_orientacion' => $cod_orientacion,
                      'cod_residencia_actual' => $cod_residencia_actual,
                      'tipo' => $tipo,
                      'correo' => $correo,
                      'mencion' => $mencion,
                      'telefono' => $telefono,

                      'Primer_nombre' => $personales[0],
                      'Segundo_nombre' => $personales[1],
                      'Primer_apellido' => $personales[2],
                      'Segundo_apellido' => $personales[3],
                      'Sexo' => $personales[4],
                      'Fecha_nacimiento' => $personales[5],
                      'Estado_Civil' => $personales[6],
                      'Nacionalidad' => $personales[7],
                      'Direccion' => $personales[8],
                      'aniosEstudioDerecho2' => $aniosEstudioDerecho2,
                      'grupoEtnico' => $grupoEtnico,
                      'carreraAnterior' => $carreraAnterior,
                       'aniosEstudiosFinal1' => $aniosEstudiosFinal1,
                       'aniosEstudiosFinal2' => $aniosEstudiosFinal2

                      );

    // $arreglo = explode(',',$mensaje);
    echo json_encode($arreglo);

    
    // echo $mensaje;
  }catch(PDOExecption $e){
    $mensaje = "<strong>¡Error! </strong> Error al actualizar la clase.";
    $codMensaje = 0;
    echo $mensaje;
    http_response_code(500);
  }

  function obtenerCorreo($dni){
    $queryString = "SELECT Correo_Electronico from persona where N_Identidad ='".$dni."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['Correo_Electronico'];
  }

  function obtenerMencion($dni){
    $queryString = "SELECT codigo FROM sa_menciones_honorificas WHERE codigo in (SELECT cod_mencion FROM sa_estudiantes_menciones_honorificas WHERE dni_estudiante ='".$dni."')";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['codigo'];
  }

  function obtenerTipo($dni){
    $queryString = "SELECT codigo_tipo_estudiante FROM sa_estudiantes_tipos_estudiantes WHERE dni_estudiante ='".$dni."' ORDER BY fecha_registro DESC LIMIT 0, 1";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['codigo_tipo_estudiante'];
  }

  function obtenerPersonales($dni){
    $queryString = "SELECT * FROM 
            persona p INNER JOIN sa_estudiantes e ON p.N_Identidad = e.dni WHERE e.dni = '".$dni."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    $Primer_nombre = $row['Primer_nombre'];
    $Segundo_nombre = $row['Segundo_nombre'];
    $Primer_apellido = $row['Primer_apellido'];
    $Segundo_apellido = $row['Segundo_apellido'];
    $Sexo = $row['Sexo'];
    $Fecha_nacimiento = $row['Fecha_nacimiento'];
    $Estado_Civil = $row['Estado_Civil'];
    $Nacionalidad = $row['Nacionalidad'];
    $Direccion = $row['Direccion'];

    // return $row['Primer_nombre'].",".$row["Segundo_nombre"].",".$row["Primer_apellido"].",".$row["Segundo_apellido"].",".
    //         $row['Sexo'].",".$row['Fecha_nacimiento'].",".$row['Estado_Civil'].",".$row['Nacionalidad'].",".$row['Direccion'];
    
    return array( $row['Primer_nombre'],$row["Segundo_nombre"],$row["Primer_apellido"],$row["Segundo_apellido"],
            $row['Sexo'],$row['Fecha_nacimiento'],$row['Estado_Civil'],$row['Nacionalidad'],$row['Direccion']);

  }
  
  function obtenerTelefono($dni){
    $queryString = "SELECT Numero FROM telefono WHERE N_Identidad = '".$dni."'";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['Numero'];
  }  
?>