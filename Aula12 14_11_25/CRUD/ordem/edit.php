<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_os"];
    $data_abertura = $_POST["data_abertura"];
    $data_fechamento = !empty($_POST["data_fechamento"]) ? $_POST["data_fechamento"] : NULL;
    $status = $_POST["status"];
    $observacoes = $_POST["observacoes"];
    $id_veiculo = $_POST["id_veiculo"];

    $stmt = $conn->prepare("UPDATE OrdemServico SET data_abertura=?, data_fechamento=?, status=?, observacoes=?, id_veiculo=? WHERE id_os=?");
    $stmt->bind_param("ssssii", $data_abertura, $data_fechamento, $status, $observacoes, $id_veiculo, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM OrdemServico WHERE id_os = $id");
$row = $result->fetch_assoc();
if (!$row) die("Não encontrado. <a href='list.php'>Voltar</a>");

$veiculos = $conn->query("SELECT v.id_veiculo, v.modelo, v.placa, c.nome_cliente 
                          FROM Veiculo v 
                          LEFT JOIN Cliente c ON v.id_cliente = c.id_cliente 
                          ORDER BY c.nome_cliente");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Ordem de Serviço</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>✏️ Editar Ordem de Serviço</h1></header>
        <form action="edit.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <input type="hidden" name="id_os" value="<?php echo $row['id_os']; ?>">
            <label>Veículo:</label>
            <select name="id_veiculo" required>
                <?php while ($veiculo = $veiculos->fetch_assoc()): ?>
                    <option value="<?php echo $veiculo['id_veiculo']; ?>" <?php echo ($veiculo['id_veiculo'] == $row['id_veiculo']) ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($veiculo['nome_cliente']) . ' - ' . htmlspecialchars($veiculo['modelo']) . ' (' . htmlspecialchars($veiculo['placa']) . ')'; ?>
                    </option>
                <?php endwhile; ?>
            </select>
            <label>Data de Abertura:</label>
            <input type="date" name="data_abertura" value="<?php echo $row['data_abertura']; ?>" required>
            <label>Data de Fechamento:</label>
            <input type="date" name="data_fechamento" value="<?php echo $row['data_fechamento']; ?>">
            <label>Status:</label>
            <select name="status" required>
                <option value="Aberta" <?php echo ($row['status'] == 'Aberta') ? 'selected' : ''; ?>>Aberta</option>
                <option value="Em andamento" <?php echo ($row['status'] == 'Em andamento') ? 'selected' : ''; ?>>Em andamento</option>
                <option value="Concluída" <?php echo ($row['status'] == 'Concluída') ? 'selected' : ''; ?>>Concluída</option>
                <option value="Cancelada" <?php echo ($row['status'] == 'Cancelada') ? 'selected' : ''; ?>>Cancelada</option>
            </select>
            <label>Observações:</label>
            <textarea name="observacoes"><?php echo htmlspecialchars($row['observacoes']); ?></textarea>
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>