<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");


if(isset($_POST['idcontausuario'])){

#posts
    $idconta=anti_sql_injection($_POST['idcontausuario']);
    $valor=anti_sql_injection($_POST['valor']);
    $desconto=anti_sql_injection($_POST['desconto']);
    $prazo=anti_sql_injection($_POST['prazo']);
    $descricao=anti_sql_injection($_POST['msg']);
    $tipe=anti_sql_injection($_POST['tipo']);
    $servidor=anti_sql_injection($_POST['servidoralocado']);



//Gerando faturas
    $contassh = "SELECT * FROM usuario where id_usuario='".$idconta."'";
    $contassh = $conn->prepare($contassh);
    $contassh->execute();
    $achou=$contassh->rowCount();
    $ssh=$contassh->fetch();

    if($achou==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Usuário não encontrado!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }elseif($ssh['id_mestre']<>$_SESSION['usuarioID']){
        echo '<script type="text/javascript">';
        echo 	'alert("Este usuario não é sua!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;

    }

    if($ssh['subrevenda']<>'sim'){
        echo '<script type="text/javascript">';
        echo 	'alert("Este usuário não é um subrevendedor!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    if(!is_numeric($valor)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um numero valido!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    if(!is_numeric($desconto)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um numero valido!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    if(!is_numeric($prazo)){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um numero valido!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    if($valor<=0){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um valor maior ou igual a 1 real!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    if($prazo<=0){
        echo '<script type="text/javascript">';
        echo 	'alert("Digite um prazo maior ou igual a 1 dia!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    if($desconto>=$valor){
        echo '<script type="text/javascript">';
        echo 	'alert("Desconto não pode ser maior ou igual ao valor da SSH!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    $tipo='revenda';


//Busca Servidor Alocado

    $buscaaloc = "SELECT * FROM acesso_servidor where id_acesso_servidor='".$servidor."' and id_mestre='".$_SESSION['usuarioID']."'";
    $buscaaloc = $conn->prepare($buscaaloc);
    $buscaaloc->execute();

    if($buscaaloc->rowCount()==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Servidor não encontrado!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    $alocado=$buscaaloc->fetch();



//Procura fatura pendente
    $fatura = "SELECT * FROM fatura_clientes where usuario_id='".$idconta."' and status='pendente'";
    $fatura = $conn->prepare($fatura);
    $fatura->execute();
    $achoufat=$fatura->rowCount();
    if($achoufat>0){
        echo '<script type="text/javascript">';
        echo 	'alert("Já existe uma fatura em andamento para este usuario!");';
        echo	'window.location="../../home.php?page=subrevenda/alocados";';
        echo '</script>';
        exit;
    }

    $valorssh=$valor;
    $data=date('Y-m-d H:i:s');
    $dataexpire=date('Y-m-d 00:00:00',strtotime("+ ".$prazo." days"));

    $desc=$descricao;

//Insere fatura
    $faturains = "insert into fatura_clientes (usuario_id,id_mestre,tipo,qtd,data,datavencimento,status,descrição,valor,desconto,servidor_id) values ('".$ssh['id_usuario']."','".$_SESSION['usuarioID']."','".$tipo."','1','".$data."','".$dataexpire."','pendente','".$desc."','".$valorssh."','".$desconto."','".$alocado['id_servidor']."')";
    $faturains = $conn->prepare($faturains);
    $faturains->execute();

//Insere notificacao
    $usuarion=$ssh['id_usuario'];
    $msg="Atenção uma nova Fatura foi gerada e está em aberto no momento veja!";
    $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$usuarion."','".$data."','fatura','faturasclientes/minhas/abertas','".$msg."')";
    $notins = $conn->prepare($notins);
    $notins->execute();

    echo '<script type="text/javascript">';
    echo 	'alert("Fatura Criada com Sucesso!");';
    echo	'window.location="../../home.php?page=faturasclientes/abertas";';
    echo '</script>';



}