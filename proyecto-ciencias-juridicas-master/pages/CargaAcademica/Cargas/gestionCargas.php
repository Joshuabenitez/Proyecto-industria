<?php
include '../../../conexion/config.inc.php';
?>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="pages/CargaAcademica/Cargas/scripts.js"></script>

    <script type="text/javascript" src="js/jquery.js"></script>
  </head>
  <body>
      <!-- .panel-heading -->
      <div class="panel-body">
        <div class="panel-group" id="accordion">
          <h2>Gestión de Cargas</h2>
          <div name="alerta" id="alerta"></div>
          <div class="row">
            <form role="form" id="form" name="form" class="form-horizontal">
              <div class="col-md-8">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Crear/Modificar Carga </label>
                    <div style="color:#CCCCCC">
                      <input type="checkbox" id="modificando" name="modificando" disabled="true" /> Modificando
                    </div>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div class="form-group" id="carga"></div>
                    <div class="form-group" id="listaDocentes">
                      <label class="col-sm-3 control-label">Docente</label>
                      <div class="col-sm-5">
                        <select class="form-control" id="docentes" name="docentes">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT No_Empleado, Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido FROM persona p INNER JOIN empleado e ON p.N_Identidad = e.N_Identidad WHERE (Id_departamento = (SELECT Id_departamento_laboral from departamento_laboral WHERE nombre_departamento = 'Docencia'))");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['No_Empleado']."'>".$row['Primer_nombre']." ".$row["Segundo_nombre"]." ".$row["Primer_apellido"]." ".$row["Segundo_apellido"]."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="listaPeriodos">
                      <label class="col-sm-3 control-label">Período</label>
                      <div class="col-sm-5">
                        <select class="form-control" id="periodos" name="periodos">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT * FROM sa_periodos");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="listaEstados">
                      <label class="col-sm-3 control-label">Estado</label>
                      <div class="col-sm-5">
                        <select class="form-control" id="estados" name="estados">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT * FROM ca_estados_carga");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-1">
                      <input type="button" name="guardar" id="guardar" value="Guardar" dir="pages/CargaAcademica/Clases/guardarClase.php" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
                    </div>
                    <label class="col-sm-1 control-label"></label>
                    <div class="col-sm-1">
                      <input type="button" name="nuevo" id="nuevo" value="Nuevo" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
                    </div>
                  </div>
                </div>
              </div>
              <!-- TABLA DE CLASES CREADAS-->
              <label class="col-sm-8 control-label"></label>

              <div class="col-md-8">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Cargas </label>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div id="paginador"></div>
                    <div class="box-body table-responsive">
                      <table id="cargas" class='table table-bordered table-striped'>
                        <?php include ("../../../pages/CargaAcademica/Cargas/cargarCargas.php"); ?>
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
