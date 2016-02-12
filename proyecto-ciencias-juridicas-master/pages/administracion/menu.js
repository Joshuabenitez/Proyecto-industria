
  $(document).ready(function(){

    $("#usuarios").click(function(event) {
      event.preventDefault();
      // alert("has presionado estadisticas");

      $("#div_contenido" ).load( "pages/administracion/admin.php" );
      });
    $("#historial_ingreso").click(function(event) {
      event.preventDefault();
      // alert("has presionado estadisticas");

      $("#page-wrapper" ).load( "pages/administracion/panel_Grafos/historial_ingreso.php" );
      });
    $("#usuarios_activos").click(function(event) {
      event.preventDefault();
      // alert("has presionado estadisticas");

      $("#page-wrapper" ).load( "pages/administracion/panel_Grafos/grafo_empleados.php" );
      });

    $("#logs").click(function(event) {
      event.preventDefault();
      $("#page-wrapper").load("pages/administracion/logs/Logs.php" );
      });
});
