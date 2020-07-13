<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");


if(isset($_GET["id"])){
$id=anti_sql_injection($_GET['id']);

$SQLSubSSH = "SELECT * FROM ovpn where id='".$id."'";
$SQLSubSSH = $conn->prepare($SQLSubSSH);
$SQLSubSSH->execute();
$conta=$SQLSubSSH->rowCount();
if($conta>0){
$arquivo=$SQLSubSSH->fetch();
$file=$arquivo['arquivo'];

if(file_exists("../servidor/ovpn/".$file."")) {
$separa=explode('.',$file);
$novoNome=$separa[0];
$local="../../admin/pages/servidor/ovpn/".$file;
// Configuramos os headers que serão enviados para o browser
header('Cache-control: private');
header('Content-Type: application/octet-stream');
header('Content-Length: '.filesize($local_arquivo));
header('Content-Disposition: filename='.$novoNome[0]);
header("Content-Disposition: attachment; filename=".basename($local));
// Envia o arquivo para o cliente
readfile($local);


             }else{ echo '<script type="text/javascript">';
             echo 'alert("Arquivo não foi encontrado na pasta do servidor");';
             echo 'window.location="../../home.php?page=servidor/listar";';
             echo '</script>';exit;}
             }else{
             echo '<script type="text/javascript">';
             echo 'alert("Arquivo não foi encontrado no servidor");';
             echo 'window.location="../../home.php?page=servidor/listar";';
             echo '</script>';exit;
             }
			}

?>