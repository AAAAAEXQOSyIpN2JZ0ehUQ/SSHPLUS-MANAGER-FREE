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
                <h1 class="card-title font-medium-2"><i class="fad fa-users text-warning font-large-1"></i> SubRevendedores</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Lista completa dos Sub Revendedores</p>
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
                            <th>STATUS</th>
                            <th>NOME</th>
                            <th>LOGIN</th>
                            <th>SENHA</th>
                            <th>CONTAS SSH</th>
                            <th>ACESSOS SSH</</th>
                            <th>SERVIDORES</th>
                            <th>EDITAR / FUNCÕES</th>
                        </tr>
                        </thead>
                        <tbody id="myTable">
                        <?php


                        $SQLUsuario = "SELECT * FROM usuario   where  tipo = 'revenda' and subrevenda='sim' and id_mestre='".$usuario['id_usuario']."' ORDER BY ativo ";
                        $SQLUsuario = $conn->prepare($SQLUsuario);
                        $SQLUsuario->execute();


                        // output data of each row
                        if (($SQLUsuario->rowCount()) > 0) {

                            while($row = $SQLUsuario->fetch())


                            {
                                $class = "class='btn btn-danger'";
                                $status="";
                                $color = "";
                                $contas = 0;
                                $servidores = 0;
                                if($row['ativo']== 1){
                                    $status="Ativo";
                                    $class = "class='btn-sm btn-primary'";
                                }else{
                                    $status="Desativado";
                                    $color = "bgcolor='#FF6347'";
                                }


                                $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."'";
                                $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                $SQLContasSSH->execute();
                                $contas += $SQLContasSSH->rowCount();

                                $SQLServidores = "select * from acesso_servidor WHERE id_usuario = '".$row['id_usuario']."'";
                                $SQLServidores = $conn->prepare($SQLServidores);
                                $SQLServidores->execute();
                                $servidores += $SQLServidores->rowCount();

                                $total_acesso_ssh = 0;
                                $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$row['id_usuario']."' ";
                                $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                $SQLAcessoSSH->execute();
                                $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                $total_acesso_ssh += $SQLAcessoSSH['quantidade'];


                                $SQLUserSub = "select * from usuario WHERE id_mestre = '".$row['id_usuario']."'";
                                $SQLUserSub = $conn->prepare($SQLUserSub);
                                $SQLUserSub->execute();

                                if (($SQLUserSub->rowCount()) > 0) {

                                    while($rowS = $SQLUserSub->fetch()) {
                                        $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$rowS['id_usuario']."'";
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







                                ?>

                                <div class="modal fade" id="squarespaceModal<?php echo $row['id_usuario'];?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-pencil-square-o"></i> Notificar Usuario</h3>
                                            </div>
                                            <div class="modal-body">

                                                <!-- content goes here -->
                                                <form action="pages/usuario/notifica_sub.php" method="post">
                                                    <input name="idsubrev" type="hidden" value="<?php echo $row['id_usuario'];?>">
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Usuario</label>
                                                        <input type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $row['nome'];?>" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Tipo de Alerta</label>
                                                        <select size="1" name="tipo" class="form-control">
                                                            <option value="1" selected=selected>SUBRevenda</option>
                                                            <option value="2">Outros</option>
                                                        </select>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Mensagem</label>
                                                        <textarea class="form-control" name="msg" rows=5 cols=20 wrap="off" placeholder="Digite..." required></textarea>
                                                    </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-dismiss="modal"  role="button">Cancelar</button>
                                                <button type="button" class="btn btn-success">Confirmar</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal fade" id="criarfatura<?php echo $row['id_usuario'];?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-money"></i> Cria uma Fatura</h3>
                                            </div>
                                            <div class="modal-body">

                                                <!-- content goes here -->
                                                <form name="editaserver" action="pages/subrevenda/criafatura_subrv.php" method="post">
                                                    <input name="idcontausuario" type="hidden" value="<?php echo $row['id_usuario'];?>">
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Usuário</label>
                                                        <input type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $row['nome'];?>" disabled="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Tipo</label>
                                                        <select size="1" name="tipo" class="form-control">
                                                            <option value="3" selected=selected>Revenda</option>
                                                            <option value="2">Outros</option>
                                                        </select>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Valor</label>
                                                        <input type="number" class="form-control" name="valor" value="1">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputPassword1">Desconto</label>
                                                        <input type="number" class="form-control" name="desconto" value="0">
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Prazo</label>
                                                        <input type="number" class="form-control" name="prazo" value="1">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputPassword1">Descrição</label>
                                                        <textarea class="form-control" name="msg" rows="3" cols="20" wrap="off" placeholder="Digite..."></textarea>
                                                    </div>

                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar</button>
                                                <button type="button" class="btn btn-success">Confirmar</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <tr  <?php echo $color; ?> >
                                    <td><?php echo $status;?></td>
                                    <td><?php echo $row['nome'];?></td>

                                    <td><?php echo $row['login'];?></td>
                                    <td><?php echo $row['senha'];?></td>


                                    <td><?php echo $contas;?></td>
                                    <td><?php echo $total_acesso_ssh;?></td>
                                    <td><?php echo $servidores;?></td>


                                    <td>
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                        <a href="home.php?page=usuario/perfil&id_usuario=<?php echo $row['id_usuario'];?>" <?php echo $class;?>><i class="fa fa-eye"></i></a>
                                            <a data-toggle="modal" href="#squarespaceModal<?php echo $row['id_usuario'];?>"  class="btn-sm btn-warning"><i class="fa fa-flag"></i></a>
                                            <a data-toggle="modal" href="#criarfatura<?php echo $row['id_usuario'];?>" class="btn-sm btn-success label-warning"><b>$</b></a>
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
