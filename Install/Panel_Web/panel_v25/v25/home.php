<?php


require_once("pages/system/seguranca.php");
require_once("pages/system/config.php");
require_once("pages/system/classe.ssh.php");

protegePagina("user");


$quantidade_ssh = 0;
$quantidade_ssh_user =0;
$quantidade_ssh_sub =0;
$quantidade_sub = 0;
$all_ssh_susp_qtd = 0;

$SQLUsuario = "SELECT * FROM usuario WHERE id_usuario = '".$_SESSION['usuarioID']."'";
$SQLUsuario = $conn->prepare($SQLUsuario);
$SQLUsuario->execute();
$usuario = $SQLUsuario->fetch();
// avatares
switch($usuario['avatar']){
    case 1:$avatarusu="avatar1.png";break;
    case 2:$avatarusu="avatar2.png";break;
    case 3:$avatarusu="avatar3.png";break;
    case 4:$avatarusu="avatar4.png";break;
    case 5:$avatarusu="avatar5.png";break;
    default:$avatarusu="boxed-bg.png";break;
}


if($usuario['tipo']=='revenda'){
    $tipouser='Revendedor';
}elseif($usuario['tipo']=='vpn'){
    $tipouser='Usuário VPN';
}

$datacad=$usuario['data_cadastro'];

$partes = explode("-", $datacad);
$ano = $partes[0];
$mes = $partes[1];

$Mes = muda_mes($mes);
$Meses = muda_mes2($mes);

#####################
// Usados

 $qtddoserverusado=0;

 $SQLusuariosdele= "SELECT * FROM usuario where id_mestre = '".$_SESSION['usuarioID']."' and subrevenda='nao'";
 $SQLusuariosdele = $conn->prepare($SQLusuariosdele);
 $SQLusuariosdele->execute();

 if ($SQLusuariosdele->rowCount()>0) {
  while($usuariosdele=$SQLusuariosdele->fetch()){
    $SQLcontaqtdsshusadodele= "SELECT sum(acesso) as acessosdosserversusados2 FROM usuario_ssh where id_usuario = '".$usuariosdele['id_usuario']."'";
    $SQLcontaqtdsshusadodele = $conn->prepare($SQLcontaqtdsshusadodele);
    $SQLcontaqtdsshusadodele->execute();

    $qtdusadosdele=$SQLcontaqtdsshusadodele->fetch();

    $qtddoserverusado+=$qtdusadosdele['acessosdosserversusados2'];

  }

}


$SQLcontaqtdsshusado= "SELECT sum(acesso) as acessosdosserversusados FROM usuario_ssh where id_usuario = '".$_SESSION['usuarioID']."'";
$SQLcontaqtdsshusado = $conn->prepare($SQLcontaqtdsshusado);
$SQLcontaqtdsshusado->execute();

$qtdusados=$SQLcontaqtdsshusado->fetch();

$qtddoserverusado+=$qtdusados['acessosdosserversusados'];


// Todos Acessos

$todosacessos=0;

$SQLqtdserveracessos= "SELECT sum(qtd) as todosacessos FROM  acesso_servidor where id_usuario = '".$_SESSION['usuarioID']."'";
$SQLqtdserveracessos = $conn->prepare($SQLqtdserveracessos);
$SQLqtdserveracessos->execute();

$totalacess=$SQLqtdserveracessos->fetch();

$todosacessos+=$totalacess['todosacessos'];

//Disponiveis
$disponiveis=$todosacessos-$qtddoserverusado;

if($disponiveis<=0){$disponiveis=0;}

//Calculo Porcentagem

$porcent = ($qtddoserverusado/$todosacessos)*100; // %

$resultado = $porcent;

$valor_porce = round($resultado);

if($valor_porce>=100){
  $valor_porce=100;
}

if($valor_porce<=0){
  $valor_porce=0;
}

if(($valor_porce>=70)and($valor_porce<90)){
  $sucessobar="warning";
  $bgbar="orange";
}elseif($valor_porce>=90){
  $sucessobar="danger";
  $bgbar="red";
}else{
  $sucessobar="success";
  $bgbar="green";
}

#####################

$SQLUsuario_ssh = "select * from usuario_ssh WHERE id_usuario = '".$_SESSION['usuarioID']."' ";
$SQLUsuario_ssh = $conn->prepare($SQLUsuario_ssh);
$SQLUsuario_ssh->execute();
$quantidade_ssh += $SQLUsuario_ssh->rowCount();

$SQLUsuario_sshSUSP = "select * from usuario_ssh WHERE id_usuario = '".$_SESSION['usuarioID']."' and  status='2' and apagar='0' ";
$SQLUsuario_sshSUSP = $conn->prepare($SQLUsuario_sshSUSP);
$SQLUsuario_sshSUSP->execute();
$all_ssh_susp_qtd += $SQLUsuario_sshSUSP->rowCount();

$total_acesso_ssh = 0;
$SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$_SESSION['usuarioID']."' ";
$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
$SQLAcessoSSH->execute();
$SQLAcessoSSH = $SQLAcessoSSH->fetch();
$total_acesso_ssh += $SQLAcessoSSH['quantidade'];

