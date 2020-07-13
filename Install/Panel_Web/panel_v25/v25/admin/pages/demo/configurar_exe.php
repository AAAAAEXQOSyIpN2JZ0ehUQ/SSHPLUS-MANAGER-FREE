<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
require_once("../../../pages/system/classe.ssh.php");


protegePagina("admin");

	
	
	    if((isset($_POST["servidor"]))  and (isset($_POST["dias_demo"])) ){
			
		       $dias = $_POST["dias_demo"];
				
				 
		
				
                $SQLUPUser = "update servidor set dias = '".$dias."' , demo='1' WHERE id_servidor = '".$_POST['servidor']."'  ";
                $SQLUPUser = $conn->prepare($SQLUPUser);
                $SQLUPUser->execute();
				
				$SQLUPUser = "update servidor set dias = '0' , demo='0' WHERE id_servidor != '".$_POST['servidor']."'  ";
                $SQLUPUser = $conn->prepare($SQLUPUser);
                $SQLUPUser->execute();
			
				 
				 echo '<script type="text/javascript">';
			      echo 	'alert("Alterado com sucesso!");';
			     echo	'window.location="../../home.php?page=demo/configurar";';
			    echo '</script>';
		
			
		}else{
			echo '<script type="text/javascript">';
			echo 	'alert("Preencha todos os campos!");';
			echo	'window.location="../../home.php?page=demo/configurar";';
			echo '</script>';
			
		}

	
	
	?>