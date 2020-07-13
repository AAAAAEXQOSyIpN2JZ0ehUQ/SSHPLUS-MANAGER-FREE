<?php
require_once('seguranca.php');
require_once('config.php');
require_once('funcoes.php');
$data = date("Y-m-d H:i:s");

$servidor_sms = "";

if(($ClickAtellEnabled == 0) && ($LocaSMSEnabled == 1)){
    $servidor_sms = "locasms";

    //Envia ClickAtell
}else if(($ClickAtellEnabled==1) && ($LocaSMSEnabled==0)){
    $servidor_sms = "clickatell";

}else {
    $servidor_sms = "erro";
}


//Remove acesso revendas expiradas
//Carrega usuarioSSH
$SQLSMS = "select * from sms WHERE status = 'Aguardando' ";
$SQLSMS = $conn->prepare($SQLSMS);
$SQLSMS->execute();

if(($SQLSMS->rowCount()) > 0){
    while($row = $SQLSMS->fetch()){

        $SQLDestinatario = "select * from usuario WHERE id_usuario = '".$row['id_destinatario']."' ";
        $SQLDestinatario = $conn->prepare($SQLDestinatario);
        $SQLDestinatario->execute();
        $destinatario = $SQLDestinatario->fetch();

        if($servidor_sms == "locasms"){
            $send = enviarLocaSMS($destinatario['celular'], $row['mensagem'], $UserLocaSMS, $PassLocaSMS);

            $status = (String) (strpos($send, 'SUCESSO') > 0) ? true : false;

            if($status == '1'){
                $SQLUPSMS = "update sms set status='Enviado', hora_envio='".$data."' WHERE id_sms = '".$row['id_sms']."'  ";
                $SQLUPSMS = $conn->prepare($SQLUPSMS);
                $SQLUPSMS->execute();
                echo "SMS ID ".$row['id_sms']." enviado!<br>";
            }
        }

    }

}else{
    echo "Nenhuma SMS Disparado!<br>";
}



function  enviarLocaSMS($destino,$mensagem,$UserLocaSMS,$PassLocaSMS){

    $send = file_get_contents("http://54.173.24.177/shortcode/api.ashx?action=sendsms&lgn=$UserLocaSMS&pwd=$PassLocaSMS&msg=".urlencode($mensagem)."&numbers=".urlencode($destino)." ");


    return $send;


}



?>