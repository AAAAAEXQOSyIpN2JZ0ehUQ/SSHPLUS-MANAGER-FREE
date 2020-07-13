<?php
require_once('seguranca.php');
require_once('config.php');
require_once('funcoes.php');
require_once('classe.ssh.php');

$id_login = $argv[1];

//Carrega usuarioSSH ID
if (!empty($id_login)) {
    $SQLUsuarioSSH = "select * from usuario_ssh WHERE id_usuario_ssh = '".$id_login."' and status='1' and apagar='0'";
    $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
    $SQLUsuarioSSH->execute();
    $usuario_ssh = $SQLUsuarioSSH->fetch();

    $SQLDelSSH = "update usuario_ssh set status='3', apagar='3', id_usuario='0' WHERE id_usuario_ssh = '".$id_login."'  ";
    $SQLDelSSH = $conn->prepare($SQLDelSSH);
    $SQLDelSSH->execute();
}
?>