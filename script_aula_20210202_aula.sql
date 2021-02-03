-- Aula 02/02/2021
use escola;

-- função de Validar CPF 376.477.180-10 || 37647718010
DELIMITER $
CREATE FUNCTION func_validarcpf(cpf VARCHAR(14))
RETURNS REAL -- 0 FALSE 1 TRUE
BEGIN
    DECLARE contador  INT DEFAULT 1;
    DECLARE contador2 INT DEFAULT 10;
    DECLARE verifica  INT DEFAULT 2;
    DECLARE soma      INT DEFAULT 0;
    DECLARE n1        INT DEFAULT 0;
    DECLARE n2        INT DEFAULT 0;
    declare passo int;
    
    SET cpf = REPLACE(REPLACE(cpf,'.',''),'-','');
    
    WHILE verifica = 2 DO
        SET contador = contador + 1;
        IF SUBSTRING(cpf, 1, 1) != SUBSTRING(cpf, contador, 1) THEN
            SET verifica = 1;
        END IF;
        IF contador = 11 THEN
            SET verifica = 0;
        END IF;     
    END WHILE;
    set passo = 2;
    SET contador = 0;
    IF verifica = 1 THEN
        set passo = 3;
        WHILE contador < 9 DO
            SET contador = contador + 1;
            SET soma = soma + (SUBSTRING(cpf, contador, 1) * contador2);
            SET contador2 = contador2 - 1;
        END WHILE;
        SET n1 = 11 - (soma % 11);
        IF n1 > 9 THEN
            SET n1 = 0;
        END IF;
        SET contador = 1;
        SET contador2 = 11;
        SET soma = 0;
        WHILE contador < 11 DO
            SET soma = soma + (SUBSTRING(cpf, contador, 1) * contador2);
            SET contador = contador + 1;
            SET contador2 = contador2 - 1;
        END WHILE;
        SET n2 = 11 - (soma % 11);
        IF n2 > 9 THEN
            SET n2 = 0;
        END IF;
        IF n1 = SUBSTRING(cpf, 10, 1) AND n2 = SUBSTRING(cpf, 11, 1) THEN
            SET verifica = 1;
        ELSE
            SET verifica = 0;
        END IF;
    END IF;    
    IF verifica = 1 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END$
DELIMITER ;

select func_validarcpf('349.217.780-86');
drop function func_validarcpf;

select replace('Testando o reprace','prace','place');
select replace(replace('330.885.750-23','.',''),'-','');

select * from pessoa;
select *, func_validarcpf(cpf) from pessoa where func_validarcpf(cpf) = 1; -- utilizando função no where

-- --------------------------
select * from pessoa where nome_mae like '%5%';
select *, instr(nome_mae,'5') from pessoa where instr(nome_mae,'5') > 0;
select *, instr(nome_mae,'Z') from pessoa; -- where instr(nome_mae,'Z') > 0;
-- --------------------------
DELIMITER $
CREATE PROCEDURE proc_listaNomeMaeLike(nome VARCHAR(10))
BEGIN
    IF LENGTH(nome) > 0 THEN
        SET nome = TRIM(UPPER(nome));
        select * from pessoa where INSTR(TRIM(UPPER(nome_mae)),nome) > 0;
    END IF;
END$
DELIMITER ;

call proc_listaNomeMaeLike('5 ');
drop procedure proc_listaNomeMaeLike;
select CONCAT('|',UPPER(' AbcdefGh '),'|');
select CONCAT('|',TRIM(UPPER(' AbcdefGh ')),'|');

-- --------------------------
-- Função para retornar nota final ou a média de aluno pelas avaliações feitas
select * from avaliacaoturma WHERE id_aluno = 1;
select SUM(nota) from avaliacaoturma WHERE id_aluno = 1;
select AVG(nota) from avaliacaoturma WHERE id_aluno = 1;
-- --------------------------
DELIMITER $
CREATE FUNCTION func_notaFinal_media(idaluno INT, idprograma INT)
RETURNS DOUBLE
BEGIN
    DECLARE resposta DOUBLE DEFAULT 0;
    CASE idprograma
        WHEN 0 THEN
            -- nota final
            SELECT SUM(nota) INTO resposta FROM avaliacaoturma WHERE id_aluno = idaluno;
        WHEN 1 THEN
            -- média do aluno
            SELECT AVG(nota) INTO resposta FROM avaliacaoturma WHERE id_aluno = idaluno;
    END CASE ;
    IF resposta IS NULL THEN
        SET resposta = 0;
    END IF;    
    RETURN resposta;
END$
DELIMITER ;

drop function func_notaFinal_media;

select SUM(nota) from avaliacaoturma WHERE id_aluno = 1;
select func_notaFinal_media(1, 0);
select AVG(nota) from avaliacaoturma WHERE id_aluno = 1;
select func_notaFinal_media(1, 1);

select *, func_notaFinal_media(id_aluno, 0) somaNota, func_notaFinal_media(id_aluno, 1) mediaNota from aluno;