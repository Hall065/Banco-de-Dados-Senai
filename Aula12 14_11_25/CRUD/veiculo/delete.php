<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$id = intval($_GET["id"]);

$stmt = $conn->prepare("DELETE FROM Veiculo WHERE id_veiculo = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    $message = "Veículo deletado com sucesso!";
    $type = "success";
} else {
    $message = "Erro ao deletar veículo: " . $stmt->error;
    $type = "error";
}

$stmt->close();
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deletar Veículo</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🗑️ Deletar Veículo</h1>
        </header>

        <div class="form-box">
            <div class="message <?php echo $type; ?>">
                <?php echo $message; ?>
            </div>
            
            <div style="text-align: center;">
                <a href="list.php" class="btn btn-primary">← Voltar para lista</a>
            </div>
        </div>
    </div>
</body>
</html>