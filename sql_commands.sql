-- ========================================================
-- DICIONÁRIO DE COMANDOS SQL (MySQL e PostgreSQL)
-- ========================================================

-- 1. Conexão ao Banco de Dados
-- MySQL:
-- mysql -u usuario -p

-- PostgreSQL:
-- psql -U usuario -d nome_do_banco

-- 2. Criação de Banco de Dados
CREATE DATABASE nome_do_banco;

-- 3. Uso de um Banco de Dados
-- MySQL:
USE nome_do_banco;

-- PostgreSQL:
-- \c nome_do_banco

-- 4. Listar Bancos de Dados
-- MySQL:
SHOW DATABASES;

-- PostgreSQL:
-- \l

-- 5. Criação de Tabelas
CREATE TABLE tabela (
    id INT AUTO_INCREMENT PRIMARY KEY, -- MySQL

    -- id SERIAL PRIMARY KEY, -- PostgreSQL
    nome VARCHAR(255) NOT NULL
);

-- 6. Inserção de Dados
INSERT INTO tabela (nome) VALUES ('exemplo');

-- 7. Seleção de Dados
SELECT * FROM tabela;

-- 8. Atualização de Dados
UPDATE tabela SET nome = 'novo_nome' WHERE id = 1;

-- 9. Exclusão de Dados
DELETE FROM tabela WHERE id = 1;

-- 10. Exclusão de Tabelas
DROP TABLE tabela;

-- 11. Listar Tabelas
-- MySQL:
SHOW TABLES;

-- PostgreSQL:
-- \dt

-- 12. Estrutura de uma Tabela
-- MySQL:
DESCRIBE tabela;

-- PostgreSQL:
-- \d tabela

-- 13. Adicionar Colunas
ALTER TABLE tabela ADD coluna INT;

-- 14. Remover Colunas
ALTER TABLE tabela DROP COLUMN coluna;

-- 15. Índices
-- Criar índice
CREATE INDEX idx_nome ON tabela(nome);

-- Remover índice
-- MySQL:
DROP INDEX idx_nome ON tabela;

-- PostgreSQL:
DROP INDEX idx_nome;

-- 16. Chaves Estrangeiras
ALTER TABLE tabela
ADD CONSTRAINT fk_nome FOREIGN KEY (coluna) REFERENCES outra_tabela(coluna);

-- 17. Backup e Restauração
-- Backup:
-- MySQL: mysqldump -u usuario -p nome_do_banco > backup.sql

-- PostgreSQL: pg_dump -U usuario -d nome_do_banco > backup.sql

-- Restauração:
-- MySQL: mysql -u usuario -p nome_do_banco < backup.sql

-- PostgreSQL: psql -U usuario -d nome_do_banco -f backup.sql

-- 18. Funções de Agregação
SELECT COUNT(*), SUM(coluna), AVG(coluna), MAX(coluna), MIN(coluna) FROM tabela;

-- 19. Renomear uma Tabela
-- MySQL:
RENAME TABLE tabela_antiga TO tabela_nova;

-- PostgreSQL:
ALTER TABLE tabela_antiga RENAME TO tabela_nova;

-- 20. Alterar Nome de Coluna
-- MySQL:
ALTER TABLE tabela CHANGE coluna_antiga coluna_nova VARCHAR(255);

-- PostgreSQL:
ALTER TABLE tabela RENAME COLUMN coluna_antiga TO coluna_nova;

-- 21. Alterar Tipo de Coluna
-- MySQL:
ALTER TABLE tabela MODIFY coluna NOVO_TIPO;

-- PostgreSQL:
ALTER TABLE tabela ALTER COLUMN coluna TYPE NOVO_TIPO;

-- 22. Adicionar Restrições
-- UNIQUE:
ALTER TABLE tabela ADD CONSTRAINT nome_unico UNIQUE (coluna);
-- NOT NULL:
-- MySQL:
ALTER TABLE tabela MODIFY coluna TIPO NOT NULL;

-- PostgreSQL:
ALTER TABLE tabela ALTER COLUMN coluna SET NOT NULL;

-- 23. Consultar Restrições
-- MySQL:
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'tabela';

-- PostgreSQL:
-- \d+ tabela

-- 24. Consultar Usuários
-- MySQL:
SELECT User FROM mysql.user;

-- PostgreSQL:
-- \du

-- 25. Criar Usuário
-- MySQL:
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'senha';

-- PostgreSQL:
CREATE USER usuario WITH PASSWORD 'senha';

-- 26. Conceder Permissões
-- MySQL:
GRANT ALL PRIVILEGES ON nome_do_banco.* TO 'usuario'@'localhost';

-- PostgreSQL:
GRANT ALL PRIVILEGES ON DATABASE nome_do_banco TO usuario;

-- 27. Revogar Permissões
-- MySQL:
REVOKE ALL PRIVILEGES ON nome_do_banco.* FROM 'usuario'@'localhost';

-- PostgreSQL:
REVOKE ALL PRIVILEGES ON DATABASE nome_do_banco FROM usuario;

-- 28. Exibir Permissões
-- MySQL:
SHOW GRANTS FOR 'usuario'@'localhost';

-- PostgreSQL:
-- \du+ usuario

-- 29. Views
-- Criar uma View:
CREATE VIEW nome_da_view AS
SELECT coluna1, coluna2 FROM tabela WHERE condicao;

-- Exibir Views:
-- MySQL:
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

-- PostgreSQL:
-- \dv

-- Remover View:
DROP VIEW nome_da_view;

-- 30. Triggers
-- Criar um Trigger:
-- MySQL:
CREATE TRIGGER nome_do_trigger BEFORE INSERT ON tabela
FOR EACH ROW
BEGIN
  -- código SQL aqui
END;

-- PostgreSQL:
CREATE OR REPLACE FUNCTION funcao_trigger()
RETURNS TRIGGER AS $$
BEGIN
  -- código SQL aqui
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER nome_do_trigger
BEFORE INSERT ON tabela
FOR EACH ROW
EXECUTE FUNCTION funcao_trigger();

-- Excluir Trigger:
-- MySQL:
DROP TRIGGER nome_do_trigger;

-- PostgreSQL:
DROP TRIGGER nome_do_trigger ON tabela;

-- 31. Transações
BEGIN;
-- Operações aqui
COMMIT; -- ou ROLLBACK;

-- 32. Partições de Tabelas
-- MySQL:
CREATE TABLE tabela_particionada (
    id INT,
    nome VARCHAR(255),
    data DATE
)
PARTITION BY RANGE (YEAR(data)) (
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025)
);

-- PostgreSQL:
CREATE TABLE tabela_particionada (
    id INT,
    nome VARCHAR(255),
    data DATE
) PARTITION BY RANGE (data);

CREATE TABLE tabela_p_2023 PARTITION OF tabela_particionada
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
