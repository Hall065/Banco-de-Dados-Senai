<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_servico"];
    $tempo = $_POST["tempo_estimado"];
    $codigo = $_POST["codigo"];
    $categoria = $_POST["categoria"];
    $descricao = $_POST["descricao"];
    $preco = $_POST["preco"];

    $stmt = $conn->prepare("UPDATE Servico SET tempo_estimado=?, codigo=?, categoria=?, descricao=?, preco=? WHERE id_servico=?");
    $stmt->bind_param("sissdi", $tempo, $codigo, $categoria, $descricao, $preco, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM Servico WHERE id_servico = $id");
$row = $result->fetch_assoc();
if (!$row) die("Não encontrado. <a href='list.php'>Voltar</a>");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Serviço</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>✏️ Editar Serviço</h1></header>
        <form action="edit.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <input type="hidden" name="id_servico" value="<?php echo $row['id_servico']; ?>">
            <label>Código:</label>
            <input type="number" name="codigo" value="<?php echo $row['codigo']; ?>" required>
            <label>Categoria:</label>
            <input type="text" name="categoria" value="<?php echo htmlspecialchars($row['categoria']); ?>" required>
            <label>Descrição:</label>
            <textarea name="descricao" required><?php echo htmlspecialchars($row['descricao']); ?></textarea>
            <label>Tempo Estimado (HH:MM:SS):</label>
            <input type="time" name="tempo_estimado" step="1" value="<?php echo $row['tempo_estimado']; ?>" required>
            <label>Preço:</label>
            <input type="number" step="0.01" name="preco" value="<?php echo $row['preco']; ?>" required>
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>