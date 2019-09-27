-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Set 08, 2017 as 06:31 
-- Versão do Servidor: 5.1.41
-- Versão do PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `ssh`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `acesso_servidor`
--

CREATE TABLE IF NOT EXISTS `acesso_servidor` (
  `id_acesso_servidor` int(10) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_mestre` int(11) NOT NULL DEFAULT '0',
  `id_servidor_mestre` int(11) NOT NULL DEFAULT '0',
  `qtd` int(10) NOT NULL DEFAULT '0',
  `validade` datetime NOT NULL,
  `demo` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_acesso_servidor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `acesso_servidor`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id_administrador` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(60) NOT NULL,
  `senha` varchar(60) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `accessKEY` varchar(100) DEFAULT NULL,
  `site` varchar(255) NOT NULL,
  PRIMARY KEY (`id_administrador`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `admin`
--

INSERT INTO `admin` (`id_administrador`, `login`, `senha`, `nome`, `email`, `accessKEY`, `site`) VALUES
(1, 'admin', 'admin', 'Administrador', 'admin@admin.com', NULL, 'meusite.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `anuncios`
--

CREATE TABLE IF NOT EXISTS `anuncios` (
  `anuncio1` text NOT NULL,
  `anuncio2` text NOT NULL,
  `anuncio3` text NOT NULL,
  `anuncio4` text NOT NULL,
  `anuncio5` text NOT NULL,
  `anuncio6` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `anuncios`
--

INSERT INTO `anuncios` (`anuncio1`, `anuncio2`, `anuncio3`, `anuncio4`, `anuncio5`, `anuncio6`) VALUES
('Insira o Código Adsense no Painel', 'Insira o Código Adsense no Painel', 'Insira o Código Adsense no Painel', 'Insira o Código Adsense no Painel', 'Insira o Código Adsense no Painel', 'Insira o Código Adsense no Painel');

-- --------------------------------------------------------

--
-- Estrutura da tabela `arquivo_download`
--

CREATE TABLE IF NOT EXISTS `arquivo_download` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `arquivo_download`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `chamados`
--

CREATE TABLE IF NOT EXISTS `chamados` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `chamados`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `configuracao`
--

CREATE TABLE IF NOT EXISTS `configuracao` (
  `id_configuracao` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) NOT NULL,
  `titulo_pagina` varchar(60) NOT NULL,
  PRIMARY KEY (`id_configuracao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `configuracao`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `fatura`
--

CREATE TABLE IF NOT EXISTS `fatura` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `fatura`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `fatura_clientes`
--

CREATE TABLE IF NOT EXISTS `fatura_clientes` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `fatura_clientes`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `fatura_comprovantes`
--

CREATE TABLE IF NOT EXISTS `fatura_comprovantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fatura_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `status` enum('aberto','fechado') NOT NULL DEFAULT 'aberto',
  `data` datetime NOT NULL,
  `formapagamento` enum('boleto','deptra') NOT NULL,
  `nota` text NOT NULL,
  `imagem` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `fatura_comprovantes`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `fatura_comprovantes_clientes`
--

CREATE TABLE IF NOT EXISTS `fatura_comprovantes_clientes` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `fatura_comprovantes_clientes`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `historico_login`
--

CREATE TABLE IF NOT EXISTS `historico_login` (
  `id_historico_login` int(10) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) NOT NULL,
  `data_login` datetime NOT NULL,
  `ip_login` varchar(100) NOT NULL,
  `navegador` varchar(100) NOT NULL,
  PRIMARY KEY (`id_historico_login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `historico_login`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `hist_usuario_ssh_online`
--

CREATE TABLE IF NOT EXISTS `hist_usuario_ssh_online` (
  `id_hist_usrSSH` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `hora_conexao` datetime NOT NULL,
  `hora_desconexao` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id_hist_usrSSH`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `hist_usuario_ssh_online`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `hist_usuario_ssh_online_free`
--

CREATE TABLE IF NOT EXISTS `hist_usuario_ssh_online_free` (
  `id_hist_usrSSH` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `hora_conexao` datetime NOT NULL,
  `hora_desconexao` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id_hist_usrSSH`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `hist_usuario_ssh_online_free`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `informativo`
--

CREATE TABLE IF NOT EXISTS `informativo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `informativo`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `mercadopago`
--

CREATE TABLE IF NOT EXISTS `mercadopago` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `CLIENT_SECRET` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `mercadopago`
--

INSERT INTO `mercadopago` (`CLIENT_ID`, `CLIENT_SECRET`) VALUES
('7981557107733328', 'MpCwg3eVrRsfYtMB99ptMF7hx2D2K2VV');

-- --------------------------------------------------------

--
-- Estrutura da tabela `noticias`
--

CREATE TABLE IF NOT EXISTS `noticias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` enum('ativo','desativado') NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `subtitulo` varchar(255) NOT NULL,
  `msg` text NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `noticias`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `notificacoes`
--

CREATE TABLE IF NOT EXISTS `notificacoes` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `notificacoes`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `ovpn`
--

CREATE TABLE IF NOT EXISTS `ovpn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servidor_id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `arquivo` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `ovpn`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `servidor`
--

CREATE TABLE IF NOT EXISTS `servidor` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `servidor`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `sms`
--

CREATE TABLE IF NOT EXISTS `sms` (
  `id_sms` int(11) NOT NULL AUTO_INCREMENT,
  `id_remetente` int(11) NOT NULL,
  `id_destinatario` int(11) NOT NULL,
  `assunto` varchar(100) NOT NULL,
  `mensagem` varchar(500) NOT NULL,
  `hora_resquisicao` datetime NOT NULL,
  `hora_envio` datetime NOT NULL,
  `status` enum('Aguardando','Enviado','Erro') NOT NULL DEFAULT 'Aguardando',
  PRIMARY KEY (`id_sms`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `sms`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `smtp`
--

CREATE TABLE IF NOT EXISTS `smtp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `servidor` varchar(255) NOT NULL,
  `porta` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `ssl_secure` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `smtp`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `smtp_usuarios`
--

CREATE TABLE IF NOT EXISTS `smtp_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ssl_secure` varchar(255) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `servidor` varchar(255) NOT NULL,
  `empresa` varchar(255) NOT NULL,
  `porta` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `smtp_usuarios`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `usuario`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_ssh`
--

CREATE TABLE IF NOT EXISTS `usuario_ssh` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `usuario_ssh`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_ssh_free`
--

CREATE TABLE IF NOT EXISTS `usuario_ssh_free` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `usuario_ssh_free`
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
