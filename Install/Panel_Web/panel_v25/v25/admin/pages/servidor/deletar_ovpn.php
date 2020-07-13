<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

if(isset($_GET["id_servidor"])){

$id=anti_sql_injection($_GET['id_servidor']);

$SQLservidor = "SELECT * FROM servidor where id_servidor='".$id."'";
$SQLservidor = $conn->prepare($SQLservidor);
$SQLservidor->execute();

if(($SQLservidor->rowCount()) == 0){
echo '<script type="text/javascript">';
echo 'alert("Servidor não foi encontrado");';
echo 'window.location="../../home.php?page=servidor/listar";';
echo '</script>';exit;

}

$SQLSubSSH = "SELECT * FROM ovpn where servidor_id='".$id."'";
$SQLSubSSH = $conn->prepare($SQLSubSSH);
$SQLSubSSH->execute();
if(($SQLSubSSH->rowCount()) > 0){
$arquivo = $SQLSubSSH->fetch();


$arquivo = "../servidor/ovpn/".$arquivo['arquivo']."";
if (!unlink($arquivo))
{
echo '<script type="text/javascript">';
echo 'alert("Arquivo não foi encontrado");';
echo 'window.location="../../home.php?page=servidor/servidor&id_servidor='.$id.' ";';
echo '</script>';exit;
}
else
{

echo '<script type="text/javascript">';
echo 'alert("O Arquivo: '.$arquivo['arquivo'].' Foi Removido");';
echo	'window.location="../../home.php?page=servidor/servidor&id_servidor='.$id.' ";';
echo '</script>';

$deletando = "DELETE FROM ovpn where servidor_id='".$id."'";
$deletando = $conn->prepare($deletando);
$deletando->execute();
}




}else{
echo '<script type="text/javascript">';
echo 'alert("Nenhum OVPN Encontrado neste Servidor");';
echo	'window.location="../../home.php?page=servidor/servidor&id_servidor='.$id.' ";';
echo '</script>';exit;
}





}



?>