<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
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
                <h1 class="card-title font-medium-2"><i class="fad fa-greater-than-equal text-info font-large-1"></i> Contas SSH</h1>
            </div>
            <div class="card-content">
                <div class="card-body">
                    <p>Lista das contas SSH criadas</p>
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
                            <th>SENHA</th>
                            <th>OPENVPN</th>
                            <th>VALIDADE</th>
                            <th>ACESSOS</th>
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
                                $SQLSubSSH = "SELECT * FROM usuario_ssh, servidor  where usuario_ssh.id_servidor = servidor.id_servidor and usuario_ssh.id_usuario = '".$_SESSION['usuarioID']."' ORDER BY status";
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

                                        $color = "";
                                        if($row['status']== 2){

                                            $color = "bgcolor='#FF6347'";
                                        }
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


                                        $pegando = "SELECT * FROM usuario_ssh  where id_usuario_ssh='".$row['id_usuario_ssh']."'";
                                        $pegando = $conn->prepare($pegando);
                                        $pegando ->execute();
                                        $pegasenha = $pegando->fetch();

                                        $SQLopen = "select * from ovpn WHERE servidor_id = '".$row['id_servidor']."' ";
                                        $SQLopen = $conn->prepare($SQLopen);
                                        $SQLopen->execute();
                                        if($SQLopen->rowCount()>0){
                                            $openvpn=$SQLopen->fetch();
                                            $texto="<a href='../pages/servidor/baixar_ovpn.php?id=".$openvpn['id']."' class=\"label label-info\">Baixar</a>";
                                        }else{
                                            $texto="<span class=\"label label-danger\">Indisponivel</span>";
                                        }


                                        ?>
                                        <tr <?php echo $color; ?>>

                                            <td><?php echo $row['nome'];?></td>
                                            <td><?php echo $row['ip_servidor'];?></td>
                                            <td><?php echo $row['login'];?></td>
                                            <td><?php echo $pegasenha['senha'];?></td>
                                            <td><?php echo $texto;?></td>
                                            <td>
                                              <span class="pull-left-container" style="margin-right: 5px;">
                                                <span class="label label-primary pull-left">
                                                 <?php echo $dias_acesso."  dias   "; ?>
                                               </span>
                                             </span>
                                            </td>
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
                                            $color = "";
                                            if($row['status']== 2){

                                                $color = "bgcolor='#FF6347'";
                                            }

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

                                            $pegando2 = "SELECT * FROM usuario_ssh  where id_usuario_ssh='".$row['id_usuario_ssh']."'";
                                            $pegando2 = $conn->prepare($pegando2);
                                            $pegando2 ->execute();
                                            $pegasenha2 = $pegando->fetch();

                                            $SQLopen = "select * from ovpn WHERE servidor_id = '".$row['id_servidor']."' ";
                                            $SQLopen = $conn->prepare($SQLopen);
                                            $SQLopen->execute();
                                            if($SQLopen->rowCount()>0){
                                                $openvpn=$SQLopen->fetch();
                                                $texto="<a href='../pages/servidor/baixar_ovpn.php?id=".$openvpn['id']."' class=\"label label-info\">Baixar</a>";
                                            }else{
                                                $texto="<span class=\"label label-danger\">Indisponivel</span>";
                                            }

                                            ?>
                                            <div class="modal fade" id="criarfatura<?php echo $row['id_usuario_ssh'];?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-money"></i> Cria uma Fatura</h3>
                                                        </div>
                                                        <div class="modal-body">

                                                            <!-- content goes here -->
                                                            <form name="editaserver" action="pages/ssh/criafatura_ssh.php" method="post">
                                                                <input name="idcontausuario" type="hidden" value="<?php echo $row['id_usuario'];?>">
                                                                <input name="contassh" type="hidden" value="<?php echo $row['id_usuario_ssh'];?>">
                                                                <div class="form-group">
                                                                    <label for="exampleInputEmail1">Conta SSH</label>
                                                                    <input type="text" class="form-control" value="<?php echo $row['login'];?>" disabled="">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="exampleInputEmail1">Cliente</label>
                                                                    <input type="text" class="form-control" disabled value="<?php echo $rowSub['login'];?>">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="exampleInputEmail1">Tipo</label>
                                                                    <select size="1" class="form-control" disabled>
                                                                        <option value="1" selected=selected>Acesso VPN</option>
                                                                    </select>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label for="exampleInputEmail1">Valor</label>
                                                                    <input type="number" class="form-control" name="valor" value="15">
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
                                                            <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar </button>
                                                            <button type="button" class="btn btn-success">Confirmar</button>
                                                        </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <tr <?php echo $color; ?>>
                                                <td><?php echo $row['nome'];?></td>
                                                <td><?php echo $row['ip_servidor'];?></td>
                                                <td><?php echo $row['login'];?></td>
                                                <td><?php echo $pegasenha2['senha'];?></td>
                                                <td><?php echo $texto;?></td>
                                                <td>
                                                  <span class="pull-left-container" style="margin-right: 5px;">
                                                    <span class="label label-primary pull-left">
                                                     <?php echo $dias_acesso."  dias   "; ?>
                                                   </span>
                                                 </span>
                                                </td>
                                                <td><?php echo $row['acesso'];?></td>
                                                <td><?php echo $rowSub['login'];?></td>

                                                <td>
                                                    <a href="home.php?page=ssh/editar&id_ssh=<?php echo $row['id_usuario_ssh'];?>" class="btn-sm btn-primary"><i class="fad fa-eye"></i></a>
                                                    <a data-toggle="modal" href="#criarfatura<?php echo $row['id_usuario_ssh'];?>" class="btn-sm btn-success label-orange"><i class="fad fa-usd"></i></a>
                                                </td>
                                            </tr>
                                            <?php
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
