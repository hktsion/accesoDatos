<?php session_start();

if (isset($_SESSION['usuario'])) {
	header('Location: index.php');
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	$usuario = filter_var(strtolower($_POST['usuario']), FILTER_SANITIZE_STRING);
	$usuario = strtolower($usuario);

	$password = $_POST['password'];
	$password2 = $_POST['password2'];

	$password = strtolower($password);
	$password2 = strtolower($password2);

	$errores = '';

	if (empty($usuario) or empty($password) or empty($password2)) {
		$errores .= '<li>All fields are required</li>';
	} else {
		try {
			$conexion = new PDO('mysql:host=localhost;dbname=dbhacking', 'root1', 'root1');
		} catch (PDOException $e) {
			echo "Error: " . $e->getMessage();
		}

		$statement = $conexion->prepare('SELECT * FROM h4ck3rs WHERE user = :usuario LIMIT 1');
		$statement->execute(array(':usuario' => $usuario));
		$resultado = $statement->fetch();

		if ($resultado != false) {
			$errores .= '<li>Username already exists, try some other name</li>';
		}

		$password = hash('sha512', $password);
		$password2 = hash('sha512', $password2);

		if ($password != $password2) {
			$errores .= '<li>Your passwords don´t match</li>';
		}
	}

	if ($errores == '') {
		$statement = $conexion->prepare('INSERT INTO h4ck3rs (user, password) VALUES (:usuario, :pass)');
		$statement->execute(array(
			':usuario' => $usuario,
			':pass' => $password
		));

		header('Location: login.php');
	}
}

require 'views/registrate.view.php';

?>