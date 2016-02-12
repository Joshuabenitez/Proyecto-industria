<?php
  // session_start() ;
  
// <!-- Declaramos la direccion raiz -->
   // $maindir = "../../../";
   // include ($maindir.'conexion/config.inc.php');


    $matrizResumen = $_GET['matrizResumen'];
    $filas = $_GET["i"];
    $elementos = $_GET["j"];

    $columnas = $elementos/($filas);
    $elemento = 0;

    for($i = 1; $i <= $filas; $i++){

      echo "[";
      echo "$matrizResumen[$elemento]";
      $elemento2 = $elemento+1;
      echo "$matrizResumen[$elemento2]";
      $elemento3 = $elemento+2;
      echo "$matrizResumen[$elemento3]";
      $elemento4 = $elemento+4;
      echo "$matrizResumen[$elemento4]";
      echo "]";echo "\\n";


      //ya que tenemos todos los elementos de una fila (codigo, estudiante , dni, tipodesolicitud), se generan los archivos
      if ($elemento3 != 0) {
        ?>

        <script > 
             
                imprimirTodo(<?php echo $elemento3;?>, "treintaiún dias del mes de octubre de dos mil quince."); 
        </script> 
    
    <?php    
    } 

      $elemento = $elemento + $columnas;
     }

?>


<script>
   function imprimirTodo(DNI, cadena){
            submit_post_via_hidden_form(
                'pages/SecretariaAcademica/ConstanciaConducta.php',
                {
                    DNI: DNI,
                    cadena: cadena
                }
            );
            //alert($(this).parents("tr").find("td").eq(2).attr('class'));
        }

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
