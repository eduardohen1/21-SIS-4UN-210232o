-- Aula 26/01/2021
use escola; 

-- resolução da atividade da trigger:
--  'Aluno NOME DO ALUNO ingressou na turma NOME DA TURMA'
INSERT INTO professor(formacao, id_pessoa) VALUES('MESTRE',6);
INSERT INTO prof_turm_disc VALUES(1,1,1);

select * from professor;
select * from prof_turm_disc;

SELECT
  p.id_professor, pe.nome nomeProfessor, pe2.nome nomeAluno, t.descricao
FROM
  alunoturma at
    INNER JOIN turma t            ON at.id_turma      = t.id_turma
    INNER JOIN prof_turm_disc ptd ON t.id_turma       = ptd.id_turma
    INNER JOIN professor p        ON ptd.id_professor = p.id_professor
    INNER JOIN pessoa pe          ON p.id_pessoa      = pe.id_pessoa
    INNER JOIN aluno a            ON a.id_aluno       = at.id_aluno
    INNER JOIN pessoa pe2         ON a.id_pessoa      = pe2.id_pessoa
WHERE at.id_aluno = 2;

select * from professor where id_professor = 1;
select * from pessoa where id_pessoa = 6;
select * from aluno where id_aluno = 2;
select * from pessoa where id_pessoa = 2;
select * from mensagens;

DELIMITER $
CREATE TRIGGER msg_prof
AFTER INSERT ON alunoturma
FOR EACH ROW
BEGIN
    INSERT INTO mensagens(id_professor, dt_mensagem, mensagem)
        SELECT
          p.id_professor, now(), CONCAT('Aluno ', pe2.nome,' ingressou na turma ',t.descricao)
        FROM
          alunoturma at
            INNER JOIN turma t            ON at.id_turma      = t.id_turma
            INNER JOIN prof_turm_disc ptd ON t.id_turma       = ptd.id_turma
            INNER JOIN professor p        ON ptd.id_professor = p.id_professor
            INNER JOIN pessoa pe          ON p.id_pessoa      = pe.id_pessoa
            INNER JOIN aluno a            ON a.id_aluno       = at.id_aluno
            INNER JOIN pessoa pe2         ON a.id_pessoa      = pe2.id_pessoa
        WHERE at.id_aluno = NEW.id_aluno;
END$
DELIMITER ;

-- testando trigger:
select * from aluno;
insert into aluno(dt_cadastro, id_pessoa) values(now(), 90);
insert into aluno(dt_cadastro, id_pessoa) values(now(), 99);
select * from alunoturma;
insert into alunoturma values(7, 1, now(), '1900-01-01');
select * from alunoturma;
select * from mensagens;
select * from pessoa where id_pessoa = 99;

-- procedures e fuctions
-- função para ver a qte de pessoas de um determinado sexo:
DELIMITER $
CREATE FUNCTION qtePessoasPorSexo(sexoParam INTEGER)
RETURNS VARCHAR(9)
BEGIN
    DECLARE qtePessoas INTEGER;
    SELECT COUNT(*) INTO qtePessoas FROM pessoa WHERE sexo = sexoParam;
    
    IF qtePessoas > 26 THEN
        RETURN 'EXCELENTE';
    ELSEIF qtePessoas > 6 THEN
        RETURN 'RAZOÁVEL';
    ELSEIF qtePessoas > 0 THEN
        RETURN 'BAIXO';
    ELSE
        RETURN 'SEM REG.';
    END IF ;    
END$
DELIMITER ;

select qtePessoasPorSexo(0); -- SELECT COUNT(*) FROM pessoa WHERE sexo = 0; -- 48515
select qtePessoasPorSexo(1); -- SELECT COUNT(*) FROM pessoa WHERE sexo = 1; -- 8 
select qtePessoasPorSexo(2); -- SELECT COUNT(*) FROM pessoa WHERE sexo = 2; -- 0

drop function qtePessoasPorSexo;

-- função para verificar a idade da pessoa:
DELIMITER $
CREATE FUNCTION func_idade(dtNascimento DATETIME)
RETURNS INTEGER
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, dtNascimento, NOW());
END$
DELIMITER ;

-- testando:
select func_idade('1990-08-20');
select func_idade('2010-01-27');
select func_idade('2010-01-26');

select *, func_idade(dt_nascimento) idade from pessoa limit 5;
update pessoa set dt_nascimento = '1980-01-25' where id_pessoa = 5;
select *, func_idade(dt_nascimento) idade from pessoa limit 5;

-- procedure:
-- onde passo por parametro o sexo em String e me retorna o SELECT deste:
DELIMITER $
CREATE PROCEDURE proc_listaPessoaSexo(sexoParam VARCHAR(1))
BEGIN
    IF sexoParam = 'M' THEN
        select * from pessoa where sexo = 0;
    ELSEIF sexoParam = 'F' THEN
        select * from pessoa where sexo = 1;
    ELSE
        select * from pessoa where sexo not in (0,1);
    END IF ;
END$
DELIMITER ;

call proc_listaPessoaSexo('M');
call proc_listaPessoaSexo('F');
call proc_listaPessoaSexo('O');










