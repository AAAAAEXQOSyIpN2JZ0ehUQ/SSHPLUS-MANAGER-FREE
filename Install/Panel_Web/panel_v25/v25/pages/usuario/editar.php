<?php

	if (basename($_SERVER["REQUEST_URI"]) === basename(__FILE__))
{
	exit('<h1>ERROR 404</h1>Entre em contato conosco e envie detalhes.');
}



   if(isset($_GET["id_usuario"])){
	   $res_usuario = $mysqli->query("select * from usuario WHERE id_usuario = '".$_GET['id_usuario']."' and id_mestre= '".$_SESSION['id']."' ") or die($mysqli->error);
       $usuario = $res_usuario->fetch_assoc();
	   if($usuario['id_mestre']!=0 ){
		$res_usuario_mestre = $mysqli->query("select * from usuario WHERE id_usuario = '".$usuario['id_mestre']."' ") or die($mysqli->error);
        $usuario_mestre = $res_usuario_mestre->fetch_assoc();
	   }
	   
   }else{
	   
	    echo '<script type="text/javascript">';
		echo 	'alert("Preencha todos os campos!");';
		echo	'window.location="home.php?page=usuario/listar";';
		echo '</script>'; 
   }
	

?>
<div class="alert alert-info">
<h5 class="active"><a href="home.php"><i class="ficon fad fa-home text-warning"></i><span class="menu-item" data-i18n="Inicio"> INICIO</span></a></h5>
</div>
<!-- Input with Icons start -->
<section id="input-with-icons">
    <div class="row match-height">
        <div class="col-12">
            <div class="card border-info mb-3">
                <div class="card-header">
                    <h1 class="card-title font-medium-2"><i class="fad fa-user-tie text-success font-large-1"></i> Editar Usuário do sistema</h1>
                </div>
                <div class="card-content">
                    <form role="form" action="pages/usuario/editar_exe.php" method="post">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p>Editar informações de usuario dno painel.</p>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Nome
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left">
                                        <input required="required" type="text" class="form-control" id="nome" name="nome" value="<?php echo $usuario['nome'];?>">
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Email
                                    </div>
                                    <fieldset class="form-group position-relative">
                                        <input required="required" type="email" class="form-control" id="email" name="email" value="<?php echo $usuario['email'];?>">
                                        <div class="form-control-position">
                                            <i class="fad fa-at"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Usuário
                                    </div>
                                    <fieldset class="form-group position-relative has-icon-left input-divider-left">
                                        <input  type="hidden" class="form-control" id="login" name="login"  value="<?php echo $usuario['login'];?>" >
                                        <div class="form-control-position">
                                            <i class="fad fa-user-tie"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="text-bold-600 font-medium-2 mb-1">
                                        Senha
                                    </div>
                                    <fieldset class="form-group position-relative input-divider-right">
                                        <input required="required" type="password" class="form-control" id="senha" name="senha"  value="<?php echo $usuario['senha'];?>">
                                        <div class="form-control-position">
                                            <i class="fad fa-key-skeleton"></i>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-12 col-12 text-center">
                                    <button type="submit" class="btn btn-success round">Alterar</button>
                                    <a href="home.php?page=usuario/excluir&id_usuario=<?php echo $usuario['id_usuario'];?>" class="btn btn-danger">Deletar</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Input with Icons end -->
