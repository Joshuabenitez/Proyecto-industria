<?php 
 
$mkdir = "../../../";
include($mkdir."conexion/config.inc.php");

    $query = 'SELECT concat(Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_apellido) AS NOMBRE, COUNT(sa_solicitudes.codigo) AS NUMERO_SOLICITUDES
              FROM persona
              INNER JOIN sa_solicitudes ON (persona.N_identidad = sa_solicitudes.dni_estudiante)
              GROUP BY NOMBRE';
    $result = mysql_query($query);
?>


<script>
$(function () {
    $(document).ready(function () {

        // Build the chart
        $('#graficaEstudiantes').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Solicitudes por Estudiante'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.y}</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                name: "Solicitudes de estudiantes",
                colorByPoint: true,
                data: [
                <?php
                    $numItems = mysql_num_rows($result);
                    for($i = 0 ;$fila = mysql_fetch_array($result); $i++){
                        if ($i == 1){
                            $nombre = $fila["NOMBRE"];
                            $y = $fila["NUMERO_SOLICITUDES"];
                            echo "{name: '".$nombre."', y: ".$y.",
                               sliced: true,
                               selected: true }";
                        }else{
                            $nombre = $fila["NOMBRE"];
                            $y = $fila["NUMERO_SOLICITUDES"];
                            echo "{name: '".$nombre."', y: ".$y."}";
                        }
                        if($i != $numItems) {
                            echo ",";
                        }
                    }  
                ?>]
            }]
        });
    });
});

</script>
<div id ="graficaEstudiantes"></div>