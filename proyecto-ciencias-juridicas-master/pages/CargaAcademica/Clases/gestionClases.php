<?php
include '../../../conexion/config.inc.php';
?>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="pages/CargaAcademica/Clases/scripts.js"></script>
    
    <script type="text/javascript" src="js/jquery.js"></script>
  </head>
  <body>
      <!-- .panel-heading -->
      <div class="panel-body">
        <div class="panel-group" id="accordion">
          <h2>Gestión de Clases</h2>
          <div name="alerta" id="alerta"></div>
          <div class="row">
            <form role="form" id="form" name="form" class="form-horizontal">
              <div class="col-md-12">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Crear/Modificar Clase </label>
                    <div style="color:#CCCCCC">
                      <input type="checkbox" id="modificando" name="modificando" disabled="true" /> Modificando
                    </div>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div class="form-group" id="clase"></div>
                    <div class="form-group" id="listaCargasAsignaturas">
                      <label class="col-sm-3 control-label">Carga Académica</label>
                      <div class="col-sm-3">
                        <select class="form-control" id="cargas" name="cargas">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT * FROM ca_cargas_academicas");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['codigo']."'>Carga ".$row['codigo']. " Periodo ".$row['cod_periodo']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                      <label class="col-sm-1 control-label">Asignatura</label>
                      <div class="col-sm-3">
                        <select class="form-control" id="asignaturas" name="asignaturas">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT * FROM clases");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['ID_Clases']."'>".$row['Clase']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="checksDias">
                      <label class="col-sm-3 control-label">Días a impartir</label>
                      <div class="col-sm-6">
                        <input type="checkbox" id="lun" name="lunes" value="1"> Lunes&nbsp;
                        <input type="checkbox" id="mar" name="martes" value="2"> Martes&nbsp;
                        <input type="checkbox" id="mier" name="miercoles" value="3"> Miércoles&nbsp;
                        <input type="checkbox" id="ju" name="jueves" value="4"> Jueves&nbsp;
                        <input type="checkbox" id="vi" name="viernes" value="5"> Viernes&nbsp;
                        <input type="checkbox" id="sa" name="sabado" value="6"> Sábado
                      </div>
                    </div>
                    <div class="form-group" id="listaSecciones">
                      <label class="col-sm-3 control-label">Sección</label>
                      <div class="col-sm-3">
                        <select class="form-control" id="secciones" name="secciones">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT * FROM ca_secciones");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['codigo']."'>".$row['codigo']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="listasEdificiosAulas">
                      <label class="col-sm-3 control-label">Edificio</label>
                      <div class="col-sm-3">
                        <select class="form-control" id="edificios" name="edificios" onchange="cargarAulasPorEdificio(this.value,0)">
                          <option value=0> Seleccione una opción </option>
                          <?php
                            $query = mysql_query("SELECT * FROM edificios");
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['Edificio_ID']."'>".$row['descripcion']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                      <label class="col-sm-1 control-label">Aula</label>
                      <div class="col-sm-2">
                        <select class="form-control" id="aulas" name="aulas">
                          <option value=0> Seleccione una opción </option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="listaDocentes">
                      <label class="col-sm-3 control-label">Docente</label>
                      <div class="col-sm-3">
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
                      <label class="col-sm-1 control-label">Cupos</label>
                      <div class="col-sm-2"><input type="number" id="cupos" class="form-control" name="cupos" onkeypress="return justNumbers(event);"/></div>
                    </div>
                    <label class="col-sm-4 control-label"></label>
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
              <label class="col-sm-1 control-label"></label>

              <div class="col-md-12">
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <h4 class="panel-title">
                      <label>
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Clases </label>
                    </h4>
                  </div>
                  <div class="panel-body">
                    <div id="paginador"></div>
                    <div class="box-body table-responsive">
                      <table id="clases" class='table table-bordered table-striped'>
                        <?php include ("../../../pages/CargaAcademica/Clases/cargarClases.php"); ?>
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