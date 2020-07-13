<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");


if(isset($_POST['clientid'])){$idcliente=$_POST['clientid'];$tokencliente=$_POST['clientsecret'];

            $SQLAcesso = "select * from mercadopago";
            $SQLAcesso = $conn->prepare($SQLAcesso);
            $SQLAcesso->execute();

            if($SQLAcesso->rowCount()==0){
            $SQLAcesso = "insert into mercadopago (CLIENT_ID,CLIENT_SECRET) values ('".$idcliente."','".$tokencliente."')";
            $SQLAcesso = $conn->prepare($SQLAcesso);
            $SQLAcesso->execute();

            }else{
            $SQLAcesso = "update mercadopago set CLIENT_ID='".$idcliente."', CLIENT_SECRET='".$tokencliente."' ";
            $SQLAcesso = $conn->prepare($SQLAcesso);
            $SQLAcesso->execute();

            }




echo '<script type="text/javascript">';
echo 	'alert("Autenticação Atualizada!");';
echo	'window.location="../../home.php?page=apis/gerenciar";';
echo '</script>';


}