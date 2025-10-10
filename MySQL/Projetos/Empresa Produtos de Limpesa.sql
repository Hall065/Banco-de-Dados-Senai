-- Criação do banco de dados
CREATE DATABASE Empresa_Produtos_Limpeza;
USE Empresa_Produtos_Limpeza;

-- Tabela: Produtos
CREATE TABLE Produtos (
    Cod_Produto INT PRIMARY KEY,
    Nome_Produto VARCHAR(100),
    Preco_Unitario DECIMAL(10, 2),
    Descricao TEXT,
    Tipo_Produto VARCHAR(50),
    Estoque_Atual INT
);

-- Tabela: Clientes
CREATE TABLE Clientes (
    Cod_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR(100),
    Tipo_Cliente ENUM('Pessoa Física', 'Empresa'),
    CPF_CNPJ VARCHAR(20),
    Email VARCHAR(100),
    Telefone VARCHAR(20),
    Endereco TEXT
);

-- Tabela: Funcionarios
CREATE TABLE Funcionarios (
    Cod_Funcionario INT PRIMARY KEY,
    Nome_Funcionario VARCHAR(100),
    Cargo VARCHAR(50),
    CPF CHAR(11),
    Telefone VARCHAR(20)
);

-- Tabela: Vendas
CREATE TABLE Vendas (
    Cod_Venda INT PRIMARY KEY,
    Cod_Cliente INT,
    Data_Venda DATE,
    Valor_Total DECIMAL(10, 2)
);

-- Tabela: Itens_Venda
CREATE TABLE Itens_Venda (
    Cod_Item INT PRIMARY KEY,
    Cod_Venda INT,
    Cod_Produto INT,
    Quantidade INT,
    Preco_Unitario DECIMAL(10,2)
);

-- Tabela: Servicos
CREATE TABLE Servicos (
    Cod_Servico INT PRIMARY KEY,
    Cod_Cliente INT,
    Cod_Funcionario INT,
    Nome_Servico VARCHAR(100),
    Data_Servico DATE,
    Valor_Servico DECIMAL(10,2),
    Descricao TEXT
);

-- Tabela: Processos
CREATE TABLE Processos (
    Cod_Processo INT PRIMARY KEY,
    Nome_Processo VARCHAR(100),
    Responsavel INT,
    Data_Processo DATE,
    Descricao TEXT
);