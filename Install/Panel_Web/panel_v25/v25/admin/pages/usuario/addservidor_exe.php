<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

protegePagina("admin");

if(isset($_POST["servidor"])){

#Post
$servidor=anti_sql_injection($_POST["servidor"]);
$revendedor=anti_sql_injection($_POST["revendedor"]);
$dias=anti_sql_injection($_POST["dias"]);
$limite=anti_sql_injection($_POST["limite"]);

if(!is_numeric($limite)){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número!");';
echo	'window.location="../../home.php?page=subrevenda/adicionar";';
echo '</script>';
exit;
}
if(!is_numeric($dias)){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número!");';
echo	'window.location="../../home.php?page=subrevenda/adicionar";';
echo '</script>';
exit;
}
if($dias<=0){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número valido!");';
echo	'window.location="../../home.php?page=subrevenda/adicionar";';
echo '</script>';
exit;
}

$buscaeu = "SELECT * FROM usuario where id_usuario= '".$revendedor."'";
$buscaeu = $conn->prepare($buscaeu);
$buscaeu->execute();

if($buscaeu->rowCount()==0){
	        echo '<script type="text/javascript">';
			echo 	'alert("Sua conta não foi encontrada!");';
			echo	'window.location="../home.php?page=usuario/addservidor";';
			echo '</script>';
			exit;
}
$ele=$buscaeu->fetch();


if($ele['subrevenda']=='sim'){
echo '<script type="text/javascript">';
echo 	'alert("Você não pode editar/adicionar um subrevendedor diretamente!");';
echo	'window.location="../../home.php?page=subrevenda/adicionar";';
echo '</script>';
exit;
}

$buscaserver2 = "SELECT * FROM servidor where id_servidor='".$servidor."'";
$buscaserver2 = $conn->prepare($buscaserver2);
$buscaserver2->execute();

if($buscaserver2->rowCount()==0){
echo '<script type="text/javascript">';
echo 	'alert("Servidor não encontrado!");';
echo	'window.location="../../home.php?page=subrevenda/adicionar";';
echo '</script>';
exit;
}

$served=$buscaserver2->fetch();

$buscaserver3 = "SELECT * FROM acesso_servidor where id_servidor='".$servidor."' and id_usuario='".$revendedor."'";
$buscaserver3 = $conn->prepare($buscaserver3);
$buscaserver3->execute();

if($buscaserver3->rowCount()>0){
echo '<script type="text/javascript">';
echo 	'alert("Ele já possui acesso neste servidor \n Você precisa Retirar ou Editar o Servidor dele \n Você pode adicionar um outro servidor para Ele!");';
echo	'window.location="../../home.php?page=subrevenda/adicionar";';
echo '</script>';
exit;
}

$add=date('Y-m-d',strtotime('+ '.$dias.' days'));

//Sucesso
$SQLSucesso = "insert into acesso_servidor (id_servidor,id_usuario,qtd,validade) values ('".$servidor."','".$revendedor."','".$limite."','".$add."')";
$SQLSucesso = $conn->prepare($SQLSucesso);
$SQLSucesso->execute();


//Insere notificacao
$msg="O Admin Adicionou um Servidor a sua conta <b>".$served['nome']."</b> Limite: ".$limite." Validade: ".$dias." dias";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$revendedor."','".date('Y-m-d H:i:s')."','revenda','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();


echo '<script type="text/javascript">';
echo 	'alert("Servidor Adicionado Com Sucesso!");';
echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$revendedor['usuario'] .' ";';
echo '</script>';

}

?>