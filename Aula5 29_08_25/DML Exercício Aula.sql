-- Start --

-- Atividade DML --

-- Criar BCD --
CREATE DATABASE REMOTERC;

-- Iniciar BCD --
USE REMOTERC;

-- Tabela Produtos --
CREATE TABLE PRODUTOS (
  CProd INT PRIMARY KEY,
  Descricao VARCHAR(50),
  Peso VARCHAR(10),
  ValorUnit DECIMAL(10,2)
);

-- Inserir Dados na Tabela Produtos --
INSERT INTO PRODUTOS (CProd, Descricao, Peso, ValorUnit)
VALUES
(1, 'Teclado', 'KG', 35.00),
(2, 'Mouse', 'KG', 25.00),
(3, 'HD', 'KG', 350.00);

-- Tabela Vendedor --
CREATE TABLE VENDEDOR (
  CVend INT PRIMARY KEY,
  Nome VARCHAR(50),
  Salario DECIMAL(10,2),
  FSalario INT
);

-- Inserir Dados na Tabela Vendedor --
INSERT INTO VENDEDOR (CVend, Nome, Salario, FSalario)
VALUES
(1, 'Ronaldo', 3512.00, 1),
(2, 'Robertson', 3225.00, 2),
(3, 'Clodoaldo', 4350.00, 3);

-- Tabela Cliente --
CREATE TABLE CLIENTE (
  CCli INT PRIMARY KEY,
  Nome VARCHAR(50),
  Endereco VARCHAR(100),
  Cidade VARCHAR(50),
  UF CHAR(2)
);

-- Inserir Dados na Tabela Cliente --
INSERT INTO CLIENTE (CCli, Nome, Endereco, Cidade, UF)
VALUES
(11, 'Bruno', 'Rua 1 456', 'Rio Claro', 'SP'),
(12, 'Cláudio', 'Rua Quadrada 234', 'Campinas', 'SP'),
(13, 'Cremilda', 'Rua das Flores 666', 'São Paulo', 'SP');

-- Exeplos de Uso dos Comandos Update e Delete --
UPDATE VENDEDOR
SET Salario = Salario * 1.10
WHERE CVend = 1;

UPDATE CLIENTE
SET Endereco = 'Avenida Paulista 1000'
WHERE CCli = 13;

UPDATE PRODUTOS
SET ValorUnit = 30.00
WHERE Cprod = 2;

DELETE FROM CLIENTE
WHERE CCli = 12;

DELETE FROM PRODUTOS
WHERE CProd = 3;

DELETE FROM VENDEDOR
WHERE CVend = 3;

INSERT INTO VENDEDOR (CVend, Nome, Salario, FSalario)
VALUES
(3, 'Valentina', 2350.00, 3),
(4, 'James', 4350.00, 3);

-- Desafio --
-- 1 --
UPDATE VENDEDOR
SET Salario = 3150.00
WHERE CVend = 1;

-- 2 --
UPDATE VENDEDOR
SET Salario = Salario*1.10
WHERE CVend = 2;

-- 3 --
UPDATE VENDEDOR
SET Salario = 3500.00
WHERE CVend = 3;

-- Vizializar Tabelas --
SELECT * FROM PRODUTOS;
SELECT * FROM VENDEDOR;
SELECT * FROM CLIENTE;

-- End --