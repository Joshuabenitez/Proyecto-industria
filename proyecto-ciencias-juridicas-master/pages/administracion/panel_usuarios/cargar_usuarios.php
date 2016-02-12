
<!---INFORMACION DE LA PAGINA- -->


<?php


// <!-- Declaramos la direccion raiz -->
   $maindir = "../../";

// <!-- anadimos los archivos necesarios para trabajar-->

  if(!isset($_SESSION['auntentificado']) ) {
      header("location: ../../../login/login.php?error_code=2");
  }
  //acceso a bases de datos
  include ($maindir.'conexion/config.inc.php');
  ?>

  <section >
    <!-- <h3 class="box-title" style = "color:black"></h3> -->


     <div class="box-body table-responsive ">
       <table id = "tabla_usuarios" class='table table-bordered table-striped display' cellspacing="0" >
          <thead >
            <tr style="background-color: rgb(71, 58, 147);" >
              <th style= "color: white">Usuario</th>
              <th style= "color: white">Rol</th>
              <th style= "color: white">Fecha Creacion</th>
              <th style= "color: white">Conectado</th>
              <th style= "color: white">Estado</th>
              <th style= "color: white">Editar</th>
            </tr>
          </thead>
          <tbody>
          <?php
          //ejecutamos la consulta con ayuda del archivo conexion.php que se encuentra arriba
            $query  = $db->prepare("SELECT usuario.Logeado, usuario.usuario, usuario.usuario_ID, usuario.rol_ID, usuario.fecha_creacion, usuario.estado, rol.rol_ID, rol.descripcion FROM usuario INNER JOIN rol ON usuario.rol_ID = rol.rol_ID");
            $query->execute();
            $result1 = $query->fetchAll();
              foreach($result1 as $row)
              {
               $estado = $row['estado'];
               $Logueado = $row['Logeado'];
               echo "<tr>
                       <td><center> $row[usuario] </td></center>
                       <td><center> $row[descripcion] </td></center>
                       <td><center> $row[fecha_creacion]</td></center>";
                       if ($Logueado == 0) {
                         echo"
                           <td><center>
                              <label href=\"#\" class = \"\">Desconectado</label>
                           </td></center>";

                       }
                       else{
                        echo"

                           <td><center>
                              <label href=\"#\" class = \"label label-success\">Conectado</label>
                           </td></center>";
                       }
                        if ($estado == 0) {
                         echo"
                           <td><center>
                              <label href=\"#\" class = \"label label-warning\">Inactivo</label>
                           </td></center>";

                       }
                       else{
                        echo"

                           <td><Center>
                              <label href=\"#\" class = \"label label-primary \">Activo</label>
                           </td></center>";
                       }
                       echo"
                       <td><center>
                          <button data-id = \"$row[usuario_ID]\" href=\"#\" class = \"btn_editar btn btn-info\" id = \"editar\" data-toggle=\"modal\" data-target = \"#modal_editar_usuario\"><i class=\"glyphicon glyphicon-edit\"></i></button>
                        </td></center>
                    </tr>";
              }
          ?>
          </tbody>
      </table>
    </div>
    <!-- fin tabla -->

  </section>


<!-- modal para modificar datos del usuario -->
<!-- ===============MODAL PARA EDITAR LA INFORMACION DEL USUARIO -->
<!-- Modal nuevo_usuario-->
<div class="modal fade" id="modal_editar_usuario" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"><i class="glyphicon glyphicon-floppy-disk"></i> Editar Datos de Usuario </h4>
      </div>
      <div class="modal-body">
        <!-- aqui se cargar el form actualizado con los datos del usuario a modificar -->
      </div>
      
  </div>
</div>
</div>

    <!-- fin modal nuevo usuario-->



<script type="text/javascript" charset="utf-8">
  $(document).ready(function() {
    // stilos de los switches
    $("[name='checkbox_tabla']").bootstrapSwitch();

		$(".btn_editar").on('click',function(){


          id = $(this).data('id');
          // alert('id='+id);
		   $.get('pages/administracion/panel_usuarios/modal_editar_usuario.php?usuario_ID=' + id, function(html){
                 $('#modal_editar_usuario .modal-body').html(html);
                 $('#modal_editar_usuario').modal('show', {backdrop: 'static'});
		    });
        });
		 // example es el id de la tabla
		    $('#tabla_usuarios').dataTable();

      });
</script>
