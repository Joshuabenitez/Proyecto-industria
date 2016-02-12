<?php
include '../../../conexion/config.inc.php';
?>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="pages/CargaAcademica/Secciones/scripts.js"></script>

    <script type="text/javascript" src="js/jquery.js"></script>
  </head>
  <body>
      <!-- .panel-heading -->
      <div class="panel-body">
        <div class="panel-group" id="accordion">
          <h2>Secciones</h2>
          <div name="alerta" id="alerta"></div>
          <div class="row">
            <form role="form" id="form" name="form" class="form-horizontal">
              <div class="col-md-12">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Crear/Modificar Sección </label>
                    <div style="color:#CCCCCC">
                      <input type="checkbox" id="modificando" name="modificando" disabled="true" /> Modificando
                    </div>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div class="form-group" id="datosSeccion">
                      <div class="col-sm-4">
                        <label>Sección</label>
                        <input type="number" id="seccion" class="form-control" name="seccion" onkeypress="return justNumbers(event);"/>
                      </div>

                      <div class="col-sm-4">
                        <label>Hora de Inicio</label>
                        <input type="time" id="hora_i" class="form-control" name="hora_i" placeholder="HH:MM"/>
                      </div>

                      <div class="col-sm-4">
                        <label>Hora de Fin </label>
                        <input type="time" id="hora_f" class="form-control" name="hora_f" placeholder="HH:MM"/>
                      </div>
                    </div>
                    <div class="col-sm-12" align="center">
                      <input type="button" name="guardar" id="guardar" value="Guardar" dir="pages/CargaAcademica/Secciones/guardarSeccion.php" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
                      <input type="button" name="nuevo" id="nuevo" value="Nuevo" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
                    </div>
                  </div>
                </div>
              </div>
              <!-- TABLA DE CLASES CREADAS-->
              <label class="col-sm-12 control-label"></label>

              <div class="col-md-12">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Secciones </label>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div id="paginador"></div>
                    <div class="box-body table-responsive">
                      <table id="secciones" class='table table-bordered table-striped'>
                        <?php include ("../../../pages/CargaAcademica/Secciones/cargarSecciones.php"); ?>
                      </table>
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
