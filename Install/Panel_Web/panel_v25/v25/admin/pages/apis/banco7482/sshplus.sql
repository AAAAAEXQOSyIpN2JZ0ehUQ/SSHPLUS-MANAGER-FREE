-- MySQL dump 10.13  Distrib 5.5.62, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sshplus
-- ------------------------------------------------------
-- Server version	5.5.62-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acesso_servidor`
--

DROP TABLE IF EXISTS `acesso_servidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acesso_servidor` (
  `id_acesso_servidor` int(10) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_mestre` int(11) NOT NULL DEFAULT '0',
  `id_servidor_mestre` int(11) NOT NULL DEFAULT '0',
  `qtd` int(10) NOT NULL DEFAULT '0',
  `validade` datetime NOT NULL,
  `demo` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_acesso_servidor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acesso_servidor`
--

LOCK TABLES `acesso_servidor` WRITE;
/*!40000 ALTER TABLE `acesso_servidor` DISABLE KEYS */;
INSERT INTO `acesso_servidor` VALUES (1,1,1,0,0,40,'2020-02-24 00:00:00',0),(2,1,2,1,1,10,'2020-02-26 00:00:00',0);
/*!40000 ALTER TABLE `acesso_servidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id_administrador` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(60) NOT NULL,
  `senha` varchar(60) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `accessKEY` varchar(100) DEFAULT NULL,
  `site` varchar(255) NOT NULL,
  PRIMARY KEY (`id_administrador`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','alicia','Administrador','admin@admin.com',NULL,'meusite.com');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anuncios`
--

