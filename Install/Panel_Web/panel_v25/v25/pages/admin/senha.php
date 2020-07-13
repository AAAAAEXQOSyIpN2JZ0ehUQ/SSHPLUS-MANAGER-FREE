<?php
require_once("../system/funcoes.php");
require_once("../system/seguranca.php");
require_once("../system/config.php");
protegePagina();
 

	
		if(isset($_POST["senha"]) ){
			$senha = $_POST["senha"];
			$SQLUsuario = "SELECT * FROM usuario WHERE id_usuario = '".$_SESSION['usuarioID']."'";
            $SQLUsuario = $conn->prepare($SQLUsuario);
            $SQLUsuario->execute();
			
		
		     if(($SQLUsuario->rowCount()) > 0){
				$SQLUPUsuario = "update usuario set senha='".$senha."' WHERE id_usuario = '".$_SESSION['usuarioID']."'";
                $SQLUPUsuario = $conn->prepare($SQLUPUsuario);
                $SQLUPUsuario->execute();
				
						     echo '<script type="text/javascript">';
			                 echo 	'alert("Alterado com sucesso!");';
			                 echo	'window.location="../../home.php?page=admin/dados";';
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