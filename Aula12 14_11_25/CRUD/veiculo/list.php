<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$result = $conn->query("SELECT v.*, c.nome_cliente FROM Veiculo v LEFT JOIN Cliente c ON v.id_cliente = c.id_cliente ORDER BY v.id_veiculo DESC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Veículos</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🚗 Lista de Veículos</h1>
        </header>

        <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="form.php" class="btn btn-success">➕ Novo Veículo</a>
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Modelo</th>
                    <th>Marca</th>
                    <th>Placa</th>
                    <th>Ano</th>
                    <th>Cliente</th>
                    <th>Ações</th>
                </tr>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_veiculo']; ?></td>
                    <td><?php echo htmlspecialchars($row['modelo']); ?></td>
                    <td><?php echo htmlspecialchars($row['marca']); ?></td>
                    <td><?php echo htmlspecialchars($row['placa']); ?></td>
                    <td><?php echo $row['ano']; ?></td>
                    <td><?php echo htmlspecialchars($row['nome_cliente']); ?></td>
                    <td>
                        <a href="edit.php?id=<?php echo $row['id_veiculo']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                        <a href="delete.php?id=<?php echo $row['id_veiculo']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Tem certeza que deseja deletar este veículo?');">🗑️ Deletar</a>
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