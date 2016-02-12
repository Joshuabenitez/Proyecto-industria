
<!-- inserta el usuario en la base de datos -->
<?php
  // <!-- Declaramos la direccion raiz -->
  session_start() ;
  $maindir = "../../../";

  //acceso a bases de datos
  include ($maindir.'conexion/config.inc.php');
  if(!isset($_SESSION['auntentificado']) ) {
      header("location: ../../../login/login.php?error_code=2");
   }

 function crypt_blowfish($password, $digito = 7) {
     $set_salt = './1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
     $salt = sprintf('$2a$%02d$', $digito);
     for($i = 0; $i < 22; $i++)
     {
         $salt .= $set_salt[mt_rand(0, 63)];
     }
     return crypt($password, $salt);
 }

 // $empleado = $_POST["empleado"];
   $nombreUsuario = $_POST["nombreUsuario"];
   $password = $_POST["password"];
   $rol = (int)$_POST["rol"];
   $fecha_creacion=date("Y/m/d");


  // Algunas validaciones
  if($nombreUsuario == "" or $password == ""){
    $mensaje="Por favor introduzca un nombre de usuario y password validos";
        $codMensaje =0;
    }
    // elseif($empleado == -1){
    //     $mensaje="Por favor seleccione un empleado valido";
    //     $codMensaje =0;
    // }
    elseif($rol == -1){
        $mensaje="Por favor seleccione un rol valido";
        $codMensaje =0;
    }
    else{

    try{
      // realizamos la consulta
      $password = crypt_blowfish($password);
      $query = $db->prepare("insert into usuario (usuario, contrasena, rol_ID, fecha_creacion, estado) VALUES ('".$nombreUsuario."','".$password."','".$rol."','".$fecha_creacion."',1);");
      // $result = mysql_query($query, $conexion) or die("error en la consulta");
      $query->execute();
      $mensaje = "El usuario se ha creado exitosamente...";
      $codMensaje = 1;

    }catch(PDOExecption $e){
      $mensaje="No se ha procesado su peticion, comuniquese con el administrador del sistema";
      $codMensaje =0;
    }
    }

  if(isset($codMensaje) and isset($mensaje)){
    if($codMensaje == 1){
      echo '<div class="alert alert-success alert-succes">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Exito! </strong>'.$mensaje.'</div>';
    }else{
      echo '<div class="alert alert-danger alert-error">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <strong> Error! </strong>'.$mensaje.'</div>';
    }
  }
?>
<!-- efecto de alerta temporal -->
<script type="text/javascript">
  // setTimeout(function() {
  //   $("#notificaciones").fadeOut(1500);
  // },4000);
</script>
