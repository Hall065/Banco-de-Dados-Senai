<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nome = $_POST["nome"];
    $descricao = $_POST["descricao"];
    $preco_custo = $_POST["preco_custo"];
    $preco_venda = $_POST["preco_venda"];
    $qtd_estoque = $_POST["qtd_estoque"];

    $stmt = $conn->prepare("INSERT INTO Peca (nome, descricao, preco_custo, preco_venda, qtd_estoque) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ssddi", $nome, $descricao, $preco_custo, $preco_venda, $qtd_estoque);

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
    <title>Novo Estoque</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <header><h1>➕ Novo Estoque</h1></header>
    <form action="form.php" method="POST" class="form-box">
        <?php if (isset($error)): ?>
            <div class="message error"><?php echo $error; ?></div>
        <?php endif; ?>
        <label>Nome da Peça/Material:</label>
        <input type="text" name="nome" required>

        <label>Descrição:</label>
        <input type="text" name="descricao">

        <label>Preço de Custo (R$):</label>
        <input type="number" step="0.01" name="preco_custo" required>

        <label>Preço de Venda (R$):</label>
        <input type="number" step="0.01" name="preco_venda" required>

        <label>Quantidade em Estoque:</label>
        <input type="number" name="qtd_estoque" value="0" min="0" required>

        <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar</button>
        <div style="text-align: center;">
            <a href="list.php" class="back-link">← Voltar</a>
        </div>
    </form>
</div>
</body>
</html>
