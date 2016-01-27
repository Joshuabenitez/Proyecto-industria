<?php
  include '../../../conexion/config.inc.php';
?>

<?php          
$codIA = $_POST['codIA'];

if(!isset($_SESSION)){
    session_start();
}

$_SESSION['aula'] = $codIA;
//echo $_SESSION['aula'];
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
            var data1 = {
              "nombreInstanciaA":$('select[name=acon]').val()
            };

            $.ajax({
              async: true,
              type: "POST",
              url: "pages/CargaAcademica/Instancias_Acondicionamientos/ca_registrarInstanciaAcondicionamiento.php",
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

                $('#tbody').load("pages/CargaAcademica/Instancias_Acondicionamientos/ca_cargarTablaInstanciaAcondicionamiento.php");

                $('#nombreInstanciaA').val('');
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
        $('#tblInstanciaA').dataTable({
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
         }); // example es el id de la tabla
      });
    </script>

    <!--<script type="text/javascript">
        $(document).on("click",".editar",function () {
          codigoAP = $(this).parents("tr").find("td").eq(0).text().trim();
          nombreAP = $(this).parents("tr").find("td").eq(1).text().trim();

          $("#codInstanciaA").val(codigoAP);
          $("#nomInstanciaA").val(nombreAP);                
          $("#editarModal").modal('show');
        });
      </script>
      -->
    <!--<script type="text/javascript">
      function actualizarInstanciaA()
      {
        //alert('alert');
        var data2 = {
          "codInstanciaA":$('#codInstanciaA').val(),
          "nomInstanciaA":$('#nomInstanciaA').val()
        };
        //alert(data2);
        $.ajax({
          async: true,
          type: "POST",
          // dataType: "html",
          // contentType: "application/x-www-form-urlencoded",
          url: "pages/CargaAcademica/Instancias_Acondicionamientos/ca_editarAcondicionamiento.php",
          data: data2,
          success: function(data){
            //alert(data);
            $('#notificaciones').html(data);

            setTimeout(function() { 
              $(".content").fadeIn(1500);
            },500);
            
            setTimeout(function() {
              $(".content").fadeOut(1500);
            },1500);

            $('#editarModal').modal('hide');
            $('#tbody').load("pages/CargaAcademica/Instancias_Acondicionamientos/ca_cargarTablaInstanciaA.php");
          },
          timeout: 4000
        }); 
      }
    </script>
    -->
   
   <script type="text/javascript">
      $(document).on("click",".elimina",function () {
        var respuesta = confirm("¿Esta seguro de que desea eliminar el registro seleccionado?");
        if (respuesta)
        {
          codigoAP = $(this).parents("tr").find("td").eq(0).text().trim();
          var data3 = 
          {
            "codInstanciaA":codigoAP
          };

          $.ajax({
          async: true,
          type: "POST",
          url: "pages/CargaAcademica/Instancias_Acondicionamientos/ca_eliminarInstanciaAcondicionamiento.php",
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

              $('#tbody').load("pages/CargaAcademica/Instancias_Acondicionamientos/ca_cargarTablaInstanciaAcondicionamiento.php");
            },
            timeout: 4000
          }); 
        } 
      });
    </script>
    <script type="text/javascript">
      $(document).on("click","#retornoInstancia",function() {
       $.ajax({
        async:true,
        type: "POST",
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",
        success:llegadaCrear,
        timeout:4000
        }); 
        return false;  
      });
       
      function llegadaCrear()
      {
        $("#contenedor").load('pages/CargaAcademica/Acondicionamientos/ca_index_Acondicionamiento.php');
      }
    </script>
    
  </head>
  <body>

    <input type="hidden" id="codIA" value="<?php echo trim($codIA); ?>">     
    <div class="panel panel-default">
      <a id="retornoInstancia" href="#"><i class="fa fa-table fa-fw"></i>Regresar a Instancias </strong></a>              
    </div>
    
    <div class="col-lg-12">
      <h1 class="page-header">Acondicionamiento del aula</h1>
    </div>  
    <div class="panel panel-default">
      <div class="panel-body"> 
        <div class="conteiner">
          <div class="col-md-12" class="vertical-line">
            <form >
              <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">Agregar nuevo acondicionamiento al aula</button>   
              <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                      <h4 class="modal-title" id="facultadR">Agregar nuevo acondicionamiento al aula</h4>
                    </div>
                    <div class="modal-body">
                      <form id = "form" name="form" method="POST">
                        <div class="form-group">
                          <label for="message-text" class="control-label">Acondicionamiento:</label>
                          <select class="form-control" id="acon" name="acon">
                                                <?php
                                                    $sql4 = "SELECT `codigo`, `nombre` FROM `ca_acondicionamientos`";
                                                    $rec3 =$db->prepare($sql4);
                                                    $rec3->execute();
                                                    while ($row = $rec3->fetch()) {
                                                            echo "<option value=$row[codigo]>";
                                                            echo $row['nombre'];
                                                            echo "</option>";
                                                    }
                                                ?>
                                            </select>    
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
            <div class="panel-heading"><h4 > <b>Acondicionamientos del aula </b></h4></div>
              <form >
                <div  class="content" id= "notificaciones" style="display:none;"></div>
                <div class="panel-body">
                  <div class="col-lg-12">
                    <div class="form-group" >
                      <div class="box-body table-responsive">
                        <table class="table table-bordered table-hover table-striped" id="tblInstanciaA" >
                          <thead>
                              <tr align="center" height="50px">
                                  <th hidden>Item</th>
                                  <th>Aula</th>
                                  <th>Acondicionamiento</th>
                                  <!--<th>Instancia</th> -->
                                  <th>Eliminar</th>                           
                              </tr>
                          </thead>
                          <tbody id="tbody">
                            <?php include 'ca_cargarTablaInstanciaAcondicionamiento.php'; ?>
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
            <h4 class="modal-title" id="facultadE">Editar Instancia-Acondicionamiento</h4>
          </div>
          <div class="modal-body">
            <form id = "formEditar" name="formEditar">
              <div class="form-group">
                <label for="message-text" class="control-label">Código:</label>
                <input type="text" class="form-control" name="codInstanciaA"  id="codInstanciaA" style="text-align:left" disabled>
              </div>
              <div class="form-group">
                <label for="message-text" class="control-label">Nuevo nombre:</label>
                <input type="text" class="form-control" name="nomInstanciaA" id="nomInstanciaA" style="text-align:left" required>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button id="btnActualizar" onclick="actualizarInstanciaA()" class="btn btn-success"  type="button" class="btn btn-primary">Guardar</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

