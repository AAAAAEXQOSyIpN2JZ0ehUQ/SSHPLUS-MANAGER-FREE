<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST['tipo'])){

#Posts
$usuarioid=$_SESSION['usuarioID'];
$problema=$_POST['tipo'];
$login=$_POST['login'];
$motivo=$_POST['motivo'];
$msgprobl=$_POST['problema'];

switch($problema){case 1:$probl='contassh';break;
case 2:$probl='revendassh';break;
case 3:$probl='usuariossh';break;
case 4:$probl='servidor';break;
case 5:$probl='outros';break;
default:$probl='erro';break;
}

if($probl=='erro'){
	        echo '<script type="text/javascript">';
			echo 'alert("Selecione um Problema Primeiro!");';
			echo 'window.location="../../home.php?page=chamados/abrir";';
			echo '</script>';
			exit;
}

if($login==''){
	        echo '<script type="text/javascript">';
			echo 'alert("Informe um Login/Servidor/Conta SSH com Problemas!");';
			echo 'window.location="../../home.php?page=chamados/abrir";';
			echo '</script>';
			exit;
}

if($motivo==''){
	        echo '<script type="text/javascript">';
			echo 'alert("Informe um Motivo Principal!");';
			echo 'window.location="../../home.php?page=chamados/abrir";';
			echo '</script>';
			exit;
}
if($msgprobl==''){
	        echo '<script type="text/javascript">';
			echo 'alert("Por favor detalhe o problema!");';
			echo 'window.location="../../home.php?page=chamados/abrir";';
			echo '</script>';
			exit;
}


$verificausuario = "SELECT * FROM usuario where id_usuario= '".$usuarioid."'";
$verificausuario = $conn->prepare($verificausuario);
$verificausuario->execute();
$usuario=$verificausuario->fetch();

if(($probl=='revendassh')and($usuario['tipo']<>'revenda')){            echo '<script type="text/javascript">';
			echo 'alert("Você não é revendedor!");';
			echo 'window.location="../../home.php?page=chamados/abrir";';
			echo '</script>';
			exit;
}

if($usuario['id_mestre']<>0){//Sucesso
$criachamado = "insert into chamados (usuario_id,tipo,status,motivo,mensagem,data,id_mestre,login) values ('".$usuarioid."','".$probl."','aberto','".$motivo."','".$msgprobl."','".date('Y-m-d H:i:s')."','".$usuario['id_mestre']."','".$login."')";
$criachamado = $conn->prepare($criachamado);
$criachamado->execute();

//Insere notificacao ao Dono
$msg="O Usuário ".$usuario['nome']." Acabou de criar um Novo Chamado de Suporte Verifique!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem,admin) values ('".$usuario['id_mestre']."','".date('Y-m-d H:i:s')."','chamados','Admin','".$msg."','nao')";
$notins = $conn->prepare($notins);
$notins->execute();

}else{
//Sucesso
$criachamado = "insert into chamados (usuario_id,tipo,status,motivo,mensagem,data,login) values ('".$usuarioid."','".$probl."','aberto','".$motivo."','".$msgprobl."','".date('Y-m-d H:i:s')."','".$login."')";
$criachamado = $conn->prepare($criachamado);
$criachamado->execute();

//Insere notificacao ao ADM
$msg="O Usuário ".$usuario['nome']." Acabou de criar um Novo Chamado de Suporte Verifique!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem,admin) values ('0','".date('Y-m-d H:i:s')."','chamados','Admin','".$msg."','sim')";
$notins = $conn->prepare($notins);
$notins->execute();
}

echo '<script type="text/javascript">';
echo 'alert("Chamado criado com sucesso!\n Em Breve o Setor Responsavel irá te Responder");';
echo 'window.location="../../home.php?page=chamados/abertas";';
echo '</script>';


}