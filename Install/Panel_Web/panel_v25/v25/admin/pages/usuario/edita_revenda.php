<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

protegePagina("admin");


if(isset($_POST['idservidoracesso'])){


#Posts
$servidor=$_POST['idservidoracesso'];
$fazer=$_POST['addremove'];
$dias=$_POST['dias'];
$limite=$_POST['limite'];

$SQLAcesso = "select * from acesso_servidor where id_acesso_servidor = '".$servidor."'";
$SQLAcesso = $conn->prepare($SQLAcesso);
$SQLAcesso->execute();

if($SQLAcesso->rowCount()==0){
echo '<script type="text/javascript">';
echo 	'alert("Servidor não encontrado");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}

$server=$SQLAcesso->fetch();

$SQLusuario = "select * from usuario where id_usuario = '".$server['id_usuario']."' and subrevenda='sim'";
$SQLusuario = $conn->prepare($SQLusuario);
$SQLusuario->execute();

if($SQLusuario->rowCount()>0){
echo '<script type="text/javascript">';
echo 	'alert("Este usuario é um subrevendedor");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}

if(!is_numeric($limite)){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}
if(!is_numeric($dias)){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}
if($dias<0){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número valido!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}

switch($fazer){case 1:$vaifazer='addacesso';break;
case 2:$vaifazer='removeacesso';break;
case 3:$vaifazer='removedias';break;
default:$vaifazer='erro';break;
}



if($vaifazer=='erro'){echo '<script type="text/javascript">';
echo 	'alert("Digite um número valido!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}

if($vaifazer=='addacesso'){

$add=date('Y-m-d', strtotime('+'.$dias.' days', strtotime($server['validade'])));

//Sucesso
$SQLSucesso = "update acesso_servidor set qtd=qtd+'".$limite."',validade='".$add."' where id_acesso_servidor='".$servidor."'";
$SQLSucesso = $conn->prepare($SQLSucesso);
$SQLSucesso->execute();


$SQLserverdr = "select * from servidor WHERE id_servidor = '".$servidor."'";
$SQLserverdr = $conn->prepare($SQLserverdr);
$SQLserverdr->execute();
$serverdor=$SQLserverdr->fetch();
//Insere notificacao
$msg="O Administrador Editou Seu Servidor <b>".$serverdor['nome']."</b> Visualize nos seus servidores alocados!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$server['id_usuario']."','".date('Y-m-d H:i:s')."','revenda','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();


echo '<script type="text/javascript">';
echo 	'alert("Alteração Efetuada com sucesso!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';

}elseif($vaifazer=='removeacesso'){

if($limite<=0){
echo '<script type="text/javascript">';
echo 	'alert("Digite um número maior que 0!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';
exit;
}
//Carrega contas SSH criadas
$SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$server['id_servidor']."' and id_usuario='".$server['id_usuario']."' ";
$SQLContasSSH = $conn->prepare($SQLContasSSH);
$SQLContasSSH->execute();
$SQLContasSSH = $SQLContasSSH->fetch();
$contas_ssh_criadas += $SQLContasSSH['quantidade'];

	    //Carrega usuario sub
		$SQLUsuarioSub = "SELECT * FROM usuario WHERE id_mestre ='".$server['id_usuario']."' and subrevenda='nao'";
        $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
        $SQLUsuarioSub->execute();


		if (($SQLUsuarioSub->rowCount()) > 0) {
				while($row = $SQLUsuarioSub->fetch()) {
				$SQLSubSSH= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$server['id_servidor']."' ";
                $SQLSubSSH = $conn->prepare($SQLSubSSH);
                $SQLSubSSH->execute();
				$SQLSubSSH = $SQLSubSSH->fetch();
			    $contas_ssh_criadas += $SQLSubSSH['quantidade'];

			}

		}

if($limite<>0){
$limiteservidor=$server['qtd'];
$soma=$limiteservidor-$contas_ssh_criadas;
if($soma<=0){
$soma=0;
}


if($soma<$limite){

				echo '<script type="text/javascript">';
		            echo 	'alert("Você não pode tirar isso tudo!\n\n Quantidade Permitida: '.$soma.'");';
			        echo	'window.location="../../home.php?page=servidor/alocados";';
			        echo '</script>';
			        exit;

		}


//Sucesso
$SQLSucesso = "update acesso_servidor set qtd=qtd-'".$limite."' where id_acesso_servidor='".$servidor."'";
$SQLSucesso = $conn->prepare($SQLSucesso);
$SQLSucesso->execute();

$SQLserverdr = "select * from servidor WHERE id_servidor = '".$server['id_servidor']."'";
$SQLserverdr = $conn->prepare($SQLserverdr);
$SQLserverdr->execute();
$serverdor=$SQLserverdr->fetch();
//Insere notificacao
$msg="O Administrador Editou Seu Servidor <b>".$serverdor['nome']."</b> Tirou <b>".$limite."</b> de acessos!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$server['id_usuario']."','".date('Y-m-d H:i:s')."','revenda','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();


echo '<script type="text/javascript">';
echo 	'alert("Alteração Efetuada com sucesso!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';


}

}elseif($vaifazer=='removedias'){

$add2=date('Y-m-d', strtotime('-'.$dias.' days', strtotime($server['validade'])));$data=$add2;
if($data<date('Y-m-d')){$add2=date('Y-m-d');
}

//Sucesso
$SQLSucesso = "update acesso_servidor set validade='".$add2."' where id_acesso_servidor='".$servidor."'";
$SQLSucesso = $conn->prepare($SQLSucesso);
$SQLSucesso->execute();

$SQLserverdr = "select * from servidor WHERE id_servidor = '".$server['id_servidor']."'";
$SQLserverdr = $conn->prepare($SQLserverdr);
$SQLserverdr->execute();
$serverdor=$SQLserverdr->fetch();
//Insere notificacao
$msg="O Administrador Editou Seu Servidor <b>".$serverdor['nome']."</b> Tirou <b>".$dias."</b> de dias de validade!";
$notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$server['id_usuario']."','".date('Y-m-d H:i:s')."','revenda','Admin','".$msg."')";
$notins = $conn->prepare($notins);
$notins->execute();


echo '<script type="text/javascript">';
echo 	'alert("Alteração Efetuada com sucesso!");';
echo	'window.location="../../home.php?page=servidor/alocados";';
echo '</script>';

}



}