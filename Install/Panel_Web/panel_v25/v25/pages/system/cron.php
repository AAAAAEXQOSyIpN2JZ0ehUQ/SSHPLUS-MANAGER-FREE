<?php
require_once('seguranca.php');
require_once('config.php');

$data = date("Y-m-d");





//Remove acesso contassh expiradas
$SQLSSH = "SELECT * FROM usuario_ssh where  data_validade < '".$data."'  and status='1' ";
$SQLSSH = $conn->prepare($SQLSSH);
$SQLSSH->execute();
if(($SQLSSH->rowCount()) > 0){
    while($row = $SQLSSH->fetch()){

        $SQLUPSSH = "update usuario_ssh set status='2', apagar='2',  data_suspensao='".$data."'	WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."' ";
        $SQLUPSSH = $conn->prepare($SQLUPSSH);
        $SQLUPSSH->execute();


        echo "<br>Conta SSH".$row['login']." foi suspensa!<br>";



    }

}else{
    echo "<br>Nenhuma Conta SSH suspensa!<br>";
}


//Remove acesso revendas expiradas
$SQLRevenda = "SELECT * FROM usuario where  validade < '".$data."' and tipo='revenda'  and ativo='1' ";
$SQLRevenda = $conn->prepare($SQLRevenda);
$SQLRevenda->execute();
if(($SQLRevenda->rowCount()) > 0){
    while($row = $SQLRevenda->fetch()){

        $SQLSSH = "update usuario_ssh set status='2', apagar='2'	WHERE id_usuario = '".$row['id_usuario']."' ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();

        $SQLRevenda = "update usuario set ativo='2', apagar='2',  suspenso='".$data."'	WHERE id_usuario = '".$row['id_usuario']."' ";
        $SQLRevenda = $conn->prepare($SQLRevenda);
        $SQLRevenda->execute();
        echo "Revendedor ".$row['login']." foi suspenso!<br>";

        $SQLSubUser = "SELECT * FROM usuario where  id_mestre='".$row['id_usuario']."' ";
        $SQLSubUser = $conn->prepare($SQLSubUser);
        $SQLSubUser->execute();
        if(($SQLSubUser->rowCount()) > 0){
            while($rowS = $SQLSubUser->fetch()){
                $SQLSSH = "update usuario_ssh set status='2', apagar='2'	WHERE id_usuario = '".$rowS['id_usuario']."' ";
                $SQLSSH = $conn->prepare($SQLSSH);
                $SQLSSH->execute();

                $SQLRevenda = "update usuario set ativo='2', apagar='2',  suspenso='".$data."'	WHERE id_usuario = '".$rowS['id_usuario']."' ";
                $SQLRevenda = $conn->prepare($SQLRevenda);
                $SQLRevenda->execute();
                echo "SubRevendedor ".$rowS['login']." foi suspenso!<br>";

            }
        }else{
            echo "<br>Nenhuma Sub Revenda suspensa!<br>";
        }




    }

}else{
    echo "<br>Nenhuma Revenda suspensa!<br>";
}

//Libera acesso revendas expiradas
$SQLRevenda = "SELECT * FROM usuario where  validade > '".$data."' and tipo='revenda'  and ativo='2' and apagar='0' ";
$SQLRevenda = $conn->prepare($SQLRevenda);
$SQLRevenda->execute();

if(($SQLRevenda->rowCount()) > 0){


    while($row = $SQLRevenda->fetch()){

        $SQLSSH = "update usuario_ssh set status='1', apagar='1',  data_suspensao='".$data."'	WHERE id_usuario = '".$row['id_usuario']."' ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();

        $SQLRevenda = "update usuario set ativo='1', apagar='1',  suspenso='".$data."'	WHERE id_usuario = '".$row['id_usuario']."' ";
        $SQLRevenda = $conn->prepare($SQLRevenda);
        $SQLRevenda->execute();
        echo "Revendedor ".$row['login']." foi liberado!<br>";

        $SQLSubUser = "SELECT * FROM usuario where  id_mestre='".$row['id_usuario']."' ";
        $SQLSubUser = $conn->prepare($SQLSubUser);
        $SQLSubUser->execute();
        if(($SQLSubUser->rowCount()) > 0){
            while($rowS = $SQLSubUser->fetch()){
                $SQLSSH = "update usuario_ssh set status='1', apagar='1'	WHERE id_usuario = '".$rowS['id_usuario']."' ";
                $SQLSSH = $conn->prepare($SQLSSH);
                $SQLSSH->execute();

                $SQLRevenda = "update usuario set ativo='1', apagar='0'  	WHERE id_usuario = '".$rowS['id_usuario']."' ";
                $SQLRevenda = $conn->prepare($SQLRevenda);
                $SQLRevenda->execute();
                echo "SubRevendedor ".$rowS['login']." foi liberado!<br>";

            }
        }else{
            echo "<br>Nenhuma Sub Revenda liberada!<br>";
        }




    }

}else{
    echo "<br>Nenhuma Revenda liberada!<br>";
}




?>