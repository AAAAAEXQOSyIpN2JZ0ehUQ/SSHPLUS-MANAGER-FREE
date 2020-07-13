-- MySQL dump 10.15  Distrib 10.0.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sshplus
-- ------------------------------------------------------
-- Server version	10.0.38-MariaDB-0+deb8u1

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acesso_servidor`
--

LOCK TABLES `acesso_servidor` WRITE;
/*!40000 ALTER TABLE `acesso_servidor` DISABLE KEYS */;
INSERT INTO `acesso_servidor` VALUES (3,1,49,0,0,11,'2020-06-07 00:00:00',0),(5,1,59,0,0,15,'2020-06-14 00:00:00',0),(6,2,74,0,0,10,'2020-05-26 00:00:00',0);
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
INSERT INTO `admin` VALUES (1,'admin','2585','Administrador','admin@gmail.com',NULL,'www.vip-vps.tk');
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arquivo_download`
--

LOCK TABLES `arquivo_download` WRITE;
/*!40000 ALTER TABLE `arquivo_download` DISABLE KEYS */;
INSERT INTO `arquivo_download` VALUES (1,'CA-1 FREE','funcionando','ehi','vivo','2020-05-19 13:46:25','CA-1 FREE','CA-1-FREE.ehi','todos'),(2,'BR-1-PREMIUM','funcionando','ehi','vivo','2020-05-19 13:47:51','BR-1-PREMIUM','BR-1-VIVO-CLIENTE.ehi','todos'),(3,'BR-3-PREMIUM','funcionando','ehi','vivo','2020-05-19 13:48:38','BR-3-PREMIUM','BR-3-VIVO-CLIENTES.ehi','todos'),(4,'BR-3 VIVO SOCKS HTTP','funcionando','outros','claro','2020-05-22 11:40:36','BR-3 VIVO SOCKS HTTP','BR-3-VIVO-CLIENTES.sks','todos'),(6,'BR-1 VIVO SOCKS HTTP','funcionando','outros','claro','2020-05-22 11:45:53','BR-1 VIVO SOCKS HTTP','BR-1-VIVO-CLIENTES.sks','todos');
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura`
--

LOCK TABLES `fatura` WRITE;
/*!40000 ALTER TABLE `fatura` DISABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_usuario_ssh_online`
--

LOCK TABLES `hist_usuario_ssh_online` WRITE;
/*!40000 ALTER TABLE `hist_usuario_ssh_online` DISABLE KEYS */;
INSERT INTO `hist_usuario_ssh_online` VALUES (1,21,'2020-05-22 21:40:14','2020-05-22 21:41:16',0),(2,22,'2020-05-22 21:40:14',NULL,1),(3,33,'2020-05-22 21:40:14',NULL,1),(4,35,'2020-05-22 21:40:14',NULL,1),(5,37,'2020-05-22 21:40:14',NULL,1),(6,38,'2020-05-22 21:40:14',NULL,1),(7,40,'2020-05-22 21:40:14',NULL,1),(8,41,'2020-05-22 21:40:14',NULL,1),(9,42,'2020-05-22 21:40:14',NULL,1),(10,49,'2020-05-22 21:40:14',NULL,1),(11,50,'2020-05-22 21:40:14',NULL,1),(12,51,'2020-05-22 21:40:14',NULL,1),(13,53,'2020-05-22 21:40:14',NULL,1),(14,54,'2020-05-22 21:40:14',NULL,1),(15,25,'2020-05-22 21:41:16',NULL,1),(16,55,'2020-05-22 21:40:14',NULL,1),(17,30,'2020-05-22 21:41:16',NULL,1),(18,34,'2020-05-22 21:41:16',NULL,1),(19,43,'2020-05-22 21:41:16',NULL,1),(20,44,'2020-05-22 21:41:16',NULL,1),(21,46,'2020-05-22 21:41:16',NULL,1),(22,48,'2020-05-22 21:41:16',NULL,1),(23,57,'2020-05-22 21:41:16',NULL,1),(24,63,'2020-05-22 21:41:16',NULL,1),(25,80,'2020-05-22 21:41:16',NULL,1),(26,45,'2020-05-22 21:40:14',NULL,1),(27,56,'2020-05-22 21:40:14',NULL,1),(28,58,'2020-05-22 21:40:14',NULL,1),(29,59,'2020-05-22 21:40:14',NULL,1),(30,60,'2020-05-22 21:40:14',NULL,1),(31,61,'2020-05-22 21:40:14',NULL,1),(32,65,'2020-05-22 21:40:14',NULL,1),(33,66,'2020-05-22 21:40:14',NULL,1),(34,67,'2020-05-22 21:40:14',NULL,1),(35,85,'2020-05-22 21:40:14',NULL,1),(36,86,'2020-05-22 21:40:14',NULL,1),(37,2,'2020-05-22 21:41:16',NULL,1),(38,4,'2020-05-22 21:41:16',NULL,1),(39,8,'2020-05-22 21:41:16',NULL,1),(40,9,'2020-05-22 21:41:16',NULL,1),(41,10,'2020-05-22 21:41:16',NULL,1),(42,11,'2020-05-22 21:41:16',NULL,1),(43,12,'2020-05-22 21:41:16',NULL,1),(44,13,'2020-05-22 21:41:16',NULL,1),(45,14,'2020-05-22 21:41:16',NULL,1),(46,15,'2020-05-22 21:41:16',NULL,1),(47,16,'2020-05-22 21:41:16',NULL,1),(48,17,'2020-05-22 21:41:16',NULL,1),(49,18,'2020-05-22 21:41:16',NULL,1),(50,19,'2020-05-22 21:41:16',NULL,1),(51,20,'2020-05-22 21:41:16',NULL,1),(52,21,'2020-05-22 21:41:16',NULL,1),(53,22,'2020-05-22 21:41:16',NULL,1),(54,33,'2020-05-22 21:41:16',NULL,1);
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
INSERT INTO `mercadopago` VALUES ('966453177918365','hb86SFXeO8vtqgGT7orgddnZ24gZPBBg');
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noticias`
--

LOCK TABLES `noticias` WRITE;
/*!40000 ALTER TABLE `noticias` DISABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=289 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacoes`
--

