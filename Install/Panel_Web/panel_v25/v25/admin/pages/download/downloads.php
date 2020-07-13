<?php

    if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
    exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}

?>
<script type="text/javascript" src="../../plugins/datatables/sort-table.js"></script>
<style type="text/css">

  table { 
    width: 100%; 
    border-collapse: collapse; 
  }
  /* Zebra striping */
  tr:nth-of-type(odd) { 
    background: #f3f4f8; 
  }
  th { 
    background: white; 
    color: black; 
    font-weight: bold; 
  }
  td, th { 
    padding: 6px; 
    border: 1px solid #d7dfe2; 
    text-align: left; 
  }

</style>

<script>
  $(document).ready(function(){
    $("#myInput").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });
  });
</script>
<script type="text/javascript">
function deletatudo(){
decisao = confirm("Realmente deseja deletar todos downloads?");
if (decisao){
  window.location.href='pages/download/excluir_todos.php?id=1';
} else {

}


}
</script>
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
<!-- Input with Icons start -->
<div class="row">
                <div class="col-md-12">
                  <div class="card card-outline-info">
                    <div class="card-header">
                      <h4 class="m-b-0 text-white"><i class="fa fa-cloud-upload"></i> Hospedar Arquivos</h4></div>
                      <div class="card-body">
                        <h3 class="card-title">Arquivos Para download</h3>
                        <hr>
                        <form action="pages/download/enviandoarquivo.php" enctype="multipart/form-data" method="POST" role="form">
                          <div class="form-group">
                            <div class="form-group">
                              <label>Nome do Arquivo</label>
                              <input type="text" name="nome" id="nome" class="form-control" minlength="4"  placeholder="Digite o Nome do Arquivo..." required>
                            </div>
                            <label>Operadora</label>
                            <select class="form-control" name="operadora">
                              <option value='1' selected=selected>Todas</option>
                              <option value='2'>Claro</option>
											        <option value='3'>Vivo</option>
											        <option value='4'>Tim</option>
											        <option value='5'>Oi</option>
                            </select>
                          </div>
                          <div class="form-group">
                            <label>Status</label>
                            <select class="form-control" name="status">
                              <option value='1' selected=selected>Funcionando</option>
                              <option value='2'>Em Testes</option>
                            </select>
                          </div>
                          <div class="form-group">
                            <label>Tipo de Arquivo</label>
                            <select class="form-control" name="tipo">
                              <option value='1' selected=selected>Ehi</option>
                              <option value='2'>Apk</option>
                              <option value='3'>Outros</option>
                            </select>
                          </div>
                          <div class="form-group">
                            <label>Tipo de Cliente</label>
                            <select class="form-control" name="tipocliente">
                              <option value='1' selected=selected>Todos</option>
                              <option value='2'>Revenda</option>
                              <option value='3'>Vpn</option>
                            </select>
                          </div>
                          <div class="form-group">
                            <label>Descrição</label>
                            <input type="text" name="msg" id="msg" class="form-control" placeholder="Digite uma descrição..." required></div>
                            <div class="form-group">
                              <label>Arquivo</label>
                              <input type="file" class="form-control" name="arquivo">
                            </div>
                            <div class="form-group m-b-0">
                              <button type="submit" name="enviandoarquivos" class="btn btn-success">Salvar Arquivo</button>
                              <button type="reset" class="btn btn-inverse">Limpar</button><br><br><button type="submit" class="btn btn-danger" onclick="deletatudo();">Apagar Todos Downloads</button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="card card-outline-warning">
                    <div class="card-header">
                      <h4 class="m-b-0 text-white"><i class="fa fa-cloud"></i> Arquivos Hospedados</h4></div>
                      <div class="card-body">
                        <div class="col-12"><br>
                        <div class="form-responsive">
                          <input type="text" id="myInput" placeholder="Pesquisar..." class="form-control">
                        </div>
                      </div>   
                        <div class="table-responsive m-t-40">
                          <table class="js-sort-table">
                            <thead>
                              <tr>
                                <th>ID</th>
                                <th>TIPO</th>
											          <th>CLIENTE</th>
											          <th>OPERADORA</th>
											          <th>DATA POSTADO</th>
											          <th>NOME</th>
											          <th>DETALHES</th>
											          <th>APAGAR</th>
                              </tr>
                            </thead>
                            <tbody id="myTable">
                              <?php
                              $SQLSubSSH = "SELECT * FROM arquivo_download ORDER BY id desc";
                              $SQLSubSSH = $conn->prepare($SQLSubSSH);
                              $SQLSubSSH->execute();
                              if(($SQLSubSSH->rowCount()) > 0){
                                while($row = $SQLSubSSH->fetch()){
                                  $dataatual=$row['data'];
                                  $dataconv = substr($dataatual, 0, 10);
                                  $partes = explode("-", $dataconv);
                                  $ano = $partes[0];
                                  $mes = $partes[1];
                                  $dia = $partes[2];
                                  ?>
                                  <tr>
                                    <td><?php echo $row['id'];?></td>
                                    <td><?php echo ucfirst($row['tipo']);?></td>
                                    <td><?php echo ucfirst($row['cliente_tipo']);?></td>
                                    <td><?php echo ucfirst($row['operadora']);?></td>
                                    <td><?php echo $dia;?>/<?php echo $mes;?> - <?php echo $ano;?></td>
                                    <td><?php echo $row['nome_arquivo'];?></td>
                                    <td><?php echo $row['detalhes'];?></td>
                                    <td><a href="pages/download/excluir.php?id=<?php echo $row['id'];?>" class="btn btn-block btn-danger">Excluir</a></td>
                                  </tr>
                                  <?php
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
            </div>