CREATE DATABASE  IF NOT EXISTS `dbescola` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbescola`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: dbescola
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbaluno`
--

DROP TABLE IF EXISTS `tbaluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbaluno` (
  `IdAluno` int NOT NULL AUTO_INCREMENT,
  `nomeAluno` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `IdResponsavel` int DEFAULT NULL,
  `IdPai` int DEFAULT NULL,
  `IdMae` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `CPF` varchar(11) NOT NULL,
  `RG` varchar(10) NOT NULL,
  `IdEndereco` int DEFAULT NULL,
  `telefone` varchar(15) NOT NULL,
  `matricula` int DEFAULT NULL,
  `sexo` char(1) NOT NULL,
  `senha` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`IdAluno`),
  KEY `FK_Aluno_Responsavel` (`IdResponsavel`),
  KEY `FK_Aluno_Pai` (`IdPai`),
  KEY `FK_Aluno_Mae` (`IdMae`),
  KEY `FK_Aluno_Endereco` (`IdEndereco`),
  CONSTRAINT `FK_Aluno_Endereco` FOREIGN KEY (`IdEndereco`) REFERENCES `tbendereco` (`IdEndereco`),
  CONSTRAINT `FK_Aluno_Responsavel` FOREIGN KEY (`IdResponsavel`) REFERENCES `tbresponsavel` (`IdResponsavel`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbaluno`
--

LOCK TABLES `tbaluno` WRITE;
/*!40000 ALTER TABLE `tbaluno` DISABLE KEYS */;
INSERT INTO `tbaluno` VALUES (22,'Henrique','1995-01-11',NULL,NULL,NULL,'Henrique@gmail.com','12312312311','123456789',NULL,'(00)000000000',20230002,'M','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),(23,'Miguel','1995-03-11',NULL,NULL,NULL,'miguel@gmail.com','341242144','002513202',NULL,'(84) 999434387',20220003,'M','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),(43,'Rodrigo','1995-03-11',NULL,NULL,NULL,'rodrigo@gmail.com','10394343476','002513202',NULL,'(84) 999434387',20230004,'M','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),(78,'Rodrigo teste insert','1995-01-11',NULL,NULL,NULL,'exemplo@exemplo.com','11111111111','123456710',NULL,'(00)000000000',20230006,'M','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5'),(80,'Samantha Costa Ribeiro','1993-07-27',NULL,NULL,NULL,'exemplo@gmail.com','98712398737','000000000',NULL,'(84)999999999',20230008,'F','bb7814513ea0991120e7f8b2e128db61621875e27e4f6168a729c23ba19796de'),(81,'Fabricio','1993-01-01',NULL,NULL,NULL,'fabricio@gmail.com','98712383766','000000000',NULL,'(84)999999999',20230009,'M','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92');
/*!40000 ALTER TABLE `tbaluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbalunoturma`
--

DROP TABLE IF EXISTS `tbalunoturma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbalunoturma` (
  `IdAlunoTurma` int NOT NULL AUTO_INCREMENT,
  `IdTurma` int DEFAULT NULL,
  `IdAluno` int DEFAULT NULL,
  `StAlunoTurma` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`IdAlunoTurma`),
  KEY `IdAluno` (`IdAluno`),
  CONSTRAINT `tbalunoturma_ibfk_1` FOREIGN KEY (`IdAluno`) REFERENCES `tbaluno` (`IdAluno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbalunoturma`
--

LOCK TABLES `tbalunoturma` WRITE;
/*!40000 ALTER TABLE `tbalunoturma` DISABLE KEYS */;
INSERT INTO `tbalunoturma` VALUES (1,12,22,_binary ''),(2,12,43,_binary ''),(3,11,23,_binary '');
/*!40000 ALTER TABLE `tbalunoturma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbcurso`
--

DROP TABLE IF EXISTS `tbcurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbcurso` (
  `IdCurso` int NOT NULL AUTO_INCREMENT,
  `NomeCurso` varchar(100) NOT NULL,
  `StOficial` bit(1) NOT NULL,
  PRIMARY KEY (`IdCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcurso`
--

LOCK TABLES `tbcurso` WRITE;
/*!40000 ALTER TABLE `tbcurso` DISABLE KEYS */;
INSERT INTO `tbcurso` VALUES (1,'Ensino Médio',_binary ''),(2,'Fundamental I',_binary ''),(3,'Fundamental II',_binary '');
/*!40000 ALTER TABLE `tbcurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbdiario`
--

DROP TABLE IF EXISTS `tbdiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbdiario` (
  `IdDiario` int NOT NULL AUTO_INCREMENT,
  `nomeDiario` varchar(100) DEFAULT NULL,
  `IdProfessor` int DEFAULT NULL,
  `IdDisciplina` int DEFAULT NULL,
  `IdTurma` int DEFAULT NULL,
  PRIMARY KEY (`IdDiario`),
  KEY `IdProfessor` (`IdProfessor`),
  KEY `IdDisciplina` (`IdDisciplina`),
  KEY `IdTurma` (`IdTurma`),
  CONSTRAINT `tbdiario_ibfk_1` FOREIGN KEY (`IdProfessor`) REFERENCES `tbprofessor` (`IdProfessor`),
  CONSTRAINT `tbdiario_ibfk_2` FOREIGN KEY (`IdDisciplina`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbdiario_ibfk_3` FOREIGN KEY (`IdTurma`) REFERENCES `tbturma` (`IdTurma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdiario`
--

LOCK TABLES `tbdiario` WRITE;
/*!40000 ALTER TABLE `tbdiario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbdiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbdisciplina`
--

DROP TABLE IF EXISTS `tbdisciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbdisciplina` (
  `IdDisciplina` int NOT NULL AUTO_INCREMENT,
  `NomeDisciplina` varchar(100) NOT NULL,
  `Sigla` varchar(10) NOT NULL,
  `StAtivo` bit(1) NOT NULL,
  PRIMARY KEY (`IdDisciplina`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdisciplina`
--

LOCK TABLES `tbdisciplina` WRITE;
/*!40000 ALTER TABLE `tbdisciplina` DISABLE KEYS */;
INSERT INTO `tbdisciplina` VALUES (1,'Matemática','MAT',_binary ''),(2,'História','HIS',_binary ''),(3,'Geografia','GEO',_binary ''),(4,'Biologia','BIO',_binary ''),(5,'Física','FIS',_binary '');
/*!40000 ALTER TABLE `tbdisciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbendereco`
--

DROP TABLE IF EXISTS `tbendereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbendereco` (
  `IdEndereco` int NOT NULL AUTO_INCREMENT,
  `cep` varchar(8) NOT NULL,
  `uf` char(2) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `complemento` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`IdEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbendereco`
--

LOCK TABLES `tbendereco` WRITE;
/*!40000 ALTER TABLE `tbendereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbendereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbgrade`
--

DROP TABLE IF EXISTS `tbgrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbgrade` (
  `IdGrade` int NOT NULL AUTO_INCREMENT,
  `IdCurso` int DEFAULT NULL,
  `IdPeriodo` int DEFAULT NULL,
  `IdSerie` int DEFAULT NULL,
  `IdDisciplina` int DEFAULT NULL,
  `IdDisciplina2` int DEFAULT NULL,
  `IdDisciplina3` int DEFAULT NULL,
  `IdDisciplina4` int DEFAULT NULL,
  `IdDisciplina5` int DEFAULT NULL,
  `IdDisciplina6` int DEFAULT NULL,
  `IdDisciplina7` int DEFAULT NULL,
  `IdDisciplina8` int DEFAULT NULL,
  `IdDisciplina9` int DEFAULT NULL,
  `IdDisciplina10` int DEFAULT NULL,
  `IdDisciplina11` int DEFAULT NULL,
  `IdDisciplina12` int DEFAULT NULL,
  `IdDisciplina13` int DEFAULT NULL,
  `IdDisciplina14` int DEFAULT NULL,
  `IdDisciplina15` int DEFAULT NULL,
  `IdDisciplina16` int DEFAULT NULL,
  `IdDisciplina17` int DEFAULT NULL,
  `IdDisciplina18` int DEFAULT NULL,
  `IdDisciplina19` int DEFAULT NULL,
  `IdDisciplina20` int DEFAULT NULL,
  `IdDisciplina21` int DEFAULT NULL,
  `IdDisciplina22` int DEFAULT NULL,
  `IdDisciplina23` int DEFAULT NULL,
  `IdDisciplina24` int DEFAULT NULL,
  `IdDisciplina25` int DEFAULT NULL,
  `IdDisciplina26` int DEFAULT NULL,
  `IdDisciplina27` int DEFAULT NULL,
  `IdDisciplina28` int DEFAULT NULL,
  `IdDisciplina29` int DEFAULT NULL,
  `IdDisciplina30` int DEFAULT NULL,
  `IdDisciplina31` int DEFAULT NULL,
  PRIMARY KEY (`IdGrade`),
  KEY `IdCurso` (`IdCurso`),
  KEY `IdPeriodo` (`IdPeriodo`),
  KEY `IdSerie` (`IdSerie`),
  KEY `IdDisciplina` (`IdDisciplina`),
  KEY `IdDisciplina2` (`IdDisciplina2`),
  KEY `IdDisciplina3` (`IdDisciplina3`),
  KEY `IdDisciplina4` (`IdDisciplina4`),
  KEY `IdDisciplina5` (`IdDisciplina5`),
  KEY `IdDisciplina6` (`IdDisciplina6`),
  KEY `IdDisciplina7` (`IdDisciplina7`),
  KEY `IdDisciplina8` (`IdDisciplina8`),
  KEY `IdDisciplina9` (`IdDisciplina9`),
  KEY `IdDisciplina10` (`IdDisciplina10`),
  KEY `IdDisciplina11` (`IdDisciplina11`),
  KEY `IdDisciplina12` (`IdDisciplina12`),
  KEY `IdDisciplina13` (`IdDisciplina13`),
  KEY `IdDisciplina14` (`IdDisciplina14`),
  KEY `IdDisciplina15` (`IdDisciplina15`),
  KEY `IdDisciplina16` (`IdDisciplina16`),
  KEY `IdDisciplina17` (`IdDisciplina17`),
  KEY `IdDisciplina18` (`IdDisciplina18`),
  KEY `IdDisciplina19` (`IdDisciplina19`),
  KEY `IdDisciplina20` (`IdDisciplina20`),
  KEY `IdDisciplina21` (`IdDisciplina21`),
  KEY `IdDisciplina22` (`IdDisciplina22`),
  KEY `IdDisciplina23` (`IdDisciplina23`),
  KEY `IdDisciplina24` (`IdDisciplina24`),
  KEY `IdDisciplina25` (`IdDisciplina25`),
  KEY `IdDisciplina26` (`IdDisciplina26`),
  KEY `IdDisciplina27` (`IdDisciplina27`),
  KEY `IdDisciplina28` (`IdDisciplina28`),
  KEY `IdDisciplina29` (`IdDisciplina29`),
  KEY `IdDisciplina30` (`IdDisciplina30`),
  CONSTRAINT `tbgrade_ibfk_1` FOREIGN KEY (`IdCurso`) REFERENCES `tbcurso` (`IdCurso`),
  CONSTRAINT `tbgrade_ibfk_10` FOREIGN KEY (`IdDisciplina7`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_11` FOREIGN KEY (`IdDisciplina8`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_12` FOREIGN KEY (`IdDisciplina9`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_13` FOREIGN KEY (`IdDisciplina10`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_14` FOREIGN KEY (`IdDisciplina11`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_15` FOREIGN KEY (`IdDisciplina12`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_16` FOREIGN KEY (`IdDisciplina13`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_17` FOREIGN KEY (`IdDisciplina14`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_18` FOREIGN KEY (`IdDisciplina15`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_19` FOREIGN KEY (`IdDisciplina16`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_2` FOREIGN KEY (`IdPeriodo`) REFERENCES `tbperiodo` (`IdPeriodo`),
  CONSTRAINT `tbgrade_ibfk_20` FOREIGN KEY (`IdDisciplina17`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_21` FOREIGN KEY (`IdDisciplina18`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_22` FOREIGN KEY (`IdDisciplina19`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_23` FOREIGN KEY (`IdDisciplina20`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_24` FOREIGN KEY (`IdDisciplina21`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_25` FOREIGN KEY (`IdDisciplina22`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_26` FOREIGN KEY (`IdDisciplina23`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_27` FOREIGN KEY (`IdDisciplina24`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_28` FOREIGN KEY (`IdDisciplina25`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_29` FOREIGN KEY (`IdDisciplina26`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_3` FOREIGN KEY (`IdSerie`) REFERENCES `tbserie` (`IdSerie`),
  CONSTRAINT `tbgrade_ibfk_30` FOREIGN KEY (`IdDisciplina27`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_31` FOREIGN KEY (`IdDisciplina28`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_32` FOREIGN KEY (`IdDisciplina29`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_33` FOREIGN KEY (`IdDisciplina30`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_4` FOREIGN KEY (`IdDisciplina`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_5` FOREIGN KEY (`IdDisciplina2`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_6` FOREIGN KEY (`IdDisciplina3`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_7` FOREIGN KEY (`IdDisciplina4`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_8` FOREIGN KEY (`IdDisciplina5`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbgrade_ibfk_9` FOREIGN KEY (`IdDisciplina6`) REFERENCES `tbdisciplina` (`IdDisciplina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbgrade`
--

LOCK TABLES `tbgrade` WRITE;
/*!40000 ALTER TABLE `tbgrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbgrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbnotas`
--

DROP TABLE IF EXISTS `tbnotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbnotas` (
  `IdNota` int NOT NULL AUTO_INCREMENT,
  `Idalunoturma` int DEFAULT NULL,
  `IdAluno` int DEFAULT NULL,
  `IdDisciplina` int DEFAULT NULL,
  `nota1` float DEFAULT NULL,
  `nota2` float DEFAULT NULL,
  `nota3` float DEFAULT NULL,
  `media` float DEFAULT NULL,
  PRIMARY KEY (`IdNota`),
  KEY `Idalunoturma` (`Idalunoturma`),
  KEY `IdAluno` (`IdAluno`),
  KEY `IdDisciplina` (`IdDisciplina`),
  CONSTRAINT `tbnotas_ibfk_1` FOREIGN KEY (`Idalunoturma`) REFERENCES `tbalunoturma` (`IdAlunoTurma`),
  CONSTRAINT `tbnotas_ibfk_2` FOREIGN KEY (`IdAluno`) REFERENCES `tbaluno` (`IdAluno`),
  CONSTRAINT `tbnotas_ibfk_3` FOREIGN KEY (`IdDisciplina`) REFERENCES `tbdisciplina` (`IdDisciplina`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbnotas`
--

LOCK TABLES `tbnotas` WRITE;
/*!40000 ALTER TABLE `tbnotas` DISABLE KEYS */;
INSERT INTO `tbnotas` VALUES (1,2,43,1,7.5,8,10,NULL);
/*!40000 ALTER TABLE `tbnotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbperiodo`
--

DROP TABLE IF EXISTS `tbperiodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbperiodo` (
  `IdPeriodo` int NOT NULL AUTO_INCREMENT,
  `PeriodoNumero` int NOT NULL,
  `NomePeriodo` varchar(100) NOT NULL,
  `DataInicial` date NOT NULL,
  `DataFinal` date NOT NULL,
  `PeriodoAtual` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`IdPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbperiodo`
--

LOCK TABLES `tbperiodo` WRITE;
/*!40000 ALTER TABLE `tbperiodo` DISABLE KEYS */;
INSERT INTO `tbperiodo` VALUES (1,2023,'Período 2023','2023-01-01','2023-12-31',_binary ''),(2,2022,'Período 2022','2022-01-01','2022-12-31',_binary '\0');
/*!40000 ALTER TABLE `tbperiodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbprofessor`
--

DROP TABLE IF EXISTS `tbprofessor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbprofessor` (
  `IdProfessor` int NOT NULL AUTO_INCREMENT,
  `NomeProfessor` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `RG` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `idendereco` int DEFAULT NULL,
  `StAtivo` bit(1) NOT NULL,
  `senha` varchar(256) DEFAULT NULL,
  `sexo` char(1) NOT NULL,
  PRIMARY KEY (`IdProfessor`),
  KEY `FK_Professor_Endereco` (`idendereco`),
  CONSTRAINT `FK_Professor_Endereco` FOREIGN KEY (`idendereco`) REFERENCES `tbendereco` (`IdEndereco`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbprofessor`
--

LOCK TABLES `tbprofessor` WRITE;
/*!40000 ALTER TABLE `tbprofessor` DISABLE KEYS */;
INSERT INTO `tbprofessor` VALUES (1,'Josemar da Silva','13970265029','123334445','emaildoprofessor@gmail.com','(84)999444487',NULL,_binary '','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','M'),(2,'Ademar de Lima','28183403069','998899090','emailademar@gmail.com','(84)99994444',NULL,_binary '','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','M'),(3,'josemar sa silva','28183403999','998899098','emailjosemar@gmail.com','(84)99994444',NULL,_binary '','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','M');
/*!40000 ALTER TABLE `tbprofessor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbregistrodiario`
--

DROP TABLE IF EXISTS `tbregistrodiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbregistrodiario` (
  `Idregistro` int NOT NULL AUTO_INCREMENT,
  `IdDiario` int DEFAULT NULL,
  `IdDisciplina` int DEFAULT NULL,
  `IdProfessor` int DEFAULT NULL,
  `IdTurma` int DEFAULT NULL,
  `conteudo` text,
  `data` date DEFAULT NULL,
  PRIMARY KEY (`Idregistro`),
  KEY `IdDiario` (`IdDiario`),
  KEY `IdProfessor` (`IdProfessor`),
  KEY `IdDisciplina` (`IdDisciplina`),
  KEY `IdTurma` (`IdTurma`),
  CONSTRAINT `tbregistrodiario_ibfk_1` FOREIGN KEY (`IdDiario`) REFERENCES `tbdiario` (`IdDiario`),
  CONSTRAINT `tbregistrodiario_ibfk_2` FOREIGN KEY (`IdProfessor`) REFERENCES `tbprofessor` (`IdProfessor`),
  CONSTRAINT `tbregistrodiario_ibfk_3` FOREIGN KEY (`IdDisciplina`) REFERENCES `tbdisciplina` (`IdDisciplina`),
  CONSTRAINT `tbregistrodiario_ibfk_4` FOREIGN KEY (`IdTurma`) REFERENCES `tbturma` (`IdTurma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbregistrodiario`
--

LOCK TABLES `tbregistrodiario` WRITE;
/*!40000 ALTER TABLE `tbregistrodiario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbregistrodiario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbresponsavel`
--

DROP TABLE IF EXISTS `tbresponsavel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbresponsavel` (
  `IdResponsavel` int NOT NULL AUTO_INCREMENT,
  `NomeR` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `CPF` varchar(11) NOT NULL,
  `RG` varchar(10) NOT NULL,
  `Idendereco` int DEFAULT NULL,
  `telefone` varchar(15) NOT NULL,
  `telefone_2` varchar(15) DEFAULT NULL,
  `senha` varchar(256) DEFAULT NULL,
  `sexo` char(1) NOT NULL,
  PRIMARY KEY (`IdResponsavel`),
  KEY `FK_Responsavel_Endereco` (`Idendereco`),
  CONSTRAINT `FK_Responsavel_Endereco` FOREIGN KEY (`Idendereco`) REFERENCES `tbendereco` (`IdEndereco`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbresponsavel`
--

LOCK TABLES `tbresponsavel` WRITE;
/*!40000 ALTER TABLE `tbresponsavel` DISABLE KEYS */;
INSERT INTO `tbresponsavel` VALUES (1,'Ricardo Rodrigues','1993-01-01','ricardo@gmail.com','12332112322','000000000',NULL,'(84)999999999',NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','M'),(6,'pai teste','1993-01-01','paiteste5@gmail.com','12332112328','000000009',NULL,'(84)999999999',NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','M');
/*!40000 ALTER TABLE `tbresponsavel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbserie`
--

DROP TABLE IF EXISTS `tbserie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbserie` (
  `IdSerie` int NOT NULL AUTO_INCREMENT,
  `NomeSerie` varchar(100) NOT NULL,
  `IdCurso` int NOT NULL,
  PRIMARY KEY (`IdSerie`),
  KEY `IdCurso` (`IdCurso`),
  CONSTRAINT `tbserie_ibfk_1` FOREIGN KEY (`IdCurso`) REFERENCES `tbcurso` (`IdCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbserie`
--

LOCK TABLES `tbserie` WRITE;
/*!40000 ALTER TABLE `tbserie` DISABLE KEYS */;
INSERT INTO `tbserie` VALUES (1,'1° Ano',2),(2,'2° Ano',2),(3,'3° Ano',2),(4,'4° Ano',2),(5,'5° Ano',2),(6,'6° Ano',3),(7,'7° Ano',3),(8,'8° Ano',3),(9,'9° Ano',3);
/*!40000 ALTER TABLE `tbserie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbturma`
--

DROP TABLE IF EXISTS `tbturma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbturma` (
  `IdTurma` int NOT NULL AUTO_INCREMENT,
  `NomeTurma` varchar(100) NOT NULL,
  `SiglaTurma` varchar(100) NOT NULL,
  `IdCurso` int NOT NULL,
  `IdSerie` int NOT NULL,
  `IdPeriodo` int NOT NULL,
  PRIMARY KEY (`IdTurma`),
  KEY `IdCurso` (`IdCurso`),
  KEY `IdSerie` (`IdSerie`),
  KEY `IdPeriodo` (`IdPeriodo`),
  CONSTRAINT `tbturma_ibfk_1` FOREIGN KEY (`IdCurso`) REFERENCES `tbcurso` (`IdCurso`),
  CONSTRAINT `tbturma_ibfk_2` FOREIGN KEY (`IdSerie`) REFERENCES `tbserie` (`IdSerie`),
  CONSTRAINT `tbturma_ibfk_3` FOREIGN KEY (`IdPeriodo`) REFERENCES `tbperiodo` (`IdPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbturma`
--

LOCK TABLES `tbturma` WRITE;
/*!40000 ALTER TABLE `tbturma` DISABLE KEYS */;
INSERT INTO `tbturma` VALUES (1,'Turma A','A',2,1,1),(2,'Turma B','B',2,1,1),(3,'Turma A','A',2,2,1),(4,'Turma B','B',2,2,1),(5,'Turma A','A',2,3,1),(6,'Turma B','B',2,3,1),(7,'Turma B','B',2,4,1),(8,'Turma A','A',2,4,1),(9,'Turma A','A',2,5,1),(10,'Turma B','B',2,5,1),(11,'Turma A','A',2,6,1),(12,'Turma B','B',2,6,1),(13,'Turma B','B',2,7,1),(14,'Turma A','A',2,7,1),(15,'Turma A','A',2,8,1),(16,'Turma B','B',2,8,1),(17,'Turma B','B',2,9,1),(18,'Turma A','A',2,9,1);
/*!40000 ALTER TABLE `tbturma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbusuario`
--

DROP TABLE IF EXISTS `tbusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbusuario` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `NomeUsuario` varchar(100) NOT NULL,
  `NomeCargo` varchar(100) DEFAULT NULL,
  `senha` varchar(256) DEFAULT NULL,
  `StAtivo` bit(1) DEFAULT b'1',
  `cpf` varchar(11) NOT NULL,
  `RG` varchar(20) NOT NULL,
  `sexo` char(1) NOT NULL,
  PRIMARY KEY (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusuario`
--

LOCK TABLES `tbusuario` WRITE;
/*!40000 ALTER TABLE `tbusuario` DISABLE KEYS */;
INSERT INTO `tbusuario` VALUES (1,'Rodrigo Rodrigues','Diretor','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',_binary '','10394343476','002513202','M'),(2,'Caio Santos','Coordenador','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',_binary '','00000000000','123123123','M');
/*!40000 ALTER TABLE `tbusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_aluno_situacao`
--

DROP TABLE IF EXISTS `vw_aluno_situacao`;
/*!50001 DROP VIEW IF EXISTS `vw_aluno_situacao`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_aluno_situacao` AS SELECT 
 1 AS `NomePeriodo`,
 1 AS `NomeSerie`,
 1 AS `NomeCurso`,
 1 AS `NomeTurma`,
 1 AS `SiglaTurma`,
 1 AS `Matricula`,
 1 AS `NomeAluno`,
 1 AS `StAlunoTurma`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_dados_alunos`
--

DROP TABLE IF EXISTS `vw_dados_alunos`;
/*!50001 DROP VIEW IF EXISTS `vw_dados_alunos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dados_alunos` AS SELECT 
 1 AS `NomeAluno`,
 1 AS `telefone`,
 1 AS `cpf`,
 1 AS `rg`,
 1 AS `data_nascimento`,
 1 AS `email`,
 1 AS `matricula`,
 1 AS `NomeTurma`,
 1 AS `NomeSerie`,
 1 AS `NomeResponsavel`,
 1 AS `NomePai`,
 1 AS `NomeMae`,
 1 AS `sexo`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_aluno_situacao`
--

/*!50001 DROP VIEW IF EXISTS `vw_aluno_situacao`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_aluno_situacao` AS select `tbperiodo`.`NomePeriodo` AS `NomePeriodo`,`tbserie`.`NomeSerie` AS `NomeSerie`,`tbcurso`.`NomeCurso` AS `NomeCurso`,`tbturma`.`NomeTurma` AS `NomeTurma`,`tbturma`.`SiglaTurma` AS `SiglaTurma`,`tbaluno`.`matricula` AS `Matricula`,`tbaluno`.`nomeAluno` AS `NomeAluno`,(case `tbalunoturma`.`StAlunoTurma` when 1 then 'Ativo' when 0 then 'Inativo' end) AS `StAlunoTurma` from (((((`tbaluno` join `tbalunoturma` on((`tbaluno`.`IdAluno` = `tbalunoturma`.`IdAluno`))) join `tbturma` on((`tbturma`.`IdTurma` = `tbalunoturma`.`IdTurma`))) join `tbserie` on((`tbserie`.`IdSerie` = `tbturma`.`IdSerie`))) join `tbcurso` on((`tbcurso`.`IdCurso` = `tbserie`.`IdCurso`))) join `tbperiodo` on((`tbperiodo`.`IdPeriodo` = `tbturma`.`IdPeriodo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dados_alunos`
--

/*!50001 DROP VIEW IF EXISTS `vw_dados_alunos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dados_alunos` AS select `tbaluno`.`nomeAluno` AS `NomeAluno`,`tbaluno`.`telefone` AS `telefone`,`tbaluno`.`CPF` AS `cpf`,`tbaluno`.`RG` AS `rg`,date_format(`tbaluno`.`data_nascimento`,'%d/%m/%Y') AS `data_nascimento`,`tbaluno`.`email` AS `email`,`tbaluno`.`matricula` AS `matricula`,`tbturma`.`NomeTurma` AS `NomeTurma`,`tbserie`.`NomeSerie` AS `NomeSerie`,`tbresponsavel`.`NomeR` AS `NomeResponsavel`,`rp`.`NomeR` AS `NomePai`,`rm`.`NomeR` AS `NomeMae`,(case `tbaluno`.`sexo` when 'M' then 'Masculino' when 'F' then 'Feminino' when 'O' then 'Outro' end) AS `sexo` from ((((((`tbaluno` left join `tbalunoturma` on((`tbalunoturma`.`IdAluno` = `tbaluno`.`IdAluno`))) left join `tbturma` on((`tbturma`.`IdTurma` = `tbalunoturma`.`IdTurma`))) left join `tbserie` on((`tbturma`.`IdSerie` = `tbserie`.`IdSerie`))) left join `tbresponsavel` on((`tbresponsavel`.`IdResponsavel` = `tbaluno`.`IdResponsavel`))) left join `tbresponsavel` `rp` on(((`rp`.`IdResponsavel` = `tbaluno`.`IdPai`) and (`rp`.`IdResponsavel` = `tbresponsavel`.`IdResponsavel`)))) left join `tbresponsavel` `rm` on(((`rm`.`IdResponsavel` = `tbaluno`.`IdMae`) and (`rm`.`IdResponsavel` = `tbresponsavel`.`IdResponsavel`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-14 19:25:12