LOCK TABLES `notificacoes` WRITE;
/*!40000 ALTER TABLE `notificacoes` DISABLE KEYS */;
INSERT INTO `notificacoes` VALUES (1,29,0,'2020-05-05 21:27:44','conta','n/d','Conta criada <small><b>adeilso3</b></small> Validade <small><i><b>999 Dias</b></i></small>  !','Conta Criada','nao','nao'),(2,29,0,'2020-05-05 21:41:14','conta','n/d','Conta criada <small><b>adeilsoca</b></small> Validade <small><i><b>999 Dias</b></i></small>  !','Conta Criada','nao','nao'),(3,29,0,'2020-05-05 22:50:36','conta','n/d','Conta criada <small><b>diegoml</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','nao','nao'),(4,29,0,'2020-05-06 00:52:30','conta','n/d','Conta criada <small><b>free</b></small> Validade <small><i><b>10 Dias</b></i></small>  !','Conta Criada','nao','nao'),(5,29,0,'2020-05-06 11:41:01','conta','n/d','Conta criada <small><b>teste1</b></small> Validade <small><i><b>2 Dias</b></i></small>  !','Conta Criada','nao','nao'),(13,51,0,'2020-05-09 02:32:52','conta','n/d','Conta criada <small><b>teste12</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','nao','nao'),(7,29,0,'2020-05-07 22:06:16','conta','n/d','Conta criada <small><b>fofis</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','nao','nao'),(8,29,0,'2020-05-08 12:47:11','conta','n/d','Conta criada <small><b>weslleymp</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','nao','nao'),(9,49,0,'2020-05-08 17:50:00','conta','n/d','Conta criada <small><b>roger</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(10,49,0,'2020-05-08 18:33:29','conta','n/d','Conta criada <small><b>Primo</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(11,49,0,'2020-05-08 18:56:38','conta','n/d','Você acabou de encerrar a Conta SSH <small><b>roger</b></small>!','Encerramento','sim','nao'),(14,49,0,'2020-05-09 11:29:34','conta','n/d','Conta criada <small><b>fer </b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(15,49,0,'2020-05-10 01:22:50','conta','n/d','Você acabou de Suspender a Conta SSH <small><b>fer </b></small>!','Encerramento','sim','nao'),(16,49,0,'2020-05-10 01:24:12','conta','n/d','Conta criada <small><b>rmadu </b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(17,49,0,'2020-05-11 10:08:38','conta','n/d','Você acabou de encerrar a Conta SSH <small><b>fer </b></small>!','Encerramento','sim','nao'),(18,29,0,'2020-05-11 12:52:28','conta','n/d','Conta criada <small><b>paulojaru</b></small> Validade <small><i><b>60 Dias</b></i></small>  !','Conta Criada','nao','nao'),(19,29,0,'2020-05-13 02:55:49','conta','n/d','Conta criada <small><b>adeilso1</b></small> Validade <small><i><b>999 Dias</b></i></small>  !','Conta Criada','nao','nao'),(20,59,0,'2020-05-14 12:42:46','conta','n/d','Conta criada <small><b>Thamys</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(21,49,0,'2020-05-14 13:43:43','conta','n/d','Conta criada <small><b>fer </b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(22,29,0,'2020-05-15 03:38:28','conta','n/d','A Pservers acabou de encerrar a Conta SSH <small><b>adeilso1</b></small>!','Encerramento','nao','nao'),(23,29,0,'2020-05-15 03:40:37','conta','n/d','Conta criada <small><b>adeilso1</b></small> Validade <small><i><b>999 Dias</b></i></small>  !','Conta Criada','nao','nao'),(24,59,0,'2020-05-15 11:21:26','conta','n/d','Conta criada <small><b>felipe1</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(25,59,0,'2020-05-15 11:23:06','conta','n/d','Conta criada <small><b>felipe2</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(26,59,0,'2020-05-15 12:55:56','conta','n/d','Conta criada <small><b>Joao1</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(27,59,0,'2020-05-16 13:27:58','outros','Admin','Servidor Modificado <small><b>br3.giize.com</b></small> Veja as alterações: <small><i><b><a href=\"../home.php?page=servidor/meuservidor\">Veja</a></b></i></small>  !','','sim','nao'),(28,59,0,'2020-05-19 13:14:37','conta','n/d','Você acabou de encerrar a Conta SSH <small><b>felipe2</b></small>!','Encerramento','sim','nao'),(29,29,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(30,34,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(31,35,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(32,36,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(33,37,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(34,38,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(35,39,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(36,40,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(37,41,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(38,42,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(39,43,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(40,44,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(41,45,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(42,46,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(43,47,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(44,48,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(45,49,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(46,51,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(47,52,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(48,53,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(49,54,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(50,55,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(51,56,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(52,57,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(53,58,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(54,59,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(55,60,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(56,61,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(57,62,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(58,63,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(59,64,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(60,65,0,'2020-05-19 13:46:25','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(61,29,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(62,34,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(63,35,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(64,36,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(65,37,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(66,38,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(67,39,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(68,40,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(69,41,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(70,42,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(71,43,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(72,44,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(73,45,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(74,46,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(75,47,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(76,48,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(77,49,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(78,51,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(79,52,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(80,53,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(81,54,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(82,55,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(83,56,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(84,57,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(85,58,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(86,59,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(87,60,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(88,61,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(89,62,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(90,63,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(91,64,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(92,65,0,'2020-05-19 13:47:51','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(93,29,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(94,34,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(95,35,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(96,36,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(97,37,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(98,38,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(99,39,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(100,40,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(101,41,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(102,42,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(103,43,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(104,44,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(105,45,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(106,46,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(107,47,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(108,48,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(109,49,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(110,51,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(111,52,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(112,53,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(113,54,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(114,55,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(115,56,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(116,57,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(117,58,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(118,59,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','sim','nao'),(119,60,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(120,61,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(121,62,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(122,63,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(123,64,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(124,65,0,'2020-05-19 13:48:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(125,59,0,'2020-05-19 14:09:46','conta','n/d','Conta criada <small><b>katy</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(126,59,0,'2020-05-20 07:13:55','conta','n/d','Conta criada <small><b>Karol</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(127,59,0,'2020-05-20 16:12:57','conta','n/d','Você acabou de encerrar a Conta SSH <small><b>Karol</b></small>!','Encerramento','sim','nao'),(128,59,0,'2020-05-20 16:13:32','conta','n/d','Conta criada <small><b>karol1</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(129,29,0,'2020-05-20 17:22:05','conta','n/d','Conta criada <small><b>talisjaru</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','nao','nao'),(130,29,0,'2020-05-21 00:51:12','conta','n/d','Conta criada <small><b>aaaaa</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(131,29,0,'2020-05-21 01:08:00','conta','n/d','Conta criada <small><b>ttttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(132,74,0,'2020-05-21 01:36:55','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(133,74,0,'2020-05-21 01:42:44','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(134,74,0,'2020-05-21 01:51:28','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(135,74,0,'2020-05-21 02:07:35','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(136,74,0,'2020-05-21 02:10:33','conta','n/d','Você acabou de Suspender a Conta SSH <small><b>tttt</b></small>!','Encerramento','sim','nao'),(137,74,0,'2020-05-21 02:16:23','conta','n/d','Você acabou de encerrar a Conta SSH <small><b>tttt</b></small>!','Encerramento','sim','nao'),(138,74,0,'2020-05-21 02:45:38','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(139,74,0,'2020-05-21 03:28:34','conta','n/d','Conta criada <small><b>TTTT</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(140,74,0,'2020-05-21 04:14:22','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(141,74,0,'2020-05-21 04:37:48','conta','n/d','Conta criada <small><b>ASADSDSF</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(142,74,0,'2020-05-21 12:14:44','conta','n/d','Conta criada <small><b>tttt</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(143,29,0,'2020-05-21 13:48:40','conta','n/d','A Pservers acabou de encerrar a Conta SSH <small><b>teste1</b></small>!','Encerramento','nao','nao'),(144,29,0,'2020-05-21 14:00:22','conta','n/d','Conta criada <small><b>teste1</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(145,59,0,'2020-05-21 17:14:39','conta','n/d','Conta criada <small><b>lele1</b></small> Validade <small><i><b>30 Dias</b></i></small>  !','Conta Criada','sim','nao'),(146,29,0,'2020-05-21 18:43:19','conta','n/d','Conta criada <small><b>teste1</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(147,74,0,'2020-05-21 21:20:56','outros','Admin','Servidor Modificado <small><b>ca1free.giize.com</b></small> Veja as alterações: <small><i><b><a href=\"../home.php?page=servidor/meuservidor\">Veja</a></b></i></small>  !','','sim','nao'),(148,74,0,'2020-05-21 21:22:28','conta','n/d','Conta criada <small><b>jaru1</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(149,74,0,'2020-05-22 00:28:26','conta','n/d','Conta criada <small><b>asdfgh</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(150,59,0,'2020-05-22 01:53:40','conta','n/d','Conta criada <small><b>102030</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(151,59,0,'2020-05-22 01:55:55','conta','n/d','Conta criada <small><b>1231020</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(152,59,0,'2020-05-22 02:04:31','conta','n/d','Conta criada <small><b>25547</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(153,59,0,'2020-05-22 02:13:31','conta','n/d','Conta criada <small><b>222222</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','sim','nao'),(154,74,0,'2020-05-22 02:16:15','conta','n/d','Conta criada <small><b>asde</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(155,29,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(156,34,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(157,35,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(158,36,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(159,37,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(160,38,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(161,39,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(162,40,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(163,41,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(164,42,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(165,43,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(166,44,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(167,45,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(168,46,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(169,47,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(170,48,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(171,49,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(172,51,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(173,52,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(174,53,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(175,54,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(176,55,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(177,56,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(178,57,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(179,58,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(180,59,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(181,60,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(182,61,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(183,62,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(184,63,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(185,64,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(186,65,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(187,66,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(188,67,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(189,68,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(190,69,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(191,70,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(192,71,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(193,72,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(194,73,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(195,74,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(196,75,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(197,76,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(198,77,0,'2020-05-22 11:40:36','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(199,29,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(200,34,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(201,35,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(202,36,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(203,37,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(204,38,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(205,39,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(206,40,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(207,41,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(208,42,0,'2020-05-22 11:41:37','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(209,43,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(210,44,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(211,45,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(212,46,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(213,47,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(214,48,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(215,49,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(216,51,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(217,52,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(218,53,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(219,54,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(220,55,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(221,56,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(222,57,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(223,58,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(224,59,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(225,60,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(226,61,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(227,62,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(228,63,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(229,64,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(230,65,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(231,66,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(232,67,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(233,68,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(234,69,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(235,70,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(236,71,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(237,72,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(238,73,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(239,74,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(240,75,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(241,76,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(242,77,0,'2020-05-22 11:41:38','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(243,29,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(244,34,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(245,35,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(246,36,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(247,37,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(248,38,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(249,39,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(250,40,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(251,41,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(252,42,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(253,43,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(254,44,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(255,45,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(256,46,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(257,47,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(258,48,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(259,49,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(260,51,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(261,52,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(262,53,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(263,54,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(264,55,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(265,56,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(266,57,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(267,58,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(268,59,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(269,60,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(270,61,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(271,62,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(272,63,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(273,64,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(274,65,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(275,66,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(276,67,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(277,68,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(278,69,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(279,70,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(280,71,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(281,72,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(282,73,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(283,74,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(284,75,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(285,76,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(286,77,0,'2020-05-22 11:45:53','outros','n/d','Foi adicionado um novo arquivo ao servidor <small><a href=\"../home.php?page=downloads/downloads\">Veja</a></small>!','Arquivos','nao','nao'),(287,74,0,'2020-05-22 12:22:52','conta','n/d','Conta criada <small><b>asert</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao'),(288,74,0,'2020-05-22 20:29:46','conta','n/d','Conta criada <small><b>asdfghj</b></small> Validade <small><i><b>1 Dias</b></i></small>  !','Conta Criada','nao','nao');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servidor`
--

LOCK TABLES `servidor` WRITE;
/*!40000 ALTER TABLE `servidor` DISABLE KEYS */;
INSERT INTO `servidor` VALUES (1,0,'Brasil-3','america',0,'br3.giize.com','www.vip-vps.tk','root','250385fi',22,0,0,NULL,'São Paulo','',10000,10000,'premium','nao'),(2,0,'CA1-FREE','america',0,'ca1free.giize.com','www.vip-vps.tk','root','250385fi',22,0,1,NULL,'São Paulo','',10000,10000,'premium','nao'),(3,0,'Brasil-1','america',0,'br1revenda.giize.com','www.vip-vps.tk','root','250385fi',22,0,0,NULL,'São Paulo','',10000,10000,'premium','nao');
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
INSERT INTO `sms` VALUES (1,0,31,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Fofis senha ssh: 044','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(2,0,31,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Fofis Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(3,0,34,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 00pv1p senha ssh: 0231','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(4,0,34,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Pauloroliz Senha->123456','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(5,0,35,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 01i senha ssh: 032','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(6,0,35,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Googo Senha->01115220670','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(7,0,36,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Bottino12 senha ssh: 0344','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(8,0,36,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Bottino12 Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(9,0,37,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Bottino senha ssh: 0231','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(10,0,37,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Bottino Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(11,0,38,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: teste senha ssh: 0211','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(12,0,38,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Lukas18 Senha->Kamuka1877@','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(13,0,39,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Yushuke.u0305@gmail.com  senha ssh: 0421','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(14,0,39,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Yushuke.u0305@gmail.com  Senha->alifher0305','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(15,0,40,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: bruno12 senha ssh: 01111','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(16,0,40,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> bruno Senha->bruno','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(17,0,41,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Leiciano senha ssh: 021433','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(18,0,41,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Leiciano Senha->leiciano','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(19,0,42,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 011v00 senha ssh: 022','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(20,0,42,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Vivoapp Senha->vivoapp','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(21,0,43,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 0i11i senha ssh: 0311','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(22,0,43,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Matusaly Senha->','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(23,0,44,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 0pip senha ssh: 01222','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(24,0,44,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Ramonvp Senha->','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(25,0,45,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 0pp0 senha ssh: 0213','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(26,0,45,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Matusalyvp Senha->','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(27,0,46,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: testa senha ssh: 0311','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(28,0,46,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> testa Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(29,0,47,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: dalila senha ssh: 0243','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(30,0,47,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> dalila Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(31,0,48,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 00 senha ssh: 0234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(32,0,48,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Jack62636 Senha->2131','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(33,0,52,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Bob10 senha ssh: 0422','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(34,0,52,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Bob10 Senha->alice10','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(35,0,53,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 000pv1 senha ssh: 0241','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(36,0,53,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Alfredolima Senha->gui0205','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(37,0,54,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Weder senha ssh: 034','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(38,0,54,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Weder Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(39,0,55,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Roberto senha ssh: 013144','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(40,0,55,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Roberto Senha->123456','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(41,0,56,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: maicon8837 senha ssh: 01333','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(42,0,56,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> maiconbutzke Senha->marcia8837','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(43,0,57,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: devkhallen senha ssh: 023','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(44,0,57,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> khallendev Senha->@DxD5850190','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(45,0,58,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Bob100 senha ssh: 012213','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(46,0,58,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Bob100 Senha->6103','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(47,1,18,'ServidorOFF','@SuperSSH - O Servidor BR-1 REVENDA IP->br1revenda.giize.com não respondeu a comunicacao SSH!!','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(48,1,114,'ServidorOFF','@SuperSSH - O Servidor BR-1 REVENDA IP->br1revenda.giize.com não respondeu a comunicacao SSH!!','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(49,1,18,'ServidorOFF','@SuperSSH - O Servidor BR-1 REVENDA IP->br1revenda.giize.com não respondeu a comunicacao SSH!!','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(50,1,114,'ServidorOFF','@SuperSSH - O Servidor BR-1 REVENDA IP->br1revenda.giize.com não respondeu a comunicacao SSH!!','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(51,0,60,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: tenpereira senha ssh: 01322','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(52,0,60,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> tenpereira Senha->mi23370','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(53,0,61,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: fabiosjp senha ssh: 032133','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(54,0,61,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> fabiosjp Senha->123456','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(55,0,62,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: jc22evangem senha ssh: 021421','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(56,0,62,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> jc22evangel Senha->24793121','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(57,0,63,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: WND senha ssh: 043444','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(58,0,63,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Lopes Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(59,0,64,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Thainara senha ssh: 04331','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(60,0,64,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Thainara Senha->0000','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(61,0,65,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: ca1free.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: jaquekaefer senha ssh: 02','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(62,0,65,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> jaquekaefer Senha->manas84','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(63,0,66,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: adeilsonsouza senha ssh: 03141','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(64,0,66,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> adeilsonsouza Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(65,0,67,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 011i senha ssh: 023','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(66,0,67,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Gramyvps Senha->123456','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(67,0,68,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Pamelafp senha ssh: 0211','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(68,0,68,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Pamelafp Senha->51572294','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(69,0,69,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Taboca1 senha ssh: 0122','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(70,0,69,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Taboca1 Senha->mm360257','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(71,0,70,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Cesar10 senha ssh: 01133','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(72,0,70,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Cesar10 Senha->1234','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(73,0,71,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Full senha ssh: 03','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(74,0,71,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Full Senha->full','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(75,0,72,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: vabner senha ssh: 023211','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(76,0,72,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> vabner Senha->0213va00','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(77,0,73,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Brasil senha ssh: 03441','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(78,0,73,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Brasil Senha->brasil','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(79,0,75,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: Prueba senha ssh: 043','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(80,0,75,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Prueba Senha->12345','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(81,0,76,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 011v senha ssh: 04121','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(82,0,76,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> Visual Senha->visual','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(83,0,77,'Dados SSH','Telegram @SuperSSH   - Dados SSH  ip proxy e ssh: br1revenda.giize.com Porta Proxy:80|8080|3128  Porta SSH: 443|22  login ssh: 0ipp0 senha ssh: 02','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando'),(84,0,77,'Seja Bem Vindo','Seja Bem vindo! @SuperSSH Dados do painel: IP->localhost Login-> 0ipp0 Senha->brasil','0000-00-00 00:00:00','0000-00-00 00:00:00','Aguardando');
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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (29,0,1,0,'geral','geral','Admin','1',NULL,'(69) 99226-1779','2020-02-13 09:37:28','vpn','nao',NULL,NULL,'03AD5C353',0,0,0,'','',''),(34,0,1,0,'Pauloroliz','123456','Paulo roliz','1',NULL,'123456','2020-05-06 14:49:41','vpn','nao','2020-05-21',NULL,'0vv1p',0,0,0,'','',''),(35,0,1,0,'Googo','01115220670','Googoghost','1',NULL,'01115220679','2020-05-06 14:53:00','vpn','nao','2020-05-21',NULL,'0ip1iv',0,0,0,'','',''),(36,0,1,0,'Bottino12','1234','Daniel','1',NULL,'1234','2020-05-06 14:58:02','vpn','nao','2020-05-21',NULL,'00vpii0',0,0,0,'','',''),(37,0,1,1,'Bottino','1234','Daniel bottino santos','2','Bottino','1234','2020-05-06 14:58:57','vpn','nao','2020-05-21',NULL,'0pv00p',0,0,0,'','',''),(38,0,1,0,'Lukas18','Kamuka1877@','LUCAS','1',NULL,'','2020-05-06 19:54:08','vpn','nao','2020-06-05',NULL,'01011',0,0,0,'','',''),(39,0,1,0,'Yushuke.u0305@gmail.com ','alifher0305','Mariana Vieira de Souza ','1',NULL,'69999141210','2020-05-06 22:25:59','vpn','nao','2020-06-05',NULL,'0p1vv',0,0,0,'','',''),(40,0,1,0,'bruno','bruno','Mário Gomes ','1',NULL,'Ttiddyofdj','2020-05-06 22:26:49','vpn','nao','2020-06-05',NULL,'01i1p',0,0,0,'','',''),(41,0,1,0,'Leiciano','leiciano','Leiciano','1',NULL,'77999747541','2020-05-07 06:57:52','vpn','nao','2020-06-06',NULL,'0p1pv',0,0,0,'','',''),(42,0,1,0,'Vivoapp','vivoapp','Vivoapp','1',NULL,'Vivoapp','2020-05-07 07:22:16','vpn','nao','2020-06-06',NULL,'0vii',0,0,0,'','',''),(43,0,1,0,'Matusaly','','Matu','1',NULL,'','2020-05-07 15:23:31','vpn','nao','2020-06-06',NULL,'0vv01',0,0,0,'','',''),(44,0,1,0,'Ramonvp','','Gramyvp','1',NULL,'','2020-05-07 15:24:21','vpn','nao','2020-06-06',NULL,'00iv',0,0,0,'','',''),(45,0,1,0,'Matusalyvp','','Lilianavp','1',NULL,'','2020-05-07 15:31:00','vpn','nao','2020-06-06',NULL,'01pipv0',0,0,0,'','',''),(46,0,1,0,'testa','1234','testa','1',NULL,'123456u89','2020-05-07 17:09:14','vpn','nao','2020-06-06',NULL,'00vii',0,0,0,'','',''),(47,0,1,0,'dalila','1234','dalila','1',NULL,'123456u89','2020-05-07 17:12:59','vpn','nao','2020-06-06',NULL,'0iv1ivi',0,0,0,'','',''),(48,0,1,0,'Jack62636','2131','Jackson','1',NULL,'Hewjshshs','2020-05-07 21:55:44','vpn','nao','2020-06-06',NULL,'00',0,0,0,'','',''),(49,0,1,1,'rogerio','r1234','Rogério Madureira','1','rmadu77@hotmail.com','(11) 99999-9999','2020-05-08 17:29:11','revenda','nao',NULL,NULL,'0CA2C3B12',0,0,0,'rmadu77@hotmail.com','',''),(51,0,1,0,'teste12','teste12','teste12','1',NULL,'(11) 99999-9999','2020-05-09 02:29:05','vpn','nao',NULL,NULL,'0ADDA4A21',0,0,0,'','',''),(52,0,1,0,'Bob10','alice10','Mario César Santos batista','1',NULL,'82576103','2020-05-09 14:23:58','vpn','nao','2020-06-08',NULL,'0ii',0,0,0,'','',''),(53,0,1,0,'Alfredolima','gui0205','Alfredo','2',NULL,'93992062730','2020-05-10 17:16:25','vpn','nao','2020-06-09',NULL,'01p1v',0,0,0,'','',''),(54,0,1,0,'Weder','1234','Weder lopes','1',NULL,'69993153550','2020-05-11 23:43:21','vpn','nao','2020-06-10',NULL,'010vvp',0,0,0,'','',''),(55,0,1,0,'Roberto','123456','Roberto Carlos','1',NULL,'62983068938','2020-05-12 09:55:43','vpn','nao','2020-06-11',NULL,'010vv',0,0,0,'','',''),(56,0,1,0,'maiconbutzke','marcia8837','Maicon Butzke','1',NULL,'','2020-05-13 17:22:23','vpn','nao','2020-06-12',NULL,'01p',0,0,0,'','',''),(57,0,1,0,'khallendev','@DxD5850190','Silmar Vargas','1',NULL,'(51) 99271-1475','2020-05-13 22:49:34','vpn','nao','2020-06-12',NULL,'01ipv1',0,0,0,'','',''),(58,0,1,0,'Bob100','6103','Mario César Santos batista','1',NULL,'6103','2020-05-14 11:08:15','vpn','nao','2020-06-13',NULL,'0vp101i',0,0,0,'','',''),(59,0,1,0,'lucas','l1234','Lucas','1',NULL,'(11) 99999-9999','2020-05-14 11:56:35','revenda','nao',NULL,NULL,'03B6AB1AD',0,0,0,'','',''),(60,0,1,0,'tenpereira','mi23370','Reginaldo Pereira','1',NULL,'62996816810','2020-05-15 13:34:54','vpn','nao','2020-06-14',NULL,'0v1p',0,0,0,'','',''),(61,0,1,1,'fabiosjp','123456','Fábio','1','teste@teste.com','41992244225','2020-05-16 01:13:04','vpn','nao','2020-06-15',NULL,'00i0i',0,0,0,'','',''),(62,0,1,0,'jc22evangel','24793121','Julio evangelista','1',NULL,'85996449844','2020-05-16 23:13:18','vpn','nao','2020-06-15',NULL,'0pp0pv',0,0,0,'','',''),(63,0,1,0,'Lopes','1234','Weder lopes','1',NULL,'69993153550','2020-05-17 21:51:03','vpn','nao','2020-06-16',NULL,'01vi1v',0,0,0,'','',''),(64,0,1,0,'Thainara','0000','Thainara','1',NULL,'69993153550','2020-05-17 21:55:00','vpn','nao','2020-06-16',NULL,'0i110',0,0,0,'','',''),(65,0,1,0,'jaquekaefer','manas84','jaqueline kaefer','1',NULL,'45999129747','2020-05-18 12:05:16','vpn','nao','2020-06-17',NULL,'0i1',0,0,0,'','',''),(66,0,1,0,'adeilsonsouza','1234','adeilson','1',NULL,'69992261779','2020-05-19 13:51:34','vpn','nao','2020-05-29',NULL,'0001pi0',0,0,0,'','',''),(67,0,1,0,'Gramyvps','123456','Gramyvps','1',NULL,'3854178100','2020-05-19 14:27:25','vpn','nao','2020-05-29',NULL,'01i1i0',0,0,0,'','',''),(68,0,1,0,'Pamelafp','51572294','Pamela Falcão da Penha','1',NULL,'73998513758','2020-05-19 16:01:35','vpn','nao','2020-05-29',NULL,'01ivi1i',0,0,0,'','',''),(69,0,1,0,'Taboca1','mm360257','Udson Coelho ','1',NULL,'','2020-05-19 18:00:29','vpn','nao','2020-05-29',NULL,'011v00',0,0,0,'','',''),(70,0,1,0,'Cesar10','1234','Mario César Santos batista','1',NULL,'1234','2020-05-19 20:16:27','vpn','nao','2020-05-29',NULL,'0v',0,0,0,'','',''),(71,0,1,0,'Full','full','Full','1',NULL,'69993153550','2020-05-20 23:27:52','vpn','nao','2020-05-30',NULL,'0010ipp',0,0,0,'','',''),(72,0,1,0,'vabner','0213va00','vabner','1',NULL,'41998488584','2020-05-20 23:28:58','vpn','nao','2020-05-30',NULL,'0vp1',0,0,0,'','',''),(73,0,1,0,'Brasil','brasil','Brasil','1',NULL,'69993153550','2020-05-20 23:29:05','vpn','nao','2020-05-30',NULL,'0piv',0,0,0,'','',''),(74,0,1,0,'jaru','1234','jaru','1',NULL,'(11) 99999-9999','2020-05-21 01:17:07','revenda','nao',NULL,NULL,'04AA4DC13',0,0,0,'','',''),(75,0,1,0,'Prueba','12345','Eduardo','1',NULL,'15534797','2020-05-21 20:21:04','vpn','nao','2020-05-31',NULL,'0i11v',0,0,0,'','',''),(76,0,1,0,'Visual','visual','Wagner ','1',NULL,'27996131304','2020-05-22 01:44:49','vpn','nao','2020-06-01',NULL,'00iiii',0,0,0,'','',''),(77,0,1,0,'0ipp0','brasil','Wagner Nogueira','1',NULL,'27996131304','2020-05-22 01:48:19','vpn','nao','2020-06-01',NULL,'0pvip',0,0,0,'','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_ssh`
--

LOCK TABLES `usuario_ssh` WRITE;
/*!40000 ALTER TABLE `usuario_ssh` DISABLE KEYS */;
INSERT INTO `usuario_ssh` VALUES (1,29,1,1,'adeilso3','1234','2023-01-29',NULL,0,1,1,'2020-05-22 14:52:04',1,'nao'),(2,29,2,1,'adeilsoca','1234','2023-01-29',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(3,29,1,1,'diegoml','1234','2020-06-04',NULL,0,1,1,'2020-05-22 20:17:11',1,'nao'),(4,29,2,2,'free','1234','2020-05-16','2020-05-17 00:00:00',0,10,0,'2020-05-22 21:41:16',1,'nao'),(8,34,2,2,'00pv1p','0231','2020-05-21','2020-05-22 00:00:00',0,1,0,'2020-05-22 21:41:16',1,'nao'),(9,35,2,2,'01i','032','2020-05-21','2020-05-22 00:00:00',0,1,0,'2020-05-22 21:41:16',1,'nao'),(10,36,2,2,'Bottino12','0344','2020-05-21','2020-05-22 00:00:00',0,1,0,'2020-05-22 21:41:16',1,'nao'),(11,37,2,2,'Bottino','0231','2020-05-21','2020-05-22 00:00:00',0,1,0,'2020-05-22 21:41:16',1,'nao'),(12,38,2,1,'teste','0211','2020-06-05',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(13,39,2,1,'Yushuke.u0305@gmail.com ','0421','2020-06-05',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(14,40,2,1,'bruno12','01111','2020-06-05',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(15,41,2,1,'Leiciano','021433','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(16,42,2,1,'011v00','022','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(17,43,2,1,'0i11i','0311','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(18,44,2,1,'0pip','01222','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(19,45,2,1,'0pp0','0213','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(20,46,2,1,'testa','0311','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(21,47,2,1,'dalila','0243','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(22,48,2,1,'00','0234','2020-06-06',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(24,29,1,1,'fofis','1234','2020-06-06',NULL,0,1,1,'2020-05-22 21:25:14',1,'nao'),(25,29,1,1,'weslleymp','1234w','2020-06-07',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(30,49,1,1,'Primo','12345','2020-06-08',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(33,52,2,1,'Bob10','0422','2020-06-08',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(34,49,1,1,'rmadu ','12345','2020-06-09',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(35,53,2,1,'000pv1','0241','2020-06-09',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(36,29,1,1,'paulojaru','1234','2020-07-10',NULL,0,1,1,'2020-05-22 19:54:16',1,'nao'),(37,54,2,1,'Weder','034','2020-06-10',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(38,55,2,1,'Roberto','013144','2020-06-11',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(40,56,2,1,'maicon8837','01333','2020-06-12',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(41,57,2,1,'devkhallen','023','2020-06-12',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(42,58,2,1,'Bob100','012213','2020-06-13',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(43,59,1,1,'Thamys','l1234','2020-06-13',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(44,49,1,2,'fer ','12345','2020-05-15','2020-05-16 00:00:00',0,1,0,'2020-05-22 21:41:16',1,'nao'),(45,29,3,1,'adeilso1','1234','2023-02-08',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(46,59,1,1,'felipe1','54321','2020-06-14',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(48,59,1,1,'Joao1','230587','2020-06-14',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(49,60,2,1,'tenpereira','01322','2020-06-14',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(50,61,2,1,'fabiosjp','032133','2020-06-15',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(51,62,2,1,'jc22evangem','021421','2020-06-15',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(53,63,2,1,'WND','043444','2020-06-16',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(54,64,2,1,'Thainara','04331','2020-06-16',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(55,65,2,1,'jaquekaefer','02','2020-06-17',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(56,66,3,1,'adeilsonsouza','03141','2020-05-29',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(57,59,1,1,'katy','katy123','2020-06-18',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(58,67,3,1,'011i','023','2020-05-29',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(59,68,3,1,'Pamelafp','0211','2020-05-29',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(60,69,3,1,'Taboca1','0122','2020-05-29',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(61,70,3,1,'Cesar10','01133','2020-05-29',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(63,59,1,1,'karol1','1908','2020-06-19',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(64,29,1,1,'talisjaru','1234','2020-06-19',NULL,0,1,1,'2020-05-22 21:02:11',1,'nao'),(65,71,3,1,'Full','03','2020-05-30',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(66,72,3,1,'vabner','023211','2020-05-30',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(67,73,3,1,'Brasil','03441','2020-05-30',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(80,59,1,1,'lele1','12345','2020-06-20',NULL,0,1,0,'2020-05-22 21:41:16',1,'nao'),(82,75,3,1,'Prueba','043','2020-05-31',NULL,0,1,1,'2020-05-22 21:23:12',1,'nao'),(85,76,3,1,'011v','04121','2020-06-01',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao'),(86,77,3,1,'0ipp0','02','2020-06-01',NULL,0,1,0,'2020-05-22 21:40:14',1,'nao');
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

-- Dump completed on 2020-05-22 21:42:18
