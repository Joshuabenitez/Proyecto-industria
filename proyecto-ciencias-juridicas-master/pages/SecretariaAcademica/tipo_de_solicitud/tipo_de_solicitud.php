<?php
  include '../../../Datos/conexion.php';
?>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Tipo de Solicitud</title>

    <script type="text/javascript">
      $(document).ready(function(e) {
        $("form").submit(//Se realiza cuando se ejecuta un "submit" en el formulario, el "submit" se encuentra en el boton "Envíar Solicitud
        function(e) {
          e.preventDefault();    
          var data1 = {"nombreSolicitud":$('#nombreSolicitud').val(),
                        "codTipoEstudiante":$('#codTipoE').val() };

          $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/tipo_de_solicitud/sa_registrar_tipo_de_solicitud.php",
            data: data1,
            success: function(data){

              $('#notificaciones').html(data);

              setTimeout(function() {
              $(".content").fadeIn(1500);
              },500);

              setTimeout(function() {
              $(".content").fadeOut(1500);
              },500);

              $('#exampleModal').modal('hide');
              $('#tbody').load("pages/SecretariaAcademica/tipo_de_solicitud/sa_recargarTablaSolicitud.php");

              $('#nombreSolicitud').val('');
            },
              timeout: 4000
          }); 
            //La función implemente ajax para enviar la información a otros 
            //documentos que realizaran otros procedimientos sin necesidad de refrescar toda la pagina
        });
      });
    </script>

    <script type="text/javascript">
      $(document).ready(function() {
        $('#tblSolicitudes').dataTable({
            dom: 'Blfrtip',
        buttons: [

            {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: [ 0, ':visible' ]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                    columns: ':visible'
                },
                download: 'open'
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: ':visible'
                },
                download: 'open'
            },
            {
                extend: 'print',
                exportOptions: {
                    columns: ':visible'
                }
            },
            'colvis'
        ]
         }
    </script>

    <script type="text/javascript">
      $(document).on("click",".editarSolicitud",function () {
        codigoAP = $(this).parents("tr").find("td").eq(0).text().trim();
        nombreAP = $(this).parents("tr").find("td").eq(1).text().trim();

        $("#codSolicitud").val(codigoAP);
        $("#nomSolicitud").val(nombreAP);                
        $("#editarModal").modal('show');
      });
    </script>

    <script type="text/javascript">
      function actualizarTipo(){
        var data2 = {
          "codSolicitud":$('#codSolicitud').val(),
          "nomSolicitud":$('#nomSolicitud').val()
        };

        $.ajax({
          async: true,
          type: "POST",
          url: 'pages/SecretariaAcademica/tipo_de_solicitud/sa_editar_tipo_de_solicitud.php',
          data: data2,
          success: function(data){
            $('#notificaciones').html(data);
             setTimeout(function() {
              $(".content").fadeIn(1500);
            },500);

            setTimeout(function() {
              $(".content").fadeOut(1500);
            },1500);

            $('#editarModal').modal('hide');
            $('#tbody').load("pages/SecretariaAcademica/tipo_de_solicitud/sa_recargarTablaSolicitud.php");
          }
        }); 
      }

    </script>
   
   <script type="text/javascript">
      $(document).on("click",".eliminaSolicitud",function () {
        var respuesta = confirm("¿Esta seguro de que desea eliminar el registro seleccionado?");
        if (respuesta)
        {
          codigoAP = $(this).parents("tr").find("td").eq(0).text().trim();
          var data3 = {
            "codSolicitud":codigoAP
          };

          $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/tipo_de_solicitud/sa_eliminar_tipo_de_solicitud.php",
            data: data3,
            success: function(data){

              $('#notificaciones').html(data);

              setTimeout(function() {
                $(".content").fadeIn(1500);
              },500);

              setTimeout(function() {
                $(".content").fadeOut(1500);
              },1500);

              $('#editarModal').modal('hide');

              $('#tbody').load("pages/SecretariaAcademica/tipo_de_solicitud/sa_recargarTablaSolicitud.php");
            },
            timeout: 4000
          }); 
        } 
      });
    </script>

  </head>

  <body>
    <div class="col-lg-12">
      <h1 class="page-header">Tipo de Solicitudes</h1>
    </div>  
    <div class="panel panel-default">
      <div class="panel-body"> 
        <div class="conteiner">
          <div class="col-md-12" class="vertical-line">
            <form >
              <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">Agregar Nuevo Tipo de solicitud</button>   
              <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                      <h4 class="modal-title" id="solicitud">Agregar Nuevo Tipo de Solicitud</h4>
                    </div>
                    <div class="modal-body">
                      <form  id = "form" name="form" method="POST">
                        <div class="form-group">
                          <label for="message-text" class="control-label">Nombre:</label>
                          <input type="text" class="form-control" id="nombreSolicitud"  placeholder="Nombre" required>
                          <br>
                          <label for="message-text" class="control-label">Nivel Académico:</label>
                          <select class="form-control" id="codTipoE" name="codTipoE">
                            <?php include'sa_cargar_combobox.php'; ?>
                          </select>
                          <br>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                          <button id = "submit" class="btn btn-success" type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </form>
          </div>
          <div class="col-md-12">
            <hr>
            <div class="panel panel-default">
              <div class="panel-heading">
                <h4 > <b>Mis Tipos de Solicitudes </b></h4>
              </div>
              <form >
                <div  class="content" id= "notificaciones" style="display:none;"></div>
                <div class="panel-body">
                  <div class="col-lg-12">
                    <div class="form-group" >
                      <div class="box-body table-responsive">
                        <table class="table table-bordered table-hover table-striped" id="tblSolicitudes" >
                          <thead>
                              <tr align="center" height="50px">
                                  <th>Codigo</th>
                                  <th>Nombre</th>
                                  <th>Editar</th>
                                  <th>Eliminar</th>                           
                              </tr>
                          </thead>
                          <tbody id="tbody">
                            <?php include 'sa_recargarTablaSolicitud.php'; ?>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade" id="editarModal" tabindex="-1" role="dialog" aria-labelledby="editarModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="solicitud">Editar Tipo de Solicitud</h4>
          </div>
          <div class="modal-body">
            <form id = "formEditar" name="formEditar">
              <div class="form-group">
                <label for="message-text" class="control-label">Código:</label>
                <input type="text" class="form-control" name="codSolicitud"  id="codSolicitud" style="text-align:left" disabled>
              </div>
              <div class="form-group">
                <label for="message-text" class="control-label">Nuevo nombre:</label>
                <input type="text" class="form-control" name="nomSolicitud" id="nomSolicitud" style="text-align:left" required>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button id="btnActualizar" onclick="actualizarTipo()" class="btn btn-success"  type="button" class="btn btn-primary">Guardar</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

