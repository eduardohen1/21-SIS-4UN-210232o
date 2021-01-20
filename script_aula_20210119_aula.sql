-- Aula 19/01/2021
-- Triggers
use escola;
CREATE TABLE `escola`.`mensagens` ( 
    `idmensagens`  INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, 
    `id_aluno`     INTEGER UNSIGNED NOT NULL DEFAULT 0, 
    `id_professor` INTEGER UNSIGNED NOT NULL DEFAULT 0, 
    `dt_mensagem`  DATETIME         NOT NULL, 
    `mensagem`     VARCHAR(100)     NOT NULL, 
    `situacao`     INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 Nao lida; 1 Lida; 2 arquivada', 
    `dt_leitura`   DATETIME         NOT NULL DEFAULT '1900-01-01', 
    PRIMARY KEY (`idmensagens`) 
) ENGINE = InnoDB;

select * from mensagens;
insert into mensagens(id_aluno, dt_mensagem, mensagem, situacao) values(1, '2020-12-20','Mensagem',0);
select * from mensagens;
insert into mensagens(id_professor, dt_mensagem, mensagem) values(2, NOW(),'Mensagem para o professor');
select * from mensagens;

select * from avaliacao;
insert into avaliacao values(4, 'TESTE',10, 'Obs');

-- Criar as triggers:
-- criar mensagens para um aluno quando inserir uma nota em avaliacaoturma
DELIMITER $
CREATE TRIGGER msg_avaliacao_aluno_ins
AFTER INSERT ON avaliacaoturma
FOR EACH ROW
BEGIN
    INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem) VALUES(NEW.id_aluno, NOW(), 'Sua nota: ');
END$
DELIMITER ;

-- ---------------------------
show triggers;
insert into avaliacaoturma(id_avaliacao, id_aluno, id_turma, id_disciplina, dt_avaliacao, nota) values(4, 1, 1, 1, '2021-01-19', 9);
select * from avaliacaoturma;
select * from mensagens;
insert into avaliacaoturma(id_avaliacao, id_aluno, id_turma, id_disciplina, dt_avaliacao, nota) values(4, 10, 1, 1, '2021-01-19', 9);
select * from avaliacaoturma;
select * from mensagens;

-- vamos acrescentar a nota que o aluno tirou:
drop trigger msg_avaliacao_aluno_ins;
show triggers;
-- trigger:
DELIMITER $
CREATE TRIGGER msg_avaliacao_aluno_ins
AFTER INSERT ON avaliacaoturma
FOR EACH ROW
BEGIN
    INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem) VALUES(NEW.id_aluno, NOW(), CONCAT('Sua nota: ',NEW.nota));
END$
DELIMITER ;
-- 
show triggers;
insert into avaliacaoturma values(4, 2, 1, 1, '2021-01-19',10);
select * from avaliacaoturma where id_avaliacao = 4;
select * from mensagens;

-- ----------------
-- Nota da avaliação NOME DA AVALIAÇÃO lançada! Nota: XX de VR
select * from avaliacao where id_avaliacao = 4;
-- acrescentando campo aleatório pelo programador:
select 
    av.*, 
    avt.nota,
    '123456' vraleatorio -- este campo não está nas tabelas
from 
    avaliacao av 
        inner join avaliacaoturma avt ON av.id_avaliacao = avt.id_avaliacao 
where 
    avt.id_avaliacao = 4 and avt.id_aluno = 2;

-- o select que será utilizado na trigger:
select 
    avt.id_aluno,
    NOW() dt_atual,
    CONCAT('Nota da avaliação ',av.descricao,' lançada! Nota: ', avt.nota,' de ',av.valor)
from 
    avaliacao av 
        inner join avaliacaoturma avt ON av.id_avaliacao = avt.id_avaliacao 
where 
    avt.id_avaliacao = 4 and avt.id_aluno = 2;

