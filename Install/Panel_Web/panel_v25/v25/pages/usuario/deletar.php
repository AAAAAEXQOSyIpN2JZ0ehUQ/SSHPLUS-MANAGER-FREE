<?php
include '/var/www/html/pages/system/mysqli.php';
include '/var/www/html/pages/system/config.php';
require_once('/var/www/html/pages/system/classe.ssh.php');
// A sessão precisa ser iniciada em cada página diferente
if (!isset($_SESSION)) session_start();

// Verifica se não há a variável da sessão que identifica o usuário
if (!isset($_SESSION['id'])) {
    // Destrói a sessão por segurança

    session_destroy();
    // Redireciona o visitante de volta pro login
    header("Location: login.php"); exit;
}else{
    if( isset($_GET["id_usuario"]) ){
        $res_user = $mysqli->query("select * from usuario where id_usuario = '".$_GET['id_usuario']."' and id_mestre='".$_SESSION['id']."' ") or die($mysqli->error);
        if($res_user->num_rows>0){
            $res_ssh = $mysqli->query("select * from usuario_ssh WHERE id_usuario = '".$_GET['id_usuario']."' ") or die($mysqli->error);
            if($res_ssh->num_rows > 0){
                while($row = $res_ssh->fetch_assoc()) {
                    $res_server = $mysqli->query("select * from servidor WHERE id_servidor = '".$row['id_servidor']."' ") or die($mysqli->error);
                    $servidor = $res_server->fetch_assoc();
                    $ip_servidor= $servidor['ip_servidor'];
                    $loginSSH= $servidor['login_server'];
                    $senhaSSH=  $servidor['senha'];

                    $ssh = new SSH2($ip_servidor);
                    $ssh->auth($loginSSH,$senhaSSH);
                    $ssh->exec("./ExcluirUsuario.sh ".$row['login']." ");
                    $mensagem = (string) $ssh->output();
                    $mensagem2 = strcmp($mensagem, "apagado");
                    if($mensagem2 == 1){
                        $excluir_ssh = $mysqli->query("delete  from usuario_ssh WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."' ") or die($mysqli->error);

                    }else{

                        $update_ssh = $mysqli->query("update usuario_ssh set id_usuario='0', apagar='1' WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."' ") or die($mysqli->error);


                    }
                }
                $excluir = $mysqli->query("delete from usuario WHERE id_usuario = '".$_GET['id_usuario']."' and id_mestre='".$_SESSION['id']."'  ") or die($mysqli->error);
                echo '<script type="text/javascript">';
                echo 	'alert("Excluido com sucesso!");';
                echo	'window.location="home.php?page=usuario/listar";';
                echo '</script>';

            }else{
                $excluir = $mysqli->query("delete from usuario WHERE id_usuario = '".$_GET['id_usuario']."' and id_mestre='".$_SESSION['id']."'  ") or die($mysqli->error);
                echo '<script type="text/javascript">';
                echo 	'alert("Excluido com sucesso!");';
                echo	'window.location="home.php?page=usuario/listar";';
                echo '</script>';
            }

        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Nao encontrado");';
            echo	'window.location="home.php?page=usuario/listar";';
            echo '</script>';
        }

    }else{
        echo '<script type="text/javascript">';
        echo 	'alert("Nao encontrado");';
        echo	'window.location="home.php?page=usuario/listar";';
        echo '</script>';
    }


}

?>