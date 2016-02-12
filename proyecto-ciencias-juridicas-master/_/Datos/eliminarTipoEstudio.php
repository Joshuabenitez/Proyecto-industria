    <?php
    
      require_once('funciones.php');
    
        if (isset($_POST['TipoEstudio'])) {
            $id = $_POST['TipoEstudio'];
            
            if(mysql_query("DELETE FROM tipo_estudio WHERE ID_Tipo_estudio='$id'")){
            echo mensajes('Estudio : Eliminado con Exito', 'verde');
            }else{
                
            echo mensajes('Estudio  : No se puede eliminar', 'rojo');
                
            }
        }
        
        
       
        
    ?>