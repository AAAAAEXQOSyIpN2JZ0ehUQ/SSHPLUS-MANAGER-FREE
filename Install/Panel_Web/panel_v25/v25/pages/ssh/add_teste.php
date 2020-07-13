<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
<script>
    $(document).ready(function ($) {
        //Initialize Select2 Elements
        $(".select2").select2();
    });
</script>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-clock text-info font-large-1"></i> Criar teste SSH</h1>
                </div>
                <div class="card-content">
                    <form data-toggle="validator" action="../pages/system/conta.ssh.php" method="POST" role="form">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Preencha todos os campos</p>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Selecione um Servidor
                                        </div>
                                        <select class="form-control custom-select" style="width: 100%;"  name="acesso_servidor" id="acesso_servidor">
                                            <option selected="selected">selecione</option>
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
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Gerenciador da Conta
                                        </div>
                                        <select class="form-control custom-select" style="width: 100%;"  name="usuario" id="usuario">
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
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Tempo de Duração
                                        </div>
                                        <select class="form-control custom-select" style="width: 100%;" name="tempuser" id="tempuser">
										    <option value="3m">5 Minutos</option>
                                            <option selected="selected" value="30m">30 Minutos</option>
                                            <option value="1h">1 hora <small>(recomendado)</small></option>
                                            <option value="3h">3 horas</option>
                                            <option value="6h">6 horas</option>
                                            <option value="12h">12 horas</option>
                                            <option value="24h">24 horas</option>
                                        </select>
                                        <input type="hidden" name="dias" id="dias" class="form-control" value="1">
                                        <small class="form-control-feedback text-bold-600 font-medium-0 mb-1">O Login sera excluido automaticamente</small>
                                    </div>
                                </div>
                                <input type="hidden" name="acessos" id="acessos" placeholder="1" class="form-control" value="1" >
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Usuario
                                        </div>
                                        <input type="text" name="login_ssh" id="login_ssh" class="form-control" data-minlength="4" data-maxlength="32" placeholder="Digite o Login..." required="">
                                        <small>Mínimo 4 caracteres e no máximo 32!</small>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="text-bold-600 font-medium-2 mb-1">
                                            Senha
                                        </div>
                                        <input type="password" min="4" max="32" class="form-control" name="senha_ssh" data-minlength="4" id="senha_ssh" placeholder="Digite a Senha" required="">
                                        <small>Mínimo 4 caracteres e no máximo 32!</small>
                                    </div>
                                </div>
                            </div>

                            <input  type="hidden" class="form-control" id="diretorio" name="diretorio" value="../../home.php?page=ssh/add_teste">
                            <input  type="hidden" class="form-control" id="owner" name="owner" value="<?php echo $_SESSION['usuarioID'];?>">

                            <div class="col-sm-12 col-12 text-center">
                                <button type="submit" class="btn btn-success round">Criar Teste SSH</button>
                                <button type="reset" class="btn btn-danger round">Limpar</button>
                            </div>
                        </div>
                </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- Input with Icons end -->
