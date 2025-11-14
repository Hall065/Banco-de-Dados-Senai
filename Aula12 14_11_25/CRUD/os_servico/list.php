<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");
$result = $conn->query("SELECT oss.*, s.descricao, s.categoria, os.id_os 
                        FROM OS_Servico oss 
                        LEFT JOIN Servico s ON oss.id_servico = s.id_servico 
                        LEFT JOIN OrdemServico os ON oss.id_os = os.id_os 
                        ORDER BY oss.id_os_servico DESC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista OS - Serviços</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>📊 Lista de Serviços das OS</h1></header>
        <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="form.php" class="btn btn-success">➕ Novo Registro</a>
            </div>
            <table>
                <tr><th>ID</th><th>OS</th><th>Serviço</th><th>Preço Un.</th><th>Qtd</th><th>Subtotal</th><th>Ações</th></tr>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_os_servico']; ?></td>
                    <td>OS #<?php echo $row['id_os']; ?></td>
                    <td><?php echo htmlspecialchars($row['categoria']) . ' - ' . htmlspecialchars($row['descricao']); ?></td>
                    <td>R$ <?php echo number_format($row['preco_un'], 2, ',', '.'); ?></td>
                    <td><?php echo $row['quantidade']; ?></td>
                    <td>R$ <?php echo number_format($row['subtotal'], 2, ',', '.'); ?></td>
                    <td>
                        <a href="edit.php?id=<?php echo $row['id_os_servico']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                        <a href="delete.php?id=<?php echo $row['id_os_servico']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Deletar?');">🗑️ Deletar</a>
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