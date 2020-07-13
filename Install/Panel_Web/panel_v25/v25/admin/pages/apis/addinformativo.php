<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

protegePagina("admin");

if(isset($_FILES['arquivo'])){
$link=$_POST['link'];
$SQLUPinfo= "SELECT * FROM informativo";
$SQLUPinfo = $conn->prepare($SQLUPinfo);
$SQLUPinfo->execute();

$conta=$SQLUPinfo->rowCount();
if($conta>0){
        echo '<script type="text/javascript">';
		echo 	'alert("Existe um informativo ativo delete primeiro!");';
		echo	'window.location="home.php?page=apis/gerenciar";';
		echo '</script>';
		exit;
}

// Pasta onde o arquivo vai ser salvo
$_UP['pasta'] = '../noticias/';
// Tamanho máximo do arquivo (em Bytes)
$_UP['tamanho'] = 1024 * 1024 * 2; // 2Mb
// Array com as extensões permitidas
$_UP['extensoes'] = array('jpg', 'png', 'gif');
// Renomeia o arquivo? (Se true, o arquivo será salvo como .jpg e um nome único)
$_UP['renomeia'] = false;
// Array com os tipos de erros de upload do PHP
$_UP['erros'][0] = '<script type="text/javascript">alert("Não houve erro");window.location="../../home.php?page=apis/gerenciar";</script>';
$_UP['erros'][1] = '<script type="text/javascript">alert("O arquivo no upload é maior do que o limite do PHP");window.location="../../home.php?page=apis/gerenciar";</script>';
$_UP['erros'][2] = '<script type="text/javascript">alert("O arquivo ultrapassa o limite de tamanho especifiado no HTML");window.location="../../home.php?apis/gerenciar";</script>';
$_UP['erros'][3] = '<script type="text/javascript">alert("O upload do arquivo foi feito parcialmente");window.location="../../home.php?page=apis/gerenciar";</script>';
$_UP['erros'][4] = '<script type="text/javascript">alert("Não foi feito o upload do arquivo");window.location="../../home.php?page=apis/gerenciar";</script>';
// Verifica se houve algum erro com o upload. Se sim, exibe a mensagem do erro
if ($_FILES['arquivo']['error'] != 0) {
  die("" . $_UP['erros'][$_FILES['arquivo']['error']]);
  exit; // Para a execução do script
}
// Caso script chegue a esse ponto, não houve erro com o upload e o PHP pode continuar
// Faz a verificação da extensão do arquivo
$extensao = strtolower(end(explode('.', $_FILES['arquivo']['name'])));
if (array_search($extensao, $_UP['extensoes']) === false) {
  echo '<script type="text/javascript">';
  echo 	'alert("Por favor, envie arquivos com as seguintes extensões: jpg, png ou gif");';
  echo	'window.location="../../home.php?page=apis/gerenciar";';
  echo '</script>';
  exit;
}
// Faz a verificação do tamanho do arquivo
if ($_UP['tamanho'] < $_FILES['arquivo']['size']) {
   echo '<script type="text/javascript">';
   echo 'alert("O arquivo enviado é muito grande, envie arquivos de até 2Mb.");';
   echo	'window.location="../../home.php?page=apis/gerenciar";';
   echo '</script>';
   exit;
}
// O arquivo passou em todas as verificações, hora de tentar movê-lo para a pasta
// Primeiro verifica se deve trocar o nome do arquivo
if ($_UP['renomeia'] == true) {
  // Cria um nome baseado no UNIX TIMESTAMP atual e com extensão .jpg
  $nome_final = md5(time()).'.jpg';
} else {
  // Mantém o nome original do arquivo
  $nome_final = $_FILES['arquivo']['name'];
}

// Depois verifica se é possível mover o arquivo para a pasta escolhida
if (move_uploaded_file($_FILES['arquivo']['tmp_name'], $_UP['pasta'] . $nome_final)) {
$insereinfo= "INSERT INTO informativo (data,imagem,link) values ('".date('Y-m-d H:i:s')."','".$nome_final."','".$link."')";
$insereinfo = $conn->prepare($insereinfo);
$insereinfo->execute();

  // Upload efetuado com sucesso, exibe uma mensagem e um link para o arquivo
        echo '<script type="text/javascript">';
		echo 	'alert("Enviado com sucesso! Informativo ativo");';
		echo	'window.location="../../home.php?page=apis/gerenciar";';
		echo '</script>';

}else{   // Não foi possível fazer o upload, provavelmente a pasta está incorreta
     echo '<script type="text/javascript">';
		echo 	'alert("Não foi possivel enviar o arquivo tente novamente!");';
		echo	'window.location="../../home.php?page=apis/gerenciar";';
		echo '</script>';
}













}


?>