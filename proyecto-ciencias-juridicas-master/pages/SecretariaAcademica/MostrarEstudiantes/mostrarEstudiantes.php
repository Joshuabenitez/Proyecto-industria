<?php
include ('../../../conexion/config.inc.php');
?>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="pages/SecretariaAcademica/MostrarEstudiantes/scripts.js"></script>
    
    
  </head>
  <body>
      <!-- .panel-heading -->
      <div class="panel-body">
        <div id = "notificaciones"></div>
        <div class="panel-group" id="accordion">
          <h2>Mostrar Estudiantes</h2>
          <div name="alerta" id="alerta"></div>
          <div class="row">
            <form role="form" id="form" name="form" class="form-horizontal">
            <div>
              <div class="col-sm-3">
                  <input type="button" name="nuevo" id="nuevo" value="Registrar Nuevo Estudiante" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
              </div>
            </div>
              <!-- TABLA DE ESTUDIANTES CREADAS-->
              <label class="col-sm-12 control-label"></label>

              <div class="col-md-12">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Estudiantes </label>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div id="paginador"></div>
                    <div class="box-body table-responsive">
                      <table id="estudiantes" class='table table-bordered table-striped'>
                        <?php include ("../../../pages/SecretariaAcademica/MostrarEstudiantes/cargarEstudiantes.php"); ?>
                      </table>
                    </div>
                    <div class="col-sm-3">
                      <input type="button" name="GenerarDocumentos" id="GenerarDocumentos" value="Exportar PDF" class="ActualizarB btn btn-primary"/>
                    </div>
                  </div> 
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </body>
  </html>

  