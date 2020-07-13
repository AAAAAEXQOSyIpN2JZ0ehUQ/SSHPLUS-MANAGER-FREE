<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
<script language="JavaScript">
<!--
function desabilitar(){
with(document.form){
qtd_ssh.disabled=true;
}
}
function habilitar(){
with(document.form){

qtd_ssh.disabled=false;

}
}
// -->
$('.radiosbordas').click(function() {
  $('.hli').removeClass('hli');
  $(this).addClass('hli').find('input').prop('checked', true)
});
</script>
<script>
$(document).ready(function ($) {
	//Initialize Select2 Elements
	$(".select2").select2();
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
                    <h1 class="card-title font-medium-2"><i class="fad fa-user-plus text-primary font-large-1"></i> Adicionar Cliente ao Painel</h1>
                </div>
                <div class="card-content">
                    <form data-toggle="validator" action="pages/usuario/adicionar_exe.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Adicionar acesso ao painel !</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Nome
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <input type="text" name="nome" id="nome" class="form-control" minlength="4" placeholder="Digite o Nome ..." required>
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
                                        <input type="text" name="celular" id="celular" placeholder="Digite os 11 Digítos..." value="(11) 99999-9999" class="form-control" minlength="4" maxlength="16" required>
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
                                        <input type="text" name="login" id="login" class="form-control" minlength="4" placeholder="Digite o Usuario..." required="">
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
                                        <input type="password" min="4" max="32" class="form-control"  name="senha" data-minlength="4" id="senha" placeholder="Digite a Senha..." required>
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>

                                <div class="col-sm-12 col-12 text-center">
                                    <div class="text-bold-600 font-medium-1 mb-1">
                                        Qual opção abaixo o usuario vai ser?
                                    </div>
                                    <div class="form-group">
                                        <ul class="list-unstyled mb-1">
                                            <li class="d-inline-block mr-2">
                                                <fieldset>
                                                    <div class="vs-radio-con">
                                                        <input type="radio" class="check" id="radio1" name="tipo" value="revenda" data-radio="iradio_flat-red">
                                                        <span class="vs-radio">
		                                                  <span class="vs-radio--border"></span>
		                                                  <span class="vs-radio--circle"></span>
		                                              </span>
                                                        <span class="">Revendedor</span>
                                                    </div>
                                                </fieldset>
                                            </li>
                                            <li class="d-inline-block mr-2">
                                                <fieldset>
                                                    <div class="vs-radio-con vs-radio-success">
                                                        <input type="radio" class="check" id="radio2" name="tipo" value="vpn" checked data-radio="iradio_flat-red">
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

                                <div class="col-sm-12 col-12	text-center">
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

<script type="text/javascript">
$('.descricao').tooltipsy({
    offset: [0, 10],
    css: {
        'padding': '10px',
        'max-width': '200px',
        'color': '#303030',
        'background-color': '#f5f5b5',
        'border': '1px solid #deca7e',
        '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
        '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
        'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
        'text-shadow': 'none'
    }
});
</script>
			</div>
