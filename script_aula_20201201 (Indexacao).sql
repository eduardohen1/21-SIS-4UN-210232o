SELECT * FROM pessoa p;
-- nível conceitual da tabela:/
desc pessoa;
desc aluno;

-- esquema externo (visao) -
select
  pessoa.nome, turma.descricao, turma.ano, turma.periodo, aluno.dt_cadastro
from
  aluno, pessoa, alunoturma, turma
where
  aluno.id_pessoa     = pessoa.id_pessoa    and
  aluno.id_aluno      = alunoturma.id_aluno and
  alunoturma.id_turma = turma.id_turma;
-- ------------------------------------------------
select * from pessoa;
delete from pessoa;
insert into pessoa(nome, cpf, dt_nascimento, sexo, estado_civil, nome_mae, nome_pai) values
('CICLANO 1','','1990-01-01',0,0,'','');
truncate table pessoa;
-- ------
-- pesquisa por indice e por nome: EXPLAIN
select * from pessoa where id_pessoa = 27416; -- 0,0004S
select * from pessoa where nome = 'FULANO 63086'; -- 0,0290S

-- Comando EXPLAIN exibe a qte de linhas de pesquisa
explain select * from pessoa where id_pessoa = 27416; -- 1 rows
explain select * from pessoa where nome = 'FULANO 63086'; -- 48616 rows

explain select * from pessoa where id_pessoa = 10274; -- 0,0003s | 1 rows
explain select * from pessoa where cpf = '977.004.878-11'; -- 0,0266s | 48778 rows

-- criar os índices:
create index idx01 on pessoa (cpf);
explain select * from pessoa where id_pessoa = 10274; -- 0,0003s | 1 rows
explain select * from pessoa where cpf = '977.004.878-11'; -- 0,0003s | 1 rows
drop index idx01 on pessoa;

explain select * from pessoa where nome = 'FULANO 72953'; -- 0,0257s | 48616 rows
create index idx02 on pessoa (nome desc);
explain select * from pessoa where nome = 'FULANO 72953'; -- 0,0003s | 1 rows


-- simulando com o mesmo nome de pessoa:
drop index idx02 on pessoa;
insert into pessoa (nome, cpf, dt_nascimento, sexo, estado_civil, nome_mae, nome_pai) values
('FULANO 72953','148.775.466-11','1990-01-01',0,0, '','');
explain select * from pessoa where nome = 'FULANO 72953'; -- 0,0287s /48616 rows
create index idx02 on pessoa (nome desc);
explain select * from pessoa where nome = 'FULANO 72953'; -- 0,0003s /1 rows
