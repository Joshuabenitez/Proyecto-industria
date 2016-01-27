<?php

  require_once('funciones.php');

if (isset($_POST['IdClase'])) {
    $id = $_POST['IdClase'];

    if (mysql_query("DELETE FROM clases WHERE ID_Clases='$id'")) {
        echo mensajes('Clase : Eliminada con Exito', 'verde');
    } else {

        echo mensajes('Clase : No se puede eliminar', 'rojo');
    }
}
 
?>