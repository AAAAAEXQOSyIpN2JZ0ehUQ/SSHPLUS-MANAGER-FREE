<?php
require_once('config.php');

echo tempo_corrido("2017-01-07 19:00:38") ;

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

    if ($seconds <= 60) return"1 min atrás";
    else if ($minutes <= 60) return $minutes==1 ?'1 min atrás':$minutes.' min atrás';
    else if ($hours <= 24) return $hours==1 ?'1 hrs atrás':$hours.' hrs atrás';
    else if ($days <= 7) return $days==1 ?'1 dia atras':$days.' dias atrás';
    else if ($weeks <= 4) return $weeks==1 ?'1 semana atrás':$weeks.' semanas atrás';
    else if ($months <= 12) return $months == 1 ?'1 mês atrás':$months.' meses atrás';
    else return $years == 1 ? 'um ano atrás':$years.' anos atrás';
}


?>