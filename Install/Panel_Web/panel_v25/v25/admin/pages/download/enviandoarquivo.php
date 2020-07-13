<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");


if(isset($_POST['enviandoarquivos'])){

#Posts
$operadora=anti_sql_injection($_POST['operadora']);
$tipoarquivo=anti_sql_injection($_POST['tipo']);
$tipocliente=anti_sql_injection($_POST['tipocliente']);
$detalhes=anti_sql_injection($_POST['msg']);
$nomear=anti_sql_injection($_POST['nome']);
$status=anti_sql_injection($_POST['status']);

// Diretório de destino do arquivo
define('DEST_DIR', __DIR__ . '../../../pages/download');

if (isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name']))
{
    // se o "name" estiver vazio, é porque nenhum arquivo foi enviado

    // apenas para facilitar, criamos uma variável que é o array com os dados do arquivo
    $arquivo = $_FILES['arquivo'];
    $nomedoarquido = $arquivo['name'];
    $final=anti_sql_injection($nomedoarquido);

$buscasmtp = "SELECT * FROM arquivo_download WHERE nome_arquivo='".$final."'";
$buscasmtp = $conn->prepare($buscasmtp);
$buscasmtp->execute();
$conta=$buscasmtp->rowCount();
if($conta>0){
echo '<script type="text/javascript">';
echo 'alert("Este arquivo já existe");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}
if($nomear==''){
echo '<script type="text/javascript">';
echo 'alert("Coloque um nome");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}

switch($status){
case 1:$sta='funcionando';break;
case 2:$sta='testes';break;
default:$sta='funcionando';break;
}

switch($operadora){
case 1:$ope='todas';break;
case 2:$ope='claro';break;
case 3:$ope='vivo';break;
case 4:$ope='tim';break;
case 5:$ope='oi';break;
default:$ope='todas';break;
}

switch($tipoarquivo){
case 1:$tipoar='ehi';break;
case 2:$tipoar='apk';break;
case 3:$tipoar='outros';break;
default:$tipoar='erro';break;
}

if($tipoar=='erro'){
echo '<script type="text/javascript">';
echo 'alert("Houve problema na seleção do tipo de arquivo");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}

switch($tipocliente){
case 1:$tipocl='todos';break;
case 2:$tipocl='revenda';break;
case 3:$tipocl='vpn';break;
default:$tipocl='erro';break;
}

if($tipocl=='erro'){
echo '<script type="text/javascript">';
echo 'alert("Houve problema na seleção do tipo de cliente");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}

if($detalhes==''){
echo '<script type="text/javascript">';
echo 'alert("Coloque uma Descrição");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';exit;
}


    if (!move_uploaded_file($arquivo['tmp_name'], DEST_DIR . '/' . $arquivo['name']))
    {
echo '<script type="text/javascript">';
echo 'alert("Ocorreu um Erro no Processo de Upload");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';
    }
    else
    {
    $data=date('Y-m-d H:i:s');

    //Insere notificacao
    if($tipocl=='todos'){
    $buscauser = "SELECT * FROM usuario";
    }elseif($tipocl=='revenda'){
    $buscauser = "SELECT * FROM usuario where tipo='revenda'";
    }elseif($tipocl=='vpn'){
    $buscauser = "SELECT * FROM usuario where tipo='vpn'";
    }
    $buscauser = $conn->prepare($buscauser);
    $buscauser->execute();
    if(($buscauser->rowCount()) > 0){
    while($row = $buscauser->fetch()){
    $msg="Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!";
    $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem,info_outros) values ('".$row['id_usuario']."','".date('Y-m-d H:i:s')."','outros','n/d','".$msg."','Arquivos')";
    $notins = $conn->prepare($notins);
    $notins->execute();
    }
    }



    //Envia ao banco de dados o arquivo
    $enviando = "insert into arquivo_download (nome,tipo,operadora,data,detalhes,nome_arquivo,cliente_tipo,status) values ('".$nomear."','".$tipoar."','".$ope."','".$data."','".$detalhes."','".$final."','".$tipocl."','".$sta."')";
    $enviando = $conn->prepare($enviando);
    $enviando->execute();
    echo '<script type="text/javascript">';
echo 'alert("Sucesso ! O Arquivo foi enviado");';
echo 'window.location="../../home.php?page=download/downloads";';
echo '</script>';
    }
}else{
echo '<script type="text/javascript">';
                echo    'alert("Houve algum erro durante o Upload do arquivo");';
                echo    'window.location="../../home.php?page=download/downloads";';
                echo '</script>';exit;
}



}

?>