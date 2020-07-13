<?php
if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

if(isset($_GET['id'])){

    $fatura_id=$_GET['id'];


    $SQLUPUser= "SELECT * FROM fatura where id='".$fatura_id."'";
    $SQLUPUser = $conn->prepare($SQLUPUser);
    $SQLUPUser->execute();

    $conta=$SQLUPUser->rowCount();
    if($conta==0){
        echo '<script type="text/javascript">';
        echo 	'alert("Fatura não encontrada!");';
        echo	'window.location="home.php?page=faturas/abertas";';
        echo '</script>';
        exit;

    }
    $fatu=$SQLUPUser->fetch();

    if($fatu['usuario_id']<>$_SESSION['usuarioID']){
        echo '<script type="text/javascript">';
        echo 	'alert("Esta fatura não é sua!");';
        echo	'window.location="home.php?page=faturas/abertas";';
        echo '</script>';
        exit;
    }
    if($fatu['status']=='cancelado'){
        echo '<script type="text/javascript">';
        echo 	'alert("Esta fatura está vencida ou expirada!");';
        echo	'window.location="home.php?page=faturas/canceladas";';
        echo '</script>';
        exit;
    }
    if($fatu['status']=='pago'){
        echo '<script type="text/javascript">';
        echo 	'alert("Esta fatura está paga!");';
        echo	'window.location="home.php?page=faturas/pagas";';
        echo '</script>';
        exit;

    }





}

?>
<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-globe-americas text-success font-large-1"></i> Fatura N°<small>#<?php echo $fatu['id']; ?></small></h1>
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
                                    <fieldset class="form-group position-relative">
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
                                        <div class="form-control-position">
                                            <i class="feather icon-file"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Deixar uma descrição
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <textarea class="form-control" name="msg" id="msg" class="form-control" rows="5" placeholder="Digite ... (Opcional)"></textarea>
                                        <div class="form-control-position">
                                            <i class="feather icon-phone"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Comprovante
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="file" id="arquivo" name="arquivo" required=required>
                                        <div class="form-control-position">
                                            <i class="feather icon-file"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Salvar</button>
                                    <button type="button" onclick="window.location.href='home.php?page=faturas/verfatura&id=<?php echo $fatu['id'];?>'"  class="btn btn-warning waves-effect waves-light m-t-10"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i> Voltar</button>
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
