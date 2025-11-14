<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nome = $_POST["nome_mecanico"];
    $especialidade = $_POST["especialidade"];
    $telefone = $_POST["telefone_mecanico"];
    $email = $_POST["email_mecanico"];
    $salario = $_POST["salario"];

    $stmt = $conn->prepare("INSERT INTO Mecanico (nome_mecanico, especialidade, telefone_mecanico, email_mecanico, salario) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssd", $nome, $especialidade, $telefone, $email, $salario);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Novo Mecânico</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>➕ Novo Mecânico</h1></header>
        <form action="form.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <label>Nome:</label>
            <input type="text" name="nome_mecanico" required>
            <label>Especialidade:</label>
            <input type="text" name="especialidade">
            <label>Telefone:</label>
            <input type="text" name="telefone_mecanico">
            <label>Email:</label>
            <input type="email" name="email_mecanico">
            <label>Salário:</label>
            <input type="number" step="0.01" name="salario" placeholder="0.00">
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Salvar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>