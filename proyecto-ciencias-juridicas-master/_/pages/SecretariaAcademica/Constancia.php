<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 $maindir = "../../";
 
require_once($maindir."fpdf/fpdf.php");
require($maindir."conexion/config.inc.php");

define( 'FPDF_FONTPATH', 'font/' );
require_once( 'FlowingBlockFPDF.php' );

$nombreTemporal = "KEVIN ALEXANDER VALLADARES ARGUELLO";
$numCuentaTemporal = "20070000804";
$numIdentidadTemporal = "1701-1989-00998";
$planEstudio = "Plan de Estudio Nuevo";
//$cadenaPlanEstudio = "(".$planEstudio.")";
$orientacion = "Derecho Penal";
//$cadenaOrientacion = ", con orientación en ".$orientacion."";
$fechaPalabras = 'veintiún días del mes de abril de dos mil quince.';
$nombreSecretario = "JORGE ALBERTO MATUTE OCHOA";

if(isset($_POST['arregloConstancia']) && isset($_POST['cadena']) && isset($_POST["arregloCodsConstancia"]) && isset($_POST["fechaExp"])){
    $listaDNIConstancia = $_POST['arregloConstancia'];
    
    $listaCodsConstancias = $_POST["arregloCodsConstancia"];
    $fechaExp = $_POST["fechaExp"];
    $codsConstancias = explode(',', $listaCodsConstancias);
    
    $tok = explode(',', $listaDNIConstancia);
    $tam = count($tok);
    
    $pdf = new PDF('P', 'mm', array(215.9, 330.2));
    $pdf->AddFont('Calibri', 'B', 'calibrib.php');
    $pdf->AddFont('Cambria', 'BI', 'cambriaz.php');
    $pdf->AddFont('Cambria', 'I', 'cambriai.php');
    $pdf->AddFont('Cambria', 'B', 'cambriab.php');
    $pdf->AddFont('Cambria', '', 'Cambria.php');    
    
    for($i = 0; $i < $tam; $i++){        
        $statement = $db->prepare('CALL SP_OBTENER_ESTUDIANTE_CONSTANCIA(?,@pcMensajeError)');
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
            $planEstudio = $fila['PLANESTUDIO'];
            $orientacion = $fila['ORIENTACION'];
        }
        
        $cadenaOrientacion = ", con orientación en ".$orientacion."";
        $cadenaPlanEstudio = "(".$planEstudio.")";
        $fechaPalabras = $_POST["cadena"];
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $statement = $db->prepare('UPDATE sa_solicitudes SET fecha_exportacion = "'.$fechaExp.'" WHERE codigo = '.$codsConstancias[$i].'');
        $statement->execute();
        $statement->nextRowSet();
        $statement->closeCursor();
        
        $pdf->AddPage();
        $pdf->Image($maindir.'assets/img/Encabezado constancias.jpg', 20.00, 7, 176, 33.2, 'JPG');

        $pdf->ln(65);
        $pdf->SetFont('Cambria', 'BI', 16);
        $pdf->SetLeftMargin(22);
        $pdf->SetRightMargin(22);
        $pdf->Cell(0, 0, utf8_decode("C O N S T A N C I A"), 0, 1, 'C');

        //Definir la siguente cadena
        //$cadenaOrientacion = "";

        $pdf->Ln(19);
        $pdf->SetFont('Cambria', 'I', 16);
        $pdf->SetLeftMargin(22);
        $pdf->SetRightMargin(22);

        $pdf->newFlowingBlock(170, 10, 0, 'J');
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('El Suscrito, Secretario de la Facultad de Ciencias Jurídicas de la Universidad Nacional '
                . 'Autónoma de Honduras, por medio de la presente HACE CONSTAR: '));
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('Que el(la) alumno(a)'));
        $pdf->SetFont( 'Cambria', 'BI', 14 );
        $pdf->WriteFlowingBlock( utf8_decode(' '.$nombreTemporal.' '));
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('con Número de Cuenta '));
        $pdf->SetFont( 'Cambria', 'BI', 14 );
        $pdf->WriteFlowingBlock(utf8_decode($numCuentaTemporal.', '));
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('cursa el '));
        $pdf->SetFont( 'Cambria', 'BI', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('ULTIMO AÑO '));
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('de la '));
        $pdf->SetFont( 'Cambria', 'BI', 14 );
        $pdf->WriteFlowingBlock(utf8_decode('Carrera de DERECHO'));
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode(' '.$cadenaPlanEstudio.''.$cadenaOrientacion.';  en consecuencia puede acogerse a lo dispuesto '
                . 'en el Artículo 12, Párrafo Segundo Ley Orgánica del Colegio de Abogados de Honduras.'));
        $pdf->finishFlowingBlock();

        $pdf->Ln(15);
        $pdf->SetFont('Cambria', 'I', 14);
        $pdf->SetLeftMargin(22);
        $pdf->SetRightMargin(22);

        $pdf->newFlowingBlock(170, 10, 0, 'J');
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode("En fe de lo cual, firmo la presente en la "
                ."Ciudad Universitaria, \"José Trinidad Reyes\", a los "));
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->WriteFlowingBlock(utf8_decode($fechaPalabras));
        $pdf->finishFlowingBlock();

        $pdf->Ln(40);
        $pdf->SetFont('Cambria', 'BI', 14);
        $pdf->Cell(0,0, utf8_decode($nombreSecretario), 0 , 1, 'C');
        $pdf->Ln(6);
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->Cell(0,0, utf8_decode("SECRETARIO ACADÉMICO"), 0 , 1, 'C');
        $pdf->ln(6);
        $pdf->SetFont( 'Cambria', 'I', 14 );
        $pdf->Cell(0,0, utf8_decode("FACULTAD DE CIENCIAS JURÍDICAS"), 0 , 1, 'C');
    }
    
    $pdf->Output('Constancias', 'I');
}
?>