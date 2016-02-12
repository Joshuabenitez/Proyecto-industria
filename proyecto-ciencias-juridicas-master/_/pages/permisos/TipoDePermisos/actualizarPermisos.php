<?php  
$mkdir = "../../../";
include($mkdir."conexion/config.inc.php");
    $pcCod = $_POST['id'];
    $query = 'SELECT * FROM tipodepermiso WHERE tipodepermiso.id_tipo_permiso ='.$pcCod;
    $result = mysql_query($query);
    $json = array();
    $contadorIteracion = 0;
    while ($fila = mysql_fetch_array($result)) { 
        $json[$contadorIteracion] = array
            (
                "codPeriodo" => $fila["id_tipo_permiso"],
                "nombrePeriodo" => $fila["tipo_permiso"]
            );

        $contadorIteracion++;
    }

    //Retornamos el jason con todos los elmentos tomados de la base de datos.
    echo json_encode($json);
?>