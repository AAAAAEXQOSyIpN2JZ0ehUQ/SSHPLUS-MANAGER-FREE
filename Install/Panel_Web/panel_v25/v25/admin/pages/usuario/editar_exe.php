<?php

require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");

protegePagina("admin");

	    if(isset($_POST["idusuario"])){

		     if(strlen($_POST["senha"])<6){
	          echo '<script type="text/javascript">';
			                 echo 	'alert("Senha muito curta!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$_POST['idusuario'].'";';
			                 echo '</script>';
			                 exit;
		     }

			$SQLUsuario = "select * from usuario where id_usuario = '".$_POST['idusuario']."' ";
            $SQLUsuario = $conn->prepare($SQLUsuario);
            $SQLUsuario->execute();

		    if(($SQLUsuario->rowCount())>0){

				$conta_ssh = $SQLUsuario->fetch();



				$SQLUPUsuario = "update usuario set nome='".$_POST["nome"]."', email='".$_POST["email"]."', senha='".$_POST["senha"]."', celular='".$_POST["celular"]."' WHERE id_usuario = '".$_POST["idusuario"]."'";
                $SQLUPUsuario = $conn->prepare($SQLUPUsuario);
                $SQLUPUsuario->execute();
	                         echo '<script type="text/javascript">';
			                 echo 	'alert("Alterado!");';
			                 echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$conta_ssh['id_usuario'] .' ";';
			                 echo '</script>';


			}else{
				    echo '<script type="text/javascript">';
			        echo 	'alert("Conta  Nao encontrada!");';
			        echo	'window.location="../../home.php?page=usuario/listar";';
			        echo '</script>';
			}


		}else{

		        echo '<script type="text/javascript">';
			    echo 	'alert("Preencha!");';
			    echo	'window.location="../../home.php?page=usuario/listar";';
			    echo '</script>';
		}




?>