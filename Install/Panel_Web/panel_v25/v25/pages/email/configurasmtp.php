<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST['servidor'])){

    $servidor=anti_sql_injection($_POST['servidor']);
    $empresa=anti_sql_injection($_POST['nomeempresa']);
    $porta=anti_sql_injection($_POST['porta']);
    $email=anti_sql_injection($_POST['email']);
    $senha=anti_sql_injection($_POST['senha']);
    $ssl=anti_sql_injection($_POST['ssl']);

    if(!is_numeric($porta)){
        echo '<script type="text/javascript">';
        echo 	'alert("Defina a porta corretamente!");';
        echo	'window.location="../../home.php?page=email/enviaremail";';
        echo '</script>';exit;
    }

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

    $buscasmtp = "SELECT * FROM smtp_usuarios WHERE usuario_id='".$_SESSION['usuarioID']."'";
    $buscasmtp = $conn->prepare($buscasmtp);
    $buscasmtp->execute();
    $conta=$buscasmtp->rowCount();
    if($conta>0){
        $smtp = $buscasmtp->fetch();
        $updatesmtp = "update smtp_usuarios set servidor='".$servidor."', empresa='".$empresa."', porta='".$porta."', email='".$email."', senha='".$senha."', ssl_secure='".$ssl."' WHERE usuario_id='".$smtp['usuario_id']."'";
        $updatesmtp = $conn->prepare($updatesmtp);
        $updatesmtp->execute();

        echo '<script type="text/javascript">';
        echo 	'alert("Sucesso SMTP Atualizado!");';
        echo	'window.location="../../home.php?page=email/enviaremail";';
        echo '</script>';

    }else{
        $updatesmtp = "insert into smtp_usuarios (usuario_id,servidor,empresa,porta,email,senha) values ('".$_SESSION['usuarioID']."','".$servidor."','".$empresa."','".$porta."','".$email."','".$senha."')";
        $updatesmtp = $conn->prepare($updatesmtp);
        $updatesmtp->execute();
        echo '<script type="text/javascript">';
        echo 	'alert("Sucesso SMTP Configurado!");';
        echo	'window.location="../../home.php?page=email/enviaremail";';
        echo '</script>';
    }
}


?>