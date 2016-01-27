<script>
    
function generarReporte()
{
  
  window.open('pages/CargaAcademica/BusquedaAvanzada/reporte_busquedaAvanzada.php');
}

$( document ).ready(function()
{
    filtrarProyectos();
});

function filtrarProyectos()
{
 var datos =  
   {
       accion: 2
   };
    $.ajax({
        async: true,
        type: "POST",
        // dataType: "html",
        // contentType: "application/x-www-form-urlencoded",
        url: "pages/CargaAcademica/BusquedaAvanzada/ajax_busquedaAvanzada.php",
        data: datos,
        success: function(data){
            var response = JSON.parse(data);
            var options = '';
            
            //Clearing
            $("#cuerpoTablaProyectos").html('');
            
            if(response.length <= 0)
            {
                $("#cuerpoTablaProyectos").html('No se encontraron proyectos ');
            }

            for (var index = 0;index < response.length; index++)
            {
               options += "<tr>" +
                                "<td>" + response[index].codigoProyecto + "</td>" +
                                "<td>" + response[index].nombreProyecto + "</td>" +
                                "<td>" + response[index].nombreVinculacion + "</td>" +
                                "<td>" + response[index].nombreArea + "</td>" +
                                "<td>" + response[index].nombreCoordinador + "</td>" +
                          "</tr>";
            }

            $('#cuerpoTablaProyectos').append(options);
        },
        timeout: 4000
    });    
}
$('#filtrarProyectos').click(function(event) 
{

  

});

function antesdemandar(){
  var x = $("#notificaciones");
  x.html('Cargando...');
}


// Habilita y deshabilita los inputs

function cambiarEstadoInput(codigoInput)
{
    var htmlElement = document.getElementById(codigoInput);

    if(htmlElement.disabled)
    {
        htmlElement.disabled = false;
    }
    else
    {
        htmlElement.disabled = true;
        
        if(codigoInput === 'cmbTipoSolicitud')
        {
            $("#" + codigoInput).val('NULL');
        }    
        else
        {
            $("#" + codigoInput).val('');
        }
    }
}

</script>
</script>

<link href="css/datepicker.css" rel="stylesheet">
<link href="css/prettify.css" rel="stylesheet">

<script src="js/prettify.js"></script>
<script src="js/bootstrap-datepicker.js"></script>

<script>
    if (top.location != location) {
    top.location.href = document.location.href ;
  }
        $(function(){
            window.prettyPrint && prettyPrint();
            $('#txtFechaSolicitud').datepicker({
                format: 'yyyy-mm-dd',
                language: "es",
                autoclose: true,
                todayBtn: true
            }).on('show', function() {
                var zIndexModal = $('#myModal').css('z-index');
                var zIndexFecha = $('.datepicker').css('z-index');
                $('.datepicker').css('z-index',zIndexModal+1);
            }).on('changeDate', function(ev){
                $('#dp1').datepicker('hide');
            });

        });
</script>

 <div class="panel panel-primary">
   <div class="panel-heading">
      <h4 class="panel-title">
          <label><span class="glyphicon glyphicon-file" aria-hidden="true"></span> Busqueda avanzada</label>
      </h4>
   </div>
   <div class = "panel-body">
   <br>
   <br>
   <div id = "notificaciones"></div>
<section onload="">
  <div class = "col-sm-12">


        <!-- Creamos la tabla para mostrar las solicitudes -->
      <div class="box-body table-responsive ">
         <table id = "tablaBusquedaProyectos" class='table table-bordered table-striped display' cellspacing="0" >
            <thead >
              <tr>
                <th>Código de proyecto</th>
                <th>Nombre de proyecto</th>
                <th>Área de Vinculación</th>
                <th>Área </th>
                <th>Coordinador</th>
              </tr>
            </thead>
            <tbody id = "cuerpoTablaProyectos">

            </tbody>
          </table>
      </div>
    </div>
    <button onclick="generarReporte()" id="generarReporteProyectos" class="ActualizarB btn btn-primary">Generar reporte</button>
  </section>
  </div>
</div>
