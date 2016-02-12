<?php
include ('../../../conexion/config.inc.php');

    $cuenta = $_POST["no_cuenta"];
    $dni = $_POST["dni"];
    
    $aniosEstudioDerecho1 = $_POST['aniosEstudioDerecho1'];
    $aniosEstudioDerecho2 = $_POST['aniosEstudioDerecho2'];

    $aniosEstudioFinal1 = $_POST['aniosEstudiosFinal1'];
    $aniosEstudioFinal2 = $_POST['aniosEstudiosFinal2'];



    $indiceAcademico = $_POST["ịndice_academico"];
    $uvAcumulados = $_POST["uv_acumulados"];
    $planEstudio = $_POST["cod_plan_estudio"];
    $ciudadOrigen = $_POST["cod_ciudad_origen"];  
    $orientacion = $_POST["cod_orientacion"];
    $residenciaActual = $_POST["cod_residencia_actual"];  
    $tipoEstudiante = $_POST["tipo"];
    $correo = $_POST["correo"]; 
    $mencion = $_POST["mencion"];
    $telefono = $_POST["telefono"];
    $primerNombre =  $_POST["Primer_nombre"];
    $segundoNombre = $_POST["Segundo_nombre"];
    $primerApellido = $_POST["Primer_apellido"];
    $segundoApellido = $_POST["Segundo_apellido"];

    $fechaNacimiento = $_POST["Fecha_nacimiento"];
    $estadoCivil = $_POST["Estado_Civil"];
    $nacionalidad = $_POST["Nacionalidad"];
    $direccion = $_POST["Direccion"];

    $sexo = $_POST["Sexo"];

    $grupoEtnico = $_POST['grupoEtnico'];
    $carreraAnterior = $_POST['carreraAnterior'];


