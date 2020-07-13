<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

$buscasmtp = "SELECT * FROM smtp WHERE usuario_id='".$_SESSION['usuarioID']."'";
$buscasmtp = $conn->prepare($buscasmtp);
$buscasmtp->execute();
$smtp = $buscasmtp->fetch();

$conta=$buscasmtp->rowCount();

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
                    <h1 class="card-title font-medium-2"><i class="fad fa-at text-info font-large-1"></i> Enviar email</h1>
                </div>
                <div class="card-content">
                    <form action="pages/email/enviandoemail.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Enviar um email</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Topo de serviço
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control select2 round" name="tipomodelo">
                                            <option value="1">Suporte Tecnico</option>
                                            <option value="2">Entrega de Contas</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                       Tipo de conta
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control select2 round" name="tipoconta">
                                            <option value="1" selected=selected>Conta SSH</option>
                                            <option value="2">Acesso Painel</option>
                                        </select>
                                    </fieldset>
                                </div>

                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Assunto :
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" class="form-control round" id="assunto" name="assunto" value="Acesso de SSH Liberado" placeholder="Digite um Assunto EX: Compra de SSH ">
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Validade :
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="text" class="form-control round" id="validade" name="validade" value="30 Dias" placeholder="Validade 30">
                                        <div class="form-control-position">
                                            <i class="fad fa-calendar-week"></i>
                                        </div>
                                    </fieldset>
                                </div>

                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Login :
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" class="form-control round" id="login" name="login" placeholder="Digite o Login">
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Senha :
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input class="form-control round" id="senha" name="senha" placeholder="Digite a Senha">
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>

                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Email :
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input required="required" type="text" class="form-control round" name="email" placeholder="Digite seu email e Selecione o Servidor ao lado">
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Servidor de email
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <select class="form-control select2 round" name="servidoremail" data-toggle="dropdown" aria-expanded="false">
                                            <option value="1" selected=selected>Eu Decido</a></option>
                                            <option value="2">@Gmail.com</a></option>
                                            <option value="3">@Outlook.com</a></option>
                                            <option value="4">@Hotmail.com</a></option>
                                            <option value="5">@Yahoo.com.br</a></option>
                                        </select>
                                    </fieldset>
                                </div>

                                <div class="col-12 text-center">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Conteudo do Email :
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <textarea class="form-control round" name="msg" id="msg" rows="6" placeholder="Obrigado pela preferencia, prezamos pela qualidade de sua internet..">Obrigado pela preferencia, prezamos pela qualidade de sua internet.</textarea>
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>

                                <div class="col-sm-12 col-12	text-center">
																	<button type="submit" class="btn btn-success round">Enviar</button>
																	<button type="button" class="btn btn-info round"><a class="text-white" href="home.php?page=email/1etapasmtp">1° Configurar SMTP</a></button>
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
