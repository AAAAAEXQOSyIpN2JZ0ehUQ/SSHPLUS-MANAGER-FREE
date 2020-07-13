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
    <title>VIP-VPS - Entrar</title>
    <!-- <link rel="apple-touch-icon" href="app-assets/images/ico/favicon.ico">--> 
	<link rel="icon" type="image/png" sizes="16x16" href="../app-assets/images/favicon.png">
    <!-- <link rel="shortcut icon" type="image/x-icon" href="../app-assets/images/favicon.png">-->
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

<body class="fundodapagina vertical-layout vertical-menu-modern 1-column  navbar-floating footer-static  menu-collapsed blank-page blank-page" data-open="click" data-menu="vertical-menu-modern" data-col="1-column">

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="lineModalLabel"><i class="fas fa-envelope-open-text"></i> Recuperar Acesso</h4>
            </div>
            <div class="modal-body">
                <!-- content goes here -->
                <form name="recupera" action="recuperando.php" method="post">
                    <div class="form-group">
                        <center><label>Informe o E-mail </label></center>
                        <input type="text" class="form-control" name="email" placeholder="Digite...">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar</button>
                        <button type="submit" class="btn btn-success"><i class="fa fa-check"></i> Confirmar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- BEGIN: Content-->
<div class="app-content content">
    <div class="content-wrapper">
	<div class="login-register" style="background-image: url(index.jpg); background-size:cover;background-repeat:no-repeat;">
        <div class="content-header row">
        </div>
        <div class="content-body">
            <section class="row flexbox-container">
                <div class="col-xl-8 col-11 d-flex justify-content-center">
                    <div class="card bg-authentication rounded-0 mb-0">
                        <div class="row m-0">
                            <div class="col-lg-6 d-lg-block d-none text-center align-self-center px-1 py-0">
                                <img width="100%" height="100%" src="https://res.cloudinary.com/contas-vx-weblite/image/upload/v1485532814/F2Conecta/static/uploads/site/galeria/ZEO1uiCfbWkg5to_c2_Wp7z00LICYOsP5xl9vq_c2_bJ3nJ8RgPTwV0gYA0JRRVWTizEHt.png" alt="branding logo">
                            </div>
                            <div class="col-lg-6 col-12 p-0">
                                <div class="card rounded-0 mb-0 px-2">
                                    <div class="card-header pb-1">
                                        <div class="card-title">
                                       	
                                        </div>
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
                                    </div>
									<center><p><img src="login2.png" width="100%" height="100%"></p></center>
                                    <center><p class="px-2"><b>Bem vindo, faça login na sua conta.</b></p></center>
                                    <div class="card-content">
                                        <div class="card-body pt-1">
                                            <form method="post" action="logando.php">
                                                <fieldset class="form-label-group form-group position-relative has-icon-left">
                                                    <input type="text" class="form-control" id="login" name="login" placeholder="Usuário" required>
                                                    <div class="form-control-position">
                                                        <i class="feather icon-user"></i>
                                                    </div>
                                                    <label for="login">Usuário</label>
                                                </fieldset>

                                                <fieldset class="form-label-group position-relative has-icon-left">
                                                    <input type="password" class="form-control" id="senha" name="senha" placeholder="Senha" required>
                                                    <div class="form-control-position">
                                                        <i class="feather icon-lock"></i>
                                                    </div>
                                                    <label for="senha">Senha</label>
                                                </fieldset>
                                                <div class="form-group d-flex justify-content-between align-items-center">
                                                    <div class="text-left">
                                                        <fieldset class="checkbox">
                                                            <div class="vs-checkbox-con vs-checkbox-primary">
                                                                <input type="checkbox">
                                                                <span class="vs-checkbox">
                                                                        <span class="vs-checkbox--check">
                                                                            <i class="vs-icon feather icon-check"></i>
                                                                        </span>
                                                                    </span>
                                                                <span class="">Lembre-me</span>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                    
                                                </div>
                                                <button name="botaologin" class="btn btn-outline-info btn-lg btn-block text-uppercase waves-effect waves-light" type="submit"><i class="fa fa-sign-in"></i> <b>Entrar</b></button>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="login-footer">
                                        <div class="footer-btn d-inline text-center">
										<div class="form-group m-b-0">
                    
                       
						<center><b>VELOCIMETRO</b><a href="./teste.php" class="text-info m-l-5"><b> Teste</b></a></center>
						<b>SEM CONTA SSH?</b><a href="./new.php?p=admin" class="text-info m-l-5"><b> Cadastrar</b></a></p>
						</div>
                                        <div class="card-body">
											<center> © <script>document.write(new Date().getFullYear())</script> | All Rights Reserved <a href="http://www.vip-vps.com.br/" target="_blank" class="text-info m-l-5"><b> VIP-VPS V.25</b></a><b></b></center>
                                                <!--<p><b>NETPLUS</b> &copy; <script> document.write(new Date().getFullYear())</script> Todos os direitos reservados.</p>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    </div>
</div>
<!-- END: Content-->

<script>
    function myFunction() {
        var x = document.getElementById("senha");
        if (x.type === "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }
    }
</script>
<script type="text/javascript">
    $().ready(function() {
        demo.checkFullPageBackgroundImage();

        setTimeout(function() {
            // after 1000 ms we add the class animated to the login/register card
            $('.card').removeClass('card-hidden');
        }, 700)
    });
</script>
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
<script src="app-assets/vendors/js/vendors.min.js"></script>
<!-- BEGIN Vendor JS-->

<!-- BEGIN: Page Vendor JS-->
<!-- END: Page Vendor JS-->

<!-- BEGIN: Theme JS-->
<script src="app-assets/js/core/app-menu.js"></script>
<script src="app-assets/js/core/app.js"></script>
<script src="app-assets/js/scripts/components.js"></script>
<!-- END: Theme JS-->

<!-- BEGIN: Page JS-->
<!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>