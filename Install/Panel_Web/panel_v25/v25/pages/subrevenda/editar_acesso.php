<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");


if(isset($_POST['idservidoracesso'])){

#Posts
    $servidor=$_POST['idservidoracesso'];
    $dias=$_POST['dias'];
    $limite=$_POST['limite'];

    $SQLAcesso = "select * from acesso_servidor where id_acesso_servidor = '".$servidor."' and id_mestre='".$_SESSION['usuarioID']."'  ";
    $SQLAcesso = $conn->prepare($SQLAcesso);
    $SQLAcesso->execute();

    if($SQLAcesso->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Servidor não encontrado");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    $server=$SQLAcesso->fetch();

    if(!is_numeric($limite)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um número!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }
    if(!is_numeric($dias)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um número!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }
    if($dias<0){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um número valido!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    $SQLserver = "select * from acesso_servidor where id_acesso_servidor = '".$server['id_servidor_mestre']."'";
    $SQLserver = $conn->prepare($SQLserver);
    $SQLserver->execute();

    $servermestre=$SQLserver->fetch();
    if($servermestre['id_usuario']<>$_SESSION['usuarioID']){
        echo '<script type="text/javascript">';
        echo 	'alert("Você não tem acesso neste servidor!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }


//Carrega contas SSH criadas
    $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$servermestre['id_servidor']."' and id_usuario='".$_SESSION['usuarioID']."' ";
    $SQLContasSSH = $conn->prepare($SQLContasSSH);
    $SQLContasSSH->execute();
    $SQLContasSSH = $SQLContasSSH->fetch();
    $contas_ssh_criadas += $SQLContasSSH['quantidade'];

    //Carrega usuario sub
    $SQLUsuarioSub = "SELECT * FROM usuario WHERE id_mestre ='".$_SESSION['usuarioID']."' and subrevenda='nao'";
    $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
    $SQLUsuarioSub->execute();


    if (($SQLUsuarioSub->rowCount()) > 0) {
        while($row = $SQLUsuarioSub->fetch()) {
            $SQLSubSSH= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$servermestre['id_servidor']."' ";
            $SQLSubSSH = $conn->prepare($SQLSubSSH);
            $SQLSubSSH->execute();
            $SQLSubSSH = $SQLSubSSH->fetch();
            $contas_ssh_criadas += $SQLSubSSH['quantidade'];

        }

    }


    if($limite<>0){
        $limiteservidor=$servermestre['qtd'];
        $soma=$limiteservidor-$contas_ssh_criadas;
        if($soma<=0){
            $soma=0;
        }

        if( $limiteservidor < ($contas_ssh_criadas+$limite)  ){

            echo '<script type="text/javascript">';
            echo 	'alert("Você não possui esse limite de acessos!\n\n Quantidade Permitida: '.$soma.'");';
            echo	'window.location="../../home.php?page=subrevenda/alocados";';
            echo '</script>';
            exit;

        }

    }

    $add=date('Y-m-d', strtotime('+'.$dias.' days', strtotime($server['validade'])));


//Sucesso
    $SQLSucesso = "update acesso_servidor set qtd=qtd+'".$limite."',validade='".$add."' where id_acesso_servidor='".$servidor."'";
    $SQLSucesso = $conn->prepare($SQLSucesso);
    $SQLSucesso->execute();

//Sucesso
    $SQLSucesso2 = "update acesso_servidor set qtd=qtd-'".$limite."' where id_acesso_servidor='".$servermestre['id_acesso_servidor']."'";
    $SQLSucesso2 = $conn->prepare($SQLSucesso2);
    $SQLSucesso2->execute();


    $SQLserverdr = "select * from servidor WHERE id_servidor = '".$server['id_servidor']."'";
    $SQLserverdr = $conn->prepare($SQLserverdr);
    $SQLserverdr->execute();
    $serverdor=$SQLserverdr->fetch();
    $SQLrevendedo = "select * from usuario where id_usuario = '".$server['id_usuario']."'";
    $SQLrevendedo = $conn->prepare($SQLrevendedo);
    $SQLrevendedo->execute();
    $revendedor=$SQLrevendedo->fetch();
//Insere notificacao
    $msg="O Revendedor <b>".$revendedor['nome']."</b> Editou o Seu Servidor de Acesso <small><b>".$serverdor['ip_servidor']."</b></small>!";
    $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$server['id_usuario']."','".date('Y-m-d H:i:s')."','revenda','Admin','".$msg."')";
    $notins = $conn->prepare($notins);
    $notins->execute();

    echo '<script type="text/javascript">';
    echo 	'alert("Editado com sucesso!");';
    echo	'window.location="../../home.php?page=subrevenda/alocados";';
    echo '</script>';








}