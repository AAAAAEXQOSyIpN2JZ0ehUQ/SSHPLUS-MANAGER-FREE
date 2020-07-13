<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
<script>
    $(document).ready(function ($) {
        //$("[data-mask]").inputmask();
        //Inputmask().mask(document.querySelectorAll("input"));
        $('#celular').inputmask("(11) 999[9]9999");  //static mask
    });
</script>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
    <!-- Input with Icons start -->
    <section id="input-with-icons">
        <div class="row match-height">
            <div class="col-12">
                <div class="card border-info mb-3">
                    <div class="card-header">
                        <h1 class="card-title font-medium-2"><i class="fad fa-user-tie text-primary font-large-1"></i> Adicionar Usuario ao Painel</h1>
                    </div>
                    <div class="card-content">
                        <form data-toggle="validator" action="pages/system/funcoes.usuario.php" method="GET" role="form">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <p>Adicionar acesso ao Painel!</p>
                                    </div>
                                    <div class="col-sm-6 col-12">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Nome
                                        </div>
                                        <fieldset class="form-group position-relative has-icon-left">
                                            <input type="text" name="nome" id="nome" class="form-control" minlength="3" placeholder="Digite o Nome..." required>
                                            <div class="form-control-position">
                                                <i class="fad fa-user-tie"></i>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-sm-6 col-12">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Celular
                                        </div>
                                        <fieldset class="form-group position-relative">
                                            <input type="text" name="celular" id="celular" placeholder="Digite os 11 Digítos..." value="(11) 99999-9999" class="form-control" minlength="8" maxlength="16" required>
                                            <div class="form-control-position">
                                                <i class="fad fa-mobile-android"></i>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-sm-6 col-12">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Usuário
                                        </div>
                                        <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                            <input type="text" name="login" id="login" class="form-control" data-minlength="4" data-maxlength="32" placeholder="Digite o usuário" required="">
                                            <div class="form-control-position">
                                                <i class="fad fa-user-tie"></i>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-sm-6 col-12">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Senha
                                        </div>
                                        <fieldset class="form-group position-relative input-divider-right">
                                            <input type="password" min="3" max="32" class="form-control"  name="senha" data-minlength="6" id="senha"  placeholder="Digite a senha..." required>
                                            <div class="form-control-position">
                                                <i class="fad fa-key-skeleton"></i>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-sm-12 col-12 text-center">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Selecione o tipo de acesso
                                        </div>
                                        <div class="form-group">
                                            <input type="hidden" class="form-control" id="owner" name="owner" value="<?php echo $_SESSION['usuarioID']; ?>">
                                            <input type="hidden" class="form-control" id="diretorio" name="diretorio"  value="../../home.php">
                                            <input type="hidden" class="form-control" id="op" name="op"  value="new">
                                            <ul class="list-unstyled mb-0">
                                                <li class="d-inline-block mr-2">
                                                    <?php if($usuario['subrevenda']<>'sim'){ ?>
                                                        <fieldset>
                                                            <div class="vs-radio-con">
                                                                <input id="radio1" type="radio" name="tipo" value="1">
                                                                <span class="vs-radio">
		                                                  <span class="vs-radio--border"></span>
		                                                  <span class="vs-radio--circle"></span>
		                                              </span>
                                                                <span class="">Revendedor</span>
                                                            </div>
                                                        </fieldset>
                                                    <?php } ?>
                                                </li>
                                                <li class="d-inline-block mr-2">
                                                    <fieldset>
                                                        <div class="vs-radio-con vs-radio-success">
                                                            <input id="radio2" type="radio" name="tipo" value="2">
                                                            <span class="vs-radio">
		                                                  <span class="vs-radio--border"></span>
		                                                  <span class="vs-radio--circle"></span>
		                                              </span>
                                                            <span class="">Usuário VPN</span>
                                                        </div>
                                                    </fieldset>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 col-12 text-center">
                                        <button type="submit" class="btn btn-success round">Criar</button>
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
