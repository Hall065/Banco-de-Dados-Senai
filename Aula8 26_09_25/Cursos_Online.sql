CREATE DATABASE Cursos_Online;
USE Cursos_Online;

-- Tabela Alunos
CREATE TABLE Alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE
);

-- Tabela Cursos
CREATE TABLE Cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT,
    status VARCHAR(10) DEFAULT 'ativo' CHECK (status IN ('ativo','inativo'))
);

-- Tabela Inscricoes
CREATE TABLE Inscricoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso_id INT,
    data_inscricao DATE,
    FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);


-- Tabela Avaliacoes
CREATE TABLE Avaliacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    inscricao_id INT UNIQUE,
    nota DECIMAL(5,2),
    comentario TEXT,
    FOREIGN KEY (inscricao_id) REFERENCES Inscricoes(id)
);

-- Inserindo dados nas tabelas --

-- Inserir 5 Alunos
INSERT INTO Alunos (nome, email, data_nascimento) VALUES
('João Vitor', 'joao@email.com', '2004-05-22'),
('Ana Clara', 'ana@email.com', '2011-09-30'),
('Lucas Manveru', 'lucas@email.com', '1995-12-10'),
('Hyron Silva', 'hyron@email.com', '2007-07-01'),
('Brenda Souza', 'brenda@email.com', '2009-08-30');

-- Inserir 5 Cursos (1 com status 'inativo')
INSERT INTO Cursos (titulo, descricao, carga_horaria, status) VALUES
('SQL Básico', 'Aprenda o básico de SQL', 30, 'ativo'),
('HTML e CSS', 'Introdução ao desenvolvimento web', 50, 'ativo'),
('JavaScript', 'Aprenda JS na prática', 60, 'ativo'),
('Python', 'Programação em Python', 70, 'ativo'),
('Gestão de Projetos', 'Curso de gestão e planejamento', 40, 'inativo');

-- Inserir 5 Inscrições
INSERT INTO Inscricoes (aluno_id, curso_id, data_inscricao) VALUES
(1, 1, '2025-09-19'),
(2, 2, '2025-09-26'),
(3, 3, '2025-09-24'),
(4, 4, '2025-09-07'),
(5, 5, '2025-09-21');

-- Inserir 3 Avaliações
INSERT INTO Avaliacoes (inscricao_id, nota, comentario) VALUES
(1, 95.50, 'Excelente!'),
(2, 88.00, 'Muito bom!'),
(3, 76.50, 'Bom!');

-- Atualizar Dados --

-- Atualizar email de um aluno
UPDATE Alunos
SET email = 'joao@novoemail.com'
WHERE id = 1;

-- Alterar carga horária de um curso
UPDATE Cursos
SET carga_horaria = 55
WHERE id = 2;

-- Corrigir nome de um aluno
UPDATE Alunos
SET nome = 'Hyron'
WHERE id = 4;

-- Mudar status de um curso --
UPDATE Cursos
SET status = 'inativo'
WHERE id = 2;

-- Alterar notas de uma avaliação --
UPDATE Avaliacoes
SET nota = 85.22
WHERE id = 2;

-- Exclusão de Dados --

-- Criar dados expecificos para exclusão --

-- Inserir inscrição extra pra deletar
INSERT INTO Inscricoes (aluno_id, curso_id, data_inscricao) VALUES
(1, 2, '2025-09-27');

-- Inserir curso extra pra deletar
INSERT INTO Cursos (titulo, descricao, carga_horaria, status) VALUES
('Curso Temporário', 'Curso que será removido', 20, 'ativo');

-- Inserir avaliação ofensiva
INSERT INTO Avaliacoes (inscricao_id, nota, comentario) VALUES
(4, 50.00, 'Comentário ofensivo');

-- Inserir aluno extra pra deletar
INSERT INTO Alunos (nome, email, data_nascimento) VALUES
('Aluno a ser deletado', 'delete@email.com', '2001-01-01');

-- Inserir inscrições para curso encerrado (inativo)
INSERT INTO Inscricoes (aluno_id, curso_id, data_inscricao) VALUES
(3, 5, '2025-09-26'), -- curso Gestão de Projetos (inativo)
(4, 5, '2025-09-26');

-- Deletar Pendencias --

-- Excluir uma inscrição específica
DELETE FROM Inscricoes
WHERE id = 6; -- inscrição extra criada acima

-- Excluir um curso específico
DELETE FROM Cursos
WHERE titulo = 'Curso Temporário';

-- Excluir uma avaliação ofensiva
DELETE FROM Avaliacoes
WHERE comentario LIKE '%ofensivo%';

-- Excluir um aluno específico
DELETE FROM Alunos
WHERE nome = 'Aluno a ser deletado';

-- Deletar avaliações de inscrições do curso encerrado
DELETE FROM Avaliacoes
WHERE inscricao_id IN (SELECT id FROM Inscricoes WHERE curso_id IN (SELECT id FROM Cursos WHERE status = 'inativo'));

-- Deletar inscrições do curso encerrado
DELETE FROM Inscricoes
WHERE curso_id IN (SELECT id FROM Cursos WHERE status = 'inativo');

-- Deletar o curso encerrado
DELETE FROM Cursos
WHERE status = 'inativo';

-- Consultas --

-- Listar todos os alunos cadastrados
SELECT * FROM Alunos;

-- Exibir apenas os nomes e e-mails dos alunos
SELECT nome, email FROM Alunos;

-- Listar cursos com carga horária maior que 30 horas
SELECT * FROM Cursos
WHERE carga_horaria > 30;

-- Exibir cursos que estão inativos
SELECT * FROM Cursos
WHERE status = 'inativo';

-- Buscar alunos nascidos após o ano 1995
SELECT * FROM Alunos
WHERE data_nascimento > '1995-12-31';

-- Exibir avaliações com nota acima de 9
SELECT * FROM Avaliacoes
WHERE nota > 9;

-- Contar quantos cursos estão cadastrados
SELECT COUNT(*) AS total_cursos FROM Cursos;

-- Listar os 3 cursos com maior carga horária
SELECT * FROM Cursos
ORDER BY carga_horaria DESC
LIMIT 3;

-- Desafio Extra --
-- Criar índice para busca rápida por email
CREATE INDEX idx_email_aluno
ON Alunos(email);

-- Coisas Extras --

-- Atualizar avaliação
INSERT INTO Avaliacoes (inscricao_id, nota, comentario)
SELECT i.id, 92.50, 'Ótimo!'
FROM Inscricoes i
JOIN Alunos a ON i.aluno_id = a.id
JOIN Cursos c ON i.curso_id = c.id
WHERE a.nome = 'Hyron' AND c.titulo = 'Python';

