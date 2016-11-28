<?php session_start();

if (isset($_SESSION['usuario'])) {
	header('Location: contenido.php');
} else {
	header('Location: registrate.php');
}

 ?>