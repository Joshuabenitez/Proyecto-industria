<?php
include '../../../conexion/config.inc.php'
?>
<!DOCTYPE html>
<html>
  <head>

    <script type="text/javascript" src="pages/CargaAcademica/AsignacionProyectos/scripts.js"></script>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
    
    <link href="css/datepicker.css" rel="stylesheet">
    <link href="css/prettify.css" rel="stylesheet">

    
    <script src="js/prettify.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
  </head>
  <body>
      <!-- .panel-heading -->
      <div class="panel-body">
        <div class="panel-group" id="accordion">
          <h2>Asignación de Proyectos</h2>
          <div name="alerta" id="alerta"></div>
          <div class="row">
          <form role="form" id="form" name="form" class="form-horizontal">
            <div class="col-md-6">
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h4 class="panel-title">
                    <label>
                      <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Docentes </label>
                  </h4>
                </div>
                <div class="panel-body">
                  <div class="form-group" id="listaProyectos">
                    <label class="col-sm-6 control-label">Rol</label>
                    <div class="col-sm-6">
                      <select class="form-control" id="roles" name="roles">
                        <option value=0> Seleccione una opción </option>
                        <?php
                          $query = mysql_query("SELECT codigo,nombre FROM ca_roles_proyecto");
                          while($row = mysql_fetch_assoc($query)){
                            echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                          } 
                        ?>
                      </select>
                    </div>
                  </div>
                  <label class="col-sm-6 control-label"> Docentes sin asignación</label><br>
                  <div class="form-group" id="listaDocentes">
                    <div class="col-sm-7"  style="width:100%;">
                      <select class="form-control" id="docentes" name="docentes" style="height:250px" multiple>
                        <?php
                            $stringQuery = "SELECT 
                                                    No_Empleado, 
                                                    Primer_nombre, 
                                                    Segundo_nombre, 
                                                    Primer_apellido, 
                                                    Segundo_apellido 
                                            FROM 
                                                    persona p 
                                                    INNER JOIN empleado e ON p.N_Identidad = e.N_Identidad 
                                                    INNER JOIN departamento_laboral dl ON dl.Id_departamento_laboral = e.Id_departamento 
                                            WHERE 
                                                    e.No_Empleado not in (
                                                            SELECT 
                                                                    No_Empleado 
                                                            FROM 
                                                                    ca_empleados_proyectos
                                                    ) 
                                                    AND dl.nombre_departamento = 'Docencia'";
                            //$query = mysql_query("SELECT No_Empleado, Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido FROM persona p INNER JOIN empleado e ON p.N_Identidad = e.N_Identidad WHERE (Id_departamento = (SELECT Id_departamento_laboral from departamento_laboral WHERE nombre_departamento = 'Docencia'))");                            
                            $query = mysql_query($stringQuery);
                            while($row = mysql_fetch_assoc($query)){
                              echo "<option value='".$row['No_Empleado']."'>".$row['Primer_nombre']." ".$row['Segundo_nombre']." ".$row['Primer_apellido']." ".$row['Segundo_apellido']."</option>";
                            } 
                        ?>
                      </select>
                    </div>
                  </div>
                  <input type="button" name="asignarDocente" id="asignarDocente" value="Asignar a Proyecto" dir="pages/CargaAcademica/AsignacionProyectos/asignarDocente.php" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
                </div>
              </div>
            </div>
            
            <div class="col-md-6">
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h4 class="panel-title">
                    <label><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Proyectos </label>
                  </h4>
                </div>
                <div class="panel-body">
                  <div class="form-group" id="listaProyectos">
                    <label class="col-sm-6 control-label">Proyectos</label>
                    <div class="col-sm-6">
                      <select class="form-control" id="proyectos" name="proyectos" onchange="cargarDocentesProyecto(this.value)">
                        <option value= 0 > Seleccione una opción </option>
                        <?php
                          $query = mysql_query("SELECT codigo,nombre FROM ca_proyectos");
                          while($row = mysql_fetch_assoc($query)){
                            echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                          } 
                        ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="plan">
                    <label class="col-sm-6 control-label"> Docentes en proyecto </label><br>
                    <div class="col-sm-7" style="width:100%;">
                      <select class="form-control" id="docentesProyecto" name="docentesProyecto" style="height:250px" multiple></select>
                    </div>
                  </div>
                  <input type="button" name="quitarDocente" id="quitarDocente" value="Quitar Docente" dir="pages/CargaAcademica/AsignacionProyectos/quitarDocente.php" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
                </div>
              </div>
            </div>    
            </form>
          </div>
        </div>
      </div>
    </body>

  </html>






  