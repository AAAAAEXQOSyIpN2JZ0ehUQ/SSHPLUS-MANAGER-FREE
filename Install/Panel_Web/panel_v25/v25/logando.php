<?php

if(isset($_POST['botaologin'])){

if($_POST['login']=='admin'){require_once("admin/validacao.php");
}else{require_once("validacao.php");
}

}
