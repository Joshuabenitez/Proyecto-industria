
<script type="text/javascript">
   /* Script que permite cargar todos los elementos de la tabla para mostrar los datos que estan
    Almacenados en la base de datos */
$(document).ready(function() {

    cargarPermisos(); //Hacemos el llamado para que se cargue la tabla siempre que se cargue la pag.

    /* Este evento se levanta cada vez que le damos click al bottton eliminar */
    $(document).on("click",".eliminarPermiso",function () {
             
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
                    cargarPermisos();
                },
                url: "pages/permisos/TipoDePermisos/eliminarPermiso.php",
                timeout: 4000
            });
        }                 
    });


 /* Este evento se levanta cuando se le da click a el boton de editar */
 
   $(document).on("click",".editarPermiso",function (e){
        e.preventDefault();

        $("#Mdiv_editarPermiso").html("");
        var datos = { 
            
            id:  $(this).data('id') 
        };
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/permisos/TipoDePermisos/actualizarPermisos.php",
            data: datos,
            dataType: "html",
            success: function(data){
                var response = JSON.parse(data);
                var options = '';
       
                for (var index = 0;index < response.length; index++) 
                {
                   options +=   '<div class="form-group">'+
                                    '<label style="display : none">Codigo del periodo</label>'+
                                    '<input style="display : none" id="codPeriodo" disabled = "true" data-id="' + response[index].codPeriodo + '" placeholder="' + response[index].codPeriodo + '" class="form-control">'+
                                '</div>'+
                                '<div class="form-group">'+
                                    '<label>Nombre del Periodo</label>'+
                                    '<input id="nombrePeriodo1" placeholder="'+response[index].nombrePeriodo+'" class="form-control" required>'+
                                '</div>';
                }
             
                $("#Mdiv_editarPermiso").html(options);

                
                $('#compose-modal-modificar').modal('show');
            },
            timeout: 4000
        });
    });

    /* Evento se levanta cuando queremos insertar un nuevo permiso */

    $("#formInsertar").submit(function (e){
        e.preventDefault();

        var datos = {
            nombrePermiso: $("#nombrePermiso").val()
        }
        $.ajax({
            async: true,
            type: "POST",
            url: "pages/permisos/TipoDePermisos/insertarPermiso.php",
            data: datos,
            dataType: "html",
            success: function(data){   
                $("#notificaciones").html(data);
                $("#notificaciones").fadeOut(4500);
                cargarPermisos();
            },
            timeout: 4000
        });

    });

    /* Esta funcion es llamada al principio, es la encargada de actualizar la tabla que muestra
        los periodos que estan en el sistema en ese momento, se recarga cada vez que se elimina o se 
        actualiza */

    function cargarPermisos(){
        var datos = {
            accion: 1
         };

        $.ajax({
            async: true,
            type: "POST",
            url: "pages/permisos/TipoDePermisos/cargarPermisos.php",
            data: datos,
            dataType: "html",
            success: function(data){
                var response = JSON.parse(data);
                var options = '';
                /* Seccion para llenar la tabla */
                for (var index = 0;index < response.length; index++) 
                {
                   options += '<tr>' +
                                    '<td style="display : none">' + response[index].idpermiso + '</td>' +
                                    '<td>' + response[index].tipopermiso + '</td>' +
                                    '<td><center>'+
                                        '<button data-id = "'+ response[index].idpermiso +'" href= "#" class = "editarPermiso btn_editar btn btn-info"  data-toggle="modal" data-target = ""><i class="glyphicon glyphicon-edit"></i></button>'+
                                    '</td></center>' +
                                    '<td><center>'+
                                        '<button data-id = "'+ response[index].idpermiso +'" href= "#" class = "eliminarPermiso   btn_editar btn btn-danger"><i class="glyphicon glyphicon-trash"></i></button>'+
                                    '</td></center>' +             
                              '</tr>';
                }

            
                $("#cTablaPermisos").html(options);

                /* Script que permite a la tabla hacer busquedas dentro de ella
                    y ordenarla deacuerdo a lo que se presenta en ella.*/
                $('#tablePermisos').dataTable(); 
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
                url: "pages/permisos/TipoDePermisos/submitModal.php",
                success: function(data){ 
                    $("#notificaciones1").html(data);
                    $("#notificaciones1").fadeOut(4500);
                    cargarPermisos();
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
                <label><span class="glyphicon glyphicon-globe" aria-hidden="true"></span> Ingreso el tipo de permiso</label>
            </div>
            <div class="panel-body">
                <div>
                       <div id= "noti1" class="alert alert-info" role="alert"><center>Por favor ingrese los datos que acontinuacion se le piden</center></div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <form id = "formInsertar" role="form" action="#" method="POST">
                            <div id="NPeriodo" class="form-group">
                                <label>Tipo de Permiso</label>
                                <input placeholder = "Se necesita el tipo de permiso" type="text"  class="form-control" name="nombrePermiso" id="nombrePermiso" required >
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
            <label><span class="glyphicon glyphicon-list" aria-hidden="true"></span>Tipos de Permisos</label>
        </div>
        <div class="panel-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <section class="content">
                            <div class="table-responsive">
                                <table id= "tablePermisos" border="1" class='table table-bordered table-hover'>
                                    <thead>
                                        <tr>
                                            <th style='display:none'>Cod Permiso</th>
                                            <th>Tipo De Permiso</th>   
                                            <th>Actualización</th>  
                                            <th>Eliminar</th>                  
                                        </tr>
                                    </thead>
                                    <tbody id = "cTablaPermisos">
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
                    <h4 class="modal-title" id="myModalLabel">Modificar Tipo de Permiso</h4>
                </div>
                <div class = "modal-body">
                    <div id= "Mdiv_editarPermiso">
                        
                    </div>                
                </div>
                <div class="modal-footer">
                    <button  id="guardaredicion" class="btn btn-primary" >Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>






