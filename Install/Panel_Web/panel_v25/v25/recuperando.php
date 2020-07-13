<?php
require_once("pages/system/seguranca.php");
require_once("pages/system/funcoes.php");

if(isset($_POST['email'])){

$email=anti_sql_injection($_POST['email']);

if(filter_var($email, FILTER_VALIDATE_EMAIL))
{
$email=$email;
}
else
{
echo '<script type="text/javascript">';
echo 	'alert("Email invalido!");';
echo	'window.location="index.php";';
echo '</script>';exit;
}

# procura email
$SQLverifica = "select * from usuario where email='".$email."'";
$SQLverifica = $conn->prepare($SQLverifica);
$SQLverifica->execute();
$achou=$SQLverifica->rowCount();

if($achou>0){$recebe = $SQLverifica->fetch();

$login=$recebe['login'];
$senha=$recebe['senha'];

$data_envio = date('d/m/Y');
$hora_envio = date('H:i:s');
$nome=ucfirst($nome);
// Compo E-mail


	$arquivo = "

    <br /><b>Recuperação de Acesso</b>.<br />
	<b>Seus Dados de Login</b>:
	<br /><br />
    <b>Email</b>: $email <br />
    <b>Login</b>: $login <br />
    <b>Senha</b>: $senha <br />

    <br /><br />
    <b>1.</b>Caso não tenha Feito esta solicitação entre em contato Imediatamente com nosso suporte<br />

    <hr><br />
    Este e-mail foi enviado em <b>$data_envio</b> &agrave;s <b>$hora_envio
	";

// -------------------------

//enviar
$assunto='Recuperação de Dados';
$corpo=$arquivo;
$destino=$email;
$destinatario='Suporte - Tecnico';
$sucesso='Os dados foram encaminhados para o seu email com sucesso!';

require_once("recuperandoclasse.php");







}else{echo '<script type="text/javascript">';
echo 	'alert("Nenhuma conta encontrada com o email informado!");';
echo	'window.location="index.php";';
echo '</script>';
}



}

?>