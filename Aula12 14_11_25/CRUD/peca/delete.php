<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");
$id = intval($_GET["id"]);

$stmt = $conn->prepare("DELETE FROM Peca WHERE id_peca = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    $message = "Registro deletado com sucesso!";
    $type = "success";
} else {
    $message = "Erro: " . $stmt->error;
    $type = "error";
}

$stmt->close();
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Deletar Estoque</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <header><h1>🗑️ Deletar Estoque</h1></header>
    <div class="form-box">
        <div class="message <?php echo $type; ?>"><?php echo $message; ?></div>
        <div style="text-align: center;">
            <a href="list.php" class="btn btn-primary">← Voltar</a>
        </div>
    </div>
</div>
</body>
</html>
