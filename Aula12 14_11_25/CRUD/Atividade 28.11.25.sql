-- Query Para Atividade de Inserts da Aula - 28/11/25
USE oficina;
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

-- (Desafio) Peças com preco_custo > 200 listando nome + preco_venda
SELECT nome, preco_venda
FROM Peca
WHERE preco_custo > 200;

-- ================== 2. UPDATE =================
-- 2.1 Aumentar preco_venda das peças da Bosch em 5%
UPDATE Peca
SET preco_venda = preco_venda * 1.05
WHERE nome LIKE '%Bosch%';

-- 2.2 Modificar status da OS 105
UPDATE OrdemServico
SET status = 'Concluída'
WHERE id_os = 105;

-- 2.3 Atualizar data_fechamento das OS abertas há mais de 30 dias e ainda em execução
UPDATE OrdemServico
SET data_fechamento = CURDATE()
WHERE status = 'Em Execução' 
  AND data_abertura <= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 2.4 Dobrar a quantidade em estoque da peça id_peca = 20
UPDATE Peca
SET qtd_estoque = qtd_estoque * 2
WHERE id_peca = 20;

-- ================== 3. ALTER TABLE =================
-- 3.1 Adicionar coluna email na tabela Cliente
ALTER TABLE Cliente
ADD COLUMN email VARCHAR(100);

-- 3.2 Modificar tipo da coluna especialidade na tabela Mecanico
ALTER TABLE Mecanico
MODIFY COLUMN especialidade VARCHAR(150);

-- 3.3 Remover coluna diagnostico_entrada da tabela OrdemServico
ALTER TABLE OrdemServico
DROP COLUMN diagnostico_entrada;

-- 3.4 Adicionar restrição CHECK para preco_venda >= preco_custo na tabela Peca
ALTER TABLE Peca
ADD CONSTRAINT chk_preco_venda CHECK (preco_venda >= preco_custo);

--=================== 4. JOINS =================
-- 4.1 Listar todas as OS com nome do cliente, placa do veículo e data de abertura
SELECT os.id_os, c.nome_cliente, v.placa, os.data_abertura
FROM OrdemServico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Cliente c ON v.id_cliente = c.id_cliente;

-- 4.2 Mostrar peças usadas na OS 50 (assumindo tabela OS_Pecas)
SELECT p.nome, op.quantidade_usada
FROM OS_Pecas op
JOIN Peca p ON op.id_peca = p.id_peca
WHERE op.id_os = 50;

-- 4.3 Nomes dos mecânicos que trabalharam na OS 75
SELECT m.nome_mecanico
FROM OS_Mecanico om
JOIN Mecanico m ON om.id_mecanico = m.id_mecanico
WHERE om.id_os = 75;

-- 4.4 (Desafio) Listar veículos com seu proprietário
SELECT v.placa, v.modelo, c.nome_cliente
FROM Veiculo v
JOIN Cliente c ON v.id_cliente = c.id_cliente;

-- =================== 5. INNER JOIN (Apenas Interseções) =================

-- 5.1 Placa e modelo dos veículos com OS "Em andamento"
SELECT v.placa, v.modelo
FROM Veiculo v
JOIN OrdemServico os ON v.id_veiculo = os.id_veiculo
WHERE os.status = 'Em andamento';

-- 5.2 Nome dos clientes que possuem veículos da marca “Volkswagen"
SELECT DISTINCT c.nome_cliente
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente
WHERE v.marca = 'Volkswagen';

-- 5.3 Nomes dos mecânicos que já trabalharam em pelo menos uma OS
SELECT DISTINCT m.nome_mecanico
FROM Mecanico m
JOIN OS_Mecanico om ON m.id_mecanico = om.id_mecanico;

-- 5.4 (Desafio) Nomes dos serviços que já foram executados
SELECT DISTINCT s.descricao
FROM Servico s
JOIN OS_Servico oss ON s.id_servico = oss.id_servico;


-- =================== 6. LEFT JOIN (Priorizando a Esquerda) =================

