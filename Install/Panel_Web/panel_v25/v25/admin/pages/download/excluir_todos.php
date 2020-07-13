<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_GET["id"])){

$SQLSubSSH = "SELECT * FROM arquivo_download";
$SQLSubSSH = $conn->prepare($SQLSubSSH);
$SQLSubSSH->execute();
if(($SQLSubSSH->rowCount()) > 0){

while($arquivo=$SQLSubSSH->fetch()){



$arquivo2 = "".$arquivo['nome_arquivo']."";
unlink($arquivo2);

$deletando = "DELETE FROM arquivo_download";
$deletando = $conn->prepare($deletando);
$deletando->execute();

echo '<script type="text/javascript">';
echo 'alert("Arquivos Removidos");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';




}
}else{
echo '<script type="text/javascript">';
echo 'alert("Não foi encontrado arquivos para download");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;






}
}


?>