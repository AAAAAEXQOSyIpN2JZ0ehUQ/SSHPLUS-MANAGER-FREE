<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");

	protegePagina("admin");

		if((isset($_POST["nomesrv"])) and (isset($_POST["ip"]))  and (isset($_POST["login"]))  and (isset($_POST["senha"])) and (isset($_POST["senha"]))){

		     // crzvpn@gmail.com
		     $tiposerver=$_POST['tiposerver'];
		     $localiza=$_POST['localiza'];
		     $siteserver=$_POST['siteserver'];
		     $validade=$_POST['validade'];
		     $limite=$_POST['limite'];
		     $regiao=$_POST['regiao'];
		     $site=$_POST['sitevps'];

		     if(!is_numeric($validade)){
		        echo '<script type="text/javascript">';
			    echo 	'alert("Só é permitido numeros na validade");';
			    echo	'window.location="../../home.php?page=servidor/adicionar";';
			    echo '</script>';
			    exit;
			   }

			   if(!is_numeric($limite)){
		        echo '<script type="text/javascript">';
			    echo 	'alert("Só é permitido numeros no limite");';
			    echo	'window.location="../../home.php?page=servidor/adicionar";';
			    echo '</script>';
			    exit;
			   }

			   switch($regiao){
			   case 1:$regi='asia';break;
			   case 2:$regi='america';break;
			   case 3:$regi='europa';break;
			   case 4:$regi='australia';break;
			   default:$regi='nada';break;
			   }

			    if($regi=='nada'){
		        echo '<script type="text/javascript">';
			    echo 	'alert("Selecione uma Região");';
			    echo	'window.location="../../home.php?page=servidor/adicionar";';
			    echo '</script>';
			    exit;
			   }

			 $SQLServidor = "select * from servidor WHERE ip_servidor = '".$_POST['ip']."'  ";
             $SQLServidor = $conn->prepare($SQLServidor);
             $SQLServidor->execute();
			if(($SQLServidor->rowCount()) > 0){
				echo '<script type="text/javascript">';
			    echo 	'alert("Ja existe servidor com o ip '.$_POST['ip'].'");';
			    echo	'window.location="../../home.php?page=servidor/adicionar";';
			    echo '</script>';
			 }else{
				//Realiza a comunicacao com o servidor
			$ip_servidor= $_POST['ip'];
		    $loginSSH= $_POST['login'];
			$senhaSSH=  $_POST['senha'];
			$ssh = new SSH2($ip_servidor);

			 $servidor_online = $ssh->online($_POST['ip']);
           if ($servidor_online) {
            $servidor_autenticado = $ssh->auth($_POST["login"],$_POST["senha"]);
			   if($servidor_autenticado){

			       if('freee' =='free'){
			       $tipodeservidor='free';
			       }else{
			       $tipodeservidor='premium';
			       }

				   $SQLInsert = "INSERT INTO servidor (ip_servidor, nome, login_server, senha , site_servidor , localizacao , localizacao_img , validade , limite, tipo, regiao)
                                         VALUES ('".$_POST['ip']."', '".$_POST['nomesrv']."', '".$_POST['login']."',  '".$_POST['senha']."', '".$siteserver."', '".$localiza."', '".$nome_final."', '".$validade."', '".$limite."', '".$tipodeservidor."', '".$regi."')";
             $SQLInsert = $conn->prepare($SQLInsert);
             $SQLInsert->execute();


			$SQLNServidor = "SELECT LAST_INSERT_ID() AS last_id ";
            $SQLNServidor = $conn->prepare($SQLNServidor);
            $SQLNServidor->execute();
			 $id = $SQLNServidor->fetch();

			if($_POST['tipo'] == "full"){
				$ssh->exec(" wget http://".$site."/scripts/install.sh ");
				$ssh->output();
				$ssh->exec(" chmod 777 install.sh ");
				$ssh->output();
				$ssh->exec(" chmod +x install.sh ");
				$ssh->output();
				// IP SERVIDOR
				$ipservidor = $_POST["ip"];
                $ipservidor = escapeshellarg($ipservidor);
				// SITE ARQUIVOS
				$arquivossite = $site;
                $arquivossite = escapeshellarg($arquivossite);

				$ssh->exec(" ./install.sh ".$ipservidor." ".$arquivossite);
                $ssh->output();


				echo '<script type="text/javascript">';
	     		echo 	'alert("A instalacao foi concluida!");';
		     	echo	'window.location="../../home.php?page=servidor/servidor&id_servidor='.$id['last_id'] .' ";';
		    	echo '</script>';
                // Link do dominio VIP-VPS
			}else{
				//$ssh->exec(" wget http://painelweb.tk/painelssh/instt.sh "); 
				//$ssh->output();
				//$ssh->exec(" chmod 777 instt.sh ");
				//$ssh->output();
				//$ssh->exec(" sed -i -e 's/\r$//' instt.sh ");
				//$ssh->output();
				//$ssh->exec(" ./instt.sh ");
				//$ssh->output();
				
				// Link do seu dominio VIP-VPS
		
		$ssh->exec(" cd /root ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/alterarlimite.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 alterarlimite.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/AlterarSenha.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 AlterarSenha.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/criarusuario.sh ");
	    $ssh->output();
		$ssh->exec(" chmod 777 criarusuario.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/remover.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 remover.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/sshlimiter.sh ");
	    $ssh->output();
		$ssh->exec(" chmod 777 sshlimiter.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/AlterarData.sh ");
	    $ssh->output();
		$ssh->exec(" chmod 777 AlterarData.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/sshmonitor.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 sshmonitor.sh ");
	    $ssh->output();
		$ssh->exec(" wget http://painelweb.tk/arq/KillUser.sh  ");
	    $ssh->output();
		$ssh->exec(" chmod 777 KillUser.sh ");
	    $ssh->output();
		
				echo '<script type="text/javascript">';
	     		echo 	'alert("Servidor pronto para uso!");';
		     	echo	'window.location="../../home.php?page=servidor/servidor&id_servidor='.$id['last_id'] .' ";';
		    	echo '</script>';
			}


			}else{

				echo '<script type="text/javascript">';
			    echo 	'alert("Não foi possivel logar no servidor");';
			    echo	'window.location="../../home.php?page=servidor/adicionar";';
			    echo '</script>';

		   }
	 }else{
		  echo '<script type="text/javascript">';
			    echo 	'alert("Servidor OFF");';
			    echo	'window.location="../../home.php?page=servidor/adicionar";';
			    echo '</script>';

	 }

		}

	    }else{
			echo '<script type="text/javascript">';
			echo 	'alert("Preencha todos os campos!");';
			echo	'window.location="../../home.php?page=servidor/adicionar";';
			echo '</script>';

		}


	?>

?>