<?php 
require("../../conexion/config.inc.php");
    $errores=array();
    $datos=array();
    $id;

     if(empty($_POST['Edificio_ID']))
        { 
          $errores['Edificio_ID']="se requiere especificar el id Edificio_ID";
        }
    else
    
    {
      $id=$_POST['Edificio_ID']; 

    }

         



          if (empty($errores))
          {

            $sql="SELECT * FROM `permisos` WHERE id_Edificio_Registro='$id'";
            $rec =$db->prepare($sql);
            $rec->execute();
            $total = $rec->rowcount();
            if ($total==0) {
                
                   $del="DELETE FROM `edificios` WHERE Edificio_ID='$id'";
                   $rec =$db->prepare($del);
                   $rec->execute();
                   if ($rec) {
                             $datos['exito']=true;
                             $datos['mensaje']="transaccion exitosamente .....";
                             }
                   else {
                             $datos['exito']=false;
                             $errores['ErrorEliminar']="error Eliminar";
                             $datos['errores']=$errores;
                             }


            } else {
                $datos['exito']=false;
                $errores['motivorelacionado']="Edificio  no  se puede Eliminar";
                $datos['errores']=$errores;

            }
            

          }
          else
               {
              $datos['exito']=false;
              $datos['errores']=$errores;

              }



echo json_encode($datos);








 ?>