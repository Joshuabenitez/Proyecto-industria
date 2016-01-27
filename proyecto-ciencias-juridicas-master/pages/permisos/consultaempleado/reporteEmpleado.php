

<!DOCTYPE html>
<html lang="utf-8">

<head>

    <meta charset="utf-8">

     <script>

            /* 
             * To change this license header, choose License Headers in Project Properties.
             * To change this template file, choose Tools | Templates
             * and open the template in the editor.
             */

            var x;
            x = $(document);
            x.ready(buscarPersona);
            
            function buscarPersona()
            {
                var x;
                x = $("#persona");
                x.click(buscar);
            }

            function buscar()
            {
                data={
                    idpersona:$('#id_persona').val()
                }
                
                $.ajax({
                    async: true,
                    type: "POST",
                    dataType: "html",
                    contentType: "application/x-www-form-urlencoded",
                    beforeSend: function()
               {
                $(".alert").remove();
                var me='<div class="alert alert-info alert-error"><a href="#" class="close" data-dismiss="alert">&times;</a><strong> Informacion   </strong>Enviando .......................</div>';
                $("#proceso").append(me); 
                
               },
                    success:function()
                    {

                  $mensaje="Transaccion Exitosamente..............................................";
                  $(".alert").remove();
                  $me='<div class="alert alert-success" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong>'+$mensaje + '</strong></div>';
                  $("#proceso").append($me);
                  $("#contenedor2").load('Datos/BuscarPersona.php',data);
                    },
                    timeout: 4000,
                    error:function(result)
                {
                   $(".alert").remove();
                  var me='<div class="alert alert-danger" role="alert"> <a href="#" class="close" data-dismiss="alert">&times;</a>  <strong>'+result.status + ' ' + result.statusText+'</strong></div>';
                  $("#proceso").append(me);
                    
                }
                });
                return false;
            }

            

        </script>
       
</head>

<body>

    <div id="proceso"></div>

<div id="contenedor3" class="panel-body">
        <?php
			include "Listaempleados.php";
        ?>
 </div>

<!-- /#wrapper -->

<!-- jQuery -->

<!-- Bootstrap Core JavaScript -->

<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../bower_components/metisMenu/dist/metisMenu.min.js"></script>

<!-- Flot Charts JavaScript -->

<!-- Custom Theme JavaScript -->
<script src="../dist/js/sb-admin-2.js"></script>

<script type="text/javascript"></script>

</body>

</html>


