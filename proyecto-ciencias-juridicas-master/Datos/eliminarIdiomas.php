    <?php
    
       require_once('funciones.php');
    
        if (isset($_POST['ID_Idioma'])) {
            $id = $_POST['ID_Idioma'];
            
            if(mysql_query("DELETE FROM idioma WHERE ID_Idioma='$id'")){
                
            echo mensajes('Idioma :  Eliminado con Exito', 'verde');
            }else{
                
            echo mensajes('Idioma : No se puede eliminar', 'rojo');
                
            }
        }

        
    ?>