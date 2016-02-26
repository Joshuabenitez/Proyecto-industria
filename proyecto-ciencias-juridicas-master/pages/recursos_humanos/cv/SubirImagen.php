<?php
include "../../../Datos/conexion.php";
if(is_array($_FILES)) {
	if(is_uploaded_file($_FILES['userImage']['tmp_name'])) {
		if (!empty($_POST['identi'])) {
    		$identi = $_POST['identi'];
			$sourcePath = $_FILES['userImage']['tmp_name'];
			$archivo = $_FILES['userImage']['name'];
			$trozos = explode(".", $archivo); 
			$extension = end($trozos); 
			$nombreFoto = $identi.'.'.$extension;
			$targetPath = 'Fotos_perfil/Fotografias/'.$nombreFoto;
			if(move_uploaded_file($sourcePath,$targetPath)) {
					$queryFoto=mysql_query("UPDATE `persona` SET `foto_perfil` = '".$nombreFoto."' WHERE `persona`.`N_identidad` = '".$identi."'");
		        	if($queryFoto){
		               $mensaje = 'Fotografía agregada con éxito!';
		               $codMensaje = 1;
		       		}else{
		               $mensaje = 'Error al cargar la fotografia';
		               $codMensaje = 0;
		    		}
		    		if(isset($codMensaje) and isset($mensaje)){
					    if($codMensaje == 1){
					      echo '<img src="pages/recursos_humanos/cv/'.$targetPath.'"/>';
					    }else{
					      echo '<div class="alert alert-danger">';
					      echo '<a href="#" class="close" data-dismiss="alert">&times;</a>';
					      echo '<strong>Error! </strong>';
					      echo $mensaje;
					      echo '</div>';
					    } 
					} 
			}
		}
	}
}
?>