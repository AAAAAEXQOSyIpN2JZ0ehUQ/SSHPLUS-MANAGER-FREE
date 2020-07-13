<style>
    .modal .modal-header {
        border-bottom: none;
        position: relative;
    }
    .modal .modal-header .btn {
        position: absolute;
        top: 0;
        right: 0;
        margin-top: 0;
        border-top-left-radius: 0;
        border-bottom-right-radius: 0;
    }
    .modal .modal-footer {
        border-top: none;
        padding: 0;
    }
    .modal .modal-footer .btn-group > .btn:first-child {
        border-bottom-left-radius: 0;
    }
    .modal .modal-footer .btn-group > .btn:last-child {
        border-top-right-radius: 0;
    }
</style>
<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}



if(isset($_GET["id_usuario"])){

    $id_usuario = $_GET["id_usuario"];
    $owner= $_SESSION['usuarioID'];


    $SQLUsuario= "SELECT * FROM usuario where id_usuario='".$id_usuario."' and id_mestre =  '".$_SESSION['usuarioID']."' ";
    $SQLUsuario = $conn->prepare($SQLUsuario);
    $SQLUsuario->execute();

    $SQLUsuarioSSH= "SELECT * FROM usuario_ssh where id_usuario='".$id_usuario."'   ";
    $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
    $SQLUsuarioSSH->execute();

    $total_ssh = $SQLUsuarioSSH->rowCount();

    $total_acesso_ssh = 0;
    $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$id_usuario."' ";
    $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
    $SQLAcessoSSH->execute();
    $SQLAcessoSSH = $SQLAcessoSSH->fetch();
    $total_acesso_ssh += $SQLAcessoSSH['quantidade'];



    if(($SQLUsuario->rowCount()) <= 0){
        echo '<script type="text/javascript">';
        echo 	'alert("O usuario nao existe!");';
        echo	'window.location="home.php?page=usuario/listar";';
        echo '</script>';
        exit;
    }else{
        $usuarioGET = $SQLUsuario->fetch();
    }





}else{

    echo '<script type="text/javascript">';
    echo 	'alert("Preencha todos os campos!");';
    echo	'window.location="home.php?page=usuario/listar";';
    echo '</script>';
}


$diretorio = " ";

?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<!-- Alerta de usuario suspenso -->
<?php if($usuarioGET['ativo'] == 2 ){?>
    <div class="alert alert-danger alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <center><h4><i class="icon fa fa-ban"></i>  Conta suspensa !</h4></center>
    </div>
<?php }?>