$total_acesso_ssh_online = 0;
$SQLAcessoSSH = "SELECT sum(online) AS quantidade  FROM usuario_ssh  where id_usuario='".$_SESSION['usuarioID']."' ";
$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
$SQLAcessoSSH->execute();
$SQLAcessoSSH = $SQLAcessoSSH->fetch();
$total_acesso_ssh_online += $SQLAcessoSSH['quantidade'];




$SQLAcesso= "select * from acesso_servidor WHERE id_usuario = '".$_SESSION['usuarioID']."' ";
$SQLAcesso = $conn->prepare($SQLAcesso);
$SQLAcesso->execute();
$acesso_servidor = $SQLAcesso->rowCount();


//Arquivos download
$SQLArquivos= "select * from  arquivo_download";
$SQLArquivos = $conn->prepare($SQLArquivos);
$SQLArquivos->execute();
$todosarquivos = $SQLArquivos->rowCount();
if($usuario['id_mestre']==0){
    // Faturas
    $SQLfaturas= "select * from  fatura where status='pendente' and usuario_id='".$_SESSION['usuarioID']."'";
    $SQLfaturas = $conn->prepare($SQLfaturas);
    $SQLfaturas->execute();
    $faturas = $SQLfaturas->rowCount();
}else{
    // Faturas
    $SQLfaturas= "select * from  fatura_clientes where status='pendente' and usuario_id='".$_SESSION['usuarioID']."'";
    $SQLfaturas = $conn->prepare($SQLfaturas);
    $SQLfaturas->execute();
    $faturas = $SQLfaturas->rowCount();
}
if($usuario['tipo']=='revenda'){
    // Faturas
    $SQLfaturas2= "select * from  fatura_clientes where status='pendente' and id_mestre='".$_SESSION['usuarioID']."'";
    $SQLfaturas2 = $conn->prepare($SQLfaturas2);
    $SQLfaturas2->execute();
    $faturas_clientes = $SQLfaturas2->rowCount();
}
// Notificações
$SQLnoti= "select * from  notificacoes where lido='nao' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLnoti = $conn->prepare($SQLnoti);
$SQLnoti->execute();
$totalnoti = $SQLnoti->rowCount();
// Notificações Contas
$SQLnoti1= "select * from  notificacoes where lido='nao' and tipo='conta' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLnoti1= $conn->prepare($SQLnoti1);
$SQLnoti1->execute();
$totalnoti_contas = $SQLnoti1->rowCount();

// Notificações fatura
$SQLnoti2= "select * from  notificacoes where lido='nao' and tipo='fatura' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLnoti2= $conn->prepare($SQLnoti2);
$SQLnoti2->execute();
$totalnoti_fatura = $SQLnoti2->rowCount();

if($usuario['tipo']=='revenda'){
    // Notificações Revenda
    $SQLnoti3= "select * from  notificacoes where lido='nao' and tipo='revenda' and usuario_id='".$_SESSION['usuarioID']."'";
    $SQLnoti3= $conn->prepare($SQLnoti3);
    $SQLnoti3->execute();
    $totalnoti_revenda = $SQLnoti3->rowCount();

    //Todos os chamados subRevendedores e usuarios do revendedor
    $SQLchamadoscli2= "select * from  chamados where status='resposta' and id_mestre='".$_SESSION['usuarioID']."'";
    $SQLchamadoscli2= $conn->prepare($SQLchamadoscli2);
    $SQLchamadoscli2->execute();
    $all_chamados_clientes += $SQLchamadoscli2->rowCount();
    //Todos os chamados subRevendedores e usuarios do revendedor
    $SQLchamadoscli= "select * from  chamados where status='aberto' and id_mestre='".$_SESSION['usuarioID']."'";
    $SQLchamadoscli= $conn->prepare($SQLchamadoscli);
    $SQLchamadoscli->execute();
    $all_chamados_clientes += $SQLchamadoscli->rowCount();

    //subrevendedores
    $SQLsbrevenda = "select * from usuario WHERE id_mestre = '".$_SESSION['usuarioID']."' and subrevenda='sim' ";
    $SQLsbrevenda = $conn->prepare($SQLsbrevenda);
    $SQLsbrevenda->execute();
    $quantidade_sub_revenda = $SQLsbrevenda->rowCount();
}

//Todos os chamados meus 1
$SQLchamados= "select * from  chamados where status='aberto' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLchamados= $conn->prepare($SQLchamados);
$SQLchamados->execute();
$all_chamados += $SQLchamados->rowCount();
//Todos os chamados meus 2
$SQLchamados2= "select * from  chamados where status='resposta' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLchamados2= $conn->prepare($SQLchamados2);
$SQLchamados2->execute();
$all_chamados += $SQLchamados2->rowCount();
// Notificações chamados
$SQLnotichama= "select * from  notificacoes where lido='nao' and tipo='chamados' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLnotichama= $conn->prepare($SQLnotichama);
$SQLnotichama->execute();
$totalnoti_chamados = $SQLnotichama->rowCount();
// Notificações Outros
$SQLnoti4= "select * from  notificacoes where lido='nao' and tipo='outros' and usuario_id='".$_SESSION['usuarioID']."'";
$SQLnoti4= $conn->prepare($SQLnoti4);
$SQLnoti4->execute();
$totalnoti_outros = $SQLnoti4->rowCount();

