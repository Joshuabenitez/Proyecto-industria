<?php
require_once("conexion.php");

        $pcCod_Area=$_POST['cod_area'];
        $pcCod_Vinculacion=$_POST['cod_vinculacion'];
        $pcNombre=$_POST['nombre'];
        
        
        $consulta="CALL SP_REGISTRAR_PROYECTO(".$pcCod_Area.",".$pcCod_Vinculacion.",'".$pcNombre."',@pcMensajeError)";
        
        $resultado=  mysqli_query($conectar, $consulta);
        
        $result=mysqli_query($conectar,'select @pcMensajeError');
        $error=null;
        if($result){        
            $pcMensajeError=mysqli_fetch_array($result);
            $error=$pcMensajeError[0];    
        }

        if($error==null)
        {   
            echo '<div id="resultado" class="alert alert-success">
                ' . 'Proyecto guardado exitosamente'. '</div>';
        }
        else
        {
          echo '<div id="resultado" class="alert alert-danger">
            ' . $error . '</div>';

        }      
?>

<script type="text/javascript">
$(document).ready(function() {
    setTimeout(function() {
        $("#contenedor2").fadeOut(1500);
    },3000);	
});
</script>