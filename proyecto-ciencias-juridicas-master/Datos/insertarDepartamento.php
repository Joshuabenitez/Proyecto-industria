<?php

require_once('funciones.php');
    if (isset($_POST['departamento'])) 
    {
        $depto = $_POST['departamento']; 
       

        $DeptoRepetido = mysql_query("SELECT * FROM  departamento_laboral WHERE departamento_laboral.nombre_departamento='$depto' LIMIT 1");
        $Depto_="";
   
   while($row =mysql_fetch_array($DeptoRepetido)){
        $Depto_ = $row['nombre_departamento'];

    }   

    if($DeptoRepetido = $Depto_){
      echo mensajes('Nombre de departamento Repetido','rojo');

    }
    else{
      $query = "INSERT INTO departamento_laboral(nombre_departamento) VALUES('$depto')";
        mysql_query($query); 
             if($query){   
           echo mensajes('Agregado con Exito','verde');
       }else{
           echo mensajes('no se puedo ingresar registro','rojo');
       }
    }
    


    }
      
?>
