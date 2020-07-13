<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

	function geraToken(){
				

					$salt = "123456ABCDER";
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
				$data =  date("Y-m-d H:i:s");
				$token = geraToken();
				
		if((isset($_POST["login"])) and (isset($_POST["nome"])) and (isset($_POST["senha"]))  and (isset($_POST["tipo"]))  and (isset($_POST["celular"])) ){
		
			$SQLUsuario = "select * from usuario WHERE login = '".$_POST['login']."' ";
            $SQLUsuario = $conn->prepare($SQLUsuario);
            $SQLUsuario->execute();
	   
			if(($SQLUsuario->rowCount()) > 0){
				echo '<script type="text/javascript">';
			echo 	'alert("O usuario '.$_POST['login'].' ja existe!");';
			echo	'window.location="../../home.php?page=usuario/1-etapa";';
			echo '</script>';
			}else{
				
				
				
				
                
				
				
                $SQLUsuario = "INSERT INTO usuario (login, senha, data_cadastro, tipo, nome, celular, 	token_user)
              VALUES ('".$_POST['login']."', '".$_POST['senha']."',  '$data', '".$_POST['tipo']."', '".$_POST['nome']."', '".$_POST['celular']."', '{$token}' )";
                $SQLUsuario = $conn->prepare($SQLUsuario);
                 $SQLUsuario->execute();
			
               
				$SQLUsuario = "SELECT LAST_INSERT_ID() AS last_id ";
                $SQLUsuario = $conn->prepare($SQLUsuario);
                $SQLUsuario->execute();
                 $id = $SQLUsuario->fetch();
                echo '<script type="text/javascript">';
	     		echo 	'alert("O usuario '.$_POST['login'].' foi criado com sucesso!");';
		     	echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$id['last_id'] .' ";';
		    	echo '</script>';
			
			
                



				
			}
			
		}else{
			echo '<script type="text/javascript">';
			echo 	'alert("Preencha todos os campos!");';
			echo	'window.location="../../home.php?page=usuario/1-etapa";';
			echo '</script>';
			
		}
		

	
	

	?>