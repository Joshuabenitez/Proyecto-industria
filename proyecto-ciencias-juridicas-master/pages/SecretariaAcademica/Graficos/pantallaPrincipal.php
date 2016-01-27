 <!-- libreria para generar graficos -->
<script src="js/plugins/Highcharts-4/js/highcharts.js" type="text/javascript"></script>
<link href="css/datepicker.css" rel="stylesheet">
<link href="css/prettify.css" rel="stylesheet">

<script src="js/prettify.js"></script>
<script src="js/bootstrap-datepicker.js"></script>

<!-- Procedimento para obtener las solitudes del sistema -->
<script>

var codiEliminar;
/* Cargar la grafica de solicitudes la cual nos muestra las graficas que estan activas en el sistema 
 y tambien las desactivas */
cargarGraficaSolicitudes();

/* Carga la grafica de estudiantes con el numero de Solicitudes realizadas */
cargarGraficaEstudiantes();

/* Carga la tabla con las solicitudes activas en el sistema */
cargarSolicitudes();

/* Funcion para cargar dentro del div Estudiantes los graficos en la direccion indicada */
function cargarGraficaSolicitudes(){
    $("#EstadoSolicitudes").load("pages/SecretariaAcademica/Graficos/grafoSolicitudes.php");
}

function cargarGraficaEstudiantes(){
    $("#Estudiantes").load("pages/SecretariaAcademica/Graficos/grafoEstudiantes.php");
}
/* Funcion que llena el cuerpo de la tabla con las solicitudes en el sitema para luego llegar la tabla */
function cargarSolicitudes(){
        var datos = {
            accion: 1
         };

        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Graficos/cargarSolicitudes.php",
            data: datos,
            dataType: "html",
            success: function(data){            
                $("#cTablaSolicitudes").html(data);

                /* Script que permite a la tabla hacer busquedas dentro de ella
                    y ordenarla deacuerdo a lo que se presenta en ella.*/
                $('#tableSolicitudes').dataTable({
            dom: 'Blfrtip',
        buttons: [

            {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: [ 0, ':visible' ]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                    columns: ':visible'
                },
                download: 'open'
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: ':visible'
                },
                download: 'open'
            },
            {
                extend: 'print',
                exportOptions: {
                    columns: ':visible'
                }
            },
            'colvis'
        ]
         }); 
            },
            timeout: 4000
        }); 
    }

    /* Funcion Para organizar el modal para reprogramar una solicitud */
    $(document).on("click",".editar",function (e){
        e.preventDefault();
        $("#Mdiv_editarSolicitud").html("");
        var id =  $(this).data('id');
        var himno = $(this).data('himno'); 

        var options = '';

        if(himno == 'No'){

            options =   '<div class="form-group">'+
                        '<label>Codigo de la Solicitud</label>'+
                        '<input id="codSolicitud" disabled = "true" data-id="' + id + '" placeholder="' + id + '" class="form-control">'+
                    '</div>'+
                    '<div class="form-group">'+
                        '<label>Fecha de Reprogramacion</label>'+
                        '<input data-inputmask= "alias: dd/mm/yyyy" format="yyyy-mm-dd" class="form-control" id="txtFechaSolicitud" placeholder="yyyy-mm-dd" type="date">'+
                    '</div>'+
                    '<div class="form-group">'+
                            '<label>Fecha de Reprogramacion del himno</label>'+
                            '<input disabled = "true" data-inputmask= "alias: dd/mm/yyyy" format="yyyy-mm-dd" class="form-control" id="FechaHimno" placeholder="yyyy-mm-dd" type="date">'+
                    '</div>';

        }else{
            options =   '<div class="form-group">'+
                            '<label>Codigo de la Solicitud</label>'+
                            '<input id="codSolicitud" disabled = "true" data-id="' + id + '" placeholder="' + id + '" class="form-control">'+
                        '</div>'+
                        '<div class="form-group">'+
                            '<label>Fecha de Reprogramacion</label>'+
                            '<input data-inputmask= "alias: dd/mm/yyyy" format="yyyy-mm-dd" class="form-control" id="txtFechaSolicitud" placeholder="yyyy-mm-dd" type="date">'+
                        '</div>'+
                        '<div class="form-group">'+
                            '<label>Fecha de Reprogramacion del himno</label>'+
                            '<input data-inputmask= "alias: dd/mm/yyyy" format="yyyy-mm-dd" class="form-control" id="FechaHimno" placeholder="yyyy-mm-dd" type="date">'+
                        '</div>';
        }
        /* Insertamos dentro del div del modal los datos obtenidos en la base de datos */
        $("#Mdiv_editarSolicitud").html(options);

        /* Cuando ya tenemos listo el modal con los datos que queriamos, abrimos el modal */
        $('#compose-modal-modificar').modal('show');

    });


    
    /* Este evento se levanta cuando le damos submit al modal, para mandar a ingresar la informacion que 
    indicamos que queremos modificar */
    $("#form_Modificar").submit(function (e){
        e.preventDefault();
        var datos = {
            codSolicitud: $("#codSolicitud").data('id'),
            fechaSolicitud: $("#txtFechaSolicitud").val(),
            fechaHimno: $("#FechaHimno").val()
        }
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Graficos/reprogramarSolicitudes.php",
            data: datos,
            dataType: "html",
            success: function(data){
                $('#compose-modal-modificar').modal('hide');
                $("#notificaciones").html(data);
                $("#notificaciones").fadeOut(4500);
                cargarSolicitudes();
            },
            timeout: 4000
        });

    });

 /* Se levanta cuando se le da submit al form de dar de alta a una solicitud */
    $("#form_Eliminar").submit(function (e){
        e.preventDefault();
        var id = codiEliminar;
        alert(id);
        var data = 
        {
            codigo: id,
            notaHimno: $("#txtEliminar").val()
        };
        $.ajax({
            async: true,
            type: "POST",
            dataType: "html",
            data: data,
            contentType: "application/x-www-form-urlencoded",
            success: function(data){
                $('#compose-modal-eliminar').modal('hide');
                $("#notificaciones").html(data);
                $("#notificaciones").fadeOut(4500);
                cargarSolicitudes();
            },
            url: "pages/SecretariaAcademica/Graficos/eliminarSolicitud.php",
            timeout: 4000
        }); 

    });

    /* Este evento se levanta cada vez que le damos click al bottton eliminar */
    $(document).on("click",".elimina",function () {
        
        codiEliminar = $(this).data('id');
        var himno = $(this).data('himno');
        var opcion = '';
        if(himno == 'No'){
            opcion = '<div class="form-group">'+
                            '<label>Nota de himno</label>'+
                            '<input disabled = "true" class="form-control" id="txtEliminar" type="text">'+
                     '</div>';
        }else{
            opcion = '<div class="form-group">'+
                            '<label>Nota de himno</label>'+
                            '<input class="form-control" id="txtEliminar" type="text">'+
                     '</div>';
        }
        $("#Mdiv_eliminarSolicitud").html(opcion);
        $('#compose-modal-eliminar').modal('show');               
    });


