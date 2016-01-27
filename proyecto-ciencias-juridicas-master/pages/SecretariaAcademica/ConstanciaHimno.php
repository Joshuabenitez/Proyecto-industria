<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// FUNCIONES DE CONVERSION DE NUMEROS A LETRAS.

 
function centimos()
{
	global $importe_parcial;
 
	$importe_parcial = number_format($importe_parcial, 2, ".", "") * 100;
 
	if ($importe_parcial > 0)
		$num_letra = " con ".decena_centimos($importe_parcial);
	else
		$num_letra = "";
 
	return $num_letra;
}
 
function unidad_centimos($numero)
{
	switch ($numero)
	{
		case 9:
		{
			$num_letra = "nueve céntimos";
			break;
		}
		case 8:
		{
			$num_letra = "ocho céntimos";
			break;
		}
		case 7:
		{
			$num_letra = "siete céntimos";
			break;
		}
		case 6:
		{
			$num_letra = "seis céntimos";
			break;
		}
		case 5:
		{
			$num_letra = "cinco céntimos";
			break;
		}
		case 4:
		{
			$num_letra = "cuatro céntimos";
			break;
		}
		case 3:
		{
			$num_letra = "tres céntimos";
			break;
		}
		case 2:
		{
			$num_letra = "dos céntimos";
			break;
		}
		case 1:
		{
			$num_letra = "un céntimo";
			break;
		}
	}
	return $num_letra;
}
 
function decena_centimos($numero)
{
	if ($numero >= 10)
	{
		if ($numero >= 90 && $numero <= 99)
		{
			  if ($numero == 90)
				  return "noventa céntimos";
			  else if ($numero == 91)
				  return "noventa y un céntimos";
			  else
				  return "noventa y ".unidad_centimos($numero - 90);
		}
		if ($numero >= 80 && $numero <= 89)
		{
			if ($numero == 80)
				return "ochenta céntimos";
			else if ($numero == 81)
				return "ochenta y un céntimos";
			else
				return "ochenta y ".unidad_centimos($numero - 80);
		}
		if ($numero >= 70 && $numero <= 79)
		{
			if ($numero == 70)
				return "setenta céntimos";
			else if ($numero == 71)
				return "setenta y un céntimos";
			else
				return "setenta y ".unidad_centimos($numero - 70);
		}
		if ($numero >= 60 && $numero <= 69)
		{
			if ($numero == 60)
				return "sesenta céntimos";
			else if ($numero == 61)
				return "sesenta y un céntimos";
			else
				return "sesenta y ".unidad_centimos($numero - 60);
		}
		if ($numero >= 50 && $numero <= 59)
		{
			if ($numero == 50)
				return "cincuenta céntimos";
			else if ($numero == 51)
				return "cincuenta y un céntimos";
			else
				return "cincuenta y ".unidad_centimos($numero - 50);
		}
		if ($numero >= 40 && $numero <= 49)
		{
			if ($numero == 40)
				return "cuarenta céntimos";
			else if ($numero == 41)
				return "cuarenta y un céntimos";
			else
				return "cuarenta y ".unidad_centimos($numero - 40);
		}
		if ($numero >= 30 && $numero <= 39)
		{
			if ($numero == 30)
				return "treinta céntimos";
			else if ($numero == 91)
				return "treinta y un céntimos";
			else
				return "treinta y ".unidad_centimos($numero - 30);
		}
		if ($numero >= 20 && $numero <= 29)
		{
			if ($numero == 20)
				return "veinte céntimos";
			else if ($numero == 21)
				return "veintiun céntimos";
			else
				return "veinti".unidad_centimos($numero - 20);
		}
		if ($numero >= 10 && $numero <= 19)
		{
			if ($numero == 10)
				return "diez céntimos";
			else if ($numero == 11)
				return "once céntimos";
			else if ($numero == 11)
				return "doce céntimos";
			else if ($numero == 11)
				return "trece céntimos";
			else if ($numero == 11)
				return "catorce céntimos";
			else if ($numero == 11)
				return "quince céntimos";
			else if ($numero == 11)
				return "dieciseis céntimos";
			else if ($numero == 11)
				return "diecisiete céntimos";
			else if ($numero == 11)
				return "dieciocho céntimos";
			else if ($numero == 11)
				return "diecinueve céntimos";
		}
	}
	else
		return unidad_centimos($numero);
}
 
