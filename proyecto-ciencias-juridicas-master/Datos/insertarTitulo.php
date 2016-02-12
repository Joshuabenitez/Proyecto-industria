<?php

require_once('funciones.php');




//echo $_POST['nombre'];
if (isset($_POST['titulo'])) {
    $nombre1 = $_POST['titulo'];
    
   $TituloRepetido = mysql_query("SELECT * from titulo WHERE titulo.titulo ='$nombre1' LIMIT 1");
   $Titulo_="";
   
   while($row =mysql_fetch_array($TituloRepetido)){
        $Titulo_ =$row['titulo'];

    }

    if($TituloRepetido=$Titulo_){
     echo mensajes('Titulo Repetido','rojo');

    }

    else{
        $query = "INSERT INTO titulo(titulo) VALUES('$nombre1')";
    mysql_query($query);   
    if($query){
        //echo '<META HTTP-EQUIV="REFRESH" CONTENT="2">' ;
        echo mensajes('Agregado con Exito','verde');
    }
    else{
        echo mensajes('no se puedo ingresar registro','rojo');
    }
    
    }
    
    }
    

?>