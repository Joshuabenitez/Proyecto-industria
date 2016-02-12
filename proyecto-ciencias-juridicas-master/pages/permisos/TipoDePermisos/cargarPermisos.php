<?php
$mkdir = "../../../";
include($mkdir."conexion/config.inc.php");

    /* Hacemos una consulta a la base de datos para obtener los datos de la tabla Ciudades. */
        $query = 'SELECT * FROM TipoDePermiso';
        $result = mysql_query($query);
        $json = array();
        $contadorIteracion = 0;


        while ($fila = mysql_fetch_array($result)) { 
            $json[$contadorIteracion] = array
                (
                "idpermiso" => $fila["id_tipo_permiso"],
                "tipopermiso" => $fila["tipo_permiso"]
                );

            $contadorIteracion++;
        }

        //Retornamos el jason con todos los elmentos tomados de la base de datos.
        echo json_encode($json);
?>

