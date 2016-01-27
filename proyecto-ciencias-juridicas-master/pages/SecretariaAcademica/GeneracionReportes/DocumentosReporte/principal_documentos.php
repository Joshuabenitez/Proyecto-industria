<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$mkdir = "../../../../";
include($mkdir."conexion/config.inc.php");

$statement = $db->prepare('CALL SP_OBTENER_SOLICITUDES_REPORTES(@pcMensajeError)');
$statement->execute();

$contadorFilas = $statement->rowCount();

if($contadorFilas >= 1){
    $tabla = $statement->fetchAll(PDO::FETCH_ASSOC);
}

$statement->nextRowSet();
$statement->closeCursor();

$fechaExpedicion = "No definida.";

?>

<div class="panel panel-primary">
    <div class="panel-heading">
        <label><span class="glyphicon glyphicon-file" aria-hidden="true"></span> Generar Constancias </label>
    </div>
    <div class="panel-body ">
<!--        <div class="page-header">
            <h3>Filtros</h3>
        </div>
        <label  class="checkbox-inline">
            <input  class="toggle-vis" data-column="0" type="checkbox" id="checkboxEnLinea1" value="opcion_1"> Codigo
        </label>
        <label class="checkbox-inline">
            <input class="toggle-vis" data-column="1" type="checkbox" type="checkbox" id="checkboxEnLinea2" value="opcion_2"> Estudiante
        </label>
        <label class="checkbox-inline">
            <input class="toggle-vis" data-column="2" type="checkbox"type="checkbox" id="checkboxEnLinea3" value="opcion_3"> Observaciones
        </label>

        <label class="checkbox-inline">
            <input class="toggle-vis" data-column="3" type="checkbox" type="checkbox" id="checkboxEnLinea3" value="opcion_3"> Estado
        </label>

        <label class="checkbox-inline">
            <input class="toggle-vis" data-column="4" type="checkbox" type="checkbox" id="checkboxEnLinea3" value="opcion_3"> DNI
        </label>

        <label class="checkbox-inline">
            <input class="toggle-vis" data-column="5" type="checkbox"type="checkbox" id="checkboxEnLinea3" value="opcion_3"> Tipo Solicitud
        </label>
        <label class="checkbox-inline">
            <input class="toggle-vis" data-column="6" type="checkbox" type="checkbox" id="checkboxEnLinea3" value="opcion_3" > Himno
        </label>-->
        <div class="col-md-12 well">
            <div class="table-responsive">
                <table id="lista_solicitudes" class="table table-striped table-bordered table-hover">
                    <thead class="well">
                        <tr>
                            <th>Cod</th>
                            <th>Estudiante</th>
                            <th>DNI</th>
                            <th>Fecha</th>
                            <th>Fecha Exp</th>
                            <th>Tipo Solicitud</th>
                            <th style="width: 40px">Exportar</th>
                            <th style="width: 40px">Supr.</th>
                        </tr>
                    <!--<a class="fa fa-file-pdf-o"></a>-->
                    </thead>
                    <tbody id="tablaBody">
                        <?php
                        foreach ($tabla as $fila){
                            echo '<tr>'.
                                    '<td id="'.$fila['CODIGO'].'">'.$fila['CODIGO'].'</td>'.
                                    '<td>'.$fila['NOMBRE'].'</td>'.
                                    '<td class="'.$fila['DNI'].'">'.$fila['DNI'].'</td>'.
                                    '<td>'.$fila['FECHA'].'</td>'.
                                    '<td>'.$fila['FECHAEXP'].'</td>'.
                                    '<td>'.$fila['TIPOSOLICITUD'].'</td>'.
                                    '<td class="'.$fila['TIPOSOLICITUD'].'"><center><a title="'.$fila['TIPOSOLICITUD'].'" class="'.$fila['TIPOSOLICITUD'].' btn btn-success fa fa-file-pdf-o"></a></center></td>'.
                                    '<td><center><button class="btn btn-danger btnSuprimir"><span class="glyphicon glyphicon-remove-circle"></span></button></center></td>'.
                                    '</tr>';
                        }
                        ?>
                    </tbody>
                </table>
            </div>
            <button style="width: 200px; margin-top: 10px;" class="btn btn-primary pull-right" id="btnExportarTodos">Exportar Todas</button>
        </div>
    </div>
    
    <div class="modal fade" id="modalHimno" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- Botón para cerrar la ventana -->
                    <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                            <span class="sr-only">Close</span>
                    </button>
                    <!-- Título de la ventana -->
                    <h3 class="title">Constancia de Himno</h3>
                </div>
                <div class="modal-body" style="padding-left: 45px">
                    <div role="form" class="form-group form-horizontal">
                        <div class="row">
                            <label class="label label-default">Fecha en la que se emite la constancia:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaPalabrasHimno" type="date">