-- 6.1 Todos os clientes e IDs das ordens (clientes sem OS aparecem)
SELECT c.nome_cliente, os.id_os
FROM Cliente c
LEFT JOIN Veiculo v ON c.id_cliente = v.id_cliente
LEFT JOIN OrdemServico os ON v.id_veiculo = os.id_veiculo;

-- 6.2 Todos os mecânicos e quantidade de OS que trabalharam (novatos aparecem com 0)
SELECT m.nome_mecanico, COUNT(om.id_os) AS quantidade_os
FROM Mecanico m
LEFT JOIN OS_Mecanico om ON m.id_mecanico = om.id_mecanico
GROUP BY m.id_mecanico, m.nome_mecanico;

-- 6.3 Todas as peças e quantidade total vendida (peças nunca vendidas aparecem)
SELECT p.nome, COALESCE(SUM(op.quantidade_usada), 0) AS total_vendido
FROM Peca p
LEFT JOIN OS_Pecas op ON p.id_peca = op.id_peca
GROUP BY p.id_peca, p.nome;

-- 6.4 (Desafio) Veículos e data da última OS aberta (veículos sem OS aparecem com NULL)
SELECT v.placa, v.modelo, MAX(os.data_abertura) AS ultima_os
FROM Veiculo v
LEFT JOIN OrdemServico os ON v.id_veiculo = os.id_veiculo
GROUP BY v.id_veiculo, v.placa, v.modelo;

-- 7.1 (Inverso do 6.1)
-- Liste todas as Ordens de Serviço e o nome do cliente correspondente
SELECT os.id_os, c.nome_cliente
FROM Cliente c
RIGHT JOIN Veiculo v ON c.id_cliente = v.id_cliente
RIGHT JOIN OrdemServico os ON v.id_veiculo = os.id_veiculo;

-- 7.2 Mostrar todos os serviços e os IDs das OS onde foram usados
-- Serviços nunca executados aparecem com ID_OS = NULL
SELECT s.descricao, oss.id_os
FROM Servico s
RIGHT JOIN OS_Servico oss ON s.id_servico = oss.id_servico;

-- 7.3 Exibir todos os itens da tabela OS_Mecanico
-- e trazer o nome completo do mecânico
SELECT om.*, m.nome_mecanico
FROM Mecanico m
RIGHT JOIN OS_Mecanico om ON m.id_mecanico = om.id_mecanico;

-- 7.4 (Desafio)
-- Liste todos os veículos (direita) e as OS associadas (esquerda)
-- Veículos sem OS devem aparecer
-- (Inversão do LEFT JOIN clássico)
SELECT os.id_os, v.placa, v.modelo
FROM OrdemServico os
RIGHT JOIN Veiculo v ON os.id_veiculo = v.id_veiculo;

-- 8.1 Clientes que abriram mais de 3 Ordens de Serviço
SELECT c.*
FROM Cliente c
WHERE (
    SELECT COUNT(*)
    FROM Veiculo v
    JOIN OrdemServico os ON os.id_veiculo = v.id_veiculo
    WHERE v.id_cliente = c.id_cliente
) > 3;

-- 8.2 Peças usadas na mesma OS em que o mecânico "Carlos" (ID 4) atuou
SELECT DISTINCT p.nome
FROM Peca p
JOIN OS_Pecas op ON p.id_peca = op.id_peca
WHERE op.id_os IN (
    SELECT om.id_os
    FROM OS_Mecanico om
    WHERE om.id_mecanico = 4
);

-- 8.3 Veículos que NUNCA tiveram uma Ordem de Serviço
-- (usando NOT EXISTS)
SELECT v.placa, v.modelo
FROM Veiculo v
WHERE NOT EXISTS (
    SELECT 1
    FROM OrdemServico os
    WHERE os.id_veiculo = v.id_veiculo
);

-- 8.4 (Desafio)
-- Serviços de "Mão de Obra" com preço acima de 120 reais
SELECT *
FROM Servico
WHERE descricao = 'Mão de Obra'
  AND preco > 120;

-- 9.0.1 Faturamento total de uma OS específica (ID 100)
SELECT 
    COALESCE(SUM(oss.subtotal),0) + COALESCE(SUM(op.quantidade_usada * op.preco_unitario_cobrado),0) AS faturamento_total
