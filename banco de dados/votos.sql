-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Jul 01, 2013 as 02:02 PM
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
-- Estrutura da tabela `votos`
--

CREATE TABLE IF NOT EXISTS `votos` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `id_eleitor` mediumint(8) unsigned NOT NULL,
  `id_lei` smallint(5) unsigned NOT NULL,
  `mespub` datetime NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=14110 ;
