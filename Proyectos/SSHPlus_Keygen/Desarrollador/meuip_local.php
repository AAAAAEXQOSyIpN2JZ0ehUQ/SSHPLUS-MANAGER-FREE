<?php
// Obtener la IP del cliente
$ip = $_SERVER['REMOTE_ADDR'];

// Mostrar la IP sin salto de línea extra
header('Content-Type: text/plain');
echo $ip;
?>
