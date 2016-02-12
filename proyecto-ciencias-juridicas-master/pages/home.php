 <?php

  if(isset($_GET['contenido']))
    {
      $contenido = $_GET['contenido'];
    }
  else
    {
      $contenido = 'home';
    }


  require_once("navbar.php");

?>

<!-- Main -->
<div class="container-fluid">
<div class="row">
   
    
        <div class="col-md-12">
      
    
            <img class="" src="img/home3.png" style = "margin:0px;" height="80%" width = "100%" >
            
          
      </div>
      </div>

</div>


   <script>
        // $.backstretch("../img/home3.pmg", {speed: 800});
  </script>

<!-- /Main -->
