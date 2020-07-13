<!-- Input with Icons start -->
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-server text-warning font-large-1"></i> Adicionar Servidor ao Cliente</h1>
                </div>
                <div class="card-content">
                    <form action="pages/subrevenda/addservidor_exe.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Logo abaixo Você entrega parte de seu limite em um dos seus servidores ao seu Subrevendedor não é possivel entregar mais que o seu limite disponivel.</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione um Servidor
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <select class="form-control" style="width: 100%;"  name="servidor" id="servidor">
                                            <option selected="selected">Selecione um Servidor</option>
                                            <?php

                                            $SQLAcesso= "select * from acesso_servidor where id_usuario='".$usuario['id_usuario']."'  ";
                                            $SQLAcesso = $conn->prepare($SQLAcesso);
                                            $SQLAcesso->execute();


                                            if (($SQLAcesso->rowCount()) > 0) {
                                                // output data of each row
                                                while($row_srv = $SQLAcesso->fetch()) {
                                                    $contas_ssh_criadas = 0;

                                                    $SQLServidor = "select * from servidor WHERE id_servidor = '".$row_srv['id_servidor']."' ";
                                                    $SQLServidor = $conn->prepare($SQLServidor);
                                                    $SQLServidor->execute();
                                                    $servidor = $SQLServidor->fetch();


                                                    //Carrega contas SSH criadas
                                                    $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row_srv['id_servidor']."' and id_usuario='".$usuario['id_usuario']."' ";
                                                    $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                                    $SQLContasSSH->execute();
                                                    $SQLContasSSH = $SQLContasSSH->fetch();
                                                    $contas_ssh_criadas += $SQLContasSSH['quantidade'];

                                                    //Carrega usuario sub
                                                    $SQLUsuarioSub = "SELECT * FROM usuario WHERE id_mestre ='".$usuario['id_usuario']."' and subrevenda='nao'";
                                                    $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
                                                    $SQLUsuarioSub->execute();


                                                    if (($SQLUsuarioSub->rowCount()) > 0) {
                                                        while($row = $SQLUsuarioSub->fetch()) {
                                                            $SQLSubSSH= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$row_srv['id_servidor']."' ";
                                                            $SQLSubSSH = $conn->prepare($SQLSubSSH);
                                                            $SQLSubSSH->execute();
                                                            $SQLSubSSH = $SQLSubSSH->fetch();
                                                            $contas_ssh_criadas += $SQLSubSSH['quantidade'];

                                                        }

                                                    }

                                                    $resta=$row_srv['qtd']-$contas_ssh_criadas;
                                                    //echo $resultado;

                                                    ?>

                                                    <option value="<?php echo $row_srv['id_acesso_servidor'];?>" > <?php echo $servidor['nome'];?> - <?php echo $servidor['ip_servidor'];?> - Limite: <?php echo $resta;?> </option>

                                                <?php }
                                            }else{ ?>
                                                <option value="nada">Nenhum Servidor</option>
                                                <?php
                                            }

                                            ?>
                                        </select>
                                        <div class="form-control-position">
                                            <i class="fad fa-server"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        SubRevendedor
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control" style="width: 100%;"  name="subusuario" id="subusuario">
                                            <option selected="selected">Selecione o SubRevendedor</option>
                                            <?php



                                            $SQL = "SELECT * FROM usuario where id_mestre='".$usuario['id_usuario']."' and subrevenda='sim'";
                                            $SQL = $conn->prepare($SQL);
                                            $SQL->execute();



                                            if (($SQL->rowCount()) > 0) {
                                                // output data of each row
                                                while($row = $SQL->fetch()) {

                                                    $SQLServidor = "select * from acesso_servidor  WHERE id_usuario = '".$row['id_usuario']."' ";
                                                    $SQLServidor = $conn->prepare($SQLServidor);
                                                    $SQLServidor->execute();
                                                    $acesso_server=$SQLServidor->rowCount();

                                                    ?>

                                                    <option value="<?php echo $row['id_usuario'];?>" ><?php echo $row['login'];?> - Servidores Alocados: <?php echo $acesso_server;?> </option>

                                                <?php }
                                            }else{ ?>
                                                <option value="nada">Nenhum Subrevendedor</option>
                                                <?php
                                            }

                                            ?>
                                        </select>
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Validade em Dias
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="number" name="dias" id="dias" class="form-control" placeholder="30" value="30" required="required">
                                        <div class="form-control-position">
                                            <i class="fad fa-calendar-week"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Limite
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="number" name="limite" id="limite" class="form-control" placeholder="30" required="required">
                                        <div class="form-control-position">
                                            <i class="fad fa-flame"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <input  type="hidden" class="form-control" id="diretorio" name="diretorio" value="../../admin/home.php?page=ssh/adicionar">
                                <input  type="hidden" class="form-control" id="owner" name="owner"  value="<?php echo $accessKEY;?>">

                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Adicionar</button>
                                    <button type="reset" class="btn btn-danger round">Limpar</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Input with Icons end -->
