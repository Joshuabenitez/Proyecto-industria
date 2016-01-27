<?php
include '../../../Datos/conexion.php';
$queryE = mysql_query('SELECT dni, no_cuenta FROM sa_estudiantes', $enlace);
?>
  <!-- // <script type="text/javascript" src="js/jquery.js"></script> -->
  <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
  <!-- // <script src="scriptsRegistroEstudiantes.js"></script> -->

  <link href="css/datepicker.css" rel="stylesheet">
  <link href="css/prettify.css" rel="stylesheet">

  <script src="js/prettify.js"></script>
  <script src="js/bootstrap-datepicker.js"></script>
  <!--<script>
    if (top.location != location) {
      top.location.href = document.location.href;
    }
    $(function() {
      window.prettyPrint && prettyPrint();
      $('#dp1').datepicker({
        format: 'yyyy-mm-dd',
        language: "es",
        autoclose: true,
        todayBtn: true
      }).on('show', function() {
        var zIndexModal = $('#myModal').css('z-index');
        var zIndexFecha = $('.datepicker').css('z-index');
        $('.datepicker').css('z-index', zIndexModal + 1);
      }).on('changeDate', function(ev) {
        $('#dp1').datepicker('hide');
      });

    });
  </script>-->


  <body>
    <form role="form" id="formInsertarEstudiante" class="form-horizontal">
      <!-- .panel-heading -->
      <div class="panel-body">
        <div class="panel-group" id="accordion">
          <h2>Registro de Estudiante</h2>
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
                      <input id="identidad" class="form-control" name="identidad" placeholder="Ejemplo: 0000-0000-00000" pattern="[0-9]{4}[\-][0-9]{4}[\-][0-9]{5}" required>
                    </div>
                  </div>
                  <div class="form-group" id="cuenta">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Número de Cuenta</label>
                    <div class="col-sm-7">
                      <input id="numeroCuenta" class="form-control" name="numeroCuenta" placeholder="Ejemplo: 20011001111" required>
                    </div>
                  </div>
                  <div class="form-group" id="primerN">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Primer nombre</label>
                    <div class="col-sm-7">
                      <input id="primerNombre" class="form-control" name="primerNombre" required>
                    </div>
                  </div>
                  <div class="form-group" id="Snombre">
                    <label class="col-sm-5 control-label"> Segundo nombre</label>
                    <div class="col-sm-7">
                      <input id="segundoNombre" class="form-control" name="segundoNombre">
                    </div>
                  </div>
                  <div class="form-group" id="pApellido">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Primer Apellido</label>
                    <div class="col-sm-7">
                      <input id="primerApellido" class="form-control" name="primerApellido" required>
                    </div>
                  </div>
                  <div class="form-group" id="sApellido">
                    <label class="col-sm-5 control-label">
                      <span aria-hidden="true"></span> Segundo Apellido</label>
                    <div class="col-sm-7">
                      <input id="segundoApellido" class="form-control" name="segundoApellido" >
                    </div>
                  </div>
                  <div class="form-group" id="tel">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Teléfono</label>
                    <div class="col-sm-7">
                      <input type="tel" id="telefono" class="form-control" name="telefono" placeholder="Ejemplo: 9999-9999" pattern="[0-9]{4}[\-][0-9]{4}" required>
                    </div>
                  </div>
                  <div class="form-group" id="correoE">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Correo Electrónico</label>
                    <div class="col-sm-7">
                      <input type="email" id="correo" class="form-control" name="correo" pattern="[^ @]*@[^ @]*" placeholder="Ejemplo: correo@server.com" required>
                    </div>
                  </div>
                  <!--</div>-->
                  <div class="form-group" id="sexoOpcion" name="sex">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Sexo</label>
                    <div class="col-sm-7">
                      <input type="radio" name="sexo" id="sexoFem" value="F" checked>&nbsp;Femenino
                      <br>
                      <input type="radio" name="sexo" id="sexoMas" value="M">&nbsp;Masculino
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-5 control-label" data-link-field="dtp_input2">
                      <strong>
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Fecha de Nacimiento</strong>
                    </label>
                    <div class="date form_date col-md-5">
                      <input type="date" min="1900-01-01" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask id="dp1" name="fecha" autocomplete="off" class="input-xlarge" format="yyyy-mm-dd" required>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Estado civil</label>
                    <div class="col-sm-7">
                      <select class="form-control" id="estCivil" name="estCivil">
                        <option>Soltero</option>
                        <option>Casado</option>
                        <option>Divorciado</option>
                        <option>Viudo</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="nacionalidadOpcion">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Nacionalidad</label>
                    <div class="col-sm-7">
                      <input id="nacionalidad" class="form-control" name="nacionalidad" required>
                    </div>
                  </div>
                  <div class="form-group" id="GrupoEtnico">
                    <label class="col-sm-5 control-label">
                      <span class="" aria-hidden="true"></span> Grupo Etnico</label>
                    <div class="col-sm-7">
                      <input id="grupoEtnico" value = " "class="form-control" name="grupoEtnico" >
                    </div>
                  </div>
                  <div class="form-group" id="lugarOrigenOpcion">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon " aria-hidden="true"></span> Lugar de Origen</label>
                    <div class="col-sm-7">
                      <select class="form-control" id="ciudadOrigenCombo" name="ciudadOrigenCombo">
                        <?php
                            $queryLugarOrigen = mysql_query("SELECT * FROM sa_ciudades");
                            while($row = mysql_fetch_assoc($queryLugarOrigen)){
                              echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
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
                              echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                            }
                          ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group" id="direccionOpcion">
                    <label class="col-sm-5 control-label">
                      <span aria-hidden="true"></span> Dirección</label>
                    <div class="col-sm-7">
                      <textarea id="direccion" class="form-control" name="direccion"></textarea>
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
                              echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";
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
                              
                              
                              echo "<option value='".$row['codigo']."'>".$row['nombre']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="unidades">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Unidades Valorativas</label>
                      <div class="col-sm-6">
                        <input type="number" min="1" max="600" value="1" id="unidadesValorativas" class="form-control" name="unidadesValorativas" required>
                      </div>
                    </div>
                    <div class="form-group" id="aniosInicio">
                      <label class="col-sm-5 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Años de estudio en Derecho</label>
                      <div class="col-sm-3">
                        <input type="text" min="" value="" id="aniosEstudioInicio1" class="form-control" name="aniosEstudioInicio1" placeholder = "1999" onchange="validarAnioCambio()" >
                      </div>
                      <label for="" class="col-sm-1 control-label">to</label>
                      <div class="col-sm-3">
                        <input type="text" min="" value="" id="aniosEstudioInicio2" class="form-control" name="aniosEstudioInicio2" placeholder = "1999" onchange="validarAnioCambio()" >
                      </div>
                    </div>
                    <div class="form-group" id="aniosFinal">
                      <label class="col-sm-5 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Años de Estudio segun Certificado </label>
                      <div class="col-sm-3">
                        <input type="text" id="aniosEstudioFinal1" class="form-control" name="aniosEstudioFinal1" placeholder = "1999">
                      </div>
                      <label for="" class="col-sm-1 control-label">to</label>
                      <div class="col-sm-3">
                        <input type="text" id="aniosEstudioFinal2" class="form-control" name="aniosEstudioFinal2" placeholder = "1999">
                      </div>
                    </div>
                    
                    <div class="form-group" id="tituloOpcion">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Título</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="titulo" name="titulo">
                          <?php
                            $queryTitulos = mysql_query("SELECT * FROM titulo");
                            while($row = mysql_fetch_assoc($queryTitulos)){
                              echo "<option value='".$row['id_titulo']."'>".$row['titulo']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="orientacionOpcion">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Orientación</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="orientacion" name="orientacion">
                          <?php
                            $queryTitulos = mysql_query("SELECT * FROM sa_orientaciones");
                            while($row = mysql_fetch_assoc($queryTitulos)){
                              echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" id="indice">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Índice Académico</label>
                      <div class="col-sm-6">
                        <input type="number" min="0" max="100" step="0.01" value="0.00" id="indiceAcademico" class="form-control" name="indiceAcademico" required>
                      </div>
                    </div>
                    <div class="form-group" id="mencionOpcion">
                      <label class="col-sm-6 control-label">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Mención Honorífica</label>
                      <div class="col-sm-6">
                        <select class="form-control" id="mencionHonorificaCombo" name="mencionHonorificaCombo">
                          <?php
                            $queryMencion = mysql_query("SELECT * FROM sa_menciones_honorificas");
                            while($row = mysql_fetch_assoc($queryMencion)){
                              echo "<option value='".$row['codigo']."'>".$row['descripcion']."</option>";
                            }
                          ?>
                        </select>
                      </div>
                    </div>

                    <div class="form-group" id="carrera_anterior">
                    <label class="col-sm-5 control-label">
                      <span class="glyphicon " aria-hidden="true"></span>Es egresado de otra Carrera</label>
                    <div class="col-sm-7">
                      <input id="carreraAnterior" value = ""class="form-control" name="carreraAnterior" >
                    </div>
                  </div>

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div id="notificaciones"></div>
        <div id="noti1" class="alert alert-info" role="alert">IMPORTANTE: Los campos marcados con el signo
          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> son obligatorios.</div>
        <button id="registrarEstudiante" class="ActualizarB btn btn-primary"> Guardar</button>
      </div>
      </div>
    </form>
  </body>

  </html>

    <script type="text/javascript">
    $(document).ready(function() {
      var nada = "N/D";
      $("#formInsertarEstudiante").submit(function(e) {
        e.preventDefault();
        
          var data1 = {
           "identidad": $('#identidad').val(),
            "primerNombre": $('#primerNombre').val(),
            "segundoNombre": (!$.trim($('#segundoNombre').val())) ? nada : $('#segundoNombre').val(),
            "primerApellido": $('#primerApellido').val(),
            "segundoApellido": (!$.trim($('#segundoApellido').val())) ? nada : $('#segundoApellido').val() ,
            "sexo": $('input[name="sexo"]:checked').val(),
            "fecha": $("#dp1").val(),
            "telefono": (!$.trim($('#telefono').val())) ? nada : $('#telefono').val() ,
            "correo": (!$.trim($('#correo').val())) ? nada : $('#correo').val(),
            "estCivil": $('#estCivil').val(),
            "nacionalidad": (!$.trim($('#nacionalidad').val())) ? nada : $('#nacionalidad').val(),
            "direccion": (!$.trim($('#direccion').val())) ? nada : $('#direccion').val(),
            "ciudadOrigen": $('#ciudadOrigenCombo').val(),
            "residenciaActual": $('#residenciaActual').val(),
            "numeroCuenta": $('#numeroCuenta').val(),

            "tipoEstudiante": $('#tipoEstudiante').val(),
            "planEstudio": $('#planEstudio').val(),
            "unidadesValorativas": (!$.trim($('#unidadesValorativas').val())) ? "N/D" :  $('#unidadesValorativas').val(),

            "aniosEstudioInicio1": (!$.trim($('#aniosEstudioInicio1').val())) ? 0000 : $('#aniosEstudioInicio1').val(),
            "aniosEstudioInicio2": (!$.trim($('#aniosEstudioInicio2').val())) ? 0000 : $('#aniosEstudioInicio2').val(),
            
            "aniosEstudioFinal1": (!$.trim($('#aniosEstudioFinal1').val())) ? 0000 : $('#aniosEstudioFinal1').val(),
            "aniosEstudioFinal2": (!$.trim($('#aniosEstudioFinal2').val())) ? 0000 : $('#aniosEstudioFinal2').val(),
           
            "titulo": $('#titulo').val(),
            "orientacion": $('#orientacion').val(),
            "indiceAcademico": (!$.trim($('#indiceAcademico').val())) ? 0.00 : $('#indiceAcademico').val() ,
            "mencionHonorifica": $('#mencionHonorificaCombo').val(),


            "grupoEtnico":$('#grupoEtnico').val(),
            "carreraAnterior": $('#carreraAnterior').val()

          };
           $.ajax({
            
            type: "POST",
            url: "pages/SecretariaAcademica/RegistroEstudiantes/RegistrarEstudiante.php",
            data: data1,
            success: function(data) {
              $('#contenedor').html(data);
            },
          });
    

    });

      

    });

    function llegadaGuardar(dato) {
      $("#notificaciones").html(dato);
    }

    function insertarEstudiante() {
      var x = $("#notificaciones");
      x.html('Cargando...');
    }

    function problemasInsertar() {
      $("#notificaciones").text('Problemas en el servidor.');
    }

    // function validarAnioCambio(){
    //   document.getElementsById("aniosEstudioFinal").setAttribute("min","15");
    //   alert("h");
    //   var x = document.getElementsById("aniosEstudioFinal").hasAttribute("min");
    //   //alert(x);
    //
    // } //Cada vez que se cambie el valor del campo Año Inicio Estudios, el valor mínimo del campo Año Finalizacion Estudios sea el valor seleccionado en Año Inicio Estudios
  </script>
