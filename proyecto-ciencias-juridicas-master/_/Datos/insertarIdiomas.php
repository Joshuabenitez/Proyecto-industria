<?php

require_once('funciones.php');

if (isset($_POST['nombreIdioma'])) {
    $Language = $_POST['nombreIdioma'];
   
   $LanguageRepetido = mysql_query("SELECT * FROM idioma WHERE idioma.Idioma ='$Language' LIMIT 1");
   $Languaje_="";
   
   while($row =mysql_fetch_array($LanguageRepetido)){
       

        $Languaje_=$row['Idioma'];

    }
    if($LanguageRepetido=$Languaje_){
    	 echo mensajes('Idioma ya agregado','rojo');

    }
    else{
    
    $query = "INSERT INTO idioma(Idioma) VALUES('$Language')";
    mysql_query($query);
     echo mensajes('Idioma Agregado con Exito','verde');

    }
   
}


?>