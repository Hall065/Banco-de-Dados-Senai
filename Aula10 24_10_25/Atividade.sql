CREATE DATABASE Joins_Atividade;
USE Joins_Atividade;

-- ==============================
--   TABELAS CLIENTES E VENDAS
-- ==============================

-- Criação da tabela CLIENTES
CREATE TABLE cliente (
    CODCLI CHAR(3) NOT NULL PRIMARY KEY,   -- Código do cliente (chave primária)
    NOME VARCHAR(40) NOT NULL,             -- Nome do cliente
    ENDERECO VARCHAR(50) NOT NULL,         -- Endereço completo
    CIDADE VARCHAR(20) NOT NULL,           -- Cidade onde mora
    ESTADO CHAR(2) NOT NULL,               -- Sigla do estado (UF)
    CEP CHAR(9) NOT NULL                   -- CEP do cliente
);

-- Criação da tabela VENDAS
CREATE TABLE venda (
    DUPLIC CHAR(6) NOT NULL PRIMARY KEY,   -- Código da duplicata (identificador da venda)
    VALOR DECIMAL(10,2) NOT NULL,          -- Valor da venda
    VENCTO DATE NOT NULL,                  -- Data de vencimento da duplicata
    CODCLI CHAR(3) NOT NULL,               -- Código do cliente que fez a compra
    FOREIGN KEY (CODCLI) REFERENCES cliente(CODCLI) -- Chave estrangeira que liga ao cliente
);

-- INSERÇÃO DE DADOS NA TABELA CLIENTE
INSERT INTO cliente (CODCLI, NOME, ENDERECO, CIDADE, ESTADO, CEP) VALUES
('250', 'BANCO BARCA S/A', 'R. VITO, 34', 'SAO SEBASTIAO', 'CE', '62380-000'),
('820', 'MECANICA SAO PAULO', 'R. DO MACUCO, 99', 'SANTO ANTONIO', 'ES', '29810-020'),
('170', 'POSTO BRASIL LTDA.', 'AV. IMPERIO, 85', 'GUAGIRUS', 'BA', '42837-000'),
('340', 'TRANSP. CARGA PESADA LTDA.', 'AV. DOS AUTONOMISTAS, 1000', 'OSASCO', 'SP', '06020-010'),
('100', 'MICROS INFORMATICA S/A', 'R. DAS PALMEIRAS, 4 - LOJA 2', 'SAO PAULO', 'SP', '01226-010'),
('750', 'IMOBILIARIA PAVAO', 'AV. BRASIL, 105', 'RIO DO PRADO', 'MG', '39940-111'),
('860', 'ASSIS CONTABIL S/C LTDA.', 'R. DO MONUMENTO, 550', 'SANTO AMARO', 'BA', '44200-090'),
('230', 'SUPERMERCADO BOTAFOGO', 'R. DA LAGOA, 999', 'RIO DAS OSTRAS', 'RJ', '28890-540'),
('150', 'MARCONDES E IRMAO LTDA.', 'R. DO ORATORIO, 66', 'ROSARIO OESTE', 'MT', '78470-010'),
('800', 'DOCEIRA PAO DE ACUCAR', 'R. MARTINS PENA, 200', 'SANTO ANDRE', 'SP', '09190-700'),
('990', 'METALURGICA FOGO E FERRO', 'R. ARTUR BERNARDES, 3500', 'SANTO ANDRE', 'SP', '09193-410'),
('500', 'JOSE DANTAS E FILHOS S/C LTDA.', 'AV. IPIRANGA, 1000', 'LUCRECIA', 'RN', '59805-010'),
('300', 'PCTEC - MICROCOMPUTADORES S/A.', 'R. CAIS DO PORTO, ARMAZEM 3', 'SANTOS', 'SP', '11000-005'),
('550', 'ROTRAM COMERCIAL LTDA.', 'R. DAS PALMEIRAS, 45 - CJ 10', 'SAO PAULO', 'SP', '01226-010');


