CREATE DATABASE Solar;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    ID_Cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Cliente VARCHAR(100),
    Endereco_Cliente VARCHAR(100),
    Contato_Cliente VARCHAR(20),
    CPF VARCHAR(11) NOT NULL
);

-- Tabela Fornecedor
CREATE TABLE IF NOT EXISTS Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Fornecedor VARCHAR(100),
    Endereco_Fornecedor VARCHAR(200),
    Contato_Fornecedor VARCHAR(20),
    CNPJ VARCHAR(18) NOT NULL,
    Estado CHAR(2) DEFAULT '2',
    Cidade VARCHAR(50)
);

-- Tabela Produto
CREATE TABLE IF NOT EXISTS Produto (
    ID_Produto INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Produto VARCHAR(100),
    Descricao_Produto VARCHAR(500),
    Valor_Produto DECIMAL(10,2),
    Quantidade_Produto INT
);

-- Tabela Departamento
CREATE TABLE IF NOT EXISTS Departamento (
    ID_Departamento INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Departamento VARCHAR(100) NOT NULL,
    Localizacao VARCHAR(100)
);

-- Tabela Funcionarios
CREATE TABLE IF NOT EXISTS Funcionarios (
    ID_Funcionario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Funcionario VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50),
    Salario DECIMAL(10,2),
    ID_Departamento INT NOT NULL,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

-- Tabela Vender (Fornecedor -> Produto)
CREATE TABLE IF NOT EXISTS Vender (
	ID_Venda INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ID_Produto INT NOT NULL,
    ID_Fornecedor INT NOT NULL,
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

-- Tabela Comprar (Cliente -> Produto)
CREATE TABLE IF NOT EXISTS Comprar (
	ID_Venda INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Produto INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Relação Funcionário → Venda
CREATE TABLE IF NOT EXISTS Funcionario_Venda (
    ID_FuncVenda INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ID_Funcionario INT NOT NULL,
    ID_Venda INT NOT NULL,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID_Funcionario),
    FOREIGN KEY (ID_Venda) REFERENCES Comprar(ID_Venda)
);

 -- Alterar Tabelas
 SELECT * FROM funcionarios;
 
 -- Alterar em Tabelas
 -- Adicionar Coluna
ALTER TABLE funcionarios
ADD Sexo Char(1);
  
 -- Remover Coluna
ALTER TABLE empregado
DROP COLUMN Sexo;

 -- Renomear Tabela
ALTER TABLE empregrado
RENAME TO empregado;

ALTER TABLE empregado
CHANGE Nome_Funcionario Nome_Empregado VARCHAR(18);

ALTER TABLE fornecedor
MODIFY COLUMN Estado CHAR(12) DEFAULT 'MG';

ALTER TABLE fornecedor
ADD PRIMARY KEY (CNPJ);

