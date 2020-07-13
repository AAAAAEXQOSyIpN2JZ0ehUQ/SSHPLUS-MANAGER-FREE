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
                    <h1 class="card-title font-medium-2"><i class="fad fa-bell text-primary font-large-1"></i> Revendedores</h1>
                </div>
                <div class="card-content">
                    <form role="form" name="form" id="form" action="pages/notificacoes/notificar_revendedor.php" method="post">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Sera enviado para revendedores</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione o Revendedor
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control select2" name="revendedor">
                                            <option selected=selected>Selecione</option>
                                            <?php

                                            $SQLUsuario = "SELECT * FROM usuario where tipo='revenda' and subrevenda='nao'";
                                            $SQLUsuario = $conn->prepare($SQLUsuario);
                                            $SQLUsuario->execute();

                                            if (($SQLUsuario->rowCount()) > 0) {
                                                // output data of each row
                                                while($row = $SQLUsuario->fetch()) {
                                                    if($row['id_usuario'] != $usuario_sistema['id_usuario']){

                                                        $SQLserv = "SELECT * FROM acesso_servidor where id_usuario='".$row['id_usuario']."'";
                                                        $SQLserv = $conn->prepare($SQLserv);
                                                        $SQLserv->execute();
                                                        $sv=$SQLserv->rowCount();

                                                        ?>

                                                        <option value="<?php echo $row['id_usuario'];?>" ><?php echo ucfirst($row['nome']);?> - Servidores: <?php echo $sv;?> </option>

                                                    <?php }
                                                }
                                            }
                                            ?>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione o Tipo
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control" name="tipo">
                                            <option selected=selected>Selecione</option>
                                            <option value="1">Fatura</option>
                                            <option value="2">Outros/Servidores</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-12 text-center">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Mensagem
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <textarea class="form-control"  name="msg" rows="5" placeholder="Digite ..."></textarea>
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12 text-center">
                                    <button type="submit" class="btn btn-success round">Notificar</button>
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


<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-bell text-success font-large-1"></i> Cliente VPN</h1>
                </div>
                <div class="card-content">
                    <form role="form" name="form" id="form" action="pages/notificacoes/notificar_clientevpn.php" method="post">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Sera enviado para usuarios VPN</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione o Cliente VPN
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control select2" name="clientevpn">
                                            <option selected=selected>Selecione</option>
                                            <?php

                                            $SQLUsuario = "SELECT * FROM usuario where id_mestre='0' and tipo='vpn'";
                                            $SQLUsuario = $conn->prepare($SQLUsuario);
                                            $SQLUsuario->execute();

                                            if (($SQLUsuario->rowCount()) > 0) {
                                                // output data of each row
                                                while($row = $SQLUsuario->fetch()) {
                                                    if($row['id_usuario'] != $usuario_sistema['id_usuario']){

                                                        $SQLserv = "SELECT * FROM  usuario_ssh where id_usuario='".$row['id_usuario']."'";
                                                        $SQLserv = $conn->prepare($SQLserv);
                                                        $SQLserv->execute();
                                                        $sv=$SQLserv->rowCount();

                                                        ?>

                                                        <option value="<?php echo $row['id_usuario'];?>" ><?php echo ucfirst($row['nome']);?> - Contas SSH: <?php echo $sv;?> </option>

                                                    <?php }
                                                }
                                            }
                                            ?>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione o Tipo
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control" name="tipo">
                                            <option selected=selected>Selecione</option>
                                            <option value="1">Fatura</option>
                                            <option value="2">Outros/Servidores</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-12 text-center">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Mensagem
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <textarea class="form-control"  name="msg" rows="5" placeholder="Digite ..."></textarea>
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Notificar</button>
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


<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-bell text-warning font-large-1"></i> Notificar Geral</h1>
                </div>
                <div class="card-content">
                    <form role="form" name="form" id="form" action="pages/notificacoes/notificar_todos.php" method="post">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Notificar Todos !</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione os Clientes
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control select2" name="clientes">
                                            <option selected=selected>Selecione</option>
                                            <option value="1">Todos</option>
                                            <option value="2">Todos Revendedores</option>
                                            <option value="3">Todos Clientes VPN</option>
                                        </select>

                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione o Tipo
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control" name="tipo">
                                            <option selected=selected>Selecione</option>
                                            <option value="1">Fatura</option>
                                            <option value="2">Outros/Servidores</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-12 text-center">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Mensagem
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <textarea class="form-control"  name="msg" rows="5" placeholder="Digite ..."></textarea>
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12 text-center">
                                    <button type="submit" class="btn btn-success round">Notificar</button>
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
