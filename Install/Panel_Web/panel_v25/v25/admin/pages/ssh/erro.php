<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__)) {
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
                <h1 class="card-title font-medium-2"><i class="fad fa-trash text-danger font-large-1"></i> Contas SSH com erro</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <div class="col-12"><br>
                        <div class="form-responsive">
                            <input type="text" id="myInput" placeholder="Pesquisar..." class="form-control">
                            <br>
                            <!-- <center><a href="" class="btn btn-danger btn-sm" value="excluiErros">Excluir contas com erro</a></center> -->
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0 js-sort-table" id="MeuServidor" data-search="minhaPesquisa-lista">
                        <thead>
                            <tr>
                                <th>Servidor</th>
                                <th>IP SSH</th>
                                <th>Problema</th>
                                <th>Login</th>
                                <th>Validade</th>
                                <th>Owner</th>
                                <th>Informações</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <?php
                            //lista
                            $SQLSSH = "SELECT * FROM usuario_ssh , servidor  where usuario_ssh.id_servidor = servidor.id_servidor and usuario_ssh.status > '2'";
                            $SQLSSH = $conn->prepare($SQLSSH);
                            $SQLSSH->execute();


                            // output data of each row
                            if (($SQLSSH->rowCount()) > 0) {

                                while ($row = $SQLSSH->fetch()) {
                                    $class = "class='btn-sm btn-danger'";
                                    $status = "";
                                    $erro = "";
                                    $owner = "";
                                    $color = "";


                                    if ($row['status'] == 1) {
                                        $status = "Ativo";
                                        $class = "class='btn-sm btn-primary'";
                                    } else if ($row['status'] == 2) {
                                        $status = "Suspenso";
                                        $color = "bgcolor=''";
                                    }
                                    if ($row['status'] == 3) {
                                        $erro = "Erro no id";
                                    }
                                    if ($row['apagar'] == 5) {
                                        $erro = "Erro ao deletar";
                                    }
                                    if ($row['id_usuario'] == 0) {
                                        $owner = "Sistema";
                                    } else {

                                        $SQLRevendedor = "select * from usuario WHERE id_usuario = '" . $row['id_usuario'] . "'";
                                        $SQLRevendedor = $conn->prepare($SQLRevendedor);
                                        $SQLRevendedor->execute();
                                        $revendedor = $SQLRevendedor->fetch();

                                        $owner = $revendedor['login'];
                                    }
                                    //Calcula os dias restante
                                    $data_atual = date("Y-m-d ");
                                    $data_validade = $row['data_validade'];
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


                                    ?>

                                    <tr <?php echo $color; ?>>

                                        <td><?php echo $row['nome']; ?></td>
                                        <td><?php echo $row['ip_servidor']; ?></td>
                                        <td> <?php echo $erro; ?></td>
                                        <td><?php echo $row['login']; ?></td>

                                        <td>
                                            <span class="pull-left-container" style="margin-right: 3px;">
                                                <span class="label label-primary pull-left">
                                                    <?php echo $dias_acesso . "  dias   "; ?>
                                                </span>
                                            </span>

                                            <?php echo date('d/m/Y', strtotime($row['data_validade'])); ?>


                                        </td>
                                        <td><?php echo $owner; ?></td>

                                        <td>


                                            <a href="home.php?page=ssh/editar&id_ssh=<?php echo $row['id_usuario_ssh']; ?>" <?php echo $class; ?>>Visualizar</a>



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