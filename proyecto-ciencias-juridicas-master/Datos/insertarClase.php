

<?php

//Crear una consulta que verifique si existe la clase ya exitente 
 require_once('funciones.php');
  
//echo $_POST['nombre'];
if (isset($_POST['nombre'])) {
    $nombre1 = $_POST['nombre'];  
    $ClaseRepetida = mysql_query("SELECT * from clases where Clase = '$nombre1' LIMIT 1");

    $clase1="";
    while($row =mysql_fetch_array($ClaseRepetida)){
    	$clase1 =$row['Clase'];

    }
    if($ClaseRepetida = $clase1){
         echo mensajes('Clase repetida','rojo');
    }
    else{
    	$query = "INSERT INTO clases(Clase) VALUES('$nombre1')";

    mysql_query($query);
    
    
      if($query){
           
           
           echo mensajes('Agregado con Exito','verde');
       }else{
        
           echo mensajes('no se puedo ingresar registro','rojo');
       }
    

    }
    
}

?>