</script>
<script>
    /* Funcion necesaria para cargar el componente para eleccion de fecha */
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
                $('#txtFechaSolicitud').datepicker('hide');
            });

        });
</script>

<!-- En esta seccion se muestran los primeros dos divs, el primero muestra el estado  de solicitudes 
    y la cantidad de ellas.
    El segundo el numero de estudiantes dependiendo el tipo de estudiante -->

<!-- div para mostrar errores en el servidor -->
<div class = "col-md-12" id = "notificaciones"></div>
<div class = "col-md-12">
    <div class = "col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <label><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Estado de Solicitudes </label>
            </div>
            <div class="panel-body" id = "EstadoSolicitudes"></div>
        </div>
    </div>
    <div class = "col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <label><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Estudiantes </label>
            </div>
            <div class="panel-body" id= "Estudiantes">
            </div>
        </div>
    </div>
</div>
<!-- Tabla de solicitdes en el sistema -->
<div class = "col-md-12">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <label><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Solicitudes </label>
        </div>
        <div class="panel-body" id = "Solicitudes">
            <section class="content">
                <div class="box-body table-responsive">
                    <table id= "tableSolicitudes" class="table table-bordered table-hover table-striped">
                        <thead>
                            <tr align="center">
                                <th hidden>Cod</th>
                                <th>Estudiante</th>  
                                <th>Fecha</th>   
                                <th>Observaciones</th>
                                <th>Estado</th>  
                                <th>DNI</th>
                                <th>Tipo Solicitud</th>
                                <th>Himno</th>
                                <th>Reprogramar</th>
                                <th>Registrar Nota</th>

                            </tr>
                        </thead>
                        <tbody id = "cTablaSolicitudes">
                            <!-- Contenido de la tabla generado atravez de la consulta a 
                                la base de datos -->
                        </tbody>
                    </table>       
                </div>
            </section>
        </div>
    </div>
</div>

<!-- Modal para editar una solicitudes -->
<div  class="modal fade" id="compose-modal-modificar" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" id="form_Modificar" name="form_insertar" action="#">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Modificar Solicitud</h4>
                </div>
                <div class = "modal-body">
                    <div id= "Mdiv_editarSolicitud">
                        
                    </div>                
                </div>
                <div class="modal-footer">
                    <button  id="guardaredicion" class="btn btn-primary" >Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para dar de alta a la solicitudes -->
<div  class="modal fade" id="compose-modal-eliminar" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" id="form_Eliminar" name="form_eliminar" action="#">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Modificar Solicitud</h4>
                </div>
                <div class = "modal-body">
                    <div id= "Mdiv_eliminarSolicitud">
                        <!-- Seccion para armar el modal dependiendo el himno -->
                    </div>                
                </div>
                <div class="modal-footer">
                    <button  id="guardarEliminar" class="btn btn-primary" >Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>
