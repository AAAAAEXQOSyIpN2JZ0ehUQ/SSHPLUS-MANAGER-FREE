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
                <h1 class="card-title font-medium-2"><i class="fad fa-rocket text-success font-large-1"></i> Contas SSH Online</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Usuários SSH conectados no momento!</p>
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
                            <th>SERVIDOR</th>
                            <th>IP SSH</th>
                            <th>LOGIN</th>
                            <th>VALIDADE</th>
                            <th>TEMPO</th>
                            <th>STATUS</th>
                            <th>CONEXAO</th>
                            <th>LIMITE</th>
                            <th>DONO</th>
                            <th>OPCOES</th>
                        </tr>
                        </thead>
                        <tbody id="myTable">
                        <?php

                        $SQLSub = "SELECT * FROM usuario where id_usuario= '".$_SESSION['usuarioID']."'";
                        $SQLSub = $conn->prepare($SQLSub);
                        $SQLSub->execute();



                        if(($SQLSub->rowCount()) > 0){
                            while($rowSub = $SQLSub->fetch()) {
                                $SQLSubSSH = "SELECT * FROM usuario_ssh, servidor  where usuario_ssh.id_servidor = servidor.id_servidor and usuario_ssh.id_usuario = '".$_SESSION['usuarioID']."'";
                                $SQLSubSSH = $conn->prepare($SQLSubSSH);
                                $SQLSubSSH->execute();


                                if(($SQLSubSSH->rowCount()) > 0){
                                    while($row = $SQLSubSSH->fetch()){
                                        $status="";
                                        if($row['status']== 1){
                                            $status="Ativo";
                                        }else{
                                            $status="Desativado";
                                        }
                                        if($row['online'] != 0){
                                            //Calcula os dias restante
                                            $data_atual = date("Y-m-d ");
                                            $data_validade = $row['data_validade'];
                                            if($data_validade > $data_atual){
                                                $data1 = new DateTime( $data_validade );
                                                $data2 = new DateTime( $data_atual );
                                                $dias_acesso = 0;
                                                $diferenca = $data1->diff( $data2 );
                                                $ano = $diferenca->y * 364 ;
                                                $mes = $diferenca->m * 30;
                                                $dia = $diferenca->d;
                                                $dias_acesso = $ano + $mes + $dia;

                                            }else{
                                                $dias_acesso = 0;
                                            }

                                            ?>



                                            <tr>

                                                <td><?php echo $row['nome'];?></td>
                                                <td><?php echo $row['ip_servidor'];?></td>

                                                <td><?php echo $row['login'];?></td>

                                                <td>

                                               <span class="pull-left-container" style="margin-right: 5px;">
                                                  <span class="label label-primary pull-left">
                                                   <?php echo $dias_acesso."  dias   "; ?>
                                                 </span>
                                               </span>

                                                <td><?php echo tempo_corrido($row['online_start']);?> </td>
                                                <td><div class="badge badge-pill badge-glow badge-success">Online</div></td>
                                                <td><?php echo $row['online'];?></td>
                                                <td><?php echo $row['acesso'];?></td>
                                                <td>Sistema</td>
                                                <td>
                                                    <a href="home.php?page=ssh/editar&id_ssh=<?php echo $row['id_usuario_ssh'];?>" class="btn-sm btn-primary"><i class="fad fa-eye"></i></a>
                                                </td>
                                            </tr>
                                            <?php
                                        }

                                    }

                                }

                            }
                        }



                        if($usuario['tipo']=="revenda"){



                            $SQLSub = "SELECT * FROM usuario where id_mestre= '".$_SESSION['usuarioID']."' and subrevenda='nao'";
                            $SQLSub = $conn->prepare($SQLSub);
                            $SQLSub->execute();


                            if(($SQLSub->rowCount()) > 0){
                                while($rowSub = $SQLSub->fetch()) {
                                    $SQLSSH = "SELECT * FROM usuario_ssh, servidor  where usuario_ssh.id_servidor = servidor.id_servidor and usuario_ssh.id_usuario = '".$rowSub['id_usuario']."'";
                                    $SQLSSH = $conn->prepare($SQLSSH);
                                    $SQLSSH->execute();


                                    if(($SQLSSH->rowCount()) > 0){
                                        while($row = $SQLSSH->fetch()){
                                            $status="";
                                            if($row['status']== 1){
                                                $status="Ativo";
                                            }else{
                                                $status="Desativado";
                                            }
                                            if($row['online'] != 0){


                                                ?>
                                                <tr>

                                                    <td><?php echo $row['nome'];?></td>
                                                    <td><?php echo $row['ip_servidor'];?></td>
                                                    <td><?php echo $row['login'];?></td>
                                                    <td>

                                                   <span class="pull-left-container" style="margin-right: 5px;">
                                                      <span class="label label-primary pull-left">
                                                       <?php echo $dias_acesso."  dias   "; ?>
                                                     </span>
                                                   </span>

                                                    <td><?php echo tempo_corrido($row['online_start']);?> </td>
                                                    <td><div class="badge badge-pill badge-glow badge-success">Online</div></td>
                                                    <td><?php echo $row['online'];?></td>
                                                    <td><?php echo $row['acesso'];?></td>
                                                    <td><?php echo $rowSub['login'];?></td>

                                                    <td>
                                                        <a href="home.php?page=ssh/editar&id_ssh=<?php echo $row['id_usuario_ssh'];?>" class="btn-sm btn-primary"><i class="fad fa-eye"></i></a>
                                                    </td>
                                                </tr>
                                                <?php
                                            }

                                        }

                                    }

                                }
                            }




                        }



                        ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
