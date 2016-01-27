<?php 
$maindir = "../../../"; 
require($maindir ."conexion/config.inc.php");
    $errores;
     if(empty($_POST['Edificio_ID']))
        { 
          $errores=4;
        }
        else
        {


            $id=$_POST['Edificio_ID']; 
            $sql="SELECT * FROM `permisos` WHERE id_Edificio_Registro='$id'";
            $rec =$db->prepare($sql);
            $rec->execute();
            $total = $rec->rowcount();
            if ($total==0) {
                
                   $del="DELETE FROM `edificios` WHERE Edificio_ID='$id'";
                   $rec =$db->prepare($del);
                   $rec->execute();
                   if ($rec) {
                              $errores=1;
                             
                             }
                   else {
                             $errores=3;


                             }


            } else {
               

               $errores=2;
            }




        }
    

        
          



echo $errores;












 ?>