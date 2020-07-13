<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}
$procnoticias= "select * FROM noticias where status='ativo'";
$procnoticias = $conn->prepare($procnoticias);
$procnoticias->execute();


        // Clientes
        $SQLbuscaclientes= "select * from usuario where tipo='vpn'";
        $SQLbuscaclientes = $conn->prepare($SQLbuscaclientes);
        $SQLbuscaclientes->execute();
        $totalclientes = $SQLbuscaclientes->rowCount();
        // Revendedores
        $SQLbuscarevendedores= "select * from  usuario where tipo='revenda'";
        $SQLbuscarevendedores = $conn->prepare($SQLbuscarevendedores);
        $SQLbuscarevendedores->execute();
        $totalrevendedores = $SQLbuscarevendedores->rowCount();
        // Servidores
        $SQLbuscaservidores= "select * from  servidor";
        $SQLbuscaservidores= $conn->prepare($SQLbuscaservidores);
        $SQLbuscaservidores->execute();
        $totalservidores = $SQLbuscaservidores->rowCount();
?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-edit text-success font-large-1"></i> Alterar Informações</h1>
                </div>
                <div class="card-content">
									<form action="pages/admin/alterar.php" method="POST" role="form">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <p>Alterar suas informações com cuidado.</p>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="text-bold-600 font-medium-2 mb-1">
                                    Nome
                                </div>
                                <fieldset class="form-group position-relative has-icon-left">
                                  <input type="text" name="nome" id="nome" class="form-control" minlength="3"  value="<?php echo $administrador['nome'];?>" required>
                                    <div class="form-control-position">
                                        <i class="fad fa-user"></i>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="text-bold-600 font-medium-2 mb-1">
                                    Login
                                </div>
                                <fieldset class="form-group position-relative">
                                  <input type="text" disabled class="form-control" minlength="3" value="<?php echo $administrador['login'];?>" required="">
                                    <div class="form-control-position">
                                        <i class="fad fa-user"></i>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="text-bold-600 font-medium-2 mb-1">
                                    Email
                                </div>
                                <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                  <input type="text" name="email" id="email" minlength="3" class="form-control" value="<?php echo $administrador['email'];?>" required>
                                    <div class="form-control-position">
                                        <i class="fad fa-at"></i>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="text-bold-600 font-medium-2 mb-1">
                                    Site do Painel
                                </div>
                                <fieldset class="form-group position-relative input-divider-right">
                                  <input type="text" name="site" id="site" minlength="3" value="<?php echo $administrador['site'];?>" class="form-control" required>
                                    <div class="form-control-position">
                                        <i class="fad fa-globe-americas"></i>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="text-bold-600 font-medium-2 mb-1">
                                    Senha Antiga
                                </div>
                                <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                  <input type="password" name="senhaantiga" id="senhaantiga" minlength="3" placeholder="Digite a Senha Antiga..." class="form-control">
                                    <div class="form-control-position">
                                        <i class="fad fa-key-skeleton"></i>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-sm-6 col-12">
                                <div class="text-bold-600 font-medium-2 mb-1">
                                    Senha Nova
                                </div>
                                <fieldset class="form-group position-relative input-divider-right">
                                  <input type="password" name="novasenha" id="novasenha" minlength="3" placeholder="Digite a Nova Senha..." class="form-control">
                                    <div class="form-control-position">
                                        <i class="fad fa-key-skeleton"></i>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-sm-12 col-12	text-center">
                                <button type="submit" class="btn btn-success round">Salvar</button>
                                <button type="reset" class="btn btn-danger round">Limpar</button>
                            </div>
                        </div>
                    </div>
                  </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Input with Icons end -->
