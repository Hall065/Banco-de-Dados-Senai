<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nome = $_POST["nome_cliente"];
    $cpf = $_POST["cpf"];
    $email = $_POST["email_cliente"];
    $telefone = $_POST["telefone_cliente"];
    $endereco = $_POST["endereco"];

    $stmt = $conn->prepare("INSERT INTO Cliente (nome_cliente, cpf, email_cliente, telefone_cliente, endereco) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $nome, $cpf, $email, $telefone, $endereco);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro ao cadastrar: " . $stmt->error;
    }
    $stmt->close();
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Cliente</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>➕ Novo Cliente</h1>
        </header>

        <form action="form.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>

            <label>Nome:</label>
            <input type="text" name="nome_cliente" required>

            <label>CPF:</label>
            <input type="text" name="cpf" placeholder="000.000.000-00" required>

            <label>Email:</label>
            <input type="email" name="email_cliente">

            <label>Telefone:</label>
            <input type="text" name="telefone_cliente" placeholder="(00) 00000-0000">

            <label>Endereço:</label>
            <input type="text" name="endereco">

            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar Cliente</button>
            
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar para lista</a>
            </div>
        </form>
    </div>
</body>
</html>