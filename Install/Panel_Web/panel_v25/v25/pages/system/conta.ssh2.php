<?php
require_once('seguranca.php');
require_once('config.php');
require_once('funcoes.php');
require_once('classe.ssh.php');
$diretorio = "../../index.php";


if(
    ( ((isset($_POST["owner"])) && (isset($_POST["servidor"]) ) )  ||
        ((isset($_POST["owner"])) && (isset($_POST["acesso_servidor"]) ) ) ) and

    (isset($_POST["login_ssh"])) and
    (isset($_POST["senha_ssh"])) and
    (isset($_POST["dias"]) && is_numeric($_POST["dias"])  ) and
    (isset($_POST["acessos"]) && is_numeric($_POST["acessos"])  )  and
    (isset($_POST["diretorio"])) and
    (isset($_POST["usuario"]))


)   {

    $quantidade_ssh = 0;
    $valida = 0;
    $acesso_servidor = $_POST['acesso_servidor'] ;
    $limite_servidor = "";
    $owner = $_POST['owner'] ;
    $usuario_id = $_POST['usuario'];
    $login_ssh = $_POST['login_ssh'];
    $senha_ssh = $_POST['senha_ssh'];
    $dias = $_POST['dias'];
    $acessos = $_POST['acessos'];
    $diretorio =  $_POST['diretorio'];

    if($owner != $accessKEY){
        protegePagina("user");

        $contas_ssh_criadas = 0;
        //Carrega acesso ao servidor
        $SQLAcessoServidor = "SELECT * FROM acesso_servidor WHERE id_acesso_servidor = '".$acesso_servidor."' and id_usuario = '".$owner."' ";
        $SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
        $SQLAcessoServidor->execute();
        $servidor_usuario = $SQLAcessoServidor->fetch();
        $limite_servidor = $servidor_usuario['qtd'];

        //Carrega servidor
        $SQLServidor = "SELECT * FROM servidor WHERE id_servidor = '".$servidor_usuario['id_servidor']."'  ";
        $SQLServidor = $conn->prepare($SQLServidor);
        $SQLServidor->execute();
        $servidor = $SQLServidor->fetch();
        //Carrega usuario que chamou
        $SQLUsuario = "SELECT * FROM usuario WHERE id_usuario = '".$owner."'";
        $SQLUsuario = $conn->prepare($SQLUsuario);
        $SQLUsuario->execute();
        $usuario = $SQLUsuario->fetch();
        //Carrega contas SSH dele "acessos"
        $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$servidor['id_servidor']."' and id_usuario='".$usuario['id_usuario']."' ";
        $SQLContasSSH = $conn->prepare($SQLContasSSH);
        $SQLContasSSH->execute();
        $SQLContasSSH = $SQLContasSSH->fetch();
        $contas_ssh_criadas += $SQLContasSSH['quantidade'];

        //Carrega usuario sub
        $SQLUsuarioSub = "SELECT * FROM usuario WHERE id_mestre ='".$usuario['id_usuario']."'";
        $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
        $SQLUsuarioSub->execute();


        if (($SQLUsuarioSub->rowCount()) > 0) {
            while($row = $SQLUsuarioSub->fetch()) {
                $SQLSubSSH= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$servidor['id_servidor']."' ";
                $SQLSubSSH = $conn->prepare($SQLSubSSH);
                $SQLSubSSH->execute();
                $SQLSubSSH = $SQLSubSSH->fetch();
                $contas_ssh_criadas += $SQLSubSSH['quantidade'];

            }

        }


        if( $limite_servidor < ($contas_ssh_criadas+$acessos)  ){

            echo '<script type="text/javascript">';
            echo 	'alert("Voce nao tem limites no servidor selecionado!\n Max:'.$contas_ssh_criadas.'acesso");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;

        }





    }else if($owner == $accessKEY){
        protegePagina("admin");
        $owner = 0 ;

        //Carrega servidor
        $SQLServidor = "SELECT * FROM servidor WHERE id_servidor = '".$_POST["servidor"]."'  ";
        $SQLServidor = $conn->prepare($SQLServidor);
        $SQLServidor->execute();
        $servidor = $SQLServidor->fetch();
    }

    $ip_servidorSSH = $servidor['ip_servidor'];
    $loginSSH = $servidor['login_server'];
    $senhaSSH =  $servidor['senha'];

    $ssh = new SSH2($ip_servidorSSH);
    $ssh->auth($loginSSH,$senhaSSH);
    $ssh->exec("./criarusuario.sh ".$login_ssh." ".$senha_ssh." 999999  ".$acessos."");
    $mensagem = (string) $ssh->output();

    if($mensagem == 13){
        $dias_acesso = $dias;
        $expira= date('Y-m-d', strtotime(' + '.$dias_acesso.'  days'));
        $SQLContaSSH = "INSERT INTO usuario_ssh (status, id_usuario, id_servidor, login, senha,  data_validade, acesso)
                                                VALUES ('1', '".$usuario_id."', '".$servidor['id_servidor']."', '".$login_ssh."', '".$senha_ssh."', '".$expira."', '".$acessos."' )";

        $SQLContaSSH = $conn->prepare($SQLContaSSH);
        $SQLContaSSH->execute();

    }else{
        $ssh->exec("./remover.sh ".$login_ssh." ");
        $mensagem2 = (string) $ssh->output();
    }

    switch($mensagem){
        case 0:
            echo '<script type="text/javascript">';
            echo 	'alert("Este login ssh ja existe!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 1:
            echo '<script type="text/javascript">';
            echo 	'alert("Este login ssh e invalido!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 2:
            echo '<script type="text/javascript">';
            echo 	'alert("Este login  e muito curto!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 3:
            echo '<script type="text/javascript">';
            echo 	'alert("Este login  e muito grande!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 4:
            echo '<script type="text/javascript">';
            echo 	'alert("Campo Login esta vazio!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 5:
            echo '<script type="text/javascript">';
            echo 	'alert("Campo senha esta vazio!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 6:
            echo '<script type="text/javascript">';
            echo 	'alert("Senha muito curta!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 7:
            echo '<script type="text/javascript">';
            echo 	'alert("Dias invalido!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 8:
            echo '<script type="text/javascript">';
            echo 	'alert("Dias vazio!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 9:
            echo '<script type="text/javascript">';
            echo 	'alert("Dias deve ser maior que zero!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 10:
            echo '<script type="text/javascript">';
            echo 	'alert("Acessos invalido");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 11:
            echo '<script type="text/javascript">';
            echo 	'alert("Campo acessos vazio");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 12:
            echo '<script type="text/javascript">';
            echo 	'alert("Campo acessos deve ser maior que zero");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 13:
            echo '<script type="text/javascript">';
            echo 	'alert("Criado com sucesso!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        case 14:
            echo '<script type="text/javascript">';
            echo 	'alert("Erro ao criar!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;

        default:
            echo '<script type="text/javascript">';
            echo 	'alert("Houve um erro inesperado, tente novamente.");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            break;


    }


}else{


    echo '<script type="text/javascript">';
    echo 	'alert("Preencha todos os campos corretamente!");';
    echo	'window.location="'.$diretorio.'";';
    echo '</script>';


}

?>