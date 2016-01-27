<?php
	//El siguiente codigo recibe como parametro el valor del identificador de la fila seleccionada en el formulario y que ha sido enviado con ajax en el javascript
	//y lo utiliza para cambiar un valor en la tabla respectiva de la base de datos

    $maindir = "../../../";
	require($maindir."conexion/config.inc.php");

	$codpermiso =  $_POST['codigo'];
	$usuario = $_POST['usr'];
	$rol = $_POST['rol'];
	$cant = $_POST['cdias'];
	$cont=0;

	
	$sql="Select No_Empleado from usuario where id_Usuario = '".$usuario."'";
    $rec =$db->prepare($sql);
    $rec->execute();
	$NoEmp=$rec->fetch();
	//$consulta = mysqli_query($conexion, "Select No_Empleado from usuario where id_Usuario = '".$usuario."'");
	//mysqli_data_seek ($consulta,$cont);
	//$NoEmp = mysqli_fetch_array($consulta);
	
	if($rol==30 and $cant <3){
		
		$sql="update permisos set estado = 'Aprobado', revisado_por = '".$NoEmp['No_Empleado']."' where id_Permisos = '$codpermiso' and estado = 'Espera'";
        $rec =$db->prepare($sql);
        $rec->execute();
        echo 1;
        
        //$resultado = mysqli_query($conexion, "update permisos set estado = 'Aprobado', revisado_por = '".$NoEmp['No_Empleado']."' where id_Permisos = '$codpermiso' and estado = 'Espera'") or die("Error " . mysqli_error($conexion));
	}elseif($rol==30 and $cant >=3){
		
       $sql="update permisos set estado = 'Visto', revisado_por = '".$NoEmp['No_Empleado']."' where id_Permisos = '$codpermiso' and estado = 'Espera'";
       $rec =$db->prepare($sql);
       $rec->execute();
       echo 1;

		//$resultado = mysqli_query($conexion, "update permisos set estado = 'Visto', revisado_por = '".$NoEmp['No_Empleado']."' where id_Permisos = '$codpermiso' and estado = 'Espera'") or die("Error " . mysqli_error($conexion));
	}elseif($rol==50){
		   $sql="update permisos set estado = 'Aprobado', revisado_por = '".$NoEmp['No_Empleado']."' where id_Permisos = '$codpermiso' and (estado = 'Espera' or estado = 'Visto')";
           $rec =$db->prepare($sql);
           $rec->execute();
           echo 1;
           
		//$resultado = mysqli_query($conexion, "update permisos set estado = 'Aprobado', revisado_por = '".$NoEmp['No_Empleado']."' where id_Permisos = '$codpermiso' and (estado = 'Espera' or estado = 'Visto')") or die("Error " . mysqli_error($conexion));		
	}
	
	//$query = "update permisos set estado = 'Aprobado', revisado_por = '".$NoEmp."' where id_Permisos = '".$codpermiso."' and estado = 'En espera';";
	

?>