-- limpar a trigger:
drop trigger msg_avaliacao_aluno_ins;
show triggers;
-- criando trigger de insert:
DELIMITER $
CREATE TRIGGER msg_avaliacao_aluno_ins
AFTER INSERT ON avaliacaoturma
FOR EACH ROW
BEGIN
    INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem)
        SELECT 
            avt.id_aluno,
            NOW() dt_atual,
            CONCAT('Nota da avaliação ',av.descricao,' lançada! Nota: ', avt.nota,' de ',av.valor)
        FROM 
            avaliacao av 
                INNER JOIN avaliacaoturma avt ON av.id_avaliacao = avt.id_avaliacao 
        WHERE 
            avt.id_avaliacao = NEW.id_avaliacao and avt.id_aluno = NEW.id_aluno;
END$
DELIMITER ;
-- 
show triggers;
select * from mensagens;
insert into avaliacaoturma(id_avaliacao, id_aluno, id_turma, id_disciplina, dt_avaliacao, nota) VALUES(4, 3, 1, 1, '2021-01-18', 8);
select * from avaliacaoturma where id_avaliacao = 4;
select * from mensagens;

-- trigger de update
-- avisar ao aluno que a nota foi alterada
-- Nota da avaliação NOME DA AVALIAÇÃO alterada! Nota antiga: XX, Nota nova: ZZ
select * from avaliacaoturma where id_avaliacao = 4;

-- trigger de update:
DELIMITER $
CREATE TRIGGER msg_avaliacao_aluno_upd
AFTER UPDATE ON avaliacaoturma
FOR EACH ROW
BEGIN
    INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem)
        SELECT 
            avt.id_aluno,
            NOW() dt_atual,
            CONCAT('Nota da avaliação ', av.descricao, ' alterada! Nota antiga: ', OLD.nota,', Nota nova: ', NEW.nota)
        FROM 
            avaliacao av 
                INNER JOIN avaliacaoturma avt ON av.id_avaliacao = avt.id_avaliacao 
        WHERE 
            avt.id_avaliacao = NEW.id_avaliacao and avt.id_aluno = NEW.id_aluno;
END$
DELIMITER ;
show triggers;
select * from avaliacaoturma where id_avaliacao = 4;
select * from mensagens;
update avaliacaoturma set nota = 9.5 where id_avaliacao = 4 and id_aluno = 2 and id_turma = 1 and id_disciplina = 1;
select * from avaliacaoturma where id_avaliacao = 4;
select * from mensagens;
-- além da mensagem de nota (insert), se o aluno tirou acima da média, enviar outra mensagem
drop trigger msg_avaliacao_aluno_ins;
-- trigger com condição:
DELIMITER $
CREATE TRIGGER msg_avaliacao_aluno_ins
AFTER INSERT ON avaliacaoturma
FOR EACH ROW
BEGIN
    -- Declarar uma variável:
    DECLARE valorNota DOUBLE;
    -- Recuperar informação do campo valor da tab avaliacao:
    SELECT a.valor INTO valorNota FROM avaliacao a WHERE a.id_avaliacao = NEW.id_avaliacao;
    
    INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem)
        SELECT 
            avt.id_aluno,
            NOW() dt_atual,
            CONCAT('Nota da avaliação ',av.descricao,' lançada! Nota: ', avt.nota,' de ',av.valor)
        FROM 
            avaliacao av 
                INNER JOIN avaliacaoturma avt ON av.id_avaliacao = avt.id_avaliacao 
        WHERE 
            avt.id_avaliacao = NEW.id_avaliacao and avt.id_aluno = NEW.id_aluno;
    -- fazer a lógica de média (60%)
    IF (NEW.nota > (valorNota * 0.6)) THEN
        INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem) VALUES(NEW.id_aluno, NOW(),'Parabéns! Você tirou a nota acima da média!');
    END IF ;
END$
DELIMITER ;

--
show triggers;
select * from mensagens;
insert into avaliacaoturma value(4, 5,1,1,'2021-01-18',5);
select * from avaliacaoturma where id_avaliacao = 4;
select * from mensagens;
insert into avaliacaoturma value(4, 6,1,1,'2021-01-19',7.5);
select * from avaliacaoturma where id_avaliacao = 4;
select * from mensagens;

