<script type="text/javascript" src="//resources.mlstatic.com/mptools/render.js"></script>
<?php
require_once("pages/system/seguranca.php");
require_once ('lib/mercadopago.php');

$SQLmp = "select * from mercadopago";
$SQLmp = $conn->prepare($SQLmp);
$SQLmp->execute();
$mp=$SQLmp->fetch();

$mp = new MP ("".$mp['CLIENT_ID']."", "".$mp['CLIENT_SECRET']."");

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

    }
    $fatu=$SQLUPUser->fetch();

    if($fatu['usuario_id']<>$_SESSION['usuarioID']){
        echo '<script type="text/javascript">';
        echo 	'alert("Esta fatura não é sua!");';
        echo	'window.location="home.php?page=faturas/abertas";';
        echo '</script>';

    }
    if($fatu['status']=='cancelado'){
        echo '<script type="text/javascript">';
        echo 	'alert("Esta fatura está vencida ou expirada!");';
        echo	'window.location="home.php?page=faturas/abertas";';
        echo '</script>';

    }
    //Datas

    $datacriado=$fatu['data'];
    $dataconvcriado = substr($datacriado, 0, 10);
    $partes = explode("-", $dataconvcriado);
    $ano = $partes[0];
    $mes = $partes[1];
    $dia = $partes[2];

    $datavenc=$fatu['datavencimento'];
    $datanv = substr($datavenc, 0, 10);
    $partes2 = explode("-", $datanv);
    $anov = $partes2[0];
    $mesv = $partes2[1];
    $diav = $partes2[2];

// Busca usuario
    $user= "SELECT * FROM usuario where id_usuario='".$fatu['usuario_id']."'";
    $user = $conn->prepare($user);
    $user->execute();
    $usufatu=$user->fetch();

// busca servidor

    $server= "SELECT * FROM servidor where id_servidor='".$fatu['servidor_id']."'";
    $server = $conn->prepare($server);
    $server->execute();
    $servidor=$server->fetch();

// busca conta
    if($fatu['tipo']=='vpn'){
        $acc= "SELECT * FROM usuario_ssh where id_usuario_ssh='".$fatu['conta_id']."'";
        $acc = $conn->prepare($acc);
        $acc->execute();
        $conta=$acc->fetch();

    }

//valores
    $desconto1=$fatu['desconto'];
    $desconto=number_format($fatu['desconto'], 2, ',', '.');
    $valor=number_format($fatu['valor'], 2, ',', '.');
    $total=ceil(($fatu['valor']*$fatu['qtd'])-$desconto1);
    $valorfinal=$fatu['valor'];
    $total=number_format($total, 2, ',', '.');


    $total2=$fatu['valor']*$fatu['qtd'];
    $total2=number_format($total2, 2, ',', '.');
// MercadoPago
    $id=$fatu['id'];
    $decricao=$fatu['descricao'];
    $preference_data = array(
        "items" => array(
            array(
                "id" => $id,
                "title" => "Mercado Pago Inc - Pagamentos",
                "currency_id" => "BRL",
                "picture_url" =>"https://www.mercadopago.com/org-img/MP3/home/logomp3.gif",
                "description" => $decricao,
                "unit_price" => intval($valorfinal),
                "category_id" => "Category",
                "quantity" => intval($fatu['qtd']),
            )
        )
    );

    $preference = $mp->create_preference($preference_data);




    switch($fatu['tipo']){
        case 'vpn':$tipo='Acesso VPN';break;
        case 'revenda':$tipo='Revenda';break;
        default:$tipo='Outros';break;
    }


}else{
    echo '<script type="text/javascript">';
    echo 	'alert("Fatura Inexistente!");';
    echo	'window.location="home.php?page=faturas/abertas";';
    echo '</script>';

}


?>
<script>
  $(function () {
  $('#example1').DataTable({
    "language": {
        "sProcessing":    "Processando...",
        "sLengthMenu":    "Mostrar _MENU_ registros",
        "sZeroRecords":   "Não foram encontrados resultados",
        "sEmptyTable":    "Nenhum dado disponivel",
        "sInfo":          "Mostrando de _START_ até _END_ de _TOTAL_ registros",
        "sInfoEmpty":     "Mostrando de 0 até 0 de 0 registos",
        "sInfoFiltered":  "(filtrado de _MAX_ registos no total)",
        "sInfoPostFix":   "",
        "sSearch":        "Procurar:",
        "sUrl":           "",
        "sInfoThousands":  ",",
        "sSearchPlaceholder": "Procure o CP",
        "sLoadingRecords": "A carregar dados...",
        "oPaginate": {
            "sFirst":    "Primeiro",
            "sLast":    "Último",
            "sNext":    "Seguinte",
            "sPrevious": "Anterior"
        },
        "oAria": {
            "sSortAscending":  ": Clique para ordenar ascendente (ASC)",
            "sSortDescending": ": Clique para ordenar descendente (DESC)"
        }
    }
});
  responsive: true
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
                     <h1 class="card-title font-medium-2"><i class="fad fa-globe-americas text-success font-large-1"></i> Fatura N°<small>#<?php echo $fatu['id']; ?></small></h1>
                 </div>
                 <div class="card-content">
                     <form role="form" action="pages/faturas/confirmando.php" enctype="multipart/form-data" method="post">
                         <div class="card-body">
                             <div class="row">
                                 <div class="col-12">
                                     <p>Confirmar seu pagamento.</p>
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
                                     </fieldset>
                                 </div>
                                 <div class="col-sm-6 col-12">
                                     <div class="text-bold-600 font-medium-2 mb-1">
                                         Deixar uma mensagem?
                                     </div>
                                     <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                         <textarea class="form-control" name="msg" id="msg" class="form-control" rows="5" placeholder="Digite ... (Opcional)"></textarea>
                                         <div class="form-control-position">
                                             <i class="fad fa-flame"></i>
                                         </div>
                                     </fieldset>
                                 </div>
                                 <div class="col-sm-6 col-12">
                                     <div class="text-bold-600 font-medium-2 mb-1">
                                         Anexar de comprovante
                                     </div>
                                     <fieldset class="form-group position-relative input-divider-right">
                                         <input type="file" id="arquivo" name="arquivo" required=required> </span> <a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">Remover</a>
                                    </fieldset>
                                </div>
                             <div class="col-sm-12 col-12	text-center">
                                 <button type="submit" class="btn btn-success round">Enviar</button>
                                 <button type="button" onclick="window.location.href='home.php?page=faturas/verfatura&id=<?php echo $fatu['id'];?>'" class="btn btn-danger round">Voltar</button>
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
