
<?php 
  // <!-- Declaramos la direccion raiz -->
  $maindir = "../../";

//acceso a bases de datos
include ($maindir.'conexion/config.inc.php');


  try{

    $query = $db->prepare("select count(estado) as cuenta from usuario where estado = 1");
    $query ->execute();

    $query2 = $db->prepare("select count(estado) as cuenta from usuario where estado = 0");
    $query2->execute();    

    $numero = $query ->fetch();
    $numero1 = $query2->fetch();
    $codMensaje = 1;
  }
  catch(PDOExecption $e){
    $mensaje="Error en la obtencion de datos";
    $codMensaje =0;
  }


?>

    
<script type="text/javascript">
 $(document).ready(function () {
    $('#graficaUsers').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 0,
            plotShadow: false
        },
        title: {
            text: 'Usuarios<br>Activos',
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
            name: 'Usuarios Activos',
            innerSize: '50%',
            data: [
                <?php
                  echo '["Activos",'.$numero["cuenta"].'],';
                  echo '["Desactivos",'.$numero1["cuenta"].']';
                ?>
            ]
        }]
    });
});

</script>

<div id="graficaUsers" style="width: 100%; height: 255px; margin: 0 auto">
    <h1>Hola Mundo</h1>
</div>