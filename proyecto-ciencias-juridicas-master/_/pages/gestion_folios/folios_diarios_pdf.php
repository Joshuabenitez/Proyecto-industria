<?php

 $maindir = "../../";

require_once($maindir."fpdf/fpdf.php");
require($maindir."conexion/config.inc.php");

$sql = "SELECT * FROM ( SELECT folios.NroFolio, folios.PersonaReferente, unidad_academica.NombreUnidadAcademica AS ENTIDAD, 
                         DATE(folios.FechaEntrada) as FechaEntrada, folios.FechaEntrada as Fecha, folios.TipoFolio FROM folios INNER JOIN unidad_academica ON folios.UnidadAcademica = unidad_academica.Id_UnidadAcademica 
                         UNION SELECT folios.NroFolio, folios.PersonaReferente, organizacion.NombreOrganizacion AS ENTIDAD, 
                         DATE(folios.FechaEntrada) as FechaEntrada, folios.FechaEntrada as Fecha ,folios.TipoFolio FROM folios INNER JOIN organizacion ON folios.Organizacion = organizacion.Id_Organizacion ) T1 
                        where DATE(FechaEntrada)=CURDATE() ORDER BY Fecha DESC";

    $query = $db->prepare($sql);
	//$query ->bindParam(":Id_Seguimiento",$Id_Seguimiento);
    $query->execute();
    $rows = $query->fetchAll();

$pdf = new FPDF();

$pdf->AddPage();
$pdf->SetFont('Arial', '', 18);
$pdf->Image($maindir.'assets/img/lucen-aspicio.png', 50,30,200,200, 'PNG');
$pdf->Image($maindir.'assets/img/logo_unah.png' , 10,5,20,35, 'PNG');
$pdf->Image($maindir.'assets/img/logo-cienciasjuridicas.png' , 170,8, 35 , 35,'PNG');
$pdf->Cell(18, 10, '', 0);
$pdf->SetFont('Arial', '', 18);
$pdf->Cell(5, 10, '', 0);
$pdf->Cell(143, 10, utf8_decode("Universidad Nacional Autónoma de Honduras"), 0, 0, "C");
$pdf->Ln(25);
$pdf->SetFont('Arial', 'U', 14);
$pdf->Cell(30, 8, ' ', 0,0,"C");
$pdf->Cell(133, 8, utf8_decode("Reporte de Folios Diarios"), 0,0,"C");

$pdf->SetFont('Arial', '', 12);
$pdf->Ln(10);
$pdf->Cell(190, 8, 'Fecha: '.date('Y-m-d'), 1);
$pdf->Ln(10);
$pdf->SetFont('Arial', 'B', 8);
$pdf->Cell(20, 8, utf8_decode("No. de Folio"), 1,0,"C");
$pdf->Cell(60, 8, utf8_decode("Persona Referente"), 1,0,"C");
$pdf->Cell(50, 8, utf8_decode("Unidad académica u Organización"), 1,0,"C");
$pdf->Cell(30, 8, utf8_decode("Fecha de Entrada"), 1,0,"C");
$pdf->Cell(30, 8, utf8_decode("Tipo de Folio"), 1,0,"C");
$pdf->Ln(8);
$pdf->SetFont('Arial', '', 8);

$NroFolio=array();
$PersonaReferente=array();
$Unidadacadémica =array();
$FechadeEntrada=array();
$TipodeFolio=array();
$numeroMayor=array();

function array_ref(&$arreglo,$cadena,$limite) {
    $limite=$limite-10;
    $contador=0;
  if (strlen($cadena)<$limite)
   {
      $arreglo[$contador]=$cadena;
   }
  else {

    while ( strlen($cadena)>$limite) {
        $cadena2=substr($cadena,0,$limite);
        $arreglo[$contador]=$cadena2;
        $contador=$contador+1;
        $cadena3=substr($cadena,$limite-1,strlen($cadena));
        $cadena=$cadena3;
        if (strlen($cadena)< $limite) {
            
            $arreglo[$contador]=$cadena;
            $cadena="";
        }
    }
      
  }
}


