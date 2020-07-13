<?php
require_once("../pages/system/funcoes.php");
require_once("../pages/system/seguranca.php");
require_once("../pages/system/config.php");
require_once("../pages/system/classe.ssh.php");

protegePagina("admin");
if( $_SESSION['tipo'] == "user"){
    expulsaVisitante();
}


$data_atual = date("Y-m-d");

$SQLAdministrador = "SELECT * FROM admin WHERE id_administrador = '".$_SESSION['usuarioID']."'";
$SQLAdministrador = $conn->prepare($SQLAdministrador);
$SQLAdministrador->execute();
$administrador = $SQLAdministrador->fetch();

//Carrega qtd contas ssh do sistema

$SQLUsuario_sshSUSP = "select * from usuario_ssh WHERE status='2' ";
$SQLUsuario_sshSUSP = $conn->prepare($SQLUsuario_sshSUSP);
$SQLUsuario_sshSUSP->execute();
$ssh_susp_qtd += $SQLUsuario_sshSUSP->rowCount();

$SQLContasSSH = "SELECT * FROM usuario_ssh ";
$SQLContasSSH = $conn->prepare($SQLContasSSH);
$SQLContasSSH->execute();
$contas_ssh = $SQLContasSSH->rowCount();


$total_acesso_ssh = 0;
$SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh  ";
$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
$SQLAcessoSSH->execute();
$SQLAcessoSSH = $SQLAcessoSSH->fetch();
$total_acesso_ssh += $SQLAcessoSSH['quantidade'];

$total_acesso_ssh_online = 0;
$SQLAcessoSSH = "SELECT sum(online) AS quantidade  FROM usuario_ssh  ";
$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
$SQLAcessoSSH->execute();
$SQLAcessoSSH = $SQLAcessoSSH->fetch();
$total_acesso_ssh_online += $SQLAcessoSSH['quantidade'];


//carrega qtd de todos os usuarios do sistema
$SQLUsuarios = "SELECT * FROM usuario ";
$SQLUsuarios = $conn->prepare($SQLUsuarios);
$SQLUsuarios->execute();
$all_usuarios_qtd = $SQLUsuarios->rowCount();

//carrega qtd de todos os usuarios do sistema SSH
$SQLVPN = "SELECT * FROM usuario  where tipo='vpn' ";
$SQLVPN = $conn->prepare($SQLVPN);
$SQLVPN->execute();
$all_usuarios_vpn_qtd = $SQLVPN->rowCount();

$SQLVPN = "SELECT * FROM usuario  where tipo='vpn' and ativo='2' ";
$SQLVPN = $conn->prepare($SQLVPN);
$SQLVPN->execute();
$all_usuarios_vpn_qtd_susp = $SQLVPN->rowCount();

//carrega qtd de todos os usuarios do sistema SSH
$SQLRevenda = "SELECT * FROM usuario  where tipo='revenda' ";
$SQLRevenda = $conn->prepare($SQLRevenda);
$SQLRevenda->execute();
$all_usuarios_revenda_qtd = $SQLRevenda->rowCount();
//carrega qtd de todos os usuarios do sistema SSH
$SQLRevenda = "SELECT * FROM usuario  where tipo='revenda' and ativo='2'";
$SQLRevenda = $conn->prepare($SQLRevenda);
$SQLRevenda->execute();
$revenda_qtd_susp = $SQLRevenda->rowCount();

//carrega qtd de servidores
$SQLServidor = "SELECT * FROM servidor ";
$SQLServidor = $conn->prepare($SQLServidor);
$SQLServidor->execute();
$servidor_qtd = $SQLServidor->rowCount();

// arquivos download
$SQLArquivos= "select * from  arquivo_download";
$SQLArquivos = $conn->prepare($SQLArquivos);
$SQLArquivos->execute();
$todosarquivos = $SQLArquivos->rowCount();
// Faturas
$SQLfaturas= "select * from  fatura where status='pendente'";
$SQLfaturas = $conn->prepare($SQLfaturas);
$SQLfaturas->execute();
$faturas = $SQLfaturas->rowCount();
// Notificações
$SQLnoti= "select * from  notificacoes where lido='nao' and admin='sim'";
$SQLnoti = $conn->prepare($SQLnoti);
$SQLnoti->execute();
$totalnoti = $SQLnoti->rowCount();
// Notificações fatura
$SQLnoti2= "select * from  notificacoes where lido='nao' and tipo='fatura' and admin='sim'";
$SQLnoti2= $conn->prepare($SQLnoti2);
$SQLnoti2->execute();
$totalnoti_fatura = $SQLnoti2->rowCount();
// Notificações chamados
$SQLnoti3= "select * from  notificacoes where lido='nao' and tipo='chamados' and admin='sim'";
$SQLnoti3= $conn->prepare($SQLnoti3);
$SQLnoti3->execute();
$totalnoti_chamados = $SQLnoti3->rowCount();

