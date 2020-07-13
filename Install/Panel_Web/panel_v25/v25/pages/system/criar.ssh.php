<?php
require_once('seguranca.php');
require_once('config.php');
require_once('classe.ssh.php');
$date = date("Y-m-d");
echo $date."<br>";



//Carrega servidor
$SQLSSH = "select * from servidor ";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();


if(($SQLSSH->rowCount()) > 0){

    while($row = $SQLSSH->fetch()){
        //Carrega servidor
        $SQLServidor = "select * from servidor WHERE id_servidor = '".$row['id_servidor']."' ";
        $SQLServidor = $conn->prepare($SQLServidor);
        $SQLServidor->execute();
        $servidor = $SQLServidor->fetch();
        //Realiza a comunicacao com o servidor
        $ip_servidor = $servidor['ip_servidor'];
        $loginSSH = $servidor['login_server'];
        $senhaSSH =  $servidor['senha'];
        $ssh = new SSH2($ip_servidor);
        $ssh->auth($loginSSH,$senhaSSH);
        $ssh->exec("cd /root");

        $ssh->exec("rm KillUser.sh");

        $ssh->exec("wget http://sshplus.xyz/revenda/confpainel/inst");

        $ssh->exec("chmod 777 inst");
        $ssh->output();

    }
}



?>