<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_POST['email'])){
$login=anti_sql_injection($_POST['login']);
$senha=anti_sql_injection($_POST['senha']);
$link=anti_sql_injection($_POST['link']);
$assunto=anti_sql_injection($_POST['assunto']);
$msg=anti_sql_injection($_POST['msg']);
$validade=anti_sql_injection($_POST['validade']);
$contatipo=anti_sql_injection($_POST['tipoconta']);
$modelo=anti_sql_injection($_POST['tipomodelo']);


// Seleção do email
$emailservidor=$_POST['servidoremail'];

switch($emailservidor){case 1:$server='decido';break;
case 2:$server='@gmail.com';break;
case 3:$server='@outlook.com';break;
case 4:$server='@hotmail.com';break;
default:$server='@yahoo.com.br';break;
}
$email=anti_sql_injection($_POST['email']);

if($server=='decido'){$email=$email;
}else{$email=$email.$server;
}


$buscanosm = "SELECT * FROM smtp WHERE usuario_id='".$_SESSION['usuarioID']."'";
$buscanosm = $conn->prepare($buscanosm);
$buscanosm->execute();
$conta=$buscanosm->rowCount();

if($conta<=0){echo '<script type="text/javascript">';
echo 	'alert("Você não configurou o servidor SMTP!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;}
$smtp = $buscanosm->fetch();


if(filter_var($email, FILTER_VALIDATE_EMAIL))
{
$email=$email;
}
else
{
echo '<script type="text/javascript">';
echo 	'alert("Email invalido!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}

if($modelo==1){
if($assunto==''){echo '<script type="text/javascript">';
echo 	'alert("Digite o Assunto!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}
if($msg==''){
echo '<script type="text/javascript">';
echo 	'alert("Digite a Mensagem!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}
}elseif($modelo==2){
if($login==''){
echo '<script type="text/javascript">';
echo 	'alert("Digite um login!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}
if($senha==''){
echo '<script type="text/javascript">';
echo 	'alert("Digite uma senha!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}
if($link==''){
echo '<script type="text/javascript">';
echo 	'alert("Digite um Endereço ou IP!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}
if($validade==''){
echo '<script type="text/javascript">';
echo 	'alert("Digite uma validade!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}
}
if($senha<>''){$senha_corpo="<b>Senha</b>: $senha<br />";
}else{$senha_corpo="";}
if($login<>''){
$login_corpo="<b>Login</b>: $login <br />";
}else{$login_corpo="";}
if($link<>''){
$link_corpo="<b>Link de acesso</b>: <a href='$link' target='_blank'>$link</a><br /><br />";
}else{$link_corpo="";}
$data_envio = date('d/m/Y');
$hora_envio = date('H:i:s');
$ass=$assunto;
if($msg<>''){$msg2="<b>Mensagem</b>:<br />$mensagem";
}else{$msg="";
}
if($assunto==""){if($modelo==1){$assunto="Suporte TI";
}elseif($modelo==2){$assunto="Compra Efetuada";
}
}
$emailadm=$smtp['email'];
if($validade==''){$validadetecnico="";
}else{$validadetecnico="<b>Validade</b>: $validade Dias<br />";
}
// Compo E-mail

if($modelo==1){
	$arquivo = "

	<br /><b>Suporte Tecnico</b><br />
	<b>Informações Tecnicas Detalhadas</b>:
	<br /><br />
    <b>Assunto</b>: $ass <br />
    $login_corpo
    $senha_corpo
    $validadetecnico
    $link_corpo


    <b>Mensagem</b>:<br />
    $msg
    <hr><br />
    Este e-mail foi enviado em <b>$data_envio</b> &agrave;s <b>$hora_envio


	";

}elseif($modelo==2){

    switch($contatipo){
    case 1:$tip='sshconta';break;
    case 2:$tip='sshacesso';break;
    default:$tip='sshconta';break;
    }

    if($tip=='sshconta'){
    $link_corpo="<b>IP para conexão</b>: <a href='$link' target='_blank'>$link</a><br /><br />";
    $portas_corpo="<b>Portas Squid</b>: 80,8080,8799,3128 <br />";
    $portassh_corpo="<b>Portas SSH</b>: 22,443 <br />";

    if($assunto<>''){
    $ass=$assunto;
    }else{
    $ass='Entrega de conta <b>SSH</b>';
    }

    }elseif($tip='sshacesso'){
    $link_corpo=$link_corpo;
     if($assunto<>''){
    $ass=$assunto;
    }else{
    $ass='Acesso Painel V4.1';
    }
    $todascontas="<b>4.</b>Todas suas contas <b>SSH</b> encontra-se dentro deste painel automatíco.";
    }
	$arquivo = "
	<br /><b>Obrigado pela compra.</b><br />
	<b>Seus Dados</b>:
	<br /><br />
    <b>Assunto</b>: $ass <br />
    $login_corpo
    $senha_corpo
    <b>Validade</b>: $validade Dias<br />
    $portas_corpo
    $portassh_corpo
    $link_corpo
    $msg2
    <br /><br />
    <b>1.</b>Duvidas e Suporte Entre em Contato com <a href='$emailadm'>$emailadm.</a><br />
    <b>2.</b>Temos um Grupo Especial para Revendedores, caso seja um deles solicite o link através do contato.<br />
    <b>3.</b>Recomendamos Arquivar esse email para não perder os dados da sua conta.<br />
    $todascontas
    <hr><br />
    Este e-mail foi enviado em <b>$data_envio</b> &agrave;s <b>$hora_envio


	";
}else{echo '<script type="text/javascript">';
echo 	'alert("Modelo não selecionado!");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';exit;
}

// -------------------------
$de=explode("@",$email);
//enviar
$assunto="[".$assunto."]"."[SEUSiteSSH]";
$corpo=$arquivo;
$destino=$email;
$destinatario=strtoupper($de[0]);
$sucesso='Email enviado, o cliente receberá na caixa de entrada.';



# Exemplo de envio de e-mail SMTP PHPMailer - www.secnet.com.br
#
# Inclui o arquivo class.phpmailer.php localizado na pasta phpmailer
require_once("../phpmailer/class.phpmailer.php");
require_once("../phpmailer/class.smtp.php");

# Inicia a classe PHPMailer
$mail = new PHPMailer();

# Define os dados do servidor e tipo de conexão
$mail->IsSMTP(); // Define que a mensagem será SMTP
$mail->SMTPSecure = $smtp['ssl_secure'];    // SSL REQUERIDO pelo GMail
$mail->Host = $smtp['servidor']; # Endereço do servidor SMTP
$mail->Port = $smtp['porta']; // Porta TCP para a conexão
$mail->SMTPDebug = 0; // 1 = erros e mensagens || 2 = apenas mensagens
$mail->SMTPAuth = true; # Usar autenticação SMTP - Sim
$mail->Username = $smtp['email']; # Usuário de e-mail
$mail->Password = $smtp['senha']; // # Senha do usuário de e-mail

# Define o remetente (você)
$mail->From = $smtp['email']; # Seu e-mail
$mail->FromName = "Administração"; // Seu nome

# Define os destinatário(s)
$mail->AddAddress($destino,$destinatario); # Os campos podem ser substituidos por variáveis
#$mail->AddAddress('webmaster@nomedoseudominio.com'); # Caso queira receber uma copia
#$mail->AddCC('ciclano@site.net', 'Ciclano'); # Copia
#$mail->AddBCC('fulano@dominio.com.br', 'Fulano da Silva'); # Cópia Oculta

# Define os dados técnicos da Mensagem
$mail->IsHTML(true); # Define que o e-mail será enviado como HTML
$mail->CharSet = 'UTF-8';
#$mail->CharSet = 'iso-8859-1'; # Charset da mensagem (opcional)

# Define a mensagem (Texto e Assunto)
$mail->Subject = $assunto; # Assunto da mensagem
$mail->Body = "'".$corpo."'";
/*$mail->AltBody = "Este é o corpo da mensagem de teste, somente Texto! \r\n :)"; */

# Define os anexos (opcional)
#$mail->AddAttachment("c:/temp/documento.pdf", "documento.pdf"); # Insere um anexo

# Envia o e-mail
$enviado = $mail->Send();

# Limpa os destinatários e os anexos
$mail->ClearAllRecipients();
$mail->ClearAttachments();

# Exibe uma mensagem de resultado (opcional)
if ($enviado) {
echo '<script type="text/javascript">';
echo 	'alert("'.$sucesso.'");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';
} else {
// echo "Não foi possível enviar o e-mail.";
// echo "<b>Informações do erro:</b> " . $mail->ErrorInfo;
echo '<script type="text/javascript">';
echo 	'alert("Erro ao enviar: '.$mail->ErrorInfo.'");';
echo	'window.location="../../home.php?page=email/enviaremail";';
echo '</script>';
}






}

?>