function unidad($numero)
{
	switch ($numero)
	{
		case 9:
		{
			$num = "nueve";
			break;
		}
		case 8:
		{
			$num = "ocho";
			break;
		}
		case 7:
		{
			$num = "siete";
			break;
		}
		case 6:
		{
			$num = "seis";
			break;
		}
		case 5:
		{
			$num = "cinco";
			break;
		}
		case 4:
		{
			$num = "cuatro";
			break;
		}
		case 3:
		{
			$num = "tres";
			break;
		}
		case 2:
		{
			$num = "dos";
			break;
		}
		case 1:
		{
			$num = "uno";
			break;
		}
	}
	return $num;
}
 
function decena($numero)
{
	if ($numero >= 90 && $numero <= 99)
	{
		$num_letra = "noventa ";
 
		if ($numero > 90)
			$num_letra = $num_letra."y ".unidad($numero - 90);
	}
	else if ($numero >= 80 && $numero <= 89)
	{
		$num_letra = "ochenta ";
 
		if ($numero > 80)
			$num_letra = $num_letra."y ".unidad($numero - 80);
	}
	else if ($numero >= 70 && $numero <= 79)
	{
			$num_letra = "setenta ";
 
		if ($numero > 70)
			$num_letra = $num_letra."y ".unidad($numero - 70);
	}
	else if ($numero >= 60 && $numero <= 69)
	{
		$num_letra = "sesenta ";
 
		if ($numero > 60)
			$num_letra = $num_letra."y ".unidad($numero - 60);
	}
	else if ($numero >= 50 && $numero <= 59)
	{
		$num_letra = "cincuenta ";
 
		if ($numero > 50)
			$num_letra = $num_letra."y ".unidad($numero - 50);
	}
	else if ($numero >= 40 && $numero <= 49)
	{
		$num_letra = "cuarenta ";
 
		if ($numero > 40)
			$num_letra = $num_letra."y ".unidad($numero - 40);
	}
	else if ($numero >= 30 && $numero <= 39)
	{
		$num_letra = "treinta ";
 
		if ($numero > 30)
			$num_letra = $num_letra."y ".unidad($numero - 30);
	}
	else if ($numero >= 20 && $numero <= 29)
	{
		if ($numero == 20)
			$num_letra = "veinte ";
		else
			$num_letra = "veinti".unidad($numero - 20);
	}
	else if ($numero >= 10 && $numero <= 19)
	{
		switch ($numero)
		{
			case 10:
			{
				$num_letra = "diez ";
				break;
			}
			case 11:
			{
				$num_letra = "once ";
				break;
			}
			case 12:
			{
				$num_letra = "doce ";
				break;
			}
			case 13:
			{
				$num_letra = "trece ";
				break;
			}
			case 14:
			{
				$num_letra = "catorce ";
				break;
			}
			case 15:
			{
				$num_letra = "quince ";
				break;
			}
			case 16:
			{
				$num_letra = "dieciseis ";
				break;
			}
			case 17:
			{
				$num_letra = "diecisiete ";
				break;
			}
			case 18:
			{
				$num_letra = "dieciocho ";
				break;
			}
			case 19:
			{
				$num_letra = "diecinueve ";
				break;
			}
		}
	}
	else
		$num_letra = unidad($numero);
 
	return $num_letra;
}
 
