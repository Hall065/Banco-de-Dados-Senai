	-- Ex2
-- Criando o banco de dados
CREATE DATABASE IF NOT EXISTS BD_Fornecimento;
USE BD_Fornecimento;

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    Fcodigo INT AUTO_INCREMENT PRIMARY KEY,
    Fnome VARCHAR(100) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Ativo',
    Cidade VARCHAR(100)
);

-- Tabela Peca
CREATE TABLE Peca (
    Pcodigo INT AUTO_INCREMENT PRIMARY KEY,
    Pnome VARCHAR(100) NOT NULL,
    Cor VARCHAR(50) NOT NULL,
    Peso DECIMAL(10,2) NOT NULL,
    Cidade VARCHAR(100) NOT NULL
);

-- Tabela Instituicao
CREATE TABLE Instituicao (
    Icodigo INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela Projeto
CREATE TABLE Projeto (
    PRcod INT AUTO_INCREMENT PRIMARY KEY,
    PRnome VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100),
    Icod INT NOT NULL,
    FOREIGN KEY (Icod) REFERENCES Instituicao(Icodigo)
);

-- Tabela Fornecimento
CREATE TABLE Fornecimento (
    Fcod INT NOT NULL,
    Pcod INT NOT NULL,
    PRcod INT NOT NULL,
    Quantidade INT NOT NULL,

    PRIMARY KEY (Fcod, Pcod, PRcod),
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcodigo),
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcodigo),
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod)
);

	-- Ex 3
-- Criando a nova tabela Cidade
CREATE TABLE Cidade (
    Ccod INT AUTO_INCREMENT PRIMARY KEY,
    Cnome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

-- Alterando a tabela Fornecedor
ALTER TABLE Fornecedor 
	CHANGE COLUMN Fcodigo Fcod INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Fornecedor
    ADD COLUMN Fone VARCHAR(20),
    ADD COLUMN Ccod INT,
    ADD CONSTRAINT fk_fornecedor_cidade FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

-- Alterando a tabela Peca
ALTER TABLE Peca 
	CHANGE COLUMN Pcodigo Pcod INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Peca
    DROP COLUMN Cidade, 
    ADD COLUMN Ccod INT NOT NULL,
    ADD CONSTRAINT fk_peca_cidade FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

-- Alterando a tabela Projeto
ALTER TABLE Projeto DROP FOREIGN KEY projeto_ibfk_1;
ALTER TABLE Projeto 
    DROP COLUMN Cidade, 
    DROP COLUMN Icod;
ALTER TABLE Projeto 
    ADD COLUMN Ccod INT,
    ADD CONSTRAINT fk_projeto_cidade FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

-- Excluindo a tabela Instituicao
DROP TABLE Instituicao;

	-- Ex4
-- Índice para buscar fornecedores pelo nome
CREATE INDEX idx_fornecedor_nome ON Fornecedor(Fnome);

-- Índice para buscar peças pela cor
CREATE INDEX idx_peca_cor ON Peca(Cor);

-- Índice para buscar projetos pelo nome
CREATE INDEX idx_projeto_nome ON Projeto(PRnome);
