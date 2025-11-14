<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$result = $conn->query("SELECT * FROM Cliente ORDER BY id_cliente DESC");
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>👤 Lista de Clientes</h1>
        </header>

        <div style="background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
            <div style="margin-bottom: 20px; text-align: right;">
                <a href="form.php" class="btn btn-success">➕ Novo Cliente</a>
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>CPF</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Endereço</th>
                    <th>Ações</th>
                </tr>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_cliente']; ?></td>
                    <td><?php echo htmlspecialchars($row['nome_cliente']); ?></td>
                    <td><?php echo htmlspecialchars($row['cpf']); ?></td>
                    <td><?php echo htmlspecialchars($row['email_cliente']); ?></td>
                    <td><?php echo htmlspecialchars($row['telefone_cliente']); ?></td>
                    <td><?php echo htmlspecialchars($row['endereco']); ?></td>
                    <td>
                        <a href="edit.php?id=<?php echo $row['id_cliente']; ?>" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.9em;">✏️ Editar</a>
                        <a href="delete.php?id=<?php echo $row['id_cliente']; ?>" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.9em;" onclick="return confirm('Tem certeza que deseja deletar este cliente?');">🗑️ Deletar</a>
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