function centena($numero)
{
	if ($numero >= 100)
	{
		if ($numero >= 900 & $numero <= 999)
		{
			$num_letra = "novecientos ";
 
			if ($numero > 900)
				$num_letra = $num_letra.decena($numero - 900);
		}
		else if ($numero >= 800 && $numero <= 899)
		{
			$num_letra = "ochocientos ";
 
			if ($numero > 800)
				$num_letra = $num_letra.decena($numero - 800);
		}
		else if ($numero >= 700 && $numero <= 799)
		{
			$num_letra = "setecientos ";
 
			if ($numero > 700)
				$num_letra = $num_letra.decena($numero - 700);
		}
		else if ($numero >= 600 && $numero <= 699)
		{
			$num_letra = "seiscientos ";
 
			if ($numero > 600)
				$num_letra = $num_letra.decena($numero - 600);
		}
		else if ($numero >= 500 && $numero <= 599)
		{
			$num_letra = "quinientos ";
 
			if ($numero > 500)
				$num_letra = $num_letra.decena($numero - 500);
		}
		else if ($numero >= 400 && $numero <= 499)
		{
			$num_letra = "cuatrocientos ";
 
			if ($numero > 400)
				$num_letra = $num_letra.decena($numero - 400);
		}
		else if ($numero >= 300 && $numero <= 399)
		{
			$num_letra = "trescientos ";
 
			if ($numero > 300)
				$num_letra = $num_letra.decena($numero - 300);
		}
		else if ($numero >= 200 && $numero <= 299)
		{
			$num_letra = "doscientos ";
 
			if ($numero > 200)
				$num_letra = $num_letra.decena($numero - 200);
		}
		else if ($numero >= 100 && $numero <= 199)
		{
			if ($numero == 100)
				$num_letra = "cien ";
			else
				$num_letra = "ciento ".decena($numero - 100);
		}
	}
	else
		$num_letra = decena($numero);
 
	return $num_letra;
}
 
function cien()
{
	global $importe_parcial;
 
	$parcial = 0; $car = 0;
 
	while (substr($importe_parcial, 0, 1) == 0)
		$importe_parcial = substr($importe_parcial, 1, strlen($importe_parcial) - 1);
 
	if ($importe_parcial >= 1 && $importe_parcial <= 9.99)
		$car = 1;
	else if ($importe_parcial >= 10 && $importe_parcial <= 99.99)
		$car = 2;
	else if ($importe_parcial >= 100 && $importe_parcial <= 999.99)
		$car = 3;
 
	$parcial = substr($importe_parcial, 0, $car);
	$importe_parcial = substr($importe_parcial, $car);
 
	$num_letra = centena($parcial).centimos();
 
	return $num_letra;
}
 
function cien_mil()
{
	global $importe_parcial;
 
	$parcial = 0; $car = 0;
 
	while (substr($importe_parcial, 0, 1) == 0)
		$importe_parcial = substr($importe_parcial, 1, strlen($importe_parcial) - 1);
 
	if ($importe_parcial >= 1000 && $importe_parcial <= 9999.99)
		$car = 1;
	else if ($importe_parcial >= 10000 && $importe_parcial <= 99999.99)
		$car = 2;
	else if ($importe_parcial >= 100000 && $importe_parcial <= 999999.99)
		$car = 3;
 
	$parcial = substr($importe_parcial, 0, $car);
	$importe_parcial = substr($importe_parcial, $car);
 
	if ($parcial > 0)
	{
		if ($parcial == 1)
			$num_letra = "mil ";
		else
			$num_letra = centena($parcial)." mil ";
	}
 
	return $num_letra;
}
 
 
function millon()
{
	global $importe_parcial;
 
	$parcial = 0; $car = 0;
 
	while (substr($importe_parcial, 0, 1) == 0)
		$importe_parcial = substr($importe_parcial, 1, strlen($importe_parcial) - 1);
 
	if ($importe_parcial >= 1000000 && $importe_parcial <= 9999999.99)
		$car = 1;
	else if ($importe_parcial >= 10000000 && $importe_parcial <= 99999999.99)
		$car = 2;
	else if ($importe_parcial >= 100000000 && $importe_parcial <= 999999999.99)
		$car = 3;
 
	$parcial = substr($importe_parcial, 0, $car);
	$importe_parcial = substr($importe_parcial, $car);
 
	if ($parcial == 1)
		$num_letras = "un millón ";
	else
		$num_letras = centena($parcial)." millones ";
 
	return $num_letras;
}
 
