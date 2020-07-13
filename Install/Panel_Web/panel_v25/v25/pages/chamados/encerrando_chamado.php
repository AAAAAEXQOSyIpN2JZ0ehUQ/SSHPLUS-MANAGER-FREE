<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST['chamado'])){

#Posts
$chamado=$_POST['chamado'];
$diretorio=$_POST['diretorio'];

$buscachamado = "SELECT * FROM chamados where id='".$chamado."' and usuario_id='".$_SESSION['usuarioID']."'";
$buscachamado = $conn->prepare($buscachamado);
$buscachamado->execute();

if($buscachamado->rowCount()==0){
	        echo '<script type="text/javascript">';
			echo 	'alert("Chamado não encontrado!");';
			echo	'window.location="'.$diretorio.'";';
			echo '</script>';
			exit;
}
$chama=$buscachamado->fetch();
if($chama['status']=='encerrado'){
	        echo '<script type="text/javascript">';
			echo 	'alert("Chamado já resolvido!");';
			echo	'window.location="'.$diretorio.'";';
			echo '</script>';
			exit;
}

//Sucesso
$updatechamado = "UPDATE chamados set status='encerrado', data='".date('Y-m-d H:i:s')."' where id= '".$chama['id']."'";
$updatechamado = $conn->prepare($updatechamado);
$updatechamado->execute();

$verificausuario = "SELECT * FROM usuario where id_usuario= '".$_SESSION['usuarioID']."'";
$verificausuario = $conn->prepare($verificausuario);
$verificausuario->execute();
$usuario=$verificausuario->fetch();

//Insere notificacao ao ADM
$msg="O Usuário ".$usuario['nome']." Acabou de Encerrar o Chamado N°".$chama['id']." de Suporte não precisa mais resolver!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem,admin) values ('0','".date('Y-m-d H:i:s')."','chamados','Admin','".$msg."','sim')";
$notins = $conn->prepare($notins);
$notins->execute();

echo '<script type="text/javascript">';
echo 'alert("Chamado Encerrado com sucesso!");';
echo 'window.location="'.$diretorio.'";';
echo '</script>';


}