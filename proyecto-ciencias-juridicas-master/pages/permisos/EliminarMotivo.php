<?php 
require("../../conexion/config.inc.php");
    $errores=array();
    $datos=array();
    $id;

       //validar  parametro
    if(empty($_POST['Motivo_ID']))
        {
         $errores['Motivo_ID']="se requiere especificar el id motivo";

        }
    else
        {
            $id=$_POST['Motivo_ID'];  

         }

          if (empty($errores))
          {

            $sql="SELECT * FROM permisos WHERE id_motivo='$id'";
            $rec =$db->prepare($sql);
            $rec->execute();
            $total = $rec->rowcount();
            if ($total==0) {
                
                   $del="DELETE FROM `motivos` WHERE Motivo_ID='$id'";
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
                $errores['motivorelacionado']="Motivo  no  se puede Eliminar";
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