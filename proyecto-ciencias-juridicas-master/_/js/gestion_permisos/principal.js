/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

	var y;
	y=$(document);
	y.ready(inicio);

	function inicio()
	{
		var x;
		x=$("#solicitud");
		x.click(Solicitud);
		
		var x1;
		x1=$("#motivos");
		x1.click(Motivos);
	  
	  
		var x2;
		x2=$("#edificios");
		x2.click(Edificios);
		
		var x3;
		x3=$("#unidad");
		x3.click(Unidad);
		
		var x4;
		x4=$("#revision");
		x4.click(Revision);
		
		var x5;
		x5=$("#reportetotal");
		x5.click(ReporteT);
		
		var x6;
		x6=$("#reportetrimestral");
		x6.click(ReporteTr);
		
		var x7;
		x7=$("#solicitude");
		x7.click(Solicitud_empleado);
		
		var x8;
		x8=$("#estadistica");
		x8.click(Esta);
                
                var x9;
		x9=$("#nE");
		x9.click(nE);
	}

	function Esta()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/estadistica/estadistica.php",    
			// url:"../estadistica.php",  
			beforeSend:inicioEnvio,
			success:llegadaEsta,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}
	
	function llegadaEsta()
	{
		$("#contenedor").load('pages/permisos/estadistica/estadistica.php');
		 //$("#contenedor").load('../permisos/estadistica.php');
	}
	function Solicitud()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/solicitudpersonal/Solicitud.php",    
			// url:"../solicitudes.php",  
			beforeSend:inicioEnvio,
			success:llegadaSolic,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }  
		}); 
		return false;
	}
	
	function Solicitud_empleado()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/solicitudempleado/Nuevo_usuario.php",      
			beforeSend:inicioEnvio,
			success:llegadaCreacion,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}

	function Motivos()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/motivo/motivo.php",    
			// url:"../Motivos.php",  
			beforeSend:inicioEnvio,
			success:llegadaMotivos,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}

	function Edificios()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/edificio/Edificios.php",    
			// url:"../Edificios.php",  
			beforeSend:inicioEnvio,
			success:llegadaEdificios,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}

	function Unidad()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/Unidad_Academica.php",    
			// url:"../Unidad_Academica.php",  
			beforeSend:inicioEnvio,
			success:llegadaUnidad,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}
	
	function Revision()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/revision/Revision.php",    
			// url:"../Revision.php",  
			beforeSend:inicioEnvio,
			success:llegadaRevision,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return true;
	}
        
        function nE()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/revision/nE.php",    
			// url:"../Revision.php",  
			beforeSend:inicioEnvio,
			success:llegadanE,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return true;
	}
	
	function ReporteT()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/reportecompleto/ReporteTotal.php",    
			// url:"../ReporteTotal.php",  
			beforeSend:inicioEnvio,
			success:llegadaReporteTotal,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}
	function ReporteTr()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/consultaempleado/reporteEmpleado.php",    
			// url:"../reporteTrimestral.php",  
			beforeSend:inicioEnvio,
			success:llegadaReporteTrimestral,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}
	function CrearUsuario()
	{
		$.ajax({
			async:true,
			type: "POST",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded",
			url:"pages/permisos/solicitudempleado/Nuevo_usuario.php",      
			beforeSend:inicioEnvio,
			success:llegadaCreacion,
			timeout:4000,
			error:function(result){  
            alert('ERROR ' + result.status + ' ' + result.statusText);  
          }
		}); 
		return false;
	}
	
	//$(".btn-default").on('click',
	/*function CrearSolicitudPDF(){
          mode = $(this).data('mode');
          id1 = $(this).data('id');
          if(mode == "verPDF"){
           
			data={
            NroFolio:id
            };
            $.ajax({
                async:true,
                type: "POST",
                dataType: "html",
                contentType: "application/x-www-form-urlencoded",
                url:"pages/permisos/crear_pdfpermiso.php", 
                success:reportePDF,
                timeout:4000,
                error:problemas
            }); 
            return false;
          }
    };
	
	function reportePDF(){
		window.open('pages/permisos/crear_pdfpermiso.php?id1='+id1);
	}*/

	function inicioEnvio()
	{
		var x=$("#contenedor");
		x.html('Cargando...');
	}
	function llegadaSolic()
	{
		$("#contenedor").load('pages/permisos/solicitudpersonal/Solicitud.php');
		 //$("#contenedor").load('../permisos/solicitudes.php');
	}
	function llegadaMotivos()
	{
		$("#contenedor").load('pages/permisos/motivo/motivo.php');
		 //$("#contenedor").load('../permisos/motivo.php');
	}
	function llegadaEdificios()
	{
		$("#contenedor").load('pages/permisos/edificio/Edificios.php');
		 //$("#contenedor").load('../permisos/Edificios.php');
	}
	function llegadaUnidad()
	{
		$("#contenedor").load('pages/permisos/Unidad_Academica.php');
		 //$("#contenedor").load('../permisos/Unidad_Academica.php');
	}
	function llegadaRevision()
	{
		$("#contenedor").load('pages/permisos/revision/Revision.php');
		 //$("#contenedor").load('../permisos/Revision.php');
	}
        function llegadanE()
	{
		$("#contenedor").load('pages/permisos/revision/nE.php');
		 //$("#contenedor").load('../permisos/Revision.php');
	}
	function llegadaReporteTotal()
	{
		$("#contenedor").load('pages/permisos/reportecompleto/ReporteTotal.php');
		 //$("#contenedor").load('../permisos/ReporteTotal.php');
	}
	function llegadaReporteTrimestral()
	{
		$("#contenedor").load('pages/permisos/consultaempleado/reporteEmpleado.php');
		 //$("#contenedor").load('../permisos/reporteTrimestral.php');
	}
	function llegadaCreacion(){
		$("#contenedor").load('pages/permisos/solicitudempleado/Nuevo_usuario.php');
	}
	function problemas()
	{
		$("#contenedor").text();
	}
		function llegadaCreacion(){
		$("#contenedor").load('pages/permisos/solicitudempleado/Nuevo_usuario.php');
	}