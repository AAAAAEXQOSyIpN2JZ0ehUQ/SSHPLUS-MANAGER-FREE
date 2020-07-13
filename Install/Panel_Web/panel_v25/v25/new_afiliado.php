<?php
require_once '/var/www/html/pages/system/seguranca.php';
require_once '/var/www/html/pages/system/config.php';
require_once('/var/www/html/pages/system/classe.ssh.php');

	    function geraToken(){
				

					$salt = "vip10";
					srand((double)microtime()*1000000); 

					$i = 0;
                    $pass = 0;
					while($i <= 7){

						$num = rand() % 10;
						$tmp = substr($salt, $num, 1);
						$pass = $pass . $tmp;
						$i++;

					}
					
					
					

					return $pass;

				}
				
	    function geraSenha(){
				

					$salt = "1234";
					srand((double)microtime()*1000000); 

					$i = 0;
                    $pass = 0;
					while($i <= 7){

						$num = rand() % 10;
						$tmp = substr($salt, $num, 1);
						$pass = $pass . $tmp;
						$i++;

					}
					
					
					

					return $pass;

				}
	
	
		if((isset($_POST["nome"])) and (isset($_POST["login_sistema"])) 
			                        and (isset($_POST["senha_sistema"])) 
			                       and (isset($_POST["celular"])) 
							       and (isset($_POST["tipo"]))  
								   and (isset($_POST["p"]))
								   and (isset($_POST["owner"]))
								   and (isset($_POST["login_ssh"]))   
								   
								   ){
                  $owner = $_POST["owner"];
				
		
			$SQLUsuario = "select * from usuario WHERE login = '".$_POST['login_sistema']."'";
            $SQLUsuario = $conn->prepare($SQLUsuario);
            $SQLUsuario->execute();
       
			if(($SQLUsuario->rowCount()) == 0){
				
				            $SQLServidor = "select * from servidor WHERE demo = '1' LIMIT 1";
                            $SQLServidor = $conn->prepare($SQLServidor);
                            $SQLServidor->execute();
				            $servidor =  $SQLServidor->fetch();
							
				            $dias_acesso = $servidor['dias'];
							$acessos = 1;
							   
                            
							$data =  date("Y-m-d H:i:s");
							$expira= date('Y-m-d', strtotime(' + '.$dias_acesso.'  days'));
				            $token = geraToken();	
                           
							
				            $SQLInsertUsuario = "INSERT INTO usuario (validade, login, senha, data_cadastro, tipo, nome, celular, 	token_user, id_mestre)
                                        VALUES ('{$expira}','".$_POST['login_sistema']."', '".$_POST["senha_sistema"]."',  
										        '$data', '".$_POST['tipo']."', '".$_POST['nome']."',
												'".$_POST['celular']."', '{$token}', '".$owner."' )";
                            $SQLInsertUsuario = $conn->prepare($SQLInsertUsuario);
                            $SQLInsertUsuario->execute();
							
							$SQLResID = "SELECT LAST_INSERT_ID() AS last_id";                     	
                            $SQLResID = $conn->prepare($SQLResID);
                            $SQLResID->execute();
                            $id = $SQLResID->fetch();
				 
							
							
							
							
							$ip_servidorSSH= $servidor['ip_servidor'];
                            $loginSSH= $servidor['login_server'];
	                        $senhaSSH=  $servidor['senha'];
	                        
							$senha_ssh = geraSenha();
					        $login_ssh = $_POST['login_ssh'];
	                        $ssh = new SSH2($ip_servidorSSH); 
	                        $ssh->auth($loginSSH,$senhaSSH); 
                            $ssh->exec("./criarusuario.sh ".$login_ssh." ".$senha_ssh." ".$dias_acesso." 1 ");
	                        $mensagem = (string) $ssh->output();
							
							
							if($mensagem == 13){
							$ssh->exec("./AlterarSenha.sh ".$login_ssh." ".$senha_ssh." ");
                            $mensagem_passwd = (string) $ssh->output();	
		
        $expira= date('Y-m-d', strtotime(' + '.$dias_acesso.'  days'));
		$SQLContaSSH = "INSERT INTO usuario_ssh (status, id_usuario, id_servidor, login, senha,  data_validade, acesso)
                                                VALUES ('1', '".$id['last_id']."', '".$servidor['id_servidor']."', '".$_POST["login_ssh"]."', '".$senha_ssh."', '".$expira."', '1' )";
                                                    	
        $SQLContaSSH = $conn->prepare($SQLContaSSH);
        $SQLContaSSH->execute();
		
		$mensagem_sms = "Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ".$ip_servidorSSH." Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: ".$_POST['login_ssh']." senha ssh: ".$senha_ssh;
		$SQLSMS = "insert into sms (id_remetente, id_destinatario, assunto, mensagem) 
				                    VALUES ('".$owner."', '".$id['last_id']."', 'Dados SSH', '".$mensagem_sms."')  ";
        $SQLSMS = $conn->prepare($SQLSMS);
        $SQLSMS->execute();			

        $mensagem_sms = "Seja Bem vindo! @SuperSSH Dados do painel: IP->".$endereco_web." Login-> ".$_POST['login_sistema']." Senha->".$_POST["senha_sistema"];
		$SQLSMS = "insert into sms (id_remetente, id_destinatario, assunto, mensagem) 
		  VALUES ('".$owner."', '".$id['last_id']."', 'Seja Bem Vindo', '".$mensagem_sms."')  ";
         $SQLSMS = $conn->prepare($SQLSMS);
         $SQLSMS->execute();	
      	 
								
	   }else{
		$ssh->exec("./remover.sh ".$_POST["login_ssh"]." ");
	    $mensagem = (string) $ssh->output();
		$SQLSSH = "delete  from usuario  WHERE id_usuario = '".$id['last_id']."'  ";
        $SQLSSH = $conn->prepare($SQLSSH);
        $SQLSSH->execute();
		
	   }
	
							
							
								switch($mensagem){
			case 0:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Cadastro Indisponivel no Momento!");';
		       echo	'window.location="index.php";';
		       echo '</script>';
			break;
			
			case 1:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Este login ssh e invalido!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 2:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Cadastro Indisponivel no Momento!");';
		       echo	'window.location="index.php";';
		       echo '</script>';
			break;
			
			case 3:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Este login  e muito grande!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 4:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Campo Login esta vazio!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 5:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Campo senha esta vazio!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 6:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Senha muito curta!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 7:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Dias invalido!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 8:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Dias vazio!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 9:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Dias deve ser maior que zero!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 10:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Acessos invalido");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 11:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Campo acessos vazio");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 12:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Campo acessos deve ser maior que zero");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			case 13:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Criado com sucesso!");';
			   echo	'window.location="index.php";';
		       echo '</script>';
			break;
			
			case 14:
			   echo '<script type="text/javascript">';
		       echo 	'alert("Erro ao criar!");';
		       echo	'window.location="login.php";';
		       echo '</script>';
			break;
			
			 default:
                 echo '<script type="text/javascript">';
		         echo 	'alert("Houve um erro inesperado, tente novamente.");';
		         echo	'window.location="login.php";';
		         echo '</script>';
            break;
			
			
		}
	

				
			
			}else{
			echo '<script type="text/javascript">';
			echo 	'alert("Usuario do sistema ja existe!");';
			echo	'window.location="new.php?p='.$_POST['p'].'";';
			echo '</script>';
		}
		

	   }else{
		   			echo '<script type="text/javascript">';
			echo 	'alert("Preencha todos os campos!");';
			echo	'window.location="new.php?p='.$_POST['p'].'";';
			echo '</script>';
	   }
	
	
	?>