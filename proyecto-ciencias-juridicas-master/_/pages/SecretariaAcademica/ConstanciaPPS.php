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

$nombreTemporal = "<<NOMBRE DEL ESTUDIANTE>>";
$numCuentaTemporal = "<<CUENTA DEL ESTUDIANTE>>";
$numIdentidadTemporal = "<<ID DEL ESTUDIANTE>>";
$anioInicio = "2010";
$abogado = "ERLINDA ESPERANZA FLORES FLORES";
$fechaPalabras = "<<Fecha en palabras>>";
$nombreSecretario = "JORGE ALBERTO MATUTE OCHOA";

if(isset($_POST["arregloPPS"]) && isset($_POST["cadena"]) && isset($_POST["arregloCodsPPS"]) && isset($_POST["fechaExp"])){
    $listaDNI = $_POST["arregloPPS"];
    
    $listaCodsPPS = $_POST["arregloCodsPPS"];
    $fechaExp = $_POST["fechaExp"];
    $codsPSS = explode(',', $listaCodsPPS);
    
    $tok = explode(',', $listaDNI);
    $tam = count($tok);
    
    $pdf = new PDF('P', 'cm', array(21.59, 35.56));

    $pdf->AddFont('Calibri', 'B', 'calibrib.php');
    $pdf->AddFont('Cambria', 'BI', 'cambriaz.php');
    $pdf->AddFont('Cambria', 'I', 'cambriai.php');
    
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
            $numCuentaTemporal = $fila['CUENTA'];
            $numIdentidadTemporal = $fila['DNI'];
            $anioInicio = $fila['ANIO'];
        }

        $fechaPalabras = $_POST["cadena"];
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $statement = $db->prepare('UPDATE sa_solicitudes SET fecha_exportacion = "'.$fechaExp.'" WHERE codigo = '.$codsPSS[$i].'');
        $statement->execute();
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $pdf->AddPage();
        $pdf->Image($maindir.'assets/img/Encabezado de documentos.jpg', 0.40, 0.05, 20.96, 3.22, 'JPG');
        $pdf->Image($maindir."assets/img/Pie de documentos.jpg", 0.40, 21.6, 20.88, 13.7, 'JPG');
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

        $pdf->ln(4);
        $pdf->SetFont('Cambria', 'BI', 18);
        $pdf->Cell(0, 0, utf8_decode("C E R T I F I C A C I O N"), 0, 1, 'C');

        $pdf->Ln(1.9);
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->SetLeftMargin(2.2);
        $pdf->SetRightMargin(2.2);

        $pdf->newFlowingBlock(17.0, 1.0, 0, 'J');
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode('El Suscrito, Secretario de la Facultad de Ciencias Jurídicas de la Universidad Nacional '
                . 'Autónoma de Honduras, '));
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->WriteFlowingBlock(utf8_decode('CERTIFICA: '));
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode('Que la firma de la Abogada '));
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->WriteFlowingBlock(utf8_decode($abogado));
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode(', puesta en su condición de Directora del Consultorio Jurídico Gratuito dependiente de '
                . 'la Facultad de Ciencias Jurídicas de la UNAH, '));
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->WriteFlowingBlock(utf8_decode('en la Constancia de Práctica Profesional Supervisada, '));
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode('expedida a favor de '));
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->WriteFlowingBlock(utf8_decode($nombreTemporal));
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode(', con número de Cuenta '));
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->WriteFlowingBlock(utf8_decode($numCuentaTemporal));
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode(', es AUTENTICA por ser la que usa la Abogada Flores Flores en todos los Actos en los que '
                . 'interviene como tal.'));

        $pdf->finishFlowingBlock();

        $pdf->Ln(1.9);
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->SetLeftMargin(2.2);
        $pdf->SetRightMargin(2.2);

        $pdf->newFlowingBlock(17.0, 1.0, 0, 'J');
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode('En fe de lo cual firmo la presente '));
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->WriteFlowingBlock(utf8_decode('CERTIFICACIÓN '));
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->WriteFlowingBlock(utf8_decode('en la Ciudad Universitaria, Tegucigalpa, Municipio del Distrito Central, a los '.$fechaPalabras).'.');
        $pdf->finishFlowingBlock();

        $pdf->Ln(3);
        $pdf->SetFont('Cambria', 'BI', 16);
        $pdf->Cell(0,0, utf8_decode($nombreSecretario), 0 , 1, 'C');
        $pdf->Ln(0.6);
        $pdf->Cell(0,0, utf8_decode("SECRETARIO"), 0 , 1, 'C');        
    }
    
    $pdf->Output('Constancia PPS.pdf','I');
}
?>
