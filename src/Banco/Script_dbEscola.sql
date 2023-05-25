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
  PRIMARY KEY (`IdAluno`),
  KEY `FK_Aluno_Responsavel` (`IdResponsavel`),
  KEY `FK_Aluno_Pai` (`IdPai`),
  KEY `FK_Aluno_Mae` (`IdMae`),
  KEY `FK_Aluno_Endereco` (`IdEndereco`),
  CONSTRAINT `FK_Aluno_Endereco` FOREIGN KEY (`IdEndereco`) REFERENCES `tbendereco` (`IdEndereco`),
  CONSTRAINT `FK_Aluno_Mae` FOREIGN KEY (`IdMae`) REFERENCES `tbresponsavel` (`IdResponsavel`),
  CONSTRAINT `FK_Aluno_Pai` FOREIGN KEY (`IdPai`) REFERENCES `tbresponsavel` (`IdResponsavel`),
  CONSTRAINT `FK_Aluno_Responsavel` FOREIGN KEY (`IdResponsavel`) REFERENCES `tbresponsavel` (`IdResponsavel`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbaluno`
--

LOCK TABLES `tbaluno` WRITE;
/*!40000 ALTER TABLE `tbaluno` DISABLE KEYS */;
INSERT INTO `tbaluno` VALUES (22,'henrique','1995-03-11',NULL,NULL,NULL,NULL,'10394343476','002513202',NULL,'(84) 999434387',20230002,'M'),(23,'Miguel','1995-03-11',NULL,NULL,NULL,NULL,'10394343476','002513202',NULL,'(84) 999434387',20220003,'M'),(43,'Rodrigo','1995-03-11',NULL,NULL,NULL,NULL,'10394343476','002513202',NULL,'(84) 999434387',20230004,'M');
/*!40000 ALTER TABLE `tbaluno` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbcurso`
--

LOCK TABLES `tbcurso` WRITE;
/*!40000 ALTER TABLE `tbcurso` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbcurso` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdisciplina`
--

LOCK TABLES `tbdisciplina` WRITE;
/*!40000 ALTER TABLE `tbdisciplina` DISABLE KEYS */;
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
  `IdEndereco` int NOT NULL,
  `StAtivo` bit(1) NOT NULL,
  PRIMARY KEY (`IdProfessor`),
  KEY `FK_Professor_Endereco` (`IdEndereco`),
  CONSTRAINT `FK_Professor_Endereco` FOREIGN KEY (`IdEndereco`) REFERENCES `tbendereco` (`IdEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbprofessor`
--

LOCK TABLES `tbprofessor` WRITE;
/*!40000 ALTER TABLE `tbprofessor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbprofessor` ENABLE KEYS */;
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
  `IdEndereco` int NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `telefone_2` varchar(15) NOT NULL,
  PRIMARY KEY (`IdResponsavel`),
  KEY `FK_Responsavel_Endereco` (`IdEndereco`),
  CONSTRAINT `FK_Responsavel_Endereco` FOREIGN KEY (`IdEndereco`) REFERENCES `tbendereco` (`IdEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbresponsavel`
--

LOCK TABLES `tbresponsavel` WRITE;
/*!40000 ALTER TABLE `tbresponsavel` DISABLE KEYS */;
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
  `IdPeriodo` int DEFAULT NULL,
  PRIMARY KEY (`IdSerie`),
  KEY `IdCurso` (`IdCurso`),
  KEY `fk_Serie_Periodo` (`IdPeriodo`),
  CONSTRAINT `fk_Serie_Periodo` FOREIGN KEY (`IdPeriodo`) REFERENCES `tbperiodo` (`IdPeriodo`),
  CONSTRAINT `tbserie_ibfk_1` FOREIGN KEY (`IdCurso`) REFERENCES `tbcurso` (`IdCurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbserie`
--

LOCK TABLES `tbserie` WRITE;
/*!40000 ALTER TABLE `tbserie` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbturma`
--

LOCK TABLES `tbturma` WRITE;
/*!40000 ALTER TABLE `tbturma` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbturma` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-25 20:43:33
