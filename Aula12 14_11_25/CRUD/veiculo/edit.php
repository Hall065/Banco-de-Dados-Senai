<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_veiculo"];
    $modelo = $_POST["modelo"];
    $marca = $_POST["marca"];
    $placa = $_POST["placa"];
    $ano = $_POST["ano"];
    $id_cliente = $_POST["id_cliente"];

    $stmt = $conn->prepare("UPDATE Veiculo SET modelo=?, marca=?, placa=?, ano=?, id_cliente=? WHERE id_veiculo=?");
    $stmt->bind_param("sssiii", $modelo, $marca, $placa, $ano, $id_cliente, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro ao atualizar: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM Veiculo WHERE id_veiculo = $id");
$row = $result->fetch_assoc();

if (!$row) {
    die("Veículo não encontrado. <a href='list.php'>Voltar</a>");
}

$clientes = $conn->query("SELECT id_cliente, nome_cliente FROM Cliente ORDER BY nome_cliente");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Veículo</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>✏️ Editar Veículo</h1>
        </header>

        <form action="edit.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>

            <input type="hidden" name="id_veiculo" value="<?php echo $row['id_veiculo']; ?>">

            <label>Modelo:</label>
            <input type="text" name="modelo" value="<?php echo htmlspecialchars($row['modelo']); ?>" required>

            <label>Marca:</label>
            <input type="text" name="marca" value="<?php echo htmlspecialchars($row['marca']); ?>" required>

            <label>Placa:</label>
            <input type="text" name="placa" value="<?php echo htmlspecialchars($row['placa']); ?>" required>

            <label>Ano:</label>
            <input type="number" name="ano" value="<?php echo $row['ano']; ?>" min="1900" max="2100" required>

            <label>Cliente:</label>
            <select name="id_cliente" required>
                <?php while ($cliente = $clientes->fetch_assoc()): ?>
                    <option value="<?php echo $cliente['id_cliente']; ?>" <?php echo ($cliente['id_cliente'] == $row['id_cliente']) ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($cliente['nome_cliente']); ?>
                    </option>
                <?php endwhile; ?>
            </select>

            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
            
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar para lista</a>
            </div>
        </form>
    </div>
</body>
</html>