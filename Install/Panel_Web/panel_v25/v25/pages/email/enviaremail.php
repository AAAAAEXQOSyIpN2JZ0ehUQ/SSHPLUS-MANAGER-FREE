<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

$buscasmtp = "SELECT * FROM smtp_usuarios WHERE usuario_id='".$_SESSION['usuarioID']."'";
$buscasmtp = $conn->prepare($buscasmtp);
$buscasmtp->execute();
$smtp = $buscasmtp->fetch();

$conta=$buscasmtp->rowCount();

if($smtp['empresa']==''){
$empresa='Sem Nome';
}else{
$empresa=$smtp['empresa'];
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
                    <h1 class="card-title font-medium-2"><i class="fad fa-envelope text-success font-large-1"></i> Enviar Email</h1>
                </div>
                <div class="card-content">
                    <form action="pages/email/enviandoemail.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p> Enviar email para seu clientes não esqueça de configurar antes.</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Tipo de Contato ao Cliente
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control" name="tipomodelo">
                                            <option value="1">Suporte Tecnico</option>
                                            <option value="2">Entrega de Contas</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Tipo de Conta
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control" name="tipoconta">
                                            <option value="1" selected=selected>Conta SSH</option>
                                            <option value="2">Acesso Painel</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Email do Destinatario
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input required="required" type="text" class="form-control" name="email" placeholder="Ex:o.juniordesouza@gmail.com">
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Sua Empresa
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="text" class="form-control" id="emp" name="emp" value="<?php echo $empresa;?>" disabled>
                                        <div class="form-control-position">
                                            <i class="fad fa-globe-americas"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Senha
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input class="form-control" id="senha" name="senha" placeholder="Digite a Senha">
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Link de Acesso (<small>ou ip conexão</small>)
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input class="form-control" id="link" name="link" placeholder="Ip ou endereço">
                                        <div class="form-control-position">
                                            <i class="fad fa-flame"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Assunto
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" class="form-control" id="assunto" name="assunto" placeholder="Digite um Assunto EX: Compra de SSH" value="Sua nova conta SSH está pronta">
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Validade
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="text" class="form-control" id="validade" name="validade" placeholder="30" value="30">
                                        <div class="form-control-position">
                                            <i class="fad fa-calendar-week"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-12 text-center">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Mensagem
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <textarea class="form-control" name="msg" id="msg" rows="5" placeholder="Digite a Mensagem ..."></textarea>
                                        <div class="form-control-position">
                                            <i class="fad fa-flame"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-12 text-center">
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <?php if($conta>0){ ?>
                                            <button href="home.php?page=email/1etapasmtp" class="btn btn-info waves-effect waves-light m-t-10">Reconfigurar SMTP</button>
                                        <?php } ?>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12 text-center">
                                    <button type="submit" class="btn btn-success round">Salvar</button>
                                    <button type="reset" class="btn btn-danger round">Limpar</button>
                                    <a href="home.php?page=email/1etapasmtp" class="btn btn-warning round"> Configurar SMTP</a>
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
