
<script type="text/javascript">
   /* Script que permite cargar todos los elementos de la tabla para mostrar los datos que estan
    Almacenados en la base de datos */
$(document).ready(function() {

    cargarTiposDeEstudiantes(); //Hacemos el llamado para que se cargue la tabla siempre que se cargue la pag.

    /* Este evento se levanta cada vez que le damos click al bottton eliminar */
    $(document).on("click",".eliminaTipoDeEstudiante",function () {
             
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
                    $("#notificaciones1").fadeOut(1500);
                    cargarTiposDeEstudiantes();
                },
                url: "pages/SecretariaAcademica/Mantenimiento/TiposDeEstudiantes/eliminarTipoDeEstudiante.php",
                timeout: 4000
            });
        }                 
    });


 /* Este evento se levanta cuando se le da click a el boton de editar */
   $(document).on("click",".editarTipoDeEstudiante",function (e){
        e.preventDefault();
        $("#Mdiv_editarTipoDeEstudiante").html("");
        var datos = { 
            
            id:  $(this).data('id') 
        };
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Mantenimiento/TiposDeEstudiantes/actualizarTipoDeEstudiante.php",
            data: datos,
            dataType: "html",
            success: function(data){
                var response = JSON.parse(data);
                var options = '';
                /* En esta seccion llenamos los datos que se van a editar el modal*/ 
                for (var index = 0;index < response.length; index++) 
                {
                   options +=   '<div class="form-group">'+
                                    '<label>Código del tipo de estudiante</label>'+
                                    '<input id="codEstudiante" disabled = "true" data-id="' + response[index].codEstudiante + '" placeholder="' + response[index].codEstudiante + '" class="form-control">'+
                                '</div>'+
                                '<div class="form-group">'+
                                    '<label>Nombre del tipo de estudiante</label>'+
                                    '<input id="nombreTipoDeEstudiante1" placeholder="'+response[index].TipoDeEstudiante+'" class="form-control">'+
                                '</div>';
                }
                /* Insertamos dentro del div del modal los datos obtenidos en la base de datos */
                $("#Mdiv_editarTipoDeEstudiante").html(options);

                /* Cuando ya tenemos listo el modal con los datos que queriamos abrimos el modal */
                $('#compose-modal-modificar').modal('show');
            },
            timeout: 4000
        });

    });

    /* Evento se levanta cuando queremos insertar un nuevo tipo de estudiante */

    $("#formInsertar").submit(function (e){
        e.preventDefault();
        var datos = {
            TipoDeEstudiante: $("#TipoDeEstudiante").val()
        }
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Mantenimiento/TiposDeEstudiantes/insertarTipoDeEstudiante.php",
            data: datos,
            dataType: "html",
            success: function(data){   
                $("#notificaciones").html(data);
                $("#notificaciones").fadeOut(3500);
                cargarTiposDeEstudiantes();
            },
            timeout: 4000
        });

    });

    
    /* Esta funcion es llamada al principio, es la encargada de actualizar la tabla que muestra
        los tipos de estudiantes que estan en el sistema en ese momento, se recarga cada vez que se elimina o se 
        actualiza */
    function cargarTiposDeEstudiantes(){
        var datos = {
            accion: 1
         };

        $.ajax({
            async: true,
            type: "POST",
            url: "pages/SecretariaAcademica/Mantenimiento/TiposDeEstudiantes/cargarTipoDeEstudiante.php",
            data: datos,
            dataType: "html",
            success: function(data){
                var response = JSON.parse(data);
                var options = '';
                /* Seccion para llenar la tabla */
                for (var index = 0;index < response.length; index++) 
                {
                   options += '<tr>' +
                                    '<td>' + response[index].codEstudiante + '</td>' +
                                    '<td>' + response[index].TipoDeEstudiante + '</td>' +
                                    '<td><center>'+
                                        '<button data-id = "'+ response[index].codEstudiante +'" href= "#" class = "editarTipoDeEstudiante btn_editar btn btn-info"  data-toggle="modal" data-target = ""><i class="glyphicon glyphicon-edit"></i></button>'+
                                    '</td></center>' +
                                    '<td><center>'+
                                        '<button data-id = "'+ response[index].codEstudiante +'" href= "#" class = "eliminaTipoDeEstudiante btn_editar btn btn-danger"><i class="glyphicon glyphicon-trash"></i></button>'+
                                    '</td></center>' +             
                              '</tr>';
                }

            
                $("#cTablaTipoDeEstudiantes").html(options);

                /* Script que permite a la tabla hacer busquedas dentro de ella
                    y ordenarla deacuerdo a lo que se presenta en ella.*/
                $('#tableTipoDeEstudiantes').dataTable({
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
    modificar ya se hizo */

    $("#form_Modificar").submit(function(e) {
            e.preventDefault();
            $("#compose-modal-modificar").modal('hide');
            datosEditados = {
                codigo: $("#codEstudiante").data('id'),
                nombre: $("#nombreTipoDeEstudiante1").val()
            };
            $.ajax({
                async: true,
                type: "POST",
                dataType: "html",
                data: datosEditados,
                contentType: "application/x-www-form-urlencoded",
                url: "pages/SecretariaAcademica/Mantenimiento/TiposDeEstudiantes/submitModal.php",
                success: function(data){ 
                    $("#notificaciones1").html(data);
                    $("#notificaciones1").fadeOut(4500000);
                    cargarTiposDeEstudiantes();
                },
                timeout: 4000
            });
        });
});

</script>


<!-- Div para cargar informacion recibida por el servidor -->
<div id = "notificaciones"></div>

<!-- Seccion para que el usuario indique el nuevo tipo de estudiante que quiere ingresar -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <label><span class="glyphicon glyphicon-globe" aria-hidden="true"></span> Ingreso de datos de nivel educativo</label>
            </div>
            <div class="panel-body">
                <div>
                       <div id= "noti1" class="alert alert-info" role="alert"><center>Por favor ingrese los datos que a continuación se le piden.</center></div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <form id = "formInsertar" role="form" action="#" method="POST">
                            <div id="Nciudad" class="form-group">
                                <label>Descripción Nivel Educativo</label>
                                <input placeholder = "Se necesita un nombre" type="text"  class="form-control" name="TipoDeEstudiante" id="TipoDeEstudiante" required >
                                <p class="help-block">Ejemplo: Pregrado, Posgrado</p>
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

<!-- Seccion usada para mostrar la tabla de los tipos de estudiante que están presentes en el sistema -->
<div class="col-lg-12">
    <div class="panel panel-default">
        <div class="panel-heading">
            <label><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Niveles Educativos </label>
        </div>
        <div class="panel-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <section class="content">
                            <div class="table-responsive">
                                <table id= "tableTipoDeEstudiantes" border="1" class='table table-bordered table-hover'>
                                    <thead>
                                        <tr>Codigo Nivel Educativo</th>
                                            <th>Descripción Nivel Educativo</th>   
                                            <th>Actualización</th>  
                                            <th>Eliminar</th>                  
                                        </tr>
                                    </thead>
                                    <tbody id = "cTablaTipoDeEstudiantes">
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

<!-- Modal para editar las ciudades -->

<div  class="modal fade" id="compose-modal-modificar" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" id="form_Modificar" name="form_insertar" action="#">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Modificar Nivel Educativo</h4>
                </div>
                <div class = "modal-body">
                    <div id= "Mdiv_editarTipoDeEstudiante">
                        
                    </div>                
                </div>
                <div class="modal-footer">
                    <button  id="guardaredicion" class="btn btn-primary" >Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>






