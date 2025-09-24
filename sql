-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 23 sep. 2025 à 19:39
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `exercice1`
--

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login` varchar(100) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_compte_id` int(11) DEFAULT NULL,
  `user_mail` varchar(255) NOT NULL,
  `user_date_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_date_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `cle_etrangere` (`user_compte_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`user_id`, `user_login`, `user_password`, `user_compte_id`, `user_mail`, `user_date_new`, `user_date_login`) VALUES
(1, 'tawhmt', '$2y$10$HOk44O09UGvJTagQbNZMieyPAHOdxImFoBVWRgB6BU353N1.tL1mq', NULL, 'tawhmt@gmail.com', '2025-09-22 19:32:24', '2025-09-22 19:57:25'),
(2, 'imenham', '$2y$10$Bs/r5Ab1QaUGHbN8d0SRA.NfJpg2pDwXuSmijpsUb/hRb8Lt5aaj6', NULL, 'imenham@gmail.com', '2025-09-22 19:36:34', '2025-09-22 19:36:34');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
