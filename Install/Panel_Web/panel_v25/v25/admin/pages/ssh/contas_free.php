<?php
	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

if(isset($_GET['deletar'])){

$idssh=sql_injector($_GET['deletar']);

//Carrega usuarioSSH
                $SQLUsuarioSSH = "select * from usuario_ssh_free WHERE id = '".$idssh."'";
                $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                $SQLUsuarioSSH->execute();
                $usuario_ssh = $SQLUsuarioSSH->fetch();

                if($SQLUsuarioSSH->rowCount()==0){
						echo '<script type="text/javascript">';
		                echo 	'alert("Esse usuario não existe!");';
		            	echo	'window.location="?page=ssh/contas_free";';
		             	echo '</script>';
		            	exit;

				}

			$SQLUsuarioserver = "select * from servidor WHERE id_servidor = '".$usuario_ssh['servidor']."'";
            $SQLUsuarioserver = $conn->prepare($SQLUsuarioserver);
            $SQLUsuarioserver->execute();

             if($SQLUsuarioserver->rowCount()==0){
						echo '<script type="text/javascript">';
		                echo 	'alert("Servidor não encontrado!");';
		            	echo	'window.location="?page=ssh/contas_free";';
		             	echo '</script>';
		            	exit;

				}

	         $server=$SQLUsuarioserver->fetch();

			//Realiza a comunicacao com o servidor
			$ip_servidor= $server['ip_servidor'];
		    $loginSSH= $server['login_server'];
			$senhaSSH=  $server['senha'];
			$ssh = new SSH2($ip_servidor);
			$ssh->auth($loginSSH,$senhaSSH);

			$ssh->exec("./remover.sh ".$usuario_ssh['login']." ");
		    $mensagem = (string) $ssh->output();

            $SQLSSHfinal = "delete  from usuario_ssh_free  WHERE id = '".$usuario_ssh['id']."'  ";
            $SQLSSHfinal = $conn->prepare($SQLSSHfinal);
            $SQLSSHfinal->execute();

            echo '<script type="text/javascript">';
		    echo 	'alert("Conta SSH Removida!");';
		    echo	'window.location="?page=ssh/contas_free";';
		    echo '</script>';

}

        //carrega qtd de servidores free
		$SQLServidorfree = "SELECT * FROM servidor where tipo='free' ";
        $SQLServidorfree = $conn->prepare($SQLServidorfree);
        $SQLServidorfree->execute();
        $servidor_qtd_free = $SQLServidorfree->rowCount();

        //Total de Contas SSH Free
        $SQLContasSSH_free = "SELECT * FROM usuario_ssh_free ";
        $SQLContasSSH_free = $conn->prepare($SQLContasSSH_free);
        $SQLContasSSH_free->execute();
        $contas_ssh_free = $SQLContasSSH_free->rowCount();

        //Total de Contas SSH Free Vencidas
        $SQLContasSSH_free_venc = "SELECT * FROM usuario_ssh_free where validade<='".date('Y-m-d H:i:s')."'";
        $SQLContasSSH_free_venc = $conn->prepare($SQLContasSSH_free_venc);
        $SQLContasSSH_free_venc->execute();
        $contas_ssh_free_venc = $SQLContasSSH_free_venc->rowCount();

        //Total de Contas SSH Free Online

        $total_acesso_ssh_online_free = 0;
	    $SQLAcessoSSH_free = "SELECT sum(online) AS quantidade  FROM usuario_ssh_free  ";
        $SQLAcessoSSH_free = $conn->prepare($SQLAcessoSSH_free);
        $SQLAcessoSSH_free->execute();
		$SQLAcessoSSH_free = $SQLAcessoSSH_free->fetch();
        $total_acesso_ssh_online_free += $SQLAcessoSSH_free['quantidade'];

?>
<!-- jQuery 2.2.3 -->
<script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../../plugins/datatables/dataTables.bootstrap.min.js"></script>
<script>
  $(function () {
  $('#example1').DataTable({
    "language": {
        "sProcessing":    "Processando...",
        "sLengthMenu":    "Mostrar _MENU_ registros",
        "sZeroRecords":   "Não foram encontrados resultados",
        "sEmptyTable":    "Nenhum dado disponivel",
        "sInfo":          "Mostrando de _START_ até _END_ de _TOTAL_ registros",
        "sInfoEmpty":     "Mostrando de 0 até 0 de 0 registos",
        "sInfoFiltered":  "(filtrado de _MAX_ registos no total)",
        "sInfoPostFix":   "",
        "sSearch":        "Procurar:",
        "sUrl":           "",
        "sInfoThousands":  ",",
        "sSearchPlaceholder": "Procure a conta",
        "sLoadingRecords": "A carregar dados...",
        "oPaginate": {
            "sFirst":    "Primeiro",
            "sLast":    "Último",
            "sNext":    "Seguinte",
            "sPrevious": "Anterior"
        },
        "oAria": {
            "sSortAscending":  ": Clique para ordenar ascendente (ASC)",
            "sSortDescending": ": Clique para ordenar descendente (DESC)"
        }
    }
});
  responsive: true
  });
