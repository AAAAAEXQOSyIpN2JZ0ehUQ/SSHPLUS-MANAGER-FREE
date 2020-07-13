<?php
if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

if(isset($_GET['ler'])){

    switch($_GET['ler']){
        case 'all':$ler='tudo';$tipo='tudo';break;
        case 'others':$ler='others';$tipo='outros';break;
        case 'fatu':$ler='fatu';$tipo='fatura';break;
        case 'accs':$ler='contas';$tipo='conta';break;
        case 'reve':$ler='revenda';$tipo='revenda';break;
        case 'subreve':$ler='subrevenda';$tipo='subrevenda';break;
        case 'usuario':$ler='usuario';$tipo='usuario';break;
        case 'chamados':$ler='chamados';$tipo='chamados';break;
        default:$ler='nada';break;
    }
    if($ler=='nada'){

    }elseif($ler=='tudo'){

// Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='others'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='outros' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='fatu'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='fatura' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='contas'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='conta' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='revenda'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='revenda' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='subrevenda'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='subrevenda' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='usuario'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='subrevenda' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }elseif($ler=='chamados'){

        // Notificações
        $SQLnoti= "select * from  notificacoes where lido='nao' and tipo='chamados' and usuario_id='".$_SESSION['usuarioID']."'";
        $SQLnoti = $conn->prepare($SQLnoti);
        $SQLnoti->execute();
        $totalnoti = $SQLnoti->rowCount();

        if($totalnoti>0){
            while($tudo= $SQLnoti->fetch()){

                $SQLnotiler= "update notificacoes set lido='sim' where id='".$tudo['id']."'";
                $SQLnotiler = $conn->prepare($SQLnotiler);
                $SQLnotiler->execute();

            }
        }

    }

}else{$tipo='tudo';}

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
                <h1 class="card-title font-medium-2"><i class="fad fa-bell text-success font-large-1"></i> Últimas Notificacoes</h1>
                <div class="col-12"><br>
                        <div class="form-responsive">
                            <input type="text" id="myInput" placeholder="Pesquisar..." class="form-control">
                        </div>
                    </div>
            </div>
            <div class="card-content">
                <div class="card-body text-center">
                    <?php if(($_GET['ler']<>'all')and(isset($_GET['ler']))){?>
                        <a href="home.php?page=notificacoes/notificacoes" class="btn btn-warning round text-center"><span class="fad fa-search"></span> Visualizar Todos</a>
                    <?php } ?>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0 js-sort-table" id="MeuServidor" data-search="minhaPesquisa-lista">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>TIPO</th>
                            <th>DATA</th>
                            <th>INFORMACOES</th>
                            <th>DETALHES</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        if($tipo=='tudo'){
                            $SQLUPUser= "SELECT * FROM notificacoes where usuario_id =  '".$usuario['id_usuario']."' ORDER BY id desc LIMIT 15";
                        }else{
                            $SQLUPUser= "SELECT * FROM notificacoes where usuario_id =  '".$usuario['id_usuario']."' and tipo='".$tipo."' ORDER BY id desc LIMIT 15";
                        }
                        $SQLUPUser = $conn->prepare($SQLUPUser);
                        $SQLUPUser->execute();

                        // output data of each row
                        if (($SQLUPUser->rowCount()) > 0) {
                            while($noti = $SQLUPUser->fetch()){

                                switch($noti['tipo']){
                                    case 'fatura':$tipo='Fatura';$class='label label-success';$info='Visualizar';break;
                                    case 'conta':$tipo='Conta';$class='label label-warning';$info=$noti['info_outros'];break;
                                    case 'revenda':$tipo='Revenda';$class='label label-danger';$info=$noti['info_outros'];break;
                                    case 'subrevenda':$tipo='Revenda-SUB';$class='label label-primary';$info='Sobre a Revenda';break;
                                    case 'usuario':$tipo='Usúario VPN';$class='label label-primary';$info='Sobre Suas Contas';break;
                                    case 'outros':$tipo='Outros';$class='label label-primary';$info=$noti['info_outros'];break;
                                    case 'chamados':$tipo='Chamado/Suporte';$class='label label-primary';$info=$noti['info_outros'];break;
                                    default:$tipo='erro';break;
                                }

                                //Datas

                                $datacriado=$noti['data'];
                                $dataconvcriado = substr($datacriado, 0, 10);
                                $partes = explode("-", $dataconvcriado);
                                $ano = $partes[0];
                                $mes = $partes[1];
                                $dia = $partes[2];


                                ?>

                                <tr>
                                    <td><?php echo $noti['id'];?></td>
                                    <td><?php echo $tipo;?></td>
                                    <td><?php echo $dia;?>/<?php echo $mes;?>/<?php echo $ano;?></td>
                                    <?php if($noti['linkfatura']=='Admin'){?>
                                        <td><span class="label label-warning bg-yellow-active color-palette">Administração</span></td>
                                    <?php }else{ if($tipo=='Fatura'){?>
                                        <td><a href="home.php?page=<?php echo $noti['linkfatura'];?>"><span class="<?php echo $class;?>"><?php echo $info;?></span></a></td>

                                    <?php }else{?>
                                        <td><span class="<?php echo $class;?>"><?php echo $info;?></span></td>
                                    <?php } } ?>
                                    <td><?php echo $noti['mensagem'];?></td>
                                </tr>

                            <?php } }else{ ?>

                            <tr ><td valign="top" colspan="5">Nenhuma notificação encontrada</td></tr>
                        <?php }?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
