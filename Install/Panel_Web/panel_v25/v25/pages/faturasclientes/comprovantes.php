<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}
?>
<script type="text/javascript" src="../../app-assets/plugins/sort-table.js"></script>
<script>
    $(document).ready(function() {
        $("#myInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<div class="row" id="table-hover-row">
    <div class="col-12">
        <div class="card border-info mb-3">
            <div class="card-header">
                <h1 class="card-title font-medium-2"><i class="fad fa-file-invoice text-success font-large-1"></i> Comprovantes</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Seus comprovantes serao listado abaixo.</p>
                    <div class="col-12"><br>
                        <div class="form-responsive">
                            <input type="text" id="myInput" placeholder="Pesquisar..." class="form-control">
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0 js-sort-table" id="MeuServidor" data-search="minhaPesquisa-lista">
                        <thead>
                        <tr>
                            <th>FATURA</th>
                            <th>CLIENTE</th>
                            <th>STATUS</th>
                            <th>DATA</th>
                            <th>FORMA</th>
                            <th>NOTA</th>
                            <th>IMG</th>
                            <th>INFORMACOES</th>
                        </tr>
                        </thead>
                        <tbody id="myTable">
                        <?php

                        $SQLUPUser= "SELECT * FROM  fatura_comprovantes_clientes where status='aberto' and id_mestre='".$_SESSION['usuarioID']."' ORDER BY id desc ";
                        $SQLUPUser = $conn->prepare($SQLUPUser);
                        $SQLUPUser->execute();

                        // output data of each row
                        if (($SQLUPUser->rowCount()) > 0) {

                            while($row = $SQLUPUser->fetch())


                            {

                                switch($row['formapagamento']){
                                    case 'boleto':$tipo='Boleto';break;
                                    case 'deptra':$tipo='CEF-DEP';break;
                                    default:$tipo='Outros';break;
                                }



                                $datacriado=$row['data'];
                                $dataconvcriado = substr($datacriado, 0, 10);
                                $partes = explode("-", $dataconvcriado);
                                $ano = $partes[0];
                                $mes = $partes[1];
                                $dia = $partes[2];




                                switch($row['status']){
                                    case 'aberto':$botao='<span class="label label-warning">Aberto</span>';break;
                                    case 'cancelado':$botao='<span class="label label-danger">Cancelado</span>';break;
                                    case 'pago':$botao='<span class="label label-success">Pago</span>';break;
                                    default:$botao='Outros';break;
                                }


                                $Susuario= "SELECT * FROM usuario where id_usuario='".$row['usuario_id']."'";
                                $Susuario = $conn->prepare($Susuario);
                                $Susuario->execute();
                                $usuario=$Susuario->fetch();

                                ?>

                                <tr >
                                    <td >#<?php echo $row['fatura_id'];?></td>
                                    <td><?php echo $usuario['nome'];?></td>
                                    <td><?php echo $botao;?></td>
                                    <td><?php echo $dia;?>/<?php echo $mes;?> - <?php echo $ano;?></td>
                                    <td><?php echo $tipo;?></td>
                                    <td><?php echo $row['nota'];?></td>
                                    <td><a href="../pages/faturasclientes/minhas/comprovantes/<?php echo $row['imagem'];?>" target="_blank" class="btn btn-block btn-success">Ver</a></td>
                                    <td>
                                        <a href="home.php?page=faturasclientes/verfatura&id=<?php echo $row['fatura_id'];?>" class="btn btn-block btn-success">Visualizar</a>
                                    </td>
                                </tr>
                            <?php } } ?>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
