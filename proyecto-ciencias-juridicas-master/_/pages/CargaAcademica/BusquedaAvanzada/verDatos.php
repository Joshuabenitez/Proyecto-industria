
<?php

	$maindir = "../../../";
	include($maindir."conexion/config.inc.php");  

	require_once($maindir."funciones/check_session.php");

	require_once($maindir."funciones/timeout.php");
	  
	if(!isset( $_SESSION['user_id'] ))
	{
	  header('Location: '.$maindir.'login/logout.php?code=100');
	  exit();
	}
	
	require($maindir . "fpdf/fpdf.php");
	$anio=NULL;
	$periodoC=NULL;
	$anio=$_POST['anio'];
	$periodoC=$_POST['periodoC'];
	$num=0;

	$pdf=new FPDF();
	$pdf->AddPage();

	$pdf->Image("img/unah.png",10,10,190,35);
	$pdf->Ln(40);
	$pdf->SetFont("Arial","B","9");
	$pdf->Cell(30,10,"Carga Academica",1,'C');
	$pdf->Cell(20,10,"Periodo",1,'C');
	$pdf->Cell(35,10,"Profesor",1,'C');
	$pdf->Cell(30,10,"Asignatura",1,'C');
	$pdf->Cell(20,10,"Seccion",1,'C');
	$pdf->Cell(25,10,"Hora Inicio",1,'C');
	$pdf->Cell(25,10,"Hora Fin",1,'C');
	$pdf->Ln(10);
        
	$query = $db -> prepare("CALL SP_REPORTE_CARGA_ACADEMICA(?,?)");
        $query -> execute(array($anio, $periodoC));
        
	while ($datos = $query ->fetch(PDO::FETCH_ASSOC) ) 
	{
		$carga=$datos['codigo'];
		$periodo=$datos['cod_periodo'];	
		$profesor=$datos['Primer_nombre'] ." ". $datos['Primer_apellido'];
	
		$asignatura=$datos['Clase'];
		$seccion=$datos['cod_seccion'];
		$hora_inicio=$datos['hora_inicio'];
		$hora_fin=$datos['hora_fin'];

		$pdf->SetFont("Arial","B","9");
		$pdf->Cell(30,10,$carga,1,'C');
		$pdf->Cell(20,10,$periodo,1,'C');
		$pdf->Cell(35,10,$profesor,1,'C');
		$pdf->Cell(30,10,$asignatura,1,'C');
		$pdf->Cell(20,10,$seccion,1,'C');
		$pdf->Cell(25,10,$hora_inicio,1,'C');
		$pdf->Cell(25,10,$hora_fin,1,'C');
		$pdf->Ln(10);
		$num=1;
	}
	
	if($num==0)
	{
		$pdf->Ln(30);
		$pdf->SetFont("Arial","B","20");
		$pdf->Cell(1,50,"              NO SE ENCONTRARON RESULTADOS",0,'C');
	}
	$pdf->OutPut();
?>