DROP TABLE IF EXISTS `anuncios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anuncios` (
  `anuncio1` text NOT NULL,
  `anuncio2` text NOT NULL,
  `anuncio3` text NOT NULL,
  `anuncio4` text NOT NULL,
  `anuncio5` text NOT NULL,
  `anuncio6` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anuncios`
--

LOCK TABLES `anuncios` WRITE;
/*!40000 ALTER TABLE `anuncios` DISABLE KEYS */;
INSERT INTO `anuncios` VALUES ('Insira o Código Adsense no Painel','Insira o Código Adsense no Painel','Insira o Código Adsense no Painel','Insira o Código Adsense no Painel','Insira o Código Adsense no Painel','Insira o Código Adsense no Painel');
/*!40000 ALTER TABLE `anuncios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arquivo_download`
--

DROP TABLE IF EXISTS `arquivo_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arquivo_download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `status` enum('funcionando','testes') NOT NULL,
  `tipo` enum('ehi','apk','outros') NOT NULL,
  `operadora` enum('todas','claro','vivo','tim','oi') NOT NULL,
  `data` datetime NOT NULL,
  `detalhes` text NOT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `cliente_tipo` enum('vpn','revenda','todos') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arquivo_download`
--

LOCK TABLES `arquivo_download` WRITE;
/*!40000 ALTER TABLE `arquivo_download` DISABLE KEYS */;
INSERT INTO `arquivo_download` VALUES (2,'BR01','funcionando','ehi','vivo','2020-01-27 13:10:53','Todas Regioes','BR1.ehi','todos'),(3,'BR02','funcionando','ehi','claro','2020-01-27 13:11:40','Requer promoção prezao','BR2.ehi','todos'),(4,'BR03','funcionando','ehi','oi','2020-01-27 13:12:06','Requer promoção oi livre','BR3.ehi','todos'),(5,'TIM01','testes','ehi','tim','2020-01-27 13:13:00','Em testes','BR4.ehi','todos');
/*!40000 ALTER TABLE `arquivo_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chamados`
--

DROP TABLE IF EXISTS `chamados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chamados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `id_mestre` int(11) NOT NULL DEFAULT '0',
  `tipo` enum('contassh','revendassh','usuariossh','servidor','outros') NOT NULL,
  `status` enum('aberto','resposta','encerrado') NOT NULL,
  `resposta` text NOT NULL,
  `login` varchar(255) NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `mensagem` text NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chamados`
--

LOCK TABLES `chamados` WRITE;
/*!40000 ALTER TABLE `chamados` DISABLE KEYS */;
/*!40000 ALTER TABLE `chamados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracao`
--

DROP TABLE IF EXISTS `configuracao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracao` (
  `id_configuracao` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) NOT NULL,
  `titulo_pagina` varchar(60) NOT NULL,
  PRIMARY KEY (`id_configuracao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracao`
--

LOCK TABLES `configuracao` WRITE;
/*!40000 ALTER TABLE `configuracao` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fatura`
--

DROP TABLE IF EXISTS `fatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fatura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `servidor_id` int(11) NOT NULL,
  `conta_id` int(11) NOT NULL,
  `tipo` enum('vpn','revenda','outros') NOT NULL,
  `qtd` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `datavencimento` datetime NOT NULL,
  `status` enum('pendente','cancelado','pago') NOT NULL,
  `descrição` text NOT NULL,
  `valor` int(11) NOT NULL,
  `desconto` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura`
--

LOCK TABLES `fatura` WRITE;
/*!40000 ALTER TABLE `fatura` DISABLE KEYS */;
INSERT INTO `fatura` VALUES (1,1,0,0,'vpn',1,'2020-01-25 20:12:32','2020-01-28 00:00:00','pendente','Pagar e enviar print',1,0);
/*!40000 ALTER TABLE `fatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fatura_clientes`
--

DROP TABLE IF EXISTS `fatura_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fatura_clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `id_mestre` int(11) NOT NULL DEFAULT '0',
  `servidor_id` int(11) NOT NULL,
  `conta_id` int(11) NOT NULL,
  `tipo` enum('vpn','revenda','outros') NOT NULL,
  `qtd` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `datavencimento` datetime NOT NULL,
  `status` enum('pendente','cancelado','pago') NOT NULL,
  `descrição` text NOT NULL,
  `valor` int(11) NOT NULL,
  `desconto` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura_clientes`
--

LOCK TABLES `fatura_clientes` WRITE;
/*!40000 ALTER TABLE `fatura_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `fatura_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fatura_comprovantes`
--

DROP TABLE IF EXISTS `fatura_comprovantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fatura_comprovantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fatura_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `status` enum('aberto','fechado') NOT NULL DEFAULT 'aberto',
  `data` datetime NOT NULL,
  `formapagamento` enum('boleto','deptra') NOT NULL,
  `nota` text NOT NULL,
  `imagem` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura_comprovantes`
--

LOCK TABLES `fatura_comprovantes` WRITE;
/*!40000 ALTER TABLE `fatura_comprovantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `fatura_comprovantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fatura_comprovantes_clientes`
--

DROP TABLE IF EXISTS `fatura_comprovantes_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fatura_comprovantes_clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_mestre` int(11) NOT NULL DEFAULT '0',
  `fatura_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `status` enum('aberto','fechado') NOT NULL DEFAULT 'aberto',
  `data` datetime NOT NULL,
  `formapagamento` enum('boleto','deptra') NOT NULL,
  `nota` text NOT NULL,
  `imagem` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura_comprovantes_clientes`
--

LOCK TABLES `fatura_comprovantes_clientes` WRITE;
/*!40000 ALTER TABLE `fatura_comprovantes_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `fatura_comprovantes_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_usuario_ssh_online`
--

DROP TABLE IF EXISTS `hist_usuario_ssh_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hist_usuario_ssh_online` (
  `id_hist_usrSSH` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `hora_conexao` datetime NOT NULL,
  `hora_desconexao` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id_hist_usrSSH`)
) ENGINE=MyISAM AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_usuario_ssh_online`
--

LOCK TABLES `hist_usuario_ssh_online` WRITE;
/*!40000 ALTER TABLE `hist_usuario_ssh_online` DISABLE KEYS */;
INSERT INTO `hist_usuario_ssh_online` VALUES (1,5,'2020-01-28 03:00:02','2020-01-28 03:01:01',0),(2,7,'2020-01-28 03:00:02','2020-01-28 03:01:01',0),(3,10,'2020-01-28 03:00:02','2020-01-28 03:01:01',0),(4,5,'2020-01-28 03:01:01','2020-01-28 03:02:01',0),(5,7,'2020-01-28 03:01:01','2020-01-28 03:02:01',0),(6,10,'2020-01-28 03:01:01','2020-01-28 03:02:01',0),(7,5,'2020-01-28 03:02:01','2020-01-28 03:03:01',0),(8,7,'2020-01-28 03:02:01','2020-01-28 03:03:01',0),(9,10,'2020-01-28 03:02:01','2020-01-28 03:03:01',0),(10,5,'2020-01-28 03:03:01','2020-01-28 03:04:01',0),(11,7,'2020-01-28 03:03:01','2020-01-28 03:04:01',0),(12,10,'2020-01-28 03:03:01','2020-01-28 03:04:01',0),(13,5,'2020-01-28 03:04:01','2020-01-28 03:05:01',0),(14,7,'2020-01-28 03:04:01','2020-01-28 03:05:01',0),(15,10,'2020-01-28 03:04:01','2020-01-28 03:05:01',0),(16,5,'2020-01-28 03:05:01','2020-01-28 03:06:01',0),(17,7,'2020-01-28 03:05:01','2020-01-28 03:06:01',0),(18,10,'2020-01-28 03:05:01','2020-01-28 03:06:01',0),(19,5,'2020-01-28 03:06:01','2020-01-28 03:07:01',0),(20,7,'2020-01-28 03:06:01','2020-01-28 03:07:01',0),(21,10,'2020-01-28 03:06:01','2020-01-28 03:07:01',0),(22,5,'2020-01-28 03:07:01','2020-01-28 03:08:01',0),(23,7,'2020-01-28 03:07:01','2020-01-28 03:08:01',0),(24,10,'2020-01-28 03:07:01','2020-01-28 03:08:01',0),(25,5,'2020-01-28 03:08:01','2020-01-28 03:09:01',0),(26,7,'2020-01-28 03:08:01','2020-01-28 03:09:01',0),(27,10,'2020-01-28 03:08:01','2020-01-28 03:09:01',0),(28,5,'2020-01-28 03:09:01','2020-01-28 03:10:01',0),(29,7,'2020-01-28 03:09:01','2020-01-28 03:10:01',0),(30,10,'2020-01-28 03:09:01','2020-01-28 03:10:01',0),(31,5,'2020-01-28 03:10:01','2020-01-28 03:11:01',0),(32,7,'2020-01-28 03:10:01','2020-01-28 03:11:01',0),(33,10,'2020-01-28 03:10:01','2020-01-28 03:11:01',0),(34,5,'2020-01-28 03:11:01','2020-01-28 03:12:01',0),(35,7,'2020-01-28 03:11:01','2020-01-28 03:12:01',0),(36,10,'2020-01-28 03:11:01','2020-01-28 03:12:01',0),(37,5,'2020-01-28 03:12:01','2020-01-28 03:13:01',0),(38,7,'2020-01-28 03:12:01','2020-01-28 03:13:01',0),(39,10,'2020-01-28 03:12:01','2020-01-28 03:13:01',0),(40,5,'2020-01-28 03:13:01','2020-01-28 03:14:01',0),(41,7,'2020-01-28 03:13:01','2020-01-28 03:14:01',0),(42,10,'2020-01-28 03:13:01','2020-01-28 03:14:01',0),(43,5,'2020-01-28 03:14:01','2020-01-28 03:15:01',0),(44,7,'2020-01-28 03:14:01','2020-01-28 03:15:01',0),(45,10,'2020-01-28 03:14:01','2020-01-28 03:15:01',0),(46,5,'2020-01-28 03:15:01','2020-01-28 03:16:01',0),(47,7,'2020-01-28 03:15:01','2020-01-28 03:16:01',0),(48,10,'2020-01-28 03:15:01','2020-01-28 03:16:01',0),(49,5,'2020-01-28 03:16:01','2020-01-28 03:17:01',0),(50,7,'2020-01-28 03:16:01','2020-01-28 03:17:01',0),(51,10,'2020-01-28 03:16:01','2020-01-28 03:17:01',0),(52,5,'2020-01-28 03:17:01','2020-01-28 03:18:01',0),(53,7,'2020-01-28 03:17:01','2020-01-28 03:18:01',0),(54,10,'2020-01-28 03:17:01','2020-01-28 03:18:01',0),(55,5,'2020-01-28 03:18:01','2020-01-28 03:19:01',0),(56,7,'2020-01-28 03:18:01','2020-01-28 03:19:01',0),(57,10,'2020-01-28 03:18:01','2020-01-28 03:19:01',0),(58,5,'2020-01-28 03:19:01','2020-01-28 03:20:01',0),(59,7,'2020-01-28 03:19:01','2020-01-28 03:20:01',0),(60,10,'2020-01-28 03:19:01','2020-01-28 03:20:01',0),(61,5,'2020-01-28 03:20:01','2020-01-28 03:21:01',0),(62,7,'2020-01-28 03:20:01','2020-01-28 03:21:01',0),(63,10,'2020-01-28 03:20:01','2020-01-28 03:21:01',0),(64,5,'2020-01-28 03:21:01','2020-01-28 03:22:01',0),(65,7,'2020-01-28 03:21:01','2020-01-28 03:22:01',0),(66,10,'2020-01-28 03:21:01','2020-01-28 03:22:01',0),(67,5,'2020-01-28 03:22:01','2020-01-28 03:23:01',0),(68,7,'2020-01-28 03:22:01','2020-01-28 03:23:01',0),(69,10,'2020-01-28 03:22:01','2020-01-28 03:23:01',0),(70,5,'2020-01-28 03:23:01','2020-01-28 03:24:02',0),(71,7,'2020-01-28 03:23:01','2020-01-28 03:24:02',0),(72,10,'2020-01-28 03:23:01','2020-01-28 03:24:02',0),(73,5,'2020-01-28 03:24:02','2020-01-28 03:25:01',0),(74,7,'2020-01-28 03:24:02','2020-01-28 03:25:01',0),(75,10,'2020-01-28 03:24:02','2020-01-28 03:25:01',0),(76,5,'2020-01-28 03:25:01','2020-01-28 03:26:01',0),(77,7,'2020-01-28 03:25:01','2020-01-28 03:26:01',0),(78,10,'2020-01-28 03:25:01','2020-01-28 03:26:01',0),(79,5,'2020-01-28 03:26:01','2020-01-28 03:27:02',0),(80,7,'2020-01-28 03:26:01','2020-01-28 03:27:02',0),(81,10,'2020-01-28 03:26:01','2020-01-28 03:27:02',0),(82,5,'2020-01-28 03:27:02','2020-01-28 03:28:01',0),(83,7,'2020-01-28 03:27:02','2020-01-28 03:28:01',0),(84,10,'2020-01-28 03:27:02','2020-01-28 03:28:01',0),(85,5,'2020-01-28 03:28:01','2020-01-28 03:29:01',0),(86,7,'2020-01-28 03:28:01','2020-01-28 03:29:01',0),(87,10,'2020-01-28 03:28:01','2020-01-28 03:29:01',0),(88,5,'2020-01-28 03:29:01','2020-01-28 03:30:02',0),(89,7,'2020-01-28 03:29:01','2020-01-28 03:30:02',0),(90,10,'2020-01-28 03:29:01','2020-01-28 03:30:02',0),(91,5,'2020-01-28 03:30:02','2020-01-28 03:31:01',0),(92,7,'2020-01-28 03:30:02','2020-01-28 03:31:01',0),(93,10,'2020-01-28 03:30:02','2020-01-28 03:31:01',0),(94,5,'2020-01-28 03:31:01','2020-01-28 03:32:01',0),(95,7,'2020-01-28 03:31:01','2020-01-28 03:32:01',0),(96,10,'2020-01-28 03:31:01','2020-01-28 03:32:01',0),(97,5,'2020-01-28 03:32:01','2020-01-28 03:33:01',0),(98,7,'2020-01-28 03:32:01','2020-01-28 03:33:01',0),(99,10,'2020-01-28 03:32:01','2020-01-28 03:33:01',0),(100,5,'2020-01-28 03:33:01','2020-01-28 03:34:01',0),(101,7,'2020-01-28 03:33:01','2020-01-28 03:34:01',0),(102,10,'2020-01-28 03:33:01','2020-01-28 03:34:01',0),(103,5,'2020-01-28 03:34:01','2020-01-28 03:35:01',0),(104,7,'2020-01-28 03:34:01','2020-01-28 03:35:01',0),(105,10,'2020-01-28 03:34:01','2020-01-28 03:35:01',0),(106,5,'2020-01-28 03:35:01','2020-01-28 03:36:01',0),(107,7,'2020-01-28 03:35:01','2020-01-28 03:36:01',0),(108,10,'2020-01-28 03:35:01','2020-01-28 03:36:01',0),(109,5,'2020-01-28 03:36:01','2020-01-28 03:37:01',0),(110,7,'2020-01-28 03:36:01','2020-01-28 03:37:01',0),(111,10,'2020-01-28 03:36:01','2020-01-28 03:37:01',0),(112,5,'2020-01-28 03:37:01','2020-01-28 03:38:01',0),(113,7,'2020-01-28 03:37:01','2020-01-28 03:38:01',0),(114,10,'2020-01-28 03:37:01','2020-01-28 03:38:01',0),(115,5,'2020-01-28 03:38:01','2020-01-28 03:39:01',0),(116,7,'2020-01-28 03:38:01','2020-01-28 03:39:01',0),(117,10,'2020-01-28 03:38:01','2020-01-28 03:39:01',0),(118,5,'2020-01-28 03:39:01','2020-01-28 03:40:01',0),(119,7,'2020-01-28 03:39:01','2020-01-28 03:40:01',0),(120,10,'2020-01-28 03:39:01','2020-01-28 03:40:01',0),(121,5,'2020-01-28 03:40:01','2020-01-28 03:41:01',0),(122,7,'2020-01-28 03:40:01','2020-01-28 03:41:01',0),(123,10,'2020-01-28 03:40:01','2020-01-28 03:41:01',0),(124,5,'2020-01-28 03:41:01','2020-01-28 03:42:01',0),(125,7,'2020-01-28 03:41:01','2020-01-28 03:42:01',0),(126,10,'2020-01-28 03:41:01','2020-01-28 03:42:01',0),(127,5,'2020-01-28 03:42:01','2020-01-28 03:43:01',0),(128,7,'2020-01-28 03:42:01','2020-01-28 03:43:01',0),(129,10,'2020-01-28 03:42:01','2020-01-28 03:43:01',0),(130,5,'2020-01-28 03:43:01','2020-01-28 03:44:01',0),(131,7,'2020-01-28 03:43:01','2020-01-28 03:44:01',0),(132,10,'2020-01-28 03:43:01','2020-01-28 03:44:01',0),(133,5,'2020-01-28 03:44:01','2020-01-28 03:45:01',0),(134,7,'2020-01-28 03:44:01','2020-01-28 03:45:01',0),(135,10,'2020-01-28 03:44:01','2020-01-28 03:45:01',0),(136,5,'2020-01-28 03:45:01','2020-01-28 03:46:01',0),(137,7,'2020-01-28 03:45:01','2020-01-28 03:46:01',0),(138,10,'2020-01-28 03:45:01','2020-01-28 03:46:01',0),(139,5,'2020-01-28 03:46:01','2020-01-28 03:47:01',0),(140,7,'2020-01-28 03:46:01','2020-01-28 03:47:01',0),(141,10,'2020-01-28 03:46:01','2020-01-28 03:47:01',0),(142,5,'2020-01-28 03:47:01','2020-01-28 03:48:01',0),(143,7,'2020-01-28 03:47:01','2020-01-28 03:48:01',0),(144,10,'2020-01-28 03:47:01','2020-01-28 03:48:01',0),(145,5,'2020-01-28 03:48:01','2020-01-28 03:49:01',0),(146,7,'2020-01-28 03:48:01','2020-01-28 03:49:01',0),(147,10,'2020-01-28 03:48:01','2020-01-28 03:49:01',0),(148,5,'2020-01-28 03:49:01','2020-01-28 03:50:01',0),(149,7,'2020-01-28 03:49:01','2020-01-28 03:50:01',0),(150,10,'2020-01-28 03:49:01','2020-01-28 03:50:01',0),(151,5,'2020-01-28 03:50:01','2020-01-28 03:51:01',0),(152,7,'2020-01-28 03:50:01','2020-01-28 03:51:01',0),(153,10,'2020-01-28 03:50:01','2020-01-28 03:51:01',0),(154,5,'2020-01-28 03:51:01','2020-01-28 03:52:01',0),(155,7,'2020-01-28 03:51:01','2020-01-28 03:52:01',0),(156,10,'2020-01-28 03:51:01','2020-01-28 03:52:01',0),(157,5,'2020-01-28 03:52:01','2020-01-28 03:53:01',0),(158,7,'2020-01-28 03:52:01','2020-01-28 03:53:01',0),(159,10,'2020-01-28 03:52:01','2020-01-28 03:53:01',0),(160,5,'2020-01-28 03:53:01','2020-01-28 03:54:01',0),(161,7,'2020-01-28 03:53:01','2020-01-28 03:54:01',0),(162,10,'2020-01-28 03:53:01','2020-01-28 03:54:01',0),(163,5,'2020-01-28 03:54:01','2020-01-28 03:55:01',0),(164,7,'2020-01-28 03:54:01','2020-01-28 03:55:01',0),(165,10,'2020-01-28 03:54:01','2020-01-28 03:55:01',0),(166,5,'2020-01-28 03:55:01','2020-01-28 03:56:01',0),(167,7,'2020-01-28 03:55:01','2020-01-28 03:56:01',0),(168,10,'2020-01-28 03:55:01','2020-01-28 03:56:01',0),(169,5,'2020-01-28 03:56:01','2020-01-28 03:57:01',0),(170,7,'2020-01-28 03:56:01','2020-01-28 03:57:01',0),(171,10,'2020-01-28 03:56:01','2020-01-28 03:57:01',0),(172,5,'2020-01-28 03:57:01','2020-01-28 03:58:01',0),(173,7,'2020-01-28 03:57:01','2020-01-28 03:58:01',0),(174,10,'2020-01-28 03:57:01','2020-01-28 03:58:01',0),(175,5,'2020-01-28 03:58:01','2020-01-28 03:59:01',0),(176,7,'2020-01-28 03:58:01','2020-01-28 03:59:01',0),(177,10,'2020-01-28 03:58:01','2020-01-28 03:59:01',0),(178,5,'2020-01-28 03:59:01',NULL,1),(179,7,'2020-01-28 03:59:01',NULL,1),(180,10,'2020-01-28 03:59:01',NULL,1);
/*!40000 ALTER TABLE `hist_usuario_ssh_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_usuario_ssh_online_free`
--

DROP TABLE IF EXISTS `hist_usuario_ssh_online_free`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hist_usuario_ssh_online_free` (
  `id_hist_usrSSH` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `hora_conexao` datetime NOT NULL,
  `hora_desconexao` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id_hist_usrSSH`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_usuario_ssh_online_free`
--

LOCK TABLES `hist_usuario_ssh_online_free` WRITE;
/*!40000 ALTER TABLE `hist_usuario_ssh_online_free` DISABLE KEYS */;
/*!40000 ALTER TABLE `hist_usuario_ssh_online_free` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_login`
--

DROP TABLE IF EXISTS `historico_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historico_login` (
  `id_historico_login` int(10) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) NOT NULL,
  `data_login` datetime NOT NULL,
  `ip_login` varchar(100) NOT NULL,
  `navegador` varchar(100) NOT NULL,
  PRIMARY KEY (`id_historico_login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_login`
--

LOCK TABLES `historico_login` WRITE;
/*!40000 ALTER TABLE `historico_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informativo`
--

DROP TABLE IF EXISTS `informativo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informativo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informativo`
--

LOCK TABLES `informativo` WRITE;
/*!40000 ALTER TABLE `informativo` DISABLE KEYS */;
/*!40000 ALTER TABLE `informativo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mercadopago`
--

DROP TABLE IF EXISTS `mercadopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mercadopago` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `CLIENT_SECRET` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mercadopago`
--

LOCK TABLES `mercadopago` WRITE;
/*!40000 ALTER TABLE `mercadopago` DISABLE KEYS */;
INSERT INTO `mercadopago` VALUES ('7981557107733328','MpCwg3eVrRsfYtMB99ptMF7hx2D2K2VV');
/*!40000 ALTER TABLE `mercadopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noticias`
--

DROP TABLE IF EXISTS `noticias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noticias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` enum('ativo','desativado') NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `subtitulo` varchar(255) NOT NULL,
  `msg` text NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noticias`
--

LOCK TABLES `noticias` WRITE;
/*!40000 ALTER TABLE `noticias` DISABLE KEYS */;
INSERT INTO `noticias` VALUES (1,'desativado','ATENÇÃO !','MANUTENCAO BR1','Ola mundo','2020-01-25 21:05:42');
/*!40000 ALTER TABLE `noticias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacoes`
--

DROP TABLE IF EXISTS `notificacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `conta_id` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `tipo` enum('fatura','conta','revenda','outros','usuario','chamados') NOT NULL,
  `linkfatura` varchar(255) NOT NULL,
  `mensagem` text NOT NULL,
  `info_outros` varchar(50) NOT NULL,
  `lido` enum('nao','sim') NOT NULL DEFAULT 'nao',
  `admin` enum('nao','sim') NOT NULL DEFAULT 'nao',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacoes`
--

LOCK TABLES `notificacoes` WRITE;
/*!40000 ALTER TABLE `notificacoes` DISABLE KEYS */;
INSERT INTO `notificacoes` VALUES (1,1,0,'2020-01-25 20:12:32','fatura','faturas/abertas','Foi gerado uma nova fatura para seus serviços veja!','','sim','nao'),(2,1,0,'2020-01-25 21:51:24','revenda','Admin','O Admin Adicionou um Servidor a sua conta <b>BR-1</b> Limite: 50 Validade: 30 dias','','sim','nao'),(3,1,0,'2020-01-26 13:41:46','conta','n/d','Conta criada <small><b>teste1</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(4,1,0,'2020-01-26 13:43:35','conta','n/d','Conta criada <small><b>teste3</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(5,1,0,'2020-01-27 01:24:36','conta','n/d','Conta criada <small><b>TESTE10</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(6,1,0,'2020-01-27 12:06:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(7,2,0,'2020-01-27 12:06:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(8,3,0,'2020-01-27 12:06:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(9,1,0,'2020-01-27 13:10:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(10,2,0,'2020-01-27 13:10:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(11,3,0,'2020-01-27 13:10:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(12,1,0,'2020-01-27 13:11:40','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(13,2,0,'2020-01-27 13:11:40','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(14,3,0,'2020-01-27 13:11:40','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(15,1,0,'2020-01-27 13:12:06','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(16,2,0,'2020-01-27 13:12:06','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(17,3,0,'2020-01-27 13:12:06','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(18,1,0,'2020-01-27 13:13:00','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(19,2,0,'2020-01-27 13:13:00','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(20,3,0,'2020-01-27 13:13:00','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(21,1,0,'2020-01-27 20:15:58','conta','n/d','Conta criada <small><b>TESTE10</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(22,1,0,'2020-01-27 20:16:36','conta','n/d','Conta criada <small><b>crzvpn10</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','nao','nao'),(23,1,0,'2020-01-27 20:33:50','conta','n/d','A Pservers acabou de suspender a Conta SSH <small><b>TESTE10</b></small>!','Encerramento','nao','nao'),(24,1,0,'2020-01-27 20:52:02','conta','n/d','A Pservers acabou de encerrar a Conta SSH <small><b>teste3</b></small>!','Encerramento','nao','nao'),(25,1,0,'2020-01-27 21:27:42','conta','n/d','Conta criada <small><b>farias</b></small> Validade <small><i><b>5 Dias</b></i></small>  !','Conta Criada','nao','nao'),(26,1,0,'2020-01-27 21:28:04','conta','n/d','Conta criada <small><b>vence</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(27,1,0,'2020-01-27 21:28:54','conta','n/d','A Pservers acabou de encerrar a Conta SSH <small><b>teste1</b></small>!','Encerramento','nao','nao'),(28,1,0,'2020-01-27 21:31:01','conta','n/d','Conta criada <small><b>tst10</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(29,1,0,'2020-01-28 00:45:29','conta','n/d','Conta criada <small><b>TEST60</b></small> Validade <small><i><b>5 Dias</b></i></small>  !','Conta Criada','nao','nao'),(30,1,0,'2020-01-28 00:45:47','conta','n/d','Conta criada <small><b>teste023</b></small> Validade <small><i><b>2 Dias</b></i></small>  !','Conta Criada','nao','nao');
/*!40000 ALTER TABLE `notificacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovpn`
--

DROP TABLE IF EXISTS `ovpn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovpn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servidor_id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `arquivo` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovpn`
--

LOCK TABLES `ovpn` WRITE;
/*!40000 ALTER TABLE `ovpn` DISABLE KEYS */;
/*!40000 ALTER TABLE `ovpn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servidor`
--

DROP TABLE IF EXISTS `servidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servidor` (
  `id_servidor` int(11) NOT NULL AUTO_INCREMENT,
  `ativo` int(10) NOT NULL DEFAULT '0',
  `nome` varchar(100) NOT NULL,
  `regiao` enum('asia','america','europa','australia') NOT NULL,
  `limite_usuario` int(10) NOT NULL DEFAULT '0',
  `ip_servidor` varchar(100) NOT NULL,
  `site_servidor` varchar(255) NOT NULL,
  `login_server` varchar(30) NOT NULL,
  `senha` varchar(60) NOT NULL,
  `porta` int(10) NOT NULL DEFAULT '22',
  `dias` int(10) NOT NULL DEFAULT '0',
  `demo` int(11) NOT NULL DEFAULT '0',
  `ehi` varchar(1000) DEFAULT NULL,
  `localizacao` varchar(255) NOT NULL,
  `localizacao_img` varchar(50) NOT NULL,
  `validade` int(11) NOT NULL,
  `limite` int(11) NOT NULL,
  `tipo` enum('premium','free') NOT NULL DEFAULT 'premium',
  `manutencao` enum('nao','sim') NOT NULL DEFAULT 'nao',
  PRIMARY KEY (`id_servidor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servidor`
--

LOCK TABLES `servidor` WRITE;
/*!40000 ALTER TABLE `servidor` DISABLE KEYS */;
INSERT INTO `servidor` VALUES (1,0,'BR-1','america',0,'52.138.3.74','Seu-Site.com','root','eloa',22,0,0,NULL,'São paulo','',10000,10000,'premium','nao');
/*!40000 ALTER TABLE `servidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `id_sms` int(11) NOT NULL AUTO_INCREMENT,
  `id_remetente` int(11) NOT NULL,
  `id_destinatario` int(11) NOT NULL,
  `assunto` varchar(100) NOT NULL,
  `mensagem` varchar(500) NOT NULL,
  `hora_resquisicao` datetime NOT NULL,
  `hora_envio` datetime NOT NULL,
  `status` enum('Aguardando','Enviado','Erro') NOT NULL DEFAULT 'Aguardando',
  PRIMARY KEY (`id_sms`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
INSERT INTO `sms` VALUES (1,0,1,'Reenviar Senha','Dados de acesso: IP->localhost Login-> crazy Senha->101010','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando');
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smtp`
--

DROP TABLE IF EXISTS `smtp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smtp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `servidor` varchar(255) NOT NULL,
  `porta` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `ssl_secure` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smtp`
--

LOCK TABLES `smtp` WRITE;
/*!40000 ALTER TABLE `smtp` DISABLE KEYS */;
/*!40000 ALTER TABLE `smtp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smtp_usuarios`
--

DROP TABLE IF EXISTS `smtp_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smtp_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ssl_secure` varchar(255) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `servidor` varchar(255) NOT NULL,
  `empresa` varchar(255) NOT NULL,
  `porta` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smtp_usuarios`
--

LOCK TABLES `smtp_usuarios` WRITE;
/*!40000 ALTER TABLE `smtp_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `smtp_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(60) NOT NULL AUTO_INCREMENT,
  `id_mestre` int(10) DEFAULT '0',
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `atualiza_dados` int(11) NOT NULL DEFAULT '0',
  `login` varchar(60) NOT NULL,
  `senha` varchar(60) NOT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `avatar` varchar(50) NOT NULL DEFAULT '1',
  `email` varchar(100) DEFAULT NULL,
  `celular` varchar(20) NOT NULL,
  `data_cadastro` datetime DEFAULT NULL,
  `tipo` enum('vpn','revenda','','') NOT NULL,
  `subrevenda` enum('nao','sim') NOT NULL,
  `validade` date DEFAULT NULL,
  `suspenso` date DEFAULT NULL,
  `token_user` varchar(120) DEFAULT NULL,
  `permitir_demo` int(11) NOT NULL DEFAULT '0',
  `dias_demo_sub` int(10) NOT NULL DEFAULT '0',
  `apagar` int(11) NOT NULL DEFAULT '0',
  `idcliente_mp` varchar(255) NOT NULL,
  `tokensecret_mp` varchar(255) NOT NULL,
  `dadosdeposito` text NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `token_user` (`token_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,0,1,1,'crazy','101010','Dimas Amado','2','crzvpn@gmail.com','(11) 99999-9999','2020-01-24 14:13:41','revenda','nao',NULL,NULL,'011121451',0,0,0,'','',''),(2,1,2,1,'subcrazy','101010','subcrazy','1','adc@gmail.com','(11) 99999-9999','2020-01-26 14:53:20','revenda','sim',NULL,NULL,'03C4D2663',0,0,2,'','',''),(3,1,1,0,'client1','1234','client1','1',NULL,'(11) 99999-9999','2020-01-26 14:54:12','vpn','nao',NULL,NULL,'0514C642D',0,0,0,'','','');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_ssh`
--

DROP TABLE IF EXISTS `usuario_ssh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_ssh` (
  `id_usuario_ssh` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_servidor` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `login` varchar(30) NOT NULL,
  `senha` varchar(20) NOT NULL,
  `data_validade` date NOT NULL,
  `data_suspensao` datetime DEFAULT NULL,
  `apagar` int(2) NOT NULL DEFAULT '0',
  `acesso` int(10) NOT NULL DEFAULT '1',
  `online` int(11) NOT NULL DEFAULT '0',
  `online_start` datetime DEFAULT NULL,
  `online_hist` int(11) NOT NULL DEFAULT '0',
  `demo` enum('nao','sim') NOT NULL DEFAULT 'nao',
  PRIMARY KEY (`id_usuario_ssh`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_ssh`
--

LOCK TABLES `usuario_ssh` WRITE;
/*!40000 ALTER TABLE `usuario_ssh` DISABLE KEYS */;
INSERT INTO `usuario_ssh` VALUES (5,1,1,1,'crzvpn10','1234','2020-02-26',NULL,0,1,0,'2020-01-28 03:59:01',1,'nao'),(7,1,1,1,'vence','1234','2020-01-28',NULL,0,1,0,'2020-01-28 03:59:01',1,'nao'),(10,1,1,1,'teste023','1234','2020-01-30',NULL,0,1,0,'2020-01-28 03:59:01',1,'nao');
/*!40000 ALTER TABLE `usuario_ssh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_ssh_free`
--

DROP TABLE IF EXISTS `usuario_ssh_free`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_ssh_free` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `servidor` int(11) NOT NULL,
  `validade` datetime NOT NULL,
  `ip` varchar(255) NOT NULL,
  `online` int(11) NOT NULL DEFAULT '0',
  `online_start` datetime DEFAULT NULL,
  `online_hist` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_ssh_free`
--

LOCK TABLES `usuario_ssh_free` WRITE;
/*!40000 ALTER TABLE `usuario_ssh_free` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_ssh_free` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-28  4:00:02
