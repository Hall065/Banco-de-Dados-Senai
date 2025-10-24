-- Cria o banco de dados e seleciona ele para uso
CREATE DATABASE Joins;
USE Joins;

-- ==============================
--   TABELAS CLIENTES E VENDAS
-- ==============================

-- Criação da tabela CLIENTES
CREATE TABLE Clientes (
    CODCLI CHAR(3) NOT NULL PRIMARY KEY,   -- Código do cliente (chave primária)
    NOME VARCHAR(40) NOT NULL,             -- Nome do cliente
    ENDERECO VARCHAR(50) NOT NULL,         -- Endereço completo
    CIDADE VARCHAR(20) NOT NULL,           -- Cidade onde mora
    ESTADO CHAR(2) NOT NULL,               -- Sigla do estado (UF)
    CEP CHAR(9) NOT NULL                   -- CEP do cliente
);

-- Criação da tabela VENDAS
CREATE TABLE Vendas (
    DUPLIC CHAR(6) NOT NULL PRIMARY KEY,   -- Código da duplicata (identificador da venda)
    VALOR DECIMAL(10,2) NOT NULL,          -- Valor da venda
    VENCTO DATE NOT NULL,                  -- Data de vencimento da duplicata
    CODCLI CHAR(3) NOT NULL,               -- Código do cliente que fez a compra
    FOREIGN KEY (CODCLI) REFERENCES Clientes(CODCLI) -- Chave estrangeira que liga ao cliente
);

-- ==============================
--   INSERÇÃO DE DADOS
-- ==============================

-- Inserindo clientes
INSERT INTO Clientes VALUES 
('250', 'BANCO BARCA S/A', 'R. VITO, 34', 'SAO SEBASTIAO', 'CE', '62380-000'),
('820', 'MECANICA SAO PAULO', 'R. DO MACUCO, 99', 'SANTO ANTONIO', 'ES', '29810-020'),
('170', 'POSTO BRASIL LTDA.', 'AV. IMPERIO, 85', 'GUAGIRUS', 'BA', '42837-000');

-- Inserindo vendas
INSERT INTO Vendas VALUES 
('230001', 1300.00, '2001-06-10', '250'),
('230099', 1000.00, '2002-10-02', '820'),
('997818', 3000.00, '2001-11-11', '170');

-- ==============================
--   CONSULTAS COM JOIN
-- ==============================

-- Consulta básica (JOIN antigo usando vírgula e WHERE)
SELECT CLIENTES.NOME, VENDAS.DUPLIC
FROM CLIENTES, VENDAS
WHERE CLIENTES.CODCLI = VENDAS.CODCLI;

-- INNER JOIN moderno: junta cliente e venda com base no código
SELECT VENDAS.DUPLIC, CLIENTES.NOME
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI;

-- INNER JOIN com cidade e ordenação alfabética
SELECT VENDAS.DUPLIC, CLIENTES.NOME, CLIENTES.CIDADE
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI
ORDER BY CLIENTES.NOME;

-- Contando quantas vendas cada cliente fez
SELECT CLIENTES.NOME, COUNT(*) AS QTDE
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI
GROUP BY CLIENTES.NOME;

-- Soma total de vendas por cliente (corrigido o GROUP BY)
SELECT CLIENTES.NOME, SUM(VENDAS.VALOR) AS TOTAL_VENDAS
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI
GROUP BY CLIENTES.NOME;

-- Maior valor de venda por duplicata
SELECT CLIENTES.NOME, VENDAS.DUPLIC, MAX(VENDAS.VALOR) AS MAIOR_VALOR
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI
GROUP BY VENDAS.DUPLIC;

-- Menor valor de venda por duplicata
SELECT CLIENTES.NOME, VENDAS.DUPLIC, MIN(VENDAS.VALOR) AS MENOR_VALOR
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI
GROUP BY VENDAS.DUPLIC;

SELECT CLIENTES.NOME, VENDAS.VENCTO
FROM CLIENTES INNER JOIN VENDAS
ON CLIENTES.CODCLI = VENDAS.CODCLI
WHERE YEAR(VENDAS.VENCTO) = 2001 OR MONTH(VENDAS.VENCTO) = 11
ORDER BY VENDAS.VENCTO;

-- ==============================
--   TESTES COM TABELAS SIMPLES (EX e FX)
-- ==============================

