<?php
// Conexão com o banco de dados
$mysqli = mysqli_connect('localhost', 'root', 'senaisp', 'LetrasCodigos');

// Segurança: colunas válidas para ordenação
$columns = array('titulo', 'data_publicacao', 'preco', 'nome_autor');

// Coluna para ordenar (padrão = primeira do array)
$column = isset($_GET['column']) && in_array($_GET['column'], $columns) ? $_GET['column'] : $columns[0];

// Direção da ordenação (ASC ou DESC)
$sort_order = isset($_GET['order']) && strtolower($_GET['order']) == 'desc' ? 'DESC' : 'ASC';

// Query com JOIN para trazer o nome do autor
$query = "
SELECT l.titulo, l.data_publicacao, l.preco, a.nome_autor
FROM Livro l
LEFT JOIN LivroAutor la ON l.codigo_livro = la.codigo_livro
LEFT JOIN Autor a ON la.id_autor = a.id_autor
ORDER BY $column $sort_order
";

if ($result = $mysqli->query($query)) {

    // Transformar ASC/DESC em up/down
    $up_or_down = str_replace(array('ASC', 'DESC'), array('up', 'down'), $sort_order);

    // Alternar direção para próximo clique
    $asc_or_desc = $sort_order == 'ASC' ? 'desc' : 'asc';
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Banco de Dados - Codigos & Letras</title>
<style>
    .highlight {
        background-color: #f0f0f0;
    }
    th a {
        text-decoration: none;
        color: black;
    }
</style>
</head>
<body>
<table border="1" cellpadding="5">
    <tr>
        <th><a href="index.php?column=titulo&order=<?php echo $asc_or_desc; ?>">Título <?php echo $column == 'titulo' ? '-' . $up_or_down : ''; ?></a></th>
        <th><a href="index.php?column=data_publicacao&order=<?php echo $asc_or_desc; ?>">Data Publicação <?php echo $column == 'data_publicacao' ? '-' . $up_or_down : ''; ?></a></th>
        <th><a href="index.php?column=preco&order=<?php echo $asc_or_desc; ?>">Preço <?php echo $column == 'preco' ? '-' . $up_or_down : ''; ?></a></th>
        <th><a href="index.php?column=nome_autor&order=<?php echo $asc_or_desc; ?>">Autor <?php echo $column == 'nome_autor' ? '-' . $up_or_down : ''; ?></a></th>
    </tr>

    <?php while ($row = $result->fetch_assoc()): ?>
    <tr>
        <td><?php echo $row['titulo']; ?></td>
        <td><?php echo $row['data_publicacao']; ?></td>
        <td><?php echo $row['preco']; ?></td>
        <td><?php echo $row['nome_autor']; ?></td>
    </tr>
    <?php endwhile; ?>
</table>
</body>
</html>
<?php
} // query end
?>
