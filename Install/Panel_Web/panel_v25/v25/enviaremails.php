<?php
#
# Exemplo de envio de e-mail SMTP PHPMailer - www.secnet.com.br
#
# Inclui o arquivo class.phpmailer.php localizado na pasta phpmailer
require_once("phpmailer/class.phpmailer.php");
require_once("phpmailer/class.smtp.php");

# Inicia a classe PHPMailer
$mail = new PHPMailer();

# Define os dados do servidor e tipo de conexão
$mail->IsSMTP(); // Define que a mensagem será SMTP
$mail->SMTPSecure = $ssl_smtp;    // SSL REQUERIDO pelo GMail
$mail->Host = $servidor_smtp; # Endereço do servidor SMTP
$mail->Port = $porta_smtp; // Porta TCP para a conexão
$mail->SMTPDebug = 0; // 1 = erros e mensagens || 2 = apenas mensagens
$mail->SMTPAuth = true; # Usar autenticação SMTP - Sim
$mail->Username = $email_smtp; # Usuário de e-mail
$mail->Password = $senha_smtp; // # Senha do usuário de e-mail

# Define o remetente (você)
$mail->From = $email_smtp; # Seu e-mail
$mail->FromName = "Suporte - SSH"; // Seu nome

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
?>