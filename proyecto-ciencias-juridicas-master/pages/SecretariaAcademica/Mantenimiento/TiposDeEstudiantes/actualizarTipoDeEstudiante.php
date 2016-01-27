<?php  
$mkdir = "../../../../";
include($mkdir."conexion/config.inc.php");
    $pcCod = $_POST['id'];
    $query = 'SELECT * FROM sa_tipos_estudiante  WHERE sa_tipos_estudiante.codigo ='.$pcCod;
    $result = mysql_query($query);
    $json = array();
    $contadorIteracion = 0;
    while ($fila = mysql_fetch_array($result)) { 
        $json[$contadorIteracion] = array
            (
                "codEstudiante" => $fila["codigo"],         /*codCiudad = codEstudiante*/
                "TipoDeEstudiante" => $fila["descripcion"]  /*nombreCiudad = TipoDeEstudiante*/
            );

        $contadorIteracion++;
    }

    //Retornamos el jason con todos los elmentos tomados de la base de datos.
    echo json_encode($json);
?>