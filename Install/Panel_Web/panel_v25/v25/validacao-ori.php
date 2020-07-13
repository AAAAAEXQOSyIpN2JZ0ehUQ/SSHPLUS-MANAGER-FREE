<?php 
require_once("pages/system/funcoes.php");
require_once("pages/system/seguranca.php");

$usuario = $_POST['login'];
$senha = $_POST['senha'];

if(empty($usuario)){
	echo '<script type="text/javascript">';
			                        echo 	'alert("Ops seu usuario em branco!");';
			                        echo	'window.location="login.php";';
			                        echo '</script>';
}
elseif(empty($senha)){
	echo '<script type="text/javascript">';
			                        echo 	'alert("Ops sua senha em branco!");';
			                        echo	'window.location="login.php";';
			                        echo '</script>';
}else{
	
	// Verifica se um formulário foi enviado
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
		$usuario = (isset($usuario)) ? $usuario : '';
        $senha = (isset($senha)) ? $senha : '';
		 // Utiliza uma função criada no seguranca.php pra validar os dados digitados
        if (validaUsuario($usuario, $senha,"user") == true) {
			echo '<script type="text/javascript">';
			                        echo	'window.location="home.php";';
			                        echo '</script>';
		}else{
			
			                        echo '<script type="text/javascript">';
			                        echo 	'alert("Ops seus dados estao incorretos.");';
			                        echo	'window.location="login.php";';
			                        echo '</script>';
		}
		
		
	}
}

?>