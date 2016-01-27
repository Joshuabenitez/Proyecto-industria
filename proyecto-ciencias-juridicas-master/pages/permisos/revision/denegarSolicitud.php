<?php
	$maindir = "../../../";

	
	
	require_once($maindir . "funciones/check_session.php");
	require($maindir."conexion/config.inc.php");
	
	
  
	$idusuario= $_SESSION['user_id']; 
	$rol = $_SESSION['user_rol'];

		$codpermiso =  $_POST['idpermiso'];
		$obsr = $_POST['obs'];
		$cont=0;
        $sql1="Select No_Empleado from usuario where id_Usuario = '$idusuario'";
		$rec =$db->prepare($sql1);
        $rec->execute();
	    $NoEmp=$rec->fetch();
		
		//$consulta = mysqli_query($conexion, "Select No_Empleado from usuario where id_Usuario = '$idusuario'");
		//$NoEmp = mysqli_fetch_array($consulta);
		
		if($rol==30){
			   $sql2="update permisos set estado = 'Denegado', observacion = '".$obsr."', revisado_por = '".$NoEmp['No_Empleado']."' 
				where id_Permisos = '$codpermiso' and estado = 'Espera'";
		        $rec2 =$db->prepare($sql2);
               $rec2->execute();
               echo 1;

               



			//$resultado = mysqli_query($conexion, "update permisos set estado = 'Denegado', observacion = '".$obsr."', revisado_por = '".$NoEmp['No_Empleado']."' 
			//	where id_Permisos = '$codpermiso' and estado = 'Espera'") or die("Error " . mysqli_error($conexion));			
		}elseif($rol == 50){

             $sql2="update permisos set estado = 'Denegado', observacion = '".$obsr."', revisado_por = '".$NoEmp['No_Empleado']."' 
				where id_Permisos = '$codpermiso' and estado = 'Visto'";
		     $rec2 =$db->prepare($sql2);
             $rec2->execute();
              echo 1;
             


			//$resultado = mysqli_query($conexion, "update permisos set estado = 'Denegado', observacion = '".$obsr."', revisado_por = '".$NoEmp['No_Empleado']."' 
			//	where id_Permisos = '$codpermiso' and estado = 'Visto'") or die("Error " . mysqli_error($conexion));	
		}
		//$query = "update permisos set estado = 'Aprobado', revisado_por = '".$NoEmp."' where id_Permisos = '".$codpermiso."' and estado = 'En espera';";
		
	//}
?>