<?php

require_once("system/seguranca.php");
require_once("system/config.php");

protegePagina("user");


$SQLUsuario = "SELECT * FROM usuario WHERE id_usuario = '".$_SESSION['usuarioID']."'";
$SQLUsuario = $conn->prepare($SQLUsuario);
$SQLUsuario->execute();
$usuario = $SQLUsuario->fetch();

if(($usuario['ativo']==1)|| ($usuario['tipo']=='vpn')){
 echo '<script type="text/javascript">';
 echo   'alert("Sua conta não encontra-se Suspensa!");';
 echo   'window.location="../home.php";';
 echo '</script>';
 exit;
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
    <meta name="keywords" content="VIP-VPS, VPS, SSH, VPN">
    <meta name="author" content="Adeilsonfi">
    <meta name="msapplication-TileColor" content="#1e88e5">
    <meta name="theme-color" content="#1e88e5">
    <title>VIP-VPS - SUSPENSO</title>
    <!-- <link rel="apple-touch-icon" href="../app-assets/images/ico/favicon.ico">-->
	<link rel="icon" type="image/png" sizes="16x16" href="../app-assets/images/favicon.png">
    <!-- <link rel="shortcut icon" type="image/x-icon" href="../app-assets/images/ico/favicon.ico">-->
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
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <!-- END: Custom CSS-->

</head>
<!-- END: Head-->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body class="vertical-layout 1-column navbar-floating footer-static blank-page blank-page pace-done menu-hide vertical-overlay-menu" data-open="click" data-menu="vertical-menu-modern" data-col="1-column"><div class="pace  pace-inactive"><div class="pace-progress" data-progress-text="100%" data-progress="99" style="transform: translate3d(100%, 0px, 0px);">
  <div class="pace-progress-inner"></div>
</div>
<div class="pace-activity"></div></div>
<!-- BEGIN: Content-->
<div class="app-content content">
  <div class="content-wrapper">
    <div class="content-header row">
    </div>
    <div class="content-body">
        <section class="row flexbox-container">
            <div class="col-xl-12 col-12 d-flex justify-content-center">
              <div class="row">
                <div class="col-12">
                  <div class="card border-danger">
                    <div class="card-content">
                      <div class="card-body text-center">
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
					  <center><p><img src="../login2.png" width="100%" height="100%"></p></center>
                        <center><p><h3 class="text-danger"><i class="fa fa-ban"></i> <b>Seu acesso está Suspenso!</b></h3></p></center>
						<center><h5 class="alert alert-warning"><i class="fas fa-user"></i> <b> incluido Todos os usuários do Painel <br>Atenção: Apos 5 dias Vencido sua Conta e Deletada</b></h5></center>
                        <div class="avatar avatar-xl bg-gradient-danger shadow mt-0">
                          <div class="avatar-content">
                            <img alt="thumbnail" class="img-circle" width="100" src="../app-assets/images/portrait/avatar/avatar1.png" alt="User Image">
                        </div>
                    </div>
                    <div class="text-center">
                      <div class="form-group text-center m-t-20">
                          <div class="col-xs-12"><br>
                            <div class="alert alert-danger"><h3><i class="fa fa-info-circle"></i><b>Pagamento em atraso !</h3><p>Entre em contato pelo telegram e resolva a sua<br>situação agora mesmo com seu <a href="#">Fornecedor</a></p></b></div>
                        </div>
                    </div>
                    <a href="../index.php" class="btn btn-outline-info btn-lg btn-block text-uppercase waves-effect waves-light"><i class="fa fa-sign-in"></i> <b>Entrar</b></a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<footer class="footer footer-static footer-light">
    <center><p class="clearfix blue-grey lighten-2 mb-0">
        <span class="center">
			<center> © <script>document.write(new Date().getFullYear())</script> | <a href="http://www.vip-vps.tk/" target="_blank" class="text-info m-l-5"><b>VIP-VPS V.25</b></a><br>TODOS DIREITOS RESERVADOS</center>
        </span>
        <button class="btn btn-primary btn-icon scroll-top" type="button"><i class="feather icon-arrow-up"></i></button>
    </p></center>
</footer>
</section>
</div>
</div>
</div>
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
<!-- BEGIN: Footer-->
<script src="../app-assets/vendors/js/vendors.min.js"></script>
<script src="../app-assets/vendors/js/charts/apexcharts.min.js"></script>
<script src="../app-assets/vendors/js/extensions/tether.min.js"></script>
<script src="../app-assets/js/core/app-menu.js"></script>
<script src="../app-assets/js/core/app.js"></script>
<script src="../app-assets/js/scripts/components.js"></script>
<script src="../app-assets/js/scripts/pages/dashboard-analytics.js"></script>
<!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>