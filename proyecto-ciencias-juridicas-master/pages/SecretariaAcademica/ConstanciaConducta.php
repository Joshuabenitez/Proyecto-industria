<?php
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 $maindir = "../../";

//require($maindir."fpdf/makefont/makefont.php");
//MakeFont("C:\\Users\\owner\\Desktop\\cambriai.ttf", 'cp1252');

require_once($maindir."fpdf/fpdf.php");
require($maindir."conexion/config.inc.php");

define( 'FPDF_FONTPATH', 'font/' );
require_once( 'FlowingBlockFPDF.php' );

$nombreTemporal = "KEVIN ALEXANDER VALLADARES ARGUELLO";
$numCuentaTemporal = "20070000804";
$numIdentidadTemporal = "1701-1989-00998";
$anioInicio = "2010";
$anioFinal = "2010";
$fechaPalabras = 'veintiún días del mes de abril de dos mil quince.';
$nombreSecretario = "JORGE ALBERTO MATUTE OCHOA";

if(isset($_POST["arregloConducta"]) && isset($_POST["cadena"]) && isset($_POST["arregloCodsConducta"]) && isset($_POST["fechaExp"]) && isset($_POST["fechaEgresado"])){
    
    $listaDNIConducta = $_POST["arregloConducta"];
    $listaCodsConducta = $_POST["arregloCodsConducta"];
    $fechaExp = $_POST["fechaExp"];
    $anioFinal = $_POST["fechaEgresado"];
    $tok = explode(',', $listaDNIConducta);
    $codsConducta  = explode(',', $listaCodsConducta);
    
    $tam = count($tok);
    
    $pdf = new PDF('P', 'mm', array(215.9, 355.6));

    $pdf->AddFont('Calibri', 'B', 'calibrib.php');
    $pdf->AddFont('Cambria', 'BI', 'cambriaz.php');
    $pdf->AddFont('Cambria', 'I', 'cambriai.php');
    $pdf->AddFont('Cambria', 'B', 'cambriab.php');
    $pdf->AddFont('Cambria', '', 'Cambria.php');
    
    for($i = 0; $i < $tam; $i++){

        $statement = $db->prepare('CALL SP_OBTENER_ESTUDIANTE_CONDUCTA(?,@pcMensajeError)');
        $statement->bindValue(1, $tok[$i]);
        $statement->execute();
        $contadorFilas = $statement->rowCount();

        if($contadorFilas >= 1){
            $tabla = $statement->fetchAll(PDO::FETCH_ASSOC);
        }   

        foreach ($tabla as $fila){
            $nombreTemporal = mb_strtoupper($fila['NOMBRE'], 'utf-8');
            $numIdentidadTemporal = $fila['DNI'];
            $numCuentaTemporal = $fila['CUENTA'];
            $anioInicio = $fila['ANIO'];
            //$anioFinal = $fila['ANIOFINAL'];
        }

        $fechaPalabras = $_POST["cadena"];
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $statement = $db->prepare('UPDATE sa_solicitudes SET fecha_exportacion = "'.$fechaExp.'" WHERE codigo = '.$codsConducta[$i].'');
        $statement->execute();
        $statement->nextRowSet();
        $statement->closeCursor();
        
        //$statement = mysql_query('UPDATE sa_solicitudes SET fecha_exportacion = '.$fechaExp.' WHERE codigo = '.$codsConducta[$i].'', $db);
        
        $pdf->AddPage();
        $pdf->Image($maindir.'assets/img/Encabezado de documentos.jpg', 4.00, 0.50, 209.6, 32.2, 'JPG');
        $pdf->Image($maindir."assets/img/Pie de documentos.jpg", 4.00, 216, 208.8, 137, 'JPG');
        $pdf->SetRightMargin(15);
        $pdf->SetLeftMargin(15);
        $pdf->SetFont('Calibri', 'B', 11);
        $pdf->Cell(0, -4.5, utf8_decode("FACULTAD DE CIENCIAS JURÍDICAS"), 0, 0, 'R');
        $pdf->Ln(2);
        $pdf->SetFont('Arial', '', 10);
        $pdf->Cell(0, 0, utf8_decode("Teléfono: 2232-2290"), 0, 1, 'R');
        $pdf->Ln(4.1);
        $pdf->Cell(0, 0, utf8_decode("Edificio A-2"), 0, 1, 'R');
        $pdf->Ln(4.1);
        $pdf->Cell(0, 0, utf8_decode("Ciudad Universitaria"), 0, 1, 'R');
        $pdf->Ln(4.1);
        $pdf->Cell(0, 0, utf8_decode("Tegucigalpa, Honduras"), 0, 1, 'R');

        $pdf->ln(35);
        $pdf->SetFont('Cambria', 'BI', 18);
        $pdf->Cell(0, 0, utf8_decode("CONSTANCIA DE CONDUCTA"), 0, 1, 'C');


        $pdf->Ln(19);
        $pdf->SetFont('Cambria', 'I', 16);
        $pdf->SetLeftMargin(22);
        $pdf->SetRightMargin(22);

        //$nombreTemporal = "KEVIN ALEXANDER VALLADARES ARGUELLO";
        //$numCuentaTemporal = "20070000804";
        //$numIdentidadTemporal = "1701-1989-00998";
        //$añoInicio = "2010";

        $pdf->newFlowingBlock(170, 10, 0, 'J');
        $pdf->SetFont( 'Cambria', 'I', 16 );
        $pdf->WriteFlowingBlock(utf8_decode('El Suscrito, Secretario de la Facultad de Ciencias Jurídicas de la Universidad Nacional '
                . 'Autónoma de Honduras, HACE CONSTAR: '));
        $pdf->SetFont( 'Cambria', 'BI', 16 );
        $pdf->WriteFlowingBlock( utf8_decode('Que '.$nombreTemporal.' '));
        $pdf->SetFont( 'Cambria', 'I', 16 );
        $pdf->WriteFlowingBlock(utf8_decode('con Número de Cuenta '));
        $pdf->SetFont( 'Cambria', 'BI', 16 );
        $pdf->WriteFlowingBlock(utf8_decode($numCuentaTemporal.', '));
        $pdf->SetFont( 'Cambria', 'I', 16 );
        $pdf->WriteFlowingBlock(utf8_decode('y Tarjeta de Identidad '));
        $pdf->SetFont( 'Cambria', 'BI', 16 );
        $pdf->WriteFlowingBlock(utf8_decode($numIdentidadTemporal.', '));
        $pdf->SetFont( 'Cambria', 'I', 16 );
        $pdf->WriteFlowingBlock(utf8_decode('durante sus años de estudio como Alumno (a) de esta Facultad, '));
        $pdf->SetFont( 'Cambria', 'BI', 16 );
        $pdf->WriteFlowingBlock(utf8_decode('la que cursó durante los años '.$anioInicio.' al '.$anioFinal.', '));
        $pdf->SetFont( 'Cambria', 'BI', 16 );
        $pdf->WriteFlowingBlock(utf8_decode('NO RECIBIÓ SANCIÓN DISCIPLINARIA ALGUNA.'));
        $pdf->finishFlowingBlock();

        $pdf->Ln(15);
        $pdf->SetFont('Cambria', 'I', 16);
        $pdf->SetLeftMargin(22);
        $pdf->SetRightMargin(22);

        $pdf->newFlowingBlock(170, 10, 0, 'J');
        $pdf->SetFont( 'Cambria', 'I', 16 );
        $pdf->WriteFlowingBlock(utf8_decode("Y para los efectos de darle el trámite respectivo, se extiende la presente Constancia en la "
                ."Ciudad Universitaria \"José Trinidad Reyes\", a los "));
        $pdf->SetFont( 'Cambria', 'I', 16 );
        $pdf->WriteFlowingBlock(utf8_decode($fechaPalabras));
        $pdf->finishFlowingBlock();

        $pdf->Ln(40);
        $pdf->SetFont('Cambria', 'BI', 16);
        $pdf->Cell(0,0, utf8_decode($nombreSecretario), 0 , 1, 'C');
        $pdf->Ln(6);
        $pdf->Cell(0,0, utf8_decode("SECRETARIO"), 0 , 1, 'C');    
    
    }
    
    $pdf->Output('Constancia.pdf', 'I');
}

$maindir = "../../";
?>