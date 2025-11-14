<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_mecanico"];
    $nome = $_POST["nome_mecanico"];
    $especialidade = $_POST["especialidade"];
    $telefone = $_POST["telefone_mecanico"];
    $email = $_POST["email_mecanico"];
    $salario = $_POST["salario"];

    $stmt = $conn->prepare("UPDATE Mecanico SET nome_mecanico=?, especialidade=?, telefone_mecanico=?, email_mecanico=?, salario=? WHERE id_mecanico=?");
    $stmt->bind_param("ssssdi", $nome, $especialidade, $telefone, $email, $salario, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM Mecanico WHERE id_mecanico = $id");
$row = $result->fetch_assoc();
if (!$row) die("Não encontrado. <a href='list.php'>Voltar</a>");
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Mecânico</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header><h1>✏️ Editar Mecânico</h1></header>
        <form action="edit.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>
            <input type="hidden" name="id_mecanico" value="<?php echo $row['id_mecanico']; ?>">
            <label>Nome:</label>
            <input type="text" name="nome_mecanico" value="<?php echo htmlspecialchars($row['nome_mecanico']); ?>" required>
            <label>Especialidade:</label>
            <input type="text" name="especialidade" value="<?php echo htmlspecialchars($row['especialidade']); ?>">
            <label>Telefone:</label>
            <input type="text" name="telefone_mecanico" value="<?php echo htmlspecialchars($row['telefone_mecanico']); ?>">
            <label>Email:</label>
            <input type="email" name="email_mecanico" value="<?php echo htmlspecialchars($row['email_mecanico']); ?>">
            <label>Salário:</label>
            <input type="number" step="0.01" name="salario" value="<?php echo $row['salario']; ?>">
            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar</a>
            </div>
        </form>
    </div>
</body>
</html>