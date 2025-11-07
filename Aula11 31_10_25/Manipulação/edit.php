<?php
$conn = new mysqli("localhost", "root", "senaisp", "livraria");

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $id = $_POST["id"];
    $nome = $_POST["nome"];
    $email = $_POST["email"];

    $sql = "UPDATE usuarios SET nome='$nome', email='$email' WHERE id=$id";
    $conn->query($sql);

    echo "<p>Usuário atualizado com sucesso!</p>";
    echo "<a href='list.php'>Voltar para lista</a>";
    exit;
}

if (!isset($_GET["id"])) {
    die("Erro: ID não informado. <a href='list.php'>Voltar</a>");
}

$id = intval($_GET["id"]);
$result = $conn->query("SELECT * FROM usuarios WHERE id = $id");
$row = $result->fetch_assoc();

if (!$row) {
    die("Usuário não encontrado. <a href='list.php'>Voltar</a>");
}
?>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f3f4f6;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}
form {
    background: #fff;
    padding: 25px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    width: 320px;
    text-align: center;
}
form input[type="text"] {
    width: 90%;
    padding: 10px;
    margin: 8px 0 16px 0;
    border: 1px solid #ccc;
    border-radius: 8px;
    outline: none;
    transition: border 0.2s;
}
form input[type="text"]:focus {
    border-color: #007bff;
}
form input[type="submit"] {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 16px;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.2s;
}
form input[type="submit"]:hover {
    background-color: #0056b3;
}
</style>

<form action="edit.php" method="POST">
    <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
    Nome: <input type="text" name="nome" value="<?php echo $row['nome']; ?>"><br>
    Email: <input type="text" name="email" value="<?php echo $row['email']; ?>"><br>
    <input type="submit" value="Atualizar">
</form>
