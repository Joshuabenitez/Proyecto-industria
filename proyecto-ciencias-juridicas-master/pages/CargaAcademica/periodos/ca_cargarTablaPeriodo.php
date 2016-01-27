 <?php
  include '../../../Datos/conexion.php';
?>    

<?php
	$resultado= mysql_query("SELECT codigo, nombre FROM sa_periodos");
	while ($row = mysql_fetch_array($resultado)) 
	{
		$codigo = $row['codigo'];
		$nom=$row['nombre'];
		?>
		<tr height="50px">
			<td id="codigo" hidden>
				<?php echo $codigo ?>
			</td>
			<td id="nombreT">
				<?php echo $nom ?>
			</td>
			<td>
				<center>
				  <button type="button"  id="editar" href="#" class="editarFacultad btn btn-primary glyphicon glyphicon-edit"  data-toggle="modal" data-target="#editarModal" data-whatever="@mdo"></button>
				</center>
			</td>
			<td>
				<center>
				  <button type="button"  id="eliminar" href="#" class="eliminarFacultad btn btn-danger glyphicon glyphicon-trash"></button>
				</center>
			</td>
		</tr>
		<?php
	} 
?>