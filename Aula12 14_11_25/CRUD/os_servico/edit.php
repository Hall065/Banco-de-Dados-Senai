<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_os_servico"];
    $preco_un = $_POST["preco_un"];
    $quantidade = $_POST["quantidade"];
    $subtotal = $preco_un * $quantidade;
    $id_servico = $_POST["id_servico"];
    $id_os = $_POST["id_os"];

    $stmt = $conn->prepare("UPDATE OS_Servico SET preco_un=?, quantidade=?, subtotal=?, id_servico=?, id_os=? WHERE id_os_servico=?");
    $stmt->bind_param("ddiiii", $preco_un, $quantidade, $subtotal, $id_servico, $id_os, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM OS_Servico WHERE id_os_servico = $id");
$row = $result->fetch_assoc();
if (!$row) die("Não encontrado. <a href='list.php'>Voltar</a>");

$servicos = $conn->query("SELECT id_servico, categoria, descricao, preco FROM Servico ORDER BY categoria");
$ordens = $conn->query("SELECT id_os, data_abertura, status FROM OrdemServico ORDER BY id_os DESC");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar OS-Serviço</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function calcularSubtotal() {
            var preco = parseFloat(document.getElementById('preco_un').value) || 0;
            var qtd = parseInt(document.getElementById('quantidade').value) || 0;
            document.getElementById('subtotal_display').textContent = 'R$ ' + (preco * qtd).toFixed(2).replace('.', ',');
        }
        window.onload = calcularSubtotal;
    </script>
</head>
<body>
    <div class="container">
        <header><h1>✏️ Editar OS-Serviço</h1></header>
        <form action="edit.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <input type="hidden" name="id_os_servico" value="<?php echo $row['id_os_servico']; ?>">
            <label>Ordem de Serviço:</label>
            <select name="id_os" required>
                <?php while ($os = $ordens->fetch_assoc()): ?>
                    <option value="<?php echo $os['id_os']; ?>" <?php echo ($os['id_os'] == $row['id_os']) ? 'selected' : ''; ?>>
                        OS #<?php echo $os['id_os']; ?> - <?php echo date('d/m/Y', strtotime($os['data_abertura'])); ?> (<?php echo $os['status']; ?>)
                    </option>
                <?php endwhile; ?>
            </select>
            <label>Serviço:</label>
            <select name="id_servico" required>
                <?php while ($servico = $servicos->fetch_assoc()): ?>
                    <option value="<?php echo $servico['id_servico']; ?>" <?php echo ($servico['id_servico'] == $row['id_servico']) ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($servico['categoria']) . ' - ' . htmlspecialchars($servico['descricao']); ?>
                    </option>
                <?php endwhile; ?>
            </select>
            <label>Preço Unitário:</label>
            <input type="number" step="0.01" name="preco_un" id="preco_un" value="<?php echo $row['preco_un']; ?>" onchange="calcularSubtotal()" required>
            <label>Quantidade:</label>
            <input type="number" name="quantidade" id="quantidade" value="<?php echo $row['quantidade']; ?>" min="1" onchange="calcularSubtotal()" required>
            <div style="padding: 15px; background: #f0f0f0; border-radius: 8px; text-align: center; margin-bottom: 20px;">
                <strong>Subtotal: <span id="subtotal_display">R$ 0,00</span></strong>
            </div>
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>