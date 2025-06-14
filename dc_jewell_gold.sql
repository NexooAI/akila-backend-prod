-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 12, 2025 at 02:18 PM
-- Server version: 10.6.19-MariaDB-cll-lve
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dc_jwl_gold`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminuser`
--

CREATE TABLE `adminuser` (
  `id` int(11) NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `Fname` varchar(50) NOT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `surename` varchar(50) DEFAULT NULL,
  `empid` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category` varchar(50) DEFAULT NULL,
  `createrId` int(11) DEFAULT NULL,
  `updaterId` int(11) DEFAULT NULL,
  `profilephoto` varchar(255) DEFAULT NULL,
  `roles` enum('super-admin','admin','employee') NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `role_id` int(11) NOT NULL,
  `descriptaion` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adminuser`
--

INSERT INTO `adminuser` (`id`, `mobile_number`, `Fname`, `lname`, `surename`, `empid`, `email`, `password`, `createdAt`, `updatedAt`, `category`, `createrId`, `updaterId`, `profilephoto`, `roles`, `status`, `role_id`, `descriptaion`) VALUES
(7, '1264738843', 'John', 'Doe', NULL, 'EMP12335', 'john.doe@example.do', '$2b$10$9vudq93mhuQXFGt6QLp0C.EE.pi8of5VPDf2I5TKZeiC3Lhrd5cMq', '2025-03-13 04:02:30', '2025-03-13 04:02:30', NULL, NULL, NULL, NULL, 'super-admin', 'active', 1, ''),
(6, '9003616461', 'John', 'Doe', NULL, 'EMP12345', 'john.doe@example.com', '$2b$10$MiszV2F46O3/ow7k8mj/MuQfTR9swh4ZfU4PD0BrXMIyYZrOfk3Yy', '2025-03-13 03:48:56', '2025-03-13 03:48:56', NULL, NULL, NULL, NULL, 'super-admin', 'active', 3, ''),
(8, '98928393', 'John', 'Doe', NULL, 'EMP12338', 'john.doe@example.dof', '$2b$10$aSV1Ie4h3K6dqCkBDZ8L0uuoKfzr4C8L0175eXINen0hlf3QmajyC', '2025-03-13 04:06:34', '2025-03-13 04:06:34', NULL, NULL, NULL, NULL, 'super-admin', 'active', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `branchid` varchar(50) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT 'India',
  `phone` varchar(20) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branchid`, `branch_name`, `address`, `city`, `state`, `country`, `phone`, `active`, `created_at`, `updated_at`) VALUES
(8, 'DCJ-1', 'Thrissur', 'Mission Quarters Rd ,Nr.Fathima Nagar Jn,. ', 'Thrissur', 'Kerala', 'India', '8086033999', 'Y', '2025-03-09 15:53:26', '2025-03-09 15:53:26');

-- --------------------------------------------------------

--
-- Table structure for table `chits`
--

CREATE TABLE `chits` (
  `id` int(10) UNSIGNED NOT NULL,
  `SchemeId` varchar(10) DEFAULT NULL,
  `AMOUNT` decimal(10,2) DEFAULT NULL,
  `NOINS` int(11) DEFAULT NULL,
  `TOTALMEMBERS` int(11) DEFAULT NULL,
  `REGNO` varchar(20) DEFAULT NULL,
  `ACTIVE` char(1) DEFAULT NULL,
  `METID` varchar(10) DEFAULT NULL,
  `GROUPCODE` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chits`
--

INSERT INTO `chits` (`id`, `SchemeId`, `AMOUNT`, `NOINS`, `TOTALMEMBERS`, `REGNO`, `ACTIVE`, `METID`, `GROUPCODE`) VALUES
(13, '18', 1000.00, 11, 1000, '002', 'Y', '002', '002'),
(12, '17', 1000.00, 11, 1000, '001', 'Y', '001', '001'),
(14, '18', 2000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(15, '17', 2000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(16, '18', 3000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(17, '17', 3000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(18, '17', 5000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(19, '18', 5000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(20, '18', 10000.00, 11, 9999, '0034', 'Y', '00345', '003456'),
(21, '17', 10000.00, 11, 9999, '0034', 'Y', '00345', '003456');

-- --------------------------------------------------------

--
-- Table structure for table `investments`
--

CREATE TABLE `investments` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `chitId` int(11) NOT NULL,
  `schemeId` int(11) NOT NULL,
  `accountName` varchar(255) NOT NULL,
  `accountNo` varchar(50) NOT NULL,
  `joiningDate` date DEFAULT NULL,
  `paymentStatus` varchar(50) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `dueDate` date DEFAULT NULL,
  `previousInvestmentId` int(11) DEFAULT NULL,
  `totalgoldweight` varchar(34) NOT NULL,
  `status` enum('ACTIVE','DEACTIVE','','') NOT NULL DEFAULT 'ACTIVE',
  `descripation` varchar(100) NOT NULL,
  `current_goldrate` decimal(10,0) NOT NULL,
  `current_silverrate` decimal(10,0) NOT NULL,
  `totalsilverweight` varchar(24) NOT NULL,
  `firstMonthPayment` varchar(10) NOT NULL,
  `associated_branch` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `investments`
--

INSERT INTO `investments` (`id`, `userId`, `chitId`, `schemeId`, `accountName`, `accountNo`, `joiningDate`, `paymentStatus`, `createdAt`, `updatedAt`, `start_date`, `end_date`, `total_paid`, `dueDate`, `previousInvestmentId`, `totalgoldweight`, `status`, `descripation`, `current_goldrate`, `current_silverrate`, `totalsilverweight`, `firstMonthPayment`, `associated_branch`) VALUES
(241, 379, 12, 17, 'Yiteef', '103', '2025-04-06', 'pending', '2025-04-06 10:16:19', '2025-04-06 10:16:19', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(242, 379, 12, 17, 'Yth', '104', '2025-04-09', 'pending', '2025-04-09 07:05:40', '2025-04-09 07:05:40', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(243, 379, 12, 17, 'Test', '105', '2025-04-09', 'pending', '2025-04-09 07:21:31', '2025-04-09 12:00:11', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(244, 189, 15, 17, 'Test4', '111', '2025-04-09', 'PAID', '2025-04-09 08:34:39', '2025-04-09 14:29:13', '2025-04-09', '2026-03-09', 0.00, '2025-05-09', NULL, '0', 'ACTIVE', '', 8050, 108, '0', '', 0),
(245, 3, 12, 17, 'Ajithkumar', '107', '2025-04-09', 'pending', '2025-04-09 08:38:47', '2025-04-09 08:38:47', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(247, 189, 15, 17, 'Test4', '111', '2025-04-09', 'PAID', '2025-04-09 12:48:39', '2025-04-09 14:37:13', '2025-04-09', '2026-03-09', 0.00, '2025-06-09', NULL, '0.62000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(250, 3, 15, 17, 'Etyy', '112', '2025-04-09', 'pending', '2025-04-09 13:57:07', '2025-04-09 13:57:07', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(252, 391, 21, 17, 'Test', '113', '2025-04-09', 'PAID', '2025-04-09 15:19:08', '2025-04-09 15:19:35', '2025-04-09', '2026-03-09', 10000.00, '2025-06-09', NULL, '1.24000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(253, 7, 12, 17, 'Jin Daniel', '114', '2025-04-10', 'PAID', '2025-04-10 06:22:37', '2025-04-10 06:23:28', '2025-04-10', '2026-03-10', 1000.00, '2025-06-10', NULL, '0.12000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(254, 7, 21, 17, 'Jin', '115', '2025-04-10', 'PAID', '2025-04-10 06:27:38', '2025-04-10 06:28:05', '2025-04-10', '2026-03-10', 10000.00, '2025-06-10', NULL, '1.24000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(255, 391, 12, 17, '123456789', '116', '2025-04-10', 'pending', '2025-04-10 10:44:38', '2025-04-10 10:44:38', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(256, 391, 12, 17, '123456789', '117', '2025-04-10', 'pending', '2025-04-10 10:46:05', '2025-04-10 10:46:05', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(257, 391, 12, 17, '123456789', '118', '2025-04-10', 'pending', '2025-04-10 10:47:19', '2025-04-10 10:47:19', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(258, 391, 12, 17, '123456789', '119', '2025-04-10', 'pending', '2025-04-10 10:50:20', '2025-04-10 10:50:20', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(259, 391, 12, 17, '123456789', '120', '2025-04-10', 'PAID', '2025-04-10 10:51:30', '2025-04-10 10:53:59', '2025-04-10', '2026-03-10', 1000.00, '2025-06-10', NULL, '0.12000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(260, 391, 12, 17, '123456789', '121', '2025-04-10', 'pending', '2025-04-10 10:56:05', '2025-04-10 10:56:05', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(261, 391, 12, 17, '123456789', '122', '2025-04-10', 'pending', '2025-04-10 10:59:21', '2025-04-10 10:59:21', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(262, 391, 12, 17, '123456789', '123', '2025-04-10', 'pending', '2025-04-10 11:01:22', '2025-04-10 11:01:22', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(263, 7, 18, 17, 'Suganya', '124', '2025-04-10', 'PAID', '2025-04-10 11:02:26', '2025-04-10 11:03:03', '2025-04-10', '2026-03-10', 5000.00, '2025-05-10', NULL, '0.62000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(264, 391, 12, 17, '123456789', '125', '2025-04-10', 'pending', '2025-04-10 11:04:31', '2025-04-10 11:04:31', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(265, 391, 12, 17, '123456789', '126', '2025-04-10', 'pending', '2025-04-10 11:04:58', '2025-04-10 11:04:58', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(266, 391, 12, 17, '123456789', '127', '2025-04-10', 'pending', '2025-04-10 11:16:32', '2025-04-10 11:16:32', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(267, 379, 21, 17, 'My first scheme', '128', '2025-04-11', 'PAID', '2025-04-11 10:42:20', '2025-04-11 10:44:18', '2025-04-11', '2026-03-11', 10000.00, '2025-05-11', NULL, '1.24000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(268, 379, 21, 17, 'Y', '129', '2025-04-11', 'pending', '2025-04-11 10:43:41', '2025-04-11 10:43:41', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(269, 379, 21, 17, 'My new scheme', '130', '2025-04-11', 'PAID', '2025-04-11 11:11:32', '2025-04-11 11:11:58', '2025-04-11', '2026-03-11', 10000.00, '2025-05-11', NULL, '1.24000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(270, 391, 12, 17, '123456789', '131', '2025-04-11', 'pending', '2025-04-11 11:17:42', '2025-04-11 11:17:42', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(271, 391, 12, 17, '123456789', '132', '2025-04-11', 'pending', '2025-04-11 11:20:55', '2025-04-11 11:20:55', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(272, 391, 12, 17, '123456789', '133', '2025-04-11', 'PAID', '2025-04-11 11:23:17', '2025-04-11 11:24:44', '2025-04-11', '2026-03-11', 1000.00, '2025-05-11', NULL, '0.12000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(273, 391, 15, 17, '123456789', '134', '2025-04-11', 'pending', '2025-04-11 11:27:27', '2025-04-11 11:27:27', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(274, 391, 15, 17, '123456789', '135', '2025-04-11', 'pending', '2025-04-11 11:32:22', '2025-04-11 11:32:22', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(275, 391, 15, 17, '123456789', '136', '2025-04-11', 'pending', '2025-04-11 11:40:04', '2025-04-11 11:40:04', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(276, 391, 15, 17, '123445556679', '137', '2025-04-11', 'pending', '2025-04-11 11:47:30', '2025-04-11 11:47:30', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(277, 391, 15, 17, '22342234332', '138', '2025-04-11', 'pending', '2025-04-11 11:54:04', '2025-04-11 11:54:04', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(278, 391, 15, 17, '1234556789', '139', '2025-04-11', 'pending', '2025-04-11 11:56:35', '2025-04-11 11:56:35', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(279, 391, 12, 17, '123567890', '140', '2025-04-11', 'pending', '2025-04-11 12:01:00', '2025-04-11 12:01:00', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(280, 391, 15, 17, '123456789', '141', '2025-04-11', 'PAID', '2025-04-11 12:04:19', '2025-04-11 12:06:14', '2025-04-11', '2026-03-11', 1000.00, '2025-05-11', NULL, '0.12000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(281, 391, 12, 17, '12345788', '142', '2025-04-11', 'pending', '2025-04-11 12:27:30', '2025-04-11 12:27:30', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(282, 391, 12, 17, '12345788', '143', '2025-04-11', 'pending', '2025-04-11 12:27:46', '2025-04-11 12:27:46', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(283, 391, 15, 17, '13456689', '144', '2025-04-11', 'PAID', '2025-04-11 12:31:51', '2025-04-11 12:46:17', '2025-04-11', '2026-03-11', 1000.00, '2025-05-11', NULL, '0.12000', 'ACTIVE', '', 8050, 108, '0', 'PAID', 0),
(284, 391, 15, 17, '213445679', '145', '2025-04-11', 'pending', '2025-04-11 12:54:17', '2025-04-11 12:54:17', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0),
(285, 391, 12, 17, '12345789', '146', '2025-04-11', 'pending', '2025-04-11 12:57:21', '2025-04-11 12:57:21', '0000-00-00', '0000-00-00', 0.00, NULL, NULL, '0', 'ACTIVE', '', 0, 0, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `kyc`
--

CREATE TABLE `kyc` (
  `id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `doorno` varchar(50) NOT NULL,
  `street` varchar(100) NOT NULL,
  `area` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `dob` date NOT NULL,
  `addressproof` varchar(255) NOT NULL,
  `enternumber` varchar(50) NOT NULL,
  `nominee_name` varchar(100) NOT NULL,
  `nominee_relationship` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kyc`
--

INSERT INTO `kyc` (`id`, `user_id`, `doorno`, `street`, `area`, `city`, `district`, `state`, `country`, `pincode`, `dob`, `addressproof`, `enternumber`, `nominee_name`, `nominee_relationship`, `created_at`, `updated_at`) VALUES
(13, 192, '', 'EDATHARA HOUSE', 'P.O.VARADIUM', 'AVANUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(14, 193, '', 'VAZHAPPULLY HOUSE', 'THRITHALLUR', 'CHETTIKKAD', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(15, 194, '', 'KALARIKKAL HOUSE', 'K.K.LANE', 'POONKUNNAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(16, 195, '', 'PALUPPADATH HOUSE', 'KIZHUPPILLIKKARA.P.O.', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(17, 196, '', 'ORUVINAPURATH H', 'KOTTANAD', 'NAGALASSERY', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(18, 197, '', 'KARUMUDI HOUSE', 'GREEN GARDEN', 'NADATHARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(19, 198, '', 'GURU VIHAR', 'CHIYARAM', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(20, 199, '', 'NALAKATH H', ' ', ' ', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(21, 200, '', 'KANJIRATHINGAL H', 'E P LANE', 'EAST FORT', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(22, 201, '', 'VALAPPATTUKARAN', 'E P LANE', 'EAST FORT', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(23, 202, '', 'KIZHAKKEVEETTIL H', 'KONDOTTY PO', 'KONDOTTY', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(24, 203, '', 'PLOT NO-206', 'GATE 2ND', 'HILL GARDENS', 'KUTTANELLUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(25, 204, '', 'VALAPPATTUKARAN H', 'K.R.PURAM', 'BANGALORE', ' ', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(26, 205, '', 'MINA GARDEN', 'VALLIKUNNAM', 'ALAPPUZHA', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(27, 206, '', 'PZHUNKARAN H', 'MATHRUKA STREET', 'NETTISSERY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(28, 207, '', 'KAIPPADA H', 'PUTHANPALLY', 'GURUVAYUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(29, 208, '', 'KANDAMPULLY H', 'PARANNUR', 'PARANNUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(30, 209, '', 'NIRAVATHUKANDATHIL', 'PADIYOOR', ' ', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(31, 210, '', 'VELLANIKKARAN', 'NELLIKUNNU', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(32, 211, '', '39/535,', 'THRIVEVI', 'ERNAKULAM', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(33, 212, '', 'THANISSERY H', 'CHEMMANTHITTA', 'PAZHUNNANA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(34, 213, '', 'CHEERAMBAN H', 'PURANATTUKKARA', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(35, 214, '', 'KODAPPANAPARAMBIL', 'CHIRAMANANGAD', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(36, 215, '', 'P.M.APARTMENT', 'FLAT NO.6', 'THURUTH', 'KAIPARAMBU', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(37, 216, '', 'ANTHIKKAT H', 'THAIKKAD', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(38, 217, '', 'POTTANATT HOUSE', 'DWARAKA', 'MARATHAKKARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(39, 218, '', 'KOLLARA HOUSE', 'KURA ROAD', 'KALATHODE,OLLUKKARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(40, 219, '', 'KAINOOR P O', 'NEAR KAINOOR SIVA TEMPLE', 'PUTHOOR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(41, 220, '', 'ADIMURI H', 'PALARIVATTOM', 'ERNAKULAM', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(42, 221, '', 'LAKSHMINI', 'PURANATTUKARA', ' ', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(43, 222, '', 'CHEERAMPARAMBIL', 'P.O.THANNEERCODE', 'CHALISSERY', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(44, 223, '', 'RAM NIVAS', 'WEST NADA', 'GURUVAYUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(45, 224, '', 'P[ARAKKAL H', 'AYYANTHOLE', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(46, 225, '', 'MAPRANATHUKARAN', 'VARAKKARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(47, 226, '', 'PULICKAL H', 'POONJAR', 'KOTTAYAM', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(48, 227, '', 'THOOMPANA H', 'VATTEKKADU', 'KOLLENGODE', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(49, 228, '', 'CHANGARANGATH', 'PURANATTUKARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(50, 229, '', 'KADAYAMKALAM', 'KOTTOPADAM', 'PATTITHARA', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(51, 230, '', 'THEKKETHIL HOUSE', 'NATTIANCHIRA', 'P.O.CHELAKODE,VENGANELLUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(52, 231, '', 'MANGHAT', 'KANATTUKULANGARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(53, 232, '', 'THACHIL H', 'MYLIPPADAM', 'EAST FORT', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(54, 233, '', 'PALLIPURATHUPARAMBIL.', 'MATTATHUR', 'AVITTAPPILLY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(55, 234, '', 'PANTHIRAYITHADATHIL', 'KATTILAPOOVAM', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(56, 235, '', 'CHIRIYANKANDATH H', 'POTTOR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(57, 236, '', 'VALIYAPARAMBIL H', 'PURANATTUKARA', 'THRUSSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(58, 237, '', 'RINS', 'MOOCHIKKAL', 'RANDATHANI', 'MALAPPURAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(59, 238, '', 'CHIRIYANKANDATH', 'VELUR P O', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(60, 239, '', 'ERUPPASSERY HOUSE', 'P.O.KANDANASSERY', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(61, 240, '', 'MULEKKATTIL H', 'NEDUPUZHA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(62, 241, '', 'CHEMMARATH HOUSE', 'P.O.POTTA', 'CHALAKUDY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(63, 242, '', 'VITHAYATHIL HOUSE', 'ST.JOSEPH STREET', 'KURIACHIRA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(64, 243, '', 'VADAKKEPARAMBIL HOUSE', 'MULANGU PO', 'THOTTIPPAL', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(65, 244, '', 'KADHALIKATTIL H', 'PO AYYAPPANKKAVU', 'MULAYAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(66, 245, '', 'THEKKUMPURAM', 'PALLASSENA', 'PALAKKAD', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(67, 246, '', 'THELAKKATTU H', 'VADACODE P O', 'KANGARAPADY', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(68, 247, '', 'CHOWALLOOR', 'NR.MATHA SCHOOL', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(69, 248, '', 'PALLATHU HOUSE', 'VELLARKULAM', 'P.O.PAZHAYANNUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(70, 249, '', 'KOTTIYATIL H', 'KANNAMKULANGARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(71, 250, '', 'AMBADATH H', 'KADUPPASSERY', 'IRINJALAKKUDA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(72, 251, '', 'FLAT NO:2A', 'PARK CITY', 'INDRANEELAM', 'AYYANTHOLE', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(73, 252, '', 'SERINITY', 'WESTHILL', 'CALICUT', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(74, 253, '', 'VELUTHEDATHU H', 'THALORE', 'VADAKKUMURI', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(75, 254, '', 'KALANI H', 'ARIMPUR', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(76, 255, '', 'SWAPNA BHAVAN', 'VENGANELLUR', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(77, 256, '', 'PURAKKAL H', 'MATHILAKAM', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(78, 257, '', 'PAZHAMUKKIL H', 'PURANATTUKARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(79, 258, '', 'KANNAMPARAMBIL H', 'PUZHAKKAL', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(80, 259, '', 'CHULLIPARAMBIL H', 'P.O.ENGANDIYUR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(81, 260, '', 'THIYYATHU PARAMBIL', 'P.O.PONJANAM', 'KATTOOR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(82, 261, '', 'MANAPPURAM HOUSE', 'P.O.POOTHOLE', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(83, 262, '', 'EDATHIRITHIKKARAN HOUSE', 'KURIACHIRA', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(84, 263, '', 'SWAPNA BHAVAN', 'VENGANELLUR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(85, 264, '', 'PULIYATHUPARAMBIL HOUSE', ' ', 'NELLAYI PO', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(86, 265, '', 'KARTHIKAPPALLY PEEDIKAYIL', 'MATTAM', 'THATTARAMBALAM', 'ALAPPUZHA', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(87, 266, '', 'KARTHIKAPALLY PEEDIKAYIL', 'MATTAM', 'THATTARAMBALAM', 'ALAPPUZHA', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(88, 267, '', 'KUMARAPURAM TEMPLE QUARTERS', 'ERAVIMANGALAM', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(89, 268, '', 'PARAPARAMBIL HOUSE', 'P.O.ANCHERY', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(90, 269, '', 'SREENIVAS', 'SANKARANKULANGARA', 'POONKUNNAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(91, 270, '', 'MANKEDATH HOUSE', 'CHEMMANTHATTA', 'CHIRANELLUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(92, 271, '', 'P.O.THAIKKAD', 'GURUVAYUR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(93, 272, '', 'THALAKOTTUKARAN', 'VASANTH VIHAR', 'PATTIKKAD', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(94, 273, '', '704,FORTUNA A WING', 'THEWALK', 'HIRANANDANI', 'THANE', 'MAHARASHTA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(95, 274, '', 'ATTUPARAMBATH', 'CIDBI', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(96, 275, '', 'DEVA RITHAM', 'KOTTILIL LANE', 'KANNATTUKKARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(97, 276, '', 'MOONEPPILLY H', 'NR,SNDP JUNCTION', 'ANGAMALY', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(98, 277, '', 'KUZHIKATHIMALIL H', ' ', 'THODUPUZHA', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(99, 278, '', 'PAZHAYATTIL H', ' ', 'THUMBOOR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(100, 279, '', 'KATTISSERY H', 'POONKUNNAM', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(101, 280, '', 'NEDUPARAMBIL (H)', 'THRISSUR', 'PO PANANGAD', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(102, 281, '', 'PARAMBATH (H)', 'THRISSUR', 'KARNIYARKODE (PO)', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(103, 282, '', 'THOPPIL VADAKAN', 'PALLIPURAM', ' ', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', 'PAN AIKPV6882H', 'PAN AIKPV6882H', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(104, 283, '', ' ', ' ', ' ', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(105, 284, '', 'VADAKKEN HOUSE', ' ', 'CHETTUPUZHA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(106, 285, '', 'EDAKALATHUR U', 'MUKKATTUKARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(107, 286, '', 'THEKKEKARA HOUSE', 'KUTTAPUZHA', ' ', 'THIRUVALLA', 'KERALA', 'INDIA', '', '0000-00-00', '', '465299743202', '465299743202', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(108, 287, '', 'HOME SERVANT', ' ', ' ', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(109, 288, '', '542,VS ROAD 7 CROSS', 'K.R.MOHALLA', ' ', 'MYSORE', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(110, 289, '', 'MULANGATTUPARAMBIL HOUSE', 'P.O.CHENTRAPPINNI', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(111, 290, '', '53/1484, ROYAL STREET', 'KOLOPARAMBU', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(112, 291, '', 'H NO-D 115,', 'PARAVATTANI', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(113, 292, '', 'ARACKAL HOUSE', 'KINFRA PARK', 'P.O.KORATTY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(114, 293, '', 'THAKKILAKADAN HOUSE', ' ', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(115, 294, '', 'INCHAMUDH HOUSE', 'PANAYAMPADAM', 'THALORE', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(116, 295, '', 'KOCHERY HOUSE', 'PULLUR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(117, 296, '', 'KIZHAKKE KALARIYIL', 'URALLOOR', 'P.O.KOYILANDY', 'KOZHIKODE', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(118, 297, '', 'SONIYA BHAVAN', 'P.O.PERUMBAIKADU', ' ', 'KOTTAYAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(119, 298, '', 'KULHUKALLINGAL', 'P.O.VELLARAKKAD', 'ERUMAPETTY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(120, 299, '', 'KARENGAL HOUSE', 'P.O.CHIRAMANANGAD', 'PANNITHADAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(121, 300, '', 'KOOTTUNGAL HOUSE', 'P.O.MANGAD', 'VETTIKADAVU', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(122, 301, '', 'ANNIE SADANAM', 'KANNIMAI', 'PALAKKAD', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(123, 302, '', 'RADHA BHAVAN', 'P.O.PARAVUR', ' ', 'KOLLAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(124, 303, '', 'MANAPPURAM HOUSE', 'P.O.POOTHOLE', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(125, 304, '', 'CHERUMULANGATTU', 'THAYYIL HOUSE', 'P.O.CHULOOR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(126, 305, '', 'CHEMBANKANDAM', 'PUTHUR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(127, 306, '', 'CHAKKALAKKAL HOUSE', 'P.O.ALAGAPPANAGAR', 'VENDORE', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(128, 307, '', 'VELUTHOTH H', 'PAMBOOR', 'KUTTOOR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(129, 308, '', 'NALANDA', '1/39,NIZAM LAYOUT', 'KODAGU', 'KARNATAKA', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(130, 309, '', 'MALIAKKAL ANCHERY H', 'MANNUTHY P O', 'THRISSUR', ' ', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(131, 310, '', 'KATTILAN HOUSE', 'P.O.MATHILAKAM', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(132, 311, '', 'MELETHIL HOUSE', 'WADAKKENCHERY', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(133, 312, '', 'PALLAVEETTIL H', 'KANNAMKULANGARA', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(134, 313, '', 'PALLAVEETTIL H', 'KANNAMKULANGARA', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(135, 314, '', 'KOZHIKAKADAN', ' ', 'KADAKARA', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(136, 315, '', 'THENGAMUCHI (H)', 'KOOTTALA', 'KARIPPAKUNNU', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(137, 316, '', 'KALLIPARAMBIL,MATHUPPULLI', 'CHAZHIYATTIRI', 'THIRUMITTACODE', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(138, 317, '', 'PULICHARAM VEETIL HOUSE', 'CHEMANNOR', 'CHOWALLURPADI', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(139, 318, '', 'THARAYIL H', 'OLLUKKARA P O', 'KALATHODE', 'KURA', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(140, 319, '', 'NARATTIL H', 'PULLUR', 'IRINJALAKKUDA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(141, 320, '', 'KOTTAYIL HOUSE', 'KUNNAMKULAM', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(142, 321, '', 'PRK VILLA', 'ENTHAN PATHA', 'KANIMANGALAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(143, 322, '', 'ARIYAKKODE', 'NSS COLLAGE', 'NENMMARA', 'PALAKKAD', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(144, 323, '', 'VAZHAKKALA', 'COCHIN', 'ERNAKULAM', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(145, 324, '', 'EYYANI THOTTUNGAL', 'KOZHIKUNNU', 'P.O.M.G.KAVU', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(146, 325, '', 'CHERIKKATTIL H', ' ', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(147, 326, '', 'EDIYAKUNNEL HOUSE', 'P.O.PADUVA', 'MATTAKARA', 'KOTTAYAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(148, 327, '', ' ', ' ', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(149, 328, '', 'KODDOKI HOUSE', 'PALAKKAL', 'PALLISSERY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(150, 329, '', 'EDASSERY HOUSE', 'CHERANELLUR', ' ', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(151, 330, '', 'MANAKKALATH', 'VELUR P O', 'VELLATTANJUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(152, 331, '', 'CHEMBRAYOOR H', 'ENKKAD P O', 'MANKARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(153, 332, '', '003,A BLOCK,GROUND FLOOR', 'AVANI AMULYA APTS', 'BANGALORE', 'KARNATAKA', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(154, 333, '', 'WYNN GATE APTMT', 'BELATHUR', 'BANGALORE', ' ', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(155, 334, '', 'AMPURETH H', 'SUBIN VILLA', 'PALLICKAL EAST', 'THEKKEKKARA,MAVELIKKARA', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(156, 335, '', 'AMBALATH VEETTIL', 'CHOONDAL', 'KUNNAMKULAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(157, 336, '', 'PARUTHIKATTU HOUSE', 'THOZHUPADAM', 'CHELAKKARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(158, 337, '', 'MULAYAMKODATH HOUSE', 'ALOOR', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(159, 338, '', 'MANGALATH HOUSE', 'P.O.NEDUMBASSERY', 'ALUVA', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(160, 339, '', 'KADAVATH H', 'MANITHARA', 'AVANOOR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(161, 340, '', 'KAIPPUNCHERY KUDIYIL', 'CHERAYA', 'PALAKKAD', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(162, 341, '', 'PADINJAREVEETIL H', 'THIRUMALABHAGOM', 'ALAPPUZHA', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(163, 342, '', 'ALAPPADAN H', 'MANAKODY', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(164, 343, '', 'FLAT NO.1B', 'AYYANTHOLE', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(165, 344, '', 'FLAT B2, RUGMANI TEMPLE PARK BLDG', 'PATTURAIKKAL', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(166, 345, '', 'THATTIL HOUSE', 'P.O.OLLUKKARA', 'KALATHODE', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(167, 346, '', 'PULIKOTTIL H', 'CHITTILAPPILLY', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(168, 347, '', 'VATTEKUNNAM', 'EDAPALLY PO', ' ', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(169, 348, '', 'ANATTI', 'OLAKKENGAL H', 'P.O.KURIACHIRA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(170, 349, '', 'PULLIKUNNATH H', 'MUNDATHIKODE', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(171, 350, '', 'PANDIYATH HOUSE', 'MUNDUR P O', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(172, 351, '', 'PLACKATTU H', 'MANAKADA', 'ADOOR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(173, 352, '', 'HOME SERVANT', ' ', ' ', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(174, 353, '', 'MANNATH HOUSE', 'KOZHUKULLY', 'NADATHARA', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(175, 354, '', 'HOUSE NO.167, SECTOR -17', 'OLD FARIDABAD', ' ', 'HARYANA', 'HARYANA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(176, 355, '', 'PERUTTU HOUSE', 'AKG NAGAR', 'POONKUNNAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(177, 356, '', 'ARAVASSERY HOUSE', 'THAMPANKADAVU.P.O.', 'THALIKULAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(178, 357, '', 'KORAPPATH LANE', 'ROUND NORTH', ' ', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(179, 358, '', 'KOMBAN H', 'KATTOOR P O', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(180, 359, '', '5B,DAFFODILS APTS', 'PARAKKOTT LANE', 'PATTURAIKAL', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(181, 360, '', 'CHELLARI H', 'THANIPPADAM', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(182, 361, '', '79 2ND STREET', 'LINGRAJPURAM', 'BANGALORE', ' ', 'KARNATAKA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(183, 362, '', 'VELAYUDHAN BHAVAN', 'P.O.RUBY NAGAR', 'CHANGANASSERY', 'KOTTAYAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(184, 363, '', 'KANNATH HOUSE', 'NR.VILLAGE OFFICE', 'P.O.CHIYYARAM', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(185, 364, '', 'KANOONATH HOUSE', 'NJELLUR', 'KALLUR', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(186, 365, '', 'ALUMKAL HOUSE', 'PERUMPADAPPU', 'PALLURUTHY', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(187, 366, '', 'ARACKAL HOUSE', 'PERUMPADAPPU', 'PALLURUTHY', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(188, 367, '', 'EDATHARA HOUSE', 'AYYANTHOLE', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(189, 368, '', 'KANJIRAPARAMABIL', 'KUTTUR P O', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(190, 369, '', 'SANYU', 'AYURVEDHA PANCHAKARMA CENTRE', 'KOORKKANCHERY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(191, 370, '', 'CHIRAYATH H', 'THRISSUR', ' ', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(192, 371, '', 'KIZHAKKEBHAGAM', 'PUTHIYAKAVU', 'THRIPUNITHURA', 'ERNAKULAM', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(193, 372, '', 'KALATHIL CHAKKATH', 'MULLURKKARA', 'THRISSUR', ' ', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(194, 373, '', 'CHERUVATHOOR H', ' ', 'PAVARATTY', 'THRISSUR', 'KERALA', 'INDIA', '', '0000-00-00', '', ' ', ' ', '', '2025-03-01 15:35:52', '2025-03-01 15:35:52'),
(199, 381, '636, swarnalashmi ', 'Ram nagar ', 'Chennai', 'Chennai', 'Chennai', 'Tamil Nadu', 'India', '600093', '1992-03-21', 'aadhar', '987687658787', 'Nith', 'Wife', '2025-03-18 20:26:13', '2025-03-18 20:26:13'),
(200, 387, '205/64A', 'Main Bazar ', 'Udangudi ', 'Thiruchendur ', 'Tuticorin ', 'Tamil Nadu', 'India', '628203', '1995-01-03', 'pan', 'EVYPS2362L', 'Sudha', 'Wife', '2025-03-22 14:21:10', '2025-03-22 14:21:10'),
(203, 379, '534', 'Ramnagar ', 'Velachery ', 'Velachery ', 'Chennai ', 'Tamil Nadu', 'India', '600031', '2007-04-01', 'aadhar', '128467978645', 'Nithya', 'spouse', '2025-04-01 11:14:36', '2025-04-01 11:14:36'),
(204, 3, '22', 'South Street ', 'Kalavasal', 'Madurai', 'Madurai ', 'Tamil Nadu', 'India', '625016', '1997-03-05', 'aadhar', '703092951730', 'Aravinth', 'brother', '2025-04-02 17:07:28', '2025-04-02 17:07:28'),
(205, 384, '4/474', 'GNG NAHAR', 'Vedapatti', 'Dindigul ', 'Dindigul', 'Tamil Nadu', 'India', '624003', '2000-11-25', 'aadhar', '939785418082', 'Amutha', 'mother', '2025-04-09 09:13:30', '2025-04-09 09:13:30'),
(206, 391, 'Tesy', 'Test', 'Test', 'Test', 'Test', 'Kerala', 'India', '605421', '2007-04-03', 'aadhar', '980056324588', 'Test', 'father', '2025-04-09 12:21:17', '2025-04-09 12:21:17'),
(207, 7, '100', '100', 'Erode', 'Erode', 'Erode', 'Rajasthan', 'India', '638009', '2007-04-07', 'aadhar', '123556689966', 'Jin', 'other', '2025-04-10 06:21:56', '2025-04-10 06:21:56');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `discount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `title`, `subtitle`, `start_date`, `end_date`, `image_url`, `status`, `created_at`, `updated_at`, `discount`) VALUES
(8, 'Offers 1', 'Offers 1', '2025-03-10', '2026-12-29', '/uploads/offers/1741608748412-slider1.png', 'active', '2025-03-09 20:57:02', '2025-03-09 20:57:02', 0.00),
(9, 'Offers 2', 'Offers 2', '2025-03-10', '2026-12-31', '/uploads/offers/1741608778862-slider2.png', 'active', '2025-03-09 21:09:06', '2025-03-09 21:09:06', 0.00),
(10, 'Offers 3', 'Offers 3', '2025-03-10', '2026-12-31', '/uploads/offers/1741608811051-slider3.png', 'active', '2025-03-10 12:13:31', '2025-03-10 12:13:31', 0.00),
(11, 'Offers 4', 'Offers 4', '2025-03-10', '2026-12-31', '/uploads/offers/1741608889862-slider4.png', 'active', '2025-03-10 12:14:49', '2025-03-10 12:14:49', 0.00),
(12, 'test', 'testdate', '0000-00-00', '0000-00-00', '/uploads/default.jpg', 'active', '2025-03-10 19:08:46', '2025-03-10 19:08:46', 88.00),
(13, 'datetest', 'trwt', '2025-03-04', '2025-03-14', '/uploads/default.jpg', 'active', '2025-03-10 19:18:11', '2025-03-10 19:18:11', 55.00),
(14, 'string', 'string', '2025-03-25', '2025-03-31', '/uploads/default.jpg', 'active', '2025-03-10 19:19:54', '2025-03-10 19:19:54', 0.00),
(15, 'string', 'string', '2025-03-12', '2025-03-30', '/uploads/default.jpg', 'active', '2025-03-10 19:23:54', '2025-03-10 19:23:54', 0.00),
(16, '77', '77', '2025-03-11', '2025-03-14', '/uploads/default.jpg', 'active', '2025-03-10 19:28:28', '2025-03-10 19:28:28', 77.00),
(17, '66', '66', '2025-03-11', '2025-03-17', '/uploads/default.jpg', 'active', '2025-03-10 19:30:11', '2025-03-10 19:30:11', 66.00),
(18, '66', '66', '2025-03-11', '2025-03-25', '/uploads/default.jpg', 'active', '2025-03-10 19:37:41', '2025-03-10 19:37:41', 66.00),
(19, '11', '11', '2025-03-11', '2025-03-12', '/uploads/default.jpg', 'active', '2025-03-11 18:22:50', '2025-03-11 18:22:50', 11.00),
(20, '8888', '8888', '0000-00-00', '0000-00-00', '/uploads/default.jpg', 'active', '2025-03-11 18:59:52', '2025-03-11 18:59:52', 88.00),
(21, 'yyy', 'yyy', '2025-03-12', '2025-03-31', '/uploads/offers/1741719976760-logo_sm.png', 'active', '2025-03-11 19:01:36', '2025-03-11 19:01:36', 7.00);

-- --------------------------------------------------------

--
-- Table structure for table `otp_verification`
--

CREATE TABLE `otp_verification` (
  `id` int(11) NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `attempts` int(11) NOT NULL DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL,
  `is_used` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otp_verification`
--

INSERT INTO `otp_verification` (`id`, `mobile_number`, `otp`, `expires_at`, `created_at`, `attempts`, `locked_until`, `is_used`) VALUES
(280, '9976157984', '7400', '2025-03-19 10:16:02', '2025-03-19 10:06:02', 0, NULL, 0),
(279, '9976157984', '1817', '2025-03-19 10:13:42', '2025-03-19 10:03:42', 0, NULL, 0),
(278, '9585141535', '6948', '2025-03-19 09:58:05', '2025-03-19 09:48:05', 0, NULL, 0),
(277, '9585141535', '2756', '2025-03-19 09:47:11', '2025-03-19 09:37:11', 0, NULL, 0),
(276, '9585141535', '2650', '2025-03-19 09:45:14', '2025-03-19 09:35:14', 0, NULL, 0),
(275, '9585141535', '2998', '2025-03-19 09:44:49', '2025-03-19 09:34:49', 0, NULL, 0),
(274, '9585141535', '3447', '2025-03-19 09:44:20', '2025-03-19 09:34:20', 0, NULL, 0),
(273, '9585141535', '4746', '2025-03-19 09:44:20', '2025-03-19 09:34:20', 0, NULL, 0),
(272, '9585141525', '5856', '2025-03-19 09:32:13', '2025-03-19 09:22:13', 0, NULL, 0),
(271, '9976157984', '3226', '2025-03-19 09:32:12', '2025-03-19 09:22:12', 0, NULL, 0),
(270, '9788033234', '1791', '2025-03-19 09:09:16', '2025-03-19 08:59:16', 0, NULL, 0),
(269, '9585141535', '4549', '2025-03-19 09:04:29', '2025-03-19 08:54:29', 0, NULL, 0),
(268, '', '9832', '2025-03-19 09:04:18', '2025-03-19 08:54:18', 0, NULL, 0),
(267, '9585141535', '3297', '2025-03-19 09:00:00', '2025-03-19 08:50:00', 0, NULL, 0),
(266, '9585141535', '5520', '2025-03-19 08:54:46', '2025-03-19 08:44:46', 0, NULL, 0),
(265, '6381279295', '1955', '2025-03-19 08:29:24', '2025-03-19 08:19:24', 0, NULL, 0),
(264, '9788033234', '4325', '2025-03-19 08:25:04', '2025-03-19 08:15:04', 0, NULL, 0),
(263, '9788033234', '2230', '2025-03-19 07:48:05', '2025-03-19 07:38:05', 0, NULL, 0),
(262, '9840319606', '9161', '2025-03-19 07:43:03', '2025-03-19 07:33:03', 0, NULL, 0),
(261, '9788033234', '8009', '2025-03-19 07:40:00', '2025-03-19 07:30:00', 0, NULL, 0),
(260, '', '8265', '2025-03-19 07:39:53', '2025-03-19 07:29:53', 0, NULL, 0),
(259, '', '4471', '2025-03-19 07:39:47', '2025-03-19 07:29:47', 0, NULL, 0),
(258, '9788033234', '9823', '2025-03-19 06:55:28', '2025-03-19 06:45:28', 0, NULL, 0),
(257, '6385333161', '7280', '2025-03-19 05:16:19', '2025-03-19 05:06:19', 0, NULL, 0),
(256, '9788033234', '9138', '2025-03-19 04:43:27', '2025-03-19 04:33:27', 0, NULL, 0),
(28, '9840319606', '8375', '2025-02-28 04:01:24', '2025-02-28 03:51:24', 0, NULL, 0),
(29, '9788033234', '9372', '2025-02-28 04:01:38', '2025-02-28 03:51:38', 0, NULL, 0),
(30, '9788033234', '8093', '2025-02-28 04:17:41', '2025-02-28 04:07:41', 0, NULL, 0),
(31, '9788033234', '3095', '2025-02-28 04:28:02', '2025-02-28 04:18:02', 0, NULL, 0),
(32, '9840319606', '5704', '2025-02-28 04:28:10', '2025-02-28 04:18:10', 0, NULL, 0),
(33, '9840319606', '5756', '2025-02-28 04:28:36', '2025-02-28 04:18:36', 0, NULL, 0),
(34, '9840319606', '7201', '2025-02-28 04:29:56', '2025-02-28 04:19:56', 0, NULL, 0),
(35, '9840319606', '1351', '2025-02-28 05:35:33', '2025-02-28 05:25:33', 0, NULL, 0),
(36, '9840319606', '3953', '2025-02-28 05:39:32', '2025-02-28 05:29:32', 0, NULL, 0),
(37, '9840319606', '3899', '2025-02-28 05:39:47', '2025-02-28 05:29:47', 0, NULL, 0),
(38, '9840319606', '7235', '2025-02-28 05:39:48', '2025-02-28 05:29:48', 0, NULL, 0),
(39, '9840319606', '3637', '2025-02-28 05:40:53', '2025-02-28 05:30:53', 0, NULL, 0),
(40, '9840319606', '2518', '2025-02-28 05:46:51', '2025-02-28 05:36:51', 0, NULL, 0),
(41, '9840319606', '9452', '2025-02-28 05:47:27', '2025-02-28 05:37:27', 0, NULL, 0),
(42, '9840319606', '8593', '2025-02-28 05:47:49', '2025-02-28 05:37:49', 0, NULL, 0),
(43, '9840319606', '5531', '2025-02-28 05:48:22', '2025-02-28 05:38:22', 0, NULL, 0),
(44, '9788033234', '5555', '2025-02-28 05:56:27', '2025-02-28 05:46:27', 0, NULL, 0),
(45, '9840319606', '5555', '2025-02-28 06:05:28', '2025-02-28 05:55:28', 0, NULL, 0),
(46, '9840319606', '5555', '2025-02-28 06:09:39', '2025-02-28 05:59:39', 0, NULL, 0),
(47, '9840319606', '5555', '2025-02-28 06:20:19', '2025-02-28 06:10:19', 0, NULL, 0),
(48, '9840319606', '5555', '2025-02-28 06:22:48', '2025-02-28 06:12:48', 0, NULL, 0),
(49, '9585141535', '5555', '2025-02-28 06:22:49', '2025-02-28 06:12:49', 0, NULL, 0),
(50, '9585141535', '5555', '2025-02-28 06:23:37', '2025-02-28 06:13:37', 0, NULL, 0),
(51, '9788033234', '5555', '2025-02-28 06:26:07', '2025-02-28 06:16:07', 0, NULL, 0),
(52, '9585141535', '5555', '2025-02-28 06:48:37', '2025-02-28 06:38:37', 0, NULL, 0),
(53, '9788033234', '5555', '2025-02-28 06:57:56', '2025-02-28 06:47:56', 0, NULL, 0),
(54, '9840319606', '5555', '2025-02-28 07:03:26', '2025-02-28 06:53:26', 0, NULL, 0),
(55, '9840319606', '5555', '2025-02-28 07:06:27', '2025-02-28 06:56:27', 0, NULL, 0),
(56, '9840319606', '5555', '2025-02-28 07:11:47', '2025-02-28 07:01:47', 0, NULL, 0),
(57, '9585141535', '5555', '2025-02-28 07:26:09', '2025-02-28 07:16:09', 0, NULL, 0),
(58, '9585141535', '5555', '2025-02-28 07:28:17', '2025-02-28 07:18:17', 0, NULL, 0),
(59, '9840319606', '5555', '2025-02-28 07:28:43', '2025-02-28 07:18:43', 0, NULL, 0),
(60, '9585141535', '5555', '2025-02-28 07:31:53', '2025-02-28 07:21:53', 0, NULL, 0),
(61, '9585141535', '5555', '2025-02-28 07:33:30', '2025-02-28 07:23:30', 0, NULL, 0),
(62, '9585141535', '5555', '2025-02-28 07:35:08', '2025-02-28 07:25:08', 0, NULL, 0),
(63, '9788033234', '5555', '2025-02-28 07:44:22', '2025-02-28 07:34:22', 0, NULL, 0),
(64, '9645462847', '5555', '2025-02-28 11:16:07', '2025-02-28 11:06:07', 0, NULL, 0),
(65, '9061802999', '5555', '2025-02-28 11:17:47', '2025-02-28 11:07:47', 0, NULL, 0),
(66, '9645462844', '5555', '2025-02-28 11:19:11', '2025-02-28 11:09:11', 0, NULL, 0),
(67, '9061802999', '5555', '2025-02-28 11:19:26', '2025-02-28 11:09:26', 0, NULL, 0),
(68, '9645462844', '5555', '2025-02-28 11:20:22', '2025-02-28 11:10:22', 0, NULL, 0),
(69, '9585141535', '5555', '2025-02-28 11:40:13', '2025-02-28 11:30:13', 0, NULL, 0),
(70, '9585141535', '5555', '2025-02-28 13:22:04', '2025-02-28 13:12:04', 0, NULL, 0),
(71, '9585141535', '5555', '2025-02-28 13:23:58', '2025-02-28 13:13:58', 0, NULL, 0),
(72, '9585141535', '5555', '2025-02-28 13:35:15', '2025-02-28 13:25:15', 0, NULL, 0),
(73, '9585141535', '5555', '2025-02-28 16:09:20', '2025-02-28 15:59:20', 0, NULL, 0),
(74, '9585141535', '5555', '2025-02-28 16:09:26', '2025-02-28 15:59:26', 0, NULL, 0),
(75, '9840319606', '5555', '2025-02-28 16:43:13', '2025-02-28 16:33:13', 0, NULL, 0),
(76, '9003616461', '5555', '2025-02-28 17:18:38', '2025-02-28 17:08:38', 0, NULL, 0),
(77, '9003616461', '5555', '2025-02-28 17:18:38', '2025-02-28 17:08:38', 0, NULL, 0),
(78, '9003616461', '5555', '2025-02-28 17:19:54', '2025-02-28 17:09:54', 0, NULL, 0),
(79, '9003616461', '5555', '2025-02-28 17:20:07', '2025-02-28 17:10:07', 0, NULL, 0),
(80, '9003616461', '5555', '2025-02-28 17:20:14', '2025-02-28 17:10:14', 0, NULL, 0),
(81, '6504992804', '5555', '2025-02-28 18:41:33', '2025-02-28 18:31:33', 0, NULL, 0),
(82, '1446043833', '5555', '2025-02-28 18:42:46', '2025-02-28 18:32:46', 0, NULL, 0),
(83, '9840319606', '5555', '2025-03-01 05:44:50', '2025-03-01 05:34:50', 0, NULL, 0),
(84, '9788033234', '5555', '2025-03-01 05:50:30', '2025-03-01 05:40:30', 0, NULL, 0),
(85, '9585141535', '5555', '2025-03-01 06:50:54', '2025-03-01 06:40:54', 0, NULL, 0),
(86, '9585141535', '5555', '2025-03-01 06:51:06', '2025-03-01 06:41:06', 0, NULL, 0),
(87, '8667382195', '5555', '2025-03-01 07:31:16', '2025-03-01 07:21:16', 0, NULL, 0),
(88, '9150280795', '5555', '2025-03-01 07:54:44', '2025-03-01 07:44:44', 0, NULL, 0),
(89, '9150280795', '5555', '2025-03-01 07:55:16', '2025-03-01 07:45:16', 0, NULL, 0),
(90, '9150280795', '5555', '2025-03-01 07:56:44', '2025-03-01 07:46:44', 0, NULL, 0),
(91, '9585141535', '5555', '2025-03-01 08:48:44', '2025-03-01 08:38:44', 0, NULL, 0),
(92, '9585141535', '5555', '2025-03-01 09:30:01', '2025-03-01 09:20:01', 0, NULL, 0),
(93, '9789330082', '5555', '2025-03-01 12:29:30', '2025-03-01 12:19:30', 0, NULL, 0),
(94, '9789330082', '5555', '2025-03-01 12:30:15', '2025-03-01 12:20:15', 0, NULL, 0),
(95, '6976832696', '5555', '2025-03-01 15:14:49', '2025-03-01 15:04:49', 0, NULL, 0),
(96, '6504992804', '5555', '2025-03-01 15:35:50', '2025-03-01 15:25:50', 0, NULL, 0),
(97, '2383310630', '5555', '2025-03-01 15:38:02', '2025-03-01 15:28:02', 0, NULL, 0),
(98, '9585141535', '5555', '2025-03-01 23:18:08', '2025-03-01 23:08:08', 0, NULL, 0),
(99, '9585141535', '5555', '2025-03-01 23:18:31', '2025-03-01 23:08:31', 0, NULL, 0),
(100, '9788033234', '5555', '2025-03-02 08:56:58', '2025-03-02 08:46:58', 0, NULL, 0),
(101, '9788033234', '5555', '2025-03-02 09:05:41', '2025-03-02 08:55:41', 0, NULL, 0),
(102, '9788033234', '5555', '2025-03-02 10:06:46', '2025-03-02 09:56:46', 0, NULL, 0),
(103, '9788033234', '5555', '2025-03-02 10:48:00', '2025-03-02 10:38:00', 0, NULL, 0),
(104, '9788033234', '5555', '2025-03-02 10:50:12', '2025-03-02 10:40:12', 0, NULL, 0),
(105, '9788033234', '5555', '2025-03-02 10:56:04', '2025-03-02 10:46:04', 0, NULL, 0),
(106, '9788033234', '5555', '2025-03-02 10:59:07', '2025-03-02 10:49:07', 0, NULL, 0),
(107, '9788033234', '5555', '2025-03-02 11:02:36', '2025-03-02 10:52:36', 0, NULL, 0),
(108, '9788033234', '5555', '2025-03-02 11:28:26', '2025-03-02 11:18:26', 0, NULL, 0),
(109, '9788033234', '5555', '2025-03-02 11:46:38', '2025-03-02 11:36:38', 0, NULL, 0),
(110, '1446043833', '5555', '2025-03-02 11:50:50', '2025-03-02 11:40:50', 0, NULL, 0),
(111, '9788033234', '5555', '2025-03-02 12:11:00', '2025-03-02 12:01:00', 0, NULL, 0),
(112, '9788033234', '5555', '2025-03-02 12:13:12', '2025-03-02 12:03:12', 0, NULL, 0),
(113, '9788033234', '5555', '2025-03-02 12:28:52', '2025-03-02 12:18:52', 0, NULL, 0),
(114, '9788033234', '5555', '2025-03-02 12:32:55', '2025-03-02 12:22:55', 0, NULL, 0),
(115, '9788033234', '5555', '2025-03-02 14:16:05', '2025-03-02 14:06:05', 0, NULL, 0),
(116, '9585141535', '5555', '2025-03-02 14:38:47', '2025-03-02 14:28:47', 0, NULL, 0),
(117, '9585141535', '5555', '2025-03-02 14:39:06', '2025-03-02 14:29:06', 0, NULL, 0),
(118, '', '5555', '2025-03-02 16:31:41', '2025-03-02 16:21:41', 0, NULL, 0),
(119, '9585141535', '7177', '2025-03-03 11:02:21', '2025-03-03 10:52:21', 0, NULL, 0),
(120, '', '2190', '2025-03-03 11:44:41', '2025-03-03 11:34:41', 0, NULL, 0),
(121, '', '4728', '2025-03-03 11:44:49', '2025-03-03 11:34:49', 0, NULL, 0),
(122, '6369089584', '8015', '2025-03-03 11:45:30', '2025-03-03 11:35:30', 0, NULL, 0),
(123, '6369089584', '4472', '2025-03-03 11:46:43', '2025-03-03 11:36:43', 0, NULL, 0),
(124, '', '3058', '2025-03-03 12:31:38', '2025-03-03 12:21:38', 0, NULL, 0),
(125, '', '9110', '2025-03-03 12:31:51', '2025-03-03 12:21:51', 0, NULL, 0),
(126, '9840319606', '3487', '2025-03-03 12:32:01', '2025-03-03 12:22:01', 0, NULL, 0),
(127, '9840319606', '9245', '2025-03-03 12:32:08', '2025-03-03 12:22:08', 0, NULL, 0),
(128, '9840319606', '3478', '2025-03-03 12:32:39', '2025-03-03 12:22:39', 0, NULL, 0),
(129, '9840319606', '2932', '2025-03-03 12:43:02', '2025-03-03 12:33:02', 0, NULL, 0),
(130, '9840319606', '9722', '2025-03-03 14:57:17', '2025-03-03 14:47:17', 0, NULL, 0),
(131, '', '1316', '2025-03-03 15:16:46', '2025-03-03 15:06:46', 0, NULL, 0),
(132, '9840319606', '4121', '2025-03-03 15:16:46', '2025-03-03 15:06:46', 0, NULL, 0),
(133, '9840319606', '4764', '2025-03-03 16:36:31', '2025-03-03 16:26:31', 0, NULL, 0),
(134, '9840319606', '7183', '2025-03-03 16:42:23', '2025-03-03 16:32:23', 0, NULL, 0),
(135, '9840319606', '7814', '2025-03-03 16:45:48', '2025-03-03 16:35:48', 0, NULL, 0),
(136, '9840319606', '2212', '2025-03-03 16:50:34', '2025-03-03 16:40:34', 0, NULL, 0),
(137, '9788033234', '7146', '2025-03-03 16:52:37', '2025-03-03 16:42:37', 0, NULL, 0),
(138, '9788033234', '3704', '2025-03-03 17:18:12', '2025-03-03 17:08:12', 0, NULL, 0),
(139, '9840319606', '4360', '2025-03-03 17:28:52', '2025-03-03 17:18:52', 0, NULL, 0),
(140, '9840319606', '7226', '2025-03-03 17:30:27', '2025-03-03 17:20:27', 0, NULL, 0),
(141, '9840319606', '6669', '2025-03-03 17:48:21', '2025-03-03 17:38:21', 0, NULL, 0),
(142, '9840319606', '4773', '2025-03-03 17:52:21', '2025-03-03 17:42:21', 0, NULL, 0),
(143, '9788033234', '1305', '2025-03-03 18:13:45', '2025-03-03 18:03:45', 0, NULL, 0),
(144, '9840319606', '9293', '2025-03-03 18:23:33', '2025-03-03 18:13:33', 0, NULL, 0),
(145, '9840319606', '8543', '2025-03-03 18:28:44', '2025-03-03 18:18:44', 0, NULL, 0),
(146, '9788033234', '8078', '2025-03-03 19:52:53', '2025-03-03 19:42:53', 0, NULL, 0),
(147, '9585141535', '5369', '2025-03-03 21:55:40', '2025-03-03 21:45:40', 0, NULL, 0),
(148, '9840319606', '5882', '2025-03-04 02:55:25', '2025-03-04 02:45:25', 0, NULL, 0),
(149, '7025357001', '3625', '2025-03-04 08:17:20', '2025-03-04 08:07:20', 0, NULL, 0),
(150, '7025357001', '6916', '2025-03-04 08:17:20', '2025-03-04 08:07:20', 0, NULL, 0),
(151, '7025357001', '7216', '2025-03-04 08:17:20', '2025-03-04 08:07:20', 0, NULL, 0),
(152, '7025357001', '5341', '2025-03-04 08:17:20', '2025-03-04 08:07:20', 0, NULL, 0),
(153, '7025357001', '9290', '2025-03-04 08:17:20', '2025-03-04 08:07:20', 0, NULL, 0),
(154, '9840319606', '6559', '2025-03-04 09:13:34', '2025-03-04 09:03:34', 0, NULL, 0),
(155, '9788033234', '3026', '2025-03-04 16:03:47', '2025-03-04 15:53:47', 0, NULL, 0),
(156, '9788033234', '3279', '2025-03-04 16:32:54', '2025-03-04 16:22:54', 0, NULL, 0),
(157, '9788033234', '8691', '2025-03-04 16:58:22', '2025-03-04 16:48:22', 0, NULL, 0),
(158, '9788033234', '4296', '2025-03-04 19:02:51', '2025-03-04 18:52:51', 0, NULL, 0),
(159, '9788033234', '3572', '2025-03-05 05:32:41', '2025-03-05 05:22:41', 0, NULL, 0),
(160, '9788033234', '4242', '2025-03-05 11:54:46', '2025-03-05 11:44:46', 0, NULL, 0),
(161, '9585141535', '1529', '2025-03-05 11:56:08', '2025-03-05 11:46:08', 0, NULL, 0),
(162, '9788033234', '3329', '2025-03-05 13:07:08', '2025-03-05 12:57:08', 0, NULL, 0),
(163, '9788033234', '8444', '2025-03-05 15:18:13', '2025-03-05 15:08:13', 0, NULL, 0),
(164, '9788033234', '3177', '2025-03-05 15:34:29', '2025-03-05 15:24:29', 0, NULL, 0),
(165, '9788033234', '7675', '2025-03-05 17:42:23', '2025-03-05 17:32:23', 0, NULL, 0),
(166, '9788033234', '4180', '2025-03-05 18:09:39', '2025-03-05 17:59:39', 0, NULL, 0),
(167, '9788033234', '1946', '2025-03-05 19:43:31', '2025-03-05 19:33:31', 0, NULL, 0),
(168, '9788033234', '7658', '2025-03-05 19:44:38', '2025-03-05 19:34:38', 0, NULL, 0),
(169, '6385333161', '8065', '2025-03-06 12:53:37', '2025-03-06 12:43:37', 0, NULL, 0),
(170, '6385333161', '9592', '2025-03-06 12:54:25', '2025-03-06 12:44:25', 0, NULL, 0),
(171, '6385333161', '6713', '2025-03-06 12:54:36', '2025-03-06 12:44:36', 0, NULL, 0),
(172, '9585141535', '2828', '2025-03-06 12:55:33', '2025-03-06 12:45:33', 0, NULL, 0),
(173, '6385333161', '8128', '2025-03-06 15:06:12', '2025-03-06 14:56:12', 0, NULL, 0),
(174, '9788033234', '9335', '2025-03-06 18:28:24', '2025-03-06 18:18:24', 0, NULL, 0),
(175, '9788033234', '8997', '2025-03-06 19:08:41', '2025-03-06 18:58:41', 0, NULL, 0),
(176, '6381279295', '7834', '2025-03-06 19:23:53', '2025-03-06 19:13:53', 0, NULL, 0),
(177, '6381279295', '2349', '2025-03-06 19:47:31', '2025-03-06 19:37:31', 0, NULL, 0),
(178, '6381279295', '1823', '2025-03-06 19:56:52', '2025-03-06 19:46:52', 0, NULL, 0),
(179, '9788033234', '6150', '2025-03-07 05:16:10', '2025-03-07 05:06:10', 0, NULL, 0),
(180, '9788033234', '8249', '2025-03-07 12:21:23', '2025-03-07 12:11:23', 0, NULL, 0),
(181, '9788033234', '6622', '2025-03-07 12:40:12', '2025-03-07 12:30:12', 0, NULL, 0),
(182, '6385333161', '7274', '2025-03-08 10:12:30', '2025-03-08 10:02:30', 0, NULL, 0),
(183, '9788033234', '9360', '2025-03-08 10:33:50', '2025-03-08 10:23:50', 0, NULL, 0),
(184, '9788033234', '1149', '2025-03-08 10:38:09', '2025-03-08 10:28:09', 0, NULL, 0),
(185, '9788033234', '5835', '2025-03-08 11:25:30', '2025-03-08 11:15:30', 0, NULL, 0),
(186, '9788033234', '9187', '2025-03-08 12:01:20', '2025-03-08 11:51:20', 0, NULL, 0),
(187, '9788033234', '5524', '2025-03-08 15:06:13', '2025-03-08 14:56:13', 0, NULL, 0),
(188, '9788033234', '8270', '2025-03-08 18:32:17', '2025-03-08 18:22:17', 0, NULL, 0),
(189, '9788033234', '4882', '2025-03-09 09:15:56', '2025-03-09 09:05:56', 0, NULL, 0),
(190, '9788033234', '8969', '2025-03-09 15:29:39', '2025-03-09 15:19:39', 0, NULL, 0),
(191, '9840319606', '6015', '2025-03-09 15:50:54', '2025-03-09 15:40:54', 0, NULL, 0),
(192, '9788033234', '6708', '2025-03-09 16:17:17', '2025-03-09 16:07:17', 0, NULL, 0),
(193, '9788033234', '4335', '2025-03-09 17:16:11', '2025-03-09 17:06:11', 0, NULL, 0),
(194, '9788033234', '1510', '2025-03-09 17:18:36', '2025-03-09 17:08:36', 0, NULL, 0),
(195, '9840319606', '6929', '2025-03-09 17:35:42', '2025-03-09 17:25:42', 0, NULL, 0),
(196, '9840319606', '6361', '2025-03-09 18:36:46', '2025-03-09 18:26:46', 0, NULL, 0),
(197, '9840319606', '2934', '2025-03-10 05:46:38', '2025-03-10 05:36:38', 0, NULL, 0),
(198, '9788033234', '6127', '2025-03-10 05:47:52', '2025-03-10 05:37:52', 0, NULL, 0),
(199, '9788033234', '2211', '2025-03-10 05:50:10', '2025-03-10 05:40:10', 0, NULL, 0),
(200, '9840319606', '3417', '2025-03-10 05:56:02', '2025-03-10 05:46:02', 0, NULL, 0),
(201, '9788033234', '5853', '2025-03-10 19:05:52', '2025-03-10 18:55:52', 0, NULL, 0),
(202, '9788033234', '8366', '2025-03-10 19:26:20', '2025-03-10 19:16:20', 0, NULL, 0),
(203, '6381279295', '8205', '2025-03-10 21:16:34', '2025-03-10 21:06:34', 0, NULL, 0),
(204, '6381279239', '3033', '2025-03-10 21:25:45', '2025-03-10 21:15:45', 0, NULL, 0),
(205, '6381279239', '7201', '2025-03-10 21:25:48', '2025-03-10 21:15:48', 0, NULL, 0),
(206, '6381279295', '6935', '2025-03-10 21:28:39', '2025-03-10 21:18:39', 0, NULL, 0),
(207, '6381279295', '6454', '2025-03-10 21:31:48', '2025-03-10 21:21:48', 0, NULL, 0),
(208, '6381279295', '3708', '2025-03-10 21:34:33', '2025-03-10 21:24:33', 0, NULL, 0),
(209, '6381279295', '9232', '2025-03-10 21:37:13', '2025-03-10 21:27:13', 0, NULL, 0),
(210, '6385333161', '5636', '2025-03-11 07:42:21', '2025-03-11 07:32:21', 0, NULL, 0),
(211, '9585141535', '6519', '2025-03-11 08:04:23', '2025-03-11 07:54:23', 0, NULL, 0),
(212, '9585141535', '5870', '2025-03-11 08:14:48', '2025-03-11 08:04:48', 0, NULL, 0),
(213, '9585141535', '9757', '2025-03-11 12:26:57', '2025-03-11 12:16:57', 0, NULL, 0),
(214, '9585141535', '7851', '2025-03-11 12:26:57', '2025-03-11 12:16:57', 0, NULL, 0),
(215, '6381279295', '2129', '2025-03-11 16:31:14', '2025-03-11 16:21:14', 0, NULL, 0),
(216, '9788033234', '5776', '2025-03-11 17:10:52', '2025-03-11 17:00:52', 0, NULL, 0),
(217, '', '3990', '2025-03-12 06:18:43', '2025-03-12 06:08:43', 0, NULL, 0),
(218, '9788033234', '7721', '2025-03-12 13:05:06', '2025-03-12 12:55:06', 0, NULL, 0),
(219, '9788033234', '4709', '2025-03-12 16:28:26', '2025-03-12 16:18:26', 0, NULL, 0),
(220, '6385333161', '5438', '2025-03-15 07:13:40', '2025-03-15 07:03:41', 0, NULL, 0),
(221, '6385333161', '8028', '2025-03-15 07:13:51', '2025-03-15 07:03:51', 0, NULL, 0),
(222, '6385333161', '3946', '2025-03-15 07:14:00', '2025-03-15 07:04:00', 0, NULL, 0),
(223, '9840319606', '4964', '2025-03-15 16:48:35', '2025-03-15 16:38:35', 0, NULL, 0),
(224, '', '9571', '2025-03-15 17:10:45', '2025-03-15 17:00:45', 0, NULL, 0),
(225, '6369089584', '9918', '2025-03-15 17:10:58', '2025-03-15 17:00:58', 0, NULL, 0),
(226, '9840319606', '2681', '2025-03-15 17:46:08', '2025-03-15 17:36:08', 0, NULL, 0),
(227, '9840319606', '8916', '2025-03-15 18:11:52', '2025-03-15 18:01:52', 0, NULL, 0),
(228, '9840319606', '7715', '2025-03-15 18:18:46', '2025-03-15 18:08:46', 0, NULL, 0),
(229, '9840319606', '6466', '2025-03-15 18:28:10', '2025-03-15 18:18:10', 0, NULL, 0),
(230, '9840319606', '1482', '2025-03-15 18:38:31', '2025-03-15 18:28:31', 0, NULL, 0),
(231, '9840319606', '9290', '2025-03-15 18:39:50', '2025-03-15 18:29:50', 0, NULL, 0),
(232, '9840319606', '5479', '2025-03-15 18:40:37', '2025-03-15 18:30:37', 0, NULL, 0),
(233, '9840319606', '9295', '2025-03-15 18:54:34', '2025-03-15 18:44:34', 0, NULL, 0),
(234, '9840319606', '9967', '2025-03-15 18:55:49', '2025-03-15 18:45:49', 0, NULL, 0),
(235, '9788033234', '2770', '2025-03-16 10:41:07', '2025-03-16 10:31:07', 0, NULL, 0),
(236, '9788033234', '7729', '2025-03-16 10:41:55', '2025-03-16 10:31:55', 0, NULL, 0),
(237, '9788033234', '5539', '2025-03-16 11:34:23', '2025-03-16 11:24:23', 0, NULL, 0),
(238, '9788033234', '2746', '2025-03-16 11:37:42', '2025-03-16 11:27:42', 0, NULL, 0),
(239, '9788033234', '1489', '2025-03-17 04:23:13', '2025-03-17 04:13:13', 0, NULL, 0),
(240, '9788033234', '7080', '2025-03-17 07:37:42', '2025-03-17 07:27:42', 0, NULL, 0),
(241, '6385333161', '6905', '2025-03-17 07:54:39', '2025-03-17 07:44:39', 0, NULL, 0),
(242, '9788033234', '9713', '2025-03-17 08:36:21', '2025-03-17 08:26:21', 0, NULL, 0),
(243, '9788033234', '4853', '2025-03-17 08:45:58', '2025-03-17 08:35:58', 0, NULL, 0),
(244, '9788033234', '8188', '2025-03-17 08:51:54', '2025-03-17 08:41:54', 0, NULL, 0),
(245, '9788033234', '5663', '2025-03-17 18:40:18', '2025-03-17 18:30:18', 0, NULL, 0),
(246, '9788033234', '1495', '2025-03-17 19:09:17', '2025-03-17 18:59:17', 0, NULL, 0),
(247, '9788033234', '4744', '2025-03-18 05:44:56', '2025-03-18 05:34:56', 0, NULL, 0),
(248, '9788033234', '5273', '2025-03-18 18:27:40', '2025-03-18 18:17:40', 0, NULL, 0),
(249, '9788033234', '2523', '2025-03-18 18:34:47', '2025-03-18 18:24:47', 0, NULL, 0),
(250, '', '3357', '2025-03-18 19:54:38', '2025-03-18 19:44:38', 0, NULL, 0),
(251, '', '1554', '2025-03-18 19:54:42', '2025-03-18 19:44:42', 0, NULL, 0),
(252, '9788033234', '7897', '2025-03-18 19:59:30', '2025-03-18 19:49:30', 0, NULL, 0),
(253, '9942811475', '2014', '2025-03-18 20:29:25', '2025-03-18 20:19:25', 0, NULL, 0),
(254, '6381279295', '7656', '2025-03-18 20:31:54', '2025-03-18 20:21:54', 0, NULL, 0),
(255, '6381279295', '6318', '2025-03-18 20:33:19', '2025-03-18 20:23:19', 0, NULL, 0),
(281, '9715736596', '7719', '2025-03-19 10:18:54', '2025-03-19 10:08:54', 0, NULL, 0),
(282, '9715736596', '7128', '2025-03-19 10:20:05', '2025-03-19 10:10:05', 0, NULL, 0),
(283, '8072993596', '3360', '2025-03-19 11:39:28', '2025-03-19 11:29:28', 0, NULL, 0),
(284, '8072993596', '8416', '2025-03-19 11:40:12', '2025-03-19 11:30:12', 0, NULL, 0),
(285, '6374646530', '5581', '2025-03-19 11:41:05', '2025-03-19 11:31:05', 0, NULL, 0),
(286, '8072993596', '6707', '2025-03-19 11:41:52', '2025-03-19 11:31:52', 0, NULL, 0),
(287, '6374646530', '9127', '2025-03-19 11:42:50', '2025-03-19 11:32:50', 0, NULL, 0),
(288, '8072993596', '1322', '2025-03-19 11:44:29', '2025-03-19 11:34:29', 0, NULL, 0),
(289, '8072993596', '3378', '2025-03-19 11:47:46', '2025-03-19 11:37:46', 0, NULL, 0),
(290, '8072993596', '8879', '2025-03-19 11:49:25', '2025-03-19 11:39:25', 0, NULL, 0),
(291, '9788033234', '2700', '2025-03-19 19:15:18', '2025-03-19 19:05:19', 0, NULL, 0),
(292, '9788033234', '6494', '2025-03-19 19:15:34', '2025-03-19 19:05:34', 0, NULL, 0),
(293, '9585141535', '6018', '2025-03-19 19:32:24', '2025-03-19 19:22:24', 0, NULL, 0),
(294, '9585141535', '2874', '2025-03-19 19:37:58', '2025-03-19 19:27:58', 0, NULL, 0),
(295, '9585141535', '3327', '2025-03-19 19:44:05', '2025-03-19 19:34:05', 0, NULL, 0),
(296, '9788033234', '2671', '2025-03-19 20:03:57', '2025-03-19 19:53:57', 0, NULL, 0),
(297, '9585141535', '6775', '2025-03-20 03:08:55', '2025-03-20 02:58:55', 0, NULL, 0),
(298, '9585141535', '3051', '2025-03-20 03:15:05', '2025-03-20 03:05:05', 0, NULL, 0),
(299, '9585141535', '6709', '2025-03-20 03:30:00', '2025-03-20 03:20:00', 0, NULL, 0),
(300, '9585141535', '5355', '2025-03-20 03:34:45', '2025-03-20 03:24:45', 0, NULL, 0),
(301, '9585141535', '9638', '2025-03-20 03:38:01', '2025-03-20 03:28:01', 0, NULL, 0),
(302, '9789330082', '9761', '2025-03-20 03:45:42', '2025-03-20 03:35:42', 0, NULL, 0),
(303, '9976157984', '5347', '2025-03-20 04:14:35', '2025-03-20 04:04:35', 0, NULL, 0),
(304, '6385333161', '3781', '2025-03-20 09:28:28', '2025-03-20 09:18:28', 0, NULL, 0),
(305, '6385333161', '7022', '2025-03-20 09:29:52', '2025-03-20 09:19:52', 0, NULL, 0),
(306, '6385333161', '5430', '2025-03-20 09:31:09', '2025-03-20 09:21:09', 0, NULL, 0),
(307, '6385333161', '6075', '2025-03-20 09:35:08', '2025-03-20 09:25:08', 0, NULL, 0),
(308, '9788033234', '8847', '2025-03-20 12:12:16', '2025-03-20 12:02:16', 0, NULL, 0),
(309, '9788033234', '9633', '2025-03-20 12:35:35', '2025-03-20 12:25:35', 0, NULL, 0),
(310, '9788033234', '5386', '2025-03-20 12:53:44', '2025-03-20 12:43:44', 0, NULL, 0),
(311, '9788033234', '1925', '2025-03-20 12:56:42', '2025-03-20 12:46:42', 0, NULL, 0),
(312, '9788033234', '5610', '2025-03-20 12:57:07', '2025-03-20 12:47:07', 0, NULL, 0),
(313, '9788033234', '8084', '2025-03-20 13:01:16', '2025-03-20 12:51:16', 0, NULL, 0),
(314, '9566315253', '2099', '2025-03-20 13:10:56', '2025-03-20 13:00:56', 0, NULL, 0),
(315, '9566315253', '9532', '2025-03-20 13:19:56', '2025-03-20 13:09:56', 0, NULL, 0),
(316, '9788033234', '3949', '2025-03-20 13:24:57', '2025-03-20 13:14:57', 0, NULL, 0),
(317, '9788033234', '2523', '2025-03-21 09:49:36', '2025-03-21 09:39:36', 0, NULL, 0),
(318, '9025901345', '4312', '2025-03-21 10:37:37', '2025-03-21 10:27:37', 0, NULL, 0),
(319, '9025901345', '8729', '2025-03-21 10:39:24', '2025-03-21 10:29:24', 0, NULL, 0),
(320, '9788033234', '5204', '2025-03-21 15:32:10', '2025-03-21 15:22:10', 0, NULL, 0),
(321, '9788033234', '3311', '2025-03-21 15:39:06', '2025-03-21 15:29:06', 0, NULL, 0),
(322, '9840319606', '3308', '2025-03-21 18:23:01', '2025-03-21 18:13:01', 0, NULL, 0),
(323, '9788033234', '5122', '2025-03-21 18:23:57', '2025-03-21 18:13:57', 0, NULL, 0),
(324, '9788033234', '1585', '2025-03-21 19:42:15', '2025-03-21 19:32:15', 0, NULL, 0),
(325, '9585141535', '3348', '2025-03-21 19:52:43', '2025-03-21 19:42:43', 0, NULL, 0),
(326, '9585141535', '7057', '2025-03-21 19:55:19', '2025-03-21 19:45:19', 0, NULL, 0),
(327, '9585141535', '3898', '2025-03-21 19:56:47', '2025-03-21 19:46:47', 0, NULL, 0),
(328, '9840319606', '2649', '2025-03-22 03:38:57', '2025-03-22 03:28:57', 0, NULL, 0),
(329, '9840319606', '6572', '2025-03-22 03:41:06', '2025-03-22 03:31:06', 0, NULL, 0),
(330, '9840319606', '6904', '2025-03-22 06:05:51', '2025-03-22 05:55:51', 0, NULL, 0),
(331, '9840319606', '4367', '2025-03-22 06:05:51', '2025-03-22 05:55:51', 0, NULL, 0),
(332, '9840319606', '6834', '2025-03-22 06:06:15', '2025-03-22 05:56:15', 0, NULL, 0),
(333, '9840319606', '2107', '2025-03-22 06:30:26', '2025-03-22 06:20:26', 0, NULL, 0),
(334, '9840319606', '7066', '2025-03-22 08:58:37', '2025-03-22 08:48:37', 0, NULL, 0),
(335, '9840319606', '3373', '2025-03-22 08:58:37', '2025-03-22 08:48:37', 0, NULL, 0),
(336, '9840319606', '9481', '2025-03-22 08:58:48', '2025-03-22 08:48:48', 0, NULL, 0),
(337, '9788033234', '5207', '2025-03-22 12:36:23', '2025-03-22 12:26:23', 0, NULL, 0),
(338, '9788033234', '3730', '2025-03-22 12:39:07', '2025-03-22 12:29:07', 0, NULL, 0),
(339, '9788033234', '6105', '2025-03-22 12:41:46', '2025-03-22 12:31:46', 0, NULL, 0),
(340, '9788033234', '2697', '2025-03-22 12:43:19', '2025-03-22 12:33:19', 0, NULL, 0),
(341, '9788033234', '1737', '2025-03-22 12:44:45', '2025-03-22 12:34:45', 0, NULL, 0),
(342, '9788033234', '2753', '2025-03-22 12:46:18', '2025-03-22 12:36:18', 0, NULL, 0),
(343, '9585141535', '3243', '2025-03-22 13:12:43', '2025-03-22 13:02:43', 0, NULL, 0),
(344, '9585141535', '8425', '2025-03-22 13:16:45', '2025-03-22 13:06:45', 0, NULL, 0),
(345, '8667382195', '2383', '2025-03-22 13:51:47', '2025-03-22 13:41:47', 0, NULL, 0),
(346, '9585141535', '1982', '2025-03-22 14:03:07', '2025-03-22 13:53:07', 0, NULL, 0),
(347, '9486979231', '7239', '2025-03-22 14:23:21', '2025-03-22 14:13:21', 0, NULL, 0),
(348, '9486979231', '3021', '2025-03-22 14:24:13', '2025-03-22 14:14:13', 0, NULL, 0),
(349, '9486979231', '8935', '2025-03-22 14:27:45', '2025-03-22 14:17:45', 0, NULL, 0),
(350, '9486979231', '5476', '2025-03-22 14:28:51', '2025-03-22 14:18:51', 0, NULL, 0),
(351, '9840319606', '5991', '2025-03-22 17:36:36', '2025-03-22 17:26:36', 0, NULL, 0),
(352, '9788033234', '1017', '2025-03-22 18:49:17', '2025-03-22 18:39:17', 0, NULL, 0),
(353, '9788033234', '3649', '2025-03-22 20:08:37', '2025-03-22 19:58:37', 0, NULL, 0),
(354, '9840319606', '8714', '2025-03-23 05:08:36', '2025-03-23 04:58:36', 0, NULL, 0),
(355, '8072993596', '5360', '2025-03-23 07:18:39', '2025-03-23 07:08:39', 0, NULL, 0),
(356, '9788033234', '8303', '2025-03-23 07:55:29', '2025-03-23 07:45:29', 0, NULL, 0),
(357, '9788033234', '6276', '2025-03-23 07:55:57', '2025-03-23 07:45:57', 0, NULL, 0),
(358, '9788033234', '7718', '2025-03-23 07:57:23', '2025-03-23 07:47:23', 0, NULL, 0),
(359, '9788033234', '2853', '2025-03-23 10:18:30', '2025-03-23 10:08:30', 0, NULL, 0),
(360, '', '7166', '2025-03-23 10:25:33', '2025-03-23 10:15:33', 0, NULL, 0),
(361, '9788033234', '9319', '2025-03-23 10:25:45', '2025-03-23 10:15:45', 0, NULL, 0),
(362, '9788033234', '6920', '2025-03-23 12:06:22', '2025-03-23 11:56:22', 0, NULL, 0),
(363, '1446043833', '5701', '2025-03-23 14:47:57', '2025-03-23 14:37:57', 0, NULL, 0),
(364, '9788033234', '9561', '2025-03-23 19:17:34', '2025-03-23 19:07:34', 0, NULL, 0),
(365, '9788033234', '8352', '2025-03-24 08:47:02', '2025-03-24 08:37:02', 0, NULL, 0),
(366, '9788033234', '8413', '2025-03-24 08:48:19', '2025-03-24 08:38:19', 0, NULL, 0),
(367, '9788033234', '8466', '2025-03-24 08:48:59', '2025-03-24 08:38:59', 0, NULL, 0),
(368, '9788033234', '2257', '2025-03-24 08:53:10', '2025-03-24 08:43:10', 0, NULL, 0),
(369, '9840319606', '8452', '2025-03-24 09:28:37', '2025-03-24 09:18:37', 0, NULL, 0),
(370, '9788033234', '3621', '2025-03-24 09:29:26', '2025-03-24 09:19:26', 0, NULL, 0),
(371, '8056151190', '1258', '2025-03-24 10:57:07', '2025-03-24 10:47:07', 0, NULL, 0),
(372, '9788033234', '4643', '2025-03-24 11:08:21', '2025-03-24 10:58:21', 0, NULL, 0),
(373, '9788033234', '2047', '2025-03-24 11:09:25', '2025-03-24 10:59:25', 0, NULL, 0),
(374, '8072993596', '1427', '2025-03-24 11:42:41', '2025-03-24 11:32:41', 0, NULL, 0),
(375, '9585141535', '4388', '2025-03-24 13:10:44', '2025-03-24 13:00:44', 0, NULL, 0),
(376, '9976157984', '9484', '2025-03-24 14:04:34', '2025-03-24 13:54:34', 0, NULL, 0),
(377, '9840319606', '2521', '2025-03-24 14:11:29', '2025-03-24 14:01:29', 0, NULL, 0),
(378, '9840319606', '2434', '2025-03-24 14:12:54', '2025-03-24 14:02:54', 0, NULL, 0),
(379, '8072993596', '1179', '2025-03-24 14:21:30', '2025-03-24 14:11:30', 0, NULL, 0),
(380, '8072993596', '7033', '2025-03-24 14:22:13', '2025-03-24 14:12:13', 0, NULL, 0),
(381, '8072993596', '6650', '2025-03-24 14:29:33', '2025-03-24 14:19:33', 0, NULL, 0),
(382, '6374646530', '3782', '2025-03-24 14:34:47', '2025-03-24 14:24:47', 0, NULL, 0),
(383, '8072993596', '2337', '2025-03-24 14:37:21', '2025-03-24 14:27:21', 0, NULL, 0),
(384, '8072993596', '3538', '2025-03-24 14:39:26', '2025-03-24 14:29:26', 0, NULL, 0),
(385, '8072993596', '5528', '2025-03-24 14:43:06', '2025-03-24 14:33:06', 0, NULL, 0),
(386, '9840319606', '8942', '2025-03-24 15:52:56', '2025-03-24 15:42:56', 0, NULL, 0),
(387, '9840319606', '7984', '2025-03-24 16:07:55', '2025-03-24 15:57:55', 0, NULL, 0),
(388, '9840319606', '3411', '2025-03-24 16:11:15', '2025-03-24 16:01:15', 0, NULL, 0),
(389, '9840319606', '7173', '2025-03-24 16:17:27', '2025-03-24 16:07:27', 0, NULL, 0),
(390, '9840319606', '8714', '2025-03-24 16:25:52', '2025-03-24 16:15:52', 0, NULL, 0),
(391, '9840319606', '9316', '2025-03-24 16:27:17', '2025-03-24 16:17:17', 0, NULL, 0),
(392, '9840319606', '6439', '2025-03-24 16:39:21', '2025-03-24 16:29:21', 0, NULL, 0),
(393, '9840319606', '9969', '2025-03-24 16:42:44', '2025-03-24 16:32:44', 0, NULL, 0),
(394, '9840319606', '3865', '2025-03-24 16:43:26', '2025-03-24 16:33:26', 0, NULL, 0),
(395, '9840319606', '7289', '2025-03-24 18:07:01', '2025-03-24 17:57:01', 0, NULL, 0),
(396, '9840319606', '3300', '2025-03-24 18:09:10', '2025-03-24 17:59:10', 0, NULL, 0),
(397, '9840319606', '7422', '2025-03-24 18:10:15', '2025-03-24 18:00:15', 0, NULL, 0),
(398, '9840319606', '5459', '2025-03-24 18:32:36', '2025-03-24 18:22:36', 0, NULL, 0),
(399, '9840319606', '1406', '2025-03-24 18:54:16', '2025-03-24 18:44:16', 0, NULL, 0),
(400, '9840319606', '5190', '2025-03-24 19:05:15', '2025-03-24 18:55:15', 0, NULL, 0),
(401, '9840319606', '7624', '2025-03-24 19:07:51', '2025-03-24 18:57:51', 0, NULL, 0),
(402, '9840319606', '1747', '2025-03-24 19:10:42', '2025-03-24 19:00:42', 0, NULL, 0),
(403, '9840319606', '2405', '2025-03-24 19:27:18', '2025-03-24 19:17:18', 0, NULL, 0),
(404, '9840319606', '8213', '2025-03-24 19:28:39', '2025-03-24 19:18:39', 0, NULL, 0),
(405, '9585141535', '6891', '2025-03-25 03:24:55', '2025-03-25 03:14:55', 0, NULL, 0),
(406, '9585141535', '9616', '2025-03-25 03:29:00', '2025-03-25 03:19:00', 0, NULL, 0),
(407, '9976157984', '8369', '2025-03-25 04:17:50', '2025-03-25 04:07:50', 0, NULL, 0),
(408, '8072993596', '5366', '2025-03-25 06:59:19', '2025-03-25 06:49:19', 0, NULL, 0),
(409, '8072993596', '3058', '2025-03-25 07:11:40', '2025-03-25 07:01:40', 0, NULL, 0),
(410, '8072993596', '6767', '2025-03-25 13:33:08', '2025-03-25 13:23:08', 0, NULL, 0),
(411, '9788033234', '9965', '2025-03-26 10:53:45', '2025-03-26 10:43:45', 0, NULL, 0),
(412, '9788033234', '1091', '2025-03-26 10:55:56', '2025-03-26 10:45:56', 0, NULL, 0),
(413, '6381279295', '2123', '2025-03-26 11:00:16', '2025-03-26 10:50:16', 0, NULL, 0),
(414, '6381279295', '7341', '2025-03-26 11:02:46', '2025-03-26 10:52:46', 0, NULL, 0),
(415, '6381279295', '8272', '2025-03-26 11:02:50', '2025-03-26 10:52:50', 0, NULL, 0),
(416, '9788033234', '1233', '2025-03-27 11:58:21', '2025-03-27 11:48:21', 0, NULL, 0),
(417, '9788033234', '2853', '2025-03-27 12:14:19', '2025-03-27 12:04:19', 0, NULL, 0),
(418, '8072993596', '9570', '2025-03-27 12:14:40', '2025-03-27 12:04:40', 0, NULL, 0),
(419, '9788033234', '5558', '2025-03-27 13:25:23', '2025-03-27 13:15:23', 0, NULL, 0),
(420, '9788033234', '7116', '2025-03-27 13:42:09', '2025-03-27 13:32:09', 0, NULL, 0),
(421, '9788033234', '1404', '2025-03-27 14:59:52', '2025-03-27 14:49:52', 0, NULL, 0),
(422, '6381279295', '3733', '2025-03-27 14:59:58', '2025-03-27 14:49:59', 0, NULL, 0),
(423, '9788033234', '3741', '2025-03-27 15:52:16', '2025-03-27 15:42:16', 0, NULL, 0),
(424, '9788033234', '9203', '2025-03-27 16:19:54', '2025-03-27 16:09:54', 0, NULL, 0),
(425, '9788033234', '3066', '2025-03-27 16:35:33', '2025-03-27 16:25:33', 0, NULL, 0),
(426, '9788033234', '5681', '2025-03-27 17:54:31', '2025-03-27 17:44:31', 0, NULL, 0),
(427, '9788033234', '7222', '2025-03-27 18:09:34', '2025-03-27 17:59:34', 0, NULL, 0),
(428, '9788033234', '2572', '2025-03-27 18:19:12', '2025-03-27 18:09:12', 0, NULL, 0),
(429, '9788033234', '3346', '2025-03-27 18:37:56', '2025-03-27 18:27:56', 0, NULL, 0),
(430, '9585141535', '6655', '2025-03-28 09:05:04', '2025-03-28 08:55:04', 0, NULL, 0),
(431, '9585141535', '4376', '2025-03-28 09:07:08', '2025-03-28 08:57:08', 0, NULL, 0),
(432, '9788033234', '1968', '2025-03-28 10:33:11', '2025-03-28 10:23:11', 0, NULL, 0),
(433, '6381279295', '4854', '2025-03-28 10:49:06', '2025-03-28 10:39:06', 0, NULL, 0),
(434, '6381279295', '4235', '2025-03-28 11:50:36', '2025-03-28 11:40:36', 0, NULL, 0),
(435, '9788033234', '2752', '2025-03-29 07:47:34', '2025-03-29 07:37:34', 0, NULL, 1),
(436, '9788033234', '5713', '2025-03-29 08:39:30', '2025-03-29 08:29:30', 0, NULL, 1),
(437, '9585141535', '4049', '2025-03-30 18:14:23', '2025-03-30 18:04:23', 0, NULL, 1),
(438, '9788033234', '7507', '2025-03-31 06:04:20', '2025-03-31 05:54:20', 0, NULL, 1),
(439, '9788033234', '1534', '2025-03-31 06:17:32', '2025-03-31 06:07:32', 0, NULL, 1),
(440, '9788033234', '1065', '2025-03-31 06:23:01', '2025-03-31 06:13:01', 0, NULL, 1),
(441, '9788033234', '3041', '2025-03-31 06:25:56', '2025-03-31 06:15:56', 0, NULL, 1),
(442, '9788033234', '7044', '2025-03-31 06:30:29', '2025-03-31 06:20:29', 0, NULL, 1),
(443, '9788033234', '1899', '2025-03-31 06:31:43', '2025-03-31 06:21:43', 0, NULL, 1),
(444, '9788033234', '6388', '2025-03-31 09:14:36', '2025-03-31 09:04:36', 0, NULL, 1),
(445, '9788033234', '8487', '2025-03-31 09:58:29', '2025-03-31 09:48:29', 0, NULL, 1),
(446, '9788033234', '2714', '2025-03-31 10:24:31', '2025-03-31 10:14:31', 0, NULL, 0),
(447, '9788033234', '8530', '2025-03-31 10:24:31', '2025-03-31 10:14:31', 0, NULL, 0),
(448, '9788033234', '7580', '2025-03-31 10:24:36', '2025-03-31 10:14:36', 0, NULL, 1),
(449, '9788033234', '3805', '2025-03-31 11:32:46', '2025-03-31 11:22:46', 0, NULL, 1),
(450, '9788033234', '7863', '2025-03-31 11:57:57', '2025-03-31 11:47:57', 1, NULL, 1),
(451, '9788033234', '1735', '2025-03-31 12:09:11', '2025-03-31 11:59:11', 0, NULL, 1),
(452, '9788033234', '8308', '2025-03-31 13:05:06', '2025-03-31 12:55:06', 0, NULL, 1),
(453, '9788033234', '3791', '2025-03-31 13:24:53', '2025-03-31 13:14:53', 0, NULL, 1),
(454, '9486979231', '3963', '2025-04-01 06:31:11', '2025-04-01 06:21:11', 0, NULL, 0),
(455, '9486979231', '8852', '2025-04-01 06:31:26', '2025-04-01 06:21:26', 1, NULL, 1),
(456, '9788033234', '6714', '2025-04-01 06:42:58', '2025-04-01 06:32:58', 0, NULL, 0),
(457, '9788033234', '5132', '2025-04-01 06:43:12', '2025-04-01 06:33:12', 1, NULL, 1),
(458, '9788033234', '8815', '2025-04-01 06:57:39', '2025-04-01 06:47:39', 0, NULL, 1),
(459, '9788033234', '2094', '2025-04-01 07:02:09', '2025-04-01 06:52:09', 0, NULL, 1),
(460, '9788033234', '5257', '2025-04-01 07:07:28', '2025-04-01 06:57:28', 0, NULL, 1),
(461, '9585141535', '2247', '2025-04-01 07:24:13', '2025-04-01 07:14:13', 0, NULL, 1),
(462, '9788033234', '8461', '2025-04-01 07:54:46', '2025-04-01 07:44:46', 0, NULL, 0),
(463, '9788033234', '6527', '2025-04-01 07:54:46', '2025-04-01 07:44:46', 0, NULL, 1),
(464, '9585141535', '9620', '2025-04-01 08:02:56', '2025-04-01 07:52:56', 0, NULL, 1),
(465, '9585141535', '8848', '2025-04-01 08:03:32', '2025-04-01 07:53:32', 1, NULL, 0),
(466, '9585141535', '2424', '2025-04-01 08:04:08', '2025-04-01 07:54:08', 0, NULL, 1),
(467, '9788033234', '4472', '2025-04-01 08:19:56', '2025-04-01 08:09:56', 0, NULL, 1),
(468, '9788033234', '7653', '2025-04-01 09:55:40', '2025-04-01 09:45:40', 0, NULL, 1),
(469, '9788033234', '4167', '2025-04-01 10:11:18', '2025-04-01 10:01:18', 0, NULL, 1),
(470, '9788033234', '7383', '2025-04-01 11:22:28', '2025-04-01 11:12:28', 0, NULL, 1),
(471, '9788033234', '2085', '2025-04-01 11:43:15', '2025-04-01 11:33:15', 0, NULL, 1),
(472, '9788033234', '8086', '2025-04-01 12:05:34', '2025-04-01 11:55:34', 0, NULL, 1),
(473, '9788033234', '1362', '2025-04-01 12:20:55', '2025-04-01 12:10:55', 0, NULL, 1),
(474, '9585141535', '6836', '2025-04-02 12:38:06', '2025-04-02 12:28:06', 0, NULL, 1),
(475, '9788033234', '3404', '2025-04-02 12:38:56', '2025-04-02 12:28:56', 0, NULL, 1),
(476, '9585141535', '6756', '2025-04-02 12:39:07', '2025-04-02 12:29:07', 0, NULL, 1),
(477, '9788033234', '1897', '2025-04-02 12:40:45', '2025-04-02 12:30:45', 0, NULL, 1),
(478, '9585141535', '8070', '2025-04-02 12:42:05', '2025-04-02 12:32:05', 0, NULL, 1),
(479, '9025901345', '5642', '2025-04-02 13:25:38', '2025-04-02 13:15:38', 0, NULL, 1),
(480, '9025901345', '4604', '2025-04-02 13:27:38', '2025-04-02 13:17:38', 0, NULL, 1),
(481, '9025901345', '9978', '2025-04-02 13:32:06', '2025-04-02 13:22:06', 0, NULL, 1),
(482, '9585141535', '9382', '2025-04-02 17:12:21', '2025-04-02 17:02:21', 1, NULL, 1),
(483, '9486979231', '9598', '2025-04-03 03:47:38', '2025-04-03 03:37:38', 0, NULL, 1),
(484, '9585141535', '9242', '2025-04-03 04:12:23', '2025-04-03 04:02:23', 0, NULL, 1),
(485, '9080862495', '1095', '2025-04-03 04:30:40', '2025-04-03 04:20:40', 0, NULL, 0),
(486, '9080862495', '6080', '2025-04-03 04:31:23', '2025-04-03 04:21:23', 0, NULL, 1),
(487, '9788033234', '9166', '2025-04-03 13:26:13', '2025-04-03 13:16:13', 0, NULL, 1),
(488, '9788033234', '5673', '2025-04-03 13:27:58', '2025-04-03 13:17:58', 0, NULL, 1),
(489, '9788033234', '2001', '2025-04-03 14:31:02', '2025-04-03 14:21:02', 0, NULL, 1),
(490, '9788033234', '3470', '2025-04-03 14:44:33', '2025-04-03 14:34:33', 0, NULL, 0),
(491, '9788033234', '9122', '2025-04-03 14:46:53', '2025-04-03 14:36:53', 0, NULL, 1),
(492, '6381279295', '6961', '2025-04-03 17:20:59', '2025-04-03 17:10:59', 0, NULL, 1),
(493, '9788033234', '5505', '2025-04-03 18:24:17', '2025-04-03 18:14:17', 0, NULL, 1),
(494, '9788033234', '7978', '2025-04-03 19:48:53', '2025-04-03 19:38:53', 0, NULL, 1),
(495, '7045719909', '9200', '2025-04-04 04:52:10', '2025-04-04 04:42:10', 0, NULL, 0),
(496, '7045719909', '5028', '2025-04-04 04:52:59', '2025-04-04 04:42:59', 0, NULL, 1),
(497, '7045719909', '8448', '2025-04-04 05:15:29', '2025-04-04 05:05:29', 0, NULL, 1),
(498, '9788033234', '4942', '2025-04-06 07:39:57', '2025-04-06 07:29:57', 0, NULL, 1),
(499, '9788033234', '1687', '2025-04-06 09:35:58', '2025-04-06 09:25:58', 0, NULL, 1),
(500, '9788033234', '6550', '2025-04-06 09:53:09', '2025-04-06 09:43:09', 0, NULL, 1),
(501, '9788033234', '9517', '2025-04-06 10:39:38', '2025-04-06 10:29:38', 0, NULL, 1),
(502, '', '3881', '2025-04-06 14:50:01', '2025-04-06 14:40:01', 0, NULL, 0),
(503, '1446043833', '7011', '2025-04-07 08:11:00', '2025-04-07 08:01:00', 0, NULL, 0),
(504, '9788033234', '8883', '2025-04-07 18:45:13', '2025-04-07 18:35:13', 0, NULL, 0),
(505, '6381279295', '4458', '2025-04-07 18:50:40', '2025-04-07 18:40:40', 1, NULL, 0),
(506, '6381279295', '4135', '2025-04-07 18:54:00', '2025-04-07 18:44:00', 0, NULL, 1),
(507, '9788033234', '4581', '2025-04-08 11:35:05', '2025-04-08 11:25:05', 0, NULL, 1),
(508, '1446043833', '1368', '2025-04-08 18:25:33', '2025-04-08 18:15:33', 0, NULL, 0),
(509, '9788033234', '8068', '2025-04-09 06:54:42', '2025-04-09 06:44:42', 0, NULL, 1),
(510, '9788033234', '7306', '2025-04-09 07:15:12', '2025-04-09 07:05:12', 0, NULL, 1),
(511, '9788033234', '7492', '2025-04-09 07:24:40', '2025-04-09 07:14:40', 0, NULL, 1),
(512, '', '1332', '2025-04-09 07:29:44', '2025-04-09 07:19:44', 0, NULL, 0),
(513, '9788033234', '1986', '2025-04-09 07:31:08', '2025-04-09 07:21:08', 0, NULL, 1),
(514, '9788033234', '9112', '2025-04-09 07:42:13', '2025-04-09 07:32:13', 0, NULL, 1),
(515, '9788033234', '4135', '2025-04-09 08:24:59', '2025-04-09 08:14:59', 0, NULL, 0),
(516, '9788033234', '6735', '2025-04-09 08:25:09', '2025-04-09 08:15:09', 0, NULL, 1),
(517, '9585141535', '8322', '2025-04-09 08:43:22', '2025-04-09 08:33:22', 0, NULL, 1),
(518, '9585141535', '6056', '2025-04-09 08:46:45', '2025-04-09 08:36:45', 0, NULL, 1),
(519, '9585141535', '3950', '2025-04-09 09:14:39', '2025-04-09 09:04:39', 3, '2025-04-09 09:11:25', 0),
(520, '8072993596', '7517', '2025-04-09 09:19:24', '2025-04-09 09:09:24', 0, NULL, 1),
(521, '9585141535', '2698', '2025-04-09 09:19:53', '2025-04-09 09:09:53', 3, '2025-04-09 09:15:46', 0),
(522, '6385333161', '8367', '2025-04-09 09:26:06', '2025-04-09 09:16:06', 0, NULL, 1),
(523, '9585141535', '4029', '2025-04-09 09:28:10', '2025-04-09 09:18:10', 1, NULL, 0),
(524, '8655907044', '2830', '2025-04-09 11:16:08', '2025-04-09 11:06:08', 0, NULL, 0),
(525, '8655907044', '5283', '2025-04-09 11:20:55', '2025-04-09 11:10:55', 0, NULL, 1),
(526, '8655907044', '3888', '2025-04-09 12:19:14', '2025-04-09 12:09:14', 0, NULL, 1),
(527, '8655907044', '8571', '2025-04-09 12:23:10', '2025-04-09 12:13:10', 0, NULL, 1),
(528, '8655907044', '5530', '2025-04-09 12:49:33', '2025-04-09 12:39:33', 3, NULL, 0),
(529, '8655907044', '2724', '2025-04-09 12:51:44', '2025-04-09 12:41:44', 0, NULL, 0),
(530, '8655907044', '9213', '2025-04-09 12:52:41', '2025-04-09 12:42:41', 0, NULL, 0),
(531, '9788033234', '3197', '2025-04-09 12:53:37', '2025-04-09 12:43:37', 0, NULL, 0),
(532, '8655907044', '4607', '2025-04-09 12:54:35', '2025-04-09 12:44:35', 0, NULL, 1),
(533, '9585141535', '9175', '2025-04-09 14:03:57', '2025-04-09 13:53:57', 0, NULL, 1),
(534, '9585141535', '2735', '2025-04-09 14:12:01', '2025-04-09 14:02:01', 0, NULL, 1),
(535, '9788033234', '8075', '2025-04-09 15:08:06', '2025-04-09 14:58:06', 0, NULL, 0),
(536, '9788033234', '4257', '2025-04-09 15:08:11', '2025-04-09 14:58:11', 0, NULL, 1),
(537, '8655907044', '1871', '2025-04-09 15:25:50', '2025-04-09 15:15:50', 0, NULL, 1),
(538, '9003616461', '4912', '2025-04-10 06:27:31', '2025-04-10 06:17:31', 0, NULL, 1),
(539, '9003616461', '2733', '2025-04-10 06:35:52', '2025-04-10 06:25:52', 0, NULL, 1),
(540, '9115161011', '7191', '2025-04-10 10:46:48', '2025-04-10 10:36:48', 0, NULL, 0),
(541, '9115161011', '2897', '2025-04-10 10:48:18', '2025-04-10 10:38:18', 0, NULL, 1),
(542, '8655907044', '1385', '2025-04-10 10:51:25', '2025-04-10 10:41:25', 0, NULL, 1),
(543, '9003616461', '5479', '2025-04-10 11:10:44', '2025-04-10 11:00:44', 0, NULL, 1),
(544, '6385333161', '1261', '2025-04-11 07:54:15', '2025-04-11 07:44:15', 0, NULL, 0),
(545, '9788033234', '1681', '2025-04-11 10:49:11', '2025-04-11 10:39:11', 0, NULL, 0),
(546, '9788033234', '2518', '2025-04-11 10:49:11', '2025-04-11 10:39:11', 0, NULL, 0),
(547, '9788033234', '1883', '2025-04-11 10:49:12', '2025-04-11 10:39:12', 0, NULL, 1),
(548, '9788033234', '5028', '2025-04-11 11:19:00', '2025-04-11 11:09:00', 0, NULL, 1),
(549, '8655907044', '2271', '2025-04-11 11:21:57', '2025-04-11 11:11:57', 0, NULL, 1),
(550, '8655907044', '7970', '2025-04-11 12:30:51', '2025-04-11 12:20:51', 0, NULL, 1),
(551, '9840319606', '9555', '2025-04-12 08:21:27', '2025-04-12 08:11:27', 0, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `investment_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_method` enum('UPI','NetBanking','CreditCard','DebitCard','Cash','NB') NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `payment_status` enum('pending','success','failed','refunded') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `monthNumber` int(11) NOT NULL,
  `status` enum('ACTIVE','DEACTIVE','','') NOT NULL DEFAULT 'ACTIVE',
  `gold_rate` decimal(10,2) NOT NULL,
  `current_goldrate` decimal(10,0) NOT NULL,
  `current_silverrate` decimal(10,0) NOT NULL,
  `silver_rate` decimal(10,2) NOT NULL,
  `order_id` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `investment_id`, `amount`, `payment_date`, `payment_method`, `transaction_id`, `payment_status`, `created_at`, `updated_at`, `monthNumber`, `status`, `gold_rate`, `current_goldrate`, `current_silverrate`, `silver_rate`, `order_id`) VALUES
(73, 3, 172, 1000.00, '2025-03-20 03:29:32', 'NB', 'SG1358-order_3_1742441353579-1', 'success', '2025-03-19 21:59:32', '2025-03-19 21:59:32', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(72, 3, 171, 1000.00, '2025-03-20 03:26:05', 'NB', 'SG1358-order_3_1742441132122-1', 'success', '2025-03-19 21:56:05', '2025-03-19 21:56:05', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(71, 379, 164, 1000.00, '2025-03-19 19:09:03', 'NB', 'SG1358-order_379_1742411324337-1', 'success', '2025-03-19 13:39:03', '2025-03-19 13:39:03', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(70, 379, 163, 1000.00, '2025-03-19 17:27:15', 'NB', 'SG1358-order_379_1742405073622-1', 'success', '2025-03-19 11:57:15', '2025-03-19 11:57:15', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(69, 379, 160, 1000.00, '2025-03-19 10:20:37', 'NB', 'SG1358-order_379_1742379613059-1', 'success', '2025-03-19 04:50:37', '2025-03-19 04:50:37', 2, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(68, 379, 160, 1000.00, '2025-03-19 08:16:09', 'NB', 'SG1358-order_379_1742372149946-1', 'success', '2025-03-19 02:46:09', '2025-03-19 02:46:09', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(67, 379, 158, 1000.00, '2025-03-19 07:12:27', 'NB', 'SG1358-order_379_1742368236480-1', 'success', '2025-03-19 01:42:27', '2025-03-19 01:42:27', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(74, 379, 173, 1000.00, '2025-03-21 19:34:20', 'NB', 'SG1358-order_379_1742585640065-1', 'success', '2025-03-21 14:04:20', '2025-03-21 14:04:20', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(75, 387, 174, 1000.00, '2025-03-22 14:25:24', 'NB', 'SG1358-order_387_1742653342742-1', 'success', '2025-03-22 08:55:24', '2025-03-22 08:55:24', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(76, 3, 176, 1000.00, '2025-03-22 17:23:55', 'NB', 'SG1358-order_3_1742664215496-1', 'success', '2025-03-22 11:53:55', '2025-03-22 11:53:55', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(77, 379, 181, 1000.00, '2025-03-27 12:12:08', 'NB', 'SG1358-order_379_1743077383534-1', 'success', '2025-03-27 06:42:08', '2025-03-27 06:42:08', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(78, 379, 182, 1000.00, '2025-03-27 13:17:25', 'NB', 'SG1358-order_379_1743081395074-1', 'success', '2025-03-27 07:47:25', '2025-03-27 07:47:25', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(79, 379, 183, 1000.00, '2025-03-27 14:08:17', 'NB', 'SG1358-order_379_1743084470978-1', 'success', '2025-03-27 08:38:17', '2025-03-27 08:38:17', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(80, 379, 193, 1000.00, '2025-03-27 15:24:44', 'NB', 'SG1358-order_379_1743088966316-1', 'success', '2025-03-27 09:54:44', '2025-03-27 09:54:44', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(81, 379, 210, 1000.00, '2025-03-28 10:27:59', 'NB', 'SG1358-order_379_1743157555170-1', 'success', '2025-03-28 04:57:59', '2025-03-28 04:57:59', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(82, 379, 211, 1000.00, '2025-03-28 10:33:05', 'NB', 'SG1358-order_379_1743157915646-1', 'success', '2025-03-28 05:03:05', '2025-03-28 05:03:05', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(83, 379, 212, 1000.00, '2025-03-28 10:41:03', 'NB', 'SG1358-order_379_1743158415886-1', 'success', '2025-03-28 05:11:03', '2025-03-28 05:11:03', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(84, 381, 213, 1000.00, '2025-03-28 10:45:23', 'NB', 'SG1358-order_381_1743158681550-1', 'success', '2025-03-28 05:15:23', '2025-03-28 05:15:23', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(85, 381, 215, 1000.00, '2025-03-28 11:34:31', 'NB', 'SG1358-order_381_1743161614570-1', 'success', '2025-03-28 06:04:31', '2025-03-28 06:04:31', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, ''),
(86, 381, 223, 1000.00, '2025-04-03 17:21:39', 'NB', 'SG1358-order_381_1743700873296-1', 'success', '2025-04-03 11:51:39', '2025-04-03 11:51:39', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743700873296'),
(87, 381, 224, 1000.00, '2025-04-03 17:32:05', 'NB', 'SG1358-order_381_1743701489118-1', 'success', '2025-04-03 12:02:05', '2025-04-03 12:02:05', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743701489118'),
(88, 381, 225, 1000.00, '2025-04-03 17:34:39', 'NB', 'SG1358-order_381_1743701655424-1', 'success', '2025-04-03 12:04:39', '2025-04-03 12:04:39', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743701655424'),
(89, 381, 226, 1000.00, '2025-04-03 17:42:06', 'NB', 'SG1358-order_381_1743702046385-1', 'success', '2025-04-03 12:12:06', '2025-04-03 12:12:06', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743702046385'),
(90, 381, 229, 1000.00, '2025-04-03 17:47:35', 'NB', 'SG1358-order_381_1743702430132-1', 'success', '2025-04-03 12:17:35', '2025-04-03 12:17:35', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743702430132'),
(91, 381, 230, 10000.00, '2025-04-03 17:53:44', 'NB', 'SG1358-order_381_1743702803152-1', 'success', '2025-04-03 12:23:44', '2025-04-03 12:23:44', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743702803152'),
(92, 381, 230, 1000.00, '2025-04-03 18:10:43', 'NB', 'SG1358-order_381_1743703814636-1', 'success', '2025-04-03 12:40:43', '2025-04-03 12:40:43', 2, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_381_1743703814636'),
(93, 379, 212, 1000.00, '2025-04-03 18:16:59', 'NB', 'SG1358-order_379_1743704193623-1', 'success', '2025-04-03 12:46:59', '2025-04-03 12:46:59', 2, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_379_1743704193623'),
(94, 379, 212, 1000.00, '2025-04-03 18:30:29', 'NB', 'SG1358-order_379_1743704993822-1', 'success', '2025-04-03 13:00:29', '2025-04-03 13:00:29', 3, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_379_1743704993822'),
(95, 379, 212, 1000.00, '2025-04-03 18:32:14', 'NB', 'SG1358-order_379_1743705112841-1', 'success', '2025-04-03 13:02:14', '2025-04-03 13:02:14', 4, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_379_1743705112841'),
(96, 379, 212, 1000.00, '2025-04-03 18:40:01', 'NB', 'SG1358-order_379_1743705578471-1', 'success', '2025-04-03 13:10:01', '2025-04-03 13:10:01', 5, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_379_1743705578471'),
(97, 379, 232, 1000.00, '2025-04-03 19:41:10', 'NB', 'SG1358-order_379_1743709217189-1', 'success', '2025-04-03 14:11:10', '2025-04-03 14:11:10', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_379_1743709217189'),
(98, 379, 238, 1000.00, '2025-04-06 09:44:29', 'NB', 'SG1358-order_379_1743932638311-1', 'success', '2025-04-06 04:14:29', '2025-04-06 04:14:29', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_379_1743932638311'),
(99, 391, 246, 10000.00, '2025-04-09 12:21:46', 'NB', 'SG1358-order_391_1744201287505-1', 'success', '2025-04-09 06:51:46', '2025-04-09 06:51:46', 1, 'ACTIVE', 1.24, 8050, 0, 0.00, 'order_391_1744201287505'),
(100, 391, 247, 5000.00, '2025-04-09 12:49:16', 'NB', 'SG1358-order_391_1744202928901-1', 'success', '2025-04-09 07:19:16', '2025-04-09 07:19:16', 1, 'ACTIVE', 0.62, 8050, 0, 0.00, 'order_391_1744202928901'),
(101, 391, 248, 3000.00, '2025-04-09 13:04:03', 'NB', 'SG1358-order_391_1744203818856-1', 'success', '2025-04-09 07:34:03', '2025-04-09 07:34:03', 1, 'ACTIVE', 0.37, 8050, 0, 0.00, 'order_391_1744203818856'),
(102, 391, 249, 2000.00, '2025-04-09 13:08:53', 'NB', 'SG1358-order_391_1744204108152-1', 'success', '2025-04-09 07:38:53', '2025-04-09 07:38:53', 1, 'ACTIVE', 0.25, 8050, 0, 0.00, 'order_391_1744204108152'),
(103, 379, 251, 10000.00, '2025-04-09 14:59:11', 'NB', 'SG1358-order_379_1744210723138-1', 'success', '2025-04-09 09:29:11', '2025-04-09 09:29:11', 1, 'ACTIVE', 1.24, 8050, 0, 0.00, 'order_379_1744210723138'),
(104, 391, 252, 10000.00, '2025-04-09 15:19:34', 'NB', 'SG1358-order_391_1744211950872-1', 'success', '2025-04-09 09:49:34', '2025-04-09 09:49:34', 1, 'ACTIVE', 1.24, 8050, 0, 0.00, 'order_391_1744211950872'),
(105, 7, 253, 1000.00, '2025-04-10 06:23:28', 'NB', 'SG1358-order_7_1744266188160-1', 'success', '2025-04-10 00:53:28', '2025-04-10 00:53:28', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_7_1744266188160'),
(106, 7, 254, 10000.00, '2025-04-10 06:28:05', 'NB', 'SG1358-order_7_1744266461268-1', 'success', '2025-04-10 00:58:05', '2025-04-10 00:58:05', 1, 'ACTIVE', 1.24, 8050, 0, 0.00, 'order_7_1744266461268'),
(107, 391, 259, 1000.00, '2025-04-10 10:53:57', 'NB', 'SG1358-order_391_1744282296691-1', 'success', '2025-04-10 05:23:57', '2025-04-10 05:23:57', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_391_1744282296691'),
(108, 7, 263, 5000.00, '2025-04-10 11:03:03', 'NB', 'SG1358-order_7_1744282949164-1', 'success', '2025-04-10 05:33:03', '2025-04-10 05:33:03', 1, 'ACTIVE', 0.62, 8050, 0, 0.00, 'order_7_1744282949164'),
(109, 379, 267, 10000.00, '2025-04-11 10:44:17', 'NB', 'SG1358-order_379_1744368224306-1', 'success', '2025-04-11 05:14:17', '2025-04-11 05:14:17', 1, 'ACTIVE', 1.24, 8050, 0, 0.00, 'order_379_1744368224306'),
(110, 379, 269, 10000.00, '2025-04-11 11:11:58', 'NB', 'SG1358-order_379_1744369895216-1', 'success', '2025-04-11 05:41:58', '2025-04-11 05:41:58', 1, 'ACTIVE', 1.24, 8050, 0, 0.00, 'order_379_1744369895216'),
(111, 391, 272, 1000.00, '2025-04-11 11:24:43', 'NB', 'SG1358-order_391_1744370599907-1', 'success', '2025-04-11 05:54:43', '2025-04-11 05:54:43', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_391_1744370599907'),
(112, 391, 280, 1000.00, '2025-04-11 12:06:12', 'NB', 'SG1358-order_391_1744372864946-1', 'success', '2025-04-11 06:36:12', '2025-04-11 06:36:12', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_391_1744372864946'),
(113, 391, 283, 1000.00, '2025-04-11 12:46:17', 'NB', 'SG1358-order_391_1744375505820-1', 'success', '2025-04-11 07:16:17', '2025-04-11 07:16:17', 1, 'ACTIVE', 0.12, 8050, 0, 0.00, 'order_391_1744375505820');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `permission_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `permission_name`, `description`) VALUES
(1, 'create_scheme', 'Create Scheme'),
(2, 'create_chit', 'Create Chits'),
(3, 'delete_scheme', 'Delete Scheme'),
(4, 'update_scheme', 'Update Scheme'),
(5, 'delete_chit', 'Delete Chit'),
(6, 'update_chit', 'Update Chit'),
(7, 'view_payment', 'View payment'),
(8, 'manage_all', 'Full system access'),
(9, 'manage_chits', 'Create/update chits'),
(10, 'manage_schemes', 'Create/update schemes'),
(11, 'manage_branches', 'Create/update branches'),
(12, 'manage_offers', 'Create/update offers'),
(13, 'manage_policies', 'Create/update policies'),
(14, 'manage_rates', 'Create/update rates'),
(15, 'view_schemes', 'View schemes'),
(16, 'view_chits', 'View chits'),
(17, 'view_offers', 'View offers'),
(18, 'view_policies', 'View policies'),
(19, 'deactivate_investment', 'Deactivate investment'),
(20, 'view_rates', 'View rates'),
(21, 'view_investments', 'View investment list');

-- --------------------------------------------------------

--
-- Table structure for table `policies`
--

CREATE TABLE `policies` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `subtitle` varchar(150) DEFAULT NULL,
  `description` text NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `policies`
--

INSERT INTO `policies` (`id`, `type`, `title`, `subtitle`, `description`, `status`, `created_at`, `updated_at`) VALUES
(2, 'our_policy', 'Our Policies', 'Sub title of Our Policies', 'Digi Gold Savings App Policy\r\n\r\nLast Updated: February 27, 2025\r\n\r\n1. Introduction\r\nWelcome to the Digi Gold Savings App (\"App\"). This Policy outlines the terms under which you may access and use our digital platform for buying, saving, and managing digital gold. By using our App, you acknowledge that you have read, understood, and agree to be bound by this Policy. If you disagree with any part of these terms, please refrain from using the App.\r\n\r\n2. Definitions\r\n\r\n\"App\" refers to the Digi Gold Savings mobile application and its associated services.\r\n\"User\" means any individual who accesses or uses the App.\r\n\"Digital Gold\" is a digital representation of physical gold held on your behalf.\r\n\"Transaction\" refers to any purchase, sale, or other operation carried out through the App.\r\n3. User Registration and Eligibility\r\n\r\nYou must be at least 18 years old and legally capable of entering into binding agreements to use the App.\r\nDuring registration, you agree to provide accurate, current, and complete information and to keep your account credentials secure.\r\nUsers are solely responsible for all activities conducted under their account.\r\n4. Digital Gold Transactions\r\n\r\nThe App enables you to purchase and manage digital gold savings. Transactions are executed in real time and are subject to market risks, including price fluctuations in gold.\r\nOnce confirmed, transactions are considered final and cannot be reversed, except as required by applicable law.\r\nAll transactions are processed in accordance with industry standards and regulatory requirements.\r\n5. Fees and Charges\r\n\r\nThe use of our App may incur service fees, transaction fees, or other charges. All applicable fees will be clearly disclosed before you complete any transaction.\r\nBy proceeding with a transaction, you authorize us to deduct any relevant fees from your account.\r\n6. Privacy and Data Security\r\n\r\nWe are committed to protecting your personal information. Please review our Privacy Policy to understand how we collect, use, and secure your data.\r\nBy using the App, you consent to our collection and processing of your information as described in our Privacy Policy.\r\nWe employ industry-standard security measures to safeguard your data, although we cannot guarantee absolute security.\r\n7. Intellectual Property Rights\r\n\r\nAll content within the App, including text, graphics, logos, and software, is the property of Digi Gold Savings or its licensors and is protected by applicable intellectual property laws.\r\nYou agree not to reproduce, modify, or distribute any part of the App without our prior written consent.\r\n8. Limitation of Liability\r\n\r\nDigi Gold Savings and its affiliates shall not be liable for any indirect, incidental, or consequential damages arising from your use of the App.\r\nOur total liability for any claim arising from the use of the App shall not exceed the total fees paid by you in the preceding 12 months.\r\n9. Changes to the Policy\r\n\r\nWe reserve the right to modify or update this Policy at any time. Any changes will be effective immediately upon being posted on the App.\r\nYour continued use of the App after changes are posted signifies your acceptance of the revised Policy.\r\n10. Termination\r\n\r\nWe may suspend or terminate your access to the App if you violate this Policy or if we determine, at our sole discretion, that your use of the App poses a risk to the security, integrity, or proper functioning of our services.\r\n11. Governing Law and Dispute Resolution\r\n\r\nThis Policy is governed by the laws of [Your Country/State].\r\nAny disputes arising under or in connection with this Policy shall be resolved through binding arbitration or in the courts of [Your Country/State], as applicable.\r\n12. Contact Us\r\nIf you have any questions, concerns, or comments about this Policy, please contact our support team at support@digigoldsavings.com.', 'active', '2025-02-27 02:56:48', '2025-02-27 21:03:36'),
(4, 'terms_and_conditions', 'test Terms and conditions ----1', 'test Terms and conditions ----12 subtitle', 'test Terms and conditions ----12test Terms and conditions ----12test Terms and conditions ----12', 'active', '2025-03-08 11:28:13', '2025-03-08 11:28:22'),
(5, 'privacy_policy', '**Privacy Policy**', '**Privacy Policy**', '**Privacy Policy**\n\nEffective Date: 31/12/2025\n\nThank you for using our Gold Savings Scheme and Online Payment platform. We value your trust and are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, and safeguard your information.\n\n**1. Information We Collect**\n\nWe collect the following information when you use our services:\n\n1.1 **Personal Information:**\n- Name, contact number, email address\n- Government-issued identification (for verification purposes)\n- Bank account details and payment information\n\n1.2 **Transaction Information:**\n- Gold savings plan details (e.g., scheme type, tenure, monthly contribution)\n- Payment history, transaction IDs, and payment methods\n\n1.3 **Device and Usage Information:**\n- Device type, operating system, and browser information\n- IP address and geolocation (if enabled)\n- App usage statistics\n\n**2. How We Use Your Information**\n\nWe use your information to:\n\n- Register and manage your gold savings account\n- Process payments and maintain transaction records\n- Communicate important updates and payment reminders\n- Enhance security and prevent fraudulent activities\n- Provide customer support and address inquiries\n- Comply with legal obligations and regulations\n\n**3. Data Sharing and Disclosure**\n\nWe do not sell or share your personal information with third parties for marketing purposes. Your data may be shared with:\n\n- **Payment Processors:** For secure payment transactions (e.g., Razorpay)\n- **Regulatory Authorities:** When required by law or legal processes\n- **Service Providers:** For backend support and system maintenance\n\n**4. Data Retention**\n\nWe retain your data for as long as necessary to fulfill our service commitments and legal obligations. Transaction records may be stored for up to [Insert Duration] years for regulatory compliance.\n\n**5. Security Measures**\n\nWe implement industry-standard security practices to protect your data:\n\n- Encryption of sensitive information\n- Secure payment gateways\n- Access control and authentication\n\n**6. Your Rights and Choices**\n\nYou have the right to:\n\n- Access and review your personal information\n- Update or correct inaccurate data\n- Request data deletion (subject to legal requirements)\n\n**7. Cookies and Tracking Technologies**\n\nOur platform may use cookies to enhance your experience, including session tracking and user preferences. You can manage cookie settings via your browser.\n\n**8. Policy Updates**\n\nWe may update this policy periodically. Any significant changes will be communicated via app notifications or email.\n\n**9. Contact Us**\n\nFor questions regarding this policy, contact us at:\n\n**DC Jewels Support**  \nEmail: [Insert Email]  \nPhone: [Insert Phone Number]\n\n', 'active', '2025-03-10 20:23:34', '2025-03-10 20:51:09');

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE `rates` (
  `id` int(11) NOT NULL,
  `gold_rate` decimal(10,2) NOT NULL,
  `silver_rate` decimal(10,2) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rates`
--

INSERT INTO `rates` (`id`, `gold_rate`, `silver_rate`, `status`, `created_at`, `updated_at`) VALUES
(15, 8040.00, 108.00, 'inactive', '2025-03-09 15:47:07', '2025-03-09 20:37:45'),
(16, 1.00, 1.00, 'inactive', '2025-03-09 20:37:45', '2025-03-10 05:43:08'),
(17, 8050.00, 108.00, 'active', '2025-03-10 05:43:08', '2025-03-10 05:43:08');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `description`) VALUES
(1, 'Admin', 'Manage access for scheme,chits'),
(2, 'Sales Executive	', 'limited access'),
(3, 'Super Admin', 'Able to access all modules'),
(4, 'User', 'Normal Customer'),
(5, 'Branch Manager', 'View Access for Scheme and Chits and mange investments');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `schemes`
--

CREATE TABLE `schemes` (
  `id` int(10) UNSIGNED NOT NULL,
  `SCHEMENAME` varchar(100) NOT NULL,
  `SCHEMETYPE` varchar(50) NOT NULL,
  `SCHEMENO` varchar(10) NOT NULL,
  `REGNO` varchar(10) NOT NULL,
  `ACTIVE` char(1) NOT NULL,
  `BRANCHID` varchar(50) NOT NULL,
  `INS_TYPE` varchar(50) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL,
  `SLOGAN` varchar(255) DEFAULT NULL,
  `IMAGE` varchar(255) DEFAULT NULL,
  `ICON` varchar(255) DEFAULT NULL,
  `type` varchar(23) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `schemes`
--

INSERT INTO `schemes` (`id`, `SCHEMENAME`, `SCHEMETYPE`, `SCHEMENO`, `REGNO`, `ACTIVE`, `BRANCHID`, `INS_TYPE`, `DESCRIPTION`, `SLOGAN`, `IMAGE`, `ICON`, `type`) VALUES
(17, 'ADVANCE PLUS GOLD SCHEME', 'weight', 'DC', '001', 'Y', 'DCJ-1', '001', 'ADVANCE PLUS GOLD SCHEME', '\"Start saving the precious metal\"', '/uploads/scheme1.png', '/uploads/1741537306287-scheme_icon.png', 'gold'),
(18, 'ADVANCE PLUS GOLD SCHEME - 2', 'weight', 'DC-2', '002', 'Y', 'DCJ-1', '002', 'ADVANCE PLUS GOLD SCHEME - 2', '\"Invest in Gold, Secure Your Future.\"', '/uploads/scheme2.png', '/uploads/1741537313764-scheme_2.png', 'gold');

-- --------------------------------------------------------

--
-- Table structure for table `schemesKnowmore`
--

CREATE TABLE `schemesKnowmore` (
  `id` int(11) NOT NULL,
  `scheme_id` int(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `schemesKnowmore`
--

INSERT INTO `schemesKnowmore` (`id`, `scheme_id`, `title`, `subtitle`, `description`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Gold Savings Schemes (or Gold Deposit Schemes)', 'stringThese are typically offered', 'A gold scheme generally refers to an investment or financial plan that allows individuals to invest in gold or benefit from gold-related assets. These schemes are often designed to help people diversify their portfolios, hedge against inflation, or gain exposure to the precious metal. There are various types of gold schemes, ranging from physical gold investments to digital options. Here are some common types of gold schemes:  1. Gold Savings Schemes (or Gold Deposit Schemes) These are typically offered by banks or jewelry retailers where you deposit money regularly (like a recurring deposit) and, at the end of a specified term, you receive an equivalent amount of gold. Example: Many jewelers offer plans where you can save monthly, and after a set period, you get gold based on the amount you\'ve saved. 2. Sovereign Gold Bonds (SGB) Issued by the government, these bonds allow you to invest in gold without physically owning it. The bonds are denominated in grams of gold, and interest is paid periodically. They are a more secure way to invest in gold compared to purchasing physical gold, and there may be tax benefits too. Benefits: No need for physical storage, and you get interest on your investment, typically around 2.5% per annum. 3. Gold ETFs (Exchange-Traded Funds) These are financial products that track the price of gold and can be bought and sold on stock exchanges just like stocks. By purchasing shares in a Gold ETF, you own a fraction of the gold held by the fund. Benefits: Easy trading, no need to worry about storage or security of physical gold. 4. Gold Mutual Funds These funds invest in a portfolio of gold mining companies or gold-related assets. It\'s a more indirect way of investing in gold since you\'re investing in companies involved in the gold sector rather than the gold itself. Benefits: Diversification in the gold sector and potential for capital appreciation beyond just the price of gold. 5. Gold Coins and Bars Direct purchase of gold in the form of coins or bars. This is one of the most traditional ways of investing in gold. Benefits: Tangible asset ownership, easily accessible, and can be resold quickly. 6. Gold-Backed Digital Assets These schemes allow you to invest in digital gold, where the amount you buy is backed by physical gold stored in a secure vault. Benefits: Easy to buy, sell, and track online, with gold backing the asset. 7. Gold Loan Schemes Offered by banks and financial institutions, these schemes allow individuals to take loans against their gold holdings. The gold acts as collateral for the loan. Benefits: You get liquidity without selling your gold. Key Benefits of Gold Schemes: Hedge Against Inflation: Gold often acts as a hedge against inflation, as its value tends to rise during periods of economic instability. Diversification: Including gold in an investment portfolio can reduce risk and volatility. Liquidity: Gold can usually be easily converted into cash, especially when held in forms like ETFs or mutual funds. Security: Certain gold schemes, such as SGBs, provide a safe, government-backed investment, whereas physical gold might need to be stored securely. Points to Consider: Storage and Security: For physical gold, there are concerns about storage and security. Market Volatility: The price of gold can fluctuate, so it\'s important to invest wisely. Tax Implications: Some gold schemes might have tax advantages, while others, especially physical gold, may incur taxes such as capital gains. If you\'re interested in a particular type of gold scheme, such as Gold ETFs or Sovereign Gold Bonds, let me know, and I can provide more detailed information.', '/uploads/1740690410223-glass-bottle-on-beach.jpg', 'active', '2025-02-27 21:06:50', '2025-02-27 21:06:50'),
(2, 2, 'stringtest', 'stringtest', 'string', NULL, 'active', '2025-03-03 15:42:41', '2025-03-04 18:28:15'),
(3, 0, 'string', 'string', 'string', NULL, 'active', '2025-03-03 18:09:48', '2025-03-03 18:09:48'),
(4, 4, 'DC', 'Dc for All', 'All is Well', '/uploads/1741032160838-sidebar.png', 'inactive', '2025-03-03 20:02:40', '2025-03-03 20:02:40'),
(5, 6, '789', '789', '789', '/uploads/1741116339486-avatar-4.jpg', 'active', '2025-03-04 19:25:40', '2025-03-04 19:25:40'),
(6, 16, 'MM test 21 schemes know more 231', 'MM test 21 schemes know more subtitle ', 'Gold schemes in India include the Gold Monetisation Scheme (GMS), Sovereign Gold Bond Scheme, and Gold Coin and Bullion Scheme. These schemes encourage the use of gold for productive purposes, and reduce the country\'s reliance on gold imports. \r\nGold Monetisation Scheme (GMS)\r\nThe GMS was announced in September 2015. \r\nIt combines the Gold Deposit Scheme and the Gold Metal Loan Scheme. \r\nThe scheme allows individuals and organizations to deposit their gold and earn interest. \r\nThe interest rate is decided by the Central Government and notified by the Reserve Bank of India. \r\nThe scheme aims to reduce the country\'s dependency on gold imports. \r\nGold Savings Schemes \r\nGold saving schemes are a secure way to invest in gold.\r\nThey offer bonuses and rewards.\r\nThey can be used to save for weddings, anniversaries, or to diversify a portfolio.\r\nMost schemes range from 10-24 months.\r\nA shorter tenure is better for immediate needs, while longer tenures allow greater accumulation.\r\nBenefits of Gold Schemes \r\nGold schemes allow investors to earn interest on their gold investments.\r\nThey also allow investors to save on gold storage costs.\r\nGold Monetisation Scheme (GMS) - ICICI Bank\r\nResident Indians can deposit gold under Gold Monetisation Scheme. The deposit will be denominated in grams of gold with purity 995...\r\n\r\nICICI Bank\r\nGold Monetisation Scheme (GMS) - ClearTax\r\n18 Feb 2025 — The Government of India announced the Gold Monetisation Scheme (GMS) in September 2015. Under this scheme, people can e...\r\n\r\nClearTax\r\nGold Monetisation Scheme (GMS) - IBEF\r\nIntroduction. In November 2015, the Indian government introduced the Gold Monetisation Scheme (GMS) to bring together gold held by...\r\nIBEF\r\nShow all\r\nGenerative AI is experimental. For financial advice, consult a professional', '/uploads/1741433216176-gettyimages-137509061-612x612.jpg', 'active', '2025-03-08 09:48:48', '2025-03-08 11:27:07');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `investmentId` int(11) NOT NULL,
  `schemeId` int(11) NOT NULL,
  `chitId` int(11) NOT NULL,
  `installment` int(11) NOT NULL,
  `accountNumber` varchar(50) NOT NULL,
  `paymentId` varchar(100) NOT NULL,
  `orderId` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `paymentMethod` varchar(50) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `paymentStatus` varchar(50) NOT NULL,
  `paymentDate` datetime NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('paid','paynow','coming soon') DEFAULT 'coming soon',
  `gatewayTransactionId` varchar(100) NOT NULL,
  `gatewayresponse` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`gatewayresponse`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `userId`, `investmentId`, `schemeId`, `chitId`, `installment`, `accountNumber`, `paymentId`, `orderId`, `amount`, `currency`, `paymentMethod`, `signature`, `paymentStatus`, `paymentDate`, `createdAt`, `updatedAt`, `status`, `gatewayTransactionId`, `gatewayresponse`) VALUES
(29, 379, 158, 17, 12, 1, '101', '1', 'order_379_1742368236480', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-19 07:10:36', '2025-03-19 07:12:29', '2025-03-19 07:12:29', '', 'SG1358-order_379_1742368236480-1', ''),
(30, 379, 160, 17, 12, 1, '103', '1', 'order_379_1742372149946', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-19 08:15:50', '2025-03-19 08:16:10', '2025-03-19 08:16:10', '', 'SG1358-order_379_1742372149946-1', ''),
(31, 379, 160, 17, 12, 2, '103', '1', 'order_379_1742379613059', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-19 10:20:13', '2025-03-19 10:20:40', '2025-03-19 10:20:40', '', 'SG1358-order_379_1742379613059-1', ''),
(32, 379, 163, 18, 13, 1, '106', '1', 'order_379_1742405073622', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-19 17:24:34', '2025-03-19 17:27:18', '2025-03-19 17:27:18', '', 'SG1358-order_379_1742405073622-1', ''),
(33, 379, 164, 18, 13, 1, '107', '1', 'order_379_1742411324337', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-19 19:08:44', '2025-03-19 19:09:04', '2025-03-19 19:09:04', '', 'SG1358-order_379_1742411324337-1', ''),
(34, 3, 168, 18, 13, 1, '111', '0', 'order_3_1742439942233', 1000.00, 'INR', 'CARD_TRANSACTION', '000', 'Canceled', '2025-03-20 03:05:42', '2025-03-20 03:07:16', '2025-03-20 03:07:16', '', 'SG1358-order_3_1742439942233-1', ''),
(35, 3, 167, 17, 12, 1, '110', '0', 'order_3_1742439942233', 1000.00, 'INR', 'CARD_TRANSACTION', '000', 'Canceled', '2025-03-20 03:05:42', '2025-03-20 03:07:16', '2025-03-20 03:07:16', '', 'SG1358-order_3_1742439942233-1', ''),
(36, 3, 169, 17, 12, 1, '112', '0', 'order_3_1742440072072', 1000.00, 'INR', 'CARD_TRANSACTION', '000', 'Canceled', '2025-03-20 03:07:52', '2025-03-20 03:09:15', '2025-03-20 03:09:15', '', 'SG1358-order_3_1742440072072-1', ''),
(37, 3, 170, 17, 12, 1, '113', '0', 'order_3_1742440834037', 1000.00, 'INR', 'CARD_TRANSACTION', '000', 'Canceled', '2025-03-20 03:20:34', '2025-03-20 03:22:23', '2025-03-20 03:22:23', '', 'SG1358-order_3_1742440834037-1', ''),
(38, 3, 171, 17, 12, 1, '114', '1', 'order_3_1742441132122', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-20 03:25:32', '2025-03-20 03:26:06', '2025-03-20 03:26:06', '', 'SG1358-order_3_1742441132122-1', ''),
(39, 3, 172, 18, 13, 1, '115', '1', 'order_3_1742441353579', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-20 03:29:14', '2025-03-20 03:29:33', '2025-03-20 03:29:33', '', 'SG1358-order_3_1742441353579-1', ''),
(40, 379, 173, 18, 13, 1, '116', '1', 'order_379_1742585640065', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-21 19:34:00', '2025-03-21 19:34:21', '2025-03-21 19:34:21', '', 'SG1358-order_379_1742585640065-1', ''),
(41, 387, 174, 17, 12, 1, '117', '1', 'order_387_1742653342742', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-22 14:22:23', '2025-03-22 14:25:25', '2025-03-22 14:25:25', '', 'SG1358-order_387_1742653342742-1', ''),
(42, 3, 176, 18, 13, 1, '119', '1', 'order_3_1742664215496', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-22 17:23:36', '2025-03-22 17:23:56', '2025-03-22 17:23:56', '', 'SG1358-order_3_1742664215496-1', ''),
(43, 379, 181, 17, 12, 1, '124', '1', 'order_379_1743077383534', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-27 12:09:44', '2025-03-27 12:12:09', '2025-03-27 12:12:09', '', 'SG1358-order_379_1743077383534-1', ''),
(44, 379, 182, 18, 13, 1, '125', '1', 'order_379_1743081395074', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-27 13:16:35', '2025-03-27 13:17:26', '2025-03-27 13:17:26', '', 'SG1358-order_379_1743081395074-1', ''),
(45, 379, 183, 17, 12, 1, '126', '1', 'order_379_1743084470978', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-27 14:07:51', '2025-03-27 14:08:18', '2025-03-27 14:08:18', '', 'SG1358-order_379_1743084470978-1', ''),
(46, 379, 193, 17, 12, 1, '136', '1', 'order_379_1743088966316', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-27 15:22:46', '2025-03-27 15:24:47', '2025-03-27 15:24:47', '', 'SG1358-order_379_1743088966316-1', ''),
(47, 379, 210, 17, 12, 1, '153', '1', 'order_379_1743157555170', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-28 10:25:55', '2025-03-28 10:28:00', '2025-03-28 10:28:00', '', 'SG1358-order_379_1743157555170-1', ''),
(48, 379, 211, 17, 12, 1, '154', '1', 'order_379_1743157915646', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-28 10:31:56', '2025-03-28 10:33:06', '2025-03-28 10:33:06', '', 'SG1358-order_379_1743157915646-1', ''),
(49, 379, 212, 17, 12, 1, '155', '1', 'order_379_1743158415886', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-28 10:40:16', '2025-03-28 10:41:03', '2025-03-28 10:41:03', '', 'SG1358-order_379_1743158415886-1', ''),
(50, 381, 213, 17, 12, 1, '156', '1', 'order_381_1743158681550', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-28 10:44:42', '2025-03-28 10:45:25', '2025-03-28 10:45:25', '', 'SG1358-order_381_1743158681550-1', ''),
(51, 381, 215, 17, 12, 1, '158', '1', 'order_381_1743161614570', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-03-28 11:33:35', '2025-03-28 11:34:33', '2025-03-28 11:34:33', '', 'SG1358-order_381_1743161614570-1', ''),
(52, 381, 229, 17, 12, 1, '171', '1', 'order_381_1743702430132', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-03 17:47:10', '2025-04-03 17:47:36', '2025-04-03 17:47:36', '', 'SG1358-order_381_1743702430132-1', '{\"orderId\":\"order_381_1743702430132\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohan@gmail.com\",\"customer_phone\":\"6381279295\",\"customer_id\":\"381\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_b2f1d2849851459b8bc777fbc3a44438\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_381_1743702430132\",\"date_created\":\"2025-04-03T17:47:10Z\",\"last_updated\":\"2025-04-03T17:47:31Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_b2f1d2849851459b8bc777fbc3a44438\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_b2f1d2849851459b8bc777fbc3a44438\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_b2f1d2849851459b8bc777fbc3a44438\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_381_1743702430132-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz91zbHrq6MbSnzALF\",\"txn_detail\":{\"txn_id\":\"SG1358-order_381_1743702430132-1\",\"order_id\":\"order_381_1743702430132\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz91zbHrq6MbSnzALF\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-03T17:47:23Z\",\"last_updated\":\"2025-04-03T17:47:31Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs4f93b5829e05\",\"created\":\"2025-04-03T17:47:31Z\",\"epg_txn_id\":\"314012829221\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs4f93b5829e05\",\"txn_id\":\"SG1358-order_381_1743702430132-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-03T18:02:10Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 03 Apr 2025 17:47:33 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"101\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"4a255493-f09c-457a-8587-15182ca83f55\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_381_1743702430132\",\"x-jp-txn-uuid\":\"moz91zbHrq6MbSnzALF\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 ed149c4696419c0643fab13e9539b16c.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA60-P5\",\"x-amz-cf-id\":\"t7kKqgfZLyEEb6QHw52eovuAdfEgEBm4he6S0YKQYhduaiCG6tPuwA==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92aa64491e619bb8-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 03 Apr 2025 17:47:33 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"101\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"4a255493-f09c-457a-8587-15182ca83f55\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_381_1743702430132\"],\"x-jp-txn-uuid\":[\"moz91zbHrq6MbSnzALF\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 ed149c4696419c0643fab13e9539b16c.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA60-P5\"],\"x-amz-cf-id\":[\"t7kKqgfZLyEEb6QHw52eovuAdfEgEBm4he6S0YKQYhduaiCG6tPuwA==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92aa64491e619bb8-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 03 Apr 2025 17:47:33 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"101\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"4a255493-f09c-457a-8587-15182ca83f55\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_381_1743702430132\",\"x-jp-txn-uuid\",\"moz91zbHrq6MbSnzALF\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 ed149c4696419c0643fab13e9539b16c.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA60-P5\",\"x-amz-cf-id\",\"t7kKqgfZLyEEb6QHw52eovuAdfEgEBm4he6S0YKQYhduaiCG6tPuwA==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92aa64491e619bb8-FRA\"],\"statusMessage\":\"OK\"}}}'),
(53, 381, 230, 17, 12, 1, '172', '1', 'order_381_1743702803152', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-03 17:53:23', '2025-04-03 17:53:45', '2025-04-03 17:53:45', '', 'SG1358-order_381_1743702803152-1', '{\"orderId\":\"order_381_1743702803152\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohan@gmail.com\",\"customer_phone\":\"6381279295\",\"customer_id\":\"381\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_6be6b8147290489488680ba504bb9bd6\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_381_1743702803152\",\"date_created\":\"2025-04-03T17:53:23Z\",\"last_updated\":\"2025-04-03T17:53:42Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_6be6b8147290489488680ba504bb9bd6\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_6be6b8147290489488680ba504bb9bd6\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_6be6b8147290489488680ba504bb9bd6\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_381_1743702803152-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozx32XaSjceWrh9LqC\",\"txn_detail\":{\"txn_id\":\"SG1358-order_381_1743702803152-1\",\"order_id\":\"order_381_1743702803152\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozx32XaSjceWrh9LqC\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-03T17:53:34Z\",\"last_updated\":\"2025-04-03T17:53:42Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bsb4423428d224\",\"created\":\"2025-04-03T17:53:42Z\",\"epg_txn_id\":\"314012829229\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bsb4423428d224\",\"txn_id\":\"SG1358-order_381_1743702803152-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-03T18:08:23Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 03 Apr 2025 17:53:44 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"100\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"4a328bb6-5ff7-481d-9314-f6e318fc9d44\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_381_1743702803152\",\"x-jp-txn-uuid\":\"mozx32XaSjceWrh9LqC\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 4d156fc02c81ad97b906c107779265e2.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA60-P5\",\"x-amz-cf-id\":\"GIvAFHyi_8ckNYmygFNaBDBdvcTRxG3uTtGGH4skPSp77z-0DTYsrg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92aa6d575ed6bb95-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 03 Apr 2025 17:53:44 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"100\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"4a328bb6-5ff7-481d-9314-f6e318fc9d44\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_381_1743702803152\"],\"x-jp-txn-uuid\":[\"mozx32XaSjceWrh9LqC\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 4d156fc02c81ad97b906c107779265e2.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA60-P5\"],\"x-amz-cf-id\":[\"GIvAFHyi_8ckNYmygFNaBDBdvcTRxG3uTtGGH4skPSp77z-0DTYsrg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92aa6d575ed6bb95-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 03 Apr 2025 17:53:44 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"100\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"4a328bb6-5ff7-481d-9314-f6e318fc9d44\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_381_1743702803152\",\"x-jp-txn-uuid\",\"mozx32XaSjceWrh9LqC\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 4d156fc02c81ad97b906c107779265e2.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA60-P5\",\"x-amz-cf-id\",\"GIvAFHyi_8ckNYmygFNaBDBdvcTRxG3uTtGGH4skPSp77z-0DTYsrg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92aa6d575ed6bb95-FRA\"],\"statusMessage\":\"OK\"}}}'),
(54, 379, 212, 17, 12, 2, '155', '1', 'order_379_1743704993822', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-03 18:29:54', '2025-04-03 18:30:30', '2025-04-03 18:30:30', '', 'SG1358-order_379_1743704993822-1', '{\"orderId\":\"order_379_1743704993822\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_aba5ffdee6c94b1ebee5bd4b0acbf0da\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_379_1743704993822\",\"date_created\":\"2025-04-03T18:29:54Z\",\"last_updated\":\"2025-04-03T18:30:27Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_aba5ffdee6c94b1ebee5bd4b0acbf0da\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_aba5ffdee6c94b1ebee5bd4b0acbf0da\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_aba5ffdee6c94b1ebee5bd4b0acbf0da\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1743704993822-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozurKbiLu4EvcL91oj\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1743704993822-1\",\"order_id\":\"order_379_1743704993822\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozurKbiLu4EvcL91oj\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-03T18:30:18Z\",\"last_updated\":\"2025-04-03T18:30:27Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs00ed3c72a8c9\",\"created\":\"2025-04-03T18:30:27Z\",\"epg_txn_id\":\"314012829244\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs00ed3c72a8c9\",\"txn_id\":\"SG1358-order_379_1743704993822-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-03T18:44:54Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 03 Apr 2025 18:30:28 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"141\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"e72be317-6d5e-449d-a526-0d40fd6105f8\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1743704993822\",\"x-jp-txn-uuid\":\"mozurKbiLu4EvcL91oj\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 d147b4a7fe31d4e8683f7d8b15b71906.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA60-P5\",\"x-amz-cf-id\":\"eg2vzPcToU-IWtWKy_KAnRlZXc8M7JCGukL7ljQgYlSgkC0-Orjw4w==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92aaa32c7db0e86b-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 03 Apr 2025 18:30:28 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"141\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"e72be317-6d5e-449d-a526-0d40fd6105f8\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1743704993822\"],\"x-jp-txn-uuid\":[\"mozurKbiLu4EvcL91oj\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 d147b4a7fe31d4e8683f7d8b15b71906.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA60-P5\"],\"x-amz-cf-id\":[\"eg2vzPcToU-IWtWKy_KAnRlZXc8M7JCGukL7ljQgYlSgkC0-Orjw4w==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92aaa32c7db0e86b-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 03 Apr 2025 18:30:28 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"141\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"e72be317-6d5e-449d-a526-0d40fd6105f8\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1743704993822\",\"x-jp-txn-uuid\",\"mozurKbiLu4EvcL91oj\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 d147b4a7fe31d4e8683f7d8b15b71906.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA60-P5\",\"x-amz-cf-id\",\"eg2vzPcToU-IWtWKy_KAnRlZXc8M7JCGukL7ljQgYlSgkC0-Orjw4w==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92aaa32c7db0e86b-FRA\"],\"statusMessage\":\"OK\"}}}'),
(55, 379, 212, 17, 12, 3, '155', '1', 'order_379_1743705112841', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-03 18:31:54', '2025-04-03 18:32:15', '2025-04-03 18:32:15', '', 'SG1358-order_379_1743705112841-1', '{\"orderId\":\"order_379_1743705112841\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_d951bbf90d0143e2a21f9fbc5acd640a\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_379_1743705112841\",\"date_created\":\"2025-04-03T18:31:54Z\",\"last_updated\":\"2025-04-03T18:32:12Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_d951bbf90d0143e2a21f9fbc5acd640a\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_d951bbf90d0143e2a21f9fbc5acd640a\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_d951bbf90d0143e2a21f9fbc5acd640a\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1743705112841-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozg2kEekxHBJ6Sqdt3\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1743705112841-1\",\"order_id\":\"order_379_1743705112841\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozg2kEekxHBJ6Sqdt3\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-03T18:32:03Z\",\"last_updated\":\"2025-04-03T18:32:12Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bscad751c48fab\",\"created\":\"2025-04-03T18:32:12Z\",\"epg_txn_id\":\"314012829245\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bscad751c48fab\",\"txn_id\":\"SG1358-order_379_1743705112841-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-03T18:46:54Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 03 Apr 2025 18:32:14 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"95\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"3d0f01cc-476b-4318-8cd1-a85ec7c07b26\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1743705112841\",\"x-jp-txn-uuid\":\"mozg2kEekxHBJ6Sqdt3\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 c554699ee704a19f7545cb8005037198.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"CDG52-P2\",\"x-amz-cf-id\":\"0q_SrfrGYFMx3iyyZiwkeLKD5VQyuf2QudYSVw6kLYp0urZtVWm-5A==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92aaa5bc6e865d96-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 03 Apr 2025 18:32:14 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"95\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"3d0f01cc-476b-4318-8cd1-a85ec7c07b26\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1743705112841\"],\"x-jp-txn-uuid\":[\"mozg2kEekxHBJ6Sqdt3\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 c554699ee704a19f7545cb8005037198.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"CDG52-P2\"],\"x-amz-cf-id\":[\"0q_SrfrGYFMx3iyyZiwkeLKD5VQyuf2QudYSVw6kLYp0urZtVWm-5A==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92aaa5bc6e865d96-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 03 Apr 2025 18:32:14 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"95\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"3d0f01cc-476b-4318-8cd1-a85ec7c07b26\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1743705112841\",\"x-jp-txn-uuid\",\"mozg2kEekxHBJ6Sqdt3\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 c554699ee704a19f7545cb8005037198.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"CDG52-P2\",\"x-amz-cf-id\",\"0q_SrfrGYFMx3iyyZiwkeLKD5VQyuf2QudYSVw6kLYp0urZtVWm-5A==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92aaa5bc6e865d96-FRA\"],\"statusMessage\":\"OK\"}}}'),
(56, 379, 212, 17, 12, 4, '155', '96', 'order_379_1743705578471', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-03 18:39:38', '2025-04-03 18:40:03', '2025-04-03 18:40:03', '', 'SG1358-order_379_1743705578471-1', '{\"orderId\":\"order_379_1743705578471\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_5e48b8bb7ebf4a49912cccb236b482b5\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_379_1743705578471\",\"date_created\":\"2025-04-03T18:39:38Z\",\"last_updated\":\"2025-04-03T18:39:59Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_5e48b8bb7ebf4a49912cccb236b482b5\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_5e48b8bb7ebf4a49912cccb236b482b5\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_5e48b8bb7ebf4a49912cccb236b482b5\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1743705578471-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz5QDCvqUruiBDznQW\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1743705578471-1\",\"order_id\":\"order_379_1743705578471\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz5QDCvqUruiBDznQW\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-03T18:39:51Z\",\"last_updated\":\"2025-04-03T18:39:59Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs62dbfddb011c\",\"created\":\"2025-04-03T18:39:59Z\",\"epg_txn_id\":\"314012829249\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs62dbfddb011c\",\"txn_id\":\"SG1358-order_379_1743705578471-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-03T18:54:38Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 03 Apr 2025 18:40:01 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"138\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"7aaf3f76-4194-4ce5-b070-d0a6d2c9fd6d\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1743705578471\",\"x-jp-txn-uuid\":\"moz5QDCvqUruiBDznQW\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 ce0a6880f9416cb3a7b5da0d937e47be.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA60-P5\",\"x-amz-cf-id\":\"8aA1w0MGlpKogWuzygacqquhyrKmvB1hfP6DaKcKNO905AhNQw0KBA==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92aab125afcad232-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 03 Apr 2025 18:40:01 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"138\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"7aaf3f76-4194-4ce5-b070-d0a6d2c9fd6d\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1743705578471\"],\"x-jp-txn-uuid\":[\"moz5QDCvqUruiBDznQW\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 ce0a6880f9416cb3a7b5da0d937e47be.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA60-P5\"],\"x-amz-cf-id\":[\"8aA1w0MGlpKogWuzygacqquhyrKmvB1hfP6DaKcKNO905AhNQw0KBA==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92aab125afcad232-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 03 Apr 2025 18:40:01 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"138\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"7aaf3f76-4194-4ce5-b070-d0a6d2c9fd6d\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1743705578471\",\"x-jp-txn-uuid\",\"moz5QDCvqUruiBDznQW\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 ce0a6880f9416cb3a7b5da0d937e47be.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA60-P5\",\"x-amz-cf-id\",\"8aA1w0MGlpKogWuzygacqquhyrKmvB1hfP6DaKcKNO905AhNQw0KBA==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92aab125afcad232-FRA\"],\"statusMessage\":\"OK\"}}}');
INSERT INTO `transactions` (`id`, `userId`, `investmentId`, `schemeId`, `chitId`, `installment`, `accountNumber`, `paymentId`, `orderId`, `amount`, `currency`, `paymentMethod`, `signature`, `paymentStatus`, `paymentDate`, `createdAt`, `updatedAt`, `status`, `gatewayTransactionId`, `gatewayresponse`) VALUES
(57, 379, 232, 17, 12, 1, '174', '97', 'order_379_1743709217189', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-03 19:40:17', '2025-04-03 19:41:11', '2025-04-03 19:41:11', '', 'SG1358-order_379_1743709217189-1', '{\"orderId\":\"order_379_1743709217189\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_1b1df65e9f04453fb0360c2685a6090b\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_379_1743709217189\",\"date_created\":\"2025-04-03T19:40:17Z\",\"last_updated\":\"2025-04-03T19:41:08Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_1b1df65e9f04453fb0360c2685a6090b\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_1b1df65e9f04453fb0360c2685a6090b\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_1b1df65e9f04453fb0360c2685a6090b\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1743709217189-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozrHyPweC5b87FLuEF\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1743709217189-1\",\"order_id\":\"order_379_1743709217189\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozrHyPweC5b87FLuEF\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-03T19:40:31Z\",\"last_updated\":\"2025-04-03T19:41:08Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs7460e3549eda\",\"created\":\"2025-04-03T19:41:08Z\",\"epg_txn_id\":\"314012829268\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs7460e3549eda\",\"txn_id\":\"SG1358-order_379_1743709217189-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-03T19:55:17Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 03 Apr 2025 19:41:10 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"112\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"c603c3ec-7fb8-4bad-a124-2c2f1a3a5245\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1743709217189\",\"x-jp-txn-uuid\":\"mozrHyPweC5b87FLuEF\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 b99111dfd026a3c99d0e66063beb0544.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA60-P5\",\"x-amz-cf-id\":\"F7EwLFp9J38B_0xxrq-q0QRKolCDiAXi-HhRzn1kDRyiVgCgiSVGwA==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92ab0aba8980377b-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 03 Apr 2025 19:41:10 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"112\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"c603c3ec-7fb8-4bad-a124-2c2f1a3a5245\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1743709217189\"],\"x-jp-txn-uuid\":[\"mozrHyPweC5b87FLuEF\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 b99111dfd026a3c99d0e66063beb0544.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA60-P5\"],\"x-amz-cf-id\":[\"F7EwLFp9J38B_0xxrq-q0QRKolCDiAXi-HhRzn1kDRyiVgCgiSVGwA==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92ab0aba8980377b-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 03 Apr 2025 19:41:10 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"112\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"c603c3ec-7fb8-4bad-a124-2c2f1a3a5245\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1743709217189\",\"x-jp-txn-uuid\",\"mozrHyPweC5b87FLuEF\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 b99111dfd026a3c99d0e66063beb0544.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA60-P5\",\"x-amz-cf-id\",\"F7EwLFp9J38B_0xxrq-q0QRKolCDiAXi-HhRzn1kDRyiVgCgiSVGwA==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92ab0aba8980377b-FRA\"],\"statusMessage\":\"OK\"}}}'),
(58, 379, 238, 17, 12, 1, '180', '98', 'order_379_1743932638311', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-06 09:43:58', '2025-04-06 09:44:30', '2025-04-06 09:44:30', '', 'SG1358-order_379_1743932638311-1', '{\"orderId\":\"order_379_1743932638311\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_f6187db9d27e4b89a9841a78f5dbd762\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_379_1743932638311\",\"date_created\":\"2025-04-06T09:43:58Z\",\"last_updated\":\"2025-04-06T09:44:27Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f6187db9d27e4b89a9841a78f5dbd762\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f6187db9d27e4b89a9841a78f5dbd762\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f6187db9d27e4b89a9841a78f5dbd762\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1743932638311-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz9KKuuS8N27FqMoa4\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1743932638311-1\",\"order_id\":\"order_379_1743932638311\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz9KKuuS8N27FqMoa4\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-06T09:44:15Z\",\"last_updated\":\"2025-04-06T09:44:27Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs1f75c3bc356c\",\"created\":\"2025-04-06T09:44:27Z\",\"epg_txn_id\":\"314012833922\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs1f75c3bc356c\",\"txn_id\":\"SG1358-order_379_1743932638311-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-06T09:58:58Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Sun, 06 Apr 2025 09:44:28 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"145\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"2b14e06d-5acb-40a6-9f8e-ef541b6898d0\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1743932638311\",\"x-jp-txn-uuid\":\"moz9KKuuS8N27FqMoa4\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 4d156fc02c81ad97b906c107779265e2.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA60-P5\",\"x-amz-cf-id\":\"afSnxpvkfiAE8HIDKYSDaIk8Wbw3UmxgsKlvOqKW5KNhMcIXp8k94Q==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92c058c8b8714dcc-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Sun, 06 Apr 2025 09:44:28 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"145\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"2b14e06d-5acb-40a6-9f8e-ef541b6898d0\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1743932638311\"],\"x-jp-txn-uuid\":[\"moz9KKuuS8N27FqMoa4\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 4d156fc02c81ad97b906c107779265e2.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA60-P5\"],\"x-amz-cf-id\":[\"afSnxpvkfiAE8HIDKYSDaIk8Wbw3UmxgsKlvOqKW5KNhMcIXp8k94Q==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92c058c8b8714dcc-FRA\"]},\"rawHeaders\":[\"Date\",\"Sun, 06 Apr 2025 09:44:28 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"145\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"2b14e06d-5acb-40a6-9f8e-ef541b6898d0\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1743932638311\",\"x-jp-txn-uuid\",\"moz9KKuuS8N27FqMoa4\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 4d156fc02c81ad97b906c107779265e2.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA60-P5\",\"x-amz-cf-id\",\"afSnxpvkfiAE8HIDKYSDaIk8Wbw3UmxgsKlvOqKW5KNhMcIXp8k94Q==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92c058c8b8714dcc-FRA\"],\"statusMessage\":\"OK\"}}}'),
(59, 391, 246, 17, 21, 1, '108', '99', 'order_391_1744201287505', 10000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-09 12:21:27', '2025-04-09 12:21:47', '2025-04-09 12:21:47', '', 'SG1358-order_391_1744201287505-1', '{\"orderId\":\"order_391_1744201287505\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_de633418a61842cab97b270d3c071460\",\"merchant_id\":\"SG1358\",\"amount\":10000,\"currency\":\"INR\",\"order_id\":\"order_391_1744201287505\",\"date_created\":\"2025-04-09T12:21:27Z\",\"last_updated\":\"2025-04-09T12:21:44Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_de633418a61842cab97b270d3c071460\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_de633418a61842cab97b270d3c071460\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_de633418a61842cab97b270d3c071460\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744201287505-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":10000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozfw3nnhQJYvT44dpW\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744201287505-1\",\"order_id\":\"order_391_1744201287505\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":10000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":10000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozfw3nnhQJYvT44dpW\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-09T12:21:36Z\",\"last_updated\":\"2025-04-09T12:21:44Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":10000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bsa9725c8bd317\",\"created\":\"2025-04-09T12:21:44Z\",\"epg_txn_id\":\"314012846523\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bsa9725c8bd317\",\"txn_id\":\"SG1358-order_391_1744201287505-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":10000,\"order_expiry\":\"2025-04-09T12:36:27Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Wed, 09 Apr 2025 12:21:46 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"93\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"2cc789ef-9acb-4a9d-846e-942edd95f0a6\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744201287505\",\"x-jp-txn-uuid\":\"mozfw3nnhQJYvT44dpW\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 8027798dc40af04392a940303e0fc516.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"Eg147AhOYecXguRoZppConniFGo1bRtnXwUL1LFfifs55et6zr6EwA==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92d9f7506e04ffed-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Wed, 09 Apr 2025 12:21:46 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"93\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"2cc789ef-9acb-4a9d-846e-942edd95f0a6\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744201287505\"],\"x-jp-txn-uuid\":[\"mozfw3nnhQJYvT44dpW\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 8027798dc40af04392a940303e0fc516.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"Eg147AhOYecXguRoZppConniFGo1bRtnXwUL1LFfifs55et6zr6EwA==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92d9f7506e04ffed-FRA\"]},\"rawHeaders\":[\"Date\",\"Wed, 09 Apr 2025 12:21:46 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"93\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"2cc789ef-9acb-4a9d-846e-942edd95f0a6\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744201287505\",\"x-jp-txn-uuid\",\"mozfw3nnhQJYvT44dpW\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 8027798dc40af04392a940303e0fc516.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"Eg147AhOYecXguRoZppConniFGo1bRtnXwUL1LFfifs55et6zr6EwA==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92d9f7506e04ffed-FRA\"],\"statusMessage\":\"OK\"}}}'),
(60, 391, 247, 18, 19, 1, '109', '100', 'order_391_1744202928901', 5000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-09 12:48:49', '2025-04-09 12:49:17', '2025-04-09 12:49:17', '', 'SG1358-order_391_1744202928901-1', '{\"orderId\":\"order_391_1744202928901\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_dfa63c1177374c83b679697b987253d7\",\"merchant_id\":\"SG1358\",\"amount\":5000,\"currency\":\"INR\",\"order_id\":\"order_391_1744202928901\",\"date_created\":\"2025-04-09T12:48:49Z\",\"last_updated\":\"2025-04-09T12:49:13Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_dfa63c1177374c83b679697b987253d7\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_dfa63c1177374c83b679697b987253d7\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_dfa63c1177374c83b679697b987253d7\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744202928901-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":5000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz8QEoUTUKYKijGPeL\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744202928901-1\",\"order_id\":\"order_391_1744202928901\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":5000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":5000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz8QEoUTUKYKijGPeL\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-09T12:49:05Z\",\"last_updated\":\"2025-04-09T12:49:13Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":5000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs1fbd389bfb1a\",\"created\":\"2025-04-09T12:49:13Z\",\"epg_txn_id\":\"314012846681\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs1fbd389bfb1a\",\"txn_id\":\"SG1358-order_391_1744202928901-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":5000,\"order_expiry\":\"2025-04-09T13:03:49Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Wed, 09 Apr 2025 12:49:15 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"100\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"47b5d753-1ab2-423f-bae5-3c4da65a60c7\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744202928901\",\"x-jp-txn-uuid\":\"moz8QEoUTUKYKijGPeL\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 a99407071c3f2a96a40fff2cd5775d8e.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"rScOJmeR_QMKFoMEV6k4Dxcc6aguPYzWIQk_hZB3N3P9B9uFbs3L1Q==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92da1f961d11dcc0-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Wed, 09 Apr 2025 12:49:15 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"100\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"47b5d753-1ab2-423f-bae5-3c4da65a60c7\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744202928901\"],\"x-jp-txn-uuid\":[\"moz8QEoUTUKYKijGPeL\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 a99407071c3f2a96a40fff2cd5775d8e.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"rScOJmeR_QMKFoMEV6k4Dxcc6aguPYzWIQk_hZB3N3P9B9uFbs3L1Q==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92da1f961d11dcc0-FRA\"]},\"rawHeaders\":[\"Date\",\"Wed, 09 Apr 2025 12:49:15 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"100\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"47b5d753-1ab2-423f-bae5-3c4da65a60c7\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744202928901\",\"x-jp-txn-uuid\",\"moz8QEoUTUKYKijGPeL\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 a99407071c3f2a96a40fff2cd5775d8e.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"rScOJmeR_QMKFoMEV6k4Dxcc6aguPYzWIQk_hZB3N3P9B9uFbs3L1Q==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92da1f961d11dcc0-FRA\"],\"statusMessage\":\"OK\"}}}'),
(61, 391, 248, 17, 17, 1, '110', '101', 'order_391_1744203818856', 3000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-09 13:03:39', '2025-04-09 13:04:05', '2025-04-09 13:04:05', '', 'SG1358-order_391_1744203818856-1', '{\"orderId\":\"order_391_1744203818856\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_5b5bfc518df1445cb1e471443473c568\",\"merchant_id\":\"SG1358\",\"amount\":3000,\"currency\":\"INR\",\"order_id\":\"order_391_1744203818856\",\"date_created\":\"2025-04-09T13:03:39Z\",\"last_updated\":\"2025-04-09T13:04:01Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_5b5bfc518df1445cb1e471443473c568\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_5b5bfc518df1445cb1e471443473c568\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_5b5bfc518df1445cb1e471443473c568\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744203818856-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":3000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozJiihpjvaKinHX1Kp\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744203818856-1\",\"order_id\":\"order_391_1744203818856\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":3000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":3000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozJiihpjvaKinHX1Kp\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-09T13:03:53Z\",\"last_updated\":\"2025-04-09T13:04:01Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":3000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs341eca25b02c\",\"created\":\"2025-04-09T13:04:01Z\",\"epg_txn_id\":\"314012846770\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs341eca25b02c\",\"txn_id\":\"SG1358-order_391_1744203818856-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":3000,\"order_expiry\":\"2025-04-09T13:18:39Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Wed, 09 Apr 2025 13:04:03 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"90\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"245c92bf-dc40-4fb5-a501-81bae7c5fb2d\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744203818856\",\"x-jp-txn-uuid\":\"mozJiihpjvaKinHX1Kp\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 161bb6093ee10b11ad6a8a23b3138bee.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"ik12xexMEjEnyaWsF_FXUkaj9WApuuCJQimvrghqQrKXWKBxCREx2w==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92da353f8e6edc70-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Wed, 09 Apr 2025 13:04:03 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"90\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"245c92bf-dc40-4fb5-a501-81bae7c5fb2d\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744203818856\"],\"x-jp-txn-uuid\":[\"mozJiihpjvaKinHX1Kp\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 161bb6093ee10b11ad6a8a23b3138bee.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"ik12xexMEjEnyaWsF_FXUkaj9WApuuCJQimvrghqQrKXWKBxCREx2w==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92da353f8e6edc70-FRA\"]},\"rawHeaders\":[\"Date\",\"Wed, 09 Apr 2025 13:04:03 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"90\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"245c92bf-dc40-4fb5-a501-81bae7c5fb2d\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744203818856\",\"x-jp-txn-uuid\",\"mozJiihpjvaKinHX1Kp\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 161bb6093ee10b11ad6a8a23b3138bee.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"ik12xexMEjEnyaWsF_FXUkaj9WApuuCJQimvrghqQrKXWKBxCREx2w==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92da353f8e6edc70-FRA\"],\"statusMessage\":\"OK\"}}}'),
(62, 391, 249, 17, 15, 1, '111', '102', 'order_391_1744204108152', 2000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-09 13:08:29', '2025-04-09 13:08:54', '2025-04-09 13:08:54', '', 'SG1358-order_391_1744204108152-1', '{\"orderId\":\"order_391_1744204108152\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_6a3778759965442184bbb05fe60b5a70\",\"merchant_id\":\"SG1358\",\"amount\":2000,\"currency\":\"INR\",\"order_id\":\"order_391_1744204108152\",\"date_created\":\"2025-04-09T13:08:29Z\",\"last_updated\":\"2025-04-09T13:08:51Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_6a3778759965442184bbb05fe60b5a70\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_6a3778759965442184bbb05fe60b5a70\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_6a3778759965442184bbb05fe60b5a70\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744204108152-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":2000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozxdxBUWK8XNcBy1z2\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744204108152-1\",\"order_id\":\"order_391_1744204108152\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":2000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":2000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozxdxBUWK8XNcBy1z2\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-09T13:08:43Z\",\"last_updated\":\"2025-04-09T13:08:51Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":2000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs4bb947787378\",\"created\":\"2025-04-09T13:08:51Z\",\"epg_txn_id\":\"314012846787\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs4bb947787378\",\"txn_id\":\"SG1358-order_391_1744204108152-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":2000,\"order_expiry\":\"2025-04-09T13:23:29Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Wed, 09 Apr 2025 13:08:53 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"97\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"ecf4872d-a522-49d9-b35d-024e099e41ca\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744204108152\",\"x-jp-txn-uuid\":\"mozxdxBUWK8XNcBy1z2\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 df11b13b779c62601ca4cd4d2bb0ce18.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"1114RoEr-zkbsZdUEgX5lHwZcQMxTmB3pgm8BBV16hxwARKcPtZgYg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92da3c55dd2b8f36-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Wed, 09 Apr 2025 13:08:53 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"97\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"ecf4872d-a522-49d9-b35d-024e099e41ca\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744204108152\"],\"x-jp-txn-uuid\":[\"mozxdxBUWK8XNcBy1z2\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 df11b13b779c62601ca4cd4d2bb0ce18.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"1114RoEr-zkbsZdUEgX5lHwZcQMxTmB3pgm8BBV16hxwARKcPtZgYg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92da3c55dd2b8f36-FRA\"]},\"rawHeaders\":[\"Date\",\"Wed, 09 Apr 2025 13:08:53 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"97\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"ecf4872d-a522-49d9-b35d-024e099e41ca\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744204108152\",\"x-jp-txn-uuid\",\"mozxdxBUWK8XNcBy1z2\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 df11b13b779c62601ca4cd4d2bb0ce18.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"1114RoEr-zkbsZdUEgX5lHwZcQMxTmB3pgm8BBV16hxwARKcPtZgYg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92da3c55dd2b8f36-FRA\"],\"statusMessage\":\"OK\"}}}');
INSERT INTO `transactions` (`id`, `userId`, `investmentId`, `schemeId`, `chitId`, `installment`, `accountNumber`, `paymentId`, `orderId`, `amount`, `currency`, `paymentMethod`, `signature`, `paymentStatus`, `paymentDate`, `createdAt`, `updatedAt`, `status`, `gatewayTransactionId`, `gatewayresponse`) VALUES
(63, 379, 251, 17, 21, 1, '113', '103', 'order_379_1744210723138', 10000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-09 14:58:43', '2025-04-09 14:59:13', '2025-04-09 14:59:13', '', 'SG1358-order_379_1744210723138-1', '{\"orderId\":\"order_379_1744210723138\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_73cbf5f1943045a38c8e8ce7e58e7a92\",\"merchant_id\":\"SG1358\",\"amount\":10000,\"currency\":\"INR\",\"order_id\":\"order_379_1744210723138\",\"date_created\":\"2025-04-09T14:58:43Z\",\"last_updated\":\"2025-04-09T14:59:09Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_73cbf5f1943045a38c8e8ce7e58e7a92\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_73cbf5f1943045a38c8e8ce7e58e7a92\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_73cbf5f1943045a38c8e8ce7e58e7a92\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1744210723138-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":10000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz7ANtagyzmXECzDnE\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1744210723138-1\",\"order_id\":\"order_379_1744210723138\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":10000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":10000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz7ANtagyzmXECzDnE\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-09T14:59:01Z\",\"last_updated\":\"2025-04-09T14:59:09Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":10000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs9f1abe18b8f7\",\"created\":\"2025-04-09T14:59:09Z\",\"epg_txn_id\":\"314012848365\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs9f1abe18b8f7\",\"txn_id\":\"SG1358-order_379_1744210723138-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":10000,\"order_expiry\":\"2025-04-09T15:13:43Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Wed, 09 Apr 2025 14:59:11 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"81\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"c257a31d-b7c8-4afb-903d-0099b5e30beb\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1744210723138\",\"x-jp-txn-uuid\":\"moz7ANtagyzmXECzDnE\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 89d30ce8a4c37b9d11d7f552521193ae.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"N14inf62oPJSSW5E1XAD5SqIBPSnSl98vaYQF5xc7jiE-unS5nAeMg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92dadde71a2bd38c-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Wed, 09 Apr 2025 14:59:11 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"81\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"c257a31d-b7c8-4afb-903d-0099b5e30beb\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1744210723138\"],\"x-jp-txn-uuid\":[\"moz7ANtagyzmXECzDnE\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 89d30ce8a4c37b9d11d7f552521193ae.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"N14inf62oPJSSW5E1XAD5SqIBPSnSl98vaYQF5xc7jiE-unS5nAeMg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92dadde71a2bd38c-FRA\"]},\"rawHeaders\":[\"Date\",\"Wed, 09 Apr 2025 14:59:11 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"81\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"c257a31d-b7c8-4afb-903d-0099b5e30beb\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1744210723138\",\"x-jp-txn-uuid\",\"moz7ANtagyzmXECzDnE\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 89d30ce8a4c37b9d11d7f552521193ae.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"N14inf62oPJSSW5E1XAD5SqIBPSnSl98vaYQF5xc7jiE-unS5nAeMg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92dadde71a2bd38c-FRA\"],\"statusMessage\":\"OK\"}}}'),
(64, 391, 252, 17, 21, 1, '113', '104', 'order_391_1744211950872', 10000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-09 15:19:11', '2025-04-09 15:19:36', '2025-04-09 15:19:36', '', 'SG1358-order_391_1744211950872-1', '{\"orderId\":\"order_391_1744211950872\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_f4c9f0a644b64d4e921e1a60d473d262\",\"merchant_id\":\"SG1358\",\"amount\":10000,\"currency\":\"INR\",\"order_id\":\"order_391_1744211950872\",\"date_created\":\"2025-04-09T15:19:11Z\",\"last_updated\":\"2025-04-09T15:19:32Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f4c9f0a644b64d4e921e1a60d473d262\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f4c9f0a644b64d4e921e1a60d473d262\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f4c9f0a644b64d4e921e1a60d473d262\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744211950872-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":10000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozsuWT4tHyw6UZbdxM\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744211950872-1\",\"order_id\":\"order_391_1744211950872\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":10000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":10000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozsuWT4tHyw6UZbdxM\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-09T15:19:24Z\",\"last_updated\":\"2025-04-09T15:19:32Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":10000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs34b42f382c21\",\"created\":\"2025-04-09T15:19:32Z\",\"epg_txn_id\":\"314012848709\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs34b42f382c21\",\"txn_id\":\"SG1358-order_391_1744211950872-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":10000,\"order_expiry\":\"2025-04-09T15:34:11Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Wed, 09 Apr 2025 15:19:34 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"389\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"dd138189-d304-48c6-97d4-89e6acc4d9ef\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744211950872\",\"x-jp-txn-uuid\":\"mozsuWT4tHyw6UZbdxM\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 4575fb97e212b2ee375e83186512eb2e.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"MRS53-P1\",\"x-amz-cf-id\":\"bERHrC1_sYiEaYLDrYmlG403cLY8NLaIpu3Ns17hSqq5P0J9xms6Eg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92dafbc41e5f4d67-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Wed, 09 Apr 2025 15:19:34 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"389\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"dd138189-d304-48c6-97d4-89e6acc4d9ef\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744211950872\"],\"x-jp-txn-uuid\":[\"mozsuWT4tHyw6UZbdxM\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 4575fb97e212b2ee375e83186512eb2e.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"MRS53-P1\"],\"x-amz-cf-id\":[\"bERHrC1_sYiEaYLDrYmlG403cLY8NLaIpu3Ns17hSqq5P0J9xms6Eg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92dafbc41e5f4d67-FRA\"]},\"rawHeaders\":[\"Date\",\"Wed, 09 Apr 2025 15:19:34 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"389\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"dd138189-d304-48c6-97d4-89e6acc4d9ef\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744211950872\",\"x-jp-txn-uuid\",\"mozsuWT4tHyw6UZbdxM\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 4575fb97e212b2ee375e83186512eb2e.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"MRS53-P1\",\"x-amz-cf-id\",\"bERHrC1_sYiEaYLDrYmlG403cLY8NLaIpu3Ns17hSqq5P0J9xms6Eg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92dafbc41e5f4d67-FRA\"],\"statusMessage\":\"OK\"}}}'),
(65, 7, 253, 17, 12, 1, '114', '105', 'order_7_1744266188160', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-10 06:23:08', '2025-04-10 06:23:30', '2025-04-10 06:23:30', '', 'SG1358-order_7_1744266188160-1', '{\"orderId\":\"order_7_1744266188160\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"meivannanjayalakshim@gmail.com\",\"customer_phone\":\"9003616461\",\"customer_id\":\"7\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_f2c6b69380ce4d80b1018d33a1380b6e\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_7_1744266188160\",\"date_created\":\"2025-04-10T06:23:08Z\",\"last_updated\":\"2025-04-10T06:23:26Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f2c6b69380ce4d80b1018d33a1380b6e\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f2c6b69380ce4d80b1018d33a1380b6e\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_f2c6b69380ce4d80b1018d33a1380b6e\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_7_1744266188160-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz2o6P2x489SWAVv42\",\"txn_detail\":{\"txn_id\":\"SG1358-order_7_1744266188160-1\",\"order_id\":\"order_7_1744266188160\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz2o6P2x489SWAVv42\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-10T06:23:15Z\",\"last_updated\":\"2025-04-10T06:23:26Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs6f1edc2cf85a\",\"created\":\"2025-04-10T06:23:26Z\",\"epg_txn_id\":\"314012852128\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs6f1edc2cf85a\",\"txn_id\":\"SG1358-order_7_1744266188160-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-10T06:38:08Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 10 Apr 2025 06:23:28 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"101\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"5998a509-3506-404f-92db-b6c2e10ddabc\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_7_1744266188160\",\"x-jp-txn-uuid\":\"moz2o6P2x489SWAVv42\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 2e5530cd574fa6a27f079027dd7a281a.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"Q8cer6ivbRQ9vlSYxZyi9dyie2AVY0m9_ZPVpItbTAz9KDgVuyoQyg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92e027d74cd69267-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 10 Apr 2025 06:23:28 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"101\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"5998a509-3506-404f-92db-b6c2e10ddabc\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_7_1744266188160\"],\"x-jp-txn-uuid\":[\"moz2o6P2x489SWAVv42\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 2e5530cd574fa6a27f079027dd7a281a.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"Q8cer6ivbRQ9vlSYxZyi9dyie2AVY0m9_ZPVpItbTAz9KDgVuyoQyg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92e027d74cd69267-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 10 Apr 2025 06:23:28 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"101\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"5998a509-3506-404f-92db-b6c2e10ddabc\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_7_1744266188160\",\"x-jp-txn-uuid\",\"moz2o6P2x489SWAVv42\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 2e5530cd574fa6a27f079027dd7a281a.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"Q8cer6ivbRQ9vlSYxZyi9dyie2AVY0m9_ZPVpItbTAz9KDgVuyoQyg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92e027d74cd69267-FRA\"],\"statusMessage\":\"OK\"}}}'),
(66, 7, 254, 17, 21, 1, '115', '106', 'order_7_1744266461268', 10000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-10 06:27:41', '2025-04-10 06:28:06', '2025-04-10 06:28:06', '', 'SG1358-order_7_1744266461268-1', '{\"orderId\":\"order_7_1744266461268\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"meivannanjayalakshim@gmail.com\",\"customer_phone\":\"9003616461\",\"customer_id\":\"7\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_a58f20195fe24d5190f2e8332e9f8179\",\"merchant_id\":\"SG1358\",\"amount\":10000,\"currency\":\"INR\",\"order_id\":\"order_7_1744266461268\",\"date_created\":\"2025-04-10T06:27:41Z\",\"last_updated\":\"2025-04-10T06:28:02Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_a58f20195fe24d5190f2e8332e9f8179\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_a58f20195fe24d5190f2e8332e9f8179\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_a58f20195fe24d5190f2e8332e9f8179\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_7_1744266461268-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":10000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozk9hnxuCTc5hpBFWW\",\"txn_detail\":{\"txn_id\":\"SG1358-order_7_1744266461268-1\",\"order_id\":\"order_7_1744266461268\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":10000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":10000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozk9hnxuCTc5hpBFWW\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-10T06:27:53Z\",\"last_updated\":\"2025-04-10T06:28:02Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":10000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs09554ebf90de\",\"created\":\"2025-04-10T06:28:02Z\",\"epg_txn_id\":\"314012852156\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs09554ebf90de\",\"txn_id\":\"SG1358-order_7_1744266461268-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":10000,\"order_expiry\":\"2025-04-10T06:42:41Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 10 Apr 2025 06:28:05 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"110\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"20220762-ae50-4e40-a904-9099d9af1313\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_7_1744266461268\",\"x-jp-txn-uuid\":\"mozk9hnxuCTc5hpBFWW\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 ca72fb79824404d2ea5e2f5721ad1998.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"MRS53-P1\",\"x-amz-cf-id\":\"-6bWQ1L0ZYE0iNwe3eKtcAIAs9rVS0JUCAXCRJUycYUuoOTIablY7w==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92e02e981b00bb74-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 10 Apr 2025 06:28:05 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"110\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"20220762-ae50-4e40-a904-9099d9af1313\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_7_1744266461268\"],\"x-jp-txn-uuid\":[\"mozk9hnxuCTc5hpBFWW\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 ca72fb79824404d2ea5e2f5721ad1998.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"MRS53-P1\"],\"x-amz-cf-id\":[\"-6bWQ1L0ZYE0iNwe3eKtcAIAs9rVS0JUCAXCRJUycYUuoOTIablY7w==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92e02e981b00bb74-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 10 Apr 2025 06:28:05 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"110\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"20220762-ae50-4e40-a904-9099d9af1313\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_7_1744266461268\",\"x-jp-txn-uuid\",\"mozk9hnxuCTc5hpBFWW\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 ca72fb79824404d2ea5e2f5721ad1998.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"MRS53-P1\",\"x-amz-cf-id\",\"-6bWQ1L0ZYE0iNwe3eKtcAIAs9rVS0JUCAXCRJUycYUuoOTIablY7w==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92e02e981b00bb74-FRA\"],\"statusMessage\":\"OK\"}}}'),
(67, 391, 259, 17, 12, 1, '120', '107', 'order_391_1744282296691', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-10 10:51:37', '2025-04-10 10:54:00', '2025-04-10 10:54:00', '', 'SG1358-order_391_1744282296691-1', '{\"orderId\":\"order_391_1744282296691\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_8f82652ae1464ae6bf0f8943aa0bfa3a\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_391_1744282296691\",\"date_created\":\"2025-04-10T10:51:37Z\",\"last_updated\":\"2025-04-10T10:53:24Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_8f82652ae1464ae6bf0f8943aa0bfa3a\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_8f82652ae1464ae6bf0f8943aa0bfa3a\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_8f82652ae1464ae6bf0f8943aa0bfa3a\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744282296691-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozekb34GsRFwURrHDd\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744282296691-1\",\"order_id\":\"order_391_1744282296691\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozekb34GsRFwURrHDd\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-10T10:52:05Z\",\"last_updated\":\"2025-04-10T10:53:24Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bse25434349af3\",\"created\":\"2025-04-10T10:53:24Z\",\"epg_txn_id\":\"314012854108\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bse25434349af3\",\"txn_id\":\"SG1358-order_391_1744282296691-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-10T11:06:37Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 10 Apr 2025 10:53:55 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"89\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"1ed76db0-b7c2-41ab-bb90-90bd04de358b\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744282296691\",\"x-jp-txn-uuid\":\"mozekb34GsRFwURrHDd\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 1e882280b9c5d046c63d8cd0c1faf9c0.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"J65IlMMdpxMuivKD0whQML72lMrAROADmmsDxXiJ_j1VONW1J9cFFg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92e1b4049925d3b5-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 10 Apr 2025 10:53:55 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"89\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"1ed76db0-b7c2-41ab-bb90-90bd04de358b\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744282296691\"],\"x-jp-txn-uuid\":[\"mozekb34GsRFwURrHDd\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 1e882280b9c5d046c63d8cd0c1faf9c0.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"J65IlMMdpxMuivKD0whQML72lMrAROADmmsDxXiJ_j1VONW1J9cFFg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92e1b4049925d3b5-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 10 Apr 2025 10:53:55 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"89\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"1ed76db0-b7c2-41ab-bb90-90bd04de358b\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744282296691\",\"x-jp-txn-uuid\",\"mozekb34GsRFwURrHDd\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 1e882280b9c5d046c63d8cd0c1faf9c0.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"J65IlMMdpxMuivKD0whQML72lMrAROADmmsDxXiJ_j1VONW1J9cFFg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92e1b4049925d3b5-FRA\"],\"statusMessage\":\"OK\"}}}'),
(68, 391, 260, 17, 12, 1, '121', '0', 'order_391_1744282569959', 1000.00, 'INR', 'NET_BANKING', '000', 'Failure', '2025-04-10 10:56:10', '2025-04-10 10:57:26', '2025-04-10 10:57:26', '', 'SG1358-order_391_1744282569959-1', '{\"orderId\":\"order_391_1744282569959\",\"status\":\"failure\",\"message\":\"Payment authorization failed. Please check your payment details.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":27,\"status\":\"AUTHORIZATION_FAILED\",\"id\":\"ordeh_ef6fd258c40d4b1d99a2dc0b5b1fc014\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_391_1744282569959\",\"date_created\":\"2025-04-10T10:56:10Z\",\"last_updated\":\"2025-04-10T10:56:59Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_ef6fd258c40d4b1d99a2dc0b5b1fc014\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_ef6fd258c40d4b1d99a2dc0b5b1fc014\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_ef6fd258c40d4b1d99a2dc0b5b1fc014\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744282569959-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":\"PAYMENT_FAILED\",\"resp_message\":\"Payment Failure\",\"bank_error_code\":\"Failure\",\"bank_error_message\":\"Transaction is Failed\",\"txn_uuid\":\"mozRQmZj5fYc52kUMBy\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744282569959-1\",\"order_id\":\"order_391_1744282569959\",\"status\":\"AUTHORIZATION_FAILED\",\"error_code\":\"Failure\",\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozRQmZj5fYc52kUMBy\",\"gateway\":\"CCAVENUE_V2\",\"response_code\":\"PAYMENT_FAILED\",\"response_message\":\"Payment Failure\",\"error_message\":\"Transaction is Failed\",\"created\":\"2025-04-10T10:56:31Z\",\"last_updated\":\"2025-04-10T10:56:59Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Failure\",\"rrn\":\"bs6e2f8580664f\",\"created\":\"2025-04-10T10:56:59Z\",\"epg_txn_id\":\"314012854136\",\"resp_message\":\"Transaction is Failed\",\"auth_id_code\":\"bs6e2f8580664f\",\"txn_id\":\"SG1358-order_391_1744282569959-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"order_expiry\":\"2025-04-10T11:11:10Z\",\"resp_category\":\"PAYMENT_FAILURE\",\"http\":{\"headers\":{\"date\":\"Thu, 10 Apr 2025 10:57:25 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"83\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"4c53e397-7419-4fc2-8266-3a60acc3e5f2\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744282569959\",\"x-jp-txn-uuid\":\"mozRQmZj5fYc52kUMBy\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 52dfbfe5ed6eea481ae3cb6b0a8eec38.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"Od0yvcxIFYLBFj-hCC4ur1cMIVVBHiFlMK5SGCB5gMhAAH_ZONjoAQ==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92e1b9227b2fdb07-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 10 Apr 2025 10:57:25 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"83\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"4c53e397-7419-4fc2-8266-3a60acc3e5f2\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744282569959\"],\"x-jp-txn-uuid\":[\"mozRQmZj5fYc52kUMBy\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 52dfbfe5ed6eea481ae3cb6b0a8eec38.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"Od0yvcxIFYLBFj-hCC4ur1cMIVVBHiFlMK5SGCB5gMhAAH_ZONjoAQ==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92e1b9227b2fdb07-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 10 Apr 2025 10:57:25 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"83\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"4c53e397-7419-4fc2-8266-3a60acc3e5f2\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744282569959\",\"x-jp-txn-uuid\",\"mozRQmZj5fYc52kUMBy\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 52dfbfe5ed6eea481ae3cb6b0a8eec38.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"Od0yvcxIFYLBFj-hCC4ur1cMIVVBHiFlMK5SGCB5gMhAAH_ZONjoAQ==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92e1b9227b2fdb07-FRA\"],\"statusMessage\":\"OK\"}}}');
INSERT INTO `transactions` (`id`, `userId`, `investmentId`, `schemeId`, `chitId`, `installment`, `accountNumber`, `paymentId`, `orderId`, `amount`, `currency`, `paymentMethod`, `signature`, `paymentStatus`, `paymentDate`, `createdAt`, `updatedAt`, `status`, `gatewayTransactionId`, `gatewayresponse`) VALUES
(69, 7, 263, 17, 18, 1, '124', '108', 'order_7_1744282949164', 5000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-10 11:02:29', '2025-04-10 11:03:05', '2025-04-10 11:03:05', '', 'SG1358-order_7_1744282949164-1', '{\"orderId\":\"order_7_1744282949164\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"meivannanjayalakshim@gmail.com\",\"customer_phone\":\"9003616461\",\"customer_id\":\"7\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_1117caaf905e4074ac7b7cf01fdbc602\",\"merchant_id\":\"SG1358\",\"amount\":5000,\"currency\":\"INR\",\"order_id\":\"order_7_1744282949164\",\"date_created\":\"2025-04-10T11:02:29Z\",\"last_updated\":\"2025-04-10T11:03:00Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_1117caaf905e4074ac7b7cf01fdbc602\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_1117caaf905e4074ac7b7cf01fdbc602\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_1117caaf905e4074ac7b7cf01fdbc602\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_7_1744282949164-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":5000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozrUhi9WEDwWqHJ6rc\",\"txn_detail\":{\"txn_id\":\"SG1358-order_7_1744282949164-1\",\"order_id\":\"order_7_1744282949164\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":5000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":5000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozrUhi9WEDwWqHJ6rc\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-10T11:02:48Z\",\"last_updated\":\"2025-04-10T11:03:00Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":5000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bsb1049af0d8d0\",\"created\":\"2025-04-10T11:03:00Z\",\"epg_txn_id\":\"314012854167\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bsb1049af0d8d0\",\"txn_id\":\"SG1358-order_7_1744282949164-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":5000,\"order_expiry\":\"2025-04-10T11:17:29Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Thu, 10 Apr 2025 11:03:03 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"81\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"1f8c9054-d2e9-4a3e-8a44-90954fa50db1\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_7_1744282949164\",\"x-jp-txn-uuid\":\"mozrUhi9WEDwWqHJ6rc\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 d7b95fc49388e3b88d8d8ce14a277aac.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"84xEC2T4bApQOuDZX4Y_JzVm29GaTGRJmBJ2Z6V4T0GTwuu7uvIBtQ==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92e1c1608addd399-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Thu, 10 Apr 2025 11:03:03 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"81\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"1f8c9054-d2e9-4a3e-8a44-90954fa50db1\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_7_1744282949164\"],\"x-jp-txn-uuid\":[\"mozrUhi9WEDwWqHJ6rc\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 d7b95fc49388e3b88d8d8ce14a277aac.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"84xEC2T4bApQOuDZX4Y_JzVm29GaTGRJmBJ2Z6V4T0GTwuu7uvIBtQ==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92e1c1608addd399-FRA\"]},\"rawHeaders\":[\"Date\",\"Thu, 10 Apr 2025 11:03:03 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"81\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"1f8c9054-d2e9-4a3e-8a44-90954fa50db1\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_7_1744282949164\",\"x-jp-txn-uuid\",\"mozrUhi9WEDwWqHJ6rc\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 d7b95fc49388e3b88d8d8ce14a277aac.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"84xEC2T4bApQOuDZX4Y_JzVm29GaTGRJmBJ2Z6V4T0GTwuu7uvIBtQ==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92e1c1608addd399-FRA\"],\"statusMessage\":\"OK\"}}}'),
(70, 379, 267, 17, 21, 1, '128', '109', 'order_379_1744368224306', 10000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-11 10:43:44', '2025-04-11 10:44:19', '2025-04-11 10:44:19', '', 'SG1358-order_379_1744368224306-1', '{\"orderId\":\"order_379_1744368224306\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_badc6eb6a26d4e60a385914263292125\",\"merchant_id\":\"SG1358\",\"amount\":10000,\"currency\":\"INR\",\"order_id\":\"order_379_1744368224306\",\"date_created\":\"2025-04-11T10:43:44Z\",\"last_updated\":\"2025-04-11T10:44:15Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_badc6eb6a26d4e60a385914263292125\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_badc6eb6a26d4e60a385914263292125\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_badc6eb6a26d4e60a385914263292125\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1744368224306-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":10000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moztzZvQdReBsxGGter\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1744368224306-1\",\"order_id\":\"order_379_1744368224306\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":10000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":10000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moztzZvQdReBsxGGter\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-11T10:44:03Z\",\"last_updated\":\"2025-04-11T10:44:15Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":10000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs059d40c6731a\",\"created\":\"2025-04-11T10:44:15Z\",\"epg_txn_id\":\"314012857314\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs059d40c6731a\",\"txn_id\":\"SG1358-order_379_1744368224306-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":10000,\"order_expiry\":\"2025-04-11T10:58:44Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Fri, 11 Apr 2025 10:44:17 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"105\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"e360a1e5-a043-4c52-9394-fa8b87d6ac0a\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1744368224306\",\"x-jp-txn-uuid\":\"moztzZvQdReBsxGGter\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 24cf00ae4a49accfc79d487bbda5821a.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"MRS53-P1\",\"x-amz-cf-id\":\"DN-Ub5zlWecBRSzIVC_e73gSYC1jZN2QDE2G7lRNAObzwnwls-wQLg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92e9e346aa763a5e-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Fri, 11 Apr 2025 10:44:17 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"105\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"e360a1e5-a043-4c52-9394-fa8b87d6ac0a\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1744368224306\"],\"x-jp-txn-uuid\":[\"moztzZvQdReBsxGGter\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 24cf00ae4a49accfc79d487bbda5821a.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"MRS53-P1\"],\"x-amz-cf-id\":[\"DN-Ub5zlWecBRSzIVC_e73gSYC1jZN2QDE2G7lRNAObzwnwls-wQLg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92e9e346aa763a5e-FRA\"]},\"rawHeaders\":[\"Date\",\"Fri, 11 Apr 2025 10:44:17 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"105\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"e360a1e5-a043-4c52-9394-fa8b87d6ac0a\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1744368224306\",\"x-jp-txn-uuid\",\"moztzZvQdReBsxGGter\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 24cf00ae4a49accfc79d487bbda5821a.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"MRS53-P1\",\"x-amz-cf-id\",\"DN-Ub5zlWecBRSzIVC_e73gSYC1jZN2QDE2G7lRNAObzwnwls-wQLg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92e9e346aa763a5e-FRA\"],\"statusMessage\":\"OK\"}}}'),
(71, 379, 269, 17, 21, 1, '130', '110', 'order_379_1744369895216', 10000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-11 11:11:35', '2025-04-11 11:11:59', '2025-04-11 11:11:59', '', 'SG1358-order_379_1744369895216-1', '{\"orderId\":\"order_379_1744369895216\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"mohandass@gmail.com\",\"customer_phone\":\"9788033234\",\"customer_id\":\"379\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_c38dbc67aef049f6bc519bbb2da65c30\",\"merchant_id\":\"SG1358\",\"amount\":10000,\"currency\":\"INR\",\"order_id\":\"order_379_1744369895216\",\"date_created\":\"2025-04-11T11:11:35Z\",\"last_updated\":\"2025-04-11T11:11:56Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_c38dbc67aef049f6bc519bbb2da65c30\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_c38dbc67aef049f6bc519bbb2da65c30\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_c38dbc67aef049f6bc519bbb2da65c30\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_379_1744369895216-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":10000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"mozcGFFJdYpHN3Lvfo6\",\"txn_detail\":{\"txn_id\":\"SG1358-order_379_1744369895216-1\",\"order_id\":\"order_379_1744369895216\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":10000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":10000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozcGFFJdYpHN3Lvfo6\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-11T11:11:47Z\",\"last_updated\":\"2025-04-11T11:11:56Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":10000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs7c6913b49cf4\",\"created\":\"2025-04-11T11:11:56Z\",\"epg_txn_id\":\"314012857579\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs7c6913b49cf4\",\"txn_id\":\"SG1358-order_379_1744369895216-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":10000,\"order_expiry\":\"2025-04-11T11:26:35Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Fri, 11 Apr 2025 11:11:57 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"138\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"cbfb4778-d9cf-464d-98ea-ef9f36e4d25e\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_379_1744369895216\",\"x-jp-txn-uuid\":\"mozcGFFJdYpHN3Lvfo6\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 161bb6093ee10b11ad6a8a23b3138bee.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"4hrrQ22gMW5B338N_5eljIL3AFgwr8fYbbWNXZgjY80aw-Xn-E8BVw==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92ea0bcfcb325c3e-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Fri, 11 Apr 2025 11:11:57 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"138\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"cbfb4778-d9cf-464d-98ea-ef9f36e4d25e\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_379_1744369895216\"],\"x-jp-txn-uuid\":[\"mozcGFFJdYpHN3Lvfo6\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 161bb6093ee10b11ad6a8a23b3138bee.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"4hrrQ22gMW5B338N_5eljIL3AFgwr8fYbbWNXZgjY80aw-Xn-E8BVw==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92ea0bcfcb325c3e-FRA\"]},\"rawHeaders\":[\"Date\",\"Fri, 11 Apr 2025 11:11:57 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"138\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"cbfb4778-d9cf-464d-98ea-ef9f36e4d25e\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_379_1744369895216\",\"x-jp-txn-uuid\",\"mozcGFFJdYpHN3Lvfo6\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 161bb6093ee10b11ad6a8a23b3138bee.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"4hrrQ22gMW5B338N_5eljIL3AFgwr8fYbbWNXZgjY80aw-Xn-E8BVw==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92ea0bcfcb325c3e-FRA\"],\"statusMessage\":\"OK\"}}}'),
(72, 391, 272, 17, 12, 1, '133', '111', 'order_391_1744370599907', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-11 11:23:20', '2025-04-11 11:24:44', '2025-04-11 11:24:44', '', 'SG1358-order_391_1744370599907-1', '{\"orderId\":\"order_391_1744370599907\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_153184dfae094ee3804939eae5f7b20f\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_391_1744370599907\",\"date_created\":\"2025-04-11T11:23:20Z\",\"last_updated\":\"2025-04-11T11:24:25Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_153184dfae094ee3804939eae5f7b20f\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_153184dfae094ee3804939eae5f7b20f\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_153184dfae094ee3804939eae5f7b20f\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744370599907-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz7gARxEoRmBNy5Mn1\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744370599907-1\",\"order_id\":\"order_391_1744370599907\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz7gARxEoRmBNy5Mn1\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-11T11:23:35Z\",\"last_updated\":\"2025-04-11T11:24:25Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bsb4165ee580d6\",\"created\":\"2025-04-11T11:24:25Z\",\"epg_txn_id\":\"314012857691\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bsb4165ee580d6\",\"txn_id\":\"SG1358-order_391_1744370599907-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-11T11:38:20Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Fri, 11 Apr 2025 11:24:43 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"84\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"1457bcc7-4766-47d9-a14b-c4f473468a05\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744370599907\",\"x-jp-txn-uuid\":\"moz7gARxEoRmBNy5Mn1\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 eea44cfdd1770b9ba28f1b455f101b4c.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"xxkh_6bL_eJ7wHKbDn6dLJmangsaMabduaETol56FreLplJ8ODfJaA==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92ea1e7f5e0578c0-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Fri, 11 Apr 2025 11:24:43 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"84\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"1457bcc7-4766-47d9-a14b-c4f473468a05\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744370599907\"],\"x-jp-txn-uuid\":[\"moz7gARxEoRmBNy5Mn1\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 eea44cfdd1770b9ba28f1b455f101b4c.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"xxkh_6bL_eJ7wHKbDn6dLJmangsaMabduaETol56FreLplJ8ODfJaA==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92ea1e7f5e0578c0-FRA\"]},\"rawHeaders\":[\"Date\",\"Fri, 11 Apr 2025 11:24:43 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"84\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"1457bcc7-4766-47d9-a14b-c4f473468a05\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744370599907\",\"x-jp-txn-uuid\",\"moz7gARxEoRmBNy5Mn1\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 eea44cfdd1770b9ba28f1b455f101b4c.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"xxkh_6bL_eJ7wHKbDn6dLJmangsaMabduaETol56FreLplJ8ODfJaA==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92ea1e7f5e0578c0-FRA\"],\"statusMessage\":\"OK\"}}}'),
(73, 391, 280, 17, 15, 1, '141', '112', 'order_391_1744372864946', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-11 12:01:05', '2025-04-11 12:06:15', '2025-04-11 12:06:15', '', 'SG1358-order_391_1744372864946-1', '{\"orderId\":\"order_391_1744372864946\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_d1f52692a4924f52b5d47c82fed0adda\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_391_1744372864946\",\"date_created\":\"2025-04-11T12:01:05Z\",\"last_updated\":\"2025-04-11T12:02:15Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_d1f52692a4924f52b5d47c82fed0adda\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_d1f52692a4924f52b5d47c82fed0adda\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_d1f52692a4924f52b5d47c82fed0adda\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744372864946-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz6DguyWEGVeUpzUzA\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744372864946-1\",\"order_id\":\"order_391_1744372864946\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz6DguyWEGVeUpzUzA\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-11T12:01:38Z\",\"last_updated\":\"2025-04-11T12:02:15Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs3d1aa2490d97\",\"created\":\"2025-04-11T12:02:15Z\",\"epg_txn_id\":\"314012857894\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs3d1aa2490d97\",\"txn_id\":\"SG1358-order_391_1744372864946-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-11T12:16:05Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Fri, 11 Apr 2025 12:06:12 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"94\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"aad295e5-8479-4125-a2bc-17b15b400cb6\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744372864946\",\"x-jp-txn-uuid\":\"moz6DguyWEGVeUpzUzA\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 2d859daa66fde82c2a8685f4b0ee0dbe.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"S-s3z7pvtXc6xdHB-AmhshV7H9fWQdEpLoZn8ICTAhaWpwvCID913A==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92ea5b435eba4dbf-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Fri, 11 Apr 2025 12:06:12 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"94\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"aad295e5-8479-4125-a2bc-17b15b400cb6\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744372864946\"],\"x-jp-txn-uuid\":[\"moz6DguyWEGVeUpzUzA\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 2d859daa66fde82c2a8685f4b0ee0dbe.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"S-s3z7pvtXc6xdHB-AmhshV7H9fWQdEpLoZn8ICTAhaWpwvCID913A==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92ea5b435eba4dbf-FRA\"]},\"rawHeaders\":[\"Date\",\"Fri, 11 Apr 2025 12:06:12 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"94\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"aad295e5-8479-4125-a2bc-17b15b400cb6\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744372864946\",\"x-jp-txn-uuid\",\"moz6DguyWEGVeUpzUzA\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 2d859daa66fde82c2a8685f4b0ee0dbe.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"S-s3z7pvtXc6xdHB-AmhshV7H9fWQdEpLoZn8ICTAhaWpwvCID913A==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92ea5b435eba4dbf-FRA\"],\"statusMessage\":\"OK\"}}}'),
(74, 391, 283, 17, 15, 1, '144', '113', 'order_391_1744375505820', 1000.00, 'INR', 'NET_BANKING', '000', 'Success', '2025-04-11 12:45:06', '2025-04-11 12:46:18', '2025-04-11 12:46:18', '', 'SG1358-order_391_1744375505820-1', '{\"orderId\":\"order_391_1744375505820\",\"status\":\"success\",\"message\":\"Payment completed successfully.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":21,\"status\":\"CHARGED\",\"id\":\"ordeh_04efa63a513d4beba9129fbe2e635444\",\"merchant_id\":\"SG1358\",\"amount\":1000,\"currency\":\"INR\",\"order_id\":\"order_391_1744375505820\",\"date_created\":\"2025-04-11T12:45:06Z\",\"last_updated\":\"2025-04-11T12:46:08Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_04efa63a513d4beba9129fbe2e635444\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_04efa63a513d4beba9129fbe2e635444\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_04efa63a513d4beba9129fbe2e635444\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744375505820-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":1000,\"resp_code\":null,\"resp_message\":null,\"bank_error_code\":\"\",\"bank_error_message\":\"\",\"txn_uuid\":\"moz4XFn48QBgtCkbsRY\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744375505820-1\",\"order_id\":\"order_391_1744375505820\",\"status\":\"CHARGED\",\"error_code\":null,\"net_amount\":1000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":1000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"moz4XFn48QBgtCkbsRY\",\"gateway\":\"CCAVENUE_V2\",\"error_message\":\"\",\"created\":\"2025-04-11T12:45:33Z\",\"last_updated\":\"2025-04-11T12:46:08Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":1000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Success\",\"rrn\":\"bs1eadb25a556f\",\"created\":\"2025-04-11T12:46:08Z\",\"epg_txn_id\":\"314012858050\",\"resp_message\":\"Transaction is Successful\",\"auth_id_code\":\"bs1eadb25a556f\",\"txn_id\":\"SG1358-order_391_1744375505820-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"maximum_eligible_refund_amount\":1000,\"order_expiry\":\"2025-04-11T13:00:06Z\",\"resp_category\":null,\"http\":{\"headers\":{\"date\":\"Fri, 11 Apr 2025 12:46:16 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"131\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"566d0d4f-00dd-4a47-86f4-8a866087ef26\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744375505820\",\"x-jp-txn-uuid\":\"moz4XFn48QBgtCkbsRY\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 eea44cfdd1770b9ba28f1b455f101b4c.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"0c9rnGROS7Ul1gZPEDbJzUDMQP7RwyI_TMovV83YGMhIJSeV9cER6Q==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92ea95f61e53bbef-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Fri, 11 Apr 2025 12:46:16 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"131\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"566d0d4f-00dd-4a47-86f4-8a866087ef26\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744375505820\"],\"x-jp-txn-uuid\":[\"moz4XFn48QBgtCkbsRY\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 eea44cfdd1770b9ba28f1b455f101b4c.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"0c9rnGROS7Ul1gZPEDbJzUDMQP7RwyI_TMovV83YGMhIJSeV9cER6Q==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92ea95f61e53bbef-FRA\"]},\"rawHeaders\":[\"Date\",\"Fri, 11 Apr 2025 12:46:16 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"131\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"566d0d4f-00dd-4a47-86f4-8a866087ef26\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744375505820\",\"x-jp-txn-uuid\",\"moz4XFn48QBgtCkbsRY\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 eea44cfdd1770b9ba28f1b455f101b4c.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"0c9rnGROS7Ul1gZPEDbJzUDMQP7RwyI_TMovV83YGMhIJSeV9cER6Q==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92ea95f61e53bbef-FRA\"],\"statusMessage\":\"OK\"}}}');
INSERT INTO `transactions` (`id`, `userId`, `investmentId`, `schemeId`, `chitId`, `installment`, `accountNumber`, `paymentId`, `orderId`, `amount`, `currency`, `paymentMethod`, `signature`, `paymentStatus`, `paymentDate`, `createdAt`, `updatedAt`, `status`, `gatewayTransactionId`, `gatewayresponse`) VALUES
(75, 391, 284, 17, 15, 1, '145', '0', 'order_391_1744376065651', 2000.00, 'INR', 'NET_BANKING', '000', 'Failure', '2025-04-11 12:54:26', '2025-04-11 12:55:48', '2025-04-11 12:55:48', '', 'SG1358-order_391_1744376065651-1', '{\"orderId\":\"order_391_1744376065651\",\"status\":\"failure\",\"message\":\"Payment authorization failed. Please check your payment details.\",\"paymentResponse\":{\"customer_email\":\"hdfc_team4@qseap.com\",\"customer_phone\":\"8655907044\",\"customer_id\":\"391\",\"status_id\":27,\"status\":\"AUTHORIZATION_FAILED\",\"id\":\"ordeh_657012c0d2474d18aa27a45d446c394c\",\"merchant_id\":\"SG1358\",\"amount\":2000,\"currency\":\"INR\",\"order_id\":\"order_391_1744376065651\",\"date_created\":\"2025-04-11T12:54:26Z\",\"last_updated\":\"2025-04-11T12:55:31Z\",\"return_url\":\"https://api.dcjewellers.org/payments/status\",\"product_id\":\"\",\"payment_links\":{\"mobile\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_657012c0d2474d18aa27a45d446c394c\",\"web\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_657012c0d2474d18aa27a45d446c394c\",\"iframe\":\"https://smartgatewayuat.hdfcbank.com/payment-page/order/ordeh_657012c0d2474d18aa27a45d446c394c\"},\"udf1\":\"\",\"udf2\":\"\",\"udf3\":\"\",\"udf4\":\"\",\"udf5\":\"\",\"udf6\":\"\",\"udf7\":\"\",\"udf8\":\"\",\"udf9\":\"\",\"udf10\":\"\",\"txn_id\":\"SG1358-order_391_1744376065651-1\",\"payment_method_type\":\"NB\",\"auth_type\":\"THREE_DS\",\"payment_method\":\"NB_AVENUETEST\",\"refunded\":false,\"amount_refunded\":0,\"effective_amount\":2000,\"resp_code\":\"PAYMENT_FAILED\",\"resp_message\":\"Payment Failure\",\"bank_error_code\":\"Failure\",\"bank_error_message\":\"Transaction is Failed\",\"txn_uuid\":\"mozjxTceXPHaJ3tSH7g\",\"txn_detail\":{\"txn_id\":\"SG1358-order_391_1744376065651-1\",\"order_id\":\"order_391_1744376065651\",\"status\":\"AUTHORIZATION_FAILED\",\"error_code\":\"Failure\",\"net_amount\":2000,\"surcharge_amount\":null,\"tax_amount\":null,\"txn_amount\":2000,\"offer_deduction_amount\":null,\"gateway_id\":16,\"currency\":\"INR\",\"metadata\":{\"payment_channel\":\"MWEB\"},\"express_checkout\":false,\"redirect\":true,\"txn_uuid\":\"mozjxTceXPHaJ3tSH7g\",\"gateway\":\"CCAVENUE_V2\",\"response_code\":\"PAYMENT_FAILED\",\"response_message\":\"Payment Failure\",\"error_message\":\"Transaction is Failed\",\"created\":\"2025-04-11T12:54:53Z\",\"last_updated\":\"2025-04-11T12:55:31Z\",\"txn_flow_type\":\"NET_BANKING\",\"txn_amount_breakup\":[{\"name\":\"BASE\",\"amount\":2000,\"sno\":1,\"method\":\"ADD\"}]},\"payment_gateway_response\":{\"resp_code\":\"Failure\",\"rrn\":\"bs95c1bdfddaad\",\"created\":\"2025-04-11T12:55:31Z\",\"epg_txn_id\":\"314012858096\",\"resp_message\":\"Transaction is Failed\",\"auth_id_code\":\"bs95c1bdfddaad\",\"txn_id\":\"SG1358-order_391_1744376065651-1\",\"network_error_message\":null,\"network_error_code\":null,\"arn\":null,\"gateway_merchant_id\":\"3493832\",\"eci\":null,\"auth_ref_num\":null,\"umrn\":null,\"current_blocked_amount\":null},\"gateway_id\":16,\"emi_details\":{\"bank\":null,\"monthly_payment\":null,\"interest\":null,\"conversion_details\":null,\"principal_amount\":null,\"additional_processing_fee_info\":null,\"tenure\":null,\"subvention_info\":[],\"emi_type\":null,\"processed_by\":null},\"gateway_reference_id\":null,\"offers\":[],\"order_expiry\":\"2025-04-11T13:09:26Z\",\"resp_category\":\"PAYMENT_FAILURE\",\"http\":{\"headers\":{\"date\":\"Fri, 11 Apr 2025 12:55:47 GMT\",\"content-type\":\"application/json\",\"transfer-encoding\":\"chunked\",\"connection\":\"keep-alive\",\"x-envoy-upstream-service-time\":\"98\",\"x-envoy-attempt-count\":\"1\",\"x-response-id\":\"bba81842-dff0-4004-a5d8-4f9143d4dec8\",\"x-jp-merchant-id\":\"SG1358\",\"x-jp-order-id\":\"order_391_1744376065651\",\"x-jp-txn-uuid\":\"mozjxTceXPHaJ3tSH7g\",\"access-control-allow-methods\":\"GET, POST, OPTIONS\",\"access-control-allow-headers\":\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"cache-control\":\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\":\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\":\"0\",\"x-content-type-options\":\"nosniff\",\"x-frame-options\":\"SAMEORIGIN\",\"referrer-policy\":\"strict-origin\",\"x-cache\":\"Miss from cloudfront\",\"via\":\"1.1 2e4eab1a81a3a1decbe496056c9489da.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\":\"FRA50-P2\",\"x-amz-cf-id\":\"JGzw7zs-d1LYeUvtEHchGHujy7j7pEy3xBgfxM295pFGjX1dwi1-Fg==\",\"cf-cache-status\":\"DYNAMIC\",\"server\":\"cloudflare\",\"cf-ray\":\"92eaa3e67e9ec4d8-FRA\"},\"statusCode\":200,\"url\":\"\",\"method\":null,\"httpVersion\":\"1.1\",\"httpVersionMajor\":1,\"httpVersionMinor\":1,\"headersDistinct\":{\"date\":[\"Fri, 11 Apr 2025 12:55:47 GMT\"],\"content-type\":[\"application/json\"],\"transfer-encoding\":[\"chunked\"],\"connection\":[\"keep-alive\"],\"x-envoy-upstream-service-time\":[\"98\"],\"x-envoy-attempt-count\":[\"1\"],\"x-response-id\":[\"bba81842-dff0-4004-a5d8-4f9143d4dec8\"],\"x-jp-merchant-id\":[\"SG1358\"],\"x-jp-order-id\":[\"order_391_1744376065651\"],\"x-jp-txn-uuid\":[\"mozjxTceXPHaJ3tSH7g\"],\"access-control-allow-methods\":[\"GET, POST, OPTIONS\"],\"access-control-allow-headers\":[\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\"],\"cache-control\":[\"private, no-cache, no-store, must-revalidate\"],\"strict-transport-security\":[\"max-age=63072000; includeSubdomains; preload\"],\"x-xss-protection\":[\"0\"],\"x-content-type-options\":[\"nosniff\"],\"x-frame-options\":[\"SAMEORIGIN\"],\"referrer-policy\":[\"strict-origin\"],\"x-cache\":[\"Miss from cloudfront\"],\"via\":[\"1.1 2e4eab1a81a3a1decbe496056c9489da.cloudfront.net (CloudFront)\"],\"x-amz-cf-pop\":[\"FRA50-P2\"],\"x-amz-cf-id\":[\"JGzw7zs-d1LYeUvtEHchGHujy7j7pEy3xBgfxM295pFGjX1dwi1-Fg==\"],\"cf-cache-status\":[\"DYNAMIC\"],\"server\":[\"cloudflare\"],\"cf-ray\":[\"92eaa3e67e9ec4d8-FRA\"]},\"rawHeaders\":[\"Date\",\"Fri, 11 Apr 2025 12:55:47 GMT\",\"Content-Type\",\"application/json\",\"Transfer-Encoding\",\"chunked\",\"Connection\",\"keep-alive\",\"x-envoy-upstream-service-time\",\"98\",\"x-envoy-attempt-count\",\"1\",\"x-response-id\",\"bba81842-dff0-4004-a5d8-4f9143d4dec8\",\"x-jp-merchant-id\",\"SG1358\",\"x-jp-order-id\",\"order_391_1744376065651\",\"x-jp-txn-uuid\",\"mozjxTceXPHaJ3tSH7g\",\"access-control-allow-methods\",\"GET, POST, OPTIONS\",\"access-control-allow-headers\",\"Content-Type, X-RegistrationToken-Id, X-RegistrationToken, X-LoginToken, X-Web-LoginToken, cache-control, x-api, x-jp-merchant-id, x-jp-session-id, x-merchantid, x-feature, X-OrderId, sdk-web-trackname, sdk-micro-app-name, sdk-micro-app-version, sdk-micro-app-config-version, sdk-godel-version, sdk-godel-build-version, sdk-godel-remotes-version, sdk-app-name, sdk-os, sdk-os-version, sdk-browser-version, sdk-browser, sdk-device, sdk-package-name, sdk-user-agent\",\"Cache-Control\",\"private, no-cache, no-store, must-revalidate\",\"strict-transport-security\",\"max-age=63072000; includeSubdomains; preload\",\"x-xss-protection\",\"0\",\"x-content-type-options\",\"nosniff\",\"x-frame-options\",\"SAMEORIGIN\",\"referrer-policy\",\"strict-origin\",\"x-cache\",\"Miss from cloudfront\",\"via\",\"1.1 2e4eab1a81a3a1decbe496056c9489da.cloudfront.net (CloudFront)\",\"x-amz-cf-pop\",\"FRA50-P2\",\"x-amz-cf-id\",\"JGzw7zs-d1LYeUvtEHchGHujy7j7pEy3xBgfxM295pFGjX1dwi1-Fg==\",\"cf-cache-status\",\"DYNAMIC\",\"Server\",\"cloudflare\",\"CF-RAY\",\"92eaa3e67e9ec4d8-FRA\"],\"statusMessage\":\"OK\"}}}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mpin` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `password` varchar(255) NOT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `referral_code` varchar(6) DEFAULT NULL,
  `referred_by` varchar(10) DEFAULT NULL,
  `kyc_status` enum('pending','verified','rejected','') NOT NULL,
  `status` enum('1','0') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `mobile_number`, `name`, `email`, `mpin`, `created_at`, `password`, `user_type`, `referral_code`, `referred_by`, `kyc_status`, `status`) VALUES
(3, '9585141535', 'Ajithkumar', 'ajithkumar799@yahoo.com', '$2b$10$CnVcWdTFY2.kRV8qMH7ssODJfSpPsGI2qj/TNTm58CUk9aWxSTtf2', '2025-02-28 06:13:34', '', 'user', '8R39LK', NULL, 'verified', '1'),
(4, '9645462847', 'ginto pj', 'gintopj88@gmail.com', '$2b$10$iopWrkLBactPKSiB7Jnd5Oj/Y3XxESy9mR0h.d7iJBEYfVbxC8/1u', '2025-02-28 11:07:05', '', 'user', 'XTP7XU', NULL, 'pending', '1'),
(5, '9061802999', 'DC JEWELLERY', 'dcjewellerstcr@gmail.com', '$2b$10$njmajWIhOnWc9UN0ijqIie0Rq1gGay/I.UnKQu9y62ihx4i1ayzbW', '2025-02-28 11:09:14', '', 'user', 'OOZTJM', NULL, 'pending', '1'),
(6, '9645462844', 'ginto pj', 'gintopj88@gmail.com', '$2b$10$0umk/jR2hQ.kdmowhOd8i.RFBak5Jedr7C7Bzy84TaH/ZhCkc9rn.', '2025-02-28 11:10:04', '', 'user', 'NUVKIY', NULL, 'pending', '1'),
(7, '9003616461', 'Meivannan', 'meivannanjayalakshim@gmail.com', '$2b$10$TpeldLXL2yqKwXfWu24n4OhJ1nGj/9.FunykoYY8/UulrOhAql/PG', '2025-02-28 17:09:44', '', 'user', 'D6H8HY', NULL, 'pending', '1'),
(8, '8667382195', 'KEERTHANAN N', 'Keerthanan14bsc40@gmail.com', '$2b$10$ggkPAv1bvDufeuhOG74w2OyPGgyol/I1.VK/BFBjy53yV7I9GU2VK', '2025-03-01 07:21:59', '', 'user', 'O2EUYN', NULL, 'pending', '1'),
(9, '9150280795', 'Sam', 'bsksam@gmail.com', '$2b$10$LDTU.VvjI.7AJtWVPXu.6OkYb8umpQI2MD.BFNPNWCNJbYpH27xFS', '2025-03-01 07:46:16', '', 'user', 'D40WIN', NULL, 'pending', '1'),
(192, '9846549521', 'GIRI E U (8227)', ' ', '', '2025-03-01 08:36:49', '', 'user', '8G8CSU', NULL, 'verified', '1'),
(193, '9037363304', 'ALISHA AKHIL (8382)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'MX5A82', NULL, 'verified', '1'),
(194, '8848582844', 'SURESH KUMAR(13360)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'JEAC7B', NULL, 'verified', '1'),
(195, '9847096805', 'VINIL P', ' ', '', '2025-03-01 08:36:49', '', 'user', 'VDXQE5', NULL, 'verified', '1'),
(196, '8921946404', 'SHIHAB T H', ' ', '', '2025-03-01 08:36:49', '', 'user', 'UCCPHF', NULL, 'verified', '1'),
(197, '9495502169', 'MINI PRADEEP', ' ', '', '2025-03-01 08:36:49', '', 'user', 'AP7WLP', NULL, 'verified', '1'),
(198, '8593090008', 'SUSHANT', ' ', '', '2025-03-01 08:36:49', '', 'user', '2QOT09', NULL, 'verified', '1'),
(199, '9745460398', 'SABIRA K K', ' ', '', '2025-03-01 08:36:49', '', 'user', 'H9SICZ', NULL, 'verified', '1'),
(200, '9,65,65,54,46,1', 'RANI M', ' ', '', '2025-03-01 08:36:49', '', 'user', 'TBX0GE', NULL, 'verified', '1'),
(201, '8606606007', 'ANGEL ANTONY', ' ', '', '2025-03-01 08:36:49', '', 'user', 'PJ3951', NULL, 'verified', '1'),
(202, '8136843123', 'SETHU LAKSHMI', ' ', '', '2025-03-01 08:36:49', '', 'user', 'O12GYX', NULL, 'verified', '1'),
(203, '9961606369', 'BINDU ANN NAVEEN', ' ', '', '2025-03-01 08:36:49', '', 'user', '3J9SOV', NULL, 'verified', '1'),
(204, '9620933632', 'JINCY JAISON', ' ', '', '2025-03-01 08:36:49', '', 'user', 'WY6JC7', NULL, 'verified', '1'),
(205, '9495557770', 'JIYAS JAMALUDEEN LEBBA', ' ', '', '2025-03-01 08:36:49', '', 'user', 'W86YPT', NULL, 'verified', '1'),
(206, '9961469777', 'ANTONY P R', ' ', '', '2025-03-01 08:36:49', '', 'user', '29AJHM', NULL, 'verified', '1'),
(207, '9947623415', 'RANJITH K K', ' ', '', '2025-03-01 08:36:49', '', 'user', 'B2L03Q', NULL, 'verified', '1'),
(208, '9061931139', 'ADITHYA ASHOKAN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ASS9X6', NULL, 'verified', '1'),
(209, '9495046939', 'ANN RENJU REGI', ' ', '', '2025-03-01 08:36:49', '', 'user', 'MHK92F', NULL, 'verified', '1'),
(210, '7034238891', 'SIMI THOMSON', ' ', '', '2025-03-01 08:36:49', '', 'user', '4K4RVX', NULL, 'verified', '1'),
(211, '9539733393', 'RAMESH BABU C B', ' ', '', '2025-03-01 08:36:49', '', 'user', 'JO145O', NULL, 'verified', '1'),
(212, '9778206968', 'NISHA T U', ' ', '', '2025-03-01 08:36:49', '', 'user', 'T43GR0', NULL, 'verified', '1'),
(213, '9497064636', 'SHAJI K J', ' ', '', '2025-03-01 08:36:49', '', 'user', 'FEBLL5', NULL, 'verified', '1'),
(214, '7034781984', 'ZEENATH C S', ' ', '', '2025-03-01 08:36:49', '', 'user', 'TASHJZ', NULL, 'verified', '1'),
(215, '8888956066', 'SHITHA', ' ', '', '2025-03-01 08:36:49', '', 'user', 'EO6O6X', NULL, 'verified', '1'),
(216, '8848816136', 'THARUN ABRAHAM', ' ', '', '2025-03-01 08:36:49', '', 'user', 'NNEHSW', NULL, 'verified', '1'),
(217, '9746264288', 'BINDU BHASI', ' ', '', '2025-03-01 08:36:49', '', 'user', '89USSE', NULL, 'verified', '1'),
(218, '9895027077', 'DEEPA SAMTHEJ(8484)', ' ', '', '2025-03-01 08:36:49', '', 'user', '50YY2F', NULL, 'verified', '1'),
(219, '9633461611', 'NITHEESH T R', ' ', '', '2025-03-01 08:36:49', '', 'user', 'V9NY8A', NULL, 'verified', '1'),
(220, '9847676158', 'BAIJU A R', ' ', '', '2025-03-01 08:36:49', '', 'user', '2PB1LP', NULL, 'verified', '1'),
(221, '9020143344', 'SREELAKSHMI', ' ', '', '2025-03-01 08:36:49', '', 'user', '5RC5Z9', NULL, 'verified', '1'),
(222, '9656884579', 'ASHRAF C P (8295)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'JHCX4P', NULL, 'verified', '1'),
(223, '9745617226', 'ANJALI KISHORE', ' ', '', '2025-03-01 08:36:49', '', 'user', '4AI2FX', NULL, 'verified', '1'),
(224, '9446620134', 'DHANYA RAJEEV', ' ', '', '2025-03-01 08:36:49', '', 'user', 'G5BLGM', NULL, 'verified', '1'),
(225, '9142582066', 'JOSE', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XF1N25', NULL, 'verified', '1'),
(226, '9447324163', 'TESSY THOMAS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'QOKP9N', NULL, 'verified', '1'),
(227, '9495941502', 'SUDHAKARAN S', ' ', '', '2025-03-01 08:36:49', '', 'user', 'I9X26N', NULL, 'verified', '1'),
(228, '8592065731', 'LEELA', ' ', '', '2025-03-01 08:36:49', '', 'user', 'U5S5ZS', NULL, 'verified', '1'),
(229, '9037745979', 'ASMABHI P (8293)', ' ', '', '2025-03-01 08:36:49', '', 'user', '3AOIUD', NULL, 'verified', '1'),
(230, '8921830662', 'NOUSHAD T S(8294)', ' ', '', '2025-03-01 08:36:49', '', 'user', '77K2IA', NULL, 'verified', '1'),
(231, '9744976444', 'SANDHYA', ' ', '', '2025-03-01 08:36:49', '', 'user', 'UGQVUH', NULL, 'verified', '1'),
(232, '9895636751', 'GRACE A THACHIL', ' ', '', '2025-03-01 08:36:49', '', 'user', '446IH7', NULL, 'verified', '1'),
(233, '9846822057', 'REDSON P S', ' ', '', '2025-03-01 08:36:49', '', 'user', '6YAP85', NULL, 'verified', '1'),
(234, '9148232984', 'EVLIN THOMAS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ES4GNU', NULL, 'verified', '1'),
(235, '9895751157', 'JOSE DAVIS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'VOLPXM', NULL, 'verified', '1'),
(236, '9495109437', 'BABITHA R', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XHJT7B', NULL, 'verified', '1'),
(237, '9400522886', 'DR NIZAB P P', ' ', '', '2025-03-01 08:36:49', '', 'user', '1BOMA8', NULL, 'verified', '1'),
(238, '9745810285', 'NINU JOSEPH', ' ', '', '2025-03-01 08:36:49', '', 'user', 'JLML1T', NULL, 'verified', '1'),
(239, '7356182732', 'RENJITHA C R (12740)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'D3I8PU', NULL, 'verified', '1'),
(240, '9895945295', 'JAYA SASI', ' ', '', '2025-03-01 08:36:49', '', 'user', 'T2BJLS', NULL, 'verified', '1'),
(241, '8129646165', 'ANUSREE R NAIR(8508)', ' ', '', '2025-03-01 08:36:49', '', 'user', '2JK6DU', NULL, 'verified', '1'),
(242, '9497721851', 'SHIJI BAIJU(13223)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ZFYEKV', NULL, 'verified', '1'),
(243, '9778244873', 'ARSHITHA V R', ' ', '', '2025-03-01 08:36:49', '', 'user', 'YZ374T', NULL, 'verified', '1'),
(244, '9961996414', 'SHYBIN BABY', ' ', '', '2025-03-01 08:36:49', '', 'user', 'AK9ZRS', NULL, 'verified', '1'),
(245, '8129394506', 'ARUN SHANKAR A', ' ', '', '2025-03-01 08:36:49', '', 'user', '1SN0QX', NULL, 'verified', '1'),
(246, '9946065500', 'THANUJA GEORGE', ' ', '', '2025-03-01 08:36:49', '', 'user', '5XBGFR', NULL, 'verified', '1'),
(247, '9947985151', 'JESSY CIJO', ' ', '', '2025-03-01 08:36:49', '', 'user', 'OS7G8E', NULL, 'verified', '1'),
(248, '8943730903', 'AYANA BABYCHAN', ' ', '', '2025-03-01 08:36:49', '', 'user', '21TH0U', NULL, 'verified', '1'),
(249, '8111853983', 'SHEEBA K K', ' ', '', '2025-03-01 08:36:49', '', 'user', '8JCTRQ', NULL, 'verified', '1'),
(250, '8891766240', 'VINEESH', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XKJ8L1', NULL, 'verified', '1'),
(251, '9495319973', 'STELLA VASUDEVAN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'NGONQ5', NULL, 'verified', '1'),
(252, '8893903040', 'ALEENA ELIZABETH C B', ' ', '', '2025-03-01 08:36:49', '', 'user', '4US4XJ', NULL, 'verified', '1'),
(253, '9895566502', 'MADHU V K', ' ', '', '2025-03-01 08:36:49', '', 'user', 'B7VO6P', NULL, 'verified', '1'),
(254, '9744636035', 'NISHAD K G', ' ', '', '2025-03-01 08:36:49', '', 'user', 'EST88V', NULL, 'verified', '1'),
(255, '7306594196', 'PRANAV CHANDRAN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'Q0OX77', NULL, 'verified', '1'),
(256, '9846806488', 'STELLA JIMMY', ' ', '', '2025-03-01 08:36:49', '', 'user', 'CXIHJP', NULL, 'verified', '1'),
(257, '9544395782', 'BINDHU M R', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ML0YW0', NULL, 'verified', '1'),
(258, '8606486237', 'DEEPA V V', ' ', '', '2025-03-01 08:36:49', '', 'user', 'HQPKG3', NULL, 'verified', '1'),
(259, '8943134243', 'NIJI SAJEEB (7006)', ' ', '', '2025-03-01 08:36:49', '', 'user', '0WS02C', NULL, 'verified', '1'),
(260, '9947817078', 'ISHAAN VIJESH (7047)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'QNBUHK', NULL, 'verified', '1'),
(261, '9778252270', 'SHARON BABU (7459)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'PIMN2K', NULL, 'verified', '1'),
(262, '8157071281', 'JITTO FRANCIS (8116)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'R9WZNB', NULL, 'verified', '1'),
(263, '7306594196', 'RESHMA CHANDRAN (12505)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'BAK8QT', NULL, 'verified', '1'),
(264, '9744864742', 'NIDHIN P P', ' ', '', '2025-03-01 08:36:49', '', 'user', 'M9LFF0', NULL, 'verified', '1'),
(265, '9447963494', 'SHINY THOMAS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'PF56DB', NULL, 'verified', '1'),
(266, '7907634810', 'GREESHMA ACCA THOMAS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'I9H568', NULL, 'verified', '1'),
(267, '9895742056', 'VIJAYALAKSHMI (7210)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ZF20BO', NULL, 'verified', '1'),
(268, '9845755785', 'ASWATHI VIPIN (7783)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'A6AX2S', NULL, 'verified', '1'),
(269, '8139869342', 'AKHIL B (7876)', ' ', '', '2025-03-01 08:36:49', '', 'user', '6JFBIH', NULL, 'verified', '1'),
(270, '9645454987', 'MUJEEB RAHMAN (12367)', ' ', '', '2025-03-01 08:36:49', '', 'user', '7ZFBWG', NULL, 'verified', '1'),
(271, '8113981074', 'VISMAYA N M (12604)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'PVUA6N', NULL, 'verified', '1'),
(272, '9633553434', 'SANAL T S', ' ', '', '2025-03-01 08:36:49', '', 'user', 'KV45OW', NULL, 'verified', '1'),
(273, '9920269826', 'BIPIN PUTHUR', ' ', '', '2025-03-01 08:36:49', '', 'user', '09FLBV', NULL, 'verified', '1'),
(274, '9048447944', 'SHAHINA NOUSHAD', ' ', '', '2025-03-01 08:36:49', '', 'user', 'OZCFMR', NULL, 'verified', '1'),
(275, '9744955573', 'HENA CHANDRAN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'SCTWFV', NULL, 'verified', '1'),
(276, '9946271320', 'PRINCY FRANCIS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'CIJD0F', NULL, 'verified', '1'),
(277, '9446289159', 'SHYNI DENNIS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'KN6RYX', NULL, 'verified', '1'),
(278, '9446489660', 'JINI P J', ' ', '', '2025-03-01 08:36:49', '', 'user', 'U75RZ7', NULL, 'verified', '1'),
(279, '8848066914', 'RESHMI M', ' ', '', '2025-03-01 08:36:49', '', 'user', 'G6D7O7', NULL, 'verified', '1'),
(280, '8281254058', 'BINDU V S', ' ', '', '2025-03-01 08:36:49', '', 'user', 'LBNQ5X', NULL, 'verified', '1'),
(281, '9072445531', 'DEEPA V S', ' ', '', '2025-03-01 08:36:49', '', 'user', '5S03AD', NULL, 'verified', '1'),
(282, '949735165', 'DONNA JOSE VADAKKEN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'J3CYHD', NULL, 'verified', '1'),
(283, '0', 'MANJU K HOME NEW CHITTY', ' ', '', '2025-03-01 08:36:49', '', 'user', '65COCY', NULL, 'verified', '1'),
(284, '8547615151', 'DR THOMAS VADAKKEN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'A2P7NB', NULL, 'verified', '1'),
(285, '9633202372', 'SAMILY MARIYA E V', ' ', '', '2025-03-01 08:36:49', '', 'user', '5XODX6', NULL, 'verified', '1'),
(286, '9747699564', 'JUNIYA ANN BENJAMIN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'VUFPYK', NULL, 'verified', '1'),
(287, '0', 'MANJU K (HOME) (8216)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'GSQ8P6', NULL, 'verified', '1'),
(288, '9449585459', 'HAMSA VENI R (7050)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'WPXE1N', NULL, 'verified', '1'),
(289, '9539526406', 'SHEEJA PREMJITH(11378)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'PFDTLX', NULL, 'verified', '1'),
(290, '9174366629', 'SHIPPU LENIN(7760)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'PQDSZ2', NULL, 'verified', '1'),
(291, '9497083418', 'DR FEBY T FRANCIS', ' ', '', '2025-03-01 08:36:49', '', 'user', 'YJSOVG', NULL, 'verified', '1'),
(292, '9633675759', 'ABU THAHIR A S', ' ', '', '2025-03-01 08:36:49', '', 'user', 'MPJ1J8', NULL, 'verified', '1'),
(293, '9645603985', 'SWAPNA C P(7004)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'LCV39J', NULL, 'verified', '1'),
(294, '7994351642', 'BHADRA BHARATH (7373)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XBXNGQ', NULL, 'verified', '1'),
(295, '9535299508', 'TIYA VARGHESE (7851)', ' ', '', '2025-03-01 08:36:49', '', 'user', '1YSQI9', NULL, 'verified', '1'),
(296, '9961565124', 'VIJEESH B', ' ', '', '2025-03-01 08:36:49', '', 'user', '4OLGTB', NULL, 'verified', '1'),
(297, '8891000658', 'MAYAKUTTY JOHN (7879)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XF4G2B', NULL, 'verified', '1'),
(298, '8281503329', 'SUBAIR (7920)', ' ', '', '2025-03-01 08:36:49', '', 'user', '1BT91N', NULL, 'verified', '1'),
(299, '9947522210', 'NASEERA KABEER (12075)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'RWMTUF', NULL, 'verified', '1'),
(300, '9+744702052', 'MUSAIBA MUSTHAFA (12366)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ZFCV37', NULL, 'verified', '1'),
(301, '9947100973', 'ANNIE MOL A', ' ', '', '2025-03-01 08:36:49', '', 'user', '4RRLS4', NULL, 'verified', '1'),
(302, '9496257371', 'RAJESH B.R.(7005)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'JR0N1N', NULL, 'verified', '1'),
(303, '7907602589', 'LISSY M A (7460)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'P01JZ0', NULL, 'verified', '1'),
(304, '9544324628', 'KRISHNENDU(7475)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'RO66Q2', NULL, 'verified', '1'),
(305, '8943386682', 'SANDRA MOHANDAS(7612)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'H2OK7E', NULL, 'verified', '1'),
(306, '8139810959', 'JESMIN JOY(7626)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'V70NR2', NULL, 'verified', '1'),
(307, '8129228873', 'SYAM KRISHNA V R', ' ', '', '2025-03-01 08:36:49', '', 'user', 'BEDAYB', NULL, 'verified', '1'),
(308, '9448504298', 'NARENDRAN M K', ' ', '', '2025-03-01 08:36:49', '', 'user', 'POQRJW', NULL, 'verified', '1'),
(309, '8714493532', 'GEENUS SHIBU', ' ', '', '2025-03-01 08:36:49', '', 'user', 'QO20WM', NULL, 'verified', '1'),
(310, '9995470183', 'SHUMAISA (7697)', ' ', '', '2025-03-01 08:36:49', '', 'user', '3DOQZI', NULL, 'verified', '1'),
(311, '8.92E+11', 'SHINY', ' ', '', '2025-03-01 08:36:49', '', 'user', '5I0B77', NULL, 'verified', '1'),
(312, '9745841234', 'MUMDAS THAHA', ' ', '', '2025-03-01 08:36:49', '', 'user', 'J5R0N5', NULL, 'verified', '1'),
(313, '9745711234', 'BALKEES SAHABUDHEEN', ' ', '', '2025-03-01 08:36:49', '', 'user', '1IE79R', NULL, 'verified', '1'),
(314, ' ', 'JAISON K A', ' ', '', '2025-03-01 08:36:49', '', 'user', 'K27JS0', NULL, 'verified', '1'),
(315, '9496752042', 'ASWATHY', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XB4Z3L', NULL, 'verified', '1'),
(316, '9745078299', 'RAJINI A N (12793)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'P2SHDL', NULL, 'verified', '1'),
(317, '7510303576', 'SHIBY DIRAR(8304)', ' ', '', '2025-03-01 08:36:49', '', 'user', '47QDO5', NULL, 'verified', '1'),
(318, '9539029309', 'ROSILY KURIAN', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ABH7YF', NULL, 'verified', '1'),
(319, '9633845998', 'SISIRA BABU', ' ', '', '2025-03-01 08:36:49', '', 'user', 'CA6I5K', NULL, 'verified', '1'),
(320, '9995555084', 'LIVIN KUMAR (7842)', ' ', '', '2025-03-01 08:36:49', '', 'user', '1P0SN5', NULL, 'verified', '1'),
(321, '7593958472', 'KRISHNA KRIPA', ' ', '', '2025-03-01 08:36:49', '', 'user', '9UISSI', NULL, 'verified', '1'),
(322, '9544136579', 'JISHA B', ' ', '', '2025-03-01 08:36:49', '', 'user', '7SL749', NULL, 'verified', '1'),
(323, '9947154464', 'VINITHA CHERIYAN', ' ', '', '2025-03-01 08:36:49', '', 'user', '03UGAQ', NULL, 'verified', '1'),
(324, '9447465319', 'HITHESH SANKAR (6704)', ' ', '', '2025-03-01 08:36:49', '', 'user', '0ZDVLY', NULL, 'verified', '1'),
(325, '9605334215', 'SREERAG C S (7048)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'DUWKBP', NULL, 'verified', '1'),
(326, '8590358603', 'NEETHU JOSE (7437)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XGLRO1', NULL, 'verified', '1'),
(327, '0', 'MOHAMMED RAFEEK (7176)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ZCS038', NULL, 'verified', '1'),
(328, '8075286957', 'SWAPNA P.S.(7964)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'D1UU01', NULL, 'verified', '1'),
(329, '9747383966', 'ROBY E G', ' ', '', '2025-03-01 08:36:49', '', 'user', '6GYB6W', NULL, 'verified', '1'),
(330, ' ', 'SANTHA V K', ' ', '', '2025-03-01 08:36:49', '', 'user', 'VXCYGR', NULL, 'verified', '1'),
(331, '8156812116', 'SHIFAS A B', ' ', '', '2025-03-01 08:36:49', '', 'user', 'IKOZLB', NULL, 'verified', '1'),
(332, '8095062864', 'DEEPA DIAS', ' ', '', '2025-03-01 08:36:49', '', 'user', '8M9GB3', NULL, 'verified', '1'),
(333, '9611769307', 'VIJESWARY NAMBIAR', ' ', '', '2025-03-01 08:36:49', '', 'user', '588QQ5', NULL, 'verified', '1'),
(334, '9526614304', 'STEPHY MATHEW', ' ', '', '2025-03-01 08:36:49', '', 'user', 'G6R3GQ', NULL, 'verified', '1'),
(335, '8606222394', 'JESEENA ALTHAF (11773)', ' ', '', '2025-03-01 08:36:49', '', 'user', '5VDW0T', NULL, 'verified', '1'),
(336, '9562938470', 'SMITHA UNNIKRISHNAN (7843)', ' ', '', '2025-03-01 08:36:49', '', 'user', '962OHH', NULL, 'verified', '1'),
(337, '9846200428', 'PRAVITHA (12384)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'HZ7KEO', NULL, 'verified', '1'),
(338, '8590572510', 'ARYA MOHAN', ' ', '', '2025-03-01 08:36:49', '', 'user', '4OZDG3', NULL, 'verified', '1'),
(339, '9388611811', 'RADHAKRISHNAN K', ' ', '', '2025-03-01 08:36:49', '', 'user', 'BMDK0H', NULL, 'verified', '1'),
(340, '9847395565', 'VINEESH', ' ', '', '2025-03-01 08:36:49', '', 'user', 'XW39YV', NULL, 'verified', '1'),
(341, '7907194626', 'VARGHESE ANTONY', ' ', '', '2025-03-01 08:36:49', '', 'user', 'Z6EITR', NULL, 'verified', '1'),
(342, '9544339025', 'ANCY ROBERT', ' ', '', '2025-03-01 08:36:49', '', 'user', 'Y0Y0MS', NULL, 'verified', '1'),
(343, '9847496805', 'SUDHEER A (8231)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'NXGWQI', NULL, 'verified', '1'),
(344, '9746477520', 'PARAYIL RONIMA VIJAYAN (6543)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'YBXSYA', NULL, 'verified', '1'),
(345, '9961750785', 'LINET JOSHY', ' ', '', '2025-03-01 08:36:49', '', 'user', 'NUZSGL', NULL, 'verified', '1'),
(346, '9995608095', 'DIANA P S', ' ', '', '2025-03-01 08:36:49', '', 'user', 'F5EII9', NULL, 'verified', '1'),
(347, '8138875748', 'DR PIA JOSEPH', ' ', '', '2025-03-01 08:36:49', '', 'user', 'YIIUM3', NULL, 'verified', '1'),
(348, '9400322046', 'MERIN BABU(7008)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'X1IKLY', NULL, 'verified', '1'),
(349, '9047098816', 'BINDU C V', ' ', '', '2025-03-01 08:36:49', '', 'user', 'IN3M5W', NULL, 'verified', '1'),
(350, '9744856575', 'RAJANI SURESH', ' ', '', '2025-03-01 08:36:49', '', 'user', 'R08RIG', NULL, 'verified', '1'),
(351, '9656634781', 'LEENA ANTO', ' ', '', '2025-03-01 08:36:49', '', 'user', 'FS2B7E', NULL, 'verified', '1'),
(352, '0', 'DEVID KUJUR (8255)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'T69BXX', NULL, 'verified', '1'),
(353, '9562587676', 'VISHNU PRASAD M R (7156)', ' ', '', '2025-03-01 08:36:49', '', 'user', '70VUUO', NULL, 'verified', '1'),
(354, ' ', 'MAMTA SETHI (10209)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'CSTAXU', NULL, 'verified', '1'),
(355, '9544695920', 'VALSALA SIVAN(8540)', ' ', '', '2025-03-01 08:36:49', '', 'user', '256WH9', NULL, 'verified', '1'),
(356, '9544342261', 'SALMA A H (8543)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'EU34G0', NULL, 'verified', '1'),
(357, '9846995997', 'SURESH KUMAR', ' ', '', '2025-03-01 08:36:49', '', 'user', 'C7CQG0', NULL, 'verified', '1'),
(358, '9747921067', 'SONIYA KOMBAN JOPHY', ' ', '', '2025-03-01 08:36:49', '', 'user', '3SQTIQ', NULL, 'verified', '1'),
(359, '8330073627', 'DR TINTU JAMES', ' ', '', '2025-03-01 08:36:49', '', 'user', '28I20K', NULL, 'verified', '1'),
(360, '9544581210', 'KRISHNANJU SUMESH', ' ', '', '2025-03-01 08:36:49', '', 'user', 'FNMSWZ', NULL, 'verified', '1'),
(361, '9380333854', 'NANCY GLORIA', ' ', '', '2025-03-01 08:36:49', '', 'user', 'V9ZC0M', NULL, 'verified', '1'),
(362, '0', 'ATHIRA LAKSHMI (6628)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'UJ5FJR', NULL, 'verified', '1'),
(363, '9497655107', 'JIJI RAJ (7323)', ' ', '', '2025-03-01 08:36:49', '', 'user', 'BJ0ZHN', NULL, 'verified', '1'),
(364, '9847650379', 'RAJITHA P G (7841)', ' ', '', '2025-03-01 08:36:49', '', 'user', '713DUS', NULL, 'verified', '1'),
(365, '9447183241', 'ASHAMOL C', ' ', '', '2025-03-01 08:36:49', '', 'user', 'V6QOEW', NULL, 'verified', '1'),
(366, '9995077792', 'SHAJAN JOSEPH THOMAS', ' ', '', '2025-03-01 08:36:49', '', 'user', '9NPBR7', NULL, 'verified', '1'),
(367, '7012378564', 'SWETHA E P', ' ', '', '2025-03-01 08:36:49', '', 'user', 'TAYOF0', NULL, 'verified', '1'),
(368, '8606269721', 'REO K A', ' ', '', '2025-03-01 08:36:49', '', 'user', 'ALS04I', NULL, 'verified', '1'),
(369, '9447553382', 'DR SUJITHRA S G', ' ', '', '2025-03-01 08:36:49', '', 'user', '0B5I6E', NULL, 'verified', '1'),
(370, '8589993311', 'SOPHIYA PAUL', ' ', '', '2025-03-01 08:36:49', '', 'user', '1XFNRO', NULL, 'verified', '1'),
(371, '9446161000', 'DR SMITHA AJITH', ' ', '', '2025-03-01 08:36:49', '', 'user', '6DNIYR', NULL, 'verified', '1'),
(372, '7092526249', 'ANJALY K C', ' ', '', '2025-03-01 08:36:49', '', 'user', 'Q6XC67', NULL, 'verified', '1'),
(373, '9495612928', 'ANAICE CATHERINE', ' ', '', '2025-03-01 08:36:49', '', 'user', 'WT1Y39', NULL, 'verified', '1'),
(374, '9789330082', 'KALICHARAN Ramachandran', 'k9789330082@gmail.com', '$2b$10$bg2c6qzSHbZti8wE9UKJFu9qojmQQh8pXK5D/4Zf8bkWfguUYzVse', '2025-03-01 12:19:55', '', 'user', '7QKX0A', NULL, 'pending', '1'),
(375, '6369089584', 'Kumar', 'a.prashanna1996@gmail.com', '$2b$10$eJOeAHEm38s3iBlmX8foteQdbnptmVmOBl/9YV2lgQ1huxTclpr6S', '2025-03-03 11:36:22', '', 'user', '9PYBYT', NULL, 'pending', '1'),
(377, '6385333161', 'Krishna Moorthy', 'krishna280399@gmail.com', '$2b$10$9iV/6FxhuKHP/WeTc.ckruyJRaBGulRIbB6Krkw13Vp7FwM3BV8.C', '2025-03-06 12:44:22', '', 'user', '84WBYV', NULL, 'pending', '1'),
(379, '9788033234', 'Mohandass', 'mohandass@gmail.com', '$2b$10$nWr0K9wloFKTp..0IHdppe8OUrU9NTZZyonZbYYADyP725UpOuwX.', '2025-03-06 18:19:26', '', 'user', 'K0FF89', NULL, 'pending', '1'),
(381, '6381279295', 'Mohan', 'mohan@gmail.com', '$2b$10$QgY2qJKIbBSmqj656ptJ2u0ylu/r8lvK77oiYCeWiDycFWF61Ypka', '2025-03-18 20:23:12', '', 'user', 'EGF4RH', NULL, 'pending', '1'),
(382, '9976157984', 'Suresh', 'sureshthirukkural@gmail.com', '$2b$10$d7i.Eh8ZwTR/TvhucBBpA.aqHH9v04.OjE/9m6RMUfPlZ9YitWmEm', '2025-03-19 10:05:45', '', 'user', 'QP6TB4', NULL, 'pending', '1'),
(383, '9715736596', 'Keerthanan', 'keeri@gmail.com', '$2b$10$Fby.ILYS3FeDrPpfackiPu33blwRCEBNlYOVPsDE7mNkrM7gG7bwG', '2025-03-19 10:09:50', '', 'user', 'N7P537', NULL, 'pending', '1'),
(384, '8072993596', 'Dinagaran', 'dhinakaran4267@gmail.com', '$2b$10$qmlh3jf7Gm/2u4MO7eb8Ge.FAF4rntkNzPzjI4Ah6Z/I/RDSAREzy', '2025-03-19 11:30:08', '', 'user', 'ZAH0RA', NULL, 'pending', '1'),
(385, '6374646530', 'R.Madhan Kumar', 'kumarmadhan4418@gmail.com', '$2b$10$SbRhmN8pYgEb0QYFZCNAfe8pw3muSN1NFQbGsO38bPn30h8Y6N53a', '2025-03-19 11:32:41', '', 'user', 'TQIY2N', NULL, 'pending', '1'),
(386, '9025901345', 'Niithya', 'nithya7262@gmail.com', '$2b$10$PjvGu3vHgvRufBpCzjKxFee0V5e4UorUFuPRoO6sNQpPC5nbdAvO2', '2025-03-21 10:29:01', '', 'user', '8O6RRF', NULL, 'pending', '1'),
(387, '9486979231', 'Saran Santhanu', 'saran1310@gmail.com', '$2b$10$1G0Rzbusae9YijAcJljzU.KYUxxnsNSf9m0B6AZz7.iTXdirM5ixC', '2025-03-22 14:14:09', '', 'user', 'RWKWLE', NULL, 'pending', '1'),
(388, '9840319606', 'Sudhakar', 'mailsudhakarg@gmail.com', '$2b$10$XJafCGUm10iozE4PxW7RWu2lh8ijmsqTeGzMXURoSI2a8DpI0nyQy', '2025-03-24 14:02:14', '', 'user', '2IYN2F', NULL, 'pending', '1'),
(389, '9080862495', 'Saran Santhanu', 'saran1310@gmail.com', '$2b$10$6Ydz7MAAefutcy9y8n1IVuVBxOxCcMLwHshmBmU6EsWLDWOoVHxSK', '2025-04-03 04:21:18', '', NULL, 'TVAOE9', NULL, 'pending', '1'),
(390, '7045719909', 'Seetharaman', 'seetharamanavenues@gmail.com', '$2b$10$WLzf/KrLGevwtxUAm8ucUOs9Y/GX1X6u0ePo4Z5cjxvwiKbzpFoTa', '2025-04-04 04:42:53', '', NULL, 'GNOW32', NULL, 'pending', '1'),
(391, '8655907044', 'Test', 'hdfc_team4@qseap.com', '$2b$10$No/Ua.lHHTW6uZKw.i4L5e4rGTrDH1hiXAK41si.Kwh.v3JTHeluC', '2025-04-09 11:10:44', '', 'user', 'PD91I0', NULL, 'pending', '1'),
(392, '9115161011', 'Test Cyraacs', 'cyraacs5@gmail.com', '$2b$10$FsfAk7qjx3zEzGZl0sfWQOf9Gl40W3ipDbpdLhA17yuMAfI6NLO2C', '2025-04-10 10:38:12', '', NULL, '4D27FF', NULL, 'pending', '1');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_tokens`
--

CREATE TABLE `user_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `refresh_token` text NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `video_url` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`id`, `title`, `subtitle`, `video_url`, `status`, `created_at`, `updated_at`) VALUES
(1, 'promo video', 'This is a sample video', 'https://youtu.be/8RAhdn5b9Bw', 'active', '2025-02-25 12:39:37', '2025-03-12 15:55:06'),
(2, 'Sample Video', 'This is a sample video', 'https://youtu.be/8RAhdn5b9Bw', 'inactive', '2025-02-25 12:39:41', '2025-03-08 09:44:52'),
(3, 'video', 'video', 'video', 'inactive', '2025-02-27 19:37:32', '2025-02-27 19:37:41'),
(4, 'Add for video link new', 'Add for video link new subtitle ', 'https://www.youtube.com/watch?v=OQ4mbwPXiQc', 'inactive', '2025-03-08 09:44:52', '2025-03-12 15:55:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminuser`
--
ALTER TABLE `adminuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`),
  ADD UNIQUE KEY `empid` (`empid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_adminuser_role` (`role_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branchid` (`branchid`);

--
-- Indexes for table `chits`
--
ALTER TABLE `chits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `SCHEMEID` (`SchemeId`);

--
-- Indexes for table `investments`
--
ALTER TABLE `investments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `previousInvestmentId` (`previousInvestmentId`);

--
-- Indexes for table `kyc`
--
ALTER TABLE `kyc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `otp_verification`
--
ALTER TABLE `otp_verification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`) KEY_BLOCK_SIZE=1024;

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_name` (`permission_name`);

--
-- Indexes for table `policies`
--
ALTER TABLE `policies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rates`
--
ALTER TABLE `rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `schemes`
--
ALTER TABLE `schemes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schemesKnowmore`
--
ALTER TABLE `schemesKnowmore`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `investmentId` (`investmentId`),
  ADD KEY `schemeId` (`schemeId`),
  ADD KEY `chitId` (`chitId`),
  ADD KEY `paymentStatus` (`paymentStatus`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_referCode` (`referral_code`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminuser`
--
ALTER TABLE `adminuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `chits`
--
ALTER TABLE `chits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `investments`
--
ALTER TABLE `investments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=286;

--
-- AUTO_INCREMENT for table `kyc`
--
ALTER TABLE `kyc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `otp_verification`
--
ALTER TABLE `otp_verification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=552;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `policies`
--
ALTER TABLE `policies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rates`
--
ALTER TABLE `rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `schemes`
--
ALTER TABLE `schemes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `schemesKnowmore`
--
ALTER TABLE `schemesKnowmore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=393;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `investments`
--
ALTER TABLE `investments`
  ADD CONSTRAINT `investments_ibfk_1` FOREIGN KEY (`previousInvestmentId`) REFERENCES `investments` (`id`);

--
-- Constraints for table `kyc`
--
ALTER TABLE `kyc`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
