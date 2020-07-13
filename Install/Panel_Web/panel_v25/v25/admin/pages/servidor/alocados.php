<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__)) {
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

// Usados

$qtddoserverusado = 0;

$SQLusuariosdele = "SELECT * FROM acesso_servidor";
$SQLusuariosdele = $conn->prepare($SQLusuariosdele);
$SQLusuariosdele->execute();

if ($SQLusuariosdele->rowCount() > 0) {
    while ($usuariosdele = $SQLusuariosdele->fetch()) {


        $SQLcontaqtdsshusadodele = "SELECT sum(acesso) as acessosdosserversusados2 FROM usuario_ssh where id_usuario = '" . $usuariosdele['id_usuario'] . "'";
        $SQLcontaqtdsshusadodele = $conn->prepare($SQLcontaqtdsshusadodele);
        $SQLcontaqtdsshusadodele->execute();

        $qtdusadosdele = $SQLcontaqtdsshusadodele->fetch();

        $qtddoserverusado += $qtdusadosdele['acessosdosserversusados2'];

        //Select sub deles

        $SQLusuariossubdele = "SELECT * FROM usuario where id_mestre = '" . $usuariosdele['id_usuario'] . "'";
        $SQLusuariossubdele = $conn->prepare($SQLusuariossubdele);
        $SQLusuariossubdele->execute();

        if ($SQLusuariossubdele->rowCount() > 0) {
            while ($usuariossubdele = $SQLusuariossubdele->fetch()) {
                $SQLcontaqtdsshusado = "SELECT sum(acesso) as acessosdosserversusados FROM usuario_ssh where id_usuario = '" . $usuariossubdele['id_usuario'] . "'";
                $SQLcontaqtdsshusado = $conn->prepare($SQLcontaqtdsshusado);
                $SQLcontaqtdsshusado->execute();

                $qtdusados = $SQLcontaqtdsshusado->fetch();

                $qtddoserverusado += $qtdusados['acessosdosserversusados'];
            }
        }
    }
}




// Todos Acessos

$todosacessos = 0;

$SQLqtdserveracessos2 = "SELECT sum(qtd) as tudo FROM  acesso_servidor";
$SQLqtdserveracessos2 = $conn->prepare($SQLqtdserveracessos2);
$SQLqtdserveracessos2->execute();

$totalacessf = $SQLqtdserveracessos2->fetch();

$todosacessos += $totalacessf['tudo'];


//Disponiveis
$disponiveis = $todosacessos - $qtddoserverusado;


//Calculo Porcentagem

$porcent = ($qtddoserverusado / $todosacessos) * 100; // %

$resultado = $porcent;

$valor_porce = round($resultado);





if (($valor_porce >= 70) and ($valor_porce < 90)) {
    $sucessobar = "warning";
    $bgbar = "warning";
} elseif ($valor_porce >= 90) {
    $sucessobar = "danger";
    $bgbar = "danger";
} else {
    $sucessobar = "success";
    $bgbar = "success";
}


?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<section id="column-selectors">
    <div class="row">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-server text-warning font-large-1"></i> Estaticas (Revenda)</h1>
                </div>
                <div class="card-content">
                    <div class="card-body card-dashboard">
                        <div class="table-responsive">
                            <table id="MeuServidor" data-search="minhaPesquisa-lista" class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <th style="width: 50%">Acessos</th>
                                        <th style="width: 50%">Acessos Disponíveis</th>
                                    </tr>
                                    <tr>
                                        <td><?php echo $qtddoserverusado; ?>/<?php echo $todosacessos; ?></td>
                                        <td><?php echo $disponiveis;
                                        $valor_porce = $valor_porce; ?></td>
                                    </tr>
                                    <tr>
                                        <th>Progresso de Uso</th>
                                        <th style="width: 40px">Utilizado (%)</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="progress progress-xl progress-bar-<?php echo $sucessobar; ?>">
                                                <div class="progress-bar progress-bar-<?php echo $sucessobar; ?>" style="width: <?php echo $valor_porce; ?>%"></div>
                                            </div>
                                        </td>
                                        <td><span class="badge badge-<?php echo $bgbar; ?> "><?php echo $valor_porce; ?>%</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="alert alert-info">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"> <span aria-hidden="true">×</span> </button>
  <center><i class="fas fa-info-circle"></i>  Logo Abaixo vc pode editar dias de acesso e limite do seus clientes !</center>
</div>
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
<section id="column-selectors">
    <div class="row">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-server text-warning font-large-1"></i> Listar dos servidores.</h1>
                </div>
                <div class="card-content">
                    <div class="card-body ">
                        <p class="card-text">
                            Relarorio revendedores e subrevendedores
                        </p>
                        <div class="col-12"><br>
                            <div class="form-responsive">
                                <input type="text" id="myInput" placeholder="Pesquisar..." class="form-control">
                            </div>
                        </div>
                        <br>
                        <div class="table-responsive">
                            <table id="MeuServidor" data-search="minhaPesquisa-lista" class="table table-bordered table-striped js-sort-table">
                                <thead>
                                    <tr>
                                        <th>NOME</th>
                                        <th>CLIENTE</th>
                                        <th>USO(%)</th>
                                        <th>ENDERECO IP</th>
                                        <th>SSH CRIADAS</th>
                                        <th>ACESSOS</th>
                                        <th>VALIDADE</th>
                                        <th>LIMITE ACESSOS</th>
                                        <th>INFO / EDITAR</th>
                                    </tr>
                                </thead>
                                <tbody id="myTable">

                                    <?php

                                    $SQLServidorac = "select * from acesso_servidor";
                                    $SQLServidorac = $conn->prepare($SQLServidorac);
                                    $SQLServidorac->execute();

                                    // output data of each row
                                    if (($SQLServidorac->rowCount()) > 0) {

                                        while ($serveacesso = $SQLServidorac->fetch()) {
                                            $Servidor = "select * from servidor where id_servidor='" . $serveacesso['id_servidor'] . "'";
                                            $Servidor = $conn->prepare($Servidor);
                                            $Servidor->execute();
                                            $row = $Servidor->fetch();

                                            $SQLcliennte = "select * from usuario WHERE id_usuario='" . $serveacesso['id_usuario'] . "' ";
                                            $SQLcliennte = $conn->prepare($SQLcliennte);
                                            $SQLcliennte->execute();
                                            $cliente = $SQLcliennte->fetch();

                                            $contas = 0;
                                            $total_acesso_ssh = 0;

                                            $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '" . $serveacesso['id_usuario'] . "' and id_servidor='" . $serveacesso['id_servidor'] . "'";
                                            $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                            $SQLContasSSH->execute();
                                            $contas += $SQLContasSSH->rowCount();


                                            $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='" . $serveacesso['id_usuario'] . "' and id_servidor='" . $serveacesso['id_servidor'] . "'";
                                            $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                            $SQLAcessoSSH->execute();
                                            $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                            $total_acesso_ssh += $SQLAcessoSSH['quantidade'];

                                            $SQLUserSub = "select * from usuario WHERE id_mestre = '" . $serveacesso['id_usuario'] . "' and subrevenda='nao'";
                                            $SQLUserSub = $conn->prepare($SQLUserSub);
                                            $SQLUserSub->execute();

                                            if (($SQLUserSub->rowCount()) > 0) {

                                                while ($rowS = $SQLUserSub->fetch()) {
                                                    $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '" . $rowS['id_usuario'] . "'  and id_servidor='" . $serveacesso['id_servidor'] . "'";
                                                    $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                                    $SQLContasSSH->execute();
                                                    $contas += $SQLContasSSH->rowCount();

                                                    $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='" . $rowS['id_usuario'] . "'  and id_servidor='" . $serveacesso['id_servidor'] . "'";
                                                    $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                                    $SQLAcessoSSH->execute();
                                                    $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                                    $total_acesso_ssh += $SQLAcessoSSH['quantidade'];
                                                }
                                            }

                                            $todosacessos2 = 0;

                                            $SQLqtdserveracessos2 = "SELECT sum(qtd) as todosacessos FROM  acesso_servidor where id_usuario = '" . $serveacesso['id_usuario'] . "' and id_servidor='" . $serveacesso['id_servidor'] . "' ";
                                            $SQLqtdserveracessos2 = $conn->prepare($SQLqtdserveracessos2);
                                            $SQLqtdserveracessos2->execute();

                                            $totalacess2 = $SQLqtdserveracessos2->fetch();

                                            $todosacessos2 += $totalacess2['todosacessos'];

                                            //Calculo Porcentagem

                                            $porcentagem = ($total_acesso_ssh / $todosacessos2) * 100; // %

                                            $resultado2 = $porcentagem;

                                            $valor_porcetage = round($resultado2);

                                            if ($valor_porcetage >= 100) {
                                                $valor_porcetage = 100;
                                            }
                                            if (($valor_porcetage >= 70) and ($valor_porcetage < 90)) {
                                                $sucessobar = "warning";
                                                $bgbar2 = "warning";
                                            } elseif ($valor_porcetage >= 90) {
                                                $sucessobar = "danger";
                                                $bgbar2 = "danger";
                                            } else {
                                                $sucessobar = "success";
                                                $bgbar2 = "success";
                                            }



                                            //Calcula os dias restante
                                            $data_atual = date("Y-m-d");
                                            $data_validade = $serveacesso['validade'];
                                            if ($data_validade > $data_atual) {
                                                $data1 = new DateTime($data_validade);
                                                $data2 = new DateTime($data_atual);
                                                $dias_acesso = 0;
                                                $diferenca = $data1->diff($data2);
                                                $ano = $diferenca->y * 364;
                                                $mes = $diferenca->m * 30;
                                                $dia = $diferenca->d;
                                                $dias_acesso = $ano + $mes + $dia;
                                            } else {
                                                $dias_acesso = 0;
                                            }

                                            $somapode = $serveacesso['qtd'] - $total_acesso_ssh;

                                            ?>
                                            <?php if ($cliente['subrevenda'] == 'nao') { ?>
                                                <div class="modal fade" id="squarespaceModal<?php echo $serveacesso['id_acesso_servidor']; ?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-pencil-square-o"></i> Editar Servidor de Acesso</h3>
                                                            </div>
                                                            <div class="modal-body">

                                                                <!-- content goes here -->
                                                                <form name="editaserver" action="pages/usuario/edita_revenda.php" method="post">
                                                                    <input name="idservidoracesso" type="hidden" value="<?php echo $serveacesso['id_acesso_servidor']; ?>">
                                                                    <div class="form-group">
                                                                        <label for="exampleInputEmail1">Servidor</label>
                                                                        <select size="1" class="form-control" name="fazer" disabled>
                                                                            <option value="<?php echo $row['id_servidor']; ?>" selected=selected> <?php echo $row['nome']; ?> - <?php echo $row['ip_servidor']; ?> - Você Pode Remover: <?php echo $somapode; ?></option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="exampleInputEmail1">Revendedor</label>
                                                                        <input type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $cliente['nome']; ?>" disabled>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label for="exampleInputEmail1">Oquê Vai Fazer?</label>
                                                                        <select size="1" name="addremove" class="form-control">
                                                                            <option value="1" selected=selected>ADD Dias+Acessos</option>
                                                                            <option value="2">Apenas Remover Acessos</option>
                                                                            <option value="3">Apenas Remover Dias</option>
                                                                        </select>
                                                                    </div>


                                                                    <div class="form-group">
                                                                        <label for="exampleInputEmail1">Dias</label>
                                                                        <input type="number" class="form-control" name="dias" value="1">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="exampleInputPassword1">Limite</label>
                                                                        <input type="number" class="form-control" name="limite" value="0">
                                                                    </div>



                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar</button>
                                                                    <button class="btn btn-success">Confirmar</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <?php } ?>

                                    <tr>

                                        <td>
                                            <span class="pull-left-container" style="margin-right: 5px;">
                                                <span class="badge badge-info pull-left">
                                                    <?php echo $row['nome']; ?>
                                                </span>
                                            </span>
                                        </td>
                                        <td><?php echo $cliente['nome']; ?></td>
                                        <td><span class="badge badge-<?php echo $bgbar2; ?>"><?php echo $valor_porcetage; ?>%</span></td>
                                        <td><?php echo $row['ip_servidor']; ?></td>
                                        <td>
                                            <span class="pull-left-container" style="margin-right: 5px;">
                                                <span class="badge badge-danger pull-left">
                                                    <?php echo $contas; ?></td>
                                                </span>
                                            </span>
                                            <td><?php echo $total_acesso_ssh; ?></td>
                                            <td>
                                                <span class="pull-left-container" style="margin-right: 5px;">
                                                    <span class="badge badge-warning pull-left">
                                                        <?php echo $dias_acesso . "  dias   "; ?>
                                                    </span>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="pull-left-container" style="margin-right: 5px;">
                                                    <span class="badge badge-info pull-left">
                                                        <?php echo $serveacesso['qtd']; ?>
                                                    </span>
                                                </span>
                                            </td>

                                            <td>
                                                <div class="btn-group" role="group" aria-label="Basic example">
                                                    <a href="home.php?page=usuario/perfil&id_usuario=<?php echo $serveacesso['id_usuario']; ?>" class="btn-sm btn-primary"><i class="fad fa-eye"></i></a>
                                                    <?php if ($cliente['subrevenda'] == 'nao') { ?>
                                                        <a data-toggle="modal" href="#squarespaceModal<?php echo $serveacesso['id_acesso_servidor']; ?>" class="btn-sm btn-warning label-orange"><i class="fad fa-list-alt"></i></a>
                                                    <?php } ?>
                                                </div>
                                            </td>
                                        </tr>

                                    <?php }
                                }
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>