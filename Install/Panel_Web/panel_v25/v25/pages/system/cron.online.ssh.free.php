<?php
require_once('seguranca.php');
require_once('config.php');
require_once('classe.ssh.php');
$data = date("Y-m-d H:i:s");
echo $data."<br>";
$data_hora_atual = date("Y-m-d H:i:s");


//Historico
$SQLSelectSSH = "SELECT * FROM usuario_ssh_free  WHERE online = '0'    ";
$SQLSelectSSH = $conn->prepare($SQLSelectSSH);
$SQLSelectSSH->execute();

if(($SQLSelectSSH->rowCount()) > 0){
    while($ssh = $SQLSelectSSH->fetch()){
        $SQLHistSSH = "update hist_usuario_ssh_online_free set hora_desconexao='".$data."' , status='0'
				                    WHERE status='1' and id_usuario='".$ssh['id']."' ";
        $SQLHistSSH = $conn->prepare($SQLHistSSH);
        $SQLHistSSH->execute();

    }

}


$SQLUPSSH = "update usuario_ssh_free set online_hist='0'  WHERE online = '0'    ";
$SQLUPSSH = $conn->prepare($SQLUPSSH);
$SQLUPSSH->execute();


//Remove acesso conta ssh suspensa

$SQLServidor = "SELECT * FROM servidor where tipo='free'";
$SQLServidor = $conn->prepare($SQLServidor);
$SQLServidor->execute();

if(($SQLServidor->rowCount()) > 0){

    while($row = $SQLServidor->fetch()){

        $SQLUPSSH = "update usuario_ssh_free set online='0'  WHERE servidor = '".$row['id_servidor']."'    ";
        $SQLUPSSH = $conn->prepare($SQLUPSSH);
        $SQLUPSSH->execute();




        //Realiza a comunicacao com o servidor
        $ip_servidor= $row['ip_servidor'];
        $loginSSH= $row['login_server'];
        $senhaSSH=  $row['senha'];
        $ssh = new SSH2($ip_servidor);
        $ssh->auth($loginSSH,$senhaSSH);

        $ssh->exec("./sshmonitor.sh ");
        $mensagem = (string) $ssh->output();

        $partes = explode(",", $mensagem);
        $Array = array();

        for($i = 0;$i <=count($partes);$i++){

            $user = trim($partes[$i]," ");
            $user2 = trim($user,",");
            $Array[$i] = (String) $user2;




        }

        for($i = 0;$i <count($Array);$i++){

            $character_mask = " \t\n\r\0\x0B" ;
            $user =  trim (  $Array[$i] ,  $character_mask);


            $SQLSSHServidor = "SELECT * FROM usuario_ssh_free where login='$user' ";
            $SQLSSHServidor = $conn->prepare($SQLSSHServidor);
            $SQLSSHServidor->execute();
            if(($SQLSSHServidor->rowCount()) > 0){
                $sssh =  $SQLSSHServidor->fetch();


                if($sssh['online_hist'] == 0){
                    $SQLUPSSH = "update usuario_ssh_free set online='".$Array[$i+1]."' , online_hist='1' ,
						                online_start = '".$data_hora_atual."' WHERE login = '$user'  ";
                    $SQLUPSSH = $conn->prepare($SQLUPSSH);
                    $SQLUPSSH->execute();


                    //Historico de conexao
                    $SQLHistSSH = "INSERT INTO hist_usuario_ssh_online_free (status, id_usuario, hora_conexao)
                                                VALUES ('1', '".$sssh['id']."', '".$data."' )";

                    $SQLHistSSH = $conn->prepare($SQLHistSSH);
                    $SQLHistSSH->execute();

                }else{
                    $SQLUPSSH = "update usuario_ssh_free set online='".$Array[$i+1]."' , online_hist='1'  WHERE login = '$user'  ";
                    $SQLUPSSH = $conn->prepare($SQLUPSSH);
                    $SQLUPSSH->execute();
                }






            }


        }


    }

}else{
    echo "<br>Nenhuma Servidor!<br>";
}







?>