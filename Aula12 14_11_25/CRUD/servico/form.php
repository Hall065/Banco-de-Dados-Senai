<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $tempo = $_POST["tempo_estimado"];
    $codigo = $_POST["codigo"];
    $categoria = $_POST["categoria"];
    $descricao = $_POST["descricao"];
    $preco = $_POST["preco"];

    $stmt = $conn->prepare("INSERT INTO Servico (tempo_estimado, codigo, categoria, descricao, preco) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sissd", $tempo, $codigo, $categoria, $descricao, $preco);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Novo Serviço</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>➕ Novo Serviço</h1></header>
        <form action="form.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <label>Código:</label>
            <input type="number" name="codigo" required>
            <label>Categoria:</label>
            <input type="text" name="categoria" required>
            <label>Descrição:</label>
            <textarea name="descricao" required></textarea>
            <label>Tempo Estimado (HH:MM:SS):</label>
            <input type="time" name="tempo_estimado" step="1" required>
            <label>Preço:</label>
            <input type="number" step="0.01" name="preco" placeholder="0.00" required>
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>