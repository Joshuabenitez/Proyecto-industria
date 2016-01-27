 <?php
  include '../../../Datos/conexion.php';
?>    
<?php

	$resultado=mysql_query("SELECT codigo, descripcion FROM sa_tipos_estudiante");
	while ($row = mysql_fetch_array($resultado)) 
	{
		$codigo = $row['codigo'];
		$descripcion=$row['descripcion'];
		?>
		<option  value=  <?php echo "'".$row['codigo']."'" ?> > <?php echo $descripcion ?></option>
		<?php
	} 
?>