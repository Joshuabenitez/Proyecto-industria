<?php

 

require_once 'funciones.php';
  	

    if (isset($_POST['Pais'])) 
    {
        $Pais = $_POST['Pais']; 
        $PaisRepetido = mysql_query("SELECT * FROM `pais` WHERE pais.Nombre_pais ='$Pais'  LIMIT 1");
        $Pais_=""; 
       
         while($row =mysql_fetch_array($PaisRepetido)){
               $Pais_ =$row['Nombre_pais'];
      }
        
      if($PaisRepetido=$Pais_){
            echo mensajes('Nombre de Pais Repetido','rojo');
      }
      else{
       $query =mysql_query("INSERT INTO pais(Nombre_pais) VALUES('$Pais')"); 
       if($query){   
           echo mensajes('Agregado con Exito','verde');
       }else{
        
           echo mensajes('no se puedo ingresar registro','rojo');
       }  
  

      }
    }   
   
   
    
    
?>
