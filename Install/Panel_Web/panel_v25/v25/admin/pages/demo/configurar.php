<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}


  
?>
 <!-- jQuery 2.2.3 -->
 <script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
 <!-- Bootstrap 3.3.6 -->
 <script src="../../bootstrap/js/bootstrap.min.js"></script>
 <!-- DataTables -->
 <script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
 <script src="../../plugins/datatables/dataTables.bootstrap.min.js"></script>
 <script>
  $(document).ready(function(){
    $("#myInput").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });
  });
</script>
<!-- ##### inicio pegar IP #####-->
<?php
      // create a new cURL resource
      $ch = curl_init ();

      // set URL and other appropriate options
      curl_setopt ($ch, CURLOPT_URL, "http://ipecho.net/plain");
      curl_setopt ($ch, CURLOPT_HEADER, 0);
      curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);

      // grab URL and pass it to the browser

      $ip = curl_exec ($ch);
      #echo "The public ip for this server is: $ip";
      // close cURL resource, and free up system resources
      curl_close ($ch);
    ?>
<!-- ##### fim pegar IP #####-->
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
            <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
                <center><h5><i class="fas fa-exclamation-triangle" ></i> OBS: o cadastro so e valido se o admin, liberar um servidor, com a quantidade de dias, 0 dias desativa o cadastro</center>
            </div>
  <div class="row">
    <div class="col-lg-12">
      <div class="card card-outline-warning">
        <div class="card-header">
          <h4 class="m-b-0 text-white"><i class="fas fa-wrench"></i> Liberar Cadastro</h4>
        </div>

<section class="content">
      <div class="row">
        <!-- left column -->
        <div class="col-md-6">
          <!-- general form elements -->
          <div class="box box-primary">
            <div class="box-header with-border">
              
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form" action="pages/demo/configurar_exe.php" method="post">
              <div class="box-body">
			   
			   <div class="form-group">
			   <center> <p class="text-info m-l-5"><b>Selecione um servidor Para Cadastro</b></p></center>
                
                <center> <select class="form-control select2" style="width: 100%;"  name="servidor" id="servidor"> </center> 
                  
                  <?php
    
	
   
	$SQLAcessoSRV = "SELECT * FROM servidor WHERE  demo='1' LIMIT 1";
    $SQLAcessoSRV = $conn->prepare($SQLAcessoSRV);
    $SQLAcessoSRV->execute();
   

if (($SQLAcessoSRV->rowCount()) > 0) {
    // output data of each row
   $row_srv_principal = $SQLAcessoSRV->fetch();
		
		?>
        
	<option value="<?php echo $row_srv_principal['id_servidor'];?>" > <?php echo $row_srv_principal['nome'];?> - <?php echo $row_srv_principal['ip_servidor'];?> </option>
	
   <?php 
}

	
	$SQLAcessoSRV = "SELECT * FROM servidor WHERE   demo='0' ";
    $SQLAcessoSRV = $conn->prepare($SQLAcessoSRV);
    $SQLAcessoSRV->execute();
	

if (($SQLAcessoSRV->rowCount()) > 0) {
    // output data of each row
    while($row_srv = $SQLAcessoSRV->fetch()) {
		
		?>
        
	<option value="<?php echo $row_srv['id_servidor'];?>" > <?php echo $row_srv['nome'];?> - <?php echo $row_srv['ip_servidor'];?> </option>
	
   <?php }
}

?>
				  
				  
                </select>
              </div>
			  
              
				
				<div class="form-group">
				<center> <b class="text-info m-l-5"><b>Validade em dias </b></center>
				<center> <b class="text-info m-l-5"><b>Por cada conta Criada </b></center>
                
                  <input required="required" type="number" class="form-control" id="dias_demo" name="dias_demo" placeholder="Digite a quantidade de dias " value="<?php echo $row_srv_principal['dias'];?>" >
                </div>
				
				
       
        <td >

				
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary">Salvar</button>
				<br/>
				
              </div>
			  <div class="box-footer">
                <b></b>
				<br/>
				
              </div>
			  
            </form>
          </div>
          <!-- /.box -->
</tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>