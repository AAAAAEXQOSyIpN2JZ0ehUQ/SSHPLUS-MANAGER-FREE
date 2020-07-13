<?php 
require_once("pages/system/seguranca.php");

 if(isset($_GET["p"])){
	 
	 if($_GET["p"]=="admin"){
		$id_owner  = 0;				 
	 }else{
		$SQLUsuario = "select * from usuario where token_user = '".$_GET['p']."' ";
        $SQLUsuario = $conn->prepare($SQLUsuario);
        $SQLUsuario->execute();
		
	    if(($SQLUsuario->rowCount()) > 0){
		   $usuario = $SQLUsuario->fetch();
		   $id_owner  = $usuario['id_usuario'];
  
		}else{
		   echo '<script type="text/javascript">';
		   echo 	'alert("Nao encontrado!");';
		   echo	'window.location="login.php";';
		   echo '</script>'; 
		   exit;
			
		}	 

        $SQLSrv = "select * from servidor where demo='1' LIMIT 1";
        $SQLSrv = $conn->prepare($SQLSrv);
        $SQLSrv->execute();
				
	    if(($SQLSrv->rowCount()) < 0){
			echo '<script type="text/javascript">';
		   echo 	'alert("Nao disponivel!");';
		   echo	'window.location="login.php";';
		   echo '</script>'; 
		   exit;
			
		}else{
			$servidor = $SQLSrv->fetch();
		}
		   
	   
		 
		 
	 }
	
   }else{
	   
	    echo '<script type="text/javascript">';
		echo	'window.location="login.php";';
		echo '</script>'; 
		exit;
   }

   function geraSenha(){
				

					$salt = "1234";
					srand((double)microtime()*1000000); 

					$i = 0;
                    $pass = 0;
					while($i <= 7){

						$num = rand() % 10;
						$tmp = substr($salt, $num, 1);
						$pass = $pass . $tmp;
						$i++;

					}
					
					
					

					return $pass;

				}
	
    function geraLoginSSH(){
				

					$salt = "vip10";
					srand((double)microtime()*1000000); 

					$i = 0;
                    $pass = 0;
					while($i <= 7){

						$num = rand() % 10;
						$tmp = substr($salt, $num, 1);
						$pass = $pass . $tmp;
						$i++;

					}
					
					
					

					return $pass;

				}
	
$login_ssh = geraLoginSSH();

?>
<?php
    
	
   
	$SQLAcessoSRV = "SELECT * FROM servidor WHERE  demo='1' LIMIT 1";
    $SQLAcessoSRV = $conn->prepare($SQLAcessoSRV);
    $SQLAcessoSRV->execute();
   

if (($SQLAcessoSRV->rowCount()) > 0) {
    // output data of each row
   $row_srv_principal = $SQLAcessoSRV->fetch();
		
		?>
        
	<!--<option value="<?php echo $row_srv_principal['id_servidor'];?>" > <?php echo $row_srv_principal['nome'];?> - <?php echo $row_srv_principal['ip_servidor'];?> </option>-->
	
   <?php 
}

	
	$SQLAcessoSRV = "SELECT * FROM servidor WHERE   demo='1' ";
    $SQLAcessoSRV = $conn->prepare($SQLAcessoSRV);
    $SQLAcessoSRV->execute();
	

if (($SQLAcessoSRV->rowCount()) > 0) {
    // output data of each row
    while($row_srv = $SQLAcessoSRV->fetch()) {
		
		?>
 <center> <b class="text-info m-l-5"> <i class="far fa-server"></i>  <b> SERVIDOR DISPONIVEL</b></center>       
	<center><option class="rounded-lg btn btn-outline-info  waves-effect waves-light" value=" <?php echo $row_srv['id_servidor'];?>" >  <?php echo $row_srv['nome'];?> </option></p></center>
	
   <?php }
}

?>
<p> </p>
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
    <title>VIP-VPS V.25 - Cadastro</title>
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
                                <img width="400" height="300" src="https://res.cloudinary.com/contas-vx-weblite/image/upload/v1485532814/F2Conecta/static/uploads/site/galeria/ZEO1uiCfbWkg5to_c2_Wp7z00LICYOsP5xl9vq_c2_bJ3nJ8RgPTwV0gYA0JRRVWTizEHt.png" alt="branding logo">
                            </div>
                            <div class="col-lg-6 col-12 p-0">
                                <div class="card rounded-0 mb-0 px-2">
                                    <div class="card-header pb-1">
                                        <div class="card-title">
                                       	<p> </p>
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
  <a href="./" class="btn btn-outline-primary float-left btn-inline">VOLTAR</a>
  <br>
  <div>
  </div>
