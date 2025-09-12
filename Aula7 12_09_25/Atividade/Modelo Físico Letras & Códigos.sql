-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Autor (
id_autor Texto(1) PRIMARY KEY,
data_nascimento Texto(1),
nacionalidade Texto(1),
nome_autor Texto(1)
)

CREATE TABLE Livro (
genero Texto(1),
titulo Texto(1),
preco Texto(1),
codigo_livro Texto(1) PRIMARY KEY,
quantidade Texto(1),
id_editora Texto(1) FK
)

CREATE TABLE Editora (
nome_editora Texto(1),
endereco Texto(1),
contato Texto(1),
cidade Texto(1),
id_editora Texto(1) PRIMARY KEY,
cnpj Texto(1),
telefone_editora Texto(1)
)

CREATE TABLE Cliente (
cpf Texto(1),
nome_cliente Texto(1),
telefone_cliente Texto(1),
email Texto(1),
id_cliente Texto(1) PRIMARY KEY,
data_nascimento Texto(1)
)

CREATE TABLE Venda (
id_venda Texto(1) PRIMARY KEY,
valor_total Texto(1),
data_venda Texto(1),
id_cliente Texto(1) FK
)

CREATE TABLE ItemVenda (
id_venda Texto(1),
codigo_livro Texto(1),
FOREIGN KEY(id_venda) REFERENCES Venda (id_venda),
FOREIGN KEY(codigo_livro) REFERENCES Livro (codigo_livro)
)

CREATE TABLE LivroAutor (
id_autor Texto(1),
codigo_livro Texto(1),
FOREIGN KEY(id_autor) REFERENCES Autor (id_autor),
FOREIGN KEY(codigo_livro) REFERENCES Livro (codigo_livro)
)

CREATE TABLE VendaCliente (
id_cliente Texto(1),
id_venda Texto(1),
FOREIGN KEY(id_cliente) REFERENCES Cliente (id_cliente)
)

CREATE TABLE LivroEditora (
id_editora Texto(1),
codigo_livro Texto(1),
FOREIGN KEY(id_editora) REFERENCES Editora (id_editora),
FOREIGN KEY(codigo_livro) REFERENCES Livro (codigo_livro)
)

