<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-server text-success font-large-1"></i> Adicionar Servidor ao Cliente</h1>
                </div>
                <div class="card-content">
                    <form action="pages/usuario/addservidor_exe.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Logo Abaixo vc pode adicionar um servidor para um cliente com validade e limite!</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione um Servidor
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control custom-select" style="width: 100%;"  name="servidor" id="servidor">
                                            <?php


                                            $SQLAcesso= "select * from servidor where tipo='premium'";
                                            $SQLAcesso = $conn->prepare($SQLAcesso);
                                            $SQLAcesso->execute();


                                            if (($SQLAcesso->rowCount()) > 0) {
                                                while($row_srv = $SQLAcesso->fetch()) {



                                                    ?>

                                                    <option value="<?php echo $row_srv['id_servidor'];?>" > <?php echo $row_srv['nome'];?> - <?php echo $row_srv['ip_servidor'];?></option>

                                                <?php }
                                            }else{ ?>
                                                <option>Nenhum Servidor</option>
                                                <?php
                                            }

                                            ?>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Revendedor
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control custom-select" style="width: 100%;"  name="revendedor" id="revendedor">
                                            <?php



                                            $SQL = "SELECT * FROM usuario where tipo='revenda' and subrevenda='nao' and id_mestre=0";
                                            $SQL = $conn->prepare($SQL);
                                            $SQL->execute();



                                            if (($SQL->rowCount()) > 0) {
                                                while($row = $SQL->fetch()) {

                                                    $SQLServidor = "select * from acesso_servidor  WHERE id_usuario = '".$row['id_usuario']."' ";
                                                    $SQLServidor = $conn->prepare($SQLServidor);
                                                    $SQLServidor->execute();
                                                    $acesso_server=$SQLServidor->rowCount();

                                                    ?>

                                                    <option value="<?php echo $row['id_usuario'];?>" ><?php echo $row['login'];?> - Servidores Alocados: <?php echo $acesso_server;?> </option>

                                                <?php }
                                            }else{ ?>
                                                <option>Nenhum Revendedor</option>
                                                <?php
                                            }

                                            ?>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Validade em Dias
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="number" name="dias" id="dias" class="form-control" placeholder="30" value="30" required>
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
                                        <input type="number" name="limite" id="limite" placeholder="30" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="feather icon-file"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Salvar</button>
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
