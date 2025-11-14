<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $modelo = $_POST["modelo"];
    $marca = $_POST["marca"];
    $placa = $_POST["placa"];
    $ano = $_POST["ano"];
    $id_cliente = $_POST["id_cliente"];

    $stmt = $conn->prepare("INSERT INTO Veiculo (modelo, marca, placa, ano, id_cliente) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssii", $modelo, $marca, $placa, $ano, $id_cliente);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro ao cadastrar: " . $stmt->error;
    }
    $stmt->close();
}

$clientes = $conn->query("SELECT id_cliente, nome_cliente FROM Cliente ORDER BY nome_cliente");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Veículo</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>➕ Novo Veículo</h1>
        </header>

        <form action="form.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>

            <label>Modelo:</label>
            <input type="text" name="modelo" required>

            <label>Marca:</label>
            <input type="text" name="marca" required>

            <label>Placa:</label>
            <input type="text" name="placa" placeholder="ABC1D23" required>

            <label>Ano:</label>
            <input type="number" name="ano" min="1900" max="2100" required>

            <label>Cliente:</label>
            <select name="id_cliente" required>
                <option value="">Selecione um cliente</option>
                <?php while ($cliente = $clientes->fetch_assoc()): ?>
                    <option value="<?php echo $cliente['id_cliente']; ?>">
                        <?php echo htmlspecialchars($cliente['nome_cliente']); ?>
                    </option>
                <?php endwhile; ?>
            </select>

            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar Veículo</button>
            
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar para lista</a>
            </div>
        </form>
    </div>
</body>
</html>