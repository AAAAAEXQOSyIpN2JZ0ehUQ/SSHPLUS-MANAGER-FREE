<?php

if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}
?>

<script type="text/javascript">
    function deleta(id){
        decisao = confirm("Tem certeza que deseja deletar essa Conta?!");
        if (decisao){
            window.location.href='home.php?page=ssh/online_free&deletar='+id;
        } else {

        }

    }
</script>
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
                <h1 class="card-title font-medium-2"><i class="fad fa-rocket text-success font-large-1"></i> Contas SSH Online</h1>
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
                          <th>SERVIDOR</th>
                          <th>IP SSH</th>
                          <th>LOGIN</th>
                          <th>VALIDADE</th>
                          <th>DONO</th>
                          <th>TEMPO</th>
                          <th>STATUS</th>
                          <th>CONEXAO</th>
                          <th>LIMITE</th>
                          <th>OPCOES</th>
                      </tr>
                      </thead>
                      <tbody>
                      <?php
                      $SQLSub = "SELECT * FROM usuario_ssh";
                      $SQLSub = $conn->prepare($SQLSub);
                      $SQLSub->execute();

                      if(($SQLSub->rowCount()) > 0){
                          while($rowSub = $SQLSub->fetch()) {

                              $SQLSSH = "SELECT * FROM servidor where tipo='premium' and id_servidor='".$rowSub['id_servidor']."' ORDER BY id_servidor";
                              $SQLSSH = $conn->prepare($SQLSSH);
                              $SQLSSH->execute();
                              $row = $SQLSSH->fetch();

                              //Calcula os dias restante
                              $dias_acesso = 0 ;

                              $data_atual = date("Y-m-d ");
                              $data_validade = $rowSub['data_validade'];
                              if($data_validade > $data_atual){
                                  $data1 = new DateTime( $data_validade );
                                  $data2 = new DateTime( $data_atual );
                                  $dias_acesso = 0;
                                  $diferenca = $data1->diff( $data2 );
                                  $ano = $diferenca->y * 364 ;
                                  $mes = $diferenca->m * 30;
                                  $dia = $diferenca->d;
                                  $dias_acesso = $ano + $mes + $dia;

                              }

                              $SQLSubowner = "SELECT * FROM usuario where id_usuario='".$rowSub['id_usuario']."'";
                              $SQLSubowner = $conn->prepare($SQLSubowner);
                              $SQLSubowner->execute();
                              $own=$SQLSubowner->fetch();

                              $status="";
                              if($rowSub['status']== 1){
                                  $status="Ativo";
                                  $class = "class='btn-sm btn-primary'";
                              }else{
                                  $status="Desativado";
                              }

                              if($rowSub['online'] != 0){

                                  ?>
                                  <tr>

                                      <td><?php echo $row['nome'];?></td>
                                      <td><?php echo $row['ip_servidor'];?></td>

                                      <td><?php echo $rowSub['login'];?></td>
                                      <td>

                             <span class="pull-left-container" style="margin-right: 5px;">
                              <span class="label label-primary pull-left">
                               <?php echo $dias_acesso."  dias   "; ?>
                             </span>
                           </span>

                                      </td>
                                      <td><?php echo $own['nome'];?></td>
                                      <td><?php echo tempo_corrido($rowSub['online_start']);?> </td>
                                      <td><?php
                                          if($rowSub['online']>0){ ?>
                                              <div class="badge badge-pill badge-glow badge-success">Online</div>
                                          <?php }else{
                                              echo $rowSub['online']; } ?></td>

                                      <td><?php echo $rowSub['online'];?></td>
                                      <td><?php echo $rowSub['acesso'];?></td>
                                      <td>
                                          <a href="home.php?page=ssh/editar&id_ssh=<?php echo $rowSub['id_usuario_ssh'];?>" <?php echo $class;?>><i class="fa fa-eye"></i></a>
                                      </td>
                                  </tr>
                                  <?php
                              }
                          }
                      }

                      ?>
                      </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
