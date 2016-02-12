<?php

$maindir = '../../../';
include $maindir . 'fpdf/fpdf.php';
include $maindir . 'Datos/conexion.php';
include($maindir . "conexion/config.inc.php");


            
$pdf = new FPDF();


$pdf->AddPage();
$pdf->SetFont('Arial', '', 18);
$pdf->Image($maindir.'assets/img/cabecera.png', -2,5,212,30, 'PNG');
$pdf->Image($maindir.'assets/img/lucen-aspicio.png', 78,85,200,200, 'PNG');
$pdf->Ln(30);
$pdf->Cell(18, 10, '', 0);
$pdf->SetFont('Arial', '', 18);
$pdf->Cell(30, 8, ' ', 0,0,"C");
$pdf->Cell(100, 8,'Reporte de proyectos', 0,0,"C");
$pdf->Rect(2, 55, 206, 200 ,'D');
$pdf->SetFont('Arial', '', 12);
$pdf->Ln(15);
$pdf->Cell(115, 15, 'Fecha: '.date('Y-m-d'), 0);
$pdf->Ln(7);
$pdf->Ln(5);
$pdf->SetFont('Arial', 'B', 8);

$pdf->Cell(28, 8, utf8_decode('Código Proyecto'),1,0,"C");
$pdf->Cell(40, 8, utf8_decode('Nombre Proyecto'),1, 0,"C");
$pdf->Cell(40, 8, utf8_decode('Área de Vinculación'),1,0,"C");
$pdf->Cell(30, 8, utf8_decode('Área'),1,0,"C");
$pdf->Cell(55, 8, utf8_decode('Coordinador'),1,0,"C");
//$pdf->Cell(30, 8, 'Solicitud realizada',1,0,"C");
//$pdf->Cell(17, 8, 'Fecha',1,0,"C");
$pdf->Ln(8);
$pdf->SetFont('Arial', '', 8);


$query = 'CALL SP_REPORTE_PROYECTOS(@mensajeError)';
$result = mysql_query($query);

$json = array();
$contadorIteracion = 0;


while ($fila = mysql_fetch_array($result)) 
{
    $pdf->Cell(28, 8, $fila["CODIGO_PROYECTO"],1,0,"C");
    $pdf->Cell(40, 8, $fila["PROYECTO_NOMBRE"],1,0,"C");
    $pdf->Cell(40, 8, $fila["VINCULACION_NOMBRE"],1,0,"C");
    $pdf->Cell(30, 8, $fila["NOMBRE_AREA"]."%",1,0,"C");
    $pdf->Cell(55, 8, $fila["NOMBRE_COORDINADOR"],1,0,"C");
//    $pdf->Cell(30, 8, $fila["NOMBRE_TIPO_SOLICITUD"],1,0,"C");
//    $pdf->Cell(17, 8, $fila["FECHA_SOLICITUD"],1,0,"C");

    $pdf->Ln(8);   
    
    //$pdf->Cell($w, $h, $txt, $border)
}

$pdf->SetFont('Arial', '', 10);


$pdf->Output();   