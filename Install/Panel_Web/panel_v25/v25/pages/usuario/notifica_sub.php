<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST['idsubrev'])){

    $revendedor=$_POST['idsubrev'];
    $tipo=$_POST['tipo'];
    $msg=$_POST['msg'];

//verifica revendedor
    $SQLrev = "SELECT * FROM usuario where id_usuario='".$revendedor."' and subrevenda='sim' and id_mestre='".$_SESSION['usuarioID']."'";
    $SQLrev = $conn->prepare($SQLrev);
    $SQLrev->execute();

    if($SQLrev->rowCount()<=0){
        echo '<script type="text/javascript">';
        echo 	'alert("SUBRevendedor Não encontrado!");';
        echo	'window.location="../../home.php?page=usuario/subrevenda";';
        echo '</script>';
        exit;

    }
    $revenda=$SQLrev->fetch();

    if($revenda['tipo']<>'revenda'){
        echo '<script type="text/javascript">';
        echo 	'alert("Este usuario não é uma revenda!");';
        echo	'window.location="../../home.php?page=usuario/subrevenda";';
        echo '</script>';
        exit;
    }

    switch($tipo){
        case 1:$tipo='subrevenda';break;
        case 2:$tipo='outros';break;
        default:$tipo='erro';break;
    }

    if($tipo=='erro'){
        echo '<script type="text/javascript">';
        echo 	'alert("Erro no tipo escolha outro!");';
        echo	'window.location="../../home.php?page=usuario/subrevenda";';
        echo '</script>';
        exit;
    }


//Insere notificacao
    $usuarion=$revenda['id_usuario'];
    $msg=$msg;
    $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,mensagem) values ('".$usuarion."','".date('Y-m-d H:i:s')."','".$tipo."','".$msg."')";
    $notins = $conn->prepare($notins);
    $notins->execute();


    echo '<script type="text/javascript">';
    echo 	'alert("Usuário Reportado com Sucesso!");';
    echo	'window.location="../../home.php?page=usuario/subrevenda";';
    echo '</script>';






}


?>