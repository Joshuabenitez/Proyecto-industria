<?php
require_once("../conexion/config.inc.php");
$nombre= $_POST['nombreDTA'];
$obs= $_POST['observacionDTA'];

try{
        $stmt = $db->prepare("CALL pa_insertar_tipo_area(?,?,@mensaje,@codMensaje)");
        $stmt->bindParam(1, $nombre, PDO::PARAM_STR); 
        $stmt->bindParam(2, $obs, PDO::PARAM_STR); 
        $stmt->execute();   
        
        $output = $db->query("select @mensaje, @codMensaje")->fetch(PDO::FETCH_ASSOC);
        //var_dump($output);
        $mensaje = $output['@mensaje'];
        $resultado = $output['@codMensaje'];
        
        }catch(PDOExecption $e){
            $mensaje="No se ha procesado su peticion, comuniquese con el administrador del sistema";
            $codMensaje =0;
        }
if($resultado==1)
    {
    echo '<div id="resultado" class="alert alert-success">
        se ha ingresaso un nuevo Tipo de Area
         
         </div>';
    
    }else{
         echo '<div id="resultado" class="alert alert-danger">
        No se pu'.$resultado.'do almacenar
         
         </div>';
    }

    include '../Datos/mostrarTipos.php';
?>
 

<script type="text/javascript">
$(document).ready(function() {
    setTimeout(function() {
        $("#resultado").fadeOut(1500);
    },3000);
	
});
</script>
