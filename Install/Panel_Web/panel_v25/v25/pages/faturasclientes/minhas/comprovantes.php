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
                <h1 class="card-title font-medium-2"><i class="fad fa-globe-americas text-success font-large-1"></i> Comprovantes</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Verifique os comprovantes dos clientes</p>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="MeuServidor" data-search="minhaPesquisa-lista">
                        <thead>
                        <tr>
                            <th>Fatura</th>
                            <th>Cliente</th>
                            <th>Status</th>
                            <th>Data</th>
                            <th>Forma</th>
                            <th>Nota</th>
                            <th>Img</th>
                            <th>Informações</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php




                        $SQLUPUser= "SELECT * FROM  fatura_comprovantes where status='aberto' ORDER BY id desc ";
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
                                    <td><a href="../../../painelssh/admin/pages/faturas/comprovantes/<?php echo $row['imagem'];?>" target="_blank" class="btn btn-block btn-success">Ver</a></td>


                                    <td>

                                        <a href="home.php?page=faturas/verfatura&id=<?php echo $row['fatura_id'];?>" class="btn btn-block btn-success">Visualizar</a>



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
