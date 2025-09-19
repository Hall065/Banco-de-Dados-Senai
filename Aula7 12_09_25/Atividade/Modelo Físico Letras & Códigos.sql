-- Criação do banco
CREATE DATABASE LetrasCodigos;
USE LetrasCodigos;

-- Tabela Autor
CREATE TABLE Autor (
    id_autor VARCHAR(50) PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

-- Tabela Editora
CREATE TABLE Editora (
    id_editora VARCHAR(50) PRIMARY KEY,
    nome_editora VARCHAR(100) NOT NULL,
    endereco VARCHAR(150),
    contato VARCHAR(100),
    cidade VARCHAR(50),
    cnpj VARCHAR(20) NOT NULL UNIQUE,
    telefone_editora VARCHAR(20)
);

-- Tabela Livro
CREATE TABLE Livro (
    codigo_livro VARCHAR(50) PRIMARY KEY,
    genero VARCHAR(50),
    titulo VARCHAR(150) NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    id_editora VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_editora) REFERENCES Editora(id_editora)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
ALTER TABLE Livro
ADD COLUMN data_publicacao DATE;

UPDATE Livro
SET data_publicacao = '1899-01-01'
WHERE codigo_livro = 'L1';

UPDATE Livro
SET data_publicacao = '1997-06-26'
WHERE codigo_livro = 'L2';

UPDATE Livro
SET data_publicacao = '1996-08-06'
WHERE codigo_livro = 'L3';

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente VARCHAR(50) PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone_cliente VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_nascimento DATE
);

-- Tabela Venda
CREATE TABLE Venda (
    id_venda VARCHAR(50) PRIMARY KEY,
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    data_venda DATE NOT NULL,
    id_cliente VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela ItemVenda (N:N entre Venda e Livro)
CREATE TABLE ItemVenda (
    id_venda VARCHAR(50),
    codigo_livro VARCHAR(50),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED,
    PRIMARY KEY (id_venda, codigo_livro),
    FOREIGN KEY (id_venda) REFERENCES Venda(id_venda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (codigo_livro) REFERENCES Livro(codigo_livro)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela LivroAutor (N:N entre Livro e Autor)
CREATE TABLE LivroAutor (
    id_autor VARCHAR(50),
    codigo_livro VARCHAR(50),
    PRIMARY KEY (id_autor, codigo_livro),
    FOREIGN KEY (id_autor) REFERENCES Autor(id_autor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (codigo_livro) REFERENCES Livro(codigo_livro)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Consultar todos os registros das tabelas

SELECT * FROM Autor;

SELECT * FROM Editora;

SELECT * FROM Livro;
    -- Consulta Por Ano de Publicação < 2015
    SELECT titulo FROM Livro WHERE YEAR(data_publicacao) < 2015;
    -- Consultar Por Titulo e Ano em Ordem Decrescente
    SELECT * FROM Livro WHERE titulo LIKE '%A%' ORDER BY YEAR(data_publicacao) DESC;
    -- Limitar Consultas Por Valor de Quantidade Apresentadas
    SELECT titulo FROM Livro LIMIT 5;
    -- Renomear Coluna na Consulta
    SELECT titulo AS Nome, data_publicacao AS Ano FROM Livro;
    -- Consultas Agregadas
    SELECT COUNT(*) AS Total_Livros FROM Livro;
    -- Consultas com Joins
    SELECT l.titulo, a.nome_autor
    FROM Livro l
    JOIN LivroAutor la ON l.codigo_livro = la.codigo_livro
    JOIN Autor a ON la.id_autor = a.id_autor;
    -- Consulta Por Agrupamentos Group By
    SELECT titulo, COUNT(*) AS Numero_Autores
    FROM Livro l
    GROUP BY l.titulo;

SELECT * FROM Cliente;

SELECT * FROM Venda;

SELECT * FROM ItemVenda;

SELECT * FROM LivroAutor;


-- Inserindo autores
INSERT INTO Autor (id_autor, nome_autor, nacionalidade, data_nascimento) VALUES
('A1', 'Machado de Assis', 'Brasileiro', '1839-06-21'),
('A2', 'J.K. Rowling', 'Britânica', '1965-07-31'),
('A3', 'George R. R. Martin', 'Americano', '1948-09-20');

-- Inserindo editoras
INSERT INTO Editora (id_editora, nome_editora, endereco, contato, cidade, cnpj, telefone_editora) VALUES
('E1', 'Editora Globo', 'Rua das Letras, 100', 'contato@globo.com', 'São Paulo', '12.345.678/0001-99', '11999999999'),
('E2', 'Bloomsbury Publishing', '50 Bedford Square', 'contact@bloomsbury.com', 'Londres', '98.765.432/0001-55', '+442012345678');

-- Inserindo livros
INSERT INTO Livro (codigo_livro, genero, titulo, preco, quantidade, id_editora) VALUES
('L1', 'Romance', 'Dom Casmurro', 35.90, 50, 'E1'),
('L2', 'Fantasia', 'Harry Potter e a Pedra Filosofal', 45.00, 100, 'E2'),
('L3', 'Fantasia', 'A Guerra dos Tronos', 60.00, 30, 'E2');

-- Relacionando livros e autores
INSERT INTO LivroAutor (id_autor, codigo_livro) VALUES
('A1', 'L1'),
('A2', 'L2'),
('A3', 'L3');

-- Inserindo clientes
INSERT INTO Cliente (id_cliente, cpf, nome_cliente, telefone_cliente, email, data_nascimento) VALUES
('C1', '123.456.789-00', 'Ana Silva', '11988887777', 'ana@gmail.com', '1990-05-10'),
('C2', '987.654.321-00', 'Carlos Souza', '21977776666', 'carlos@gmail.com', '1985-03-15');

-- Inserindo vendas
INSERT INTO Venda (id_venda, valor_total, data_venda, id_cliente) VALUES
('V1', 80.90, '2025-09-19', 'C1'),
('V2', 105.00, '2025-09-19', 'C2');

-- Itens das vendas
INSERT INTO ItemVenda (id_venda, codigo_livro, quantidade, preco_unitario) VALUES
('V1', 'L1', 1, 35.90),
('V1', 'L2', 1, 45.00),
('V2', 'L3', 1, 60.00),
('V2', 'L2', 1, 45.00);
