 <?php

 if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
 {
   exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
 }

// Usados

 $qtddoserverusado=0;

 $SQLusuariosdele= "SELECT * FROM acesso_servidor where id_mestre = '".$_SESSION['usuarioID']."'";
 $SQLusuariosdele = $conn->prepare($SQLusuariosdele);
 $SQLusuariosdele->execute();

 if ($SQLusuariosdele->rowCount()>0) {
  while($usuariosdele=$SQLusuariosdele->fetch()){


    $SQLcontaqtdsshusadodele= "SELECT sum(acesso) as acessosdosserversusados2 FROM usuario_ssh where id_usuario = '".$usuariosdele['id_usuario']."'";
    $SQLcontaqtdsshusadodele = $conn->prepare($SQLcontaqtdsshusadodele);
    $SQLcontaqtdsshusadodele->execute();

    $qtdusadosdele=$SQLcontaqtdsshusadodele->fetch();

    $qtddoserverusado+=$qtdusadosdele['acessosdosserversusados2'];

//Select sub deles

    $SQLusuariossubdele= "SELECT * FROM usuario where id_mestre = '".$usuariosdele['id_usuario']."'";
    $SQLusuariossubdele = $conn->prepare($SQLusuariossubdele);
    $SQLusuariossubdele->execute();

    if ($SQLusuariossubdele->rowCount()>0) {
      while($usuariossubdele=$SQLusuariossubdele->fetch()){
        $SQLcontaqtdsshusado= "SELECT sum(acesso) as acessosdosserversusados FROM usuario_ssh where id_usuario = '".$usuariossubdele['id_usuario']."'";
        $SQLcontaqtdsshusado = $conn->prepare($SQLcontaqtdsshusado);
        $SQLcontaqtdsshusado->execute();

        $qtdusados=$SQLcontaqtdsshusado->fetch();

        $qtddoserverusado+=$qtdusados['acessosdosserversusados'];


      }
    }


  }

}


// Todos Acessos

$todosacessos=0;

$SQLqtdserveracessos2= "SELECT sum(qtd) as tudo FROM  acesso_servidor where id_mestre = '".$_SESSION['usuarioID']."'";
$SQLqtdserveracessos2 = $conn->prepare($SQLqtdserveracessos2);
$SQLqtdserveracessos2->execute();

$totalacessf=$SQLqtdserveracessos2->fetch();

$todosacessos+=$totalacessf['tudo'];


//Disponiveis
$disponiveis=$todosacessos-$qtddoserverusado;

if($disponiveis<=0){$disponiveis=0;}


//Calculo Porcentagem

$porcent = ($qtddoserverusado/$todosacessos)*100; // %

$resultado = $porcent;

$valor_porce = round($resultado);

if($valor_porce>=100){
  $valor_porce=100;
}