foreach( $rows as $row ){
  if($row['TipoFolio'] == 0){
  $tipo = "Folio de entrada";
    }elseif($row['TipoFolio'] == 1){
    $tipo = "Folio de salida";
    }
     



array_ref($NroFolio,$row["NroFolio"],20);
array_ref($PersonaReferente,$row["PersonaReferente"],60);
array_ref($Unidadacadémica,$row["ENTIDAD"],50);
array_ref($FechadeEntrada,$row["FechaEntrada"],30);
array_ref($TipodeFolio,$tipo,30);
$numeroMayor[1]=count($NroFolio);
$numeroMayor[2]=count($PersonaReferente);
$numeroMayor[3]=count($Unidadacadémica);
$numeroMayor[4]=count($TipodeFolio);
$n= max($numeroMayor);

$contador=0;
while ( $contador<$n) {

  if ($contador==$n-1)
   {

     if($contador<count($NroFolio))
        {
            $pdf->Cell(20, 8, utf8_decode($NroFolio[$contador]), "L,R,B",0,"C");
        }
     else
        {
            $pdf->Cell(20, 8, utf8_decode(" "), "L,R,B",0,"C");
        }
  if($contador<count($PersonaReferente))
        {
            $pdf->Cell(60, 8, utf8_decode($PersonaReferente[$contador]), "L,R,B",0,"C");
        }
  else
       {
            $pdf->Cell(60, 8, utf8_decode(""), "L,R,B",0,"C");
    
       }
  if($contador<count($Unidadacadémica))
       {
        $pdf->Cell(50, 8, utf8_decode($Unidadacadémica[$contador]), "L,R,B",0,"C");
       }
 else
 {
   $pdf->Cell(50, 8, utf8_decode(""), "L,R,B",0,"C");
 }
 if($contador<count($FechadeEntrada))
 {
   $pdf->Cell(30, 8, utf8_decode($FechadeEntrada[$contador]), "L,R,B",0,"C");
 }
 else
 {
   $pdf->Cell(30, 8, utf8_decode(""), "L,R,B",0,"C");
    

 }
 if($contador<count($TipodeFolio))
 {
   $pdf->Cell(30, 8, utf8_decode($TipodeFolio[$contador]), "L,R,B",0,"C");
   

 }
 else
 {
   $pdf->Cell(30, 8, utf8_decode(""), "L,R,B",0,"C");
    

 }
    
  } else {

  if($contador<count($NroFolio))
 {
   $pdf->Cell(20, 8, utf8_decode($NroFolio[$contador]), "L,R",0,"C");
 }
 else
 {
   $pdf->Cell(20, 8, utf8_decode(" "), "L,R",0,"C");
  }
  if($contador<count($PersonaReferente))
 {
   $pdf->Cell(60, 8, utf8_decode($PersonaReferente[$contador]), "L,R",0,"C");
   

 }
 else
 {
   $pdf->Cell(60, 8, utf8_decode(""), "L,R",0,"C");
    

 }
  if($contador<count($Unidadacadémica))
 {
   $pdf->Cell(50, 8, utf8_decode($Unidadacadémica[$contador]), "L,R",0,"C");
   

 }
 else
 {
   $pdf->Cell(50, 8, utf8_decode(""), "L,R",0,"C");
    

 }
 if($contador<count($FechadeEntrada))
 {
   $pdf->Cell(30, 8, utf8_decode($FechadeEntrada[$contador]), "L,R",0,"C");
   

 }
 else
 {
   $pdf->Cell(30, 8, utf8_decode(""), "L,R",0,"C");
    

 }
 if($contador<count($TipodeFolio))
 {
   $pdf->Cell(30, 8, utf8_decode($TipodeFolio[$contador]), "L,R",0,"C");
   

 }
 else
 {
   $pdf->Cell(30, 8, utf8_decode(""), "L,R",0,"C");
    

 }

 }
  
  

 

$pdf->Ln();
$contador=$contador+1;

}




  }



 



$pdf->SetFont('Arial', '', 10);


$pdf->Output('reporte.pdf','I');

?>