<?php 
require_once('seguranca.php');
require_once('config.php');
require_once('classe.ssh.php');
$date = date("Y-m-d");
echo $date;
 
  


  
  
   //Remove acesso conta ssh suspensa

   $SQLSSH = "SELECT * FROM usuario_ssh where id_servidor='1' and apagar='0'";
   $SQLSSH = $conn->prepare($SQLSSH);
   $SQLSSH->execute();
			
   if(($SQLSSH->rowCount()) > 0){	   
	   while($row = $SQLSSH->fetch()){ 
	      
	     //Carrega servidor
            $SQLServidor = "select * from servidor WHERE id_servidor = '".$row['id_servidor']."'";
            $SQLServidor = $conn->prepare($SQLServidor);
            $SQLServidor->execute();
            $servidor = $SQLServidor->fetch();

            //Realiza a comunicacao com o servidor
			$ip_servidor= $servidor['ip_servidor'];
		    $loginSSH= $servidor['login_server'];
			$senhaSSH=  $servidor['senha'];
			$ssh = new SSH2($ip_servidor); 
			$ssh->auth($loginSSH,$senhaSSH); 
			
			 $ssh->exec("./criarusuario.sh ".$row['login']." ".$row['senha']." 30  ".$row['acesso']."");
		    $mensagem = (string) $ssh->output();			
	        if($mensagem == 6 ){
				echo "<br> Conta SSH criada no servidor!"
			    $SQLSSH = "update usuario_ssh set apagar='1'  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
                   $SQLSSH = $conn->prepare($SQLSSH);
                   $SQLSSH->execute();
			} else{
				echo "<br> Conta SSH nao criada no servidor!".$row['login']." ";
				
				   $SQLSSH = "update usuario_ssh set apagar='4'  WHERE id_usuario_ssh = '".$row['id_usuario_ssh']."'  ";
                   $SQLSSH = $conn->prepare($SQLSSH);
                   $SQLSSH->execute();
				
			}
			   
			   
			   
	   }
	   
   }else{
		   echo "<br>Nenhuma Conta SSH criada no servidor!<br>";
	}
	
	
	   
	 
   
  
?>