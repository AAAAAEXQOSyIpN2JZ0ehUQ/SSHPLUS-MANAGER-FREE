<?php
require_once('seguranca.php');
require_once('config.php');
require_once('classe.ssh.php');
$data = date("Y-m-d");




//Remove acesso conta ssh suspensa

$SQLSSH = "SELECT * FROM usuario_ssh where  status='2' and apagar='2' LIMIT 5";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();

if(($SQLSSH->rowCount()) > 0){
    while($row = $SQLSSH->fetch()){

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
        $newPass = "sersa7ha3";
        $ssh->exec("./AlterarSenha.sh ".$row['login']." ".$newPass."");
        $ssh->output();
        $ssh->exec("./KillUser.sh ".$row['login']." ");
        $ssh->output();



        $SQLSSH = "update usuario_ssh set status='2' , apagar='0', online='0'  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();
        echo "<br>Conta SSH suspensa no servidor!<br>".$row['login'];




    }

}else{
    echo "<br>Nenhuma Conta SSH suspensa no servidor!<br>";
}


//Libera acesso conta ssh suspensa

$SQLSSH = "SELECT * FROM usuario_ssh where  status='1' and apagar='1' LIMIT 5";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();

if(($SQLSSH->rowCount()) > 0){
    while($row = $SQLSSH->fetch()){
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

        $ssh->exec("./AlterarSenha.sh ".$row['login']." ".$row['senha']." ");
        $mensagem = (string) $ssh->output();

        $SQLSSH = "update usuario_ssh set status='1' , apagar='0'  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();
        echo "<br>ContaSSH: ".$row['login']." liberada no servidor!<br>";




    }

}else{
    echo "<br>Nenhuma Conta SSH liberada no servidor!<br>";
}


//Exclui  conta ssh
$SQLSSH = "SELECT * FROM usuario_ssh where  status='3'  and apagar ='3' ";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();

if(($SQLSSH->rowCount()) > 0){
    while($row = $SQLSSH->fetch()){
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


        $SQLSSH = "delete  from usuario_ssh  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();

        echo "<br>ContaSSH: ".$row['login']." excluida no servidor!<br>";




    }

}else{
    echo "<br>Nenhuma Conta SSH excluida no servidor!<br>";
}

//contas com erro
$SQLSSH = "SELECT * FROM usuario_ssh where  status='3'  and apagar ='0' ";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();

if(($SQLSSH->rowCount()) > 0){
    while($row = $SQLSSH->fetch()){
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


        $SQLSSH = "delete  from usuario_ssh  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();

        echo "<br>ContaSSH: ".$row['login']." com erro excluida!<br>";

    }

}else{
    echo "<br>Nenhuma Conta SSH com erro no servidor!<br>";
}


?>