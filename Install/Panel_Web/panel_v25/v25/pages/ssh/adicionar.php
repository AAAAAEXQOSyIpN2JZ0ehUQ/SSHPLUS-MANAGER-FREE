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
                    <h1 class="card-title font-medium-2"><i class="fad fa-terminal text-info font-large-1"></i> Criar Conta SSH</h1>
                </div>
                <div class="card-content">
                    <form data-toggle="validator" action="../pages/system/conta.ssh.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Preencha todos os campos</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Selecione um Servidor
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <select class="form-control custom-select" style="width: 100%;"  name="acesso_servidor" id="acesso_servidor">
                                            <option selected="selected">Selecione um Servidor</option>
                                            <?php
                                            $SQLAcesso= "select * from acesso_servidor WHERE id_usuario = '".$usuario['id_usuario']."' ";
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


                                                    $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row_srv['id_servidor']."' and id_usuario='".$_SESSION['usuarioID']."' ";
                                                    $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                                    $SQLContasSSH->execute();
                                                    $SQLContasSSH = $SQLContasSSH->fetch();
                                                    $contas_ssh_criadas += $SQLContasSSH['quantidade'];

                                                    $SQLSub= "select * from usuario WHERE id_mestre = '".$_SESSION['usuarioID']."' ";
                                                    $SQLSub = $conn->prepare($SQLSub);
                                                    $SQLSub->execute();

                                                    $resta=$row_srv['qtd']-$contas_ssh_criadas;

                                                    ?>
                                                    <option value="<?php echo $row_srv['id_acesso_servidor'];?>"> <?php echo $servidor['nome'];?> [<?php echo $servidor['ip_servidor'];?>]  Resta <?php echo $resta;?> de <?php echo $row_srv['qtd'];?></option>
                                                <?php }
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
                                        Usuário Gerenciador
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <select class="form-control custom-select" name="usuario" id="usuario">
                                            <option selected="selected" value="<?php echo $_SESSION['usuarioID']; ?>">Usuário Atual do Sistema</option>
                                            <?php
                                            $SQL = "SELECT * FROM usuario where id_mestre = '".$_SESSION['usuarioID']."'";
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
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>     
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Usuario
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <input type="text" name="login_ssh" id="login_ssh" class="form-control" data-minlength="4" data-maxlength="32" placeholder="Digite o usuário..." required="">
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Quantidade de Acesso
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <input type="number" name="acessos" id="acessos" placeholder="1" class="form-control" value="1" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-flame"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Senha
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <input type="password" min="4" max="32" class="form-control" name="senha_ssh" data-minlength="4" id="senha_ssh" placeholder="Digite a senha" required="">
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>

                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Validade
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <input type="number" name="dias" id="dias" class="form-control" placeholder="30" value="30" required>
                                        <div class="form-control-position">
                                            <i class="fad fa-calendar-week"></i>
                                        </div>
                                    </fieldset>
                                </div>

                                <input  type="hidden" class="form-control" id="diretorio" name="diretorio" value="../../home.php?page=ssh/adicionar">
                                <input  type="hidden" class="form-control" id="owner" name="owner" value="<?php echo $_SESSION['usuarioID'];?>">

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