function buscar(){
var oTable = $('#example1').dataTable();
oTable.fnFilter( $('#txt').val());
$('html, body').animate({
scrollTop: 160
}, 1000, 'linear');
}
function buscar2(){
var oTable = $('#example1').dataTable();
oTable.fnFilter( $('#txt2').val());
$('html, body').animate({
scrollTop: 160
}, 1000, 'linear');
}
</script>
<input id="txt" type="hidden" value="vencido">
<input id="txt2" type="hidden" value="">
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="row page-titles">
                    <div class="col-md-5 col-8 align-self-center">
                        <h3 class="text-themecolor">SSH<b>PLUS</b></h3>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.php">Início</a></li>
                            <li class="breadcrumb-item active">Listar Free</li>
                        </ol>
                    </div>
                </div>

<section class="content">
<div class="row">
<!-- Onlines -->
<div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-blue">
            <div class="inner">
              <h3><?php echo $total_acesso_ssh_online_free;?></h3>

              <p>Online</p>
            </div>
            <div class="icon">
              <i class="ion ion-ios-timer-outline"></i>
            </div>
            <a href="home.php?page=ssh/online_free" class="small-box-footer">
              Mais informações <i class="fa fa-arrow-circle-right"></i>
            </a>
          </div>
        </div>

<!-- Servidores -->
<!-- inicia o box de cada coisa -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3><?php echo $servidor_qtd_free; ?></h3>

              <p>Servidores Free</p>
            </div>
            <div class="icon">
              <i class="fa fa-server"></i>
            </div>
            <a href="home.php?page=servidor/listar" class="small-box-footer">
              Mais informações <i class="fa fa-arrow-circle-right"></i>
            </a>
          </div>
        </div>
         <!-- fim -->

        <!-- Contas SSH -->
 <!-- inicia o box de cada coisa -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3><?php echo $contas_ssh_free;?></h3>

              <p>Contas SSH FREE Criadas</p>
            </div>
            <div class="icon">
              <i class="fa fa-globe"></i>
            </div>
            <a onclick="buscar2();" style="cursor:pointer;"  class="small-box-footer">
              Mais informações <i class="fa fa-arrow-circle-right"></i>
            </a>
          </div>
        </div>
         <!-- fim -->
        <!-- Free Vencidas -->
 <!-- inicia o box de cada coisa -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3><?php echo $contas_ssh_free_venc;?></h3>

              <p>Contas SSH Free Vencidas</p>
            </div>
            <div class="icon">
              <i class="fa fa-globe"></i>
            </div>
            <a onclick="buscar();" style="cursor:pointer;" class="small-box-footer">
              Mais informações <i class="fa fa-arrow-circle-right"></i>
            </a>
          </div>
        </div>
         <!-- fim -->
        <div class="col-xs-12">
          <div class="box box-primary">
<script type="text/javascript">
function deleta(id){
decisao = confirm("Tem certeza que deseja deletar essa Conta?!");
if (decisao){
  window.location.href='home.php?page=ssh/contas_free&deletar='+id;
} else {

}


}
</script>

            <div class="box-header">
              <h3 class="box-title">Contas SSH Criadas</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Servidor</th>
				  <th>IP</th>
				  <th>Validade</th>
                  <th>Porta</th>
                  <th>Login</th>
                  <th>Senha</th>
				  <th>IP Pessoal</th>
				  <th>Excluir</th>
                </tr>
                </thead>
                <tbody>


								  <?php
					$SQLSSH = "SELECT * FROM usuario_ssh_free order by id asc";
                    $SQLSSH = $conn->prepare($SQLSSH);
                    $SQLSSH->execute();


					// output data of each row
                   if (($SQLSSH->rowCount()) > 0) {

                   while($row = $SQLSSH->fetch())


				   {

				   //Busca Servidor
				   	$SQLServer = "SELECT * FROM servidor where id_servidor='".$row['servidor']."'";
                    $SQLServer = $conn->prepare($SQLServer);
                    $SQLServer->execute();
                    $servidor=$SQLServer->fetch();

//Calcula os dias restante
        $valida=explode(" ",$row['validade']);
	    $data_atual = date("Y-m-d ");
		$data_validade = $valida[0];
		if($data_validade > $data_atual){
		   $data1 = new DateTime( $data_validade );
           $data2 = new DateTime( $data_atual );
           $dias_acesso = 0;
           $diferenca = $data1->diff( $data2 );
           $ano = $diferenca->y * 364 ;
	       $mes = $diferenca->m * 30;
		   $dia = $diferenca->d;
           $dias_acesso = $ano + $mes + $dia;

		}else{
			 $dias_acesso = 0;
		}




					   ?>

                  <tr>

                   <td><?php echo $servidor['nome'];?></td>
				   <td><?php echo $servidor['ip_servidor'];?></td>
				    <td>
				   <span class="pull-left-container" style="margin-right: 5px;">
                            <span class="label label-primary pull-left">
					        <?php if($dias_acesso<=0){
		                    echo "Vencido";
		                     }else{
					         echo $dias_acesso."  dias   ";
					         } ?>
				            </span>
                       </span>
                   </td>
                   <td> 80,8080|443,22</td>
                   <td><?php echo $row['login'];?></td>
                   <td><?php echo $row['senha'];?></td>
                   <td><?php echo $row['ip'];?></td>


				   <td>


					  <a onclick="deleta('<?php echo $row['id'];?>');" class="btn-sm btn-danger"><i class="fa fa-trash"></i></a>



				   </td>
                  </tr>




   <?php }
}