if(($valor_porce>=70)and($valor_porce<90)){
  $sucessobar="warning";
  $bgbar="warning";
}elseif($valor_porce>=90){
  $sucessobar="danger";
  $bgbar="danger";
}else{
  $sucessobar="success";
  $bgbar="success";
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
                 <h1 class="card-title font-medium-2"><i class="fad fa-server text-info font-large-1"></i> Listar Servidores</h1>
             </div>
             <div class="card-content">
                 <div class="card-body">
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
                             <th>NOME</th>
                             <th>CLIENTE</th>
                             <th>USO</th>
                             <th>ENDERECO IP</th>
                             <th>CONTAS SSH</th>
                             <th>ACESSOS SSH</th>
                             <th>LIMITE</th>
                             <th>VALIDADE</th>
                             <th>EXCLUIR / EDITAR</th>
                         </tr>
                         </thead>
                         <tbody id="MeuServidor">
                         <?php

                         $SQLAcessoServidor = "SELECT * FROM acesso_servidor where id_mestre = '".$_SESSION['usuarioID']."' ";
                         $SQLAcessoServidor = $conn->prepare($SQLAcessoServidor);
                         $SQLAcessoServidor->execute();



                         // output data of each row
                         if (($SQLAcessoServidor->rowCount()) > 0) {

                             while($row = $SQLAcessoServidor->fetch())


                             {

                                 $SQLusuario = "SELECT * FROM usuario where id_usuario = '".$row['id_usuario']."' ";
                                 $SQLusuario = $conn->prepare($SQLusuario);
                                 $SQLusuario->execute();
                                 $usuario=$SQLusuario->fetch();


                                 $contas=0;
                                 $total_acesso_ssh=0;

                                 $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$row['id_servidor']."'";
                                 $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                 $SQLContasSSH->execute();
                                 $contas += $SQLContasSSH->rowCount();

                                 $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$row['id_usuario']."' and id_servidor='".$row['id_servidor']."'";
                                 $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                 $SQLAcessoSSH->execute();
                                 $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                 $total_acesso_ssh += $SQLAcessoSSH['quantidade'];

                                 $SQLUserSub = "select * from usuario WHERE id_mestre = '".$row['id_usuario']."'";
                                 $SQLUserSub = $conn->prepare($SQLUserSub);
                                 $SQLUserSub->execute();

                                 if (($SQLUserSub->rowCount()) > 0) {

                                     while($rowS = $SQLUserSub->fetch()) {
                                         $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$rowS['id_usuario']."'  and id_servidor='".$row['id_servidor']."'";
                                         $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                         $SQLContasSSH->execute();
                                         $contas += $SQLContasSSH->rowCount();

                                         $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$rowS['id_usuario']."'  and id_servidor='".$row['id_servidor']."'";
                                         $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                         $SQLAcessoSSH->execute();
                                         $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                         $total_acesso_ssh += $SQLAcessoSSH['quantidade'];

                                         $SQLusuariossubdele2= "SELECT * FROM usuario where id_mestre = '".$rowS['id_usuario']."'";
                                         $SQLusuariossubdele2 = $conn->prepare($SQLusuariossubdele2);
                                         $SQLusuariossubdele2->execute();
                                         if (($SQLusuariossubdele2->rowCount()) > 0) {
                                             while($rowSubdele = $SQLusuariossubdele2->fetch()) {
                                                 $SQLContasSSH = "select * from usuario_ssh WHERE id_usuario = '".$rowSubdele['id_usuario']."'  and id_servidor='".$row['id_servidor']."'";
                                                 $SQLContasSSH = $conn->prepare($SQLContasSSH);
                                                 $SQLContasSSH->execute();
                                                 $contas += $SQLContasSSH->rowCount();

                                                 $SQLAcessoSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_usuario='".$rowSubdele['id_usuario']."'  and id_servidor='".$row['id_servidor']."'";
                                                 $SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
                                                 $SQLAcessoSSH->execute();
                                                 $SQLAcessoSSH = $SQLAcessoSSH->fetch();
                                                 $total_acesso_ssh += $SQLAcessoSSH['quantidade'];


                                             }
                                         }

                                     }
                                 }



                                 $Servidor = "select * from servidor where id_servidor='".$row['id_servidor']."'";
                                 $Servidor = $conn->prepare($Servidor);
                                 $Servidor->execute();
                                 $rowservidor = $Servidor->fetch();

                                 $SQLcliennte = "select * from usuario WHERE id_usuario='".$row['id_usuario']."' ";
                                 $SQLcliennte = $conn->prepare($SQLcliennte);
                                 $SQLcliennte->execute();
                                 $cliente=$SQLcliennte->fetch();

                                 $todosacessos2=0;

                                 $SQLqtdserveracessos2= "SELECT sum(qtd) as todosacessos FROM  acesso_servidor where id_usuario = '".$row['id_usuario']."' and id_servidor='".$row['id_servidor']."' ";
                                 $SQLqtdserveracessos2 = $conn->prepare($SQLqtdserveracessos2);
                                 $SQLqtdserveracessos2->execute();

                                 $totalacess2=$SQLqtdserveracessos2->fetch();

                                 $todosacessos2+=$totalacess2['todosacessos'];

                                 //Calculo Porcentagem

                                 $porcentagem = ($total_acesso_ssh/$todosacessos2)*100; // %

                                 $resultado2 = $porcentagem;

                                 $valor_porcetage = round($resultado2);

                                 if($valor_porcetage>=100){
                                     $valor_porcetage=100;
                                 }

                                 if($valor_porcetage<=0){
                                     $valor_porcetage=0;
                                 }
                                 if(($valor_porcetage>=70)and($valor_porcetage<90)){
                                     $sucessobar="warning";
                                     $bgbar2="warning";
                                 }elseif($valor_porcetage>=90){
                                     $sucessobar="danger";
                                     $bgbar2="danger";
                                 }else{
                                     $sucessobar="success";
                                     $bgbar2="success";
                                 }


                                 $SQLServidor= "select * from servidor WHERE id_servidor = '".$row['id_servidor']."' ";
                                 $SQLServidor = $conn->prepare($SQLServidor);
                                 $SQLServidor->execute();
                                 $servidor =  $SQLServidor->fetch();


                                 $SQLopen = "select * from ovpn WHERE servidor_id = '".$row['id_servidor']."' ";
                                 $SQLopen = $conn->prepare($SQLopen);
                                 $SQLopen->execute();
                                 if($SQLopen->rowCount()>0){
                                     $openvpn=$SQLopen->fetch();
                                     $texto="<a href='../admin/pages/servidor/baixar_ovpn.php?id=".$openvpn['id']."' class=\"label label-info\">Baixar</a>";
                                 }else{
                                     $texto="<span class=\"label label-danger\">Indisponivel</span>";
                                 }

                                 //Calcula os dias restante
                                 $data_atual = date("Y-m-d");
                                 $data_validade = $row['validade'];
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


                                 //Carrega contas SSH criadas
                                 $SQLContasminha = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$row['id_servidor']."' and id_usuario='".$_SESSION['usuarioID']."' ";
                                 $SQLContasminha = $conn->prepare($SQLContasminha);
                                 $SQLContasminha->execute();
                                 $SQLContasminha = $SQLContasminha->fetch();
                                 $contas_ssh_criadas_minhas = $SQLContasminha['quantidade'];

                                 //Carrega usuario sub
                                 $SQLUsuarioSub_minhas = "SELECT * FROM usuario WHERE id_mestre ='".$_SESSION['usuarioID']."' and subrevenda='nao'";
                                 $SQLUsuarioSub_minhas = $conn->prepare($SQLUsuarioSub_minhas);
                                 $SQLUsuarioSub_minhas->execute();


                                 if (($SQLUsuarioSub_minhas->rowCount()) > 0) {
                                     while($row2 = $SQLUsuarioSub_minhas->fetch()) {
                                         $SQLSubSSH_minhas= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row2['id_usuario']."' and id_servidor='".$serveacesso['id_servidor']."' ";
                                         $SQLSubSSH_minhas = $conn->prepare($SQLSubSSH_minhas);
                                         $SQLSubSSH_minhas->execute();
                                         $SQLSubSSH_minhas = $SQLSubSSH_minhas->fetch();
                                         $contas_ssh_criadas_minhas += $SQLSubSSH_minhas['quantidade'];

                                     }

                                 }


                                 $SQLservermy = "select * from acesso_servidor WHERE id_acesso_servidor='".$row['id_servidor_mestre']."'";
                                 $SQLservermy = $conn->prepare($SQLservermy);
                                 $SQLservermy->execute();

                                 $meuserver=$SQLservermy->fetch();

                                 $somameusatuais=$meuserver['qtd']-$contas_ssh_criadas_minhas;

                                 ?>

                                 <div id="myModal<?php echo $row['id_acesso_servidor'];?>" class="modal fade in">
                                     <div class="modal-dialog">
                                         <div class="modal-content">
                                             <form name="deletarserver" action="pages/subrevenda/deletarservidor_exe.php" method="post">
                                                 <input name="servidor" type="hidden" value="<?php echo $row['id_acesso_servidor'];?>">
                                                 <input name="cliente" type="hidden" value="<?php echo $cliente['id_usuario'];?>">
                                                 <div class="modal-header">
                                                     <a class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></a>
                                                     <h4 class="modal-title">Apagar Tudo de <?php echo $cliente['nome'];?></h4>
                                                 </div>
                                                 <div class="modal-body">
                                                     <h4>Tem certeza?</h4>
                                                     <p>Todos os clientes deles irão ter a conta SSH Deletada.</p>
                                                     <p>Você recebe os Acessos de Volta.</p>
                                                 </div>
                                                 <div class="modal-footer">
                                                     <button class="btn btn-danger" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancelar</button>
                                                     <button name="deletandoserver" class="btn btn-primary"><span class="glyphicon glyphicon-check"></span> Confirmar</button><br>
                                                     <br></div>
                                             </form>
                                         </div><!-- /.modal-content -->
                                     </div><!-- /.modal-dalog -->
                                 </div><!-- /.modal -->

                                 <div class="modal fade" id="squarespaceModal<?php echo $row['id_acesso_servidor'];?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                                     <div class="modal-dialog">
                                         <div class="modal-content">
                                             <div class="modal-header">
                                                 <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-pencil-square-o"></i> Editar Servidor de Acesso</h3>
                                             </div>
                                             <div class="modal-body">

                                                 <!-- content goes here -->
                                                 <form name="editaserver" action="pages/subrevenda/editar_acesso.php" method="post">
                                                     <input name="idservidoracesso" type="hidden" value="<?php echo $row['id_acesso_servidor'];?>">
                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">Servidor</label>
                                                         <select size="1" class="form-control select2" name="fazer" disabled>
                                                             <option value="<?php echo $rowservidor['id_servidor'];?>" selected=selected> <?php echo $rowservidor['nome'];?> - <?php echo $rowservidor['ip_servidor'];?> -  Limite Atual: <?php echo $row['qtd'];?> Saldo: <?php echo $somameusatuais;?></option>
                                                         </select>
                                                     </div>
                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">Revendedor</label>
                                                         <input type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $cliente['nome'];?>" disabled>
                                                     </div>

                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">+ Dias</label>
                                                         <input type="number" class="form-control" name="dias" value="1">
                                                     </div>
                                                     <div class="form-group">
                                                         <label for="exampleInputPassword1">Mais Limite Ex: 1<br>Menos Limite Ex: -1</label>
                                                         <input type="text" class="form-control" name="limite" value="0">
                                                     </div>

                                                     <div class="modal-footer">
                                                         <button type="button" class="btn btn-danger" data-dismiss="modal" role="button">Cancelar</button>
                                                         <button class="btn btn-success">Confirmar</button>
                                                 </form>
                                             </div>
                                         </div>
                                     </div>
                                 </div>

                                 <div class="modal fade" id="criarfatura<?php echo $row['id_acesso_servidor'];?>" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true" style="display: none;">
                                     <div class="modal-dialog">
                                         <div class="modal-content">
                                             <div class="modal-header">
                                                 <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                                 <h3 class="modal-title" id="lineModalLabel"><i class="fa fa-money"></i> Cria uma Fatura</h3>
                                             </div>
                                             <div class="modal-body">

                                                 <!-- content goes here -->
                                                 <form name="editaserver" action="pages/subrevenda/criafatura_subaloc.php" method="post">
                                                     <input name="idcontausuario" type="hidden" value="<?php echo $row['id_usuario'];?>">
                                                     <input name="servidoralocado" type="hidden" value="<?php echo $row['id_acesso_servidor'];?>">
                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">Servidor</label>
                                                         <input type="text" class="form-control" value="<?php echo $servidor['nome'];?>" disabled="">
                                                     </div>
                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">Cliente</label>
                                                         <input type="text" class="form-control" disabled value="<?php echo $cliente['nome'];?>">
                                                     </div>
                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">Tipo</label>
                                                         <select size="1" class="form-control" disabled>
                                                             <option value="3" selected=selected>Revenda</option>
                                                         </select>
                                                     </div>

                                                     <div class="form-group">
                                                         <label for="exampleInputEmail1">Valor</label>
                                                         <input type="number" class="form-control" name="valor" value="1">
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

                                                     <div class="modal-footer">
                                                         <button type="button" class="btn btn-inverse" data-dismiss="modal" role="button">Cancelar</button>
                                                         <button class="btn btn-default btn-primary">Confirmar</button>
                                                 </form>
                                             </div>
                                         </div>
                                     </div>
                                 </div>



                                 <tr>

                                     <td><?php echo $servidor['nome'];?></td>
                                     <td><?php echo $usuario['nome'];?></td>
                                     <td><span class="badge badge-<?php echo $bgbar2;?>"><?php echo $valor_porcetage;?>%</span></td>
                                     <td><?php echo $servidor['ip_servidor'];?></td>
                                     <td><?php echo $contas;?></td>
                                     <td><?php echo $total_acesso_ssh;?></td>
                                     <td><?php echo $row['qtd'];?></td>
                                     <td>
         <span class="pull-left-container" style="margin-right: 5px;">
            <span class="label label-primary pull-left">
             <?php echo $dias_acesso."  dias   "; ?>
            </span>
         </span>
                                     </td>

                                     <td>
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                         <a data-toggle="modal" href="#myModal<?php echo $row['id_acesso_servidor'];?>" class="btn-sm btn-danger"><i class="fa fa-trash"></i></a>&nbsp;&nbsp;&nbsp;
                                             <a data-toggle="modal" href="#squarespaceModal<?php echo $row['id_acesso_servidor'];?>" class="btn-sm btn-warning"><i class="fa fa-list-alt"></i></a>
                                         </div>

                                     </td>
                                 </tr>

                             <?php }
                         }

                         ?>

                         </tbody>
                     </table>
                 </div>
             </div>
         </div>
     </div>
 </div>


 <div class="row" id="table-hover-row">
     <div class="col-12">
         <div class="card border-info mb-3">
             <div class="card-header">
                 <h1 class="card-title font-medium-2"><i class="text-success font-large-1"></i> Estatisticas (Deles)</h1>
             </div>
             <div class="card-content">
                 <div class="card-body">
                     <p></p>
                 </div>
                 <div class="table-responsive">
                     <table class="table table-hover mb-0" id="MeuServidor" data-search="minhaPesquisa-lista">
                         <thead>
                         <tr>
                             <th style="width: 50%">Acessos</th>
                             <th style="width: 50%">Acessos Disponíveis</th>
                         <tr>
                         <tr>
                             <td><?php echo $qtddoserverusado;?>/<?php echo $todosacessos;?></td>
                             <td><?php echo $disponiveis;?></td>
                         </tr>
                         <tr>
                             <th>Progresso de Uso</th>
                             <th style="width: 40px">Utilizado (%)</th>
                         </tr>
                         <tr>
                             <td><div class="progress progress-xl progress-bar-<?php echo $sucessobar;?>"><div class="progress-bar progress-bar-<?php echo $sucessobar;?>" style="width: <?php echo $valor_porce;?>%"></div></div></td>
                             <td><span class="badge badge-<?php echo $bgbar;?> "><?php echo $valor_porce;?>%</span></td>
                         </tr>
                         </thead>
                     </table>
                 </div>
             </div>
         </div>
     </div>
 </div>
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