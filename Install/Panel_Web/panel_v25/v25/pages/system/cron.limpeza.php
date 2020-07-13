<?php 
require_once('seguranca.php');
require_once('config.php');
require_once('classe.ssh.php');
require_once('funcoes.php');

    $SQLLimpeza = "TRUNCATE TABLE `hist_usuario_ssh_online`"; 
    $SQLLimpeza = $conn->prepare($SQLLimpeza);
	$SQLLimpeza->execute();
?>