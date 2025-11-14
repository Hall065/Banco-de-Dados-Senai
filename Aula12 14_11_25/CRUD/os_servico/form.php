<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $preco_un = $_POST["preco_un"];
    $quantidade = $_POST["quantidade"];
    $subtotal = $preco_un * $quantidade;
    $id_servico = $_POST["id_servico"];
    $id_os = $_POST["id_os"];

    $stmt = $conn->prepare("INSERT INTO OS_Servico (preco_un, quantidade, subtotal, id_servico, id_os) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ddiii", $preco_un, $quantidade, $subtotal, $id_servico, $id_os);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

$servicos = $conn->query("SELECT id_servico, categoria, descricao, preco FROM Servico ORDER BY categoria");
$ordens = $conn->query("SELECT id_os, data_abertura, status FROM OrdemServico ORDER BY id_os DESC");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Novo Registro OS-Serviço</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function atualizarPreco() {
            var select = document.getElementById('id_servico');
            var preco = select.options[select.selectedIndex].getAttribute('data-preco');
            document.getElementById('preco_un').value = preco;
            calcularSubtotal();
        }
        
        function calcularSubtotal() {
            var preco = parseFloat(document.getElementById('preco_un').value) || 0;
            var qtd = parseInt(document.getElementById('quantidade').value) || 0;
            document.getElementById('subtotal_display').textContent = 'R$ ' + (preco * qtd).toFixed(2).replace('.', ',');
        }
    </script>
</head>
<body>
    <div class="container">
        <header><h1>➕ Novo Registro OS-Serviço</h1></header>
        <form action="form.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <label>Ordem de Serviço:</label>
            <select name="id_os" required>
                <option value="">Selecione uma OS</option>
                <?php while ($os = $ordens->fetch_assoc()): ?>
                    <option value="<?php echo $os['id_os']; ?>">
                        OS #<?php echo $os['id_os']; ?> - <?php echo date('d/m/Y', strtotime($os['data_abertura'])); ?> (<?php echo $os['status']; ?>)
                    </option>
                <?php endwhile; ?>
            </select>
            <label>Serviço:</label>
            <select name="id_servico" id="id_servico" onchange="atualizarPreco()" required>
                <option value="">Selecione um serviço</option>
                <?php while ($servico = $servicos->fetch_assoc()): ?>
                    <option value="<?php echo $servico['id_servico']; ?>" data-preco="<?php echo $servico['preco']; ?>">
                        <?php echo htmlspecialchars($servico['categoria']) . ' - ' . htmlspecialchars($servico['descricao']) . ' (R$ ' . number_format($servico['preco'], 2, ',', '.') . ')'; ?>
                    </option>
                <?php endwhile; ?>
            </select>
            <label>Preço Unitário:</label>
            <input type="number" step="0.01" name="preco_un" id="preco_un" placeholder="0.00" onchange="calcularSubtotal()" required>
            <label>Quantidade:</label>
            <input type="number" name="quantidade" id="quantidade" value="1" min="1" onchange="calcularSubtotal()" required>
            <div style="padding: 15px; background: #f0f0f0; border-radius: 8px; text-align: center; margin-bottom: 20px;">
                <strong>Subtotal: <span id="subtotal_display">R$ 0,00</span></strong>
            </div>
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>