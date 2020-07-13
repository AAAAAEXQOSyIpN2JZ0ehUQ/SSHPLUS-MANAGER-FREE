<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_POST['clientes'])){

$clientes=anti_sql_injection($_POST['clientes']);
$msg=anti_sql_injection($_POST['msg']);

echo $clientes;

switch($clientes){
case 1:$cliente='todos';break;
case 2:$cliente='revenda';break;
case 3:$cliente='vpn';break;
default:$cliente='erro';break;
}

$tipo='outros';

if($cliente=='erro'){
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Erro no tipo de cliente!");';
			                 echo	'window.location="../../home.php";';
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
$msg=$msg;
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$row['id_usuario']."','".date('Y-m-d H:i:s')."','".$tipo."','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

}


}


                             echo '<script type="text/javascript">';
			                 echo 	'alert("Clientes Notificados!");';
			                 echo	'window.location="../../home.php";';
			                 echo '</script>';






}


?>