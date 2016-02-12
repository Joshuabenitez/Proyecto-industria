
<!---INFORMACION DE LA PAGINA- -->


<?php
  // <!-- Declaramos la direccion raiz -->
  $maindir = "../../";
  // <!-- anadimos los archivos necesarios para trabajar-->
  //acceso a bases de datos
  if(!isset($_SESSION['auntentificado']) ) {
    header("location: ../../../login/login.php?error_code=2");
   }
    include ($maindir.'conexion/config.inc.php');
  ?>
<!-- =====================cuerpo del panel============================ -->

  <!-- AREA DE NOFIFICACIONES -->
<div id = "notificaciones">
</div>
<!-- - -->

<!-- aqui se cargara la tabla que contendra todos los usuarios -->
<?php require_once('cargar_usuarios.php') ?>



<!-- ===============MODAL PARA INGRESAR NUEVO USUARIO============= -->
<div class="modal fade" id="modal_insertar_usuario" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><i class="glyphicon glyphicon-floppy-disk"></i> Ingreso de Datos del Usuario </h4>
      </div>
      <div class="modal-body">

        <form id = "form_insertar_usuario" class="form" name="form_insertar_usuario"  >
          <div class="form-group">

          <div id="verUserName" class="form-group">
                        <label>Nombre del usuario</label>
                        <input type="text" class="form-control" name = "nombreUsuario" id="nombreUsuario" title = "Solo son permitidos numeros y letras 5 caracteres minimo" minlength="5" pattern="[a-zA-Z0-9]{5,}"autocomplete = "off"required >
                    </div>
          <div id="verPass" class="form-group">
                        <label>Contraseña </label>
                        <input type="password" class="form-control" id="password" name="password"  title = "Solo son permitidos numeros y letras 8 caracteres minimo"  pattern="[a-zA-Z0-9]{5,}" autocomplete = "off"required >
                    </div>
          <div id="verPass2" class="form-group">
                        <label class="control-label">Repetir contraseña</label>
                        <input type="password" class="form-control" id="password2" name="password2" value = "">
                    </div>
          <div id = "verrol"class="form-group">
            <label class="" for="pwd">Rol del usuario</label>
            <div class="col-sm-10">
                <select id = "rol" class="form-control">
                    <?php
                    $default = -1;
                    echo "<option selected value= '-1'> -- Seleccione un rol de usuario -- </option>";
                    $query = $db->prepare("SELECT rol.rol_ID, rol.descripcion FROM rol ");
                    $query ->execute();
                    while($row= $query->fetch())
                      {

                       echo "<option> $row[rol_ID] $row[descripcion] </option>";
                      }
                      ?>
                </select>
            </div>
          </div>
           <div class="modal-footer clearfix">
              <button  id="guardar_usuario" class="btn btn-primary">Agregar</button>
           </div>
        </form>
     <!-- final form -->
      </div>
    </div>
  </div>
</div>
    <!-- fin modal nuevo usuario-->

    <script>
    $(document).ready(function(){
      // tratamiento del submit del formulario ingresar nuevo usuario
      $("#form_insertar_usuario").submit(function(e) {
          e.preventDefault();
        if (validador()) {
          var datos ={
            "nombreUsuario":$('#nombreUsuario').val(),
            "password":$('#password').val(),
            "rol":$('#rol option:selected').val()
            // tipoProcedimiento:"insertar"
          };
          $.ajax({
              data: datos,
              url: 'pages/administracion/panel_usuarios/insertar_usuario.php',
              type : 'post',
              success: function(data) {
                  $("#modal_insertar_usuario").modal('hide');
                  $('#notificaciones').html(data);
                  $('#nombreUsuario').val() = "";
                  $('#password').val() = "";
              }
            });
        };
      });

    //validacion personlizada
     function validador(){
      var pass1 = $("#password").val();
      var pass2 = $("#password2").val();
      var rol = $('#rol option:selected').val();

      $('.form-group').removeClass("has-warning");
      $('.form-group').removeClass("has-error");

      // valida si el password es el mismo que se ingreso la segunda vez
      if(pass1 == pass2){
          $("#verPass2").removeClass("has-error");
          $("#verPass2").find("label").text("Repetir contraseña");

      }else{
          $("#verPass2").addClass("has-error");
          $("#verPass2").find("label").text("Repetir contraseña: Error la contraseña no coincide");
          $("#password2").focus();
          return false;
      }
      //valida si selecciona un rol valido
      if (rol == '-1' ) {
        $("#verrol").addClass("has-error");
        $("#verrol").find("label").text("Selecciona un rol de usuario valido");
        $("#verrol").focus();
        return false;
      } else {
        $("#verrol").removeClass("has-error");
        $("#verrol").find("label").text("-- Seleccione un rol de usuario -- ");
      }
      return true;
    }
    //fin del validador
  });
  // fin del evento ready
  </script>
