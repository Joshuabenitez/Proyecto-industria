<?php
require_once("../conexion/config.inc.php");

$pcIdentidadEstudiante= $_POST['id'];


$consulta= $db ->prepare ("CALL SP_OBTENER_TIPOS_SOLICITUDES_POR_ESTUDIANTE('".$pcIdentidadEstudiante."',@pcMensajeError)");
$consulta ->execute();
$resultado = $consulta;

$json = array();
$interacion = 0;

WHILE($linea = $resultado -> fetch(PDO::FETCH_ASSOC))
	{
	    $json[$interacion] = array
        	(                
	            "codigo" => $linea["codigo"],
        	    "nombre" => $linea["nombre"]
	        );
    
    	    $interacion++;
	}
echo json_encode($json);	

?>