if($usuario['id_mestre']<>0){
    // Notificações users
    $SQLnoti5= "select * from  notificacoes where lido='nao' and tipo='usuario' and usuario_id='".$_SESSION['usuarioID']."'";
    $SQLnoti5= $conn->prepare($SQLnoti5);
    $SQLnoti5->execute();
    $totalnoti_users = $SQLnoti5->rowCount();


}


if($usuario['tipo']=="revenda"){
    $SQLSub= "select * from usuario WHERE id_mestre = '".$_SESSION['usuarioID']."' and subrevenda='nao'";
    $SQLSub = $conn->prepare($SQLSub);
    $SQLSub->execute();


    if (($SQLSub->rowCount()) > 0) {

        while($row = $SQLSub->fetch()) {

            $SQLSubSSH= "select * from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."'  ";
            $SQLSubSSH = $conn->prepare($SQLSubSSH);
            $SQLSubSSH->execute();
            $quantidade_ssh += $SQLSubSSH->rowCount();

            $sshsub=$SQLSubSSH->rowCount();

            $SQLUsuario_sshSUSP = "select * from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and status='2' and apagar='0' ";
            $SQLUsuario_sshSUSP = $conn->prepare($SQLUsuario_sshSUSP);
            $SQLUsuario_sshSUSP->execute();
            $all_ssh_susp_qtd += $SQLUsuario_sshSUSP->rowCount();

            $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$row['id_usuario']."' ";
            $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
            $SQLAcessoSSH->execute();
            $SQLAcessoSSH = $SQLAcessoSSH->fetch();
            $total_acesso_ssh += $SQLAcessoSSH['quantidade'];


            $SQLAcessoSSHon = "SELECT sum(online) AS quantidade  FROM usuario_ssh  where id_usuario='".$row['id_usuario']."' ";
            $SQLAcessoSSHon = $conn->prepare($SQLAcessoSSHon);
            $SQLAcessoSSHon->execute();
            $SQLAcessoSSHon = $SQLAcessoSSHon->fetch();
            $total_acesso_ssh_online += $SQLAcessoSSHon['quantidade'];

        }


    }
    $quantidade_sub += $SQLSub->rowCount();


    //Calcula os dias restante
    $data_atual = date("Y-m-d ");
    $data_validade = $usuario['validade'];

    $data1 = new DateTime( $data_validade );
    $data2 = new DateTime( $data_atual );

    $diferenca = $data1->diff( $data2 );
    $ano = $diferenca->y * 364 ;
    $mes = $diferenca->m * 30;
    $dia = $diferenca->d;
    $dias_acesso = $ano + $mes + $dia;

    $quantidade_ssh +=   $quantidade_ssh_sub+$quantidade_ssh_user;

    if($usuario['ativo']==2){
        echo '<script type="text/javascript">';
        echo   'alert("Sua conta  esta suspensa!");';
        echo 'window.location="pages/suspenso.php";';
        echo '</script>';
        exit;

    }

}

?>
<!DOCTYPE html>
<html class="loading" lang="pt_BR" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Gerenciador de conexôes SSH">
    <meta name="keywords" content="VIP-VPS, VPN, SSH">
    <meta name="author" content="Adeilonfi">
    <meta name="msapplication-TileColor" content="#FFFFFF">
    <meta name="theme-color" content="#FFFFFF">
    <title>VIP-VPS V.25 - PAINEL</title>
    <!-- <link rel="apple-touch-icon" href="app-assets/images/ico/favicon.ico">-->
	<link rel="icon" type="image/png" sizes="16x16" href="../app-assets/images/favicon.png">
    <!-- <link rel="shortcut icon" type="image/x-icon" href="../app-assets/images/ico/favicon.ico">-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Icon CSS-->
    <link rel="stylesheet" type="text/css" href="app-assets/fonts/font-awesome/css/all.css">
    <!-- END: Icon CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="app-assets/css/plugins/tour/tour.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <!-- END: Custom CSS-->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu-modern 2-columns navbar-floating footer-static " data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

    <div class="wrapper">
        <div class="modal fade" id="flaggeral" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-flag"></i> Alertar Todos!</h3>
                    </div>
                    <div class="modal-body">

                        <!-- content goes here -->
                        <form name="editaserver" action="pages/usuario/notificar_home.php" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Tipo de Notificação </label>
                                <?php if(($usuario['tipo']=='revenda') and ($usuario['subrevenda']=='nao')){?>
                                    <select size="1" name="clientes" class="form-control select2">
                                        <option value="1" selected=selected>Todos</option>
                                        <option value="2">Revendedores</option>
                                        <option value="3" >Clientes</option>
                                    </select>
                                <?php }else{ ?>
                                    <select size="1" name="clientes" class="form-control select2" disabled>
                                        <option value="1" selected=selected>Todos Clientes</option>
                                    </select>
                                <?php } ?>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Mensagem</label>
                                <textarea class="form-control" name="msg" rows="3" cols="20" wrap="off" placeholder="Digite..."></textarea>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar</button>
                                <button type="button" class="btn btn-success">Confirmar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
  //paste this code under head tag or in a seperate js file.
  // Wait for window load
  $(window).load(function() {
    // Animate loader off screen
    $(".se-pre-con").fadeOut('slow');;
  });
