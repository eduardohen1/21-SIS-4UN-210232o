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
-- Temporary table structure for view `vw_media_avaliacao_aluno`
--
DROP TABLE IF EXISTS `vw_media_avaliacao_aluno`;
DROP VIEW IF EXISTS `vw_media_avaliacao_aluno`;
CREATE TABLE `vw_media_avaliacao_aluno` (
  `id_aluno` int(11),
  `nome` varchar(100),
  `descricao` varchar(50),
  `media` double
);

--
-- Temporary table structure for view `vw_media_avaliacoes`
--
DROP TABLE IF EXISTS `vw_media_avaliacoes`;
DROP VIEW IF EXISTS `vw_media_avaliacoes`;
CREATE TABLE `vw_media_avaliacoes` (
  `id_avaliacao` int(11),
  `descricao` varchar(45),
  `valor` double,
  `media` double
);

--
-- Temporary table structure for view `vw_pessoa_aluno_turma`
--
DROP TABLE IF EXISTS `vw_pessoa_aluno_turma`;
DROP VIEW IF EXISTS `vw_pessoa_aluno_turma`;
CREATE TABLE `vw_pessoa_aluno_turma` (
  `nome` varchar(100),
  `cpf` varchar(14),
  `dt_nascimento` datetime,
  `dt_cadastro` datetime,
  `dt_matricula` datetime,
  `ano` int(11),
  `periodo` int(11),
  `descricao` varchar(50)
);

--
-- Temporary table structure for view `vw_pessoa_aluno_turma2`
--
DROP TABLE IF EXISTS `vw_pessoa_aluno_turma2`;
DROP VIEW IF EXISTS `vw_pessoa_aluno_turma2`;
CREATE TABLE `vw_pessoa_aluno_turma2` (
  `nome` varchar(100),
  `cpf` varchar(14),
  `dt_nascimento` varbinary(10),
  `dt_cadastro` varbinary(10),
  `dt_matricula` varbinary(10),
  `ano` int(11),
  `periodo` int(11),
  `descricao` varchar(50)
);

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
  `id_avaliacao` int(11) NOT NULL auto_increment,
  `descricao` varchar(45) NOT NULL,
  `valor` double NOT NULL,
  `observacao` text,
  PRIMARY KEY  (`id_avaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `avaliacao`
--

/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
INSERT INTO `avaliacao` (`id_avaliacao`,`descricao`,`valor`,`observacao`) VALUES 
 (1,'Trabalho 1',30,'Trabalho sobre BD'),
 (2,'Trabalho 2',30,'Trabalho sobre INNER JOIN'),
 (3,'AVALIAÇÃO',40,'AVALIAÇÃO FINAL'),
 (4,'TESTE',10,'Obs');
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
  `dt_avaliacao` datetime NOT NULL,
  `nota` double NOT NULL,
  PRIMARY KEY  (`id_avaliacao`,`id_aluno`,`id_turma`,`id_disciplina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `avaliacaoturma`
--

/*!40000 ALTER TABLE `avaliacaoturma` DISABLE KEYS */;
INSERT INTO `avaliacaoturma` (`id_avaliacao`,`id_aluno`,`id_turma`,`id_disciplina`,`dt_avaliacao`,`nota`) VALUES 
 (1,1,1,1,'2020-12-08 00:00:00',20),
 (1,2,1,1,'2020-12-08 00:00:00',25),
 (1,3,1,1,'2020-12-08 00:00:00',21),
 (1,4,1,1,'2020-12-08 00:00:00',10),
 (1,5,1,1,'2020-12-08 00:00:00',0),
 (2,1,1,1,'2020-12-18 00:00:00',28),
 (2,2,1,1,'2020-12-18 00:00:00',22),
 (2,3,1,1,'2020-12-18 00:00:00',5),
 (2,4,1,1,'2020-12-18 00:00:00',10),
 (2,5,1,1,'2020-12-18 00:00:00',0),
 (3,1,1,1,'2020-12-15 00:00:00',30),
 (3,2,1,1,'2020-12-15 00:00:00',39),
 (3,3,1,1,'2020-12-15 00:00:00',20),
 (3,4,1,1,'2020-12-15 00:00:00',35),
 (3,5,1,1,'