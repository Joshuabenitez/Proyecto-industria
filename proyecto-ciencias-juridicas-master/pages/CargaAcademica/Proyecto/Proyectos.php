<script>
    function validarCampos()
    {
        var nombre=$('#nombre').val();
        var area=$('#areaP').val();
        var vinculacion=$('#areaV').val();        
        if(nombre.length>0 )
        {
            if(area!=='NULL')
            {
                if(vinculacion!=='NULL')
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }   
                    
    }
    
    function llenarComboAreaProyecto()
    { 
        opcion=1;
        var datos=
            {
               opcion:opcion
            };
         $.ajax({
             async:true,
             type:"POST",
             data:datos,
             dataType:"html",
             contentType: "application/x-www-form-urlencoded",                        
            url: "Datos/ObtenerInformacionProyecto.php",
            success: function(response){
                            var arr = JSON.parse(response);                         
                            var options = ' ';
                            var cod='NULL';
                            var nombre='Elija una opción';
                            options += '<option value="' + cod + '">' +
                                            nombre + '</option>';
                            
                            for (var index = 0; index < arr.length; index++) 
                            {
                                
                                
                                var codigoTipoSolicitud = arr[index].codigo;
                                var nombreTipoSolicitud = arr[index].nombre;
                                
                                options += '<option value="' + codigoTipoSolicitud + '">' +
                                            nombreTipoSolicitud + '</option>';
                            }                            
                            $("#areaP").html(options);                             
                        },
                        timeout: 4000,
                        
                    });
                    return false;
    }                                                          
    
    
    function llenarComboAreaVinculacion()
    {        
        opcion=2;
        
         var datos=
                 {
                     opcion:opcion
                 };
         
         $.ajax({
             async:true,
             type:"POST",
             data:datos,
             dataType:"html",
             contentType: "application/x-www-form-urlencoded",                        
            url: "Datos/ObtenerInformacionProyecto.php",
            
            success: function(response){
                var arr = JSON.parse(response);                            
                            options = '';
                            var cod='NULL';
                            var nombre='Elija una opción';
                            options += '<option value="' + cod + '">' +
                                            nombre + '</option>';
                            
                            for (var index = 0; index < arr.length; index++) 
                            {
                                
                                
                                var codigoTipoSolicitud = arr[index].codigo;
                                var nombreTipoSolicitud = arr[index].nombre;
                                
                                options += '<option value="' + codigoTipoSolicitud + '">' +
                                            nombreTipoSolicitud + '</option>';
                            }                            
                            $("#areaV").html(options);                                                                                    
                        },            
                
                        timeout: 4000,                        
                    });
                    
                    return false;
                    
    }
    
    $(document).ready(function(){           
        llenarComboAreaVinculacion();
        llenarComboAreaProyecto();
    });
    


            $("#cancelar").click(function(event) {
              event.preventDefault();
                  $('#nombre').val(' ');     
            });
            
            
            
            
            
            $("#guardar").click(function(event) {
              event.preventDefault();                  
                if(validarCampos()===true)
                {
                    cod_area =$("#areaP").val();
                cod_vinculacion=$("#areaV").val();
                nombre=$("#nombre").val();

                          
                           datos = {
                            cod_area: cod_area,
                            cod_vinculacion:cod_vinculacion,
                            nombre:nombre
                        };
                                            
                        
                        $.ajax({
                            async: true,
                            type: "POST",
                            dataType: "html",
                            contentType: "application/x-www-form-urlencoded",
                            url: "Datos/GuardarProyecto.php",
                            beforeSend: inicioEnvio,
                            success: llegadaGuardar,
                            
                            
                            timeout: 4000,                                        //error: problemas
                        });
                }
                else
                {
                    alert('NO has ingresado los datos correctmente');
                }
                
                                                
                        return false;
            });
            
            function llegadaGuardar()
            {
                $("#contenedor2").load('Datos/GuardarProyecto.php',datos);
                $('#nombre').val(' ');
                            llenarComboAreaVinculacion();
                            llenarComboAreaProyecto();
            }
             function inicioEnvio()
            {
                var x = $("#contenedor2");
                x.html('Cargando...');
            }

</script>

<html lang="es">
    <head>
        <title>Proyecto</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width-device-width, initial-scale=1">                 
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" >        
    </head>
    <body>
        <div id="contenedor2">            
        </div>
        
            <div class="panel panel-primary">
                <div class="panel-heading panel-success"><h2>Proyectos</h2></div>
                
                <div class="panel-body">                     
                    <form class="form-horizontal">
                        <div class="form-group row">
                            <label class="control-label col-sm-2"style="text-align: left ">Nombre</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="nombre" name="nombre" required="">
                            </div>
                        </div>
                        
                        <div class="form-group row">                            
                            <label class="control-label col-sm-2" style="text-align: left ">Area del proyecto</label>
                            <div class="col-sm-10">
                                <select id="areaP" name="areaP" class="form-control">                                    
                                </select>
                            </div>                                                        
                        </div>
                        
                        <div class="form-group row">                            
                            <label class="control-label col-sm-2" style="text-align: left ">Area de vinculación</label>
                            <div class="col-sm-10 ">
                                <select id="areaV" name="areaV" class="form-control">                                    
                                </select>
                            </div>                                                        
                        </div>                                                                       
                        <button class="btn btn-primary" style="margin-left: 490px" id="guardar" name="guardar"><span class=" glyphicon glyphicon-floppy-disk"></span>Guardar</button>
                        <button class="btn btn-primary" id="cancelar" name="cancelar"><span class=" glyphicon glyphicon-ban-circle"></span>Cancelar</button>
                        
                    </form>                    
                    
                </div>
            </div>                    
    </body>
</html>
