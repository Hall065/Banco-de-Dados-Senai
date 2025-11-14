CREATE DATABASE oficina;
USE oficina;

-- ================= CLIENTE =================
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email_cliente VARCHAR(100),
    telefone_cliente VARCHAR(15),
    endereco VARCHAR(100)
);

-- ================= VEICULO =================
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(20),
    marca VARCHAR(20),
    placa VARCHAR(8) UNIQUE,
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- ================= MECANICO =================
CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome_mecanico VARCHAR(100) NOT NULL,
    especialidade VARCHAR(20),
    telefone_mecanico VARCHAR(15),
    email_mecanico VARCHAR(100),
    salario DECIMAL(10,2)
);

-- ================= SERVICO =================
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    tempo_estimado TIME,
    codigo INT,
    categoria VARCHAR(100),
    descricao VARCHAR(100),
    preco DECIMAL(10,2)
);

-- ================= ORDEM DE SERVIÇO =================
CREATE TABLE OrdemServico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_abertura DATE,
    data_fechamento DATE,
    status VARCHAR(100),
    observacoes VARCHAR(100),
    id_veiculo INT,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

-- ================= OS_SERVICO =================
CREATE TABLE OS_Servico (
    id_os_servico INT AUTO_INCREMENT PRIMARY KEY,
    preco_un DECIMAL(10,2),
    quantidade INT,
    subtotal DECIMAL(10,2),
    id_servico INT,
    id_os INT,
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico),
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os)
);

-- ================= INSERTS =================
INSERT INTO Cliente (nome_cliente, cpf, email_cliente, telefone_cliente, endereco) VALUES
('João Mendes', '123.456.789-00', 'joao@gmail.com', '11987654321', 'Rua Alfa, 120'),
('Carla Souza', '987.654.321-00', 'carla@hotmail.com', '11999887766', 'Av. Beta, 455'),
('Marcos Silva', '111.222.333-44', 'marcos@outlook.com', '11988776655', 'Rua Gama, 80');

INSERT INTO Veiculo (modelo, marca, placa, ano, id_cliente) VALUES
('Civic', 'Honda', 'ABC1A23', 2018, 1),
('Corolla', 'Toyota', 'XYZ9B88', 2020, 2),
('Gol', 'Volkswagen', 'DEF3C45', 2012, 1),
('Onix', 'Chevrolet', 'GHI4D67', 2019, 3);

INSERT INTO Mecanico (nome_mecanico, especialidade, telefone_mecanico, email_mecanico, salario) VALUES
('Pedro Santos', 'Motor', '11991234567', 'pedro@oficina.com', 3200.00),
('Rafael Martins', 'Suspensão', '11992345678', 'rafael@oficina.com', 3000.00),
('André Costa', 'Elétrica', '11993456789', 'andre@oficina.com', 3500.00);

INSERT INTO Servico (tempo_estimado, codigo, categoria, descricao, preco) VALUES
('01:00:00', 101, 'Revisão', 'Troca de óleo', 120.00),
('02:00:00', 202, 'Suspensão', 'Alinhamento e balanceamento', 150.00),
('00:45:00', 303, 'Elétrica', 'Verificação de bateria', 80.00),
('03:00:00', 404, 'Motor', 'Limpeza de bicos injetores', 250.00);

INSERT INTO OrdemServico (data_abertura, data_fechamento, status, observacoes, id_veiculo) VALUES
('2025-11-01', '2025-11-02', 'Concluída', 'Cliente pediu revisão geral.', 1),
('2025-11-03', NULL, 'Em andamento', 'Problema na suspensão.', 2),
('2025-11-05', '2025-11-06', 'Concluída', 'Troca de bateria realizada.', 4);

INSERT INTO OS_Servico (preco_un, quantidade, subtotal, id_servico, id_os) VALUES
(120.00, 1, 120.00, 1, 1),   -- Troca de óleo - OS 1
(150.00, 1, 150.00, 2, 2),   -- Alinhamento - OS 2
(80.00,  1, 80.00,  3, 3),   -- Bateria - OS 3
(250.00, 1, 250.00, 4, 1);   -- Limpeza de bico - OS 1