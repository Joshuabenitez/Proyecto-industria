


<?php
$mkdir = "../../../";
include($mkdir."Datos/conexion.php");

    /* Hacemos una consulta a la base de datos para obtener los datos de la tabla Ciudades. */
        $result = mysql_query('CALL SP_OBTENER_SOLICITUDES(@pcMensajeError)',$enlace);
        $json = array();
        $contadorIteracion = 0;


        while ($fila = mysql_fetch_array($result)) { 
            echo '<tr>'.
            '<td hidden>'.$fila["CODIGO"].'</td>'.
            '<td>'.$fila["NOMBRE"].'</td>'.
            '<td>'.$fila["FECHA_SOLICITUD"].'</td>'.
            '<td>'.$fila["OBSERVACIONES"].'</td>'.
            '<td>'.$fila["ESTADO"].'</td>'.
            '<td>'.$fila["DNI_ESTUDIANTE"].'</td>'.
            '<td>'.$fila["TIPO_SOLICITUD"].'</td>'.
            '<td>'.$fila["APLICA_PARA_HIMNO"].'</td>'.
            '<td><center>'
                    . '<button data-himno = "'.$fila["APLICA_PARA_HIMNO"].'" '
                    . 'data-id = "'.$fila["CODIGO"].'" '
                    . 'href= "#" class = "editar btn_editar btn btn-info"  '
                    . 'data-toggle="modal" data-target = "">'
                    . '<i class="glyphicon glyphicon-edit">'
                    . '</i>'
                    . '</button>'.
            '</center></td>'.
            '<td><center>'.
            '<button data-himno = "'.$fila["APLICA_PARA_HIMNO"].'" '
                    . 'data-id = "'.$fila["CODIGO"].'" href= "#" '
                    . 'class = "elimina btn_editar btn btn-success" '
                    . 'data-toggle="modal" data-target = "">'
                    . '<i class="glyphicon glyphicon-edit">'
                    . '</i>'
                    . '</button>'.
            '</center></td>'.
      '</tr>';
        }
?>

