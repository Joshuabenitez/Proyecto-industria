/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

  $(document).ready(function(){

    $("#SecretariaAcademica").click(function(event) {
      event.preventDefault();
          
      $("#contenedor").load("pages/SecretariaAcademica/Graficos/pantallaPrincipal.php");
      });
    
    $("#RegistroEstudiante").click(function(event) {

      event.preventDefault();
          
      $("#contenedor" ).load( "pages/SecretariaAcademica/RegistroEstudiantes/RegistroDeEstudiantes.php"
                            );
      }); 
    $("#TipoEstudiante").click(function(event) {
      event.preventDefault();
      
      $("#contenedor").load( "pages/SecretariaAcademica/Tipo_Estudiante/TipoEstudiante.php");
      }); 
      
    $("#tiposEstudiantes").click(function(event) {
      event.preventDefault();
      
      $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/TiposDeEstudiantes/TipoDeEstudiante.php");
      });  
      
    $("#periodosAcademicos").click(function(event) {
      event.preventDefault();
      
      $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/Periodos/periodos.php");
      });            

    $("#nuevaSolicitud").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/SecretariaAcademica/tipo_de_solicitud/tipo_de_solicitud.php"
                            );
      });

    $("#SolicitudEstudiante").click(function(event) {
      event.preventDefault();
      
      $("#contenedor").load("pages/SecretariaAcademica/NuevaSolicitud/nuevaSolicitud.php"
                            );
      }); 

    $("#BusquedaAvanzada").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/BusquedaAvanzada/BusquedaAvanzada.php"
                            );
      });
	  
    $("#elementoMenuEstudiantes").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/MostrarEstudiantes/mostrarEstudiantes.php"
                            );
      });	  
	  

    $("#ManejoDocuementos").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/Manejo_Documentos/manejo_Documentos.php"
                            );
      });
    $("#ciudadOrigen").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/CiudadOrigen/ciudadOrigen.php"
                            );
      });

    $("#planesEstudio").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/PlanesEstudio/planesEstudio.php"
                            );
      });

    $("#mencionHonorifica").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/MencionesHonorificas/MencionesHonorificas.php"
                            );
      });
    $("#Orientaciones").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/Orientaciones/orientaciones.php"
                            );
      });

    
    $("#secre_reportes").click(function(event) {
      event.preventDefault();
    
        $("#contenedor").load( "pages/SecretariaAcademica/GeneracionReportes/principal_reportes.php");
        });
      
    $("#secre_generacion_documentos").click(function(){
        event.preventDefault();
        $("#contenedor").load("pages/SecretariaAcademica/GeneracionReportes/DocumentosReporte/principal_documentos.php");
    });

    // $("#secre_generacion_reportes").click(function(event) {
    //   event.preventDefault();
    //   $("#contenedor").load( "pages/SecretariaAcademica/Mantenimiento/Orientaciones/orientaciones.php"
    //                         );
    //   });
    
});

