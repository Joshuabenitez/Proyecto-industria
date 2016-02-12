<?php

 require_once('funciones.php');

//echo $_POST['nombre'];
if (isset($_POST['nombre'])) {
    $nombre1 = $_POST['nombre'];


   $CargoRepetido = mysql_query("SELECT  * FROM  cargo WHERE cargo.Cargo ='$nombre1' LIMIT 1");
   $Cargo_="";
   
   while($row =mysql_fetch_array($CargoRepetido)){
       

        $Cargo_=$row['Cargo'];

    }
    if($CargoRepetido=$Cargo_){
    	  echo mensajes('Este cargo ya existe','rojo');

    }
    else{
    	 $query = "INSERT INTO cargo(Cargo) VALUES('$nombre1')";
    mysql_query($query);
     if($query){           
           echo mensajes('Agregado con Exito','verde');
       }else{
        
           echo mensajes('no se puedo ingresar registro','rojo');
       }
    }
 


    
}

?>