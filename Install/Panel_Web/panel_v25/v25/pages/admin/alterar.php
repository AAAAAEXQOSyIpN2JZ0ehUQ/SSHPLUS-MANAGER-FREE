<?php
require_once("../system/funcoes.php");
require_once("../system/seguranca.php");
require_once("../system/config.php");


protegePagina();

if((isset($_POST["nome"])) and (isset($_POST["email"]))  ){
	        $nome = anti_sql_injection($_POST["nome"]);
			$email = anti_sql_injection($_POST["email"]);
			$senha = anti_sql_injection($_POST["senha"]);
			// mercado pago
			$idcliente = anti_sql_injection($_POST["idcliente"]);
			$token = anti_sql_injection($_POST["tokensecreto"]);
			$bancarios = anti_sql_injection($_POST["bancarios"]);

			if(strlen($senha)<3){
				echo '<script type="text/javascript">';
			    echo 	'alert("Senha muito curta!");';
			    echo	'window.location="../../home.php?page=admin/dados";';
			    echo '</script>';
			    exit;
			}


			$SQLUsuario = "SELECT * FROM usuario WHERE id_usuario = '".$_SESSION['usuarioID']."'";
            $SQLUsuario = $conn->prepare($SQLUsuario);
            $SQLUsuario->execute();

		    if(($SQLUsuario->rowCount()) > 0){
		        $eu=$SQLUsuario->fetch();

		        if($eu['tipo']=='revenda'){
		        $SQLUPUsuario = "update usuario set nome='".$nome."', email='".$email."', senha='".$senha."',idcliente_mp='".$idcliente."',tokensecret_mp='".$token."',dadosdeposito='".$bancarios."', atualiza_dados='1' WHERE id_usuario = '".$_SESSION['usuarioID']."'";
                $SQLUPUsuario = $conn->prepare($SQLUPUsuario);
                $SQLUPUsuario->execute();
		        }else{
				$SQLUPUsuario = "update usuario set nome='".$nome."', email='".$email."', senha='".$senha."', atualiza_dados='1' WHERE id_usuario = '".$_SESSION['usuarioID']."'";
                $SQLUPUsuario = $conn->prepare($SQLUPUsuario);
                $SQLUPUsuario->execute();
                }
						     echo '<script type="text/javascript">';
			                 echo 	'alert("Alterado com sucesso!");';
			                 echo	'window.location="../../home.php";';
			                 echo '</script>';
			}else{
			    echo '<script type="text/javascript">';
			    echo 	'alert("Nao permitido!");';
			    echo	'window.location="../../home.php?page=admin/dados";';
			    echo '</script>';
			}

		}else{
			    echo '<script type="text/javascript">';
			    echo 	'alert("Preencha!");';
			    echo	'window.location="../../home.php?page=admin/dados";';
			    echo '</script>';
		}
?>