</script>
<script>
  function usuariosonline()
  {

  // Requisição
  $.post('pages/ssh/online_home.php?requisicao=1',
    function (resposta) {
          //Adiciona Efeito Fade
          $("#usuarioson").fadeOut("slow").fadeIn('slow');
      // Limpa
      $('#usuarioson').empty();
      // Exibe
      $('#usuarioson').append(resposta);
    });
}
// Intervalo para cada Chamada
setInterval("usuariosonline()", 30000);

// Após carregar a Pagina Primeiro Requisito
$(function() {
    // Requisita Função acima
    usuariosonline();
  });
</script>
<script>
  function atualizar()
  {
    // Fazendo requisição AJAX
    $.post('pages/ssh/online_home.php?requisicao=2',
      function (online) {
        // Exibindo frase
        $('#online_nav').html(online);
        $('#online').html(online);

      }, 'JSON');
  }
// Definindo intervalo que a função será chamada
setInterval("atualizar()", 10000);
// Quando carregar a página
$(function() {
    // Faz a primeira atualização
    atualizar();
  });
</script>
        <!-- BEGIN: Main Menu-->
        <div class="main-menu menu-fixed menu-light menu-accordion menu-shadow" data-scroll-to-active="false">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mr-auto"><a class="navbar-brand" href="home.php">
                        <img class="round" src="../app-assets/images/logo/logomenu.png" alt="icon" height="35" width="225" />
                    </a></li>
                    <li class="nav-item nav-toggle">
                        <a class="nav-link modern-nav-toggle pr-0" data-toggle="collapse">
                            <i class="feather icon-x d-block d-xl-none font-medium-4 primary toggle-icon"></i>
                            <i class="toggle-icon feather icon-disc font-medium-4 d-none d-xl-block collapse-toggle-icon primary" data-ticon="icon-disc"></i>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="shadow-bottom"></div>
            <div class="main-menu-content">
                <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
                    <li class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></li>
                    <li class=" navigation-header"><span>VIP-VPS | PRINCIPAL</span>
                    </li>                    
                    <li class=" nav-item"><a href="#"><i class="ficon fal fa-greater-than-equal text-info"></i><span class="menu-title" data-i18n="Area VPN"> CONTAS SSH</span><span class="badge badge badge-info badge-pill float-right mr-2"><?php echo $quantidade_ssh; ?></span></a>
                        <ul class="menu-content">
                            <?php if(($usuario['tipo']=="revenda") and ($acesso_servidor > 0) ){?>
                                <li><a href="?page=ssh/adicionar"><i class="ficon fad fa-terminal"></i><span class="menu-item" data-i18n="Criar SSH"> Criar Conta SSH</span></a>
                                </li>
								<li><a href="?page=ssh/add_teste"><i class="ficon fad fa-clock text-info"></i><span class="menu-item" data-i18n="Teste SSH"> Criar Teste SSH</span></a>
                                </li>
                            <?php }?>
                            <li><a href="?page=ssh/contas"><i class="ficon ficon fad fa-list-ul"></i><span class="menu-item" data-i18n="Listar SSH"> Listar SSH</span></a>
                            </li>
                            <li><a href="?page=ssh/online"><i class="ficon fad fa-rocket"></i><span class="menu-item" data-i18n="Online SSH"> SSH Online</span></a>
                            </li>
                        </ul>
                    </li>

                    <?php if($usuario['tipo']=="revenda") {?>
                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-user text-primary"></i><span class="menu-title" data-i18n="Area Clientes"> CLIENTES</span><span class="badge badge badge-primary badge-pill float-right mr-2"><?php echo $quantidade_sub; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=usuario/adicionar"><i class="ficon fad fa-user-plus"></i><span class="menu-item" data-i18n="Novo Usuário"> Novo Usuário</span></a>
                                </li>
                                <li><a href="?page=usuario/listar"><i class="ficon fad fa-user-shield"></i><span class="menu-item" data-i18n="Usuários SSH"> Listar Clientes</span></a>
                                </li>
                            </ul>
                        </li>
                    

                    <?php if($usuario['subrevenda']<>'sim'){ ?>
                        
                            <li class=" nav-item"><a href="#"><i class="ficon fal fa-user-tie text-warning"></i><span class="menu-title" data-i18n="SubRevenda"> SUB REVENDA</span><span class="badge badge badge-warning badge-pill float-right mr-2"><?php echo $quantidade_sub_revenda; ?></span></a>
                                <ul class="menu-content">
                                    <li><a href="?page=subrevenda/adicionar"><i class="fad fa-server"></i><span class="menu-item" data-i18n="ADD Servidor"> ADD Servidor</span></a>
                                    </li>
                                    <li><a href="?page=subrevenda/revendedores"><i class="fad fa-user-tie"></i><span class="menu-item" data-i18n="Revendedores"> Revendedores</span></a>
                                    </li>
                                </ul>
                            </li>
                            <?php }?>
                            <?php } ?>
                            <?php if(($usuario['tipo']=="revenda") and ($acesso_servidor > 0) ){?>
                            <li class=" nav-item"><a href="#"><i class="ficon fal fa-server text-info"></i><span class="menu-title" data-i18n="Servidores"> SERVIDORES</span><span class="badge badge badge-info badge-pill float-right mr-2"><?php echo $acesso_servidor; ?></span></a>
                                <ul class="menu-content">
                                    <li><a href="?page=servidor/listar"><i class="ficon fad fa-list-ul"></i><span class="menu-item" data-i18n="Listar servidores"> Listar servidores</span></a>
                                    </li>
                                    <?php if($usuario['subrevenda']<>'sim'){?>
                                        <li><a href="?page=servidor/meuservidor"><i class="ficon fad fa-user"></i><span class="menu-item" data-i18n="Meus Sevidores"> Meus Sevidores</span></a>
                                        </li>
                                        <li><a href="?page=subrevenda/alocados"><i class="ficon fad fa-user-cog"></i><span class="menu-item" data-i18n="Servidores Alocados"> Servidores Alocados</span></a>
                                        </li>
                                    <?php } ?>
                                </ul>
                            </li>
                        
                    <?php } ?>
                    <?php if($usuario['id_mestre']==0){?>
                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-wallet text-success"></i><span class="menu-title" data-i18n="Minhas faturas"> M FATURAS</span><span class="badge badge badge-success badge-pill float-right mr-2"><?php echo $faturas; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=faturas/abertas"><i class="ficon fad fa-file-invoice-dollar"></i><span class="menu-item" data-i18n="Abertas"> Abertas</span></a>
                                </li>
                                <li><a href="?page=faturas/pagas"><i class="ficon fad fa-file-powerpoint"></i><span class="menu-item" data-i18n="Pagas"> Pagas</span></a>
                                </li>
                                <li><a href="?page=faturas/canceladas"><i class="ficon fad fa-file-excel"></i><span class="menu-item" data-i18n="Canceladas"> Canceladas</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-bells text-danger"></i><span class="menu-title" data-i18n="Chamados">M CHAMADO</span><span class="badge badge badge-danger badge-pill float-right mr-2"><?php echo $all_chamados; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=chamados/abrir"><i class="ficon fad fa-user"></i><span class="menu-item" data-i18n="Abrir um chamado"> Abrir um chamado</span></a>
                                </li>
                                <li><a href="?page=chamados/abertas"><i class="ficon fad fa-user-tag"></i><span class="menu-item" data-i18n="Abertos"> Abertos</span></a>
                                </li>
                                <li><a href="?page=chamados/respondidos"><i class="ficon fad fa-user-check"></i><span class="menu-item" data-i18n="Respondidas"> Respondidas</span></a>
                                </li>
                                <li><a href="?page=chamados/encerrados"><i class="ficon fad fa-user-times"></i><span class="menu-item" data-i18n="Encerradas"> Encerradas</span></a>
                                </li>
                            </ul>
                        </li>
                    <?php }else{ ?>

                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-wallet text-success"></i><span class="menu-title" data-i18n="Minhas faturas"> M FATURAS</span><span class="badge badge badge-success badge-pill float-right mr-2"><?php echo $faturas; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=faturasclientes/minhas/abertas"><i class="ficon fad fa-file-invoice-dollar"></i><span class="menu-item" data-i18n="Abertas"> Abertas</span></a>
                                </li>
                                <li><a href="?page=faturasclientes/minhas/pagas"><i class="ficon fad fa-file-powerpoint"></i><span class="menu-item" data-i18n="Pagas"> Pagas</span></a>
                                </li>
                                <li><a href="?page=faturasclientes/minhas/canceladas"><i class="ficon fad fa-file-excel"></i><span class="menu-item" data-i18n="Canceladas"> Canceladas</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-bells text-danger"></i><span class="menu-title" data-i18n="Minhas faturas"> M CHAMADOS</span><span class="badge badge badge-danger badge-pill float-right mr-2"><?php echo $all_chamados; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=chamados/abrir"><i class="ficon fad fa-user"></i><span class="menu-item" data-i18n="Abrir um chamado"> Abrir um chamado</span></a>
                                </li>
                                <li><a href="?page=chamados/abertas"><i class="ficon fad fa-user-tag"></i><span class="menu-item" data-i18n="Abertos"> Abertos</span></a>
                                </li>
                                <li><a href="?page=chamados/respondidos"><i class="ficon fad fa-user-check"></i><span class="menu-item" data-i18n="Respondidos"> Respondidos</span></a>
                                </li>
                                <li><a href="?page=chamados/encerrados"><i class="ficon fad fa-user-times"></i><span class="menu-item" data-i18n="Encerradas"> Encerradas</span></a>
                                </li>
                            </ul>
                        </li>
                    <?php }?>

                    <?php if($usuario['tipo']=='revenda'){ ?>
                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-wallet text-success"></i><span class="menu-title" data-i18n="Faturas Clientes"> F CLIENTES</span><span class="badge badge badge-success badge-pill float-right mr-2"><?php echo $faturas_clientes; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=faturasclientes/abertas"><i class="ficon fad fa-file-invoice-dollar"></i><span class="menu-item" data-i18n="Abertas"> Abertas</span></a>
                                </li>
                                <li><a href="?page=faturasclientes/pagas"><i class="ficon fad fa-file-powerpoint"></i><span class="menu-item" data-i18n="Pagas"> Pagas</span></a>
                                </li>
                                <li><a href="?page=faturasclientes/canceladas"><i class="ficon fad fa-file-excel"></i><span class="menu-item" data-i18n="Canceladas"> Canceladas</span></a>
                                </li>
                                <li><a href="?page=faturasclientes/comprovantes"><i class="ficon fad fa-file-invoice"></i><span class="menu-item" data-i18n="Comprovantes"> Comprovantes</span></a>
                                </li>
                                <li><a href="?page=faturasclientes/cpfechados"><i class="ficon fad fa-file-csv"></i><span class="menu-item" data-i18n="CP Fechados"> CP Fechados</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class=" nav-item"><a href="#"><i class="ficon fal fa-bells text-danger"></i><span class="menu-title" data-i18n="Chamados"> C CLIENTES</span><span class="badge badge badge-danger badge-pill float-right mr-2"><?php echo $all_chamados_clientes; ?></span></a>
                            <ul class="menu-content">
                                <li><a href="?page=chamadosclientes/abertas"><i class="ficon fad fa-user-tag"></i><span class="menu-item" data-i18n="Abertos"> Abertos</span></a>
                                </li>
                                <li><a href="?page=chamadosclientes/respondidos"><i class="ficon fad fa-user-check"></i><span class="menu-item" data-i18n="Respondidos"> Respondidos</span></a>
                                </li>
                                <li><a href="?page=chamadosclientes/encerrados"><i class="ficon fad fa-user-times"></i><span class="menu-item" data-i18n="Encerrados"> Encerrados</span></a>
                                </li>
                            </ul>
                        </li>
                    <?php } ?>
                    <!-- <li class=" nav-item"><a href="?page=apps"><i class="ficon fal fa-cog text-primary"></i><span class="menu-title" data-i18n="Configurações"> GERENCIAR APP</span></a> -->   
                    <li class=" nav-item"><a href="#"><i class="ficon fal fa-cog text-primary"></i><span class="menu-title" data-i18n="Configurações"> CONFIGURAÇÕES</span></a>
                        <ul class="menu-content">
                            <li><a href="?page=admin/dados"><i class="ficon fad fa-user-tie"></i><span class="menu-item" data-i18n="Minhas Informações"> Minhas Informações</span></a>
                            </li>
                            <li><a href="?page=downloads/downloads"><i class="ficon fad fa-archive"></i><span class="menu-item" data-i18n="Arquivos"> Arquivos</span></a>
                            </li>
                            <?php if($usuario['tipo']=="revenda") {?>
                                <li><a href="?page=email/enviaremail"><i class="ficon fad fa-envelope"></i><span class="menu-item" data-i18n="Email"> Email</span></a>
                                </li>
                            <?php } ?>
                        </ul>
                    </li>
                    <li class=" nav-item"><a href="sair.php"><i class="ficon fal fa-power-off text-danger"></i><span class="menu-title" data-i18n="Sair"> SAIR</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- END: Main Menu-->

        <!-- BEGIN: Content-->
        <div class="app-content content">

            <!-- BEGIN: Header-->
            <div class="content-overlay"></div>
            <div class="header-navbar-shadow"></div>
            <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu floating-nav navbar-light navbar-shadow">
                <div class="navbar-wrapper">
                    <div class="navbar-container content">
                        <div class="navbar-collapse" id="navbar-mobile">
                            <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                                <ul class="nav navbar-nav">
                                    <li class="nav-item mobile-menu d-xl-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ficon feather icon-menu"></i></a></li>
                                </ul>
                                <ul class="nav navbar-nav bookmark-icons">
                                  <style type='text/css'>
                                      .dark-layout {}
                                  </style>
                                  <div class="custom-control custom-switch mr-0 mb-0">
                                      <input type="checkbox" class="custom-control-input" id="dark-layout" value="false" data-layout="dark-layout">
                                      <label class="custom-control-label" for="dark-layout">
                                          <span class="switch-icon-left"><i class="fal fa-sun"></i></span>
                                          <span class="switch-icon-right" ><i class="fal fa-eclipse-alt"></i></span>
                                      </label>
                                  </div>
                              </ul>
                              <!-- novo code -->
                          </div>
                          <ul class="nav navbar-nav float-right">
                            <li class="nav-item"><a class="nav-link nav-link-expand"></a></li>
                            <?php if($usuario['tipo']=='revenda'){?>
                                <li class="nav-item"><a class="nav-link" href="#flaggeral" data-toggle="modal" data-placement="top" title="Notificar"><i class="ficon fad fa-comment-alt-lines"></i></a></li>
                            <?php } ?>
                        
                       <!-- <li class="nav-item"><a class="nav-link nav-link-expand"><i class="ficon feather icon-maximize"></i></a></li>-->
                    
                    <li class="dropdown dropdown-notification nav-item">
                        <a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i class="ficon fad fa-rocket"></i>
                            <span class="badge badge-pill badge-success badge-up" id="online_nav"><?php echo $total_acesso_ssh_online; ?></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                            <li class="dropdown-menu-header">
                                <div class="dropdown-header m-0 p-2">
                                    <h4> <span class="notification-title">Usuários | Conectados</h4></span>
                                </div>
                            </li>
                            <li class="scrollable-container media-list">
                                <a class="d-flex justify-content-between" href="javascript:void(0)">
                                    <div class="media d-flex align-items-start">
                                        <div class="media-body">
                                            <h5 class="primary media-heading align-items-start" id="usuarioson"></h5>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="dropdown-menu-footer"><a class="dropdown-item p-1 text-center" href="?page=ssh/online">| Ver todos |</a></li>
                        </ul>
                    </li>
