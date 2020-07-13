<?php


if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__)) {
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

if (isset($_GET["id_servidor"])) {
    $SQLServidor = "select * from servidor WHERE id_servidor = '" . $_GET['id_servidor'] . "' ";
    $SQLServidor = $conn->prepare($SQLServidor);
    $SQLServidor->execute();
    $servidor = $SQLServidor->fetch();
    if (($SQLServidor->rowCount()) == 0) {
        echo '<script type="text/javascript">';
        echo     'alert("Nao encontrado!");';
        echo    'window.location="home.php?page=servidor/listar";';
        echo '</script>';
        exit;
    }
} else {
    echo '<script type="text/javascript">';
    echo     'alert("Preencha todos os campos!");';
    echo    'window.location="home.php?page=servidor/listar";';
    echo '</script>';
    exit;
}


//Realiza a comunicacao com o servidor
$ip_servidor = $servidor['ip_servidor'];
$loginSSH = $servidor['login_server'];
$senhaSSH =  $servidor['senha'];
$ssh = new SSH2($ip_servidor);



//Verifica se o servidor esta online
$servidor_online = $ssh->online($ip_servidor);
if ($servidor_online) {
    $servidor_autenticado = $ssh->auth($loginSSH, $senhaSSH);
    if ($servidor_autenticado) {
        $status = "<div class='alert alert-success alert-dismissible'>

                <h4><center>Autenticado</center></h4>

              </div>";
        //Verifica memoria
        $ssh->exec("free -m");
        $mensagem = (string) $ssh->output();
        $words = preg_split(
            "/[\s,]*\\\"([^\\\"]+)\\\"[\s,]*|" . "[\s,]*'([^']+)'[\s,]*|" . "[\s,]+/",
            $mensagem,
            0,
            PREG_SPLIT_NO_EMPTY | PREG_SPLIT_DELIM_CAPTURE
        );
        //Memoria total $words[7]
        //Memoria usada $words[8]
        //Memoria livre $words[9]

        //Quantidade de CPU fisico
        $ssh->exec("cat /proc/cpuinfo | grep 'physical id' | sort | uniq | wc -l ");
        $mensagem_f = (string) $ssh->output();
        $cpu_fisico = $mensagem_f;

        //Quantidade de CPU Virtual
        $ssh->exec("cat /proc/cpuinfo | egrep 'core id|physical id' | tr -d '\n' | sed s/physical/\\nphysical/g | grep -v ^$ | sort | uniq | wc -l");
        $mensagem_v = (string) $ssh->output();
        $cpu_virtual = $mensagem_v;

        //Nome do Processador
        $ssh->exec("cat /proc/cpuinfo | egrep ' model name|model name'");
        $mensagem_p = (string) $ssh->output();
        $partes = explode(":", $mensagem_p);
        $nome_processador = $partes[1];

        //UPTIME
        $ssh->exec("uptime -p");
        $mensagem_u = (string) $ssh->output();
        $uptime = $mensagem_u;
####################################################################################
			//entrada
			$ssh->exec("ifconfig eth0 | grep 'RX bytes' | awk '{print $3 $4}'");
			$mensagem_u = (string) $ssh->output();
			$download1 = $mensagem_u;

			//entrada
			$ssh->exec("ifconfig lo | grep 'RX bytes' | awk '{print $3 $4}'");
			$mensagem_u = (string) $ssh->output();
			$download2 = $mensagem_u;
			
			//entrada
			$ssh->exec("ifconfig venet0 | grep 'RX bytes' | awk '{print $3 $4}'");
			$mensagem_u = (string) $ssh->output();
			$download3 = $mensagem_u;
####################################################################################			
			//saida
			$ssh->exec("ifconfig eth0 | grep 'RX bytes' | awk '{print $7 $8}'");
			$mensagem_u = (string) $ssh->output();
			$upload1 = $mensagem_u;
			
			//saida
			$ssh->exec("ifconfig lo | grep 'RX bytes' | awk '{print $7 $8}'");
			$mensagem_u = (string) $ssh->output();
			$upload2 = $mensagem_u;
			
			//saida
			$ssh->exec("ifconfig venet0 | grep 'RX bytes' | awk '{print $7 $8}'");
			$mensagem_u = (string) $ssh->output();
			$upload3 = $mensagem_u;
####################################################################################
        if ($servidor['tipo'] <> 'free') {
            //Usuarios SSH online neste servidor
            $SQLContasSSH = "SELECT sum(online) AS soma  FROM usuario_ssh where id_servidor = '" . $_GET['id_servidor'] . "'   ";
            $SQLContasSSH = $conn->prepare($SQLContasSSH);
            $SQLContasSSH->execute();
            $SQLContasSSH = $SQLContasSSH->fetch();
            $usuarios_online = $SQLContasSSH['soma'];
        }
    } else {
        $status = "<div class='alert alert-warning alert-dismissible'>

                <h4><center>Não Autenticado </center></h4>

              </div>";
    }
} else {
    $status = "<div class='alert alert-danger alert-dismissible'>

                <h4><center>OFFLINE </center></h4>

              </div>";
}

?>

<!-- Input with Icons start -->
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<section id="input-with-icons">
    <div class="row">
        <div class="col-sm-12">
            <div id="responsive-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <center>
                                <h4 class="modal-title">Funções do servidor</h4>
                            </center>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <?php if ($servidor_autenticado) { ?>
                                        <script type="text/javascript">
                                            function updatescripts() {
                                                decisao = confirm("Realmente quer atualizar? , os usuarios serão resetados!");
                                                if (decisao) {
                                                    window.location.href = '../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=updateScript'
                                                } else {

                                                }
                                            }
                                        </script>
                                        <div class="box box-warning">
                                            <center><a href="../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=reiniciar" class="btn btn-warning white"> Reiniciar Servidor</a><br><br>
                                                <a href="../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=desligar" class="btn btn-danger white"> Desligar Servidor</a><br><br>
                                                <a href=" ../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=reiniciarSquid" class="btn btn-primary white">  Reiniciar Squid</a><br><br>
                                                <a onclick=" updatescripts()" class="btn btn-success white"> Sincronizar SSH</a><br><br>
                                            </center>
                                        </div>
                                    <?php } ?>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">

                    <div class="card border-info mb-3" style="height: 690.094px;">
                        <div class="card-content">
                            <div class="card-body">
                            <p class="card-text"><?php echo $status; ?></p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <span class="badge badge-pill bg-primary float-right"></span>
                                    <center><b><?php echo $nome_processador; ?></b></center>
                                </li>
                                <li class="list-group-item">
              <span class="badge badge-pill bg-info float-right"><?php echo $cpu_fisico; ?></span>
              <b>CPU física</b>
            </li>
            <li class="list-group-item">
              <span class="badge badge-pill bg-warning float-right"><?php echo $cpu_virtual; ?></span>
              <b>CPU Virtual</b>
            </li>
            <li class="list-group-item">
              <span class="badge badge-pill bg-success float-right"><?php echo $words[7]; ?> Mb</span>
              <b>Memoria total</b>
            </li>
            <li class="list-group-item">
              <span class="badge badge-pill bg-danger float-right"><?php echo $words[8]; ?> Mb</span>
              <b>Memoria usada</b>
            </li>
            <li class="list-group-item">
              <span class="badge badge-pill bg-success float-right"><?php echo $words[9]; ?> Mb</span>
              <b>Memoria livre</b>
            </li>
            <li class="list-group-item">
              <span class="badge badge-pill bg-info float-right"><?php echo $words[11]; ?> Mb</span>
              <b>Memoria cache</b>
            </li>
            <li class="list-group-item">
              <span class="badge badge-pill bg-success float-right"><?php echo $usuarios_online; ?></span>
              <b>Usuários Online</b>
            </li>
			<!-- ################################# -->
			<li class="list-group-item">
              <span class="badge badge-pill bg-danger float-right"><?php echo $upload1; ?><?php echo $upload3; ?></span>
              <b>Enviado</b>
			</li>
			<li class="list-group-item">
              <span class="badge badge-pill bg-danger float-right"><?php echo $download1; ?><?php echo $download3; ?></span>
			  <b>Recebido</b>
			</li>
			<li class="list-group-item">
              <span class="badge badge-pill bg-success float-right"><?php echo $uptime; ?></span>
              <b>Ligado</b>
            </li>
			<!-- ################################# -->
              <div class="card-body">
                                <center><button type="button" class="btn btn-warning waves-effect waves-light" alt="default" data-toggle="modal" data-target="#responsive-modal"> Funções do Servidor </button></center>
                            </div>
                        </div>
                    </div>
                </div>
            
            <!-- /.col -->
            <div class="col-sm-6">
                <div class="card border-info mb-3">
                    <div class="card-body p-b-0">
                        <h4 class="card-title"><i class="fa fa-edit"></i> Editar Servidor</i></h4>
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs customtab" role="tablist">
                            <li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#activity" role="tab"><span class="hidden-sm-up"><i class="ti-pencil"></i></span> <span class="hidden-xs-down">Informacoes</span></a> </li>
                            <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#timeline" role="tab"><span class="hidden-sm-up"><i class="ti-align-center"></i></span> <span class="hidden-xs-down">Contas SSH</span></a> </li>
                            <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#ovpn" role="tab"><span class="hidden-sm-up"><i class="ti-export"></i></span> <span class="hidden-xs-down">Arquivo OVPN</span></a> </li>
                        </ul>
                        <div class="tab-content">
                            <div class="active tab-pane" id="activity">
                                <form role="form" action="pages/servidor/editar_exe.php" method="post" enctype="multipart/form-data">
                                    <div class="form-body">
                                        <input type="hidden" class="form-control" id="id_servidor" name="id_servidor" value="<?php echo $servidor['id_servidor']; ?>"><br>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Nome do servidor</label>
                                            <input required="required" type="text" class="form-control" id="nomesrv" name="nomesrv" value="<?php echo $servidor['nome']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Endereço IP</label>
                                            <input required="required" type="text" class="form-control" id="ip" name="ip" value="<?php echo $servidor['ip_servidor']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Login</label>
                                            <input required="required" type="text" class="form-control" id="login" name="login" value="<?php echo $servidor['login_server']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Senha</label>
                                            <input required="required" type="password" class="form-control" id="login" name="senha" value="<?php echo $servidor['senha']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Site Servidor</label>
                                            <input required="required" type="text" class="form-control" id="siteserver" name="siteserver" value="<?php echo $servidor['site_servidor']; ?>" placeholder="Só precisa em Server Free">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Localização</label>
                                            <input required="required" type="text" class="form-control" id="localiza" name="localiza" value="<?php echo $servidor['localizacao']; ?>" placeholder="Só precisa em Server Free">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Validade</label>
                                            <input required="required" type="text" maxlength="2" class="form-control" id="validade" name="validade" value="<?php echo $servidor['validade']; ?>" placeholder="Só precisa em Server Free">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">Limite</label>
                                            <input required="required" type="text" maxlength="3" class="form-control" id="limite" name="limite" value="<?php echo $servidor['limite']; ?>" placeholder="Só precisa em Server Free">
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                    <div class="divider"></div>
                                    <div class="form-actions">
                                        <center>
                                            <button type="submit" class="btn btn-success">Alterar Servidor</button>
                                            <button type="reset" class="btn btn-danger">Limpar</button>
                                        </center>
                                    </div>
                                    <div class="divider"></div>
                                    <div class="card border-info mb-3">
                                        <div class="card-body">
                                            <h4 class="card-title">
                                                <center>Outras Opções</center>
                                            </h4>
                                            <hr><br>
                                            <div class="button-group">
                                                <center>
                                                    <a href="../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=deletarGeral" class="btn btn-danger">Deletar Tudo</a>
                                                    <div class="divider"></div>
                                                    <a href="../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=deletarContas" class="btn btn-danger">Deletar Contas SSH</a>
                                                    <div class="divider"></div>
                                                    <?php if ($servidor['manutencao'] == 'nao') { ?>
                                                        <a href="../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=manutencao" class="btn btn-warning">Por em Manutenção </a>
                                                        <div class="divider"></div>
                                                    <?php } else { ?>
                                                        <a href="../admin/pages/servidor/servidor_exe.php?id_servidor=<?php echo $servidor['id_servidor']; ?>&op=manutencao" class="btn btn-info">Tirar Manutenção</a>
                                                        <div class="divider"></div>
                                                    <?php } ?>
                                                </center>
                                            </div>
                                        </div>
                                    </div>

                                </form>
                            </div>
                            <!-- /.tab-panel -->
                            <div class="tab-pane" id="timeline">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <tr>
                                            <th>Login SSH</th>
                                            <th>Vencimento</th>
                                            <th>Online</th>
                                            <th>Acesso</th>
											<th>Editar</th>
                                        </tr>
                                        <?php
                                        if ($servidor['tipo'] == 'free') {
                                            $SQLUsuarioSSH = "select * from usuario_ssh_free where servidor='" . $servidor['id_servidor'] . "'  ";
                                        } else {
                                            $SQLUsuarioSSH = "select * from usuario_ssh where id_servidor='" . $servidor['id_servidor'] . "'  ";
                                        }
                                        $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                                        $SQLUsuarioSSH->execute();

                                        if (($SQLUsuarioSSH->rowCount()) > 0) {
                                            while ($row2 = $SQLUsuarioSSH->fetch()) {
                                                if ($servidor['tipo'] <> 'free') {
                                                    $SQLTotalUser = "select * from usuario_ssh WHERE id_servidor='" . $servidor['id_servidor'] . "' ";
                                                    $SQLTotalUser = $conn->prepare($SQLTotalUser);
                                                    $SQLTotalUser->execute();
                                                    $total_user = $SQLTotalUser->rowCount();

                                                    $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '" . $row2['id_servidor'] . "'  and id_usuario='" . $_GET['id_usuario'] . "' ";
                                                    $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                                    $SQLAcessoSSH->execute();
                                                    $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                                    $acessos += $SQLAcessoSSH['quantidade'];
                                                }
                                                $data_atual = date("Y-m-d ");
                                                $data_validade = $row2['data_validade'];
                                                if ($data_validade > $data_atual) {
                                                    $data1 = new DateTime($data_validade);
                                                    $data2 = new DateTime($data_atual);
                                                    $dias_acesso = 0;
                                                    $diferenca = $data1->diff($data2);
                                                    $ano = $diferenca->y * 364;
                                                    $mes = $diferenca->m * 30;
                                                    $dia = $diferenca->d;
                                                    $dias_acesso = $ano + $mes + $dia;
                                                }
                                                ?>
                                                <tr>
                                                    <td><?php echo $row2['login']; ?></td>
                                                    <td><span class="pull-left-container" style="margin-right: 5px;">
                                                            <span class="label label-primary pull-left">
                                                                <?php echo $dias_acesso . "  dias   "; ?>
                                                            </span>
                                                        </span>
                                                    </td>
                                                    <td><?php if ($servidor['tipo'] == 'premium') {
                                                                    echo $row2['online'];
                                                                } else {
                                                                    echo "<small>Server Free</small>";
                                                                } ?><i class="badge badge-pill bg-success float-right"></i></td>
                                                    <td><?php if ($servidor['tipo'] == 'premium') {
                                                                    echo $row2['acesso'];
                                                                } else {
                                                                    echo "<small>Server Free</small>";
                                                                } ?></td>
													<td> <a href="home.php?page=ssh/editar&id_ssh=<?php echo $row2['id_usuario_ssh'];?>" <?php echo $class;?>><i class="btn-sm btn-primary fa fa-eye"></i></a></td>			
                                                </tr>
												
                                        <?php
                                            }
                                        }
                                        ?>
                                    </table>
                                </div>
                            </div>
                            <?php
                            $SQLovpn = "select * from ovpn WHERE servidor_id = '" . $_GET["id_servidor"] . "' ";
                            $SQLovpn = $conn->prepare($SQLovpn);
                            $SQLovpn->execute();
                            ?>
                            <div class="tab-pane" id="ovpn">
                                <div class="box-body">
                                    <?php if ($SQLovpn->rowCount() == 0) { ?>
                                        <form role="form" action="pages/servidor/enviar_ovpn.php" method="post" enctype="multipart/form-data">
                                            <input name="servidorid" type="hidden" value="<?php echo $servidor['id_servidor']; ?>">
                                            <div class="form-group">
                                                <br><label for="exampleInputFile">Selecione o arquivo ovpn</label>
                                                <input type="file" id="arquivo" class="form-control" name="arquivo" required=required>
                                                <p class="help-block"><small>OVPN Tamanho Máximo 2MB.</small></p>
                                            <?php } else { ?>
                                                <div class="box box-solid box-success">
                                                    <div class="box-header">
                                                        <h3 class="box-title">Arquivo Enviado!</h3>
                                                    </div><!-- /.box-header -->
                                                    <div class="box-body">Já possui um arquivo <b>OVPN</b> instalado neste Servidor</div><!-- /.box-body -->
                                                </div>
                                            <?php } ?>
                                            <div class="box-footer box-primary">
                                                <div class="box-header with-border">
                                                    <?php if ($SQLovpn->rowCount() == 0) { ?> <button type="submit" class="btn btn-success">Enviar OVPN</button>
                                        </form><?php } ?>
                                    <div class="divider"></div>
                                    <a href="../admin/pages/servidor/deletar_ovpn.php?id_servidor=<?php echo $servidor['id_servidor']; ?>" class="btn btn-danger">Deletar OVPN</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</section>
<!-- Input with Icons end -->