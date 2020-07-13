<?php

require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");


if(isset($_POST['usuarioid'])){

$SQLUsuario = "select * from usuario where id_usuario = '".$_POST['usuarioid']."' ";
$SQLUsuario = $conn->prepare($SQLUsuario);
$SQLUsuario->execute();
$usercount=$SQLUsuario->rowCount();

if($usercount==0){                    echo '<script type="text/javascript">';
			        echo 	'alert("Conta  Nao encontrada!");';
			        echo	'window.location="../../home.php?page=usuario/listar";';
			        echo '</script>';
			        exit;
}

$conta_ssh = $SQLUsuario->fetch();

if($conta_ssh['tipo']=='vpn'){
// Posts
$tipo=$_POST['tipofat'];
$quantidade=$_POST['qtd'];
$valor=$_POST['valor'];
$servidor=$_POST['servidorid'];
$desconto=$_POST['desconto'];
$vencimento=$_POST['venc'];
$msg=$_POST['msg'];
$contassh=$_POST['account'];

switch($tipo){case 1:$tipo='vpn';break;
case 2:$tipo='outros';break;
default:$tipo='erro';break;
}
if($tipo=='erro'){                             echo '<script type="text/javascript">';
			                 echo 	'alert("Erro na escolha do tipo!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}

if(!is_numeric($valor)){echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um valor!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}
if(!is_numeric($desconto)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um desconto!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}
if(!is_numeric($vencimento)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um vencimento numerico!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}
if($vencimento<1){$vencimento=1;}
if($quantidade<1){$quantidade=1;}
if($valor<1){$valor=1;}
if(!is_numeric($quantidade)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um quantidade numerico!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}

if($msg==''){	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Digite uma descrição!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}

if($tipo=='outros'){
//verifica servidor
$SQLserver = "SELECT * FROM servidor where id_servidor='".$servidor."'";
$SQLserver = $conn->prepare($SQLserver);
$SQLserver->execute();

if($SQLserver->rowCount()==0){                             echo '<script type="text/javascript">';
			                 echo 	'alert("Servidor não encontrado!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

$server=$SQLserver->fetch();
$data=date('Y-m-d H:i:s');
$dataexpire=date('Y-m-d 00:00:00',strtotime("+".$vencimento." days"));//insere fatura vpn em outros
$SQLinsere = "INSERT INTO fatura (usuario_id,servidor_id,conta_id,tipo,qtd,data,datavencimento,status,descrição,valor,desconto) values ('".$conta_ssh['id_usuario']."','".$server['id_servidor']."',0,'outros','".$quantidade."','".$data."','".$dataexpire."','pendente','".$msg."','".$valor."','".$desconto."')";
$SQLinsere = $conn->prepare($SQLinsere);
$SQLinsere->execute();

//Insere notificacao
$usuarion=$conta_ssh['id_usuario'];
$msg="Foi gerado uma nova fatura do tipo <small><b>Outros</b></small> veja!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".$data."','fatura','faturas/abertas','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

echo '<script type="text/javascript">';
echo 	'alert("Fatura Gerada com Sucesso!");';
echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
echo '</script>';


}elseif($tipo='vpn'){//verifica conta ssh
$SQLconta = "SELECT * FROM usuario_ssh where id_usuario_ssh='".$contassh."'";
$SQLconta = $conn->prepare($SQLconta);
$SQLconta->execute();

if($SQLconta->rowCount()==0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Conta não encontrado!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}
$sshacc=$SQLconta->fetch();
if($sshacc['id_usuario']<>$_POST['usuarioid']){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Usuario não é dono dessa SSH!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

//verifica fatura aberta
$SQLfatura = "SELECT * FROM fatura where conta_id='".$contassh."' and status='pendente'";
$SQLfatura = $conn->prepare($SQLfatura);
$SQLfatura->execute();

if($SQLfatura->rowCount()>0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Já Existe uma fatura em andamento para esta conta!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

$valorssh=ceil($valor*$sshacc['acesso']);
if($sshacc['acesso']>1){
$desc=$msg.'<small><b>+ Acessos</b></small>';
}else{
$desc=$msg;
}
$valorfinal=$valorssh;
$data=date('Y-m-d H:i:s');
$dataexpire=date('Y-m-d 00:00:00',strtotime("+".$vencimento." days"));
//insere fatura vpn
$SQLinsere = "INSERT INTO fatura (usuario_id,servidor_id,conta_id,tipo,qtd,data,datavencimento,status,descrição,valor,desconto) values ('".$conta_ssh['id_usuario']."','".$sshacc['id_servidor']."','".$sshacc['id_usuario_ssh']."','vpn','".$quantidade."','".$data."','".$dataexpire."','pendente','".$desc."','".$valorfinal."','".$desconto."')";
$SQLinsere = $conn->prepare($SQLinsere);
$SQLinsere->execute();

//Insere notificacao
$usuarion=$sshacc['id_usuario'];
$msg="Foi gerado uma nova fatura para <small><b>".$sshacc['login']."</b></small> veja!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".$data."','fatura','faturas/abertas','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

echo '<script type="text/javascript">';
echo 	'alert("Fatura Gerada com Sucesso!");';
echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
echo '</script>';

}


}elseif($conta_ssh['tipo']=='revenda'){

// Posts Revenda
$tipo=$_POST['tipofat'];
$quantidade=$_POST['qtd'];
$valor=$_POST['valor'];
$servidor=$_POST['servidorid'];
$desconto=$_POST['desconto'];
$vencimento=$_POST['venc'];
$msg=$_POST['msg'];

switch($tipo){
case 1:$tipo='revenda';break;
case 2:$tipo='outros';break;
default:$tipo='erro';break;
}
if($tipo=='erro'){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Erro na escolha do tipo!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}

if(!is_numeric($valor)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um valor!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}
if(!is_numeric($desconto)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um desconto!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}
if(!is_numeric($vencimento)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um vencimento numerico!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}
if($vencimento<1){$vencimento=1;}
if($quantidade<1){$quantidade=1;}
if($valor<1){$valor=1;}
if(!is_numeric($quantidade)){
echo '<script type="text/javascript">';
			                 echo 	'alert("Digite um quantidade numerico!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}

if($msg==''){
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Digite uma descrição!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;
}


if($tipo=='revenda'){//verifica servidor e acesso
$SQLconta = "SELECT * FROM acesso_servidor where id_servidor='".$servidor."' and id_usuario='".$_POST['usuarioid']."'";
$SQLconta = $conn->prepare($SQLconta);
$SQLconta->execute();

if($SQLconta->rowCount()==0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Servidor de Acesso não encontrado!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

$SQLserver = "SELECT * FROM servidor where id_servidor='".$servidor."'";
$SQLserver = $conn->prepare($SQLserver);
$SQLserver->execute();
$servi=$SQLserver->fetch();

if($SQLserver->rowCount()==0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Servidor não encontrado!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

//verifica fatura aberta
$SQLfatura = "SELECT * FROM fatura where servidor_id='".$servidor."' and usuario_id='".$conta_ssh['id_usuario']."' and status='pendente'";
$SQLfatura = $conn->prepare($SQLfatura);
$SQLfatura->execute();

if($SQLfatura->rowCount()>0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Já Existe uma fatura em andamento para este servidor!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

$data=date('Y-m-d H:i:s');
$dataexpire=date('Y-m-d 00:00:00',strtotime("+".$vencimento." days"));
//insere fatura revenda
$SQLinsere = "INSERT INTO fatura (usuario_id,servidor_id,conta_id,tipo,qtd,data,datavencimento,status,descrição,valor,desconto) values ('".$conta_ssh['id_usuario']."','".$servidor."',0,'revenda','".$quantidade."','".$data."','".$dataexpire."','pendente','".$msg."','".$valor."','".$desconto."')";
$SQLinsere = $conn->prepare($SQLinsere);
$SQLinsere->execute();

//Insere notificacao
$usuarion=$conta_ssh['id_usuario'];
$msg="Foi gerado uma nova fatura do Tipo <small><b>Revenda</b></small> Para o Servidor <small><b>".$servi['nome']."</b></small> veja!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".$data."','fatura','faturas/abertas','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

echo '<script type="text/javascript">';
echo 	'alert("Fatura Gerada com Sucesso!");';
echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
echo '</script>';


}elseif($tipo=='outros'){//verifica servidor e acesso
$SQLconta = "SELECT * FROM servidor where id_servidor='".$servidor."'";
$SQLconta = $conn->prepare($SQLconta);
$SQLconta->execute();

if($SQLconta->rowCount()==0){
                             echo '<script type="text/javascript">';
			                 echo 	'alert("Servidor não encontrado!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';
			                 exit;

}

$data=date('Y-m-d H:i:s');
$dataexpire=date('Y-m-d 00:00:00',strtotime("+".$vencimento." days"));
//insere fatura revenda
$SQLinsere = "INSERT INTO fatura (usuario_id,servidor_id,conta_id,tipo,qtd,data,datavencimento,status,descrição,valor,desconto) values ('".$conta_ssh['id_usuario']."','".$servidor."',0,'outros','".$quantidade."','".$data."','".$dataexpire."','pendente','".$msg."','".$valor."','".$desconto."')";
$SQLinsere = $conn->prepare($SQLinsere);
$SQLinsere->execute();

//Insere notificacao
$usuarion=$conta_ssh['id_usuario'];
$msg="Foi gerado uma nova fatura do Tipo <small><b>Outros</b></small> veja!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".$data."','fatura','faturas/abertas','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();

echo '<script type="text/javascript">';
echo 	'alert("Fatura Gerada com Sucesso!");';
echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
echo '</script>';


}




}








}




?>