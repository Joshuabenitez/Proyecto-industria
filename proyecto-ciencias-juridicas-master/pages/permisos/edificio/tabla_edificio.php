


<?php 
$maindir = "../../../";


require($maindir."conexion/config.inc.php");
$sql="SELECT * from edificios";
$rec =$db->prepare($sql);
$rec->execute();
?>



										
										<?php
              
                   echo <<<HTML
                                    <table id="tabla_Edificios" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                            <th style='display:none'><strong>ID Edificio</strong></th>
                                             <th><strong>Nombre Edificio</strong></th>
                                             <th><strong>Editar</strong></th>
                                             <th><strong>Eliminar</strong></th>

                                            </tr>
                                        </thead>
                                        <tbody>
HTML;

               while ($row = $rec->fetch())  {

				$idE = $row['Edificio_ID'];
				$dedificio = $row['descripcion'];
            
            
                echo "<tr data-id='".$idE."'>";
                echo <<<HTML
                <td style='display:none'> $idE</td> 
HTML;
               

               echo <<<HTML
				
                <td>$dedificio</td>
				
				<td><center>
                    <a class="open-Modal btn btn-primary" data-toggle="modal" data-id=$idE data-target="#compose-modal"><i class="fa fa-edit"></i></a>
                </center></td>
                <td><center>
                    <a class="open-Modal-Eliminar btn btn-danger"  data-toggle="modal" data-idEliminar=$idE data-target="#Eliminar-modal" ><i class=" fa fa-trash-o"></i></a>
                </center></td>
  
HTML;
                echo "</tr>";

            }

                   echo <<<HTML
                                       
									</table>
HTML;
               ?>

									