-- INSERÇÃO DE DADOS NA TABELA VENDA
INSERT INTO venda (DUPLIC, VALOR, VENCTO, CODCLI) VALUES
('230001', 1300.00, '2001-06-10', '340'),
('230099', 1000.00, '2002-10-02', '820'),
('997818', 3000.00, '2001-11-11', '170'),
('202550', 9518.55, '2002-11-21', '750'),
('113340', 2002.00, '2001-11-25', '230'),
('900450', 1200.00, '2002-09-09', '340'),
('202020', 2390.00, '2001-11-11', '550'),
('100200', 3500.00, '2002-11-10', '230'),
('345611', 5090.67, '2002-12-12', '550'),
('900855', 2356.00, '2002-10-10', '340'),
('100000', 5060.88, '1999-05-15', '300'),
('100335', 2002.50, '2006-01-20', '990'),
('101010', 5060.88, '2000-03-15', '300'),
('101210', 9060.55, '2001-10-15', '300'),
('112099', 1000.00, '2005-06-22', '150'),
('112299', 1000.00, '2005-10-10', '150'),
('121213', 1000.00, '2002-02-15', '170'),
('100334', 2002.50, '2005-12-20', '990'),
('100336', 2002.50, '2006-02-20', '990'),
('101110', 3460.66, '2000-04-15', '300'),
('111999', 1250.00, '2005-04-15', '150'),
('112199', 1350.00, '2005-08-30', '150'),
('121212', 1300.00, '2002-01-15', '170'),
('121214', 1400.00, '2002-03-15', '170'),
('121515', 1000.00, '2003-10-15', '230'),
('155099', 1800.00, '2004-11-13', '250'),
('155299', 1900.00, '2003-11-15', '250'),
('210001', 6000.00, '1999-12-04', '100'),
('231015', 1800.00, '2005-10-10', '550'),
('400400', 6000.00, '2003-06-15', '340'),
('460460', 1902.50, '2004-02-20', '100'),
('460660', 1902.50, '2004-04-24', '100'),
('121616', 1600.00, '2003-11-15', '230'),
('155199', 1000.00, '2003-10-15', '250'),
('155999', 1000.00, '2004-10-14', '250'),
('230002', 1300.00, '2005-10-09', '550'),
('250013', 2002.00, '2002-10-03', '820'),
('451300', 1750.00, '1999-05-21', '800'),
('460560', 1902.50, '2004-03-22', '100'),
('500005', 5060.88, '1999-05-15', '990'),
('600099', 1300.00, '2001-10-13', '860'),
('600299', 1500.00, '2002-05-12', '860'),
('653099', 1350.88, '2003-09-13', '750'),
('653999', 1255.99, '2003-09-14', '750'),
('751299', 1570.00, '2005-05-12', '800'),
('752252', 1675.00, '2006-12-15', '820'),
('950888', 2002.50, '2006-10-07', '500'),
('950890', 2002.50, '2006-10-09', '500'),
('600199', 1400.00, '2002-11-15', '860'),
('600999', 1200.00, '2001-09-14', '860'),
('653199', 1432.77, '2004-08-15', '750'),
('750299', 1560.00, '2004-03-12', '800'),
('750300', 1565.00, '2004-05-11', '800'),
('752253', 1675.00, '2006-11-22', '820'),
('950889', 2002.50, '2006-10-08', '500'),
('950891', 2002.50, '2006-10-10', '500'),
('202055', 2390.00, '2004-11-11', '550'),
('111818', 3000.00, '2006-09-11', '170'),
('302056', 2490.00, '2006-10-20', '550'),
('222550', 9518.55, '2005-11-21', '750'),
('235100', 1500.00, '2005-06-12', '500'),
('203052', 9008.33, '2005-08-22', '550'),
('999820', 3110.22, '2005-05-11', '170'),
('223345', 2112.11, '2006-03-08', '230'),
('922452', 1211.98, '2006-03-09', '340'),
('111211', 3535.00, '2006-11-15', '230'),
('907754', 2056.90, '2005-10-30', '340'),
('222228', 2390.00, '2006-10-07', '170'),
('347711', 5092.55, '2006-11-20', '170'),
('209967', 9008.33, '2006-10-05', '550');

-- ==============================
--            JOINS
-- ==============================

-- 1. Exibir duplicatas em carteira do cliente “PCTEC - MICROCOMPUTADORES S/A.”
SELECT 
    c.NOME AS Cliente,
    v.DUPLIC AS Duplicata,
    v.VALOR AS Valor
FROM cliente c
INNER JOIN venda v ON c.CODCLI = v.CODCLI
WHERE c.NOME = 'PCTEC - MICROCOMPUTADORES S/A.';

-- 2. Exibir nomes dos clientes e data de vencimento das duplicatas de novembro de 2004 --
SELECT 
    c.NOME AS Cliente,
    v.VENCTO AS Data_Vencimento
FROM cliente c
INNER JOIN venda v ON c.CODCLI = v.CODCLI
WHERE MONTH(v.VENCTO) = 11 
  AND YEAR(v.VENCTO) = 2004
ORDER BY v.VENCTO;

-- 3. Nome dos clientes e duplicatas com vencimento em outubro (qualquer ano) --
SELECT 
    c.NOME AS Cliente,
    v.DUPLIC AS Duplicata,
    v.VENCTO AS Data_Vencimento
FROM cliente c
INNER JOIN venda v ON c.CODCLI = v.CODCLI
WHERE MONTH(v.VENCTO) = 10
ORDER BY v.VENCTO;

-- 4. Nome do cliente, quantidade de títulos e total que deve --
SELECT 
    c.NOME AS Cliente,
    COUNT(v.DUPLIC) AS Qtde_Titulos,
    SUM(v.VALOR) AS Total_Devido
FROM cliente c
INNER JOIN venda v ON c.CODCLI = v.CODCLI
GROUP BY c.NOME;

-- 5. Mesma consulta anterior, mas com apelido diferente para a soma --
SELECT 
    c.NOME AS Cliente,
    COUNT(v.DUPLIC) AS Qtde_Titulos,
    SUM(v.VALOR) AS Total_Geral
FROM cliente c
INNER JOIN venda v ON c.CODCLI = v.CODCLI
GROUP BY c.NOME;

--  6. Listagem de clientes e duplicatas vencidas antes de 31/12/2003 --
SELECT 
    c.NOME AS CLIENTE, 
    COUNT(v.DUPLIC) AS VENCIDOS
FROM cliente c
JOIN venda v ON c.CODCLI = v.CODCLI
WHERE v.VENCTO < '2003-12-31'
GROUP BY c.NOME;

-- 7. Duplicatas em atraso antes de 31/12/1999, com juros e valor total --
SELECT 
    c.NOME AS CLIENTE,
    v.VALOR AS VALOR_DUPLICATA,
    v.VALOR * 0.10 AS JUROS,
    v.VALOR * 1.10 AS TOTAL
FROM cliente c
JOIN venda v ON c.CODCLI = v.CODCLI
WHERE v.VENCTO < '1999-12-31'
ORDER BY c.NOME;
