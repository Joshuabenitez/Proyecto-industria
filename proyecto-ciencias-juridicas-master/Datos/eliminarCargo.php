    <?php
    
        require_once('funciones.php');
     
    
        if (isset($_POST['ID_cargo'])) {
            $id = $_POST['ID_cargo'];
            
            if(mysql_query("DELETE FROM cargo WHERE ID_cargo='$id'")){
            echo mensajes('Cargo : Eliminado con Exito', 'verde');
            }else{
                
            echo mensajes('Cargo : No se puede eliminar', 'rojo');
                
            }
        }
        
        
      
        
    ?>
