<?php 

$maindir = "../../../";

/* Accedemos a la base de datos */
include ($maindir.'conexion/conn.php');

try{

    $query = "select count(cod_estado) as cuenta from sa_solicitudes where cod_estado = 1";
    $result = mysql_query($query, $conexion) or die("error en la consulta");

    $query = "select count(cod_estado) as cuenta from sa_solicitudes where cod_estado = 2";
    $result1 = mysql_query($query, $conexion) or die("error en la consulta");
    
    $numero = mysql_fetch_array($result);
    $numero1 = mysql_fetch_array($result1);
    $codMensaje = 1;
  }
  catch(PDOExecption $e){
    $mensaje="Error en la obtencion de datos";
    $codMensaje =0;
  }

?>
    
<script type="text/javascript">

 $(document).ready(function () {
    $('#graficaSolicitudes').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 0,
            plotShadow: false
        },
        title: {
            text: 'Solicitudes<br>Activas',
            align: 'center',
            verticalAlign: 'middle',
            y: 50
        },
        tooltip: {
            pointFormat: '<b>{point.y}</b>'
        },
        plotOptions: {
            pie: {
                dataLabels: {
                    enabled: true,
                    distance: -50,
                    style: {
                        fontWeight: 'bold',
                        color: 'white',
                        textShadow: '0px 1px 2px black'
                    }
                },
                startAngle: -90,
                endAngle: 90,
                center: ['50%', '60%']
            }
        },
        series: [{
            type: 'pie',
            name: 'Solicitudes Activas',
            innerSize: '50%',
            data: [
                <?php
                  echo '["Activas",'.$numero["cuenta"].'],';
                  echo '["Desactivas",'.$numero1["cuenta"].']';
                ?>
            ]
        }]
    });
});

</script>
<div id ="graficaSolicitudes"></div>