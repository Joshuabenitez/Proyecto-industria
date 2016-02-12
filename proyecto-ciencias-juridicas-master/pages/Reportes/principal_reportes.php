 <?php

  if(isset($_GET['contenido']))
    {
      $contenido = $_GET['contenido'];
    }
  else
    {
      $contenido = 'reportes';
    }
	
 require_once("../navbar.php");

 

?>

<!-- Main -->
<div class="container-fluid" >
<div class="row">
    <div class="col-sm-12">
        
       <div class="row">
        <div class="col-md-12">
          <div class="featurette">

			 <img class="featurette-image  pull-left" src="img/angel.png">
			<div class="alert alert-danger"><h1>Esta es la Seccion de Esta es de Reportes</h1></div>
           
          </div>
        </div>
      </div>
    </div><!--/col-span-9-->     
</div>
</div>

  <script>
       
    </script>
<!-- /Main -->