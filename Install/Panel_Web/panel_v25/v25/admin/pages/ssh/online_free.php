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
		            	echo	'window.location="?page=ssh/online_free";';
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
        "sEmptyTable":    "Nenhuma conta online no momento",
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
</script>
<script type="text/javascript">
function deleta(id){
decisao = confirm("Tem certeza que deseja deletar essa Conta?!");
if (decisao){
  window.location.href='home.php?page=ssh/online_free&deletar='+id;
} else {

}


}
</script>
<!-- Main content -->
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="row page-titles">
                    <div class="col-md-5 col-8 align-self-center">
                        <h3 class="text-themecolor">Mundo<b>SSH</b></h3>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.php">Início</a></li>
                            <li class="breadcrumb-item active">Online</li>
                        </ol>
                    </div>
                </div>
						<div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Contas SSH online</h4>
                                <div class="table-responsive m-t-40">
                                    <table id="myTable" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
											  <th>Servidor</th>
											  <th>IP SSH</th>
											  <th>Login</th>
											  <th>Validade</th>
											  <th>Tempo</th>
											  <th>Online</th>
											  <th>Quantidade Online</th>
											  <th>Apagar</th>
												</tr>
										</thead>
									<tbody>
  <?php




					$SQLSub = "SELECT * FROM usuario_ssh_free";
                    $SQLSub = $conn->prepare($SQLSub);
                    $SQLSub->execute();


                    if(($SQLSub->rowCount()) > 0){
						 while($rowSub = $SQLSub->fetch()) {

						    $SQLSSH = "SELECT * FROM servidor where tipo='free' and id_servidor='".$rowSub['servidor']."' ORDER BY id_servidor";
                            $SQLSSH = $conn->prepare($SQLSSH);
                            $SQLSSH->execute();
                            $row = $SQLSSH->fetch();


									//Calcula os dias restante
		$dias_acesso = 0 ;

	    $data_atual = date("Y-m-d ");
		$data_validade = $rowSub['validade'];
		if($data_validade > $data_atual){
		   $data1 = new DateTime( $data_validade );
           $data2 = new DateTime( $data_atual );
           $dias_acesso = 0;
           $diferenca = $data1->diff( $data2 );
           $ano = $diferenca->y * 364 ;
	       $mes = $diferenca->m * 30;
		   $dia = $diferenca->d;
           $dias_acesso = $ano + $mes + $dia;

		}


								    $status="";
				                    if($rowSub['status']== 1){
						                $status="Ativo";
										$class = "class='btn btn-primary'";
					                }else{
					           	        $status="Desativado";
				             	    }

									if($rowSub['online'] != 0){

								?>
								<tr>

                   <td><?php echo $row['nome'];?></td>
				    <td><?php echo $row['ip_servidor'];?></td>

                   <td><?php echo $rowSub['login'];?></td>
                   <td>

				       <span class="pull-left-container" style="margin-right: 5px;">
                            <span class="label label-primary pull-left">
					            <?php echo $dias_acesso."  dias   "; ?>
				            </span>
                       </span>



			      </td>
				  <td><?php echo tempo_corrido($rowSub['online_start']);?> </td>
				  <td><?php
				   if($rowSub['online']>0){ ?>
				   <small class="label bg-green">Online</small>
				   <?php }else{
				   echo $rowSub['online']; } ?></td>

                   <td><?php echo $rowSub['online'];?></td>



				   <td>
				  <a onclick="deleta('<?php echo $rowSub['id'];?>');" class="btn btn-danger">Apagar</a>
				   </td>
                  </tr>
								<?php
									}




					    }
					}








?>

									</tbody>
									</table>
                                </div>
                            </div>
                        </div>
		</div>