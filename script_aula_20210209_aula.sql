-- Aula 09/02/2021
-- Transações:

use escola;

select * from aluno;

-- reaver nossos dados:
SELECT * FROM aluno;
START TRANSACTION;
DELETE FROM aluno WHERE id_aluno = 5;
    SELECT * FROM aluno;
ROLLBACK;
SELECT * FROM aluno;


-- iniciar a transação
START TRANSACTION;
-- executar os comandos
UPDATE aluno SET dt_cadastro = NOW() WHERE id_aluno = 7;
DELETE FROM aluno WHERE id_aluno = 5;
    select * from aluno;

-- finalizar a transação (mysql não precisa)
-- confirmar/abortar
ROLLBACK;
-- COMMIT;
select * from aluno;

-- Transação com pontos de salvamento:
INSERT INTO aluno VALUES(8, now(), 97);
SELECT * FROM aluno;

START TRANSACTION;
UPDATE aluno SET dt_cadastro = NOW() WHERE id_aluno = 6;
    SELECT * FROM aluno;
SAVEPOINT atualizacao1;
DELETE FROM aluno WHERE id_aluno = 8;
    SELECT * FROM aluno;
ROLLBACK TO atualizacao1;
    SELECT * FROM aluno;
COMMIT;
SELECT * FROM aluno;

-- ---------------------------
START TRANSACTION;
UPDATE aluno SET dt_cadastro = '2021-01-26 20:00' WHERE id_aluno = 8;
UPDATE aluno SET dt_cadastro = '2021-01-26 20:00' WHERE id_aluno = 6;
SAVEPOINT atual1;
    select * from aluno;
DELETE FROM aluno WHERE id_aluno = 7;
DELETE FROM aluno WHERE id_aluno = 6;
    select * from aluno;
ROLLBACK TO atual1;
    select * from aluno;
COMMIT;

select * from aluno;

-- ISOLATION LEVEL:
SELECT * FROM aluno;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
UPDATE aluno SET id_pessoa = 95 WHERE id_aluno = 7;
    SELECT * FROM aluno;
-- testar em outra instancia.
ROLLBACK;
COMMIT;
SELECT * FROM aluno;
-- ----------------
INSERT INTO aluno VALUES(9, '2021-01-26 21:00', 94);
-- ----------------
select * from aluno;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
UPDATE aluno SET dt_cadastro = NOW() WHERE id_aluno = 9;
    select * from aluno;
-- testar em outra instancia
COMMIT;
rollback;
select * from aluno;

-- transação com insert
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
UPDATE aluno SET dt_cadastro = NOW() WHERE id_aluno = 9;
    SELECT * FROM aluno;
INSERT INTO aluno VALUES(10, NOW(), 93);
    -- testar o insert em outra instancia
    SELECT * FROM aluno;
COMMIT;
select * from aluno;


