<div class="col-sm-12 centralizar">
  <div class="register-box-body">
  <div class="col-sm-12 centralizar">
  <center> <p class="text-info m-l-5"><b> Cadastro de Usuario </b></p></center>
    <p class="login-box-msg">Dados de Acesso ao Painel</p>
   
    <form action="new_afiliado.php" method="post">
	
	<input type="hidden" class="form-control"  id="p" name="p" value="<?php echo $_GET['p'];?>">
	<input type="hidden" class="form-control"  id="owner" name="owner" value="<?php echo $id_owner;?>">
	<?php if($_GET['p']!="admin"){?>
	<div class="form-group has-feedback">
        <input required="required" type="text" disabled class="form-control" value="<?php echo $usuario['login'];?>"  >
        <span class="glyphicon glyphicon-user form-control-feedback" ></span>
      </div>
	<?php } ?>
	 
      <div class="form-group has-feedback">
        <input required="required" type="text" class="form-control" placeholder="Nome e sobre nome" id="nome" name="nome" >
        <span class="glyphicon glyphicon-user form-control-feedback" ></span>		
	  </div>
	  
	   <div class="form-group has-feedback">
        <input required="required" type="text" class="form-control" placeholder="Usuario do Painel sem espaço" id="login_sistema" name="login_sistema">
        <span class="glyphicon glyphicon-user form-control-feedback" ></span>
	  </div>
      
      <div class="form-group has-feedback">
        <input type="password" class="form-control"  placeholder="Senha do painel sem espaço" id="senha_sistema" name="senha_sistema">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>		
      </div>
	  
	  <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Ex: 69992261779" id="celular" name="celular"  min="11">
        <span class="glyphicon glyphicon-earphone form-control-feedback"></span>
		
      </div>
	  <?php if($_GET['p']=="admin"){?>
	   <div class="form-group">
                <label>
                  <input type="radio" name="tipo" id="tipo" class="minimal" checked value="vpn">
				  Usuário SSH  
                </label>
                
        </div>
		<?php }else{ ?>
	  <input type="hidden" name="tipo" id="tipo"   value="vpn">
	    <?php } ?>
		<hr>
		
		<center> <p class="text-info m-l-5"><b>Dados de Acesso a Conta SSH</b></p></center>
	   <p class="login-box-msg">Apague o usuario e digite o seu, estes msm vc pode ver no seu painel </p> 
	   <div class="form-group has-feedback">
        <input required="required" type="text" class="form-control" placeholder="Login" id="login_ssh" name="login_ssh" value="<?php echo $login_ssh;?>">
        <span class="glyphicon glyphicon-user form-control-feedback" ></span>
      </div>
	   <div class="form-group has-feedback">
        <input type="password" class="form-control"  disabled placeholder="A Senha será enviada no Painel" >
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
	  <h6><p class="login-box-msg">Loga no painel com o usuario e senha que vc criou</p></h6>
	  <h6><p class="login-box-msg">O Usuario e Senha SSH, esta no painel em -> contas</p></h6>
	  <center><button type="submit" class="btn btn-outline-info btn-lg btn-block text-uppercase waves-effect waves-light"><i class="fa fa-sign-in"></i> <b>CRIAR CONTA</b></button></center>
       
      <div class="row">
       
        <!-- /.col -->
        
        <!-- /.col -->
		<div class="col-xs-4">
        </div>
		<!-- <a href="./" class="btn btn-outline-primary float-left btn-inline">INICIO</a> -->
      </div>
	  <div class="box-footer">
                <b></b>
				<br/>
				
              </div>
			  <center> © <script>document.write(new Date().getFullYear())</script> | All Rights Reserved <i class=""></i><a href="http://www.vip-vps.com.br/" target="_blank" class="text-info m-l-5"><b> VIP-VPS V.25</b></a><b></b></center>
			  <p> </p>
    </form>
<p> </p>
<p> </p>   
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
  <!-- /.form-box -->
</div>
<p> </p>
<!-- END: Header-->

<!-- END: Content-->

<div class="sidenav-overlay"></div>
<div class="drag-target"></div>

<!-- BEGIN: Footer-->
<footer class="footer footer-static footer-light">
    <center><p class="clearfix blue-grey lighten-2 mb-0">
        <span class="center">
            
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