<!-- ########################################## -->
<li class="dropdown dropdown-notification nav-item">
                        <a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i class="ficon fal fa-server"></i>
                            <span class="badge badge-pill badge-warning badge-up"><?php echo $qtddoserverusado;?>/<?php echo $todosacessos;?></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                            <li class="dropdown-menu-header">
                                <div class="dropdown-header m-0 p-2">
                                    <h2 class="white"><?php echo $qtddoserverusado;?>/<?php echo $todosacessos;?></h2>
                                    <?php if($totalnoti==0){?>
                                        <span class="notification-title">Você não possui Servidores</span>
                                    <?php }else{ ?>
                                        <span class="notification-title">Acessos Criados || Limite de Acessos</span>
                                    <?php }?>
                                </div>
                            </li>
                            <li class="scrollable-container media-list">
                                <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-check-circle font-medium-5 info"></i></div>
                                            <div class="media-body">
                                                
                                                    <h6 class="info media-heading"><?php echo $todosacessos;?> ... LIMITE DE ACESSOS</h6>
													
                                            </a>
                                        </div>
                                    </div>
                                </a>
                                <?php
                                if($usuario['subrervenda']=='nao'){
                                    if($usuario['id_mestre']<>0){ ?>
                                        <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-check-circle font-medium-5 info"></i></div>
                                            <div class="media-body">
                                                
                                                    <h6 class="info media-heading"><?php echo $qtddoserverusado;?> ... ACESSOS DISPONIVEL</h6>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                    <?php }}
                                    if($usuario['tipo']=='revenda'){ ?>
                                        <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-check-circle font-medium-5 info"></i></div>
                                            <div class="media-body">
                                                
                                                    <h6 class="info media-heading"><?php echo $disponiveis;?> ... ACESSOS DISPONIVEL</h6>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                    <?php } ?>
									<a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-check-circle font-medium-5 info"></i></div>
                                            <div class="media-body">
                                                <a href="?page=ssh/contas">
                                                    <h6 class="info media-heading"><?php echo $qtddoserverusado;?> ... ACESSO CRIADO</h6>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                    <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-check-circle font-medium-5 info"></i></div>
                                            <div class="media-body">
                                                
                                                    <h6 class="info media-heading"> PROGRESSO DE USO</h6>
													<td><span class=" progress-lg progress-bar badge badge badge-pill badge-success badge-up-<?php echo $bgbar2;?>"><?php echo $valor_porce;?>%</span></td>
												</a>	
                         <tr>
                             <td>
                                 <div class="progress progress-lg progress-bar-<?php echo $sucessobar;?>">
                                     <div class="progress-bar progress-bar-<?php echo $sucessobar;?> progress-bar-striped" role="progressbar" style="width: <?php echo $valor_porce;?>%"></div>
                                 </div>
                             </td>
                             
                         </tr>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                    
                                    
                                </li>
                                <li class="dropdown-menu-footer"><a class="dropdown-item p-1 text-center" href="?page=servidor/listar">Ver Completo</a></li>
                            </ul>
                        </li>

