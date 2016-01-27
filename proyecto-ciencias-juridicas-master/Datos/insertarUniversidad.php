<?php
 
     require_once('funciones.php');
	
	  if (!empty($_POST['nombre'])) 
    {
        $nombre = $_POST['nombre']; 
		$pais = $_POST['pais']; 
        
        $UniversiadadRepetido = mysql_query("SELECT * FROM `universidad` WHERE universidad.nombre_universidad ='$nombre' and universidad.Id_pais in (SELECT Id_pais FROM pais WHERE pais.Nombre_pais ='$pais') LIMIT 1");
        $Universidad_="";

     while($row =mysql_fetch_array($UniversiadadRepetido)){
        $Universidad_ =$row['nombre_universidad'];
        }


     if($UniversiadadRepetido=$Universidad_){
       echo mensajes('Universidad ya creada ','verde');
       }
       else{
        $query = "INSERT INTO universidad(Nombre_universidad,Id_Pais) VALUES('$nombre','$pais')";
        mysql_query($query);     
        if($query){
        //echo '<META HTTP-EQUIV="REFRESH" CONTENT="2">' ;
        echo mensajes('Universidad ingresada con Exito','verde');  
        }
    }
    }

    else{
        echo mensajes('requisitos en blanco','rojo');
    }   
    
  
	
?>

