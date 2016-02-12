<?php 

  if(!isset( $_SESSION['user_id'] ))
  {
    header('Location: '.$maindir.'login/logout.php?code=100');
    exit();
  }
  else
  {
	$user = $_SESSION['nombreUsuario'];
	$rol = $_SESSION['user_rol']; 
  }

?>

<div class="navbar navbar-default" id="subnav">
    <div class="col-md-12">

        <div class="collapse navbar-collapse" id="navbar-collapse2">
          <ul class="nav navbar-nav navbar-left">
            <!--
            <li class="active"><a href="javascript:ajax_('home.php');">Inicio</a></li>
            <li><a role="button" href="javascript:void(0)" >Modulo 1</a></li>
            <li><a role="button" href="javascript:void(0)" >Gestión de proyectos</a></li>
            <li><a role="button" href="javascript:void(0)" >Recursos humanos</a></li>
            <li><a role="button" href="javascript:ajax_('gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios');">Gestión de folios</a></li>
            -->
<?php

             // Revisa si es la pagina de inicio o cualquier otra pagina
             // pagina de inicio
            if($contenido == 'home') 
              {
                  $url = 'home.php';
                  echo <<<HTML
                <li class="active"><a role='button' id="home" href="javascript:ajax_('$url')" >Inicio</a></li>
HTML;
              }
            else
              {
                $url = 'home.php';
                echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Inicio</a></li>
HTML;
              }

      if($rol >= 10){
             // pagina del modulo de gestion de folios
            

        if($contenido == 'home') 
              {
                if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                         $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
                }
                
                $url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class=""><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>

HTML;
if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


                }
                $url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class=""><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>
HTML;
if($rol==30 ||$rol==100 ||$rol==50 ){
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;

}

if($rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}


}


if($contenido == 'gestion_de_folios'){
  if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                         $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
                }
$url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class=""><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>
HTML;
if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


                }
                $url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class="active"><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>
HTML;
if($rol==30 || $rol==100 || $rol==50){
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;
}
if($rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li class><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}
              }


if($contenido == 'permisos') {
if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                         $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
                }
                $url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class="active"><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>

HTML;
if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


                }
$url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class=""><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>


HTML;
if($rol==30 || $rol==100 || $rol==50){
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;
}
if( $rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li class><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}


 
              }


 if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                       if($contenido == 'poa'){
                             $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li class="active"><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
             $url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class=""><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>

HTML;
if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


                }
                $url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class=""><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>
HTML;
if($rol==30 || $rol==100 || $rol==50){
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;
}
if( $rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li class><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}

                       }
                }


if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
      if($contenido == 'recursos_humanos'){
                if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                         $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
                }
                
                $url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class=""><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>

HTML;

 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li class="active"><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


              
                $url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class=""><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>
HTML;
if($rol==30 || $rol==100 || $rol==50){
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;
}
if($rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li class><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}

      }


                }

if($rol==30 || $rol==100 || $rol==50){
   if($contenido == 'carga_academica'){
     if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                         $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
                }
                
                $url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class=""><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>

HTML;

if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


                }
       $url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class=""><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>
HTML;
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li class="active"><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;
if($rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li class><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}
}
}
if($rol==100 || $rol==45){
   if($contenido == 'secretaria_academica') {
if($rol==20 || $rol == 30 || $rol == 100 || $rol == 50){
                         $url = 'pages/principal.php?contenido=poa';
                echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">POA</a></li>
HTML;
                }
                
                $url = 'pages/permisos/permisos_principal.php?contenido=permisos';
                echo <<<HTML
                <li class=""><a role="button" href="javascript:ajax_('$url');">Permisos</a></li>

HTML;


              
                $url = 'pages/gestion_folios/gestion_de_folios.php?contenido=gestion_de_folios';
                echo <<<HTML
                <li class=""><a role="button" id="gestion_de_folios" href="javascript:ajax_('$url')" >Gestion de folios</a></li>
HTML;
if($rol == 100 || $rol == 50 || $rol == 40 || $rol == 45){
 $url = 'pages/recursos_humanos/recursos_humanos.php?contenido=recursos_humanos';
          echo <<<HTML
                <li><a role="button" href="javascript:ajax_('$url');">Recursos humanos</a></li>

HTML;


                }
if($rol==30 ||$rol==100 ||$rol==50 ){
   $url = 'pages/CargaAcademica/CargaAcademica.php?contenido=carga_academica';
                  echo <<<HTML
                <li><a role='button' id="home" href="javascript:ajax_('$url')" >Carga Académica</a></li>
HTML;

}

if($rol==100 || $rol==45){
    $url = 'pages/SecretariaAcademica/SecretariaAcademica.php?contenido=secretaria_academica';
                  echo <<<HTML
                <li class="active"><a role='button' id="home" href="javascript:ajax_('$url')" >Secretaría Académica</a></li>
HTML;
}
}
}






        }
            
?>

           </ul>
        </div>  
     </div> 
</div>
