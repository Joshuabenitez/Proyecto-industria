

<?php
$maindir = "../../../"; 
require($maindir ."conexion/config.inc.php");
    $errores;
    
    $id;

       //validar  parametro
    if(empty($_POST['Motivo_ID']))
        {
         $errores=4;

        }
    else
        {
            $id=$_POST['Motivo_ID']; 
            $sql="SELECT * FROM permisos WHERE id_motivo='$id'";
            $rec =$db->prepare($sql);
            $rec->execute();
            $total = $rec->rowcount();
            if ($total==0) {
                
                   $del="DELETE FROM `motivos` WHERE Motivo_ID='$id'";
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