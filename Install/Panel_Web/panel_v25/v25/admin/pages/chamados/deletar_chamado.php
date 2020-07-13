<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_POST['chamado'])){

#Posts
$chamado=$_POST['chamado'];
$diretorio=$_POST['diretorio'];

$buscachamado = "SELECT * FROM chamados where id='".$chamado."'";
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
if($chama['status']<>'encerrado'){
	        echo '<script type="text/javascript">';
			echo 	'alert("Chamado precisa ser encerrado primeiro!");';
			echo	'window.location="'.$diretorio.'";';
			echo '</script>';
			exit;
}

//Sucesso
$updatechamado = "DELETE FROM chamados where id='".$chama['id']."'";
$updatechamado = $conn->prepare($updatechamado);
$updatechamado->execute();


echo '<script type="text/javascript">';
echo 'alert("Chamado deletado com sucesso!");';
echo 'window.location="'.$diretorio.'";';
echo '</script>';


}