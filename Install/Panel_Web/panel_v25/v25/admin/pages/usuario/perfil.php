<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}



if(isset($_GET["id_usuario"])){
	$id_usuario=$_GET['id_usuario'];
	$diretorio = "../../admin/home.php?page=usuario/perfil&id_usuario=".$id_usuario;
	$SQLUsuario = "select * from usuario WHERE id_usuario = '".$id_usuario."'  ";
	$SQLUsuario = $conn->prepare($SQLUsuario);
	$SQLUsuario->execute();
	$usuario = $SQLUsuario->fetch();
	if(($SQLUsuario->rowCount()) <= 0){
		echo '<script type="text/javascript">';
		echo 	'alert("O usuario nao existe!");';
		echo	'window.location="home.php?page=usuario/listar";';
		echo '</script>';
		exit;
	}

		// avatares
	switch($usuario['avatar']){
		case 1:$avatarusu="avatar1.png";break;
		case 2:$avatarusu="avatar2.png";break;
		case 3:$avatarusu="avatar3.png";break;
		case 4:$avatarusu="avatar4.png";break;
		case 5:$avatarusu="avatar5.png";break;
		default:$avatarusu="boxed-bg.png";break;
	}

	$SQLUsuarioSSH = "select * from usuario_ssh WHERE id_usuario = '".$id_usuario."' ";
	$SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
	$SQLUsuarioSSH->execute();
	$total_ssh = $SQLUsuarioSSH->rowCount();



	$SQLSubrevendedores= "select * from usuario WHERE id_mestre = '".$id_usuario."' and tipo='revenda' and subrevenda='sim' ";
	$SQLSubrevendedores = $conn->prepare($SQLSubrevendedores);
	$SQLSubrevendedores->execute();
	$todossubrevendedores=$SQLSubrevendedores->rowCount();

	if (($SQLSubrevendedores->rowCount()) > 0) {

		while($subrow = $SQLSubrevendedores->fetch()) {
			$quantidade_ssh_subs=0;
			$SQLSubSSHsubs= "select * from usuario_ssh WHERE id_usuario = '".$subrow['id_usuario']."'  ";
			$SQLSubSSHsubs = $conn->prepare($SQLSubSSHsubs);
			$SQLSubSSHsubs->execute();


			$sshsubs=$SQLSubSSHsubs->rowCount();


			$SQLSubUSUARIOSsubs= "select * from usuario WHERE id_mestre = '".$subrow['id_usuario']."' ";
			$SQLSubUSUARIOSsubs = $conn->prepare($SQLSubUSUARIOSsubs);
			$SQLSubUSUARIOSsubs->execute();
			$quantidade_USUARIOS_subs += $SQLSubUSUARIOSsubs->rowCount();
			$sshsubs132=$SQLSubUSUARIOSsubs->rowCount();

		}


	}


	$total_ssh_sub = 0;

	if($usuario['tipo']=="revenda"){


		$SQLUsuarioSUB = "select * from usuario WHERE id_mestre = '".$_GET['id_usuario']."' and subrevenda='nao' ";
		$SQLUsuarioSUB = $conn->prepare($SQLUsuarioSUB);
		$SQLUsuarioSUB->execute();
		$total_user = $SQLUsuarioSUB->rowCount();

		if(($SQLUsuarioSUB->rowCount()) > 0){
			while($row_sub = $SQLUsuarioSUB->fetch()) {

				$SQLUsuarioSSH = "select * from usuario_ssh WHERE id_usuario = '".$row_sub['id_usuario']."' ";
				$SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
				$SQLUsuarioSSH->execute();
				$total_ssh_sub += $SQLUsuarioSSH->rowCount();


			}
			$total = $total_ssh +$total_ssh_sub;

		}

	}



	if($usuario['id_mestre']!=0 ){

		$SQLUsuario = "select * from usuario WHERE id_usuario = '".$usuario['id_mestre']."'  ";
		$SQLUsuario = $conn->prepare($SQLUsuario);
		$SQLUsuario->execute();
		$usuario_mestre = $SQLUsuario->fetch();

	}

}else{

	echo '<script type="text/javascript">';
	echo 	'alert("Preencha todos os campos!");';
	echo	'window.location="home.php?page=usuario/listar";';
	echo '</script>';
}

?>



	<?php if($usuario['ativo'] == 2 ){?>
		<div class="alert alert-danger">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
			<center><i class="fas fa-ban" ></i> Conta Suspensa!</center>
		</div>
	<?php }?>

