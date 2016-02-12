/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

  $(document).ready(function(){

    $("#CargaAcademica").click(function(event) 
    {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Cargas/gestionCargas.php");
    });
    
    $("#Asignaturas").click(function(event) {
      event.preventDefault();
          
      $("#contenedor" ).load( //Pantalla para ingresar un estudiante
                            );
      }); 
    $("#Edificios").click(function(event) {
      event.preventDefault();
          
      $("#contenedor" ).load( "pages/CargaAcademica/ca_crearEdificios.php"
                            );
      }); 

    $("#Aulas").click(function(event) {
      event.preventDefault();
      $("#contenedor").load(// Pantalla para ingresar una nueva solicitud
                            );
      });

    $("#Clases").click(function(event) {
      event.preventDefault();
      $("#contenedor").load(// Pantalla para ingresar una solicitud por estudiante
                            );
      }); 
      
    $("#seccionesMenu").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Secciones/gestionSeccion.php"
                            );
      });    
      
      
    $("#estadosCargas").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Estados/Estados.php"
                            );
      });          
      

    $("#AsignacionClases").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Clases/gestionClases.php"
                            );
      });
      
      $("#Cargas").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Cargas/gestionCargas.php"
                            );
      });      
      
      $("#Acondicionamientos").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Acondicionamientos/ca_index_Acondicionamiento.php"
                            );
      });

    $("#RegistroDocentes").click(function(event) {
      event.preventDefault();
      $("#contenedor").load( "pages/CargaAcademica/RegistroDocentes/RegristroDocentes.php"
                            );
      });
    $("#Facultad").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/facultad/ca_indexFacultad.php"
                            );
      });
      $("#Periodos").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/periodos/ca_indexPeriodo.php"
                            );
      });
    $("#AreasProyecto").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Areas_de_Proyectos/ca_index_Areas_de_Proyecto.php"
                            );
      }); 
    $("#AreasVinculacion").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/ca_crearAreaVinculacion.php"
                            );
      }); 
    $("#Proyectos").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/Proyecto/Proyectos.php"
                            );
      });
    $("#AsigancionProyecto").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/AsignacionProyectos/asignacionProyectos.php"
                            );
      });
    $("#busquedaCargaAcademica").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/BusquedaAvanzada/reporte.php"
                            );
      }); 
      
    $("#BusquedaAvanzadaProyectos").click(function(event) {
      event.preventDefault();
      $("#contenedor").load("pages/CargaAcademica/BusquedaAvanzada/BusquedaAvanzadaProyectos.php"
                            );
      });       
      
      
});
