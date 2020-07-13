<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");


if(isset($_GET["id"])){
$id=anti_sql_injection($_GET['id']);

$SQLSubSSH = "SELECT * FROM arquivo_download where id='".$id."'";
$SQLSubSSH = $conn->prepare($SQLSubSSH);
$SQLSubSSH->execute();
$conta=$SQLSubSSH->rowCount();
if($conta>0){
$arquivo=$SQLSubSSH->fetch();
$file=$arquivo['nome_arquivo'];

if(file_exists("../../admin/pages/download/".$file."")) {
$separa=explode('.',$file);
$novoNome=$separa[0];
$local="../../admin/pages/download/".$file;
// Configuramos os headers que serao enviados para o browser
header("Content-Type: application/download");
header('Content-Length: '.filesize($local_arquivo));
header('Content-Disposition: filename='.$novoNome[0]);
header("Content-Disposition: attachment; filename=".basename($local));
// Envia o arquivo para o cliente
readfile($local);


             }else{ echo '<script type="text/javascript">';
             echo 'alert("Arquivo nao foi encontrado na pasta do servidor");';
             echo 'window.location="../../home.php?page=downloads/downloads";';
             echo '</script>';exit;}
             }else{
             echo '<script type="text/javascript">';
             echo 'alert("Arquivo nao foi encontrado no servidor");';
             echo 'window.location="../../home.php?page=downloads/downloads";';
             echo '</script>';exit;
             }
			}

?>