<div class="row">
    <div class="col-lg-4 col-xlg-3 col-md-5">
        <div class="card  border-info mb-3">
            <div class="card-body little-profile text-center">
                <div class="pro-img"><img class="img-circle" src="../app-assets/images/portrait/avatar/<?php echo $avatarusu;?>" height="60" width="60" alt="user"/></div>

                <h3 class="profile-username text-center"><?php echo $usuarioGET['nome'];?></h3>
                <?php if($usuarioGET['tipo']== "vpn"){ ?>
                    <p class="text-muted text-center">Usuário SSH</p>

                <?php }elseif($usuarioGET['tipo']== "revenda"){
                    if($usuarioGET['subrevenda']=='sim'){
                        ?>
                        <p class="text-muted text-center">Sub-Revendedor</p>
                    <?php } else{
                        ?>
                        <p class="text-muted text-center">Revendedor</p>
                        <?php
                    }
                } ?>


                <ul class="list-group list-group-unbordered">
                    <li class="list-group-item">
                        <b>Contas SSH</b> <a class="pull-right"><?php echo $total_ssh;?></a><br>
                    </li>
                    <li class="list-group-item">
                        <b>Acessos SSH</b> <a class="pull-right"><?php echo $total_acesso_ssh;?></a>
                    </li>
                    <?php if($usuarioGET['subrevenda']=='sim'){
                        $SQLUsuario2= "SELECT * FROM usuario where id_mestre='".$id_usuario."'";
                        $SQLUsuario2 = $conn->prepare($SQLUsuario2);
                        $SQLUsuario2->execute();
                        $total_acesso_usuarios=$SQLUsuario2->rowCount();


                        ?>
                        <li class="list-group-item">
                            <b>Usuários Criados</b> <a class="pull-right"><?php echo $total_acesso_usuarios;?></a>
                        </li>
                    <?php } ?>
                </ul>
                
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->

        <!-- About Me Box -->
        <div class="card border-info mb-3">
            <div class="card-body">
                <h4 class="card-title"><center>Ações</center></h4><hr><br>
                <!-- /.box-header -->
                <div class="box-body">
                    <script type="text/javascript">
                        function excluir_usuario(){
                            decisao = confirm("Tem certeza que vai excluir?!");
                            if (decisao){
                                window.location.href='pages/system/funcoes.usuario.php?&id_usuario=<?php echo $usuarioGET['id_usuario'];?>&diretorio=../../home.php?page=usuario/listar&owner=<?php echo $owner;?>&op=deletar'
                            } else {

                            }
                        }
                        function suspende_usuario(){
                            decisao = confirm("Tem certeza que vai suspender?!");
                            if (decisao){
                                window.location.href='pages/system/funcoes.usuario.php?&id_usuario=<?php echo $id_usuario;?>&diretorio=../../admin/home.php?page=usuario/listar&owner=<?php echo $owner;?>&op=suspender'
                            } else {

                            }
                        }
                    </script>
                    <center><a onclick="excluir_usuario()" class="btn btn-danger text-white"><b>DELETAR TUDO</b></a></center><br>
                    <?php if($usuarioGET['ativo']== 1){?>
                        <center><a onclick="suspende_usuario()" class="btn btn-warning text-white"><b>SUSPENDER TUDO</b></a></center><br>
						<center>
						<a href="?page=subrevenda/adicionar" class="btn btn-primary btn-success"><b>ADICIONAR SERVIDOR</b></a></center>
                    <?php }else{?>
                        <center><a href="pages/system/funcoes.usuario.php?&id_usuario=<?php echo $usuarioGET['id_usuario'];?>&diretorio=../../home.php?page=usuario/listar&owner=<?php echo $owner;?>&op=ususpender" class="btn btn-success text-white"><b>REATIVAR TUDO</b></a></center><br>
                    <?php }?>
                    <?php
                    /*
                    $SQLHist= "SELECT * FROM historico_login where id_usuario='".$id_usuario."' LIMIT 4 ";
                    $SQLHist = $conn->prepare($SQLHist);
                    $SQLHist->execute();




   if (($SQLHist->rowCount()) > 0) {
       // output data of each row
       while($row = $SQLHist->fetch()) {

           ?>



           <strong><i class="fa fa-map-marker margin-r-5"></i> <?php echo $row['ip_login'];?></strong>

                 <p class="text-muted"> <?php echo $row['data_login'];?></p>

                 <hr>

      <?php }
   }

   */
                    ?>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
    <!-- /.col -->
    <div class="col-md-8">
        <div class="card border-info mb-3">
            <div class="card-body p-b-0">
                <h4 class="card-title"><i class="fa fa-edit"></i> Gerenciar</i></h4>
                <!-- Nav tabs -->
                <ul class="nav nav-tabs customtab" role="tablist">
                    <li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#activity" role="tab"><span class="hidden-sm-up"><i class="ti-pencil"></i></span> <span class="hidden-xs-down">Editar</span></a> </li>

                    <?php if($usuarioGET['subrevenda']=='sim'){  ?>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#ssh" role="tab"><span class="hidden-sm-up"><i class="ti-harddrives"></i></span> <span class="hidden-xs-down">Servidores Alocados</span></a> </li>
                    <?php }else{ ?>
                        <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#ssh" role="tab"><span class="hidden-sm-up"><i class="ti-loop"></i></span> <span class="hidden-xs-down">Contas SSH</span></a> </li>
                    <?php } ?>
                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                        <form class="form-horizontal"  role="perfil" name="perfil" id="perfil" action="pages/usuario/editarusuario.php" method="post" >
                            <div class="form-group"><br>
                                <label for="exampleInputPassword1">Login</label>
                                <input type="text" name="login" id="login" class="form-control" minlength="4" value="<?php echo $usuarioGET['login'];?>" required="">
                                <input type="hidden" class="form-control" id="id_usuario" name="id_usuario" value="<?php echo $usuarioGET['id_usuario'];?>">
                                <input type="hidden" class="form-control" id="diretorio" name="diretorio" value="../../home.php?page=usuario/perfil&id_usuario=<?php echo $usuarioGET['id_usuario'];?>">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Senha</label>
                                <input type="password" name="senha" id="senha" class="form-control" minlength="3" value="<?php echo $usuarioGET['senha'];?>" required="">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Email</label>
                                <input type="text" name="email" id="email" class="form-control" minlength="4" value="<?php echo $usuarioGET['email'];?>" required="">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Celular</label>
                                <input type="text" name="celular" id="celular" class="form-control" minlength="4" value="<?php echo $usuarioGET['celular'];?>" required="">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Data de cadastro</label>
                                <input type="text" class="form-control" disabled value="<?php echo $usuarioGET['data_cadastro'];?>">
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success">Alterar Dados</button>
                            </div>
                        </form>

                    </div>

                    <div class=" tab-pane" id="ssh">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="box box-primary">
                                    <div class="box-header">
                                        <?php if($usuarioGET['subrevenda']=='sim'){ ?>
                                            <h3 class="box-title">Servidores Alocados</h3>
                                        <?php }else{ ?>
                                            <h3 class="box-title">Contas SSH</h3>
                                        <?php }?>
                                    </div>
                                    <!-- /.box-header -->
                                    <?php if($usuarioGET['subrevenda']=='sim'){ ?>
                                    <div class="box-body table-responsive no-padding">
                                        <table class="table table-hover">
                                            <tr>
                                                <th>Servidor</th>
                                                <th>Limite Acessos</th>
                                                <th>Validade</th>
                                                <th>Contas SSH</th>
                                                <th>Acessos SSH</th>
                                                <th></th>
                                            </tr>
                                            <?php
                                            $SQLAcessoServidor = "select * from acesso_servidor where id_usuario='".$usuarioGET['id_usuario']."'  ";
                                            $SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
                                            $SQLAcessoServidor->execute();
                                            if (($SQLAcessoServidor->rowCount()) > 0) {
                                            while($row2 = $SQLAcessoServidor->fetch()   ){

                                            $SQLTotalUser = "select * from usuario WHERE id_usuario = '".$_GET['id_usuario']."' ";
                                            $SQLTotalUser = $conn->prepare($SQLTotalUser);
                                            $SQLTotalUser->execute();
                                            $total_user = $SQLTotalUser->rowCount();

                                            $SQLServidor = "select * from servidor where id_servidor = '".$row2['id_servidor']."'";
                                            $SQLServidor = $conn->prepare($SQLServidor);
                                            $SQLServidor->execute();

                                            $contas=0;
                                            $acessos=0;


                                            $SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '".$row2['id_servidor']."'
                 and id_usuario='".$_GET['id_usuario']."'  ";
                                            $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                                            $SQLUsuarioSSH->execute();
                                            $contas += $SQLUsuarioSSH->rowCount();

                                            $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row2['id_servidor']."'  and id_usuario='".$_GET['id_usuario']."' ";
                                            $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                            $SQLAcessoSSH->execute();
                                            $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                            $acessos += $SQLAcessoSSH['quantidade'];

                                            $SQLUsuarioSub = "select * from usuario WHERE id_mestre = '".$_GET['id_usuario']."'  ";
                                            $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
                                            $SQLUsuarioSub->execute();

                                            if (($SQLUsuarioSub->rowCount()) > 0) {
                                                while($row3 = $SQLUsuarioSub->fetch()   ){

                                                    $SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '".$row2['id_servidor']."'
                    and id_usuario='".$row3['id_usuario']."'  ";
                                                    $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                                                    $SQLUsuarioSSH->execute();
                                                    $contas += $SQLUsuarioSSH->rowCount();

                                                    $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row2['id_servidor']."'  and id_usuario='".$row3['id_usuario']."' ";
                                                    $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                                    $SQLAcessoSSH->execute();
                                                    $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                                    $acessos += $SQLAcessoSSH['quantidade'];

                                                }
                                            }

                                            if (($SQLServidor->rowCount()) > 0) {
                                            while($row3 = $SQLServidor->fetch()   ){

                                            $qtd_srv =0;

                                            //Calcula os dias restante
                                            $data_atual = date("Y-m-d");
                                            $data_validade = $row2['validade'];
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

                                            ?>

                                            <div id="myModal<?php echo $row2['id_acesso_servidor'];?>" class="modal fade" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <form name="deletarserver" action="pages/subrevenda/deletarservidor_exe.php" method="post">
                                                            <input name="servidor" type="hidden" value="<?php echo $row2['id_acesso_servidor'];?>">
                                                            <input name="cliente" type="hidden" value="<?php echo $usuarioGET['id_usuario'];?>">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                                                <h4 class="modal-title" id="lineModalLabel">Apagar Tudo de <?php echo $usuarioGET['nome'];?></h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <h4>Tem certeza?</h4>
                                                                <p>Todos os clientes deles irão ter a conta SSH Deletada.<br>Você recebe os Acessos de Volta !</p>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                                                <button type="button" name="deletandoserver" class="btn btn-primary">Confirmar</button><br>
                                                        </form>
                                                    </div><br>
                                                </div>
                                            </div>
                                    </div>


                                    <tr>
                                        <td><?php echo $row3['nome'];?></td>
                                        <td><?php echo $row2['qtd'];?></td>
                                        <td>
                    <span class="pull-left-container" style="margin-right: 5px;">
                      <span class="label label-primary pull-left">
                        <?php echo $dias_acesso."  dias   "; ?>
                      </span>
                    </span>
                                        </td>
                                        <td><?php echo $contas;?></td>
                                        <td><?php echo $acessos;?></td>
                                        <td>
                                            <center>
                                                <!-- <a href="#" class="btn btn-warning">Editar Acesso</a>
                                                <a data-toggle="modal" href="#myModal<?php echo $row2['id_acesso_servidor'];?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a></center>-->
                                        </td>
                                    </tr>
                                    <?php
                                    }
                                    }
                                    }
                                    }
                                    ?>
                                    </table>
                                </div>
                                <?php }else{ ?>
                                    <div class="box-body table-responsive no-padding">
                                        <table class="table table-hover">
                                            <tr>
                                                <th>Login</th>
                                                <th>Servidor</th>
                                                <th>Validade</th>
                                                <th></th>
                                            </tr>
                                            <?php
                                            $SQLUsuario= "SELECT * FROM usuario_ssh where id_usuario =  '".$usuarioGET['id_usuario']."' and status <= '2' ";
                                            $SQLUsuario = $conn->prepare($SQLUsuario);
                                            $SQLUsuario->execute();

                                            if (($SQLUsuario->rowCount()) > 0) {

                                                // output data of each row
                                                while($row_user = $SQLUsuario->fetch()   ){

                                                    $SQLServidor= "SELECT * FROM servidor where id_servidor =  '".$row_user['id_servidor']."' ";
                                                    $SQLServidor = $conn->prepare($SQLServidor);
                                                    $SQLServidor->execute();
                                                    $servidor = $SQLServidor->fetch();
                                                    $color = "";


                                                    if($row_user['status']== 2){

                                                        $color = "bgcolor='#FF6347'";
                                                    }




                                                    ?>


                                                    <tr <?php echo $color; ?>  >
                                                        <td><?php echo $row_user['login'];?></td>
                                                        <td><?php echo $servidor['nome'];?></td>
                                                        <td><?php echo date('d/m/Y', strtotime($row_user['data_validade']));?></td>
                                                        <td>

                                                            <a href="home.php?page=ssh/editar&id_ssh=<?php echo $row_user['id_usuario_ssh'];?>" class="btn btn-primary">Detalhes</a></center>

                                                        </td>

                                                    </tr>


                                                    <?php


                                                }
                                            }





                                            ?>





                                        </table>
                                    </div>
                                <?php } ?>
                                <!-- /.box-body -->
                            </div>
                            <!-- /.box -->
                        </div>
                    </div>



                </div>
                <!-- /.tab-pane -->

            </div>
            <!-- /.tab-content -->
        </div>
        <!-- /.nav-tabs-custom -->
    </div>
    <!-- /.col -->
</div>
<!-- /.row -->

