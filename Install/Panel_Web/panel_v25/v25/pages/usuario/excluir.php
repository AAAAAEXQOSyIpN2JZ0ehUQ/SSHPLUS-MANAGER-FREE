<?php
include "../system/mysqli.php";
include "../system/config.php";
// A sessão precisa ser iniciada em cada página diferente
if (!isset($_SESSION)) session_start();

// Verifica se não há a variável da sessão que identifica o usuário
if (!isset($_SESSION['id'])) {
    // Destrói a sessão por segurança

    session_destroy();
    // Redireciona o visitante de volta pro login
    header("Location: login.php"); exit;
}else{

    if(isset($_GET["id_usuario"])) {
        $res_usuario = $mysqli->query("select * from usuario WHERE id_usuario = '".$_GET['id_usuario']."' and id_mestre = '".$_SESSION['id']."' ") or die($mysqli->error);
        if($res_usuario->num_rows > 0){

            $res_ssh = $mysqli->query("select * from usuario_ssh WHERE id_usuario = '".$_GET['id_usuario']."' ") or die($mysqli->error);
            if($res_ssh->num_rows > 0){

                echo '<script type="text/javascript">';
                echo 	'alert("Existem contas criadas neste usuario!");';
                echo	'window.location="home.php?page=usuario/listar";';
                echo '</script>';

            }else{
                $excluir = $mysqli->query("delete from usuario WHERE id_usuario = '".$_GET['id_usuario']."' ") or die($mysqli->error);
                echo '<script type="text/javascript">';
                echo 	'alert("Excluido com sucesso!");';
                echo	'window.location="home.php?page=usuario/listar";';
                echo '</script>';
            }

        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Usuario nao encontrado!");';
            echo	'window.location="home.php?page=usuario/listar";';
            echo '</script>';
        }
    }else{
        echo '<script type="text/javascript">';
        echo 	'alert("Preencha todos os campos!");';
        echo	'window.location="home.php?page=usuario/listar";';
        echo '</script>';
    }


}

?>