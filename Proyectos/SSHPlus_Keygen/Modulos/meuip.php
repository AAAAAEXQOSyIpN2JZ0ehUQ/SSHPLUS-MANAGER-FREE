<?php
// Obtener IP desde dos servicios externos
$ip1 = trim(@file_get_contents("https://ipv4.icanhazip.com/"));
$ip2 = trim(@file_get_contents("http://whatismyip.akamai.com/"));

// Comparar ambas IPs
$ipFinal = ($ip1 !== $ip2) ? $ip2 : $ip1;

// Mostrar la IP sin salto de línea extra
header('Content-Type: text/plain');
echo $ipFinal;
?>
