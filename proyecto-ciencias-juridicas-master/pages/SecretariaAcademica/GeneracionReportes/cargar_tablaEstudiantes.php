
<?php
  $mkdir = "../../../";
  include($mkdir."conexion/config.inc.php");
  $queryString = "SELECT * FROM sa_estudiantes";
  $query = mysql_query($queryString);

  echo "<div class='table-responsive'>
          <table id= 'tabla_Estudiantes' class='table table-striped table-bordered'cellspacing='0' width='100%'>
            <thead class = '' style = 'background-color:#428bca; color: white;'>
               <tr>
                  <th>Cuenta</td>
                  <th>DNI</td>
                   <th style='width: 600px'>Nombre Estudiante</td>
                   <th>correo</td>
                   <th> Indice Academico</td>

                   <th>UV acumulados</th>
                   <th>Mencion Honorifica</td>
                   <th>Solicitudes</td>
                   <th>Plan de Estudio</td>
                   <th>Orientacion</td>
                   <th>Ciudad Origen</td>
                   <th>Residencia Actual</td>
                   <th>Grupo Etnico</th>
                   <th>Anos Certificado</th>
                   <th>Anos en Derecho</th>
                   <th>Carrera Anterior</th>


                </tr>
            </thead>
            <tbody id = 'tabla_filtrada'>";

  while($row = mysql_fetch_assoc($query)){
    $estudiante = obtenerEstudiante($row['dni']);
    $correo = obtenerCorreo($row['dni']);
    $mencion = obtenerMencion($row['dni']);
    $solicitudes = obtenercantidadSolicitudes($row['dni']);
    $planEstudio = obtenerPlan($row['cod_plan_estudio']);
    $orientacion = obtenerOrientacion($row['cod_orientacion']);
    $ciudad_origen = obtenerCiudadOrigen($row['cod_ciudad_origen']);
    $residencia_actual = obtenerRecidencia($row['cod_residencia_actual']);
     $grupo_etnico = $row['grupo_etnico'];
     $anios_inicio_estudio = $row['anios_inicio_estudio'];
     $anios_final_estudio = $row['anios_final_estudio'];
     $carrera_anterior = $row['carrera_anterior'];
     $uv_acumulados = $row['uv_acumulados'];
    

   
    echo  "<tr>".
                "<td id='".$row['no_cuenta']."'>".$row['no_cuenta']."</td>".
                "<td id='".$row['dni']."'>".$row['dni']."</td>".
                "<td id='".$row['no_cuenta']."'>".utf8_encode($estudiante)."</td>".
                "<td id='".$row['dni']."'>".$correo."</td>".
                "<td id='".$row['indice_academico']."'>".$row['indice_academico']."</td>".
                "<td id=''>".$row['uv_acumulados']."</td>".

                "<td id='".$mencion."'>".utf8_encode($mencion)."</td>".
                "<td id=''>".$solicitudes."</td>".
                "<td id=''>".utf8_encode($planEstudio)."</td>".
                "<td id=''>".utf8_encode($orientacion)."</td>".
                "<td id=''>".utf8_encode($ciudad_origen)."</td>".
                "<td id=''>".utf8_encode($residencia_actual)."</td>".
                "<td id=''>".utf8_encode($grupo_etnico)."</td>".
                "<td id=''>".utf8_encode($anios_inicio_estudio)."</td>".
                "<td id=''>".utf8_encode($anios_final_estudio)."</td>".
                "<td id=''>".utf8_encode($carrera_anterior)."</td>".
                  "</tr>";
  }
  echo "</tbody>
          </table>
            </div>  ";

  function obtenerEstudiante($dni){
    $queryString = "SELECT Primer_nombre,Segundo_nombre,Primer_apellido,Segundo_apellido FROM 
            persona p INNER JOIN sa_estudiantes e ON p.N_Identidad = e.dni WHERE e.dni = '".$dni."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);
    return $row['Primer_nombre']." ".$row["Segundo_nombre"]." ".$row["Primer_apellido"]." ".$row["Segundo_apellido"];
  }

  function obtenerCorreo($dni){
    $queryString = "SELECT correo from sa_estudiantes_correos where dni_estudiante ='".$dni."'";
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['correo'];
  }

  function obtenerMencion($dni){
    $queryString = "SELECT descripcion FROM sa_menciones_honorificas WHERE codigo in (SELECT cod_mencion FROM sa_estudiantes_menciones_honorificas WHERE dni_estudiante ='".$dni."')";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['descripcion'];
  }

  function obtenercantidadSolicitudes($dni){
    $queryString = "SELECT COUNT(*) AS cuenta FROM sa_solicitudes WHERE dni_estudiante ='".$dni."'";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['cuenta'];
  }

   function obtenerPlan($codigo_plan_estudio){
    $queryString = "SELECT nombre FROM sa_planes_estudio WHERE codigo  ='".$codigo_plan_estudio."'";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['nombre'];
  }
  function obtenerOrientacion($codigo_orientacion){
    $queryString = "SELECT descripcion FROM sa_orientaciones WHERE codigo  ='".$codigo_orientacion."'";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['descripcion'];
  }
  function obtenerCiudadOrigen($cod_ciudad_origen){
    $queryString = "SELECT nombre FROM sa_ciudades WHERE codigo  ='".$cod_ciudad_origen."'";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['nombre'];
  }
  function obtenerRecidencia($cod_residencia_actual){
    $queryString = "SELECT nombre FROM sa_ciudades WHERE codigo  ='".$cod_residencia_actual."'";
    
    $query = mysql_query($queryString);
    $row = mysql_fetch_assoc($query);   
    return $row['nombre'];
  }

 ?>