<!-- ########################################## -->
                    <li class="dropdown dropdown-notification nav-item">
                        <a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i class="ficon fad fa-bell"></i>
                            <span class="badge badge-pill badge-primary badge-up"><?php echo $totalnoti;?></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                            <li class="dropdown-menu-header">
                                <div class="dropdown-header m-0 p-2">
                                    <h2 class="white"><?php echo $totalnoti;?></h2>
                                    <?php if($totalnoti==0){?>
                                        <span class="notification-title">Você não possui novas notificações</span>
                                    <?php }else{ ?>
                                        <span class="notification-title">Nova<?php if($totalnoti>1){ echo "s";}?> <?php if($totalnoti<=1){ echo "notificação";}else { echo "notificações";}?></span>
                                    <?php }?>
                                </div>
                            </li>
                            <li class="scrollable-container media-list">
                                <a class="d-flex justify-content-between" href="javascript:void(0)">
                                    <div class="media d-flex align-items-start">
                                        <div class="media-left"><i class="feather icon-plus-square font-medium-5 primary"></i></div>
                                        <div class="media-body">
                                            <a href="?page=notificacoes/notificacoes&ler=accs">
                                                <h6 class="primary media-heading"><?php echo $totalnoti_contas;?> Em Contas</h6>
                                            </a>
                                        </div>
                                    </div>
                                </a>
                                <?php
                                if($usuario['subrervenda']=='nao'){
                                    if($usuario['id_mestre']<>0){ ?>
                                        <a class="d-flex justify-content-between" href="javascript:void(0)">
                                            <div class="media d-flex align-items-start">
                                                <div class="media-left"><i class="feather icon-download-cloud font-medium-5 success"></i></div>
                                                <div class="media-body">
                                                    <a href="?page=notificacoes/notificacoes&ler=usuario">
                                                        <h6 class="success media-heading red darken-1"><?php echo $totalnoti_users;?> Em Usuário</h6>
                                                    </a>
                                                </div>
                                            </div>
                                        </a>
                                    <?php }}
                                    if($usuario['tipo']=='revenda'){ ?>
                                        <a class="d-flex justify-content-between" href="javascript:void(0)">
                                            <div class="media d-flex align-items-start">
                                                <div class="media-left"><i class="feather icon-alert-triangle font-medium-5 danger"></i></div>
                                                <div class="media-body">
                                                    <a href="?page=notificacoes/notificacoes&ler=reve">
                                                        <h6 class="danger media-heading yellow darken-3"><?php echo $totalnoti_revenda;?> Em Revendas</h6>
                                                    </a>
                                                </div>
                                            </div>
                                        </a>
                                    <?php } ?>
                                    <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-check-circle font-medium-5 info"></i></div>
                                            <div class="media-body">
                                                <a href="?page=notificacoes/notificacoes&ler=others">
                                                    <h6 class="info media-heading"><?php echo $totalnoti_outros;?> Em Outros</h6>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                    <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-file font-medium-5 success"></i></div>
                                            <div class="media-body">
                                                <a href="?page=notificacoes/notificacoes&ler=fatu">
                                                    <h6 class="success media-heading"><?php echo $totalnoti_fatura;?> Em Faturas</h6>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                    <a class="d-flex justify-content-between" href="javascript:void(0)">
                                        <div class="media d-flex align-items-start">
                                            <div class="media-left"><i class="feather icon-file font-medium-5 warning"></i></div>
                                            <div class="media-body">
                                                <a href="?page=notificacoes/notificacoes&ler=chamados">
                                                    <h6 class="warning media-heading"><?php echo $totalnoti_chamados;?> Em Chamados</h6>
                                                </a>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="dropdown-menu-footer"><a class="dropdown-item p-1 text-center" href="?page=notificacoes/notificacoes&ler=all">Ver Todos</a></li>
                            </ul>
                        </li>
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                            <div class="user-nav d-sm-flex d-none"><span class="user-name text-bold-600"><?php echo strtoupper($usuario['nome']);?></span><span class="user-status"><?php echo $tipouser;?></span></div><span><img class="round" src="app-assets/images/portrait/avatar/<?php echo $avatarusu;?>" alt="avatar" height="40" width="40" /> </span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="#"><i class="fad fa-user-tie"></i> Desde: <?php echo date('d-m-Y', strtotime($usuario['data_cadastro']));?></a>
                            <a class="dropdown-item" href="?page=admin/dados"><i class="fad fa-user-tie"></i> Editar perfil</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="sair.php"><i class="fad fa-sign-out"></i> Sair</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<!-- END: Header-->

