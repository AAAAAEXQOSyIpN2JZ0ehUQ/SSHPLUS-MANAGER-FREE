<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");


if(  (isset($_GET["op"])) && (isset($_GET["id_servidor"]))   ){

	$operacao = $_GET["op"];

    $SQLServidor = "select * from servidor WHERE id_servidor = '".$_GET['id_servidor']."'  ";
    $SQLServidor = $conn->prepare($SQLServidor);
    $SQLServidor->execute();
	$servidor = $SQLServidor->fetch();



	//Realiza a comunicacao com o servidor
			$ip_servidor= $servidor['ip_servidor'];
		    $loginSSH= $servidor['login_server'];
			$senhaSSH=  $servidor['senha'];
			$ssh = new SSH2($ip_servidor);
			$ssh->auth($loginSSH,$senhaSSH);


	if($operacao == "reiniciar" ){
		$ssh->exec(" reboot ");
	    $ssh->output();
		echo '<script type="text/javascript">';
	     		echo 	'alert("Comando enviado!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';

	}elseif($operacao == "updateScript" ){
	   $updatescript = "select * from admin";
	   $updatescript = $conn->prepare($updatescript);
       $updatescript->execute();
	   $updatando = $updatescript->fetch();

	   if($updatando['site']==''){
	   	        echo '<script type="text/javascript">';
	     		echo 	'alert("Primeiro Configure o site dos arquivos em configurações da conta administrativa!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';
		    	exit;
	   }

	    // Link do dominio VIP-VPS
	    //$link=$updatando['site'];

		//$ssh->exec(" wget http://painelweb.tk/painelssh/instt.sh "); 
				//$ssh->output();
				//$ssh->exec(" chmod 777 instt.sh ");
				//$ssh->output();
				//$ssh->exec(" sed -i -e 's/\r$//' instt.sh ");
				//$ssh->output();
				//$ssh->exec(" ./instt.sh ");
				//$ssh->output();

        // Link do seu dominio VIP-VPS
		$link=$updatando['site'];
		$ssh->exec(" cd /root ");
	    $ssh->output();
		$ssh->exec(" rm alterarlimite.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/alterarlimite.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 alterarlimite.sh ");
	    $ssh->output();
		$ssh->exec(" rm  AlterarSenha.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/AlterarSenha.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 AlterarSenha.sh ");
	    $ssh->output();
		$ssh->exec(" rm criarusuario.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/criarusuario.sh ");
	    $ssh->output();
		$ssh->exec(" chmod 777 criarusuario.sh ");
	    $ssh->output();
		$ssh->exec(" rm remover.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/remover.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 remover.sh ");
	    $ssh->output();
		$ssh->exec(" rm sshlimiter.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/sshlimiter.sh ");
	    $ssh->output();
		$ssh->exec(" chmod 777 sshlimiter.sh ");
	    $ssh->output();
		$ssh->exec(" rm AlterarData.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/AlterarData.sh ");
	    $ssh->output();
		$ssh->exec(" chmod 777 AlterarData.sh ");
	    $ssh->output();
		$ssh->exec(" rm sshmonitor.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/sshmonitor.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 sshmonitor.sh ");
	    $ssh->output();
		$ssh->exec(" rm KillUser.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/KillUser.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 KillUser.sh ");
	    $ssh->output();
		
		echo '<script type="text/javascript">';
	     		echo 	'alert(" Painel-web Sincronizado!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';

	}elseif($operacao == "deligar" ){
		$ssh->exec("shutdown");
		$ssh->output();
		echo '<script type="text/javascript">';
	     		echo 	'alert("Comando enviado!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';
	}elseif($operacao == "reiniciarSquid" ){
		$ssh->exec("service squid3 restart");
		$ssh->output();
		$ssh->exec("service squid restart");
		$ssh->output();
		echo '<script type="text/javascript">';
	     		echo 	'alert("Squid Reiniciado com sucesso!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';

	}elseif($operacao == "deletarGeral" ){
		 // servidor free e premium
		 if($servidor['tipo']=='free'){
		 $SQLUsuarioSSH = "select * from usuario_ssh_free WHERE servidor = '".$servidor['id_servidor']."' ";
		 }else{
		 $SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '".$servidor['id_servidor']."' ";
		 }
         $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
         $SQLUsuarioSSH->execute();
		      if (($SQLUsuarioSSH->rowCount()) > 0) {

                   while($row = $SQLUsuarioSSH->fetch()){
					   $ssh->exec("./remover.sh ".$row['login']." ");
		               $mensagem = (string) $ssh->output();

                        if($servidor['tipo']=='free'){
			        	$SQLSSH = "delete  from usuario_ssh_free  WHERE id = '".$row['id']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                        }else{
                        $SQLSSH = "delete  from usuario_ssh  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                        }

				   }
			  }

              $SQLSSHacess = "delete from acesso_servidor  WHERE id_servidor = '".$servidor['id_servidor']."'  ";
              $SQLSSHacess = $conn->prepare($SQLSSHacess);
              $SQLSSHacess->execute();

			  $SQLSSH = "delete  from servidor  WHERE id_servidor = '".$servidor['id_servidor']."'  ";
              $SQLSSH = $conn->prepare($SQLSSH);
              $SQLSSH->execute();
		        echo '<script type="text/javascript">';
	     		echo 	'alert("Servidor deletado sucesso!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';

	}elseif($operacao == "deletarContas" ){
		 // free e premium
	     if($servidor['tipo']=='free'){
	     $SQLUsuarioSSH = "select * from usuario_ssh_free WHERE servidor = '".$servidor['id_servidor']."' ";
         }else{
         $SQLUsuarioSSH = "select * from usuario_ssh WHERE id_servidor = '".$servidor['id_servidor']."' ";
         }
         $SQLUsuarioSSH = $conn->prepare($SQLUsuarioSSH);
         $SQLUsuarioSSH->execute();
		      if (($SQLUsuarioSSH->rowCount()) > 0) {

                   while($row = $SQLUsuarioSSH->fetch()){
					   $ssh->exec("./remover.sh ".$row['login']." ");
		               $mensagem = (string) $ssh->output();

	                    if($servidor['tipo']=='free'){
			        	$SQLSSH = "delete  from usuario_ssh_free  WHERE id = '".$row['id']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                        }else{
                        $SQLSSH = "delete  from usuario_ssh  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
                        $SQLSSH = $conn->prepare($SQLSSH);
                        $SQLSSH->execute();
                        }

				   }
			  }


		  echo '<script type="text/javascript">';
	     		echo 	'alert("Contas deletadas sucesso!");';
		     	echo	'window.location="../../home.php?page=servidor/listar ";';
		    	echo '</script>';

	}elseif($operacao == "manutencao" ){
	if($servidor['manutencao']=='nao'){
	$tiramanu = "update servidor set manutencao='sim'  WHERE id_servidor = '".$servidor['id_servidor']."'  ";
    $tiramanu = $conn->prepare($tiramanu);
    $tiramanu->execute();

	echo '<script type="text/javascript">';
    echo 	'alert("Servidor colocado em Manutenção!");';
	echo	'window.location="../../home.php?page=servidor/listar ";';
    echo '</script>';

	}elseif($servidor['manutencao']=='sim'){
	$tiramanu = "update servidor set manutencao='nao'  WHERE id_servidor = '".$servidor['id_servidor']."'  ";
    $tiramanu = $conn->prepare($tiramanu);
    $tiramanu->execute();

	echo '<script type="text/javascript">';
    echo 	'alert("Servidor Retirado da Manutenção!");';
	echo	'window.location="../../home.php?page=servidor/listar ";';
    echo '</script>';
	}

	}




}else{
	echo '<script type="text/javascript">';
	     		echo 	'alert("Preencha!");';
		     	echo	'window.location="../../home.php?page=servidor/servidor&id_servidor='.$_GET['id_servidor'] .' ";';
		    	echo '</script>';

}

?>