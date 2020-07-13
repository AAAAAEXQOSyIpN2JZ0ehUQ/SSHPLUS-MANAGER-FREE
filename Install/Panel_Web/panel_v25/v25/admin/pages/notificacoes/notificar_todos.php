<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_POST['clientes'])){

$clientes=$_POST['clientes'];
$tipo=$_POST['tipo'];
$msg=$_POST['msg'];

//verifica revendedor
$SQLrev = "SELECT * FROM usuario where id_usuario='".$cliente."'";
$SQLrev = $conn->prepare($SQLrev);
$SQLrev->execute();

switch($clientes){
case 1:$cliente='todos';break;
case 2:$cliente='revenda';break;
case 3:$cliente='vpn';break;
default:$cliente='erro';break;
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

if($cliente=='erro'){
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Erro no tipo de cliente!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';
			                 exit;
}

//verifica clientes
if($cliente=='todos'){
$SQLcli = "SELECT * FROM usuario";
}else{
$SQLcli = "SELECT * FROM usuario where tipo='".$cliente."'";
}
$SQLcli = $conn->prepare($SQLcli);
$SQLcli->execute();

if ($SQLcli->rowCount()>0) {

while($row=$SQLcli->fetch()){
//Insere notificacao
$usuarion=$row['id_usuario'];
$msg=$msg;
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".date('Y-m-d H:i:s')."','".$tipo."','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

}


}


                             echo '<script type="text/javascript">';
			                 echo 	'alert("Clientes Notificados!");';
			                 echo	'window.location="../../home.php?page=notificacoes/notificar";';
			                 echo '</script>';






}


?>