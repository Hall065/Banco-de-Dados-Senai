-- Query Para Atividade de Inserts da Aula - 28/11/25

-- ================= 1. SELECT — Consultas Básicas =================
-- Veículos da marca Ford
SELECT *
FROM Veiculo
WHERE marca = 'Ford';

-- Clientes que abriram OS nos últimos 6 meses
SELECT DISTINCT c.*
FROM Cliente c
JOIN Veiculo v ON v.id_cliente = c.id_cliente
JOIN OrdemServico os ON os.id_veiculo = v.id_veiculo
WHERE os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Mecânicos com especialidade 'Injeção Eletrônica'
SELECT *
FROM Mecanico
WHERE especialidade = 'Injeção Eletrônica';

-- Ordens de Serviço com observações "Aguardando Peça"
SELECT *
FROM OrdemServico
WHERE observacoes = 'Aguardando Peça';

-- Peças com estoque abaixo de 5 unidades
SELECT *
FROM Peca
WHERE qtd_estoque < 5;

-- Veículos que já tiveram mais de uma OS (subconsulta correlacionada)
SELECT v.*
FROM Veiculo v
WHERE (
    SELECT COUNT(*)
    FROM OrdemServico os
    WHERE os.id_veiculo = v.id_veiculo
) > 1;

-- OS executadas por um mecânico específico
SELECT o.*, m.nome_mecanico
FROM OrdemServico o
JOIN OS_Mecanico om ON o.id_os = om.id_os
JOIN Mecanico m ON om.id_mecanico = m.id_mecanico
WHERE m.id_mecanico = 3;

-- ================= 2. Desafio =================
-- Peças com preco_custo > 200 listando nome + preco_venda
SELECT nome, preco_venda
FROM Peca
WHERE preco_custo > 200;

-- ================== END =================