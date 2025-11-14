<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");
$result = $conn->query("SELECT * FROM Servico ORDER BY id_servico DESC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Serviços</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>⚙️ Lista de Serviços</h1></header>
        <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="form.php" class="btn btn-success">➕ Novo Serviço</a>
            </div>
            <table>
                <tr><th>ID</th><th>Código</th><th>Categoria</th><th>Descrição</th><th>Tempo</th><th>Preço</th><th>Ações</th></tr>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_servico']; ?></td>
                    <td><?php echo $row['codigo']; ?></td>
                    <td><?php echo htmlspecialchars($row['categoria']); ?></td>
                    <td><?php echo htmlspecialchars($row['descricao']); ?></td>
                    <td><?php echo $row['tempo_estimado']; ?></td>
                    <td>R$ <?php echo number_format($row['preco'], 2, ',', '.'); ?></td>
                    <td>
                        <a href="edit.php?id=<?php echo $row['id_servico']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                        <a href="delete.php?id=<?php echo $row['id_servico']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Deletar?');">🗑️ Deletar</a>
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