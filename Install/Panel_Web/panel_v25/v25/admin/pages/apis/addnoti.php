<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

protegePagina("admin");

if(isset($_POST['adicionanoticia'])){$titulo=$_POST['titu'];
$subtitulo=$_POST['subtitu'];
$msg=$_POST['msg'];

$procnoticias= "select * FROM noticias where status='ativo'";
$procnoticias = $conn->prepare($procnoticias);
$procnoticias->execute();
if($procnoticias->rowCount()>0){echo '<script type="text/javascript">';
echo 	'alert("Existe uma noticia online");';
echo	'window.location="../../home.php?page=apis/gerenciar";';
echo '</script>';
exit;
}

if($titulo==''){echo '<script type="text/javascript">';
echo 	'alert("Campo titulo não pode ficar em branco");';
echo	'window.location="../../home.php?page=apis/gerenciar";';
echo '</script>';
exit;
}
if($subtitulo==''){
echo '<script type="text/javascript">';
echo 	'alert("Campo subtitulo não pode ficar em branco");';
echo	'window.location="../../home.php?page=apis/gerenciar";';
echo '</script>';
exit;
}
if($msg==''){
echo '<script type="text/javascript">';
echo 	'alert("Campo Mensagem não pode ficar em branco");';
echo	'window.location="../../home.php?page=apis/gerenciar";';
echo '</script>';
exit;
}


$addnoticias= "insert into noticias (status,titulo,subtitulo,msg,data) values ('ativo','".$titulo."','".$subtitulo."','".$msg."','".date('Y-m-d H:i:s')."')";
$addnoticias = $conn->prepare($addnoticias);
$addnoticias->execute();

echo '<script type="text/javascript">';
echo 	'alert("Noticia adicionada com sucesso!");';
echo	'window.location="../../home.php?page=apis/gerenciar";';
echo '</script>';

}

?>