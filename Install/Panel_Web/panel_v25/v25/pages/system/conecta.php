<?php
include 'pass.php';

$host = 'localhost';
$user = 'root';
$db = 'ssh';

$mysqli = mysqli_connect($host, $user, $pass, $db);
if (mysqli_connect_errno($mysqli)) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
?>