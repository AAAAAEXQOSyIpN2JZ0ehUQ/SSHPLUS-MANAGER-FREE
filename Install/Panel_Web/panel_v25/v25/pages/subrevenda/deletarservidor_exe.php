<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST["servidor"])){

#Post
    $servidor=anti_sql_injection($_POST["servidor"]);
    $subrevendedor=anti_sql_injection($_POST["cliente"]);

    $SQLAcesso = "select * from acesso_servidor where id_acesso_servidor = '".$servidor."' and id_mestre='".$_SESSION['usuarioID']."'  ";
    $SQLAcesso = $conn->prepare($SQLAcesso);
    $SQLAcesso->execute();

    if($SQLAcesso->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Servidor não encontrado");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }else{

        $acesso = $SQLAcesso->fetch();





        // procura usuarios dos subrevendedores
        $SQLreset = "select * from usuario where id_mestre='".$acesso['id_usuario']."'  ";
        $SQLreset = $conn->prepare($SQLreset);
        $SQLreset->execute();

        if($SQLreset->rowCount()>0){
            while($acesso3 = $SQLreset->fetch()) {
                echo $acesso3['nome'];
                $SQLUpdateSSH3 = "update usuario_ssh set status='3', apagar='3', id_usuario='0' where id_servidor='".$acesso['id_servidor']."' and id_usuario='".$acesso3['id_usuario']."' ";
                $SQLUpdateSSH3 = $conn->prepare($SQLUpdateSSH3);
                $SQLUpdateSSH3->execute();
            }
        }



        $SQLserver = "select * from servidor WHERE id_servidor = '".$acesso['id_servidor']."'";
        $SQLserver = $conn->prepare($SQLserver);
        $SQLserver->execute();
        $server=$SQLserver->fetch();

        //Insere notificacao

        $msg="O Revendedor <b>".$usuario['nome']."</b> Removeu seu(s) acesso(s) ao servidor <small><b>".$server['ip_servidor']."</b></small>!";
        $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$acesso['id_usuario']."','".date('Y-m-d H:i:s')."','revenda','Admin','".$msg."')";
        $notins = $conn->prepare($notins);
        $notins->execute();


        //Devolve acessos ao servidor mãe


        $SQLpaga = "update acesso_servidor set qtd=qtd+'".$acesso['qtd']."' WHERE id_acesso_servidor = '".$acesso['id_servidor_mestre']."'";
        $SQLpaga = $conn->prepare($SQLpaga);
        $SQLpaga->execute();



        $SQLExcluiAcesso = "delete  from acesso_servidor WHERE id_acesso_servidor = '".$acesso['id_acesso_servidor']."'";
        $SQLExcluiAcesso = $conn->prepare($SQLExcluiAcesso);
        $SQLExcluiAcesso->execute();


        echo '<script type="text/javascript">';
        echo 	'alert("Acesso Removido!");';
        echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$acesso['id_usuario'] .'";';
        echo '</script>';





    }






}

?>