// Función Guardar/Nueva Clase.
// Se Ejecuta Al Momento De Presionar El Input guardar/nuevo.

function request(input){
  var xmlhttp;

  var cod_asignatura = document.getElementById("asignaturas").value;
  var cod_seccion = document.getElementById("secciones").value;
  var cod_carga = document.getElementById("cargas").value;
  var cod_aula = document.getElementById("aulas").value;
  var no_empleado = document.getElementById("docentes").value;
  var cupos = document.getElementById("cupos").value;
  var array = [];
  var cod_edificio = document.getElementById("edificios").value;
  
  if(document.getElementById("lun").checked) array.push(document.getElementById("lun").value);
  if(document.getElementById("mar").checked) array.push(document.getElementById("mar").value);
  if(document.getElementById("mier").checked) array.push(document.getElementById("mier").value);
  if(document.getElementById("ju").checked) array.push(document.getElementById("ju").value);
  if(document.getElementById("vi").checked) array.push(document.getElementById("vi").value);
  if(document.getElementById("sa").checked) array.push(document.getElementById("sa").value);

  var params = "cod_asignatura="+cod_asignatura+"&cod_seccion="+cod_seccion+
               "&cod_carga="+cod_carga+"&cod_aula="+cod_aula+"&no_empleado="+no_empleado+
               "&cupos="+cupos+"&dias="+array.toString();
  
  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }

  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      if(!document.getElementById("modificando").checked)
        limpiarControles();
      document.getElementById("alerta").className = "alert alert-success alert-succes";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
      cargarClases();
    }else{
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
    }
  }

  if(input == "guardar" && listoParaPeticion(cod_asignatura,cod_seccion,cod_carga,cod_aula,no_empleado,cupos,cod_edificio)){
    var respuesta = confirm("¿Está seguro que desea guardar los datos?");
    if (respuesta){
      if(document.getElementById("modificando").checked){
        var clase = document.getElementById("lblClase").innerHTML;
        params = params + "&cod_clase=" + clase;
        xmlhttp.open("POST","pages/CargaAcademica/Clases/actualizarClase.php",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send(params);
      }else{
        xmlhttp.open("POST","pages/CargaAcademica/Clases/guardarClase.php",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send(params);
      }
    }
  }else if(input == "nuevo"){
    limpiarControles();
  }
}


function cargarAulasPorEdificio(cod_edificio,cod_aula) {
  var xmlhttp;

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("aulas").innerHTML = xmlhttp.responseText;
      document.getElementById("aulas").value = cod_aula;
    }
  }

  xmlhttp.open("POST","pages/CargaAcademica/Clases/cargarAulasPorEdificio.php",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send("q="+cod_edificio);
}

function listoParaPeticion(cod_asignatura,cod_seccion,cod_carga,cod_aula,no_empleado,cupos,cod_edificio){
  if(cod_carga == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar una Carga.";
    document.getElementById("cargas").focus();
    return false;
  }else if(cod_asignatura == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar una Asignatura.";
    document.getElementById("asignaturas").focus();
    return false;
  }else if(cod_seccion == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar una Sección.";
    document.getElementById("secciones").focus();
    return false;
  }else if(cod_edificio == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Edificio.";
    document.getElementById("edificios").focus();
    return false;
  }else if(cod_aula == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Aula.";
    document.getElementById("aulas").focus();
    return false;
  }else if(no_empleado == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Docente.";
    document.getElementById("docentes").focus();
    return false;
  }else if(cupos == ""){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe Ingresar la Cantidad de Cupos.";
    document.getElementById("cupos").focus();
    return false;
  }else if(noCheckSeleccionado()){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe Seleccionar Uno o Más Días.";
    document.getElementById("lun").focus();
    return false;
  }else{
    return true;
  }
}

function noCheckSeleccionado(){
  return !(document.getElementById("lun").checked ||
         document.getElementById("mar").checked ||
         document.getElementById("mier").checked ||
         document.getElementById("ju").checked ||
         document.getElementById("vi").checked ||
         document.getElementById("sa").checked);
}


