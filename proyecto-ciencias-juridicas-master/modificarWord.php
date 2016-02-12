<?php

$rootAddress = '';

require_once("phpword/PHPWord.php");

$dias = array("Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sábado");
$meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
       

$fecha = date('d') . 'días del mes de '.  $meses[date('n')-1]. " del ".date('Y') ;

$word = new PHPWord();
$template = $word->loadTemplate($rootAddress . 'plantillas/PARA PPS.docx');
$template->setValue('${NOMBRE_ESTUDIANTE}', 'Luis Manuel Deras');
$template->setValue('${NUMERO_CUENTA}', '20112001640');
$template->setValue('${FECHA}', $fecha);

$template->save('test3.docx');   