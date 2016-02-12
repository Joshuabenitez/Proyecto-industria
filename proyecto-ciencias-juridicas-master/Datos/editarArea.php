<?php
    //En este archivo se realizo mantenimiento por Alex Flores (IIIP - 2015)

    //Incluimos el contenido del archivo config.inc.php
    include '../conexion/config.inc.php';
    
    //Se reciben los datos desde el archivo Datos/mostrarAreas.php mediante POST
    $ID             = $_POST['idTAS'];
    $name           = $_POST['nombreDA'];
    $typeOfArea     = $_POST['tipoDA'];
    $observation    = $_POST['observacionDA'];
    
    //Declaramos variables necesarias
    $message    = '';
    $Tmessage   = 0;
    
    try{
        //Se realiza consulta a la base de datos
        //sentence: Es la sentencia de lo que se pide a la base de datos
        //query     Es la consulta en sí. Al hacer execute se realiza la consulta.
        $sentence   =   "CALL PL_POA_MANTENIMIENTO_MODIFICAR_AREA(?, ?, ?, @message, @Tmessage, ?)";
        $query  =   $db ->  prepare($sentence);
        $query  ->  bindParam(1,  $name,        PDO::PARAM_STR);
        $query  ->  bindParam(2,  $typeOfArea,  PDO::PARAM_INT);
        $query  ->  bindParam(3,  $observation, PDO::PARAM_STR);
        $query  ->  bindParam(4,  $ID,          PDO::PARAM_INT);
        $query  ->  execute();

        //Recibimos el mensaje proveniente de la base de datos
        $output     = $db->query("select @message, @Tmessage")->fetch(PDO::FETCH_ASSOC);
        $message    = $output['@message'];
        $Tmessage   = $output['@Tmessage'];
    }catch(PDOExecption $e){
        $message = "Al tratar de modificar, por favor intente nuevamente.";
        $Tmessage = 0;
    }
    
    //Mostramos el mensaje al usuario
    if(isset($Tmessage) and isset($message)){ //Si existe valor en isset(X)
        if($Tmessage == 1){ //Mensaje positivo
            echo '<div class="alert alert-success" id="resultado2">';
            echo '<a href="#" class="close" data-dismiss="alert">&times;</a>';
            echo '<strong>Exito! </strong>';
            echo $message;
            echo '</div>';
        }else{ //Mensaje negativo
            echo '<div class="alert alert-danger" id="resultado2">';
            echo '<a href="#" class="close" data-dismiss="alert">&times;</a>';
            echo '<strong>Error! </strong>';
            echo $message;
            echo '</div>';
        }
    }
    
    include '../Datos/mostrarAreas.php';
?>

<script type="text/javascript">
$(document).ready(function() {
    setTimeout(function() {
        $("#resultado2").fadeOut(1500);
    },3000);
});
</script>
