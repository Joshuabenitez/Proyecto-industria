
<?php
  include '../../../Datos/conexion.php';
?>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<form id="form" method="POST" action="pages/CargaAcademica/BusquedaAvanzada/verDatos.php">
			<div class="form-group">
				<label >Ingrese el año</label>
				<input type="text"  name="anio" id="anio" placeholder="Ejemplo: 2015">
			</div>
			<br>
			<div class="form-group" >
				<label>Seleccione el periodo</label>
				<div >
		  			<select class="form-control" name="periodoC" id="periodoC" >
		    			<option value="1">Primer  Periodo (1)</option>
					    <option value="2">Segundo Periodo (2)</option>
					    <option value="3">Tercer  Periodo (3)</option>
					</select>
		  			<br>
		 		</div>
		 	</div>
			<button id="btn" type="submit" class="btn btn-default" >Generar Reporte (PDF))</button>
		</form>
	</body>
</html>

