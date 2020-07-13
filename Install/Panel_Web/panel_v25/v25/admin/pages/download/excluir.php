<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_GET["id"])){

$id=anti_sql_injection($_GET['id']);

$SQLSubSSH = "SELECT * FROM arquivo_download where id='".$id."'";
$SQLSubSSH = $conn->prepare($SQLSubSSH);
$SQLSubSSH->execute();
if(($SQLSubSSH->rowCount()) > 0){
$arquivo = $SQLSubSSH->fetch();


$arquivo = "".$arquivo['nome_arquivo']."";
if (!unlink($arquivo))
{
echo '<script type="text/javascript">';
echo 'alert("Arquivo não foi encontrado");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}
else
{

$deletando = "DELETE FROM arquivo_download where id='".$id."'";
$deletando = $conn->prepare($deletando);
$deletando->execute();

echo '<script type="text/javascript">';
echo 'alert("O Arquivo: '.$arquivo['nome_arquivo'].' Foi Removido");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';
}




}else{echo '<script type="text/javascript">';
echo 'alert("Este item não existe");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}





}



?>