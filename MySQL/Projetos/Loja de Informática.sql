-- Criação do banco de dados
CREATE DATABASE Loja_Informatica;
USE Loja_Informatica;

-- Tabela: Produtos
CREATE TABLE Produtos (
    Cod_Produto INT PRIMARY KEY,
    Nome_Produto VARCHAR(100),
    Preco_Produto DECIMAL(10, 2),
    Descricao_Produto TEXT,
    Qtde_Produto INT
);

-- Tabela: Estoque
CREATE TABLE Estoque (
    Cod_Estoque INT PRIMARY KEY,
    Local_Estoque VARCHAR(100),
    Qntd_Estoque INT,
    Nome_Produto VARCHAR(100),
    Observacao_Produto TEXT
    -- Seria melhor referenciar Cod_Produto, mas o modelo usa Nome_Produto
);

-- Tabela: Funcionarios
CREATE TABLE Funcionarios (
    Cod_Funcionario INT PRIMARY KEY,
    Nome_Func VARCHAR(100),
    Cargo_Fun VARCHAR(100),
    Idade_Func INT,
    CPF_Func CHAR(11)
);

-- Tabela: Servicos
CREATE TABLE Servicos (
    Cod_Servico INT PRIMARY KEY,
    Preco_Servico DECIMAL(10, 2),
    Nome_Servico VARCHAR(100),
    Data_Servico DATE,
    Descricao_Servico TEXT
);

-- Tabela: Cliente
CREATE TABLE Cliente (
    Cod_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR(100),
    CPF_Client CHAR(11),
    Email_Cliente VARCHAR(100),
    Conta_Cliente VARCHAR(50)
);
