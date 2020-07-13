<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

if(isset($_POST['servidor'])){

$serverid=sql_injector($_POST['servidor']);

//Procura Servidor
$SQLUsuarioserver = "select * from servidor WHERE tipo='free' and id_servidor = '".$serverid."'";
$SQLUsuarioserver = $conn->prepare($SQLUsuarioserver);
$SQLUsuarioserver->execute();
$server=$SQLUsuarioserver->fetch();

  if($SQLUsuarioserver->rowCount()==0){
						echo '<script type="text/javascript">';
		                echo 	'alert("Servidor não encontrado!");';
		            	echo	'window.location="../../home.php?page=ssh/contas_free";';
		             	echo '</script>';
		            	exit;

  }
                // verifica se tem usuarios e faz loop
                $SQLUsuarioSSH = "select * from usuario_ssh_free WHERE servidor = '".$serverid."'";
                $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
                $SQLUsuarioSSH->execute();

                if($SQLUsuarioSSH->rowCount()==0){
						echo '<script type="text/javascript">';
		                echo 	'alert("Não tem nenhuma conta neste servidor!");';
		            	echo	'window.location="../../home.php?page=ssh/contas_free";';
		             	echo '</script>';
		            	exit;

               }

               // Faz loop
               while($usuario=$SQLUsuarioSSH->fetch()){

		       //Realiza a comunicacao com o servidor
			   $ip_servidor= $server['ip_servidor'];
		       $loginSSH= $server['login_server'];
			   $senhaSSH=  $server['senha'];
			   $ssh = new SSH2($ip_servidor);
			   $ssh->auth($loginSSH,$senhaSSH);

			   $ssh->exec("./remover.sh ".$usuario['login']." ");
		       $mensagem = (string) $ssh->output();

               $SQLSSHfinal = "delete  from usuario_ssh_free  WHERE id = '".$usuario['id']."'  ";
               $SQLSSHfinal = $conn->prepare($SQLSSHfinal);
               $SQLSSHfinal->execute();

                        echo '<script type="text/javascript">';
		                echo 	'alert("Todas contas foram excluidas");';
		            	echo	'window.location="../../home.php?page=ssh/contas_free";';
		             	echo '</script>';


               }














}






?>