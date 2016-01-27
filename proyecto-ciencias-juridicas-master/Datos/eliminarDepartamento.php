<?php

require_once('funciones.php');

if (isset($_POST['IdDepartamento'])) {
    $id = $_POST['IdDepartamento'];

    if (mysql_query("DELETE FROM departamento_laboral WHERE Id_departamento_laboral='$id'")) {
        echo mensajes('Departamento  : Eliminado con Exito', 'verde');
    } else {

        echo mensajes('Departamento : No se puede eliminar', 'rojo');
    }
}

?>