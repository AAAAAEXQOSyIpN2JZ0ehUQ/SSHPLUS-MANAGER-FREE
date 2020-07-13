<?php
include('../../pages/system/config.php');
if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__)) {
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

$SQLmp = "select * from mercadopago";
$SQLmp = $conn->prepare($SQLmp);
$SQLmp->execute();
$mp = $SQLmp->fetch();


if (isset($_GET['delinfo'])) {

	$SQLinfo = "select * from informativo";
	$SQLinfo = $conn->prepare($SQLinfo);
	$SQLinfo->execute();

	if ($SQLinfo->rowCount() > 0) {

		$info = $SQLinfo->fetch();


		if (unlink("../admin/pages/noticias/" . $info['imagem'] . "")) {

			$SQLinfo2 = "delete from informativo";
			$SQLinfo2 = $conn->prepare($SQLinfo2);
			$SQLinfo2->execute();

			echo '<script type="text/javascript">';
			echo 	'alert("Informativo apagado!");';
			echo	'window.location="home.php?page=apis/gerenciar";';
			echo '</script>';
		} else {

			echo '<script type="text/javascript">';
			echo 	'alert("houve algum erro durante o apagamento!");';
			echo	'window.location="home.php?page=apis/gerenciar";';
			echo '</script>';
		}
	} else {

		echo '<script type="text/javascript">';
		echo 	'alert("Não foi encontrado nenhum informativo!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
	}
}

// desativa a noticia ativada
if (isset($_GET['delnoti'])) {
	$id = $_GET['delnoti'];
	$SQLnoticia = "select * from noticias where id='" . $id . "'";
	$SQLnoticia = $conn->prepare($SQLnoticia);
	$SQLnoticia->execute();

	if ($SQLnoticia->rowCount() > 0) {

		$not = $SQLnoticia->fetch();

		if ($not['status'] <> 'ativo') {
			echo '<script type="text/javascript">';
			echo 	'alert("Noticia já está desativada!");';
			echo	'window.location="home.php?page=apis/gerenciar";';
			echo '</script>';
			exit;
		}


		$SQLinfo2 = "update noticias set status='desativado' where id='" . $id . "'";
		$SQLinfo2 = $conn->prepare($SQLinfo2);
		$SQLinfo2->execute();

		echo '<script type="text/javascript">';
		echo 	'alert("Noticia Desativada!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
	} else {

		echo '<script type="text/javascript">';
		echo 	'alert("Nenhuma noticia encontrada!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
	}
}


?>

<?php


if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__)) {
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

$SQLmp = "select * from mercadopago";
$SQLmp = $conn->prepare($SQLmp);
$SQLmp->execute();
$mp = $SQLmp->fetch();


if (isset($_GET['delinfo'])) {

	$SQLinfo = "select * from informativo";
	$SQLinfo = $conn->prepare($SQLinfo);
	$SQLinfo->execute();

	if ($SQLinfo->rowCount() > 0) {

		$info = $SQLinfo->fetch();


		if (unlink("../admin/pages/noticias/" . $info['imagem'] . "")) {

			$SQLinfo2 = "delete from informativo";
			$SQLinfo2 = $conn->prepare($SQLinfo2);
			$SQLinfo2->execute();

			echo '<script type="text/javascript">';
			echo 	'alert("Informativo apagado!");';
			echo	'window.location="home.php?page=apis/gerenciar";';
			echo '</script>';
		} else {

			echo '<script type="text/javascript">';
			echo 	'alert("houve algum erro durante o apagamento!");';
			echo	'window.location="home.php?page=apis/gerenciar";';
			echo '</script>';
		}
	} else {

		echo '<script type="text/javascript">';
		echo 	'alert("Não foi encontrado nenhum informativo!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
	}
}

// desativa a noticia ativada
if (isset($_GET['delnoti'])) {
	$id = $_GET['delnoti'];
	$SQLnoticia = "select * from noticias where id='" . $id . "'";
	$SQLnoticia = $conn->prepare($SQLnoticia);
	$SQLnoticia->execute();

	if ($SQLnoticia->rowCount() > 0) {

		$not = $SQLnoticia->fetch();

		if ($not['status'] <> 'ativo') {
			echo '<script type="text/javascript">';
			echo 	'alert("Noticia já está desativada!");';
			echo	'window.location="home.php?page=apis/gerenciar";';
			echo '</script>';
			exit;
		}


		$SQLinfo2 = "update noticias set status='desativado' where id='" . $id . "'";
		$SQLinfo2 = $conn->prepare($SQLinfo2);
		$SQLinfo2->execute();

		echo '<script type="text/javascript">';
		echo 	'alert("Noticia Desativada!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
	} else {

		echo '<script type="text/javascript">';
		echo 	'alert("Nenhuma noticia encontrada!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
	}
}


?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<section id="input-style">
	<div class="row">
		<div class="col-12">
			<form role="form" action="pages/apis/atualizamp.php" method="post" onsubmit="return confirm('Tem certeza que deseja atualizar a autenticação (pode parar de funcionar)?');">
				<div class="card border-info mb-3">
					<div class="card-header">
						<h4 class="card-title text-primary">API Mercado Pago</h4>
					</div>
					<div class="card-content">
						<div class="card-body">
							<div class="row">
								<div class="col-12">
									<p>
										Verifique se suas informações corretas.
									</p>
									<p>
										Obtenha os dados: [ credenciais da sua conta. ]
										<a target="_blank" href="https://www.mercadopago.com.br/developers/pt/guides/payments/api/introduction/">Clique Aqui !</a>
									</p>
								</div>
								<div class="col-sm-6 col-12">
									<fieldset class="form-group">
										<label>ID De Cliente</label>
										<input required="required" value="<?php echo $mp['CLIENT_ID']; ?>" class="form-control" id="clientid" name="clientid" placeholder="Digite o Seu Client_ID!">
									</fieldset>
								</div>
								<div class="col-sm-6 col-12">
									<fieldset class="form-group">
										<label>Token Secreto</label>
										<input required="required" value="<?php echo $mp['CLIENT_SECRET']; ?>" class="form-control" id="clientsecret" name="clientsecret" placeholder="Digite o Seu CLIENT_SECRET">
									</fieldset>
								</div>
								<div class="col-12 text-center">
									<fieldset class="form-group">
										<label for="squareText">Funcional em: (Faturas, SSHPAGA, SSHREVENDA)</label>
									</fieldset>
								</div>
								<div class="col-12 text-center">
									<fieldset class="form-group">
										<button type="submit" class="btn btn-success">Alterar</button>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<section id="input-style">
	<div class="row">
		<div class="col-12">
			<form class="" action="" method="post">
				<div class="card border-info mb-3">
					<div class="card-header">
						<h4 class="card-title text-info">Auto-Backup do Banco de Dados SQL a cada 2 Minutos "Por Segurança Baixa 2 Backup"</h4>
					</div>
					<div class="card-content">
						<div class="card-body">
							<div class="row">
								<div class="col-12 text-center">
									<p>
										Faça Download backup do banco de dados "Por Segurança Baixa 2 Backup"
									</p>
								</div>
								<div class="col-12 text-center">
								<!--<a href="../admin/pages/apis/<?php echo $DirBackup;?>/sshplus.sql" download="" "> 
								 <span class="btn btn-info"> Baixar Backup </span>-->
									<fieldset class="form-group">
										<?php if(file_exists("../admin/pages/apis/$DirBackup/sshplus.sql")) { ?>
										<a href="../admin/pages/apis/<?php echo $DirBackup;?>/sshplus.sql" download="" "> 
								 <span class="btn btn-info"> Baixar Backup </span>
										<?php } else { ?>
											<button type="button" class="btn btn-info" disabled><i class="fa fa-ban"></i> Nao Disponivel no momento</button>
										<?php } ?>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!--Download do Arquivo EHI
    <div class="col-md-3 col-sm-6 col-xs-12">
     <a href="../admin/pages/apis/<?php echo $DirBackup;?>/sshplus.sql" download="" "> 
      <div class="info-box">
        <span class="info-box-icon bg-blue"><i class="btn btn-info"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">BAIXAR ARQUIVO</span>-->
</section>

<section id="input-style">
	<div class="row">
		<div class="col-12">
			<form class="" action="" method="post">
				<div class="card border-info mb-3">
					<div class="card-header">
						<h4 class="card-title text-danger">Gerenciar Email do Sistema</h4>
					</div>
					<div class="card-content">
						<div class="card-body">
							<div class="row">
								<div class="col-12 text-center">
									<p>
										Funcional em: (Recuperar Senha, Enviar Email, Contato)
									</p>
								</div>
								<div class="col-12 text-center">
									<fieldset class="form-group">
										<a href="home.php?page=email/1etapasmtp" class="btn btn-danger">Configurar o PHP Mailer</a>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>
<?php
$procnoticias = "select * FROM noticias where status='ativo'";
$procnoticias = $conn->prepare($procnoticias);
$procnoticias->execute();
?>
<section id="input-style">
	<div class="row">
		<div class="col-12">
			<form role="form" action="pages/apis/addnoti.php" method="post" onsubmit="return confirm('Tem certeza que deseja fazer isso');" enctype="multipart/form-data">
				<div class="card border-info mb-3">
					<div class="card-header">
						<h4 class="card-title text-warning">Noticiar na Tela Inicial</h4>
					</div>
					<div class="card-content">
						<div class="card-body">
							<div class="row">
								<div class="col-12">
									<p>
										Notificar seus clientes!
									</p>
								</div>
								<div class="col-sm-6 col-12">
									<fieldset class="form-group">
										<label for="roundText">Titulo</label>
										<input required="required" class="form-control" name="titu" placeholder="Titulo da noticia">
									</fieldset>
								</div>
								<div class="col-sm-6 col-12">
									<fieldset class="form-group">
										<label for="squareText">Subtitulo</label>
										<input required="required" class="form-control" name="subtitu" placeholder="Exemplo: Varias novas atualizações são aplicadas!">
									</fieldset>
								</div>
								<div class="col-12 text-center">
									<fieldset class="form-group">
										<label for="squareText">Area da Noticia</label>
										<textarea class="form-control" rows="10" name="msg" placeholder="Digite ... Use <br> para quebra de linhas"></textarea>
									</fieldset>
								</div>
								<div class="col-12">
									<fieldset class="form-group text-center">
										<label for="squareText">Funcional em: (Inicío Clientes)</label>
									</fieldset>
								</div>
								<div class="col-12 text-center">
									<fieldset class="form-group">
										<button type="submit" name="adicionanoticia" class="btn btn-success">Adicionar</button>
										<?php if ($procnoticias->rowCount() > 0) {
											$noticia = $procnoticias->fetch(); ?>
											<a href="home.php?page=apis/gerenciar&delnoti=<?php echo $noticia['id']; ?>" name="remove" class="btn btn-danger">Desativar</a>
										<?php } ?>
									</fieldset>
								</div>
								<?php if ($procnoticias->rowCount() > 0) { ?>
									<div class="col-12">
									<center><h5 class="warning"><i class="fal fa-info-circle"></i> Existe uma Notificacão Ativa</h5></center>
								</div>
								<?php } ?>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>