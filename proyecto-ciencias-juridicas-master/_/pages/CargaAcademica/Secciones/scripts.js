// Función Guardar/Nueva Carga.
// Se Ejecuta Al Momento De Presionar Los Input guardar o nuevo.

function request(input){
  var xmlhttp;

  var codigo = document.getElementById("seccion").value;
  var hora_inicio = document.getElementById("hora_i").value;
  var hora_fin = document.getElementById("hora_f").value;

  var params = "codigo="+codigo+"&hora_inicio="+hora_inicio+
               "&hora_fin="+hora_fin;
  
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
      cargarSecciones();
    }else{
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
    }
  }

  if(input == "guardar" && listoParaPeticion(codigo,hora_inicio,hora_fin)){
    var respuesta = confirm("¿Está seguro que desea guardar los datos?");
    
    if (respuesta){
      if(validarHora(document.getElementById("hora_i")) && validarHora(document.getElementById("hora_f"))){
        if(document.getElementById("modificando").checked){
          xmlhttp.open("POST","pages/CargaAcademica/Secciones/actualizarSeccion.php",true);
          xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
          xmlhttp.send(params);
        }else{
          xmlhttp.open("POST","pages/CargaAcademica/Secciones/guardarSeccion.php",true);
          xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
          xmlhttp.send(params);
        }
      }
      
    }
  }else if(input == "nuevo"){
    limpiarControles();
  }
}


function listoParaPeticion(codigo,hora_inicio,hora_fin){
  if(codigo == ""){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe ingresar el código de la sección.";
    document.getElementById("seccion").focus();
    return false;
  }else if(hora_inicio == ""){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe ingresar la hora de inicio.";
    document.getElementById("hora_i").focus();
    return false;
  }else if(hora_fin == ""){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe ingresar la hora de fin.";
    document.getElementById("hora_f").focus();
    return false;
  }else{
    return true;
  }
}

function limpiarControles(){
  document.getElementById("seccion").value = "";
  document.getElementById("hora_i").value = "";
  document.getElementById("hora_f").value = "";
  document.getElementById("modificando").checked = false;
  document.getElementById("seccion").disabled = false;
  document.getElementById("alerta").className = "";
  document.getElementById("alerta").innerHTML = "";
  
  $(document).find('table').find('tr').each(function(){
   $(this).find('td').each(function(){
         $(this).css('background-color', '');
       });
  });
}

function cargarSecciones() {
  var xmlhttp;

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("secciones").innerHTML = xmlhttp.responseText;
    }
  }

  xmlhttp.open("GET","pages/CargaAcademica/Secciones/cargarSecciones.php",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send();
}

function justNumbers(e){
  var keynum = window.event ? window.event.keyCode : e.which;
  
  if ((keynum == 8) || (keynum == 0))
    return true;
   
  return /\d/.test(String.fromCharCode(keynum));
}

// EVENTO BOTON ELIMINAR DE TABLA DE CARGAS
$(document).on("click",".elimina",function () {
           
      var respuesta = confirm("¿Está seguro que desea eliminar el registro seleccionado? (ADEVERTENCIA: Las clases con esta sección serán eliminadas.)");
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
              cargarSecciones();
            }else{
              document.getElementById("alerta").className = "alert alert-danger alert-error";
              document.getElementById("alerta").innerHTML = xmlhttp.responseText;
            }
          }

          xmlhttp.open("POST","pages/CargaAcademica/Secciones/eliminarSeccion.php",true);
          xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
          xmlhttp.send("codigo="+codigo);
      }                 
});
   

// EVENTO BOTON EDITAR(SELECCIONAR) DE TABLA DE CARGAS
$(document).on("click",".editar",function () {
  limpiarControles();
  var codigo = $(this).parents("tr").find("td").eq(0).attr('id');
  var hora_inicio = $(this).parents("tr").find("td").eq(1).attr('id');
  var hora_fin = $(this).parents("tr").find("td").eq(2).attr('id');

  document.getElementById("seccion").value = codigo;
  document.getElementById("seccion").disabled = true;
  document.getElementById("modificando").checked = true;
  document.getElementById("hora_i").value = hora_inicio;
  document.getElementById("hora_f").value = hora_fin;

  $(this).parents("tr").find('td').each(function(){
      $(this).css('background-color', 'Aquamarine');
  });

  document.getElementById("cargas").focus();
});


function validarHora(campo) {
    var RegExPattern = /^(([01]?[0-9])|(2[0-3])):([0-5]\d)$/;
    
    var errorMessage = 'Formato de hora no válido.' + campo.value;
    if (campo.value.match(RegExPattern)) {
        return true;
    } else {
        alert(errorMessage);
        campo.focus();
        return false;
    } 
}