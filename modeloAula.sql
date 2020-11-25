-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.16-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema escola
--

CREATE DATABASE IF NOT EXISTS escola;
USE escola;

--
-- Definition of table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
CREATE TABLE `aluno` (
  `id_aluno` int(11) NOT NULL auto_increment,
  `dt_cadastro` datetime NOT NULL,
  `id_pessoa` int(11) NOT NULL,
  PRIMARY KEY  (`id_aluno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `aluno`
--

/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` (`id_aluno`,`dt_cadastro`,`id_pessoa`) VALUES 
 (1,'2020-11-24 21:51:21',1),
 (2,'2020-11-24 21:51:21',2),
 (3,'2020-11-24 21:51:21',3),
 (4,'2020-11-24 21:51:21',4),
 (5,'2020-11-24 21:51:21',5);
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;


--
-- Definition of table `alunoturma`
--

DROP TABLE IF EXISTS `alunoturma`;
CREATE TABLE `alunoturma` (
  `id_aluno` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `dt_matricula` datetime NOT NULL,
  `dt_cancelamento` datetime NOT NULL,
  PRIMARY KEY  (`id_aluno`,`id_turma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alunoturma`
--

/*!40000 ALTER TABLE `alunoturma` DISABLE KEYS */;
INSERT INTO `alunoturma` (`id_aluno`,`id_turma`,`dt_matricula`,`dt_cancelamento`) VALUES 
 (1,1,'2020-11-24 22:33:44','1900-01-01 00:00:00'),
 (2,1,'2020-11-24 22:33:44','1900-01-01 00:00:00'),
 (3,1,'2020-11-24 22:33:44','1900-01-01 00:00:00'),
 (4,1,'2020-11-24 22:33:44','1900-01-01 00:00:00'),
 (5,1,'2020-11-24 22:33:44','1900-01-01 00:00:00');
/*!40000 ALTER TABLE `alunoturma` ENABLE KEYS */;


--
-- Definition of table `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
CREATE TABLE `avaliacao` (
  `id_avaliacao` int(11) NOT NULL,
  `descricacao` varchar(45) NOT NULL,
  `valor` double NOT NULL,
  `observacao` text,
  PRIMARY KEY  (`id_avaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `avaliacao`
--

/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;


--
-- Definition of table `avaliacaoturma`
--

DROP TABLE IF EXISTS `avaliacaoturma`;
CREATE TABLE `avaliacaoturma` (
  `id_avaliacao` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `dt_avalicacao` datetime NOT NULL,
  `nota` double NOT NULL,
  PRIMARY KEY  (`id_avaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `avaliacaoturma`
--

/*!40000 ALTER TABLE `avaliacaoturma` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacaoturma` ENABLE KEYS */;


--
-- Definition of table `curso`
--

DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL auto_increment,
  `descricao` varchar(100) default NULL,
  PRIMARY KEY  (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `curso`
--

/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` (`id_curso`,`descricao`) VALUES 
 (1,'SISTEMAS DE INFORMACAO');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;


--
-- Definition of table `disciplina`
--

DROP TABLE IF EXISTS `disciplina`;
CREATE TABLE `disciplina` (
  `id_disciplina` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `numero` int(11) NOT NULL,
  `creditos` int(11) NOT NULL,
  PRIMARY KEY  (`id_disciplina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `disciplina`
--

/*!40000 ALTER TABLE `disciplina` DISABLE KEYS */;
/*!40000 ALTER TABLE `disciplina` ENABLE KEYS */;


--
-- Definition of table `frequencia`
--

DROP TABLE IF EXISTS `frequencia`;
CREATE TABLE `frequencia` (
  `id_aluno` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `dt_frequencia` datetime NOT NULL,
  `frequencia` int(11) NOT NULL default '0' COMMENT '0 - presente\n1 - ausente',
  PRIMARY KEY  (`id_aluno`,`id_turma`,`id_disciplina`,`dt_frequencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `frequencia`
--

/*!40000 ALTER TABLE `frequencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `frequencia` ENABLE KEYS */;


--
-- Definition of table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
CREATE TABLE `pessoa` (
  `id_pessoa` int(11) NOT NULL auto_increment,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL COMMENT 'Gravar com máscara (000.000.000-00)',
  `dt_nascimento` datetime NOT NULL,
  `sexo` int(11) NOT NULL,
  `estado_civil` int(11) NOT NULL,
  `nome_mae` varchar(100) NOT NULL,
  `nome_pai` varchar(100) default NULL,
  PRIMARY KEY  (`id_pessoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pessoa`
--

/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` (`id_pessoa`,`nome`,`cpf`,`dt_nascimento`,`sexo`,`estado_civil`,`nome_mae`,`nome_pai`) VALUES 
 (1,'Fulano 1','111.111.111-11','1990-01-01 00:00:00',0,0,'MAE DE FULANO 1','PAI DE FULANO 1'),
 (2,'Fulano 2','111.111.111-12','1990-02-01 00:00:00',0,0,'MAE DE FULANO 2','PAI DE FULANO 2'),
 (3,'Fulano 3','111.111.111-13','1990-03-01 00:00:00',0,0,'MAE DE FULANO 3','PAI DE FULANO 3'),
 (4,'Fulano 4','111.111.111-14','1990-04-01 00:00:00',0,0,'MAE DE FULANO 4','PAI DE FULANO 4'),
 (5,'Fulano 5','111.111.111-15','1990-05-01 00:00:00',0,0,'MAE DE FULANO 5','PAI DE FULANO 5'),
 (6,'Fulano 6','111.111.111-16','1990-06-01 00:00:00',0,0,'MAE DE FULANO 6','PAI DE FULANO 6');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;


--
-- Definition of table `prof_turm_disc`
--

DROP TABLE IF EXISTS `prof_turm_disc`;
CREATE TABLE `prof_turm_disc` (
  `id_professor` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  PRIMARY KEY  (`id_professor`,`id_turma`,`id_disciplina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `prof_turm_disc`
--

/*!40000 ALTER TABLE `prof_turm_disc` DISABLE KEYS */;
/*!40000 ALTER TABLE `prof_turm_disc` ENABLE KEYS */;


--
-- Definition of table `professor`
--

DROP TABLE IF EXISTS `professor`;
CREATE TABLE `professor` (
  `id_professor` int(11) NOT NULL auto_increment,
  `formacao` varchar(45) NOT NULL,
  `id_pessoa` int(11) NOT NULL,
  PRIMARY KEY  (`id_professor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `professor`
--

/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;


--
-- Definition of table `turma`
--

DROP TABLE IF EXISTS `turma`;
CREATE TABLE `turma` (
  `id_turma` int(11) NOT NULL auto_increment,
  `dt_incial` datetime NOT NULL,
  `dt_final` datetime NOT NULL,
  `ano` int(11) NOT NULL,
  `periodo` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  `id_curso` int(11) NOT NULL,
  PRIMARY KEY  (`id_turma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `turma`
--

/*!40000 ALTER TABLE `turma` DISABLE KEYS */;
INSERT INTO `turma` (`id_turma`,`dt_incial`,`dt_final`,`ano`,`periodo`,`descricao`,`id_curso`) VALUES 
 (1,'2020-11-03 00:00:00','2021-03-31 00:00:00',2020,2,'BD2',1);
/*!40000 ALTER TABLE `turma` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
