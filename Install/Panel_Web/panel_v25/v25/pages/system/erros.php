<?php
require_once('seguranca.php');
require_once('config.php');
require_once('funcoes.php');
require_once('classe.ssh.php');


$SQLERRO = "SELECT * FROM usuario_ssh where  status='3'  and apagar ='0' ";
$SQLERRO = $conn->prepare($SQLERRO);
$SQLERRO->execute();

if(($SQLERRO->rowCount()) > 0){
    while($row = $SQLERRO->fetch()){
        //Carrega servidor
        $SQLServidor = "select * from servidor WHERE id_servidor = '".$row['id_servidor']."'";
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


        $SQLERRO = "delete  from usuario_ssh  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
        $SQLERRO = $conn->prepare($SQLERRO);
        $SQLERRO->execute();

        echo "<br>ContaSSH: ".$row['login']." excluida no servidor!<br>";

    }

}else{
    echo "<br>Nenhuma Conta SSH excluida no servidor!<br>";
}

?>