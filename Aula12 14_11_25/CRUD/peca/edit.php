<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_peca"];
    $nome = $_POST["nome"];
    $descricao = $_POST["descricao"];
    $preco_custo = $_POST["preco_custo"];
    $preco_venda = $_POST["preco_venda"];
    $qtd_estoque = $_POST["qtd_estoque"];

    $stmt = $conn->prepare("UPDATE Peca SET nome=?, descricao=?, preco_custo=?, preco_venda=?, qtd_estoque=? WHERE id_peca=?");
    $stmt->bind_param("ssddii", $nome, $descricao, $preco_custo, $preco_venda, $qtd_estoque, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM Peca WHERE id_peca = $id");
$row = $result->fetch_assoc();
if (!$row) die("Não encontrado. <a href='list.php'>Voltar</a>");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Estoque</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <header><h1>✏️ Editar Estoque</h1></header>
    <form action="edit.php" method="POST" class="form-box">
        <?php if (isset($error)): ?>
            <div class="message error"><?php echo $error; ?></div>
        <?php endif; ?>
        <input type="hidden" name="id_peca" value="<?php echo $row['id_peca']; ?>">
        <label>Nome da Peça/Material:</label>
        <input type="text" name="nome" value="<?php echo htmlspecialchars($row['nome']); ?>" required>

        <label>Descrição:</label>
        <input type="text" name="descricao" value="<?php echo htmlspecialchars($row['descricao']); ?>">

        <label>Preço de Custo (R$):</label>
        <input type="number" step="0.01" name="preco_custo" value="<?php echo $row['preco_custo']; ?>" required>

        <label>Preço de Venda (R$):</label>
        <input type="number" step="0.01" name="preco_venda" value="<?php echo $row['preco_venda']; ?>" required>

        <label>Quantidade em Estoque:</label>
        <input type="number" name="qtd_estoque" value="<?php echo $row['qtd_estoque']; ?>" min="0" required>

        <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
        <div style="text-align: center;">
            <a href="list.php" class="back-link">← Voltar</a>
        </div>
    </form>
</div>
</body>
</html>
