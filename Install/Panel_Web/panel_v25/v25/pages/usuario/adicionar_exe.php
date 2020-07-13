<?php
include "../system/mysqli.php";
include "../system/config.php";
// A sessão precisa ser iniciada em cada página diferente
if (!isset($_SESSION)) session_start();

// Verifica se não há a variável da sessão que identifica o usuário
if (!isset($_SESSION['id'])) {
    // Destrói a sessão por segurança

    session_destroy();
    // Redireciona o visitante de volta pro login
    header("Location: login.php"); exit;
}else{

    if((isset($_POST["login"])) and (isset($_POST["senha"])) and (isset($_POST["nome"])) and (isset($_POST["celular"]))){
        $res = $mysqli->query("select * from usuario WHERE login = '".$_POST['login']."' ") or die($mysqli->error);

        if($res->num_rows > 0){
            echo '<script type="text/javascript">';
            echo 	'alert("O usuario '.$_POST['login'].' ja existe!");';
            echo	'window.location="../../home.php?page=usuario/adicionar";';
            echo '</script>';
        }else{
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



            $geratoken = geraToken();

            $sql = "INSERT INTO usuario (id_mestre, login, senha, data_cadastro, tipo, nome, celular, token_user)
            VALUES ('".$_SESSION['id']."', '".$_POST['login']."', '".$_POST['senha']."',  '".$data."', 'vpn', '".$_POST['nome']."', '".$_POST['celular']."', '{$geratoken}' )";

            if ($mysqli->query($sql) === TRUE) {
                $res_id = $mysqli->query("SELECT LAST_INSERT_ID() AS last_id") or die($mysqli->error);
                $id = $res_id->fetch_assoc();
                echo '<script type="text/javascript">';
                echo 	'alert("O usuario '.$_POST['login'].' foi criado com sucesso!");';
                echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$id['last_id'] .' ";';
                echo '</script>';


            } else {
                echo '<script type="text/javascript">';
                echo 	'alert("Erro ao adicionar o usuario'.$_POST['login'].' !");';
                echo	'window.location="../../home.php?page=usuario/adicionar";';
                echo '</script>';
            }

            $mysqli->close();


            echo "Nao existe!";
        }

    }else{
        echo '<script type="text/javascript">';
        echo 	'alert("Preencha todos os campos!");';
        echo	'window.location="../../home.php?page=usuario/adicionar";';
        echo '</script>';

    }


}

?>