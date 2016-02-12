<?php


$maindir = "../../../";
include $maindir . 'Datos/conexion.php';
include($maindir . "conexion/config.inc.php");

if (isset($_POST['accion'])) {
    $accion = $_POST['accion'];

    switch ($accion) {
        //Obtener tipos de solicitudes
        case 1: {
                $query = 'SELECT codigo, nombre FROM sa_tipos_solicitud';
                $result = mysql_query($query);

                $json = array();
                $contadorIteracion = 0;


                while ($fila = mysql_fetch_array($result)) {
                    //El objeto json es un array por lo que hacemos un recorrido y le ingresamos los valores
                    //solicitados.
                    $json[$contadorIteracion] = array
                        (
                        "codigoTipoSolicitud" => $fila["codigo"],
                        "nombreTipoSolicitud" => $fila["nombre"],
                    );

                    $contadorIteracion++;
                }

                //Retornamos el jason con todos los elmentos tomados de la base de datos.
                echo json_encode($json);
                break;
            }
        case 2: 
        {             

                    $query = 'CALL SP_REPORTE_PROYECTOS(@mensajeError)';
                    
                    $result = mysql_query($query);

                    $json = array();
                    $contadorIteracion = 0;


                    while ($fila = mysql_fetch_array($result)) 
                    {
                        //El objeto json es un array por lo que hacemos un recorrido y le ingresamos los valores
                        //solicitados.
                        $json[$contadorIteracion] = array
                        (
                            "codigoProyecto" => $fila["CODIGO_PROYECTO"],
                            "nombreProyecto" => $fila["PROYECTO_NOMBRE"],
                            "nombreVinculacion" => $fila["VINCULACION_NOMBRE"],
                            "nombreArea" => $fila["NOMBRE_AREA"],
                            "nombreCoordinador" => $fila["NOMBRE_COORDINADOR"]
                        );

                        $contadorIteracion++;
                    }
                    
                    echo json_encode($json);
                    break;
            }
            
    }
}
