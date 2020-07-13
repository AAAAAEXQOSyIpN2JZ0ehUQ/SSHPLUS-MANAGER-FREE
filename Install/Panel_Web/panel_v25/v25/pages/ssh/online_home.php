<?php
require_once('../../pages/system/seguranca.php');
require_once('../../pages/system/config.php');
require_once('../../pages/system/funcoes.php');
require_once('../../pages/system/classe.ssh.php');

protegePagina("user");


if(isset($_GET['requisicao'])){

$eubusca = "SELECT * FROM usuario where id_usuario='".$_SESSION['usuarioID']."'";
$eubusca = $conn->prepare($eubusca);
$eubusca->execute();
$eu=$eubusca->fetch();

if($_GET['requisicao']==1){
$SQLSub = "SELECT * FROM usuario_ssh where id_usuario='".$_SESSION['usuarioID']."'";
$SQLSub = $conn->prepare($SQLSub);
$SQLSub->execute();

if(($SQLSub->rowCount()) > 0){
while($rowSub = $SQLSub->fetch()) {

if($rowSub['online']>0){

$SQLdono = "SELECT * FROM usuario where id_usuario='".$rowSub['id_usuario']."'";
$SQLdono = $conn->prepare($SQLdono);
$SQLdono->execute();
$dono=$SQLdono->fetch();
?>

<div class="row" id="table-hover-animation">
    <div class="col-12">
        <div class="card mb-1">
            <div class="card-content mb-0">
                <div class="card-body p-0">
                    <div class="table-responsive mb-0">
                      <a href="?page=ssh/editar&id_ssh=<?php echo $rowSub['id_usuario_ssh'];?>">
                        <table class="table table-hover-animation mb-0">
                            <thead>
                                <tr>
                                    <th scope="col">Quant</th>
                                    <th scope="col">Login</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                  <th scope="row" color="black"><b><i class="success fa fa-circle"></i> <?php echo $rowSub['online'];?> / <?php echo $rowSub['acesso'];?> </b></th>
                                  <th scope="row" color="black"><?php echo $rowSub['login'];?></th>
                                </tr>
                            </tbody>
                        </table>
                      </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php
}

}

if($eu['tipo']=='revenda'){
$SQLSubuser = "SELECT * FROM usuario where id_mestre='".$_SESSION['usuarioID']."' and subrevenda='nao'";
$SQLSubuser = $conn->prepare($SQLSubuser);
$SQLSubuser->execute();

if(($SQLSubuser->rowCount()) > 0){
while($subus = $SQLSubuser->fetch()) {


$SQLSubssh = "SELECT * FROM usuario_ssh where id_usuario='".$subus['id_usuario']."'";
$SQLSubssh = $conn->prepare($SQLSubssh);
$SQLSubssh->execute();

if(($SQLSubssh->rowCount()) > 0){
while($subussh = $SQLSubssh->fetch()) {


if($subussh['online']>0){

$SQLdono = "SELECT * FROM usuario where id_usuario='".$subussh['id_usuario']."'";
$SQLdono = $conn->prepare($SQLdono);
$SQLdono->execute();
$dono=$SQLdono->fetch();
?>
                      <div class="row" id="table-responsive">
                          <div class="col-12">
                              <div class="card">
                                  <div class="card-content">
                                      <a href="?page=ssh/editar&id_ssh=<?php echo $subussh['id_usuario_ssh'];?>">
                                      <table class="table table-responsive mb-0 text-md-center">
                                          <thead>
                                          <tr>
                                              <th scope="col">Quant.</th>
                                              <th scope="col">Login</th>
                                              <th scope="col">Dono</th>
                                          </tr>
                                          </thead>
                                          <tbody>
                                          <tr>
                                              <th scope="row" color="black"><b><i class="success fa fa-circle"></i> <?php echo $subussh['online'];?> / <?php echo $subussh['acesso'];?> </b></th>
                                              <th scope="row" color="black"><?php echo $subussh['login'];?></th>
                                              <th scope="row" color="black">Meu</th>
                                          </tr>
                                          </tbody>
                                      </table>
                                  </div>
                                  </a>
                              </div>
                          </div>
                      </div>

<?php
}


}
}

}
}

}

}

}elseif($_GET['requisicao']==2){


$total_acesso_ssh_online = 0;
$SQLAcessoSSH = "SELECT sum(online) AS quantidade  FROM usuario_ssh  where id_usuario='".$_SESSION['usuarioID']."'";
$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
$SQLAcessoSSH->execute();
$SQLAcessoSSH = $SQLAcessoSSH->fetch();
$total_acesso_ssh_online += $SQLAcessoSSH['quantidade'];

if($eu['tipo']=='revenda'){
$SQLSub= "select * from usuario WHERE id_mestre = '".$_SESSION['usuarioID']."' and subrevenda='nao'";
$SQLSub = $conn->prepare($SQLSub);
$SQLSub->execute();

if (($SQLSub->rowCount()) > 0) {

                while($row = $SQLSub->fetch()) {

                    $SQLAcessoSSHon = "SELECT sum(online) AS quantidade  FROM usuario_ssh  where id_usuario='".$row['id_usuario']."' ";
                    $SQLAcessoSSHon = $conn->prepare($SQLAcessoSSHon);
                    $SQLAcessoSSHon->execute();
		            $SQLAcessoSSHon = $SQLAcessoSSHon->fetch();
                    $total_acesso_ssh_online += $SQLAcessoSSHon['quantidade'];

}
}


}

echo $total_acesso_ssh_online;

}


}

?>
