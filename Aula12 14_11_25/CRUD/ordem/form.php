<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $data_abertura = $_POST["data_abertura"];
    $data_fechamento = !empty($_POST["data_fechamento"]) ? $_POST["data_fechamento"] : NULL;
    $status = $_POST["status"];
    $observacoes = $_POST["observacoes"];
    $id_veiculo = $_POST["id_veiculo"];

    $stmt = $conn->prepare("INSERT INTO OrdemServico (data_abertura, data_fechamento, status, observacoes, id_veiculo) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssi", $data_abertura, $data_fechamento, $status, $observacoes, $id_veiculo);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

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
    <title>Nova Ordem de Serviço</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>➕ Nova Ordem de Serviço</h1></header>
        <form action="form.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <label>Veículo:</label>
            <select name="id_veiculo" required>
                <option value="">Selecione um veículo</option>
                <?php while ($veiculo = $veiculos->fetch_assoc()): ?>
                    <option value="<?php echo $veiculo['id_veiculo']; ?>">
                        <?php echo htmlspecialchars($veiculo['nome_cliente']) . ' - ' . htmlspecialchars($veiculo['modelo']) . ' (' . htmlspecialchars($veiculo['placa']) . ')'; ?>
                    </option>
                <?php endwhile; ?>
            </select>
            <label>Data de Abertura:</label>
            <input type="date" name="data_abertura" value="<?php echo date('Y-m-d'); ?>" required>
            <label>Data de Fechamento:</label>
            <input type="date" name="data_fechamento">
            <label>Status:</label>
            <select name="status" required>
                <option value="Aberta">Aberta</option>
                <option value="Em andamento">Em andamento</option>
                <option value="Concluída">Concluída</option>
                <option value="Cancelada">Cancelada</option>
            </select>
            <label>Observações:</label>
            <textarea name="observacoes"></textarea>
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>