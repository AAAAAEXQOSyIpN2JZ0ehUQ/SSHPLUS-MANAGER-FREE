<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_POST['clientevpn'])){

$cliente=$_POST['clientevpn'];
$tipo=$_POST['tipo'];
$msg=$_POST['msg'];

//verifica revendedor
$SQLrev = "SELECT * FROM usuario where id_usuario='".$cliente."'";
$SQLrev = $conn->prepare($SQLrev);
$SQLrev->execute();

if($SQLrev->rowCount()<=0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Revendedor Não encontrado!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';
			                 exit;

}
$revenda=$SQLrev->fetch();

if($revenda['tipo']<>'vpn'){
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Este usuario não é uma VPN!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';
			                 exit;
}
if($revenda['id_mestre']<>0){
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Este usuario é de um Revendedor!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';
			                 exit;
}

switch($tipo){
case 1:$tipo='fatura';break;
case 2:$tipo='outros';break;
default:$tipo='erro';break;
}

if($tipo=='erro'){
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Erro no tipo escolha outro!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';
			                 exit;
}


//Insere notificacao
$usuarion=$revenda['id_usuario'];
$msg=$msg;
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".date('Y-m-d H:i:s')."','".$tipo."','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();


                             echo '<script type="text/javascript">';
			                 echo 	'alert("ClienteVpn Notificado!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';






}


?>