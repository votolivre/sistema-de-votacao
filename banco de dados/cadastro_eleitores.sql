-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Jul 01, 2013 as 02:00 PM
-- Versão do Servidor: 5.1.69
-- Versão do PHP: 5.3.2-1ubuntu4.19

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `votolivre`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cadastro_eleitores`
--

CREATE TABLE IF NOT EXISTS `cadastro_eleitores` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `mespub` datetime NOT NULL,
  `nome` varchar(150) COLLATE latin1_general_ci NOT NULL,
  `cpf` varchar(15) COLLATE latin1_general_ci NOT NULL,
  `sexo` char(1) COLLATE latin1_general_ci NOT NULL,
  `data_nascimento` date NOT NULL,
  `endereco` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `end_numero` varchar(6) COLLATE latin1_general_ci NOT NULL,
  `end_complemento` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `cep` varchar(9) COLLATE latin1_general_ci NOT NULL,
  `email` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `email_digest` varchar(32) COLLATE latin1_general_ci NOT NULL,
  `telefone` varchar(12) COLLATE latin1_general_ci NOT NULL,
  `senha` varchar(12) COLLATE latin1_general_ci NOT NULL,
  `titulo_eleitoral` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `zona` varchar(6) COLLATE latin1_general_ci NOT NULL,
  `secao` varchar(6) COLLATE latin1_general_ci NOT NULL,
  `codigo_habilitar` varchar(32) COLLATE latin1_general_ci NOT NULL,
  `habilitado` char(1) COLLATE latin1_general_ci NOT NULL,
  `newsletter` char(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=14059 ;
