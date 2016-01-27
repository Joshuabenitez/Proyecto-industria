<?php

require_once('funciones.php');




//echo $_POST['nombre'];
if (isset($_POST['nombreComite'])) {
    $nombre1 = $_POST['nombreComite'];
    $ComiteRepetido = mysql_query("SELECT * FROM `grupo_o_comite` WHERE grupo_o_comite.Nombre_Grupo_o_comite ='$nombre1' LIMIT 1");
    $Comite_="";

    while($row =mysql_fetch_array($ComiteRepetido)){
        $Comite_ =$row['Nombre_Grupo_o_comite'];

    }
    if($ComiteRepetido=$Comite_){
         echo mensajes('Nombre Grupo o Comite Repetido','rojo');
    }
    else{
    	 $query = "INSERT INTO grupo_o_comite(Nombre_Grupo_o_comite) VALUES('$nombre1')";
    mysql_query($query);
       if($query){
           echo mensajes('Agregado con Exito','verde');
       }else{
           echo mensajes('no se puedo ingresar registro','rojo');
       }

    }
}

?>