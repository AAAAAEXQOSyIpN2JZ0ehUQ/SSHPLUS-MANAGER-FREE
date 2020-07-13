<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-dollar text-success font-large-1"></i> Fatura N°<small>#<?php echo $fatu['id']; ?></h1>
                </div>
                <div class="card-content">
                    <form role="form" action="pages/faturas/confirmando.php" enctype="multipart/form-data" method="post">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Nota: Anexe uma Print do Comprovante para agilizar o processo que pode levar até 24 horas para ser efetuado e você ver refletido em sua conta.</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Fatura
                                    </div>
                                    <fieldset class="form-group position-relativet">
                                        <input type="text" class="form-control" placeholder="#<?php echo $fatu['id'];?>" value="#<?php echo $fatu['id'];?>" disabled="">
                                        <input name="fatura" value="<?php echo $fatu['id'];?>" type="hidden">
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Forma de Pagamento
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select name="formap" class="form-control">
                                            <option value="1" selected=selected>Boleto</option>
                                            <option value="2">Depósito/Transfência</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Deixar um comentario
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <textarea class="form-control" name="msg" id="msg" class="form-control" rows="5" placeholder="Digite ... (Opcional)"></textarea>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Anexo de comprovante
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <div class="fileinput fileinput-new input-group" data-provides="fileinput">
                                            <div class="form-control" data-trigger="fileinput"> <i class="glyphicon glyphicon-file fileinput-exists"></i> <span class="fileinput-filename"></span></div>
                                            <span class="input-group-addon btn btn-default btn-file"> <span class="fileinput-new">SELECIONAR</span> <span class="fileinput-exists">MUDAR</span>
                                            <input type="file" id="arquivo" name="arquivo" required=required> </span> <a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">Remover</a>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Enviar</button>
                                    <button type="button" onclick="window.location.href='home.php?page=faturas/verfatura&id=<?php echo $fatu['id'];?>'"  class="btn btn-info waves-effect waves-light m-t-10"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i> Voltar</button>
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