<div class="content-wrapper">
    <div class="content-header row">
    </div>
    <div class="content-body">
        <!-- Dashboard Analytics Start -->
        <section id="dashboard-analytics">
            <div class="row">
                <div class="col-sm-12">
                </div>
            </div>
        </section>
        <!-- Dashboard Analytics end -->
        <?php


        if(isset($_GET["page"])){
            $page = $_GET["page"];
            if($page and file_exists("pages/".$page.".php")) {
                include("pages/".$page.".php");
            } else {
                include("./pages/inicial.php");
            }
        }else{
            include("./pages/inicial.php");
        }


        ?>
    </div>
</div>
</div>
<!-- END: Content-->

<div class="sidenav-overlay"></div>
<div class="drag-target"></div>

<!-- BEGIN: Footer-->
<footer class="footer footer-static footer-light">
    <center><p class="clearfix blue-grey lighten-2 mb-0">
        <span class="center">
            &copy; <script> document.write(new Date().getFullYear())</script>
            <a class="text-bold-800 grey darken-2" href="http://www.vip-vps.com.br/" target="_blank">VIP-VPS V.25</a></span>
        </span>
        <button class="btn btn-primary btn-icon scroll-top" type="button"><i class="feather icon-arrow-up"></i></button>
    </p></center>
