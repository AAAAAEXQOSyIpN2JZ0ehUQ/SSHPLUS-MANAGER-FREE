<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}
?>
<div class="row" id="table-hover-row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h1 class="card-title font-medium-2"><i class="fad fa-globe-americas text-success font-large-1"></i> Faturas Pagas</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Verifique suas faturas completas</p>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="MeuServidor" data-search="minhaPesquisa-lista">
                        <thead>
                        <tr>
                            <th>ID Fatura</th>
                            <th>Tipo</th>
                            <th>Status</th>
                            <th>Data</th>
                            <th>Vencimento</th>
                            <th>Valor</th>
                            <th>Informações</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php




                        $SQLUPUser= "SELECT * FROM fatura_clientes where usuario_id =  '".$usuario['id_usuario']."' and status='pago' ORDER BY id desc ";
                        $SQLUPUser = $conn->prepare($SQLUPUser);
                        $SQLUPUser->execute();

                        // output data of each row
                        if (($SQLUPUser->rowCount()) > 0) {

                            while($row = $SQLUPUser->fetch())


                            {

                                switch($row['tipo']){
                                    case 'vpn':$tipo='Acesso VPN';break;
                                    case 'revenda':$tipo='Revenda';break;
                                    default:$tipo='Outros';break;
                                }


                                $datacriado=$row['data'];
                                $dataconvcriado = substr($datacriado, 0, 10);
                                $partes = explode("-", $dataconvcriado);
                                $ano = $partes[0];
                                $mes = $partes[1];
                                $dia = $partes[2];

                                $vencimento=$row['datavencimento'];
                                $datavn = substr($vencimento, 0, 10);
                                $partesven = explode("-", $datavn);
                                $anov = $partesven[0];
                                $mesv = $partesven[1];
                                $diav = $partesven[2];

                                $valor=number_format(($row['valor'])*($row['qtd']),2);

                                switch($row['status']){
                                    case 'pendente':$botao='<span class="label label-warning">Pendente</span>';break;
                                    case 'cancelado':$botao='<span class="label label-danger">Cancelado</span>';break;
                                    case 'pago':$botao='<span class="label label-success">Pago</span>';break;
                                    default:$botao='Outros';break;
                                }


                                ?>

                                <tr >
                                    <td >#<?php echo $row['id'];?></td>
                                    <td><?php echo $tipo;?></td>
                                    <td><?php echo $botao;?></td>
                                    <td><?php echo $dia;?>/<?php echo $mes;?> - <?php echo $ano;?></td>
                                    <td><?php echo $diav;?>/<?php echo $mesv;?> - <?php echo $anov;?></td>
                                    <td>R$<?php echo number_format($valor, 2, ',', '.');?></td>


                                    <td>

                                        <a href="home.php?page=faturasclientes/minhas/verfatura&id=<?php echo $row['id'];?>" class="btn btn-block btn-success">Visualizar</a>
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
