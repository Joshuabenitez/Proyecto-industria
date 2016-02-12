// Función Para Cargar Listbox De Los Docentes Que No Han Sido Asignados A Proyectos
function cargarDocentesSinProyecto() {
  var xmlhttp;

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("docentes").innerHTML = xmlhttp.responseText;
    }
  }

  xmlhttp.open("GET","pages/CargaAcademica/AsignacionProyectos/cargarDocentes.php",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send();
}


// Función Para Cargar Listbox De Docentes En Un Proyecto. 
// Se Ejecuta Al Momento De Seleccionar Un Proyecto Del Combobox proyectos.
// Parametro cod_proyecto: Código del proyecto seleccionado.
function cargarDocentesProyecto(cod_proyecto) {
  var xmlhttp;

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("docentesProyecto").innerHTML = xmlhttp.responseText;
    }
  }

  xmlhttp.open("POST","pages/CargaAcademica/AsignacionProyectos/cargarDocentesProyecto.php",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send("q="+cod_proyecto);
}

// Función Para Agregar Un Docente A Un Proyecto.
// Se Ejecuta Al Momento De Presionar El Input asignarDocente.
function agregarDocente(){
  
}

// Función Para Quitar Docente De Un Proyecto.
// Se Ejecuta Al Momento De Presionar El Input quitarDocente.
function quitarDocente(){
  var no_empleado = document.getElementById("docentesProyecto").value;
  var cod_rol = document.getElementById("roles").value;
  var cod_proyecto = document.getElementById("proyectos").value;
  var params = "no_empleado="+no_empleado+"&cod_rol="+cod_rol+"&cod_proyecto="+cod_proyecto;

  var xmlhttp;
  
  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }

  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("alerta").className = "alert alert-success alert-succes";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
    }else{
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
    }
  }
  
  
}




function request(input){
  var xmlhttp;
  
  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }

  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("alerta").className = "alert alert-success alert-succes";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
      cargarDocentesProyecto(cod_proyecto);
      cargarDocentesSinProyecto();
    }else{
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
    }
  }

  var cod_proyecto = document.getElementById("proyectos").value;
  
  if(input == "asignarDocente"){
    var no_empleado = document.getElementById("docentes").value;
    var cod_rol = document.getElementById("roles").value;
    var params = "no_empleado="+no_empleado+"&cod_rol="+cod_rol+"&cod_proyecto="+cod_proyecto;

    if(no_empleado == ""){
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Docente para agregar a proyecto.";
    }else if(cod_proyecto == 0 || cod_proyecto == null){
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Proyecto.";
    }else if(cod_rol == 0 || cod_rol == null){
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Rol.";
    }else{
      xmlhttp.open("POST","pages/CargaAcademica/AsignacionProyectos/asignarDocente.php",true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send(params);
    }
  }else{
    var no_empleado = document.getElementById("docentesProyecto").value;
    var params = "no_empleado="+no_empleado+"&cod_proyecto="+cod_proyecto;

    if(no_empleado == ""){
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar Docente a eliminar del proyecto.";
    }else{
      xmlhttp.open("POST","pages/CargaAcademica/AsignacionProyectos/quitarDocente.php",true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send(params);
    }
  }
}