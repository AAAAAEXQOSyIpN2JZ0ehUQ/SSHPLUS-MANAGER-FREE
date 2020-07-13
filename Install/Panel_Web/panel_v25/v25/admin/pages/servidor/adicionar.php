<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>

<script>
    function ValidateIPaddress(inputText)
    {
        var ipformat = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
        if(inputText.value.match(ipformat))
        {
            document.form1.ip.focus();
            return true;
        }
        else
        {
            alert("Endereço IP Invalido!");
            document.form1.ip.focus();<br>return false;
        }
    }
</script>
<!-- Input with Icons start -->
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-server text-warning font-large-1"></i> Adicionar Servidor ao Painel</h1>
                </div>
                <div class="card-content">
                    <form action="pages/servidor/adicionar_exe.php" method="POST" enctype="multipart/form-data" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Preencer todas informações corretamente!</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Nome para identificacao do servidor
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <input type="text" id="nomesrv" name="nomesrv" class="form-control" minlength="3" placeholder="Ex: Brasil-1" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-server"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Endereço de IP
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <input type="text" name="ip" id="ip" class="form-control" minlength="4" placeholder="Digite o IP" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-server"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Usuário Root
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" name="login" id="login" value="root" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Senha Root
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="password" min="4" max="32" class="form-control"  name="senha" data-minlength="4" id="senha" placeholder="Digite a Senha" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Região Global
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <select class="form-control custom-select" name="regiao" data-placeholder="Selecione a regiao" tabindex="1">
                                            <option value="1">Asia</option>
                                            <option value="2" selected>America</option>
                                            <option value="3">Europa</option>
                                            <option value="4">Australia</option>
                                        </select>
                                        <div class="form-control-position">
                                            <i class="fad fa-mobile-android"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Localização
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <input type="text" name="localiza" id="localiza" placeholder="Ex: São Paulo" value="São Paulo" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-map-marker-alt"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Hostname
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" name="siteserver" id="siteserver" value="www.vip-vps.tk" class="form-control" placeholder="Digite seu endereço do site ou IP" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-heart"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Validade
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="number" name="validade" id="validade" placeholder="Ex: 1000" value="10000" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-calendar-week"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12">
                                    <div class="font-medium-2 mb-1">
                                        <b>Limite</b>
                                    </div>
                                    <fieldset class="form-label-group form-group position-relative has-icon-left input-divider-left">
                                        <input type="number" name="limite" id="limite" placeholder="Ex: 1000" value="10000" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-globe-americas"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12 text-center">
                                    <button type="submit" class="btn btn-success round">Adicionar</button>
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
