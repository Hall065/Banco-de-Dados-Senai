<?php
$conn = new mysqli("localhost", "root", "senaisp", "livraria");
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$id = $_GET["id"];

$stmt = $conn->prepare("DELETE FROM usuarios WHERE id = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo "<p>Usuário deletado com sucesso!</p>";
} else {
    echo "<p>Erro ao deletar usuário: " . $stmt->error . "</p>";
}
echo "<br><a href='list.php'>Voltar para lista</a>";

$stmt->close();
$conn->close();
?>