?>
  <!-- <head> -->
    <!-- // <script type="text/javascript" src="js/jquery.js"></script> -->
     <!-- <script type="text/javascript" src="pages/SecretariaAcademica/MostrarEstudiantes/scripts.js"></script>
    // <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
    // <script id="funcionModificar" type="text/javascript"></script>

    // <link href="css/datepicker.css" rel="stylesheet">
    // <link href="css/prettify.css" rel="stylesheet">

    // <script src="js/prettify.js"></script>
    // <script src="js/bootstrap-datepicker.js"></script> -->
  <!-- </head> -->


  <body>
    <form role="form" id="formActualizar" method="post" class="form-horizontal" action="pages/SecretariaAcademica/RegistroEstudiantes/RegistrarEstudiante.php">
      <div id="notificaciones"></div>
      <!-- .panel-heading -->
      <div class="panel-body">
        <div class="panel-group" id="accordion">
          <h2>Modificar Estudiante</h2>
          <div name="alerta" id="alerta"></div>
          <input type="button" name="mostrar" id="mostrar" value="Lista de Estudiantes" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
          <label class="col-sm-12 control-label"></label>
            <div class="row">
            <div class="col-md-6">
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h4 class="panel-title">
                    <label>
                      <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Datos Generales del Estudiante</label>
                  </h4>
                </div>
                <div class="panel-body">
                  <!--<div>-->
                  <div class="form-group" id="identi">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Número de Identidad</label>
                    <div class="col-sm-7">
                      <input id="dni"  value = "<?php echo  $dni ; ?>"class="form-control" name="dni" placeholder="Ejemplo: 0000-0000-00000" pattern="[0-9]{4}[\-][0-9]{4}[\-][0-9]{5}"  required>
                    </div>
                  </div>
                  <div class="form-group" id="cuenta">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Número de Cuenta</label>
                    <div class="col-sm-7">
                      <input type = "text" id="noCuenta" value = "<?php echo $cuenta; ?>"class="form-control" name="noCuenta" placeholder="Ejemplo: 20011001111" required>
                    </div>
                  </div>
                  <div class="form-group" id="primerN">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Primer nombre</label>
                    <div class="col-sm-7">
                      <input id="primerNombre" value = "<?php echo $primerNombre ;?>" class="form-control" name="primerNombre" required>
                    </div>
                  </div>
                  <div class="form-group" id="Snombre">
                    <label class="col-sm-5 control-label"> Segundo nombre</label>
                    <div class="col-sm-7">
                      <input id="segundoNombre" value = "<?php echo $segundoNombre ; ?>" class="form-control" name="segundoNombre">
                    </div>
                  </div>
                  <div class="form-group" id="pApellido">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Primer Apellido</label>
                    <div class="col-sm-7">
                      <input id="primerApellido" value = "<?php echo $primerApellido ;?>"class="form-control" name="primerApellido" required>
                    </div>
                  </div>
                  <div class="form-group" id="sApellido">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Segundo Apellido</label>
                    <div class="col-sm-7">
                      <input id="segundoApellido" value = "<?php echo $segundoApellido; ?>" class="form-control" name="segundoApellido" required>
                    </div>
                  </div>
                  <div class="form-group" id="tel">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Teléfono</label>
                    <div class="col-sm-7">
                      <input type="tel" id="telefono" value = "<?php echo $telefono ;?>"class="form-control" name="telefono" placeholder="Ejemplo: 9999-9999" pattern="[0-9]{4}[\-][0-9]{4}" required>
                    </div>
                  </div>
                  <div class="form-group" id="correoE">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Correo Electrónico</label>
                    <div class="col-sm-7">
                      <input type="email" id="correo" value = "<?php echo $correo; ?>"class="form-control" name="correo" pattern="[^ @]*@[^ @]*" placeholder="Ejemplo: correo@server.com" required>
                    </div>
                  </div>
                  <!--</div>-->
                  <div class="form-group" id="sexoOpcion" name="sex">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Sexo</label>
                    <div class="col-sm-7">
                      <?php 
                          if ($sexo == 'M') {
                            echo "<input type='radio'name='sexo' id='femenino' value='F' > &nbsp;Femenino
                                  <br>
                                  <input type='radio' name='sexo' id='masculino' value='M' checked>&nbsp;Masculino" ;
                          } else {
                             echo "<input type='radio'name='sexo' id='femenino' value='F' checked >&nbsp;Femenino
                                  <br>
                                  <input type='radio' name='sexo' id='masculino' value='M' >&nbsp;Masculino" ;
                          }
                          
                       ?>
                      
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-5 control-label" data-link-field="dtp_input2">
                      <strong>
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Fecha de Nacimiento</strong>
                    </label>
                    <div class="date form_date col-md-5">
                      <input type="date" value = "<?php echo $fechaNacimiento ?>"min="1900-01-01" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask id="dp1" name="fechaNacimiento" autocomplete="off" class="input-xlarge" format="yyyy-mm-dd" required>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Estado civil</label>
                    <div class="col-sm-7">
                      <select class="form-control" id="estadoCivil" name="estadoCivil">
                        <option value="Soltero" <?php echo ($estadoCivil == 'Soltero'?  'selected': '')?>>Soltero</option>
                        <option value="Casado"<?php echo ($estadoCivil == 'Casado'?  'selected': '')?>>Casado</option>
                        <option value="Divorciado"<?php echo ($estadoCivil == 'Divorciado'?  'selected': '')?>>Divorciado</option>
                        <option value="Viudo" <?php echo ($estadoCivil == 'Viudo'?  'selected': '')?>>Viudo</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="nacionalidadOpcion">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Nacionalidad</label>
                    <div class="col-sm-7">
                      <input id="nacionalidad" value = "<?php echo $nacionalidad; ?>"class="form-control" name="nacionalidad" required>
                    </div>
                  </div> 
                  <div class="form-group" id="GrupoEtnico">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Grupo Etnico</label>
                    <div class="col-sm-7">
                      <input id="grupoEtnico" value = "<?php echo $grupoEtnico; ?>"class="form-control" name="grupoEtnico" >
                    </div>
                  </div>
                  <div class="form-group" id="lugarOrigenOpcion">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Lugar de Origen</label>
                    <div class="col-sm-7">
                      <select class="form-control" id="ciudadOrigen" name="ciudadOrigen">
                        <?php
                            $queryLugarOrigen = mysql_query("SELECT * FROM sa_ciudades");
                            while($row = mysql_fetch_assoc($queryLugarOrigen)){
                              if ($ciudadOrigen == $row['codigo']) {
                                echo "<option value='".$row['codigo']."'  selected>".$row['nombre']."</option>";
                              } else {
                                echo "<option value='".$row['codigo']."'  >".$row['nombre']."</option>";
                              }
                              
                              
                            } 
                          ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="residenciaActualOpcion">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Residencia Actual</label>
                    <div class="col-sm-7">
                      <select class="form-control" id="residenciaActual" name="residenciaActual">
                        <?php
                            $queryResidencia = mysql_query("SELECT * FROM sa_ciudades");
                            while($row = mysql_fetch_assoc($queryResidencia)){
                              if ($residenciaActual == $row['codigo']) {
                                echo "<option value='".$row['codigo']."' selected>".$row['nombre']."</option>";
                              } else {
                                echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                              }
                              
                            } 
                          ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="direccionOpcion">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Dirección</label>
                    <div class="col-sm-7">
                      <textarea id="direccion" value = "<?php echo $Direccion; ?>" class="form-control" name="direccion" required></textarea>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h4 class="panel-title">
                    <label>
                      <span class="glyphicon glyphicon-book" aria-hidden="true"></span> Información Académica</label>
                  </h4>
                </div>
                <div class="panel-body">
                  <div>
                    <div class="form-group" id="tipoEstudianteOpcion">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Tipo de Estudiante</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="tipoEstudiante" name="tipoEstudiante">
                          <?php
                            $queryTipoEstudiante = mysql_query("SELECT * FROM sa_tipos_estudiante");
                            while($row = mysql_fetch_assoc($queryTipoEstudiante)){
                              if ($row['codigo'] == $tipoEstudiante) {
                                echo "<option value='".$row['codigo']."' selected>".$row['descripcion']."</option>";

                              } else {
                                echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";
                              }
                            } 
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="plan">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Plan de Estudio</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="planEstudio" name="planEstudio">
                          <?php
                            $queryPlanes = mysql_query("SELECT * FROM sa_planes_estudio");
                            while($row = mysql_fetch_assoc($queryPlanes)){
                              if ($row['codigo'] == $planEstudio) {
                                 echo "<option value='".$row['codigo']."' selected>".$row['nombre']."</option>";
                              } else {
                                echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                              }
                            } 
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="unidades">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Unidades Valorativas</label>
                      <div class="col-sm-6">
                        <input type="number" value = "<?php echo $uvAcumulados; ?>" min="1" max="600" value="1" id="uvAcumulados" class="form-control" name="uvAcumulados" required>
                      </div>
                    </div>

                    <div class="form-group" id="aniosInicio">
                      <label class="col-sm-5 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Años de estudio en Derecho</label>
                      <div class="col-sm-3">
                        <input type="text" min="" value="<?php echo $aniosEstudioDerecho1; ?>" id="aniosEstudioInicio1" class="form-control" name="aniosEstudioInicio1" placeholder = "1999" onchange="validarAnioCambio()" >
                      </div>
                      <label for="" class="col-sm-1 control-label">to</label>
                      <div class="col-sm-3">
                        <input type="text" min="" value="<?php echo $aniosEstudioDerecho2; ?>" id="aniosEstudioInicio2" class="form-control" name="aniosEstudioInicio2" placeholder = "1999" onchange="validarAnioCambio()" >
                      </div>
                    </div>
                    <div class="form-group" id="aniosFinal">
                      <label class="col-sm-5 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Años de Estudio segun Certificado </label>
                      <div class="col-sm-3">
                        <input type="text" id="aniosEstudioFinal1" value = "<?php echo $aniosEstudioFinal1 ?>" class="form-control" name="aniosEstudioFinal1" placeholder = "1999">
                      </div>
                      <label for="" class="col-sm-1 control-label">to</label>
                      <div class="col-sm-3">
                        <input type="text" id="aniosEstudioFinal2" value = "<?php echo $aniosEstudioFinal2 ?>" class="form-control" name="aniosEstudioFinal2" placeholder = "1999">
                      </div>
                    </div>

                    <!-- <div class="form-group" id="aniosDerecho">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Años de Estudio En Derecho</label>
                      <div class="col-sm-6">
                        <input type="text"  value="<?php echo $aniosEstudioDerecho; ?>" id="aniosEstudioDerecho" class="form-control" name="aniosEstudioDerecho" placeholder = "9999-9999">
                      </div>
                    </div>
                    
                    <div class="form-group" id="anios">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Años de Estudio Segun Certificado</label>
                      <div class="col-sm-6">
                        <input type="text"  value="<?php echo $aniosEstudio; ?>" id="aniosEstudio" class="form-control" name="aniosEstudio" placeholder = "9999-9999" >
                      </div>
                    </div> -->

                    <div class="form-group" id="orientacionOpcion">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Orientación</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="orientacion" name="orientacion">
                          <?php
                            $queryTitulos = mysql_query("SELECT * FROM sa_orientaciones");
                            while($row = mysql_fetch_assoc($queryTitulos)){
                              if ($row['codigo'] == $orientacion) {
                                echo "<option value='".$row['codigo']."' selected>".$row['descripcion']."</option>";
                              } else {
                                echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";                              }
                            } 
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="indice">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Índice Académico</label>
                      <div class="col-sm-6">
                        <input type="number" min="0" max="100" step="0.01" value="<?php echo $indiceAcademico; ?>" id="indiceAcademico" class="form-control" name="indiceAcademico" required>
                      </div>
                    </div>
                    <div class="form-group" id="mencionOpcion">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Mención Honorífica</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="mencion" name="mencion">
                          <?php
                            $queryMencion = mysql_query("SELECT * FROM sa_menciones_honorificas");
                            while($row = mysql_fetch_assoc($queryMencion)){
                              if ($row['codigo'] == $mencion) {
                                echo "<option value='".$row['codigo']."' selected>".$row['descripcion']."</option>";
                              } else {
                                echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";
                              }
                            } 
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="carrera_anterior">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Es egresado de otra Carrera</label>
                    <div class="col-sm-7">
                      <input id="carreraAnterior" value = "<?php echo $carreraAnterior; ?>"class="form-control" name="carreraAnterior" required>
                    </div>
                  </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
       
        <div id="noti1" class="alert alert-info" role="alert">IMPORTANTE: Los campos marcados con el signo
          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> son obligatorios.</div>
        <input type="button" name="modificar" id="modificar" value="Actualizar" class="ActualizarB btn btn-primary" onclick="request(this.id)" readonly/>
      </div>
    </form>
  </body>

