<?php 

//conexion a la base de datos 
$maindir = "../../../";
require($maindir."conexion/config.inc.php");

 
											     


//variables recibidas por ajax	
$idusuario =  $_POST['idusuario'];
$idEmpleado =  $_POST['no_empleado'];
$depto = $_POST['area'];
$motivo =  $_POST['motivo'];
$edificio =  $_POST['edificio'];
$fecha =  $_POST['fecha'];
$horai =  $_POST['horai'];
$horaf =  $_POST['horaf'];
$cantidad =  $_POST['cantidad'];
$tildes=$db->exec("set names utf8");

//$tildes = $link->query("SET NAMES 'utf8'"); //Para que se muestren las tildes
$cont=0;
//echo $idEmpleado;
//consultas para encontrar los ID de cada campo seleccionado en los combobox
//$result = mysqli_query($link, "SELECT Edificio_ID FROM edificios  where descripcion='".$edificio."'");
//$result2 = mysqli_query($link, "SELECT Id_departamento_laboral FROM departamento_laboral  where nombre_departamento='".$depto."'");
//$result3 = mysqli_query($link, "SELECT Motivo_ID FROM motivos  where descripcion='".$motivo."'");
//$result5 = mysqli_query($link, "SELECT DATE_FORMAT(NOW(), '%Y-%m-%d') as fecha_slctd");

$sql1="SELECT Edificio_ID FROM edificios  where descripcion='".$edificio."'";
$result  =$db->prepare($sql1);
$result->execute();
$sql2="SELECT Id_departamento_laboral FROM departamento_laboral  where nombre_departamento='".$depto."'";
$result2  =$db->prepare($sql2);
$result2->execute();
$sql3="SELECT Motivo_ID FROM motivos  where descripcion='".$motivo."'";
$result3  =$db->prepare($sql3);
$result3->execute();
$sql5="SELECT DATE_FORMAT(NOW(), '%Y-%m-%d') as fecha_slctd";
$result5  =$db->prepare($sql5);
$result5->execute();


//$consult = mysqli_query($link, "SELECT No_Empleado FROM usuario  where id_Usuario='$idusuario'");
//$row2 = mysqli_fetch_array($consult);

//se obtiene la fecha para validar que no hayan solicitudes con misma fecha para un usuario
//$fquery = mysqli_query($link, "select fecha_solicitud, DATE_FORMAT(fecha, '%Y-%m-%d') as fecha from permisos where permisos.No_Empleado='".$idEmpleado."' and permisos.estado = 'En espera'");
//$frow = mysqli_fetch_array($fquery);


$sql7="select fecha_solicitud, DATE_FORMAT(fecha, '%Y-%m-%d') as fecha from permisos where permisos.No_Empleado='".$idEmpleado."' and permisos.estado = 'En espera'";
$consult1 =$db->prepare($sql7);
$consult1 ->execute();
$frow = $consult1->fetch();


// data seek de consultas
//mysqli_data_seek ($result,$cont);
//mysqli_data_seek ($result2,$cont);
//mysqli_data_seek ($result3,$cont);

// arreglos de consultas
//$extraido= mysqli_fetch_array($result);
//$extraido2= mysqli_fetch_array($result2);
//$extraido3= mysqli_fetch_array($result3);
//$fecha_solic = mysqli_fetch_array($result5);
$extraido= $result->fetch();
$extraido2=$result2->fetch();
$extraido3=$result3->fetch();
$fecha_solic =$result5->fetch();

//Consulta de inserción a la base de datos
	$query = "INSERT INTO permisos (
	id_departamento,
	No_Empleado,
	id_motivo,
	dias_permiso,
	hora_inicio,
	hora_finalizacion,
	id_Edificio_Registro,
	fecha,
	estado,
	fecha_solicitud,
	id_usuario)
	VALUES(
	'".$extraido2['Id_departamento_laboral']."',
	'".$idEmpleado."',
	'".$extraido3['Motivo_ID']."',
	'".$cantidad."',
	'".$horai."',
	'".$horaf."',
	'".$extraido['Edificio_ID']."',
	'".$fecha."',
	'Espera',
	Date_format(now(),'%Y-%m-%d'),
	'".$idusuario."'
	)";
	//se ejecuta la consulta de insercion y se verifica si se ha realizado o si ha fallado
    $sql8="SELECT DATE_FORMAT(fecha, '%Y-%m-%d') as fecha from permisos where fecha between DATE_SUB(DATE_FORMAT('".$fecha."', '%Y-%m-%d'), INTERVAL '".$cantidad."' DAY) 
							and DATE_ADD(DATE_FORMAT('".$fecha."', '%Y-%m-%d'), INTERVAL '".$cantidad."' DAY) and No_Empleado = '".$idEmpleado."'";
	
	//$result6 = mysqli_query($link, "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') as fecha from permisos where fecha between DATE_SUB(DATE_FORMAT('".$fecha."', '%Y-%m-%d'), INTERVAL '".$cantidad."' DAY) 
	//						and DATE_ADD(DATE_FORMAT('".$fecha."', '%Y-%m-%d'), INTERVAL '".$cantidad."' DAY) and No_Empleado = '".$idEmpleado."'");
	//$field_cnt = $result6->field_count;
     $re=$db->prepare($sql8);
     $re->execute();



    $total = $re->rowcount();
	
	if($total>=0){
		if($fecha_solic['fecha_slctd']==$frow['fecha_solicitud']){
			//echo "Solamente puede realizar una solicitud por día";
			echo 3;
		}else{
			if($fecha == $frow['fecha']){
				//echo "Ya tiene una solicitud de permiso con la fecha ingresada";
				echo 2;
			}else{ 
				$rec2 =$db->prepare($query);
                   $rec2->execute();
                   if( $rec2)
                           {
                             echo 1;

                            }
			}
		}
	}else{
		//echo "Hay traslape de fechas con una solicitud previa";
		echo 4;
	}
	
   

?>