<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
	<div class="row">
		<div class="col-lg-4 col-xlg-3 col-md-5">
			<div class="card border-info mb-3">
				
				<div class="card-body little-profile text-center">
					<div class="pro-img">
						<img class="img-circle" src="../app-assets/images/portrait/avatar/<?php echo $avatarusu;?>" height="60" width="60" alt="user"/></div>
					<h3 class="profile-username text-center"><?php echo $usuario['nome'];?></h3>
					<?php if($usuario['tipo']== "vpn"){ ?>
						<p class="text-muted text-center">Usuário SSH</p>
					<?php }elseif($usuario['tipo']== "revenda"){
						if($usuario['subrevenda']=='sim'){
							?>
							<p class="text-primary text-center">Sub-Revendedor (<a href="home.php?page=usuario/perfil&id_usuario=<?php echo $usuario_mestre['id_usuario'];?>"><?php echo $usuario_mestre['nome'];?></a>)</p>
						<?php } else{
							?>
							<p class="text-primary text-center">Revendedor</p>
							<?php
						}
					} ?>

					<ul class="list-group list-group-unbordered">
						<li class="list-group-item">
							<b>Contas SSH</b> <a class="badge badge-pill bg-success float-right text-white"><?php echo $total_ssh;?></a>
						</li>
						<?php if($usuario['tipo']=="revenda"){?>
							<li class="list-group-item">
								<b>Usuários SSH</b> <a class="badge badge-pill bg-warning float-right text-white"><?php echo $total_user;?></a>
							</li>
							<li class="list-group-item">
								<b>Contas dos Usuários SSH</b> <a class="badge badge-pill bg-danger float-right text-white"><?php echo $total_ssh_sub;?></a>
							</li>
							<?php if($usuario['subrevenda']=='sim'){
								$totalserversadd = "select * from acesso_servidor WHERE id_usuario = '".$usuario['id_usuario']."' ";
								$totalserversadd = $conn->prepare($totalserversadd);
								$totalserversadd->execute();
								$total_servers_add = $totalserversadd->rowCount();
								?>
								<li class="list-group-item">
									<b>Servidores Adicionados</b> <aclass="badge badge-pill bg-success float-right"><?php echo $total_servers_add;?></a>
								</li>
							<?php } ?>
							<?php if($usuario['subrevenda']=='nao'){?>
								<li class="list-group-item">
									<b>SubRevendedores</b> <a class="badge badge-pill bg-primary float-right text-white"><?php echo $todossubrevendedores;?></a>
								</li>
								<li class="list-group-item">
									<b>Usuários dos Sub</b> <a class="badge badge-pill bg-info float-right text-white"><?php echo $quantidade_USUARIOS_subs;?></a>
								</li>
							<?php } ?>
						<?php  } ?>
					</ul>

					<script type="text/javascript">
						function excluir_usuario(){
							decisao = confirm("Tem certeza que vai excluir?!");
							if (decisao){
								window.location.href='../pages/system/funcoes.usuario.php?&op=deletar&id_usuario=<?php echo $usuario['id_usuario'];?>&diretorio=../../admin/home.php?page=usuario/revenda&owner=<?php echo $accessKEY;?>'
							} else {

							}
						}
						function suspende_usuario(){
							decisao = confirm("Tem certeza que vai suspender?!");
							if (decisao){
								window.location.href='../pages/system/funcoes.usuario.php?&id_usuario=<?php echo $usuario['id_usuario'];?>&diretorio=../../admin/home.php?page=usuario/listar&owner=<?php echo $accessKEY;?>&op=suspender'
							} else {

							}
						}
					</script>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->

			<!-- About Me Box -->
			<div class="card border-info mb-3">
				<div class="card-body">
					<h4 class="card-title"><center>Ações</center></h4><hr><br>
					<center>
						<a onclick="excluir_usuario()" class="btn mr-1 mb-1 btn-danger"><b><font color="white">DELETAR TUDO</font></b></a>
					<?php if($usuario['ativo']== 1){?>
						<center>
							<a onclick="suspende_usuario()" class="btn mr-1 mb-1 btn-primary btn-warning"><b>SUSPENDER TUDO</b></a>
					<?php }else{?>
						<center>
							<a href="../pages/system/funcoes.usuario.php?&id_usuario=<?php echo $usuario['id_usuario'];?>&diretorio=../../admin/home.php?page=usuario/listar&owner=<?php echo $accessKEY;?>&op=ususpender" class="btn btn-primarymr-1 mb-1  btn-success"><b>REATIVAR TUDO</b></a>

					<?php }?>
					<center>
						<a href="../pages/system/funcoes.usuario.php?&id_usuario=<?php echo $usuario['id_usuario'];?>&diretorio=../../admin/home.php?page=usuario/listar&owner=<?php echo $accessKEY;?>&op=senha" class="btn btn-primary mr-1 mb-1  btn-primary"><b>REENVIAR SENHA</b></a>
					<center>
						<a href="?page=usuario/addservidor" class="btn btn-primary btn-success"><b>ADICIONAR SERVIDOR</b></a></center>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
		<!-- /.col -->
		<div class="col-md-8">
			<div class="card border-info mb-3">
				<div class="card-body p-b-0">
					<h4 class="card-title"><i class="fa fa-edit"></i> Gerenciar</i></h4>
					<!-- Nav tabs -->

					<ul class="nav nav-tabs customtab" role="tablist">
						<li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#activity" role="tab"><span class="hidden-sm-up"><i class="ti-pencil"></i></span> <span class="hidden-xs-down">Informações do Usuário</span></a> </li>
						<?php if($usuario['tipo']=="revenda"){?>
							<?php if($usuario['subrevenda']=="nao"){?>
								<li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#timeline" role="tab"><span class="hidden-sm-up"><i class="ti-harddrives"></i></span> <span class="hidden-xs-down">Servidores</span></a> </li>
							<?php } ?>
							<li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#users" role="tab"><span class="hidden-sm-up"><i class="ti-user"></i></span> <span class="hidden-xs-down">Usuários</span></a> </li>
						<?php } ?>
						<li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#ssh" role="tab"><span class="hidden-sm-up"><i class="ti-loop"></i></span> <span class="hidden-xs-down">Contas SSH</span></a> </li>
						<?php if($usuario['subrevenda']=="nao"){?>
							<li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#fatura" role="tab"><span class="hidden-sm-up"><i class="ti-money"></i></span> <span class="hidden-xs-down">Gerar Fatura</span></a> </li>
						<?php } ?>
					</ul>

					<div class="tab-content">

						<div class="active tab-pane" id="activity">
							<form class="form-horizontal"  role="perfil" name="perfil" id="perfil" action="pages/usuario/editar_exe.php" method="post" >
								<div class="form-group"><br>
									<label for="exampleInputPassword1">Login</label>
									<input type="text" class="form-control" disabled value="<?php echo $usuario['login'];?>">
									<input type="hidden" class="form-control" id="idusuario" name="idusuario" value="<?php echo $usuario['id_usuario'];?>">
								</div>

								<div class="form-group">
									<label for="exampleInputPassword1">Senha</label>
									<input type="password" class="form-control" id="senha" name="senha" value="<?php echo $usuario['senha'];?>">
								</div>

								<div class="form-group">
									<label for="exampleInputPassword1">Nome</label>
									<input type="text" class="form-control" id="nome" name="nome" value="<?php echo $usuario['nome'];?>">
								</div>

								<div class="form-group">
									<label for="exampleInputPassword1">Email</label>
									<input type="email" class="form-control" id="email" name="email" value="<?php echo $usuario['email'];?>">
								</div>

								<div class="form-group">
									<label for="exampleInputPassword1">Celular</label>
									<input type="text" class="form-control" id="celular" name="celular" value="<?php echo $usuario['celular'];?>">
								</div>

								<div class="form-group">
									<label for="exampleInputPassword1">Data de cadastro</label>
									<input type="text" class="form-control" disabled value="<?php echo $usuario['data_cadastro'];?>">
								</div>

								<div class="form-group">
									<button type="submit" class="btn btn-success">Alterar Dados</button>
								</div>
							</form>

						</div>
						<!-- /.tab-pane -->
						<?php if($usuario['tipo']=="revenda"){?>
							<?php if($usuario['subrevenda']=='nao'){ ?>
								<div class=" tab-pane" id="timeline">
<h4 class="card-title"><i class="fa fa-edit"></i> Adicionar Servidor</i></h4>
<form  role="servidor" name="servidor" id="servidor" action="pages/usuario/adiciona_acesso.php" method="post">

             <div class="form-group">
                <label>Selecione um servidor</label>
                <select class="form-control select2" style="width: 100%;"  name="servidor" id="servidor">
                  <option selected="selected" value="0">Lista de servidores</option>

                  <?php


    $SQLServidor = "select * from servidor   ";
    $SQLServidor = $conn->prepare($SQLServidor);
    $SQLServidor->execute();

if (($SQLServidor->rowCount()) > 0) {
    // output data of each row
    while($row2 = $SQLServidor->fetch()   ) {

		$SQLAcessoServidor = "select * from acesso_servidor where id_servidor='".$row2['id_servidor']."'  and id_usuario = '".$_GET['id_usuario']."'";
        $SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
        $SQLAcessoServidor->execute();


		if(($SQLAcessoServidor->rowCount()) == 0 ){
		?>

	<option value="<?php echo $row2['id_servidor'];?>" > <?php echo $row2['nome'];?> - <?php echo $row2['ip_servidor'];?>   </option>

		<?php
		}
   }
}


?>


                </select>
              </div>
              <!-- /.form group -->



			  <div class="form-group"id="qtd_ssh" >
                  <label  >Limite de Acessos SSH</label>
                  <input required="required" type="number" class="form-control" id="qtd" name="qtd" placeholder="Digite a quantidade">
              </div>
              <div class="form-group"id="qtd_ssh" >
                  <label>Data de Validade</label>
                  <input required="required" type="text" class="form-control" id="val" name="val" placeholder="Exemplo: 15 (dias)">
              </div>
			  <div class="form-group"id="qtd_ssh" >

                  <input  type="hidden" class="form-control" id="usuario" name="usuario" value="<?php echo $_GET['id_usuario'];?>">
              </div>


			  <div class="box-footer">
                <button type="submit" class="btn btn-primary">Adicionar</button>
              </div>
            </form>	
			
<!-- edita servidor usuario -->
     <?php
    $usuarioid=anti_sql_injection($_GET['id_usuario']);
    $SQLverifica = "select * from acesso_servidor where id_usuario='".$usuarioid."'";
    $SQLverifica = $conn->prepare($SQLverifica);
    $SQLverifica->execute();
    if($SQLverifica->rowCount()>0){
        ?>
       <hr>
<h4 class="card-title"><i class="fa fa-edit"></i> Editar Validade e Limite</i></h4>
        <form  role="servidor" name="servidor" id="servidor" action="pages/usuario/edita_acesso.php" method="post">

             <div class="form-group">
                <label><b>Selecione um servidor</b></label>
                <select class="form-control select2" style="width: 100%;"  name="servidor" id="servidor">
                  <option selected="selected" value="0">Lista de servidores</option>

                  <?php

    $usuarioid=anti_sql_injection($_GET['id_usuario']);
    $SQLServidor2 = "select * from acesso_servidor where id_usuario='".$usuarioid."'";
    $SQLServidor2 = $conn->prepare($SQLServidor2);
    $SQLServidor2->execute();

if (($SQLServidor2->rowCount()) > 0) {
    // output data of each row
    while($row22 = $SQLServidor2->fetch()   ) {

		$SQLAcessoServidor2 = "select * from servidor where id_servidor='".$row22['id_servidor']."'";
        $SQLAcessoServidor2 = $conn->prepare($SQLAcessoServidor2);
        $SQLAcessoServidor2->execute();


		if(($SQLAcessoServidor2->rowCount()) > 0 ){
		$server = $SQLAcessoServidor2->fetch();
		?>

	<option value="<?php echo $row22['id_acesso_servidor'];?>" > <?php echo $server['nome'];?> - <?php echo $server['ip_servidor'];?>   </option>

		<?php
		}
   }
}


?>


                </select>
              </div>
              <!-- /.form group -->
              <div class="form-group"id="qtd_ssh" >
                  <label><b>Adicionar Dias (validade)</b></label>
                  <input required="required" type="text" class="form-control" id="val" name="val" value="0">
              </div>
              <div class="form-group">
                  <label for="exampleInputPassword1"><b>Adicionar Limite</b></label>
                  <input type="number" class="form-control" id="acesso" name="acesso" value="0">
                </div>
              <div class="form-group">
                  <label for="exampleInputPassword1"><b>Remover Limite</b></label>
                  <input required="required" type="number" class="form-control" id="racesso" name="racesso" value="0">
                </div>
			  <div class="form-group"id="qtd_ssh" >
			  <input  type="hidden" class="form-control" id="usuario" name="usuario" value="<?php echo $_GET['id_usuario'];?>">
              </div>


			  <div class="box-footer">
                <button type="submit" class="btn btn-primary btn-success"><b>Editar Servidor</b></button>
              </div>
            </form>
       </br>
       <?php } ?>
<!-- edita servidor usuario -->
									<div class="row">
										<div class="col-lg-12">
											<div class="box box-primary">
												<div class="box-header">
													<h3 class="box-title">Servidores de acesso</h3>


												</div>
												<!-- /.box-header -->
												<div class="table-responsive">
													<table class="table table-hover">
														<tr>
															<th>Servidor</th>
															<th>Limite Atual</th>
															<th>Validade</th>
															<th>SubServidores</th>
															<th>Contas SSH</th>
															<th>Acessos SSH</th>
															<th></th>

														</tr>
														<?php


														$SQLAcessoServidor = "select * from acesso_servidor where id_usuario='".$_GET['id_usuario']."'  ";
														$SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
														$SQLAcessoServidor->execute();


														if (($SQLAcessoServidor->rowCount()) > 0) {


															while($row2 = $SQLAcessoServidor->fetch()   ){

																$SQLTotalUser = "select * from usuario WHERE id_usuario = '".$_GET['id_usuario']."' ";
																$SQLTotalUser = $conn->prepare($SQLTotalUser);
																$SQLTotalUser->execute();
																$total_user = $SQLTotalUser->rowCount();



																$SQLServidor = "select * from servidor where id_servidor = '".$row2['id_servidor']."'";
																$SQLServidor = $conn->prepare($SQLServidor);
																$SQLServidor->execute();

																$SQLsubservidores = "select * from acesso_servidor WHERE id_servidor_mestre = '".$row2['id_acesso_servidor']."'";
																$SQLsubservidores = $conn->prepare($SQLsubservidores);
																$SQLsubservidores->execute();
																$total_subservers = $SQLsubservidores->rowCount();

																$contas=0;
																$acessos=0;


																$SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '".$row2['id_servidor']."'
																and id_usuario='".$_GET['id_usuario']."'  ";
																$SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
																$SQLUsuarioSSH->execute();
																$contas += $SQLUsuarioSSH->rowCount();

																$SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row2['id_servidor']."'  and id_usuario='".$_GET['id_usuario']."' ";
																$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
																$SQLAcessoSSH->execute();
																$SQLAcessoSSH = $SQLAcessoSSH->fetch();
																$acessos += $SQLAcessoSSH['quantidade'];



																$SQLUsuarioSub = "select * from usuario WHERE id_mestre = '".$_GET['id_usuario']."' and subrevenda='nao' ";
																$SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
																$SQLUsuarioSub->execute();

																if (($SQLUsuarioSub->rowCount()) > 0) {
																	while($row3 = $SQLUsuarioSub->fetch()   ){

																		$SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '".$row2['id_servidor']."'
																		and id_usuario='".$row3['id_usuario']."'  ";
																		$SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
																		$SQLUsuarioSSH->execute();
																		$contas += $SQLUsuarioSSH->rowCount();

																		$SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row2['id_servidor']."'  and id_usuario='".$row3['id_usuario']."' ";
																		$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
																		$SQLAcessoSSH->execute();
																		$SQLAcessoSSH = $SQLAcessoSSH->fetch();
																		$acessos += $SQLAcessoSSH['quantidade'];



																	}
																}





																if (($SQLServidor->rowCount()) > 0) {
																	while($row3 = $SQLServidor->fetch()   ){

																		$qtd_srv =0;

			//Calcula os dias restante
																		$data_atual = date("Y-m-d");
																		$data_validade = $row2['validade'];
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
																			<td><?php echo $row3['nome'];?></td>
																			<td><?php echo $row2['qtd'];?></td>
																			<td>
																				<span class="pull-left-container" style="margin-right: 5px;">
																					<span class="label label-primary pull-left">
																						<?php echo $dias_acesso."  dias   "; ?>
																					</span>
																				</span>



																			</td>
																			<td><?php echo $total_subservers;?></td>
																			<td><?php echo $contas;?></td>
																			<td><?php echo $acessos;?></td>
																			<td>
																				<center>
																					<script>
																						function apaga_tudo<?php echo $row2['id_acesso_servidor'];?>(){
																							decisao = confirm("Tem certeza que vai apagar o servidor dele?!\n Vai apagar o servidor dos subrevendedores dele.");
																							if (decisao){
																								window.location.href='pages/usuario/remover_servidor.php?&id_acesso=<?php echo $row2['id_acesso_servidor'];?>'
																							} else {

																							}


																						}
																					</script>
																					<!-- <a href="#" class="btn btn-warning">Editar Acesso</a> -->
																					<a onclick="apaga_tudo<?php echo $row2['id_acesso_servidor'];?>()" class="btn btn-danger"><i class="fa fa-trash"></i></a>

																				</center>
																			</td>

																		</tr>


																		<?php
																	}
																}
															}
														}
														?>




													</table>
												</div>
												<!-- /.box-body -->
											</div>
											<!-- /.box -->
										</div>
									</div>



								</div>
								<!-- /.tab-pane -->
							<?php } ?>
							<div class="tab-pane" id="users">


								<div class="row">
									<div class="col-lg-12">
										<div class="box box-primary">
											<div class="box-header">
												<h3 class="box-title">Usuários de sistema</h3>


											</div>
											<!-- /.box-header -->
											<div class="table-responsive">
												<table class="table table-hover">
													<tr>
														<th>Login</th>
														<th>Nome</th>
														<th>Contas</th>

													</tr>
													<?php

													$SQLUsuarioSUB = "select * from usuario where id_mestre='".$usuario['id_usuario']."'  ";
													$SQLUsuarioSUB = $conn->prepare($SQLUsuarioSUB);
													$SQLUsuarioSUB->execute();


													if (($SQLUsuarioSUB->rowCount()) > 0) {
    // output data of each row
														while($row_user = $SQLUsuarioSUB->fetch()   ){

															$total_ssh = 0;

															$SQLUsuarioSSH = "select * from usuario_ssh where id_usuario = '".$row_user['id_usuario']."' ";
															$SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
															$SQLUsuarioSSH->execute();
															$total_ssh += $SQLUsuarioSSH->rowCount();
															$color = "";


															if($row_user['ativo']== 2){

																$color = "bgcolor='#FF6347'";
															}

															?>


															<tr <?php echo $color; ?>>
																<td><?php echo $row_user['login'];?></td>
																<td><?php echo $row_user['nome'];?></td>
																<td><?php echo $total_ssh;?></td>


															</tr>


															<?php

														}
													}
													?>




												</table>
											</div>
											<!-- /.box-body -->
										</div>
										<!-- /.box -->
									</div>
								</div>


							</div>
						<?php }?>
						<!-- /.tab-pane -->
						<div class=" tab-pane" id="ssh">
							<div class="row">
								<div class="col-lg-12">
									<div class="box box-primary">
										<div class="box-header">
											<h3 class="box-title">Contas SSH</h3>
										</div>
										<!-- /.box-header -->
										<div class="table-responsive">
											<table class="table table-hover">
												<tr>
													<th>Login</th>
													<th>Servidor</th>
													<th>Acessos</th>
													<th>Owner</th>
												</tr>
												<?php
												$SQLUsuarioSSH = "select * from usuario_ssh where id_usuario='".$usuario['id_usuario']."'";
												$SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
												$SQLUsuarioSSH->execute();


												if (($SQLUsuarioSSH->rowCount()) > 0) {

    // output data of each row
													while($row_user = $SQLUsuarioSSH->fetch()   ){

														$SQLServidor = "select * from servidor where id_servidor='".$row_user['id_servidor']."'  ";
														$SQLServidor = $conn->prepare($SQLServidor);
														$SQLServidor->execute();
														$servidor = $SQLServidor->fetch();
														$color = "";

														$acessos = 0;
														$SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario_ssh='".$row_user['id_usuario_ssh']."' ";
														$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
														$SQLAcessoSSH->execute();
														$SQLAcessoSSH = $SQLAcessoSSH->fetch();
														$acessos += $SQLAcessoSSH['quantidade'];


														if($row_user['status']== 2){

															$color = "bgcolor='#FF6347'";
														}



														?>


														<tr <?php echo $color; ?>>
															<td><?php echo $row_user['login'];?></td>
															<td><?php echo $servidor['nome'];?></td>
															<td><?php echo $acessos;?></td>
															<td>Owner</td>


														</tr>


														<?php


													}
												}
												if($usuario['tipo'] == "revenda"){

													$SQLUserSub = "select * from usuario where id_mestre = '".$usuario['id_usuario']."'  ";
													$SQLUserSub = $conn->prepare($SQLUserSub);
													$SQLUserSub->execute();

													if (($SQLUserSub->rowCount()) > 0) {

														while($row_user_sub = $SQLUserSub->fetch()   ){


															$SQLSubSSH = "select * from usuario_ssh where id_usuario='".$row_user_sub['id_usuario']."'  ";
															$SQLSubSSH = $conn->prepare($SQLSubSSH);
															$SQLSubSSH->execute();

															if (($SQLSubSSH->rowCount()) > 0) {
																while($row_ssh_sub = $SQLSubSSH->fetch()   ){

																	$SQLServidor = "select * from servidor where id_servidor='".$row_ssh_sub['id_servidor']."'  ";
																	$SQLServidor = $conn->prepare($SQLServidor);
																	$SQLServidor->execute();
																	$servidor = $SQLServidor->fetch();
																	$color = "";
																	$acessos  = 0;

																	if($row_ssh_sub['status']== 2){

																		$color = "bgcolor='#FF6347'";
																	}

																	$SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario_ssh='".$row_ssh_sub['id_usuario_ssh']."'  ";
																	$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
																	$SQLAcessoSSH->execute();
																	$SQLAcessoSSH = $SQLAcessoSSH->fetch();
																	$acessos += $SQLAcessoSSH['quantidade'];


																	?>

																	<tr <?php echo $color; ?>>
																		<td><?php echo $row_ssh_sub['login'];?></td>
																		<td><?php echo $servidor['nome'];?></td>
																		<td><?php echo $acessos;?></td>
																		<td><?php echo $row_user_sub['login'];?></td>


																	</tr>

																<?php	}

															}
														}

													}

												}


												?>

											</table>
										</div>
										<!-- /.box-body -->
									</div>
									<!-- /.box -->
								</div>
							</div>
						</div>
						<!-- /.tab-pane -->
						<!-- /.tab-fatura -->
						<div class="tab-pane" id="fatura">
							<div class="row">
								<div class="col-lg-12">
									<form class="form-horizontal"  role="perfil" name="gerandofatura" id="gerandofatura" action="pages/usuario/gerarfatura_exe.php" method="post" >
										<div class="form-group"><br>
											<input  type="hidden" class="form-control" id="usuarioid" name="usuarioid" value="<?php echo $_GET['id_usuario'];?>">
											<label for="exampleInputPassword1">Tipo da Fatura</label>
											<select class="form-control" name="tipofat">
												<?php if($usuario['tipo']=='vpn'){?><option value='1'> Acesso VPN</option><?php } ?>
												<option value='2'>Outros</option>
												<?php if($usuario['tipo']=='revenda'){?><option value='1' selected=selected>Revenda</option><?php } ?>
											</select>

										</div>

										<div class="form-group">
											<label for="exampleInputPassword1">Quantidade</label>
											<input type="number" class="form-control" id="qtd" name="qtd" value="1" required>
										</div>

										<div class="form-group">
											<label for="exampleInputPassword1">Valor</label>
											<input type="number" class="form-control" id="valor" name="valor" value="5" required>
										</div>
										<div class="form-group">
											<label for="exampleInputPassword1">Desconto</label>
											<input type="number" class="form-control" id="desconto" name="desconto" value="0" required>
										</div>

										<div class="form-group">

											<label for="exampleInputPassword1">Vencimento</label>
											<input type="number" class="form-control" id="venc" name="venc" value="5" required>
										</div>


										<div class="form-group">
											<label for="exampleInputPassword1">Descrição</label>
											<textarea class="form-control" name="msg" id="msg" rows="3" placeholder="Digite ..." value="Enviar Comprovante apos Pagamento" required></textarea>
										</div>
										<?php if($usuario['tipo']=="revenda"){?>
											<div class="form-group">
												<label for="exampleInputPassword1">Servidor</label>
												<select class="form-control" name="servidorid">
													<option selected=selected>Servidores</option>
													<?php
													$SQLServidor2 = "select * from servidor";
													$SQLServidor2 = $conn->prepare($SQLServidor2);
													$SQLServidor2->execute();

													if (($SQLServidor2->rowCount()) > 0) {
														// output data of each row
														while($row22 = $SQLServidor2->fetch()   ) {

															$SQLAcessoServidor = "select * from acesso_servidor where id_servidor='".$row22['id_servidor']."'  and  id_usuario = '".$_GET['id_usuario']."'";
															$SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
															$SQLAcessoServidor->execute();
															$acc=$SQLAcessoServidor->fetch();

															if(($SQLAcessoServidor->rowCount()) > 0 ){
																?>

																<option value="<?php echo $row22['id_servidor'];?>" > <?php echo $row22['ip_servidor'];?> - Acessos: <?php echo $acc['qtd'];?> - VAL: <?php echo $acc['validade'];?>  </option>

																<?php
															}else{ ?>
																<option value="<?php echo $row22['id_servidor'];?>" > <?php echo $row22['nome'];?> - <?php echo $row22['ip_servidor'];?> - Não tem acesso </option>
															<?php }
														}
													}
													?>
												</select>

											</div>
										<?php }elseif($usuario['tipo']=="vpn"){?>
											<div class="form-group">
												<label for="inputName" for="exampleInputPassword1">Contas SSH</label>
												<select class="form-control" name="account">
													<option value="outros" selected=selected>Gerar em Outros</option>
													<?php
													$SQLServidor2 = "select * from usuario_ssh where id_usuario='".$_GET['id_usuario']."'";
													$SQLServidor2 = $conn->prepare($SQLServidor2);
													$SQLServidor2->execute();

													if (($SQLServidor2->rowCount()) > 0) {
    													// output data of each row
														while($row22 = $SQLServidor2->fetch()   ) {
															$data=$row22['data_validade'];

															$datacriado=$data;
															$dataconvcriado = substr($datacriado, 0, 10);
															$partes = explode("-", $dataconvcriado);
															$ano = $partes[0];
															$mes = $partes[1];
															$dia = $partes[2];

														        /*
																$SQLAcessoServidor = "select * from acesso_servidor where id_servidor='".$row22['id_servidor']."'  and  id_usuario = '".$_GET['id_usuario']."'";
														        $SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
														        $SQLAcessoServidor->execute();
														        $acc=$SQLAcessoServidor->fetch();

														        if(($SQLAcessoServidor->rowCount()) > 0 ){   */
														        	?>
														        	<option value="<?php echo $row22['id_usuario_ssh'];?>" > <?php echo $row22['login'];?> - Acessos: <?php echo $row22['acesso'];?> - VAL: <?php echo $dia;?>/<?php echo $mes;?> - <?php echo $ano;?>  </option>
														        	<?php /*
																			}else{ ?>
																	        <option value="<?php echo $row22['id_servidor'];?>" > <?php echo $row22['nome'];?> - <?php echo $row22['ip_servidor'];?> - Não tem acesso </option>
																	    <?php }   */
																	}
																}


																?>
															</select>
														</div>

														<div class="form-group">
															<label for="inputName" for="exampleInputPassword1">Servidor</label>
															<select class="form-control" name="servidorid">
																<option value="outros" selected=selected>Outros (Tipo em outros Tbm)</option>
																<?php


																$SQLServidor2 = "select * from servidor";
																$SQLServidor2 = $conn->prepare($SQLServidor2);
																$SQLServidor2->execute();

																if (($SQLServidor2->rowCount()) > 0) {
    // output data of each row
																	while($row22 = $SQLServidor2->fetch()   ) {



																		$SQLcriados = "select * from usuario_ssh where id_servidor='".$row22['id_servidor']."'";
																		$SQLcriados = $conn->prepare($SQLcriados);
																		$SQLcriados->execute();
																		$criados=$SQLcriados->rowCount();
        /*
        if(($SQLAcessoServidor->rowCount()) > 0 ){   */
        	?>

        	<option value="<?php echo $row22['id_servidor'];?>" > <?php echo $row22['nome'];?> -  <?php echo $row22['ip_servidor'];?>  - Contas: <?php echo $criados;?></option>

		<?php /*
		}else{ ?>
        <option value="<?php echo $row22['id_servidor'];?>" > <?php echo $row22['nome'];?> - <?php echo $row22['ip_servidor'];?> - Não tem acesso </option>
    <?php }   */
}
}


?>
</select>
</div>
<?php } ?>



<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
		<button type="submit" class="btn btn-primary">Gerar Fatura</button>
	</div>
</div>
</form>

</div>
</div>
</div>
</div>

</div>
<!-- /.tab-content -->
</div>
<!-- /.nav-tabs-custom -->
</div>
<!-- /.col -->
</div>
<!-- /.row -->

</section>
<!-- /.content -->
