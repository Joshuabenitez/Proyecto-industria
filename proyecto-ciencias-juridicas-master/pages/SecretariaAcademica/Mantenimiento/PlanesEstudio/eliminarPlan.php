<?php  
$mkdir = "../../../../";
include($mkdir."conexion/config.inc.php");
    $id = $_POST['codigo'];
    try{
        $sql = "CALL SP_ELIMINAR_PLANES_ESTUDIO(?,@mensajeError)";
        $query1 = $db->prepare($sql);
        $query1->bindParam(1,$id,PDO::PARAM_STR);
        $query1->execute();

        $output = $db->query("select @mensajeError")->fetch(PDO::FETCH_ASSOC);
        $mensaje = $output['@mensajeError'];





        if(is_null($mensaje)){
            echo'<div id = "mensaje" class="alert alert-success  alert-dismissable" >
            <strong> Exito! </strong>EL plan de estudio se ha borrado correctamente</div>';
        }
        else{
              echo'<div id = "mensaje"class="alert alert-danger  alert-dismissable class="close"">
             <strong> Error! </strong>'.$mensaje.'</div>';
        }





    }catch(PDOExecption $e){

        echo '<div id = "mensaje" class="alert alert-danger alert-error">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            <strong> Error! </strong> error al intentar realizar la accion</div>';

    }

?>

<script>
    $(document).ready(function(){
        setTimeout(function(){
            $('#mensaje').fadeOut(3000);
        },3000);
    });
</script
>