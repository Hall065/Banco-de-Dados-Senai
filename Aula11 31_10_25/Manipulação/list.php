<?php

$conn = new mysqli("localhost", "root", "senaisp", "livraria");
$result = $conn->query("SELECT * FROM usuarios");

echo"<h2>Usuários</h2>";
echo"<table border='1'>";
echo "<tr><th>ID</th><th>Nome</th><th>Email</th><th>Editar</th><th>Deletar</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo "<tr>
        <td>{$row['id']}</td>
        <td>{$row['nome']}</td>
        <td>{$row['email']}</td>
        <td>
            <a href='edit.php?id={$row['id']}'>Editar</a>
        </td>
        <td>
            <a href='delete.php?id={$row['id']}' onclick=\"return confirm('Tem certeza que deseja deletar este usuário?');\">Deletar</a>
        </td>
    </tr>";
}
echo "</table>";
$conn->close();
?>

<a href="index.html"><button type="button">Pagina Inicial</button></a>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f7f7;
        margin: 40px;
    }

    h2 {
        text-align: center;
        color: #333;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #007BFF;
        color: white;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    a {
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }

    button {
        display: block;
        margin: 30px auto;
        padding: 10px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    button:hover {
        background-color: #0056b3;
    }
</style>
