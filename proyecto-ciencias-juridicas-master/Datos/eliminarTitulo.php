    <?php
    
       require_once('funciones.php');
    
        if (isset($_POST['titulo'])) {
            $id = $_POST['titulo'];
            
            if(mysql_query("DELETE FROM titulo WHERE id_titulo='$id'")){
            echo mensajes('Titulo : Eliminado con Exito', 'verde');
            }else{
                
            echo mensajes('Titulo : No se puede eliminar', 'rojo');
                
            }
        }
        
        
    
        
    ?>