//Todos os chamados subRevendedores e usuarios do revendedor
$SQLchamadoscli2= "select * from  chamados where status='resposta' and id_mestre=0";
$SQLchamadoscli2= $conn->prepare($SQLchamadoscli2);
$SQLchamadoscli2->execute();
$all_chamados += $SQLchamadoscli2->rowCount();
//Todos os chamados subRevendedores e usuarios do revendedor
$SQLchamadoscli= "select * from  chamados where status='aberto' and id_mestre=0";
$SQLchamadoscli= $conn->prepare($SQLchamadoscli);
$SQLchamadoscli->execute();
$all_chamados += $SQLchamadoscli->rowCount();



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
    <meta name="msapplication-TileColor" content="#1e88e5">
    <meta name="theme-color" content="#1e88e5">
    <title>VIP-VPS V.25 - Admin</title>
    <!--<link rel="apple-touch-icon" href="../app-assets/images/ico/favicon.ico">-->
	<link rel="icon" type="image/png" sizes="16x16" href="../app-assets/images/favicon.png">
    <!--<link rel="shortcut icon" type="image/x-icon" href="../app-assets/images/ico/favicon.ico">-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Icon CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/fonts/font-awesome/css/all.css">
    <!-- END: Icon CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../app-assets/css/plugins/tour/tour.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <!-- END: Custom CSS-->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu-modern 2-columns navbar-floating footer-static" data-open="click" data-menu="vertical-menu-modern" data-col="2-columns">

    <div class="modal fade" id="flaggeral" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-flag"></i> Alertar Todos!</h3>
                </div>
                <div class="modal-body">

                    <!-- content goes here -->
                    <form name="editaserver" action="pages/notificacoes/notificar_home.php" method="post">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Tipo de Notificação </label>
                            <select size="1" name="clientes" class="form-control select2 col-lg-12">
                                <option value="1" selected=selected>Todos</option>
                                <option value="2">Revendedores</option>
                                <option value="3" >Clientes</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Mensagem</label>
                            <textarea class="form-control" name="msg" rows="5" cols="20" wrap="off" placeholder="Digita sua mensagem..."></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar</button>
                            <button class="btn btn-success">Confirmar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

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

<script>
    //paste this code under head tag or in a seperate js file.
    // Wait for window load
    $(window).load(function() {
        // Animate loader off screen
        $(".se-pre-con").fadeOut('slow');;
    });
</script>