function convertir_a_letras($numero)
{
	global $importe_parcial;
 
	$importe_parcial = $numero;
 
	if ($numero < 1000000000)
	{
		if ($numero >= 1000000 && $numero <= 999999999.99)
			$num_letras = millon().cien_mil().cien();
		else if ($numero >= 1000 && $numero <= 999999.99)
			$num_letras = cien_mil().cien();
		else if ($numero >= 1 && $numero <= 999.99)
			$num_letras = cien();
		else if ($numero >= 0.01 && $numero <= 0.99)
		{
			if ($numero == 0.01)
				$num_letras = "un céntimo";
			else
				$num_letras = convertir_a_letras(($numero * 100)."/100")." céntimos";
		}
	}
	return $num_letras;
}


 $maindir = "../../";

require_once($maindir."fpdf/fpdf.php");
require($maindir."conexion/config.inc.php");

define( 'FPDF_FONTPATH', 'font/' );
require_once( 'FlowingBlockFPDF.php' );

$nombreTemporal = "KEVIN ALEXANDER VALLADARES ARGUELLO";
$numCuentaTemporal = "20070000804";
$numIdentidadTemporal = "1701-1989-00998";
$calificacion = "100 POR CIENTO(%)";
$nombreSecretario = "JORGE ALBERTO MATUTE OCHOA";
$fechaPalabras = "veintidós días del mes de julio de dos mil quince.";