?>

                </tbody>
                <tfoot>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
          </div>
          <!-- /.box -->
        </div>
        <div class="row">
        <div class="col-md-6">
             <!-- general form elements -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Apagar Todas Contas</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form" method="post" action="pages/ssh/apagarall.php" onsubmit="return confirm('Tem certeza que deseja apagar todas contas?');">
              <div class="box-body">
                  <div class="form-group">
                <label>Selecione um servidor</label>
                <select class="form-control select2" style="width: 100%;"  name="servidor" id="servidor" required>
                  <option selected="selected">Selecione um servidor</option>

                  <?php


    $SQLServidor = "select * from servidor where tipo='free'  ";
    $SQLServidor = $conn->prepare($SQLServidor);
    $SQLServidor->execute();

if (($SQLServidor->rowCount()) > 0) {
    // output data of each row
    while($row2 = $SQLServidor->fetch()   ) {

        $SQLcontasServidor = "select * from usuario_ssh_free where servidor='".$row2['id_servidor']."'";
        $SQLcontasServidor = $conn->prepare($SQLcontasServidor);
        $SQLcontasServidor->execute();
        $contasservers=$SQLcontasServidor->rowCount();

	if(($SQLServidor->rowCount()) > 0 ){
		?>

	<option value="<?php echo $row2['id_servidor'];?>" > <?php echo $row2['nome'];?> - <?php echo $row2['ip_servidor'];?> - Contas: <?php echo $contasservers;?>    </option>

		<?php
		}
   }
}


?>


                </select>
              </div>

              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-danger">Apagar</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
           </div>
            <div class="col-md-6">
              <!-- general form elements -->
              <script>

              </script>
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Apagar Contas Vencidas</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form" method="post" action="pages/ssh/apagarvenc.php" onsubmit="return confirm('Tem certeza que deseja apagar contas vencidas?');">
              <div class="box-body">
                <div class="form-group">
                <label>Selecione um servidor</label>
                <select class="form-control select2" style="width: 100%;"  name="servidor" id="servidor" required>
                  <option selected="selected">Selecione um servidor</option>

                  <?php


    $SQLServidor = "select * from servidor where tipo='free'  ";
    $SQLServidor = $conn->prepare($SQLServidor);
    $SQLServidor->execute();

if (($SQLServidor->rowCount()) > 0) {
    // output data of each row
    while($row2 = $SQLServidor->fetch()   ) {

        //Contas totais
        $SQLcontasServidor = "select * from usuario_ssh_free where servidor='".$row2['id_servidor']."'";
        $SQLcontasServidor = $conn->prepare($SQLcontasServidor);
        $SQLcontasServidor->execute();
        $contasservers=$SQLcontasServidor->rowCount();

        // Contas Vencidas
        $SQLcontasServidorvencidas = "select * from usuario_ssh_free where validade<'".date('Y-m-d H:i:s')."'";
        $SQLcontasServidorvencidas = $conn->prepare($SQLcontasServidorvencidas);
        $SQLcontasServidorvencidas->execute();
        $contasserversvencidas=$SQLcontasServidorvencidas->rowCount();

	if(($SQLServidor->rowCount()) > 0 ){
		?>

	<option value="<?php echo $row2['id_servidor'];?>"> <?php echo $row2['nome'];?> - <?php echo $row2['ip_servidor'];?> - Contas: <?php echo $contasservers;?> - Vencidas: <?php echo $contasserversvencidas;?>  </option>

		<?php
		}
   }
}


?>


                </select>
              </div>
              <!-- /.form group -->
                <div class="form-group">
                  <label for="exampleInputPassword1">Tirar dias das contas</label>
                  <input type="text" class="form-control" id="tiradias" name="tiradias" maxlength="2" value="0">
                </div>


              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-danger">Apagar</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
          </div>



        </div>
      </div>
    </section>
</div>





