<?php
// Conecta ao banco de dados "Cursos_Online" no MySQL
$mysqli = mysqli_connect('localhost', 'root', 'senaisp', 'Cursos_Online');

// Define as colunas que podem ser usadas para ordenar a tabela
$columns = array('nome', 'titulo', 'data_inscricao', 'nota', 'status');
// Verifica se o usuário passou uma coluna válida via GET para ordenação, senão usa a primeira do array
$column = isset($_GET['column']) && in_array($_GET['column'], $columns) ? $_GET['column'] : $columns[0];
// Verifica se a direção da ordenação foi passada via GET ('desc'), senão usa 'ASC'
$sort_order = isset($_GET['order']) && strtolower($_GET['order']) == 'desc' ? 'DESC' : 'ASC';

// Monta a query principal com JOINs entre Inscricoes, Alunos, Cursos e Avaliacoes
$query = "
    SELECT a.nome AS aluno, c.titulo AS curso, c.status, i.data_inscricao, av.nota, av.comentario
    FROM Inscricoes i
    LEFT JOIN Alunos a ON i.aluno_id = a.id
    LEFT JOIN Cursos c ON i.curso_id = c.id
    LEFT JOIN Avaliacoes av ON av.inscricao_id = i.id
    WHERE 1=1
";

// Adiciona a ordenação final da query
$query .= " ORDER BY $column $sort_order";

// Executa a query no banco de dados
$result = $mysqli->query($query);
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cursos Online</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f4f9;
        margin: 20px;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        background: #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #E60012;
        color: white;
        cursor: pointer;
    }
    th a {
        color: white;
        text-decoration: none;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
</style>
</head>
<body>

    <h2>Cursos Online - Inscrições e Avaliações</h2>

<table>
    <tr>
        <th><a href="?column=aluno&order=<?php echo $sort_order === 'ASC' ? 'desc' : 'asc'; ?>">Aluno</a></th>
        <th><a href="?column=curso&order=<?php echo $sort_order === 'ASC' ? 'desc' : 'asc'; ?>">Curso</a></th>
        <th><a href="?column=status&order=<?php echo $sort_order === 'ASC' ? 'desc' : 'asc'; ?>">Status</a></th>
        <th><a href="?column=data_inscricao&order=<?php echo $sort_order === 'ASC' ? 'desc' : 'asc'; ?>">Data Inscrição</a></th>
        <th><a href="?column=nota&order=<?php echo $sort_order === 'ASC' ? 'desc' : 'asc'; ?>">Nota</a></th>
        <th>Comentário</th>
    </tr>
    <?php while($row = $result->fetch_assoc()): ?>
    <tr>
        <td><?php echo htmlspecialchars($row['aluno'] ?? ''); ?></td>
        <td><?php echo htmlspecialchars($row['curso'] ?? ''); ?></td>
        <td><?php echo htmlspecialchars($row['status'] ?? ''); ?></td>
        <td><?php echo htmlspecialchars($row['data_inscricao'] ?? ''); ?></td>
        <td><?php echo htmlspecialchars($row['nota'] ?? ''); ?></td>
        <td><?php echo htmlspecialchars($row['comentario'] ?? ''); ?></td>
    </tr>
    <?php endwhile; ?>
</table>
</body>
</html>
