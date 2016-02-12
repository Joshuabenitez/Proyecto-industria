

<!---INFORMACION DE LA PAGINA- -->


<?php
  session_start() ;
  // <!-- Declaramos la direccion raiz -->
  $maindir = "../../../";

  // <!-- anadimos los archivos necesarios para trabajar-->

  //acceso a bases de datos
  if(!isset($_SESSION['auntentificado']) ) {
    header("location: ../../../login/login.php?error_code=2");
  }
  include ($maindir.'conexion/config.inc.php');

  $id = (int)$_GET['usuario_ID'];

  $query_1 = $db->prepare("select usuario.usuario_ID, usuario.usuario, usuario.rol_ID, usuario.fecha_creacion, fecha_alta, usuario.estado,
            rol.descripcion from usuario INNER JOIN rol ON usuario.rol_ID = rol.rol_ID WHERE usuario.usuario_ID = '".$id."';");
  // $result_1 = mysql_query($query_1, $conexion) or die("erorr consulta sql");
  $query_1->execute();
  $dato1 = $query_1->fetch();

  $dias = array("Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sábado");
  $meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");

  $date = date_create($dato1['fecha_creacion']);

echo "<h3>Usuario: <strong>".$dato1['usuario']."</strong></h3> Ingresado el ".$dias[date_format($date,'w')]." ".date_format($date,'d')." de ".$meses[date_format($date,'n')-1]. " del ".date_format($date,'Y'); ?>
<hr>
<!-- formulario para editar informacion de usuario -->
<form class = "form" role="form" id="form_actualizar">
      <!-- para poder acceder a la variable usuario_ID por javascript -->
      <input type="hidden" id="usuario_ID" name="idUsuario" value="<?php echo $id; ?>">
          <div class="form-group">

          </div>
          <div id="verUserName_actualizar" class="form-group">
            <label>Nombre del usuario</label>
            <input type="hidden" id="nombreUsuarioAnt" name="nombreUsuarioAnt" value="<?php echo $dato1['usuario']; ?>">
            <input type="text" class="form-control" id="nombreUsuario_actualizar" maxlength="30" value="<?php echo $dato1['usuario'] ?>" placeholder="<?php echo $dato1['usuario'] ?>" title = "Solo son permitidos numeros y letras 5 caracteres minimo" pattern="[a-zA-Z0-9]{5,}"autocomplete = "off" required>
          </div>
          <div id="verPass_actualizar" class="form-group">
            <label>Contraseña (Maximo 20 carateres)</label>
            <input type="password" class="form-control" id="password_actualizar" name="password_actualizar" title = "Solo son permitidos numeros y letras 8 caracteres minimo" pattern="[a-zA-Z0-9]{5,}" autocomplete = "off" maxlength="20" required>
          </div>
          <div id="verPass2_actualizar" class="form-group">
            <label class="control-label">Repetir contraseña</label>
            <input type="password" class="form-control" id="password_actualizar2" name="" maxlength="20" required>
          </div>
          <div class="form-group">
            <label class="" for="pwd">Rol del usuario</label>
            <div class="col-sm-10">
                <select id = "rol" class="form-control">
                    <option> -- Seleccione un rol de usuario -- </option>
                    <!-- cargamos los roles desde la base de datos -->
                   <?php
                    $query2 = $db ->prepare("SELECT rol.rol_ID, rol.descripcion FROM rol ");
                    $query2 -> execute();

                    while($row=$query2 ->fetch())
                      { ?>
                       <option <?php if($row['rol_ID'] == $dato1['rol_ID']){ echo 'selected'; } ?> value="<?php echo $row['rol_ID'];?>"> <?php echo $row['descripcion'] ?> </option>
                      <?php  }
                      ?>

                </select>
            </div>
          </div>

          <div class="row form-group " style = "height:35px; margin-top: 50px; margin-button : 5px;" >
            <div class="col-md-4">
              <label>Estado del usuario:  </label>

            </div>
            <div class="col-md-8">
              <?php
              if($dato1['estado'] == 0){
                  echo "<input class = 'bootstrapSwitch bootstrap-switch-wrapper bootstrap-switch-id-switch-state bootstrap-switch-animate bootstrap-switch-on' data-id = '0' data-on-color = 'primary' data-off-color  = 'danger' data-off-text = 'Inactivo' data-on-text = 'activo' type='checkbox' name='my-checkbox'   >  ";
              }else{
                  echo  "<input class = 'bootstrapSwitch bootstrap-switch-wrapper bootstrap-switch-id-switch-state bootstrap-switch-animate bootstrap-switch-on' data-id = '1' data-on-color = 'primary' data-off-color = 'danger' data-off-text = 'Inactivo' data-on-text = 'activo' type='checkbox' name='my-checkbox' checked> ";
              }
              echo "<p>indica si el usuario esta disponible en el sistema</p> ";
              ?>
            </div>
          </div>
          <hr>
          <div class=" form-group clearfix">
              <button id="submit_actualizar_usuario"  class="btn btn-primary pull-right"><i class="glyphicon glyphicon-edit"></i> Actualizar Informacion</button>
          </div>
      </form>
     <!-- final form -->

<script>
$(document).ready(function(){
    var estado = $('[name="my-checkbox"]').data('id');


   $("[name='my-checkbox']").bootstrapSwitch();
   $('[name="my-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
      if (state == true) {
        estado = 1;
      }
      else {
        estado = 0;
      }
   });

    $("#form_actualizar").submit(function(e) {
      if (confirm('Esta seguro que desea modificar este registro?')) {
        e.preventDefault();
        if (validador()) {
           var datos ={
             "usuario":$('#nombreUsuario_actualizar').val(),
             "password":$('#password_actualizar').val(),
             "rol":$('#rol option:selected').val(),
             "estado":estado,
             "usuario_ID":$("#usuario_ID").val()
             // tipoProcedimiento:"insertar"
             // tipoProcedimiento:"actualizar"
           };
           $.ajax({
                   data: datos,
                   url: 'pages/administracion/panel_usuarios/editar_usuario.php',
                   type : 'post',
                   success: function(data) {

                       $("#modal_editar_usuario").modal('hide');
                       $('#notificaciones').html(data);
                     }

                 });
        };
      }//fin de confirm

    });
    //fin del evento submit
});/*fin del ready*/

  // ------validador del formulario------
function validador(){
  var nombre = $("#nombreUsuario_actualizar").val();
  var pass1 = $("#password_actualizar").val();
	var pass2 = $("#password_actualizar2").val();
	// valida si el password es el mismo que se ingreso la segunda vez
	if(pass1 == pass2){
    $("#verPass2_actualizar").removeClass("has-error");
		$("#verPass2_actualizar").find("label").text("Repetir contraseña");
	}else{
    $("#verPass2_actualizar").addClass("has-error");
		$("#verPass2_actualizar").find("label").text("Repetir contraseña: Error la contraseña no coincide");
		$("#").focus();
    return false;
	}

	return true;
}


</script>
