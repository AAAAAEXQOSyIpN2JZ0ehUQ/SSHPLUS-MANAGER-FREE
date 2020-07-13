<?php
require_once('seguranca.php');

// ======================================
//  Script para remover acentos e caracteres especiais
// ======================================

function Pinga($IP,$PORTA){
    $IPAddress = $IP;
    $Port = $PORTA;
    $fp=@fsockopen ($IPAddress,$Port, $errno, $errstr,(float)0.5);
    if(!$fp) {
        return 1;
    }
    else {
        return 0;
        fclose($fp);
    }
}

function tempo_corrido($time) {

    $now = strtotime(date("Y-m-d H:i:s"));
    $time = strtotime($time);
    $diff = $now - $time;

    $seconds = $diff;
    $minutes = round($diff / 60);
    $hours = round($diff / 3600);
    $days = round($diff / 86400);
    $weeks = round($diff / 604800);
    $months = round($diff / 2419200);
    $years = round($diff / 29030400);

    if ($seconds <= 60) return"1 min ";
    else if ($minutes <= 60) return $minutes==1 ?'1 min ':$minutes.' min ';
    else if ($hours <= 24) return $hours==1 ?'1 hrs ':$hours.' hrs ';
    else if ($days <= 7) return $days==1 ?'1 dia atras':$days.' dias ';
    else if ($weeks <= 4) return $weeks==1 ?'1 semana ':$weeks.' semanas ';
    else if ($months <= 12) return $months == 1 ?'1 mês ':$months.' meses ';
    else return $years == 1 ? 'um ano ':$years.' anos ';
}

function tempo_final($time, $time_f) {

    $now = strtotime($time_f);
    $time = strtotime($time);
    $diff = $now - $time;

    $seconds = $diff;
    $minutes = round($diff / 60);
    $hours = round($diff / 3600);
    $days = round($diff / 86400);
    $weeks = round($diff / 604800);
    $months = round($diff / 2419200);
    $years = round($diff / 29030400);

    if ($seconds <= 60) return"1 min ";
    else if ($minutes <= 60) return $minutes==1 ?'1 min ':$minutes.' min ';
    else if ($hours <= 24) return $hours==1 ?'1 hrs ':$hours.' hrs ';
    else if ($days <= 7) return $days==1 ?'1 dia atras':$days.' dias ';
    else if ($weeks <= 4) return $weeks==1 ?'1 semana ':$weeks.' semanas ';
    else if ($months <= 12) return $months == 1 ?'1 mês ':$months.' meses ';
    else return $years == 1 ? 'um ano ':$years.' anos ';
}


function removerEspeciais($palavra){

    $palavra = ereg_replace("[^a-zA-Z0-9_]", "", strtr($palavra, "áàãâéêíóôõúüçÁÀÃÂÉÊÍÓÔÕÚÜÇ ", "aaaaeeiooouucAAAAEEIOOOUUC_"));
    $palavra = anti_sql_injection($palavra);

    return $palavra;
}

// ======================================
//  Script para remover acentos e caracteres especiais
// ======================================

function validarNumero($palavra){

    return (is_numeric($palavra)) ?  $var=0 : $var =1 ;


}


// ======================================
//  Anti SQL Injector
// ======================================

function anti_sql_injection($sql)
{
    $seg = preg_replace(sql_regcase("/(from|select|insert|delete|where|drop table|show tables|#|\*|--|\\\\)/"),"",$sql); //remove palavras que          contenham a sintaxe sql
    $seg = trim($seg); //limpa espaços vazios
    $seg = strip_tags($seg); // tira tags html e php
    $seg = addslashes($seg); //adiciona barras invertidas a uma string
    return $seg;
}


// ======================================
//  Recuperar o ID do Usuário logado
// ======================================

function getIDUsuario(){


    $session = empty($_SESSION['usuarioID']) ? 0 : $_SESSION['usuarioID'];

    return $session;
}

// ======================================
//  Recuperar o ID do Usuário logado
// ======================================

function getUsuario($id){

    $SQLUsuario = "SELECT * FROM usuario WHERE id_usuario = '".$id."'";
    $SQLUsuario = $conn->prepare($SQLUsuario);
    $SQLUsuario->execute();
    $usuario = $SQLUsuario->fetch();

    return $usuario;
}

?>