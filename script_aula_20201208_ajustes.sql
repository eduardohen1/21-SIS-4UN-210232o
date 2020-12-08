
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