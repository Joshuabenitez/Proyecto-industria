
<script type="text/javascript">
   /* Script que permite cargar todos los elementos de la tabla para mostrar los datos que estan
    Almacenados en la base de datos */
$(document).ready(function() {

    cargarPeriodos(); //Hacemos el llamado para que se cargue la tabla siempre que se cargue la pag.

    /* Este evento se levanta cada vez que le damos click al bottton eliminar */
    $(document).on("click",".eliminarPeriodo",function () {
             
        var respuesta = confirm("¿Esta seguro de que desea eliminar el registro seleccionado?");
        if (respuesta)
        {
            var id = $(this).data('id');

            var data = 
            {
                codigo: id
            };
            $.ajax({
                async: true,
                type: "POST",
                dataType: "html",
                data: data,
                contentType: "application/x-www-form-urlencoded",
                success: function(data){
                    $("#notificaciones1").html(data);
                    $("#notificaciones1").fadeOut(4500);
                    cargarPeriodos();
                },
                url: "pages/SecretariaAcademica/Mantenimiento/Periodos/eliminarPeriodo.php",
                timeout: 4000
            });
        }                 
    });


 /* Este evento se levanta cuando se le da click a el boton de editar */
   $(document).on("click",".editarPeriodo",function (e){
        e.preventDefault();
        $("#Mdiv_editarPeriodo").html("");
        var datos = { 
            
            id:  $(this).data('id') 
        };
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Mantenimiento/Periodos/actualizarPeriodo.php",
            data: datos,
            dataType: "html",
            success: function(data){
                var response = JSON.parse(data);
                var options = '';
                /* En esta seccion llenamos los datos que se van a editar el modal*/ 
                for (var index = 0;index < response.length; index++) 
                {
                   options +=   '<div class="form-group">'+
                                    '<label>Codigo del periodo</label>'+
                                    '<input id="codPeriodo" disabled = "true" data-id="' + response[index].codPeriodo + '" placeholder="' + response[index].codPeriodo + '" class="form-control">'+
                                '</div>'+
                                '<div class="form-group">'+
                                    '<label>Nombre del Periodo</label>'+
                                    '<input id="nombrePeriodo1" placeholder="'+response[index].nombrePeriodo+'" class="form-control" required>'+
                                '</div>';
                }
                /* Insertamos dentro del div del modal los datos obtenidos en la base de datos */
                $("#Mdiv_editarPeriodo").html(options);

                /* Cuando ya tenemos listo el modal con los datos que queriamos abrimos el modal */
                $('#compose-modal-modificar').modal('show');
            },
            timeout: 4000
        });

    });

    /* Evento se levanta cuando queremos insertar un nuevo periodo */

    $("#formInsertar").submit(function (e){
        e.preventDefault();
        var datos = {
            nombrePeriodo: $("#nombrePeriodo").val()
        }
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Mantenimiento/Periodos/insertarPeriodo.php",
            data: datos,
            dataType: "html",
            success: function(data){   
                $("#notificaciones").html(data);
                $("#notificaciones").fadeOut(4500);
                cargarPeriodos();
            },
            timeout: 4000
        });

    });

    
    /* Esta funcion es llamada al principio, es la encargada de actualizar la tabla que muestra
        los periodos que estan en el sistema en ese momento, se recarga cada vez que se elimina o se 
        actualiza */
    function cargarPeriodos(){
        var datos = {
            accion: 1
         };

        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Mantenimiento/Periodos/cargarPeriodos.php",
            data: datos,
            dataType: "html",
            success: function(data){
                var response = JSON.parse(data);
                var options = '';
                /* Seccion para llenar la tabla */
                for (var index = 0;index < response.length; index++) 
                {
                   options += '<tr>' +
                                    '<td>' + response[index].codPeriodo + '</td>' +
                                    '<td>' + response[index].nombrePeriodo + '</td>' +
                                    '<td><center>'+
                                        '<button data-id = "'+ response[index].codPeriodo +'" href= "#" class = "editarPeriodo btn_editar btn btn-info"  data-toggle="modal" data-target = ""><i class="glyphicon glyphicon-edit"></i></button>'+
                                    '</td></center>' +
                                    '<td><center>'+
                                        '<button data-id = "'+ response[index].codPeriodo +'" href= "#" class = "eliminarPeriodo btn_editar btn btn-danger"><i class="glyphicon glyphicon-trash"></i></button>'+
                                    '</td></center>' +             
                              '</tr>';
                }

            
                $("#cTablaPeriodo").html(options);

                /* Script que permite a la tabla hacer busquedas dentro de ella
                    y ordenarla deacuerdo a lo que se presenta en ella.*/
                $('#tablePeriodo').dataTable({
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

    /* Seccion que se manda a llamar cuando dentro de la modal aceptamos e indicamos que lo que queremos 
    modificar ya se hiso */

    $("#form_Modificar").submit(function(e) {
            e.preventDefault();
            $("#compose-modal-modificar").modal('hide');
            datosEditados = {
                codigo: $("#codPeriodo").data('id'),
                nombre: $("#nombrePeriodo1").val()
            };
            $.ajax({
                async: true,
                type: "POST",
                dataType: "html",
                data: datosEditados,
                contentType: "application/x-www-form-urlencoded",
                url: "pages/SecretariaAcademica/Mantenimiento/Periodos/submitModal.php",
                success: function(data){ 
                    $("#notificaciones1").html(data);
                    $("#notificaciones1").fadeOut(4500);
                    cargarPeriodos();
                },
                timeout: 4000
            });
        });
});

</script>


<!-- Div para cargar informacion recibida por el servidor -->
<div id = "notificaciones"></div>

<!-- Seccion para que el usuario indique el nuevo periodo que quiere ingresar -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <label><span class="glyphicon glyphicon-globe" aria-hidden="true"></span> Ingreso de datos del Periodo </label>
            </div>
            <div class="panel-body">
                <div>
                       <div id= "noti1" class="alert alert-info" role="alert"><center>Por favor ingrese los datos que acontinuacion se le piden</center></div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <form id = "formInsertar" role="form" action="#" method="POST">
                            <div id="NPeriodo" class="form-group">
                                <label>Nombre Periodo</label>
                                <input placeholder = "Se necesita un nombre" type="text"  class="form-control" name="nombrePeriodo" id="nombrePeriodo" required >
                            </div>
                            <button type="submit" name="submit"  id="submit" class="submit btn btn-primary" >Agregar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- En este div se muestran todos los mensajes con respecto a la creacion y eliminacion dentro de la 
    que el servidor responda -->
<div id = "notificaciones1"></div>

<!-- Seccion usada para mostrar la tabla de los periodos que estan presentes en el sistema -->
<div class="col-lg-12">
    <div class="panel panel-default">
        <div class="panel-heading">
            <label><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Periodos</label>
        </div>
        <div class="panel-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <section class="content">
                            <div class="table-responsive">
                                <table id= "tablePeriodo" border="1" class='table table-bordered table-hover'>
                                    <thead>
                                        <tr>
                                            <th>Cod Periodo</th>
                                            <th>Nombre Periodo</th>   
                                            <th>Actualización</th>  
                                            <th>Eliminar</th>                  
                                        </tr>
                                    </thead>
                                    <tbody id = "cTablaPeriodo">
                                        <!-- Contenido de la tabla generado atravez de la consulta a 
                                            la base de datos -->
                                    </tbody>
                                </table>       
                            </div>
                        </section>
                    </div>                
                </div>
            </div>       
        </div>
    </div>
</div>

<!-- Modal para editar los Periodos -->

<div  class="modal fade" id="compose-modal-modificar" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" id="form_Modificar" name="form_insertar" action="#">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Modificar Periodo</h4>
                </div>
                <div class = "modal-body">
                    <div id= "Mdiv_editarPeriodo">
                        
                    </div>                
                </div>
                <div class="modal-footer">
                    <button  id="guardaredicion" class="btn btn-primary" >Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>






