-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2026 at 03:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_credit_risk`
--

-- --------------------------------------------------------

--
-- Table structure for table `credit_risk`
--

CREATE TABLE `credit_risk` (
  `loan_id` int(11) NOT NULL,
  `person_age` int(11) NOT NULL,
  `person_income` int(11) NOT NULL,
  `person_home_ownership` varchar(15) NOT NULL,
  `person_emp_length` decimal(5,2) NOT NULL,
  `loan_intent` varchar(25) NOT NULL,
  `loan_grade` char(1) NOT NULL,
  `loan_amnt` int(11) NOT NULL,
  `loan_int_rate` decimal(5,2) NOT NULL,
  `loan_status` tinyint(1) NOT NULL,
  `loan_percent_income` decimal(5,2) NOT NULL,
  `cb_person_default_on_file` char(1) NOT NULL,
  `cb_person_cred_hist_length` int(11) NOT NULL,
  `age_group` varchar(25) NOT NULL,
  `income_tier` varchar(30) NOT NULL,
  `dti_category` varchar(30) NOT NULL,
  `loan_status_label` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_risk_by_grade`
-- (See below for the actual view)
--
CREATE TABLE `v_risk_by_grade` (
`loan_grade` char(1)
,`total_loans` bigint(21)
,`total_loan_amount` decimal(32,0)
,`avg_interest_rate` decimal(6,2)
,`total_defaults` decimal(25,0)
,`default_rate_pct` decimal(9,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_risk_segmentation`
-- (See below for the actual view)
--
CREATE TABLE `v_risk_segmentation` (
`age_group` varchar(25)
,`income_tier` varchar(30)
,`dti_category` varchar(30)
,`loan_intent` varchar(25)
,`loan_status_label` varchar(25)
,`total_loans` bigint(21)
,`total_loan_amount` decimal(32,0)
,`avg_interest_rate` decimal(6,2)
);

-- --------------------------------------------------------

--
-- Structure for view `v_risk_by_grade`
--
DROP TABLE IF EXISTS `v_risk_by_grade`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_risk_by_grade`  AS SELECT `credit_risk`.`loan_grade` AS `loan_grade`, count(0) AS `total_loans`, sum(`credit_risk`.`loan_amnt`) AS `total_loan_amount`, round(avg(`credit_risk`.`loan_int_rate`),2) AS `avg_interest_rate`, sum(`credit_risk`.`loan_status`) AS `total_defaults`, round(avg(`credit_risk`.`loan_status`) * 100,2) AS `default_rate_pct` FROM `credit_risk` GROUP BY `credit_risk`.`loan_grade` ;

-- --------------------------------------------------------

--
-- Structure for view `v_risk_segmentation`
--
DROP TABLE IF EXISTS `v_risk_segmentation`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_risk_segmentation`  AS SELECT `credit_risk`.`age_group` AS `age_group`, `credit_risk`.`income_tier` AS `income_tier`, `credit_risk`.`dti_category` AS `dti_category`, `credit_risk`.`loan_intent` AS `loan_intent`, `credit_risk`.`loan_status_label` AS `loan_status_label`, count(0) AS `total_loans`, sum(`credit_risk`.`loan_amnt`) AS `total_loan_amount`, round(avg(`credit_risk`.`loan_int_rate`),2) AS `avg_interest_rate` FROM `credit_risk` GROUP BY `credit_risk`.`age_group`, `credit_risk`.`income_tier`, `credit_risk`.`dti_category`, `credit_risk`.`loan_intent`, `credit_risk`.`loan_status_label` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `credit_risk`
--
ALTER TABLE `credit_risk`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `idx_grade` (`loan_grade`),
  ADD KEY `idx_dti` (`dti_category`),
  ADD KEY `idx_intent` (`loan_intent`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `credit_risk`
--
ALTER TABLE `credit_risk`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
