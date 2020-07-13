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
                <h1 class="card-title font-medium-2"><i class="fad fa-server text-warning font-large-1"></i> Servidores</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Seus servidores estao listado abaixo.</p>
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
                                <th>NOME</th>
                                <th>TIPO</th>
                                <th>REGIAO</th>
                                <th>ENDERECO IP</th>
                                <th>LOGIN</th>
                                <th>OPENVPN</th>
                                <th>SSH CRIADAS</th>
                                <th>ACESSOS</th>
                                <th>INFORMACOES</th>
                        </thead>
                        <tbody id="myTable">
                            <?php





                            $SQLServidor = "select * from servidor";
                            $SQLServidor = $conn->prepare($SQLServidor);
                            $SQLServidor->execute();

                            // output data of each row
                            if (($SQLServidor->rowCount()) > 0) {

                                while ($row = $SQLServidor->fetch()) {
                                    $acessos = 0;

                                    if ($row['tipo'] == 'premium') {
                                        $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor='" . $row['id_servidor'] . "' ";
                                        $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                        $SQLAcessoSSH->execute();
                                        $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                        $acessos += $SQLAcessoSSH['quantidade'];

                                        $SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '" . $row['id_servidor'] . "' ";
                                        $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                                        $SQLUsuarioSSH->execute();
                                    } else {
                                        $SQLUsuarioSSH = "select * from usuario_ssh_free WHERE servidor = '" . $row['id_servidor'] . "' ";
                                        $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                                        $SQLUsuarioSSH->execute();
                                    }

                                    $qtd_ssh = $SQLUsuarioSSH->rowCount();

                                    switch ($row['tipo']) {
                                        case 'premium':
                                            $tipo = 'Premium';
                                            break;
                                        case 'free':
                                            $tipo = 'Free';
                                            break;
                                        default:
                                            $tipo = 'erro';
                                            break;
                                    }

                                    $SQLopen = "select * from ovpn WHERE servidor_id = '" . $row['id_servidor'] . "' ";
                                    $SQLopen = $conn->prepare($SQLopen);
                                    $SQLopen->execute();
                                    if ($SQLopen->rowCount() > 0) {
                                        $openvpn = $SQLopen->fetch();
                                        $texto = "<a href='../admin/pages/servidor/baixar_ovpn.php?id=" . $openvpn['id'] . "' class=\"label label-info\">Baixar</a>";
                                    } else {
                                        $texto = "<span class=\"label label-danger\">Indisponivel</span>";
                                    }


                                    ?>

                                        <tr>

                                            <td><?php echo $row['nome']; ?></td>
                                            <td><?php echo $tipo; ?></td>
                                            <td><?php echo ucfirst($row['regiao']); ?></td>
                                            <td><?php echo $row['ip_servidor']; ?></td>
                                            <td><?php echo $row['login_server']; ?></td>
                                            <td><?php echo $texto; ?></td>
                                            <td><?php echo $qtd_ssh; ?></td>
                                            <td><?php echo $acessos; ?></td>


                                            <td>


                                                <a href="home.php?page=servidor/servidor&id_servidor=<?php echo $row['id_servidor']; ?>" class="btn-sm btn-primary"> Visualizar</a>
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