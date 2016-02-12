<?php
  
$maindir = "";

  // crea el encabezado de la pagina
  require_once($maindir."pages/head.php");

?>

<script language="JavaScript" type="text/javascript">

    function accionAntesDeSalir()
    {
        alert('antesDeSalir');
      $.ajax("funciones/eventoCerrarPestaña.php");
    }
</script>

<script type="text/javascript">
var time;
function inicio() 
{
  time = setTimeout(function() {
    $(document).ready(function(e) {
    document.location.href = "login/logout.php?code=5";
});
  },20000000);//fin timeout
}//fin inicio

function reset() 
{
  clearTimeout(time);//limpia el timeout para resetear el tiempo desde cero
  time = setTimeout(function() {
    $(document).ready(function(e) {
    document.location.href = "login/logout.php?code=5";
});
  },20000000);//fin timeout
  }
  
  window.onbeforeunload = function(event) {
    // do something
    alert('alert()');
    $.ajax("funciones/eventoCerrarPestaña.php");
};

$( window ).unload(function() {
  return "Bye now!";
});

//fin reset
</script>

<!-- Div principal el cual contendra la generacion dinamica de la pag -->
<!-- div_contenido -->
<div id="div_contenido" onUnload = "accionAntesDeSalir()" onkeypress="reset()" onclick="reset()" onMouseMove="reset()">

<?php
  
  if(!isset($_GET['contenido']))
  {
    require_once("home.php");
  }
  else
  {
  	$contenido = $_GET['contenido'];
  }

?>

</div>
<!-- /div_contenido -->

<?php

  // crea el pie de pagina
  require_once($maindir."pages/footer.php");

?>