-- Cria duas tabelas com uma única coluna (para testar JOINs)
CREATE TABLE EX ( NOME VARCHAR(100) );
CREATE TABLE FX ( NOME VARCHAR(100) );

-- Inserindo nomes na tabela EX
INSERT INTO EX (NOME) VALUES
('BRUNO'),
('CARLOS'),
('ANA'),
('MARIA');

-- Inserindo nomes na tabela FX
INSERT INTO FX (NOME) VALUES
('CARLOS'),
('MARIA'),
('JOAO'),
('PEDRO');

-- INNER JOIN: mostra só nomes que estão nas duas tabelas
SELECT EX.NOME
FROM EX
INNER JOIN FX
ON EX.NOME = FX.NOME;

-- LEFT JOIN: mostra todos de EX + correspondentes de FX
SELECT EX.NOME, FX.NOME AS NOME_FX
FROM EX
LEFT JOIN FX
ON EX.NOME = FX.NOME;

-- RIGHT JOIN: mostra todos de FX + correspondentes de EX
SELECT FX.NOME, EX.NOME AS NOME_EX
FROM FX
RIGHT JOIN EX
ON FX.NOME = EX.NOME;

-- LEFT JOIN filtrado: mostra quem está em EX mas não em FX
SELECT EX.NOME
FROM EX
LEFT JOIN FX ON EX.NOME = FX.NOME
WHERE FX.NOME IS NULL;

-- LEFT JOIN filtrado: mostra quem está em FX mas não em EX
SELECT FX.NOME
FROM FX
LEFT JOIN EX ON FX.NOME = EX.NOME
WHERE EX.NOME IS NULL;

-- ===========================================
-- 🧩 1️⃣ UNION → Junta resultados e REMOVE duplicados
-- ===========================================
-- 🔹 Retorna todos os nomes das duas tabelas, mas sem repetir:
SELECT NOME FROM EX
UNION
SELECT NOME FROM FX;

-- ===========================================
-- 🧩 2️⃣ UNION ALL → Junta resultados e MANTÉM duplicados
-- ===========================================
-- 🔹 Mesmo que o anterior, mas mantém todos os nomes (mesmo repetidos)
SELECT NOME FROM EX
UNION ALL
SELECT NOME FROM FX;

-- ===========================================
-- 🧩 3️⃣ UNION ALL + Origem dos dados
-- ===========================================
-- 🔹 Adiciona uma coluna mostrando de qual tabela o nome veio
SELECT NOME, 'EX' AS TABELA
FROM EX
UNION ALL
SELECT NOME, 'FX' AS TABELA
FROM FX;

-- ===========================================
-- 🧮 4️⃣ “FULL JOIN” simulado com UNION
-- ===========================================
-- 🔹 Esse UNION combina os resultados do LEFT e RIGHT JOIN,
-- mostrando todos os nomes das duas tabelas:
-- MySQL não tem FULL OUTER JOIN nativo, mas dá pra simular assim:

SELECT EX.NOME AS NOME_EX, FX.NOME AS NOME_FX
FROM EX
LEFT JOIN FX ON EX.NOME = FX.NOME

UNION

SELECT EX.NOME AS NOME_EX, FX.NOME AS NOME_FX
FROM FX
LEFT JOIN EX ON FX.NOME = EX.NOME;

-- ===========================================
-- 🧠 5️⃣ Diferenças com JOINs (comparativo extra)
-- ===========================================

-- INNER JOIN → mostra só quem existe nas duas tabelas
SELECT EX.NOME
FROM EX
INNER JOIN FX
ON EX.NOME = FX.NOME;
-- Resultado: CARLOS, MARIA

-- LEFT JOIN → mostra todos de EX + correspondentes de FX
SELECT EX.NOME, FX.NOME AS NOME_FX
FROM EX
LEFT JOIN FX
ON EX.NOME = FX.NOME;
-- Resultado:
-- BRUNO | NULL
-- CARLOS | CARLOS
-- ANA | NULL
-- MARIA | MARIA

-- Quem está só em EX
SELECT EX.NOME
FROM EX
LEFT JOIN FX ON EX.NOME = FX.NOME
WHERE FX.NOME IS NULL;
-- Resultado: BRUNO, ANA

-- Quem está só em FX
SELECT FX.NOME
FROM FX
LEFT JOIN EX ON FX.NOME = EX.NOME
WHERE EX.NOME IS NULL;
-- Resultado: JOAO, PEDRO