if(isset($_POST["arregloHimno"]) && isset($_POST["cadena"]) && isset($_POST["arregloCodsHimno"]) && isset($_POST["fechaExp"])){
    $listaDNI = $_POST["arregloHimno"];
    
    $listaCodsHimno = $_POST["arregloCodsHimno"];
    $fechaExp = $_POST["fechaExp"];
    $codsHimno = explode(',', $listaCodsHimno);
    
    $tok = explode(',', $listaDNI);
    $tam = count($tok);
    
    $pdf = new PDF('P', 'cm', array(21.59, 33.02));
    
    $pdf->AddFont('Calibri', 'B', 'calibrib.php');
    $pdf->AddFont('Cambria', 'BI', 'cambriaz.php');
    $pdf->AddFont('Cambria', 'I', 'cambriai.php');    
    
    for($i = 0; $i < $tam; $i++){
        $statement = $db->prepare('CALL SP_OBTENER_ESTUDIANTE_CONDUCTA(?, @pcMensajeError)');
        $statement->bindValue(1, $tok[$i]);
        $statement->execute();
        $contadorFilas = $statement->rowCount();

        if($contadorFilas >= 1){
            $tabla = $statement->fetchALL(PDO::FETCH_ASSOC);
        }

        foreach($tabla as $fila){
            $nombreTemporal = mb_strtoupper($fila['NOMBRE'], 'utf-8');
            $numCuentaTemporal = $fila['CUENTA'];
            $numIdentidadTemporal = $fila['DNI'];
        }

        $fechaPalabras = $_POST['cadena'];
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $statement = $db->prepare('UPDATE sa_solicitudes SET fecha_exportacion = "'.$fechaExp.'" WHERE codigo = '.$codsHimno[$i].'');
        $statement->execute();
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $statement = $db->prepare('SELECT sa_examenes_himno.nota_himno as NOTA FROM sa_examenes_himno WHERE sa_examenes_himno.cod_solicitud = '.$codsHimno[$i]);
        $statement->execute();
        $tablaNota = $statement->fetchALL(PDO::FETCH_ASSOC);
        
        foreach($tablaNota as $filaNota){
            $calificacion = $filaNota['NOTA'];
            $nota_letras = convertir_a_letras($calificacion);
        }
        
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $pdf->AddPage();
        $pdf->Image($maindir.'assets/img/Encabezado de documentos.jpg', 0.40, 0.05, 20.96, 3.22, 'JPG');
        $pdf->Image($maindir."assets/img/Pie de documentos.jpg", 0.40, 19.1, 20.88, 13.7, 'JPG');
        $pdf->SetRightMargin(1.0);
        $pdf->SetLeftMargin(1.0);
        $pdf->SetFont('Calibri', 'B', 11);
        $pdf->Cell(0, -0.45, utf8_decode("FACULTAD DE CIENCIAS JURÍDICAS    "), 0, 0, 'R');
        $pdf->Ln(0.2);
        $pdf->SetFont('Arial', '', 10);
        $pdf->Cell(0, 0, utf8_decode("Teléfono: 2232-2290    "), 0, 1, 'R');
        $pdf->Ln(0.41);
        $pdf->Cell(0, 0, utf8_decode("Edificio A-2    "), 0, 1, 'R');
        $pdf->Ln(0.41);
        $pdf->Cell(0, 0, utf8_decode("Ciudad Universitaria    "), 0, 1, 'R');
        $pdf->Ln(0.41);
        $pdf->Cell(0, 0, utf8_decode("Tegucigalpa, Honduras    "), 0, 1, 'R');

        $pdf->ln(3.5);
        $pdf->SetFont('Cambria', 'BI', 16);
        $pdf->Cell(0, 0, utf8_decode("CONSTANCIA DE HIMNO"), 0, 1, 'C');

        $pdf->Ln(2.9);
        $pdf->SetFont('Cambria', 'I', 16);
        $pdf->SetLeftMargin(2.2);
        $pdf->SetRightMargin(2.2);

        $pdf->newFlowingBlock(17.0, 1.0, 0, 'J');
        $pdf->SetFont('Cambria', 'I', 16);
        $pdf->WriteFlowingBlock(utf8_decode('El Suscrito, Secretario de la Facultad de Ciencias Jurídicas de la Universidad Nacional '
                . 'Autónoma de Honduras, '));
        $pdf->setFont('Cambria', 'BI', 16);
        $pdf->WriteFlowingBlock(utf8_decode('HACE CONSTAR: '));
        $pdf->setFont('Cambria', 'I', 16);
        $pdf->WriteFlowingBlock(utf8_decode('Que '));
        $pdf->setFont('Cambria', 'BI', 16);
        $pdf->WriteFlowingBlock(utf8_decode($nombreTemporal));
        $pdf->setFont('Cambria', 'I', 16);
        $pdf->WriteFlowingBlock(utf8_decode(' con Número de Cuenta '));
        $pdf->setFont('Cambria', 'BI', 16);
        $pdf->WriteFlowingBlock(utf8_decode($numCuentaTemporal));
        $pdf->setFont('Cambria', 'I', 16);
        $pdf->WriteFlowingBlock(utf8_decode(' y Tarjeta de Identidad '));
        $pdf->setFont('Cambria', 'BI', 16);
        $pdf->WriteFlowingBlock(utf8_decode($numIdentidadTemporal));
        $pdf->setFont('Cambria', 'I', 16);
        $pdf->WriteFlowingBlock(utf8_decode(', ha realizado Examen del Himno Nacional de la República de Honduras, habiendo obtenido una '
                . 'calificación de  '));
        $pdf->setFont('Cambria', 'BI', 16);
        $pdf->WriteFlowingBlock(utf8_decode(strtoupper($nota_letras)).' POR CIENTO('.$calificacion.'%).');
        $pdf->finishFlowingBlock();

        $pdf->Ln(1.9);
        $pdf->SetFont('Cambria', 'I', 16);
        $pdf->SetLeftMargin(2.2);
        $pdf->SetRightMargin(2.2);

        $pdf->newFlowingBlock(17.0, 1.0, 0, 'J');
        $pdf->setFont('Cambria', 'I', 16);
        $pdf->WriteFlowingBlock(utf8_decode("En fe de lo cual, firmo la presente en la Ciudad Universitaria, Tegucigalpa, Municipio del "
                . "Distrito Central, a los ".$fechaPalabras.""));
        $pdf->finishFlowingBlock();

        $pdf->Ln(4);
        $pdf->SetFont('Cambria', 'BI', 16);
        $pdf->Cell(0,0, utf8_decode($nombreSecretario), 0 , 1, 'C');
        $pdf->Ln(0.6);
        $pdf->Cell(0,0, utf8_decode("SECRETARIO ACADÉMICO"), 0 , 1, 'C');      
        
    }
    
    $pdf->Output('ConstanciaHimnoEgresado.pdf', 'I');  
}
?>
