
-- script inicial da aula:
UPDATE pessoa SET nome_pai = null WHERE id_pessoa BETWEEN 48499 AND 48514;

DROP TABLE IF EXISTS `avaliacao`;
CREATE TABLE `avaliacao` (
  `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `valor` double NOT NULL,
  `observacao` text,
  PRIMARY KEY  (`id_avaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `avaliacaoturma`;
CREATE TABLE `avaliacaoturma` (
  `id_avaliacao` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `dt_avaliacao` datetime NOT NULL,
  `nota` double NOT NULL,
  PRIMARY KEY  (id_avaliacao, id_aluno, id_turma, id_disciplina)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO avaliacao(descricao, valor, observacao) VALUES
	('Trabalho 1', 30, 'Trabalho sobre BD'), 
	('Trabalho 2', 30, 'Trabalho sobre INNER JOIN'), 
	('AVALIAÇÃO' , 40, 'AVALIAÇÃO FINAL');

INSERT INTO avaliacaoturma(id_avaliacao, id_aluno, id_turma, id_disciplina, dt_avaliacao,nota) VALUES
	(1, 1, 1, 1, '2020-12-08',20),
	(1, 2, 1, 1, '2020-12-08',25),
	(1, 3, 1, 1, '2020-12-08',21),
	(1, 4, 1, 1, '2020-12-08',10),
	(1, 5, 1, 1, '2020-12-08',0),
	(2, 1, 1, 1, '2020-12-18',28),
	(2, 2, 1, 1, '2020-12-18',22),
	(2, 3, 1, 1, '2020-12-18',05),
	(2, 4, 1, 1, '2020-12-18',10),
	(2, 5, 1, 1, '2020-12-18',0);

UPDATE pessoa SET nome = replace(nome, 'FULANO','FULANA'), sexo = 1 WHERE id_pessoa BETWEEN 38643 AND 38650;
select * from pessoa WHERE id_pessoa BETWEEN 38643 AND 38650;

INSERT INTO pessoa (nome, cpf, dt_nascimento, sexo, estado_civil, nome_mae) VALUES('CICLANO 1','','1991-01-01',0,0,'MAE DE CICLANO 1');

-- utilizando replace:
-- sintaxe do replace: replace(campo,string a ser trocada, string trocada)
select nome, cpf, replace(replace(cpf,'.',''),'-','') from pessoa;

-- utilizando o like:
-- o comando like se aplica à strings e utiliza-se o caracter % para definir onde será considerado qualquer tipo de inforamção
select * from pessoa where nome like '%20';
select * from pessoa where nome like '%20%';
select * from pessoa where nome like 'CICL%';

-- utilizando o BETWEEN
-- sintaxe: id_cliente BETWEEN X AND Y ... valores entre X e Y

-- ---------------------------
-- Aula:
-- valores NULL
select * from pessoa where     nome_pai is null; -- seleciono pessoas com nome_pai nulo
-- selecionar todas as pessoas que TEM nome de pai (q não seja nula)
select * from pessoa where not nome_pai is null; -- seleciono pessoas com nome_pai nulo

-- operador IN dentro/contido:
select * from pessoa WHERE id_pessoa IN (select id_pessoa from aluno); -- selecionar todas as pessoas que são alunos
select * from pessoa WHERE id_pessoa NOT IN (select id_pessoa from aluno); -- selecionar todas as pessoas que NÃO são alunos
-- multiconjunto:
select * from pessoa where (nome, nome_mae) IN (select nome, nome_mae FROM pessoa where cpf like '093.%');

select * from cargopessoa where (formacao, salario) in (select formacao, salario from departamento where departamento_id = 1);

select nome, nome_mae FROM pessoa where cpf like '093.%'; -- like ; símbolo % é qualquer coisa


-- operador ALL:
select * from avaliacaoturma where nota > all (select nota from avaliacaoturma where id_avaliacao = 1) ;

-- ALIAS - apelidos:
select p1.* from pessoa AS p1 where p1.id_pessoa IN (select p2.id_pessoa from pessoa AS p2 where p2.sexo = 1);
select p.* from pessoa p WHERE p.id_pessoa IN (select a.id_pessoa from aluno a);
select p.* from pessoa p, aluno a where p.id_pessoa = a.id_pessoa;
select nome, cpf, replace(replace(cpf,'.',''),'-','') cpfLimpo from pessoa;

-- Função EXISTS se existe ou nao registro na tabela;
select p.* from pessoa p where EXISTS (select a.* from aluno a where a.id_pessoa = p.id_pessoa);
select p.* from pessoa p where NOT EXISTS (select a.* from aluno a where a.id_pessoa = p.id_pessoa);

-- JOIN
select * from (pessoa p join aluno a on p.id_pessoa = a.id_pessoa);

select p.nome, a.dt_cadastro from pessoa p, aluno a where p.id_pessoa = a.id_pessoa;
select p.nome, a.dt_cadastro from pessoa p INNER JOIN aluno a ON p.id_pessoa = a.id_pessoa;
select * from pessoa; -- 48523
select p.nome, a.dt_cadastro from pessoa p LEFT JOIN aluno a ON p.id_pessoa = a.id_pessoa order by p.id_pessoa;

-- comandos: count, sum, max, min, avg
-- count <- contar
select count(*) as totalPessoa from pessoa;
select count(*) from pessoa where sexo = 1;
-- sum <- somar
select * from avaliacaoturma where id_aluno = 3;
select sum((nota) * .2) from avaliacaoturma where id_aluno = 3;

-- max <- maior || min <- menor
select * from avaliacaoturma where id_avaliacao = 1;
select max(nota) from avaliacaoturma where id_avaliacao = 1;
select min(nota) from avaliacaoturma where id_avaliacao = 1;

-- AVG <-media
select * from avaliacaoturma where id_avaliacao = 1;
select AVG(nota) from avaliacaoturma where id_avaliacao = 1;

-- selecionar todos os registros que estão no grupo A e que estão contido no grupo B
-- primeiro gráfico (esquerda superior)
select a.* from
  pessoa a left join aluno b on  a.id_pessoa = b.id_pessoa;
-- selecionar todos os registro que estão no grupo A e não que estão em AB
-- segundo gráfico (esqueda)
select a.* from
  pessoa a left join aluno b on a.id_pessoa = b.id_pessoa
where b.id_pessoa is null;

-- agrupamentos group by e having
-- quero saber a média das notas das avaliações aplicadas:
select id_avaliacao, avg(nota) from avaliacaoturma group by id_avaliacao;
select id_avaliacao, sum(nota) from avaliacaoturma group by id_avaliacao;
select id_avaliacao, count(*) from avaliacaoturma where nota > 5 group by id_avaliacao;
select * from avaliacaoturma;
-- quero saber o nome das avaliações e suas médias;
select a.descricao, avg(at.nota) mediaNotas from avaliacaoturma at
  inner join avaliacao a ON at.id_avaliacao = a.id_avaliacao
 group by at.id_avaliacao;
-- quero saber o nome da avaliação e a maior nota:
select a.descricao, max(at.nota) maiorNota from avaliacaoturma at
  inner join avaliacao a ON at.id_avaliacao = a.id_avaliacao
 group by at.id_avaliacao;

-- having
-- selecionar a quantidade das avaliação e a descrição destas onde a qte seja maior que 2 registros com notas entre 10 e 30
select a.descricao, count(*) from avaliacao a
  inner join avaliacaoturma at on
    a.id_avaliacao = at.id_avaliacao
where at.nota between 10 and 30 group by a.descricao having count(*) > 2;
