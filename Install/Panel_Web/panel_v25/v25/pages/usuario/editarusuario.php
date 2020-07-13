<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST["id_usuario"])){

#Post
    $usuario=$_POST["id_usuario"];
    $login=$_POST["login"];
    $senha=$_POST["senha"];
    $email=$_POST["email"];
    $celular=$_POST["celular"];
    $diretorio=$_POST["diretorio"];

    $SQLusuario = "select * from usuario where id_usuario = '".$usuario."'  ";
    $SQLusuario = $conn->prepare($SQLusuario);
    $SQLusuario->execute();

    if($SQLusuario->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Usuario não encontrado");';
        echo	'window.location="'.$diretorio.'";';
        echo '</script>';
        exit;
    }

    $user=$SQLusuario->fetch();

    if($user['id_mestre']<>$_SESSION['usuarioID']){
        echo '<script type="text/javascript">';
        echo 	'alert("Você não é dono desta conta");';
        echo	'window.location="'.$diretorio.'";';
        echo '</script>';
        exit;
    }

    if(strlen($login)<5){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite mais que 5 Letras/Números");';
        echo	'window.location="'.$diretorio.'";';
        echo '</script>';
        exit;
    }

    if(strlen($senha)<5){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite mais que 5 Letras/Números");';
        echo	'window.location="'.$diretorio.'";';
        echo '</script>';
        exit;
    }

    if(filter_var($email, FILTER_VALIDATE_EMAIL))
    {
        $email=$email;
    }
    else
    {
        echo '<script type="text/javascript">';
        echo 	'alert("Email invalido!");';
        echo	'window.location="'.$diretorio.'";';
        echo '</script>';exit;
    }

#sucesso
    $SQLupdate = "update usuario set login='".$login."', senha='".$senha."', email='".$email."', celular='".$celular."' where id_usuario = '".$usuario."'  ";
    $SQLupdate = $conn->prepare($SQLupdate);
    $SQLupdate->execute();

    echo '<script type="text/javascript">';
    echo 	'alert("Dados Alterado com sucesso!");';
    echo	'window.location="'.$diretorio.'";';
    echo '</script>';

}