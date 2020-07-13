<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
	protegePagina("admin");

		if((isset($_POST["nome"])) and (isset($_POST["email"]))){

		    //Posts
		    $nome=$_POST["nome"];
		    $email=$_POST["email"];
		    $site=$_POST["site"];
		    $senhaat=$_POST["senhaantiga"];
            $senhanew=$_POST["novasenha"];

		    $SQLUser = "select * from admin where id_administrador = '".$_SESSION['usuarioID']."'   ";
            $SQLUser = $conn->prepare($SQLUser);
            $SQLUser->execute();
			if(($SQLUser->rowCount()) > 0){

			$euadm=$SQLUser->fetch();

			if($senhaat<>""){            if($senhaat<>$euadm['senha']){                echo '<script type="text/javascript">';
			    echo 	'alert("Senha Errada!");';
			    echo	'window.location="../../home.php?page=admin/dados";';
			    echo '</script>';
			    exit;
            }elseif($senhaat==$senhanew){
                echo '<script type="text/javascript">';
			    echo 	'alert("As Senhas devem ser diferentes!");';
			    echo	'window.location="../../home.php?page=admin/dados";';
			    echo '</script>';
			    exit;
            }
            if(strlen($senhanew)<3){                echo '<script type="text/javascript">';
			    echo 	'alert("Digite uma senha maior que 3 digitos!");';
			    echo	'window.location="../../home.php?page=admin/dados";';
			    echo '</script>';
			    exit;
            }
            $updatesenha="senha='".$senhanew."',";
			}




				   	        $SQLUPUser = "update admin set ".$updatesenha." nome='".$_POST['nome']."', email='".$_POST['email']."',site='".$_POST['site']."' WHERE id_administrador = '".$_SESSION['usuarioID']."' ";
                            $SQLUPUser = $conn->prepare($SQLUPUser);
                            $SQLUPUser->execute();
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
