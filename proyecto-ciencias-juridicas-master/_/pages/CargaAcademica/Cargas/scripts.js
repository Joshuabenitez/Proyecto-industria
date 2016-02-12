// Función Guardar/Nueva Carga.
// Se Ejecuta Al Momento De Presionar Los Input guardar o nuevo.

function request(input){
  var xmlhttp;

  var cod_periodo = document.getElementById("periodos").value;
  var cod_estado = document.getElementById("estados").value;
  var no_empleado = document.getElementById("docentes").value;
  
  
  var params = "cod_periodo="+cod_periodo+"&cod_estado="+cod_estado+
               "&no_empleado="+no_empleado;
  
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
      cargarCargas();
    }else{
      document.getElementById("alerta").className = "alert alert-danger alert-error";
      document.getElementById("alerta").innerHTML = xmlhttp.responseText;
    }
  }

  if(input == "guardar" && listoParaPeticion(cod_periodo,cod_estado,no_empleado)){
    var respuesta = confirm("¿Está seguro que desea guardar los datos?");
    if (respuesta){
      if(document.getElementById("modificando").checked){
        var carga = document.getElementById("lblCarga").innerHTML;
        params = params + "&cod_carga=" + carga;
        xmlhttp.open("POST","pages/CargaAcademica/Cargas/actualizarCarga.php",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send(params);
      }else{
        xmlhttp.open("POST","pages/CargaAcademica/Cargas/guardarCarga.php",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send(params);
      }
    }
  }else if(input == "nuevo"){
    limpiarControles();
  }
}


function listoParaPeticion(cod_periodo,cod_estado,no_empleado){
  if(cod_periodo == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Período.";
    document.getElementById("periodos").focus();
    return false;
  }else if(cod_estado == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Estado.";
    document.getElementById("estados").focus();
    return false;
  }else if(no_empleado == 0){
    document.getElementById("alerta").className = "alert alert-danger alert-error";
    document.getElementById("alerta").innerHTML = "<strong>¡Error! </strong>Debe seleccionar un Docente.";
    document.getElementById("docentes").focus();
    return false;
  }else{
    return true;
  }
}

function limpiarControles(){
  document.getElementById("periodos").value = 0;
  document.getElementById("estados").value = 0;
  document.getElementById("docentes").value = 0;
  document.getElementById("modificando").checked = false;
  document.getElementById("alerta").className = "";
  document.getElementById("alerta").innerHTML = "";
  document.getElementById("carga").innerHTML = "";
  
  $(document).find('table').find('tr').each(function(){
   $(this).find('td').each(function(){
         $(this).css('background-color', '');
       });
  });
}

function cargarCargas() {
  var xmlhttp;

  if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
  } else {// code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      document.getElementById("cargas").innerHTML = xmlhttp.responseText;
    }
  }

  xmlhttp.open("GET","pages/CargaAcademica/Cargas/cargarCargas.php",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send();
}


// EVENTO BOTON ELIMINAR DE TABLA DE CARGAS
$(document).on("click",".elimina",function () {
           
      var respuesta = confirm("¿Está seguro que desea eliminar el registro seleccionado? (ADEVERTENCIA: Debe asignar las clases a otra carga para que no sean borradas.)");
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
              cargarCargas();
            }else{
              document.getElementById("alerta").className = "alert alert-danger alert-error";
              document.getElementById("alerta").innerHTML = xmlhttp.responseText;
            }
          }

          xmlhttp.open("POST","pages/CargaAcademica/Cargas/eliminarCarga.php",true);
          xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
          xmlhttp.send("cod_carga="+codigo);
      }                 
});
   

// EVENTO BOTON EDITAR(SELECCIONAR) DE TABLA DE CARGAS
$(document).on("click",".editar",function () {
  limpiarControles();
  var codigo = $(this).parents("tr").find("td").eq(0).attr('id');
  var docente = $(this).parents("tr").find("td").eq(1).attr('id');
  var periodo = $(this).parents("tr").find("td").eq(2).attr('id');
  var estado = $(this).parents("tr").find("td").eq(3).attr('id');

  document.getElementById("carga").innerHTML = "<label class='col-sm-3 control-label'>Código:</label><label id = 'lblCarga' class='control-label'>"+ codigo +" </label>";
  document.getElementById("modificando").checked = true;
  document.getElementById("docentes").value = docente;
  document.getElementById("periodos").value = periodo;
  document.getElementById("estados").value = estado;

  $(this).parents("tr").find('td').each(function(){
      $(this).css('background-color', 'Aquamarine');
  });

  document.getElementById("cargas").focus();
});