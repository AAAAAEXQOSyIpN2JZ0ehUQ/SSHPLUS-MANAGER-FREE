<?php

    if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
<!-- Input with Icons start -->
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-user text-info font-large-1"></i> Criar conta SSH</h1>
                </div>
                <div class="card-content">
                    <form data-toggle="validator" action="../pages/system/conta.ssh.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Preencha todos os dados !</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione um Servidor
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control custom-select" style="width: 100%;"  name="servidor" id="servidor">
                                            <option selected="selected">Selecione</option>
                                            <?php
                                            $SQLAcesso= "select * from servidor  ";
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
                                                    $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row_srv['id_servidor']."'  ";
                                                    $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                                    $SQLContasSSH->execute();
                                                    $SQLContasSSH = $SQLContasSSH->fetch();
                                                    $contas_ssh_criadas += $SQLContasSSH['quantidade'];
                                                    ?>
                                                    <option value="<?php echo $row_srv['id_servidor'];?>" > <?php echo $servidor['nome'];?> - <?php echo $servidor['ip_servidor'];?> -  <?php echo $contas_ssh_criadas;?>  Conexões </option>
                                                <?php }
                                            }
                                            ?>
                                        </select>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Usuário Gerenciador
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control custom-select" style="width: 100%;"  name="usuario" id="usuario">
                                            <?php
                                            $SQL = "SELECT * FROM usuario where id_mestre=0";
                                            $SQL = $conn->prepare($SQL);
                                            $SQL->execute();
                                            if (($SQL->rowCount()) > 0) {
                                                // output data of each row
                                                while($row = $SQL->fetch()) {?>
                                                    <option value="<?php echo $row['id_usuario'];?>" ><?php echo $row['login'];?></option>
                                                <?php }
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
                                        <input type="number" name="dias" id="dias" class="form-control" placeholder="30" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-calendar-week"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Quantidade de Acesso
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="number" name="acessos" id="acessos" placeholder="1" class="form-control" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-flame"></i>                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Usuário
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input type="text" name="login_ssh" id="login_ssh" class="form-control" minlength="4" maxlength="20" placeholder="Digite o Login..." required="">
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Senha
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input type="password" min="4" max="32" class="form-control"  name="senha_ssh" data-minlength="4" id="senha_ssh" placeholder="Digite a Senha" required="">
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <input  type="hidden" class="form-control" id="diretorio" name="diretorio"  value="../../admin/home.php?page=ssh/adicionar">
                                <input  type="hidden" class="form-control" id="owner" name="owner"  value="<?php echo $accessKEY;?>">
                                <div class="col-sm-12 col-12	text-center">
                                    <button type="submit" class="btn btn-success round">Criar</button>
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
