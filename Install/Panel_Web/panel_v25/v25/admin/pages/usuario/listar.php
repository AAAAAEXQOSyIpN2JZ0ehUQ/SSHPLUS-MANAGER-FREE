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
                <h1 class="card-title font-medium-2"><i class="fad fa-users text-success font-large-1"></i>Usuariios e Revendedores</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Todos os Clintes listado abaixo.</p>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="MeuServidor" data-search="minhaPesquisa-lista">
                        <thead>
                        <tr>
                            <th>STATUS</th>
                            <th>NOME</th>
                            <th>LOGIN</th>
                            <th>TIPO</th>
                            <th>CONTAS SSH</th>
                            <th>ACESSOS SSH</th>
                            <th>DONO</th>
                            <th>OPCOES</th>
                        </tr>
                        </thead>
                        <tbody id="myTable">
                        <?php

                        $SQLUsuario = "select * from usuario ORDER BY ativo";
                        $SQLUsuario = $conn->prepare($SQLUsuario);
                        $SQLUsuario->execute();



                        // output data of each row
                        if (($SQLUsuario->rowCount()) > 0) {

                            while($row = $SQLUsuario->fetch())


                            {
                                $status="";
                                $tipo="";
                                $owner = "";
                                $contas = 0;
                                $color = "";

                                if($row['ativo']== 1){
                                    $status="Ativo";
                                }else{
                                    $status="Desativado";
                                }


                                $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."'  ";
                                $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                $SQLContasSSH->execute();
                                $contas += $SQLContasSSH->rowCount();

                                $total_acesso_ssh = 0;
                                $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$row['id_usuario']."' ";
                                $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                $SQLAcessoSSH->execute();
                                $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                $total_acesso_ssh += $SQLAcessoSSH['quantidade'];


                                if($row['ativo']!= 1){
                                    $color = "bgcolor='#FF6347'";
                                }
                                if($row['tipo']=="vpn"){
                                    $tipo="Usuário SSH";

                                }else{
                                    $tipo="Revendedor";

                                    $SQLSub = "select * from usuario WHERE id_mestre = '".$row['id_usuario']."'  ";
                                    $SQLSub = $conn->prepare($SQLSub);
                                    $SQLSub->execute();
                                    if (($SQLSub->rowCount()) > 0) {

                                        while($rowS = $SQLSub->fetch()) {


                                            $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$rowS['id_usuario']."'  ";
                                            $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                            $SQLContasSSH->execute();
                                            $contas += $SQLContasSSH->rowCount();

                                            $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$rowS['id_usuario']."' ";
                                            $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                            $SQLAcessoSSH->execute();
                                            $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                            $total_acesso_ssh += $SQLAcessoSSH['quantidade'];

                                        }
                                    }


                                }

                                if($row['id_mestre'] == 0){
                                    $owner = "Sistema";
                                }else{

                                    $SQLRevendedor = "select * from usuario WHERE id_usuario = '".$row['id_mestre']."'  ";
                                    $SQLRevendedor = $conn->prepare($SQLRevendedor);
                                    $SQLRevendedor->execute();
                                    $revendedor =  $SQLRevendedor->fetch();
                                    $owner = $revendedor['login'];

                                }


                                ?>

                                <tr <?php echo $color; ?> >
                                    <td><?php echo $status;?></td>
                                    <td><?php echo $row['nome'];?></td>

                                    <td><?php echo $row['login'];?></td>


                                    <td><?php echo $tipo;?></td>
                                    <td><?php echo $contas;?></td>
                                    <td><?php echo $total_acesso_ssh;?></td>

                                    <td><?php echo $owner;?></td>

                                    <td>


                                        <a href="home.php?page=usuario/perfil&id_usuario=<?php echo $row['id_usuario'];?>" class="btn btn-primary">Visualizar</a>


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
