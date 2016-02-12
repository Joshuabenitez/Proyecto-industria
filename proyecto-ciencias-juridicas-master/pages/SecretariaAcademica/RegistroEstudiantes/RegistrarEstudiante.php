
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
  try{
      $identidad = $_POST['identidad'];
      $primerNombre =  $_POST['primerNombre'];
      $segundoNombre = $_POST['segundoNombre'];
      $primerApellido = $_POST['primerApellido'];
      $segundoApellido = $_POST['segundoApellido'];
      $sexo = $_POST['sexo'];
      $fNac = $_POST['fecha'];
      $telefono = $_POST['telefono'];
      $correo = $_POST['correo'];
      $estCivil = $_POST['estCivil'];
      $nacionalidad = $_POST['nacionalidad'];
      $direccion = $_POST['direccion'];
      $ciudadOrigen = $_POST['ciudadOrigen'];
      $residenciaActual = $_POST['residenciaActual'];
      $numeroCuenta = $_POST['numeroCuenta'];

      $tipoEstudiante = $_POST['tipoEstudiante'];
      $planEstudio = $_POST['planEstudio'];
      $unidadesValorativas = $_POST['unidadesValorativas'];
      $aniosEstudioInicio = $_POST['aniosEstudioInicio1'];
      $aniosEstudioFinal = $_POST['aniosEstudioInicio2'];
      $titulo = $_POST['titulo'];
      $orientacion = $_POST['orientacion'];
      $indiceAcademico = $_POST['indiceAcademico'];
      $mencionHonorifica = $_POST['mencionHonorifica'];

      $grupoEtnico = $_POST['grupoEtnico'];
      $carreraAnterior = $_POST['carreraAnterior'];

      $aniosEstudioFinal1 = $_POST['aniosEstudioFinal1'];
      $aniosEstudioFinal2 = $_POST['aniosEstudioFinal2'];




      $stmt = $db->prepare("CALL SP_REGISTRAR_ESTUDIANTE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@mensajeError)");
          //Introduccion de parametros
          $stmt->bindParam(1, $identidad, PDO::PARAM_STR);
          $stmt->bindParam(2, $primerNombre, PDO::PARAM_STR);
          $stmt->bindParam(3, $segundoNombre, PDO::PARAM_STR);
          $stmt->bindParam(4, $primerApellido, PDO::PARAM_STR);
          $stmt->bindParam(5, $segundoApellido, PDO::PARAM_STR);
          $stmt->bindParam(6, $fNac, PDO::PARAM_STR);
          $stmt->bindParam(7, $sexo, PDO::PARAM_STR);
          $stmt->bindParam(8, $ciudadOrigen, PDO::PARAM_INT);
          $stmt->bindParam(9, $residenciaActual, PDO::PARAM_INT);
          $stmt->bindParam(10, $numeroCuenta, PDO::PARAM_STR);
          $stmt->bindParam(11, $correo, PDO::PARAM_STR);
          $stmt->bindParam(12, $tipoEstudiante, PDO::PARAM_STR);
          $stmt->bindParam(13, $planEstudio, PDO::PARAM_STR);
          $stmt->bindParam(14, $unidadesValorativas, PDO::PARAM_STR);
          $stmt->bindParam(15, $aniosEstudioInicio, PDO::PARAM_STR);
          $stmt->bindParam(16, $aniosEstudioFinal, PDO::PARAM_STR);
          $stmt->bindParam(17, $indiceAcademico, PDO::PARAM_STR);
          $stmt->bindParam(18, $mencionHonorifica, PDO::PARAM_INT);
          $stmt->bindParam(19, $orientacion, PDO::PARAM_INT);
          $stmt->bindParam(20, $direccion, PDO::PARAM_STR);
          $stmt->bindParam(21, $estCivil, PDO::PARAM_STR);
          $stmt->bindParam(22, $nacionalidad, PDO::PARAM_STR);
          $stmt->bindParam(23, $telefono, PDO::PARAM_STR);
          $stmt->bindParam(24, $titulo, PDO::PARAM_STR);

       $stmt->execute();
       $output = $db->query("select @mensajeError")->fetch(PDO::FETCH_ASSOC);
       $mensaje = $output['@mensajeError'];
       $codMensaje = 0;

        $query1 = $db -> prepare('UPDATE `sa_estudiantes` SET `grupo_etnico`=? ,`carrera_anterior`=?, `aniosDerecho1`=?, `aniosDerecho2`=? WHERE `dni`=?');
        $query1 -> execute(array($grupoEtnico,$carreraAnterior , $aniosEstudioFinal1, $aniosEstudioFinal2, $identidad));



    }catch(PDOExecption $e){
      //$mensaje = 'error al ingresar el registro o registro actualmente existente';
      $codMensaje = 0;
    }

    if($mensaje == NULL)
    {
      echo '<div id = "mensaje" class="alert alert-success alert-succes">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Exito! El usuario se ha creado correctamente</strong></div>';
    }
    else
      {
      echo '<div id = "mensaje" class="alert alert-danger alert-error">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Error! </strong>'.$mensaje.'</div>';
      }

include '../MostrarEstudiantes/mostrarEstudiantes.php';
 ?>
 <script>
  $(document).ready(function(){
        setTimeout(function(){
            $('#mensaje').fadeOut(3000);
        },3000);

      });
</script>
