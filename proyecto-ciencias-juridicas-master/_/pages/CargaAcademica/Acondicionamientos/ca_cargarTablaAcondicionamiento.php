 <?php
  include '../../../Datos/conexion.php';
?>    

<?php
	$resultado= mysql_query("SELECT codigo, nombre FROM ca_acondicionamientos");
	while ($row = mysql_fetch_array($resultado)) 
	{
		$codigo = $row['codigo'];
		$nom=$row['nombre'];
		?>
		<tr height="50px">
			<td id="codigo">
				<?php echo $codigo ?>
			</td>
			<td id="nombreT">
				<?php echo $nom ?>
			</td>
			<td>
				<center>
				  <button type="button"  id="editar" href="#" class="editaAcondicionamiento btn btn-primary glyphicon glyphicon-edit"  data-toggle="modal" data-target="#editarModal" data-whatever="@mdo"></button>
				</center>
			</td>
			<td>
				<center>
				  <button type="button"  id="eliminar" href="#" class="eliminaAcondicionamiento btn btn-danger glyphicon glyphicon-trash"></button>
				</center>
			</td>
		</tr>
		<?php
	} 
?>