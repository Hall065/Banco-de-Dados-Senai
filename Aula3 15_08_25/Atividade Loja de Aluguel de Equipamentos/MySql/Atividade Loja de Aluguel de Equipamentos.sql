CREATE DATABASE Lunar;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente_Aluguel (
    ID_Cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Cliente VARCHAR(100) NOT NULL,
    Contato_Cliente VARCHAR(20),
    CPF VARCHAR(11) NOT NULL
);

-- Tabela Equipamento
CREATE TABLE IF NOT EXISTS Equipamento (
    ID_Equipamento INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Equipamento VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50),
    Valor_Diaria DECIMAL(10,2) NOT NULL
);

-- Tabela Aluguel
CREATE TABLE IF NOT EXISTS Aluguel (
    ID_Aluguel INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Data_Inicio DATE NOT NULL,
    Data_Fim DATE NOT NULL,
    ID_Cliente_Aluguel INT NOT NULL,
    ID_Equipamento INT NOT NULL,
    FOREIGN KEY (ID_Cliente_Aluguel) REFERENCES Cliente_Aluguel(ID_Cliente),
    FOREIGN KEY (ID_Equipamento) REFERENCES Equipamento(ID_Equipamento)
);
