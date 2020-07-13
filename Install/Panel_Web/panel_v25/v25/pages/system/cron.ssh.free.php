<?php
require_once('seguranca.php');
require_once('config.php');
require_once('classe.ssh.php');
$data = date("Y-m-d");

// Feito Por Junior Rios
// Exclui  conta ssh free vencida
$SQLSSH = "SELECT * FROM usuario_ssh_free where  validade<='".date('Y-m-d H:i:s')."'";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();

if(($SQLSSH->rowCount()) > 0){
    while($row = $SQLSSH->fetch()){
        //Carrega servidor
        $SQLServidor = "select * from servidor WHERE id_servidor = '".$row['servidor']."'";
        $SQLServidor = $conn->prepare($SQLServidor);
        $SQLServidor->execute();
        $servidor = $SQLServidor->fetch();

        //Realiza a comunicacao com o servidor
        $ip_servidor= $servidor['ip_servidor'];
        $loginSSH= $servidor['login_server'];
        $senhaSSH=  $servidor['senha'];
        $ssh = new SSH2($ip_servidor);
        $ssh->auth($loginSSH,$senhaSSH);

        $ssh->exec("./remover.sh ".$row['login']." ");
        $mensagem = (string) $ssh->output();


        $SQLSSH = "delete  from usuario_ssh_free  WHERE id = '".$row['id']."'  ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();

        echo "<br>ContaSSH: ".$row['login']." excluida no servidor!<br>";




    }

}else{
    echo "<br>Nenhuma Conta SSH excluida no servidor!<br>";
}

