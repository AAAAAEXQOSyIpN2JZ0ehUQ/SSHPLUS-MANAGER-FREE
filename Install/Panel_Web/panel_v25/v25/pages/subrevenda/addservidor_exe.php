<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");

if(isset($_POST["servidor"])){

#Post
    $servidor=anti_sql_injection($_POST["servidor"]);
    $subrevendedor=anti_sql_injection($_POST["subusuario"]);
    $dias=anti_sql_injection($_POST["dias"]);
    $limite=anti_sql_injection($_POST["limite"]);

    if(!is_numeric($limite)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um número!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }
    if(!is_numeric($dias)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um número!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }
    if($dias<=0){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um número valido!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }

    $buscaeu = "SELECT * FROM usuario where id_usuario= '".$_SESSION['usuarioID']."'";
    $buscaeu = $conn->prepare($buscaeu);
    $buscaeu->execute();

    if($buscaeu->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Sua conta não foi encontrada!");';
        echo	'window.location="../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }
    $eu=$buscaeu->fetch();

    $buscasubusuario = "SELECT * FROM usuario where id_usuario= '".$subrevendedor."' and id_mestre='".$_SESSION['usuarioID']."' and subrevenda='sim'";
    $buscasubusuario = $conn->prepare($buscasubusuario);
    $buscasubusuario->execute();

    if($buscasubusuario->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Subrevendedor não encontrado!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }

    if($eu['subrevenda']=='sim'){
        echo '<script type="text/javascript">';
        echo 	'alert("Você não tem permissão para isso!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }

    $buscaserver = "SELECT * FROM acesso_servidor where id_acesso_servidor= '".$servidor."' and id_usuario='".$eu['id_usuario']."'";
    $buscaserver = $conn->prepare($buscaserver);
    $buscaserver->execute();

    if($buscaserver->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Servidor de acesso não encontrado!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }
    $meuservidor=$buscaserver->fetch();

    $buscaserver2 = "SELECT * FROM servidor where id_servidor='".$meuservidor['id_servidor']."'";
    $buscaserver2 = $conn->prepare($buscaserver2);
    $buscaserver2->execute();

    if($buscaserver2->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Servidor não encontrado!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }

    $buscaserver3 = "SELECT * FROM acesso_servidor where id_servidor='".$meuservidor['id_servidor']."' and id_usuario='".$subrevendedor."' and id_mestre='".$_SESSION['usuarioID']."'";
    $buscaserver3 = $conn->prepare($buscaserver3);
    $buscaserver3->execute();

    if($buscaserver3->rowCount()>0){
        echo '<script type="text/javascript">';
        echo 	'alert("Ele já possui acesso neste servidor \n Você precisa Retirar ou Editar o Servidor dele \n Você pode adicionar um outro servidor para Ele!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;
    }

//Carrega contas SSH criadas
    $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$meuservidor['id_servidor']."' and id_usuario='".$eu['id_usuario']."' ";
    $SQLContasSSH = $conn->prepare($SQLContasSSH);
    $SQLContasSSH->execute();
    $SQLContasSSH = $SQLContasSSH->fetch();
    $contas_ssh_criadas += $SQLContasSSH['quantidade'];

    //Carrega usuario sub
    $SQLUsuarioSub = "SELECT * FROM usuario WHERE id_mestre ='".$eu['id_usuario']."' and subrevenda='nao'";
    $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
    $SQLUsuarioSub->execute();


    if (($SQLUsuarioSub->rowCount()) > 0) {
        while($row = $SQLUsuarioSub->fetch()) {
            $SQLSubSSH= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$meuservidor['id_servidor']."' ";
            $SQLSubSSH = $conn->prepare($SQLSubSSH);
            $SQLSubSSH->execute();
            $SQLSubSSH = $SQLSubSSH->fetch();
            $contas_ssh_criadas += $SQLSubSSH['quantidade'];

        }

    }



    $limiteservidor=$meuservidor['qtd'];

    $soma=$limiteservidor-$contas_ssh_criadas;
    if($soma<=0){
        $soma=0;
    }

    if($limiteservidor==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Você não possui saldo em limites disponivel contrate mais e tente novamente!");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;

    }

    if( $limiteservidor < ($contas_ssh_criadas+$limite)  ){

        echo '<script type="text/javascript">';
        echo 	'alert("Você não possui esse limite de acessos!\n\n Quantidade Permitida: '.$soma.'");';
        echo	'window.location="../../home.php?page=subrevenda/adicionar";';
        echo '</script>';
        exit;

    }

    $add=date('Y-m-d',strtotime('+ '.$dias.' days'));

//Sucesso
    $SQLSucesso = "insert into acesso_servidor (id_servidor,id_usuario,id_mestre,id_servidor_mestre,qtd,validade) values ('".$meuservidor['id_servidor']."','".$subrevendedor."','".$_SESSION['usuarioID']."','".$meuservidor['id_acesso_servidor']."','".$limite."','".$add."')";
    $SQLSucesso = $conn->prepare($SQLSucesso);
    $SQLSucesso->execute();

//Sucesso
    $SQLSucesso2 = "update acesso_servidor set qtd=qtd-'".$limite."' where id_acesso_servidor='".$meuservidor['id_acesso_servidor']."'";
    $SQLSucesso2 = $conn->prepare($SQLSucesso2);
    $SQLSucesso2->execute();

    echo '<script type="text/javascript">';
    echo 	'alert("Servidor Adicionado Com Sucesso!");';
    echo	'window.location="../../home.php?page=subrevenda/adicionar";';
    echo '</script>';

}

?>