<?php
require_once("../../../pages/system/seguranca.php");
require_once("../../../pages/system/config.php");
	protegePagina("admin");
	    if((isset($_POST["nomesrv"])) and (isset($_POST["ip"]))
                                        and (isset($_POST["login"]))
                                        and (isset($_POST["senha"]))
										and (isset($_POST["id_servidor"]))
                                        )
		{

		    if(!is_numeric($_POST['validade'])){		    echo '<script type="text/javascript">';
			        echo 	'alert("Validade não é numero!");';
			        echo	'window.location="../../home.php?page=servidor/listar";';
			        echo '</script>';
			        exit;

		    }
		    if(!is_numeric($_POST['limite'])){
		            echo '<script type="text/javascript">';
			        echo 	'alert("Limite não é numero!");';
			        echo	'window.location="../../home.php?page=servidor/listar";';
			        echo '</script>';
			        exit;

		    }


			$SQLServidor = "select * from servidor where id_servidor = '".$_POST['id_servidor']."'  ";
            $SQLServidor = $conn->prepare($SQLServidor);
            $SQLServidor->execute();
		    if(($SQLServidor->rowCount())>0){

				$servidor = $SQLServidor->fetch();

				$SQLServidor = "update servidor set   nome='".$_POST['nomesrv']."',
							                                    ip_servidor='".$_POST['ip']."',
																login_server='".$_POST['login']."',
                                                                senha='".$_POST['senha']."',
                                                               	site_servidor='".$_POST['siteserver']."',
                                                               	localizacao='".$_POST['localiza']."',
                                                               	localizacao_img='".$_POST['localiza_ico']."',
                                                               	validade='".$_POST['validade']."',
                                                               	limite='".$_POST['limite']."'
																WHERE id_servidor = '".$_POST['id_servidor']."' ";
                $SQLServidor = $conn->prepare($SQLServidor);
                $SQLServidor->execute();

							  echo '<script type="text/javascript">';
	     	            	echo 	'alert("O servidor '.$_POST['nomesrv'].' foi editado com sucesso!");';
		     	echo	'window.location="../../home.php?page=servidor/servidor&id_servidor='.$_POST['id_servidor'] .' ";';
		    	echo '</script>';


			}else{
				    echo '<script type="text/javascript">';
			        echo 	'alert("Servidor  nao encontrado!");';
			        echo	'window.location="../../home.php?page=servidor/listar";';
			        echo '</script>';
			}


		}else{

		        echo '<script type="text/javascript">';
			    echo 	'alert("Preencha!");';
			    echo	'window.location="../../home.php?page=servidor/listar";';
			    echo '</script>';
		}




?>