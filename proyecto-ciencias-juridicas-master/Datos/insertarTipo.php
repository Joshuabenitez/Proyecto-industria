<?php

require_once('funciones.php');

//echo $_POST['nombre'];
if (isset($_POST['nombre'])) {
    $nombre1 = $_POST['nombre'];
    
   $TipoRepetido = mysql_query("SELECT * FROM `tipo_estudio` WHERE  tipo_estudio.Tipo_estudio ='$nombre1' LIMIT 1");
   $Tipo_="";
   
   while($row =mysql_fetch_array($TipoRepetido)){
        $Tipo_ =$row['Tipo_estudio'];

    }

   if($TipoRepetido=$Tipo_){
     echo mensajes('Ya existe este tipo de estudio','rojo');
   }
   else{
    $query = "INSERT INTO tipo_estudio(Tipo_estudio) VALUES('$nombre1')";
    mysql_query($query);  	
	if($query){
	
		//echo '<META HTTP-EQUIV="REFRESH" CONTENT="2">' ;
		echo mensajes('Actualizado con Exito','verde');
	}else{

	}

   }  
}

?>