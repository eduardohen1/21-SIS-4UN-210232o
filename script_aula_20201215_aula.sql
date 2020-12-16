select * from pessoa;
select * from aluno;

select * from pessoa a inner join aluno b on a.id_pessoa = b.id_pessoa;
select * from pessoa a left join aluno b on a.id_pessoa = b.id_pessoa;         
select * from pessoa a right join aluno b on a.id_pessoa = b.id_pessoa;

-- aula 15/12/2020 - VIEWS
-- pessoa + aluno + alunoturma + turma
-- Nome aluno x, cpf aluno x, dt nasc aluno x, dt cadastro aluno x, dt matricula aluno x, ano turma x, 
-- periodo turma x, descricao turma x
SELECT 
    p.nome, p.cpf, p.dt_nascimento, a.dt_cadastro, alt.dt_matricula, t.ano, t.periodo, t.descricao
FROM
    pessoa p
        INNER JOIN aluno a        ON p.id_pessoa  = a.id_pessoa
        INNER JOIN alunoturma alt ON a.id_aluno   = alt.id_aluno
        INNER JOIN turma t        ON alt.id_turma = t.id_turma;

-- Criar a view:
CREATE VIEW vw_pessoa_aluno_turma AS
SELECT 
    p.nome, p.cpf, p.dt_nascimento, a.dt_cadastro, alt.dt_matricula, t.ano, t.periodo, t.descricao
FROM
    pessoa p
        INNER JOIN aluno a        ON p.id_pessoa  = a.id_pessoa
        INNER JOIN alunoturma alt ON a.id_aluno   = alt.id_aluno
        INNER JOIN turma t        ON alt.id_turma = t.id_turma;
select * from vw_pessoa_aluno_turma;
select * from vw_pessoa_aluno_turma where nome = 'FULANO 10';
select * from pessoa where nome = 'FULANO 10';
UPDATE pessoa SET cpf = '093.418.XXX-11' where id_pessoa = 5;

-- view com datas tratadas:
SELECT 
    p.nome, p.cpf, 
    DATE_FORMAT(p.dt_nascimento, '%d/%m/%Y') dt_nascimento, 
    DATE_FORMAT(a.dt_cadastro, '%d/%m/%Y') dt_cadastro, 
    DATE_FORMAT(alt.dt_matricula, '%d/%m/%Y') dt_matricula, 
    t.ano, t.periodo, t.descricao
FROM
    pessoa p
        INNER JOIN aluno a        ON p.id_pessoa  = a.id_pessoa
        INNER JOIN alunoturma alt ON a.id_aluno   = alt.id_aluno
        INNER JOIN turma t        ON alt.id_turma = t.id_turma;
        
-- cria a view:
CREATE VIEW vw_pessoa_aluno_turma2 AS 
SELECT 
    p.nome, p.cpf, 
    DATE_FORMAT(p.dt_nascimento, '%d/%m/%Y') dt_nascimento, 
    DATE_FORMAT(a.dt_cadastro, '%d/%m/%Y') dt_cadastro, 
    DATE_FORMAT(alt.dt_matricula, '%d/%m/%Y') dt_matricula, 
    t.ano, t.periodo, t.descricao
FROM
    pessoa p
        INNER JOIN aluno a        ON p.id_pessoa  = a.id_pessoa
        INNER JOIN alunoturma alt ON a.id_aluno   = alt.id_aluno
        INNER JOIN turma t        ON alt.id_turma = t.id_turma;

-- uma consulta para definir quais as médias de notas de um aluno em um
-- determinado grupo de avaliações (id aluno | nome do aluno | descricao da turma | média)
select * from avaliacaoturma;
select id_aluno, avg(nota) media from avaliacaoturma GROUP BY id_aluno;
-- --------------------------------
SELECT 
    a.id_aluno, p.nome, t.descricao, avg(avt.nota) media
FROM
    avaliacaoturma avt
        INNER JOIN aluno a  ON avt.id_aluno = a.id_aluno
        INNER JOIN pessoa p ON a.id_pessoa  = p.id_pessoa
        INNER JOIN turma t  ON avt.id_turma = t.id_turma
GROUP BY avt.id_aluno;

-- criar a view:
CREATE VIEW vw_media_avaliacao_aluno AS 
SELECT 
    a.id_aluno, p.nome, t.descricao, avg(avt.nota) media
FROM
    avaliacaoturma avt
        INNER JOIN aluno a  ON avt.id_aluno = a.id_aluno
        INNER JOIN pessoa p ON a.id_pessoa  = p.id_pessoa
        INNER JOIN turma t  ON avt.id_turma = t.id_turma
GROUP BY avt.id_aluno;
select * from vw_media_avaliacao_aluno;

-- 
select * from avaliacao;
select * from avaliacaoturma;

insert into avaliacaoturma values
(3, 1, 1, 1, '2020-12-15',30),
(3, 2, 1, 1, '2020-12-15',39),
(3, 3, 1, 1, '2020-12-15',20),
(3, 4, 1, 1, '2020-12-15',35),
(3, 5, 1, 1, '2020-12-15',40);
select * from vw_media_avaliacao_aluno;

-- outra consulta para definirmos a média das notas nas avaliações já aplicadas
select id_avaliacao, avg(nota) from avaliacaoturma group by id_avaliacao;
-- amarrar taela avaliacaoturma junto com avaliacao (id avaliacao | descricao aval | valor | média)
SELECT 
    avt.id_avaliacao, av.descricao, av.valor, avg(avt.nota) media
FROM 
    avaliacaoturma avt
        INNER JOIN avaliacao av ON avt.id_avaliacao = av.id_avaliacao
GROUP BY avt.id_avaliacao;

-- criando view para este caso:
CREATE VIEW vw_media_avaliacoes AS
SELECT 
    avt.id_avaliacao, av.descricao, av.valor, avg(avt.nota) media
FROM 
    avaliacaoturma avt
        INNER JOIN avaliacao av ON avt.id_avaliacao = av.id_avaliacao
GROUP BY avt.id_avaliacao;

select * from vw_media_avaliacoes;

-- selecionar notas finais dos alunos:
SELECT 
    avt.id_aluno,
    sum(avt.nota) SOMATORIO_NOTAS,
    CONCAT(
      (CASE WHEN sum(avt.nota) > 50 THEN 'APROVADO COM ' ELSE 'REPROVADO COM ' END),
      ((sum(avt.nota)*100) / 100),
      '%'
    ) SITUACAO
FROM
    avaliacaoturma avt
GROUP BY avt.id_aluno;

-- selecionar notas fianis dos alunos + nome do aluno e a disciplina, criando uma view