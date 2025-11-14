<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");
$result = $conn->query("SELECT * FROM Mecanico ORDER BY id_mecanico DESC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Mecânicos</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>🔧 Lista de Mecânicos</h1></header>
        <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="form.php" class="btn btn-success">➕ Novo Mecânico</a>
            </div>
            <table>
                <tr><th>ID</th><th>Nome</th><th>Especialidade</th><th>Telefone</th><th>Email</th><th>Salário</th><th>Ações</th></tr>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_mecanico']; ?></td>
                    <td><?php echo htmlspecialchars($row['nome_mecanico']); ?></td>
                    <td><?php echo htmlspecialchars($row['especialidade']); ?></td>
                    <td><?php echo htmlspecialchars($row['telefone_mecanico']); ?></td>
                    <td><?php echo htmlspecialchars($row['email_mecanico']); ?></td>
                    <td>R$ <?php echo number_format($row['salario'], 2, ',', '.'); ?></td>
                    <td>
                        <a href="edit.php?id=<?php echo $row['id_mecanico']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                        <a href="delete.php?id=<?php echo $row['id_mecanico']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Deletar este mecânico?');">🗑️ Deletar</a>
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