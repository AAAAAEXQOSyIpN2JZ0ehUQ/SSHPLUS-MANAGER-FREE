<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
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
                    <h1 class="card-title font-medium-2"><i class="fad fa-ticket text-danger font-large-1"></i> Chamado Suporte</h1>
                </div>
                <div class="card-content">
                    <form class="" action="index.html" method="post">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Abrir um novo chamado.</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione o servidor
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <select size="1" class="form-control" name="tipo" required>
                                            <option value="1">Problema na SSH</option>
                                            <?php if($usuario['tipo']=='revenda'){?>
                                                <option value="2">Problema na Revenda</option>
                                            <?php } ?>
                                            <option value="3">Problema no Usuário</option>
                                            <option value="4">Problema Em Servidor</option>
                                            <option value="5">Outros/Faturas Problemas</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Login/Servidor/ContaSSH
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <input type="text" class="form-control" name="login" minlength="4" placeholder="Digite o Login ou o Servidor com Problemas" required>
                                        <div class="form-control-position">
                                            <i class="feather icon-file"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Assunto
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" name="motivo" placeholder="Fale qual é o motivo Principal..." minlength="5" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="feather icon-phone"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Informe sua mensagem
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <textarea class="form-control" name="problema" placeholder="Fale mais sobre oquê está acontecento..." rows=5 cols=20 wrap="off" required></textarea>
                                        <input  type="hidden" class="form-control" id="diretorio" name="diretorio"  value="../../admin/home.php?page=ssh/adicionar">
                                        <input  type="hidden" class="form-control" id="owner" name="owner"  value="<?php echo $accessKEY;?>">
                                        <div class="form-control-position">
                                            <i class="feather icon-file"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Criar Chamado</button>
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
