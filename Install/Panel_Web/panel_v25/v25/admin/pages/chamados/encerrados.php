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
                <h1 class="card-title font-medium-2"><i class="fad fa-user-times text-danger font-large-1"></i>Chamados Encerrados</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Chamados encerrados listado abaixo.</p>
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
                                <th>N° DE CHAMADO </th>
                                <th>STATUS </th>
                                <th>ABERTO POR </th>
                                <th>TIPO </th>
                                <th>LOGIN/SERVIDOR </th>
                                <th>ULTIMA ATUALIZACAO </th>
                                <th>INFORMACOES </th>
                            </tr>
                            </thead>
                            <tbody id="myTable">
                            <?php




                            $SQLUsuario = "SELECT * FROM chamados   where  status = 'encerrado' and id_mestre=0 ORDER BY id desc";
                            $SQLUsuario = $conn->prepare($SQLUsuario);
                            $SQLUsuario->execute();


                            // output data of each row
                            if (($SQLUsuario->rowCount()) > 0) {

                                while($row = $SQLUsuario->fetch())


                                {

                                    $SQLUsuario2 = "SELECT * FROM usuario   where  id_usuario = '".$row['usuario_id']."'";
                                    $SQLUsuario2 = $conn->prepare($SQLUsuario2);
                                    $SQLUsuario2->execute();
                                    $user2 = $SQLUsuario2->fetch();

                                    switch($row['tipo']){
                                        case 'contassh':$tipo='SSH';break;
                                        case 'revendassh':$tipo='REVENDA SSH';break;
                                        case 'usuariossh':$tipo='USUÁRIO SSH';break;
                                        case 'servidor':$tipo='SERVIDOR';break;
                                        case 'outros':$tipo='OUTROS';break;
                                        default:$tipo='Erro';break;
                                    }

                                    $data1=explode(' ',$row['data']);
                                    $data2=explode('-',$data1[0]);
                                    $dia=$data2[2];
                                    $mes=$data2[1];
                                    $ano=$data2[0];


                                    ?>




                                    <div class="modal fade" id="squarespaceModal<?php echo $row['id'];?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-info"></i> Informações do Chamado</h3>
                                                </div>
                                                <div class="modal-body">

                                                    <!-- content goes here -->
                                                    <form action="pages/chamados/deletar_chamado.php" method="post">
                                                        <input name="chamado" type="hidden" value="<?php echo $row['id'];?>">
                                                        <input name="diretorio" type="hidden" value="../../home.php?page=chamados/encerrados">
                                                        <div class="form-group">
                                                            <label for="exampleInputEmail1">Motivo</label>
                                                            <input type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $row['motivo'];?>" disabled>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputEmail1">Mensagem</label>
                                                            <textarea class="form-control" rows=5 cols=20 wrap="off" disabled><?php echo $row['mensagem'];?></textarea>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="exampleInputEmail1">Problema</label>
                                                            <select size="1" class="form-control" disabled>
                                                                <option  selected=selectes><?php echo $tipo;?></option>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputPassword1">Resposta</label>
                                                            <textarea class="form-control" rows=5 cols=20 wrap="off" placeholder="Deixe uma resposta para ele visualizar" required disabled><?php echo $row['resposta'];?></textarea>
                                                        </div>
                                                </div>
                                                </form>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-success" data-dismiss="modal"  role="button">Cancelar</button>
                                                    <button type="button" class="btn btn-danger">Deletar Chamado</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <tr>
                                        <td>#<?php echo $row['id'];?></td>
                                        <td><small class="label label-success"><?php echo ucfirst($row['status']);?></small></td>
                                        <td><a href="home.php?page=usuario/perfil&id_usuario=<?php echo $user2['id_usuario'];?>"><?php echo $user2['nome'];?></a></td>
                                        <td><?php echo $tipo;?></td>
                                        <td><?php echo $row['login'];?></td>
                                        <td><?php echo $dia;?>/<?php echo $mes;?> - <?php echo $ano;?></td>


                                        <td>

                                            <a data-toggle="modal" href="#squarespaceModal<?php echo $row['id'];?>" class="btn-sm btn-primary"><i class="fa fa-eye"></i></a>
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
