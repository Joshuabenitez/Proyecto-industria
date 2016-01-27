<?php 
    //Datos necesarios para la conexion
    include '../../../Datos/conexion.php';
    
    $Message= "Numero de indentidad incorrecto";
    //Se recupera valor enviado
    if(isset($_POST['Identidad']))
    {
        $Nid = $_POST['Identidad'];
    }

    $sentencia =  $conectar->stmt_init();

    $sentencia->prepare("CALL SP_OBTENER_INFORMACION_ESTUDIANTE(?, @pcMensajeError)");
    
    if ($Nid != NULL) 
    {
        try{
            /* vincular los parámetros para los marcadores */
            $sentencia->bind_param("s", $Nid);
            /* ejecutar la consulta */
            $sentencia->execute();
            /* vincular las variables de resultados */
            if (mysqli_stmt_affected_rows($sentencia)){
                $sentencia->bind_result($nombre, $tipo);
                /* obtener el valor */
                $sentencia->fetch();
                /* cerrar la sentencia */
                $sentencia->close();
                /*enviar valores*/
                echo $nombre."*".$tipo;
            }else{
                echo "Número de identidad no existe.*";
            }

        }catch(Exception $e){
          echo'<div class="alert alert-info alert-succes">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            <strong> Error! intente de nuevo! </strong></div>';
        }
    }else 
    {
            echo'<div class="alert alert-info alert-succes">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            <strong> Ingrese numero de identidad! </strong></div>';
    }       
?>