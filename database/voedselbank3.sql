-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 21, 2023 at 11:53 AM
-- Server version: 5.7.36
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `voedselbank3`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `UpdateVoedselpakketStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateVoedselpakketStatus` (IN `p_id` INT, IN `p_status` VARCHAR(255))   BEGIN
    UPDATE voedselpakket
    SET status = p_status
    WHERE id = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `eetwens`
--

DROP TABLE IF EXISTS `eetwens`;
CREATE TABLE IF NOT EXISTS `eetwens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naam` varchar(255) NOT NULL,
  `omschrijving` varchar(255) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `eetwens`
--

INSERT INTO `eetwens` (`id`, `naam`, `omschrijving`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'GeenVarken', 'Geen varkensvlees', 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(2, 'Veganistisch', 'Geen zuivelproducten en vlees', 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(3, 'Vegetarisch', 'Geen vlees', 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(4, 'Omnivoor', 'Geen beperkingen', 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17');

-- --------------------------------------------------------

--
-- Table structure for table `eetwenspergezin`
--

DROP TABLE IF EXISTS `eetwenspergezin`;
CREATE TABLE IF NOT EXISTS `eetwenspergezin` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gezin_id` bigint(20) NOT NULL,
  `eetwens_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `eetwenspergezin_gezin_id_foreign` (`gezin_id`),
  KEY `eetwenspergezin_eetwens_id_foreign` (`eetwens_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `eetwenspergezin`
--

INSERT INTO `eetwenspergezin` (`id`, `gezin_id`, `eetwens_id`) VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 4),
(4, 4, 3),
(5, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `gezin`
--

DROP TABLE IF EXISTS `gezin`;
CREATE TABLE IF NOT EXISTS `gezin` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `naam` varchar(255) NOT NULL,
  `code` varchar(25) NOT NULL,
  `omschrijving` varchar(255) NOT NULL,
  `aantalvolwassenen` bigint(20) NOT NULL,
  `aantalkinderen` bigint(20) NOT NULL,
  `aantalbabys` bigint(20) NOT NULL,
  `totaalaantalpersonen` bigint(20) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gezin`
--

INSERT INTO `gezin` (`id`, `naam`, `code`, `omschrijving`, `aantalvolwassenen`, `aantalkinderen`, `aantalbabys`, `totaalaantalpersonen`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'ZevenhuizenGezin', 'G0001', 'Bijstandsgezin', 2, 2, 0, 4, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(2, 'BergkampGezin', 'G0002', 'Bijstandsgezin', 2, 1, 1, 4, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(3, 'HeuvelkampGezin', 'G0003', 'Bijstandsgezin', 2, 0, 0, 2, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(4, 'ScherderGezin', 'G0004', 'Bijstandsgezin', 1, 0, 2, 3, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(5, 'DeJongGezin', 'G0005', 'Bijstandsgezin', 1, 1, 0, 2, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(6, 'VanderBergGezin', 'G0006', 'AlleenGaande', 1, 0, 0, 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17');

-- --------------------------------------------------------

--
-- Table structure for table `persoon`
--

DROP TABLE IF EXISTS `persoon`;
CREATE TABLE IF NOT EXISTS `persoon` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gezin_id` bigint(20) DEFAULT NULL,
  `voornaam` varchar(255) NOT NULL,
  `tussenvoegsel` varchar(255) DEFAULT NULL,
  `achternaam` varchar(255) NOT NULL,
  `geboortedatum` date NOT NULL,
  `typepersoon` varchar(255) NOT NULL,
  `isvertegenwoordiger` tinyint(1) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `persoon_gezin_id_foreign` (`gezin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `persoon`
--

INSERT INTO `persoon` (`id`, `gezin_id`, `voornaam`, `tussenvoegsel`, `achternaam`, `geboortedatum`, `typepersoon`, `isvertegenwoordiger`, `is_active`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Hans', 'van', 'Leeuwen', '1958-02-12', 'Manager', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(2, NULL, 'Jan', 'van der', 'Sluijs', '1993-04-30', 'Medewerker', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(3, NULL, 'Herman', 'den', 'Duiker', '1989-08-30', 'Vrijwilliger', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(4, 1, 'Johan', 'van', 'Zevenhuizen', '1990-05-20', 'Klant', 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(5, 1, 'Sarah', 'den', 'Dolder', '1985-03-23', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(6, 1, 'Theo', 'van', 'Zevenhuizen', '2015-03-08', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(7, 1, 'Jantien', 'van', 'Zevenhuizen', '2016-09-10', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(8, 2, 'Arjan', '', 'Bergkamp', '1968-07-12', 'Klant', 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(9, 2, 'Janneke', '', 'Sanders', '1969-05-11', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(10, 2, 'Stein', '', 'Bergkamp', '2009-02-02', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(11, 2, 'Judith', '', 'Bergkamp', '2022-02-05', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(12, 3, 'Mazin', 'van', 'Vliet', '1968-08-18', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(13, 3, 'Selma', 'van de', 'Heuvel', '1965-09-05', 'Klant', 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(14, 4, 'Eva', '', 'Scherder', '2000-04-07', 'Klant', 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(15, 4, 'Felicia', '', 'Scherder', '2021-11-29', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(16, 4, 'Devin', '', 'Scherder', '2023-03-01', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(17, 5, 'Frieda', 'de', 'Jong', '1980-09-04', 'Klant', 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(18, 5, 'Simeon', 'de', 'Jong', '2018-05-23', 'Klant', 0, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17'),
(19, 6, 'Hanna', 'van der', 'Berg', '1999-09-09', 'Klant', 1, 1, '2023-06-21 08:04:17', '2023-06-21 08:04:17');

-- --------------------------------------------------------

--
-- Table structure for table `productpervoedselpakket`
--

DROP TABLE IF EXISTS `productpervoedselpakket`;
CREATE TABLE IF NOT EXISTS `productpervoedselpakket` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `voedselpakket_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `aantalproducteenheden` bigint(20) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productpervoedselpakket`
--

INSERT INTO `productpervoedselpakket` (`id`, `voedselpakket_id`, `product_id`, `aantalproducteenheden`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 7, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(2, 1, 8, 2, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(3, 1, 9, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(4, 2, 12, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(5, 2, 13, 2, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(6, 2, 14, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(7, 3, 3, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(8, 3, 4, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(9, 4, 20, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(10, 4, 19, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(11, 4, 21, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(12, 5, 24, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(13, 5, 25, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(14, 5, 26, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(15, 6, 28, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(16, 6, 29, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(17, 6, 27, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(18, 6, 26, 1, 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18');

-- --------------------------------------------------------

--
-- Table structure for table `voedselpakket`
--

DROP TABLE IF EXISTS `voedselpakket`;
CREATE TABLE IF NOT EXISTS `voedselpakket` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gezin_id` bigint(20) NOT NULL,
  `pakketnummer` bigint(20) NOT NULL,
  `datumsamengesteld` date NOT NULL,
  `datumuitgifte` date DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `voedselpakket_gezin_id_foreign` (`gezin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voedselpakket`
--

INSERT INTO `voedselpakket` (`id`, `gezin_id`, `pakketnummer`, `datumsamengesteld`, `datumuitgifte`, `status`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2023-04-06', '2023-04-07', 'Uitgereikt', 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(2, 1, 2, '2023-04-13', NULL, 'NietUitgereikt', 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(3, 1, 3, '2023-04-20', NULL, 'NietUitgereikt', 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(4, 2, 4, '2023-04-06', '2023-04-07', 'Uitgereikt', 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(5, 2, 5, '2023-04-13', '2023-04-14', 'Uitgereikt', 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(6, 2, 6, '2023-04-20', NULL, 'NietUitgereikt', 1, '2023-06-21 08:04:18', '2023-06-21 08:04:18'),
(7, 3, 1, '2023-04-06', '2023-04-07', 'Uitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(8, 3, 2, '2023-04-13', NULL, 'NietUitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(9, 3, 3, '2023-04-20', NULL, 'NietUitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(10, 4, 4, '2023-04-06', '2023-04-07', 'Uitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(11, 4, 5, '2023-04-13', '2023-04-14', 'Uitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(12, 4, 6, '2023-04-20', NULL, 'NietUitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(13, 5, 1, '2023-04-06', '2023-04-07', 'Uitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(14, 5, 2, '2023-04-13', NULL, 'NietUitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(15, 5, 3, '2023-04-20', NULL, 'NietUitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(16, 6, 4, '2023-04-06', '2023-04-07', 'Uitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(17, 6, 5, '2023-04-13', '2023-04-14', 'Uitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51'),
(18, 6, 6, '2023-04-20', NULL, 'NietUitgereikt', 1, '2023-06-21 11:37:51', '2023-06-21 11:37:51');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
