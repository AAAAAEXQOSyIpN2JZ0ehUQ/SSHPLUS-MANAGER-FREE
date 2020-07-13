<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

protegePagina("admin");



if(isset($_POST['idcontassh'])){

#posts
$idconta=$_POST['idcontassh'];
$valor=$_POST['valor'];
$desconto=$_POST['desconto'];
$prazo=$_POST['prazo'];
$descricao=$_POST['msg'];


//Gerando faturas
$contassh = "SELECT * FROM usuario_ssh where id_usuario_ssh='".$idconta."'";
$contassh = $conn->prepare($contassh);
$contassh->execute();
$achou=$contassh->rowCount();
$ssh=$contassh->fetch();

if($achou==0){
        echo '<script type="text/javascript">';
		echo 	'alert("Conta não encontrada!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}elseif($ssh['id_usuario']==0){
        echo '<script type="text/javascript">';
		echo 	'alert("Essa conta é do sistema!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;

}

if(!is_numeric($valor)){
        echo '<script type="text/javascript">';
		echo 	'alert("Digite um numero valido!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}

if(!is_numeric($desconto)){
        echo '<script type="text/javascript">';
		echo 	'alert("Digite um numero valido!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}

if(!is_numeric($prazo)){
        echo '<script type="text/javascript">';
		echo 	'alert("Digite um numero valido!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}

if($valor<=0){
        echo '<script type="text/javascript">';
		echo 	'alert("Digite um valor maior ou igual a 1 real!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}

if($prazo<=0){
        echo '<script type="text/javascript">';
		echo 	'alert("Digite um prazo maior ou igual a 1 dia!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}

if($desconto>=$valor){        echo '<script type="text/javascript">';
		echo 	'alert("Desconto não pode ser maior ou igual ao valor da SSH!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}


//Procura fatura pendente
$fatura = "SELECT * FROM fatura where conta_id='".$idconta."' and status='pendente'";
$fatura = $conn->prepare($fatura);
$fatura->execute();
$achoufat=$fatura->rowCount();
if($achoufat>0){
        echo '<script type="text/javascript">';
		echo 	'alert("Já existe uma fatura em andamento para esta conta!");';
		echo	'window.location="../../home.php?page=ssh/contas";';
		echo '</script>';
		exit;
}

$valorssh=ceil($valor*$ssh['acesso']);
$data=date('Y-m-d H:i:s');
$dataexpire=date('Y-m-d 00:00:00',strtotime("+ ".$prazo." days"));

$desc=$descricao;

//Insere fatura
$faturains = "insert into fatura (usuario_id,servidor_id,conta_id,tipo,qtd,data,datavencimento,status,descrição,valor,desconto) values ('".$ssh['id_usuario']."','".$ssh['id_servidor']."','".$ssh['id_usuario_ssh']."','vpn','1','".$data."','".$dataexpire."','pendente','".$desc."','".$valorssh."','0')";
$faturains = $conn->prepare($faturains);
$faturains->execute();

//Insere notificacao
$usuarion=$ssh['id_usuario'];
$msg="Foi gerado uma nova fatura para <small><b>".$ssh['login']."</b></small> veja!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".$data."','fatura','faturas/abertas','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

echo '<script type="text/javascript">';
echo 	'alert("Fatura Criada com Sucesso!");';
echo	'window.location="../../home.php?page=ssh/contas";';
echo '</script>';



}