</footer>
<!-- END: Footer-->
<script>
    if (localStorage.getItem("toggled") === null) {
      localStorage.setItem("toggled", " ");
    }
    $("#dark-layout").click(function(){$("body").toggleClass("dark-layout")}),$("body").toggleClass(localStorage.toggled),$("#dark-layout").click(function(){"dark-layout"!=localStorage.toggled?($("body").toggleClass("dark-layout",!0),localStorage.toggled="dark-layout"):($("body").toggleClass("dark-layout",!1),localStorage.toggled="")});

    if (localStorage.getItem("toggled") === "dark-layout") {
       document.getElementById("dark-layout").checked = true;
    } else {
      document.getElementById("dark-layout").checked = false;
    }
</script>

<!-- BEGIN: Vendor JS-->
<script src="app-assets/vendors/js/vendors.min.js"></script>
<!-- BEGIN Vendor JS-->

<!-- BEGIN: Page Vendor JS-->
<script src="app-assets/vendors/js/charts/apexcharts.min.js"></script>
<script src="app-assets/vendors/js/extensions/tether.min.js"></script>

<!-- END: Page Vendor JS-->

<!-- BEGIN: Theme JS-->
<script src="app-assets/js/core/app-menu.js"></script>
<script src="app-assets/js/core/app.js"></script>
<script src="app-assets/js/scripts/components.js"></script>
<!-- END: Theme JS-->

<!-- BEGIN: Page JS-->
<script src="app-assets/js/scripts/pages/dashboard-analytics.js"></script>
<!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>