FROM OrdemServico os
LEFT JOIN OS_Servico oss ON os.id_os = oss.id_os
LEFT JOIN OS_Pecas op ON os.id_os = op.id_os
WHERE os.id_os = 100;

-- 9.0.2 Tempo médio que as Ordens de Serviço ficam abertas (em dias)
SELECT AVG(DATEDIFF(data_fechamento, data_abertura)) AS tempo_medio_dias
FROM OrdemServico
WHERE data_fechamento IS NOT NULL;

-- 9.1.1 Número total de veículos cadastrados
SELECT COUNT(*) AS total_veiculos
FROM Veiculo;

-- 9.1.2 Valor total do inventário (estoque)
SELECT SUM(qtd_estoque * preco_custo) AS valor_total_estoque
FROM Peca;

-- 9.1.3 Preço médio da mão de obra de todos os serviços
SELECT AVG(preco) AS preco_medio_servicos
FROM Servico;

-- 9.2.1 Contagem de veículos por marca
SELECT marca, COUNT(*) AS total_por_marca
FROM Veiculo
GROUP BY marca;

-- 9.2.2 Número de OS abertas por mês
SELECT MONTH(data_abertura) AS mes, COUNT(*) AS total_os
FROM OrdemServico
GROUP BY MONTH(data_abertura);

-- 9.2.3 Contagem de OS por status
SELECT status, COUNT(*) AS total_por_status
FROM OrdemServico
GROUP BY status;

-- 9.3.1 Número total de OS com status "Concluído"
SELECT COUNT(*) AS total_concluidas
FROM OrdemServico
WHERE status = 'Concluída';

-- 9.3.2 Faturamento total apenas de veículos da marca "Fiat" no último ano
SELECT 
    SUM(oss.subtotal + COALESCE(op.quantidade_usada * op.preco_unitario_cobrado,0)) AS faturamento_fiat
FROM OrdemServico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
LEFT JOIN OS_Servico oss ON os.id_os = oss.id_os
LEFT JOIN OS_Pecas op ON os.id_os = op.id_os
WHERE v.marca = 'Fiat' 
  AND os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- 9.3.3 Preço médio da mão de obra apenas de serviços com descrição contendo "Motor"
SELECT AVG(preco) AS preco_medio_motor
FROM Servico
WHERE descricao LIKE '%Motor%';

-- 9.4.1 Clientes que já gastaram mais de R$ 5.000,00 no total em OS
SELECT v.id_cliente, SUM(oss.subtotal + COALESCE(op.quantidade_usada * op.preco_unitario_cobrado,0)) AS total_gasto
FROM OrdemServico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
LEFT JOIN OS_Servico oss ON os.id_os = oss.id_os
LEFT JOIN OS_Pecas op ON os.id_os = op.id_os
GROUP BY v.id_cliente
HAVING total_gasto > 5000;

-- 9.4.2 Peças vendidas mais de 100 vezes no total
SELECT id_peca, SUM(quantidade_usada) AS total_vendido
FROM OS_Pecas
GROUP BY id_peca
HAVING total_vendido > 100;

-- 9.4.3 Especialidades dos mecânicos que trabalharam em mais de 20 OS
SELECT m.especialidade, COUNT(om.id_os) AS total_os
FROM Mecanico m
JOIN OS_Mecanico om ON m.id_mecanico = om.id_mecanico
GROUP BY m.especialidade
HAVING total_os > 20;

-- 9.4.4 (Desafio) Nome do mecânico que mais trabalhou em OS
SELECT m.nome_mecanico, COUNT(om.id_os) AS total_os
FROM Mecanico m
JOIN OS_Mecanico om ON m.id_mecanico = om.id_mecanico
GROUP BY m.nome_mecanico
ORDER BY total_os DESC
LIMIT 1;

-- Criar índice simples na coluna placa
CREATE INDEX idx_placa ON Veiculo(placa);

-- Indexar a coluna id_veiculo na tabela OrdemServico
CREATE INDEX idx_ordem_veiculo ON OrdemServico(id_veiculo);

-- Criar índice composto
CREATE INDEX idx_os_peca ON OS_Pecas(id_os, id_peca);