<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");


		if( (isset($_POST["val"])) and(isset($_POST["usuario"])) and ($_POST["servidor"]!=0) ){

            if(!is_numeric($_POST['val'])){
		            echo '<script type="text/javascript">';
	        		echo 	'alert("Somente valores numericos!");';
		        	echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$_POST['usuario'] .' ";';
		        	echo '</script>';
		        	exit;

		    }


			$SQLAcesso = "select * from acesso_servidor WHERE id_acesso_servidor = '".$_POST['servidor']."' and id_usuario='".$_POST['usuario']."'";
            $SQLAcesso = $conn->prepare($SQLAcesso);
            $SQLAcesso->execute();

			if(($SQLAcesso->rowCount()) <= 0){
				echo '<script type="text/javascript">';
			echo 	'alert("O Cliente não possui este servidor!");';
			echo	'window.location="../../home.php?page=usuario/listar";';
			echo '</script>';
			}else{
            $servido=$SQLAcesso->fetch();
            $postacesso=$_POST['acesso'];
            $remove=$_POST['racesso'];

            if(!is_numeric($postacesso)){            echo '<script type="text/javascript">';
			echo 	'alert("Numero de acesso invalido!");';
			echo	'window.location="../../home.php?page=usuario/listar";';
			echo '</script>';
			exit;            }
            if(!is_numeric($remove)){
            echo '<script type="text/javascript">';
			echo 	'alert("Numero de acesso invalido!");';
			echo	'window.location="../../home.php?page=usuario/listar";';
			echo '</script>';
			exit;
            }


            if($remove>0){
            $limite_servidor=$servido['qtd'];
            $acessos=$remove;
            $contas_ssh_criadas=0;


            //Carrega contas SSH dele "acessos"
		    $SQLContasSSH = "SELECT sum(acesso) AS quantidade  FROM usuario_ssh where id_servidor = '".$servido["id_servidor"]."' and id_usuario='".$_POST["usuario"]."' ";
            $SQLContasSSH = $conn->prepare($SQLContasSSH);
            $SQLContasSSH->execute();
		    $SQLContasSSH = $SQLContasSSH->fetch();
            $contas_ssh_criadas += $SQLContasSSH['quantidade'];


            //Carrega usuario sub
		    $SQLUsuarioSub = "SELECT * FROM usuario WHERE id_mestre ='".$_POST["usuario"]."'";
            $SQLUsuarioSub = $conn->prepare($SQLUsuarioSub);
            $SQLUsuarioSub->execute();


		    if (($SQLUsuarioSub->rowCount()) > 0) {
				 while($row = $SQLUsuarioSub->fetch()) {
				$SQLSubSSH= "select sum(acesso) AS quantidade  from usuario_ssh WHERE id_usuario = '".$row['id_usuario']."' and id_servidor='".$servido["id_servidor"]."' ";
                $SQLSubSSH = $conn->prepare($SQLSubSSH);
                $SQLSubSSH->execute();
				$SQLSubSSH = $SQLSubSSH->fetch();
			    $contas_ssh_criadas += $SQLSubSSH['quantidade'];

			}

		    }

		    if( ($limite_servidor-$acessos) < $contas_ssh_criadas  ){
                    $soma=$limite_servidor-$contas_ssh_criadas;
				    echo '<script type="text/javascript">';
		            echo 	'alert("Você não pode tirar esses limites ele criou mais!\n Criados: '.$contas_ssh_criadas.' Acessos \n Pode Tirar: '.$soma.' \n Limite de Acessos: '.$limite_servidor.'");';
			        echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$_POST['usuario'] .' ";';
			        echo '</script>';
			        exit;

		    }

            $SQLserver = "select * from servidor WHERE id_servidor = '".$servido['id_servidor']."'";
            $SQLserver = $conn->prepare($SQLserver);
            $SQLserver->execute();
            $server=$SQLserver->fetch();
            //Insere notificacao

            $msg="Servidor Modificado <small><b>".$server['ip_servidor']."</b></small> Veja as alterações: <small><i><b><a href=\"../home.php?page=servidor/meuservidor\">Veja</a></b></i></small>  !";
            $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$_POST["usuario"]."','".date('Y-m-d H:i:s')."','outros','Admin','".$msg."')";
            $notins = $conn->prepare($notins);
            $notins->execute();


                if($_POST['val']==0){                $addvalidade='';
                }else{                if($servido['validade']<=date('Y-m-d')){                $add=date('Y-m-d',strtotime('+ '.$_POST['val'].' days'));
                }else{
                $validadeatual=$servido['validade'];
                $add=date('Y-m-d',strtotime('+ '.$_POST['val'].' days'),strtotime($validadeatual));
                }
                $addvalidade="validade='".$add."',";
                }


                $InsertAcesso = "UPDATE acesso_servidor set ".$addvalidade." qtd=qtd-'".$acessos."' where id_acesso_servidor='".$_POST['servidor']."' and id_usuario='".$_POST["usuario"]."'";
                $InsertAcesso = $conn->prepare($InsertAcesso);
                $InsertAcesso->execute();


                    echo '<script type="text/javascript">';
	        		echo 	'alert("Servidor Editado com sucesso!");';
		        	echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$_POST['usuario'] .' ";';
		        	echo '</script>';

		    }else{

		        if($_POST['val']==0){
                $addvalidade='';
                }else{
                if($servido['validade']<=date('Y-m-d')){
                $add=date('Y-m-d',strtotime('+ '.$_POST['val'].' days'));
                }else{
                $validadeatual=$servido['validade'];
                $add=date('Y-m-d', strtotime('+ '.$_POST['val'].' days', strtotime($validadeatual)));
                }
                $addvalidade="validade='".$add."',";
                }
		    $InsertAcesso = "UPDATE acesso_servidor set ".$addvalidade." qtd=qtd+'".$postacesso."' where id_acesso_servidor='".$_POST['servidor']."' and id_usuario='".$_POST["usuario"]."'";
            $InsertAcesso = $conn->prepare($InsertAcesso);
            $InsertAcesso->execute();


            $SQLserver = "select * from servidor WHERE id_servidor = '".$servido['id_servidor']."'";
            $SQLserver = $conn->prepare($SQLserver);
            $SQLserver->execute();
            $server=$SQLserver->fetch();
            //Insere notificacao

            $msg="Servidor Modificado <small><b>".$server['ip_servidor']."</b></small> Veja as alterações: <small><i><b><a href=\"../home.php?page=servidor/meuservidor\">Veja</a></b></i></small>  !";
            $notins = "INSERT INTO notificacoes (usuario_id,data,tipo,linkfatura,mensagem) values ('".$_POST["usuario"]."','".date('Y-m-d H:i:s')."','outros','Admin','".$msg."')";
            $notins = $conn->prepare($notins);
            $notins->execute();



                    echo '<script type="text/javascript">';
	        		echo 	'alert("Servidor Editado com sucesso!");';
		        	echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$_POST['usuario'] .' ";';
		        	echo '</script>';


		    }




			}

		}else{
			echo '<script type="text/javascript">';
			echo 	'alert("Preencha todos os campos!");';
			echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$_POST['usuario'] .' ";';
			echo '</script>';

		}



			?>