-- Aula 24/11/2020 -- Arquitetura

use escola;
-- verificou a física dos dados
create table teste (id int not null auto_increment primary key,
descricao varchar(50));
drop table teste;

-- verificou a lógica dos dados
select * from aluno;
desc aluno;
alter table aluno add id_teste int;
alter table aluno drop id_teste;
alter table aluno add id_teste varchar(10);

-- acrescentar pessoas:
select * from pessoa;
insert into pessoa(nome, cpf, dt_nascimento, sexo, estado_civil, nome_mae, nome_pai) values
('Fulano 1', '111.111.111-11', '1990-01-01', 0, 0, 'MAE DE FULANO 1', 'PAI DE FULANO 1'),
('Fulano 2', '111.111.111-12', '1990-02-01', 0, 0, 'MAE DE FULANO 2', 'PAI DE FULANO 2'),
('Fulano 3', '111.111.111-13', '1990-03-01', 0, 0, 'MAE DE FULANO 3', 'PAI DE FULANO 3'),
('Fulano 4', '111.111.111-14', '1990-04-01', 0, 0, 'MAE DE FULANO 4', 'PAI DE FULANO 4'),
('Fulano 5', '111.111.111-15', '1990-05-01', 0, 0, 'MAE DE FULANO 5', 'PAI DE FULANO 5'),
('Fulano 6', '111.111.111-16', '1990-06-01', 0, 0, 'MAE DE FULANO 6', 'PAI DE FULANO 6');
select * from pessoa;

-- buscar data e hora atual
select now();

-- acrescentar os alunos:
select * from aluno;
insert into aluno(dt_cadastro, id_pessoa) values
(now(),1),
(now(),2),
(now(),3),
(now(),4),
(now(),5);
select * from aluno;

-- ajustando dados em novo campo
update aluno set id_teste = 'Oi123' where id_pessoa = 2;
update aluno set id_teste = '' where id_pessoa <> 2;
select * from aluno;
desc aluno;

-- modificando o campo para ampliar a quantidade de caracteres
alter table aluno modify column id_teste varchar(50);
select * from aluno;
desc aluno;

-- mudando o título do campo
alter table aluno change column id_teste id_testes varchar(50);
select * from aluno;
desc aluno;

-- escluindo novo campo
alter table aluno drop id_testes;
select * from aluno;
desc aluno;

-- mudar a exibição da estrutura de dados
select * from pessoa;
select nome, cpf, estado_civil from pessoa; -- estado_civil em integer
select nome, cpf, CONVERT(estado_civil, char) as estadoCivil from pessoa; -- estado_civil em string

-- ----------------
-- quero saber o nome, o cpf e a data de cadastro dos alunos
select * from aluno;
select * from pessoa where id_pessoa = 1 or id_pessoa = 2 or id_pessoa = 3 or id_pessoa = 4 or id_pessoa = 5; -- seleciono pessoas q são alunos
select * from pessoa where id_pessoa IN (1,2,3,4,5); -- seleciono pessoas q são alunos mais rápido e menos memória
select * from pessoa where id_pessoa IN (select id_pessoa from aluno); -- subquery
select * from pessoa, aluno where pessoa.id_pessoa = aluno.id_pessoa; -- 2 tabelas em 1 consulta fazendo relacionamento
select
  pessoa.nome,
  pessoa.cpf,
  aluno.dt_cadastro, DATE_FORMAT(aluno.dt_cadastro,'%d/%m/%Y') dataCadastro
from
  pessoa, aluno
where
  pessoa.id_pessoa = aluno.id_pessoa; -- visão

-- cadastrar o curso:
insert into curso(descricao) values('SISTEMAS DE INFORMACAO');
select * from curso;
-- turma
insert into turma(dt_incial, dt_final, ano, periodo, descricao, id_curso) values
('2020-11-03','2021-03-31',2020,2,'BD2',1);
select * from turma;
-- alunoturma
select * from aluno;
insert into alunoturma(id_aluno, id_turma, dt_matricula, dt_cancelamento) values
(1, 1, now(), '1900-01-01'),
(2, 1, now(), '1900-01-01'),
(3, 1, now(), '1900-01-01'),
(4, 1, now(), '1900-01-01'),
(5, 1, now(), '1900-01-01');
select * from alunoturma;

-- quero saber o nome do aluno e dt_matricula e o nome do curso <<== dica da atividade assíncrona!
select
  *
from
  pessoa, aluno, alunoturma, turma, curso
where pessoa.id_pessoa = aluno.id_pessoa and aluno.id_aluno = alunoturma.id_aluno and alunoturma.id_turma = turma.id_turma
and turma.id_curso = curso.id_curso; -- <- pegou todos os campos

-- fazendo a seleção de apenas o necessário
select
  pessoa.nome, alunoturma.dt_matricula, curso.descricao
from
  pessoa, aluno, alunoturma, turma, curso
where pessoa.id_pessoa = aluno.id_pessoa and aluno.id_aluno = alunoturma.id_aluno and alunoturma.id_turma = turma.id_turma
and turma.id_curso = curso.id_curso;