<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
protegePagina("admin");
if( $_SESSION['tipo'] == "user"){
	expulsaVisitante();			
}

	    if(isset($_GET["id_acesso"]) ) {
			
		    $SQLAcesso = "select * from acesso_servidor where id_acesso_servidor = '".$_GET['id_acesso']."'  ";
            $SQLAcesso = $conn->prepare($SQLAcesso);
            $SQLAcesso->execute();
					
			if(($SQLAcesso->rowCount()) > 0){
				   $acesso = $SQLAcesso->fetch();
				
					$SQLUpdateSSH = "update usuario_ssh set status='3', apagar='3', id_usuario='0' where id_servidor='".$acesso['id_servidor']."' and id_usuario='".$acesso['id_usuario']."' ";
                    $SQLUpdateSSH = $conn->prepare($SQLUpdateSSH);
                    $SQLUpdateSSH->execute();
					
					$SQLUserSub = "SELECT * from usuario where id_mestre = '".$acesso['id_usuario']."' ";
                    $SQLUserSub = $conn->prepare($SQLUserSub);
                    $SQLUserSub->execute();
	             	
					
                    if (($SQLUserSub->rowCount()) > 0) {
					        while($row = $SQLUserSub->fetch()) {
						       
								$SQLUpdateSSH = "update usuario_ssh set id_usuario='0', status='3', apagar='3' WHERE id_servidor='".$acesso['id_servidor']."' and id_usuario = '".$acesso['id_usuario']."' ";
                                $SQLUpdateSSH = $conn->prepare($SQLUpdateSSH);
                                $SQLUpdateSSH->execute();
							}

					}
					 $SQLExcluiAcesso = "delete  from acesso_servidor WHERE id_servidor = '".$acesso['id_servidor']."' and id_usuario = '".$acesso['id_usuario']."'";
                    $SQLExcluiAcesso = $conn->prepare($SQLExcluiAcesso);
                    $SQLExcluiAcesso->execute();
                   
	             	
					echo '<script type="text/javascript">';
			        
			        echo	'window.location="../../home.php?page=usuario/perfil&id_usuario='.$acesso['id_usuario'] .'";';
			        echo '</script>';
					
				
			
			
				
			}else{
					echo '<script type="text/javascript">';
			        echo 	'alert("Acesso nao encontrado!");';
			        echo	'window.location="home.php?page=usuario/listar";';
			        echo '</script>';
		    }
		   
		    
		  
        }else{
					echo '<script type="text/javascript">';
			        echo 	'alert("Preencha!");';
			        echo	'window.location="home.php?page=usuario/listar";';
			        echo '</script>';
	
		}
	
	
	?>