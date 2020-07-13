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
    <title>VIP-VPS V.25 - Velocimetro</title>
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
<div class="box-footer">
                <b></b>
				<br/>
				
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
 <div class="box-footer">
                <b></b>
				<br/>
				
              </div>
<center><a href="./" class="btn btn-outline-primary float-left btn-inline">VOLTAR</a></center>
<div class="box-footer">
                <b></b>
				<br/>
				
              </div>
<center><h3><i class='fa fa-tachometer' style='font-size:48px;color:#d29a18'></i> <b></b></h3></center>

<iframe id="iFrameVideos" src="https://fast.com/pt" height="100%" width="100%" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes" allowfullscreen="allowfullscreen" > Por favor, use um navegador que suporte iframes!</iframe>
<script>iFrameResize({log: false, inPageLinks: true}, '#iFrameVideos')</script>

</div>

<!-- END: Header-->

<!-- END: Content-->

<div class="sidenav-overlay"></div>
<div class="drag-target"></div>

<!-- BEGIN: Footer-->
<footer class="footer footer-static footer-light">
    <center><p class="clearfix blue-grey lighten-2 mb-0">
        <span class="center">
            &copy; <script> document.write(new Date().getFullYear())</script>
            <a class="text-bold-800 grey darken-2" href="http://www.vip-vps.com.br/" target="_blank"> VIP-VPS V.25</a></span>
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
