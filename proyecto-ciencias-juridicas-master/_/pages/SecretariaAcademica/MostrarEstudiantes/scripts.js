// Función Guardar/Nueva Clase.
// Se Ejecuta Al Momento De Presionar El Input guardar/nuevo.


function request(id){
  if(id=="modificar"){
    var respuesta = confirm("¿Está seguro que desea actualizar los datos?");
    if (respuesta){
         datoss = $('#formActualizar').serialize(),
       $.ajax({
        type: "POST",
        url: "pages/SecretariaAcademica/MostrarEstudiantes/actualizarEstudiante.php",
        data: $('#formActualizar').serialize(),

        success: function(datos) {
          $("#contenedor").html(datos);
        }
      });
    }

  }
    // fin id modificar
  else if(id=="mostrar"){
    $("#contenedor").load("pages/SecretariaAcademica/MostrarEstudiantes/mostrarEstudiantes.php");
  }else{
    $("#contenedor").load("pages/SecretariaAcademica/RegistroEstudiantes/RegistroDeEstudiantes.php");
  }
}



$(document).on("click",".elimina",function () {
      var respuesta = confirm("¿Está seguro que desea eliminar el registro seleccionado?");
      if (respuesta){
          var no_cuenta = $(this).parents("tr").find("td").eq(0).attr('id');
          $.ajax({
              type: "POST",
              url: "pages/SecretariaAcademica/MostrarEstudiantes/eliminarEstudiante.php",
              data: {'no_cuenta':no_cuenta},

              success: function(datos) {
                $('#contenedor').html(datos);
              }
      });
      }
});
   
$( document).on("click",".edit_estudiante",function () {
  no_cuenta = $(this).data('no_cuenta');
  $.ajax({
    type: "POST",
    url: "pages/SecretariaAcademica/MostrarEstudiantes/cargarEstudiante.php",
    data:{"no_cuenta":no_cuenta},

    success: function(datos_estudiante) {
      //alert("obtenemos el estudiante"+datos_estudiante);
      $.ajax({
        type: "POST",
        url: "pages/SecretariaAcademica/MostrarEstudiantes/modificacionDeEstudiante.php",
        data:JSON.parse(datos_estudiante),

        success: function(formulario_lleno) {
          //alert("obeniendo el foermulario lleno "+ formulario_lleno);
          $('#contenedor').html(formulario_lleno);
        }
      });
    },
  });
});

$("#GenerarDocumentos").click(function(event) {
    event.preventDefault();
    window.open('pages/SecretariaAcademica/MostrarEstudiantes/reporte_estudiante.php');
}); 