<!--                        <div class="row">
                            <label class="label label-default">Recibio sanci&oacute;n:</label>
                        </div>
                        
                        <div class="input-group">
                            <div>
                                <label class="radio-primary">
                                    <input type="radio" name="opciones" id="opciones_1" value="false" checked>
                                    No recibio sanci&oacute;n.
                                </label>                                
                            </div>
                            <div>
                                <label class="radio-primary">
                                    <input type="radio" name="opciones" id="opciones_2" value="true">
                                    S&iacute; recibio sanci&oacute;n.
                                </label> 
                            </div>
                        </div>-->
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnAceptarHimno" class="btn btn-success">Aceptar</button>
                </div>
            </div>
        </div>
    </div>    
    
    <div class="modal fade" id="modalConducta" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- Botón para cerrar la ventana -->
                    <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                            <span class="sr-only">Close</span>
                    </button>
                    <!-- Título de la ventana -->
                    <h3 class="title">Constancia de Conducta</h3>
                </div>
                <div class="modal-body" style="padding-left: 45px">
                    <div role="form" class="form-group form-horizontal">
                        <div class="row">
                            <label class="label label-default">Fecha en la que se emite la constancia:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaPalabrasConducta" type="date">
                        <div class="row">
                            <label class="label label-default">Fecha de culminacion de estudios en derecho:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaEgresadoConduta" type="date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnAceptarConducta" class="btn btn-success">Aceptar</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="modalPPS" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- Botón para cerrar la ventana -->
                    <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                            <span class="sr-only">Close</span>
                    </button>
                    <!-- Título de la ventana -->
                    <h3 class="title">Certificaci&oacute;n de Practica Profesional</h3>
                </div>
                <div class="modal-body" style="padding-left: 45px">
                    <div role="form" class="form-group form-horizontal">
                        <div class="row">
                            <label class="label label-default">Fecha en la que se emite la certificaci&oacute;n:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaPalabrasPPS" type="date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnAceptarPPS" class="btn btn-success">Aceptar</button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="modalConstancia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- Botón para cerrar la ventana -->
                    <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                            <span class="sr-only">Close</span>
                    </button>
                    <!-- Título de la ventana -->
                    <h3 class="title">Constancia</h3>
                </div>
                <div class="modal-body" style="padding-left: 45px">
                    <div role="form" class="form-group form-horizontal">
                        <div class="row">
                            <label class="label label-default">Fecha en la que se emite la constancia:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaPalabrasConstancia" type="date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnAceptarConstancia" class="btn btn-success">Aceptar</button>
                </div>
            </div>
        </div>
    </div> 
    
    <div class="modal fade" id="modalEgresado" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- Botón para cerrar la ventana -->
                    <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                            <span class="sr-only">Close</span>
                    </button>
                    <!-- Título de la ventana -->
                    <h3 class="title">Constancia de Egresado</h3>
                </div>
                <div class="modal-body" style="padding-left: 45px">
                    <div role="form" class="form-group form-horizontal">
                        <div class="row">
                            <label class="label label-default">Fecha en la que se emite la constancia:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaPalabrasEgresado" type="date">
                        <div class="row">
                            <label class="label label-default">Fecha de culminacion de estudios en derecho:</label>
                        </div>
                        <input style="margin-bottom: 10px; margin-top: 10px; width: 200px" class="form-control" id="txtFechaEgresado" type="date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnAceptarEgresado" class="btn btn-success">Aceptar</button>
                </div>
            </div>
        </div>
    </div>   
</div>

