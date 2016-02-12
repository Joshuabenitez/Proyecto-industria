 <?php
  include '../../../Datos/conexion.php';
?>    
<?php
if(!isset($_SESSION)){
    session_start();
}
            $codIA = $_SESSION['aula'];
        
	$resultado=mysql_query("CALL SP_OBTENER_INSTANCIAS_ACONDICIONAMIENTOS(".$codIA.")");
	while ($row = mysql_fetch_array($resultado)) 
	{
		$codigo = $row['cod_aula'];
		$nom=$row['cod_instancia_acondicionamiento'];
                $item = $row['item'];
		?>
		<tr height="50px">
                        <td hidden id='item'>
                            <?php echo $item ?>
                        </td>
			<td id="codigo">
				<?php echo $codigo ?>
			</td>
			<td id="nombreT">
				<?php echo $nom ?>
			</td>
			<td>
				<center>
				  <button type="button"  id="eliminar" href="#" class="elimina btn btn-danger glyphicon glyphicon-trash"></button>
				</center>
			</td>
		</tr>
		<?php
	} 
?>


