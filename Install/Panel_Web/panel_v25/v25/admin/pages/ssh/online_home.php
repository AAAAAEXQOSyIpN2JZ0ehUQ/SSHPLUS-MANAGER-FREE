<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

if(isset($_GET['requisicao'])){


if($_GET['requisicao']==1){
$SQLSub = "SELECT * FROM usuario_ssh";
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
                                    <th scope="col">Dono</th>
                                    <th scope="col">Login</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                  <th scope="row"><b><i class="success fa fa-circle"></i> <?php echo $rowSub['online'];?> / <?php echo $rowSub['acesso'];?></b></th>
                                  <th scope="row"><?php echo $dono['nome'];?></th>
                                  <th scope="row"><?php echo $rowSub['login'];?></th>
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


}

}elseif($_GET['requisicao']==2){


$total_acesso_ssh_online = 0;
$SQLAcessoSSH = "SELECT sum(online) AS quantidade  FROM usuario_ssh  ";
$SQLAcessoSSH = $conn->prepare($SQLAcessoSSH);
$SQLAcessoSSH->execute();
$SQLAcessoSSH = $SQLAcessoSSH->fetch();
$total_acesso_ssh_online += $SQLAcessoSSH['quantidade'];

echo $total_acesso_ssh_online;

}


}

?>
