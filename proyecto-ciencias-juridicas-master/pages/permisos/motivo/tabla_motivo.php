<?php


$maindir = "../../../";
require($maindir."conexion/config.inc.php");
$sql="SELECT * from motivos";
$rec =$db->prepare($sql);
$rec->execute();





             
            echo <<<HTML
                            <table id="tabla_Motivos" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                            <th style='display:none'><strong>ID Motivo</strong></th>
                                             <th><strong>Descripci&#243;n Motivo</strong></th>
                                             <th><strong>Editar</strong></th>
                                             <th><strong>Eliminar</strong></th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
HTML;

               while ($row = $rec->fetch() ) {

				$idM = $row['Motivo_ID'];
				$dmotivo = $row['descripcion'];
            
            
                echo "<tr   data-id='".$idM."'>";
                echo <<<HTML
                <td style='display:none' >$idM</td>

HTML;
                
                echo <<<HTML
				
                <td>   $dmotivo </td>
				
				<td><center>
                    <a class="open-Modal btn btn-primary" data-toggle="modal" data-id=$idM data-target="#compose-modal"><i class="fa fa-edit"></i></a>
                    
                </center></td>
                <td><center>
                    
                    <a class="open-Modal-Eliminar btn btn-danger"  data-toggle="modal" data-idEliminar=$idM data-target="#Eliminar-modal" ><i class="fa fa-trash-o"></i></a>
                </center></td>
 

HTML;
                echo "</tr>";

            }

                   echo <<<HTML
                                       
									</table>
HTML;
             
               ?>