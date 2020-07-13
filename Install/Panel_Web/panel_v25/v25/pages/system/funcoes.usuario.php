<?php
require_once('seguranca.php');
require_once('config.php');
require_once('funcoes.php');
require_once('classe.ssh.php');
$diretorio = "../../index.php";
$date = date("Y-m-d H:i:s");

function geraToken(){


    $salt = "123456ABCDER";
    srand((double)microtime()*1000000);

    $i = 0;
    $pass = 0;
    while($i <= 7){

        $num = rand() % 10;
        $tmp = substr($salt, $num, 1);
        $pass = $pass . $tmp;
        $i++;

    }


    return $pass;

}
$token = geraToken();


if(isset($_GET["op"],$_GET["owner"])){
    $operacao = $_GET["op"];
    $owner = $_GET["owner"];

    if($owner != $accessKEY){
        protegePagina("user");

    }else if($owner == $accessKEY){
        protegePagina("admin");
    }


    if($operacao == "new" ){
        if((isset($_GET["diretorio"])) &&
            (isset($_GET["nome"])) &&
            (isset($_GET["login"])) &&
            (isset($_GET["senha"])) &&
            (isset($_GET["tipo"])) &&
            (isset($_GET["celular"]))
        ){

            $diretorio = $_GET['diretorio'];
            $nome = $_GET['nome'];
            $login = $_GET['login'];
            $celular = $_GET['celular'];
            $senha = $_GET['senha'];
            $tipouser=$_GET['tipo'];


            if($owner==$accessKEY){
                $owner = 0;
            }

            $SQLUsuario = "select * from usuario WHERE login = '".$_GET['login']."' ";
            $SQLUsuario = $conn->prepare($SQLUsuario);
            $SQLUsuario->execute();

            $SQLeu = "select * from usuario WHERE id_usuario = '".$_SESSION['usuarioID']."' ";
            $SQLeu = $conn->prepare($SQLeu);
            $SQLeu->execute();
            $eumesmo=$SQLeu->fetch();

            if(($SQLUsuario->rowCount()) > 0){
                echo '<script type="text/javascript">';
                echo 	'alert("O usuario '.$_GET['login'].' ja existe!");';
                echo	'window.location="'.$diretorio.'";';
                echo '</script>';
                exit;
            }

            switch($tipouser){
                case 1:$tipouser='revenda';break;
                case 2:$tipouser='vpn';break;
                default:$tipouser='erro';break;
            }
            if($tipouser=='erro'){
                echo '<script type="text/javascript">';
                echo 	'alert("Selecione o Tipo de Usu�rio!");';
                echo	'window.location="'.$diretorio.'";';
                echo '</script>';
                exit;
            }
            if($tipouser=='revenda'){
                $subrevenda='sim';

                if($eumesmo['subrevenda']=='sim'){
                    echo '<script type="text/javascript">';
                    echo 	'alert("Voc� n�o pode adicionar SUBRevendedor!");';
                    echo	'window.location="'.$diretorio.'";';
                    echo '</script>';
                    exit;
                }

            }else{
                $subrevenda='nao';
            }

            $SQLNew = "INSERT INTO usuario (ativo, id_mestre, nome, login, tipo, subrevenda, celular, senha, data_cadastro, token_user)
                                                VALUES ('1', '".$owner."', '".$nome."', '".$login."','".$tipouser."' , '".$subrevenda."',  '".$celular."', '".$senha."', '".$date."' , '".$token."') ";

            $SQLNew = $conn->prepare($SQLNew);
            $SQLNew->execute();

            $SQLResID = "SELECT LAST_INSERT_ID() AS last_id";
            $SQLResID = $conn->prepare($SQLResID);
            $SQLResID->execute();
            $id = $SQLResID->fetch();

            /*
            $mensagem = "Seja Bem vindo! @Pservers Dados de acesso: IP->".$endereco_web." Login-> ".$login." Senha->".$senha;
            $SQLSMS = "insert into sms (id_remetente, id_destinatario, assunto, mensagem)
                                VALUES ('".$owner."', '".$id['last_id']."', 'Seja Bem Vindo', '".$mensagem."')  ";
            $SQLSMS = $conn->prepare($SQLSMS);
            $SQLSMS->execute();
             */

            echo '<script type="text/javascript">';
            echo 	'alert("Conta adicionada!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;


        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Preencha todos os campos!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;
        }



    }else if($operacao == "dados" ){
        if((isset($_GET["id_usuario"])) &&
            (isset($_GET["diretorio"])) &&
            (isset($_GET["nome"])) &&
            (isset($_GET["email"])) &&
            (isset($_GET["celular"]))
        ){

            $id_usuario = $_GET["id_usuario"];
            $diretorio = $_GET['diretorio'];
            $nome = $_GET['nome'];
            $email = $_GET['email'];
            $celular = $_GET['celular'];


            $SQLUser = "select * from usuario WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();
            $usuario = $SQLUser->fetch();

            if($owner != $accessKEY){
                if(!($id_usuario == $owner)){


                    $SQLSub = "select * from usuario WHERE  id_mestre ='".$usuario['id_mestre']."' ";
                    $SQLSub = $conn->prepare($SQLSub);
                    $SQLSub->execute();
                    $usuario_owner = $SQLSub->fetch();

                    if($usuario_owner['id_mestre'] != $owner){
                        echo '<script type="text/javascript">';
                        echo 	'alert("Voce nao tem permissao!!");';
                        echo	'window.location="'.$diretorio.'";';
                        echo '</script>';
                        exit;
                    }
                }
            }else if($owner==$accessKEY){
                $owner = 0;
            }




            $SQLUpdate = "UPDATE usuario SET nome='".$nome."', email='".$email."', celular='".$celular."' WHERE id_usuario='".$usuario['id_usuario']."'  ";
            $SQLUpdate = $conn->prepare($SQLUpdate);
            $SQLUpdate->execute();


            echo '<script type="text/javascript">';
            echo 	'alert("Dados alterado!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;


        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Preencha todos os campos!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;
        }



    }else if($operacao == "senha"){

        if((isset($_GET["id_usuario"])) &&
            (isset($_GET["diretorio"]))
        ){
            $id_usuario = $_GET["id_usuario"];
            $diretorio = $_GET['diretorio'];

            $SQLUser = "select * from usuario WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();
            $usuario = $SQLUser->fetch();

            if($owner != $accessKEY){




                if(!($id_usuario == $owner)){


                    $SQLSub = "select * from usuario WHERE  id_mestre ='".$usuario['id_mestre']."' ";
                    $SQLSub = $conn->prepare($SQLSub);
                    $SQLSub->execute();
                    $usuario_owner = $SQLSub->fetch();

                    if($usuario_owner['id_mestre'] != $owner){
                        echo '<script type="text/javascript">';
                        echo 	'alert("Voce nao tem permissao!!");';
                        echo	'window.location="'.$diretorio.'";';
                        echo '</script>';
                        exit;
                    }
                }
            }else if($owner==$accessKEY){
                $owner = 0;
            }


            $mensagem = "Dados de acesso: IP->".$endereco_web." Login-> ".$usuario['login']." Senha->".$usuario['senha'];
            $SQLSMS = "insert into sms (id_remetente, id_destinatario, assunto, mensagem)
				                    VALUES ('".$owner."', '".$usuario['id_usuario']."', 'Reenviar Senha', '".$mensagem."')  ";
            $SQLSMS = $conn->prepare($SQLSMS);
            $SQLSMS->execute();


            echo '<script type="text/javascript">';
            echo 	'alert("Senha reenviada!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;


        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Preencha todos os campos!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;
        }


    }else if($operacao == "deletar"){
        if((isset($_GET["id_usuario"])) &&
            (isset($_GET["diretorio"]))
        ){

            $id_usuario = $_GET["id_usuario"];
            $diretorio = $_GET['diretorio'];
            $SQLUser = "select * from usuario WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();
            $usuario = $SQLUser->fetch();

            if($owner != $accessKEY){
                if(!($id_usuario == $owner)){


                    $SQLSub = "select * from usuario WHERE  id_mestre ='".$usuario['id_mestre']."' ";
                    $SQLSub = $conn->prepare($SQLSub);
                    $SQLSub->execute();
                    $usuario_owner = $SQLSub->fetch();

                    if($usuario_owner['id_mestre'] != $owner){
                        echo '<script type="text/javascript">';
                        echo 	'alert("Voce nao tem permissao!!");';
                        echo	'window.location="'.$diretorio.'";';
                        echo '</script>';
                        exit;
                    }
                }
            }else if($owner==$accessKEY){
                $owner = 0;
            }

            $SQLSSH = "update usuario_ssh set status='3', id_usuario='0' WHERE id_usuario = '".$id_usuario."'  ";
            $SQLSSH = $conn->prepare($SQLSSH);
            $SQLSSH->execute();

            if($usuario['tipo']=="revenda"){
                // Faz Devolu��o de acessos
                if($usuario['subrevenda']=="sim"){



                    $SQLdevolve= "SELECT * FROM acesso_servidor  where id_usuario='".$id_usuario."' ";
                    $SQLdevolve = $conn->prepare($SQLdevolve);
                    $SQLdevolve->execute();
                    if ($SQLdevolve->rowCount()>0) {
                        while($devolvendo=$SQLdevolve->fetch()){
                            $SQLpaga = "update acesso_servidor set qtd=qtd+'".$devolvendo['qtd']."' WHERE id_acesso_servidor = '".$devolvendo['id_servidor_mestre']."'";
                            $SQLpaga = $conn->prepare($SQLpaga);
                            $SQLpaga->execute();
                        }


                    }


                }



                $SQLExcluiAcesso = "delete  from acesso_servidor WHERE  id_usuario = '".$id_usuario."'";
                $SQLExcluiAcesso = $conn->prepare($SQLExcluiAcesso);
                $SQLExcluiAcesso->execute();

                $SQLUsuarioSub= "SELECT * FROM usuario where id_mestre =  '".$id_usuario."' ";
                $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
                $SQLUsuarioSub->execute();
                if (($SQLUsuarioSub->rowCount()) > 0) {
                    while($row = $SQLUsuarioSub->fetch()){
                        $SQLSSH = "update usuario_ssh set status='3', apagar='3', id_usuario='0' WHERE id_usuario = '".$row['id_usuario']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                    }
                }

                $SQLUser = "update usuario set id_mestre='0' WHERE id_mestre = '".$id_usuario."'  ";
                $SQLUser = $conn->prepare($SQLUser);
                $SQLUser->execute();


            }

            //verifica se tem fatura
            $SQLExcluiRevfat = "delete  from fatura WHERE  usuario_id = '".$id_usuario."'";
            $SQLExcluiRevfat = $conn->prepare($SQLExcluiRevfat);
            $SQLExcluiRevfat->execute();

            // 2

            $SQLExcluiRevfat2 = "delete  from fatura_clientes WHERE  usuario_id = '".$id_usuario."'";
            $SQLExcluiRevfat2 = $conn->prepare($SQLExcluiRevfat2);
            $SQLExcluiRevfat2->execute();

            $SQLExcluiRevfat3 = "delete  from fatura_clientes WHERE  id_mestre = '".$id_usuario."'";
            $SQLExcluiRevfat3 = $conn->prepare($SQLExcluiRevfat3);
            $SQLExcluiRevfat3->execute();

            //verifica se tem chamados
            $SQLExcluichamados1 = "delete  from chamados WHERE  usuario_id = '".$id_usuario."'";
            $SQLExcluichamados1 = $conn->prepare($SQLExcluichamados1);
            $SQLExcluichamados1->execute();

            //verifica se tem chamados que seja dono
            $SQLExcluichamados2 = "delete  from chamados WHERE  id_mestre = '".$id_usuario."'";
            $SQLExcluichamados2 = $conn->prepare($SQLExcluichamados2);
            $SQLExcluichamados2->execute();

            //verifica se tem notificacao
            $SQLExcluiRevnoti = "delete  from notificacoes WHERE  usuario_id = '".$id_usuario."'";
            $SQLExcluiRevnoti = $conn->prepare($SQLExcluiRevnoti);
            $SQLExcluiRevnoti->execute();

            //verifica se tem comprovante
            $SQLExcluiRevnoti = "delete  from fatura_comprovantes WHERE  usuario_id = '".$id_usuario."'";
            $SQLExcluiRevnoti = $conn->prepare($SQLExcluiRevnoti);
            $SQLExcluiRevnoti->execute();

            // 2

            $SQLExcluiRevnoti2 = "delete  from fatura_comprovantes_clientes WHERE  usuario_id = '".$id_usuario."'";
            $SQLExcluiRevnoti2 = $conn->prepare($SQLExcluiRevnoti2);
            $SQLExcluiRevnoti2->execute();

            $SQLExcluiRevnoti3 = "delete  from fatura_comprovantes_clientes WHERE  id_mestre = '".$id_usuario."'";
            $SQLExcluiRevnoti3 = $conn->prepare($SQLExcluiRevnoti3);
            $SQLExcluiRevnoti3->execute();


            $SQLExcluiRev = "delete  from usuario WHERE  id_usuario = '".$id_usuario."'";
            $SQLExcluiRev = $conn->prepare($SQLExcluiRev);
            $SQLExcluiRev->execute();


            echo '<script type="text/javascript">';
            echo 	'alert("Usuario  deletado!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;


        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Preencha todos os campos!!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;
        }

    }else if($operacao == "suspender"){
        if((isset($_GET["id_usuario"])) &&
            (isset($_GET["diretorio"]))
        ){

            $id_usuario = $_GET["id_usuario"];
            $diretorio = $_GET['diretorio'];

            $SQLUser = "select * from usuario WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();
            $usuario = $SQLUser->fetch();

            if($owner != $accessKEY){




                if(!($id_usuario == $owner)){


                    $SQLSub = "select * from usuario WHERE  id_mestre ='".$usuario['id_mestre']."' ";
                    $SQLSub = $conn->prepare($SQLSub);
                    $SQLSub->execute();
                    $usuario_owner = $SQLSub->fetch();

                    if($usuario_owner['id_mestre'] != $owner){
                        echo '<script type="text/javascript">';
                        echo 	'alert("Voce nao tem permissao!!");';
                        echo	'window.location="'.$diretorio.'";';
                        echo '</script>';
                        exit;
                    }
                }
            }else if($owner==$accessKEY){
                $owner = 0;
            }

            $SQLSSH = "update usuario_ssh set status='2', apagar='2' WHERE id_usuario = '".$id_usuario."'  ";
            $SQLSSH = $conn->prepare($SQLSSH);
            $SQLSSH->execute();

            if($usuario['tipo']=="revenda"){
                $SQLUsuarioSub= "SELECT * FROM usuario where id_mestre =  '".$id_usuario."' ";
                $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
                $SQLUsuarioSub->execute();
                if (($SQLUsuarioSub->rowCount()) > 0) {
                    while($row = $SQLUsuarioSub->fetch()){
                        $SQLSSH = "update usuario_ssh set status='2', apagar='2' WHERE id_usuario = '".$row['id_usuario']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                        $SQLUser = "update usuario set ativo='2', apagar='2' WHERE id_usuario = '".$row['id_usuario']."'  ";
                        $SQLUser = $conn->prepare($SQLUser);
                        $SQLUser->execute();
                    }
                }


            }

            $SQLUser = "update usuario set ativo='2', apagar='2' WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();


            echo '<script type="text/javascript">';
            echo 	'alert("Usuarios  suspenso!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;


        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Preencha todos os campos!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;
        }


    }else if($operacao == "ususpender"){
        if((isset($_GET["id_usuario"])) &&
            (isset($_GET["diretorio"]))
        ){

            $id_usuario = $_GET["id_usuario"];
            $diretorio = $_GET['diretorio'];

            $SQLUser = "select * from usuario WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();
            $usuario = $SQLUser->fetch();

            if($owner != $accessKEY){




                if(!($id_usuario == $owner)){


                    $SQLSub = "select * from usuario WHERE  id_mestre ='".$usuario['id_mestre']."' ";
                    $SQLSub = $conn->prepare($SQLSub);
                    $SQLSub->execute();
                    $usuario_owner = $SQLSub->fetch();

                    if($usuario_owner['id_mestre'] != $owner){
                        echo '<script type="text/javascript">';
                        echo 	'alert("Voce nao tem permissao!!");';
                        echo	'window.location="'.$diretorio.'";';
                        echo '</script>';
                        exit;
                    }
                }
            }else if($owner==$accessKEY){
                $owner = 0;
            }

            $SQLSSH = "update usuario_ssh set status='1', apagar='1' WHERE id_usuario = '".$id_usuario."'  ";
            $SQLSSH = $conn->prepare($SQLSSH);
            $SQLSSH->execute();

            if($usuario['tipo']=="revenda"){
                $SQLUsuarioSub= "SELECT * FROM usuario where id_mestre =  '".$id_usuario."' ";
                $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
                $SQLUsuarioSub->execute();
                if (($SQLUsuarioSub->rowCount()) > 0) {
                    while($row = $SQLUsuarioSub->fetch()){
                        $SQLSSH = "update usuario_ssh set status='1', apagar='1' WHERE id_usuario = '".$row['id_usuario']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                        $SQLUser = "update usuario set ativo='1', apagar='1' WHERE id_usuario = '".$row['id_usuario']."'  ";
                        $SQLUser = $conn->prepare($SQLUser);
                        $SQLUser->execute();
                    }
                }



            }

            $SQLUser = "update usuario set ativo='1', apagar='1' WHERE id_usuario = '".$id_usuario."'  ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();


            echo '<script type="text/javascript">';
            echo 	'alert("Usuarios  liberados!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;


        }else{
            echo '<script type="text/javascript">';
            echo 	'alert("Preencha todos os campos!");';
            echo	'window.location="'.$diretorio.'";';
            echo '</script>';
            exit;
        }


    }else{



    }

}else{

    echo '<script type="text/javascript">';
    echo 	'alert("Preencha todos os campos!");';
    echo	'window.location="'.$diretorio.'";';
    echo '</script>';
    exit;
}

?>