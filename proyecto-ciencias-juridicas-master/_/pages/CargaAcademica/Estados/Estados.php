<?php
  include '../../../Datos/conexion.php';
?>
<!DOCTYPE html>
<html lang="es">
  <head>

    <meta charset="UTF-8">
    <title>Estados de carga academica</title>
    

    <!--Funcion que permite insertar un area en la base de datos, 
    se genera al presionar el boton guardar del modal agregar-->
    <script type="text/javascript">
      $(document).ready(function(e) {
        $("form").submit(//Se realiza cuando se ejecuta un "submit" en el formulario, el "submit" se encuentra en el boton "Envíar Solicitud
        function(e) {
            e.preventDefault();    
            /*Se envian los parametros que necesita el procedimiento almacenado*/
            var data1 = {
                  "nombreEstado":$('#nombreEstado').val()
                };
            /*Se carga contenido ca_registrar_Areas_de_Proyecto*/
            $.ajax({
                async: true,
                type: "POST",
                url: "pages/CargaAcademica/Estados/Registrar_estados.php",
                data: data1,
                success: function(data){
                  /*Se recibe valor devuelto*/
                  $('#notificaciones').html(data);
                  /*Funcion que permita mostrar un alerta en cierto tiempo*/
                  setTimeout(function() {
                  $(".content").fadeIn(1500);
                  },500);
                  /*Funcion que permita ocultar un alerta en cierto tiempo*/
                  setTimeout(function() {
                  $(".content").fadeOut(1500);
                  },500);
                  /*Se esconde el modal agregar area*/
                  $('#EstadoModal').modal('hide');
                  /*Se recarga contenido de la tabla*/
                  $('#tbody').load("pages/CargaAcademica/Estados/Cargar_estados.php");
                  $('#nombreEstado').val('');
                },
                timeout: 4000
            }); 
        });
      });
    </script>

    <!--Funcion que permite agregar un estilo Datatable-->
    <script type="text/javascript">
      $(document).ready(function() {
      $('#tblEstados').dataTable({
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
         });
      });
    </script>

    <!--Funcion que se sucede al dar click sobre el boton editar del Datatable-->
    <script type="text/javascript">
      $(document).on("click",".editarEstados",function () {
        /*Se extrae valor de codigo y nombre, del datatable*/
        codigoAP = $(this).parents("tr").find("td").eq(0).text().trim();
        nombreAP = $(this).parents("tr").find("td").eq(1).text().trim();
        /*Se asigna valor extraido a sus respectivos input, en el modal editar*/
        $("#codEstado").val(codigoAP);
        $("#nomEstado").val(nombreAP); 
        /*Se abre el modal editar*/               
        $("#editarModal").modal('show');
          });
    </script>

    <!--Funcion que permite modificar un area, se genera al presionar el boton guardar del modal editar-->
    <script type="text/javascript">
      function actualizarEstado()
      {
        /*Se envian los parametros que necesita el procedimiento almacenado*/
        var data2 = {
        "codEstado":$('#codEstado').val(),
        "nomEstado":$('#nomEstado').val()
        };
        /*Se carga contenido ca_editar_Areas_de_Proyecto*/
        $.ajax({
          async: true,
          type: "POST",
          url: "pages/CargaAcademica/Estados/Modificar_estados.php",
          data: data2,
          success: function(data){
              /*Se recibe valor devuelto*/
              $('#notificaciones').html(data);
              /*Funcion que permita mostrar un alerta en cierto tiempo*/
              setTimeout(function() {
              $(".content").fadeIn(1500);
              },500);
              /*Funcion que permita ocultar un alerta en cierto tiempo*/
              setTimeout(function() {
              $(".content").fadeOut(1500);
              },1500);
              /*Se esconde el modal agregar area*/
              $('#editarModal').modal('hide');
              /*Se recarga contenido de la tabla*/
              $('#tbody').load("pages/CargaAcademica/Estados/Cargar_estados.php");
            },
            timeout: 4000
          }); 
      }
    </script>


    <!--Funcion que permite modificar un area, se genera al presionar el boton guardar del modal editar-->
    <script type="text/javascript">
      $(document).on("click",".eliminaEstados",function () {
        /*Muestra un mensaje, con el contenido espesificado*/
        var respuesta = confirm("¿Esta seguro de que desea eliminar el registro seleccionado?");
        if (respuesta)
        {
          /*Se obtiene el valor selccionado del datatable*/
          codigoAP = $(this).parents("tr").find("td").eq(0).text().trim();
          /*Se envian los parametros que necesita el procedimiento almacenado*/
          var data3 = 
          {
            "codEstado":codigoAP
          };
          /*Se carga contenido ca_editar_Areas_de_Proyecto*/
          $.ajax({
          async: true,
          type: "POST",
          url: "pages/CargaAcademica/Estados/Eliminar_estados.php",
          data: data3,
          success: function(data){
            /*Se recibe valor devuelto*/
            $('#notificaciones').html(data);
            /*Funcion que permita mostrar un alerta en cierto tiempo*/
            setTimeout(function() {
            $(".content").fadeIn(1500);
            },500);
            /*Se esconde el modal agregar area*/
            setTimeout(function() {
              $(".content").fadeOut(1500);
              },1500);
              /*Se esconde el modal agregar area*/
              $('#editarModal').modal('hide');
              /*Se recarga contenido de la tabla*/
              $('#tbody').load("pages/CargaAcademica/Estados/Cargar_estados.php");
            },
            timeout: 4000
          }); 
        } 
      });
    </script>
  </head>

  <body> 
      <div class="row"> 
        <!---->
        <div class="panel panel-default">
          <div class="panel-body">
              <div class="col-lg-8">
                  <button type="button" class="btn btn-success" data-toggle="modal" data-target="#EstadoModal" data-whatever="@mdo">Agregar nuevo estado</button>  
              </div>
          </div>
        </div> 
        <!--Datatable con el contenido de la tabla ca_areas-->
        <div class="panel panel-default">
          <div class="panel-heading">
              <h4><b>Estados de carga académica</b></h4>
          </div>
          <!--Se recibe mensaje de procedimiento almacenado-->
          <div  style="display:none" class="content" id= "notificaciones"></div>
          <!--Contenido de tabla-->
          <div class="panel-body">
            <table class="table table-bordered table-hover table-striped" id="tblEstados" >
              <thead>
                <tr align="center" height="50px">
                  <th>Codigo</th>
                  <th>Nombre</th>
                  <th>Editar</th>
                  <th>Eliminar</th>                           
                </tr>
              </thead>
              <tbody id="tbody">
                <?php include 'Cargar_estados.php';?>
              </tbody>
            </table>   
          </div>
        </div> 
        <!--Modal agregar estados-->
        <div class="modal fade" id="EstadoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
              <div class="modal-content">
                  <form role="form" id="form" name="form" >
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Agregar nuevo estado</h4>
                      </div>
                      <div class="modal-body">
                          <div class="form-group">
                              <label for="message-text" class="control-label">Nombre</label>
                              <input type="text" class="form-control" id="nombreEstado"  placeholder="Nombre de estado" required>
                          </div>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <button id = "submit" class="btn btn-success" type="submit" class="btn btn-primary">Guardar</button>
                      </div>
                  </form>
              </div>
          </div>
        </div>
        <!-- Modal para Editar -->
        <div class="modal fade" id="editarModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
              <div class="modal-content">
                  <form role="form" id = "formEditar" name="formEditar" >
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Editar estado</h4>
                      </div>
                      <div class="modal-body">
                          <div class="form-group">
                            <input type="hidden" class="form-control" name="codEstado"  id="codEstado" style="text-align:left" disabled>
                          </div>
                          <div class="form-group">
                            <label for="message-text" class="control-label">Nuevo nombre:</label>
                            <input type="text" class="form-control" name="nomEstado"  id="nomEstado" style="text-align:left" required>
                          </div>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <button id="btnActualizar" onclick="actualizarEstado()" class="btn btn-success"  type="button" class="btn btn-primary">Guardar</button>
                      </div>
                  </form>
              </div>
          </div>
        </div>
      </div>
  </body>
</html>