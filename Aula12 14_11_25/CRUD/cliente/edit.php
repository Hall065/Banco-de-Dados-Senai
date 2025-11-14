<?php
$conn = new mysqli("localhost", "root", "senaisp", "oficina");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_cliente"];
    $nome = $_POST["nome_cliente"];
    $cpf = $_POST["cpf"];
    $email = $_POST["email_cliente"];
    $telefone = $_POST["telefone_cliente"];
    $endereco = $_POST["endereco"];

    $stmt = $conn->prepare("UPDATE Cliente SET nome_cliente=?, cpf=?, email_cliente=?, telefone_cliente=?, endereco=? WHERE id_cliente=?");
    $stmt->bind_param("sssssi", $nome, $cpf, $email, $telefone, $endereco, $id);

    if ($stmt->execute()) {
        header("Location: list.php");
        exit;
    } else {
        $error = "Erro ao atualizar: " . $stmt->error;
    }
    $stmt->close();
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM Cliente WHERE id_cliente = $id");
$row = $result->fetch_assoc();

if (!$row) {
    die("Cliente não encontrado. <a href='list.php'>Voltar</a>");
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Cliente</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>✏️ Editar Cliente</h1>
        </header>

        <form action="edit.php" method="POST" class="form-box">
            <?php if (isset($error)): ?>
                <div class="message error"><?php echo $error; ?></div>
            <?php endif; ?>

            <input type="hidden" name="id_cliente" value="<?php echo $row['id_cliente']; ?>">

            <label>Nome:</label>
            <input type="text" name="nome_cliente" value="<?php echo htmlspecialchars($row['nome_cliente']); ?>" required>

            <label>CPF:</label>
            <input type="text" name="cpf" value="<?php echo htmlspecialchars($row['cpf']); ?>" required>

            <label>Email:</label>
            <input type="email" name="email_cliente" value="<?php echo htmlspecialchars($row['email_cliente']); ?>">

            <label>Telefone:</label>
            <input type="text" name="telefone_cliente" value="<?php echo htmlspecialchars($row['telefone_cliente']); ?>">

            <label>Endereço:</label>
            <input type="text" name="endereco" value="<?php echo htmlspecialchars($row['endereco']); ?>">

            <button type="submit" class="btn btn-success" style="width: 100%;">💾 Atualizar</button>
            
            <div style="text-align: center;">
                <a href="list.php" class="back-link">← Voltar para lista</a>
            </div>
        </form>
    </div>
</body>
</html>