function limpiarControles(){
  document.getElementById("cargas").value = 0;
  document.getElementById("asignaturas").value = 0;
  document.getElementById("secciones").value = 0;
  document.getElementById("edificios").value = 0;
  document.getElementById("aulas").value = 0;
  document.getElementById("docentes").value = 0;
  document.getElementById("cupos").value = "";
  document.getElementById("lun").checked = false;
  document.getElementById("mar").checked = false;
  document.getElementById("mier").checked = false;
  document.getElementById("ju").checked = false;
  document.getElementById("vi").checked = false;
  document.getElementById("sa").checked = false;
  document.getElementById("modificando").checked = false;
  document.getElementById("alerta").className = "";
  document.getElementById("alerta").innerHTML = "";
  document.getElementById("clase").innerHTML = "";
  
  $(document).find('table').find('tr').each(function(){
   $(this).find('td').each(function(){
         $(this).css('background-color', '');
       });
  });
}

function justNumbers(e){
  var keynum = window.event ? window.event.keyCode : e.which;
  
  if ((keynum == 8) || (keynum == 0))
    return true;
   
  return /\d/.test(String.fromCharCode(keynum));
}

function cargarClases() {
  var xmlhttp;

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("clases").innerHTML = xmlhttp.responseText;
      var p = new Paginador(document.getElementById('paginador'),document.getElementById('clases'),4);
      p.Mostrar();
    }
  }

  xmlhttp.open("GET","pages/CargaAcademica/Clases/cargarClases.php",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send();
}

$(document).on("click",".elimina",function () {
           
      var respuesta = confirm("¿Está seguro que desea eliminar el registro seleccionado?");
      if (respuesta){
          var codigo = $(this).parents("tr").find("td").eq(0).attr('id');
          var xmlhttp;

          if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
          } else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          
          xmlhttp.onreadystatechange = function(){
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
              limpiarControles();
              document.getElementById("alerta").className = "alert alert-success alert-succes";
              document.getElementById("alerta").innerHTML = xmlhttp.responseText;
              cargarClases();
            }else{
              document.getElementById("alerta").className = "alert alert-danger alert-error";
              document.getElementById("alerta").innerHTML = xmlhttp.responseText;
            }
          }

          xmlhttp.open("POST","pages/CargaAcademica/Clases/eliminarClase.php",true);
          xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
          xmlhttp.send("cod_clase="+codigo);
      }                 
});
   
$(document).on("click",".editar",function () {
  limpiarControles();
  var codigo = $(this).parents("tr").find("td").eq(0).attr('id');
  var carga = $(this).parents("tr").find("td").eq(1).attr('id');
  var asignatura = $(this).parents("tr").find("td").eq(2).attr('id');
  var docente = $(this).parents("tr").find("td").eq(3).attr('id');
  var strDias = $(this).parents("tr").find("td").eq(4).attr('id');
  var seccion = $(this).parents("tr").find("td").eq(5).attr('id');
  var edificio = $(this).parents("tr").find("td").eq(6).attr('id');
  var aula = $(this).parents("tr").find("td").eq(7).attr('id');
  var cupos = $(this).parents("tr").find("td").eq(8).attr('id');

  document.getElementById("clase").innerHTML = "<label class='col-sm-3 control-label'>Código:</label><label id = 'lblClase' class='control-label'>"+ codigo +" </label>";
  document.getElementById("modificando").checked = true;
  document.getElementById("cargas").value = carga;
  document.getElementById("asignaturas").value = asignatura;
  document.getElementById("secciones").value = seccion;
  document.getElementById("edificios").value = edificio;
  cargarAulasPorEdificio(edificio,aula);
  document.getElementById("docentes").value = docente;
  document.getElementById("cupos").value = cupos;
  seleccionarChecks(strDias);

  $(this).parents("tr").find('td').each(function(){
      $(this).css('background-color', 'Aquamarine');
  });

  document.getElementById("cargas").focus();
});

function seleccionarChecks(strDias){
  var dias = strDias.split(",");
  for (i=0; i<dias.length; i++)
    document.getElementById(dias[i]).checked = true;
}