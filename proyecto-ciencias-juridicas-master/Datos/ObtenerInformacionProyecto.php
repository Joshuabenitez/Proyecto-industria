<?php
    //En este archivo se realizo mantenimiento por Alex Flores (IIIP - 2015)

    //Incluimos el contenido del archivo config.inc.php
    include '../conexion/config.inc.php';
    
    //Se obtiene la opción a realizar
    $opcion=$_POST['opcion'];

    switch ($opcion){
        case 1:{
            $consulta = $db -> prepare("CALL SP_OBTENER_AREAS_POYECTO(@pcMensajeError)");
            $consulta -> execute();
            $error = null;

            if($error == null){
                $json = array();
                $interacion = 0;
                WHILE($linea = $consulta -> fetch(PDO::FETCH_ASSOC)){
                    $json[$interacion] = array(                
                            "codigo" => $linea["codigo"],
                            "nombre" => $linea["nombre"]
                    );
                    $interacion++;
                }
                echo json_encode($json);
            }
            else{
              echo '<div id="resultado" class="alert alert-danger">
                ' . $error . '</div>';
            }  
            break;
        }
        case 2:{
            $consulta = $db -> prepare("CALL SP_OBTENER_AREAS_VINCULACIONES(@pcMensajeError)");
            $consulta -> execute();
            $error = null;
            
            if($error == null){   
                $json = array();
                $interacion = 0;
                WHILE($linea = $consulta -> fetch(PDO::FETCH_ASSOC)){
                    $json[$interacion] = array(                
                            "codigo" => $linea["codigo"],
                            "nombre" => $linea["nombre"]
                    );
                    $interacion++;
                }
                 echo json_encode($json);
            }
            else
            {
              echo '<div id="resultado" class="alert alert-danger">
                ' . $error . '</div>';
            }  
            break;        
        }
    }
?>

