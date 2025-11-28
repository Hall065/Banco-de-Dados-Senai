<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");
$result = $conn->query("SELECT * FROM Peca ORDER BY nome ASC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista Estoque</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
<div class="container">
    <header><h1>📦 Estoque</h1></header>
    <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
        <div style="margin-bottom: 20px; text-align: right;">
            <a href="form.php" class="btn btn-success">➕ Novo Registro</a>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Preço Custo</th>
                <th>Preço Venda</th>
                <th>Qtd Estoque</th>
                <th>Ações</th>
            </tr>
            <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?php echo $row['id_peca']; ?></td>
                <td><?php echo htmlspecialchars($row['nome']); ?></td>
                <td><?php echo htmlspecialchars($row['descricao']); ?></td>
                <td>R$ <?php echo number_format($row['preco_custo'], 2, ',', '.'); ?></td>
                <td>R$ <?php echo number_format($row['preco_venda'], 2, ',', '.'); ?></td>
                <td><?php echo $row['qtd_estoque']; ?></td>
                <td>
                    <a href="edit.php?id=<?php echo $row['id_peca']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                    <a href="delete.php?id=<?php echo $row['id_peca']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Deletar?');">🗑️ Deletar</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </table>
        <div style="margin-top: 30px; text-align: center;">
            <a href="../index.html" class="btn btn-secondary">🏠 Página Inicial</a>
        </div>
    </div>
</div>
</body>
</html>
<?php $conn->close(); ?>