<!-- BEGIN: Main Menu-->
<div class="main-menu menu-fixed menu-light menu-accordion menu-shadow" data-scroll-to-active="false">
    <div class="navbar-header">
        <ul class="nav navbar-nav flex-row">
            <li class="nav-item mr-auto"><a class="navbar-brand" href="/admin/home.php">
                <img class="rounded-lg" src="../app-assets/images/logo/logomenu.png" alt="avatar" height="35" width="225" />
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

            <li class=" nav-item"><a href="#"><i class="ficon fal fa-greater-than-equal text-info"></i><span class="menu-title" data-i18n="Area VPN"> CONTAS SSH</span><span class="badge badge badge-info badge-pill float-right mr-2"><?php echo $contas_ssh; ?></span></a>
                <ul class="menu-content">
                    <li><a href="?page=ssh/adicionar"><i class="ficon fad fa-terminal"></i><span class="menu-item" data-i18n="Criar VPN"> Criar Conta SSH</span></a>
                    </li>
					<li><a href="?page=ssh/add_teste"><i class="ficon fad fa-clock"></i><span class="menu-item" data-i18n="Teste SSH"> Criar Teste SSH</span></a>
                    </li>
                    <li><a href="?page=ssh/online"><i class="ficon ficon fad fa-rocket"></i><span class="menu-item" data-i18n="SSH Online"> SSH Online</span></a>
					</li>
                    <li><a href="?page=ssh/contas"><i class="ficon ficon fad fa-list-ul"></i><span class="menu-item" data-i18n="Listar VPN"> Listar SSH</span></a>
                    </li>
					<li><a href="?page=ssh/erro"><i class="ficon fad fa-trash"></i><span class="menu-item" data-i18n="Criar Teste"> Contas com Erro</span></a>
                    </li>
                </ul>
            </li>

            <li class=" nav-item"><a href="#"><i class="ficon fal fa-user text-primary"></i><span class="menu-title" data-i18n="Area de Cliente"> CLIENTES</span><span class="badge badge badge-primary badge-pill float-right mr-2"><?php echo $all_usuarios_qtd; ?></span></a>
                <ul class="menu-content">
                    <li><a href="?page=usuario/1-etapa"><i class="ficon fad fa-user-plus"></i><span class="menu-item" data-i18n="Novo Usuário"> Novo Usuário</span></a>
                    </li>
                    <li><a href="?page=usuario/revenda"><i class="ficon fad fa-user-tie"></i><span class="menu-item" data-i18n="Revendedor SSH"> Revendedor SSH</span></a>
                    </li>
                    <li><a href="?page=usuario/usuario_ssh"><i class="ficon fad fa-user-shield"></i><span class="menu-item" data-i18n="Usuario VPN"> Usuario VPN</span></a>
                    </li>
                    <li><a href="?page=usuario/listar"><i class="ficon fad fa-users"></i><span class="menu-item" data-i18n="Usuario VPN"> Todos Clientes</span></a>
                    </li>
                    <li><a href="?page=usuario/addservidor"><i class="ficon fad fa-user-edit"></i><span class="menu-item" data-i18n="Add. Sevidor"> Add. Sevidor</span></a>
                    </li>
                </ul>
            </li>

            <li class=" nav-item"><a href="#"><i class="ficon fad fa-user-check text-info"></i><span class="menu-title" data-i18n="Area VPN"> CADASTRO</span><span class="badge badge badge-info badge-pill float-right mr-2"><?php echo $servidor_qtd; ?></span></a>
                <ul class="menu-content">
                    <li><a href="?page=demo/configurar"><i class="ficon fad fa-terminal"></i><span class="menu-item" data-i18n="Criar VPN"> Liberar Cadastro </span></a>
					<span class="pull-right-container">
                    <small class="label pull-right bg-green">Novo</small>
			        </li>
                </ul>
            </li>
			
            <li class=" nav-item"><a href="#"><i class="ficon fal fa-microchip text-warning"></i><span class="menu-title" data-i18n="Alterar"> SERVIDORES</span><span class="badge badge badge-warning badge-pill float-right mr-2"><?php echo $servidor_qtd; ?></span></a>
                <ul class="menu-content">
                    <li><a href="?page=servidor/adicionar"><i class="ficon fad fa-hdd"></i><span class="menu-item" data-i18n="Alterar"> Novo servidor</span></a>
                    </li>
                    <li><a href="?page=servidor/listar"><i class="ficon fad fa-list-ul"></i><span class="menu-item" data-i18n="Alterar"> Listar servidores</span></a>
                    </li>
                    <li><a href="?page=servidor/alocados"><i class="ficon fad fa-user-cog"></i><span class="menu-item" data-i18n="Alterar"> Servidores Alocados</span></a>
                    </li>
                </ul>
            </li>

            <li class=" nav-item"><a href="#"><i class="ficon fal fa-wallet text-success"></i><span class="menu-title" data-i18n="Faturas"> FATURAS</span><span class="badge badge badge-success badge-pill float-right mr-2"><?php echo $faturas; ?></span></a>
                <ul class="menu-content">
                    <li><a href="?page=faturas/abertas"><i class="ficon fad fa-file-invoice-dollar"></i><span class="menu-item" data-i18n="Abertas"> Abertas</span></a>
                    </li>
                    <li><a href="?page=faturas/pagas"><i class="ficon fad fa-file-powerpoint"></i><span class="menu-item" data-i18n="Pagas"> Pagas</span></a>
                    </li>
                    <li><a href="?page=faturas/canceladas"><i class="ficon fad fa-file-excel"></i><span class="menu-item" data-i18n="Canceladas"> Canceladas</span></a>
                    </li>
                    <li><a href="?page=faturas/comprovantes"><i class="ficon fad fa-file-invoice"></i><span class="menu-item" data-i18n="Comprovantes"> Comprovantes</span></a>
                    </li>
                    <li><a href="?page=faturas/cpfechados"><i class="ficon fad fa-file-csv"></i><span class="menu-item" data-i18n="CP Fechados"> CP Fechados</span></a>
                    </li>
                </ul>
            </li>

            <li class=" nav-item"><a href="#"><i class="ficon fal fa-bells text-danger"></i><span class="menu-title" data-i18n="Chamados"> CHAMADOS</span><span class="badge badge badge-danger badge-pill float-right mr-2"><?php echo $all_chamados; ?></span></a>
                <ul class="menu-content">
                    <li><a href="?page=chamados/abertas"><i class="ficon fad fa-user-tag"></i><span class="menu-item" data-i18n="Abertos"> Abertos</span></a>
                    </li>
                    <li><a href="?page=chamados/respondidos"><i class="ficon fad fa-user-check"></i><span class="menu-item" data-i18n="Respondidos"> Respondidos</span></a>
                    </li>
                    <li><a href="?page=chamados/encerrados"><i class="ficon fad fa-user-times"></i><span class="menu-item" data-i18n="Encerrados"> Encerrados</span></a>
                    </li>
                </ul>
            </li>
            <li class=" nav-item"><a href="#"><i class="ficon fal fa-cog text-info"></i><span class="menu-title" data-i18n="Configurações"> CONFIGURAÇÕES</span></a>
                <ul class="menu-content">
				    <!-- <li><a href="?page=apps"><i class="ficon fad fa-user-tie"></i><span class="menu-item" data-i18n="Minhas Informações"> Gerenciar App</span></a> -->
                    </li>
                    <li><a href="?page=admin/dados"><i class="ficon fad fa-user-tie"></i><span class="menu-item" data-i18n="Minhas Informações"> Minhas Informações</span></a>
                    </li>
                    <li><a href="?page=apis/gerenciar"><i class="ficon fad fa-cog"></i><span class="menu-item" data-i18n="Gerenciar APIS"> Gerenciar APIS</span></a>
                    </li>
                    <li><a href="?page=notificacoes/notificar"><i class="ficon fad fa-bell-plus"></i><span class="menu-item" data-i18n="Notificações"> Notificações</span></a>
                    </li>
                    <li><a href="?page=download/downloads"><i class="ficon fad fa-archive"></i><span class="menu-item" data-i18n="Arquivos"> Arquivos</span></a>
                    </li>
                    <li><a href="?page=email/enviaremail"><i class="ficon fad fa-envelope"></i><span class="menu-item" data-i18n="Email"> Email</span></a>
                    </li>
                </ul>
            </li>
            <li class=" nav-item"><a href="sair.php"><i class="ficon fal fa-power-off text-danger"></i><span class="menu-title" data-i18n="Raise Support"> SAIR</span></a>
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
                            <li class="nav-item mobile-menu d-xl-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ficon fad fa-bars"></i></a></li>
                        </ul>
                        <ul class="nav navbar-nav bookmark-icons">
                          <style type='text/css'>
                              .dark-layout {}
                          </style>
                          <div class="custom-control custom-switch mr-0 mb-0">
                              <input type="checkbox" class="custom-control-input" id="dark-layout">
                              <label class="custom-control-label" for="dark-layout">
                                  <span class="switch-icon-left"><i class="fal fa-sun"></i></span>
                                  <span class="switch-icon-right" ><i class="fal fa-eclipse-alt"></i></span>
                              </label>
                          </div>
                      </ul>
                      <!-- novo code -->
                  </div>

                  <ul class="nav navbar-nav float-right">
                    <li class="nav-item"><a class="nav-link nav-link-expand"><i class="ficon fad fa-compress"></i></a></li>
                    <li class="nav-item"><a class="nav-link" href="#flaggeral" data-toggle="modal" data-placement="top" title="Notificar"><i class="ficon fad fa-comment-alt-lines"></i></a></li>
                    <li class="dropdown dropdown-notification nav-item"><a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i class="ficon fad fa-rocket"></i><span class="badge badge-pill badge-success badge-up" id="online_nav"><?php echo $total_acesso_ssh_online; ?></span></a>
                        <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                            <li class="dropdown-menu-header">
                                <div class="dropdown-header m-0 p-2">
                                    <h3 <span class="notification-title">Usuários | Conectados</h3></span>
                                </div>
                            </li>
                            <li class="scrollable-container media-list">
                                <a class="d-flex justify-content-between" href="javascript:void(0)">
                                    <div class="media d-flex align-items-start">
                                        <div class="media-body">
                                            <h6 class="primary media-heading" id="usuarioson"></h6><small class="notification-text"></small>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="dropdown-menu-footer"><a class="dropdown-item p-2 text-center" href="home.php?page=ssh/online">| Ver todos |</a></li>
                        </ul>
                    </li>
                    <li class="dropdown dropdown-notification nav-item"><a class="nav-link nav-link-label" href="#" data-toggle="dropdown"><i class="ficon fad fa-bell"></i><span class="badge badge-pill badge-danger badge-up"><?php echo $totalnoti;?></span></a>
                        <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                            <li class="dropdown-menu-header">
                                <div class="dropdown-header m-0 p-2">
                                    <h2 class="white"><?php echo $totalnoti;?> <?php if($totalnoti==0){?></h2>
                                    <span class="notification-title">Você não possui novas notificações</span>
                                <?php }else{ ?>
                                    <span class="notification-title">Você possui <?php echo $totalnoti;?> nova <?php if($totalnoti>1){ echo "s";}?> <?php if($totalnoti<=1){ echo "notificação";}else { echo "notificações";}?></span>
                                <?php }?>
                            </div>
                        </li>
                        <li class="scrollable-container media-list">
                            <a class="d-flex justify-content-between" href="javascript:void(0)">
                                <div class="media d-flex align-items-start">
                                    <div class="media-left"><i class="fal fa-file-invoice-dollar font-medium-5 success"></i></div>
                                    <div class="media-body">
                                        <h6 class="success media-heading"><?php echo $totalnoti_fatura;?> Em Faturas</h6>
                                        <small class="notification-text"> Notificações de Faturas</small>
                                    </div>
                                </div>
                            </a>
                            <a class="d-flex justify-content-between" href="javascript:void(0)">
                                <div class="media d-flex align-items-start">
                                    <div class="media-left"><i class="fal fa-clipboard-list-check font-medium-5 danger"></i></div>
                                    <div class="media-body">
                                        <h6 class="danger media-heading"><?php echo $totalnoti_chamados;?> Em Chamados</h6>
                                        <small class="notification-text"> Notificações de chamados</small>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="dropdown-menu-footer"><a class="dropdown-item p-1 text-center" href="?page=notificacoes/notificacoes&ler=all">Ver todos</a></li>
                    </ul>
                </li>
                <li class="dropdown dropdown-user nav-item">
                    <a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                        <div class="user-nav d-sm-flex d-none">
                            <span class="user-name text-bold-600"><?php echo strtoupper($administrador['nome']);?></span>
                            <span class="user-status">Adiministrador</span>
                        </div>
                        <span>
                            <img class="round" src="../app-assets/images/portrait/avatar/user2-160x160.png" alt="avatar" height="40" width="40" />
                        </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="?page=admin/dados"><i class="fad fa-user-tie"></i> Meu Perfil</a>
                        <a class="dropdown-item" href="?page=apis/gerenciar"><i class="fad fa-cog"></i> Configuração</a>
                        <a class="dropdown-item" href="?page=email/enviaremail"><i class="fad fa-at"></i> Email</a>
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
    $(document).ready(function(){
        $("#minhaPesquisa").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#MeuServidor tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
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
<script src="../app-assets/vendors/js/vendors.min.js"></script>
<!-- BEGIN Vendor JS-->

<!-- BEGIN: Page Vendor JS-->
<script src="../app-assets/vendors/js/charts/apexcharts.min.js"></script>
<script src="../app-assets/vendors/js/extensions/tether.min.js"></script>
<!-- END: Page Vendor JS-->

<!-- BEGIN: Theme JS-->
<script src="../app-assets/js/core/app-menu.js"></script>
<script src="../app-assets/js/core/app.js"></script>
<script src="../app-assets/js/scripts/components.js"></script>
<!-- END: Theme JS-->

<!-- BEGIN: Page JS-->
<script src="../app-assets/js/scripts/pages/dashboard-analytics.js"></script>
<!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>