<script>
    $(document).ready(function(){
        var table = $("#lista_solicitudes").DataTable({
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
        var DNI;
        var matrizConducta = [];
        var matrizPPS = [];
        var matrizHimno = []; //al parecer solo se enviaran los dni
        var matrizEgresado = [];
        var matrizConstancia = [];
        var row;
        var codTipo = [];
        var codsConducta = [];
        var codsPPS = [];
        var codsHimno = [];
        var codsEgresado = [];
        var codsConstancia = [];
        
        var dias = "un,dos,tres,cuatro,cinco,seis,siete,ocho,nueve,diez,once,doce,trece,catorce,quince,dieciséis,diecisiete,dieciocho,diecinueve,veinte,veintiún,veintidós,veintitrés,veinticuatro,veinticinco,veintiséis,veintisiete,veintiocho,veintinueve,treinta,treinta y un";
        var años = "uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve,diez,once,doce,trece,catorce,quince,dieciséis,diecisiete,dieciocho,diecinueve,veinte,veintiuno,veintidós,veintitrés,veinticuatro,veinticinco,veintiséis,veintisiete,veintiocho,veintinueve,treinta,treinta y uno,treinta y dos,treinta y tres,\n\
                    treinta y cuatro,treinta y cinco,treinta y seis,treinta y siete,treinta y ocho,treinta y nueve,cuarenta,cuarenta y uno,cuarenta y dos,cuarenta y tres,cuarenta y cuatro,cuarenta y cinco,cuarenta y seis,cuarenta y siete,cuarenta y ocho,cuarenta y nueve,cincuenta,cincuenta y uno,cincuenta y dos,cincuenta y tres,cincuenta y cuatro,cincuenta y cinco,cincuenta y seis,cincuenta y siete,cincuenta y ocho,cincuenta y nueve,sesenta";
        var dia = dias.split(",");
        var año = años.split(",");
        var mes = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
        
        $(".Constancia.de.Ultimo.Año").click(function(){
            DNI = $(this).parents("tr").find("td").eq(2).attr('class');
            row = $(this).closest('tr').find('td').eq(4);
            matrizConstancia[0] = DNI;
            codsConstancia[0] = $(this).parents("tr").find("td").eq(0).attr('id');
            $("#modalConstancia").modal("show");
            row = $(this).closest('tr').find('td').eq(4);
            $("#txtFechaPalabrasConstancia").val(null);
        });
        
        $(".btnSuprimir").click(function(){
            var here = this;
            $(this).closest('tr').find('td').fadeOut('200', 
                function(here){
                    table.row($(this).parents('tr')).remove().draw();
                    //$(here).parents('tr:first').remove().draw();                    
                });  
        });
        
        $("#btnAceptarConstancia").click(function(){
            if(!$.trim($("#txtFechaPalabrasConstancia").val())){
                alert("Introduzca la fecha en la que se emitie la constancia");
            }
            else{
                var cadena = $("#txtFechaPalabrasConstancia").val();
                var parts = cadena.match(/(\d+)/g);
                var date = new Date(parts[0], parts[1]-1, parts[2]);
                var aniospart = date.getFullYear().toString().split("");
                var dosUltimos = aniospart[2]+""+aniospart[3];
                
                cadena = dia[date.getDate()-1]+" días del mes de "+mes[date.getMonth()]+" de Dos Mil "+año[dosUltimos - 1].toString().charAt(0).toUpperCase()+año[dosUltimos - 1].slice(1)+".";
                
                var arregloConstancia = matrizConstancia.toString();
                var arregloCodsConstancia = codsConstancia.toString();
                
                if(row != null){
                    row.html($("#txtFechaPalabrasConstancia").val());
                }
                
                if(codTipo.length >= 1){
                    for(var i = 0; i < codTipo.length; i++){
                        if(codTipo[i][1] === "Constancia de Ultimo Año"){
                            codTipo[i][2].find('td').eq(4).html($("#txtFechaPalabrasConstancia").val());
                        }
                    }
                }
                
                submit_post_via_hidden_form(
                    'pages/SecretariaAcademica/Constancia.php',
                    {
                        arregloConstancia: arregloConstancia,
                        cadena: cadena,
                        arregloCodsConstancia: arregloCodsConstancia,
                        fechaExp: $("#txtFechaPalabrasConstancia").val()
                    }
                );
                $("#modalConstancia").modal("hide");
            }
        });
        
        $(".Constancia.de.Egresado").click(function(){
            DNI = $(this).parents("tr").find("td").eq(2).attr('class');
            matrizEgresado[0] = DNI;
            codsEgresado[0] = $(this).parents("tr").find("td").eq(0).attr('id');
            $("#modalEgresado").modal("show");
            row = $(this).closest('tr').find('td').eq(4);
            $("#txtFechaPalabrasEgresado").val(null);
        });
        
        $("#btnAceptarEgresado").click(function(){
            if(!$.trim($("#txtFechaPalabrasEgresado").val()) && !$.trim($("#txtFechaEgresado").val())){
                alert("Introduzca la fecha en la que se emitie la constancia y la fecha de egreso.")
            }
            else{
                var cadena = $("#txtFechaPalabrasEgresado").val();
                var parts = cadena.match(/(\d+)/g);
                var fechaEgresadoConstancia = $("#txtFechaEgresado").val();
                var fechapartsEgresado = fechaEgresadoConstancia.match(/(\d+)/g);
                var date = new Date(parts[0], parts[1]-1, parts[2]);
                var aniospart = date.getFullYear().toString().split("");
                var dosUltimos = aniospart[2]+""+aniospart[3];
                
                cadena = dia[date.getDate()-1]+" días del mes de "+mes[date.getMonth()]+" de Dos Mil "+año[dosUltimos - 1].toString().charAt(0).toUpperCase()+año[dosUltimos - 1].slice(1)+".";
              
                if(row != null){
                    row.html($("#txtFechaPalabrasEgresado").val());
                }
                
                if(codTipo.length >= 1){
                    for(var i = 0; i < codTipo.length; i++){
                        if(codTipo[i][1] === "Constancia de Egresado"){
                            codTipo[i][2].find('td').eq(4).html($("#txtFechaPalabrasEgresado").val());
                        }
                    }
                }
                
                var arregloEgresado = matrizEgresado.toString();
                var arregloCodsEgresados = codsEgresado.toString();
                submit_post_via_hidden_form(
                    'pages/SecretariaAcademica/ConstanciaEgresado.php',
                    {
                        arregloEgresado: arregloEgresado,
                        cadena: cadena,
                        arregloCodsEgresados: arregloCodsEgresados,
                        fechaExp: $("#txtFechaPalabrasEgresado").val(),
                        fechaEgresadoConstancia: fechapartsEgresado[0]
                    }
                );
                $("#modalEgresado").modal("hide");
            }
        });
          
        $(".Certificación.para.PPS").click(function(){
            DNI = $(this).parents("tr").find("td").eq(2).attr('class');
            matrizPPS[0] = DNI;
            codsPPS[0] = $(this).parents("tr").find("td").eq(0).attr('id');
            $("#modalPPS").modal("show");
            row = $(this).closest('tr').find('td').eq(4);
            $("#txtFechaPalabrasPPS").val(null);
        });
        
        $("#btnAceptarPPS").click(function(){
            if(!$.trim($("#txtFechaPalabrasPPS").val())){
                alert("Introduzca la fecha en la que se emitie la certificación");
            }
            else{
                var cadena = $("#txtFechaPalabrasPPS").val();
                var parts = cadena.match(/(\d+)/g);
                var date = new Date(parts[0], parts[1]-1, parts[2]);
                var aniospart = date.getFullYear().toString().split("");
                var dosUltimos = aniospart[2]+""+aniospart[3];
                
                cadena = dia[date.getDate()-1]+" días del mes de "+mes[date.getMonth()]+" de Dos Mil "+año[dosUltimos - 1].toString().charAt(0).toUpperCase()+año[dosUltimos - 1].slice(1);
             
                var arregloPPS = matrizPPS.toString();
                var arregloCodsPPS = codsPPS.toString();
                if(row != null){
                    row.html($("#txtFechaPalabrasPPS").val());
                }
                
                if(codTipo.length >= 1){
                    for(var i = 0; i < codTipo.length; i++){
                        if(codTipo[i][1] === "Certificación para PPS"){
                            codTipo[i][2].find('td').eq(4).html($("#txtFechaPalabrasPPS").val());
                        }
                    }
                }
                
                submit_post_via_hidden_form('pages/SecretariaAcademica/ConstanciaPPS.php',
                    {
                        arregloPPS: arregloPPS,
                        cadena: cadena,
                        arregloCodsPPS: arregloCodsPPS,
                        fechaExp: $("#txtFechaPalabrasPPS").val()
                    }
                );
                $("#modalPPS").modal("hide");
            }
        });
        
        $(".Constancia.de.Conducta").click(function(){
            DNI = $(this).parents("tr").find("td").eq(2).attr('class');
            matrizConducta[0] = DNI;
            codsConducta[0] = $(this).parents("tr").find("td").eq(0).attr('id');
            $("#modalConducta").modal("show");
            row = $(this).closest('tr').find('td').eq(4);
            $("#txtFechaPalabrasConducta").val(null);
        });
        
        $("#btnAceptarConducta").click(function(){
            if(!$.trim($("#txtFechaPalabrasConducta").val()) && !$.trim($("#txtFechaEgresadoConduta").val())){
                alert("Introduzca la fecha en la que se emitie la constancia y la de fecha de egreso.");
            }
            else{
                
                var cadena = $("#txtFechaPalabrasConducta").val();
                var fechaEgresado = $("#txtFechaEgresadoConduta").val();
                var fechaparts = fechaEgresado.match(/(\d+)/g);
                var parts = cadena.match(/(\d+)/g);
                var date = new Date(parts[0], parts[1]-1, parts[2]);
                var aniospart = date.getFullYear().toString().split("");
                var dosUltimos = aniospart[2]+""+aniospart[3];
                
                cadena = dia[date.getDate()-1]+" días del mes de "+mes[date.getMonth()]+" de Dos Mil "+año[dosUltimos - 1].toString().charAt(0).toUpperCase()+año[dosUltimos - 1].slice(1)+".";
             
                var arregloConducta = matrizConducta.toString();
                var arregloCodsConducta = codsConducta.toString();
                
                if(row != null){
                    row.html($("#txtFechaPalabrasConducta").val());
                }
                
                if(codTipo.length >= 1){
                    for(var i = 0; i < codTipo.length; i++){
                        if(codTipo[i][1] === "Constancia de Conducta"){
                            codTipo[i][2].find('td').eq(4).html($("#txtFechaPalabrasConducta").val());
                        }
                    }
                }
                
                submit_post_via_hidden_form(
                    'pages/SecretariaAcademica/ConstanciaConducta.php',
                    {
                        arregloConducta: arregloConducta,
                        cadena: cadena,
                        arregloCodsConducta: arregloCodsConducta,
                        fechaExp: $("#txtFechaPalabrasConducta").val(),
                        fechaEgresado: fechaparts[0] 
                    }
                );                
                $("#modalConducta").modal("hide");
            }
        });
                
        $(".Constancia.de.Himno").click(function(){
            DNI = $(this).parents("tr").find("td").eq(2).attr('class');
            matrizHimno[0] = DNI;
            codsHimno[0] = $(this).parents("tr").find("td").eq(0).attr('id');
            row = $(this).closest('tr').find('td').eq(4);
            $("#modalHimno").modal("show");
            row = $(this).closest('tr').find('td').eq(4);
            $("#txtFechaPalabrasHimno").val(null);
        });
        
        $("#btnAceptarHimno").click(function(){
            if(!$.trim($("#txtFechaPalabrasHimno").val())){
                alert("Introduzca la fecha en la que se emitie la constancia");
            }
            else{
                var cadena = $("#txtFechaPalabrasHimno").val();
                var parts = cadena.match(/(\d+)/g);
                var date = new Date(parts[0], parts[1]-1, parts[2]);
                var aniospart = date.getFullYear().toString().split("");
                var dosUltimos = aniospart[2]+""+aniospart[3];
                
                cadena = dia[date.getDate()-1]+" días del mes de "+mes[date.getMonth()]+" de Dos Mil "+año[dosUltimos - 1].toString().charAt(0).toUpperCase()+año[dosUltimos - 1].slice(1)+".";
             
                var arregloHimno = matrizHimno.toString();
                var arregloCodsHimno = codsHimno.toString();
                if(row != null){
                    row.html($("#txtFechaPalabrasHimno").val());
                }
                
                if(codTipo.length >= 1){
                    for(var i = 0; i < codTipo.length; i++){
                        if(codTipo[i][1] === "Constancia de Himno"){
                            codTipo[i][2].find('td').eq(4).html($("#txtFechaPalabrasHimno").val());
                        }
                    }
                }
                
                submit_post_via_hidden_form(
                    'pages/SecretariaAcademica/ConstanciaHimno.php',
                    {
                        arregloHimno: arregloHimno,
                        cadena: cadena,
                        arregloCodsHimno: arregloCodsHimno,
                        fechaExp: $("#txtFechaPalabrasHimno").val()
                    }
                );                
                $("#modalHimno").modal("hide");
            }
        });
        
        $("#btnExportarTodos").click(function(){
            var matrizSolicitudes = [];
            
            var i = 0;
            var ini = false;
            var contHimno = 0;
            var contPPS = 0;
            var contConducta = 0;
            var contEgresado = 0;
            var contConstancia = 0;
            
//            var matrizConducta = [];
//            var matrizPPS = [];
//            var matrizHimno = []; //al parecer solo se enviaran los dni
//            var matrizEgresado = [];
            
            $("#lista_solicitudes tr").each(function(){
                if(ini){
                    matrizSolicitudes[i] = [$(this).find("td").eq(2).attr('class'), $(this).find("td").eq(6).attr('class'), $(this).find("td").eq(0).attr("id")];
                    codTipo[i] = [$(this).find("td").eq(0).attr('id'), $(this).find("td").eq(6).attr('class'), $(this)];
                    //alert(codTipo[i][2]);
                    i++;
                }
                else{
                    ini = true;
                }
            });
            
            for(var i = 0; i < matrizSolicitudes.length; i++){
                //alert(matrizSolicitudes[i][1]);
                
                if(matrizSolicitudes[i][1] === "Constancia de Himno"){
                    matrizHimno[contHimno] = matrizSolicitudes[i][0];
                    codsHimno[contHimno] = matrizSolicitudes[i][2];
                    //alert(codsHimno[0]);
                    contHimno++;
                }
                
                if(matrizSolicitudes[i][1] === "Certificación para PPS"){
                    codsPPS[contPPS] = matrizSolicitudes[i][2];
                    matrizPPS[contPPS] = [matrizSolicitudes[i][0]];
                    contPPS++;
                }
                
                if(matrizSolicitudes[i][1] === "Constancia de Conducta"){
                    matrizConducta[contConducta] = matrizSolicitudes[i][0];
                    codsConducta[contConducta] = matrizSolicitudes[i][2];
                    contConducta++;
                }
                
                if(matrizSolicitudes[i][1] === "Constancia de Egresado"){
                    matrizEgresado[contEgresado] = matrizSolicitudes[i][0];
                    codsEgresado[contEgresado] = matrizSolicitudes[i][2];
                    contEgresado++;
                }
                
                if(matrizSolicitudes[i][1] === "Constancia de Ultimo Año"){
                    matrizConstancia[contConstancia] = matrizSolicitudes[i][0];
                    codsConstancia[contConstancia] = matrizSolicitudes[i][2];
                    contConstancia++;
                }
            }
            
            if(matrizConstancia.length >= 1){
                $("#modalConstancia").modal("show");
                $("#txtFechaPalabrasConstancia").val(null);
            }
            
            if(matrizHimno.length >= 1){
                $("#modalHimno").modal("show");
                $("#txtFechaPalabrasHimno").val(null);
            }
            
            if(matrizConducta.length >= 1){
                $("#modalConducta").modal("show");
                $("#txtFechaPalabrasConducta").val(null);
            }
            
            if(matrizPPS.length >= 1){
                $("#modalPPS").modal("show");
                $("#txtFechaPalabrasConducta").val(null);
            }
            
            if(matrizEgresado.length >= 1){
                $("#modalEgresado").modal("show");
                $("#txtFechaPalabrasEgresado").val(null);
            }
        });
        
        //PROVISIONAL los eventos click siguientes
        $("#btnExportarDocumentos1").click(function(){
            window.open('pages/SecretariaAcademica/ConstanciaConducta.php');
        });

        $("#btnExportarDocumentos2").click(function(){
            window.open('pages/SecretariaAcademica/ConstanciaHimno.php');

            //window.open('pages/SecretariaAcademica/GeneracionReportes/DocumentosReporte/LeerRTFs.php');
        });

        $("#btnExportarDocumentos3").click(function(){
            window.open('pages/SecretariaAcademica/ConstanciaEgresado.php');
            //window.open('pages/SecretariaAcademica/GeneracionReportes/DocumentosReporte/LeerRTFs.php');
        });    

        $("#btnExportarDocumentos4").click(function(){
            window.open('pages/SecretariaAcademica/ConstanciaPPS.php');
            //window.open('pages/SecretariaAcademica/GeneracionReportes/DocumentosReporte/LeerRTFs.php');
        });
    });
    
                        
    function submit_post_via_hidden_form(url, params) {
        var f = $("<form target='_blank' method='POST' style='display:none;'></form>").attr({
            action: url
        }).appendTo(document.body);

        for (var i in params) {
            if (params.hasOwnProperty(i)) {
                $('<input type="hidden" />').attr({
                    name: i,
                    value: params[i]
                }).appendTo(f);
            }
        }

        f.submit();

        f.remove();
    }
</script>