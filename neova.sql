-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 01, 2014 at 01:40 PM
-- Server version: 5.5.38-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `neova`
--
CREATE DATABASE IF NOT EXISTS `neova` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `neova`;

-- --------------------------------------------------------

--
-- Table structure for table `java_group`
--

DROP TABLE IF EXISTS `java_group`;
CREATE TABLE IF NOT EXISTS `java_group` (
  `groupName` varchar(50) NOT NULL,
  `groupDescription` varchar(50) NOT NULL,
  PRIMARY KEY (`groupName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `java_group`
--

INSERT INTO `java_group` (`groupName`, `groupDescription`) VALUES
('ADMIN', 'For Admin Users'),
('MODERATOR', 'For Users having Moderate access');

-- --------------------------------------------------------

--
-- Table structure for table `java_group_role`
--

DROP TABLE IF EXISTS `java_group_role`;
CREATE TABLE IF NOT EXISTS `java_group_role` (
  `groupName` varchar(50) NOT NULL,
  `roleName` varchar(50) NOT NULL,
  PRIMARY KEY (`groupName`,`roleName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `java_group_role`
--

INSERT INTO `java_group_role` (`groupName`, `roleName`) VALUES
('ADMIN', 'ROLE_ADMIN'),
('ADMIN', 'ROLE_MODERATOR'),
('MODERATOR', 'ROLE_MODERATOR');

-- --------------------------------------------------------

--
-- Table structure for table `java_role`
--

DROP TABLE IF EXISTS `java_role`;
CREATE TABLE IF NOT EXISTS `java_role` (
  `roleName` varchar(255) NOT NULL,
  `roleDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `java_role`
--

INSERT INTO `java_role` (`roleName`, `roleDescription`) VALUES
('ROLE_ADMIN', 'Role having admin access to resources'),
('ROLE_MODERATOR', 'Role having Moderate access to resources');

-- --------------------------------------------------------

--
-- Table structure for table `java_user`
--

DROP TABLE IF EXISTS `java_user`;
CREATE TABLE IF NOT EXISTS `java_user` (
  `userName` varchar(255) NOT NULL,
  `passWord` varchar(255) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `accountNonExpired` tinyint(1) NOT NULL DEFAULT '1',
  `accountNonLocked` tinyint(1) NOT NULL DEFAULT '1',
  `credentialsNonExpired` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`userName`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `java_user`
--

INSERT INTO `java_user` (`userName`, `passWord`, `firstName`, `lastName`, `enabled`, `accountNonExpired`, `accountNonLocked`, `credentialsNonExpired`, `email`) VALUES
('anwar', 'anwar', 'anwar', 'sahib', 1, 1, 1, 1, 'anwarsahib@gmail.com'),
('aryan', 'aryan', 'aryan', 'bagul', 1, 1, 1, 1, 'aryan@gmail.com'),
('dsds', 'MyP@ssw0rd', 'dsd', 'dsds', 0, 1, 0, 0, 'mahi'),
('fd', '12345^&*(asdfA', 'dfdf', 'fdfdfd', 0, 0, 0, 0, 'fdf@ffdf.cc'),
('maa', 'MyP@ssw0rd', 'dsd', 'dsds', 0, 1, 0, 0, 'bagulm123@gmail.com'),
('mahi', 'mahi', 'Ramdas', 'bagul', 1, 1, 1, 1, 'mahi@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `java_user_group`
--

DROP TABLE IF EXISTS `java_user_group`;
CREATE TABLE IF NOT EXISTS `java_user_group` (
  `userName` varchar(255) NOT NULL DEFAULT '',
  `groupName` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`userName`,`groupName`),
  KEY `java_user_group_ibfk_1` (`groupName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `java_user_group`
--

INSERT INTO `java_user_group` (`userName`, `groupName`) VALUES
('mahi', 'ADMIN'),
('anwar', 'MODERATOR'),
('aryan', 'MODERATOR'),
('dsds', 'MODERATOR'),
('fd', 'MODERATOR'),
('maa', 'MODERATOR'),
('mahi', 'MODERATOR');

-- --------------------------------------------------------

--
-- Table structure for table `user_tenant`
--

DROP TABLE IF EXISTS `user_tenant`;
CREATE TABLE IF NOT EXISTS `user_tenant` (
  `userName` varchar(50) NOT NULL,
  `tenantName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_tenant`
--

INSERT INTO `user_tenant` (`userName`, `tenantName`) VALUES
('mahi', 'java'),
('aryan', 'ms'),
('yogesh', 'java'),
('ganesh', 'ms');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `java_group_role`
--
ALTER TABLE `java_group_role`
  ADD CONSTRAINT `java_group_role_ibfk_1` FOREIGN KEY (`groupName`) REFERENCES `java_group` (`groupName`);

--
-- Constraints for table `java_user_group`
--
ALTER TABLE `java_user_group`
  ADD CONSTRAINT `java_user_group_ibfk_1` FOREIGN KEY (`groupName`) REFERENCES `java_group` (`groupName`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
