<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");
$result = $conn->query("SELECT os.*, v.modelo, v.placa, c.nome_cliente 
                        FROM OrdemServico os 
                        LEFT JOIN Veiculo v ON os.id_veiculo = v.id_veiculo 
                        LEFT JOIN Cliente c ON v.id_cliente = c.id_cliente 
                        ORDER BY os.id_os DESC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Ordens de Serviço</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>📋 Lista de Ordens de Serviço</h1></header>
        <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="form.php" class="btn btn-success">➕ Nova OS</a>
            </div>
            <table>
                <tr><th>ID</th><th>Veículo</th><th>Cliente</th><th>Abertura</th><th>Fechamento</th><th>Status</th><th>Observações</th><th>Ações</th></tr>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_os']; ?></td>
                    <td><?php echo htmlspecialchars($row['modelo']) . ' - ' . htmlspecialchars($row['placa']); ?></td>
                    <td><?php echo htmlspecialchars($row['nome_cliente']); ?></td>
                    <td><?php echo date('d/m/Y', strtotime($row['data_abertura'])); ?></td>
                    <td><?php echo $row['data_fechamento'] ? date('d/m/Y', strtotime($row['data_fechamento'])) : '-'; ?></td>
                    <td><?php echo htmlspecialchars($row['status']); ?></td>
                    <td><?php echo htmlspecialchars($row['observacoes']); ?></td>
                    <td>
                        <a href="edit.php?id=<?php echo $row['id_os']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                        <a href="delete.php?id=<?php echo $row['id_os']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Deletar?');">🗑️ Deletar</a>
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